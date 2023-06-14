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
  v_union_sql     CLOB;
  v_gp_sql        CLOB;
  v_gp_sql_a      CLOB;
  v_where         CLOB;
  v_query_where   CLOB;
  v_first_day     DATE;
  v_last_day      DATE;
  v_first         VARCHAR2(2);
  v_last          VARCHAR2(2);
BEGIN
  v_where := q'[ WHERE t.delivery_status <> '正常' AND t.company_id = ']' ||
             v_company_id || q'[']';
  --时间维度
  CASE
    WHEN v_abn_date_type = '00' THEN
      v_where := v_where || ' AND to_char(t.delivery_date,''yyyy'') = ''' ||
                 v_abn_year || ''' ';
    WHEN v_abn_date_type = '01' THEN
      v_where := v_where ||
                 ' AND to_char(t.delivery_date,''yyyy-mm'') = ''' ||
                 v_abn_year || '-' || v_abn_date || ''' ';
    WHEN v_abn_date_type = '02' THEN
      IF v_abn_date = '01' THEN
        v_first := '01';
        v_last  := '03';
      ELSIF v_abn_date = '02' THEN
        v_first := '04';
        v_last  := '06';
      ELSIF v_abn_date = '03' THEN
        v_first := '07';
        v_last  := '09';
      ELSIF v_abn_date = '04' THEN
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
    v_where     := v_where || ' AND t.delivery_date BETWEEN ''' ||
                   v_first_day || ''' AND  ''' || v_last_day || ''' ';
  ELSE
    NULL;
  END IF;

  --where sql
  --分部 
  CASE
    WHEN v_cate = '1' THEN
      v_where := v_where || ' AND 1 = 1 ';
    
    ELSE
      v_where := v_where || ' AND t.category = ''' || v_cate || ''' ';
  END CASE;
  --区域组
  CASE
    WHEN v_group = '全部' THEN
      v_where := v_where || ' AND 1 = 1 ';
    ELSE
      v_where := v_where || ' AND t.group_name = ''' || v_group || ''' ';
  END CASE;

  --展示维度 
  --group sql
  v_query_filed_a := q'[ '合计' group_name, null category_name,]';
  IF v_cate = '1' AND v_group = '全部' THEN
    v_query_filed := q'[ '全部' group_name, '全部' category_name,]';
    v_gp_sql      := 'GROUP BY v.delay_problem_class, v.delay_cause_class,v.delay_cause_detailed, v.is_sup_responsible';
    IF v_fileds_type <> '00' THEN
      raise_application_error(-20002,
                              '请至少选择一项分部/区域组进行查询！');
    END IF;
  ELSE
    IF v_cate = '1' AND v_group <> '全部' THEN
      v_query_filed := q'[ v.group_name, '全部' category_name,]';
      v_gp_sql      := ' GROUP BY v.group_name';
    ELSIF v_cate <> '1' AND v_group = '全部' THEN
      v_query_filed := q'[ '全部' group_name, v.category_name,]';
      v_gp_sql      := ' GROUP BY v.category_name ';
    ELSE
      v_query_filed := q'[ v.group_name, v.category_name,]';
      v_gp_sql      := ' GROUP BY v.group_name, v.category_name';
    END IF;
    --根据筛选字段进行分组统计
    IF v_fileds_type = '00' THEN
      NULL;
    ELSE
      CASE
        WHEN v_fileds_type = '01' THEN
          v_gp_sql_a      := ',v.product_subclass_name';
          v_query_filed   := v_query_filed || ' v.product_subclass_name, ';
          v_query_filed_a := v_query_filed_a ||
                             ' null product_subclass_name, ';
          v_where         := v_where || ' AND t.product_subclass_name = ''' ||
                             v_fileds || '''';
        WHEN v_fileds_type = '02' THEN
          v_gp_sql_a      := ',v.supplier_code,v.supplier_company_name';
          v_query_filed   := v_query_filed ||
                             ' v.supplier_code,v.supplier_company_name, ';
          v_query_filed_a := v_query_filed_a ||
                             ' null supplier_code,null supplier_company_name, ';
          v_where         := v_where || ' AND t.supplier_code = ''' ||
                             v_fileds || '''';
        WHEN v_fileds_type = '03' THEN
          v_gp_sql_a      := ',v.factory_code,v.factory_company_name';
          v_query_filed   := v_query_filed ||
                             ' v.factory_code,v.factory_company_name, ';
          v_query_filed_a := v_query_filed_a ||
                             ' null factory_code,null factory_company_name, ';
          v_where         := v_where || ' AND tt.factory_code = ''' ||
                             v_fileds || '''';
        WHEN v_fileds_type = '04' THEN
          v_gp_sql_a      := ',v.qc_name';
          v_query_filed   := v_query_filed || ' v.qc_name, ';
          v_query_filed_a := v_query_filed_a || ' null qc_name, ';
          v_where         := v_where || ' AND t.qc = ''' || v_fileds || '''';
        WHEN v_fileds_type = '05' THEN
          v_gp_sql_a      := ' ,v.flw_order_name ';
          v_query_filed   := v_query_filed || ' v.flw_order_name, ';
          v_query_filed_a := v_query_filed_a || ' null flw_order_name, ';
          v_where         := v_where || ' AND t.flw_order = ''' || v_fileds || '''';
        ELSE
          NULL;
      END CASE;
    END IF;
    v_gp_sql := v_gp_sql || v_gp_sql_a ||
                ',v.delay_problem_class, v.delay_cause_class,v.delay_cause_detailed, v.is_sup_responsible';
  END IF;
  v_sql := q'[SELECT ]' || v_query_filed || q'[
         v.delay_problem_class,
         v.delay_cause_class,
         v.delay_cause_detailed,
         v.is_sup_responsible,
         SUM(v.abn_money)*100 / MAX(abn_sum_money) abn_sum_propotion,
         SUM(v.abn_money) abn_money,
         SUM(CASE
               WHEN v.actual_delay_day BETWEEN 1 AND 3 THEN
                v.abn_money
               ELSE
                0
             END) delay_ot,
         SUM(CASE
               WHEN v.actual_delay_day BETWEEN 1 AND 3 THEN
                v.abn_money
               ELSE
                0
             END)*100 / SUM(v.abn_money) delay_otp,
         SUM(CASE
               WHEN v.actual_delay_day BETWEEN 4 AND 7 THEN
                v.abn_money
               ELSE
                0
             END) delay_fs,   
         SUM(CASE
               WHEN v.actual_delay_day BETWEEN 4 AND 7 THEN
                v.abn_money
               ELSE
                0
             END)*100 / SUM(v.abn_money) delay_fsp,
         SUM(CASE
               WHEN v.actual_delay_day > 7 THEN
                v.abn_money
               ELSE
                0
             END) delay_s,
         SUM(CASE
               WHEN v.actual_delay_day > 7 THEN
                v.abn_money
               ELSE
                0
             END)*100 / SUM(v.abn_money) delay_sp
    FROM (SELECT t.group_name,
                 t.category,
                 t.category_name,
                 t.samll_category,
                 t.product_subclass_name,
                 t.supplier_code,
                 t.supplier_company_name,
                 t.factory_code,
                 t.factory_company_name,
                 t.qc,
                 a.company_user_name qc_name,
                 t.flw_order,
                 b.company_user_name flw_order_name,
                 t.responsible_dept,
                 t.delay_problem_class,
                 t.delay_cause_class,
                 t.delay_cause_detailed,
                 pr.is_sup_responsible,
                 pr.actual_delay_day,
                 t.order_money - t.satisfy_money abn_money,
                 SUM(t.order_money - t.satisfy_money) over() abn_sum_money,
                 t.delivery_date,
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
             AND b.company_id = t.company_id ]' || v_where ||
           q'[)v ]' || v_gp_sql;

  --合计
  v_union_sql := v_sql || q'[ UNION ALL SELECT ]' || v_query_filed_a || q'[
       NULL delay_problem_class,
       NULL delay_cause_class,
       NULL delay_cause_detailed,
       NULL is_sup_responsible,
       SUM(abn_money)*100/SUM(abn_money) abn_sum_propotion,
       SUM(abn_money) abn_money,
       SUM(delay_ot) delay_ot,
       SUM(delay_ot)*100/ SUM(abn_money) delay_otp,
       SUM(delay_fs) delay_fs,
       SUM(delay_fs)*100/ SUM(abn_money) delay_fsp,
       SUM(delay_s) delay_s,
       SUM(delay_s)*100/ SUM(abn_money) delay_sp
  FROM (]' || v_sql || ')';

  dbms_output.put_line(v_union_sql);
END;
