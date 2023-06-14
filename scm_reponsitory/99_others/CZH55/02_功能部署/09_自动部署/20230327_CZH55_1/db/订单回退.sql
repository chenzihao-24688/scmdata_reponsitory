--订单回退已接单,生产跟进单退回未完成，进行中
DECLARE
  CURSOR p_pro_cur IS
    SELECT *
      FROM scmdata.t_production_progress t
     WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
       AND t.product_gress_code IN
           (SELECT a.order_code
              FROM scmdata.t_ordered a
             INNER JOIN scmdata.t_orders b
                ON b.order_id = a.order_code
               AND b.company_id = a.company_id
             INNER JOIN scmdata.t_commodity_info c
                ON c.goo_id = b.goo_id
               AND c.company_id = b.company_id
             WHERE c.rela_goo_id = '819645'
               AND a.order_status = 'OS01');
BEGIN
  FOR p_data_rec IN p_pro_cur LOOP
    UPDATE scmdata.t_ordered po
       SET po.order_status    = 'OS01',
           po.approve_status  = NULL --OS01 已接单
          ,
           po.finish_time_scm = NULL
     WHERE po.company_id = p_data_rec.company_id
       AND po.order_code = p_data_rec.order_id;
  
    UPDATE scmdata.t_production_progress t
       SET t.progress_status = '00' --02 进行中 00 未开始  01 已完成
     WHERE t.company_id = p_data_rec.company_id
       AND t.order_id = p_data_rec.order_id;
  
    DELETE FROM scmdata.t_deduction t
     WHERE t.company_id = p_data_rec.company_id
       AND t.order_id = p_data_rec.order_id;
  END LOOP;
END;
/
