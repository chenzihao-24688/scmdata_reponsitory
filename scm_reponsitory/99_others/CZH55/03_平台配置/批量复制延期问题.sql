DECLARE
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --�������������
  v_company_id         VARCHAR2(100) := %default_company_id%;
  p_produ_rec          t_production_progress%ROWTYPE;
  --��ѡ����Ҫ���������������������
  CURSOR pro_cur IS
    SELECT pc.*
      FROM scmdata.t_production_progress pc
     WHERE pc.company_id = v_company_id
       AND pc.product_gress_code IN (@selection);
BEGIN
  --У����������������Ƿ��������쳣����
  SELECT  ac.abnormal_config_code,ac.abnormal_name
    FROM scmdata.t_abnormal_config ac
   INNER JOIN scmdata.t_abnormal_range_config ar
      ON ac.company_id = v_company_id  and ac.abnormal_config_id     
      scmdata.t_abnormal_dtl_config ad
  
  --�������������
    SELECT pi.*
            INTO p_produ_rec
            FROM scmdata.t_production_progress pi
           WHERE pi.company_id = v_company_id
             AND pi.product_gress_code = v_product_gress_code;

  --��ѡ����Ҫ���������������������  
  FOR pro_rec IN pro_cur LOOP
  --У�������/�踴�Ƶ�����������Ʒ���Ƿ�����ͬһģ��
  
  END LOOP;

END;
