prompt Importing table bwptest1.sys_tree_list...
set feedback off
set define off
insert into bwptest1.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_itf_a_supp_140', '100', 'itf_a_supp_140', 'czh2000', null, 'app_sanfu_retail', 'icon-function', 0, 0, 9, 0, 0, '供应商主档接口导入', null, 1, 1, null);

insert into bwptest1.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_itf_a_supp_141', '100', 'itf_a_supp_141', 'czh2000', null, 'app_sanfu_retail', 'icon-function', 0, 0, 10, 0, 0, '供应商档案-合作范围接口导入', null, 1, 1, null);

prompt Done.
