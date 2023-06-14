﻿BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_310'' AND RELATE_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_310'' AND RELATE_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_310'',0,''a_coop_106'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_220'' AND RELATE_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_220'' AND RELATE_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_220'',0,''a_coop_106'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_230'' AND RELATE_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_230'' AND RELATE_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_230'',0,''a_coop_106'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_150'' AND RELATE_ID = ''a_coop_133_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_150'' AND RELATE_ID = ''a_coop_133_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_150'',0,''a_coop_133_1'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_312'' AND RELATE_ID = ''a_coop_312_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_312'' AND RELATE_ID = ''a_coop_312_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_312'',0,''a_coop_312_1'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_151'' AND RELATE_ID = ''a_coop_159''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_151'' AND RELATE_ID = ''a_coop_159''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_151'',0,''a_coop_159'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_210'' AND RELATE_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_210'' AND RELATE_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_210'',0,''a_coop_106'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_101'' AND RELATE_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_check_101'' AND RELATE_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_101'',0,''a_coop_106'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_102'' AND RELATE_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_check_102'' AND RELATE_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_102'',0,''a_coop_106'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_211'' AND RELATE_ID = ''a_coop_159_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_211'' AND RELATE_ID = ''a_coop_159_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_211'',0,''a_coop_159_2'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''test_fl_new_list'' AND RELATE_ID = ''test_fl_new_navigation''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[N]'',1 FROM DUAL) WHERE  ITEM_ID = ''test_fl_new_list'' AND RELATE_ID = ''test_fl_new_navigation''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''test_fl_new_list'',0,''test_fl_new_navigation'',q''[N]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_104'' AND RELATE_ID = ''a_coop_104_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_coop_104'' AND RELATE_ID = ''a_coop_104_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_104'',0,''a_coop_104_1'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_221'' AND RELATE_ID = ''a_coop_221_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_221'' AND RELATE_ID = ''a_coop_221_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_221'',0,''a_coop_221_1'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_102'' AND RELATE_ID = ''a_check_109_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_check_102'' AND RELATE_ID = ''a_check_109_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_102'',0,''a_check_109_2'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_101_1'' AND RELATE_ID = ''a_check_101_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_check_101_1'' AND RELATE_ID = ''a_check_101_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_101_1'',0,''a_check_101_4'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_102_1'' AND RELATE_ID = ''a_check_101_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_check_102_1'' AND RELATE_ID = ''a_check_101_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_102_1'',0,''a_check_101_3'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_102_1'' AND RELATE_ID = ''a_check_101_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_check_102_1'' AND RELATE_ID = ''a_check_101_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_102_1'',0,''a_check_101_4'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_103'' AND RELATE_ID = ''a_check_109_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_check_103'' AND RELATE_ID = ''a_check_109_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_103'',0,''a_check_109_2'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_103'' AND RELATE_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_check_103'' AND RELATE_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_103'',0,''a_coop_106'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_130'' AND RELATE_ID = ''a_coop_133''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_130'' AND RELATE_ID = ''a_coop_133''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_130'',0,''a_coop_133'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_311'' AND RELATE_ID = ''a_coop_104_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_311'' AND RELATE_ID = ''a_coop_104_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_311'',0,''a_coop_104_1'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_150_6'' AND RELATE_ID = ''a_coop_159''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_coop_150_6'' AND RELATE_ID = ''a_coop_159''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_150_6'',0,''a_coop_159'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_121'' AND RELATE_ID = ''a_coop_121_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_121'' AND RELATE_ID = ''a_coop_121_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_121'',0,''a_coop_121_1'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_131'' AND RELATE_ID = ''a_coop_131_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_131'' AND RELATE_ID = ''a_coop_131_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_131'',0,''a_coop_131_2'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_101'' AND RELATE_ID = ''a_check_109_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_check_101'' AND RELATE_ID = ''a_check_109_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_101'',0,''a_check_109_1'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_132_1'' AND RELATE_ID = ''a_coop_132_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_132_1'' AND RELATE_ID = ''a_coop_132_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_132_1'',0,''a_coop_132_2'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_150_3'' AND RELATE_ID = ''a_coop_159_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_150_3'' AND RELATE_ID = ''a_coop_159_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_150_3'',0,''a_coop_159_1'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_check_101_1'' AND RELATE_ID = ''a_check_101_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_check_101_1'' AND RELATE_ID = ''a_check_101_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_check_101_1'',0,''a_check_101_3'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_312'' AND RELATE_ID = ''a_coop_312_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_coop_312'' AND RELATE_ID = ''a_coop_312_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_312'',0,''a_coop_312_2'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_312'' AND RELATE_ID = ''a_coop_312_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',3 FROM DUAL) WHERE  ITEM_ID = ''a_coop_312'' AND RELATE_ID = ''a_coop_312_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_312'',0,''a_coop_312_3'',q''[S]'',3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_320'' AND RELATE_ID = ''a_coop_106''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_320'' AND RELATE_ID = ''a_coop_106''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_320'',0,''a_coop_106'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_105'' AND RELATE_ID = ''a_check_101_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',1 FROM DUAL) WHERE  ITEM_ID = ''a_coop_105'' AND RELATE_ID = ''a_check_101_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_105'',0,''a_check_101_3'',q''[S]'',1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ITEM_RELA WHERE  ITEM_ID = ''a_coop_105'' AND RELATE_ID = ''a_check_101_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ITEM_RELA SET (PAUSE,RELATE_TYPE,SEQ_NO) = (SELECT 0,q''[S]'',2 FROM DUAL) WHERE  ITEM_ID = ''a_coop_105'' AND RELATE_ID = ''a_check_101_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ITEM_RELA (ITEM_ID,PAUSE,RELATE_ID,RELATE_TYPE,SEQ_NO) SELECT ''a_coop_105'',0,''a_check_101_4'',q''[S]'',2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

