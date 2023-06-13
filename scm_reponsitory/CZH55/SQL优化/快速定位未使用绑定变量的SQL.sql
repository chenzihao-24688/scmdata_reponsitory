/*SELECT t.sql_text_wo_constants, t.module, COUNT(*) cnt
  FROM t_bind_sql_czh t
 GROUP BY t.sql_text_wo_constants, t.module
HAVING COUNT(*) > 100
 ORDER BY 3 DESC;
*/
--快速定位未使用绑定变量的SQL
DECLARE
  v_sql_text CLOB;
BEGIN
  v_sql_text := q'[select * from sys_user where user_id = 'czh']';

  UPDATE t_bind_sql_czh t
     SET t.sql_text_wo_constants = scmdata.sf_get_arguments_pkg.remove_constants(v_sql_text);
  COMMIT;
END;
