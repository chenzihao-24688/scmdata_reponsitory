--SQL�Ż�����˼��
--1.��������Ψһ����count(distinct col)
--����Խ�ͣ����ݷֲ������⣬�ᵼ��sql��ѯ���������������ر����ݵ���5%����Ҳ������ȫ��ɨ�裨���ر����ݴ���5%����
--sex�У��С�Ů��������Ϊ2��id�У�����=���������
--���ӣ�
--select * from test where owner = :B1;(�����ͣ����ݷֲ������⣬������������������ȫ��)
--select * from test where id = :B1;(�����ߣ����ݷֲ����⣬������)
--������
--����SQL�Ż���ʱ��������������ݷֲ������⣬���ǿ���ʹ������sql���鿴�е����ݷֲ���
--select count(distinct owner),count(distinct object_id),count(*) from test;
--select ��,count(*) from �� group by �� order by 2 desc
select count(distinct supplier_code),count(distinct order_id),count(*) from scmdata.t_ordered;
SELECT t.order_id,COUNT(*) FROM scmdata.t_ordered t GROUP BY order_id ORDER BY 2 DESC;
SELECT t.supplier_code,COUNT(*) FROM scmdata.t_ordered t GROUP BY supplier_code ORDER BY 2 DESC;

--2.ѡ����
--�������������ı�ֵ�ٳ���100%����ĳ���е�ѡ���ԡ�
--�ڽ���SQL�Ż���ʱ�򣬵������еĻ�����û������ģ���������Ա�����������ʵ������
--�������ǲ鿴test������еĻ�����ѡ���ԣ�Ϊ�˲鿴ѡ���ԣ��������ռ�ͳ����Ϣ��
--�ռ�ͳ����Ϣ
BEGIN
  dbms_stats.gather_table_stats(ownname          => 'SCOTT',
                                tabname          => 'TEST',
                                estimate_percent => 100,
                                method_opt       => 'for all columns size 1',
                                no_invalidate    => FALSE,
                                degree           => 1,
                                cascade          => TRUE);
END;
--�鿴���������е�ѡ����
SELECT a.column_name,
       b.num_rows,
       a.num_distinct cardinality,
       round(a.num_distinct / b.num_rows * 100, 2) selectivity,
       a.histogram,
       a.num_buckets
  FROM dba_tab_col_statistics a, dba_tables b
 WHERE a.owner = b.owner
   AND a.table_name = b.table_name
   AND a.owner = 'SCMDATA'
   AND a.table_name = 'T_ORDERED';
