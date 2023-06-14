DECLARE
  v_log_id     VARCHAR2(32) := NULL;
  v_flag       INT;
  v_company_id VARCHAR2(32);
BEGIN
  FOR l_rec IN (SELECT b.product_gress_code,
                       v.log_type,
                       v.operate_company_id,
                       v.operate_user_id,
                       v.operate_time,
                       v.product_gress_id,
                       b.company_id,
                       v.old_operate_remarks,
                       v.new_operate_remarks
                  FROM (SELECT row_number() over(PARTITION BY a.product_gress_id, a.company_id ORDER BY a.operate_time ASC) rn,
                               a.log_type,
                               a.operate_company_id,
                               a.operate_user_id,
                               a.operate_time,
                               a.product_gress_id,
                               a.company_id,
                               a.old_operate_remarks,
                               a.new_operate_remarks
                          FROM scmdata.t_production_progress_log a
                         WHERE a.company_id <>
                               'b6cc680ad0f599cde0531164a8c0337f') v
                 INNER JOIN scmdata.t_production_progress b
                    ON b.product_gress_id = v.product_gress_id
                 ORDER BY v.product_gress_id, v.rn) LOOP
    --判断是否日志主表是否已存在LOG_ID
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_plat_log t
     WHERE t.log_id = v_log_id;
    --新增日志主表
    IF v_flag > 0 THEN
      NULL;
    ELSE
      scmdata.pkg_plat_log.p_insert_t_plat_log(p_company_id         => l_rec.company_id,
                                               p_apply_module       => 'a_product_110',
                                               p_base_table         => upper('T_PRODUCTION_PROGRESS'),
                                               p_apply_pk_id        => l_rec.product_gress_id,
                                               p_action_type        => upper('UPDATE'),
                                               p_log_type           => '00',
                                               p_log_msg            => NULL, --1.手动编写 2.如有日志明细 则设置自动赋值
                                               p_user_id            => l_rec.operate_user_id,
                                               p_operate_company_id => l_rec.operate_company_id,
                                               po_log_id            => v_log_id);
    END IF;
    --新增日志明细
    scmdata.pkg_plat_log.p_insert_plat_logs(p_log_id         => v_log_id,
                                            p_company_id     => l_rec.company_id,
                                            p_field_desc     => '生产进度说明',
                                            p_operate_field  => upper('PRODUCT_GRESS_REMARKS'),
                                            p_field_type     => upper('VARCHAR2'),
                                            p_old_code       => NULL,
                                            p_new_code       => NULL,
                                            p_old_value      => l_rec.old_operate_remarks,
                                            p_new_value      => l_rec.new_operate_remarks,
                                            p_operate_reason => '因订单优化1.3版本上线，操作日志迁移，系统管理员补充历史数据。',
                                            p_seq_no         => 1);
  
    scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id => l_rec.company_id,
                                              p_log_id     => v_log_id,
                                              p_is_logsmsg => 1);
  
    UPDATE scmdata.t_plat_log t
       SET t.create_time = l_rec.operate_time,
           t.update_time = l_rec.operate_time
     WHERE t.log_id = v_log_id
       AND t.company_id = l_rec.company_id;
    v_log_id := NULL;
  END LOOP;
END;

