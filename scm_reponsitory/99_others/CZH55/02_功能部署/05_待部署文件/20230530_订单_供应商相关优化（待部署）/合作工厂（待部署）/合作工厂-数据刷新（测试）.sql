DECLARE
  v_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  FOR rec IN (SELECT t.supplier_info_id, t.is_our_factory
                FROM scmdata.t_supplier_info t
               WHERE t.is_our_factory = 1) LOOP
  
    UPDATE scmdata.t_supplier_info t
       SET t.is_our_factory = 0,
           t.update_id      = 'ADMIN',
           t.update_date    = SYSDATE
     WHERE t.supplier_info_id = rec.supplier_info_id;
  
    scmdata.pkg_supplier_info_a.p_generate_t_coop_factory_by_iu(p_company_id => v_company_id,
                                                                p_supp_id    => rec.supplier_info_id,
                                                                p_user_id    => 'ADMIN');
  END LOOP;
END;
/
