DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
  v_sql1 := q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0180103') as flag from dual]';
  UPDATE bw3.sys_cond_list t SET t.cond_sql = v_sql1 WHERE t.cond_id = 'cond_11_auto_27'; 
  v_sql2 := q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0030214') as flag from dual]';
  UPDATE bw3.sys_cond_list t SET t.cond_sql = v_sql2 WHERE t.cond_id= 'cond_a_supp_160_auto_1'; 
END;
/
