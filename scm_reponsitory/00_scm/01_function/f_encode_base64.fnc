CREATE OR REPLACE FUNCTION SCMDATA.F_ENCODE_BASE64(P_BLOB IN BLOB) RETURN CLOB IS
  L_CLOB CLOB;
  L_STEP PLS_INTEGER := 12000;
BEGIN
  IF P_BLOB IS NOT NULL THEN 
    FOR I IN 0 .. TRUNC((DBMS_LOB.GETLENGTH(P_BLOB) - 1) / L_STEP) LOOP
      L_CLOB := L_CLOB ||
                UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(DBMS_LOB.SUBSTR(P_BLOB,
                                                                                  L_STEP,
                                                                                  I *
                                                                                  L_STEP + 1)));
    END LOOP;
  END IF;
  
  RETURN L_CLOB;
END F_ENCODE_BASE64;
/

