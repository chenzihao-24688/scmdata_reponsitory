--系统消息配置
SELECT * FROM scmdata.sys_group_msg_config;
SELECT * FROM scmdata.sys_company_msg_config;
select * from nbw.sys_hint;

select * from nbw.msg_info;
select * from nbw.msg_log lg;
select * from nbw.msg_log_detail;
select * from nbw.msg_log_backup;
select * from nbw.msg_log_detail_backup;
--删除消息log
DECLARE
BEGIN
  DELETE FROM nbw.msg_log_detail ld
   WHERE ld.log_id IN
         (SELECT lg.log_id
            FROM nbw.msg_log lg
           WHERE lg.object_type = 'SYSTEM_NOTICE'
              OR (lg.object_type = 'hint' AND
                 instr(lg.sender, '系统#sys_hint_') > 0));
                 
  DELETE FROM nbw.msg_log lg
   WHERE lg.object_type = 'SYSTEM_NOTICE'
      OR (lg.object_type = 'hint' AND instr(lg.sender, '系统#sys_hint_') > 0);

END;
--SYS_GROUP_MSG_CONFIG
--SYS_COMPANY_MSG_CONFIG 
select rowid, t.* from nbw.sys_item t where t.item_id like '%g_530%';
select rowid, t.* from nbw.sys_tree_list t where t.item_id like '%g_530%';
select rowid, t.* from nbw.sys_item_list t where t.item_id like '%g_530%';

select rowid, t.* from nbw.sys_item t where t.item_id like '%c_230%';
select rowid, t.* from nbw.sys_tree_list t where t.item_id like '%c_230%';
select rowid, t.* from nbw.sys_item_list t where t.item_id like '%c_230%';

--1.hint
SELECT ROWID, t.* FROM nbw.sys_hint t where t.hint_id = 'hint_3';
select rowid,t.* from nbw.sys_cond_rela t where t.cond_id = 'cond_hint_3'; --cond_hint_3
select rowid,t.* from nbw.sys_cond_list t where t.cond_id = 'cond_hint_3';


SELECT '您有' || COUNT(1) || '个单审核单据，请前往处理'
  FROM scmdata.t_abnormal abn
 INNER JOIN scmdata.sys_company_user t
    ON abn.company_id = t.company_id
   AND abn.progress_status = '00'
 WHERE t.company_id = %default_company_id%
   AND t.user_id = %user_id%;
   
select t.*,rowid from nbw.sys_config t where t.app_id='app_sanfu_retail' and t.set_name='free_login_mode';

--2.ms_info 平台级，缺点无企业id限制，且只能走定时
select rowid,t.* from nbw.Msg_info t; --消息信息表

select * from nbw.Msg_log; --消息日志表

select * from nbw.Msg_log_detail; --消息日志详情表

select * from nbw.msg_user_online;

--3.按钮action


----------------------------------------------------------------------------------------


--SYS_GROUP_MSG_CONFIG
--SYS_COMPANY_MSG_CONFIG
/*P_MSG_CONTENT :信息内容
* P_MSG_TITLE :信息标题，不填默认’无标题‘
* P_TARGET_USER :获取用户，为空时为群发，不为空则是单发
                  注：该参数必须以‘HX87,CMS3'或者'HX87'的形式，内有校验拒绝此形式以外的输入
* P_SENDER_NAME :发送人名称，按照需求填写，不填默认’system‘
* P_APP_ID :appid，不填则默认’scm‘
* P_MSG_TYPE :  消息类型：S：System，发送系统消息（蓝色警钟图标、没有‘立即处理’按钮）
                           T：Todo，发送hint消息（黄色待办图标、有‘立即处理’按钮）
                           注：内有校验拒绝以上两种类型外的输入
* P_OBJECT_ID :发送hint消息时需要，为立即处理按钮跳转到的node_id*/

SELECT gm.group_msg_name,
       gm.config_type,
       gm.config_id,
       mf.title, --信息标题 
       mf.urgent, --0：紧急消息 1：非紧急消息 
       mf.sender, --发送者 
       mf.send_type, --0:群发 1:单独            
       mf.receivers, --所有接收的对象userids(sql语句）       
       mf.message_info, --消息内容       
       mf.send_state, --发送状态 0:全部成功  1:全部失败  2:部分成功  
       mf.object_id, --对象id  发送hint消息时需要，为立即处理按钮跳转到的node_id
       mf.app_id
  FROM sys_group_msg_config gm
 INNER JOIN nbw.msg_info mf
    ON gm.config_id = mf.msg_id;

SELECT gm.group_msg_name,
       gm.config_type,
       gm.config_id,
       lg.title, --信息标题 
       lg.urgent, --0：紧急消息 1：非紧急消息 
       lg.sender, --发送者 
       lg.send_type, --0:群发 1:单独            
       ld.receiver, --所有接收的对象userids(sql语句）       
       lg.msg_info message_info, --消息内容       
       lg.send_state, --发送状态 0:全部成功  1:全部失败  2:部分成功  
       lg.send_time,
       ld.read_state,
       ld.read_time,
       lg.fail_receiver
  FROM nbw.msg_log lg
 INNER JOIN nbw.msg_log_detail ld
    ON lg.log_id = ld.log_id
 INNER JOIN sys_group_msg_config gm
    ON ld.msg_id = gm.config_id;

SELECT * FROM nbw.msg_log; --消息日志表

SELECT * FROM nbw.msg_log_detail;

