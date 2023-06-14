declare
begin

insert into bwptest1.xxl_job_info (ID, APP_ID, JOB_GROUP, GLUE_TYPE, GLUE_REMARK, JOB_CRON, EXECUTOR_HANDLER, EXECUTOR_PARAM, JOB_DESC, CHILD_JOBID, ADD_TIME, UPDATE_TIME, AUTHOR, TRIGGER_STATUS, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_UPDATETIME, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (xxl_job_info_seq.nextval, 'app_sanfu_retail', 1, 'BEAN', null, '0 0/5  * * * ?', 'actionJobHandler', 'action_itf_a_supp_140', '供应商档案接口导入', null, to_date('26-10-2020', 'dd-mm-yyyy'), to_date('26-10-2020', 'dd-mm-yyyy'), 'HX87', 0, null, 'ROUND', 'SERIAL_EXECUTION', 0, 0, to_date('26-10-2020', 'dd-mm-yyyy'), 1607909580000, 1607909640000);

insert into bwptest1.xxl_job_info (ID, APP_ID, JOB_GROUP, GLUE_TYPE, GLUE_REMARK, JOB_CRON, EXECUTOR_HANDLER, EXECUTOR_PARAM, JOB_DESC, CHILD_JOBID, ADD_TIME, UPDATE_TIME, AUTHOR, TRIGGER_STATUS, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_UPDATETIME, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (xxl_job_info_seq.nextval, 'app_sanfu_retail', 1, 'BEAN', null, '0 0/5  * * * ?', 'actionJobHandler', 'action_itf_a_supp_141', '供应商档案-合作范围接口导入', null, to_date('26-10-2020', 'dd-mm-yyyy'), to_date('26-10-2020', 'dd-mm-yyyy'), 'HX87', 0, null, 'ROUND', 'SERIAL_EXECUTION', 0, 0, to_date('26-10-2020', 'dd-mm-yyyy'), 1607909580000, 1607909640000);

end;
