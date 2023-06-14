--未完成订单延期情况统计
SELECT gv.category_name,
       gv.supplier_code,
       gv.owe_goo_cnt,
       gv.owe_amount,
       gv.owe_price,
       gv.act_owe_goo_cnt,
       gv.act_owe_amount,
       gv.act_owe_price,
       decode(gv.owe_price, 0, 0, gv.act_owe_price / gv.owe_price) act_owe_price_prom,
       gv.pre_owe_goo_cnt,
       gv.pre_owe_amount,
       gv.pre_owe_price,
       decode(gv.owe_price, 0, 0, gv.pre_owe_price / gv.owe_price) pre_owe_price_prom
  FROM (SELECT v.category_name,
               v.supplier_code,
               COUNT(DISTINCT v.goo_id) owe_goo_cnt,
               SUM(v.owe_amount) owe_amount,
               SUM(v.owe_amount * v.price) owe_price,
               COUNT(DISTINCT CASE
                       WHEN (v.actual_delay_day > 0 OR
                            (v.actual_delay_day = 0 AND v.check_act_days > 0 AND
                            v.check_act_prom <= CASE
                              WHEN v.category = '07' THEN
                               0.86
                              WHEN v.category = '06' THEN
                               0.92
                              ELSE
                               0.80
                            END)) THEN
                        v.goo_id
                       ELSE
                        NULL
                     END) act_owe_goo_cnt,
               SUM(CASE
                     WHEN (v.actual_delay_day > 0 OR
                          (v.actual_delay_day = 0 AND v.check_act_days > 0 AND
                          v.check_act_prom <= CASE
                            WHEN v.category = '07' THEN
                             0.86
                            WHEN v.category = '06' THEN
                             0.92
                            ELSE
                             0.80
                          END)) THEN
                      v.owe_amount
                     ELSE
                      0
                   END) act_owe_amount,
               SUM(CASE
                     WHEN (v.actual_delay_day > 0 OR
                          (v.actual_delay_day = 0 AND v.check_act_days > 0 AND
                          v.check_act_prom <= CASE
                            WHEN v.category = '07' THEN
                             0.86
                            WHEN v.category = '06' THEN
                             0.92
                            ELSE
                             0.80
                          END)) THEN
                      v.owe_amount * v.price
                     ELSE
                      0
                   END) act_owe_price,
               COUNT(DISTINCT CASE
                       WHEN (v.actual_delay_day = 0 AND v.check_act_days <= 0 AND
                            v.forecast_delay_day > 0) THEN
                        v.goo_id
                       ELSE
                        NULL
                     END) pre_owe_goo_cnt,
               SUM(CASE
                     WHEN (v.actual_delay_day = 0 AND v.check_act_days <= 0 AND
                          v.forecast_delay_day > 0) THEN
                      v.owe_amount
                     ELSE
                      0
                   END) pre_owe_amount,
               SUM(CASE
                     WHEN (v.actual_delay_day = 0 AND v.check_act_days <= 0 AND
                          v.forecast_delay_day > 0) THEN
                      v.owe_amount * v.price
                     ELSE
                      0
                   END) pre_owe_price
          FROM (SELECT po.order_code,
                       tc.category,
                       a.group_dict_name category_name,
                       c.company_dict_name product_subclass_name,
                       (SELECT listagg(fu.company_user_name, ';')
                          FROM scmdata.sys_company_user fu
                         WHERE instr(po.deal_follower, fu.user_id) > 0
                           AND fu.company_id = po.company_id) deal_follower_name,
                       sp.supplier_code,
                       sp.supplier_company_name,
                       decode(sign(pr.order_amount - pr.delivery_amount),
                              -1,
                              0,
                              pr.order_amount - pr.delivery_amount) owe_amount,
                       pr.goo_id,
                       tc.price,
                       pr.actual_delay_day,
                       pr.forecast_delay_day,
                       trunc(SYSDATE) - trunc(po.delivery_date) check_act_days,
                       pr.delivery_amount / pr.order_amount check_act_prom,
                       po.create_time,
                       po.delivery_date,
                       pr.latest_planned_delivery_date                       
                  FROM scmdata.t_ordered po
                 INNER JOIN scmdata.t_orders ln
                    ON ln.order_id = po.order_code
                   AND ln.company_id = po.company_id
                 INNER JOIN scmdata.t_production_progress pr
                    ON pr.goo_id = ln.goo_id
                   AND pr.order_id = ln.order_id
                   AND pr.company_id = ln.company_id
                  LEFT JOIN scmdata.t_supplier_info sp
                    ON sp.supplier_code = pr.supplier_code
                   AND sp.company_id = pr.company_id
                 INNER JOIN scmdata.t_commodity_info tc
                    ON pr.goo_id = tc.goo_id
                   AND pr.company_id = tc.company_id
                  LEFT JOIN scmdata.sys_group_dict a
                    ON a.group_dict_type = 'PRODUCT_TYPE'
                   AND a.group_dict_value = tc.category
                  LEFT JOIN scmdata.sys_group_dict b
                    ON b.group_dict_type = a.group_dict_value
                   AND b.group_dict_value = tc.product_cate
                  LEFT JOIN scmdata.sys_company_dict c
                    ON c.company_dict_type = b.group_dict_value
                   AND c.company_dict_value = tc.samll_category
                   AND c.company_id = tc.company_id
                 WHERE po.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
                   AND po.order_status <> 'OS02') v
         GROUP BY v.category_name, v.supplier_code) gv
