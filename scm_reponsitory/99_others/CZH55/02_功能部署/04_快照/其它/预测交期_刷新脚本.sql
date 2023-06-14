DECLARE
  vo_forecast_date DATE;
  vo_forecast_days INT;
BEGIN
  FOR po_rec IN (SELECT a.product_gress_id,
                        a.company_id,
                        a.latest_planned_delivery_date,
                        a.plan_delivery_date,
                        c.delivery_date,
                        a.progress_status,
                        a.progress_update_date,
                        a.curlink_complet_ratio,
                        c.is_product_order
                   FROM scmdata.t_production_progress a
                  INNER JOIN scmdata.t_orders b
                     ON b.goo_id = a.goo_id
                    AND b.order_id = a.order_id
                    AND b.company_id = a.company_id
                  INNER JOIN scmdata.t_ordered c
                     ON c.order_code = b.order_id
                    AND c.company_id = b.company_id
                  WHERE a.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
                    AND a.progress_status <> '01'
                    AND c.order_status <> 'OS02') LOOP
    IF po_rec.is_product_order = 1 THEN
      scmdata.pkg_production_progress_a.p_forecast_delivery_date(p_progress_id          => po_rec.product_gress_id,
                                                                 p_company_id           => po_rec.company_id,
                                                                 p_progress_status      => po_rec.progress_status,
                                                                 p_progress_update_date => po_rec.progress_update_date,
                                                                 p_plan_date            => po_rec.plan_delivery_date,
                                                                 p_delivery_date        => po_rec.delivery_date,
                                                                 p_curlink_complet_prom => round(po_rec.curlink_complet_ratio,
                                                                                                 2),
                                                                 po_forecast_date       => vo_forecast_date,
                                                                 po_forecast_days       => vo_forecast_days);
    
    ELSE
      scmdata.pkg_production_progress_a.p_forecast_delivery_date(p_progress_id          => po_rec.product_gress_id,
                                                                 p_company_id           => po_rec.company_id,
                                                                 p_is_product           => 0,
                                                                 p_latest_delivery_date => po_rec.latest_planned_delivery_date,
                                                                 p_plan_date            => po_rec.plan_delivery_date,
                                                                 p_delivery_date        => po_rec.delivery_date,
                                                                 po_forecast_date       => vo_forecast_date,
                                                                 po_forecast_days       => vo_forecast_days);
    END IF;
  
    UPDATE scmdata.t_production_progress t
       SET t.forecast_delivery_date = vo_forecast_date,
           t.forecast_delay_day     = vo_forecast_days,
           t.update_id              = 'ADMIN',
           t.update_time            = SYSDATE
     WHERE t.product_gress_id = po_rec.product_gress_id;  
  END LOOP;
END;
