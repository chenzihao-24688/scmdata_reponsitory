WITH delivery_amount AS
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
SELECT td.order_id order_id,
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
       td.discount_unit_price discount_unit_price,
       td.actual_discount_price actual_discount_price,
       (SELECT ln.delivery_date
          FROM scmdata.t_orders ln
         WHERE ln.company_id = pr.company_id
           AND ln.order_id = pr.order_id
           AND ln.goo_id = pr.goo_id) delivery_date,
       td.arrival_date arrival_date,
       abn.detailed_reasons,
       decode(abn.deduction_method,
              'METHOD_00',
              abn.deduction_unit_price || 'ิช/ผþ',
              'METHOD_01',
              0,
              'METHOD_02',
              decode(td.orgin,
                     'SC',
                     nvl((SELECT deduction_ratio
                            FROM deduction_ratio drt
                           WHERE drt.company_id = pr.company_id
                             AND drt.goo_id = pr.goo_id
                             AND (abn.delay_date >= drt.section_start AND
                                 abn.delay_date < drt.section_end)) || '%',
                         0),
                     'MA',
                     abn.deduction_unit_price || '%',
                     0)) deduction_ratio,
       td.discount_price,
       td.actual_discount_price,
       td.adjust_reason
  FROM scmdata.t_deduction td
 INNER JOIN scmdata.t_production_progress pr
    ON td.company_id = pr.company_id
   AND td.order_id = pr.order_id
 INNER JOIN scmdata.t_abnormal abn
    ON pr.company_id = abn.company_id
   AND pr.order_id = abn.order_id
   AND pr.goo_id = abn.goo_id
   AND td.abnormal_id = abn.abnormal_id
 WHERE td.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
   AND td.order_id = 'FAKEINFO0871';

/*   select * from scmdata.t_deduction td WHERE td.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
   AND td.order_id = 'FAKEINFO0871'*/

/* INNER JOIN scmdata.t_ordered po
     ON td.company_id = po.company_id
    AND td.order_id = po.order_code
  INNER JOIN scmdata.t_orders ln
     ON ln.company_id = po.company_id
    AND ln.order_code = po.order_id        
decode(abn.anomaly_class, 'AC_DATE',

  SELECT MAX(DISTINCT dr.delivery_date)
    INTO v_max_delivery_date
    FROM scmdata.t_delivery_record dr
   WHERE dr.company_id = p_pro_rec.company_id
     AND dr.order_code = p_pro_rec.order_id
     AND dr.goo_id = p_pro_rec.goo_id,
     
   (SELECT MAX(delivery_date)
            FROM delivery_amount dr3
           WHERE dr3.company_id = pr.company_id
             AND dr3.order_code = pr.order_id
             AND dr3.goo_id = pr.goo_id
             AND dr3.delivery_amount > 0)) delivery_date
    
    */
