BEGIN
UPDATE bw3.sys_item_element_rela t SET t.pause = 1 WHERE t.element_id = 'look_a_supp_151' AND t.item_id IN ('a_supp_160','a_supp_161','a_supp_151'); 
END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_supp_161', 'lookup', 'oracle_scmdata', 0, null, null, null, null, null, null);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_supp_161', 'GROUP_NAME_DESC', 'SELECT t.group_name group_name_desc, t.group_config_id group_name
  FROM scmdata.t_supplier_group_config t
 WHERE t.company_id = %default_company_id%
   AND t.pause = 1', '1', 'GROUP_NAME', 'GROUP_NAME_DESC', 'GROUP_NAME', null, null, null, null, null, null, null, null);
   
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151', 'look_a_supp_161', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_160', 'look_a_supp_161', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_161', 'look_a_supp_161', 1, 0, null);   
END;
/
