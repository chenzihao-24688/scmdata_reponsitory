CREATE OR REPLACE PACKAGE pkg_production_progress_a IS

  -- Author  : SANFU
  -- Created : 2021/7/26 14:23:50
  -- Purpose : 处理生产进度跟进单相关逻辑
  --订单自动结束功能
  --生产跟进模块-优化与运维 / 美妆、淘品订单自动结束功能
  PROCEDURE auto_end_orders(p_company_id VARCHAR2 DEFAULT 'a972dd1ffe3b3a10e0533c281cac8fd7');

END pkg_production_progress_a;
/
CREATE OR REPLACE PACKAGE BODY pkg_production_progress_a IS
  --订单自动结束功能
  --生产跟进模块-优化与运维 / 美妆、淘品订单自动结束功能
  PROCEDURE auto_end_orders(p_company_id VARCHAR2 DEFAULT 'a972dd1ffe3b3a10e0533c281cac8fd7') IS
    p_sql             CLOB;
    v_count           NUMBER;
    v_abn_status      NUMBER;
    v_abn_status_tol  NUMBER;
    v_order_rate_flag NUMBER;
    v_delay_day       NUMBER;
    v_end_time_c      NUMBER;
    v_total_c         NUMBER;
  BEGIN
    --订单分类为：美妆、淘品自动结束规则，需同时满足以下所有条件：
    --1. 熊猫系统-订单明细-结束时间不为空；
    --2. 结束时间减去交货日期（订单初始交期）＜3；
    FOR order_rec IN (SELECT po.company_id,
                             po.order_code,
                             pr.product_gress_id,
                             pr.progress_status,
                             pr.goo_id,
                             pr.order_amount,
                             cf.category,
                             cf.product_cate,
                             cf.samll_category,
                             po.delivery_date,
                             po.finish_time
                        FROM scmdata.t_ordered po
                       INNER JOIN scmdata.t_orders ln
                          ON po.company_id = ln.company_id
                         AND po.order_code = ln.order_id
                         AND po.order_status <> 'OS02'
                         AND po.finish_time IS NOT NULL
                         AND trunc(po.finish_time) + 5 < trunc(SYSDATE)
                         AND trunc(po.finish_time) - trunc(po.delivery_date) < 3
                       INNER JOIN scmdata.t_production_progress pr
                          ON ln.company_id = pr.company_id
                         AND ln.order_id = pr.order_id
                         AND ln.goo_id = pr.goo_id
                         AND pr.progress_status <> '01'
                       INNER JOIN scmdata.t_commodity_info cf
                          ON cf.company_id = pr.company_id
                         AND cf.goo_id = pr.goo_id
                         AND cf.category IN ('06', '07')
                       WHERE po.company_id = p_company_id) LOOP
      --3. 订单不需要QC查货：订单“分类-生产类别-产品子类”没有在’业务配置中心-QC查货配置‘，则判定为不需要QC查货；   
      p_sql := q'[SELECT COUNT(1)
                  FROM scmdata.t_qc_config qc
               WHERE qc.company_id = :company_id
                 AND qc.industry_classification = :production_category
                 AND qc.production_category = :industry_classification
                 AND instr(';' || qc.product_subclass || ';',
                           ';' || :product_subclass || ';') > 0
                 AND pause = 0]';
      EXECUTE IMMEDIATE p_sql
        INTO v_count
        USING p_company_id, order_rec.category, order_rec.product_cate, order_rec.samll_category;
    
      IF v_count = 0 THEN
        --4. 订单没有异常单，或没有在处理中的异常单：在’异常处理列表-待处理'不存在订单的异常处理单；        
        --结束生产订单，必须所有异常处理单全部处理完才能结束
        p_sql := q'[SELECT NVL(SUM(decode(abn.progress_status, '02', 1, 0)),0), COUNT(*)           
            FROM scmdata.t_abnormal abn
              WHERE abn.company_id = :a
             AND abn.order_id = :b
             AND abn.goo_id = :c]';
      
        EXECUTE IMMEDIATE p_sql
          INTO v_abn_status, v_abn_status_tol
          USING p_company_id, order_rec.order_code, order_rec.goo_id;
      
        IF v_abn_status = v_abn_status_tol THEN
          --最新的交货记录  
          --5.订单交货记录：必须所有记录都有到仓时间；
          --取交货记录最新记录计算：到仓确认时间最晚记录，且收货量不为空的数据；
          --如果到仓确认时间最晚那一条数据没有收货量，则按顺序取次晚数据，依次类推；
          p_sql := 'SELECT CASE :category
                 WHEN :category THEN
                  (CASE
                    WHEN order_rate > :order_rate THEN
                     1
                    ELSE
                     0
                  END)
                 ELSE
                  0
               END order_rate_flag,
               dd_day,
               end_time_c,
               total_c
          FROM (SELECT SUM(dr.delivery_amount) / :order_amount order_rate,
                       trunc(MAX(dr.delivery_date)) - :delivery_date dd_day,
                       SUM(CASE WHEN dr.delivery_date IS NULL THEN 0 ELSE 1 END) end_time_c,
                       COUNT(1) total_c
                  FROM scmdata.t_delivery_record dr
                 WHERE dr.company_id = :company_id
                   AND dr.order_code = :order_code
                   AND dr.goo_id = :goo_id
                   AND dr.delivery_amount is not null)';
        
          IF order_rec.category = '06' THEN
            EXECUTE IMMEDIATE p_sql
              INTO v_order_rate_flag, v_delay_day, v_end_time_c, v_total_c
              USING '06', '06', 0.92, order_rec.order_amount, trunc(order_rec.delivery_date), p_company_id, order_rec.order_code, order_rec.goo_id;
          ELSIF order_rec.category = '07' THEN
            EXECUTE IMMEDIATE p_sql
              INTO v_order_rate_flag, v_delay_day, v_end_time_c, v_total_c
              USING '07', '07', 0.86, order_rec.order_amount, trunc(order_rec.delivery_date), p_company_id, order_rec.order_code, order_rec.goo_id;
          ELSE
            CONTINUE;
          END IF;
          --6.到仓确认时间-交货日期（订单初始交期）< 2天;
          --7.淘品07：到货量（交货记录-收货量总和）/订货量（订单数量）＞86%；
          --  美妆06：到货量（交货记录-收货量总和）/订货量（订单数量）＞92%；
          IF v_end_time_c = v_total_c THEN
            IF v_order_rate_flag = 1 AND v_delay_day < 2 THEN
              scmdata.pkg_production_progress.finish_production_progress(p_product_gress_id => order_rec.product_gress_id,
                                                                         p_status           => '01',
                                                                         p_is_check         => 0);
            ELSE
              CONTINUE;
            END IF;
          ELSE
            CONTINUE;
          END IF;
        ELSE
          CONTINUE;
        END IF;
      ELSE
        CONTINUE;
      END IF;
    
    END LOOP;
  
  END auto_end_orders;

END pkg_production_progress_a;
/
