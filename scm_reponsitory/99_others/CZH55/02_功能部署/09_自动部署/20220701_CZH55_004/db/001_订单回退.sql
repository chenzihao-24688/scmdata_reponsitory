BEGIN
  FOR p_data_rec IN (SELECT t.company_id, t.order_id
                       FROM scmdata.t_production_progress t
                      WHERE t.company_id =
                            'b6cc680ad0f599cde0531164a8c0337f'
                        AND t.product_gress_code IN
                            ('GZZXS2205300007',
                             'GZZXP2206060162',
                             'GZZXP2206060163')) LOOP
    --订单回退已接单
    UPDATE scmdata.t_ordered po
       SET po.order_status    = 'OS01',
           po.approve_status  = NULL --OS01 已接单
          ,
           po.finish_time_scm = NULL
     WHERE po.company_id = p_data_rec.company_id
       AND po.order_code = p_data_rec.order_id;
    --生产进度表回退至未开始
    UPDATE scmdata.t_production_progress t
       SET t.progress_status = '00' --02 进行中 00 未开始  01 已完成
     WHERE t.company_id = p_data_rec.company_id
       AND t.order_id = p_data_rec.order_id;
    --删除扣款单
    DELETE FROM scmdata.t_deduction t
     WHERE t.company_id = p_data_rec.company_id
       AND t.order_id = p_data_rec.order_id;
  END LOOP;
END;
/
