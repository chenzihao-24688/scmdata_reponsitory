DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  p_abn_rec scmdata.t_abnormal%ROWTYPE;
BEGIN
  FOR i IN (SELECT *
              FROM scmdata.t_abnormal abn
             WHERE abn.abnormal_id IN (@selection)) LOOP
    p_abn_rec.abnormal_id          := i.abnormal_id;
    p_abn_rec.company_id           := i.company_id;
    p_abn_rec.abnormal_code        := i.abnormal_code;
    p_abn_rec.order_id             := i.order_id;
    p_abn_rec.progress_status      := i.progress_status;
    p_abn_rec.goo_id               := i.goo_id;
    p_abn_rec.anomaly_class        := i.anomaly_class;
    p_abn_rec.problem_class        := i.problem_class;
    p_abn_rec.cause_class          := i.cause_class;
    p_abn_rec.detailed_reasons     := i.detailed_reasons;
    p_abn_rec.delay_date           := i.delay_date;
    p_abn_rec.delay_amount         := i.delay_amount;
    p_abn_rec.responsible_party    := i.responsible_party;
    p_abn_rec.responsible_dept     := i.responsible_dept;
    p_abn_rec.handle_opinions      := i.handle_opinions;
    p_abn_rec.quality_deduction    := i.quality_deduction;
    p_abn_rec.is_deduction         := i.is_deduction;
    p_abn_rec.deduction_unit_price := i.deduction_unit_price;
    p_abn_rec.file_id              := i.file_id;
    p_abn_rec.applicant_id         := i.applicant_id;
    p_abn_rec.applicant_date       := i.applicant_date;   
    p_abn_rec.confirm_id           := :user_id;
    p_abn_rec.confirm_company_id   := %default_company_id%;
    p_abn_rec.confirm_date         := SYSDATE;   
    p_abn_rec.create_id            := i.create_id;
    p_abn_rec.create_time          := i.create_time;
    p_abn_rec.origin               := i.origin;
    p_abn_rec.origin_id            := i.origin_id;
    p_abn_rec.memo                 := i.memo;
    p_abn_rec.update_id            := i.update_id;
    p_abn_rec.update_time          := i.update_time;
    p_abn_rec.deduction_method     := i.deduction_method;
    p_abn_rec.responsible_dept_sec := i.responsible_dept_sec;
    p_abn_rec.is_sup_responsible   := i.is_sup_responsible;
    p_abn_rec.cause_detailed       := i.cause_detailed;
  
    scmdata.pkg_production_progress.confirm_abnormal(p_abn_rec => p_abn_rec);
  
  END LOOP;
END;';
  UPDATE bw3.sys_action t
     SET t.action_sql = v_sql
   WHERE t.element_id = 'action_a_product_120_1';
END;


