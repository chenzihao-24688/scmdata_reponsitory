--历史数据处理
--流程状态
DECLARE
  v_bf_status VARCHAR2(256);
BEGIN
  FOR i IN (SELECT DISTINCT ar.ask_record_id
              FROM scmdata.t_ask_record ar
             INNER JOIN scmdata.t_factory_ask_oper_log lg
                ON lg.ask_record_id = ar.ask_record_id
             WHERE lg.status_bf_oper IS NULL
               /*AND ar.ask_record_id = 'HZ2110186387023121'*/) LOOP
    FOR j IN (SELECT t.*,
                     row_number() over(PARTITION BY t.ask_record_id ORDER BY t.oper_time DESC) rn
                FROM scmdata.t_factory_ask_oper_log t
               WHERE t.ask_record_id = i.ask_record_id) LOOP
    
      SELECT MAX(v.status_af_oper)
        INTO v_bf_status
        FROM (SELECT t.status_af_oper,
                     t.ask_record_id,
                     row_number() over(PARTITION BY t.ask_record_id ORDER BY t.oper_time DESC) rn
                FROM scmdata.t_factory_ask_oper_log t
               WHERE t.ask_record_id = i.ask_record_id) v
       WHERE v.rn = j.rn + 1;
    
      UPDATE scmdata.t_factory_ask_oper_log lg
         SET lg.status_bf_oper = v_bf_status
       WHERE lg.log_id = j.log_id;
    END LOOP;
  END LOOP;
END;
/
--人员配置 车位人数刷新
BEGIN
  UPDATE scmdata.t_ask_record ar SET ar.worker_total_num = NVL(ar.worker_num,0),ar.worker_num = NVL(ar.worker_num,0) WHERE 1 = 1;
  UPDATE scmdata.t_factory_ask fa SET fa.worker_total_num= NVL(fa.worker_num,0),fa.worker_num = NVL(fa.worker_num,0) WHERE 1 = 1;
  UPDATE scmdata.t_supplier_info sp SET sp.worker_total_num= NVL(sp.worker_num,0),sp.worker_num = NVL(sp.worker_num,0)  WHERE 1 = 1;
END;
/
BEGIN
  FOR i IN (SELECT ar.ask_record_id, ar.company_id,ar.worker_num
              FROM scmdata.t_ask_record ar
             WHERE ar.worker_num IS NOT NULL) LOOP
    UPDATE scmdata.t_person_config_hz t SET t.person_num = i.worker_num
     WHERE t.department_id = 'ROLE_01_01' AND t.person_job_id = 'ROLE_01_01_01'
       AND t.ask_record_id = i.ask_record_id
       AND t.company_id = i.company_id;
  END LOOP;
END;
/
BEGIN
  FOR i IN (SELECT fa.factory_ask_id, fa.company_id,fa.worker_num
              FROM scmdata.t_factory_ask fa
             WHERE fa.worker_num IS NOT NULL) LOOP
    UPDATE scmdata.t_person_config_fa t SET t.person_num = i.worker_num
     WHERE t.department_id = 'ROLE_01_01' AND t.person_job_id = 'ROLE_01_01_01'
       AND t.factory_ask_id = i.factory_ask_id
       AND t.company_id = i.company_id;
  END LOOP;
END;
/
BEGIN
  FOR i IN (SELECT sp.supplier_info_id, sp.company_id,sp.worker_num
              FROM scmdata.t_supplier_info sp
             WHERE sp.worker_num IS NOT NULL) LOOP
    UPDATE scmdata.t_person_config_sup t SET t.person_num = i.worker_num
     WHERE t.department_id = 'ROLE_01_01' AND t.person_job_id = 'ROLE_01_01_01'
       AND t.supplier_info_id = i.supplier_info_id
       AND t.company_id = i.company_id;
  END LOOP;
END;
/
--公司类型
--合作定位
BEGIN
UPDATE scmdata.t_supplier_info sp SET sp.company_type = '02' WHERE sp.company_type = '00';

UPDATE scmdata.t_supplier_info sp
   SET sp.coop_position = (CASE
                            WHEN sp.coop_position = '外协厂' THEN
                             '04'
                            WHEN sp.coop_position = '普通型' THEN
                             '02'
                            ELSE
                             NULL
                          END)
 WHERE 1 = 1;
END;
/
