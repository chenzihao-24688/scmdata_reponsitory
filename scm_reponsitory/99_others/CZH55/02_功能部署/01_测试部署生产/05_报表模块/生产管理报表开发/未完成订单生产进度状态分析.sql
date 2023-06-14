--未完成订单生产进度状态分析
SELECT gv.*
  FROM (SELECT DISTINCT v.category,
                        v.category_name,
                        v.deal_follower_name,
                        COUNT(DISTINCT v.goo_id) over(PARTITION BY v.category_name, v.deal_follower_name) owe_goo_cnt,
                        SUM(owe_amount) over(PARTITION BY v.category_name, v.deal_follower_name) owe_amount,
                        COUNT(CASE
                                WHEN v.finish_time IS NOT NULL AND
                                     v.finish_time_scm IS NULL THEN
                                 v.order_code
                                ELSE
                                 NULL
                              END) over(PARTITION BY v.category_name, v.deal_follower_name) pd_finish_cnt,
                        v.progress_status_desc,
                        COUNT(v.order_code) over(PARTITION BY v.category_name, v.deal_follower_name, v.progress_status_desc) pst_cnt
          FROM (SELECT po.order_code,
                       tc.category,
                       a.group_dict_name category_name,
                       (SELECT listagg(fu.company_user_name, ';')
                          FROM scmdata.sys_company_user fu
                         WHERE instr(po.deal_follower, fu.user_id) > 0
                           AND fu.company_id = po.company_id) deal_follower_name,
                       c.company_dict_name product_subclass_name,
                       sp.supplier_code,
                       sp.supplier_company_name,
                       pr.goo_id,
                       decode(sign(pr.order_amount - pr.delivery_amount),
                              -1,
                              0,
                              pr.order_amount - pr.delivery_amount) owe_amount,
                       decode(pr.progress_status,
                              '02',
                              pno.pno_status,
                              '00',
                              gd_b.group_dict_name) progress_status_desc,
                       po.finish_time,
                       po.finish_time_scm,
                       pno.node_num
                  FROM scmdata.t_ordered po
                 INNER JOIN scmdata.t_orders ln
                    ON ln.order_id = po.order_code
                   AND ln.company_id = po.company_id
                 INNER JOIN scmdata.t_production_progress pr
                    ON pr.goo_id = ln.goo_id
                   AND pr.order_id = ln.order_id
                   AND pr.company_id = ln.company_id
                  LEFT JOIN (SELECT pno_status, product_gress_id, node_num
                              FROM (SELECT row_number() over(PARTITION BY pn.product_gress_id ORDER BY pn.node_num DESC) rn,
                                           pn.node_name ||
                                           gd_a.group_dict_name pno_status,
                                           pn.product_gress_id,
                                           pn.node_num
                                      FROM scmdata.t_production_node pn
                                     INNER JOIN scmdata.sys_group_dict gd_a
                                        ON gd_a.group_dict_type =
                                           'PROGRESS_NODE_TYPE'
                                       AND gd_a.group_dict_value =
                                           pn.progress_status
                                     WHERE pn.company_id =
                                           'a972dd1ffe3b3a10e0533c281cac8fd7'
                                       AND pn.progress_status IS NOT NULL)
                             WHERE rn = 1) pno
                    ON pno.product_gress_id = pr.product_gress_id
                  LEFT JOIN scmdata.sys_group_dict gd_b
                    ON gd_b.group_dict_type = 'PROGRESS_TYPE'
                   AND gd_b.group_dict_value = pr.progress_status
                  LEFT JOIN scmdata.t_supplier_info sp
                    ON sp.supplier_code = pr.supplier_code
                   AND sp.company_id = pr.company_id
                 INNER JOIN scmdata.t_commodity_info tc
                    ON pr.goo_id = tc.goo_id
                   AND pr.company_id = tc.company_id
                  LEFT JOIN scmdata.sys_group_dict a
                    ON a.group_dict_type = 'PRODUCT_TYPE'
                   AND a.group_dict_value = tc.category
                  LEFT JOIN scmdata.sys_group_dict b
                    ON b.group_dict_type = a.group_dict_value
                   AND b.group_dict_value = tc.product_cate
                  LEFT JOIN scmdata.sys_company_dict c
                    ON c.company_dict_type = b.group_dict_value
                   AND c.company_dict_value = tc.samll_category
                   AND c.company_id = tc.company_id
                 WHERE po.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
                   AND po.order_status <> 'OS02'
                   /*AND tc.category = '01'*/) v) gv
  LEFT JOIN scmdata.t_product_status_seq sq
    ON sq.category = gv.category
   AND sq.node_name = gv.progress_status_desc
 ORDER BY sq.node_num ASC;
