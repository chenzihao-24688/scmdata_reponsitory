CREATE OR REPLACE TRIGGER trg_af_iu_t_orders
  AFTER INSERT OR UPDATE OF factory_code ON t_orders
  FOR EACH ROW
DECLARE
  v_company_id        VARCHAR2(32) := :new.company_id;
  v_apply_pk_id       VARCHAR2(32);
  vo_log_id           VARCHAR2(32);
  v_old_factory       VARCHAR2(2000);
  v_new_factory       VARCHAR2(2000);
  v_update_id         VARCHAR2(32);
  v_update_company_id VARCHAR2(32);
BEGIN
  SELECT MAX(t.order_id), MAX(t.update_id), MAX(t.update_company_id)
    INTO v_apply_pk_id, v_update_id, v_update_company_id
    FROM scmdata.t_ordered t
   WHERE t.company_id = :new.company_id
     AND t.order_code = :new.order_id;

  --指定工厂
  v_new_factory := scmdata.pkg_plat_comm.f_get_sup_name(p_company_id    => v_company_id,
                                                        p_sup_code      => :new.factory_code,
                                                        p_is_inner_code => 0,
                                                        p_is_short_name => 1);

  IF inserting THEN
    scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                           p_apply_module       => 'a_order_101_0',
                                           p_base_table         => 't_orders',
                                           p_apply_pk_id        => v_apply_pk_id,
                                           p_action_type        => 'INSERT',
                                           p_log_type           => '01',
                                           p_field_desc         => '工厂名称',
                                           p_operate_field      => 'factory_code',
                                           p_field_type         => 'VARCHAR',
                                           p_old_code           => NULL,
                                           p_new_code           => :new.factory_code,
                                           p_old_value          => NULL,
                                           p_new_value          => v_new_factory,
                                           p_user_id            => v_update_id,
                                           p_operate_company_id => v_update_company_id,
                                           p_seq_no             => 1,
                                           po_log_id            => vo_log_id);
  ELSIF updating THEN
    --指定工厂
    v_old_factory := scmdata.pkg_plat_comm.f_get_sup_name(p_company_id    => v_company_id,
                                                          p_sup_code      => :old.factory_code,
                                                          p_is_inner_code => 0,
                                                          p_is_short_name => 1);
  
    scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                           p_apply_module       => 'a_order_101_0',
                                           p_base_table         => 't_orders',
                                           p_apply_pk_id        => v_apply_pk_id,
                                           p_action_type        => 'UPDATE',
                                           p_log_type           => '01',
                                           p_field_desc         => '工厂名称',
                                           p_operate_field      => 'factory_code',
                                           p_field_type         => 'VARCHAR',
                                           p_old_code           => :old.factory_code,
                                           p_new_code           => :new.factory_code,
                                           p_old_value          => v_old_factory,
                                           p_new_value          => v_new_factory,
                                           p_user_id            => v_update_id,
                                           p_operate_company_id => v_update_company_id,
                                           p_seq_no             => 1,
                                           po_log_id            => vo_log_id);
  END IF;
  scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id => v_company_id,
                                            p_log_id     => vo_log_id,
                                            p_is_logsmsg => 1);
END trg_af_iu_t_orders;
/
