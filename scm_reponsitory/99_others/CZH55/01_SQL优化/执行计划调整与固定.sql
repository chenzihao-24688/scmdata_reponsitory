--һ������SQL Profile�Զ���������
/*1��mSqlText�����Ż���SQL��������Ҫע�ⵥ���ŵ�ת��д��������SQLĩβ�����зֺ�

2��user_name����ǰ���ݿ��¼�û���

3��task_name����ǰ�Ż����������*/

DECLARE
  mtaskname VARCHAR2(30);
  msqltext  CLOB;
BEGIN
  msqltext := q'[SELECT u.user_id,
       u.pause,
       (SELECT listagg(gr.group_role_name, ';') within GROUP(ORDER BY gr.create_time)
          FROM scmdata.sys_group_user_role ur, scmdata.sys_group_role gr
         WHERE u.user_id = ur.user_id
           AND ur.group_role_id = gr.group_role_id) group_role_name_desc,
       u.avatar,
       u.nick_name,
       u.user_account,
       (SELECT listagg(b.logn_name, ';') within GROUP(ORDER BY 1)
          FROM scmdata.sys_user_company a
          LEFT JOIN scmdata.sys_company b
            ON a.company_id = b.company_id
         WHERE a.user_id = u.user_id
           AND b.pause = 0) user_logn_name, --add by czh
       dp.province || dc.city || dy.county city,
       u.sex,
       u.birthday,
       u.create_time create_time
  FROM scmdata.sys_user u
  LEFT JOIN scmdata.dic_province dp
    ON u.province = dp.provinceid
  LEFT JOIN scmdata.dic_city dc
    ON u.province = dc.provinceid
   AND u.city = dc.cityno
  LEFT JOIN scmdata.dic_county dy
    ON u.city = dy.cityno
   AND u.county = dy.countyid
 ORDER BY u.create_time ASC]';

  mtaskname := dbms_sqltune.create_tuning_task(sql_text    => msqltext,
                                               user_name   => 'SCMDATA',
                                               scope       => 'COMPREHENSIVE',
                                               time_limit  => 60,
                                               task_name   => 't_sys_user_task',
                                               description => 'Task to t_sys_user_task');
END;

--����ִ��sql��������
--1��task_name��ǰһ�������õ��Ż���������
BEGIN
  dbms_sqltune.execute_tuning_task(task_name => 't_sys_user_task');
END;

--�����鿴SQL�Ż�����

--��ѯ��SQL����CLOB���ݼ�Ϊ�Ż����档

SELECT dbms_sqltune.report_tuning_task(task_name => 't_sys_user_task')
  FROM dual;

--�ġ�ɾ���Ż�����

--ͨ����SQL���Բ鿴��ǰ����Щ�Ż�����

SELECT * FROM dba_tune_mview WHERE owner = 'SCMDATA';
--ͨ����ָ��ɾ���Ż�����

BEGIN
  dbms_sqltune.drop_tuning_task(task_name => 't_abnormal_task');
END;

--�塢ͨ����ָ��ɾ���̶���ִ�мƻ���
--��SQLʹ����SQL Profile�����磺sqlplus�鿴ͳ����Ϣ �ҵ�SYS_SQLPROF_0168372e2f030000

BEGIN
  dbms_sqltune.drop_sql_profile(NAME => 'SYS_SQLPROF_0177d8605b120000');
END;
