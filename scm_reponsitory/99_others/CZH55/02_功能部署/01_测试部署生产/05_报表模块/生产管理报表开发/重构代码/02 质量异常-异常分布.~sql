DECLARE
  v_begin_date  DATE := @abn_begin_time@;
  v_end_date    DATE := @abn_end_time@;
  v_cate        VARCHAR2(32) := @abn_category@;
  v_fileds_type VARCHAR2(32) := @abn_fileds_type@;
  v_company_id  VARCHAR2(32) := %default_company_id%;
  v_sql         CLOB;
  v_amt_price   NUMBER;
  v_where_sql   CLOB;
  v_gp_sql      CLOB;
BEGIN
  v_where_sql := CASE
                   WHEN v_cate = '1' THEN
                    q'[ AND '1' = :1 ]'
                   ELSE
                    q'[' AND tc.category = :1 ]'
                 END;
  v_gp_sql := ' GROUP BY tc.category ' || CASE
                WHEN v_fileds_type = '00' THEN
                 ''
                WHEN v_fileds_type = '01' THEN
                 ',tc.samll_category '
                WHEN v_fileds_type = '02' THEN
                 ',supplier_code '
                ELSE
                 ''
              END;
  v_ingd_sql  := q'[ SELECT SUM(gs.amount * tc.price) amt_price   
    FROM scmdata.t_ingood gd
   INNER JOIN scmdata.t_ingoods gs
      ON gd.ing_id = gs.ing_id
     AND gd.company_id = gs.company_id
   INNER JOIN scmdata.t_commodity_info tc
      ON gs.goo_id = tc.goo_id
     AND gs.company_id = tc.company_id
   WHERE gd.company_id = ']' || v_company_id || v_where_sql || q'[
     AND trunc(gd.create_time) BETWEEN :2 AND :3 ]' ||
                 v_gp_sql;

  EXECUTE IMMEDIATE v_ingd_sql
    USING v_cate, v_begin_date, v_end_date
    INTO v_amt_price;

  v_gp_sql := ' GROUP BY cate_name ' || CASE
                WHEN v_fileds_type = '00' THEN
                 ''
                WHEN v_fileds_type = '01' THEN
                 ',product_subclass_name '
                WHEN v_fileds_type = '02' THEN
                 ',supplier_code,supplier_company_name'
                ELSE
                 ''
              END;

  v_sql := q'[ SELECT v.cate_name,
         SUM(abn_money) / MAX(abn_sum_money) abn_sum_propotion,
         SUM(abn_money) abn_money,]' || v_amt_price ||
           q'[ amt_price,
         SUM(abn_money) / ]' || v_amt_price ||
           q'[ abn_money_propotion
    FROM (SELECT tc.category,
                 ga.group_dict_name cate_name,
                 tc.samll_category,
                 gc.company_dict_name product_subclass_name,
                 sp.supplier_code,
                 sp.supplier_company_name,
                 SUM(nvl(t.delay_amount, pr.order_amount) * tc.price) over() abn_sum_money,
                 nvl(t.delay_amount, pr.order_amount) * tc.price abn_money,
                 pr.product_gress_code
            FROM scmdata.t_abnormal t
           INNER JOIN scmdata.t_commodity_info tc
              ON t.goo_id = tc.goo_id
             AND t.company_id = tc.company_id
           INNER JOIN scmdata.sys_group_dict ga
              ON ga.group_dict_value = tc.category
             AND ga.group_dict_type = 'PRODUCT_TYPE'
           INNER JOIN scmdata.sys_group_dict gb
              ON gb.group_dict_value = tc.product_cate
             AND gb.group_dict_type = ga.group_dict_value
           INNER JOIN scmdata.sys_company_dict gc
              ON gc.company_dict_value = tc.samll_category
             AND gc.company_dict_type = gb.group_dict_value
           INNER JOIN scmdata.t_production_progress pr
              ON t.goo_id = pr.goo_id
             AND t.order_id = pr.order_id
             AND t.company_id = pr.company_id
           INNER JOIN scmdata.t_supplier_info sp
              ON pr.supplier_code = sp.supplier_code
             AND pr.company_id = sp.company_id
           WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
             AND trunc(t.create_time) BETWEEN p_begin_date AND p_end_date
             AND tc.category = ']' || v_where_sql
           q'[') v]' || v_gp_sql;
  dbms_output.put_line(v_sql);
END;
