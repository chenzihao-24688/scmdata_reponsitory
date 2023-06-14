DECLARE
v_sql clob;
v_sql1 clob;
BEGIN
  v_sql := 'SELECT dp.data_priv_id,
       dp.pause pause_desc,
       dp.data_priv_code,
       dp.data_priv_name,
       dp.seq_no,
       dp.level_type,
       dp.fields_config_method,
       (select u.nick_name from sys_user u where u.user_id = dp.create_id) create_id,
       dp.create_time,
       (select u.nick_name from sys_user u where u.user_id = dp.update_id) update_id,
       dp.update_time
  FROM sys_data_privs dp 
 ORDER BY dp.level_type ASC, dp.seq_no ASC';
 
 v_sql1 := 'SELECT pg.data_priv_group_id DATA_PRIV_GROUP_ID,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id,
       pg.user_id,
       (select u.nick_name from sys_user u where u.user_id = pg.create_id) create_id,
       pg.create_time,
       (select u.nick_name from sys_user u where u.user_id = pg.update_id) update_id,
       pg.update_time
  FROM sys_company_data_priv_group pg
  WHERE pg.company_id = %default_company_id%';
 
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql WHERE t.item_id = 'g_560';
  
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql1 WHERE t.item_id = 'c_2410';

END;
/
BEGIN
  update bw3.sys_item_list t set t.noshow_fields = 'data_priv_field_id,company_id,data_priv_id,col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8,col_9,col_10,col_11,col_21,col_22,data_priv_pick_field_id,data_priv_lookup_field_id,data_priv_date_field_id' where t.item_id = 'c_2431';
  
  insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('COMPANY_STORE_TYPE_DESC', '仓库', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null);

END;
/
DECLARE
  v_sql  CLOB;
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql3 CLOB;
  v_sql4 CLOB;
BEGIN
  v_sql := 'SELECT dp.data_priv_id,
       decode(dp.pause,1,''启用'',0,''停用'') pause_desc,
       dp.data_priv_code,
       dp.data_priv_name
  FROM sys_data_privs dp
 ORDER BY dp.level_type ASC, dp.seq_no ASC';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql
   WHERE t.item_id = 'g_560';

  v_sql1 := 'SELECT dp.data_priv_id,
       decode(dp.pause,1,''启用'',0,''停用'') pause_desc,
       dp.data_priv_code,
       dp.data_priv_name,
       pm.data_priv_middle_id
  FROM scmdata.sys_data_privs dp
 INNER JOIN scmdata.sys_company_data_priv_middle pm
    ON dp.data_priv_id = pm.data_priv_id
   AND pm.data_priv_group_id = :data_priv_group_id
 WHERE pm.company_id = %default_company_id%
 ORDER BY dp.level_type ASC, dp.seq_no ASC';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql1
   WHERE t.item_id = 'c_2421';

  v_sql2 := 'SELECT pg.data_priv_group_id data_priv_group_id,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id,
       pm.user_id,
       pm.data_priv_user_middle_id
  FROM sys_company_data_priv_group pg
 INNER JOIN scmdata.sys_company_data_priv_user_middle pm
    ON pg.company_id = pm.company_id
   AND pg.data_priv_group_id = pm.data_priv_group_id
 WHERE pm.company_id = %default_company_id%
   AND pm.user_id = :user_id';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql2
   WHERE t.item_id = 'c_2412';

  v_sql3 := 'SELECT pg.data_priv_group_id,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id, 
       pm.data_priv_dept_middle_id
  FROM sys_company_data_priv_group pg
 INNER JOIN scmdata.sys_company_data_priv_dept_middle pm
    ON pg.company_id = pm.company_id
   AND pg.data_priv_group_id = pm.data_priv_group_id
 WHERE pm.company_id = %default_company_id%
   AND pm.company_dept_id = :company_dept_id';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql3
   WHERE t.item_id = 'c_2413';

v_sql4 :='SELECT dp.data_priv_id,
       decode(dp.pause,1,''启用'',0,''停用'') pause_desc,
       dp.data_priv_code,
       dp.data_priv_name
  FROM sys_data_privs dp
 ORDER BY dp.level_type ASC, dp.seq_no ASC';
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql4
   WHERE t.item_id = 'c_2420';
END;


