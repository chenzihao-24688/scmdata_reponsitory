--1.建议使用统计信息表（dba_tab_col_statistics 、dba_tables ）里的信息来查看选择性和基数,直方图类型，桶数
SELECT a.column_name,
       b.num_rows, --总行数       
       a.num_distinct cardinality, --基数      
       round(a.num_distinct / b.num_rows * 100, 2) selectivity, -- 选择性       
       --round(b.num_rows / a.num_distinct, 2) cbo_rows,-- 预估返回行数（与是否收集直方图信息有关）    
       a.histogram, --直方图类型    
       a.num_buckets --桶数
  FROM dba_tab_col_statistics a, dba_tables b
 WHERE a.owner = b.owner
   AND a.table_name = b.table_name
   AND a.owner = upper('SCMDATA')
   AND a.table_name = upper('T_PRODUCTION_PROGRESS');
--AND a.column_name = upper('product_gress_id');

--2.找出系统某个用户中不合理（选择性很低）的索引脚本

SELECT a.owner,
       a.index_name,
       a.table_name,
       a.distinct_keys cardinality,
       a.num_rows,
       round(a.distinct_keys / num_rows * 100, 2) selectivity
  FROM dba_ind_statistics a
 WHERE a.owner = upper('SCMDATA')
   AND a.table_name = upper('T_PRODUCTION_PROGRESS');

--3.如果统计信息有可能不是最新的 最好使用下面的语句

SELECT table_name,
       index_name,
       round(distinct_keys / num_rows * 100, 2) selectivity
  FROM user_indexes t
 WHERE t.table_owner = upper('SCMDATA')
   AND t.table_name = upper('T_PRODUCTION_PROGRESS');
