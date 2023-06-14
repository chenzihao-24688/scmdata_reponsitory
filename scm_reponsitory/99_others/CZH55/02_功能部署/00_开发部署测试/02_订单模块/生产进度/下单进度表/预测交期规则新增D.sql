DECLARE
  vo_forecast_date      DATE;
  vo_plan_complete_date DATE;
  v_over_plan_days      NUMBER;
BEGIN
  --生产进度状态为进行中，且当前日期已超过计划完成日期，
  --则预测交期=最新节点实际完成日期+剩余未完成节点的节点周期+超计划完成日期天数
  FOR pro_rec IN (SELECT *
                    FROM scmdata.t_production_progress t
                   WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
                     AND t.progress_status = '02') LOOP
    --获取预测交期 
    scmdata.pkg_production_progress.get_forecast_delivery_date(p_company_id          => pro_rec.company_id,
                                                               p_product_gress_id    => pro_rec.product_gress_id,
                                                               p_progress_status     => pro_rec.progress_status,
                                                               po_forecast_date      => vo_forecast_date,
                                                               po_plan_complete_date => vo_plan_complete_date);
    --生产进度状态为进行中，且当前日期已超过计划完成日期，则预测交期=最新节点实际完成日期+剩余未完成节点的节点周期+超计划完成日期天数
    v_over_plan_days := trunc(SYSDATE) -
                        nvl(trunc(vo_plan_complete_date), trunc(SYSDATE));
    IF v_over_plan_days > 0 THEN
      pro_rec.forecast_delivery_date := vo_forecast_date + v_over_plan_days;
      --3.更新生产进度表
      scmdata.pkg_production_progress.update_production_progress(p_produ_rec => pro_rec);
    ELSE
      NULL;
    END IF;
  END LOOP;
END;
