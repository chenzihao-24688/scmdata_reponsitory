BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_abn_200';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'manylist',null,null,null,null,null,null,null,null,null,'订单满足率异常分析','a_report_abn_200',null,null,'oracle_scmdata',null,0,null,null,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'manylist',null,null,null,null,null,null,null,null,null,'订单满足率异常分析','a_report_abn_200',null,null,'oracle_scmdata',null,0,null,null,null,null,null from dual) where item_id='a_report_abn_200';
       END IF;
   END;
END;
/


BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_abn_201';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常原因','a_report_abn_201',null,null,'oracle_scmdata',null,0,null,0,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常原因','a_report_abn_201',null,null,'oracle_scmdata',null,0,null,0,null,null,null from dual) where item_id='a_report_abn_201';
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
  v_sql := scmdata.pkg_report_analy.f_get_abn_cause_report(p_company_id         => %default_company_id%,
                                                           p_class_data_privs   => v_class_data_privs,
                                                           p_abn_year           => @abn_year@,
                                                           p_abn_date_type      => @abn_date_type@,
                                                           p_abn_date           => @abn_date@,
                                                           p_abn_category       => @abn_category@,
                                                           p_abn_group          => @abn_group@,
                                                           p_abnc_fileds_type   => @abnc_fileds_type@,
                                                           p_abnc_fileds_type_a => @abnc_fileds_type_a@);

  @strresult := v_sql;
END;}]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_abn_201';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'0',0,null,1,null,null,null,0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_201',null,'DELAY_OT,DELAY_FS,DELAY_S',null,13,null,null,null,0,null,null,null,null,null,0);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,1,'20,30,50,100,200,500',null,null,null,null,null,0,null,'0',0,null,1,null,null,null,0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_201',null,'DELAY_OT,DELAY_FS,DELAY_S',null,13,null,null,null,0,null,null,null,null,null,0 from dual) where item_id='a_report_abn_201';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_CAUSE_CLASS';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'延期原因分类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DELAY_CAUSE_CLASS',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'延期原因分类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DELAY_CAUSE_CLASS',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null from dual) where field_name='DELAY_CAUSE_CLASS';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_OTP';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'延期天数≤3(%)',0,0,null,0,0,null,0,0,null,null,null,0,0,1,0,null,0,null,null,null,0,null,'DELAY_OTP',null,null,null,null,null,0,0,0,'0.000','14',0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'延期天数≤3(%)',0,0,null,0,0,null,0,0,null,null,null,0,0,1,0,null,0,null,null,null,0,null,'DELAY_OTP',null,null,null,null,null,0,0,0,'0.000','14',0,0,null,null,null from dual) where field_name='DELAY_OTP';
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
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='IS_SUP_RESPONSIBLE';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'供应商是否免责',1,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'IS_SUP_RESPONSIBLE',null,null,null,null,null,0,null,null,null,'17',1,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'供应商是否免责',1,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'IS_SUP_RESPONSIBLE',null,null,null,null,null,0,null,null,null,'17',1,3,null,null,null from dual) where field_name='IS_SUP_RESPONSIBLE';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_OT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'延期天数≤3',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_OT',null,null,null,null,null,0,0,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'延期天数≤3',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_OT',null,null,null,null,null,0,0,null,null,null,0,0,null,null,null from dual) where field_name='DELAY_OT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='GROUP_NAME';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'分组名称',0,null,null,null,null,null,0,null,null,null,null,null,0,null,1,null,null,null,null,null,0,null,'GROUP_NAME',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'分组名称',0,null,null,null,null,null,0,null,null,null,null,null,0,null,1,null,null,null,null,null,0,null,'GROUP_NAME',null,null,null,null,null,0,null,null,null,null,0,3,null,null,null from dual) where field_name='GROUP_NAME';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ABN_SUM_PROPOTION';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'占比(%)',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'ABN_SUM_PROPOTION',null,null,null,null,null,0,0,null,'0.000','14',0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'占比(%)',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'ABN_SUM_PROPOTION',null,null,null,null,null,0,0,null,'0.000','14',0,0,null,null,null from dual) where field_name='ABN_SUM_PROPOTION';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_FSP';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'4天≤延期天数≤6(%)',0,0,null,0,0,null,0,0,null,null,null,0,0,1,0,null,0,null,null,null,0,null,'DELAY_FSP',null,null,null,null,null,0,0,0,'0.000','14',0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'4天≤延期天数≤6(%)',0,0,null,0,0,null,0,0,null,null,null,0,0,1,0,null,0,null,null,null,0,null,'DELAY_FSP',null,null,null,null,null,0,0,0,'0.000','14',0,0,null,null,null from dual) where field_name='DELAY_FSP';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_FS';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'4天≤延期天数≤6',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_FS',null,null,null,null,null,0,0,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'4天≤延期天数≤6',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_FS',null,null,null,null,null,0,0,null,null,null,0,0,null,null,null from dual) where field_name='DELAY_FS';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_CAUSE_DETAILED';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'延期原因细分',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DELAY_CAUSE_DETAILED',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'延期原因细分',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DELAY_CAUSE_DETAILED',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null from dual) where field_name='DELAY_CAUSE_DETAILED';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ABN_MONEY';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'异常金额',0,0,null,0,0,null,0,0,null,null,null,0,0,1,0,null,0,null,null,null,0,null,'ABN_MONEY',null,null,null,null,null,0,0,0,'0.00','10',0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'异常金额',0,0,null,0,0,null,0,0,null,null,null,0,0,1,0,null,0,null,null,null,0,null,'ABN_MONEY',null,null,null,null,null,0,0,0,'0.00','10',0,0,null,null,null from dual) where field_name='ABN_MONEY';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_SP';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'延期天数≥7(%)',0,0,null,0,0,null,0,0,null,null,null,0,0,1,0,null,0,null,null,null,0,null,'DELAY_SP',null,null,null,null,null,0,0,0,'0.000','14',0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'延期天数≥7(%)',0,0,null,0,0,null,0,0,null,null,null,0,0,1,0,null,0,null,null,null,0,null,'DELAY_SP',null,null,null,null,null,0,0,0,'0.000','14',0,0,null,null,null from dual) where field_name='DELAY_SP';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_PROBLEM_CLASS';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'延期问题分类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DELAY_PROBLEM_CLASS',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'延期问题分类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'DELAY_PROBLEM_CLASS',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null from dual) where field_name='DELAY_PROBLEM_CLASS';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DELAY_S';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'延期天数≥7',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_S',null,null,null,null,null,0,0,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'延期天数≥7',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'DELAY_S',null,null,null,null,null,0,0,null,null,null,0,0,null,null,null from dual) where field_name='DELAY_S';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_abn_202';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常分布','a_report_abn_202',null,null,'oracle_scmdata',null,0,null,null,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,null,null,null,null,null,null,null,null,'异常分布','a_report_abn_202',null,null,'oracle_scmdata',null,0,null,null,null,null,null from dual) where item_id='a_report_abn_202';
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
  v_sql := scmdata.pkg_report_analy.f_get_abn_distribut_report(p_company_id       => %default_company_id%,
                                                               p_class_data_privs => v_class_data_privs,
                                                               p_abn_year         => @abn_year@,
                                                               p_abn_date_type    => @abn_date_type@,
                                                               p_abn_date         => @abn_date@,
                                                               p_abn_category     => @abn_category@,
                                                               p_abnf_fileds_type => @abnf_fileds_type@,
                                                               p_abn_group        => @abn_group@);

  @strresult := v_sql;
END;}]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_abn_202';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,null,'20,30,50,100,200,500',null,null,null,null,null,null,null,null,null,null,1,null,null,null,null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_202',null,null,null,13,null,null,null,null,null,null,null,null,null,null);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,null,'20,30,50,100,200,500',null,null,null,null,null,null,null,null,null,null,1,null,null,null,null,null,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_abn_202',null,null,null,13,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_report_abn_202';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRODUCT_SUBCLASS_NAME';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'产品子类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'PRODUCT_SUBCLASS_NAME',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'产品子类',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'PRODUCT_SUBCLASS_NAME',null,null,null,null,null,0,null,null,null,null,0,0,null,null,null from dual) where field_name='PRODUCT_SUBCLASS_NAME';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ORDER_MONEY';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'订货金额(￥)',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'ORDER_MONEY',null,null,null,null,null,0,null,null,'0.00','10',0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'订货金额(￥)',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'ORDER_MONEY',null,null,null,null,null,0,null,null,'0.00','10',0,0,null,null,null from dual) where field_name='ORDER_MONEY';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ABN_MONEY_PROPOTION';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'异常占比(%)',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'ABN_MONEY_PROPOTION',null,null,null,null,null,0,0,null,'0.000','14',0,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'异常占比(%)',0,null,null,null,null,null,0,null,null,null,null,null,0,1,0,null,null,null,null,null,0,null,'ABN_MONEY_PROPOTION',null,null,null,null,null,0,0,null,'0.000','14',0,0,null,null,null from dual) where field_name='ABN_MONEY_PROPOTION';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_delivery_100';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'menu',null,null,null,null,null,null,null,null,null,'交期','a_report_delivery_100',null,null,null,null,0,null,null,null,null,null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'menu',null,null,null,null,null,null,null,null,null,'交期','a_report_delivery_100',null,null,null,null,0,null,null,null,null,null from dual) where item_id='a_report_delivery_100';
       END IF;
   END;
END;
/


BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_delivery_101_1';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,1,'t_production_progress',null,null,null,null,null,null,'未完成订单延期情况统计','a_report_delivery_101_1',null,null,'oracle_scmdata',null,0,null,0,null,'PRODUCT_GRESS_ID',null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,1,'t_production_progress',null,null,null,null,null,null,'未完成订单延期情况统计','a_report_delivery_101_1',null,null,'oracle_scmdata',null,0,null,0,null,'PRODUCT_GRESS_ID',null from dual) where item_id='a_report_delivery_101_1';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      delete_sql_VAL CLOB :=q'[delete from T_PRODUCTION_PROGRESS where PRODUCT_GRESS_ID = :PRODUCT_GRESS_ID]';insert_sql_VAL CLOB :=q'[insert into T_PRODUCTION_PROGRESS (
	PRODUCT_GRESS_ID,
	COMPANY_ID,
	PRODUCT_GRESS_CODE,
	ORDER_ID,
	PROGRESS_STATUS,
	GOO_ID,
	SUPPLIER_CODE,
	FACTORY_CODE,
	FORECAST_DELIVERY_DATE,
	FORECAST_DELAY_DAY,
	ACTUAL_DELIVERY_DATE,
	ACTUAL_DELAY_DAY,
	LATEST_PLANNED_DELIVERY_DATE,
	ORDER_AMOUNT,
	DELIVERY_AMOUNT,
	APPROVE_EDITION,
	FABRIC_CHECK,
	QC_QUALITY_CHECK,
	EXCEPTION_HANDLE_STATUS,
	HANDLE_OPINIONS,
	CREATE_ID,
	CREATE_TIME,
	ORIGIN,
	MEMO,
	QC_CHECK,
	QA_CHECK,
	ORDER_STATUS,
	DELAY_PROBLEM_CLASS,
	DELAY_CAUSE_CLASS,
	DELAY_CAUSE_DETAILED,
	PROBLEM_DESC,
	IS_SUP_RESPONSIBLE,
	RESPONSIBLE_DEPT,
	RESPONSIBLE_DEPT_SEC,
	ORDER_FULL_RATE,
	CHECK_LINK,
	IS_QUALITY,
	IS_ORDER_REAMEM_UPD,
	UPDATE_COMPANY_ID,
	UPDATE_ID,
	UPDATE_TIME,
	PRODUCT_GRESS_REMARKS) 
values (
	:PRODUCT_GRESS_ID,
	:COMPANY_ID,
	:PRODUCT_GRESS_CODE,
	:ORDER_ID,
	:PROGRESS_STATUS,
	:GOO_ID,
	:SUPPLIER_CODE,
	:FACTORY_CODE,
	:FORECAST_DELIVERY_DATE,
	:FORECAST_DELAY_DAY,
	:ACTUAL_DELIVERY_DATE,
	:ACTUAL_DELAY_DAY,
	:LATEST_PLANNED_DELIVERY_DATE,
	:ORDER_AMOUNT,
	:DELIVERY_AMOUNT,
	:APPROVE_EDITION,
	:FABRIC_CHECK,
	:QC_QUALITY_CHECK,
	:EXCEPTION_HANDLE_STATUS,
	:HANDLE_OPINIONS,
	:CREATE_ID,
	:CREATE_TIME,
	:ORIGIN,
	:MEMO,
	:QC_CHECK,
	:QA_CHECK,
	:ORDER_STATUS,
	:DELAY_PROBLEM_CLASS,
	:DELAY_CAUSE_CLASS,
	:DELAY_CAUSE_DETAILED,
	:PROBLEM_DESC,
	:IS_SUP_RESPONSIBLE,
	:RESPONSIBLE_DEPT,
	:RESPONSIBLE_DEPT_SEC,
	:ORDER_FULL_RATE,
	:CHECK_LINK,
	:IS_QUALITY,
	:IS_ORDER_REAMEM_UPD,
	:UPDATE_COMPANY_ID,
	:UPDATE_ID,
	:UPDATE_TIME,
	:PRODUCT_GRESS_REMARKS)]';select_sql_VAL CLOB :=q'[{DECLARE
  v_sql CLOB;
  v_class_data_privs CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key     => 'COL_2');
  
  v_sql := scmdata.pkg_report_analy.f_unfinished_delay_orders(p_company_id  =>%default_company_id%,
                                                            p_class_data_privs => v_class_data_privs,                                                           
                                                            p_date_type   =>@RDL_DATE_TYPE@,
                                                            p_start_time  =>@RDL_BEGIN_TIME@,
                                                            p_end_time    =>@RDL_END_TIME@,
                                                            p_cate        =>@RDL_CATEGORY@,
                                                            p_fileds_type =>@RDL_FILEDS_TYPE@,
                                                            p_follower    =>@RDL_FOLLOWER@,
                                                            p_small_cate  =>@RDL_SMALL_CATE@,
                                                            p_sup         =>@RDL_SUPP@);
 @strresult := v_sql;
END;
}]';update_sql_VAL CLOB :=q'[update T_PRODUCTION_PROGRESS set 
	PRODUCT_GRESS_ID             = :PRODUCT_GRESS_ID,
	COMPANY_ID                   = :COMPANY_ID,
	PRODUCT_GRESS_CODE           = :PRODUCT_GRESS_CODE,
	ORDER_ID                     = :ORDER_ID,
	PROGRESS_STATUS              = :PROGRESS_STATUS,
	GOO_ID                       = :GOO_ID,
	SUPPLIER_CODE                = :SUPPLIER_CODE,
	FACTORY_CODE                 = :FACTORY_CODE,
	FORECAST_DELIVERY_DATE       = :FORECAST_DELIVERY_DATE,
	FORECAST_DELAY_DAY           = :FORECAST_DELAY_DAY,
	ACTUAL_DELIVERY_DATE         = :ACTUAL_DELIVERY_DATE,
	ACTUAL_DELAY_DAY             = :ACTUAL_DELAY_DAY,
	LATEST_PLANNED_DELIVERY_DATE = :LATEST_PLANNED_DELIVERY_DATE,
	ORDER_AMOUNT                 = :ORDER_AMOUNT,
	DELIVERY_AMOUNT              = :DELIVERY_AMOUNT,
	APPROVE_EDITION              = :APPROVE_EDITION,
	FABRIC_CHECK                 = :FABRIC_CHECK,
	QC_QUALITY_CHECK             = :QC_QUALITY_CHECK,
	EXCEPTION_HANDLE_STATUS      = :EXCEPTION_HANDLE_STATUS,
	HANDLE_OPINIONS              = :HANDLE_OPINIONS,
	CREATE_ID                    = :CREATE_ID,
	CREATE_TIME                  = :CREATE_TIME,
	ORIGIN                       = :ORIGIN,
	MEMO                         = :MEMO,
	QC_CHECK                     = :QC_CHECK,
	QA_CHECK                     = :QA_CHECK,
	ORDER_STATUS                 = :ORDER_STATUS,
	DELAY_PROBLEM_CLASS          = :DELAY_PROBLEM_CLASS,
	DELAY_CAUSE_CLASS            = :DELAY_CAUSE_CLASS,
	DELAY_CAUSE_DETAILED         = :DELAY_CAUSE_DETAILED,
	PROBLEM_DESC                 = :PROBLEM_DESC,
	IS_SUP_RESPONSIBLE           = :IS_SUP_RESPONSIBLE,
	RESPONSIBLE_DEPT             = :RESPONSIBLE_DEPT,
	RESPONSIBLE_DEPT_SEC         = :RESPONSIBLE_DEPT_SEC,
	ORDER_FULL_RATE              = :ORDER_FULL_RATE,
	CHECK_LINK                   = :CHECK_LINK,
	IS_QUALITY                   = :IS_QUALITY,
	IS_ORDER_REAMEM_UPD          = :IS_ORDER_REAMEM_UPD,
	UPDATE_COMPANY_ID            = :UPDATE_COMPANY_ID,
	UPDATE_ID                    = :UPDATE_ID,
	UPDATE_TIME                  = :UPDATE_TIME,
	PRODUCT_GRESS_REMARKS        = :PRODUCT_GRESS_REMARKS 
where PRODUCT_GRESS_ID=:OLD_PRODUCT_GRESS_ID]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_delivery_101_1';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,1,null,null,null,null,null,delete_sql_VAL,0,null,'1',0,insert_sql_VAL,1,null,null,null,0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_delivery_101_1',null,null,null,13,null,null,null,0,null,update_sql_VAL,null,null,null,0);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,1,null,null,null,null,null,delete_sql_VAL,0,null,'1',0,insert_sql_VAL,1,null,null,null,0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_delivery_101_1',null,null,null,13,null,null,null,0,null,update_sql_VAL,null,null,null,0 from dual) where item_id='a_report_delivery_101_1';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DEAL_FOLLOWER_NAME';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'跟单员',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'DEAL_FOLLOWER_NAME',null,null,null,null,null,0,0,0,null,'0',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'跟单员',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'DEAL_FOLLOWER_NAME',null,null,null,null,null,0,0,0,null,'0',1,0,null,null,null from dual) where field_name='DEAL_FOLLOWER_NAME';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRE_OWE_GOO_CNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'欠货款数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PRE_OWE_GOO_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'欠货款数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PRE_OWE_GOO_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='PRE_OWE_GOO_CNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ACT_OWE_GOO_CNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'欠货款数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ACT_OWE_GOO_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'欠货款数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ACT_OWE_GOO_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='ACT_OWE_GOO_CNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRE_OWE_AMOUNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'欠货量',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PRE_OWE_AMOUNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'欠货量',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PRE_OWE_AMOUNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='PRE_OWE_AMOUNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRE_OWE_PRICE_PROM';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'预计延期金额占比',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PRE_OWE_PRICE_PROM',null,null,null,null,null,0,0,0,'0.000','14',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'预计延期金额占比',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PRE_OWE_PRICE_PROM',null,null,null,null,null,0,0,0,'0.000','14',1,0,null,null,null from dual) where field_name='PRE_OWE_PRICE_PROM';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='OWE_PRICE';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'欠货金额',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'OWE_PRICE',null,null,null,null,null,0,0,0,null,null,1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'欠货金额',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'OWE_PRICE',null,null,null,null,null,0,0,0,null,null,1,0,null,null,null from dual) where field_name='OWE_PRICE';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ACT_OWE_PRICE_PROM';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'已延期金额占比',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ACT_OWE_PRICE_PROM',null,null,null,null,null,0,0,0,'0.000','14',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'已延期金额占比',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ACT_OWE_PRICE_PROM',null,null,null,null,null,0,0,0,'0.000','14',1,0,null,null,null from dual) where field_name='ACT_OWE_PRICE_PROM';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='OWE_AMOUNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'欠货量',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'OWE_AMOUNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'欠货量',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'OWE_AMOUNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='OWE_AMOUNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRE_OWE_PRICE';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'预计延期金额',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PRE_OWE_PRICE',null,null,null,null,null,0,0,0,null,null,1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'预计延期金额',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PRE_OWE_PRICE',null,null,null,null,null,0,0,0,null,null,1,0,null,null,null from dual) where field_name='PRE_OWE_PRICE';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ACT_OWE_PRICE';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'已延期金额',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ACT_OWE_PRICE',null,null,null,null,null,0,0,0,null,null,1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'已延期金额',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ACT_OWE_PRICE',null,null,null,null,null,0,0,0,null,null,1,0,null,null,null from dual) where field_name='ACT_OWE_PRICE';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ACT_OWE_AMOUNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'欠货量',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ACT_OWE_AMOUNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'欠货量',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ACT_OWE_AMOUNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='ACT_OWE_AMOUNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='OWE_GOO_CNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'欠货款数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'OWE_GOO_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'欠货款数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'OWE_GOO_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='OWE_GOO_CNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_report_prostatus_100';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid)
           values (null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'未完成订单生产进度状态分析','a_report_prostatus_100',null,null,'oracle_scmdata',null,0,null,0,null,'PRODUCT_GRESS_ID',null);
       ELSE 
           update SYS_ITEM set (panel_id,badge_sql,link_field,item_type,memo,enable_stand_permission,base_table,tag_id,name_field,config_params,offline_flag,help_id,report_title,caption_sql,item_id,sub_scripts,fix_caption,data_source,setting_id,pause,badge_flag,time_out,init_show,key_field,show_rowid) = (select null,null,null,'list',null,1,'T_PRODUCTION_PROGRESS',null,null,null,null,null,null,'未完成订单生产进度状态分析','a_report_prostatus_100',null,null,'oracle_scmdata',null,0,null,0,null,'PRODUCT_GRESS_ID',null from dual) where item_id='a_report_prostatus_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      delete_sql_VAL CLOB :=q'[delete from T_PRODUCTION_PROGRESS where PRODUCT_GRESS_ID = :PRODUCT_GRESS_ID]';insert_sql_VAL CLOB :=q'[insert into T_PRODUCTION_PROGRESS (
	PRODUCT_GRESS_ID,
	COMPANY_ID,
	PRODUCT_GRESS_CODE,
	ORDER_ID,
	PROGRESS_STATUS,
	GOO_ID,
	SUPPLIER_CODE,
	FACTORY_CODE,
	FORECAST_DELIVERY_DATE,
	FORECAST_DELAY_DAY,
	ACTUAL_DELIVERY_DATE,
	ACTUAL_DELAY_DAY,
	LATEST_PLANNED_DELIVERY_DATE,
	ORDER_AMOUNT,
	DELIVERY_AMOUNT,
	APPROVE_EDITION,
	FABRIC_CHECK,
	QC_QUALITY_CHECK,
	EXCEPTION_HANDLE_STATUS,
	HANDLE_OPINIONS,
	CREATE_ID,
	CREATE_TIME,
	ORIGIN,
	MEMO,
	QC_CHECK,
	QA_CHECK,
	ORDER_STATUS,
	DELAY_PROBLEM_CLASS,
	DELAY_CAUSE_CLASS,
	DELAY_CAUSE_DETAILED,
	PROBLEM_DESC,
	IS_SUP_RESPONSIBLE,
	RESPONSIBLE_DEPT,
	RESPONSIBLE_DEPT_SEC,
	ORDER_FULL_RATE,
	CHECK_LINK,
	IS_QUALITY,
	IS_ORDER_REAMEM_UPD,
	UPDATE_COMPANY_ID,
	UPDATE_ID,
	UPDATE_TIME,
	PRODUCT_GRESS_REMARKS) 
values (
	:PRODUCT_GRESS_ID,
	:COMPANY_ID,
	:PRODUCT_GRESS_CODE,
	:ORDER_ID,
	:PROGRESS_STATUS,
	:GOO_ID,
	:SUPPLIER_CODE,
	:FACTORY_CODE,
	:FORECAST_DELIVERY_DATE,
	:FORECAST_DELAY_DAY,
	:ACTUAL_DELIVERY_DATE,
	:ACTUAL_DELAY_DAY,
	:LATEST_PLANNED_DELIVERY_DATE,
	:ORDER_AMOUNT,
	:DELIVERY_AMOUNT,
	:APPROVE_EDITION,
	:FABRIC_CHECK,
	:QC_QUALITY_CHECK,
	:EXCEPTION_HANDLE_STATUS,
	:HANDLE_OPINIONS,
	:CREATE_ID,
	:CREATE_TIME,
	:ORIGIN,
	:MEMO,
	:QC_CHECK,
	:QA_CHECK,
	:ORDER_STATUS,
	:DELAY_PROBLEM_CLASS,
	:DELAY_CAUSE_CLASS,
	:DELAY_CAUSE_DETAILED,
	:PROBLEM_DESC,
	:IS_SUP_RESPONSIBLE,
	:RESPONSIBLE_DEPT,
	:RESPONSIBLE_DEPT_SEC,
	:ORDER_FULL_RATE,
	:CHECK_LINK,
	:IS_QUALITY,
	:IS_ORDER_REAMEM_UPD,
	:UPDATE_COMPANY_ID,
	:UPDATE_ID,
	:UPDATE_TIME,
	:PRODUCT_GRESS_REMARKS)]';select_sql_VAL CLOB :=q'[{DECLARE
  v_sql CLOB;
  v_class_data_privs CLOB;
BEGIN
  v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key     => 'COL_2');
  v_sql      := scmdata.pkg_report_analy.f_unfinished_prostatus_report(p_company_id  => %default_company_id%,
                                                                       p_class_data_privs => v_class_data_privs,
                                                                       p_date_type   => @rdl_date_type@,
                                                                       p_start_time  => @rdl_begin_time@,
                                                                       p_end_time    => @rdl_end_time@,
                                                                       p_cate        => @rdl_category@,
                                                                       p_small_cate  => @rdl_small_cate@,
                                                                       p_sup         => @rdl_supp@);
  @strresult := v_sql;
END;}]';update_sql_VAL CLOB :=q'[update T_PRODUCTION_PROGRESS set 
	PRODUCT_GRESS_ID             = :PRODUCT_GRESS_ID,
	COMPANY_ID                   = :COMPANY_ID,
	PRODUCT_GRESS_CODE           = :PRODUCT_GRESS_CODE,
	ORDER_ID                     = :ORDER_ID,
	PROGRESS_STATUS              = :PROGRESS_STATUS,
	GOO_ID                       = :GOO_ID,
	SUPPLIER_CODE                = :SUPPLIER_CODE,
	FACTORY_CODE                 = :FACTORY_CODE,
	FORECAST_DELIVERY_DATE       = :FORECAST_DELIVERY_DATE,
	FORECAST_DELAY_DAY           = :FORECAST_DELAY_DAY,
	ACTUAL_DELIVERY_DATE         = :ACTUAL_DELIVERY_DATE,
	ACTUAL_DELAY_DAY             = :ACTUAL_DELAY_DAY,
	LATEST_PLANNED_DELIVERY_DATE = :LATEST_PLANNED_DELIVERY_DATE,
	ORDER_AMOUNT                 = :ORDER_AMOUNT,
	DELIVERY_AMOUNT              = :DELIVERY_AMOUNT,
	APPROVE_EDITION              = :APPROVE_EDITION,
	FABRIC_CHECK                 = :FABRIC_CHECK,
	QC_QUALITY_CHECK             = :QC_QUALITY_CHECK,
	EXCEPTION_HANDLE_STATUS      = :EXCEPTION_HANDLE_STATUS,
	HANDLE_OPINIONS              = :HANDLE_OPINIONS,
	CREATE_ID                    = :CREATE_ID,
	CREATE_TIME                  = :CREATE_TIME,
	ORIGIN                       = :ORIGIN,
	MEMO                         = :MEMO,
	QC_CHECK                     = :QC_CHECK,
	QA_CHECK                     = :QA_CHECK,
	ORDER_STATUS                 = :ORDER_STATUS,
	DELAY_PROBLEM_CLASS          = :DELAY_PROBLEM_CLASS,
	DELAY_CAUSE_CLASS            = :DELAY_CAUSE_CLASS,
	DELAY_CAUSE_DETAILED         = :DELAY_CAUSE_DETAILED,
	PROBLEM_DESC                 = :PROBLEM_DESC,
	IS_SUP_RESPONSIBLE           = :IS_SUP_RESPONSIBLE,
	RESPONSIBLE_DEPT             = :RESPONSIBLE_DEPT,
	RESPONSIBLE_DEPT_SEC         = :RESPONSIBLE_DEPT_SEC,
	ORDER_FULL_RATE              = :ORDER_FULL_RATE,
	CHECK_LINK                   = :CHECK_LINK,
	IS_QUALITY                   = :IS_QUALITY,
	IS_ORDER_REAMEM_UPD          = :IS_ORDER_REAMEM_UPD,
	UPDATE_COMPANY_ID            = :UPDATE_COMPANY_ID,
	UPDATE_ID                    = :UPDATE_ID,
	UPDATE_TIME                  = :UPDATE_TIME,
	PRODUCT_GRESS_REMARKS        = :PRODUCT_GRESS_REMARKS 
where PRODUCT_GRESS_ID=:OLD_PRODUCT_GRESS_ID]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_report_prostatus_100';
       IF V_CNT=0 THEN   
           insert into SYS_ITEM_LIST (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count)
           values (null,1,null,null,null,null,null,delete_sql_VAL,0,null,'0',0,insert_sql_VAL,1,null,null,null,0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_prostatus_100',null,null,null,13,null,null,null,0,null,update_sql_VAL,null,null,null,0);
       ELSE 
           update SYS_ITEM_LIST set (output_parameter,auto_refresh,page_sizes,monitor_id,operation_type,footer,query_count,delete_sql,hint_type,jump_express,end_field,open_mode,insert_sql,multi_page_flag,newid_sql,opretion_hint,query_fields,execute_time,sub_edit_state,ui_tmpl,select_sql,scannable_time,jump_field,noshow_app_fields,detail_sql,noadd_fields,noedit_fields,subselect_sql,nomodify_fields,operate_type,item_id,back_ground_id,noshow_fields,lock_sql,query_type,edit_express,sub_table_judge_field,subnoshow_fields,rfid_flag,scannable_type,update_sql,header,scannable_location_line,scannable_field,max_row_count) = (select null,1,null,null,null,null,null,delete_sql_VAL,0,null,'0',0,insert_sql_VAL,1,null,null,null,0,0,null,select_sql_VAL,null,null,null,null,null,null,null,null,0,'a_report_prostatus_100',null,null,null,13,null,null,null,0,null,update_sql_VAL,null,null,null,0 from dual) where item_id='a_report_prostatus_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      column_fields_VAL CLOB :=q'[progress_status_desc]';row_fields_VAL CLOB :=q'[category_name,deal_follower_name,owe_goo_cnt,owe_amount,pd_finish_cnt]';value_fields_VAL CLOB :=q'[pst_cnt]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_PIVOT_LIST where pivot_id='p_a_report_prostatus_100';
       IF V_CNT=0 THEN   
           insert into SYS_PIVOT_LIST (pivot_id,memo,column_fields,tag,row_fields,value_fields)
           values ('p_a_report_prostatus_100',null,column_fields_VAL,1,row_fields_VAL,value_fields_VAL);
       ELSE 
           update SYS_PIVOT_LIST set (pivot_id,memo,column_fields,tag,row_fields,value_fields) = (select 'p_a_report_prostatus_100',null,column_fields_VAL,1,row_fields_VAL,value_fields_VAL from dual) where pivot_id='p_a_report_prostatus_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_report_prostatus_100'and relate_id = 'p_a_report_prostatus_100';
       IF V_CNT=0 THEN   
           insert into sys_item_rela (seq_no,item_id,relate_id,pause,relate_type)
           values (1,'a_report_prostatus_100','p_a_report_prostatus_100',0,'P');
       ELSE 
           update sys_item_rela set (seq_no,item_id,relate_id,pause,relate_type) = (select 1,'a_report_prostatus_100','p_a_report_prostatus_100',0,'P' from dual) where item_id='a_report_prostatus_100'and relate_id = 'p_a_report_prostatus_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PD_FINISH_CNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'熊猫已结束订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PD_FINISH_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'熊猫已结束订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PD_FINISH_CNT',null,null,null,null,null,0,0,0,null,'10',1,0,null,null,null from dual) where field_name='PD_FINISH_CNT';
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
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PROGRESS_STATUS_DESC';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,1,'生产进度状态',0,1000,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PROGRESS_STATUS_DESC',null,null,null,null,null,0,0,0,null,'0',0,1,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,1,'生产进度状态',0,1000,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PROGRESS_STATUS_DESC',null,null,null,null,null,0,0,0,null,'0',0,1,null,null,null from dual) where field_name='PROGRESS_STATUS_DESC';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PST_CNT';
       IF V_CNT=0 THEN   
           insert into sys_field_list (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PST_CNT',null,null,null,null,null,0,0,0,null,'10',1,1,null,null,null);
       ELSE 
           update sys_field_list set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'订单数',1,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PST_CNT',null,null,null,null,null,0,0,0,null,'10',1,1,null,null,null from dual) where field_name='PST_CNT';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_1';
       IF V_CNT=0 THEN   
           insert into SYS_ELEMENT (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission)
           values (null,null,null,null,'aggregate_prostatus_100_1','aggregate',null,'oracle_scmdata',0,null);
       ELSE 
           update SYS_ELEMENT set (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission) = (select null,null,null,null,'aggregate_prostatus_100_1','aggregate',null,'oracle_scmdata',0,null from dual) where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_1';
       END IF;
   END;
END;
/
BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_2';
       IF V_CNT=0 THEN   
           insert into SYS_ELEMENT (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission)
           values (null,null,null,null,'aggregate_prostatus_100_2','aggregate',null,'oracle_scmdata',0,null);
       ELSE 
           update SYS_ELEMENT set (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission) = (select null,null,null,null,'aggregate_prostatus_100_2','aggregate',null,'oracle_scmdata',0,null from dual) where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_2';
       END IF;
   END;
END;
/
BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_3';
       IF V_CNT=0 THEN   
           insert into SYS_ELEMENT (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission)
           values (null,null,null,null,'aggregate_prostatus_100_3','aggregate',null,'oracle_scmdata',0,null);
       ELSE 
           update SYS_ELEMENT set (is_hide,is_async,is_per_exe,memo,element_id,element_type,message,data_source,pause,enable_stand_permission) = (select null,null,null,null,'aggregate_prostatus_100_3','aggregate',null,'oracle_scmdata',0,null from dual) where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_3';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      expression_VAL CLOB :=q'[SUM(OWE_GOO_CNT)]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_AGGREGATE where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_1';
       IF V_CNT=0 THEN   
           insert into SYS_AGGREGATE (expression,to_item_id,element_id,field_name)
           values (expression_VAL,null,'aggregate_prostatus_100_1','OWE_GOO_CNT');
       ELSE 
           update SYS_AGGREGATE set (expression,to_item_id,element_id,field_name) = (select expression_VAL,null,'aggregate_prostatus_100_1','OWE_GOO_CNT' from dual) where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_1';
       END IF;
   END;
END;
/
BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      expression_VAL CLOB :=q'[SUM(OWE_AMOUNT)]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_AGGREGATE where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_2';
       IF V_CNT=0 THEN   
           insert into SYS_AGGREGATE (expression,to_item_id,element_id,field_name)
           values (expression_VAL,null,'aggregate_prostatus_100_2','OWE_AMOUNT');
       ELSE 
           update SYS_AGGREGATE set (expression,to_item_id,element_id,field_name) = (select expression_VAL,null,'aggregate_prostatus_100_2','OWE_AMOUNT' from dual) where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_2';
       END IF;
   END;
END;
/
BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      expression_VAL CLOB :=q'[SUM(PD_FINISH_CNT)]';
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_AGGREGATE where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_3';
       IF V_CNT=0 THEN   
           insert into SYS_AGGREGATE (expression,to_item_id,element_id,field_name)
           values (expression_VAL,null,'aggregate_prostatus_100_3','PD_FINISH_CNT');
       ELSE 
           update SYS_AGGREGATE set (expression,to_item_id,element_id,field_name) = (select expression_VAL,null,'aggregate_prostatus_100_3','PD_FINISH_CNT' from dual) where element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_3';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_report_prostatus_100' and element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_1';
       IF V_CNT=0 THEN   
           insert into sys_item_element_rela (seq_no,item_id,element_id,level_no,pause)
           values (1,'a_report_prostatus_100','aggregate_prostatus_100_1',null,0);
       ELSE 
           update sys_item_element_rela set (seq_no,item_id,element_id,level_no,pause) = (select 1,'a_report_prostatus_100','aggregate_prostatus_100_1',null,0 from dual) where item_id='a_report_prostatus_100' and element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_1';
       END IF;
   END;
END;
/
BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_report_prostatus_100' and element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_2';
       IF V_CNT=0 THEN   
           insert into sys_item_element_rela (seq_no,item_id,element_id,level_no,pause)
           values (2,'a_report_prostatus_100','aggregate_prostatus_100_2',null,0);
       ELSE 
           update sys_item_element_rela set (seq_no,item_id,element_id,level_no,pause) = (select 2,'a_report_prostatus_100','aggregate_prostatus_100_2',null,0 from dual) where item_id='a_report_prostatus_100' and element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_2';
       END IF;
   END;
END;
/
BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_report_prostatus_100' and element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_3';
       IF V_CNT=0 THEN   
           insert into sys_item_element_rela (seq_no,item_id,element_id,level_no,pause)
           values (3,'a_report_prostatus_100','aggregate_prostatus_100_3',null,0);
       ELSE 
           update sys_item_element_rela set (seq_no,item_id,element_id,level_no,pause) = (select 3,'a_report_prostatus_100','aggregate_prostatus_100_3',null,0 from dual) where item_id='a_report_prostatus_100' and element_id in ('aggregate_prostatus_100_1','aggregate_prostatus_100_2','aggregate_prostatus_100_3')  and ELEMENT_ID = 'aggregate_prostatus_100_3';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_web_union where item_id='a_report_abn_200' and union_item_id = 'a_report_abn_202';
       IF V_CNT=0 THEN   
           insert into sys_web_union (union_item_id,seqno,item_id,pause)
           values ('a_report_abn_202',1,'a_report_abn_200',0);
       ELSE 
           update sys_web_union set (union_item_id,seqno,item_id,pause) = (select 'a_report_abn_202',1,'a_report_abn_200',0 from dual) where item_id='a_report_abn_200' and union_item_id = 'a_report_abn_202';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM sys_web_union where item_id='a_report_abn_200' and union_item_id = 'a_report_abn_201';
       IF V_CNT=0 THEN   
           insert into sys_web_union (union_item_id,seqno,item_id,pause)
           values ('a_report_abn_201',2,'a_report_abn_200',0);
       ELSE 
           update sys_web_union set (union_item_id,seqno,item_id,pause) = (select 'a_report_abn_201',2,'a_report_abn_200',0 from dual) where item_id='a_report_abn_200' and union_item_id = 'a_report_abn_201';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_report_delivery_100';
       IF V_CNT=0 THEN   
           insert into SYS_TREE_LIST (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag)
           values (0,'tree_a_report','a_report_delivery_100',null,null,0,0,1,null,'a_report_100',null,0,1,null,'scm','node_a_report_delivery_100',null);
       ELSE 
           update SYS_TREE_LIST set (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag) = (select 0,'tree_a_report','a_report_delivery_100',null,null,0,0,1,null,'a_report_100',null,0,1,null,'scm','node_a_report_delivery_100',null from dual) where node_id='node_a_report_delivery_100';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_report_abn_200';
       IF V_CNT=0 THEN   
           insert into SYS_TREE_LIST (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag)
           values (2,'tree_a_report','a_report_abn_200',1,'icon-renliziyuanxinxiguanlixitong (175)',0,null,1,null,'a_report_delivery_100',null,null,1,null,'scm','node_a_report_abn_200',null);
       ELSE 
           update SYS_TREE_LIST set (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag) = (select 2,'tree_a_report','a_report_abn_200',1,'icon-renliziyuanxinxiguanlixitong (175)',0,null,1,null,'a_report_delivery_100',null,null,1,null,'scm','node_a_report_abn_200',null from dual) where node_id='node_a_report_abn_200';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_report_delivery_101_1';
       IF V_CNT=0 THEN   
           insert into SYS_TREE_LIST (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag)
           values (0,'tree_a_report','a_report_delivery_101_1',null,null,0,1,1,null,'a_report_delivery_100',null,0,1,null,'scm','node_a_report_delivery_101_1',null);
       ELSE 
           update SYS_TREE_LIST set (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag) = (select 0,'tree_a_report','a_report_delivery_101_1',null,null,0,1,1,null,'a_report_delivery_100',null,0,1,null,'scm','node_a_report_delivery_101_1',null from dual) where node_id='node_a_report_delivery_101_1';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_report_prostatus_100';
       IF V_CNT=0 THEN   
           insert into SYS_TREE_LIST (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag)
           values (0,'tree_a_report','a_report_prostatus_100',null,null,0,0,1,null,'a_report_delivery_100',null,0,1,null,'scm','node_a_report_prostatus_100',null);
       ELSE 
           update SYS_TREE_LIST set (seq_no,tree_id,item_id,is_end,icon_name,pause,enable_stand_permission,node_type,competence_flag,parent_id,caption_explain,terminal_flag,is_authorize,var_id,app_id,node_id,stand_priv_flag) = (select 0,'tree_a_report','a_report_prostatus_100',null,null,0,0,1,null,'a_report_delivery_100',null,0,1,null,'scm','node_a_report_prostatus_100',null from dual) where node_id='node_a_report_prostatus_100';
       END IF;
   END;
END;
/

