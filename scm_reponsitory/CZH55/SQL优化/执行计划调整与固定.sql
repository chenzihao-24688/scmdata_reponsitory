--一、创建SQL Profile自动调整任务
/*1、mSqlText：待优化的SQL，这里需要注意单引号的转义写法，并且SQL末尾不能有分号

2、user_name：当前数据库登录用户名

3、task_name：当前优化任务的名称*/

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

--二、执行sql调整任务
--1、task_name：前一步创建好的优化任务名称
BEGIN
  dbms_sqltune.execute_tuning_task(task_name => 't_sys_user_task');
END;

--三、查看SQL优化报告

--查询该SQL，打开CLOB内容即为优化报告。

SELECT dbms_sqltune.report_tuning_task(task_name => 't_sys_user_task')
  FROM dual;

--四、删除优化任务

--通过该SQL可以查看当前有哪些优化任务：

SELECT * FROM dba_tune_mview WHERE owner = 'SCMDATA';
--通过该指令删除优化任务：

BEGIN
  dbms_sqltune.drop_tuning_task(task_name => 't_abnormal_task');
END;

--五、通过该指令删除固定的执行计划：
--该SQL使用了SQL Profile，例如：sqlplus查看统计信息 找到SYS_SQLPROF_0168372e2f030000

BEGIN
  dbms_sqltune.drop_sql_profile(NAME => 'SYS_SQLPROF_0177d8605b120000');
END;
