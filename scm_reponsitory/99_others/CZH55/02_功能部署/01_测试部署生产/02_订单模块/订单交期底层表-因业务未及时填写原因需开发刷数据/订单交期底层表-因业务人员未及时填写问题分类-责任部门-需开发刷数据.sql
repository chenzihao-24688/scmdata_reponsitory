BEGIN
  FOR i IN (SELECT a.col_1          order_code,
                   a.col_2          problem,
                   a.col_3          cause,
                   a.col_4          cause_d,
                   a.col_5          memo,
                   v.first_dept_id,
                   v.second_dept_id
              FROM scmdata.t_excel_import a
             INNER JOIN (SELECT ad.problem_classification,
                               ad.cause_classification,
                               ad.cause_detail,
                               ad.first_dept_id,
                               ad.second_dept_id,
                               t.order_id
                          FROM scmdata.t_production_progress t
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
                           AND ad.anomaly_classification = 'AC_DATE'
                           AND ad.pause = 0
                         INNER JOIN scmdata.t_abnormal_config ab
                            ON ab.company_id = ad.company_id
                           AND ab.abnormal_config_id = ad.abnormal_config_id
                           AND ab.pause = 0
                         WHERE t.company_id =
                               'b6cc680ad0f599cde0531164a8c0337f') v
                ON v.order_id = a.col_1
               AND v.problem_classification = a.col_2
               AND v.cause_classification = a.col_3
               AND v.cause_detail = a.col_4) LOOP
    UPDATE scmdata.pt_ordered t
       SET t.delay_problem_class  = i.problem,
           t.delay_cause_class    = i.cause,
           t.delay_cause_detailed = i.cause_d,
           t.problem_desc         = i.memo,
           t.responsible_dept     = i.first_dept_id,
           t.responsible_dept_sec = i.second_dept_id
     WHERE t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
       AND t.product_gress_code = i.order_code;
  
  END LOOP;
END;
