DECLARE
  v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  p_pro_rec            t_production_progress%ROWTYPE;
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_iabn_config_id     VARCHAR2(100);
  v_cabn_config_id     VARCHAR2(100);
  --所选的需要复制延期问题的生产订单
  CURSOR pro_cur IS
    SELECT pc.*
      FROM scmdata.t_production_progress pc
     WHERE pc.company_id = v_company_id
       AND pc.product_gress_code IN (@selection);
BEGIN
  --输入的生产订单
  SELECT pi.*
    INTO p_pro_rec
    FROM scmdata.t_production_progress pi
   WHERE pi.company_id = v_company_id
     AND pi.product_gress_code = v_product_gress_code;

  IF p_pro_rec.product_gress_id IS NULL THEN
    raise_application_error(-20002, ''生产单编码有误，请重新输入！'');
  ELSE
    --校验输入的生产单，是否配置了异常处理
    v_iabn_config_id := scmdata.pkg_production_progress.check_abnormal_config(p_company_id => p_pro_rec.company_id,
                                                                              p_goo_id     => p_pro_rec.goo_id);

    IF v_iabn_config_id IS NOT NULL THEN
      --所选的需要复制延期问题的生产订单
      FOR pro_rec IN pro_cur LOOP
        ----校验需复制的生产单，是否配置了异常处理
        v_cabn_config_id := scmdata.pkg_production_progress.check_abnormal_config(p_company_id => pro_rec.company_id,
                                                                                  p_goo_id     => pro_rec.goo_id);
        IF v_cabn_config_id IS NOT NULL THEN
          --校验输入的/需复制的生产单（商品）是否属于同一模板
          IF v_iabn_config_id = v_cabn_config_id THEN
            --模板一致，将延期异常问题复制至需复制的生产单
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
                                    ''需复制的生产单：['' ||
                                    pro_rec.product_gress_code ||
                                    ''],与输入的生产单模板不一致，请重新选择！！'');
          END IF;

        ELSE
          raise_application_error(-20002,
                                  ''需复制的生产单：['' || pro_rec.product_gress_code ||
                                  ''],无异常处理配置,请联系管理员！！'');
        END IF;

      END LOOP;
    ELSE
      raise_application_error(-20002,
                              ''输入的生产单，无异常处理配置,请联系管理员！！'');

    END IF;
  END IF;
END;';
  UPDATE bw3.sys_action t
     SET t.action_sql = v_sql
   WHERE t.element_id = 'action_a_product_110_4';
END;
