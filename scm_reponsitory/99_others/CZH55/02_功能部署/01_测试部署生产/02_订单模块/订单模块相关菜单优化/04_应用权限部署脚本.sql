--1.备份权限相关表app_priva,cond_list,cond_rela 数据
create table scmdata.sys_app_privilege_bak as select * from scmdata.sys_app_privilege where 1 = 1;
/
create table bw3.sys_cond_list_bak as select * from bw3.sys_cond_list where 1 = 1;
/
create table bw3.sys_cond_rela_bak as select * from bw3.sys_cond_rela where 1 = 1;
/
--2.迁移应用权限时处理，先备份原应用权限，且sys_app_privilege表字段cond_id置空,同时删除相应cond_id关联的sys_cond_list,sys_cond_rela
BEGIN
  DELETE FROM bw3.sys_cond_rela t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P00901')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  DELETE FROM bw3.sys_cond_list t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P00901')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  UPDATE scmdata.sys_app_privilege t
     SET t.cond_id = NULL,t.pause = 1
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P00901')
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);
END;
/
--清空导出权限
BEGIN
  UPDATE scmdata.sys_app_privilege a
     SET a.cond_id = NULL
   WHERE a.cond_id IS NOT NULL
     AND a.cond_id LIKE '%cond_9_auto%';

  DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%cond_9_auto%';
  DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%cond_9_auto%';
END;
/
--3.导入迁移后应用权限，app_prival,cond_list,cond_rela
begin
--供应商
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00703', '生产订单（供应商）', 'P007', 0, 0, 'node_a_order_201_0', null, 'CZH', to_date('19-04-2022 17:08:45', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 17:08:45', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_order_201_0_auto', 2);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00704', '非生产订单（供应商）', 'P007', 0, 0, 'node_a_order_201_4', null, 'CZH', to_date('19-04-2022 17:09:05', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 17:09:05', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_order_201_4_auto', 2);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00705', '已完成订单（供应商）', 'P007', 0, 0, 'node_a_order_201_1', null, 'CZH', to_date('19-04-2022 17:09:49', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 17:09:49', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_order_201_1_auto', 2);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00911', '生产订单进度表（供应商）', 'P009', 0, 0, 'node_a_product_210', null, 'CZH', to_date('19-04-2022 17:03:50', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 17:03:50', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_210_auto', 2);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00912', '非生产订单（供应商）', 'P009', 0, 0, 'node_a_product_217', null, 'CZH', to_date('19-04-2022 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 17:04:32', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_217_auto', 2);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00913', '已完成订单（供应商）', 'P009', 0, 0, 'node_a_product_216', null, 'CZH', to_date('19-04-2022 17:05:13', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 17:05:13', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_216_auto', 2);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_order_201_0_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00703'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_order_201_1_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00705'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_order_201_4_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00704'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_210_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00911'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_216_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00913'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_217_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00912'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_order_201_0_auto', 0, 'node_a_order_201_0', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_order_201_1_auto', 0, 'node_a_order_201_1', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_order_201_4_auto', 0, 'node_a_order_201_4', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_210_auto', 0, 'node_a_product_210', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_216_auto', 0, 'node_a_product_216', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_217_auto', 0, 'node_a_product_217', 0, 1, 0, null);

--采购方

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00907', '生产订单进度表（采购方）', 'P009', 0, 0, 'node_a_product_110', null, 'CZH', to_date('19-04-2022 15:09:08', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 15:09:08', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_110_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090701', '查看', 'P00907', 0, 14, 'a_product_110', null, 'CZH', to_date('19-04-2022 15:16:28', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 15:16:28', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_110_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090702', '编辑', 'P00907', 0, 13, 'a_product_110', null, 'CZH', to_date('19-04-2022 15:17:16', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 15:17:16', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_110_auto_1', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090703', '导出', 'P00907', 0, 98, '9', 'a_product_110', 'CZH', to_date('19-04-2022 15:17:48', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 15:17:48', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_87', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090704', '生成节点模板', 'P00907', 0, 91, 'action_a_product_101_4', null, 'admin', to_date('27-01-2021 16:03:35', 'dd-mm-yyyy hh24:mi:ss'), 'admin', to_date('27-01-2021 16:03:35', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_101_4_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090705', '异常处理按钮', 'P00907', 0, 91, 'action_a_product_110_3', null, 'admin', to_date('27-01-2021 16:04:42', 'dd-mm-yyyy hh24:mi:ss'), 'admin', to_date('27-01-2021 16:04:42', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_110_3_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090707', '批量复制进度', 'P00907', 0, 91, 'action_a_product_110_1', null, 'admin', to_date('27-01-2021 16:04:28', 'dd-mm-yyyy hh24:mi:ss'), 'admin', to_date('27-01-2021 16:04:28', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_110_1_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00908', '非生产订单（采购方）', 'P009', 0, 0, 'node_a_product_150', null, 'CZH', to_date('19-04-2022 16:33:19', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 16:33:19', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_150_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090801', '查看', 'P00908', 0, 14, 'a_product_150', null, 'CZH', to_date('19-04-2022 15:16:28', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 15:16:28', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_150_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090802', '编辑', 'P00908', 0, 13, 'a_product_150', null, 'CZH', to_date('19-04-2022 15:17:16', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 15:17:16', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_150_auto_1', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090803', '导出', 'P00908', 0, 98, '9', 'a_product_150', 'CZH', to_date('19-04-2022 15:17:48', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 15:17:48', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_100', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00909', '可结束订单', 'P009', 0, 0, 'node_a_report_order_100', null, 'CZH', to_date('19-04-2022 16:41:44', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 16:41:44', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_report_order_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090901', '查看', 'P00909', 0, 14, 'a_report_order_100', null, 'CZH', to_date('06-04-2022 09:57:31', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:57:31', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_report_order_100_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090902', '导出', 'P00909', 0, 98, '9', 'a_report_order_100', 'CZH', to_date('06-04-2022 09:58:01', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('06-04-2022 09:58:01', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_119', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P00910', '已完成订单（采购方）', 'P009', 0, 0, 'node_a_product_116', null, 'CZH', to_date('19-04-2022 16:43:18', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 16:43:18', 'dd-mm-yyyy hh24:mi:ss'), 'cond_node_a_product_116_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0091001', '查看', 'P00910', 0, 14, 'a_product_116', null, 'admin', to_date('27-01-2021 15:53:09', 'dd-mm-yyyy hh24:mi:ss'), 'admin', to_date('27-01-2021 15:53:09', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_116_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0091003', '导出', 'P00910', 0, 98, '9', 'a_product_116', 'CZH', to_date('19-04-2022 15:17:48', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('19-04-2022 15:17:48', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_120', 1);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_product_110_3_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090705'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_report_order_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090901'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_119', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090902'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_product_116_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0091001'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_product_110_auto_1', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090702'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_116_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00910'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_110_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00907'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_product_110_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090701'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_report_order_100_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00909'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_product_150_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090801'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_product_150_auto_1', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090802'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_120', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0091003'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_product_110_1_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090707'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_100', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090803'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_product_101_4_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090704'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_node_a_product_150_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P00908'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_87', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090703'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_product_110_3_auto', 91, 'action_a_product_110_3', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_report_order_100_auto', 14, 'a_report_order_100', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_119', 98, '9', 0, 1, 0, 'a_report_order_100');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_116_auto', 0, 'node_a_product_116', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_110_auto', 0, 'node_a_product_110', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_product_150_auto_1', 13, 'a_product_150', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_product_116_auto', 14, 'a_product_116', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_product_110_auto_1', 13, 'a_product_110', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_product_110_auto', 14, 'a_product_110', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_product_150_auto', 14, 'a_product_150', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_report_order_100_auto', 0, 'node_a_report_order_100', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_120', 98, '9', 0, 1, 0, 'a_product_116');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_product_110_1_auto', 91, 'action_a_product_110_1', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_100', 98, '9', 0, 1, 0, 'a_product_150');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_product_101_4_auto', 91, 'action_a_product_101_4', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_node_a_product_150_auto', 0, 'node_a_product_150', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_87', 98, '9', 0, 1, 0, 'a_product_110');

--从表-按钮共用配置
--按钮
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090110', '结束订单', 'P00901', 0, 91, 'action_a_product_110', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 19:29:32', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 19:29:32', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_110_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090111', '批量复制延期问题', 'P00901', 0, 91, 'action_a_product_110_4', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 19:30:08', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 19:30:08', 'dd-mm-yyyy hh24:mi:ss'), 'cond_action_a_product_110_4_auto', 1);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_product_110_4_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090111'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_product_110_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0090110'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_product_110_4_auto', 91, 'action_a_product_110_4', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_product_110_auto', 91, 'action_a_product_110', 0, 1, 0, null);

--从表
update scmdata.sys_app_privilege t set t.pause = 0 where t.priv_id in ('P0090103','P0090104','P0090105','P0090107');
update scmdata.sys_app_privilege t set t.priv_name = '从-品控记录' where t.priv_id in ('P0090105');
update scmdata.sys_app_privilege t set t.priv_name = '从表/按钮共用配置' where t.priv_id in ('P00901');

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P0090112', '从-进度跟进日志', 'P00901', 0, null, null, null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 19:59:43', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 19:59:43', 'dd-mm-yyyy hh24:mi:ss'), null, 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P009011201', '查看', 'P0090112', 0, 14, 'a_product_111_1', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 20:00:13', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 20:00:13', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_111_1_auto', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P009011202', '编辑', 'P0090112', 0, 13, 'a_product_111_1', null, 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 20:00:29', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 20:00:29', 'dd-mm-yyyy hh24:mi:ss'), 'cond_a_product_111_1_auto_1', 1);

insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG)
values ('P009011203', '导出', 'P0090112', 0, 98, '9', 'a_product_111_1', 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 20:00:49', 'dd-mm-yyyy hh24:mi:ss'), 'bfff0ebdd2e22b0be0550250568762e1', to_date('21-04-2022 20:00:49', 'dd-mm-yyyy hh24:mi:ss'), 'cond_9_auto_113', 1);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_9_auto_113', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P009011203'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_product_111_1_auto', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P009011201'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_product_111_1_auto_1', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P009011202'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_9_auto_113', 98, '9', 0, 1, 0, 'a_product_111_1');

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_product_111_1_auto', 14, 'a_product_111_1', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_a_product_111_1_auto_1', 13, 'a_product_111_1', 0, 1, 0, null);

end;
/
--从表
DECLARE
  v_i INT;
BEGIN
  v_i := 0;
  FOR item IN (SELECT t.priv_id
                 FROM scmdata.sys_app_privilege t
                START WITH t.priv_id IN
                           ('P0090103','P0090104','P0090105','P0090107') 
               CONNECT BY PRIOR t.priv_id = t.parent_priv_id) LOOP
    BEGIN
      pkg_company_manage.p_privilege_cond(item.priv_id);
      v_i := v_i + 1;
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('''' || item.priv_id || ''',');
        --raise_application_error(-20002, v_i || item.priv_id);
    END;
  END LOOP;
END;
/
--4.清空并重新生成导出权限
BEGIN
  UPDATE scmdata.sys_app_privilege a
     SET a.cond_id = NULL
   WHERE a.cond_id IS NOT NULL
     AND a.cond_id LIKE '%cond_9_auto%';

  DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%cond_9_auto%';
  DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%cond_9_auto%';
END;
/
DECLARE
  v_i INT;
BEGIN
  v_i := 0;
  FOR item IN (SELECT t.priv_id
                 FROM scmdata.sys_app_privilege t
                WHERE t.ctl_id = '9' and t.pause = 0) LOOP
    BEGIN
      pkg_company_manage.p_privilege_cond(item.priv_id);
      v_i := v_i + 1;
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('''' || item.priv_id || ''',');
        --raise_application_error(-20002, v_i || item.priv_id);
    END;
  END LOOP;
END;

