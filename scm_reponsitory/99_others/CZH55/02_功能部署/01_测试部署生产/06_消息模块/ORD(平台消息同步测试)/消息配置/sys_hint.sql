???prompt Importing table bw3.sys_hint...
set feedback off
set define off
insert into bw3.sys_hint (HINT_ID, NODE_ID, CAPTION, TEXT_SQL, DATA_SQL, BTN_CAPTION, BTN_EXEC_SQL, BTN_ENABLE_SQL, WRAP_FLAG, HINT_FLAG, PAUSE, DATA_SOURCE, APP_ID)
values ('hint_2104126014018883', 'node_a_coop_200', '验厂申请-审批通知', 'SELECT ''您有'' || COUNT(1) || ''条验厂申请单需处理，请及时前往[验厂申请]=>[待审核申请]页面进行处理，谢谢！''
  FROM scmdata.t_factory_ask fa
 WHERE fa.company_id = %default_company_id%
   AND fa.factrory_ask_flow_status = ''FA02''', null, null, null, null, 1, 3, 0, 'oracle_scmdata', 'scm');

insert into bw3.sys_hint (HINT_ID, NODE_ID, CAPTION, TEXT_SQL, DATA_SQL, BTN_CAPTION, BTN_EXEC_SQL, BTN_ENABLE_SQL, WRAP_FLAG, HINT_FLAG, PAUSE, DATA_SOURCE, APP_ID)
values ('hint_2104126118444984', 'node_a_supp_100', '供应商管理-建档通知', 'SELECT ''您有'' || COUNT(*) || ''家供应商准入成功,请及时前往[供应商管理]=>[待建档供应商列表]页面进行处理！''
  FROM scmdata.t_supplier_info sp
 WHERE sp.company_id = %default_company_id%
   AND sp.status = 0', null, null, null, null, 1, 3, 0, 'oracle_scmdata', 'scm');

insert into bw3.sys_hint (HINT_ID, NODE_ID, CAPTION, TEXT_SQL, DATA_SQL, BTN_CAPTION, BTN_EXEC_SQL, BTN_ENABLE_SQL, WRAP_FLAG, HINT_FLAG, PAUSE, DATA_SOURCE, APP_ID)
values ('hint_2104126153891885', 'node_a_check_100', '验厂管理-验厂通知', 'SELECT ''您有'' || COUNT(1) || ''条[待验厂]验厂申请单需处理，请及时前往[验厂管理]=>[待验厂]页面进行处理，谢谢！''
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = ''FA11''', null, null, null, null, 1, 3, 0, 'oracle_scmdata', 'scm');

insert into bw3.sys_hint (HINT_ID, NODE_ID, CAPTION, TEXT_SQL, DATA_SQL, BTN_CAPTION, BTN_EXEC_SQL, BTN_ENABLE_SQL, WRAP_FLAG, HINT_FLAG, PAUSE, DATA_SOURCE, APP_ID)
values ('hint_2104125726584782', 'node_a_coop_310', '准入审批-准入审批通知', ' SELECT ''您有'' || COUNT(1) || ''条待准入审批需处理,请及时前往[准入审批]=>[待审批申请]页面进行处理，谢谢！''
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = ''FA12''', null, null, null, null, 1, 3, 0, 'oracle_scmdata', 'scm');

prompt Done.
