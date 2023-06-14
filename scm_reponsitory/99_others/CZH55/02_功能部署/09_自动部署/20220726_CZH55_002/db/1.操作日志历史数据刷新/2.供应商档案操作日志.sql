DECLARE
  v_update_company_id VARCHAR2(256);
  vo_log_id           VARCHAR2(32) := NULL;
BEGIN
  FOR i IN (SELECT t.supplier_info_id,
                   t.oper_type,
                   t.reason,
                   t.create_id,
                   t.create_time,
                   t.company_id
              FROM scmdata.t_supplier_info_oper_log t
             ORDER BY t.supplier_info_id ASC, t.create_time DESC) LOOP
    IF i.oper_type = '��������' THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => i.company_id,
                                             p_apply_module       => 'action_a_supp_151_1',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => i.supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '00',
                                             p_field_desc         => '����״̬',
                                             p_operate_field      => 'status',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => 0,
                                             p_new_code           => 1,
                                             p_old_value          => '������',
                                             p_new_value          => '�ѽ���',
                                             p_user_id            => i.create_id,
                                             p_operate_company_id => i.company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id       => i.company_id,
                                                p_log_id           => vo_log_id,
                                                p_is_logsmsg       => 1,
                                                p_is_splice_fields => 0);
      UPDATE scmdata.t_plat_log t
         SET t.create_time = i.create_time, t.update_time = i.create_time
       WHERE t.log_id = vo_log_id;
      vo_log_id := NULL;
    ELSIF instr(i.oper_type, '������Ϣ') > 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => i.company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => i.supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_type           => '01',
                                             p_is_logs            => 0,
                                             p_log_msg            => '�޸ĵ���-������Ϣ',
                                             p_user_id            => i.create_id,
                                             p_operate_company_id => i.company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
      UPDATE scmdata.t_plat_log t
         SET t.create_time = i.create_time, t.update_time = i.create_time
       WHERE t.log_id = vo_log_id;
      vo_log_id := NULL;
    ELSIF instr(i.oper_type, '������Χ') > 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => i.company_id,
                                             p_apply_module       => 'a_supp_161_1',
                                             p_base_table         => 't_coop_scope',
                                             p_apply_pk_id        => i.supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_type           => '02',
                                             p_is_logs            => 0,
                                             p_log_msg            => '�޸ĵ���-������Χ',
                                             p_user_id            => i.create_id,
                                             p_operate_company_id => i.company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
      UPDATE scmdata.t_plat_log t
         SET t.create_time = i.create_time, t.update_time = i.create_time
       WHERE t.log_id = vo_log_id;
      vo_log_id := NULL;
    ELSIF i.oper_type IN ('����', 'ͣ��', '�Ե�') THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => i.company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => i.supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '04',
                                             p_field_desc         => '����״̬',
                                             p_operate_field      => 'pause',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => CASE
                                                                       WHEN i.oper_type = '����' THEN
                                                                        0
                                                                       WHEN i.oper_type = 'ͣ��' THEN
                                                                        1
                                                                       WHEN i.oper_type = '�Ե�' THEN
                                                                        2
                                                                       ELSE
                                                                        NULL
                                                                     END,
                                             p_old_value          => NULL,
                                             p_new_value          => i.oper_type,
                                             p_memo               => '01',
                                             p_memo_desc          => i.reason,
                                             p_user_id            => i.create_id,
                                             p_operate_company_id => i.company_id,
                                             p_seq_no             => 9,
                                             po_log_id            => vo_log_id);
      IF vo_log_id IS NOT NULL THEN
        scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => i.company_id,
                                                  p_log_id            => vo_log_id,
                                                  p_is_logsmsg        => 1,
                                                  p_is_splice_fields  => 0,
                                                  p_is_show_memo_desc => 1);
        UPDATE scmdata.t_plat_log t
           SET t.create_time = i.create_time, t.update_time = i.create_time
         WHERE t.log_id = vo_log_id;
      END IF;
      vo_log_id := NULL;
    END IF;
  END LOOP;
END;
/
