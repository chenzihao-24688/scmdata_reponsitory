 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_101_2','list','物料清单','oracle_scmdata',null,null,null,'a_good_101_2',null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_101_2','list','物料清单','oracle_scmdata',null,null,null,'a_good_101_2',null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT a.commodity_material_id,
       a.commodity_info_id,
       ga.group_dict_name material_type_desc,
       a.material_record_code,
       mr.material_code,
       mr.material_name,
       mri.color,
       --cg.color_desc,
       mri.specification,
       mr.supplier_name   SUPPLIER,
       a.material_record_item_code,
       mri.material_record_item_id
  FROM t_commodity_material_record a
  left join t_material_record_item mri
    on a.material_record_item_code = mri.material_record_item_code
   and a.company_id = mri.company_id
  left join t_material_record mr
    on a.material_record_code = mr.material_record_code
   and a.company_id = mr.company_id
  left join sys_group_dict ga
    on mr.material_type = ga.group_dict_value
   and ga.group_dict_type = 'MATERIAL_OBJECT_TYPE'
/*  left join t_supplier_info tsi
    on tsi.supplier_code = mr.supplier_code
   and tsi.company_id = a.company_id
 left join (select ca.company_dict_name  COLOR_DESC,
                ca.company_dict_value COLOR
           from sys_company_dict ca
           left join sys_company_dict cb
             on ca.company_dict_type = cb.company_dict_value
            and cb.company_id = %default_company_id%
          where cb.company_dict_type = 'GD_COLOR_LIST'
            and ca.company_id = %default_company_id%) cg
on mri.color = cg.color*/
 WHERE a.commodity_info_id = :commodity_info_id]' ;INSERT_SQL_VAL CLOB :=q'[declare
begin
  pkg_material_record.p_use_material_record_item(pi_material_record_item_id =>:material_record_item_id ,
                                                 pi_commodity_info_id       =>:commodity_info_id  ,
                                                 pi_company_id              => %default_company_id% );
end;]' ;DELETE_SQL_VAL CLOB :=q'[call pkg_material_record.p_disuse_material_record_item(:commodity_material_id)]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_101_2',12,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,null,DELETE_SQL_VAL,'material_record_code,material_record_item_id,material_record_item_code,commodity_material_id,commodity_info_id,company_id',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_101_2',12,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,null,DELETE_SQL_VAL,'material_record_code,material_record_item_id,material_record_item_code,commodity_material_id,commodity_info_id,company_id',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040301') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_2_auto' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_2_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_2_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_2_auto' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_2_auto' and ctl_id = 'a_good_101_2' and obj_type = 14 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_2_auto',14,'a_good_101_2',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_2_auto',14,'a_good_101_2',0,1,0,null from dual) where cond_id = 'cond_a_good_101_2_auto' and ctl_id = 'a_good_101_2' and obj_type = 14 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COLOR' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COLOR','颜色',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COLOR','颜色',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COLOR' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='MATERIAL_RECORD_CODE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('MATERIAL_RECORD_CODE','物料编号',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'MATERIAL_RECORD_CODE','物料编号',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='MATERIAL_RECORD_CODE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SPECIFICATION' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SPECIFICATION','规格',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SPECIFICATION','规格',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SPECIFICATION' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='MATERIAL_NAME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('MATERIAL_NAME','物料名称',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'MATERIAL_NAME','物料名称',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='MATERIAL_NAME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COMMODITY_INFO_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COMMODITY_INFO_ID','COMMODITY_INFO_ID',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COMMODITY_INFO_ID','COMMODITY_INFO_ID',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COMMODITY_INFO_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='MATERIAL_TYPE_DESC' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('MATERIAL_TYPE_DESC','物料类型',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'MATERIAL_TYPE_DESC','物料类型',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='MATERIAL_TYPE_DESC' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SUPPLIER' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SUPPLIER','供应商',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SUPPLIER','供应商',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SUPPLIER' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='MATERIAL_CODE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('MATERIAL_CODE','物料编号',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'MATERIAL_CODE','物料编号',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='MATERIAL_CODE' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_101_4','list','工艺单','oracle_scmdata','T_COMMODITY_CRAFT','COMMODITY_CRAFT_ID',null,'a_good_101_4',null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_101_4','list','工艺单','oracle_scmdata','T_COMMODITY_CRAFT','COMMODITY_CRAFT_ID',null,'a_good_101_4',null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT t.commodity_craft_id,
       t.company_id,
       t.commodity_info_id,
       t.craft_type,
       t.part,
       t.process_description
  FROM scmdata.t_commodity_craft t
 WHERE t.company_id = %default_company_id%
   AND t.commodity_info_id = :commodity_info_id]' ;INSERT_SQL_VAL CLOB :=q'[DECLARE
  v_craft_rec scmdata.t_commodity_craft%ROWTYPE;
  v_goo_id    VARCHAR2(100);
BEGIN
  SELECT t.goo_id
    INTO v_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.company_id = %default_company_id%
     AND t.commodity_info_id = :commodity_info_id;
     
  SELECT scmdata.f_get_uuid(),
         %default_company_id%,
         :commodity_info_id,
         :craft_type,
         :part,
         :process_description,
         :remarks,
         v_goo_id,
         :user_id,
         sysdate,
         :user_id,
         sysdate
    INTO v_craft_rec.commodity_craft_id,
         v_craft_rec.company_id,
         v_craft_rec.commodity_info_id,
         v_craft_rec.craft_type,
         v_craft_rec.part,
         v_craft_rec.process_description,
         v_craft_rec.remarks,
         v_craft_rec.goo_id,
         v_craft_rec.create_id,
         v_craft_rec.create_time,
         v_craft_rec.update_id,
         v_craft_rec.update_time
    FROM dual;

  scmdata.pkg_commodity_info.insert_comm_craft(p_craft_rec => v_craft_rec);
END;]' ;UPDATE_SQL_VAL CLOB :=q'[DECLARE
  v_craft_rec scmdata.t_commodity_craft%ROWTYPE;
BEGIN

     
  SELECT :commodity_craft_id,
         %default_company_id%,
         :commodity_info_id,
         :craft_type,
         :part,
         :process_description,
         :remarks,
         :user_id,
         sysdate
    INTO v_craft_rec.commodity_craft_id,
         v_craft_rec.company_id,
         v_craft_rec.commodity_info_id,
         v_craft_rec.craft_type,
         v_craft_rec.part,
         v_craft_rec.process_description,
         v_craft_rec.remarks,
         v_craft_rec.update_id,
         v_craft_rec.update_time
    FROM dual;

  scmdata.pkg_commodity_info.update_comm_craft(p_craft_rec => v_craft_rec);
END;]' ;DELETE_SQL_VAL CLOB :=q'[CALL scmdata.pkg_commodity_info.delete_comm_craft(p_commodity_craft_id => :commodity_craft_id)]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_101_4',0,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,DELETE_SQL_VAL,'commodity_info_id,company_id,commodity_craft_id,craft_type',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_101_4',0,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,DELETE_SQL_VAL,'commodity_info_id,company_id,commodity_craft_id,craft_type',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040401') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_4_auto' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_4_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_4_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_4_auto' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_4_auto' and ctl_id = 'a_good_101_4' and obj_type = 14 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_4_auto',14,'a_good_101_4',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_4_auto',14,'a_good_101_4',0,1,0,null from dual) where cond_id = 'cond_a_good_101_4_auto' and ctl_id = 'a_good_101_4' and obj_type = 14 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040402') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_4_auto_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_4_auto_1',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_4_auto_1',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_4_auto_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_4_auto_1' and ctl_id = 'a_good_101_4' and obj_type = 11 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_4_auto_1',11,'a_good_101_4',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_4_auto_1',11,'a_good_101_4',0,1,0,null from dual) where cond_id = 'cond_a_good_101_4_auto_1' and ctl_id = 'a_good_101_4' and obj_type = 11 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040403') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_4_auto_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_4_auto_2',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_4_auto_2',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_4_auto_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_4_auto_2' and ctl_id = 'a_good_101_4' and obj_type = 12 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_4_auto_2',12,'a_good_101_4',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_4_auto_2',12,'a_good_101_4',0,1,0,null from dual) where cond_id = 'cond_a_good_101_4_auto_2' and ctl_id = 'a_good_101_4' and obj_type = 12 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040404') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_4_auto_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_4_auto_3',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_4_auto_3',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_4_auto_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_4_auto_3' and ctl_id = 'a_good_101_4' and obj_type = 13 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_4_auto_3',13,'a_good_101_4',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_4_auto_3',13,'a_good_101_4',0,1,0,null from dual) where cond_id = 'cond_a_good_101_4_auto_3' and ctl_id = 'a_good_101_4' and obj_type = 13 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PROCESS_DESCRIPTION' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('PROCESS_DESCRIPTION','工艺描述',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'PROCESS_DESCRIPTION','工艺描述',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='PROCESS_DESCRIPTION' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PART' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('PART','部件',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'PART','部件',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='PART' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CRAFT_TYPE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('CRAFT_TYPE','类型',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'CRAFT_TYPE','类型',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='CRAFT_TYPE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COMPANY_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COMPANY_ID','企业编号',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COMPANY_ID','企业编号',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COMPANY_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_101_4_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_101_4_1','list','工艺单导入','oracle_scmdata','T_COMMODITY_CRAFT_TEMP','COMMODITY_CRAFT_ID',null,'a_good_101_4_1',null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_101_4_1','list','工艺单导入','oracle_scmdata','T_COMMODITY_CRAFT_TEMP','COMMODITY_CRAFT_ID',null,'a_good_101_4_1',null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_4_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT t.commodity_craft_id,
       t.company_id,
       t.user_id,
       t.commodity_info_id,
       t.craft_type,
       t.part,
       t.process_description,
       m.msg
  FROM scmdata.t_commodity_craft_temp t
  LEFT JOIN scmdata.t_commodity_craft_import_msg m
    ON t.err_msg_id = m.msg_id
 WHERE t.company_id = %default_company_id%
   AND t.user_id = :user_id]' ;INSERT_SQL_VAL CLOB :=q'[DECLARE
  v_craft_rec scmdata.t_commodity_craft_temp%ROWTYPE;
  v_goo_id    VARCHAR2(100);
BEGIN
  SELECT t.goo_id
    INTO v_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.company_id = %default_company_id%
     AND t.commodity_info_id = :commodity_info_id;

  SELECT scmdata.f_get_uuid(),
         %default_company_id%,
         :user_id,
         :commodity_info_id,
         :craft_type,
         :part,
         :process_description,
         :remarks,
         v_goo_id
    INTO v_craft_rec.commodity_craft_id,
         v_craft_rec.company_id,
         v_craft_rec.user_id,
         v_craft_rec.commodity_info_id,
         v_craft_rec.craft_type,
         v_craft_rec.part,
         v_craft_rec.process_description,
         v_craft_rec.remarks,
         v_craft_rec.goo_id
    FROM dual;

  scmdata.pkg_commodity_info.insert_comm_craft_temp(p_craft_rec => v_craft_rec);
END;

]' ;UPDATE_SQL_VAL CLOB :=q'[DECLARE
  v_craft_rec scmdata.t_commodity_craft_temp%ROWTYPE;
BEGIN
  SELECT :commodity_craft_id,
         %default_company_id%,
         :user_id,
         :commodity_info_id,
         :craft_type,
         :part,
         :process_description
    INTO v_craft_rec.commodity_craft_id,
         v_craft_rec.company_id,
         v_craft_rec.user_id,
         v_craft_rec.commodity_info_id,
         v_craft_rec.craft_type,
         v_craft_rec.part,
         v_craft_rec.process_description
    FROM dual;

  scmdata.pkg_commodity_info.update_comm_craft_temp(p_craft_rec => v_craft_rec);
END;]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_101_4_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_101_4_1',0,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,null,'commodity_info_id,company_id,commodity_craft_id,user_id',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_101_4_1',0,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,null,'commodity_info_id,company_id,commodity_craft_id,user_id',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_4_1' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='MSG' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('MSG','校验信息',0,null,null,null,null,null,0,0,0,null,0,0,null,null,10,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'MSG','校验信息',0,null,null,null,null,null,0,0,0,null,0,0,null,null,10,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='MSG' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='USER_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('USER_ID','平台账户识别码',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'USER_ID','平台账户识别码',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='USER_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_101_5' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_101_5','list','附件','oracle_scmdata',null,null,null,'a_good_101_5',null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_101_5','list','附件','oracle_scmdata',null,null,null,'a_good_101_5',null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT t.commodity_file_id,
       t.commodity_info_id,
       t.company_id,
       t.file_type,
       t.file_id,
       a.company_user_name create_id,
       t.create_time,
       t.remarks,
       t.goo_id
  FROM scmdata.t_commodity_file t
 INNER JOIN sys_company_user a
    ON a.company_id = t.company_id
   AND a.user_id = t.create_id
 WHERE t.commodity_info_id = :commodity_info_id
 order by t.create_time asc]' ;INSERT_SQL_VAL CLOB :=q'[DECLARE
  v_file_rec scmdata.t_commodity_file%ROWTYPE;
  v_goo_id   VARCHAR2(100);
  v_username VARCHAR2(100);
BEGIN
  SELECT t.goo_id
    INTO v_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.company_id = %default_company_id%
     AND t.commodity_info_id = :commodity_info_id;
     

  v_file_rec.commodity_info_id := :commodity_info_id;
  v_file_rec.company_id        := %default_company_id%;
  v_file_rec.file_type         := :file_type;
  v_file_rec.file_id           := :file_id;
  v_file_rec.create_id         := :user_id;
  v_file_rec.create_time       := SYSDATE;
  v_file_rec.goo_id            := v_goo_id;
  v_file_rec.update_id         := :user_id;
  v_file_rec.update_time       := SYSDATE;

  scmdata.pkg_commodity_info.insert_commodity_file(p_file_rec => v_file_rec);
END;]' ;UPDATE_SQL_VAL CLOB :=q'[DECLARE
  v_file_rec scmdata.t_commodity_file%ROWTYPE;
BEGIN
  v_file_rec.commodity_file_id := :commodity_file_id;
  v_file_rec.file_type         := :file_type;
  v_file_rec.file_id           := :file_id;
  v_file_rec.update_id         := :user_id;
  v_file_rec.update_time       := SYSDATE;
  scmdata.pkg_commodity_info.update_commodity_file(p_file_rec => v_file_rec);
END;]' ;DELETE_SQL_VAL CLOB :=q'[call scmdata.pkg_commodity_info.delete_commodity_file(p_commodity_file_id => :commodity_file_id)]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_101_5' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_101_5',12,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,DELETE_SQL_VAL,'commodity_info_id,company_id,commodity_file_id,remarks,goo_id',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_101_5',12,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,DELETE_SQL_VAL,'commodity_info_id,company_id,commodity_file_id,remarks,goo_id',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040501') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_5_auto' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_5_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_5_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_5_auto' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_5_auto' and ctl_id = 'a_good_101_5' and obj_type = 14 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_5_auto',14,'a_good_101_5',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_5_auto',14,'a_good_101_5',0,1,0,null from dual) where cond_id = 'cond_a_good_101_5_auto' and ctl_id = 'a_good_101_5' and obj_type = 14 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040502') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_5_auto_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_5_auto_1',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_5_auto_1',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_5_auto_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_5_auto_1' and ctl_id = 'a_good_101_5' and obj_type = 11 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_5_auto_1',11,'a_good_101_5',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_5_auto_1',11,'a_good_101_5',0,1,0,null from dual) where cond_id = 'cond_a_good_101_5_auto_1' and ctl_id = 'a_good_101_5' and obj_type = 11 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040503') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_5_auto_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_5_auto_2',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_5_auto_2',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_5_auto_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_5_auto_2' and ctl_id = 'a_good_101_5' and obj_type = 12 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_5_auto_2',12,'a_good_101_5',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_5_auto_2',12,'a_good_101_5',0,1,0,null from dual) where cond_id = 'cond_a_good_101_5_auto_2' and ctl_id = 'a_good_101_5' and obj_type = 12 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040504') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_101_5_auto_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_101_5_auto_3',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_101_5_auto_3',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_101_5_auto_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_101_5_auto_3' and ctl_id = 'a_good_101_5' and obj_type = 13 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_101_5_auto_3',13,'a_good_101_5',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_101_5_auto_3',13,'a_good_101_5',0,1,0,null from dual) where cond_id = 'cond_a_good_101_5_auto_3' and ctl_id = 'a_good_101_5' and obj_type = 13 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='GOO_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('GOO_ID','商品档案编号',1,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'GOO_ID','商品档案编号',1,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='GOO_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='REMARKS' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('REMARKS','备注',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'18',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'REMARKS','备注',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'18',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='REMARKS' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='FILE_TYPE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('FILE_TYPE','类型',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'FILE_TYPE','类型',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='FILE_TYPE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='FILE_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('FILE_ID','附件',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'47',null,null,null,0,0,null,null,null,null,null,null,null,null,20,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'FILE_ID','附件',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'47',null,null,null,0,0,null,null,null,null,null,null,null,null,20,null,null,null,null,null,null,null from dual) where field_name='FILE_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CREATE_TIME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('CREATE_TIME','创建时间',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,'yyyy-MM-dd HH:mm:ss',null,'12',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'CREATE_TIME','创建时间',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,'yyyy-MM-dd HH:mm:ss',null,'12',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='CREATE_TIME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CREATE_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('CREATE_ID','创建人',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'CREATE_ID','创建人',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='CREATE_ID' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_101_6' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_101_6','list','成分表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_101_6','list','成分表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_6' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[select a.commodity_composition_id,
       a.commodity_info_id,
       a.composname,
       a.goo_raw,
       a.loadrate,
       a.memo
  from scmdata.t_commodity_composition a
  where a.commodity_info_id=:commodity_info_id]' ;INSERT_SQL_VAL CLOB :=q'[declare
  p_i int;
begin
  select max(sort) + 1
    into p_i
    from scmdata.t_commodity_composition
   where commodity_info_id = :commodity_info_id;
  insert into scmdata.t_commodity_composition
    (commodity_composition_id,
     commodity_info_id,
     company_id,
     composname,
     loadrate,
     goo_raw,
     memo,
     sort,
     create_time,
     create_id,
     update_time,
     update_id,
     pause)
  values
    (f_get_uuid,
     :commodity_info_id,
     %default_company_id%,
     :composname,
     :loadrate,
     :goo_raw,
     :memo,
     p_i,
     sysdate,
     :user_id,
     sysdate,
     :user_id,
     0);
  commit;
end;]' ;UPDATE_SQL_VAL CLOB :=q'[update scmdata.t_commodity_composition a
   set a.composname = :composname,
       a.loadrate   = :loadrate,
       a.goo_raw    = :goo_raw,
       a.memo       = :memo
where commodity_composition_id=:commodity_composition_id]' ;DELETE_SQL_VAL CLOB :=q'[delete from scmdata.t_commodity_composition a
 where commodity_composition_id = :commodity_composition_id]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_101_6' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_101_6',12,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,DELETE_SQL_VAL,'commodity_composition_id,commodity_info_id',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_101_6',12,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,DELETE_SQL_VAL,'commodity_composition_id,commodity_info_id',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_101_6' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='LOADRATE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('LOADRATE','含量',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'14',100,0,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'LOADRATE','含量',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'14',100,0,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='LOADRATE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COMPOSNAME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COMPOSNAME','成分',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COMPOSNAME','成分',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COMPOSNAME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='GOO_RAW' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('GOO_RAW','原料',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'GOO_RAW','原料',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='GOO_RAW' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='MEMO' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('MEMO','备注',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'18',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'MEMO','备注',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'18',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='MEMO' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_110' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_110','list','商品档案列表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_110','list','商品档案列表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_110' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[WITH group_dict AS
 (SELECT * FROM scmdata.sys_group_dict),
company_dict AS
 (SELECT *
    FROM scmdata.sys_company_dict t
   WHERE t.company_id = %default_company_id%),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM sys_company_user
   WHERE company_id = %default_company_id%)
SELECT tc.commodity_info_id,
       tc.company_id,
       gd.group_dict_name       origin,
       tc.rela_goo_id,
       tc.goo_id,
       tc.sup_style_number,
       tc.style_number,
       tc.style_name,
       gd1.group_dict_name      category_gd,
       gd2.group_dict_name      product_cate_gd,
       cd.company_dict_name     small_category_gd,
       tc.supplier_code         supplier_code_gd,
       sp.supplier_company_name sup_name_gd,
       tc.goo_name,
       tc.year,
       tc.season,
       --gd3.group_dict_name      year_gd,
       gd4.group_dict_name season_gd,
       tc.inprice,
       tc.price            price_gd,
       tc.create_time,
       nvl(a.company_user_name,tc.create_id) create_id,
       tc.update_time,
       nvl(b.company_user_name,tc.create_id) update_id
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_supplier_info sp
    ON tc.supplier_code = sp.supplier_code
   AND tc.company_id = sp.company_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = 'ORIGIN_TYPE'
   AND tc.origin = gd.group_dict_value
 INNER JOIN group_dict gd1
    ON gd1.group_dict_type = 'PRODUCT_TYPE'
   AND gd1.group_dict_value = tc.category
 INNER JOIN group_dict gd2
    ON gd2.group_dict_type = gd1.group_dict_value
   AND gd2.group_dict_value = tc.product_cate
 INNER JOIN company_dict cd
    ON cd.company_dict_type = gd2.group_dict_value
   AND cd.company_dict_value = tc.samll_category
   AND cd.company_id = %default_company_id%
/* INNER JOIN group_dict gd3
 ON gd3.group_dict_type = 'GD_YEAR'
AND gd3.group_dict_value = tc.year*/
 INNER JOIN group_dict gd4
    ON gd4.group_dict_type = 'GD_SESON'
   AND gd4.group_dict_value = tc.season
 left JOIN company_user a
    ON a.company_id = tc.company_id
   AND a.user_id = tc.create_id
 left JOIN company_user b
    ON b.company_id = tc.company_id
   AND b.user_id = tc.update_id
 WHERE tc.company_id = %default_company_id%
   AND tc.pause = 0
 ORDER BY tc.create_time DESC]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_110' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_110',12,'rela_goo_id,style_number,goo_id,style_name,sup_name_gd',null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,season',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_110',12,'rela_goo_id,style_number,goo_id,style_name,sup_name_gd',null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,season',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_110' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0050101') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_110_auto' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_110_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_110_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_110_auto' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_110_auto' and ctl_id = 'a_good_110' and obj_type = 14 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_110_auto',14,'a_good_110',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_110_auto',14,'a_good_110',0,1,0,null from dual) where cond_id = 'cond_a_good_110_auto' and ctl_id = 'a_good_110' and obj_type = 14 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CATEGORY_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('CATEGORY_GD','分类',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'CATEGORY_GD','分类',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='CATEGORY_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SMALL_CATEGORY_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SMALL_CATEGORY_GD','产品子类',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SMALL_CATEGORY_GD','产品子类',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SMALL_CATEGORY_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SUP_NAME_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SUP_NAME_GD','供应商',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SUP_NAME_GD','供应商',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SUP_NAME_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='RELA_GOO_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('RELA_GOO_ID','货号',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'RELA_GOO_ID','货号',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='RELA_GOO_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='INPRICE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('INPRICE','进价',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,'0.00',null,'10',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'INPRICE','进价',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,'0.00',null,'10',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='INPRICE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='UPDATE_TIME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('UPDATE_TIME','修改时间',0,null,null,null,null,null,1,1,0,null,0,0,null,null,null,'yyyy-MM-dd HH:mm:ss',null,'12',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'UPDATE_TIME','修改时间',0,null,null,null,null,null,1,1,0,null,0,0,null,null,null,'yyyy-MM-dd HH:mm:ss',null,'12',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='UPDATE_TIME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SUPPLIER_CODE_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SUPPLIER_CODE_GD','供应商档案编号',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SUPPLIER_CODE_GD','供应商档案编号',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SUPPLIER_CODE_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRICE_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('PRICE_GD','定价',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,'0.00',null,'10',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'PRICE_GD','定价',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,'0.00',null,'10',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='PRICE_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRODUCT_CATE_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('PRODUCT_CATE_GD','生产类别',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'PRODUCT_CATE_GD','生产类别',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='PRODUCT_CATE_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='GOO_NAME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('GOO_NAME','品牌',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'GOO_NAME','品牌',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='GOO_NAME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SEASON' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SEASON','季节',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SEASON','季节',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SEASON' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SEASON_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SEASON_GD','季节',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SEASON_GD','季节',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SEASON_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ORIGIN' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('ORIGIN','来源',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'ORIGIN','来源',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='ORIGIN' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='YEAR' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('YEAR','年度',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'YEAR','年度',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='YEAR' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SUP_STYLE_NUMBER' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SUP_STYLE_NUMBER','供应商款号',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SUP_STYLE_NUMBER','供应商款号',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SUP_STYLE_NUMBER' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='STYLE_NAME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('STYLE_NAME','款式名称',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'STYLE_NAME','款式名称',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='STYLE_NAME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='UPDATE_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('UPDATE_ID','修改人',0,null,null,null,null,null,1,1,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'UPDATE_ID','修改人',0,null,null,null,null,null,1,1,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='UPDATE_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='STYLE_NUMBER' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('STYLE_NUMBER','款号',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'STYLE_NUMBER','款号',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='STYLE_NUMBER' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_111' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_111','single','商品档案详情','oracle_scmdata','T_COMMODITY_INFO','COMMODITY_INFO_ID',null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_111','single','商品档案详情','oracle_scmdata','T_COMMODITY_INFO','COMMODITY_INFO_ID',null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_111' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[WITH group_dict AS
 (SELECT gd.group_dict_value, gd.group_dict_type, gd.group_dict_name
    FROM scmdata.sys_group_dict gd),
company_dict AS
 (SELECT cd.company_dict_value,
         cd.company_dict_type,
         cd.company_dict_name,
         cd.pause
    FROM scmdata.sys_company_dict cd
   WHERE cd.company_id = %default_company_id%),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM sys_company_user
   WHERE company_id = %default_company_id%)
SELECT tc.commodity_info_id,
       tc.company_id,
       tc.style_pic,
       tc.supplier_code supplier_code_gd,
       tc.style_name,
       (SELECT SUPPLIER_COMPANY_NAME
          FROM SCMDATA.T_SUPPLIER_INFO
         WHERE SUPPLIER_CODE = TC.SUPPLIER_CODE
           AND COMPANY_ID = %DEFAULT_COMPANY_ID%) SUP_NAME_GD,
       tc.style_number,
       tc.sup_style_number,
       tc.goo_id,
       tc.rela_goo_id,
       tc.goo_name,
       tc.category,
       tc.product_cate,
       tc.samll_category,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = 'PRODUCT_TYPE'
           AND GROUP_DICT_VALUE = TC.CATEGORY) CATEGORY_GD,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = TC.CATEGORY
           AND GROUP_DICT_VALUE = TC.PRODUCT_CATE) PRODUCT_CATE_GD,
       (SELECT COMPANY_DICT_NAME
          FROM company_dict
         WHERE COMPANY_DICT_TYPE = TC.PRODUCT_CATE
           AND COMPANY_DICT_VALUE = TC.SAMLL_CATEGORY) SMALL_CATEGORY_GD,
       tc.year,
       tc.season,
       -- gd3.group_dict_name year_gd,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = 'GD_SESON'
           AND GROUP_DICT_VALUE = TC.SEASON) SEASON_GD,
       tc.inprice,
       tc.price price_gd,
       tc.color_list,
       (SELECT listagg(a.company_dict_name, ';') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.color_list, '[^;]+', 1, LEVEL) color
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.color_list, '[^;]+')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.color
         INNER JOIN company_dict b
            ON b.company_dict_type = 'GD_COLOR_LIST'
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) color_list_gd, --颜色组  键值，拆分，组合转换  
       tc.size_list,
       (SELECT listagg(a.company_dict_name, ';') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.size_list, '[^;]+', 1, LEVEL) size_gd
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.size_list, '[^;]+')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.size_gd
         INNER JOIN company_dict b
            ON b.company_dict_type = 'GD_SIZE_LIST'
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) size_list_gd, --尺码组 键值，拆分，组合转换 
       -- tc.base_size,
       tc.EXECUTIVE_STD,
       -- e.company_dict_name base_size_desc,
       (select listagg(composname || ' ' || pk, chr(10)) within group(order by seq)
  from (select k.composname,
               listagg(loadrate * 100 || '%' || ' ' || k.goo_raw || ' ' || k.memo,
                       ' ') within group(order by sort asc) pk,
                       Case k.ComPosName WHEN '面料1'    then 1
                               WHEN '面料2'    THEN 2
                               WHEN '面料'     THEN 3
                               WHEN '里料1'    then 4
                               When '里料2'    then 5
                               WHEN '里料'     THEN 6
                               when '侧翼面料' THEN 7
                               when '侧翼里料' THEN 8
                               when '罩杯里料' THEN 9
                               WHEN '表层'     THEN 10
                               WHEN '基布'     THEN 11
                               When '填充物'   then 12
                               when '填充量'   then 13
                               when '鞋面材质' then 14
                               when '鞋底材质' then 15
                               WHEN '帽里填充物' THEN 16
                               else 99 end seq
          from scmdata.t_commodity_composition k
         where k.commodity_info_id=tc.commodity_info_id
         group by k.composname
)) ||chr(10)||
       (select max(memo)
          from scmdata.t_commodity_composition k
         where k.commodity_info_id = tc.commodity_info_id) COMPOSNAME_LONG,
       nvl((SELECT COMPANY_USER_NAME
             FROM COMPANY_USER
            WHERE COMPANY_ID = TC.COMPANY_ID
              AND USER_ID = TC.CREATE_ID),
           TC.CREATE_ID) CREATE_ID,
       tc.create_time,
       (SELECT COMPANY_USER_NAME
          FROM COMPANY_USER
         WHERE COMPANY_ID = TC.COMPANY_ID
           AND USER_ID = TC.UPDATE_ID) UPDATE_ID,
       tc.update_time
  FROM (SELECT *
          FROM SCMDATA.T_COMMODITY_INFO
         WHERE (COMPANY_ID = %DEFAULT_COMPANY_ID%)
           AND (commodity_info_id = %ass_commodity_info_id%)) tc
/*LEFT JOIN company_dict e
ON tc.base_size = e.company_dict_value*/


/*WITH group_dict AS
 (SELECT gd.group_dict_value, gd.group_dict_type, gd.group_dict_name
    FROM scmdata.sys_group_dict gd),
company_dict AS
 (SELECT cd.company_dict_value,
         cd.company_dict_type,
         cd.company_dict_name,
         cd.pause
    FROM scmdata.sys_company_dict cd
   WHERE cd.company_id = %default_company_id%)
SELECT tc.commodity_info_id,
       tc.company_id,
       tc.style_pic,
       tc.supplier_code SUPPLIER_CODE_GD,
       tc.style_name,
       sp.supplier_company_name sup_name_gd,
       tc.style_number,
       tc.sup_style_number,
       tc.goo_id,
       tc.rela_goo_id,
       tc.goo_name,
       tc.category,
       tc.product_cate,
       tc.samll_category,
       gd1.group_dict_name category_gd,
       gd2.group_dict_name product_cate_gd,
       cd.company_dict_name small_category_gd,
       tc.year,
       tc.season,
      -- gd3.group_dict_name year_gd,
       gd4.group_dict_name season_gd,
       tc.inprice,
       tc.price price_gd,
       tc.color_list,
       (SELECT listagg(a.company_dict_name, ';') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.color_list, '[^;]+', 1, LEVEL) color
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.color_list, '[^;]+')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.color
         INNER JOIN company_dict b
            ON b.company_dict_type = 'GD_COLOR_LIST'
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) color_list_gd, --颜色组  键值，拆分，组合转换  
       tc.size_list,
       (SELECT listagg(a.company_dict_name, ';') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.size_list, '[^;]+', 1, LEVEL) size_gd
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.size_list, '[^;]+')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.size_gd
         INNER JOIN company_dict b
            ON b.company_dict_type = 'GD_SIZE_LIST'
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) size_list_gd, --尺码组 键值，拆分，组合转换 
       tc.base_size,
       e.company_dict_name base_size_desc,
       pkg_personal.F_show_username_by_company(upper(tc.create_id), tc.company_id) create_id,
       tc.create_time,
       pkg_personal.F_show_username_by_company(upper(tc.update_id), tc.company_id) update_id,
       tc.update_time
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_supplier_info sp
    ON tc.supplier_code = sp.supplier_code
   AND tc.company_id = sp.company_id
   AND sp.company_id = %default_company_id%
   AND tc.commodity_info_id = %ass_commodity_info_id%
  LEFT JOIN company_dict e
    ON tc.base_size = e.company_dict_value
 INNER JOIN group_dict gd1
    ON gd1.group_dict_type = 'PRODUCT_TYPE'
   AND tc.category = gd1.group_dict_value
 INNER JOIN group_dict gd2
    ON gd2.group_dict_type = gd1.group_dict_value
   AND tc.product_cate = gd2.group_dict_value
 INNER JOIN company_dict cd
    ON cd.company_dict_type = gd2.group_dict_value
   AND tc.samll_category = cd.company_dict_value
 INNER JOIN group_dict gd4
    ON gd4.group_dict_type = 'GD_SESON'
  AND gd4.group_dict_value = tc.season*/]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_111' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_111',0,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,season,base_size',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_111',0,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,season,base_size',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_111' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P005010401') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_111_auto' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_111_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_111_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_111_auto' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_111_auto' and ctl_id = 'a_good_111' and obj_type = 0 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_111_auto',0,'a_good_111',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_111_auto',0,'a_good_111',0,1,0,null from dual) where cond_id = 'cond_a_good_111_auto' and ctl_id = 'a_good_111' and obj_type = 0 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COMPOSNAME_LONG' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COMPOSNAME_LONG','成分',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'18',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COMPOSNAME_LONG','成分',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'18',null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COMPOSNAME_LONG' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COLOR_LIST' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COLOR_LIST','颜色',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COLOR_LIST','颜色',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COLOR_LIST' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CATEGORY' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('CATEGORY','分类',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'CATEGORY','分类',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='CATEGORY' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SAMLL_CATEGORY' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SAMLL_CATEGORY','产品子类',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SAMLL_CATEGORY','产品子类',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SAMLL_CATEGORY' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SIZE_LIST_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SIZE_LIST_GD','尺码',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SIZE_LIST_GD','尺码',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SIZE_LIST_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COLOR_LIST_GD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COLOR_LIST_GD','颜色',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COLOR_LIST_GD','颜色',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COLOR_LIST_GD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PRODUCT_CATE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('PRODUCT_CATE','生产类别',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'PRODUCT_CATE','生产类别',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='PRODUCT_CATE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SIZE_LIST' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SIZE_LIST','尺码',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SIZE_LIST','尺码',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SIZE_LIST' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='EXECUTIVE_STD' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('EXECUTIVE_STD','执行标准',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'EXECUTIVE_STD','执行标准',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='EXECUTIVE_STD' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='STYLE_PIC' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('STYLE_PIC','款式图片',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'28',null,null,null,0,0,null,null,null,null,null,null,null,null,20,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'STYLE_PIC','款式图片',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'28',null,null,null,0,0,null,null,null,null,null,null,null,null,20,null,null,null,null,null,null,null from dual) where field_name='STYLE_PIC' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
CLO_NAMES_VAL CLOB :=q'[style_pic,SUPPLIER_CODE_GD,style_name,SUP_NAME_GD,style_number,sup_style_number,goo_id,rela_goo_id,goo_name,category_gd,product_cate_gd,small_category_gd,year,SEASON_GD,inprice,PRICE_GD,color_list_gd,size_list_gd,base_size,base_size_desc,EXECUTIVE_STD,COMPOSNAME_LONG,create_id,create_time,update_id,update_time]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_DETAIL_GROUP where item_id='a_good_111' and GROUP_NAME = '基本信息' ;
   IF V_CNT=0 THEN   
       insert into SYS_DETAIL_GROUP(ITEM_ID,GROUP_NAME,CLO_NAMES,COLUMN_NUMBER,SEQ_NO,PAUSE)
       values ('a_good_111','基本信息',CLO_NAMES_VAL,2,1,0);
   ELSE 
       update SYS_DETAIL_GROUP set (ITEM_ID,GROUP_NAME,CLO_NAMES,COLUMN_NUMBER,SEQ_NO,PAUSE)=(select 'a_good_111','基本信息',CLO_NAMES_VAL,2,1,0 from dual) where item_id='a_good_111' and GROUP_NAME = '基本信息' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_111_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_111_1','list','色码表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_111_1','list','色码表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_111_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT tcs.commodity_color_size_id,
       tcs.commodity_info_id,
       tcs.company_id,
       tcs.goo_id,
       tcs.barcode,
       tcs.color_code,
       tcs.colorname,
       tcs.sizecode,
       tcs.sizename
  FROM scmdata.t_commodity_color_size tcs
 WHERE tcs.commodity_info_id = :commodity_info_id
 ORDER BY tcs.color_code asc,tcs.sizecode asc]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_111_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_111_1',0,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_color_size_id,commodity_info_id,company_id,goo_id,color_code,sizecode',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_111_1',0,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_color_size_id,commodity_info_id,company_id,goo_id,color_code,sizecode',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_111_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501040201') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_a_good_111_1_auto' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_a_good_111_1_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_a_good_111_1_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_a_good_111_1_auto' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_a_good_111_1_auto' and ctl_id = 'a_good_111_1' and obj_type = 14 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_a_good_111_1_auto',14,'a_good_111_1',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_a_good_111_1_auto',14,'a_good_111_1',0,1,0,null from dual) where cond_id = 'cond_a_good_111_1_auto' and ctl_id = 'a_good_111_1' and obj_type = 14 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='SIZENAME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('SIZENAME','尺码',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'SIZENAME','尺码',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='SIZENAME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COLORNAME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COLORNAME','颜色',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COLORNAME','颜色',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COLORNAME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='BARCODE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('BARCODE','条码',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'BARCODE','条码',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='BARCODE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COLOR_CODE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COLOR_CODE','颜色编码',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COLOR_CODE','颜色编码',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COLOR_CODE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_130' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_130','single','查看商品档案','oracle_scmdata','T_COMMODITY_INFO','COMMODITY_INFO_ID',null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_130','single','查看商品档案','oracle_scmdata','T_COMMODITY_INFO','COMMODITY_INFO_ID',null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[WITH group_dict AS
 (SELECT gd.group_dict_value, gd.group_dict_type, gd.group_dict_name
    FROM scmdata.sys_group_dict gd),
company_dict AS
 (SELECT cd.company_dict_value,
         cd.company_dict_type,
         cd.company_dict_name,
         cd.pause
    FROM scmdata.sys_company_dict cd
   WHERE cd.company_id = %default_company_id%),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM sys_company_user
   WHERE company_id = %default_company_id%)
SELECT tc.commodity_info_id,
       tc.company_id,
       tc.style_pic,
       tc.supplier_code supplier_code_gd,
       tc.style_name,
       (SELECT SUPPLIER_COMPANY_NAME
          FROM SCMDATA.T_SUPPLIER_INFO
         WHERE SUPPLIER_CODE = TC.SUPPLIER_CODE
           AND COMPANY_ID = %DEFAULT_COMPANY_ID%) SUP_NAME_GD,
       tc.style_number,
       tc.sup_style_number,
       tc.goo_id,
       tc.rela_goo_id,
       tc.goo_name,
       tc.category,
       tc.product_cate,
       tc.samll_category,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = 'PRODUCT_TYPE'
           AND GROUP_DICT_VALUE = TC.CATEGORY) CATEGORY_GD,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = TC.CATEGORY
           AND GROUP_DICT_VALUE = TC.PRODUCT_CATE) PRODUCT_CATE_GD,
       (SELECT COMPANY_DICT_NAME
          FROM company_dict
         WHERE COMPANY_DICT_TYPE = TC.PRODUCT_CATE
           AND COMPANY_DICT_VALUE = TC.SAMLL_CATEGORY) SMALL_CATEGORY_GD,
       tc.year,
       tc.season,
       -- gd3.group_dict_name year_gd,
       (SELECT GROUP_DICT_NAME
          FROM group_dict
         WHERE GROUP_DICT_TYPE = 'GD_SESON'
           AND GROUP_DICT_VALUE = TC.SEASON) SEASON_GD,
       tc.inprice,
       tc.price price_gd,
       tc.color_list,
       (SELECT listagg(a.company_dict_name, ';') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.color_list, '[^;]+', 1, LEVEL) color
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.color_list, '[^;]+')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.color
         INNER JOIN company_dict b
            ON b.company_dict_type = 'GD_COLOR_LIST'
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) color_list_gd, --颜色组  键值，拆分，组合转换  
       tc.size_list,
       (SELECT listagg(a.company_dict_name, ';') within GROUP(ORDER BY 1)
          FROM (SELECT regexp_substr(tc.size_list, '[^;]+', 1, LEVEL) size_gd
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(tc.size_list, '[^;]+')) t
         INNER JOIN company_dict a
            ON a.company_dict_value = t.size_gd
         INNER JOIN company_dict b
            ON b.company_dict_type = 'GD_SIZE_LIST'
           AND b.company_dict_value = a.company_dict_type
           AND b.pause = 0) size_list_gd, --尺码组 键值，拆分，组合转换 
       -- tc.base_size,
       tc.EXECUTIVE_STD,
       -- e.company_dict_name base_size_desc,
              (select listagg(composname || ' ' || pk, chr(10)) within group(order by seq)
  from (select k.composname,
               listagg(loadrate * 100 || '%' || ' ' || k.goo_raw || ' ' || k.memo,
                       ' ') within group(order by sort asc) pk,
                       Case k.ComPosName WHEN '面料1'    then 1
                               WHEN '面料2'    THEN 2
                               WHEN '面料'     THEN 3
                               WHEN '里料1'    then 4
                               When '里料2'    then 5
                               WHEN '里料'     THEN 6
                               when '侧翼面料' THEN 7
                               when '侧翼里料' THEN 8
                               when '罩杯里料' THEN 9
                               WHEN '表层'     THEN 10
                               WHEN '基布'     THEN 11
                               When '填充物'   then 12
                               when '填充量'   then 13
                               when '鞋面材质' then 14
                               when '鞋底材质' then 15
                               WHEN '帽里填充物' THEN 16
                               else 99 end seq
          from scmdata.t_commodity_composition k
         where k.commodity_info_id=tc.commodity_info_id
         group by k.composname
)) ||chr(10)||
       (select max(memo)
          from scmdata.t_commodity_composition k
         where k.commodity_info_id = tc.commodity_info_id) COMPOSNAME_LONG,
       nvl((SELECT COMPANY_USER_NAME
             FROM COMPANY_USER
            WHERE COMPANY_ID = TC.COMPANY_ID
              AND USER_ID = TC.CREATE_ID),
           TC.CREATE_ID) CREATE_ID,
       tc.create_time,
       (SELECT COMPANY_USER_NAME
          FROM COMPANY_USER
         WHERE COMPANY_ID = TC.COMPANY_ID
           AND USER_ID = TC.UPDATE_ID) UPDATE_ID,
            tc.update_time
  FROM (SELECT *
          FROM SCMDATA.T_COMMODITY_INFO
         WHERE (COMPANY_ID = %DEFAULT_COMPANY_ID%)
           AND (GOO_ID = :GOO_ID)) tc
/*LEFT JOIN company_dict e
ON tc.base_size = e.company_dict_value*/]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_130' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_130',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,season,base_size',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_130',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,season,base_size',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
CLO_NAMES_VAL CLOB :=q'[style_pic,SUPPLIER_CODE_GD,style_name,SUP_NAME_GD,style_number,sup_style_number,goo_id,rela_goo_id,goo_name,category_gd,product_cate_gd,small_category_gd,year,SEASON_GD,inprice,PRICE_GD,color_list_gd,size_list_gd,base_size,base_size_desc,EXECUTIVE_STD,COMPOSNAME_LONG,create_id,create_time,update_id,update_time]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_DETAIL_GROUP where item_id='a_good_130' and GROUP_NAME = '基本信息' ;
   IF V_CNT=0 THEN   
       insert into SYS_DETAIL_GROUP(ITEM_ID,GROUP_NAME,CLO_NAMES,COLUMN_NUMBER,SEQ_NO,PAUSE)
       values ('a_good_130','基本信息',CLO_NAMES_VAL,2,1,0);
   ELSE 
       update SYS_DETAIL_GROUP set (ITEM_ID,GROUP_NAME,CLO_NAMES,COLUMN_NUMBER,SEQ_NO,PAUSE)=(select 'a_good_130','基本信息',CLO_NAMES_VAL,2,1,0 from dual) where item_id='a_good_130' and GROUP_NAME = '基本信息' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_130_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_130_1','list','色码表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_130_1','list','色码表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT tcs.commodity_color_size_id,
       tcs.commodity_info_id,
       tcs.company_id,
       tcs.goo_id,
       tcs.barcode,
       tcs.color_code,
       tcs.colorname,
       tcs.sizecode,
       tcs.sizename
  FROM scmdata.t_commodity_color_size tcs
 WHERE tcs.commodity_info_id = :commodity_info_id
 ORDER BY tcs.color_code asc,tcs.sizecode asc]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_130_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_130_1',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_color_size_id,commodity_info_id,company_id,goo_id,color_code,sizecode',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_130_1',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_color_size_id,commodity_info_id,company_id,goo_id,color_code,sizecode',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_1' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_130_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_130_2','list','物料清单','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_130_2','list','物料清单','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT a.commodity_material_id,
       a.commodity_info_id,
       ga.group_dict_name material_type_desc,
       a.material_record_code,
       mr.material_code,
       mr.material_name,
       cg.color_desc,
       mri.specification,
       tsi.supplier_company_name SUPPLIER,
       a.material_record_item_code,
       mri.material_record_item_id
  FROM t_commodity_material_record a
  left join t_material_record_item mri
    on a.material_record_item_code = mri.material_record_item_code
   and a.company_id = mri.company_id
  left join t_material_record mr
    on a.material_record_code = mr.material_record_code
   and a.company_id = mr.company_id
  left join sys_group_dict ga
    on mr.material_type = ga.group_dict_value
   and ga.group_dict_type = 'MATERIAL_OBJECT_TYPE'
  left join t_supplier_info tsi
  on tsi.supplier_code=mr.supplier_code and tsi.company_id=a.company_id
  left join (select ca.company_dict_name  COLOR_DESC,
                    ca.company_dict_value COLOR
               from sys_company_dict ca
               left join sys_company_dict cb
                 on ca.company_dict_type = cb.company_dict_value
                and cb.company_id = %default_company_id%
              where cb.company_dict_type = 'GD_COLOR_LIST'
                and ca.company_id = %default_company_id%) cg
    on mri.color = cg.color
 WHERE a.commodity_info_id = :commodity_info_id]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_130_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_130_2',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'material_record_code,material_record_item_id,material_record_item_code,commodity_material_id,commodity_info_id,company_id',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_130_2',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'material_record_code,material_record_item_id,material_record_item_code,commodity_material_id,commodity_info_id,company_id',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_2' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='COLOR_DESC' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('COLOR_DESC','颜色',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'COLOR_DESC','颜色',1,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='COLOR_DESC' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_130_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_130_3','list','工艺单','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_130_3','list','工艺单','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT t.commodity_craft_id,
       t.company_id,
       t.commodity_info_id,
       t.craft_type,
       t.part,
       t.process_description
  FROM scmdata.t_commodity_craft t
 WHERE t.company_id = %default_company_id%
   AND t.commodity_info_id = :commodity_info_id]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_130_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_130_3',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,commodity_craft_id,craft_type',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_130_3',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,commodity_craft_id,craft_type',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_3' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_130_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_130_4','list','附件','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_130_4','list','附件','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT t.commodity_file_id,
       t.commodity_info_id,
       t.company_id,
       t.file_type,
       t.file_id,
       t.create_id,
       t.create_time,
       t.remarks,
       t.goo_id
  FROM scmdata.t_commodity_file t
 WHERE t.commodity_info_id = :commodity_info_id
 order by t.create_time asc]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_130_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_130_4',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,commodity_file_id,remarks,goo_id',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_130_4',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_info_id,company_id,commodity_file_id,remarks,goo_id',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_4' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='a_good_130_5' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('a_good_130_5','list','成分表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'a_good_130_5','list','成分表','oracle_scmdata',null,null,null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[select a.commodity_composition_id,
       a.commodity_info_id,
       a.composname,
       a.goo_raw,
       a.loadrate,
       a.memo
  from scmdata.t_commodity_composition a
  where a.commodity_info_id=:commodity_info_id]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='a_good_130_5' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('a_good_130_5',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_composition_id,commodity_info_id',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'a_good_130_5',null,null,null,null,null,SELECT_SQL_VAL,null,null,null,null,null,'commodity_composition_id,commodity_info_id',null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='a_good_130_5' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_12' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_12','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_12','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_12' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_122' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_122','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_122','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_122' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_1222' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_1222','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_1222','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_1222' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[delete from scmdata.t_commodity_info_import_temp  a where a.company_id=%default_company_id% and a.create_id=%user_id%]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_12' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_12','商品档案导入',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_12','商品档案导入',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_12' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[delete from scmdata.t_commodity_color_size_import_temp  a where a.company_id=%default_company_id% and a.create_id=%user_id%]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_122' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_122','色码表导入',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_122','色码表导入',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_122' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[
delete from scmdata.t_commodity_composition_import_temp  a where a.company_id=%default_company_id% and a.create_id=%user_id%]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_1222' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_1222','成分导入',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_1222','成分导入',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_1222' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_110' and element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_12' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_110','action_a_good_12',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_110','action_a_good_12',1,0,null from dual) where item_id='a_good_110' and element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_12' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_110' and element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_122' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_110','action_a_good_122',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_110','action_a_good_122',1,0,null from dual) where item_id='a_good_110' and element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_122' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_110' and element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_1222' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_110','action_a_good_1222',3,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_110','action_a_good_1222',3,0,null from dual) where item_id='a_good_110' and element_id in ('action_a_good_12','action_a_good_122','action_a_good_1222')  and ELEMENT_ID = 'action_a_good_1222' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('associate_a_good_111')  and ELEMENT_ID = 'associate_a_good_111' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('associate_a_good_111','associate','oracle_scmdata',0,null,1,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'associate_a_good_111','associate','oracle_scmdata',0,null,1,null,null,null from dual) where element_id in ('associate_a_good_111')  and ELEMENT_ID = 'associate_a_good_111' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ASSOCIATE where element_id in ('associate_a_good_111')  and ELEMENT_ID = 'associate_a_good_111' ;
   IF V_CNT=0 THEN   
       insert into SYS_ASSOCIATE(NODE_ID,ELEMENT_ID,FIELD_NAME,ASSOCIATE_TYPE,CAPTION,ICON_NAME,DATA_TYPE,DATA_SQL,OPEN_TYPE)
       values ('node_a_good_111','associate_a_good_111','COMMODITY_INFO_ID',6,'查看商品档案',null,2,null,null);
   ELSE 
       update SYS_ASSOCIATE set (NODE_ID,ELEMENT_ID,FIELD_NAME,ASSOCIATE_TYPE,CAPTION,ICON_NAME,DATA_TYPE,DATA_SQL,OPEN_TYPE)=(select 'node_a_good_111','associate_a_good_111','COMMODITY_INFO_ID',6,'查看商品档案',null,2,null,null from dual) where element_id in ('associate_a_good_111')  and ELEMENT_ID = 'associate_a_good_111' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_110' and element_id in ('associate_a_good_111')  and ELEMENT_ID = 'associate_a_good_111' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_110','associate_a_good_111',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_110','associate_a_good_111',1,0,null from dual) where item_id='a_good_110' and element_id in ('associate_a_good_111')  and ELEMENT_ID = 'associate_a_good_111' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('look_a_good_101_2','lookup',null,0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'look_a_good_101_2','lookup',null,0,null,null,null,null,null from dual) where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('look_a_good_101_3','lookup',null,1,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'look_a_good_101_3','lookup',null,1,null,null,null,null,null from dual) where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
LOOK_UP_SQL_VAL CLOB :=q'[SELECT t.group_dict_value SEASON,
       t.group_dict_name  SEASON_DESC
  FROM scmdata.sys_group_dict t
 WHERE t.group_dict_type = 'GD_SESON'
   AND t.pause = 0
 ORDER BY t.group_dict_value]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_LOOK_UP where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_LOOK_UP(ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)
       values ('look_a_good_101_2','SEASON_DESC',LOOK_UP_SQL_VAL,'1','SEASON','SEASON_DESC','SEASON',null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_LOOK_UP set (ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)=(select 'look_a_good_101_2','SEASON_DESC',LOOK_UP_SQL_VAL,'1','SEASON','SEASON_DESC','SEASON',null,null,null,null,null,null,null,null from dual) where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
LOOK_UP_SQL_VAL CLOB :=q'[SELECT t1.group_dict_value BASE_SIZE, t1.group_dict_name BASE_SIZE_DESC
  FROM scmdata.sys_group_dict t, scmdata.sys_group_dict t1
 WHERE t.group_dict_id = t1.parent_id
   AND (t.group_dict_type = 'GDN00' OR t.group_dict_type = 'GDV01')
   AND t1.pause = 0
   AND t1.group_dict_value IN
       (SELECT regexp_substr(v.size_list, '[^;]+', 1, LEVEL) size_gd
          FROM (SELECT tc.size_list
                  FROM scmdata.t_commodity_info tc
                 WHERE tc.commodity_info_id = :commodity_info_id
                   AND tc.company_id = :company_id) v
        CONNECT BY LEVEL <= regexp_count(v.size_list, '[^;]+'))
 ORDER BY t1.group_dict_value
 
/*SELECT t1.group_dict_value BASE_SIZE,
       t1.group_dict_name  BASE_SIZE_DESC
  FROM scmdata.sys_group_dict t, scmdata.sys_group_dict t1
 WHERE t.group_dict_id = t1.parent_id
   AND t.group_dict_value = 'GD_BASE_SIZE'
   AND t1.pause = 0
 ORDER BY t1.group_dict_value*/]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_LOOK_UP where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_LOOK_UP(ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)
       values ('look_a_good_101_3','BASE_SIZE_DESC',LOOK_UP_SQL_VAL,'1','BASE_SIZE','BASE_SIZE_DESC','BASE_SIZE',null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_LOOK_UP set (ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)=(select 'look_a_good_101_3','BASE_SIZE_DESC',LOOK_UP_SQL_VAL,'1','BASE_SIZE','BASE_SIZE_DESC','BASE_SIZE',null,null,null,null,null,null,null,null from dual) where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_111' and element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_111','look_a_good_101_2',2,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_111','look_a_good_101_2',2,0,null from dual) where item_id='a_good_111' and element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_111' and element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_111','look_a_good_101_3',3,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_111','look_a_good_101_3',3,0,null from dual) where item_id='a_good_111' and element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4_1','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4_1','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4_2','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4_2','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4_3','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4_3','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4_4','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4_4','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[SELECT gt.kit_template_code, gt.template_name, gt.kit_template_file_id
  FROM scmdata.sys_group_template_type t, scmdata.sys_group_template gt
 WHERE t.template_type_id = gt.template_type_id
   AND t.template_type_code = 'CRAFT_IMPORT']' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4_1','下载模板',null,0,ACTION_SQL_VAL,null,1,0,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4_1','下载模板',null,0,ACTION_SQL_VAL,null,1,0,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[declare
v_flag number := 1;
begin
       if v_flag = 1 then
          raise_application_error(-20002,'此按钮暂不支持上传功能，请从右侧工具栏进行导入数据！');
       end if;
end;]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4_2','上传',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4_2','上传',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[CALL scmdata.pkg_commodity_info.submit_comm_craft_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4_3','提交',null,4,ACTION_SQL_VAL,null,3,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4_3','提交',null,4,ACTION_SQL_VAL,null,3,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[call scmdata.pkg_commodity_info.delete_sys_company_user_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4_4','重置',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4_4','重置',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4_1','action_a_good_101_4_1',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4_1','action_a_good_101_4_1',1,0,null from dual) where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4_1','action_a_good_101_4_2',2,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4_1','action_a_good_101_4_2',2,0,null from dual) where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4_1','action_a_good_101_4_3',3,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4_1','action_a_good_101_4_3',3,0,null from dual) where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4_1','action_a_good_101_4_4',4,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4_1','action_a_good_101_4_4',4,0,null from dual) where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4_1','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4_1','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4_2','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4_2','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4_3','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4_3','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4_4','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4_4','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[SELECT gt.kit_template_code, gt.template_name, gt.kit_template_file_id
  FROM scmdata.sys_group_template_type t, scmdata.sys_group_template gt
 WHERE t.template_type_id = gt.template_type_id
   AND t.template_type_code = 'CRAFT_IMPORT']' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4_1','下载模板',null,0,ACTION_SQL_VAL,null,1,0,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4_1','下载模板',null,0,ACTION_SQL_VAL,null,1,0,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[declare
v_flag number := 1;
begin
       if v_flag = 1 then
          raise_application_error(-20002,'此按钮暂不支持上传功能，请从右侧工具栏进行导入数据！');
       end if;
end;]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4_2','上传',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4_2','上传',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[CALL scmdata.pkg_commodity_info.submit_comm_craft_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4_3','提交',null,4,ACTION_SQL_VAL,null,3,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4_3','提交',null,4,ACTION_SQL_VAL,null,3,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[call scmdata.pkg_commodity_info.delete_sys_company_user_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4_4','重置',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4_4','重置',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4_1','action_a_good_101_4_1',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4_1','action_a_good_101_4_1',1,0,null from dual) where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4_1','action_a_good_101_4_2',2,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4_1','action_a_good_101_4_2',2,0,null from dual) where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4_1','action_a_good_101_4_3',3,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4_1','action_a_good_101_4_3',3,0,null from dual) where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4_1','action_a_good_101_4_4',4,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4_1','action_a_good_101_4_4',4,0,null from dual) where item_id='a_good_101_4_1' and element_id in ('action_a_good_101_4_1','action_a_good_101_4_2','action_a_good_101_4_3','action_a_good_101_4_4')  and ELEMENT_ID = 'action_a_good_101_4_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('look_a_good_101_2','lookup',null,0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'look_a_good_101_2','lookup',null,0,null,null,null,null,null from dual) where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('look_a_good_101_3','lookup',null,1,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'look_a_good_101_3','lookup',null,1,null,null,null,null,null from dual) where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
LOOK_UP_SQL_VAL CLOB :=q'[SELECT t.group_dict_value SEASON,
       t.group_dict_name  SEASON_DESC
  FROM scmdata.sys_group_dict t
 WHERE t.group_dict_type = 'GD_SESON'
   AND t.pause = 0
 ORDER BY t.group_dict_value]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_LOOK_UP where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_LOOK_UP(ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)
       values ('look_a_good_101_2','SEASON_DESC',LOOK_UP_SQL_VAL,'1','SEASON','SEASON_DESC','SEASON',null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_LOOK_UP set (ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)=(select 'look_a_good_101_2','SEASON_DESC',LOOK_UP_SQL_VAL,'1','SEASON','SEASON_DESC','SEASON',null,null,null,null,null,null,null,null from dual) where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
LOOK_UP_SQL_VAL CLOB :=q'[SELECT t1.group_dict_value BASE_SIZE, t1.group_dict_name BASE_SIZE_DESC
  FROM scmdata.sys_group_dict t, scmdata.sys_group_dict t1
 WHERE t.group_dict_id = t1.parent_id
   AND (t.group_dict_type = 'GDN00' OR t.group_dict_type = 'GDV01')
   AND t1.pause = 0
   AND t1.group_dict_value IN
       (SELECT regexp_substr(v.size_list, '[^;]+', 1, LEVEL) size_gd
          FROM (SELECT tc.size_list
                  FROM scmdata.t_commodity_info tc
                 WHERE tc.commodity_info_id = :commodity_info_id
                   AND tc.company_id = :company_id) v
        CONNECT BY LEVEL <= regexp_count(v.size_list, '[^;]+'))
 ORDER BY t1.group_dict_value
 
/*SELECT t1.group_dict_value BASE_SIZE,
       t1.group_dict_name  BASE_SIZE_DESC
  FROM scmdata.sys_group_dict t, scmdata.sys_group_dict t1
 WHERE t.group_dict_id = t1.parent_id
   AND t.group_dict_value = 'GD_BASE_SIZE'
   AND t1.pause = 0
 ORDER BY t1.group_dict_value*/]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_LOOK_UP where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_LOOK_UP(ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)
       values ('look_a_good_101_3','BASE_SIZE_DESC',LOOK_UP_SQL_VAL,'1','BASE_SIZE','BASE_SIZE_DESC','BASE_SIZE',null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_LOOK_UP set (ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)=(select 'look_a_good_101_3','BASE_SIZE_DESC',LOOK_UP_SQL_VAL,'1','BASE_SIZE','BASE_SIZE_DESC','BASE_SIZE',null,null,null,null,null,null,null,null from dual) where element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_111' and element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_111','look_a_good_101_2',2,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_111','look_a_good_101_2',2,0,null from dual) where item_id='a_good_111' and element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_111' and element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_111','look_a_good_101_3',3,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_111','look_a_good_101_3',3,0,null from dual) where item_id='a_good_111' and element_id in ('look_a_good_101_2','look_a_good_101_3')  and ELEMENT_ID = 'look_a_good_101_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_1' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_1','S',1,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_1','S',1,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_2','S',2,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_2','S',2,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_3' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_3','S',3,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_3','S',3,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_4' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_4','S',4,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_4','S',4,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_5' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_5','S',5,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_5','S',5,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_111'and relate_id = 'a_good_111_1' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_111','a_good_111_1','S',1,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_111','a_good_111_1','S',1,0 from dual) where item_id='a_good_111'and relate_id = 'a_good_111_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select 0 flag from dual where 1=1]' ;SHOW_TEXT_VAL CLOB :=q'[下一步]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_action_a_good_101_2_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_action_a_good_101_2_1',COND_SQL_VAL,0,SHOW_TEXT_VAL,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_action_a_good_101_2_1',COND_SQL_VAL,0,SHOW_TEXT_VAL,'oracle_scmdata',null,null from dual) where cond_id = 'cond_action_a_good_101_2_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_action_a_good_101_2_1' and ctl_id = 'action_a_good_101_2_1' and obj_type = 91 and ctl_type = 1 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_action_a_good_101_2_1',91,'action_a_good_101_2_1',1,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_action_a_good_101_2_1',91,'action_a_good_101_2_1',1,1,0,null from dual) where cond_id = 'cond_action_a_good_101_2_1' and ctl_id = 'action_a_good_101_2_1' and obj_type = 91 and ctl_type = 1 ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
CONTENT_VAL CLOB :=q'[即将跳转到物料档案管理页面]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_OPERATE where cond_id = 'cond_action_a_good_101_2_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_OPERATE(COND_ID,CAPTION,CONTENT,TO_CONFIRM_ITEM_ID,TO_CANCEL_ITEM_ID)
       values ('cond_action_a_good_101_2_1','跳转',CONTENT_VAL,'a_material_101',null);
   ELSE 
       update SYS_COND_OPERATE set (COND_ID,CAPTION,CONTENT,TO_CONFIRM_ITEM_ID,TO_CANCEL_ITEM_ID)=(select 'cond_action_a_good_101_2_1','跳转',CONTENT_VAL,'a_material_101',null from dual) where cond_id = 'cond_action_a_good_101_2_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('pick_a_good_101_2_add')  and ELEMENT_ID = 'pick_a_good_101_2_add' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('pick_a_good_101_2_add','pick','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'pick_a_good_101_2_add','pick','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('pick_a_good_101_2_add')  and ELEMENT_ID = 'pick_a_good_101_2_add' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
PICK_SQL_VAL CLOB :=q'[select ga.group_dict_name        material_type_desc,
       mr.material_code,
       mr.material_name,
       a.color,
       --cg.color_desc,
       a.specification,
       tsi.supplier_company_name SUPPLIER,
       a.material_record_item_id,
       mr.material_record_code
  from (select *
          from t_material_record_item
         where material_record_item_code not in
               (select material_record_item_code
                  from t_commodity_material_record
                 where commodity_info_id = :commodity_info_id)
           and company_id = %default_company_id%) a
 inner join t_material_record mr
    on a.material_record_id = mr.material_record_id
   and mr.pause = 0
   and mr.company_id = %default_company_id%
 inner join sys_group_dict ga
    on mr.material_type = ga.group_dict_value
   and ga.group_dict_type = 'MATERIAL_OBJECT_TYPE'
  left join t_supplier_info tsi
    on tsi.supplier_code = mr.supplier_code
   and tsi.company_id = a.company_id
  /*left join (select ca.company_dict_name  COLOR_DESC,
                    ca.company_dict_value COLOR
               from sys_company_dict ca
               left join sys_company_dict cb
                 on ca.company_dict_type = cb.company_dict_value
                and cb.company_id = %default_company_id%
              where cb.company_dict_type = 'GD_COLOR_LIST'
                and ca.company_id = %default_company_id%) cg
    on a.color = cg.color*/]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_PICK_LIST where element_id in ('pick_a_good_101_2_add')  and ELEMENT_ID = 'pick_a_good_101_2_add' ;
   IF V_CNT=0 THEN   
       insert into SYS_PICK_LIST(ELEMENT_ID,FIELD_NAME,CAPTION,PICK_SQL,FROM_FIELD,QUERY_FIELDS,OTHER_FIELDS,TREE_FIELDS,LEVEL_FIELD,IMAGE_NAMES,TREE_ID,SEPERATOR,MULTI_VALUE_FLAG,RECURSION_FLAG,CUSTOM_QUERY,NAME_LIST_SQL,PORT_ID,PORT_SQL)
       values ('pick_a_good_101_2_add','MATERIAL_CODE','选择物料档案',PICK_SQL_VAL,'MATERIAL_CODE',null,'MATERIAL_RECORD_CODE,MATERIAL_RECORD_ITEM_ID,MATERIAL_TYPE_DESC,MATERIAL_NAME,COLOR,COLOR_DESC,SPECIFICATION,SUPPLIER',null,null,null,null,null,null,null,0,null,null,null);
   ELSE 
       update SYS_PICK_LIST set (ELEMENT_ID,FIELD_NAME,CAPTION,PICK_SQL,FROM_FIELD,QUERY_FIELDS,OTHER_FIELDS,TREE_FIELDS,LEVEL_FIELD,IMAGE_NAMES,TREE_ID,SEPERATOR,MULTI_VALUE_FLAG,RECURSION_FLAG,CUSTOM_QUERY,NAME_LIST_SQL,PORT_ID,PORT_SQL)=(select 'pick_a_good_101_2_add','MATERIAL_CODE','选择物料档案',PICK_SQL_VAL,'MATERIAL_CODE',null,'MATERIAL_RECORD_CODE,MATERIAL_RECORD_ITEM_ID,MATERIAL_TYPE_DESC,MATERIAL_NAME,COLOR,COLOR_DESC,SPECIFICATION,SUPPLIER',null,null,null,null,null,null,null,0,null,null,null from dual) where element_id in ('pick_a_good_101_2_add')  and ELEMENT_ID = 'pick_a_good_101_2_add' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_2' and element_id in ('pick_a_good_101_2_add')  and ELEMENT_ID = 'pick_a_good_101_2_add' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_2','pick_a_good_101_2_add',1,1,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_2','pick_a_good_101_2_add',1,1,null from dual) where item_id='a_good_101_2' and element_id in ('pick_a_good_101_2_add')  and ELEMENT_ID = 'pick_a_good_101_2_add' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_2_1','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_2_1','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_2_2','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_2_2','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[select 1 from dual]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_2_1','新增物料',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_2_1','新增物料',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[select ga.group_dict_name        material_type_desc,
       mr.material_code,
       mr.material_name,
       --cg.color_desc,
       a.color,
       a.specification,
       mr.SUPPLIER_name SUPPLIER,
       a.material_record_item_id,
       mr.material_record_code
  from (select *
          from t_material_record_item
         where material_record_item_code not in
               (select material_record_item_code
                  from t_commodity_material_record
                 where commodity_info_id = :commodity_info_id)
           and company_id = %default_company_id%) a
 inner join t_material_record mr
    on a.material_record_id = mr.material_record_id
   and mr.pause = 0
   and mr.company_id = %default_company_id%
 inner join sys_group_dict ga
    on mr.material_type = ga.group_dict_value
   and ga.group_dict_type = 'MATERIAL_OBJECT_TYPE'
  /*left join t_supplier_info tsi
    on tsi.supplier_code = mr.supplier_code
   and tsi.company_id = a.company_id
  left join (select ca.company_dict_name  COLOR_DESC,
                    ca.company_dict_value COLOR
               from sys_company_dict ca
               left join sys_company_dict cb
                 on ca.company_dict_type = cb.company_dict_value
                and cb.company_id = %default_company_id%
              where cb.company_dict_type = 'GD_COLOR_LIST'
                and ca.company_id = %default_company_id%) cg
    on a.color = cg.color*/]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_2_2','添加物料',null,5,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,'material_name,SUPPLIER');
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_2_2','添加物料',null,5,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,'material_name,SUPPLIER' from dual) where element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_2' and element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_1' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_2','action_a_good_101_2_1',2,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_2','action_a_good_101_2_1',2,0,null from dual) where item_id='a_good_101_2' and element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_2' and element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_2','action_a_good_101_2_2',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_2','action_a_good_101_2_2',1,0,null from dual) where item_id='a_good_101_2' and element_id in ('action_a_good_101_2_1','action_a_good_101_2_2')  and ELEMENT_ID = 'action_a_good_101_2_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_111'and relate_id = 'a_good_101_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_111','a_good_101_2','S',2,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_111','a_good_101_2','S',2,0 from dual) where item_id='a_good_111'and relate_id = 'a_good_101_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('look_a_good_101_4')  and ELEMENT_ID = 'look_a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('look_a_good_101_4','lookup','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'look_a_good_101_4','lookup','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('look_a_good_101_4')  and ELEMENT_ID = 'look_a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
LOOK_UP_SQL_VAL CLOB :=q'[SELECT t1.group_dict_value CRAFT_TYPE,
       t1.group_dict_name  CRAFT_TYPE_DESC
  FROM scmdata.sys_group_dict t, scmdata.sys_group_dict t1
 WHERE t.group_dict_id = t1.parent_id
   AND t.group_dict_value = 'GD_CRAFT_TYPE'
   AND t1.pause = 0
 ORDER BY t1.group_dict_value]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_LOOK_UP where element_id in ('look_a_good_101_4')  and ELEMENT_ID = 'look_a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_LOOK_UP(ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)
       values ('look_a_good_101_4','CRAFT_TYPE_DESC',LOOK_UP_SQL_VAL,'1','CRAFT_TYPE','CRAFT_TYPE_DESC','CRAFT_TYPE',null,0,null,null,null,null,null,null);
   ELSE 
       update SYS_LOOK_UP set (ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)=(select 'look_a_good_101_4','CRAFT_TYPE_DESC',LOOK_UP_SQL_VAL,'1','CRAFT_TYPE','CRAFT_TYPE_DESC','CRAFT_TYPE',null,0,null,null,null,null,null,null from dual) where element_id in ('look_a_good_101_4')  and ELEMENT_ID = 'look_a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4' and element_id in ('look_a_good_101_4')  and ELEMENT_ID = 'look_a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4','look_a_good_101_4',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4','look_a_good_101_4',1,0,null from dual) where item_id='a_good_101_4' and element_id in ('look_a_good_101_4')  and ELEMENT_ID = 'look_a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_a_good_101_4')  and ELEMENT_ID = 'action_a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_a_good_101_4','action','oracle_scmdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_a_good_101_4','action','oracle_scmdata',0,null,null,null,null,null from dual) where element_id in ('action_a_good_101_4')  and ELEMENT_ID = 'action_a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[--select 1 from dual
call scmdata.pkg_commodity_info.delete_sys_company_user_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_a_good_101_4')  and ELEMENT_ID = 'action_a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_a_good_101_4','工艺单导入',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_a_good_101_4','工艺单导入',null,4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_a_good_101_4')  and ELEMENT_ID = 'action_a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_4' and element_id in ('action_a_good_101_4')  and ELEMENT_ID = 'action_a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_4','action_a_good_101_4',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_4','action_a_good_101_4',1,0,null from dual) where item_id='a_good_101_4' and element_id in ('action_a_good_101_4')  and ELEMENT_ID = 'action_a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_111'and relate_id = 'a_good_101_4' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_111','a_good_101_4','S',3,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_111','a_good_101_4','S',3,0 from dual) where item_id='a_good_111'and relate_id = 'a_good_101_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('lookup_a_good_101_5')  and ELEMENT_ID = 'lookup_a_good_101_5' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('lookup_a_good_101_5','lookup','oracle_scmdata',0,null,0,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'lookup_a_good_101_5','lookup','oracle_scmdata',0,null,0,null,null,null from dual) where element_id in ('lookup_a_good_101_5')  and ELEMENT_ID = 'lookup_a_good_101_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
LOOK_UP_SQL_VAL CLOB :=q'[SELECT gd1.group_dict_value file_type,
         gd1.group_dict_name  file_type_gd
    FROM scmdata.sys_group_dict gd, scmdata.sys_group_dict gd1
   WHERE gd.group_dict_value = gd1.group_dict_type
     AND gd.group_dict_value = 'FILE_TYPE']' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_LOOK_UP where element_id in ('lookup_a_good_101_5')  and ELEMENT_ID = 'lookup_a_good_101_5' ;
   IF V_CNT=0 THEN   
       insert into SYS_LOOK_UP(ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)
       values ('lookup_a_good_101_5','FILE_TYPE',LOOK_UP_SQL_VAL,'1','FILE_TYPE','FILE_TYPE_GD','FILE_TYPE',0,0,'0',null,null,null,null,null);
   ELSE 
       update SYS_LOOK_UP set (ELEMENT_ID,FIELD_NAME,LOOK_UP_SQL,DATA_TYPE,KEY_FIELD,RESULT_FIELD,BEFORE_FIELD,SEARCH_FLAG,MULTI_VALUE_FLAG,DISABLED_FIELD,GROUP_FIELD,VALUE_SEP,ICON,PORT_ID,PORT_SQL)=(select 'lookup_a_good_101_5','FILE_TYPE',LOOK_UP_SQL_VAL,'1','FILE_TYPE','FILE_TYPE_GD','FILE_TYPE',0,0,'0',null,null,null,null,null from dual) where element_id in ('lookup_a_good_101_5')  and ELEMENT_ID = 'lookup_a_good_101_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='a_good_101_5' and element_id in ('lookup_a_good_101_5')  and ELEMENT_ID = 'lookup_a_good_101_5' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('a_good_101_5','lookup_a_good_101_5',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'a_good_101_5','lookup_a_good_101_5',1,0,null from dual) where item_id='a_good_101_5' and element_id in ('lookup_a_good_101_5')  and ELEMENT_ID = 'lookup_a_good_101_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_111'and relate_id = 'a_good_101_5' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_111','a_good_101_5','S',4,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_111','a_good_101_5','S',4,0 from dual) where item_id='a_good_111'and relate_id = 'a_good_101_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_111'and relate_id = 'a_good_101_6' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_111','a_good_101_6','S',5,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_111','a_good_101_6','S',5,0 from dual) where item_id='a_good_111'and relate_id = 'a_good_101_6' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_1' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_1','S',1,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_1','S',1,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_1' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_2','S',2,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_2','S',2,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_2' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_3' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_3','S',3,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_3','S',3,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_3' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_4' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_4','S',4,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_4','S',4,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_rela where item_id='a_good_130'and relate_id = 'a_good_130_5' ;
   IF V_CNT=0 THEN   
       insert into sys_item_rela(ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)
       values ('a_good_130','a_good_130_5','S',5,0);
   ELSE 
       update sys_item_rela set (ITEM_ID,RELATE_ID,RELATE_TYPE,SEQ_NO,PAUSE)=(select 'a_good_130','a_good_130_5','S',5,0 from dual) where item_id='a_good_130'and relate_id = 'a_good_130_5' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_good_110' ;
   IF V_CNT=0 THEN   
       insert into SYS_TREE_LIST(NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)
       values ('node_a_good_110','tree_a_good','a_good_110','a_good_99',null,'scm',null,0,null,1,0,0,null,null,1,1);
   ELSE 
       update SYS_TREE_LIST set (NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)=(select 'node_a_good_110','tree_a_good','a_good_110','a_good_99',null,'scm',null,0,null,1,0,0,null,null,1,1 from dual) where node_id='node_a_good_110' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
COND_SQL_VAL CLOB :=q'[select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00501') as flag from dual ]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_LIST where cond_id = 'cond_node_a_good_110_auto' ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_LIST(COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)
       values ('cond_node_a_good_110_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null);
   ELSE 
       update SYS_COND_LIST set (COND_ID,COND_SQL,COND_TYPE,SHOW_TEXT,DATA_SOURCE,COND_FIELD_NAME,MEMO)=(select 'cond_node_a_good_110_auto',COND_SQL_VAL,0,null,'oracle_scmdata',null,null from dual) where cond_id = 'cond_node_a_good_110_auto' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_node_a_good_110_auto' and ctl_id = 'node_a_good_110' and obj_type = 0 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_node_a_good_110_auto',0,'node_a_good_110',0,1,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_node_a_good_110_auto',0,'node_a_good_110',0,1,0,null from dual) where cond_id = 'cond_node_a_good_110_auto' and ctl_id = 'node_a_good_110' and obj_type = 0 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_good_111' ;
   IF V_CNT=0 THEN   
       insert into SYS_TREE_LIST(NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)
       values ('node_a_good_111','tree_a_good','a_good_111','a_good_110',null,'scm',null,0,null,2,0,0,null,null,1,1);
   ELSE 
       update SYS_TREE_LIST set (NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)=(select 'node_a_good_111','tree_a_good','a_good_111','a_good_110',null,'scm',null,0,null,2,0,0,null,null,1,1 from dual) where node_id='node_a_good_111' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_good_130' ;
   IF V_CNT=0 THEN   
       insert into SYS_TREE_LIST(NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)
       values ('node_a_good_130','tree_a_good','a_good_130','a_good_110',null,'scm',null,null,null,1,0,null,null,null,1,1);
   ELSE 
       update SYS_TREE_LIST set (NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)=(select 'node_a_good_130','tree_a_good','a_good_130','a_good_110',null,'scm',null,null,null,1,0,null,null,null,1,1 from dual) where node_id='node_a_good_130' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_good_101_4_1_temp' ;
   IF V_CNT=0 THEN   
       insert into SYS_TREE_LIST(NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)
       values ('node_a_good_101_4_1_temp','tree_a_good','a_good_101_4_1','a_good_110',null,'scm',null,null,null,1,0,null,null,null,1,1);
   ELSE 
       update SYS_TREE_LIST set (NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)=(select 'node_a_good_101_4_1_temp','tree_a_good','a_good_101_4_1','a_good_110',null,'scm',null,null,null,1,0,null,null,null,1,1 from dual) where node_id='node_a_good_101_4_1_temp' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_good_130' ;
   IF V_CNT=0 THEN   
       insert into SYS_TREE_LIST(NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)
       values ('node_a_good_130','tree_a_good','a_good_130','a_good_110',null,'scm',null,null,null,1,0,null,null,null,1,1);
   ELSE 
       update SYS_TREE_LIST set (NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)=(select 'node_a_good_130','tree_a_good','a_good_130','a_good_110',null,'scm',null,null,null,1,0,null,null,null,1,1 from dual) where node_id='node_a_good_130' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_good_101_4_1_temp' ;
   IF V_CNT=0 THEN   
       insert into SYS_TREE_LIST(NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)
       values ('node_a_good_101_4_1_temp','tree_a_good','a_good_101_4_1','a_good_110',null,'scm',null,null,null,1,0,null,null,null,1,1);
   ELSE 
       update SYS_TREE_LIST set (NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)=(select 'node_a_good_101_4_1_temp','tree_a_good','a_good_101_4_1','a_good_110',null,'scm',null,null,null,1,0,null,null,null,1,1 from dual) where node_id='node_a_good_101_4_1_temp' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_a_good_111' ;
   IF V_CNT=0 THEN   
       insert into SYS_TREE_LIST(NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)
       values ('node_a_good_111','tree_a_good','a_good_111','a_good_110',null,'scm',null,0,null,2,0,0,null,null,1,1);
   ELSE 
       update SYS_TREE_LIST set (NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)=(select 'node_a_good_111','tree_a_good','a_good_111','a_good_110',null,'scm',null,0,null,2,0,0,null,null,1,1 from dual) where node_id='node_a_good_111' ;
   END IF;
 END ;
 END ;
/

