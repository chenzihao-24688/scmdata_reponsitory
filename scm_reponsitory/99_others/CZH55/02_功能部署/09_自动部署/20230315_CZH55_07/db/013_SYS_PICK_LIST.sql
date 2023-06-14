BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^WITH DIC AS
 (SELECT GROUP_DICT_VALUE, GROUP_DICT_NAME, GROUP_DICT_TYPE,group_dict_sort
    FROM SCMDATA.SYS_GROUP_DICT)
SELECT  '' COOPERATION_SUBCATEGORY_DESC,
       ''  COOPERATION_SUBCATEGORY,
         A.GROUP_DICT_VALUE COOPERATION_TYPE,
       A.GROUP_DICT_NAME COOPERATION_TYPE_DESC,
       B.GROUP_DICT_VALUE COOPERATION_CLASSIFICATION,
       B.GROUP_DICT_NAME  COOPERATION_CLASSIFICATION_DES,
       C.GROUP_DICT_VALUE COOPERATION_PRODUCT_CATE,
       C.GROUP_DICT_NAME  COOPERATION_PRODUCT_CATE_DESC
  FROM (SELECT * FROM DIC WHERE GROUP_DICT_VALUE = 'PRODUCT_TYPE') A
  LEFT JOIN DIC B
    ON A.GROUP_DICT_VALUE = B.GROUP_DICT_TYPE
  LEFT JOIN DIC  C
    ON B.GROUP_DICT_VALUE = C.GROUP_DICT_TYPE
    order by b.group_dict_sort asc,c.group_dict_sort asc^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_cateAprocate''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[意向合作类型]'',0,q''[COOPERATION_CLASSIFICATION_DES]'',q''[COOPERATION_CLASSIFICATION_DES]'',q''[]'',q''[]'',0,q''[COOPERATION_SUBCATEGORY_DESC,COOPERATION_SUBCATEGORY,COOPERATION_TYPE,COOPERATION_TYPE_DESC,COOPERATION_CLASSIFICATION,COOPERATION_CLASSIFICATION_DES,COOPERATION_PRODUCT_CATE,COOPERATION_PRODUCT_CATE_DESC]'',q''[]'',q''[COOPERATION_CLASSIFICATION_DES,COOPERATION_PRODUCT_CATE_DESC]'',0,q''[]'',q''[COOPERATION_TYPE_DESC,COOPERATION_CLASSIFICATION_DES,COOPERATION_PRODUCT_CATE_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_cateAprocate''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[意向合作类型]'',0,''picklist_cateAprocate'',q''[COOPERATION_CLASSIFICATION_DES]'',q''[COOPERATION_CLASSIFICATION_DES]'',q''[]'',q''[]'',0,q''[COOPERATION_SUBCATEGORY_DESC,COOPERATION_SUBCATEGORY,COOPERATION_TYPE,COOPERATION_TYPE_DESC,COOPERATION_CLASSIFICATION,COOPERATION_CLASSIFICATION_DES,COOPERATION_PRODUCT_CATE,COOPERATION_PRODUCT_CATE_DESC]'',q''[]'',q''[COOPERATION_CLASSIFICATION_DES,COOPERATION_PRODUCT_CATE_DESC]'',0,q''[]'',q''[COOPERATION_TYPE_DESC,COOPERATION_CLASSIFICATION_DES,COOPERATION_PRODUCT_CATE_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT c.group_dict_value coop_classification,
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
 order by c.group_dict_sort,p.group_dict_sort asc^';
  CV3 CLOB:=q'^^';

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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^  select gc.province province_desc,
         ga.city city_desc,
         gb.county county_desc,
         gc.provinceid company_province,
         ga.cityno company_city,
         gb.countyid company_county,
         gc.province || ga.city || gb.county area
    from dic_county gb
    inner join dic_city ga
      on ga.cityno = gb.cityno and ga.pause=0
    inner join dic_province gc
      on gc.provinceid = ga.provinceid and gc.pause=0
      where gb.pause=0^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择区域]'',1,q''[AREA]'',q''[AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_CITY,COMPANY_COUNTY]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',0,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择区域]'',1,''pick_a_coop_121_5'',q''[AREA]'',q''[AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_CITY,COMPANY_COUNTY]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',0,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^select null               COOPERATION_SUBCATEGORY_DESC,
       null               COOPERATION_SUBCATEGORY,
                 b.group_dict_name COOPERATION_CLASSIFICATION_DES,
                 b.group_dict_value COOPERATION_CLASSIFICATION,
       c.group_dict_name  cooperation_type_DESC,
       c.group_dict_value cooperation_type
  from (select * from sys_group_dict  where group_dict_value = 'PRODUCT_TYPE' and parent_id is not null) c
  left join sys_group_dict b
    on b.group_dict_type = c.group_dict_value
   and b.parent_id is not null^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_7''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[合作分类选择]'',1,q''[COOPERATION_CLASSIFICATION_DES]'',q''[COOPERATION_CLASSIFICATION_DES]'',q''[]'',q''[]'',0,q''[COOPERATION_TYPE_DESC,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY_DESC,COOPERATION_SUBCATEGORY]'',q''[]'',q''[COOPERATION_CLASSIFICATION_DES]'',,q''[]'',q''[COOPERATION_CLASSIFICATION_DES]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_7''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[合作分类选择]'',1,''pick_a_coop_121_7'',q''[COOPERATION_CLASSIFICATION_DES]'',q''[COOPERATION_CLASSIFICATION_DES]'',q''[]'',q''[]'',0,q''[COOPERATION_TYPE_DESC,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY_DESC,COOPERATION_SUBCATEGORY]'',q''[]'',q''[COOPERATION_CLASSIFICATION_DES]'',,q''[]'',q''[COOPERATION_CLASSIFICATION_DES]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^  select gc.province province_desc,
         ga.city city_desc,
         gb.county county_desc,
         gc.provinceid company_province,
         ga.cityno company_city,
         gb.countyid company_county,
         gc.province || ga.city || gb.county PCC
    from dic_county gb
    inner join dic_city ga
      on ga.cityno = gb.cityno and ga.pause=0
    inner join dic_province gc
      on gc.provinceid = ga.provinceid and gc.pause=0
      where gb.pause=0^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_8''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择区域]'',1,q''[PCC]'',q''[PCC]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_CITY,COMPANY_COUNTY]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',0,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_8''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择区域]'',1,''pick_a_coop_121_8'',q''[PCC]'',q''[PCC]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_CITY,COMPANY_COUNTY]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',0,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT
       A.PROVINCEID COMPANY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO COMPANY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID COMPANY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY AR_COMPANY_AREA_Y,
       null ar_company_vill_desc_y,
       null ar_company_vill_y
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_address''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司所在区域]'',0,q''[AR_COMPANY_AREA_Y]'',q''[AR_COMPANY_AREA_Y]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC,AR_COMPANY_VILL_Y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_address''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司所在区域]'',0,''picklist_address'',q''[AR_COMPANY_AREA_Y]'',q''[AR_COMPANY_AREA_Y]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC,AR_COMPANY_VILL_Y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'SP_BRAND_TYPE_N',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'BRAND_TYPE_DESC',
                                                                p_cooperation_brand_field_desc  => 'SP_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  IF :ar_is_our_factory_y = 1 THEN
    raise_application_error(-20002,
                            '【是否本厂】为是时，不可编辑工厂所在街道！！');
  END IF;
  v_sql      := scmdata.pkg_ask_record_mange.f_query_vill_picksql(p_county     => ':factory_county',
                                                                  p_vill_value => 'ar_factory_vill_y',
                                                                  p_vill_desc  => 'ar_factory_vill_desc_y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂所在街道]'',0,q''[AR_FACTORY_VILL_DESC_Y]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_FACTORY_VILL_DESC_Y,AR_FACTORY_VILL_Y]'',q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',0,q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂所在街道]'',0,''pick_a_coop_151_2'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_FACTORY_VILL_DESC_Y,AR_FACTORY_VILL_Y]'',q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',0,q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_ask_record_mange.f_query_picksql_by_type(p_group_dict_type   => 'COMPANY_TYPE',
                                                                     p_dict_value        => 'AR_COMPANY_TYPE_Y',
                                                                     p_dict_desc         => 'AR_COMPANY_TYPE_DESC_Y',
                                                                     p_setnull_fdvalue_1 => 'AR_COOPERATION_MODEL_Y',
                                                                     p_setnull_fddesc_1  => 'AR_COOP_MODEL_DESC_Y',
                                                                     p_setnull_fdvalue_2 => 'AR_PAY_TERM_N',
                                                                     p_setnull_fddesc_2  => 'AR_PAY_TERM_DESC_N',
                                                                     p_setnull_fdvalue_3 => 'AR_PRODUCT_TYPE_Y',
                                                                     p_setnull_fddesc_3  => 'AR_PRODUCT_TYPE_DESC_Y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司类型]'',0,q''[AR_COMPANY_TYPE_DESC_Y]'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[]'',q''[]'',,q''[AR_COMPANY_TYPE_DESC_Y,AR_COMPANY_TYPE_Y,AR_COOPERATION_MODEL_Y,AR_COOP_MODEL_DESC_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y]'',q''[]'',q''[AR_COMPANY_TYPE_DESC_Y]'',0,q''[]'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司类型]'',0,''pick_a_coop_151_3'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[]'',q''[]'',,q''[AR_COMPANY_TYPE_DESC_Y,AR_COMPANY_TYPE_Y,AR_COOPERATION_MODEL_Y,AR_COOP_MODEL_DESC_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y]'',q''[]'',q''[AR_COMPANY_TYPE_DESC_Y]'',0,q''[]'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT /*c.group_dict_value coop_classification,
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
   AND scd.company_id = %default_company_id%
   and scd.pause=0^';
  CV3 CLOB:=q'^^';

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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT
       A.PROVINCEID FACTORY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO FACTORY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID FACTORY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY FPCC,
       null factory_vill,
       null factory_vill_desc
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_factory_area''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂所在区域]'',0,q''[FPCC]'',q''[FPCC]'',q''[]'',q''[]'',0,q''[FACTORY_PROVINCE,PROVINCE_DESC,FACTORY_CITY,CITY_DESC,FACTORY_COUNTY,COUNTY_DESC,FPCC,FACTORY_VILL,FACTORY_VILL_DESC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_factory_area''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂所在区域]'',0,''picklist_factory_area'',q''[FPCC]'',q''[FPCC]'',q''[]'',q''[]'',0,q''[FACTORY_PROVINCE,PROVINCE_DESC,FACTORY_CITY,CITY_DESC,FACTORY_COUNTY,COUNTY_DESC,FPCC,FACTORY_VILL,FACTORY_VILL_DESC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'BRAND_TYPE',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'AR_BRAND_TYPE_DESC_N',
                                                                p_cooperation_brand_field_desc  => 'AR_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[AR_COOP_BRAND_DESC_N]'',q''[AR_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[BRAND_TYPE,COOPERATION_BRAND,AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_121_1'',q''[AR_COOP_BRAND_DESC_N]'',q''[AR_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[BRAND_TYPE,COOPERATION_BRAND,AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'SP_BRAND_TYPE_N',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'BRAND_TYPE_DESC',
                                                                p_cooperation_brand_field_desc  => 'SP_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  IF :ar_company_type_y = '01' THEN
    v_sql := q'[SELECT t.group_dict_value AR_COOPERATION_MODEL_Y,
           t.group_dict_name  ar_coop_model_desc_y,
           NULL               ar_pay_term_n,
           NULL               ar_pay_term_desc_n
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = 'SUPPLY_TYPE'
       AND t.pause = 0
       AND t.group_dict_value = 'ODM']';
  ELSIF :ar_company_type_y = '02' THEN
    v_sql := scmdata.pkg_ask_record_mange.f_query_picksql_by_type(p_group_dict_type   => 'SUPPLY_TYPE',
                                                                  p_dict_value        => 'AR_COOPERATION_MODEL_Y',
                                                                  p_dict_desc         => 'AR_COOP_MODEL_DESC_Y',
                                                                  p_setnull_fdvalue_1 => 'AR_PAY_TERM_N',
                                                                  p_setnull_fddesc_1  => 'AR_PAY_TERM_DESC_N',
                                                                  p_setnull_fdvalue_2 => 'AR_PRODUCT_TYPE_Y',
                                                                  p_setnull_fddesc_2  => 'AR_PRODUCT_TYPE_DESC_Y');
  ELSE
   v_sql := q'[SELECT NULL ar_cooperation_model_y, NULL ar_coop_model_desc_y FROM scmdata.sys_group_dict]';
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[意向合作模式]'',0,q''[AR_COOP_MODEL_DESC_Y]'',q''[AR_COOP_MODEL_DESC_Y]'',q''[]'',q''[]'',1,q''[AR_COOP_MODEL_DESC_Y,AR_COOPERATION_MODEL_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y]'',q''[]'',q''[AR_COOP_MODEL_DESC_Y]'',0,q''[;]'',q''[AR_COOP_MODEL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[意向合作模式]'',0,''pick_a_coop_151_4'',q''[AR_COOP_MODEL_DESC_Y]'',q''[AR_COOP_MODEL_DESC_Y]'',q''[]'',q''[]'',1,q''[AR_COOP_MODEL_DESC_Y,AR_COOPERATION_MODEL_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y]'',q''[]'',q''[AR_COOP_MODEL_DESC_Y]'',0,q''[;]'',q''[AR_COOP_MODEL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT a.provinceid company_province,
       a.province company_province_desc,
       b.cityno company_city,
       b.city company_city_desc,
       c.countyid company_county,
       c.county company_county_desc,
       a.province || b.city || c.county sp_location_area_y,
       NULL ar_company_vill_y,
       NULL AR_COMPANY_VILL_DESC_Y
  FROM dic_province a
  LEFT JOIN dic_city b
    ON a.provinceid = b.provinceid
   AND b.pause = 0
  LEFT JOIN dic_county c
    ON b.cityno = c.cityno
   AND c.pause = 0
 WHERE a.pause = 0^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择所在区域]'',0,q''[SP_LOCATION_AREA_Y]'',q''[SP_LOCATION_AREA_Y]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,SP_LOCATION_AREA_Y,ar_company_vill_y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择所在区域]'',0,''pick_a_supp_151'',q''[SP_LOCATION_AREA_Y]'',q''[SP_LOCATION_AREA_Y]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,SP_LOCATION_AREA_Y,ar_company_vill_y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT
       A.PROVINCEID COMPANY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO COMPANY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID COMPANY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY AR_COMPANY_AREA_Y,
       null ar_company_vill_desc_y,
       null ar_company_vill_y
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_address''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司所在区域]'',0,q''[AR_COMPANY_AREA_Y]'',q''[AR_COMPANY_AREA_Y]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC,AR_COMPANY_VILL_Y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_address''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司所在区域]'',0,''picklist_address'',q''[AR_COMPANY_AREA_Y]'',q''[AR_COMPANY_AREA_Y]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC,AR_COMPANY_VILL_Y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_ask_record_mange.f_query_vill_picksql(p_county     => ':company_county',
                                                                  p_vill_value => 'ar_company_vill_y',
                                                                  p_vill_desc  => 'ar_company_vill_desc_y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司所在街道]'',0,q''[AR_COMPANY_VILL_DESC_Y]'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_COMPANY_VILL_DESC_Y,AR_COMPANY_VILL_Y]'',q''[]'',q''[AR_COMPANY_VILL_DESC_Y]'',0,q''[]'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司所在街道]'',0,''pick_a_coop_151_1'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_COMPANY_VILL_DESC_Y,AR_COMPANY_VILL_Y]'',q''[]'',q''[AR_COMPANY_VILL_DESC_Y]'',0,q''[]'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  IF :ar_company_type_y = '01' THEN
    v_sql := q'[SELECT t.group_dict_value AR_COOPERATION_MODEL_Y,
           t.group_dict_name  ar_coop_model_desc_y,
           NULL               ar_pay_term_n,
           NULL               ar_pay_term_desc_n
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = 'SUPPLY_TYPE'
       AND t.pause = 0
       AND t.group_dict_value = 'ODM']';
  ELSIF :ar_company_type_y = '02' THEN
    v_sql := scmdata.pkg_ask_record_mange.f_query_picksql_by_type(p_group_dict_type   => 'SUPPLY_TYPE',
                                                                  p_dict_value        => 'AR_COOPERATION_MODEL_Y',
                                                                  p_dict_desc         => 'AR_COOP_MODEL_DESC_Y',
                                                                  p_setnull_fdvalue_1 => 'AR_PAY_TERM_N',
                                                                  p_setnull_fddesc_1  => 'AR_PAY_TERM_DESC_N',
                                                                  p_setnull_fdvalue_2 => 'AR_PRODUCT_TYPE_Y',
                                                                  p_setnull_fddesc_2  => 'AR_PRODUCT_TYPE_DESC_Y');
  ELSE
   v_sql := q'[SELECT NULL ar_cooperation_model_y, NULL ar_coop_model_desc_y FROM scmdata.sys_group_dict]';
  END IF;
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[意向合作模式]'',0,q''[AR_COOP_MODEL_DESC_Y]'',q''[AR_COOP_MODEL_DESC_Y]'',q''[]'',q''[]'',1,q''[AR_COOP_MODEL_DESC_Y,AR_COOPERATION_MODEL_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y]'',q''[]'',q''[AR_COOP_MODEL_DESC_Y]'',0,q''[;]'',q''[AR_COOP_MODEL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[意向合作模式]'',0,''pick_a_coop_151_4'',q''[AR_COOP_MODEL_DESC_Y]'',q''[AR_COOP_MODEL_DESC_Y]'',q''[]'',q''[]'',1,q''[AR_COOP_MODEL_DESC_Y,AR_COOPERATION_MODEL_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y]'',q''[]'',q''[AR_COOP_MODEL_DESC_Y]'',0,q''[;]'',q''[AR_COOP_MODEL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'BRAND_TYPE',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'AR_BRAND_TYPE_DESC_N',
                                                                p_cooperation_brand_field_desc  => 'AR_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[AR_COOP_BRAND_DESC_N]'',q''[AR_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[BRAND_TYPE,COOPERATION_BRAND,AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_121_1'',q''[AR_COOP_BRAND_DESC_N]'',q''[AR_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[BRAND_TYPE,COOPERATION_BRAND,AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
    v_query_sql CLOB;
  BEGIN
    v_query_sql := pkg_supplier_info.f_query_person_info_pick(p_person_field => 'CHECK_PERSON2', p_suffix  => '_DESC');
    ^'|| CHR(64) ||q'^strresult := v_query_sql;
  END;}
^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_check_101_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[验厂人员2]'',0,q''[CHECK_PERSON2_DESC]'',q''[CHECK_PERSON2_DESC]'',q''[avatar]'',q''[]'',0,q''[CHECK_PERSON2,CHECK_PERSON2_PHONE]'',q''[]'',q''[CHECK_PERSON2_DESC]'',0,q''[]'',q''[DEPT_NAME,CHECK_PERSON2_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_check_101_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[验厂人员2]'',0,''pick_a_check_101_2'',q''[CHECK_PERSON2_DESC]'',q''[CHECK_PERSON2_DESC]'',q''[avatar]'',q''[]'',0,q''[CHECK_PERSON2,CHECK_PERSON2_PHONE]'',q''[]'',q''[CHECK_PERSON2_DESC]'',0,q''[]'',q''[DEPT_NAME,CHECK_PERSON2_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT a.provinceid company_province,
       a.province company_province_desc,
       b.cityno company_city,
       b.city company_city_desc,
       c.countyid company_county,
       c.county company_county_desc,
       a.province || b.city || c.county sp_location_area_y,
       NULL ar_company_vill_y,
       NULL AR_COMPANY_VILL_DESC_Y
  FROM dic_province a
  LEFT JOIN dic_city b
    ON a.provinceid = b.provinceid
   AND b.pause = 0
  LEFT JOIN dic_county c
    ON b.cityno = c.cityno
   AND c.pause = 0
 WHERE a.pause = 0^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择所在区域]'',0,q''[SP_LOCATION_AREA_Y]'',q''[SP_LOCATION_AREA_Y]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,SP_LOCATION_AREA_Y,ar_company_vill_y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择所在区域]'',0,''pick_a_supp_151'',q''[SP_LOCATION_AREA_Y]'',q''[SP_LOCATION_AREA_Y]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,SP_LOCATION_AREA_Y,ar_company_vill_y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT COMPANY_DICT_VALUE COOPERATION_SUBCATEGORY,
       COMPANY_DICT_NAME  COOPERATION_SUBCATEGORY_DESC
  FROM SCMDATA.SYS_COMPANY_DICT
 WHERE COMPANY_DICT_TYPE = :COOPERATION_PRODUCT_CATE
   AND COMPANY_ID = %default_company_id%
   and pause=0^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_subcate''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[子类]'',0,q''[COOPERATION_SUBCATEGORY_DESC]'',q''[COOPERATION_SUBCATEGORY_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_SUBCATEGORY,COOPERATION_SUBCATEGORY_DESC]'',q''[]'',q''[COOPERATION_SUBCATEGORY_DESC]'',0,q''[;]'',q''[COOPERATION_SUBCATEGORY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_subcate''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[子类]'',0,''picklist_subcate'',q''[COOPERATION_SUBCATEGORY_DESC]'',q''[COOPERATION_SUBCATEGORY_DESC]'',q''[]'',q''[]'',1,q''[COOPERATION_SUBCATEGORY,COOPERATION_SUBCATEGORY_DESC]'',q''[]'',q''[COOPERATION_SUBCATEGORY_DESC]'',0,q''[;]'',q''[COOPERATION_SUBCATEGORY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT c.group_dict_value coop_classification,
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
 order by c.group_dict_sort,p.group_dict_sort asc^';
  CV3 CLOB:=q'^^';

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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_coop_factory_pick(p_item_id => 'a_supp_151_7');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}
^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151_7_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂名称]'',0,q''[FACTORY_NAME]'',q''[FACTORY_NAME]'',q''[]'',q''[]'',0,q''[SUPPLIER_CODE,FACTORY_NAME,COOP_STATUS,COOP_FACTORY_TYPE,FAC_SUP_INFO_ID]'',q''[]'',q''[SUPPLIER_CODE,FACTORY_NAME]'',0,q''[]'',q''[FACTORY_NAME]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151_7_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂名称]'',0,''pick_a_supp_151_7_1'',q''[FACTORY_NAME]'',q''[FACTORY_NAME]'',q''[]'',q''[]'',0,q''[SUPPLIER_CODE,FACTORY_NAME,COOP_STATUS,COOP_FACTORY_TYPE,FAC_SUP_INFO_ID]'',q''[]'',q''[SUPPLIER_CODE,FACTORY_NAME]'',0,q''[]'',q''[FACTORY_NAME]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  IF :ar_is_our_factory_y = 1 THEN
    raise_application_error(-20002,
                            '【是否本厂】为是时，不可编辑工厂所在区域！！');
  END IF;
  v_sql      := q'[SELECT
       A.PROVINCEID FACTORY_PROVINCE,
       A.PROVINCE FACTORY_PROVINCE_DESC,
       B.CITYNO FACTORY_CITY,
       B.CITY FACTORY_CITY_DESC,
       C.COUNTYID FACTORY_COUNTY,
       C.COUNTY FACTORY_COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY AR_FACTORY_AREA_Y,
       null AR_FACTORY_VILL_DESC_Y,
       null AR_FACTORY_VILL_Y
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO]';
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂所在区域]'',0,q''[AR_FACTORY_AREA_Y]'',q''[AR_FACTORY_AREA_Y]'',q''[]'',q''[]'',,q''[FACTORY_PROVINCE,FACTORY_PROVINCE_DESC,FACTORY_CITY,FACTORY_CITY_DESC,FACTORY_COUNTY,FACTORY_COUNTY_DESC,AR_FACTORY_VILL_Y,AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[FACTORY_PROVINCE_DESC,FACTORY_CITY_DESC,FACTORY_COUNTY_DESC]'',,q''[]'',q''[FACTORY_PROVINCE_DESC,FACTORY_CITY_DESC,FACTORY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂所在区域]'',0,''pick_a_coop_121_2'',q''[AR_FACTORY_AREA_Y]'',q''[AR_FACTORY_AREA_Y]'',q''[]'',q''[]'',,q''[FACTORY_PROVINCE,FACTORY_PROVINCE_DESC,FACTORY_CITY,FACTORY_CITY_DESC,FACTORY_COUNTY,FACTORY_COUNTY_DESC,AR_FACTORY_VILL_Y,AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[FACTORY_PROVINCE_DESC,FACTORY_CITY_DESC,FACTORY_COUNTY_DESC]'',,q''[]'',q''[FACTORY_PROVINCE_DESC,FACTORY_CITY_DESC,FACTORY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'FA_BRAND_TYPE',p_cooperation_brand_field => 'FACTORY_COOP_BRAND',p_suffix => '_DESC');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV3 CLOB:=q'^^';

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

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT a.provinceid company_province,
       a.province company_province_desc,
       b.cityno company_city,
       b.city company_city_desc,
       c.countyid company_county,
       c.county company_county_desc,
       a.province || b.city || c.county sp_location_area_y,
       NULL ar_company_vill_y,
       NULL AR_COMPANY_VILL_DESC_Y
  FROM dic_province a
  LEFT JOIN dic_city b
    ON a.provinceid = b.provinceid
   AND b.pause = 0
  LEFT JOIN dic_county c
    ON b.cityno = c.cityno
   AND c.pause = 0
 WHERE a.pause = 0^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择所在区域]'',0,q''[SP_LOCATION_AREA_Y]'',q''[SP_LOCATION_AREA_Y]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,SP_LOCATION_AREA_Y,ar_company_vill_y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择所在区域]'',0,''pick_a_supp_151'',q''[SP_LOCATION_AREA_Y]'',q''[SP_LOCATION_AREA_Y]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,SP_LOCATION_AREA_Y,ar_company_vill_y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT c.group_dict_value coop_classification,
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
 order by c.group_dict_sort,p.group_dict_sort asc^';
  CV3 CLOB:=q'^^';

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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'BRAND_TYPE',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'AR_BRAND_TYPE_DESC_N',
                                                                p_cooperation_brand_field_desc  => 'AR_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[AR_COOP_BRAND_DESC_N]'',q''[AR_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[BRAND_TYPE,COOPERATION_BRAND,AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_121_1'',q''[AR_COOP_BRAND_DESC_N]'',q''[AR_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[BRAND_TYPE,COOPERATION_BRAND,AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  IF :ar_is_our_factory_y = 1 THEN
    raise_application_error(-20002,
                            '【是否本厂】为是时，不可编辑工厂所在区域！！');
  END IF;
  v_sql      := q'[SELECT
       A.PROVINCEID FACTORY_PROVINCE,
       A.PROVINCE FACTORY_PROVINCE_DESC,
       B.CITYNO FACTORY_CITY,
       B.CITY FACTORY_CITY_DESC,
       C.COUNTYID FACTORY_COUNTY,
       C.COUNTY FACTORY_COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY AR_FACTORY_AREA_Y,
       null AR_FACTORY_VILL_DESC_Y,
       null AR_FACTORY_VILL_Y
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO]';
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂所在区域]'',0,q''[AR_FACTORY_AREA_Y]'',q''[AR_FACTORY_AREA_Y]'',q''[]'',q''[]'',,q''[FACTORY_PROVINCE,FACTORY_PROVINCE_DESC,FACTORY_CITY,FACTORY_CITY_DESC,FACTORY_COUNTY,FACTORY_COUNTY_DESC,AR_FACTORY_VILL_Y,AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[FACTORY_PROVINCE_DESC,FACTORY_CITY_DESC,FACTORY_COUNTY_DESC]'',,q''[]'',q''[FACTORY_PROVINCE_DESC,FACTORY_CITY_DESC,FACTORY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂所在区域]'',0,''pick_a_coop_121_2'',q''[AR_FACTORY_AREA_Y]'',q''[AR_FACTORY_AREA_Y]'',q''[]'',q''[]'',,q''[FACTORY_PROVINCE,FACTORY_PROVINCE_DESC,FACTORY_CITY,FACTORY_CITY_DESC,FACTORY_COUNTY,FACTORY_COUNTY_DESC,AR_FACTORY_VILL_Y,AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[FACTORY_PROVINCE_DESC,FACTORY_CITY_DESC,FACTORY_COUNTY_DESC]'',,q''[]'',q''[FACTORY_PROVINCE_DESC,FACTORY_CITY_DESC,FACTORY_COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_lookup_com_mnfacturer(p_com_mnfacturer_field => 'COM_MANUFACTURER',p_suffix  => '_DESC');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}
^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[COM_MANUFACTURER_DESC]'',q''[COM_MANUFACTURER_DESC]'',q''[]'',q''[]'',0,q''[COM_MANUFACTURER_DESC,COM_MANUFACTURER]'',q''[]'',q''[COM_MANUFACTURER_DESC]'',0,q''[]'',q''[COM_MANUFACTURER_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_3'',q''[COM_MANUFACTURER_DESC]'',q''[COM_MANUFACTURER_DESC]'',q''[]'',q''[]'',0,q''[COM_MANUFACTURER_DESC,COM_MANUFACTURER]'',q''[]'',q''[COM_MANUFACTURER_DESC]'',0,q''[]'',q''[COM_MANUFACTURER_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'SP_BRAND_TYPE_N',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'BRAND_TYPE_DESC',
                                                                p_cooperation_brand_field_desc  => 'SP_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT /*c.group_dict_value coop_classification,
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
   AND scd.company_id = %default_company_id%
   and scd.pause=0^';
  CV3 CLOB:=q'^^';

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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT
       A.PROVINCEID COMPANY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO COMPANY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID COMPANY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY AR_COMPANY_AREA_Y,
       null ar_company_vill_desc_y,
       null ar_company_vill_y
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_address''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司所在区域]'',0,q''[AR_COMPANY_AREA_Y]'',q''[AR_COMPANY_AREA_Y]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC,AR_COMPANY_VILL_Y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_address''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司所在区域]'',0,''picklist_address'',q''[AR_COMPANY_AREA_Y]'',q''[AR_COMPANY_AREA_Y]'',q''[]'',q''[]'',,q''[COMPANY_PROVINCE,PROVINCE_DESC,COMPANY_CITY,CITY_DESC,COMPANY_COUNTY,COUNTY_DESC,PCC,AR_COMPANY_VILL_Y,AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_ask_record_mange.f_query_picksql_by_type(p_group_dict_type   => 'COMPANY_TYPE',
                                                                     p_dict_value        => 'AR_COMPANY_TYPE_Y',
                                                                     p_dict_desc         => 'AR_COMPANY_TYPE_DESC_Y',
                                                                     p_setnull_fdvalue_1 => 'AR_COOPERATION_MODEL_Y',
                                                                     p_setnull_fddesc_1  => 'AR_COOP_MODEL_DESC_Y',
                                                                     p_setnull_fdvalue_2 => 'AR_PAY_TERM_N',
                                                                     p_setnull_fddesc_2  => 'AR_PAY_TERM_DESC_N',
                                                                     p_setnull_fdvalue_3 => 'AR_PRODUCT_TYPE_Y',
                                                                     p_setnull_fddesc_3  => 'AR_PRODUCT_TYPE_DESC_Y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司类型]'',0,q''[AR_COMPANY_TYPE_DESC_Y]'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[]'',q''[]'',,q''[AR_COMPANY_TYPE_DESC_Y,AR_COMPANY_TYPE_Y,AR_COOPERATION_MODEL_Y,AR_COOP_MODEL_DESC_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y]'',q''[]'',q''[AR_COMPANY_TYPE_DESC_Y]'',0,q''[]'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司类型]'',0,''pick_a_coop_151_3'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[]'',q''[]'',,q''[AR_COMPANY_TYPE_DESC_Y,AR_COMPANY_TYPE_Y,AR_COOPERATION_MODEL_Y,AR_COOP_MODEL_DESC_Y,AR_PAY_TERM_N,AR_PAY_TERM_DESC_N,AR_PRODUCT_TYPE_Y,AR_PRODUCT_TYPE_DESC_Y]'',q''[]'',q''[AR_COMPANY_TYPE_DESC_Y]'',0,q''[]'',q''[AR_COMPANY_TYPE_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => 'IS_OUR_FACTORY',
                                                               p_field_value     => 'AR_IS_OUR_FACTORY_Y',
                                                               p_field_desc      => 'AR_IS_OUR_FAC_DESC_Y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[是否本厂]'',0,q''[AR_IS_OUR_FAC_DESC_Y]'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[]'',q''[]'',,q''[AR_IS_OUR_FAC_DESC_Y,AR_IS_OUR_FACTORY_Y]'',q''[]'',q''[AR_IS_OUR_FAC_DESC_Y]'',0,q''[]'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[是否本厂]'',0,''pick_a_coop_151_5'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[]'',q''[]'',,q''[AR_IS_OUR_FAC_DESC_Y,AR_IS_OUR_FACTORY_Y]'',q''[]'',q''[AR_IS_OUR_FAC_DESC_Y]'',0,q''[]'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT
       A.PROVINCEID FACTORY_PROVINCE,
       A.PROVINCE PROVINCE_DESC,
       B.CITYNO FACTORY_CITY,
       B.CITY CITY_DESC,
       C.COUNTYID FACTORY_COUNTY,
       C.COUNTY COUNTY_DESC,
       A.PROVINCE || B.CITY || C.COUNTY FPCC,
       null factory_vill,
       null factory_vill_desc
FROM (SELECT PROVINCEID,PROVINCE FROM SCMDATA.DIC_PROVINCE) A
LEFT JOIN (SELECT CITYNO,CITY,PROVINCEID FROM SCMDATA.DIC_CITY WHERE PAUSE=0) B ON A.PROVINCEID=B.PROVINCEID
LEFT JOIN (SELECT COUNTYID,COUNTY,CITYNO FROM SCMDATA.DIC_COUNTY WHERE PAUSE=0) C ON B.CITYNO=C.CITYNO^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''picklist_factory_area''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂所在区域]'',0,q''[FPCC]'',q''[FPCC]'',q''[]'',q''[]'',0,q''[FACTORY_PROVINCE,PROVINCE_DESC,FACTORY_CITY,CITY_DESC,FACTORY_COUNTY,COUNTY_DESC,FPCC,FACTORY_VILL,FACTORY_VILL_DESC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''picklist_factory_area''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂所在区域]'',0,''picklist_factory_area'',q''[FPCC]'',q''[FPCC]'',q''[]'',q''[]'',0,q''[FACTORY_PROVINCE,PROVINCE_DESC,FACTORY_CITY,CITY_DESC,FACTORY_COUNTY,COUNTY_DESC,FPCC,FACTORY_VILL,FACTORY_VILL_DESC]'',q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',,q''[]'',q''[PROVINCE_DESC,CITY_DESC,COUNTY_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT a.provinceid company_province,
         a.province company_province_desc,
         b.cityno company_city,
         b.city company_city_desc,
         c.countyid company_county,
         c.county company_county_desc,
         d.villid company_vill,
         d.vill  company_vill_desc,
         a.province || b.city || c.county||d.vill location_area
    FROM scmdata.dic_province a
    LEFT JOIN scmdata.dic_city b
      ON a.provinceid = b.provinceid
     AND b.pause = 0
    LEFT JOIN scmdata.dic_county c
      ON b.cityno = c.cityno
     AND c.pause = 0
    left join scmdata.dic_village d on c.countyid=d.countyid and d.pause=0
   WHERE a.pause = 0^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_supp_151_V''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[选择所在区域]'',0,q''[LOCATION_AREA]'',q''[LOCATION_AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,COMPANY_VILL,COMPANY_VILL_DESC,LOCATION_AREA]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC,COMPANY_VILL_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC,COMPANY_VILL_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_supp_151_V''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[选择所在区域]'',0,''pick_a_supp_151_V'',q''[LOCATION_AREA]'',q''[LOCATION_AREA]'',q''[]'',q''[]'',0,q''[COMPANY_PROVINCE,COMPANY_PROVINCE_DESC,COMPANY_CITY,COMPANY_CITY_DESC,COMPANY_COUNTY,COMPANY_COUNTY_DESC,COMPANY_VILL,COMPANY_VILL_DESC,LOCATION_AREA]'',q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC,COMPANY_VILL_DESC]'',0,q''[]'',q''[COMPANY_PROVINCE_DESC,COMPANY_CITY_DESC,COMPANY_COUNTY_DESC,COMPANY_VILL_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'SP_BRAND_TYPE_N',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'BRAND_TYPE_DESC',
                                                                p_cooperation_brand_field_desc  => 'SP_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'SP_BRAND_TYPE_N',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'BRAND_TYPE_DESC',
                                                                p_cooperation_brand_field_desc  => 'SP_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field => 'FA_BRAND_TYPE',p_cooperation_brand_field => 'FACTORY_COOP_BRAND',p_suffix => '_DESC');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV3 CLOB:=q'^^';

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

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_ask_record_mange.f_query_vill_picksql(p_county     => ':company_county',
                                                                  p_vill_value => 'ar_company_vill_y',
                                                                  p_vill_desc  => 'ar_company_vill_desc_y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[公司所在街道]'',0,q''[AR_COMPANY_VILL_DESC_Y]'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_COMPANY_VILL_DESC_Y,AR_COMPANY_VILL_Y]'',q''[]'',q''[AR_COMPANY_VILL_DESC_Y]'',0,q''[]'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[公司所在街道]'',0,''pick_a_coop_151_1'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_COMPANY_VILL_DESC_Y,AR_COMPANY_VILL_Y]'',q''[]'',q''[AR_COMPANY_VILL_DESC_Y]'',0,q''[]'',q''[AR_COMPANY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => 'IS_OUR_FACTORY',
                                                               p_field_value     => 'AR_IS_OUR_FACTORY_Y',
                                                               p_field_desc      => 'AR_IS_OUR_FAC_DESC_Y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[是否本厂]'',0,q''[AR_IS_OUR_FAC_DESC_Y]'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[]'',q''[]'',,q''[AR_IS_OUR_FAC_DESC_Y,AR_IS_OUR_FACTORY_Y]'',q''[]'',q''[AR_IS_OUR_FAC_DESC_Y]'',0,q''[]'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[是否本厂]'',0,''pick_a_coop_151_5'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[]'',q''[]'',,q''[AR_IS_OUR_FAC_DESC_Y,AR_IS_OUR_FACTORY_Y]'',q''[]'',q''[AR_IS_OUR_FAC_DESC_Y]'',0,q''[]'',q''[AR_IS_OUR_FAC_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^SELECT /*c.group_dict_value coop_classification,
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
   AND scd.company_id = %default_company_id%
   and scd.pause=0^';
  CV3 CLOB:=q'^^';

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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'BRAND_TYPE',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'AR_BRAND_TYPE_DESC_N',
                                                                p_cooperation_brand_field_desc  => 'AR_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[AR_COOP_BRAND_DESC_N]'',q''[AR_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[BRAND_TYPE,COOPERATION_BRAND,AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_121_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_121_1'',q''[AR_COOP_BRAND_DESC_N]'',q''[AR_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[BRAND_TYPE,COOPERATION_BRAND,AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[AR_BRAND_TYPE_DESC_N,AR_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_ask_record_mange.f_query_check_person_picksql();
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_10''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[验厂申请人]'',0,q''[FA_CHECK_PERSON_DESC_Y]'',q''[FA_CHECK_PERSON_DESC_Y]'',q''[]'',q''[]'',,q''[FA_CHECK_PERSON_Y,FA_CHECK_PERSON_DESC_Y,FA_CHECK_DEPT_NAME_Y,FA_DEPT_NAME_DESC_Y]'',q''[]'',q''[FA_CHECK_PERSON_DESC_Y]'',0,q''[]'',q''[FA_CHECK_PERSON_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_10''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[验厂申请人]'',0,''pick_a_coop_150_3_10'',q''[FA_CHECK_PERSON_DESC_Y]'',q''[FA_CHECK_PERSON_DESC_Y]'',q''[]'',q''[]'',,q''[FA_CHECK_PERSON_Y,FA_CHECK_PERSON_DESC_Y,FA_CHECK_DEPT_NAME_Y,FA_DEPT_NAME_DESC_Y]'',q''[]'',q''[FA_CHECK_PERSON_DESC_Y]'',0,q''[]'',q''[FA_CHECK_PERSON_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_ask_record_mange.f_query_check_dept_name_picksql(p_company_id => %default_company_id%,
                                                                             p_user_id    => :fa_check_person_y);
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_11''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[验厂部门]'',0,q''[FA_DEPT_NAME_DESC_Y]'',q''[FA_DEPT_NAME_DESC_Y]'',q''[]'',q''[]'',,q''[FA_CHECK_DEPT_NAME_Y,FA_DEPT_NAME_DESC_Y]'',q''[]'',q''[FA_DEPT_NAME_DESC_Y]'',0,q''[]'',q''[FA_DEPT_NAME_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_11''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[验厂部门]'',0,''pick_a_coop_150_3_11'',q''[FA_DEPT_NAME_DESC_Y]'',q''[FA_DEPT_NAME_DESC_Y]'',q''[]'',q''[]'',,q''[FA_CHECK_DEPT_NAME_Y,FA_DEPT_NAME_DESC_Y]'',q''[]'',q''[FA_DEPT_NAME_DESC_Y]'',0,q''[]'',q''[FA_DEPT_NAME_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_coop_brand_picksql(p_brand_field_value             => 'SP_BRAND_TYPE_N',
                                                                p_cooperation_brand_field_value => 'COOPERATION_BRAND',
                                                                p_brand_field_desc              => 'BRAND_TYPE_DESC',
                                                                p_cooperation_brand_field_desc  => 'SP_COOP_BRAND_DESC_N');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[请选择]'',0,q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_150_3_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[请选择]'',0,''pick_a_coop_150_3_1'',q''[SP_COOP_BRAND_DESC_N]'',q''[SP_COOP_BRAND_DESC_N]'',q''[]'',q''[]'',1,q''[SP_BRAND_TYPE_N,COOPERATION_BRAND,BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',0,q''[;]'',q''[BRAND_TYPE_DESC,SP_COOP_BRAND_DESC_N]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{DECLARE
 v_query_sql CLOB;
BEGIN
  v_query_sql := pkg_supplier_info.f_query_person_info_pick(p_person_field => 'CHECK_PERSON1', p_suffix  => '_DESC');
  ^'|| CHR(64) ||q'^strresult := v_query_sql;
END;}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_check_101_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[验厂人员1]'',0,q''[CHECK_PERSON1_DESC]'',q''[CHECK_PERSON1_DESC]'',q''[avatar]'',q''[]'',0,q''[CHECK_PERSON1,CHECK_PERSON1_DESC,CHECK_PERSON1_PHONE]'',q''[]'',q''[CHECK_PERSON1_DESC]'',0,q''[]'',q''[DEPT_NAME,CHECK_PERSON1_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_check_101_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[验厂人员1]'',0,''pick_a_check_101_1'',q''[CHECK_PERSON1_DESC]'',q''[CHECK_PERSON1_DESC]'',q''[avatar]'',q''[]'',0,q''[CHECK_PERSON1,CHECK_PERSON1_DESC,CHECK_PERSON1_PHONE]'',q''[]'',q''[CHECK_PERSON1_DESC]'',0,q''[]'',q''[DEPT_NAME,CHECK_PERSON1_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  IF :ar_is_our_factory_y = 1 THEN
    raise_application_error(-20002,
                            '【是否本厂】为是时，不可编辑工厂所在街道！！');
  END IF;
  v_sql      := scmdata.pkg_ask_record_mange.f_query_vill_picksql(p_county     => ':factory_county',
                                                                  p_vill_value => 'ar_factory_vill_y',
                                                                  p_vill_desc  => 'ar_factory_vill_desc_y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂所在街道]'',0,q''[AR_FACTORY_VILL_DESC_Y]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_FACTORY_VILL_DESC_Y,AR_FACTORY_VILL_Y]'',q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',0,q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂所在街道]'',0,''pick_a_coop_151_2'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_FACTORY_VILL_DESC_Y,AR_FACTORY_VILL_Y]'',q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',0,q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV1 CLOB:=q'^^';
  CV2 CLOB:=q'^{
DECLARE
  v_sql CLOB;
BEGIN
  IF :ar_is_our_factory_y = 1 THEN
    raise_application_error(-20002,
                            '【是否本厂】为是时，不可编辑工厂所在街道！！');
  END IF;
  v_sql      := scmdata.pkg_ask_record_mange.f_query_vill_picksql(p_county     => ':factory_county',
                                                                  p_vill_value => 'ar_factory_vill_y',
                                                                  p_vill_desc  => 'ar_factory_vill_desc_y');
  ^'|| CHR(64) ||q'^strresult := v_sql;
END;
}^';
  CV3 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_coop_151_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[工厂所在街道]'',0,q''[AR_FACTORY_VILL_DESC_Y]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_FACTORY_VILL_DESC_Y,AR_FACTORY_VILL_Y]'',q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',0,q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_coop_151_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[工厂所在街道]'',0,''pick_a_coop_151_2'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',q''[]'',,q''[AR_FACTORY_VILL_DESC_Y,AR_FACTORY_VILL_Y]'',q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',0,q''[]'',q''[AR_FACTORY_VILL_DESC_Y]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

