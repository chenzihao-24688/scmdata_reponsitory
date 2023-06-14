BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[]';
  CV2 CLOB:=q'[SELECT ad.problem_classification problem_class_pr,
       ad.cause_classification cause_class_pr,
       ad.cause_detail cause_detailed_pr,
       ad.is_sup_exemption is_sup_responsible,
       (SELECT sd.dept_name
          FROM scmdata.sys_company_dept sd
         WHERE sd.company_id = ad.company_id
           AND sd.company_dept_id = ad.first_dept_id) responsible_dept_pr,
       (SELECT sd.dept_name
          FROM scmdata.sys_company_dept sd
         WHERE sd.company_id = ad.company_id
           AND sd.company_dept_id = ad.second_dept_id) responsible_dept_sec_pr
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_abnormal_range_config ar
    ON tc.company_id = ar.company_id
   AND tc.category = ar.industry_classification
   AND tc.product_cate = ar.production_category
   AND instr(';' || ar.product_subclass || ';',
             ';' || tc.samll_category || ';') > 0
   AND ar.pause = 0
 INNER JOIN scmdata.t_abnormal_dtl_config ad
    ON ar.company_id = ad.company_id
   AND ar.abnormal_config_id = ad.abnormal_config_id
   AND ad.pause = 0
 INNER JOIN scmdata.t_abnormal_config ab
    ON ab.company_id = ad.company_id
   AND ab.abnormal_config_id = ad.abnormal_config_id
   AND ab.pause = 0
 WHERE tc.company_id = :company_id
   AND tc.goo_id = :goo_id_pr
   AND ad.anomaly_classification = :anomaly_class_pr]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[问题分类]'',0,q''[PROBLEM_CLASS_PR]'',q''[CAUSE_CLASS_PR]'',q''[]'',q''[]'',0,q''[CAUSE_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_DETAILED_PR,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT_PR,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[PROBLEM_CLASS_PR]'',0,q''[]'',q''[PROBLEM_CLASS_PR,CAUSE_CLASS_PR,CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[问题分类]'',0,''pick_a_product_118_1'',q''[PROBLEM_CLASS_PR]'',q''[CAUSE_CLASS_PR]'',q''[]'',q''[]'',0,q''[CAUSE_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_DETAILED_PR,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT_PR,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[PROBLEM_CLASS_PR]'',0,q''[]'',q''[PROBLEM_CLASS_PR,CAUSE_CLASS_PR,CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT ad.problem_classification problem_class_pr,
       ad.cause_classification cause_class_pr,
       ad.cause_detail cause_detailed_pr,
       ad.is_sup_exemption is_sup_responsible,
       (SELECT sd.dept_name
          FROM scmdata.sys_company_dept sd
         WHERE sd.company_id = ad.company_id
           AND sd.company_dept_id = ad.first_dept_id) responsible_dept_pr,
       (SELECT sd.dept_name
          FROM scmdata.sys_company_dept sd
         WHERE sd.company_id = ad.company_id
           AND sd.company_dept_id = ad.second_dept_id) responsible_dept_sec_pr
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_abnormal_range_config ar
    ON tc.company_id = ar.company_id
   AND tc.category = ar.industry_classification
   AND tc.product_cate = ar.production_category
   AND instr(';' || ar.product_subclass || ';',
             ';' || tc.samll_category || ';') > 0
   AND ar.pause = 0
 INNER JOIN scmdata.t_abnormal_dtl_config ad
    ON ar.company_id = ad.company_id
   AND ar.abnormal_config_id = ad.abnormal_config_id
   AND ad.pause = 0
 INNER JOIN scmdata.t_abnormal_config ab
    ON ab.company_id = ad.company_id
   AND ab.abnormal_config_id = ad.abnormal_config_id
   AND ab.pause = 0
 WHERE tc.company_id = :company_id
   AND tc.goo_id = :goo_id_pr
   AND ad.anomaly_classification = :anomaly_class_pr]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[问题分类]'',0,q''[PROBLEM_CLASS_PR]'',q''[CAUSE_CLASS_PR]'',q''[]'',q''[]'',0,q''[CAUSE_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_DETAILED_PR,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT_PR,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[PROBLEM_CLASS_PR]'',0,q''[]'',q''[PROBLEM_CLASS_PR,CAUSE_CLASS_PR,CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[问题分类]'',0,''pick_a_product_118_1'',q''[PROBLEM_CLASS_PR]'',q''[CAUSE_CLASS_PR]'',q''[]'',q''[]'',0,q''[CAUSE_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_DETAILED_PR,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT_PR,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[PROBLEM_CLASS_PR]'',0,q''[]'',q''[PROBLEM_CLASS_PR,CAUSE_CLASS_PR,CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT ad.problem_classification problem_class_pr,
       ad.cause_classification cause_class_pr,
       ad.cause_detail cause_detailed_pr,
       ad.is_sup_exemption is_sup_responsible,
       (SELECT sd.dept_name
          FROM scmdata.sys_company_dept sd
         WHERE sd.company_id = ad.company_id
           AND sd.company_dept_id = ad.first_dept_id) responsible_dept_pr,
       (SELECT sd.dept_name
          FROM scmdata.sys_company_dept sd
         WHERE sd.company_id = ad.company_id
           AND sd.company_dept_id = ad.second_dept_id) responsible_dept_sec_pr
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_abnormal_range_config ar
    ON tc.company_id = ar.company_id
   AND tc.category = ar.industry_classification
   AND tc.product_cate = ar.production_category
   AND instr(';' || ar.product_subclass || ';',
             ';' || tc.samll_category || ';') > 0
   AND ar.pause = 0
 INNER JOIN scmdata.t_abnormal_dtl_config ad
    ON ar.company_id = ad.company_id
   AND ar.abnormal_config_id = ad.abnormal_config_id
   AND ad.pause = 0
 INNER JOIN scmdata.t_abnormal_config ab
    ON ab.company_id = ad.company_id
   AND ab.abnormal_config_id = ad.abnormal_config_id
   AND ab.pause = 0
 WHERE tc.company_id = :company_id
   AND tc.goo_id = :goo_id_pr
   AND ad.anomaly_classification = :anomaly_class_pr]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[问题分类]'',0,q''[PROBLEM_CLASS_PR]'',q''[CAUSE_CLASS_PR]'',q''[]'',q''[]'',0,q''[CAUSE_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_DETAILED_PR,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT_PR,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[PROBLEM_CLASS_PR]'',0,q''[]'',q''[PROBLEM_CLASS_PR,CAUSE_CLASS_PR,CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[问题分类]'',0,''pick_a_product_118_1'',q''[PROBLEM_CLASS_PR]'',q''[CAUSE_CLASS_PR]'',q''[]'',q''[]'',0,q''[CAUSE_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_DETAILED_PR,IS_SUP_RESPONSIBLE,RESPONSIBLE_DEPT_PR,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[PROBLEM_CLASS_PR]'',0,q''[]'',q''[PROBLEM_CLASS_PR,CAUSE_CLASS_PR,CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT a.group_dict_value anomaly_class_pr,
       a.group_dict_name anomaly_class_desc,
       '' problem_class_pr,
       '' cause_class_pr,
       '' cause_detailed_pr
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT']';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[异常分类]'',0,q''[ANOMALY_CLASS_DESC]'',q''[ANOMALY_CLASS_DESC]'',q''[]'',q''[]'',0,q''[ANOMALY_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_CLASS_PR]'',q''[]'',q''[ANOMALY_CLASS_DESC]'',0,q''[]'',q''[ANOMALY_CLASS_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[异常分类]'',0,''pick_a_product_118_3'',q''[ANOMALY_CLASS_DESC]'',q''[ANOMALY_CLASS_DESC]'',q''[]'',q''[]'',0,q''[ANOMALY_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_CLASS_PR]'',q''[]'',q''[ANOMALY_CLASS_DESC]'',0,q''[]'',q''[ANOMALY_CLASS_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT a.group_dict_value anomaly_class_pr,
       a.group_dict_name anomaly_class_desc,
       '' problem_class_pr,
       '' cause_class_pr,
       '' cause_detailed_pr
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = 'ANOMALY_CLASSIFICATION_DICT']';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[异常分类]'',0,q''[ANOMALY_CLASS_DESC]'',q''[ANOMALY_CLASS_DESC]'',q''[]'',q''[]'',0,q''[ANOMALY_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_CLASS_PR]'',q''[]'',q''[ANOMALY_CLASS_DESC]'',0,q''[]'',q''[ANOMALY_CLASS_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[异常分类]'',0,''pick_a_product_118_3'',q''[ANOMALY_CLASS_DESC]'',q''[ANOMALY_CLASS_DESC]'',q''[]'',q''[]'',0,q''[ANOMALY_CLASS_PR,PROBLEM_CLASS_PR,CAUSE_CLASS_PR]'',q''[]'',q''[ANOMALY_CLASS_DESC]'',0,q''[]'',q''[ANOMALY_CLASS_DESC]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[select a.company_dept_id,a.dept_name responsible_dept_pr,a.parent_id
  from sys_company_dept a
 where a.company_id=%default_company_id%]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[责任部门(1级)]'',0,q''[RESPONSIBLE_DEPT_PR]'',q''[RESPONSIBLE_DEPT_PR]'',q''[]'',q''[]'',0,q''[COMPANY_DEPT_ID]'',q''[]'',q''[RESPONSIBLE_DEPT_PR]'',1,q''[]'',q''[COMPANY_DEPT_ID,PARENT_ID,RESPONSIBLE_DEPT_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[责任部门(1级)]'',0,''pick_a_product_118_4'',q''[RESPONSIBLE_DEPT_PR]'',q''[RESPONSIBLE_DEPT_PR]'',q''[]'',q''[]'',0,q''[COMPANY_DEPT_ID]'',q''[]'',q''[RESPONSIBLE_DEPT_PR]'',1,q''[]'',q''[COMPANY_DEPT_ID,PARENT_ID,RESPONSIBLE_DEPT_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[select a.company_dept_id,a.dept_name responsible_dept_pr,a.parent_id
  from sys_company_dept a
 where a.company_id=%default_company_id%]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_4''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[责任部门(1级)]'',0,q''[RESPONSIBLE_DEPT_PR]'',q''[RESPONSIBLE_DEPT_PR]'',q''[]'',q''[]'',0,q''[COMPANY_DEPT_ID]'',q''[]'',q''[RESPONSIBLE_DEPT_PR]'',1,q''[]'',q''[COMPANY_DEPT_ID,PARENT_ID,RESPONSIBLE_DEPT_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_4''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[责任部门(1级)]'',0,''pick_a_product_118_4'',q''[RESPONSIBLE_DEPT_PR]'',q''[RESPONSIBLE_DEPT_PR]'',q''[]'',q''[]'',0,q''[COMPANY_DEPT_ID]'',q''[]'',q''[RESPONSIBLE_DEPT_PR]'',1,q''[]'',q''[COMPANY_DEPT_ID,PARENT_ID,RESPONSIBLE_DEPT_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT ad.problem_classification delay_problem_class_pr,
       ad.cause_classification   delay_cause_class_pr,
       ad.cause_detail           delay_cause_detailed_pr
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_abnormal_range_config ar
    ON tc.company_id = ar.company_id
   AND tc.category = ar.industry_classification
   AND tc.product_cate = ar.production_category
   AND instr(';' || ar.product_subclass || ';',
             ';' || tc.samll_category || ';') > 0
   AND ar.pause = 0
 INNER JOIN scmdata.t_abnormal_dtl_config ad
    ON ar.company_id = ad.company_id
   AND ar.abnormal_config_id = ad.abnormal_config_id
   AND ad.pause = 0
 INNER JOIN scmdata.t_abnormal_config ab
    ON ab.company_id = ad.company_id
   AND ab.abnormal_config_id = ad.abnormal_config_id
   AND ab.pause = 0
 WHERE tc.company_id = :company_id
   AND tc.goo_id = :goo_id_pr
   AND ad.anomaly_classification = 'AC_DATE']';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_110_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[延期问题分类]'',0,q''[DELAY_PROBLEM_CLASS_PR]'',q''[DELAY_PROBLEM_CLASS_PR]'',q''[]'',q''[]'',0,q''[DELAY_PROBLEM_CLASS_PR,DELAY_CAUSE_CLASS_PR,DELAY_CAUSE_DETAILED_PR]'',q''[]'',q''[DELAY_PROBLEM_CLASS_PR]'',0,q''[]'',q''[DELAY_PROBLEM_CLASS_PR,DELAY_CAUSE_CLASS_PR,DELAY_CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_110_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[延期问题分类]'',0,''pick_a_product_110_1'',q''[DELAY_PROBLEM_CLASS_PR]'',q''[DELAY_PROBLEM_CLASS_PR]'',q''[]'',q''[]'',0,q''[DELAY_PROBLEM_CLASS_PR,DELAY_CAUSE_CLASS_PR,DELAY_CAUSE_DETAILED_PR]'',q''[]'',q''[DELAY_PROBLEM_CLASS_PR]'',0,q''[]'',q''[DELAY_PROBLEM_CLASS_PR,DELAY_CAUSE_CLASS_PR,DELAY_CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT ad.cause_classification delay_cause_class_pr,
       '' delay_cause_detailed_pr
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_abnormal_range_config ar
    ON tc.company_id = ar.company_id
   AND tc.category = ar.industry_classification
   AND tc.product_cate = ar.production_category
   AND instr(';' || ar.product_subclass || ';',
             ';' || tc.samll_category || ';') > 0
   AND ar.pause = 0
 INNER JOIN scmdata.t_abnormal_dtl_config ad
    ON ar.company_id = ad.company_id
   AND ar.abnormal_config_id = ad.abnormal_config_id
   AND ad.pause = 0
 INNER JOIN scmdata.t_abnormal_config ab
    ON ab.company_id = ad.company_id
   AND ab.abnormal_config_id = ad.abnormal_config_id
   AND ab.pause = 0
 WHERE tc.company_id = :company_id
   AND tc.goo_id = :goo_id_pr
   AND ad.anomaly_classification = 'AC_DATE'
   AND ad.problem_classification = :delay_problem_class_pr]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_110_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[延期原因分类]'',0,q''[DELAY_CAUSE_CLASS_PR]'',q''[DELAY_CAUSE_CLASS_PR]'',q''[]'',q''[]'',0,q''[DELAY_CAUSE_DETAILED_PR]'',q''[]'',q''[DELAY_CAUSE_CLASS_PR]'',0,q''[]'',q''[DELAY_CAUSE_CLASS_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_110_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[延期原因分类]'',0,''pick_a_product_110_2'',q''[DELAY_CAUSE_CLASS_PR]'',q''[DELAY_CAUSE_CLASS_PR]'',q''[]'',q''[]'',0,q''[DELAY_CAUSE_DETAILED_PR]'',q''[]'',q''[DELAY_CAUSE_CLASS_PR]'',0,q''[]'',q''[DELAY_CAUSE_CLASS_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[SELECT ad.cause_detail delay_cause_detailed_pr
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_abnormal_range_config ar
    ON tc.company_id = ar.company_id
   AND tc.category = ar.industry_classification
   AND tc.product_cate = ar.production_category
   AND instr(';' || ar.product_subclass || ';',
             ';' || tc.samll_category || ';') > 0
   AND ar.pause = 0
 INNER JOIN scmdata.t_abnormal_dtl_config ad
    ON ar.company_id = ad.company_id
   AND ar.abnormal_config_id = ad.abnormal_config_id
   AND ad.pause = 0
 INNER JOIN scmdata.t_abnormal_config ab
    ON ab.company_id = ad.company_id
   AND ab.abnormal_config_id = ad.abnormal_config_id
   AND ab.pause = 0
 WHERE tc.company_id = :company_id
   AND tc.goo_id = :goo_id_pr
   AND ad.anomaly_classification = 'AC_DATE'
   AND ad.problem_classification = :delay_problem_class_pr
   AND ad.cause_classification = :delay_cause_detailed_pr]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_110_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[延期原因细分]'',0,q''[DELAY_CAUSE_DETAILED_PR]'',q''[DELAY_CAUSE_DETAILED_PR]'',q''[]'',q''[]'',0,q''[]'',q''[]'',q''[DELAY_CAUSE_DETAILED_PR]'',0,q''[]'',q''[DELAY_CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_110_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[延期原因细分]'',0,''pick_a_product_110_3'',q''[DELAY_CAUSE_DETAILED_PR]'',q''[DELAY_CAUSE_DETAILED_PR]'',q''[]'',q''[]'',0,q''[]'',q''[]'',q''[DELAY_CAUSE_DETAILED_PR]'',0,q''[]'',q''[DELAY_CAUSE_DETAILED_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[select a.company_dept_id,a.dept_name responsible_dept_sec_pr,a.parent_id
  from sys_company_dept a
 where a.company_id=%default_company_id%]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[责任部门(2级)]'',0,q''[RESPONSIBLE_DEPT_SEC_PR]'',q''[RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[]'',0,q''[COMPANY_DEPT_ID]'',q''[]'',q''[RESPONSIBLE_DEPT_SEC_PR]'',1,q''[]'',q''[COMPANY_DEPT_ID,PARENT_ID,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[责任部门(2级)]'',0,''pick_a_product_118_5'',q''[RESPONSIBLE_DEPT_SEC_PR]'',q''[RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[]'',0,q''[COMPANY_DEPT_ID]'',q''[]'',q''[RESPONSIBLE_DEPT_SEC_PR]'',1,q''[]'',q''[COMPANY_DEPT_ID,PARENT_ID,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
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
  CV2 CLOB:=q'[select a.company_dept_id,a.dept_name responsible_dept_sec_pr,a.parent_id
  from sys_company_dept a
 where a.company_id=%default_company_id%]';
  CV3 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_PICK_LIST WHERE ELEMENT_ID = ''pick_a_product_118_5''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_PICK_LIST SET (CAPTION,CUSTOM_QUERY,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) = (SELECT q''[责任部门(2级)]'',0,q''[RESPONSIBLE_DEPT_SEC_PR]'',q''[RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[]'',0,q''[COMPANY_DEPT_ID]'',q''[]'',q''[RESPONSIBLE_DEPT_SEC_PR]'',1,q''[]'',q''[COMPANY_DEPT_ID,PARENT_ID,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL) WHERE ELEMENT_ID = ''pick_a_product_118_5''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_PICK_LIST (CAPTION,CUSTOM_QUERY,ELEMENT_ID,FIELD_NAME,FROM_FIELD,IMAGE_NAMES,LEVEL_FIELD,MULTI_VALUE_FLAG,OTHER_FIELDS,PORT_ID,QUERY_FIELDS,RECURSION_FLAG,SEPERATOR,TREE_FIELDS,TREE_ID,NAME_LIST_SQL,PICK_SQL,PORT_SQL) SELECT q''[责任部门(2级)]'',0,''pick_a_product_118_5'',q''[RESPONSIBLE_DEPT_SEC_PR]'',q''[RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',q''[]'',0,q''[COMPANY_DEPT_ID]'',q''[]'',q''[RESPONSIBLE_DEPT_SEC_PR]'',1,q''[]'',q''[COMPANY_DEPT_ID,PARENT_ID,RESPONSIBLE_DEPT_SEC_PR]'',q''[]'',:CV1,:CV2,:CV3 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2,CV3;
     END IF;
  END;
END;
/

