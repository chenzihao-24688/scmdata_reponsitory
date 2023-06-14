CREATE OR REPLACE PACKAGE scmdata.pkg_db_job IS

  -- Author  : CZH
  -- Created : 2021/9/2 11:43:38
  -- Purpose : 统一管理业务报表的定时任务（数据库）

  --订单数据表
  --次月1~5号,返回上个月份
  FUNCTION f_get_month(p_begin_date DATE) RETURN VARCHAR2;
  --通过分组获取区域组长
  FUNCTION f_get_area_leader_by_gpname(p_gp_name    VARCHAR2,
                                       p_company_id VARCHAR2) RETURN VARCHAR2;
  --获取区域组
  PROCEDURE p_get_groupname(p_gp_type      VARCHAR2,
                            p_category     VARCHAR2,
                            p_product_cate VARCHAR2,
                            p_sub_cate     VARCHAR2,
                            p_goo_id       VARCHAR2,
                            p_order_id     VARCHAR2,
                            p_company_id   VARCHAR2,
                            po_group_name  OUT VARCHAR2,
                            po_area_leader OUT VARCHAR2);
  --通过qc配置获取qc主管
  FUNCTION f_get_manager_byconfig(p_company_id VARCHAR2,
                                  p_user_id    VARCHAR2) RETURN VARCHAR2;
  --获取主管
  FUNCTION f_get_manager(p_company_id     VARCHAR2,
                         p_user_id        VARCHAR2,
                         p_company_job_id VARCHAR2) RETURN VARCHAR2;
  --merge_order
  PROCEDURE p_merge_order(p_company_id VARCHAR2,
                          p_begin_date DATE,
                          p_end_date   DATE);

  --3 更新回货计划表的数据 begin
  PROCEDURE p_merge_return_plan;
  --更新回货计划表的数据end
END pkg_db_job;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_db_job IS

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-10 14:01:03
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 次月1~5号,返回上个月份
  * Obj_Name    : F_GET_MONTH
  * Arg_Number  : 1
  * P_BEGIN_DATE :
  *============================================*/

  FUNCTION f_get_month(p_begin_date DATE) RETURN VARCHAR2 IS
    v_date VARCHAR2(10);
  BEGIN
    --1）当月月初至当月5号 同步上月订单
    v_date := CASE
                WHEN SYSDATE BETWEEN p_begin_date AND p_begin_date + 5 THEN
                 to_char(add_months(SYSDATE, -1), 'yyyy-mm')
                ELSE
                 ''
              END;
    RETURN v_date;
  END f_get_month;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-11 14:08:48
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 通过qc配置获取qc主管
  * Obj_Name    : F_GET_MANAGER_BYCONFIG
  * Arg_Number  : 2
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  * P_USER_ID : QC ID
  *============================================*/

  FUNCTION f_get_manager_byconfig(p_company_id VARCHAR2,
                                  p_user_id    VARCHAR2) RETURN VARCHAR2 IS
    v_company_dept_id VARCHAR2(2000);
    v_qc_manager      VARCHAR2(2000);
  BEGIN
    SELECT listagg(DISTINCT ib.company_dept_id, ',') company_dept_id
      INTO v_company_dept_id
      FROM scmdata.sys_company_user ia
      LEFT JOIN sys_company_user_dept ib
        ON ia.user_id = ib.user_id
       AND ia.company_id = ib.company_id
       AND instr(',' || p_user_id || ',', ',' || ia.user_id || ',') > 0
     WHERE ia.company_id = p_company_id;
  
    SELECT listagg(t.qc_group_leader, ',') qc_manager
      INTO v_qc_manager
      FROM scmdata.t_qc_group_config t
     WHERE t.pause = 1
       AND instr(v_company_dept_id, t.qc_group_dept_id) > 0
       AND t.company_id = p_company_id;
  
    RETURN v_qc_manager;
  END f_get_manager_byconfig;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-10 14:02:14
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  获取主管 
  *             只适用一员工  一岗位 的情形
  * Obj_Name    : F_GET_MANAGER
  * Arg_Number  : 3
  * P_COMPANY_ID : 企业ID
  * P_USER_ID : 跟单/QC ID
  * P_COMPANY_JOB_ID : 岗位ID
  *============================================*/

  FUNCTION f_get_manager(p_company_id     VARCHAR2,
                         p_user_id        VARCHAR2,
                         p_company_job_id VARCHAR2) RETURN VARCHAR2 IS
    v_manager VARCHAR2(256);
  BEGIN
    SELECT user_id
      INTO v_manager
      FROM (SELECT listagg(DISTINCT ic.user_id, ',') user_id
              FROM scmdata.sys_company_user ia
              LEFT JOIN sys_company_user_dept ib
                ON ia.user_id = ib.user_id
               AND ia.company_id = ib.company_id
               AND instr(',' || p_user_id || ',', ',' || ia.user_id || ',') > 0
              LEFT JOIN (SELECT ob.company_dept_id,
                               oa.company_id,
                               oa.user_id,
                               oa.company_user_name,
                               oc.company_job_id
                          FROM sys_company_user oa
                          LEFT JOIN sys_company_user_dept ob
                            ON oa.user_id = ob.user_id
                           AND oa.company_id = ob.company_id
                          LEFT JOIN scmdata.sys_company_job oc
                            ON oa.job_id = oc.job_id
                           AND oa.company_id = oc.company_id
                         WHERE oc.company_job_id = p_company_job_id --'1001005003005002'
                           AND oa.company_id = p_company_id) ic
                ON ib.company_dept_id = ic.company_dept_id
               AND ib.company_id = ic.company_id
             WHERE ia.company_id = p_company_id);
  
    RETURN v_manager;
  END f_get_manager;
  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-10 13:54:57
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 通过分组名称获取区域组长
  * Obj_Name    : F_GET_AREA_LEADER_BY_GPNAME
  * Arg_Number  : 2
  * P_GP_NAME : 分组名称
  * P_COMPANY_ID : 企业ID 
  *============================================*/

  FUNCTION f_get_area_leader_by_gpname(p_gp_name    VARCHAR2,
                                       p_company_id VARCHAR2) RETURN VARCHAR2 IS
    v_area_gdleader VARCHAR2(256);
  BEGIN
    SELECT MAX(t.area_group_leader)
      INTO v_area_gdleader
      FROM scmdata.t_supplier_group_config t
     WHERE t.group_name = p_gp_name
       AND t.company_id = p_company_id;
    RETURN v_area_gdleader;
  END f_get_area_leader_by_gpname;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-07 09:56:48
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  获取分组名称，区域组长
  *   1. 订单对应生产工厂名称为“现货供应商”、“义乌现货”的数据不划分区域组，因此分组名称、区域组长为空；
  *   2. 美妆、淘品（除满足1.条件的订单分组名称、区域组长为空，其他订单根据以下逻辑取数）
  *   1）订单分类-生产类别-产品子类为：淘品-生活日用-家居拖鞋 的订单，分组名称均为 温州，区域组长根据对应【分组配置-产业区域分组配置】获取；
  *   2）除满足（1）条件的订单，其他订单收货仓为：广州仓或电商仓，分组名称为 广州/汕头，区域组长根据对应【分组配置-产业区域分组配置】获取；
  *   3）除满足（1）条件的订单，其他订单收货仓为：义乌仓，分组名称为 东莞/义乌，区域组长根据对应【分组配置-产业区域分组配置】获取；
  *   3. 除美妆、淘品之外的其他分部订单（除满足1.条件的订单分组名称、区域组长为空，其他订单根据以下逻辑取数）
  *   其他订单根据对应的生产工厂所在区域+订单分类&生产类别&产品子类，对应【分组配置-区域配置、产业区域分组配置】获取分组名称、区域组长；
  * Obj_Name    : F_GET_GROUPNAME
  * Arg_Number  : 7
  * IN PARAMS：
  * P_GP_TYPE  : 分组类型
  * P_CATEGORY : 分部编码
  * P_PRODUCT_CATE ： 生产类别编码
  * P_SUB_CATE   ：子类编码
  * P_GOO_ID : 货号
  * P_ORDER_ID : 订单编号
  * P_COMPANY_ID : 企业ID
  * OUT PARAMS：
  * PO_GROUP_NAME : 区域名称
  * PO_AREA_LEADER : 区域组长
  *============================================*/
  PROCEDURE p_get_groupname(p_gp_type      VARCHAR2,
                            p_category     VARCHAR2,
                            p_product_cate VARCHAR2,
                            p_sub_cate     VARCHAR2,
                            p_goo_id       VARCHAR2,
                            p_order_id     VARCHAR2,
                            p_company_id   VARCHAR2,
                            po_group_name  OUT VARCHAR2,
                            po_area_leader OUT VARCHAR2) IS
    v_company_province VARCHAR2(256);
    v_company_city     VARCHAR2(256);
    v_sho_id           VARCHAR2(256);
    v_insup_code       VARCHAR2(256);
    v_area             CLOB;
    vo_group_name      VARCHAR2(2000);
    vo_area_leader     VARCHAR2(2000);
  BEGIN
    --获取订单的生产工厂，熊猫内部编码 省 市
    SELECT MAX(fc.supplier_code),
           MAX(fc.company_province),
           MAX(fc.company_city),
           MAX(a.sho_id)
      INTO v_insup_code, v_company_province, v_company_city, v_sho_id
      FROM scmdata.t_ordered a
     INNER JOIN scmdata.t_orders b
        ON b.order_id = a.order_code
       AND b.company_id = a.company_id
     INNER JOIN scmdata.t_production_progress t
        ON t.goo_id = b.goo_id
       AND t.order_id = b.order_id
       AND t.company_id = b.company_id
     INNER JOIN scmdata.t_supplier_info fc
        ON fc.supplier_code = t.factory_code
       AND fc.company_id = t.company_id
     WHERE t.goo_id = p_goo_id
       AND t.order_id = p_order_id
       AND t.company_id = p_company_id;
    --生产环境现货供应商，义乌现货供应商的熊猫编码 返回值为空
    IF v_insup_code IN ('C00216', 'C00563') THEN
      vo_group_name  := NULL;
      vo_area_leader := NULL;
      --美妆、淘品（除满足1.条件的订单分组名称、区域组长为空，其他订单根据以下逻辑取数）
      -- 1）订单分类-生产类别-产品子类为：淘品-生活日用-家居拖鞋,分部名称均为 温州，区域组长根据对应【分组配置-产业区域分组配置】获取  
    ELSE
      IF p_category IN ('06', '07') THEN
        IF p_category = '07' AND p_product_cate = '0706' AND
           p_sub_cate = '070602' THEN
          vo_group_name  := '温州';
          vo_area_leader := f_get_area_leader_by_gpname(p_gp_name    => vo_group_name,
                                                        p_company_id => p_company_id);
          --2）按订单收货仓获取
        ELSE
          IF v_sho_id = 'GZZ' OR v_sho_id = 'GDZ' THEN
            vo_group_name  := '广州/汕头';
            vo_area_leader := f_get_area_leader_by_gpname(p_gp_name    => vo_group_name,
                                                          p_company_id => p_company_id);
          ELSIF v_sho_id = 'YWZ' THEN
            vo_group_name  := '东莞/义乌';
            vo_area_leader := f_get_area_leader_by_gpname(p_gp_name    => vo_group_name,
                                                          p_company_id => p_company_id);
          ELSE
            NULL;
          END IF;
        END IF;
      ELSE
        --3）按订单根据对应的生产工厂所在区域+订单分类&生产类别&产品子类
        SELECT listagg(t.group_area_config_id, ';') within GROUP(ORDER BY t.pause)
          INTO v_area
          FROM scmdata.t_supplier_group_area_config t
         WHERE t.pause = 1
           AND t.group_type = p_gp_type
           AND instr(t.province_id, v_company_province) > 0
           AND instr(t.city_id, v_company_city) > 0
           AND t.company_id = p_company_id;
      
        SELECT MAX(t.group_name), MAX(t.area_group_leader)
          INTO vo_group_name, vo_area_leader
          FROM scmdata.t_supplier_group_config t
         INNER JOIN scmdata.t_supplier_group_category_config a
            ON t.pause = 1
           AND a.pause = 1
           AND a.group_config_id = t.group_config_id
           AND a.company_id = t.company_id
           AND trunc(SYSDATE) BETWEEN trunc(t.effective_time) AND
               trunc(t.end_time)
           AND scmdata.instr_priv(a.area_config_id, v_area) > 0
         INNER JOIN scmdata.t_supplier_group_subcate_config b
            ON b.pause = 1
           AND b.group_category_config_id = a.group_category_config_id
           AND b.company_id = a.company_id
           AND b.cooperation_classification = p_category
           AND b.cooperation_product_cate = p_product_cate
           AND instr(b.subcategory, p_sub_cate) > 0
         WHERE t.company_id = p_company_id;
      END IF;
    END IF;
  
    po_group_name  := vo_group_name;
    po_area_leader := vo_area_leader;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      BEGIN
        EXECUTE IMMEDIATE 'BEGIN  pkg_run_proc.insert_log(p_record_id => :record_id,
                                                          p_log_type  => :log_type,
                                                          p_log_flag  => :log_flag,
                                                          p_msg       => :msg); END;'
          USING '0000', 'SYS_ERR', 'F', 'PKG_RUN_PROC.PROC_SQL-----RUN_PROC_SQL:' || dbms_utility.format_error_backtrace || dbms_utility.format_error_stack;
      END;
  END p_get_groupname;
  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-10 13:56:49
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  订单底层表刷新  
  * Obj_Name    : P_MERGE_ORDER
  * Arg_Number  : 3
  * P_COMPANY_ID : 企业ID
  * P_BEGIN_DATE : 开始日期
  * P_END_DATE : 结束日期
  *============================================*/

  PROCEDURE p_merge_order(p_company_id VARCHAR2,
                          p_begin_date DATE,
                          p_end_date   DATE) IS
    v_cur_mon VARCHAR2(32);
  BEGIN
    --当月月初至当月5号 同步上月订单
    v_cur_mon := f_get_month(p_begin_date);
    MERGE INTO scmdata.pt_ordered pta
    USING (
      WITH supp_info AS
       (SELECT sp.company_id,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               province || city || county location_area,
               sp.group_name,
               sg.area_group_leader,
               sp.company_province,
               sp.company_city,
               sp.company_county
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.dic_province p
            ON p.provinceid = sp.company_province
          LEFT JOIN scmdata.dic_city c
            ON c.cityno = sp.company_city
          LEFT JOIN scmdata.dic_county dc
            ON dc.countyid = sp.company_county
          LEFT JOIN scmdata.t_supplier_group_config sg
            ON sg.group_config_id = sp.group_name
           AND sg.pause = 1),
      group_dict AS
       (SELECT group_dict_type, group_dict_value, group_dict_name
          FROM scmdata.sys_group_dict),
      dilvery_info AS
       (SELECT company_id,
               order_code,
               goo_id,
               delivery_amount,
               delivery_date,
               predict_delivery_amount
          FROM scmdata.t_delivery_record)
      SELECT DISTINCT *
        FROM (SELECT to_number(extract(YEAR FROM po.delivery_date)) YEAR,
                     to_number(to_char(po.delivery_date, 'Q')) quarter,
                     to_number(extract(MONTH FROM po.delivery_date)) MONTH,
                     --pr.supplier_code,
                     sp_a.inside_supplier_code,
                     sp_a.supplier_company_name,
                     pr.factory_code,
                     sp_b.supplier_company_name factory_company_name,
                     pr.product_gress_code,
                     tc.rela_goo_id,
                     tc.category,
                     tc.product_cate,
                     tc.samll_category,
                     a.group_dict_name category_desc,
                     b.group_dict_name coop_product_cate_desc,
                     c.company_dict_name product_subclass_desc,
                     tc.style_name,
                     tc.style_number,
                     po.deal_follower flw_order, --跟单员
                     '' flw_order_manager, --跟单主管  来源字段待定
                     v.finish_qc_id qc, --qc
                     '' qc_manager, --QC主管  来源字段待定
                     (CASE
                       WHEN sp_b.supplier_code NOT IN ('C00216', 'C00563') THEN
                        (CASE
                          WHEN po.order_status = 'OS02' THEN
                           po.area_group_leaderid
                          ELSE
                           sp_b.area_group_leader
                        END)
                       ELSE
                        NULL
                     END) area_gp_leader, --区域组长
                     (CASE
                       WHEN sp_b.supplier_code NOT IN ('C00216', 'C00563') THEN
                        (CASE
                          WHEN po.order_status = 'OS02' THEN
                           po.area_group_id
                          ELSE
                           sp_b.group_name
                        END)
                       ELSE
                        NULL
                     END) group_name,
                     (CASE
                       WHEN sp_b.supplier_code NOT IN ('C00216', 'C00563') THEN
                        (CASE
                          WHEN po.order_status = 'OS02' THEN
                           po.area_locatioin
                          ELSE
                           sp_b.location_area
                        END)
                       ELSE
                        NULL
                     END) location_area,
                     sp_b.company_province,
                     sp_b.company_city,
                     --'' is_twenty, --是否前20%
                     CASE
                       WHEN pr.delivery_amount = 0 THEN
                        CASE
                          WHEN pr.progress_status = '01' THEN
                           '取消订单'
                          ELSE
                           '未交货'
                        END
                       ELSE
                        CASE
                          WHEN trunc(pr.actual_delivery_date) -
                               trunc(po.delivery_date) <= 0 THEN
                           '正常'
                          ELSE
                           '延期'
                        END
                     END delivery_status, --交货状态
                     pr.is_quality is_quality, --是否质量问题延期
                     pr.actual_delay_day,
                     CASE
                       WHEN pr.actual_delay_day = 0 THEN
                        ''
                       WHEN pr.actual_delay_day BETWEEN 1 AND 3 THEN
                        '1~3天'
                       WHEN pr.actual_delay_day BETWEEN 4 AND 6 THEN
                        '4~6天'
                       ELSE
                        '7天以上'
                     END delay_interval,
                     pr.responsible_dept,
                     pr.responsible_dept_sec,
                     pr.delay_problem_class,
                     pr.delay_cause_class,
                     pr.delay_cause_detailed,
                     pr.is_sup_responsible,
                     pr.problem_desc,
                     pln.order_price,
                     tc.price,
                     pr.order_amount,
                     nvl(SUM(dr.predict_delivery_amount)
                         over(PARTITION BY pr.product_gress_id),
                         0) est_arrival_amount, --预计到货量
                     pr.delivery_amount,
                     SUM(CASE
                           WHEN trunc(dr.delivery_date) - trunc(po.delivery_date) <= 0 THEN
                            dr.delivery_amount
                           ELSE
                            0
                         END) over(PARTITION BY pr.product_gress_id) satisfy_amount, --满足数量
                     pln.order_amount * tc.price order_money,
                     pr.delivery_amount * tc.price delivery_money,
                     SUM(CASE
                           WHEN trunc(dr.delivery_date) - trunc(po.delivery_date) <= 0 THEN
                            dr.delivery_amount
                           ELSE
                            0
                         END) over(PARTITION BY pr.product_gress_id) * tc.price satisfy_money, --满足金额 * pln.order_price
                     po.delivery_date,
                     po.create_time,
                     '' arrival_date, --到仓日期
                     '' sort_date, --分拣日期
                     po.isfirstordered isfirstordered, --是否首单
                     po.memo,
                     po.finish_time_scm,
                     po.company_id,
                     po.order_id,
                     tc.goo_id goo_id_pr, --商品档案编号
                     po.sho_id, --仓库编号
                     MAX(pln.delivery_date) over(PARTITION BY pln.order_id) latest_planned_delivery_date,
                     po.is_product_order
                FROM scmdata.t_ordered po
               INNER JOIN scmdata.t_orders pln
                  ON po.company_id = pln.company_id
                 AND po.order_code = pln.order_id
               INNER JOIN scmdata.t_production_progress pr
                  ON pln.company_id = pr.company_id
                 AND pln.order_id = pr.order_id
                 AND pln.goo_id = pr.goo_id
               INNER JOIN scmdata.t_commodity_info tc
                  ON pr.company_id = tc.company_id
                 AND pr.goo_id = tc.goo_id
                LEFT JOIN dilvery_info dr
                  ON pr.company_id = dr.company_id
                 AND pr.order_id = dr.order_code
                 AND pr.goo_id = dr.goo_id
                LEFT JOIN supp_info sp_a
                  ON sp_a.company_id = pr.company_id
                 AND sp_a.supplier_code = pr.supplier_code
                LEFT JOIN supp_info sp_b
                  ON sp_b.company_id = pr.company_id
                 AND sp_b.supplier_code = pr.factory_code
                LEFT JOIN group_dict a
                  ON a.group_dict_type = 'PRODUCT_TYPE'
                 AND a.group_dict_value = tc.category
                LEFT JOIN group_dict b
                  ON b.group_dict_type = a.group_dict_value
                 AND b.group_dict_value = tc.product_cate
                LEFT JOIN scmdata.sys_company_dict c
                  ON c.company_dict_type = b.group_dict_value
                 AND c.company_dict_value = tc.samll_category
                 AND c.company_id = tc.company_id
                LEFT JOIN (SELECT qc_a.orders_id,
                                 listagg(DISTINCT qc_b.finish_qc_id, ',') finish_qc_id
                            FROM scmdata.t_qc_check_rela_order qc_a
                           INNER JOIN scmdata.t_qc_check qc_b
                              ON qc_b.finish_time IS NOT NULL
                             AND qc_b.qc_check_id = qc_a.qc_check_id
                             AND qc_b.qc_check_node = 'QC_FINAL_CHECK'
                           GROUP BY qc_a.orders_id) v
                  ON v.orders_id = pln.orders_id
               WHERE po.company_id = p_company_id
                    --1）当月月初至月底 同步当月订单
                 AND ((po.delivery_date BETWEEN p_begin_date AND p_end_date) OR
                     --2）当月月初至当月5号 同步上月订单
                     to_char(po.delivery_date, 'yyyy-mm') = v_cur_mon))) ptb
          ON (pta.company_id = ptb.company_id AND pta.order_id = ptb.order_id) WHEN
       MATCHED THEN
        UPDATE
           SET pta.year                   = ptb.year,
               pta.quarter                = ptb.quarter,
               pta.month                  = ptb.month,
               pta.supplier_code          = ptb.inside_supplier_code,
               pta.supplier_company_name  = ptb.supplier_company_name,
               pta.factory_code           = ptb.factory_code,
               pta.factory_company_name   = ptb.factory_company_name,
               pta.product_gress_code     = ptb.product_gress_code,
               pta.goo_id                 = ptb.rela_goo_id,
               pta.category               = ptb.category,
               pta.category_name          = ptb.category_desc,
               pta.product_cate           = ptb.product_cate,
               pta.coop_product_cate_name = ptb.coop_product_cate_desc,
               pta.samll_category         = ptb.samll_category,
               pta.product_subclass_name  = ptb.product_subclass_desc,
               pta.style_name             = ptb.style_name,
               pta.style_number           = ptb.style_number,
               pta.flw_order              = ptb.flw_order,
               pta.flw_order_manager      = '', --ptb.flw_order_manager,
               pta.qc                    =
               (CASE
                 WHEN pta.updated_qc = 1 AND pta.qc IS NOT NULL THEN
                  pta.qc
                 ELSE
                  ptb.qc
               END),
               /*decode(pta.updated_qc,0,ptb.qc,pta.qc),*/
               pta.qc_manager = '', --ptb.qc_manager,
               --pta.is_twenty              = '', --ptb.is_twenty,
               pta.delivery_status      = ptb.delivery_status,
               pta.is_quality           = ptb.is_quality,
               pta.actual_delay_days    = ptb.actual_delay_day,
               pta.delay_section        = ptb.delay_interval,
               pta.is_sup_duty          = ptb.is_sup_responsible,
               pta.responsible_dept     = decode(pta.updated,
                                                 0,
                                                 ptb.responsible_dept,
                                                 pta.responsible_dept),
               pta.responsible_dept_sec = decode(pta.updated,
                                                 0,
                                                 ptb.responsible_dept_sec,
                                                 pta.responsible_dept_sec),
               pta.delay_problem_class  = decode(pta.updated,
                                                 0,
                                                 ptb.delay_problem_class,
                                                 pta.delay_problem_class),
               pta.delay_cause_class    = decode(pta.updated,
                                                 0,
                                                 ptb.delay_cause_class,
                                                 pta.delay_cause_class),
               pta.delay_cause_detailed = decode(pta.updated,
                                                 0,
                                                 ptb.delay_cause_detailed,
                                                 pta.delay_cause_detailed),
               pta.problem_desc         = decode(pta.updated,
                                                 0,
                                                 ptb.problem_desc,
                                                 pta.problem_desc),
               pta.purchase_price       = ptb.order_price,
               pta.fixed_price          = ptb.price,
               pta.order_amount         = ptb.order_amount,
               pta.est_arrival_amount   = ptb.est_arrival_amount,
               pta.delivery_amount      = ptb.delivery_amount,
               pta.satisfy_amount       = ptb.satisfy_amount,
               pta.order_money          = ptb.order_money,
               pta.delivery_money       = ptb.delivery_money,
               pta.satisfy_money        = ptb.satisfy_money,
               pta.delivery_date        = ptb.delivery_date,
               pta.order_create_date    = ptb.create_time,
               --pta.arrival_date         = '', --ptb.arrival_date,
               --pta.sort_date            = '', --ptb.sort_date,
               pta.is_first_order               = ptb.isfirstordered,
               pta.remarks                      = ptb.memo,
               pta.order_finish_time            = ptb.finish_time_scm,
               pta.update_id                    = 'ADMIN',
               pta.update_time                  = SYSDATE,
               pta.goo_id_pr                    = ptb.goo_id_pr,
               pta.sho_id                       = ptb.sho_id,
               pta.group_name                   = ptb.group_name,
               pta.area_locatioin               = ptb.location_area,
               pta.area_gp_leader               = ptb.area_gp_leader,
               pta.latest_planned_delivery_date = ptb.latest_planned_delivery_date,
               pta.is_product_order             = ptb.is_product_order WHEN NOT MATCHED THEN INSERT(pta.pt_ordered_id, pta.company_id, pta.order_id, pta.year, pta.quarter, pta.month, pta.supplier_code, pta.supplier_company_name, pta.factory_code, pta.factory_company_name, pta.product_gress_code, pta.goo_id, pta.category, pta.category_name, pta.product_cate, pta.coop_product_cate_name, pta.samll_category, pta.product_subclass_name, pta.style_name, pta.style_number, pta.flw_order, pta.flw_order_manager, pta.qc, pta.qc_manager, pta.is_twenty, pta.delivery_status, pta.is_quality, pta.actual_delay_days, pta.delay_section, pta.is_sup_duty, pta.responsible_dept, pta.responsible_dept_sec, pta.delay_problem_class, pta.delay_cause_class, pta.delay_cause_detailed, pta.problem_desc, pta.purchase_price, pta.fixed_price, pta.order_amount, pta.est_arrival_amount, pta.delivery_amount, pta.satisfy_amount, pta.order_money, pta.delivery_money, pta.satisfy_money, pta.delivery_date, pta.order_create_date,
               --pta.arrival_date,
               --pta.sort_date,
                pta.is_first_order, pta.remarks, pta.order_finish_time, pta.create_id, pta.create_time, pta.update_id, pta.update_time, pta.goo_id_pr, pta.sho_id, pta.group_name, pta.area_locatioin, pta.area_gp_leader, pta.latest_planned_delivery_date, pta.is_product_order) VALUES(scmdata.f_get_uuid(), ptb.company_id, ptb.order_id, ptb.year, ptb.quarter, ptb.month, ptb.inside_supplier_code, ptb.supplier_company_name, ptb.factory_code, ptb.factory_company_name, ptb.product_gress_code, ptb.rela_goo_id, ptb.category, ptb.category_desc, ptb.product_cate, ptb.coop_product_cate_desc, ptb.samll_category, ptb.product_subclass_desc, ptb.style_name, ptb.style_number, ptb.flw_order, '' /*ptb.flw_order_manager*/
                , ptb.qc, '' /*ptb.qc_manager*/
                , 0 /* ptb.is_twenty*/
                , ptb.delivery_status, ptb.is_quality, ptb.actual_delay_day, ptb.delay_interval, ptb.is_sup_responsible, ptb.responsible_dept, ptb.responsible_dept_sec, ptb.delay_problem_class, ptb.delay_cause_class, ptb.delay_cause_detailed, ptb.problem_desc, ptb.order_price, ptb.price, ptb.order_amount, ptb.est_arrival_amount, ptb.delivery_amount, ptb.satisfy_amount, ptb.order_money, ptb.delivery_money, ptb.satisfy_money, ptb.delivery_date, ptb.create_time,
               --'' /*ptb.arrival_date*/,
               --'' /*ptb.sort_date*/,
                ptb.isfirstordered, ptb.memo, ptb.finish_time_scm, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE, ptb.goo_id_pr, ptb.sho_id, ptb.group_name, ptb.location_area, ptb.area_gp_leader, ptb.latest_planned_delivery_date, ptb.is_product_order);
    --取交货记录收货量不为0,到仓时间，分拣时间
    BEGIN
      MERGE INTO pt_ordered pta
      USING (SELECT DISTINCT *
               FROM (SELECT MAX(dr.delivery_date) over(PARTITION BY po.order_id) arrival_date,
                            MAX(dr.sorting_date) over(PARTITION BY po.order_id) sort_date,
                            po.order_id,
                            po.company_id
                       FROM scmdata.t_ordered po
                      INNER JOIN scmdata.t_orders pln
                         ON po.company_id = pln.company_id
                        AND po.order_code = pln.order_id
                      INNER JOIN scmdata.t_production_progress pr
                         ON pln.company_id = pr.company_id
                        AND pln.order_id = pr.order_id
                        AND pln.goo_id = pr.goo_id
                       LEFT JOIN scmdata.t_delivery_record dr
                         ON pr.company_id = dr.company_id
                        AND pr.order_id = dr.order_code
                        AND pr.goo_id = dr.goo_id
                      WHERE po.company_id = p_company_id
                        AND dr.delivery_amount <> 0
                           --1）当月月初至月底 同步当月订单
                        AND ((po.delivery_date BETWEEN p_begin_date AND
                            p_end_date) OR
                            --2）当月月初至当月5号 同步上月订单
                            (to_char(po.delivery_date, 'yyyy-mm') =
                            v_cur_mon)))) ptb
      ON (pta.company_id = ptb.company_id AND pta.order_id = ptb.order_id)
      WHEN MATCHED THEN
        UPDATE
           SET pta.arrival_date = ptb.arrival_date,
               pta.sort_date    = ptb.sort_date;
    END;
    --次月3号才判断生成
    --是否前20%,需次月3号才判断生成
    BEGIN
      IF trunc(SYSDATE, 'mm') + 2 = trunc(SYSDATE) THEN
        FOR i IN (SELECT a.pt_ordered_id
                    FROM scmdata.pt_ordered a
                   INNER JOIN scmdata.t_bestgoodsofmonth b
                      ON b.goo_id = a.goo_id_pr
                     AND b.ayear = a.year
                     AND b.amonth = a.month
                   WHERE a.company_id = p_company_id
                     AND to_char(a.delivery_date, 'yyyy-mm') =
                         to_char(add_months(SYSDATE, -1), 'yyyy-mm')) LOOP
          UPDATE scmdata.pt_ordered t
             SET t.is_twenty = 1
           WHERE t.pt_ordered_id = i.pt_ordered_id;
        END LOOP;
      END IF;
    END;
  
    --更新主管
    BEGIN
      FOR pt_rec IN (SELECT pt.company_id,
                            pt.pt_ordered_id,
                            pt.flw_order,
                            pt.qc
                       FROM scmdata.pt_ordered pt
                      WHERE pt.company_id = p_company_id
                           --1）当月月初至月底 同步当月订单
                        AND ((pt.delivery_date BETWEEN p_begin_date AND
                            p_end_date) OR
                            --2）当月月初至当月5号 同步上月订单
                            (to_char(pt.delivery_date, 'yyyy-mm') =
                            v_cur_mon))) LOOP
        UPDATE scmdata.pt_ordered pt
           SET pt.flw_order_manager = f_get_manager(p_company_id     => pt_rec.company_id,
                                                    p_user_id        => pt_rec.flw_order,
                                                    p_company_job_id => '1001005003005002'),
               pt.qc_manager        = f_get_manager_byconfig(p_company_id => pt_rec.company_id,
                                                             p_user_id    => pt_rec.qc)
         WHERE pt.pt_ordered_id = pt_rec.pt_ordered_id;
      END LOOP;
    END;
  END p_merge_order;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-10 14:03:25
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 更新回货计划表的数据 
  * Obj_Name    : P_MERGE_RETURN_PLAN
  * Arg_Number  : 0
  *============================================*/
  PROCEDURE p_merge_return_plan IS
    v_robot_type VARCHAR2(1024);
    v_company_id VARCHAR2(1024);
  BEGIN
    MERGE INTO scmdata.t_return_plan pta
    USING (
      WITH c_order AS
       (SELECT z.company_id,
               z.order_code,
               w.delivery_date,
               w.order_amount,
               w.goo_id,
               z.sho_id
          FROM scmdata.t_ordered z
         INNER JOIN scmdata.t_orders w
            ON w.order_id = z.order_code
           AND w.company_id = z.company_id
         WHERE NOT EXISTS (SELECT 1
                  FROM scmdata.t_delivery_record t
                 WHERE t.order_code = z.order_code
                   AND z.company_id = t.company_id)
           AND (z.send_by_sup <> 1 OR z.send_by_sup IS NULL)
           AND z.finish_time IS NULL
        UNION ALL
        SELECT b.company_id,
               b.order_code,
               b.predict_delivery_date,
               b.predict_delivery_amount,
               b.goo_id,
               y.sho_id
          FROM scmdata.t_orders x
         INNER JOIN scmdata.t_ordered y
            ON x.order_id = y.order_code
           AND x.company_id = y.company_id
         INNER JOIN scmdata.t_delivery_record b
            ON x.goo_id = b.goo_id
           AND x.order_id = b.order_code
           AND x.company_id = b.company_id
         WHERE y.order_status = 'OS01'
           AND (y.send_by_sup <> 1 OR y.send_by_sup IS NULL)
           AND b.end_acc_time IS NULL
           AND y.finish_time IS NULL)
      SELECT g.company_id,
             g.order_code,
             g.latest_delivery_date,
             g.year,
             g.month,
             MAX(CASE g.category
                   WHEN '男装' THEN
                    order_amount
                   ELSE
                    0
                 END) menswear,
             MAX(CASE g.category
                   WHEN '女装' THEN
                    order_amount
                   ELSE
                    0
                 END) womenswear,
             MAX(CASE g.category
                   WHEN '内衣' THEN
                    order_amount
                   ELSE
                    0
                 END) underwear,
             MAX(CASE g.category
                   WHEN '美妆' THEN
                    order_amount
                   ELSE
                    0
                 END) beautymakeup,
             MAX(CASE g.category
                   WHEN '鞋包' THEN
                    order_amount
                   ELSE
                    0
                 END) shoesbags,
             MAX(CASE g.category
                   WHEN '淘品' THEN
                    order_amount
                   ELSE
                    0
                 END) taopin,
             g.sho_id
        FROM (SELECT (SELECT group_dict_name
                        FROM scmdata.sys_group_dict
                       WHERE group_dict_value = x.category
                         AND group_dict_type = 'PRODUCT_TYPE') category,
                     c.company_id,
                     c.order_code,
                     MAX(to_date(to_char(c.delivery_date, 'yyyy/mm/dd'),
                                 'yyyy-mm-dd')) over(PARTITION BY c.order_code, c.company_id) latest_delivery_date,
                     MAX(to_char(c.delivery_date, 'yyyy')) over(PARTITION BY c.order_code, c.company_id) YEAR,
                     MAX(to_number(to_char(c.delivery_date, 'mm'))) over(PARTITION BY c.order_code, c.company_id) MONTH,
                     c.order_amount,
                     c.sho_id
                FROM c_order c
               INNER JOIN scmdata.t_commodity_info x
                  ON x.goo_id = c.goo_id
                 AND x.company_id = c.company_id) g
       WHERE g.latest_delivery_date > SYSDATE
       GROUP BY g.order_code,
                g.company_id,
                g.latest_delivery_date,
                g.year,
                g.month,
                g.sho_id) ptb
          ON (pta.company_id = ptb.company_id AND
             pta.order_id = ptb.order_code) WHEN MATCHED THEN
        UPDATE
           SET pta.delivery_date       = ptb.latest_delivery_date,
               pta.year                = ptb.year,
               pta.month               = ptb.month,
               pta.menswear_amount     = ptb.menswear,
               pta.womenswear_amount   = ptb.womenswear,
               pta.underwear_amount    = ptb.underwear,
               pta.beautymakeup_amount = ptb.beautymakeup,
               pta.shoesbags_amount    = ptb.shoesbags,
               pta.taopin_amount       = ptb.taopin,
               pta.warehouse           = ptb.sho_id,
               pta.update_id           = 'ADMIN',
               pta.update_time         = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (pta.t_return_plan_id,
           pta.company_id,
           pta.order_id,
           pta.delivery_date,
           pta.year,
           pta.month,
           pta.menswear_amount,
           pta.womenswear_amount,
           pta.underwear_amount,
           pta.beautymakeup_amount,
           pta.shoesbags_amount,
           pta.taopin_amount,
           pta.warehouse,
           pta.create_id,
           pta.create_time,
           pta.update_id,
           pta.update_time)
        VALUES
          (scmdata.f_get_uuid(),
           ptb.company_id,
           ptb.order_code,
           ptb.latest_delivery_date,
           ptb.year,
           ptb.month,
           ptb.menswear,
           ptb.womenswear,
           ptb.underwear,
           ptb.beautymakeup,
           ptb.shoesbags,
           ptb.taopin,
           ptb.sho_id,
           'ADMIN',
           SYSDATE,
           'ADMIN',
           SYSDATE);
  EXCEPTION
    WHEN OTHERS THEN
      BEGIN
        v_robot_type := 'RETURN_PLAN_MSG';
        SELECT company_id
          INTO v_company_id
          FROM scmdata.sys_company_wecom_config
         WHERE robot_type = v_robot_type;
        scmdata.pkg_send_wx_msg.p_send_wx_msg(v_company_id,
                                              v_robot_type,
                                              'text',
                                              ';',
                                              '回货计划定时任务出错消息通知',
                                              'LSL167');
      END;
  END p_merge_return_plan;
END pkg_db_job;
/
