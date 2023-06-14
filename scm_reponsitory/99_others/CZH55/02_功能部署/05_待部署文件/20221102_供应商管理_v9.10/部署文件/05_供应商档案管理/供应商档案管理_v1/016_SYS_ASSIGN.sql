BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:=q'^{
DECLARE
  v_third_dept_id   VARCHAR2(32);
  v_third_dept_name VARCHAR2(32);
  v_sql             CLOB;
BEGIN
  v_third_dept_id := scmdata.pkg_ask_record_mange.f_get_check_third_dept_id(p_company_id => %default_company_id%,
                                                                            p_user_id    => :fa_check_person_y);
  SELECT MAX(t.dept_name) third_dept_name
    INTO v_third_dept_name
    FROM scmdata.sys_company_dept t
   WHERE t.company_dept_id = v_third_dept_id;

  v_sql      := q'[SELECT ']' || v_third_dept_id || q'[' fa_check_dept_name_y,
         ']' || v_third_dept_name || q'[' fa_dept_name_desc_y
    FROM dual]';
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_coop_153_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 1,q''[FA_CHECK_PERSON_Y]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_coop_153_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 1,''assign_a_coop_153_1'',q''[FA_CHECK_PERSON_Y]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  v_sql                    VARCHAR2(512);
  v_ar_company_name_y      VARCHAR2(256) := :ar_company_name_y;
  v_company_province       VARCHAR2(256) := :company_province;
  v_company_city           VARCHAR2(256) := :company_city;
  v_company_county         VARCHAR2(256) := :company_county;
  v_ar_company_area_y      VARCHAR2(256) := :ar_company_area_y;
  v_ar_company_vill_y      VARCHAR2(256) := :ar_company_vill_y;
  v_ar_company_vill_desc_y VARCHAR2(256) := :ar_company_vill_desc_y;
  v_ar_company_address_y   VARCHAR2(256) := :ar_company_address_y;
BEGIN
  IF nvl(:ar_is_our_factory_y, 0) = 1 THEN
    v_sql := q'[
   SELECT ']' || v_ar_company_name_y || q'[' ar_factory_name_y,
          ']' || v_company_province || q'['  factory_province,
          ']' || v_company_city || q'[' factory_city,
          ']' || v_company_county || q'[' factory_county,
          ']' || v_ar_company_area_y || q'[' ar_factory_area_y,
          ']' || v_ar_company_vill_y || q'[' ar_factory_vill_y,
          ']' || v_ar_company_vill_desc_y || q'[' ar_factory_vill_desc_y,
          ']' || v_ar_company_address_y || q'[' ar_factroy_details_address_y
      FROM dual]';
  ELSE
    v_sql := 'select 1 from dual';
  END IF;
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_coop_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 1,q''[AR_IS_OUR_FACTORY_Y]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_coop_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 1,''assign_a_coop_151_1'',q''[AR_IS_OUR_FACTORY_Y]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  v_sql                    VARCHAR2(512);
BEGIN
  IF :ASK_RECORD_ID IS NOT NULL THEN
    v_sql := q'[
   SELECT 0 ar_worker_total_num_y,
          0 ar_worker_num_y,
          0 ar_form_num_y,
          '00' ar_pattern_cap_y,
          '00' ar_fabric_purchase_cap_y
      FROM dual]';
  ELSE
    v_sql := 'select 1 from dual';
  END IF;
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_coop_151_2''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 1,q''[ASK_RECORD_ID]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_coop_151_2''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 1,''assign_a_coop_151_2'',q''[ASK_RECORD_ID]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  FACTORY_NAME           VARCHAR2(48);
  FACTORY_ABBREVIATION   VARCHAR2(48);
  FA_SOCIAL_CREDIT_CODE  VARCHAR2(48);
  FACTORY_PROVINCE       VARCHAR2(48);
  FACTORY_CITY           VARCHAR2(48);
  FACTORY_COUNTY         VARCHAR2(48);
  FACTORY_DETAIL_ADRESS  VARCHAR2(48);
  FACTORY_REPRESENTATIVE VARCHAR2(48);
  FACTORY_CONTACT_PHONE  VARCHAR2(48);
  FA_CONTACT_NAME        VARCHAR2(48);
  FA_CONTACT_PHONE       VARCHAR2(48);
  FA_BRAND_TYPE          VARCHAR2(48);
  FACTORY_COOP_BRAND     VARCHAR2(48);
  FA_CERTIFICATE_FILE    VARCHAR2(48);
  FACTORY_GATE           VARCHAR2(48);
  FACTORY_OFFICE         VARCHAR2(48);
  FACTORY_SITE           VARCHAR2(48);
  FACTORY_PRODUCT        VARCHAR2(48);
  FACTORY_TYPE           VARCHAR2(48);
  FPCC                   VARCHAR2(48);
  FACTORY_COOP_BRAND_DESC      VARCHAR2(48);
  FACTORY_COOP_MODEL     VARCHAR2(48);
  FA_RELA_SUPPLIER_ID    VARCHAR2(48);
BEGIN

  FACTORY_NAME := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :ASK_COMPANY_NAME
                    ELSE
                     ''
                  END;
  FACTORY_ABBREVIATION := CASE
                            WHEN :COM_MANUFACTURER = '00' THEN
                             :COMPANY_ABBREVIATION
                            ELSE
                             ''
                          END;
  FA_SOCIAL_CREDIT_CODE := CASE
                             WHEN :COM_MANUFACTURER = '00' THEN
                              :SOCIAL_CREDIT_CODE
                             ELSE
                              ''
                           END;
  FACTORY_PROVINCE := CASE
                        WHEN :COM_MANUFACTURER = '00' THEN
                         :COMPANY_PROVINCE
                        ELSE
                         ''
                      END;
  FACTORY_CITY := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :COMPANY_CITY
                    ELSE
                     ''
                  END;
  FACTORY_COUNTY := CASE
                      WHEN :COM_MANUFACTURER = '00' THEN
                       :COMPANY_COUNTY
                      ELSE
                       ''
                    END;

  FPCC := CASE
            WHEN :COM_MANUFACTURER = '00' THEN
             :PCC
            ELSE
             ''
          END;

  FACTORY_DETAIL_ADRESS := CASE
                             WHEN :COM_MANUFACTURER = '00' THEN
                              :COMPANY_ADDRESS
                             ELSE
                             ''
                           END;
  FACTORY_REPRESENTATIVE := CASE
                              WHEN :COM_MANUFACTURER = '00' THEN
                               :LEGAL_REPRESENTATIVE
                              ELSE
                               ''
                            END;
  FACTORY_CONTACT_PHONE := CASE
                             WHEN :COM_MANUFACTURER = '00' THEN
                              :COMPANY_CONTACT_PHONE
                             ELSE
                              ''
                           END;
  FA_CONTACT_NAME := CASE
                       WHEN :COM_MANUFACTURER = '00' THEN
                        :CONTACT_NAME
                       ELSE
                        ''
                     END;
  FA_CONTACT_PHONE := CASE
                        WHEN :COM_MANUFACTURER = '00' THEN
                         :CONTACT_PHONE
                        ELSE
                         ''
                      END;
  FACTORY_TYPE := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :COMPANY_TYPE
                    ELSE
                    ''
                  END;

  FA_BRAND_TYPE := CASE
                     WHEN :COM_MANUFACTURER = '00' THEN
                      :BRAND_TYPE
                     ELSE
                     ''
                   END;
  FACTORY_COOP_BRAND := CASE
                          WHEN :COM_MANUFACTURER = '00' THEN
                           :COOPERATION_BRAND
                          ELSE
                           ''
                        END;

  FACTORY_COOP_BRAND_DESC := CASE
                               WHEN :COM_MANUFACTURER = '00' THEN
                                :COOPERATION_BRAND_DESC
                               ELSE
                                ''
                             END;

  FA_CERTIFICATE_FILE := CASE
                           WHEN :COM_MANUFACTURER = '00' THEN
                            :CERTIFICATE_FILE
                           ELSE
                            ''
                         END;

  FACTORY_GATE := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :SUPPLIER_GATE
                    ELSE
                     ''
                  END;
  FACTORY_OFFICE := CASE
                      WHEN :COM_MANUFACTURER = '00' THEN
                       :SUPPLIER_OFFICE
                      ELSE
                      ''
                    END;
  FACTORY_SITE := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :SUPPLIER_SITE
                    ELSE
                    ''
                  END;

  FACTORY_PRODUCT := CASE
                       WHEN :COM_MANUFACTURER = '00' THEN
                        :SUPPLIER_PRODUCT
                       ELSE
                       ''
                     END;
  FACTORY_COOP_MODEL := CASE
                       WHEN :COM_MANUFACTURER = '00' THEN
                        ''
                       ELSE
                       'OF'
                     END;

  FA_RELA_SUPPLIER_ID := CASE
                       WHEN :COM_MANUFACTURER = '00' THEN
                        ''
                       ELSE
                       :SOCIAL_CREDIT_CODE
                     END;

  @STRRESULT := 'SELECT ''' || FACTORY_NAME || ''' FACTORY_NAME,
       ''' || FACTORY_ABBREVIATION || ''' FACTORY_ABBREVIATION,
       ''' || FA_SOCIAL_CREDIT_CODE || ''' FA_SOCIAL_CREDIT_CODE,
       ''' || FACTORY_PROVINCE || ''' FACTORY_PROVINCE,
       ''' || FACTORY_CITY || ''' FACTORY_CITY,
       ''' || FACTORY_COUNTY || ''' FACTORY_COUNTY,
       ''' || FPCC || ''' FPCC,
       ''' || FACTORY_DETAIL_ADRESS || ''' FACTORY_DETAIL_ADRESS,
       ''' || FACTORY_REPRESENTATIVE || ''' FACTORY_REPRESENTATIVE,
       ''' || FACTORY_CONTACT_PHONE || ''' FA_COM_CONTACT_PHONE,
       ''' || FA_CONTACT_NAME || ''' FA_CONTACT_NAME,
       ''' || FA_CONTACT_PHONE || ''' FA_CONTACT_PHONE,
       ''' || FACTORY_TYPE || ''' FACTORY_TYPE,
       ''' || FA_BRAND_TYPE || ''' FA_BRAND_TYPE,
       ''' || FACTORY_COOP_BRAND || ''' FACTORY_COOP_BRAND,
       ''' || FACTORY_COOP_BRAND_DESC || ''' FACTORY_COOP_BRAND_DESC,
       ''' || FA_CERTIFICATE_FILE || ''' FA_CERTIFICATE_FILE,
       ''' || FACTORY_GATE || ''' FACTORY_GATE,
       ''' || FACTORY_OFFICE || ''' FACTORY_OFFICE,
       ''' || FACTORY_SITE || ''' FACTORY_SITE,
       ''' || FACTORY_PRODUCT || ''' FACTORY_PRODUCT,
       ''' || FACTORY_COOP_MODEL || ''' FACTORY_COOP_MODEL,
       ''' || FA_RELA_SUPPLIER_ID || ''' FA_RELA_SUPPLIER_ID
  FROM DUAL';
END;
}


/*{DECLARE
  FACTORY_NAME           VARCHAR2(48);
  FACTORY_ABBREVIATION   VARCHAR2(48);
  FA_SOCIAL_CREDIT_CODE  VARCHAR2(48);
  FACTORY_PROVINCE       VARCHAR2(48);
  FACTORY_CITY           VARCHAR2(48);
  FACTORY_COUNTY         VARCHAR2(48);
  FACTORY_DETAIL_ADRESS  VARCHAR2(48);
  FACTORY_REPRESENTATIVE VARCHAR2(48);
  FACTORY_CONTACT_PHONE  VARCHAR2(48);
  FA_CONTACT_NAME        VARCHAR2(48);
  FA_CONTACT_PHONE       VARCHAR2(48);
  FA_BRAND_TYPE          VARCHAR2(48);
  FACTORY_COOP_BRAND     VARCHAR2(48);
  FA_CERTIFICATE_FILE    VARCHAR2(48);
  FACTORY_GATE           VARCHAR2(48);
  FACTORY_OFFICE         VARCHAR2(48);
  FACTORY_SITE           VARCHAR2(48);
  FACTORY_PRODUCT        VARCHAR2(48);
  FACTORY_TYPE           VARCHAR2(48);

BEGIN

  FACTORY_NAME := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :COMPANY_ABBREVIATION
                    ELSE
                     :FACTORY_NAME
                  END;
  FACTORY_ABBREVIATION := CASE
                            WHEN :COM_MANUFACTURER = '00' THEN
                             :ASK_COMPANY_NAME
                            ELSE
                             NVL(:FACTORY_ABBREVIATION, '')
                          END;
  FA_SOCIAL_CREDIT_CODE := CASE
                             WHEN :COM_MANUFACTURER = '00' THEN
                              :SOCIAL_CREDIT_CODE
                             ELSE
                              NVL(:FA_SOCIAL_CREDIT_CODE, '')
                           END;
  FACTORY_PROVINCE := CASE
                        WHEN :COM_MANUFACTURER = '00' THEN
                         :COMPANY_PROVINCE
                        ELSE
                         NVL(:FACTORY_PROVINCE, '')
                      END;
  FACTORY_CITY := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :COMPANY_CITY
                    ELSE
                     NVL(:FACTORY_CITY, '')
                  END;
  FACTORY_COUNTY := CASE
                      WHEN :COM_MANUFACTURER = '00' THEN
                       :COMPANY_COUNTY
                      ELSE
                       NVL(:FACTORY_COUNTY, '')
                    END;
  FACTORY_DETAIL_ADRESS := CASE
                             WHEN :COM_MANUFACTURER = '00' THEN
                              :COMPANY_ADDRESS
                             ELSE
                              NVL(:FACTORY_DETAIL_ADRESS, '')
                           END;
  FACTORY_REPRESENTATIVE := CASE
                              WHEN :COM_MANUFACTURER = '00' THEN
                               :LEGAL_REPRESENTATIVE
                              ELSE
                               NVL(:FACTORY_REPRESENTATIVE, '')
                            END;
  FACTORY_CONTACT_PHONE := CASE
                             WHEN :COM_MANUFACTURER = '00' THEN
                              :COMPANY_CONTACT_PHONE
                             ELSE
                              NVL(:FACTORY_CONTACT_PHONE, '')
                           END;
  FA_CONTACT_NAME := CASE
                       WHEN :COM_MANUFACTURER = '00' THEN
                        :CONTACT_NAME
                       ELSE
                        NVL(:FA_CONTACT_NAME, '')
                     END;
  FA_CONTACT_PHONE := CASE
                        WHEN :COM_MANUFACTURER = '00' THEN
                         :CONTACT_PHONE
                        ELSE
                         NVL(:FA_COM_CONTACT_PHONE, '')
                      END;
  FACTORY_TYPE := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :COMPANY_TYPE
                    ELSE
                     NVL(:FACTORY_TYPE, '')
                  END;

  FA_BRAND_TYPE := CASE
                     WHEN :COM_MANUFACTURER = '00' THEN
                      :BRAND_TYPE
                     ELSE
                      NVL(:FA_BRAND_TYPE, '')
                   END;
  FACTORY_COOP_BRAND := CASE
                          WHEN :COM_MANUFACTURER = '00' THEN
                           :COOPERATION_BRAND
                          ELSE
                           NVL(:FACTORY_COOP_BRAND, '')
                        END;

  FA_CERTIFICATE_FILE := CASE
                           WHEN :COM_MANUFACTURER = '00' THEN
                            :CERTIFICATE_FILE
                           ELSE
                            NVL(:FA_CERTIFICATE_FILE, '')
                         END;

  FACTORY_GATE := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :SUPPLIER_GATE
                    ELSE
                     NVL(:FACTORY_GATE, '')
                  END;
  FACTORY_OFFICE := CASE
                      WHEN :COM_MANUFACTURER = '00' THEN
                       :SUPPLIER_OFFICE
                      ELSE
                       NVL(:FACTORY_OFFICE, '')
                    END;
  FACTORY_SITE := CASE
                    WHEN :COM_MANUFACTURER = '00' THEN
                     :SUPPLIER_SITE
                    ELSE
                     NVL(:FACTORY_SITE, '')
                  END;

  FACTORY_PRODUCT := CASE
                       WHEN :COM_MANUFACTURER = '00' THEN
                        :SUPPLIER_PRODUCT
                       ELSE
                        NVL(:FACTORY_PRODUCT, '')
                     END;

  @STRRESULT := 'SELECT ''' || FACTORY_NAME || ''' FACTORY_NAME,
       ''' || FACTORY_ABBREVIATION || ''' FACTORY_ABBREVIATION,
       ''' || FA_SOCIAL_CREDIT_CODE || ''' FA_SOCIAL_CREDIT_CODE,
       ''' || FACTORY_PROVINCE || ''' FACTORY_PROVINCE,
       ''' || FACTORY_CITY || ''' FACTORY_CITY,
       ''' || FACTORY_COUNTY || ''' FACTORY_COUNTY,
       ''' || FACTORY_DETAIL_ADRESS || ''' FACTORY_DETAIL_ADRESS,
       ''' || FACTORY_REPRESENTATIVE || ''' FACTORY_REPRESENTATIVE,
       ''' || FACTORY_CONTACT_PHONE || ''' FACTORY_CONTACT_PHONE,
       ''' || FA_CONTACT_NAME || ''' FA_CONTACT_NAME,
       ''' || FA_CONTACT_PHONE || ''' FA_CONTACT_PHONE,
       ''' || FACTORY_TYPE || ''' FACTORY_TYPE,
       ''' || FA_BRAND_TYPE || ''' FA_BRAND_TYPE,
       ''' || FACTORY_COOP_BRAND || ''' FACTORY_COOP_BRAND,
       ''' || FA_CERTIFICATE_FILE || ''' FA_CERTIFICATE_FILE,
       ''' || FACTORY_GATE || ''' FACTORY_GATE,
       ''' || FACTORY_OFFICE || ''' FACTORY_OFFICE,
       ''' || FACTORY_SITE || ''' FACTORY_SITE,
       ''' || FACTORY_PRODUCT || ''' FACTORY_PRODUCT
  FROM DUAL';
END;
}*/^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_coop_150_3''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 1,q''[COM_MANUFACTURER]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_coop_150_3''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 1,''assign_a_coop_150_3'',q''[COM_MANUFACTURER]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  GROUP_NAME         VARCHAR2(32);
  V_COMPANY_PROVINCE VARCHAR2(148);
  V_COMPANY_CITY     VARCHAR2(148);
BEGIN
  V_COMPANY_PROVINCE := :COMPANY_PROVINCE;
  V_COMPANY_CITY := :COMPANY_CITY;
    SELECT MAX(NVL(DD.GROUP_NAME, '')) INTO GROUP_NAME
      FROM (SELECT AA.GROUP_NAME, BB.PROVINCE_ID || BB.CITY_ID AS QUYU
              FROM T_SUPPLIER_GROUP_CONFIG AA
              LEFT JOIN T_SUPPLIER_GROUP_AREA_CONFIG BB
                ON AA.GROUP_CONFIG_ID = BB.GROUP_CONFIG_ID) DD
     WHERE (V_COMPANY_PROVINCE || V_COMPANY_CITY) = DD.QUYU;
  @STRRESULT := 'SELECT ''' || GROUP_NAME || ''' GROUP_NAME FROM DUAL';
END;}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_supp_171''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 0,q''[LOCATION_AREA]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_supp_171''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 0,''assign_a_supp_171'',q''[LOCATION_AREA]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  v_sql                    VARCHAR2(512);
  v_ar_company_name_y      VARCHAR2(256) := :ar_company_name_y;
  v_company_province       VARCHAR2(256) := :company_province;
  v_company_city           VARCHAR2(256) := :company_city;
  v_company_county         VARCHAR2(256) := :company_county;
  v_ar_company_area_y      VARCHAR2(256) := :ar_company_area_y;
  v_ar_company_vill_y      VARCHAR2(256) := :ar_company_vill_y;
  v_ar_company_vill_desc_y VARCHAR2(256) := :ar_company_vill_desc_y;
  v_ar_company_address_y   VARCHAR2(256) := :ar_company_address_y;
BEGIN
  IF nvl(:ar_is_our_factory_y, 0) = 1 THEN
    v_sql := q'[
   SELECT ']' || v_ar_company_name_y || q'[' ar_factory_name_y,
          ']' || v_company_province || q'['  factory_province,
          ']' || v_company_city || q'[' factory_city,
          ']' || v_company_county || q'[' factory_county,
          ']' || v_ar_company_area_y || q'[' ar_factory_area_y,
          ']' || v_ar_company_vill_y || q'[' ar_factory_vill_y,
          ']' || v_ar_company_vill_desc_y || q'[' ar_factory_vill_desc_y,
          ']' || v_ar_company_address_y || q'[' ar_factroy_details_address_y
      FROM dual]';
  ELSE
    v_sql := 'select 1 from dual';
  END IF;
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_coop_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 1,q''[AR_IS_OUR_FACTORY_Y]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_coop_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 1,''assign_a_coop_151_1'',q''[AR_IS_OUR_FACTORY_Y]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
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
  v_sql                    VARCHAR2(512);
  v_ar_company_name_y      VARCHAR2(256) := :ar_company_name_y;
  v_company_province       VARCHAR2(256) := :company_province;
  v_company_city           VARCHAR2(256) := :company_city;
  v_company_county         VARCHAR2(256) := :company_county;
  v_ar_company_area_y      VARCHAR2(256) := :ar_company_area_y;
  v_ar_company_vill_y      VARCHAR2(256) := :ar_company_vill_y;
  v_ar_company_vill_desc_y VARCHAR2(256) := :ar_company_vill_desc_y;
  v_ar_company_address_y   VARCHAR2(256) := :ar_company_address_y;
BEGIN
  IF nvl(:ar_is_our_factory_y, 0) = 1 THEN
    v_sql := q'[
   SELECT ']' || v_ar_company_name_y || q'[' ar_factory_name_y,
          ']' || v_company_province || q'['  factory_province,
          ']' || v_company_city || q'[' factory_city,
          ']' || v_company_county || q'[' factory_county,
          ']' || v_ar_company_area_y || q'[' ar_factory_area_y,
          ']' || v_ar_company_vill_y || q'[' ar_factory_vill_y,
          ']' || v_ar_company_vill_desc_y || q'[' ar_factory_vill_desc_y,
          ']' || v_ar_company_address_y || q'[' ar_factroy_details_address_y
      FROM dual]';
  ELSE
    v_sql := 'select 1 from dual';
  END IF;
  @strresult := v_sql;
END;
}^';
  CV2 CLOB:=q'^^';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_coop_151_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 1,q''[AR_IS_OUR_FACTORY_Y]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_coop_151_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 1,''assign_a_coop_151_1'',q''[AR_IS_OUR_FACTORY_Y]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

