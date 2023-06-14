DECLARE
  v_company_id           VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
  v_deduction_proportion NUMBER;
  v_deduction_money      NUMBER;
  v_deduction_type       VARCHAR2(32);
  vo_count               NUMBER;
  vo_ded_change_time     DATE;
BEGIN
  FOR i IN (SELECT t.deduction_id,
                   t.order_id,
                   t.abnormal_id,
                   abn.anomaly_class,
                   abn.deduction_method,
                   abn.deduction_unit_price,
                   t.discount_type,
                   t.discount_proportion,
                   t.company_id,
                   abn.goo_id,
                   nvl(abn.delay_date, 0) delay_date,
                   po.create_time
              FROM scmdata.t_deduction t
             INNER JOIN scmdata.t_ordered po
                ON po.order_code = t.order_id
               AND po.company_id = t.company_id
              LEFT JOIN scmdata.t_abnormal abn
                ON abn.abnormal_id = t.abnormal_id
               AND abn.company_id = t.company_id
             WHERE t.company_id = v_company_id
               AND t.discount_type IS NULL
               AND t.discount_proportion IS NULL) LOOP
    IF i.anomaly_class IN ('AC_QUALITY', 'AC_OTHERS') THEN
      IF i.deduction_method = 'METHOD_02' THEN
        v_deduction_proportion := nvl(i.deduction_unit_price, 0);
      ELSE
        v_deduction_proportion := 0;
      END IF;
    ELSIF i.anomaly_class = 'AC_DATE' THEN
      scmdata.pkg_production_progress.check_deduction_config(p_company_id        => i.company_id,
                                                             p_goo_id            => i.goo_id,
                                                             p_status            => 0,
                                                             p_order_create_time => i.create_time,
                                                             po_count            => vo_count,
                                                             po_ded_change_time  => vo_ded_change_time);
    
      --2. 延期扣款规则无配置时不作处理,有配置时进行以下操作
      IF vo_count > 0 THEN
        scmdata.pkg_production_progress.get_deduction(p_company_id        => i.company_id,
                                                      p_goo_id            => i.goo_id,
                                                      p_delay_day         => i.delay_date,
                                                      p_order_create_time => i.create_time,
                                                      po_deduction_type   => v_deduction_type,
                                                      po_deduction_money  => v_deduction_money);
        IF v_deduction_type = 'METHOD_02' THEN
          v_deduction_proportion := nvl(v_deduction_money * 100, 0);
          UPDATE scmdata.t_abnormal t
             SET t.deduction_unit_price = v_deduction_proportion
           WHERE t.abnormal_id = i.abnormal_id
             AND t.company_id = i.company_id;
        ELSE
          v_deduction_proportion := 0;
        END IF;
      ELSE
        NULL;
      END IF;
    END IF;
    UPDATE scmdata.t_deduction t
       SET t.discount_type       = i.deduction_method,
           t.discount_proportion = nvl(v_deduction_proportion, 0)
     WHERE t.deduction_id = i.deduction_id
       AND t.company_id = v_company_id;
  END LOOP;
END;
/
