BEGIN
  DELETE FROM scmdata.t_factory_ask_oper_log a
   WHERE a.factory_ask_id IN
         (SELECT t.factory_ask_id
            FROM scmdata.t_factory_ask t
           WHERE t.social_credit_code = '9144C101MA9UU08569'
             AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f');

  DELETE FROM scmdata.t_factory_ask_oper_log a
   WHERE a.ask_record_id IN
         (SELECT t.ask_record_id
            FROM scmdata.t_ask_record t
           WHERE t.social_credit_code = '9144C101MA9UU08569'
             AND t.be_company_id = 'b6cc680ad0f599cde0531164a8c0337f');

  DELETE FROM scmdata.t_factory_ask t
   WHERE t.social_credit_code = '9144C101MA9UU08569'
     AND t.company_id = 'b6cc680ad0f599cde0531164a8c0337f';
  DELETE FROM scmdata.t_ask_record t
   WHERE t.social_credit_code = '9144C101MA9UU08569'
     AND t.be_company_id = 'b6cc680ad0f599cde0531164a8c0337f';
END;
/
