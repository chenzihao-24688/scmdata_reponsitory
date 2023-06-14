SELECT rowid,t.* from bw3.sys_pick_list t WHERE t.element_id IN ('pick_a_fabric_2','pick_a_quotation_111_3');
SELECT rowid,t.* from bw3.sys_element t WHERE t.element_id IN ('control_a_quotation_111_5','control_a_quotation_111_3','fc_a_fabric_111');
SELECT rowid,t.* from bw3.sys_field_control t WHERE t.element_id IN ('control_a_quotation_111_5','control_a_quotation_111_3','fc_a_fabric_111');--pick_a_quotation_111_5
SELECT rowid,t.* from bw3.sys_item_element_rela t WHERE t.element_id IN ('control_a_quotation_111_5','control_a_quotation_111_3','fc_a_fabric_111');
