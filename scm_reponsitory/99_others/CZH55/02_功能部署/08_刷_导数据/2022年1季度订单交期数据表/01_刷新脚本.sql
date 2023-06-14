DECLARE
  v_company_id       VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_cnt              INT := 0;
BEGIN
  FOR i IN (SELECT t.col_1, t.col_2, t.col_3, t.col_4, t.col_5
              FROM scmdata.t_excel_import t) LOOP
  
    SELECT MAX(ad.is_sup_exemption),
           MAX(ad.first_dept_id),
           MAX(ad.second_dept_id),
           MAX(ad.is_quality_problem)
      INTO v_is_sup_exemption,
           v_first_dept_id,
           v_second_dept_id,
           v_is_quality
      FROM scmdata.pt_ordered t
     INNER JOIN scmdata.t_commodity_info tc
        ON tc.goo_id = t.goo_id
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
     INNER JOIN scmdata.t_abnormal_config ab
        ON ab.company_id = ad.company_id
       AND ab.abnormal_config_id = ad.abnormal_config_id
       AND ab.pause = 0
     WHERE t.company_id = v_company_id
       AND t.product_gress_code = i.col_1
       AND ad.anomaly_classification = 'AC_DATE'
       AND ad.problem_classification = i.col_2
       AND ad.cause_classification = i.col_3
       AND ad.cause_detail = i.col_4;
  
    UPDATE scmdata.t_production_progress t
       SET t.delay_problem_class  = i.col_2,
           t.delay_cause_class    = i.col_3,
           t.delay_cause_detailed = i.col_4,
           t.problem_desc         = i.col_5,
           t.is_sup_responsible   = v_is_sup_exemption,
           t.responsible_dept     = v_first_dept_id,
           t.responsible_dept_sec = v_second_dept_id,
           t.is_quality           = v_is_quality,
           t.update_company_id    = v_company_id,
           t.update_id            = 'ADMIN',
           t.update_time          = SYSDATE
     WHERE t.company_id = v_company_id
       AND t.product_gress_code = i.col_1;
    v_cnt := v_cnt + 1;
    IF MOD(v_cnt, 1000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;
  COMMIT;
END;
