???prompt Importing table nbw.sys_tree_list...
set feedback off
set define off
insert into nbw.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_product_200', 'tree_a_product', 'a_product_200', 'menuroot', null, 'scm', 'icon-huiyiguanli01', 0, null, 20, 0, 0, null, null, 1, 1, null);

prompt Done.
