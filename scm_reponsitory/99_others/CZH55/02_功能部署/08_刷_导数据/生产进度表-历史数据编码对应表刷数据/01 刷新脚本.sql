BEGIN
  FOR rc IN (SELECT v.company_id, v.product_gress_code, pt.col_3
               FROM (SELECT t.company_id,
                            t.product_gress_code,
                            pno.pno_status       progress_status_desc,
                            cf.category,
                            a.group_dict_name    cate_name
                       FROM scmdata.t_production_progress t
                      INNER JOIN scmdata.t_commodity_info cf
                         ON t.company_id = cf.company_id
                        AND t.goo_id = cf.goo_id
                       LEFT JOIN (SELECT pno_status, product_gress_id
                                   FROM (SELECT row_number() over(PARTITION BY pn.product_gress_id ORDER BY pn.node_num DESC) rn,
                                                pn.node_name ||
                                                gd_a.group_dict_name pno_status,
                                                pn.product_gress_id
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
                         ON pno.product_gress_id = t.product_gress_id
                       LEFT JOIN scmdata.sys_group_dict gd_b
                         ON gd_b.group_dict_type = 'PROGRESS_TYPE'
                        AND gd_b.group_dict_value = t.progress_status
                       LEFT JOIN scmdata.sys_group_dict a
                         ON a.group_dict_type = 'PRODUCT_TYPE'
                        AND a.group_dict_value = cf.category
                      WHERE t.progress_status = '02'
                        AND t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
                        AND cf.category NOT IN ('07', '06')) v
               LEFT JOIN scmdata.t_excel_import pt
                 ON v.cate_name = pt.col_1
                AND v.progress_status_desc = pt.col_2) LOOP
    UPDATE scmdata.t_production_progress t
       SET t.progress_status = rc.col_3
     WHERE t.product_gress_code = rc.product_gress_code
       AND t.company_id = rc.company_id;
  END LOOP;
END;
