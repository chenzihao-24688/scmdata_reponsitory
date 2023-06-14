﻿CREATE OR REPLACE PROCEDURE SCMDATA.P_PRINT_CLOB_INTO_CONSOLE(V_CLOB  IN CLOB) IS
  V_NUM  NUMBER(32);
BEGIN
  V_NUM := 1;

  WHILE(V_NUM <= DBMS_LOB.GETLENGTH(V_CLOB) + 200) LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(V_CLOB,V_NUM,200));
    V_NUM := V_NUM + 200;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(' ');
END P_PRINT_CLOB_INTO_CONSOLE;
/

