 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM where item_id='g_520' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM(ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)
       values ('g_520','list','接口管理','oracle_nsfdata','T_INTERFACE','INTERFACE_ID',null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM set (ITEM_ID,ITEM_TYPE,CAPTION_SQL,DATA_SOURCE,BASE_TABLE,KEY_FIELD,NAME_FIELD,SETTING_ID,REPORT_TITLE,SUB_SCRIPTS,PAUSE,LINK_FIELD,HELP_ID,TAG_ID,CONFIG_PARAMS,TIME_OUT,OFFLINE_FLAG,PANEL_ID,INIT_SHOW,BADGE_FLAG,BADGE_SQL,MEMO,SHOW_ROWID)=(select 'g_520','list','接口管理','oracle_nsfdata','T_INTERFACE','INTERFACE_ID',null,null,null,null,0,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='g_520' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
SELECT_SQL_VAL CLOB :=q'[SELECT t.interface_id,
       t.company_id,
       fc.logn_name,
       t.itf_name,
       t.pause,
       t.dock_item_id,
       t.dock_item_caption,
       t.ctl_item_id,
       t.ctl_item_caption,
       t.ds_item_id,
       t.ds_item_caption,
       t.error_resolve_item_id,
       t.error_resolve_caption
  FROM nsfdata.t_interface t
 INNER JOIN nsfdata.sys_company fc
    ON t.company_id = fc.company_id]' ;INSERT_SQL_VAL CLOB :=null ;UPDATE_SQL_VAL CLOB :=null ;DELETE_SQL_VAL CLOB :=null;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ITEM_LIST where item_id='g_520' ;
   IF V_CNT=0 THEN   
       insert into SYS_ITEM_LIST(ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)
       values ('g_520',null,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,DELETE_SQL_VAL,'company_id,pause',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update SYS_ITEM_LIST set (ITEM_ID,QUERY_TYPE,QUERY_FIELDS,QUERY_COUNT,EDIT_EXPRESS,NEWID_SQL,SELECT_SQL,DETAIL_SQL,SUBSELECT_SQL,INSERT_SQL,UPDATE_SQL,DELETE_SQL,NOSHOW_FIELDS,NOADD_FIELDS,NOMODIFY_FIELDS,NOEDIT_FIELDS,SUBNOSHOW_FIELDS,UI_TMPL,MULTI_PAGE_FLAG,OUTPUT_PARAMETER,LOCK_SQL,MONITOR_ID,END_FIELD,EXECUTE_TIME,SCANNABLE_FIELD,SCANNABLE_TYPE,AUTO_REFRESH,RFID_FLAG,SCANNABLE_TIME,MAX_ROW_COUNT,NOSHOW_APP_FIELDS,SCANNABLE_LOCATION_LINE,SUB_TABLE_JUDGE_FIELD,BACK_GROUND_ID,OPRETION_HINT,SUB_EDIT_STATE,HINT_TYPE,HEADER,FOOTER,JUMP_FIELD,JUMP_EXPRESS,OPEN_MODE,OPERATION_TYPE)=(select 'g_520',null,null,null,null,null,SELECT_SQL_VAL,null,null,INSERT_SQL_VAL,UPDATE_SQL_VAL,DELETE_SQL_VAL,'company_id,pause',null,null,null,null,null,1,null,null,null,null,null,null,null,1,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where item_id='g_520' ;
   END IF;
 END ;
 END ;
/


 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CTL_ITEM_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('CTL_ITEM_ID','接口监控(ITEM_ID)',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'CTL_ITEM_ID','接口监控(ITEM_ID)',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='CTL_ITEM_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='LOGN_NAME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('LOGN_NAME','企业全称',1,null,null,null,'^([\u4e00-\u9fa5]|[\uff08\uff09]){1,}$','根据中国大陆相关法规，企业全称应由中文和括号组成',0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'LOGN_NAME','企业全称',1,null,null,null,'^([\u4e00-\u9fa5]|[\uff08\uff09]){1,}$','根据中国大陆相关法规，企业全称应由中文和括号组成',0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='LOGN_NAME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DOCK_ITEM_CAPTION' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('DOCK_ITEM_CAPTION','接口界面',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'DOCK_ITEM_CAPTION','接口界面',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='DOCK_ITEM_CAPTION' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ERROR_RESOLVE_CAPTION' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('ERROR_RESOLVE_CAPTION','错误处理',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'ERROR_RESOLVE_CAPTION','错误处理',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='ERROR_RESOLVE_CAPTION' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DS_ITEM_CAPTION' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('DS_ITEM_CAPTION','数据源',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'DS_ITEM_CAPTION','数据源',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='DS_ITEM_CAPTION' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DS_ITEM_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('DS_ITEM_ID','数据源(ITEM_ID)',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'DS_ITEM_ID','数据源(ITEM_ID)',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='DS_ITEM_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ERROR_RESOLVE_ITEM_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('ERROR_RESOLVE_ITEM_ID','错误处理',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'ERROR_RESOLVE_ITEM_ID','错误处理',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='ERROR_RESOLVE_ITEM_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='PAUSE' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('PAUSE','禁用',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'17',null,null,null,0,0,null,null,null,null,'1','0',null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'PAUSE','禁用',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,'17',null,null,null,0,0,null,null,null,null,'1','0',null,null,null,null,null,null,null,null,null,null from dual) where field_name='PAUSE' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='INTERFACE_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('INTERFACE_ID','接口编码',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'INTERFACE_ID','接口编码',0,null,null,null,null,null,0,0,0,0,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='INTERFACE_ID' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='ITF_NAME' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('ITF_NAME','接口名称',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'ITF_NAME','接口名称',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='ITF_NAME' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='DOCK_ITEM_ID' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('DOCK_ITEM_ID','接口界面(ITEM_ID)',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'DOCK_ITEM_ID','接口界面(ITEM_ID)',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='DOCK_ITEM_ID' ;
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
   SELECT COUNT(*) INTO V_CNT FROM sys_field_list where field_name='CTL_ITEM_CAPTION' ;
   IF V_CNT=0 THEN   
       insert into sys_field_list(FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)
       values ('CTL_ITEM_CAPTION','接口监控',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
   ELSE 
       update sys_field_list set (FIELD_NAME,CAPTION,REQUIERED_FLAG,INPUT_HINT,VALID_CHARS,INVALID_CHARS,CHECK_EXPRESS,CHECK_MESSAGE,READ_ONLY_FLAG,NO_EDIT,NO_COPY,NO_SUM,NO_SORT,ALIGNMENT,MAX_LENGTH,MIN_LENGTH,DISPLAY_WIDTH,DISPLAY_FORMAT,EDIT_FORMT,DATA_TYPE,MAX_VALUE,MIN_VALUE,DEFAULT_VALUE,IME_CARE,IME_OPEN,VALUE_LISTS,VALUE_LIST_TYPE,HYPER_RES,MULTI_VALUE_FLAG,TRUE_EXPR,FALSE_EXPR,NAME_RULE_FLAG,NAME_RULE_ID,DATA_TYPE_FLAG,ALLOW_SCAN,VALUE_ENCRYPT,VALUE_SENSITIVE,OPERATOR_FLAG,VALUE_DISPLAY_STYLE,TO_ITEM_ID,VALUE_SENSITIVE_REPLACEMENT)=(select 'CTL_ITEM_CAPTION','接口监控',0,null,null,null,null,null,0,0,0,null,0,0,null,null,null,null,null,null,null,null,null,0,0,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null from dual) where field_name='CTL_ITEM_CAPTION' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('pick_g_520_c')  and ELEMENT_ID = 'pick_g_520_c' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('pick_g_520_c','pick','oracle_nsfdata',0,null,null,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'pick_g_520_c','pick','oracle_nsfdata',0,null,null,null,null,null from dual) where element_id in ('pick_g_520_c')  and ELEMENT_ID = 'pick_g_520_c' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
PICK_SQL_VAL CLOB :=q'[select a.company_id, a.company_name, a.logn_name, a.puase
  from nsfdata.sys_company a]' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_PICK_LIST where element_id in ('pick_g_520_c')  and ELEMENT_ID = 'pick_g_520_c' ;
   IF V_CNT=0 THEN   
       insert into SYS_PICK_LIST(ELEMENT_ID,FIELD_NAME,CAPTION,PICK_SQL,FROM_FIELD,QUERY_FIELDS,OTHER_FIELDS,TREE_FIELDS,LEVEL_FIELD,IMAGE_NAMES,TREE_ID,SEPERATOR,MULTI_VALUE_FLAG,RECURSION_FLAG,CUSTOM_QUERY,NAME_LIST_SQL,PORT_ID,PORT_SQL)
       values ('pick_g_520_c','LOGN_NAME','选择公司',PICK_SQL_VAL,'LOGN_NAME','LOGN_NAME','COMPANY_ID',null,null,null,null,null,null,null,0,null,null,null);
   ELSE 
       update SYS_PICK_LIST set (ELEMENT_ID,FIELD_NAME,CAPTION,PICK_SQL,FROM_FIELD,QUERY_FIELDS,OTHER_FIELDS,TREE_FIELDS,LEVEL_FIELD,IMAGE_NAMES,TREE_ID,SEPERATOR,MULTI_VALUE_FLAG,RECURSION_FLAG,CUSTOM_QUERY,NAME_LIST_SQL,PORT_ID,PORT_SQL)=(select 'pick_g_520_c','LOGN_NAME','选择公司',PICK_SQL_VAL,'LOGN_NAME','LOGN_NAME','COMPANY_ID',null,null,null,null,null,null,null,0,null,null,null from dual) where element_id in ('pick_g_520_c')  and ELEMENT_ID = 'pick_g_520_c' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='g_520' and element_id in ('pick_g_520_c')  and ELEMENT_ID = 'pick_g_520_c' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('g_520','pick_g_520_c',1,1,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'g_520','pick_g_520_c',1,1,null from dual) where item_id='g_520' and element_id in ('pick_g_520_c')  and ELEMENT_ID = 'pick_g_520_c' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_g_520_1','action','oracle_nsfdata',0,null,1,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_g_520_1','action','oracle_nsfdata',0,null,1,null,null,null from dual) where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_g_520_2','action','oracle_nsfdata',0,null,1,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_g_520_2','action','oracle_nsfdata',0,null,1,null,null,null from dual) where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_g_520_3','action','oracle_nsfdata',0,null,1,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_g_520_3','action','oracle_nsfdata',0,null,1,null,null,null from dual) where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ELEMENT where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ELEMENT(ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)
       values ('action_g_520_4','action','oracle_nsfdata',0,null,1,null,null,null);
   ELSE 
       update SYS_ELEMENT set (ELEMENT_ID,ELEMENT_TYPE,DATA_SOURCE,PAUSE,MESSAGE,IS_HIDE,MEMO,IS_ASYNC,IS_PER_EXE)=(select 'action_g_520_4','action','oracle_nsfdata',0,null,1,null,null,null from dual) where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[UPDATE bwptest1.sys_cond_operate t
   SET t.content           =
       (SELECT '是否前往' || itf.dock_item_caption || '页面？'
          FROM t_interface itf
         WHERE itf.interface_id = :interface_id),
       t.to_confirm_item_id =
       (SELECT itf.dock_item_id
          FROM t_interface itf
         WHERE itf.interface_id = :interface_id)
 WHERE t.cond_id = 'cond_action_g_520_1']' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_1' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_g_520_1','接口界面','icon-daoru',4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_g_520_1','接口界面','icon-daoru',4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[UPDATE bwptest1.sys_cond_operate t
   SET t.content           =
       (SELECT '是否前往' || itf.ctl_item_caption || '页面？'
          FROM t_interface itf
         WHERE itf.interface_id = :interface_id),
       t.to_confirm_item_id =
       (SELECT itf.ctl_item_id
          FROM t_interface itf
         WHERE itf.interface_id = :interface_id)
 WHERE t.cond_id = 'cond_action_g_520_2']' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_2' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_g_520_2','接口监控','icon-daoru',4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_g_520_2','接口监控','icon-daoru',4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[UPDATE bwptest1.sys_cond_operate t
   SET t.content           =
       (SELECT '是否前往' || itf.ds_item_caption || '页面？'
          FROM t_interface itf
         WHERE itf.interface_id = :interface_id),
       t.to_confirm_item_id =
       (SELECT itf.ds_item_id
          FROM t_interface itf
         WHERE itf.interface_id = :interface_id)
 WHERE t.cond_id = 'cond_action_g_520_3']' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_3' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_g_520_3','数据源','icon-daoru',4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_g_520_3','数据源','icon-daoru',4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 
ACTION_SQL_VAL CLOB :=q'[UPDATE bwptest1.sys_cond_operate t
   SET t.content           =
       (SELECT '是否前往' || itf.ERROR_RESOLVE_caption || '页面？'
          FROM t_interface itf
         WHERE itf.interface_id = :interface_id),
       t.to_confirm_item_id =
       (SELECT itf.ERROR_RESOLVE_ITEM_ID
          FROM t_interface itf
         WHERE itf.interface_id = :interface_id)
 WHERE t.cond_id = 'cond_action_g_520_4']' ;
 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_ACTION where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_4' ;
   IF V_CNT=0 THEN   
       insert into SYS_ACTION(ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)
       values ('action_g_520_4','错误处理','icon-daoru',4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null);
   ELSE 
       update SYS_ACTION set (ELEMENT_ID,CAPTION,ICON_NAME,ACTION_TYPE,ACTION_SQL,SELECT_FIELDS,REFRESH_FLAG,MULTI_PAGE_FLAG,PRE_FLAG,FILTER_EXPRESS,UPDATE_FIELDS,PORT_ID,PORT_SQL,LOCK_SQL,SELECTION_FLAG,CALL_ID,OPERATE_MODE,PORT_TYPE,QUERY_FIELDS)=(select 'action_g_520_4','错误处理','icon-daoru',4,ACTION_SQL_VAL,null,1,1,null,null,null,null,null,null,0,null,null,1,null from dual) where element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='g_520' and element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_1' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('g_520','action_g_520_1',1,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'g_520','action_g_520_1',1,0,null from dual) where item_id='g_520' and element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_1' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='g_520' and element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_2' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('g_520','action_g_520_2',2,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'g_520','action_g_520_2',2,0,null from dual) where item_id='g_520' and element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_2' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='g_520' and element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_3' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('g_520','action_g_520_3',3,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'g_520','action_g_520_3',3,0,null from dual) where item_id='g_520' and element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_3' ;
   END IF;
 END ;
 END ;
/
 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM sys_item_element_rela where item_id='g_520' and element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_4' ;
   IF V_CNT=0 THEN   
       insert into sys_item_element_rela(ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)
       values ('g_520','action_g_520_4',4,0,null);
   ELSE 
       update sys_item_element_rela set (ITEM_ID,ELEMENT_ID,SEQ_NO,PAUSE,LEVEL_NO)=(select 'g_520','action_g_520_4',4,0,null from dual) where item_id='g_520' and element_id in ('action_g_520_1','action_g_520_2','action_g_520_3','action_g_520_4')  and ELEMENT_ID = 'action_g_520_4' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_TREE_LIST where node_id='node_g_520' ;
   IF V_CNT=0 THEN   
       insert into SYS_TREE_LIST(NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)
       values ('node_g_520','tree_g','g_520','g_500',null,'app_sanfu_retail','icon-guizeguanli',1,null,10,0,null,'接口配置',null,1,1);
   ELSE 
       update SYS_TREE_LIST set (NODE_ID,TREE_ID,ITEM_ID,PARENT_ID,VAR_ID,APP_ID,ICON_NAME,IS_END,STAND_PRIV_FLAG,SEQ_NO,PAUSE,TERMINAL_FLAG,CAPTION_EXPLAIN,COMPETENCE_FLAG,NODE_TYPE,IS_AUTHORIZE)=(select 'node_g_520','tree_g','g_520','g_500',null,'app_sanfu_retail','icon-guizeguanli',1,null,10,0,null,'接口配置',null,1,1 from dual) where node_id='node_g_520' ;
   END IF;
 END ;
 END ;
/

 BEGIN 
 DECLARE 
   V_CNT  NUMBER(1); 

 BEGIN 
   SELECT COUNT(*) INTO V_CNT FROM SYS_COND_RELA where cond_id = 'cond_node_g_520' and ctl_id = 'node_g_520' and obj_type = 0 and ctl_type = 0 ;
   IF V_CNT=0 THEN   
       insert into SYS_COND_RELA(COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)
       values ('cond_node_g_520',0,'node_g_520',0,null,0,null);
   ELSE 
       update SYS_COND_RELA set (COND_ID,OBJ_TYPE,CTL_ID,CTL_TYPE,SEQ_NO,PAUSE,ITEM_ID)=(select 'cond_node_g_520',0,'node_g_520',0,null,0,null from dual) where cond_id = 'cond_node_g_520' and ctl_id = 'node_g_520' and obj_type = 0 and ctl_type = 0 ;
   END IF;
 END ;
 END ;
/


insert into bwptest1.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_g_520_4', 'select 0 flag from dual where 1=1', 1, null, 'oracle_nsfdata', null, null);

insert into bwptest1.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_g_520_3', 'select 0 flag from dual where 1=1', 1, null, 'oracle_nsfdata', null, null);

insert into bwptest1.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_g_520_2', 'select 0 flag from dual where 1=1', 1, null, 'oracle_nsfdata', null, null);

insert into bwptest1.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_g_520_1', 'select 0 flag from dual where 1=1', 1, null, 'oracle_nsfdata', null, null);

insert into bwptest1.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_g_520_3', 91, 'action_g_520_3', 2, 3, 0, null);

insert into bwptest1.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_g_520_2', 91, 'action_g_520_2', 2, 2, 0, null);

insert into bwptest1.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_g_520_1', 91, 'action_g_520_1', 2, 1, 0, null);

insert into bwptest1.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_g_520_4', 91, 'action_g_520_4', 2, 4, 0, null);

insert into bwptest1.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_g_520_3', '是否前往页面？', null, null);

insert into bwptest1.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_g_520_2', '是否前往页面？', 'a_product_port_2', null);

insert into bwptest1.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_g_520_1', '是否前往页面？', 'a_good_112', null);

insert into bwptest1.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_g_520_4', '是否前往页面？', 'a_good_118_2', null);
