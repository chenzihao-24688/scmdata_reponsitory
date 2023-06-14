--以准入供应商
--未准入供应商
select rowid,t.* from nbw.sys_item t where t.item_id in ('a_coop_330','a_coop_330_1','a_coop_330_2');
select rowid,t.* from nbw.sys_tree_list t where t.item_id in ('a_coop_330','a_coop_330_1','a_coop_330_2');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_coop_330','a_coop_330_1','a_coop_330_2');
select rowid,t.* from nbw.sys_web_union t where t.item_id in ('a_coop_330','a_coop_330_1','a_coop_330_2') ;
