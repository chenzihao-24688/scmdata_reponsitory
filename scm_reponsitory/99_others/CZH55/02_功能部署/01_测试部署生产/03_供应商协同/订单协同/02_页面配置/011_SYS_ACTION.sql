BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[{DECLARE
  v_jugnum      NUMBER(4);
  v_catejug     NUMBER(4);
  v_pcatejug    NUMBER(4);
  v_scatejug    NUMBER(4);
  v_compid      VARCHAR2(32) := %default_company_id%;
  v_cst_comp_id VARCHAR2(32);
  v_order_ids   VARCHAR2(2048);
  v_gooids      VARCHAR2(2048);
  ret_sql       CLOB;
BEGIN
  SELECT COUNT(DISTINCT d.company_id),
         listagg(d.order_id, ',') || ',',
         listagg(e.goo_id, ',') || ',',
         MAX(d.company_id) cst_comp_id
    INTO v_jugnum, v_order_ids, v_gooids, v_cst_comp_id
    FROM (SELECT a.order_id, a.order_code, a.supplier_code, a.company_id
            FROM scmdata.t_ordered a
           INNER JOIN (SELECT c.company_id, c.company_name, b.supplier_code
                        FROM scmdata.t_supplier_info b
                       INNER JOIN scmdata.sys_company c
                          ON b.company_id = c.company_id
                       WHERE b.supplier_company_id = v_compid) d --供应商 对应的客户
              ON a.company_id = d.company_id --客户
             AND a.supplier_code = d.supplier_code --供应商
           WHERE a.order_id IN (@selection)) d
   INNER JOIN scmdata.t_orders e
      ON d.order_code = e.order_id
     AND d.company_id = e.company_id;

  IF v_jugnum > 1 THEN
    raise_application_error(-20002, '所选订单客户不一致，无法批量指定！');
  ELSE
    SELECT COUNT(DISTINCT category),
           COUNT(DISTINCT product_cate),
           COUNT(DISTINCT samll_category)
      INTO v_catejug, v_pcatejug, v_scatejug
      FROM scmdata.t_commodity_info
     WHERE regexp_count(v_gooids, goo_id || ',') > 0
       AND company_id = v_cst_comp_id;

    IF v_catejug > 1 OR v_pcatejug > 1 OR v_scatejug > 1 THEN
      raise_application_error(-20002,
                              '所选订单商品“行业分类+生产类别+产品子类”不一致，无法批量指定！');
    ELSE
      --取供应商对应客户的合作工厂
      ret_sql := 'SELECT DISTINCT ''' || v_order_ids || ''' order_id,
                  fc.supplier_code factory_code,
                  fc.supplier_company_name factory_name
    FROM (SELECT a.supplier_info_id, a.company_id
            FROM scmdata.t_supplier_info a
           WHERE a.supplier_company_id = ''' || v_compid || '''
             AND a.company_id = ''' || v_cst_comp_id || '''
             AND a.status = 1) sp
   INNER JOIN scmdata.t_coop_factory b
      ON sp.supplier_info_id = b.supplier_info_id
     AND sp.company_id = b.company_id
     AND b.pause = 0
   INNER JOIN scmdata.t_supplier_info fc
      ON b.fac_sup_info_id = fc.supplier_info_id
     AND b.company_id = fc.company_id
     AND fc.status = 1
     AND instr(fc.cooperation_model, ''OF'') > 0
   INNER JOIN scmdata.t_coop_scope tc
      ON fc.supplier_info_id = tc.supplier_info_id
     AND fc.company_id = tc.company_id
     AND tc.pause = 0
     AND EXISTS
   (SELECT 1
            FROM scmdata.t_ordered po
           INNER JOIN scmdata.t_orders pln
              ON po.order_code = pln.order_id
               AND po.company_id = pln.company_id
           INNER JOIN scmdata.t_commodity_info tf
              ON pln.goo_id = tf.goo_id
             AND pln.company_id = tf.company_id
           WHERE instr(''' || v_order_ids ||''',po.order_id) > 0
             AND po.company_id = ''' || v_cst_comp_id || '''
             AND instr(tc.coop_classification, tf.category) > 0
             AND instr(tc.coop_product_cate, tf.product_cate) > 0
             AND instr(tc.coop_subcategory, tf.samll_category) > 0)';
    END IF;
  END IF;

  @strresult := ret_sql;
END;
}]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_order_201''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 6,q''[]'',q''[指定工厂]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[PRODUCT_FACTORY]'',1,0,2,q''[ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_order_201''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 6,q''[]'',q''[指定工厂]'',''action_a_order_201'',q''[]'',q''[]'',1,,q''[]'',1,,q''[PRODUCT_FACTORY]'',1,0,2,q''[ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

