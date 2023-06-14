BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[SELECT --'' ctl_id,
       --'' itf_id,
       '' itf_type,
       '' batch_id,
       '' batch_num,
       '' batch_time,
       '' sender,
       '' receiver,
       '' send_time,
       '' receive_time,
       '' data_status,
       '' return_type,
       '' return_msg,
       '' create_id,
       '' create_time,
       '' update_id,
       '' update_time,
       '' publish_id,
       '' publish_time
  FROM dual]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_supp_140''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 18,q''[]'',q''[查看接口监控（181）]'',q''[]'',q''[]'',1,,q''[method_a_supp_140]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_supp_140''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 18,q''[]'',q''[查看接口监控（181）]'',''action_a_supp_140'',q''[]'',q''[]'',1,,q''[method_a_supp_140]'',1,,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

