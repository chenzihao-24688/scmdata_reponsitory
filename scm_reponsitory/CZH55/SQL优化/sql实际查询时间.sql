--sql实际查询时间
SELECT a.sql_text,
       a.sql_fulltext,
       a.sql_id,
       a.executions "总执行次数",
       nvl(a.elapsed_time, 0) / 1000 / 1000 "总耗时(秒)",
       (nvl(a.elapsed_time, 0) /
       nvl(decode(a.executions, 0, 1, a.executions), 1)) / 1000 / 1000 "平均耗时（秒）",
       a.parse_calls "硬解析次数",
       a.disk_reads "物理读次数",
       a.buffer_gets "读缓存区次数",
       a.first_load_time "sql开始执行时间"
  FROM v$sql a
 WHERE a.sql_fulltext LIKE '%progress_status_desc_check02%';
