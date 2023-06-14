CREATE OR REPLACE PACKAGE pkg_compname_check IS

  PROCEDURE p_tar_compname_check_for_new(comp_name VARCHAR2,
                                         dcomp_id  VARCHAR2);

  PROCEDURE p_tar_compname_check_for_dcheck(comp_name VARCHAR2,
                                            dcomp_id  VARCHAR2,
                                            origin_id VARCHAR2);

  PROCEDURE p_tfa_compname_check_for_new(comp_name VARCHAR2,
                                         dcomp_id  VARCHAR2,
                                         p_fask_id VARCHAR2 DEFAULT NULL);

  PROCEDURE p_tfa_compname_check_for_dcheck(comp_name VARCHAR2,
                                            dcomp_id  VARCHAR2,
                                            origin_id VARCHAR2);

  PROCEDURE p_tsi_compname_check_for_new(comp_name VARCHAR2,
                                         dcomp_id  VARCHAR2);

  PROCEDURE p_tsi_compname_check_for_dcheck(comp_name VARCHAR2,
                                            dcomp_id  VARCHAR2,
                                            sp_id     VARCHAR2);

  PROCEDURE p_companyname_dcheck(comp_name VARCHAR2,
                                 dcomp_id  VARCHAR2,
                                 origin_id VARCHAR2,
                                 sp_id     VARCHAR2);

  PROCEDURE p_companyname_new(comp_name VARCHAR2, dcomp_id VARCHAR2);

END pkg_compname_check;
/
CREATE OR REPLACE PACKAGE BODY PKG_COMPNAME_CHECK IS

  --新增时：校验公司名称是否与意向合作供应商清单内已提交公司名称重复
  PROCEDURE P_TAR_COMPNAME_CHECK_FOR_NEW(COMP_NAME VARCHAR2, DCOMP_ID VARCHAR2)
  IS
    JUDGE      NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO JUDGE
      FROM SCMDATA.T_ASK_RECORD
     WHERE COMPANY_ID = DCOMP_ID
       AND COMPANY_NAME = COMP_NAME
       AND COOR_ASK_FLOW_STATUS<>'CA00';
    IF JUDGE > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'公司名称与意向合作供应商清单的公司名称重复！');
    END IF;
  END P_TAR_COMPNAME_CHECK_FOR_NEW;

  

	--修改时：校验公司名称是否与意向合作供应商清单内已提交公司名称重复
  PROCEDURE P_TAR_COMPNAME_CHECK_FOR_DCHECK(COMP_NAME VARCHAR2, DCOMP_ID VARCHAR2, ORIGIN_ID VARCHAR2)
  IS
    JUDGE      NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO JUDGE
      FROM SCMDATA.T_ASK_RECORD
     WHERE COMPANY_ID = DCOMP_ID
       AND COMPANY_NAME = COMP_NAME
       AND COOR_ASK_FLOW_STATUS<>'CA00'
       AND ASK_RECORD_ID<>(SELECT ASK_RECORD_ID
                             FROM SCMDATA.T_FACTORY_ASK
                            WHERE FACTORY_ASK_ID=ORIGIN_ID);
    IF JUDGE > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'公司名称与意向合作供应商清单的公司名称重复！');
    END IF;
  END P_TAR_COMPNAME_CHECK_FOR_DCHECK;



  --新增时：校验公司名称是否与准入流程中已提交公司名称重复
  --CZH ADD P_FASK_ID 
  PROCEDURE P_TFA_COMPNAME_CHECK_FOR_NEW(COMP_NAME VARCHAR2, DCOMP_ID VARCHAR2,P_FASK_ID VARCHAR2 DEFAULT NULL)
  IS
    JUDGE      NUMBER(1);
  BEGIN
    SELECT COUNT(1)
       INTO JUDGE
      FROM SCMDATA.T_FACTORY_ASK
     WHERE COMPANY_ID=DCOMP_ID
     AND FACTORY_ASK_ID <> P_FASK_ID
           AND COMPANY_NAME=COMP_NAME
           AND FACTRORY_ASK_FLOW_STATUS NOT IN ('CA01', 'FA01','FA03','FA21');
    IF JUDGE > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'公司名称与准入流程中的公司名称重复！');
    END IF;
  END P_TFA_COMPNAME_CHECK_FOR_NEW;



  --修改时：校验公司名称是否与准入流程中已提交公司名称重复
  PROCEDURE P_TFA_COMPNAME_CHECK_FOR_DCHECK(COMP_NAME VARCHAR2, DCOMP_ID VARCHAR2, ORIGIN_ID VARCHAR2)
  IS
    JUDGE      NUMBER(1);
  BEGIN
    SELECT COUNT(1)
       INTO JUDGE
      FROM SCMDATA.T_FACTORY_ASK
     WHERE COMPANY_ID=DCOMP_ID
           AND COMPANY_NAME=COMP_NAME
           AND FACTRORY_ASK_FLOW_STATUS NOT IN ('CA01', 'FA01')
           AND ASK_RECORD_ID<>(SELECT ASK_RECORD_ID 
                                 FROM SCMDATA.T_FACTORY_ASK 
                                WHERE FACTORY_ASK_ID=ORIGIN_ID);
    IF JUDGE > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'公司名称与准入流程中的公司名称重复！');
    END IF;
  END P_TFA_COMPNAME_CHECK_FOR_DCHECK;

  

	--新增时：校验公司名称是否与待建档、已建档的供应商名称重复
  PROCEDURE P_TSI_COMPNAME_CHECK_FOR_NEW(COMP_NAME VARCHAR2, DCOMP_ID VARCHAR2)
  IS
    JUDGE      NUMBER(1);
  BEGIN
    SELECT COUNT(1)
       INTO JUDGE
      FROM SCMDATA.T_SUPPLIER_INFO
     WHERE COMPANY_ID=DCOMP_ID
           AND SUPPLIER_COMPANY_NAME=COMP_NAME;
    IF JUDGE > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'公司名称与待建档、已建档的供应商名称重复！');
    END IF;
  END P_TSI_COMPNAME_CHECK_FOR_NEW;



  --修改时：校验公司名称是否与待建档、已建档的供应商名称重复
  PROCEDURE P_TSI_COMPNAME_CHECK_FOR_DCHECK(COMP_NAME VARCHAR2, DCOMP_ID VARCHAR2, SP_ID VARCHAR2)
  IS
    JUDGE      NUMBER(1);
  BEGIN
    SELECT COUNT(1)
       INTO JUDGE
      FROM SCMDATA.T_SUPPLIER_INFO
     WHERE COMPANY_ID=DCOMP_ID
       AND SUPPLIER_COMPANY_NAME=COMP_NAME
       AND SUPPLIER_INFO_ID<>SP_ID;
    IF JUDGE > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,'公司名称与待建档、已建档的供应商名称重复！');
    END IF;
  END P_TSI_COMPNAME_CHECK_FOR_DCHECK;


  --用于修改时的3处同时校验
  PROCEDURE P_COMPANYNAME_DCHECK(COMP_NAME VARCHAR2, DCOMP_ID VARCHAR2, ORIGIN_ID VARCHAR2, SP_ID VARCHAR2)
  IS
  BEGIN
    P_TAR_COMPNAME_CHECK_FOR_DCHECK(COMP_NAME, DCOMP_ID, ORIGIN_ID);
    P_TFA_COMPNAME_CHECK_FOR_DCHECK(COMP_NAME, DCOMP_ID, ORIGIN_ID);
    P_TSI_COMPNAME_CHECK_FOR_DCHECK(COMP_NAME, DCOMP_ID, SP_ID);
  END;


  --用于新增时的3处同时校验
  PROCEDURE P_COMPANYNAME_NEW(COMP_NAME VARCHAR2, DCOMP_ID VARCHAR2)
  IS
  BEGIN
    P_TAR_COMPNAME_CHECK_FOR_NEW(COMP_NAME, DCOMP_ID);
    P_TFA_COMPNAME_CHECK_FOR_NEW(COMP_NAME, DCOMP_ID);
    P_TSI_COMPNAME_CHECK_FOR_NEW(COMP_NAME, DCOMP_ID);
  END;

END PKG_COMPNAME_CHECK;
/
