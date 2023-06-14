BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_103_1_230''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[��ҵ����]'',2,q''[COMPANY_ID]'',q''[]'',q''[node_a_coop_103_1]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_103_1_230''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[��ҵ����]'',2,''associate_a_coop_103_1_230'',q''[COMPANY_ID]'',q''[]'',q''[node_a_coop_103_1]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_supp_120_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��Ӧ�̵���]'',2,q''[SUPPLIER_INFO_ID]'',q''[]'',q''[node_a_supp_121]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_supp_120_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��Ӧ�̵���]'',2,''associate_a_supp_120_1'',q''[SUPPLIER_INFO_ID]'',q''[]'',q''[node_a_supp_121]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_103_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[��ҵ����]'',2,q''[BE_COMPANY_ID]'',q''[]'',q''[node_a_coop_103]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_103_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[��ҵ����]'',2,''associate_a_coop_103_130'',q''[BE_COMPANY_ID]'',q''[]'',q''[node_a_coop_103]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^{DECLARE
  v_sql     CLOB;
  v_methods VARCHAR2(256) := 'GET;PUT';
  v_params  VARCHAR2(256);
BEGIN
  --��ԴΪ׼��/�ֶ�����
  SELECT MAX(sp.supplier_info_origin)
    INTO v_params
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%;

  v_params := v_params || ',' || '"is_element_show"'||':'||'"0"';
  v_params := v_params || ',' || '"item_name"'||':'||'"��Ӧ�̵�������"';

  v_sql      := 'select ''' || :supplier_info_id || '/' || v_methods || '?' ||
                v_params || ''' SUPPLIER_INFO_ID from dual';
  @strresult := v_sql;
END;}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_supp_160_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴����]'',2,q''[SUPPLIER_INFO_ID]'',q''[]'',q''[node_a_supp_151]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_supp_160_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴����]'',2,''associate_a_supp_160_1'',q''[SUPPLIER_INFO_ID]'',q''[]'',q''[node_a_supp_151]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��˾����]'',2,q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��˾����]'',2,''asso_a_coop_150_0'',q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^/*{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET';
  v_params          VARCHAR2(4000);
  v_is_show_element INT;
BEGIN
  --��תЯ������
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_132_1"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"��������"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :ASK_RECORD_ID || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  @strresult := v_sql;
END;
}*/^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_131''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[��������]'',2,q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_131]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_131''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[��������]'',2,''associate_a_coop_131'',q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_131]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET';
  v_params          VARCHAR2(4000);
  v_is_show_element INT;
BEGIN
  --��תЯ������
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_151_1"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"�鿴����"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :ASK_RECORD_ID || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  @strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴����]'',2,q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_151]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴����]'',2,''asso_a_coop_150_6'',q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_151]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��˾����]'',2,q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��˾����]'',2,''asso_a_coop_150_0'',q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��˾����]'',2,q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��˾����]'',2,''asso_a_coop_150_0'',q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^--CZH �ع��߼�
{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET;POST;PUT;DELETE';
  v_params          VARCHAR2(4000);
  v_is_show_element INT;
BEGIN
  --�����鳧����ʼ��������������
  scmdata.pkg_ask_record_mange.p_generate_factory_ask(p_ask_record_id => :ask_record_id,
                                                      p_company_id    => %default_company_id%,
                                                      p_user_id       => :user_id);

  --��תЯ������
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"1"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_150_3"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"�����鳧"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :ask_record_id || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  @strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�����鳧]'',2,q''[ASK_RECORD_ID]'',q''[three_word_200]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�����鳧]'',2,''asso_a_coop_150_3'',q''[ASK_RECORD_ID]'',q''[three_word_200]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^--CZH �ع��߼�
{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET';
  v_params          VARCHAR2(4000);
BEGIN
  --��תЯ������
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_211"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"�鿴��������"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :factory_ask_id || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  @strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_201''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��������]'',2,q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_201''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��������]'',2,''associate_a_coop_201'',q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^--CZH �ع��߼�
{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET';
  v_params          VARCHAR2(4000);
BEGIN
  --��תЯ������
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_211"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"�鿴��������"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :factory_ask_id || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  @strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_221''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��������]'',2,q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_221''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��������]'',2,''associate_a_coop_221'',q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^--CZH �ع��߼�
{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET';
  v_params          VARCHAR2(4000);
BEGIN
  --��תЯ������
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_211"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"�鿴��������"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :factory_ask_id || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  @strresult := v_sql;
END;
}^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_201''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��������]'',2,q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_201''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��������]'',2,''associate_a_coop_201'',q''[FACTORY_ASK_ID]'',q''[]'',q''[node_a_coop_150_3]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��˾����]'',2,q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''asso_a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��˾����]'',2,''asso_a_coop_150_0'',q''[ASK_COMPANY_NAME]'',q''[]'',q''[node_a_coop_150_0]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_103_1_220''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[��ҵ����]'',2,q''[COMPANY_ID]'',q''[]'',q''[node_a_coop_103_1]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_103_1_220''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[��ҵ����]'',2,''associate_a_coop_103_1_220'',q''[COMPANY_ID]'',q''[]'',q''[node_a_coop_103_1]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^select 1 from dual^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_supp_110_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��˾����]'',2,q''[SUPPLIER_INFO_ID]'',q''[]'',q''[node_a_supp_111_5]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_supp_110_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��˾����]'',2,''associate_a_supp_110_3'',q''[SUPPLIER_INFO_ID]'',q''[]'',q''[node_a_supp_111_5]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^select 1 from dual^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_supp_110_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[�鿴��˾����]'',2,q''[SUPPLIER_INFO_ID]'',q''[]'',q''[node_a_supp_111_5]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_supp_110_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[�鿴��˾����]'',2,''associate_a_supp_110_3'',q''[SUPPLIER_INFO_ID]'',q''[]'',q''[node_a_supp_111_5]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^/*{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET;PUT';
  v_params          VARCHAR2(4000);
  v_is_show_element INT;
BEGIN
  --��תЯ������
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_132_1"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"��������"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :ASK_RECORD_ID || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  @strresult := v_sql;
END;
}*/^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[��������]'',2,q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_132_1]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[��������]'',2,''associate_a_coop_130'',q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_132_1]'',q''[]'',:CV1 FROM DUAL';
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
  CV1 CLOB:=q'^/*{
DECLARE
  v_sql             CLOB;
  v_methods         VARCHAR2(256) := 'GET;PUT';
  v_params          VARCHAR2(4000);
  v_is_show_element INT;
BEGIN
  --��תЯ������
  --'{"COL_1": "PRODUCT_TYPE","COL_2": "00;01","COL_3": "","COL_4": "","COL_5": "","COL_6": "","COL_7": "","COL_8": "","COL_9": "","COL_10": "","COL_11": "YWZ","COL_21": "","COL_22": ""}'
  v_params := '"is_show_element"' || ':' || '"0"';
  v_params := v_params || ',' || '"item_id"' || ':' || '"a_coop_132_1"';
  v_params := v_params || ',' || '"item_name"' || ':' || '"��������"';
  v_params := '{' || v_params || '}';

  v_sql      := 'select ''' || :ASK_RECORD_ID || '/' || v_methods || '?' ||
                v_params || ''' ASK_RECORD_ID from dual';
  @strresult := v_sql;
END;
}*/^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSOCIATE WHERE ELEMENT_ID = ''associate_a_coop_130''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSOCIATE SET (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) = (SELECT 6,q''[��������]'',2,q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_132_1]'',q''[]'',:CV1 FROM DUAL) WHERE ELEMENT_ID = ''associate_a_coop_130''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSOCIATE (ASSOCIATE_TYPE,CAPTION,DATA_TYPE,ELEMENT_ID,FIELD_NAME,ICON_NAME,NODE_ID,OPEN_TYPE,DATA_SQL) SELECT 6,q''[��������]'',2,''associate_a_coop_130'',q''[ASK_RECORD_ID]'',q''[]'',q''[node_a_coop_132_1]'',q''[]'',:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

