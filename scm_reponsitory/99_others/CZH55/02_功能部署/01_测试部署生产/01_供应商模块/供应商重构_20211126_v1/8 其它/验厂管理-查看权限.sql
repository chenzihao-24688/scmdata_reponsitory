--验厂管理-查看权限
declare
v_sql clob;
begin
  v_sql := q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0020306') as flag from dual ]';
update bw3.sys_cond_list t  set t.cond_sql = v_sql where t.cond_id = 'cond_a_check_103_auto';
end;
