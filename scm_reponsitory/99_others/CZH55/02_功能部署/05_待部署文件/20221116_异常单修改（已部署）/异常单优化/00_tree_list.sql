prompt Importing table nbw.sys_tree_list...
set feedback off
set define off

insert into nbw.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_order_101_0', 'tree_a_order', 'a_order_101_0', 'a_order_100', null, 'scm', null, null, null, 1, 0, 0, null, null, 1, 1, null);

insert into nbw.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_product_110', 'tree_a_product', 'a_product_110', 'a_product_100', null, 'scm', null, 0, null, 1, 0, 0, null, null, 1, 1, null);

insert into nbw.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_product_118', 'tree_a_product_1', 'a_product_118', null, null, 'scm', null, 0, null, 8, 0, 0, null, null, 1, 1, null);

insert into nbw.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_product_120', 'tree_a_product', 'a_product_120', 'a_product_200', null, 'scm', null, 0, null, 2, 0, 0, null, null, 1, 1, null);

prompt Done.
