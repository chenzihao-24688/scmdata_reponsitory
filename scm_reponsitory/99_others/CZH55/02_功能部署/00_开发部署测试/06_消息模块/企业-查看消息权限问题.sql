BEGIN

delete from   bw3.sys_cond_rela  t where t.cond_id = 'cond_c_2300';
delete from   bw3.sys_cond_list  t where t.cond_id = 'cond_c_2300';

insert into scmdata.sys_company_security (COMPANY_SECURITY_ID, SECURITY_NAME, SECURITY_CODE, I18N_KEY, TIPS, SORT, SECURITY_TYPE)
values ('100', '查看-消息管理', null, null, null, 100, 'C_9');

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_c_2300_2', 'select max(1) flag from dual where SCMDATA.pkg_plat_comm.F_UserHasAction(%user_id%,%default_company_id% ,''100'',''C'')=1', null, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_c_2300_2', 14, 'c_2300', 0, 0, 0, null);

END;
