DECLARE
  v_form_sql_1 CLOB;
  v_form_sql_2 CLOB;
BEGIN
  v_form_sql_1 := q'[WITH delivery_amount AS
 (SELECT * FROM scmdata.t_delivery_record dr),
deduction_ratio AS
 (SELECT dc.deduction_ratio,
         dc.section_start,
         dc.section_end,
         tc.company_id,
         tc.goo_id
    FROM scmdata.t_commodity_info tc
   INNER JOIN scmdata.t_deduction_range_config dr
      ON tc.company_id = dr.company_id
     AND tc.category = dr.industry_classification
     AND tc.product_cate = dr.production_category
     AND instr(';' || dr.product_subclass || ';',
               ';' || tc.samll_category || ';') > 0
     AND dr.pause = 0
   INNER JOIN scmdata.t_deduction_dtl_config dc
      ON dr.company_id = dc.company_id
     AND dr.deduction_config_id = dc.deduction_config_id
     AND dc.pause = 0
   INNER JOIN scmdata.t_deduction_config td
      ON td.company_id = dc.company_id
     AND td.deduction_config_id = dc.deduction_config_id
     AND td.pause = 0)
SELECT order_id              "�������ݺ�",
       style_number          "����",
       delay_amount          "����",
       order_price           "����",
       delay_amount*order_price           "�ܼ�",
       to_char(delivery_date,'yyyy-mm-dd')         "Լ������",
       to_char(arrival_date,'yyyy-mm-dd')          "ʵ�ʽ���",
       detailed_reasons      "�ۿ�ԭ��",
       deduction_ratio       "Ӧ�۱���",
       actual_discount_price "Ӧ�۽��",
       adjust_reason         "��ע"
  FROM (SELECT td.order_id order_id,
               (SELECT tc.style_number
                  FROM scmdata.t_commodity_info tc
                 WHERE tc.company_id = pr.company_id
                   AND tc.goo_id = pr.goo_id) style_number,
               decode(td.orgin,
                      'SC',
                      nvl(abn.delay_amount, 0),
                      'MA',
                      (SELECT SUM(dr1.delivery_amount)
                         FROM delivery_amount dr1
                        WHERE dr1.company_id = pr.company_id
                          AND dr1.order_code = pr.order_id
                          AND dr1.goo_id = pr.goo_id)) delay_amount,
               ln.order_price order_price,
               --td.actual_discount_price total_money,
               (SELECT ln.delivery_date
                  FROM scmdata.t_orders ln
                 WHERE ln.company_id = pr.company_id
                   AND ln.order_id = pr.order_id
                   AND ln.goo_id = pr.goo_id) delivery_date,
               td.arrival_date arrival_date,
               decode(abn.anomaly_class,'AC_QUALITY','�����ۿ�',abn.detailed_reasons) detailed_reasons,
               decode(abn.deduction_method,
                      'METHOD_00',
                      abn.deduction_unit_price || 'Ԫ/��',
                      'METHOD_01',
                      NULL,
                      'METHOD_02',
                      decode(td.orgin,
                             'SC',
                             nvl((SELECT deduction_ratio
                                    FROM deduction_ratio drt
                                   WHERE drt.company_id = pr.company_id
                                     AND drt.goo_id = pr.goo_id
                                     AND (abn.delay_date >= drt.section_start AND
                                         abn.delay_date < drt.section_end)) || '%',
                                 NULL),
                             'MA',
                             abn.deduction_unit_price || '%',
                             NULL)) deduction_ratio,
               td.actual_discount_price,
               td.adjust_reason
          FROM scmdata.t_deduction td
         INNER JOIN scmdata.t_production_progress pr
            ON td.company_id = pr.company_id
           AND td.order_id = pr.order_id
         INNER JOIN scmdata.t_orders ln 
            ON pr.company_id = ln.company_id
           AND pr.order_id = ln.order_id
           AND pr.goo_id = ln.goo_id
         INNER JOIN scmdata.t_abnormal abn
            ON pr.company_id = abn.company_id
           AND pr.order_id = abn.order_id
           AND pr.goo_id = abn.goo_id
           AND td.abnormal_id = abn.abnormal_id
         WHERE td.company_id = %default_company_id%
           AND td.order_id = :order_code)
UNION ALL
SELECT '�ϼƽ��' "�������ݺ�",
       NULL "����",
       NULL "����",
       NULL "����",
       NULL "�ܼ�",
       NULL "Լ������",
       NULL "ʵ�ʽ���",
       NULL "�ۿ�ԭ��",
       NULL "Ӧ�۱���",
       (SELECT SUM(td.actual_discount_price)
          FROM scmdata.t_deduction td
         WHERE td.company_id = a.company_id
           AND td.order_id = a.order_code) "Ӧ�۽��",
       NULL "��ע"
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id% AND a.order_code = :order_code]';

  v_form_sql_2 := q'[WITH delivery_amount AS
 (SELECT * FROM scmdata.t_delivery_record dr),
deduction_ratio AS
 (SELECT dc.deduction_ratio,
         dc.section_start,
         dc.section_end,
         tc.company_id,
         tc.goo_id
    FROM scmdata.t_commodity_info tc
   INNER JOIN scmdata.t_deduction_range_config dr
      ON tc.company_id = dr.company_id
     AND tc.category = dr.industry_classification
     AND tc.product_cate = dr.production_category
     AND instr(';' || dr.product_subclass || ';',
               ';' || tc.samll_category || ';') > 0
     AND dr.pause = 0
   INNER JOIN scmdata.t_deduction_dtl_config dc
      ON dr.company_id = dc.company_id
     AND dr.deduction_config_id = dc.deduction_config_id
     AND dc.pause = 0
   INNER JOIN scmdata.t_deduction_config td
      ON td.company_id = dc.company_id
     AND td.deduction_config_id = dc.deduction_config_id
     AND td.pause = 0),
total_cal AS
 (SELECT SUM(td.discount_price) total_money,
         SUM(td.adjust_price) total_reduction_price,
         SUM(td.actual_discount_price) total_actual_discount_price
    FROM scmdata.t_deduction td
   WHERE td.company_id = %default_company_id%
     AND td.order_id = :order_code
     AND sign(td.adjust_price) = -1)
SELECT order_id              "�������ݺ�",
       style_number          "����",
       delay_amount          "����",
       order_price   "����",
       delay_amount*order_price           "�ܼ�",
       to_char(delivery_date,'yyyy-mm-dd')         "Լ������",
       to_char(arrival_date,'yyyy-mm-dd')          "ʵ�ʽ���",
       detailed_reasons      "�ۿ�ԭ��",
       deduction_ratio       "Ӧ�۱���",
       discount_price        "Ӧ�۽��",
       reduction_ratio       "�������",
       adjust_price*-1          "������",
       actual_discount_price "ʵ�۽��",
       adjust_reason         "��ע"
  FROM (SELECT td.order_id order_id,
               (SELECT tc.style_number
                  FROM scmdata.t_commodity_info tc
                 WHERE tc.company_id = pr.company_id
                   AND tc.goo_id = pr.goo_id) style_number,
               decode(td.orgin,
                      'SC',
                      nvl(abn.delay_amount, 0),
                      'MA',
                      (SELECT SUM(dr1.delivery_amount)
                         FROM delivery_amount dr1
                        WHERE dr1.company_id = pr.company_id
                          AND dr1.order_code = pr.order_id
                          AND dr1.goo_id = pr.goo_id)) delay_amount,
               ln.order_price order_price,
               --td.actual_discount_price total_money,
               ln.delivery_date delivery_date,
               td.arrival_date arrival_date,
               decode(abn.anomaly_class,'AC_QUALITY','�����ۿ�',abn.detailed_reasons) detailed_reasons,
               decode(abn.deduction_method,
                      'METHOD_00',
                      abn.deduction_unit_price || 'Ԫ/��',
                      'METHOD_01',
                      NULL,
                      'METHOD_02',
                      decode(td.orgin,
                             'SC',
                             nvl((SELECT deduction_ratio
                                    FROM deduction_ratio drt
                                   WHERE drt.company_id = pr.company_id
                                     AND drt.goo_id = pr.goo_id
                                     AND (abn.delay_date >= drt.section_start AND
                                         abn.delay_date < drt.section_end)) || '%',
                                 NULL),
                             'MA',
                             abn.deduction_unit_price || '%',
                             NULL)) deduction_ratio,
               td.discount_price,
               '' reduction_ratio,
               td.adjust_price,
               td.actual_discount_price,
               td.adjust_reason
          FROM scmdata.t_deduction td
         INNER JOIN scmdata.t_production_progress pr
            ON td.company_id = pr.company_id
           AND td.order_id = pr.order_id
         INNER JOIN scmdata.t_orders ln 
            ON pr.company_id = ln.company_id
           AND pr.order_id = ln.order_id
           AND pr.goo_id = ln.goo_id
         INNER JOIN scmdata.t_abnormal abn
            ON pr.company_id = abn.company_id
           AND pr.order_id = abn.order_id
           AND pr.goo_id = abn.goo_id
           AND td.abnormal_id = abn.abnormal_id
         WHERE td.company_id = %default_company_id%
           AND td.order_id = :order_code
           AND sign(td.adjust_price) = -1)
UNION ALL
SELECT '�ϼƽ��' "�������ݺ�",
       NULL "����",
       NULL "����",
       NULL "����",
       NULL "�ܼ�",
       NULL "Լ������",
       NULL "ʵ�ʽ���",
       NULL "�ۿ�ԭ��",
       NULL "Ӧ�۱���",
       (SELECT td1.total_money FROM total_cal td1) "Ӧ�۽��",
       NULL "�������",
       (SELECT td2.total_reduction_price*-1 FROM total_cal td2) "������",
       (SELECT td3.total_actual_discount_price FROM total_cal td3) "ʵ�۽��",
       NULL "��ע"
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id% AND a.order_code = :order_code]';

  UPDATE bw3.sys_file_template_table t
     SET t.form_sql = v_form_sql_1
   WHERE t.element_id = 'word_a_product_130_1';
   
  UPDATE bw3.sys_file_template_table t
     SET t.form_sql = v_form_sql_2
   WHERE t.element_id = 'word_a_product_130_2';
END;
/
DECLARE
  v_update_sql CLOB;
BEGIN
  v_update_sql := q'[DECLARE
BEGIN
  IF :adjust_price IS NOT NULL THEN
    IF :adjust_reason IS NULL THEN
      raise_application_error(-20002, '���������ֵʱ���������ɲ���Ϊ��');
    ELSE
      UPDATE scmdata.t_deduction td
         SET td.adjust_price          = round(:adjust_price, 2),
             td.adjust_reason         = :adjust_reason,
             td.update_id             = :user_id,
             td.update_time           = SYSDATE,
             td.actual_discount_price = decode(sign(:old_discount_price +
                                                    :adjust_price),
                                               -1,
                                               0,
                                               round((:old_discount_price +
                                                     :adjust_price),
                                                     2))
       WHERE td.deduction_id = :deduction_id;
    END IF;
  ELSE
    IF :adjust_reason IS NOT NULL THEN
      UPDATE scmdata.t_deduction td
         SET td.adjust_reason = :adjust_reason,
             td.update_id   = :user_id,
             td.update_time = SYSDATE
       WHERE td.deduction_id = :deduction_id;
    ELSE
      NULL;
    END IF;
  END IF;
END;]';

  UPDATE bw3.sys_item_list t
     SET t.update_sql = v_update_sql
   WHERE t.item_id = 'a_product_130_3';
END;
/
DECLARE
  v_select_sql CLOB;
BEGIN
  v_select_sql := q'[WITH group_dict AS
 (SELECT t.group_dict_type, t.group_dict_value, t.group_dict_name
    FROM scmdata.sys_group_dict t),
deduction_ratio AS
 (SELECT dc.deduction_ratio,
         dc.section_start,
         dc.section_end,
         tc.company_id,
         tc.goo_id
    FROM scmdata.t_commodity_info tc
   INNER JOIN scmdata.t_deduction_range_config dr
      ON tc.company_id = dr.company_id
     AND tc.category = dr.industry_classification
     AND tc.product_cate = dr.production_category
     AND instr(';' || dr.product_subclass || ';',
               ';' || tc.samll_category || ';') > 0
     AND dr.pause = 0
   INNER JOIN scmdata.t_deduction_dtl_config dc
      ON dr.company_id = dc.company_id
     AND dr.deduction_config_id = dc.deduction_config_id
     AND dc.pause = 0
   INNER JOIN scmdata.t_deduction_config td
      ON td.company_id = dc.company_id
     AND td.deduction_config_id = dc.deduction_config_id
     AND td.pause = 0)
SELECT td.deduction_id,
       --td.orgin,
       a.group_dict_name orgin,
       pr.product_gress_code,
       gd.group_dict_name anomaly_class,
       abn.detailed_reasons,
       nvl(abn.delay_date, 0) delay_date,
       decode(td.orgin,
              'SC',
              nvl(abn.delay_amount, 0),
              'MA',
              (SELECT SUM(dr.delivery_amount)
                 FROM scmdata.t_delivery_record dr
                WHERE dr.company_id = pr.company_id
                  AND dr.order_code = pr.order_id
                  AND dr.goo_id = pr.goo_id)) delay_amount,
       (SELECT a.group_dict_name
          FROM group_dict a
         WHERE a.group_dict_type = 'DEDUCTION_METHOD'
           AND a.group_dict_value = abn.deduction_method) deduction_method_desc,
       td.discount_unit_price deduction_unit_price,
       decode(abn.deduction_method,
              'METHOD_00',
              0,
              'METHOD_01',
              0,
              'METHOD_02',
              decode(abn.anomaly_class,
                     'AC_DATE',
                     nvl((SELECT deduction_ratio
                           FROM deduction_ratio drt
                          WHERE drt.company_id = pr.company_id
                            AND drt.goo_id = pr.goo_id
                            AND (abn.delay_date >= drt.section_start AND
                                abn.delay_date < drt.section_end)),
                         0),
                     'AC_OTHERS',
                     abn.deduction_unit_price,
                     0)) deduction_ratio_pr,
       td.discount_price,
       td.adjust_price,
       td.adjust_reason,
       td.actual_discount_price,
       su.company_user_name adjust_person,
       td.update_time adjust_time,
       :approve_status approve_status
  FROM scmdata.t_deduction td
 INNER JOIN scmdata.t_production_progress pr
    ON td.company_id = pr.company_id
   AND td.order_id = pr.order_id
 INNER JOIN scmdata.t_abnormal abn
    ON pr.company_id = abn.company_id
   AND pr.order_id = abn.order_id
   AND pr.goo_id = abn.goo_id
   AND td.abnormal_id = abn.abnormal_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
   AND gd.group_dict_value = abn.anomaly_class
 INNER JOIN group_dict a
    ON a.group_dict_type = 'ORIGIN_TYPE'
   AND a.group_dict_value = td.orgin
  LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = td.company_id
   AND su.user_id = td.update_id
 WHERE td.company_id = %default_company_id%
   AND td.order_id = :order_code
 ORDER BY td.orgin DESC, abn.anomaly_class DESC]';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_select_sql
   WHERE t.item_id = 'a_product_130_3';
END;
