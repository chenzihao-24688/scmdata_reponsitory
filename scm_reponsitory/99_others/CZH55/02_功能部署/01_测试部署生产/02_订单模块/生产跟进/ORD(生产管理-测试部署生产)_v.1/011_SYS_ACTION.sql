BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  po_rec scmdata.t_ordered%ROWTYPE;
BEGIN
  po_rec.order_id   := :order_id;
  po_rec.company_id := :company_id;
  po_rec.approve_id := :user_id;
  po_rec.approve_time := SYSDATE;
  po_rec.approve_status := :approve_status;
  scmdata.pkg_production_progress.approve_orders(po_rec => po_rec);
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_130_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[审核]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_130_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[审核]'',''action_a_product_130_1'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  p_produ_rec t_production_progress%ROWTYPE;
BEGIN
  SELECT *
    INTO p_produ_rec
    FROM scmdata.t_production_progress pr
   WHERE pr.product_gress_id = :product_gress_id;

  scmdata.pkg_production_progress.insert_production_progress_node(p_produ_rec => p_produ_rec);
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_101_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[生成节点模板]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_101_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[生成节点模板]'',''action_a_product_101_4'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       decode(t.progress_status,
              '02',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              '00',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = 'PROGRESS_TYPE'
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr, --这里goo_id是货号
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) delivery_date_pr, --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       t.order_amount - t.delivery_amount owe_amount_pr,
       t.approve_edition approve_edition_pr,
       decode(t.fabric_check,
              'FABRIC_EVELUATE_PASS',
              '通过',
              'FABRIC_EVELUATE_NO_PASS',
              '不通过',
              '') fabric_check_pr,
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
       t.handle_opinions handle_opinions_pr,
       t.progress_status progress_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr,
       t.is_sup_responsible,
       t.responsible_dept,
       t.responsible_dept_sec,
       'AC_DATE' ANOMALY_CLASS_PR
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
    AND oh.order_status <> 'OS02' --待修改
   AND (trunc(SYSDATE) - trunc(od.delivery_date)) > 2
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status NOT IN ('01', '03')
   AND t.delay_problem_class IS NOT NULL
   AND t.delay_cause_class IS NOT NULL
   AND t.delay_cause_detailed IS NOT NULL
   AND t.problem_desc IS NOT NULL
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_118_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 5,q''[]'',q''[新增交期异常]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[product_gress_code_pr,goo_id_pr]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_118_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 5,q''[]'',q''[新增交期异常]'',''action_a_product_118_2'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[product_gress_code_pr,goo_id_pr]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       decode(t.progress_status,
              '02',
              (SELECT pno_status
                 FROM (SELECT pn.node_name ||
                              (SELECT a.group_dict_name
                                 FROM group_dict a
                                INNER JOIN group_dict b
                                   ON a.group_dict_type = b.group_dict_value
                                  AND b.group_dict_value = 'PROGRESS_NODE_TYPE'
                                WHERE a.group_dict_value = pn.progress_status) pno_status
                         FROM scmdata.t_production_node pn
                        WHERE pn.company_id = t.company_id
                          AND pn.product_gress_id = t.product_gress_id
                          AND pn.progress_status IS NOT NULL
                        ORDER BY pn.node_num DESC)
                WHERE rownum = 1),
              '00',
              (SELECT a.group_dict_name
                 FROM group_dict a
                WHERE a.group_dict_type = 'PROGRESS_TYPE'
                  AND a.group_dict_value = t.progress_status)) progress_status_desc,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr, --这里goo_id是货号
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) delivery_date_pr, --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’
       t.forecast_delivery_date forecast_delivery_date_pr,
       decode(sign(ceil(t.forecast_delivery_date - od.delivery_date)),
              -1,
              0,
              ceil(t.forecast_delivery_date - od.delivery_date)) forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       t.order_amount - t.delivery_amount owe_amount_pr,
       t.approve_edition approve_edition_pr,
       decode(t.fabric_check,
              'FABRIC_EVELUATE_PASS',
              '通过',
              'FABRIC_EVELUATE_NO_PASS',
              '不通过',
              '') fabric_check_pr,
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
       t.handle_opinions handle_opinions_pr,
       t.progress_status progress_status_pr,
       'AC_QUALITY' ANOMALY_CLASS_PR
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = 'OS01' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> '01'
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_118_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 5,q''[]'',q''[新增质量异常]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[product_gress_code_pr,goo_id_pr]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_118_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 5,q''[]'',q''[新增质量异常]'',''action_a_product_118_3'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[product_gress_code_pr,goo_id_pr]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[--校验
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
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_flag               NUMBER;
  v_flag_s             NUMBER;
  v_moudle             NUMBER;
  po_header_rec        scmdata.t_ordered%ROWTYPE;
  po_line_rec          scmdata.t_orders%ROWTYPE;
  p_produ_rec          t_production_progress%ROWTYPE;
  pno_rec              scmdata.t_production_node%ROWTYPE;
  --所选的需要复制节点进度的生产订单
  CURSOR pro_cur IS
    SELECT tc.goo_id t_goo_id, p.*
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_commodity_info tc
        ON p.company_id = tc.company_id
       AND p.goo_id = tc.goo_id
      LEFT JOIN scmdata.t_production_node pn
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

  IF v_moudle <> 0 THEN
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

      IF v_moudle <> 0 AND v_moudle <> 1 THEN
        raise_application_error(-20002,
                                '所选生产订单节点进度模板与输入生产订单节点进度模板不一致，不支持复制节点进度！');
      ELSE
        FOR pro_rec IN pro_cur LOOP
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
                            '所选生产订单的节点进度为空，请先点击"生成节点模板"按钮，生成节点进度！');
  END IF;

END;

--按货号 批量复制节点进度。舍弃原因：需求变更为按节点模板一致进行批量复制 时间：2021/02/03
/*DECLARE
  v_product_gress_code VARCHAR2(100) := @product_gress_code_pr@;--输入的生产订单
  v_company_id         VARCHAR2(100) := %default_company_id%;
  v_good_id_p          VARCHAR2(100); --需要复制节点进度的生产订单,货号
  v_good_id_c          VARCHAR2(100); --输入的生产订单货号
  v_good_id            VARCHAR2(100);
  vpn_code             VARCHAR2(100);
  v_flag               NUMBER;
  po_header_rec        scmdata.t_ordered%ROWTYPE;
  po_line_rec          scmdata.t_orders%ROWTYPE;
  p_produ_rec          t_production_progress%ROWTYPE;
  pno_rec              scmdata.t_production_node%ROWTYPE;
  --所选的需要复制节点进度的生产订单
  CURSOR pro_cur IS
    SELECT tc.goo_id t_goo_id, p.*
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_commodity_info tc
        ON p.company_id = tc.company_id
       AND p.goo_id = tc.goo_id
     WHERE p.company_id = %default_company_id%
       AND p.product_gress_code IN (@selection);
BEGIN
  --生产订单的商品相同（货号相同），才可支持节点进度复制，不同时需提示用户：“所选生产订单的商品不一致，不支持同时复制节点进度！”

  --1. 所选的需要复制节点进度的生产订单,商品档案编号不一致。
  SELECT COUNT(DISTINCT tc.goo_id)
    INTO v_good_id_p
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_commodity_info tc
      ON p.company_id = v_company_id
     AND p.company_id = tc.company_id
     AND p.goo_id = tc.goo_id
     AND p.product_gress_code IN (@selection);

  IF v_good_id_p <> 1 THEN
    raise_application_error(-20002,
                            '所选生产订单的商品不一致，不支持同时复制节点进度！');
  END IF;

  --输入的生产订单，对应节点进度 是否为空
  SELECT COUNT(1)
    INTO v_flag
    FROM scmdata.t_production_progress p
   INNER JOIN scmdata.t_production_node pn
      ON p.company_id = pn.company_id
     AND p.product_gress_id = pn.product_gress_id
     AND p.product_gress_code = v_product_gress_code
   WHERE p.company_id = v_company_id;

  --2. 需要复制节点进度的生产订单商品档案编号一致。

  --2.1 如果输入的生产订单，节点进度不存在
  IF v_flag = 0 THEN
    raise_application_error(-20002,
                            '复制失败，输入的生产订单不存在/生产订单不存在节点进度！');
  ELSE
    --输入的生产订单，对应商品档案的货号
    SELECT tc.goo_id
      INTO v_good_id_c
      FROM scmdata.t_production_progress p
     INNER JOIN scmdata.t_commodity_info tc
        ON p.company_id = tc.company_id
       AND p.goo_id = tc.goo_id
       AND p.product_gress_code = v_product_gress_code
     WHERE p.company_id = v_company_id;

    FOR pro_rec IN pro_cur LOOP
      --2.3 选择的生产订单与输入的生产订单 商品档案编号不一致
      IF pro_rec.t_goo_id <> v_good_id_c THEN
        raise_application_error(-20002,
                                '所选生产订单与输入生产订单的商品不一致，不支持复制节点进度！');
      ELSE
        --2.4 校验选择的需要复制节点进度的生产订单，是否有节点进度
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_production_node pn
         WHERE pn.company_id = pro_rec.company_id
           AND pn.product_gress_id = pro_rec.product_gress_id
           AND pn.company_id = v_company_id;

        --2.5 没有节点进度，做新增操作
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

          --2.5.1 同步节点进度
          scmdata.pkg_production_progress.sync_production_progress_node(po_header_rec => po_header_rec,
                                                                        po_line_rec   => po_line_rec,
                                                                        p_produ_rec   => p_produ_rec,
                                                                        p_status      => 0);

        END IF;
        --2.6 有节点进度 ,做更新操作
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
          pno_rec.create_id              := pn_rec.create_id;
          pno_rec.create_time            := pn_rec.create_time;
          pno_rec.memo                   := pn_rec.memo;
          pno_rec.company_id             := v_company_id;
          pno_rec.product_gress_id       := pro_rec.product_gress_id;--所选择的需要复制节点进度的生产订单主键ID

          SELECT pn.product_node_id
            INTO pno_rec.product_node_id
            FROM scmdata.t_production_node pn
           WHERE pn.company_id = v_company_id
             AND pn.product_gress_id = pro_rec.product_gress_id
             AND pn.node_name = pn_rec.node_name;

          scmdata.pkg_production_progress.update_production_node(pno_rec => pno_rec);

        END LOOP;

      END IF;

    END LOOP;

  END IF;

END;*/]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_110_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[批量复制进度]'',q''[]'',q''[icon-daoru]'',1,,q''[]'',1,,q''[]'',1,0,,q''[PRODUCT_GRESS_CODE_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_110_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[批量复制进度]'',''action_a_product_110_1'',q''[]'',q''[icon-daoru]'',1,,q''[]'',1,,q''[]'',1,0,,q''[PRODUCT_GRESS_CODE_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
BEGIN
  FOR pro_rec IN (SELECT t.product_gress_id
                    FROM scmdata.t_production_progress t
                   WHERE t.product_gress_id IN (@selection)) LOOP

    scmdata.pkg_production_progress.finish_production_progress(p_product_gress_id => pro_rec.product_gress_id,
                                                               p_status           => '01');
  END LOOP;

END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_110''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[结束订单]'',q''[]'',q''[icon-daoru]'',1,,q''[]'',1,,q''[]'',1,0,,q''[PRODUCT_GRESS_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_110''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[结束订单]'',''action_a_product_110'',q''[]'',q''[icon-daoru]'',1,,q''[]'',1,,q''[]'',1,0,,q''[PRODUCT_GRESS_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[WITH supp AS
 (SELECT sp.company_id, sp.supplier_code, sp.supplier_company_name
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%),
group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict)
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       nvl((SELECT a.group_dict_name
             FROM group_dict a
            INNER JOIN group_dict b
               ON b.group_dict_value = a.group_dict_type
              AND b.group_dict_value = 'PROGRESS_TYPE'
            WHERE a.group_dict_value = t.progress_status),
           t.progress_status) progress_status_desc,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr, --这里goo_id是货号
       cf.rela_goo_id,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp2.supplier_company_name supplier_company_name_pr,
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr,
       nvl(MAX(od.delivery_date) over(PARTITION BY od.order_id),
           od.delivery_date) delivery_date_pr, --最新计划交期,有值时取‘最新计划交期’，无则取‘计划交期’
       t.forecast_delivery_date forecast_delivery_date_pr,
       ceil(t.forecast_delivery_date -
            nvl(t.latest_planned_delivery_date, od.delivery_date)) forecast_delay_day_pr,
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delay_day actual_delay_day_pr,
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       t.order_amount - t.delivery_amount owe_amount_pr,
       t.approve_edition approve_edition_pr,
       decode(t.fabric_check,
              'FABRIC_EVELUATE_PASS',
              '通过',
              'FABRIC_EVELUATE_NO_PASS',
              '不通过',
              '') fabric_check_pr,
       --t.qc_check qc_check_pr,
       --t.qa_check qa_check_pr,
       decode(t.exception_handle_status,
              '01',
              '处理中',
              '02',
              '已处理',
              '无异常') exception_handle_status_pr,
       t.handle_opinions handle_opinions_pr,
       t.progress_status progress_status_pr,
       t.delay_problem_class delay_problem_class_pr,
       t.delay_cause_class delay_cause_class_pr,
       t.delay_cause_detailed delay_cause_detailed_pr,
       t.problem_desc problem_desc_pr
  FROM scmdata.t_ordered oh
 INNER JOIN scmdata.t_orders od
    ON oh.company_id = od.company_id
   AND oh.order_code = od.order_id
   AND oh.order_status = 'OS01' --待修改
 INNER JOIN t_production_progress t
    ON t.company_id = od.company_id
   AND t.order_id = od.order_id
   AND t.goo_id = od.goo_id
   AND t.progress_status <> '01'
 INNER JOIN scmdata.t_commodity_info cf
    ON t.company_id = cf.company_id
   AND t.goo_id = cf.goo_id
  LEFT JOIN supp sp1
    ON t.company_id = sp1.company_id
   AND t.factory_code = sp1.supplier_code
 INNER JOIN supp sp2
    ON t.company_id = sp2.company_id
   AND t.supplier_code = sp2.supplier_code
 WHERE oh.company_id = %default_company_id%
/* AND oh.order_code NOT IN
(SELECT abn.order_id
   FROM scmdata.t_abnormal abn
  WHERE abn.company_id = t.company_id
    AND abn.order_id = t.order_id
    AND abn.goo_id = t.goo_id
    AND abn.progress_status = '00')*/ --2021/1/15 同一张单可多次添加异常处理单]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_118''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 5,q''[]'',q''[批量异常处理]'',q''[]'',q''[icon-daoru]'',1,,q''[]'',1,,q''[product_gress_code_pr]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_118''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 5,q''[]'',q''[批量异常处理]'',''action_a_product_118'',q''[]'',q''[icon-daoru]'',1,,q''[]'',1,,q''[product_gress_code_pr]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[select 1 from dual]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_110_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[异常处理]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_110_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[异常处理]'',''action_a_product_110_3'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  BEGIN
    FOR abn_rec IN (SELECT *
                      FROM scmdata.t_abnormal abn
                     WHERE abn.abnormal_id IN (@selection)) LOOP
      scmdata.pkg_production_progress.submit_abnormal(p_abn_rec => abn_rec);
    END LOOP;

  END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_118_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[提交]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[abnormal_id_pr]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_118_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[提交]'',''action_a_product_118_1'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[abnormal_id_pr]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
    po_rec scmdata.t_ordered%ROWTYPE;
  BEGIN
    po_rec.order_id             := :order_id;
    po_rec.company_id           := :company_id;
    po_rec.approve_id           := NULL;
    po_rec.approve_time         := NULL;
    po_rec.approve_status := :approve_status;
    scmdata.pkg_production_progress.revoke_approve_orders(po_rec => po_rec);
  END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_130_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[撤销审核]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_130_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[撤销审核]'',''action_a_product_130_2'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  p_abn_rec scmdata.t_abnormal%ROWTYPE;
BEGIN
  FOR i IN (SELECT *
              FROM scmdata.t_abnormal abn
             WHERE abn.abnormal_id IN (@selection)) LOOP

    p_abn_rec.abnormal_id          := i.abnormal_id;
    p_abn_rec.company_id           := %default_company_id%;
    p_abn_rec.confirm_id           := :user_id;
    p_abn_rec.confirm_company_id   := %default_company_id%;
    p_abn_rec.confirm_date         := SYSDATE;
    p_abn_rec.order_id             := i.order_id;
    p_abn_rec.goo_id               := i.goo_id;
    p_abn_rec.handle_opinions      := i.handle_opinions;
    p_abn_rec.is_deduction         := i.is_deduction;
    p_abn_rec.deduction_unit_price := i.deduction_unit_price;
    p_abn_rec.delay_amount         := i.delay_amount;

    scmdata.pkg_production_progress.confirm_abnormal(p_abn_rec => p_abn_rec);

  END LOOP;
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_120_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[批量确认]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[ABNORMAL_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_120_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[批量确认]'',''action_a_product_120_1'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[ABNORMAL_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[DECLARE
  p_abn_rec scmdata.t_abnormal%ROWTYPE;
BEGIN
  FOR i IN (SELECT *
              FROM scmdata.t_abnormal abn
             WHERE abn.abnormal_id IN (@selection)) LOOP

    p_abn_rec.abnormal_id        := i.abnormal_id;
    p_abn_rec.company_id         := %default_company_id%;
    p_abn_rec.order_id           := i.order_id;
    p_abn_rec.goo_id             := i.goo_id;
    p_abn_rec.handle_opinions    := i.handle_opinions;

    scmdata.pkg_production_progress.revoke_abnormal(p_abn_rec => p_abn_rec);

  END LOOP;
END;]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_product_120_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[撤销]'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[abnormal_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_product_120_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[撤销]'',''action_a_product_120_2'',q''[]'',q''[icon-morencaidan]'',1,,q''[]'',1,0,q''[]'',1,0,,q''[abnormal_id]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

