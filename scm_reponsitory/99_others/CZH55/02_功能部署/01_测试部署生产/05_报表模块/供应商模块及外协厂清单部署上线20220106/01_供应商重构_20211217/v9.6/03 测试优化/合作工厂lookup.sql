begin
update bw3.sys_item_element_rela t set t.pause = 1 where t.element_id = 'associate_a_supp_151_4';

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('COOP_FACTORY_TYPE_DESC', '工厂类型', 0, null, null, null, null, null, 0, 0, 0, 0, 0, 3, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('d33b4e9d191835b5e0533c281cac46d8', 'b2c7b0092405122de0533c281cac6536', 'b2c7b0092405122de0533c281cac6536', '合作工厂类型', 'COOP_FAC_TYPE', 'SUPPLIER_MANGE_DICT', null, 1, '1', 1, 1, 0, 'CZH', to_date('16-12-2021 10:37:44', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('16-12-2021 10:37:44', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('d33b4e9d191935b5e0533c281cac46d8', 'd33b4e9d191835b5e0533c281cac46d8', 'd33b4e9d191835b5e0533c281cac46d8', '本厂', '00', 'COOP_FAC_TYPE', null, 1, '1', 1, 1, 0, 'CZH', to_date('16-12-2021 10:38:20', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('16-12-2021 10:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('d33b4e9d191a35b5e0533c281cac46d8', 'd33b4e9d191835b5e0533c281cac46d8', 'd33b4e9d191835b5e0533c281cac46d8', '外协厂', '01', 'COOP_FAC_TYPE', null, 1, '1', 1, 1, 0, 'CZH', to_date('16-12-2021 10:38:20', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('16-12-2021 10:38:20', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

delete from  bw3.Sys_span t where t.element_id = 'span_a_supp_151_1'; 

end;
/
begin
  insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_supp_151_7_1', 'lookup', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('look_a_supp_151_7_2', 'lookup', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_supp_151_7_1', 'COOP_STATUS_DESC', '--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_coop_status_looksql(p_coop_status_field => ''COOP_STATUS'' ,p_suffix   => ''_DESC'');
  @strresult := v_sql;
END;}', '1', 'COOP_STATUS', 'COOP_STATUS_DESC', 'COOP_STATUS', 0, 0, '0', null, null, null, null, null);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_supp_151_7_2', 'COOP_FACTORY_TYPE_DESC', '--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_fac_type_looksql(p_fac_type_field => ''COOP_FACTORY_TYPE'' ,p_suffix   => ''_DESC'');
  @strresult := v_sql;
END;}', '1', 'COOP_FACTORY_TYPE', 'COOP_FACTORY_TYPE_DESC', 'COOP_FACTORY_TYPE', 0, 0, '0', null, null, null, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_7', 'look_a_supp_151_7_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_7', 'look_a_supp_151_7_2', 1, 0, null);

end;
