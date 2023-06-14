DECLARE
  vo_forecast_date      DATE;
  vo_plan_complete_date DATE;
  v_over_plan_days      NUMBER;
BEGIN
  --��������״̬Ϊ�����У��ҵ�ǰ�����ѳ����ƻ�������ڣ�
  --��Ԥ�⽻��=���½ڵ�ʵ���������+ʣ��δ��ɽڵ�Ľڵ�����+���ƻ������������
  FOR pro_rec IN (SELECT *
                    FROM scmdata.t_production_progress t
                   WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
                     AND t.progress_status = '02') LOOP
    --��ȡԤ�⽻�� 
    scmdata.pkg_production_progress.get_forecast_delivery_date(p_company_id          => pro_rec.company_id,
                                                               p_product_gress_id    => pro_rec.product_gress_id,
                                                               p_progress_status     => pro_rec.progress_status,
                                                               po_forecast_date      => vo_forecast_date,
                                                               po_plan_complete_date => vo_plan_complete_date);
    --��������״̬Ϊ�����У��ҵ�ǰ�����ѳ����ƻ�������ڣ���Ԥ�⽻��=���½ڵ�ʵ���������+ʣ��δ��ɽڵ�Ľڵ�����+���ƻ������������
    v_over_plan_days := trunc(SYSDATE) -
                        nvl(trunc(vo_plan_complete_date), trunc(SYSDATE));
    IF v_over_plan_days > 0 THEN
      pro_rec.forecast_delivery_date := vo_forecast_date + v_over_plan_days;
      --3.�����������ȱ�
      scmdata.pkg_production_progress.update_production_progress(p_produ_rec => pro_rec);
    ELSE
      NULL;
    END IF;
  END LOOP;
END;
