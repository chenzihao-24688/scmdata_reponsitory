BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
BEGIN
  FOR data_rec IN (SELECT t.data_priv_id
                     FROM scmdata.sys_data_privs t
                    WHERE t.data_priv_id IN (@selection)) LOOP
    scmdata.pkg_data_privs.update_data_privs_status(p_data_priv_id => data_rec.data_priv_id,
                                                    p_status       => 1);
  END LOOP;

END;
]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_g_560_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[����]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[data_priv_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_g_560_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[����]'',''action_g_560_1'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[data_priv_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  FOR data_rec IN (SELECT t.data_priv_id
                     FROM scmdata.sys_data_privs t
                    WHERE t.data_priv_id IN (@selection)) LOOP
    scmdata.pkg_data_privs.update_data_privs_status(p_data_priv_id => data_rec.data_priv_id,
                                                    p_status       => 0);
  END LOOP;

END;
]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_g_560_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[ͣ��]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[data_priv_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_g_560_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[ͣ��]'',''action_g_560_2'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[data_priv_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

