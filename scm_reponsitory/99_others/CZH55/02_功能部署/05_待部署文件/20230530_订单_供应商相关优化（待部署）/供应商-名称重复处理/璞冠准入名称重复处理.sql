BEGIN
  DELETE FROM scmdata.t_factory_ask a
   WHERE a.ask_record_id IN
         (SELECT t.ask_record_id
            FROM scmdata.t_ask_record t
           WHERE t.company_name = '����豹ڷ�װ���޹�˾');

  DELETE FROM scmdata.t_ask_record t
   WHERE t.company_name = '����豹ڷ�װ���޹�˾';
END;
/
