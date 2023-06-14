WITH cmd_info AS
 (SELECT tc.category,
         ga.group_dict_name   category_name,
         gb.group_dict_name,
         tc.samll_category,
         gc.company_dict_name product_subclass_name,
         tc.goo_id,
         tc.company_id,
         tc.price
    FROM scmdata.t_commodity_info tc
   INNER JOIN scmdata.sys_group_dict ga
      ON ga.group_dict_value = tc.category
     AND ga.group_dict_type = 'PRODUCT_TYPE'
   INNER JOIN scmdata.sys_group_dict gb
      ON gb.group_dict_value = tc.product_cate
     AND gb.group_dict_type = ga.group_dict_value
   INNER JOIN scmdata.sys_company_dict gc
      ON gc.company_dict_value = tc.samll_category
     AND gc.company_dict_type = gb.group_dict_value
     AND gc.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7')
SELECT category_name,
       product_subclass_name,
       abn_money / SUM(abn_money) over() abn_sum_propotion,
       goo_cnt,
       abn_cnt,
       two_abn_order_cnt,
       two_abn_order_cnt / abn_cnt two_abn_proportion
  FROM (SELECT DISTINCT gv.category_name,
                        gv.product_subclass_name,
                        SUM(abn_money) abn_money,
                        COUNT(DISTINCT gv.goo_id) goo_cnt,
                        COUNT(gv.product_gress_code) abn_cnt,
                        SUM(CASE
                              WHEN gv.two_abn_order_cnt > = 2 THEN
                               1
                              ELSE
                               0
                            END) two_abn_order_cnt
          FROM (SELECT DISTINCT v.category,
                                v.category_name,
                                v.samll_category,
                                v.product_subclass_name,
                                v.supplier_code,
                                v.supplier_company_name,
                                SUM(v.abn_money) over(PARTITION BY v.category, v.samll_category, v.product_gress_code) abn_money,
                                v.goo_id,
                                v.product_gress_code,
                                COUNT(v.abnormal_code) over(PARTITION BY v.category, v.samll_category, v.product_gress_code) two_abn_order_cnt
                  FROM (SELECT cf.category,
                               cf.category_name,
                               cf.samll_category,
                               cf.product_subclass_name,
                               sp.supplier_code,
                               sp.supplier_company_name,
                               nvl(t.delay_amount, pr.order_amount) * cf.price abn_money,
                               100 amt_price,
                               cf.goo_id,
                               t.abnormal_code,
                               pr.product_gress_code
                          FROM scmdata.t_abnormal t
                         INNER JOIN scmdata.t_production_progress pr
                            ON t.goo_id = pr.goo_id
                           AND t.order_id = pr.order_id
                           AND t.company_id = pr.company_id
                         INNER JOIN cmd_info cf
                            ON pr.goo_id = cf.goo_id
                           AND pr.company_id = cf.company_id
                         INNER JOIN scmdata.t_supplier_info sp
                            ON pr.supplier_code = sp.supplier_code
                           AND pr.company_id = sp.company_id
                         WHERE t.company_id =
                               'a972dd1ffe3b3a10e0533c281cac8fd7'
                           AND cf.category = '00') v) gv
         GROUP BY gv.category_name, gv.product_subclass_name)
