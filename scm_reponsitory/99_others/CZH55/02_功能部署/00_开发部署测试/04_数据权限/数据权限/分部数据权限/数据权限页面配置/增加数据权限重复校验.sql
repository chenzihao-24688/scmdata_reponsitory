DECLARE
v_str1 clob;
v_str2 clob;
v_str3 clob;
v_str4 clob;
BEGIN
v_str1 := q'[DATA_PRIV_ID,DATA_PRIV_CODE,COMPANY_ID,cooperation_type,cooperation_classification,cooperation_product_cate,PRODUCTION_CATEGORY_DESC,pause]';
v_str2 :=q'[--czh 修改
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
                            '新增合作分类的数据权限已配置，请勿重复操作！');
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
       update_id)
    VALUES
      (f_get_uuid(),
       pkg_plat_comm.f_getkeycode('SYS_COMPANY_DATA_PRIV',
                                  'DATA_PRIV_CODE',
                                  %default_company_id%,
                                  'DPV',
                                  8),
       :user_id,
       %default_company_id%,
       :cooperation_type,
       :cooperation_classification,
       :cooperation_product_cate,
       %current_userid%,
       %current_userid%);
  END IF;
END;


--原sql
/*insert into sys_company_data_priv(data_priv_id,data_priv_code,user_id,company_id,cooperation_type,cooperation_classification,cooperation_product_cate,
                                  create_id,update_id)
    values(f_get_uuid(),pkg_plat_comm.f_getkeycode('SYS_COMPANY_DATA_PRIV','DATA_PRIV_CODE',%DEFAULT_COMPANY_ID%,'DPV',8),:user_id,%default_company_id%,:cooperation_type,:cooperation_classification,:cooperation_product_cate,
                                  %Current_userid%,%Current_userid%)*/]';

v_str3 := q'[DECLARE
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
                            '新增合作分类的数据权限已配置，请勿重复操作！');
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
       pkg_plat_comm.f_getkeycode('SYS_COMPANY_DEPT_DATA_PRIV',
                                  'DEPT_DATA_PRIV_CODE',
                                  %default_company_id%,
                                  'DDPV',
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
           update_id)
        VALUES
          (f_get_uuid(),
           pkg_plat_comm.f_getkeycode('SYS_COMPANY_DATA_PRIV',
                                      'DATA_PRIV_CODE',
                                      %default_company_id%,
                                      'DPV',
                                      8),
           user_rec.user_id,
           user_rec.company_id,
           :cooperation_type,
           :cooperation_classification,
           NULL,
           %current_userid%,
           %current_userid%);
      END IF;
    END LOOP;
  
  END IF;

END;]';

update bw3.sys_item_list t set t.noshow_fields = v_str1,t.insert_sql = v_str2 WHERE t.item_id = 'c_2058';

update bw3.sys_item_list t set t.insert_sql = v_str3 WHERE t.item_id = 'c_2076';

END;

