  --1.У������
  IF :regist_price IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_integer(:regist_price, 0) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, 'ע���ʱ�ֻ���������֣�');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :social_credit_code IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_soial_code(:social_credit_code) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              '��������ȷ��ͳһ������ô��룬�ҳ���ӦΪ18λ��');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :company_contact_phone IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_phone(:company_contact_phone) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '��������ȷ����ϵ���ֻ����룡');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :public_id IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_id_card(:public_id) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '��������ȷ�ĶԹ�����˺ţ�');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :personal_idcard IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_id_card(:personal_idcard) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '��������ȷ�ĸ�������˺ţ�');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :public_phone IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_integer(:public_phone, 0) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '��������ȷ�ĶԹ���ϵ�绰��');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :personal_phone IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_integer(:personal_phone, 0) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '��������ȷ�ĸ�����ϵ�绰��');
    END IF;
  ELSE
    NULL;
  END IF;
  
   
  IF :cooperation_type IS  NULL THEN
      raise_application_error(-20002, '�������Ͳ���Ϊ�գ�');
  ELSE
    NULL;
  END IF;
  
  IF :cooperation_model IS  NULL THEN
      raise_application_error(-20002, '����ģʽ����Ϊ�գ�');
  ELSE
    NULL;
  END IF;

  IF :reconciliation_phone IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_integer(:reconciliation_phone, 0) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '��������ȷ�Ķ�����ϵ�绰��');
    END IF;
  ELSE
    NULL;
  END IF;
  
  --У������������ϸ����������Ϊ��Ʒ��Ӧ�̣�������������ϸtabҳ����Ϊ��
   SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_ability t
     WHERE t.supplier_info_id = :supplier_info_id;
  
    IF :cooperation_type = 'PRODUCT_TYPE' AND v_flag = 0 THEN
      raise_application_error(-20002, '��Ʒ��Ӧ�̵�����������ϸTABҳ������Ϊ�գ�');
    ELSE
      NULL;
    END IF;
   --����ʽΪָ������ָ����Ӧ�̵�TABҳ������Ϊ�� 
  SELECT COUNT(1) 
    INTO 
     v_share_flag
  FROM scmdata.t_supplier_info sa,
       scmdata.t_supplier_shared ts,
       (SELECT *
          FROM scmdata.t_supplier_info tu
         WHERE tu.company_id = %default_company_id%
           AND tu.status = 1  
           AND tu.pause = 0) v
 WHERE sa.supplier_info_id = ts.supplier_info_id
   AND ts.shared_company_id = v.supplier_company_id
   AND sa.supplier_info_id = :supplier_info_id;
   
   IF :sharing_type = '02' AND v_share_flag = 0 THEN
         raise_application_error(-20002, '����ʽΪָ������ָ����Ӧ�̵�TABҳ������Ϊ�գ�');
    ELSE
      NULL;
    END IF;
