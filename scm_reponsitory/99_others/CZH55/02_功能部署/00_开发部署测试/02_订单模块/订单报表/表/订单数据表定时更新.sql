/*
       (SELECT listagg(c.finish_qc_id, ',') qc_id
          FROM scmdata.t_qc_check_rela_order b
         INNER JOIN scmdata.t_qc_check c
            ON c.finish_time IS NOT NULL
           AND c.qc_check_id = b.qc_check_id
           AND c.qc_check_node = 'QC_FINAL_CHECK'
         WHERE b.orders_id = pln.orders_id) qc_id,
*/

WITH supp_info AS
 (SELECT company_id, supplier_code, supplier_company_name
    FROM scmdata.t_supplier_info),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT to_number(extract(YEAR FROM po.delivery_date)) YEAR,
       to_number(to_char(po.delivery_date, 'Q')) quarter,
       to_number(extract(MONTH FROM po.delivery_date)) MONTH,
       pr.supplier_code,
       sp_a.supplier_company_name,
       pr.factory_code,
       sp_b.supplier_company_name factory_company_name,
       pr.goo_id,
       tc.category,
       tc.product_cate,
       tc.samll_category,
       a.group_dict_name category_desc,
       b.group_dict_name coop_product_cate_desc,
       c.company_dict_name product_subclass_desc,
       tc.style_name,
       tc.style_number,
       --跟单员
       --跟单主管
       --qc
       --QC主管
       --区域组长
       --是否前20%
       --交货状态
       --是否质量问题延期
       pr.actual_delay_day,
       CASE
         WHEN pr.actual_delay_day BETWEEN 1 AND 3 THEN
          '1~3天'
         WHEN pr.actual_delay_day BETWEEN 4 AND 6 THEN
          '4~6天'
         ELSE
          '7天以上'
       END delay_interval,
       pr.responsible_dept,
       pr.responsible_dept_sec,
       pr.delay_problem_class,
       pr.delay_cause_class,
       pr.delay_cause_detailed,
       pr.problem_desc,
       pln.order_price,
       tc.price,
       pr.order_amount,
       --预计到货量
       pr.delivery_amount,
       --满足数量
       pln.order_amount * pln.order_price order_money,
       pr.delivery_amount * pln.order_price delivery_money,
       --满足金额 * pln.order_price
       po.delivery_date,
       po.create_time,
       --到仓日期
       --分拣日期
       --是否首单
       pr.memo,
       po.finish_time_scm
  FROM scmdata.t_ordered po
 INNER JOIN scmdata.t_orders pln
    ON po.company_id = pln.company_id
   AND po.order_code = pln.order_id
 INNER JOIN scmdata.t_production_progress pr
    ON pln.company_id = pr.company_id
   AND pln.order_id = pr.order_id
   AND pln.goo_id = pr.goo_id
 INNER JOIN scmdata.t_commodity_info tc
    ON pr.company_id = tc.company_id
   AND pr.goo_id = tc.goo_id
  LEFT JOIN supp_info sp_a
    ON sp_a.company_id = pr.company_id
   AND sp_a.supplier_code = pr.supplier_code
  LEFT JOIN supp_info sp_b
    ON sp_b.company_id = pr.company_id
   AND sp_b.supplier_code = pr.factory_code
  LEFT JOIN group_dict a
    ON a.group_dict_type = 'PRODUCT_TYPE'
   AND a.group_dict_value = tc.category
  LEFT JOIN group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND b.group_dict_value = tc.product_cate
  LEFT JOIN scmdata.sys_company_dict c
    ON c.company_dict_type = b.group_dict_value
   AND c.company_dict_value = tc.samll_category
   AND c.company_id = tc.company_id;
