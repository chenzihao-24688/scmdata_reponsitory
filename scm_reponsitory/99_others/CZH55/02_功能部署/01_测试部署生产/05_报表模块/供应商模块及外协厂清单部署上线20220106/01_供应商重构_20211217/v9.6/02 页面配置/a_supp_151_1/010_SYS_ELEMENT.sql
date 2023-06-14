﻿BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ELEMENT WHERE ELEMENT_ID = ''look_a_supp_111_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ELEMENT SET (DATA_SOURCE,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) = (SELECT q''[oracle_scmdata]'',q''[lookup]'',,,,,q''[]'',0,:CV1 FROM DUAL) WHERE ELEMENT_ID = ''look_a_supp_111_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ELEMENT (DATA_SOURCE,ELEMENT_ID,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) SELECT q''[oracle_scmdata]'',''look_a_supp_111_7'',q''[lookup]'',,,,,q''[]'',0,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ELEMENT WHERE ELEMENT_ID = ''pick_a_supp_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ELEMENT SET (DATA_SOURCE,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) = (SELECT q''[oracle_scmdata]'',q''[pick]'',,,,,q''[]'',0,:CV1 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ELEMENT (DATA_SOURCE,ELEMENT_ID,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) SELECT q''[oracle_scmdata]'',''pick_a_supp_151_1'',q''[pick]'',,,,,q''[]'',0,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ELEMENT WHERE ELEMENT_ID = ''pick_a_supp_151_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ELEMENT SET (DATA_SOURCE,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) = (SELECT q''[oracle_scmdata]'',q''[pick]'',,,,,q''[]'',0,:CV1 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ELEMENT (DATA_SOURCE,ELEMENT_ID,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) SELECT q''[oracle_scmdata]'',''pick_a_supp_151_2'',q''[pick]'',,,,,q''[]'',0,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ELEMENT WHERE ELEMENT_ID = ''lookup_a_supp_111_9''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ELEMENT SET (DATA_SOURCE,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) = (SELECT q''[oracle_scmdata]'',q''[lookup]'',,,,,q''[]'',0,:CV1 FROM DUAL) WHERE ELEMENT_ID = ''lookup_a_supp_111_9''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ELEMENT (DATA_SOURCE,ELEMENT_ID,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) SELECT q''[oracle_scmdata]'',''lookup_a_supp_111_9'',q''[lookup]'',,,,,q''[]'',0,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ELEMENT WHERE ELEMENT_ID = ''look_a_supp_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ELEMENT SET (DATA_SOURCE,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) = (SELECT q''[oracle_scmdata]'',q''[lookup]'',,,,,q''[]'',0,:CV1 FROM DUAL) WHERE ELEMENT_ID = ''look_a_supp_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ELEMENT (DATA_SOURCE,ELEMENT_ID,ELEMENT_TYPE,ENABLE_STAND_PERMISSION,IS_ASYNC,IS_HIDE,IS_PER_EXE,MEMO,PAUSE,MESSAGE) SELECT q''[oracle_scmdata]'',''look_a_supp_151_1'',q''[lookup]'',,,,,q''[]'',0,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

