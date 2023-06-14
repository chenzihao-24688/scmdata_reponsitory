BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select '点击不同意，准入流程将会结束，申请方需重新发起合作申请，确定要执行此操作吗?' from dual^';
  CV2 CLOB:=q'^点击不同意，准入流程将会结束，申请方需重新发起合作申请，确定要执行此操作吗?^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_action_a_coop_312''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_action_a_coop_312''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_action_a_coop_312'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0020301') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_103_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_103_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_103_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101050108') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_13''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_13''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_13'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^SELECT MAX(1) AS FLAG
  FROM SCMDATA.T_FACTORY_ASK
 WHERE FACTRORY_ASK_FLOW_STATUS = 'FA02'
   AND ASK_RECORD_ID = :ASK_RECORD_ID^';
  CV2 CLOB:=q'^  ^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_coop_211_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_coop_211_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_coop_211_0'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001030107') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_coop_150_0_auto_1'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0020101') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_101_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_101_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_101_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0020201') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_102_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_102_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_102_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^SELECT DECODE(NVL(MAX(1), 0),1,0,1) AS FLAG
  FROM SCMDATA.T_ASK_RECORD
 WHERE BE_COMPANY_ID = %default_company_id%
   AND COMPANY_NAME = :ASK_COMPANY_NAME
   AND COOR_ASK_FLOW_STATUS <> 'CA00'^';
  CV2 CLOB:=q'^公司名称与意向合作供应商清单的公司名称重复！^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_tar_compname''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[ASK_COMPANY_NAME]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_tar_compname''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[ASK_COMPANY_NAME]'',''cond_tar_compname'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0010301') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_150_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_150_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_150_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090107') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_45''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_45''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_45'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010602') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_30''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_30''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_30'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010801') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_34''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_34''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_34'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101050106') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_11''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_11''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_11'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090108') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_46''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_46''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_46'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090103') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_41''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_41''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_41'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0030212') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_supp_160_auto_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_supp_160_auto_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_supp_160_auto_1'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101050109') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_14''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_14''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_14'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select max(1) flag from dual where SCMDATA.pkg_plat_comm.F_UserHasAction(%user_id%,%default_company_id% ,'76','G')=1^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
 v_sql                  VARCHAR2(512);
 v_factory_report_id    VARCHAR2(4000);
 v_rest_method          VARCHAR2(4000);
 v_params               VARCHAR2(4000);
 v_is_element_show      VARCHAR2(4000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
   --element是否显示
   v_is_element_show :=SCMDATA.PARSE_JSON(p_jsonstr => v_params,
                                                p_key     => 'COL_1');

   IF v_is_element_show = 1 THEN
      v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;

  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_ass_a_check_103_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_ass_a_check_103_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_ass_a_check_103_2'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090102') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_40''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_40''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_40'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010302') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_20''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_20''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_20'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001040105') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_coop_150_0_auto_3'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
  v_factory_ask_type NUMBER(1);
BEGIN
  SELECT MAX(a.factory_ask_type)
    INTO v_factory_ask_type
    FROM t_factory_ask a
   WHERE a.factory_ask_id = :factory_ask_id;
  INSERT INTO scmdata.t_excel_import (col_1,col_2) VALUES(:factory_ask_id,v_factory_ask_type);
  IF v_factory_ask_type <> 0 THEN
    v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_312''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_312''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_312'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^--CZH 重构  当前逻辑迁移至 asso_a_coop_150_3 实现
{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_item_id       VARCHAR(256);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_rest_method := nvl(v_rest_method, 'POST');

  IF instr(';' || v_rest_method || ';', ';' || 'POST' || ';') > 0 THEN
    v_sql := q'[DECLARE
  judge           NUMBER(1);
  tmp             NUMBER(5);
  p_fa_rec        scmdata.t_factory_ask%ROWTYPE;
  ask_row         scmdata.t_ask_scope%ROWTYPE;
  p_ask_rec       scmdata.t_ask_record%ROWTYPE;
  p_scope_rec     scmdata.t_ask_scope%ROWTYPE;
  fs_id           VARCHAR2(32);
  v_nick_name     VARCHAR2(32);
  v_phone         VARCHAR2(32);
  v_ask_record_id VARCHAR2(32) := ']' || v_ask_record_id ||
             q'[';
BEGIN
  --除 CA01/FA01/FA02 外，都不能点击，点击报错
  SELECT COUNT(1)
    INTO judge
    FROM (SELECT status_af_oper
            FROM (SELECT status_af_oper
                    FROM scmdata.t_factory_ask_oper_log
                   WHERE ask_record_id = v_ask_record_id
                   ORDER BY oper_time DESC)
           WHERE rownum < 2)
   WHERE status_af_oper IN ('CA01', 'FA01', 'FA03', 'FA21', 'FA33');

  IF judge = 0 THEN
    raise_application_error(-20002,
                            '已有单据在流程中或该供应商已准入通过，请勿重复申请！');
  ELSE
    --待验厂单据唯一判定
    SELECT COUNT(factory_ask_id)
      INTO judge
      FROM scmdata.t_factory_ask
     WHERE ask_record_id = v_ask_record_id
       AND factrory_ask_flow_status = 'CA01';

    IF judge = 0 THEN
      --是否处于可再次申请验厂的范围
      SELECT COUNT(factrory_ask_flow_status)
        INTO tmp
        FROM scmdata.t_factory_ask
       WHERE ask_record_id = v_ask_record_id;

      SELECT COUNT(factrory_ask_flow_status)
        INTO judge
        FROM scmdata.t_factory_ask
       WHERE ask_record_id = v_ask_record_id
         AND factrory_ask_flow_status IN ('FA03', 'FA21', 'FA33');

      IF tmp = 0 OR judge > 0 THEN
        --流程中是否有单据判定
        SELECT COUNT(factrory_ask_flow_status)
          INTO judge
          FROM (SELECT *
                  FROM (SELECT factrory_ask_flow_status
                          FROM scmdata.t_factory_ask
                         WHERE ask_record_id = v_ask_record_id
                         ORDER BY create_date DESC)
                 WHERE rownum < 3)
         WHERE factrory_ask_flow_status NOT IN
               ('CA01', 'FA03', 'FA21', 'FA33')
           AND rownum < 2;
        IF judge = 0 THEN

          fs_id := scmdata.f_getkeyid_plat('CA', 'seq_ca');

          SELECT *
            INTO p_ask_rec
            FROM scmdata.t_ask_record t
           WHERE t.ask_record_id = v_ask_record_id;

          --申请信息
          p_fa_rec.ask_date          := p_ask_rec.ask_date;
          p_fa_rec.is_urgent         := 0;
          p_fa_rec.cooperation_model := p_ask_rec.cooperation_model;
          p_fa_rec.cooperation_type  := p_ask_rec.cooperation_type;
          p_fa_rec.product_type      := '00';
          p_fa_rec.ask_say           := ' ';

          --供应商基本信息
          p_fa_rec.factory_ask_id        := fs_id;
          p_fa_rec.company_id            := %default_company_id%;
          p_fa_rec.company_name          := p_ask_rec.company_name;
          p_fa_rec.company_abbreviation  := p_ask_rec.company_abbreviation;
          p_fa_rec.social_credit_code    := p_ask_rec.social_credit_code;
          p_fa_rec.company_province      := p_ask_rec.company_province;
          p_fa_rec.company_city          := p_ask_rec.company_city;
          p_fa_rec.company_county        := p_ask_rec.company_county;
          p_fa_rec.company_vill          := p_ask_rec.company_vill;
          p_fa_rec.company_address       := p_ask_rec.company_address;
          p_fa_rec.ask_address           := ' ';
          p_fa_rec.legal_representative  := p_ask_rec.legal_representative;
          p_fa_rec.company_contact_phone := p_ask_rec.company_contact_phone;

          SELECT nick_name, phone
            INTO v_nick_name, v_phone
            FROM scmdata.sys_user
           WHERE user_id = p_ask_rec.create_id;

          p_fa_rec.contact_name      := nvl(p_ask_rec.sapply_user,
                                            v_nick_name);
          p_fa_rec.contact_phone     := nvl(p_ask_rec.sapply_phone, v_phone);
          p_fa_rec.company_type      := p_ask_rec.company_type;
          p_fa_rec.brand_type        := p_ask_rec.brand_type;
          p_fa_rec.cooperation_brand := p_ask_rec.cooperation_brand;
          --p_fa_rec.com_manufacturer      := :com_manufacturer;
          p_fa_rec.certificate_file := p_ask_rec.certificate_file;
          p_fa_rec.supplier_gate    := p_ask_rec.supplier_gate;
          p_fa_rec.supplier_office  := p_ask_rec.supplier_office;
          p_fa_rec.supplier_site    := p_ask_rec.supplier_site;
          p_fa_rec.supplier_product := p_ask_rec.supplier_product;
          p_fa_rec.ask_user_id      := %current_userid%;
          p_fa_rec.ask_date         := SYSDATE;
          p_fa_rec.create_id        := %current_userid%;
          p_fa_rec.create_date      := SYSDATE;
          p_fa_rec.update_id        := %current_userid%;
          p_fa_rec.update_date      := SYSDATE;
          --p_fa_rec.rela_supplier_id := :rela_supplier_id;
          p_fa_rec.memo                     := p_ask_rec.remarks;
          p_fa_rec.product_link             := p_ask_rec.product_link;
          p_fa_rec.origin                   := 'CA';
          p_fa_rec.ask_user_dept_id         := %default_dept_id%;
          p_fa_rec.ask_company_id           := %default_company_id%;
          p_fa_rec.ask_record_id            := v_ask_record_id;
          p_fa_rec.factrory_ask_flow_status := 'CA01';
          p_fa_rec.ask_user_id              := %current_userid%;

          --新增验厂申请单（供应商）
          scmdata.pkg_ask_record_mange.p_insert_factory_ask(p_fa_rec => p_fa_rec);

          FOR ask_row IN (SELECT *
                            FROM scmdata.t_ask_scope
                           WHERE object_id = v_ask_record_id) LOOP

            p_scope_rec.ask_scope_id               := scmdata.f_get_uuid();
            p_scope_rec.company_id                 := %default_company_id%;
            p_scope_rec.object_id                  := fs_id;
            p_scope_rec.object_type                := 'CA';
            p_scope_rec.cooperation_type           := ask_row.cooperation_type;
            p_scope_rec.cooperation_classification := ask_row.cooperation_classification;
            p_scope_rec.cooperation_product_cate   := ask_row.cooperation_product_cate;
            p_scope_rec.cooperation_subcategory    := ask_row.cooperation_subcategory;
            p_scope_rec.be_company_id              := ask_row.be_company_id;
            p_scope_rec.update_time                := SYSDATE;
            p_scope_rec.update_id                  := %current_userid%;
            p_scope_rec.create_id                  := %current_userid%;
            p_scope_rec.create_time                := SYSDATE;
            p_scope_rec.remarks                    := NULL;
            p_scope_rec.pause                      := 0;

            scmdata.pkg_ask_record_mange.p_insert_ask_scope(p_scope_rec => p_scope_rec);
          END LOOP;

          UPDATE scmdata.t_ask_record
             SET coor_ask_flow_status = 'CA01'
           WHERE ask_record_id = v_ask_record_id;
        END IF;
      END IF;
    END IF;
  END IF;
END;]';
  ELSE
    v_sql := NULL;
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_coop_150_3'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_item_id       VARCHAR2(32);
  v_status        VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  scmdata.pkg_plat_comm.p_get_rest_val_method_params(p_character     => nvl(%ass_ask_record_id%,
                                                                            %ass_factory_report_id%),
                                                     po_pk_id        => v_ask_record_id,
                                                     po_rest_methods => v_rest_method,
                                                     po_params       => v_params);

  v_item_id := scmdata.pkg_plat_comm.f_parse_json(p_jsonstr => v_params,
                                                  p_key     => 'item_id');

  SELECT MAX(v.status_af_oper)
    INTO v_status
    FROM scmdata.t_factory_ask t
   INNER JOIN (SELECT tf.status_af_oper,
                      tf.factory_ask_id,
                      row_number() over(PARTITION BY tf.ask_record_id ORDER BY tf.oper_time DESC) rn
                 FROM scmdata.t_factory_ask_oper_log tf) v
      ON v.factory_ask_id = t.factory_ask_id
     AND rn = 1
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF nvl(v_item_id, '-1') IN ('a_coop_150_3', 'a_coop_211', 'a_check_103_1') OR
     v_status IN ('FA22', 'FA21', 'FA32', 'FA33', 'SP_01') THEN
    v_sql := 'select max(0) from dual';
    --INSERT INTO scmdata.t_excel_import (col_1,col_2,col_3) VALUES ('0',v_item_id,v_sql);
  ELSE
    v_sql := 'select max(1) from dual';
    --INSERT INTO scmdata.t_excel_import (col_1,col_2,col_3) VALUES ('1',v_item_id,v_sql);
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_coop_310''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_coop_310''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_coop_310'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_item_id       VARCHAR2(32);
  v_status        VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  scmdata.pkg_plat_comm.p_get_rest_val_method_params(p_character     => nvl(%ass_ask_record_id%,
                                                                            %ass_factory_report_id%),
                                                     po_pk_id        => v_ask_record_id,
                                                     po_rest_methods => v_rest_method,
                                                     po_params       => v_params);

  v_item_id := scmdata.pkg_plat_comm.f_parse_json(p_jsonstr => v_params,
                                                  p_key     => 'item_id');

  SELECT MAX(v.status_af_oper)
    INTO v_status
    FROM scmdata.t_factory_ask t
   INNER JOIN (SELECT tf.status_af_oper,
                      tf.factory_ask_id,
                      row_number() over(PARTITION BY tf.ask_record_id ORDER BY tf.oper_time DESC) rn
                 FROM scmdata.t_factory_ask_oper_log tf) v
      ON v.factory_ask_id = t.factory_ask_id
     AND rn = 1
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF nvl(v_item_id, '-1') IN ('a_coop_150_3', 'a_coop_211', 'a_check_103_1') OR
     v_status IN ('FA22', 'FA21', 'FA32', 'FA33', 'SP_01') THEN
    v_sql := 'select max(0) from dual';
    --INSERT INTO scmdata.t_excel_import (col_1,col_2,col_3) VALUES ('0',v_item_id,v_sql);
  ELSE
    v_sql := 'select max(1) from dual';
    --INSERT INTO scmdata.t_excel_import (col_1,col_2,col_3) VALUES ('1',v_item_id,v_sql);
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_coop_310''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_coop_310''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_coop_310'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090105') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_43''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_43''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_43'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00901040202') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_25''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_25''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_25'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001040107') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_312_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_312_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_312_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001040106') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_311_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_311_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_311_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select 0 flag from dual where 1=1^';
  CV2 CLOB:=q'^ ^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_101_1_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_101_1_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_101_1_1'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010703') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_33''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_33''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_33'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0020103') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_check_101_1_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_check_101_1_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_check_101_1_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0020104') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_coop_150_0_auto_4'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001030404') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_coop_150_0_auto_2'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0020203') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_coop_150_0_auto_5'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select 1 flag from dual^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_121''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_121''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_121'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
  v_factory_ask_type NUMBER(1);
BEGIN
  SELECT MAX(a.factory_ask_type)
    INTO v_factory_ask_type
    FROM t_factory_ask a
   WHERE a.factory_ask_id = :factory_ask_id;
  INSERT INTO scmdata.t_excel_import (col_1,col_2) VALUES(:factory_ask_id,v_factory_ask_type);
  IF v_factory_ask_type = 0 THEN
    v_sql := 'select max(1) as flag from dual';
  ELSE
    v_sql := 'select max(0) as flag from dual';
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_311''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_311''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_311'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^SELECT SIGN(SUM(COL)) AS FLAG
  FROM ((SELECT NVL(MAX(1), 0) COL
           FROM SCMDATA.T_FACTORY_REPORT A
          INNER JOIN SCMDATA.T_FACTORY_REPORT_ABILITY B
             ON A.FACTORY_REPORT_ID = B.FACTORY_REPORT_ID
            AND A.COMPANY_ID = B.COMPANY_ID
            AND A.FACTORY_REPORT_ID = :FACTORY_REPORT_ID
            AND A.COMPANY_ID = %DEFAULT_COMPANY_ID%
          WHERE (A.CHECK_RESULT IN ('验厂通过', '试单') AND
                B.ABILITY_RESULT = 'DISAGREE')) UNION ALL
        (SELECT NVL(MAX(1), 0)
           FROM SCMDATA.T_FACTORY_REPORT A
          INNER JOIN SCMDATA.T_FACTORY_REPORT_ABILITY B
             ON A.FACTORY_REPORT_ID = B.FACTORY_REPORT_ID
            AND A.COMPANY_ID = B.COMPANY_ID
            AND A.FACTORY_REPORT_ID = :FACTORY_REPORT_ID
            AND A.COMPANY_ID = %DEFAULT_COMPANY_ID%
          WHERE A.CHECK_RESULT = '验厂不通过'
            AND B.ABILITY_RESULT = 'AGREE'
            AND 0 = (SELECT NVL(MAX(1), 0)
                       FROM SCMDATA.T_FACTORY_REPORT A
                      INNER JOIN SCMDATA.T_FACTORY_REPORT_ABILITY B
                         ON A.FACTORY_REPORT_ID = B.FACTORY_REPORT_ID
                        AND A.COMPANY_ID = B.COMPANY_ID
                        AND A.FACTORY_REPORT_ID = :FACTORY_REPORT_ID
                        AND A.COMPANY_ID = %DEFAULT_COMPANY_ID%
                      WHERE A.CHECK_RESULT = '验厂不通过'
                        AND B.ABILITY_RESULT = 'DISAGREE')))^';
  CV2 CLOB:=q'^{DECLARE
  A_RESULT VARCHAR2(2048);
  C_RESULT VARCHAR2(2048);
  ST       VARCHAR2(1024);
  SQL_STR  VARCHAR2(2048);
BEGIN
  SELECT CHECK_RESULT
    INTO C_RESULT
    FROM SCMDATA.T_FACTORY_REPORT
   WHERE FACTORY_REPORT_ID = :FACTORY_REPORT_ID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

  SELECT LISTAGG(ABILITY_RESULT, ',') || ','
    INTO A_RESULT
    FROM SCMDATA.T_FACTORY_REPORT_ABILITY
   WHERE FACTORY_REPORT_ID = :FACTORY_REPORT_ID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

  IF C_RESULT = '验厂不通过' AND REGEXP_COUNT(A_RESULT,'DISAGREE,') = 0 THEN
    ST := '能力评估存在符合的评估，验厂结论确定为验厂不通过吗？';
  ELSIF C_RESULT = '验厂通过' AND REGEXP_COUNT(A_RESULT,'DISAGREE,') > 0 THEN
    ST := '能力评估存在不符合的评估，验厂结论确定为验厂通过吗？';
  ELSIF C_RESULT = '试单' AND REGEXP_COUNT(A_RESULT,'DISAGREE,') > 0 THEN
    ST := '能力评估存在不符合的评估，验厂结论确定为试单吗？';
  END IF;
  SQL_STR    := 'SELECT ''' || ST || ''' FROM DUAL';
  ^'|| CHR(64) ||q'^STRRESULT := SQL_STR;
END;}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_101_3_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_101_3_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_101_3_0'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0030201') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_supp_160_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_supp_160_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_supp_160_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001020201') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_coop_130_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_coop_130_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_coop_130_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001040104') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_action_a_coop_313_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_action_a_coop_313_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_action_a_coop_313_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001040103') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_action_a_coop_312_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_action_a_coop_312_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_action_a_coop_312_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select '请确认是否同意准入申请？' from dual^';
  CV2 CLOB:=q'^请确认是否同意准入申请？^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_action_a_coop_311''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_action_a_coop_311''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_action_a_coop_311'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P002') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_check_100_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_check_100_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_check_100_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001030204') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_coop_150_0_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_coop_150_0_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_coop_150_0_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00901010501') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_6'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00203') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_check_103_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_check_103_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_check_103_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^SELECT nvl(max(0),1) flag
  FROM SCMDATA.T_ASK_SCOPE a
 INNER JOIN scmdata.sys_group_dict B
    ON A.cooperation_classification  = B.GROUP_DICT_VALUE
   AND B.GROUP_DICT_TYPE = 'PRODUCT_TYPE'
 WHERE OBJECT_ID = :FACTORY_ASK_ID
   and b.GROUP_DICT_NAME = '男装'^';
  CV2 CLOB:=q'^测试：男装才能跳转^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_check_101_1_test''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_check_101_1_test''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_check_101_1_test'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select '确认驳回该准入申请吗？' from dual^';
  CV2 CLOB:=q'^确认驳回该准入申请吗？^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_action_a_coop_313''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_action_a_coop_313''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_action_a_coop_313'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101050103') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_9''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_9''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_9'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010102') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_2'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00901') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010104') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_4'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00901040201') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_24''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_24''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_24'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101050101') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_7'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101050102') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_8''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_8''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_8'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010106') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_15''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_15''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_15'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090109') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_36''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_36''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_36'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101050104') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_10''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_10''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_10'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010201') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_17''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_17''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_17'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090106') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_44''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_44''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_44'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010403') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_26''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_26''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_26'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
  v_factory_ask_type NUMBER(1);
BEGIN
  SELECT MAX(a.factory_ask_type)
    INTO v_factory_ask_type
    FROM t_factory_ask a
   WHERE a.factory_ask_id = :factory_ask_id;
  INSERT INTO scmdata.t_excel_import (col_1,col_2) VALUES(:factory_ask_id,v_factory_ask_type);
  IF v_factory_ask_type = 0 THEN
    v_sql := 'select max(1) as flag from dual';
  ELSE
    v_sql := 'select max(0) as flag from dual';
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_311''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_311''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_311'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010303') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_21''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_21''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_21'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
  v_factory_ask_type NUMBER(1);
BEGIN
  SELECT MAX(a.factory_ask_type)
    INTO v_factory_ask_type
    FROM t_factory_ask a
   WHERE a.factory_ask_id = :factory_ask_id;
  INSERT INTO scmdata.t_excel_import (col_1,col_2) VALUES(:factory_ask_id,v_factory_ask_type);
  IF v_factory_ask_type <> 0 THEN
    v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_312''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_312''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_312'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  v_new_total         number;
  v_old_total         number;
  v_id                varchar2(32);
  v_factory_report_id varchar2(32);
  v_sum               number;
begin
  select count(fr_is_quality_control_y)
    into v_new_total
    from (^'|| CHR(64) ||q'^batchdata)
   where fr_is_quality_control_y is null;
  select max(quality_control_id) into v_id from (^'|| CHR(64) ||q'^batchdata);
  select max(factory_report_id)
    into v_factory_report_id
    from scmdata.t_quality_control_fr
   where quality_control_id = v_id;

  select count(*)
    into v_old_total
    from scmdata.t_quality_control_fr
   where quality_control_id not in
         (select quality_control_id from (^'|| CHR(64) ||q'^batchdata))
     and factory_report_id = v_factory_report_id
     and is_quality_control is null;

  v_sum := v_new_total + v_old_total;
  if v_sum > 0 then
    raise_application_error(-20002, '是否有品控记录为必填字段');
  end if;
end;^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_101_1_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_101_1_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_101_1_7'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql           CLOB;
  v_ask_record_id VARCHAR2(32);
  v_rest_method   VARCHAR2(256);
  v_params        VARCHAR2(2000);
  v_item_id       VARCHAR2(32);
  v_status        VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  scmdata.pkg_plat_comm.p_get_rest_val_method_params(p_character     => nvl(%ass_ask_record_id%,
                                                                            %ass_factory_report_id%),
                                                     po_pk_id        => v_ask_record_id,
                                                     po_rest_methods => v_rest_method,
                                                     po_params       => v_params);

  v_item_id := scmdata.pkg_plat_comm.f_parse_json(p_jsonstr => v_params,
                                                  p_key     => 'item_id');

  SELECT MAX(v.status_af_oper)
    INTO v_status
    FROM scmdata.t_factory_ask t
   INNER JOIN (SELECT tf.status_af_oper,
                      tf.factory_ask_id,
                      row_number() over(PARTITION BY tf.ask_record_id ORDER BY tf.oper_time DESC) rn
                 FROM scmdata.t_factory_ask_oper_log tf) v
      ON v.factory_ask_id = t.factory_ask_id
     AND rn = 1
   WHERE t.factory_ask_id = :factory_ask_id
     AND t.company_id = %default_company_id%;

  IF nvl(v_item_id, '-1') IN ('a_coop_150_3', 'a_coop_211', 'a_check_103_1') OR
     v_status IN ('FA22', 'FA21', 'FA32', 'FA33', 'SP_01') THEN
    v_sql := 'select max(0) from dual';
    --INSERT INTO scmdata.t_excel_import (col_1,col_2,col_3) VALUES ('0',v_item_id,v_sql);
  ELSE
    v_sql := 'select max(1) from dual';
    --INSERT INTO scmdata.t_excel_import (col_1,col_2,col_3) VALUES ('1',v_item_id,v_sql);
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_coop_310''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_coop_310''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_coop_310'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010501') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_27''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_27''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_27'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010301') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_19''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_19''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_19'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010502') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_28''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_28''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_28'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_39''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_39''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_39'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010601') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_29''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_29''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_29'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010702') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_32''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_32''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_32'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001030306') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_150_auto_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_150_auto_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_150_auto_1'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
  v_factory_ask_type NUMBER(1);
BEGIN
  SELECT MAX(a.factory_ask_type)
    INTO v_factory_ask_type
    FROM t_factory_ask a
   WHERE a.factory_ask_id = :factory_ask_id;
  INSERT INTO scmdata.t_excel_import (col_1,col_2) VALUES(:factory_ask_id,v_factory_ask_type);
  IF v_factory_ask_type <> 0 THEN
    v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_312''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_312''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_312'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  JUDGE        NUMBER(1);
  AS_ID        VARCHAR2(32);
  FA_TYPE      NUMBER(1);
  FAC_PROVINCE VARCHAR2(48);
  FAC_CITY     VARCHAR2(48);
  FAC_COUNTY   VARCHAR2(48);
  A_ADDRESS    VARCHAR2(256);
  COO_MODEL    VARCHAR2(48);
  COO_TYPE     VARCHAR2(48);
  COM_NAME     VARCHAR2(300);
  COM_ADDRESS  VARCHAR2(256);
  FAC_NAME     VARCHAR2(300);
  FR_ID        VARCHAR2(50);
  REP_ROW      SCMDATA.T_FACTORY_REPORT%ROWTYPE;
  MEMO         VARCHAR2(600);
BEGIN
  SELECT COUNT(FACTORY_REPORT_ID)
     INTO JUDGE
    FROM SCMDATA.T_FACTORY_REPORT
   WHERE FACTORY_ASK_ID=:FACTORY_ASK_ID;

  IF JUDGE = 0 THEN
    SELECT SCMDATA.PKG_PLAT_COMM.F_GETKEYID_PLAT('CR', 'seq_cr', 99) INTO FR_ID FROM DUAL;

    SELECT ASK_COMPANY_ID,FACTORY_ASK_TYPE /*,FACTORY_PROVINCE,FACTORY_CITY,
           FACTORY_COUNTY*/ ,ASK_ADDRESS,COOPERATION_MODEL,COOPERATION_TYPE,
           COMPANY_NAME,COMPANY_ADDRESS /*,FACTORY_NAME*/,MEMO
      INTO AS_ID,FA_TYPE/*,FAC_PROVINCE,FAC_CITY,FAC_COUNTY*/,A_ADDRESS,
           COO_MODEL,COO_TYPE,COM_NAME,COM_ADDRESS/*,FAC_NAME*/,MEMO
      FROM SCMDATA.T_FACTORY_ASK
     WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID;

    INSERT INTO SCMDATA.T_FACTORY_REPORT
      (FACTORY_REPORT_ID,FACTORY_ASK_ID,COMPANY_NAME,COMPANY_CODE,
       CHECK_USER_ID,CHECK_METHOD,CHECK_PROVINCE,CHECK_CITY,
       CHECK_COUNTY,CHECK_ADDRESS,CHECK_REPORT_FILE,CHECK_SAY,
       CHECK_RESULT,CHECK_DATE,COOPERATION_TYPE,COOPERATION_MODEL,
       CREATE_ID,CREATE_DATE,COMPANY_ID,COMPANY_ADDRESS,
       FACTORY_NAME,REVIEW_ID,REVIEW_DATE,REMARKS)
    VALUES
      (FR_ID,:FACTORY_ASK_ID,COM_NAME,AS_ID,%CURRENT_USERID%,
       FA_TYPE,FAC_PROVINCE,FAC_CITY,FAC_COUNTY,A_ADDRESS,' ',
       ' ',' ',SYSDATE,'PRODUCT_TYPE',COO_MODEL,%CURRENT_USERID%,
       SYSDATE,%default_company_id%,COM_ADDRESS,FAC_NAME,%CURRENT_USERID%,SYSDATE,MEMO);

    FOR REP_ROW IN (SELECT * FROM SCMDATA.T_ASK_SCOPE WHERE OBJECT_ID = :FACTORY_ASK_ID AND BE_COMPANY_ID = %default_company_id%) LOOP
        INSERT INTO SCMDATA.T_FACTORY_REPORT_ABILITY
          (FACTORY_REPORT_ABILITY_ID, COMPANY_ID, FACTORY_REPORT_ID, COOPERATION_TYPE, COOPERATION_CLASSIFICATION,
           COOPERATION_PRODUCT_CATE, COOPERATION_SUBCATEGORY, ABILITY_RESULT)
        VALUES
          (SCMDATA.F_GET_UUID(), %DEFAULT_COMPANY_ID%, FR_ID, REP_ROW.COOPERATION_TYPE, REP_ROW.COOPERATION_CLASSIFICATION,
           REP_ROW.COOPERATION_PRODUCT_CATE, REP_ROW.COOPERATION_SUBCATEGORY, ' ');
    END LOOP;

    UPDATE SCMDATA.T_FACTORY_ASK
       SET FACTRORY_ASK_FLOW_STATUS = 'FA11'
     WHERE FACTORY_ASK_ID = :FACTORY_ASK_ID;
  ELSE
    SCMDATA.PKG_FACTORY_INSPECTION.P_CHECK_CPS(V_FAID => :FACTORY_ASK_ID, V_COMPID => %default_company_id%);
  END IF;
END;^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_101_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_101_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_101_1'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010101') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_1'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010105') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_5'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001030101') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_coop_150_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_coop_150_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_coop_150_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090101050107') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_12''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_12''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_12'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00201') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_check_101_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_check_101_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_check_101_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010202') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_18''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_18''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_18'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00202') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_check_102_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_check_102_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_check_102_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010401') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_22''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_22''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_22'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010103') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_3'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010701') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_31''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_31''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_31'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010107') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_16''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_16''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_16'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010802') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_35''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_35''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_35'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010402') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_23''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_23''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_23'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010901') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_37''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_37''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_37'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P009010902') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_38''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_38''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_38'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0090104') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond__auto_42''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond__auto_42''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond__auto_42'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
 v_sql                  VARCHAR2(512);
 v_factory_report_id    VARCHAR2(4000);
 v_rest_method          VARCHAR2(4000);
 v_params               VARCHAR2(4000);
 v_is_element_show      VARCHAR2(4000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
   --element是否显示
   v_is_element_show :=SCMDATA.PARSE_JSON(p_jsonstr => v_params,
                                                p_key     => 'COL_1');

   IF v_is_element_show = 1 THEN
      v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;

  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_ass_a_check_103_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_ass_a_check_103_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_ass_a_check_103_2'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql             CLOB;
  v_ask_record_id   VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(2000);
  v_is_show_element VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_is_show_element := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                                    p_key     => 'is_show_element');
  v_is_show_element := nvl(v_is_show_element, 1);
  IF v_is_show_element = 1 THEN
    v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;
  ^'|| CHR(64) ||q'^strresult        := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_coop_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_coop_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_coop_151'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  v_count number;
  v1_count number;
  v_factory_report_id varchar2(32);
  v_rest_method varchar2(1000);
  v_params  varchar2(1000);
  v_new_total         number;
  v_old_total         number;
  v_sum               number;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  insert into scmdata.t_excel_import (col_1,col_2) values ('factory_report_id',v_factory_report_id);

  select count(*)
    into v_count
    from scmdata.t_quality_control_fr
   where factory_report_id = v_factory_report_id
     and is_quality_control is null;
  if v_count > 0 then
    raise_application_error(-20002, '是否有品控记录为必填字段');
  end if;
  /*select count(*)
    into v1_count
    from scmdata.t_factory_report
   where spot_check_result is null
     and factory_report_id = v_factory_report_id;
  if v1_count > 0 then
    raise_application_error(-20002, '抽查结果字段为必填字段');
  end if;*/
END;^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_101_1_9''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_101_1_9''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_101_1_9'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  v_count number;
begin
  select count(fr_spot_check_result_y)
    into v_count
    from (^'|| CHR(64) ||q'^batchdata)
   where fr_spot_check_result_y is null;
  if v_count > 0 then
    raise_application_error(-20002, '抽查结果字段为必填字段');
  end if;
end;^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_101_1_8''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_101_1_8''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_101_1_8'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
 v_sql                  VARCHAR2(512);
 v_factory_report_id    VARCHAR2(4000);
 v_rest_method          VARCHAR2(4000);
 v_params               VARCHAR2(4000);
 v_is_element_show      VARCHAR2(4000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
   --element是否显示
   v_is_element_show :=SCMDATA.PARSE_JSON(p_jsonstr => v_params,
                                                p_key     => 'COL_1');

   IF v_is_element_show = 1 THEN
      v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;

  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_ass_a_check_103_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_ass_a_check_103_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_ass_a_check_103_2'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00103020302') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_action_a_check_farevoke_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_action_a_check_farevoke_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_action_a_check_farevoke_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
  v_factory_ask_type NUMBER(1);
BEGIN
  SELECT MAX(a.factory_ask_type)
    INTO v_factory_ask_type
    FROM t_factory_ask a
   WHERE a.factory_ask_id = :factory_ask_id;
  INSERT INTO scmdata.t_excel_import (col_1,col_2) VALUES(:factory_ask_id,v_factory_ask_type);
  IF v_factory_ask_type <> 0 THEN
    v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_312''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_312''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_312'',1,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P0020102') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_ac_a_check_101_3_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_ac_a_check_101_3_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_ac_a_check_101_3_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001040205') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_asso_a_coop_150_0_auto_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_asso_a_coop_150_0_auto_6'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P001040102') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_action_a_coop_311_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_action_a_coop_311_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_action_a_coop_311_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.F_USERHASACTION_APP_SEE(%Current_UserID%,%Default_Company_ID%,'apply_2') from dual^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_a_check_100''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_a_check_100''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_a_check_100'',,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00302') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_supp_160_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_supp_160_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_supp_160_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,'P00103') as flag from dual ^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_COND_LIST WHERE COND_ID = ''cond_node_a_coop_200_auto''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_COND_LIST SET (COND_FIELD_NAME,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) = (SELECT q''[]'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL) WHERE COND_ID = ''cond_node_a_coop_200_auto''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_COND_LIST (COND_FIELD_NAME,COND_ID,COND_TYPE,DATA_SOURCE,MEMO,COND_SQL,SHOW_TEXT) SELECT q''[]'',''cond_node_a_coop_200_auto'',0,q''[oracle_scmdata]'',q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

