﻿BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_check_101_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[添加验厂报告]'',2,q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_check_101_1]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_check_101_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[添加验厂报告]'',2,''asso_a_check_101_1'',q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_check_101_1]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[查看公司档案]'',2,q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[查看公司档案]'',2,''asso_a_coop_150_0'',q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[申请验厂]'',2,q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[申请验厂]'',2,''asso_a_coop_150_3'',q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_131''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[申请详情]'',2,q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_131]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_131''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[申请详情]'',2,''associate_a_coop_131'',q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_131]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[重新申请]'',2,q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_132_1]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[重新申请]'',2,''associate_a_coop_130'',q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_132_1]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_103_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[企业详情]'',2,q''[BE_COMPANY_ID]'',q''[]'',q''[node_a_coop_103]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_103_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[企业详情]'',2,''associate_a_coop_103_130'',q''[BE_COMPANY_ID]'',q''[]'',q''[node_a_coop_103]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[查看公司档案]'',2,q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[查看公司档案]'',2,''asso_a_coop_150_0'',q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[查看验厂报告]'',2,q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_check_102_1]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[查看验厂报告]'',2,''asso_a_check_102_1'',q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_check_102_1]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[查看验厂报告]'',2,q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_check_102_1]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[查看验厂报告]'',2,''asso_a_check_102_1'',q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_check_102_1]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[查看详情]'',2,q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_150_6]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[查看详情]'',2,''asso_a_coop_150_6'',q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_150_6]'',q''[]'',:CV1 FROM DUAL';
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
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[查看公司档案]'',2,q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[查看公司档案]'',2,''asso_a_coop_150_0'',q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

