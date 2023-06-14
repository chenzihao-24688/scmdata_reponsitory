--scmdata.pkg_production_progress
--scmdata.t_abnormal
--scmdata.pkg_production_progress_a
SELECT ROWID,t.* from bw3.sys_item t WHERE t.item_id IN ('a_product_110','a_product_118','a_product_120','a_product_120_1','a_product_120_2','a_order_101_0');
SELECT ROWID,t.* from bw3.sys_tree_list t WHERE t.item_id IN ('a_product_110','a_product_118','a_product_120','a_product_120_1','a_product_120_2','a_order_101_0');
SELECT ROWID,t.* from bw3.sys_item_list t WHERE t.item_id IN ('a_product_110','a_product_118','a_product_120','a_product_120_1','a_product_120_2','a_order_101_0');

SELECT ROWID, t.*
  FROM bw3.sys_element t
 WHERE t.element_id IN ('look_a_product_120_1','look_a_product_120_1_1','look_a_product_118_1','look_a_product_118_2','pick_a_product_120_1','assign_a_product_120_1');
 
SELECT ROWID, t.*  
  FROM bw3.sys_look_up t
 WHERE t.element_id IN ('look_a_product_120_1','look_a_product_120_1_1','look_a_product_118_1','look_a_product_118_2');--CHECK_GD_LINK_DESC,CHECK_LINK,CHECK_NUM,

SELECT rowid,t.* from bw3.sys_pick_list t WHERE t.element_id = 'pick_a_product_120_1';
SELECT rowid,t.* from bw3.sys_assign t WHERE t.element_id = 'assign_a_product_120_1'; 
 
SELECT ROWID, t.* FROM bw3.sys_action t WHERE t.element_id = 'action_a_product_118_5';

SELECT ROWID, t.*
  FROM bw3.sys_item_element_rela t
 WHERE t.element_id IN ('look_a_product_120_1','look_a_product_120_1_1','look_a_product_118_1','look_a_product_118_2','pick_a_product_120_1','assign_a_product_120_1');

--×Ö¶Î¿ØÖÆ 
--asso_a_coop_150_3   a.,
SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('control_a_product_120_1','control_a_product_118','control_a_product_118_1','control_a_product_118_2','control_a_product_120_2');
SELECT rowid,t.* from bw3.sys_field_control t WHERE t.element_id IN ('control_a_product_120_1','control_a_product_118','control_a_product_118_1','control_a_product_118_2','control_a_product_120_2');
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id IN ('control_a_product_120_1','control_a_product_118','control_a_product_118_1','control_a_product_118_2','control_a_product_120_2'); --AC_DATE
 
SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('associate_a_product_113','associate_a_qcqa_152_1','associate_a_product_120_1');
SELECT rowid,t.* from bw3.sys_associate t WHERE t.element_id IN ('associate_a_product_113','associate_a_qcqa_152_1','associate_a_product_120_1');
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id IN ('associate_a_product_113','associate_a_qcqa_152_1','associate_a_product_120_1');
SELECT rowid,t.* from bw3.sys_element_hint t WHERE t.element_id in ('associate_a_qcqa_152_1','associate_a_product_120_1') AND t.item_id IN ('a_product_120_1','a_product_120_2');
