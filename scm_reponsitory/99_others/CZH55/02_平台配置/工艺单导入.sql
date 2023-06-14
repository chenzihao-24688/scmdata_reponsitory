SELECT ROWID, t.* FROM nbw.sys_item t WHERE t.item_id in('c_2100','c_2051','c_2090','a_good_101_4','a_good_101_4_1') ;
SELECT ROWID, t.* FROM nbw.sys_tree_list t WHERE t.item_id in('c_2100','c_2051','c_2090','a_good_101_4','a_good_101_4_1');
SELECT ROWID, t.* FROM nbw.sys_item_list t WHERE t.item_id in('c_2100','c_2051','c_2090','a_good_101_4','a_good_101_4_1');

select rowid,t.* from nbw.sys_element t; 
select rowid,t.* from nbw.sys_action t  where t.caption in ('批量导入','工艺单导入');
SELECT ROWID, t.* FROM nbw.sys_item_element_rela t;

select rowid,t.* from nbw.sys_cond_rela t where t.cond_id in('cond_checkaction_c_2051_1','cond_checkaction_a_good_101_4'); --action_c_2051_1 t_commodity_craft_temp
select rowid,t.* from nbw.sys_cond_list t  where t.cond_id  in('cond_checkaction_c_2051_1','cond_checkaction_a_good_101_4');

select rowid,t.* from nbw.sys_cond_operate t where t.cond_id in('cond_checkaction_c_2051_1','cond_checkaction_a_good_101_4');
