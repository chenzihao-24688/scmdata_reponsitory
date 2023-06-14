DECLARE
v_sql clob;
BEGIN
  v_sql := q'[DECLARE
  vo_forecast_date      DATE;
BEGIN
  --生产进度状态为未开始/进行中，且当前日期已超过计划完成日期，
  --则预测交期=最新节点实际完成日期+剩余未完成节点的节点周期+超计划完成日期天数
  FOR pro_rec IN (SELECT *
                    FROM scmdata.t_production_progress t
                   WHERE t.company_id = %default_company_id%
                     AND t.progress_status <> '01') LOOP
  
    --获取预测交期 
    vo_forecast_date := calc_forecast_delivery_date(p_company_id       => pro_rec.company_id,
                                                    p_product_gress_id => pro_rec.product_gress_id,
                                                    p_status           => pro_rec.progress_status);
  
    pro_rec.forecast_delivery_date := vo_forecast_date;
    --3.更新生产进度表
    scmdata.pkg_production_progress.update_production_progress(p_produ_rec => pro_rec);
  
  END LOOP;
END;
]';
update bw3.sys_action t set t.action_sql = v_sql  where t.element_id = 'action_a_product_101_5' ;
END;
