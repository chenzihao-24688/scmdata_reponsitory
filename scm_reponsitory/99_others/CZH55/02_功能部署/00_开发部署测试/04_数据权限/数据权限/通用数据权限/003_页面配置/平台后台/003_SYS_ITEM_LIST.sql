BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  v_type VARCHAR2(32);
BEGIN
  SELECT upper(dp.fields_config_method)
    INTO v_type
    FROM scmdata.sys_data_privs dp
   WHERE dp.data_priv_id = :data_priv_id;

  IF v_type = 'PICK_LIST' THEN
    DELETE FROM sys_data_priv_pick_fields t
     WHERE t.data_priv_pick_field_id = :data_priv_pick_field_id;
  ELSIF v_type = 'LOOK_UP' THEN
    DELETE FROM sys_data_priv_lookup_fields t
     WHERE t.data_priv_lookup_field_id = :data_priv_lookup_field_id;
  ELSIF v_type = 'DATE' THEN
    DELETE FROM sys_data_priv_date_fields t
     WHERE t.data_priv_date_field_id = :data_priv_date_field_id;
  END IF;
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_type VARCHAR2(32);
BEGIN
  SELECT upper(dp.fields_config_method)
    INTO v_type
    FROM scmdata.sys_data_privs dp
   WHERE  dp.data_priv_id = :data_priv_id;

  IF v_type = 'PICK_LIST' THEN
    INSERT INTO sys_data_priv_pick_fields
      (data_priv_pick_field_id,
       data_priv_id,
       create_id,
       create_time,
       update_id,
       update_time,
       col_1,
       col_2,
       col_3,
       col_4,
       col_5,
       col_6,
       col_7,
       col_8,
       col_9,
       col_10)
    VALUES
      (scmdata.f_get_uuid(),
       :data_priv_id,
       :user_id,
       SYSDATE,
       :user_id,
       SYSDATE,
       :col_1,
       :col_2,
       :col_3,
       :col_4,
       :col_5,
       :col_6,
       :col_7,
       :col_8,
       :col_9,
       :col_10);
  ELSIF v_type = 'LOOK_UP' THEN
    INSERT INTO sys_data_priv_lookup_fields
      (data_priv_lookup_field_id,
       data_priv_id,
       create_id,
       create_time,
       update_id,
       update_time,
       col_11)
    VALUES
      (scmdata.f_get_uuid(),
       :data_priv_id,
       :user_id,
       SYSDATE,
       :user_id,
       SYSDATE,
       :col_11);
  ELSIF v_type = 'DATE' THEN
    INSERT INTO sys_data_priv_date_fields
      (data_priv_date_field_id,
       data_priv_id,
       create_id,
       create_time,
       update_id,
       update_time,
       col_21,
       col_22)
    VALUES
      (scmdata.f_get_uuid(),
       :data_priv_id,
       :user_id,
       SYSDATE,
       :user_id,
       SYSDATE,
       :col_21,
       :col_22);
  END IF;
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := pkg_data_privs.get_data_privs(p_data_priv_id => :data_priv_id);
  @strresult := v_sql;
END;}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  v_type VARCHAR2(32);
BEGIN
  SELECT upper(dp.fields_config_method)
    INTO v_type
    FROM scmdata.sys_data_privs dp
   WHERE dp.data_priv_id = :data_priv_id;

  IF v_type = 'PICK_LIST' THEN
   UPDATE sys_data_priv_pick_fields t
      SET t.update_id   = :user_id,
       t.update_time = SYSDATE,
       t.col_1       = :col_1,
       t.col_2       = :col_2,
       t.col_3       = :col_3,
       t.col_4       = :col_4,
       t.col_5       = :col_5,
       t.col_6       = :col_6,
       t.col_7       = :col_7,
       t.col_8       = :col_8,
       t.col_9       = :col_9,
       t.col_10      = :col_10
   WHERE t.data_priv_pick_field_id = :data_priv_pick_field_id;

  ELSIF v_type = 'LOOK_UP' THEN
     UPDATE sys_data_priv_lookup_fields t
      SET t.update_id   = :user_id,
       t.update_time = SYSDATE,
       t.col_11       = :col_11
   WHERE t.data_priv_lookup_field_id = :data_priv_lookup_field_id;
  ELSIF v_type = 'DATE' THEN
  UPDATE sys_data_priv_date_fields t
      SET t.update_id   = :user_id,
       t.update_time = SYSDATE,
       t.col_21       = :col_21,
       t.col_22       = :col_22
   WHERE t.data_priv_date_field_id = :data_priv_date_field_id;
  END IF;
END;
]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''c_2431''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_field_id,company_id,data_priv_id,col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''c_2431''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''c_2431'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_field_id,company_id,data_priv_id,col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'[--平台级数据权限只能启停，不能删除
/*DELETE FROM sys_data_privs t
 WHERE t.data_priv_id = :data_priv_id*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_data_priv_id VARCHAR2(32);
  v_data_priv_code VARCHAR2(32);
BEGIN
  v_data_priv_id := scmdata.f_get_uuid();
  v_data_priv_code := scmdata.f_getkeyid_plat(pi_pre => 'DP',pi_seqname => 'seq_data_priv_code',pi_seqnum  => 2);

  INSERT INTO sys_data_privs
    (data_priv_id,
     data_priv_code,
     data_priv_name,
     seq_no,
     level_type,
     fields_config_method,
     create_id,
     create_time,
     update_id,
     update_time)
  VALUES
    (v_data_priv_id,
     v_data_priv_code,
     :data_priv_name,
     :seq_no,
     :level_type,
     :fields_config_method,
     :user_id,
     SYSDATE,
     :user_id,
     SYSDATE);
   scmdata.pkg_data_privs.data_privs_dispen(p_data_priv_id   => v_data_priv_id,p_data_priv_name => :data_priv_name,p_user_id  => :user_id);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT dp.data_priv_id,
       dp.pause pause_desc,
       dp.data_priv_code,
       dp.data_priv_name,
       dp.seq_no,
       dp.level_type,
       dp.fields_config_method,
       dp.create_id,
       dp.create_time,
       dp.update_id,
       dp.update_time
  FROM sys_data_privs dp
 ORDER BY dp.level_type ASC, dp.seq_no ASC]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[UPDATE sys_data_privs t
   SET t.data_priv_name = :data_priv_name,
       t.seq_no         = :seq_no,
       t.level_type     = :level_type,
       t.fields_config_method = :fields_config_method,
       t.update_id      = :update_id,
       t.update_time    = :update_time
 WHERE t.data_priv_id = :data_priv_id]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''g_560''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_id]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''g_560''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''g_560'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_id]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

