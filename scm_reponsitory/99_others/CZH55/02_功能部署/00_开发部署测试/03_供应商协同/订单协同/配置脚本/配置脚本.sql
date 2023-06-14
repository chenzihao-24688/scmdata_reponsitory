select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_order_102','action_a_order_201');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_order_101_0','a_order_201_0','a_order_201_3'); 
select rowid,t.* from nbw.sys_item_rela t where t.item_id in ('a_order_101_0','a_order_201_0'); 



--czh add 20211209_v0
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_order_log(p_item_id => 'a_order_201_3'); 
  @strresult := v_sql;
END;}
