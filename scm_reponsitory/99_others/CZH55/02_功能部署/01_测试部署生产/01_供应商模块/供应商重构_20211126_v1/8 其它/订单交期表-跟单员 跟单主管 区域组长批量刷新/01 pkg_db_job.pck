CREATE OR REPLACE PACKAGE pkg_db_job IS

  -- Author  : CZH
  -- Created : 2021/9/2 11:43:38
  -- Purpose : 统一管理业务报表的定时任务（数据库）

  --订单数据表
  --次月1~5号,返回上个月份
  FUNCTION f_get_month(p_begin_date DATE) RETURN VARCHAR2;
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
CREATE OR REPLACE PACKAGE BODY pkg_db_job IS
  --订单数据表
  --次月1~5号,返回上个月份
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
  --获取主管
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

  --merge_order
  PROCEDURE p_merge_order(p_company_id VARCHAR2,
                          p_begin_date DATE,
                          p_end_date   DATE) IS
  BEGIN
    MERGE INTO scmdata.pt_ordered pta
    USING (
      WITH supp_info AS
       (SELECT company_id,
               supplier_code,
               inside_supplier_code,
               supplier_company_name,
               area_group_leader
          FROM scmdata.t_supplier_info),
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
                     (SELECT listagg(DISTINCT qc_b.finish_qc_id, ',')
                        FROM scmdata.t_qc_check_rela_order qc_a
                       INNER JOIN scmdata.t_qc_check qc_b
                          ON qc_b.finish_time IS NOT NULL
                         AND qc_b.qc_check_id = qc_a.qc_check_id
                         AND qc_b.qc_check_node = 'QC_FINAL_CHECK'
                       WHERE qc_a.orders_id = pln.orders_id) qc, --qc
                     '' qc_manager, --QC主管  来源字段待定
                     sp_a.area_group_leader area_gp_leader, --区域组长
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
                     po.order_id
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
               WHERE po.company_id = p_company_id
                    --1）当月月初至月底 同步当月订单  
                 AND ((po.delivery_date BETWEEN p_begin_date AND p_end_date) OR
                     --2）当月月初至当月5号 同步上月订单
                     to_char(po.delivery_date, 'yyyy-mm') =
                     f_get_month(p_begin_date)))) ptb
          ON (pta.company_id = ptb.company_id AND
             pta.order_id = ptb.order_id) WHEN MATCHED THEN
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
               pta.qc                     = ptb.qc,
               pta.qc_manager             = '', --ptb.qc_manager,
               pta.area_gp_leader         = ptb.area_gp_leader,
               --pta.is_twenty              = '', --ptb.is_twenty,
               pta.delivery_status      = ptb.delivery_status,
               pta.is_quality           = ptb.is_quality,
               pta.actual_delay_days    = ptb.actual_delay_day,
               pta.delay_section        = ptb.delay_interval,
               pta.responsible_dept     = ptb.responsible_dept,
               pta.responsible_dept_sec = ptb.responsible_dept_sec,
               pta.delay_problem_class  = ptb.delay_problem_class,
               pta.delay_cause_class    = ptb.delay_cause_class,
               pta.delay_cause_detailed = ptb.delay_cause_detailed,
               pta.problem_desc         = ptb.problem_desc,
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
               pta.is_first_order    = ptb.isfirstordered,
               pta.remarks           = ptb.memo,
               pta.order_finish_time = ptb.finish_time_scm,
               pta.update_id         = 'ADMIN',
               pta.update_time       = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT
          (pta.pt_ordered_id,
           pta.company_id,
           pta.order_id,
           pta.year,
           pta.quarter,
           pta.month,
           pta.supplier_code,
           pta.supplier_company_name,
           pta.factory_code,
           pta.factory_company_name,
           pta.product_gress_code,
           pta.goo_id,
           pta.category,
           pta.category_name,
           pta.product_cate,
           pta.coop_product_cate_name,
           pta.samll_category,
           pta.product_subclass_name,
           pta.style_name,
           pta.style_number,
           pta.flw_order,
           pta.flw_order_manager,
           pta.qc,
           pta.qc_manager,
           pta.area_gp_leader,
           pta.is_twenty,
           pta.delivery_status,
           pta.is_quality,
           pta.actual_delay_days,
           pta.delay_section,
           pta.responsible_dept,
           pta.responsible_dept_sec,
           pta.delay_problem_class,
           pta.delay_cause_class,
           pta.delay_cause_detailed,
           pta.problem_desc,
           pta.purchase_price,
           pta.fixed_price,
           pta.order_amount,
           pta.est_arrival_amount,
           pta.delivery_amount,
           pta.satisfy_amount,
           pta.order_money,
           pta.delivery_money,
           pta.satisfy_money,
           pta.delivery_date,
           pta.order_create_date,
           --pta.arrival_date,
           --pta.sort_date,
           pta.is_first_order,
           pta.remarks,
           pta.order_finish_time,
           pta.create_id,
           pta.create_time,
           pta.update_id,
           pta.update_time)
        VALUES
          (scmdata.f_get_uuid(),
           ptb.company_id,
           ptb.order_id,
           ptb.year,
           ptb.quarter,
           ptb.month,
           ptb.inside_supplier_code,
           ptb.supplier_company_name,
           ptb.factory_code,
           ptb.factory_company_name,
           ptb.product_gress_code,
           ptb.rela_goo_id,
           ptb.category,
           ptb.category_desc,
           ptb.product_cate,
           ptb.coop_product_cate_desc,
           ptb.samll_category,
           ptb.product_subclass_desc,
           ptb.style_name,
           ptb.style_number,
           ptb.flw_order,
           '' /*ptb.flw_order_manager*/,
           ptb.qc,
           '' /*ptb.qc_manager*/,
           ptb.area_gp_leader,
           0 /* ptb.is_twenty*/,
           ptb.delivery_status,
           ptb.is_quality,
           ptb.actual_delay_day,
           ptb.delay_interval,
           ptb.responsible_dept,
           ptb.responsible_dept_sec,
           ptb.delay_problem_class,
           ptb.delay_cause_class,
           ptb.delay_cause_detailed,
           ptb.problem_desc,
           ptb.order_price,
           ptb.price,
           ptb.order_amount,
           ptb.est_arrival_amount,
           ptb.delivery_amount,
           ptb.satisfy_amount,
           ptb.order_money,
           ptb.delivery_money,
           ptb.satisfy_money,
           ptb.delivery_date,
           ptb.create_time,
           --'' /*ptb.arrival_date*/,
           --'' /*ptb.sort_date*/,
           ptb.isfirstordered,
           ptb.memo,
           ptb.finish_time_scm,
           'ADMIN',
           SYSDATE,
           'ADMIN',
           SYSDATE);
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
                            f_get_month(p_begin_date))))) ptb
      ON (pta.company_id = ptb.company_id AND pta.order_id = ptb.order_id)
      WHEN MATCHED THEN
        UPDATE
           SET pta.arrival_date = ptb.arrival_date,
               pta.sort_date    = ptb.sort_date;
    END;
    --次月3号才判断生成
    BEGIN
      IF trunc(SYSDATE, 'mm') + 2 = trunc(SYSDATE) THEN
        --是否前20%,需次月3号才判断生成
        MERGE INTO (SELECT goo_id, is_twenty
                      FROM scmdata.pt_ordered
                     WHERE company_id = p_company_id
                       AND to_char(delivery_date, 'yyyy-mm') =
                           to_char(add_months(SYSDATE, -1), 'yyyy-mm')) pta
        USING (SELECT goo_id FROM scmdata.t_bestgoodsofmonth) bg
        ON (pta.goo_id = bg.goo_id)
        WHEN MATCHED THEN
          UPDATE SET pta.is_twenty = 1;
      END IF;
    END;
  
    --更新主管
    DECLARE
      v_count NUMBER := 0;
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
                            f_get_month(p_begin_date)))) LOOP
      
        v_count := v_count + 1;
      
        UPDATE scmdata.pt_ordered pt
           SET pt.flw_order_manager = f_get_manager(p_company_id     => pt_rec.company_id,
                                                    p_user_id        => pt_rec.flw_order,
                                                    p_company_job_id => '1001005003005002'),
               pt.qc_manager        = f_get_manager(p_company_id     => pt_rec.company_id,
                                                    p_user_id        => pt_rec.qc,
                                                    p_company_job_id => '1001005003005001')
         WHERE pt.pt_ordered_id = pt_rec.pt_ordered_id;
        --END LOOP;
        --每一千条提交一次
        IF MOD(v_count, 1000) = 0 THEN
          COMMIT;
        END IF;
      END LOOP;
    END;
    --剩余提交一次,提交所有
    COMMIT;
  
    /* EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys_raise_app_error_pkg.is_running_error(p_is_running_error => 'T',
                                               p_is_log           => 1);*/
  END p_merge_order;

  --3.更新回货计划表的数据  BEGIN
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
           SET pta.company_id          = ptb.company_id,
               pta.delivery_date       = ptb.latest_delivery_date,
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
  --更新回货计划表的数据  END
END pkg_db_job;
/
