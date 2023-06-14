--企微消息配置
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('c_2300_3', 'manylist', '企微消息配置', 'oracle_scmdata', null, null, null, 'c_2300_3', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_c_2300_3', 'tree_c', 'c_2300_3', 'c_2300', null, 'scm', null, 1, null, 2, 0, null, null, null, 1, 1, null);
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('c_2300_3', null, null, null, null, null, ' ', null, null, null, ' ', null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

--个人推送配置
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('c_2300_4', 'list', '个人推送配置', 'oracle_scmdata', null, null, null, 'c_2300_4', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_c_2300_4', 'tree_c', 'c_2300_4', 'c_2300_3', null, 'scm', null, 1, null, 1, 0, null, null, null, 1, 1, null);
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('c_2300_4', 13, null, null, null, null, 'select t.sys_company_person_wecom_msg_id,
       t.company_id,
       a.pause,
       sg.apply_name,
       a.sys_group_wecom_msg_pattern_code,
       a.sys_group_wecom_msg_pattern_name,
       a.msg_pattern,
       t.target_user_id
  from scmdata.sys_group_wecom_msg_pattern a
 inner join scmdata.sys_company_person_wecom_msg t
    on a.sys_group_wecom_msg_pattern_id = t.sys_group_wecom_msg_pattern_id
 inner join scmdata.sys_group_apply sg
    on sg.apply_id = a.apply_id
   and sg.apply_status = ''0''
   and sg.system_id = ''SCM''
 where t.pause = 0
   and exists (select 1
          from scmdata.sys_company_apply_buylog
         where apply_id = a.apply_id
           and t.company_id = t.company_id)
   and t.company_id = %default_company_id%', null, null, null, 'update scmdata.sys_company_person_wecom_msg t
   set t.target_user_id = :target_user_id
 where t.sys_company_person_wecom_msg_id = :sys_company_person_wecom_msg_id ', null, 'sys_company_person_wecom_msg_id,company_id,target_user_id', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_web_union (item_id , union_item_id , seqno, pause)
values ('c_2300_3', 'c_2300_4', 1, 0);
insert into bw3.sys_web_union (item_id , union_item_id , seqno, pause)
values ('c_2300_3', 'c_2300_2', 2, 0);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_c_2300_4', 'lookup', 'oracle_scmdata', 0, null, 0, null, null, null, null);
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_c_2300_4', 'TARGET_USER_NAME', '
SELECT d.dept_name,
       B.AVATAR,
       A.Inner_User_Id TARGET_USER_ID,
       A.COMPANY_USER_NAME TARGET_USER_NAME
  FROM SYS_COMPANY_USER A
 INNER JOIN SYS_USER B
    ON A.USER_ID = B.USER_ID
  left join sys_company_user_dept c
    on a.user_id = c.user_id
   and a.company_id = c.company_id
  left join sys_company_dept d
    on c.company_dept_id = d.company_dept_id
   and c.company_id = d.company_id
 WHERE A.COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND A.PAUSE = 0
   AND B.PAUSE = 0', '1', 'TARGET_USER_ID', 'TARGET_USER_NAME', 'TARGET_USER_ID', 1, 1, null, 'DEPT_NAME', ';', 'AVATAR', null, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('c_2300_4', 'look_c_2300_4', 1, 0, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_g_531', 'lookup', 'oracle_scmdata', 0, null, 0, null, null, null, null);
insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_g_531', 'APPLY_NAME_N', 'select t.apply_id APPLY_ID_N, t.apply_name APPLY_NAME_N
  from sys_group_apply t
 where t.apply_status = ''0''
   and t.system_id = ''SCM''', '1', 'APPLY_ID_N', 'APPLY_NAME_N', 'APPLY_ID_N', 1, 0, null, null, null, null, null, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('g_531', 'look_g_531', 1, 0, null);

---字典
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('APPLY_NAME_N', '应用名称',0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('TARGET_USER_NAME', '默认发送用户', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

--机器人配置修改
update bw3.sys_item t set t.caption_sql = '机器人配置' where t.item_id = 'c_2300_2';
update bw3.sys_tree_list t set t.parent_id = 'c_2300_3' where t.node_id ='node_c_2300_2';
