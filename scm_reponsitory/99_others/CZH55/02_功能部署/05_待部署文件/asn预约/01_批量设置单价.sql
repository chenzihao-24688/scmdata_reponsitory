BEGIN
 UPDATE bw3.sys_param_list t SET t.required_flag = 0,t.caption = '*����' WHERE t.param_name = 'UNITPRICE';  
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
    raise_application_error(-20002, '���۱�����飡');
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

  --�ж϶����Ƿ����
  IF v_order_cnt > 0 THEN
    raise_application_error(-20002,
                            '�����ֶ��ر��ͻ���������' || v_order_cnt || '�Ŷ�����' ||
                            v_order_codes || '��δ����');
  ELSE
    UPDATE scmdata.t_sendordered a
       SET a.closed = 1
     WHERE a.send_id IN (@selection@);
  END IF;
END;]';
 UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_asn_extend_03'; 
END;
/
