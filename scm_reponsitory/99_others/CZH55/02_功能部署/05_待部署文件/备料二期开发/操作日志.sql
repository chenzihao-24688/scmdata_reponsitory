--������־
BEGIN
  pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                      p_apply_module       => 'a_prematerial_220',
                                      p_apply_module_desc  => '���ϵ�����',
                                      p_base_table         => 'COLOR_PREPARE_ORDER',
                                      p_apply_pk_id        => 'PREPARE_ORDER_ID',
                                      p_action_type        => 'UPDATE',
                                      p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                      p_log_type           => '00',
                                      p_log_msg            => '���ϵ���' ||:prepare_order_id ||'���ӵ�',
                                      p_operate_field      => 'PREPARE_STATUS',
                                      p_field_type         => 'NUMBER',
                                      p_field_desc         => '���ϵ�״̬',
                                      p_old_code           => 1,
                                      p_new_code           => 2,
                                      p_old_value          => '���ӵ�',
                                      p_new_value          => '������',
                                      p_operate_company_id => %default_company_id%,
                                      p_user_id            => :user_id,
                                      p_type               => 2);
END;
