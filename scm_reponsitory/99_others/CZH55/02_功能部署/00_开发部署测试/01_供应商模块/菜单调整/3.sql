???prompt Importing table scmdata.sys_group_apply...
set feedback off
set define off
insert into scmdata.sys_group_apply (APPLY_ID, ICON, APPLY_NAME, TIPS, APPLY_STATUS, SORT, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, IS_COMPANY, APPLY_TYPE, ITEM_TYPE, PAUSE, IS_FREE, PRIV_ID, APPLY_BELONG)
values ('apply_16', 'a1a14e9d2dfd5fa9b1f59a6f48e3eeb1', '异常处理', '进行订单生产异常处理、扣款处理', '0', 16, 'admin', to_date('15-08-2020', 'dd-mm-yyyy'), 'admin', to_date('15-08-2020', 'dd-mm-yyyy'), 1, '企业应用', '平台应用', 0, 0, 'P015', 0);

prompt Done.
