BEGIN
  FOR pro_rec IN (SELECT t.product_gress_id, cf.category, pno.pno_status
                    FROM scmdata.t_production_progress t
                   INNER JOIN scmdata.t_commodity_info cf
                      ON t.company_id = cf.company_id
                     AND t.goo_id = cf.goo_id
                    LEFT JOIN (SELECT pno_status, product_gress_id
                                FROM (SELECT row_number() over(PARTITION BY pn.product_gress_id ORDER BY pn.node_num DESC) rn,
                                             pn.node_name pno_status,
                                             pn.product_gress_id
                                        FROM scmdata.t_production_node pn
                                       INNER JOIN sys_group_dict gd_a
                                          ON gd_a.group_dict_type =
                                             'PROGRESS_NODE_TYPE'
                                         AND gd_a.group_dict_value =
                                             pn.progress_status
                                       WHERE pn.company_id =
                                             'a972dd1ffe3b3a10e0533c281cac8fd7'
                                         AND pn.progress_status IS NOT NULL)
                               WHERE rn = 1) pno
                      ON pno.product_gress_id = t.product_gress_id
                   WHERE t.progress_status = '02') LOOP
    SELECT *
      FROM scmdata.v_product_progress_status pv
     WHERE pv.company_id = '';
  END LOOP;
END;
