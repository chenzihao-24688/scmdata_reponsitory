SELECT a.tablespace_name "��ռ���",
       a.total_space "�ܿռ�(G)",
       nvl(b.free_space, 0) "ʣ��ռ�(G)",
       a.total_space - nvl(b.free_space, 0) "ʹ�ÿռ�(G)",
       CASE
         WHEN a.total_space = 0 THEN
          0
         ELSE
          trunc(nvl(b.free_space, 0) / a.total_space * 100, 2)
       END "ʣ��ٷֱ�%"
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
