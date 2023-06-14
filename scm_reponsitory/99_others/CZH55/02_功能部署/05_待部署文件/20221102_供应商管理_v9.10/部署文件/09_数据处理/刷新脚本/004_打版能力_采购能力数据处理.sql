BEGIN
  FOR rec IN (SELECT t.supplier_info_id,
                     t.company_id,
                     t.pattern_cap,
                     t.fabric_purchase_cap
                FROM scmdata.t_supplier_info t
               WHERE t.pattern_cap = '00'
                  OR t.fabric_purchase_cap = '00') LOOP
    IF rec.pattern_cap = '00' THEN
      UPDATE scmdata.t_person_config_sup a
         SET a.person_num = 1
       WHERE a.supplier_info_id = rec.supplier_info_id
         AND a.company_id = rec.company_id
         AND a.person_job_id = 'ROLE_00_01_00';
    END IF;
  
    IF rec.fabric_purchase_cap = '00' THEN
      UPDATE scmdata.t_person_config_sup a
         SET a.person_num = 1
       WHERE a.supplier_info_id = rec.supplier_info_id
         AND a.company_id = rec.company_id
         AND a.person_job_id = 'ROLE_03_01_00';
    END IF;
  END LOOP;
END;
/
BEGIN
UPDATE scmdata.t_supplier_info t SET t.other_information = t.ask_files WHERE 1 = 1 AND t.ask_files IS NOT NULL;
END;
/
