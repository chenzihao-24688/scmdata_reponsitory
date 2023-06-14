CREATE OR REPLACE PACKAGE pkg_production_progress_a IS

  -- Author  : SANFU
  -- Created : 2021/7/26 14:23:50
  -- Purpose : 处理生产进度跟进单相关逻辑
  --订单自动结束功能

  --所有分部非生产订单增加自动结束订单
  PROCEDURE p_auto_end_all_orders(p_company_id VARCHAR2);
  --生产跟进模块-优化与运维 / 美妆、淘品订单自动结束功能
  PROCEDURE p_auto_end_mt_orders(p_company_id VARCHAR2);
  --美妆、淘品自动赋值延期原因
  PROCEDURE p_auto_mt_delay_problem(p_company_id VARCHAR2);
  --生产进度更新时校验
  PROCEDURE p_check_updprogress(p_item_id               VARCHAR2 DEFAULT NULL,
                                p_company_id            VARCHAR2,
                                p_goo_id                VARCHAR2,
                                p_delay_problem_class   VARCHAR2,
                                p_delay_cause_class     VARCHAR2,
                                p_delay_cause_detailed  VARCHAR2,
                                p_problem_desc          VARCHAR2,
                                p_responsible_dept_sec  VARCHAR2,
                                p_progress_status       VARCHAR2 DEFAULT NULL,
                                p_curlink_complet_ratio NUMBER,
                                p_order_rise_status     VARCHAR2,
                                p_progress_update_date  DATE DEFAULT NULL,
                                po_is_sup_exemption     OUT VARCHAR2,
                                po_first_dept_id        OUT VARCHAR2,
                                po_second_dept_id       OUT VARCHAR2,
                                po_is_quality           OUT VARCHAR2,
                                po_dept_name            OUT VARCHAR2);
  --获取延期天数
  FUNCTION f_get_delay_day(p_company_id    VARCHAR2,
                           p_order_code    VARCHAR2,
                           p_goo_id        VARCHAR2,
                           p_delivery_date DATE) RETURN INT;

  --是否满足各分部未延期订单满足率
  PROCEDURE p_is_order_rate(p_company_id       VARCHAR2,
                            p_order_code       VARCHAR2,
                            p_goo_id           VARCHAR2,
                            p_cate             VARCHAR2,
                            p_delivery_date    DATE,
                            p_order_amount     NUMBER,
                            po_order_rate_flag OUT INT,
                            po_end_time_c      OUT INT,
                            po_total_c         OUT INT);

  --新增T_PROGRESS_LOG
  PROCEDURE p_insert_t_progress_log(p_product_gress_id   VARCHAR2,
                                    p_company_id         VARCHAR2,
                                    p_log_type           VARCHAR2,
                                    p_log_msg            VARCHAR2,
                                    p_operater           VARCHAR2,
                                    p_operate_company_id VARCHAR2,
                                    p_create_id          VARCHAR2,
                                    p_update_id          VARCHAR2,
                                    p_memo               VARCHAR2);
  --获取进度状态
  FUNCTION f_get_progress_status(p_status_code VARCHAR2,
                                 p_company_id  VARCHAR2) RETURN VARCHAR2;
  --获取生产跟进操作内容
  PROCEDURE p_get_progress_log_msg(p_old_filed VARCHAR2,
                                   p_new_filed VARCHAR2,
                                   p_title     VARCHAR2,
                                   p_split     CHAR,
                                   p_status    INT,
                                   p_log_msg   CLOB DEFAULT NULL,
                                   p_up_cnt    INT DEFAULT 0,
                                   po_up_cnt   OUT INT,
                                   po_log_msg  OUT CLOB);
  --预测交期
  PROCEDURE p_forecast_delivery_date(p_progress_id          VARCHAR2,
                                     p_company_id           VARCHAR2,
                                     p_is_product           INT DEFAULT 1,
                                     p_latest_delivery_date DATE DEFAULT NULL,
                                     p_progress_status      VARCHAR2 DEFAULT NULL,
                                     p_progress_update_date DATE DEFAULT NULL,
                                     p_plan_date            DATE,
                                     p_delivery_date        DATE,
                                     p_curlink_complet_prom NUMBER DEFAULT NULL,
                                     po_forecast_date       OUT DATE,
                                     po_forecast_days       OUT INT);
  --批量复制进度
  PROCEDURE p_batch_copy_progress(p_company_id           VARCHAR2,
                                  p_inproduct_gress_code VARCHAR2,
                                  p_ndproduct_gress_code VARCHAR2,
                                  p_item_id              VARCHAR2,
                                  p_user_id              VARCHAR2);
END pkg_production_progress_a;
/
CREATE OR REPLACE PACKAGE BODY pkg_production_progress_a IS

  /*============================================*
  * Author   : CZH
  * Created  : 2022-06-16 09:37:40
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  自动结束非生产订单
  *             所有分部非生产订单增加自动结束订单功能，规则如下：
  *             1）当订单熊猫结束时间不为空，不延期（不延期指交货记录ASN到仓确定日期≤订单交期）的交货数量≥男装/女装/鞋包80%、内衣88%、淘品86%、美妆92%，无需赋值延期原因，直接结束订单；
  *             2）熊猫结束时间+3天＜当前日期；
  *             20220608 clj  需求变更：自动结束订单不延期比例变更              
  *             1) 生产订单：美妆、淘品不延期的交货数量，变更为≥94%;
  *             2) 非生产订单：不延期的交货数量，变更美妆、淘品为≥94%，男装、女装、内衣、鞋包≥100%。
  * Obj_Name    : P_AUTO_END_ALL_ORDERS
  * Arg_Number  : 1
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  *============================================*/

  PROCEDURE p_auto_end_all_orders(p_company_id VARCHAR2) IS
    v_order_rate_flag NUMBER;
    v_end_time_c      NUMBER;
    v_total_c         NUMBER;
  BEGIN
    FOR order_rec IN (SELECT po.company_id,
                             po.order_code,
                             pr.goo_id,
                             po.delivery_date,
                             pr.product_gress_id,
                             cf.category,
                             pr.order_amount
                        FROM scmdata.t_ordered po
                       INNER JOIN scmdata.t_orders ln
                          ON po.company_id = ln.company_id
                         AND po.order_code = ln.order_id
                         AND po.order_status <> 'OS02'
                         AND po.is_product_order = 0
                         AND po.finish_time IS NOT NULL
                         AND trunc(po.finish_time) + 3 < trunc(SYSDATE)
                       INNER JOIN scmdata.t_production_progress pr
                          ON ln.company_id = pr.company_id
                         AND ln.order_id = pr.order_id
                         AND ln.goo_id = pr.goo_id
                         AND pr.progress_status <> '01'
                       INNER JOIN scmdata.t_commodity_info cf
                          ON cf.company_id = pr.company_id
                         AND cf.goo_id = pr.goo_id
                       WHERE po.company_id = p_company_id) LOOP
    
      --是否不延期（不延期指交货记录ASN到仓确定日期≤订单交期）且满足各分部未延期订单满足率
      p_is_order_rate(p_company_id       => p_company_id,
                      p_order_code       => order_rec.order_code,
                      p_goo_id           => order_rec.goo_id,
                      p_cate             => order_rec.category,
                      p_delivery_date    => trunc(order_rec.delivery_date),
                      p_order_amount     => order_rec.order_amount,
                      po_order_rate_flag => v_order_rate_flag,
                      po_end_time_c      => v_end_time_c,
                      po_total_c         => v_total_c);
    
      --如果交货记录 存在到仓日期为空则不处理 
      IF v_end_time_c = v_total_c THEN
        IF v_order_rate_flag = 1 THEN
          --结束订单
          scmdata.pkg_production_progress.finish_production_progress(p_product_gress_id => order_rec.product_gress_id,
                                                                     p_status           => '01',
                                                                     p_is_check         => 0,
                                                                     p_finish_type      => '01');
        ELSE
          CONTINUE;
        END IF;
      ELSE
        CONTINUE;
      END IF;
    END LOOP;
  END p_auto_end_all_orders;
  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-18 10:09:27
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  订单自动结束功能（美妆、淘品）
  * 美妆、淘品自动结束订单区分是否生产订单，生产订单自动结束订单规则如下（非生产订单见所有分部非生产订单结束规则）：
  * 1）当订单熊猫结束时间不为空，不延期（不延期指交货记录ASN到仓确定日期≤订单交期）的交货数量≥淘品86%、美妆92%，无需赋值延期原因，直接结束订单；
  * 2）结束时间减去交货日期（订单初始交期）＜3；
  * 3）订单不需要QC查货：订单“分类-生产类别-产品子类”没有在’业务配置中心-QC查货配置‘，则判定为不需要QC查货；
  * 4）订单没有异常单，或没有在处理中的异常单：在’异常处理列表-待处理‘不存在订单的异常处理单；
  * Obj_Name    : AUTO_END_ORDERS
  * Arg_Number  : 1
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  *============================================*/

  PROCEDURE p_auto_end_mt_orders(p_company_id VARCHAR2) IS
    p_sql             CLOB;
    v_count           NUMBER;
    v_abn_status      NUMBER;
    v_abn_status_tol  NUMBER;
    v_order_rate_flag NUMBER;
    v_end_time_c      NUMBER;
    v_total_c         NUMBER;
  BEGIN
    --订单分类为：美妆、淘品自动结束规则，需同时满足以下所有条件：
    --1. 熊猫系统-订单明细-结束时间不为空；
    --2. 结束时间减去交货日期（订单初始交期）＜3；210916 新需求：舍弃该条件  
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
                         AND po.is_product_order = 1 --生产订单
                         AND po.finish_time IS NOT NULL
                         AND trunc(po.finish_time) + 3 < trunc(SYSDATE) --1.熊猫结束时间+5天小于当前日期  2.20220523 熊猫结束时间+3天小于当前日期 
                      --AND trunc(po.finish_time) - trunc(po.delivery_date) < 3 --1.210916 新需求：舍弃该条件 
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
          --5.当订单熊猫结束时间不为空，不延期（不延期指交货记录ASN到仓确定日期≤订单交期）的交货数量≥淘品86%、美妆92%，无需赋值延期原因，直接结束订单；
          --新增逻辑：排除交货记录ASN收货量=0  
          --是否不延期（不延期指交货记录ASN到仓确定日期≤订单交期）且满足各分部未延期订单满足率        
          p_is_order_rate(p_company_id       => p_company_id,
                          p_order_code       => order_rec.order_code,
                          p_goo_id           => order_rec.goo_id,
                          p_cate             => order_rec.category,
                          p_delivery_date    => trunc(order_rec.delivery_date),
                          p_order_amount     => order_rec.order_amount,
                          po_order_rate_flag => v_order_rate_flag,
                          po_end_time_c      => v_end_time_c,
                          po_total_c         => v_total_c);
        
          --如果交货记录 存在到仓日期为空则不处理 
          IF v_end_time_c = v_total_c THEN
            --7.淘品07：到货量（交货记录-收货量总和）/订货量（订单数量）＞=86%；
            --  美妆06：到货量（交货记录-收货量总和）/订货量（订单数量）＞=92%；
            IF v_order_rate_flag = 1 THEN
              scmdata.pkg_production_progress.finish_production_progress(p_product_gress_id => order_rec.product_gress_id,
                                                                         p_status           => '01',
                                                                         p_is_check         => 0,
                                                                         p_finish_type      => '01');
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
  
  END p_auto_end_mt_orders;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-06-16 09:40:58
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  美妆、淘品自动赋值延期原因
  *             1）当订单满足：熊猫结束时间+1天≤当前日期，且最晚到仓确认时间-交货日期（订单初始交期）=1天的订单自动赋值延期原因
  *             ①如果没有填写延期原因，需自动赋值延期问题分类、延期原因分类、延期原因细分、供应商是否免责、责任部门1级、责任部门2级、是否质责量问题。延期问题分类、延期原因分类、延期原因细分为下图示；供应商是否免责、责任部门1级、责任部门2级、是否质量问题则根据订单适用范围以及延期问题分类、延期原因分类、延期原因找到对应异常处理配置模板对应的值。
  *             问题描述赋值为：其他；
  *             ②如果已填写延期原因，则不需要自动赋值，以填写的内容为准；
  *             ③赋值需记录到从表[跟进日志] ，操作方为三福，操作人为系统管理员，操作时间为赋值时间；
  * Obj_Name    : P_AUTO_MT_DELAY_PROBLEM
  * Arg_Number  : 1
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  *============================================*/

  PROCEDURE p_auto_mt_delay_problem(p_company_id VARCHAR2) IS
    v_is_sup_exemption NUMBER;
    v_first_dept_id    VARCHAR2(100);
    v_second_dept_id   VARCHAR2(100);
    v_is_quality       NUMBER;
    v_delay_day        INT;
  BEGIN
    FOR order_rec IN (SELECT po.company_id,
                             po.order_code,
                             pr.goo_id,
                             po.delivery_date,
                             pr.product_gress_id
                        FROM scmdata.t_ordered po
                       INNER JOIN scmdata.t_orders ln
                          ON po.company_id = ln.company_id
                         AND po.order_code = ln.order_id
                         AND po.order_status <> 'OS02'
                         AND po.finish_time IS NOT NULL
                         AND trunc(po.finish_time) + 1 <= trunc(SYSDATE)
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
      --获取延期天数
      v_delay_day := f_get_delay_day(p_company_id    => p_company_id,
                                     p_order_code    => order_rec.order_code,
                                     p_goo_id        => order_rec.goo_id,
                                     p_delivery_date => order_rec.delivery_date);
      --如果延期天数等于1天的订单自动赋值延期原因
      IF v_delay_day = 1 THEN
        SELECT MAX(ad.is_sup_exemption),
               MAX(ad.first_dept_id),
               MAX(ad.second_dept_id),
               MAX(ad.is_quality_problem)
          INTO v_is_sup_exemption,
               v_first_dept_id,
               v_second_dept_id,
               v_is_quality
          FROM scmdata.t_commodity_info tc
         INNER JOIN scmdata.t_abnormal_range_config ar
            ON tc.company_id = ar.company_id
           AND tc.category = ar.industry_classification
           AND tc.product_cate = ar.production_category
           AND instr(';' || ar.product_subclass || ';',
                     ';' || tc.samll_category || ';') > 0
           AND ar.pause = 0
         INNER JOIN scmdata.t_abnormal_dtl_config ad
            ON ar.company_id = ad.company_id
           AND ar.abnormal_config_id = ad.abnormal_config_id
           AND ad.pause = 0
         INNER JOIN scmdata.t_abnormal_config ab
            ON ab.company_id = ad.company_id
           AND ab.abnormal_config_id = ad.abnormal_config_id
           AND ab.pause = 0
         WHERE tc.company_id = order_rec.company_id
           AND tc.goo_id = order_rec.goo_id
           AND ad.anomaly_classification = 'AC_DATE'
           AND ad.problem_classification = '其他问题'
           AND ad.cause_classification = '其他问题影响'
           AND ad.cause_detail = '其他';
      
        UPDATE scmdata.t_production_progress a
           SET a.delay_problem_class  = '其他问题',
               a.delay_cause_class    = '其他问题影响',
               a.delay_cause_detailed = '其他',
               a.problem_desc         = nvl(a.problem_desc, '其他'),
               a.is_sup_responsible   = v_is_sup_exemption,
               a.responsible_dept     = v_first_dept_id,
               a.responsible_dept_sec = v_second_dept_id,
               a.is_quality           = v_is_quality,
               a.update_id            = 'ADMIN',
               a.update_time          = SYSDATE,
               a.update_company_id    = p_company_id
         WHERE a.product_gress_id = order_rec.product_gress_id
           AND (nvl2(a.delay_problem_class, 1, 0) +
               nvl2(a.delay_cause_class, 1, 0) +
               nvl2(a.delay_cause_detailed, 1, 0)) <> 3;
      ELSE
        CONTINUE;
      END IF;
    END LOOP;
  END p_auto_mt_delay_problem;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-06-16 09:42:11
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  获取延期天数
  * Obj_Name    : F_GET_DELAY_DAY
  * Arg_Number  : 4
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  * P_ORDER_CODE : 订单编号
  * P_GOO_ID : 货号
  * P_DELIVERY_DATE : 订单交期
  * < OUT PARAMS > 
  * RETURN INT : 延期天数
  *============================================*/

  FUNCTION f_get_delay_day(p_company_id    VARCHAR2,
                           p_order_code    VARCHAR2,
                           p_goo_id        VARCHAR2,
                           p_delivery_date DATE) RETURN INT IS
    v_delay_day INT;
  BEGIN
    --最晚到仓确认时间-交货日期（订单初始交期）
    SELECT trunc(MAX(dr.delivery_date)) - trunc(p_delivery_date) dd_day
      INTO v_delay_day
      FROM scmdata.t_delivery_record dr
     WHERE dr.company_id = p_company_id
       AND dr.order_code = p_order_code
       AND dr.goo_id = p_goo_id
       AND dr.delivery_amount IS NOT NULL
       AND dr.delivery_amount <> 0;
    RETURN v_delay_day;
  END f_get_delay_day;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-06-16 09:42:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  判断是否满足各分部未延期订单满足率
  * Obj_Name    : P_IS_ORDER_RATE
  * Arg_Number  : 9
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  * P_ORDER_CODE : 订单编号
  * P_GOO_ID : 货号
  * P_CATE : 分类
  * P_DELIVERY_DATE : 订单交期
  * P_ORDER_AMOUNT : 订单数量 
  * < OUT PARAMS >  
  * PO_ORDER_RATE_FLAG : 是否满足各分部未延期订单满足率 1：是 0：否
  * PO_END_TIME_C : 统计交货记录 到仓时间不为空数的总和
  * PO_TOTAL_C : 统计全部交货记录
  *============================================*/

  PROCEDURE p_is_order_rate(p_company_id       VARCHAR2,
                            p_order_code       VARCHAR2,
                            p_goo_id           VARCHAR2,
                            p_cate             VARCHAR2,
                            p_delivery_date    DATE,
                            p_order_amount     NUMBER,
                            po_order_rate_flag OUT INT,
                            po_end_time_c      OUT INT,
                            po_total_c         OUT INT) IS
    v_sql             CLOB;
    v_order_rate_flag INT;
    v_end_time_c      INT;
    v_total_c         INT;
    v_rate            NUMBER;
  BEGIN
    v_sql := 'SELECT CASE :category
                 WHEN :category THEN
                  (CASE
                    WHEN order_rate >= :order_rate THEN
                     1
                    ELSE
                     0
                  END)
                 ELSE
                  0
               END order_rate_flag,
               end_time_c,
               total_c
          FROM (SELECT SUM(dr.delivery_amount) / :order_amount order_rate,
                       SUM(CASE WHEN dr.delivery_date IS NULL THEN 0 ELSE 1 END) end_time_c,
                       COUNT(1) total_c
                  FROM scmdata.t_delivery_record dr
                 WHERE dr.company_id = :company_id
                   AND dr.order_code = :order_code
                   AND dr.goo_id = :goo_id
                   AND dr.delivery_amount is not null
                   AND dr.delivery_amount <> 0
                   AND trunc(dr.delivery_date) <= :delivery_date)';
    --20220608 clj  需求变更：自动结束订单不延期比例变更              
    --1、生产订单：美妆、淘品不延期的交货数量，变更为≥94%;
    --2、非生产订单：不延期的交货数量，变更美妆、淘品为≥94%，男装、女装、内衣、鞋包≥100%。
    IF p_cate = '06' THEN
      --v_rate := 0.92;
      v_rate := 0.94;
    ELSIF p_cate = '07' THEN
      --v_rate := 0.86;
      v_rate := 0.94;
    ELSIF p_cate = '03' THEN
      --v_rate := 0.88;
      v_rate := 1;
    ELSE
      --v_rate := 0.80;
      v_rate := 1;
    END IF;
  
    EXECUTE IMMEDIATE v_sql
      INTO v_order_rate_flag, v_end_time_c, v_total_c
      USING p_cate, p_cate, v_rate, p_order_amount, p_company_id, p_order_code, p_goo_id, trunc(p_delivery_date);
  
    po_order_rate_flag := v_order_rate_flag;
    po_end_time_c      := v_end_time_c;
    po_total_c         := v_total_c;
  END p_is_order_rate;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-06-16 09:46:42
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 生产进度更新时校验
  *            供采购方，供应商端的生产订单，非生产订单使用
  * Obj_Name    : P_CHECK_UPDPROGRESS
  * Arg_Number  : 17
  * < IN PARAMS >  
  * P_ITEM_ID : ITEM_ID （选填） 默认为空
  * P_COMPANY_ID : 企业ID
  * P_GOO_ID : 货号
  * P_DELAY_PROBLEM_CLASS : 延期问题分类
  * P_DELAY_CAUSE_CLASS : 延期原因分类
  * P_DELAY_CAUSE_DETAILED : 延期原因细分
  * P_PROBLEM_DESC : 问题描述
  * P_RESPONSIBLE_DEPT_SEC : 责任部门二级
  * P_PROGRESS_STATUS : 生产进度状态（选填） 默认为空
  * P_CURLINK_COMPLET_RATIO : 当前环节完成比例
  * P_ORDER_RISE_STATUS :   订单风险状态
  * P_PROGRESS_UPDATE_DATE : 进度更新日期
  * < OUT PARAMS > 
  * PO_IS_SUP_EXEMPTION : 是否供应商免责
  * PO_FIRST_DEPT_ID : 责任部门一级
  * PO_SECOND_DEPT_ID :责任部门二级
  * PO_IS_QUALITY : 是否质量问题
  * PO_DEPT_NAME :  责任部门二级名称
  *============================================*/

  PROCEDURE p_check_updprogress(p_item_id               VARCHAR2 DEFAULT NULL,
                                p_company_id            VARCHAR2,
                                p_goo_id                VARCHAR2,
                                p_delay_problem_class   VARCHAR2,
                                p_delay_cause_class     VARCHAR2,
                                p_delay_cause_detailed  VARCHAR2,
                                p_problem_desc          VARCHAR2,
                                p_responsible_dept_sec  VARCHAR2,
                                p_progress_status       VARCHAR2 DEFAULT NULL,
                                p_curlink_complet_ratio NUMBER,
                                p_order_rise_status     VARCHAR2,
                                p_progress_update_date  DATE DEFAULT NULL,
                                po_is_sup_exemption     OUT VARCHAR2,
                                po_first_dept_id        OUT VARCHAR2,
                                po_second_dept_id       OUT VARCHAR2,
                                po_is_quality           OUT VARCHAR2,
                                po_dept_name            OUT VARCHAR2) IS
    v_is_sup_exemption NUMBER;
    v_first_dept_id    VARCHAR2(100);
    v_second_dept_id   VARCHAR2(100);
    v_is_quality       NUMBER;
    v_flag             NUMBER;
    v_dept_name        VARCHAR2(100);
  BEGIN
    --20220414 zxp 下单生产进度表：从熊猫接入过来的订单变更延期原因开放可修改
    --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
    IF p_delay_problem_class IS NOT NULL AND
       p_delay_cause_class IS NOT NULL AND
       p_delay_cause_detailed IS NOT NULL THEN
      IF p_problem_desc IS NULL THEN
        raise_application_error(-20002,
                                '提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！');
      ELSE
        IF p_item_id IN ('a_product_110',
                         'a_product_150',
                         'a_product_210',
                         'a_product_217') THEN
          IF p_responsible_dept_sec IS NULL THEN
            raise_application_error(-20002,
                                    '保存失败！延期原因已填写，责任部门(2)级不能为空，请检查。');
          ELSE
            SELECT MAX(ad.is_sup_exemption) is_sup_exemption,
                   MAX(ad.first_dept_id) first_dept_name,
                   MAX(ad.second_dept_id) second_dept_name,
                   MAX(ad.is_quality_problem) is_quality_problem
              INTO v_is_sup_exemption,
                   v_first_dept_id,
                   v_second_dept_id,
                   v_is_quality
              FROM scmdata.t_commodity_info tc
             INNER JOIN scmdata.t_abnormal_range_config ar
                ON tc.company_id = ar.company_id
               AND tc.category = ar.industry_classification
               AND tc.product_cate = ar.production_category
               AND instr(';' || ar.product_subclass || ';',
                         ';' || tc.samll_category || ';') > 0
               AND ar.pause = 0
             INNER JOIN scmdata.t_abnormal_dtl_config ad
                ON ar.company_id = ad.company_id
               AND ar.abnormal_config_id = ad.abnormal_config_id
               AND ad.pause = 0
             INNER JOIN scmdata.t_abnormal_config ab
                ON ab.company_id = ad.company_id
               AND ab.abnormal_config_id = ad.abnormal_config_id
               AND ab.pause = 0
             WHERE tc.company_id = p_company_id
               AND tc.goo_id = p_goo_id
               AND ad.anomaly_classification = 'AC_DATE'
               AND ad.problem_classification = p_delay_problem_class
               AND ad.cause_classification = p_delay_cause_class
               AND ad.cause_detail = p_delay_cause_detailed;
          
            IF p_item_id NOT IN ('a_product_210', 'a_product_217') THEN
              SELECT t.dept_name
                INTO v_dept_name
                FROM scmdata.sys_company_dept t
               WHERE t.company_dept_id =
                     nvl(p_responsible_dept_sec, v_second_dept_id);
              IF v_dept_name <> '无' THEN
                SELECT COUNT(1)
                  INTO v_flag
                  FROM (SELECT t.company_dept_id
                          FROM scmdata.sys_company_dept t
                         START WITH t.company_dept_id = v_first_dept_id
                        CONNECT BY PRIOR t.company_dept_id = t.parent_id)
                 WHERE company_dept_id =
                       nvl(p_responsible_dept_sec, v_second_dept_id);
                IF v_flag = 0 THEN
                  raise_application_error(-20002,
                                          '保存失败！责任部门(2级)必须为责任部门(1级)的下级部门，请检查！');
                END IF;
              ELSE
                NULL;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    ELSE
      IF p_item_id IN ('a_product_110', 'a_product_150') THEN
        IF p_responsible_dept_sec IS NOT NULL THEN
          raise_application_error(-20002,
                                  '保存失败！责任部门(2级)不为空时,延期问题分类、延期原因分类、延期原因细分必填！');
        ELSE
          NULL;
        END IF;
      END IF;
    END IF;
    IF p_item_id IN ('a_product_110', 'a_product_150', 'a_product_210') THEN
      IF p_item_id <> 'a_product_150' THEN
        IF p_progress_status IS NULL THEN
          raise_application_error(-20002,
                                  '保存失败！”生产进度状态“不可为空，请检查！');
        ELSE
          IF p_progress_status NOT IN ('00', '02') AND
             p_curlink_complet_ratio IS NULL THEN
            raise_application_error(-20002,
                                    '保存失败！”生产进度状态“有值，则“当前环节完成比例”为必填，请检查！');
          END IF;
        END IF;
      END IF;
      IF p_order_rise_status IS NULL THEN
        raise_application_error(-20002,
                                '保存失败！订单风险状态必填，请检查！');
      END IF;
    
      IF p_curlink_complet_ratio IS NOT NULL THEN
        IF p_curlink_complet_ratio >= 0 AND p_curlink_complet_ratio <= 100 THEN
          NULL;
        ELSE
          raise_application_error(-20002,
                                  '保存失败！当前环节完成比例取值区间为0~100，请检查！');
        END IF;
        IF p_progress_update_date IS NULL THEN
          raise_application_error(-20002,
                                  '保存失败！“当前环节完成比例”不为空时，进度更新日期必填，请检查！');
        ELSE
          IF p_item_id <> 'a_product_150' THEN
            IF trunc(p_progress_update_date) > trunc(SYSDATE) THEN
              raise_application_error(-20002,
                                      '保存失败！“进度更新日期”不可大于当前日期，请检查！');
            END IF;
          END IF;
        END IF;
      ELSE
        NULL;
      END IF;
    END IF;
    po_is_sup_exemption := v_is_sup_exemption;
    po_first_dept_id    := v_first_dept_id;
    po_second_dept_id   := v_second_dept_id;
    po_is_quality       := v_is_quality;
    po_dept_name        := v_dept_name;
  
  END p_check_updprogress;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-17 09:43:45
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增生产跟进日志
  * Obj_Name    : P_INSERT_T_PROGRESS_LOG
  * Arg_Number  : 9
  * < IN PARAMS >  
  * P_PRODUCT_GRESS_ID : 生产进度表主键ID
  * P_COMPANY_ID : 企业ID
  * P_LOG_TYPE : 操作类型
  * P_LOG_MSG : 操作内容
  * P_OPERATER : 操作方
  * P_OPERATE_COMPANY_ID : 操作方企业ID
  * P_CREATE_ID : 创建人
  * P_UPDATE_ID : 修改人
  * P_MEMO : 备注
  *============================================*/

  PROCEDURE p_insert_t_progress_log(p_product_gress_id   VARCHAR2,
                                    p_company_id         VARCHAR2,
                                    p_log_type           VARCHAR2,
                                    p_log_msg            VARCHAR2,
                                    p_operater           VARCHAR2,
                                    p_operate_company_id VARCHAR2,
                                    p_create_id          VARCHAR2,
                                    p_update_id          VARCHAR2,
                                    p_memo               VARCHAR2) IS
  BEGIN
    INSERT INTO t_progress_log
      (log_id,
       product_gress_id,
       company_id,
       log_type,
       log_msg,
       operater,
       operate_company_id,
       create_id,
       create_time,
       update_id,
       update_time,
       memo)
    VALUES
      (scmdata.f_get_uuid(),
       p_product_gress_id,
       p_company_id,
       p_log_type,
       p_log_msg,
       p_operater,
       p_operate_company_id,
       p_create_id,
       SYSDATE,
       p_update_id,
       SYSDATE,
       p_memo);
  END p_insert_t_progress_log;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-17 14:01:53
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 获取进度状态
  * Obj_Name    : F_GET_PROGRESS_STATUS
  * Arg_Number  : 2
  * < IN PARAMS >  
  * P_STATUS_CODE : 进度编码
  * P_COMPANY_ID : 企业ID
  *============================================*/

  FUNCTION f_get_progress_status(p_status_code VARCHAR2,
                                 p_company_id  VARCHAR2) RETURN VARCHAR2 IS
    v_status VARCHAR2(256);
  BEGIN
    SELECT MAX(v.progress_node_desc)
      INTO v_status
      FROM (SELECT a.group_dict_value progress_node_name,
                   a.group_dict_name  progress_node_desc
              FROM scmdata.sys_group_dict a
             WHERE a.group_dict_type = 'PROGRESS_TYPE'
               AND a.group_dict_value <> '02'
            UNION ALL
            SELECT c.company_dict_value progress_node_name,
                   c.company_dict_name  progress_node_desc
              FROM scmdata.sys_group_dict a
             INNER JOIN scmdata.sys_company_dict b
                ON b.company_dict_type = a.group_dict_value
             INNER JOIN scmdata.sys_company_dict c
                ON c.company_dict_type = b.company_dict_value
               AND c.company_id = b.company_id
             WHERE a.group_dict_type = 'PROGRESS_TYPE'
               AND a.group_dict_value = '02'
               AND b.company_id = p_company_id) v
     WHERE v.progress_node_name = p_status_code;
    RETURN v_status;
  END f_get_progress_status;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-05-18 10:10:03
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 获取生产跟进操作内容 （因设计通用平台日志，舍弃此逻辑）
  *           供 trigger（trg_af_u_t_production_progress） 调用 
  * Obj_Name    : P_GET_PROGRESS_LOG_MSG
  * Arg_Number  : 10
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  * P_OLD_FILED : 旧值
  * P_NEW_FILED : 新值
  * P_TITLE : 提示标题
  * P_SPLIT : 多个操作内容间的分隔符
  * P_STATUS : 根据不同状态调用不同字段取值逻辑
  *            0 :生产进度状态 1：其他通用字段获取 2：订单风险状态
  * P_LOG_MSG : 操作内容，递归传递操作内容拼接
  * P_UP_CNT : 统计统一时间修改字段，递归传递统计值
  * < OUT PARAMS >  
  * PO_UP_CNT : 统一时间修改字段 计数
  * PO_LOG_MSG : 操作内容
  *============================================*/

  PROCEDURE p_get_progress_log_msg(p_old_filed VARCHAR2,
                                   p_new_filed VARCHAR2,
                                   p_title     VARCHAR2,
                                   p_split     CHAR,
                                   p_status    INT,
                                   p_log_msg   CLOB DEFAULT NULL,
                                   p_up_cnt    INT DEFAULT 0,
                                   po_up_cnt   OUT INT,
                                   po_log_msg  OUT CLOB) IS
    v_up_count INT := p_up_cnt; --统计统一时间修改字段
    v_log_msg  CLOB := p_log_msg;
  BEGIN
    IF p_status = 1 THEN
      IF (p_new_filed IS NULL AND p_old_filed IS NOT NULL) OR
         (p_new_filed IS NOT NULL AND p_old_filed IS NULL) OR
         (p_new_filed <> p_old_filed) THEN
        v_up_count := p_up_cnt + 1;
        IF v_up_count > 1 THEN
          v_log_msg := p_log_msg || chr(10) || v_up_count || '.' || p_title ||
                       p_new_filed || p_split;
        ELSE
          v_log_msg := v_up_count || '.' || p_title || p_new_filed ||
                       p_split;
        END IF;
      END IF;
    ELSE
      raise_application_error(-20002,
                              '生产跟进日志记录报错了，请联系管理员！');
    END IF;
    po_up_cnt  := v_up_count;
    po_log_msg := v_log_msg;
  END p_get_progress_log_msg;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-06-16 09:52:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  预测交期
  *（1） 订单生产状态为空、计划到仓日期为空时，预测延误天数为空，预测交期为空；
  *（2） 计划到仓日期不为空时，预测延误天数=计划到仓日期-订单交期，预测交期=计划到仓日期；
  *（3） 计划到仓日期为空、生产进度状态不为空时，按以下逻辑计算
  * ①  预测交期计算规则
  *     订单周期 =（订单交期-下单日期）
  *     剩余需用时天数= 订单周期 *（订单剩余环节用时占比总和+当前环节用时占比*（1-当前环节完成比例）
  *     预测交期=剩余环节需用时天数+进度更新日期
  * ②  预测延误天数=预测交期-订单交期
  * 6.13 clj 补充非生产订单预测延误天数计算规则：
  * 1） 计划到仓日期不为空时，预测延误天数=计划到仓日期-订单交期，预测交期=计划到仓日期；
  * 2） 计划到仓日期为空时，预测延误天数=最新计划交期-订单交期，预测交期=最新计划交期；
  * Obj_Name    : P_FORECAST_DELIVERY_DATE
  * Arg_Number  : 11
  * < IN PARAMS >  
  * P_PROGRESS_ID : 生产进度编号
  * P_COMPANY_ID : 企业ID
  * P_IS_PRODUCT ：是否生产订单 默认为1：是生产订单，0：否
  * P_LATEST_DELIVERY_DATE ：最新计划交期 （选填）默认为空 ，非生产订单使用
  * P_PROGRESS_STATUS : 生产进度状态 （选填）默认为空 ，生产订单使用
  * P_PROGRESS_UPDATE_DATE : 进度更新日期（选填）默认为空 ，生产订单使用
  * P_PLAN_DATE : 计划交期
  * P_DELIVERY_DATE : 订单交期
  * P_CURLINK_COMPLET_PROM : 当前环节完成比例 (选填) 默认为空 ，生产订单使用
  * < OUT PARAMS > 
  * PO_FORECAST_DATE : 预测交期
  * PO_FORECAST_DAYS : 预测延误天数
  *============================================*/

  PROCEDURE p_forecast_delivery_date(p_progress_id          VARCHAR2,
                                     p_company_id           VARCHAR2,
                                     p_is_product           INT DEFAULT 1,
                                     p_latest_delivery_date DATE DEFAULT NULL,
                                     p_progress_status      VARCHAR2 DEFAULT NULL,
                                     p_progress_update_date DATE DEFAULT NULL,
                                     p_plan_date            DATE,
                                     p_delivery_date        DATE,
                                     p_curlink_complet_prom NUMBER DEFAULT NULL,
                                     po_forecast_date       OUT DATE,
                                     po_forecast_days       OUT INT) IS
    vo_forecast_date     DATE;
    vo_forecast_days     INT;
    v_cycle              INT;
    v_order_date         DATE;
    v_total_time_rt      NUMBER;
    v_current_time_rt    NUMBER;
    v_left_link_timeprom NUMBER;
    v_left_days          INT;
    v_cate               VARCHAR2(256);
    v_pcate              VARCHAR2(256);
    v_scate              VARCHAR2(4000);
  BEGIN
    SELECT tc.category, tc.product_cate, tc.samll_category
      INTO v_cate, v_pcate, v_scate
      FROM scmdata.t_production_progress t
     INNER JOIN scmdata.t_commodity_info tc
        ON tc.goo_id = t.goo_id
       AND tc.company_id = t.company_id
     WHERE t.product_gress_id = p_progress_id
       AND t.company_id = p_company_id;
    --生产订单
    IF p_is_product = 1 THEN
      IF p_progress_status IS NULL AND p_plan_date IS NULL THEN
        vo_forecast_date := NULL;
        vo_forecast_days := NULL;
      ELSIF p_plan_date IS NOT NULL THEN
        vo_forecast_date := p_plan_date;
        vo_forecast_days := p_plan_date - p_delivery_date;
      ELSIF p_plan_date IS NULL AND p_delivery_date IS NOT NULL THEN
        --获取下单日期
        SELECT MAX(b.create_time) order_date
          INTO v_order_date
          FROM scmdata.t_production_progress t
         INNER JOIN scmdata.t_orders a
            ON a.goo_id = t.goo_id
           AND a.order_id = t.order_id
           AND a.company_id = t.company_id
         INNER JOIN scmdata.t_ordered b
            ON b.order_code = a.order_id
           AND b.company_id = a.company_id
         WHERE t.product_gress_id = p_progress_id
           AND t.company_id = p_company_id;
        --订单周期
        v_cycle := trunc(p_delivery_date) - trunc(v_order_date);
        --订单剩余环节用时占比总和
        --剩余需用时天数= 订单周期 *（订单剩余环节用时占比总和+当前环节用时占比*（1-当前环节完成比例）)               
        SELECT SUM(b.time_ratio) / 100
          INTO v_total_time_rt
          FROM scmdata.t_progress_range_config c
         INNER JOIN scmdata.t_progress_node_config a
            ON a.progress_config_id = c.progress_config_id
           AND a.company_id = c.company_id
           AND c.industry_classification = v_cate
           AND c.production_category = v_pcate
           AND instr(';' || c.product_subclass || ';',
                     ';' || v_scate || ';') > 0
         INNER JOIN scmdata.t_progress_node_config b
            ON b.progress_config_id = a.progress_config_id
           AND b.company_id = a.company_id
           AND b.pause = 0
           AND a.pause = 0
           AND b.progress_node_num >= a.progress_node_num
         WHERE a.progress_node_name = p_progress_status
           AND a.company_id = p_company_id;
      
        SELECT MAX(a.time_ratio) / 100
          INTO v_current_time_rt
          FROM scmdata.t_progress_range_config c
         INNER JOIN scmdata.t_progress_node_config a
            ON a.progress_config_id = c.progress_config_id
           AND a.company_id = c.company_id
           AND c.industry_classification = v_cate
           AND c.production_category = v_pcate
           AND instr(';' || c.product_subclass || ';',
                     ';' || v_scate || ';') > 0
         WHERE a.progress_node_name = p_progress_status
           AND a.company_id = p_company_id;
      
        v_left_link_timeprom := v_total_time_rt -
                                v_current_time_rt *
                                (p_curlink_complet_prom / 100);
        --剩余需用时天数
        v_left_days      := v_cycle * v_left_link_timeprom;
        vo_forecast_date := v_left_days + trunc(p_progress_update_date);
        vo_forecast_days := trunc(vo_forecast_date) -
                            trunc(p_delivery_date);
      END IF;
      --非生产订单
    ELSIF p_is_product = 0 THEN
      IF p_plan_date IS NOT NULL THEN
        vo_forecast_date := p_plan_date;
        vo_forecast_days := p_plan_date - p_delivery_date;
      ELSE
        vo_forecast_date := p_latest_delivery_date;
        vo_forecast_days := p_latest_delivery_date - p_delivery_date;
      END IF;
    ELSE
      NULL;
    END IF;
    po_forecast_date := vo_forecast_date;
    po_forecast_days := vo_forecast_days;
  END p_forecast_delivery_date;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-06-16 10:02:27
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  批量复制进度
  * Obj_Name    : P_BATCH_COPY_PROGRESS
  * Arg_Number  : 5
  * < IN PARAMS >  
  * P_COMPANY_ID : 企业ID
  * P_INPRODUCT_GRESS_CODE : 输入的生产订单编码
  * P_NDPRODUCT_GRESS_CODE : 勾选的生产订单编码
  * P_ITEM_ID : item_id
  * P_USER_ID : user_id
  *============================================*/

  PROCEDURE p_batch_copy_progress(p_company_id           VARCHAR2,
                                  p_inproduct_gress_code VARCHAR2,
                                  p_ndproduct_gress_code VARCHAR2,
                                  p_item_id              VARCHAR2,
                                  p_user_id              VARCHAR2) IS
    v_company_id         VARCHAR2(32) := p_company_id;
    v_product_gress_code VARCHAR2(100) := p_inproduct_gress_code; --输入的生产订单
    be_pro_rec           scmdata.t_production_progress%ROWTYPE;
    v_item_id            VARCHAR2(32) := p_item_id;
    v_goo_cnt            INT;
    --所选的需要复制进度的生产订单
    CURSOR pro_cur IS
      SELECT p.goo_id,
             p.progress_status,
             p.curlink_complet_ratio,
             p.product_gress_remarks,
             p.order_rise_status,
             p.plan_delivery_date,
             p.product_gress_id,
             p.company_id,
             p.progress_update_date,
             sp.supplier_company_id cur_company_id
        FROM scmdata.t_production_progress p
       INNER JOIN scmdata.t_supplier_info sp
          ON sp.supplier_code = p.supplier_code
         AND sp.company_id = p.company_id
       WHERE p.company_id = v_company_id
         AND p.product_gress_code = p_ndproduct_gress_code;
  BEGIN
    --判断输入的生产订单是否存在
    SELECT COUNT(DISTINCT p.goo_id)
      INTO v_goo_cnt
      FROM scmdata.t_production_progress p
     WHERE p.company_id = v_company_id
       AND p.product_gress_code = v_product_gress_code;
  
    IF v_goo_cnt = 0 THEN
      raise_application_error(-20002,
                              '复制失败！输入的生产订单编号不存在，请检查！');
    ELSE
      --判断需复制进度的生产订单 货号是否一致
      SELECT COUNT(DISTINCT p.goo_id)
        INTO v_goo_cnt
        FROM scmdata.t_production_progress p
       WHERE p.company_id = v_company_id
         AND p.product_gress_code = p_ndproduct_gress_code;
    
      IF v_goo_cnt > 1 THEN
        raise_application_error(-20002,
                                '复制失败！所选生产订单货号不一致，请检查！');
      ELSE
        SELECT COUNT(DISTINCT p.goo_id)
          INTO v_goo_cnt
          FROM scmdata.t_production_progress p
         WHERE p.company_id = v_company_id
           AND (p.product_gress_code = p_ndproduct_gress_code OR
               p.product_gress_code = v_product_gress_code);
        IF v_goo_cnt > 1 THEN
          raise_application_error(-20002,
                                  '复制失败！所选生产订单货号与输入生产订单货号不一致，请检查！');
        END IF;
      END IF;
      SELECT p.*
        INTO be_pro_rec
        FROM scmdata.t_production_progress p
       WHERE p.company_id = v_company_id
         AND p.product_gress_code = v_product_gress_code;
      --复制内容修改为：复制“生产进度状态、当前环节完成比例、生产进度说明、订单风险状态、计划到仓日期”
      --6.13增加：复制内容增加“进度更新日期”
      FOR pro_rec IN pro_cur LOOP
        IF v_item_id IN ('a_product_110', 'a_product_210') THEN
          pro_rec.progress_status      := be_pro_rec.progress_status;
          pro_rec.progress_update_date := be_pro_rec.progress_update_date;
        END IF;
        pro_rec.curlink_complet_ratio := be_pro_rec.curlink_complet_ratio;
        pro_rec.product_gress_remarks := be_pro_rec.product_gress_remarks;
        pro_rec.order_rise_status     := be_pro_rec.order_rise_status;
        pro_rec.plan_delivery_date    := be_pro_rec.plan_delivery_date;
        IF v_item_id IN ('a_product_110', 'a_product_210') THEN
          UPDATE scmdata.t_production_progress t
             SET t.progress_status       = pro_rec.progress_status,
                 t.curlink_complet_ratio = pro_rec.curlink_complet_ratio,
                 t.product_gress_remarks = pro_rec.product_gress_remarks,
                 t.order_rise_status     = pro_rec.order_rise_status,
                 t.plan_delivery_date    = pro_rec.plan_delivery_date,
                 t.progress_update_date  = pro_rec.progress_update_date,
                 t.update_id             = p_user_id,
                 t.update_time           = SYSDATE,
                 t.update_company_id = CASE
                                         WHEN v_item_id = 'a_product_110' THEN
                                          pro_rec.company_id
                                         WHEN v_item_id = 'a_product_210' THEN
                                          pro_rec.cur_company_id
                                         ELSE
                                          NULL
                                       END
           WHERE t.product_gress_id = pro_rec.product_gress_id
             AND t.company_id = pro_rec.company_id;
        ELSIF v_item_id IN ('a_product_150', 'a_product_217') THEN
          UPDATE scmdata.t_production_progress t
             SET t.order_rise_status  = pro_rec.order_rise_status,
                 t.plan_delivery_date = pro_rec.plan_delivery_date,
                 t.update_id          = p_user_id,
                 t.update_time        = SYSDATE,
                 t.update_company_id = CASE
                                         WHEN v_item_id = 'a_product_150' THEN
                                          pro_rec.company_id
                                         WHEN v_item_id = 'a_product_217' THEN
                                          pro_rec.cur_company_id
                                         ELSE
                                          NULL
                                       END
           WHERE t.product_gress_id = pro_rec.product_gress_id
             AND t.company_id = pro_rec.company_id;
        ELSE
          NULL;
        END IF;
      END LOOP;
    END IF;
  END p_batch_copy_progress;

END pkg_production_progress_a;
/
