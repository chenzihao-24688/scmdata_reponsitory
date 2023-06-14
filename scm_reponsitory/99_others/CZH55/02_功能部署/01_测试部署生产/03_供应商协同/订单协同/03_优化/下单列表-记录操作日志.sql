declare
v_sql clob;
begin
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
     pkg_supp_order_coor.p_insert_order_log(p_company_id            => %default_company_id%,
                                            p_order_id              => i.order_id,
                                            p_log_type              => ''修改信息-指定工厂'',
                                            p_old_designate_factory => i.factory_code,
                                            p_new_designate_factory => :factory_code,
                                            p_operator              => ''NEED'',
                                            p_operate_person        => :user_id);
    --end

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

      UPDATE SCMDATA.T_ORDERED
         SET UPDATE_ID = %CURRENT_USERID%, UPDATE_TIME = SYSDATE
       WHERE REGEXP_COUNT(ORDER_ID || '','', I.ORDER_ID || '','') > 0
         AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
    END IF;
  END LOOP;
END;';
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_order_101_0';
end;
