begin
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_210_1', '批量复制进度', 'icon-daoru', 4, '--校验
--1.所勾选生产订单节点进度模板是否一致  否 则提示
--2.输入的生产订单，对应节点进度 是否为空
--是 则提示
--否
--3.1 所勾选生产订单节点进度模板与输入生产订单节点进度模板是否一致  否 则提示
--3.2 校验所勾选的需要复制节点进度的生产订单，是否有节点进度
--3.2.1 否 没有节点进度，做新增操作
--3.2.2 是 有节点进度 ,做更新操作
DECLARE
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@; --输入的生产订单
  v_company_id         VARCHAR2(100);
  v_icomp_id           VARCHAR2(100);
  v_flag               NUMBER;
  v_flag_s             NUMBER;
  v_moudle             NUMBER;
  po_header_rec        scmdata.t_ordered%ROWTYPE;
  po_line_rec          scmdata.t_orders%ROWTYPE;
  p_produ_rec          t_production_progress%ROWTYPE;
  pno_rec              scmdata.t_production_node%ROWTYPE;
  --所选的需要复制节点进度的生产订单
  CURSOR pro_cur(p_company_id VARCHAR2) IS
    SELECT tc.goo_id t_goo_id, p.*
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_commodity_info tc
        ON p.company_id = tc.company_id
       AND p.goo_id = tc.goo_id
      LEFT JOIN scmdata.t_production_node pn
        ON p.company_id = pn.company_id
       AND p.product_gress_id = pn.product_gress_id
     WHERE p.company_id = p_company_id
       AND p.product_gress_code IN (@selection);
BEGIN
  --0.判断所选订单客户是否相同，与输入订单客户是否相同
  SELECT COUNT(DISTINCT t.company_id)
    INTO v_flag
    FROM scmdata.t_production_progress t
   WHERE t.product_gress_code IN (@selection);

  IF v_flag > 1 THEN
    raise_application_error(-20002,
                            ''复制失败,所选生产订单客户不同,请检查！'');
  ELSE
    --勾选订单的客户
    SELECT MAX(t.company_id)
      INTO v_company_id
      FROM scmdata.t_production_progress t
     WHERE t.product_gress_code IN (@selection)
       AND rownum = 1;
    --输入订单的客户
    SELECT MAX(t.company_id)
      INTO v_icomp_id
      FROM scmdata.t_production_progress t
     WHERE t.product_gress_code = v_product_gress_code;
    IF v_company_id = v_icomp_id THEN
      NULL;
    ELSE
      raise_application_error(-20002,
                              ''复制失败,所选生产订单客户与输入的生产订单客户不同,请检查！'');
    END IF;
  END IF;

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

  IF v_moudle <> 0 THEN
    IF v_moudle <> 1 THEN
      raise_application_error(-20002,
                              ''所选生产订单的节点进度模板不一致，不支持同时复制节点进度！'');

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
                              ''复制失败，输入的生产订单不存在/生产订单不存在节点进度！'');
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

      IF v_moudle <> 0 AND v_moudle <> 1 THEN
        raise_application_error(-20002,
                                ''所选生产订单节点进度模板与输入生产订单节点进度模板不一致，不支持复制节点进度！'');
      ELSE
        FOR pro_rec IN pro_cur(p_company_id => v_company_id) LOOP
          --3.2 校验选择的需要复制节点进度的生产订单，是否有节点进度
          SELECT nvl(COUNT(1), 0)
            INTO v_flag_s
            FROM scmdata.t_production_node pn
           WHERE pn.company_id = pro_rec.company_id
             AND pn.product_gress_id = pro_rec.product_gress_id
             AND pn.company_id = v_company_id;

          --没有节点进度，做新增操作
          IF v_flag_s = 0 THEN

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
            pno_rec.plan_start_time        := pn_rec.plan_start_time;
            pno_rec.actual_start_time      := pn_rec.actual_start_time;
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
            --p_status默认为0，设置p_status =1 批量复制不走节点进度校验
            scmdata.pkg_production_progress.update_production_node(pno_rec  => pno_rec,
                                                                   p_status => 1);

          END LOOP;
        END LOOP;
      END IF;

    END IF;
  ELSE
    raise_application_error(-20002,
                            ''所选生产订单的节点进度为空，请先点击"生成节点模板"按钮，生成节点进度！'');
  END IF;
END;', 'PRODUCT_GRESS_CODE_PR', 1, 1, null, null, null, null, null, null, 0, null, null, 1, null, 2);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_product_210_2', '进度填报', 'icon-morencaidan', 4, 'DECLARE
  v_flag       NUMBER;
  v_company_id VARCHAR2(32);
BEGIN
  --0.判断所选订单客户是否相同
  SELECT COUNT(DISTINCT t.company_id)
    INTO v_flag
    FROM scmdata.t_production_progress t
   WHERE t.product_gress_code IN (@selection);

  IF v_flag > 1 THEN
    raise_application_error(-20002,
                            ''复制失败,所选生产订单客户不同,请检查！'');
  ELSE
    --勾选订单的客户
    SELECT MAX(t.company_id)
      INTO v_company_id
      FROM scmdata.t_production_progress t
     WHERE t.product_gress_code IN (@selection)
       AND rownum = 1;
    --1.所勾选生产订单节点进度模板是否一致  否 则提示
    SELECT COUNT(DISTINCT p_name)
      INTO v_flag
      FROM (SELECT listagg(pn.node_name, '';'') within GROUP(ORDER BY pn.node_num ASC) over(PARTITION BY pn.product_gress_id) p_name
              FROM scmdata.t_production_progress p
             INNER JOIN scmdata.t_production_node pn
                ON p.company_id = pn.company_id
               AND p.product_gress_id = pn.product_gress_id
               AND p.company_id = v_company_id
               AND p.product_gress_code IN (@selection));
    IF v_flag = 0 THEN
      raise_application_error(-20002,
                              ''所选生产订单的节点进度为空，请联系管理员生成节点模板！'');
    ELSE
      IF v_flag <> 0 AND v_flag <> 1 THEN
        raise_application_error(-20002,
                                ''所选生产订单的节点进度模板不一致，不支持同时进度填报！'');
      ELSE
        --2.判断所选订单，分类+生产类别+产品子类需一致，不一致则不可提交；
        SELECT COUNT(DISTINCT tc.category) +
               COUNT(DISTINCT tc.product_cate) +
               COUNT(DISTINCT tc.samll_category)
          INTO v_flag
          FROM scmdata.t_production_progress p
         INNER JOIN scmdata.t_commodity_info tc
            ON p.company_id = tc.company_id
           AND p.goo_id = tc.goo_id
         WHERE p.company_id = v_company_id
           AND p.product_gress_code IN (@selection);
        IF v_flag <> 3 THEN
          raise_application_error(-20002,
                                  ''所选订单，分类+生产类别+产品子类不一致，不支持同时进度填报！'');
        ELSE
          DECLARE
            v_tmp_rec  scmdata.t_node_tmp%ROWTYPE;
            v_pro_code VARCHAR2(4000);
          BEGIN
            --填写前先清空临时表：当前用户之前所填写的内容
            /*DELETE FROM scmdata.t_node_tmp t
             WHERE t.company_id = %default_company_id%
               AND t.create_id = :user_id;*/

            SELECT listagg(p.product_gress_code, '';'') product_gress_code
              INTO v_pro_code
              FROM scmdata.t_production_progress p
             WHERE p.company_id = v_company_id
               AND p.product_gress_code IN (@selection);
            --进度填写
            FOR i IN (SELECT pn.node_num, pn.node_name
                        FROM scmdata.t_production_progress p
                       INNER JOIN scmdata.t_production_node pn
                          ON p.company_id = pn.company_id
                         AND p.product_gress_id = pn.product_gress_id
                         AND p.company_id = v_company_id
                         AND p.product_gress_code IN (@selection)
                        GROUP BY pn.node_num, pn.node_name) LOOP
              v_tmp_rec.node_tmp_id            := scmdata.f_get_uuid();
              v_tmp_rec.company_id             := %default_company_id%;
              v_tmp_rec.order_company_id       := v_company_id;
              v_tmp_rec.product_gress_code     := v_pro_code;
              v_tmp_rec.plan_completion_time   := :plan_completion_time;
              v_tmp_rec.actual_completion_time := :actual_completion_time;
              v_tmp_rec.complete_amount        := :complete_amount;
              v_tmp_rec.progress_status        := :progress_status;
              v_tmp_rec.progress_say           := :progress_say;
              v_tmp_rec.operator               := ''SUPP'';
              v_tmp_rec.update_id              := :user_id;
              v_tmp_rec.update_date            := SYSDATE;
              v_tmp_rec.create_id              := :user_id;
              v_tmp_rec.create_time            := SYSDATE;
              v_tmp_rec.memo                   := '''';
              v_tmp_rec.node_num               := i.node_num;
              v_tmp_rec.node_name              := i.node_name;
              scmdata.pkg_supp_order_coor.p_insert_node_tmp(p_tmp_rec => v_tmp_rec);
            END LOOP;
          END;
        END IF;
      END IF;
    END IF;
  END IF;
END;', 'PRODUCT_GRESS_CODE_PR', 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, 2);

end;
