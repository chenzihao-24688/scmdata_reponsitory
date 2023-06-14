--��ʷ���ݴ���  
--�鳧�����ˡ���ϵ�绰���鳧����
DECLARE
  p_company_id VARCHAR2(32) := 'b6cc680ad0f599cde0531164a8c0337f';
BEGIN
  FOR i IN (SELECT a.ask_user_id, a.company_id, b.factory_report_id
              FROM scmdata.t_factory_ask a
             INNER JOIN scmdata.t_factory_report b
                ON a.company_id = b.company_id
               AND a.factory_ask_id = b.factory_ask_id
             WHERE a.company_id = p_company_id
               AND b.check_person1 IS NULL) LOOP
    UPDATE scmdata.t_factory_report t
       SET t.check_person1       = i.ask_user_id,
           t.check_person1_phone =
           (SELECT fu.phone
              FROM scmdata.sys_company_user fu
             WHERE fu.company_id = i.company_id
               AND fu.company_user_id = i.ask_user_id)
     WHERE t.company_id = i.company_id
       AND t.factory_report_id = i.factory_report_id;
  END LOOP;
  --�鳧����
  UPDATE scmdata.t_factory_report t
     SET t.check_result = CASE
                            WHEN t.check_result = '�Ե�' THEN
                             '02'
                            WHEN t.check_result = '�鳧ͨ��' THEN
                             '00'
                            WHEN t.check_result = '�鳧��ͨ��' THEN
                             '01'
                          END
   WHERE t.company_id = p_company_id
     AND t.check_result IN ('�Ե�', '�鳧��ͨ��', '�鳧ͨ��');
END;
