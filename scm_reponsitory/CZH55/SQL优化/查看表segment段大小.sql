--ĳ��Ĵ�С
SELECT SUM(bytes) / (1024 * 1024) AS "size(M)"
  FROM user_segments
 WHERE segment_name = upper('T_PRODUCTION_PROGRESS');
--��ռ��ܴ�С
SELECT SUM(bytes) / 1024 / 1024 segment_size FROM user_segments t;
