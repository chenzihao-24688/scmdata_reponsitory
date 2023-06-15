CREATE OR REPLACE TRIGGER MRP.trg_af_u_color_prepare_product_order
  AFTER UPDATE OF product_status ON mrp.color_prepare_product_order
  FOR EACH ROW
DECLARE
  v_document_rec scmdata.t_document_change_trace%ROWTYPE;
BEGIN
  --���ݱ����Դ
  scmdata.pkg_plat_log.p_get_document_change_trace_params(p_company_id    => 'b6cc680ad0f599cde0531164a8c0337f',
                                                          p_document_id   => :old.product_order_id,
                                                          po_document_rec => v_document_rec);

  --������״̬
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.product_status,
                                                p_new_field => :new.product_status) = 0 THEN
  
    --1.1 ȡ������ ������ => ��ȡ��
    IF :old.product_status = 1 AND :new.product_status = 3 THEN
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                  p_apply_module       => 'a_prematerial_222',
                                                  p_apply_module_desc  => 'ɫ�����ϵ�',
                                                  p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                  p_apply_pk_id        => :old.product_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => 'ȡ���������ţ�' ||
                                                                          :old.product_order_id,
                                                  p_operate_field      => 'PRODUCT_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 1,
                                                  p_new_code           => 3,
                                                  p_old_value          => '������',
                                                  p_new_value          => '��ȡ��',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
      --1.1 ��������� ������ => �����
      IF :old.product_status = 1 AND :new.product_status = 2 THEN
        scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                    p_apply_module       => 'a_prematerial_222',
                                                    p_apply_module_desc  => 'ɫ�����ϵ�',
                                                    p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                    p_apply_pk_id        => :old.product_order_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                    p_log_type           => v_document_rec.data_source_child_code,
                                                    p_log_msg            => '����������ţ�' ||
                                                                            :old.product_order_id || '��' ||
                                                                            chr(10) ||
                                                                            '���������' ||
                                                                            to_char(to_number(:new.finish_num)) ||
                                                                            '������ǰ:' ||
                                                                            to_char(to_number(:old.finish_num)) || '��' || '��' ||
                                                                            chr(10) ||
                                                                            (CASE
                                                                              WHEN :new.product_status = 2 THEN
                                                                               '��������״̬��:�����' || '��'
                                                                              ELSE
                                                                               NULL
                                                                            END),
                                                    p_operate_field      => 'PRODUCT_STATUS',
                                                    p_field_type         => 'NUMBER',
                                                    p_field_desc         => NULL,
                                                    p_old_code           => 1,
                                                    p_new_code           => 2,
                                                    p_old_value          => '������',
                                                    p_new_value          => (CASE
                                                                              WHEN :new.product_status = 2 THEN
                                                                               '�����'
                                                                              ELSE
                                                                               NULL
                                                                            END),
                                                    p_operate_company_id => v_document_rec.operate_company_id,
                                                    p_user_id            => v_document_rec.update_id,
                                                    p_memo               => NULL,
                                                    p_memo_desc          => NULL,
                                                    p_type               => 2);
      END IF;
    ELSE
      NULL;
    END IF;
  ELSE
    --�������
    IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.batch_finish_num,
                                                  p_new_field => :new.batch_finish_num) = 0 THEN
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                  p_apply_module       => 'a_prematerial_222',
                                                  p_apply_module_desc  => 'ɫ�����ϵ�',
                                                  p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                  p_apply_pk_id        => :old.product_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '����������ţ�' ||
                                                                          :old.product_order_id || '��' ||
                                                                          chr(10) ||
                                                                          '���������' ||
                                                                          to_char(to_number(:new.batch_finish_num)) ||
                                                                          '������ǰ:' ||
                                                                          to_char(to_number(:old.batch_finish_num)) || '��' || '��',
                                                  p_operate_field      => 'PRODUCT_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 1,
                                                  p_new_code           => 2,
                                                  p_old_value          => :old.batch_finish_num,
                                                  p_new_value          => :new.batch_finish_num,
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    END IF;
  END IF;
END trg_af_u_color_prepare_product_order;
/
