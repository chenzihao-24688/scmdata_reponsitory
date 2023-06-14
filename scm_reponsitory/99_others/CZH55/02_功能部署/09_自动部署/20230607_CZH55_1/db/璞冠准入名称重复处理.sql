BEGIN
  DELETE FROM scmdata.t_factory_ask a
   WHERE a.ask_record_id IN
         (SELECT t.ask_record_id
            FROM scmdata.t_ask_record t
           WHERE t.company_name = '广州璞冠服装有限公司');

  DELETE FROM scmdata.t_ask_record t
   WHERE t.company_name = '广州璞冠服装有限公司';
END;
/
