--查询sql
SELECT /*+ GATHER_PLAN_STATISTICS */ * FROM sys_user;

--获取sql_id
SELECT sql_id, hash_value, sql_text
  FROM v$sql
 WHERE sql_text LIKE
       '%select /*+ GATHER_PLAN_STATISTICS */ * from sys_user%';
       
--查看执行计划      
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR('f1gvkv3zrrufj',0,'ALLSTATS LAST'));
       
     
