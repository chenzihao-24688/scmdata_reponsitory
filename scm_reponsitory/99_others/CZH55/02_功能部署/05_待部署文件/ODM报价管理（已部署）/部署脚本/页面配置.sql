--�ֶ�����
BEGIN
 UPDATE bw3.sys_field_list t SET t.data_type = 10 WHERE t.field_name = 'CONSUMABLES_MATERIAL_CONSUMPTION';
END;
/
--������־�޸�
DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
  v_quotation_id                VARCHAR2(32);
  v_rest_method                 VARCHAR2(256);
  v_params                      VARCHAR2(4000);
  v_whether_add_color_quotation VARCHAR2(256);
  v_sql                         CLOB;
  v_flag                        INT;
BEGIN
  --��ȡasscoiate�������
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_quotation_id%,
                                             po_pk_id        => v_quotation_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
      v_sql := q''[DECLARE
  p_quota_rec   plm.quotation%ROWTYPE;
  p_plm_f_rec   plm.plm_file%ROWTYPE;
  v_attachement BLOB;
  v_file_size   NUMBER(20);
  v_style_cnt   INT;
  v_pattern_cnt INT;
  v_marker_cnt  INT;
  v_file_name   VARCHAR2(256);
  v_thirdpart_id VARCHAR2(32) := '']'' || v_quotation_id || q''['';
BEGIN
  --��������У��
  IF :style_picture_name IS NULL THEN
    raise_application_error(-20002, ''������ ����ʽͼƬ�� δ��;'');
  ELSE
    p_plm_f_rec.thirdpart_id := v_thirdpart_id;
    p_plm_f_rec.upload_time  := SYSDATE;
    p_plm_f_rec.url          := '' '';
    --1.��ʽͼƬ
    BEGIN
      SELECT COUNT(1)
        INTO v_style_cnt
        FROM plm.plm_file t
       WHERE t.thirdpart_id = v_thirdpart_id
         AND t.file_type = 1;
    
      p_quota_rec.style_picture := v_thirdpart_id;
      p_plm_f_rec.file_type     := 1;
      --��ȡ���������Ϣ
      plm.pkg_plat_comm.p_get_file_info(p_file_unique => :style_picture_name,
                                        po_file_name  => v_file_name,
                                        po_file_size  => v_file_size,
                                        po_attachment => v_attachement);
      p_plm_f_rec.file_blob   := v_attachement;
      p_plm_f_rec.file_unique := :style_picture_name;
      p_plm_f_rec.file_name   := v_file_name;
      p_plm_f_rec.source_name := v_file_name;
      p_plm_f_rec.file_size   := v_file_size;
      --У�鸽�����Ƿ��п�ʽͼƬ
      IF v_style_cnt > 0 THEN
        --���¿�ʽͼƬ
        plm.pkg_quotation.p_update_plm_file(p_plm_f_rec => p_plm_f_rec);
      ELSE
        p_plm_f_rec.file_id := plm.pkg_plat_comm.f_get_uuid();
        --������ʽͼƬ
        plm.pkg_quotation.p_insert_plm_file(p_plm_f_rec => p_plm_f_rec);
      END IF;
    END style_picture;
    --2.ֽ���ļ�
    BEGIN
      SELECT COUNT(1)
        INTO v_pattern_cnt
        FROM plm.plm_file t
       WHERE t.thirdpart_id = v_thirdpart_id
         AND t.file_type = 2;
    
      p_quota_rec.pattern_file := v_thirdpart_id;
      p_plm_f_rec.file_type    := 2;
    
      IF v_pattern_cnt > 0 THEN
        IF :pattern_file_name IS NULL THEN
          p_quota_rec.pattern_file := NULL;
          --ɾ��ֽ���ļ�
          plm.pkg_quotation.p_delete_plm_file(p_plm_f_rec => p_plm_f_rec);
        ELSE
          --��ȡ���������Ϣ
          plm.pkg_plat_comm.p_get_file_info(p_file_unique => :pattern_file_name,
                                            po_file_name  => v_file_name,
                                            po_file_size  => v_file_size,
                                            po_attachment => v_attachement);
          p_plm_f_rec.file_blob   := v_attachement;
          p_plm_f_rec.file_unique := :pattern_file_name;
          p_plm_f_rec.file_name   := v_file_name;
          p_plm_f_rec.source_name := v_file_name;
          p_plm_f_rec.file_size   := v_file_size;
          --����ֽ���ļ�
          plm.pkg_quotation.p_update_plm_file(p_plm_f_rec => p_plm_f_rec);
        END IF;
      ELSE
        IF :pattern_file_name IS NULL THEN
          NULL;
        ELSE
          p_plm_f_rec.file_id := plm.pkg_plat_comm.f_get_uuid();
          --��ȡ���������Ϣ
          plm.pkg_plat_comm.p_get_file_info(p_file_unique => :pattern_file_name,
                                            po_file_name  => v_file_name,
                                            po_file_size  => v_file_size,
                                            po_attachment => v_attachement);
          p_plm_f_rec.file_blob   := v_attachement;
          p_plm_f_rec.file_unique := :pattern_file_name;
          p_plm_f_rec.file_name   := v_file_name;
          p_plm_f_rec.source_name := v_file_name;
          p_plm_f_rec.file_size   := v_file_size;
          --����ֽ���ļ�
          plm.pkg_quotation.p_insert_plm_file(p_plm_f_rec => p_plm_f_rec);
        END IF;
      END IF;
    END pattern_file;
    --3.����ļ�
    BEGIN
      SELECT COUNT(1)
        INTO v_marker_cnt
        FROM plm.plm_file t
       WHERE t.thirdpart_id = v_thirdpart_id
         AND t.file_type = 3;
    
      p_quota_rec.marker_file := v_thirdpart_id;
      p_plm_f_rec.file_type   := 3;
    
      IF v_marker_cnt > 0 THEN
        IF :marker_file_name IS NULL THEN
          --ɾ������ļ�
          plm.pkg_quotation.p_delete_plm_file(p_plm_f_rec => p_plm_f_rec);
        ELSE
          --��ȡ���������Ϣ
          plm.pkg_plat_comm.p_get_file_info(p_file_unique => :marker_file_name,
                                            po_file_name  => v_file_name,
                                            po_file_size  => v_file_size,
                                            po_attachment => v_attachement);
          p_plm_f_rec.file_blob   := v_attachement;
          p_plm_f_rec.file_unique := :marker_file_name;
          p_plm_f_rec.file_name   := v_file_name;
          p_plm_f_rec.source_name := v_file_name;
          p_plm_f_rec.file_size   := v_file_size;
          --��������ļ�
          plm.pkg_quotation.p_update_plm_file(p_plm_f_rec => p_plm_f_rec);
        END IF;
      ELSE
        IF :marker_file_name IS NULL THEN
          NULL;
        ELSE
          p_plm_f_rec.file_id := plm.pkg_plat_comm.f_get_uuid();
          --��ȡ���������Ϣ
          plm.pkg_plat_comm.p_get_file_info(p_file_unique => :marker_file_name,
                                            po_file_name  => v_file_name,
                                            po_file_size  => v_file_size,
                                            po_attachment => v_attachement);
          p_plm_f_rec.file_blob   := v_attachement;
          p_plm_f_rec.file_unique := :marker_file_name;
          p_plm_f_rec.file_name   := v_file_name;
          p_plm_f_rec.source_name := v_file_name;
          p_plm_f_rec.file_size   := v_file_size;
          --��������ļ�
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
  --������־��¼
  DECLARE
    v_msg        CLOB;
    v_update_id  VARCHAR2(32) := :user_id;
    vo_log_id    VARCHAR2(32);
    v_company_id VARCHAR2(32) := %default_company_id%;
    v_sup_company_id VARCHAR2(32);
  BEGIN
    vo_log_id        := NULL;
    v_sup_company_id := plm.pkg_quotation.f_get_sup_company_id_by_uqid(p_company_id => v_company_id,
                                                                       p_uq_id      => p_quota_rec.platform_unique_key);
    --��ʽͼƬ
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old_style_picture_name,
                                                 :style_picture_name) = 0 THEN
      v_msg := ''�޸Ŀ�ʽͼƬ;'';
    END IF;
  
    --ֽ���ļ�
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old_pattern_file_name,
                                                 :pattern_file_name) = 0 THEN
      v_msg := v_msg || ''�޸�ֽ���ļ�;'';
    END IF;
  
    --����ļ�
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old_marker_file_name,
                                                 :marker_file_name) = 0 THEN
      v_msg := v_msg || ''�޸�����ļ�;'';
    END IF;
    IF v_msg IS NOT NULL THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => ''a_quotation_111_7'',
                                             p_base_table         => ''quotation'',
                                             p_apply_pk_id        => v_thirdpart_id,
                                             p_action_type        => ''UPDATE'',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => ''07'',
                                             p_log_msg            => v_msg,
                                             p_field_desc         => ''����'',
                                             p_operate_field      => ''file'',
                                             p_field_type         => ''VARCHAR2'',
                                             p_old_code           => '''',
                                             p_new_code           => '''',
                                             p_old_value          => 0,
                                             p_new_value          => 1,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_sup_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    END IF;
  END file;
END;]'';
  END IF;
  @strresult := v_sql;
END;}';
  UPDATE bw3.sys_item_list t SET t.update_sql = v_sql WHERE t.item_id = 'a_quotation_111_7';
END;
/
