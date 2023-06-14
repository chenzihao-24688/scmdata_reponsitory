DELETE FROM scmdata.sys_group_msg_config;
DELETE FROM scmdata.sys_company_msg_config;
DELETE FROM bw3.sys_hint;

DELETE FROM bw3.msg_info;
DELETE FROM bw3.msg_log lg;
DELETE FROM bw3.msg_log_detail;
DELETE FROM bw3.msg_log_backup;
DELETE FROM bw3.msg_log_detail_backup;

--清空按钮配置的消息
DECLARE
BEGIN
  DELETE FROM bw3.msg_info;
  DELETE FROM bw3.msg_log lg;
  DELETE FROM bw3.msg_log_detail;

  DELETE FROM bw3.sys_hint ht
   WHERE ht.hint_id IN (SELECT t.config_id
                          FROM scmdata.sys_group_msg_config t
                         WHERE t.config_type = 'SYS_HINT');

  DELETE FROM scmdata.sys_company_msg_config mc
   WHERE mc.group_msg_id IN
         (SELECT t.group_msg_id
            FROM scmdata.sys_group_msg_config t
           WHERE t.config_type = 'SYS_HINT');

  DELETE FROM scmdata.sys_group_msg_config t
   WHERE t.config_type = 'SYS_HINT';
END;
SELECT ROWID, t.* FROM scmdata.sys_group_msg_config t;
SELECT ROWID, t.* FROM scmdata.sys_company_msg_config t;
SELECT ROWID, t.* FROM bw3.sys_hint t;
SELECT ROWID, t.* FROM bw3.msg_info t;
SELECT ROWID, t.* FROM bw3.msg_log t;
SELECT ROWID, t.* FROM bw3.msg_log_detail t;
SELECT ROWID, t.* FROM bw3.msg_log_backup t ;
SELECT ROWID, t.* FROM bw3.msg_log_detail_backup t;


--按钮配置消息
select rowid,t.* from bw3.sys_action t where t.element_id = 'action_a_coop_121';  --action_a_coop_130

select rowid,t.* from bw3.sys_action t where t.element_id = 'action_a_coop_130'; --action_a_coop_313

select rowid,t.* from bw3.sys_action t where t.element_id = 'action_a_coop_220_3'; --action_a_coop_220_1

select rowid,t.* from bw3.sys_action t where t.element_id = 'action_a_coop_220_1';--action_a_coop_220_2

select rowid,t.* from bw3.sys_action t where t.element_id = 'action_a_coop_220_2'; --ac_a_check_101_3

select rowid,t.* from bw3.sys_action t where t.element_id = 'action_a_coop_313'; --action_a_coop_220_3

select rowid,t.* from bw3.sys_action t where t.element_id = 'ac_a_check_101_3'; 
