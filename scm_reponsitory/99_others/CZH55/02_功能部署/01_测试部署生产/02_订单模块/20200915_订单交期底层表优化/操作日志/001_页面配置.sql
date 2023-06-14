BEGIN
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_report_121', 'list', '操作日志', 'oracle_scmdata', null, null, null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 7, null, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_report_121', 'tree_a_report_1', 'a_report_121', null, null, 'scm', null, 0, null, 1, 0, null, null, null, 1, 1, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_report_121', 13, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id => :PT_ORDERED_ID,p_dict_type => ''PT_ORDERED_LOG'');
  @strresult := v_sql;
END;}', null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_report_120', 'associate', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_report_121', 'associate_a_report_120', 'PT_ORDERED_ID', 6, '操作日志', 'icon-kejian', 2, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_120', 'associate_a_report_120', 1, 1, null);
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_report_120_3', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_report_120_3', '查看日志', 'icon-morencaidan', 3, 'SELECT *
  FROM (SELECT a.group_dict_name log_type,
               decode(0,
                      1,
                      nvl(t.log_msg_f, t.log_msg),
                      0,
                      t.log_msg,
                      t.log_msg) log_msg,
               nvl(su.nick_name,
                   nvl(su.username,
                       nvl(u.nick_name,
                           nvl(u.company_user_name, su.user_account)))) operator_name,
               fu.logn_name operator,
               t.update_time operate_time
          FROM t_plat_log t
          LEFT JOIN scmdata.sys_group_dict a
            ON a.group_dict_type = ''PT_ORDERED_LOG''
           AND a.group_dict_value = t.log_type
          LEFT JOIN scmdata.sys_user su
            ON upper(su.user_id) = upper(t.operater)
          LEFT JOIN scmdata.sys_company_user u
            ON u.user_id = t.operater
           AND u.company_id = t.operate_company_id
          LEFT JOIN scmdata.sys_company fu
            ON fu.company_id = t.operate_company_id
         WHERE t.apply_pk_id = :pt_ordered_id) v
 WHERE v.operator_name <> ''系统管理员''
 ORDER BY v.operate_time DESC
 
/*
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id => :PT_ORDERED_ID,p_dict_type => ''PT_ORDERED_LOG'');
  @strresult := v_sql;
END;}*/', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, 1);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_report_120', 'action_a_report_120_3', 1, 0, null);

END;
/
