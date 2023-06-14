DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  V_MEMO         VARCHAR2(512);
  V_FACTORY_CODE VARCHAR2(32);
  V_ORDER_STATUS VARCHAR2(32);
BEGIN
  FOR I IN (SELECT A.ORDER_ID, A.MEMO, B.FACTORY_CODE, A.ORDER_STATUS
              FROM (SELECT ORDER_ID, ORDER_CODE, COMPANY_ID, MEMO, ORDER_STATUS
                      FROM SCMDATA.T_ORDERED
                     WHERE REGEXP_COUNT(:ORDER_ID || '','', ORDER_ID || '','') > 0) A
             INNER JOIN SCMDATA.T_ORDERS B
                ON A.ORDER_CODE = B.ORDER_ID
               AND A.COMPANY_ID = B.COMPANY_ID) LOOP
    IF :MEMO <> NVL(I.MEMO,'' '') THEN
      UPDATE SCMDATA.T_ORDERED
         SET MEMO        = :MEMO,
             UPDATE_ID   = %CURRENT_USERID%,
             UPDATE_TIME = SYSDATE
       WHERE REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0
         AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
    END IF;

    IF :FACTORY_CODE <> NVL(I.FACTORY_CODE,'' '') THEN
      IF I.ORDER_STATUS = ''OS02'' THEN
        RAISE_APPLICATION_ERROR(-20002, ''所选订单存在已完成订单，已完成订单不可指定工厂，请检查！'');
      END IF;

     --czh add 日志记录 begin
    /* pkg_supp_order_coor.p_insert_order_log(p_company_id            => %default_company_id%,
                                            p_order_id              => i.order_id,
                                            p_log_type              => ''修改信息-指定工厂'',
                                            p_old_designate_factory => i.factory_code,
                                            p_new_designate_factory => :factory_code,
                                            p_operator              => ''NEED'',
                                            p_operate_person        => :user_id);*/
    --end
      UPDATE SCMDATA.T_ORDERED
         SET UPDATE_ID = %CURRENT_USERID%, UPDATE_TIME = SYSDATE , update_company_id = %default_company_id%
       WHERE REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0
         AND COMPANY_ID = %DEFAULT_COMPANY_ID%;

      UPDATE SCMDATA.T_ORDERS
         SET FACTORY_CODE = :FACTORY_CODE
       WHERE (ORDER_ID, COMPANY_ID) IN
             (SELECT ORDER_CODE, COMPANY_ID
                FROM SCMDATA.T_ORDERED
               WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
                 AND REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0);

      UPDATE SCMDATA.T_PRODUCTION_PROGRESS
         SET FACTORY_CODE = :FACTORY_CODE
       WHERE (ORDER_ID,GOO_ID,COMPANY_ID) IN
             (SELECT ORDER_ID,GOO_ID,COMPANY_ID
                FROM SCMDATA.T_ORDERS
               WHERE (ORDER_ID,COMPANY_ID) IN
                     (SELECT ORDER_ID,COMPANY_ID
                        FROM SCMDATA.T_ORDERED
                       WHERE COMPANY_ID = %DEFAULT_COMPANY_ID%
                         AND REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0));


    END IF;
  END LOOP;
END; ';
UPDATE bw3.sys_item_list t SET t.update_sql = v_sql WHERE t.item_id = 'a_order_101_0';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_org_fac_code VARCHAR2(32);
BEGIN
  FOR i IN (SELECT a.order_id, a.company_id, a.supplier_code
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
    /*    pkg_supp_order_coor.p_insert_order_log(p_company_id            => i.company_id,
    p_order_id              => i.order_id,
    p_log_type              => ''修改信息-指定工厂'',
    p_old_designate_factory => nvl(v_org_fac_code,
                                   i.supplier_code),
    p_new_designate_factory => :factory_code,
    p_operator              => ''SUPP'',
    p_operate_person        => :user_id);*/
    --end
    UPDATE scmdata.t_ordered
       SET update_id         = %current_userid%,
           update_company_id = %default_company_id%,
           update_time       = SYSDATE
     WHERE regexp_count(order_id || '','', i.order_id || '','') > 0
       AND company_id = i.company_id;
  
    UPDATE scmdata.t_orders
       SET factory_code = :factory_code
     WHERE (order_id, company_id) IN
           (SELECT order_code, company_id
              FROM scmdata.t_ordered
             WHERE company_id = i.company_id
               AND regexp_count(order_id || '','', i.order_id || '','') > 0);
  
    UPDATE scmdata.t_production_progress
       SET factory_code = :factory_code
     WHERE (order_id, goo_id, company_id) IN
           (SELECT order_id, goo_id, company_id
              FROM scmdata.t_orders
             WHERE (order_id, company_id) IN
                   (SELECT order_id, company_id
                      FROM scmdata.t_ordered
                     WHERE company_id = i.company_id
                       AND regexp_count(order_id || '','', i.order_id || '','') > 0));
  
  END LOOP;
END;';
UPDATE bw3.sys_item_list t SET t.update_sql = v_sql WHERE t.item_id = 'a_order_201_0';
END;
/
