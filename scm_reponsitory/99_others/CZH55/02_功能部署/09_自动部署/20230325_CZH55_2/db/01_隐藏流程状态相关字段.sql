UPDATE bw3.sys_item_list t SET t.noshow_fields = 'ask_record_id,log_id,status_bf_oper,status_af_oper,flow_node_name_af,flow_node_status_desc_af' WHERE t.item_id IN ('a_coop_106','a_coop_133_1'); 
UPDATE bw3.sys_field_list_file t SET t.file_count = 20 WHERE t.field_name IN ('AR_OTHER_INFORMATION_N','ASK_OTHER_FILES','SP_OTHER_INFORMATION_N'); 
/