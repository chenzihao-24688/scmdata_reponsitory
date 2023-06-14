BEGIN
UPDATE scmdata.t_supplier_info t SET t.group_name = NULL,t.group_name_origin = NULL WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
END;
/
BEGIN
  FOR sup_rec IN (SELECT t.company_province,
                         t.company_city,
                         vc.coop_classification,
                         vc.coop_product_cate,
                         t.supplier_info_id,
                         t.company_id,
                         t.pause
                    FROM scmdata.t_supplier_info t
                   INNER JOIN (SELECT *
                                FROM (SELECT tc.coop_classification,
                                             tc.coop_product_cate,
                                             row_number() over(PARTITION BY tc.supplier_info_id, tc.company_id ORDER BY tc.create_time DESC) rn,
                                             tc.supplier_info_id,
                                             tc.company_id
                                        FROM scmdata.t_coop_scope tc
                                       WHERE tc.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
                               WHERE rn = 1) vc
                      ON vc.supplier_info_id = t.supplier_info_id
                     AND vc.company_id = t.company_id
                   WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
                   AND t.group_name IS NULL) LOOP
  
    scmdata.pkg_supplier_info.p_update_group_name(p_company_id       => sup_rec.company_id,
                                                  p_supplier_info_id => sup_rec.supplier_info_id,
                                                  p_is_trigger       => 1,
                                                  p_pause            => 1,
                                                  p_is_by_pick       => 1,
                                                  p_is_create_sup    => 1,
                                                  p_province         => sup_rec.company_province,
                                                  p_city             => sup_rec.company_city);
  END LOOP;
END;
/
BEGIN
  FOR sup_rec IN (SELECT *
                    FROM (SELECT t.supplier_code,
                                 t.group_name      group_config_id,
                                 a.group_name,
                                 p.col_2           group_name_e,
                                 b.group_config_id group_config_id_e,
                                 t.company_id
                            FROM scmdata.t_excel_import p
                            LEFT JOIN scmdata.t_supplier_group_config b
                              ON b.group_name = p.col_2
                            LEFT JOIN scmdata.t_supplier_info t
                              ON t.supplier_code = p.col_1
                              AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
                            LEFT JOIN scmdata.t_supplier_group_config a
                              ON a.group_config_id = t.group_name
                             AND a.company_id = t.company_id) v
                   WHERE v.group_name <> v.group_name_e) LOOP
    UPDATE scmdata.t_supplier_info t
       SET t.group_name        = sup_rec.group_config_id_e,
           t.group_name_origin = 'AA',
           t.update_id         = 'ADMIN',
           t.update_date       = SYSDATE
     WHERE t.supplier_code = sup_rec.supplier_code
       AND t.company_id = sup_rec.company_id;
  END LOOP;
END;
/

