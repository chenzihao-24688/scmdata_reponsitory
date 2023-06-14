BEGIN
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_prematerial_226', 'list', '备料进度', 'oracle_plm', null, null, null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.SYS_ITEM_LIST (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_prematerial_226', null, null, null, null, null, '{
DECLARE
  v_sql CLOB;
  v_order_num VARCHAR2(32);
BEGIN
  SELECT MAX(t.product_gress_code) INTO v_order_num from scmdata.t_production_progress t WHERE t.product_gress_id = :product_gress_id;
  v_sql      := mrp.pkg_color_prepare_order_manager.f_query_prepare_order_process(p_order_num => v_order_num);
  @strresult := v_sql;
END;
}', null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, 4, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_110', 'a_prematerial_226', 'S', 6, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_116', 'a_prematerial_226', 'S', 6, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_210', 'a_prematerial_226', 'S', 6, 0);

insert into bw3.sys_item_rela (ITEM_ID, RELATE_ID, RELATE_TYPE, SEQ_NO, PAUSE)
values ('a_product_216', 'a_prematerial_226', 'S', 6, 0);
END;
/
