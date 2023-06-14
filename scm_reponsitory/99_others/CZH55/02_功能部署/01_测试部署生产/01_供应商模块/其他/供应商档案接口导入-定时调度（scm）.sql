declare
begin

insert into nbw.xxl_job_info (ID, APP_ID, JOB_GROUP, GLUE_TYPE, GLUE_REMARK, JOB_CRON, EXECUTOR_HANDLER, EXECUTOR_PARAM, JOB_DESC, CHILD_JOBID, ADD_TIME, UPDATE_TIME, AUTHOR, TRIGGER_STATUS, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_UPDATETIME, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (xxl_job_info_seq.nextval, 'scm', 202, 'BEAN', null, '0 0/5  * * * ? ', 'actionJobHandler', 'action_a_supp_110_9', '供应商档案接口导入', null, to_date('16-11-2020 14:31:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('14-12-2020 09:31:39', 'dd-mm-yyyy hh24:mi:ss'), '18172543571', 0, null, 'ROUND', 'SERIAL_EXECUTION', 0, 0, to_date('14-12-2020 09:31:39', 'dd-mm-yyyy hh24:mi:ss'), 1607684640000, 1607684700000);

end;