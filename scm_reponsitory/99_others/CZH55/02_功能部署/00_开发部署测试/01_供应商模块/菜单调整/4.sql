???prompt Importing table scmdata.sys_app_privilege...
set feedback off
set define off
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P015', '异常处理', 'root', 0, 0, 'node_a_product_200', null, 'CZH', to_date('09-02-2022 10:29:09', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('09-02-2022 10:29:09', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_200_auto', 0);

prompt Done.
