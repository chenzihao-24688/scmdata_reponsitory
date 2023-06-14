﻿BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_TREE_LIST WHERE  ITEM_ID = ''a_supp_151'' AND NODE_ID = ''node_a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_TREE_LIST SET (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) = (SELECT q''[scm]'',q''[供应商档案详情(新)(未建档)]'',,,q''[]'',1,0,1,q''[]'',0,1,,0,q''[tree_a_supp_1]'',q''[]'' FROM DUAL) WHERE  ITEM_ID = ''a_supp_151'' AND NODE_ID = ''node_a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_TREE_LIST (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,ITEM_ID,NODE_ID,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) SELECT q''[scm]'',q''[供应商档案详情(新)(未建档)]'',,,q''[]'',1,0,''a_supp_151'',''node_a_supp_151'',1,q''[]'',0,1,,0,q''[tree_a_supp_1]'',q''[]'' FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_TREE_LIST WHERE  ITEM_ID = ''a_supp_151_4'' AND NODE_ID = ''node_a_supp_151_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_TREE_LIST SET (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) = (SELECT q''[scm]'',q''[供应商选择]'',,,q''[]'',1,0,1,q''[]'',0,2,,0,q''[tree_a_supp_1]'',q''[]'' FROM DUAL) WHERE  ITEM_ID = ''a_supp_151_4'' AND NODE_ID = ''node_a_supp_151_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_TREE_LIST (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,ITEM_ID,NODE_ID,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) SELECT q''[scm]'',q''[供应商选择]'',,,q''[]'',1,0,''a_supp_151_4'',''node_a_supp_151_4'',1,q''[]'',0,2,,0,q''[tree_a_supp_1]'',q''[]'' FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_TREE_LIST WHERE  ITEM_ID = ''a_supp_161'' AND NODE_ID = ''node_a_supp_161''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_TREE_LIST SET (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) = (SELECT q''[scm]'',q''[供应商档案详情(新)(已建档)]'',,,q''[]'',1,0,1,q''[]'',0,1,,0,q''[tree_a_supp_1]'',q''[]'' FROM DUAL) WHERE  ITEM_ID = ''a_supp_161'' AND NODE_ID = ''node_a_supp_161''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_TREE_LIST (APP_ID,CAPTION_EXPLAIN,COMPETENCE_FLAG,ENABLE_STAND_PERMISSION,ICON_NAME,IS_AUTHORIZE,IS_END,ITEM_ID,NODE_ID,NODE_TYPE,PARENT_ID,PAUSE,SEQ_NO,STAND_PRIV_FLAG,TERMINAL_FLAG,TREE_ID,VAR_ID) SELECT q''[scm]'',q''[供应商档案详情(新)(已建档)]'',,,q''[]'',1,0,''a_supp_161'',''node_a_supp_161'',1,q''[]'',0,1,,0,q''[tree_a_supp_1]'',q''[]'' FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL;
     END IF;
  END;
END;
/

