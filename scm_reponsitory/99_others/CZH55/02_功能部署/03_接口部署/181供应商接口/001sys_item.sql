prompt Importing table bwptest1.sys_item...
set feedback off
set define off
insert into bwptest1.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_SQL, BADGE_FLAG, SHOW_ROWID, ENABLE_STAND_PERMISSION, MEMO, FIX_CAPTION)
values ('itf_a_supp_140', 'list', '��Ӧ�������ӿڵ���', 'oracle_mdmdata', 't_supplier_base_itf', 'itf_id', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bwptest1.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_SQL, BADGE_FLAG, SHOW_ROWID, ENABLE_STAND_PERMISSION, MEMO, FIX_CAPTION)
values ('itf_a_supp_141', 'list', '��Ӧ�̵���-������Χ�ӿڵ���', 'oracle_mdmdata', 't_supplier_coop_itf', 'itf_id', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

prompt Done.
