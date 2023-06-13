--1.�鿴������ѡ����
SELECT COUNT(DISTINCT t.product_gress_id), --����
       COUNT(*) total_rows,
       COUNT(DISTINCT t.product_gress_id) / COUNT(*) * 100 || '%' selectivity --ѡ����
  FROM t_production_progress t;

--2.�����ͳ����Ϣ�Ƿ����
SELECT owner, table_name NAME, object_type, stale_stats, last_analyzed
  FROM dba_tab_statistics
 WHERE table_name IN ('T_PRODUCTION_PROGRESS')
   AND owner = 'SCMDATA'
   AND (stale_stats = 'YES' OR last_analyzed IS NULL);

--3.ͳ����Ϣ�ռ�
--method_opt=> 'for all columns size repeat' method_opt��ʾ�ռ��ķ�����repeat��ʾ��ǰ�ռ���ֱ��ͼ�������ռ�ͳ����Ϣ��ʱ����ռ�ֱ��ͼ�������ǰû�ռ���ֱ��ͼ�������ռ�ͳ����Ϣ��ʱ��Ͳ��ռ���
BEGIN
  dbms_stats.gather_table_stats(ownname          => 'SCOTT',
                                tabname          => 'TEST',
                                estimate_percent => 30,
                                method_opt       => 'for all columns size repeat',
                                no_invalidate    => FALSE,
                                degree           => 8,
                                cascade          => TRUE);
END;

--ֱ��ͼ�������Ŀ�ģ����Ǹ���ORACLE���������ѡ���Ե�ʱ�򣬲�Ҫ�����ľ�������/�л���
--4.�ռ�ֱ��ͼ
--method_opt => 'for all columns size skewonly',method_opt��ʾ�ռ��ķ������������ skewonly��ʾORACLE�Լ����������ݷֲ��Զ�����ֱ��ͼͳ����Ϣ��
--method_opt       => 'for all columns size 1',-- ��ʾ�����ж����ռ�ֱ��ͼ
BEGIN
  dbms_stats.gather_table_stats(ownname          => 'SCOTT',
                                tabname          => 'TEST',
                                estimate_percent => 100,
                                method_opt       => 'for all columns size skewonly',
                                no_invalidate    => FALSE,
                                degree           => 1,
                                cascade          => TRUE);
END;
--5.
SELECT *
  FROM (SELECT a.column_name,
               b.num_rows,
               a.num_distinct cardinality,
               round(a.num_distinct / b.num_rows * 100, 2) selectivity,
               a.histogram,
               a.num_buckets
          FROM dba_tab_col_statistics a, dba_tables b
         WHERE a.owner = b.owner
           AND a.table_name = b.table_name
           AND a.owner = 'SCMDATA'
           AND a.table_name = 'T_PRODUCTION_PROGRESS')
 ORDER BY selectivity DESC;
 
 --6.��ѯ�߼���
SELECT * FROM v$sqlarea;
