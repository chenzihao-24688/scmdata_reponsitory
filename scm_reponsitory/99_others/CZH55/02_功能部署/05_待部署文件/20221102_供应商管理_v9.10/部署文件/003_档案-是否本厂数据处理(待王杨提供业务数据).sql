BEGIN
  FOR rec IN (SELECT *
                FROM scmdata.t_supplier_info t
               WHERE t.is_our_factory IS NULL
                 AND t.status = 1) LOOP
  
    UPDATE scmdata.t_supplier_info t
       SET t.is_our_factory = 1
     WHERE t.supplier_code = rec.supplier_code
       AND t.company_id = rec.company_id;
  
    scmdata.pkg_supplier_info_a.p_generate_t_coop_factory_by_iu(p_company_id => rec.company_id,
                                                                p_supp_id    => rec.supplier_info_id,
                                                                p_user_id    => 'ADMIN');
  END LOOP;
END;
/
