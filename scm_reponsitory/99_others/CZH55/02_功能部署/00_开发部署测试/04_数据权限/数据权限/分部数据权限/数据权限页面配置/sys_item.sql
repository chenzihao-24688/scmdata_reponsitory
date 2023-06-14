declare
begin
  
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID)
values ('c_2075', 'list', '部门信息', 'oracle_scmdata', 'sys_company_dept', 'COMPANY_DEPT_ID', null, 'c_2075', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID)
values ('c_2076', 'list', '数据权限-合作类别', 'oracle_scmdata', 'sys_company_dept', 'COMPANY_DEPT_ID', null, 'c_2076', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null);

end;
