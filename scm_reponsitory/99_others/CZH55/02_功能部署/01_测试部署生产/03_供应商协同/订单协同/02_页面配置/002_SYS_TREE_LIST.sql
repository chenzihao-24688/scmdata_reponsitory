﻿BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_TREE_LIST WHERE  ITEM_ID = ''a_order_201'' AND NODE_ID = ''node_a_order_201''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_TREE_LIST SET (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) = (SELECT q''[scm]'',q''[]'',,,q''[]'',1,,1,q''[a_order_100]'',0,2,,0,q''[tree_a_order]'',q''[]'' FROM DUAL) WHERE  ITEM_ID = ''a_order_201'' AND NODE_ID = ''node_a_order_201''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_TREE_LIST (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,ITEM_ID,NODE_ID,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) SELECT q''[scm]'',q''[]'',,,q''[]'',1,,''a_order_201'',''node_a_order_201'',1,q''[a_order_100]'',0,2,,0,q''[tree_a_order]'',q''[]'' FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_TREE_LIST WHERE  ITEM_ID = ''a_order_201_0'' AND NODE_ID = ''node_a_order_201_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_TREE_LIST SET (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) = (SELECT q''[scm]'',q''[]'',,,q''[]'',1,,1,q''[]'',0,1,,0,q''[tree_a_order]'',q''[]'' FROM DUAL) WHERE  ITEM_ID = ''a_order_201_0'' AND NODE_ID = ''node_a_order_201_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_TREE_LIST (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,ITEM_ID,NODE_ID,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) SELECT q''[scm]'',q''[]'',,,q''[]'',1,,''a_order_201_0'',''node_a_order_201_0'',1,q''[]'',0,1,,0,q''[tree_a_order]'',q''[]'' FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_TREE_LIST WHERE  ITEM_ID = ''a_order_201_1'' AND NODE_ID = ''node_a_order_201_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_TREE_LIST SET (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) = (SELECT q''[scm]'',q''[]'',,,q''[]'',1,,1,q''[]'',0,1,,0,q''[tree_a_order]'',q''[]'' FROM DUAL) WHERE  ITEM_ID = ''a_order_201_1'' AND NODE_ID = ''node_a_order_201_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_TREE_LIST (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,ITEM_ID,NODE_ID,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) SELECT q''[scm]'',q''[]'',,,q''[]'',1,,''a_order_201_1'',''node_a_order_201_1'',1,q''[]'',0,1,,0,q''[tree_a_order]'',q''[]'' FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_TREE_LIST WHERE  ITEM_ID = ''a_order_201_2'' AND NODE_ID = ''node_a_order_201_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_TREE_LIST SET (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) = (SELECT q''[scm]'',q''[]'',,,q''[]'',1,,1,q''[]'',0,1,,0,q''[tree_a_order]'',q''[]'' FROM DUAL) WHERE  ITEM_ID = ''a_order_201_2'' AND NODE_ID = ''node_a_order_201_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_TREE_LIST (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,ITEM_ID,NODE_ID,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) SELECT q''[scm]'',q''[]'',,,q''[]'',1,,''a_order_201_2'',''node_a_order_201_2'',1,q''[]'',0,1,,0,q''[tree_a_order]'',q''[]'' FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_TREE_LIST WHERE  ITEM_ID = ''a_order_201_3'' AND NODE_ID = ''node_a_order_201_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_TREE_LIST SET (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) = (SELECT q''[scm]'',q''[]'',,,q''[]'',1,,1,q''[]'',0,1,,0,q''[tree_a_order]'',q''[]'' FROM DUAL) WHERE  ITEM_ID = ''a_order_201_3'' AND NODE_ID = ''node_a_order_201_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_TREE_LIST (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,ITEM_ID,NODE_ID,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) SELECT q''[scm]'',q''[]'',,,q''[]'',1,,''a_order_201_3'',''node_a_order_201_3'',1,q''[]'',0,1,,0,q''[tree_a_order]'',q''[]'' FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

