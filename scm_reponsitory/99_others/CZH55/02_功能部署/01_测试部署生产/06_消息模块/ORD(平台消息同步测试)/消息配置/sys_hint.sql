???prompt Importing table bw3.sys_hint...
set feedback off
set define off
insert into bw3.sys_hint (HINT_ID, NODE_ID, CAPTION, TEXT_SQL, DATA_SQL, BTN_CAPTION, BTN_EXEC_SQL, BTN_ENABLE_SQL, WRAP_FLAG, HINT_FLAG, PAUSE, DATA_SOURCE, APP_ID)
values ('hint_2104126014018883', 'node_a_coop_200', '�鳧����-����֪ͨ', 'SELECT ''����'' || COUNT(1) || ''���鳧���뵥�账���뼰ʱǰ��[�鳧����]=>[���������]ҳ����д���лл��''
  FROM scmdata.t_factory_ask fa
 WHERE fa.company_id = %default_company_id%
   AND fa.factrory_ask_flow_status = ''FA02''', null, null, null, null, 1, 3, 0, 'oracle_scmdata', 'scm');

insert into bw3.sys_hint (HINT_ID, NODE_ID, CAPTION, TEXT_SQL, DATA_SQL, BTN_CAPTION, BTN_EXEC_SQL, BTN_ENABLE_SQL, WRAP_FLAG, HINT_FLAG, PAUSE, DATA_SOURCE, APP_ID)
values ('hint_2104126118444984', 'node_a_supp_100', '��Ӧ�̹���-����֪ͨ', 'SELECT ''����'' || COUNT(*) || ''�ҹ�Ӧ��׼��ɹ�,�뼰ʱǰ��[��Ӧ�̹���]=>[��������Ӧ���б�]ҳ����д���''
  FROM scmdata.t_supplier_info sp
 WHERE sp.company_id = %default_company_id%
   AND sp.status = 0', null, null, null, null, 1, 3, 0, 'oracle_scmdata', 'scm');

insert into bw3.sys_hint (HINT_ID, NODE_ID, CAPTION, TEXT_SQL, DATA_SQL, BTN_CAPTION, BTN_EXEC_SQL, BTN_ENABLE_SQL, WRAP_FLAG, HINT_FLAG, PAUSE, DATA_SOURCE, APP_ID)
values ('hint_2104126153891885', 'node_a_check_100', '�鳧����-�鳧֪ͨ', 'SELECT ''����'' || COUNT(1) || ''��[���鳧]�鳧���뵥�账���뼰ʱǰ��[�鳧����]=>[���鳧]ҳ����д���лл��''
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = ''FA11''', null, null, null, null, 1, 3, 0, 'oracle_scmdata', 'scm');

insert into bw3.sys_hint (HINT_ID, NODE_ID, CAPTION, TEXT_SQL, DATA_SQL, BTN_CAPTION, BTN_EXEC_SQL, BTN_ENABLE_SQL, WRAP_FLAG, HINT_FLAG, PAUSE, DATA_SOURCE, APP_ID)
values ('hint_2104125726584782', 'node_a_coop_310', '׼������-׼������֪ͨ', ' SELECT ''����'' || COUNT(1) || ''����׼�������账��,�뼰ʱǰ��[׼������]=>[����������]ҳ����д���лл��''
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = ''FA12''', null, null, null, null, 1, 3, 0, 'oracle_scmdata', 'scm');

prompt Done.
