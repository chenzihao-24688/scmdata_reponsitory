begin
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID)
values ('P0130301', '订单交期数据表', 'P01303', 0, 0, 'node_a_report_120', null, 'CZH', to_date('11-10-2021 10:44:15', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-10-2021 10:44:15', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_120_auto');

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID)
values ('P013030101', '查看', 'P0130301', 0, 14, 'a_report_120', null, 'CZH', to_date('11-10-2021 10:44:31', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-10-2021 10:44:31', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_120_auto');

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID)
values ('P013030102', '导出', 'P0130301', 0, 98, '9', 'a_report_120', 'CZH', to_date('11-10-2021 10:45:09', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('11-10-2021 10:45:09', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_49');

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID)
values ('P01303', '底层数据报表', 'P013', 0, 0, 'node_a_report_110', null, 'admin', to_date('11-10-2021 10:43:04', 'dd-mm-yyyy hh24:mi:ss'), 'admin', to_date('11-10-2021 10:43:04', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_110_auto');

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_49', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013030102'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_120_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013030101'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_110_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01303'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_120_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0130301'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_49', 98, '9', 0, 1, 0, 'a_report_120');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_120_auto', 14, 'a_report_120', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_110_auto', 0, 'node_a_report_110', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_120_auto', 0, 'node_a_report_120', 0, 1, 0, null);

end;
