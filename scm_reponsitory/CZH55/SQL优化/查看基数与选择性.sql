--1.����ʹ��ͳ����Ϣ��dba_tab_col_statistics ��dba_tables �������Ϣ���鿴ѡ���Ժͻ���,ֱ��ͼ���ͣ�Ͱ��
SELECT a.column_name,
       b.num_rows, --������       
       a.num_distinct cardinality, --����      
       round(a.num_distinct / b.num_rows * 100, 2) selectivity, -- ѡ����       
       --round(b.num_rows / a.num_distinct, 2) cbo_rows,-- Ԥ���������������Ƿ��ռ�ֱ��ͼ��Ϣ�йأ�    
       a.histogram, --ֱ��ͼ����    
       a.num_buckets --Ͱ��
  FROM dba_tab_col_statistics a, dba_tables b
 WHERE a.owner = b.owner
   AND a.table_name = b.table_name
   AND a.owner = upper('SCMDATA')
   AND a.table_name = upper('T_PRODUCTION_PROGRESS');
--AND a.column_name = upper('product_gress_id');

--2.�ҳ�ϵͳĳ���û��в�����ѡ���Ժܵͣ��������ű�

SELECT a.owner,
       a.index_name,
       a.table_name,
       a.distinct_keys cardinality,
       a.num_rows,
       round(a.distinct_keys / num_rows * 100, 2) selectivity
  FROM dba_ind_statistics a
 WHERE a.owner = upper('SCMDATA')
   AND a.table_name = upper('T_PRODUCTION_PROGRESS');

--3.���ͳ����Ϣ�п��ܲ������µ� ���ʹ����������

SELECT table_name,
       index_name,
       round(distinct_keys / num_rows * 100, 2) selectivity
  FROM user_indexes t
 WHERE t.table_owner = upper('SCMDATA')
   AND t.table_name = upper('T_PRODUCTION_PROGRESS');
