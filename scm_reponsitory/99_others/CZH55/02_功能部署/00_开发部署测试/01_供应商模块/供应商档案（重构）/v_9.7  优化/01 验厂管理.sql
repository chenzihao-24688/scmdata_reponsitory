--1.�鳧����
--1���ύ�鳧�����������Ϣ��Ҷ������ҵ΢�ţ�
--2���鳧���-��ͨ��ʱ��Ϊ������ѡ���ѡ��
--2.׼������-��ͬ��׼��-��������޸�Ϊ�Ǳ���
select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_check_101_1_0','action_a_check_102_1','action_a_check_102_2','action_a_coop_312'); 
select rowid,t.* from nbw.sys_param_list t where t.param_name in  ('MEMO_FR','AUDIT_COMMENT_FR','AUDIT_COMMENT_SP');
--��������
--�ɱ��ȼ���Ϊ�Ǳ��
--����Ч��Ĭ��Ϊ80% �����޸�
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_supp_151','a_supp_161','a_supp_171'); 
select rowid,t.* from nbw.sys_field_list t where t.field_name like '%COST_STEP%' ;

--�鳧���븽��
select rowid,t.* from nbw.sys_detail_group t where t.item_id in ('a_coop_150_3' , 'a_coop_211' , 'a_coop_221');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_coop_150_3' , 'a_coop_211' , 'a_coop_221');
select rowid,t.* from nbw.sys_field_list t where t.field_name like '%ASK_FILES%' ;  

--�鳧����
select rowid,t.* from nbw.sys_detail_group t where t.item_id in ('a_check_101_1','a_check_102_1','a_check_101_4','a_coop_104');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_check_101_1','a_check_102_1','a_check_101_4','a_coop_104');

--��Ӧ�̵���
select rowid,t.* from nbw.sys_detail_group t where t.item_id in ('a_supp_151','a_supp_161','a_supp_171');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_supp_151','a_supp_161','a_supp_171');

--�ύʱУ��������Ƿ���д��������
select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_coop_151');   
