SELECT *
  FROM nbw.sys_sql_config
 WHERE upper(sql_text) LIKE upper('%user_account%');

SELECT *
  FROM nbw.sys_action t
 WHERE t.action_sql LIKE /*upper(*/
       '%user_account%' /*)*/
;

SELECT * FROM nbw.sys_item_list t WHERE t.select_sql LIKE '%user_account%';

SELECT * FROM nbw.sys_item_list t WHERE t.insert_sql LIKE '%user_account%';

SELECT * FROM nbw.sys_item_list t WHERE t.update_sql LIKE '%user_account%';

SELECT * FROM nbw.sys_item_list t WHERE t.delete_sql LIKE '%user_account%';

SELECT * FROM scmdata.sys_user;
SELECT * FROM scmdata.sys_company_user;
SELECT * FROM scmdata.sys_user_company;

SELECT *
  FROM nbw.sys_item_list t
 WHERE t.item_id IN ('a_audit_110', 'a_audit_120');

--≈À¿Ÿ--15521389217
--“¸Œƒ”¬--17752604077

SELECT *
  FROM scmdata.sys_user su
 WHERE su.nick_name = '≈À¿Ÿ'
   AND su.user_account = '15521389217';

SELECT *
  FROM scmdata.sys_company_user su
 WHERE su.company_user_name = '≈À¿Ÿ'
   AND su.user_account = '15521389217';

DECLARE
  v_phone VARCHAR2(100) := '17752604077';
  v_name  VARCHAR2(100) := '“¸Œƒ”¬';
BEGIN
  UPDATE scmdata.sys_user su
     SET su.user_account = v_phone, su.phone = v_phone
   WHERE su.nick_name = v_name;

  UPDATE scmdata.sys_company_user scu
     SET scu.phone = v_phone
   WHERE /*scu.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
     AND*/ scu.company_user_name = v_name;
END;


