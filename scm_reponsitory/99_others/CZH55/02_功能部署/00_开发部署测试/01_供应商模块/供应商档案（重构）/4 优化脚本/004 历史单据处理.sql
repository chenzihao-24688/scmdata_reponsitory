--历史单据处理
--合作模式
BEGIN
   UPDATE scmdata.t_ask_record t
     SET t.cooperation_model = REPLACE('ODM_OEM_OF', '_', ';')
   WHERE EXISTS (SELECT 1 FROM dual where instr(t.cooperation_model, '_') > 0);
   
   UPDATE scmdata.t_factory_ask t
     SET t.cooperation_model = REPLACE('ODM_OEM_OF', '_', ';')
   WHERE EXISTS (SELECT 1 FROM dual where instr(t.cooperation_model, '_') > 0);
   
   UPDATE scmdata.t_factory_report t
     SET t.cooperation_model = REPLACE('ODM_OEM_OF', '_', ';')
   WHERE EXISTS (SELECT 1 FROM dual where instr(t.cooperation_model, '_') > 0);
   
  UPDATE scmdata.t_supplier_info t
     SET t.cooperation_model = REPLACE('ODM_OEM_OF', '_', ';')
   WHERE EXISTS (SELECT 1 FROM dual where instr(t.cooperation_model, '_') > 0);
END;
