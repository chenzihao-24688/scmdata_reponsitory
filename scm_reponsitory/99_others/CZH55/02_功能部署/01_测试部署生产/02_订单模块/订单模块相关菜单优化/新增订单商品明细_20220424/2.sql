begin
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_order_201_5', 'list', '订单商品明细', 'oracle_scmdata', 'T_ORDERSITEM', 'ORDERSITEM_ID', null, 'a_order_201_5', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_order_201_5', 0, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_ordergoods_list();
  @strresult := v_sql;
END;}', null, null, null, null, null, 'ordersitem_id', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
end;
/
begin
update bw3.sys_item_rela t set t.relate_id = 'a_order_201_5' where t.item_id in ('a_order_201_4') and t.relate_id = 'a_product_115';
end;

