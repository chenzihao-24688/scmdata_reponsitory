--表
--新增，修改字段
--scmdata.t_ask_record 
--scmdata.t_factory_ask
--scmdata.t_factory_report
--scmdata.t_supplier_info
--模板表
--t_person_config
--t_machine_equipment
--t_quality_control
--业务表
--人员配置
--T_PERSON_CONFIG_HZ
--T_PERSON_CONFIG_FA
--T_PERSON_CONFIG_SUP
--机器设备
--T_MACHINE_EQUIPMENT_HZ
--T_MACHINE_EQUIPMENT_FA
--T_MACHINE_EQUIPMENT_SUP
--品控体系
--t_quality_control_fr
--t_quality_control_sup
--包
--pkg_ask_record_mange
--pkg_ask_record_mange_a
--scmdata.pkg_plat_comm
--scmdata.sf_get_arguments_pkg 
--scmdata.pkg_supplier_info
--scmdata.pkg_supplier_info_a
--pkg_check_data_comm
--pkg_compname_check
--scmdata.pkg_ask_mange
--触发器
--trg_bf_iu_t_coop_scope
--页面共用
--a_coop_151
--原item:
--a_coop_150_6,a_coop_132_1,A_COOP_121
--新item:a_coop_151  pick_a_coop_121_1
--验厂申请
SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id IN ('a_coop_150','a_coop_151','a_coop_151_1','a_coop_151_2','a_coop_121','a_coop_132_1','a_coop_159','a_coop_159_1','a_coop_150_3','a_coop_150_3_1','a_coop_150_3_2','a_coop_210','a_coop_220','a_coop_230','a_coop_310','a_coop_320','a_check_103_1','a_supp_150','a_supp_151','a_supp_151_1','a_supp_151_9','a_supp_151_10','a_supp_151_11','a_supp_151_7','a_supp_151_8','a_supp_151_2','a_supp_151_3');
SELECT rowid,t.* from nbw.sys_tree_list t WHERE t.item_id IN ('a_coop_150','a_coop_151','a_coop_151_1','a_coop_151_2','a_coop_121','a_coop_132_1','a_coop_159','a_coop_159_1','a_coop_150_3','a_coop_150_3_1','a_coop_150_3_2','a_coop_210','a_coop_220','a_coop_230','a_coop_310','a_coop_320','a_check_103_1','a_supp_150','a_supp_151','a_supp_151_1','a_supp_151_2');
SELECT rowid,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_coop_150','a_coop_151','a_coop_151_1','a_coop_151_2','a_coop_121','a_coop_132_1','a_coop_159','a_coop_159_1','a_coop_150_3','a_coop_150_3_1','a_coop_150_3_2','a_coop_210','a_coop_220','a_coop_230','a_coop_310','a_coop_320','a_check_103_1','a_supp_150','a_supp_151','a_supp_151_1','a_supp_151_9','a_supp_151_10','a_supp_151_11','a_supp_151_7','a_supp_151_8','a_supp_151_2','a_supp_151_3','a_supp_151_2','a_supp_171'); 
SELECT rowid,t.* from nbw.sys_item_rela t WHERE t.item_id IN ('a_coop_151','a_coop_150_3','a_supp_151'); 
SELECT rowid,t.* from nbw.sys_detail_group t WHERE t.item_id IN ('a_coop_151','a_coop_150_3','a_supp_151'); 
SELECT rowid,t.* from nbw.sys_link_list t WHERE t.item_id = 'a_supp_151_2';

--按钮  
--'ac_a_coop_150_1','ac_a_coop_150_2' action_a_coop_220_3 按钮隐藏
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('ac_a_coop_150_1','ac_a_coop_150_2','action_a_coop_150_0','asso_a_coop_150_6');
SELECT rowid,t.* from nbw.sys_action t WHERE t.element_id IN ('ac_a_coop_150_1','ac_a_coop_150_2','action_a_coop_150_0','action_a_coop_151','ac_a_coop_150_4','action_a_coop_220_1','action_a_coop_220_2','action_a_coop_311','action_a_supp_151_1','action_a_supp_150_1');
SELECT rowid,t.* from nbw.sys_associate t WHERE t.element_id IN ('asso_a_coop_150_6','associate_a_coop_130','associate_a_coop_131','asso_a_coop_150_3','associate_a_coop_221','associate_a_coop_201','asso_a_check_102_2','associate_a_supp_150_2','associate_a_supp_160_1','asso_a_supp_151_2'); 
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('ac_a_coop_150_1','ac_a_coop_150_2','action_a_coop_150_0','asso_a_coop_150_6','associate_a_coop_221','associate_a_coop_201','action_a_coop_220_3','associate_a_supp_160_1');
SELECT rowid,t.* from nbw.sys_element_hint t WHERE t.element_id = 'asso_a_check_102_2';--asso_a_supp_151_2 
SELECT rowid,t.* from nbw.sys_cond_list t WHERE t.cond_id IN ('cond_a_coop_150','cond_a_coop_151','cond_asso_a_coop_150_3','cond_a_coop_150_3','cond_a_coop_310','cond_action_a_supp_151_1');
SELECT rowid,t.* from nbw.sys_cond_rela t WHERE t.cond_id IN ('cond_a_coop_150','cond_a_coop_151','cond_asso_a_coop_150_3','cond_a_coop_150_3','cond_a_coop_310','cond_action_a_supp_151_1'); 
SELECT rowid,t.* from nbw.sys_cond_operate t WHERE t.cond_id IN ('cond_a_coop_150','cond_a_supp_150_1'); --node_a_coop_151 node_a_coop_150_6
--新增意向供应商

--字段控制   a_coop_150_3 a_coop_211 a_coop_211
--asso_a_coop_150_3  
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('control_a_coop_150_1','control_a_coop_151_1','control_a_coop_151_2','control_a_coop_151_3','control_a_coop_151_2_1','control_a_coop_151_2_2');
SELECT rowid,t.* from nbw.sys_field_control t WHERE t.element_id IN ('control_a_coop_150_1','control_a_coop_151_1','control_a_coop_151_2','control_a_coop_151_3','control_a_coop_151_2_1','control_a_coop_151_2_2');
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('control_a_coop_150_1','control_a_coop_151_1','control_a_coop_151_2','control_a_coop_151_3','control_a_coop_151_2_1','control_a_coop_151_2_2');

SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id = 'control_a_coop_150_2';
SELECT rowid,t.* from nbw.sys_field_control t WHERE t.element_id = 'control_a_coop_150_2';
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id = 'control_a_coop_150_2';
--字段配置
SELECT ROWID, t.*
  FROM nbw.sys_field_list_file t
 WHERE t.field_name IN ('AR_CERTIFICATE_FILE_Y',
                        'AR_SUPPLIER_GATE_N',
                        'AR_SUPPLIER_OFFICE_N',
                        'AR_SUPPLIER_SITE_N',
                        'AR_SUPPLIER_PRODUCT_N',
                        'AR_OTHER_INFORMATION_N',
                        'SP_CERTIFICATE_FILE_Y',
                        'SP_SUPPLIER_GATE_N',
                        'SP_SUPPLIER_OFFICE_N',
                        'SP_SUPPLIER_SITE_N',
                        'SP_SUPPLIER_PRODUCT_N',
                        'SP_OTHER_INFORMATION_N');
                        
--辅助配置
SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id IN ('action_a_coop_151',
                        'coop_model',
                        'look_a_coop_121_1',
                        'look_a_coop_121_2',
                        'look_a_coop_121_5',
                        'look_a_supp_160_1',
                        'lookup_a_coop_151_0',
                        'pick_a_coop_121_1',
                        'picklist_address',
                        'look_a_coop_151_1',
                        'look_a_coop_151_2',
                        'look_a_coop_151_3',
                        'look_a_coop_151_4',
                        'look_a_coop_151_5',
                        'look_a_coop_151_6',
                        'look_a_coop_151_7',
                        'look_a_coop_151_8',
                        'look_a_coop_151_9',
                        'pick_a_coop_151_1',
                        'pick_a_coop_151_2',
                        'pick_a_coop_151_3',
                        'pick_a_coop_151_4',
                        'pick_a_coop_151_5',
                        'look_a_coop_151_1_1',
                        'look_a_coop_151_1_2',
                        'look_a_coop_151_1_3',
                        'look_a_coop_151_1_4',
                        'lookup_a_coop_150_3_0',
                        'assign_a_coop_151_1',
                        'assign_a_coop_151_2','look_a_supp_150_1','look_a_check_101_1_7_1');
SELECT ROWID, t.*  
  FROM nbw.sys_look_up t
 WHERE t.element_id IN ('look_a_coop_121_1',
                        'look_a_coop_121_2',
                        'look_a_coop_121_5',
                        'look_a_supp_160_1',
                        'lookup_a_coop_151_0',
                        'look_a_coop_151_1',
                        'look_a_coop_151_2',
                        'look_a_coop_151_3',
                        'look_a_coop_151_4',
                        'look_a_coop_151_5',
                        'look_a_coop_151_6',
                        'look_a_coop_151_7',
                        'look_a_coop_151_8',
                        'look_a_coop_151_9',
                        'look_a_coop_151_1_1',
                        'look_a_coop_151_1_2',
                        'look_a_coop_151_1_3',
                        'look_a_coop_151_1_4',
                        'lookup_a_coop_150_3_0',
                        'look_a_coop_150_3_1','lookup_a_coop_150_3_0','look_a_supp_150_1','look_a_check_101_1_7_1');
SELECT ROWID, t.*
  FROM nbw.sys_pick_list t
 WHERE t.element_id IN ('pick_a_coop_121_1',
                        'picklist_address',
                        'pick_a_coop_121_2',
                        'pick_a_coop_151_1',
                        'pick_a_coop_151_2',
                        'pick_a_coop_151_3',
                        'pick_a_coop_151_4',
                        'pick_a_coop_151_5',
                        'lookup_a_coop_150_3_0',
                        'pick_a_coop_150_3_10',
                        'pick_a_coop_150_3_11','pick_a_coop_150_3_1','pick_a_supp_151');
SELECT ROWID, t.*
  FROM nbw.sys_assign t
 WHERE t.element_id IN ('assign_a_coop_151_1', 'assign_a_coop_151_2','assign_a_coop_153_1');
 
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id IN ('look_a_check_101_1_7_1');
 
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.item_id IN ('a_coop_151',
                     'a_coop_151_1',
                     'a_coop_150_3',
                     'a_coop_151_1',
                     'a_coop_151_2',
                     'a_coop_310',
                     'a_supp_151',
                     'a_supp_171',
                     'a_supp_150',
                     'a_supp_151_7',
                     'a_supp_151_8',
                     'a_supp_151_11');

--准入审批
--权限控制
SELECT rowid,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_coop_311','a_check_102_1'); 
SELECT rowid,t.* from nbw.sys_tree_list t WHERE t.node_id IN ('node_a_coop_311','node_a_check_102_1','node_a_coop_312','node_a_coop_150_3','node_a_check_103_1'); 
SELECT rowid,t.* from nbw.sys_tree_list t WHERE t.parent_id IN ('a_coop_310','a_coop_320'); 
SELECT rowid,t.* from nbw.sys_cond_list t WHERE t.cond_id IN ('cond_node_a_coop_311','cond_node_a_coop_312');
SELECT rowid,t.* from nbw.sys_cond_rela t WHERE t.cond_id IN ('cond_node_a_coop_311','cond_node_a_coop_312'); 
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('associate_a_coop_201','asso_a_check_102_2') AND t.item_id = 'a_coop_310'; 
SELECT rowid,t.* from nbw.sys_element_hint t WHERE t.element_id IN ('associate_a_coop_201','asso_a_check_102_2'); 


--准入流程日志
SELECT rowid,t.* from nbw.sys_action t WHERE t.element_id IN ('action_a_coop_151','ac_a_coop_150_4','action_a_coop_220_2','action_a_coop_220_1','action_a_coop_313','action_a_coop_312','action_a_coop_311','action_specialapply','action_a_supp_151_1'); 
SELECT rowid,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_coop_133_1','a_coop_106'); 
,status_bf_oper,flow_node_status_desc_bf,flow_node_name_af,flow_node_status_desc_af
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('action_a_coop_310_1','action_a_coop_310_2','action_a_coop_310_3');
SELECT rowid,t.* from nbw.sys_action t WHERE t.element_id IN ('action_a_coop_310_1','action_a_coop_310_2','action_a_coop_310_3','action_a_supp_110_9'); 
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('action_a_coop_310_1','action_a_coop_310_2','action_a_coop_310_3'); 
