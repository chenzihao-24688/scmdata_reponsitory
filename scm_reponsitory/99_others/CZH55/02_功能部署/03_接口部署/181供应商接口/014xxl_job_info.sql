prompt Importing table bwptest1.xxl_job_info...
set feedback off
set define off
insert into bwptest1.xxl_job_info (ID, APP_ID, JOB_GROUP, JOB_CRON, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID, TRIGGER_STATUS, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (520, 'app_sanfu_retail', 1, '0 0/5  * * * ?', '供应商档案接口导入', to_date('26-10-2020', 'dd-mm-yyyy'), to_date('14-07-2021 11:58:56', 'dd-mm-yyyy hh24:mi:ss'), 'HX87', null, 'ROUND', 'actionJobHandler', 'action_itf_a_supp_140', 'SERIAL_EXECUTION', 0, 0, 'BEAN', null, null, to_date('26-10-2020', 'dd-mm-yyyy'), null, 1, 1626508500000, 1626508800000);

insert into bwptest1.xxl_job_info (ID, APP_ID, JOB_GROUP, JOB_CRON, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID, TRIGGER_STATUS, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (521, 'app_sanfu_retail', 1, '0 0/5  * * * ?', '供应商档案-合作范围接口导入', to_date('26-10-2020', 'dd-mm-yyyy'), to_date('14-07-2021 11:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'HX87', null, 'ROUND', 'actionJobHandler', 'action_itf_a_supp_141', 'SERIAL_EXECUTION', 0, 0, 'BEAN', null, null, to_date('26-10-2020', 'dd-mm-yyyy'), null, 1, 1626508500000, 1626508800000);

prompt Done.
