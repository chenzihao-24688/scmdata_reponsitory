SELECT a.sql_text        sql语句,
       b.etime           执行耗时,
       c.user_id         用户id,
       c.sample_time     执行时间,
       c.instance_number 实例数,
       u.username        用户名,
       a.sql_id          sql编号
  FROM dba_hist_sqltext a,
       (SELECT sql_id, elapsed_time_delta / 1000000 AS etime
          FROM dba_hist_sqlstat
         WHERE elapsed_time_delta / 1000000 >= 1) b,
       dba_hist_active_sess_history c,
       dba_users u
 WHERE a.sql_id = b.sql_id
   AND u.username = 'SCMDATA'
   AND c.user_id = u.user_id
   AND b.sql_id = c.sql_id
   AND a.sql_text LIKE '%product_gress_id%'
 ORDER BY sample_time DESC, b.etime DESC;
