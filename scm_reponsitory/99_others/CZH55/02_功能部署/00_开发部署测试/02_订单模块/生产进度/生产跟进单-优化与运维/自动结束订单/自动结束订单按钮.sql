begin
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_product_110_5', 'action', 'oracle_scmdata', 0, null, 1, null, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_110_5', '自动结束订单', 'icon-morencaidan', 4, 'BEGIN
  FOR company_rec IN (SELECT company_id FROM scmdata.sys_company) LOOP
    pkg_production_progress_a.auto_end_orders(p_company_id => company_rec.company_id);
  END LOOP;
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_110', 'action_a_product_110_5', 5, 0, null);

end;



