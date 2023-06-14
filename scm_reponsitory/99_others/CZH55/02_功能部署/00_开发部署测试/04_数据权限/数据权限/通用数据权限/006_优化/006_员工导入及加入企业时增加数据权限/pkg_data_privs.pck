CREATE OR REPLACE PACKAGE pkg_data_privs IS

  --ȫ�ֱ���
  --����Ȩ�޶�ά����
  --���У�
  TYPE data_privs_type IS RECORD(
    item_id              VARCHAR2(256),
    data_priv_group_code VARCHAR2(256),
    level_type           VARCHAR2(256),
    col                  VARCHAR2(256));
  --�����ڴ��
  TYPE data_privs_tab IS TABLE OF data_privs_type INDEX BY PLS_INTEGER;

  -- Author  : SANFU
  -- Created : 2021/7/8 16:41:52

  --У������Ȩ��
  PROCEDURE check_data_privs(p_data_privs_rec scmdata.sys_data_privs%ROWTYPE);
  --У������Ȩ��-�ֶ�����
  --scmdata.sys_data_priv_pick_fields
  --scmdata.sys_data_priv_lookup_fields
  --scmdata.sys_data_priv_date_fields

  PROCEDURE check_data_priv_fields(p_tab IN VARCHAR2, p_where VARCHAR2);

  --У������Ȩ����
  PROCEDURE check_data_priv_group(p_dp_group_rec sys_company_data_priv_group%ROWTYPE);

  --��������Ȩ��
  PROCEDURE insert_data_privs(p_data_privs_rec scmdata.sys_data_privs%ROWTYPE);

  --��������Ȩ��
  PROCEDURE update_data_privs(p_data_privs_rec scmdata.sys_data_privs%ROWTYPE);
  --У����ҵ_��������Ȩ��
  PROCEDURE check_ass_data_privs(p_company_id         VARCHAR2,
                                 p_data_priv_group_id VARCHAR2,
                                 p_data_priv_id       VARCHAR2);
  --��ҵ_��������Ȩ��
  PROCEDURE ass_data_privs(p_company_id         VARCHAR2,
                           p_data_priv_group_id VARCHAR2,
                           p_data_priv_id       VARCHAR2,
                           p_user_id            VARCHAR2);

  --����pick_fields
  PROCEDURE insert_data_priv_pick_fields(p_pick_fd_rec sys_data_priv_pick_fields%ROWTYPE);

  --����lookup_fields
  PROCEDURE insert_data_priv_lookup_fields(p_lookup_fd_rec sys_data_priv_lookup_fields%ROWTYPE);

  --����date_fields
  PROCEDURE insert_data_priv_date_fields(p_date_fd_rec sys_data_priv_date_fields%ROWTYPE);

  --�޸�pick_fields
  PROCEDURE update_data_priv_pick_fields(p_pick_fd_rec sys_data_priv_pick_fields%ROWTYPE);

  --�޸�lookup_fields
  PROCEDURE update_data_priv_lookup_fields(p_lookup_fd_rec sys_data_priv_lookup_fields%ROWTYPE);

  --�޸�date_fields
  PROCEDURE update_data_priv_date_fields(p_date_fd_rec sys_data_priv_date_fields%ROWTYPE);

  --����sys_company_data_priv_group
  PROCEDURE insert_company_data_priv_group(p_dp_group_rec sys_company_data_priv_group%ROWTYPE);

  --�޸�sys_company_data_priv_group
  PROCEDURE update_company_data_priv_group(p_dp_group_rec sys_company_data_priv_group%ROWTYPE);

  --ɾ���޸�sys_company_data_priv_group
  PROCEDURE delete_company_data_priv_group(p_data_priv_group_id VARCHAR2,
                                           p_company_id         VARCHAR2);

  -- Purpose : ����Ȩ�޴���
  --��ȡ�ֵ�ֵ
  FUNCTION get_dict(p_dict_type VARCHAR2, p_dict_value VARCHAR2)
    RETURN VARCHAR2;
  --��ȡ����Ȩ������ҳ��
  FUNCTION get_data_privs(p_data_priv_id VARCHAR2) RETURN CLOB;

  --��ȡpick_list ��ѯsql
  FUNCTION get_pick_list_sql(p_data_priv_id VARCHAR2) RETURN CLOB;

  --��ȡlook_up ��ѯsql
  FUNCTION get_look_up_sql(p_dict_type VARCHAR2,
                           p_key       VARCHAR2,
                           p_value     VARCHAR2) RETURN CLOB;

  --�ú���У������Ȩ��
  --v_type 0:��¼ 1������Ȩ���� 2.����Ȩ��
  FUNCTION check_is_data_privs(p_company_id          VARCHAR2,
                               p_user_id             VARCHAR2 DEFAULT NULL,
                               p_data_priv_group_id  VARCHAR2 DEFAULT NULL,
                               p_data_priv_middle_id VARCHAR2 DEFAULT NULL,
                               p_dept_id             VARCHAR2 DEFAULT NULL,
                               v_type                NUMBER) RETURN NUMBER;
  /*--����ֵΪ����Ȩ��
  FUNCTION get_privs_var(p_company_id VARCHAR2, p_user_id VARCHAR2)
    RETURN data_privs_tab;
  
  --���ݲ�ͬȨ�޻�ȡȫ�ֱ��������ַ���
  PROCEDURE get_golbal_data_privs(p_level_type    VARCHAR2,
                                  data_privs_arrs data_privs_tab,
                                  po_item_id      OUT VARCHAR2,
                                  po_col          OUT VARCHAR2);*/
  --����ֵΪjson�ַ���
  FUNCTION get_json_strs(p_company_id VARCHAR2, p_user_id VARCHAR2)
    RETURN CLOB;

  --  ����JSON�ַ���  --
  ------------------------------
  --p_jsonstr json�ַ���
  --p_key ��
  --����p_key��Ӧ��ֵ
  FUNCTION parse_json(p_jsonstr VARCHAR2, p_key VARCHAR2) RETURN CLOB;

  --Ȩ�޷ַ�
  PROCEDURE data_privs_dispen(p_data_priv_id   VARCHAR2,
                              p_data_priv_name VARCHAR2,
                              p_user_id        VARCHAR2);
  --ƽ̨Ȩ��������ͣ
  PROCEDURE update_data_privs_status(p_data_priv_id VARCHAR2,
                                     p_status       NUMBER);

  --����Ա��������Ȩ��Ӧ���沿�ŵ�����Ȩ�� 
  PROCEDURE authorize_emp(p_company_id VARCHAR2,
                          p_dept_id    VARCHAR2,
                          p_user_id    VARCHAR2);

END pkg_data_privs;
/
CREATE OR REPLACE PACKAGE BODY pkg_data_privs IS
  --У������Ȩ��
  PROCEDURE check_data_privs(p_data_privs_rec scmdata.sys_data_privs%ROWTYPE) IS
    v_flag NUMBER;
  BEGIN
  
    EXECUTE IMMEDIATE 'select count(1) from scmdata.sys_data_privs t where t.data_priv_name = :data_priv_name'
      INTO v_flag
      USING IN p_data_privs_rec.data_priv_name;
  
    WHILE v_flag > 0 LOOP
      v_flag := -1;
      raise_application_error(-20002,
                              '��ʾ������ʧ�ܣ�Ȩ�����Ʋ����ظ������顣');
    
    END LOOP;
  
  END check_data_privs;

  --У������Ȩ��-�ֶ�����
  --scmdata.sys_data_priv_pick_fields
  --scmdata.sys_data_priv_lookup_fields
  --scmdata.sys_data_priv_date_fields

  PROCEDURE check_data_priv_fields(p_tab IN VARCHAR2, p_where VARCHAR2) IS
    v_flag NUMBER;
  BEGIN
    EXECUTE IMMEDIATE 'select count(1) from ' || p_tab || p_where
      INTO v_flag;
  
    WHILE v_flag > 0 LOOP
      v_flag := -1;
      raise_application_error(-20002,
                              '��ʾ������ʧ�ܣ��ֶ��������ݲ����ظ������顣');
    END LOOP;
  
  END check_data_priv_fields;

  --У������Ȩ����
  PROCEDURE check_data_priv_group(p_dp_group_rec sys_company_data_priv_group%ROWTYPE) IS
    v_flag NUMBER;
  BEGIN
  
    EXECUTE IMMEDIATE 'SELECT COUNT(1)
        FROM scmdata.sys_company_data_priv_group t
       WHERE t.company_id = :company_id
         AND t.data_priv_group_name = :data_priv_group_name'
      INTO v_flag
      USING IN p_dp_group_rec.company_id, p_dp_group_rec.data_priv_group_name;
  
    WHILE v_flag > 0 LOOP
      v_flag := -1;
      raise_application_error(-20002,
                              '��ʾ������ʧ�ܣ�Ȩ�������Ʋ����ظ������顣');
    
    END LOOP;
  
  END check_data_priv_group;

  --����ƽ̨_����Ȩ��
  PROCEDURE insert_data_privs(p_data_privs_rec scmdata.sys_data_privs%ROWTYPE) IS
    --v_data_priv_id   VARCHAR2(32);
    v_data_priv_code VARCHAR2(32);
  BEGIN
    --У������Ȩ�� �Ƿ��ظ�
    check_data_privs(p_data_privs_rec => p_data_privs_rec);
  
    --v_data_priv_id   := scmdata.f_get_uuid();
    v_data_priv_code := scmdata.f_getkeyid_plat(pi_pre     => 'DP',
                                                pi_seqname => 'seq_data_priv_code',
                                                pi_seqnum  => 2);
    INSERT INTO sys_data_privs
      (data_priv_id,
       data_priv_code,
       data_priv_name,
       seq_no,
       level_type,
       fields_config_method,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (p_data_privs_rec.data_priv_id,
       v_data_priv_code,
       p_data_privs_rec.data_priv_name,
       p_data_privs_rec.seq_no,
       p_data_privs_rec.level_type,
       p_data_privs_rec.fields_config_method,
       p_data_privs_rec.create_id,
       SYSDATE,
       p_data_privs_rec.update_id,
       SYSDATE);
  END insert_data_privs;
  --����ƽ̨_����Ȩ��
  PROCEDURE update_data_privs(p_data_privs_rec scmdata.sys_data_privs%ROWTYPE) IS
  BEGIN
    --У������Ȩ�� �Ƿ��ظ�
    check_data_privs(p_data_privs_rec => p_data_privs_rec);
  
    UPDATE sys_data_privs t
       SET t.data_priv_name       = p_data_privs_rec.data_priv_name,
           t.seq_no               = p_data_privs_rec.seq_no,
           t.level_type           = p_data_privs_rec.level_type,
           t.fields_config_method = p_data_privs_rec.fields_config_method,
           t.update_id            = p_data_privs_rec.update_id,
           t.update_time          = p_data_privs_rec.update_time
     WHERE t.data_priv_id = p_data_privs_rec.data_priv_id;
  END;
  --У����ҵ_��������Ȩ��
  PROCEDURE check_ass_data_privs(p_company_id         VARCHAR2,
                                 p_data_priv_group_id VARCHAR2,
                                 p_data_priv_id       VARCHAR2) IS
    v_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.sys_company_data_priv_middle t
     WHERE t.company_id = p_company_id
       AND t.data_priv_group_id = p_data_priv_group_id
       AND t.data_priv_id = p_data_priv_id;
    IF v_flag > 0 THEN
      raise_application_error(-20002,
                              '��ʾ������ʧ�ܣ�Ȩ�����Ʋ����ظ������顣');
    END IF;
  
  END check_ass_data_privs;

  --��ҵ_��������Ȩ��
  PROCEDURE ass_data_privs(p_company_id         VARCHAR2,
                           p_data_priv_group_id VARCHAR2,
                           p_data_priv_id       VARCHAR2,
                           p_user_id            VARCHAR2) IS
  BEGIN
  
    check_ass_data_privs(p_company_id         => p_company_id,
                         p_data_priv_group_id => p_data_priv_group_id,
                         p_data_priv_id       => p_data_priv_id);
  
    INSERT INTO sys_company_data_priv_middle
      (data_priv_middle_id,
       data_priv_group_id,
       data_priv_id,
       create_id,
       create_time,
       update_id,
       update_time,
       company_id)
    VALUES
      (scmdata.f_get_uuid(),
       p_data_priv_group_id,
       p_data_priv_id,
       p_user_id,
       SYSDATE,
       p_user_id,
       SYSDATE,
       p_company_id);
  
  END ass_data_privs;

  --����pick_fields
  PROCEDURE insert_data_priv_pick_fields(p_pick_fd_rec sys_data_priv_pick_fields%ROWTYPE) IS
    v_where VARCHAR2(256);
  BEGIN
    v_where := q'[ WHERE data_priv_id = ']' || p_pick_fd_rec.data_priv_id ||
               q'[' AND  col_1 = ']' || p_pick_fd_rec.col_1 ||
               q'[' AND  col_2 = ']' || p_pick_fd_rec.col_2 || q'[']';
  
    check_data_priv_fields(p_tab   => 'sys_data_priv_pick_fields',
                           p_where => v_where);
  
    INSERT INTO sys_data_priv_pick_fields
      (data_priv_pick_field_id,
       data_priv_id,
       create_id,
       create_time,
       update_id,
       update_time,
       col_1,
       col_2,
       col_3,
       col_4,
       col_5,
       col_6,
       col_7,
       col_8,
       col_9,
       col_10)
    VALUES
      (scmdata.f_get_uuid(),
       p_pick_fd_rec.data_priv_id,
       p_pick_fd_rec.create_id,
       p_pick_fd_rec.create_time,
       p_pick_fd_rec.update_id,
       p_pick_fd_rec.update_time,
       p_pick_fd_rec.col_1,
       p_pick_fd_rec.col_2,
       p_pick_fd_rec.col_3,
       p_pick_fd_rec.col_4,
       p_pick_fd_rec.col_5,
       p_pick_fd_rec.col_6,
       p_pick_fd_rec.col_7,
       p_pick_fd_rec.col_8,
       p_pick_fd_rec.col_9,
       p_pick_fd_rec.col_10);
  END insert_data_priv_pick_fields;

  --����lookup_fields
  PROCEDURE insert_data_priv_lookup_fields(p_lookup_fd_rec sys_data_priv_lookup_fields%ROWTYPE) IS
    v_where VARCHAR2(256);
  BEGIN
    v_where := q'[ WHERE data_priv_id = ']' || p_lookup_fd_rec.data_priv_id ||
               q'[' AND  col_11 = ']' || p_lookup_fd_rec.col_11 || q'[']';
  
    check_data_priv_fields(p_tab   => 'sys_data_priv_lookup_fields',
                           p_where => v_where);
  
    INSERT INTO sys_data_priv_lookup_fields
      (data_priv_lookup_field_id,
       data_priv_id,
       create_id,
       create_time,
       update_id,
       update_time,
       col_11)
    VALUES
      (scmdata.f_get_uuid(),
       p_lookup_fd_rec.data_priv_id,
       p_lookup_fd_rec.create_id,
       p_lookup_fd_rec.create_time,
       p_lookup_fd_rec.update_id,
       p_lookup_fd_rec.update_time,
       p_lookup_fd_rec.col_11);
  END insert_data_priv_lookup_fields;

  --����date_fields
  PROCEDURE insert_data_priv_date_fields(p_date_fd_rec sys_data_priv_date_fields%ROWTYPE) IS
    v_where VARCHAR2(256);
  BEGIN
    v_where := q'[ WHERE data_priv_id = ']' || p_date_fd_rec.data_priv_id ||
               q'[' AND  col_21 = ']' || p_date_fd_rec.col_21 ||
               q'[' AND  col_22 = ']' || p_date_fd_rec.col_22 || q'[']';
  
    check_data_priv_fields(p_tab   => 'sys_data_priv_date_fields',
                           p_where => v_where);
  
    INSERT INTO sys_data_priv_date_fields
      (data_priv_date_field_id,
       data_priv_id,
       create_id,
       create_time,
       update_id,
       update_time,
       col_21,
       col_22)
    VALUES
      (scmdata.f_get_uuid(),
       p_date_fd_rec.data_priv_id,
       p_date_fd_rec.create_id,
       SYSDATE,
       p_date_fd_rec.update_id,
       SYSDATE,
       p_date_fd_rec.col_21,
       p_date_fd_rec.col_22);
  END insert_data_priv_date_fields;
  --�޸�pick_fields
  PROCEDURE update_data_priv_pick_fields(p_pick_fd_rec sys_data_priv_pick_fields%ROWTYPE) IS
    v_where VARCHAR2(256);
  BEGIN
    v_where := q'[ WHERE data_priv_id = ']' || p_pick_fd_rec.data_priv_id ||
               q'[' AND  col_1 = ']' || p_pick_fd_rec.col_1 ||
               q'[' AND  col_2 = ']' || p_pick_fd_rec.col_2 ||
               q'[' AND  col_3 = ']' || p_pick_fd_rec.col_3 || q'[']';
  
    check_data_priv_fields(p_tab   => 'sys_data_priv_pick_fields',
                           p_where => v_where);
  
    UPDATE sys_data_priv_pick_fields t
       SET t.update_id   = p_pick_fd_rec.update_id,
           t.update_time = SYSDATE,
           t.col_1       = p_pick_fd_rec.col_1,
           t.col_2       = p_pick_fd_rec.col_2,
           t.col_3       = p_pick_fd_rec.col_3,
           t.col_4       = p_pick_fd_rec.col_4,
           t.col_5       = p_pick_fd_rec.col_5,
           t.col_6       = p_pick_fd_rec.col_6,
           t.col_7       = p_pick_fd_rec.col_7,
           t.col_8       = p_pick_fd_rec.col_8,
           t.col_9       = p_pick_fd_rec.col_9,
           t.col_10      = p_pick_fd_rec.col_10
     WHERE t.data_priv_pick_field_id =
           p_pick_fd_rec.data_priv_pick_field_id;
  
  END update_data_priv_pick_fields;

  --�޸�lookup_fields
  PROCEDURE update_data_priv_lookup_fields(p_lookup_fd_rec sys_data_priv_lookup_fields%ROWTYPE) IS
    v_where VARCHAR2(256);
  BEGIN
    v_where := q'[ WHERE data_priv_id = ']' || p_lookup_fd_rec.data_priv_id ||
               q'[' AND  col_11 = ']' || p_lookup_fd_rec.col_11 || q'[']';
  
    check_data_priv_fields(p_tab   => 'sys_data_priv_lookup_fields',
                           p_where => v_where);
  
    UPDATE sys_data_priv_lookup_fields t
       SET t.update_id   = p_lookup_fd_rec.update_id,
           t.update_time = SYSDATE,
           t.col_11      = p_lookup_fd_rec.col_11
     WHERE t.data_priv_lookup_field_id =
           p_lookup_fd_rec.data_priv_lookup_field_id;
  
  END update_data_priv_lookup_fields;

  --�޸�date_fields
  PROCEDURE update_data_priv_date_fields(p_date_fd_rec sys_data_priv_date_fields%ROWTYPE) IS
    v_where VARCHAR2(256);
  BEGIN
    v_where := q'[ WHERE data_priv_id = ']' || p_date_fd_rec.data_priv_id ||
               q'[' AND  col_21 = ']' || p_date_fd_rec.col_21 ||
               q'[' AND  col_22 = ']' || p_date_fd_rec.col_22 || q'[']';
  
    check_data_priv_fields(p_tab   => 'sys_data_priv_date_fields',
                           p_where => v_where);
  
    UPDATE sys_data_priv_date_fields t
       SET t.update_id   = p_date_fd_rec.update_id,
           t.update_time = SYSDATE,
           t.col_21      = p_date_fd_rec.col_21,
           t.col_22      = p_date_fd_rec.col_22
     WHERE t.data_priv_date_field_id =
           p_date_fd_rec.data_priv_date_field_id;
  
  END update_data_priv_date_fields;
  --����sys_company_data_priv_group
  PROCEDURE insert_company_data_priv_group(p_dp_group_rec sys_company_data_priv_group%ROWTYPE) IS
    v_data_priv_code VARCHAR2(32);
  BEGIN
    check_data_priv_group(p_dp_group_rec => p_dp_group_rec);
  
    v_data_priv_code := pkg_plat_comm.f_getkeycode(pi_table_name  => 'sys_company_data_priv_group',
                                                   pi_column_name => 'data_priv_group_code',
                                                   pi_company_id  => p_dp_group_rec.company_id,
                                                   pi_pre         => 'DPG',
                                                   pi_serail_num  => 6);
    INSERT INTO sys_company_data_priv_group
      (data_priv_group_id,
       data_priv_group_code,
       data_priv_group_name,
       company_id,
       user_id,
       seq_no,
       create_id,
       create_time,
       update_id,
       update_time)
    VALUES
      (scmdata.f_get_uuid(),
       v_data_priv_code,
       p_dp_group_rec.data_priv_group_name,
       p_dp_group_rec.company_id,
       NULL, --��֯�ܹ��ڽ�������
       p_dp_group_rec.seq_no,
       p_dp_group_rec.create_id,
       SYSDATE,
       p_dp_group_rec.update_id,
       SYSDATE);
  END insert_company_data_priv_group;

  --�޸�sys_company_data_priv_group
  PROCEDURE update_company_data_priv_group(p_dp_group_rec sys_company_data_priv_group%ROWTYPE) IS
  BEGIN
    check_data_priv_group(p_dp_group_rec => p_dp_group_rec);
    UPDATE sys_company_data_priv_group t
       SET t.data_priv_group_name = p_dp_group_rec.data_priv_group_name,
           t.seq_no               = p_dp_group_rec.seq_no,
           t.update_id            = p_dp_group_rec.user_id,
           t.update_time          = SYSDATE
     WHERE t.company_id = p_dp_group_rec.company_id
       AND t.data_priv_group_id = p_dp_group_rec.data_priv_group_id;
  
  END update_company_data_priv_group;

  --ɾ���޸�sys_company_data_priv_group
  PROCEDURE delete_company_data_priv_group(p_data_priv_group_id VARCHAR2,
                                           p_company_id         VARCHAR2) IS
    v_dflag NUMBER;
  BEGIN
    v_dflag := scmdata.pkg_data_privs.check_is_data_privs(p_company_id         => p_company_id,
                                                          p_data_priv_group_id => p_data_priv_group_id,
                                                          v_type               => 1);
    IF v_dflag > 0 THEN
      raise_application_error(-20002,
                              '������Ȩ���������Ա���ã�����ɾ����');
    ELSE
      v_dflag := scmdata.pkg_data_privs.check_is_data_privs(p_company_id         => p_company_id,
                                                            p_data_priv_group_id => p_data_priv_group_id,
                                                            v_type               => 2);
      IF v_dflag > 0 THEN
        raise_application_error(-20002,
                                '������Ȩ�����������Ȩ�ޣ�����ɾ����');
      ELSE
        DELETE FROM sys_company_data_priv_group t
         WHERE t.company_id = p_company_id
           AND t.data_priv_group_id = p_data_priv_group_id;
      END IF;
    END IF;
  END delete_company_data_priv_group;

  --��ȡƽ̨�ֵ�ֵ
  FUNCTION get_dict(p_dict_type VARCHAR2, p_dict_value VARCHAR2)
    RETURN VARCHAR2 IS
    v_sql VARCHAR2(2000);
  BEGIN
    v_sql := '(SELECT gd.group_dict_name FROM group_dict gd WHERE gd.group_dict_type = ' ||
             p_dict_type || ' AND gd.group_dict_value = ' || p_dict_value || ')';
    RETURN nvl(v_sql, '');
  END get_dict;

  --��ȡ����Ȩ������ҳ��
  FUNCTION get_data_privs(p_data_priv_id VARCHAR2) RETURN CLOB IS
    v_type       VARCHAR2(32);
    v_level_type VARCHAR2(32);
    --v_item_id    VARCHAR2(32);
    v_table_id   VARCHAR2(256);
    v_table_name VARCHAR2(256);
    v_sql        CLOB;
    v_col_1_desc CLOB := q'['' ]';
    v_col_2_desc CLOB := q'['' ]';
    v_col_3_desc CLOB;
    --v_col_4_desc CLOB;
    --v_col_5_desc CLOB;
    --v_col_6_desc CLOB;
    --v_col_7_desc CLOB;  
  BEGIN
    SELECT upper(dp.fields_config_method), upper(dp.level_type)
      INTO v_type, v_level_type
      FROM scmdata.sys_data_privs dp
     WHERE dp.data_priv_id = p_data_priv_id;
  
    v_sql := 'WITH group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
 SELECT pf.data_priv_id,';
    --PICK_LIST�ֶ� COL_1 - COL_7 
    --LOOK_UP�ֶ�COL8
    --DATE�ӵ�COL9-COL_10
    /*v_sql := v_sql || v_col_1_desc || 'col_1_desc,' || 'pf.col_1 col_1,' ||
     v_col_2_desc || 'col_2_desc,' || 'pf.col_2 col_2,' ||
    --v_col_3_desc || 'col_3_desc,'
     'pf.col_3,' ||
    --v_col_4_desc || 'col_4_desc,'
     'pf.col_4,' ||
    --v_col_5_desc || 'col_5_desc,'
     'pf.col_5,' ||
    --v_col_6_desc || 'col_6_desc,'
     'pf.col_6,' ||
    --v_col_7_desc || 'col_7_desc,'
     'pf.col_7,';*/
    IF v_type = 'PICK_LIST' THEN
      v_table_name := 'scmdata.sys_data_priv_pick_fields';
      v_table_id   := 'pf.data_priv_pick_field_id';
      IF v_level_type = 'CLASS_TYPE' THEN
        v_col_1_desc := get_dict(p_dict_type  => '''COOPERATION_TYPE''',
                                 p_dict_value => 'pf.col_1');
        v_col_2_desc := get_dict(p_dict_type  => 'pf.col_1',
                                 p_dict_value => 'pf.col_2');
      
        v_sql := v_sql || v_col_1_desc || 'COOP_TYPE_DESC,' ||
                 'pf.col_1 col_1,' || v_col_2_desc ||
                 'COOP_CLASSIFICATION_DESC,' || 'pf.col_2 col_2,';
      
      ELSIF v_level_type = 'PRODUCT_CLASS_TYPE' THEN
        v_col_1_desc := get_dict(p_dict_type  => '''COOPERATION_TYPE''',
                                 p_dict_value => 'pf.col_1');
        v_col_2_desc := get_dict(p_dict_type  => 'pf.col_1',
                                 p_dict_value => 'pf.col_2');
        v_col_3_desc := get_dict(p_dict_type  => 'pf.col_2',
                                 p_dict_value => 'pf.col_3');
      
        v_sql := v_sql || v_col_1_desc || 'COOP_TYPE_DESC_01,' ||
                 'pf.col_1 col_1,' || v_col_2_desc ||
                 'COOP_CLASSIFICATION_DESC_01,' || 'pf.col_2 col_2,' ||
                 v_col_3_desc || 'PRODUCTION_CATEGORY_DESC_01,' ||
                 'pf.col_3 col_3,';
      ELSE
        raise_application_error(-20002,
                                '��ʾ����תʧ��,����ϵ����Ա,����[' || v_level_type ||
                                ']���͵�PICK_LIST������');
      END IF;
    ELSIF v_type = 'LOOK_UP' THEN
      v_table_name := 'scmdata.sys_data_priv_lookup_fields';
      v_table_id   := 'pf.data_priv_lookup_field_id';
      IF v_level_type = 'COMPANY_STORE_TYPE' THEN
        v_sql := v_sql || 'pf.col_11 col_11,';
      ELSE
        raise_application_error(-20002,
                                '��ʾ����תʧ��,����ϵ����Ա,����[' || v_level_type ||
                                ']���͵�LOOK_UP�����б�');
      END IF;
    ELSIF v_type = 'DATE' THEN
      v_table_name := 'scmdata.sys_data_priv_date_fields';
      v_table_id   := 'pf.data_priv_date_field_id';
      v_sql        := v_sql || 'pf.col_21,pf.col_22,';
    ELSE
      raise_application_error(-20002, q'[��ʾ����תʧ�ܣ�����ϵ����Ա��]');
    END IF;
    v_sql := v_sql || q'[
         (select u.nick_name from sys_user u where u.user_id = pf.create_id) create_id,
         pf.create_time,
         (select u.nick_name from sys_user u where u.user_id = pf.update_id) update_id,
         pf.update_time, ]' || v_table_id || ' FROM ' ||
             v_table_name || q'[ pf
   WHERE  pf.data_priv_id = ']' || p_data_priv_id || q'[']';
    RETURN v_sql;
  END get_data_privs;

  --��ȡpick_list ��ѯsql
  FUNCTION get_pick_list_sql(p_data_priv_id VARCHAR2) RETURN CLOB IS
    v_type       VARCHAR2(32);
    v_dict_type  VARCHAR2(32);
    v_level_type VARCHAR2(32);
    v_pick_sql   CLOB;
  BEGIN
    SELECT upper(dp.fields_config_method), upper(dp.level_type)
      INTO v_type, v_level_type
      FROM scmdata.sys_data_privs dp
     WHERE dp.data_priv_id = p_data_priv_id;
  
    IF v_type = 'PICK_LIST' THEN
      --��������
      IF v_level_type = 'CLASS_TYPE' THEN
        v_dict_type := 'COOPERATION_TYPE';
        v_pick_sql  := q'[SELECT a.group_dict_name  COOP_TYPE_DESC,
       a.group_dict_value col_1,
       b.group_dict_name  COOP_CLASSIFICATION_DESC,
       b.group_dict_value col_2
  FROM sys_group_dict a
  LEFT JOIN sys_group_dict b
    ON a.group_dict_value = b.group_dict_type
  LEFT JOIN sys_group_dict c
    ON b.group_dict_value = c.group_dict_type
 WHERE a.group_dict_type =']' || v_dict_type ||
                       q'[']';
        --�������
      ELSIF v_level_type = 'PRODUCT_CLASS_TYPE' THEN
        v_dict_type := 'COOPERATION_TYPE';
        v_pick_sql  := q'[SELECT a.group_dict_name  COOP_TYPE_DESC_01,
       a.group_dict_value col_1,
       b.group_dict_name  COOP_CLASSIFICATION_DESC_01,
       b.group_dict_value col_2,
       c.group_dict_name PRODUCTION_CATEGORY_DESC_01,
       c.group_dict_value col_3
  FROM sys_group_dict a
  LEFT JOIN sys_group_dict b
    ON a.group_dict_value = b.group_dict_type
  LEFT JOIN sys_group_dict c
    ON b.group_dict_value = c.group_dict_type
 WHERE a.group_dict_type =']' || v_dict_type ||
                       q'[']';
      ELSE
        raise_application_error(-20002,
                                '��ʾ����תʧ��,����ϵ����Ա,����[' || v_level_type ||
                                ']���͵�PICK_LIST������');
      END IF;
    ELSE
      raise_application_error(-20002,
                              '��ʾ����תʧ��,����ϵ����Ա,����[' || v_type || ']���ͣ�');
    END IF;
    RETURN v_pick_sql;
  END get_pick_list_sql;

  --��ȡlook_up ��ѯsql
  FUNCTION get_look_up_sql(p_dict_type VARCHAR2,
                           p_key       VARCHAR2,
                           p_value     VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    IF p_dict_type = 'COMPANY_STORE_TYPE' THEN
      v_sql := 'SELECT t.group_dict_name ' || p_key ||
               ', t.group_dict_value ' || p_value || q'[
        FROM scmdata.sys_group_dict t
       WHERE ]' || q'[t.group_dict_type = ']' || p_dict_type ||
               q'[']';
    ELSE
      raise_application_error(-20002,
                              '��ʾ����תʧ��,����ϵ����Ա,����[' || p_dict_type ||
                              ']���͵������б�');
    END IF;
    RETURN v_sql;
  END get_look_up_sql;

  --�ú���У��
  --v_type 0:��¼�û��Ƿ�������Ȩ�� 1���Ƿ����û���������Ȩ���� 2.�Ƿ����û���������Ȩ�� 3.�����Ƿ�ӵ������Ȩ����
  FUNCTION check_is_data_privs(p_company_id          VARCHAR2,
                               p_user_id             VARCHAR2 DEFAULT NULL,
                               p_data_priv_group_id  VARCHAR2 DEFAULT NULL,
                               p_data_priv_middle_id VARCHAR2 DEFAULT NULL,
                               p_dept_id             VARCHAR2 DEFAULT NULL,
                               v_type                NUMBER) RETURN NUMBER IS
    v_flag NUMBER;
    p_sql  CLOB;
  BEGIN
    p_sql := 'SELECT COUNT(1)
      FROM scmdata.sys_company_data_priv_group b      
     INNER JOIN scmdata.sys_company_data_priv_middle g
        ON b.company_id = g.company_id
       AND b.data_priv_group_id = g.data_priv_group_id
     INNER JOIN scmdata.sys_data_privs h
        ON h.data_priv_id = g.data_priv_id
        AND h.pause = 1
      LEFT JOIN scmdata.sys_data_priv_pick_fields j
        ON h.data_priv_id = j.data_priv_id
      LEFT JOIN scmdata.sys_data_priv_lookup_fields k
        ON h.data_priv_id = k.data_priv_id
      LEFT JOIN scmdata.sys_data_priv_date_fields l
        ON h.data_priv_id = l.data_priv_id';
  
    IF v_type = 0 THEN
      p_sql := p_sql || ' 
     INNER JOIN scmdata.sys_company_data_priv_user_middle a
         ON a.company_id = b.company_id
       AND a.data_priv_group_id = b.data_priv_group_id  
     WHERE a.company_id = :a AND a.user_id = :b';
      EXECUTE IMMEDIATE p_sql
        INTO v_flag
        USING p_company_id, p_user_id;
    ELSIF v_type = 1 THEN
      p_sql := p_sql || ' 
     INNER JOIN scmdata.sys_company_data_priv_user_middle a
         ON a.company_id = b.company_id
       AND a.data_priv_group_id = b.data_priv_group_id  
     WHERE a.company_id = :a and a.data_priv_group_id = :c';
      EXECUTE IMMEDIATE p_sql
        INTO v_flag
        USING p_company_id, p_data_priv_group_id;
    ELSIF v_type = 2 THEN
      p_sql := p_sql ||
               ' INNER JOIN scmdata.sys_company_data_priv_user_middle a
         ON a.company_id = b.company_id
       AND a.data_priv_group_id = b.data_priv_group_id 
     WHERE b.company_id = :a and b.data_priv_group_id = :c 
     AND a.data_priv_user_middle_id = :data_priv_user_middle_id';
      EXECUTE IMMEDIATE p_sql
        INTO v_flag
        USING p_company_id, p_data_priv_group_id, p_data_priv_middle_id;
    ELSIF v_type = 3 THEN
      p_sql := p_sql ||
               ' INNER JOIN  scmdata.sys_company_data_priv_dept_middle a
         ON a.company_id = b.company_id        
       AND a.data_priv_group_id = b.data_priv_group_id 
     WHERE b.company_id = :company_id AND a.company_dept_id = :company_dept_id';
      EXECUTE IMMEDIATE p_sql
        INTO v_flag
        USING p_company_id, p_dept_id;
    ELSE
      raise_application_error(-20002, '��ʾ���޴�У�����ͣ�����ϵ����Ա��');
    END IF;
  
    RETURN v_flag;
  END check_is_data_privs;

  --����ֵΪ����Ȩ������
  /*FUNCTION get_privs_var(p_company_id VARCHAR2, p_user_id VARCHAR2)
    RETURN data_privs_tab IS
    --���鳤�ȣ��У�
    v_count         PLS_INTEGER := 0;
    data_privs_arrs data_privs_tab := data_privs_tab();
  BEGIN
    \*listagg('COL_1:[' || col_1 || '],COL_2:[' || col_2 || '],' ||
    'COL_3:[' || col_3 || '],COL_4:[' || col_4 || '],' ||
    'COL_5:[' || col_5 || '],COL_6:[' || col_6 || '],' ||
    'COL_7:[' || col_7 || '],COL_8:[' || col_8 || '],' ||
    'COL_9:[' || col_9 || '],COL_10:[' || col_10 || ']',
    ';') col*\
    \*
    listagg(nvl2(col_1, col_1 || ',', '') ||
                             nvl2(col_2, col_2 || ',', '') ||
                             nvl2(col_3, col_3 || ',', '') ||
                             nvl2(col_4, col_4 || ',', '') ||
                             nvl2(col_5, col_5 || ',', '') ||
                             nvl2(col_6, col_6 || ',', '') ||
                             nvl2(col_7, col_7 || ',', '') ||
                             nvl2(col_8, col_8 || ',', '') ||
                             nvl2(col_9, col_9 || ',', '') ||
                             nvl2(col_10, col_10 || ',', ''),
                             ';') col
    *\
  
    FOR i IN (SELECT item_id,
                     data_priv_group_code,
                     level_type,
                     listagg(col_1 || ',' || col_2 || ',' || col_3 || ',' ||
                             col_4 || ',' || col_5 || ',' || col_6 || ',' ||
                             col_7 || ',' || col_8 || ',' || col_9 || ',' ||
                             col_10 || ',' || col_11 || ',' || col_21 || ',' ||
                             col_22,
                             ';') col
                FROM (SELECT listagg(DISTINCT e.item_id, ';') item_id,
                             b.data_priv_group_code,
                             listagg(DISTINCT h.level_type, ';') level_type,
                             listagg(DISTINCT h.data_priv_code, ';') data_priv_code,
                             listagg(DISTINCT j.col_1, ';') col_1,
                             listagg(DISTINCT j.col_2, ';') col_2,
                             listagg(DISTINCT j.col_3, ';') col_3,
                             listagg(DISTINCT j.col_4, ';') col_4,
                             listagg(DISTINCT j.col_5, ';') col_5,
                             listagg(DISTINCT j.col_6, ';') col_6,
                             listagg(DISTINCT j.col_7, ';') col_7,
                             listagg(DISTINCT j.col_8, ';') col_8,
                             listagg(DISTINCT j.col_9, ';') col_9,
                             listagg(DISTINCT j.col_10, ';') col_10,
                             listagg(DISTINCT k.col_11, ';') col_11,
                             listagg(DISTINCT l.col_21, ';') col_21,
                             listagg(DISTINCT l.col_22, ';') col_22
                        FROM scmdata.sys_company_data_priv_user_middle a
                       INNER JOIN scmdata.sys_company_data_priv_group b
                          ON a.company_id = b.company_id
                         AND a.data_priv_group_id = b.data_priv_group_id
                       INNER JOIN scmdata.sys_company_data_priv_page_middle c
                          ON b.company_id = c.company_id
                         AND b.data_priv_group_id = c.data_priv_group_id
                       INNER JOIN scmdata.sys_company_data_priv_page e
                          ON c.company_id = e.company_id
                         AND c.data_priv_page_id = e.data_priv_page_id
                       INNER JOIN scmdata.sys_company_data_priv_middle g
                          ON c.company_id = g.company_id
                         AND c.data_priv_group_id = g.data_priv_group_id
                       INNER JOIN scmdata.sys_data_privs h
                          ON h.data_priv_id = g.data_priv_id
                        LEFT JOIN scmdata.sys_data_priv_pick_fields j
                          ON h.data_priv_id = j.data_priv_id
                        LEFT JOIN scmdata.sys_data_priv_lookup_fields k
                          ON h.data_priv_id = k.data_priv_id
                        LEFT JOIN scmdata.sys_data_priv_date_fields l
                          ON h.data_priv_id = l.data_priv_id
                       WHERE a.company_id = p_company_id
                         AND a.user_id = p_user_id
                       GROUP BY b.data_priv_group_code)
               GROUP BY item_id, data_priv_group_code, level_type) LOOP
      data_privs_arrs(v_count).item_id := i.item_id;
      data_privs_arrs(v_count).data_priv_group_code := i.data_priv_group_code;
      data_privs_arrs(v_count).level_type := i.level_type;
      data_privs_arrs(v_count).col := i.col;
      v_count := v_count + 1;
    END LOOP;
    --��ѯ���鷵��ֵ
    \*
        DECLARE
      data_privs_arrs scmdata.pkg_data_privs.data_privs_tab := scmdata.pkg_data_privs.data_privs_tab();
    BEGIN
      data_privs_arrs := scmdata.pkg_data_privs.get_privs_var(p_company_id => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                              p_user_id    => 'b54e6b59653f0544e0533c281cac9880');
      FOR i IN data_privs_arrs.first .. data_privs_arrs.last LOOP
        dbms_output.put_line(data_privs_arrs(i).item_id);
        dbms_output.put_line(data_privs_arrs(i).data_priv_group_code);
        dbms_output.put_line(data_privs_arrs(i).col);
        dbms_output.put_line('--------');
      END LOOP;
    END;
    
        *\
    RETURN data_privs_arrs;
  END get_privs_var;
  
  --���ݲ�ͬȨ�޻�ȡȫ�ֱ��������ַ���
  PROCEDURE get_golbal_data_privs(p_level_type    VARCHAR2,
                                  data_privs_arrs data_privs_tab,
                                  po_item_id      OUT VARCHAR2,
                                  po_col          OUT VARCHAR2) IS
  BEGIN
    FOR i IN data_privs_arrs.first .. data_privs_arrs.last LOOP
      IF data_privs_arrs(i).level_type IS NOT NULL THEN
        IF data_privs_arrs(i).level_type = p_level_type THEN
          po_item_id := data_privs_arrs(i).item_id;
          po_col     := data_privs_arrs(i).col;
        ELSE
          NULL;
        END IF;
      ELSE
        NULL;
      END IF;
    END LOOP;
  END get_golbal_data_privs;*/

  --����ֵΪjson�ַ���
  FUNCTION get_json_strs(p_company_id VARCHAR2, p_user_id VARCHAR2)
    RETURN CLOB IS
    v_json_text CLOB;
  BEGIN
    /*
    '{"LEVEL_TYPE": ' || '{"CLASS_TYPE":{,' || '"COL_1": "' || col_1 || '",' ||
           '"COL_2": "' || col_2 || '",' || '"COL_3": "' || col_3 || '",' ||
           '"COL_4": "' || col_4 || '",' || '"COL_5": "' || col_5 || '",' ||
           '"COL_6": "' || col_6 || '",' || '"COL_7": "' || col_7 || '",' ||
           '"COL_8": "' || col_8 || '",' || '"COL_9": "' || col_9 || '",' ||
           '"COL_10": "' || col_10 || '"},' || '"COMPANY_STORE_TYPE":{,' ||
           '"COL_11": "' || col_11 || '"' || '},' || '"DATE_TYPE":{,' ||
           '"COL_21": "' || col_21 || '",' || '"COL_22": "' || col_22 || '"}' || '}}'
    */
    SELECT '{' || '"COL_1": "' || col_1 || '",' || '"COL_2": "' || col_2 || '",' ||
           '"COL_3": "' || col_3 || '",' || '"COL_4": "' || col_4 || '",' ||
           '"COL_5": "' || col_5 || '",' || '"COL_6": "' || col_6 || '",' ||
           '"COL_7": "' || col_7 || '",' || '"COL_8": "' || col_8 || '",' ||
           '"COL_9": "' || col_9 || '",' || '"COL_10": "' || col_10 || '",' ||
           '"COL_11": "' || col_11 || '"' || ',' || '"COL_21": "' || col_21 || '",' ||
           '"COL_22": "' || col_22 || '"' || '}' json_txt
      INTO v_json_text
      FROM (SELECT listagg(DISTINCT h.level_type, ';') level_type,
                   listagg(DISTINCT h.data_priv_code, ';') data_priv_code,
                   listagg(DISTINCT j.col_1, ';') col_1,
                   listagg(DISTINCT j.col_2, ';') col_2,
                   listagg(DISTINCT j.col_3, ';') col_3,
                   listagg(DISTINCT j.col_4, ';') col_4,
                   listagg(DISTINCT j.col_5, ';') col_5,
                   listagg(DISTINCT j.col_6, ';') col_6,
                   listagg(DISTINCT j.col_7, ';') col_7,
                   listagg(DISTINCT j.col_8, ';') col_8,
                   listagg(DISTINCT j.col_9, ';') col_9,
                   listagg(DISTINCT j.col_10, ';') col_10,
                   listagg(DISTINCT k.col_11, ';') col_11,
                   listagg(DISTINCT l.col_21, ';') col_21,
                   listagg(DISTINCT l.col_22, ';') col_22
              FROM scmdata.sys_company_data_priv_user_middle a
             INNER JOIN scmdata.sys_company_data_priv_group b
                ON a.company_id = b.company_id
               AND a.data_priv_group_id = b.data_priv_group_id
             INNER JOIN scmdata.sys_company_data_priv_middle g
                ON b.company_id = g.company_id
               AND b.data_priv_group_id = g.data_priv_group_id
             INNER JOIN scmdata.sys_data_privs h
                ON h.data_priv_id = g.data_priv_id
               AND h.pause = 1
              LEFT JOIN scmdata.sys_data_priv_pick_fields j
                ON h.data_priv_id = j.data_priv_id
              LEFT JOIN scmdata.sys_data_priv_lookup_fields k
                ON h.data_priv_id = k.data_priv_id
              LEFT JOIN scmdata.sys_data_priv_date_fields l
                ON h.data_priv_id = l.data_priv_id
             WHERE a.company_id = p_company_id
               AND a.user_id = p_user_id);
    RETURN v_json_text;
  END;

  --  ����JSON�ַ���  --
  ------------------------------
  --p_jsonstr json�ַ���
  --p_key ��
  --����p_key��Ӧ��ֵ
  FUNCTION parse_json(p_jsonstr VARCHAR2, p_key VARCHAR2) RETURN CLOB IS
    rtnval    VARCHAR2(50);
    i         NUMBER(2);
    jsonkey   VARCHAR2(50);
    jsonvalue VARCHAR2(50);
    json      VARCHAR2(1000);
  BEGIN
    IF p_jsonstr IS NOT NULL THEN
      json := REPLACE(p_jsonstr, '{', '');
      json := REPLACE(json, '}', '');
      json := REPLACE(json, '"', '');
    
      /*SELECT column_value VALUE
      FROM sf_get_arguments_pkg.get_strarray(av_str   => json, --Ҫ�ָ���ַ���
                                             av_split => ',' --�ָ�����
                                             )*/
    
      FOR temprow IN (SELECT str_value
                        FROM (SELECT regexp_substr(json,
                                                   '[^' || ',' || ']+',
                                                   1,
                                                   LEVEL,
                                                   'i') AS str_value
                                FROM dual
                              CONNECT BY LEVEL <=
                                         length(json) -
                                         length(regexp_replace(json, ',', '')) + 1)
                       WHERE instr(str_value, p_key) > 0) LOOP
      
        IF temprow.str_value IS NOT NULL THEN
          IF instr(temprow.str_value, p_key) > 0 THEN
            i         := 0;
            jsonkey   := '';
            jsonvalue := '';
            FOR tem2 IN (SELECT regexp_substr(temprow.str_value,
                                              '[^' || ':' || ']+',
                                              1,
                                              LEVEL,
                                              'i') AS VALUE
                           FROM dual
                         CONNECT BY LEVEL <=
                                    length(temprow.str_value) -
                                    length(regexp_replace(temprow.str_value,
                                                          ':',
                                                          '')) + 1) LOOP
              IF i = 0 THEN
                jsonkey := tem2.value;
              END IF;
              IF i = 1 THEN
                jsonvalue := tem2.value;
                IF (jsonkey = p_key) THEN
                  rtnval := TRIM(jsonvalue);
                  EXIT;
                END IF;
              END IF;
            
              IF i = 0 THEN
                i := i + 1;
              ELSE
                i := 0;
              END IF;
            
            END LOOP;
            EXIT;
          ELSE
            CONTINUE;
          END IF;
        END IF;
      END LOOP;
    END IF;
  
    RETURN rtnval;
  END parse_json;
  --Ȩ�޷ַ�
  PROCEDURE data_privs_dispen(p_data_priv_id   VARCHAR2,
                              p_data_priv_name VARCHAR2,
                              p_user_id        VARCHAR2) IS
    v_data_priv_group_id   VARCHAR2(32);
    v_data_priv_group_code VARCHAR2(32);
  BEGIN
    FOR fc_rec IN (SELECT fc.company_id FROM scmdata.sys_company fc) LOOP
      v_data_priv_group_id   := scmdata.f_get_uuid();
      v_data_priv_group_code := pkg_plat_comm.f_getkeycode(pi_table_name  => 'sys_company_data_priv_group',
                                                           pi_column_name => 'data_priv_group_code',
                                                           pi_company_id  => fc_rec.company_id,
                                                           pi_pre         => 'DPG',
                                                           pi_serail_num  => 6);
    
      INSERT INTO sys_company_data_priv_group
        (data_priv_group_id,
         data_priv_group_code,
         data_priv_group_name,
         company_id,
         user_id,
         seq_no,
         create_id,
         create_time,
         update_id,
         update_time)
      VALUES
        (v_data_priv_group_id,
         v_data_priv_group_code,
         p_data_priv_name || 'Ȩ����',
         fc_rec.company_id,
         NULL, --��֯�ܹ��ڽ�������
         1,
         p_user_id,
         SYSDATE,
         p_user_id,
         SYSDATE);
    
      INSERT INTO sys_company_data_priv_middle
        (data_priv_middle_id,
         data_priv_group_id,
         data_priv_id,
         create_id,
         create_time,
         update_id,
         update_time,
         company_id)
      VALUES
        (scmdata.f_get_uuid(),
         v_data_priv_group_id,
         p_data_priv_id,
         p_user_id,
         SYSDATE,
         p_user_id,
         SYSDATE,
         fc_rec.company_id);
    
    END LOOP;
  END;
  --ƽ̨Ȩ��������ͣ
  PROCEDURE update_data_privs_status(p_data_priv_id VARCHAR2,
                                     p_status       NUMBER) IS
    v_status  NUMBER;
    x_err_msg VARCHAR2(1000);
    priv_exp EXCEPTION;
  BEGIN
    SELECT dp.pause
      INTO v_status
      FROM scmdata.sys_data_privs dp
     WHERE dp.data_priv_id = p_data_priv_id;
  
    IF p_status <> v_status THEN
      UPDATE scmdata.sys_data_privs u
         SET u.pause = p_status
       WHERE u.data_priv_id = p_data_priv_id;
    ELSE
      --�����ظ�����ʾ��Ϣ
      RAISE priv_exp;
    END IF;
  
  EXCEPTION
    WHEN priv_exp THEN
      x_err_msg := '�����ظ���������';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
    
  END update_data_privs_status;
  --����Ա��������Ȩ��Ӧ���沿�ŵ�����Ȩ�� 
  PROCEDURE authorize_emp(p_company_id VARCHAR2,
                          p_dept_id    VARCHAR2,
                          p_user_id    VARCHAR2) IS
    v_dp_flag NUMBER;
  BEGIN
    --У���Ա���Ĳ����Ƿ�ӵ��Ȩ����
    v_dp_flag := check_is_data_privs(p_company_id => p_company_id,
                                     p_dept_id    => p_dept_id,
                                     v_type       => 3);
  
    IF v_dp_flag > 0 THEN
      FOR dp_rec IN (SELECT b.data_priv_group_id
                       FROM scmdata.sys_company_data_priv_dept_middle a
                      INNER JOIN scmdata.sys_company_data_priv_group b
                         ON a.company_id = b.company_id
                        AND a.data_priv_group_id = b.data_priv_group_id
                      WHERE a.company_id = p_company_id
                        AND a.company_dept_id = p_dept_id) LOOP
      
        INSERT INTO sys_company_data_priv_user_middle
          (data_priv_user_middle_id,
           data_priv_group_id,
           user_id,
           create_id,
           create_time,
           update_id,
           update_time,
           company_id)
        VALUES
          (scmdata.f_get_uuid(),
           dp_rec.data_priv_group_id,
           p_user_id,
           'ADMIN',
           SYSDATE,
           'ADMIN',
           SYSDATE,
           p_company_id);
      END LOOP;
    ELSE
      NULL;    
    END IF;
  END authorize_emp;

END pkg_data_privs;
/
