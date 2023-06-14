BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[SELECT /*c.group_dict_value coop_classification,
       c.group_dict_name coop_classification_desc,
       gd.group_dict_value coop_product_cate,
       gd.group_dict_name coop_product_cate_desc,*/
       scd.company_dict_value coop_subcategory,
       scd.company_dict_name coop_subcategory_desc
  FROM scmdata.sys_group_dict p
 INNER JOIN scmdata.sys_group_dict c
    ON p.group_dict_id = c.parent_id
   AND p.group_dict_value = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict gd
    ON c.group_dict_id = gd.parent_id
 INNER JOIN scmdata.sys_company_dict scd
    ON gd.group_dict_id = scd.parent_id
   AND gd.group_dict_value = :coop_product_cate
   AND scd.company_id = %default_company_id%]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[可合作产品子类]'',0,q''[coop_subcategory_desc]'',q''[coop_subcategory_desc]'',q''[]'',q''[]'',1,q''[coop_subcategory,coop_subcategory_desc]'',q''[]'',q''[coop_subcategory_desc]'',0,q''[;]'',q''[coop_subcategory_desc]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[可合作产品子类]'',0,''pick_a_supp_151_1'',q''[coop_subcategory_desc]'',q''[coop_subcategory_desc]'',q''[]'',q''[]'',1,q''[coop_subcategory,coop_subcategory_desc]'',q''[]'',q''[coop_subcategory_desc]'',0,q''[;]'',q''[coop_subcategory_desc]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT c.group_dict_value coop_classification,
       c.group_dict_name coop_classification_desc,
       gd.group_dict_value coop_product_cate,
       gd.group_dict_name coop_product_cate_desc,
       '' coop_subcategory,
       '' coop_subcategory_desc
  FROM scmdata.sys_group_dict p
 INNER JOIN scmdata.sys_group_dict c
    ON p.group_dict_id = c.parent_id
   AND p.group_dict_value = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict gd
    ON c.group_dict_id = gd.parent_id
 order by c.group_dict_sort,p.group_dict_sort asc]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[可生产类别]'',0,q''[coop_product_cate_desc]'',q''[coop_product_cate_desc]'',q''[]'',q''[]'',0,q''[coop_classification,coop_classification_desc,coop_product_cate,coop_product_cate_desc,coop_subcategory,coop_subcategory_desc]'',q''[]'',q''[coop_classification_desc,coop_product_cate_desc]'',0,q''[]'',q''[coop_classification_desc,coop_product_cate_desc]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[可生产类别]'',0,''pick_a_supp_151_2'',q''[coop_product_cate_desc]'',q''[coop_product_cate_desc]'',q''[]'',q''[]'',0,q''[coop_classification,coop_classification_desc,coop_product_cate,coop_product_cate_desc,coop_subcategory,coop_subcategory_desc]'',q''[]'',q''[coop_classification_desc,coop_product_cate_desc]'',0,q''[]'',q''[coop_classification_desc,coop_product_cate_desc]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

