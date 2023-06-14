create or replace package scmdata.PKG_HX_TEST is
PROCEDURE PROC_OUT(p_i int);

end;
/

CREATE OR REPLACE package BODY SCMDATA.PKG_HX_TEST is

PROCEDURE PROC_INNER(p_i int) IS
BEGIN
  RETURN;
END;
PROCEDURE PROC_OUT(p_i int) IS
BEGIN
  DBMS_OUTPUT.put_line('THIS IS FIRST');
  PROC_INNER(1);
  DBMS_OUTPUT.put_line('THIS IS SECOND');
END;
end;
/

