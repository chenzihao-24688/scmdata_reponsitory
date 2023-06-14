BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_FIELD_LIST where field_name='CURLINK_COMPLET_RATIO';
       IF V_CNT=0 THEN   
           insert into SYS_FIELD_LIST (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'当前环节完成比例',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'CURLINK_COMPLET_RATIO',null,null,null,null,null,0,0,0,'0.00','10',0,0,null,null,null);
       ELSE 
           update SYS_FIELD_LIST set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'当前环节完成比例',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'CURLINK_COMPLET_RATIO',null,null,null,null,null,0,0,0,'0.00','10',0,0,null,null,null from dual) where field_name='CURLINK_COMPLET_RATIO';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_FIELD_LIST where field_name='PROGRESS_UPDATE_DATE';
       IF V_CNT=0 THEN   
           insert into SYS_FIELD_LIST (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'进度更新日期',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PROGRESS_UPDATE_DATE',null,null,null,null,null,0,0,0,'yyyy-MM-dd','12',0,0,null,null,null);
       ELSE 
           update SYS_FIELD_LIST set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'进度更新日期',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PROGRESS_UPDATE_DATE',null,null,null,null,null,0,0,0,'yyyy-MM-dd','12',0,0,null,null,null from dual) where field_name='PROGRESS_UPDATE_DATE';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_FIELD_LIST where field_name='ORDER_RISE_STATUS';
       IF V_CNT=0 THEN   
           insert into SYS_FIELD_LIST (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'订单风险状态',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ORDER_RISE_STATUS',null,null,null,null,null,0,0,0,null,'0',0,0,null,null,null);
       ELSE 
           update SYS_FIELD_LIST set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'订单风险状态',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'ORDER_RISE_STATUS',null,null,null,null,null,0,0,0,null,'0',0,0,null,null,null from dual) where field_name='ORDER_RISE_STATUS';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_FIELD_LIST where field_name='ORDER_RISE_STATUS_DESC';
       IF V_CNT=0 THEN   
           insert into SYS_FIELD_LIST (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'订单风险状态',0,0,null,0,0,null,0,0,null,null,null,0,0,null,1,null,0,null,null,null,0,null,'ORDER_RISE_STATUS_DESC',null,null,null,null,null,0,0,0,null,'0',0,0,null,null,null);
       ELSE 
           update SYS_FIELD_LIST set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'订单风险状态',0,0,null,0,0,null,0,0,null,null,null,0,0,null,1,null,0,null,null,null,0,null,'ORDER_RISE_STATUS_DESC',null,null,null,null,null,0,0,0,null,'0',0,0,null,null,null from dual) where field_name='ORDER_RISE_STATUS_DESC';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_FIELD_LIST where field_name='PLAN_DELIVERY_DATE';
       IF V_CNT=0 THEN   
           insert into SYS_FIELD_LIST (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'计划到仓日期',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PLAN_DELIVERY_DATE',null,null,null,null,null,0,0,0,'yyyy-MM-dd','12',0,0,null,null,null);
       ELSE 
           update SYS_FIELD_LIST set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'计划到仓日期',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PLAN_DELIVERY_DATE',null,null,null,null,null,0,0,0,'yyyy-MM-dd','12',0,0,null,null,null from dual) where field_name='PLAN_DELIVERY_DATE';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_FIELD_LIST where field_name='LOG_MSG';
       IF V_CNT=0 THEN   
           insert into SYS_FIELD_LIST (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,null,'操作内容',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'LOG_MSG',null,null,null,null,null,0,null,null,null,'18',0,3,null,null,null);
       ELSE 
           update SYS_FIELD_LIST set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,null,'操作内容',0,null,null,null,null,null,0,null,null,null,null,null,0,null,0,null,null,null,null,null,0,null,'LOG_MSG',null,null,null,null,null,0,null,null,null,'18',0,3,null,null,null from dual) where field_name='LOG_MSG';
       END IF;
   END;
END;
/

BEGIN 
   DECLARE 
       V_CNT  NUMBER(1); 
      
   BEGIN 
       SELECT COUNT(*) INTO V_CNT FROM SYS_FIELD_LIST where field_name='PROGRESS_NODE_DESC';
       IF V_CNT=0 THEN   
           insert into SYS_FIELD_LIST (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value)
           values (null,null,null,0,'生产节点名称',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PROGRESS_NODE_DESC',null,null,null,null,null,0,0,0,null,null,0,0,null,null,null);
       ELSE 
           update SYS_FIELD_LIST set (name_rule_flag,true_expr,value_sensitive_replacement,value_list_type,caption,no_edit,display_width,hyper_res,enable_stand_permission,multi_value_flag,operator_flag,no_sort,value_encrypt,value_sensitive,value_lists,check_message,max_length,ime_open,data_type_flag,requiered_flag,check_express,min_length,to_item_id,edit_formt,default_value,ime_care,name_rule_id,field_name,invalid_chars,store_source,value_display_style,min_value,false_expr,no_copy,no_sum,allow_scan,display_format,data_type,read_only_flag,alignment,input_hint,valid_chars,max_value) = (select null,null,null,0,'生产节点名称',0,0,null,0,0,null,0,0,null,null,null,0,0,null,0,null,0,null,null,null,0,null,'PROGRESS_NODE_DESC',null,null,null,null,null,0,0,0,null,null,0,0,null,null,null from dual) where field_name='PROGRESS_NODE_DESC';
       END IF;
   END;
END;
/
BEGIN
  insert into BW3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('SUP_CNT', '供应商数量', 0, null, null, null, null, null, 0, 0, 0, 0, 0, 0, 0, 0, 0, null, null, '10', null, null, null, 0, 0, null, 0, null, 0, null, null, null, null, null, 0, 0, null, null, null, null, null, null, 0);

END;

