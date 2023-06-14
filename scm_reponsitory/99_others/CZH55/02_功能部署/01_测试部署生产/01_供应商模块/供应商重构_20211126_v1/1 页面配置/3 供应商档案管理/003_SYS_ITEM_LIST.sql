BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_check_factory_base();
  @strresult := v_sql;
END;}

--原有逻辑
/*WITH DIC AS
 (SELECT GROUP_DICT_VALUE, GROUP_DICT_NAME, GROUP_DICT_TYPE
    FROM SCMDATA.SYS_GROUP_DICT),
COMP AS
 (SELECT COMPANY_ID, LOGN_NAME, COMPANY_NAME FROM SCMDATA.SYS_COMPANY)
SELECT (SELECT DEPT_NAME
          FROM SCMDATA.SYS_COMPANY_DEPT
         WHERE COMPANY_DEPT_ID = TFA.ASK_USER_DEPT_ID) CHECK_DEPT_NAME, --验厂申请部门
       TFA.ASK_DATE FACTORY_ASK_DATE, --验厂申请日期
       (SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE COMPANY_ID = TFA.COMPANY_ID
           AND USER_ID = TFA.ASK_USER_ID) CHECKAPPLY_PERSON, --验厂申请人
       (SELECT PHONE FROM SCMDATA.SYS_USER WHERE USER_ID = TFA.ASK_USER_ID) CHECKAPPLY_PHONE, --验厂申请人电话
       TFA.COMPANY_NAME ASK_COMPANY_NAME,
       (SELECT PROVINCE
          FROM SCMDATA.DIC_PROVINCE
         WHERE PROVINCEID = TFA.COMPANY_PROVINCE) ||
       (SELECT CITY FROM SCMDATA.DIC_CITY WHERE CITYNO = TFA.COMPANY_CITY) ||
       (SELECT COUNTY
          FROM SCMDATA.DIC_COUNTY
         WHERE COUNTYID = TFA.COMPANY_COUNTY) PCC, --公司所在区域
       (SELECT PROVINCE
          FROM SCMDATA.DIC_PROVINCE
         WHERE PROVINCEID = TFA.FACTORY_PROVINCE) ||
       (SELECT CITY FROM SCMDATA.DIC_CITY WHERE CITYNO = TFA.FACTORY_CITY) ||
       (SELECT COUNTY
          FROM SCMDATA.DIC_COUNTY
         WHERE COUNTYID = TFA.FACTORY_COUNTY) FPCC, --工厂所在区域
       TFA.COMPANY_ADDRESS, --公司地址
       TFA.ASK_ADDRESS, --工厂地址
       TFA.FACTORY_NAME, --工厂名称
       TFA.CONTACT_NAME, --工厂联系人
       TFA.CONTACT_PHONE, --工厂联系人电话
       TFA.ASK_FILES, --验厂申请附件
       'PRODUCT_TYPE' COOPERATION_TYPE,
       (SELECT GROUP_DICT_NAME
          FROM SCMDATA.SYS_GROUP_DICT
         WHERE GROUP_DICT_VALUE='PRODUCT_TYPE') COOPERATION_TYPE_DESC,
       TFA.COOPERATION_MODEL, --意向合作模式
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TFA.COOPERATION_MODEL
           AND GROUP_DICT_TYPE = 'SUPPLY_TYPE') COOPERATION_MODEL_DESC, --意向合作模式名称
       TFA.ASK_SAY CHECKAPPLY_INTRO, --验厂申请说明
       TFA.ASK_USER_DEPT_ID,
       TFA.FACTORY_ASK_ID,
       TFA.SOCIAL_CREDIT_CODE,
       TFA.RELA_SUPPLIER_ID,
       TFA.COMPANY_PROVINCE,
       TFA.COMPANY_CITY,
       TFA.COMPANY_COUNTY,
       TFA.FACTORY_PROVINCE,
       TFA.FACTORY_CITY,
       TFA.FACTORY_COUNTY,
       TFA.COOPERATION_COMPANY_ID,
       TFA.FACTRORY_ASK_FLOW_STATUS
  FROM (SELECT *
          FROM SCMDATA.T_FACTORY_ASK
         WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID) TFA*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',,q''[]'',q''[]'',q''[]'',q''[]'',q''[FACTORY_REPORT_ID,FACTORY_ASK_ID,COOPERATION_METHOD,COOPERATION_MODEL,PRODUCTION_MODE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,CHECK_METHOD,COOPERATION_TYPE,rela_supplier_id,company_type,cooperation_brand,product_link,product_type,is_urgent,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,CHECK_FAC_RESULT,check_person1,check_person2]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_check_102_1'',q''[]'',q''[]'',,q''[]'',,q''[]'',q''[]'',q''[]'',q''[]'',q''[FACTORY_REPORT_ID,FACTORY_ASK_ID,COOPERATION_METHOD,COOPERATION_MODEL,PRODUCTION_MODE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,CHECK_METHOD,COOPERATION_TYPE,rela_supplier_id,company_type,cooperation_brand,product_link,product_type,is_urgent,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,CHECK_FAC_RESULT,check_person1,check_person2]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_checked_factory(p_type => 0);
  @strresult := v_sql;
END;}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_check_103''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[FACTORY_REPORT_ID,FACTORY_ASK_ID,CHECK_METHOD,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COMPANY_ID,FACTRORY_ASK_FLOW_STATUS,COOPERATION_MODEL,factory_report_id,CHECK_FAC_RESULT]'',,0,q''[]'',q''[]'',q''[]'',,q''[ASK_COMPANY_NAME]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_check_103''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_check_103'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[FACTORY_REPORT_ID,FACTORY_ASK_ID,CHECK_METHOD,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COMPANY_ID,FACTRORY_ASK_FLOW_STATUS,COOPERATION_MODEL,factory_report_id,CHECK_FAC_RESULT]'',,0,q''[]'',q''[]'',q''[]'',,q''[ASK_COMPANY_NAME]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[select a.log_id,
       cua.company_user_name oper_user_name,
       goper.group_dict_name oper_code_desc,
       substr(gs.group_dict_name,0,instr(gs.group_dict_name,'+')-1) FLOW_NODE_NAME_AF,
       substr(gs.group_dict_name,instr(gs.group_dict_name,'+')+1,length(gs.group_dict_name)) FLOW_NODE_STATUS_DESC_AF,
       a.oper_time,
       a.remarks,
       a.ask_record_id,
       a.factory_ask_id
  from t_factory_ask_oper_log a
  inner join sys_group_dict goper
    on goper.group_dict_value = upper(a.oper_code)
   and goper.group_dict_type = 'DICT_FLOW_STATUS'
  inner join sys_group_dict gs
    on gs.group_dict_value = a.status_af_oper
   and gs.group_dict_type = 'FACTORY_ASK_FLOW'
   inner join sys_company_user cua on a.oper_user_id=cua.user_id and a.oper_user_company_id=cua.company_id
 where a.factory_ask_id = :factory_ask_id
    or (a.ask_record_id is not null and
       a.ask_record_id =
       (select ask_record_id
           from t_factory_ask
          where factory_ask_id = :factory_ask_id) and a.factory_ask_id is null)
 order by a.oper_time desc]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ask_record_id,log_id,factory_ask_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_106'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ask_record_id,log_id,factory_ask_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_supp_list();
  @strresult := v_sql;
END;}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,COOR_ASK_FLOW_STATUS,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_MODEL,PRODUCTION_MODE,BE_COMPANY_ID,ASK_USER_ID,COMPANY_ID,FACTORY_ASK_ID,COOPERATION_PRODUCT_CATE]'',,0,q''[]'',q''[]'',q''[]'',,q''[ASK_COMPANY_NAME]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,COOR_ASK_FLOW_STATUS,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_MODEL,PRODUCTION_MODE,BE_COMPANY_ID,ASK_USER_ID,COMPANY_ID,FACTORY_ASK_ID,COOPERATION_PRODUCT_CATE]'',,0,q''[]'',q''[]'',q''[]'',,q''[ASK_COMPANY_NAME]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[select a.company_id,a.logo,a.company_name,a.logn_name,a.tips,
       a.is_open,a.attributor_id,nvl(c.COMPANY_USER_NAME,b.username) attributor,a.create_time,dp.province || dci.city || dc.county area,a.address,
       a.product,a.rival,a.licence_type,a.licence_num
  from (select * from scmdata.sys_company WHERE LOGN_NAME=%ASS_ASK_COMPANY_NAME%) a
 left join sys_user b on a.attributor_id=b.user_id
 left join sys_company_user c on b.user_id=c.user_id and a.company_id=c.company_id
   left join scmdata.dic_province dp
    on dp.provinceid = a.company_province
  left join scmdata.dic_county dc
    on a.company_county = dc.countyid
  left join scmdata.dic_city dci
    on dci.cityno = a.company_city]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150_0'',q''[]'',q''[]'',,q''[]'',0,q''[]'',q''[]'',q''[]'',q''[]'',q''[COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[SELECT SCMDATA.F_GETKEYID_PLAT('CA', 'seq_ca') FACTORY_ASK_ID FROM DUAL]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_factory_ask(p_type => 0);
  @strresult := v_sql;
END;}
--原代码
/*WITH DIC AS
 (SELECT GROUP_DICT_VALUE, GROUP_DICT_NAME, GROUP_DICT_TYPE
    FROM SCMDATA.SYS_GROUP_DICT),
COMP AS
 (SELECT COMPANY_ID, LOGN_NAME, COMPANY_NAME FROM SCMDATA.SYS_COMPANY)
SELECT (SELECT DEPT_NAME
          FROM SCMDATA.SYS_COMPANY_DEPT
         WHERE COMPANY_DEPT_ID =(SELECT COMPANY_DEPT_ID
                            FROM SYS_COMPANY_USER_DEPT
                           WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
                             AND USER_ID = %CURRENT_USERID%)) CHECK_DEPT_NAME,
       TFA.ASK_DATE FACTORY_ASK_DATE,
       (SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
           AND USER_ID = %CURRENT_USERID%) CHECKAPPLY_PERSON,
       (SELECT PHONE FROM SCMDATA.SYS_USER WHERE USER_ID = %CURRENT_USERID%) CHECKAPPLY_PHONE,
       TFA.COMPANY_NAME ASK_COMPANY_NAME,
       (SELECT PROVINCE
          FROM SCMDATA.DIC_PROVINCE
         WHERE PROVINCEID = TFA.COMPANY_PROVINCE) ||
       (SELECT CITY FROM SCMDATA.DIC_CITY WHERE CITYNO = TFA.COMPANY_CITY) ||
       (SELECT COUNTY
          FROM SCMDATA.DIC_COUNTY
         WHERE COUNTYID = TFA.COMPANY_COUNTY) PCC,
       (SELECT PROVINCE
          FROM SCMDATA.DIC_PROVINCE
         WHERE PROVINCEID = TFA.FACTORY_PROVINCE) ||
       (SELECT CITY FROM SCMDATA.DIC_CITY WHERE CITYNO = TFA.FACTORY_CITY) ||
       (SELECT COUNTY
          FROM SCMDATA.DIC_COUNTY
         WHERE COUNTYID = TFA.FACTORY_COUNTY) FPCC,
       TFA.COMPANY_ADDRESS,
       TFA.ASK_ADDRESS,
       TFA.FACTORY_NAME,
       TFA.CONTACT_NAME,
       TFA.CONTACT_PHONE,
       TFA.ASK_FILES,
       'PRODUCT_TYPE' COOPERATION_TYPE,
       (SELECT GROUP_DICT_NAME
          FROM SCMDATA.SYS_GROUP_DICT
         WHERE GROUP_DICT_VALUE = 'PRODUCT_TYPE') COOPERATION_TYPE_DESC,
       TFA.COOPERATION_MODEL,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TFA.COOPERATION_MODEL
           AND GROUP_DICT_TYPE = 'SUPPLY_TYPE') COOPERATION_MODEL_DESC,
       TFA.SOCIAL_CREDIT_CODE,
       TFA.RELA_SUPPLIER_ID,
       TFA.ASK_SAY CHECKAPPLY_INTRO,
       TFA.ASK_USER_DEPT_ID,
       TFA.FACTORY_ASK_ID,
       TFA.COMPANY_PROVINCE,
       TFA.COMPANY_CITY,
       TFA.COMPANY_COUNTY,
       TFA.FACTORY_PROVINCE,
       TFA.FACTORY_CITY,
       TFA.FACTORY_COUNTY,
       TFA.COOPERATION_COMPANY_ID,
       TAR.ORIGIN
  FROM (SELECT *
          FROM SCMDATA.T_FACTORY_ASK
         WHERE ASK_RECORD_ID = :ASK_RECORD_ID) TFA
  LEFT JOIN SCMDATA.T_ASK_RECORD TAR
         ON TFA.ASK_RECORD_ID = TAR.ASK_RECORD_ID
 ORDER BY TFA.CREATE_DATE DESC*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[--czh 20211016重构代码
DECLARE
  p_fa_rec scmdata.t_factory_ask%ROWTYPE;
BEGIN
  --验厂申请
  --申请信息
  p_fa_rec.ask_date          := :factory_ask_date;
  p_fa_rec.is_urgent         := :is_urgent;
  p_fa_rec.cooperation_model := :cooperation_model;
  p_fa_rec.product_type      := :product_type;
  p_fa_rec.ask_say           := :checkapply_intro;
  --供应商基本信息
  p_fa_rec.factory_ask_id       := :factory_ask_id;
  p_fa_rec.company_name         := :ask_company_name;
  p_fa_rec.company_abbreviation := :company_abbreviation;
  --p_fa_rec.social_credit_code    := :social_credit_code;
  p_fa_rec.company_province := :company_province;
  p_fa_rec.company_city     := :company_city;
  p_fa_rec.company_county   := :company_county;
  p_fa_rec.company_address  := nvl(:company_address, :pcc);
  p_fa_rec.factory_name     := :factory_name;
  p_fa_rec.factory_province := :company_province;
  p_fa_rec.factory_city     := :company_city;
  p_fa_rec.factory_county   := :company_county;
  p_fa_rec.ask_address      := nvl(:ask_address, :fpcc);
  p_fa_rec.legal_representative  := :legal_representative;
  p_fa_rec.company_contact_phone := :company_contact_phone;
  p_fa_rec.contact_name          := :ask_user_name;
  p_fa_rec.contact_phone         := :ask_user_phone;
  p_fa_rec.company_type          := :company_type;
  p_fa_rec.brand_type            := :brand_type;
  p_fa_rec.cooperation_brand     := :cooperation_brand;
  p_fa_rec.com_manufacturer      := :com_manufacturer;
  p_fa_rec.certificate_file      := :certificate_file;
  p_fa_rec.supplier_gate         := :supplier_gate;
  p_fa_rec.supplier_office       := :supplier_office;
  p_fa_rec.supplier_site         := :supplier_site;
  p_fa_rec.supplier_product      := :supplier_product;
  p_fa_rec.ask_user_id           := %current_userid%;
  p_fa_rec.update_id             := %current_userid%;
  p_fa_rec.update_date           := SYSDATE;
  p_fa_rec.rela_supplier_id      := :rela_supplier_id;
  p_fa_rec.product_link          := :product_link;
  p_fa_rec.memo               := :remarks;
  --生产信息
  p_fa_rec.worker_num          := :worker_num;
  p_fa_rec.machine_num         := :machine_num;
  p_fa_rec.reserve_capacity    := rtrim(:reserve_capacity,'%');
  p_fa_rec.product_efficiency  := rtrim(:product_efficiency,'%');
  p_fa_rec.work_hours_day      := :work_hours_day;

  scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);

END;


/*--czh 重构代码
DECLARE
  p_fa_rec scmdata.t_factory_ask%ROWTYPE;
  p_fo_rec scmdata.t_factory_ask_out%ROWTYPE;
BEGIN
  --验厂申请
  --申请信息
  p_fa_rec.ask_date          := :factory_ask_date;
  p_fa_rec.is_urgent         := :is_urgent;
  p_fa_rec.cooperation_model := :cooperation_model;
  p_fa_rec.product_type      := :product_type;
  p_fa_rec.ask_say           := :checkapply_intro;

  --供应商基本信息
  p_fa_rec.factory_ask_id       := :factory_ask_id;
  p_fa_rec.company_name         := :ask_company_name;
  p_fa_rec.company_abbreviation := :company_abbreviation;
  --p_fa_rec.social_credit_code    := :social_credit_code;
  p_fa_rec.company_province      := :company_province;
  p_fa_rec.company_city          := :company_city;
  p_fa_rec.company_county        := :company_county;
  p_fa_rec.company_address       := :pcc;
  p_fa_rec.ask_address           := :company_address;
  p_fa_rec.legal_representative  := :legal_representative;
  p_fa_rec.company_contact_phone := :company_contact_phone;
  p_fa_rec.contact_name          := :contact_name;
  p_fa_rec.contact_phone         := :contact_phone;
  p_fa_rec.company_type          := :company_type;
  p_fa_rec.brand_type            := :brand_type;
  p_fa_rec.cooperation_brand     := :cooperation_brand;
  p_fa_rec.com_manufacturer      := :com_manufacturer;
  p_fa_rec.certificate_file      := :certificate_file;
  p_fa_rec.supplier_gate         := :supplier_gate;
  p_fa_rec.supplier_office       := :supplier_office;
  p_fa_rec.supplier_site         := :supplier_site;
  p_fa_rec.supplier_product      := :supplier_product;
  p_fa_rec.ask_user_id           := %current_userid%;
  p_fa_rec.update_id             := %current_userid%;
  p_fa_rec.update_date           := SYSDATE;
  p_fa_rec.rela_supplier_id      := :rela_supplier_id;
  p_fa_rec.product_link          := :product_link;

  /*
  p_fa_rec.ask_files             := :ask_files;
  p_fa_rec.cooperation_method    := :cooperation_method;
  p_fa_rec.company_mold          := :company_mold;
  p_fa_rec.origin                   := :origin;
  p_fa_rec.create_id                := :create_id;
  p_fa_rec.create_date              := :create_date;
  p_fa_rec.remarks                  := :remarks;
  p_fa_rec.ask_company_id           := :ask_company_id;
  p_fa_rec.ask_record_id            := :ask_record_id;
  p_fa_rec.factrory_ask_flow_status := :factrory_ask_flow_status;
  p_fa_rec.factory_ask_type         := :factory_ask_type;
  p_fa_rec.cooperation_type         := :cooperation_type;
  p_fa_rec.cooperation_company_id   := :cooperation_company_id;
  p_fa_rec.ask_user_dept_id         := :ask_user_dept_id;*/

  --工厂信息
  /* IF :factory_ask_out_id IS NULL THEN
    p_fo_rec.factory_ask_out_id := scmdata.f_get_uuid();
  ELSE
    p_fo_rec.factory_ask_out_id := :factory_ask_out_id;
  END IF;
  p_fo_rec.factory_ask_id         := :factory_ask_id; --外键
  p_fo_rec.company_id             := :company_id;
  p_fo_rec.factory_name := CASE
                             WHEN :com_manufacturer = '00' THEN
                              :ask_company_name
                             ELSE
                              :factory_name
                           END;
  p_fo_rec.factory_abbreviation := CASE
                                     WHEN :com_manufacturer = '00' THEN
                                      :company_abbreviation
                                     ELSE
                                      nvl(:factory_abbreviation, '')
                                   END;
  p_fo_rec.fa_social_credit_code := CASE
                                      WHEN :com_manufacturer = '00' THEN
                                       :social_credit_code
                                      ELSE
                                       nvl(:fa_social_credit_code, '')
                                    END;
  p_fo_rec.factory_province := CASE
                                 WHEN :com_manufacturer = '00' THEN
                                  :company_province
                                 ELSE
                                  nvl(:factory_province, '')
                               END;
  p_fo_rec.factory_city := CASE
                             WHEN :com_manufacturer = '00' THEN
                              :company_city
                             ELSE
                              nvl(:factory_city, '')
                           END;
  p_fo_rec.factory_county := CASE
                               WHEN :com_manufacturer = '00' THEN
                                :company_county
                               ELSE
                                nvl(:factory_county, '')
                             END;
  p_fo_rec.factory_detail_adress := CASE
                                      WHEN :com_manufacturer = '00' THEN
                                       :company_address
                                      ELSE
                                       nvl(:factory_detail_adress, '')
                                    END;
  p_fo_rec.factory_representative := CASE
                                       WHEN :com_manufacturer = '00' THEN
                                        :legal_representative
                                       ELSE
                                        nvl(:factory_representative, '')
                                     END;
  p_fo_rec.factory_contact_phone := CASE
                                      WHEN :com_manufacturer = '00' THEN
                                       :company_contact_phone
                                      ELSE
                                       nvl(:fa_com_contact_phone, '')
                                    END;
  p_fo_rec.fa_contact_name := CASE
                                WHEN :com_manufacturer = '00' THEN
                                 :contact_name
                                ELSE
                                 nvl(:fa_contact_name, '')
                              END;
  p_fo_rec.fa_contact_phone := CASE
                                 WHEN :com_manufacturer = '00' THEN
                                  :contact_phone
                                 ELSE
                                  nvl(:fa_contact_phone, '')
                               END;
  --p_fo_rec.factory_contact_phone  := :fa_com_contact_phone;
  p_fo_rec.factory_type := CASE
                             WHEN :com_manufacturer = '00' THEN
                              :company_type
                             ELSE
                              nvl(:factory_type, '')
                           END;

  p_fo_rec.factory_coop_model := :factory_coop_model;

  p_fo_rec.fa_brand_type := CASE
                              WHEN :com_manufacturer = '00' THEN
                               :brand_type
                              ELSE
                               nvl(:fa_brand_type, '')
                            END;
  p_fo_rec.factory_coop_brand := CASE
                                   WHEN :com_manufacturer = '00' THEN
                                    :cooperation_brand
                                   ELSE
                                    nvl(:factory_coop_brand, '')
                                 END;
  IF :com_manufacturer = '00' THEN
    IF :product_link IS NULL THEN
      raise_application_error(-20002,
                              '生产工厂=“本厂”时，工厂基本信息栏中生产环节为必填！');
    ELSE
      p_fo_rec.product_link := :product_link;
    END IF;
  ELSE
    p_fo_rec.product_link := :product_link;
  END IF;

  p_fo_rec.fa_rela_supplier_id := :fa_rela_supplier_id; --关联供应商
  p_fo_rec.fa_certificate_file := CASE
                                    WHEN :com_manufacturer = '00' THEN
                                     :certificate_file
                                    ELSE
                                     nvl(:fa_certificate_file, '')
                                  END;

  p_fo_rec.factory_gate := CASE
                             WHEN :com_manufacturer = '00' THEN
                              :supplier_gate
                             ELSE
                              nvl(:factory_gate, '')
                           END;
  p_fo_rec.factory_office := CASE
                               WHEN :com_manufacturer = '00' THEN
                                :supplier_office
                               ELSE
                                nvl(:factory_office, '')
                             END;
  p_fo_rec.factory_site := CASE
                             WHEN :com_manufacturer = '00' THEN
                              :supplier_site
                             ELSE
                              nvl(:factory_site, '')
                           END;

  p_fo_rec.factory_product := CASE
                                WHEN :com_manufacturer = '00' THEN
                                 :supplier_product
                                ELSE
                                 nvl(:factory_product, '')
                              END;
  p_fo_rec.remarks         := :remarks;
  p_fo_rec.create_id       := :user_id;
  p_fo_rec.create_time     := SYSDATE;
  p_fo_rec.update_id       := :user_id;
  p_fo_rec.update_time     := SYSDATE;*/

  scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);

END;
*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_METHOD,COOPERATION_MODEL,PRODUCTION_MODE,ASK_USER_DEPT_ID,COOPERATION_COMPANY_ID,COMPANY_PROVINCE,COMPANY_CITY,COMPANY_COUNTY,FACTORY_PROVINCE,FACTORY_CITY,FACTORY_COUNTY,is_urgent,product_type,company_type,cooperation_brand,com_manufacturer,factory_type,factory_coop_brand,product_link,factory_coop_model,factory_ask_out_id,rela_supplier_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150_3'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_METHOD,COOPERATION_MODEL,PRODUCTION_MODE,ASK_USER_DEPT_ID,COOPERATION_COMPANY_ID,COMPANY_PROVINCE,COMPANY_CITY,COMPANY_COUNTY,FACTORY_PROVINCE,FACTORY_CITY,FACTORY_COUNTY,is_urgent,product_type,company_type,cooperation_brand,com_manufacturer,factory_type,factory_coop_brand,product_link,factory_coop_model,factory_ask_out_id,rela_supplier_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
  v_origin varchar2(32);
BEGIN
  select max(t.origin) into v_origin from scmdata.t_ask_record t where t.be_company_id = %default_company_id% and t.ask_record_id = :ask_record_id;
  v_sql      := pkg_ask_record_mange.f_query_coop_fp_supplier(p_type => 1,p_origin => v_origin);
  @strresult := v_sql;
END;}
--原代码
/*WITH DIC AS
 (SELECT GROUP_DICT_TYPE, GROUP_DICT_VALUE, GROUP_DICT_NAME
    FROM SCMDATA.SYS_GROUP_DICT)
SELECT COMPANY_NAME ASK_COMPANY_NAME, --公司名称
       SAPPLY_USER, --申请人
       SAPPLY_PHONE, --申请人手机
       SOCIAL_CREDIT_CODE,
       ((SELECT PROVINCE
           FROM SCMDATA.DIC_PROVINCE
          WHERE PROVINCEID = COMPANY_PROVINCE) ||
       (SELECT CITY FROM SCMDATA.DIC_CITY WHERE CITYNO = COMPANY_CITY) ||
       (SELECT COUNTY
           FROM SCMDATA.DIC_COUNTY
          WHERE COUNTYID = COMPANY_COUNTY)) PCC, --所在区域
       COMPANY_ADDRESS, --详细地址
       CERTIFICATE_FILE, --营业执照
       OTHER_FILE, --其他附件
       COOPERATION_TYPE, --意向合作类型
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_TYPE='COOPERATION_TYPE'
           AND GROUP_DICT_VALUE=COOPERATION_TYPE) COOPERATION_TYPE_DESC,--意向合作类型显示
       COOPERATION_MODEL, --意向合作模式
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = COOPERATION_MODEL
           AND GROUP_DICT_TYPE = 'SUPPLY_TYPE'
           AND GROUP_DICT_VALUE != 'SUPPLY_TYPE') COOPERATION_MODEL_DESC, --意向合作模式显示
       ASK_SAY, --合作申请说明
       ASK_RECORD_ID
  FROM SCMDATA.T_ASK_RECORD
 WHERE ASK_RECORD_ID = :ASK_RECORD_ID*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[--czh 重构逻辑
DECLARE
  p_ar_rec           scmdata.t_ask_record%ROWTYPE;
  v_company_province VARCHAR2(48);
  v_company_city     VARCHAR2(48);
  v_company_county   VARCHAR2(48);
BEGIN
  SELECT company_province, company_city, company_county
    INTO v_company_province, v_company_city, v_company_county
    FROM scmdata.t_ask_record
   WHERE ask_record_id = :ask_record_id;

  p_ar_rec.ask_record_id         := :ask_record_id;
  p_ar_rec.social_credit_code    := :social_credit_code;
  p_ar_rec.company_province      := nvl(:company_province,
                                        v_company_province);
  p_ar_rec.company_city          := nvl(:company_city, v_company_city);
  p_ar_rec.company_county        := nvl(:company_county, v_company_county);
  p_ar_rec.company_address       := :area || :company_address;
  p_ar_rec.certificate_file      := :certificate_file;
  p_ar_rec.other_file            := :other_file;
  p_ar_rec.cooperation_model     := :cooperation_model;
  p_ar_rec.ask_say               := :ask_say;
  p_ar_rec.sapply_user           := :sapply_user;
  p_ar_rec.sapply_phone          := :sapply_phone;
  p_ar_rec.update_id             := %current_userid%;
  p_ar_rec.update_date           := SYSDATE;
  p_ar_rec.company_name          := :ask_company_name;
  p_ar_rec.cooperation_type      := :cooperation_type;
  p_ar_rec.company_abbreviation  := :company_abbreviation;
  p_ar_rec.legal_representative  := :legal_representative;
  p_ar_rec.company_contact_phone := :company_contact_phone;
  p_ar_rec.company_type          := :company_type;
  p_ar_rec.brand_type            := :brand_type;
  p_ar_rec.cooperation_brand     := :cooperation_brand;
  p_ar_rec.product_link          := :product_link;
  p_ar_rec.supplier_gate         := :supplier_gate;
  p_ar_rec.supplier_office       := :supplier_office;
  p_ar_rec.supplier_site         := :supplier_site;
  p_ar_rec.supplier_product      := :supplier_product;
  p_ar_rec.sapply_user          := :ask_user_name;
  p_ar_rec.sapply_phone         := :ask_user_phone;
  p_ar_rec.remarks               := :remarks;
  scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,
                                                    p_type   => 1);

  scmdata.pkg_ask_record_mange.p_update_t_ask_record(p_ar_rec => p_ar_rec);

END;

--原有逻辑
/*UPDATE SCMDATA.T_ASK_RECORD
   SET   COMPANY_PROVINCE    = NVL(:COMPANY_PROVINCE, (SELECT COMPANY_PROVINCE FROM SCMDATA.T_ASK_RECORD WHERE ASK_RECORD_ID=:ASK_RECORD_ID))
       , COMPANY_CITY        = NVL(:COMPANY_CITY, (SELECT COMPANY_CITY FROM SCMDATA.T_ASK_RECORD WHERE ASK_RECORD_ID=:ASK_RECORD_ID))
       , COMPANY_COUNTY      = NVL(:COMPANY_COUNTY, (SELECT COMPANY_COUNTY FROM SCMDATA.T_ASK_RECORD WHERE ASK_RECORD_ID=:ASK_RECORD_ID))
       , COMPANY_ADDRESS     = :AREA || :COMPANY_ADDRESS
       , CERTIFICATE_FILE    = :CERTIFICATE_FILE
       , OTHER_FILE          = :OTHER_FILE
       , COOPERATION_MODEL   = :COOPERATION_MODEL
       , ASK_SAY             = :ASK_SAY
       , SAPPLY_USER         = :SAPPLY_USER
       , SAPPLY_PHONE        = :SAPPLY_PHONE
       , UPDATE_ID           = %CURRENT_USERID%
       , UPDATE_DATE         = SYSDATE
       , COMPANY_NAME        = :ASK_COMPANY_NAME
       , COOPERATION_TYPE    = :COOPERATION_TYPE
 WHERE ASK_RECORD_ID = :ASK_RECORD_ID*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_150_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,PRODUCTION_MODE,COOPERATION_MODEL,COOPERATION_METHOD,COOPERATION_SUBCATEGORY,COOPERATION_CLASSIFICATION,COOPERATION_TYPE,coor_ask_flow_status]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_150_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_150_6'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,PRODUCTION_MODE,COOPERATION_MODEL,COOPERATION_METHOD,COOPERATION_SUBCATEGORY,COOPERATION_CLASSIFICATION,COOPERATION_TYPE,coor_ask_flow_status]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[--czh add
call scmdata.pkg_ask_record_mange.p_delete_t_ask_record(p_ask_record_id => :ask_record_id)

--原有逻辑
/*
DECLARE
  JUDGE NUMBER(1);
BEGIN
	SELECT COUNT(1) INTO JUDGE
	  FROM SCMDATA.T_FACTORY_ASK
	 WHERE ASK_RECORD_ID=:ASK_RECORD_ID;

	IF JUDGE = 0 THEN
		DELETE FROM SCMDATA.T_ASK_RECORD WHERE ASK_RECORD_ID=:ASK_RECORD_ID;
	ELSE
		RAISE_APPLICATION_ERROR(-20002,'已有单据在流程中不能删除！');
  END IF;
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[--czh 重构逻辑
DECLARE
  p_ar_rec scmdata.t_ask_record%ROWTYPE;
  v_company_id VARCHAR2(32);
BEGIN
  SELECT MAX(company_id) INTO v_company_id
    FROM scmdata.sys_company
   WHERE licence_num = :social_credit_code;

  p_ar_rec.ask_record_id        := :ask_record_id;
  p_ar_rec.company_id           := nvl(v_company_id,'');
  p_ar_rec.company_name         := :ask_company_name;
  p_ar_rec.be_company_id        := %default_company_id%;
  p_ar_rec.company_province     := :company_province;
  p_ar_rec.company_city         := :company_city;
  p_ar_rec.company_county       := :company_county;
  p_ar_rec.company_address      := :company_address;
  p_ar_rec.ask_say              := :ask_say;
  p_ar_rec.ask_date             := :ask_date;
  p_ar_rec.ask_user_id          := :user_id;
  p_ar_rec.certificate_file     := :certificate_file;
  p_ar_rec.other_file           := :other_file;
  p_ar_rec.sapply_user          := :ask_user_name;
  p_ar_rec.sapply_phone         := :ask_user_phone;
  p_ar_rec.create_id            := %current_userid%;
  p_ar_rec.create_date          := SYSDATE;
  p_ar_rec.update_id            := %current_userid%;
  p_ar_rec.update_date          := SYSDATE;
  p_ar_rec.coor_ask_flow_status := 'CA00';
  p_ar_rec.social_credit_code   := :social_credit_code;
  p_ar_rec.cooperation_model    := :cooperation_model;
  p_ar_rec.cooperation_type     := :cooperation_type;
  p_ar_rec.origin               := 'MA';
  --p_ar_rec.cooperation_classification := :cooperation_classification;
  --p_ar_rec.cooperation_subcategory    := :cooperation_subcategory;
  p_ar_rec.company_abbreviation  := :company_abbreviation;
  p_ar_rec.legal_representative  := :legal_representative;
  p_ar_rec.company_contact_phone := :company_contact_phone;
  p_ar_rec.company_type          := :company_type;
  p_ar_rec.brand_type            := :brand_type;
  p_ar_rec.cooperation_brand     := :cooperation_brand;
  p_ar_rec.product_link          := :product_link;
  p_ar_rec.supplier_gate         := :supplier_gate;
  p_ar_rec.supplier_office       := :supplier_office;
  p_ar_rec.supplier_site         := :supplier_site;
  p_ar_rec.supplier_product      := :supplier_product;
  p_ar_rec.remarks               := :remarks;
  /*
  p_ar_rec.ask_user_id := :user_id;
    p_ar_rec.production_mode       := :production_mode;
    p_ar_rec.remarks               := :remarks;
    p_ar_rec.collection            := :collection;
    p_ar_rec.origin                := :origin;
    p_ar_rec.cooperation_statement := :cooperation_statement;
    */

  scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,
                                                    p_type   => 1);

  scmdata.pkg_ask_record_mange.p_insert_t_ask_record(p_ar_rec => p_ar_rec);

END;
--原有逻辑
/*
DECLARE
  JUDGE NUMBER(1);
BEGIN
  IF :COOPERATION_TYPE <> 'PRODUCT_TYPE' THEN
    RAISE_APPLICATION_ERROR(-20002,'除成品供应商外，其余合作类型未开放！');
  END IF;

  SELECT NVL(MAX(1), 0)
    INTO JUDGE
    FROM SCMDATA.T_ASK_RECORD
   WHERE BE_COMPANY_ID = %DEFAULT_COMPANY_ID%
     AND COMPANY_NAME = :ASK_COMPANY_NAME
     AND COOR_ASK_FLOW_STATUS <> 'CA00';
  IF JUDGE = 0 THEN
    SELECT COUNT(1)
       INTO JUDGE
      FROM (SELECT DISTINCT FIRST_VALUE(COMPANY_NAME) OVER(PARTITION BY ASK_RECORD_ID ORDER BY CREATE_DATE DESC) COMPANY_NAME
              FROM SCMDATA.T_FACTORY_ASK
             WHERE FACTRORY_ASK_FLOW_STATUS NOT IN ('CA01','FA01','FA12','FA21','FA22','FA31','FA32','FA33')
               AND COMPANY_ID = %DEFAULT_COMPANY_ID%
               AND ROWNUM < 2)
     WHERE COMPANY_NAME = :ASK_COMPANY_NAME;
    IF JUDGE = 0 THEN
      SELECT COUNT(1)
       INTO JUDGE
      FROM (SELECT DISTINCT FIRST_VALUE(COMPANY_NAME) OVER(PARTITION BY ASK_RECORD_ID ORDER BY CREATE_DATE DESC) COMPANY_NAME
              FROM SCMDATA.T_FACTORY_ASK
             WHERE FACTRORY_ASK_FLOW_STATUS IN ('FA12','FA21','FA22','FA31','FA32','FA33')
               AND COMPANY_ID = %DEFAULT_COMPANY_ID%
               AND ROWNUM < 2)
     WHERE COMPANY_NAME = :ASK_COMPANY_NAME;
      IF JUDGE > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, '公司名称与待建档、已建档的供应商名称重复！');
      END IF;
    ELSE
      RAISE_APPLICATION_ERROR(-20002, '公司名称与准入流程中的公司名称存在重复！');
    END IF;
  ELSE
    RAISE_APPLICATION_ERROR(-20002, '公司名称与意向合作供应商清单的公司名称重复！');
  END IF;

  INSERT INTO SCMDATA.T_ASK_RECORD
    (ASK_RECORD_ID,
     COMPANY_ID,
     COMPANY_NAME,
     BE_COMPANY_ID,
     COMPANY_PROVINCE,
     COMPANY_CITY,
     COMPANY_COUNTY,
     COMPANY_ADDRESS,
     ASK_DATE,
     ASK_SAY,
     CERTIFICATE_FILE,
     OTHER_FILE,
     SAPPLY_USER,
     SAPPLY_PHONE,
     CREATE_ID,
     CREATE_DATE,
     UPDATE_ID,
     UPDATE_DATE,
     COOR_ASK_FLOW_STATUS,
     SOCIAL_CREDIT_CODE,
     COOPERATION_MODEL,
     COOPERATION_TYPE,
     ORIGIN)
  VALUES
    (:ASK_RECORD_ID,
     NVL((SELECT COMPANY_ID
            FROM SCMDATA.SYS_COMPANY
           WHERE LICENCE_NUM = :SOCIAL_CREDIT_CODE),''),
     :ASK_COMPANY_NAME,
     %default_company_id%,
     :COMPANY_PROVINCE,
     :COMPANY_CITY,
     :COMPANY_COUNTY,
     :COMPANY_ADDRESS,
     SYSDATE,
     :ASK_SAY,
     :CERTIFICATE_FILE,
     :OTHER_FILE,
     :SAPPLY_USER,
     :SAPPLY_PHONE,
     %CURRENT_USERID%,
     SYSDATE,
     %CURRENT_USERID%,
     SYSDATE,
     'CA00',
     :SOCIAL_CREDIT_CODE,
     :COOPERATION_MODEL,
     :COOPERATION_TYPE,
     'MA');
END;*/]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[SELECT SCMDATA.F_GETKEYID_PLAT('HZ', 'SEQ_T_ASK_RECORD', 99) ASK_RECORD_ID FROM DUAL]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_fp_supplier(p_type => 2);
  @strresult := v_sql;
END;}

--原有逻辑
/*WITH DIC AS
 (SELECT GROUP_DICT_TYPE, GROUP_DICT_VALUE, GROUP_DICT_NAME
    FROM SCMDATA.SYS_GROUP_DICT)
SELECT Z.COMPANY_NAME ASK_COMPANY_NAME,
       Z.SAPPLY_USER,
       Z.SAPPLY_PHONE,
       Z.SOCIAL_CREDIT_CODE,
       ((SELECT PROVINCE
           FROM SCMDATA.DIC_PROVINCE
          WHERE PROVINCEID = Z.COMPANY_PROVINCE) ||
       (SELECT CITY FROM SCMDATA.DIC_CITY WHERE CITYNO = Z.COMPANY_CITY) ||
       (SELECT COUNTY
           FROM SCMDATA.DIC_COUNTY
          WHERE COUNTYID = Z.COMPANY_COUNTY)) PCC,
       Z.COMPANY_ADDRESS,
       Z.CERTIFICATE_FILE,
       Z.OTHER_FILE,
       Z.COOPERATION_TYPE,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_TYPE='COOPERATION_TYPE'
           AND GROUP_DICT_VALUE=Z.COOPERATION_TYPE) COOPERATION_TYPE_DESC,
       Z.COOPERATION_MODEL,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = Z.COOPERATION_MODEL
           AND GROUP_DICT_TYPE = 'SUPPLY_TYPE'
           AND GROUP_DICT_VALUE != 'SUPPLY_TYPE') COOPERATION_MODEL_DESC,
       Z.ASK_SAY,
       (SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE COMPANY_ID = Z.COMPANY_ID
           AND USER_ID = Z.CREATE_ID) CREATOR,
       Z.CREATE_DATE,
       Z.ASK_RECORD_ID
  FROM SCMDATA.T_ASK_RECORD Z
 WHERE COOR_ASK_FLOW_STATUS = 'CA00'
   AND BE_COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND CREATE_ID = %CURRENT_USERID%
ORDER BY CREATE_DATE DESC*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[--czh 重构逻辑
DECLARE
  p_ar_rec           scmdata.t_ask_record%ROWTYPE;
  v_company_province VARCHAR2(48);
  v_company_city     VARCHAR2(48);
  v_company_county   VARCHAR2(48);
BEGIN

  SELECT company_province, company_city, company_county
    INTO v_company_province, v_company_city, v_company_county
    FROM scmdata.t_ask_record
   WHERE ask_record_id = :ask_record_id;

  p_ar_rec.ask_record_id         := :ask_record_id;
  p_ar_rec.social_credit_code    := :social_credit_code;
  p_ar_rec.company_province      := nvl(:company_province,
                                        v_company_province);
  p_ar_rec.company_city          := nvl(:company_city, v_company_city);
  p_ar_rec.company_county        := nvl(:company_county, v_company_county);
  p_ar_rec.company_address       := :area || :company_address;
  p_ar_rec.certificate_file      := :certificate_file;
  p_ar_rec.other_file            := :other_file;
  p_ar_rec.cooperation_model     := :cooperation_model;
  p_ar_rec.ask_say               := :ask_say;
  p_ar_rec.sapply_user           := :sapply_user;
  p_ar_rec.sapply_phone          := :sapply_phone;
  p_ar_rec.update_id             := %current_userid%;
  p_ar_rec.update_date           := SYSDATE;
  p_ar_rec.company_name          := :ask_company_name;
  p_ar_rec.cooperation_type      := :cooperation_type;
  p_ar_rec.company_abbreviation  := :company_abbreviation;
  p_ar_rec.legal_representative  := :legal_representative;
  p_ar_rec.company_contact_phone := :company_contact_phone;
  p_ar_rec.company_type          := :company_type;
  p_ar_rec.brand_type            := :brand_type;
  p_ar_rec.cooperation_brand     := :cooperation_brand;
  p_ar_rec.product_link          := :product_link;
  p_ar_rec.supplier_gate         := :supplier_gate;
  p_ar_rec.supplier_office       := :supplier_office;
  p_ar_rec.supplier_site         := :supplier_site;
  p_ar_rec.supplier_product      := :supplier_product;
  p_ar_rec.sapply_user           := :ask_user_name;
  p_ar_rec.sapply_phone          := :ask_user_phone;
  p_ar_rec.remarks               := :remarks;
  scmdata.pkg_ask_record_mange.p_check_data_by_save(p_ar_rec => p_ar_rec,
                                                    p_type   => 1);

  scmdata.pkg_ask_record_mange.p_update_t_ask_record(p_ar_rec => p_ar_rec);

END;

--原有逻辑
/*
DECLARE
  JUDGE NUMBER(1);
BEGIN
  IF :COOPERATION_TYPE <> 'PRODUCT_TYPE' THEN
    RAISE_APPLICATION_ERROR(-20002,'除成品供应商外，其余合作类型未开放！');
  END IF;

  SELECT COUNT(1)
    INTO JUDGE
    FROM SCMDATA.T_ASK_RECORD
   WHERE BE_COMPANY_ID = %DEFAULT_COMPANY_ID%
     AND COMPANY_NAME = :ASK_COMPANY_NAME
     AND COOR_ASK_FLOW_STATUS <> 'CA00';
  IF JUDGE = 0 THEN
    SELECT COUNT(1)
       INTO JUDGE
      FROM (SELECT DISTINCT FIRST_VALUE(COMPANY_NAME) OVER(PARTITION BY ASK_RECORD_ID ORDER BY CREATE_DATE DESC) COMPANY_NAME
              FROM SCMDATA.T_FACTORY_ASK
             WHERE FACTRORY_ASK_FLOW_STATUS NOT IN ('CA01','FA01','FA03','FA21','FA33')
               AND COMPANY_ID = %DEFAULT_COMPANY_ID%)
     WHERE COMPANY_NAME = :ASK_COMPANY_NAME;
    IF JUDGE = 0 THEN
      SELECT COUNT(1)
        INTO JUDGE
        FROM SCMDATA.T_SUPPLIER_INFO
       WHERE SUPPLIER_COMPANY_NAME = :ASK_COMPANY_NAME;
      IF JUDGE > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, '公司名称与待建档、已建档的供应商名称重复！');
      END IF;
    ELSE
      RAISE_APPLICATION_ERROR(-20002, '公司名称与准入流程中的公司名称存在重复！');
    END IF;
  ELSE
    RAISE_APPLICATION_ERROR(-20002, '公司名称与意向合作供应商清单的公司名称重复！');
  END IF;
  UPDATE SCMDATA.T_ASK_RECORD
     SET   SOCIAL_CREDIT_CODE  = :SOCIAL_CREDIT_CODE,
           COMPANY_PROVINCE    = NVL(:COMPANY_PROVINCE, (SELECT COMPANY_PROVINCE FROM SCMDATA.T_ASK_RECORD WHERE ASK_RECORD_ID=:ASK_RECORD_ID)),
           COMPANY_CITY        = NVL(:COMPANY_CITY, (SELECT COMPANY_CITY FROM SCMDATA.T_ASK_RECORD WHERE ASK_RECORD_ID=:ASK_RECORD_ID)),
           COMPANY_COUNTY      = NVL(:COMPANY_COUNTY, (SELECT COMPANY_COUNTY FROM SCMDATA.T_ASK_RECORD WHERE ASK_RECORD_ID=:ASK_RECORD_ID)),
           COMPANY_ADDRESS     = :AREA || :COMPANY_ADDRESS,
           CERTIFICATE_FILE    = :CERTIFICATE_FILE,
           OTHER_FILE          = :OTHER_FILE,
           COOPERATION_MODEL   = :COOPERATION_MODEL,
           ASK_SAY             = :ASK_SAY,
           SAPPLY_USER         = :SAPPLY_USER,
           SAPPLY_PHONE        = :SAPPLY_PHONE,
           UPDATE_ID           = %CURRENT_USERID%,
           UPDATE_DATE         = SYSDATE,
           COMPANY_NAME        = :ASK_COMPANY_NAME,
           COOPERATION_TYPE    = :COOPERATION_TYPE
 WHERE ASK_RECORD_ID = :ASK_RECORD_ID;
END;*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_coop_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[]'',q''[]'',q''[]'',q''[COOPERATION_MODEL,ASK_RECORD_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_coop_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_coop_151'',q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[]'',q''[]'',q''[]'',q''[COOPERATION_MODEL,ASK_RECORD_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT t.itf_id,
       t.supplier_code,
       t.sup_id_base,
       t.sup_name,
       t.data_status,
       t.fetch_flag,
       t.create_id,
       t.create_time,
       t.update_id,
       t.update_time,
       t.publish_id,
       t.publish_time
  FROM scmdata.t_supplier_base_itf t]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_110''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,pause_desc,CREATE_SUPP_DATE]'',,0,q''[]'',q''[]'',q''[]'',,q''[supplier_company_name,supplier_company_abbreviation]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_110''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_110'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,pause_desc,CREATE_SUPP_DATE]'',,0,q''[]'',q''[]'',q''[]'',,q''[supplier_company_name,supplier_company_abbreviation]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--基本信息
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_code,
       sp.inside_supplier_code,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.legal_representative,
       sp.company_create_date,
       sp.regist_address,
       sp.certificate_validity_start,
       sp.certificate_validity_end,
       sp.regist_price,
       sp.social_credit_code,
       sp.company_type,
       sp.company_person,
       sp.company_contact_person,
       sp.company_contact_phone,
       nvl(sp.company_address,
           (SELECT fc.address
              FROM scmdata.sys_company fc
             WHERE fc.company_id = sp.supplier_company_id)) company_address,
       sp.taxpayer,
       sp.company_say,
       sp.certificate_file up_certificate_file,
       sp.organization_file,
       sp.sharing_type sharing_type,
       --财务信息
       sp.public_accounts,
       sp.public_payment,
       sp.public_bank,
       sp.public_id,
       sp.public_phone,
       sp.personal_account,
       sp.personal_payment,
       sp.personal_bank,
       sp.personal_idcard,
       sp.personal_phone,
       sp.pay_type,
       sp.settlement_type,
       sp.reconciliation_user,
       sp.reconciliation_phone,
       --合同管理
       sp.contract_start_date,
       sp.contract_stop_date,
       sp.contract_file,
       --能力评估
       sp.cooperation_method,
       sp.cooperation_model,
       sp.cooperation_type,
       sp.production_mode /*,
       sp.cooperation_classification cooperation_classification_sp,
       sp.cooperation_subcategory cooperation_subcategory_sp */
  FROM scmdata.t_supplier_info sp
 WHERE sp.supplier_info_id = %ass_supplier_info_id%
   AND sp.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_sp_data            scmdata.t_supplier_info%ROWTYPE;
  p_default_company_id VARCHAR2(1000) := %default_company_id%;
  p_status             VARCHAR2(20) := 'OLD';
BEGIN

SELECT :supplier_info_id,
       :supplier_company_name,
       :supplier_company_abbreviation,
       :social_credit_code,
       :company_contact_person,
       :company_contact_phone,
       :up_certificate_file,
       :contract_start_date,
       :contract_stop_date,
       :contract_file,
       :cooperation_type,
       :cooperation_model,
       :regist_price,
       :public_id,
       :personal_idcard,
       :public_phone,
       :personal_phone,
       :cooperation_type,
       :cooperation_model,
       :reconciliation_phone,
       :sharing_type
  INTO p_sp_data.supplier_info_id,
       p_sp_data.supplier_company_name,
       p_sp_data.supplier_company_abbreviation,
       p_sp_data.social_credit_code,
       p_sp_data.company_contact_person,
       p_sp_data.company_contact_phone,
       p_sp_data.certificate_file,
       p_sp_data.contract_start_date,
       p_sp_data.contract_stop_date,
       p_sp_data.contract_file,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_model,
       p_sp_data.regist_price,
       p_sp_data.public_id,
       p_sp_data.personal_idcard,
       p_sp_data.public_phone,
       p_sp_data.personal_phone,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_model,
       p_sp_data.reconciliation_phone,
       p_sp_data.sharing_type
  FROM dual;

  --更新=》保存，校验数据
  scmdata.sf_supplier_info_pkg.check_save_t_supplier_info(p_sp_data            => p_sp_data,
                                                          p_default_company_id => p_default_company_id,
                                                          p_status             => p_status);

  --2.修改数据
  UPDATE scmdata.t_supplier_info sp
     SET sp.inside_supplier_code = :inside_supplier_code,
         -- sp.supplier_company_name         = :supplier_company_name,
         -- sp.supplier_company_abbreviation = :supplier_company_abbreviation,
         sp.legal_representative       = :legal_representative,
         sp.company_create_date        = :company_create_date,
         sp.regist_address             = :regist_address,
         sp.company_address            = :company_address,
         sp.certificate_validity_start = :certificate_validity_start,
         sp.certificate_validity_end   = :certificate_validity_end,
         sp.regist_price               = :regist_price,
         sp.social_credit_code         = :social_credit_code,
         sp.company_type               = :company_type,
         sp.company_person             = :company_person,
         sp.company_contact_person     = :company_contact_person,
         sp.company_contact_phone      = :company_contact_phone,
         sp.taxpayer                   = :taxpayer,
         sp.company_say                = :company_say,
         sp.certificate_file           = :up_certificate_file,
         sp.organization_file          = :organization_file,
         sp.sharing_type               = :sharing_type,
         --财务信息
         sp.public_accounts      = :public_accounts,
         sp.public_payment       = :public_payment,
         sp.public_bank          = :public_bank,
         sp.public_id            = :public_id,
         sp.public_phone         = :public_phone,
         sp.personal_account     = :personal_account,
         sp.personal_payment     = :personal_payment,
         sp.personal_bank        = :personal_bank,
         sp.personal_idcard      = :personal_idcard,
         sp.personal_phone       = :personal_phone,
         sp.pay_type             = :pay_type,
         sp.settlement_type      = :settlement_type,
         sp.reconciliation_user  = :reconciliation_user,
         sp.reconciliation_phone = :reconciliation_phone,
         --合同管理
         sp.contract_start_date = :contract_start_date,
         sp.contract_stop_date  = :contract_stop_date,
         sp.contract_file       = :contract_file,
         --能力评估
         sp.cooperation_method = :cooperation_method,
         sp.cooperation_model  = :cooperation_model,
         sp.cooperation_type   = :cooperation_type,
         sp.production_mode    = :production_mode
   WHERE sp.supplier_info_id = :supplier_info_id;

END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_111''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,company_type,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[00]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_111''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_111'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,company_type,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[00]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT a.company_id,
       a.logo,
       a.company_name,
       a.logn_name,
       a.tips,
       --a.is_open,
       a.attributor_id,
       nvl(c.company_user_name, b.username) attributor,
       --a.create_time,
       dp.province || dci.city || dc.county area,
       a.address,
       a.product,
       a.rival,
       a.licence_type,
       a.licence_num
  FROM scmdata.t_supplier_info sp
 INNER JOIN scmdata.sys_company a
    ON sp.supplier_company_id = a.company_id
  LEFT JOIN sys_user b
    ON a.attributor_id = b.user_id
  LEFT JOIN sys_company_user c
    ON b.user_id = c.user_id
   AND a.company_id = c.company_id
    left join scmdata.dic_province dp
    on dp.provinceid = a.company_province
  left join scmdata.dic_county dc
    on a.company_county = dc.countyid
  left join scmdata.dic_city dci
    on dci.cityno = a.company_city
 WHERE sp.supplier_info_id = %ass_supplier_info_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_111_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_111_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_111_5'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--修改后的查询代码
SELECT v.supplier_info_id,
       v.company_id,
       v.supplier_info_origin,
       v.status,
       v.pause,
       v.regist_status,
       v.bind_status,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       v.cooperation_type_sp,
       nvl(v.cooperation_classification_sp, f.group_dict_name) cooperation_classification_sp, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       nvl(v.cooperation_subcategory_sp, g.group_dict_name) cooperation_subcategory_sp, --合作子类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       v.cooperation_method_sp,
       v.cooperation_model_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.regist_address,
       v.legal_representative,
       v.company_create_date,
       v.regist_price,
       v.company_contact_person,
       v.company_contact_phone
  FROM (SELECT e.group_dict_name supplier_info_origin,
               sp.status,
               sp.pause,
               nvl2(sp.supplier_company_id,'已注册','未注册') regist_status,
               sp.bind_status,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation,
               ar.ask_date,
               fr.check_date,
               sp.create_supp_date,
               sp.social_credit_code,
               sp.regist_address,
               sp.legal_representative,
               sp.company_create_date,
               sp.regist_price,
               a.group_dict_name cooperation_type_sp,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY 1)
                  FROM scmdata.sys_group_dict     t,
                       scmdata.t_supplier_ability sa
                 WHERE sp.supplier_info_id = sa.supplier_info_id
                   AND t.group_dict_type = sp.cooperation_type
                   AND t.group_dict_value = sa.cooperation_classification
                   AND t.pause = 0) cooperation_classification_sp,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY 1)
                  FROM scmdata.sys_group_dict     t,
                       scmdata.t_supplier_ability sa
                 WHERE sp.supplier_info_id = sa.supplier_info_id
                   AND t.group_dict_type = sa.cooperation_classification
                   AND t.group_dict_value = sa.cooperation_subcategory
                   AND t.pause = 0) cooperation_subcategory_sp,
               b.group_dict_name cooperation_method_sp,
               c.group_dict_name cooperation_model_sp,
               d.group_dict_name production_mode_sp,
               sp.company_contact_person,
               sp.company_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
          LEFT JOIN scmdata.sys_group_dict a
            ON a.group_dict_type = 'COOPERATION_TYPE'
           AND sp.cooperation_type = a.group_dict_value
          LEFT JOIN scmdata.sys_group_dict b
            ON b.group_dict_type = 'COOP_METHOD'
           AND b.group_dict_value = sp.cooperation_method
          LEFT JOIN scmdata.sys_group_dict c
            ON c.group_dict_type = 'SUPPLY_TYPE'
           AND c.group_dict_value = sp.cooperation_model
          LEFT JOIN scmdata.sys_group_dict d
            ON d.group_dict_type = 'CPMODE_TYPE'
           AND d.group_dict_value = sp.production_mode
          LEFT JOIN scmdata.sys_group_dict e
            ON e.group_dict_type = 'ORIGIN_TYPE'
           AND e.group_dict_value = sp.supplier_info_origin
          LEFT JOIN scmdata.sys_company fc
            ON sp.social_credit_code = fc.licence_num
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 1) v
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
  LEFT JOIN scmdata.sys_group_dict f
    ON f.group_dict_type = v.cooperation_type
   AND f.group_dict_value = fa.cooperation_classification
  LEFT JOIN scmdata.sys_group_dict g
    ON g.group_dict_type = fa.cooperation_classification
   AND g.group_dict_value = fa.cooperation_subcategory
 ORDER BY v.create_date DESC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_120''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status]'',,0,q''[]'',q''[]'',q''[]'',,q''[supplier_company_name,supplier_company_abbreviation]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_120''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_120'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status]'',,0,q''[]'',q''[]'',q''[]'',,q''[supplier_company_name,supplier_company_abbreviation]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT t.oper_type, t.reason, fc.company_user_name  oper_user_name, t.create_time oper_time
  FROM scmdata.t_supplier_info_oper_log t
  left JOIN scmdata.sys_company_user fc
    ON t.company_id = fc.company_id and t.create_id=fc.user_id
 WHERE t.company_id = %default_company_id%
   AND t.supplier_info_id = :supplier_info_id
ORDER BY t.create_time DESC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_120_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_120_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_120_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--基本信息
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_code,
       sp.inside_supplier_code,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.legal_representative,
       sp.company_create_date,
       sp.regist_address,
       sp.certificate_validity_start,
       sp.certificate_validity_end,
       sp.regist_price,
       sp.social_credit_code,
       sp.company_type,
       sp.company_person,
       sp.company_contact_person,
       sp.company_contact_phone,
       nvl(sp.company_address,
           (SELECT fc.address
              FROM scmdata.sys_company fc
             WHERE fc.company_id = sp.supplier_company_id)) company_address,
       sp.taxpayer,
       sp.company_say,
       sp.certificate_file UP_CERTIFICATE_FILE,
       sp.organization_file,
       sp.sharing_type sharing_type,
       --财务信息
       sp.public_accounts,
       sp.public_payment,
       sp.public_bank,
       sp.public_id,
       sp.public_phone,
       sp.personal_account,
       sp.personal_payment,
       sp.personal_bank,
       sp.personal_idcard,
       sp.personal_phone,
       sp.pay_type,
       sp.settlement_type,
       sp.reconciliation_user,
       sp.reconciliation_phone,
       --合同管理
       sp.contract_start_date,
       sp.contract_stop_date,
       sp.contract_file,
       --能力评估
       sp.cooperation_method ,
       sp.cooperation_model ,
       sp.cooperation_type ,
       sp.production_mode  /*,
       sp.cooperation_classification cooperation_classification_sp,
       sp.cooperation_subcategory cooperation_subcategory_sp  */
  FROM scmdata.t_supplier_info sp
  WHERE sp.supplier_info_id = %ASS_SUPPLIER_INFO_ID%
        AND sp.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_sp_data            scmdata.t_supplier_info%ROWTYPE;
  p_default_company_id VARCHAR2(1000) := %default_company_id%;
  p_status             VARCHAR2(20) := 'OLD';
BEGIN

SELECT :supplier_info_id,
       :supplier_company_name,
       :supplier_company_abbreviation,
       :social_credit_code,
       :company_contact_person,
       :company_contact_phone,
       :up_certificate_file,
       :contract_start_date,
       :contract_stop_date,
       :contract_file,
       :cooperation_type,
       :cooperation_model,
       :regist_price,
       :public_id,
       :personal_idcard,
       :public_phone,
       :personal_phone,
       :cooperation_type,
       :cooperation_model,
       :reconciliation_phone,
       :sharing_type
  INTO p_sp_data.supplier_info_id,
       p_sp_data.supplier_company_name,
       p_sp_data.supplier_company_abbreviation,
       p_sp_data.social_credit_code,
       p_sp_data.company_contact_person,
       p_sp_data.company_contact_phone,
       p_sp_data.certificate_file,
       p_sp_data.contract_start_date,
       p_sp_data.contract_stop_date,
       p_sp_data.contract_file,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_model,
       p_sp_data.regist_price,
       p_sp_data.public_id,
       p_sp_data.personal_idcard,
       p_sp_data.public_phone,
       p_sp_data.personal_phone,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_model,
       p_sp_data.reconciliation_phone,
       p_sp_data.sharing_type
  FROM dual;

  --更新=》保存，校验数据
  scmdata.sf_supplier_info_pkg.check_save_t_supplier_info(p_sp_data            => p_sp_data,
                                                          p_default_company_id => p_default_company_id,
                                                          p_status             => p_status);

--2.修改数据
UPDATE scmdata.t_supplier_info sp
   SET sp.inside_supplier_code          = :inside_supplier_code,
       --sp.supplier_company_name         = :supplier_company_name,
       --sp.supplier_company_abbreviation = :supplier_company_abbreviation,
       sp.legal_representative          = :legal_representative,
       sp.company_create_date           = :company_create_date,
       sp.regist_address                = :regist_address,
       sp.company_address               = :company_address,
       sp.certificate_validity_start    = :certificate_validity_start,
       sp.certificate_validity_end      = :certificate_validity_end,
       sp.regist_price                  = :regist_price,
       sp.social_credit_code            = :social_credit_code,
       sp.company_type                  = :company_type,
       sp.company_person                = :company_person,
       sp.company_contact_person        = :company_contact_person,
       sp.company_contact_phone         = :company_contact_phone,
       sp.taxpayer                      = :taxpayer,
       sp.company_say                   = :company_say,
       sp.certificate_file              = :up_certificate_file,
       sp.organization_file             = :organization_file,
       sp.sharing_type               = :sharing_type,
       --财务信息
       sp.public_accounts      = :public_accounts,
       sp.public_payment       = :public_payment,
       sp.public_bank          = :public_bank,
       sp.public_id            = :public_id,
       sp.public_phone         = :public_phone,
       sp.personal_account     = :personal_account,
       sp.personal_payment     = :personal_payment,
       sp.personal_bank        = :personal_bank,
       sp.personal_idcard      = :personal_idcard,
       sp.personal_phone       = :personal_phone,
       sp.pay_type             = :pay_type,
       sp.settlement_type      = :settlement_type,
       sp.reconciliation_user  = :reconciliation_user,
       sp.reconciliation_phone = :reconciliation_phone,
       --合同管理
       sp.contract_start_date = :contract_start_date,
       sp.contract_stop_date = :contract_stop_date,
       sp.contract_file      = :contract_file,
       --能力评估
       sp.cooperation_method         = :cooperation_method,
       sp.cooperation_model          = :cooperation_model,
       sp.cooperation_type           = :cooperation_type,
       sp.production_mode            = :production_mode
 WHERE sp.supplier_info_id = :supplier_info_id;
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_121''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,cooperation_classification,cooperation_subcategory,company_type,taxpayer,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_121''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_121'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,cooperation_classification,cooperation_subcategory,company_type,taxpayer,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[call scmdata.pkg_supplier_info.delete_supplier_info(p_supplier_info_id => :supplier_info_id,p_default_company_id => %default_company_id%)]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_unfile_supp_info();
  @strresult := v_sql;
END;}
--原逻辑
/*--优化后的查询代码
SELECT v.supplier_info_id,
       v.company_id,
       v.status,
       v.pause,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       NVL(V.COOPERATION_CLASSIFICATION_SP,'') COOPERATION_CLASSIFICATION_SP, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       --合作子类 注释原因：暂不开放出来
       /*       nvl(v.cooperation_subcategory_sp,
       g.group_dict_name
       (SELECT *
          FROM scmdata.sys_group_dict g
         WHERE g.group_dict_type = fa.cooperation_classification
           AND g.group_dict_value = fa.cooperation_subcategory)) cooperation_subcategory_sp,*/ --合作子类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       v.cooperation_model_sp,
       v.company_type,
       v.cooperation_method_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.cooperation_type_sp,
       v.company_contact_person,
       v.company_contact_phone,
       v.supplier_info_origin,
       v.supplier_info_origin_id factory_ask_id
  FROM (SELECT (SELECT e.group_dict_name
                  FROM scmdata.sys_group_dict e
                 WHERE e.group_dict_type = 'ORIGIN_TYPE'
                   AND e.group_dict_value = sp.supplier_info_origin) supplier_info_origin,
               sp.status,
               sp.pause,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation,
               ar.ask_date,
               fr.check_date,
               sp.create_supp_date,
               sp.social_credit_code,
               sp.regist_address,
               sp.legal_representative,
               sp.company_create_date,
               sp.regist_price,
               (SELECT a.group_dict_name
                  FROM scmdata.sys_group_dict a
                 WHERE a.group_dict_type = 'COOPERATION_TYPE'
                   AND sp.cooperation_type = a.group_dict_value) cooperation_type_sp,
               (SELECT listagg(DISTINCT sa.coop_classification, ';') within GROUP(ORDER BY sa.coop_classification)
                  FROM scmdata.t_coop_scope sa
                 WHERE sa.company_id = sp.company_id
                   AND sa.supplier_info_id = sp.supplier_info_id) coop_classification,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                  FROM scmdata.sys_group_dict t, scmdata.t_coop_scope sa
                 WHERE sa.company_id = sp.company_id
                   AND sa.supplier_info_id = sp.supplier_info_id
                   AND t.group_dict_type = sp.cooperation_type
                   AND t.group_dict_value = sa.coop_classification
                   AND t.pause = 0) cooperation_classification_sp,
               (SELECT b.group_dict_name
                  FROM scmdata.sys_group_dict b
                 WHERE b.group_dict_type = 'COOP_METHOD'
                   AND b.group_dict_value = sp.cooperation_method) cooperation_method_sp,
               (SELECT c.group_dict_name
                  FROM scmdata.sys_group_dict c
                 WHERE c.group_dict_type = 'SUPPLY_TYPE'
                   AND c.group_dict_value = sp.cooperation_model) cooperation_model_sp,
               (SELECT d.group_dict_name
                  FROM scmdata.sys_group_dict d
                 WHERE d.group_dict_type = 'CPMODE_TYPE'
                   AND d.group_dict_value = sp.production_mode) production_mode_sp,
               sp.company_contact_person,
               sp.company_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id,
               (SELECT f.group_dict_name
                  FROM scmdata.sys_group_dict f
                 WHERE f.group_dict_type = 'COMPANY_TYPE'
                   AND f.group_dict_value = sp.company_type) company_type
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 0
           AND sp.supplier_info_origin <> 'II') v --先不展示接口导入的数据
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
 WHERE ((%is_company_admin% = 1) OR
  instr_priv(p_str1  => @subsql@ ,p_str2  => v.coop_classification ,p_split => ';') > 0)
 ORDER BY v.create_date DESC*/]';
  CV8 CLOB:=q'[{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => 'COL_2');]' || '
 @strresult := ''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';' || q'[
end;}]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_150''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,supplier_code,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,pause_desc,CREATE_SUPP_DATE,inside_supplier_code,factory_ask_id,coop_status]'',,0,q''[]'',q''[]'',q''[]'',,q''[supplier_company_name,supplier_company_abbreviation]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_150''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_150'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,supplier_code,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,pause_desc,CREATE_SUPP_DATE,inside_supplier_code,factory_ask_id,coop_status]'',,0,q''[]'',q''[]'',q''[]'',,q''[supplier_company_name,supplier_company_abbreviation]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/ 
  
BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value, 
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
--基本信息
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.supplier_code,
       sp.social_credit_code,
       sp.legal_representative,
       sp.inside_supplier_code,
       sp.company_province company_province,
       sp.company_city company_city,
       sp.company_county company_county,
       province || city || county location_area,
       nvl(sp.company_address, fc.address) company_address_sp,
       sp.group_name,
       sp.area_group_leader,
       sp.company_contact_phone,
       sp.fa_contact_name,
       sp.fa_contact_phone,
       sp.company_type,
       --生产信息
       sp.product_type,
       sp.product_link,
       sp.brand_type,
       sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || sp.brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || sp.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc,
       sp.product_line,
       sp.product_line_num,
       sp.worker_num,
       sp.machine_num,
       sp.quality_step quality_step,
       sp.pattern_cap pattern_cap,
       sp.fabric_purchase_cap fabric_purchase_cap,
       sp.fabric_check_cap fabric_check_cap,
       sp.cost_step cost_step,
       decode(sp.reserve_capacity, NULL, '', sp.reserve_capacity || '%') reserve_capacity,
       decode(sp.product_efficiency, NULL, '', sp.product_efficiency || '%') product_efficiency,
       sp.work_hours_day,
       --合作信息
       sp.pause coop_state,
       nvl2(sp.supplier_company_id, '已注册', '未注册') regist_status_sp,
       decode(sp.bind_status, 1, '已绑定', '未绑定') bind_status_sq,
       sp.cooperation_type,
       sp.cooperation_model,
       sp.coop_position,
       --附件资料
       sp.certificate_file certificate_file_sp,
       sp.supplier_gate,
       sp.supplier_office,
       sp.supplier_site,
       sp.supplier_product,
       sp.file_remark,
       --其他
       sp.supplier_info_origin,
       sp.status
  FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.t_factory_ask fa
    ON sp.supplier_info_origin_id = fa.factory_ask_id
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = nvl(sp.company_province, fa.company_province)
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = nvl(sp.company_city, fa.company_city)
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = nvl(sp.company_county, fa.company_county)
  LEFT JOIN scmdata.sys_company fc
    ON fc.company_id = sp.supplier_company_id
 INNER JOIN group_dict ga
    ON sp.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = 'COOPERATION_TYPE'
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = 'COOPERATION_BRAND'
   AND gd.group_dict_value = sp.cooperation_brand
 WHERE sp.supplier_info_id = %ass_supplier_info_id%
   AND sp.company_id = %default_company_id%

]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN
  --来源为准入/手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%
     AND sp.status = 0;

  v_sql := q'[DECLARE
  v_sp_data t_supplier_info%ROWTYPE;
BEGIN
  --待建档数据
  v_sp_data.supplier_info_id := :supplier_info_id;
  v_sp_data.company_id       := :company_id;
  v_sp_data.status           := :status;
  v_sp_data.supplier_info_origin := ']' || '|| v_origin ||' || q'[' ;
  --来源为准入 统一社会信用代码则 不可更改
  --来源为手动新增 待建档：统一社会信用代码 可以更改 ，已建档 不可以更改
  ]' || '|| CASE WHEN v_origin = ''MA'' THEN v_sp_data.social_credit_code := :social_credit_code;
ELSE '''' END ||' || q'[
  --基本信息
  v_sp_data.supplier_company_name         := :supplier_company_name;
  v_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  v_sp_data.legal_representative := :legal_representative;
  v_sp_data.inside_supplier_code := :inside_supplier_code;
  v_sp_data.company_province     := :company_province;
  v_sp_data.company_city         := :company_city;
  v_sp_data.company_county       := :company_county;
  v_sp_data.company_address      := :company_address_sp;
  --v_sp_data.group_name                    := :group_name;
  v_sp_data.company_contact_phone := :company_contact_phone;
  v_sp_data.fa_contact_name       := :fa_contact_name;
  v_sp_data.fa_contact_phone      := :fa_contact_phone;
  v_sp_data.company_type          := :company_type;
  --生产信息
  v_sp_data.product_type        := :product_type;
  v_sp_data.product_link        := :product_link;
  v_sp_data.brand_type          := :brand_type;
  v_sp_data.cooperation_brand   := :cooperation_brand;
  v_sp_data.product_line        := :product_line;
  v_sp_data.product_line_num    := :product_line_num;
  v_sp_data.worker_num          := :worker_num;
  v_sp_data.machine_num         := :machine_num;
  v_sp_data.quality_step        := :quality_step;
  v_sp_data.pattern_cap         := :pattern_cap;
  v_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  v_sp_data.fabric_check_cap    := :fabric_check_cap;
  v_sp_data.cost_step           := :cost_step;
  v_sp_data.reserve_capacity    := rtrim(:reserve_capacity,'%');
  v_sp_data.product_efficiency  := rtrim(:product_efficiency,'%');
  v_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  v_sp_data.pause               := :coop_state;
  --v_sp_data.cooperation_type  := :cooperation_type;
  v_sp_data.cooperation_model := :cooperation_model;
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
  v_sp_data.supplier_gate    := :supplier_gate;
  v_sp_data.supplier_office  := :supplier_office;
  v_sp_data.supplier_site    := :supplier_site;
  v_sp_data.supplier_product := :supplier_product;
  v_sp_data.company_say      := :company_say;
  v_sp_data.file_remark      := :file_remark;
  v_sp_data.update_id        := :user_id;
  v_sp_data.update_date      := SYSDATE;
  --1.更新=》保存，校验数据
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data);
  --2.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => :supplier_info_id);
END;]' || q'[;
 @strresult := v_sql; END;}]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,province,city,county,company_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,FA_BRAND_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[00]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,province,city,county,company_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,FA_BRAND_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[00]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;

  scmdata.pkg_supplier_info.delete_coop_scope(p_cp_data => p_cp_data);
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;

/*DECLARE
BEGIN
DELETE FROM scmdata.t_supplier_shared t WHERE t.coop_scope_id = :coop_scope_id;

DELETE FROM t_coop_scope t WHERE t.coop_scope_id = :coop_scope_id;
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.create_id           := %user_id%;
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := :sharing_type;
  p_cp_data.publish_id          := '';
  p_cp_data.publish_date        := '';

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;


/*INSERT INTO t_coop_scope
  (coop_scope_id,
   supplier_info_id,
   company_id,
   --coop_mode,
   coop_classification,
   coop_product_cate,
   coop_subcategory,
   create_id,
   create_time,
   update_id,
   update_time,
   sharing_type)
VALUES
  (scmdata.f_get_uuid(),
   :supplier_info_id,
   %default_company_id%,
   --:coop_mode,
   :coop_classification,
   :coop_product_cate,
   :coop_subcategory,
   %user_id%,
   sysdate,
   %user_id%,
   sysdate,
   :sharing_type)*/]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT tc.coop_scope_id,
       tc.coop_classification,
       a.group_dict_name coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name coop_product_cate_desc,
       tc.coop_subcategory,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id = %default_company_id%
           AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) coop_subcategory_desc,
       tc.sharing_type,
       (SELECT listagg(fc.supplier_company_name, ';')
          FROM scmdata.t_supplier_shared ts, scmdata.t_supplier_info fc
         WHERE ts.supplier_info_id = tc.supplier_info_id
           AND ts.coop_scope_id = tc.coop_scope_id
           AND fc.supplier_code = ts.shared_supplier_code
           AND fc.company_id = tc.company_id) company_list
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
  LEFT JOIN scmdata.t_supplier_info sp
    ON tc.supplier_info_id = sp.supplier_info_id
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.sharing_type        := :sharing_type;

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.update_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode,coop_state]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 4,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode,coop_state]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH company_user AS
 (SELECT t.company_user_name, t.user_id, t.company_id
    FROM scmdata.sys_company_user t
   WHERE t.company_id = %default_company_id%)
SELECT *
  FROM (SELECT fa.factory_ask_id,
               fa.company_id,
               fa.ask_date factory_ask_date,
               a.company_user_name check_apply_username,
               nvl(fr.check_date, '') check_date,
               b.company_user_name || CASE
                 WHEN c.company_user_name IS NULL THEN
                  ''
                 ELSE
                  ';' || c.company_user_name
               END check_person,
               fr.check_result check_fac_result,
               '验厂报告详情' CHECK_REPORT,
               fr.factory_result_suggest,
               fa.factory_ask_id supplier_info_origin_id
          FROM scmdata.t_factory_ask fa
         INNER JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN company_user a
            ON a.user_id = fa.ask_user_id
           AND a.company_id = fa.company_id
          LEFT JOIN company_user b
            ON b.user_id = fr.check_person1
           AND b.company_id = fr.company_id
          LEFT JOIN company_user c
            ON c.user_id = fr.check_person2
           AND c.company_id = fr.company_id) v
 WHERE v.supplier_info_origin_id IN
       (SELECT sa.supplier_info_origin_id
          FROM scmdata.t_supplier_info sa
         WHERE sa.supplier_info_id = :supplier_info_id)
   AND v.company_id = %default_company_id%

--原代码
/*
SELECT *
  FROM (SELECT fa.factory_ask_id,
               fa.company_id,
               nvl((fr.check_date), '') check_date,
               (SELECT fc.logn_name
                  FROM scmdata.sys_company fc
                 WHERE fc.company_id = fa.company_id) fa_company_name,
               fa.ask_address,
               fr.check_result check_fac_result,
               fr.check_report_file,
               fa.factory_ask_id supplier_info_origin_id,
               nvl(fr.admit_result, '') trialorder_type
          FROM scmdata.t_factory_ask fa
         INNER JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
         INNER JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id) v
 WHERE v.supplier_info_origin_id IN
       (SELECT sa.supplier_info_origin_id
          FROM scmdata.t_supplier_info sa
         WHERE sa.supplier_info_id = :supplier_info_id)
   AND v.company_id = %default_company_id%*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[factory_ask_id,company_id,supplier_info_origin_id,TRIALORDER_TYPE,CHECK_FAC_RESULT]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_2'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[factory_ask_id,company_id,supplier_info_origin_id,TRIALORDER_TYPE,CHECK_FAC_RESULT]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[call scmdata.pkg_supplier_info.delete_contract_info(p_contract_info_id => :contract_info_id)]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file,
         :contract_type,
         :contract_num,
         %user_id%,
         %user_id%
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file,
         p_contract_rec.contract_type,
         p_contract_rec.contract_num,
         p_contract_rec.operator_id,
         p_contract_rec.change_id
    FROM dual;
  scmdata.pkg_supplier_info.insert_contract_info(p_contract_rec => p_contract_rec);
END;


/*DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file
    FROM dual;
  scmdata.pkg_supplier_info.insert_contract_info(p_contract_rec => p_contract_rec);
END;*/]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT tc.contract_info_id,
       tc.supplier_info_id,
       tc.company_id,
       tc.contract_start_date,
       tc.contract_stop_date,
       tc.contract_sign_date,
       tc.contract_file contract_file_sp,
       tc.CONTRACT_TYPE,
       tc.contract_num,
       (SELECT MAX(NICK_NAME) FROM scmdata.sys_company_user td WHERE td.user_id = tc.operator_id ) AS OPERATOR_NAME,
       tc.OPERATE_TIME,
       (SELECT MAX(NICK_NAME) FROM scmdata.sys_company_user td WHERE td.user_id = tc.Change_Id ) AS CHANGE_NAME,
       TC.CHANGE_TIME
  FROM scmdata.t_contract_info tc
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%


/*SELECT tc.contract_info_id,
       tc.supplier_info_id,
       tc.company_id,
       tc.contract_start_date,
       tc.contract_stop_date,
       tc.contract_sign_date,
       tc.contract_file
  FROM scmdata.t_contract_info tc
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file,
         :contract_type,
         :contract_num,
         %user_id%,
         SYSDATE
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file,
         p_contract_rec.contract_type,
         p_contract_rec.contract_num,
         p_contract_rec.change_id,
         p_contract_rec.change_time
    FROM dual;
  scmdata.pkg_supplier_info.update_contract_info(p_contract_rec => p_contract_rec);
END;


/*DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file
    FROM dual;
  scmdata.pkg_supplier_info.update_contract_info(p_contract_rec => p_contract_rec);
END;*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[contract_info_id,supplier_info_id,company_id,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_3'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[contract_info_id,supplier_info_id,company_id,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
BEGIN
pkg_supplier_info.delete_supplier_shared(p_supplier_shared_id => :supplier_shared_id);
--3.新增日志操作
scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-删除指定供应商','',%user_id%,%default_company_id%,SYSDATE);
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
 v_scope_rec scmdata.t_coop_scope%ROWTYPE;
BEGIN
  SELECT *
    INTO v_scope_rec
    FROM scmdata.t_coop_scope t
   WHERE t.coop_scope_id = :coop_scope_id;

  pkg_supplier_info.insert_supplier_shared(scope_rec => v_scope_rec,p_supplier_code => :supplier_code);

  --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(v_scope_rec.supplier_info_id,
                                            '修改档案-新增指定供应商',
                                            '',
                                            %user_id%,
                                            %default_company_id%,
                                            SYSDATE);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[select %ass_coop_scope_id% coop_scope_id from dual]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[{
DECLARE
  v_flag VARCHAR2(100);
  v_sql  VARCHAR2(1000);
BEGIN
  SELECT max(t.sharing_type)
    INTO v_flag
    FROM scmdata.t_coop_scope t
   WHERE t.coop_scope_id = :coop_scope_id;
  IF v_flag = '00' OR v_flag = '01' THEN
    raise_application_error(-20002, '是否作为外协厂设置为‘否或是’，则无需操作‘指定供应商’按钮！！');
    RETURN;
  ELSE
  v_sql := 'SELECT tf.supplier_code,
       tf.inside_supplier_code,
       tf.supplier_company_name,
       tf.social_credit_code,
       ts.supplier_shared_id,
       tf.supplier_info_id,
       tf.company_id
  FROM scmdata.t_supplier_info tf
 INNER JOIN scmdata.t_supplier_shared ts
    ON tf.supplier_code = ts.shared_supplier_code
    AND tf.company_id = %default_company_id%
 INNER JOIN scmdata.t_coop_scope t
    ON ts.company_id = t.company_id
   AND ts.supplier_info_id = t.supplier_info_id
   AND ts.coop_scope_id = t.coop_scope_id
   AND t.coop_scope_id = :coop_scope_id';
  END IF;
  @strresult := v_sql;
END;
}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',3,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_shared_id,supplier_info_id,company_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_4'',q''[]'',q''[]'',,q''[]'',3,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_shared_id,supplier_info_id,company_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT tc.coop_scope_id,
       tc.coop_classification,
       a.group_dict_name      coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name      coop_product_cate_desc,
       tc.coop_subcategory,
       --c.company_dict_name coop_subcategory_desc,
       (SELECT listagg(DISTINCT c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) coop_subcategory_desc,
       tc.coop_mode,
       tc.sharing_type
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = :company_id]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_5'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DELETE FROM scmdata.t_contract_info_temp A
WHERE A.COMPANY_ID = %default_company_id%
AND A.USER_ID =  %user_id%
AND A.TEMP_ID = :TEMP_ID]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_temp_id VARCHAR2(100);

BEGIN
  v_temp_id := f_getkeyid_plat('', 'SEQ_CA', '');
  INSERT INTO scmdata.t_contract_info_temp
    (supplier_info_id,
     inside_supplier_code,
     supplier_company_name,
     company_id,
     contract_start_date,
     contract_stop_date,
     contract_sign_date,
     contract_file,
     contract_type,
     contract_num,
     user_id,
     temp_id)
  VALUES
    (:supplier_info_id,
     :inside_supplier_code_sp,
     :supplier_company_name,
     :default_company_id,
     :contract_start_date,
     :contract_stop_date,
     :contract_sign_date,
     :contract_file,
     :contract_type,
     :contract_num,
     :user_id,
     v_temp_id);
  pkg_supplier_info.check_import_constract(p_temp_id => v_temp_id);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[SELECT CONTRACT_START_DATE,
       CONTRACT_STOP_DATE,
       CONTRACT_SIGN_DATE,
       CONTRACT_FILE,
       CONTRACT_TYPE,
       CONTRACT_NUM
  FROM T_CONTRACT_INFO_TEMP
 WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND USER_ID = %USER_ID%]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT inside_supplier_code inside_supplier_code_sp,
       supplier_company_name,
       user_id,
       --USER_NAME,
       company_id,
       temp_id,
       contract_start_date,
       contract_stop_date,
       contract_sign_date,
       contract_file,
       contract_type,
       contract_num,
       msg
  FROM t_contract_info_temp
 WHERE company_id = %default_company_id%
   AND user_id = :user_id]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[declare
begin
UPDATE scmdata.t_contract_info_temp a
   SET a.inside_supplier_code  = :inside_supplier_code_sp,
       a.supplier_company_name = :supplier_company_name,
       a.contract_start_date   = :contract_start_date,
       a.contract_stop_date    = :contract_stop_date,
       a.contract_sign_date    = :contract_sign_date,
       a.contract_file         = :contract_file,
       a.contract_type         = :contract_type,
       a.contract_num          = :contract_num
 WHERE a.company_id = %default_company_id%
   AND a.user_id = %user_id%
   AND a.temp_id = :temp_id;
pkg_supplier_info.check_import_constract(p_temp_id => :temp_id);
end;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[USER_ID,COMPANY_ID,TEMP_ID,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_6'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[USER_ID,COMPANY_ID,TEMP_ID,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id
    FROM scmdata.sys_group_dict)
SELECT sp.supplier_company_name,
       '本厂' cooperation_name,
       sp.pause COOP_STATE,
       sp.product_type,
       sp.product_link,
       sp.product_line,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM dic t
          LEFT JOIN dic b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || sp.brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || sp.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc
  FROM scmdata.t_supplier_info sp
 WHERE sp.company_id = %default_company_id%
   AND sp.supplier_info_id = :supplier_info_id
UNION ALL
SELECT DISTINCT sp_a.supplier_company_name,
                '外协厂' cooperation_name,
                sp_a.pause COOP_STATE,
                sp_a.product_type,
                sp_a.product_link,
                sp_a.product_line,
                (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
                   FROM dic t
                   LEFT JOIN dic b
                     ON t.group_dict_type = 'COOPERATION_BRAND'
                    AND t.group_dict_id = b.parent_id
                    AND instr(';' || sp_a.brand_type || ';',
                              ';' || t.group_dict_value || ';') > 0
                    AND instr(';' || sp_a.cooperation_brand || ';',
                              ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc
  FROM scmdata.t_supplier_info sp_a
  LEFT JOIN scmdata.t_supplier_shared ts_a
    ON sp_a.supplier_info_id = ts_a.supplier_info_id
 WHERE sp_a.company_id = ts_a.company_id AND
 ts_a.company_id = %default_company_id% AND
 ts_a.shared_supplier_code =
 (SELECT t.supplier_code
    FROM scmdata.t_supplier_info t
   WHERE t.supplier_info_id = :supplier_info_id)]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[FACTORY_TYPE,COOP_STATE,PRODUCT_TYPE,PRODUCT_LINK,PRODUCT_LINE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_7'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[FACTORY_TYPE,COOP_STATE,PRODUCT_TYPE,PRODUCT_LINK,PRODUCT_LINE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT A.SP_RECORD_ID,
       A.SUPPLIER_INFO_ID,
       A.COMPANY_ID,
       A.KAOH_LIMIT,
       A.BUH_SVG_LIMIT,
       A.ORDER_CONTENT_RATE,
       A.ORDER_ONTIME_RATE,
       A.STORE_RETURN_RATE,
       A.SHOP_RETURN_RATE,
       A.QOUTE_RATE,
       A.RALE_QOUTE_RATE,
       A.CUSTOM_PRIOR,
       A.ACCOUNT_CAP,
       A.RESPONSE_QS
  FROM T_SUPPLIER_PERFORM A
  WHERE A.supplier_info_id = %ass_supplier_info_id%
   AND A.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_151_8''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[SP_RECORD_ID,SUPPLIER_INFO_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_151_8''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_151_8'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[SP_RECORD_ID,SUPPLIER_INFO_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[select pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => 'COL_2') class_data_privs from dual]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_filed_supp_info();
  @strresult := v_sql;
END;}
--原逻辑
/*--优化后的查询代码
--增加数据权限函数
SELECT v.supplier_info_id,
        v.company_id,
        v.status,
        v.pause,
        v.supplier_code,
        v.inside_supplier_code,
        v.supplier_company_id,
        v.supplier_company_name,
        v.supplier_company_abbreviation,
        NVL(V.COOPERATION_CLASSIFICATION_SP,'') COOPERATION_CLASSIFICATION_SP, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
        /*nvl(v.cooperation_subcategory_sp,
        (SELECT g.group_dict_name
           FROM scmdata.sys_group_dict g
             WHERE g.group_dict_type = fa.cooperation_classification
            AND g.group_dict_value = fa.cooperation_subcategory)) cooperation_subcategory_sp,*/ --合作子类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
        v.cooperation_model_sp,
        v.company_type,
        v.cooperation_method_sp,
        v.production_mode_sp,
        v.ask_date,
        v.check_date,
        v.create_supp_date,
        v.social_credit_code,
        v.cooperation_type_sp,
        v.regist_status,
        v.bind_status,
        v.company_contact_person,
        v.company_contact_phone,
        v.supplier_info_origin,
        v.supplier_info_origin_id factory_ask_id
   FROM (SELECT (SELECT e.group_dict_name
                   FROM scmdata.sys_group_dict e
                  WHERE e.group_dict_type = 'ORIGIN_TYPE'
                    AND e.group_dict_value = sp.supplier_info_origin) supplier_info_origin,
                sp.status,
                sp.pause,
                nvl2(sp.supplier_company_id, '已注册', '未注册') regist_status,
                sp.bind_status,
                sp.supplier_code,
                sp.inside_supplier_code,
                sp.supplier_company_name,
                sp.supplier_company_abbreviation,
                ar.ask_date,
                fr.check_date,
                sp.create_supp_date,
                sp.social_credit_code,
                sp.regist_address,
                sp.legal_representative,
                sp.company_create_date,
                sp.regist_price,
                (SELECT a.group_dict_name
                   FROM scmdata.sys_group_dict a
                  WHERE a.group_dict_type = 'COOPERATION_TYPE'
                    AND sp.cooperation_type = a.group_dict_value) cooperation_type_sp,
                (SELECT listagg(DISTINCT sa.coop_classification, ';') within GROUP(ORDER BY sa.coop_classification)
                  FROM scmdata.t_coop_scope sa
                 WHERE sa.company_id = sp.company_id
                   AND sa.supplier_info_id = sp.supplier_info_id) coop_classification,
                (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                   FROM scmdata.sys_group_dict t, scmdata.t_coop_scope sa
                  WHERE sa.company_id = sp.company_id
                    AND sa.supplier_info_id = sp.supplier_info_id
                    AND t.group_dict_type = sp.cooperation_type
                    AND t.group_dict_value = sa.coop_classification
                    AND t.pause = 0) cooperation_classification_sp,
                (SELECT b.group_dict_name
                   FROM scmdata.sys_group_dict b
                  WHERE b.group_dict_type = 'COOP_METHOD'
                    AND b.group_dict_value = sp.cooperation_method) cooperation_method_sp,
                (SELECT c.group_dict_name
                   FROM scmdata.sys_group_dict c
                  WHERE c.group_dict_type = 'SUPPLY_TYPE'
                    AND c.group_dict_value = sp.cooperation_model) cooperation_model_sp,
                (SELECT d.group_dict_name
                   FROM scmdata.sys_group_dict d
                  WHERE d.group_dict_type = 'CPMODE_TYPE'
                    AND d.group_dict_value = sp.production_mode) production_mode_sp,
                sp.company_contact_person,
                sp.company_contact_phone,
                sp.create_date,
                sp.supplier_info_origin_id,
                sp.cooperation_type,
                sp.supplier_info_id,
                sp.supplier_company_id,
                sp.company_id,
                (SELECT f.group_dict_name
                   FROM scmdata.sys_group_dict f
                  WHERE f.group_dict_type = 'COMPANY_TYPE'
                    AND f.group_dict_value = sp.company_type) company_type
           FROM scmdata.t_supplier_info sp
           LEFT JOIN scmdata.t_factory_ask fa
             ON sp.supplier_info_origin_id = fa.factory_ask_id
           LEFT JOIN scmdata.t_factory_report fr
             ON fa.factory_ask_id = fr.factory_ask_id
           LEFT JOIN scmdata.t_ask_record ar
             ON fa.ask_record_id = ar.ask_record_id
           LEFT JOIN scmdata.sys_company fc
             ON sp.social_credit_code = fc.licence_num
          WHERE sp.company_id = %default_company_id%
            AND sp.status = 1
            AND sp.supplier_info_origin <> 'II') v --先不展示接口导入的数据
   LEFT JOIN scmdata.t_factory_ask fa
     ON fa.factory_ask_id = v.supplier_info_origin_id
   WHERE ((%is_company_admin% = 1) OR
   instr_priv(p_str1  => @subsql@ ,p_str2  => v.coop_classification ,p_split => ';') > 0)
  ORDER BY v.create_date DESC*/]';
  CV8 CLOB:=q'[{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => 'COL_2');]' || '
 @strresult := ''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';' || q'[
end;}]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_160''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status,factory_ask_id,coop_status]'',,0,q''[]'',q''[]'',q''[]'',,q''[supplier_company_name,supplier_company_abbreviation]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_160''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_160'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status,factory_ask_id,coop_status]'',,0,q''[]'',q''[]'',q''[]'',,q''[supplier_company_name,supplier_company_abbreviation]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
v_supp_rec scmdata.t_supplier_info_temp%ROWTYPE;
BEGIN
  v_supp_rec.supplier_temp_id       := scmdata.f_get_uuid();
  v_supp_rec.company_id             := %default_company_id%;
  v_supp_rec.user_id                := :user_id;
  v_supp_rec.inside_supplier_code   := :inside_supplier_code_sp;
  v_supp_rec.supplier_company_name  := :supplier_company_name;
  v_supp_rec.cooperation_type       := :cooperation_type_sp;
  v_supp_rec.company_city           := :company_city_sp;
  v_supp_rec.company_province       := :company_province_sp;
  v_supp_rec.company_county         := :company_county_sp;
  v_supp_rec.company_address        := :company_address_sp;
  v_supp_rec.social_credit_code     := :social_credit_code_tp;
  v_supp_rec.legal_representative   := :legal_representative;
  v_supp_rec.company_contact_person := :company_contact_person;
  v_supp_rec.company_contact_phone  := :company_contact_phone_tp;
  v_supp_rec.cooperation_type_code  := :cooperation_type_code;
  v_supp_rec.company_city_code      := :company_city_code;
  v_supp_rec.company_province_code  := :company_province_code;
  v_supp_rec.company_county_code    := :company_county_code;
  v_supp_rec.cooperation_model_code := :cooperation_model_code;
  v_supp_rec.cooperation_model      := :cooperation_model_sp;
  v_supp_rec.memo:=:memo;
  scmdata.pkg_supplier_info.insert_supplier_info_temp(p_supp_rec => v_supp_rec);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT t.supplier_temp_id,
       t.company_id,
       t.user_id,
       t.inside_supplier_code inside_supplier_code_sp,
       t.supplier_company_name,
       t.cooperation_type_code,
       t.cooperation_type cooperation_type_sp,
       t.cooperation_model_code,
       t.cooperation_model cooperation_model_sp,
       t.company_province_code,
       t.company_province company_province_sp,
       t.company_city_code,
       t.company_city company_city_sp,
       t.company_county_code,
       t.company_county company_county_sp,
       t.company_address company_address_sp,
       t.social_credit_code social_credit_code_tp,
       t.legal_representative,
       t.company_contact_person,
       t.company_contact_phone company_contact_phone_tp,
       t.memo,
       t.err_msg_id,
       m.msg
  FROM scmdata.t_supplier_info_temp t
  LEFT JOIN scmdata.t_supplier_info_import_msg m
    ON t.err_msg_id = m.msg_id
 WHERE t.company_id = %default_company_id%
   AND t.user_id = :user_id
   ORDER BY t.inside_supplier_code asc]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
v_supp_rec scmdata.t_supplier_info_temp%ROWTYPE;
BEGIN
  v_supp_rec.supplier_temp_id       := :supplier_temp_id;
  v_supp_rec.company_id             := %default_company_id%;
  v_supp_rec.user_id                := :user_id;
  v_supp_rec.inside_supplier_code   := :inside_supplier_code_sp;
  v_supp_rec.supplier_company_name  := :supplier_company_name;
  v_supp_rec.cooperation_type       := :cooperation_type_sp;
  v_supp_rec.company_city           := :company_city_sp;
  v_supp_rec.company_province       := :company_province_sp;
  v_supp_rec.company_county         := :company_county_sp;
  v_supp_rec.company_address        := :company_address_sp;
  v_supp_rec.social_credit_code     := :social_credit_code_tp;
  v_supp_rec.legal_representative   := :legal_representative;
  v_supp_rec.company_contact_person := :company_contact_person;
  v_supp_rec.company_contact_phone  := :company_contact_phone_tp;
  v_supp_rec.cooperation_type_code  := :cooperation_type_code;
  v_supp_rec.company_city_code      := :company_city_code;
  v_supp_rec.company_province_code  := :company_province_code;
  v_supp_rec.company_county_code    := :company_county_code;
  v_supp_rec.cooperation_model_code := :cooperation_model_code;
  v_supp_rec.cooperation_model      := :cooperation_model_sp;
v_supp_rec.memo:=:memo;
  scmdata.pkg_supplier_info.update_supplier_info_temp(p_supp_rec => v_supp_rec);
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_160_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_temp_id,company_id,user_id,err_msg_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_160_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_160_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_temp_id,company_id,user_id,err_msg_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/
  
BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
--基本信息
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.supplier_code,
       sp.social_credit_code,
       sp.legal_representative,
       sp.inside_supplier_code,
       sp.company_province company_province,
       sp.company_city company_city,
       sp.company_county company_county,
       province || city || county location_area,
       nvl(sp.company_address, fc.address) company_address_sp,
       sp.group_name,
       sp.area_group_leader,
       sp.company_contact_phone,
       sp.fa_contact_name,
       sp.fa_contact_phone,
       sp.company_type,
       --生产信息
       sp.product_type,
       sp.product_link,
       sp.brand_type,
       sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || sp.brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || sp.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc,
       sp.product_line,
       sp.product_line_num,
       sp.worker_num,
       sp.machine_num,
       sp.quality_step quality_step,
       sp.pattern_cap pattern_cap,
       sp.fabric_purchase_cap fabric_purchase_cap,
       sp.fabric_check_cap fabric_check_cap,
       sp.cost_step cost_step,
       decode(sp.reserve_capacity, NULL, '', sp.reserve_capacity || '%') reserve_capacity,
       decode(sp.product_efficiency, NULL, '', sp.product_efficiency || '%') product_efficiency,
       sp.work_hours_day,
       --合作信息
       sp.pause coop_state,
       nvl2(sp.supplier_company_id, '已注册', '未注册') regist_status_sp,
       decode(sp.bind_status, 1, '已绑定', '未绑定') bind_status_sq,
       sp.cooperation_type,
       sp.cooperation_model,
       sp.coop_position,
       --附件资料
       sp.certificate_file certificate_file_sp,
       sp.supplier_gate,
       sp.supplier_office,
       sp.supplier_site,
       sp.supplier_product,
       sp.file_remark,
       --其他
       sp.supplier_info_origin,
       sp.status
  FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.t_factory_ask fa
    ON sp.supplier_info_origin_id = fa.factory_ask_id
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = nvl(sp.company_province, fa.company_province)
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = nvl(sp.company_city, fa.company_city)
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = nvl(sp.company_county, fa.company_county)
  LEFT JOIN scmdata.sys_company fc
    ON fc.company_id = sp.supplier_company_id
 INNER JOIN group_dict ga
    ON sp.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = 'COOPERATION_TYPE'
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = 'COOPERATION_BRAND'
   AND gd.group_dict_value = sp.cooperation_brand
 WHERE sp.supplier_info_id = %ass_supplier_info_id%
   AND sp.company_id = %default_company_id%
]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN
    --来源为准入/手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%
     AND sp.status = 1;

  v_sql := ]' || q'['DECLARE
  v_sp_data t_supplier_info%ROWTYPE;
BEGIN
  --已建档数据
  v_sp_data.supplier_info_id := :supplier_info_id;
  v_sp_data.company_id       := :company_id;
  v_sp_data.status           := :status;
  v_sp_data.supplier_info_origin := ']' || '|| v_origin || ' || q'[' ;
  --来源为准入/手动新增 统一社会信用代码则 不可更改
  --基本信息
  v_sp_data.supplier_company_name         := :supplier_company_name;
  v_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  v_sp_data.legal_representative := :legal_representative;
  v_sp_data.inside_supplier_code := :inside_supplier_code;
  v_sp_data.company_province     := :company_province;
  v_sp_data.company_city         := :company_city;
  v_sp_data.company_county       := :company_county;
  v_sp_data.company_address      := :company_address_sp;
  --v_sp_data.group_name                    := :group_name;
  v_sp_data.company_contact_phone := :company_contact_phone;
  v_sp_data.fa_contact_name       := :fa_contact_name;
  v_sp_data.fa_contact_phone      := :fa_contact_phone;
  v_sp_data.company_type          := :company_type;
  --生产信息
  v_sp_data.product_type        := :product_type;
  v_sp_data.product_link        := :product_link;
  v_sp_data.brand_type          := :brand_type;
  v_sp_data.cooperation_brand   := :cooperation_brand;
  v_sp_data.product_line        := :product_line;
  v_sp_data.product_line_num    := :product_line_num;
  v_sp_data.worker_num          := :worker_num;
  v_sp_data.machine_num         := :machine_num;
  v_sp_data.quality_step        := :quality_step;
  v_sp_data.pattern_cap         := :pattern_cap;
  v_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  v_sp_data.fabric_check_cap    := :fabric_check_cap;
  v_sp_data.cost_step           := :cost_step;
  v_sp_data.reserve_capacity    := rtrim(:reserve_capacity,'%');
  v_sp_data.product_efficiency  := rtrim(:product_efficiency,'%');
  v_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  v_sp_data.pause               := :coop_state;
  --v_sp_data.cooperation_type  := :cooperation_type;
  v_sp_data.cooperation_model := :cooperation_model;
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
  v_sp_data.supplier_gate    := :supplier_gate;
  v_sp_data.supplier_office  := :supplier_office;
  v_sp_data.supplier_site    := :supplier_site;
  v_sp_data.supplier_product := :supplier_product;
  v_sp_data.company_say      := :company_say;
  v_sp_data.file_remark      := :file_remark;
  v_sp_data.update_id        := :user_id;
  v_sp_data.update_date      := SYSDATE;

  --1.更新=》保存，校验数据
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data,p_item_id => 'a_supp_161');
  --2.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => :supplier_info_id);
END;]'
|| q'['; 
@strresult := v_sql;
END; } ]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_161''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,province,city,county,company_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,BIND_STATUS,FA_BRAND_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_161''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_161'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,province,city,county,company_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,BIND_STATUS,FA_BRAND_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[--2020/12/9  供应商档案已建档-合作范围，去掉删除功能
/*DECLARE
BEGIN
DELETE FROM scmdata.t_supplier_shared t WHERE t.coop_scope_id = :coop_scope_id;

DELETE FROM t_coop_scope t WHERE t.coop_scope_id = :coop_scope_id;
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.create_id           := %user_id%;
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := :sharing_type;
  p_cp_data.publish_id          := '';
  p_cp_data.publish_date        := '';

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;

/*INSERT INTO t_coop_scope
  (coop_scope_id,
   supplier_info_id,
   company_id,
   --coop_mode,
   coop_classification,
   coop_product_cate,
   coop_subcategory,
   create_id,
   create_time,
   update_id,
   update_time,
   sharing_type)
VALUES
  (scmdata.f_get_uuid(),
   :supplier_info_id,
   %default_company_id%,
   --:coop_mode,
   :coop_classification,
   :coop_product_cate,
   :coop_subcategory,
   %user_id%,
   sysdate,
   %user_id%,
   sysdate,
   :sharing_type)*/]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT tc.pause,
       tc.coop_scope_id,
       tc.coop_classification,
       a.group_dict_name      coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name      coop_product_cate_desc,
       tc.coop_subcategory,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id = %default_company_id%
           AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) coop_subcategory_desc,
       tc.sharing_type,
       (SELECT listagg(fc.supplier_company_name, ';')
          FROM scmdata.t_supplier_shared ts, scmdata.t_supplier_info fc
         WHERE ts.supplier_info_id = tc.supplier_info_id
           AND ts.coop_scope_id = tc.coop_scope_id
           AND fc.supplier_code = ts.shared_supplier_code
           AND fc.company_id = tc.company_id) company_list
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
  LEFT JOIN scmdata.t_supplier_info sp
    ON tc.supplier_info_id = sp.supplier_info_id
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%



/*SELECT sp.coop_state,
       tc.coop_scope_id,
       tc.coop_classification,
       a.group_dict_name      coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name      PRODUCT_CATE_GD,
       tc.coop_subcategory,
       --c.company_dict_name coop_subcategory_desc,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id  = %default_company_id%
         AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) SMALL_CATEGORY_GD,
       --tc.coop_mode,
       tc.sharing_type,
       (SELECT listagg(fc.supplier_company_name, ';')
          FROM scmdata.t_supplier_shared ts, scmdata.t_supplier_info fc
         WHERE ts.supplier_info_id = tc.supplier_info_id
                   AND ts.coop_scope_id = tc.coop_scope_id
                   AND fc.supplier_code = ts.shared_supplier_code
                   and fc.company_id = tc.company_id) company_list
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
 LEFT JOIN scmdata.t_supplier_info sp
    ON tc.supplier_info_id = sp.supplier_info_id
WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.sharing_type        := :sharing_type;

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.update_coop_scope(p_cp_data => p_cp_data);
  END IF;

  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

  --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-修改合作范围','',%user_id%,%default_company_id%,SYSDATE);

END;

/*UPDATE t_coop_scope t
   SET --t.coop_mode           = :coop_mode,
       t.coop_classification = :coop_classification,
       t.coop_product_cate   = :coop_product_cate,
       t.coop_subcategory    = :coop_subcategory,
       t.update_id           = %user_id%,
       t.update_time         = SYSDATE,
       t.sharing_type        = :sharing_type
 WHERE t.company_id = %default_company_id%
   AND t.supplier_info_id = :supplier_info_id
   AND t.coop_scope_id = :coop_scope_id*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_161_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode,coop_state]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_161_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_161_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode,coop_state]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
BEGIN
 scmdata.pkg_supplier_info.delete_contract_info(p_contract_info_id => :contract_info_id);

 scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-删除合同','',%user_id%,%default_company_id%,SYSDATE);
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file,
         :contract_type,
         :contract_num,
         %user_id%,
         %user_id%
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file,
         p_contract_rec.contract_type,
         p_contract_rec.contract_num,
         p_contract_rec.operator_id,
         p_contract_rec.change_id
    FROM dual;
  scmdata.pkg_supplier_info.insert_contract_info(p_contract_rec => p_contract_rec);


/*DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file
    FROM dual;
  scmdata.pkg_supplier_info.insert_contract_info(p_contract_rec => p_contract_rec);*/
    --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-新增合同','',%user_id%,:company_id,SYSDATE);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT tc.contract_info_id,
       tc.supplier_info_id,
       tc.company_id,
       tc.contract_start_date,
       tc.contract_stop_date,
       tc.contract_sign_date,
       tc.contract_file contract_file_sp,
       tc.CONTRACT_TYPE,
       tc.contract_num,
       (SELECT MAX(NICK_NAME) FROM scmdata.sys_company_user td WHERE td.user_id = tc.operator_id ) AS OPERATOR_NAME,
       tc.OPERATE_TIME,
       (SELECT MAX(NICK_NAME) FROM scmdata.sys_company_user td WHERE td.user_id = tc.Change_Id ) AS CHANGE_NAME,
       TC.CHANGE_TIME
  FROM scmdata.t_contract_info tc
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%


/*SELECT tc.contract_info_id,
       tc.supplier_info_id,
       tc.company_id,
       tc.contract_start_date,
       tc.contract_stop_date,
       tc.contract_sign_date,
       tc.contract_file
  FROM scmdata.t_contract_info tc
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file,
         :contract_type,
         :contract_num,
         %user_id%,
         SYSDATE
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file,
         p_contract_rec.contract_type,
         p_contract_rec.contract_num,
         p_contract_rec.change_id,
         p_contract_rec.change_time
    FROM dual;
  scmdata.pkg_supplier_info.update_contract_info(p_contract_rec => p_contract_rec);
    --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-修改合同','',%user_id%,%default_company_id%,SYSDATE);
END;


/*DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file
    FROM dual;
  scmdata.pkg_supplier_info.update_contract_info(p_contract_rec => p_contract_rec);
  --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-修改合同','',%user_id%,%default_company_id%,SYSDATE);
END;*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_161_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[contract_info_id,supplier_info_id,company_id,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_161_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_161_3'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[contract_info_id,supplier_info_id,company_id,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT A.SP_RECORD_ID,
       A.SUPPLIER_INFO_ID,
       A.COMPANY_ID,
       A.KAOH_LIMIT,
       A.BUH_SVG_LIMIT,
       A.ORDER_CONTENT_RATE,
       A.ORDER_ONTIME_RATE,
       A.STORE_RETURN_RATE,
       A.SHOP_RETURN_RATE,
       A.QOUTE_RATE,
       A.RALE_QOUTE_RATE,
       A.CUSTOM_PRIOR,
       A.ACCOUNT_CAP,
       A.RESPONSE_QS
  FROM T_SUPPLIER_PERFORM A
  WHERE A.supplier_info_id = %ass_supplier_info_id%
   AND A.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_161_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[SP_RECORD_ID,SUPPLIER_INFO_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_161_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_161_6'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[SP_RECORD_ID,SUPPLIER_INFO_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[delete from t_coop_scope_temp where coop_scope_temp_id = :coop_scope_temp_id]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[declare
  p_id varchar2(32);
begin
  p_id := f_get_uuid();
  insert into t_coop_scope_temp
    (coop_scope_temp_id,
     company_id,
     supplier_company_name,
     coop_classification,
     coop_product_cate,
     coop_subcategory,
     msg_type,
     msg,
     coop_classification_desc,
     coop_product_cate_desc,
     coop_subcategory_desc,
     inside_supplier_code,
     create_id, sharing_type,
         sharing_type_desc,
         sharing_sup_code,
         sharing_sup_code_desc)
  values
    (p_id,
     %default_company_id%,
     :supplier_company_name,
     :COOP_CLASSIFICATION_NUM,
     :COOP_PRODUCT_CATE_NUM,
     :COOP_SUBCATEGORY_NUM,
     null,
     null,
     :coop_classification_desc,
     :coop_product_cate_desc,
     :COOP_SUBCATEGORY,
     :inside_supplier_code_sp,
     %user_id%,:sharing_type,
         :sharing_type_desc,
         :sharing_sup_code,
         :sharing_sup_code_desc);
  pkg_supplier_info.check_importdatas_coop_scope(p_coop_scope_temp_id => p_id);
end;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[select a.coop_scope_temp_id,
       a.inside_supplier_code inside_supplier_code_sp,
       a.supplier_company_name,
       a.coop_classification      COOP_CLASSIFICATION_NUM,
       a.coop_classification_desc,
       a.coop_product_cate        COOP_PRODUCT_CATE_NUM,
       a.coop_product_cate_desc,
       a.coop_subcategory         COOP_SUBCATEGORY_NUM,
       a.coop_subcategory_desc COOP_SUBCATEGORY,
       a.sharing_type,
         a.sharing_type_desc,
         a.sharing_sup_code,
         a.sharing_sup_code_desc,
         nvl(a.msg,'校验成功!')                      MSG
  from scmdata.t_coop_scope_temp a
  where a.company_id=%default_company_id%
  and a.create_id=:user_id]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[declare
begin
 update scmdata.t_coop_scope_temp a
    set a.inside_supplier_code     = :inside_supplier_code_sp,
        a.supplier_company_name    = :supplier_company_name,
        a.coop_classification      = :COOP_CLASSIFICATION_NUM,
        a.coop_classification_desc = :coop_classification_desc,
        a.coop_product_cate        = :COOP_PRODUCT_CATE_NUM,
        a.coop_product_cate_desc   = :coop_product_cate_desc,
        a.coop_subcategory         = :COOP_SUBCATEGORY_NUM,
        a.coop_subcategory_desc    = :COOP_SUBCATEGORY,
        a.sharing_type= :sharing_type,
         a.sharing_type_desc= :sharing_type_desc,
         a.sharing_sup_code= :sharing_sup_code,
         a.sharing_sup_code_desc= :sharing_sup_code_desc
  where a.coop_scope_temp_id = :coop_scope_temp_id;
  pkg_supplier_info.check_importdatas_coop_scope(p_coop_scope_temp_id => :coop_scope_temp_id);
end;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_170''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[COOP_SUBCATEGORY_NUM,COOP_PRODUCT_CATE_NUM,COOP_CLASSIFICATION_NUM,coop_scope_temp_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_170''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_170'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[COOP_SUBCATEGORY_NUM,COOP_PRODUCT_CATE_NUM,COOP_CLASSIFICATION_NUM,coop_scope_temp_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT *
  FROM (SELECT fa.factory_ask_id,
               fa.company_id,
               nvl((fr.check_date), '') check_date,
               fa.ask_address,
               fr.check_result check_fac_result,
               fr.check_report_file,
               fa.factory_ask_id supplier_info_origin_id,
               nvl(fr.admit_result, '') trialorder_type
          FROM scmdata.t_factory_ask fa
         INNER JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
         INNER JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id) v
 WHERE v.supplier_info_origin_id IN
       (SELECT sa.supplier_info_origin_id
          FROM scmdata.t_supplier_info sa
         WHERE sa.supplier_info_id = :supplier_info_id)
   AND v.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_171_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[factory_ask_id,company_id,supplier_info_origin_id,TRIALORDER_TYPE,CHECK_FAC_RESULT]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_171_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_171_2'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[factory_ask_id,company_id,supplier_info_origin_id,TRIALORDER_TYPE,CHECK_FAC_RESULT]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/
  
BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[--不考虑供应商是否已经在平台注册
DECLARE
  p_sp_data    scmdata.t_supplier_info%ROWTYPE;
  vo_group_name            VARCHAR2(32);
  vo_area_group_leader     VARCHAR2(32);
BEGIN

  p_sp_data.supplier_info_id := scmdata.pkg_plat_comm.f_getkeyid_plat('GY','seq_plat_code',99);
  p_sp_data.company_id       := %default_company_id%;
  --基本信息
  p_sp_data.supplier_company_name         := :supplier_company_name;
  p_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  --p_sp_data.supplier_code                 := :supplier_code;
  p_sp_data.inside_supplier_code          := :inside_supplier_code;
  p_sp_data.social_credit_code            := :social_credit_code;
  p_sp_data.legal_representative          := :legal_representative;
  p_sp_data.inside_supplier_code          := :inside_supplier_code;
  p_sp_data.company_province              := :company_province;
  p_sp_data.company_city                  := :company_city;
  p_sp_data.company_county                := :company_county;
  p_sp_data.company_address               := :company_address_sp;
  p_sp_data.group_name                    := :v_group_name;
  p_sp_data.company_contact_phone         := :company_contact_phone;
  p_sp_data.fa_contact_name               := :fa_contact_name;
  p_sp_data.fa_contact_phone              := :fa_contact_phone;
  p_sp_data.company_type                  := :company_type;
  --生产信息
  p_sp_data.product_type        := :product_type;
  p_sp_data.product_link        := :product_link;
  p_sp_data.brand_type          := :brand_type;
  p_sp_data.cooperation_brand   := :cooperation_brand;
  p_sp_data.product_line        := :product_line;
  p_sp_data.product_line_num    := :product_line_num;
  p_sp_data.worker_num          := :worker_num;
  p_sp_data.machine_num         := :machine_num;
  p_sp_data.quality_step        := :quality_step;
  p_sp_data.pattern_cap         := :pattern_cap;
  p_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  p_sp_data.fabric_check_cap    := :fabric_check_cap;
  p_sp_data.cost_step           := :cost_step;
  p_sp_data.reserve_capacity    := rtrim(:reserve_capacity,'%');
  p_sp_data.product_efficiency  := rtrim(:product_efficiency,'%');
  p_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  p_sp_data.pause               := :coop_state;
  p_sp_data.cooperation_model   := :cooperation_model;
  --平台注册状态
  --应用绑定状态
  p_sp_data.cooperation_type  := :cooperation_type;
  p_sp_data.cooperation_model := :cooperation_model;
  p_sp_data.coop_position     := :coop_position;
  --相关附件
  p_sp_data.certificate_file := :certificate_file_sp;
  p_sp_data.supplier_gate    := :supplier_gate;
  p_sp_data.supplier_office  := :supplier_office;
  p_sp_data.supplier_site    := :supplier_site;
  p_sp_data.supplier_product := :supplier_product;
  p_sp_data.file_remark      := :file_remark;

  p_sp_data.company_say          := :company_say;
  p_sp_data.create_id            := :user_id;
  p_sp_data.create_date          := SYSDATE;
  p_sp_data.supplier_info_origin := 'MA';
  p_sp_data.status               := 0;

  --1.新增 => 保存，校验数据
  scmdata.pkg_supplier_info.check_save_t_supplier_info(p_sp_data => p_sp_data);
  --2.插入数据
  scmdata.pkg_supplier_info.insert_supplier_info(p_sp_data => p_sp_data);
  --3.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => p_sp_data.supplier_info_id);

END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[SELECT scmdata.pkg_plat_comm.f_getkeyid_plat('GY', 'seq_plat_code', 99) AS supplier_info_id FROM dual]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:='--czh 重构代码
--过期时间 15分钟
{DECLARE
  v_select_sql VARCHAR2(8000);
BEGIN
  --基本信息
  v_select_sql :=' ||
        q'['WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
--基本信息
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.supplier_code,
       sp.social_credit_code,
       sp.legal_representative,
       sp.inside_supplier_code,
       sp.company_province company_province,
       sp.company_city company_city,
       sp.company_county company_county,
       province || city || county location_area,
       nvl(sp.company_address, fc.address) company_address_sp,
       --pkg_supplier_info.get_group_name(p_company_id => %default_company_id%,
       --p_supp_id    => sp.supplier_info_id) group_name,
       sp.group_name,
       sp.area_group_leader,
       sp.company_contact_phone,
       sp.fa_contact_name,
       sp.fa_contact_phone,
       sp.company_type,
       --生产信息
       sp.product_type,
       sp.product_link,
       sp.brand_type,
       sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, '';'') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = ''COOPERATION_BRAND''
           AND t.group_dict_id = b.parent_id
           AND instr('';'' || sp.brand_type || '';'',
                     '';'' || t.group_dict_value || '';'') > 0
           AND instr('';'' || sp.cooperation_brand || '';'',
                     '';'' || b.group_dict_value || '';'') > 0) cooperation_brand_desc,
       sp.product_line,
       sp.product_line_num,
       sp.worker_num,
       sp.machine_num,
       sp.quality_step,
       sp.pattern_cap,
       sp.fabric_purchase_cap,
       sp.fabric_check_cap,
       sp.cost_step,
       decode(sp.reserve_capacity, NULL, '''', sp.reserve_capacity || ''%'') reserve_capacity,
       decode(sp.product_efficiency, NULL, '''', sp.product_efficiency || ''%'') product_efficiency,
       sp.work_hours_day,
       --合作信息
       sp.pause coop_state,
       nvl2(sp.supplier_company_id, ''已注册'', ''未注册'') regist_status_sp,
       decode(sp.bind_status, 1, ''已绑定'', ''未绑定'') bind_status_sq,
       sp.cooperation_type,
       sp.cooperation_model,
       sp.coop_position,
       --附件资料
       sp.certificate_file certificate_file_sp,
       sp.supplier_gate,
       sp.supplier_office,
       sp.supplier_site,
       sp.supplier_product,
       sp.file_remark,
       --其他
       sp.supplier_info_origin,
       sp.status
  FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.t_factory_ask fa
    ON sp.supplier_info_origin_id = fa.factory_ask_id
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = nvl(sp.company_province, fa.company_province)
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = nvl(sp.company_city, fa.company_city)
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = nvl(sp.company_county, fa.company_county)
  LEFT JOIN scmdata.sys_company fc
    ON fc.company_id = sp.supplier_company_id
 INNER JOIN group_dict ga
    ON sp.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = ''COOPERATION_TYPE''
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''COOPERATION_BRAND''
   AND gd.group_dict_value = sp.cooperation_brand
 WHERE sp.company_id = %default_company_id%
   AND sp.create_id  = :user_id
   AND sp.supplier_info_origin = ''MA''
   AND sp.status = 0
   AND (ceil(TO_NUMBER(SYSDATE - sp.create_date)*(24*60)) <= 15 or ceil(TO_NUMBER(SYSDATE - sp.update_date)*(24*60)) <= 15)
 ORDER BY sp.create_date DESC, sp.update_date DESC ']' || q'[;
:strresult := v_select_sql;
END; } ]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:='{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN
  --来源为手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%
     AND sp.status = 0;

  v_sql := ''' || 'DECLARE
  v_sp_data t_supplier_info%ROWTYPE;
BEGIN
  --待建档数据
  v_sp_data.supplier_info_id := :supplier_info_id;
  v_sp_data.company_id       := :company_id;
  v_sp_data.status           := :status;
  v_sp_data.supplier_info_origin := ''' || '|| v_origin ||' || q'[' ;
  --来源为a_supp_171-手动新增 则供应商名称、简称和统一社会信用代码 可更改

  --基本信息
  v_sp_data.supplier_company_name         := :supplier_company_name;
  v_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  v_sp_data.social_credit_code            := :social_credit_code;
  v_sp_data.legal_representative := :legal_representative;
  v_sp_data.inside_supplier_code := :inside_supplier_code;
  v_sp_data.company_province     := :company_province;
  v_sp_data.company_city         := :company_city;
  v_sp_data.company_county       := :company_county;
  v_sp_data.company_address      := :company_address_sp;
  --v_sp_data.group_name                    := :group_name;
  v_sp_data.company_contact_phone := :company_contact_phone;
  v_sp_data.fa_contact_name       := :fa_contact_name;
  v_sp_data.fa_contact_phone      := :fa_contact_phone;
  v_sp_data.company_type          := :company_type;
  --生产信息
  v_sp_data.product_type        := :product_type;
  v_sp_data.product_link        := :product_link;
  v_sp_data.brand_type          := :brand_type;
  v_sp_data.cooperation_brand   := :cooperation_brand;
  v_sp_data.product_line        := :product_line;
  v_sp_data.product_line_num    := :product_line_num;
  v_sp_data.worker_num          := :worker_num;
  v_sp_data.machine_num         := :machine_num;
  v_sp_data.quality_step        := :quality_step;
  v_sp_data.pattern_cap         := :pattern_cap;
  v_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  v_sp_data.fabric_check_cap    := :fabric_check_cap;
  v_sp_data.cost_step           := :cost_step;
  v_sp_data.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  v_sp_data.product_efficiency  := rtrim(:product_efficiency,''%'');
  v_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  v_sp_data.pause               := :coop_state;
  --v_sp_data.cooperation_type  := :cooperation_type;
  v_sp_data.cooperation_model := :cooperation_model;
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
  v_sp_data.supplier_gate    := :supplier_gate;
  v_sp_data.supplier_office  := :supplier_office;
  v_sp_data.supplier_site    := :supplier_site;
  v_sp_data.supplier_product := :supplier_product;
  v_sp_data.company_say      := :company_say;
  v_sp_data.file_remark      := :file_remark;
  v_sp_data.update_id        := :user_id;
  v_sp_data.update_date      := SYSDATE;

  --1.更新=》保存，校验数据
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data);
  --2.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => :supplier_info_id);
END;]' || q'[';
  @strresult := v_sql;
END;}]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_171''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,cooperation_classification,cooperation_subcategory,taxpayer,cooperation_method,cooperation_model,company_type,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_171''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_171'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[supplier_info_id,company_id,supplier_info_origin_id,cooperation_classification,cooperation_subcategory,taxpayer,cooperation_method,cooperation_model,company_type,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;

  scmdata.pkg_supplier_info.delete_coop_scope(p_cp_data => p_cp_data);
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;

/*DECLARE
BEGIN
DELETE FROM scmdata.t_supplier_shared t WHERE t.coop_scope_id = :coop_scope_id;

DELETE FROM t_coop_scope t WHERE t.coop_scope_id = :coop_scope_id;
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.create_id           := %user_id%;
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := :sharing_type;
  p_cp_data.publish_id          := '';
  p_cp_data.publish_date        := '';

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;

/*INSERT INTO t_coop_scope
  (coop_scope_id,
   supplier_info_id,
   company_id,
   --coop_mode,
   coop_classification,
   coop_product_cate,
   coop_subcategory,
   create_id,
   create_time,
   update_id,
   update_time,
   sharing_type)
VALUES
  (scmdata.f_get_uuid(),
   :supplier_info_id,
   %default_company_id%,
   --:coop_mode,
   :coop_classification,
   :coop_product_cate,
   :coop_subcategory,
   %user_id%,
   sysdate,
   %user_id%,
   sysdate,
   :sharing_type)*/]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT sp.coop_state,
       tc.coop_scope_id,
       tc.coop_classification,
       a.group_dict_name      coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name      coop_product_cate_desc,
       tc.coop_subcategory,
       --c.company_dict_name coop_subcategory_desc,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id  = %default_company_id%
         AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) coop_subcategory_desc,
       --tc.coop_mode,
       tc.sharing_type,
       (SELECT listagg(fc.supplier_company_name, ';')
          FROM scmdata.t_supplier_shared ts, scmdata.t_supplier_info fc
         WHERE ts.supplier_info_id = tc.supplier_info_id
                   AND ts.coop_scope_id = tc.coop_scope_id
                   AND fc.supplier_code = ts.shared_supplier_code
                   and fc.company_id = tc.company_id) company_list
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
 LEFT JOIN scmdata.t_supplier_info sp
    ON tc.supplier_info_id = sp.supplier_info_id
WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%

/*SELECT sp.coop_state,
       tc.coop_scope_id,
       tc.coop_classification,
       a.group_dict_name      coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name      PRODUCT_CATE_GD,
       tc.coop_subcategory,
       --c.company_dict_name coop_subcategory_desc,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id  = %default_company_id%
         AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) SMALL_CATEGORY_GD,
       --tc.coop_mode,
       tc.sharing_type,
       (SELECT listagg(fc.supplier_company_name, ';')
          FROM scmdata.t_supplier_shared ts, scmdata.t_supplier_info fc
         WHERE ts.supplier_info_id = tc.supplier_info_id
                   AND ts.coop_scope_id = tc.coop_scope_id
                   AND fc.supplier_code = ts.shared_supplier_code
                   and fc.company_id = tc.company_id) company_list
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
 LEFT JOIN scmdata.t_supplier_info sp
    ON tc.supplier_info_id = sp.supplier_info_id
WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.sharing_type        := :sharing_type;

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.update_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --更新所在分组，区域组长
  pkg_supplier_info.update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);

END;

/*UPDATE t_coop_scope t
   SET --t.coop_mode           = :coop_mode,
       t.coop_classification = :coop_classification,
       t.coop_product_cate   = :coop_product_cate,
       t.coop_subcategory    = :coop_subcategory,
       t.update_id           = %user_id%,
       t.update_time         = SYSDATE,
       t.sharing_type        = :sharing_type
 WHERE t.company_id = %default_company_id%
   AND t.supplier_info_id = :supplier_info_id
   AND t.coop_scope_id = :coop_scope_id*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_171_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode,coop_state]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_171_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_171_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[coop_scope_id,sharing_type,coop_classification,coop_product_cate,coop_subcategory,coop_mode,coop_state]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[call scmdata.pkg_supplier_info.delete_contract_info(p_contract_info_id => :contract_info_id)]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file,
         :contract_type,
         :contract_num,
         %user_id%,
         %user_id%
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file,
         p_contract_rec.contract_type,
         p_contract_rec.contract_num,
         p_contract_rec.operator_id,
         p_contract_rec.change_id
    FROM dual;
  scmdata.pkg_supplier_info.insert_contract_info(p_contract_rec => p_contract_rec);
END;

/*DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file
    FROM dual;
  scmdata.pkg_supplier_info.insert_contract_info(p_contract_rec => p_contract_rec);
END;*/]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT tc.contract_info_id,
       tc.supplier_info_id,
       tc.company_id,
       tc.contract_start_date,
       tc.contract_stop_date,
       tc.contract_sign_date,
       tc.contract_file contract_file_sp,
       tc.CONTRACT_TYPE,
       tc.contract_num,
       (SELECT MAX(NICK_NAME) FROM scmdata.sys_company_user td WHERE td.user_id = tc.operator_id ) AS OPERATOR_NAME,
       tc.OPERATE_TIME,
       (SELECT MAX(NICK_NAME) FROM scmdata.sys_company_user td WHERE td.user_id = tc.Change_Id ) AS CHANGE_NAME,
       TC.CHANGE_TIME
  FROM scmdata.t_contract_info tc
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%

/*SELECT tc.contract_info_id,
       tc.supplier_info_id,
       tc.company_id,
       tc.contract_start_date,
       tc.contract_stop_date,
       tc.contract_sign_date,
       tc.contract_file
  FROM scmdata.t_contract_info tc
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file,
         :contract_type,
         :contract_num,
         %user_id%,
         SYSDATE
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file,
         p_contract_rec.contract_type,
         p_contract_rec.contract_num,
         p_contract_rec.change_id,
         p_contract_rec.change_time
    FROM dual;
  scmdata.pkg_supplier_info.update_contract_info(p_contract_rec => p_contract_rec);
END;


/*DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file
    FROM dual;
  scmdata.pkg_supplier_info.update_contract_info(p_contract_rec => p_contract_rec);
END;*/]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_171_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[contract_info_id,supplier_info_id,company_id,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_171_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_171_3'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[contract_info_id,supplier_info_id,company_id,CONTRACT_TYPE]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT A.SP_RECORD_ID,
       A.SUPPLIER_INFO_ID,
       A.COMPANY_ID,
       A.KAOH_LIMIT,
       A.BUH_SVG_LIMIT,
       A.ORDER_CONTENT_RATE,
       A.ORDER_ONTIME_RATE,
       A.STORE_RETURN_RATE,
       A.SHOP_RETURN_RATE,
       A.QOUTE_RATE,
       A.RALE_QOUTE_RATE,
       A.CUSTOM_PRIOR,
       A.ACCOUNT_CAP,
       A.RESPONSE_QS
  FROM T_SUPPLIER_PERFORM A
  WHERE A.supplier_info_id = %ass_supplier_info_id%
   AND A.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_supp_171_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[SP_RECORD_ID,SUPPLIER_INFO_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_supp_171_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_supp_171_6'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[SP_RECORD_ID,SUPPLIER_INFO_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--增加归属企业
SELECT u.user_id,
       u.pause,
       (SELECT listagg(gr.group_role_name, ';') within GROUP(ORDER BY gr.create_time)
          FROM scmdata.sys_group_user_role ur, scmdata.sys_group_role gr
         WHERE u.user_id = ur.user_id
           AND ur.group_role_id = gr.group_role_id) group_role_name_desc,
       u.avatar,
       u.nick_name,
       u.user_account,
       (SELECT listagg(b.logn_name, ';') within GROUP(ORDER BY 1)
          FROM scmdata.sys_user_company a
          LEFT JOIN scmdata.sys_company b
            ON a.company_id = b.company_id
         WHERE a.user_id = u.user_id
           AND b.pause = 0) user_logn_name, --add by czh
       dp.province || dc.city || dy.county city,
       u.sex,
       u.birthday,
       u.create_time create_time
  FROM scmdata.sys_user u
  LEFT JOIN scmdata.dic_province dp
    ON u.province = dp.provinceid
  LEFT JOIN scmdata.dic_city dc
    ON u.province = dc.provinceid
   AND u.city = dc.cityno
  LEFT JOIN scmdata.dic_county dy
    ON u.city = dy.cityno
   AND u.county = dy.countyid
 ORDER BY u.create_time ASC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''g_501''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[user_id,user_role_id,pause]'',,0,q''[]'',q''[]'',q''[]'',,q''[group_role_name_desc,nick_name,user_account,user_logn_name]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''g_501''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''g_501'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[user_id,user_role_id,pause]'',,0,q''[]'',q''[]'',q''[]'',,q''[group_role_name_desc,nick_name,user_account,user_logn_name]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[/*select u.user_id,
       u.pause,
       --decode(u.user_type,'admin','管理员','user','用户') user_type,
       (select listagg(gr.group_role_name, ';') within group(order by gr.create_time)
          from --scmdata.sys_user            u,
               scmdata.SYS_GROUP_USER_ROLE ur,
               scmdata.SYS_GROUP_ROLE      gr
         where u.user_id = ur.user_id
           and ur.group_role_id = gr.group_role_id
        /*and u.user_account = %CurrentUserID%*/
        ) group_role_name_desc,
       u.avatar,
       u.nick_name,
       u.user_account,
       u.city,
       u.sex,
       u.birthday,
       to_char(u.create_time,'YYYY-MM-DD') create_time
  from scmdata.sys_user u
  where u.user_id = %ASS_user_id%  */

 select u.user_id,
        u.user_account,
        u.avatar,
        u.nick_name,
        u.city,
        u.sex,
        u.birthday,
        to_char(u.create_time, 'YYYY-MM-DD') create_time,
        --u.login_time
        (select max(a.create_time)
           from SYS_LOGIN_RECORD a
          where a.create_time > sysdate - 7
            and a.login_success = 1
            and user_id = u.user_account) last_login_time
from scmdata.sys_user u
  where u.user_id = %ASS_user_id%                                         ]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''g_502''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[user_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''g_502''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''g_502'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[user_id]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',0,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH DIC AS
 (SELECT GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE
    FROM SCMDATA.SYS_GROUP_DICT)
SELECT (CASE
         WHEN TAR.COLLECTION = 1 THEN
          '收藏'
       END) COLLECTION,
       TAR.COOR_ASK_FLOW_STATUS,
       TAR.CREATE_DATE COOP_APPLY_DATE,
       TAR.COMPANY_NAME ASK_COMPANY_NAME,
       (SELECT LISTAGG(Y.GROUP_DICT_NAME, ';')
          FROM (SELECT DISTINCT COOPERATION_CLASSIFICATION TMP
                  FROM SCMDATA.T_ASK_SCOPE
                 WHERE OBJECT_ID = TAR.ASK_RECORD_ID
                   AND COMPANY_ID = DECODE(TAR.ORIGIN,
                                           'MA',
                                           TAR.BE_COMPANY_ID,
                                           TAR.COMPANY_ID)) Z
         INNER JOIN DIC Y
            ON Z.TMP = Y.GROUP_DICT_VALUE
           AND Y.GROUP_DICT_TYPE = 'PRODUCT_TYPE') COOPERATION_CLASSIFICATION_DESC,
       TAR.COOPERATION_MODEL,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE TAR.COOPERATION_MODEL = GROUP_DICT_VALUE
           AND GROUP_DICT_TYPE = 'SUPPLY_TYPE') COOPERATION_MODEL_DESC,
       SUBSTR(STATUS, 1, INSTR(STATUS, '+') - 1) FLOW_NODE_NAME,
       SUBSTR(STATUS, INSTR(STATUS, '+') + 1, LENGTH(STATUS)) FLOW_NODE_STATUS_DESC,
       SAPPLY_USER,
       SAPPLY_PHONE,
       (SELECT LISTAGG(W.GROUP_DICT_NAME, ';')
          FROM (SELECT DISTINCT COOPERATION_TYPE TMP
                  FROM SCMDATA.T_ASK_SCOPE
                 WHERE OBJECT_ID = TAR.ASK_RECORD_ID) X
         INNER JOIN DIC W
            ON X.TMP = W.GROUP_DICT_VALUE
           AND W.GROUP_DICT_TYPE = 'COOPERATION_TYPE') COOPERATION_TYPE_DESC,
       TAR.COMPANY_ADDRESS,
       (SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE COMPANY_ID =
               DECODE(TAR.ORIGIN, 'MA', TAR.BE_COMPANY_ID, TAR.COMPANY_ID)
           AND USER_ID = TAR.CREATE_ID) CREATOR,
       TAR.CREATE_DATE CREATE_TIME,
       TAR.ASK_RECORD_ID,
       TAR.ASK_USER_ID,
       TAR.COMPANY_ID,
       TAR.ASK_SAY, --合作申请说明
       CERTIFICATE_FILE, --营业执照
       case
         when status like '%待审核%' then
          'icon-renliziyuanxinxiguanlixitong (81)'
         when status like '%不通过%' then
          'icon-renliziyuanxinxiguanlixitong (24)'
         else
          'icon-feiyongshezhi2'
       end status_desc
  FROM (SELECT A.*,
               (SELECT GROUP_DICT_NAME
                  FROM DIC
                 WHERE GROUP_DICT_TYPE = 'FACTORY_ASK_FLOW'
                   AND GROUP_DICT_VALUE =
                       NVL((SELECT STATUS_AF_OPER
                             FROM (SELECT STATUS_AF_OPER
                                     FROM SCMDATA.T_FACTORY_ASK_OPER_LOG
                                    WHERE ASK_RECORD_ID = A.ASK_RECORD_ID
                                    ORDER BY OPER_TIME DESC)
                            WHERE ROWNUM < 2),
                           A.COOR_ASK_FLOW_STATUS)) STATUS
          FROM SCMDATA.T_ASK_RECORD A
         WHERE BE_COMPANY_ID = %DEFAULT_COMPANY_ID%) TAR
 order by TAR.CREATE_DATE desc]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''test_fl_new_list''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,COOR_ASK_FLOW_STATUS,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_MODEL,PRODUCTION_MODE,BE_COMPANY_ID,ASK_USER_ID,COMPANY_ID,FACTORY_ASK_ID,COOPERATION_PRODUCT_CATE]'',,0,q''[]'',q''[]'',q''[]'',,q''[ASK_COMPANY_NAME]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''test_fl_new_list''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT ,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''test_fl_new_list'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ASK_RECORD_ID,COOR_ASK_FLOW_STATUS,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,COOPERATION_MODEL,PRODUCTION_MODE,BE_COMPANY_ID,ASK_USER_ID,COMPANY_ID,FACTORY_ASK_ID,COOPERATION_PRODUCT_CATE]'',,0,q''[]'',q''[]'',q''[]'',,q''[ASK_COMPANY_NAME]'',13,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

