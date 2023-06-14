--商品档案
--SCMDATA.T_SIZE_CHART_TMP  
--SCMDATA.T_SIZE_CHART_DETAILS_TMP  
--SCMDATA.T_SIZE_CHART
--SCMDATA.T_SIZE_CHART_DETAILS
--SCMDATA.T_SIZE_CHART_IMPORT_TMP    
--SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP  
--批版
--SCMDATA.T_APPROVE_VERSION_SIZE_CHART_TMP 
--SCMDATA.T_APPROVE_VERSION_SIZE_CHART_DETAILS_TMP
--SCMDATA.T_APPROVE_VERSION_SIZE_CHART
--SCMDATA.T_APPROVE_VERSION_SIZE_CHART_DETAILS

SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id IN ('a_good_110','a_approve_111','a_approve_112','a_good_310_1','a_good_310_2','a_good_310_3','a_good_310_4','a_approve_310_1','a_approve_310_2','a_approve_310_3');
SELECT rowid,t.* from nbw.sys_tree_list t WHERE t.item_id IN ('a_good_110','a_approve_111','a_approve_112','a_good_310_1','a_good_310_2','a_good_310_3','a_good_310_4','a_approve_310_1','a_approve_310_2','a_approve_310_3');
SELECT rowid,t.* from nbw.sys_item_list t WHERE t.item_id IN ('a_good_110','a_approve_111','a_approve_112','a_good_310_1','a_good_310_2','a_good_310_3','a_good_310_4','a_approve_310_1','a_approve_310_2','a_approve_310_3');

SELECT ROWID, t.*
  FROM nbw.sys_element t
 WHERE t.element_id IN ('associate_a_good_110','associate_a_good_310_1_1','associate_a_good_110_1','associate_a_good_110_2','associate_a_approve_111_1','associate_a_approve_111_2','associate_a_approve_111_3','associate_a_approve_310_1_1','associate_a_approve_111_4');
SELECT ROWID, t.*
  FROM nbw.sys_associate t
 WHERE t.element_id IN ('associate_a_good_110','associate_a_good_310_1_1','associate_a_good_110_1','associate_a_good_110_2','associate_a_approve_111_1','associate_a_approve_111_2','associate_a_approve_111_3','associate_a_approve_310_1_1','associate_a_approve_111_4');
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id IN ('associate_a_good_110','associate_a_good_310_1_1','associate_a_good_110_1','associate_a_good_110_2','associate_a_approve_111_1','associate_a_approve_111_2','associate_a_approve_111_3','associate_a_approve_310_1_1','associate_a_approve_111_4');

SELECT rowid,t.* from nbw.sys_element_hint t WHERE t.element_id in ('associate_a_good_110_1','associate_a_approve_111_1','associate_a_approve_111_2','associate_a_approve_111_3');--STANDARD_SIZE_CHART
SELECT rowid,t.* from nbw.sys_cond_rela t WHERE t.cond_id IN ('cond_associate_a_good_110','cond_associate_a_approve_110');
SELECT rowid,t.* from nbw.sys_cond_list t WHERE t.cond_id IN ('cond_associate_a_good_110','cond_associate_a_approve_110');
 
SELECT ROWID, t.*
  FROM nbw.sys_element t  
 WHERE t.element_id in ('action_a_approve_111_0','action_a_approve_100_0','action_a_good_310_1_1','action_a_good_310_1_2','action_a_good_310_2_1','action_a_approve_310_1_1','action_a_approve_310_1_2','action_a_approve_310_2_1','action_a_good_310_4_1','action_a_good_310_4_2','action_a_good_310_4_3','action_a_good_310_3_1','action_a_approve_310_3_1','action_a_approve_111_1','action_a_good_310_1_3');
SELECT ROWID, t.*
  FROM nbw.sys_action t
 WHERE t.element_id in ('action_a_approve_111_0','action_a_approve_100_0','action_a_good_310_1_1','action_a_good_310_1_2','action_a_good_310_2_1','action_a_approve_310_1_1','action_a_approve_310_1_2','action_a_approve_310_2_1','action_a_good_310_4_1','action_a_good_310_4_2','action_a_good_310_4_3','action_a_good_310_3_1','action_a_approve_310_3_1','action_a_approve_111_1','action_a_good_310_1_3');
SELECT ROWID, t.*
  FROM nbw.sys_item_element_rela t
 WHERE t.element_id in ('action_a_approve_111_0','action_a_approve_100_0','action_a_good_310_1_1','action_a_good_310_1_2','action_a_good_310_2_1','action_a_approve_310_1_1','action_a_approve_310_1_2','action_a_approve_310_2_1','action_a_good_310_4_1','action_a_good_310_4_2','action_a_good_310_4_3','action_a_good_310_3_1','action_a_approve_310_3_1','action_a_approve_111_1','action_a_good_310_1_3');
 
SELECT rowid,t.* from nbw.sys_cond_list t WHERE t.cond_id IN ('cond_action_a_good_310_1_2','cond_action_a_approve_310_1_2','cond_action_a_good_310_2_1','cond_action_a_approve_310_2_1');
SELECT rowid,t.* from nbw.sys_cond_rela t WHERE t.cond_id IN ('cond_action_a_good_310_1_2','cond_action_a_approve_310_1_2','cond_action_a_good_310_2_1','cond_action_a_approve_310_2_1');
SELECT rowid,t.* from nbw.sys_cond_operate t WHERE t.cond_id IN ('cond_action_a_good_310_1_2','cond_action_a_approve_310_1_2','cond_action_a_good_310_2_1','cond_action_a_approve_310_2_1');  

--字段控制
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('control_a_good_110_1','control_a_good_110_2');
SELECT rowid,t.* from nbw.sys_field_control t WHERE t.element_id IN ('control_a_good_110_1','control_a_good_110_2');--pick_a_quotation_111_5
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('control_a_good_110_1','control_a_good_110_2');--associate_a_approve_111_2,associate_a_approve_111_3,associate_a_good_110_1
 
SELECT rowid,t.* from nbw.sys_param_list t WHERE t.param_name IN ('SIZE_CHART_MOUDLE','GOO_SIZE_CHART_TYPE','NEW_SEQ_NUM'); 
SELECT rowid,t.* from nbw.sys_field_list t WHERE t.field_name IN ('SEQ_NUM','NEW_SEQ_NUM','MEASURE'); --未部署
SELECT rowid,t.* from nbw.sys_pivot_list t WHERE t.pivot_id IN ('p_a_good_310_1_2','p_a_approve_310_2','p_a_good_310_3','p_a_good_310_4','p_a_approve_310_3'); --a_approve_310_2
SELECT rowid,t.* from nbw.sys_item_rela t WHERE t.item_id IN ('a_good_310_2','a_approve_310_2','a_good_310_3','a_good_310_4','a_approve_310_3'); 

scmdata.pkg_size_chart    
scmdata.pkg_plat_comm 
scmdata.pkg_approve_version_size_chart 


SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id like '%a_approve_%'; 
SELECT rowid,t.* from nbw.sys_action t WHERE t.element_id = 'action_a_approve_111_0'; 
SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id = 'handle-hx_test_pivot'; 


SELECT rowid,t.* from bw3.sys_item_list t WHERE t.item_id IN ('a_good_110','a_approve_111','a_approve_112'); 
