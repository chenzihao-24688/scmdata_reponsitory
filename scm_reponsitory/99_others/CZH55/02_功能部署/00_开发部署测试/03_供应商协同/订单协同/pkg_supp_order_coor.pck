CREATE OR REPLACE PACKAGE pkg_supp_order_coor IS

  -- Author  : SANFU
  -- Created : 2021/12/9 14:18:42
  -- Purpose : 供应商-订单协同

  FUNCTION f_query_order_list(p_item_id VARCHAR2) RETURN CLOB;
  --订单数量明细
  FUNCTION f_query_ordernums_list RETURN CLOB;
  --指定工厂  记录操作日志
  PROCEDURE p_insert_order_log(p_log_type              VARCHAR2,
                               p_old_designate_factory VARCHAR2,
                               p_new_designate_factory VARCHAR2,
                               p_operator              VARCHAR2,
                               p_operate_person        VARCHAR2);

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
           z.delivery_date,
           MAX(y.delivery_date) over(PARTITION BY y.order_id, y.company_id) latest_delivery_date,
           y.order_amount,
           y.order_price single_price,
           y.order_price * y.order_amount order_sum,
           z.memo,
           gd_b.group_dict_name order_type,
           x.style_name,
           x.goo_name,
           gd_c.group_dict_name category,
           gd_d.group_dict_name product_cate,
           cd_a.company_dict_name samll_category_gd,
           /*(SELECT listagg(company_user_name, ',')
              FROM scmdata.sys_company_user
             WHERE inner_user_id = z.send_order
               AND company_id = z.company_id) send_order,*/
           z.deal_follower,
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
             INNER JOIN (SELECT b.company_id, c.company_name, b.supplier_code
                          FROM scmdata.t_supplier_info b
                         INNER JOIN scmdata.sys_company c
                            ON b.company_id = c.company_id
                         WHERE b.supplier_company_id = %default_company_id%) d
                ON a.company_id = d.company_id
               AND a.supplier_code = d.supplier_code]' || CASE
               WHEN p_item_id = 'a_order_201_0' THEN
                q'[ AND a.order_status IN ('OS01', 'OS00')]'
               WHEN p_item_id = 'a_order_201_1' THEN
                q'[ AND a.order_status IN ('OS02', 'OS03')]'
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
  
    RETURN v_sql;
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
  --指定工厂  记录操作日志
  PROCEDURE p_insert_order_log(p_log_type              VARCHAR2,
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
       SYSDATE);
  END p_insert_order_log;

END pkg_supp_order_coor;
/
