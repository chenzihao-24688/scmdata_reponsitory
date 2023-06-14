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
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',1,q''[COOP_TYPE_DESC_01]'',q''[COOP_TYPE_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',1,''pick_c_2431_3'',q''[COOP_TYPE_DESC_01]'',q''[COOP_TYPE_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',1,q''[COOP_CLASSIFICATION_DESC_01]'',q''[COOP_CLASSIFICATION_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',1,''pick_c_2431_4'',q''[COOP_CLASSIFICATION_DESC_01]'',q''[COOP_CLASSIFICATION_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',1,q''[PRODUCTION_CATEGORY_DESC_01]'',q''[PRODUCTION_CATEGORY_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',1,''pick_c_2431_5'',q''[PRODUCTION_CATEGORY_DESC_01]'',q''[PRODUCTION_CATEGORY_DESC_01]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01,COL_1,COL_2,COL_3]'',q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',0,q''[]'',q''[COOP_TYPE_DESC_01,COOP_CLASSIFICATION_DESC_01,PRODUCTION_CATEGORY_DESC_01]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',1,q''[COOP_TYPE_DESC]'',q''[COOP_TYPE_DESC]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC,COL_1,COL_2]'',q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',0,q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',1,''pick_c_2431_1'',q''[COOP_TYPE_DESC]'',q''[COOP_TYPE_DESC]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC,COL_1,COL_2]'',q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',0,q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',1,q''[COOP_CLASSIFICATION_DESC]'',q''[COOP_CLASSIFICATION_DESC]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC,COL_1,COL_2]'',q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',0,q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2431_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',1,''pick_c_2431_2'',q''[COOP_CLASSIFICATION_DESC]'',q''[COOP_CLASSIFICATION_DESC]'',q''[]'',q''[]'',0,q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC,COL_1,COL_2]'',q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',0,q''[]'',q''[COOP_TYPE_DESC,COOP_CLASSIFICATION_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT a.item_id p_node_item_id, c.caption_sql p_node_item, b.item_id, e.caption_sql item_name
  FROM nbw.sys_tree_list a
 INNER JOIN nbw.sys_tree_list b
    ON a.tree_id = b.tree_id
   AND a.item_id = b.parent_id
 INNER JOIN nbw.sys_item c
    ON a.item_id = c.item_id
   AND a.pause = 0
 INNER JOIN nbw.sys_item e
    ON b.item_id = e.item_id
   AND a.pause = 0
 ORDER BY a.seq_no ASC, a.item_id ASC, b.seq_no ASC
]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_c_2440_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择页面]'',0,q''[ITEM_NAME]'',q''[ITEM_NAME]'',q''[]'',q''[]'',0,q''[ITEM_ID,ITEM_NAME]'',q''[]'',q''[P_NODE_ITEM,ITEM_NAME]'',0,q''[]'',q''[P_NODE_ITEM,ITEM_NAME]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2440_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择页面]'',0,''pick_c_2440_1'',q''[ITEM_NAME]'',q''[ITEM_NAME]'',q''[]'',q''[]'',0,q''[ITEM_ID,ITEM_NAME]'',q''[]'',q''[P_NODE_ITEM,ITEM_NAME]'',0,q''[]'',q''[P_NODE_ITEM,ITEM_NAME]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT dp.data_priv_id,
       dp.data_priv_code,
       dp.data_priv_name,
       dp.seq_no,
       dp.level_type,
       dp.fields_config_method
  FROM sys_data_privs dp
  WHERE dp.pause = 1
 ORDER BY dp.level_type ASC, dp.seq_no ASC]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_c_2421_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[权限名称]'',0,q''[DATA_PRIV_NAME]'',q''[DATA_PRIV_NAME]'',q''[]'',q''[]'',0,q''[DATA_PRIV_ID,DATA_PRIV_CODE,DATA_PRIV_NAME,SEQ_NO,LEVEL_TYPE,FIELDS_CONFIG_METHOD]'',q''[]'',q''[LEVEL_TYPE,DATA_PRIV_NAME]'',0,q''[]'',q''[LEVEL_TYPE,DATA_PRIV_NAME]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2421_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[权限名称]'',0,''pick_c_2421_1'',q''[DATA_PRIV_NAME]'',q''[DATA_PRIV_NAME]'',q''[]'',q''[]'',0,q''[DATA_PRIV_ID,DATA_PRIV_CODE,DATA_PRIV_NAME,SEQ_NO,LEVEL_TYPE,FIELDS_CONFIG_METHOD]'',q''[]'',q''[LEVEL_TYPE,DATA_PRIV_NAME]'',0,q''[]'',q''[LEVEL_TYPE,DATA_PRIV_NAME]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT pg.data_priv_group_id,
       pg.data_priv_group_code,
       pg.data_priv_group_name,
       pg.seq_no
  FROM sys_company_data_priv_group pg
  WHERE pg.company_id = %default_company_id%]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_c_2411_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[权限组名称]'',0,q''[DATA_PRIV_GROUP_NAME]'',q''[DATA_PRIV_GROUP_NAME]'',q''[]'',q''[]'',0,q''[DATA_PRIV_GROUP_ID,DATA_PRIV_GROUP_CODE,DATA_PRIV_GROUP_NAME,SEQ_NO]'',q''[]'',q''[DATA_PRIV_GROUP_NAME]'',0,q''[]'',q''[DATA_PRIV_GROUP_NAME]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_c_2411_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[权限组名称]'',0,''pick_c_2411_1'',q''[DATA_PRIV_GROUP_NAME]'',q''[DATA_PRIV_GROUP_NAME]'',q''[]'',q''[]'',0,q''[DATA_PRIV_GROUP_ID,DATA_PRIV_GROUP_CODE,DATA_PRIV_GROUP_NAME,SEQ_NO]'',q''[]'',q''[DATA_PRIV_GROUP_NAME]'',0,q''[]'',q''[DATA_PRIV_GROUP_NAME]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

