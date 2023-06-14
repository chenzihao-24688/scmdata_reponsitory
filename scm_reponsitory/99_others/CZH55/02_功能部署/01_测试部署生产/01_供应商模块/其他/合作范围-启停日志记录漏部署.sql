DECLARE
  v_action_sql CLOB;
BEGIN
  v_action_sql := q'[DECLARE
  v_coop_scope_id VARCHAR2(100);
BEGIN
  FOR a_rec IN (SELECT tc.supplier_info_id, tc.coop_scope_id
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (@selection)) LOOP
  
    v_coop_scope_id := a_rec.coop_scope_id;
    pkg_supplier_info.update_coop_scope_status(p_company_id       => %default_company_id%,
                                               p_user_id          => %user_id%,                     
                                               p_supplier_info_id => a_rec.supplier_info_id,
                                               p_coop_scope_id    => a_rec.coop_scope_id,
                                               p_status           => 1);
  
  END LOOP;

END;]';
  UPDATE bw3.sys_action t
     SET t.action_sql = v_action_sql
   WHERE t.element_id = 'action_a_supp_161_1_2';
END;
/
DECLARE
  v_action_sql CLOB;
BEGIN
  v_action_sql := q'[DECLARE
  v_coop_scope_id VARCHAR2(100);
BEGIN
  FOR a_rec IN (SELECT tc.supplier_info_id, tc.coop_scope_id
                  FROM scmdata.t_coop_scope tc
                 WHERE tc.coop_scope_id IN (@selection)) LOOP
  
    v_coop_scope_id := a_rec.coop_scope_id;
    pkg_supplier_info.update_coop_scope_status(p_company_id       => %default_company_id%,
                                               p_user_id          => %user_id%, 
                                               p_supplier_info_id => a_rec.supplier_info_id,
                                               p_coop_scope_id    => a_rec.coop_scope_id,
                                               p_status           => 0);
  
  END LOOP;

END;]';
  UPDATE bw3.sys_action t
     SET t.action_sql = v_action_sql
   WHERE t.element_id = 'action_a_supp_161_1_1';
END;
