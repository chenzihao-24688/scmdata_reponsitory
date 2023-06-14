﻿CREATE OR REPLACE PROCEDURE SCMDATA.P_INSERT_SUPPLIER_INFO(IV_SUPP_INFO SCMDATA.T_SUPPLIER_INFO%ROWTYPE) IS
BEGIN
  INSERT INTO T_SUPPLIER_INFO
    (SUPPLIER_INFO_ID,
     COMPANY_ID,
     SUPPLIER_INFO_ORIGIN_ID,
     SUPPLIER_COMPANY_ID,
     SUPPLIER_COMPANY_NAME,
     SUPPLIER_COMPANY_ABBREVIATION,
     SOCIAL_CREDIT_CODE,
     COMPANY_CONTACT_PERSON,
     COMPANY_CONTACT_PHONE,
     COMPANY_ADDRESS,
     CERTIFICATE_FILE,
     COOPERATION_TYPE,
     COOPERATION_MODEL,
     SHARING_TYPE,
     SUPPLIER_INFO_ORIGIN,
     PAUSE,
     STATUS,
     BIND_STATUS,
     CREATE_ID,
     CREATE_DATE,
     UPDATE_ID,
     UPDATE_DATE,
     COMPANY_PROVINCE,
     COMPANY_CITY,
     COMPANY_COUNTY)
  VALUES
    (IV_SUPP_INFO.SUPPLIER_INFO_ID,
     IV_SUPP_INFO.COMPANY_ID,
     IV_SUPP_INFO.SUPPLIER_INFO_ORIGIN_ID,
     IV_SUPP_INFO.SUPPLIER_COMPANY_ID,
     IV_SUPP_INFO.SUPPLIER_COMPANY_NAME,
     IV_SUPP_INFO.SUPPLIER_COMPANY_ABBREVIATION,
     IV_SUPP_INFO.SOCIAL_CREDIT_CODE,
     IV_SUPP_INFO.COMPANY_CONTACT_PERSON,
     IV_SUPP_INFO.COMPANY_CONTACT_PHONE,
     IV_SUPP_INFO.COMPANY_ADDRESS,
     IV_SUPP_INFO.CERTIFICATE_FILE,
     IV_SUPP_INFO.COOPERATION_TYPE,
     IV_SUPP_INFO.COOPERATION_MODEL,
     IV_SUPP_INFO.SHARING_TYPE,
     IV_SUPP_INFO.SUPPLIER_INFO_ORIGIN,
     IV_SUPP_INFO.PAUSE,
     IV_SUPP_INFO.STATUS,
     IV_SUPP_INFO.BIND_STATUS,
     IV_SUPP_INFO.CREATE_ID,
     IV_SUPP_INFO.CREATE_DATE,
     IV_SUPP_INFO.UPDATE_ID,
     IV_SUPP_INFO.UPDATE_DATE,
     IV_SUPP_INFO.COMPANY_PROVINCE,
     IV_SUPP_INFO.COMPANY_CITY,
     IV_SUPP_INFO.COMPANY_COUNTY);
  COMMIT;
END P_INSERT_SUPPLIER_INFO;
/

