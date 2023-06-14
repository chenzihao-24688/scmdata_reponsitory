declare
v_sql clob;
begin
  v_sql := 'DECLARE
  p_fac_rec scmdata.t_factory_report%ROWTYPE;
BEGIN
  p_fac_rec.factory_report_id   := :factory_report_id;
  p_fac_rec.product_line        := :product_line;
  p_fac_rec.product_line_num    := :product_line_num;
  p_fac_rec.worker_num          := :worker_num;
  p_fac_rec.machine_num         := :machine_num;
  p_fac_rec.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  p_fac_rec.product_efficiency  := rtrim(:product_efficiency,''%'');
  p_fac_rec.work_hours_day      := :work_hours_day;
  p_fac_rec.quality_step        := :quality_step;
  p_fac_rec.pattern_cap         := :pattern_cap;
  p_fac_rec.fabric_purchase_cap := :fabric_purchase_cap;
  p_fac_rec.fabric_check_cap    := :fabric_check_cap;
  p_fac_rec.cost_step           := :cost_step;
  p_fac_rec.check_person1       := :check_person1;
  p_fac_rec.check_person1_phone := :check_person1_phone;
  p_fac_rec.check_person2       := :check_person2;
  p_fac_rec.check_person2_phone := :check_person2_phone;
  p_fac_rec.check_say           := :check_say;
  p_fac_rec.check_result        := :CHECK_FAC_RESULT;
  p_fac_rec.check_date          := :check_date;
  p_fac_rec.update_id           := :user_id;
  p_fac_rec.update_date         := SYSDATE;
  p_fac_rec.remarks             := :remarks;

  scmdata.pkg_ask_record_mange.p_update_check_factory_report(p_fac_rec => p_fac_rec,p_type => 0);
END;

--原逻辑
/*DECLARE

BEGIN
  IF LENGTHB(:CHECK_REPORT_FILE) > 256 THEN
    RAISE_APPLICATION_ERROR(-20002, ''最多只可上传7个附件！'');
  END IF;

  UPDATE SCMDATA.T_FACTORY_REPORT
     SET CHECK_REPORT_FILE = :CHECK_REPORT_FILE,
         CHECK_SAY         = :CHECK_SAY,
         CHECK_RESULT      = :CHECK_RESULT,
         CHECK_DATE        = :CHECK_DATE,
         UPDATE_ID         = %CURRENT_USERID%,
         UPDATE_DATE       = SYSDATE
   WHERE FACTORY_REPORT_ID = :FACTORY_REPORT_ID;

END;*/';

update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_check_101_1';
end;
