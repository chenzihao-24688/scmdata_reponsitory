BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[call sf_supplier_info_pkg.submit_t_supplier_info(p_supplier_info_id => :supplier_info_id,
                                                 p_default_company_id => %default_company_id%,
                                                 p_user_id => %CURRENTUSERID%)]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[DECLARE
  v_share_method VARCHAR2(100) := @share_method@;
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

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (@selection)) LOOP

    v_supplier_info_id := supplier_info_rec.supplier_info_id;
    sf_supplier_info_pkg.update_supp_info_bind_status(p_supplier_info_id => v_supplier_info_id,
                                                      p_status           => 0);

  END LOOP;

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (@selection)) LOOP

    v_supplier_info_id := supplier_info_rec.supplier_info_id;

    sf_supplier_info_pkg.update_supp_info_bind_status(p_supplier_info_id => v_supplier_info_id,
                                                      p_status           => 1);

  END LOOP;

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[{DECLARE
  v_sql VARCHAR2(4000);
  --v_i   VARCHAR2(100);
BEGIN
   /*--1.初始跑批日期
    v_i   := '2004';
   --2.查询监控表跑批日期，并重写初始值
   select decode(max(t.batch_time),null,v_i,max(t.batch_time) + 1)  into v_i from scmdata.t_supplier_info_ctl t;*/

  --获取跑批日期
  --v_i :=  pkg_supplier_info.get_supp_batch_time;

   v_sql := 'select ''' || '' || ''' BATCH_TIME,'''' SUP_ID_BASE,'''' SUP_NAME,'''' LEGALPERSON, '''' LINKMAN,'''' PHONENUMBER,'''' ADDRESS,'''' SUP_TYPE,'''' INSERTTIME,'''' LASTMODIFYTIME,'''' SUP_STATUS,'''' COUNTYID,'''' PROVINCEID,'''' CITYNO,'''' TAX_ID,'''' COMPANY_TYPE,'''' SEND_TIME FROM dual';

    --dbms_output.put_line(v_sql);
    @StrResult := v_sql;
END;}]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_itf_id     VARCHAR2(32);
  v_ctl_id     VARCHAR2(32);
  v_flag       VARCHAR2(32);
  v_supp_info_id  VARCHAR2(100);
  v_itf_flag   NUMBER;
  supp_itf_rec t_supplier_base_itf%ROWTYPE;
  supp_ctl_rec t_supplier_info_ctl%ROWTYPE;
BEGIN

  SELECT COUNT(1)
    INTO v_itf_flag
    FROM t_supplier_base_itf t
   WHERE t.sup_id_base = :sup_id_base;

  --判断接口表是否已经存在scm传过来的数据

  IF v_itf_flag > 0 THEN
     raise_application_error(-20002,'181数据已全部同步至scm，无新增数据！');
  ELSE
  --1.接口表
  v_itf_id := scmdata.f_get_uuid();

  INSERT INTO t_supplier_base_itf
    (itf_id,
     sup_id_base,
     sup_name,
     legalperson,
     linkman,
     phonenumber,
     address,
     sup_type,
     inserttime,
     lastmodifytime,
     lastpublishtime,
     sup_status,
     countyid,
     provinceid,
     cityno,
     tax_id,
     company_type)
  VALUES
    (v_itf_id,
     :sup_id_base,
     :sup_name,
     :legalperson,
     :linkman,
     :phonenumber,
     :address,
     :sup_type,
     :inserttime,
     :lastmodifytime,
     :lastpublishtime,
     :sup_status,
     :countyid,
     :provinceid,
     :cityno,
     :tax_id,
     :company_type);

  --2.接口表数据校验(待晓萍确认后开发)

  --3.记录接口表信息到监控表

  v_ctl_id := scmdata.f_get_uuid();

  INSERT INTO t_supplier_info_ctl
    (ctl_id,
     itf_id,
     itf_type,
     batch_id,
     batch_num,
     batch_time,
     sender,
     receiver,
     send_time,
     receive_time,
     return_type,
     return_msg,
     create_id,
     create_time,
     update_id,
     update_time)
  VALUES
    (v_ctl_id,
     v_itf_id,
     '供应商接口导入',
     '',
     '',
     :batch_time,
     '181',
     'scm',
     :send_time,
     SYSDATE,
     'Y', --根据校验数据确定,待确定
     '数据校验成功', --根据校验数据确定,待确定
     'czh',
     SYSDATE,
     'czh',
     SYSDATE);

  --判断监控表数据是否正确，判断错误，是该批全部回滚还是，部分回滚
  --select nvl(max(t.return_type),'N') INTO v_flag from t_supplier_info_ctl t where t.ctl_id = v_ctl_id;

  v_flag := 'Y';
  IF v_flag = 'Y' THEN

    --从接口拿数据
    SELECT *
      INTO supp_itf_rec
      FROM t_supplier_base_itf t
     WHERE t.itf_id = v_itf_id;

   v_supp_info_id := scmdata.f_get_uuid();

    --4.最终接口导入到业务表
    INSERT INTO scmdata.t_supplier_info
      (supplier_info_id,
       company_id,
       supplier_info_origin_id,
       inside_supplier_code,
       supplier_company_id,
       supplier_company_name,
       supplier_company_abbreviation,
       company_create_date,
       legal_representative,
       create_id,
       create_date,
       regist_address,
       company_address,
       certificate_validity_start,
       certificate_validity_end,
       regist_price,
       social_credit_code,
       company_type,
       company_person,
       company_contact_person,
       company_contact_phone,
       taxpayer,
       company_say,
       certificate_file,
       organization_file,
       --能力评估
       cooperation_method,
       cooperation_model,
       cooperation_type,
       production_mode,
       sharing_type,
       supplier_info_origin,
       pause,
       status)
    VALUES
      (v_supp_info_id,
       %default_company_id%,
       '',
       supp_itf_rec.sup_id_base,
       '',
       supp_itf_rec.sup_name,
       to_char(supp_itf_rec.sup_name),
       '',
       '',
       %currentuserid%,
       SYSDATE,
       '',
       '',
       '',
       '',
       '',
       nvl(supp_itf_rec.tax_id, '啥也没有'),
       '',
       '',
       supp_itf_rec.linkman,
       supp_itf_rec.phonenumber,
       '',
       '',
       '',
       '',
       --能力评估
       '',
       supp_itf_rec.sup_type,
       'COOPERATION_CLASSIFICATION',
       '',
       '00',
       'II',
       0,
       0);

     -- 提交=》已建档     报网关错误
     /*scmdata.pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => v_supp_info_id,
                                                      p_default_company_id => %default_company_id%,
                                                      p_user_id           => %currentuserid%);*/
  END IF;
END IF;
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_110''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 8,q''[]'',q''[获取供应商信息]'',q''[]'',q''[]'',0,,q''[method_a_supp_110]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_110''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 8,q''[]'',q''[获取供应商信息]'',''action_a_supp_110'',q''[]'',q''[]'',0,,q''[method_a_supp_110]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'[/*DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (@selection)) LOOP

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
                                                   p_reason           => @U_REASON_SP@,
                                                   p_status           => 0,
                                                   p_user_id          => v_user_id,
                                                   p_company_id       => %default_company_id%);

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[/*DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (@selection)) LOOP

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
                                                   p_reason           => @D_REASON_SP@,
                                                   p_status           => 1,
                                                   p_user_id          => v_user_id,
                                                   p_company_id       => %default_company_id%);

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

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
  CV1 CLOB:=q'[SELECT * FROM scmdata.t_supplier_info_ctl t ORDER BY t.batch_time DESC]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_110_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[查看接口监控]'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_110_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[查看接口监控]'',''action_a_supp_110_1'',q''[]'',q''[]'',0,,q''[]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'[--181=>scm
SELECT '' data_status,
       '' supplier_code,
       '' sup_id_base,
       '' sup_name,
       '' create_id,
       '' create_date_itf,
       '' update_id,
       '' update_time,
       '' send_time,
       --scm => 181  请求参数
       'scm' send_flag,
        1    fet_flag,
       to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') fet_time,
       to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')  send_time
  FROM dual]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_itf_id       VARCHAR2(32);
  v_ctl_id       VARCHAR2(32);
  v_flag         VARCHAR2(32);
  v_supp_info_id VARCHAR2(100);
  v_itf_flag     NUMBER;
  supp_itf_rec   t_supplier_base_itf%ROWTYPE;
  supp_ctl_rec   t_supplier_info_ctl%ROWTYPE;
BEGIN

  SELECT COUNT(1)
    INTO v_itf_flag
    FROM t_supplier_base_itf t
   WHERE t.sup_id_base = :sup_id_base;

  --判断接口表是否已经存在181回传供应商编码

  IF v_itf_flag > 0 THEN
    null;
  ELSE
    --1.接口表
    v_itf_id := sys_guid();
    -- 1.记录接口表信息
    INSERT INTO t_supplier_base_itf
      (itf_id,
       supplier_code,
       sup_id_base,
       sup_name,
       legalperson,
       linkman,
       phonenumber,
       address,
       sup_type,
       sup_type_name,
       sup_status,
       countyid,
       provinceid,
       cityno,
       tax_id,
       cooperation_model,
       create_id,
       create_time,
       update_id,
       update_time,
       publish_id,
       publish_time,
       data_status,
       fetch_flag,
       pause,
       supp_date,
       memo)
    VALUES
      (v_itf_id,
       :supplier_code,
       :sup_id_base,
       :sup_name,
       '',
       '',
       '',
       '',
       '',
       '',
       '',
       '',
       '',
       '',
       '',
       '',
       :create_id,
       to_date(:create_date_itf, 'yyyy-mm-dd hh24:mi:ss'),
       :update_id,
       to_date(:update_time, 'yyyy-mm-dd hh24:mi:ss'),
       '181',
       sysdate,
       'I',
       1,
       '',
       '',
       '');
    --2.记录接口表信息到监控表

    v_ctl_id := sys_guid();

    INSERT INTO t_supplier_info_ctl
      (ctl_id,
       itf_id,
       itf_type,
       batch_id,
       batch_num,
       batch_time,
       sender,
       receiver,
       send_time,
       receive_time,
       return_type,
       return_msg)
    VALUES
      (v_ctl_id,
       v_itf_id,
       '供应商获取回传编号',
       '',
       '',
       '',
       '181',
       'scm',
       to_date(:send_time, 'yyyy-mm-dd hh24:mi:ss'),
       SYSDATE,
       'Y', --根据校验数据确定,待确定
       '数据校验成功' --根据校验数据确定,待确定
       );

    --3.关联供应商档案
    UPDATE scmdata.t_supplier_info sp
       SET sp.inside_supplier_code = :sup_id_base
     WHERE sp.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7' and
     sp.supplier_code = :supplier_code;

  END IF;
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_110_9''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 8,q''[]'',q''[获取mdm回传数据]'',q''[]'',q''[]'',0,,q''[method_a_supp_110_9]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_110_9''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 8,q''[]'',q''[获取mdm回传数据]'',''action_a_supp_110_9'',q''[]'',q''[]'',0,,q''[method_a_supp_110_9]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

