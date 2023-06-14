--�ݹ��ѯ�����ṹ��
select prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain
  from bwptest1.sys_tree_list t
 start with t.item_id = 'flow_menu'
connect by prior t.item_id = t.parent_id;

--1.����ID,parent_id
--2.prior ��λ��
          --connect by prior ����ID ��������
          --connect by prior parent_id ��������
          
--�������±���
select prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain
  from bwptest1.sys_tree_list t
 start with t.item_id = 'flow_menu'
connect by prior t.item_id = t.parent_id;

--�������ϱ���

select prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain
  from bwptest1.sys_tree_list t
 start with t.item_id = 'flow_process_manage'
connect by prior t.parent_id = t.item_id;

select prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain
  from bwptest1.sys_tree_list t
 start with t.item_id = 'flow_process_manage'
connect by t.item_id = prior t.parent_id;

--ʹ��level �� lpad��������output����ʾ���β��(ע�������ַ� lengthb��Ӣ���ַ� length)
--1.
SELECT t.item_id,
       t.caption_explain,
       level,
       lpad(t.caption_explain,
            lengthb(t.caption_explain) + (level * 2) - 2,
            '_') chart
  FROM bwptest1.sys_tree_list t
 start with t.item_id = 'czh2000'
connect by prior t.item_id = t.parent_id;

--2.
SELECT t.item_id,
       t.caption_explain,
       level,
       lpad(t.caption_explain,
            lengthb(t.caption_explain) + (level * 2) - 2,
            '_') chart
  FROM bwptest1.sys_tree_list t
 where t.caption_explain is not null
 start with t.item_id = 'czh2000'
connect by prior t.item_id = t.parent_id
 order by level;

--3.
SELECT prior t.item_id,
       prior t.caption_explain,
       t.item_id,
       t.caption_explain,
       level,
       lengthb(prior t.caption_explain),
       lengthb(prior t.caption_explain) + (level * 2)-2,
       lpad(t.caption_explain,
            lengthb(t.caption_explain) + (level * 2)-2,
            '_') chart
  FROM bwptest1.sys_tree_list t
 start with t.item_id = 'flow_menu'
connect by prior t.item_id = t.parent_id;

--�﷨
1 select �� from tablename
2 start with ����1
3 connect by ����2
4 where ����3;

     ��˵���ǽ�һ����״�ṹ�洢��һ�ű������һ�����д��������ֶ�:org_id��parent_id����ôͨ����ʾÿһ����¼��parent��˭���Ϳ����γ�һ����״�ṹ���������﷨�Ĳ�ѯ����ȡ������������м�¼�����У�  
        ����1 �Ǹ������޶���䣬��Ȼ���Էſ��޶���������ȡ�ö������㣬ʵ�ʾ��Ƕ������
        ����2 ������������������PRIOR��ʾ��һ����¼������ CONNECT BY PRIOR org_id = parent_id������˵��һ����¼��org_id �Ǳ�����¼��parent_id��������¼�ĸ�������һ����¼��
         ����3 �ǹ������������ڶԷ��ص����м�¼���й��ˡ�
    �򵥽������£�
        ��ɨ�����ṹ��ʱ����Ҫ���˷������ṹ��ÿ���ڵ㣬һ���ڵ�ֻ�ܷ���һ�Σ�����ʵĲ������£�
        ��һ�����Ӹ��ڵ㿪ʼ��
        �ڶ��������ʸýڵ㣻
        ���������жϸýڵ�����δ�����ʵ��ӽڵ㣬���У���ת����������δ�����ʵ��ӽڣ���ִ�еڶ���������ִ�е��Ĳ���
        ���Ĳ������ýڵ�Ϊ���ڵ㣬�������ϣ�����ִ�е��岽��
        ���岽�����ص��ýڵ�ĸ��ڵ㣬��ִ�е������衣
        ��֮��ɨ���������ṹ�Ĺ���Ҳ��������������Ĺ��̡�
--���� ����ͼ
select t.*,
       level,
       lpad(t.rela_apply_id,
            lengthb(t.rela_apply_id) + (level * 2) - 2,
            '_') chart
  from scmdata.sys_group_apply_rela t
 --where apply_id = 'apply_2'
 start with t.apply_id = 'apply_1'
        and t.force_bind = 1
connect by t.apply_id = prior t.rela_apply_id
       and t.force_bind = 1;
       
       
--��Ӧ�ã�ǿ�󶨣����󶨹�ϵ
with a as
 (select distinct t.rela_apply_id
    from scmdata.sys_group_apply_rela t
   start with t.apply_id = 'apply_1'
          and t.force_bind = 1
  connect by t.apply_id = prior t.rela_apply_id
         and t.force_bind = 1)
select g.apply_id,
       g.pause,
       g.apply_status,
       g.icon,
       g.apply_name,
       g.tips,
       g.apply_type,
       g.create_time
  from scmdata.sys_group_apply g, a
 where g.apply_id = a.rela_apply_id
