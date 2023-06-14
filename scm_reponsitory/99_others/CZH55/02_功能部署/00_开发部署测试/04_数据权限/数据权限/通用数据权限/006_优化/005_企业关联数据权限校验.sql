DECLARE
BEGIN
  UPDATE bw3.sys_item_list t
     SET t.insert_sql = 'BEGIN
  pkg_data_privs.ass_data_privs(p_company_id         => %default_company_id%,
                                p_data_priv_group_id => :data_priv_group_id,
                                p_data_priv_id       => :data_priv_id,
                                p_user_id            => :user_id);

END;'
   WHERE t.item_id = 'c_2421';
END;
