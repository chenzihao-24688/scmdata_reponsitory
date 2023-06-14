BEGIN
DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%a_product_118%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%a_product_118%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%action_a_product_110_6%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%action_a_product_110_6%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%action_a_product_150_1%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%action_a_product_150_1%'; 

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%a_product_111_2%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%a_product_111_2%';
END;
/
BEGIN
/*insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090705', '异常处理按钮', 'P00907', 0, 91, 'action_a_product_110_3', null, 'admin', to_date('27-01-2021 16:04:42', 'dd-mm-yyyy hh24:mi:ss'), 'admin', to_date('27-01-2021 16:04:42', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_110_3_auto', 1);
*/
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P009070501', '异常处理单', 'P0090705', 0, 0, 'node_a_product_118', null, 'CZH', to_date('08-07-2022 16:33:21', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:33:21', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_118_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050101', '查看', 'P009070501', 0, 14, 'a_product_118', null, 'CZH', to_date('08-07-2022 16:34:35', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:34:35', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_118_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050102', '编辑', 'P009070501', 0, 13, 'a_product_118', null, 'CZH', to_date('08-07-2022 16:35:51', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:35:51', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_118_auto_1', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050103', '新增', 'P009070501', 0, 11, 'a_product_118', null, 'CZH', to_date('08-07-2022 16:43:16', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:43:16', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_118_auto_2', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050104', '删除', 'P009070501', 0, 12, 'a_product_118', null, 'CZH', to_date('08-07-2022 16:43:37', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:43:37', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_118_auto_3', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050105', '导出', 'P009070501', 0, 98, '9', 'a_product_118', 'CZH', to_date('08-07-2022 16:44:13', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:44:13', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_58', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050106', '新增交期异常', 'P009070501', 0, 91, 'action_a_product_118_2', null, 'CZH', to_date('08-07-2022 16:45:25', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:45:25', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_118_2_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050107', '新增质量异常', 'P009070501', 0, 91, 'action_a_product_118_3', null, 'CZH', to_date('08-07-2022 16:46:10', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:46:10', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_118_3_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050108', '新增其它异常', 'P009070501', 0, 91, 'action_a_product_118_4', null, 'CZH', to_date('08-07-2022 16:50:07', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:50:07', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_118_4_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050109', '批量复制异常单', 'P009070501', 0, 91, 'action_a_product_118_5', null, 'CZH', to_date('08-07-2022 16:50:59', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:50:59', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_118_5_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907050110', '提交', 'P009070501', 0, 91, 'action_a_product_118_1', null, 'CZH', to_date('08-07-2022 16:51:21', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('08-07-2022 16:51:21', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_118_1_auto', 1);

END;
/
BEGIN
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090113', '批量复制进度(生产订单)', 'P00901', 0, 91, 'action_a_product_110_6', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('11-07-2022 11:31:19', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('11-07-2022 11:31:19', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_110_6_auto', 1);
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090114', '批量复制进度(非生产订单)', 'P00901', 0, 91, 'action_a_product_150_1', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('11-07-2022 14:10:10', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('11-07-2022 14:10:10', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_150_1_auto', 1);
END;
/
BEGIN
UPDATE scmdata.sys_app_privilege t SET t.ctl_id = 'a_product_111_2' WHERE t.priv_id = 'P009011201';
UPDATE scmdata.sys_app_privilege t SET t.pause = 1 WHERE t.priv_id = 'P009011202';
UPDATE scmdata.sys_app_privilege t SET t.pause = 1 WHERE t.priv_id = 'P0090103';
UPDATE scmdata.sys_app_privilege t SET t.pause = 1
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P0090103')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);
UPDATE scmdata.sys_app_privilege t SET t.item_id = 'a_product_111_2' WHERE t.priv_id = 'P009011203';
END;
/
BEGIN
  DELETE FROM bw3.sys_cond_rela t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P0090705', 'P0090113', 'P009011201')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  DELETE FROM bw3.sys_cond_list t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P0090705', 'P0090113', 'P009011201')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  UPDATE scmdata.sys_app_privilege t
     SET t.cond_id = NULL
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P0090705', 'P0090113', 'P009011201') 
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);
END;
/
BEGIN
  UPDATE scmdata.sys_app_privilege a
     SET a.cond_id = NULL
   WHERE a.cond_id IS NOT NULL
     AND a.cond_id LIKE '%cond_9_auto%';

  DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%cond_9_auto%';
  DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%cond_9_auto%';
END;
/
