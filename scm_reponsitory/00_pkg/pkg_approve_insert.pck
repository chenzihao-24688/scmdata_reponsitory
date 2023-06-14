CREATE OR REPLACE PACKAGE SCMDATA.PKG_APPROVE_INSERT IS

  --批版记录表单行插入-新增
  PROCEDURE P_INSERT_APPROVE_VERSION(COMP_ID IN VARCHAR2,
                                     GOOD_ID IN VARCHAR2,
                                     AV_ID   IN VARCHAR2,
                                     OI_STR  IN VARCHAR2,
                                     CRE_ID  IN VARCHAR2);

  --风险评估表单行插入-新增
  PROCEDURE P_INSERT_RISK_ASSESSMENT(COMP_ID IN VARCHAR2,
                                     ATYPE   IN VARCHAR2,
                                     AV_ID   IN VARCHAR2,
                                     USER_ID IN VARCHAR2);

  --插入空的风险评估汇总
  PROCEDURE P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID IN VARCHAR2,
                                           ATYPE   IN VARCHAR2,
                                           AV_ID   IN VARCHAR2);

  --批版尺寸表新增插入
  PROCEDURE P_INSERT_APPROVE_SIZE(COMP_ID   IN VARCHAR2,
                                  AV_ID     IN VARCHAR2,
                                  POSITION  IN VARCHAR2,
                                  MEAMETHOD IN VARCHAR2,
                                  STDSIZE   IN VARCHAR2);

  --复版新增
  PROCEDURE P_APPROVE_REVERSION_INSERT(COMP_ID VARCHAR2, AV_ID VARCHAR2);

  --生成批版数据
  PROCEDURE P_INSERT_NES_APPROVE(COMP_ID IN VARCHAR2,
                                 GOOD_ID IN VARCHAR2,
                                 OI_STR  IN VARCHAR2,
                                 CRE_ID  IN VARCHAR2);

  --带条件生成批版数据
  PROCEDURE P_GENERATE_NES_APPROVE_INFO(COMP_ID IN VARCHAR2,
                                        GOO_ID  IN VARCHAR2,
                                        OI_STR  IN VARCHAR2 DEFAULT 'SI',
                                        CRE_ID  IN VARCHAR2 DEFAULT 'ADMIN');

  --批版条件校验
  PROCEDURE P_APPROVER_RESULT_VERIFY(V_AVID IN VARCHAR2,
                                     V_CPID IN VARCHAR2,
                                     V_USID IN VARCHAR2);

  --生成批版不合格处理picklist
  FUNCTION F_GET_APUNQUAL_TREATMENT_PICKLIST(V_ASSESSTYPE IN VARCHAR2)
    RETURN VARCHAR2;

  --生成批版不合格处理执行语句
  FUNCTION F_GENERATE_AP_UTSENTANCE(V_CODES IN VARCHAR2) RETURN VARCHAR2;

  --插入批版记录表主表（创建者为系统管理员）
    ----新增复版/页面新增的创建人记录为当前操作人 by dyy153 20220617
  PROCEDURE P_INSERT_APPROVE_VERSION_WITHOUT_CREATOR(V_APVID  IN VARCHAR2 DEFAULT NULL,
                                                     V_STCODE IN VARCHAR2 DEFAULT NULL,
                                                     V_SPCODE IN VARCHAR2 DEFAULT NULL,
                                                     V_COMPID IN VARCHAR2,
                                                     V_GOODID IN VARCHAR2,
                                                     V_ORIGIN IN VARCHAR2,
                                                     V_APVOID IN VARCHAR2 DEFAULT NULL,
                                                     CRE_ID   IN VARCHAR2 DEFAULT 'ADMIN');

  --复版带入批版风险评估表数据
  PROCEDURE P_INSERT_APRISKASSEMENT_BY_REAP(V_APVID  IN VARCHAR2,
                                            V_APID   IN VARCHAR2,
                                            V_COMPID IN VARCHAR2);

  --插入批版附件表
  PROCEDURE P_INSERT_APPROVE_FILE(V_APVID  IN VARCHAR2,
                                  V_COMPID IN VARCHAR2);

  --插入空的批版附件记录
  PROCEDURE P_INSERT_EMPTY_APFILE(V_APVID  IN VARCHAR2,
                                  V_COMPID IN VARCHAR2,
                                  V_TYPE   IN VARCHAR2);

END PKG_APPROVE_INSERT;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_APPROVE_INSERT IS

  --批版记录表单行插入-新增
  PROCEDURE P_INSERT_APPROVE_VERSION(COMP_ID IN VARCHAR2,
                                     GOOD_ID IN VARCHAR2,
                                     AV_ID   IN VARCHAR2,
                                     OI_STR  IN VARCHAR2,
                                     CRE_ID  IN VARCHAR2) IS
    S_CODE     VARCHAR2(32);
    SP_CODE    VARCHAR2(32);
    B_CODE     VARCHAR2(32);
    V_JUGNUM   NUMBER(1);
    V_CATE     VARCHAR2(32);
    V_PROCATE  VARCHAR2(32);
    V_APP_TYPE VARCHAR2(32);
  BEGIN
    SELECT COUNT(1)
      INTO V_JUGNUM
      FROM SCMDATA.T_APPROVE_VERSION
     WHERE GOO_ID = GOOD_ID
       AND COMPANY_ID = COMP_ID
       AND ROWNUM = 1;
  
    IF V_JUGNUM = 0 THEN
      SELECT STYLE_NUMBER, SUPPLIER_CODE, CATEGORY, PRODUCT_CATE
        INTO S_CODE, SP_CODE, V_CATE, V_PROCATE
        FROM SCMDATA.T_COMMODITY_INFO
       WHERE COMPANY_ID = COMP_ID
         AND GOO_ID = GOOD_ID;
    
      B_CODE := SCMDATA.F_GETKEYID_PLAT('BILL_CODE', 'seq_billcode', 2);
    
      IF V_CATE = '03' OR
         (v_cate = '08' AND V_procate = '113' OR v_procate = '114') THEN
        V_APP_TYPE := '';
      ELSE
        V_APP_TYPE := 'CONFIRM_VERSION';
      END IF;
    
      INSERT INTO SCMDATA.T_APPROVE_VERSION
        (APPROVE_VERSION_ID,
         COMPANY_ID,
         BILL_CODE,
         APPROVE_STATUS,
         APPROVE_NUMBER,
         APPROVE_RESULT,
         GOO_ID,
         STYLE_CODE,
         APPROVE_USER_ID,
         APPROVE_TIME,
         CREATE_TIME,
         ORIGIN,
         CREATE_ID,
         SUPPLIER_CODE,
         APPROVE_TYPE)
      VALUES
        (AV_ID,
         COMP_ID,
         B_CODE,
         'AS00',
         0,
         'AS00',
         GOOD_ID,
         S_CODE,
         NULL,
         NULL,
         SYSDATE,
         OI_STR,
         CRE_ID,
         SP_CODE,
         V_APP_TYPE);
    END IF;
  
    --COMMIT;
  END P_INSERT_APPROVE_VERSION;

  --风险评估表单行插入-新增
  PROCEDURE P_INSERT_RISK_ASSESSMENT(COMP_ID IN VARCHAR2,
                                     ATYPE   IN VARCHAR2,
                                     AV_ID   IN VARCHAR2,
                                     USER_ID IN VARCHAR2) IS
  BEGIN
    INSERT INTO SCMDATA.T_APPROVE_RISK_ASSESSMENT
      (APPROVE_RISK_ASSESSMENT_ID,
       APPROVE_VERSION_ID,
       COMPANY_ID,
       ASSESS_TYPE,
       ASSESS_SAY,
       RISK_WARNING,
       ASSESS_RESULT,
       UNQUALIFIED_SAY,
       ASSESS_USER_ID,
       ASSESS_TIME)
    VALUES
      (SCMDATA.F_GET_UUID(),
       AV_ID,
       COMP_ID,
       ATYPE,
       ' ',
       ' ',
       ' ',
       ' ',
       USER_ID,
       SYSDATE);
    --COMMIT;
  END P_INSERT_RISK_ASSESSMENT;

  --插入空的风险评估汇总
  PROCEDURE P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID IN VARCHAR2,
                                           ATYPE   IN VARCHAR2,
                                           AV_ID   IN VARCHAR2) IS
  BEGIN
    INSERT INTO SCMDATA.T_APPROVE_RISK_ASSESSMENT
      (APPROVE_RISK_ASSESSMENT_ID,
       APPROVE_VERSION_ID,
       COMPANY_ID,
       ASSESS_TYPE,
       ASSESS_SAY,
       RISK_WARNING,
       ASSESS_RESULT,
       UNQUALIFIED_SAY,
       ASSESS_USER_ID,
       ASSESS_TIME)
    VALUES
      (SCMDATA.F_GET_UUID(),
       AV_ID,
       COMP_ID,
       ATYPE,
       ' ',
       ' ',
       ' ',
       ' ',
       ' ',
       NULL);
    --COMMIT;
  END P_INSERT_RISK_ASSESSMENT_EMPTY;

  --批版尺寸表新增插入
  PROCEDURE P_INSERT_APPROVE_SIZE(COMP_ID   IN VARCHAR2,
                                  AV_ID     IN VARCHAR2,
                                  POSITION  IN VARCHAR2,
                                  MEAMETHOD IN VARCHAR2,
                                  STDSIZE   IN VARCHAR2) IS
  BEGIN
    INSERT INTO SCMDATA.T_APPROVE_SIZE
      (APPROVE_SIZE_ID,
       APPROVE_VERSION_ID,
       COMPANY_ID,
       POSITION,
       MEASURING_METHOD,
       STD_SIZE,
       TEMPLATE_SIZE,
       CRAFTSMAN_SIZE,
       DEVIATION)
    VALUES
      (SCMDATA.F_GET_UUID(),
       AV_ID,
       COMP_ID,
       POSITION,
       MEAMETHOD,
       CAST(STDSIZE AS NUMBER(32, 8)),
       0,
       0,
       0);
    --COMMIT;
  END P_INSERT_APPROVE_SIZE;

  --插入必要值
  PROCEDURE P_INSERT_NES_APPROVE(COMP_ID IN VARCHAR2,
                                 GOOD_ID IN VARCHAR2,
                                 OI_STR  IN VARCHAR2,
                                 CRE_ID  IN VARCHAR2) IS
    AV_ID VARCHAR2(32);
    JUDGE NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO JUDGE
      FROM SCMDATA.T_APPROVE_VERSION
     WHERE GOO_ID = GOOD_ID
       AND COMPANY_ID = COMP_ID
       AND ROWNUM = 1;
  
    IF JUDGE = 0 THEN
      SELECT MAX(1)
        INTO JUDGE
        FROM (SELECT COMPANY_ID, CATEGORY, PRODUCT_CATE, SAMLL_CATEGORY
                FROM SCMDATA.T_COMMODITY_INFO
               WHERE COMPANY_ID = COMP_ID
                 AND GOO_ID = GOOD_ID) A
       INNER JOIN SCMDATA.T_APPROVE_CONFIG B
          ON A.COMPANY_ID = B.COMPANY_ID
         AND A.CATEGORY = B.INDUSTRY_CLASSIFICATION
         AND A.PRODUCT_CATE = B.PRODUCTION_CATEGORY
         AND INSTR(B.PRODUCT_SUBCLASS || ';', A.SAMLL_CATEGORY) > 0
         AND B.PAUSE = 0;
      IF JUDGE > 0 THEN
        AV_ID := SCMDATA.F_GETKEYID_PLAT('AP_VERSION',
                                         'seq_approve_version',
                                         '99');
      
        P_INSERT_APPROVE_VERSION(COMP_ID => COMP_ID,
                                 GOOD_ID => GOOD_ID,
                                 AV_ID   => AV_ID,
                                 OI_STR  => OI_STR,
                                 CRE_ID  => CRE_ID);
      
        P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID, 'EVAL11', AV_ID);
        P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID, 'EVAL12', AV_ID);
        P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID, 'EVAL13', AV_ID);
        P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID, 'EVAL14', AV_ID);
        P_INSERT_APPROVE_FILE(V_APVID => AV_ID, V_COMPID => COMP_ID);
      END IF;
    END IF;
  END P_INSERT_NES_APPROVE;

  --复版新增
  PROCEDURE P_APPROVE_REVERSION_INSERT(COMP_ID VARCHAR2, AV_ID VARCHAR2) IS
  BEGIN
    P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID, 'EVAL11', AV_ID);
    P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID, 'EVAL12', AV_ID);
    P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID, 'EVAL13', AV_ID);
    P_INSERT_RISK_ASSESSMENT_EMPTY(COMP_ID, 'EVAL14', AV_ID);
  END P_APPROVE_REVERSION_INSERT;

  --带条件生成批版数据
  PROCEDURE P_GENERATE_NES_APPROVE_INFO(COMP_ID IN VARCHAR2,
                                        GOO_ID  IN VARCHAR2,
                                        OI_STR  IN VARCHAR2 DEFAULT 'SI',
                                        CRE_ID  IN VARCHAR2 DEFAULT 'ADMIN') IS
    JUDGE NUMBER(4);
  BEGIN
    JUDGE := SCMDATA.PKG_PLAT_COMM.F_COMPANY_HAS_APP(PI_COMPANY_ID => COMP_ID,
                                                     PI_APPLY_ID   => 'apply_6');
    IF JUDGE = 1 THEN
      SCMDATA.PKG_APPROVE_INSERT.P_INSERT_NES_APPROVE(COMP_ID => COMP_ID,
                                                      GOOD_ID => GOO_ID,
                                                      OI_STR  => OI_STR,
                                                      CRE_ID  => CRE_ID);
    END IF;
  END P_GENERATE_NES_APPROVE_INFO;

  --批版条件校验
  PROCEDURE P_APPROVER_RESULT_VERIFY(V_AVID IN VARCHAR2,
                                     V_CPID IN VARCHAR2,
                                     V_USID IN VARCHAR2) IS
  
    ASS_RESULTS    VARCHAR2(256);
    V_GOOID        VARCHAR2(32);
    V_SUPCODE      VARCHAR2(32);
    EV0_CNT        NUMBER(1);
    EV1_CNT        NUMBER(1);
    EV2_CNT        NUMBER(1);
    EV3_CNT        NUMBER(1);
    EV4_CNT        NUMBER(1);
    APP_RESULT     VARCHAR2(8);
    APP_STATUS     VARCHAR2(8);
    V_CFID         VARCHAR2(32);
    V_ERR_RE       number(1);
    V_RELA_GOOID   varchar2(32);
    EMPTY_RESULT   varchar2(256);
    V_JUDGE        NUMBER(1);
    V_APPTYPE      VARCHAR2(32);
    V_APPTYPE_NAME VARCHAR2(32);
  BEGIN
  
    --dyy153 20220516 批版类型不为空校验 begin
    SELECT COUNT(1)
      INTO v_judge
      FROM scmdata.t_approve_version t
     WHERE t.approve_version_id = V_AVID
       AND t.company_id = V_CPID
       AND t.approve_type IS NULL;
  
    IF V_JUDGE = 1 THEN
      RAISE_APPLICATION_ERROR(-20002, '“批版类型”为必填项，请检查！');
    END IF;
  
    --dyy153 20220516   批版类型不为空校验 end 
  
    --zwh73 20211228 复版原因校验 begin 
    /*20220516  dyy153修改 begin
    当批版次数≥2，且待批版列表的“货号+批版类型”在已批版列表中已存在，“复版原因”为必填 */
    SELECT max(X.GOO_ID),
           max(X.RELA_GOO_ID),
           max(x.supplier_code),
           MAX(y.approve_type),
           MAX(Z.GROUP_DICT_NAME)
      INTO V_GOOID, V_RELA_GOOID, V_SUPCODE, V_APPTYPE, V_APPTYPE_NAME
      FROM SCMDATA.T_COMMODITY_INFO X
     INNER JOIN SCMDATA.T_APPROVE_VERSION Y
        ON X.GOO_ID = Y.GOO_ID
       AND X.COMPANY_ID = Y.COMPANY_ID
       AND Y.APPROVE_VERSION_ID = V_AVID
       AND Y.COMPANY_ID = V_CPID
     INNER JOIN SCMDATA.SYS_GROUP_DICT Z
        ON Z.GROUP_DICT_VALUE = Y.APPROVE_TYPE
       AND Z.GROUP_DICT_TYPE = 'APPROVE_TYPE';
  
    select nvl(max(1), 0)
      into V_ERR_RE
      from scmdata.t_approve_version a
     where a.approve_version_id = V_AVID
       and a.approve_number >= 2
       and a.re_version_reason is NULL
       AND a.company_id = V_CPID
       AND EXISTS (SELECT 1
              FROM scmdata.t_approve_version t
             WHERE t.approve_status IN ('AS01', 'AS02')
               AND t.GOO_ID = V_GOOID
               AND t.approve_type = V_APPTYPE);
    if V_ERR_RE = 1 then
      RAISE_APPLICATION_ERROR(-20002,
                              V_RELA_GOOID || '的 ' || V_APPTYPE_NAME ||
                              ' 为复版时， 主表-复版原因为必填，请检查！');
    END IF;
  
    --zwh73 20211228 复版原因校验 end
  
    SELECT LISTAGG(ASSESS_RESULT, ';') || ';'
      INTO ASS_RESULTS
      FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT
     WHERE APPROVE_VERSION_ID = V_AVID
       AND COMPANY_ID = V_CPID;
  
    EV0_CNT := REGEXP_COUNT(ASS_RESULTS, ' ');
    EV1_CNT := REGEXP_COUNT(ASS_RESULTS, 'EVRT01');
    EV2_CNT := REGEXP_COUNT(ASS_RESULTS, 'EVRT02');
    EV3_CNT := REGEXP_COUNT(ASS_RESULTS, 'EVRT03');
    EV4_CNT := REGEXP_COUNT(ASS_RESULTS, 'EVRT04');
  
    IF EV0_CNT + EV4_CNT = 4 THEN
      APP_STATUS := 'AS01';
      APP_RESULT := 'AS02';
    ELSIF EV0_CNT = 0 AND EV1_CNT + EV3_CNT + EV4_CNT = 4 THEN
      APP_STATUS := 'AS01';
      APP_RESULT := 'AS03';
    ELSIF EV0_CNT = 0 AND EV2_CNT >= 1 THEN
      APP_STATUS := 'AS01';
      APP_RESULT := 'AS04';
    ELSE
      --zwh73 begin 20211229
      SELECT LISTAGG(b.group_dict_name, ';') || ';'
        INTO EMPTY_RESULT
        FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT a
       inner join scmdata.sys_group_dict b
          on a.assess_type = b.group_dict_value
         and b.group_dict_type = 'BAD_FACTOR'
       WHERE APPROVE_VERSION_ID = V_AVID
         AND COMPANY_ID = V_CPID
         AND ASSESS_RESULT = ' ';
      RAISE_APPLICATION_ERROR(-20002,
                              EMPTY_RESULT || '评语、评估结果未填，请检查！');
    
      --  RAISE_APPLICATION_ERROR(-20002, '请将结果填写完成！');
      --zwh73 end 20211229
    
    END IF;
  
    UPDATE SCMDATA.T_APPROVE_VERSION
       SET APPROVE_STATUS  = APP_STATUS,
           APPROVE_RESULT  = APP_RESULT,
           APPROVE_TIME    = SYSDATE,
           APPROVE_USER_ID = V_USID,
           APPROVE_NUMBER  = DECODE(APPROVE_NUMBER, 0, 1, APPROVE_NUMBER),
           SUPPLIER_CODE   = V_SUPCODE
     WHERE APPROVE_VERSION_ID = V_AVID;
  
    FOR I IN (SELECT A.APPROVE_FILE_ID,
                     B.GOO_ID,
                     A.COMPANY_ID,
                     C.COMMODITY_INFO_ID,
                     A.FILE_TYPE,
                     A.FILE_ID,
                     A.PIC_ID,
                     A.CREATE_ID,
                     A.CREATE_TIME,
                     A.UPDATE_ID,
                     A.UPDATE_TIME,
                     A.COMMODITY_FILE_ID
                FROM (SELECT APPROVE_FILE_ID,
                             APPROVE_VERSION_ID,
                             COMPANY_ID,
                             FILE_TYPE,
                             FILE_ID,
                             PIC_ID,
                             CREATE_ID,
                             CREATE_TIME,
                             UPDATE_ID,
                             UPDATE_TIME,
                             COMMODITY_FILE_ID
                        FROM SCMDATA.T_APPROVE_FILE
                       WHERE APPROVE_VERSION_ID = V_AVID
                         AND COMPANY_ID = V_CPID
                         AND FILE_TYPE IN ('01', '02')) A
                LEFT JOIN SCMDATA.T_APPROVE_VERSION B
                  ON A.APPROVE_VERSION_ID = B.APPROVE_VERSION_ID
                 AND A.COMPANY_ID = B.COMPANY_ID
                LEFT JOIN SCMDATA.T_COMMODITY_INFO C
                  ON B.GOO_ID = C.GOO_ID
                 AND B.COMPANY_ID = C.COMPANY_ID) LOOP
    
      V_CFID := SCMDATA.F_GET_UUID();
    
      IF I.CREATE_ID <> 'ADMIN' THEN
        IF I.COMMODITY_FILE_ID IS NULL THEN
          INSERT INTO SCMDATA.T_COMMODITY_FILE
            (COMMODITY_FILE_ID,
             COMMODITY_INFO_ID,
             GOO_ID,
             COMPANY_ID,
             FILE_TYPE,
             FILE_ID,
             PICTURE_ID,
             CREATE_ID,
             CREATE_TIME,
             UPDATE_ID,
             UPDATE_TIME)
          VALUES
            (V_CFID,
             I.COMMODITY_INFO_ID,
             I.GOO_ID,
             I.COMPANY_ID,
             I.FILE_TYPE,
             I.FILE_ID,
             I.PIC_ID,
             I.CREATE_ID,
             I.CREATE_TIME,
             I.UPDATE_ID,
             I.UPDATE_TIME);
        
          UPDATE SCMDATA.T_APPROVE_FILE
             SET COMMODITY_FILE_ID = V_CFID
           WHERE APPROVE_FILE_ID = I.APPROVE_FILE_ID
             AND COMPANY_ID = I.COMPANY_ID;
        ELSE
          UPDATE SCMDATA.T_COMMODITY_FILE
             SET UPDATE_ID   = NVL(I.UPDATE_ID, I.CREATE_ID),
                 UPDATE_TIME = SYSDATE,
                 FILE_ID     = I.FILE_ID,
                 PICTURE_ID  = I.PIC_ID
           WHERE COMMODITY_FILE_ID = I.COMMODITY_FILE_ID
             AND COMPANY_ID = I.COMPANY_ID
             AND FILE_TYPE = I.FILE_TYPE;
        END IF;
      END IF;
    END LOOP;
  
    UPDATE SCMDATA.T_PRODUCTION_PROGRESS PR
       SET PR.APPROVE_EDITION = APP_RESULT
     WHERE COMPANY_ID = V_CPID
       AND GOO_ID = V_GOOID;
  
    UPDATE SCMDATA.T_QC_GOO_COLLECT
       SET APPROVE_RESULT = APP_RESULT
     WHERE COMPANY_ID = V_CPID
       AND GOO_ID = V_GOOID;
  
    --zwh73 2022/4/16 生成已批版报表
    scmdata.pkg_approve_report.p_log_approve_report(p_approve_vesrion_id => V_AVID);
  
    --zwh73 20220609 同步生成印绣花面料检测审核
    scmdata.pkg_fabric_evaluate.p_sync_yxh_by_approve(pi_approve_version_id => V_AVID);
  
  END P_APPROVER_RESULT_VERIFY;

  --生成批版不合格处理picklist
  FUNCTION F_GET_APUNQUAL_TREATMENT_PICKLIST(V_ASSESSTYPE IN VARCHAR2)
    RETURN VARCHAR2 IS
    V_EXESQL VARCHAR2(2048);
  BEGIN
    IF V_ASSESSTYPE = 'EVAL11' THEN
      V_EXESQL := F_GENERATE_AP_UTSENTANCE(V_CODES => ',RFBV,RGMV,SPMD,');
    ELSIF V_ASSESSTYPE = 'EVAL12' THEN
      V_EXESQL := F_GENERATE_AP_UTSENTANCE(V_CODES => ',RMEV,RGMV,SPMD,');
    ELSIF V_ASSESSTYPE = 'EVAL13' THEN
      V_EXESQL := F_GENERATE_AP_UTSENTANCE(V_CODES => ',RGMV,RDM,RST,REM,RWA,SPMD,');
    ELSIF V_ASSESSTYPE = 'EVAL14' THEN
      V_EXESQL := F_GENERATE_AP_UTSENTANCE(V_CODES => ',RGMV,SPMD,');
    END IF;
    RETURN V_EXESQL;
  END;

  --生成批版不合格处理执行语句
  FUNCTION F_GENERATE_AP_UTSENTANCE(V_CODES IN VARCHAR2) RETURN VARCHAR2 IS
    V_EXESQL VARCHAR2(2048);
  BEGIN
    V_EXESQL := 'SELECT APUNQUAL_TREATMENT,APUNQUAL_TREATMENT_DESC FROM (' ||
                'SELECT GROUP_DICT_VALUE APUNQUAL_TREATMENT, GROUP_DICT_NAME APUNQUAL_TREATMENT_DESC, GROUP_DICT_SORT AP_SORT ' ||
                'FROM SCMDATA.SYS_GROUP_DICT ' ||
                'WHERE GROUP_DICT_TYPE = ''APUNQUAL_TREATMENT'' ' ||
                'AND INSTR(''' || V_CODES ||
                ''','',''||GROUP_DICT_VALUE||'','')>0 ' ||
                'UNION ALL SELECT ''/'' APUNQUAL_TREATMENT, ''/'' APUNQUAL_TREATMENT_DESC, 99 AP_SORT FROM DUAL) ' ||
                'ORDER BY AP_SORT';
    RETURN V_EXESQL;
  END F_GENERATE_AP_UTSENTANCE;

  --插入批版记录表主表（创建者为系统管理员）
    --新增复版/页面新增的创建人记录为当前操作人 by dyy153 20220617
  PROCEDURE P_INSERT_APPROVE_VERSION_WITHOUT_CREATOR(V_APVID  IN VARCHAR2 DEFAULT NULL,
                                                     V_STCODE IN VARCHAR2 DEFAULT NULL,
                                                     V_SPCODE IN VARCHAR2 DEFAULT NULL,
                                                     V_COMPID IN VARCHAR2,
                                                     V_GOODID IN VARCHAR2,
                                                     V_ORIGIN IN VARCHAR2,
                                                     V_APVOID IN VARCHAR2 DEFAULT NULL,
                                                     CRE_ID   IN VARCHAR2 DEFAULT 'ADMIN') IS
    V_APNUM    NUMBER(4);
    V_APPVID   VARCHAR2(32) := V_APVID;
    V_STYCODE  VARCHAR2(32) := V_STCODE;
    V_SUPCODE  VARCHAR2(32) := V_SPCODE;
    V_CATE     VARCHAR2(32);
    V_PROCATE  VARCHAR2(32);
    V_APP_TYPE VARCHAR2(32);
    V_BCODE    VARCHAR2(32) := SCMDATA.F_GETKEYID_PLAT('BILL_CODE',
                                                       'seq_billcode',
                                                       99);
  BEGIN
    IF V_APPVID IS NULL THEN
      V_APPVID := SCMDATA.F_GETKEYID_PLAT('AP_VERSION',
                                          'seq_approve_version',
                                          '99');
    END IF;
  
    SELECT DECODE(MAX(APPROVE_NUMBER), NULL, 0, MAX(APPROVE_NUMBER) + 1)
      INTO V_APNUM
      FROM SCMDATA.T_APPROVE_VERSION
     WHERE APPROVE_VERSION_ID = V_APVOID
       AND COMPANY_ID = V_COMPID;
  
    IF V_STYCODE IS NOT NULL OR V_SUPCODE IS NOT NULL THEN
      SELECT STYLE_NUMBER, SUPPLIER_CODE, CATEGORY, PRODUCT_CATE
        INTO V_STYCODE, V_SUPCODE, V_CATE, V_PROCATE
        FROM SCMDATA.T_COMMODITY_INFO
       WHERE GOO_ID = V_GOODID
         AND COMPANY_ID = V_COMPID;
      IF V_CATE = '03' OR
         (v_cate = '08' AND V_procate = '113' OR v_procate = '114') THEN
        V_APP_TYPE := '';
      ELSE
        V_APP_TYPE := 'CONFIRM_VERSION';
      END IF;
    
      INSERT INTO SCMDATA.T_APPROVE_VERSION
        (APPROVE_VERSION_ID,
         COMPANY_ID,
         BILL_CODE,
         APPROVE_STATUS,
         APPROVE_NUMBER,
         APPROVE_RESULT,
         GOO_ID,
         STYLE_CODE,
         CREATE_TIME,
         ORIGIN,
         CREATE_ID,
         SUPPLIER_CODE,
         APPROVE_TYPE)
      VALUES
        (V_APPVID,
         V_COMPID,
         V_BCODE,
         'AS00',
         V_APNUM,
         'AS00',
         V_GOODID,
         V_STYCODE,
         SYSDATE,
         V_ORIGIN,
         CRE_ID,
         V_SUPCODE,
         V_APP_TYPE);
    END IF;
  END P_INSERT_APPROVE_VERSION_WITHOUT_CREATOR;

  --复版带入批版风险评估表数据
  PROCEDURE P_INSERT_APRISKASSEMENT_BY_REAP(V_APVID  IN VARCHAR2,
                                            V_APID   IN VARCHAR2,
                                            V_COMPID IN VARCHAR2) IS
  
  BEGIN
    FOR I IN (SELECT *
                FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT
               WHERE APPROVE_VERSION_ID = V_APVID
                 AND COMPANY_ID = V_COMPID) LOOP
      INSERT INTO SCMDATA.T_APPROVE_RISK_ASSESSMENT
        (APPROVE_RISK_ASSESSMENT_ID,
         APPROVE_VERSION_ID,
         COMPANY_ID,
         UNQUAL_TREATMENT,
         ASSESS_TYPE,
         ASSESS_SAY,
         RISK_WARNING,
         ASSESS_RESULT,
         UNQUALIFIED_SAY,
         ASSESS_USER_ID,
         ASSESS_TIME,
         REMARKS)
      VALUES
        (SCMDATA.F_GET_UUID(),
         V_APID,
         V_COMPID,
         I.UNQUAL_TREATMENT,
         I.ASSESS_TYPE,
         I.ASSESS_SAY,
         I.RISK_WARNING,
         I.ASSESS_RESULT,
         I.UNQUALIFIED_SAY,
         I.ASSESS_USER_ID,
         I.ASSESS_TIME,
         I.REMARKS);
    END LOOP;
  END;

  --插入批版附件表
  PROCEDURE P_INSERT_APPROVE_FILE(V_APVID  IN VARCHAR2,
                                  V_COMPID IN VARCHAR2) IS
  BEGIN
    P_INSERT_EMPTY_APFILE(V_APVID  => V_APVID,
                          V_COMPID => V_COMPID,
                          V_TYPE   => '01');
    P_INSERT_EMPTY_APFILE(V_APVID  => V_APVID,
                          V_COMPID => V_COMPID,
                          V_TYPE   => '02');
  END P_INSERT_APPROVE_FILE;

  --插入空的批版附件记录
  PROCEDURE P_INSERT_EMPTY_APFILE(V_APVID  IN VARCHAR2,
                                  V_COMPID IN VARCHAR2,
                                  V_TYPE   IN VARCHAR2) IS
    V_FILE  VARCHAR2(256);
    V_PIC   VARCHAR2(256);
    V_CID   VARCHAR2(32);
    V_CDATE DATE;
    V_CFID  VARCHAR2(32);
  BEGIN
    SELECT MAX(FILE_ID),
           MAX(PICTURE_ID),
           MAX(CREATE_ID),
           MAX(CREATE_TIME),
           MAX(COMMODITY_FILE_ID)
      INTO V_FILE, V_PIC, V_CID, V_CDATE, V_CFID
      FROM SCMDATA.T_COMMODITY_FILE
     WHERE FILE_TYPE = V_TYPE
       AND (COMMODITY_INFO_ID, COMPANY_ID) IN
           (SELECT COMMODITY_INFO_ID, COMPANY_ID
              FROM SCMDATA.T_COMMODITY_INFO Z
             WHERE EXISTS (SELECT 1
                      FROM SCMDATA.T_APPROVE_VERSION
                     WHERE APPROVE_VERSION_ID = V_APVID
                       AND COMPANY_ID = V_COMPID
                       AND GOO_ID = Z.GOO_ID
                       AND COMPANY_ID = Z.COMPANY_ID));
    INSERT INTO SCMDATA.T_APPROVE_FILE
      (APPROVE_FILE_ID,
       APPROVE_VERSION_ID,
       COMPANY_ID,
       FILE_TYPE,
       FILE_ID,
       PIC_ID,
       CREATE_ID,
       CREATE_TIME,
       COMMODITY_FILE_ID)
    VALUES
      (SCMDATA.F_GET_UUID(),
       V_APVID,
       V_COMPID,
       V_TYPE,
       V_FILE,
       V_PIC,
       NVL(V_CID, 'ADMIN'),
       NVL(V_CDATE, SYSDATE),
       V_CFID);
  END P_INSERT_EMPTY_APFILE;

END PKG_APPROVE_INSERT;
/

