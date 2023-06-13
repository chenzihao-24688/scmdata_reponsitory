--select sql_id from v$sql where sql_text='select sysdate from dual';
--select cost, cpu_cost, io_cost from v$sql_plan sql where sql.plan_HASH_VALUE = '1438150988'
--ͨ������Ľű��Ϳ��Լ����Ƿ����
--�������ű�����֮�󷵻ؽ����˵��������ˣ��������ű�����֮�󲻷��ؽ����˵����ͳ����Ϣû���ڡ�
exec dbms_stats.flush_database_monitoring_info;

SELECT owner, table_name NAME, object_type, stale_stats, last_analyzed
  FROM dba_tab_statistics
 WHERE table_name IN ('table_name')
   AND owner = 'OWNER_NAME'
   AND (stale_stats = 'YES' OR last_analyzed IS NULL);
   
--�鿴ִ�мƻ�
DECLARE
  b1 DATE;
BEGIN
  EXECUTE IMMEDIATE 'alter session set statistics_level=ALL';
  b1 := SYSDATE - 1;
  --ִ��sql�ŵ�forѭ��
  FOR test IN (\*��sql���*\) LOOP
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
