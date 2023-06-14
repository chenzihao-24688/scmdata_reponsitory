--平台数据权限
DECLARE
  v_sql   CLOB;
  v_sql_1 CLOB;
BEGIN
  v_sql := 'DECLARE
  v_data_privs_rec scmdata.sys_data_privs%ROWTYPE;
BEGIN

  v_data_privs_rec.data_priv_name       := :data_priv_name;
  v_data_privs_rec.seq_no               := :seq_no;
  v_data_privs_rec.level_type           := :level_type;
  v_data_privs_rec.fields_config_method := :fields_config_method;
  v_data_privs_rec.create_id            := :user_id;
  v_data_privs_rec.update_id            := :user_id;

  scmdata.pkg_data_privs.insert_data_privs(p_data_privs_rec => v_data_privs_rec);

  scmdata.pkg_data_privs.data_privs_dispen(p_data_priv_id   => v_data_priv_id,
                                           p_data_priv_name => :data_priv_name,
                                           p_user_id        => :user_id);
END;';

  v_sql_1 := 'DECLARE
  v_data_privs_rec scmdata.sys_data_privs%ROWTYPE;
BEGIN
  v_data_privs_rec.data_priv_id = :data_priv_id;
  v_data_privs_rec.data_priv_name = :data_priv_name;
  v_data_privs_rec.seq_no = :seq_no;
  v_data_privs_rec.level_type = :level_type;
  v_data_privs_rec.fields_config_method = :fields_config_method;
  v_data_privs_rec.update_id = :user_id;
  v_data_privs_rec.update_time = SYSDATE;
  pkg_data_privs.update_data_privs(p_data_privs_rec => v_data_privs_rec);
END;';

  UPDATE nbw.sys_item_list t
     SET t.insert_sql = v_sql, t.update_sql = v_sql_1
   WHERE t.item_id = 'g_560';

END;
/
--字段配置
DECLARE v_sql CLOB;
v_sql_1 CLOB;
BEGIN
  v_sql   := q'[DECLARE
  v_type              VARCHAR2(32);
  v_pick_fields_rec   sys_data_priv_pick_fields%ROWTYPE;
  v_lookup_fields_rec sys_data_priv_lookup_fields%ROWTYPE;
  v_date_fields_rec   sys_data_priv_date_fields%ROWTYPE;
BEGIN
  SELECT upper(dp.fields_config_method)
    INTO v_type
    FROM scmdata.sys_data_privs dp
   WHERE dp.data_priv_id = :data_priv_id;

  IF v_type = 'PICK_LIST' THEN
  
    v_pick_fields_rec.data_priv_id := :data_priv_id; 
    v_pick_fields_rec.create_id    := :user_id;
    v_pick_fields_rec.create_time  := SYSDATE;
    v_pick_fields_rec.update_id    := :user_id;
    v_pick_fields_rec.update_time  := SYSDATE;
    v_pick_fields_rec.col_1        := :col_1;
    v_pick_fields_rec.col_2        := :col_2;
    v_pick_fields_rec.col_3        := :col_3;
    v_pick_fields_rec.col_4        := :col_4;
    v_pick_fields_rec.col_5        := :col_5;
    v_pick_fields_rec.col_6        := :col_6;
    v_pick_fields_rec.col_7        := :col_7;
    v_pick_fields_rec.col_8        := :col_8;
    v_pick_fields_rec.col_9        := :col_9;
    v_pick_fields_rec.col_10       := :col_10;
  
    pkg_data_privs.insert_data_priv_pick_fields(p_pick_fd_rec => v_pick_fields_rec);
  
  ELSIF v_type = 'LOOK_UP' THEN
  
    v_lookup_fields_rec.data_priv_id := :data_priv_id;
    v_lookup_fields_rec.create_id    := :user_id;
    v_lookup_fields_rec.create_time  := SYSDATE;
    v_lookup_fields_rec.update_id    := :user_id;
    v_lookup_fields_rec.update_time  := SYSDATE;
    v_lookup_fields_rec.col_11       := :col_11;
  
    pkg_data_privs.insert_data_priv_lookup_fields(p_lookup_fd_rec => v_lookup_fields_rec);
  
  ELSIF v_type = 'DATE' THEN
  
    v_date_fields_rec.data_priv_id := :data_priv_id;
    v_date_fields_rec.create_id    := :user_id;
    v_date_fields_rec.create_time  := SYSDATE;
    v_date_fields_rec.update_id    := :user_id;
    v_date_fields_rec.update_time  := SYSDATE;
    v_date_fields_rec.col_21       := :col_21;
    v_date_fields_rec.col_22       := :col_22;
  
    pkg_data_privs.insert_data_priv_date_fields(p_date_fd_rec => v_date_fields_rec);
  END IF;
END;
]';

  v_sql_1 := q'[DECLARE
  v_type              VARCHAR2(32);
  v_pick_fields_rec   sys_data_priv_pick_fields%ROWTYPE;
  v_lookup_fields_rec sys_data_priv_lookup_fields%ROWTYPE;
  v_date_fields_rec   sys_data_priv_date_fields%ROWTYPE;
BEGIN
  SELECT upper(dp.fields_config_method)
    INTO v_type
    FROM scmdata.sys_data_privs dp
   WHERE dp.data_priv_id = :data_priv_id;

  IF v_type = 'PICK_LIST' THEN
    v_pick_fields_rec.data_priv_pick_field_id := :data_priv_pick_field_id;
    v_pick_fields_rec.update_id               := :user_id;
    v_pick_fields_rec.update_time             := SYSDATE;
    v_pick_fields_rec.col_1                   := :col_1;
    v_pick_fields_rec.col_2                   := :col_2;
    v_pick_fields_rec.col_3                   := :col_3;
    v_pick_fields_rec.col_4                   := :col_4;
    v_pick_fields_rec.col_5                   := :col_5;
    v_pick_fields_rec.col_6                   := :col_6;
    v_pick_fields_rec.col_7                   := :col_7;
    v_pick_fields_rec.col_8                   := :col_8;
    v_pick_fields_rec.col_9                   := :col_9;
    v_pick_fields_rec.col_10                  := :col_10;
  
    pkg_data_privs.update_data_priv_pick_fields(p_pick_fd_rec => v_pick_fields_rec);
  
  ELSIF v_type = 'LOOK_UP' THEN
  
    v_lookup_fields_rec.data_priv_lookup_field_id := :data_priv_lookup_field_id;
    v_lookup_fields_rec.update_id                 := :user_id;
    v_lookup_fields_rec.update_time               := SYSDATE;
    v_lookup_fields_rec.col_11                    := :col_11;
  
    pkg_data_privs.update_data_priv_lookup_fields(p_lookup_fd_rec => v_lookup_fields_rec);
  
  ELSIF v_type = 'DATE' THEN
  
    v_date_fields_rec.data_priv_date_field_id := :data_priv_date_field_id;
    v_date_fields_rec.update_id               := :user_id;
    v_date_fields_rec.update_time             := SYSDATE;
    v_date_fields_rec.col_21                  := :col_21;
    v_date_fields_rec.col_22                  := :col_22;
  
    pkg_data_privs.update_data_priv_date_fields(p_date_fd_rec => v_date_fields_rec);
  END IF;
END;
]';
  
  UPDATE nbw.sys_item_list t
     SET t.insert_sql = v_sql, t.update_sql = v_sql_1
   WHERE t.item_id = 'c_2431';
END;
