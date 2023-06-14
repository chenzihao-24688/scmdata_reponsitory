CREATE OR REPLACE PACKAGE pkg_production_progress_a IS

  -- Author  : SANFU
  -- Created : 2021/7/26 14:23:50
  -- Purpose : �����������ȸ���������߼�
  --�����Զ���������
  --��������ģ��-�Ż�����ά / ��ױ����Ʒ�����Զ���������
  PROCEDURE auto_end_orders(p_company_id VARCHAR2 DEFAULT 'a972dd1ffe3b3a10e0533c281cac8fd7');

END pkg_production_progress_a;
/
CREATE OR REPLACE PACKAGE BODY pkg_production_progress_a IS
  --�����Զ���������
  --��������ģ��-�Ż�����ά / ��ױ����Ʒ�����Զ���������
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
    --��������Ϊ����ױ����Ʒ�Զ�����������ͬʱ������������������
    --1. ��èϵͳ-������ϸ-����ʱ�䲻Ϊ�գ�
    --2. ����ʱ���ȥ�������ڣ�������ʼ���ڣ���3��
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
          --���µĽ�����¼  
          --5.����������¼���������м�¼���е���ʱ�䣻
          --ȡ������¼���¼�¼���㣺����ȷ��ʱ�������¼�����ջ�����Ϊ�յ����ݣ�
          --�������ȷ��ʱ��������һ������û���ջ�������˳��ȡ�������ݣ��������ƣ�
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
          --6.����ȷ��ʱ��-�������ڣ�������ʼ���ڣ�< 2��;
          --7.��Ʒ07����������������¼-�ջ����ܺͣ�/��������������������86%��
          --  ��ױ06����������������¼-�ջ����ܺͣ�/��������������������92%��
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
