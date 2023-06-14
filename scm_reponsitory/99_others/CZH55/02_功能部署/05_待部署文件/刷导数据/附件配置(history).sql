{DECLARE
  v_quotation_id                VARCHAR2(32);
  v_rest_method                 VARCHAR2(256);
  v_params                      VARCHAR2(4000);
  v_whether_add_color_quotation VARCHAR2(256);
  v_sql                         CLOB;
  v_flag                        INT;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_quotation_id%,
                                             po_pk_id        => v_quotation_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr(';' || v_rest_method || ';', ';' || 'PUT' || ';') > 0 THEN
      v_sql := q'[DECLARE
  p_quota_rec   plm.quotation%ROWTYPE;
  p_plm_f_rec   plm.plm_file%ROWTYPE;
  v_attachement BLOB;
  v_file_size   NUMBER(20);
  v_style_cnt   INT;
  v_pattern_cnt INT;
  v_marker_cnt  INT;
  v_thirdpart_id VARCHAR2(32) := ']' || v_quotation_id || q'[';
BEGIN
  --附件必填校验
  IF :style_picture_id IS NULL AND :style_picture_name IS NULL THEN
    raise_application_error(-20002, '必填项 “款式图片“ 未填;');
  ELSE
    p_plm_f_rec.thirdpart_id := v_thirdpart_id;
    p_plm_f_rec.upload_time  := SYSDATE;
    p_plm_f_rec.url          := ' ';
    --1.款式图片 
    BEGIN
      SELECT COUNT(1)
        INTO v_style_cnt
        FROM plm.plm_file t
       WHERE t.thirdpart_id = v_thirdpart_id
         AND t.file_type = 1;
    
      p_quota_rec.style_picture := v_thirdpart_id;
      p_plm_f_rec.file_type     := 1;
      IF :style_picture_id IS NULL THEN
        NULL;
      ELSE
      SELECT v.attachment, v.file_size
        INTO v_attachement, v_file_size
        FROM (SELECT a.attachment, a.file_size
                FROM scmdata.file_data a
               WHERE a.file_id = :style_picture_id
               ORDER BY a.lastupdatetime DESC) v
       WHERE rownum < 2;
      p_plm_f_rec.file_blob   := v_attachement;
      p_plm_f_rec.file_md5    := :style_picture_id;
      p_plm_f_rec.file_name   := :style_picture_name;
      p_plm_f_rec.source_name := :style_picture_name;
      p_plm_f_rec.file_size   := v_file_size;
      --校验附件表是否有款式图片
      IF v_style_cnt > 0 THEN
        --更新款式图片
        plm.pkg_quotation.p_update_plm_file(p_plm_f_rec => p_plm_f_rec);
      ELSE
        p_plm_f_rec.file_id := plm.pkg_plat_comm.f_get_uuid();
        --新增款式图片
        plm.pkg_quotation.p_insert_plm_file(p_plm_f_rec => p_plm_f_rec);
      END IF;
    END IF;
    END style_picture;
    --2.纸样文件 
    BEGIN
      SELECT COUNT(1)
        INTO v_pattern_cnt
        FROM plm.plm_file t
       WHERE t.thirdpart_id = v_thirdpart_id
         AND t.file_type = 2;
    
      p_quota_rec.pattern_file := v_thirdpart_id;
      p_plm_f_rec.file_type    := 2;
    
      IF v_pattern_cnt > 0 THEN
        IF :pattern_file_id IS NULL AND :pattern_file_name IS NULL THEN
          p_quota_rec.pattern_file := NULL;
          --删除纸样文件
          plm.pkg_quotation.p_delete_plm_file(p_plm_f_rec => p_plm_f_rec);
        ELSE
          IF :pattern_file_id IS NULL THEN
            NULL;
          ELSE
            IF :pattern_file_id IS NULL THEN
              NULL;
            ELSE
              SELECT v.attachment, v.file_size
                INTO v_attachement, v_file_size
                FROM (SELECT a.attachment, a.file_size
                        FROM scmdata.file_data a
                       WHERE a.file_id = :pattern_file_id
                       ORDER BY a.lastupdatetime DESC) v
               WHERE rownum < 2;
              p_plm_f_rec.file_blob   := v_attachement;
              p_plm_f_rec.file_md5    := :pattern_file_id;
              p_plm_f_rec.file_name   := :pattern_file_name;
              p_plm_f_rec.source_name := :pattern_file_name;
              p_plm_f_rec.file_size   := v_file_size;
              --更新纸样文件
              plm.pkg_quotation.p_update_plm_file(p_plm_f_rec => p_plm_f_rec);
            END IF;
          END IF;
        END IF;
      ELSE
        IF :pattern_file_id IS NULL AND :pattern_file_name IS NULL THEN
          NULL;
        ELSE
          p_plm_f_rec.file_id := plm.pkg_plat_comm.f_get_uuid();
          SELECT v.attachment, v.file_size
            INTO v_attachement, v_file_size
            FROM (SELECT a.attachment, a.file_size
                    FROM scmdata.file_data a
                   WHERE a.file_id = :pattern_file_id
                   ORDER BY a.lastupdatetime DESC) v
           WHERE rownum < 2;
          p_plm_f_rec.file_blob   := v_attachement;
          p_plm_f_rec.file_md5    := :pattern_file_id;
          p_plm_f_rec.file_name   := :pattern_file_name;
          p_plm_f_rec.source_name := :pattern_file_name;
          p_plm_f_rec.file_size   := v_file_size;
          --新增纸样文件
          plm.pkg_quotation.p_insert_plm_file(p_plm_f_rec => p_plm_f_rec);
        END IF;
      END IF;
    END pattern_file;
    --3.唛架文件
    BEGIN
      SELECT COUNT(1)
        INTO v_marker_cnt
        FROM plm.plm_file t
       WHERE t.thirdpart_id = v_thirdpart_id
         AND t.file_type = 3;
    
      p_quota_rec.marker_file := v_thirdpart_id;
      p_plm_f_rec.file_type   := 3;
    
      IF v_marker_cnt > 0 THEN
        IF :marker_file_id IS NULL AND :marker_file_name IS NULL THEN
          --删除唛架文件
          plm.pkg_quotation.p_delete_plm_file(p_plm_f_rec => p_plm_f_rec);
        ELSE
          IF :marker_file_id IS NULL THEN
            NULL;
          ELSE
          SELECT v.attachment, v.file_size
            INTO v_attachement, v_file_size
            FROM (SELECT a.attachment, a.file_size
                    FROM scmdata.file_data a
                   WHERE a.file_id = :marker_file_id
                   ORDER BY a.lastupdatetime DESC) v
           WHERE rownum < 2;
          p_plm_f_rec.file_blob   := v_attachement;
          p_plm_f_rec.file_md5    := :marker_file_id;
          p_plm_f_rec.file_name   := :marker_file_name;
          p_plm_f_rec.source_name := :marker_file_name;
          p_plm_f_rec.file_size   := v_file_size;
          --更新唛架文件
          plm.pkg_quotation.p_update_plm_file(p_plm_f_rec => p_plm_f_rec);
          END IF;
        END IF;
      ELSE
        IF :marker_file_id IS NULL AND :marker_file_name IS NULL THEN
          NULL;
        ELSE
          p_plm_f_rec.file_id := plm.pkg_plat_comm.f_get_uuid();
          SELECT v.attachment, v.file_size
            INTO v_attachement, v_file_size
            FROM (SELECT a.attachment, a.file_size
                    FROM scmdata.file_data a
                   WHERE a.file_id = :marker_file_id
                   ORDER BY a.lastupdatetime DESC) v
           WHERE rownum < 2;
          p_plm_f_rec.file_blob   := v_attachement;
          p_plm_f_rec.file_md5    := :marker_file_id;
          p_plm_f_rec.file_name   := :marker_file_name;
          p_plm_f_rec.source_name := :marker_file_name;
          p_plm_f_rec.file_size   := v_file_size;
          --新增唛架文件
          plm.pkg_quotation.p_insert_plm_file(p_plm_f_rec => p_plm_f_rec);
        END IF;
      END IF;
    END marker_file;
    p_quota_rec.quotation_id := v_thirdpart_id;
    p_quota_rec.update_time  := SYSDATE;
    p_quota_rec.update_id    := :user_id;
    plm.pkg_quotation.p_update_quotation(p_quota_rec => p_quota_rec,
                                         p_type      => 4);
  END IF;
END;]';
  END IF;
  @strresult := v_sql;
END;}
