begin
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_product_201', 'manylist', '���������', 'oracle_scmdata', null, null, null, 'a_product_201', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_product_210', 'list', 'δ��ɶ���', 'oracle_scmdata', 'T_PRODUCTION_PROGRESS', 'PRODUCT_GRESS_ID', null, 'a_product_210', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 5, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_product_211', 'list', '�ڵ����', 'oracle_scmdata', null, null, null, 'a_product_211', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_product_213', 'single', '�ڵ������д', 'oracle_scmdata', 'T_NODE_TMP', 'NODE_TMP_ID', null, 'a_product_213', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_product_216', 'list', '����ɶ���', 'oracle_scmdata', 'T_PRODUCTION_PROGRESS', 'PRODUCT_GRESS_ID', null, 'a_product_216', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1, null);
end;
