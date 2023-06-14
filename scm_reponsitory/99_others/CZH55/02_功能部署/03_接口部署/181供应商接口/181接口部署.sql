select rowid,t.* from bwptest1.sys_item t where t.item_id in('itf_a_supp_140','itf_a_supp_141');
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('itf_a_supp_140','itf_a_supp_141');   
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in('itf_a_supp_140','itf_a_supp_141'); --czh2008 czh2007

SELECT ROWID, t.* FROM bwptest1.sys_element t where t.element_id like '%action_itf_a_supp%';
SELECT ROWID, t.* FROM bwptest1.sys_action t where t.element_id like '%action_itf_a_supp%';
SELECT ROWID, t.* FROM bwptest1.sys_item_element_rela t where t.element_id like '%action_itf_a_supp%';

select rowid,t.* from bwptest1.xxl_job_info t where t.id in('520','521'); 

select rowid,t.* from bwptest1.sys_open_info t where t.open_id = 'open_scm_supp_code';
SELECT ROWID, t.* FROM bwptest1.sys_open_interface t where t.open_id = 'open_scm_supp_code';
SELECT ROWID, t.* FROM bwptest1.sys_method t where t.method_id in ('method_itf_a_supp_140','method_itf_a_supp_141'); --czh2007
SELECT ROWID, t.* FROM bwptest1.sys_port_http t where t.port_name in('port_itf_a_supp_140','port_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_port_method t where t.method_id in ('method_itf_a_supp_140','method_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_port_map t where t.port_name in('port_itf_a_supp_140','port_itf_a_supp_141');
--SELECT ROWID, t.* FROM bwptest1.sys_action t where t.element_id in ('action_itf_a_supp_140','action_itf_a_supp_141');
SELECT ROWID, t.* FROM bwptest1.sys_port_submap t where t.seqno = '100'; --a_supp_100

