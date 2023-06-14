DECLARE
  v_update_company_id VARCHAR2(256);
  vo_log_id           VARCHAR2(32) := NULL;
  v_new_factory       VARCHAR2(256);
  v_old_factory       VARCHAR2(256);
BEGIN
  FOR i IN (SELECT a.order_id,
                   a.company_id,
                   a.old_designate_factory,
                   a.new_designate_factory,
                   a.operate_person,
                   a.operator,
                   a.operate_time
              FROM scmdata.t_order_log a) LOOP
    IF i.operator = 'NEED' THEN
      v_update_company_id := 'b6cc680ad0f599cde0531164a8c0337f';
    ELSE
      SELECT MAX(sp.supplier_company_id)
        INTO v_update_company_id
        FROM scmdata.t_ordered od
       INNER JOIN scmdata.t_supplier_info sp
          ON sp.supplier_code = od.supplier_code
         AND sp.company_id = od.company_id
       WHERE od.order_id = i.order_id
         AND od.company_id = i.company_id;
    END IF;
  
    --指定工厂
    v_new_factory := scmdata.pkg_plat_comm.f_get_sup_name(p_company_id    => i.company_id,
                                                          p_sup_code      => i.new_designate_factory,
                                                          p_is_inner_code => 0,
                                                          p_is_short_name => 1);
  
    --指定工厂
    v_old_factory := scmdata.pkg_plat_comm.f_get_sup_name(p_company_id    => i.company_id,
                                                          p_sup_code      => i.old_designate_factory,
                                                          p_is_inner_code => 0,
                                                          p_is_short_name => 1);
  
    scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => i.company_id,
                                           p_apply_module       => 'a_order_101_0',
                                           p_base_table         => 't_orders',
                                           p_apply_pk_id        => i.order_id,
                                           p_action_type        => 'UPDATE',
                                           p_log_type           => '01',
                                           p_field_desc         => '工厂名称',
                                           p_operate_field      => 'factory_code',
                                           p_field_type         => 'VARCHAR',
                                           p_old_code           => i.old_designate_factory,
                                           p_new_code           => i.new_designate_factory,
                                           p_old_value          => v_old_factory,
                                           p_new_value          => v_new_factory,
                                           p_user_id            => i.operate_person,
                                           p_operate_company_id => v_update_company_id,
                                           p_seq_no             => 1,
                                           po_log_id            => vo_log_id);
  
    --修改操作时间                                      
    scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id => i.company_id,
                                              p_log_id     => vo_log_id,
                                              p_is_logsmsg => 1);
  
    UPDATE scmdata.t_plat_log t
       SET t.create_time = i.operate_time, t.update_time = i.operate_time
     WHERE t.log_id = vo_log_id;
    vo_log_id := NULL;
  END LOOP;
END;
/
