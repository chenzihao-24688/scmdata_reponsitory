declare
begin
insert into bw3.xxl_job_info (ID, APP_ID, JOB_GROUP, JOB_CRON, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID, TRIGGER_STATUS, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (201, 'scm', 202, '0 0/5 * * *  ?', '供应商档案接口导入（获取mdm回传数据）', to_date('16-11-2020 14:31:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('24-05-2021 14:20:14', 'dd-mm-yyyy hh24:mi:ss'), '18172543571', null, 'ROUND', 'actionJobHandler', 'action_a_supp_110_9', 'SERIAL_EXECUTION', 0, 0, 'BEAN', null, null, to_date('24-05-2021 14:20:14', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 1624263900000, 1624264200000);

end;
