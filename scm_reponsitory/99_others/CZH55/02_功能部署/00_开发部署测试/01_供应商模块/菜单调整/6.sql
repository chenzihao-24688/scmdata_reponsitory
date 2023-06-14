???prompt Importing table nbw.sys_cond_list...
set feedback off
set define off
insert into nbw.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_200', 'select pkg_plat_comm.F_USERHASACTION_APP_SEE(%Current_UserID%,%Default_Company_ID%,''apply_16'') from dual', 0, null, 'oracle_scmdata', null, null);

prompt Done.
