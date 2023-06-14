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
  CV7 CLOB:=q'[SELECT ca.company_id,
       ga.apply_id,
       gm.config_id,
       gm.group_msg_id,
       ga.apply_name,
       gm.group_msg_name,
       (SELECT DISTINCT mc.pause
          FROM scmdata.sys_company_msg_config mc
         WHERE gm.group_msg_id = mc.group_msg_id
           AND mc.company_id = ca.company_id) pause
  FROM scmdata.sys_group_apply ga
 INNER JOIN scmdata.sys_company_apply ca
    ON ca.apply_id = ga.apply_id
   AND ca.pause = 0
   AND ga.pause = 0
 INNER JOIN scmdata.sys_group_msg_config gm
    ON gm.apply_id = ca.apply_id
   AND gm.pause = 0
 WHERE ca.company_id = %default_company_id%]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''c_2300_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[GROUP_MSG_NAME]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id,.apply_id,config_id,group_msg_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''c_2300_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''c_2300_1'',q''[]'',q''[GROUP_MSG_NAME]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_id,.apply_id,config_id,group_msg_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV1 CLOB:=q'[call pkg_msg_config.delete_sys_company_msg_config(p_company_msg_id => :company_msg_id)]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[DECLARE
  v_flag NUMBER;
  v_config_type varchar2(32) := :config_type;

  CURSOR role_users IS
    SELECT b.user_id
      FROM sys_company_user a
     INNER JOIN sys_app_user_role_group_ra b
        ON a.user_id = b.user_id
       AND a.company_id = b.company_id
      LEFT JOIN sys_company_user c
        ON b.create_id = c.user_id
       AND b.company_id = c.company_id
      LEFT JOIN sys_company_user d
        ON b.update_id = d.user_id
       AND b.company_id = d.company_id
     WHERE b.role_group_id = :role_group_id
       AND b.company_id = %default_company_id%;

BEGIN
  IF v_config_type = 'P' THEN
    pkg_msg_config.insert_sys_company_msg_config(p_company_msg_id => scmdata.f_get_uuid(),
                                                 p_group_msg_id   => :group_msg_id,
                                                 p_company_id     => :company_id,
                                                 p_user_id        => :user_id,
                                                 p_alter_id       => %user_id%,
                                                 p_memo           => '');
  ELSIF v_config_type = 'R' THEN
    FOR role_rec IN role_users LOOP

      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.sys_company_msg_config ms
       WHERE ms.company_id = :company_id
         AND ms.group_msg_id = :group_msg_id
         AND ms.user_id = role_rec.user_id;

      IF v_flag > 0 THEN
        NULL;
      ELSE
        pkg_msg_config.insert_sys_company_msg_config(p_company_msg_id => scmdata.f_get_uuid(),
                                                     p_group_msg_id   => :group_msg_id,
                                                     p_company_id     => :company_id,
                                                     p_user_id        => role_rec.user_id,
                                                     p_alter_id       => %user_id%,
                                                     p_memo           => '');
      END IF;
    END LOOP;
  ELSIF v_config_type = 'D' THEN
    NULL;
  ELSE
    NULL;
  END IF;
END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[WITH company_user AS
 (SELECT fc.company_id, fc.user_id, fc.company_user_name, fc.phone
    FROM scmdata.sys_company_user fc)
SELECT mc.company_msg_id,
       mc.group_msg_id,
       mc.company_id,
       mc.pause,
       a.company_user_name,
       a.phone,
       b.company_user_name create_id,
       mc.create_time
  FROM scmdata.sys_company_msg_config mc
 INNER JOIN company_user a
    ON a.company_id = mc.company_id
   AND a.user_id = mc.user_id
 INNER JOIN company_user b
    ON b.company_id = mc.company_id
   AND b.user_id = mc.create_id
 WHERE mc.company_id = %default_company_id%
   AND mc.group_msg_id = :group_msg_id
   AND mc.memo is null]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''c_2300_11''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_msg_id,group_msg_id,company_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''c_2300_11''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''c_2300_11'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[company_msg_id,group_msg_id,company_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

