--某表的大小
SELECT SUM(bytes) / (1024 * 1024) AS "size(M)"
  FROM user_segments
 WHERE segment_name = upper('T_PRODUCTION_PROGRESS');
--表空间总大小
SELECT SUM(bytes) / 1024 / 1024 segment_size FROM user_segments t;
