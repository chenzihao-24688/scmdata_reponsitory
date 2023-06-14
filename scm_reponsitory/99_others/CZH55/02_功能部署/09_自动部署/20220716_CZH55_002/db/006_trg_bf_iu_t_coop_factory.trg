CREATE OR REPLACE TRIGGER scmdata.trg_bf_iu_t_coop_factory
  BEFORE INSERT OR UPDATE ON scmdata.t_coop_factory
  FOR EACH ROW
DECLARE
  vo_log_id          VARCHAR2(32);
  v_company_id       VARCHAR2(32) := :new.company_id;
  v_update_id        VARCHAR2(32) := :new.update_id;
  v_supplier_info_id VARCHAR2(32) := :new.supplier_info_id;
  v_memo_desc        VARCHAR2(4000);
  v_status           INT;
BEGIN
  SELECT MAX(t.status)
    INTO v_status
    FROM scmdata.t_supplier_info t
   WHERE t.supplier_info_id = v_supplier_info_id
     AND t.company_id = v_company_id;
  IF v_status = 1 THEN
    v_memo_desc := :new.factory_code || ' ' || :new.factory_name;
    IF inserting THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_151_7',
                                             p_base_table         => 't_coop_factory',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'INSERT',
                                             p_log_type           => '03',
                                             p_is_logs            => 0,
                                             p_log_msg            => '新增：' ||
                                                                     v_memo_desc,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    
    ELSIF updating THEN
      --状态
      IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.pause, :new.pause) = 0 THEN
        scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                               p_apply_module       => 'a_supp_151_7',
                                               p_base_table         => 't_coop_factory',
                                               p_apply_pk_id        => v_supplier_info_id,
                                               p_action_type        => 'UPDATE',
                                               p_log_id             => vo_log_id,
                                               p_log_type           => '03',
                                               p_field_desc         => '状态',
                                               p_operate_field      => 'pause',
                                               p_field_type         => 'INT',
                                               p_old_code           => :old.pause,
                                               p_new_code           => :new.pause,
                                               p_old_value          => CASE
                                                                         WHEN :old.pause = 1 THEN
                                                                          '停用'
                                                                         WHEN :old.pause = 0 THEN
                                                                          '启用'
                                                                         ELSE
                                                                          NULL
                                                                       END,
                                               p_new_value          => CASE
                                                                         WHEN :new.pause = 1 THEN
                                                                          '停用'
                                                                         WHEN :new.pause = 0 THEN
                                                                          '启用'
                                                                         ELSE
                                                                          NULL
                                                                       END,
                                               p_memo               => '04',
                                               p_memo_desc          => v_memo_desc,
                                               p_user_id            => v_update_id,
                                               p_operate_company_id => v_company_id,
                                               p_seq_no             => 2,
                                               po_log_id            => vo_log_id);
        --拼接日志
        IF vo_log_id IS NOT NULL THEN
          scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                    p_log_id            => vo_log_id,
                                                    p_is_logsmsg        => 1,
                                                    p_is_splice_fields  => 0,
                                                    p_is_show_memo_desc => 1);
        END IF;
      END IF;
    END IF;
  END IF;
END trg_bf_iu_t_coop_factory;
/
/
