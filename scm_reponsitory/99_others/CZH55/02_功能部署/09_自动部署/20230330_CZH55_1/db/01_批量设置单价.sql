BEGIN
 UPDATE bw3.sys_param_list t SET t.required_flag = 0,t.caption = '*单价' WHERE t.param_name = 'UNITPRICE';  
END;
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[
DECLARE
  v_unitprice NUMBER := @unitprice@;
BEGIN
  IF v_unitprice IS NULL THEN
    raise_application_error(-20002, '单价必填，请检查！');
  ELSE
    UPDATE scmdata.t_sendorders a
       SET a.inprice = v_unitprice
     WHERE a.asn_id || '-' || a.goodids IN (@selection)
       AND a.company_id = %default_company_id%;
  END IF;
END;]';
 UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_asn_extend_02'; 
END;
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[
DECLARE
  v_order_cnt   INT;
  v_order_codes VARCHAR(2000);
BEGIN
  SELECT listagg(DISTINCT t.order_code, ';'),
         COUNT(DISTINCT t.order_code) order_cnt
    INTO v_order_codes, v_order_cnt
    FROM scmdata.t_sendordered a
   INNER JOIN scmdata.t_ordered t
      ON t.order_code = a.order_code
     AND t.company_id = a.company_id
     AND t.order_status <> 'OS02'
   WHERE a.send_id IN (@selection@);

  --判断订单是否结束
  IF v_order_cnt > 0 THEN
    raise_application_error(-20002,
                            '不可手动关闭送货单！存在' || v_order_cnt || '张订单【' ||
                            v_order_codes || '】未结束');
  ELSE
    UPDATE scmdata.t_sendordered a
       SET a.closed = 1
     WHERE a.send_id IN (@selection@);
  END IF;
END;]';
 UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_asn_extend_03'; 
END;
/
