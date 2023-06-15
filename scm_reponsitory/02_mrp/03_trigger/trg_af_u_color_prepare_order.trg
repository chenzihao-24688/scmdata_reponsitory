CREATE OR REPLACE TRIGGER MRP.trg_af_u_color_prepare_order
  AFTER  UPDATE OF prepare_status, expect_arrival_time, order_num ON mrp.color_prepare_order
  FOR EACH ROW
DECLARE
  v_document_rec scmdata.t_document_change_trace%ROWTYPE;
BEGIN
  IF :old.prepare_status = 0 AND :new.prepare_status = 1 THEN 
    NULL;
  ELSE   
  --���ݱ����Դ
  scmdata.pkg_plat_log.p_get_document_change_trace_params(p_company_id    => 'b6cc680ad0f599cde0531164a8c0337f',
                                                          p_document_id   => :old.prepare_order_id,
                                                          po_document_rec => v_document_rec);
   END IF;                                                       

  --1.����״̬
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.prepare_status,
                                                p_new_field => :new.prepare_status) = 0 THEN
    --1.1 �ӵ� ���ӵ� => ������
    IF :old.prepare_status = 1 AND :new.prepare_status = 2 THEN
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                  p_apply_module       => 'prematerial_221',
                                                  p_apply_module_desc  => 'ɫ�����ϵ�',
                                                  p_base_table         => 'COLOR_PREPARE_ORDER',
                                                  p_apply_pk_id        => :old.prepare_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '���ϵ��ţ�' ||
                                                                          :old.prepare_order_id ||
                                                                          '���ӵ�',
                                                  p_operate_field      => 'PREPARE_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 1,
                                                  p_new_code           => 2,
                                                  p_old_value          => '���ӵ�',
                                                  p_new_value          => '������',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    ELSIF :old.prepare_status in (1,0) AND :new.prepare_status = 4 THEN
      --1.2 ȡ�����ϵ� ���ӵ�/����� => ��ȡ��
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                  p_apply_module       => 'a_prematerial_221_1',
                                                  p_apply_module_desc  => 'ɫ�����ϵ���ϸ',
                                                  p_base_table         => 'COLOR_PREPARE_ORDER',
                                                  p_apply_pk_id        => :old.prepare_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => 'ȡ�����ϵ��ţ�' ||
                                                                          :old.prepare_order_id,
                                                  p_operate_field      => 'PREPARE_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 1,
                                                  p_new_code           => 4,
                                                  p_old_value          => CASE WHEN :old.prepare_status = 1 THEN '���ӵ�' WHEN :old.prepare_status = 0 THEN '�����' END,
                                                  p_new_value          => '��ȡ��',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    
    ELSIF :old.prepare_status = 2 AND :new.prepare_status = 4 THEN
      --1.3 ȡ�������� ���ϵ�״̬�������� => ��ȡ��
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                  p_apply_module       => 'a_prematerial_222',
                                                  p_apply_module_desc  => 'ɫ�����ϵ�',
                                                  p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                  p_apply_pk_id        => :old.prepare_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => 'ȡ���������ţ�' ||
                                                                          :old.product_order_id,
                                                  p_operate_field      => 'PREPARE_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 2,
                                                  p_new_code           => 4,
                                                  p_old_value          => '������',
                                                  p_new_value          => '��ȡ��',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    
    ELSIF :old.prepare_status = 2 AND :new.prepare_status = 3 THEN
      --������� ������ => �����
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                  p_apply_module       => 'a_prematerial_222',
                                                  p_apply_module_desc  => 'ɫ�����ϵ�',
                                                  p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                  p_apply_pk_id        => :old.prepare_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '����������ţ�' ||
                                                                          :old.product_order_id,
                                                  p_operate_field      => 'PREPARE_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 2,
                                                  p_new_code           => 3,
                                                  p_old_value          => '������',
                                                  p_new_value          => '�����',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    ELSE
      NULL;
    END IF;
  END IF;

  --2.Ԥ�Ƶ�������
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.expect_arrival_time,
                                                p_new_field => :new.expect_arrival_time) = 0 THEN
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'a_prematerial_221_1',
                                                p_apply_module_desc  => 'ɫ�����ϵ���ϸ',
                                                p_base_table         => 'COLOR_PREPARE_ORDER',
                                                p_apply_pk_id        => :old.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                p_log_type           => v_document_rec.data_source_child_code,
                                                p_log_msg            => '���ϵ��ţ�' ||
                                                                        :old.prepare_order_id || '��' ||
                                                                        chr(10) ||
                                                                        'Ԥ�Ƶ������ڣ�' ||
                                                                        to_char(:new.expect_arrival_time,
                                                                                'yyyy-mm-dd') ||
                                                                        ' 12:00:00' ||
                                                                        '������ǰ��' ||
                                                                        to_char(:old.expect_arrival_time,
                                                                                'yyyy-mm-dd hh24:mi:ss') || '��' || '��',
                                                p_operate_field      => 'EXPECT_ARRIVAL_TIME',
                                                p_field_type         => 'DATE',
                                                p_field_desc         => NULL,
                                                p_old_code           => NULL,
                                                p_new_code           => NULL,
                                                p_old_value          => 1,
                                                p_new_value          => 2,
                                                p_operate_company_id => v_document_rec.operate_company_id,
                                                p_user_id            => v_document_rec.update_id,
                                                p_type               => 2);
  END IF;

  --3.������
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.order_num,
                                                p_new_field => :new.order_num) = 0 THEN
  
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'a_prematerial_221_1',
                                                p_apply_module_desc  => 'ɫ�����ϵ���ϸ',
                                                p_base_table         => 'COLOR_PREPARE_ORDER',
                                                p_apply_pk_id        => :old.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                p_log_type           => v_document_rec.data_source_child_code,
                                                p_log_msg            => '���ϵ��ţ�' ||
                                                                        :old.prepare_order_id || '��' ||
                                                                        chr(10) ||
                                                                        '��������' ||
                                                                        :new.order_num ||
                                                                        '������ǰ��' ||
                                                                        :old.order_num || '��' || '��',
                                                p_operate_field      => 'ORDER_NUM',
                                                p_field_type         => 'NUMBER',
                                                p_field_desc         => NULL,
                                                p_old_code           => NULL,
                                                p_new_code           => NULL,
                                                p_old_value          => 1,
                                                p_new_value          => 2,
                                                p_operate_company_id => v_document_rec.operate_company_id,
                                                p_user_id            => v_document_rec.update_id,
                                                p_type               => 2);
  END IF;

END trg_af_u_color_prepare_order;
/
