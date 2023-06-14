begin
update bw3.sys_item t set t.caption_sql = '生产进度' where t.item_id = 'a_product_100';
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_product_200', 'menu', '异常处理', 'oracle_scmdata', null, null, null, 'a_product_200', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);
insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_product_200', 'tree_a_product', 'a_product_200', 'menuroot', null, 'scm', 'icon-huiyiguanli01', 0, null, 20, 0, 0, null, null, 1, 1, null);

update bw3.sys_tree_list t set t.parent_id = 'a_product_100' where t.node_id = 'node_a_product_101';
update bw3.sys_tree_list t set t.parent_id = 'a_product_200' where t.node_id = 'node_a_product_120';
update bw3.sys_tree_list t set t.parent_id = 'a_product_200' where t.node_id = 'node_a_product_130';
update bw3.sys_tree_list t set t.parent_id = 'a_product_200' where t.node_id = 'node_a_product_140';
update bw3.sys_tree_list t set t.parent_id = 'a_product_100' where t.node_id = 'node_a_product_201';
end;
/
begin
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P015', '异常处理', 'root', 0, 0, 'node_a_product_200', null, 'CZH', to_date('09-02-2022 10:29:09', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('09-02-2022 10:29:09', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_200_auto', 0);
update scmdata.sys_app_privilege t set t.parent_priv_id = 'P015' where t.priv_id in ('P00902','P00903','P00905');
insert into scmdata.sys_group_apply (APPLY_ID, ICON, APPLY_NAME, TIPS, APPLY_STATUS, SORT, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, IS_COMPANY, APPLY_TYPE, ITEM_TYPE, PAUSE, IS_FREE, PRIV_ID, APPLY_BELONG)
values ('apply_16', 'a1a14e9d2dfd5fa9b1f59a6f48e3eeb1', '异常处理', '进行订单生产异常处理、扣款处理', '0', 16, 'admin', to_date('15-08-2020', 'dd-mm-yyyy'), 'admin', to_date('15-08-2020', 'dd-mm-yyyy'), 1, '企业应用', '平台应用', 0, 0, 'P015', 0);
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00906', '生产进度填报', 'P009', 0, 0, 'node_a_product_201', null, 'CZH', to_date('18-01-2022 14:06:19', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('18-01-2022 14:06:19', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_201_auto', 2);
end;
/
begin
/*
--暂时不用  供应商端 企业管理未开放应用管理  不能进行应用订阅
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_200', 'select pkg_plat_comm.F_USERHASACTION_APP_SEE(%Current_UserID%,%Default_Company_ID%,''apply_16'') from dual', 0, null, 'oracle_scmdata', null, null);
insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_200', 0, 'node_a_product_200', 0, 1, 0, null);
update bw3.sys_cond_rela t set t.pause = 1 where t.cond_id = 'cond_node_a_product_200';*/
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_200_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P015'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);
insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_200_auto', 0, 'node_a_product_200', 0, 1, 0, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_201_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00906'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);
insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_201_auto', 0, 'node_a_product_201', 0, 1, 0, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_140_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00905'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);
insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_140_auto', 0, 'node_a_product_140', 0, 1, 0, null);

end;
/
--节点进度隐藏用时占比，目标完成时间
begin
update bw3.sys_item_list t set t.noshow_fields = 'product_node_id,company_id,product_gress_id,product_node_code,node_num,product_node_status,progress_status_pr,time_ratio_pr,target_completion_time_pr' where t.item_id = 'a_product_111' ;
end;
