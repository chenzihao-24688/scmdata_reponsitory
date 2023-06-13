DECLARE
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@;
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_good_id_p          VARCHAR2(100); --��Ҫ���ƽڵ���ȵ���������,����
  v_good_id_c          VARCHAR2(100); --ѡ���������������
  v_good_id            VARCHAR2(100);
  vpn_code             VARCHAR2(100);
  v_flag               NUMBER;
  po_header_rec        scmdata.t_ordered%ROWTYPE;
  po_line_rec          scmdata.t_orders%ROWTYPE;
  p_produ_rec          t_production_progress%ROWTYPE;
  pno_rec              scmdata.t_production_node%ROWTYPE;
  --��Ҫ���ƽڵ���ȵ���������
  CURSOR pro_cur IS
    SELECT tc.goo_id t_goo_id, p.*
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_commodity_info tc
        ON p.company_id = tc.company_id
       AND p.goo_id = tc.goo_id
     WHERE p.company_id = %default_company_id%
       AND p.product_gress_code IN (@selection);
BEGIN
  --������������Ʒ��ͬ��������ͬ�����ſ�֧�ֽڵ���ȸ��ƣ���ͬʱ����ʾ�û�������ѡ������������Ʒ��һ�£���֧��ͬʱ���ƽڵ���ȣ���

  --1. ��Ҫ���ƽڵ���ȵ���������,��Ʒ������Ų�һ�¡�
  SELECT COUNT(DISTINCT tc.goo_id), COUNT(*)
    INTO v_good_id_p, v_good_id
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_commodity_info tc
      ON p.company_id = v_company_id
     AND p.company_id = tc.company_id
     AND p.goo_id = tc.goo_id
     AND p.product_gress_code IN (@selection);

  IF v_good_id_p <> v_good_id THEN
    raise_application_error(-20002,
                            '��ѡ������������Ʒ��һ�£���֧��ͬʱ���ƽڵ���ȣ�');
  END IF;

  --�����������������Ӧ�ڵ���� �Ƿ�Ϊ��
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_production_node pn
      ON p.company_id = pn.company_id
     AND p.product_gress_id = pn.product_gress_id
     AND p.product_gress_code = v_product_gress_code
   WHERE p.company_id = v_company_id;

  --2. ��Ҫ���ƽڵ���ȵ�����������Ʒ�������һ�¡�

  --2.1 �������������������ڵ���Ȳ�����
  IF v_flag = 0 THEN
    raise_application_error(-20002,
                            '����ʧ�ܣ��������������������/�������������ڽڵ���ȣ�');
  ELSE
    --�����������������Ӧ��Ʒ�����Ļ���
    SELECT tc.goo_id
      INTO v_good_id_c
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_commodity_info tc
        ON p.company_id = tc.company_id
       AND p.goo_id = tc.goo_id
       AND p.product_gress_code = v_product_gress_code
     WHERE p.company_id = v_company_id;
  
    --2.2 ������ƽڵ���ȵ������������ڵ���ȴ���
    FOR pro_rec IN pro_cur LOOP
      --2.3 ѡ�������������Ʒ������Ų�һ��
      IF pro_rec.t_goo_id <> v_good_id_c THEN
        raise_application_error(-20002,
                                '��ѡ��������������������������Ʒ��һ�£���֧�ָ��ƽڵ���ȣ�');
      ELSE
        --2.4 У����Ҫ���ƽڵ���ȵ������������Ƿ��нڵ����
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pro_rec.company_id
           AND pn.product_gress_id = pro_rec.product_gress_id
           AND pn.company_id = v_company_id;
      
        --2.5 û�нڵ���ȣ�����������
        IF v_flag = 0 THEN
        
          SELECT *
            INTO po_header_rec
            FROM scmdata.t_ordered po
           WHERE po.company_id = pro_rec.company_id
             AND po.order_code = pro_rec.order_id;
        
          SELECT *
            INTO po_line_rec
            FROM scmdata.t_orders pln
           WHERE pln.company_id = pro_rec.company_id
             AND pln.order_id = pro_rec.order_id
             AND pln.goo_id = pro_rec.goo_id;
        
          SELECT *
            INTO p_produ_rec
            FROM scmdata.t_production_progress t
           WHERE t.company_id = pro_rec.company_id
             AND t.product_gress_id = pro_rec.product_gress_id;
        
          --2.5.1 ͬ���ڵ����
          scmdata.pkg_production_progress.sync_production_progress_node(po_header_rec => po_header_rec,
                                                                        po_line_rec   => po_line_rec,
                                                                        p_produ_rec   => p_produ_rec);
        END IF;
      
        --2.6 �нڵ���� ,�����²���
        ----�����������������Ӧ�ڵ����
        FOR pn_rec IN (SELECT pn.*
                         FROM scmdata.t_production_progress p
                        INNER JOIN scmdata.t_production_node pn
                           ON p.company_id = pn.company_id
                          AND p.product_gress_id = pn.product_gress_id
                          AND p.product_gress_code = v_product_gress_code
                        WHERE p.company_id = v_company_id) LOOP
        
          pno_rec.plan_completion_time   := pn_rec.plan_completion_time;
          pno_rec.actual_completion_time := pn_rec.actual_completion_time;
          pno_rec.complete_amount        := pn_rec.complete_amount;
          pno_rec.progress_status        := pn_rec.progress_status;
          pno_rec.progress_say           := pn_rec.progress_say;
          pno_rec.update_id              := pn_rec.update_id;
          pno_rec.update_date            := pn_rec.update_date;
          pno_rec.create_id              := pn_rec.create_id;
          pno_rec.create_time            := pn_rec.create_time;
          pno_rec.memo                   := pn_rec.memo;
          pno_rec.company_id             := v_company_id;
          pno_rec.product_gress_id       := pro_rec.product_gress_id;
        
          pno_rec.product_node_id := i.product_node_id; --�������⣬Ӧ������ѡ�Ķ���
        
          scmdata.pkg_production_progress.update_production_node(pno_rec => pno_rec);
        
        END LOOP;
      
      END IF;
    
    END LOOP;
  
  END IF;

END;
