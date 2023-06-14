--Á÷³Ì×´Ì¬
DECLARE
  v_bf_status VARCHAR2(256);
BEGIN
  FOR i IN (SELECT DISTINCT ar.ask_record_id
              FROM scmdata.t_ask_record ar
             INNER JOIN scmdata.t_factory_ask_oper_log lg
                ON lg.ask_record_id = ar.ask_record_id
             WHERE lg.status_bf_oper IS NULL
               AND ar.ask_record_id = 'HZ2110186387023121') LOOP
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
