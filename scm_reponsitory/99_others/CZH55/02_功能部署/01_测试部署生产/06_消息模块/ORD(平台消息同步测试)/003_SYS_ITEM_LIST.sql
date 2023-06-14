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
  CV7 CLOB:=q'[SELECT lg.title,
       lg.msg_info message_info,
       lg.sender,
       listagg(ld.receiver, ';') within GROUP(ORDER BY 1) receiver
  FROM bw3.msg_log lg
 INNER JOIN bw3.msg_log_detail ld
    ON lg.log_id = ld.log_id
 WHERE lg.object_type = 'SYSTEM_NOTICE'
    OR (lg.object_type = 'hint' AND instr(lg.sender, 'ϵͳ#sys_hint_') > 0)
 GROUP BY lg.title, lg.urgent, lg.send_type, lg.sender, lg.msg_info


/*SELECT lg.title,
       lg.urgent,
       lg.send_type,
       lg.sender,
       (SELECT listagg(ld.receiver, ';') within GROUP(ORDER BY 1)
          FROM bw3.msg_log_detail ld
         WHERE lg.log_id = ld.log_id) receiver,
       lg.msg_info message_info,
       lg.send_state,
       lg.send_time,
       lg.fail_receiver
  FROM bw3.msg_log lg
 WHERE lg.object_type = 'SYSTEM_NOTICE'*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''g_530_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[title,message_info]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''g_530_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''g_530_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[title,message_info]'',12,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV3 CLOB:=q'[DECLARE
  v_hint_id      VARCHAR2(100);
  v_apply_id     VARCHAR2(100);
  v_cond_sql     VARCHAR2(4000);
  v_group_msg_id VARCHAR2(100);
  v_text_sql     CLOB;
  v_btn_enable_sql VARCHAR2(256);
BEGIN

  v_hint_id := f_getkeyid_plat(pi_pre     => 'hint_',
                               pi_seqname => 'SEQ_SYS_HINT',
                               pi_seqnum  => 2);

  IF instr(lower(:text_sql), 'select') > 0 THEN
    v_text_sql := :text_sql;
  ELSE
    v_text_sql := 'select ' || '''' || :text_sql || '''' || ' from dual';
  END IF;

  IF :btn_enable_sql is null THEN
   v_btn_enable_sql := null;
  ELSE
   v_btn_enable_sql := 'select ' || :btn_enable_sql || ' from dual';
  END IF;

  pkg_msg_config.config_sys_hint(p_hint_id        => v_hint_id,
                                 p_node_id        => :node_id,
                                 p_caption        => :caption,
                                 p_text_sql       => v_text_sql,
                                 p_data_sql       => '',
                                 p_btn_caption    => :btn_caption,
                                 p_btn_exec_sql   => :btn_exec_sql,
                                 p_btn_enable_sql => v_btn_enable_sql,
                                 p_wrap_flag      => :wrap_flag,
                                 p_hint_flag      => :hint_flag,
                                 p_pause          => 0,
                                 p_data_source    => 'oracle_scmdata');

  v_group_msg_id := scmdata.f_get_uuid();

  pkg_msg_config.insert_sys_group_msg_config(p_group_msg_id   => v_group_msg_id,
                                             p_group_msg_name => :group_msg_name,
                                             p_config_id      => v_hint_id,
                                             p_config_type    => 'HINT',
                                             p_apply_id       => :apply_id,
                                             p_user_id        => %user_id%,
                                             p_memo           => '');

  v_cond_sql := ]' ||
              q'['SELECT MAX(1)
    FROM dual
   WHERE pkg_msg_config.check_person(p_company_id   => %default_company_id%,
                                     p_user_id      => %user_id%,
                                     p_group_msg_id => ']' ||
              q'[ ||
                v_group_msg_id ||]' || q'[') = 1']' || q'[;

  pkg_msg_config.config_jurisdiction(p_cond_id         => 'cond_' ||
                                                          v_hint_id,
                                     p_cond_sql        => v_cond_sql,
                                     p_cond_type       => '',
                                     p_show_text       => '',
                                     p_data_source     => 'oracle_scmdata',
                                     p_cond_field_name => '',
                                     p_memo            => '',
                                     p_obj_type        => 41,
                                     p_ctl_id          => v_hint_id,
                                     p_ctl_type        => 0,
                                     p_seq_no          => 0,
                                     p_pause           => 0,
                                     p_item_id         => '');

END;]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[SELECT gm.pause,
       gm.group_msg_id,
       gm.apply_id,
       (SELECT ga.apply_name
          FROM scmdata.sys_group_apply ga
         WHERE ga.apply_id = gm.apply_id) apply_name,
       gm.group_msg_name,
       t.hint_id,
       t.node_id,
       t.caption,
       t.text_sql,
       t.btn_caption,
       t.btn_exec_sql,
       decode(to_char(t.btn_enable_sql),
              'select 1 from dual',
              1,
              'select 0 from dual',
              0,
              NULL) btn_enable_sql,
       t.wrap_flag,
       t.hint_flag
  FROM scmdata.sys_group_msg_config gm
 INNER JOIN bw3.sys_hint t
    ON gm.config_id = t.hint_id
 WHERE gm.config_type = 'HINT']';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  v_btn_enable_sql VARCHAR2(256);
BEGIN
 UPDATE scmdata.sys_group_msg_config gm
    SET gm.group_msg_name = :group_msg_name,
        gm.apply_id       = :apply_id
  WHERE gm.group_msg_id = :group_msg_id;

  IF :btn_enable_sql is null THEN
   v_btn_enable_sql := null;
  ELSE
   v_btn_enable_sql := 'select ' || :btn_enable_sql || ' from dual';
  END IF;

  pkg_msg_config.update_sys_hint(p_hint_id        => :hint_id,
                                 p_node_id        => :node_id,
                                 p_caption        => :caption,
                                 p_text_sql       => :text_sql,
                                 p_btn_caption    => :btn_caption,
                                 p_btn_exec_sql   => :btn_exec_sql,
                                 p_btn_enable_sql => v_btn_enable_sql,
                                 p_wrap_flag      => :wrap_flag,
                                 p_hint_flag      => :hint_flag);
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''g_530_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[group_msg_id,hint_id,apply_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''g_530_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''g_530_2'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[group_msg_id,hint_id,apply_id]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
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
  CV7 CLOB:=q'[select 1 from dual]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''g_530_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''g_530_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATION_TYPE,OUTPUT_PARAMETER,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 3,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''g_530_3'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

