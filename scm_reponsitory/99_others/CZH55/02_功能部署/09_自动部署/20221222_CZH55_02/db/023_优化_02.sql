DECLARE
 v_sql CLOB;
 
BEGIN
  v_sql:='DECLARE
  V_GOODID   VARCHAR2(32);
  V_STNUM    VARCHAR2(32);
  V_SPCODE   VARCHAR2(32);
  V_APNUM    NUMBER(4);
  V_JUGNUM   NUMBER(1);
  V_ORIGIN   VARCHAR2(8);
  V_STATUS   VARCHAR2(8);
  V_APID     VARCHAR2(32);
  V_APVID    VARCHAR2(32);
BEGIN
  --CHECK_RELA_GOO_ID_NULL_OR_NOT
  IF :RELA_GOO_ID IS NULL THEN
    RAISE_APPLICATION_ERROR(-20002, ''δ��⵽������ţ�������������ٱ��棡'');
  END IF;

  --GET_GOOID_STYLENUM_SUPPLIERCODE
  SELECT MAX(GOO_ID), MAX(STYLE_NUMBER), MAX(SUPPLIER_CODE)
    INTO V_GOODID, V_STNUM, V_SPCODE
    FROM SCMDATA.T_COMMODITY_INFO
   WHERE RELA_GOO_ID = :RELA_GOO_ID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

  --CHECK_COMMODITYINFO_EXIST
  IF V_GOODID IS NULL THEN
    RAISE_APPLICATION_ERROR(-20002, ''�������������˶Ժ��������룡'');
  END IF;

  --GET_APPROVENUM_ORIGIN_APPROVESTATUS_HISTORYAPPROVEVERSIONID
  SELECT MAX(APPROVE_NUMBER),
         MAX(ORIGIN),
         MAX(APPROVE_STATUS),
         MAX(APPROVE_VERSION_ID)
    INTO V_APNUM, V_ORIGIN, V_STATUS, V_APVID
    FROM (SELECT APPROVE_NUMBER, ORIGIN, APPROVE_TIME, APPROVE_VERSION_ID, APPROVE_STATUS
            FROM SCMDATA.T_APPROVE_VERSION
           WHERE GOO_ID = V_GOODID
             AND COMPANY_ID = %DEFAULT_COMPANY_ID%
           ORDER BY APPROVE_TIME DESC)
   WHERE ROWNUM < 2;

  --CHECK_GOOID_ALREADY_EXISTS
  SELECT COUNT(1)
    INTO V_JUGNUM
    FROM SCMDATA.T_APPROVE_VERSION
   WHERE GOO_ID = V_GOODID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%
     AND ROWNUM = 1;

  --CHECK_PREAPPROVE_DATA
  IF V_JUGNUM > 0 AND V_STATUS = ''AS00'' THEN
    RAISE_APPLICATION_ERROR(-20002,''�ÿ����д��������ݣ������ظ�������'');
  END IF;

  --GEN_APPROVE_VERSION_ID
  V_APID := SCMDATA.F_GETKEYID_PLAT(''AP_VERSION'',
                                    ''seq_approve_version'',
                                    ''99'');

  --APPROVE_VERSION_INS
  SCMDATA.PKG_APPROVE_INSERT.P_INSERT_APPROVE_VERSION_WITHOUT_CREATOR(V_APVID  => V_APID,
                                                                      V_STCODE => V_STNUM,
                                                                      V_SPCODE => V_SPCODE,
                                                                      V_COMPID => %DEFAULT_COMPANY_ID%,
                                                                      V_GOODID => V_GOODID,
                                                                      V_ORIGIN => ''MI'',
                                                                      V_APVOID => :APPROVE_VERSION_ID,
                                                                      CRE_ID   => %CURRENT_USERID%);

  --APPROVE_RISK_ASSESSMENT_INS
  IF V_APNUM IS NULL THEN
    V_APNUM := 0;
    SCMDATA.PKG_APPROVE_INSERT.P_INSERT_RISK_ASSESSMENT_EMPTY(%DEFAULT_COMPANY_ID%, ''EVAL11'', V_APID);
    SCMDATA.PKG_APPROVE_INSERT.P_INSERT_RISK_ASSESSMENT_EMPTY(%DEFAULT_COMPANY_ID%, ''EVAL12'', V_APID);
    SCMDATA.PKG_APPROVE_INSERT.P_INSERT_RISK_ASSESSMENT_EMPTY(%DEFAULT_COMPANY_ID%, ''EVAL13'', V_APID);
    SCMDATA.PKG_APPROVE_INSERT.P_INSERT_RISK_ASSESSMENT_EMPTY(%DEFAULT_COMPANY_ID%, ''EVAL14'', V_APID);
  ELSE
    V_APNUM := V_APNUM + 1;
    SCMDATA.PKG_APPROVE_INSERT.P_INSERT_APRISKASSEMENT_BY_REAP(V_APVID  => V_APVID,
                                                               V_APID   => V_APID,
                                                               V_COMPID => %DEFAULT_COMPANY_ID%);
  END IF;

  --APPROVE_FILE_INS
  SCMDATA.PKG_APPROVE_INSERT.P_INSERT_APPROVE_FILE(V_APVID  => V_APID,
                                                   V_COMPID => %DEFAULT_COMPANY_ID%);

  --T_APPROVE_VERSION_UPD
  UPDATE SCMDATA.T_APPROVE_VERSION
     SET APPROVE_NUMBER = V_APNUM
   WHERE APPROVE_VERSION_ID = V_APID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

  --T_PRODUCTION_PROGRESS_UPD
  UPDATE SCMDATA.T_PRODUCTION_PROGRESS PR
     SET PR.APPROVE_EDITION = ''AS00''
   WHERE GOO_ID = V_GOODID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

  --T_QC_GOO_COLLECT_UPD
  UPDATE SCMDATA.T_QC_GOO_COLLECT
     SET APPROVE_RESULT = ''AS00''
   WHERE GOO_ID = V_GOODID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
  --czh add �ж���Ʒ�����Ƿ���ڳߴ�������ڣ���ͬ����Ʒ�����ߴ��������
  scmdata.pkg_size_chart.p_sync_gd_size_chart_to_apv(p_company_id => %default_company_id%,p_goo_id  => v_goodid);
END;';
  UPDATE bw3.sys_item_list t SET t.insert_sql=v_sql WHERE t.item_id='a_approve_111';
END;
/
