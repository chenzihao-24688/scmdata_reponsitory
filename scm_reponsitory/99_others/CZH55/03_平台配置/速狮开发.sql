select rowid,t.* from bwptest1.sys_item t where t.item_id = 'data-20207221';

--�ݹ���
select rowid,t.*
  from bwptest1.sys_tree_list t
 start with t.item_id = 'data-202072'
connect by prior t.item_id = t.parent_id;--czh2000

select rowid,t.* from bwptest1.sys_item_list t where t.item_id = 'data-20207221';
--czhdata-2000
--�˵�����

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-20207131','data-202071311','data-2020713111') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-20207131','data-202071311','data-2020713111') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-20207131','data-202071311','data-2020713111'); 
select rowid,t.* from bwptest1.sys_item_custom t ;
select rowid,t.* from bwptest1.sys_item  t where t.base_table like '%PL_DIC_CATEGORYGROUPS%' 
--------------------------------------------------------------------------------------------------

select rowid,t.* from bwptest1.sys_item t where t.item_id in('scm_p_1','scm_p_10','scm_p_20','scm_p_30','scm_p_40') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('scm_p_1','scm_p_10','scm_p_20','scm_p_30','scm_p_40') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('scm_p_1','scm_p_10','scm_p_20','scm_p_30','scm_p_40'); 



--ҳ������
--1. ҳ������
--��׼��ѯ����sys_item SYS_ITEM_LIST sys_field_list
--��ݲ�ѯ����SYS_QUICK_QUERY
select rowid,t.* from bwptest1.SYS_QUICK_QUERY t ; --data-202071212 a.bra_id,a.bra_name

--��׼��ȡ  ???
select rowid,t.* from bwptest1.RESOURCES_DRILL t ;--data-202071221
select rowid,t.* from bwptest1.RESOURCES_DRILL_RESULT t ;
select rowid,t.* from bwptest1.resources_drill_level t ;

--��¼��ز��������� 7.2�ż�����
--������������
select rowid,t.* from bwptest1.sys_item t where t.item_id = 'scm_p_1';
select rowid,t.* from bwptest1.sys_tree_list t where t.node_id = 'node-scm_p_1';
select rowid,t.* from bwptest1.sys_item_list t where t.item_id = 'scm_p_1'; 
select rowid,t.* from bwptest1.SYS_PERSONAL_MENU t ;--node_czh2000  node-data-20207124

--������Ϣ����  
select rowid,t.* from bwptest1.sys_config t ; 
select rowid,t.* from bwptest1.sys_sql_config t where t.sql_name in ('user_info','modify_user_info');

--2. ҳ��ģ��
--ͨ�ù���

select rowid,t.* from bwptest1.sys_item t ;
select rowid,t.* from bwptest1.sys_tree_list t ;
select rowid,t.* from bwptest1.sys_item_list t  ;
select rowid,t.* from bwptest1.sys_element_hint t ;
select rowid,t.* from bwptest1.sys_field_back_color t ;

--��ɾ�Ĳ���

--��ȡ

--�����ӣ������¼����ܣ�  ��Ҫ���ö�һ��item   data-2020713111   CUSGROUPNO����һitem_list ͨ�� %ASS_cusgroupno%���ϼ���������  

--ע��LINK_FIELD�ֶ�

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-20207131','data-202071311','data-2020713111') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-20207131','data-202071311','data-2020713111') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-20207131','data-202071311','data-2020713111'); 

--actions�������ݰ�ť  ע��SELECT_FIELDS��ʹ��
--�� sys_element  sys_action  sys_item_element_rela   
--data-czh20001
select rowid,t.* from bwptest1.sys_element t  where t.element_id in ('action-test-3','action-20207131','action-202071311'); --action-20001  associate-test-1
select rowid,t.* from bwptest1.sys_action t  where t.element_id in ('action-test-3', 'action-20207131','action-202071311');--action-20001  associate-test-1
select rowid,t.* from bwptest1.sys_item_element_rela t where t.element_id in ('action-test-3','action-20207131','action-202071311'); --node-data-20207131  action-20207131  node-data-20207131


--֧���кͰ�ť���������������ʱ��������Ӧ�����İ�ť
select rowid,t.* from bwptest1.sys_item t where t.item_id in('test-4','data-20207131','data-202071311') ; 
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-4','data-20207131','data-202071311','data-2020713111'); 

select rowid,t.* from bwptest1.sys_element_hint t; 


--ҳüҳ��

select rowid,t.* from bwptest1.sys_item t where t.item_id in('test-4','data-20207131','data-202071311','data-2020713111') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('test-4','data-20207131','data-202071311','data-2020713111') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-4','data-20207131','data-202071311','data-2020713111'); 


--����֧�ֶ��н��б�����ɫ���ã�������б�

select a.bra_id,
       a.bra_name,
       a.fullname,
       a.jdbra_id,
       a.jdbra_name,
       '��ѯ�ֲ�����' excute,
       case a.bra_name
         when '��װ' then
          65280
         when 'Ůװ' then
          65535
       end GRIDBACKCOLOR
  from nsfdata.branch a

--����֧�ֶԵ����н��б�����ɫ����  data-20207131
select rowid,t.* from bwptest1.sys_field_back_color t ;

--����֧�ֶԵ����н���������ɫ���ã�����б�

select a.cusgroupno,
       a.cusgroupname,
       CASE
         WHEN a.cusgroupno = '152' THEN
          255
         ELSE
          NULL
       END GRIDFORECOLOR
  from nsfdata.pl_dic_cusgroups a
 where bra_id = %bra_id%

select a.categorygroupno,
       a.categorygroup,
       CASE
         WHEN a.categorygroupno = '152' THEN
          255
         ELSE
          NULL
       END GRIDFORECOLOR
  from nsfdata.pl_dic_categorygroup a;
  

--���

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-2020713','data-20207132','data-202071321','data-202071322') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-2020713','data-20207132','data-202071321','data-202071322') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-2020713','data-20207132','data-202071321','data-202071322'); 

--node-test-7

--�����Ʊ�  data-202071321  p-202071321
select rowid,t.* from bwptest1.sys_item t where t.item_id in ('test-7','data-202071321');

select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-7','data-202071321');

select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in ('test-7','data-202071321');

select rowid,t.* from bwptest1.sys_item_rela t where t.item_id in ('data-202071321','test-7') ;

select rowid,t.* from bwptest1.sys_pivot_list t where t.pivot_id in ('p-test-1','p-202071321'); 


--�����ֶ�  node-data-202071322
select rowid,t.* from bwptest1.sys_item t  where t.item_id in ('data-202071322');

select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-202071322');

select rowid,t.* from bwptest1.sys_item_rela t where t.item_id in ('data-202071322');

select rowid,t.* from bwptest1.sys_element t; --adt-202071322

select rowid,t.* from bwptest1.sys_adt_field t;

select rowid,t.* from bwptest1.sys_item_element_rela t;


--��ҳ  n2_test_dy-1
select rowid,t.* from bwptest1.sys_item t where t.item_id in('n2_test_dy-1','data-20207132','data-20207133','data-202071331','data-202071332') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('n2_test_dy-1','data-20207132','data-20207133','data-20207133','data-202071331','data-202071332') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('n2_test_dy-1','data-20207132','data-20207133','data-20207133','data-202071331','data-202071332'); --node-data-20207133 node-data-202071331 node-data-202071332
select rowid,t.* from bwptest1.sys_detail_group t;  --data-202071332

--�б�  data-20207133  scm_1003

select rowid,t.* from bwptest1.sys_item t where t.item_id in('n2_test_dy-1','data-20207132','data-20207133','data-202071331','data-202071332','scm_1003','data-20207134') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('n2_test_dy-1','data-20207132','data-20207133','data-20207133','data-202071331','data-202071332','scm_1003','data-20207134') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('n2_test_dy-1','data-20207132','data-20207133','data-20207133','data-202071331','data-202071332','scm_1003','data-20207134');
--select rowid,t.* from bwptest1.sys_tree_list t  where t.node_id = 'node_scm1003';
select rowid,t.* from bwptest1.sys_layout t where t.item_id = 'scm_1003'; --node_scm1003 scm_1003

--��׼ͼ  data-20207135
select rowid,t.* from bwptest1.sys_item t where t.item_id in('test-15','data-20207135') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('test-15','data-20207135') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('test-15','data-20207135');
--����
select rowid,t.* from bwptest1.sys_panel t where t.panel_id in ('p-test-5','p-20207135');
--������Ա�
select rowid,t.* from bwptest1.sys_panel_attribute t where t.panel_id  in ('p-test-5','p-20207135');

--select rowid,t.* from bwptest1.sys_item t where t.panel_id = 'p-test-5'; 
select rowid,t.* from bwptest1.sys_item_list t where t.item_id = 'test-15' ;

--ͨѶ¼  n1011_data-1005
select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-1005','data-20207135') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-1005','data-20207135') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-1005','data-20207135','data-20207136');
 
--ҳ����װ  data-2020714

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-1005','data-2020714','data-20207141','data-20207142','data-202071411','data-202071412') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-1005','data-2020714','data-20207141','data-20207142','data-202071411','data-202071412') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-1005','data-2020714','data-20207141','data-20207142','data-202071411','data-202071412');

--tabҳ
select rowid,t.* from bwptest1.sys_web_union t; --data-20207141

--���ӱ�  data-20207131
select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-20207131','data-202071311','data-2020713111','data-20207142','data-202071421','data-202071422') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-20207131','data-202071311','data-2020713111','data-20207142','data-202071421','data-202071422') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-20207131','data-202071311','data-2020713111','data-20207142','data-202071421','data-202071422');

select rowid,t.* from bwptest1.sys_item_rela t ; --data-20207142  data-202071421 data-202071422


--��������  data-202072

select rowid,t.* from bwptest1.sys_item t where t.item_id in('data-202071321','data-20207131','data-202071','data-2020712','data-20207211','data-20207221') ;  --data-202071   czh2000  czhdata-2000  czhdata-2000  node-data-20207131  data-202071311
select rowid,t.* from bwptest1.sys_tree_list t where t.item_id in('data-202071321','data-20207131','data-202071','data-2020712','data-20207211','data-20207221') ;--data-202071
select rowid,t.* from bwptest1.sys_item_list t where t.item_id in ('data-202071321','data-20207131','data-202071','data-2020712','data-20207211','data-20207221');

--�ֶ����ã������ֶΣ������ֶΣ�

select rowid,t.* from bwptest1.sys_field_list t; 

--�ֶο���  data-20207211  action-20207211  control-20207211-1  2  3 �������⣩��������

select rowid,t.* from bwptest1.Sys_element t;

select rowid,t.* from bwptest1.sys_item_element_rela t where t.element_id = 'control-20207211-1';

select rowid,t.* from bwptest1.SYS_FIELD_CONTROL t; 

select a.bra_id,
       a.bra_name,
       a.fullname,
       a.jdbra_id,
       a.jdbra_name,
       '��ѯ�ֲ�����' excute,
       case a.bra_name
         when '��װ' then
          65280
         when 'Ůװ' then
          65535
       end GRIDBACKCOLOR
  from nsfdata.branch a;--FULLNAME,JDBRA_ID,JDBRA_NAME
  
  
--��������  node-data-202071321  data-20207221

--�Զ���ֵ  data-20207211  assign-20207211

select rowid,t.* from bwptest1.sys_element t where t.element_id = 'assign-20207211';
select rowid,t.* from bwptest1.sys_assign t where t.element_id = 'assign-20207211' ;
select rowid,t.* from bwptest1.sys_item_element_rela t  where t.element_id = 'assign-20207211';

--default����Ĭ��ֵ  data-20207211   default-20207211

select rowid,t.* from bwptest1.sys_element t ;

select rowid,t.* from bwptest1.sys_default t ;

select rowid,t.* from bwptest1.sys_item_element_rela t ; 

--lookup����ѡ���б� data-20207211  look-20207211

select rowid,t.* from bwptest1.sys_element t;

select rowid,t.* from bwptest1.sys_look_up t;

select rowid,t.* from bwptest1.sys_item_element_rela t;

--valuelist�����б� data-20207211 value-20207211

select rowid,t.* from bwptest1.sys_element t;

select rowid,t.* from bwptest1.sys_value_list t;

select rowid,t.* from bwptest1.sys_item_element_rela t;
 
--picklist�����б�  data-20207221 pick-20207221-1 2 3 (��񣬵��㣬��㵯��)

select rowid,t.* from bwptest1.sys_element t;

select rowid,t.* from bwptest1.sys_pick_list t;

select rowid,t.* from bwptest1.sys_item_element_rela t;

--qryvaluelist���������򣨲�ѯ���棩 data-20207221


select rowid,t.* from bwptest1.sys_field_list t where t.field_name like '%FULLNAME%';

select rowid,t.* from bwptest1.sys_field_qryvalue t; --FULLNAME


--��ģ��   data-20207222




--pick+assign  data-20207223  pickassign-20207223   ע��ֺţ�GetUserNames

select rowid,t.* from bwptest1.sys_element t where t;

select rowid,t.* from bwptest1.sys_pick_list t where t.element_id = 'pickassign-20207223';

select rowid,t.* from bwptest1.sys_assign t WHERE t.element_id = 'assign-20207223';

select rowid,t.* from bwptest1.sys_item_element_rela t;



--����ͳ��
select rowid,t.* from bwptest1.sys_element t;

select rowid,t.* from bwptest1.sys_field_list t;

select rowid,t.* from bwptest1.sys_aggregate t;

select rowid,t.* from bwptest1.sys_item_element_rela t;
