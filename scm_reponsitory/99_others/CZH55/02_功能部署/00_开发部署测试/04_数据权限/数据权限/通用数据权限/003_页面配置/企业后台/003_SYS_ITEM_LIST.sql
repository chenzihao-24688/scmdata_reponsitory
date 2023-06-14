BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
v_dflag number;
BEGIN
v_dflag := scmdata.pkg_data_privs.check_is_data_privs(p_company_id => %default_company_id%,p_data_priv_group_id => :data_priv_group_id,v_type => 1);
IF v_dflag > 0 THEN
raise_application_error(-20002,'该数据权限组存在人员配置，不能删除！');
ELSE
v_dflag := scmdata.pkg_data_privs.check_is_data_privs(p_company_id => %default_company_id%,p_data_priv_group_id => :data_priv_group_id,v_type => 2);
IF v_dflag > 0 THEN
raise_application_error(-20002,'该数据权限组存在数据权限，不能删除！');
ELSE
DELETE FROM sys_company_data_priv_group t
 WHERE t.company_id = :company_id
   AND t.data_priv_group_id = :data_priv_group_id;
END IF;
END IF;
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_data_priv_code VARCHAR2(32);
BEGIN

  v_data_priv_code := pkg_plat_comm.f_getkeycode(pi_table_name  => 'sys_company_data_priv_group',
                                                 pi_column_name => 'data_priv_group_code',
                                                 pi_company_id  => %default_company_id%,
                                                 pi_pre         => 'DPG',
                                                 pi_serail_num  => 6);
  INSERT INTO sys_company_data_priv_group
    (data_priv_group_id,
     data_priv_group_code,
     data_priv_group_name,
     company_id,
     user_id,
     seq_no,
     create_id,
     create_time,
     update_id,
     update_time)
  VALUES
    (scmdata.f_get_uuid(),
     v_data_priv_code,
     :data_priv_group_name,
     %default_company_id%,
     NULL, --组织架构在进行配置
     :seq_no,
     :user_id,
     SYSDATE,
     :user_id,
     SYSDATE);
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT pg.data_priv_group_id DATA_PRIV_GROUP_ID,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id,
       pg.user_id,
       pg.seq_no,
       pg.create_id,
       pg.create_time,
       pg.update_id,
       pg.update_time
  FROM sys_company_data_priv_group pg
  WHERE pg.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[UPDATE sys_company_data_priv_group t
   SET t.data_priv_group_name = :data_priv_group_name,
       t.seq_no      = :seq_no,
       t.update_id   = :user_id,
       t.update_time = SYSDATE
 WHERE t.company_id = :company_id
   AND t.data_priv_group_id = :data_priv_group_id]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''c_2410''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id,user_id]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''c_2410''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''c_2410'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id,user_id]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'[DELETE FROM sys_company_data_priv_page_middle pm
 WHERE pm.company_id = %default_company_id%
   AND pm.data_priv_page_middle_id = :data_priv_page_middle_id]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[INSERT INTO sys_company_data_priv_page_middle
  (data_priv_page_middle_id,
   data_priv_group_id,
   data_priv_page_id,
   create_id,
   create_time,
   update_id,
   update_time,
   company_id)
VALUES
  (scmdata.f_get_uuid(),
   :data_priv_group_id,
   :data_priv_page_id,
   :user_id,
   SYSDATE,
   :user_id,
   SYSDATE,
   %default_company_id%)]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT pg.data_priv_group_id data_priv_group_id,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id,
       pg.user_id,
       pg.seq_no,
       pg.create_id,
       pg.create_time,
       pg.update_id,
       pg.update_time,
       pm.data_priv_page_middle_id
  FROM sys_company_data_priv_group pg
 INNER JOIN scmdata.sys_company_data_priv_page_middle pm
    ON pg.company_id = pm.company_id
   AND pg.data_priv_group_id = pm.data_priv_group_id
 WHERE pm.company_id = %default_company_id%
   AND pm.data_priv_page_id = :data_priv_page_id]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''c_2411''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_group_id,company_id,user_id,data_priv_page_middle_id]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''c_2411''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''c_2411'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_group_id,company_id,user_id,data_priv_page_middle_id]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
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
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''c_2420''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_id,company_id]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''c_2420''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''c_2420'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_id,company_id]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'[DECLARE
v_dflag number;
BEGIN
v_dflag := scmdata.pkg_data_privs.check_is_data_privs(p_company_id => %default_company_id%,
                                                      p_data_priv_group_id => :data_priv_group_id,
                                                      p_data_priv_middle_id => :data_priv_middle_id,
                                                      v_type => 2);
IF v_dflag > 0 THEN
raise_application_error(-20002,'该数据权限存在人员配置，不能删除！');
ELSE
DELETE FROM sys_company_data_priv_middle pm
 WHERE pm.company_id = %default_company_id%
   AND pm.data_priv_middle_id = :data_priv_middle_id;
END IF;
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
BEGIN
  INSERT INTO sys_company_data_priv_middle
    (data_priv_middle_id,
     data_priv_group_id,
     data_priv_id,
     create_id,
     create_time,
     update_id,
     update_time,
     company_id)
  VALUES
    (scmdata.f_get_uuid(),
     :DATA_PRIV_GROUP_ID,
     :data_priv_id,
     :user_id,
     SYSDATE,
     :user_id,
     SYSDATE,
     %default_company_id%);

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
       pm.data_priv_middle_id
  FROM scmdata.sys_data_privs dp
 INNER JOIN scmdata.sys_company_data_priv_middle pm
    ON dp.data_priv_id = pm.data_priv_id
   AND pm.data_priv_group_id = :data_priv_group_id
 WHERE pm.company_id = %default_company_id%
 ORDER BY dp.level_type ASC, dp.seq_no ASC

 ]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''c_2421''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_id,data_priv_middle_id,DATA_PRIV_GROUP_ID]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''c_2421''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''c_2421'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[data_priv_id,data_priv_middle_id,DATA_PRIV_GROUP_ID]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'[DELETE FROM sys_company_data_priv_page t
 WHERE t.company_id = %default_company_id%
   AND t.data_priv_page_id = :data_priv_page_id]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[INSERT INTO sys_company_data_priv_page
  (data_priv_page_id,
   item_id,
   item_name,
   create_id,
   create_time,
   update_id,
   update_time,
   company_id)
VALUES
  (scmdata.f_get_uuid(),
   :item_id,
   :item_name,
   :user_id,
   SYSDATE,
   :user_id,
   SYSDATE,
   %default_company_id%)]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT p.data_priv_page_id,
       p.item_id,
       p.item_name,
       p.create_id,
       p.create_time,
       p.update_id,
       p.update_time,
       p.company_id
  FROM sys_company_data_priv_page p]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[UPDATE sys_company_data_priv_page t
   SET t.item_id     = :item_id,
       t.item_name   = :item_name,
       t.update_id   = :user_id,
       t.update_time = SYSDATE
 WHERE t.company_id = %default_company_id%
   AND t.data_priv_page_id = :data_priv_page_id]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''c_2440''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''c_2440''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''c_2440'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,0,q''[]'',q''[]'',,q''[]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

