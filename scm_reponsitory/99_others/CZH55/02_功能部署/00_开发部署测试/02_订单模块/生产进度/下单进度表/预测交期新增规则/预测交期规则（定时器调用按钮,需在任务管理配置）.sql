DECLARE
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('action_a_product_101_5', 'action', 'oracle_scmdata', 0, null, 1, null, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_101_5', 'Ԥ�⽻��(����)', 'icon-morencaidan', 4, 'DECLARE
  vo_forecast_date      DATE;
  vo_plan_complete_date DATE;
  v_over_plan_days      NUMBER;
BEGIN
  --��������״̬Ϊ�����У��ҵ�ǰ�����ѳ����ƻ�������ڣ�
  --��Ԥ�⽻��=���½ڵ�ʵ���������+ʣ��δ��ɽڵ�Ľڵ�����+���ƻ������������
  FOR pro_rec IN (SELECT *
                    FROM scmdata.t_production_progress t
                   WHERE t.company_id = %default_company_id%
                     AND t.progress_status = ''02'') LOOP
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
', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

     
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_product_101', 'action_a_product_101_5', 1, 0, null);

END;
