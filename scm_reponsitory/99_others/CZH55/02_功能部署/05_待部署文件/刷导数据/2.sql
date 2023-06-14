prompt Importing table nbw.sys_look_up...
set feedback off
set define off

insert into nbw.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_supp_161', 'GROUP_NAME_DESC', 'SELECT t.group_name group_name_desc, t.group_config_id group_name
  FROM scmdata.t_supplier_group_config t
 WHERE t.company_id = %default_company_id%
   AND t.pause = 1', '1', 'GROUP_NAME', 'GROUP_NAME_DESC', 'GROUP_NAME', null, null, null, null, null, null, null, null);

prompt Done.
