--数据库表
SELECT (CASE
         WHEN va.rn = 1 THEN
          va.table_name
         ELSE
          NULL
       END) table_name,
       va.column_name,
       va.data_type,
       va.nullable,
       va.data_default,
       va.comments,
       va.tablespace_name
  FROM (SELECT v.table_name,
               v.column_name,
               v.data_type,
               v.nullable,
               v.data_default,
               v.comments,
               v.tablespace_name,
               row_number() over(PARTITION BY v.table_name ORDER BY v.column_id ASC) rn
          FROM (SELECT t.table_name,
                       NULL              column_name,
                       NULL              data_type,
                       NULL              nullable,
                       NULL              data_default,
                       tc.comments       comments,
                       0                 column_id,
                       t.tablespace_name
                  FROM all_tables t
                 INNER JOIN user_tab_comments tc
                    ON tc.table_name = t.table_name
                 WHERE t.tablespace_name IN ('SCMDATA', 'MRPDATA', 'PLMDATA')
                --WHERE t.table_name IN ('T_SUPPLIER_INFO', 'T_ORDERED')
                UNION ALL
                SELECT t.table_name,
                       t.column_name,
                       t.data_type,
                       t.nullable,
                       t.data_default,
                       c.comments,
                       t.column_id,
                       NULL tablespace_name
                  FROM all_tables a
                 INNER JOIN user_tab_columns t
                    ON t.table_name = a.table_name
                   AND a.tablespace_name IN ('SCMDATA', 'MRPDATA', 'PLMDATA')
                 INNER JOIN user_col_comments c
                    ON t.table_name = c.table_name
                   AND t.column_name = c.column_name
                /*WHERE t.table_name IN ('T_SUPPLIER_INFO', 'T_ORDERED')*/
                ) v) va;

--数据库对象
SELECT * from scmdata.t_user_objs_bak t WHERE t.version_num = 1 ; 

