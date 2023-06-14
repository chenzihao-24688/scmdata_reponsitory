DECLARE
  v_sql  CLOB;
  v_sql1 CLOB;
BEGIN
  v_sql := 'SELECT dp.data_priv_id,
       dp.pause pause_desc,
       dp.data_priv_code,
       dp.data_priv_name,
       dp.create_id,
       dp.create_time,
       dp.update_id,
       dp.update_time
  FROM sys_data_privs dp
 ORDER BY dp.level_type ASC, dp.seq_no ASC';

  v_sql1 := 'SELECT dp.data_priv_id,
       dp.pause pause_desc,
       dp.data_priv_code,
       dp.data_priv_name,
       pm.data_priv_middle_id
  FROM scmdata.sys_data_privs dp
 INNER JOIN scmdata.sys_company_data_priv_middle pm
    ON dp.data_priv_id = pm.data_priv_id
   AND pm.data_priv_group_id = :data_priv_group_id
 WHERE pm.company_id = %default_company_id%
 ORDER BY dp.level_type ASC, dp.seq_no ASC
';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql
   WHERE t.item_id = 'c_2420';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql1
   WHERE t.item_id = 'c_2421';

  UPDATE bw3.sys_item_list t
     SET t.noshow_fields = 'company_id,user_id,data_priv_group_id'
   WHERE t.item_id = 'c_2410';

  UPDATE bw3.sys_item_list t
     SET t.noshow_fields = 'data_priv_field_id,company_id,data_priv_id,col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8,data_priv_pick_field_id,data_priv_lookup_field_id,data_priv_date_field_id'
   WHERE t.item_id = 'c_2431';
 
END;

/
DECLARE
v_sql clob;
BEGIN
  v_sql := q'[SELECT dp.data_priv_id,
       dp.data_priv_code,
       dp.data_priv_name,
       dp.seq_no,
       decode(dp.level_type,'CLASS_TYPE','·Ö²¿','COMPANY_STORE_TYPE','²Ö¿â','') level_type,
       dp.fields_config_method
  FROM sys_data_privs dp 
  WHERE dp.pause = 1
 ORDER BY dp.level_type ASC, dp.seq_no ASC]';
  update bw3.sys_pick_list t set t.pick_sql = v_sql  where t.element_id = 'pick_c_2421_1';
END;
