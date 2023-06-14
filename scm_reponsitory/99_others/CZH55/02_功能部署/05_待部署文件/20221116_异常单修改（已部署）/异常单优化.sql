DECLARE
  v_abnormal_code VARCHAR2(32);
  p_abn_rec       scmdata.t_abnormal%ROWTYPE;
  v_order_amount  NUMBER;
  v_abn_origin    VARCHAR2(32);
BEGIN

  p_abn_rec.abnormal_id          := scmdata.f_get_uuid();
  p_abn_rec.company_id           := %default_company_id%;
  p_abn_rec.abnormal_code        := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_abnormal',
                                                                       pi_column_name => 'abnormal_code',
                                                                       pi_company_id  => %default_company_id%,
                                                                       pi_pre         => 'ABN',
                                                                       pi_serail_num  => '6');
  p_abn_rec.order_id             := :order_id_pr;
  p_abn_rec.progress_status      := '00';
  p_abn_rec.goo_id               := :goo_id_pr;
  p_abn_rec.anomaly_class        := nvl(:anomaly_class_pr, ' ');
  p_abn_rec.problem_class        := nvl(:delay_problem_class_pr, ' ');
  p_abn_rec.cause_class          := nvl(:delay_cause_class_pr, ' ');
  p_abn_rec.cause_detailed       := nvl(:delay_cause_detailed_pr, ' ');
  p_abn_rec.detailed_reasons     := nvl(:problem_desc_pr, ' ');
  p_abn_rec.is_sup_responsible   := :is_sup_responsible;
  p_abn_rec.responsible_dept_sec := :responsible_dept_sec;
  p_abn_rec.delay_date           := :delay_date;
  p_abn_rec.abnormal_range       := '00';

  SELECT nvl(MAX(t.order_amount), 0)
    INTO v_order_amount
    FROM scmdata.t_production_progress t
   WHERE t.goo_id = :goo_id_pr
     AND t.order_id = :order_id_pr
     AND t.company_id = %default_company_id%;

  p_abn_rec.delay_amount         := v_order_amount;
  p_abn_rec.responsible_party    := nvl(:responsible_party, ' ');
  p_abn_rec.responsible_dept     := nvl(:responsible_dept, ' ');
  p_abn_rec.handle_opinions      := :handle_opinions;
  p_abn_rec.quality_deduction    := nvl(:quality_deduction, 0);
  p_abn_rec.is_deduction         := nvl(:is_deduction, 0);
  p_abn_rec.deduction_method     := :deduction_method_pr;
  p_abn_rec.deduction_unit_price := :deduction_unit_price_pr;
  p_abn_rec.applicant_id         := :user_id;
  p_abn_rec.applicant_date       := SYSDATE;
  p_abn_rec.create_id            := :user_id;
  p_abn_rec.create_time          := SYSDATE;
  p_abn_rec.update_id            := :user_id;
  p_abn_rec.update_time          := SYSDATE;
  --p_abn_rec.origin               := 'MA';
  p_abn_rec.memo := :memo_pr;
  --20220708 781 异常处理相关优化
  p_abn_rec.origin     := 'MA';
  p_abn_rec.origin_id  := p_abn_rec.abnormal_id; --来源ID
  p_abn_rec.orgin_type := 'ABN'; --来源类型
 
  IF :anomaly_class_pr = 'AC_DATE' THEN
    p_abn_rec.abnormal_orgin := NULL;
    p_abn_rec.checker        := NULL; --查货人 待做
    p_abn_rec.check_link     := NULL; --查货环节
    p_abn_rec.check_num      := NULL;
  ELSE
     --异常来源  获取员工对应的三级部门ID
    v_abn_origin             := scmdata.pkg_production_progress.f_get_user_third_dept_id(p_user_id    => :user_id,
                                                                                         p_company_id => %default_company_id%);
    p_abn_rec.abnormal_orgin := v_abn_origin;
    p_abn_rec.checker        := NULL; --查货人
    p_abn_rec.check_link := CASE
                              WHEN v_abn_origin IN
                                   ('ed7ff3c7135a236ae0533c281caccd8d', '14') THEN
                               'QC_FINAL_CHECK'
                              WHEN v_abn_origin = '16' THEN
                               'AC'
                              ELSE
                               NULL
                            END; --查货环节
    p_abn_rec.check_num := CASE
                             WHEN v_abn_origin IN ('ed7ff3c7135a236ae0533c281caccd8d',
                                                   '14',
                                                   '16') THEN
                              1
                             ELSE
                              NULL
                           END;
  END IF;
  --提交异常单
  scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);
END;
