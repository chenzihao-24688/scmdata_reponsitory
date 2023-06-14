BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^DECLARE
 V_DATE DATE :=@EXPECT_ARRIVAL_DATE@;
 V_FLAG NUMBER;
 V_ERRID VARCHAR2(256);
BEGIN
  --校验状态
   SELECT COUNT(1),LISTAGG(A.PREPARE_ORDER_ID,';') WITHIN GROUP(ORDER BY 1) INTO V_FLAG,V_ERRID
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (%Selection%)
  AND A.PREPARE_STATUS NOT IN (1,2);

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||v_errid||'状态不等于“待接单/生产中”，只可对“待接单/生产中”状态的备料单操作修改预计到仓日期！');

  ELSE
    FOR I IN (SELECT * FROM MRP.GREY_PREPARE_ORDER B WHERE B.prepare_order_id IN (%Selection%))LOOP
    MRP.PKG_PREMATERIAL_MANA_SPU.P_UPD_EXARRTIME(PI_USERID => :USER_ID,
                                                 PI_PREID  => I.PREPARE_ORDER_ID,
                                                 PI_TYPE   => 'SPU',
                                                 PI_DATE   => V_DATE,
                                                 V_OPR_COM =>%DEFAULT_COMPANY_ID%);

    END LOOP;
  END IF;


  --

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_230_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改预计到仓日期]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_230_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改预计到仓日期]'',''action_a_prematerial_230_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  v_cpo_rec mrp.color_prepare_order%ROWTYPE;
BEGIN
  FOR cpo_rec IN (SELECT *
                    FROM (SELECT po.*,
                                 row_number() over(PARTITION BY po.group_key ORDER BY po.create_time DESC) rn
                            FROM mrp.color_prepare_order po
                           WHERE po.group_key IN (%selection%)
                             AND po.prepare_status = 1) va
                   WHERE va.rn = 1) LOOP
    --单据状态校验
    --mrp.pkg_color_prepare_order.p_check_prepare_status(p_prepare_order_id => cpo_rec.prepare_order_id,p_prepare_status => 1);

    SELECT *
      INTO v_cpo_rec
      FROM mrp.color_prepare_order t
     WHERE t.prepare_order_id = cpo_rec.prepare_order_id;

    mrp.pkg_color_prepare_order_manager.p_receive_orders(p_company_id => 'b6cc680ad0f599cde0531164a8c0337f',
                                                         p_user_id    => :user_id,
                                                         p_cpo_rec    => v_cpo_rec);
    --操作日志
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                        p_apply_module       => 'prematerial_241',
                                        p_apply_module_desc  => '色布备料单',
                                        p_base_table         => 'COLOR_PREPARE_ORDER',
                                        p_apply_pk_id        => cpo_rec.prepare_order_id,
                                        p_action_type        => 'UPDATE',
                                        p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                        p_log_type           => '00',
                                        p_log_msg            => '备料单号：' || cpo_rec.prepare_order_id || '被接单',
                                        p_operate_field      => 'PREPARE_STATUS',
                                        p_field_type         => 'NUMBER',
                                        p_field_desc         => NULL,
                                        p_old_code           => 1,
                                        p_new_code           => 2,
                                        p_old_value          => '待接单',
                                        p_new_value          => '生产中',
                                        p_operate_company_id => %default_company_id%,
                                        p_user_id            => :user_id,
                                        p_memo               => NULL,
                                        p_memo_desc          => NULL,
                                        p_type               => 2);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_241_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[接单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[GROUP_KEY]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_241_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[接单]'',''action_a_prematerial_241_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[GROUP_KEY]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
v_cr_expect_arrival_time_n DATE := @cr_expect_arrival_time_n@;
BEGIN
  FOR cpo_rec IN (SELECT t.prepare_order_id, t.expect_arrival_time
                    FROM mrp.color_prepare_order t
                   WHERE t.prepare_order_id IN (%selection%)) LOOP
    mrp.pkg_color_prepare_order_manager.p_update_expect_arrival_time(p_prepare_order_id    => cpo_rec.prepare_order_id,
                                                                     p_prepare_status      => 1,
                                                                     p_expect_arrival_time => v_cr_expect_arrival_time_n,
                                                                     p_user_id             => :user_id);
    --操作日志 expect_arrival_time
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                        p_apply_module       => 'a_prematerial_221_1',
                                        p_apply_module_desc  => '色布备料单明细',
                                        p_base_table         => 'COLOR_PREPARE_ORDER',
                                        p_apply_pk_id        => cpo_rec.prepare_order_id,
                                        p_action_type        => 'UPDATE',
                                        p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                        p_log_type           => '04',
                                        p_log_msg            => '备料单号：' || cpo_rec.prepare_order_id || '；' || chr(10) ||
                                                                '预计到仓日期：' || to_char(v_cr_expect_arrival_time_n,'yyyy-mm-dd')||' 12:00:00'  || '【操作前：'|| to_char(cpo_rec.expect_arrival_time,'yyyy-mm-dd hh24:mi:ss') || '】' || '；',
                                        p_operate_field      => 'EXPECT_ARRIVAL_TIME',
                                        p_field_type         => 'DATE',
                                        p_field_desc         => NULL,
                                        p_old_code           => NULL,
                                        p_new_code           => NULL,
                                        p_old_value          => 1,
                                        p_new_value          => 2,
                                        p_operate_company_id => %default_company_id%,
                                        p_user_id            => :user_id,
                                        p_type               => 2);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_241_1_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改预计到仓日期]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_241_1_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改预计到仓日期]'',''action_a_prematerial_241_1_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  v_prepare_order_id VARCHAR2(32) := @cr_prepare_order_id_n@;
  v_unit             VARCHAR2(32) := @cr_unit_n@;
  v_order_num        VARCHAR2(13) := to_char(@cr_order_num_n@,'fm999999990.00');
  v_old_order_num    VARCHAR2(13);
BEGIN
  --获取订单数量旧值
  SELECT MAX(t.order_num)
    INTO v_old_order_num
    FROM mrp.color_prepare_order t
   WHERE t.prepare_order_id = :prepare_order_id;

  --修改订单数量
  mrp.pkg_color_prepare_order_manager.p_update_order_num(p_prepare_order_id => :prepare_order_id,
                                                         p_order_num        => v_order_num,
                                                         p_user_id          => :user_id);
  --操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                      p_apply_module       => 'a_prematerial_221_1',
                                      p_apply_module_desc  => '色布备料单明细',
                                      p_base_table         => 'COLOR_PREPARE_ORDER',
                                      p_apply_pk_id        => :prepare_order_id,
                                      p_action_type        => 'UPDATE',
                                      p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                      p_log_type           => '02',
                                      p_log_msg            => '备料单号：' || :prepare_order_id || '；' || chr(10) ||
                                                              '订单数量：' || v_order_num || '【操作前：'|| v_old_order_num ||'】' || '；',
                                      p_operate_field      => 'ORDER_NUM',
                                      p_field_type         => 'NUMBER',
                                      p_field_desc         => NULL,
                                      p_old_code           => NULL,
                                      p_new_code           => NULL,
                                      p_old_value          => 1,
                                      p_new_value          => 2,
                                      p_operate_company_id => %default_company_id%,
                                      p_user_id            => :user_id,
                                      p_type               => 2);
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_241_1_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改订单数量]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_241_1_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改订单数量]'',''action_a_prematerial_241_1_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  v_cp_material_name_n        VARCHAR2(32) := @cp_material_name_n@;
  v_cp_unit_n                 VARCHAR2(32) := @cp_unit_n@;
  v_cp_color_n                VARCHAR2(32) := @cp_color_n@;
  v_cp_order_num_n            VARCHAR2(32) := @cp_order_num_n@;
  v_cp_unfinish_num_n         VARCHAR2(32) := @cp_unfinish_num_n@;
  v_cp_finished_num_n         VARCHAR2(32) := @cp_finished_num_n@;
  v_cp_finished_rate_n        VARCHAR2(32) := @cp_finished_rate_n@;
  v_cp_ml_cloth_n             VARCHAR2(32) := @cp_ml_cloth_n@;
  v_cp_cur_finished_num_n     VARCHAR2(32) := @cp_cur_finished_num_n@;
  v_cp_is_finished_preorder_n VARCHAR2(32) := @cp_is_finished_preorder_n@;
BEGIN
  mrp.pkg_color_prepare_order_manager.p_finish_product_order(p_product_order_id     => :product_order_id,
                                                             p_cur_finished_num     => v_cp_cur_finished_num_n,
                                                             p_is_finished_preorder => v_cp_is_finished_preorder_n,
                                                             p_company_id           => 'b6cc680ad0f599cde0531164a8c0337f',
                                                             p_user_id              => :user_id);
  --操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                              p_apply_module       => 'a_prematerial_222',
                                              p_apply_module_desc  => '色布备料单',
                                              p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                              p_apply_pk_id        => :product_order_id,
                                              p_action_type        => 'UPDATE',
                                              p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                              p_log_type           => '06',
                                              p_log_msg            => '完成生产单号：' ||:product_order_id || '；' || chr(10) ||
                                                                      '完成数量：' || to_char(to_number(v_cp_finished_num_n) + to_number(v_cp_cur_finished_num_n)) ||'【操作前:' || to_char(v_cp_finished_num_n) || '】' || '；' || chr(10) ||
                                                                      (CASE
                                                                        WHEN v_cp_is_finished_preorder_n = 1 THEN
                                                                         '【生产单状态】:已完成'|| '；'
                                                                        ELSE
                                                                         NULL
                                                                      END) ,
                                              p_operate_field      => 'PRODUCT_STATUS',
                                              p_field_type         => 'NUMBER',
                                              p_field_desc         => NULL,
                                              p_old_code           => 1,
                                              p_new_code           => 2,
                                              p_old_value          => '生产中',
                                              p_new_value          => (CASE
                                                                        WHEN v_cp_is_finished_preorder_n = 1 THEN
                                                                         '已完成'
                                                                        ELSE
                                                                         NULL
                                                                      END),
                                              p_operate_company_id => %default_company_id%,
                                              p_user_id            => :user_id,
                                              p_memo               => NULL,
                                              p_memo_desc          => NULL,
                                              p_type               => 2);
  --记录备料单操作日志
  IF v_cp_is_finished_preorder_n = 1 THEN
  FOR rec IN (SELECT po.prepare_order_id
                FROM mrp.color_prepare_order po
               WHERE po.product_order_id = :product_order_id) LOOP
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'a_prematerial_222',
                                                p_apply_module_desc  => '色布备料单',
                                                p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                p_apply_pk_id        => rec.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                                p_log_type           => '06',
                                                p_log_msg            => '完成生产单号：' || :product_order_id,
                                                p_operate_field      => 'PREPARE_STATUS',
                                                p_field_type         => 'NUMBER',
                                                p_field_desc         => NULL,
                                                p_old_code           => 2,
                                                p_new_code           => 3,
                                                p_old_value          => '生产中',
                                                p_new_value          => '已完成',
                                                p_operate_company_id => %default_company_id%,
                                                p_user_id            => :user_id,
                                                p_memo               => NULL,
                                                p_memo_desc          => NULL,
                                                p_type               => 2);
  END LOOP;
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_242_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[完成订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_242_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[完成订单]'',''action_a_prematerial_242_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  v_cp_material_name_n        VARCHAR2(32) := @cp_material_name_n@;
  v_cp_unit_n                 VARCHAR2(32) := @cp_unit_n@;
  v_cp_color_n                VARCHAR2(32) := @cp_color_n@;
  v_cp_order_num_n            VARCHAR2(32) := @cp_order_num_n@;
  v_cp_unfinish_num_n         VARCHAR2(32) := @cp_unfinish_num_n@;
  v_cp_finished_num_n         VARCHAR2(32) := @cp_finished_num_n@;
  v_cp_finished_rate_n        VARCHAR2(32) := @cp_finished_rate_n@;
  v_cp_ml_cloth_n             VARCHAR2(32) := @cp_ml_cloth_n@;
  v_cp_cur_finished_num_n     VARCHAR2(32) := @cp_cur_finished_num_n@;
  v_cp_is_finished_preorder_n VARCHAR2(32) := @cp_is_finished_preorder_n@;
BEGIN
  mrp.pkg_color_prepare_order_manager.p_finish_product_order(p_product_order_id     => :product_order_id,
                                                             p_cur_finished_num     => v_cp_cur_finished_num_n,
                                                             p_is_finished_preorder => v_cp_is_finished_preorder_n,
                                                             p_company_id           => 'b6cc680ad0f599cde0531164a8c0337f',
                                                             p_user_id              => :user_id);
  --操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                              p_apply_module       => 'a_prematerial_222',
                                              p_apply_module_desc  => '色布备料单',
                                              p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                              p_apply_pk_id        => :product_order_id,
                                              p_action_type        => 'UPDATE',
                                              p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                              p_log_type           => '06',
                                              p_log_msg            => '完成生产单号：' ||:product_order_id || '；' || chr(10) ||
                                                                      '完成数量：' || to_char(to_number(v_cp_finished_num_n) + to_number(v_cp_cur_finished_num_n)) ||'【操作前:' || to_char(v_cp_finished_num_n) || '】' || '；' || chr(10) ||
                                                                      (CASE
                                                                        WHEN v_cp_is_finished_preorder_n = 1 THEN
                                                                         '【生产单状态】:已完成' || '；'
                                                                        ELSE
                                                                         NULL
                                                                      END),
                                              p_operate_field      => 'PRODUCT_STATUS',
                                              p_field_type         => 'NUMBER',
                                              p_field_desc         => NULL,
                                              p_old_code           => 1,
                                              p_new_code           => 2,
                                              p_old_value          => '生产中',
                                              p_new_value          => (CASE
                                                                        WHEN v_cp_is_finished_preorder_n = 1 THEN
                                                                         '已完成'
                                                                        ELSE
                                                                         NULL
                                                                      END),
                                              p_operate_company_id => %default_company_id%,
                                              p_user_id            => :user_id,
                                              p_memo               => NULL,
                                              p_memo_desc          => NULL,
                                              p_type               => 2);

  --记录备料单操作日志
  IF v_cp_is_finished_preorder_n = 1 THEN
  FOR rec IN (SELECT po.prepare_order_id
                FROM mrp.color_prepare_order po
               WHERE po.product_order_id = :product_order_id) LOOP
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'a_prematerial_222',
                                                p_apply_module_desc  => '色布备料单',
                                                p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                p_apply_pk_id        => rec.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                                p_log_type           => '06',
                                                p_log_msg            => '完成生产单号：' || :product_order_id,
                                                p_operate_field      => 'PREPARE_STATUS',
                                                p_field_type         => 'NUMBER',
                                                p_field_desc         => NULL,
                                                p_old_code           => 2,
                                                p_new_code           => 3,
                                                p_old_value          => '生产中',
                                                p_new_value          => '已完成',
                                                p_operate_company_id => %default_company_id%,
                                                p_user_id            => :user_id,
                                                p_memo               => NULL,
                                                p_memo_desc          => NULL,
                                                p_type               => 2);

  END LOOP;
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_222_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[完成订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_222_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[完成订单]'',''action_a_prematerial_222_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^BEGIN
  mrp.pkg_color_prepare_order_manager.p_cancle_color_prepare_order(p_prepare_order_id => :prepare_order_id,
                                                                   p_cancel_reason    => @cr_cancel_reason_n@,
                                                                   p_user_id          => :user_id);
  --操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                      p_apply_module       => 'a_prematerial_221_1',
                                      p_apply_module_desc  => '色布备料单明细',
                                      p_base_table         => 'COLOR_PREPARE_ORDER',
                                      p_apply_pk_id        => :prepare_order_id,
                                      p_action_type        => 'UPDATE',
                                      p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                      p_log_type           => '01',
                                      p_log_msg            => '取消备料单号：' || :prepare_order_id,
                                      p_operate_field      => 'PREPARE_STATUS',
                                      p_field_type         => 'NUMBER',
                                      p_field_desc         => NULL,
                                      p_old_code           => 1,
                                      p_new_code           => 4,
                                      p_old_value          => '待接单',
                                      p_new_value          => '已取消',
                                      p_operate_company_id => %default_company_id%,
                                      p_user_id            => :user_id,
                                      p_memo               => NULL,
                                      p_memo_desc          => NULL,
                                      p_type               => 2);
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_241_1_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消备料单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_241_1_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消备料单]'',''action_a_prematerial_241_1_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  V_FLAG NUMBER;
  V_ERRID VARCHAR2(512);
  V_GROUPKEY  VARCHAR2(64);
  V_SKC        VARCHAR2(512);
  V_ORDERAMOUNT NUMBER;
  V_ORDERCOUNT  NUMBER;
  V_ID    VARCHAR2(64);
  VO_LOG_ID VARCHAR2(64);
BEGIN
  --先校验状态
  SELECT COUNT(1),LISTAGG(A.PREPARE_ORDER_ID,';') WITHIN GROUP(ORDER BY 1) INTO V_FLAG,V_ERRID
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (%Selection%)
  AND A.PREPARE_STATUS <>1;

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||v_errid||'状态不等于“待接单”，只可对“待接单”状态的备料单操作接单！');

  ELSE
  /* SELECT MAX(a.material_spu),MAX(a.pro_supplier_code),MAX(a.mater_supplier_code),MAX(a.whether_inner_mater),
     MAX(a.material_name),MAX(a.unit),MAX(a.supplier_material_name),MAX(a.practical_door_with),
     MAX(a.
     INTO
     FROM  MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (@Selection@);*/

  SELECT MAX(A.GROUP_KEY),LISTAGG(A.GOODS_SKC,'/') WITHIN GROUP (ORDER BY 1),SUM(A.ORDER_NUM),COUNT(1)
    INTO V_GROUPKEY,V_SKC,V_ORDERAMOUNT,V_ORDERCOUNT
    FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (%Selection%);

    --生成生产单
    mrp.PKG_PREMATERIAL_MANA_SPU.P_INS_PREPROORDER(V_GROUPKEY    => V_GROUPKEY,
                                                   V_SKC         => V_SKC,
                                                   V_DOCUNUM     => V_ORDERCOUNT,
                                                   V_ORDERAMOUNT => V_ORDERAMOUNT,
                                                   V_MATERIAL    => 'SPU',
                                                   V_USERID      => :USER_ID,
                                                   V_COMPANY_ID  => 'b6cc680ad0f599cde0531164a8c0337f',
                                                   V_OPR_COM     => %DEFAULT_COMPANY_ID%,
                                                   V_ORDERID     => V_ID);


  --同步数据到备料单(生产单号，状态改为生产中）
  FOR i IN (SELECT * FROM MRP.GREY_PREPARE_ORDER B WHERE B.prepare_order_id IN (%Selection%))LOOP
  VO_LOG_ID :=NULL;
  UPDATE MRP.GREY_PREPARE_ORDER Z
     SET Z.PREPARE_STATUS = 2,
         Z.PRODUCT_ORDER_ID=V_ID,
         Z.RECEIVE_ID = :USER_ID,
         Z.RECEIVE_TIME = SYSDATE,
         Z.Complete_Num = I.ORDER_NUM

      WHERE z.prepare_order_id = I.PREPARE_ORDER_ID ;

       SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_211',
                                         P_BASE_TABLE         => 'GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => I.PREPARE_ORDER_ID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '01',
                                         P_LOG_MSG            => '备料单号' ||
                                                                 I.PREPARE_ORDER_ID||'被接单',
                                         P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                         P_FIELD_TYPE         => 'NUMBER',
                                         P_OLD_CODE           => NULL,
                                         P_NEW_CODE           => NULL,
                                         P_OLD_VALUE          => 0,
                                         P_NEW_VALUE          => 1,
                                         P_USER_ID            => :USER_ID,
                                         P_OPERATE_COMPANY_ID => %DEFAULT_COMPANY_ID%,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);
     /*IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 1);
    END IF;*/

   scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '备料单号' ||
                                                                 I.PREPARE_ORDER_ID||'被接单',
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '接单',
                                                        p_type        => 2)  ;

 END LOOP;
 END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[接单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[接单]'',''action_a_prematerial_210_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 V_REASON VARCHAR2(512):=@CANCEL_REASON@;
 V_FLAG NUMBER;

BEGIN

 IF V_REASON IS NULL THEN
  RAISE_APPLICATION_ERROR(-20002,'请填写取消原因!');

 ELSE

  --校验状态
  SELECT COUNT(1)
  INTO V_FLAG
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID =:PREPARE_ORDER_ID
  AND A.PREPARE_STATUS <>1;

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||:PREPARE_ORDER_ID||'状态不等于“待接单/生产中”，只可对“待接单/生产中”状态的备料单操作取消备料单！');

  ELSE
    mrp.pkg_prematerial_mana_spu.P_CANCEL_PREMATERIAL(V_USERID => :USER_ID,
                                                  V_PREID  => :PREPARE_ORDER_ID,
                                                  V_REASON => V_REASON,
                                                  V_TYPE   => 'SPU',
                                                  V_OPR_COM =>%DEFAULT_COMPANY_ID%);
  END IF;

  END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_230_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消备料单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_230_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消备料单]'',''action_a_prematerial_230_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  V_CPU_REC MRP.GREY_PREPARE_ORDER%ROWTYPE;

BEGIN
  FOR I IN (SELECT *
              FROM (SELECT A.*,
                           ROW_NUMBER() OVER(PARTITION BY A.GROUP_KEY ORDER BY A.CREATE_TIME DESC) RN
                      FROM MRP.GREY_PREPARE_ORDER A
                     WHERE A.GROUP_KEY IN (%SELECTION%)
                       AND A.PREPARE_STATUS = 1) B
             WHERE B.RN = 1) LOOP

    SELECT *
      INTO V_CPU_REC
      FROM MRP.GREY_PREPARE_ORDER Z
     WHERE Z.PREPARE_ORDER_ID = I.PREPARE_ORDER_ID;
    MRP.PKG_PREMATERIAL_MANA_SPU.P_SPU_RECEIVE_ORDERS(PI_USERID     => :USER_ID,
                                                      PI_COMPANY_ID => 'b6cc680ad0f599cde0531164a8c0337f',
                                                      PI_OPR_COM    => %DEFAULT_COMPANY_ID%,
                                                      PI_REC        => V_CPU_REC);

  END LOOP;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_231_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[接单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[GROUP_KEY]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_231_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[接单]'',''action_a_prematerial_231_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[GROUP_KEY]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 v_cr_expect_arrival_time_n DATE := @cr_expect_arrival_time_n@;
BEGIN
  FOR cpo_rec IN (SELECT t.prepare_order_id,t.expect_arrival_time
                    FROM mrp.color_prepare_order t
                   WHERE t.prepare_order_id IN (%selection%)) LOOP
    mrp.pkg_color_prepare_order_manager.p_update_expect_arrival_time(p_prepare_order_id    => cpo_rec.prepare_order_id,
                                                                     p_prepare_status      => 2,
                                                                     p_expect_arrival_time => v_cr_expect_arrival_time_n,
                                                                     p_user_id             => :user_id);

    --操作日志
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                        p_apply_module       => 'a_prematerial_221_1',
                                        p_apply_module_desc  => '色布备料单明细',
                                        p_base_table         => 'COLOR_PREPARE_ORDER',
                                        p_apply_pk_id        => cpo_rec.prepare_order_id,
                                        p_action_type        => 'UPDATE',
                                        p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                        p_log_type           => '04',
                                        p_log_msg            => '备料单号：' || cpo_rec.prepare_order_id || '；' || chr(10) ||
                                                                '预计到仓日期：' || to_char(v_cr_expect_arrival_time_n,'yyyy-mm-dd')||' 12:00:00'  || '【操作前：'|| to_char(cpo_rec.expect_arrival_time,'yyyy-mm-dd hh24:mi:ss') || '】' || '；',
                                        p_operate_field      => 'EXPECT_ARRIVAL_TIME',
                                        p_field_type         => 'DATE',
                                        p_field_desc         => NULL,
                                        p_old_code           => NULL,
                                        p_new_code           => NULL,
                                        p_old_value          => 1,
                                        p_new_value          => 2,
                                        p_operate_company_id => %default_company_id%,
                                        p_user_id            => :user_id,
                                        p_type               => 2);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_242_1_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改预计到仓日期]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_242_1_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改预计到仓日期]'',''action_a_prematerial_242_1_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 V_DATE DATE :=@EXPECT_ARRIVAL_DATE@;
 V_FLAG NUMBER;
 V_ERRID VARCHAR2(256);
BEGIN
  --校验状态
   SELECT COUNT(1),LISTAGG(A.PREPARE_ORDER_ID,';') WITHIN GROUP(ORDER BY 1) INTO V_FLAG,V_ERRID
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (%Selection%)
  AND A.PREPARE_STATUS NOT IN (1,2);

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||v_errid||'状态不等于“待接单/生产中”，只可对“待接单/生产中”状态的备料单操作修改预计到仓日期！');

  ELSE
    FOR I IN (SELECT * FROM MRP.GREY_PREPARE_ORDER B WHERE B.prepare_order_id IN (%Selection%))LOOP
    MRP.PKG_PREMATERIAL_MANA_SPU.P_UPD_EXARRTIME(PI_USERID => :USER_ID,
                                                 PI_PREID  => I.PREPARE_ORDER_ID,
                                                 PI_TYPE   => 'SPU',
                                                 PI_DATE   => V_DATE,
                                                 V_OPR_COM =>%DEFAULT_COMPANY_ID%);

    END LOOP;
  END IF;


  --

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改预计到仓日期]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改预计到仓日期]'',''action_a_prematerial_210_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  V_YIDUANZ VARCHAR2(32):=@TOLERANCE_RATIO@; --溢短装
  V_MATERIAL_NAME VARCHAR2(64) :=@MATERIAL_NAME@;  --物料名称
  V_UNIT    VARCHAR2(32) :=@UNIT_DESC@; --单位
  V_ORDERAMOUT NUMBER :=@ORDER_AMOUNT_DESC@; --订单数量
  V_UNFINISH_AMOUNT NUMBER:=@UNFINISHED_AMOUNT@; --未完成数量
  V_FINISH_AMOUNT NUMBER :=@COMPLETED_AMOUNT@;--已完成数量
  V_RATE VARCHAR2(32) :=@COMPLETION_RATE@; --完成率
  V_COMP_AMOUNT VARCHAR2(64):=TO_CHAR(@COMPLETE_AMOUNT@,'fm999999990.00'); --本次完成数量
  V_ISFINSH VARCHAR2(1) :=@IS_FINISH_PAPRE@; --是否完成
  V_ID VARCHAR2(32) :=:PRODUCT_ORDER_ID;
  V_FLAG            NUMBER;
  V_FLAG2           NUMBER;
BEGIN
   --进行【生产单号】状态校验：【生产单状态】是否等于“生产中”
    --校验状态
  SELECT COUNT(1)
    INTO V_FLAG
    FROM MRP.GREY_PREPARE_PRODUCT_ORDER A
    WHERE A.PRODUCT_ORDER_ID = :PRODUCT_ORDER_ID
      AND A.PRODUCT_STATUS <> 1;

  IF V_FLAG > 0 THEN
     RAISE_APPLICATION_ERROR(-20002,'只可对【生产中】状态的订单操作完成订单!');
  END IF;

    --校验必填项 【完成数量】【是否完成备料单】
    IF  V_COMP_AMOUNT IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'请注意【本次完成数量】未填!');
    END IF;
    IF V_ISFINSH IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'请注意【是否完成备料单】未填!');
    END IF;

   --校验格式 填写7位自然数，小数允许后2位
   V_FLAG2 :=MRP.PKG_PREMATERIAL_MANA_SPU.F_CHECK_NUM(PI_NUM =>V_COMP_AMOUNT);
   IF V_FLAG2 = 0 THEN
     RAISE_APPLICATION_ERROR(-20002,'支持填写7位自然数，小数允许后2位!');
   ELSE
     NULL;
   END IF;


   --【完成数量】＞ 【未完成数量】*（1+3%），报错：【完成数量】不可超过【溢短装】要求
   IF V_COMP_AMOUNT > V_UNFINISH_AMOUNT*(1+3/100) THEN
     RAISE_APPLICATION_ERROR(-20002,'【完成数量】不可超过【溢短装】要求');
   ELSE
     NULL;
   END IF;

   --当【完成数量】≥ 【未完成数量】*（1-3%），【是否完成备料单】选中“否”，报错：【完成数量】≥ 【未完成数量】*（1-3%）时，【是否完成备料单】不可为“否”
   IF (V_COMP_AMOUNT >V_UNFINISH_AMOUNT*(1-3/100) OR V_COMP_AMOUNT = V_UNFINISH_AMOUNT*(1-3/100))  AND V_ISFINSH = 0 THEN
     RAISE_APPLICATION_ERROR(-20002,'【完成数量】≥ 【未完成数量】*（1-3%）时，【是否完成备料单】不可为“否”');

   ELSE
     MRP.PKG_PREMATERIAL_MANA_SPU.P_SPU_FINISH_PRODUCT(PI_PROID    => :PRODUCT_ORDER_ID,
                                                       PI_USERID   => :user_id,
                                                       PI_AMOUNT   => V_COMP_AMOUNT,
                                                       PI_ISFINISH => V_ISFINSH,
                                                       PI_OPCOM    => %DEFAULT_COMPANY_ID%);


   END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[完成订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[完成订单]'',''action_a_prematerial_210_6'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 V_REASON VARCHAR2(512):=@CANCEL_REASON@;
 V_FLAG NUMBER;

BEGIN

 IF V_REASON IS NULL THEN
  RAISE_APPLICATION_ERROR(-20002,'请填写取消原因!');

 ELSE

  --校验状态
  SELECT COUNT(1)
  INTO V_FLAG
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID =:PREPARE_ORDER_ID
  AND A.PREPARE_STATUS <>1;

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||:PREPARE_ORDER_ID||'状态不等于“待接单”，只可对“待接单”状态的备料单操作取消备料单！');

  ELSE
    mrp.pkg_prematerial_mana_spu.P_CANCEL_PREMATERIAL(V_USERID => :USER_ID,
                                                  V_PREID  => :PREPARE_ORDER_ID,
                                                  V_REASON => V_REASON,
                                                  V_TYPE   => 'SPU',
                                                  V_OPR_COM =>%DEFAULT_COMPANY_ID%);
  END IF;

  END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消备料单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消备料单]'',''action_a_prematerial_210_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 V_REASON VARCHAR2(512) :=@CANCEL_REASON@;
 V_FLAG   NUMBER;
BEGIN
  --校验状态
  SELECT COUNT(1)
    INTO V_FLAG
    FROM MRP.GREY_PREPARE_PRODUCT_ORDER A
    WHERE A.PRODUCT_ORDER_ID = :PRODUCT_ORDER_ID
      AND A.PRODUCT_STATUS <> 1;

  IF V_FLAG > 0 THEN
     RAISE_APPLICATION_ERROR(-20002,'只可对【生产中】状态的订单操作取消订单!');
  ELSE
    IF V_REASON IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'请填写取消原因!');
    ELSE
      MRP.PKG_PREMATERIAL_MANA_SPU.P_CANCEL_PROORDER(PI_TYPE   => 'SPU',
                                                     PI_USERID => :USER_ID,
                                                     PI_PROID  => :PRODUCT_ORDER_ID,
                                                     PI_REASON => V_REASON,
                                                     V_OPR_COM =>%DEFAULT_COMPANY_ID% );


    END IF;

  END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消订单]'',''action_a_prematerial_210_5'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 v_cr_expect_arrival_time_n DATE := @cr_expect_arrival_time_n@;
BEGIN
  FOR cpo_rec IN (SELECT t.prepare_order_id,t.expect_arrival_time
                    FROM mrp.color_prepare_order t
                   WHERE t.prepare_order_id IN (%selection%)) LOOP
    mrp.pkg_color_prepare_order_manager.p_update_expect_arrival_time(p_prepare_order_id    => cpo_rec.prepare_order_id,
                                                                     p_prepare_status      => 2,
                                                                     p_expect_arrival_time => v_cr_expect_arrival_time_n,
                                                                     p_user_id             => :user_id);

    --操作日志
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                        p_apply_module       => 'a_prematerial_221_1',
                                        p_apply_module_desc  => '色布备料单明细',
                                        p_base_table         => 'COLOR_PREPARE_ORDER',
                                        p_apply_pk_id        => cpo_rec.prepare_order_id,
                                        p_action_type        => 'UPDATE',
                                        p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                        p_log_type           => '04',
                                        p_log_msg            => '备料单号：' || cpo_rec.prepare_order_id || '；' || chr(10) ||
                                                                '预计到仓日期：' || to_char(v_cr_expect_arrival_time_n,'yyyy-mm-dd') ||' 12:00:00'  || '【操作前：'|| to_char(cpo_rec.expect_arrival_time,'yyyy-mm-dd hh24:mi:ss') || '】' || '；',
                                        p_operate_field      => 'EXPECT_ARRIVAL_TIME',
                                        p_field_type         => 'DATE',
                                        p_field_desc         => NULL,
                                        p_old_code           => NULL,
                                        p_new_code           => NULL,
                                        p_old_value          => 1,
                                        p_new_value          => 2,
                                        p_operate_company_id => %default_company_id%,
                                        p_user_id            => :user_id,
                                        p_type               => 2);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_222_1_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改预计到仓日期]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_222_1_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改预计到仓日期]'',''action_a_prematerial_222_1_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  V_PREID  VARCHAR2(32) :=@PREPARE_ORDER_ID@;
  V_UNIT    VARCHAR2(32) :=@UNIT@;
  V_ORDERAMOUNT VARCHAR2(64) :=TO_CHAR(@ORDER_AMOUNT@,'fm999999990.00');
  V_FLAG    NUMBER;

BEGIN
 --校验状态
  SELECT COUNT(1)
   INTO V_FLAG
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID =:PREPARE_ORDER_ID
  AND A.PREPARE_STATUS <>1;

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||:PREPARE_ORDER_ID||'状态不等于“待接单”，只可对“待接单”状态的备料单操作修改订单数量！');

  ELSE
    MRP.PKG_PREMATERIAL_MANA_SPU.P_UPD_ORDERAMOUNT(PI_USERID      =>  :USER_ID,
                                                   PI_PREID       => :PREPARE_ORDER_ID,
                                                   PI_TYPE        => 'SPU',
                                                   PI_ORDERAMOUNT =>V_ORDERAMOUNT,
                                                   V_OPR_COM =>%DEFAULT_COMPANY_ID% );
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改订单数量]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改订单数量]'',''action_a_prematerial_210_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  v_prepare_order_id VARCHAR2(32) := @cr_prepare_order_id_n@;
  v_unit             VARCHAR2(32) := @cr_unit_n@;
  v_order_num        VARCHAR2(13) := to_char(@cr_order_num_n@,'fm999999990.00');
  v_old_order_num    VARCHAR2(13);
BEGIN
  --获取订单数量旧值
  SELECT MAX(t.order_num)
    INTO v_old_order_num
    FROM mrp.color_prepare_order t
   WHERE t.prepare_order_id = :prepare_order_id;

  --修改订单数量
  mrp.pkg_color_prepare_order_manager.p_update_order_num(p_prepare_order_id => :prepare_order_id,
                                                         p_order_num        => v_order_num,
                                                         p_user_id          => :user_id);

  --操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                      p_apply_module       => 'a_prematerial_221_1',
                                      p_apply_module_desc  => '色布备料单明细',
                                      p_base_table         => 'COLOR_PREPARE_ORDER',
                                      p_apply_pk_id        => :prepare_order_id,
                                      p_action_type        => 'UPDATE',
                                      p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                      p_log_type           => '02',
                                      p_log_msg            => '备料单号：' || :prepare_order_id || '；' || chr(10) ||
                                                              '订单数量：' || v_order_num || '【操作前：'|| v_old_order_num ||'】' || '；',
                                      p_operate_field      => 'ORDER_NUM',
                                      p_field_type         => 'NUMBER',
                                      p_field_desc         => NULL,
                                      p_old_code           => NULL,
                                      p_new_code           => NULL,
                                      p_old_value          => 1,
                                      p_new_value          => 2,
                                      p_operate_company_id => %default_company_id%,
                                      p_user_id            => :user_id,
                                      p_type               => 2);
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_221_1_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改订单数量]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_221_1_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改订单数量]'',''action_a_prematerial_221_1_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  V_FLAG NUMBER;
  V_ERRID VARCHAR2(512);
  V_GROUPKEY  VARCHAR2(64);
  V_SKC        VARCHAR2(512);
  V_ORDERAMOUNT NUMBER;
  V_ORDERCOUNT  NUMBER;
  V_ID    VARCHAR2(64);
  VO_LOG_ID VARCHAR2(32);
BEGIN
  --先校验状态
  SELECT COUNT(1),LISTAGG(A.PREPARE_ORDER_ID,';') WITHIN GROUP(ORDER BY 1) INTO V_FLAG,V_ERRID
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (%Selection%)
  AND A.PREPARE_STATUS <>1;

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||v_errid||'状态不等于“待接单”，只可对“待接单”状态的备料单操作接单！');

  ELSE
  /* SELECT MAX(a.material_spu),MAX(a.pro_supplier_code),MAX(a.mater_supplier_code),MAX(a.whether_inner_mater),
     MAX(a.material_name),MAX(a.unit),MAX(a.supplier_material_name),MAX(a.practical_door_with),
     MAX(a.
     INTO
     FROM  MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (@Selection@);*/

  SELECT MAX(A.GROUP_KEY),LISTAGG(A.GOODS_SKC,'/') WITHIN GROUP (ORDER BY 1),SUM(A.ORDER_NUM),COUNT(1)
    INTO V_GROUPKEY,V_SKC,V_ORDERAMOUNT,V_ORDERCOUNT
    FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (%Selection%);

    --生成生产单
    mrp.PKG_PREMATERIAL_MANA_SPU.P_INS_PREPROORDER(V_GROUPKEY    => V_GROUPKEY,
                                                   V_SKC         => V_SKC,
                                                   V_DOCUNUM     => V_ORDERCOUNT,
                                                   V_ORDERAMOUNT => V_ORDERAMOUNT,
                                                   V_MATERIAL    => 'SPU',
                                                   V_USERID      => :USER_ID,
                                                   V_COMPANY_ID  => 'b6cc680ad0f599cde0531164a8c0337f',
                                                   V_OPR_COM     => %DEFAULT_COMPANY_ID%,
                                                   V_ORDERID     => V_ID);


  --同步数据到备料单(生产单号，状态改为生产中）
  FOR i IN (SELECT * FROM MRP.GREY_PREPARE_ORDER B WHERE B.prepare_order_id IN (%Selection%))LOOP
  UPDATE MRP.GREY_PREPARE_ORDER Z
     SET Z.PREPARE_STATUS = 2,
         Z.PRODUCT_ORDER_ID=V_ID,
         Z.RECEIVE_ID = :USER_ID,
         Z.RECEIVE_TIME = SYSDATE,
         Z.Complete_Num = I.ORDER_NUM
      WHERE z.prepare_order_id = I.PREPARE_ORDER_ID ;

       SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => 'b6cc680ad0f599cde0531164a8c0337f',
                                         P_APPLY_MODULE       => 'a_prematerial_211',
                                         P_BASE_TABLE         => 'MRP.GREY_PREPARE_ORDER',
                                         P_APPLY_PK_ID        => I.PREPARE_ORDER_ID,
                                         P_ACTION_TYPE        => 'UPDATE',
                                         P_LOG_ID             => VO_LOG_ID,
                                         P_LOG_TYPE           => '00',
                                         P_LOG_MSG            => '备料单号' ||
                                                                 I.PREPARE_ORDER_ID||'被接单',
                                         P_OPERATE_FIELD      => 'PREPARE_STATUS',
                                         P_FIELD_TYPE         => 'NUMBER',
                                         P_OLD_CODE           => NULL,
                                         P_NEW_CODE           => NULL,
                                         P_OLD_VALUE          => 0,
                                         P_NEW_VALUE          => 1,
                                         P_USER_ID            => :USER_ID,
                                         P_OPERATE_COMPANY_ID => %DEFAULT_COMPANY_ID%,
                                         P_SEQ_NO             => 1,
                                         PO_LOG_ID            => VO_LOG_ID);
     /*IF vo_log_id IS NOT NULL THEN
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_log_id            => vo_log_id,
                                                p_is_logsmsg        => 1,
                                                p_is_splice_fields  => 0,
                                                p_is_show_memo_desc => 1);
    END IF;*/

   scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => VO_LOG_ID,
                                                        p_log_msg     => '备料单号' ||
                                                                 I.PREPARE_ORDER_ID||'被接单',
                                                        p_class_name  => '坯布备料单管理',
                                                        p_method_name => '接单',
                                                        p_type        => 2)  ;

 END LOOP;
 END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_230_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[接单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_230_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[接单]'',''action_a_prematerial_230_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id => :prepare_order_id,
                                                         p_dict_type   => 'PREMATERIAL_MANA_LOG');
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 3,q''[]'',q''[查看日志]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 3,q''[]'',q''[查看日志]'',''action_a_prematerial_210_7'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id => :prepare_order_id,
                                                         p_dict_type   => 'PREMATERIAL_MANA_LOG');
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 3,q''[]'',q''[查看日志]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 3,q''[]'',q''[查看日志]'',''action_a_prematerial_210_7'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 V_DATE DATE :=@EXPECT_ARRIVAL_DATE@;
 V_FLAG NUMBER;
 V_ERRID VARCHAR2(256);
BEGIN
  --校验状态
   SELECT COUNT(1),LISTAGG(A.PREPARE_ORDER_ID,';') WITHIN GROUP(ORDER BY 1) INTO V_FLAG,V_ERRID
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (%Selection%)
  AND A.PREPARE_STATUS NOT IN (1,2);

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||v_errid||'状态不等于“待接单/生产中”，只可对“待接单/生产中”状态的备料单操作修改预计到仓日期！');

  ELSE
    FOR I IN (SELECT * FROM MRP.GREY_PREPARE_ORDER B WHERE B.prepare_order_id IN (%Selection%))LOOP
    MRP.PKG_PREMATERIAL_MANA_SPU.P_UPD_EXARRTIME(PI_USERID => :USER_ID,
                                                 PI_PREID  => I.PREPARE_ORDER_ID,
                                                 PI_TYPE   => 'SPU',
                                                 PI_DATE   => V_DATE,
                                                 V_OPR_COM =>%DEFAULT_COMPANY_ID%);

    END LOOP;
  END IF;


  --

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改预计到仓日期]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改预计到仓日期]'',''action_a_prematerial_210_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  v_cpop_id   VARCHAR2(32);
  v_cpo_rec   mrp.color_prepare_order%ROWTYPE;
  v_cpop_rec  mrp.color_prepare_product_order%ROWTYPE;
  v_order_num NUMBER := 0;
  v_order_cnt NUMBER := 0;
  v_skc_strs  VARCHAR2(500);
BEGIN
  SELECT *
    INTO v_cpo_rec
    FROM (SELECT po.*
            FROM mrp.color_prepare_order po
           WHERE po.prepare_order_id IN (%selection%)
             AND po.prepare_status = 1) va
   WHERE rownum = 1;

  --色布生产单号
  v_cpop_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'COLOR_PREPARE_PRODUCT_ORDER',
                                              pi_column_name => 'PRODUCT_ORDER_ID',
                                              pi_pre         => (CASE
                                                                  WHEN v_cpo_rec.prepare_object = 0 THEN
                                                                   'CKSC'
                                                                  WHEN v_cpo_rec.prepare_object = 1 THEN
                                                                   'WKSC'
                                                                  ELSE
                                                                   NULL
                                                                END) ||
                                                                to_char(trunc(SYSDATE),
                                                                        'YYYYMMDD'),
                                              pi_serail_num  => 5);
  --从表接单逻辑
  --1.生成色布备料生产单、坯布出入库单表 、坯布仓库存明细
  SELECT SUM(t.order_num),
         COUNT(t.prepare_order_id),
         listagg(t.goods_skc, '/')
    INTO v_order_num, v_order_cnt, v_skc_strs
    FROM mrp.color_prepare_order t
   WHERE t.prepare_order_id IN (%selection%)
     AND t.prepare_status = 1;

  mrp.pkg_color_prepare_order_manager.p_receive_orders_sub(p_company_id => 'b6cc680ad0f599cde0531164a8c0337f',
                                                           p_user_id    => :user_id,
                                                           p_cpop_id    => v_cpop_id,
                                                           p_cpo_rec    => v_cpo_rec,
                                                           p_order_num  => v_order_num,
                                                           p_order_cnt  => v_order_cnt,
                                                           p_relate_skc => v_skc_strs);

  --2.更新色布备料单
  FOR cpo_rec IN (SELECT po.*
                    FROM mrp.color_prepare_order po
                   WHERE po.prepare_order_id IN (%selection%)
                     AND po.prepare_status = 1) LOOP
    mrp.pkg_color_prepare_order_manager.p_generate_color_prepare_order_sub(p_cpo_rec          => cpo_rec,
                                                                           p_user_id          => :user_id,
                                                                           p_product_order_id => v_cpop_id);
    --操作日志
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'a_prematerial_221_1',
                                                p_apply_module_desc  => '色布备料单明细',
                                                p_base_table         => 'COLOR_PREPARE_ORDER',
                                                p_apply_pk_id        => cpo_rec.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                                p_log_type           => '00',
                                                p_log_msg            => '备料单号：' || cpo_rec.prepare_order_id || '被接单',
                                                p_operate_field      => 'PREPARE_STATUS',
                                                p_field_type         => 'NUMBER',
                                                p_field_desc         => NULL,
                                                p_old_code           => 1,
                                                p_new_code           => 2,
                                                p_old_value          => '待接单',
                                                p_new_value          => '生产中',
                                                p_operate_company_id => %default_company_id%,
                                                p_user_id            => :user_id,
                                                p_memo               => NULL,
                                                p_memo_desc          => NULL,
                                                p_type               => 2);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_221_1_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[接单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_221_1_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[接单]'',''action_a_prematerial_221_1_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^BEGIN
  mrp.pkg_color_prepare_order_manager.p_cancle_color_prepare_order(p_prepare_order_id => :prepare_order_id,
                                                                   p_cancel_reason    => @cr_cancel_reason_n@,
                                                                   p_user_id          => :user_id);
  --操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                      p_apply_module       => 'a_prematerial_221_1',
                                      p_apply_module_desc  => '色布备料单明细',
                                      p_base_table         => 'COLOR_PREPARE_ORDER',
                                      p_apply_pk_id        => :prepare_order_id,
                                      p_action_type        => 'UPDATE',
                                      p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                      p_log_type           => '01',
                                      p_log_msg            => '取消备料单号：' || :prepare_order_id,
                                      p_operate_field      => 'PREPARE_STATUS',
                                      p_field_type         => 'NUMBER',
                                      p_field_desc         => NULL,
                                      p_old_code           => 1,
                                      p_new_code           => 4,
                                      p_old_value          => '待接单',
                                      p_new_value          => '已取消',
                                      p_operate_company_id => %default_company_id%,
                                      p_user_id            => :user_id,
                                      p_memo               => NULL,
                                      p_memo_desc          => NULL,
                                      p_type               => 2);
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_221_1_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消备料单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_221_1_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消备料单]'',''action_a_prematerial_221_1_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  V_PREID  VARCHAR2(32) :=@PREPARE_ORDER_ID@;
  V_UNIT    VARCHAR2(32) :=@UNIT@;
  V_ORDERAMOUNT VARCHAR2(64) :=TO_CHAR(@ORDER_AMOUNT@,'fm999999990.00');
  V_FLAG    NUMBER;

BEGIN
 --校验状态
  SELECT COUNT(1)
   INTO V_FLAG
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID =:PREPARE_ORDER_ID
  AND A.PREPARE_STATUS <>1;

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||:PREPARE_ORDER_ID||'状态不等于“待接单”，只可对“待接单”状态的备料单操作修改订单数量！');

  ELSE
    MRP.PKG_PREMATERIAL_MANA_SPU.P_UPD_ORDERAMOUNT(PI_USERID      =>  :USER_ID,
                                                   PI_PREID       => :PREPARE_ORDER_ID,
                                                   PI_TYPE        => 'SPU',
                                                   PI_ORDERAMOUNT =>V_ORDERAMOUNT,
                                                   V_OPR_COM =>%DEFAULT_COMPANY_ID% );
  END IF;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_230_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改订单数量]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_230_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改订单数量]'',''action_a_prematerial_230_3'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 V_DATE DATE :=@EXPECT_ARRIVAL_DATE@;
 V_FLAG NUMBER;
 V_ERRID VARCHAR2(256);
BEGIN
  --校验状态
   SELECT COUNT(1),LISTAGG(A.PREPARE_ORDER_ID,';') WITHIN GROUP(ORDER BY 1) INTO V_FLAG,V_ERRID
  FROM MRP.GREY_PREPARE_ORDER A
  WHERE A.PREPARE_ORDER_ID IN (%Selection%)
  AND A.PREPARE_STATUS NOT IN (1,2);

  IF V_FLAG >0 THEN
    RAISE_APPLICATION_ERROR(-20002,'备料单号:'||v_errid||'状态不等于“待接单/生产中”，只可对“待接单/生产中”状态的备料单操作修改预计到仓日期！');

  ELSE
    FOR I IN (SELECT * FROM MRP.GREY_PREPARE_ORDER B WHERE B.prepare_order_id IN (%Selection%))LOOP
    MRP.PKG_PREMATERIAL_MANA_SPU.P_UPD_EXARRTIME(PI_USERID => :USER_ID,
                                                 PI_PREID  => I.PREPARE_ORDER_ID,
                                                 PI_TYPE   => 'SPU',
                                                 PI_DATE   => V_DATE,
                                                 V_OPR_COM =>%DEFAULT_COMPANY_ID%);

    END LOOP;
  END IF;


  --

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_230_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改预计到仓日期]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_230_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改预计到仓日期]'',''action_a_prematerial_230_4'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 V_REASON VARCHAR2(512) :=@CANCEL_REASON@;
 V_FLAG   NUMBER;
BEGIN
  --校验状态
  SELECT COUNT(1)
    INTO V_FLAG
    FROM MRP.GREY_PREPARE_PRODUCT_ORDER A
    WHERE A.PRODUCT_ORDER_ID = :PRODUCT_ORDER_ID
      AND A.PRODUCT_STATUS <> 1;

  IF V_FLAG > 0 THEN
     RAISE_APPLICATION_ERROR(-20002,'只可对【生产中】状态的订单操作取消订单!');
  ELSE
    IF V_REASON IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'请填写取消原因!');
    ELSE
      MRP.PKG_PREMATERIAL_MANA_SPU.P_CANCEL_PROORDER(PI_TYPE   => 'SPU',
                                                     PI_USERID => :USER_ID,
                                                     PI_PROID  => :PRODUCT_ORDER_ID,
                                                     PI_REASON => V_REASON,
                                                     V_OPR_COM =>%DEFAULT_COMPANY_ID% );


    END IF;

  END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_230_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_230_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消订单]'',''action_a_prematerial_230_5'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^BEGIN
  mrp.pkg_color_prepare_order_manager.p_cancel_product_order(p_product_order_id => :product_order_id,
                                                             p_user_id          => :user_id,
                                                             p_cancel_reason    => @cr_cancel_reason_n@);
  --记录生产单操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                              p_apply_module       => 'a_prematerial_222',
                                              p_apply_module_desc  => '色布备料单',
                                              p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                              p_apply_pk_id        => :product_order_id,
                                              p_action_type        => 'UPDATE',
                                              p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                              p_log_type           => '05',
                                              p_log_msg            => '取消生产单号：' || :product_order_id,
                                              p_operate_field      => 'PREPARE_STATUS',
                                              p_field_type         => 'NUMBER',
                                              p_field_desc         => NULL,
                                              p_old_code           => 1,
                                              p_new_code           => 3,
                                              p_old_value          => '生产中',
                                              p_new_value          => '已取消',
                                              p_operate_company_id => %default_company_id%,
                                              p_user_id            => :user_id,
                                              p_memo               => NULL,
                                              p_memo_desc          => NULL,
                                              p_type               => 2);
  --记录备料单操作日志
  FOR rec IN (SELECT po.prepare_order_id
                FROM mrp.color_prepare_order po
               WHERE po.product_order_id = :product_order_id) LOOP
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'a_prematerial_222',
                                                p_apply_module_desc  => '色布备料单',
                                                p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                p_apply_pk_id        => rec.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                                p_log_type           => '05',
                                                p_log_msg            => '取消生产单号：' || :product_order_id,
                                                p_operate_field      => 'PREPARE_STATUS',
                                                p_field_type         => 'NUMBER',
                                                p_field_desc         => NULL,
                                                p_old_code           => 2,
                                                p_new_code           => 4,
                                                p_old_value          => '生产中',
                                                p_new_value          => '已取消',
                                                p_operate_company_id => %default_company_id%,
                                                p_user_id            => :user_id,
                                                p_memo               => NULL,
                                                p_memo_desc          => NULL,
                                                p_type               => 2);

  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_222_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_222_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消订单]'',''action_a_prematerial_222_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id => :prepare_order_id,
                                                         p_dict_type   => 'PREMATERIAL_MANA_LOG');
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 3,q''[]'',q''[查看日志]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 3,q''[]'',q''[查看日志]'',''action_a_prematerial_210_7'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  V_CPU_REC MRP.GREY_PREPARE_ORDER%ROWTYPE;

BEGIN
  FOR I IN (SELECT *
              FROM (SELECT A.*,
                           ROW_NUMBER() OVER(PARTITION BY A.GROUP_KEY ORDER BY A.CREATE_TIME DESC) RN
                      FROM MRP.GREY_PREPARE_ORDER A
                     WHERE A.GROUP_KEY IN (%SELECTION%)
                       AND A.PREPARE_STATUS = 1) B
             WHERE B.RN = 1) LOOP

    SELECT *
      INTO V_CPU_REC
      FROM MRP.GREY_PREPARE_ORDER Z
     WHERE Z.PREPARE_ORDER_ID = I.PREPARE_ORDER_ID;
    MRP.PKG_PREMATERIAL_MANA_SPU.P_SPU_RECEIVE_ORDERS(PI_USERID     => :USER_ID,
                                                      PI_COMPANY_ID => 'b6cc680ad0f599cde0531164a8c0337f',
                                                      PI_OPR_COM    => %DEFAULT_COMPANY_ID%,
                                                      PI_REC        => V_CPU_REC);

  END LOOP;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_211_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[接单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[GROUP_KEY]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_211_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[接单]'',''action_a_prematerial_211_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[GROUP_KEY]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  v_cpo_rec mrp.color_prepare_order%ROWTYPE;
BEGIN
  FOR cpo_rec IN (SELECT *
                    FROM (SELECT po.*,
                                 row_number() over(PARTITION BY po.group_key ORDER BY po.create_time DESC) rn
                            FROM mrp.color_prepare_order po
                           WHERE po.group_key IN (%selection%)
                             AND po.prepare_status = 1) va
                   WHERE va.rn = 1) LOOP

    --单据状态校验
    --mrp.pkg_color_prepare_order.p_check_prepare_status(p_prepare_order_id => cpo_rec.prepare_order_id,p_prepare_status => 1);

    SELECT *
      INTO v_cpo_rec
      FROM mrp.color_prepare_order t
     WHERE t.prepare_order_id = cpo_rec.prepare_order_id;

    --接单
    mrp.pkg_color_prepare_order_manager.p_receive_orders(p_company_id => 'b6cc680ad0f599cde0531164a8c0337f',
                                                         p_user_id    => :user_id,
                                                         p_cpo_rec    => v_cpo_rec);
    --记录操作日志
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'prematerial_221',
                                                p_apply_module_desc  => '色布备料单',
                                                p_base_table         => 'COLOR_PREPARE_ORDER',
                                                p_apply_pk_id        => cpo_rec.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                                p_log_type           => '00',
                                                p_log_msg            => '备料单号：' || cpo_rec.prepare_order_id || '被接单',
                                                p_operate_field      => 'PREPARE_STATUS',
                                                p_field_type         => 'NUMBER',
                                                p_field_desc         => NULL,
                                                p_old_code           => 1,
                                                p_new_code           => 2,
                                                p_old_value          => '待接单',
                                                p_new_value          => '生产中',
                                                p_operate_company_id => %default_company_id%,
                                                p_user_id            => :user_id,
                                                p_memo               => NULL,
                                                p_memo_desc          => NULL,
                                                p_type               => 2);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_221_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[接单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[GROUP_KEY]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_221_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[接单]'',''action_a_prematerial_221_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[GROUP_KEY]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
 v_cr_expect_arrival_time_n DATE := @cr_expect_arrival_time_n@;
BEGIN
  FOR cpo_rec IN (SELECT t.prepare_order_id, t.expect_arrival_time
                    FROM mrp.color_prepare_order t
                   WHERE t.prepare_order_id IN (%selection%)) LOOP
    mrp.pkg_color_prepare_order_manager.p_update_expect_arrival_time(p_prepare_order_id    => cpo_rec.prepare_order_id,
                                                                     p_prepare_status      => 1,
                                                                     p_expect_arrival_time => v_cr_expect_arrival_time_n,
                                                                     p_user_id             => :user_id);
    --操作日志
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                        p_apply_module       => 'a_prematerial_221_1',
                                        p_apply_module_desc  => '色布备料单明细',
                                        p_base_table         => 'COLOR_PREPARE_ORDER',
                                        p_apply_pk_id        => cpo_rec.prepare_order_id,
                                        p_action_type        => 'UPDATE',
                                        p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                        p_log_type           => '04',
                                        p_log_msg            => '备料单号：' || cpo_rec.prepare_order_id || '；' || chr(10) ||
                                                                '预计到仓日期：' || to_char(v_cr_expect_arrival_time_n,'yyyy-mm-dd') ||' 12:00:00'  || '【操作前：' || to_char(cpo_rec.expect_arrival_time,'yyyy-mm-dd hh24:mi:ss') || '】' || '；',
                                        p_operate_field      => 'EXPECT_ARRIVAL_TIME',
                                        p_field_type         => 'DATE',
                                        p_field_desc         => NULL,
                                        p_old_code           => NULL,
                                        p_new_code           => NULL,
                                        p_old_value          => 1,
                                        p_new_value          => 2,
                                        p_operate_company_id => %default_company_id%,
                                        p_user_id            => :user_id,
                                        p_type               => 2);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_221_1_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[修改预计到仓日期]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_221_1_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[修改预计到仓日期]'',''action_a_prematerial_221_1_2'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  V_YIDUANZ VARCHAR2(32):=@TOLERANCE_RATIO@; --溢短装
  V_MATERIAL_NAME VARCHAR2(64) :=@MATERIAL_NAME@;  --物料名称
  V_UNIT    VARCHAR2(32) :=@UNIT_DESC@; --单位
  V_ORDERAMOUT NUMBER :=@ORDER_AMOUNT_DESC@; --订单数量
  V_UNFINISH_AMOUNT NUMBER:=@UNFINISHED_AMOUNT@; --未完成数量
  V_FINISH_AMOUNT NUMBER :=@COMPLETED_AMOUNT@;--已完成数量
  V_RATE VARCHAR2(32) :=@COMPLETION_RATE@; --完成率
  V_COMP_AMOUNT VARCHAR2(64):=TO_CHAR(@COMPLETE_AMOUNT@,'fm999999990.00'); --本次完成数量
  V_ISFINSH VARCHAR2(1) :=@IS_FINISH_PAPRE@; --是否完成
  V_ID VARCHAR2(32) :=:PRODUCT_ORDER_ID;
  V_FLAG            NUMBER;
  V_FLAG2           NUMBER;
BEGIN
   --进行【生产单号】状态校验：【生产单状态】是否等于“生产中”
    --校验状态
  SELECT COUNT(1)
    INTO V_FLAG
    FROM MRP.GREY_PREPARE_PRODUCT_ORDER A
    WHERE A.PRODUCT_ORDER_ID = :PRODUCT_ORDER_ID
      AND A.PRODUCT_STATUS <> 1;

  IF V_FLAG > 0 THEN
     RAISE_APPLICATION_ERROR(-20002,'只可对【生产中】状态的订单操作完成订单!');
  END IF;

    --校验必填项 【完成数量】【是否完成备料单】
    IF  V_COMP_AMOUNT IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'请注意【本次完成数量】未填!');
    END IF;
    IF V_ISFINSH IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,'请注意【是否完成备料单】未填!');
    END IF;

   --校验格式 填写7位自然数，小数允许后2位
   V_FLAG2 :=MRP.PKG_PREMATERIAL_MANA_SPU.F_CHECK_NUM(PI_NUM =>V_COMP_AMOUNT);
   IF V_FLAG2 = 0 THEN
     RAISE_APPLICATION_ERROR(-20002,'支持填写7位自然数，小数允许后2位!');
   ELSE
     NULL;
   END IF;

   --【完成数量】＞ 【未完成数量】*（1+3%），报错：【完成数量】不可超过【溢短装】要求
   IF V_COMP_AMOUNT > V_UNFINISH_AMOUNT*(1+3/100) THEN
     RAISE_APPLICATION_ERROR(-20002,'【完成数量】不可超过【溢短装】要求');
   ELSE
     NULL;
   END IF;


   --当【完成数量】≥ 【未完成数量】*（1-3%），【是否完成备料单】选中“否”，报错：【完成数量】≥ 【未完成数量】*（1-3%）时，【是否完成备料单】不可为“否”
   IF (V_COMP_AMOUNT >V_UNFINISH_AMOUNT*(1-3/100) OR V_COMP_AMOUNT = V_UNFINISH_AMOUNT*(1-3/100))  AND V_ISFINSH = 0 THEN
     RAISE_APPLICATION_ERROR(-20002,'【完成数量】≥ 【未完成数量】*（1-3%）时，【是否完成备料单】不可为“否”');

   ELSE
     MRP.PKG_PREMATERIAL_MANA_SPU.P_SPU_FINISH_PRODUCT(PI_PROID    => :PRODUCT_ORDER_ID,
                                                       PI_USERID   => :user_id,
                                                       PI_AMOUNT   => V_COMP_AMOUNT,
                                                       PI_ISFINISH => V_ISFINSH,
                                                       PI_OPCOM    => %DEFAULT_COMPANY_ID%);


   END IF;

END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_230_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[完成订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_230_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[完成订单]'',''action_a_prematerial_230_6'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id => :prepare_order_id,
                                                         p_dict_type   => 'PREMATERIAL_MANA_LOG');
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_210_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 3,q''[]'',q''[查看日志]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_210_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 3,q''[]'',q''[查看日志]'',''action_a_prematerial_210_7'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^DECLARE
  v_cpop_id   VARCHAR2(32);
  v_cpo_rec   mrp.color_prepare_order%ROWTYPE;
  v_cpop_rec  mrp.color_prepare_product_order%ROWTYPE;
  v_order_num NUMBER := 0;
  v_order_cnt NUMBER := 0;
  v_skc_strs  VARCHAR2(500);
BEGIN
  SELECT *
    INTO v_cpo_rec
    FROM (SELECT po.*
            FROM mrp.color_prepare_order po
           WHERE po.prepare_order_id IN (%selection%)
             AND po.prepare_status = 1) va
   WHERE rownum = 1;

  --色布生产单号
  v_cpop_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'COLOR_PREPARE_PRODUCT_ORDER',
                                              pi_column_name => 'PRODUCT_ORDER_ID',
                                              pi_pre         => (CASE
                                                                  WHEN v_cpo_rec.prepare_object = 0 THEN
                                                                   'CKSC'
                                                                  WHEN v_cpo_rec.prepare_object = 1 THEN
                                                                   'WKSC'
                                                                  ELSE
                                                                   NULL
                                                                END) ||
                                                                to_char(trunc(SYSDATE),
                                                                        'YYYYMMDD'),
                                              pi_serail_num  => 5);
  --从表接单逻辑
  --1.生成色布备料生产单、坯布出入库单表 、坯布仓库存明细
  SELECT SUM(t.order_num),
         COUNT(t.prepare_order_id),
         listagg(t.goods_skc, '/')
    INTO v_order_num, v_order_cnt, v_skc_strs
    FROM mrp.color_prepare_order t
   WHERE t.prepare_order_id IN (%selection%)
     AND t.prepare_status = 1;

  mrp.pkg_color_prepare_order_manager.p_receive_orders_sub(p_company_id => 'b6cc680ad0f599cde0531164a8c0337f',
                                                           p_user_id    => :user_id,
                                                           p_cpop_id    => v_cpop_id,
                                                           p_cpo_rec    => v_cpo_rec,
                                                           p_order_num  => v_order_num,
                                                           p_order_cnt  => v_order_cnt,
                                                           p_relate_skc => v_skc_strs);

  --2.更新色布备料单
  FOR cpo_rec IN (SELECT po.*
                    FROM mrp.color_prepare_order po
                   WHERE po.prepare_order_id IN (%selection%)
                     AND po.prepare_status = 1) LOOP
    mrp.pkg_color_prepare_order_manager.p_generate_color_prepare_order_sub(p_cpo_rec          => cpo_rec,
                                                                           p_user_id          => :user_id,
                                                                           p_product_order_id => v_cpop_id);

    --操作日志
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                        p_apply_module       => 'prematerial_241_1',
                                        p_apply_module_desc  => '色布备料单明细',
                                        p_base_table         => 'COLOR_PREPARE_ORDER',
                                        p_apply_pk_id        => cpo_rec.prepare_order_id,
                                        p_action_type        => 'UPDATE',
                                        p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                        p_log_type           => '00',
                                        p_log_msg            => '备料单号：' || cpo_rec.prepare_order_id || '被接单',
                                        p_operate_field      => 'PREPARE_STATUS',
                                        p_field_type         => 'NUMBER',
                                        p_field_desc         => NULL,
                                        p_old_code           => 1,
                                        p_new_code           => 2,
                                        p_old_value          => '待接单',
                                        p_new_value          => '生产中',
                                        p_operate_company_id => %default_company_id%,
                                        p_user_id            => :user_id,
                                        p_memo               => NULL,
                                        p_memo_desc          => NULL,
                                        p_type               => 2);
  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_241_1_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[接单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_241_1_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[接单]'',''action_a_prematerial_241_1_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,2,q''[PREPARE_ORDER_ID]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^BEGIN
  mrp.pkg_color_prepare_order_manager.p_cancel_product_order(p_product_order_id => :product_order_id,
                                                             p_user_id          => :user_id,
                                                             p_cancel_reason    => @cr_cancel_reason_n@);
  --记录生产单操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                              p_apply_module       => 'a_prematerial_222',
                                              p_apply_module_desc  => '色布备料单',
                                              p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                              p_apply_pk_id        => :product_order_id,
                                              p_action_type        => 'UPDATE',
                                              p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                              p_log_type           => '05',
                                              p_log_msg            => '取消生产单号：' || :product_order_id,
                                              p_operate_field      => 'PREPARE_STATUS',
                                              p_field_type         => 'NUMBER',
                                              p_field_desc         => NULL,
                                              p_old_code           => 1,
                                              p_new_code           => 3,
                                              p_old_value          => '生产中',
                                              p_new_value          => '已取消',
                                              p_operate_company_id => %default_company_id%,
                                              p_user_id            => :user_id,
                                              p_memo               => NULL,
                                              p_memo_desc          => NULL,
                                              p_type               => 2);
  --记录备料单操作日志
  FOR rec IN (SELECT po.prepare_order_id
                FROM mrp.color_prepare_order po
               WHERE po.product_order_id = :product_order_id) LOOP
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'a_prematerial_222',
                                                p_apply_module_desc  => '色布备料单',
                                                p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                p_apply_pk_id        => rec.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                                p_log_type           => '05',
                                                p_log_msg            => '取消生产单号：' || :product_order_id,
                                                p_operate_field      => 'PREPARE_STATUS',
                                                p_field_type         => 'NUMBER',
                                                p_field_desc         => NULL,
                                                p_old_code           => 2,
                                                p_new_code           => 4,
                                                p_old_value          => '生产中',
                                                p_new_value          => '已取消',
                                                p_operate_company_id => %default_company_id%,
                                                p_user_id            => :user_id,
                                                p_memo               => NULL,
                                                p_memo_desc          => NULL,
                                                p_type               => 2);

  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_242_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_242_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消订单]'',''action_a_prematerial_242_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^BEGIN
  mrp.pkg_color_prepare_order_manager.p_cancel_product_order(p_product_order_id => :product_order_id,
                                                             p_user_id          => :user_id,
                                                             p_cancel_reason    => @cr_cancel_reason_n@);
  --记录生产单操作日志
  scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                              p_apply_module       => 'a_prematerial_222',
                                              p_apply_module_desc  => '色布备料单',
                                              p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                              p_apply_pk_id        => :product_order_id,
                                              p_action_type        => 'UPDATE',
                                              p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                              p_log_type           => '05',
                                              p_log_msg            => '取消生产单号：' || :product_order_id,
                                              p_operate_field      => 'PREPARE_STATUS',
                                              p_field_type         => 'NUMBER',
                                              p_field_desc         => NULL,
                                              p_old_code           => 1,
                                              p_new_code           => 3,
                                              p_old_value          => '生产中',
                                              p_new_value          => '已取消',
                                              p_operate_company_id => %default_company_id%,
                                              p_user_id            => :user_id,
                                              p_memo               => NULL,
                                              p_memo_desc          => NULL,
                                              p_type               => 2);
  --记录备料单操作日志
  FOR rec IN (SELECT po.prepare_order_id
                FROM mrp.color_prepare_order po
               WHERE po.product_order_id = :product_order_id) LOOP
    scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                                p_apply_module       => 'a_prematerial_222',
                                                p_apply_module_desc  => '色布备料单',
                                                p_base_table         => 'COLOR_PREPARE_PRODUCT_ORDER',
                                                p_apply_pk_id        => rec.prepare_order_id,
                                                p_action_type        => 'UPDATE',
                                                p_log_dict_type      => 'PREMATERIAL_MANA_LOG',
                                                p_log_type           => '05',
                                                p_log_msg            => '取消生产单号：' || :product_order_id,
                                                p_operate_field      => 'PREPARE_STATUS',
                                                p_field_type         => 'NUMBER',
                                                p_field_desc         => NULL,
                                                p_old_code           => 2,
                                                p_new_code           => 4,
                                                p_old_value          => '生产中',
                                                p_new_value          => '已取消',
                                                p_operate_company_id => %default_company_id%,
                                                p_user_id            => :user_id,
                                                p_memo               => NULL,
                                                p_memo_desc          => NULL,
                                                p_type               => 2);

  END LOOP;
END;^';
  CV2 CLOB:=q'^^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ACTION WHERE ELEMENT_ID = ''action_a_prematerial_242_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ACTION SET (ACTION_TYPE,CALL_ID,CAPTION,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) = (SELECT 4,q''[]'',q''[取消订单]'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''action_a_prematerial_242_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ACTION (ACTION_TYPE,CALL_ID,CAPTION,ELEMENT_ID,FILTER_EXPRESS,ICON_NAME,MULTI_PAGE_FLAG,OPERATE_MODE,PORT_ID,PORT_TYPE,PRE_FLAG,QUERY_FIELDS,REFRESH_FLAG,SELECTION_FLAG,SELECTION_METHOD,SELECT_FIELDS,UPDATE_FIELDS,ACTION_SQL,LOCK_SQL,PORT_SQL) SELECT 4,q''[]'',q''[取消订单]'',''action_a_prematerial_242_1'',q''[]'',q''[]'',1,,q''[]'',1,,q''[]'',1,0,1,q''[]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

