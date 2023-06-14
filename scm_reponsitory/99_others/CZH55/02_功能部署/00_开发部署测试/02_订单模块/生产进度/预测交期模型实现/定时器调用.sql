DECLARE
v_sql clob;
BEGIN
  v_sql := q'[DECLARE
  vo_forecast_date      DATE;
BEGIN
  --��������״̬Ϊδ��ʼ/�����У��ҵ�ǰ�����ѳ����ƻ�������ڣ�
  --��Ԥ�⽻��=���½ڵ�ʵ���������+ʣ��δ��ɽڵ�Ľڵ�����+���ƻ������������
  FOR pro_rec IN (SELECT *
                    FROM scmdata.t_production_progress t
                   WHERE t.company_id = %default_company_id%
                     AND t.progress_status <> '01') LOOP
  
    --��ȡԤ�⽻�� 
    vo_forecast_date := calc_forecast_delivery_date(p_company_id       => pro_rec.company_id,
                                                    p_product_gress_id => pro_rec.product_gress_id,
                                                    p_status           => pro_rec.progress_status);
  
    pro_rec.forecast_delivery_date := vo_forecast_date;
    --3.�����������ȱ�
    scmdata.pkg_production_progress.update_production_progress(p_produ_rec => pro_rec);
  
  END LOOP;
END;
]';
update bw3.sys_action t set t.action_sql = v_sql  where t.element_id = 'action_a_product_101_5' ;
END;
