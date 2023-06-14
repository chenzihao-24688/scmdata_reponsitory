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
