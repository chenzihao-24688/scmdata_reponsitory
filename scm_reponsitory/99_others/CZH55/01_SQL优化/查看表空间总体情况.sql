SELECT a.tablespace_name "表空间名",
       a.total_space "总空间(G)",
       nvl(b.free_space, 0) "剩余空间(G)",
       a.total_space - nvl(b.free_space, 0) "使用空间(G)",
       CASE
         WHEN a.total_space = 0 THEN
          0
         ELSE
          trunc(nvl(b.free_space, 0) / a.total_space * 100, 2)
       END "剩余百分比%"
  FROM (SELECT tablespace_name,
               trunc(SUM(bytes) / 1024 / 1024 / 1024, 2) total_space
          FROM dba_data_files
         GROUP BY tablespace_name) a,
       (SELECT tablespace_name,
               trunc(SUM(bytes / 1024 / 1024 / 1024), 2) free_space
          FROM dba_free_space
         GROUP BY tablespace_name) b
 WHERE a. tablespace_name = b. tablespace_name(+)
 ORDER BY 5;
