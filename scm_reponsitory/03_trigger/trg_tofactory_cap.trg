CREATE OR REPLACE TRIGGER SCMDATA.TRG_TOFACTORY_CAP
  AFTER INSERT ON T_SUPPLIER_SHARED
  FOR EACH ROW
DECLARE
  P_SUPPLIER_INFO T_SUPPLIER_INFO%ROWTYPE;
  AA INT;

BEGIN
  CASE
    WHEN INSERTING THEN
      SELECT BB.*
        INTO P_SUPPLIER_INFO
        FROM SCMDATA.T_SUPPLIER_INFO BB
       WHERE BB.SUPPLIER_INFO_ID = :NEW.SUPPLIER_SHARED_ID;

       INSERT INTO T_SUPPLIER_FACTORY_CAP(FAC_CAPACITY_ID,
                                    SUPPLIER_INFO_ID,
                                    SHARED_SUPPLIER_CODE,
                                    FACTORY_NAME,
                                    FACTORY_TYPE,
                                    PRODUCT_TYPE,
                                    PRODUCT_LINK,
                                    FACTORY_CAPACITY,
                                    PRODUCT_LINE,
                                    PRODUCT_LINE_NUM,
                                    WORKER_NUM,
                                    MACHINE_NUM,
                                    BRAND_TYPE,
                                    WORK_DAYS,
                                    WORK_TIMES,
                                    AVG_EFFECT,
                                    ACCOUNT_CAP,
                                    COOP_STATE)
                   VALUES(scmdata.f_get_uuid(),
                          :NEW.SUPPLIER_INFO_ID,
                          P_SUPPLIER_INFO.SUPPLIER_INFO_ID,
                          P_SUPPLIER_INFO.SUPPLIER_COMPANY_NAME,
                          '',
                          P_SUPPLIER_INFO.PRODUCT_TYPE,
                          P_SUPPLIER_INFO.PRODUCT_LINK,
                          '',
                          P_SUPPLIER_INFO.PRODUCT_LINE,
                          P_SUPPLIER_INFO.PRODUCT_LINE_NUM,
                          P_SUPPLIER_INFO.WORKER_NUM,
                          P_SUPPLIER_INFO.MACHINE_NUM,
                          P_SUPPLIER_INFO.BRAND_TYPE,
                          '',
                          '',
                          '',
                          '',
                          '');
                          END CASE ;
                          Exception when no_data_found then  
                          AA := NULL;  
END ;
/

