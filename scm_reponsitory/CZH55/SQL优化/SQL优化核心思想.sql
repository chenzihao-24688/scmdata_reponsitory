--SQL优化核心思想
--1.基数（列唯一键）count(distinct col)
--基数越低，数据分布不均衡，会导致sql查询可能走索引（返回表数据低于5%），也可能走全表扫描（返回表数据大于5%）。
--sex列（男、女），基数为2；id列，基数=表的总行数
--例子：
--select * from test where owner = :B1;(基数低，数据分布不均衡，可能走索引，可能走全表)
--select * from test where id = :B1;(基数高，数据分布均衡，走索引)
--案例：
--在做SQL优化的时候，如果怀疑列数据分布不均衡，我们可以使用以下sql来查看列的数据分布。
--select count(distinct owner),count(distinct object_id),count(*) from test;
--select 列,count(*) from 表 group by 列 order by 2 desc
select count(distinct supplier_code),count(distinct order_id),count(*) from scmdata.t_ordered;
SELECT t.order_id,COUNT(*) FROM scmdata.t_ordered t GROUP BY order_id ORDER BY 2 DESC;
SELECT t.supplier_code,COUNT(*) FROM scmdata.t_ordered t GROUP BY supplier_code ORDER BY 2 DESC;

--2.选择性
--基数与总行数的比值再乘以100%就是某个列的选择性。
--在进行SQL优化的时候，单独看列的基数是没有意义的，基数必须对比总行数才有实际意义
--下面我们查看test表各个列的基数与选择性，为了查看选择性，必须先收集统计信息。
--收集统计信息
BEGIN
  dbms_stats.gather_table_stats(ownname          => 'SCOTT',
                                tabname          => 'TEST',
                                estimate_percent => 100,
                                method_opt       => 'for all columns size 1',
                                no_invalidate    => FALSE,
                                degree           => 1,
                                cascade          => TRUE);
END;
--查看表中所有列的选择性
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
