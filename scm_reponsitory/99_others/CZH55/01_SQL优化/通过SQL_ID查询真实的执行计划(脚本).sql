/*--1.查询sql
SELECT * FROM sys_user WHERE rownum <= 100;

--2.获取sql_id
SELECT sql_id, hash_value, sql_text
  FROM v$sql
 WHERE sql_text LIKE '%SELECT * FROM sys_user WHERE ROWNUM <= 100%';

--3.查看执行计划      
SELECT *
  FROM TABLE(dbms_xplan.display_cursor('9wzu3zpaj34us', 0, 'ALLSTATS LAST'));*/

DECLARE
  v_sql    CLOB;
  v_sql_id CLOB;
BEGIN
  v_sql := 'SELECT * FROM sys_user WHERE ROWNUM <= 200';

  EXECUTE IMMEDIATE v_sql;

  SELECT sql_id INTO v_sql_id FROM v$sql WHERE sql_text LIKE v_sql || '%';
  
  FOR x IN (SELECT p.plan_table_output
              FROM TABLE(dbms_xplan.display_cursor(v_sql_id,
                                                   0,
                                                   'advanced -bytes -PROJECTION allstats last')) p) LOOP
    dbms_output.put_line(x.plan_table_output);
  END LOOP;


END;
