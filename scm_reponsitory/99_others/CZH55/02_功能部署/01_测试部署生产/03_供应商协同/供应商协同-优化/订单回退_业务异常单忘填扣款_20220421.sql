--订单回退已接单,生产跟进单退回未完成，进行中
DECLARE
  CURSOR p_pro_cur IS
    SELECT *
      FROM scmdata.t_production_progress t
     WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
       AND t.product_gress_code IN
           ('GDZXW2203090108',
            'YWZXC2203070057',
            'YWZXC2203090073',
            'YWZXP2203090251',
            'YWZXS2203090058',
            'YWZXS2203090060',
            'YWZXS2203090063',
            'YWZXS2203090065',
            'YWZXS2203090067',
            'YWZXS2203090068',
            'YWZXS2203090069');
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
