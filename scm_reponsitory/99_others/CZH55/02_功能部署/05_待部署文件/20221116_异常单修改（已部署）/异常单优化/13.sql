prompt Importing table nbw.sys_tree_list...
set feedback off
set define off

insert into nbw.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_product_113_1', 'tree_a_product', 'a_product_113_1', null, null, 'scm', null, 1, null, 1, 0, null, null, null, 1, 1, null);

prompt Done.
