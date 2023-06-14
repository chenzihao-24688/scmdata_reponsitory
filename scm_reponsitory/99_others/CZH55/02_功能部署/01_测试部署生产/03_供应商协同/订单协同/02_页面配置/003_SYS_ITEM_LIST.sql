BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_order_201''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_order_201''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_order_201'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh add 20211209_v0
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_order_list(p_item_id => 'a_order_201_0');
  @strresult := v_sql;
END;}
/*
WITH gdic AS
 (SELECT group_dict_name, group_dict_value, group_dict_type
    FROM scmdata.sys_group_dict),
supp_info AS
 (SELECT company_id,
         supplier_company_id,
         supplier_company_name,
         supplier_code
    FROM scmdata.t_supplier_info)
SELECT z.order_code,
       z.order_status,
       gd_a.group_dict_name order_status_desc,
       z.company_name customer,
       x.rela_goo_id,
       x.style_number,
       y.factory_code,
       sp_a.supplier_company_name product_factory,
       z.delivery_date,
       MAX(y.delivery_date) over(PARTITION BY y.order_id, y.company_id) latest_delivery_date,
       y.order_amount,
       y.order_price single_price,
       y.order_price * y.order_amount order_sum,
       z.memo,
       gd_b.group_dict_name order_type,
       x.style_name,
       x.goo_name,
       gd_c.group_dict_name category,
       gd_d.group_dict_name product_cate,
       cd_a.company_dict_name samll_category_gd,
       (SELECT listagg(company_user_name, ',')
          FROM scmdata.sys_company_user
         WHERE inner_user_id = z.send_order
           AND company_id = z.company_id) send_order,
       z.deal_follower,
       CASE
         WHEN z.send_by_sup = 0 THEN
          '否'
         WHEN z.send_by_sup = 1 THEN
          '是'
       END send_by_sup,
       z.send_order_date send_order_date,
       to_char(z.finish_time_scm, 'yyyy-MM-dd') finish_time_scm,
       x.goo_id,
       su.company_user_name update_id,
       z.update_time,
       z.order_id
  FROM (SELECT a.order_id,
               a.order_code,
               a.order_status,
               a.supplier_code,
               a.memo,
               a.order_type,
               a.send_order,
               a.send_order_date,
               a.finish_time_scm,
               a.company_id,
               a.update_id,
               a.update_time,
               a.delivery_date,
               a.deal_follower,
               a.send_by_sup,
               d.company_name
          FROM scmdata.t_ordered a
         INNER JOIN (SELECT b.company_id, c.company_name,b.supplier_code
                      FROM scmdata.t_supplier_info b
                     INNER JOIN scmdata.sys_company c
                        ON b.company_id = c.company_id
                     WHERE b.supplier_company_id = %default_company_id%) d
         ON a.company_id = d.company_id
         AND a.supplier_code = d.supplier_code
           AND a.order_status IN ('OS01', 'OS00')) z
 INNER JOIN scmdata.t_orders y
    ON z.order_code = y.order_id
   AND z.company_id = y.company_id
  LEFT JOIN gdic gd_a
    ON gd_a.group_dict_value = z.order_status
   AND gd_a.group_dict_type = 'ORDER_STATUS'
  LEFT JOIN gdic gd_b
    ON gd_b.group_dict_value = z.order_type
   AND gd_b.group_dict_type = 'ORDER_TYPE'
  LEFT JOIN scmdata.t_supplier_info sp_a
    ON sp_a.supplier_code = y.factory_code
   AND sp_a.company_id = z.company_id
  LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = z.company_id
   AND su.user_id = z.update_id
 INNER JOIN scmdata.t_commodity_info x
    ON x.goo_id = y.goo_id
   AND x.company_id = y.company_id
 INNER JOIN gdic gd_c
    ON gd_c.group_dict_value = x.category
   AND gd_c.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN gdic gd_d
    ON gd_d.group_dict_value = x.product_cate
   AND gd_d.group_dict_type = x.category
 INNER JOIN scmdata.sys_company_dict cd_a
    ON cd_a.company_dict_value = x.samll_category
   AND cd_a.company_dict_type = x.product_cate
   AND cd_a.company_id = z.company_id
 WHERE ((%is_company_admin% = 1) OR
       scmdata.instr_priv(p_str1  => scmdata.pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                                        p_key     => 'COL_2'),
                           p_str2  => x.category,
                           p_split => ';') > 0)*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[DECLARE
  v_org_fac_code VARCHAR2(32);
BEGIN
  FOR i IN (SELECT a.order_id, a.company_id,a.supplier_code
              FROM scmdata.t_ordered a
             INNER JOIN (SELECT b.company_id, c.company_name, b.supplier_code
                          FROM scmdata.t_supplier_info b
                         INNER JOIN scmdata.sys_company c
                            ON b.company_id = c.company_id
                         WHERE b.supplier_company_id = %default_company_id%) d
                ON a.company_id = d.company_id
               AND a.supplier_code = d.supplier_code
             WHERE instr(:order_id, a.order_id) > 0) LOOP

    SELECT MAX(new_designate_factory)
      INTO v_org_fac_code
      FROM (SELECT t.new_designate_factory
              FROM scmdata.t_order_log t
             WHERE order_id = i.order_id
               AND company_id = i.company_id
             ORDER BY t.operate_time DESC)
     WHERE rownum = 1;

    --czh add 日志记录 begin
    pkg_supp_order_coor.p_insert_order_log(p_company_id            => i.company_id,
                                           p_order_id              => i.order_id,
                                           p_log_type              => '修改信息-指定工厂',
                                           p_old_designate_factory => nvl(v_org_fac_code,supplier_code),
                                           p_new_designate_factory => :factory_code,
                                           p_operator              => 'SUPP',
                                           p_operate_person        => :user_id);
    --end

    UPDATE scmdata.t_orders
       SET factory_code = :factory_code
     WHERE (order_id, company_id) IN
           (SELECT order_code, company_id
              FROM scmdata.t_ordered
             WHERE company_id = i.company_id
               AND regexp_count(order_id || ',', i.order_id || ',') > 0);

    UPDATE scmdata.t_production_progress
       SET factory_code = :factory_code
     WHERE (order_id, goo_id, company_id) IN
           (SELECT order_id, goo_id, company_id
              FROM scmdata.t_orders
             WHERE (order_id, company_id) IN
                   (SELECT order_id, company_id
                      FROM scmdata.t_ordered
                     WHERE company_id = i.company_id
                       AND regexp_count(order_id || ',', i.order_id || ',') > 0));

    UPDATE scmdata.t_ordered
       SET update_id = %current_userid%, update_time = SYSDATE
     WHERE regexp_count(order_id || ',', i.order_id || ',') > 0
       AND company_id = i.company_id;

  END LOOP;
END;]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_order_201_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS,LOG_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[ORDER_CODE,RELA_GOO_ID,CUSTOMER,STYLE_NUMBER]'',3,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_order_201_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_order_201_0'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS,LOG_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[ORDER_CODE,RELA_GOO_ID,CUSTOMER,STYLE_NUMBER]'',3,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh add 20211209_v0
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_order_list(p_item_id => 'a_order_201_1');
  @strresult := v_sql;
END;}
/*
WITH gdic AS
 (SELECT group_dict_name, group_dict_value, group_dict_type
    FROM scmdata.sys_group_dict),
supp_info AS
 (SELECT company_id,
         supplier_company_id,
         supplier_company_name,
         supplier_code
    FROM scmdata.t_supplier_info)
SELECT z.order_code,
       z.order_status,
       gd_a.group_dict_name order_status_desc,
       z.company_name customer,
       x.rela_goo_id,
       x.style_number,
       y.factory_code,
       sp_a.supplier_company_name product_factory,
       z.delivery_date,
       MAX(y.delivery_date) over(PARTITION BY y.order_id, y.company_id) latest_delivery_date,
       y.order_amount,
       y.order_price single_price,
       y.order_price * y.order_amount order_sum,
       z.memo,
       gd_b.group_dict_name order_type,
       x.style_name,
       x.goo_name,
       gd_c.group_dict_name category,
       gd_d.group_dict_name product_cate,
       cd_a.company_dict_name samll_category_gd,
       (SELECT listagg(company_user_name, ',')
          FROM scmdata.sys_company_user
         WHERE inner_user_id = z.send_order
           AND company_id = z.company_id) send_order,
       z.deal_follower,
       CASE
         WHEN z.send_by_sup = 0 THEN
          '否'
         WHEN z.send_by_sup = 1 THEN
          '是'
       END send_by_sup,
       z.send_order_date send_order_date,
       to_char(z.finish_time_scm, 'yyyy-MM-dd') finish_time_scm,
       x.goo_id,
       su.company_user_name update_id,
       z.update_time,
       z.order_id
  FROM (SELECT a.order_id,
               a.order_code,
               a.order_status,
               a.supplier_code,
               a.memo,
               a.order_type,
               a.send_order,
               a.send_order_date,
               a.finish_time_scm,
               a.company_id,
               a.update_id,
               a.update_time,
               a.delivery_date,
               a.deal_follower,
               a.send_by_sup,
               d.company_name
          FROM scmdata.t_ordered a
         INNER JOIN (SELECT b.company_id, c.company_name, b.supplier_code
                      FROM scmdata.t_supplier_info b
                     INNER JOIN scmdata.sys_company c
                        ON b.company_id = c.company_id
                     WHERE b.supplier_company_id = %default_company_id%) d
            ON a.company_id = d.company_id
           AND a.supplier_code = d.supplier_code
           AND a.order_status IN ('OS02', 'OS03')) z
 INNER JOIN scmdata.t_orders y
    ON z.order_code = y.order_id
   AND z.company_id = y.company_id
  LEFT JOIN gdic gd_a
    ON gd_a.group_dict_value = z.order_status
   AND gd_a.group_dict_type = 'ORDER_STATUS'
  LEFT JOIN gdic gd_b
    ON gd_b.group_dict_value = z.order_type
   AND gd_b.group_dict_type = 'ORDER_TYPE'
  LEFT JOIN scmdata.t_supplier_info sp_a
    ON sp_a.supplier_code = y.factory_code
   AND sp_a.company_id = z.company_id
  LEFT JOIN scmdata.sys_company_user su
    ON su.company_id = z.company_id
   AND su.user_id = z.update_id
 INNER JOIN scmdata.t_commodity_info x
    ON x.goo_id = y.goo_id
   AND x.company_id = y.company_id
 INNER JOIN gdic gd_c
    ON gd_c.group_dict_value = x.category
   AND gd_c.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN gdic gd_d
    ON gd_d.group_dict_value = x.product_cate
   AND gd_d.group_dict_type = x.category
 INNER JOIN scmdata.sys_company_dict cd_a
    ON cd_a.company_dict_value = x.samll_category
   AND cd_a.company_dict_type = x.product_cate
   AND cd_a.company_id = z.company_id
 WHERE ((%is_company_admin% = 1) OR
       scmdata.instr_priv(p_str1  => scmdata.pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,
                                                                        p_key     => 'COL_2'),
                           p_str2  => x.category,
                           p_split => ';') > 0)*/]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_order_201_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[ORDER_CODE,RELA_GOO_ID,SUPPLIER,STYLE_NUMBER]'',3,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_order_201_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_order_201_1'',q''[]'',q''[]'',,q''[]'',1,q''[]'',q''[]'',q''[]'',q''[]'',q''[ORDER_ID,ORDERS_ID,COMPANY_ID,FACTORY_CODE,ORDER_STATUS]'',,0,q''[]'',q''[]'',q''[20,30,50,100,200,500]'',,q''[ORDER_CODE,RELA_GOO_ID,SUPPLIER,STYLE_NUMBER]'',3,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_ordernums_list();
  @strresult := v_sql;
END;}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_order_201_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[]'',q''[]'',q''[]'',q''[ORDERED_ID,ORDERS_ID,ORDER_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_order_201_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_order_201_2'',q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[]'',q''[]'',q''[]'',q''[ORDERED_ID,ORDERS_ID,ORDER_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[]';
  CV3 CLOB:=q'[]';
  CV4 CLOB:=q'[]';
  CV5 CLOB:=q'[]';
  CV6 CLOB:=q'[]';
  CV7 CLOB:=q'[--czh add 20211209_v0
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supp_order_coor.f_query_order_log(p_item_id => 'a_order_201_3');
  @strresult := v_sql;
END;}]';
  CV8 CLOB:=q'[]';
  CV9 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_LIST WHERE ITEM_ID = ''a_order_201_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_LIST SET (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) = (SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[]'',q''[]'',q''[]'',q''[ORDERED_ID,ORDERS_ID,ORDER_ID,LOG_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL) WHERE ITEM_ID = ''a_order_201_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_LIST (AUTO_REFRESH,BACK_GROUND_ID,EDIT_EXPRESS,END_FIELD,EXECUTE_TIME,FOOTER,HEADER,HINT_TYPE,ITEM_ID,JUMP_EXPRESS,JUMP_FIELD,MAX_ROW_COUNT,MONITOR_ID,MULTI_PAGE_FLAG,NOADD_FIELDS,NOEDIT_FIELDS,NOMODIFY_FIELDS,NOSHOW_APP_FIELDS,NOSHOW_FIELDS,OPEN_MODE,OPERATE_TYPE,OPERATION_TYPE,OUTPUT_PARAMETER,PAGE_SIZES,QUERY_COUNT,QUERY_FIELDS,QUERY_TYPE,RFID_FLAG,SCANNABLE_FIELD,SCANNABLE_LOCATION_LINE,SCANNABLE_TIME,SCANNABLE_TYPE,SUBNOSHOW_FIELDS,SUB_EDIT_STATE,SUB_TABLE_JUDGE_FIELD,UI_TMPL,DELETE_SQL,DETAIL_SQL,INSERT_SQL,LOCK_SQL,NEWID_SQL,OPRETION_HINT,SELECT_SQL,SUBSELECT_SQL,UPDATE_SQL) SELECT 1,q''[]'',q''[]'',q''[]'',,q''[]'',q''[]'',,''a_order_201_3'',q''[]'',q''[]'',,q''[]'',2,q''[]'',q''[]'',q''[]'',q''[]'',q''[ORDERED_ID,ORDERS_ID,ORDER_ID,LOG_ID,COMPANY_ID]'',,0,q''[]'',q''[]'',q''[]'',,q''[]'',,,q''[]'',q''[]'',,,q''[]'',,q''[]'',q''[]'',:CV1,:CV2,:CV3,:CV4,:CV5,:CV6,:CV7,:CV8,:CV9 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3,CV4,CV5,CV6,CV7,CV8,CV9;
     END IF;
  END;
END;
/

