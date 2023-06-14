DECLARE
v_action_sql clob;
BEGIN
  v_action_sql := 'CALL scmdata.sf_import_company_users_pkg.delete_sys_company_user_temp(%default_company_id%,%user_id%)';
  update nbw.sys_action t set t.action_sql = v_action_sql where t.element_id = 'action_c_2100_5';
END;
