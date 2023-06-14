???prompt Importing table nbw.sys_item...
set feedback off
set define off
insert into nbw.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID)
values ('a_supp_151', 'single', '供应商档案详情', 'oracle_scmdata', 'T_SUPPLIER_INFO', 'SUPPLIER_INFO_ID', null, 'a_supp_151', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null);

insert into nbw.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID)
values ('g_540_11', 'list', '标签详细内容', 'scm_nbw', 'SYS_LABEL_LISTS', 'LABEL_ID', null, 'g_540_11', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null);

prompt Done.
