begin
  insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('pick_a_supp_151_7_1', 'pick', 'oracle_scmdata', 0, null, 0, null, null, null, null);
insert into bw3.sys_pick_list (ELEMENT_ID, FIELD_NAME, CAPTION, PICK_SQL, FROM_FIELD, QUERY_FIELDS, OTHER_FIELDS, TREE_FIELDS, LEVEL_FIELD, IMAGE_NAMES, TREE_ID, SEPERATOR, MULTI_VALUE_FLAG, RECURSION_FLAG, CUSTOM_QUERY, NAME_LIST_SQL, PORT_ID, PORT_SQL)
values ('pick_a_supp_151_7_1', 'FACTORY_NAME', '工厂名称', '--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_coop_factory_pick(p_item_id => ''a_supp_151_7'');
  @strresult := v_sql;
END;}
', 'FACTORY_NAME', 'SUPPLIER_CODE,FACTORY_NAME', 'SUPPLIER_CODE,FACTORY_NAME,COOP_STATUS,COOP_FACTORY_TYPE,FAC_SUP_INFO_ID', 'FACTORY_NAME', null, null, null, null, 0, 0, 0, null, null, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_7', 'pick_a_supp_151_7_1', 1, 0, null);
end;
