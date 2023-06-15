CREATE OR REPLACE TRIGGER MRP.TRG_AF_U_GREY_PREPARE_PRODUCT_ORDER
  AFTER UPDATE OF product_status, BATCH_FINISH_NUM ON mrp.GREY_PREPARE_PRODUCT_ORDER
  FOR EACH ROW
DECLARE
  /*v_operate_company_id VARCHAR2(32);
  v_ds_parent_code     VARCHAR2(32);
  v_ds_child_code      VARCHAR2(32);
  v_user_id            VARCHAR2(32);*/
  V_REC SCMDATA.T_DOCUMENT_CHANGE_TRACE%ROWTYPE;
BEGIN
  --记录生产单操作日志
  
   SCMDATA.PKG_PLAT_LOG.P_GET_DOCUMENT_CHANGE_TRACE_PARAMS(P_COMPANY_ID    =>  'b6cc680ad0f599cde0531164a8c0337f',
                                                            P_DOCUMENT_ID   => :old.product_order_id,
                                                            PO_DOCUMENT_REC => V_REC);  
  
  /*SELECT t.operate_company_id,
         t.data_source_parent_code,
         t.data_source_child_code,
         t.update_id
    INTO v_operate_company_id, v_ds_parent_code, v_ds_child_code, v_user_id
    FROM scmdata.t_document_change_trace t
   WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
     AND t.document_id = :old.product_order_id;*/

  --生产单状态
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.product_status,
                                                p_new_field => :new.product_status) = 0 THEN

    --1.1 取消订单 生产中 => 已取消
    IF :old.product_status = 1 AND :new.product_status = 3 THEN
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                  p_apply_module       => 'a_prematerial_212',
                                                  p_apply_module_desc  => '坯布备料单',
                                                  p_base_table         => 'GREY_PREPARE_PRODUCT_ORDER',
                                                  p_apply_pk_id        => :old.product_order_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_rec.data_source_parent_code,
                                                  p_log_type           => v_rec.data_source_child_code,
                                                  p_log_msg            => '取消生产单号：' ||
                                                                          :old.product_order_id,
                                                  p_operate_field      => 'PRODUCT_STATUS',
                                                  p_field_type         => 'NUMBER',
                                                  p_field_desc         => NULL,
                                                  p_old_code           => 1,
                                                  p_new_code           => 3,
                                                  p_old_value          => '生产中',
                                                  p_new_value          => '已取消',
                                                  p_operate_company_id => v_rec.operate_company_id,
                                                  p_user_id            => v_rec.update_id,
                                                  p_memo               => NULL,
                                                  p_memo_desc          => NULL,
                                                  p_type               => 2);
      --1.1 完成生产单 生产中 => 已完成
      IF :old.product_status = 1 AND :new.product_status = 2 THEN
        scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                    p_apply_module       => 'a_prematerial_212',
                                                    p_apply_module_desc  => '坯布备料单',
                                                    p_base_table         => 'GREY_PREPARE_PRODUCT_ORDER',
                                                    p_apply_pk_id        => :old.product_order_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_rec.data_source_parent_code,
                                                    p_log_type           => v_rec.data_source_child_code,
                                                    p_log_msg            => '完成生产单号：' ||
                                                                            :old.product_order_id || '；' ||
                                                                            chr(10) ||
                                                                            '完成数量：' ||
                                                                            to_char(to_number(:new.finish_num)) ||
                                                                            '【操作前:' ||
                                                                            to_char(to_number(:old.finish_num)) || '】' || '；' ||
                                                                            chr(10) ||
                                                                            (CASE WHEN :new.product_status = 2 THEN '【生产单状态】:已完成' || '；'
                                                                              ELSE  NULL   END),
                                                    p_operate_field      => 'PRODUCT_STATUS',
                                                    p_field_type         => 'NUMBER',
                                                    p_field_desc         => NULL,
                                                    p_old_code           => 1,
                                                    p_new_code           => 2,
                                                    p_old_value          => '生产中',
                                                    p_new_value          => (CASE   WHEN :new.product_status = 2 THEN '已完成'
                                                                              ELSE   NULL       END),
                                                    p_operate_company_id => v_rec.operate_company_id,
                                                  p_user_id            => v_rec.update_id,
                                                    p_memo               => NULL,
                                                    p_memo_desc          => NULL,
                                                    p_type               => 2);
        NULL;
      END IF;
    ELSE
      NULL;
    END IF;
  END IF;
  IF scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.BATCH_FINISH_NUM,
                                                p_new_field => :new.BATCH_FINISH_NUM) = 0 AND :new.product_status = 1 THEN
                      
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                    p_apply_module       => 'a_prematerial_212',
                                                    p_apply_module_desc  => '坯布备料单',
                                                    p_base_table         => 'GREY_PREPARE_PRODUCT_ORDER',
                                                    p_apply_pk_id        => :old.product_order_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_rec.data_source_parent_code,
                                                    p_log_type           => v_rec.data_source_child_code,
                                                    p_log_msg            => '完成生产单号：' ||
                                                                            :old.product_order_id || '；' ||
                                                                            chr(10) ||
                                                                            '完成数量：' ||
                                                                            to_char(to_number(:new.BATCH_FINISH_NUM)) ||
                                                                            '【操作前:' ||
                                                                            to_char(to_number(:old.BATCH_FINISH_NUM)) || '】；'  ,
                                                    p_operate_field      => 'BATCH_FINISH_NUM',
                                                    p_field_type         => 'NUMBER',
                                                    p_field_desc         => NULL,
                                                    p_old_code           => 1,
                                                    p_new_code           => 2,
                                                    p_old_value          => :old.BATCH_FINISH_NUM,
                                                    p_new_value          => :new.BATCH_FINISH_NUM,
                                                    p_operate_company_id => v_rec.operate_company_id,
                                                    p_user_id            => v_rec.update_id,
                                                    p_memo               => NULL,
                                                    p_memo_desc          => NULL,
                                                    p_type               => 2);                                       
                                                
  END IF;                                             
  
END TRG_AF_U_GREY_PREPARE_PRODUCT_ORDER;
/

