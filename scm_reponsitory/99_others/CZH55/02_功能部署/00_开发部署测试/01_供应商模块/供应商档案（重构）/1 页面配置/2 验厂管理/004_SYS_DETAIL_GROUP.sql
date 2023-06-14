﻿BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'[check_dept_name,checkapply_person,checkapply_phone,is_urgent,factory_ask_date,cooperation_type_desc,cooperation_classification_des,cooperation_model_desc,product_type,checkapply_intro]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''申请信息'' AND ITEM_ID = ''a_check_101_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''申请信息'' AND ITEM_ID = ''a_check_101_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''申请信息'',''a_check_101_1'',0,1,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[WORKER_NUM,MACHINE_NUM,RESERVE_CAPACITY,PRODUCT_EFFICIENCY,WORK_HOURS_DAY]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''生产信息'' AND ITEM_ID = ''a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,3,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''生产信息'' AND ITEM_ID = ''a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''生产信息'',''a_coop_150_3'',0,3,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[ask_company_name,company_abbreviation,social_credit_code,pcc,company_address,legal_representative,company_contact_phone,ask_user_name,ask_user_phone,COMPANY_TYPE_DESC,cooperation_brand_desc,cooperation_type_desc,cooperation_model,product_link_desc,ask_say,remarks]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_coop_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_coop_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''供应商基本信息'',''a_coop_151'',0,1,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[certificate_file,supplier_gate,supplier_office,supplier_site,supplier_product]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''附件资料'' AND ITEM_ID = ''a_coop_151''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,2,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''附件资料'' AND ITEM_ID = ''a_coop_151''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''附件资料'',''a_coop_151'',0,2,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[certificate_file,supplier_gate,supplier_office,supplier_site,supplier_product]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''附件资料'' AND ITEM_ID = ''a_coop_150_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,2,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''附件资料'' AND ITEM_ID = ''a_coop_150_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''附件资料'',''a_coop_150_6'',0,2,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[ask_company_name,company_abbreviation,social_credit_code,pcc,company_address,legal_representative,company_contact_phone,ask_user_name,ask_user_phone,COMPANY_TYPE_DESC,cooperation_brand_desc,cooperation_type_desc,cooperation_model,product_link_desc,ask_say,remarks]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_coop_150_6''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_coop_150_6''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''供应商基本信息'',''a_coop_150_6'',0,1,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[ask_company_name,company_abbreviation,social_credit_code,pcc,company_address,FACTORY_NAME,FPCC,ASK_ADDRESS,legal_representative,company_contact_phone,contact_name,contact_phone,company_type,cooperation_brand,cooperation_brand_desc,product_link,product_link_desc,rela_supplier_id,rela_supplier_id_desc,remarks]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,2,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''供应商基本信息'',''a_check_102_1'',0,2,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[product_line,product_line_num,worker_num,machine_num,quality_step,pattern_cap,fabric_purchase_cap,fabric_check_cap,cost_step,reserve_capacity,product_efficiency,work_hours_day]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''生产信息'' AND ITEM_ID = ''a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,3,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''生产信息'' AND ITEM_ID = ''a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''生产信息'',''a_check_102_1'',0,3,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[LOGO,COMPANY_NAME,LOGN_NAME,TIPS,LICENCE_TYPE,LICENCE_NUM]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''基础资料'' AND ITEM_ID = ''a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 1,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''基础资料'' AND ITEM_ID = ''a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 1,''基础资料'',''a_coop_150_0'',0,1,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[check_dept_name,checkapply_person,checkapply_phone,is_urgent,factory_ask_date,cooperation_type_desc,cooperation_classification_des,cooperation_model_desc,product_type,checkapply_intro]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''申请信息'' AND ITEM_ID = ''a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''申请信息'' AND ITEM_ID = ''a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''申请信息'',''a_check_102_1'',0,1,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[check_person1,check_person1_desc,check_person1_phone,check_date,check_person2,check_person2_desc,check_person2_phone,CHECK_FAC_RESULT,check_say]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''验厂结果'' AND ITEM_ID = ''a_check_102_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,4,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''验厂结果'' AND ITEM_ID = ''a_check_102_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''验厂结果'',''a_check_102_1'',0,4,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[AREA,ATTRIBUTOR,ADDRESS,PRODUCT,RIVAL]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''其他资料'' AND ITEM_ID = ''a_coop_150_0''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 2,0,2,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''其他资料'' AND ITEM_ID = ''a_coop_150_0''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 2,''其他资料'',''a_coop_150_0'',0,2,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[COMPANY_NAME,CHECK_COMPANY_NAME,CHECK_USER_NAME,FR.CHECK_DATE,CHECK_METHOD,CHECK_ADDRESS,COOPERATION_METHOD,COOPERATION_MODEL,PRODUCTION_MODE,COOPERATION_TYPE,COOPERATION_CLASSIFICATION,COOPERATION_SUBCATEGORY]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''验厂基本信息'' AND ITEM_ID = ''a_check_102''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 2,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''验厂基本信息'' AND ITEM_ID = ''a_check_102''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 2,''验厂基本信息'',''a_check_102'',0,1,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[CHECK_REPORT_FILE,CHECK_SAY,CHECK_RESULT]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''验厂结论'' AND ITEM_ID = ''a_check_102''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 1,0,2,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''验厂结论'' AND ITEM_ID = ''a_check_102''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 1,''验厂结论'',''a_check_102'',0,2,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[FRA_COOPERATION_CLASSIFICATION,FRA_COOPERATION_SUBCATEGORY,ORIGINAL_DESIGN,DEVELOPMENT_PROOFING,MATERIALS_PROCUREMENT,PRODUCTION_PROCESSING]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''能力评估'' AND ITEM_ID = ''a_check_102''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 6,0,3,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''能力评估'' AND ITEM_ID = ''a_check_102''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 6,''能力评估'',''a_check_102'',0,3,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[ask_company_name,company_abbreviation,social_credit_code,pcc,company_address,legal_representative,company_contact_phone,ask_user_name,ask_user_phone,COMPANY_TYPE_DESC,cooperation_brand_desc,cooperation_type_desc,cooperation_model,product_link_desc,ask_say]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_coop_121''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_coop_121''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''供应商基本信息'',''a_coop_121'',0,1,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[certificate_file,supplier_gate,supplier_office,supplier_site,supplier_product]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''附件资料'' AND ITEM_ID = ''a_coop_121''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,2,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''附件资料'' AND ITEM_ID = ''a_coop_121''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''附件资料'',''a_coop_121'',0,2,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[check_dept_name,checkapply_person,checkapply_phone,is_urgent,factory_ask_date,cooperation_type_desc,cooperation_classification_des,cooperation_model_desc,product_type,checkapply_intro]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''申请信息'' AND ITEM_ID = ''a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,1,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''申请信息'' AND ITEM_ID = ''a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''申请信息'',''a_coop_150_3'',0,1,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[ask_company_name,company_abbreviation,social_credit_code,pcc,company_address,factory_name,fpcc,ask_address,legal_representative,company_contact_phone,ask_user_name,ask_user_phone,company_type,cooperation_brand,cooperation_brand_desc,product_link,product_link_desc,rela_supplier_id,rela_supplier_id_desc,remarks]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,2,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''供应商基本信息'',''a_coop_150_3'',0,2,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[certificate_file,supplier_gate,supplier_office,supplier_site,supplier_product]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''供应商附件资料'' AND ITEM_ID = ''a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,4,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''供应商附件资料'' AND ITEM_ID = ''a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''供应商附件资料'',''a_coop_150_3'',0,4,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[check_person1,check_person1_desc,check_person1_phone,check_date,check_person2,check_person2_desc,check_person2_phone,CHECK_FAC_RESULT,check_say]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''验厂结果'' AND ITEM_ID = ''a_check_101_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,4,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''验厂结果'' AND ITEM_ID = ''a_check_101_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''验厂结果'',''a_check_101_1'',0,4,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[product_line,product_line_num,worker_num,machine_num,quality_step,pattern_cap,fabric_purchase_cap,fabric_check_cap,cost_step,reserve_capacity,product_efficiency,work_hours_day]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''生产信息'' AND ITEM_ID = ''a_check_101_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,3,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''生产信息'' AND ITEM_ID = ''a_check_101_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''生产信息'',''a_check_101_1'',0,3,:CV1 FROM DUAL';
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
  CV1 CLOB:=q'[ask_company_name,company_abbreviation,social_credit_code,pcc,company_address,factory_name,fpcc,ask_address,legal_representative,company_contact_phone,contact_name,contact_phone,company_type,cooperation_brand,cooperation_brand_desc,product_link,product_link_desc,rela_supplier_id,rela_supplier_id_desc,remarks]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_DETAIL_GROUP WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_check_101_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_DETAIL_GROUP SET (COLUMN_NUMBER,PAUSE,SEQ_NO,CLO_NAMES) = (SELECT 3,0,2,:CV1 FROM DUAL) WHERE  GROUP_NAME = ''供应商基本信息'' AND ITEM_ID = ''a_check_101_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_DETAIL_GROUP (COLUMN_NUMBER,GROUP_NAME,ITEM_ID,PAUSE,SEQ_NO,CLO_NAMES) SELECT 3,''供应商基本信息'',''a_check_101_1'',0,2,:CV1 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1;
     END IF;
  END;
END;
/

