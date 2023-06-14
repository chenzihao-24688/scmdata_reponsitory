DECLARE
  v_text_sql CLOB := q'[{DECLARE 
 v_count NUMBER;
v_msg VARCHAR2(4000);
BEGIN
  SELECT COUNT(*)
    INTO v_count
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%
     AND sp.status = 0;

  IF v_count > 0 THEN
    v_msg := '您有' || v_count || '家供应商准入成功,请及时前往[供应商管理]=>[待建档供应商列表]页面进行处理！';
  END IF;
  @strresult := v_msg;
  END; }]';
BEGIN
  UPDATE bw3.sys_hint t
     SET t.text_sql = v_text_sql
   WHERE t.hint_id = 'hint_2104126118444984';
END;
/

DECLARE v_text_sql CLOB := q'[{DECLARE 
v_count NUMBER;
v_msg VARCHAR2(4000);
BEGIN
  SELECT  COUNT(1) 
  INTO v_count
  FROM scmdata.t_factory_ask fa
 WHERE fa.company_id = %default_company_id%
   AND fa.factrory_ask_flow_status = 'FA02';

  IF v_count > 0 THEN
    v_msg := '您有' || v_count || '条验厂申请单需处理，请及时前往[验厂申请]=>[待审核申请]页面进行处理，谢谢！';
  END IF;
  @strresult := v_msg;
  END; }]';
BEGIN
  UPDATE bw3.sys_hint t
     SET t.text_sql = v_text_sql
   WHERE t.hint_id = 'hint_2104126014018883';
END;
/

DECLARE v_text_sql CLOB := q'[{DECLARE 
v_count NUMBER;
v_msg VARCHAR2(4000);
BEGIN
  SELECT  COUNT(1) 
  INTO v_count
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = 'FA11';

  IF v_count > 0 THEN
    v_msg := '您有' || v_count || '条[待验厂]验厂申请单需处理，请及时前往[验厂管理]=>[待验厂]页面进行处理，谢谢！';
  END IF;
  @strresult := v_msg;
  END; }]';
BEGIN
  UPDATE bw3.sys_hint t
     SET t.text_sql = v_text_sql
   WHERE t.hint_id = 'hint_2104126153891885';
END;
/

DECLARE v_text_sql CLOB := q'[{DECLARE 
v_count NUMBER;
v_msg VARCHAR2(4000);
BEGIN
   SELECT  COUNT(1) 
   INTO  v_count
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = 'FA12';

  IF v_count > 0 THEN
    v_msg := '您有' || v_count || '条待准入审批需处理,请及时前往[准入审批]=>[待审批申请]页面进行处理，谢谢！';
  END IF;
  @strresult := v_msg;
  END; }]';
BEGIN
  UPDATE bw3.sys_hint t
     SET t.text_sql = v_text_sql
   WHERE t.hint_id = 'hint_2104125726584782';
END;
