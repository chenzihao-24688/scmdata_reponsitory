prompt PL/SQL Developer Export User Objects for user MRP@ORCL_SCMTEST
prompt Created by SANFU on 2023年6月15日
set define off
spool 20230614_table.log

prompt
prompt Creating sequence CLASS_ID_SEQ
prompt ==============================
prompt
@@class_id_seq.seq
prompt
prompt Creating sequence XXL_JOB_GROUP_ID
prompt ==================================
prompt
@@xxl_job_group_id.seq
prompt
prompt Creating sequence XXL_JOB_INFO_ID
prompt =================================
prompt
@@xxl_job_info_id.seq
prompt
prompt Creating sequence XXL_JOB_LOCK_ID
prompt =================================
prompt
@@xxl_job_lock_id.seq
prompt
prompt Creating sequence XXL_JOB_LOGGLUE_ID
prompt ====================================
prompt
@@xxl_job_logglue_id.seq
prompt
prompt Creating sequence XXL_JOB_LOG_ID
prompt ================================
prompt
@@xxl_job_log_id.seq
prompt
prompt Creating sequence XXL_JOB_LOG_REPORT_ID
prompt =======================================
prompt
@@xxl_job_log_report_id.seq
prompt
prompt Creating sequence XXL_JOB_REGISTRY_ID
prompt =====================================
prompt
@@xxl_job_registry_id.seq
prompt
prompt Creating sequence XXL_JOB_USER_ID
prompt =================================
prompt
@@xxl_job_user_id.seq

prompt Done
spool off
set define on
