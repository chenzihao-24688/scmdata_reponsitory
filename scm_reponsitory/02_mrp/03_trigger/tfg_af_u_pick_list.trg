create or replace trigger mrp.tfg_af_u_pick_list
  after update or insert of pick_status ,pick_num on mrp.pick_list
  for each row

declare

  v_document_rec scmdata.t_document_change_trace%ROWTYPE;
begin
if updating then
    --单据变更溯源
    scmdata.pkg_plat_log.p_get_document_change_trace_params(p_company_id    => 'b6cc680ad0f599cde0531164a8c0337f',
                                                            p_document_id   => :old.pick_lict_code,
                                                            po_document_rec => v_document_rec);
    ---领料状态 待完成--》已取消
    if :old.pick_status = 0 and :new.pick_status = 2 then
    
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                  p_apply_module       => 'a_prematerial_301',
                                                  p_apply_module_desc  => '领料任务',
                                                  p_base_table         => 'PICK_LIST',
                                                  p_apply_pk_id        => :old.pick_lict_code,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '操作【取消领料单】，取消原因:' ||
                                                                          :new.cancel_reason,
                                                  p_operate_field      => 'PICK_STATUS',
                                                  p_field_type         => 'VARCHAR2',
                                                  p_field_desc         => '领料状态',
                                                  p_old_code           => 0,
                                                  p_new_code           => 2,
                                                  p_old_value          => '待完成',
                                                  p_new_value          => '已取消',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_type               => '2');
    
      ---领料状态 待完成--》已完成
    elsif :old.pick_status = 0 and :new.pick_status = 1 then
    
      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_document_rec.company_id,
                                                  p_apply_module       => 'a_prematerial_301',
                                                  p_apply_module_desc  => '领料任务',
                                                  p_base_table         => 'PICK_LIST',
                                                  p_apply_pk_id        => :old.pick_lict_code,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '操作【领料出库】，本次领料量=' ||
                                                                          (:new.pick_num - :old.pick_num) ||
                                                                          '，领料状态=已完成',
                                                  p_operate_field      => 'PICK_STATUS',
                                                  p_field_type         => 'VARCHAR2',
                                                  p_field_desc         => '领料状态',
                                                  p_old_code           => 0,
                                                  p_new_code           => 1,
                                                  p_old_value          => '待完成',
                                                  p_new_value          => '已完成',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_type               => '2');
      ---领料状态 待完成--》待完成
    elsif :old.pick_status = 0 and :new.pick_status = 0 then

      if :old.pick_num <> :new.pick_num then

      scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => :old.company_id,
                                                  p_apply_module       => 'a_prematerial_301',
                                                  p_apply_module_desc  => '领料任务',
                                                  p_base_table         => 'PICK_LIST',
                                                  p_apply_pk_id        => :old.pick_lict_code,
                                                  p_action_type        => 'UPDATE',
                                                  p_log_dict_type      => v_document_rec.data_source_parent_code,
                                                  p_log_type           => v_document_rec.data_source_child_code,
                                                  p_log_msg            => '操作【领料出库】，本次领料量=' ||
                                                                          (:new.pick_num - :old.pick_num)  ,
                                                  p_operate_field      => 'PICK_STATUS',
                                                  p_field_type         => 'VARCHAR2',
                                                  p_field_desc         => '领料状态',
                                                  p_old_code           => 0,
                                                  p_new_code           => 1,
                                                  p_old_value          => ' ',
                                                  p_new_value          => '待完成',
                                                  p_operate_company_id => v_document_rec.operate_company_id,
                                                  p_user_id            => v_document_rec.update_id,
                                                  p_type               => '2');
      end if;  
    end if;
  end if;
end;
/

