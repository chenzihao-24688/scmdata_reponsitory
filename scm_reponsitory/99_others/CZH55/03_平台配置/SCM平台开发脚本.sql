--�鿴����Դ
select a.*,a.rowid from nbw.sys_data_source a;
--��������
select  f_get_uuid() from dual;
--�û���¼
SELECT rowid,a.* FROM SYS_USER_LOGIN a;
--���쳣������ʾ��
raise_application_error(-20002,'�ǳƳ���7���ַ����������ַ�');

--ִ�мƻ�  explain plan for  F5
select * from plan_table;
select * from table(dbms_xplan.display);

--������ʽ
select *
   from scmdata.sys_group_dict t
  where regexp_like(t.group_dict_value, '.([a-z]+|[A-Z])');

--�ݹ���
select rowid,t.*
  from nbw.sys_tree_list t
 start with t.item_id = 'g_500'
connect by prior t.item_id = t.parent_id;--node_g_500

select rowid, t.* from nbw.sys_item t;
select rowid, t.* from nbw.sys_tree_list t;
select rowid, t.* from nbw.sys_item_list t;

--nbw ������  scmdata��ҵ��
--ƽ̨��̨ node_g_500
--1.�û�����

select * from scmdata.sys_user;
select decode(u.pause, 0, '����', 1, 'ͣ��') pause,
       u.avatar,
       u.nick_name,
       u.user_account,
       u.city,
       u.sex,
       u.birthday
 from scmdata.sys_user u;
 

 
select * from nbw.sys_tree_list t where t.node_id = 'node_g_500' ; --g_500

select rowid,t.* from nbw.sys_item t where t.item_id in('g_500','g_501','g_502','g_503') ;
select rowid,t.* from nbw.sys_tree_list t where t.item_id in('g_500','g_501','g_502','g_503') ;
select rowid,t.* from nbw.sys_item_list t where t.item_id in('g_500','g_501','g_502','g_503') ;

--�ֶ�����
select rowid,t.* from nbw.sys_field_list t; 
select rowid,t.* from nbw.sys_param_list t;


--��ť����
--action
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_501_1','action_g_501_2','action_g_501_3','action_g_501_4','action_g_501_5'); 
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_501_1','action_g_501_2','action_g_501_3','action_g_501_4','action_g_501_5');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_501_1','action_g_501_2','action_g_501_3','action_g_501_4','action_g_501_5');

select rowid,t.* from nbw.sys_element_hint t  ;

--��������ҳ��  associate-501-6
--associate ����  δ������
select rowid,t.* from nbw.sys_element t  where t.element_id in ('associate-501-6','associate-503-9'); 
select rowid,t.* from nbw.sys_associate t  where t.element_id in ('associate-501-6','associate-503-9');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('associate-501-6','associate-503-9');
select rowid,t.* from nbw.sys_element_hint t ;

--TABҳ  --g_502   node_g_502  g_502_1 ~6
select rowid,t.* from nbw.sys_item t;
select rowid,t.* from nbw.sys_tree_list t;--δ����
select rowid,t.* from nbw.sys_item_list t ;--δ����
select rowid,t.* from nbw.sys_web_union t;
select rowid,t.* from nbw.sys_item_rela t;--���ӱ�
select rowid,t.* from nbw.sys_field_list t; 
select rowid,t.* from nbw.sys_param_list t;

--sys_value_list  ƽ̨��ɫ����


--������
select rowid,t.* from nbw.sys_element t ;

select rowid,t.* from nbw.sys_look_up t ;

select rowid,t.* from nbw.sys_value_list t;

select rowid,t.* from nbw.sys_item_element_rela t ;

--��ť���� paramList
select rowid,t.* from nbw.sys_field_list t ; 
select rowid,t.* from nbw.sys_param_list t;

--sys_field_qryvalue ���������򣨻���Щ���⣬��Ҫ�ģ�

select rowid,t.* from nbw.sys_field_qryvalue t ;-- PAUSE  USER_TYPE

select rowid, t.* from scmdata.SYS_QRYVALUE_LIST t;

--�ǽṹ��condition ƽ̨����Ա�ɼ�  ����item

select rowid,t.* from nbw.sys_cond_list t;  --g_505_1  node_g_505_1

select rowid,t.* from nbw.sys_cond_rela t; --node_g_501

--����action   cond_czh_505_3_5
select rowid,t.* from nbw.sys_cond_list t;

select rowid,t.* from nbw.sys_cond_rela t;


--֧���кͰ�ť���������������ʱ��������Ӧ�����İ�ť
select rowid,t.* from nbw.sys_element_hint t  ;

--���ӱ�
select rowid,t.* from nbw.sys_item_rela t;

select rowid,t.* from nbw.sys_item t;
select rowid,t.* from nbw.sys_tree_list t;--δ����
select rowid,t.* from nbw.sys_item_list t;--δ����
select rowid,t.* from nbw.sys_item_rela t;

select rowid,t.* from nbw.sys_element t  where t.element_id in ('associate-501-6','associate-503-9'); 
select rowid,t.* from nbw.sys_associate t  where t.element_id in ('associate-501-6','associate-503-9');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('associate-501-6','associate-503-9');
select rowid,t.* from nbw.sys_element_hint t ;

--2.��ҵ����
select rowid,t.* from nbw.sys_item t where t.item_id in('g_500','g_501','g_502','g_503') ;
select rowid,t.* from nbw.sys_tree_list t where t.item_id in('g_500','g_501','g_502','g_503') ;
select rowid,t.* from nbw.sys_item_list t where t.item_id in('g_500','g_501','g_502','g_503') ;

--�ֶ�����
select rowid,t.* from nbw.sys_field_list t; 

--��ť����
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_503_1','action_g_503_2'); 
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_503_1','action_g_503_2');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_503_1','action_g_503_2');



--��ݼ�����
select rowid,t.* from nbw.sys_item t;

select rowid,t.* from nbw.sys_shortcut t;

select rowid,t.* from nbw.sys_shortcut_node_rela t;

select rowid,t.* from nbw.sys_item_custom t;

--3.Ӧ�ù���  g_504

select rowid,t.* from nbw.sys_item t  ;
select rowid,t.* from nbw.sys_tree_list t  ;
select rowid,t.* from nbw.sys_item_list t ;

--�ֶ�����
select rowid,t.* from nbw.sys_field_list t; 

--��ť����
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4'); 
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4');

--3.1 �۸�����
--g_504_1 --associate_g_504_3
select rowid, t.* from nbw.sys_item t where t.item_id LIKE '%g_504%';
select rowid, t.* from nbw.sys_tree_list t where t.item_id LIKE '%g_504%';
select rowid, t.* from nbw.sys_item_list t where t.item_id LIKE '%g_504%';

select rowid,t.* from nbw.sys_element t ;

select rowid,t.* from nbw.sys_look_up t where t.element_id like '%lookup_g_504_4%' ;

select rowid,t.* from nbw.sys_item_element_rela t ;

select rowid,t.* from nbw.sys_field_list t ; 

--3.2��Ӧ��


--4.��ɫȨ�޹��� g_505
select rowid,t.* from nbw.sys_item t  ;
select rowid,t.* from nbw.sys_tree_list t  ;
select rowid,t.* from nbw.sys_item_list t  ;
select rowid,t.* from nbw.sys_web_union t;--��ҳ
select rowid,t.* from nbw.sys_item_rela t;--���ӱ�

select rowid,t.* from nbw.sys_link_list t;--group_role_name

select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_505_3_1','action_g_505_3_5'); --action_g_505_3_5
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_505_3_1','action_g_505_3_5');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_505_3_1','action_g_505_3_5');


--����action   cond_czh_505_3_5
select rowid,t.* from nbw.sys_cond_list t;

select rowid,t.* from nbw.sys_cond_rela t;

select rowid,t.* from scmdata.SYS_GROUP_ROLE t ;
select rowid,t.* from scmdata.SYS_GROUP_ROLE_SECURITY t ;
select rowid,t.* from scmdata.SYS_GROUP_SECURITY t ;
select rowid,t.* from scmdata.SYS_GROUP_USER_ROLE t;

--�ֶ�����
select rowid,t.* from nbw.sys_field_list t; 

--��ť����  g_505_3   action_g_505_3_5
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_505_3_1','action_g_505_3_5'); --action_g_505_3_5
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_505_3_1','action_g_505_3_5');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_505_3_1','action_g_505_3_5');

--��ť���� paramList
select rowid,t.* from nbw.sys_field_list t; 
select rowid,t.* from nbw.sys_param_list t;

--�û�������ѡ�� picklist  g_505_7   pick_g_505_7

select rowid,t.* from nbw.sys_element t;

select rowid,t.* from nbw.sys_pick_list t;

select rowid,t.* from nbw.sys_item_element_rela t;

--5.�����ֵ�
select rowid,t.* from nbw.sys_item t where t.item_id like '%g_%' ;
select rowid,t.* from nbw.sys_tree_list t where t.item_id like '%g_%' ;
select rowid,t.* from nbw.sys_item_list t where t.item_id like '%g_%'  ;
select rowid,t.* from nbw.sys_web_union t;--��ҳ
select rowid,t.* from nbw.sys_item_rela t;--���ӱ�

--�ֶ�����
select rowid,t.* from nbw.sys_field_list t; 


--��ť����  action_g_506
select rowid,t.* from nbw.sys_element t  where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4','action_g_506_1','action_g_506_2'); 
select rowid,t.* from nbw.sys_action t  where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4','action_g_506_1','action_g_506_2');
select rowid,t.* from nbw.sys_item_element_rela t where t.element_id in ('action_g_504_1','action_g_504_2','action_g_504_3','action_g_504_4','action_g_506_1','action_g_506_2');

--checkaction
select rowid,t.* from nbw.sys_action t;

select rowid,t.* from nbw.sys_cond_rela t;

select rowid,t.* from nbw.sys_cond_list t;

select rowid,t.* from nbw.sys_cond_operate t;
