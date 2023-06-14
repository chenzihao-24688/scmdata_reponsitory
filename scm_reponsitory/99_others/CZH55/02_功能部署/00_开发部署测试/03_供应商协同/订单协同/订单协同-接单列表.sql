begin
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_order_201', 'manylist', '接单列表', 'oracle_scmdata', 'SCMDATA.T_ORDERED', 'ORDER_ID', null, 'a_order_201', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_order_201_0', 'list', '未完成订单', 'oracle_scmdata', 'SCMDATA.T_ORDERED', 'ORDER_ID', null, 'a_order_201_0', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_order_201_1', 'list', '已完成订单', 'oracle_scmdata', 'SCMDATA.T_ORDERED', 'ORDER_ID', null, 'a_order_201_1', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_order_201_2', 'list', '订单数量明细', 'oracle_scmdata', null, null, null, 'a_order_201_2', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_order_201_3', 'list', '修改日志', 'oracle_scmdata', null, null, null, 'a_order_201_3', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_order_201', 'tree_a_order', 'a_order_201', 'a_order_100', null, 'scm', null, null, null, 2, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_order_201_0', 'tree_a_order', 'a_order_201_0', null, null, 'scm', null, null, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_order_201_1', 'tree_a_order', 'a_order_201_1', null, null, 'scm', null, null, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_order_201_2', 'tree_a_order', 'a_order_201_2', null, null, 'scm', null, null, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_order_201_3', 'tree_a_order', 'a_order_201_3', null, null, 'scm', null, null, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_order_201', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_order_201_0', 3, 'ORDER_CODE,RELA_GOO_ID,SUPPLIER,STYLE_NUMBER', null, null, null, '--czh add 20211209_v0
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_order_list(p_item_id => ''a_order_201_0''); 
  @strresult := v_sql;
END;}', null, null, null, 'DECLARE
  V_MEMO         VARCHAR2(512);
  V_FACTORY_CODE VARCHAR2(32);
  V_ORDER_STATUS VARCHAR2(32);
BEGIN
  FOR I IN (SELECT A.ORDER_ID, A.MEMO, B.FACTORY_CODE, A.ORDER_STATUS
              FROM (SELECT ORDER_ID, ORDER_CODE, COMPANY_ID, MEMO, ORDER_STATUS
                      FROM SCMDATA.T_ORDERED
                     WHERE REGEXP_COUNT(:ORDER_ID || '','', ORDER_ID || '','') > 0) A
             INNER JOIN SCMDATA.T_ORDERS B
                ON A.ORDER_CODE = B.ORDER_ID
               AND A.COMPANY_ID = B.COMPANY_ID) LOOP
    IF :MEMO <> NVL(I.MEMO,'' '') THEN
      UPDATE SCMDATA.T_ORDERED
         SET MEMO        = :MEMO,
             UPDATE_ID   = %CURRENT_USERID%,
             UPDATE_TIME = SYSDATE
       WHERE REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0
         AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
    END IF;

    IF :FACTORY_CODE <> NVL(I.FACTORY_CODE,'' '') THEN
      IF I.ORDER_STATUS = ''OS02'' THEN
        RAISE_APPLICATION_ERROR(-20002, ''所选订单存在已完成订单，已完成订单不可指定工厂，请检查！'');
      END IF;

      UPDATE SCMDATA.T_ORDERS
         SET FACTORY_CODE = :FACTORY_CODE
       WHERE (ORDER_ID, COMPANY_ID) IN
             (SELECT ORDER_CODE, COMPANY_ID
                FROM SCMDATA.T_ORDERED
               WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
                 AND REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0);

      UPDATE SCMDATA.T_PRODUCTION_PROGRESS
         SET FACTORY_CODE = :FACTORY_CODE
       WHERE (ORDER_ID,GOO_ID,COMPANY_ID) IN 
             (SELECT ORDER_ID,GOO_ID,COMPANY_ID
                FROM SCMDATA.T_ORDERS 
               WHERE (ORDER_ID,COMPANY_ID) IN
                     (SELECT ORDER_ID,COMPANY_ID 
                        FROM SCMDATA.T_ORDERED
                       WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
                         AND REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0));

      UPDATE SCMDATA.T_ORDERED
         SET UPDATE_ID = %CURRENT_USERID%, UPDATE_TIME = SYSDATE
       WHERE REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0
         AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
         
      --czh add 日志记录 begin 
      pkg_supp_order_coor.p_insert_order_log(p_log_type => ''修改信息-指定工厂'',
                                             p_old_designate_factory => I.FACTORY_CODE,
                                             p_new_designate_factory => :FACTORY_CODE,
                                             p_operator => ''SUPP'',
                                             p_operate_person => :user_id);
      --end
      
    END IF;
  END LOOP;
END;', null, 'ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_order_201_1', 3, 'ORDER_CODE,RELA_GOO_ID,SUPPLIER,STYLE_NUMBER', null, null, null, '--czh add 20211209_v0
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_order_list(p_item_id => ''a_order_201_1''); 
  @strresult := v_sql;
END;}', null, null, null, null, null, 'ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_order_201_2', null, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_ordernums_list(); 
  @strresult := v_sql;
END;}', null, null, null, null, null, 'ORDERED_ID,ORDERS_ID,ORDER_ID', null, null, null, null, null, 2, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_order_201_3', null, null, null, null, null, 'select 1 from dual', null, null, null, null, null, 'ORDERED_ID,ORDERS_ID,ORDER_ID', null, null, null, null, null, 2, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_web_union (ITEM_ID, UNION_ITEM_ID, SEQNO, PAUSE)
values ('a_order_201', 'a_order_201_0', 1, 0);

insert into bw3.sys_web_union (ITEM_ID, UNION_ITEM_ID, SEQNO, PAUSE)
values ('a_order_201', 'a_order_201_1', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_201_1', 'a_order_201_2', 'S', 1, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_201_0', 'a_order_201_2', 'S', 1, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_201_0', 'a_order_201_3', 'S', 2, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_order_201_1', 'a_order_201_3', 'S', 2, 0);


end;
