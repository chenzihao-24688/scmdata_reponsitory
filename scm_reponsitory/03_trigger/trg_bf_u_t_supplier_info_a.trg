CREATE OR REPLACE TRIGGER SCMDATA.trg_bf_u_t_supplier_info_a
  BEFORE UPDATE OF inside_supplier_code, supplier_company_name, supplier_company_abbreviation, group_name, pause, gendan_perid, bind_status, supplier_company_id, worker_num, product_efficiency, work_hours_day ON t_supplier_info
  FOR EACH ROW
  FOLLOWS trg_bf_u_t_supplier_info
DECLARE
  vo_log_id          VARCHAR2(32);
  v_company_id       VARCHAR2(32) := :new.company_id;
  v_update_id        VARCHAR2(32) := :new.update_id;
  v_supplier_info_id VARCHAR2(32) := :old.supplier_info_id;
  v_old_group_name   VARCHAR2(256);
  v_new_group_name   VARCHAR2(256);
  v_old_gendan_perid VARCHAR2(2000);
  v_new_gendan_perid VARCHAR2(2000);
BEGIN

  IF :old.status = 1 AND :new.status = 1 THEN
    --供应商名称修改
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.supplier_company_name,
                                                 :new.supplier_company_name) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_type           => '01',
                                             p_field_desc         => '供应商名称',
                                             p_operate_field      => 'supplier_company_name',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => :old.supplier_company_name,
                                             p_new_value          => :new.supplier_company_name,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.supplier_company_name,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    END IF;
    --供应商简称修改
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.supplier_company_abbreviation,
                                                 :new.supplier_company_abbreviation) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '供应商简称',
                                             p_operate_field      => 'supplier_company_abbreviation',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => :old.supplier_company_abbreviation,
                                             p_new_value          => :new.supplier_company_abbreviation,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.supplier_company_abbreviation,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 2,
                                             po_log_id            => vo_log_id);
    END IF;
    --供应商编号修改
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.inside_supplier_code,
                                                 :new.inside_supplier_code) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '供应商编号',
                                             p_operate_field      => 'inside_supplier_code',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => :old.inside_supplier_code,
                                             p_new_value          => :new.inside_supplier_code,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.inside_supplier_code,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 3,
                                             po_log_id            => vo_log_id);
    END IF;
    --统一社会信用代码修改
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.social_credit_code,
                                                 :new.social_credit_code) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '统一社会信用代码',
                                             p_operate_field      => 'social_credit_code',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => :old.social_credit_code,
                                             p_new_value          => :new.social_credit_code,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.social_credit_code,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 4,
                                             po_log_id            => vo_log_id);
    END IF;
  
    --区域组修改
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.group_name,
                                                 :new.group_name) = 0 THEN
    
      v_old_group_name := scmdata.pkg_supplier_info.f_get_group_name(p_company_id      => v_company_id,
                                                                     p_group_config_id => :old.group_name);
    
      v_new_group_name := scmdata.pkg_supplier_info.f_get_group_name(p_company_id      => v_company_id,
                                                                     p_group_config_id => :new.group_name);
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '所在分组',
                                             p_operate_field      => 'group_name',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.group_name,
                                             p_new_code           => :new.group_name,
                                             p_old_value          => v_old_group_name,
                                             p_new_value          => v_new_group_name,
                                             p_memo               => '02',
                                             p_memo_desc          => v_old_group_name,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 5,
                                             po_log_id            => vo_log_id);
    END IF;
    --业务联系人
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.fa_contact_name,
                                                 :new.fa_contact_name) = 0 THEN
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '业务联系人',
                                             p_operate_field      => 'fa_contact_name',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => :old.fa_contact_name,
                                             p_new_value          => :new.fa_contact_name,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.fa_contact_name,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 6,
                                             po_log_id            => vo_log_id);
    END IF;
  
    --业务联系电话
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.fa_contact_phone,
                                                 :new.fa_contact_phone) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '业务联系电话',
                                             p_operate_field      => 'fa_contact_phone',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => :old.fa_contact_phone,
                                             p_new_value          => :new.fa_contact_phone,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.fa_contact_phone,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 7,
                                             po_log_id            => vo_log_id);
    END IF;
    --指派跟单员
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.gendan_perid,
                                                 :new.gendan_perid) = 0 THEN
    
      v_old_gendan_perid := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :old.gendan_perid,
                                                                 p_is_mutival => 1);
    
      v_new_gendan_perid := scmdata.pkg_plat_comm.f_get_username(p_user_id    => :new.gendan_perid,
                                                                 p_is_mutival => 1);
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '跟单员',
                                             p_operate_field      => 'gendan_perid',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.gendan_perid,
                                             p_new_code           => :new.gendan_perid,
                                             p_old_value          => v_old_gendan_perid,
                                             p_new_value          => v_new_gendan_perid,
                                             p_memo               => '02',
                                             p_memo_desc          => v_old_gendan_perid,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 8,
                                             po_log_id            => vo_log_id);
    END IF;
  
    --状态变更
    --合作状态
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.pause, :new.pause) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '04',
                                             p_field_desc         => '合作状态',
                                             p_operate_field      => 'pause',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.pause,
                                             p_new_code           => :new.pause,
                                             p_old_value          => CASE
                                                                       WHEN :old.pause = 0 THEN
                                                                        '启用'
                                                                       WHEN :old.pause = 1 THEN
                                                                        '停用'
                                                                       WHEN :old.pause = 2 THEN
                                                                        '试单'
                                                                       ELSE
                                                                        NULL
                                                                     END,
                                             p_new_value          => CASE
                                                                       WHEN :new.pause = 0 THEN
                                                                        '启用'
                                                                       WHEN :new.pause = 1 THEN
                                                                        '停用'
                                                                       WHEN :new.pause = 2 THEN
                                                                        '试单'
                                                                       ELSE
                                                                        NULL
                                                                     END,
                                             p_memo               => '01',
                                             p_memo_desc          => :new.pause_cause,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 9,
                                             po_log_id            => vo_log_id);
    END IF;
  
    --注册状态
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.supplier_company_id,
                                                 :new.supplier_company_id) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '04',
                                             p_field_desc         => '注册状态',
                                             p_operate_field      => 'supplier_company_id',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.supplier_company_id,
                                             p_new_code           => :new.supplier_company_id,
                                             p_old_value          => CASE
                                                                       WHEN :old.supplier_company_id IS NULL THEN
                                                                        '未注册'
                                                                       ELSE
                                                                        '已注册'
                                                                     END,
                                             p_new_value          => CASE
                                                                       WHEN :new.supplier_company_id IS NULL THEN
                                                                        '未注册'
                                                                       ELSE
                                                                        '已注册'
                                                                     END,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 10,
                                             po_log_id            => vo_log_id);
    END IF;
  
    --绑定状态
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.bind_status,
                                                 :new.bind_status) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '04',
                                             p_field_desc         => '绑定状态',
                                             p_operate_field      => 'bind_status',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => :old.bind_status,
                                             p_new_code           => :new.bind_status,
                                             p_old_value          => CASE
                                                                       WHEN :old.bind_status = 0 THEN
                                                                        '未绑定'
                                                                       WHEN :old.bind_status = 1 THEN
                                                                        '已绑定'
                                                                       ELSE
                                                                        NULL
                                                                     END,
                                             p_new_value          => CASE
                                                                       WHEN :new.bind_status = 0 THEN
                                                                        '未绑定'
                                                                       WHEN :new.bind_status = 1 THEN
                                                                        '已绑定'
                                                                       ELSE
                                                                        NULL
                                                                     END,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 11,
                                             po_log_id            => vo_log_id);
    END IF;
  
    --车位人数
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.worker_num,
                                                 :new.worker_num) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '车位人数',
                                             p_operate_field      => 'worker_num',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => :old.worker_num,
                                             p_new_value          => :new.worker_num,
                                             p_memo               => '02',
                                             p_memo_desc          => :old.worker_num,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 12,
                                             po_log_id            => vo_log_id);
    END IF;
  
    --生产效率
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.product_efficiency,
                                                 :new.product_efficiency) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '生产效率',
                                             p_operate_field      => 'product_efficiency',
                                             p_field_type         => 'NUMBER',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => to_char(:old.product_efficiency),
                                             p_new_value          => to_char(:new.product_efficiency),
                                             p_memo               => '02',
                                             p_memo_desc          => to_char(:old.product_efficiency),
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 13,
                                             po_log_id            => vo_log_id);
    END IF;
  
    --上班时数
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.work_hours_day,
                                                 :new.work_hours_day) = 0 THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_field_desc         => '上班时数',
                                             p_operate_field      => 'work_hours_day',
                                             p_field_type         => 'NUMBER',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => to_char(:old.work_hours_day),
                                             p_new_value          => to_char(:new.work_hours_day),
                                             p_memo               => '02',
                                             p_memo_desc          => to_char(:old.work_hours_day),
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 14,
                                             po_log_id            => vo_log_id);
    END IF;
    --拼接日志明细  worker_num, product_efficiency, work_hours_day
    IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 1);
    END IF;
  END IF;
END trg_bf_u_t_supplier_info_a;
/

