DECLARE
  v_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
  v_cnt        INT := 0;
BEGIN
  FOR i IN (SELECT ad.is_sup_exemption,
                   ad.first_dept_id,
                   t.product_gress_code
              FROM scmdata.pt_ordered t
             INNER JOIN scmdata.t_commodity_info tc
                ON tc.rela_goo_id = t.goo_id
               AND tc.company_id = t.company_id
             INNER JOIN scmdata.t_abnormal_range_config ar
                ON tc.company_id = ar.company_id
               AND tc.category = ar.industry_classification
               AND tc.product_cate = ar.production_category
               AND instr(';' || ar.product_subclass || ';',
                         ';' || tc.samll_category || ';') > 0
               AND ar.pause = 0
             INNER JOIN scmdata.t_abnormal_dtl_config ad
                ON ar.company_id = ad.company_id
               AND ar.abnormal_config_id = ad.abnormal_config_id
               AND ad.pause = 0
               AND ad.anomaly_classification = 'AC_DATE'
               AND ad.problem_classification = t.delay_problem_class
               AND ad.cause_classification = t.delay_cause_class
               AND ad.cause_detail = t.delay_cause_detailed
             INNER JOIN scmdata.t_abnormal_config ab
                ON ab.company_id = ad.company_id
               AND ab.abnormal_config_id = ad.abnormal_config_id
               AND ab.pause = 0
             WHERE t.company_id = v_company_id
               AND t.year = 22
               AND t.delay_problem_class IS NOT NULL
               AND (t.is_sup_duty IS NULL OR t.responsible_dept IS NULL)) LOOP
  
    UPDATE scmdata.pt_ordered t
       SET t.is_sup_duty      = i.is_sup_exemption,
           t.responsible_dept = i.first_dept_id,
           t.update_id        = 'ADMIN',
           t.update_time      = SYSDATE
     WHERE t.company_id = v_company_id
       AND t.product_gress_code = i.product_gress_code;
    v_cnt := v_cnt + 1;
    IF MOD(v_cnt, 1000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
  COMMIT;
END;
/
