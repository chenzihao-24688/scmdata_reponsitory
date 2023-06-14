
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'call scmdata.sf_import_company_users_pkg.delete_sys_company_user_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)';
  UPDATE nbw.sys_action t
     SET t.action_sql = v_sql
   WHERE t.element_id = 'action_c_2051_1';
END;
