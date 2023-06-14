CREATE OR REPLACE PACKAGE pkg_report_analy IS

  -- Author  : SANFU
  -- Created : 2022/3/16 10:56:53
  -- Purpose : 报表分析
  --订单满足率-异常分布 a_report_abn_202
  FUNCTION f_get_abn_distribut_report(p_company_id       VARCHAR2,
                                      p_class_data_privs CLOB,
                                      p_abn_year         VARCHAR2,
                                      p_abn_date_type    VARCHAR2,
                                      p_abn_date         VARCHAR2,
                                      p_abn_category     VARCHAR2,
                                      p_abnf_fileds_type VARCHAR2,
                                      p_abn_group        VARCHAR2)
    RETURN CLOB;

  --获取订单满足率  a_report_abn_201
  --原因分析
  FUNCTION f_get_abn_cause_report(p_company_id         VARCHAR2,
                                  p_class_data_privs   CLOB,
                                  p_abn_year           VARCHAR2,
                                  p_abn_date_type      VARCHAR2,
                                  p_abn_date           VARCHAR2,
                                  p_abn_category       VARCHAR2,
                                  p_abn_group          VARCHAR2,
                                  p_abnc_fileds_type   VARCHAR2,
                                  p_abnc_fileds_type_a VARCHAR2) RETURN CLOB;

  --异常处理-原因分布
  FUNCTION f_get_abn_distribut(p_begin_date       DATE,
                               p_end_date         DATE,
                               p_cate             VARCHAR2,
                               p_fileds_type      VARCHAR2,
                               p_company_id       VARCHAR2,
                               p_class_data_privs CLOB) RETURN CLOB;
  --异常处理 异常原因分析
  FUNCTION f_get_abn_cause(p_start_date  DATE,
                           p_end_date    DATE,
                           p_cate        VARCHAR2,
                           p_fileds_type VARCHAR2,
                           p_fileds      VARCHAR2,
                           p_company_id  VARCHAR2) RETURN CLOB;
  --异常处理 异常原因分析
  FUNCTION f_get_abn_cause_ma(p_start_date       DATE,
                              p_end_date         DATE,
                              p_cate             VARCHAR2,
                              p_fileds_type      VARCHAR2,
                              p_fileds           VARCHAR2,
                              p_company_id       VARCHAR2,
                              p_class_data_privs VARCHAR2) RETURN CLOB;
  --可结束生产进度表
  FUNCTION f_finished_orders(p_company_id       VARCHAR2,
                             p_class_data_privs CLOB) RETURN CLOB;
  --动态获取订单列表
  FUNCTION f_get_orders_list(p_company_id VARCHAR2,
                             p_cate       VARCHAR2,
                             p_type       NUMBER) RETURN CLOB;
  --未完成订单延期情况统计
  FUNCTION f_unfinished_delay_orders(p_company_id       VARCHAR2,
                                     p_class_data_privs VARCHAR2,
                                     p_cate             VARCHAR2,
                                     p_date_type        VARCHAR2,
                                     p_start_time       DATE,
                                     p_end_time         DATE,
                                     p_fileds_type      VARCHAR2,
                                     p_follower         VARCHAR2,
                                     p_small_cate       VARCHAR2,
                                     p_sup              VARCHAR2) RETURN CLOB;
  --未完成订单生产进度状态分析
  FUNCTION f_unfinished_prostatus_report(p_company_id       VARCHAR2,
                                         p_class_data_privs CLOB,
                                         p_cate             VARCHAR2,
                                         p_date_type        VARCHAR2,
                                         p_start_time       DATE,
                                         p_end_time         DATE,
                                         p_small_cate       VARCHAR2,
                                         p_sup              VARCHAR2)
    RETURN CLOB;
  --获取数据权限sql
  FUNCTION f_get_dataprivs_sql(p_class_data_privs VARCHAR2,
                               p_pre              VARCHAR2 DEFAULT 'tc')
    RETURN CLOB;
END pkg_report_analy;
/
CREATE OR REPLACE PACKAGE BODY pkg_report_analy IS
  --订单满足率-异常分布 a_report_abn_202
  FUNCTION f_get_abn_distribut_report(p_company_id       VARCHAR2,
                                      p_class_data_privs CLOB,
                                      p_abn_year         VARCHAR2,
                                      p_abn_date_type    VARCHAR2,
                                      p_abn_date         VARCHAR2,
                                      p_abn_category     VARCHAR2,
                                      p_abnf_fileds_type VARCHAR2,
                                      p_abn_group        VARCHAR2)
    RETURN CLOB IS
    v_company_id    VARCHAR2(32) := p_company_id;
    v_where         CLOB;
    v_gp_sql        CLOB;
    v_gp_sql_a      CLOB;
    v_sql           CLOB;
    v_union_sql     CLOB;
    v_query_filed   CLOB;
    v_query_filed_a CLOB;
    v_abn_year      VARCHAR2(4) := p_abn_year;
    v_abn_date_type VARCHAR2(32) := p_abn_date_type;
    v_abn_date      VARCHAR2(32) := p_abn_date;
    v_cate          VARCHAR2(32) := p_abn_category;
    v_fileds_type   VARCHAR2(32) := p_abnf_fileds_type;
    v_group         VARCHAR2(256) := p_abn_group;
    v_first_day     DATE;
    v_last_day      DATE;
    v_first         VARCHAR2(2);
    v_last          VARCHAR2(2);
  BEGIN
    v_where := q'[ WHERE t.delivery_status <> '正常' AND t.company_id = ']' ||
               v_company_id || q'[']';
    --数据权限
    v_where := v_where ||
               f_get_dataprivs_sql(p_class_data_privs => p_class_data_privs,
                                   p_pre              => 't');
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
      ELSE
        NULL;
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
    IF (v_cate = '1' AND v_group = '全部') THEN
      v_query_filed := q'[ '全部' group_name, '全部' category_name,]';
      v_gp_sql      := NULL;
      IF v_fileds_type <> '00' THEN
        raise_application_error(-20002,
                                '请至少选择一项分部/区域组进行查询！');
      END IF;
    ELSE
      IF v_cate = '1' AND v_group <> '全部' THEN
        v_query_filed := q'[ v.group_name, '全部' category_name,]';
        v_gp_sql      := ' GROUP BY v.group_name ';
      ELSIF v_cate <> '1' AND v_group = '全部' THEN
        v_query_filed := q'[ '全部' group_name, v.category_name,]';
        v_gp_sql      := ' GROUP BY v.category_name ';
      ELSE
        v_query_filed := q'[ v.group_name, v.category_name,]';
        v_gp_sql      := ' GROUP BY v.group_name, v.category_name ';
      END IF;
      --根据筛选字段进行分组统计
      IF v_fileds_type = '00' THEN
        NULL;
      ELSE
        CASE
          WHEN v_fileds_type = '01' THEN
            v_gp_sql_a      := ',v.product_subclass_name';
            v_query_filed   := v_query_filed ||
                               ' v.product_subclass_name, ';
            v_query_filed_a := v_query_filed_a ||
                               ' null product_subclass_name, ';
          WHEN v_fileds_type = '02' THEN
            v_gp_sql_a      := ',v.supplier_code,v.supplier_company_name';
            v_query_filed   := v_query_filed ||
                               ' v.supplier_code,v.supplier_company_name, ';
            v_query_filed_a := v_query_filed_a ||
                               ' null supplier_code,null supplier_company_name, ';
          WHEN v_fileds_type = '03' THEN
            v_gp_sql_a      := ',v.factory_code,v.factory_company_name';
            v_query_filed   := v_query_filed ||
                               ' v.factory_code,v.factory_company_name, ';
            v_query_filed_a := v_query_filed_a ||
                               ' null supplier_code,null supplier_company_name, ';
          WHEN v_fileds_type = '04' THEN
            v_gp_sql_a      := ',v.qc_name';
            v_query_filed   := v_query_filed || ' v.qc_name, ';
            v_query_filed_a := v_query_filed_a || ' null qc_name, ';
          WHEN v_fileds_type = '05' THEN
            v_gp_sql_a      := ' ,v.flw_order_name ';
            v_query_filed   := v_query_filed || ' v.flw_order_name, ';
            v_query_filed_a := v_query_filed_a || ' null flw_order_name, ';
          WHEN v_fileds_type = '06' THEN
            v_gp_sql_a      := ' ,v.is_first_order ';
            v_query_filed   := v_query_filed || ' v.is_first_order, ';
            v_query_filed_a := v_query_filed_a || ' null is_first_order, ';
          ELSE
            NULL;
        END CASE;
      END IF;
      v_gp_sql := v_gp_sql || v_gp_sql_a;
    END IF;
  
    v_sql := q'[ SELECT ]' || v_query_filed || q'[
       SUM(v.abn_money) / MAX(v.abn_sum_money) abn_sum_propotion,
       SUM(v.abn_money) abn_money,
       SUM(v.order_money) order_money,
       SUM(v.abn_money) / SUM(v.order_money) abn_money_propotion
  FROM (SELECT t.group_name,
               t.category,
               t.category_name,
               t.samll_category,
               t.product_subclass_name,
               t.supplier_code,
               t.supplier_company_name,
               t.factory_code,
               t.factory_company_name,
               t.is_first_order,
               t.flw_order,
               b.company_user_name flw_order_name,
               t.qc,
               a.company_user_name qc_name,
               t.satisfy_money,
               t.order_money,
               t.delivery_date,
               t.company_id,
               t.order_money - t.satisfy_money abn_money,
               SUM(t.order_money - t.satisfy_money) over() abn_sum_money
          FROM scmdata.pt_ordered t
          LEFT JOIN scmdata.sys_company_user a
            ON a.user_id = t.qc
           AND a.company_id = t.company_id
          LEFT JOIN scmdata.sys_company_user b
            ON b.user_id = t.flw_order
           AND b.company_id = t.company_id
           ]' || v_where || q'[) v]' || v_gp_sql;
    --合计
    v_union_sql := 'SELECT * FROM (' || 'SELECT * FROM (' || v_sql ||
                   ') ORDER BY abn_money DESC )' || q'[ UNION ALL SELECT ]' ||
                   v_query_filed_a || q'[
       SUM(abn_money)/SUM(abn_money) abn_sum_propotion,
       SUM(abn_money) abn_money,
       SUM(order_money) order_money,
       SUM(abn_money)/SUM(order_money) abn_money_propotion
  FROM (]' || v_sql || ')';
    RETURN v_union_sql;
  END f_get_abn_distribut_report;
  --获取订单满足率  a_report_abn_201
  --原因分析
  FUNCTION f_get_abn_cause_report(p_company_id         VARCHAR2,
                                  p_class_data_privs   CLOB,
                                  p_abn_year           VARCHAR2,
                                  p_abn_date_type      VARCHAR2,
                                  p_abn_date           VARCHAR2,
                                  p_abn_category       VARCHAR2,
                                  p_abn_group          VARCHAR2,
                                  p_abnc_fileds_type   VARCHAR2,
                                  p_abnc_fileds_type_a VARCHAR2) RETURN CLOB IS
  
    v_abn_year      VARCHAR2(4) := p_abn_year;
    v_abn_date_type VARCHAR2(32) := p_abn_date_type;
    v_abn_date      VARCHAR2(32) := p_abn_date;
    v_cate          VARCHAR2(32) := p_abn_category;
    v_group         VARCHAR2(256) := p_abn_group;
    v_fileds_type   VARCHAR2(32) := p_abnc_fileds_type;
    v_fileds        VARCHAR2(32) := p_abnc_fileds_type_a;
    v_query_filed   CLOB;
    v_query_filed_a CLOB;
    v_company_id    VARCHAR2(32) := p_company_id;
    v_sql           CLOB;
    v_union_sql     CLOB;
    v_gp_sql        CLOB;
    v_gp_sql_a      CLOB;
    v_where         CLOB;
    v_first_day     DATE;
    v_last_day      DATE;
    v_first         VARCHAR2(2);
    v_last          VARCHAR2(2);
  BEGIN
    v_where := q'[ WHERE t.delivery_status <> '正常' AND t.company_id = ']' ||
               v_company_id || q'[']';
    --数据权限
    v_where := v_where ||
               f_get_dataprivs_sql(p_class_data_privs => p_class_data_privs,
                                   p_pre              => 't');
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
            v_query_filed   := v_query_filed ||
                               ' v.product_subclass_name, ';
            v_query_filed_a := v_query_filed_a ||
                               ' null product_subclass_name, ';
            v_where         := v_where ||
                               ' AND t.product_subclass_name = ''' ||
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
            v_where         := v_where || ' AND t.flw_order = ''' ||
                               v_fileds || '''';
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
         SUM(v.abn_money) / MAX(abn_sum_money) abn_sum_propotion,
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
             END) / SUM(v.abn_money) delay_otp,
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
             END) / SUM(v.abn_money) delay_fsp,
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
             END) / SUM(v.abn_money) delay_sp
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
    v_union_sql := 'SELECT * FROM (' || 'SELECT * FROM (' || v_sql ||
                   ') ORDER BY abn_money DESC ) ' ||
                   q'[ UNION ALL SELECT ]' || v_query_filed_a || q'[
       NULL delay_problem_class,
       NULL delay_cause_class,
       NULL delay_cause_detailed,
       NULL is_sup_responsible,
       SUM(abn_money)/SUM(abn_money) abn_sum_propotion,
       SUM(abn_money) abn_money,
       SUM(delay_ot) delay_ot,
       SUM(delay_ot)/ SUM(abn_money) delay_otp,
       SUM(delay_fs) delay_fs,
       SUM(delay_fs)/ SUM(abn_money) delay_fsp,
       SUM(delay_s) delay_s,
       SUM(delay_s)/ SUM(abn_money) delay_sp
  FROM (]' || v_sql || ')';
  
    RETURN v_union_sql;
  
  END f_get_abn_cause_report;
  --异常处理-原因分布
  FUNCTION f_get_abn_distribut(p_begin_date       DATE,
                               p_end_date         DATE,
                               p_cate             VARCHAR2,
                               p_fileds_type      VARCHAR2,
                               p_company_id       VARCHAR2,
                               p_class_data_privs CLOB) RETURN CLOB IS
    v_begin_date    DATE := p_begin_date;
    v_end_date      DATE := p_end_date;
    v_cate          VARCHAR2(32) := p_cate;
    v_fileds_type   VARCHAR2(32) := p_fileds_type;
    v_company_id    VARCHAR2(32) := p_company_id;
    v_sql           CLOB;
    v_where_sql     CLOB;
    v_gp_sql        CLOB;
    v_query_filed   CLOB;
    v_query_filed_a CLOB;
    v_union_sql     CLOB;
  BEGIN
    v_where_sql := q'[ WHERE t.company_id = ']' || v_company_id ||
                   q'[' AND trunc(t.confirm_date) BETWEEN ']' ||
                   v_begin_date || q'[' AND ']' || v_end_date || '''' ||
                   q'[ AND cf.category = ']' || v_cate || '''';
  
    --数据权限
    v_where_sql := v_where_sql ||
                   f_get_dataprivs_sql(p_class_data_privs => p_class_data_privs,
                                       p_pre              => 'cf');
  
    v_query_filed := q'[ category_name]';
    v_gp_sql      := ' GROUP BY gv.category_name';
    CASE
      WHEN v_fileds_type = '01' THEN
        v_gp_sql        := v_gp_sql || ',gv.product_subclass_name';
        v_query_filed_a := ' ''合计'' category_name,NULL product_subclass_name,';
        v_query_filed   := v_query_filed || ',product_subclass_name ';
      WHEN v_fileds_type = '02' THEN
        v_gp_sql        := v_gp_sql ||
                           ',gv.supplier_code,gv.supplier_company_name';
        v_query_filed_a := ' ''合计'' category_name,NULL supplier_code,NULL supplier_company_name,';
        v_query_filed   := v_query_filed ||
                           ',supplier_code,supplier_company_name';
      ELSE
        v_gp_sql := v_gp_sql || ',gv.product_subclass_name';
    END CASE;
  
    v_sql := q'[WITH cmd_info AS
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
     AND gc.company_id = ']' || v_company_id || q'[')
SELECT ]' || v_query_filed || q'[,
       abn_money / SUM(abn_money) over() abn_sum_propotion,
       abn_money,
       decode(amt_price,NULL,0,amt_price) amt_price,
       decode(SUM(amt_price) over(),NULL,0,abn_money / SUM(amt_price) over()) ABN_MONEY_PROPOTION,
       ABN_CNT,
       ABN_ORDER_CNT,
       two_abn_order_cnt,
       two_abn_order_cnt / ABN_ORDER_CNT two_abn_proportion
  FROM (SELECT DISTINCT ]' || v_query_filed || q'[,
                        SUM(abn_money) abn_money,
                        SUM(amt_price) amt_price,
                        COUNT(DISTINCT gv.goo_id) ABN_CNT,
                        COUNT(gv.product_gress_code) ABN_ORDER_CNT,
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
                                SUM(v.abn_money) over(PARTITION BY v.category,]' || CASE
               WHEN v_fileds_type = '01' THEN
                'v.samll_category'
               WHEN v_fileds_type = '02' THEN
                'v.supplier_code'
               ELSE
                'v.samll_category'
             END ||
             q'[, v.product_gress_code) abn_money,
                                SUM(gsv.amt_price) over(PARTITION BY v.category, ]' || CASE
               WHEN v_fileds_type = '01' THEN
                'v.samll_category'
               WHEN v_fileds_type = '02' THEN
                'v.supplier_code'
               ELSE
                'v.samll_category'
             END ||
             q'[, v.product_gress_code) amt_price,
                                v.goo_id,
                                v.product_gress_code,
                                COUNT(v.abnormal_code) over(PARTITION BY v.category, ]' || CASE
               WHEN v_fileds_type = '01' THEN
                'v.samll_category'
               WHEN v_fileds_type = '02' THEN
                'v.supplier_code'
               ELSE
                'v.samll_category'
             END || q'[, v.product_gress_code) two_abn_order_cnt
                  FROM (SELECT cf.category,
                               cf.category_name,
                               cf.samll_category,
                               cf.product_subclass_name,
                               sp.supplier_code,
                               sp.supplier_company_name,
                               nvl(t.delay_amount, pr.order_amount) * cf.price abn_money,
                               cf.goo_id,
                               t.abnormal_code,
                               pr.product_gress_code,
                               t.company_id,
                               trunc(t.confirm_date) confirm_date
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
                         ]' || v_where_sql ||
             q'[) v
                  LEFT JOIN (SELECT gs.amount * tc.price amt_price,
                                   tc.samll_category,
                                   tc.category,
                                   tc.company_id,
                                   trunc(gd.create_time) create_time
                              FROM scmdata.t_ingood gd
                             INNER JOIN scmdata.t_ingoods gs
                                ON gd.ing_id = gs.ing_id
                               AND gd.company_id = gs.company_id
                             INNER JOIN scmdata.t_commodity_info tc
                                ON gs.goo_id = tc.goo_id
                               AND gs.company_id = tc.company_id) gsv
                    ON gsv.samll_category = v.samll_category
                   AND gsv.category = v.category
                   AND gsv.company_id = v.company_id
                   AND gsv.create_time = v.confirm_date) gv ]' ||
             v_gp_sql || q'[) zv]';
  
    v_union_sql := 'SELECT * FROM (' || 'SELECT * FROM (' || v_sql ||
                   ') ORDER BY abn_money DESC ) ' ||
                   q'[ UNION ALL SELECT ]' || v_query_filed_a ||
                   q'[ SUM(abn_money)/SUM(abn_money) abn_sum_propotion,
                   SUM(abn_money) abn_money,
                   decode(SUM(amt_price),0,0,SUM(amt_price)) amt_price,
                   decode(SUM(amt_price),0,0,SUM(abn_money)/SUM(amt_price)) ABN_MONEY_PROPOTION,
                   SUM(ABN_CNT) ABN_CNT,
                   SUM(ABN_ORDER_CNT) ABN_ORDER_CNT,
                   SUM(two_abn_order_cnt) two_abn_order_cnt,
                   SUM(two_abn_order_cnt) / SUM(ABN_ORDER_CNT) two_abn_proportion FROM (]' ||
                   v_sql || ')';
  
    RETURN v_union_sql;
  END f_get_abn_distribut;
  --异常处理 异常原因分析(交叉制表)
  FUNCTION f_get_abn_cause(p_start_date  DATE,
                           p_end_date    DATE,
                           p_cate        VARCHAR2,
                           p_fileds_type VARCHAR2,
                           p_fileds      VARCHAR2,
                           p_company_id  VARCHAR2) RETURN CLOB IS
    --筛选日期
    v_start_date    DATE := p_start_date;
    v_end_date      DATE := p_end_date;
    v_cate          VARCHAR2(32) := p_cate;
    v_fileds_type   VARCHAR2(32) := p_fileds_type;
    v_fileds        VARCHAR2(32) := p_fileds;
    v_company_id    VARCHAR2(32) := p_company_id;
    v_where         CLOB;
    v_gp_sql        CLOB;
    v_query_filed   CLOB;
    v_query_filed_a CLOB;
    v_sql           CLOB;
    v_union_sql     CLOB;
  BEGIN
  
    v_where := q'[ WHERE t.company_id = ']' || v_company_id || q'['
             AND t.progress_status = '02'
             AND t.anomaly_class IN ('AC_QUALITY', 'AC_OTHERS')
             AND tc.category = ']' || v_cate || q'[']' || '
     AND trunc(t.confirm_date) BETWEEN ''' || v_start_date ||
               ''' AND ''' || v_end_date || '''';
  
    v_gp_sql        := q'[GROUP BY v.anomaly_class_name,v.category_name]';
    v_query_filed   := q'[v.anomaly_class_name,v.category_name,]';
    v_query_filed_a := q'['合计' anomaly_class_name,NULL category_name,]';
    IF v_fileds_type = '01' THEN
      IF v_fileds IS NULL THEN
        v_query_filed   := v_query_filed || q'[v.product_subclass_name,]';
        v_gp_sql        := v_gp_sql || ',v.product_subclass_name,';
        v_query_filed_a := v_query_filed_a || 'null product_subclass_name,';
      ELSE
      
        v_query_filed   := v_query_filed || q'[v.product_subclass_name,]';
        v_where         := v_where || q'[ AND c.company_dict_name = ']' ||
                           v_fileds || q'[']';
        v_gp_sql        := v_gp_sql || ',v.product_subclass_name,';
        v_query_filed_a := v_query_filed_a || 'null product_subclass_name,';
      END IF;
    ELSIF v_fileds_type = '02' THEN
      v_query_filed   := v_query_filed ||
                         q'[v.supplier_code,v.supplier_company_name,]';
      v_where         := v_where || q'[ AND pr.supplier_code = ']' ||
                         v_fileds || q'[']';
      v_gp_sql        := v_gp_sql ||
                         ',v.supplier_code,v.supplier_company_name,';
      v_query_filed_a := v_query_filed_a ||
                         'null supplier_code,null supplier_company_name,';
    ELSE
      NULL;
    END IF;
  
    v_gp_sql := v_gp_sql ||
                q'[,v.problem_class,v.cause_class,v.handle_opinions_name]';
  
    v_sql := q'[SELECT ]' || v_query_filed || q'[
         v.problem_class,
         v.cause_class,
         SUM(nvl(v.delay_amount, v.order_amount) * v.price) /
         MAX(abn_sum_money) abn_sum_propotion,
         --SUM(nvl(v.delay_amount, v.order_amount) * v.price) abn_money_a,
         SUM(nvl(v.delay_amount, v.order_amount) * v.price) abn_money,
         v.handle_opinions_name
    FROM (SELECT t.anomaly_class,
                 e.group_dict_name anomaly_class_name,
                 tc.category,
                 a.group_dict_name category_name,
                 tc.samll_category,
                 c.company_dict_name product_subclass_name,
                 pr.supplier_code,
                 sp.supplier_company_name,
                 t.problem_class,
                 t.cause_class,
                 t.delay_amount,
                 pr.order_amount,
                 tc.price,
                 SUM(nvl(t.delay_amount, pr.order_amount) * tc.price) over() abn_sum_money,
                 t.handle_opinions,
                 d.group_dict_name handle_opinions_name
            FROM scmdata.t_abnormal t
           INNER JOIN scmdata.t_commodity_info tc
              ON t.goo_id = tc.goo_id
             AND t.company_id = tc.company_id
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
            LEFT JOIN scmdata.sys_group_dict d
              ON d.group_dict_type = 'HANDLE_RESULT'
             AND d.group_dict_value = t.handle_opinions
            LEFT JOIN scmdata.sys_group_dict e
              ON e.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
             AND e.group_dict_value = t.anomaly_class
           INNER JOIN scmdata.t_production_progress pr
              ON t.goo_id = pr.goo_id
             AND t.order_id = pr.order_id
             AND t.company_id = pr.company_id
            LEFT JOIN scmdata.t_supplier_info sp
              ON pr.supplier_code = sp.supplier_code
             AND pr.company_id = sp.company_id ]' || v_where ||
             q'[) v ]' || v_gp_sql;
  
    v_union_sql := 'SELECT * FROM (' || 'SELECT * FROM (' || v_sql ||
                   ') ORDER BY abn_money DESC ) ' ||
                   q'[ UNION ALL SELECT ]' || v_query_filed_a ||
                   q'[null problem_class,
       null cause_class,
      SUM(abn_money)/SUM(abn_money) abn_sum_propotion,
      --SUM(abn_money_a) abn_money_a,
      SUM(abn_money) abn_money,
      null handle_opinions_name
      FROM (]' || v_sql || ')';
    RETURN v_union_sql;
  END;

  --异常处理 异常原因分析
  FUNCTION f_get_abn_cause_ma(p_start_date       DATE,
                              p_end_date         DATE,
                              p_cate             VARCHAR2,
                              p_fileds_type      VARCHAR2,
                              p_fileds           VARCHAR2,
                              p_company_id       VARCHAR2,
                              p_class_data_privs VARCHAR2) RETURN CLOB IS
    --筛选日期
    v_start_date    DATE := p_start_date;
    v_end_date      DATE := p_end_date;
    v_cate          VARCHAR2(32) := p_cate;
    v_fileds_type   VARCHAR2(32) := p_fileds_type;
    v_fileds        VARCHAR2(32) := p_fileds;
    v_company_id    VARCHAR2(32) := p_company_id;
    v_where         CLOB;
    v_gp_sql        CLOB;
    v_query_filed   CLOB;
    v_query_filed_a CLOB;
    v_sql           CLOB;
    v_union_sql     CLOB;
  BEGIN
    --分部
    v_where := q'[WHERE t.company_id = ']' || v_company_id || q'['
             AND t.progress_status = '02'
             AND t.anomaly_class IN ('AC_QUALITY', 'AC_OTHERS')
             --AND t.problem_class <> ' '
             --AND t.cause_class <> ' '
              ]' || q'[ AND tc.category = ']' || v_cate ||
               q'[' ]' || '
             AND trunc(t.confirm_date) BETWEEN ''' ||
               v_start_date || ''' AND ''' || v_end_date || '''';
    --数据权限
    v_where := v_where ||
               f_get_dataprivs_sql(p_class_data_privs => p_class_data_privs,
                                   p_pre              => 'tc');
  
    v_gp_sql        := q'[GROUP BY v.anomaly_class_name,v.category_name]';
    v_query_filed   := q'[v.anomaly_class_name,v.category_name,]';
    v_query_filed_a := q'['合计' anomaly_class_name,NULL category_name,]';
  
    IF v_fileds_type = '00' THEN
      NULL;
    ELSIF v_fileds_type = '01' THEN
      v_query_filed   := v_query_filed || q'[v.product_subclass_name,]';
      v_where         := v_where || q'[ AND c.company_dict_name = ']' ||
                         v_fileds || q'[']';
      v_gp_sql        := v_gp_sql || ',v.product_subclass_name';
      v_query_filed_a := v_query_filed_a || 'null product_subclass_name,';
    ELSIF v_fileds_type = '02' THEN
      v_query_filed   := v_query_filed ||
                         q'[v.supplier_code,v.supplier_company_name,]';
      v_where         := v_where || q'[ AND pr.supplier_code = ']' ||
                         v_fileds || q'[']';
      v_gp_sql        := v_gp_sql ||
                         ',v.supplier_code,v.supplier_company_name';
      v_query_filed_a := v_query_filed_a ||
                         'null supplier_code,null supplier_company_name,';
    ELSE
      NULL;
    END IF;
    v_query_filed := v_query_filed || 'v.problem_class,v.cause_class,';
    v_gp_sql      := v_gp_sql || q'[,v.problem_class,v.cause_class]';
  
    v_sql       := q'[ SELECT ]' || v_query_filed || q'[
         SUM(v.abn_price) / MAX(abn_sum_price) abn_sum_propotion,
         SUM(v.abn_price) abn_money,
         SUM(CASE
               WHEN v.handle_opinions = '03' THEN
                v.abn_price
               ELSE
                0
             END) qxorders,
         SUM(CASE
               WHEN v.handle_opinions = '05' THEN
                v.abn_price
               ELSE
                0
             END) jsreceipt,
         SUM(CASE
               WHEN v.handle_opinions = '04' THEN
                v.abn_price
               ELSE
                0
             END) dxreceipt,
         SUM(CASE
               WHEN v.handle_opinions = '01' THEN
                v.abn_price
               ELSE
                0
             END) kkreceipt,
         SUM(CASE
               WHEN v.handle_opinions = '09' THEN
                v.abn_price
               ELSE
                0
             END) yzjgreceipt,
         SUM(CASE
               WHEN v.handle_opinions = '08' THEN
                v.abn_price
               ELSE
                0
             END) jgreceipt,
         SUM(CASE
               WHEN v.handle_opinions = '10' THEN
                v.abn_price
               ELSE
                0
             END) dbreceipt,
         SUM(CASE
               WHEN v.handle_opinions = '06' THEN
                v.abn_price
               ELSE
                0
             END) fgreceipt,
         SUM(CASE
               WHEN v.handle_opinions = '02' THEN
                v.abn_price
               ELSE
                0
             END) rbreceipt,
         SUM(CASE
               WHEN v.handle_opinions = '07' THEN
                v.abn_price
               ELSE
                0
             END) jlreceipt
    FROM (SELECT DISTINCT t.anomaly_class,
                          d.group_dict_name anomaly_class_name,
                          tc.category,
                          a.group_dict_name category_name,
                          tc.samll_category,
                          c.company_dict_name product_subclass_name,
                          pr.supplier_code,
                          sp.supplier_company_name,
                          t.problem_class,
                          t.cause_class,
                          nvl(t.delay_amount, pr.order_amount) * tc.price abn_price,
                          t.handle_opinions,
                          tc.goo_id,
                          SUM(nvl(t.delay_amount, pr.order_amount) * tc.price) over() abn_sum_price
            FROM scmdata.t_abnormal t
           INNER JOIN scmdata.t_commodity_info tc
              ON t.goo_id = tc.goo_id
             AND t.company_id = tc.company_id
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
            LEFT JOIN scmdata.sys_group_dict d
              ON d.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT'
             AND d.group_dict_value = t.anomaly_class
           INNER JOIN scmdata.t_production_progress pr
              ON t.goo_id = pr.goo_id
             AND t.order_id = pr.order_id
             AND t.company_id = pr.company_id
            LEFT JOIN scmdata.t_supplier_info sp
              ON pr.supplier_code = sp.supplier_code
             AND pr.company_id = sp.company_id ]' ||
                   v_where || q'[) v ]' || v_gp_sql;
    v_union_sql := 'SELECT * FROM (' || 'SELECT * FROM (' || v_sql ||
                   ') ORDER BY abn_money DESC ) ' ||
                   q'[ UNION ALL SELECT ]' || v_query_filed_a ||
                   q'[null problem_class,
         null cause_class,
         SUM(abn_money)/SUM(abn_money) abn_sum_propotion,
         SUM(abn_money) abn_money,
         SUM(qxorders) qxorders,
         SUM(jsreceipt) jsreceipt,
         SUM(dxreceipt) dxreceipt,
         SUM(kkreceipt) kkreceipt,
         SUM(yzjgreceipt) yzjgreceipt,
         SUM(jgreceipt) jgreceipt,
         SUM(dbreceipt) dbreceipt,
         SUM(fgreceipt) fgreceipt,
         SUM(rbreceipt) rbreceipt,
         SUM(jlreceipt) jlreceipt
      FROM (]' || v_sql || ')';
    RETURN v_union_sql;
  END f_get_abn_cause_ma;
  --可结束生产进度表
  FUNCTION f_finished_orders(p_company_id       VARCHAR2,
                             p_class_data_privs CLOB) RETURN CLOB IS
    v_sql       CLOB;
    v_union_sql CLOB;
    v_where     CLOB;
  BEGIN
    v_where := q'[WHERE po.company_id = ']' || p_company_id ||
               q'[' AND po.finish_time IS NOT NULL
                   AND po.order_status <> 'OS02' ]';
    --数据权限
    v_where := v_where ||
               f_get_dataprivs_sql(p_class_data_privs => p_class_data_privs,
                                   p_pre              => 'tc');
  
    v_sql := q'[SELECT category,category_name,
       abn_order_cnt_nl,
       abn_order_cnt_n,
       nm_order_cnt,
       cate_order_cnt
  FROM (SELECT ga.group_dict_value category,
               ga.group_dict_name category_name,
               nvl2(v.abn_order_cnt_nl, v.abn_order_cnt_nl, 0) abn_order_cnt_nl,
               nvl2(v.abn_order_cnt, v.abn_order_cnt, 0) abn_order_cnt_n,
               v.cate_order_cnt,
               v.cate_order_cnt - (v.abn_order_cnt_nl +
               nvl2(v.abn_order_cnt, v.abn_order_cnt, 0)) nm_order_cnt
          FROM (SELECT tc.category,
                       SUM(CASE
                             WHEN (pr.actual_delay_day > 0 OR
                                  (pr.actual_delay_day = 0 AND
                                  trunc(SYSDATE) - trunc(po.delivery_date) >= 0 AND
                                  (pr.delivery_amount / pr.order_amount) <= CASE
                                    WHEN tc.category = '07' THEN
                                     0.86
                                    WHEN tc.category = '06' THEN
                                     0.92
                                    ELSE
                                     0.80
                                  END)) AND pr.delay_problem_class IS NULL THEN
                              1
                             ELSE
                              NULL
                           END) abn_order_cnt_nl,
                       SUM(CASE
                             WHEN (pr.actual_delay_day > 0 OR
                                  (pr.actual_delay_day = 0 AND
                                  trunc(SYSDATE) - trunc(po.delivery_date) > 0 AND
                                  (pr.delivery_amount / pr.order_amount) <= CASE
                                    WHEN tc.category = '07' THEN
                                     0.86
                                    WHEN tc.category = '06' THEN
                                     0.92
                                    ELSE
                                     0.80
                                  END)) AND pr.delay_problem_class IS NOT NULL THEN
                              1
                             ELSE
                              NULL
                           END) abn_order_cnt,
                       COUNT(po.order_id) cate_order_cnt
                  FROM scmdata.t_ordered po
                 INNER JOIN scmdata.t_orders ln
                    ON ln.order_id = po.order_code
                   AND ln.company_id = po.company_id
                 INNER JOIN scmdata.t_production_progress pr
                    ON pr.goo_id = ln.goo_id
                   AND pr.order_id = ln.order_id
                   AND pr.company_id = ln.company_id
                 INNER JOIN scmdata.t_commodity_info tc
                    ON pr.goo_id = tc.goo_id
                   AND pr.company_id = tc.company_id ]' ||
             v_where ||
             q'[ GROUP BY tc.category ORDER BY tc.category ASC) v
         INNER JOIN scmdata.sys_group_dict ga
            ON ga.group_dict_value = v.category
           AND ga.group_dict_type = 'PRODUCT_TYPE')]';
  
    v_union_sql := v_sql ||
                   q'[ UNION ALL SELECT '1' category,'合计' category_name,
       sum(abn_order_cnt_nl) abn_order_cnt_nl,
       sum(abn_order_cnt_n) abn_order_cnt_n,
       sum(nm_order_cnt) nm_order_cnt,
       sum(cate_order_cnt) cate_order_cnt FROM (]' ||
                   v_sql || q'[)]';
    RETURN v_union_sql;
  END f_finished_orders;
  --动态获取订单列表
  FUNCTION f_get_orders_list(p_company_id VARCHAR2,
                             p_cate       VARCHAR2,
                             p_type       NUMBER) RETURN CLOB IS
    v_cate    VARCHAR2(32) := p_cate;
    v_type    NUMBER := p_type;
    v_sql     CLOB;
    v_where   CLOB;
    v_where_a CLOB;
    v_prom    NUMBER;
  BEGIN
    IF v_cate = '1' THEN
      v_where   := q'[ AND 1 = 1 ]';
      v_where_a := q'[WHERE (v.actual_delay_day > 0 OR (v.actual_delay_day = 0 AND v.check_days >= 0 AND v.check_prom <= CASE WHEN
              v.category = '07' THEN 0.86 WHEN v.category = '06' THEN 0.92 ELSE 0.80 END))]';
    ELSE
      v_prom := CASE
                  WHEN v_cate = '06' THEN
                   0.92
                  WHEN v_cate = '07' THEN
                   0.86
                  ELSE
                   0.80
                END;
    
      v_where := q'[ AND tc.category = ']' || v_cate || '''';
    
      v_where_a := q'[WHERE (v.actual_delay_day > 0 OR
         (v.actual_delay_day = 0 AND v.check_days >= 0 AND
         v.check_prom <= ]' || v_prom || q'[))]';
    END IF;
  
    IF v_type = 0 THEN
      v_where := v_where || ' AND pr.delay_problem_class IS NULL';
    ELSIF v_type = 1 THEN
      v_where := v_where || ' AND pr.delay_problem_class IS NOT NULL';
    ELSIF v_type = 2 THEN
      v_where_a := q'[WHERE v.actual_delay_day = 0 AND (v.check_prom >= CASE WHEN v.category = '07' THEN 0.86 WHEN v.category = '06' THEN 0.92 ELSE 0.80 END)]';
    ELSE
      v_where_a := NULL;
    END IF;
  
    v_sql := q'[SELECT v.finish_time FINISH_TIME_PANDA,
         v.deal_follower,
         v.product_gress_code product_gress_code_pr,
         v.rela_goo_id,
         v.style_number style_number_pr,
         v.supplier_company_abbreviation SUPPLIER_COMPANY_NAME_PR,
         v.delivery_date delivery_date_pr,
         --v.actual_delivery_date actual_delivery_date_pr,
         v.actual_delay_day actual_delay_day_pr,
         v.order_amount order_amount_pr,
         --v.delivery_amount delivery_amount_pr,
         --v.owe_amount owe_amount_pr,
         v.delay_problem_class delay_problem_class_pr,
         v.delay_cause_class delay_cause_class_pr,
         v.delay_cause_detailed delay_cause_detailed_pr,
         v.problem_desc problem_desc_pr,
         v.category,
         --v.product_cate,
         v.samll_category,
         v.check_days,
         v.check_prom
    FROM (SELECT po.finish_time,
                 (SELECT listagg(fu.company_user_name, ';') within GROUP(ORDER BY po.deal_follower)
                    FROM scmdata.sys_company_user fu
                   WHERE instr(po.deal_follower, fu.user_id) > 0
                     AND fu.company_id = po.company_id) deal_follower,
                 pr.product_gress_code,
                 tc.rela_goo_id,
                 tc.style_number,
                 sp.supplier_company_abbreviation ,
                 po.delivery_date,
                 pr.actual_delivery_date,
                 pr.actual_delay_day,
                 pr.order_amount,
                 pr.delivery_amount,
                 decode(sign(pr.order_amount - pr.delivery_amount),
                        -1,
                        0,
                        pr.order_amount - pr.delivery_amount) owe_amount,
                 pr.delay_problem_class,
                 pr.delay_cause_class,
                 pr.delay_cause_detailed,
                 pr.problem_desc,
                 a.group_dict_name category,
                 b.group_dict_name product_cate,
                 c.company_dict_name samll_category,
                 trunc(SYSDATE) - trunc(po.delivery_date) check_days,
                 pr.delivery_amount / pr.order_amount check_prom
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
            INNER JOIN scmdata.sys_group_dict a
              ON a.group_dict_type = 'PRODUCT_TYPE'
             AND a.group_dict_value = tc.category
            INNER JOIN scmdata.sys_group_dict b
              ON b.group_dict_type = a.group_dict_value
             AND b.group_dict_value = tc.product_cate
            INNER JOIN scmdata.sys_company_dict c
              ON c.company_dict_type = b.group_dict_value
             AND c.company_dict_value = tc.samll_category
             AND c.company_id = tc.company_id
           WHERE po.company_id = ']' || p_company_id || q'['
             AND po.order_status <> 'OS02'
             AND po.finish_time IS NOT NULL
             ]' || v_where || q'[) v ]' || v_where_a;
    RETURN v_sql;
  END f_get_orders_list;
  --未完成订单延期情况统计
  FUNCTION f_unfinished_delay_orders(p_company_id       VARCHAR2,
                                     p_class_data_privs VARCHAR2,
                                     p_cate             VARCHAR2,
                                     p_date_type        VARCHAR2,
                                     p_start_time       DATE,
                                     p_end_time         DATE,
                                     p_fileds_type      VARCHAR2,
                                     p_follower         VARCHAR2,
                                     p_small_cate       VARCHAR2,
                                     p_sup              VARCHAR2) RETURN CLOB IS
    v_sql           CLOB;
    v_group_sql     CLOB;
    v_query_filed   CLOB;
    v_query_filed_a CLOB;
    v_where         CLOB;
    v_date_type     VARCHAR2(32) := p_date_type;
    v_start_time    DATE := p_start_time;
    v_end_time      DATE := p_end_time;
    v_fileds_type   VARCHAR2(32) := p_fileds_type;
    v_union_sql     CLOB;
  BEGIN
    v_where := q'[WHERE po.company_id = ']' || p_company_id || q'['
                       AND po.order_status <> 'OS02' AND tc.category = ']' ||
               p_cate || q'[']';
    --数据权限
    v_where := v_where ||
               f_get_dataprivs_sql(p_class_data_privs => p_class_data_privs);
  
    --筛选条件   
    IF v_fileds_type = '00' THEN
      v_group_sql     := q'[GROUP BY v.category_name,v.deal_follower_name]';
      v_query_filed   := q'[category_name,deal_follower_name]';
      v_query_filed_a := q'['合计' category_name,null deal_follower_name]';
    ELSIF v_fileds_type = '01' THEN
    
      v_group_sql     := q'[GROUP BY v.category_name,v.product_subclass_name]';
      v_query_filed   := q'[category_name,product_subclass_name]';
      v_query_filed_a := q'['合计' category_name,null product_subclass_name]';
    ELSIF v_fileds_type = '02' THEN
    
      v_group_sql     := q'[GROUP BY v.category_name,v.supplier_code,v.supplier_company_name]';
      v_query_filed   := q'[category_name,supplier_code,supplier_company_name]';
      v_query_filed_a := q'['合计' category_name,null supplier_code,null supplier_company_name]';
    ELSE
      NULL;
    END IF;
    --过滤条件
    v_where := v_where || CASE
                 WHEN p_follower = '1' THEN
                  ' AND 1 = 1'
                 ELSE
                  q'[ AND instr(po.deal_follower,']' || p_follower ||
                  q'[') > 0]'
               END;
    v_where := v_where || CASE
                 WHEN p_small_cate = '1' THEN
                  ' AND 1 = 1'
                 ELSE
                  q'[ AND c.company_dict_name = ']' || p_small_cate || q'[']'
               END;
    v_where := v_where || CASE
                 WHEN p_sup = '1' THEN
                  ' AND 1 = 1'
                 ELSE
                  q'[ AND sp.supplier_code = ']' || p_sup || q'[']'
               END;
    --时间维度 
    v_where := v_where || CASE
                 WHEN v_date_type = '00' THEN
                  ' AND 1 = 1 '
                 WHEN v_date_type = '01' THEN
                  ' AND trunc(po.create_time) BETWEEN ''' || v_start_time ||
                  ''' AND ''' || v_end_time || ''''
                 WHEN v_date_type = '02' THEN
                  ' AND trunc(po.delivery_date) BETWEEN ''' || v_start_time ||
                  ''' AND ''' || v_end_time || ''''
                 WHEN v_date_type = '03' THEN
                  ' AND trunc(pr.latest_planned_delivery_date) BETWEEN ''' ||
                  v_start_time || ''' AND ''' || v_end_time || ''''
                 ELSE
                  NULL
               END;
  
    --未完成订单延期情况统计
    v_sql := q'[ SELECT ]' || v_query_filed || q'[,
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
      FROM (SELECT ]' || v_query_filed ||
             q'[,  COUNT(DISTINCT v.goo_id) owe_goo_cnt,
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
                           po.create_time order_date,
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
                       AND c.company_id = tc.company_id ]' ||
             v_where || q'[) v ]' || v_group_sql || q'[) gv]';
  
    v_union_sql := 'SELECT * FROM (' || 'SELECT * FROM (' || v_sql ||
                   ') ORDER BY owe_price DESC ) ' ||
                   q'[ UNION ALL SELECT ]' || v_query_filed_a ||
                   q'[,SUM(owe_goo_cnt) owe_goo_cnt,
                      SUM(owe_amount) owe_amount, 
                      SUM(owe_price) owe_price,  
                      SUM(act_owe_goo_cnt) act_owe_goo_cnt,  
                      SUM(act_owe_amount) act_owe_amount,    
                      SUM(act_owe_price) act_owe_price,  
                      SUM(act_owe_price)/SUM(owe_price) act_owe_price_prom,  
                      SUM(pre_owe_goo_cnt) pre_owe_goo_cnt,   
                      SUM(pre_owe_amount) pre_owe_amount, 
                      SUM(pre_owe_price) pre_owe_price, 
                      SUM(pre_owe_price)/SUM(owe_price) pre_owe_price_prom        
      FROM (]' || v_sql || ')';
    RETURN v_union_sql;
  END f_unfinished_delay_orders;

  --新增分部生产节点顺序配置
  PROCEDURE p_insert_product_node_sqcfg(p_company_id VARCHAR2,
                                        p_cate       VARCHAR2,
                                        p_num        NUMBER,
                                        p_node_name  VARCHAR2,
                                        p_user_id    VARCHAR2) IS
  BEGIN
    INSERT INTO t_product_status_seq t
    VALUES
      (scmdata.f_get_uuid(),
       p_company_id,
       p_cate,
       p_num,
       p_node_name,
       p_user_id,
       SYSDATE,
       p_user_id,
       SYSDATE);
  END p_insert_product_node_sqcfg;
  --修改分部生产节点顺序配置
  PROCEDURE p_update_product_node_sqcfg(p_seq_id    VARCHAR2,
                                        p_num       NUMBER,
                                        p_node_name VARCHAR2,
                                        p_user_id   VARCHAR2) IS
  BEGIN
    UPDATE t_product_status_seq t
       SET t.node_num    = p_num,
           t.node_name   = p_node_name,
           t.update_id   = p_user_id,
           t.update_time = SYSDATE
     WHERE t.seq_id = p_seq_id;
  END p_update_product_node_sqcfg;
  --未完成订单生产进度状态分析
  FUNCTION f_unfinished_prostatus_report(p_company_id       VARCHAR2,
                                         p_class_data_privs CLOB,
                                         p_cate             VARCHAR2,
                                         p_date_type        VARCHAR2,
                                         p_start_time       DATE,
                                         p_end_time         DATE,
                                         p_small_cate       VARCHAR2,
                                         p_sup              VARCHAR2)
    RETURN CLOB IS
    v_sql        CLOB;
    v_company_id VARCHAR2(32) := p_company_id;
    v_cate       VARCHAR2(32) := p_cate;
    v_where      CLOB;
    v_date_type  VARCHAR2(32) := p_date_type;
    v_start_time DATE := p_start_time;
    v_end_time   DATE := p_end_time;
    v_union_sql  CLOB;
  BEGIN
    v_where := q'[ WHERE po.company_id = ']' || v_company_id || q'['
                     AND po.order_status <> 'OS02'
                     AND tc.category = ']' || v_cate ||
               q'[' ]';
    --数据权限
    v_where := v_where ||
               f_get_dataprivs_sql(p_class_data_privs => p_class_data_privs);
  
    --过滤条件
    v_where := v_where || CASE
                 WHEN p_small_cate = '1' THEN
                  ' AND 1 = 1'
                 ELSE
                  q'[ AND c.company_dict_name = ']' || p_small_cate || q'[']'
               END;
    v_where := v_where || CASE
                 WHEN p_sup = '1' THEN
                  ' AND 1 = 1'
                 ELSE
                  q'[ AND sp.supplier_code = ']' || p_sup || q'[']'
               END;
    --时间维度 
    v_where := v_where || CASE
                 WHEN v_date_type = '00' THEN
                  ' AND 1 = 1 '
                 WHEN v_date_type = '01' THEN
                  ' AND trunc(po.create_time) BETWEEN ''' || v_start_time ||
                  ''' AND ''' || v_end_time || ''''
                 WHEN v_date_type = '02' THEN
                  ' AND trunc(po.delivery_date) BETWEEN ''' || v_start_time ||
                  ''' AND ''' || v_end_time || ''''
                 WHEN v_date_type = '03' THEN
                  ' AND trunc(pr.latest_planned_delivery_date) BETWEEN ''' ||
                  v_start_time || ''' AND ''' || v_end_time || ''''
                 ELSE
                  NULL
               END;
    --未完成订单生产进度状态分析
    v_sql := q'[SELECT * FROM (SELECT gv.*,sq.node_num
    FROM (SELECT DISTINCT v.category,
                          v.category_name,
                          v.deal_follower_name,
                          COUNT(DISTINCT v.goo_id) over(PARTITION BY v.category_name, v.deal_follower_name) owe_goo_cnt,
                          SUM(owe_amount) over(PARTITION BY v.category_name, v.deal_follower_name) owe_amount,
                          COUNT(CASE
                                  WHEN v.finish_time IS NOT NULL AND
                                       v.finish_time_scm IS NULL THEN
                                   v.order_code
                                  ELSE
                                   NULL
                                END) over(PARTITION BY v.category_name, v.deal_follower_name) pd_finish_cnt,
                          v.progress_status_desc,
                          COUNT(v.order_code) over(PARTITION BY v.category_name, v.deal_follower_name, v.progress_status_desc) pst_cnt
            FROM (SELECT po.order_code,
                         tc.category,
                         a.group_dict_name category_name,
                         (SELECT listagg(fu.company_user_name, ';')
                            FROM scmdata.sys_company_user fu
                           WHERE instr(po.deal_follower, fu.user_id) > 0
                             AND fu.company_id = po.company_id) deal_follower_name,
                         c.company_dict_name product_subclass_name,
                         sp.supplier_code,
                         sp.supplier_company_name,
                         pr.goo_id,
                         decode(sign(pr.order_amount - pr.delivery_amount),
                                -1,
                                0,
                                pr.order_amount - pr.delivery_amount) owe_amount,
                         decode(pr.progress_status,
                                '02',
                                pno.pno_status,
                                '00',
                                gd_b.group_dict_name) progress_status_desc,
                         po.finish_time,
                         po.finish_time_scm,
                         pno.node_num
                    FROM scmdata.t_ordered po
                   INNER JOIN scmdata.t_orders ln
                      ON ln.order_id = po.order_code
                     AND ln.company_id = po.company_id
                   INNER JOIN scmdata.t_production_progress pr
                      ON pr.goo_id = ln.goo_id
                     AND pr.order_id = ln.order_id
                     AND pr.company_id = ln.company_id
                    LEFT JOIN (SELECT pno_status, product_gress_id, node_num
                                FROM (SELECT row_number() over(PARTITION BY pn.product_gress_id ORDER BY pn.node_num DESC) rn,
                                             pn.node_name ||
                                             gd_a.group_dict_name pno_status,
                                             pn.product_gress_id,
                                             pn.node_num
                                        FROM scmdata.t_production_node pn
                                       INNER JOIN scmdata.sys_group_dict gd_a
                                          ON gd_a.group_dict_type =
                                             'PROGRESS_NODE_TYPE'
                                         AND gd_a.group_dict_value =
                                             pn.progress_status
                                       WHERE pn.company_id =
                                             'a972dd1ffe3b3a10e0533c281cac8fd7'
                                         AND pn.progress_status IS NOT NULL)
                               WHERE rn = 1) pno
                      ON pno.product_gress_id = pr.product_gress_id
                    LEFT JOIN scmdata.sys_group_dict gd_b
                      ON gd_b.group_dict_type = 'PROGRESS_TYPE'
                     AND gd_b.group_dict_value = pr.progress_status
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
                     AND c.company_id = tc.company_id ]' ||
             v_where || q'[ ) v) gv
    LEFT JOIN scmdata.t_product_status_seq sq
      ON sq.category = gv.category
     AND sq.node_name = gv.progress_status_desc)]';
  
    dbms_output.put_line(v_sql);
  
    v_union_sql := 'SELECT * FROM (SELECT * FROM (' || 'SELECT * FROM (' ||
                   v_sql || ') ORDER BY owe_amount DESC) ' || q'[ UNION ALL SELECT DISTINCT NULL category,
                                       '合计' category_name,
                                       NULL deal_follower_name,
                                       NULL owe_goo_cnt,
                                       NULL owe_amount,
                                       NULL pd_finish_cnt,
                                       progress_status_desc,
                                       SUM(pst_cnt) over(partition by  uv.category_name, uv.progress_status_desc) pst_cnt,
                                       node_num
      FROM (]' || v_sql || ')uv) ORDER BY node_num ASC';
    RETURN v_union_sql;
  END f_unfinished_prostatus_report;

  --获取数据权限sql
  FUNCTION f_get_dataprivs_sql(p_class_data_privs VARCHAR2,
                               p_pre              VARCHAR2 DEFAULT 'tc')
    RETURN CLOB IS
  BEGIN
    RETURN q'[ AND ((%is_company_admin%) = 1 OR instr_priv(p_str1 => ']' || p_class_data_privs || q'[', p_str2 => ]' || p_pre || q'[.category, p_split => ';') > 0) ]';
  END f_get_dataprivs_sql;
END pkg_report_analy;
/
