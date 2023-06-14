--供应商新增准入结果处理
DECLARE
  v_trialorder_type VARCHAR2(256);
BEGIN
  FOR i IN (SELECT sa.supplier_info_origin_id,
                   sa.supplier_info_id,
                   sa.company_id
              FROM scmdata.t_supplier_info sa
             WHERE sa.company_id = 'b6cc680ad0f599cde0531164a8c0337f') LOOP
  
    SELECT nvl(MAX(fr.admit_result), 0) trialorder_type
      INTO v_trialorder_type
      FROM scmdata.t_factory_ask fa
     INNER JOIN scmdata.t_factory_report fr
        ON fa.factory_ask_id = fr.factory_ask_id
       AND fa.factory_ask_id = i.supplier_info_origin_id;
  
    UPDATE scmdata.t_supplier_info t
       SET t.admit_result = v_trialorder_type
     WHERE t.supplier_info_id = i.supplier_info_id
       AND t.company_id = i.company_id;
  END LOOP;
END;
