--恢复订单‘GDZXW2111130000’指定工厂为新大板
BEGIN
  UPDATE scmdata.t_orders t
     SET t.factory_code = 'C00163'
   WHERE t.order_id = 'GDZXW2111130000'
     AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
     
  UPDATE scmdata.t_production_progress t
     SET t.factory_code = 'C00163'
   WHERE t.product_gress_code = 'GDZXW2111130000'
     AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
     
  --删除日志
  DELETE FROM scmdata.t_order_log t
   WHERE t.order_id = 'd0a21839ba952b79e0531164a8c066c1';
END;
