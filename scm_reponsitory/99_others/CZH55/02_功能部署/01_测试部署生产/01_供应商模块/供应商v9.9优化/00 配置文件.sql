SELECT rowid,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_supp_151','a_supp_151_7','a_supp_160','a_supp_161','a_supp_161_1','a_supp_171','a_supp_120_1'); 
SELECT rowid,t.* from nbw.sys_pick_list t WHERE t.element_id = 'pick_a_supp_151_2'; 
SELECT rowid,t.* from nbw.sys_look_up t WHERE t.element_id = 'look_a_supp_151'; 
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id = 'look_a_supp_151'; 
SELECT rowid,t.* from nbw.sys_action t WHERE t.element_id IN ('action_a_supp_160_1','action_a_supp_160_2','action_a_coop_162_2','action_a_supp_160_4','action_a_supp_160_3','action_a_supp_160_5'); 
--tri_af_t_supplier_group_category_config

SELECT rowid,t.* from nbw.sys_field_list t WHERE t.field_name = 'GROUP_NAME'; 

scmdata.pkg_supplier_info  pkg_plat_comm scmdata.t_supplier_info  pause_cause 

SELECT DISTINCT t.apply_module from scmdata.t_plat_log t;
SELECT * from scmdata.t_plat_logs;

DELETE from scmdata.t_plat_logs a WHERE a.log_id IN (SELECT t.log_id from  scmdata.t_plat_log t WHERE t.apply_module LIKE '%a_supp_16%');
DELETE from scmdata.t_plat_log t WHERE t.apply_module LIKE '%a_supp_16%';
c1
scmdata.t_coop_scope  T_SUPPLIER_INFO  SUPPLIER_INFO_ID
scmdata.pkg_plat_comm
SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id IN ('a_report_140'); 
SELECT rowid,t.* from nbw.sys_tree_list t WHERE t.item_id IN ('a_report_140'); 
SELECT rowid,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_report_140'); 
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id = 'associate_a_supp_160_1_1';
SELECT rowid,t.* from nbw.sys_associate t WHERE t.element_id = 'associate_a_supp_160_1_1';
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id = 'associate_a_supp_160_1_1';
SELECT rowid,t.* from nbw.sys_element_hint t  WHERE t.item_id = 'a_report_140';
