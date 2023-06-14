--供应商待建档  新增按钮 shortcut类型=》action
DECLARE
BEGIN
  UPDATE nbw.sys_shortcut t
     SET t.pause = 1
   WHERE t.short_id = 'short_a_supp_150';
   
 insert into nbw.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('action_a_supp_150_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null);

insert into nbw.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS)
values ('action_a_supp_150_1', '新增', 'icon-morencaidan', 4, 'select 1 from dual', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null);

insert into nbw.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_150', 'action_a_supp_150_1', 1, 0, null);

insert into nbw.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_supp_150_1', 'select 0 flag from dual where 1=1', 1, null, 'oracle_scmdata', null, null);

insert into nbw.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_supp_150_1', 91, 'action_a_supp_150_1', 1, 1, 0, null);

insert into nbw.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_a_supp_150_1', '提示', '是否前往供应商档案新增页面？', 'a_supp_171', null);

END;
