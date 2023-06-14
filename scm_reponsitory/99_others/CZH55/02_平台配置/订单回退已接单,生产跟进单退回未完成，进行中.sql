--���������ѽӵ�,�����������˻�δ��ɣ�������
DECLARE
  CURSOR p_pro_cur IS
    SELECT *
      FROM scmdata.t_production_progress t
     WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
       AND t.product_gress_code IN ('YWZXW2209190018','YWZXW2209190015');
BEGIN
  FOR p_data_rec IN p_pro_cur LOOP
    UPDATE scmdata.t_ordered po
       SET po.order_status    = 'OS01',
           po.approve_status  = NULL --OS01 �ѽӵ�
          ,
           po.finish_time_scm = NULL
     WHERE po.company_id = p_data_rec.company_id
       AND po.order_code = p_data_rec.order_id;
  
    UPDATE scmdata.t_production_progress t
       SET t.progress_status = '02' --02 ������ 00 δ��ʼ  01 �����
     WHERE t.company_id = p_data_rec.company_id
       AND t.order_id = p_data_rec.order_id;
  
/*    UPDATE scmdata.t_abnormal t
       SET t.progress_status = '01'
     WHERE t.goo_id = p_data_rec.goo_id
       AND t.order_id = p_data_rec.order_id
       AND t.company_id = p_data_rec.company_id;*/
  
    DELETE FROM scmdata.t_deduction t
     WHERE t.company_id = p_data_rec.company_id
       AND t.order_id = p_data_rec.order_id;
    
    --UPDATE scmdata.pt_ordered t SET t.order_finish_time = NULL WHERE t.product_gress_code = p_data_rec.order_id;
  END LOOP;
END;
