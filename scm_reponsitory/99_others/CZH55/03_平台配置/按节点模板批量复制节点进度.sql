--只要节点数量+节点名称一致就可复制订单（按序号），用时比例不校验
--1.所勾选生产订单节点进度模板是否一致  否 则提示
--2.输入的生产订单，对应节点进度 是否为空
--是 则提示
--否
--3.1 所勾选生产订单节点进度模板与输入生产订单节点进度模板是否一致  否 则提示
--3.2 校验所勾选的需要复制节点进度的生产订单，是否有节点进度
--3.2.1 否 没有节点进度，做新增操作
--3.2.2 是 有节点进度 ,做更新操作
--4.批量复制功能，节点进度舍弃
--4.1 校验实际完成日期，与进度状态，两者任一字段有值，则另一字段必填
--4.2 完成数量大于订单数量的校验
--4.3 计划完成日期前后节点校验
DECLARE
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_flag               NUMBER;
  v_moudle             NUMBER;
  po_header_rec        scmdata.t_ordered%ROWTYPE;
  po_line_rec          scmdata.t_orders%ROWTYPE;
  p_produ_rec          t_production_progress%ROWTYPE;
  pno_rec              scmdata.t_production_node%ROWTYPE;
  --所选的需要复制节点进度的生产订单
  CURSOR pro_cur IS
    SELECT tc.goo_id t_goo_id, p.*
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_production_node pn
        ON p.company_id = pn.company_id
       AND p.product_gress_id = pn.product_gress_id
     WHERE p.company_id = v_company_id
       AND p.product_gress_code IN (@selection);
BEGIN

  --1.所勾选生产订单节点进度模板是否一致  否 则提示
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
                            '所选生产订单的节点进度模板不一致，不支持同时复制节点进度！');
  
  END IF;

  --2.输入的生产订单，对应节点进度 是否为空    
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
                            '复制失败，输入的生产订单不存在/生产订单不存在节点进度！');
  ELSE
    --3.1 所勾选生产订单节点进度模板与输入生产订单节点进度模板是否一致  否 则提示
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
                              '所选生产订单节点进度模板与输入生产订单节点进度模板不一致，不支持复制节点进度！');
    ELSE
      FOR pro_rec IN pro_cur LOOP
        --3.2 校验选择的需要复制节点进度的生产订单，是否有节点进度
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pro_rec.company_id
           AND pn.product_gress_id = pro_rec.product_gress_id
           AND pn.company_id = v_company_id;
      
        --没有节点进度，做新增操作
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
        
          --同步节点进度
          scmdata.pkg_production_progress.sync_production_progress_node(po_header_rec => po_header_rec,
                                                                        po_line_rec   => po_line_rec,
                                                                        p_produ_rec   => p_produ_rec,
                                                                        p_status      => 0);
        
        END IF;
        --3.3 有节点进度 ,做更新操作
        ----输入的生产订单，对应节点进度
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
          pno_rec.product_gress_id       := pro_rec.product_gress_id; --所选择的需要复制节点进度的生产订单主键ID
        
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
