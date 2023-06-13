WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT * FROM scmdata.sys_group_dict),
pn_node AS
 (SELECT pn.node_name || a.group_dict_name pno_status,
         pn.progress_status,
         pn.node_num,
         pn.node_name,
         pn.plan_completion_time,
         pn.company_id,
         pn.product_gress_id
    FROM scmdata.t_production_node pn
   INNER JOIN sys_group_dict a
      ON a.group_dict_value = pn.progress_status
   INNER JOIN sys_group_dict b
      ON a.group_dict_type = b.group_dict_value
     AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
   WHERE pn.company_id = %default_company_id%)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr, --生产订单编号
       t.progress_status    progress_status_pr,
       --a.group_dict_name progress_status_desc,
       nvl((SELECT pno_status
             FROM (SELECT pn.pno_status
                     FROM pn_node pn
                    WHERE pn.company_id = t.company_id
                      AND pn.product_gress_id = t.product_gress_id
                      AND pn.progress_status IS NOT NULL
                    ORDER BY pn.node_num DESC)
            WHERE rownum = 1),
           a.group_dict_name) progress_status_desc, --生产进度状态
       t.order_id order_id_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp1.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp2.supplier_company_name factory_company_name_pr,
       nvl(t.latest_planned_delivery_date, od.delivery_date) delivery_date_pr, --订单交期
       --t.forecast_delivery_date forecast_delivery_date_pr, --预测交期
       
       decode((SELECT pno_status
                FROM (SELECT pn.pno_status
                        FROM pn_node pn
                       WHERE pn.company_id = t.company_id
                         AND pn.product_gress_id = t.product_gress_id
                         AND pn.progress_status IS NOT NULL
                       ORDER BY pn.node_num DESC)
               WHERE rownum = 1),
              '',
              CASE
                WHEN (SELECT pn.plan_completion_time
                        FROM pn_node pn
                       WHERE pn.company_id = t.company_id
                         AND pn.product_gress_id = t.product_gress_id
                         AND pn.node_name = '交货') IS NOT NULL THEN
                 (SELECT pn.plan_completion_time
                    FROM pn_node pn
                   WHERE pn.company_id = t.company_id
                     AND pn.product_gress_id = t.product_gress_id
                     AND pn.node_name = '交货')
                ELSE
                 od.delivery_date
              END,
              od.delivery_date) forecast_delivery_date_pr,
              
       t.forecast_delivery_date - od.delivery_date forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delivery_date - od.delivery_date actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       t.order_amount - t.delivery_amount owe_amount_pr,
       t.approve_edition approve_edition_pr,
       t.fabric_check fabric_check_pr,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       t.exception_handle_status exception_handle_status_pr,
       t.handle_opinions handle_opinions_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = '已接单' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.progress_status <> '01'
 INNER JOIN group_dict a
    ON a.group_dict_value = t.progress_status
 INNER JOIN group_dict b
    ON b.group_dict_value = a.group_dict_type
   AND b.group_dict_value = 'PROGRESS_TYPE'
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.rela_goo_id
 INNER JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%
