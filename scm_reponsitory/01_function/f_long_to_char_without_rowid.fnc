﻿CREATE OR REPLACE FUNCTION SCMDATA.F_LONG_TO_CHAR_WITHOUT_ROWID(TAB_NAME  IN VARCHAR2,
                                                                LONG_COL  IN VARCHAR2,
                                                                UNQ_COND  IN VARCHAR2) RETURN VARCHAR2 AUTHID CURRENT_USER IS
  LS LONG;
  LR LONG RAW;
  TMP_SQL VARCHAR2(512);
  RET_STR VARCHAR2(2048);
  ERR_INFO VARCHAR2(2048);
BEGIN
  TMP_SQL := 'SELECT ' || LONG_COL || ' FROM ' || TAB_NAME ||
              ' WHERE ' || UNQ_COND;
  EXECUTE IMMEDIATE TMP_SQL INTO LS;
  LR := UTL_RAW.CAST_TO_RAW(LS);
  RET_STR := UTL_RAW.CAST_TO_VARCHAR2(LR);
  RETURN RET_STR;
  EXCEPTION 
    WHEN OTHERS THEN 
      ERR_INFO := 'EXE_TIME: '||SYSDATE||CHR(10)||
                  'ERR_SQL: '||TMP_SQL;
      RAISE_APPLICATION_ERROR(-20002,ERR_INFO);
END F_LONG_TO_CHAR_WITHOUT_ROWID;
/

