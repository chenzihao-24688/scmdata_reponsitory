BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[SELECT a.provinceid company_province,
       a.province company_province_desc,
       b.cityno company_city,
       b.city company_city_desc,
       c.countyid company_county,
       c.county company_county_desc,
       a.province || b.city || c.county location_area
  FROM dic_province a
  LEFT JOIN dic_city b
    ON a.provinceid = b.provinceid and b.pause=0
  LEFT JOIN dic_county c
    ON b.cityno = c.cityno and c.pause=0
    where a.pause=0]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择所在区域]'',0,q''[LOCATION_AREA]'',q''[LOCATION_AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,LOCATION_AREA]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择所在区域]'',0,''pick_a_supp_151'',q''[LOCATION_AREA]'',q''[LOCATION_AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,LOCATION_AREA]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT a.provinceid company_province,
       a.province company_province_desc,
       b.cityno company_city,
       b.city company_city_desc,
       c.countyid company_county,
       c.county company_county_desc,
       a.province || b.city || c.county location_area
  FROM dic_province a
  LEFT JOIN dic_city b
    ON a.provinceid = b.provinceid and b.pause=0
  LEFT JOIN dic_county c
    ON b.cityno = c.cityno and c.pause=0
    where a.pause=0]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择所在区域]'',0,q''[LOCATION_AREA]'',q''[LOCATION_AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,LOCATION_AREA]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择所在区域]'',0,''pick_a_supp_151'',q''[LOCATION_AREA]'',q''[LOCATION_AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,LOCATION_AREA]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT a.provinceid company_province,
       a.province company_province_desc,
       b.cityno company_city,
       b.city company_city_desc,
       c.countyid company_county,
       c.county company_county_desc,
       a.province || b.city || c.county location_area
  FROM dic_province a
  LEFT JOIN dic_city b
    ON a.provinceid = b.provinceid and b.pause=0
  LEFT JOIN dic_county c
    ON b.cityno = c.cityno and c.pause=0
    where a.pause=0]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择所在区域]'',0,q''[LOCATION_AREA]'',q''[LOCATION_AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,LOCATION_AREA]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择所在区域]'',0,''pick_a_supp_151'',q''[LOCATION_AREA]'',q''[LOCATION_AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,LOCATION_AREA]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[SELECT
       A.PROVINCEID COMPANY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO COMPANY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID COMPANY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY PCC
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_address''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司所在区域]'',0,q''[PCC]'',q''[PCC]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_address''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司所在区域]'',0,''picklist_address'',q''[PCC]'',q''[PCC]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT
       A.PROVINCEID COMPANY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO COMPANY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID COMPANY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY PCC
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_address''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司所在区域]'',0,q''[PCC]'',q''[PCC]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_address''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司所在区域]'',0,''picklist_address'',q''[PCC]'',q''[PCC]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT
       A.PROVINCEID COMPANY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO COMPANY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID COMPANY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY PCC
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_address''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司所在区域]'',0,q''[PCC]'',q''[PCC]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_address''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司所在区域]'',0,''picklist_address'',q''[PCC]'',q''[PCC]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT
       A.PROVINCEID FACTORY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO FACTORY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID FACTORY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY FPCC
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_factory_area''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂所在区域]'',0,q''[FPCC]'',q''[FPCC]'',q''[]'',q''[]'',0,q''[FACTORY_PROVINCE,PROVINCE_DESC,FACTORY_CITY,CITY_DESC,FACTORY_COUNTY,COUNTY_DESC,FPCC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_factory_area''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂所在区域]'',0,''picklist_factory_area'',q''[FPCC]'',q''[FPCC]'',q''[]'',q''[]'',0,q''[FACTORY_PROVINCE,PROVINCE_DESC,FACTORY_CITY,CITY_DESC,FACTORY_COUNTY,COUNTY_DESC,FPCC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'BRAND_TYPE',p_cooperation_brand_field => 'COOPERATION_BRAND',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_121_1'',q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'BRAND_TYPE',p_cooperation_brand_field => 'COOPERATION_BRAND',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_121_1'',q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'BRAND_TYPE',p_cooperation_brand_field => 'COOPERATION_BRAND',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'BRAND_TYPE',p_cooperation_brand_field => 'COOPERATION_BRAND',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'BRAND_TYPE',p_cooperation_brand_field => 'COOPERATION_BRAND',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'BRAND_TYPE',p_cooperation_brand_field => 'COOPERATION_BRAND',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'BRAND_TYPE',p_cooperation_brand_field => 'COOPERATION_BRAND',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[COOPERATION_BRAND_DESC]'',q''[COOPERATION_BRAND_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_BRAND_DESC,COOPERATION_BRAND,BRAND_TYPE_DESC,BRAND_TYPE]'',q''[]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',0,q''[;]'',q''[BRAND_TYPE_DESC,COOPERATION_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'FA_BRAND_TYPE',p_cooperation_brand_field => 'FACTORY_COOP_BRAND',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[FACTORY_COOP_BRAND_DESC]'',q''[FACTORY_COOP_BRAND_DESC]'',q''[]'',q''[]'',1,q''[FA_BRAND_TYPE_DESC,FA_BRAND_TYPE,FACTORY_COOP_BRAND_DESC,FACTORY_COOP_BRAND]'',q''[]'',q''[FA_BRAND_TYPE_DESC,FACTORY_COOP_BRAND_DESC]'',0,q''[;]'',q''[FA_BRAND_TYPE_DESC,FACTORY_COOP_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_2'',q''[FACTORY_COOP_BRAND_DESC]'',q''[FACTORY_COOP_BRAND_DESC]'',q''[]'',q''[]'',1,q''[FA_BRAND_TYPE_DESC,FA_BRAND_TYPE,FACTORY_COOP_BRAND_DESC,FACTORY_COOP_BRAND]'',q''[]'',q''[FA_BRAND_TYPE_DESC,FACTORY_COOP_BRAND_DESC]'',0,q''[;]'',q''[FA_BRAND_TYPE_DESC,FACTORY_COOP_BRAND_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

