CREATE OR REPLACE TRIGGER plm.trg_af_iu_quotation
  AFTER INSERT OR UPDATE OF item_no, sanfu_article_no, color, bag_paper_lattice_number, consumables_quotation_remark, crop_salary, skiving_salary, forming_salary, working_procedure_machining_total, working_procedure_machining_remark, management_expense, development_fee, euipment_depreciation, rent_and_utilities, processing_profit, freight, design_fee, style_picture, pattern_file, marker_file ON plm.quotation
  FOR EACH ROW
DECLARE
  v_company_id     VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
  v_sup_company_id VARCHAR2(32);
  v_quotation_id   VARCHAR2(32) := :new.quotation_id;
  v_update_id      VARCHAR2(32) := :new.update_id;
  vo_log_id        VARCHAR2(32);
BEGIN
  IF :new.quotation_source = '供应商报价' THEN
  
    v_sup_company_id := plm.pkg_quotation.f_get_sup_company_id_by_uqid(p_company_id => v_company_id,
                                                                       p_uq_id      => :new.platform_unique_key);
  
    IF inserting THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_quotation_110',
                                             p_base_table         => 'quotation',
                                             p_apply_pk_id        => v_quotation_id,
                                             p_action_type        => 'INSERT',
                                             p_log_type           => '00',
                                             p_field_desc         => '新增报价单',
                                             p_log_msg            => '新增报价单：' ||
                                                                     v_quotation_id,
                                             p_operate_field      => 'quotation_id',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => 0,
                                             p_new_value          => 1,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_sup_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id,
                                             p_type               => 1);
    ELSIF updating THEN
      --1.报价单明细
      BEGIN
        --款号
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.item_no,
                                                     :new.item_no) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_type           => '00',
                                                 p_field_desc         => '三福款号（供）',
                                                 p_operate_field      => 'item_no',
                                                 p_field_type         => 'VARCHAR',
                                                 p_old_code           => NULL,
                                                 p_new_code           => NULL,
                                                 p_old_value          => :old.item_no,
                                                 p_new_value          => :new.item_no,
                                                 p_memo               => '02',
                                                 p_memo_desc          => :old.item_no,
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 1,
                                                 po_log_id            => vo_log_id);
        END IF;
        --货号
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.sanfu_article_no,
                                                     :new.sanfu_article_no) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_log_id             => vo_log_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_type           => '00',
                                                 p_field_desc         => '三福货号（供）',
                                                 p_operate_field      => 'sanfu_article_no',
                                                 p_field_type         => 'VARCHAR',
                                                 p_old_code           => NULL,
                                                 p_new_code           => NULL,
                                                 p_old_value          => :old.sanfu_article_no,
                                                 p_new_value          => :new.sanfu_article_no,
                                                 p_memo               => '02',
                                                 p_memo_desc          => :old.sanfu_article_no,
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 2,
                                                 po_log_id            => vo_log_id);
        END IF;
        --颜色
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.color, :new.color) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_log_id             => vo_log_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_type           => '00',
                                                 p_field_desc         => '颜色（供）',
                                                 p_operate_field      => 'color',
                                                 p_field_type         => 'VARCHAR',
                                                 p_old_code           => NULL,
                                                 p_new_code           => NULL,
                                                 p_old_value          => :old.color,
                                                 p_new_value          => :new.color,
                                                 p_memo               => '02',
                                                 p_memo_desc          => :old.color,
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 3,
                                                 po_log_id            => vo_log_id);
        END IF;
        --纸格件数
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.bag_paper_lattice_number,
                                                     :new.bag_paper_lattice_number) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_log_id             => vo_log_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_type           => '00',
                                                 p_field_desc         => '纸格件数',
                                                 p_operate_field      => 'color',
                                                 p_field_type         => 'VARCHAR',
                                                 p_old_code           => NULL,
                                                 p_new_code           => NULL,
                                                 p_old_value          => to_char(:old.bag_paper_lattice_number),
                                                 p_new_value          => to_char(:new.bag_paper_lattice_number),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.bag_paper_lattice_number),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 4,
                                                 po_log_id            => vo_log_id);
        END IF;
        --耗材报价备注
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.consumables_quotation_remark,
                                                     :new.consumables_quotation_remark) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_log_id             => vo_log_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_type           => '00',
                                                 p_field_desc         => '耗材报价备注',
                                                 p_operate_field      => 'consumables_quotation_remark',
                                                 p_field_type         => 'VARCHAR',
                                                 p_old_code           => NULL,
                                                 p_new_code           => NULL,
                                                 p_old_value          => to_char(:old.consumables_quotation_remark),
                                                 p_new_value          => to_char(:new.consumables_quotation_remark),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.consumables_quotation_remark),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 5,
                                                 po_log_id            => vo_log_id);
        END IF;
        --拼接日志明细 
        IF vo_log_id IS NOT NULL THEN
          scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                    p_log_id            => vo_log_id,
                                                    p_is_logsmsg        => 1,
                                                    p_is_splice_fields  => 0,
                                                    p_is_show_memo_desc => 1,
                                                    p_type              => 1);
        END IF;
      END quotation;
    
      --2.生产工序
      BEGIN
        vo_log_id := NULL;
        --裁断工资
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.crop_salary,
                                                     :new.crop_salary) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '04',
                                                 p_field_desc         => '裁断工资',
                                                 p_operate_field      => 'crop_salary',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.crop_salary),
                                                 p_new_value          => to_char(:new.crop_salary),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.crop_salary),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 1,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --针车工资
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.skiving_salary,
                                                     :new.skiving_salary) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '04',
                                                 p_field_desc         => '针车工资',
                                                 p_operate_field      => 'skiving_salary',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.skiving_salary),
                                                 p_new_value          => to_char(:new.skiving_salary),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.skiving_salary),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 2,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --成型工资
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.forming_salary,
                                                     :new.forming_salary) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '04',
                                                 p_field_desc         => '成型工资',
                                                 p_operate_field      => 'forming_salary',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.forming_salary),
                                                 p_new_value          => to_char(:new.forming_salary),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.forming_salary),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 3,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --工序加工总报价
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.working_procedure_machining_total,
                                                     :new.working_procedure_machining_total) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '04',
                                                 p_field_desc         => '工序加工总报价',
                                                 p_operate_field      => 'working_procedure_machining_total',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.working_procedure_machining_total),
                                                 p_new_value          => to_char(:new.working_procedure_machining_total),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.working_procedure_machining_total),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 4,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --备注
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.working_procedure_machining_remark,
                                                     :new.working_procedure_machining_remark) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_110',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '04',
                                                 p_field_desc         => '备注',
                                                 p_operate_field      => 'working_procedure_machining_remark',
                                                 p_field_type         => 'VARCHAR',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => :old.working_procedure_machining_remark,
                                                 p_new_value          => :new.working_procedure_machining_remark,
                                                 p_memo               => '02',
                                                 p_memo_desc          => :old.working_procedure_machining_remark,
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 5,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --拼接日志明细
        IF vo_log_id IS NOT NULL THEN
          scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                    p_log_id            => vo_log_id,
                                                    p_is_logsmsg        => 1,
                                                    p_is_splice_fields  => 0,
                                                    p_is_show_memo_desc => 1,
                                                    p_type              => 1);
        END IF;
      END work_procedure_machine;
    
      --3.其他费用
      BEGIN
        vo_log_id := NULL;
        --管理费
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.management_expense,
                                                     :new.management_expense) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_111_6',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '06',
                                                 p_field_desc         => '管理费',
                                                 p_operate_field      => 'management_expense',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.management_expense),
                                                 p_new_value          => to_char(:new.management_expense),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.management_expense),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 1,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --开发费
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.development_fee,
                                                     :new.development_fee) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_111_6',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '06',
                                                 p_field_desc         => '开发费',
                                                 p_operate_field      => 'development_fee',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.development_fee),
                                                 p_new_value          => to_char(:new.development_fee),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.development_fee),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 2,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --刀模/楦头费/胶水/设备折旧
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.euipment_depreciation,
                                                     :new.euipment_depreciation) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_111_6',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '06',
                                                 p_field_desc         => '刀模/楦头费/胶水/设备折旧',
                                                 p_operate_field      => 'euipment_depreciation',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.euipment_depreciation),
                                                 p_new_value          => to_char(:new.euipment_depreciation),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.euipment_depreciation),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 3,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --房租、水电
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.rent_and_utilities,
                                                     :new.rent_and_utilities) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_111_6',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '06',
                                                 p_field_desc         => '房租、水电',
                                                 p_operate_field      => 'rent_and_utilities',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.rent_and_utilities),
                                                 p_new_value          => to_char(:new.rent_and_utilities),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.rent_and_utilities),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 4,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --加工利润
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.processing_profit,
                                                     :new.processing_profit) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_111_6',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '06',
                                                 p_field_desc         => '加工利润',
                                                 p_operate_field      => 'processing_profit',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.processing_profit),
                                                 p_new_value          => to_char(:new.processing_profit),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.processing_profit),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 5,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --运费
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.freight,
                                                     :new.freight) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_111_6',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '06',
                                                 p_field_desc         => '运费',
                                                 p_operate_field      => 'freight',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.freight),
                                                 p_new_value          => to_char(:new.freight),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.freight),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 6,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --设计费
        IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.design_fee,
                                                     :new.design_fee) = 0 THEN
          scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                 p_apply_module       => 'a_quotation_111_6',
                                                 p_base_table         => 'quotation',
                                                 p_apply_pk_id        => v_quotation_id,
                                                 p_action_type        => 'UPDATE',
                                                 p_log_id             => vo_log_id,
                                                 p_log_type           => '06',
                                                 p_field_desc         => '设计费',
                                                 p_operate_field      => 'design_fee',
                                                 p_field_type         => 'NUMBER',
                                                 p_old_code           => '',
                                                 p_new_code           => '',
                                                 p_old_value          => to_char(:old.design_fee),
                                                 p_new_value          => to_char(:new.design_fee),
                                                 p_memo               => '02',
                                                 p_memo_desc          => to_char(:old.design_fee),
                                                 p_user_id            => v_update_id,
                                                 p_operate_company_id => v_sup_company_id,
                                                 p_seq_no             => 7,
                                                 po_log_id            => vo_log_id);
        
        END IF;
      
        --拼接日志明细
        IF vo_log_id IS NOT NULL THEN
          scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                    p_log_id            => vo_log_id,
                                                    p_is_logsmsg        => 1,
                                                    p_is_splice_fields  => 0,
                                                    p_is_show_memo_desc => 1,
                                                    p_type              => 1);
        END IF;
      END other_fee;
      --4.附件  换到item处理
      /*IF updating THEN
        DECLARE
          v_msg CLOB;
        BEGIN
          vo_log_id := NULL;
          --款式图片
          IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.style_picture,
                                                       :new.style_picture) = 0 THEN
            v_msg := '修改款式图片;';
          END IF;
        
          --纸样文件
          IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.pattern_file,
                                                       :new.pattern_file) = 0 THEN
            v_msg := v_msg || '修改纸样文件;';
          END IF;
        
          --唛架文件
          IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.marker_file,
                                                       :new.marker_file) = 0 THEN
            v_msg := v_msg || '修改唛架文件;';
          END IF;
          IF v_msg IS NOT NULL THEN
            scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                                   p_apply_module       => 'a_quotation_111_7',
                                                   p_base_table         => 'quotation',
                                                   p_apply_pk_id        => v_quotation_id,
                                                   p_action_type        => 'UPDATE',
                                                   p_log_id             => vo_log_id,
                                                   p_log_type           => '07',
                                                   p_log_msg            => v_msg,
                                                   p_field_desc         => '附件',
                                                   p_operate_field      => 'file',
                                                   p_field_type         => 'VARCHAR2',
                                                   p_old_code           => '',
                                                   p_new_code           => '',
                                                   p_old_value          => 0,
                                                   p_new_value          => 1,
                                                   p_user_id            => v_update_id,
                                                   p_operate_company_id => v_sup_company_id,
                                                   p_seq_no             => 1,
                                                   po_log_id            => vo_log_id);
          END IF;
        END file;
      END IF;*/
    ELSE
      NULL;
    END IF;
  ELSE
    NULL;
  END IF;
END trg_af_iu_quotation;
/
