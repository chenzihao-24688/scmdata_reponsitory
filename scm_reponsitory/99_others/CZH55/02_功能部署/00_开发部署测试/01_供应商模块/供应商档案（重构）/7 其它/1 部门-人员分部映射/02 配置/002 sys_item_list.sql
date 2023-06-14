begin
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('c_2058', 0, null, null, null, null, 'SELECT a.user_cate_map_id,
       a.user_cate_map_code,
       a.company_id,
       a.cooperation_type,
       a.cooperation_classification,
       t1.group_dict_name           coop_type_desc,
       t2.group_dict_name           coop_classification_desc,
       a.pause,
       b.company_user_name          creator,
       a.create_time,
       c.company_user_name          updator,
       a.update_time
  FROM sys_company_user_cate_map a
  LEFT JOIN sys_company_user b
    ON a.create_id = b.user_id
   AND a.company_id = b.company_id
  LEFT JOIN sys_company_user c
    ON a.update_id = c.user_id
   AND a.company_id = c.company_id
  LEFT JOIN sys_group_dict t1
    ON a.cooperation_type = t1.group_dict_value
   AND t1.group_dict_type = ''COOPERATION_TYPE''
  LEFT JOIN sys_group_dict t2
    ON a.cooperation_classification = t2.group_dict_value
   AND t2.group_dict_type = a.cooperation_type
 WHERE a.company_id = %default_company_id%
   AND a.user_id = :user_id




/*  
select a.data_priv_id,a.data_priv_code,a.company_id,a.cooperation_type,a.cooperation_classification,a.cooperation_product_cate,
       t1.group_dict_name COOP_TYPE_DESC,t2.group_dict_name COOP_CLASSIFICATION_DESC,
       t3.group_dict_name PRODUCTION_CATEGORY_DESC,
       a.pause,b.company_user_name creator,a.create_time,c.company_user_name updator ,a.update_time
  from sys_company_data_priv a
  left join sys_company_user b on a.create_id=b.user_id and a.company_id=b.company_id
  left join sys_company_user c on a.update_id=c.user_id and a.company_id=c.company_id
  left join sys_group_dict t1 on a.cooperation_type = t1.group_dict_value and t1.group_dict_type = ''COOPERATION_TYPE''
  left join sys_group_dict t2 on a.cooperation_classification = t2.group_dict_value and t2.group_dict_type=a.cooperation_type
  left join sys_group_dict t3 on a.cooperation_product_cate = t3.group_dict_value and t3.group_dict_type = a.cooperation_classification
 where a.company_id=%Default_Company_ID%
   AND A.user_id=:user_id*/', null, null, '--czh 修改
DECLARE
  v_dpflag NUMBER;
BEGIN
  SELECT COUNT(1)
    INTO v_dpflag
    FROM scmdata.sys_company_user_cate_map dp
   WHERE dp.company_id = :company_id
     AND dp.cooperation_type = :cooperation_type
     AND dp.cooperation_classification = :cooperation_classification
     AND dp.user_id = :user_id;

  IF v_dpflag > 0 THEN
    raise_application_error(-20002, ''人员-分部映射已配置，请勿重复操作！'');
  ELSE
    INSERT INTO sys_company_user_cate_map
      (user_cate_map_id,
       user_cate_map_code,
       user_id,
       company_id,
       cooperation_type,
       cooperation_classification,
       pause,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (f_get_uuid(),
       pkg_plat_comm.f_getkeycode(''SYS_COMPANY_USER_CATE_MAP'',
                                  ''USER_CATE_MAP_CODE'',
                                  %default_company_id%,
                                  ''UCM'',
                                  8),
       :user_id,
       %default_company_id%,
       :cooperation_type,
       :cooperation_classification,
       0,
       %current_userid%,
       SYSDATE,
       %current_userid%,
       SYSDATE);
  END IF;
END;

/*
--czh 修改
DECLARE
  v_dpflag NUMBER;
BEGIN
  SELECT COUNT(1)
    INTO v_dpflag
    FROM scmdata.sys_company_data_priv dp
   WHERE dp.company_id = :company_id
     AND dp.cooperation_type = :cooperation_type
     AND dp.cooperation_classification = :cooperation_classification
     AND dp.user_id = :user_id;

  IF v_dpflag > 0 THEN
    raise_application_error(-20002,
                            ''新增合作分类的数据权限已配置，请勿重复操作！'');
  ELSE
    INSERT INTO sys_company_data_priv
      (data_priv_id,
       data_priv_code,
       user_id,
       company_id,
       cooperation_type,
       cooperation_classification,
       cooperation_product_cate,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (f_get_uuid(),
       pkg_plat_comm.f_getkeycode(''SYS_COMPANY_DATA_PRIV'',
                                  ''DATA_PRIV_CODE'',
                                  %default_company_id%,
                                  ''DPV'',
                                  8),
       :user_id,
       %default_company_id%,
       :cooperation_type,
       :cooperation_classification,
       :cooperation_product_cate,
       %current_userid%,
       sysdate,
       %current_userid%,
       sysdate);
  END IF;
END;
*/

--原sql
/*insert into sys_company_data_priv(data_priv_id,data_priv_code,user_id,company_id,cooperation_type,cooperation_classification,cooperation_product_cate,
                                  create_id,update_id)
    values(f_get_uuid(),pkg_plat_comm.f_getkeycode(''SYS_COMPANY_DATA_PRIV'',''DATA_PRIV_CODE'',%DEFAULT_COMPANY_ID%,''DPV'',8),:user_id,%default_company_id%,:cooperation_type,:cooperation_classification,:cooperation_product_cate,
                                  %Current_userid%,%Current_userid%)*/', 'UPDATE sys_company_user_cate_map a
   SET a.cooperation_type           = :cooperation_type,
       a.cooperation_classification = :cooperation_classification,
       a.update_id                  = %current_userid%,
       a.update_time                = SYSDATE,
       a.pause                      = :pause
 WHERE a.user_cate_map_id = :user_cate_map_id', 'DELETE FROM sys_company_user_cate_map WHERE user_cate_map_id = :user_cate_map_id', 'user_cate_map_id,user_cate_map_code,company_id,cooperation_type,cooperation_classification,cooperation_product_cate,PRODUCTION_CATEGORY_DESC,pause', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('c_2076', 12, null, null, null, null, 'SELECT a.dept_cate_map_id,
       a.dept_cate_map_code,
       a.company_id,
       a.cooperation_type,
       a.cooperation_classification,
       t1.group_dict_name           coop_type_desc,
       t2.group_dict_name           coop_classification_desc,
       a.pause,
       b.company_user_name          creator,
       a.create_time,
       c.company_user_name          updator,
       a.update_time
  FROM sys_company_dept_cate_map a
  LEFT JOIN sys_company_user b
    ON a.create_id = b.user_id
   AND a.company_id = b.company_id
  LEFT JOIN sys_company_user c
    ON a.update_id = c.user_id
   AND a.company_id = c.company_id
  LEFT JOIN sys_group_dict t1
    ON a.cooperation_type = t1.group_dict_value
   AND t1.group_dict_type = ''COOPERATION_TYPE''
  LEFT JOIN sys_group_dict t2
    ON a.cooperation_classification = t2.group_dict_value
   AND t2.group_dict_type = a.cooperation_type
 WHERE a.company_id = %default_company_id%
   AND a.company_dept_id = :company_dept_id', null, null, 'DECLARE
  v_dflag  NUMBER;
  v_dpflag NUMBER;
BEGIN
  SELECT COUNT(1)
    INTO v_dflag
    FROM scmdata.sys_company_dept_cate_map dp
   WHERE dp.company_id = :company_id
     AND dp.company_dept_id = :company_dept_id
     AND dp.cooperation_type = :cooperation_type
     AND dp.cooperation_classification = :cooperation_classification;

  IF v_dflag > 0 THEN
    raise_application_error(-20002, ''部门-分部映射已配置，请勿重复操作！'');
  ELSE
    INSERT INTO sys_company_dept_cate_map
      (dept_cate_map_id,
       dept_cate_map_code,
       company_id,
       company_dept_id,
       cooperation_type,
       cooperation_classification,
       pause,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (f_get_uuid(),
       pkg_plat_comm.f_getkeycode(''SYS_COMPANY_DEPT_CATE_MAP'',
                                  ''DEPT_CATE_MAP_CODE'',
                                  %default_company_id%,
                                  ''DCM'',
                                  8),
       :company_id,
       :company_dept_id,
       :cooperation_type,
       :cooperation_classification,
       0,
       :user_id,
       SYSDATE,
       :user_id,
       SYSDATE);
  
    FOR user_rec IN (SELECT t.user_id, t.company_id
                       FROM scmdata.sys_company_dept dt
                      INNER JOIN scmdata.sys_company_user_dept t
                         ON dt.company_id = t.company_id
                        AND dt.company_dept_id = t.company_dept_id
                      WHERE dt.company_id = :company_id
                        AND dt.company_dept_id = :company_dept_id) LOOP
      SELECT COUNT(1)
        INTO v_dpflag
        FROM scmdata.sys_company_user_cate_map dp
       WHERE dp.company_id = :company_id
         AND dp.cooperation_type = :cooperation_type
         AND dp.cooperation_classification = :cooperation_classification
         AND dp.user_id = user_rec.user_id;
    
      IF v_dpflag > 0 THEN
        NULL;
      ELSE
        INSERT INTO sys_company_user_cate_map
          (user_cate_map_id,
           user_cate_map_code,
           user_id,
           company_id,
           cooperation_type,
           cooperation_classification,
           pause,
           create_id,
           create_time,
           update_id,
           update_time)
        VALUES
          (f_get_uuid(),
           pkg_plat_comm.f_getkeycode(''SYS_COMPANY_USER_CATE_MAP'',
                                      ''USER_CATE_MAP_CODE'',
                                      %default_company_id%,
                                      ''UCM'',
                                      8),
           user_rec.user_id,
           user_rec.company_id,
           :cooperation_type,
           :cooperation_classification,
           0,
           %current_userid%,
           SYSDATE,
           %current_userid%,
           SYSDATE);
      END IF;
    END LOOP;
  
  END IF;

END;


/*
DECLARE
  v_dflag  NUMBER;
  v_dpflag NUMBER;
BEGIN
  SELECT COUNT(1)
    INTO v_dflag
    FROM scmdata.sys_company_dept_data_priv dp
   WHERE dp.company_id = :company_id
     AND dp.company_dept_id = :company_dept_id
     AND dp.cooperation_type = :cooperation_type
     AND dp.cooperation_classification = :cooperation_classification;

  IF v_dflag > 0 THEN
    raise_application_error(-20002,
                            ''新增合作分类的数据权限已配置，请勿重复操作！'');
  ELSE
    INSERT INTO sys_company_dept_data_priv
      (dept_data_priv_id,
       dept_data_priv_code,
       company_id,
       company_dept_id,
       cooperation_type,
       cooperation_classification,
       pause,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (f_get_uuid(),
       pkg_plat_comm.f_getkeycode(''SYS_COMPANY_DEPT_DATA_PRIV'',
                                  ''DEPT_DATA_PRIV_CODE'',
                                  %default_company_id%,
                                  ''DDPV'',
                                  8),
       :company_id,
       :company_dept_id,
       :cooperation_type,
       :cooperation_classification,
       :pause,
       :user_id,
       SYSDATE,
       :user_id,
       SYSDATE);

    FOR user_rec IN (SELECT t.user_id, t.company_id
                       FROM scmdata.sys_company_dept dt
                      INNER JOIN scmdata.sys_company_user_dept t
                         ON dt.company_id = t.company_id
                        AND dt.company_dept_id = t.company_dept_id
                      WHERE dt.company_id = :company_id
                        AND dt.company_dept_id = :company_dept_id) LOOP
      SELECT COUNT(1)
        INTO v_dpflag
        FROM scmdata.sys_company_data_priv dp
       WHERE dp.company_id = :company_id
         AND dp.cooperation_type = :cooperation_type
         AND dp.cooperation_classification = :cooperation_classification
         AND dp.user_id = user_rec.user_id;

      IF v_dpflag > 0 THEN
        NULL;
      ELSE
        INSERT INTO sys_company_data_priv
          (data_priv_id,
           data_priv_code,
           user_id,
           company_id,
           cooperation_type,
           cooperation_classification,
           cooperation_product_cate,
           create_id,
           create_time,
           update_id,
           update_time)
        VALUES
          (f_get_uuid(),
           pkg_plat_comm.f_getkeycode(''SYS_COMPANY_DATA_PRIV'',
                                      ''DATA_PRIV_CODE'',
                                      %default_company_id%,
                                      ''DPV'',
                                      8),
           user_rec.user_id,
           user_rec.company_id,
           :cooperation_type,
           :cooperation_classification,
           NULL,
           %current_userid%,
           sysdate,
           %current_userid%,
           sysdate);
      END IF;
    END LOOP;

  END IF;

END;*/', null, 'DECLARE
BEGIN
  FOR user_rec IN (SELECT t.user_id,
                          t.company_id,
                          dp.cooperation_type,
                          dp.cooperation_classification
                     FROM scmdata.sys_company_dept dt
                    INNER JOIN scmdata.sys_company_user_dept t
                       ON dt.company_id = t.company_id
                      AND dt.company_dept_id = t.company_dept_id
                    INNER JOIN scmdata.sys_company_dept_cate_map dp
                       ON dt.company_id = dp.company_id
                      AND dt.company_dept_id = dp.company_dept_id
                    WHERE dt.company_id = %default_company_id%
                      AND dt.company_dept_id = :company_dept_id
                      AND dp.cooperation_type = :cooperation_type
                      AND dp.cooperation_classification = :cooperation_classification) LOOP
  
    DELETE FROM sys_company_user_cate_map dp1
     WHERE dp1.company_id = user_rec.company_id
       AND dp1.user_id = user_rec.user_id
       AND dp1.cooperation_type = user_rec.cooperation_type
       AND dp1.cooperation_classification =
           user_rec.cooperation_classification;
  
  END LOOP;

  DELETE FROM scmdata.sys_company_dept_cate_map dp
   WHERE dp.dept_cate_map_id  = :dept_cate_map_id ;
END;

/*
DECLARE
BEGIN
  FOR user_rec IN (SELECT t.user_id,
                          t.company_id,
                          dp.cooperation_type,
                          dp.cooperation_classification
                     FROM scmdata.sys_company_dept dt
                    INNER JOIN scmdata.sys_company_user_dept t
                       ON dt.company_id = t.company_id
                      AND dt.company_dept_id = t.company_dept_id
                    INNER JOIN scmdata.sys_company_dept_data_priv dp
                       ON dt.company_id = dp.company_id
                      AND dt.company_dept_id = dp.company_dept_id
                    WHERE dt.company_id = %default_company_id%
                      AND dt.company_dept_id = :company_dept_id
                      AND dp.cooperation_type = :cooperation_type
                      AND dp.cooperation_classification = :cooperation_classification) LOOP
  
    DELETE FROM sys_company_data_priv dp1
     WHERE dp1.company_id = user_rec.company_id
       AND dp1.user_id = user_rec.user_id
       AND dp1.cooperation_type = user_rec.cooperation_type
       AND dp1.cooperation_classification =
           user_rec.cooperation_classification;
  
  END LOOP;

  DELETE FROM scmdata.sys_company_dept_data_priv dp
   WHERE dp.dept_data_priv_id = :dept_data_priv_id;
END;*/', 'dept_cate_map_id,dept_cate_map_code,company_id,cooperation_type,cooperation_classification,pause', null, null, null, null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, null);

end;
