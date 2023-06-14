CREATE OR REPLACE TRIGGER trg_af_iu_quotation
  AFTER INSERT OR UPDATE OF item_no, sanfu_article_no, color, bag_paper_lattice_number, consumables_quotation_remark ON quotation
  FOR EACH ROW
DECLARE
  v_company_id   VARCHAR2(32) := 'a972dd1ffe3b3a10e0533c281cac8fd7';
  v_quotation_id VARCHAR2(32) := :new.quotation_id;
  v_update_id    VARCHAR2(32) := :new.update_id;
  vo_log_id      VARCHAR2(32);
BEGIN
  IF :new.quotation_source = '供应商报价' THEN
    IF inserting THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_quotation_110',
                                             p_base_table         => 'quotation',
                                             p_apply_pk_id        => v_quotation_id,
                                             p_action_type        => 'INSERT',
                                             p_log_type           => '00',
                                             p_field_desc         => '新增报价单',
                                             p_log_msg            => '新增报价单',
                                             p_operate_field      => 'quotation_id',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => 0,
                                             p_new_value          => 1,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id,
                                             p_type               => 1);
    ELSIF updating THEN
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
                                               p_operate_company_id => v_company_id,
                                               p_seq_no             => 1,
                                               po_log_id            => vo_log_id);
      END IF;
      --。。。
      --拼接日志明细 
      IF vo_log_id IS NOT NULL THEN
        scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                  p_log_id            => vo_log_id,
                                                  p_is_logsmsg        => 1,
                                                  p_is_splice_fields  => 0,
                                                  p_is_show_memo_desc => 1,
                                                  p_type              => 1);
      END IF;
    ELSIF deleting THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_quotation_111_3',
                                             p_base_table         => 'special_craft_quotation',
                                             p_apply_pk_id        => v_quotation_id,
                                             p_action_type        => 'DELETE',
                                             p_log_type           => '03',
                                             p_field_desc         => '删除特殊工艺',
                                             p_log_msg            => '删除特殊工艺',
                                             p_operate_field      => 'quotation_special_craft_detail_id',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => 1,
                                             p_new_value          => 0,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_sup_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id,
                                             p_type               => 1);
    ELSE
      NULL;
    END IF;
  ELSE
    NULL;
  END IF;
END trg_af_iu_quotation;
