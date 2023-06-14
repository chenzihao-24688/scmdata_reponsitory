--库高速缓存
SELECT * FROM scmdata.sys_user u WHERE u.user_account = '18172543571';
SELECT * FROM scmdata.sys_user u WHERE u.user_account = '18172543571';
SELECT * FROM scmdata.sys_user u WHERE u.user_account = '18172543571';

--绑定变量，有效降低硬编码
--1.sql
var v_user_account VARCHAR2(100);
exec :v_user_account := '18172543571';
SELECT * FROM scmdata.sys_user u WHERE u.user_account = :v_user_account;

SELECT t.sql_text,
       t.sql_id,
       t.child_number,
       t.hash_value,
       t.address,
       t.executions
  FROM v$sql t
 WHERE upper(t.sql_text) LIKE '%v_user_account%';

DECLARE
  v_user_account VARCHAR2(100) := '18172543573';
  v_psw          VARCHAR2(100);
BEGIN
  SELECT u.password
    INTO v_psw
    FROM scmdata.sys_user u
   WHERE u.user_account = v_user_account;
  dbms_output.put_line(v_psw);
END;
