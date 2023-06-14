--历史单据处理  
--验厂申请人、联系电话
DECLARE
  p_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  FOR i IN (SELECT b.check_user_id, b.company_id, b.factory_report_id
              FROM scmdata.t_factory_ask a
             INNER JOIN scmdata.t_factory_report b
                ON a.company_id = b.company_id
               AND a.factory_ask_id = b.factory_ask_id
             WHERE a.company_id = p_company_id) LOOP
  
    UPDATE scmdata.t_factory_report t
       SET t.check_person1       = i.check_user_id,
           t.check_person1_phone =
           (SELECT fu.phone
              FROM scmdata.sys_user fu
             WHERE fu.user_id = i.check_user_id)
     WHERE t.company_id = i.company_id
       AND t.factory_report_id = i.factory_report_id;
  END LOOP;
END;
