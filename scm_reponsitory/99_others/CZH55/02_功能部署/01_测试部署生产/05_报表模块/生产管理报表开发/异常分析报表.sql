--分部tab a_report_abn_101
--分部tab a_report_abn_101
{DECLARE
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
         t.problem_class,
         t.cause_class,
         nvl(t.delay_amount,pr.order_amount) * tc.price abn_price,
         (nvl(t.delay_amount,pr.order_amount) * tc.price) / ]' ||
           v_sum_abn_price || q'[ * 100 abn_price_proportion,
         SUM(CASE
               WHEN t.handle_opinions = '00' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) kkreceipt,
         SUM(CASE
               WHEN t.handle_opinions = '01' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) rbreceipt,
         SUM(CASE
               WHEN t.handle_opinions = '02' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) qxorders,
         SUM(CASE
               WHEN t.handle_opinions = '03' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) dxreceipt,
         SUM(CASE
               WHEN t.handle_opinions = '04' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) jsreceipt,
         SUM(CASE
               WHEN t.handle_opinions = '05' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) fgreceipt,
         SUM(CASE
               WHEN t.handle_opinions = '06' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) jlreceipt,
         SUM(CASE
               WHEN t.handle_opinions = '07' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) jgreceipt,
         SUM(CASE
               WHEN t.handle_opinions = '08' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) yzjgreceipt,
         SUM(CASE
               WHEN t.handle_opinions = '08' THEN
                1
               ELSE
                0
             END) over(PARTITION BY t.anomaly_class, tc.category, t.problem_class, t.cause_class) dbreceipt
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
       abn_price,
       to_char(round(abn_price_proportion,2),'fm990.00') || '%' abn_price_proportion,
       kkreceipt,
       rbreceipt,
       qxorders,
       dxreceipt,
       jsreceipt,
       fgreceipt,
       jlreceipt,
       jgreceipt,
       yzjgreceipt,
       dbreceipt
  FROM abn_tab ]' || CASE
             WHEN v_flag > 0 THEN
              q'[
UNION ALL
SELECT '合计' anomaly_class,
       '' category,
       '' problem_class,
       '' cause_class,
       SUM(abn_price) abn_price,
       CASE
         WHEN SUM(round(abn_price_proportion, 2)) > 100 THEN
           100
        ELSE
           SUM(round(abn_price_proportion, 2))
       END || '%' abn_price_proportion,
       SUM(kkreceipt) kkreceipt,
       SUM(rbreceipt) rbreceipt,
       SUM(qxorders) qxorders,
       SUM(dxreceipt) dxreceipt,
       SUM(jsreceipt) jsreceipt,
       SUM(fgreceipt) fgreceipt,
       SUM(jlreceipt) jlreceipt,
       SUM(jgreceipt) jgreceipt,
       SUM(yzjgreceipt) yzjgreceipt,
       SUM(dbreceipt) dbreceipt
  FROM abn_tab
 ]'
             ELSE
              ''
           END;
  @strresult := v_sql;
  --dbms_output.put_line(v_sql);
END;
}


