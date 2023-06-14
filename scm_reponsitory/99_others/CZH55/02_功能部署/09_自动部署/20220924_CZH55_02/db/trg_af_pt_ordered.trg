CREATE OR REPLACE TRIGGER scmdata.trg_af_pt_ordered
  AFTER UPDATE OF flw_order, flw_order_manager, qc, qc_manager, delay_problem_class, delay_cause_class, delay_cause_detailed, problem_desc, responsible_dept, responsible_dept_sec, is_sup_duty ON scmdata.pt_ordered
  FOR EACH ROW
DECLARE
  vo_log_id     VARCHAR2(32);
  v_company_id  VARCHAR2(32) := :new.company_id;
  v_update_id   VARCHAR2(32) := :new.update_id;
  pt_ordered_id VARCHAR2(32) := :new.pt_ordered_id;
BEGIN
  --1.qc���
  DECLARE
    v_old_qc         VARCHAR2(256);
    v_new_qc         VARCHAR2(256);
    v_old_qc_manager VARCHAR2(256);
    v_new_qc_manager VARCHAR2(256);
  BEGIN
    --qc
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.qc, :new.qc) = 0 THEN
    
      v_old_qc := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :old.qc,
                                                       p_is_mutival => 1,
                                                       p_spilt      => ',');
    
      v_new_qc := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :new.qc,
                                                       p_is_mutival => 1,
                                                       p_spilt      => ',');
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '00',
                                             p_field_desc         => 'QC',
                                             p_operate_field      => 'qc',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.qc,
                                             p_new_code           => :new.qc,
                                             p_old_value          => v_old_qc,
                                             p_new_value          => v_new_qc,
                                             p_memo               => '02',
                                             p_memo_desc          => v_old_qc,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --qc����
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.qc_manager,
                                                 :new.qc_manager) = 0 THEN
    
      v_old_qc_manager := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :old.qc_manager,
                                                               p_is_mutival => 1,
                                                               p_spilt      => ',');
    
      v_new_qc_manager := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :new.qc_manager,
                                                               p_is_mutival => 1,
                                                               p_spilt      => ',');
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '00',
                                             p_field_desc         => 'QC����',
                                             p_operate_field      => 'qc_manager',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.qc_manager,
                                             p_new_code           => :new.qc_manager,
                                             p_old_value          => v_old_qc_manager,
                                             p_new_value          => v_new_qc_manager,
                                             p_memo               => '02',
                                             p_memo_desc          => v_old_qc_manager,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 2,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --ƴ����־��ϸ
    IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 0);
    END IF;
  END qc;

  --�������
  DECLARE
    v_old_flw_order         VARCHAR2(32);
    v_new_flw_order         VARCHAR2(32);
    v_old_flw_order_manager VARCHAR2(32);
    v_new_flw_order_manager VARCHAR2(32);
  BEGIN
    --����
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.flw_order,
                                                 :new.flw_order) = 0 THEN
    
      v_old_flw_order := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :old.flw_order,
                                                              p_is_mutival => 1,
                                                              p_spilt      => ',');
    
      v_new_flw_order := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :new.flw_order,
                                                              p_is_mutival => 1,
                                                              p_spilt      => ',');
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '����',
                                             p_operate_field      => 'flw_order',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.flw_order,
                                             p_new_code           => :new.flw_order,
                                             p_old_value          => v_old_flw_order,
                                             p_new_value          => v_new_flw_order,
                                             p_memo               => '02',
                                             p_memo_desc          => v_old_flw_order,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --��������
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.flw_order_manager,
                                                 :new.flw_order_manager) = 0 THEN
    
      v_old_flw_order_manager := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :old.flw_order_manager,
                                                                      p_is_mutival => 1,
                                                                      p_spilt      => ',');
    
      v_new_flw_order_manager := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :new.flw_order_manager,
                                                                      p_is_mutival => 1,
                                                                      p_spilt      => ',');
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '��������',
                                             p_operate_field      => 'flw_order_manager',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.flw_order_manager,
                                             p_new_code           => :new.flw_order_manager,
                                             p_old_value          => v_old_flw_order_manager,
                                             p_new_value          => v_new_flw_order_manager,
                                             p_memo               => '02',
                                             p_memo_desc          => v_old_flw_order_manager,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 2,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --ƴ����־��ϸ
    IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 0);
    END IF;
  
  END flw_order;
  --����ԭ��
  DECLARE
    v_old_responsible_dept     VARCHAR2(256);
    v_new_responsible_dept     VARCHAR2(256);
    v_old_responsible_dept_sec VARCHAR2(256);
    v_new_responsible_dept_sec VARCHAR2(256);
  BEGIN
    --���ڷ���
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.delay_problem_class,
                                                 :new.delay_problem_class) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '02',
                                             p_field_desc         => '�����������',
                                             p_operate_field      => 'delay_problem_class',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => '',
                                             p_new_code           => '',
                                             p_old_value          => :old.delay_problem_class,
                                             p_new_value          => :new.delay_problem_class,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.delay_problem_class,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --ԭ�����
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.delay_cause_class,
                                                 :new.delay_cause_class) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '02',
                                             p_field_desc         => '����ԭ�����',
                                             p_operate_field      => 'delay_cause_class',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => '',
                                             p_new_code           => '',
                                             p_old_value          => :old.delay_cause_class,
                                             p_new_value          => :new.delay_cause_class,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.delay_cause_class,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 2,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --ԭ��ϸ��
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.delay_cause_detailed,
                                                 :new.delay_cause_detailed) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '02',
                                             p_field_desc         => '����ԭ��ϸ��',
                                             p_operate_field      => 'delay_cause_detailed',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => '',
                                             p_new_code           => '',
                                             p_old_value          => :old.delay_cause_detailed,
                                             p_new_value          => :new.delay_cause_detailed,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.delay_cause_detailed,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 3,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --��Ӧ���Ƿ�����  
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.is_sup_duty,
                                                 :new.is_sup_duty) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '02',
                                             p_field_desc         => '��Ӧ���Ƿ�����',
                                             p_operate_field      => 'is_sup_duty',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.is_sup_duty,
                                             p_new_code           => :new.is_sup_duty,
                                             p_old_value          => (CASE
                                                                       WHEN :old.is_sup_duty = 1 THEN
                                                                        '��'
                                                                       WHEN :old.is_sup_duty = 0 THEN
                                                                        '��'
                                                                       ELSE
                                                                        NULL
                                                                     END),
                                             p_new_value          => (CASE
                                                                       WHEN :new.is_sup_duty = 1 THEN
                                                                        '��'
                                                                       WHEN :new.is_sup_duty = 0 THEN
                                                                        '��'
                                                                       ELSE
                                                                        NULL
                                                                     END),
                                             p_memo               => '02',
                                             p_memo_desc          => (CASE
                                                                       WHEN :old.is_sup_duty = 1 THEN
                                                                        '��'
                                                                       WHEN :old.is_sup_duty = 0 THEN
                                                                        '��'
                                                                       ELSE
                                                                        NULL
                                                                     END),
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 4,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --��ȡ���β�������
    v_old_responsible_dept     := scmdata.pkg_plat_comm.f_get_company_deptname(p_company_id => v_company_id,
                                                                               p_dept_id    => :old.responsible_dept);
    v_new_responsible_dept     := scmdata.pkg_plat_comm.f_get_company_deptname(p_company_id => v_company_id,
                                                                               p_dept_id    => :new.responsible_dept);
    v_old_responsible_dept_sec := scmdata.pkg_plat_comm.f_get_company_deptname(p_company_id => v_company_id,
                                                                               p_dept_id    => :old.responsible_dept_sec);
    v_new_responsible_dept_sec := scmdata.pkg_plat_comm.f_get_company_deptname(p_company_id => v_company_id,
                                                                               p_dept_id    => :new.responsible_dept_sec);
    --���β���(1��)
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.responsible_dept,
                                                 :new.responsible_dept) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '02',
                                             p_field_desc         => '���β���(1��)',
                                             p_operate_field      => 'responsible_dept',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.responsible_dept,
                                             p_new_code           => :new.responsible_dept,
                                             p_old_value          => v_old_responsible_dept,
                                             p_new_value          => v_new_responsible_dept,
                                             p_memo               => '02',
                                             p_memo_desc          => v_old_responsible_dept,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 5,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --���β���(2��)
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.responsible_dept_sec,
                                                 :new.responsible_dept_sec) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '02',
                                             p_field_desc         => '���β���(2��)',
                                             p_operate_field      => 'responsible_dept_sec',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.responsible_dept_sec,
                                             p_new_code           => :new.responsible_dept_sec,
                                             p_old_value          => v_old_responsible_dept_sec,
                                             p_new_value          => v_new_responsible_dept_sec,
                                             p_memo               => '02',
                                             p_memo_desc          => v_old_responsible_dept_sec,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 6,
                                             po_log_id            => vo_log_id);
    
    END IF;
    --��������
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.problem_desc,
                                                 :new.problem_desc) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_report_120',
                                             p_base_table         => 'PT_ORDERED',
                                             p_apply_pk_id        => pt_ordered_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '02',
                                             p_field_desc         => '��������',
                                             p_operate_field      => 'problem_desc',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => '',
                                             p_new_code           => '',
                                             p_old_value          => :old.problem_desc,
                                             p_new_value          => :new.problem_desc,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.problem_desc,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 7,
                                             po_log_id            => vo_log_id);
    
    END IF;
  
    --ƴ����־��ϸ
    IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 0);
    END IF;
  
  END delay_cause;
END trg_af_pt_ordered;
/
