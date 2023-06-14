SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('action_a_good_310_3_2','action_a_good_310_1_4','action_a_good_310_2_3','action_a_good_310_4_4','action_a_approve_310_3_2','action_a_approve_310_1_4','action_a_approve_310_2_3'); 
SELECT rowid,t.* from nbw.sys_action t WHERE t.element_id IN ('action_a_good_310_3_2','action_a_good_310_1_4','action_a_good_310_2_3','action_a_good_310_4_4','action_a_approve_310_3_2','action_a_approve_310_1_4','action_a_approve_310_2_3'); 
SELECT rowid,t.* from nbw.sys_associate t WHERE t.element_id IN ('associate_a_approve_111_2', 'associate_a_approve_111_3','associate_a_approve_111_4','associate_a_good_110_2');
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('action_a_good_310_3_2','action_a_good_310_1_4','action_a_good_310_2_3','action_a_good_310_4_4','action_a_approve_310_3_2','action_a_approve_310_1_4','action_a_approve_310_2_3'); 
SELECT rowid,t.* from nbw.sys_item t WHERE t.item_id IN ('a_good_110','a_approve_111','a_approve_112','a_good_310_1','a_good_310_2','a_good_310_3','a_good_310_4','a_approve_310_1','a_approve_310_2','a_approve_310_3');

SELECT rowid,t.* from nbw.sys_element t WHERE t.element_id IN ('control_a_good_310_3_1');
SELECT rowid,t.* from nbw.sys_field_control t WHERE t.element_id IN ('control_a_good_310_3_1');--pick_a_quotation_111_5
SELECT rowid,t.* from nbw.sys_item_element_rela t WHERE t.element_id IN ('control_a_good_310_3_1');
