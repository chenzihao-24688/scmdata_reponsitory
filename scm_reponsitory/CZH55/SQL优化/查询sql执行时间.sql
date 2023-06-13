SELECT a.sql_text        sql���,
       b.etime           ִ�к�ʱ,
       c.user_id         �û�id,
       c.sample_time     ִ��ʱ��,
       c.instance_number ʵ����,
       u.username        �û���,
       a.sql_id          sql���
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
