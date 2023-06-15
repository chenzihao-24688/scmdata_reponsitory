CREATE OR REPLACE TRIGGER MRP.trg_af_u_color_prepare_order
  AFTER  UPDATE OF prepare_status, expect_arrival_time, order_num ON mrp.color_prepare_order
  FOR EACH ROW
DECLARE
  v_document_rec scmdata.t_document_change_trace%ROWTYPE;
BEGIN
  IF :old.prepare_status = 0 AND :new.prepare_status = 1 THEN 
    NULL;
  ELSE   
  --单据变更溯源
  scmdata.pkg_plat_log.p_get_document_change_trace_params(p_company_id    => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                          p_document_id   => :old.prepare_order_id,
                                                          po_document_rec => v_document_rec);
   END IF;                                                       

  --1.备料状态
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.prepare_status,
                                                p_new_field => :new.prepare_status) = 0 THEN
    --1.1 接单 待接单 => 生产中
    IF :old.prepare_status = 1 AND :new.prepare_status = 2 THEN
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                  p_apply_module       => 'prematerial_221',
                                                  p_apply_module_desc  => '色布备料单',
                                                  p_base_table         => 'COLOR_PREPARE_ORDER',
                                                  p_apply_pk_id        => :old.prepare_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '备料单号：' ||
                                                                          :old.prepare_order_id ||
                                                                          '被接单',
                                                  p_operate_field      => 'PREPARE_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 1,
                                                  p_new_code           => 2,
                                                  p_old_value          => '待接单',
                                                  p_new_value          => '生产中',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    ELSIF :old.prepare_status in (1,0) AND :new.prepare_status = 4 THEN
      --1.2 取消备料单 待接单/待审核 => 已取消
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                  p_apply_module       => 'a_prematerial_221_1',
                                                  p_apply_module_desc  => '色布备料单明细',
                                                  p_base_table         => 'COLOR_PREPARE_ORDER',
                                                  p_apply_pk_id        => :old.prepare_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '取消备料单号：' ||
                                                                          :old.prepare_order_id,
                                                  p_operate_field      => 'PREPARE_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 1,
                                                  p_new_code           => 4,
                                                  p_old_value          => CASE WHEN :old.prepare_status = 1 THEN '待接单' WHEN :old.prepare_status = 0 THEN '待审核' END,
                                                  p_new_value          => '已取消',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    
    ELSIF :old.prepare_status = 2 AND :new.prepare_status = 4 THEN
      --1.3 取消生产单 备料单状态：生产中 => 已取消
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                  p_apply_module       => 'a_prematerial_222',
                                                  p_apply_module_desc  => '色布备料单',
                                                  p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                  p_apply_pk_id        => :old.prepare_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '取消生产单号：' ||
                                                                          :old.product_order_id,
                                                  p_operate_field      => 'PREPARE_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 2,
                                                  p_new_code           => 4,
                                                  p_old_value          => '生产中',
                                                  p_new_value          => '已取消',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    
    ELSIF :old.prepare_status = 2 AND :new.prepare_status = 3 THEN
      --订单完成 生产中 => 已完成
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                  p_apply_module       => 'a_prematerial_222',
                                                  p_apply_module_desc  => '色布备料单',
                                                  p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                  p_apply_pk_id        => :old.prepare_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '完成生产单号：' ||
                                                                          :old.product_order_id,
                                                  p_operate_field      => 'PREPARE_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 2,
                                                  p_new_code           => 3,
                                                  p_old_value          => '生产中',
                                                  p_new_value          => '已完成',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
    ELSE
      NULL;
    END IF;
  END IF;

  --2.预计到仓日期
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.expect_arrival_time,
                                                p_new_field => :new.expect_arrival_time) = 0 THEN
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                p_apply_module       => 'a_prematerial_221_1',
                                                p_apply_module_desc  => '色布备料单明细',
                                                p_base_table         => 'COLOR_PREPARE_ORDER',
                                                p_apply_pk_id        => :old.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                p_log_type           => v_document_rec.data_source_child_code,
                                                p_log_msg            => '备料单号：' ||
                                                                        :old.prepare_order_id || '；' ||
                                                                        chr(10) ||
                                                                        '预计到仓日期：' ||
                                                                        to_char(:new.expect_arrival_time,
                                                                                'yyyy-mm-dd') ||
                                                                        ' 12:00:00' ||
                                                                        '【操作前：' ||
                                                                        to_char(:old.expect_arrival_time,
                                                                                'yyyy-mm-dd hh24:mi:ss') || '】' || '；',
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

  --3.订单量
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.order_num,
                                                p_new_field => :new.order_num) = 0 THEN
  
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                                p_apply_module       => 'a_prematerial_221_1',
                                                p_apply_module_desc  => '色布备料单明细',
                                                p_base_table         => 'COLOR_PREPARE_ORDER',
                                                p_apply_pk_id        => :old.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                p_log_type           => v_document_rec.data_source_child_code,
                                                p_log_msg            => '备料单号：' ||
                                                                        :old.prepare_order_id || '；' ||
                                                                        chr(10) ||
                                                                        '订单量：' ||
                                                                        :new.order_num ||
                                                                        '【操作前：' ||
                                                                        :old.order_num || '】' || '；',
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

