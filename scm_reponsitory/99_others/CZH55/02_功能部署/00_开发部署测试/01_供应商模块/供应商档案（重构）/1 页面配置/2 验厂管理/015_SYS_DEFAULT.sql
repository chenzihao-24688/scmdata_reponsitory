BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[select pkg_personal.F_show_username_by_company(u.user_id,
                                               %default_company_id%) ask_user_name,
       u.phone ask_user_phone,
       (select licence_num
          from sys_company
         where company_id = %default_company_id%) SOCIAL_CREDIT_CODE,
       (select logn_name
          from sys_company
         where company_id = %default_company_id%) ASK_COMPANY_NAME,
       '成品供应商' cooperation_type_desc,
       'PRODUCT_TYPE' cooperation_type
  from sys_user u
 where u.user_id = :user_id]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DEFAULT WHERE ELEMENT_ID = ''default_a_coop_121''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DEFAULT SET (DEFAULT_SQL) = (SELECT :CV1 FROM DUAL) WHERE ELEMENT_ID = ''default_a_coop_121''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DEFAULT (ELEMENT_ID,DEFAULT_SQL) SELECT :CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

