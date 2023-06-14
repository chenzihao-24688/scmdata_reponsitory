BEGIN
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION)
values ('c_2412', 'list', '数据权限配置', 'oracle_scmdata', 'sys_company_data_priv_group', 'data_priv_group_id', null, 'c_2412', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION)
values ('c_2413', 'list', '数据权限配置', 'oracle_scmdata', 'sys_company_data_priv_group', 'data_priv_group_id', null, 'c_2413', null, null, 0, null, null, null, null, null, null, null, null, null, null, null, null, 1);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('c_2412', 12, null, null, null, null, 'SELECT pg.data_priv_group_id data_priv_group_id,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id,
       pm.user_id,
       pg.seq_no,
       pg.create_id,
       pg.create_time,
       pg.update_id,
       pg.update_time,
       pm.data_priv_user_middle_id
  FROM sys_company_data_priv_group pg
 INNER JOIN scmdata.sys_company_data_priv_user_middle pm
    ON pg.company_id = pm.company_id
   AND pg.data_priv_group_id = pm.data_priv_group_id
 WHERE pm.company_id = %default_company_id%
   AND pm.user_id = :user_id', null, null, 'DECLARE
v_flag number;
BEGIN
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.sys_company_data_priv_user_middle dp
   WHERE dp.company_id = :company_id
     AND dp.user_id = :user_id
     AND dp.data_priv_group_id = :data_priv_group_id;
  IF v_flag > 0 THEN
    raise_application_error(-20002, ''该数据权限组已配置，请勿重复操作！'');
  ELSE
    INSERT INTO sys_company_data_priv_user_middle
      (data_priv_user_middle_id,
       data_priv_group_id,
       user_id,
       create_id,
       create_time,
       update_id,
       update_time,
       company_id)
    VALUES
      (scmdata.f_get_uuid(),
       :data_priv_group_id,
       :user_id,
       %current_userid%,
       SYSDATE,
       %current_userid%,
       SYSDATE,
       %default_company_id%);
  END IF;
END;', null, 'DELETE FROM sys_company_data_priv_user_middle pm
 WHERE pm.company_id = %default_company_id%
   AND pm.data_priv_user_middle_id = :data_priv_user_middle_id', 'data_priv_group_id,company_id,user_id,data_priv_user_middle_id', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('c_2413', 12, null, null, null, null, 'SELECT pg.data_priv_group_id,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id,      
       pg.seq_no,
       pg.create_id,
       pg.create_time,
       pg.update_id,
       pg.update_time,
       pm.data_priv_dept_middle_id
  FROM sys_company_data_priv_group pg
 INNER JOIN scmdata.sys_company_data_priv_dept_middle pm
    ON pg.company_id = pm.company_id
   AND pg.data_priv_group_id = pm.data_priv_group_id
 WHERE pm.company_id = %default_company_id%
   AND pm.company_dept_id = :company_dept_id', null, null, 'DECLARE
  v_flag NUMBER;
BEGIN
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.sys_company_data_priv_dept_middle dp
   WHERE dp.company_id = :company_id
     AND dp.company_dept_id = :company_dept_id
     AND dp.data_priv_group_id = :data_priv_group_id;
  IF v_flag > 0 THEN
    raise_application_error(-20002, ''该数据权限组已配置，请勿重复操作！'');
  ELSE
    INSERT INTO sys_company_data_priv_dept_middle
      (data_priv_dept_middle_id,
       data_priv_group_id,
       create_id,
       create_time,
       update_id,
       update_time,
       company_id,
       company_dept_id)
    VALUES
      (scmdata.f_get_uuid(),
       :data_priv_group_id,
       %current_userid%,
       SYSDATE,
       %current_userid%,
       SYSDATE,
       %default_company_id%,
       :company_dept_id);
  
    FOR user_rec IN (SELECT t.user_id, t.company_id
                       FROM scmdata.sys_company_dept dt
                      INNER JOIN scmdata.sys_company_user_dept t
                         ON dt.company_id = t.company_id
                        AND dt.company_dept_id = t.company_dept_id
                      WHERE dt.company_id = :company_id
                        AND dt.company_dept_id = :company_dept_id) LOOP
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.sys_company_data_priv_user_middle dp
       WHERE dp.company_id = user_rec.company_id
         AND dp.user_id = user_rec.user_id
         AND dp.data_priv_group_id = :data_priv_group_id;
    
      IF v_flag > 0 THEN
        CONTINUE;
      ELSE
        INSERT INTO sys_company_data_priv_user_middle
          (data_priv_user_middle_id,
           data_priv_group_id,
           user_id,
           create_id,
           create_time,
           update_id,
           update_time,
           company_id)
        VALUES
          (scmdata.f_get_uuid(),
           :data_priv_group_id,
           user_rec.user_id,
           %current_userid%,
           SYSDATE,
           %current_userid%,
           SYSDATE,
           %default_company_id%);
      END IF;
    END LOOP;
  END IF;
END;', null, 'DECLARE
BEGIN
  FOR user_rec IN (SELECT t.user_id, t.company_id
                     FROM scmdata.sys_company_dept dt
                    INNER JOIN scmdata.sys_company_user_dept t
                       ON dt.company_id = t.company_id
                      AND dt.company_dept_id = t.company_dept_id
                    WHERE dt.company_id = %default_company_id%
                      AND dt.company_dept_id = :company_dept_id) LOOP
  
    DELETE FROM sys_company_data_priv_user_middle dp
     WHERE dp.company_id = user_rec.company_id
       AND dp.user_id = user_rec.user_id
       AND dp.data_priv_group_id = :data_priv_group_id;
  
  END LOOP;

  DELETE FROM sys_company_data_priv_dept_middle pm
   WHERE pm.company_id = %default_company_id%
     AND pm.company_dept_id = :company_dept_id
     AND pm.data_priv_group_id = :data_priv_group_id;
END;', 'data_priv_group_id,company_id,user_id,data_priv_dept_middle_id', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

END;
