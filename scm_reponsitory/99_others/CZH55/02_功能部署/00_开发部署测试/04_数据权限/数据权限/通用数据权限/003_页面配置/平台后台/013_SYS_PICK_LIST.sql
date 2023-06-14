BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := pkg_data_privs.get_pick_list_sql(p_data_priv_id => :data_priv_id);

  @strresult := v_sql;

END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_c_2431_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[��ѡ��]'',1,q''[COOP_TYPE_DESC_01]'',q''[COOP_TYPE_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[��ѡ��]'',1,''pick_c_2431_3'',q''[COOP_TYPE_DESC_01]'',q''[COOP_TYPE_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
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
  CV2 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := pkg_data_privs.get_pick_list_sql(p_data_priv_id => :data_priv_id);

  @strresult := v_sql;

END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_c_2431_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[��ѡ��]'',1,q''[COOP_CLASSIFICATION_DESC_01]'',q''[COOP_CLASSIFICATION_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[��ѡ��]'',1,''pick_c_2431_4'',q''[COOP_CLASSIFICATION_DESC_01]'',q''[COOP_CLASSIFICATION_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
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
  CV2 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := pkg_data_privs.get_pick_list_sql(p_data_priv_id => :data_priv_id);

  @strresult := v_sql;

END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_c_2431_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[��ѡ��]'',1,q''[PRODUCTION_CATEGORY_DESC_01]'',q''[PRODUCTION_CATEGORY_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[��ѡ��]'',1,''pick_c_2431_5'',q''[PRODUCTION_CATEGORY_DESC_01]'',q''[PRODUCTION_CATEGORY_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
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
  CV2 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := pkg_data_privs.get_pick_list_sql(p_data_priv_id => :data_priv_id);

  @strresult := v_sql;

END;}

/*SELECT a.group_dict_name  COL_1_DESC,
       a.group_dict_value COL_1,
       b.group_dict_name  COL_2_DESC,
       b.group_dict_value COL_2
  FROM sys_group_dict a
  LEFT JOIN sys_group_dict b
    ON a.group_dict_value = b.group_dict_type
  LEFT JOIN sys_group_dict c
    ON b.group_dict_value = c.group_dict_type
 WHERE a.group_dict_type = 'COOPERATION_TYPE'*/]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_c_2431_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[��ѡ��]'',1,q''[COOP_TYPE_DESC]'',q''[COOP_TYPE_DESC]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC,COL_1,COL_2]'',q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',0,q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[��ѡ��]'',1,''pick_c_2431_1'',q''[COOP_TYPE_DESC]'',q''[COOP_TYPE_DESC]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC,COL_1,COL_2]'',q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',0,q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
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
  CV2 CLOB:=q'[{DECLARE
  v_sql CLOB;
BEGIN
  v_sql := pkg_data_privs.get_pick_list_sql(p_data_priv_id => :data_priv_id);

  @strresult := v_sql;

END;}
/*SELECT a.group_dict_name  COL_1_DESC,
       a.group_dict_value COL_1,
       b.group_dict_name  COL_2_DESC,
       b.group_dict_value COL_2
  FROM sys_group_dict a
  LEFT JOIN sys_group_dict b
    ON a.group_dict_value = b.group_dict_type
 WHERE a.group_dict_type = 'COOPERATION_TYPE'*/]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_c_2431_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[��ѡ��]'',1,q''[COOP_CLASSIFICATION_DESC]'',q''[COOP_CLASSIFICATION_DESC]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC,COL_1,COL_2]'',q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',0,q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[��ѡ��]'',1,''pick_c_2431_2'',q''[COOP_CLASSIFICATION_DESC]'',q''[COOP_CLASSIFICATION_DESC]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC,COL_1,COL_2]'',q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',0,q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

