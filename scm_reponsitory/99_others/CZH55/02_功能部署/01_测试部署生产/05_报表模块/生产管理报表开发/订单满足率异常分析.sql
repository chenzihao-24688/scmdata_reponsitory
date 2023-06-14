DECLARE
  v_abn_year      VARCHAR2(4) := @abn_year@;
  v_abn_date_type VARCHAR2(32) := @abn_date_type@;
  v_abn_date      VARCHAR2(32) := @abn_date@;
  v_cate          VARCHAR2(32) := @abn_category@;
  v_group         VARCHAR2(256) := @abn_group@;
  v_fileds_type   VARCHAR2(32) := @abnc_fileds_type@;
  v_fileds        VARCHAR2(32) := @abnc_fileds_type_a@;
  v_query_filed   CLOB;
  v_query_filed_a CLOB;
  v_company_id    VARCHAR2(32) := %default_company_id%;
  v_sql           CLOB;
  v_where         CLOB;
  v_query_where   CLOB;
  v_first_day     DATE;
  v_last_day      DATE;
  v_first         VARCHAR2(2);
  v_last          VARCHAR2(2);
  v_hj_sql        CLOB;
  v_hj_flag       NUMBER;
BEGIN
  --时间维度
  CASE
    WHEN v_abn_date_type = '00' THEN
      v_where := ' WHERE to_char(v.delivery_date,''yyyy'') = ''' ||
                 v_abn_year || ''' ';
    WHEN v_abn_date_type = '01' THEN
      v_where := ' WHERE to_char(v.delivery_date,''yyyy-mm'') = ''' ||
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
  END CASE;

  IF v_abn_date_type IN ('02', '03') THEN
    v_first_day := trunc(to_date(v_abn_year || v_first, 'yyyymm'), 'mm');
    v_last_day  := last_day(to_date(v_abn_year || v_last, 'yyyymm'));
    v_where     := ' WHERE v.delivery_date BETWEEN ''' || v_first_day ||
                   ''' AND  ''' || v_last_day || ''' ';
  ELSE
    NULL;
  END IF;
  --分部
  v_where := v_where || CASE
               WHEN v_cate = '1' THEN
                ' AND 1 = 1 '
               ELSE
                ' AND v.category = ''' || v_cate || ''' '
             END;
  --区域组
  v_where := v_where || CASE
               WHEN v_group = '1' THEN
                ' AND 1 = 1 '
               ELSE
                ' AND v.group_name = ''' || v_group || ''' '
             END;

  --展示维度 
  --筛选字段
  CASE
    WHEN v_fileds_type = '00' THEN
      v_query_where := ' AND 1 = 1 ';
      v_query_filed := NULL;
    WHEN v_fileds_type = '01' THEN
      v_query_where := CASE
                         WHEN v_fileds IS NULL THEN
                          ' AND 1 = 1 '
                         ELSE
                          ' AND v.samll_category = ''' || v_fileds || ''' '
                       END;
      v_query_filed := ' product_subclass_name, ';
      v_query_filed_a := ' null product_subclass_name, ';
    WHEN v_fileds_type = '02' THEN
      v_query_where := CASE
                         WHEN v_fileds IS NULL THEN
                          ' AND 1 = 1 '
                         ELSE
                          ' AND v.supplier_code = ''' || v_fileds || ''' '
                       END;
      v_query_filed := ' supplier_code,supplier_company_name, ';
      v_query_filed_a := ' null supplier_code,null supplier_company_name, ';
    WHEN v_fileds_type = '03' THEN
      v_query_where := CASE
                         WHEN v_fileds IS NULL THEN
                          ' AND 1 = 1 '
                         ELSE
                          ' AND v.factory_code = ''' || v_fileds || ''' '
                       END;
      v_query_filed := ' factory_code,factory_company_name, ';
      v_query_filed_a := ' null supplier_code,null supplier_company_name, ';
    WHEN v_fileds_type = '04' THEN
      v_query_where := CASE
                         WHEN v_fileds IS NULL THEN
                          ' AND 1 = 1 '
                         ELSE
                          ' AND v.qc = ''' || v_fileds || ''' '
                       END;
      v_query_filed := ' qc_name, ';
      v_query_filed_a := ' null qc_name, ';
    WHEN v_fileds_type = '05' THEN
      v_query_where := CASE
                         WHEN v_fileds IS NULL THEN
                          ' AND 1 = 1 '
                         ELSE
                          ' AND v.flw_order = ''' || v_fileds || ''' '
                       END;
      v_query_filed := ' flw_order_name, ';
      v_query_filed_a := ' null flw_order_name, ';
  END CASE;

  v_where := v_where || v_query_where;

  --合计是否展示
  v_hj_sql := q'[SELECT COUNT(1)
  FROM scmdata.pt_ordered t
 INNER JOIN scmdata.t_ordered po
    ON t.order_id = po.order_id
   AND t.company_id = po.company_id
 INNER JOIN scmdata.t_orders pln
    ON po.order_code = pln.order_id
   AND po.company_id = pln.company_id
 INNER JOIN scmdata.t_production_progress pr
    ON pln.goo_id = pr.goo_id
   AND pln.order_id = pr.order_id
   AND pln.company_id = pr.company_id
  LEFT JOIN scmdata.sys_company_user a
    ON a.user_id = t.qc
   AND a.company_id = t.company_id
  LEFT JOIN scmdata.sys_company_user b
    ON b.user_id = t.flw_order
   AND b.company_id = t.company_id
 WHERE t.delivery_status <> '正常'
   AND t.company_id = ']' || v_company_id || q'['
    AND t.delay_problem_class IS NOT NULL
    AND t.delay_cause_class IS NOT NULL
    AND t.delay_cause_detailed IS NOT NULL
    ]';

  EXECUTE IMMEDIATE v_hj_sql
    INTO v_hj_flag;

  v_sql := q'[WITH order_data AS
 (SELECT v.category,
         v.category_name,]' || v_query_filed || q'[
         v.responsible_dept,
         v.delay_problem_class,
         v.delay_cause_class,
         v.delay_cause_detailed,
         v.is_sup_responsible,
         v.abn_money,
         v.abn_money * 100 / SUM(abn_money) over() abn_money_propotion,
         v.delay_ot,
         v.delay_fs,
         v.delay_s
    FROM (SELECT DISTINCT t.category,
                          t.category_name,
                          t.responsible_dept,
                          t.delay_problem_class,
                          t.delay_cause_class,
                          t.delay_cause_detailed,
                          pr.is_sup_responsible,
                          SUM(t.order_money - t.satisfy_money) over(PARTITION BY t.category, t.delay_problem_class, t.delay_cause_class, t.delay_cause_detailed) abn_money,
                          SUM(CASE
                                WHEN pr.actual_delay_day BETWEEN 1 AND 3 THEN
                                 t.order_money - t.satisfy_money
                                ELSE
                                 0
                              END) over(PARTITION BY t.category, t.delay_problem_class, t.delay_cause_class, t.delay_cause_detailed) delay_ot,
                          SUM(CASE
                                WHEN pr.actual_delay_day BETWEEN 4 AND 7 THEN
                                 t.order_money - t.satisfy_money
                                ELSE
                                 0
                              END) over(PARTITION BY t.category, t.delay_problem_class, t.delay_cause_class, t.delay_cause_detailed) delay_fs,
                          SUM(CASE
                                WHEN pr.actual_delay_day > 7 THEN
                                 t.order_money - t.satisfy_money
                                ELSE
                                 0
                              END) over(PARTITION BY t.category, t.delay_problem_class, t.delay_cause_class, t.delay_cause_detailed) delay_s,
                          t.delivery_date,
                          t.samll_category,
                          t.product_subclass_name, 
                          t.qc,
                          a.company_user_name qc_name,
                          t.flw_order, 
                          b.company_user_name flw_order_name,
                          t.supplier_code,
                          t.supplier_company_name,
                          t.factory_company_name,
                          t.factory_code,
                          t.group_name,
                          t.company_id                              
            FROM scmdata.pt_ordered t
           INNER JOIN scmdata.t_ordered po
              ON t.order_id = po.order_id
             AND t.company_id = po.company_id
           INNER JOIN scmdata.t_orders pln
              ON po.order_code = pln.order_id
             AND po.company_id = pln.company_id
           INNER JOIN scmdata.t_production_progress pr
              ON pln.goo_id = pr.goo_id
             AND pln.order_id = pr.order_id
             AND pln.company_id = pr.company_id
           LEFT JOIN scmdata.sys_company_user a 
              ON a.user_id = t.qc
            AND a.company_id = t.company_id
           LEFT JOIN scmdata.sys_company_user b 
              ON b.user_id = t.flw_order
            AND b.company_id = t.company_id
           WHERE t.delivery_status <> '正常'
             AND t.company_id = ']' || v_company_id || q'['
             AND t.delay_problem_class IS NOT NULL
             AND t.delay_cause_class IS NOT NULL
             AND t.delay_cause_detailed IS NOT NULL) v
             ]' || v_where || q'[
         ORDER BY v.abn_money DESC)
SELECT category_name,]' || v_query_filed || q'[
       responsible_dept,
       delay_problem_class,
       delay_cause_class,
       delay_cause_detailed,
       is_sup_responsible,
       abn_money,
       round(abn_money_propotion, 2) abn_money_propotion,
       round(CASE
               WHEN abn_money <= 0 THEN
                0
               ELSE
                delay_ot * 100 / abn_money
             END,
             2) delay_otp,
       delay_ot,
       round(CASE
               WHEN abn_money <= 0 THEN
                0
               ELSE
                delay_fs * 100 / abn_money
             END,
             2) delay_fsp,
       delay_fs,
       round(CASE
               WHEN abn_money <= 0 THEN
                0
               ELSE
                delay_s * 100 / abn_money
             END,
             2) delay_sp,
       delay_s
  FROM order_data ]' || CASE
             WHEN v_hj_flag = 0 THEN
              NULL
             ELSE
              q'[
UNION ALL
SELECT '合计' category_name,]' || CASE
                WHEN v_query_filed_a IS NULL THEN
                 NULL
                ELSE
                  v_query_filed_a
              END || q'[
       NULL responsible_dept,
       NULL delay_problem_class,
       NULL delay_cause_class,
       NULL delay_cause_detailed,
       NULL is_sup_responsible,
       SUM(abn_money) abn_money,
       round(SUM(abn_money_propotion), 2) abn_money_propotion,
       round(SUM(delay_ot) * 100 / SUM(abn_money), 2) delay_otp,
       SUM(delay_ot) delay_ot,
       round(SUM(delay_fs) * 100 / SUM(abn_money), 2) delay_fsp,
       SUM(delay_fs) delay_fs,
       round(SUM(delay_s) * 100 / SUM(abn_money), 2) delay_sp,
       SUM(delay_s) delay_s
  FROM order_data]'
           END;
  @strresult := v_sql;
END;
