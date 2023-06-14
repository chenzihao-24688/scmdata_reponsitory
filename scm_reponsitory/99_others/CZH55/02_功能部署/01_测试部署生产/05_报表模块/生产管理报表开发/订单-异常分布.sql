{DECLARE
  v_abn_year      VARCHAR2(4) := @abn_year@;
  v_abn_date_type VARCHAR2(32) := @abn_date_type@;
  v_abn_date      VARCHAR2(32) := @abn_date@;
  v_cate          VARCHAR2(32) := @abn_category@;
  v_fileds_type   VARCHAR2(32) := @abnc_fileds_type@;
  v_fileds        VARCHAR2(32) := @abnc_fileds_type_a@;
  v_query_filed   CLOB;
  v_query_filed_a CLOB;
  v_company_id    VARCHAR2(32) := %default_company_id%;
  v_sql           CLOB;
  v_first_day     DATE;
  v_last_day      DATE;
  v_first         VARCHAR2(2);
  v_last          VARCHAR2(2);
  v_where         CLOB;
  v_query_where   CLOB;
BEGIN
  --时间维度
  CASE
    WHEN v_abn_date_type = '00' THEN
      v_where := ' AND to_char(t.delivery_date,''yyyy'') = ''' ||
                 v_abn_year || ''' ';
    WHEN v_abn_date_type = '01' THEN
      v_where := ' AND to_char(t.delivery_date,''yyyy-mm'') = ''' ||
                 v_abn_year || '-' || v_abn_date || ''' ';
    WHEN v_abn_date_type = '02' THEN
      IF v_abn_date = '00' THEN
        v_first := '01';
        v_last  := '03';
      ELSIF v_abn_date = '01' THEN
        v_first := '04';
        v_last  := '06';
      ELSIF v_abn_date = '02' THEN
        v_first := '07';
        v_last  := '09';
      ELSIF v_abn_date = '03' THEN
        v_first := '10';
        v_last  := '12';
      ELSE
        NULL;
      END IF;
    WHEN v_abn_date_type = '03' THEN
      IF v_abn_date = '00' THEN
        v_first := '01';
        v_last  := '06';
      ELSIF v_abn_date = '01' THEN
        v_first := '07';
        v_last  := '12';
      END IF;
    ELSE
      NULL;
  END CASE;

  IF v_abn_date_type IN ('02', '03') THEN
    v_first_day := trunc(to_date(v_abn_year || v_first, 'yyyymm'), 'mm');
    v_last_day  := last_day(to_date(v_abn_year || v_last, 'yyyymm'));
    v_where     := ' AND t.delivery_date BETWEEN ''' || v_first_day ||
                   ''' AND  ''' || v_last_day || ''' ';
  ELSE
    NULL;
  END IF;
  --分部
  v_where := v_where || CASE
               WHEN v_cate = '1' THEN
                ' AND 1 = 1 '
               ELSE
                ' AND t.category = ''' || v_cate || ''' '
             END;
  --展示维度 
  --筛选字段
  CASE
    WHEN v_fileds_type = '00' THEN
      v_query_where := ' AND 1 = 1 ';
      v_query_filed := NULL;
    WHEN v_fileds_type = '01' THEN
      v_query_where   := CASE
                           WHEN v_fileds IS NULL THEN
                            ' AND 1 = 1 '
                           ELSE
                            ' AND t.samll_category = ''' || v_fileds || ''' '
                         END;
      v_query_filed   := ' product_subclass_name, ';
      v_query_filed_a := ' null product_subclass_name, ';
    WHEN v_fileds_type = '02' THEN
      v_query_where   := CASE
                           WHEN v_fileds IS NULL THEN
                            ' AND 1 = 1 '
                           ELSE
                            ' AND t.supplier_code = ''' || v_fileds || ''' '
                         END;
      v_query_filed   := ' supplier_code,supplier_company_name, ';
      v_query_filed_a := ' null supplier_code,null supplier_company_name, ';
    WHEN v_fileds_type = '03' THEN
      v_query_where   := CASE
                           WHEN v_fileds IS NULL THEN
                            ' AND 1 = 1 '
                           ELSE
                            ' AND t.factory_code = ''' || v_fileds || ''' '
                         END;
      v_query_filed   := ' factory_code,factory_company_name, ';
      v_query_filed_a := ' null supplier_code,null supplier_company_name, ';
    WHEN v_fileds_type = '04' THEN
      v_query_where   := CASE
                           WHEN v_fileds IS NULL THEN
                            ' AND 1 = 1 '
                           ELSE
                            ' AND t.qc = ''' || v_fileds || ''' '
                         END;
      v_query_filed   := ' qc_name, ';
      v_query_filed_a := ' null qc_name, ';
    WHEN v_fileds_type = '05' THEN
      v_query_where   := CASE
                           WHEN v_fileds IS NULL THEN
                            ' AND 1 = 1 '
                           ELSE
                            ' AND t.flw_order = ''' || v_fileds || ''' '
                         END;
      v_query_filed   := ' flw_order_name, ';
      v_query_filed_a := ' null flw_order_name, ';
    ELSE
      NULL;
  END CASE;

  v_where := v_where || v_query_where;

  v_sql := q'[WITH order_data AS
 (SELECT t.category,
         t.category_name,
         t.samll_category,
         t.product_subclass_name,
         t.supplier_code,
         t.factory_code,
         t.supplier_company_name,
         t.factory_company_name,
         t.is_first_order,
         t.flw_order,
         t.qc,
         t.order_money - t.satisfy_money abn_money,
         order_money,
         round((t.order_money - t.satisfy_money) * 100 / order_money,2) abn_money_propotion,
         SUM(t.order_money - t.satisfy_money) over() abn_sum_money
    FROM scmdata.pt_ordered t
   WHERE t.company_id = ']' || v_company_id || q'[']' || v_where || ')' || q'[
   SELECT category_name,
          ]' || v_query_filed || q'[
          round(abn_money * 100 / abn_sum_money,2) abn_sum_propotion,
          abn_money,
          order_money,
          abn_money_propotion
     FROM order_data
   UNION ALL 
   SELECT '合计' category_name,]' || v_query_filed_a || q'[
          round(sum(abn_money / abn_sum_money)* 100,2) abn_sum_propotion,
          sum(abn_money) abn_money,
          sum(order_money) order_money,
          round(sum(abn_money)*100/sum(order_money),2) abn_money_propotion
    FROM order_data 
   ]';
  --dbms_output.put_line(v_sql);
  @strresult := v_sql;
END;}
