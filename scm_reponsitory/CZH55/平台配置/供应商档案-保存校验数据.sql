  --1.校验数据
  IF :regist_price IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_integer(:regist_price, 0) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '注册资本只能输入数字！');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :social_credit_code IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_soial_code(:social_credit_code) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              '请输入正确的统一社会信用代码，且长度应为18位！');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :company_contact_phone IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_phone(:company_contact_phone) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '请输入正确的联系人手机号码！');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :public_id IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_id_card(:public_id) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '请输入正确的对公身份账号！');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :personal_idcard IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_id_card(:personal_idcard) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '请输入正确的个人身份账号！');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :public_phone IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_integer(:public_phone, 0) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '请输入正确的对公联系电话！');
    END IF;
  ELSE
    NULL;
  END IF;

  IF :personal_phone IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_integer(:personal_phone, 0) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '请输入正确的个人联系电话！');
    END IF;
  ELSE
    NULL;
  END IF;
  
   
  IF :cooperation_type IS  NULL THEN
      raise_application_error(-20002, '合作类型不能为空！');
  ELSE
    NULL;
  END IF;
  
  IF :cooperation_model IS  NULL THEN
      raise_application_error(-20002, '合作模式不能为空！');
  ELSE
    NULL;
  END IF;

  IF :reconciliation_phone IS NOT NULL THEN
    IF scmdata.pkg_check_data_comm.f_check_integer(:reconciliation_phone, 0) = 1 THEN
      NULL;
    ELSE
      raise_application_error(-20002, '请输入正确的对账联系电话！');
    END IF;
  ELSE
    NULL;
  END IF;
  
  --校验能力评估明细，合作类型为成品供应商，则能力评估明细tab页不能为空
   SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_ability t
     WHERE t.supplier_info_id = :supplier_info_id;
  
    IF :cooperation_type = 'PRODUCT_TYPE' AND v_flag = 0 THEN
      raise_application_error(-20002, '成品供应商的能力评估明细TAB页，不能为空！');
    ELSE
      NULL;
    END IF;
   --共享方式为指定共享，指定供应商的TAB页，不能为空 
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
         raise_application_error(-20002, '共享方式为指定共享，指定供应商的TAB页，不能为空！');
    ELSE
      NULL;
    END IF;
