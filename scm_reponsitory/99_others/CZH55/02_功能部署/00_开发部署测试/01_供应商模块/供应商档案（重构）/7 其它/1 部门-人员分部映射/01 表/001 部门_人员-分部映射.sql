declare
v_select_sql clob;
v_insert_sql clob;
v_update_sql clob;
v_delete_sql clob;
v_noshow_fields clob;
v_select_sql1 clob;
v_insert_sql1 clob;
v_update_sql1 clob;
v_delete_sql1 clob;
v_noshow_fields1 clob;
begin
  --1.sys_item
  update bw3.sys_item t set t.caption_sql = '人员-分部映射',t.base_table = 'sys_company_user_cate_map' ,t.name_field = 'user_cate_map_id' where t.item_id = 'c_2058';
  update bw3.sys_item t set t.caption_sql = '部门-分部映射',t.base_table = 'sys_company_dept_cate_map' ,t.name_field = 'user_cate_map_id' where t.item_id = 'c_2076';
  --2.sys_item_list
  --c_2058
  v_select_sql := 'SELECT a.user_cate_map_id,
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
   AND a.user_id = :user_id';
   
   v_insert_sql := '--czh 修改
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
END;';
v_update_sql := 'UPDATE sys_company_user_cate_map a
   SET a.cooperation_type           = :cooperation_type,
       a.cooperation_classification = :cooperation_classification,
       a.update_id                  = %current_userid%,
       a.update_time                = SYSDATE,
       a.pause                      = :pause
 WHERE a.user_cate_map_id = :user_cate_map_id';
 
v_delete_sql := 'DELETE FROM sys_company_user_cate_map WHERE user_cate_map_id = :user_cate_map_id';

v_noshow_fields := 'user_cate_map_id,user_cate_map_code,company_id,cooperation_type,cooperation_classification,cooperation_product_cate,PRODUCTION_CATEGORY_DESC,pause';

update bw3.sys_item_list t set t.select_sql = v_select_sql,t.insert_sql = v_insert_sql, t.update_sql = v_update_sql, t.delete_sql = v_delete_sql, t.noshow_fields = v_noshow_fields where t.item_id = 'c_2058';
--c_2076
 v_select_sql1 := 'SELECT a.dept_cate_map_id,
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
   AND a.company_dept_id = :company_dept_id';
   
   v_insert_sql1 := 'DECLARE
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

END;';
 
v_delete_sql1 := 'DECLARE
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
END;';

v_noshow_fields1 := 'dept_cate_map_id,dept_cate_map_code,company_id,cooperation_type,cooperation_classification,pause';

update bw3.sys_item_list t set t.select_sql = v_select_sql1,t.insert_sql = v_insert_sql1, t.delete_sql = v_delete_sql1, t.noshow_fields = v_noshow_fields1 where t.item_id = 'c_2076';

end;
