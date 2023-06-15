create or replace trigger mrp.tfg_af_iu_fabric_purchase_sheet
  after update or insert of fabric_status, already_deliver_amount,supplier_shades on mrp.t_fabric_purchase_sheet
  for each row

declare
  v_document_rec scmdata.t_document_change_trace%ROWTYPE;
 --- v_fabric_id varchar2(32);
begin

  if inserting then
    --单据变更溯源
    scmdata.pkg_plat_log.p_get_document_change_trace_params(p_company_id    => 'b6cc680ad0f599cde0531164a8c0337f',
                                                            p_document_id   => :new.fabric_id,
                                                            po_document_rec => v_document_rec);
    ---新增面料采购单（订单接口生成）
    if :new.fabric_status = 'S01' and :new.fabric_source = '0' then
    
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                  p_apply_module       => 'a_prematerial_411',
                                                  p_apply_module_desc  => '面辅料采购',
                                                  p_base_table         => 't_fabric_purchase_sheet',
                                                  p_apply_pk_id        => :new.fabric_id,
                                                  p_action_type        => 'INSERT',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '采购单来源=品牌采购单',
                                                  p_operate_field      => 'FABRIC_ID',
                                                  p_field_type         => 'VARCHAR2',
                                                  p_field_desc         => '面料采购单号',
                                                  p_old_code           => '',
                                                  p_new_code           => :new.fabric_id,
                                                  p_old_value          => '',
                                                  p_new_value          => :new.fabric_id,
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_type               => '2');
    
    elsif :new.fabric_status in ('S01', 'S02') and :new.fabric_source = '3' then
      ---替换物料sku按钮
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                  p_apply_module       => 'a_prematerial_411',
                                                  p_apply_module_desc  => '面辅料采购',
                                                  p_base_table         => 't_fabric_purchase_sheet',
                                                  p_apply_pk_id        => :new.fabric_id,
                                                  p_action_type        => 'INSERT',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '采购单来源=替换物料sku,原关联面料采购单号：' ||
                                                                          :new.old_fabric_id,
                                                  p_operate_field      => 'FABRIC_ID',
                                                  p_field_type         => 'VARCHAR2',
                                                  p_field_desc         => '面料采购单号',
                                                  p_old_code           => :new.old_fabric_id,
                                                  p_new_code           => :new.fabric_id,
                                                  p_old_value          => :new.old_fabric_id,
                                                  p_new_value          => :new.fabric_id,
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_type               => '2');
    
      ---新增面料采购单（待发货页面新增）
    elsif :new.fabric_status = 'S03' and :new.fabric_source = '2' then
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                  p_apply_module       => 'a_prematerial_420',
                                                  p_apply_module_desc  => '面辅料采购',
                                                  p_base_table         => 't_fabric_purchase_sheet',
                                                  p_apply_pk_id        => :new.fabric_id,
                                                  p_action_type        => 'INSERT',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '采购单来源=物料商发货',
                                                  p_operate_field      => 'FABRIC_ID',
                                                  p_field_type         => 'VARCHAR2',
                                                  p_field_desc         => '面料采购单号',
                                                  p_old_code           => ' ',
                                                  p_new_code           => :new.fabric_id,
                                                  p_old_value          => ' ',
                                                  p_new_value          => :new.fabric_id,
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_type               => '2');
    end if;
  
  elsif updating then
    --单据变更溯源
    scmdata.pkg_plat_log.p_get_document_change_trace_params(p_company_id    => 'b6cc680ad0f599cde0531164a8c0337f',
                                                            p_document_id   => :old.fabric_id,
                                                            po_document_rec => v_document_rec);
    ---面料采购单状态 待接单--》待发货
    if :old.fabric_status = 'S01' and :new.fabric_status = 'S02' then
    
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                  p_apply_module       => 'a_prematerial_411',
                                                  p_apply_module_desc  => '面辅料采购',
                                                  p_base_table         => 't_fabric_purchase_sheet',
                                                  p_apply_pk_id        => :old.fabric_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '操作【接单】',
                                                  p_operate_field      => 'FABRIC_ID',
                                                  p_field_type         => 'VARCHAR2',
                                                  p_field_desc         => '面料采购单号',
                                                  p_old_code           => 'S01',
                                                  p_new_code           => 'S02',
                                                  p_old_value          => '待接单',
                                                  p_new_value          => '待发货',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_type               => '2');
      ---面料采购单状态 待接单--》已取消
    elsif :old.fabric_status = 'S01' and :new.fabric_status = 'S05' then
      ---取消面料采购单按钮
      if v_document_rec.data_source_child_code = '02' then
        scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                    p_apply_module       => 'a_prematerial_411',
                                                    p_apply_module_desc  => '面辅料采购',
                                                    p_base_table         => 't_fabric_purchase_sheet',
                                                    p_apply_pk_id        => :old.fabric_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                    p_log_type           => v_document_rec.data_source_child_code,
                                                    p_log_msg            => '操作【取消面料采购单】，取消原因：' ||
                                                                            :new.cancel_cause,
                                                    p_operate_field      => 'FABRIC_ID',
                                                    p_field_type         => 'VARCHAR2',
                                                    p_field_desc         => '面料采购单号',
                                                    p_old_code           => 'S01',
                                                    p_new_code           => 'S05',
                                                    p_old_value          => '待接单',
                                                    p_new_value          => '已取消',
                                                    p_operate_company_id => v_document_rec.operate_company_id,
                                                    p_user_id            => v_document_rec.update_id,
                                                    p_type               => '2');
        ---替换物料sku按钮
      elsif v_document_rec.data_source_child_code = '04' then
/*        select max(t.fabric_id)
          into v_fabric_id
          from mrp.t_fabric_purchase_sheet t
         where t.old_fabric_id = :old.fabric_id;*/
        scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                    p_apply_module       => 'a_prematerial_411',
                                                    p_apply_module_desc  => '面辅料采购',
                                                    p_base_table         => 't_fabric_purchase_sheet',
                                                    p_apply_pk_id        => :old.fabric_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                    p_log_type           => v_document_rec.data_source_child_code,
                                                    p_log_msg            => '采购状态=已取消，关联新建面料采购单号：' ||
                                                                             substr(:new.cancel_cause, instr(:new.cancel_cause, ':') + 1),
                                                    p_operate_field      => 'FABRIC_ID',
                                                    p_field_type         => 'VARCHAR2',
                                                    p_field_desc         => '面料采购单号',
                                                    p_old_code           => 'S01',
                                                    p_new_code           => 'S05',
                                                    p_old_value          => '待接单',
                                                    p_new_value          => '已取消',
                                                    p_operate_company_id => v_document_rec.operate_company_id,
                                                    p_user_id            => v_document_rec.update_id,
                                                    p_type               => '2');
      end if;
      ---面料采购单状态 待发货--》待收货
    elsif :old.fabric_status = 'S02' and :new.fabric_status = 'S03' then
    
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                  p_apply_module       => 'a_prematerial_412',
                                                  p_apply_module_desc  => '面辅料采购',
                                                  p_base_table         => 't_fabric_purchase_sheet',
                                                  p_apply_pk_id        => :old.fabric_id,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '本次发货量=' ||
                                                                          (:new.already_deliver_amount -
                                                                          :old.already_deliver_amount) ||
                                                                          '，采购状态=已完成',
                                                  p_operate_field      => 'FABRIC_ID',
                                                  p_field_type         => 'VARCHAR2',
                                                  p_field_desc         => '',
                                                  p_old_code           => 'S02',
                                                  p_new_code           => 'S03',
                                                  p_old_value          => '待发货',
                                                  p_new_value          => '待收货',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_type               => '2');
      ---面料采购单状态 待发货--》已取消
    elsif :old.fabric_status = 'S02' and :new.fabric_status = 'S05' then
      ---取消面料采购单按钮
      if v_document_rec.data_source_child_code = '02' then
        scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                    p_apply_module       => 'a_prematerial_411',
                                                    p_apply_module_desc  => '面辅料采购',
                                                    p_base_table         => 't_fabric_purchase_sheet',
                                                    p_apply_pk_id        => :old.fabric_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                    p_log_type           => v_document_rec.data_source_child_code,
                                                    p_log_msg            => '操作【取消面料采购单】，取消原因：' ||
                                                                            :new.cancel_cause,
                                                    p_operate_field      => 'FABRIC_ID',
                                                    p_field_type         => 'VARCHAR2',
                                                    p_field_desc         => '面料采购单号',
                                                    p_old_code           => 'S02',
                                                    p_new_code           => 'S05',
                                                    p_old_value          => '待发货',
                                                    p_new_value          => '已取消',
                                                    p_operate_company_id => v_document_rec.operate_company_id,
                                                    p_user_id            => v_document_rec.update_id,
                                                    p_type               => '2');
        ---替换物料sku按钮
      elsif v_document_rec.data_source_child_code = '04' then
/*        select max(t.fabric_id)
          into v_fabric_id
          from mrp.t_fabric_purchase_sheet t
         where t.old_fabric_id = :old.fabric_id;*/
        scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                    p_apply_module       => 'a_prematerial_411',
                                                    p_apply_module_desc  => '面辅料采购',
                                                    p_base_table         => 't_fabric_purchase_sheet',
                                                    p_apply_pk_id        => :old.fabric_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                    p_log_type           => v_document_rec.data_source_child_code,
                                                    p_log_msg            => '采购状态=已取消，关联新建面料采购单号：' ||
                                                                            substr(:new.cancel_cause, instr(:new.cancel_cause, ':') + 1),
                                                    p_operate_field      => 'FABRIC_ID',
                                                    p_field_type         => 'VARCHAR2',
                                                    p_field_desc         => '面料采购单号',
                                                    p_old_code           => 'S01',
                                                    p_new_code           => 'S05',
                                                    p_old_value          => '待接单',
                                                    p_new_value          => '已取消',
                                                    p_operate_company_id => v_document_rec.operate_company_id,
                                                    p_user_id            => v_document_rec.update_id,
                                                    p_type               => '2');
      end if;
      ---面料采购单状态 待发货--》待发货
    elsif :old.fabric_status = 'S02' and :new.fabric_status = 'S02' then
      ---判断发货量是否一致
      if :old.already_deliver_amount <> :new.already_deliver_amount then
        scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                    p_apply_module       => 'a_prematerial_412',
                                                    p_apply_module_desc  => '面辅料采购',
                                                    p_base_table         => 't_fabric_purchase_sheet',
                                                    p_apply_pk_id        => :old.fabric_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                    p_log_type           => v_document_rec.data_source_child_code,
                                                    p_log_msg            => '本次发货量=' ||
                                                                            (:new.already_deliver_amount -
                                                                            :old.already_deliver_amount),
                                                    p_operate_field      => 'FABRIC_ID',
                                                    p_field_type         => 'VARCHAR2',
                                                    p_field_desc         => '',
                                                    p_old_code           => 'S02',
                                                    p_new_code           => ' ',
                                                    p_old_value          => '待发货',
                                                    p_new_value          => ' ',
                                                    p_operate_company_id => v_document_rec.operate_company_id,
                                                    p_user_id            => v_document_rec.update_id,
                                                    p_type               => '2');
      end if;
    end if;
   if :old.supplier_shades is null and :new.supplier_shades is not null then
        scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                    p_apply_module       => 'a_prematerial_411',
                                                    p_apply_module_desc  => '面辅料采购',
                                                    p_base_table         => 't_fabric_purchase_sheet',
                                                    p_apply_pk_id        => :old.fabric_id,
                                                    p_action_type        => 'UPDATE',
                                                    p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                    p_log_type           => v_document_rec.data_source_child_code,
                                                    p_log_msg            => '操作【补录供应商色号】，供应商色号：' ||
                                                                            :new.supplier_shades ,
                                                    p_operate_field      => 'FABRIC_ID',
                                                    p_field_type         => 'VARCHAR2',
                                                    p_field_desc         => '',
                                                    p_old_code           => ' ',
                                                    p_new_code           => :new.supplier_shades,
                                                    p_old_value          => ' ',
                                                    p_new_value          => :new.supplier_shades,
                                                    p_operate_company_id => v_document_rec.operate_company_id,
                                                    p_user_id            => v_document_rec.update_id,
                                                    p_type               => '2');
   end if;
  end if;
end;
/

