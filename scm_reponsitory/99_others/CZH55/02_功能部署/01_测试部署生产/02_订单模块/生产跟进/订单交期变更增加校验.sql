DECLARE
  v_update_sql CLOB;
BEGIN
  v_update_sql := q'[DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
  v_flag             NUMBER;

BEGIN

  SELECT MAX(t.is_order_reamem_upd)
    INTO v_flag
    FROM scmdata.t_production_progress t
   WHERE t.product_gress_id = :product_gress_id;
   
  --新增 交期变更数据 "延期问题分类、延期原因分类、延期原因细分、问题描述"已对接熊猫,不可修改！
  IF v_flag = 1 THEN
    raise_application_error(-20002,'提示："延期问题分类、延期原因分类、延期原因细分、问题描述"交期变更数据已对接熊猫,不可修改！');
  ELSE
    --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
    IF :delay_problem_class_pr IS NOT NULL AND
       :delay_cause_class_pr IS NOT NULL AND
       :delay_cause_detailed_pr IS NOT NULL THEN
      IF :problem_desc_pr IS NULL THEN
        raise_application_error(-20002,'提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！');
      ELSE
        SELECT ad.is_sup_exemption,
               (SELECT sd.dept_name
                  FROM scmdata.sys_company_dept sd
                 WHERE sd.company_id = ad.company_id
                   AND sd.company_dept_id = ad.first_dept_id) first_dept_name,
               (SELECT sd.dept_name
                  FROM scmdata.sys_company_dept sd
                 WHERE sd.company_id = ad.company_id
                   AND sd.company_dept_id = ad.second_dept_id) second_dept_name,
               ad.is_quality_problem
          INTO v_is_sup_exemption,
               v_first_dept_id,
               v_second_dept_id,
               v_is_quality
          FROM scmdata.t_commodity_info tc
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
         WHERE tc.company_id = :company_id
           AND tc.goo_id = :goo_id_pr
           AND ad.anomaly_classification = 'AC_DATE'
           AND ad.problem_classification = :delay_problem_class_pr
           AND ad.cause_classification = :delay_cause_class_pr
           AND ad.cause_detail = :delay_cause_detailed_pr;
      
      END IF;
    END IF;
  
    UPDATE scmdata.t_production_progress t
       SET t.delay_problem_class  = :delay_problem_class_pr,
           t.delay_cause_class    = :delay_cause_class_pr,
           t.delay_cause_detailed = :delay_cause_detailed_pr,
           t.problem_desc         = :problem_desc_pr,
           t.is_sup_responsible   = v_is_sup_exemption,
           t.responsible_dept     = v_first_dept_id,
           t.responsible_dept_sec = v_second_dept_id,
           t.is_quality           = v_is_quality
     WHERE t.product_gress_id = :product_gress_id;
  END IF;

END;]';

  UPDATE bw3.sys_item_list t
     SET t.update_sql = v_update_sql
   WHERE t.item_id = 'a_product_110';
END;


