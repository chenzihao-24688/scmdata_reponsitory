CREATE OR REPLACE TRIGGER scmdata.trg_bf_u_t_supplier_info
  BEFORE UPDATE OF supplier_company_name, company_province, company_city ON scmdata.t_supplier_info
  FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_flag NUMBER := 0; --У���ظ�
BEGIN
  --1) ���� ��Ӧ�����ƣ��ڵ�ǰ��ҵ�����ظ�
  IF updating THEN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_info sp
     WHERE sp.company_id = :old.company_id
       AND sp.supplier_info_id <> :old.supplier_info_id
       AND sp.supplier_company_name = :new.supplier_company_name;
  
    IF v_flag > 0 THEN
      raise_application_error(-20002,
                              '��Ӧ�����ƣ��ڵ�ǰ��ҵ�����ظ�����������д��');
    END IF;
  
    --�����޸�,������������
    IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.company_province ||
                                                 :old.company_city,
                                                 :new.company_province ||
                                                 :new.company_city) = 0 THEN
    
      :new.group_name := pkg_supplier_info.f_get_group_config_id(p_company_id => :old.company_id,
                                                                 p_supp_id    => :old.supplier_info_id,
                                                                 p_is_by_pick => 1,
                                                                 p_province   => :new.company_province,
                                                                 p_city       => :new.company_city);
      IF :new.group_name IS NULL THEN
        IF :old.group_name IS NOT NULL THEN
          :new.group_name := :old.group_name;
        ELSE
          raise_application_error(-20002,
                                  '���鲻��Ϊ�գ������������÷������ϵ����Ա���з������ã�');
        END IF;
      END IF;
    
    END IF;
  ELSE
    NULL;
  END IF;

END trg_bf_u_t_supplier_info;
/
/
