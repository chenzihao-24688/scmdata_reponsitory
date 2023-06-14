DECLARE
  v_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  UPDATE scmdata.t_supplier_info t
     SET t.group_name  = NULL,
         t.update_id   = 'ADMIN',
         t.update_date = SYSDATE
   WHERE t.group_name_origin = 'AA'
     AND t.company_id = v_company_id;

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
                                       WHERE tc.company_id = v_company_id)
                               WHERE rn = 1) vc
                      ON vc.supplier_info_id = t.supplier_info_id
                     AND vc.company_id = t.company_id
                   WHERE t.company_id = v_company_id
                     AND t.group_name_origin = 'AA') LOOP
  
    scmdata.pkg_supplier_info.p_update_group_name(p_company_id       => sup_rec.company_id,
                                                  p_supplier_info_id => sup_rec.supplier_info_id,
                                                  p_is_trigger       => 0,
                                                  p_pause            => 1,
                                                  p_is_by_pick       => 1,
                                                  p_is_create_sup    => 1,
                                                  p_province         => sup_rec.company_province,
                                                  p_city             => sup_rec.company_city);
  END LOOP;
END;
