CREATE OR REPLACE PACKAGE pkg_production_progress IS
  --ȫ�ֱ���
  --Ԥ�⽻�ڶ�ά����
  --���У�
  TYPE pno_type IS RECORD(
    node_num               NUMBER(3),
    target_completion_time DATE,
    plan_completion_time   DATE,
    actual_completion_time DATE);
  --�����ڴ��
  TYPE sys_pno_type IS TABLE OF pno_type INDEX BY PLS_INTEGER;

  --У���Ƿ��Ѿ�ͬ����������
  FUNCTION check_is_sync_production_progress(po_header_rec scmdata.t_ordered%ROWTYPE)
    RETURN NUMBER;
  --������è=���ӿڵ���=���ѽӵ��Ķ���=���Զ�ͬ����������
  PROCEDURE sync_production_progress(po_header_rec scmdata.t_ordered%ROWTYPE);
  --ͬ���ڵ����
  PROCEDURE sync_production_progress_node(po_header_rec scmdata.t_ordered%ROWTYPE,
                                          po_line_rec   scmdata.t_orders%ROWTYPE,
                                          p_produ_rec   t_production_progress%ROWTYPE,
                                          p_status      NUMBER);
  --�����ӿ�  ��Ӧ�̱������ͬ��������������
  PROCEDURE sync_ordered_update_product(po_header_rec scmdata.t_ordered%ROWTYPE);
  --�����ӿ�  �������ڣ��ɱ�����ͬ�������������������߼�
  PROCEDURE sync_orders_update_product(po_header_rec scmdata.t_ordered%ROWTYPE,
                                       po_line_rec   scmdata.t_orders%ROWTYPE,
                                       p_produ_rec   t_production_progress%ROWTYPE);
  --У��ڵ����ģ��
  FUNCTION check_production_node_config(p_produ_rec t_production_progress%ROWTYPE)
    RETURN NUMBER;
  --�����ڵ����
  PROCEDURE insert_production_progress_node(p_produ_rec t_production_progress%ROWTYPE);

  PROCEDURE insert_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE);
  PROCEDURE update_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE);
  PROCEDURE delete_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE);
  --У������������
  PROCEDURE check_production_progress(p_product_gress_id VARCHAR2);
  --��������
  PROCEDURE finish_production_progress(p_product_gress_id VARCHAR2,
                                       p_status           VARCHAR2,
                                       p_user_id          VARCHAR2 DEFAULT 'ADMIN',
                                       p_is_check         NUMBER DEFAULT 1,
                                       p_finish_type      VARCHAR2 DEFAULT '00');

  --У���Ƿ��н�����¼
  FUNCTION check_delivery_record(p_pro_rec scmdata.t_production_progress%ROWTYPE)
    RETURN NUMBER;

  --�ж��Ƿ��пۿ���ϸ�������޸Ķ���-�ۿ����״̬-�����
  PROCEDURE check_deductions(p_company_id VARCHAR2, p_order_id VARCHAR2);

  --������¼����-ͬ�����������ȱ�
  PROCEDURE sync_delivery_record(p_delivery_rec scmdata.t_delivery_record%ROWTYPE);
  --У���쳣�������� ����ֵ��ģ����
  FUNCTION check_abnormal_config(p_company_id VARCHAR2, p_goo_id VARCHAR2)
    RETURN VARCHAR2;
  --У���쳣��
  PROCEDURE check_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --�����쳣��
  PROCEDURE handle_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --�����쳣��
  PROCEDURE update_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --�����������ȣ��쳣��״̬
  PROCEDURE sync_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE,
                          p_status  VARCHAR2);
  --�ύ�쳣��
  PROCEDURE submit_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --ȷ���쳣��
  PROCEDURE confirm_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --ȷ���쳣��
  PROCEDURE revoke_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE);
  --���������쳣��
  --1)v_abn_rec ��ѡ�쳣��
  --2)p_abnormal_code_cp �������쳣������
  PROCEDURE batch_copy_abnormal(p_company_id       VARCHAR2,
                                p_user_id          VARCHAR2,
                                v_abn_rec          scmdata.t_abnormal%ROWTYPE, --��ѡ�쳣��
                                p_abnormal_code_cp VARCHAR2);
  --У��ڵ����
  PROCEDURE check_production_node(pno_rec scmdata.t_production_node%ROWTYPE);
  --�����ڵ����
  PROCEDURE insert_production_node(pno_rec scmdata.t_production_node%ROWTYPE);
  --����Ԥ�⽻��
  PROCEDURE get_forecast_delivery_date(p_company_id          VARCHAR2,
                                       p_product_gress_id    VARCHAR2,
                                       p_progress_status     VARCHAR2,
                                       po_forecast_date      OUT DATE,
                                       po_plan_complete_date OUT DATE);
  --�޸Ľڵ����
  PROCEDURE update_production_node(pno_rec  scmdata.t_production_node%ROWTYPE,
                                   p_status NUMBER DEFAULT 0);
  --�޸Ķ�����ע
  PROCEDURE update_ordered(po_rec scmdata.t_ordered%ROWTYPE);
  --�ۿ���
  PROCEDURE approve_orders(po_rec scmdata.t_ordered%ROWTYPE);
  --�ۿ�������
  PROCEDURE revoke_approve_orders(po_rec scmdata.t_ordered%ROWTYPE);
  --��ȡ��������
  FUNCTION get_delay_days(p_arrival_date DATE, p_order_date DATE)
    RETURN NUMBER;
  --��ȡ�������ڣ��������ȱ��еĶ�������ȡ�µ��б�Ķ������ڣ�����è�Ľ������ڣ�
  FUNCTION get_order_date(p_company_id VARCHAR2,
                          p_order_code VARCHAR2,
                          p_status     NUMBER) RETURN DATE;
  --��ȡ��Ʒ����
  FUNCTION get_order_price(p_pro_rec scmdata.t_production_progress%ROWTYPE)
    RETURN NUMBER;
  --��ȡʵ�۽��
  FUNCTION get_actual_discount_price(p_is_sup         NUMBER,
                                     p_discount_price NUMBER) RETURN NUMBER;
  --��ȡ�ۿ���/�ۿ����
  PROCEDURE get_deduction(p_company_id       VARCHAR2,
                          p_goo_id           VARCHAR2,
                          p_delay_day        NUMBER,
                          po_deduction_type  OUT VARCHAR2,
                          po_deduction_money OUT NUMBER);
  --��������һ����ϲ�������1���ۿ
  PROCEDURE get_date_same_deduction(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE,
                                    p_orgin         VARCHAR2,
                                    p_abnormal_id   VARCHAR2);

  --�������ڲ�һ�£�����1���ۿ
  PROCEDURE get_date_nsame_deduction(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                     p_delivery_date DATE,
                                     p_orgin         VARCHAR2,
                                     p_abnormal_id   VARCHAR2);
  --У��һ�µĵ�������
  FUNCTION check_delivery_date_same(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE) RETURN NUMBER;
  --У�鲻һ�µĵ�������
  FUNCTION check_delivery_date_nsame(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                     p_delivery_date DATE) RETURN NUMBER;

  --��������һ�£�����1���ۿ(����)
  PROCEDURE get_uwmax_date_same_deduction(p_pro_rec           scmdata.t_production_progress%ROWTYPE,
                                          p_delivery_date     DATE,
                                          p_orgin             VARCHAR2,
                                          p_abnormal_id       VARCHAR2,
                                          p_max_delivery_date DATE);

  --�������ڲ�һ�£�����1���ۿ(����)
  PROCEDURE get_uwmax_date_nsame_deduction(p_pro_rec           scmdata.t_production_progress%ROWTYPE,
                                           p_delivery_date     DATE,
                                           p_orgin             VARCHAR2,
                                           p_abnormal_id       VARCHAR2,
                                           p_max_delivery_date DATE);

  --����-ȡ��ٵĽ�����¼,������1�����ڿۿ�
  PROCEDURE get_uwmax_delivery_date(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE,
                                    p_orgin         VARCHAR2,
                                    p_abnormal_id   VARCHAR2);
  --ԭʼ��������ת��=������ȷ������
  PROCEDURE transform_delivery_date(p_delivery_rec          scmdata.t_delivery_record%ROWTYPE,
                                    p_deduction_change_time DATE);
  --ԭʼ�������ڰ����ù������ת��=������ȷ������
  PROCEDURE tranf_deduction_config(p_delivery_rec scmdata.t_delivery_record%ROWTYPE);

  --������Ʒ����ҵ����+�������+��Ʒ���ࣩ�����ڿۿ����������һģ��ƥ��
  PROCEDURE check_deduction_config(p_company_id       VARCHAR2,
                                   p_goo_id           VARCHAR2,
                                   p_status           NUMBER,
                                   po_count           OUT NUMBER,
                                   po_ded_change_time OUT DATE);
  --�Զ������Ŀۿ
  PROCEDURE sync_deduction(p_pro_rec     scmdata.t_production_progress%ROWTYPE,
                           p_orgin       VARCHAR2,
                           p_abnormal_id VARCHAR2);

  --�����쳣�����ۿ
  PROCEDURE sync_abn_ded_bill(p_company_id         VARCHAR2,
                              p_order_id           VARCHAR2,
                              p_goo_id             VARCHAR2,
                              p_create_id          VARCHAR2,
                              p_deduction_type     VARCHAR2 DEFAULT NULL,
                              p_delay_day          NUMBER,
                              p_delay_amount       NUMBER,
                              p_is_sup             NUMBER DEFAULT NULL, --��Ӧ���Ƿ�����
                              p_order_price        NUMBER,
                              p_discount_price     NUMBER,
                              p_act_discount_price NUMBER,
                              p_orgin              VARCHAR2, --��Դ ϵͳ���� SC / �ֶ����� MA
                              p_arrival_date       DATE DEFAULT NULL, --�������ڣ�����ӡ����ʹ�ã�
                              p_abnormal_id        VARCHAR2);
  --�����ۿ���ϸ
  PROCEDURE insert_deduction(p_duc_rec scmdata.t_deduction%ROWTYPE);
  --�Ƿ񳬼ƻ������������ ����ֵ����������
  FUNCTION check_is_delay(p_max_node_date DATE) RETURN NUMBER;
  --����ڵ����� ��һ�ڵ����� - ��ǰ�ڵ�����
  FUNCTION calc_node_cycle(p_next_node_time DATE, p_curr_node_time DATE)
    RETURN NUMBER;
  --��ȡʣ��ڵ������
  FUNCTION get_node_cycle(p_sys_pno_arrays sys_pno_type, p_node_num NUMBER)
    RETURN NUMBER;
  --Ԥ�⽻��ģ��ʵ��
  FUNCTION calc_forecast_delivery_date(p_company_id       VARCHAR2,
                                       p_product_gress_id VARCHAR2,
                                       p_status           VARCHAR2)
    RETURN DATE;
END pkg_production_progress;
/
CREATE OR REPLACE PACKAGE BODY pkg_production_progress IS
  --У���Ƿ��Ѿ�ͬ����������
  FUNCTION check_is_sync_production_progress(po_header_rec scmdata.t_ordered%ROWTYPE)
    RETURN NUMBER IS
    v_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_production_progress pr
     WHERE pr.company_id = po_header_rec.company_id
       AND pr.order_id = po_header_rec.order_code;
    IF v_flag > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  
  END check_is_sync_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:08:07
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ������è=���ӿڵ���=���ѽӵ��Ķ���=���Զ�ͬ����������
  * Obj_Name    : SYNC_PRODUCTION_PROGRESS
  * Arg_Number  : 1
  * PO_HEADER_REC :����ͷ����
  *============================================*/
  PROCEDURE sync_production_progress(po_header_rec scmdata.t_ordered%ROWTYPE) IS
    p_produ_rec          t_production_progress%ROWTYPE; --��������
    v_product_gress_code VARCHAR2(100); --�������ȱ���
    v_count              NUMBER; --ͳ��һ���ɹ������Ķ�����ϸ��
    v_approve_edition    VARCHAR2(100); --����״̬
    v_flag               NUMBER; --�ж������������ñ��Ƿ������÷�Χ���������ɽڵ���ȣ����������ɡ�
    v_rela_goo_id        VARCHAR2(100); --��������
    v_check_flag         NUMBER;
    v_evaluate_result    VARCHAR2(32);
  BEGIN
    --У��ͬ����������ʱ���Ƿ��Ѿ���������
    v_check_flag := check_is_sync_production_progress(po_header_rec => po_header_rec);
    IF v_check_flag = 1 THEN
      NULL;
    ELSE
      --ͳ�ƻ��� һ���ɹ������Ķ�����ϸ��
      SELECT COUNT(l.goo_id)
        INTO v_count
        FROM scmdata.t_orders l
       WHERE l.company_id = po_header_rec.company_id
         AND l.order_id = po_header_rec.order_code;
      --��ȡ������ϸ
      FOR po_line_rec IN (SELECT *
                            FROM scmdata.t_orders l
                           WHERE l.company_id = po_header_rec.company_id
                             AND l.order_id = po_header_rec.order_code) LOOP
      
        --1.�����������
        -- A ��һ���ɹ��������ֻ��Ӧһ�����ţ��������������=�ɹ�������ţ�
        -- B ��һ���ɹ�������Ŷ�Ӧ������ţ��������������=�ɹ��������+��������
        IF v_count = 1 THEN
          v_product_gress_code := po_header_rec.order_code;
        ELSE
          SELECT tc.rela_goo_id
            INTO v_rela_goo_id
            FROM scmdata.t_commodity_info tc
           WHERE tc.company_id = po_header_rec.company_id
             AND tc.goo_id = po_line_rec.goo_id;
        
          v_product_gress_code := po_header_rec.order_code || '-' ||
                                  v_rela_goo_id;
        END IF;
      
        --2.����״̬(������Ʒ����������ģ��ӿڵ���ʱ�����ݿ��ܻ���ڲ�ͬ�������)
        /*SELECT MAX(a.approve_status)
         INTO v_approve_edition
         FROM scmdata.t_approve_version a
        WHERE a.company_id = po_header_rec.company_id
          AND a.goo_id = po_line_rec.goo_id
          AND a.approve_status = 'AS03';*/
        --�޸�
        SELECT MAX(approve_result)
          INTO v_approve_edition
          FROM (SELECT a.approve_result
                  FROM scmdata.t_approve_version a
                 WHERE a.company_id = po_line_rec.company_id
                   AND a.goo_id = po_line_rec.goo_id
                   AND a.approve_status <> 'AS00'
                 ORDER BY a.approve_time DESC)
         WHERE rownum < 2;
        --���ϼ��
        SELECT MAX(a.evaluate_result)
          INTO v_evaluate_result
          FROM scmdata.t_fabric_evaluate a
         WHERE a.company_id = po_line_rec.company_id
           AND a.goo_id = po_line_rec.goo_id;
      
        --3.��ֵ
        p_produ_rec.product_gress_id   := scmdata.f_get_uuid();
        p_produ_rec.company_id         := po_header_rec.company_id;
        p_produ_rec.product_gress_code := v_product_gress_code; --�����������
        p_produ_rec.order_id           := po_header_rec.order_code;
        p_produ_rec.progress_status    := '00'; --��������״̬  ��ʼֵ��δ��ʼ
        p_produ_rec.goo_id             := po_line_rec.goo_id;
        p_produ_rec.supplier_code      := po_header_rec.supplier_code;
        p_produ_rec.factory_code       := po_line_rec.factory_code;
        --p_produ_rec.forecast_delivery_date       := po_line_rec.delivery_date; --Ԥ�⽻��  :A.��������״̬Ϊδ��ʼ���Ҽƻ��������Ϊ��ʱ��Ԥ�⽻��=�������ڣ�
        p_produ_rec.forecast_delivery_date       := po_header_rec.delivery_date;
        p_produ_rec.forecast_delay_day           := 0; --Ԥ����������  ��ʼ0 ��������������ȡ��  ceil(sysdate - to_date('2020-11-13','YYYY-MM-DD'))
        p_produ_rec.actual_delivery_date         := '';
        p_produ_rec.actual_delay_day             := 0;
        p_produ_rec.latest_planned_delivery_date := get_order_date(p_company_id => po_header_rec.company_id,
                                                                   p_order_code => po_header_rec.order_code,
                                                                   p_status     => 2);
        p_produ_rec.order_amount                 := po_line_rec.order_amount;
        p_produ_rec.delivery_amount              := 0;
        p_produ_rec.approve_edition              := v_approve_edition; --ȡ����������
        p_produ_rec.fabric_check                 := v_evaluate_result; --���ϼ�� ��δ������ģ�飬�ݲ�����Ĭ��Ϊ��
        p_produ_rec.qc_quality_check             := ''; --����
        p_produ_rec.exception_handle_status      := '00';
        p_produ_rec.handle_opinions              := ''; --��ʼΪ��
        p_produ_rec.create_id                    := po_header_rec.create_id;
        p_produ_rec.create_time                  := SYSDATE;
        p_produ_rec.origin                       := 'SC';
        p_produ_rec.memo                         := '';
        p_produ_rec.qc_check                     := ''; --��ʱû��
        p_produ_rec.qa_check                     := ''; --��ʱû��
        p_produ_rec.order_rise_status            := '00';
      
        --4.������������
        insert_production_progress(p_produ_rec => p_produ_rec);
      
        --5.�ж������������ñ��Ƿ������÷�Χ(ͬʱУ���Ƿ�ͣ��)���������ɽڵ���ȣ����������ɡ�
      
        v_flag := check_production_node_config(p_produ_rec => p_produ_rec);
      
        --6.ͬ�����ɽڵ����
        IF v_flag = 1 THEN
        
          sync_production_progress_node(po_header_rec => po_header_rec,
                                        po_line_rec   => po_line_rec,
                                        p_produ_rec   => p_produ_rec,
                                        p_status      => 0);
        
        END IF;
      
      --7.����qc���ܼ���
      /*scmdata.pkg_a_qcqa.p_create_goo_collect(p_goo_id     => po_line_rec.goo_id,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                

                  
                  
                              
                                                                            p_company_id => po_line_re
                                                                                                      c.company_id);*/
      END LOOP;
    END IF;
  
  END sync_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:09:13
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ͬ�����ɽڵ����
  * Obj_Name    : SYNC_PRODUCTION_PROGRESS_NODE
  * Arg_Number  : 2
  * PO_HEADER_REC :����ͷ����
  * po_line_rec ��������ϸ
  * P_PRODU_REC :������������
  * p_status     : �����ӿ����ݣ����� 0 / �޸� 1
  *============================================*/
  PROCEDURE sync_production_progress_node(po_header_rec scmdata.t_ordered%ROWTYPE,
                                          po_line_rec   scmdata.t_orders%ROWTYPE, --��ʱ�ò���
                                          p_produ_rec   t_production_progress%ROWTYPE,
                                          p_status      NUMBER) IS
    pno_rec             scmdata.t_production_node%ROWTYPE;
    v_product_node_code VARCHAR2(100);
    --��һ���ڵ��Ŀ���������,��ʼֵΪ����-Ŀ���������
    v_target_completion_time DATE;
    --��������
    v_product_cycle NUMBER;
    --��һ���ڵ�Ľڵ����� ,��ʼֵΪ����-�ڵ�����
    v_node_cycle NUMBER;
    --��������ͨ������=����Ʒ���� =������Ʒ�������=���ҵ���Ʒ������Ӧ�ķ��࣬����������� =�������ڵ�����=����Ӧ�ڵ�ģ���ʹ�÷�Χ =�� �ڵ�����ģ������
    CURSOR pno_cur IS
      SELECT pn.progress_node_config_id,
             pn.progress_node_num,
             pn.progress_node_name,
             pn.time_ratio,
             row_number() over(ORDER BY pn.progress_node_num ASC) node_num --������������ ���ڵ����ûᱻͣ�õ���progress_node_num ����
        FROM scmdata.t_commodity_info tc
       INNER JOIN scmdata.t_progress_range_config pr
          ON tc.company_id = pr.company_id
         AND tc.category = pr.industry_classification
         AND tc.product_cate = pr.production_category
         AND instr(';' || pr.product_subclass || ';',
                   ';' || tc.samll_category || ';') > 0
         AND pr.pause = 0
       INNER JOIN scmdata.t_progress_node_config pn
          ON pr.company_id = pn.company_id
         AND pr.progress_config_id = pn.progress_config_id
         AND pn.pause = 0
       INNER JOIN scmdata.t_progress_config pg
          ON pg.company_id = pn.company_id
         AND pg.progress_config_id = pn.progress_config_id
         AND pg.pause = 0
       WHERE tc.company_id = p_produ_rec.company_id
         AND tc.goo_id = p_produ_rec.goo_id
       ORDER BY pn.progress_node_num DESC; --���ڵ㵹��
  
  BEGIN
    --0.�������� �����������µ�����Ϊͬһ�죬�������������Ϊ1,���� �������� = ��������-�ӵ�����
    SELECT decode(trunc(po_header_rec.delivery_date),
                  trunc(po_header_rec.create_time),
                  1,
                  ceil(trunc(po_header_rec.delivery_date) -
                       trunc(po_header_rec.create_time)))
      INTO v_product_cycle
      FROM dual;
  
    FOR pnode_rec IN pno_cur LOOP
    
      --1.�ڵ����-Ŀ��������ڼ������
      IF pnode_rec.progress_node_name = '����' THEN
        --1.1 ���ڵ㵹�ƣ����һ���ڵ�Ϊ�̶�ֵ����������Ŀ���������=�������ڣ�
        v_target_completion_time := trunc(po_header_rec.delivery_date);
        --�ڵ�����=��������*�ýڵ���ʱռ��
        v_node_cycle := round(v_product_cycle * pnode_rec.time_ratio * 0.01);
      ELSE
        --1.2 ����ڵ��Ŀ���������=��һ���ڵ��Ŀ���������-��һ���ڵ�Ľڵ����ڡ�
        v_target_completion_time := v_target_completion_time - v_node_cycle;
        --�ڵ�����=��������*��ǰ�ڵ���ʱռ��
        v_node_cycle := round(v_product_cycle * pnode_rec.time_ratio * 0.01);
      END IF;
      --2.�����ӿ�-����
      IF p_status = 0 THEN
        --2.1 �����ڵ���ȱ��
        v_product_node_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_production_node', --����
                                                                  pi_column_name => 'product_node_code', --����
                                                                  pi_company_id  => p_produ_rec.company_id, --��˾���
                                                                  pi_pre         => 'PN', --ǰ׺
                                                                  pi_serail_num  => 6);
        --2.2 ��ֵ
        pno_rec.product_node_id        := scmdata.f_get_uuid();
        pno_rec.company_id             := p_produ_rec.company_id;
        pno_rec.product_gress_id       := p_produ_rec.product_gress_id;
        pno_rec.product_node_code      := v_product_node_code;
        pno_rec.node_num               := pnode_rec.node_num; --�ڵ����
        pno_rec.node_name              := pnode_rec.progress_node_name; --�ڵ�����
        pno_rec.time_ratio             := pnode_rec.time_ratio; --��ʱռ��
        pno_rec.target_completion_time := v_target_completion_time; --Ŀ�����ʱ�䣬�Զ�����
        pno_rec.plan_completion_time   := ''; --�ƻ����ʱ��
        pno_rec.actual_completion_time := ''; --ʵ�����ʱ��
        pno_rec.complete_amount        := ''; --�������
        pno_rec.progress_status        := ''; --�ڵ����״̬
        pno_rec.progress_say           := ''; --����˵��
        pno_rec.update_id              := '';
        pno_rec.update_date            := '';
        pno_rec.create_id              := p_produ_rec.create_id;
        pno_rec.create_time            := SYSDATE;
        pno_rec.memo                   := '';
      
        --2.3 ͬ���ڵ����
        insert_production_node(pno_rec => pno_rec);
        --3.�����ӿ�-�޸ģ�������ʵ�֣�
      ELSIF p_status = 1 THEN
        --4.ͬ���ڵ����
        UPDATE scmdata.t_production_node pn
           SET pn.target_completion_time = v_target_completion_time
         WHERE pn.company_id = p_produ_rec.company_id
           AND pn.product_gress_id = p_produ_rec.product_gress_id
           AND pn.node_name = pnode_rec.progress_node_name;
      
      END IF;
    END LOOP;
    --COMMIT;
  END sync_production_progress_node;

  --�����ӿ�  ��Ӧ�̱������ͬ������������������ordered���������ã�
  PROCEDURE sync_ordered_update_product(po_header_rec scmdata.t_ordered%ROWTYPE) IS
  BEGIN
    --1.��Ӧ�̱�� ��������������-��Ӧ�̱��
    UPDATE scmdata.t_production_progress pr
       SET pr.supplier_code = po_header_rec.supplier_code
     WHERE pr.company_id = po_header_rec.company_id
       AND pr.order_id = po_header_rec.order_code;
  
  END sync_ordered_update_product;

  --�����ӿ�  �������ڣ��ɱ���ͬ�������������������߼�����orders���������ã�  ���������ã�ԭ�������ڱ����������ϸ���½��ڣ�
  PROCEDURE sync_orders_update_product(po_header_rec scmdata.t_ordered%ROWTYPE,
                                       po_line_rec   scmdata.t_orders%ROWTYPE,
                                       p_produ_rec   t_production_progress%ROWTYPE) IS
    v_flag NUMBER;
  BEGIN
    --1.�������ڱ����������������-Ԥ�⽻�ڣ���У����������״̬�Ƿ�Ϊδ��ʼ���Ҽƻ��������Ϊ��ʱ��Ԥ�⽻��=�������ڣ�
  
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_production_progress pr
     INNER JOIN scmdata.t_production_node pn
        ON pr.company_id = pn.company_id
       AND pr.product_gress_id = pn.product_gress_id
     WHERE pr.company_id = po_line_rec.company_id
       AND pr.order_id = po_line_rec.order_id
       AND pr.goo_id = po_line_rec.goo_id
       AND pr.progress_status = '00'
       AND pn.plan_completion_time IS NULL;
  
    IF v_flag > 0 THEN
      UPDATE scmdata.t_production_progress pr
         SET pr.forecast_delivery_date = po_header_rec.delivery_date
       WHERE pr.company_id = po_line_rec.company_id
         AND pr.order_id = po_line_rec.order_id
         AND pr.goo_id = po_line_rec.goo_id;
    END IF;
  
    --2.�µ��������ȱ�-�ڵ���� Ŀ�����ʱ��
  
    sync_production_progress_node(po_header_rec => po_header_rec,
                                  po_line_rec   => po_line_rec,
                                  p_produ_rec   => p_produ_rec,
                                  p_status      => 1);
  
  END sync_orders_update_product;

  --У��ڵ����ģ��
  FUNCTION check_production_node_config(p_produ_rec t_production_progress%ROWTYPE)
    RETURN NUMBER IS
    v_flag       NUMBER; --�ڵ�ģ����ڱ�־
    v_range_flag NUMBER; --���÷�Χ���ڱ�־
  BEGIN
    --1.ͬ���ڵ����
    --�ڵ�ģ��
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_commodity_info tc
     INNER JOIN scmdata.t_progress_range_config pr
        ON tc.company_id = pr.company_id
       AND tc.category = pr.industry_classification
       AND tc.product_cate = pr.production_category
       AND instr(';' || pr.product_subclass || ';',
                 ';' || tc.samll_category || ';') > 0
     INNER JOIN scmdata.t_progress_node_config pn
        ON pr.company_id = pn.company_id
       AND pr.progress_config_id = pn.progress_config_id
     INNER JOIN scmdata.t_progress_config pg
        ON pg.company_id = pn.company_id
       AND pg.progress_config_id = pn.progress_config_id
       AND pg.pause = 0
     WHERE tc.company_id = p_produ_rec.company_id
       AND tc.goo_id = p_produ_rec.goo_id;
  
    IF v_flag > 0 THEN
      --���÷�Χ
      SELECT COUNT(1)
        INTO v_range_flag
        FROM scmdata.t_commodity_info tc
       INNER JOIN scmdata.t_progress_range_config pr
          ON tc.company_id = pr.company_id
         AND tc.category = pr.industry_classification
         AND tc.product_cate = pr.production_category
         AND instr(';' || pr.product_subclass || ';',
                   ';' || tc.samll_category || ';') > 0
         AND pr.pause = 0
       INNER JOIN scmdata.t_progress_node_config pn
          ON pr.company_id = pn.company_id
         AND pr.progress_config_id = pn.progress_config_id
       INNER JOIN scmdata.t_progress_config pg
          ON pg.company_id = pn.company_id
         AND pg.progress_config_id = pn.progress_config_id
         AND pg.pause = 0
       WHERE tc.company_id = p_produ_rec.company_id
         AND tc.goo_id = p_produ_rec.goo_id;
    
      IF v_range_flag > 0 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      RETURN 0;
    END IF;
  
  END check_production_node_config;

  --�����ڵ�ģ��
  PROCEDURE insert_production_progress_node(p_produ_rec t_production_progress%ROWTYPE) IS
    v_flag        NUMBER;
    po_header_rec scmdata.t_ordered%ROWTYPE;
    po_line_rec   scmdata.t_orders%ROWTYPE;
  BEGIN
    --1.�жϸ����������Ƿ��нڵ���ȣ�������ʾ�������ɽڵ㡣
    --2.�����жϽڵ�������ñ��Ƿ����ģ�壬�������ɽڵ���ȣ�����������ʾ������ϵ����Ա����
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_production_node pn
     WHERE pn.company_id = p_produ_rec.company_id
       AND pn.product_gress_id = p_produ_rec.product_gress_id;
  
    IF v_flag > 0 THEN
      raise_application_error(-20002,
                              '�Ѵ��ڽڵ���ȣ������ظ����ɽڵ���ȣ�');
    ELSE
      --3.�ж������������ñ��Ƿ������÷�Χ���������ɽڵ���ȣ����������ɡ�
      --3.1
      v_flag := check_production_node_config(p_produ_rec => p_produ_rec);
    
      --4.ͬ�����ɽڵ����
      IF v_flag = 1 THEN
        SELECT *
          INTO po_header_rec
          FROM scmdata.t_ordered po
         WHERE po.company_id = p_produ_rec.company_id
           AND po.order_code = p_produ_rec.order_id;
      
        SELECT *
          INTO po_line_rec
          FROM scmdata.t_orders pln
         WHERE pln.company_id = p_produ_rec.company_id
           AND pln.order_id = p_produ_rec.order_id
           AND pln.goo_id = p_produ_rec.goo_id;
      
        sync_production_progress_node(po_header_rec => po_header_rec,
                                      po_line_rec   => po_line_rec,
                                      p_produ_rec   => p_produ_rec,
                                      p_status      => 0);
      
      ELSE
        raise_application_error(-20002,
                                '�ڵ�������ò����ڻ��ѽ��ã�����ϵ����Ա���ã�');
      END IF;
    
    END IF;
  
  END insert_production_progress_node;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:10:47
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ������������
  * Obj_Name    : INSERT_PRODUCTION_PROGRESS
  * Arg_Number  : 1
  * P_PRODU_REC :������������
  *============================================*/
  PROCEDURE insert_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE) IS
  BEGIN
    INSERT INTO t_production_progress
      (product_gress_id,
       company_id,
       product_gress_code,
       order_id,
       progress_status,
       goo_id,
       supplier_code,
       factory_code,
       forecast_delivery_date,
       forecast_delay_day,
       actual_delivery_date,
       actual_delay_day,
       latest_planned_delivery_date,
       order_amount,
       delivery_amount,
       approve_edition,
       fabric_check,
       qc_quality_check,
       exception_handle_status,
       handle_opinions,
       create_id,
       create_time,
       origin,
       memo,
       qc_check,
       qa_check,
       order_rise_status)
    VALUES
      (p_produ_rec.product_gress_id,
       p_produ_rec.company_id,
       p_produ_rec.product_gress_code,
       p_produ_rec.order_id,
       p_produ_rec.progress_status,
       p_produ_rec.goo_id,
       p_produ_rec.supplier_code,
       p_produ_rec.factory_code,
       trunc(p_produ_rec.forecast_delivery_date),
       p_produ_rec.forecast_delay_day,
       trunc(p_produ_rec.actual_delivery_date, 'YYYY-MM-DD'),
       p_produ_rec.actual_delay_day,
       trunc(p_produ_rec.latest_planned_delivery_date),
       p_produ_rec.order_amount,
       p_produ_rec.delivery_amount,
       p_produ_rec.approve_edition,
       p_produ_rec.fabric_check,
       p_produ_rec.qc_quality_check,
       p_produ_rec.exception_handle_status,
       p_produ_rec.handle_opinions,
       p_produ_rec.create_id,
       p_produ_rec.create_time,
       p_produ_rec.origin,
       p_produ_rec.memo,
       p_produ_rec.qc_check,
       p_produ_rec.qa_check,
       p_produ_rec.order_rise_status);
  END insert_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:11:32
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸���������
  * Obj_Name    : UPDATE_PRODUCTION_PROGRESS
  * Arg_Number  : 1
  * P_PRODU_REC :������������
  *============================================*/

  PROCEDURE update_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE) IS
  BEGIN
    UPDATE t_production_progress t
       SET t.progress_status              = p_produ_rec.progress_status,
           t.forecast_delivery_date       = trunc(p_produ_rec.forecast_delivery_date),
           t.latest_planned_delivery_date = trunc(p_produ_rec.latest_planned_delivery_date)
     WHERE t.product_gress_id = p_produ_rec.product_gress_id;
  
  END update_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:11:32
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ɾ����������
  * Obj_Name    : DELETE_PRODUCTION_PROGRESS
  * Arg_Number  : 1
  * P_PRODU_REC :������������
  *============================================*/
  PROCEDURE delete_production_progress(p_produ_rec scmdata.t_production_progress%ROWTYPE) IS
  BEGIN
  
    DELETE FROM t_production_progress t
     WHERE t.product_gress_id = p_produ_rec.product_gress_id;
  
  END delete_production_progress;

  --У������������
  PROCEDURE check_production_progress(p_product_gress_id VARCHAR2) IS
    v_abn_status       NUMBER; --�Ѵ����쳣������
    v_abn_status_tol   NUMBER; --ȫ���쳣������
    v_tips             VARCHAR2(1000);
    v_actual_delay_day NUMBER;
    v_count            NUMBER;
    v_delivery_amount  NUMBER;
    v_finish_time      DATE; --��è��������ʱ��
    v_flag             NUMBER; --������¼�Ƿ���ڵ���ʱ��Ϊ�յ����
    v_category         VARCHAR2(32); --�ֲ�
    v_is_sup_exemption NUMBER;
    v_first_dept_id    VARCHAR2(100);
    v_second_dept_id   VARCHAR2(100);
    v_is_quality       NUMBER;
  BEGIN
    --0.210911 �������� ��������������У��
    --1��ҪУ�鶩������è�Ľ���ʱ�䣬SCM�ſ��Բ�����������
    SELECT MAX(t.finish_time)
      INTO v_finish_time
      FROM scmdata.t_ordered t
     WHERE (t.company_id, t.order_code) IN
           (SELECT pr.company_id, pr.order_id
              FROM scmdata.t_production_progress pr
             WHERE pr.product_gress_id = p_product_gress_id);
  
    IF v_finish_time IS NULL THEN
      raise_application_error(-20002,
                              '��������ʧ�ܣ���������è������SCM�ſ��Բ���"��������"');
    ELSE
      NULL;
    END IF;
    --2��У�齻����¼�Ƿ���ڵ���ʱ��Ϊ�յ������������ڽ�����¼�ĵ���ʱ��Ϊ�գ����������������ʱ��ʾ����������ʧ�ܣ�������¼���ڡ�����ʱ��Ϊ�ա������ݣ����ɽ�����
    --20220308 �����߼����Ų齻����¼ASN�ջ���=0
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_delivery_record t
     WHERE (t.company_id, t.order_code, t.goo_id) IN
           (SELECT pr.company_id, pr.order_id, pr.goo_id
              FROM scmdata.t_production_progress pr
             WHERE pr.product_gress_id = p_product_gress_id)
       AND t.delivery_amount <> 0
       AND t.delivery_date IS NULL;
    IF v_flag > 0 THEN
      raise_application_error(-20002,
                              '��������ʧ�ܣ�������¼���ڡ�����ʱ��Ϊ�ա������ݣ����ɽ���');
    END IF;
  
    --1.�����������������������쳣����ȫ����������ܽ���
    SELECT nvl(SUM(decode(abn.progress_status, '02', 1, 0)), 0), COUNT(*)
      INTO v_abn_status, v_abn_status_tol
      FROM scmdata.t_abnormal abn
     INNER JOIN scmdata.t_production_progress pr
        ON abn.company_id = pr.company_id
       AND abn.order_id = pr.order_id
       AND abn.goo_id = pr.goo_id
     WHERE pr.product_gress_id = p_product_gress_id;
  
    IF v_abn_status <> v_abn_status_tol THEN
      --����ʧ�ܣ�����δ�ύ���������쳣������
      --���飡δ�ύ�쳣�������˺�(���˺�)��FAKEINFO013����XX����XX��FAKEINFO014����XX���������쳣�����������˺ţ���FAKEINFO015��FAKEINFO016��
      /*WITH company_user AS
       (SELECT f.company_id, f.user_id, f.company_user_name
          FROM scmdata.sys_company_user f
         INNER JOIN scmdata.sys_user su
            ON su.user_id = f.user_id),
      abn_bill AS
       (SELECT abn.company_id,
               abn.create_id,
               abn.progress_status,
               pr.product_gress_code
          FROM scmdata.t_abnormal abn
         INNER JOIN scmdata.t_production_progress pr
            ON abn.company_id = pr.company_id
           AND abn.order_id = pr.order_id
           AND abn.goo_id = pr.goo_id
         WHERE pr.product_gress_id = p_product_gress_id)
      SELECT '����ʧ�ܣ�����δ�ύ���������쳣���������飡' || listagg(v.handle_bill, ';') o_handle_bill
        INTO v_tips
        FROM (SELECT nvl2(a.product_gress_code || ',' ||
                          listagg(fc.company_user_name, '��'),
                          'δ�ύ�쳣�������˺ţ�' || a.product_gress_code || ',' ||
                          listagg(fc.company_user_name, '��'),
                          '') handle_bill
                FROM abn_bill a
               INNER JOIN company_user fc
                  ON fc.company_id = a.company_id
                 AND fc.user_id = a.create_id
               WHERE a.progress_status = '00'
               GROUP BY a.product_gress_code
              UNION ALL
              SELECT nvl2(listagg(DISTINCT a.product_gress_code, '��'),
                          '�������쳣������' ||
                          listagg(DISTINCT a.product_gress_code, '��'),
                          '') handle_bill
                FROM abn_bill a
               WHERE a.progress_status = '01') v;*/
    
      --�ģ�����ʧ�ܣ��˺ţ�A��B ����δ�ύ�쳣������FAKExxxx���˺ţ�A��B ���ڴ������쳣������FAKEXXX����������쳣����
    
      WITH company_user AS
       (SELECT f.company_id, f.user_id, f.company_user_name
          FROM scmdata.sys_company_user f
         INNER JOIN scmdata.sys_user su
            ON su.user_id = f.user_id),
      abn_bill AS
       (SELECT abn.company_id,
               abn.create_id,
               abn.progress_status,
               pr.product_gress_code
          FROM scmdata.t_abnormal abn
         INNER JOIN scmdata.t_production_progress pr
            ON abn.company_id = pr.company_id
           AND abn.order_id = pr.order_id
           AND abn.goo_id = pr.goo_id
         WHERE pr.product_gress_id = p_product_gress_id)
      SELECT '����ʧ�ܣ����飡' || listagg(v.handle_bill, '��') o_handle_bill
        INTO v_tips
        FROM (SELECT nvl2(a.product_gress_code || '��' ||
                          listagg(DISTINCT fc.company_user_name, '��'),
                          '�˺ţ�[' || listagg(fc.company_user_name, '��') ||
                          '],����δ�ύ�쳣������[' || a.product_gress_code || ']',
                          '') handle_bill
                FROM abn_bill a
               INNER JOIN company_user fc
                  ON fc.company_id = a.company_id
                 AND fc.user_id = a.create_id
               WHERE a.progress_status = '00'
               GROUP BY a.product_gress_code
              UNION ALL
              SELECT nvl2(a.product_gress_code || '��' ||
                          listagg(DISTINCT fc.company_user_name, '��'),
                          '�˺ţ�[' || listagg(fc.company_user_name, '��') ||
                          '],���ڴ������쳣������[' || a.product_gress_code || ']',
                          '') handle_bill
                FROM abn_bill a
               INNER JOIN company_user fc
                  ON fc.company_id = a.company_id
                 AND fc.user_id = a.create_id
               WHERE a.progress_status = '01'
               GROUP BY a.product_gress_code) v;
    
      raise_application_error(-20002, v_tips);
    END IF;
    --2. ����������У��ʵ������������2��ʱ������������ࡢ����ԭ����ࡢ����ԭ��ϸ�֡����������Ƿ�����д
    --���δ��ʱ����������ʧ�ܣ���ʾ�û�������������ʧ�ܣ�����ʵ������������2�죬����д'"����������ࡢ����ԭ����ࡢ����ԭ��ϸ�֡���������"����
    SELECT t.actual_delay_day,
           nvl2(t.delay_problem_class, 1, 0) +
           nvl2(t.delay_cause_class, 1, 0) +
           nvl2(t.delay_cause_detailed, 1, 0) + nvl2(t.problem_desc, 1, 0) dcount,
           t.delivery_amount,
           ci.category
      INTO v_actual_delay_day, v_count, v_delivery_amount, v_category
      FROM scmdata.t_production_progress t
     INNER JOIN scmdata.t_commodity_info ci
        ON ci.goo_id = t.goo_id
       AND ci.company_id = t.company_id
     WHERE t.product_gress_id = p_product_gress_id;
  
    --2.1 ���δ��ʱ����������ʧ�ܣ���ʾ�û�������������ʧ�ܣ�����ʵ������������2�죬����д'"����������ࡢ����ԭ����ࡢ����ԭ��ϸ�֡���������"������������
    --������ģ���������ʱ��ʵ������������0��ʱУ�顣
    --20220315�������󣬶�����ױ��Ʒ����������ӳ������<=1�����������������Զ�����Ϊ��������������������Ӱ�죬����
    IF v_count <> 4 THEN
      IF v_actual_delay_day > 0 THEN
        IF v_actual_delay_day <= 1 AND v_category IN ('06', '07') THEN
        
          SELECT MAX(ad.is_sup_exemption),
                 MAX(ad.first_dept_id),
                 MAX(ad.second_dept_id),
                 MAX(ad.is_quality_problem)
            INTO v_is_sup_exemption,
                 v_first_dept_id,
                 v_second_dept_id,
                 v_is_quality
            FROM scmdata.t_production_progress t
           INNER JOIN scmdata.t_commodity_info tc
              ON t.goo_id = tc.goo_id
             AND t.company_id = tc.company_id
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
           WHERE t.product_gress_id = p_product_gress_id
             AND ad.anomaly_classification = 'AC_DATE'
             AND ad.problem_classification = '��������'
             AND ad.cause_classification = '��������Ӱ��'
             AND ad.cause_detail = '����';
        
          UPDATE scmdata.t_production_progress a
             SET a.delay_problem_class  = '��������',
                 a.delay_cause_class    = '��������Ӱ��',
                 a.delay_cause_detailed = '����',
                 a.problem_desc         = '����',
                 a.is_sup_responsible   = v_is_sup_exemption,
                 a.responsible_dept     = v_first_dept_id,
                 a.responsible_dept_sec = v_second_dept_id,
                 a.is_quality           = v_is_quality
           WHERE a.product_gress_id = p_product_gress_id
             AND (nvl2(a.delay_problem_class, 1, 0) +
                 nvl2(a.delay_cause_class, 1, 0) +
                 nvl2(a.delay_cause_detailed, 1, 0) +
                 nvl2(a.problem_desc, 1, 0)) <> 4;
        ELSE
          raise_application_error(-20002,
                                  q'[��ʾ����������ʧ�ܣ���������ʧ��,����ʵ������������0������д,����������ࡢ����ԭ����ࡢ����ԭ��ϸ�֡�����������]');
        END IF;
      ELSIF v_delivery_amount = 0 THEN
        --�������󣺶���������Ϊ0ʱ����������������д��������
        raise_application_error(-20002,
                                q'[��ʾ����������ʧ�ܣ���������ʧ��,����������Ϊ0������д,����������ࡢ����ԭ����ࡢ����ԭ��ϸ�֡�����������]');
      ELSE
        NULL;
      END IF;
    ELSE
      NULL;
    END IF;
  
  END check_production_progress;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:12:27
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ������������
  * Obj_Name    : FINISH_PRODUCTION_PROGRESS
  * Arg_Number  : 2
  * P_PRODUCT_GRESS_ID : �����������
  * P_STATUS : ��������״̬
  * P_FINISH_TYPE :�������� '00'/null �ֶ�����  '01' �Զ�����
  *============================================*/
  PROCEDURE finish_production_progress(p_product_gress_id VARCHAR2,
                                       p_status           VARCHAR2,
                                       p_user_id          VARCHAR2 DEFAULT 'ADMIN',
                                       p_is_check         NUMBER DEFAULT 1,
                                       p_finish_type      VARCHAR2 DEFAULT '00') IS
    p_pro_rec        scmdata.t_production_progress%ROWTYPE;
    v_flag           NUMBER; --�Ƿ��� �쳣�����б�-�Ѵ����Ƿ�ۿ�Ϊ���ǡ����쳣����
    v_delivery_flag  NUMBER; --�Ƿ��н�����¼����ʵ�ʽ�����¼��
    v_suc_count      NUMBER; --�ö�������������������
    v_pr_tol         NUMBER; --�ö������������ܺ�
    v_discount_price NUMBER; --�ۿ���
    --v_order_amount     NUMBER; --������������ 
    v_order_price  NUMBER; --�����ۡ�ָ������Ʒ����
    v_arrival_date DATE; --�������ڣ�����ӡ����ʹ�ã�
    --p_deduction_amount NUMBER; --2022/3/16 zwh73 �����쳣�ۿ����� --20220506 ������������ȡֵ������쳣�����ġ��쳣��Χ������ͳ��
    v_abn_amount   NUMBER; --�쳣����
    v_alldr_amount NUMBER; --����ʵ�ʽ������ܺ�
  BEGIN
    --1.У����������,�Զ������������������У�麯��
    IF p_is_check = 1 THEN
      pkg_production_progress.check_production_progress(p_product_gress_id => p_product_gress_id);
    END IF;
    --2.��ȡ��������
    SELECT *
      INTO p_pro_rec
      FROM scmdata.t_production_progress t
     WHERE t.product_gress_id = p_product_gress_id;
  
    --3.��������
    IF p_pro_rec.progress_status <> p_status THEN
      UPDATE scmdata.t_production_progress t
         SET t.progress_status = '01'
       WHERE t.product_gress_id = p_product_gress_id;
    
      --4.�жϸö�����  �������������������������������ܺ�
      SELECT SUM(decode(pr.progress_status, '01', 1, 0)), COUNT(1)
        INTO v_suc_count, v_pr_tol
        FROM scmdata.t_production_progress pr
       WHERE pr.company_id = p_pro_rec.company_id
         AND pr.order_id = p_pro_rec.order_id;
    
      --����������������� = �������������ܺͣ�˵���������������Ѿ���������ö�������
      IF v_suc_count = v_pr_tol THEN
      
        --5.�޸Ķ�������ʱ��,�Լ�״̬,��������
        UPDATE scmdata.t_ordered po
           SET po.order_status    = 'OS02',
               po.finish_time_scm = SYSDATE,
               po.finish_type     = p_finish_type,
               po.finish_id       = p_user_id
         WHERE po.company_id = p_pro_rec.company_id
           AND po.order_code = p_pro_rec.order_id;
      
        --6.�ж��Ƿ��н�����¼������������Ӧ�ۿ ������������
        v_delivery_flag := check_delivery_record(p_pro_rec => p_pro_rec);
      
        --7.�ж��Ƿ��н�����¼��ʵ���ջ���¼������Ϊ0
        --��ʵ���ջ�������¼ʱ,�Զ������Ŀۿ
        --û��ʵ���ջ�������¼ʱ�������ɿۿ��¼
        IF v_delivery_flag = 1 THEN
          --8.�ж��Ƿ��� �쳣�����б�-�Ѵ����Ƿ�ۿ�Ϊ���ǡ����쳣����
          SELECT COUNT(1)
            INTO v_flag
            FROM scmdata.t_abnormal abn
           WHERE abn.company_id = p_pro_rec.company_id
             AND abn.order_id = p_pro_rec.order_id
             AND abn.progress_status = '02'
             AND abn.is_deduction = 1;
          --9.�����������ֶ������Ŀۿ(�����쳣�������쳣)
          IF v_flag > 0 THEN
            FOR p_abn_rec IN (SELECT abn.abnormal_id,
                                     abn.delay_date,
                                     abn.delay_amount,
                                     abn.anomaly_class,
                                     abn.deduction_unit_price,
                                     abn.deduction_method,
                                     abn.abnormal_range,
                                     abn.company_id,
                                     abn.order_id,
                                     abn.goo_id,
                                     abn.memo
                                FROM scmdata.t_abnormal abn
                               WHERE abn.company_id = p_pro_rec.company_id
                                 AND abn.order_id = p_pro_rec.order_id
                                 AND abn.progress_status = '02'
                                 AND abn.is_deduction = 1) LOOP
            
              --20220506 zxp czh ��������                   
              -- �쳣����Ϊ�����쳣/�����쳣���ҿۿʽΪ���ۿ��/�ۿ�������Ŀۿ����ȡֵ������쳣�����ġ��쳣��Χ������ͳ�ƣ�           
              --1) ���쳣��Χ��Ϊȫ����ȡ�������н���������
              SELECT SUM(dr.delivery_amount)
                INTO v_alldr_amount
                FROM scmdata.t_delivery_record dr
               WHERE dr.company_id = p_pro_rec.company_id
                 AND dr.order_code = p_pro_rec.order_id
                 AND dr.goo_id = p_pro_rec.goo_id;
              IF p_abn_rec.abnormal_range = '00' THEN
                --����ʵ���ջ�����
                v_abn_amount := v_alldr_amount;
                --2)  ���쳣��Χ��Ϊָ���������쳣�����ġ��쳣������ 
              ELSIF p_abn_rec.abnormal_range = '01' THEN
                --�ж��쳣�����Ƿ�<=�����������ܺ�
                IF p_abn_rec.delay_amount <= v_alldr_amount THEN
                  v_abn_amount := p_abn_rec.delay_amount;
                ELSE
                  v_abn_amount := v_alldr_amount;
                END IF;
              ELSE
                --3) ���쳣��Χ��Ϊ������ɫ��ȡ�쳣������ ���쳣��Χ����ɫ�Ľ��������ܺͣ�
                SELECT SUM(od.got_amount)
                  INTO v_abn_amount
                  FROM scmdata.t_ordersitem od
                 INNER JOIN scmdata.t_commodity_info tc
                    ON od.goo_id = tc.goo_id
                 INNER JOIN scmdata.t_commodity_color_size tcs
                    ON tc.commodity_info_id = tcs.commodity_info_id
                   AND od.barcode = tcs.barcode
                 WHERE od.goo_id = p_abn_rec.goo_id
                   AND od.order_id = p_abn_rec.order_id
                   AND od.company_id = p_abn_rec.company_id
                   AND instr(' ' || p_abn_rec.abnormal_range || ' ',
                             ' ' || tcs.color_code || ' ') > 0;
              END IF;
            
              --�����쳣����-�Ѵ����б�-�ѽ�������
              UPDATE scmdata.t_abnormal t
                 SET t.delivery_amount = v_abn_amount
               WHERE t.abnormal_id = p_abn_rec.abnormal_id;
            
              -- �������ڣ�����ӡ����ʹ�ã�
              SELECT MAX(dr.delivery_date)
                INTO v_arrival_date
                FROM scmdata.t_delivery_record dr
               WHERE dr.company_id = p_pro_rec.company_id
                 AND dr.order_code = p_pro_rec.order_id
                 AND dr.goo_id = p_pro_rec.goo_id
                 AND dr.delivery_amount > 0;
            
              --�����쳣�����쳣���࣬��ͬ�Ŀۿ�������ɲ�ͬ�ۿ
              --9.1�����쳣
              --��ҵ��Ҫ���쳣����Ϊ�����쳣���Ƿ�ۿ�Ϊ���ǡ����쳣�������ֶ������ۿ��ֻ���������쳣���쳣����
              --9.2�����쳣
              IF p_abn_rec.anomaly_class = 'AC_QUALITY' THEN
                --���ݿۿʽ���пۿ�
                --�����쳣�ۿ���ȡ����p_abn_rec.delay_amount
                --p_deduction_amount := p_abn_rec.delay_amount;
                IF p_abn_rec.deduction_method = 'METHOD_00' THEN
                  --�ۿʽΪ�ۿ�ۣ��ۿ���=ʵ�ʽ�������*�ۿ��
                  --20220316�������󣬸�Ϊ�ۿ���=�ۿ������*�ۿ��
                  --20220506 ������������ȡֵ������쳣�����ġ��쳣��Χ������ͳ��
                  v_discount_price := p_abn_rec.deduction_unit_price *
                                      v_abn_amount;
                ELSIF p_abn_rec.deduction_method = 'METHOD_01' THEN
                  --�ۿʽΪ�ۿ��ܶֱ��ȡ�ۿ���
                  v_discount_price := p_abn_rec.deduction_unit_price;
                ELSIF p_abn_rec.deduction_method = 'METHOD_02' THEN
                  --�ۿʽΪ�ۿ�������ۿ���=����*����*�ۿ�����������ۡ�ָ������Ʒ���ۣ�
                  --��Ʒ����
                  v_order_price := get_order_price(p_pro_rec => p_pro_rec);
                  --20220506 ������������ȡֵ������쳣�����ġ��쳣��Χ������ͳ��
                  v_discount_price := (v_abn_amount * v_order_price *
                                      p_abn_rec.deduction_unit_price) / 100;
                ELSE
                  NULL;
                END IF;
                --���ɿۿ
                sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                                  p_order_id           => p_pro_rec.order_id,
                                  p_goo_id             => p_pro_rec.goo_id,
                                  p_create_id          => p_pro_rec.create_id,
                                  p_delay_day          => p_abn_rec.delay_date, --��������
                                  p_delay_amount       => v_abn_amount, --20220506 ������������ȡֵ������쳣�����ġ��쳣��Χ������ͳ�� --����ԭ���߼���20220316���˻�ȥ������Ч����p_abn_rec.delay_amount, --�������� ����Ϊ���������쳣�������쳣��������ȡֵ������ʵ���ջ����� 
                                  p_order_price        => p_abn_rec.deduction_unit_price,
                                  p_discount_price     => v_discount_price, --�ۿ���
                                  p_act_discount_price => v_discount_price, --ʵ�ʿۿ���
                                  p_orgin              => 'MA', --��Դ ϵͳ���� SC / �ֶ����� MA
                                  p_arrival_date       => v_arrival_date,
                                  p_abnormal_id        => p_abn_rec.abnormal_id);
                --9.3�����쳣
              ELSIF p_abn_rec.anomaly_class = 'AC_OTHERS' THEN
                dbms_output.put_line(p_abn_rec.memo || ',' ||
                                     p_abn_rec.anomaly_class || ',' ||
                                     p_abn_rec.deduction_method);
                --���ݿۿʽ���пۿ�
                --�����쳣�ۿ���ȡ����
                IF p_abn_rec.deduction_method = 'METHOD_00' THEN
                  --�ۿʽΪ�ۿ�ۣ��ۿ���=ʵ�ʽ�������*�ۿ��
                  --20220316�������󣬸�Ϊ�ۿ���=�ۿ������*�ۿ��
                  --20220506 ������������ȡֵ������쳣�����ġ��쳣��Χ������ͳ��
                  v_discount_price := p_abn_rec.deduction_unit_price *
                                      v_abn_amount;
                ELSIF p_abn_rec.deduction_method = 'METHOD_01' THEN
                  --�ۿʽΪ�ۿ��ܶֱ��ȡ�ۿ���
                  v_discount_price := p_abn_rec.deduction_unit_price;
                ELSIF p_abn_rec.deduction_method = 'METHOD_02' THEN
                  --�ۿʽΪ�ۿ�������ۿ���=����*����*�ۿ�����������ۡ�ָ������Ʒ���ۣ�
                  --��Ʒ����
                  v_order_price := get_order_price(p_pro_rec => p_pro_rec);
                  --20220506 ������������ȡֵ������쳣�����ġ��쳣��Χ������ͳ��
                  v_discount_price := (v_abn_amount * v_order_price *
                                      p_abn_rec.deduction_unit_price) / 100;
                ELSE
                  NULL;
                END IF;
                --���ɿۿ
                sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                                  p_order_id           => p_pro_rec.order_id,
                                  p_goo_id             => p_pro_rec.goo_id,
                                  p_create_id          => p_pro_rec.create_id,
                                  p_delay_day          => p_abn_rec.delay_date, --��������
                                  p_delay_amount       => v_abn_amount, --20220506 ������������ȡֵ������쳣�����ġ��쳣��Χ������ͳ�� --����ԭ���߼���20220316���˻�ȥ������Ч����p_abn_rec.delay_amount, --�������� ����Ϊ���������쳣�������쳣��������ȡֵ������ʵ���ջ�����
                                  p_order_price        => p_abn_rec.deduction_unit_price,
                                  p_discount_price     => v_discount_price, --�ۿ���
                                  p_act_discount_price => v_discount_price, --ʵ�ʿۿ���
                                  p_orgin              => 'MA', --��Դ ϵͳ���� SC / �ֶ����� MA
                                  p_arrival_date       => v_arrival_date,
                                  p_abnormal_id        => p_abn_rec.abnormal_id);
              END IF;
            
            END LOOP;
            --11.�ж��Ƿ��пۿ���ϸ�������޸Ķ���-�ۿ����״̬-�����
            check_deductions(p_pro_rec.company_id, p_pro_rec.order_id);
          END IF;
        
          --12.�����������Զ������Ŀۿ (�����쳣)
          sync_deduction(p_pro_rec     => p_pro_rec,
                         p_orgin       => 'SC',
                         p_abnormal_id => '');
        
          --13.�ж��Ƿ��пۿ���ϸ�������޸Ķ���-�ۿ����״̬-�����
          check_deductions(p_pro_rec.company_id, p_pro_rec.order_id);
        ELSE
          NULL;
        END IF;
      END IF;
    ELSE
      --�����ظ�����ʾ��Ϣ
      raise_application_error(-20002, '�ѽ��������������������ظ�������');
    END IF;
  
  END finish_production_progress;
  --У���Ƿ��н�����¼
  FUNCTION check_delivery_record(p_pro_rec scmdata.t_production_progress%ROWTYPE)
    RETURN NUMBER IS
    v_flag            NUMBER;
    v_delivery_amount NUMBER;
  BEGIN
    SELECT COUNT(1), COUNT(dr.delivery_amount)
      INTO v_flag, v_delivery_amount
      FROM scmdata.t_delivery_record dr
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id;
    --�ж��Ƿ��н�����¼��ʵ���ջ���¼������Ϊ0
    --��ʵ���ջ�������¼ʱ,�Զ������Ŀۿ
    --û��ʵ���ջ�������¼ʱ�������ɿۿ��¼
    IF v_flag > 0 THEN
      IF v_delivery_amount > 0 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      RETURN 0;
    END IF;
  END;

  --�ж��Ƿ��пۿ���ϸ�������޸Ķ���-�ۿ����״̬-�����
  PROCEDURE check_deductions(p_company_id VARCHAR2, p_order_id VARCHAR2) IS
    v_deds_flag NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO v_deds_flag
      FROM scmdata.t_deduction td
     INNER JOIN scmdata.t_production_progress pr
        ON td.company_id = pr.company_id
       AND td.order_id = pr.order_id
     INNER JOIN scmdata.t_abnormal abn
        ON pr.company_id = abn.company_id
       AND pr.order_id = abn.order_id
       AND pr.goo_id = abn.goo_id
       AND td.abnormal_id = abn.abnormal_id
     WHERE td.company_id = p_company_id
       AND td.order_id = p_order_id;
  
    IF v_deds_flag > 0 THEN
      UPDATE scmdata.t_ordered po
         SET po.approve_status = '00'
       WHERE po.company_id = p_company_id
         AND po.order_code = p_order_id;
    ELSE
      NULL;
    END IF;
  
  END check_deductions;
  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:13:57
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ������¼����-ͬ�����������ȱ�
  * Obj_Name    : SYNC_DELIVERY_RECORD
  * Arg_Number  : 1
  * P_DELIVERY_REC :������¼
  *============================================*/
  PROCEDURE sync_delivery_record(p_delivery_rec scmdata.t_delivery_record%ROWTYPE) IS
    v_delivery_date   DATE; --ʵ�ʽ�������
    v_delay_day       NUMBER; --ʵ����������
    v_delivery_amount NUMBER; --��������
    v_order_date      DATE; --��������
    v_order_amount    NUMBER; --��������
    v_order_full_rate NUMBER;
  BEGIN
    --0.ԭʼ�������ڰ����ù������ת��=������ȷ������
    IF p_delivery_rec.delivery_origin_time = p_delivery_rec.delivery_date THEN
      tranf_deduction_config(p_delivery_rec => p_delivery_rec);
    END IF;
  
    --1.��������
    v_order_date := get_order_date(p_company_id => p_delivery_rec.company_id,
                                   p_order_code => p_delivery_rec.order_code,
                                   p_status     => 1);
    SELECT MAX(ln.order_amount)
      INTO v_order_amount
      FROM scmdata.t_orders ln
     WHERE ln.company_id = p_delivery_rec.company_id
       AND ln.order_id = p_delivery_rec.order_code
       AND ln.goo_id = p_delivery_rec.goo_id;
  
    IF v_order_amount IS NULL THEN
      RETURN;
    END IF;
  
    --2.ȡ���µĽ�������
    --3.��������,������¼�ġ��������������
    --4.���������ʣ�
    --1������������ = ������� / �������
    --2��������� = ��Ʒ���� * δ���ڵ�������������������¼�У��������� - �������� �� 2�Ľ�������������
    --3��������� = ��Ʒ���� * ��������
    SELECT MAX(trunc(td.delivery_date)),
           SUM(td.delivery_amount),
           (SUM(CASE
                  WHEN ceil(trunc(td.delivery_date) - v_order_date) <= 2 THEN
                   td.delivery_amount
                  ELSE
                   0
                END) * 100) / v_order_amount order_full_rate
      INTO v_delivery_date, v_delivery_amount, v_order_full_rate
      FROM scmdata.t_delivery_record td
     WHERE td.company_id = p_delivery_rec.company_id
       AND td.order_code = p_delivery_rec.order_code
       AND td.goo_id = p_delivery_rec.goo_id;
  
    --5.ʵ����������:ʵ�ʽ�������-��������,����0ʱ��ʾʵ�ʼ�������С��0ʱ��������Ϊ0
    --v_delay_day := nvl(ceil(v_delivery_date - v_order_date), 0);
    v_delay_day := get_delay_days(p_arrival_date => v_delivery_date,
                                  p_order_date   => v_order_date);
  
    --6.������������
    UPDATE t_production_progress t
       SET t.actual_delivery_date = v_delivery_date,
           t.actual_delay_day     = decode(sign(v_delay_day),
                                           -1,
                                           0,
                                           v_delay_day),
           t.delivery_amount      = nvl(v_delivery_amount, 0),
           t.order_full_rate      = nvl(v_order_full_rate, 0)
     WHERE t.company_id = p_delivery_rec.company_id
       AND t.order_id = p_delivery_rec.order_code
       AND t.goo_id = p_delivery_rec.goo_id;
  
  END sync_delivery_record;
  --У���쳣��������  ����ֵv_abnormal_config_id��ģ����
  FUNCTION check_abnormal_config(p_company_id VARCHAR2, p_goo_id VARCHAR2)
    RETURN VARCHAR2 IS
    v_abnormal_config_id VARCHAR2(100);
  BEGIN
    SELECT DISTINCT dr.abnormal_config_id
      INTO v_abnormal_config_id
      FROM scmdata.t_commodity_info tc
     INNER JOIN scmdata.t_abnormal_range_config dr
        ON tc.company_id = dr.company_id
       AND tc.category = dr.industry_classification
       AND tc.product_cate = dr.production_category
       AND instr(';' || dr.product_subclass || ';',
                 ';' || tc.samll_category || ';') > 0
       AND dr.pause = 0
     INNER JOIN scmdata.t_abnormal_dtl_config dc
        ON dr.company_id = dc.company_id
       AND dr.abnormal_config_id = dc.abnormal_config_id
       AND dc.pause = 0
     INNER JOIN scmdata.t_abnormal_config td
        ON td.company_id = dc.company_id
       AND td.abnormal_config_id = dc.abnormal_config_id
       AND td.pause = 0
     WHERE tc.company_id = p_company_id
       AND tc.goo_id = p_goo_id;
    RETURN v_abnormal_config_id;
  END check_abnormal_config;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:14:41
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : У���쳣��
  * Obj_Name    : CHECK_ABNORMAL
  * Arg_Number  : 1
  * P_ABN_REC :�쳣��
  *============================================*/

  PROCEDURE check_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
    v_order_amount NUMBER;
    v_total_cnt    NUMBER;
    v_cnt_0        NUMBER;
    v_cnt_1        NUMBER;
  BEGIN
    IF p_abn_rec.anomaly_class IS NOT NULL AND
       p_abn_rec.anomaly_class <> ' ' THEN
    
      --У���쳣����Ϊ�������쳣��ʱ,�����������
      IF p_abn_rec.anomaly_class = 'AC_DATE' THEN
      
        IF p_abn_rec.delay_date IS NULL THEN
          raise_application_error(-20002,
                                  '�쳣����Ϊ�������쳣��ʱ,�����������');
        END IF;
        --�쳣����Ϊ�������쳣��ʱ,�����������
        IF p_abn_rec.delay_amount IS NULL THEN
          raise_application_error(-20002,
                                  '�쳣����Ϊ�������쳣��ʱ,�����������');
        END IF;
        --�����쳣�Ƿ�ۿ����ѡ���񡱣�
        IF p_abn_rec.is_deduction = 1 THEN
          raise_application_error(-20002,
                                  '����ʧ�ܣ������쳣�Ƿ�ۿ����ѡ���񡱣�');
        
        END IF;
      END IF;
      --�����쳣���࣬У�������쳣/�����쳣�Ŀۿʽ
      IF p_abn_rec.anomaly_class = 'AC_QUALITY' THEN
        --20220505 zxp:�쳣�������쳣�����б��ۿʽ������ѡ��
        /*        IF p_abn_rec.deduction_method = 'METHOD_02' THEN
          raise_application_error(-20002,
                                  '�쳣����Ϊ�����쳣���쳣�����ۿʽֻ��ѡ��ۿ��/�ۿ��ܶ');
        END IF;*/
        --�˴����ĺ�QC��Ӧģ����Ҫ������У��
        IF p_abn_rec.detailed_reasons = ' ' OR
           p_abn_rec.handle_opinions = ' ' OR p_abn_rec.cause_class = ' ' OR
           p_abn_rec.cause_detailed = ' ' OR p_abn_rec.problem_class = ' ' THEN
          raise_application_error(-20002, '�������Ϊ�գ�');
        END IF;
        /*      ELSIF p_abn_rec.anomaly_class = 'AC_OTHERS' THEN
          IF p_abn_rec.deduction_method = 'METHOD_00' THEN
            raise_application_error(-20002,
                                    '�쳣����Ϊ�����쳣���쳣�����ۿʽֻ��ѡ��ۿ��ܶ�/�ۿ������');
          END IF;
        ELSE
          NULL;*/
      END IF;
    
      --������������Ϊ��
      IF p_abn_rec.detailed_reasons = ' ' THEN
        raise_application_error(-20002, '������������Ϊ�գ�');
      END IF;
      --20220316����������������Ϊ���ۿ��ջ������Ƿ�ۿ��ѡ����
      IF p_abn_rec.handle_opinions = '01' AND p_abn_rec.is_deduction = 0 THEN
        raise_application_error(-20002,
                                '������Ϊ���ۿ��ջ�ʱ���Ƿ�ۿ���ѡ����');
      END IF;
      --�Ƿ�ۿ�Ϊ���ǡ�ʱ,�ۿ�۱���
      IF p_abn_rec.is_deduction = 1 THEN
        IF p_abn_rec.deduction_method IS NULL THEN
          raise_application_error(-20002,
                                  '�Ƿ�ۿ�Ϊ���ǡ�ʱ,�ۿʽ���');
        ELSE
          IF p_abn_rec.deduction_unit_price IS NULL THEN
            raise_application_error(-20002,
                                    '�Ƿ�ۿ�Ϊ���ǡ�ʱ,�ۿ��/���/�������');
          END IF;
        END IF;
      END IF;
    
      --�����������ܴ��ڶ�������
      SELECT MAX(pln.order_amount)
        INTO v_order_amount
        FROM scmdata.t_ordered po
       INNER JOIN scmdata.t_orders pln
          ON po.company_id = pln.company_id
         AND po.order_code = pln.order_id
       WHERE pln.company_id = p_abn_rec.company_id
         AND pln.order_id = p_abn_rec.order_id
         AND pln.goo_id = p_abn_rec.goo_id;
    
      IF p_abn_rec.delay_amount > v_order_amount THEN
        raise_application_error(-20002, '�������ܴ��ڶ���������');
      END IF;
    
    ELSE
      raise_application_error(-20002, '�쳣���಻��Ϊ�գ�');
    END IF;
  
    IF p_abn_rec.abnormal_range IS NULL THEN
      raise_application_error(-20002,
                              '����ʧ�ܣ��쳣��Χ����Ϊ�գ����飡');
    END IF;
    
    --�쳣��ΧУ��
    SELECT regexp_count(p_abn_rec.abnormal_range, ' ') + 1 total_cnt,
           regexp_count(' ' || p_abn_rec.abnormal_range || ' ', ' 00 ') cnt_0,
           regexp_count(' ' || p_abn_rec.abnormal_range || ' ', ' 01 ') cnt_1
      INTO v_total_cnt, v_cnt_0, v_cnt_1
      FROM dual;
  
    IF v_total_cnt > 1 THEN
      IF v_cnt_0 = 1 OR v_cnt_1 = 1 THEN
        raise_application_error(-20002,
                                '����ʧ�ܣ��쳣��Χѡ��ȫ��/ָ����������ѡ��1�������ɶ�ѡ�����飡');
      ELSE
        NULL;
      END IF;
    ELSE
      NULL;
    END IF;
    --�쳣����У��
    IF p_abn_rec.delay_amount IS NULL AND p_abn_rec.abnormal_range = '01' THEN
      raise_application_error(-20002,
                              '����ʧ�ܣ����쳣��Χ��ѡ��ָ������������д"�쳣����"��');
    END IF;
  END check_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:14:41
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �����쳣��
  * Obj_Name    : handle_abnormal
  * Arg_Number  : 1
  * P_ABN_REC :�쳣��
  *============================================*/
  PROCEDURE handle_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
  
  BEGIN
    --У���쳣��
    --check_abnormal(p_abn_rec => p_abn_rec);
  
    INSERT INTO t_abnormal
      (abnormal_id,
       company_id,
       abnormal_code,
       order_id,
       progress_status,
       goo_id,
       anomaly_class,
       problem_class,
       cause_class,
       cause_detailed,
       detailed_reasons,
       is_sup_responsible,
       delay_date,
       delay_amount,
       responsible_party,
       responsible_dept,
       responsible_dept_sec,
       handle_opinions,
       quality_deduction,
       is_deduction,
       deduction_method,
       deduction_unit_price,
       file_id,
       applicant_id,
       applicant_date,
       confirm_id,
       confirm_company_id,
       confirm_date,
       create_id,
       create_time,
       update_id,
       update_time,
       origin,
       origin_id,
       memo,
       abnormal_range)
    VALUES
      (p_abn_rec.abnormal_id,
       p_abn_rec.company_id,
       p_abn_rec.abnormal_code,
       p_abn_rec.order_id,
       p_abn_rec.progress_status,
       p_abn_rec.goo_id,
       p_abn_rec.anomaly_class,
       p_abn_rec.problem_class,
       p_abn_rec.cause_class,
       p_abn_rec.cause_detailed,
       p_abn_rec.detailed_reasons,
       p_abn_rec.is_sup_responsible,
       p_abn_rec.delay_date,
       p_abn_rec.delay_amount,
       p_abn_rec.responsible_party,
       p_abn_rec.responsible_dept,
       p_abn_rec.responsible_dept_sec,
       p_abn_rec.handle_opinions,
       p_abn_rec.quality_deduction,
       p_abn_rec.is_deduction,
       p_abn_rec.deduction_method,
       p_abn_rec.deduction_unit_price,
       p_abn_rec.file_id,
       p_abn_rec.applicant_id,
       p_abn_rec.applicant_date,
       p_abn_rec.confirm_id,
       p_abn_rec.confirm_company_id,
       to_date(to_char(p_abn_rec.confirm_date, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
       p_abn_rec.create_id,
       p_abn_rec.create_time,
       p_abn_rec.update_id,
       p_abn_rec.update_time,
       p_abn_rec.origin,
       p_abn_rec.origin_id,
       p_abn_rec.memo,
       p_abn_rec.abnormal_range);
  
  END handle_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:14:41
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸��쳣��
  * Obj_Name    : update_abnormal
  * Arg_Number  : 1
  * P_ABN_REC :�쳣��
  *============================================*/
  PROCEDURE update_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
  
  BEGIN
    --У���쳣��
    check_abnormal(p_abn_rec => p_abn_rec);
  
    IF p_abn_rec.anomaly_class = 'AC_DATE' THEN
      UPDATE t_abnormal t
         SET t.delay_date           = p_abn_rec.delay_date,
             t.abnormal_range       = p_abn_rec.abnormal_range,
             t.delay_amount         = p_abn_rec.delay_amount,
             t.responsible_party    = p_abn_rec.responsible_party,
             t.handle_opinions      = p_abn_rec.handle_opinions,
             t.is_deduction         = p_abn_rec.is_deduction,
             t.deduction_method     = p_abn_rec.deduction_method,
             t.deduction_unit_price = round(p_abn_rec.deduction_unit_price,
                                            2),
             t.file_id              = p_abn_rec.file_id,
             t.applicant_id         = p_abn_rec.applicant_id,
             t.applicant_date       = p_abn_rec.applicant_date,
             t.memo                 = p_abn_rec.memo,
             t.update_id            = p_abn_rec.update_id,
             t.update_time          = p_abn_rec.update_time
       WHERE t.company_id = p_abn_rec.company_id
         AND t.abnormal_id = p_abn_rec.abnormal_id;
    ELSIF p_abn_rec.anomaly_class IN ('AC_QUALITY', 'AC_OTHERS') THEN
      UPDATE t_abnormal t
         SET t.problem_class        = p_abn_rec.problem_class,
             t.cause_class          = p_abn_rec.cause_class,
             t.cause_detailed       = p_abn_rec.cause_detailed,
             t.detailed_reasons     = p_abn_rec.detailed_reasons,
             t.delay_date           = p_abn_rec.delay_date,
             t.abnormal_range       = p_abn_rec.abnormal_range,
             t.delay_amount         = p_abn_rec.delay_amount,
             t.is_sup_responsible   = p_abn_rec.is_sup_responsible,
             t.responsible_party    = p_abn_rec.responsible_party,
             t.responsible_dept     = p_abn_rec.responsible_dept,
             t.responsible_dept_sec = p_abn_rec.responsible_dept_sec,
             t.handle_opinions      = p_abn_rec.handle_opinions,
             t.is_deduction         = p_abn_rec.is_deduction,
             t.deduction_method     = p_abn_rec.deduction_method,
             t.deduction_unit_price = round(p_abn_rec.deduction_unit_price,
                                            2),
             t.file_id              = p_abn_rec.file_id,
             t.applicant_id         = p_abn_rec.applicant_id,
             t.applicant_date       = p_abn_rec.applicant_date,
             t.memo                 = p_abn_rec.memo,
             t.update_id            = p_abn_rec.update_id,
             t.update_time          = p_abn_rec.update_time
       WHERE t.company_id = p_abn_rec.company_id
         AND t.abnormal_id = p_abn_rec.abnormal_id;
    ELSE
      NULL;
    END IF;
  
  END update_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:15:51
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �����������ȣ��쳣��״̬
  * Obj_Name    : SYNC_ABNORMAL
  * Arg_Number  : 2
  * P_ABN_REC : �쳣��
  * P_STATUS :��������-�쳣״̬
  *============================================*/

  PROCEDURE sync_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE,
                          p_status  VARCHAR2) IS
    v_handle_opinions VARCHAR2(100);
    v_flag            NUMBER;
  BEGIN
    --�����У���У���Ѵ����Ƿ���ڵ��ݣ���������ȡ�Ѵ������µ��ݵĴ�����
    IF p_status = '01' THEN
      SELECT MAX(t.handle_opinions)
        INTO v_handle_opinions
        FROM (SELECT abn.handle_opinions
                FROM scmdata.t_abnormal abn
               WHERE abn.company_id = p_abn_rec.company_id
                 AND abn.order_id = p_abn_rec.order_id
                 AND abn.goo_id = p_abn_rec.goo_id
                 AND abn.progress_status = '02'
               ORDER BY abn.create_time DESC) t
       WHERE rownum = 1;
    
      UPDATE scmdata.t_production_progress pr
         SET pr.exception_handle_status = p_status,
             pr.handle_opinions         = v_handle_opinions
       WHERE pr.company_id = p_abn_rec.company_id
         AND pr.order_id = p_abn_rec.order_id
         AND pr.goo_id = p_abn_rec.goo_id;
      --�Ѵ���
    ELSIF p_status = '02' THEN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_abnormal abn
       WHERE abn.company_id = p_abn_rec.company_id
         AND abn.order_id = p_abn_rec.order_id
         AND abn.goo_id = p_abn_rec.goo_id
         AND abn.progress_status = '01';
      --ͬһ�ŵ����ڶ����쳣����ʱ����Ҫȫ��ȷ���ˣ��������쳣״̬�ſɱ�Ϊ���Ѵ���
      IF v_flag = 0 THEN
        UPDATE scmdata.t_production_progress pr
           SET pr.exception_handle_status = p_status,
               pr.handle_opinions         = p_abn_rec.handle_opinions
         WHERE pr.company_id = p_abn_rec.company_id
           AND pr.order_id = p_abn_rec.order_id
           AND pr.goo_id = p_abn_rec.goo_id;
      END IF;
      --ɾ���쳣��
    ELSIF p_status = '00' THEN
      UPDATE scmdata.t_production_progress pr
         SET pr.exception_handle_status = p_status,
             pr.handle_opinions         = p_abn_rec.handle_opinions
       WHERE pr.company_id = p_abn_rec.company_id
         AND pr.order_id = p_abn_rec.order_id
         AND pr.goo_id = p_abn_rec.goo_id;
    END IF;
  END sync_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:16:45
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �ύ�쳣��
  * Obj_Name    : SUBMIT_ABNORMAL
  * Arg_Number  : 1
  * P_ABN_REC : �쳣��
  *============================================*/

  PROCEDURE submit_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
  
  BEGIN
    --У���쳣��
    check_abnormal(p_abn_rec => p_abn_rec);
  
    UPDATE t_abnormal t
       SET t.progress_status = '01'
     WHERE t.company_id = p_abn_rec.company_id
       AND t.abnormal_id = p_abn_rec.abnormal_id;
  
    --�����������ȣ��쳣��״̬
    sync_abnormal(p_abn_rec => p_abn_rec, p_status => '01');
  
  END submit_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:16:45
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : ȷ���쳣��
  * Obj_Name    : confirm_abnormal
  * Arg_Number  : 1
  * P_ABN_REC : �쳣��
  *============================================*/
  PROCEDURE confirm_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
  BEGIN
    --1.У���쳣��
    check_abnormal(p_abn_rec => p_abn_rec);
    --2.ȷ���쳣��
    UPDATE t_abnormal t
       SET t.progress_status    = '02',
           t.confirm_id         = p_abn_rec.confirm_id,
           t.confirm_company_id = p_abn_rec.confirm_company_id,
           t.confirm_date       = p_abn_rec.confirm_date
     WHERE t.company_id = p_abn_rec.company_id
       AND t.abnormal_id = p_abn_rec.abnormal_id;
  
    --3.�����������ȣ��쳣��״̬
    sync_abnormal(p_abn_rec => p_abn_rec, p_status => '02');
  
  END confirm_abnormal;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:16:45
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �����쳣��
  * Obj_Name    : revoke_abnormal
  * Arg_Number  : 1
  * P_ABN_REC : �쳣��
  *============================================*/
  PROCEDURE revoke_abnormal(p_abn_rec scmdata.t_abnormal%ROWTYPE) IS
    v_progress_status VARCHAR2(100);
  BEGIN
    SELECT MAX(pr.progress_status)
      INTO v_progress_status
      FROM scmdata.t_abnormal abn
     INNER JOIN scmdata.t_production_progress pr
        ON abn.company_id = pr.company_id
       AND abn.order_id = pr.order_id
       AND abn.goo_id = pr.goo_id
       AND abn.abnormal_id = p_abn_rec.abnormal_id;
    --���������������ɳ���
    IF v_progress_status = '01' THEN
      raise_application_error(-20002, '��ʾ����ѡ�����ѽ��������ɳ�����');
    END IF;
  
    UPDATE t_abnormal t
       SET t.progress_status = '01'
     WHERE t.company_id = p_abn_rec.company_id
       AND t.abnormal_id = p_abn_rec.abnormal_id;
  
    --�����������ȣ��쳣��״̬
    sync_abnormal(p_abn_rec => p_abn_rec, p_status => '01');
  
  END revoke_abnormal;

  --���������쳣��
  --1)v_abn_rec ��ѡ�쳣��
  --2)p_abnormal_code_cp �������쳣������
  PROCEDURE batch_copy_abnormal(p_company_id       VARCHAR2,
                                p_user_id          VARCHAR2, --��ʱ�ò���
                                v_abn_rec          scmdata.t_abnormal%ROWTYPE, --��ѡ�쳣��
                                p_abnormal_code_cp VARCHAR2) IS
    --�������쳣��
    v_abn_rec_cp scmdata.t_abnormal%ROWTYPE;
  BEGIN
    SELECT t.*
      INTO v_abn_rec_cp
      FROM scmdata.t_abnormal t
     WHERE t.company_id = p_company_id
          --AND t.create_id = p_user_id
       AND t.abnormal_code = p_abnormal_code_cp;
  
    --�����쳣��
    v_abn_rec_cp.abnormal_id  := v_abn_rec.abnormal_id;
    v_abn_rec_cp.order_id     := v_abn_rec.order_id;
    v_abn_rec_cp.delay_amount := v_abn_rec.delay_amount;
    update_abnormal(p_abn_rec => v_abn_rec_cp);
  END batch_copy_abnormal;

  --У��ڵ����
  PROCEDURE check_production_node(pno_rec scmdata.t_production_node%ROWTYPE) IS
    --v_pre_flag      NUMBER;
    --v_next_flag     NUMBER;
    --v_pre_node_num  NUMBER;
    v_next_node_num NUMBER;
    v_max_node_num  NUMBER;
    --v_flag NUMBER;
    v_next_plan_completion_time   DATE;
    v_next_actual_completion_time DATE;
    v_next_node_name              VARCHAR2(100);
    --v_pre_plan_completion_time  DATE;
    --v_pre_node_name             VARCHAR2(100);
    v_order_amount NUMBER;
    --v_complete_amount           NUMBER;
    v_plan_completion_time      DATE;
    v_actual_completion_time    DATE;
    v_jh_plan_completion_time   DATE;
    v_jh_actual_completion_time DATE;
  
  BEGIN
    --1.У�鵱ǰ�ڵ����һ�ڵ��Ƿ����
    --����2021-07-13������������󣺼ƻ��������ȥ����һ�ڵ���������һ�ڵ�Ŀ��ƣ�
    /* SELECT COUNT(1)
      INTO v_pre_flag
      FROM scmdata.t_production_node pn
     WHERE pn.company_id = pno_rec.company_id
       AND pn.product_gress_id = pno_rec.product_gress_id
       AND pn.node_num = pno_rec.node_num - 1;
    
    IF v_pre_flag > 0 THEN
    
      v_pre_node_num := pno_rec.node_num; --��ʼֵΪ��ǰ�ڵ�
    
      LOOP
        SELECT pn.plan_completion_time, pn.node_name
          INTO v_pre_plan_completion_time, v_pre_node_name
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pno_rec.company_id
           AND pn.product_gress_id = pno_rec.product_gress_id
           AND pn.node_num = v_pre_node_num - 1;
    
        --У�鵱ǰ�ڵ㲻������ǰһ�ڵ�����
        IF trunc(v_pre_plan_completion_time) >
           trunc(pno_rec.plan_completion_time) THEN
          raise_application_error(-20002,
                                  '��ǰ�ڵ㣺' || pno_rec.node_name ||
                                  '�����ڲ�������ǰ�ڵ�:' || v_pre_node_name ||
                                  '�����ڣ�');
        END IF;
        v_pre_node_num := v_pre_node_num - 1;
    
        EXIT WHEN v_pre_node_num = 1; --�������� �ڵ���Ϊ1���˳�
    
      END LOOP;
    
    ELSE
      NULL;
    END IF;
    
    --2.У�鵱ǰ�ڵ����һ�ڵ��Ƿ����
    SELECT COUNT(1)
      INTO v_next_flag
      FROM scmdata.t_production_node pn
     WHERE pn.company_id = pno_rec.company_id
       AND pn.product_gress_id = pno_rec.product_gress_id
       AND pn.node_num = pno_rec.node_num + 1;
    
    IF v_next_flag > 0 THEN
      --��ȡ���ڵ�
      SELECT MAX(pn.node_num)
        INTO v_max_node_num
        FROM scmdata.t_production_node pn
       WHERE pn.company_id = pno_rec.company_id
         AND pn.product_gress_id = pno_rec.product_gress_id;
    
      v_next_node_num := pno_rec.node_num; --��ʼֵΪ��ǰ�ڵ�
    
      LOOP
        SELECT pn.plan_completion_time, pn.node_name
          INTO v_next_plan_completion_time, v_next_node_name
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pno_rec.company_id
           AND pn.product_gress_id = pno_rec.product_gress_id
           AND pn.node_num = v_next_node_num + 1;
    
        --У�鵱ǰ�ڵ������Ƿ���ں�һ�ڵ�����
        IF trunc(pno_rec.plan_completion_time) >
           trunc(v_next_plan_completion_time) THEN
          raise_application_error(-20002,
                                  '��ǰ�ڵ㣺' || pno_rec.node_name ||
                                  '�����ڲ������ں�ڵ�:' || v_next_node_name ||
                                  '�����ڣ�');
        END IF;
    
        v_next_node_num := v_next_node_num + 1;
    
        EXIT WHEN v_next_node_num = v_max_node_num; --�������� �ڵ���Ϊ���ֵ���˳�
    
      END LOOP;
    
    ELSE
      NULL;
    END IF;*/
  
    --2.2021-07-13�������󣺼ƻ��������/ʵ���������-�����ڵ�����������нڵ㣨�����нڵ㲻�����ڼƻ��������/ʵ��������ڵĽ����ڵ㣩��
    v_plan_completion_time   := pno_rec.plan_completion_time;
    v_actual_completion_time := pno_rec.actual_completion_time;
    IF pno_rec.node_name = '����' THEN
      v_max_node_num := pno_rec.node_num;
      IF v_plan_completion_time IS NOT NULL THEN
        v_next_node_num := 1; --��ʼֵΪ�ڵ�1
        WHILE v_next_node_num < v_max_node_num LOOP
          SELECT MAX(pn.plan_completion_time),
                 MAX(pn.node_name),
                 MAX(pn.actual_completion_time)
            INTO v_next_plan_completion_time,
                 v_next_node_name,
                 v_next_actual_completion_time
            FROM scmdata.t_production_node pn
           WHERE pn.company_id = pno_rec.company_id
             AND pn.product_gress_id = pno_rec.product_gress_id
             AND pn.node_num = v_next_node_num;
        
          IF v_next_plan_completion_time IS NOT NULL THEN
            IF trunc(v_next_plan_completion_time) >
               trunc(v_plan_completion_time) THEN
              raise_application_error(-20002,
                                      '��ǰ�ڵ�[' || v_next_node_name ||
                                      ']�ļƻ�������ڲ������ڼƻ�������ڵĽ����ڵ㣡');
            END IF;
          ELSE
            NULL;
          END IF;
          IF v_next_actual_completion_time IS NOT NULL THEN
            IF trunc(v_next_actual_completion_time) >
               trunc(v_actual_completion_time) THEN
              raise_application_error(-20002,
                                      '��ǰ�ڵ�[' || v_next_node_name ||
                                      ']��ʵ��������ڲ�������ʵ��������ڵĽ����ڵ㣡');
            END IF;
          ELSE
            NULL;
          END IF;
          v_next_node_num := v_next_node_num + 1;
          --EXIT WHEN v_next_node_num = v_max_node_num; --�������� �ڵ���Ϊ���ֵ���˳�
        END LOOP;
      ELSE
        NULL;
      END IF;
    ELSE
      SELECT MAX(pn.plan_completion_time), MAX(pn.actual_completion_time)
        INTO v_jh_plan_completion_time, v_jh_actual_completion_time
        FROM scmdata.t_production_node pn
       WHERE pn.company_id = pno_rec.company_id
         AND pn.product_gress_id = pno_rec.product_gress_id
         AND pn.node_name = '����';
    
      IF v_jh_plan_completion_time IS NOT NULL THEN
        IF trunc(v_jh_plan_completion_time) < trunc(v_plan_completion_time) THEN
          raise_application_error(-20002,
                                  '��ǰ�ڵ�[' || pno_rec.node_name ||
                                  ']�ļƻ�������ڲ������ڼƻ�������ڵĽ����ڵ㣡');
        END IF;
      ELSE
        NULL;
      END IF;
      IF v_jh_plan_completion_time IS NOT NULL THEN
        IF trunc(v_jh_actual_completion_time) <
           trunc(v_actual_completion_time) THEN
          raise_application_error(-20002,
                                  '��ǰ�ڵ�[' || pno_rec.node_name ||
                                  ']��ʵ��������ڲ�������ʵ��������ڵĽ����ڵ㣡');
        END IF;
      ELSE
        NULL;
      END IF;
      NULL;
    END IF;
    --2021-07-28 ��������:��������ģ��-�Ż�����ά / ��������-�ӱ�-�ڵ�������Ӽƻ���ʼʱ��&ʵ�ʿ�ʼʱ��
    --����
    --1��ͬһ�ڵ��£����ƻ���ʼ&���������ֵʱ���ƻ���ʼ������ �� �ƻ�������ڣ�
    --2��ͬһ�ڵ��£����ƻ���ʼ&���������ֵʱ��ʵ�ʿ�ʼ������ �� ʵ��������ڣ�
    IF pno_rec.plan_start_time IS NOT NULL AND
       pno_rec.plan_completion_time IS NOT NULL THEN
      IF trunc(pno_rec.plan_start_time) >
         trunc(pno_rec.plan_completion_time) THEN
        raise_application_error(-20002,
                                'ͬһ�ڵ��£����ƻ���ʼ' || '&' ||
                                '���������ֵʱ���ƻ���ʼ������ �� �ƻ�������ڣ�');
      END IF;
    END IF;
  
    IF pno_rec.actual_start_time IS NOT NULL AND
       pno_rec.actual_completion_time IS NOT NULL THEN
      IF trunc(pno_rec.actual_start_time) >
         trunc(pno_rec.actual_completion_time) THEN
        raise_application_error(-20002,
                                'ͬһ�ڵ��£����ƻ���ʼ' || '&' ||
                                '���������ֵʱ��ʵ�ʿ�ʼ������ �� ʵ��������ڣ�');
      END IF;
    END IF;
  
    --3.У��ʵ��������ڣ������״̬��������һ�ֶ���ֵ������һ�ֶα���
    --2021-07-13��������ʵ�����������д����ݵ�ǰʱ�䣻
    IF pno_rec.actual_completion_time IS NOT NULL THEN
      IF pno_rec.progress_status IS NULL OR pno_rec.progress_status <> '01' THEN
        raise_application_error(-20002,
                                'ʵ�����������ֵ���ڵ����״̬��ѡ������ɡ���');
      END IF;
      IF trunc(pno_rec.actual_completion_time) > trunc(SYSDATE) THEN
        raise_application_error(-20002, 'ʵ�����������д����<=��ǰʱ��!');
      ELSE
        NULL;
      END IF;
    END IF;
    IF pno_rec.progress_status = '01' THEN
      IF pno_rec.actual_completion_time IS NULL THEN
        raise_application_error(-20002,
                                '�ڵ����״̬Ϊ������ɡ���ʵ��������ڱ��');
      END IF;
    END IF;
  
    --4.У������������ܴ��ڶ�������
    SELECT pr.order_amount
      INTO v_order_amount
      FROM scmdata.t_production_progress pr
     WHERE pr.product_gress_id = pno_rec.product_gress_id;
  
    IF pno_rec.complete_amount > v_order_amount THEN
      raise_application_error(-20002,
                              '����������ܴ��ڸ����������Ķ���������');
    END IF;
  
  END check_production_node;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:17:52
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �����ڵ����
  * Obj_Name    : INSERT_PRODUCTION_NODE
  * Arg_Number  : 1
  * PNO_REC :�ڵ����
  *============================================*/

  PROCEDURE insert_production_node(pno_rec scmdata.t_production_node%ROWTYPE) IS
  BEGIN
    INSERT INTO t_production_node
      (product_node_id,
       company_id,
       product_gress_id,
       product_node_code,
       node_num,
       node_name,
       time_ratio,
       target_completion_time,
       plan_completion_time,
       actual_completion_time,
       complete_amount,
       progress_status,
       progress_say,
       update_id,
       update_date,
       create_id,
       create_time,
       memo)
    VALUES
      (pno_rec.product_node_id,
       pno_rec.company_id,
       pno_rec.product_gress_id,
       pno_rec.product_node_code,
       pno_rec.node_num,
       pno_rec.node_name,
       pno_rec.time_ratio,
       trunc(pno_rec.target_completion_time),
       trunc(pno_rec.plan_completion_time),
       trunc(pno_rec.actual_completion_time),
       pno_rec.complete_amount,
       pno_rec.progress_status,
       pno_rec.progress_say,
       pno_rec.update_id,
       pno_rec.update_date,
       pno_rec.create_id,
       pno_rec.create_time,
       pno_rec.memo);
  
  END insert_production_node;
  --����Ԥ�⽻��
  PROCEDURE get_forecast_delivery_date(p_company_id          VARCHAR2,
                                       p_product_gress_id    VARCHAR2,
                                       p_progress_status     VARCHAR2,
                                       po_forecast_date      OUT DATE,
                                       po_plan_complete_date OUT DATE) IS
    v_plan_completion_time   DATE;
    v_actual_completion_time DATE;
    v_delivery_date          DATE; --��������
    v_product_cycle          NUMBER; --��������
    v_node_cycle             NUMBER := 0; --ʣ��δ��ɽڵ�Ľڵ�����
    v_node_num               NUMBER := 0; --�ڵ����
  BEGIN
    --�������� �����������µ�����Ϊͬһ�죬�������������Ϊ1,���� �������� = ��������-�ӵ�����
    SELECT trunc(po.delivery_date),
           decode(trunc(po.delivery_date),
                  trunc(po.create_time),
                  1,
                  ceil(trunc(po.delivery_date) - trunc(po.create_time)))
      INTO v_delivery_date, v_product_cycle
      FROM scmdata.t_ordered po
     INNER JOIN scmdata.t_orders pln
        ON po.company_id = pln.company_id
       AND po.order_code = pln.order_id
     INNER JOIN scmdata.t_production_progress pr
        ON pln.company_id = pr.company_id
       AND pln.order_id = pr.order_id
       AND pln.goo_id = pr.goo_id
     WHERE pr.company_id = p_company_id
       AND pr.product_gress_id = p_product_gress_id;
  
    --2.2 Ԥ�⽻��  B ��������״̬Ϊδ��ʼ���ƻ����������ֵʱ��Ԥ�⽻��=�ƻ�������ڣ���������
    SELECT MAX(trunc(pn.plan_completion_time))
      INTO v_plan_completion_time
      FROM scmdata.t_production_node pn
     WHERE pn.company_id = p_company_id
       AND pn.product_gress_id = p_product_gress_id
       AND pn.node_name = '����';
  
    IF p_progress_status = '00' THEN
      IF v_plan_completion_time IS NULL THEN
        po_forecast_date := v_delivery_date; --��������
      ELSE
        po_forecast_date := v_plan_completion_time; --�ƻ�������ڣ�������
      END IF;
    ELSE
      --2.3 C ��������״̬Ϊ�����У�Ԥ�⽻��=���½ڵ�ʵ���������+ʣ��δ��ɽڵ�Ľڵ����� .
      --�����Ϊ�����У���ȡ�ƻ�������ڣ�������/��������
      --2.4��������״̬Ϊ�����У��ҵ�ǰ�����ѳ����ƻ�������ڣ���Ԥ�⽻��=���½ڵ�ʵ���������+ʣ��δ��ɽڵ�Ľڵ�����+���ƻ������������
      --���ƻ������������= ��ǰ���� - ��ǰ�ڵ�ƻ��������
      SELECT MAX(trunc(actual_completion_time)),
             MAX(node_num),
             MAX(trunc(plan_completion_time))
        INTO v_actual_completion_time, v_node_num, po_plan_complete_date
        FROM (SELECT pn.actual_completion_time,
                     pn.node_num,
                     pn.plan_completion_time
                FROM scmdata.t_production_node pn
               WHERE pn.company_id = p_company_id
                 AND pn.product_gress_id = p_product_gress_id
                 AND pn.progress_status = '01' --01 �����
               ORDER BY pn.node_num DESC)
       WHERE rownum = 1;
      --ʣ��δ��ɽڵ�Ľڵ�����.
      --�ڵ�����=��������*�ýڵ���ʱռ��
      --��������=��������-�ӵ�����
      FOR pn_data IN (SELECT pn.time_ratio
                        FROM scmdata.t_production_node pn
                       WHERE pn.company_id = p_company_id
                         AND pn.product_gress_id = p_product_gress_id
                         AND pn.node_num > v_node_num
                         AND (pn.progress_status = '00' OR
                             pn.progress_status IS NULL)) LOOP
        --00 �ڵ������ۼ���֮���ٽ���ȡ��
        v_node_cycle := nvl(v_node_cycle +
                            v_product_cycle * pn_data.time_ratio * 0.01,
                            0);
      END LOOP;
    
      po_forecast_date := nvl((v_actual_completion_time +
                              ceil(v_node_cycle)),
                              nvl(v_plan_completion_time, v_delivery_date));
    
    END IF;
  
  END get_forecast_delivery_date;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:17:52
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �޸Ľڵ����  ,�˴��漰�������ȱ��ֶα仯�߼�
  * Obj_Name    : update_production_node
  * Arg_Number  : 1
  * PNO_REC :�ڵ����
  * p_status :0:����  1���������Ƶ��� ����У��ڵ����
  *============================================*/
  PROCEDURE update_production_node(pno_rec  scmdata.t_production_node%ROWTYPE,
                                   p_status NUMBER DEFAULT 0) IS
    p_produ_rec           t_production_progress%ROWTYPE; --��������
    vo_forecast_date      DATE;
    vo_plan_complete_date DATE;
    v_over_plan_days      NUMBER;
  BEGIN
    --У��ڵ����
    IF p_status = 0 THEN
      check_production_node(pno_rec => pno_rec);
    END IF;
  
    --1.�޸Ľڵ����
    UPDATE t_production_node t
       SET t.plan_completion_time   = trunc(pno_rec.plan_completion_time),
           t.actual_completion_time = trunc(pno_rec.actual_completion_time),
           t.plan_start_time        = trunc(pno_rec.plan_start_time),
           t.actual_start_time      = trunc(pno_rec.actual_start_time),
           t.complete_amount        = pno_rec.complete_amount,
           t.progress_status        = pno_rec.progress_status,
           t.progress_say           = pno_rec.progress_say,
           t.update_id              = pno_rec.update_id,
           t.update_date            = pno_rec.update_date,
           t.operator               = pno_rec.operator
     WHERE t.product_node_id = pno_rec.product_node_id;
  
    --2.�������ȱ��ֶ���ڵ�����ֶα仯�߼�
    --������������
    p_produ_rec.product_gress_id := pno_rec.product_gress_id;
  
    --2.1 ��������״̬���м�ڵ�״̬��ȡ�ڵ����״̬���һ���ǿյ�״ֵ̬��չʾ���ڵ�����+����״̬�� �������ò�ѯitem
    /*    SELECT nvl((SELECT pno_status
               FROM (SELECT pn.node_name || a.group_dict_name pno_status
                       FROM scmdata.t_production_node pn
                      INNER JOIN scmdata.sys_group_dict a
                         ON a.group_dict_value = pn.progress_status
                      INNER JOIN scmdata.sys_group_dict b
                         ON a.group_dict_type = b.group_dict_value
                        AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                      WHERE pn.company_id = pno_rec.company_id
                        AND pn.product_gress_id = pno_rec.product_gress_id
                        AND pn.progress_status IS NOT NULL
                      ORDER BY pn.node_num DESC)
              WHERE rownum = 1),
             '00') pno_status
    INTO p_produ_rec.progress_status
    FROM dual;*/
  
    --�޸��ֶ�progress_status�����ݿⰴ���� 00��δ��ʼ��01������ɣ�02����������ʽ�洢����
    SELECT nvl2(MAX(pno_status), '02', '00')
      INTO p_produ_rec.progress_status
      FROM (SELECT pn.node_name || a.group_dict_name pno_status
              FROM scmdata.t_production_node pn
             INNER JOIN scmdata.sys_group_dict a
                ON a.group_dict_value = pn.progress_status
             INNER JOIN scmdata.sys_group_dict b
                ON a.group_dict_type = b.group_dict_value
               AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
             WHERE pn.company_id = pno_rec.company_id
               AND pn.product_gress_id = pno_rec.product_gress_id
               AND pn.progress_status IS NOT NULL
             ORDER BY pn.node_num DESC)
     WHERE rownum = 1;
  
    --��ȡԤ�⽻��
    vo_forecast_date := calc_forecast_delivery_date(p_company_id       => pno_rec.company_id,
                                                    p_product_gress_id => pno_rec.product_gress_id,
                                                    p_status           => p_produ_rec.progress_status);
  
    --�ɹ����߼�����
    get_forecast_delivery_date(p_company_id          => pno_rec.company_id,
                               p_product_gress_id    => pno_rec.product_gress_id,
                               p_progress_status     => p_produ_rec.progress_status,
                               po_forecast_date      => vo_forecast_date,
                               po_plan_complete_date => vo_plan_complete_date);
  
    --��������״̬Ϊ�����У��ҵ�ǰ�����ѳ����ƻ�������ڣ���Ԥ�⽻��=���½ڵ�ʵ���������+ʣ��δ��ɽڵ�Ľڵ�����+���ƻ������������
    v_over_plan_days := trunc(SYSDATE) -
                        nvl(trunc(vo_plan_complete_date), trunc(SYSDATE));
    IF v_over_plan_days > 0 THEN
      p_produ_rec.forecast_delivery_date := vo_forecast_date +
                                            v_over_plan_days;
    ELSE
      p_produ_rec.forecast_delivery_date := vo_forecast_date;
    END IF;
    --���¼ƻ�����  =�ƻ�������ڣ������� ��Ƽ/���� ����û����
    --p_produ_rec.latest_planned_delivery_date := vo_plan_complete_date;
  
    --p_produ_rec.forecast_delivery_date := vo_forecast_date;
  
    --3.�����������ȱ�
    update_production_progress(p_produ_rec => p_produ_rec);
  
  END update_production_node;
  --�޸Ķ�����ע
  PROCEDURE update_ordered(po_rec scmdata.t_ordered%ROWTYPE) IS
  BEGIN
    UPDATE scmdata.t_ordered po
       SET po.memo_dedu        = po_rec.memo_dedu,
           po.update_id_dedu  =
           (SELECT fc.company_user_name
              FROM scmdata.sys_company_user fc
             WHERE fc.company_id = po_rec.company_id
               AND fc.user_id = po_rec.update_id_dedu),
           po.update_time_dedu = po_rec.update_time_dedu
     WHERE po.company_id = po_rec.company_id
       AND po.order_id = po_rec.order_id;
  END update_ordered;
  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:19:01
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �ۿ���
  * Obj_Name    : APPROVE_ORDERS
  * Arg_Number  : 1
  * PO_REC :����ͷ
  *============================================*/

  PROCEDURE approve_orders(po_rec scmdata.t_ordered%ROWTYPE) IS
  BEGIN
    IF po_rec.approve_status = '00' THEN
      UPDATE scmdata.t_ordered po
         SET po.approve_status = '01',
             po.approve_id     = po_rec.approve_id,
             po.approve_time   = po_rec.approve_time
       WHERE po.company_id = po_rec.company_id
         AND po.order_id = po_rec.order_id;
    END IF;
  END;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:19:01
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �ۿ�������
  * Obj_Name    : revoke_approve_orders
  * Arg_Number  : 1
  * PO_REC :����ͷ
  *============================================*/
  PROCEDURE revoke_approve_orders(po_rec scmdata.t_ordered%ROWTYPE) IS
  BEGIN
    IF po_rec.approve_status = '01' THEN
      UPDATE scmdata.t_ordered po
         SET po.approve_status = '00',
             po.approve_id     = po_rec.approve_id,
             po.approve_time   = po_rec.approve_time
       WHERE po.company_id = po_rec.company_id
         AND po.order_id = po_rec.order_id;
    END IF;
  END revoke_approve_orders;

  --��ȡ��������
  FUNCTION get_delay_days(p_arrival_date DATE, p_order_date DATE)
    RETURN NUMBER IS
    v_delay_days NUMBER;
  BEGIN
    v_delay_days := nvl(to_number(trunc(p_arrival_date) -
                                  trunc(p_order_date)),
                        0);
    RETURN v_delay_days;
  END get_delay_days;

  --��ȡ��������
  --1.�������ȱ��еĶ�������ȡ�µ��б�Ķ������ڣ�����è�Ľ������ڣ�
  --2.�������ȱ��е����¼ƻ�����ȡ�µ��б�����¼ƻ����ڣ�����è���½������ڣ�
  FUNCTION get_order_date(p_company_id VARCHAR2,
                          p_order_code VARCHAR2,
                          p_status     NUMBER) RETURN DATE IS
    v_delivery_date DATE;
  BEGIN
    IF p_status = 1 THEN
      SELECT MAX(po.delivery_date)
        INTO v_delivery_date
        FROM scmdata.t_ordered po
       WHERE po.company_id = p_company_id
         AND po.order_code = p_order_code;
      RETURN v_delivery_date;
    ELSIF p_status = 2 THEN
      SELECT MAX(pn.delivery_date)
        INTO v_delivery_date
        FROM scmdata.t_orders pn
       WHERE pn.company_id = p_company_id
         AND pn.order_id = p_order_code;
      RETURN v_delivery_date;
    ELSE
      RETURN NULL;
    END IF;
  
  END get_order_date;

  --��ȡ��Ʒ����
  FUNCTION get_order_price(p_pro_rec scmdata.t_production_progress%ROWTYPE)
    RETURN NUMBER IS
    v_order_price NUMBER;
  BEGIN
    SELECT nvl(MAX(ln.order_price), 0)
      INTO v_order_price --��Ʒ����
      FROM scmdata.t_orders ln
     WHERE ln.company_id = p_pro_rec.company_id
       AND ln.order_id = p_pro_rec.order_id;
  
    RETURN v_order_price;
  
  END get_order_price;

  --��ȡʵ�۽��
  --2022-02-21 �������� ����ԭ�򡰹�Ӧ���Ƿ�����Ϊ�ǵĶ������ۿ���ϸ���������Զ���ֵΪ�����Ŀۿ���
  FUNCTION get_actual_discount_price(p_is_sup         NUMBER, --��Ӧ���Ƿ�����
                                     p_discount_price NUMBER) RETURN NUMBER IS
  BEGIN
    --ʵ�ʿۿ���=�ۿ���+�������
    IF p_is_sup = 1 THEN
      RETURN 0;
    ELSE
      RETURN p_discount_price + 0;
    END IF;
  
  END get_actual_discount_price;
  --��ȡ�ۿ���/�ۿ���������ݶ�����Ʒ����ҵ����+�������+��Ʒ���ࣩ����������ƥ����Ӧ�ۿ����
  PROCEDURE get_deduction(p_company_id       VARCHAR2,
                          p_goo_id           VARCHAR2,
                          p_delay_day        NUMBER,
                          po_deduction_type  OUT VARCHAR2,
                          po_deduction_money OUT NUMBER) IS
    v_deduction_type  VARCHAR2(100);
    v_deduction_ratio NUMBER;
    v_deduction_money NUMBER;
  BEGIN
  
    SELECT MAX(dc.deduction_type),
           nvl(MAX(dc.deduction_money), -1),
           nvl(MAX(dc.deduction_ratio) * 0.01, -1)
      INTO v_deduction_type, v_deduction_money, v_deduction_ratio
      FROM scmdata.t_commodity_info tc
     INNER JOIN scmdata.t_deduction_range_config dr
        ON tc.company_id = dr.company_id
       AND tc.category = dr.industry_classification
       AND tc.product_cate = dr.production_category
       AND instr(';' || dr.product_subclass || ';',
                 ';' || tc.samll_category || ';') > 0
       AND dr.pause = 0
     INNER JOIN scmdata.t_deduction_dtl_config dc
        ON dr.company_id = dc.company_id
       AND dr.deduction_config_id = dc.deduction_config_id
       AND dc.pause = 0
     INNER JOIN scmdata.t_deduction_config td
        ON td.company_id = dc.company_id
       AND td.deduction_config_id = dc.deduction_config_id
       AND td.pause = 0
     WHERE tc.company_id = p_company_id
       AND tc.goo_id = p_goo_id
       AND (p_delay_day >= dc.section_start AND
           p_delay_day < dc.section_end);
  
    po_deduction_type := v_deduction_type;
  
    --�ۿ��ܶ�
    IF v_deduction_type = 'METHOD_01' THEN
      po_deduction_money := v_deduction_money;
      --�ۿ����
    ELSIF v_deduction_type = 'METHOD_02' THEN
      po_deduction_money := v_deduction_ratio;
    ELSE
      NULL;
    END IF;
  END get_deduction;

  --��������һ����ϲ�������1���ۿ
  PROCEDURE get_date_same_deduction(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE,
                                    p_orgin         VARCHAR2,
                                    p_abnormal_id   VARCHAR2) IS
    v_delay_day          NUMBER;
    v_order_price        NUMBER;
    v_deduction_type     VARCHAR2(100);
    v_deduction_money    NUMBER;
    v_discount_price     NUMBER;
    v_act_discount_price NUMBER;
    --�������ڣ��������ڣ���������һ�µĽ�����¼  ���Ż�
    CURSOR p_date_cur(p_order_date DATE) IS
      SELECT DISTINCT trunc(dr.delivery_date) delivery_date,
                      dr.company_id,
                      dr.order_code,
                      dr.goo_id,
                      SUM(dr.delivery_amount) over(PARTITION BY trunc(dr.delivery_date)) delivery_amount_sum
        FROM scmdata.t_delivery_record dr
       WHERE dr.company_id = p_pro_rec.company_id
         AND dr.order_code = p_pro_rec.order_id
         AND dr.goo_id = p_pro_rec.goo_id
         AND trunc(dr.delivery_date) > trunc(p_order_date)
         AND dr.delivery_amount <> 0
         AND EXISTS
       (SELECT 1
                FROM scmdata.t_delivery_record t
               WHERE dr.company_id = t.company_id
                 AND dr.order_code = t.order_code
                 AND dr.goo_id = t.goo_id
                 AND dr.delivery_record_id <> t.delivery_record_id
                 AND trunc(dr.delivery_date) = trunc(t.delivery_date));
  BEGIN
    FOR p_date_rec IN p_date_cur(p_delivery_date) LOOP
      --�����������������������=������¼��������-��������
      --v_delay_day := ceil(p_date_rec.delivery_date - p_delivery_date);
      v_delay_day := get_delay_days(p_arrival_date => p_date_rec.delivery_date,
                                    p_order_date   => p_delivery_date);
    
      --�ж����������Ƿ��ڿۿ�������
      --��ȡ�ۿ���/�ۿ����
      get_deduction(p_company_id       => p_pro_rec.company_id,
                    p_goo_id           => p_pro_rec.goo_id,
                    p_delay_day        => v_delay_day,
                    po_deduction_type  => v_deduction_type,
                    po_deduction_money => v_deduction_money);
    
      --8.2 �����㣺���ݶ�����Ʒ����ҵ����+�������+��Ʒ���ࣩ����������ƥ����Ӧ�ۿ����
      --�ۿ���
      IF v_deduction_type = 'METHOD_01' THEN
        --8.2.1 �ۿ���=��������*��Ʒ����*�ۿ����
        v_discount_price := v_deduction_money;
      
        --8.2.2 ʵ�ʿۿ���=�ۿ���+�������
        --v_act_discount_price := v_discount_price + 0;
        v_act_discount_price := get_actual_discount_price(p_is_sup         => p_pro_rec.is_sup_responsible,
                                                          p_discount_price => v_discount_price);
        --�ۿ����
      ELSIF v_deduction_type = 'METHOD_02' THEN
      
        --��Ʒ����
        v_order_price := get_order_price(p_pro_rec => p_pro_rec);
      
        --8.2.3 �ۿ���=��������*��Ʒ����*�ۿ����
        v_discount_price := p_date_rec.delivery_amount_sum * v_order_price *
                            v_deduction_money;
      
        --8.2.4 ʵ�ʿۿ���=�ۿ���+�������
        --v_act_discount_price := v_discount_price + 0;
        v_act_discount_price := get_actual_discount_price(p_is_sup         => p_pro_rec.is_sup_responsible,
                                                          p_discount_price => v_discount_price);
      ELSE
        NULL;
      END IF;
    
      IF v_deduction_type IS NULL THEN
        NULL;
      ELSE
        --8.2.5 �����쳣��,���ɿۿ
        sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                          p_order_id           => p_pro_rec.order_id,
                          p_goo_id             => p_pro_rec.goo_id,
                          p_create_id          => p_pro_rec.create_id,
                          p_deduction_type     => v_deduction_type,
                          p_delay_day          => v_delay_day, --��������
                          p_delay_amount       => p_date_rec.delivery_amount_sum, --��������
                          p_is_sup             => p_pro_rec.is_sup_responsible, --��Ӧ���Ƿ�����
                          p_order_price        => v_order_price,
                          p_discount_price     => v_discount_price, --�ۿ���
                          p_act_discount_price => v_act_discount_price, --ʵ�ʿۿ���
                          p_orgin              => p_orgin, --��Դ ϵͳ���� SC / �ֶ����� MA
                          p_arrival_date       => p_date_rec.delivery_date,
                          p_abnormal_id        => p_abnormal_id); --�쳣����ţ��ֶ�������������Ϊ��
      END IF;
    
    END LOOP;
  END get_date_same_deduction;

  --�������ڲ�һ�£�����1���ۿ
  PROCEDURE get_date_nsame_deduction(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                     p_delivery_date DATE,
                                     p_orgin         VARCHAR2,
                                     p_abnormal_id   VARCHAR2) IS
    v_delay_day          NUMBER;
    v_order_price        NUMBER;
    v_deduction_type     VARCHAR2(100);
    v_deduction_money    NUMBER;
    v_discount_price     NUMBER;
    v_act_discount_price NUMBER;
    --�������ڣ��������ڣ��������ڲ�һ�µĽ�����¼ ���Ż�
    CURSOR p_date_not_cur(p_order_date DATE) IS
      SELECT dr.delivery_record_id,
             dr.delivery_amount,
             trunc(dr.delivery_date) delivery_date
        FROM scmdata.t_delivery_record dr
       WHERE dr.company_id = p_pro_rec.company_id
         AND dr.order_code = p_pro_rec.order_id
         AND dr.goo_id = p_pro_rec.goo_id
         AND dr.delivery_record_id NOT IN
             (SELECT dr.delivery_record_id
                FROM scmdata.t_delivery_record dr
               INNER JOIN scmdata.t_delivery_record t
                  ON dr.company_id = t.company_id
                 AND dr.order_code = t.order_code
                 AND dr.goo_id = t.goo_id
                 AND dr.delivery_record_id <> t.delivery_record_id
                 AND trunc(dr.delivery_date) = trunc(t.delivery_date)
               WHERE dr.company_id = p_pro_rec.company_id
                 AND dr.order_code = p_pro_rec.order_id
                 AND dr.goo_id = p_pro_rec.goo_id
                 AND trunc(dr.delivery_date) > trunc(p_order_date))
         AND trunc(dr.delivery_date) > trunc(p_order_date)
         AND dr.delivery_amount <> 0;
  BEGIN
    FOR p_date_not_rec IN p_date_not_cur(p_delivery_date) LOOP
    
      --�����������������������=������¼��������-��������
      --v_delay_day := ceil(p_date_not_rec.delivery_date - p_delivery_date);
      v_delay_day := get_delay_days(p_arrival_date => p_date_not_rec.delivery_date,
                                    p_order_date   => p_delivery_date);
    
      --�ж����������Ƿ��ڿۿ�������
      --��ȡ�ۿ����
      get_deduction(p_company_id       => p_pro_rec.company_id,
                    p_goo_id           => p_pro_rec.goo_id,
                    p_delay_day        => v_delay_day,
                    po_deduction_type  => v_deduction_type,
                    po_deduction_money => v_deduction_money);
    
      --8.4 �����㣺���ݶ�����Ʒ����ҵ����+�������+��Ʒ���ࣩ����������ƥ����Ӧ�ۿ����
      --�ۿ���
      IF v_deduction_type = 'METHOD_01' THEN
        --8.4.1 �ۿ���=�ۿ���
        v_discount_price := v_deduction_money;
        --8.4.2 ʵ�ʿۿ���=�ۿ���+�������
        --v_act_discount_price := v_discount_price + 0;
        v_act_discount_price := get_actual_discount_price(p_is_sup         => p_pro_rec.is_sup_responsible,
                                                          p_discount_price => v_discount_price);
        --�ۿ����
      ELSIF v_deduction_type = 'METHOD_02' THEN
        --��Ʒ����
        v_order_price := get_order_price(p_pro_rec => p_pro_rec);
      
        --8.4.3 �ۿ���=��������*��Ʒ����*�ۿ����
        v_discount_price := p_date_not_rec.delivery_amount * v_order_price *
                            v_deduction_money;
      
        --8.4.4 ʵ�ʿۿ���=�ۿ���+�������
        --v_act_discount_price := v_discount_price + 0;
        v_act_discount_price := get_actual_discount_price(p_is_sup         => p_pro_rec.is_sup_responsible,
                                                          p_discount_price => v_discount_price);
      ELSE
        NULL;
      END IF;
      IF v_deduction_type IS NULL THEN
        NULL;
      ELSE
        --8.5 �����쳣��,���ɿۿ
        sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                          p_order_id           => p_pro_rec.order_id,
                          p_goo_id             => p_pro_rec.goo_id,
                          p_create_id          => p_pro_rec.create_id,
                          p_deduction_type     => v_deduction_type,
                          p_delay_day          => v_delay_day, --��������
                          p_delay_amount       => p_date_not_rec.delivery_amount, --��������
                          p_is_sup             => p_pro_rec.is_sup_responsible, --��Ӧ���Ƿ�����
                          p_order_price        => v_order_price,
                          p_discount_price     => v_discount_price, --�ۿ���
                          p_act_discount_price => v_act_discount_price, --ʵ�ʿۿ���
                          p_orgin              => p_orgin, --��Դ ϵͳ���� SC / �ֶ����� MA
                          p_arrival_date       => p_date_not_rec.delivery_date,
                          p_abnormal_id        => p_abnormal_id); --�쳣����ţ��ֶ�������������Ϊ��
      END IF;
    
    END LOOP;
  END get_date_nsame_deduction;
  --У�鵽�����ڵ�һ����
  FUNCTION check_delivery_date_same(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE) RETURN NUMBER IS
    v_date_count NUMBER;
  BEGIN
    --�н�����¼ʱ���������ڣ��������ڵĽ�����¼����Ӧ���ɶ�Ӧ�����Ŀۿ
    --�������ڿۿ�������ü�������¼������1����ſۿ
    --�жϵ��������Ƿ�һ��
    SELECT COUNT(1)
      INTO v_date_count
      FROM scmdata.t_delivery_record dr
     INNER JOIN scmdata.t_delivery_record t
        ON dr.company_id = t.company_id
       AND dr.order_code = t.order_code
       AND dr.goo_id = t.goo_id
       AND dr.delivery_record_id <> t.delivery_record_id
       AND trunc(dr.delivery_date) = trunc(t.delivery_date)
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id
       AND trunc(dr.delivery_date) > p_delivery_date;
    IF v_date_count > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END check_delivery_date_same;

  --У�鲻һ�µĵ�������
  FUNCTION check_delivery_date_nsame(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                     p_delivery_date DATE) RETURN NUMBER IS
    v_date_not_count NUMBER;
  BEGIN
    --�н�����¼ʱ���������ڣ��������ڵĽ�����¼����Ӧ���ɶ�Ӧ�����Ŀۿ
    --�������ڿۿ�������ü�������¼������1����ſۿ
    --�жϵ��������Ƿ�һ��
    SELECT COUNT(1)
      INTO v_date_not_count
      FROM scmdata.t_delivery_record dr
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id
       AND dr.delivery_record_id NOT IN
           (SELECT dr.delivery_record_id
              FROM scmdata.t_delivery_record dr
             INNER JOIN scmdata.t_delivery_record t
                ON dr.company_id = t.company_id
               AND dr.order_code = t.order_code
               AND dr.goo_id = t.goo_id
               AND dr.delivery_record_id <> t.delivery_record_id
               AND trunc(dr.delivery_date) = trunc(t.delivery_date)
             WHERE dr.company_id = p_pro_rec.company_id
               AND dr.order_code = p_pro_rec.order_id
               AND dr.goo_id = p_pro_rec.goo_id
               AND trunc(dr.delivery_date) > p_delivery_date)
       AND trunc(dr.delivery_date) > p_delivery_date;
    IF v_date_not_count > 0 THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END check_delivery_date_nsame;

  ----��������һ����ϲ�������1���ۿ(����)
  PROCEDURE get_uwmax_date_same_deduction(p_pro_rec           scmdata.t_production_progress%ROWTYPE,
                                          p_delivery_date     DATE,
                                          p_orgin             VARCHAR2,
                                          p_abnormal_id       VARCHAR2,
                                          p_max_delivery_date DATE) IS
    v_delay_day          NUMBER;
    v_order_price        NUMBER;
    v_deduction_type     VARCHAR2(100);
    v_deduction_money    NUMBER;
    v_discount_price     NUMBER;
    v_act_discount_price NUMBER;
    --�������ڣ��������ڣ���������һ�µĽ�����¼  ���Ż�
    CURSOR p_date_cur(p_order_date DATE) IS
      SELECT DISTINCT trunc(dr.delivery_date) delivery_date,
                      dr.company_id,
                      dr.order_code,
                      dr.goo_id,
                      SUM(dr.delivery_amount) over(PARTITION BY trunc(dr.delivery_date)) delivery_amount_sum
        FROM scmdata.t_delivery_record dr
       WHERE dr.company_id = p_pro_rec.company_id
         AND dr.order_code = p_pro_rec.order_id
         AND dr.goo_id = p_pro_rec.goo_id
         AND trunc(dr.delivery_date) > trunc(p_order_date)
         AND dr.delivery_amount <> 0
         AND trunc(dr.delivery_date) = trunc(p_max_delivery_date);
  BEGIN
    FOR p_date_rec IN p_date_cur(p_delivery_date) LOOP
      --�����������������������=������¼��������-��������
      --v_delay_day := ceil(p_date_rec.delivery_date - p_delivery_date);
      v_delay_day := get_delay_days(p_arrival_date => p_date_rec.delivery_date,
                                    p_order_date   => p_delivery_date);
      --�ж����������Ƿ��ڿۿ�������
      --��ȡ�ۿ���/�ۿ����
      get_deduction(p_company_id       => p_pro_rec.company_id,
                    p_goo_id           => p_pro_rec.goo_id,
                    p_delay_day        => v_delay_day,
                    po_deduction_type  => v_deduction_type,
                    po_deduction_money => v_deduction_money);
    
      --8.2 �����㣺���ݶ�����Ʒ����ҵ����+�������+��Ʒ���ࣩ����������ƥ����Ӧ�ۿ����
      --�ۿ���
      IF v_deduction_type = 'METHOD_01' THEN
        --8.2.1 �ۿ���=��������*��Ʒ����*�ۿ����
        v_discount_price := v_deduction_money;
      
        --8.2.2 ʵ�ʿۿ���=�ۿ���+�������
        --v_act_discount_price := v_discount_price + 0;
        v_act_discount_price := get_actual_discount_price(p_is_sup         => p_pro_rec.is_sup_responsible,
                                                          p_discount_price => v_discount_price);
        --�ۿ����
      ELSIF v_deduction_type = 'METHOD_02' THEN
      
        --��Ʒ����
        v_order_price := get_order_price(p_pro_rec => p_pro_rec);
      
        --8.2.3 �ۿ���=��������*��Ʒ����*�ۿ����
        v_discount_price := p_date_rec.delivery_amount_sum * v_order_price *
                            v_deduction_money;
      
        --8.2.4 ʵ�ʿۿ���=�ۿ���+�������
        --v_act_discount_price := v_discount_price + 0;
        v_act_discount_price := get_actual_discount_price(p_is_sup         => p_pro_rec.is_sup_responsible,
                                                          p_discount_price => v_discount_price);
      ELSE
        NULL;
      END IF;
    
      IF v_deduction_type IS NULL THEN
        NULL;
      ELSE
        --8.2.5 �����쳣��,���ɿۿ
        sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                          p_order_id           => p_pro_rec.order_id,
                          p_goo_id             => p_pro_rec.goo_id,
                          p_create_id          => p_pro_rec.create_id,
                          p_deduction_type     => v_deduction_type,
                          p_delay_day          => v_delay_day, --��������
                          p_delay_amount       => p_date_rec.delivery_amount_sum, --��������
                          p_is_sup             => p_pro_rec.is_sup_responsible, --��Ӧ���Ƿ�����
                          p_order_price        => v_order_price,
                          p_discount_price     => v_discount_price, --�ۿ���
                          p_act_discount_price => v_act_discount_price, --ʵ�ʿۿ���
                          p_orgin              => p_orgin, --��Դ ϵͳ���� SC / �ֶ����� MA
                          p_arrival_date       => p_date_rec.delivery_date,
                          p_abnormal_id        => p_abnormal_id); --�쳣����ţ��ֶ�������������Ϊ��
      END IF;
    
    END LOOP;
  END get_uwmax_date_same_deduction;

  --�������ڲ�һ�£�����1���ۿ(����)
  PROCEDURE get_uwmax_date_nsame_deduction(p_pro_rec           scmdata.t_production_progress%ROWTYPE,
                                           p_delivery_date     DATE,
                                           p_orgin             VARCHAR2,
                                           p_abnormal_id       VARCHAR2,
                                           p_max_delivery_date DATE) IS
    v_delay_day          NUMBER;
    v_order_price        NUMBER;
    v_deduction_type     VARCHAR2(100);
    v_deduction_money    NUMBER;
    v_discount_price     NUMBER;
    v_act_discount_price NUMBER;
    v_delivery_amount    NUMBER;
  
  BEGIN
    /*    SELECT dr.delivery_amount
     INTO v_delivery_amount
     FROM scmdata.t_delivery_record dr
    WHERE dr.company_id = p_pro_rec.company_id
      AND dr.order_code = p_pro_rec.order_id
      AND dr.goo_id = p_pro_rec.goo_id
      AND trunc(dr.delivery_date) = trunc(p_max_delivery_date);*/
  
    --�����������������������=������¼��������-��������
    --v_delay_day := trunc(p_max_delivery_date) - trunc(p_delivery_date);
    v_delay_day := get_delay_days(p_arrival_date => p_max_delivery_date,
                                  p_order_date   => p_delivery_date);
  
    --�ж����������Ƿ��ڿۿ�������
    --��ȡ�ۿ����
    get_deduction(p_company_id       => p_pro_rec.company_id,
                  p_goo_id           => p_pro_rec.goo_id,
                  p_delay_day        => v_delay_day,
                  po_deduction_type  => v_deduction_type,
                  po_deduction_money => v_deduction_money);
  
    --8.4 �����㣺���ݶ�����Ʒ����ҵ����+�������+��Ʒ���ࣩ����������ƥ����Ӧ�ۿ����
    --�ۿ���
    IF v_deduction_type = 'METHOD_01' THEN
      --8.4.1 �ۿ���=�ۿ���
      v_discount_price := v_deduction_money;
      --8.4.2 ʵ�ʿۿ���=�ۿ���+�������
      --v_act_discount_price := v_discount_price + 0;
      v_act_discount_price := get_actual_discount_price(p_is_sup         => p_pro_rec.is_sup_responsible,
                                                        p_discount_price => v_discount_price);
      --�ۿ����
    ELSIF v_deduction_type = 'METHOD_02' THEN
      --��Ʒ����
      v_order_price := get_order_price(p_pro_rec => p_pro_rec);
    
      SELECT MAX(dr.delivery_amount)
        INTO v_delivery_amount
        FROM scmdata.t_delivery_record dr
       WHERE dr.company_id = p_pro_rec.company_id
         AND dr.order_code = p_pro_rec.order_id
         AND dr.goo_id = p_pro_rec.goo_id
         AND trunc(dr.delivery_date) = trunc(p_max_delivery_date);
    
      --8.4.3 �ۿ���=��������*��Ʒ����*�ۿ����
      v_discount_price := v_delivery_amount * v_order_price *
                          v_deduction_money;
    
      --8.4.4 ʵ�ʿۿ���=�ۿ���+�������
      --v_act_discount_price := v_discount_price + 0;
      v_act_discount_price := get_actual_discount_price(p_is_sup         => p_pro_rec.is_sup_responsible,
                                                        p_discount_price => v_discount_price);
    ELSE
      RETURN;
    END IF;
    IF v_deduction_type IS NULL THEN
      NULL;
    ELSE
      --8.5 �����쳣��,���ɿۿ
      sync_abn_ded_bill(p_company_id         => p_pro_rec.company_id,
                        p_order_id           => p_pro_rec.order_id,
                        p_goo_id             => p_pro_rec.goo_id,
                        p_create_id          => p_pro_rec.create_id,
                        p_deduction_type     => v_deduction_type,
                        p_delay_day          => v_delay_day, --��������
                        p_delay_amount       => v_delivery_amount, --��������
                        p_is_sup             => p_pro_rec.is_sup_responsible, --��Ӧ���Ƿ�����
                        p_order_price        => v_order_price,
                        p_discount_price     => v_discount_price, --�ۿ���
                        p_act_discount_price => v_act_discount_price, --ʵ�ʿۿ���
                        p_orgin              => p_orgin, --��Դ ϵͳ���� SC / �ֶ����� MA
                        p_arrival_date       => trunc(p_max_delivery_date),
                        p_abnormal_id        => p_abnormal_id); --�쳣����ţ��ֶ�������������Ϊ��
    END IF;
  
  END get_uwmax_date_nsame_deduction;

  --����-ȡ��ٵĽ�����¼,������1�����ڿۿ�
  PROCEDURE get_uwmax_delivery_date(p_pro_rec       scmdata.t_production_progress%ROWTYPE,
                                    p_delivery_date DATE,
                                    p_orgin         VARCHAR2,
                                    p_abnormal_id   VARCHAR2) IS
    v_max_delivery_date DATE;
    v_date_count        NUMBER;
  BEGIN
    --��ȡ��ٵĽ�����¼
    SELECT MAX(DISTINCT dr.delivery_date)
      INTO v_max_delivery_date
      FROM scmdata.t_delivery_record dr
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id;
  
    --�жϵ��������Ƿ�һ��
    SELECT COUNT(1)
      INTO v_date_count
      FROM scmdata.t_delivery_record dr
     INNER JOIN scmdata.t_delivery_record t
        ON dr.company_id = t.company_id
       AND dr.order_code = t.order_code
       AND dr.goo_id = t.goo_id
       AND dr.delivery_record_id <> t.delivery_record_id
       AND trunc(dr.delivery_date) = trunc(t.delivery_date)
     WHERE dr.company_id = p_pro_rec.company_id
       AND dr.order_code = p_pro_rec.order_id
       AND dr.goo_id = p_pro_rec.goo_id
       AND trunc(dr.delivery_date) > p_delivery_date
       AND dr.delivery_date = v_max_delivery_date;
    --�絽������һ����ϲ�Ϊ1���ۿ��
    IF v_date_count > 0 THEN
      get_uwmax_date_same_deduction(p_pro_rec           => p_pro_rec,
                                    p_delivery_date     => p_delivery_date,
                                    p_orgin             => p_orgin,
                                    p_abnormal_id       => p_abnormal_id,
                                    p_max_delivery_date => v_max_delivery_date);
      --�������ڲ�һ�£���������һ�ۿ
    ELSE
      get_uwmax_date_nsame_deduction(p_pro_rec           => p_pro_rec,
                                     p_delivery_date     => p_delivery_date,
                                     p_orgin             => p_orgin,
                                     p_abnormal_id       => p_abnormal_id,
                                     p_max_delivery_date => v_max_delivery_date);
    END IF;
  END get_uwmax_delivery_date;

  --ԭʼ�������ڰ����ù������ת��=������ȷ������
  PROCEDURE transform_delivery_date(p_delivery_rec          scmdata.t_delivery_record%ROWTYPE,
                                    p_deduction_change_time DATE) IS
    v_deadline_time     VARCHAR2(32); --���ڱ����ֹʱ��
    v_deadline_date     VARCHAR2(32); --ԭʼ��������
    v_deadline_dtime    DATE;
    v_deadline_dtime_bf DATE;
    v_deadline_dtime_af DATE;
    v_transform_date    DATE; --ת����ĵ���ȷ������
  BEGIN
    v_deadline_date := to_char(trunc(p_delivery_rec.delivery_origin_time),
                               'yyyy-mm-dd');
    v_deadline_time := to_char(p_deduction_change_time, 'hh24:mi:ss');
    --����v_deadline_time
    v_deadline_dtime := to_date(v_deadline_date || ' ' || v_deadline_time,
                                'yyyy-mm-dd hh24:mi:ss');
    --ǰһ��v_deadline_time
    v_deadline_dtime_bf := v_deadline_dtime - 1;
    --��һ��v_deadline_time
    v_deadline_dtime_af := v_deadline_dtime + 1;
    --�ж�ԭʼ���������Ƿ�������
    --ע������ȷ������ ֻ���Ƶ����ڣ��˺����ɿۿ��߼������������ڼ���
    --1������(ǰһ��v_deadline_time,����v_deadline_time]������ȷ�����ڣ�ǰһ��
    --2������(����v_deadline_time,��һ��v_deadline_time]������ȷ�����ڣ�����
    IF p_delivery_rec.delivery_origin_time > v_deadline_dtime_bf AND
       p_delivery_rec.delivery_origin_time <= v_deadline_dtime THEN
    
      v_transform_date := trunc(v_deadline_dtime_bf);
    
    ELSIF p_delivery_rec.delivery_origin_time > v_deadline_dtime AND
          p_delivery_rec.delivery_origin_time <= v_deadline_dtime_af THEN
    
      v_transform_date := trunc(v_deadline_dtime);
    
    ELSE
      raise_application_error(-20002,
                              'ԭʼ�������ڰ����ù������ת���ɵ���ȷ������ʧ�ܣ�����ϵ����Ա����');
    END IF;
  
    UPDATE scmdata.t_delivery_record dr
       SET dr.delivery_date = v_transform_date
     WHERE dr.delivery_record_id = p_delivery_rec.delivery_record_id;
  
  END transform_delivery_date;

  --ת��ԭʼ��������=������ȷ������
  PROCEDURE tranf_deduction_config(p_delivery_rec scmdata.t_delivery_record%ROWTYPE) IS
    vo_count                 NUMBER;
    vo_deduction_change_time DATE; --���ڱ����ֹʱ��
  BEGIN
    --1. ������Ʒ����ҵ����+�������+��Ʒ���ࣩ�����ڿۿ����������һģ��ƥ�䣻
    check_deduction_config(p_company_id       => p_delivery_rec.company_id,
                           p_goo_id           => p_delivery_rec.goo_id,
                           p_status           => 1,
                           po_count           => vo_count,
                           po_ded_change_time => vo_deduction_change_time);
  
    IF vo_count > 0 AND vo_deduction_change_time IS NOT NULL THEN
      --�����ڱ����ֹʱ��  ת��ԭʼ��������=������ȷ������
      transform_delivery_date(p_delivery_rec          => p_delivery_rec,
                              p_deduction_change_time => vo_deduction_change_time);
    ELSE
      --��ת�����򣬲��������ӿ�ͬ��ʱ������ȷ������ Ĭ�ϵ��� ԭʼ��������
      NULL;
    END IF;
  
  END tranf_deduction_config;

  --������Ʒ����ҵ����+�������+��Ʒ���ࣩ�����ڿۿ����������һģ��ƥ��
  PROCEDURE check_deduction_config(p_company_id       VARCHAR2,
                                   p_goo_id           VARCHAR2,
                                   p_status           NUMBER,
                                   po_count           OUT NUMBER,
                                   po_ded_change_time OUT DATE) IS
    v_count           NUMBER;
    v_ded_change_time DATE;
  BEGIN
    SELECT COUNT(1), MAX(td.deduction_change_time)
      INTO v_count, v_ded_change_time
      FROM scmdata.t_commodity_info tc
     INNER JOIN scmdata.t_deduction_range_config dr
        ON tc.company_id = dr.company_id
       AND tc.category = dr.industry_classification
       AND tc.product_cate = dr.production_category
       AND instr(';' || dr.product_subclass || ';',
                 ';' || tc.samll_category || ';') > 0
       AND dr.pause = 0
     INNER JOIN scmdata.t_deduction_dtl_config dc
        ON dr.company_id = dc.company_id
       AND dr.deduction_config_id = dc.deduction_config_id
       AND dc.pause = 0
     INNER JOIN scmdata.t_deduction_config td
        ON td.company_id = dc.company_id
       AND td.deduction_config_id = dc.deduction_config_id
       AND td.pause = 0
     WHERE tc.company_id = p_company_id
       AND tc.goo_id = p_goo_id;
  
    IF p_status = 0 THEN
      po_count           := v_count;
      po_ded_change_time := NULL;
    ELSIF p_status = 1 THEN
      po_count           := v_count;
      po_ded_change_time := v_ded_change_time;
    ELSE
      NULL;
    END IF;
  
  END check_deduction_config;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:19:42
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �Զ������Ŀۿ
  * Obj_Name    : SYNC_DEDUCTION
  * Arg_Number  : 3
  * P_PRO_REC : ��������
  * P_ORGIN : ��Դ ϵͳ���� SC / �ֶ����� MA
  * P_ABNORMAL_ID : �쳣����ţ��ֶ�������������Ϊ��
  *============================================*/

  PROCEDURE sync_deduction(p_pro_rec     scmdata.t_production_progress%ROWTYPE,
                           p_orgin       VARCHAR2, --��Դ ϵͳ���� SC / �ֶ����� MA
                           p_abnormal_id VARCHAR2) IS
    --�쳣����ţ��ֶ�������������Ϊ��
    vo_count           NUMBER;
    vo_ded_change_time DATE;
    --v_order_price    NUMBER;
    v_category       VARCHAR2(100);
    v_delivery_date  DATE;
    v_date_count     NUMBER;
    v_date_not_count NUMBER;
  
  BEGIN
    --��������
    SELECT trunc(po.delivery_date)
      INTO v_delivery_date
      FROM scmdata.t_ordered po
     WHERE po.company_id = p_pro_rec.company_id
       AND po.order_code = p_pro_rec.order_id;
  
    /*    --��Ʒ����
    SELECT ln.order_price
      INTO v_order_price --��Ʒ����
      FROM scmdata.t_orders ln
     WHERE p_pro_rec.company_id = ln.company_id
       AND p_pro_rec.order_id = ln.order_id;*/
    --AND p_pro_rec.goo_id = ln.goo_id; ע��ԭ��ҵ����ģ��ֶ�������Ʒ��һ��һ��ϵ��ȡ������Ʒ����
  
    --1. ������Ʒ����ҵ����+�������+��Ʒ���ࣩ�����ڿۿ����������һģ��ƥ��������ɣ������ɵ��쳣����Ϊ�������쳣����
    check_deduction_config(p_company_id       => p_pro_rec.company_id,
                           p_goo_id           => p_pro_rec.goo_id,
                           p_status           => 0,
                           po_count           => vo_count,
                           po_ded_change_time => vo_ded_change_time);
  
    --2. ���ڿۿ����������ʱ��������,������ʱ�������²���
    IF vo_count > 0 THEN
      SELECT tc.category
        INTO v_category
        FROM scmdata.t_commodity_info tc
       WHERE tc.company_id = p_pro_rec.company_id
         AND tc.goo_id = p_pro_rec.goo_id;
    
      --3.�������·ֲ��ۿ��������ֲ��ۿʽ��ͬ������ͨ���ڿۿ�-���·ֲ���������������Ĵ���
      --�������ఴԭ������
      IF v_category <> '03' THEN
        --4.�н�����¼ʱ���������ڣ��������ڵĽ�����¼����Ӧ���ɶ�Ӧ�����Ŀۿ
        -- �������ڿۿ�������ü�������¼������1����ſۿ
        --�жϵ��������Ƿ�һ��
        v_date_count := check_delivery_date_same(p_pro_rec       => p_pro_rec,
                                                 p_delivery_date => v_delivery_date);
      
        --5.�絽������һ����ϲ�Ϊ1���ۿ��
        IF v_date_count > 0 THEN
        
          get_date_same_deduction(p_pro_rec       => p_pro_rec,
                                  p_delivery_date => v_delivery_date,
                                  p_orgin         => p_orgin,
                                  p_abnormal_id   => p_abnormal_id);
        END IF;
      
        v_date_not_count := check_delivery_date_nsame(p_pro_rec       => p_pro_rec,
                                                      p_delivery_date => v_delivery_date);
      
        --6.�������ڲ�һ�£���������һ�ۿ
        IF v_date_not_count > 0 THEN
          get_date_nsame_deduction(p_pro_rec       => p_pro_rec,
                                   p_delivery_date => v_delivery_date,
                                   p_orgin         => p_orgin,
                                   p_abnormal_id   => p_abnormal_id);
        END IF;
      
      ELSE
        --1��������1�����ڿۿ
        --2��ȡ��ٵĽ�����¼���������������ڶ�����¼������ͬ��¼��ԭ�й�����кϲ���
        --3��������Ʒ������+��������+��Ʒ���ࣩ+����������ƥ�����ڿۿ����ý��м���ۿƥ����򼰼��������ԭ�й���һ�£���
        get_uwmax_delivery_date(p_pro_rec       => p_pro_rec,
                                p_delivery_date => v_delivery_date,
                                p_orgin         => p_orgin,
                                p_abnormal_id   => p_abnormal_id);
      
      END IF;
    
    END IF;
  
  END sync_deduction;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:20:50
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �����쳣�����ۿ
  * Obj_Name    : SYNC_ABN_DED_BILL
  * Arg_Number  : 10
  * P_COMPANY_ID :��˾ID
  * P_ORDER_ID :����ID
  * P_GOO_ID :��Ʒ�������
  * P_CREATE_ID :������
  * P_DELAY_DAY :��������
  * P_DELAY_AMOUNT :��������
  * P_DISCOUNT_PRICE :�ۿ���
  * P_ACT_DISCOUNT_PRICE :ʵ�ʿۿ���
  * P_ORGIN :��Դ ϵͳ���� SC / �ֶ����� MA
  * P_ABNORMAL_ID :�쳣����ţ��ֶ�������������Ϊ��
  *============================================*/
  PROCEDURE sync_abn_ded_bill(p_company_id         VARCHAR2,
                              p_order_id           VARCHAR2,
                              p_goo_id             VARCHAR2,
                              p_create_id          VARCHAR2,
                              p_deduction_type     VARCHAR2 DEFAULT NULL,
                              p_delay_day          NUMBER,
                              p_delay_amount       NUMBER,
                              p_is_sup             NUMBER DEFAULT NULL, --��Ӧ���Ƿ�����
                              p_order_price        NUMBER,
                              p_discount_price     NUMBER,
                              p_act_discount_price NUMBER,
                              p_orgin              VARCHAR2, --��Դ ϵͳ���� SC / �ֶ����� MA
                              p_arrival_date       DATE DEFAULT NULL, --�������ڣ�����ӡ����ʹ�ã�
                              p_abnormal_id        VARCHAR2) IS
    --�쳣����ţ��ֶ�������������Ϊ��
    p_abn_rec          scmdata.t_abnormal%ROWTYPE;
    p_duc_rec          scmdata.t_deduction%ROWTYPE;
    v_abnormal_id      VARCHAR2(100);
    v_deduction_method VARCHAR2(32);
  BEGIN
    --1.ϵͳ����
    IF p_orgin = 'SC' THEN
      v_abnormal_id := scmdata.f_get_uuid();
      --1.1 �����쳣��
      p_abn_rec.abnormal_id          := v_abnormal_id;
      p_abn_rec.company_id           := p_company_id;
      p_abn_rec.abnormal_code        := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_abnormal',
                                                                           pi_column_name => 'abnormal_code',
                                                                           pi_company_id  => p_company_id,
                                                                           pi_pre         => 'ABN',
                                                                           pi_serail_num  => '6');
      p_abn_rec.order_id             := p_order_id;
      p_abn_rec.progress_status      := '02';
      p_abn_rec.goo_id               := p_goo_id;
      p_abn_rec.anomaly_class        := 'AC_DATE';
      p_abn_rec.problem_class        := ' ';
      p_abn_rec.cause_class          := ' ';
      p_abn_rec.detailed_reasons     := '���ڿۿ�';
      p_abn_rec.delay_date           := nvl(p_delay_day, 0);
      p_abn_rec.delay_amount         := nvl(p_delay_amount, 0); --��������
      p_abn_rec.responsible_party    := ' ';
      p_abn_rec.responsible_dept     := ' ';
      p_abn_rec.handle_opinions      := '';
      p_abn_rec.quality_deduction    := 0;
      p_abn_rec.is_deduction         := 1;
      p_abn_rec.deduction_method     := p_deduction_type;
      p_abn_rec.deduction_unit_price := 0;
      p_abn_rec.applicant_id         := p_create_id;
      p_abn_rec.applicant_date       := SYSDATE;
      p_abn_rec.create_id            := p_create_id;
      p_abn_rec.create_time          := SYSDATE;
      p_abn_rec.origin               := p_orgin;
    
      scmdata.pkg_production_progress.handle_abnormal(p_abn_rec => p_abn_rec);
    
      --1.2 ���ɿۿ
      p_duc_rec.deduction_id     := scmdata.f_get_uuid();
      p_duc_rec.company_id       := p_company_id;
      p_duc_rec.order_company_id := '';
      p_duc_rec.order_id         := p_order_id;
      p_duc_rec.abnormal_id      := v_abnormal_id;
      p_duc_rec.deduction_status := '00'; --������
      --����
      p_duc_rec.deduction_amount      := p_delay_amount;
      p_duc_rec.discount_unit_price   := nvl(p_order_price, 0);
      p_duc_rec.discount_type         := '';
      p_duc_rec.discount_proportion   := '';
      p_duc_rec.discount_price        := nvl(p_discount_price, 0); --�ۿ���
      p_duc_rec.adjust_type           := '';
      p_duc_rec.adjust_proportion     := '';
      p_duc_rec.adjust_price := CASE
                                  WHEN p_is_sup = 1 THEN
                                   nvl(-p_discount_price, 0)
                                  ELSE
                                   0
                                END; --��������Ӧ���Ƿ�����Ϊ�ǣ�ȡ�����Ŀۿ�������ʼΪ0
      p_duc_rec.adjust_reason := CASE
                                   WHEN p_is_sup = 1 THEN
                                    '��Ӧ�̿ۿ�����'
                                   ELSE
                                    ''
                                 END;
      p_duc_rec.actual_discount_price := nvl(p_act_discount_price, 0); --ʵ�ʿۿ���
      p_duc_rec.create_id             := p_create_id;
      p_duc_rec.create_time           := SYSDATE;
      p_duc_rec.update_id := CASE
                               WHEN p_is_sup = 1 THEN
                                'ADMIN'
                               ELSE
                                ''
                             END;
      p_duc_rec.update_time := CASE
                                 WHEN p_is_sup = 1 THEN
                                  SYSDATE
                                 ELSE
                                  ''
                               END;
      p_duc_rec.memo                  := '';
      p_duc_rec.orgin                 := p_orgin; --��Դ��ϵͳ����
      p_duc_rec.arrival_date          := p_arrival_date; --��������
    
      scmdata.pkg_production_progress.insert_deduction(p_duc_rec => p_duc_rec);
      --2.�ֶ�����
    ELSIF p_orgin = 'MA' THEN
      v_abnormal_id := p_abnormal_id;
    
      SELECT ar.deduction_method
        INTO v_deduction_method
        FROM scmdata.t_abnormal ar
       WHERE ar.abnormal_id = p_abnormal_id;
    
      --2.1 ���ɿۿ
      p_duc_rec.deduction_id     := scmdata.f_get_uuid();
      p_duc_rec.company_id       := p_company_id;
      p_duc_rec.order_company_id := '';
      p_duc_rec.order_id         := p_order_id;
      p_duc_rec.abnormal_id      := v_abnormal_id;
      p_duc_rec.deduction_status := '00'; --������
      --����
      p_duc_rec.deduction_amount := p_delay_amount;
      --���ۿʽ���ۿ�۸�ֵ
      IF v_deduction_method = 'METHOD_00' OR
         v_deduction_method = 'METHOD_02' THEN
        p_duc_rec.discount_unit_price := nvl(p_order_price, 0);
      ELSE
        p_duc_rec.discount_unit_price := nvl('', 0);
      END IF;
      p_duc_rec.discount_type       := '';
      p_duc_rec.discount_proportion := '';
      p_duc_rec.discount_price      := nvl(p_discount_price, 0); --�ۿ���
      --���ۿʽ���ۿ��ֵ
      /*      IF v_deduction_method = 'METHOD_01' THEN
        p_duc_rec.discount_price := nvl(p_discount_price, 0); --�ۿ���
      ELSE
        p_duc_rec.discount_price := nvl('', 0);
      END IF;*/
      p_duc_rec.adjust_type           := '';
      p_duc_rec.adjust_proportion     := '';
      p_duc_rec.adjust_price          := 0; --��������ʼΪ0
      p_duc_rec.adjust_reason         := '';
      p_duc_rec.actual_discount_price := nvl(p_act_discount_price, 0); --ʵ�ʿۿ���
      p_duc_rec.create_id             := p_create_id;
      p_duc_rec.create_time           := SYSDATE;
      p_duc_rec.memo                  := '';
      p_duc_rec.orgin                 := p_orgin; --��Դ���ֶ�����
      p_duc_rec.arrival_date          := p_arrival_date; --��������
    
      scmdata.pkg_production_progress.insert_deduction(p_duc_rec => p_duc_rec);
    
    END IF;
  
  END sync_abn_ded_bill;

  /*============================================*
  * Author   : CZH
  * Created  : 2021-01-04 15:22:23
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : �����ۿ���ϸ
  * Obj_Name    : INSERT_DEDUCTION
  * Arg_Number  : 1
  * P_DUC_REC :�ۿ
  *============================================*/

  PROCEDURE insert_deduction(p_duc_rec scmdata.t_deduction%ROWTYPE) IS
  BEGIN
    INSERT INTO t_deduction
      (deduction_id,
       company_id,
       order_company_id,
       order_id,
       abnormal_id,
       deduction_status,
       discount_unit_price,
       deduction_amount,
       discount_type,
       discount_proportion,
       discount_price,
       adjust_type,
       adjust_proportion,
       adjust_price,
       adjust_reason,
       actual_discount_price,
       create_id,
       create_time,
       update_id,
       update_time,
       memo,
       orgin,
       arrival_date)
    VALUES
      (p_duc_rec.deduction_id,
       p_duc_rec.company_id,
       p_duc_rec.order_company_id,
       p_duc_rec.order_id,
       p_duc_rec.abnormal_id,
       p_duc_rec.deduction_status,
       p_duc_rec.discount_unit_price,
       p_duc_rec.deduction_amount,
       p_duc_rec.discount_type,
       p_duc_rec.discount_proportion,
       p_duc_rec.discount_price,
       p_duc_rec.adjust_type,
       p_duc_rec.adjust_proportion,
       p_duc_rec.adjust_price,
       p_duc_rec.adjust_reason,
       p_duc_rec.actual_discount_price,
       p_duc_rec.create_id,
       p_duc_rec.create_time,
       p_duc_rec.update_id,
       p_duc_rec.update_time,
       p_duc_rec.memo,
       p_duc_rec.orgin,
       p_duc_rec.arrival_date);
  
  END;

  --�Ƿ񳬼ƻ������������ ����ֵ����������
  /*
  ���ƻ������������ȡֵ��
   1������ƻ����������ֵ���ҵ�ǰ���ڳ����ƻ�������ڣ��򳬼ƻ������������=��ǰ���� - ���½ڵ�ļƻ��������
   2������ƻ��������Ϊ�գ���ȡĿ��������ڣ��ҵ�ǰ���ڳ�������Ŀ��������ڣ��򳬼ƻ������������=��ǰ���� - ������Ŀ���������
  */
  FUNCTION check_is_delay(p_max_node_date DATE) RETURN NUMBER IS
    v_delay_day NUMBER;
  BEGIN
    v_delay_day := trunc(SYSDATE) - trunc(p_max_node_date);
    IF v_delay_day > 0 THEN
      RETURN v_delay_day;
    ELSE
      RETURN 0;
    END IF;
  
  END;
  --����ڵ����� ��һ�ڵ����� - ��ǰ�ڵ�����
  FUNCTION calc_node_cycle(p_next_node_time DATE, p_curr_node_time DATE)
    RETURN NUMBER IS
  BEGIN
    RETURN trunc(p_next_node_time) - trunc(p_curr_node_time);
  END calc_node_cycle;

  --��ȡʣ��ڵ������
  /* ʣ��δ��ɽڵ�Ľڵ�����ȡֵ��
    1������ƻ����������ֵ����ȡ�ƻ�������ڵ�ʣ��δ��ɽڵ�����
    2������ƻ��������Ϊ�գ���ȡĿ��������ڵ�ʣ��δ��ɽڵ�����
    3������=��ǰ�ڵ����� - ��һ�ڵ�����
  */
  FUNCTION get_node_cycle(p_sys_pno_arrays sys_pno_type, p_node_num NUMBER)
    RETURN NUMBER IS
    v_node_cycle NUMBER := 0;
  BEGIN
    --p_node_num �ýڵ�Ӧ����ʵ��������ڣ����½ڵ㣩
    --�ж�p_node_num����Ӧ�ļƻ���������Ƿ���ֵ
    --��ֵ����ȡ�ƻ�������ڣ����½ڵ㣩-�ƻ�������ڣ�p_node_num�ڵ㣩���ó��ƻ�������ڵĽڵ����ڣ�����Ŀ��������ڵĽڵ����ڣ�����еĻ���
  
    --��ֵ����μ��㣿
    --�ڵ�����=�ƻ�������ڣ����½ڵ㣩-������ļƻ�������ڣ�p_node_num�ڵ㣩
    --��ʵ�ڵ�����=��Ӧ��Ŀ��������ڣ����½ڵ㣩-Ŀ��������ڣ�p_node_num�ڵ㣩
    --����Ŀ��������ڵĽڵ����ڣ�����еĻ���
  
    --��ʣ��ڵ� ��������
    FOR i IN p_node_num .. p_sys_pno_arrays.last LOOP
      --�жϵ�ǰ�ڵ��Ƿ�����һ�ڵ�
      IF p_sys_pno_arrays.next(i) IS NOT NULL THEN
        IF p_sys_pno_arrays(i).plan_completion_time IS NOT NULL THEN
          IF p_sys_pno_arrays(i + 1).plan_completion_time IS NOT NULL THEN
            v_node_cycle := v_node_cycle +
                            calc_node_cycle(p_next_node_time => p_sys_pno_arrays(i + 1).plan_completion_time,
                                            p_curr_node_time => p_sys_pno_arrays(i).plan_completion_time);
          ELSE
            v_node_cycle := v_node_cycle +
                            calc_node_cycle(p_next_node_time => p_sys_pno_arrays(i + 1).target_completion_time,
                                            p_curr_node_time => p_sys_pno_arrays(i).target_completion_time);
          END IF;
        ELSE
          v_node_cycle := v_node_cycle +
                          calc_node_cycle(p_next_node_time => p_sys_pno_arrays(i + 1).target_completion_time,
                                          p_curr_node_time => p_sys_pno_arrays(i).target_completion_time);
        END IF;
      END IF;
    
    END LOOP;
  
    /*    FOR i IN p_node_num .. p_sys_pno_arrays.last LOOP
      dbms_output.put_line(p_sys_pno_arrays(i).node_num);
      dbms_output.put_line(p_sys_pno_arrays(i).target_completion_time);
      dbms_output.put_line(p_sys_pno_arrays(i).plan_completion_time);
      dbms_output.put_line(p_sys_pno_arrays(i).actual_completion_time);
    END LOOP;*/
    RETURN v_node_cycle;
  END;

  --Ԥ�⽻��ģ��ʵ��
  FUNCTION calc_forecast_delivery_date(p_company_id       VARCHAR2,
                                       p_product_gress_id VARCHAR2,
                                       p_status           VARCHAR2)
    RETURN DATE IS
    /*    --���У�
    TYPE pno_type IS RECORD(
      node_num               NUMBER(3),
      target_completion_time DATE,
      plan_completion_time   DATE,
      actual_completion_time DATE);
    
    TYPE sys_pno_type IS TABLE OF pno_type INDEX BY PLS_INTEGER;*/
  
    sys_pno_arrays sys_pno_type := sys_pno_type();
  
    --���鳤�ȣ��У�
    v_count PLS_INTEGER := 0;
  
    --�жϼƻ�������ڣ�ʵ��������� ��ֵ����
    v_nplnl_count NUMBER := 0;
    v_natnl_count NUMBER := 0;
  
    --��¼���½ڵ� �ڵ���� �ƻ�������ڣ�ʵ���������
    v_plnl_num NUMBER;
    v_atnl_num NUMBER;
  
    --��¼ 1.����Ŀ���������  2.���½ڵ�  �ƻ�������ڣ�ʵ���������
    v_target_date DATE;
    v_plnl_date   DATE;
    v_atnl_date   DATE;
  
    v_pro_status VARCHAR2(32) := p_status;
  
    --��������
    vo_delay_day NUMBER;
    --Ԥ�⽻��
    vo_forecast_date DATE;
    --ʣ��ڵ�����
    v_node_cycle NUMBER;
  BEGIN
    --��ʼ����ά����
    FOR pno_rec IN (SELECT pn.node_num,
                           pn.target_completion_time,
                           pn.plan_completion_time,
                           pn.actual_completion_time
                      FROM scmdata.t_production_node pn
                     WHERE pn.company_id = p_company_id
                       AND pn.product_gress_id = p_product_gress_id
                     ORDER BY pn.node_num ASC) LOOP
      --ȫ���ڵ����/�����ڵ����
      v_count := v_count + 1;
      sys_pno_arrays(v_count).node_num := pno_rec.node_num;
      sys_pno_arrays(v_count).target_completion_time := pno_rec.target_completion_time;
      --��¼���½ڵ� Ŀ���������
      v_target_date := pno_rec.target_completion_time;
    
      --ͳ�Ƽƻ�������� ��ֵ����
      IF pno_rec.plan_completion_time IS NOT NULL THEN
        v_nplnl_count := v_nplnl_count + 1;
        --��¼���½ڵ� �ڵ���� �ƻ��������
        v_plnl_num := pno_rec.node_num;
        --��¼���½ڵ� �ƻ��������
        v_plnl_date := pno_rec.plan_completion_time;
      END IF;
    
      sys_pno_arrays(v_count).plan_completion_time := pno_rec.plan_completion_time;
    
      --ͳ��ʵ��������� ��ֵ����
      IF pno_rec.actual_completion_time IS NOT NULL THEN
        v_natnl_count := v_natnl_count + 1;
        --��¼���½ڵ� �ڵ���� �ƻ��������
        v_atnl_num := pno_rec.node_num;
        --��¼���½ڵ� ʵ���������
        v_atnl_date := pno_rec.actual_completion_time;
      END IF;
    
      sys_pno_arrays(v_count).actual_completion_time := pno_rec.actual_completion_time;
    
    END LOOP;
  
    --1.��������δ��ʼ��������  �����߼�
    IF v_pro_status = '00' OR v_pro_status = '02' THEN
      --1.1 �ƻ��������/ʵ��������� Ϊ�գ����нڵ㣩
      IF v_nplnl_count = 0 AND v_natnl_count = 0 THEN
        --1.1.1 ����ǰ�����ѳ��� Ŀ��������ڣ�������
        vo_delay_day := check_is_delay(p_max_node_date => v_target_date);
        --1.1.2 Ԥ�⽻�� = Ŀ��������ڣ������� + ���ƻ��������������vo_delay_day ? >0:vo_delay_day:0��
        vo_forecast_date := v_target_date + vo_delay_day;
        --1.2 �ƻ�������� ��ֵ(����/���½ڵ�)/ʵ��������� Ϊ�գ����нڵ㣩
      ELSIF v_nplnl_count > 0 AND v_natnl_count = 0 THEN
        --1.2.1 �� �ƻ�������� ���½ڵ� = �����ڵ�
        IF v_plnl_num = v_count THEN
          --1.2.2 ����ǰ�����ѳ����ƻ�������ڣ�������
          vo_delay_day := check_is_delay(p_max_node_date => v_plnl_date);
          --1.2.3 Ԥ�⽻�� = �ƻ�������ڣ������� + ���ƻ��������������vo_delay_day ? >0:vo_delay_day:0��
          vo_forecast_date := v_plnl_date + vo_delay_day;
          --1.2.4 �� �ƻ�������� ���½ڵ� <> �����ڵ�
        ELSE
          ----1.2.5 ����ǰ�����ѳ���Ŀ��������ڣ�������
          vo_delay_day := check_is_delay(p_max_node_date => v_target_date);
          --1.2.6 Ԥ�⽻�� = �ƻ�������ڣ����½ڵ㣩 + ʣ��ڵ������  + ���ƻ��������������vo_delay_day ? >0:vo_delay_day:0��
          v_node_cycle     := get_node_cycle(p_sys_pno_arrays => sys_pno_arrays,
                                             p_node_num       => v_plnl_num);
          vo_forecast_date := v_plnl_date + v_node_cycle + vo_delay_day;
        END IF;
      END IF;
      --2.�������Ƚ�����  �����߼�
      IF v_pro_status = '02' THEN
        --2.1 �ƻ��������Ϊ�գ����нڵ㣩/ʵ�����������ֵ�����ֽڵ㣩
        IF v_nplnl_count = 0 AND v_natnl_count > 0 THEN
          --2.1.1 �� ʵ��������� ���½ڵ� = �����ڵ�
          IF v_atnl_num = v_count THEN
            --2.1.2 Ԥ�⽻�� = ʵ��������ڣ�������
            vo_forecast_date := v_atnl_date;
          ELSE
            --2.1.3 ����ǰ�����ѳ��� Ŀ��������ڣ�������
            vo_delay_day := check_is_delay(p_max_node_date => v_target_date);
          
            --2.1.4 Ԥ�⽻�� = ʵ��������ڣ����½ڵ㣩 + ʣ��ڵ������  + ���ƻ��������������vo_delay_day ? >0:vo_delay_day:0��
            v_node_cycle     := get_node_cycle(p_sys_pno_arrays => sys_pno_arrays,
                                               p_node_num       => v_atnl_num);
            vo_forecast_date := v_atnl_date + v_node_cycle + vo_delay_day;
          END IF;
          --2.2 �ƻ����������ֵ������/���нڵ㣩/ʵ�����������ֵ�����нڵ㣩
          --ELSIF v_nplnl_count > 0 AND v_natnl_count = v_count THEN
          --2.2.1 Ԥ�⽻�� = ʵ��������ڣ�������
          --vo_forecast_date := v_atnl_date;
          --2.3 �ƻ����������ֵ������/���нڵ㣩/ʵ�����������ֵ�����ֽڵ㣩
        ELSIF v_nplnl_count > 0 AND v_natnl_count > 0 THEN
          --2.3.1 �� ʵ��������� ���½ڵ� = �����ڵ�
          IF v_atnl_num = v_count THEN
            --2.3.2 Ԥ�⽻�� = ʵ��������ڣ�������
            vo_forecast_date := v_atnl_date;
          ELSE
            --2.3.3 ����ǰ�����ѳ��� �ƻ�������ڣ�������/Ŀ��������ڣ�������
            IF v_plnl_num = v_count THEN
              vo_delay_day := check_is_delay(p_max_node_date => v_plnl_date);
            ELSE
              vo_delay_day := check_is_delay(p_max_node_date => v_target_date);
            END IF;
            --2.3.4 Ԥ�⽻�� = ʵ��������ڣ����½ڵ㣩 + ʣ��ڵ������  + ���ƻ��������������vo_delay_day ? >0:vo_delay_day:0��
            v_node_cycle     := get_node_cycle(p_sys_pno_arrays => sys_pno_arrays,
                                               p_node_num       => v_atnl_num);
            vo_forecast_date := v_atnl_date + v_node_cycle + vo_delay_day;
          END IF;
        END IF;
      END IF;
    END IF;
    RETURN vo_forecast_date;
  
    --���
    /*FOR i IN sys_pno_arrays.first .. sys_pno_arrays.last LOOP
      dbms_output.put_line(sys_pno_arrays(i).node_num);
      dbms_output.put_line(sys_pno_arrays(i).target_completion_time);
      dbms_output.put_line(sys_pno_arrays(i).plan_completion_time);
      dbms_output.put_line(sys_pno_arrays(i).actual_completion_time);
    
    END LOOP;*/
  END calc_forecast_delivery_date;

END pkg_production_progress;
/
