begin
update bw3.sys_item t set t.pause = 1 where t.item_id in ('a_order_201','a_product_101','a_product_201');
update bw3.sys_tree_list t set t.parent_id = 'a_order_100' where t.item_id in ('a_order_201_0','a_order_201_1');
update bw3.sys_item t set t.caption_sql = '生产订单' where t.item_id in ('a_order_201_0');
update bw3.sys_tree_list t set t.seq_no = 7 where t.item_id in ('a_order_201_0');
update bw3.sys_tree_list t set t.seq_no = 8 where t.item_id in ('a_order_201_4');
update bw3.sys_tree_list t set t.seq_no = 9  where t.item_id in ('a_order_201_1');

update bw3.sys_item t set t.caption_sql = '生产订单进度表' where t.item_id in ('a_product_110'); 
update bw3.sys_item t set t.caption_sql = '生产订单进度表' where t.item_id in ('a_product_210'); 
update bw3.sys_item t set t.caption_sql = '生产订单进度表' where t.item_id in ('a_product_210'); 
update bw3.sys_item t set t.caption_sql = '可结束订单' where t.item_id in ('a_report_order_100'); 
update bw3.sys_item t set t.caption_sql = '已完成订单' where t.item_id in ('a_product_116'); 

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_report_order_100', 'tree_a_product', 'a_report_order_100', 'a_product_100', null, 'scm', null, 0, null, 6, 0, 0, null, null, 1, 1, null);

update bw3.sys_tree_list t set t.parent_id = 'a_product_100',t.tree_id = 'tree_a_product' where t.item_id in ('a_product_110','a_product_116','a_product_210','a_product_216','a_report_order_100');

update bw3.sys_tree_list t set t.seq_no = 7 where t.item_id in ('a_product_110');
update bw3.sys_tree_list t set t.seq_no = 8 where t.item_id in ('a_product_150');
update bw3.sys_tree_list t set t.seq_no = 9  where t.item_id in ('a_report_order_100');
update bw3.sys_tree_list t set t.seq_no = 10 where t.item_id in ('a_product_116');

update bw3.sys_tree_list t set t.seq_no = 11 where t.item_id in ('a_product_210');
update bw3.sys_tree_list t set t.seq_no = 12 where t.item_id in ('a_product_217');
update bw3.sys_tree_list t set t.seq_no = 13 where t.item_id in ('a_product_216');


end;
