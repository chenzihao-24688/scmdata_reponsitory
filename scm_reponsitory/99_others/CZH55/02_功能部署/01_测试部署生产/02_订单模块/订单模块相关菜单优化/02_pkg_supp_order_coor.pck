CREATE OR REPLACE PACKAGE pkg_supp_order_coor IS

  -- Author  : SANFU
  -- Created : 2021/12/9 14:18:42
  -- Purpose : 供应商-订单协同

  FUNCTION f_query_order_list(p_item_id VARCHAR2) RETURN CLOB;
  --订单数量明细
  FUNCTION f_query_ordernums_list RETURN CLOB;
  --查询操作记录
  FUNCTION f_query_order_log(p_item_id VARCHAR2) RETURN CLOB;
  --指定工厂  记录操作日志
  PROCEDURE p_insert_order_log(p_company_id            VARCHAR2,
                               p_order_id              VARCHAR2,
                               p_log_type              VARCHAR2,
                               p_old_designate_factory VARCHAR2,
                               p_new_designate_factory VARCHAR2,
                               p_operator              VARCHAR2,
                               p_operate_person        VARCHAR2);
  --生产进度填报
  FUNCTION f_query_order_progress_list(p_item_id VARCHAR2,
                                       p_where   VARCHAR2) RETURN CLOB;
  --生产进度填报  已完成：a_product_216
  FUNCTION f_query_order_progressed_list(p_item_id VARCHAR2) RETURN CLOB;
  --节点进度 ：a_product_211
  FUNCTION f_query_progress_node_list(p_item_id VARCHAR2) RETURN CLOB;
  --新增节点进度（临时）
  PROCEDURE p_insert_node_tmp(p_tmp_rec scmdata.t_node_tmp%ROWTYPE);
  --修改节点进度（临时）
  PROCEDURE p_update_node_tmp(p_tmp_rec scmdata.t_node_tmp%ROWTYPE);

END pkg_supp_order_coor;
/
CREATE OR REPLACE PACKAGE BODY pkg_supp_order_coor IS
  --供应商 接单列表 待完成：a_order_201_0  已完成：a_order_201_1
  FUNCTION f_query_order_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    --czh add 20211209_v0
    v_sql := q'[WITH gdic AS
     (SELECT group_dict_name, group_dict_value, group_dict_type
        FROM scmdata.sys_group_dict),
    supp_info AS
     (SELECT company_id,
             supplier_company_id,
             supplier_company_name,
             supplier_code
        FROM scmdata.t_supplier_info)
    SELECT z.order_code,
           z.order_status,
           gd_a.group_dict_name order_status_desc,
           z.company_id,
           z.company_name customer,
           x.rela_goo_id,
           x.style_number,
           y.factory_code,
           sp_a.supplier_company_name product_factory,
           z.deal_follower,
           z.delivery_date,
           MAX(y.delivery_date) over(PARTITION BY y.order_id, y.company_id) latest_delivery_date,
           y.order_amount,
           y.order_price single_price,
           y.order_price * y.order_amount order_sum,
           z.memo,
           gd_b.group_dict_name order_type,
           x.style_name,
           x.goo_name,
           w.picture,
           gd_c.group_dict_name category,
           gd_d.group_dict_name product_cate,
           cd_a.company_dict_name samll_category_gd,
           /*(SELECT listagg(company_user_name, ',')
              FROM scmdata.sys_company_user
             WHERE inner_user_id = z.send_order
               AND company_id = z.company_id) send_order,*/
           CASE
             WHEN z.send_by_sup = 0 THEN
              '否'
             WHEN z.send_by_sup = 1 THEN
              '是'
           END send_by_sup,
           z.send_order_date send_order_date,
           to_char(z.finish_time_scm, 'yyyy-MM-dd') finish_time_scm,
           x.goo_id,
           su.company_user_name update_id,
           z.update_time,
           z.order_id
      FROM (SELECT a.order_id,
                   a.order_code,
                   a.order_status,
                   a.supplier_code,
                   a.memo,
                   a.order_type,
                   a.send_order,
                   a.send_order_date,
                   a.finish_time_scm,
                   a.company_id,
                   a.update_id,
                   a.update_time,
                   a.delivery_date,
                   a.deal_follower,
                   a.send_by_sup,
                   d.company_name
              FROM scmdata.t_ordered a
             INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
                          FROM scmdata.t_supplier_info b
                         INNER JOIN scmdata.sys_company c
                            ON b.company_id = c.company_id
                         WHERE b.supplier_company_id = %default_company_id%) d
                ON a.company_id = d.company_id
               AND a.supplier_code = d.supplier_code]' || CASE
               WHEN p_item_id = 'a_order_201_0' THEN
                q'[ AND a.order_status IN ('OS01', 'OS00') AND a.is_product_order = 1 ]'
               WHEN p_item_id = 'a_order_201_4' THEN
                q'[ AND a.order_status IN ('OS01', 'OS00') AND a.is_product_order = 0 ]'
               WHEN p_item_id = 'a_order_201_1' THEN
                q'[ AND a.order_status IN ('OS02', 'OS03') ]'
               ELSE
                NULL
             END || q'[) z
     INNER JOIN scmdata.t_orders y
        ON z.order_code = y.order_id
       AND z.company_id = y.company_id
      LEFT JOIN gdic gd_a
        ON gd_a.group_dict_value = z.order_status
       AND gd_a.group_dict_type = 'ORDER_STATUS'
      LEFT JOIN gdic gd_b
        ON gd_b.group_dict_value = z.order_type
       AND gd_b.group_dict_type = 'ORDER_TYPE'
      LEFT JOIN scmdata.t_supplier_info sp_a
        ON sp_a.supplier_code = y.factory_code
       AND sp_a.company_id = z.company_id
      LEFT JOIN scmdata.sys_company_user su
        ON su.company_id = z.company_id
       AND su.user_id = z.update_id
     INNER JOIN scmdata.t_commodity_info x
        ON x.goo_id = y.goo_id
       AND x.company_id = y.company_id
     LEFT JOIN SCMDATA.T_COMMODITY_PICTURE w
        ON X.GOO_ID = w.GOO_ID
       AND X.COMPANY_ID = w.COMPANY_ID
     INNER JOIN gdic gd_c
        ON gd_c.group_dict_value = x.category
       AND gd_c.group_dict_type = 'PRODUCT_TYPE'
     INNER JOIN gdic gd_d
        ON gd_d.group_dict_value = x.product_cate
       AND gd_d.group_dict_type = x.category
     INNER JOIN scmdata.sys_company_dict cd_a
        ON cd_a.company_dict_value = x.samll_category
       AND cd_a.company_dict_type = x.product_cate
       AND cd_a.company_id = z.company_id
     WHERE ((%is_company_admin% = 1) OR
           scmdata.instr_priv(p_str1  => scmdata.pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                                            p_key     => 'COL_2'),
                               p_str2  => x.category,
                               p_split => ';') > 0)]';
    IF p_item_id IN ('a_order_201_0', 'a_order_201_1','a_order_201_4') THEN
      RETURN v_sql;
    ELSE
      NULL;
    END IF;
  END f_query_order_list;
  --订单数量明细
  FUNCTION f_query_ordernums_list RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT a.barcode,
       ccs.colorname param_1,
       ccs.sizename param_2,
       a.order_amount,
       a.order_amount - a.got_amount owe_amount_pr
  FROM scmdata.t_ordersitem a
  LEFT JOIN scmdata.t_commodity_color_size ccs
    ON a.barcode = ccs.barcode
   AND a.company_id = ccs.company_id
 WHERE a.order_id = :order_code
   AND a.company_id = :company_id
]';
    RETURN v_sql;
  END f_query_ordernums_list;
  --查询操作记录
  FUNCTION f_query_order_log(p_item_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := 'SELECT t.log_id,
       t.log_type,
       sp_a.supplier_company_name old_designate_factory,
       sp_b.supplier_company_name new_designate_factory,
       decode(t.operator,''SUPP'',''供应商'',''NEED'',''采购方'',NULL) operator,
       nvl(su.nick_name,su.username) operate_person,
       t.operate_time,
       t.order_id,
       t.company_id
  FROM scmdata.t_order_log t
  LEFT JOIN scmdata.t_supplier_info sp_a
    ON t.company_id = sp_a.company_id
   AND t.old_designate_factory = sp_a.supplier_code
  LEFT JOIN scmdata.t_supplier_info sp_b
    ON t.company_id = sp_b.company_id
   AND t.new_designate_factory = sp_b.supplier_code
  LEFT JOIN scmdata.sys_user su ON t.operate_person = su.user_id
 WHERE t.order_id = :order_id
 ORDER BY t.operate_time DESC';
    IF p_item_id = 'a_order_201_3' THEN
      RETURN v_sql;
    ELSE
      NULL;
    END IF;
  END f_query_order_log;
  --指定工厂  记录操作日志
  PROCEDURE p_insert_order_log(p_company_id            VARCHAR2,
                               p_order_id              VARCHAR2,
                               p_log_type              VARCHAR2,
                               p_old_designate_factory VARCHAR2,
                               p_new_designate_factory VARCHAR2,
                               p_operator              VARCHAR2,
                               p_operate_person        VARCHAR2) IS
  BEGIN
    INSERT INTO scmdata.t_order_log
    VALUES
      (scmdata.f_get_uuid(),
       p_log_type,
       p_old_designate_factory,
       p_new_designate_factory,
       p_operator,
       p_operate_person,
       SYSDATE,
       p_order_id,
       p_company_id);
  END p_insert_order_log;

  --生产进度填报  未完成：a_product_210
  FUNCTION f_query_order_progress_list(p_item_id VARCHAR2,
                                       p_where   VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    --czh add 20211209_v0
    v_sql := q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status progress_status_pr,
       t.product_gress_code product_gress_code_pr,
       decode(t.progress_status,
              '02',
              pno.pno_status,
              '00',
              gd_b.group_dict_name) progress_status_desc,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       d.company_name customer,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       listagg(cu.nick_name, ';') over(PARTITION BY oh.order_id) deal_follower,
       oh.delivery_date delivery_date_pr, --update by czh 20210527（1）生产进度表中的订单交期取下单列表的订单交期（即熊猫的交期日期）
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - oh.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - oh.delivery_date)) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --update by czh 20210527（2）生产进度表中的”最新计划完成日期“字段名更改为“最新计划交期”，取下单列表中的最新计划交期（即熊猫的新交货日期）
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       t.approve_edition, --Edit by zc
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
       gd_d.group_dict_name handle_opinions_pr,
       t.goo_id goo_id_pr, --这里goo_id是货号
       decode(oh.send_by_sup, 1, '是', '否') send_by_sup,
       oh.create_time create_time_po,
       oh.memo memo_po,
       a.group_dict_name category,
       b.group_dict_name cooperation_product_cate_sp,
       c.company_dict_name product_subclass_desc,
       oh.finish_time
  FROM scmdata.t_ordered oh
 INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
               FROM scmdata.t_supplier_info b
              INNER JOIN scmdata.sys_company c
                 ON b.company_id = c.company_id
              WHERE b.supplier_company_id = %default_company_id%) d
    ON oh.company_id = d.company_id
   AND oh.supplier_code = d.supplier_code
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
  AND oh.order_status = 'OS01'
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> '01'
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
   ]' || p_where || q'[
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = 'PRODUCT_TYPE'
   AND a.group_dict_value = cf.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = cf.samll_category
   AND c.company_id = cf.company_id
  LEFT JOIN (SELECT pno_status, product_gress_id, company_id
               FROM (SELECT row_number() over(PARTITION BY pn.product_gress_id ORDER BY pn.node_num DESC) rn,
                            pn.node_name || gd_a.group_dict_name pno_status,
                            pn.product_gress_id,
                            pn.company_id
                       FROM scmdata.t_production_node pn
                      INNER JOIN group_dict gd_a
                         ON gd_a.group_dict_type = 'PROGRESS_NODE_TYPE'
                        AND gd_a.group_dict_value = pn.progress_status
                      WHERE pn.progress_status IS NOT NULL)
              WHERE rn = 1) pno
    ON pno.product_gress_id = t.product_gress_id
   AND pno.company_id = t.company_id
  LEFT JOIN group_dict gd_b
    ON gd_b.group_dict_type = 'PROGRESS_TYPE'
   AND gd_b.group_dict_value = t.progress_status
  LEFT JOIN group_dict gd_d
    ON gd_d.group_dict_type = 'HANDLE_RESULT'
   AND gd_d.group_dict_value = t.handle_opinions
  LEFT JOIN sys_company_user cu
    ON oh.company_id = cu.company_id
   AND instr(oh.deal_follower, cu.user_id) > 0
 WHERE ((%is_company_admin%) = 1 OR
       instr_priv(p_str1  => @subsql@,
                   p_str2  => cf.category,
                   p_split => ';') > 0)
 ORDER BY t.product_gress_code DESC, t.create_time DESC
]';
    IF p_item_id = 'a_product_210' THEN
      RETURN v_sql;
    ELSE
      NULL;
    END IF;
  END f_query_order_progress_list;

  --生产进度填报  已完成：a_product_216
  FUNCTION f_query_order_progressed_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    --czh add 20211209_v0
    v_sql := q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.progress_status progress_status_pr,
       t.product_gress_code product_gress_code_pr,
       a.group_dict_name progress_status_desc,
       t.order_id order_id_pr,
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       oh.delivery_date delivery_date_pr,
       oh.finish_time_scm finish_time_scm_pr,
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - oh.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - oh.delivery_date)) forecast_delay_day_pr,
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       decode(sign(t.order_amount - t.delivery_amount),
              -1,
              0,
              t.order_amount - t.delivery_amount) owe_amount_pr,
       t.approve_edition,
       cf.is_set_fabric,
       t.fabric_check fabric_check,
       t.check_link,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
       gd.group_dict_name handle_opinions_pr,
       t.goo_id goo_id_pr,
       oh.create_time create_time_po,
       oh.memo memo_po,
       c.group_dict_name category,
       d.group_dict_name cooperation_product_cate_sp,
       e.company_dict_name product_subclass_desc,
       oh.finish_time
  FROM scmdata.t_ordered oh
 INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
               FROM scmdata.t_supplier_info b
              INNER JOIN scmdata.sys_company c
                 ON b.company_id = c.company_id
              WHERE b.supplier_company_id = %default_company_id%) d
    ON oh.company_id = d.company_id
   AND oh.supplier_code = d.supplier_code
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status IN ('OS01', 'OS02')
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status = '01'
 INNER JOIN group_dict a
    ON a.group_dict_value = t.progress_status
 INNER JOIN group_dict b
    ON b.group_dict_value = a.group_dict_type
   AND b.group_dict_value = 'PROGRESS_TYPE'
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
  LEFT JOIN group_dict c
    ON c.group_dict_type = 'PRODUCT_TYPE'
   AND c.group_dict_value = cf.category
  LEFT JOIN group_dict d
    ON d.group_dict_type = c.group_dict_value
   AND d.group_dict_value = cf.product_cate
  LEFT JOIN scmdata.sys_company_dict e
    ON e.company_dict_type = d.group_dict_value
   AND e.company_dict_value = cf.samll_category
   AND e.company_id = cf.company_id
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = 'HANDLE_RESULT'
   AND gd.group_dict_value = t.handle_opinions
 WHERE ((%is_company_admin%) = 1 OR
       instr(%coop_class_priv%, cf.category) > 0)
 ORDER BY t.product_gress_code DESC, oh.finish_time_scm DESC
]';
    IF p_item_id = 'a_product_216' THEN
      RETURN v_sql;
    ELSE
      NULL;
    END IF;
  END f_query_order_progressed_list;

  --节点进度 ：a_product_211
  FUNCTION f_query_progress_node_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    --czh add 20211209_v0
    v_sql := q'[WITH group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_node_id,
       t.company_id,
       t.product_gress_id,
       pp.progress_status       progress_status_pr,
       t.product_node_code,
       t.node_num,
       t.node_name              node_name_pr,
       t.target_completion_time target_completion_time_pr,
       t.plan_completion_time   plan_completion_time_pr,
       t.actual_completion_time actual_completion_time_pr,
       t.complete_amount        complete_amount_pr,
       t.progress_status        product_node_status_pr,
       a.group_dict_name        product_node_status,
       t.progress_say           progress_say_pr,
       t.operator,
       b.nick_name              update_id_pr,
       t.update_date            update_date_pr
  FROM scmdata.t_production_progress pp
 INNER JOIN scmdata.t_production_node t
    ON pp.product_gress_id = t.product_gress_id
  LEFT JOIN sys_user b
    ON b.user_id = t.update_id
  LEFT JOIN group_dict a
    ON a.group_dict_type = 'PROGRESS_NODE_TYPE'
   AND a.group_dict_value = t.progress_status
 WHERE pp.product_gress_id = :product_gress_id
 ORDER BY t.node_num ASC
]';
    IF p_item_id = 'a_product_211' THEN
      RETURN v_sql;
    ELSE
      NULL;
    END IF;
  END f_query_progress_node_list;
  --新增节点进度（临时）
  PROCEDURE p_insert_node_tmp(p_tmp_rec scmdata.t_node_tmp%ROWTYPE) IS
  BEGIN
    INSERT INTO scmdata.t_node_tmp
    VALUES
      (p_tmp_rec.node_tmp_id,
       p_tmp_rec.company_id,
       p_tmp_rec.order_company_id,
       p_tmp_rec.product_gress_code,
       p_tmp_rec.plan_completion_time,
       p_tmp_rec.actual_completion_time,
       p_tmp_rec.complete_amount,
       p_tmp_rec.progress_status,
       p_tmp_rec.progress_say,
       p_tmp_rec.operator,
       p_tmp_rec.update_id,
       p_tmp_rec.update_date,
       p_tmp_rec.create_id,
       p_tmp_rec.create_time,
       p_tmp_rec.memo,
       p_tmp_rec.node_name,
       p_tmp_rec.node_num);
  END p_insert_node_tmp;
  --修改节点进度（临时）
  PROCEDURE p_update_node_tmp(p_tmp_rec scmdata.t_node_tmp%ROWTYPE) IS
  BEGIN
    UPDATE t_node_tmp t
       SET t.product_gress_code     = p_tmp_rec.product_gress_code,
           t.plan_completion_time   = p_tmp_rec.plan_completion_time,
           t.actual_completion_time = p_tmp_rec.actual_completion_time,
           t.complete_amount        = p_tmp_rec.complete_amount,
           t.progress_status        = p_tmp_rec.progress_status,
           t.progress_say           = p_tmp_rec.progress_say,
           t.operator               = p_tmp_rec.operator,
           t.update_id              = p_tmp_rec.update_id,
           t.update_date            = p_tmp_rec.update_date,
           t.memo                   = p_tmp_rec.memo
     WHERE t.node_tmp_id = p_tmp_rec.node_tmp_id
       AND t.company_id = p_tmp_rec.company_id;
  END p_update_node_tmp;

END pkg_supp_order_coor;
/
