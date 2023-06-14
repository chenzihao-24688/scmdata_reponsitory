begin
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090109', 'tab-可结束生产进度表', 'P00901', 0, null, null, null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('06-04-2022 10:42:45', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('06-04-2022 10:42:45', 'dd-mm-yyyy hh24:mi:ss'), null, 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P009010901', '查看', 'P0090109', 0, 14, 'a_report_order_100', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('06-04-2022 10:43:45', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('06-04-2022 10:43:45', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_order_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P009010902', '导出', 'P0090109', 0, 98, '9', 'a_report_order_100', 'bfff0ebdd2e22b0be0550250568762e1', to_date('06-04-2022 10:44:01', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('06-04-2022 10:44:01', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_119', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01311', '交期', 'P013', 0, 0, 'node_a_report_delivery_100', null, 'CZH', to_date('06-04-2022 09:36:56', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:36:56', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_delivery_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0131101', '未完成订单延期情况', 'P01311', 0, 0, 'node_a_report_delivery_101_1', null, 'CZH', to_date('06-04-2022 09:39:10', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:39:10', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_delivery_101_1_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013110101', '查看', 'P0131101', 0, 14, 'a_report_delivery_101_1', null, 'CZH', to_date('06-04-2022 09:52:00', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:52:00', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_delivery_101_1_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013110102', '导出', 'P0131101', 0, 98, '9', 'a_report_delivery_101_1', 'CZH', to_date('06-04-2022 09:52:26', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:52:26', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_192', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0131102', '未完成订单生产进度状态分析', 'P01311', 0, 0, 'node_a_report_prostatus_100', null, 'CZH', to_date('06-04-2022 09:39:53', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:39:53', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_prostatus_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013110201', '查看', 'P0131102', 0, 14, 'a_report_prostatus_100', null, 'CZH', to_date('06-04-2022 09:53:38', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:53:38', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_prostatus_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013110202', '导出', 'P0131102', 0, 98, '9', 'a_report_prostatus_100', 'CZH', to_date('06-04-2022 09:55:15', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:55:15', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_193', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0131103', '订单满足率异常分析', 'P01311', 0, 0, 'node_a_report_abn_200', null, 'CZH', to_date('06-04-2022 09:40:20', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:40:20', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_abn_200_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013110301', '查看', 'P0131103', 0, 14, 'a_report_abn_200', null, 'CZH', to_date('06-04-2022 09:55:41', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:55:41', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_abn_200_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013110302', '导出', 'P0131103', 0, 98, '9', 'a_report_abn_200', 'CZH', to_date('06-04-2022 09:56:15', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:56:15', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_194', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013110303', '异常分布', 'P0131103', 0, 0, 'node_a_report_abn_202', null, 'CZH', to_date('06-04-2022 10:28:05', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:28:05', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_abn_202_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01311030301', '查看', 'P013110303', 0, 14, 'a_report_abn_202', null, 'CZH', to_date('06-04-2022 10:29:28', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:29:28', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_abn_202_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01311030302', '导出', 'P013110303', 0, 98, '9', 'a_report_abn_202', 'CZH', to_date('06-04-2022 10:29:39', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:29:39', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_196', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013110304', '异常原因', 'P0131103', 0, 0, 'node_a_report_abn_201', null, 'CZH', to_date('06-04-2022 10:28:40', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:28:40', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_abn_201_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01311030401', '查看', 'P013110304', 0, 14, 'a_report_abn_201', null, 'CZH', to_date('06-04-2022 10:29:59', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:29:59', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_abn_201_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01311030402', '导出', 'P013110304', 0, 98, '9', 'a_report_abn_201', 'CZH', to_date('06-04-2022 10:30:13', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:30:13', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_197', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01312', '质量', 'P013', 0, 0, 'node_a_report_quality_100', null, 'CZH', to_date('06-04-2022 09:37:15', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:37:15', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_quality_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0131201', '异常处理分析', 'P01312', 0, 0, 'node_a_report_abn_100', null, 'CZH', to_date('06-04-2022 09:43:19', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:43:19', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_abn_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013120101', '查看', 'P0131201', 0, 14, 'a_report_abn_100', null, 'CZH', to_date('06-04-2022 10:00:23', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:00:23', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_abn_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013120102', '导出', 'P0131201', 0, 98, '9', 'a_report_abn_100', 'CZH', to_date('06-04-2022 10:00:40', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:00:40', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_195', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013120103', '异常分布', 'P0131201', 0, 0, 'node_a_report_abn_102', null, 'CZH', to_date('06-04-2022 10:33:03', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:33:03', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_abn_102_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01312010301', '查看', 'P013120103', 0, 14, 'a_report_abn_102', null, 'CZH', to_date('06-04-2022 10:33:17', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:33:17', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_abn_102_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01312010302', '导出', 'P013120103', 0, 98, '9', 'a_report_abn_102', 'CZH', to_date('06-04-2022 10:33:32', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:33:32', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_198', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013120104', '异常细分', 'P0131201', 0, 0, 'node_a_report_abn_101', null, 'CZH', to_date('06-04-2022 10:34:24', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:34:24', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_abn_101_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01312010401', '查看', 'P013120104', 0, 14, 'a_report_abn_101', null, 'CZH', to_date('06-04-2022 10:34:40', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:34:40', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_abn_101_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P01312010402', '导出', 'P013120104', 0, 98, '9', 'a_report_abn_101', 'CZH', to_date('06-04-2022 10:34:50', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 10:34:50', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_199', 1);

end;
/
begin
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_119', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P009010902'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_192', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013110102'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_193', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013110202'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_194', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013110302'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_195', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013120102'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_196', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01311030302'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_197', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01311030402'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_198', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01312010302'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_199', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01312010402'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_abn_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013120101'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_abn_101_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01312010401'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_abn_102_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01312010301'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_abn_200_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013110301'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_abn_201_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01311030401'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_abn_202_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01311030301'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_delivery_101_1_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013110101'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_order_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P009010901'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_prostatus_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013110201'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_abn_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0131201'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_abn_101_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013120104'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_abn_102_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013120103'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_abn_200_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0131103'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_abn_201_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013110304'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_abn_202_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P013110303'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_delivery_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01311'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_delivery_101_1_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0131101'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_prostatus_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0131102'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_quality_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P01312'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

end;
/
begin
insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_119', 98, '9', 0, 1, 0, 'a_report_order_100');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_192', 98, '9', 0, 1, 0, 'a_report_delivery_101_1');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_193', 98, '9', 0, 1, 0, 'a_report_prostatus_100');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_194', 98, '9', 0, 1, 0, 'a_report_abn_200');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_195', 98, '9', 0, 1, 0, 'a_report_abn_100');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_196', 98, '9', 0, 1, 0, 'a_report_abn_202');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_197', 98, '9', 0, 1, 0, 'a_report_abn_201');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_198', 98, '9', 0, 1, 0, 'a_report_abn_102');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_199', 98, '9', 0, 1, 0, 'a_report_abn_101');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_abn_100_auto', 14, 'a_report_abn_100', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_abn_101_auto', 14, 'a_report_abn_101', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_abn_102_auto', 14, 'a_report_abn_102', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_abn_200_auto', 14, 'a_report_abn_200', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_abn_201_auto', 14, 'a_report_abn_201', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_abn_202_auto', 14, 'a_report_abn_202', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_delivery_101_1_auto', 14, 'a_report_delivery_101_1', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_order_100_auto', 14, 'a_report_order_100', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_prostatus_100_auto', 14, 'a_report_prostatus_100', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_abn_200_auto', 0, 'node_a_report_abn_200', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_abn_100_auto', 0, 'node_a_report_abn_100', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_abn_101_auto', 0, 'node_a_report_abn_101', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_abn_102_auto', 0, 'node_a_report_abn_102', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_abn_201_auto', 0, 'node_a_report_abn_201', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_abn_202_auto', 0, 'node_a_report_abn_202', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_delivery_100_auto', 0, 'node_a_report_delivery_100', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_delivery_101_1_auto', 0, 'node_a_report_delivery_101_1', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_prostatus_100_auto', 0, 'node_a_report_prostatus_100', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_quality_100_auto', 0, 'node_a_report_quality_100', 0, 1, 0, null);

end;
