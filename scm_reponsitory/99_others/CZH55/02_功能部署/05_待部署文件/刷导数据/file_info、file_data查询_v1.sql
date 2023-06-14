SELECT *
  FROM plm.plm_file t
 WHERE t.thirdpart_id IN ('BJ20220914002', 'BJ20220914003')
   AND t.file_type = 1;

SELECT *
  FROM scmdata.file_info t
 WHERE t.file_unique IN
       ('f25406493c474b3b9c6ce53abda3a58a',
        '0381d1741e4b43b6b50e7b0c6f991803');

SELECT *
  FROM scmdata.file_data t
 WHERE t.file_id IN
       (SELECT a.md5
          FROM scmdata.file_info a
         WHERE a.file_unique IN
               ('f25406493c474b3b9c6ce53abda3a58a',
                '0381d1741e4b43b6b50e7b0c6f991803'));
