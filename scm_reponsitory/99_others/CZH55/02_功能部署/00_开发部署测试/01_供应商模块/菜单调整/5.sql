???prompt Importing table scmdata.sys_app_privilege...
set feedback off
set define off
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00905', '扣款单（供应商）', 'P015', 0, 0, 'node_a_product_140', null, 'cb82c279e43c368ce0533c281cac20cf', to_date('27-12-2021 16:22:44', 'dd-mm-yyyy hh24:mi:ss'), 'cb82c279e43c368ce0533c281cac20cf', to_date('27-12-2021 16:22:44', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_140_auto', 2);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00906', '生产进度填报', 'P009', 0, 0, 'node_a_product_201', null, 'CZH', to_date('18-01-2022 14:06:19', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('18-01-2022 14:06:19', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_201_auto', 2);

prompt Done.
