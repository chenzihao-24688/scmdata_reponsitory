DECLARE
  v_sql  CLOB;
  v_sql1 CLOB;
  v_sql2 CLOB;
BEGIN
  v_sql := q'[DECLARE
    p_dp_group_rec sys_company_data_priv_group%ROWTYPE;
  BEGIN
    p_dp_group_rec.data_priv_group_name := :data_priv_group_name;
    p_dp_group_rec.company_id           := %default_company_id%;
    p_dp_group_rec.user_id              := :user_id;
    p_dp_group_rec.seq_no               := :seq_no;
    p_dp_group_rec.create_id            := %current_userid%;
    p_dp_group_rec.create_time          := SYSDATE;
    p_dp_group_rec.update_id            := %current_userid%;
    p_dp_group_rec.update_time          := SYSDATE;
  
    pkg_data_privs.insert_company_data_priv_group(p_dp_group_rec => p_dp_group_rec);
  
  END;]';

  v_sql1 := q'[DECLARE
    p_dp_group_rec sys_company_data_priv_group%ROWTYPE;
  BEGIN
    p_dp_group_rec.data_priv_group_id   := :data_priv_group_id;
    p_dp_group_rec.data_priv_group_name := :data_priv_group_name;
    p_dp_group_rec.company_id           := %default_company_id%;
    p_dp_group_rec.user_id              := :user_id;
    p_dp_group_rec.seq_no               := :seq_no;
    p_dp_group_rec.update_id            := %current_userid%;
    p_dp_group_rec.update_time          := SYSDATE; 
    pkg_data_privs.update_company_data_priv_group(p_dp_group_rec => p_dp_group_rec);
  END;]';

  v_sql2 := q'[
  BEGIN
    pkg_data_privs.delete_company_data_priv_group(p_data_priv_group_id => :data_priv_group_id,
                                           p_company_id         => %default_company_id%);
  END;]';

  UPDATE bw3.sys_item_list t
     SET t.insert_sql = v_sql, t.update_sql = v_sql1, t.delete_sql = v_sql2
   WHERE t.item_id = 'c_2410';
END;
