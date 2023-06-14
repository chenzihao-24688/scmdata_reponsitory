DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  p_pro_rec            t_production_progress%ROWTYPE;
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --�������������
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_iabn_config_id     VARCHAR2(100);
  v_cabn_config_id     VARCHAR2(100);
  --��ѡ����Ҫ���������������������
  CURSOR pro_cur IS
    SELECT pc.*
      FROM scmdata.t_production_progress pc
     WHERE pc.company_id = v_company_id
       AND pc.product_gress_code IN (@selection);
BEGIN
  --�������������
  SELECT pi.*
    INTO p_pro_rec
    FROM scmdata.t_production_progress pi
   WHERE pi.company_id = v_company_id
     AND pi.product_gress_code = v_product_gress_code;

  IF p_pro_rec.product_gress_id IS NULL THEN
    raise_application_error(-20002, ''�����������������������룡'');
  ELSE
    --У����������������Ƿ��������쳣����
    v_iabn_config_id := scmdata.pkg_production_progress.check_abnormal_config(p_company_id => p_pro_rec.company_id,
                                                                              p_goo_id     => p_pro_rec.goo_id);

    IF v_iabn_config_id IS NOT NULL THEN
      --��ѡ����Ҫ���������������������
      FOR pro_rec IN pro_cur LOOP
        ----У���踴�Ƶ����������Ƿ��������쳣����
        v_cabn_config_id := scmdata.pkg_production_progress.check_abnormal_config(p_company_id => pro_rec.company_id,
                                                                                  p_goo_id     => pro_rec.goo_id);
        IF v_cabn_config_id IS NOT NULL THEN
          --У�������/�踴�Ƶ�����������Ʒ���Ƿ�����ͬһģ��
          IF v_iabn_config_id = v_cabn_config_id THEN
            --ģ��һ�£��������쳣���⸴�����踴�Ƶ�������
            UPDATE t_production_progress t
               SET t.delay_problem_class  = p_pro_rec.delay_problem_class,
                   t.delay_cause_class    = p_pro_rec.delay_cause_class,
                   t.delay_cause_detailed = p_pro_rec.delay_cause_detailed,
                   t.problem_desc         = p_pro_rec.problem_desc,
                   t.is_sup_responsible   = p_pro_rec.is_sup_responsible,
                   t.responsible_dept     = p_pro_rec.responsible_dept,
                   t.responsible_dept_sec = p_pro_rec.responsible_dept_sec
             WHERE t.company_id = pro_rec.company_id
               AND t.product_gress_id = pro_rec.product_gress_id;
          ELSE
            raise_application_error(-20002,
                                    ''�踴�Ƶ���������['' ||
                                    pro_rec.product_gress_code ||
                                    ''],�������������ģ�岻һ�£�������ѡ�񣡣�'');
          END IF;

        ELSE
          raise_application_error(-20002,
                                  ''�踴�Ƶ���������['' || pro_rec.product_gress_code ||
                                  ''],���쳣��������,����ϵ����Ա����'');
        END IF;

      END LOOP;
    ELSE
      raise_application_error(-20002,
                              ''����������������쳣��������,����ϵ����Ա����'');

    END IF;
  END IF;
END;';
  UPDATE bw3.sys_action t
     SET t.action_sql = v_sql
   WHERE t.element_id = 'action_a_product_110_4';
END;
