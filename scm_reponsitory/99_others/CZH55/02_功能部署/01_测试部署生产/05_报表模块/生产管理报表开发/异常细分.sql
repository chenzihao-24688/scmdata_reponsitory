--异常细分
DECLARE
  --筛选日期
  v_cate          VARCHAR2(32) := @abn_category@;
  v_start_date    DATE := @abn_begin_time@;
  v_end_date      DATE := @abn_end_time@;
  v_sql           CLOB;
  v_cnt_sql       CLOB;
  v_flag          NUMBER;
  v_sum_abn_price NUMBER;
BEGIN

  v_cnt_sql := q'[SELECT COUNT(*), nvl(SUM(nvl(t.delay_amount, pr.order_amount) * tc.price),0)  
    FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr
      ON t.goo_id = pr.goo_id
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   WHERE t.company_id = ']' || %default_company_id% || q'['
     AND t.progress_status = '02'
     AND t.anomaly_class IN ('AC_QUALITY', 'AC_OTHERS') ]' || CASE
                 WHEN v_cate = '1' THEN
                  ' AND 1 = 1 '
                 ELSE
                  ' AND tc.category = ''' || v_cate || ''''
               END || '
     AND trunc(t.confirm_date) BETWEEN ''' || v_start_date ||
               ''' AND ''' || v_end_date || '''';

  EXECUTE IMMEDIATE v_cnt_sql
    INTO v_flag, v_sum_abn_price;

  v_sql := q'[WITH abn_tab AS
 (SELECT t.anomaly_class,
         tc.category,
         tc.samll_category,
         t.problem_class,
         t.cause_class,
         nvl(t.delay_amount,pr.order_amount) * tc.price abn_price,
         (nvl(t.delay_amount,pr.order_amount) * tc.price) / ]' ||
           v_sum_abn_price || q'[ * 100 abn_price_proportion,
         FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr 
      ON t.goo_id = pr.goo_id 
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   WHERE t.company_id = ']' || %default_company_id% || q'['
     AND t.progress_status = '02'
     AND t.anomaly_class IN ('AC_QUALITY','AC_OTHERS') 
     ]' || CASE
             WHEN v_cate = '1' THEN
              ' AND 1 = 1'
             ELSE
              q'[ AND tc.category = ']' || v_cate || q'[' ]'
           END || '
     AND trunc(t.confirm_date) BETWEEN ''' || v_start_date ||
           ''' AND ''' || v_end_date || '''' || q'[)
SELECT anomaly_class,
       category,
       problem_class,
       cause_class,       
       to_char(round(abn_price_proportion,2),'fm990.00') || '%' abn_price_proportion,
       abn_price
  FROM abn_tab ]' || CASE
             WHEN v_flag > 0 THEN
              q'[
UNION ALL
SELECT '合计' anomaly_class,
       '' category,
       '' problem_class,
       '' cause_class,      
       CASE
         WHEN SUM(round(abn_price_proportion, 2)) > 100 THEN
           100
        ELSE
           SUM(round(abn_price_proportion, 2))
       END || '%' abn_price_proportion
  FROM abn_tab
 ]'
             ELSE
              ''
           END;
  --@strresult := v_sql;
  dbms_output.put_line(v_sql);
END;
