???prompt Importing table bw3.sys_item_list...
set feedback off
set define off
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_check_101_1', 0, null, null, null, 'SELECT SCMDATA.PKG_PLAT_COMM.F_GETKEYID_PLAT(''CR'', ''seq_cr'', 99) FACTORY_REPORT_ID FROM DUAL', '--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_check_factory_base();
  @strresult := v_sql;
END;}

--原有逻辑
/*SELECT (SELECT LOGN_NAME
          FROM SCMDATA.SYS_COMPANY
         WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%) CHECK_COMPANY_NAME,
			 (SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE COMPANY_ID = TFR.COMPANY_ID
           AND USER_ID = %CURRENT_USERID%) CHECK_USERNAME,
       (SELECT PHONE FROM SCMDATA.SYS_USER WHERE USER_ID = %CURRENT_USERID%) CHECK_PHONE,
       TFR.CHECK_REPORT_FILE,
       TFR.CHECK_SAY,
       TFR.CHECK_RESULT,
       TFA.FACTORY_ASK_TYPE,
       '''' FACTORY_ASK_TYPE_DESC,
       NVL(TFR.CHECK_DATE,SYSDATE) CHECK_DATE,
       TFR.FACTORY_REPORT_ID
  FROM (SELECT FACTORY_ASK_ID,
               FACTORY_REPORT_ID,
							 CHECK_USER_ID,
               CHECK_SAY,
               COMPANY_ID,
               CHECK_RESULT,
               CHECK_DATE,
               CHECK_REPORT_FILE
          FROM SCMDATA.T_FACTORY_REPORT
         WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID) TFR
  LEFT JOIN SCMDATA.T_FACTORY_ASK TFA
    ON TFR.FACTORY_ASK_ID = TFA.FACTORY_ASK_ID*/', null, null, null, 'DECLARE
  p_fac_rec scmdata.t_factory_report%ROWTYPE;
BEGIN
  p_fac_rec.factory_report_id   := :factory_report_id;
  p_fac_rec.product_line        := :product_line;
  p_fac_rec.product_line_num    := :product_line_num;
  p_fac_rec.worker_num          := :worker_num;
  p_fac_rec.machine_num         := :machine_num;
  p_fac_rec.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  p_fac_rec.product_efficiency  := rtrim(:product_efficiency,''%'');
  p_fac_rec.work_hours_day      := :work_hours_day;
  p_fac_rec.quality_step        := :quality_step;
  p_fac_rec.pattern_cap         := :pattern_cap;
  p_fac_rec.fabric_purchase_cap := :fabric_purchase_cap;
  p_fac_rec.fabric_check_cap    := :fabric_check_cap;
  p_fac_rec.cost_step           := :cost_step;
  p_fac_rec.check_person1       := :check_person1;
  p_fac_rec.check_person1_phone := :check_person1_phone;
  p_fac_rec.check_person2       := :check_person2;
  p_fac_rec.check_person2_phone := :check_person2_phone;
  p_fac_rec.check_say           := :check_say;
  p_fac_rec.check_result        := :CHECK_FAC_RESULT;
  p_fac_rec.check_date          := :check_date;
  p_fac_rec.update_id           := :user_id;
  p_fac_rec.update_date         := SYSDATE;
  p_fac_rec.remarks             := :remarks;

  scmdata.pkg_ask_record_mange.p_update_check_factory_report(p_fac_rec => p_fac_rec,p_type => 0);
END;

--原逻辑
/*DECLARE

BEGIN
  IF LENGTHB(:CHECK_REPORT_FILE) > 256 THEN
    RAISE_APPLICATION_ERROR(-20002, ''最多只可上传7个附件！'');
  END IF;

  UPDATE SCMDATA.T_FACTORY_REPORT
     SET CHECK_REPORT_FILE = :CHECK_REPORT_FILE,
         CHECK_SAY         = :CHECK_SAY,
         CHECK_RESULT      = :CHECK_RESULT,
         CHECK_DATE        = :CHECK_DATE,
         UPDATE_ID         = %CURRENT_USERID%,
         UPDATE_DATE       = SYSDATE
   WHERE FACTORY_REPORT_ID = :FACTORY_REPORT_ID;

END;*/', null, 'FACTORY_REPORT_ID,FACTORY_ASK_ID,COOPERATION_METHOD,COOPERATION_MODEL,PRODUCTION_MODE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY,CHECK_METHOD,COOPERATION_TYPE,rela_supplier_id,company_type,cooperation_brand,product_link,product_type,is_urgent,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,CHECK_FAC_RESULT,check_person1,check_person2', null, null, null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

prompt Done.
