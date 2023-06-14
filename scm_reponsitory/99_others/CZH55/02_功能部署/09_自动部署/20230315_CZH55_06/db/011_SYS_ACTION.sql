BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^call pkg_supplier_info.SUBMIT_T_CONTRACT_INFO(p_company_id => %default_company_id%, p_user_id =>%user_id% )^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_180_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_180_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_supp_180_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^
DECLARE
  v_flw_order     VARCHAR2(4000);
  v_reason        VARCHAR2(256);
  v_gendan_name_n VARCHAR2(256);
  v_old_gendan    VARCHAR2(4000);
  vo_log_id       VARCHAR2(32);
BEGIN
  --跟单员
  v_flw_order := ^'|| CHR(64) ||q'^flw_order^'|| CHR(64) ||q'^;


  FOR i IN (SELECT t.supplier_info_id, t.gendan_perid
              FROM scmdata.t_supplier_info t
             WHERE t.supplier_info_id IN (%selection%)
               AND t.company_id = %default_company_id%) LOOP

    --更新进表
    UPDATE scmdata.t_supplier_info t
       SET t.gendan_perid = v_flw_order,
           t.update_id    = :user_id,
           t.update_date  = sysdate
     WHERE t.supplier_info_id = i.supplier_info_id;

  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[指派跟单员]'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[指派跟单员]'',''action_a_supp_160_5'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^
DECLARE
  v_flw_order     VARCHAR2(4000);
  v_reason        VARCHAR2(256);
  v_gendan_name_n VARCHAR2(256);
  v_old_gendan    VARCHAR2(4000);
  vo_log_id       VARCHAR2(32);
BEGIN
  --跟单员
  v_flw_order := ^'|| CHR(64) ||q'^flw_order^'|| CHR(64) ||q'^;


  FOR i IN (SELECT t.supplier_info_id, t.gendan_perid
              FROM scmdata.t_supplier_info t
             WHERE t.supplier_info_id IN (%selection%)
               AND t.company_id = %default_company_id%) LOOP

    --更新进表
    UPDATE scmdata.t_supplier_info t
       SET t.gendan_perid = v_flw_order,
           t.update_id    = :user_id,
           t.update_date  = sysdate
     WHERE t.supplier_info_id = i.supplier_info_id;

  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[指派跟单员]'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[指派跟单员]'',''action_a_supp_160_5'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^call sf_supplier_info_pkg.submit_t_supplier_info(p_supplier_info_id => :supplier_info_id,
                                                 p_default_company_id => %default_company_id%,
                                                 p_user_id => %user_id%)^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_111_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_111_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_supp_111_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  p_status_af_oper  VARCHAR2(32);
  p_msg             VARCHAR2(256);
  p_ask_user        VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32) := ^'|| CHR(64) ||q'^is_trialorder^'|| CHR(64) ||q'^;
  p_trialorder_type VARCHAR2(32) := ^'|| CHR(64) ||q'^trialorder_type^'|| CHR(64) ||q'^;
  v_company_name    VARCHAR2(256);
  v_factrory_ask_flow_status VARCHAR2(32);
  v_factory_ask_type VARCHAR2(32);
BEGIN
  SELECT MAX(t.factrory_ask_flow_status), MAX(t.factory_ask_type)
    INTO v_factrory_ask_flow_status, v_factory_ask_type
    FROM scmdata.t_factory_ask t
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF v_factrory_ask_flow_status = 'FA12' THEN
    p_status_af_oper := 'FA22';
  ELSIF v_factrory_ask_flow_status = 'FA31' THEN
    p_status_af_oper := 'FA32';
  ELSE
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS NULL THEN
    raise_application_error(-20002, '试单时，试单模式必填！');
  ELSIF p_is_trialorder = 0 AND p_trialorder_type IS NOT NULL THEN
    raise_application_error(-20002, '试单模式无需填写！');
  ELSIF v_factory_ask_type IS NOT NULL AND v_factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;

  --生成档案
  pkg_supplier_info.p_create_t_supplier_info(p_company_id      => %default_company_id%,
                                             p_factory_ask_id  => :factory_ask_id,
                                             p_user_id         => :user_id,
                                             p_is_trialorder   => p_is_trialorder,
                                             p_trialorder_type => p_trialorder_type);

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_ask_record_id    => NULL, --合作申请单ID
                                                               p_flow_oper_status => 'AGREE', --流程操作方式编码
                                                               p_flow_af_status   => p_status_af_oper, --操作后流程状态
                                                               p_memo             => ^'|| CHR(64) ||q'^audit_comment_sp^'|| CHR(64) ||q'^);

  --lsl add 20230116
  --个人企微消息推送
  SELECT company_name
    INTO v_company_name
    FROM scmdata.t_factory_ask
   WHERE factory_ask_id = :factory_ask_id;
  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FA_AGREE_00',
                                                        v_user_id      => '',
                                                        v_type         => 1);
  --lsl end
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^select 1 from dual^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_311''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[同意准入]'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_311''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[同意准入]'',''action_a_coop_311'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE

BEGIN
  UPDATE SCMDATA.T_QA_SCOPE
     SET COMMIT_TYPE = 'PC'
   WHERE QA_REPORT_ID IN (^'|| CHR(64) ||q'^SELECTION^'|| CHR(64) ||q'^);

  UPDATE SCMDATA.T_QA_REPORT
     SET COMFIRM_RESULT = NULL,
         STATUS = 'N_PCF',
         COMFIRM_MEMO = '测试'
   WHERE QA_REPORT_ID IN (^'|| CHR(64) ||q'^SELECTION^'|| CHR(64) ||q'^);
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_error_btn''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[单据状态回退]'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,2,q''[QA_REPORT_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_error_btn''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[单据状态回退]'',''action_error_btn'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,2,q''[QA_REPORT_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^delete from scmdata.t_coop_scope_temp a where a.company_id=%default_company_id% and a.create_id=%user_id%^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_170_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[重置]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_170_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[重置]'',''action_a_supp_170_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^declare
  v_company_name  varchar2(256);
  v_check_user_id varchar2(256);
begin
  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => 'BACK', --流程操作方式编码
                                                               p_flow_af_status   => 'FA11', --操作后流程状态
                                                               p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
---lsl add 20230114 (验厂管理9.10版)消息推送
  select max(company_name) , max(check_user_id)
    into v_company_name, v_check_user_id
    from scmdata.t_factory_report
   where factory_report_id = :factory_report_id;
  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FR_AUDIT_01',
                                                        v_user_id      => v_check_user_id,
                                                        v_type         => 0);
--lsl add
end;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_102_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[驳回]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_102_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[驳回]'',''action_a_check_102_3'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^/*DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (^'|| CHR(64) ||q'^selection)) LOOP

    v_supplier_info_id := supplier_info_rec.supplier_info_id;
    sf_supplier_info_pkg.update_supplier_info_status(p_supplier_info_id => v_supplier_info_id,
                                                     p_status           => 0);

  END LOOP;

END;*/
--修改：启用、停用增加输入原因
DECLARE
  v_user_id VARCHAR2(100);
BEGIN

  SELECT t.nick_name
  INTO v_user_id
    FROM scmdata.sys_user t
   WHERE t.user_id = :user_id;

  sf_supplier_info_pkg.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                   p_reason           => ^'|| CHR(64) ||q'^U_REASON_SP^'|| CHR(64) ||q'^,
                                                   p_status           => 0,
                                                   p_user_id          => v_user_id,
                                                   p_company_id       => %default_company_id%);

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_120_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[启用]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_120_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[启用]'',''action_a_supp_120_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  p_trialorder_type VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32);
  p_audit_comment   VARCHAR2(256);
  v_company_name    VARCHAR2(256);
BEGIN
  p_is_trialorder   := ^'|| CHR(64) ||q'^is_trialorder^'|| CHR(64) ||q'^;
  p_trialorder_type := ^'|| CHR(64) ||q'^trialorder_type^'|| CHR(64) ||q'^;
  p_audit_comment   := ^'|| CHR(64) ||q'^audit_comment_sp^'|| CHR(64) ||q'^;

  IF p_is_trialorder = 0 THEN
    IF p_trialorder_type IS NOT NULL THEN
      raise_application_error(-20002, '不试单时，试单模式无需填写！');
    ELSE
      NULL;
    END IF;
  ELSIF p_is_trialorder = 1 THEN
    IF p_trialorder_type IS  NULL THEN
      raise_application_error(-20002, '试单时，试单模式必填！');
    ELSE
      NULL;
    END IF;
  END IF;

  UPDATE scmdata.t_factory_report t
     SET t.is_trialorder          = p_is_trialorder,
         t.trialorder_type        = p_trialorder_type,
         t.audit_comment          = p_audit_comment,
         t.factory_result_suggest = CASE
                                      WHEN p_is_trialorder = 1 THEN
                                       (SELECT t.group_dict_name
                                          FROM scmdata.sys_group_dict t
                                         WHERE t.group_dict_type =
                                               'TRIALORDER_TYPE'
                                           AND t.group_dict_value =
                                               p_trialorder_type)
                                      ELSE
                                       '通过'
                                    END
   WHERE t.factory_report_id = :factory_report_id;

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => 'AGREE', --流程操作方式编码
                                                               p_flow_af_status   => 'FA12', --操作后流程状态
                                                               p_memo             => p_audit_comment);

---lsl add 20230114 (验厂管理9.10版)消息推送
  SELECT max(company_name)
    INTO v_company_name
    FROM scmdata.t_factory_report
   WHERE factory_report_id = :factory_report_id;
  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FR_AUDIT_00',
                                                        v_user_id      => '',
                                                        v_type         => 1);
---end lsl

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[通过]'',q''[]'',q''[icon-morencaidan]'',1,0,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[通过]'',''action_a_check_102_1'',q''[]'',q''[icon-morencaidan]'',1,0,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  p_trialorder_type VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32);
  p_audit_comment   VARCHAR2(256);
  v_company_name    VARCHAR2(256);
BEGIN
  p_is_trialorder   := ^'|| CHR(64) ||q'^is_trialorder^'|| CHR(64) ||q'^;
  p_trialorder_type := ^'|| CHR(64) ||q'^trialorder_type^'|| CHR(64) ||q'^;
  p_audit_comment   := ^'|| CHR(64) ||q'^audit_comment_sp^'|| CHR(64) ||q'^;

  IF p_is_trialorder = 0 THEN
    IF p_trialorder_type IS NOT NULL THEN
      raise_application_error(-20002, '不试单时，试单模式无需填写！');
    ELSE
      NULL;
    END IF;
  ELSIF p_is_trialorder = 1 THEN
    IF p_trialorder_type IS  NULL THEN
      raise_application_error(-20002, '试单时，试单模式必填！');
    ELSE
      NULL;
    END IF;
  END IF;

  UPDATE scmdata.t_factory_report t
     SET t.is_trialorder          = p_is_trialorder,
         t.trialorder_type        = p_trialorder_type,
         t.audit_comment          = p_audit_comment,
         t.factory_result_suggest = CASE
                                      WHEN p_is_trialorder = 1 THEN
                                       (SELECT t.group_dict_name
                                          FROM scmdata.sys_group_dict t
                                         WHERE t.group_dict_type =
                                               'TRIALORDER_TYPE'
                                           AND t.group_dict_value =
                                               p_trialorder_type)
                                      ELSE
                                       '通过'
                                    END
   WHERE t.factory_report_id = :v_factory_report_id;

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => 'AGREE', --流程操作方式编码
                                                               p_flow_af_status   => 'FA12', --操作后流程状态
                                                               p_memo             => p_audit_comment);

---lsl add 20230114 (验厂管理9.10版)消息推送
  SELECT max(company_name)
    INTO v_company_name
    FROM scmdata.t_factory_report
   WHERE factory_report_id = :v_factory_report_id;
  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FR_AUDIT_00',
                                                        v_user_id      => '',
                                                        v_type         => 1);
---end lsl

END;
/*
DECLARE
  p_trialorder_type VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32);
  p_audit_comment   VARCHAR2(256);
BEGIN
  p_is_trialorder   := ^'|| CHR(64) ||q'^is_trialorder^'|| CHR(64) ||q'^;
  p_trialorder_type := ^'|| CHR(64) ||q'^trialorder_type^'|| CHR(64) ||q'^;
  p_audit_comment   := ^'|| CHR(64) ||q'^audit_comment_sp^'|| CHR(64) ||q'^;

  IF p_is_trialorder = 1 THEN
    IF p_trialorder_type IS NULL THEN
      raise_application_error(-20002, '试单时，试单模式必填！');
    ELSE
      NULL;
    END IF;
  END IF;

  UPDATE scmdata.t_factory_report t
     SET t.is_trialorder          = p_is_trialorder,
         t.trialorder_type        = p_trialorder_type,
         t.audit_comment          = p_audit_comment,
         t.factory_result_suggest = CASE
                                      WHEN p_is_trialorder = 1 THEN
                                       (SELECT t.group_dict_name
                                          FROM scmdata.sys_group_dict t
                                         WHERE t.group_dict_type =
                                               'TRIALORDER_TYPE'
                                           AND t.group_dict_value =
                                               p_trialorder_type)
                                      ELSE
                                       '通过'
                                    END
   WHERE t.factory_report_id = :factory_report_id;

  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => 'AGREE', --'PASS',
                                              p_fac_ask_flow => 'FA12',
                                              p_memo         => p_audit_comment);

END;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_103_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[通过]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_103_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[通过]'',''action_a_check_103_1'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^update scmdata.t_ask_record
  set collection=decode(nvl(collection,0), 0, 1, 0)
where ask_record_id=:ask_record_id^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''ac_a_coop_150_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[收藏/取消收藏]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''ac_a_coop_150_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[收藏/取消收藏]'',''ac_a_coop_150_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (^'|| CHR(64) ||q'^selection)) LOOP

    v_supplier_info_id := supplier_info_rec.supplier_info_id;

    pkg_supplier_info.update_supp_info_bind_status(p_supplier_info_id => v_supplier_info_id,
                                                      p_status           => 1,
                                                      p_user_id          => :user_id,
                                                      p_company_id       => %default_company_id%);

  END LOOP;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[绑定]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[绑定]'',''action_a_supp_160_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  vo_target_company VARCHAR2(100);
  vo_target_user    VARCHAR2(4000);
  vo_msg            CLOB;
  v_company_name    VARCHAR2(256);
  v_ask_user_id     VARCHAR2(256);
  v_factrory_ask_flow_status VARCHAR2(32);
BEGIN
  SELECT MAX(t.factrory_ask_flow_status)
    INTO v_factrory_ask_flow_status
    FROM scmdata.t_factory_ask t
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF v_factrory_ask_flow_status = 'FA31' THEN
    raise_application_error(-20002, '特批申请不能驳回，请选择同意或不同意');
  ELSIF v_factrory_ask_flow_status <> 'FA12' THEN
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  IF :factory_ask_type = 0 THEN
    --更新单据状态同时记录流程操作日志
    scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                                 p_user_id          => :user_id,
                                                                 p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                                 p_ask_record_id    => NULL, --合作申请单ID
                                                                 p_flow_oper_status => 'BACK', --流程操作方式编码
                                                                 p_flow_af_status   => 'FA02', --操作后流程状态
                                                                 p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
    --lsl add 20230116
    --个人企微消息推送
    SELECT company_name
      INTO v_company_name
      FROM scmdata.t_factory_ask
     WHERE factory_ask_id = :factory_ask_id;
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FA_REJECT_00',
                                                          v_user_id      => '',
                                                          v_type         => 1);
    --lsl end

    /* 原代码
       --2. czh add 消息推送 准入驳回通知：如果单据需验厂,系统自动通知验厂人员

        scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                        p_factory_ask_id    => :factory_ask_id,
                                                        p_flow_node_name_af => '验厂申请',
                                                        p_oper_code_desc    => '驳回',
                                                        p_oper_code         => 'BACK',
                                                        p_status_af         => 'FA02',
                                                        p_type              => 'SUP_RE_APPLY',
                                                        po_target_company   => vo_target_company,
                                                        po_target_user      => vo_target_user,
                                                        po_msg              => vo_msg);

        scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                        p_user_id     => vo_target_user,
                                        p_node_id     => 'node_a_coop_200',
                                        p_msg_title   => '验厂申请-准入驳回通知',
                                        p_msg_content => vo_msg,
                                        p_type        => 'SUP_RE_APPLY');
    */
  ELSE
    --更新单据状态同时记录流程操作日志
    scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                                 p_user_id          => :user_id,
                                                                 p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                                 p_ask_record_id    => NULL, --合作申请单ID
                                                                 p_flow_oper_status => 'BACK', --流程操作方式编码
                                                                 p_flow_af_status   => 'FA11', --操作后流程状态
                                                                 p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
    --lsl add 20230116
    --个人企微消息推送
    SELECT company_name, check_user_id
      INTO v_company_name, v_ask_user_id
      FROM scmdata.t_factory_report
     WHERE factory_ask_id = :factory_ask_id;
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FA_REJECT_01',
                                                          v_user_id      => v_ask_user_id,
                                                          v_type         => 0);
    --lsl end

    /*原代码
        --3.  czh add 消息推送 准入驳回通知：如果单据无需验厂，则系统自动通知验厂申请审批人（无需配置通知人员）

        scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                        p_factory_ask_id    => :factory_ask_id,
                                                        p_flow_node_name_af => '验厂',
                                                        p_oper_code_desc    => '驳回',
                                                        p_oper_code         => 'BACK',
                                                        p_status_af         => 'FA11',
                                                        p_type              => 'SUP_RE_REPORT',
                                                        po_target_company   => vo_target_company,
                                                        po_target_user      => vo_target_user,
                                                        po_msg              => vo_msg);

        scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                        p_user_id     => vo_target_user,
                                        p_node_id     => 'node_a_check_100',
                                        p_msg_title   => '验厂报告-准入驳回通知',
                                        p_msg_content => vo_msg,
                                        p_type        => 'SUP_RE_REPORT');
    */
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_313''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[驳回]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_313''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[驳回]'',''action_a_coop_313'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  vo_target_company VARCHAR2(100);
  vo_target_user    VARCHAR2(4000);
  vo_msg            CLOB;
  v_company_name    VARCHAR2(256);
  v_ask_user_id     VARCHAR2(256);
  v_factrory_ask_flow_status VARCHAR2(32);
BEGIN
  SELECT MAX(t.factrory_ask_flow_status)
    INTO v_factrory_ask_flow_status
    FROM scmdata.t_factory_ask t
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF v_factrory_ask_flow_status = 'FA31' THEN
    raise_application_error(-20002, '特批申请不能驳回，请选择同意或不同意');
  ELSIF v_factrory_ask_flow_status <> 'FA12' THEN
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  IF :factory_ask_type = 0 THEN
    --更新单据状态同时记录流程操作日志
    scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                                 p_user_id          => :user_id,
                                                                 p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                                 p_ask_record_id    => NULL, --合作申请单ID
                                                                 p_flow_oper_status => 'BACK', --流程操作方式编码
                                                                 p_flow_af_status   => 'FA02', --操作后流程状态
                                                                 p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
    --lsl add 20230116
    --个人企微消息推送
    SELECT company_name
      INTO v_company_name
      FROM scmdata.t_factory_ask
     WHERE factory_ask_id = :factory_ask_id;
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FA_REJECT_00',
                                                          v_user_id      => '',
                                                          v_type         => 1);
    --lsl end

    /* 原代码
       --2. czh add 消息推送 准入驳回通知：如果单据需验厂,系统自动通知验厂人员

        scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                        p_factory_ask_id    => :factory_ask_id,
                                                        p_flow_node_name_af => '验厂申请',
                                                        p_oper_code_desc    => '驳回',
                                                        p_oper_code         => 'BACK',
                                                        p_status_af         => 'FA02',
                                                        p_type              => 'SUP_RE_APPLY',
                                                        po_target_company   => vo_target_company,
                                                        po_target_user      => vo_target_user,
                                                        po_msg              => vo_msg);

        scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                        p_user_id     => vo_target_user,
                                        p_node_id     => 'node_a_coop_200',
                                        p_msg_title   => '验厂申请-准入驳回通知',
                                        p_msg_content => vo_msg,
                                        p_type        => 'SUP_RE_APPLY');
    */
  ELSE
    --更新单据状态同时记录流程操作日志
    scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                                 p_user_id          => :user_id,
                                                                 p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                                 p_ask_record_id    => NULL, --合作申请单ID
                                                                 p_flow_oper_status => 'BACK', --流程操作方式编码
                                                                 p_flow_af_status   => 'FA11', --操作后流程状态
                                                                 p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
    --lsl add 20230116
    --个人企微消息推送
    SELECT company_name, check_user_id
      INTO v_company_name, v_ask_user_id
      FROM scmdata.t_factory_report
     WHERE factory_ask_id = :factory_ask_id;
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FA_REJECT_01',
                                                          v_user_id      => v_ask_user_id,
                                                          v_type         => 0);
    --lsl end

    /*原代码
        --3.  czh add 消息推送 准入驳回通知：如果单据无需验厂，则系统自动通知验厂申请审批人（无需配置通知人员）

        scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                        p_factory_ask_id    => :factory_ask_id,
                                                        p_flow_node_name_af => '验厂',
                                                        p_oper_code_desc    => '驳回',
                                                        p_oper_code         => 'BACK',
                                                        p_status_af         => 'FA11',
                                                        p_type              => 'SUP_RE_REPORT',
                                                        po_target_company   => vo_target_company,
                                                        po_target_user      => vo_target_user,
                                                        po_msg              => vo_msg);

        scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                        p_user_id     => vo_target_user,
                                        p_node_id     => 'node_a_check_100',
                                        p_msg_title   => '验厂报告-准入驳回通知',
                                        p_msg_content => vo_msg,
                                        p_type        => 'SUP_RE_REPORT');
    */
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_313''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[驳回]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_313''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[驳回]'',''action_a_coop_313'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  p_status_af_oper VARCHAR2(32);
  p_msg            VARCHAR2(256);
  p_ask_user       VARCHAR2(32);
  v_company_name   VARCHAR2(256);
  v_ask_user_id    VARCHAR2(32);
  v_factrory_ask_flow_status VARCHAR2(32);
BEGIN
  SELECT MAX(t.factrory_ask_flow_status)
    INTO v_factrory_ask_flow_status
    FROM scmdata.t_factory_ask t
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF v_factrory_ask_flow_status = 'FA12' THEN
    p_status_af_oper := 'FA21';
  ELSIF v_factrory_ask_flow_status = 'FA31' THEN
    p_status_af_oper := 'FA33';
  ELSE
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_ask_record_id    => NULL, --合作申请单ID
                                                               p_flow_oper_status => 'DISAGREE', --流程操作方式编码
                                                               p_flow_af_status   => p_status_af_oper, --操作后流程状态
                                                               p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
  --lsl add 20230116
  --个人企微消息推送
  SELECT company_name, ask_user_id
    INTO v_company_name, v_ask_user_id
    FROM scmdata.t_factory_ask
   WHERE factory_ask_id = :factory_ask_id;
  IF :factrory_ask_flow_status = 'FA12' THEN
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FA_DISAGREE_00',
                                                          v_user_id      => v_ask_user_id,
                                                          v_type         => 0);
  ELSIF :factrory_ask_flow_status = 'FA31' THEN
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FA_DISAGREE_01',
                                                          v_user_id      => v_ask_user_id,
                                                          v_type         => 0);
  END IF;
  --lsl end
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^select 1 from dual^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_312''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[不同意准入]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_312''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[不同意准入]'',''action_a_coop_312'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  p_status_af_oper VARCHAR2(32);
  p_msg            VARCHAR2(256);
  p_ask_user       VARCHAR2(32);
  v_company_name   VARCHAR2(256);
  v_ask_user_id    VARCHAR2(32);
  v_factrory_ask_flow_status VARCHAR2(32);
BEGIN
  SELECT MAX(t.factrory_ask_flow_status)
    INTO v_factrory_ask_flow_status
    FROM scmdata.t_factory_ask t
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF v_factrory_ask_flow_status = 'FA12' THEN
    p_status_af_oper := 'FA21';
  ELSIF v_factrory_ask_flow_status = 'FA31' THEN
    p_status_af_oper := 'FA33';
  ELSE
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_ask_record_id    => NULL, --合作申请单ID
                                                               p_flow_oper_status => 'DISAGREE', --流程操作方式编码
                                                               p_flow_af_status   => p_status_af_oper, --操作后流程状态
                                                               p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
  --lsl add 20230116
  --个人企微消息推送
  SELECT company_name, ask_user_id
    INTO v_company_name, v_ask_user_id
    FROM scmdata.t_factory_ask
   WHERE factory_ask_id = :factory_ask_id;
  IF :factrory_ask_flow_status = 'FA12' THEN
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FA_DISAGREE_00',
                                                          v_user_id      => v_ask_user_id,
                                                          v_type         => 0);
  ELSIF :factrory_ask_flow_status = 'FA31' THEN
    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FA_DISAGREE_01',
                                                          v_user_id      => v_ask_user_id,
                                                          v_type         => 0);
  END IF;
  --lsl end
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^select 1 from dual^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_312''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[不同意准入]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_312''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[不同意准入]'',''action_a_coop_312'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  tmp_str VARCHAR2(32);
BEGIN
  SELECT factrory_ask_flow_status
    INTO tmp_str
    FROM scmdata.t_factory_ask
   WHERE factory_ask_id = :factory_ask_id;
  IF tmp_str = 'FA02' THEN
    --流程操作记录
    pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                p_user_id      => :user_id,
                                                p_fac_ask_id   => :factory_ask_id,
                                                p_flow_status  => 'CANCEL',
                                                p_fac_ask_flow => 'FA01',
                                                p_memo         => '');

  ELSE
    raise_application_error(-20002, '只有验厂申请已提交状态可以撤回');
  END IF;
END;

--原代码
/*
DECLARE
  TMP_STR VARCHAR2(32);
BEGIN
  SELECT FACTRORY_ASK_FLOW_STATUS
    INTO TMP_STR
    FROM SCMDATA.T_FACTORY_ASK
   WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID;
  IF TMP_STR = 'FA02' THEN
    INSERT INTO T_FACTORY_ASK_OPER_LOG
      (LOG_ID,
       FACTORY_ASK_ID,
       OPER_USER_ID,
       OPER_CODE,
       STATUS_AF_OPER,
       REMARKS,
       ASK_RECORD_ID,
       OPER_TIME,
       oper_user_company_id)
    VALUES
      (F_GET_UUID(),
       :FACTORY_ASK_ID,
       :USER_ID,
       'CANCEL',
       'FA01',
       NULL,
       (SELECT ASK_RECORD_ID
          FROM T_FACTORY_ASK
         WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID),
       SYSDATE,
       %DEFAULT_COMPANY_ID%);

    UPDATE SCMDATA.T_FACTORY_ASK
       SET FACTRORY_ASK_FLOW_STATUS = 'FA01'
     WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID;
	ELSE
	   RAISE_APPLICATION_ERROR(-20002, '只有验厂申请已提交状态可以撤回');
  END IF;
END;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_farevoke''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[撤销提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_farevoke''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[撤销提交]'',''action_a_check_farevoke'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--select 1 from dual
call scmdata.pkg_supplier_info.delete_supplier_info_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[导入主档]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[导入主档]'',''action_a_supp_160'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^call scmdata.pkg_supplier_info.delete_supplier_info_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_1_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[重置]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_1_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[重置]'',''action_a_supp_160_1_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^declare
v_flag number := 1;
begin
       if v_flag = 1 then
          raise_application_error(-20002,'此按钮暂不支持上传功能，请从右侧工具栏进行导入数据！');
       end if;
end;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_170_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[上传]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_170_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[上传]'',''action_a_supp_170_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^declare
  new_num varchar2(128);
  p_reason varchar2(256);
  v_scc_flag  number;
  sp_id varchar2(128);
  vc_id varchar2(128);
  v_s number;
  old_num varchar2(128);
  vo_log_id varchar2(32);
begin
   new_num := ^'|| CHR(64) ||q'^NEW_LICENCE_NUM^'|| CHR(64) ||q'^;
   p_reason := ^'|| CHR(64) ||q'^MODIFY_REASON^'|| CHR(64) ||q'^;
   sp_id := :supplier_info_id;

   SELECT SOCIAL_CREDIT_CODE
     INTO OLD_NUM
     FROM T_SUPPLIER_INFO A
    WHERE A.SUPPLIER_INFO_ID = SP_ID AND a.company_id =%default_company_id%;

    if new_num is null then
         raise_application_error(-20002, '新统一社会信用代码不能为空！');
      else
         if length(new_num)<>lengthb(new_num) then
            raise_application_error(-20002,
                 '统一社会信用代码是由18位英文和数字组成，不能填写中文');
         end if;
         if length(new_num) > 18 then
             raise_application_error(-20002, '填写的新社会信用代码已大于18位，请填写正确的新信用代码');
         end if;
         if length(new_num) < 18 then
             raise_application_error(-20002, '填写的新社会信用代码小于18位，请填写正确的新信用代码');
         end if;
         if scmdata.pkg_check_data_comm.f_check_soial_code(new_num) = 1 then
           null;
         else
            raise_application_error(-20002,
                 '统一社会信用代码是由18位英文和数字组成，不能存在空格、特殊符号，请填写正确的新信用代码');
         end if;

         select count(1)
         into v_scc_flag
         from scmdata.t_supplier_info sp
         where sp.social_credit_code = new_num
         and  sp.company_id=%default_company_id%;

        if v_scc_flag > 0 then
          raise_application_error(-20002, '新统一社会信用代码不能重复！');
        end if;

        select count(1)
        into v_s
        from scmdata.t_ask_record a
        left join scmdata.t_factory_ask b
          on a.be_company_id = b.company_id
         and a.ask_record_id = b.ask_record_id
       where a.be_company_id = :company_id
         and (a.social_credit_code = new_num or
             b.social_credit_code = new_num);

         if v_s > 0 then
            raise_application_error(-20002,
                                 '新统一信用代码已存在流程中，不能重复，请检查！');
        end if;

         select supplier_company_id
         into vc_id
         from scmdata.t_supplier_info sp
         where sp.supplier_info_id = sp_id;

        if vc_id is not null then
            raise_application_error(-20002, '该供应商已在SCM注册企业，不能修改统一社会信用代码');
        end if;

    end if;

    update scmdata.t_supplier_info sp set sp.social_credit_code = new_num
          where sp.supplier_info_id = :supplier_info_id;

     scmdata.pkg_supplier_info.insert_oper_log( :supplier_info_id,
                                               '更变社会信用代码',
                                                p_reason,
                                                :user_id,
                                                :company_id,
                                                SYSDATE);

    scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => %default_company_id%,
                                           p_apply_module       => 'a_supp_160',
                                           p_base_table         => 't_supplier_info',
                                           p_apply_pk_id        => sp_id,
                                           p_action_type        => 'UPDATE',
                                           p_log_msg            =>'更变社会信用代码为 '||new_num,
                                           p_log_type           => '00',
                                           p_field_desc         => '更变社会信用代码',
                                           p_operate_field      => 'social_credit_code',
                                           p_field_type         => 'VARCHAR',
                                           p_old_code           => NULL,
                                           p_new_code           => NULL,
                                           p_old_value          => OLD_NUM,
                                           p_new_value          => new_num,
                                           p_user_id            => %current_userid%,
                                           p_operate_company_id => %default_company_id%,
                                           p_seq_no             => 1,
                                           p_operate_reason     => p_reason,
                                           po_log_id            => vo_log_id);



end;

/*declare
  new_num varchar2(128);
  p_reason varchar2(256);
  v_scc_flag  number;
  sp_id varchar2(128);
  vc_id varchar2(128);
  v_s number;
begin
   new_num := ^'|| CHR(64) ||q'^NEW_LICENCE_NUM^'|| CHR(64) ||q'^;
   p_reason := ^'|| CHR(64) ||q'^MODIFY_REASON^'|| CHR(64) ||q'^;
   sp_id := :supplier_info_id;
    if new_num is null then
         raise_application_error(-20002, '新统一社会信用代码不能为空！');
      else
         if length(new_num)<>lengthb(new_num) then
            raise_application_error(-20002,
                 '统一社会信用代码是由18位英文和数字组成，不能填写中文');
         end if;
         if length(new_num) > 18 then
             raise_application_error(-20002, '填写的新社会信用代码已大于18位，请填写正确的新信用代码');
         end if;
         if length(new_num) < 18 then
             raise_application_error(-20002, '填写的新社会信用代码小于18位，请填写正确的新信用代码');
         end if;
         if scmdata.pkg_check_data_comm.f_check_soial_code(new_num) = 1 then
           null;
         else
            raise_application_error(-20002,
                 '统一社会信用代码是由18位英文和数字组成，不能存在空格、特殊符号，请填写正确的新信用代码');
         end if;

         select count(1)
         into v_scc_flag
         from scmdata.t_supplier_info sp
         where sp.social_credit_code = new_num
         and  sp.company_id=%default_company_id%;

        if v_scc_flag > 0 then
          raise_application_error(-20002, '新统一社会信用代码不能重复！');
        end if;

        select count(1)
        into v_s
        from scmdata.t_ask_record a
        left join scmdata.t_factory_ask b
          on a.be_company_id = b.company_id
         and a.ask_record_id = b.ask_record_id
       where a.be_company_id = :company_id
         and (a.social_credit_code = new_num or
             b.social_credit_code = new_num);

         if v_s > 0 then
            raise_application_error(-20002,
                                 '新统一信用代码已存在流程中，不能重复，请检查！');
        end if;

         select supplier_company_id
         into vc_id
         from scmdata.t_supplier_info sp
         where sp.supplier_info_id = sp_id;

        if vc_id is not null then
            raise_application_error(-20002, '该供应商已在SCM注册企业，不能修改统一社会信用代码');
        end if;

    end if;

    update scmdata.t_supplier_info sp set sp.social_credit_code = new_num
          where sp.supplier_info_id = :supplier_info_id;

     scmdata.pkg_supplier_info.insert_oper_log( :supplier_info_id,
                                               '更变社会信用代码',
                                                p_reason,
                                                :user_id,
                                                :company_id,
                                                SYSDATE);

end;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[信用代码变更]'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[信用代码变更]'',''action_a_supp_160_6'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^
declare
  v_company_name  varchar2(256);
  v_check_user_id varchar2(256);
begin
  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => 'BACK', --流程操作方式编码
                                                               p_flow_af_status   => 'FA11', --操作后流程状态
                                                               p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
---lsl add 20230114 (验厂管理9.10版)消息推送
  select max(company_name) , max(check_user_id)
    into v_company_name, v_check_user_id
    from scmdata.t_factory_report
   where factory_report_id = :v_factory_report_id;
  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FR_AUDIT_01',
                                                        v_user_id      => v_check_user_id,
                                                        v_type         => 0);
--lsl add
end;

/*BEGIN
  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => 'BACK',
                                              p_fac_ask_flow => 'FA11',
                                              p_memo         => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
END;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_103_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[驳回]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_103_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[驳回]'',''action_a_check_103_3'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_111_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[保存]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_111_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[保存]'',''action_a_supp_111_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  v_pub_sup_id VARCHAR2(32);
  v_submit_btn VARCHAR2(256) := :sp_sup_company_name_y;
BEGIN
  --因速狮原因，点击生成档案时，会自动触发两次提交按钮。
  --故获取必填项做校验，当v_submit_btn不为空时，则执行提交按钮。
  IF v_submit_btn IS NOT NULL THEN
    --获取asscoiate请求参数
    v_pub_sup_id := pkg_plat_comm.f_get_rest_val_method_params(p_character => %ass_supplier_info_id%,
                                                               p_rtn_type  => 1);

    --IF instr(';' || v_rest_method || ';', ';' || 'GET' || ';') > 0 THEN
    DECLARE
      v_wx_sql       CLOB;
      v_origin       VARCHAR2(32);
      v_origin_id    VARCHAR2(32);
      v_supcode      VARCHAR2(32);
      v_robot_key    VARCHAR2(400);
      v_sup_id       VARCHAR2(32) := v_pub_sup_id;
      v_company_name VARCHAR2(256);
      v_ask_user_id  VARCHAR2(32);
    BEGIN

      pkg_supplier_info.p_submit_t_supplier_info(p_supplier_info_id   => v_sup_id,
                                                 p_default_company_id => %default_company_id%,
                                                 p_user_id            => %user_id%);

      --启用qc工厂内容
      scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => v_sup_id,
                                                                     p_company_id    => %default_company_id%);

      --建档通知
      SELECT t.supplier_info_origin, t.supplier_info_origin_id
        INTO v_origin, v_origin_id
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = %default_company_id%
         AND t.supplier_info_id = v_sup_id;

      IF v_origin = 'AA' THEN
        --lsl add 20230117
        --个人企微消息推送
        SELECT MAX(t.supplier_company_name), MAX(tf.ask_user_id)
          INTO v_company_name, v_ask_user_id
          FROM scmdata.t_supplier_info t
         INNER JOIN scmdata.t_factory_ask tf
            ON t.supplier_info_origin_id = tf.factory_ask_id
           AND t.company_id = tf.company_id
         WHERE t.supplier_info_id = v_sup_id;

        scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                              v_supplier     => v_company_name,
                                                              v_pattern_code => 'TF_SUBMIT_00',
                                                              v_user_id      => v_ask_user_id,
                                                              v_type         => 0);
        --lsl end

        /*         --触发企微机器人发送消息
          SELECT MAX(a.robot_key)
            INTO v_robot_key
            FROM scmdata.sys_company_wecom_config a
           WHERE a.company_id = %default_company_id%
             AND a.robot_type = 'SUP_MSG';
         v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                                p_factory_ask_id => v_origin_id,
                                                                p_msgtype        => 'text', --消息类型 text、markdown
                                                                p_msg_title      => '建档通知通知', --消息标题
                                                                p_bot_key        => v_robot_key, --机器人key
                                                                p_robot_type     => 'SUP_MSG' --机器人配置类型
                                                                );
        ELSE
          v_wx_sql := 'select ''text'' MSGTYPE,''新增供应商-建档通知''  CONTENT,''999bc2eb-55b8-400d-a70e-5ea148e59396'' key from dual';*/
      END IF;
      /*    ELSE
      v_wx_sql := 'select ''text'' MSGTYPE,''新增供应商-建档通知''  CONTENT,''999bc2eb-55b8-400d-a70e-5ea148e59396'' key from dual';*/
    END;
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^select 1 from dual^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_supp_151_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  p_k VARCHAR2(32);
  p_c VARCHAR2(32);
BEGIN
  SELECT MAX(a.coor_ask_flow_status),
         nvl(MAX(b.factrory_ask_flow_status), '0')
    INTO p_c, p_k
    FROM t_ask_record a
    LEFT JOIN t_factory_ask b
      ON a.ask_record_id = b.ask_record_id
   WHERE a.ask_record_id = :ask_record_id;
  IF p_c <> 'CA01' THEN
    raise_application_error(-20002, '申请并未提交，不可撤回');
  END IF;
  IF p_k <> '0' THEN
    raise_application_error(-20002, '申请已进入验厂流程，不可撤回');
  END IF;

  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id    => %default_company_id%,
                                              p_user_id       => :user_id,
                                              p_ask_record_id => :ask_record_id,
                                              p_flow_status   => 'CANCEL',
                                              p_fac_ask_flow  => 'CA00',
                                              p_memo          => '');

END;

--原代码
/*
DECLARE
  p_k VARCHAR2(32);
  p_c VARCHAR2(32);
BEGIN
  SELECT MAX(a.coor_ask_flow_status),
         nvl(MAX(b.factrory_ask_flow_status), '0')
    INTO p_c, p_k
    FROM t_ask_record a
    LEFT JOIN t_factory_ask b
      ON a.ask_record_id = b.ask_record_id
   WHERE a.ask_record_id = :ask_record_id;
  IF p_c <> 'CA01' THEN
    raise_application_error(-20002, '申请并未提交，不可撤回');
  END IF;
  IF p_k <> '0' THEN
    raise_application_error(-20002, '申请已进入验厂流程，不可撤回');
  END IF;
  UPDATE t_ask_record
     SET ask_date = NULL, coor_ask_flow_status = 'CA00'
   WHERE ask_record_id = :ask_record_id;

  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id    => %default_company_id%,
                                              p_user_id       => :user_id,
                                              p_ask_record_id => :ask_record_id,
                                              p_flow_status   => 'CANCEL',
                                              p_fac_ask_flow  => 'CA00',
                                              p_memo          => '');

END;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_121_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[撤销申请]'',q''[]'',q''[]'',0,1,q''[]'',0,1,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_121_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[撤销申请]'',''action_a_coop_121_1'',q''[]'',q''[]'',0,1,q''[]'',0,1,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  judge          NUMBER(1);
  fa_id          VARCHAR2(32);
  fa_status      VARCHAR2(32);
  v_type         NUMBER;
  v_company_name VARCHAR2(256);
BEGIN

  SELECT COUNT(1)
    INTO judge
    FROM scmdata.t_factory_ask
   WHERE ask_record_id = :ask_record_id;

  IF judge > 0 THEN
    SELECT factory_ask_id, status_af_oper
      INTO fa_id, fa_status
      FROM (SELECT factory_ask_id, status_af_oper
              FROM scmdata.t_factory_ask_oper_log
             WHERE ask_record_id = :ask_record_id
             ORDER BY oper_time DESC)
     WHERE rownum < 2;
    -- 验厂环节不通过的单据需流入准入待审批
    -- 'FA14',/*CASE WHEN fa_status = 'FA14' THEN  1 ELSE 0 END*/
    IF fa_status IN ('FA03', 'FA21') THEN
      --判断是否验厂
      SELECT COUNT(1)
        INTO v_type
        FROM scmdata.t_factory_report t
       WHERE t.factory_ask_id = fa_id
         AND t.company_id = %default_company_id%;

      UPDATE scmdata.t_factory_ask
         SET factory_ask_type = CASE
                                  WHEN v_type > 0 THEN
                                   1
                                  ELSE
                                   0
                                END
       WHERE factory_ask_id = fa_id;

      --czh add 更新单据状态同时记录流程操作日志
      scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                                   p_user_id          => :user_id,
                                                                   p_fac_ask_id       => fa_id, --验厂申请单ID
                                                                   p_ask_record_id    => NULL, --合作申请单ID
                                                                   p_flow_oper_status => 'SUBMIT', --流程操作方式编码
                                                                   p_flow_af_status   => 'FA31', --操作后流程状态
                                                                   p_memo             => ^'|| CHR(64) ||q'^apply_reason^'|| CHR(64) ||q'^);
      --lsl add 20230116
      --个人企微消息推送
      SELECT company_name
        INTO v_company_name
        FROM scmdata.t_factory_ask
       WHERE factory_ask_id = fa_id;
      scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                            v_supplier     => v_company_name,
                                                            v_pattern_code => 'FA_SPECIAL_00',
                                                            v_user_id      => '',
                                                            v_type         => 1);
      --lsl end
    ELSE
      raise_application_error(-20002,
                              '仅状态为[验厂申请不通过、准入不通过]的单据才可进行特批申请！');
    END IF;

  ELSE
    raise_application_error(-20002, '找不到验厂申请单，请先申请验厂！');
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_specialapply''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[特批申请]'',q''[]'',q''[four_word_150]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_specialapply''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[特批申请]'',''action_specialapply'',q''[]'',q''[four_word_150]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^SELECT gt.kit_template_code, gt.template_name, gt.kit_template_file_id
  FROM scmdata.sys_group_template_type t, scmdata.sys_group_template gt
 WHERE t.template_type_id = gt.template_type_id
 AND t.template_type_code = 'IMPORT_CONSTRACT'
   and gt.kit_template_code='CN001'^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_151_6_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 0,q''[]'',q''[下载模板]'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_151_6_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 0,q''[]'',q''[下载模板]'',''action_a_supp_151_6_1'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  v_share_method VARCHAR2(100) := ^'|| CHR(64) ||q'^share_method^'|| CHR(64) ||q'^;
  x_err_msg      VARCHAR2(100);
  share_method_exp EXCEPTION;
BEGIN
  IF v_share_method = '02' THEN
    --raise_application_error(-20002,'若设置指定共享,请到下方‘指定共享’页面设置');
      --设置指定共享
      UPDATE scmdata.t_supplier_info ts
         SET ts.sharing_type = v_share_method
       WHERE ts.company_id = %default_company_id%
         AND ts.supplier_info_id = :supplier_info_id;
  ELSE
  scmdata.sf_supplier_info_pkg.appoint_t_supplier_shared(p_company_id        => %default_company_id%,
                                                         p_supplier_info_id  => :supplier_info_id,
                                                         p_shared_company_id => NULL,
                                                         p_appoint_type      => v_share_method);

 END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_111_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[生产工厂共享设置]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_111_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[生产工厂共享设置]'',''action_a_supp_111_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32) := :ask_record_id;
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
BEGIN
  v_sql      := q'[
DECLARE
  jug_num   NUMBER(5);
  jug_str   VARCHAR2(256);
  coop_type VARCHAR2(64);
  v_ask_record_id VARCHAR2(32) := ']' || v_ask_record_id || q'[';
BEGIN
  --1.统一信用代码校验
  scmdata.pkg_ask_record_mange.has_coop_submit(pi_be_company_id      => %default_company_id%,
                                               pi_social_credit_code => :ar_social_credit_code_y);
  --2.请填写意向合作范围后提交
  scmdata.pkg_ask_record_mange_a.p_check_t_ask_scope(p_factory_ask_id => :factory_ask_id,
                                                     p_company_id     => %default_company_id%,
                                                     p_ask_record_id  => v_ask_record_id,
                                                     p_check_type     => 1);

  --3.提交后,更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_ask_record_id    => v_ask_record_id, --合作申请单ID
                                                               p_flow_oper_status => 'SUBMIT', --流程操作方式编码
                                                               p_flow_af_status   => 'CA01', --操作后流程状态
                                                               p_memo             => NULL);

END;
]';
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_coop_151'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  judge               NUMBER(3);
  notice_userid       VARCHAR2(32);
  --czh add 消息通知
  vo_target_company   VARCHAR2(100);
  vo_target_user      VARCHAR2(4000);
  vo_msg              CLOB;
  v_company_name      varchar2(256);
  v_factory_report_id varchar2(32);
  v_flag              number(8);
BEGIN
  SELECT COUNT(factory_ask_id)
    INTO judge
    FROM scmdata.t_factory_ask
   WHERE factrory_ask_flow_status = 'FA02'
     AND factory_ask_id = :factory_ask_id;
  IF judge = 0 THEN
    SELECT oper_user_id
      INTO notice_userid
      FROM (SELECT oper_user_id, ask_record_id
              FROM scmdata.t_factory_ask_oper_log
             WHERE factory_ask_id = :factory_ask_id
               AND oper_code = 'AGREE'
             ORDER BY oper_time DESC)
     WHERE rownum = 1;

    scmdata.pkg_factory_inspection.p_reject_and_delete_ability_record(v_faid   => :factory_ask_id,
                                                                      v_compid => %default_company_id%);
    ---20230208 lsl  驳回按钮增加删除改报告的验厂品控体系
    select max(factory_report_id)
      into v_factory_report_id
      from scmdata.t_factory_report
     where factory_ask_id = :factory_ask_id;
    select count(1)
      into v_flag
      from scmdata.t_quality_control_fr t
     where t.factory_report_id = v_factory_report_id
       and t.company_id = %default_company_id%;
    if v_flag > 0 then
      delete scmdata.t_quality_control_fr t
       where t.factory_report_id = v_factory_report_id;
    end if;
     delete scmdata.t_factory_report where factory_report_id = v_factory_report_id;
    ---end

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => 'BACK', --流程操作方式编码
                                                               p_flow_af_status   => 'FA02', --操作后流程状态
                                                               p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);

    ---20230112 lsl add 个人企微消息推送（验厂管理9.10版）
    SELECT company_name
      INTO v_company_name
      FROM scmdata.t_factory_ask
     WHERE factory_ask_id = :factory_ask_id;

    scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                          v_supplier     => v_company_name,
                                                          v_pattern_code => 'FR_REJECT',
                                                          v_user_id      => '',
                                                          v_type         => 1);
    ---lsl end

    --2. czh add 消息通知 待验厂驳回通知：系统自动通知验厂申请审批人（无需配置通知人员）

    /*scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                    p_factory_ask_id    => :factory_ask_id,
                                                    p_flow_node_name_af => '验厂申请',
                                                    p_oper_code_desc    => '驳回',
                                                    p_oper_code         => 'BACK',
                                                    p_status_af         => 'FA02',
                                                    p_type              => 'REPLACE_FAC_R',
                                                    po_target_company   => vo_target_company,
                                                    po_target_user      => vo_target_user,
                                                    po_msg              => vo_msg);

    scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                    p_user_id     => vo_target_user,
                                    p_node_id     => 'node_a_coop_200',
                                    p_msg_title   => '待验厂驳回通知',
                                    p_msg_content => vo_msg,
                                    p_type        => 'REPLACE_FAC_R');*/

  ELSE
    raise_application_error(-20002, '已驳回，不可重复操作！');
  END IF;
END;

--原代码
/*
DECLARE
  JUDGE         NUMBER(3);
  ASKR_ID       VARCHAR2(32);
  NOTICE_USERID VARCHAR2(32);
  --czh add 消息通知
  vo_target_company          VARCHAR2(100);
  vo_target_user             VARCHAR2(4000);
  vo_msg                     CLOB;
BEGIN
  SELECT COUNT(FACTORY_ASK_ID)
    INTO JUDGE
    FROM SCMDATA.T_FACTORY_ASK
   WHERE FACTRORY_ASK_FLOW_STATUS = 'FA02'
     AND FACTORY_ASK_ID = :FACTORY_ASK_ID;
  IF JUDGE = 0 THEN
    UPDATE SCMDATA.T_FACTORY_ASK
       SET FACTRORY_ASK_FLOW_STATUS = 'FA02'
     WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID;
    SELECT OPER_USER_ID, ASK_RECORD_ID
      INTO NOTICE_USERID, ASKR_ID
      FROM (SELECT OPER_USER_ID, ASK_RECORD_ID
              FROM SCMDATA.T_FACTORY_ASK_OPER_LOG
             WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID
               AND OPER_CODE = 'AGREE'
             ORDER BY OPER_TIME DESC)
     WHERE ROWNUM = 1;
    INSERT INTO SCMDATA.T_FACTORY_ASK_OPER_LOG
      (LOG_ID, FACTORY_ASK_ID, OPER_USER_ID, OPER_CODE,
       STATUS_AF_OPER, REMARKS, ASK_RECORD_ID, OPER_TIME,
       OPER_USER_COMPANY_ID)
    VALUES
      (F_GET_UUID(), :FACTORY_ASK_ID, :USER_ID, 'BACK',
       'FA02', ^'|| CHR(64) ||q'^AUDIT_COMMENT^'|| CHR(64) ||q'^, ASKR_ID, SYSDATE,
       %DEFAULT_COMPANY_ID%);

    SCMDATA.PKG_FACTORY_INSPECTION.P_REJECT_AND_DELETE_ABILITY_RECORD(V_FAID => :FACTORY_ASK_ID, V_COMPID => %DEFAULT_COMPANY_ID%);

    --2. czh add 消息通知 待验厂驳回通知：系统自动通知验厂申请审批人（无需配置通知人员）

    /*scmdata.pkg_msg_config.config_t_factory_ask_msg(p_company_id        => %default_company_id%,
                                                    p_factory_ask_id    => :factory_ask_id,
                                                    p_flow_node_name_af => '验厂申请',
                                                    p_oper_code_desc    => '驳回',
                                                    p_oper_code         => 'BACK',
                                                    p_status_af         => 'FA02',
                                                    p_type              => 'REPLACE_FAC_R',
                                                    po_target_company   => vo_target_company,
                                                    po_target_user      => vo_target_user,
                                                    po_msg              => vo_msg);

    scmdata.pkg_msg_config.send_msg(p_company_id  => vo_target_company,
                                    p_user_id     => vo_target_user,
                                    p_node_id     => 'node_a_coop_200',
                                    p_msg_title   => '待验厂驳回通知',
                                    p_msg_content => vo_msg,
                                    p_type        => 'REPLACE_FAC_R');*/

  ELSE
    RAISE_APPLICATION_ERROR(-20002, '已驳回，不能重复驳回！');
  END IF;
END;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''ac_a_check_101_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[驳回]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''ac_a_check_101_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[驳回]'',''ac_a_check_101_3'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (^'|| CHR(64) ||q'^selection)) LOOP

    v_supplier_info_id := supplier_info_rec.supplier_info_id;

    sf_supplier_info_pkg.update_supp_info_bind_status(p_supplier_info_id => v_supplier_info_id,
                                                      p_status           => 1);

  END LOOP;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_120_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[绑定]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_120_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[绑定]'',''action_a_supp_120_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (^'|| CHR(64) ||q'^selection)) LOOP

    v_supplier_info_id := supplier_info_rec.supplier_info_id;
    pkg_supplier_info.update_supp_info_bind_status(p_supplier_info_id => v_supplier_info_id,
                                                      p_status           => 0,
                                                      p_user_id          => :user_id,
                                                      p_company_id       => %default_company_id%);

  END LOOP;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[解绑]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[解绑]'',''action_a_supp_160_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  p_status_af_oper  VARCHAR2(32);
  p_msg             VARCHAR2(256);
  p_ask_user        VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32) := ^'|| CHR(64) ||q'^is_trialorder^'|| CHR(64) ||q'^;
  p_trialorder_type VARCHAR2(32) := ^'|| CHR(64) ||q'^trialorder_type^'|| CHR(64) ||q'^;
  v_company_name    VARCHAR2(256);
  v_factrory_ask_flow_status VARCHAR2(32);
  v_factory_ask_type VARCHAR2(32);
BEGIN
  SELECT MAX(t.factrory_ask_flow_status), MAX(t.factory_ask_type)
    INTO v_factrory_ask_flow_status, v_factory_ask_type
    FROM scmdata.t_factory_ask t
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF v_factrory_ask_flow_status = 'FA12' THEN
    p_status_af_oper := 'FA22';
  ELSIF v_factrory_ask_flow_status = 'FA31' THEN
    p_status_af_oper := 'FA32';
  ELSE
    raise_application_error(-20002, '流程状态已改变！不能执行该操作！');
  END IF;

  IF p_is_trialorder = 1 AND p_trialorder_type IS NULL THEN
    raise_application_error(-20002, '试单时，试单模式必填！');
  ELSIF p_is_trialorder = 0 AND p_trialorder_type IS NOT NULL THEN
    raise_application_error(-20002, '试单模式无需填写！');
  ELSIF v_factory_ask_type IS NOT NULL AND v_factory_ask_type <> 0 THEN
    UPDATE t_factory_report
       SET review_date   = SYSDATE,
           review_id     = :user_id,
           admit_result  = p_trialorder_type,
           is_trialorder = p_is_trialorder
     WHERE factory_ask_id = :factory_ask_id;
  END IF;

  --生成档案
  pkg_supplier_info.p_create_t_supplier_info(p_company_id      => %default_company_id%,
                                             p_factory_ask_id  => :factory_ask_id,
                                             p_user_id         => :user_id,
                                             p_is_trialorder   => p_is_trialorder,
                                             p_trialorder_type => p_trialorder_type);

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_ask_record_id    => NULL, --合作申请单ID
                                                               p_flow_oper_status => 'AGREE', --流程操作方式编码
                                                               p_flow_af_status   => p_status_af_oper, --操作后流程状态
                                                               p_memo             => ^'|| CHR(64) ||q'^audit_comment_sp^'|| CHR(64) ||q'^);

  --lsl add 20230116
  --个人企微消息推送
  SELECT company_name
    INTO v_company_name
    FROM scmdata.t_factory_ask
   WHERE factory_ask_id = :factory_ask_id;
  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FA_AGREE_00',
                                                        v_user_id      => '',
                                                        v_type         => 1);
  --lsl end
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^select 1 from dual^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_311''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[同意准入]'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_311''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[同意准入]'',''action_a_coop_311'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^/*DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (^'|| CHR(64) ||q'^selection)) LOOP

    v_supplier_info_id := supplier_info_rec.supplier_info_id;
    sf_supplier_info_pkg.update_supplier_info_status(p_supplier_info_id => v_supplier_info_id,
                                                     p_status           => 1);

  END LOOP;

END;*/

--修改：启用、停用增加输入原因
DECLARE
  v_user_id VARCHAR2(100);
BEGIN

  SELECT t.nick_name
   INTO v_user_id
    FROM scmdata.sys_user t
   WHERE t.user_id = :user_id;

  sf_supplier_info_pkg.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                   p_reason           => ^'|| CHR(64) ||q'^D_REASON_SP^'|| CHR(64) ||q'^,
                                                   p_status           => 1,
                                                   p_user_id          => v_user_id,
                                                   p_company_id       => %default_company_id%);

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_120_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[停用]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_120_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[停用]'',''action_a_supp_120_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^call pkg_supplier_info.submit_t_coop_scope_temp(p_company_id => %default_company_id%, p_user_id =>%user_id% )^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_170_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_170_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_supp_170_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^declare
v_flag number := 1;
begin
       if v_flag = 1 then
          raise_application_error(-20002,'此按钮暂不支持上传功能，请从右侧工具栏进行导入数据！');
       end if;
end;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_180_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[上传]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_180_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[上传]'',''action_a_supp_180_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  judge             NUMBER(5);
  v_fac_flow_status VARCHAR2(32);
BEGIN
  SELECT COUNT(company_id)
    INTO judge
    FROM scmdata.sys_company
   WHERE licence_num =
         (SELECT social_credit_code
            FROM scmdata.t_ask_record
           WHERE ask_record_id = :ask_record_id);
  IF judge > 0 THEN
    SELECT MAX(t.factrory_ask_flow_status)
      INTO v_fac_flow_status
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = :factory_ask_id;
    IF nvl(v_fac_flow_status, :coor_ask_flow_status) = 'CA01' THEN
      --流程操作记录
      pkg_ask_record_mange.p_log_fac_records_oper(p_company_id    => %default_company_id%,
                                                  p_user_id       => :user_id,
                                                  p_ask_record_id => :ask_record_id,
                                                  p_flow_status   => 'RETURN',
                                                  p_fac_ask_flow  => 'CA03',
                                                  p_memo          => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);
    ELSE
      raise_application_error(-20002, '该单据已存在流程中，不可退回！');

    END IF;
  ELSE
    raise_application_error(-20002, '新增的意向合作供应商不可退回！');
  END IF;
END;


--原代码
/*DECLARE
  STATUS VARCHAR2(32);
  JUDGE  NUMBER(5);
BEGIN
  SELECT COUNT(COMPANY_ID)
	   INTO JUDGE
    FROM SCMDATA.SYS_COMPANY
   WHERE LICENCE_NUM =
         (SELECT SOCIAL_CREDIT_CODE
            FROM SCMDATA.T_ASK_RECORD
           WHERE ASK_RECORD_ID = :ASK_RECORD_ID);
  IF JUDGE > 0 THEN
    SELECT :COOR_ASK_FLOW_STATUS INTO STATUS FROM DUAL;
    IF STATUS = 'CA01' THEN
      STATUS := 'CA03';
      UPDATE T_ASK_RECORD
         SET COOR_ASK_FLOW_STATUS = STATUS, ASK_DATE = NULL
       WHERE ASK_RECORD_ID = :ASK_RECORD_ID;
      INSERT INTO T_FACTORY_ASK_OPER_LOG
   (LOG_ID,
    FACTORY_ASK_ID,
    OPER_USER_ID,
    OPER_CODE,
    STATUS_AF_OPER,
    OPER_TIME,
    REMARKS,
    ASK_RECORD_ID,
    oper_user_company_id)
 VALUES
   ((SELECT SCMDATA.F_GET_UUID() FROM DUAL),
    :FACTORY_ASK_ID,
    :USER_ID,
    'RETURN',
    STATUS,
    SYSDATE,
    ^'|| CHR(64) ||q'^AUDIT_COMMENT^'|| CHR(64) ||q'^,
    :ASK_RECORD_ID,
    %default_company_id%);
    END IF;
  ELSE
    RAISE_APPLICATION_ERROR(-20002, '新增的意向合作供应商不可以退回！');
  END IF;
END;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''ac_a_coop_150_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[退回]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''ac_a_coop_150_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[退回]'',''ac_a_coop_150_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (^'|| CHR(64) ||q'^selection)) LOOP

    v_supplier_info_id := supplier_info_rec.supplier_info_id;
    sf_supplier_info_pkg.update_supp_info_bind_status(p_supplier_info_id => v_supplier_info_id,
                                                      p_status           => 0);

  END LOOP;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_120_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[解绑]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_120_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[解绑]'',''action_a_supp_120_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--修改：启用、停用增加输入原因
DECLARE
BEGIN
  --zc314 add
  FOR i IN (SELECT supplier_info_id, company_id, supplier_code
              FROM scmdata.t_supplier_info
             WHERE supplier_info_id IN (%selection%)
               AND company_id = %default_company_id%) LOOP

    pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => i.supplier_info_id,
                                                  p_reason           => ^'|| CHR(64) ||q'^d_reason_sp^'|| CHR(64) ||q'^,
                                                  p_status           => 1,
                                                  p_user_id          => :user_id,
                                                  p_company_id       => i.company_id);
    --启停合作工厂关系
    pkg_supplier_info.p_check_sup_fac_pause(p_company_id => i.company_id,
                                            p_sup_id     => i.supplier_info_id);

    scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => %current_userid%,
                                                  v_compid    => %default_company_id%,
                                                  v_tab       => 'SCMDATA.T_SUPPLIER_INFO',
                                                  v_viewtab   => NULL,
                                                  v_unqfields => 'SUPPLIER_INFO_ID,COMPANY_ID',
                                                  v_ckfields  => 'PAUSE,UPDATE_ID,UPDATE_DATE',
                                                  v_conds     => 'SUPPLIER_INFO_ID = ''' ||
                                                                 i.supplier_info_id ||
                                                                 ''' AND COMPANY_ID = ''' ||
                                                                 i.company_id || '''',
                                                  v_method    => 'UPD',
                                                  v_viewlogic => NULL,
                                                  v_queuetype => 'CAPC_SUPCAPCAPP_INFO_U');

    --zwh73 qc工厂配置禁用
    scmdata.pkg_qcfactory_config.p_status_qc_factory_config_by_factory(p_factory_code => i.supplier_code,
                                                                       p_company_id   => i.company_id,
                                                                       p_status       => 1);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[停用]'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[停用]'',''action_a_supp_160_2'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--修改：启用、停用增加输入原因
DECLARE
BEGIN
  --zc314 add
  FOR i IN (SELECT supplier_info_id, company_id, supplier_code
              FROM scmdata.t_supplier_info
             WHERE supplier_info_id IN (%selection%)
               AND company_id = %default_company_id%) LOOP

    pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => i.supplier_info_id,
                                                  p_reason           => ^'|| CHR(64) ||q'^u_reason_sp^'|| CHR(64) ||q'^,
                                                  p_status           => 0,
                                                  p_user_id          => :user_id,
                                                  p_company_id       => i.company_id);
    --启停合作工厂关系
    pkg_supplier_info.p_check_sup_fac_pause(p_company_id => i.company_id,
                                            p_sup_id     => i.supplier_info_id);

    scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => %current_userid%,
                                                  v_compid    => %default_company_id%,
                                                  v_tab       => 'SCMDATA.T_SUPPLIER_INFO',
                                                  v_viewtab   => NULL,
                                                  v_unqfields => 'SUPPLIER_INFO_ID,COMPANY_ID',
                                                  v_ckfields  => 'PAUSE,UPDATE_ID,UPDATE_DATE',
                                                  v_conds     => 'SUPPLIER_INFO_ID = ''' ||
                                                                 i.supplier_info_id ||
                                                                 ''' AND COMPANY_ID = ''' ||
                                                                 i.company_id || '''',
                                                  v_method    => 'UPD',
                                                  v_viewlogic => NULL,
                                                  v_queuetype => 'CAPC_SUPCAPCAPP_INFO_U');

    --zwh73 qc工厂配置禁用
    scmdata.pkg_qcfactory_config.p_status_qc_factory_config_by_factory(p_factory_code => i.supplier_code,
                                                                       p_company_id   => i.company_id,
                                                                       p_status       => 0);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[启用]'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[启用]'',''action_a_supp_160_1'',q''[]'',q''[]'',1,0,q''[]'',1,0,q''[]'',1,0,2,q''[supplier_info_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
  judge                      NUMBER;
  v_judge                    NUMBER;
  v_count                    NUMBER;
  v1_count                   NUMBER;
  v_check_report_file        VARCHAR2(1280);
  v_person_config_result     VARCHAR2(32);
  v_machine_equipment_result VARCHAR2(32);
  v_control_result           VARCHAR2(32);
  v_check_say                VARCHAR2(4000);
  v_check_result             VARCHAR2(32);
  v_company_name             VARCHAR2(256);
BEGIN
  scmdata.pkg_factory_inspection.p_jug_report_result(v_frid   => :factory_report_id,
                                                     v_compid => %default_company_id%);
---lsl add 20230113 (验厂管理9.10版)新增校验
  select count(*)
    into v_count
    from scmdata.t_quality_control_fr
   where factory_report_id = :factory_report_id
     and is_quality_control is null;
  if v_count > 0 then
    raise_application_error(-20002, '品控体系内容页面有必填项未维护');
  end if;
  select count(*)
    into v1_count
    from scmdata.t_factory_report
   where spot_check_result is null
     and factory_report_id = :factory_report_id;
  if v1_count > 0 then
    raise_application_error(-20002, '品控体系内容页面有必填项未维护');
  end if;
---lsl end
  SELECT MAX(fr.certificate_file),
         MAX(fr.person_config_result),
         MAX(fr.machine_equipment_result),
         MAX(fr.control_result),
         MAX(fr.check_say),
         MAX(fr.check_result)
    INTO v_check_report_file,
         v_person_config_result,
         v_machine_equipment_result,
         v_control_result,
         v_check_say,
         v_check_result
    FROM scmdata.t_factory_report fr
   WHERE fr.company_id = %default_company_id%
     AND fr.factory_ask_id = :factory_ask_id;

  SELECT decode(v_check_result, NULL, 0, 1) + decode(v_check_say, ' ', 0, 1) +
         decode(v_person_config_result, NULL, 0, 1) +
         decode(v_machine_equipment_result, NULL, 0, 1) +
         decode(v_control_result, NULL, 0, 1) +
         decode(v_check_report_file, NULL, 0, 1)
    INTO judge
    FROM dual;

  IF judge >= 6 THEN
    SELECT COUNT(factory_report_ability_id)
      INTO judge
      FROM scmdata.t_factory_report_ability
     WHERE factory_report_id = :factory_report_id
       AND (cooperation_subcategory IS NULL OR ability_result IS NULL OR
           ability_result = ' ');
    IF judge = 0 THEN
      SELECT COUNT(factory_ask_id)
        INTO v_judge
        FROM scmdata.t_factory_ask
       WHERE factrory_ask_flow_status <> 'FA11'
         AND factory_ask_id =
             (SELECT factory_ask_id
                FROM scmdata.t_factory_report
               WHERE factory_report_id = :factory_report_id);
      IF v_judge = 0 THEN

        UPDATE scmdata.t_factory_report
           SET check_user_id = %current_userid%,
               create_id     = %current_userid%
         WHERE factory_ask_id = :factory_ask_id
           AND company_id = %default_company_id%;


  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => 'SUBMIT', --流程操作方式编码
                                                               p_flow_af_status   => 'FA13', --操作后流程状态
                                                               p_memo             => ^'|| CHR(64) ||q'^audit_comment^'|| CHR(64) ||q'^);

      ---lsl add 20230113 (验厂管理9.10版)消息推送
        SELECT company_name
          INTO v_company_name
          FROM scmdata.t_factory_report
         WHERE factory_ask_id = :factory_ask_id;
        for w in (select cooperation_classification, cooperation_product_cate, cooperation_subcategory
                    from scmdata.t_factory_report_ability
                   where factory_report_id = :factory_report_id) loop
          if w.cooperation_classification = '08' then
            if (w.cooperation_product_cate = '111' or w.cooperation_product_cate = '113' or w.cooperation_product_cate = '114') then
              ----走个人企微推送模板表___发送给康平
              scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                                    v_supplier     => v_company_name,
                                                                    v_pattern_code => 'FR_SUBMIT_00',
                                                                    v_user_id      => '',
                                                                    v_type         => 1);
            else
              ----走个人企微推送模板表___发送给叶其林
              scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                                    v_supplier     => v_company_name,
                                                                    v_pattern_code => 'FR_SUBMIT_01',
                                                                    v_user_id      => '',
                                                                    v_type         => 1);
            end if;
          else
            if w.cooperation_subcategory = '070602' then
              ----走个人企微推送模板表___发送给康平
              scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                                    v_supplier     => v_company_name,
                                                                    v_pattern_code => 'FR_SUBMIT_00',
                                                                    v_user_id      => '',
                                                                    v_type         => 1);
            end if;
            ----走个人企微推送模板表___发送给叶其林
            scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                                  v_supplier     => v_company_name,
                                                                  v_pattern_code => 'FR_SUBMIT_01',
                                                                  v_user_id      => '',
                                                                  v_type         => 1);
          end if;
        end loop;
        ---lsl end
      ELSE
        raise_application_error(-20004,
                                '已有单据在流程中或该供应商已准入通过，请勿重复提交！');
      END IF;
    ELSE
      raise_application_error(-20003, '请将能力评估表填写完成后再提交！');
    END IF;
  ELSE
    raise_application_error(-20002, '请填写页面必填项后再提交！');
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^select 1 from dual^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_101_1_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_101_1_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_check_101_1_0'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^declare
v_flag number := 1;
begin
       if v_flag = 1 then
          raise_application_error(-20002,'此按钮暂不支持上传功能，请从右侧工具栏进行导入数据！');
       end if;
end;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_1_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[上传]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_1_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[上传]'',''action_a_supp_160_1_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^
 delete from scmdata.t_coop_scope_temp a where a.company_id=%default_company_id% and a.create_id=%user_id%^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_170''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[导入合作范围]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_170''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[导入合作范围]'',''action_a_supp_170'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^delete from scmdata.t_contract_info_temp a where a.company_id=%default_company_id% and a.user_id= :user_id^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_180_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[重置]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_180_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[重置]'',''action_a_supp_180_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
v_audit_comment varchar2(256) := ^'|| CHR(64) ||q'^audit_comment_fr^'|| CHR(64) ||q'^;
v_memo CLOB := ^'|| CHR(64) ||q'^memo_fr^'|| CHR(64) ||q'^;
v_company_name varchar2(256);
BEGIN
  UPDATE scmdata.t_factory_report t
     SET t.factory_result_suggest = '不通过'
   WHERE t.factory_report_id = :factory_report_id;
  --供应链总监需审核验厂审核不通过的单据   需流入准入待审批
  --流程操作记录
  v_memo := case when v_memo is not null then '审核意见：'||chr(13)||v_audit_comment||chr(13)||';备注:'||chr(13)||v_memo else '审核意见：'||chr(13)||v_audit_comment end;

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => 'UNPASS', --流程操作方式编码
                                                               p_flow_af_status   => 'FA12', --操作后流程状态
                                                               p_memo             => v_memo);

---lsl add 20230114 (验厂管理9.10版)消息推送
  SELECT max(company_name)
    INTO v_company_name
    FROM scmdata.t_factory_report
   WHERE factory_report_id = :factory_report_id;
  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FR_AUDIT_00',
                                                        v_user_id      => '',
                                                        v_type         => 1);
--lsl end
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_102_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[不通过]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_102_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[不通过]'',''action_a_check_102_2'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select 1 from dual^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_151_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[导入合同]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_151_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[导入合同]'',''action_a_supp_151_5'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
v_audit_comment varchar2(256) := ^'|| CHR(64) ||q'^audit_comment_fr^'|| CHR(64) ||q'^;
v_memo CLOB := ^'|| CHR(64) ||q'^memo_fr^'|| CHR(64) ||q'^;
v_company_name varchar2(256);
BEGIN
  UPDATE scmdata.t_factory_report t
     SET t.factory_result_suggest = '不通过'
   WHERE t.factory_report_id = :v_factory_report_id;
  --供应链总监需审核验厂审核不通过的单据   需流入准入待审批
  --流程操作记录
  v_memo := case when v_memo is not null then '审核意见：'||chr(13)||v_audit_comment||chr(13)||';备注:'||chr(13)||v_memo else '审核意见：'||chr(13)||v_audit_comment end;

  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => 'UNPASS', --流程操作方式编码
                                                               p_flow_af_status   => 'FA12', --操作后流程状态
                                                               p_memo             => v_memo);

---lsl add 20230114 (验厂管理9.10版)消息推送
  SELECT max(company_name)
    INTO v_company_name
    FROM scmdata.t_factory_report
   WHERE factory_report_id = :v_factory_report_id;
  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FR_AUDIT_00',
                                                        v_user_id      => '',
                                                        v_type         => 1);
--lsl end
END;

/*DECLARE
v_audit_comment varchar2(256) := ^'|| CHR(64) ||q'^audit_comment_fr^'|| CHR(64) ||q'^;
v_memo CLOB := ^'|| CHR(64) ||q'^memo_fr^'|| CHR(64) ||q'^;
BEGIN
  UPDATE scmdata.t_factory_report t
     SET t.factory_result_suggest = '不通过'
   WHERE t.factory_report_id = :factory_report_id;
  --供应链总监需审核验厂审核不通过的单据   需流入准入待审批
  --流程操作记录
  v_memo := case when v_memo is not null then '审核意见：'||chr(13)||v_audit_comment||chr(13)||';备注:'||chr(13)||v_memo else '审核意见：'||chr(13)||v_audit_comment end;
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => 'UNPASS',  --'UNPASS',
                                              p_fac_ask_flow => 'FA12',  --'FA14',
                                              p_memo         => v_memo);
END;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_103_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[不通过]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_103_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[不通过]'',''action_a_check_103_2'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh add 在原有基础上增加消息（通知申请公司，通知被申请公司）
DECLARE
  p_i INT;
  --czh add消息
  v_becompany_name         VARCHAR2(100);
  v_company_name           VARCHAR2(100);
  v_cooperation_company_id VARCHAR2(100);
  v_bemsg                  VARCHAR2(4000);
  v_betarget_user          VARCHAR2(4000);
  v_msg                    VARCHAR2(4000);
  v_target_user            VARCHAR2(4000);

BEGIN
  SELECT nvl(MAX(1), 0)
    INTO p_i
    FROM scmdata.t_ask_scope
   WHERE object_id = :ask_record_id
     AND object_type = 'HZ';
  IF p_i = 0 THEN
    raise_application_error(-20002, '请至少填写一个合作意向范围');
  END IF;
  IF :ask_date IS NOT NULL THEN
    raise_application_error(-20002, '已提交过的申请,不可重复提交');
  END IF;

  pkg_ask_record_mange.has_coop_submit(pi_be_company_id      => :be_company_id,
                                       pi_social_credit_code => :social_credit_code);

  UPDATE t_ask_record
     SET ask_user_id  = :user_id,
         sapply_user =
         (SELECT MAX(company_user_name)
            FROM sys_company_user
           WHERE user_id = :user_id
             AND company_id = %default_company_id%),
         sapply_phone =
         (SELECT phone FROM sys_user WHERE user_id = :user_id)
   WHERE ask_record_id = :ask_record_id;

  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id    => %default_company_id%,
                                              p_user_id       => :user_id,
                                              p_ask_record_id => :ask_record_id,
                                              p_flow_status   => 'SUBMIT',
                                              p_fac_ask_flow  => 'CA01',
                                              p_memo          => '');

  --czh add 企业主动申请：企业申请成功通知：系统自动通知被申请企业（无需配置通知人员）

  SELECT (SELECT a.logn_name
            FROM scmdata.sys_company a
           WHERE a.company_id = fa.company_id) company_name,
         (SELECT b.logn_name
            FROM scmdata.sys_company b
           WHERE b.company_id = fa.be_company_id) becompany_name,
         fa.be_company_id
    INTO v_company_name, v_becompany_name, v_cooperation_company_id
    FROM scmdata.t_ask_record fa
   WHERE fa.company_id = %default_company_id%
     AND fa.be_company_id = :be_company_id;

  --1)通知申请公司
  v_msg := '尊敬的[' || v_company_name || ']公司，恭喜您已成功申请为我司[' ||
           v_becompany_name || ']的供应商，期待合作！';

  v_target_user := scmdata.pkg_msg_config.get_company_admin(%default_company_id%);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '企业申请成功通知',
                                         p_msg_content => v_msg,
                                         p_target_user => v_target_user,
                                         p_sender_name => v_becompany_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');

  --2)通知被申请公司  通知被申请公司：尊敬的Y公司，X公司已申请成为您的供应商，期待合作！
  v_bemsg := '尊敬的[' || v_becompany_name || ']公司，我司[' || v_company_name ||
             ']已申请成为您的供应商，期待合作！';

  v_betarget_user := scmdata.pkg_msg_config.get_company_admin(v_cooperation_company_id);

  scmdata.pkg_msg_config.config_plag_msg(p_msg_id      => scmdata.f_get_uuid(),
                                         p_urgent      => 0,
                                         p_msg_title   => '企业申请成功通知',
                                         p_msg_content => v_bemsg,
                                         p_target_user => v_betarget_user,
                                         p_sender_name => v_company_name,
                                         p_msg_type    => 'SYSTEM',
                                         p_object_id   => '');

END;

--原逻辑
/*declare
  p_i int;
begin
  select nvl(max(1), 0)
    into p_i
    from scmdata.t_ask_scope
   where object_id = :ask_record_id
     and object_type = 'HZ';
  if p_i = 0 then
    raise_application_error(-20002, '请至少填写一个合作意向范围');
  end if;
  if :ask_date is not null then
    raise_application_error(-20002, '已提交过的申请不需要重复提交');
  end if;
  /*
  if pkg_ask_record_mange.is_access_audit_pass(:company_id, :be_company_id) = 1 then
    raise_application_error(-20002,
                            '您已通过该企业的准入合作，不可重新发起申请！');
  end if;
  if pkg_ask_record_mange.is_cooperation_running(:company_id,
                                                 :be_company_id) = 1 then
    raise_application_error(-20002, '存在申请中的表单，请耐心等待');
  end if;
  */

pkg_ask_record_mange.has_coop_submit(pi_be_company_id => :be_company_id, pi_social_credit_code =>:social_credit_code );

 update t_ask_record
   set ask_user_id          = :user_id,
       ask_date             = sysdate,
       sapply_user         =
       (select max(company_user_name)
          from sys_company_user
         where user_id = :user_id
           and company_id = %default_company_id%),
       sapply_phone        =
       (select phone from sys_user where user_id = :user_id),
       COOR_ASK_FLOW_STATUS = 'CA01'
 where ask_record_id = :ask_record_id;
insert into t_factory_ask_oper_log
  (log_id,
   ask_record_id,
   oper_user_id,
   oper_code,
   oper_time,
   status_af_oper,
   oper_user_company_id)
values
  (f_get_uuid(),
   :ask_record_id,
   :user_id,
   'SUBMIT',
   sysdate,
   'CA01',
   %default_company_id%);

end;*/^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_121''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',0,1,q''[]'',0,1,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_121''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_coop_121'',q''[]'',q''[]'',0,1,q''[]'',0,1,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--czh 重构代码
DECLARE
  v_ask_record_id VARCHAR2(32);
  v_company_name  VARCHAR2(256);
BEGIN

  --获取ask_record_id
  v_ask_record_id := scmdata.pkg_plat_comm.f_get_rest_val_method_params(p_character => :ask_record_id,
                                                                        p_rtn_type  => 1);

  --1.请填写意向合作范围后提交
  scmdata.pkg_ask_record_mange_a.p_check_t_ask_scope(p_ask_record_id => v_ask_record_id,
                                                     p_company_id    => %default_company_id%);

  --2.校验流程中是否已有单据
  scmdata.pkg_ask_record_mange_a.p_check_is_has_factory_ask(p_ask_record_id => v_ask_record_id,
                                                            p_company_id    => %default_company_id%);
  --3.提交后,更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_ask_record_id    => v_ask_record_id, --合作申请单ID
                                                               p_flow_oper_status => 'SUBMIT', --流程操作方式编码
                                                               p_flow_af_status   => 'FA02', --操作后流程状态
                                                               p_memo             => NULL);
  --lsl add 20230116
  --个人企微消息推送
  SELECT company_name
    INTO v_company_name
    FROM scmdata.t_factory_ask
   WHERE factory_ask_id = :factory_ask_id;

  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FA_SUBMIT_00',
                                                        v_user_id      => '',
                                                        v_type         => 1);
  --lsl end
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''ac_a_coop_150_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''ac_a_coop_150_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''ac_a_coop_150_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
BEGIN
    INSERT INTO T_FACTORY_ASK_OPER_LOG
    (LOG_ID,
     FACTORY_ASK_ID,
     OPER_USER_ID,
     OPER_CODE,
     STATUS_AF_OPER,
     REMARKS,
     ASK_RECORD_ID,
     OPER_TIME,
     oper_user_company_id)
  VALUES
    (F_GET_UUID(),
     :FACTORY_ASK_ID,
     :USER_ID,
     'SUBMIT',
     'FA11',
     NULL,
     (SELECT ASK_RECORD_ID
        FROM T_FACTORY_ASK
       WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID),
     SYSDATE,
     %DEFAULT_COMPANY_ID%);
  UPDATE SCMDATA.T_FACTORY_ASK
   SET FACTRORY_ASK_FLOW_STATUS = 'FA11'
 WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_101_1_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[撤销提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',0,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_101_1_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[撤销提交]'',''action_a_check_101_1_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',0,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE

BEGIN
  UPDATE SCMDATA.T_QA_SCOPE
     SET COMMIT_TYPE = 'PC'
   WHERE QA_REPORT_ID IN (^'|| CHR(64) ||q'^SELECTION^'|| CHR(64) ||q'^);

  UPDATE SCMDATA.T_QA_REPORT
     SET COMFIRM_RESULT = NULL,
         STATUS = 'N_PCF',
         COMFIRM_MEMO = '测试'
   WHERE QA_REPORT_ID IN (^'|| CHR(64) ||q'^SELECTION^'|| CHR(64) ||q'^);
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_error_btn''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[单据状态回退]'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,2,q''[QA_REPORT_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_error_btn''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[单据状态回退]'',''action_error_btn'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,2,q''[QA_REPORT_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^CALL scmdata.pkg_supplier_info.submit_supplier_info_temp(p_company_id => %default_company_id%,p_user_id => %user_id%)^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_1_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_1_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_supp_160_1_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^SELECT gt.kit_template_code, gt.template_name, gt.kit_template_file_id
  FROM scmdata.sys_group_template_type t, scmdata.sys_group_template gt
 WHERE t.template_type_id = gt.template_type_id
   AND t.template_type_code = 'SUPP_IMPORT'
   and gt.kit_template_code='S0001'^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_160_1_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 0,q''[]'',q''[下载模板]'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_160_1_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 0,q''[]'',q''[下载模板]'',''action_a_supp_160_1_1'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^SELECT gt.kit_template_code, gt.template_name, gt.kit_template_file_id
  FROM scmdata.sys_group_template_type t, scmdata.sys_group_template gt
 WHERE t.template_type_id = gt.template_type_id
   AND t.template_type_code = 'SUPP_IMPORT'
   and gt.kit_template_code='S0002'^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_170_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 0,q''[]'',q''[下载模板]'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_170_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 0,q''[]'',q''[下载模板]'',''action_a_supp_170_1'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^SELECT 1 FROM DUAL^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[新增意向供应商]'',q''[]'',q''[two_word_150]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[新增意向供应商]'',''action_a_coop_150_0'',q''[]'',q''[two_word_150]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

