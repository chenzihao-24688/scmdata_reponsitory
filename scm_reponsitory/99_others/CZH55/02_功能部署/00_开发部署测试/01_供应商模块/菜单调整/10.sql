???prompt Importing table nbw.sys_cond_list...
set feedback off
set define off
insert into nbw.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_140_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00905'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

prompt Done.
