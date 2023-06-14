BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[update scmdata.t_ask_record
  set collection=decode(nvl(collection,0), 0, 1, 0)
where ask_record_id=:ask_record_id]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[--czh 重构代码
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
                                                  p_memo          => @audit_comment@);
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
    @AUDIT_COMMENT@,
    :ASK_RECORD_ID,
    %default_company_id%);
    END IF;
  ELSE
    RAISE_APPLICATION_ERROR(-20002, '新增的意向合作供应商不可以退回！');
  END IF;
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[--czh 重构代码
DECLARE
  jug_num   NUMBER(5);
  jug_str   VARCHAR2(256);
  coop_type VARCHAR2(64);
BEGIN
  scmdata.pkg_ask_record_mange.has_coop_submit(pi_be_company_id      => %default_company_id%,
                                               pi_social_credit_code => :social_credit_code);

  SELECT COUNT(1), listagg(DISTINCT cooperation_type, ',') || ','
    INTO jug_num, jug_str
    FROM scmdata.t_ask_scope
   WHERE object_id = :ask_record_id
     AND company_id = %default_company_id%;

  IF jug_num > 0 THEN
    SELECT cooperation_type || ','
      INTO coop_type
      FROM scmdata.t_ask_record
     WHERE ask_record_id = :ask_record_id
       AND be_company_id = %default_company_id%;

    IF jug_str <> coop_type THEN
      raise_application_error(-20002,
                              '主表合作类型与子表合作类型不符，请修改后再提交！');
    ELSE
      UPDATE scmdata.t_ask_record
         SET create_id = %current_userid%, create_date = SYSDATE
       WHERE ask_record_id = :ask_record_id;

      --流程操作记录
      pkg_ask_record_mange.p_log_fac_records_oper(p_company_id    => %default_company_id%,
                                                  p_user_id       => :user_id,
                                                  p_ask_record_id => :ask_record_id,
                                                  p_flow_status   => 'SUBMIT',
                                                  p_fac_ask_flow  => 'CA01',
                                                  p_memo          => '');

    END IF;
  ELSE
    raise_application_error(-20002, '请填写意向合作范围后再提交！');
  END IF;
END;

--原代码
/*
DECLARE
  jug_num   NUMBER(5);
  jug_str   VARCHAR2(256);
  coop_type VARCHAR2(64);
BEGIN
  scmdata.pkg_ask_record_mange.has_coop_submit(pi_be_company_id      => %default_company_id%,
                                               pi_social_credit_code => :social_credit_code);

  SELECT COUNT(1), listagg(DISTINCT cooperation_type, ',') || ','
    INTO jug_num, jug_str
    FROM scmdata.t_ask_scope
   WHERE object_id = :ask_record_id
     AND company_id = %default_company_id%;

  IF jug_num > 0 THEN
    SELECT cooperation_type || ','
      INTO coop_type
      FROM scmdata.t_ask_record
     WHERE ask_record_id = :ask_record_id
       AND be_company_id = %default_company_id%;

    IF jug_str <> coop_type THEN
      raise_application_error(-20002,
                              '主表合作类型与子表合作类型不符，请修改后再提交！');
    ELSE
      UPDATE scmdata.t_ask_record
         SET coor_ask_flow_status = 'CA01',
             create_id            = %current_userid%,
             create_date          = SYSDATE,
             ask_date             = SYSDATE
       WHERE ask_record_id = :ask_record_id;

      INSERT INTO scmdata.t_factory_ask_oper_log
        (log_id,
         ask_record_id,
         oper_user_id,
         oper_code,
         oper_time,
         status_af_oper,
         oper_user_company_id)
      VALUES
        (scmdata.f_get_uuid(),
         :ask_record_id,
         :user_id,
         'SUBMIT',
         SYSDATE,
         'CA01',
         %default_company_id%);
    END IF;
  ELSE
    raise_application_error(-20002, '请填写意向合作范围后再提交！');
  END IF;
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[--czh 重构代码
DECLARE
  judge         NUMBER(3);
  notice_userid VARCHAR2(32);
  --czh add 消息通知
  vo_target_company VARCHAR2(100);
  vo_target_user    VARCHAR2(4000);
  vo_msg            CLOB;
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

    --流程操作记录
    pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                p_user_id      => :user_id,
                                                p_fac_ask_id   => :factory_ask_id,
                                                p_flow_status  => 'BACK',
                                                p_fac_ask_flow => 'FA02',
                                                p_memo         => @audit_comment@);

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
       'FA02', @AUDIT_COMMENT@, ASKR_ID, SYSDATE,
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
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''ac_a_check_101_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[驳回]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''ac_a_check_101_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[驳回]'',''ac_a_check_101_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'[--czh add 在原有基础上增加消息（通知申请公司，通知被申请公司）
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

end;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[--czh 重构代码
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

END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[--czh 重构代码
DECLARE
  judge NUMBER(5);
BEGIN
  SELECT decode(:factory_name, ' ', 0, 1) + decode(:ask_address, ' ', 0, 1) +
         decode(:contact_name, ' ', 0, 1) +
         decode(:contact_phone, ' ', 0, 1) +
         decode(:checkapply_intro, ' ', 0, 1)
    INTO judge
    FROM dual;
  IF judge >= 5 THEN
    SELECT COUNT(ask_scope_id)
      INTO judge
      FROM scmdata.t_ask_scope
     WHERE object_id = :factory_ask_id;
    IF judge > 0 THEN
      --校验流程中是否已有单据
      SELECT COUNT(factrory_ask_flow_status)
        INTO judge
        FROM (SELECT *
                FROM (SELECT factrory_ask_flow_status
                        FROM scmdata.t_factory_ask
                       WHERE ask_record_id = :ask_record_id
                       ORDER BY create_date DESC)
               WHERE rownum < 3)
       WHERE factrory_ask_flow_status NOT IN
             ('CA01', 'FA01', 'FA03', 'FA21', 'FA33')
         AND rownum < 2;
      IF judge = 0 THEN
        --流程操作记录
        pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                    p_user_id      => :user_id,
                                                    p_fac_ask_id   => :factory_ask_id,
                                                    p_flow_status  => 'SUBMIT',
                                                    p_fac_ask_flow => 'FA02',
                                                    p_memo         => '');

        UPDATE scmdata.t_factory_ask
           SET ask_user_id      = %current_userid%,
               ask_user_dept_id = %default_dept_id%
         WHERE factory_ask_id = :factory_ask_id;

      ELSE
        raise_application_error(-20004,
                                '已有单据在流程中或该供应商已准入通过，请勿重复提交！');
      END IF;
    ELSE
      raise_application_error(-20003, '请填写意向合作范围后提交！');
    END IF;
  ELSE
    raise_application_error(-20002, '请将必填项填写完成后再提交');
  END IF;
  /*SCMDATA.PKG_MSG_CONFIG.SEND_MSG(P_COMPANY_ID  => %DEFAULT_COMPANY_ID%,
  P_USER_ID     => %CURRENT_USERID%,
  P_MSG_TITLE   => '您有一条新的待验厂申请',
  P_MSG_CONTENT => NULL);*/
END;
--原代码
/*
DECLARE
  JUDGE NUMBER(5);
BEGIN
  SELECT DECODE(:FACTORY_NAME, ' ', 0, 1) + DECODE(:ASK_ADDRESS, ' ', 0, 1) +
         DECODE(:CONTACT_NAME, ' ', 0, 1) +
         DECODE(:CONTACT_PHONE, ' ', 0, 1)+
         DECODE(:CHECKAPPLY_INTRO, ' ', 0, 1)
    INTO JUDGE
    FROM DUAL;
  IF JUDGE >= 5 THEN
    SELECT COUNT(ASK_SCOPE_ID)
      INTO JUDGE
      FROM SCMDATA.T_ASK_SCOPE
     WHERE OBJECT_ID = :FACTORY_ASK_ID;
    IF JUDGE > 0 THEN
      --校验流程中是否已有单据
      SELECT COUNT(FACTRORY_ASK_FLOW_STATUS)
        INTO JUDGE
        FROM (SELECT *
                FROM (SELECT FACTRORY_ASK_FLOW_STATUS
                        FROM SCMDATA.T_FACTORY_ASK
                       WHERE ASK_RECORD_ID = :ASK_RECORD_ID
                       ORDER BY CREATE_DATE DESC)
               WHERE ROWNUM < 3)
       WHERE FACTRORY_ASK_FLOW_STATUS NOT IN
             ('CA01', 'FA01', 'FA03', 'FA21', 'FA33')
         AND ROWNUM < 2;
      IF JUDGE = 0 THEN
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
           'FA02',
           NULL,
           (SELECT ASK_RECORD_ID
              FROM T_FACTORY_ASK
             WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID),
           SYSDATE,
           %default_company_id%);
        UPDATE SCMDATA.T_FACTORY_ASK
           SET FACTRORY_ASK_FLOW_STATUS = 'FA02',
               ASK_USER_ID = %CURRENT_USERID%,
							 ASK_USER_DEPT_ID = %DEFAULT_DEPT_ID%
         WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID;
      ELSE
        RAISE_APPLICATION_ERROR(-20004, '已有单据在流程中或该供应商已准入通过，请勿重复提交！');
      END IF;
    ELSE
      RAISE_APPLICATION_ERROR(-20003, '请填写意向合作范围后提交！');
    END IF;
  ELSE
    RAISE_APPLICATION_ERROR(-20002, '请将必填项填写完成后再提交');
  END IF;
  /*SCMDATA.PKG_MSG_CONFIG.SEND_MSG(P_COMPANY_ID  => %DEFAULT_COMPANY_ID%,
                                  P_USER_ID     => %CURRENT_USERID%,
                                  P_MSG_TITLE   => '您有一条新的待验厂申请',
                                  P_MSG_CONTENT => NULL);*/
END;
*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[--czh 重构代码
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
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[--czh 重构代码
DECLARE
  judge               NUMBER(1);
  v_check_report_file VARCHAR2(32);
BEGIN
  scmdata.pkg_factory_inspection.p_jug_report_result(v_frid   => :factory_report_id,
                                                     v_compid => %default_company_id%);

  SELECT MAX(fr.certificate_file)
    INTO v_check_report_file
    FROM scmdata.t_factory_report fr
   WHERE fr.company_id = %default_company_id%
     AND fr.factory_ask_id = :factory_ask_id;

  SELECT decode(:check_fac_result, NULL, 0, 1) +
         decode(:check_say, ' ', 0, 1) +
         decode(v_check_report_file, NULL, 0, 1)
    INTO judge
    FROM dual;

  IF judge >= 3 THEN
    SELECT COUNT(factory_report_ability_id)
      INTO judge
      FROM scmdata.t_factory_report_ability
     WHERE factory_report_id = :factory_report_id
       AND (cooperation_subcategory IS NULL OR ability_result IS NULL OR
           ability_result = ' ');
    IF judge = 0 THEN
      SELECT COUNT(factory_ask_id)
        INTO judge
        FROM scmdata.t_factory_ask
       WHERE factrory_ask_flow_status <> 'FA11'
         AND factory_ask_id =
             (SELECT factory_ask_id
                FROM scmdata.t_factory_report
               WHERE factory_report_id = :factory_report_id);
      IF judge = 0 THEN
        --流程操作记录
        pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                    p_user_id      => :user_id,
                                                    p_fac_ask_id   => :factory_ask_id,
                                                    p_flow_status  => 'SUBMIT',
                                                    p_fac_ask_flow => 'FA13',
                                                    p_memo         => '');

        UPDATE scmdata.t_factory_report
           SET check_user_id = %current_userid%,
               create_id     = %current_userid%
         WHERE factory_ask_id = :factory_ask_id
           AND company_id = %default_company_id%;
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
END;

--原代码
/*
DECLARE
  JUDGE NUMBER(1);
BEGIN
  SCMDATA.PKG_FACTORY_INSPECTION.P_JUG_REPORT_RESULT(V_FRID   => :FACTORY_REPORT_ID,
                                                     V_COMPID => %DEFAULT_COMPANY_ID%);
  SELECT DECODE(:CHECK_RESULT, ' ', 0, 1) + DECODE(:CHECK_SAY, ' ', 0, 1) +
         DECODE(:CHECK_REPORT_FILE, '{"value":" ","info":null}', 0, 1)
    INTO JUDGE
    FROM DUAL;
  IF JUDGE >= 3 THEN
    SELECT COUNT(FACTORY_REPORT_ABILITY_ID)
      INTO JUDGE
      FROM SCMDATA.T_FACTORY_REPORT_ABILITY
     WHERE FACTORY_REPORT_ID = :FACTORY_REPORT_ID
       AND (COOPERATION_SUBCATEGORY IS NULL OR ABILITY_RESULT IS NULL OR
            ABILITY_RESULT = ' ');
    IF JUDGE = 0 THEN
      SELECT COUNT(FACTORY_ASK_ID)
        INTO JUDGE
        FROM SCMDATA.T_FACTORY_ASK
       WHERE FACTRORY_ASK_FLOW_STATUS <> 'FA11'
         AND FACTORY_ASK_ID =
             (SELECT FACTORY_ASK_ID
                FROM SCMDATA.T_FACTORY_REPORT
               WHERE FACTORY_REPORT_ID = :FACTORY_REPORT_ID);
      IF JUDGE = 0 THEN
        INSERT INTO SCMDATA.T_FACTORY_ASK_OPER_LOG
          (LOG_ID,
           FACTORY_ASK_ID,
           OPER_USER_ID,
           OPER_CODE,
           STATUS_AF_OPER,
           ASK_RECORD_ID,
           OPER_TIME,
           OPER_USER_COMPANY_ID)
        VALUES
          ((SELECT SCMDATA.F_GET_UUID() FROM DUAL),
           :FACTORY_ASK_ID,
           :USER_ID,
           'SUBMIT',
           'FA13',--CZH update FA12 => FA13
           (SELECT ASK_RECORD_ID
              FROM SCMDATA.T_FACTORY_ASK
             WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID),
           SYSDATE,
           %default_company_id%);

        UPDATE SCMDATA.T_FACTORY_ASK
           SET FACTRORY_ASK_FLOW_STATUS = 'FA13'  --CZH update FA12 => FA13
         WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID
           AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

        UPDATE SCMDATA.T_FACTORY_REPORT
           SET CHECK_USER_ID = %CURRENT_USERID%,
               CREATE_ID = %CURRENT_USERID%
         WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID
           AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
      ELSE
        RAISE_APPLICATION_ERROR(-20004, '已有单据在流程中或该供应商已准入通过，请勿重复提交！');
      END IF;
    ELSE
      RAISE_APPLICATION_ERROR(-20003, '请将能力评估表填写完成后再提交！');
    END IF;
  ELSE
    RAISE_APPLICATION_ERROR(-20002, '请填写页面必填项后再提交！');
  END IF;
END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_101_1_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_101_1_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_check_101_1_0'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',3,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'[--czh 重构代码
DECLARE
  judge     NUMBER(1);
  fa_id     VARCHAR2(32);
  fa_status VARCHAR2(32);
  v_type    NUMBER;
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

      --流程操作记录
      pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                  p_user_id      => :user_id,
                                                  p_fac_ask_id   => fa_id,
                                                  p_flow_status  => 'SUBMIT',
                                                  p_fac_ask_flow => 'FA31',
                                                  p_memo         => @apply_reason@);

    ELSE
      raise_application_error(-20002,
                              '仅状态为[验厂申请不通过、准入不通过]的单据才可进行特批申请！');
    END IF;

  ELSE
    raise_application_error(-20002, '找不到验厂申请单，请先申请验厂！');
  END IF;
END;

--原代码
/*
DECLARE
  judge     NUMBER(1);
  fa_id     VARCHAR2(32);
  fa_status VARCHAR2(32);
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

    IF fa_status IN ('FA03', 'FA14', 'FA21') THEN
      UPDATE scmdata.t_factory_ask
         SET factrory_ask_flow_status = 'FA31',
             factory_ask_type         = CASE
                                          WHEN fa_status = 'FA14' THEN
                                           1
                                          ELSE
                                           0
                                        END
      WHERE factory_ask_id = fa_id;

      --zwh73being flow
      INSERT INTO t_factory_ask_oper_log
        (log_id,
         factory_ask_id,
         oper_user_id,
         oper_code,
         status_af_oper,
         remarks,
         ask_record_id,
         oper_time,
         oper_user_company_id)
      VALUES
        (f_get_uuid(),
         fa_id,
         :user_id,
         'SUBMIT',
         'FA31',
         @apply_reason@,
         :ask_record_id,
         SYSDATE,
         %default_company_id%);

      --flow end

    ELSE
      raise_application_error(-20002,
                              '仅状态为[验厂申请不通过、验厂审核不通过、准入不通过]的单据才可进行特批申请！');
    END IF;

  ELSE
    raise_application_error(-20002, '找不到验厂申请单，请先申请验厂！');
  END IF;
END;*、]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_specialapply''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[特批申请]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_specialapply''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[特批申请]'',''action_specialapply'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'[SELECT 1 FROM DUAL]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[新增意向供应商]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[新增意向供应商]'',''action_a_coop_150_0'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'[DECLARE
  p_trialorder_type VARCHAR2(32);
  p_is_trialorder   VARCHAR2(32);
  p_audit_comment   VARCHAR2(256);
BEGIN
  p_is_trialorder   := @is_trialorder@;
  p_trialorder_type := @trialorder_type@;
  p_audit_comment   := @audit_comment_sp@;

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
                                              p_memo         => '');

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[通过]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[通过]'',''action_a_check_102_1'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'[DECLARE
BEGIN
  UPDATE scmdata.t_factory_report t
     SET t.factory_result_suggest = '不通过'
   WHERE t.factory_report_id = :factory_report_id;
  --供应链总监需审核验厂审核不通过的单据   需流入准入待审批
  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => 'UNPASS',  --'UNPASS',
                                              p_fac_ask_flow => 'FA12',  --'FA14',
                                              p_memo         => @audit_comment@);

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[BEGIN
  --流程操作记录
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => 'BACK',
                                              p_fac_ask_flow => 'FA11',
                                              p_memo         => @audit_comment@);
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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

