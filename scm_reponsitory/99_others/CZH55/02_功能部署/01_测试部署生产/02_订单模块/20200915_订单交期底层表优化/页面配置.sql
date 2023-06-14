SELECT rowid,t.* from bw3.sys_item t WHERE t.item_id = 'a_report_121';
SELECT rowid,t.* from bw3.sys_tree_list t WHERE t.item_id = 'a_report_121';
SELECT rowid,t.* from bw3.sys_item_list t WHERE t.item_id IN ('a_report_120','a_report_121');--a_report_121
--node_a_report_120   associate_a_report_120
SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id = 'associate_a_report_120'; 
SELECT rowid,t.* from bw3.sys_associate t WHERE t.element_id = 'associate_a_report_120'; 
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id = 'associate_a_report_120'; 
--qc,跟单未部署至开发环境，待部署
SCMDATA.PKG_PT_ORDERED
SELECT rowid,t.* from bw3.sys_look_up t WHERE t.element_id = 'look_a_report_120_2'; 
SELECT rowid,t.* from bw3.sys_param_list t WHERE t.param_name IN ('DEAL_FOLLOWER','QC'); 
SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('action_a_report_120_1','action_a_report_120_2'); 
SELECT rowid,t.* from bw3.sys_action t WHERE t.element_id IN ('action_a_report_120_1','action_a_report_120_2'); 
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id IN ('action_a_report_120_1','action_a_report_120_2');  
