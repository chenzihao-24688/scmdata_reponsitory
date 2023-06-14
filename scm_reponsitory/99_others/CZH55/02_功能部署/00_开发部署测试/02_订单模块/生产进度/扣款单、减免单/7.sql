???prompt Importing table nbw.sys_file_template_table...
set feedback off
set define off
insert into nbw.sys_file_template_table (ELEMENT_ID, FORM_SQL, TABLE_COLWIDTHS, TABLE_NAME)
values ('word_a_product_130_1', 'WITH delivery_amount AS
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
     AND instr('';'' || dr.product_subclass || '';'',
               '';'' || tc.samll_category || '';'') > 0
     AND dr.pause = 0
   INNER JOIN scmdata.t_deduction_dtl_config dc
      ON dr.company_id = dc.company_id
     AND dr.deduction_config_id = dc.deduction_config_id
     AND dc.pause = 0
   INNER JOIN scmdata.t_deduction_config td
      ON td.company_id = dc.company_id
     AND td.deduction_config_id = dc.deduction_config_id
     AND td.pause = 0)
SELECT order_id              "订单单据号",
       style_number          "特征",
       delay_amount          "数量",
       order_price           "单价",
       delay_amount*order_price           "总价",
       to_char(delivery_date,''yyyy-mm-dd'')         "约定交期",
       to_char(arrival_date,''yyyy-mm-dd'')          "实际交期",
       detailed_reasons      "扣款原因",
       deduction_ratio       "应扣比例",
       actual_discount_price "应扣金额",
       adjust_reason         "备注"
  FROM (SELECT td.order_id order_id,
               (SELECT tc.style_number
                  FROM scmdata.t_commodity_info tc
                 WHERE tc.company_id = pr.company_id
                   AND tc.goo_id = pr.goo_id) style_number,
               decode(td.orgin,
                      ''SC'',
                      nvl(abn.delay_amount, 0),
                      ''MA'',
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
               abn.detailed_reasons,
               decode(abn.deduction_method,
                      ''METHOD_00'',
                      abn.deduction_unit_price || ''元/件'',
                      ''METHOD_01'',
                      NULL,
                      ''METHOD_02'',
                      decode(td.orgin,
                             ''SC'',
                             nvl((SELECT deduction_ratio
                                    FROM deduction_ratio drt
                                   WHERE drt.company_id = pr.company_id
                                     AND drt.goo_id = pr.goo_id
                                     AND (abn.delay_date >= drt.section_start AND
                                         abn.delay_date < drt.section_end)) || ''%'',
                                 NULL),
                             ''MA'',
                             abn.deduction_unit_price || ''%'',
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
SELECT ''合计金额'' "订单单据号",
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
 WHERE a.company_id = %default_company_id% AND a.order_code = :order_code', '4000,4000,3000,3000,3000,5000,5000,5000,4000,3000,5000', 'T_DEDUCTION');

insert into nbw.sys_file_template_table (ELEMENT_ID, FORM_SQL, TABLE_COLWIDTHS, TABLE_NAME)
values ('word_a_product_130_2', 'WITH delivery_amount AS
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
     AND instr('';'' || dr.product_subclass || '';'',
               '';'' || tc.samll_category || '';'') > 0
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
       to_char(delivery_date,''yyyy-mm-dd'')         "约定交期",
       to_char(arrival_date,''yyyy-mm-dd'')          "实际交期",
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
                      ''SC'',
                      nvl(abn.delay_amount, 0),
                      ''MA'',
                      (SELECT SUM(dr1.delivery_amount)
                         FROM delivery_amount dr1
                        WHERE dr1.company_id = pr.company_id
                          AND dr1.order_code = pr.order_id
                          AND dr1.goo_id = pr.goo_id)) delay_amount,
               ln.order_price order_price,
               --td.actual_discount_price total_money,
               ln.delivery_date delivery_date,
               td.arrival_date arrival_date,
               abn.detailed_reasons,
               decode(abn.deduction_method,
                      ''METHOD_00'',
                      abn.deduction_unit_price || ''元/件'',
                      ''METHOD_01'',
                      NULL,
                      ''METHOD_02'',
                      decode(td.orgin,
                             ''SC'',
                             nvl((SELECT deduction_ratio
                                    FROM deduction_ratio drt
                                   WHERE drt.company_id = pr.company_id
                                     AND drt.goo_id = pr.goo_id
                                     AND (abn.delay_date >= drt.section_start AND
                                         abn.delay_date < drt.section_end)) || ''%'',
                                 NULL),
                             ''MA'',
                             abn.deduction_unit_price || ''%'',
                             NULL)) deduction_ratio,
               td.discount_price,
               '''' reduction_ratio,
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
SELECT ''合计金额'' "订单单据号",
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
 WHERE a.company_id = %default_company_id% AND a.order_code = :order_code', '4000,4000,3000,3000,3000,4000,4000,5000,3000,3000,3000,3000,3000,5000', 'T_DEDUCTION');

prompt Done.
