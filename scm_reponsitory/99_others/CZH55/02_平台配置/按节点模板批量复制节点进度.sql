--ֻҪ�ڵ�����+�ڵ�����һ�¾Ϳɸ��ƶ���������ţ�����ʱ������У��
--1.����ѡ���������ڵ����ģ���Ƿ�һ��  �� ����ʾ
--2.�����������������Ӧ�ڵ���� �Ƿ�Ϊ��
--�� ����ʾ
--��
--3.1 ����ѡ���������ڵ����ģ�����������������ڵ����ģ���Ƿ�һ��  �� ����ʾ
--3.2 У������ѡ����Ҫ���ƽڵ���ȵ������������Ƿ��нڵ����
--3.2.1 �� û�нڵ���ȣ�����������
--3.2.2 �� �нڵ���� ,�����²���
--4.�������ƹ��ܣ��ڵ��������
--4.1 У��ʵ��������ڣ������״̬��������һ�ֶ���ֵ������һ�ֶα���
--4.2 ����������ڶ���������У��
--4.3 �ƻ��������ǰ��ڵ�У��
DECLARE
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --�������������
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_flag               NUMBER;
  v_moudle             NUMBER;
  po_header_rec        scmdata.t_ordered%ROWTYPE;
  po_line_rec          scmdata.t_orders%ROWTYPE;
  p_produ_rec          t_production_progress%ROWTYPE;
  pno_rec              scmdata.t_production_node%ROWTYPE;
  --��ѡ����Ҫ���ƽڵ���ȵ���������
  CURSOR pro_cur IS
    SELECT tc.goo_id t_goo_id, p.*
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_production_node pn
        ON p.company_id = pn.company_id
       AND p.product_gress_id = pn.product_gress_id
     WHERE p.company_id = v_company_id
       AND p.product_gress_code IN (@selection);
BEGIN

  --1.����ѡ���������ڵ����ģ���Ƿ�һ��  �� ����ʾ
  SELECT COUNT(DISTINCT p_name)
    INTO v_moudle
    FROM (SELECT listagg(pn.node_name) within GROUP(ORDER BY pn.node_num ASC) over(PARTITION BY pn.product_gress_id) p_name
            FROM scmdata.t_production_progress p
           INNER JOIN scmdata.t_production_node pn
              ON p.company_id = pn.company_id
             AND p.product_gress_id = pn.product_gress_id
             AND p.company_id = v_company_id
             AND p.product_gress_code IN (@selection));

  IF v_moudle <> 1 THEN
    raise_application_error(-20002,
                            '��ѡ���������Ľڵ����ģ�岻һ�£���֧��ͬʱ���ƽڵ���ȣ�');
  
  END IF;

  --2.�����������������Ӧ�ڵ���� �Ƿ�Ϊ��    
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_production_node pn
      ON p.company_id = pn.company_id
     AND p.product_gress_id = pn.product_gress_id
     AND p.product_gress_code = v_product_gress_code
   WHERE p.company_id = v_company_id;

  IF v_flag = 0 THEN
    raise_application_error(-20002,
                            '����ʧ�ܣ��������������������/�������������ڽڵ���ȣ�');
  ELSE
    --3.1 ����ѡ���������ڵ����ģ�����������������ڵ����ģ���Ƿ�һ��  �� ����ʾ
    SELECT COUNT(DISTINCT p_name)
      INTO v_moudle
      FROM (SELECT listagg(pn.node_name) within GROUP(ORDER BY pn.node_num ASC) over(PARTITION BY pn.product_gress_id) p_name
              FROM scmdata.t_production_progress p
             INNER JOIN scmdata.t_production_node pn
                ON p.company_id = pn.company_id
               AND p.product_gress_id = pn.product_gress_id
               AND p.company_id = v_company_id
               AND (p.product_gress_code IN (@selection) OR
                   p.product_gress_code = v_product_gress_code));
    IF v_moudle <> 1 THEN
      raise_application_error(-20002,
                              '��ѡ���������ڵ����ģ�����������������ڵ����ģ�岻һ�£���֧�ָ��ƽڵ���ȣ�');
    ELSE
      FOR pro_rec IN pro_cur LOOP
        --3.2 У��ѡ�����Ҫ���ƽڵ���ȵ������������Ƿ��нڵ����
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pro_rec.company_id
           AND pn.product_gress_id = pro_rec.product_gress_id
           AND pn.company_id = v_company_id;
      
        --û�нڵ���ȣ�����������
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
        
          --ͬ���ڵ����
          scmdata.pkg_production_progress.sync_production_progress_node(po_header_rec => po_header_rec,
                                                                        po_line_rec   => po_line_rec,
                                                                        p_produ_rec   => p_produ_rec,
                                                                        p_status      => 0);
        
        END IF;
        --3.3 �нڵ���� ,�����²���
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
          pno_rec.memo                   := pn_rec.memo;
          pno_rec.company_id             := v_company_id;
          pno_rec.product_gress_id       := pro_rec.product_gress_id; --��ѡ�����Ҫ���ƽڵ���ȵ�������������ID
        
          SELECT pn.product_node_id
            INTO pno_rec.product_node_id
            FROM scmdata.t_production_node pn
           WHERE pn.company_id = v_company_id
             AND pn.product_gress_id = pro_rec.product_gress_id
             AND pn.node_name = pn_rec.node_name;
        
          scmdata.pkg_production_progress.update_production_node(pno_rec  => pno_rec,
                                                                 p_status => 1);
        
        END LOOP;
      
      END LOOP;
    
    END IF;
  
  END IF;

END;
