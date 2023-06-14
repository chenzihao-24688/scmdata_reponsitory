alter table scmdata.sys_company_data_priv_group add pause number;
/
begin
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('action_c_2410_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('action_c_2410_2', 'action', 'oracle_scmdata', 0, null, 0, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_c_2410_1', '启用', 'icon-morencaidan', 4, 'DECLARE
BEGIN
  FOR data_rec IN (SELECT t.data_priv_group_id
                     FROM scmdata.sys_company_data_priv_group t
                    WHERE t.data_priv_group_id IN (@selection)) LOOP
  
    pkg_data_privs.update_data_privs_group_status(p_data_priv_group_id => data_rec.data_priv_group_id,
                                                  p_user_id            => :user_id,                     
                                                  p_status             => 1);
  END LOOP;

END;', 'data_priv_group_id', 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_c_2410_2', '停用', 'icon-morencaidan', 4, 'DECLARE
BEGIN
  FOR data_rec IN (SELECT t.data_priv_group_id
                     FROM scmdata.sys_company_data_priv_group t
                    WHERE t.data_priv_group_id IN (@selection)) LOOP
  
    pkg_data_privs.update_data_privs_group_status(p_data_priv_group_id => data_rec.data_priv_group_id,
                                                  p_user_id            => :user_id,
                                                  p_status             => 0);
  END LOOP;

END;', 'data_priv_group_id', 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('c_2410', 'action_c_2410_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('c_2410', 'action_c_2410_2', 1, 0, null);

end;
/
DECLARE
v_sql clob;
BEGIN
v_sql := q'[SELECT pg.data_priv_group_id data_priv_group_id,
         decode(pg.pause, 1, '启用', '停用') pause_desc,
         pg.data_priv_group_code,
         pg.data_priv_group_name,
         pg.company_id,
         pg.user_id,
         (SELECT u.nick_name FROM sys_user u WHERE u.user_id = pg.create_id) create_id,
         pg.create_time,
         (SELECT u.nick_name FROM sys_user u WHERE u.user_id = pg.update_id) update_id,
         pg.update_time
    FROM sys_company_data_priv_group pg
   WHERE pg.company_id = %default_company_id%]';
   
update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'c_2410';
END;
/
declare
v_sql clob;
begin
  v_sql := q'[SELECT pg.data_priv_group_id,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.seq_no
  FROM sys_company_data_priv_group pg
  WHERE pg.company_id = %default_company_id%
  AND pg.pause = 1]';
update bw3.sys_pick_list t set t.pick_sql = v_sql where t.element_id =  'pick_c_2411_1';
end;
/
DECLARE
v_sql clob;
v_sql1 clob;
BEGIN
 v_sql := q'[SELECT pg.data_priv_group_id data_priv_group_id,
       decode(pg.pause, 1, '启用', '停用') pause_desc,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id,
       pm.user_id,
       (SELECT u.nick_name FROM sys_user u WHERE u.user_id = pg.create_id) create_id,
        pg.create_time,
       (SELECT u.nick_name FROM sys_user u WHERE u.user_id = pg.update_id) update_id,
        pg.update_time,
       pm.data_priv_user_middle_id
  FROM sys_company_data_priv_group pg
 INNER JOIN scmdata.sys_company_data_priv_user_middle pm
    ON pg.company_id = pm.company_id
   AND pg.data_priv_group_id = pm.data_priv_group_id
 WHERE pm.company_id = %default_company_id%
   AND pm.user_id = :user_id]';
   
 v_sql1 := q'[SELECT pg.data_priv_group_id,
       decode(pg.pause, 1, '启用', '停用') pause_desc,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.company_id,
       (SELECT u.nick_name FROM sys_user u WHERE u.user_id = pg.create_id) create_id,
        pg.create_time,
       (SELECT u.nick_name FROM sys_user u WHERE u.user_id = pg.update_id) update_id,
        pg.update_time,
       pm.data_priv_dept_middle_id
  FROM sys_company_data_priv_group pg
 INNER JOIN scmdata.sys_company_data_priv_dept_middle pm
    ON pg.company_id = pm.company_id
   AND pg.data_priv_group_id = pm.data_priv_group_id
 WHERE pm.company_id = %default_company_id%
   AND pm.company_dept_id = :company_dept_id]';
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'c_2412';
  update bw3.sys_item_list t set t.select_sql = v_sql1 where t.item_id = 'c_2413';
END;
/
DECLARE
v_sql clob;
BEGIN
v_sql :=  q'[SELECT dp.data_priv_id,
       decode(dp.pause,1,'启用',0,'停用') pause_desc,
       dp.data_priv_code,
       dp.data_priv_name
  FROM sys_data_privs dp
 ORDER BY dp.level_type ASC, dp.seq_no ASC]';
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'c_2420';
 
END;
