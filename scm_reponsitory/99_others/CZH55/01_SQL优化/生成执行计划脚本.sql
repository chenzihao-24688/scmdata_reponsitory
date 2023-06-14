--select sql_id from v$sql where sql_text='select sysdate from dual';
--select cost, cpu_cost, io_cost from v$sql_plan sql where sql.plan_HASH_VALUE = '1438150988'
--通过下面的脚本就可以检查表是否过期
--如果上面脚本运行之后返回结果，说明表过期了，如果上面脚本运行之后不返回结果，说明表统计信息没过期。
exec dbms_stats.flush_database_monitoring_info;

SELECT owner, table_name NAME, object_type, stale_stats, last_analyzed
  FROM dba_tab_statistics
 WHERE table_name IN ('table_name')
   AND owner = 'OWNER_NAME'
   AND (stale_stats = 'YES' OR last_analyzed IS NULL);
   
--查看执行计划
DECLARE
  b1 DATE;
BEGIN
  EXECUTE IMMEDIATE 'alter session set statistics_level=ALL';
  b1 := SYSDATE - 1;
  --执行sql放到for循环
  FOR test IN (\*放sql语句*\) LOOP
    NULL;
  END LOOP;
  FOR x IN (SELECT p.plan_table_output
              FROM TABLE(dbms_xplan.display_cursor(NULL,
                                                   NULL,
                                                   'advanced -bytes -PROJECTION allstats last')) p) LOOP
    dbms_output.put_line(x.plan_table_output);
  END LOOP;
  ROLLBACK;
END;
