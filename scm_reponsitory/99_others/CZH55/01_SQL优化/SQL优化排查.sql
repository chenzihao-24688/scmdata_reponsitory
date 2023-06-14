--1.查看基数，选择性
SELECT COUNT(DISTINCT t.product_gress_id), --基数
       COUNT(*) total_rows,
       COUNT(DISTINCT t.product_gress_id) / COUNT(*) * 100 || '%' selectivity --选择性
  FROM t_production_progress t;

--2.检查表的统计信息是否过期
SELECT owner, table_name NAME, object_type, stale_stats, last_analyzed
  FROM dba_tab_statistics
 WHERE table_name IN ('T_PRODUCTION_PROGRESS')
   AND owner = 'SCMDATA'
   AND (stale_stats = 'YES' OR last_analyzed IS NULL);

--3.统计信息收集
--method_opt=> 'for all columns size repeat' method_opt表示收集的方法，repeat表示以前收集过直方图，现在收集统计信息的时候就收集直方图，如果以前没收集过直方图，现在收集统计信息的时候就不收集。
BEGIN
  dbms_stats.gather_table_stats(ownname          => 'SCOTT',
                                tabname          => 'TEST',
                                estimate_percent => 30,
                                method_opt       => 'for all columns size repeat',
                                no_invalidate    => FALSE,
                                degree           => 8,
                                cascade          => TRUE);
END;

--直方图最根本的目的，就是告诉ORACLE，你计算列选择性的时候，不要单纯的就是行数/列基数
--4.收集直方图
--method_opt => 'for all columns size skewonly',method_opt表示收集的方法，这个设置 skewonly表示ORACLE自己根据列数据分布自动生成直方图统计信息。
--method_opt       => 'for all columns size 1',-- 表示所有列都不收集直方图
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
 
 --6.查询逻辑读
SELECT * FROM v$sqlarea;
