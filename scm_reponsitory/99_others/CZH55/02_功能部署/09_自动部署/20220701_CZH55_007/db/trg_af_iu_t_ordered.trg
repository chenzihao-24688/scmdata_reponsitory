CREATE OR REPLACE TRIGGER scmdata.trg_af_iu_t_ordered
  AFTER INSERT OR UPDATE OF deal_follower ON t_ordered
  FOR EACH ROW
DECLARE
  v_company_id        VARCHAR2(32) := :new.company_id;
  v_apply_pk_id       VARCHAR2(32) := :new.order_id;
  vo_log_id           VARCHAR2(32);
  v_old_deal_follower VARCHAR2(2000);
  v_new_deal_follower VARCHAR2(2000);
BEGIN
  -- 跟单员
  v_new_deal_follower := scmdata.pkg_plat_comm.f_get_username(p_user_id         => :new.deal_follower,
                                                              p_company_id      => v_company_id,
                                                              p_is_company_user => 1,
                                                              p_is_mutival      => 1);
  IF inserting THEN
    NULL;
    /* scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
    p_apply_module       => 'a_order_101_0',
    p_base_table         => 't_ordered',
    p_apply_pk_id        => v_apply_pk_id,
    p_action_type        => 'INSERT',
    p_log_type           => '00',
    p_field_desc         => '跟单员',
    p_operate_field      => 'deal_follower',
    p_field_type         => 'VARCHAR',
    p_old_code           => NULL,
    p_new_code           => :new.deal_follower,
    p_old_value          => NULL,
    p_new_value          => v_new_deal_follower,
    p_user_id            => :new.update_id,
    p_operate_company_id => :new.update_company_id,
    p_seq_no             => 1,
    po_log_id            => vo_log_id);*/
  ELSIF updating THEN
    v_old_deal_follower := scmdata.pkg_plat_comm.f_get_username(p_user_id         => :old.deal_follower,
                                                                p_company_id      => v_company_id,
                                                                p_is_company_user => 1,
                                                                p_is_mutival      => 1);
    scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                           p_apply_module       => 'a_order_101_0',
                                           p_base_table         => 't_ordered',
                                           p_apply_pk_id        => v_apply_pk_id,
                                           p_action_type        => 'UPDATE',
                                           p_log_type           => '00',
                                           p_field_desc         => '跟单员',
                                           p_operate_field      => 'deal_follower',
                                           p_field_type         => 'VARCHAR',
                                           p_old_code           => :old.deal_follower,
                                           p_new_code           => :new.deal_follower,
                                           p_old_value          => v_old_deal_follower,
                                           p_new_value          => v_new_deal_follower,
                                           p_user_id            => :new.update_id,
                                           p_operate_company_id => :new.update_company_id,
                                           p_seq_no             => 1,
                                           po_log_id            => vo_log_id);
  END IF;
  scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id => v_company_id,
                                            p_log_id     => vo_log_id,
                                            p_is_logsmsg => 1);
END trg_af_iu_t_ordered;
/
