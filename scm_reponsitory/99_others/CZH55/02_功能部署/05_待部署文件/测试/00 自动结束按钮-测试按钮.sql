BEGIN
  insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_product_110_7', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_110_7', '自动-测试', 'icon-morencaidan', 4, 'DECLARE
  v_auto_type INT := @auto_finish_type@;
BEGIN
  IF v_auto_type = 1 THEN
    pkg_production_progress_a.p_auto_end_all_orders(p_company_id => %default_company_id%);
  ELSIF v_auto_type = 2 THEN
    pkg_production_progress_a.p_auto_end_mt_orders(p_company_id => %default_company_id%);
  ELSIF v_auto_type = 3 THEN
    pkg_production_progress_a.p_auto_mt_delay_problem(p_company_id => %default_company_id%);
  ELSE
    NULL;
  END IF;
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'action_a_product_110_7', 5, 0, null);
insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('AUTO_FINISH_TYPE', 'oracle_scmdata', '自动结束类型', null, 'select 1 value,''自动结束订单-非生产订单'' from dual
union all
select 2 value,''自动结束订单-美妆、淘品'' from dual
union all
select 3 value,''自动赋值延期原因-美妆、淘品'' from dual', 1, null, 0, 0, 0.0000, 0.0000, 0, 0, null, null, 0, null, null, 0);

END;
