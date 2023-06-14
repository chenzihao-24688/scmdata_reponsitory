--供应商主档接口  scm获取mdm回传编号

select rowid,t.* from nbw.sys_item t where t.item_id in ('a_supp_110','a_supp_110_1','a_supp_140');   
select rowid,t.* from nbw.sys_tree_list t where t.item_id in ('a_supp_110','a_supp_110_1','a_supp_140');   
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_supp_110','a_supp_110_1','a_supp_140'); 

SELECT ROWID, t.* FROM nbw.sys_element t where t.element_id like '%action_a_supp_110%';
SELECT ROWID, t.* FROM nbw.sys_action t where t.element_id like '%action_a_supp_110%';
SELECT ROWID, t.* FROM nbw.sys_item_element_rela t where t.element_id like '%action_a_supp_110%';

SELECT ROWID, t.* FROM nbw.sys_method t where t.method_id in('method_a_supp_110_9');
SELECT ROWID, t.* FROM nbw.sys_port_http t where t.port_name in ('port_a_supp_110_9');
SELECT ROWID, t.* FROM nbw.sys_port_method t where t.method_id in('method_a_supp_110_9');
SELECT ROWID, t.* FROM nbw.sys_port_map t where t.port_name in ('port_a_supp_110_9');
SELECT ROWID, t.* FROM nbw.sys_action t where t.element_id in ('action_a_supp_110_9');
SELECT ROWID, t.* FROM nbw.sys_port_submap t where t.seqno = 100;
