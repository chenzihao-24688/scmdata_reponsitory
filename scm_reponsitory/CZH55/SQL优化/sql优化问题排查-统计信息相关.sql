--查看表的统计信息是否过期
SELECT owner, table_name NAME, object_type, stale_stats, last_analyzed
  FROM dba_tab_statistics
 WHERE table_name IN ('T_ORDERED',
                      'T_ORDERS',
                      'T_PRODUCTION_PROGRESS',
                      'T_COMMODITY_INFO',
                      'T_COMMODITY_PICTURE',
                      'SYS_COMPANY_DICT',
                      'T_SUPPLIER_INFO',
                      'SYS_GROUP_DICT',
                      'T_PRODUCTION_NODE')
   AND owner = 'SCMDATA'
   AND (stale_stats = 'YES' OR last_analyzed IS NULL);

--重新收集统计信息
--for all columns size repeat
--for all columns size skewonly
--for all columns size 1
BEGIN
  dbms_stats.gather_table_stats(ownname          => 'SCMDATA',
                                tabname          => 'T_COMMODITY_PICTURE',
                                estimate_percent => 30,
                                method_opt       => 'for all columns size skewonly',
                                no_invalidate    => FALSE,
                                degree           => 8,
                                cascade          => TRUE);
END;

--查看列直方图信息
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

--查看某列数据分布
SELECT t.category, COUNT(*) rn
  FROM scmdata.t_commodity_info t
 GROUP BY t.category
 ORDER BY 2;
--查看过期原因
select table_name,INSERTS,UPDATES,DELETES,truncated from user_tab_modifications t where t.table_name = 'T_PRODUCTION_PROGRESS';

select to_char(systimestamp,'DD-MON-YYYY HH24:MI:SS.FF') from dual
