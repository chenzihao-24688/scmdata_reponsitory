DECLARE
  v_sql  CLOB;
  v_sql1 CLOB;
  v_sql2 CLOB;
BEGIN

  v_sql := q'[DECLARE
  v_data_privs_rec scmdata.sys_data_privs%ROWTYPE;
BEGIN
  v_data_privs_rec.data_priv_id         := scmdata.f_get_uuid();
  v_data_privs_rec.data_priv_name       := :data_priv_name;
  v_data_privs_rec.seq_no               := :seq_no;
  v_data_privs_rec.level_type           := :level_type;
  v_data_privs_rec.fields_config_method := :fields_config_method;
  v_data_privs_rec.create_id            := :user_id;
  v_data_privs_rec.update_id            := :user_id;

  scmdata.pkg_data_privs.insert_data_privs(p_data_privs_rec => v_data_privs_rec);

  scmdata.pkg_data_privs.data_privs_dispen(p_data_priv_id   => v_data_privs_rec.data_priv_id,
                                           p_data_priv_name => :data_priv_name,
                                           p_user_id        => :user_id);
END;]';

  v_sql1 := q'[SELECT dp.data_priv_id,
       decode(dp.pause,1,'ÆôÓÃ',0,'Í£ÓÃ') pause_desc,
       dp.data_priv_code,
       dp.data_priv_name,
       dp.level_type,
       dp.fields_config_method      
  FROM sys_data_privs dp
 ORDER BY dp.level_type ASC, dp.seq_no ASC]';

  v_sql2 := q'[DECLARE
  v_data_privs_rec scmdata.sys_data_privs%ROWTYPE;
BEGIN
  v_data_privs_rec.data_priv_id := :data_priv_id;
  v_data_privs_rec.data_priv_name := :data_priv_name;
  v_data_privs_rec.seq_no := :seq_no;
  v_data_privs_rec.level_type := :level_type;
  v_data_privs_rec.fields_config_method := :fields_config_method;
  v_data_privs_rec.update_id := :user_id;
  v_data_privs_rec.update_time := SYSDATE;
  pkg_data_privs.update_data_privs(p_data_privs_rec => v_data_privs_rec);
END;]';

  UPDATE bw3.sys_item_list t
     SET t.insert_sql = v_sql, t.select_sql = v_sql1, t.update_sql = v_sql2
   WHERE t.item_id = 'g_560';

END;
