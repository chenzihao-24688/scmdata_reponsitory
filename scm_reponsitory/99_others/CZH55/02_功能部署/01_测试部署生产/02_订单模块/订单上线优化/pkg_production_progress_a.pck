CREATE OR REPLACE PACKAGE pkg_production_progress_a IS

  -- Author  : SANFU
  -- Created : 2021/7/26 14:23:50
  -- Purpose : �����������ȸ���������߼�
  --�����Զ���������

  --���зֲ����������������Զ���������
  PROCEDURE p_auto_end_all_orders(p_company_id VARCHAR2);
  --��������ģ��-�Ż�����ά / ��ױ����Ʒ�����Զ���������
  PROCEDURE p_auto_end_mt_orders(p_company_id VARCHAR2);
  --��ױ����Ʒ�Զ���ֵ����ԭ��
  PROCEDURE p_auto_mt_delay_problem(p_company_id VARCHAR2);
  --�������ȸ���ʱУ��
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
  --��ȡ��������
  FUNCTION f_get_delay_day(p_company_id    VARCHAR2,
                           p_order_code    VARCHAR2,
                           p_goo_id        VARCHAR2,
                           p_delivery_date DATE) RETURN INT;

  --�Ƿ�������ֲ�δ���ڶ���������
  PROCEDURE p_is_order_rate(p_company_id       VARCHAR2,
                            p_order_code       VARCHAR2,
                            p_goo_id           VARCHAR2,
                            p_cate             VARCHAR2,
                            p_delivery_date    DATE,
                            p_order_amount     NUMBER,
                            po_order_rate_flag OUT INT,
                            po_end_time_c      OUT INT,
                            po_total_c         OUT INT);

  --����T_PROGRESS_LOG
  PROCEDURE p_insert_t_progress_log(p_product_gress_id   VARCHAR2,
                                    p_company_id         VARCHAR2,
                                    p_log_type           VARCHAR2,
                                    p_log_msg            VARCHAR2,
                                    p_operater           VARCHAR2,
                                    p_operate_company_id VARCHAR2,
                                    p_create_id          VARCHAR2,
                                    p_update_id          VARCHAR2,
                                    p_memo               VARCHAR2);
  --��ȡ����״̬
  FUNCTION f_get_progress_status(p_status_code VARCHAR2,
                                 p_company_id  VARCHAR2) RETURN VARCHAR2;
  --��ȡ����������������
  PROCEDURE p_get_progress_log_msg(p_old_filed VARCHAR2,
                                   p_new_filed VARCHAR2,
                                   p_title     VARCHAR2,
                                   p_split     CHAR,
                                   p_status    INT,
                                   p_log_msg   CLOB DEFAULT NULL,
                                   p_up_cnt    INT DEFAULT 0,
                                   po_up_cnt   OUT INT,
                                   po_log_msg  OUT CLOB);
  --Ԥ�⽻��
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
  --�������ƽ���
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
  * Purpose  :  �Զ���������������
  *             ���зֲ����������������Զ������������ܣ��������£�
  *             1����������è����ʱ�䲻Ϊ�գ������ڣ�������ָ������¼ASN����ȷ�����ڡܶ������ڣ��Ľ�����������װ/Ůװ/Ь��80%������88%����Ʒ86%����ױ92%�����踳ֵ����ԭ��ֱ�ӽ���������
  *             2����è����ʱ��+3�주��ǰ���ڣ�
  *             20220608 clj  ���������Զ��������������ڱ������              
  *             1) ������������ױ����Ʒ�����ڵĽ������������Ϊ��94%;
  *             2) �����������������ڵĽ��������������ױ����ƷΪ��94%����װ��Ůװ�����¡�Ь����100%��
  * Obj_Name    : P_AUTO_END_ALL_ORDERS
  * Arg_Number  : 1
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
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
    
      --�Ƿ����ڣ�������ָ������¼ASN����ȷ�����ڡܶ������ڣ���������ֲ�δ���ڶ���������
      p_is_order_rate(p_company_id       => p_company_id,
                      p_order_code       => order_rec.order_code,
                      p_goo_id           => order_rec.goo_id,
                      p_cate             => order_rec.category,
                      p_delivery_date    => trunc(order_rec.delivery_date),
                      p_order_amount     => order_rec.order_amount,
                      po_order_rate_flag => v_order_rate_flag,
                      po_end_time_c      => v_end_time_c,
                      po_total_c         => v_total_c);
    
      --���������¼ ���ڵ�������Ϊ���򲻴��� 
      IF v_end_time_c = v_total_c THEN
        IF v_order_rate_flag = 1 THEN
          --��������
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
  * Purpose  :  �����Զ��������ܣ���ױ����Ʒ��
  * ��ױ����Ʒ�Զ��������������Ƿ��������������������Զ����������������£����������������зֲ������������������򣩣�
  * 1����������è����ʱ�䲻Ϊ�գ������ڣ�������ָ������¼ASN����ȷ�����ڡܶ������ڣ��Ľ�����������Ʒ86%����ױ92%�����踳ֵ����ԭ��ֱ�ӽ���������
  * 2������ʱ���ȥ�������ڣ�������ʼ���ڣ���3��
  * 3����������ҪQC���������������-�������-��Ʒ���ࡱû���ڡ�ҵ����������-QC������á������ж�Ϊ����ҪQC�����
  * 4������û���쳣������û���ڴ����е��쳣�����ڡ��쳣�����б�-�����������ڶ������쳣������
  * Obj_Name    : AUTO_END_ORDERS
  * Arg_Number  : 1
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
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
    --��������Ϊ����ױ����Ʒ�Զ�����������ͬʱ������������������
    --1. ��èϵͳ-������ϸ-����ʱ�䲻Ϊ�գ�
    --2. ����ʱ���ȥ�������ڣ�������ʼ���ڣ���3��210916 ����������������  
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
                         AND po.is_product_order = 1 --��������
                         AND po.finish_time IS NOT NULL
                         AND trunc(po.finish_time) + 3 < trunc(SYSDATE) --1.��è����ʱ��+5��С�ڵ�ǰ����  2.20220523 ��è����ʱ��+3��С�ڵ�ǰ���� 
                      --AND trunc(po.finish_time) - trunc(po.delivery_date) < 3 --1.210916 ���������������� 
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
      --3. ��������ҪQC���������������-�������-��Ʒ���ࡱû���ڡ�ҵ����������-QC������á������ж�Ϊ����ҪQC�����
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
        --4. ����û���쳣������û���ڴ����е��쳣�����ڡ��쳣�����б�-������'�����ڶ������쳣������
        --�����������������������쳣����ȫ����������ܽ���
        p_sql := q'[SELECT NVL(SUM(decode(abn.progress_status, '02', 1, 0)),0), COUNT(*)
            FROM scmdata.t_abnormal abn
              WHERE abn.company_id = :a
             AND abn.order_id = :b
             AND abn.goo_id = :c]';
      
        EXECUTE IMMEDIATE p_sql
          INTO v_abn_status, v_abn_status_tol
          USING p_company_id, order_rec.order_code, order_rec.goo_id;
      
        IF v_abn_status = v_abn_status_tol THEN
          --5.��������è����ʱ�䲻Ϊ�գ������ڣ�������ָ������¼ASN����ȷ�����ڡܶ������ڣ��Ľ�����������Ʒ86%����ױ92%�����踳ֵ����ԭ��ֱ�ӽ���������
          --�����߼����ų�������¼ASN�ջ���=0  
          --�Ƿ����ڣ�������ָ������¼ASN����ȷ�����ڡܶ������ڣ���������ֲ�δ���ڶ���������        
          p_is_order_rate(p_company_id       => p_company_id,
                          p_order_code       => order_rec.order_code,
                          p_goo_id           => order_rec.goo_id,
                          p_cate             => order_rec.category,
                          p_delivery_date    => trunc(order_rec.delivery_date),
                          p_order_amount     => order_rec.order_amount,
                          po_order_rate_flag => v_order_rate_flag,
                          po_end_time_c      => v_end_time_c,
                          po_total_c         => v_total_c);
        
          --���������¼ ���ڵ�������Ϊ���򲻴��� 
          IF v_end_time_c = v_total_c THEN
            --7.��Ʒ07����������������¼-�ջ����ܺͣ�/��������������������=86%��
            --  ��ױ06����������������¼-�ջ����ܺͣ�/��������������������=92%��
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
  * Purpose  :  ��ױ����Ʒ�Զ���ֵ����ԭ��
  *             1�����������㣺��è����ʱ��+1��ܵ�ǰ���ڣ���������ȷ��ʱ��-�������ڣ�������ʼ���ڣ�=1��Ķ����Զ���ֵ����ԭ��
  *             �����û����д����ԭ�����Զ���ֵ����������ࡢ����ԭ����ࡢ����ԭ��ϸ�֡���Ӧ���Ƿ��������β���1�������β���2�����Ƿ����������⡣����������ࡢ����ԭ����ࡢ����ԭ��ϸ��Ϊ��ͼʾ����Ӧ���Ƿ��������β���1�������β���2�����Ƿ�������������ݶ������÷�Χ�Լ�����������ࡢ����ԭ����ࡢ����ԭ���ҵ���Ӧ�쳣��������ģ���Ӧ��ֵ��
  *             ����������ֵΪ��������
  *             ���������д����ԭ������Ҫ�Զ���ֵ������д������Ϊ׼��
  *             �۸�ֵ���¼���ӱ�[������־] ��������Ϊ������������Ϊϵͳ����Ա������ʱ��Ϊ��ֵʱ�䣻
  * Obj_Name    : P_AUTO_MT_DELAY_PROBLEM
  * Arg_Number  : 1
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
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
      --��ȡ��������
      v_delay_day := f_get_delay_day(p_company_id    => p_company_id,
                                     p_order_code    => order_rec.order_code,
                                     p_goo_id        => order_rec.goo_id,
                                     p_delivery_date => order_rec.delivery_date);
      --���������������1��Ķ����Զ���ֵ����ԭ��
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
           AND ad.problem_classification = '��������'
           AND ad.cause_classification = '��������Ӱ��'
           AND ad.cause_detail = '����';
      
        UPDATE scmdata.t_production_progress a
           SET a.delay_problem_class  = '��������',
               a.delay_cause_class    = '��������Ӱ��',
               a.delay_cause_detailed = '����',
               a.problem_desc         = nvl(a.problem_desc, '����'),
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
  * Purpose  :  ��ȡ��������
  * Obj_Name    : F_GET_DELAY_DAY
  * Arg_Number  : 4
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
  * P_ORDER_CODE : �������
  * P_GOO_ID : ����
  * P_DELIVERY_DATE : ��������
  * < OUT PARAMS > 
  * RETURN INT : ��������
  *============================================*/

  FUNCTION f_get_delay_day(p_company_id    VARCHAR2,
                           p_order_code    VARCHAR2,
                           p_goo_id        VARCHAR2,
                           p_delivery_date DATE) RETURN INT IS
    v_delay_day INT;
  BEGIN
    --������ȷ��ʱ��-�������ڣ�������ʼ���ڣ�
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
  * Purpose  :  �ж��Ƿ�������ֲ�δ���ڶ���������
  * Obj_Name    : P_IS_ORDER_RATE
  * Arg_Number  : 9
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
  * P_ORDER_CODE : �������
  * P_GOO_ID : ����
  * P_CATE : ����
  * P_DELIVERY_DATE : ��������
  * P_ORDER_AMOUNT : �������� 
  * < OUT PARAMS >  
  * PO_ORDER_RATE_FLAG : �Ƿ�������ֲ�δ���ڶ��������� 1���� 0����
  * PO_END_TIME_C : ͳ�ƽ�����¼ ����ʱ�䲻Ϊ�������ܺ�
  * PO_TOTAL_C : ͳ��ȫ��������¼
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
    --20220608 clj  ���������Զ��������������ڱ������              
    --1��������������ױ����Ʒ�����ڵĽ������������Ϊ��94%;
    --2�������������������ڵĽ��������������ױ����ƷΪ��94%����װ��Ůװ�����¡�Ь����100%��
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
  * Purpose  : �������ȸ���ʱУ��
  *            ���ɹ�������Ӧ�̶˵���������������������ʹ��
  * Obj_Name    : P_CHECK_UPDPROGRESS
  * Arg_Number  : 17
  * < IN PARAMS >  
  * P_ITEM_ID : ITEM_ID ��ѡ� Ĭ��Ϊ��
  * P_COMPANY_ID : ��ҵID
  * P_GOO_ID : ����
  * P_DELAY_PROBLEM_CLASS : �����������
  * P_DELAY_CAUSE_CLASS : ����ԭ�����
  * P_DELAY_CAUSE_DETAILED : ����ԭ��ϸ��
  * P_PROBLEM_DESC : ��������
  * P_RESPONSIBLE_DEPT_SEC : ���β��Ŷ���
  * P_PROGRESS_STATUS : ��������״̬��ѡ� Ĭ��Ϊ��
  * P_CURLINK_COMPLET_RATIO : ��ǰ������ɱ���
  * P_ORDER_RISE_STATUS :   ��������״̬
  * P_PROGRESS_UPDATE_DATE : ���ȸ�������
  * < OUT PARAMS > 
  * PO_IS_SUP_EXEMPTION : �Ƿ�Ӧ������
  * PO_FIRST_DEPT_ID : ���β���һ��
  * PO_SECOND_DEPT_ID :���β��Ŷ���
  * PO_IS_QUALITY : �Ƿ���������
  * PO_DEPT_NAME :  ���β��Ŷ�������
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
    --20220414 zxp �µ��������ȱ�����è��������Ķ����������ԭ�򿪷ſ��޸�
    --����У���߼�������������ࡢ����ԭ����ࡢ����ԭ��ϸ����ֵ����������������
    IF p_delay_problem_class IS NOT NULL AND
       p_delay_cause_class IS NOT NULL AND
       p_delay_cause_detailed IS NOT NULL THEN
      IF p_problem_desc IS NULL THEN
        raise_application_error(-20002,
                                '��ʾ������������ࡢ����ԭ����ࡢ����ԭ��ϸ����ֵ���������������');
      ELSE
        IF p_item_id IN ('a_product_110',
                         'a_product_150',
                         'a_product_210',
                         'a_product_217') THEN
          IF p_responsible_dept_sec IS NULL THEN
            raise_application_error(-20002,
                                    '����ʧ�ܣ�����ԭ������д�����β���(2)������Ϊ�գ����顣');
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
              IF v_dept_name <> '��' THEN
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
                                          '����ʧ�ܣ����β���(2��)����Ϊ���β���(1��)���¼����ţ����飡');
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
                                  '����ʧ�ܣ����β���(2��)��Ϊ��ʱ,����������ࡢ����ԭ����ࡢ����ԭ��ϸ�ֱ��');
        ELSE
          NULL;
        END IF;
      END IF;
    END IF;
    IF p_item_id IN ('a_product_110', 'a_product_150', 'a_product_210') THEN
      IF p_item_id <> 'a_product_150' THEN
        IF p_progress_status IS NULL THEN
          raise_application_error(-20002,
                                  '����ʧ�ܣ�����������״̬������Ϊ�գ����飡');
        ELSE
          IF p_progress_status NOT IN ('00', '02') AND
             p_curlink_complet_ratio IS NULL THEN
            raise_application_error(-20002,
                                    '����ʧ�ܣ�����������״̬����ֵ���򡰵�ǰ������ɱ�����Ϊ������飡');
          END IF;
        END IF;
      END IF;
      IF p_order_rise_status IS NULL THEN
        raise_application_error(-20002,
                                '����ʧ�ܣ���������״̬������飡');
      END IF;
    
      IF p_curlink_complet_ratio IS NOT NULL THEN
        IF p_curlink_complet_ratio >= 0 AND p_curlink_complet_ratio <= 100 THEN
          NULL;
        ELSE
          raise_application_error(-20002,
                                  '����ʧ�ܣ���ǰ������ɱ���ȡֵ����Ϊ0~100�����飡');
        END IF;
        IF p_progress_update_date IS NULL THEN
          raise_application_error(-20002,
                                  '����ʧ�ܣ�����ǰ������ɱ�������Ϊ��ʱ�����ȸ������ڱ�����飡');
        ELSE
          IF p_item_id <> 'a_product_150' THEN
            IF trunc(p_progress_update_date) > trunc(SYSDATE) THEN
              raise_application_error(-20002,
                                      '����ʧ�ܣ������ȸ������ڡ����ɴ��ڵ�ǰ���ڣ����飡');
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
  * Purpose  : ��������������־
  * Obj_Name    : P_INSERT_T_PROGRESS_LOG
  * Arg_Number  : 9
  * < IN PARAMS >  
  * P_PRODUCT_GRESS_ID : �������ȱ�����ID
  * P_COMPANY_ID : ��ҵID
  * P_LOG_TYPE : ��������
  * P_LOG_MSG : ��������
  * P_OPERATER : ������
  * P_OPERATE_COMPANY_ID : ��������ҵID
  * P_CREATE_ID : ������
  * P_UPDATE_ID : �޸���
  * P_MEMO : ��ע
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
  * Purpose  : ��ȡ����״̬
  * Obj_Name    : F_GET_PROGRESS_STATUS
  * Arg_Number  : 2
  * < IN PARAMS >  
  * P_STATUS_CODE : ���ȱ���
  * P_COMPANY_ID : ��ҵID
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
  * Purpose  : ��ȡ���������������� �������ͨ��ƽ̨��־���������߼���
  *           �� trigger��trg_af_u_t_production_progress�� ���� 
  * Obj_Name    : P_GET_PROGRESS_LOG_MSG
  * Arg_Number  : 10
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
  * P_OLD_FILED : ��ֵ
  * P_NEW_FILED : ��ֵ
  * P_TITLE : ��ʾ����
  * P_SPLIT : ����������ݼ�ķָ���
  * P_STATUS : ���ݲ�ͬ״̬���ò�ͬ�ֶ�ȡֵ�߼�
  *            0 :��������״̬ 1������ͨ���ֶλ�ȡ 2����������״̬
  * P_LOG_MSG : �������ݣ��ݹ鴫�ݲ�������ƴ��
  * P_UP_CNT : ͳ��ͳһʱ���޸��ֶΣ��ݹ鴫��ͳ��ֵ
  * < OUT PARAMS >  
  * PO_UP_CNT : ͳһʱ���޸��ֶ� ����
  * PO_LOG_MSG : ��������
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
    v_up_count INT := p_up_cnt; --ͳ��ͳһʱ���޸��ֶ�
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
                              '����������־��¼�����ˣ�����ϵ����Ա��');
    END IF;
    po_up_cnt  := v_up_count;
    po_log_msg := v_log_msg;
  END p_get_progress_log_msg;

  /*============================================*
  * Author   : CZH
  * Created  : 2022-06-16 09:52:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  Ԥ�⽻��
  *��1�� ��������״̬Ϊ�ա��ƻ���������Ϊ��ʱ��Ԥ����������Ϊ�գ�Ԥ�⽻��Ϊ�գ�
  *��2�� �ƻ��������ڲ�Ϊ��ʱ��Ԥ����������=�ƻ���������-�������ڣ�Ԥ�⽻��=�ƻ��������ڣ�
  *��3�� �ƻ���������Ϊ�ա���������״̬��Ϊ��ʱ���������߼�����
  * ��  Ԥ�⽻�ڼ������
  *     �������� =����������-�µ����ڣ�
  *     ʣ������ʱ����= �������� *������ʣ�໷����ʱռ���ܺ�+��ǰ������ʱռ��*��1-��ǰ������ɱ�����
  *     Ԥ�⽻��=ʣ�໷������ʱ����+���ȸ�������
  * ��  Ԥ����������=Ԥ�⽻��-��������
  * 6.13 clj �������������Ԥ�����������������
  * 1�� �ƻ��������ڲ�Ϊ��ʱ��Ԥ����������=�ƻ���������-�������ڣ�Ԥ�⽻��=�ƻ��������ڣ�
  * 2�� �ƻ���������Ϊ��ʱ��Ԥ����������=���¼ƻ�����-�������ڣ�Ԥ�⽻��=���¼ƻ����ڣ�
  * Obj_Name    : P_FORECAST_DELIVERY_DATE
  * Arg_Number  : 11
  * < IN PARAMS >  
  * P_PROGRESS_ID : �������ȱ��
  * P_COMPANY_ID : ��ҵID
  * P_IS_PRODUCT ���Ƿ��������� Ĭ��Ϊ1��������������0����
  * P_LATEST_DELIVERY_DATE �����¼ƻ����� ��ѡ�Ĭ��Ϊ�� ������������ʹ��
  * P_PROGRESS_STATUS : ��������״̬ ��ѡ�Ĭ��Ϊ�� ����������ʹ��
  * P_PROGRESS_UPDATE_DATE : ���ȸ������ڣ�ѡ�Ĭ��Ϊ�� ����������ʹ��
  * P_PLAN_DATE : �ƻ�����
  * P_DELIVERY_DATE : ��������
  * P_CURLINK_COMPLET_PROM : ��ǰ������ɱ��� (ѡ��) Ĭ��Ϊ�� ����������ʹ��
  * < OUT PARAMS > 
  * PO_FORECAST_DATE : Ԥ�⽻��
  * PO_FORECAST_DAYS : Ԥ����������
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
    --��������
    IF p_is_product = 1 THEN
      IF p_progress_status IS NULL AND p_plan_date IS NULL THEN
        vo_forecast_date := NULL;
        vo_forecast_days := NULL;
      ELSIF p_plan_date IS NOT NULL THEN
        vo_forecast_date := p_plan_date;
        vo_forecast_days := p_plan_date - p_delivery_date;
      ELSIF p_plan_date IS NULL AND p_delivery_date IS NOT NULL THEN
        --��ȡ�µ�����
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
        --��������
        v_cycle := trunc(p_delivery_date) - trunc(v_order_date);
        --����ʣ�໷����ʱռ���ܺ�
        --ʣ������ʱ����= �������� *������ʣ�໷����ʱռ���ܺ�+��ǰ������ʱռ��*��1-��ǰ������ɱ�����)               
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
        --ʣ������ʱ����
        v_left_days      := v_cycle * v_left_link_timeprom;
        vo_forecast_date := v_left_days + trunc(p_progress_update_date);
        vo_forecast_days := trunc(vo_forecast_date) -
                            trunc(p_delivery_date);
      END IF;
      --����������
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
  * Purpose  :  �������ƽ���
  * Obj_Name    : P_BATCH_COPY_PROGRESS
  * Arg_Number  : 5
  * < IN PARAMS >  
  * P_COMPANY_ID : ��ҵID
  * P_INPRODUCT_GRESS_CODE : �����������������
  * P_NDPRODUCT_GRESS_CODE : ��ѡ��������������
  * P_ITEM_ID : item_id
  * P_USER_ID : user_id
  *============================================*/

  PROCEDURE p_batch_copy_progress(p_company_id           VARCHAR2,
                                  p_inproduct_gress_code VARCHAR2,
                                  p_ndproduct_gress_code VARCHAR2,
                                  p_item_id              VARCHAR2,
                                  p_user_id              VARCHAR2) IS
    v_company_id         VARCHAR2(32) := p_company_id;
    v_product_gress_code VARCHAR2(100) := p_inproduct_gress_code; --�������������
    be_pro_rec           scmdata.t_production_progress%ROWTYPE;
    v_item_id            VARCHAR2(32) := p_item_id;
    v_goo_cnt            INT;
    --��ѡ����Ҫ���ƽ��ȵ���������
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
    --�ж���������������Ƿ����
    SELECT COUNT(DISTINCT p.goo_id)
      INTO v_goo_cnt
      FROM scmdata.t_production_progress p
     WHERE p.company_id = v_company_id
       AND p.product_gress_code = v_product_gress_code;
  
    IF v_goo_cnt = 0 THEN
      raise_application_error(-20002,
                              '����ʧ�ܣ����������������Ų����ڣ����飡');
    ELSE
      --�ж��踴�ƽ��ȵ��������� �����Ƿ�һ��
      SELECT COUNT(DISTINCT p.goo_id)
        INTO v_goo_cnt
        FROM scmdata.t_production_progress p
       WHERE p.company_id = v_company_id
         AND p.product_gress_code = p_ndproduct_gress_code;
    
      IF v_goo_cnt > 1 THEN
        raise_application_error(-20002,
                                '����ʧ�ܣ���ѡ�����������Ų�һ�£����飡');
      ELSE
        SELECT COUNT(DISTINCT p.goo_id)
          INTO v_goo_cnt
          FROM scmdata.t_production_progress p
         WHERE p.company_id = v_company_id
           AND (p.product_gress_code = p_ndproduct_gress_code OR
               p.product_gress_code = v_product_gress_code);
        IF v_goo_cnt > 1 THEN
          raise_application_error(-20002,
                                  '����ʧ�ܣ���ѡ�����������������������������Ų�һ�£����飡');
        END IF;
      END IF;
      SELECT p.*
        INTO be_pro_rec
        FROM scmdata.t_production_progress p
       WHERE p.company_id = v_company_id
         AND p.product_gress_code = v_product_gress_code;
      --���������޸�Ϊ�����ơ���������״̬����ǰ������ɱ�������������˵������������״̬���ƻ��������ڡ�
      --6.13���ӣ������������ӡ����ȸ������ڡ�
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
