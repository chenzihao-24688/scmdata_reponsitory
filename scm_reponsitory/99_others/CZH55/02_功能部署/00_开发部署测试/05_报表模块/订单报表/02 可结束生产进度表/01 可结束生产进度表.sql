BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_order_100';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'可结束生产进度表','a_report_order_100',null,null,'oracle_scmdata','a_report_order_100',0,null,0,null,'CATEGORY',5);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'可结束生产进度表','a_report_order_100',null,null,'oracle_scmdata','a_report_order_100',0,null,0,null,'CATEGORY',5 from dual) where item_id='a_report_order_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :=q'[{DECLARE
  v_sql CLOB;
  v_class_data_privs CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key     => 'COL_2');
  v_sql := scmdata.pkg_report_analy.f_finished_orders(p_company_id => %default_company_id%,p_class_data_privs => v_class_data_privs);
  @strresult := v_sql;
END;}]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_order_100';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,null,0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_100',null,'CATEGORY',null,13,null,null,null,0,null,null,null,null,null,0);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,null,0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_100',null,'CATEGORY',null,13,null,null,null,0,null,null,null,null,null,0 from dual) where item_id='a_report_order_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ABN_ORDER_CNT_N';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'异常有原因订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ABN_ORDER_CNT_N',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'异常有原因订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ABN_ORDER_CNT_N',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='ABN_ORDER_CNT_N';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CATE_ORDER_CNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'分部订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'CATE_ORDER_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'分部订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'CATE_ORDER_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='CATE_ORDER_CNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CATEGORY_NAME';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'分类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'CATEGORY_NAME',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'分类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'CATEGORY_NAME',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null from dual) where field_name='CATEGORY_NAME';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CATEGORY';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,1,'分类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,1,null,null,null,null,null,0,null,'CATEGORY',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,1,'分类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,1,null,null,null,null,null,0,null,'CATEGORY',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null from dual) where field_name='CATEGORY';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='NM_ORDER_CNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'正常订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'NM_ORDER_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'正常订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'NM_ORDER_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='NM_ORDER_CNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ABN_ORDER_CNT_NL';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'异常无原因订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ABN_ORDER_CNT_NL',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'异常无原因订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ABN_ORDER_CNT_NL',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='ABN_ORDER_CNT_NL';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_order_101';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'异常无原因订单列表','a_report_order_101',null,null,'oracle_scmdata','a_report_order_100_1',0,null,0,null,'PRODUCT_GRESS_ID',7);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'异常无原因订单列表','a_report_order_101',null,null,'oracle_scmdata','a_report_order_100_1',0,null,0,null,'PRODUCT_GRESS_ID',7 from dual) where item_id='a_report_order_101';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := scmdata.pkg_report_analy.f_get_orders_list(p_company_id => %default_company_id%,p_cate => :category,p_type => 0);
  @strresult := v_sql;
END;}]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_order_101';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,'product_gress_code_pr,rela_goo_id,style_number_pr,supplier_company_name_pr,deal_follower',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_101',null,'check_days,check_prom',null,13,null,null,null,0,null,null,null,null,null,0);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,'product_gress_code_pr,rela_goo_id,style_number_pr,supplier_company_name_pr,deal_follower',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_101',null,'check_days,check_prom',null,13,null,null,null,0,null,null,null,null,null,0 from dual) where item_id='a_report_order_101';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRODUCT_GRESS_CODE_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'生产订单编号',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'PRODUCT_GRESS_CODE_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'生产订单编号',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'PRODUCT_GRESS_CODE_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null from dual) where field_name='PRODUCT_GRESS_CODE_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SUPPLIER_COMPANY_ABBREVIATION';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'供应商简称',0,null,null,null,null,null,0,null,null,null,null,null,0,null,1,null,null,null,null,null,0,null,'SUPPLIER_COMPANY_ABBREVIATION',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'供应商简称',0,null,null,null,null,null,0,null,null,null,null,null,0,null,1,null,null,null,null,null,0,null,'SUPPLIER_COMPANY_ABBREVIATION',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null from dual) where field_name='SUPPLIER_COMPANY_ABBREVIATION';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='STYLE_NUMBER_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'款号',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'STYLE_NUMBER_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'款号',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'STYLE_NUMBER_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null from dual) where field_name='STYLE_NUMBER_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ORDER_AMOUNT_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'订单数量',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'ORDER_AMOUNT_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'订单数量',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'ORDER_AMOUNT_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null from dual) where field_name='ORDER_AMOUNT_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_CAUSE_CLASS_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'延期原因分类',1,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_CAUSE_CLASS_PR',null,null,null,null,null,0,null,null,null,null,1,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'延期原因分类',1,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_CAUSE_CLASS_PR',null,null,null,null,null,0,null,null,null,null,1,3,null,null,null from dual) where field_name='DELAY_CAUSE_CLASS_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='RELA_GOO_ID';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'货号',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'RELA_GOO_ID',null,null,null,null,null,0,0,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'货号',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'RELA_GOO_ID',null,null,null,null,null,0,0,null,null,null,0,3,null,null,null from dual) where field_name='RELA_GOO_ID';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELIVERY_DATE_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'订单交期',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DELIVERY_DATE_PR',null,null,null,null,null,0,null,null,'yyyy-MM-dd','12',0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'订单交期',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DELIVERY_DATE_PR',null,null,null,null,null,0,null,null,'yyyy-MM-dd','12',0,3,null,null,null from dual) where field_name='DELIVERY_DATE_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PROBLEM_DESC_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'问题描述',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'PROBLEM_DESC_PR',null,null,null,null,null,0,null,null,null,'18',0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'问题描述',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'PROBLEM_DESC_PR',null,null,null,null,null,0,null,null,null,'18',0,3,null,null,null from dual) where field_name='PROBLEM_DESC_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SAMLL_CATEGORY';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,1,'产品子类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'SAMLL_CATEGORY',null,null,null,null,null,0,0,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,1,'产品子类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'SAMLL_CATEGORY',null,null,null,null,null,0,0,null,null,null,0,3,null,null,null from dual) where field_name='SAMLL_CATEGORY';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ACTUAL_DELAY_DAY_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'实际延误天数',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'ACTUAL_DELAY_DAY_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'实际延误天数',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'ACTUAL_DELAY_DAY_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null from dual) where field_name='ACTUAL_DELAY_DAY_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DEAL_FOLLOWER';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'跟单员',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DEAL_FOLLOWER',null,null,null,null,null,0,0,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'跟单员',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DEAL_FOLLOWER',null,null,null,null,null,0,0,null,null,null,0,0,null,null,null from dual) where field_name='DEAL_FOLLOWER';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_PROBLEM_CLASS_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'延期问题分类',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_PROBLEM_CLASS_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'延期问题分类',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_PROBLEM_CLASS_PR',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null from dual) where field_name='DELAY_PROBLEM_CLASS_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='FINISH_TIME_PANDA';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'熊猫结束时间',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'FINISH_TIME_PANDA',null,null,null,null,null,0,0,0,'yyyy-MM-dd','12',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'熊猫结束时间',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'FINISH_TIME_PANDA',null,null,null,null,null,0,0,0,'yyyy-MM-dd','12',1,0,null,null,null from dual) where field_name='FINISH_TIME_PANDA';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_CAUSE_DETAILED_PR';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'延期原因细分',1,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_CAUSE_DETAILED_PR',null,null,null,null,null,0,null,null,null,null,1,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'延期原因细分',1,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_CAUSE_DETAILED_PR',null,null,null,null,null,0,null,null,null,null,1,3,null,null,null from dual) where field_name='DELAY_CAUSE_DETAILED_PR';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_order_102';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'异常有原因订单列表','a_report_order_102',null,null,'oracle_scmdata','a_report_order_100_2',0,null,0,null,'PRODUCT_GRESS_ID',7);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'异常有原因订单列表','a_report_order_102',null,null,'oracle_scmdata','a_report_order_100_2',0,null,0,null,'PRODUCT_GRESS_ID',7 from dual) where item_id='a_report_order_102';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := scmdata.pkg_report_analy.f_get_orders_list(p_company_id => %default_company_id%,p_cate => :category,p_type => 1);
  @strresult := v_sql;
END;}]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_order_102';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,'product_gress_code_pr,rela_goo_id,style_number_pr,supplier_company_name_pr,deal_follower',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_102',null,'check_days,check_prom',null,13,null,null,null,0,null,null,null,null,null,0);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,'product_gress_code_pr,rela_goo_id,style_number_pr,supplier_company_name_pr,deal_follower',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_102',null,'check_days,check_prom',null,13,null,null,null,0,null,null,null,null,null,0 from dual) where item_id='a_report_order_102';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_order_103';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'正常订单列表','a_report_order_103',null,null,'oracle_scmdata','a_report_order_100_3',0,null,0,null,'PRODUCT_GRESS_ID',7);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'正常订单列表','a_report_order_103',null,null,'oracle_scmdata','a_report_order_100_3',0,null,0,null,'PRODUCT_GRESS_ID',7 from dual) where item_id='a_report_order_103';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := scmdata.pkg_report_analy.f_get_orders_list(p_company_id => %default_company_id%,p_cate => :category,p_type => 2);
  @strresult := v_sql;
END;}]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_order_103';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,'product_gress_code_pr,rela_goo_id,style_number_pr,supplier_company_name_pr,deal_follower',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_103',null,'check_days,check_prom',null,13,null,null,null,0,null,null,null,null,null,0);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,'product_gress_code_pr,rela_goo_id,style_number_pr,supplier_company_name_pr,deal_follower',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_103',null,'check_days,check_prom',null,13,null,null,null,0,null,null,null,null,null,0 from dual) where item_id='a_report_order_103';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_order_104';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'分部订单列表','a_report_order_104',null,null,'oracle_scmdata','a_report_order_100_4',0,null,0,null,'PRODUCT_GRESS_ID',7);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'分部订单列表','a_report_order_104',null,null,'oracle_scmdata','a_report_order_100_4',0,null,0,null,'PRODUCT_GRESS_ID',7 from dual) where item_id='a_report_order_104';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      select_sql_VAL CLOB :=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := scmdata.pkg_report_analy.f_get_orders_list(p_company_id => %default_company_id%,p_cate => :category,p_type => 3);
  @strresult := v_sql;
END;}]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_order_104';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,'product_gress_code_pr,rela_goo_id,style_number_pr,supplier_company_name_pr,deal_follower',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_104',null,'check_days,check_prom',null,13,null,null,null,0,null,null,null,null,null,0);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'1',0,null,1,null,null,'product_gress_code_pr,rela_goo_id,style_number_pr,supplier_company_name_pr,deal_follower',0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_order_104',null,'check_days,check_prom',null,13,null,null,null,0,null,null,null,null,null,0 from dual) where item_id='a_report_order_104';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_report_order_100_1')  and ELEMENT_ID = 'action_a_report_order_100_1';
       IF V_CNT=0 THEN   
           insert into SYS_ELEMENT (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission)
           values (0,null,null,null,'action_a_report_order_100_1','action',null,'oracle_scmdata',1,0);
       ELSE 
           update SYS_ELEMENT set (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission) = (select 0,null,null,null,'action_a_report_order_100_1','action',null,'oracle_scmdata',1,0 from dual) where element_id in ('action_a_report_order_100_1')  and ELEMENT_ID = 'action_a_report_order_100_1';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      action_sql_VAL CLOB :=q'[select 1 from dual]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_report_order_100_1')  and ELEMENT_ID = 'action_a_report_order_100_1';
       IF V_CNT=0 THEN   
           insert into SYS_ACTION (action_sql,port_type,selection_method,action_type,filter_express,pre_flag,select_fields,refresh_flag,selection_flag,caption,lock_sql,element_id,operate_mode,icon_name,call_id,multi_page_flag,query_fields,port_id,update_fields,port_sql)
           values (action_sql_VAL,1,null,4,null,null,null,1,0,'异常无原因订单数',null,'action_a_report_order_100_1',null,null,null,1,null,null,null,null);
       ELSE 
           update SYS_ACTION set (action_sql,port_type,selection_method,action_type,filter_express,pre_flag,select_fields,refresh_flag,selection_flag,caption,lock_sql,element_id,operate_mode,icon_name,call_id,multi_page_flag,query_fields,port_id,update_fields,port_sql) = (select action_sql_VAL,1,null,4,null,null,null,1,0,'异常无原因订单数',null,'action_a_report_order_100_1',null,null,null,1,null,null,null,null from dual) where element_id in ('action_a_report_order_100_1')  and ELEMENT_ID = 'action_a_report_order_100_1';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_report_order_100' and element_id in ('action_a_report_order_100_1')  and ELEMENT_ID = 'action_a_report_order_100_1';
       IF V_CNT=0 THEN   
           insert into sys_item_element_rela (seq_no,item_id,element_id,level_no,pause)
           values (1,'a_report_order_100','action_a_report_order_100_1',null,0);
       ELSE 
           update sys_item_element_rela set (seq_no,item_id,element_id,level_no,pause) = (select 1,'a_report_order_100','action_a_report_order_100_1',null,0 from dual) where item_id='a_report_order_100' and element_id in ('action_a_report_order_100_1')  and ELEMENT_ID = 'action_a_report_order_100_1';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_web_union where item_id='a_product_101' and union_item_id = 'a_report_order_100';
       IF V_CNT=0 THEN   
           insert into sys_web_union (union_item_id,seqno,item_id,pause)
           values ('a_report_order_100',2,'a_product_101',0);
       ELSE 
           update sys_web_union set (union_item_id,seqno,item_id,pause) = (select 'a_report_order_100',2,'a_product_101',0 from dual) where item_id='a_product_101' and union_item_id = 'a_report_order_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_LINK_LIST where item_id='a_report_order_100' and field_name = 'ABN_ORDER_CNT_N';
       IF V_CNT=0 THEN   
           insert into SYS_LINK_LIST (item_id,to_item_id,null_item_id,pause,field_name)
           values ('a_report_order_100','a_report_order_102','a_report_order_102',0,'ABN_ORDER_CNT_N');
       ELSE 
           update SYS_LINK_LIST set (item_id,to_item_id,null_item_id,pause,field_name) = (select 'a_report_order_100','a_report_order_102','a_report_order_102',0,'ABN_ORDER_CNT_N' from dual) where item_id='a_report_order_100' and field_name = 'ABN_ORDER_CNT_N';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_LINK_LIST where item_id='a_report_order_100' and field_name = 'ABN_ORDER_CNT_NL';
       IF V_CNT=0 THEN   
           insert into SYS_LINK_LIST (item_id,to_item_id,null_item_id,pause,field_name)
           values ('a_report_order_100','a_report_order_101','a_report_order_101',0,'ABN_ORDER_CNT_NL');
       ELSE 
           update SYS_LINK_LIST set (item_id,to_item_id,null_item_id,pause,field_name) = (select 'a_report_order_100','a_report_order_101','a_report_order_101',0,'ABN_ORDER_CNT_NL' from dual) where item_id='a_report_order_100' and field_name = 'ABN_ORDER_CNT_NL';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_LINK_LIST where item_id='a_report_order_100' and field_name = 'CATE_ORDER_CNT';
       IF V_CNT=0 THEN   
           insert into SYS_LINK_LIST (item_id,to_item_id,null_item_id,pause,field_name)
           values ('a_report_order_100','a_report_order_104','a_report_order_104',0,'CATE_ORDER_CNT');
       ELSE 
           update SYS_LINK_LIST set (item_id,to_item_id,null_item_id,pause,field_name) = (select 'a_report_order_100','a_report_order_104','a_report_order_104',0,'CATE_ORDER_CNT' from dual) where item_id='a_report_order_100' and field_name = 'CATE_ORDER_CNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_LINK_LIST where item_id='a_report_order_100' and field_name = 'NM_ORDER_CNT';
       IF V_CNT=0 THEN   
           insert into SYS_LINK_LIST (item_id,to_item_id,null_item_id,pause,field_name)
           values ('a_report_order_100','a_report_order_103','a_report_order_103',0,'NM_ORDER_CNT');
       ELSE 
           update SYS_LINK_LIST set (item_id,to_item_id,null_item_id,pause,field_name) = (select 'a_report_order_100','a_report_order_103','a_report_order_103',0,'NM_ORDER_CNT' from dual) where item_id='a_report_order_100' and field_name = 'NM_ORDER_CNT';
       END IF;
   END;
END;
/

