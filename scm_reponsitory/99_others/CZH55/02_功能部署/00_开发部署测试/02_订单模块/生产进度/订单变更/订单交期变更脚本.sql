DECLARE
  p_produ_rec                    t_production_progress%ROWTYPE;
  v_count                        NUMBER;
  v_latest_planned_delivery_date DATE;
BEGIN
  FOR po_rec IN (SELECT *
                   FROM scmdata.t_ordered po
                  WHERE po.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
                    AND po.order_status = 'OS01') LOOP
  
    FOR pln_rec IN (SELECT *
                      FROM scmdata.t_orders t
                     WHERE po_rec.company_id = t.company_id
                       AND po_rec.order_code = t.order_id) LOOP
    
      SELECT *
        INTO p_produ_rec
        FROM scmdata.t_production_progress t
       WHERE t.company_id = pln_rec.company_id
         AND t.order_id = pln_rec.order_id
         AND t.goo_id = pln_rec.goo_id;
      --1.最新计划交期
      v_latest_planned_delivery_date := scmdata.pkg_production_progress.get_order_date(p_company_id => po_rec.company_id,
                                                                                       p_order_code => po_rec.order_code,
                                                                                       p_status     => 2);
    
      UPDATE scmdata.t_production_progress t
         SET t.latest_planned_delivery_date = v_latest_planned_delivery_date
       WHERE t.company_id = pln_rec.company_id
         AND t.order_id = pln_rec.order_id
         AND t.goo_id = pln_rec.goo_id;
    
      scmdata.pkg_production_progress.sync_orders_update_product(po_header_rec => po_rec,
                                                                 po_line_rec   => pln_rec,
                                                                 p_produ_rec   => p_produ_rec);
    
    END LOOP;
  END LOOP;
END;
/ 
DECLARE 
p_produ_rec t_production_progress%ROWTYPE;
BEGIN
  --交货记录
  SELECT *
    INTO p_produ_rec
    FROM scmdata.t_production_progress t
   WHERE t.company_id =  'b6cc680ad0f599cde0531164a8c0337f';

  FOR p_delivery_rec IN (SELECT *
              FROM scmdata.t_delivery_record dr
             WHERE dr.company_id = p_produ_rec.company_id
               AND dr.order_code = p_produ_rec.order_id
               AND dr.goo_id = p_produ_rec.goo_id) LOOP 
    scmdata.pkg_production_progress.sync_delivery_record(p_delivery_rec => p_delivery_rec);
  END LOOP;
END;
/

DECLARE
--扣款单，减免单
v_from_sql1 CLOB;
v_from_sql2 CLOB;
BEGIN
  UPDATE bw3.sys_field_list t
     SET t.caption = '最新计划交期'
   WHERE t.field_name = 'LATEST_PLANNED_DELIVERY_DATE_PR';

  v_from_sql1 := q'[WITH delivery_amount AS
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
SELECT order_id "订单单据号",
       style_number "特征",
       delay_amount "数量",
       order_price "单价",
       delay_amount * order_price "总价",
       to_char(delivery_date, 'yyyy-mm-dd') "约定交期",
       to_char(arrival_date, 'yyyy-mm-dd') "实际交期",
       detailed_reasons "扣款原因",
       deduction_ratio "应扣比例",
       actual_discount_price "应扣金额",
       adjust_reason "备注"
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
               /*(SELECT ln.delivery_date
                FROM scmdata.t_orders ln
               WHERE ln.company_id = pr.company_id
                 AND ln.order_id = pr.order_id
                 AND ln.goo_id = pr.goo_id) delivery_date,*/
               po.delivery_date delivery_date,
               td.arrival_date arrival_date,
               decode(abn.anomaly_class,
                      'AC_QUALITY',
                      '质量扣款',
                      abn.detailed_reasons) detailed_reasons,
               decode(abn.deduction_method,
                      'METHOD_00',
                      abn.deduction_unit_price || '元/件',
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
         INNER JOIN scmdata.t_ordered po
            ON po.company_id = pr.company_id
           AND po.order_code = pr.order_id
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
SELECT '合计金额' "订单单据号",
       NULL "特征",
       NULL "数量",
       NULL "单价",
       NULL "总价",
       NULL "约定交期",
       NULL "实际交期",
       NULL "扣款原因",
       NULL "应扣比例",
       (SELECT SUM(td.actual_discount_price)
          FROM scmdata.t_deduction td
         WHERE td.company_id = a.company_id
           AND td.order_id = a.order_code) "应扣金额",
       NULL "备注"
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id% AND a.order_code = :order_code]';

  v_from_sql2 := q'[WITH delivery_amount AS
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
SELECT order_id              "订单单据号",
       style_number          "特征",
       delay_amount          "数量",
       order_price   "单价",
       delay_amount*order_price           "总价",
       to_char(delivery_date,'yyyy-mm-dd')         "约定交期",
       to_char(arrival_date,'yyyy-mm-dd')          "实际交期",
       detailed_reasons      "扣款原因",
       deduction_ratio       "应扣比例",
       discount_price        "应扣金额",
       reduction_ratio       "减免比例",
       adjust_price*-1          "减免金额",
       actual_discount_price "实扣金额",
       adjust_reason         "备注"
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
               --ln.delivery_date delivery_date,
               po.delivery_date delivery_date,
               td.arrival_date arrival_date,
               decode(abn.anomaly_class,'AC_QUALITY','质量扣款',abn.detailed_reasons) detailed_reasons,
               decode(abn.deduction_method,
                      'METHOD_00',
                      abn.deduction_unit_price || '元/件',
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
         INNER JOIN scmdata.t_ordered po
            ON po.company_id = pr.company_id
           AND po.order_code = pr.order_id
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
SELECT '合计金额' "订单单据号",
       NULL "特征",
       NULL "数量",
       NULL "单价",
       NULL "总价",
       NULL "约定交期",
       NULL "实际交期",
       NULL "扣款原因",
       NULL "应扣比例",
       (SELECT td1.total_money FROM total_cal td1) "应扣金额",
       NULL "减免比例",
       (SELECT td2.total_reduction_price*-1 FROM total_cal td2) "减免金额",
       (SELECT td3.total_actual_discount_price FROM total_cal td3) "实扣金额",
       NULL "备注"
  FROM scmdata.t_ordered a
 WHERE a.company_id = %default_company_id% AND a.order_code = :order_code]';

  UPDATE bw3.sys_file_template_table t
     SET t.form_sql = v_from_sql1
   WHERE t.element_id = 'word_a_product_130_1';
  UPDATE bw3.sys_file_template_table t
     SET t.form_sql = v_from_sql2
   WHERE t.element_id = 'word_a_product_130_2';
END;
