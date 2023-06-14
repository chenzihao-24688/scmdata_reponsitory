--操作日志
BEGIN
  pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'a972dd1ffe3b3a10e0533c281cac8fd7',
                                      p_apply_module       => 'a_prematerial_220',
                                      p_apply_module_desc  => '备料单管理',
                                      p_base_table         => 'COLOR_PREPARE_ORDER',
                                      p_apply_pk_id        => 'PREPARE_ORDER_ID',
                                      p_action_type        => 'UPDATE',
                                      p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                      p_log_type           => '00',
                                      p_log_msg            => '备料单号' ||:prepare_order_id ||'被接单',
                                      p_operate_field      => 'PREPARE_STATUS',
                                      p_field_type         => 'NUMBER',
                                      p_field_desc         => '备料单状态',
                                      p_old_code           => 1,
                                      p_new_code           => 2,
                                      p_old_value          => '待接单',
                                      p_new_value          => '生产中',
                                      p_operate_company_id => %default_company_id%,
                                      p_user_id            => :user_id,
                                      p_type               => 2);
END;
