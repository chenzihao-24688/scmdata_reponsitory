BEGIN
  UPDATE scmdata.sys_app_privilege t
     SET t.pause = 1
   WHERE t.priv_id IN ('P013030104', 'P013030105', 'P013030106');
END;
/
BEGIN
 insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013030107', '查看日志', 'P0130301', 0, 91, 'action_a_report_120_3', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('24-09-2022 14:02:07', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('24-09-2022 14:02:07', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_report_120_3_auto', 0);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013030108', '指定跟单员', 'P0130301', 0, 91, 'action_a_report_120_1', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('24-09-2022 14:03:04', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('24-09-2022 14:03:04', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_report_120_1_auto', 0);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P013030109', '指定QC', 'P0130301', 0, 91, 'action_a_report_120_2', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('24-09-2022 14:03:28', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('24-09-2022 14:03:28', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_report_120_2_auto', 0);

END;
/
