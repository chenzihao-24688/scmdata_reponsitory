SELECT *
  FROM (SELECT *
          FROM (SELECT gv.category,
                       gv.category_name,
                       gv.deal_follower_name,
                       gv.sup_cnt,
                       gv.owe_goo_cnt,
                       gv.owe_amount,
                       sq.progress_status_desc,
                       gv.pst_cnt,
                       sq.node_num
                  FROM (SELECT DISTINCT v.category,
                                        v.category_name,
                                        v.deal_follower_name,
                                        COUNT(DISTINCT v.supplier_code) over(PARTITION BY v.category_name, v.deal_follower_name) sup_cnt,
                                        COUNT(DISTINCT v.goo_id) over(PARTITION BY v.category_name, v.deal_follower_name) owe_goo_cnt,
                                        SUM(owe_amount) over(PARTITION BY v.category_name, v.deal_follower_name) owe_amount,
                                        COUNT(CASE
                                                WHEN v.finish_time IS NOT NULL AND
                                                     v.finish_time_scm IS NULL THEN
                                                 v.order_code
                                                ELSE
                                                 NULL
                                              END) over(PARTITION BY v.category_name, v.deal_follower_name) pd_finish_cnt,
                                        v.progress_status,
                                        COUNT(v.order_code) over(PARTITION BY v.category_name, v.deal_follower_name, v.progress_status) pst_cnt
                          FROM (SELECT *
                                  FROM (SELECT po.order_code,
                                               tc.category,
                                               a.group_dict_name category_name,
                                               (SELECT listagg(fu.company_user_name,
                                                               ';')
                                                  FROM scmdata.sys_company_user fu
                                                 WHERE instr(po.deal_follower,
                                                             fu.user_id) > 0
                                                   AND fu.company_id =
                                                       po.company_id) deal_follower_name,
                                               c.company_dict_name product_subclass_name,
                                               sp.supplier_code,
                                               sp.supplier_company_name,
                                               pr.goo_id,
                                               decode(sign(pr.order_amount -
                                                           pr.delivery_amount),
                                                      -1,
                                                      0,
                                                      pr.order_amount -
                                                      pr.delivery_amount) owe_amount,
                                               po.finish_time,
                                               po.finish_time_scm,
                                               MAX(ln.delivery_date) over(PARTITION BY ln.order_id) latest_planned_delivery_date_pr,
                                               po.order_status,
                                               po.company_id,
                                               pr.progress_status,
                                               po.is_product_order,
                                               po.create_time,
                                               po.delivery_date
                                          FROM scmdata.t_ordered po
                                         INNER JOIN scmdata.t_orders ln
                                            ON ln.order_id = po.order_code
                                           AND ln.company_id = po.company_id
                                         INNER JOIN scmdata.t_production_progress pr
                                            ON pr.goo_id = ln.goo_id
                                           AND pr.order_id = ln.order_id
                                           AND pr.company_id = ln.company_id
                                          LEFT JOIN scmdata.t_supplier_info sp
                                            ON sp.supplier_code =
                                               pr.supplier_code
                                           AND sp.company_id = pr.company_id
                                         INNER JOIN scmdata.t_commodity_info tc
                                            ON pr.goo_id = tc.goo_id
                                           AND pr.company_id = tc.company_id
                                          LEFT JOIN scmdata.sys_group_dict a
                                            ON a.group_dict_type =
                                               'PRODUCT_TYPE'
                                           AND a.group_dict_value = tc.category
                                          LEFT JOIN scmdata.sys_group_dict b
                                            ON b.group_dict_type =
                                               a.group_dict_value
                                           AND b.group_dict_value =
                                               tc.product_cate
                                          LEFT JOIN scmdata.sys_company_dict c
                                            ON c.company_dict_type =
                                               b.group_dict_value
                                           AND c.company_dict_value =
                                               tc.samll_category
                                           AND c.company_id = tc.company_id) zv
                                 WHERE zv.company_id =
                                       'b6cc680ad0f599cde0531164a8c0337f'
                                   AND zv.order_status <> 'OS02'
                                   AND zv.progress_status <> '01'
                                   AND zv.is_product_order = 1
                                   AND zv.finish_time IS NULL
                                   AND zv.category = '03'
                                   AND (('1') = 1 OR
                                       instr_priv(p_str1  => '00;01;03;06;07;08',
                                                   p_str2  => zv.category,
                                                   p_split => ';') > 0)
                                   AND 1 = 1
                                   AND 1 = 1
                                   AND 1 = 1) v) gv
                  LEFT JOIN scmdata.v_product_progress_status_seq sq
                    ON sq.progress_status = gv.progress_status))
 ORDER BY owe_amount DESC
