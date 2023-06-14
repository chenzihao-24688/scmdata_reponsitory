DECLARE
  --筛选日期
  v_cate          VARCHAR2(32) := '1'; --@abn_category@;
  v_start_date    DATE := SYSDATE; --@abn_begin_time@;
  v_end_date      DATE := SYSDATE; --@abn_end_time@;
  v_fileds        VARCHAR2(32) := '01';
  v_sql           CLOB;
  v_cnt_sql       CLOB;
  v_flag          NUMBER;
  v_sum_abn_price NUMBER;
  v_company_id    VARCHAR2(32) := 'a972dd1ffe3b3a10e0533c281cac8fd7';
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
   INNER JOIN (SELECT gd.supplier_code,
       gd.company_id,
       trunc(gd.create_time) create_time,
       gs.goo_id,
       gs.amount
  FROM scmdata.t_ingood gd
 INNER JOIN scmdata.t_ingoods gs
    ON gd.ing_id = gs.ing_id
   AND gd.company_id = gs.company_id
 WHERE gd.company_id = ']' || v_company_id || q'[')v ON ]' || CASE
                 WHEN v_fileds = '00' THEN
                  ' v.goo_id = tc.goo_id AND v.company_id = tc.company_id'
                 WHEN v_fileds = '01' THEN
                  ' v.supplier_code = pr.supplier_code AND v.company_id = pr.company_id '
                 WHEN v_fileds = '02' THEN
                  ''
                 ELSE
                  ''
               END || q'[
   WHERE t.company_id = ']' || v_company_id || q'['
     AND t.progress_status = '02'
     AND t.anomaly_class IN ('AC_QUALITY', 'AC_OTHERS') ]' || CASE
                 WHEN v_cate = '1' THEN
                  ' AND 1 = 1 '
                 ELSE
                  ' AND tc.category = ''' || v_cate || ''''
               END; /*|| '
     AND trunc(t.confirm_date) BETWEEN ''' || v_start_date ||
               ''' AND ''' || v_end_date || '''';*/

  EXECUTE IMMEDIATE v_cnt_sql
    INTO v_flag, v_sum_abn_price;

  v_sql := q'[WITH abn_tab AS
 (SELECT t.anomaly_class,
         tc.category, ]' || CASE
             WHEN v_fileds = '00' THEN
              'tc.product_cate,'
             ELSE
              'pr.supplier_code,
               sp.supplier_company_name,'
           END ||
           q'[       
         (nvl(t.delay_amount,pr.order_amount) * tc.price) / ]' ||
           v_sum_abn_price || q'[ * 100 abn_price_proportion,  
         nvl(t.delay_amount,pr.order_amount) * tc.price abn_price,  
         sum(v.amount*tc.price) over (partition by v.create_time) amt_price,    
         count(*) over (partition by t.goo_id)  abn_cnt,
         count(*) over (partition by pr.product_gress_code) abn_order_cnt,
         pr.product_gress_code
    FROM scmdata.t_abnormal t
   INNER JOIN scmdata.t_commodity_info tc
      ON t.goo_id = tc.goo_id
     AND t.company_id = tc.company_id
   INNER JOIN scmdata.t_production_progress pr 
      ON t.goo_id = pr.goo_id 
     AND t.order_id = pr.order_id
     AND t.company_id = pr.company_id
   INNER JOIN scmdata.t_supplier_info sp 
      ON pr.supplier_code = sp.supplier_code
     AND pr.company_id = sp.company_id
   INNER JOIN (SELECT gd.supplier_code,
       gd.company_id,
       trunc(gd.create_time) create_time,
       gs.goo_id,
       gs.amount
  FROM scmdata.t_ingood gd
 INNER JOIN scmdata.t_ingoods gs
    ON gd.ing_id = gs.ing_id
   AND gd.company_id = gs.company_id
 WHERE gd.company_id = ']' || v_company_id || q'[')v ON ]' || CASE
             WHEN v_fileds = '00' THEN
              ' v.goo_id = tc.goo_id AND v.company_id = tc.company_id'
             WHEN v_fileds = '01' THEN
              ' v.supplier_code = sp.supplier_code AND v.company_id = sp.company_id '
             WHEN v_fileds = '02' THEN
              ''
             ELSE
              ''
           END || q'[ WHERE
           t.company_id = ']' || v_company_id || q'['
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
       category,]' || CASE
             WHEN v_fileds = '00' THEN
              'product_cate,'
             ELSE
              'supplier_code,
               supplier_company_name,'
           END || q'[      
       to_char(round(abn_price_proportion,2),'fm990.00') || '%' abn_price_proportion,
       abn_price,
       amt_price,  
       to_char(round(abn_price*100/amt_price,2),'fm990.00') || '%' abn_proportion,
       abn_cnt,
       abn_order_cnt,
       sum(case when abn_order_cnt > 2 then 1 else 0 end) over (partition by product_gress_code)  two_abn_order_cnt,
       to_char(round(sum(case when abn_order_cnt > 2 then 1 else 0 end) over (partition by product_gress_code)*100 /abn_order_cnt,2),'fm990.00') || '%' two_abn_proportion
  FROM abn_tab ]' || CASE
             WHEN v_flag > 0 THEN
              q'[
UNION ALL
SELECT '合计' anomaly_class, '' category,]' || CASE
                WHEN v_fileds = '00' THEN
                 ' '''' product_cate,'
                ELSE
                 ' '''' supplier_code,
               '''' supplier_company_name,'
              END || q'[ 
        to_char(CASE
         WHEN SUM(round(abn_price_proportion, 2)) > 100 THEN
           100
        ELSE
           round(SUM(abn_price_proportion), 2)
       END ,'fm990.00')|| '%' abn_price_proportion,
       sum(abn_price) abn_price,
       sum(amt_price) amt_price,
       to_char(round(sum(abn_price)*100/sum(amt_price),2),'fm990.00') || '%' abn_proportion,
       sum(abn_cnt) abn_cnt,
       sum(abn_order_cnt) abn_order_cnt,
       sum(two_abn_order_cnt) two_abn_order_cnt,
       to_char(round(sum(two_abn_order_cnt)*100/sum(abn_order_cnt),2),'fm990.00') || '%' two_abn_proportion 
FROM (SELECT abn_price,
       round(abn_price_proportion,2) abn_price_proportion,
       amt_price,  
       round(abn_price*100/amt_price,2) abn_proportion,
       abn_cnt,
       abn_order_cnt,
       sum(case when abn_order_cnt > 2 then 1 else 0 end) over (partition by product_gress_code) two_abn_order_cnt
  FROM abn_tab )]'
             ELSE
              ''
           END;
  --@strresult := v_sql;
  dbms_output.put_line(v_sql);
END;
