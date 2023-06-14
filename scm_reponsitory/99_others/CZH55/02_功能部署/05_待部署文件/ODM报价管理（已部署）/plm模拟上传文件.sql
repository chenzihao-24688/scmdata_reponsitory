/*SELECT *
  FROM scmdata.file_info t
 WHERE t.file_unique = '43b869ae5f034d7d8766d3f3fa7d0699';

SELECT *
  FROM scmdata.file_data t
 WHERE t.file_id IN
       (SELECT a.md5
          FROM scmdata.file_info a
         WHERE a.file_unique = '43b869ae5f034d7d8766d3f3fa7d0699');

SELECT *
  FROM plm.plm_file t
 WHERE t.thirdpart_id IN ('BJ20220919001', 'BJ20220914004','BJ20220914003')
   AND t.file_type = 1;*/

--update  BJ20220914003
DECLARE
  v_file_name   VARCHAR2(32);
  v_file_blob   BLOB;
  v_file_unique VARCHAR2(32);
  v_size        NUMBER;
BEGIN
  --获取新文件
  SELECT t.file_name, t.file_blob, t.file_size
    INTO v_file_name, v_file_blob, v_size
    FROM plm.plm_file t
   WHERE t.thirdpart_id = 'BJ20220914005'
     AND t.file_type = 1;

  --更新文件
  UPDATE plm.plm_file t
     SET t.file_name   = v_file_name,
         t.source_name = v_file_name,
         t.file_blob   = v_file_blob,
         t.file_size   = v_size,
         t.upload_time = SYSDATE
   WHERE t.thirdpart_id = 'BJ20220919001'
     AND t.file_type = 1;

  --同步文件信息至file_info、file_data
  SELECT t.file_unique
    INTO v_file_unique
    FROM plm.plm_file t
   WHERE t.thirdpart_id = 'BJ20220919001'
     AND t.file_type = 1;

  plm.pkg_plat_comm.p_other_system_file_blob_to_scm(p_file_unique => v_file_unique,
                                                    p_file_name   => v_file_name,
                                                    p_file_size   => v_size,
                                                    p_file_blob   => v_file_blob,
                                                    p_update_time => SYSDATE,
                                                    p_type        => 1);
END;
/
--insert  BJ20220914003
DECLARE v_file_name VARCHAR2(32);
v_file_blob BLOB;
v_file_unique VARCHAR2(32);
v_size NUMBER;
v_file_id VARCHAR2(32);
BEGIN
  v_file_id := plm.pkg_plat_comm.f_get_uuid();
  INSERT INTO plm.plm_file
    SELECT v_file_id,
           'BJ20220914003',
           t.file_name,
           t.source_name,
           t.url,
           t.bucket,
           SYSDATE,
           1,
           t.file_blob,
           v_file_id,
           t.file_size,
           t.new_column
      FROM plm.plm_file t
     WHERE t.thirdpart_id = 'BJ20220919001'
       AND t.file_type = 1;

  SELECT t.file_name, t.file_blob, t.file_size
    INTO v_file_name, v_file_blob, v_size
    FROM plm.plm_file t
   WHERE t.thirdpart_id = 'BJ20220914003'
     AND t.file_type = 1;

  plm.pkg_plat_comm.p_other_system_file_blob_to_scm(p_file_unique => v_file_id,
                                                    p_file_name   => v_file_name,
                                                    p_file_size   => v_size,
                                                    p_file_blob   => v_file_blob,
                                                    p_update_time => SYSDATE,
                                                    p_type        => 0);

END;



BEGIN
  --新增
  plm.pkg_plat_comm.p_other_system_file_blob_to_scm(p_file_unique => v_file_id,
                                                    p_file_name   => v_file_name,
                                                    p_file_size   => v_size,
                                                    p_file_blob   => v_file_blob,
                                                    p_update_time => SYSDATE,
                                                    p_type        => 0);
  --修改
  plm.pkg_plat_comm.p_other_system_file_blob_to_scm(p_file_unique => v_file_unique,
                                                    p_file_name   => v_file_name,
                                                    p_file_size   => v_size,
                                                    p_file_blob   => v_file_blob,
                                                    p_update_time => SYSDATE,
                                                    p_type        => 1);
  --删除
  plm.pkg_plat_comm.p_other_system_file_blob_to_scm(p_file_unique => v_file_id,
                                                    p_type        => 2);
END;
