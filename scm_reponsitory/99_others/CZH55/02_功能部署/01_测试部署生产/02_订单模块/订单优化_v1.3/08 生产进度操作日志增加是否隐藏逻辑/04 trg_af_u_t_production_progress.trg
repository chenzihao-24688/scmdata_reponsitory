CREATE OR REPLACE TRIGGER trg_af_u_t_production_progress
  AFTER UPDATE OF progress_status, product_gress_remarks, curlink_complet_ratio, progress_update_date, order_rise_status, plan_delivery_date, delay_problem_class, delay_cause_class, delay_cause_detailed, is_sup_responsible, responsible_dept, responsible_dept_sec, problem_desc ON t_production_progress
  FOR EACH ROW
DECLARE
  vo_log_id                  VARCHAR2(32);
  v_company_id               VARCHAR2(32) := :old.company_id;
  v_apply_pk_id              VARCHAR2(32) := :old.product_gress_id;
  v_old_status               VARCHAR2(256);
  v_new_status               VARCHAR2(256);
  v_old_rise                 VARCHAR2(256);
  v_new_rise                 VARCHAR2(256);
  v_old_responsible_dept     VARCHAR2(256);
  v_new_responsible_dept     VARCHAR2(256);
  v_old_responsible_dept_sec VARCHAR2(256);
  v_new_responsible_dept_sec VARCHAR2(256);
BEGIN
  --1.操作类型为生产进度
  --1)进度状态
  --获取进度状态字典值
  IF :old.progress_status IS NOT NULL THEN
    v_old_status := scmdata.pkg_production_progress_a.f_get_progress_status(p_status_code => :old.progress_status,
                                                                            p_company_id  => v_company_id);
  END IF;
  IF :new.progress_status IS NOT NULL THEN
    v_new_status := scmdata.pkg_production_progress_a.f_get_progress_status(p_status_code => :new.progress_status,
                                                                            p_company_id  => v_company_id);
  END IF;

  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_type           => '00',
                                         p_field_desc         => '生产进度状态',
                                         p_operate_field      => 'progress_status',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => :old.progress_status,
                                         p_new_code           => :new.progress_status,
                                         p_old_value          => v_old_status,
                                         p_new_value          => v_new_status,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 1,
                                         po_log_id            => vo_log_id);

  --2)进度说明
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '00',
                                         p_field_desc         => '生产进度说明',
                                         p_operate_field      => 'product_gress_remarks',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => NULL,
                                         p_new_code           => NULL,
                                         p_old_value          => :old.product_gress_remarks,
                                         p_new_value          => :new.product_gress_remarks,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 2,
                                         po_log_id            => vo_log_id);
  --3)当前环节完成比例
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '00',
                                         p_field_desc         => '当前环节完成比例',
                                         p_operate_field      => 'curlink_complet_ratio',
                                         p_field_type         => 'NUMBER',
                                         p_old_code           => NULL,
                                         p_new_code           => NULL,
                                         p_old_value          => to_char(round(:old.curlink_complet_ratio,
                                                                               2),
                                                                         'fm990.90') || '%',
                                         p_new_value          => to_char(round(:new.curlink_complet_ratio,
                                                                               2),
                                                                         'fm990.90') || '%',
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 3,
                                         po_log_id            => vo_log_id);
  --4)进度更新日期   
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '00',
                                         p_field_desc         => '进度更新日期',
                                         p_operate_field      => 'progress_update_date',
                                         p_field_type         => 'DATE',
                                         p_old_code           => NULL,
                                         p_new_code           => NULL,
                                         p_old_value          => to_char(:old.progress_update_date,
                                                                         'yyyy-MM-dd'),
                                         p_new_value          => to_char(:new.progress_update_date,
                                                                         'yyyy-MM-dd'),
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 4,
                                         po_log_id            => vo_log_id);
  --5)订单风险状态    
  --获取订单风险状态字典值
  IF :old.order_rise_status IS NOT NULL THEN
    v_old_rise := scmdata.pkg_plat_comm.f_get_platorcompany_dict(p_type            => 'ORDER_RISE_STATUS',
                                                                 p_value           => :old.order_rise_status,
                                                                 p_is_company_dict => 0);
  END IF;
  IF :new.order_rise_status IS NOT NULL THEN
    v_new_rise := scmdata.pkg_plat_comm.f_get_platorcompany_dict(p_type            => 'ORDER_RISE_STATUS',
                                                                 p_value           => :new.order_rise_status,
                                                                 p_is_company_dict => 0);
  END IF;

  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '00',
                                         p_field_desc         => '订单风险状态',
                                         p_operate_field      => 'order_rise_status',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => :old.order_rise_status,
                                         p_new_code           => :new.order_rise_status,
                                         p_old_value          => v_old_rise,
                                         p_new_value          => v_new_rise,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 5,
                                         po_log_id            => vo_log_id);
  --6)计划到仓日期
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '00',
                                         p_field_desc         => '计划到仓日期',
                                         p_operate_field      => 'order_rise_status',
                                         p_field_type         => 'DATE',
                                         p_old_code           => NULL,
                                         p_new_code           => NULL,
                                         p_old_value          => to_char(:old.plan_delivery_date,
                                                                         'yyyy-MM-dd'),
                                         p_new_value          => to_char(:new.plan_delivery_date,
                                                                         'yyyy-MM-dd'),
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 6,
                                         po_log_id            => vo_log_id);

  --7)将日志明细拼接 并更新日志主表 log_msg
  scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id => v_company_id,
                                            p_log_id     => vo_log_id,
                                            p_is_logsmsg => 1);

  --2.操作类型为延期原因
  --延期问题
  --置空，重新获取log_id
  vo_log_id := NULL;
  --1）延期问题分类 
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '01',
                                         p_field_desc         => '延期问题分类',
                                         p_operate_field      => 'delay_problem_class',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => NULL,
                                         p_new_code           => NULL,
                                         p_old_value          => :old.delay_problem_class,
                                         p_new_value          => :new.delay_problem_class,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 1,
                                         po_log_id            => vo_log_id);
  --2）延期原因分类
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '01',
                                         p_field_desc         => '延期原因分类',
                                         p_operate_field      => 'delay_cause_class',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => NULL,
                                         p_new_code           => NULL,
                                         p_old_value          => :old.delay_cause_class,
                                         p_new_value          => :new.delay_cause_class,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 2,
                                         po_log_id            => vo_log_id);
  --3）延期原因细分
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '01',
                                         p_field_desc         => '延期原因细分',
                                         p_operate_field      => 'delay_cause_detailed',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => NULL,
                                         p_new_code           => NULL,
                                         p_old_value          => :old.delay_cause_detailed,
                                         p_new_value          => :new.delay_cause_detailed,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 3,
                                         po_log_id            => vo_log_id);
  --4）供应商是否免责
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '01',
                                         p_field_desc         => '供应商是否免责',
                                         p_operate_field      => 'is_sup_responsible',
                                         p_field_type         => 'NUMBER',
                                         p_old_code           => :old.is_sup_responsible,
                                         p_new_code           => :new.is_sup_responsible,
                                         p_old_value          => (CASE
                                                                   WHEN :old.is_sup_responsible = 1 THEN
                                                                    '是'
                                                                   ELSE
                                                                    '否'
                                                                 END),
                                         p_new_value          => (CASE
                                                                   WHEN :new.is_sup_responsible = 1 THEN
                                                                    '是'
                                                                   ELSE
                                                                    '否'
                                                                 END),
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 4,
                                         p_is_show            => 0,
                                         po_log_id            => vo_log_id);

  --获取责任部门名称
  v_old_responsible_dept     := scmdata.pkg_plat_comm.f_get_company_deptname(p_company_id => v_company_id,
                                                                             p_dept_id    => :old.responsible_dept);
  v_new_responsible_dept     := scmdata.pkg_plat_comm.f_get_company_deptname(p_company_id => v_company_id,
                                                                             p_dept_id    => :new.responsible_dept);
  v_old_responsible_dept_sec := scmdata.pkg_plat_comm.f_get_company_deptname(p_company_id => v_company_id,
                                                                             p_dept_id    => :old.responsible_dept_sec);
  v_new_responsible_dept_sec := scmdata.pkg_plat_comm.f_get_company_deptname(p_company_id => v_company_id,
                                                                             p_dept_id    => :new.responsible_dept_sec);
  --5）责任部门1级
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '01',
                                         p_field_desc         => '责任部门1级',
                                         p_operate_field      => 'responsible_dept',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => :old.responsible_dept,
                                         p_new_code           => :new.responsible_dept,
                                         p_old_value          => v_old_responsible_dept,
                                         p_new_value          => v_new_responsible_dept,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 5,
                                         p_is_show            => 0,
                                         po_log_id            => vo_log_id);
  --5）责任部门2级
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '01',
                                         p_field_desc         => '责任部门2级',
                                         p_operate_field      => 'responsible_dept_sec',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => :old.responsible_dept_sec,
                                         p_new_code           => :new.responsible_dept_sec,
                                         p_old_value          => v_old_responsible_dept_sec,
                                         p_new_value          => v_new_responsible_dept_sec,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 6,
                                         p_is_show            => 0,
                                         po_log_id            => vo_log_id);
  --5）问题描述
  scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                         p_apply_module       => 'a_product_110',
                                         p_base_table         => 't_production_progress',
                                         p_apply_pk_id        => v_apply_pk_id,
                                         p_action_type        => 'UPDATE',
                                         p_log_id             => vo_log_id,
                                         p_log_type           => '01',
                                         p_field_desc         => '问题描述',
                                         p_operate_field      => 'responsible_dept_sec',
                                         p_field_type         => 'VARCHAR',
                                         p_old_code           => NULL,
                                         p_new_code           => NULL,
                                         p_old_value          => :old.problem_desc,
                                         p_new_value          => :new.problem_desc,
                                         p_user_id            => :new.update_id,
                                         p_operate_company_id => :new.update_company_id,
                                         p_seq_no             => 6,
                                         po_log_id            => vo_log_id);
  --2)将日志明细拼接 并更新日志主表 log_msg
  scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id       => v_company_id,
                                            p_log_id           => vo_log_id,
                                            p_is_logsmsg       => 1,
                                            p_is_flhide_fileds => 1);

END trg_af_u_t_production_progress;
/
