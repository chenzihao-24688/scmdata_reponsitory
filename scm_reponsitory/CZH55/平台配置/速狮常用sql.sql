--1. Ӧ������
--1.1 �����������ݿ�  
--��sys_data_source
select rowid,t.* from sys_data_source t;
--1�� ��������Դ
insert into sys_data_source (DATA_SOURCE, DB_TYPE, USER_NAME, PASSWORD, DRIVER_CLASS, JDBC_URL, INITAL_POOL_SIZE, MAX_IDLE_TIME, MAX_POOL_SIZE, MIN_POOL_SIZE, PAUSE, SQL_SCRIPT)
values ('oracle_bwp', 'DATA', 'BWP', 'MTIzMzIx', 'oracle.jdbc.driver.OracleDriver', 'jdbc:oracle:thin:@218.85.23.61:5555:sforacle', 3, 30, 100, 3, 0, null);

--1.2 ȫ�ֲ�������  
--��sys_config
select rowid,t.* from bwptest1.sys_config t where t.set_name like '%login_mode%';

--1.3 sqlconfig����   ����¼ ע�� �����У��� ��ҳ������ʾ  ָ�����ã�
--��sys_sql_config  sys_cond_rela  sys_cond_list
select rowid,t.* from bwptest1.sys_cond_list t ;
select rowid,t.* from bwptest1.sys_cond_rela t ;
select rowid,t.* from bwptest1.sys_sql_config t;

--��һ��������condition��У���豸�Ƿ�Ϊָ�ƴ��豸 

insert into sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME)
values ('cond-70020', 'select max(1) from dual', 0, '��ǰ�ͻ��˲��ǿ��ڻ���condition��֤ʧ�ܣ�', null, null);

--�ڶ�������condition������Ӧ�ڵ� ע�⣡����

insert into sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond-70020', 0, 'node_attend-1', 0, 2, 1, null);

--�����������û�ȡ��ǰ�û�������ָ�ƣ�SYS_SQL_CONFIG��������Ϊ:attendance/getuserfinger)

insert into sys_sql_config (APP_ID, SQL_NAME, DATA_SOURCE, SQL_TEXT, SQL_TYPE, CONFIG_TYPE, MEMO, PAUSE)
values ('app_fastlion_retail', 'attendance/getuserfinger', 'oracle_lion', 'select userid, finger, finger1, finger2, username from users where userid = :userid', null, 0, '��ȡ�û�ָ����Ϣ', 0);

--1.4 ��ҵlogo��ϵͳ��������
--�� SYS_APP
select rowid,t.* from bwptest1.SYS_APP t;

--1.5 �ļ�����(����DB)
--��SYS_DATA_SOURCE  SYS_APP  SYS_FIELD_LIST

--1.6 ���ⲿϵͳ
--�� SYS_SSO_SYSTEM  SYS_APP_SSO_SYSTEM

select rowid,t.* from bwptest1.SYS_SSO_SYSTEM t;

select rowid,t.* from bwptest1.SYS_APP_SSO_SYSTEM t;

--1.7 Сʨ����
--�� LION_SYSTEM_KEY LION_APP LION_KEY_WORD LION_KEY_WORD_RESULT

select rowid,t.* from bwptest1.LION_SYSTEM_KEY t;
select rowid,t.* from bwptest1.LION_APP t ;
select rowid,t.* from bwptest1.LION_KEY_WORD t ;
select rowid,t.* from bwptest1.LION_KEY_WORD_RESULT t ;

--2.�˵�����
--�� sys_item  sys_tree_list  sys_item_list  sys_item_custom  sys_var
select rowid,t.* from bwptest1.sys_item t where t.item_id in('test-2','test-3','test-5');  --czh2000 czhdata-2000  data-czh2000 
--select rowid,t.* from bwptest1.sys_tree_list t where t.node_id in ('node-test-2' ,'czhdata-2000','node_b2000','n2000_data-2000','n2005_data-2005','node-test-2','node-test-3'); --node-test-2 czhdata-2000  
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in ('test-2','test-3','test-5');  --data-czh20001
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-2','test-3','test-5');--czhdata-2000 test-2  test-3
select rowid,t.* from bwptest1.sys_item_custom t ; --node-test-2  CUSGROUPNO
--�ݹ���
select *
  from bwptest1.sys_tree_list
 start with item_id = 'test-5'
connect by prior item_id = parent_id; --czhdata-2000  data-czh20001

select tr.*
  from bwptest1.sys_tree_list tr, bwptest1.sys_tree_list tr1
 where tr.item_id= tr1.parent_id(+)
   and tr.parent_id = 'test-2';
----------------------------------

select * from  nsfdata.branch;
insert into nsfdata.branch
  (bra_id,
   bra_name,
   fullname,
   jdbra_id,
   jdbra_name,
   paidrate,
   cashierpaidrate,
   propvalue,
   mom_branchid,
   isprimarysales,
   memo)
values
  (:bra_id,
   :bra_name,
   :fullname,
   :jdbra_id,
   :jdbra_name,
   :paidrate,
   :cashierpaidrate,
   :propvalue,
   :mom_branchid,
   :isprimarysales,
   :memo);
   
   update nsfdata.branch
      set bra_name        = :bra_name,
          fullname        = :fullname,
          jdbra_id        = :jdbra_id,
          jdbra_name      = :jdbra_name,
          paidrate        = :paidrate,
          cashierpaidrate = :cashierpaidrate,
          propvalue       = :propvalue,
          mom_branchid    = :mom_branchid,
          isprimarysales  = :isprimarysales,
          memo            = :memo
    where bra_id = :old_bra_id;
    
    delete from  nsfdata.branch where bra_id = :old_bra_id;


--2.1���ò˵�Ŀ¼  �ɺ����¼��˵�

--��һ��������sys_item������item_type����������Ϊ��menu
insert into sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG)
values ('zsy2000', 'menu', '�ŵ��������', null, null, null, null, null, null, null, 0, null, null, null, null, null, null);

--�ڶ���������sys_tree_list
insert into sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG)
values ('zsy2000', '100', 'zsy2000', 'menuroot', null, 'app_sanfu_retail', '@green@ icon-avatar (39)', 0, null, 0, 0, null, '�ŵ��������', null);

--2.2 ���ò˵��ڵ�   ��תitem���棬��ʾ������Ϣ
--��һ��������sys_item������item_type������Ϊ��list

insert into sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG)
values ('zsydata-2449', 'list', '��ֳ���', 'oracle_nsfdata', 'BRANCH', 'BRA_ID', 'BRA_NAME', 'zsydata-2449', null, null, 0, null, null, null, null, null, null);

--�ڶ��������� sys_tree_list���������ڵ㣩

insert into sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG)
values ('n2449_data-2449', '100', 'zsydata-2449', 'zsy2000', null, 'app_sanfu_retail', 'blue iconfont icon--wenjianjia', 0, null, 0, 0, null, null, null);

--������������sys_item_list������item����ʾ��Ϣ��

insert into sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SHOW_CHECKBOX, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT)
values ('zsydata-2449', 0, null, null, null, null, ' ', null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null);

--2.3  ���ù̶�ҳ��

--��һ��������sys_item������item_type����������Ϊ��custom
insert into bwptest1.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG)
values ('data-czh2000', 'custom', 'ָ�������޸�(czh)', null, null, null, null, 'data-czh2000', null, null, 0, null, null, null, null, null, null);


--�ڶ���������sys_tree_list
insert into bwptest1.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG)
values ('node_czhattend-2', 't_attend', 'data-czh2000', 'menuroot', null, 'app_sanfu_retail', 'fa fa-briefcase', 1, null, 3, 0, null, 'ָ�������޸�(czh)', null);

--������������sys_item_custom

insert into bwptest1.sys_item_custom (ITEM_ID, CUS_ADDR, PARAM_STR, ADDR_TYPE, REQ_METHOD)
values ('data-czh2000', 'commonui/pageroute?page=static%2FcheckIn', 'USERID', '0', null);

--2.4������ҳ��򿪷�ʽ (Ŀǰ֧�����꼰�¼���ת�򿪷�ʽ������)
--����ǰ��Ҫ��sys_item�Լ�sys_tree_list������һ���˵��ڵ㣬������Ϊ��ȡ���ܵ�Ŀ¼������sys_item.item_typeΪdrill�����׼��ȡ��Ŀ��
select rowid,t.* from bwptest1.sys_item t ;
select rowid,t.* from bwptest1.sys_tree_list t ;

--��׼��ȡ
select rowid,t.* from bwptest1.resources_drill t ;
select rowid,t.* from bwptest1.resources_drill_level t ;
select rowid,t.* from bwptest1.resources_drill_result t ;

--3.actions�������ݰ�ť  ע��SELECT_FIELDS��ʹ��
--�� sys_element  sys_action  sys_item_element_rela   
--data-czh20001
select rowid,t.* from bwptest1.sys_element t  where t.element_id = 'action-20001'; --action-20001  associate-test-1
select rowid,t.* from bwptest1.sys_action t  where t.element_id = 'action-20001';--where t.action_type = 0 and t.select_fields is not null;--action-20001  associate-test-1
select rowid,t.* from bwptest1.sys_item_element_rela t where t.item_id = 'data-czh20001';

select rowid,t.* from bwptest1.sys_item t where t.item_id = 'data-czh20001';
select rowid,t.* from bwptest1.sys_item_list t where t.item_id = 'data-czh20001';  


select rowid,t.* from bwptest1.sys_action t where t.action_sql like '%call%';--{{}}��̬����

SF_WX






