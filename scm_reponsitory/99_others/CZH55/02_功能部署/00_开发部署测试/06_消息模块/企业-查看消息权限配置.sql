BEGIN
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_c_2300', 'select max(1) flag from dual where SCMDATA.pkg_plat_comm.F_UserHasAction(%user_id%,%default_company_id% ,''78'',''G'')=1', null, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_c_2300', 14, 'c_2300', 0, null, 0, null);

END;
