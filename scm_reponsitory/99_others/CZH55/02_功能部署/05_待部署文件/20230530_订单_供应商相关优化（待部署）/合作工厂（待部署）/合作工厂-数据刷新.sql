DECLARE
  v_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
  v_supp_id    VARCHAR2(32);
BEGIN
  FOR rec IN (SELECT *
                FROM scmdata.sys_company_user_temp a
               WHERE a.user_id =
                     (SELECT user_id
                        FROM scmdata.sys_user u
                       WHERE u.user_account = '18172543571')) LOOP
  
    SELECT MAX(t.supplier_info_id)
      INTO v_supp_id
      FROM scmdata.t_supplier_info t
     WHERE t.company_id = v_company_id
       AND t.supplier_code = rec.user_name;
  
    UPDATE scmdata.t_supplier_info t
       SET t.is_our_factory = rec.phone,
           t.update_id      = 'ADMIN',
           t.update_date    = SYSDATE
     WHERE t.supplier_info_id = v_supp_id;
  
    scmdata.pkg_supplier_info_a.p_generate_t_coop_factory_by_iu(p_company_id => v_company_id,
                                                                p_supp_id    => v_supp_id,
                                                                p_user_id    => 'ADMIN');
  END LOOP;
END;
/
