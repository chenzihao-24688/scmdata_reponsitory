--ϵͳ��Ϣ����
SELECT * FROM scmdata.sys_group_msg_config;
SELECT * FROM scmdata.sys_company_msg_config;
select * from nbw.sys_hint;

select * from nbw.msg_info;
select * from nbw.msg_log lg;
select * from nbw.msg_log_detail;
select * from nbw.msg_log_backup;
select * from nbw.msg_log_detail_backup;
--ɾ����Ϣlog
DECLARE
BEGIN
  DELETE FROM nbw.msg_log_detail ld
   WHERE ld.log_id IN
         (SELECT lg.log_id
            FROM nbw.msg_log lg
           WHERE lg.object_type = 'SYSTEM_NOTICE'
              OR (lg.object_type = 'hint' AND
                 instr(lg.sender, 'ϵͳ#sys_hint_') > 0));
                 
  DELETE FROM nbw.msg_log lg
   WHERE lg.object_type = 'SYSTEM_NOTICE'
      OR (lg.object_type = 'hint' AND instr(lg.sender, 'ϵͳ#sys_hint_') > 0);

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


SELECT '����' || COUNT(1) || '������˵��ݣ���ǰ������'
  FROM scmdata.t_abnormal abn
 INNER JOIN scmdata.sys_company_user t
    ON abn.company_id = t.company_id
   AND abn.progress_status = '00'
 WHERE t.company_id = %default_company_id%
   AND t.user_id = %user_id%;
   
select t.*,rowid from nbw.sys_config t where t.app_id='app_sanfu_retail' and t.set_name='free_login_mode';

--2.ms_info ƽ̨����ȱ������ҵid���ƣ���ֻ���߶�ʱ
select rowid,t.* from nbw.Msg_info t; --��Ϣ��Ϣ��

select * from nbw.Msg_log; --��Ϣ��־��

select * from nbw.Msg_log_detail; --��Ϣ��־�����

select * from nbw.msg_user_online;

--3.��ťaction


----------------------------------------------------------------------------------------


--SYS_GROUP_MSG_CONFIG
--SYS_COMPANY_MSG_CONFIG
/*P_MSG_CONTENT :��Ϣ����
* P_MSG_TITLE :��Ϣ���⣬����Ĭ�ϡ��ޱ��⡮
* P_TARGET_USER :��ȡ�û���Ϊ��ʱΪȺ������Ϊ�����ǵ���
                  ע���ò��������ԡ�HX87,CMS3'����'HX87'����ʽ������У��ܾ�����ʽ���������
* P_SENDER_NAME :���������ƣ�����������д������Ĭ�ϡ�system��
* P_APP_ID :appid��������Ĭ�ϡ�scm��
* P_MSG_TYPE :  ��Ϣ���ͣ�S��System������ϵͳ��Ϣ����ɫ����ͼ�ꡢû�С�����������ť��
                           T��Todo������hint��Ϣ����ɫ����ͼ�ꡢ�С�����������ť��
                           ע������У��ܾ��������������������
* P_OBJECT_ID :����hint��Ϣʱ��Ҫ��Ϊ��������ť��ת����node_id*/

SELECT gm.group_msg_name,
       gm.config_type,
       gm.config_id,
       mf.title, --��Ϣ���� 
       mf.urgent, --0��������Ϣ 1���ǽ�����Ϣ 
       mf.sender, --������ 
       mf.send_type, --0:Ⱥ�� 1:����            
       mf.receivers, --���н��յĶ���userids(sql��䣩       
       mf.message_info, --��Ϣ����       
       mf.send_state, --����״̬ 0:ȫ���ɹ�  1:ȫ��ʧ��  2:���ֳɹ�  
       mf.object_id, --����id  ����hint��Ϣʱ��Ҫ��Ϊ��������ť��ת����node_id
       mf.app_id
  FROM sys_group_msg_config gm
 INNER JOIN nbw.msg_info mf
    ON gm.config_id = mf.msg_id;

SELECT gm.group_msg_name,
       gm.config_type,
       gm.config_id,
       lg.title, --��Ϣ���� 
       lg.urgent, --0��������Ϣ 1���ǽ�����Ϣ 
       lg.sender, --������ 
       lg.send_type, --0:Ⱥ�� 1:����            
       ld.receiver, --���н��յĶ���userids(sql��䣩       
       lg.msg_info message_info, --��Ϣ����       
       lg.send_state, --����״̬ 0:ȫ���ɹ�  1:ȫ��ʧ��  2:���ֳɹ�  
       lg.send_time,
       ld.read_state,
       ld.read_time,
       lg.fail_receiver
  FROM nbw.msg_log lg
 INNER JOIN nbw.msg_log_detail ld
    ON lg.log_id = ld.log_id
 INNER JOIN sys_group_msg_config gm
    ON ld.msg_id = gm.config_id;

SELECT * FROM nbw.msg_log; --��Ϣ��־��

SELECT * FROM nbw.msg_log_detail;

