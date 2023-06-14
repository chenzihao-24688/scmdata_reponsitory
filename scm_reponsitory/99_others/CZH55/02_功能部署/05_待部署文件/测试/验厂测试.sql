SELECT COUNT(DISTINCT b.factory_ask_id)
  FROM scmdata.t_factory_ask a
  LEFT JOIN scmdata.t_factory_ask_oper_log b
    ON b.ask_record_id = a.ask_record_id
 WHERE a.factory_ask_id IN
       (SELECT DISTINCT t.factory_ask_id
          FROM scmdata.t_factory_ask t
         INNER JOIN scmdata.t_factory_ask_oper_log lg
            ON lg.ask_record_id = t.ask_record_id
         WHERE lg.status_af_oper = 'FA01')
   AND b.oper_code = 'BACK'
   AND b.status_af_oper = 'FA02';
