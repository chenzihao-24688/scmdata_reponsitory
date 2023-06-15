CREATE OR REPLACE PACKAGE SCMDATA.pkg_compname_check IS

  PROCEDURE p_tar_compname_check_for_new(comp_name VARCHAR2,
                                         dcomp_id  VARCHAR2);

  PROCEDURE p_tar_compname_check_for_dcheck(comp_name VARCHAR2,
                                            dcomp_id  VARCHAR2,
                                            origin_id VARCHAR2);

  PROCEDURE p_tfa_compname_check_for_new(comp_name VARCHAR2,
                                         dcomp_id  VARCHAR2,
                                         p_fask_id VARCHAR2 DEFAULT NULL,
                                         check_type INT DEFAULT 0);

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

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_compname_check IS

  --新增时：校验公司名称是否与意向合作供应商清单内已提交公司名称重复
  PROCEDURE p_tar_compname_check_for_new(comp_name VARCHAR2,
                                         dcomp_id  VARCHAR2) IS
    judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO judge
      FROM scmdata.t_ask_record
     WHERE company_id = dcomp_id
       AND company_name = comp_name
       AND coor_ask_flow_status <> 'CA00';
    IF judge > 0 THEN
      raise_application_error(-20002,
                              '公司名称与意向合作供应商清单的公司名称重复！');
    END IF;
  END p_tar_compname_check_for_new;

  --修改时：校验公司名称是否与意向合作供应商清单内已提交公司名称重复
  PROCEDURE p_tar_compname_check_for_dcheck(comp_name VARCHAR2,
                                            dcomp_id  VARCHAR2,
                                            origin_id VARCHAR2) IS
    judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO judge
      FROM scmdata.t_ask_record
     WHERE company_id = dcomp_id
       AND company_name = comp_name
       AND coor_ask_flow_status <> 'CA00'
       AND ask_record_id <>
           (SELECT ask_record_id
              FROM scmdata.t_factory_ask
             WHERE factory_ask_id = origin_id);
    IF judge > 0 THEN
      raise_application_error(-20002,
                              '公司名称与意向合作供应商清单的公司名称重复！');
    END IF;
  END p_tar_compname_check_for_dcheck;

  --新增时：校验公司名称是否与准入流程中已提交公司名称重复
  --CZH ADD P_FASK_ID 
  PROCEDURE p_tfa_compname_check_for_new(comp_name  VARCHAR2,
                                         dcomp_id   VARCHAR2,
                                         p_fask_id  VARCHAR2 DEFAULT NULL,
                                         check_type INT DEFAULT 0) IS
    judge NUMBER(1);
  BEGIN
    IF check_type = 0 THEN
      SELECT COUNT(1)
        INTO judge
        FROM scmdata.t_factory_ask
       WHERE company_id = dcomp_id
         AND factory_ask_id <> p_fask_id
         AND company_name = comp_name
         AND factrory_ask_flow_status NOT IN ('CA01', 'FA01', 'FA03');
      IF judge > 0 THEN
        raise_application_error(-20002,
                                '公司名称与准入流程中的公司名称重复！');
      END IF;
    ELSIF check_type = 1 THEN
      SELECT COUNT(1)
        INTO judge
        FROM scmdata.t_factory_ask
       WHERE company_id = dcomp_id
         AND factory_ask_id <> p_fask_id
         AND company_abbreviation = comp_name
         AND factrory_ask_flow_status NOT IN ('CA01', 'FA01', 'FA03');
      IF judge > 0 THEN
        raise_application_error(-20002,
                                '公司简称与准入流程中的公司名称重复！');
      END IF;
    ELSE
      NULL;
    END IF;
  END p_tfa_compname_check_for_new;

  --修改时：校验公司名称是否与准入流程中已提交公司名称重复
  PROCEDURE p_tfa_compname_check_for_dcheck(comp_name VARCHAR2,
                                            dcomp_id  VARCHAR2,
                                            origin_id VARCHAR2) IS
    judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO judge
      FROM scmdata.t_factory_ask
     WHERE company_id = dcomp_id
       AND company_name = comp_name
       AND factrory_ask_flow_status NOT IN ('CA01', 'FA01')
       AND ask_record_id <>
           (SELECT ask_record_id
              FROM scmdata.t_factory_ask
             WHERE factory_ask_id = origin_id);
    IF judge > 0 THEN
      raise_application_error(-20002,
                              '公司名称与准入流程中的公司名称重复！');
    END IF;
  END p_tfa_compname_check_for_dcheck;

  --新增时：校验公司名称是否与待建档、已建档的供应商名称重复
  PROCEDURE p_tsi_compname_check_for_new(comp_name VARCHAR2,
                                         dcomp_id  VARCHAR2) IS
    judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO judge
      FROM scmdata.t_supplier_info
     WHERE company_id = dcomp_id
       AND supplier_company_name = comp_name;
    IF judge > 0 THEN
      raise_application_error(-20002,
                              '公司名称与待建档、已建档的供应商名称重复！');
    END IF;
  END p_tsi_compname_check_for_new;

  --修改时：校验公司名称是否与待建档、已建档的供应商名称重复
  PROCEDURE p_tsi_compname_check_for_dcheck(comp_name VARCHAR2,
                                            dcomp_id  VARCHAR2,
                                            sp_id     VARCHAR2) IS
    judge NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO judge
      FROM scmdata.t_supplier_info
     WHERE company_id = dcomp_id
       AND supplier_company_name = comp_name
       AND supplier_info_id <> sp_id;
    IF judge > 0 THEN
      raise_application_error(-20002,
                              '公司名称与待建档、已建档的供应商名称重复！');
    END IF;
  END p_tsi_compname_check_for_dcheck;

  --用于修改时的3处同时校验
  PROCEDURE p_companyname_dcheck(comp_name VARCHAR2,
                                 dcomp_id  VARCHAR2,
                                 origin_id VARCHAR2,
                                 sp_id     VARCHAR2) IS
  BEGIN
    p_tar_compname_check_for_dcheck(comp_name, dcomp_id, origin_id);
    p_tfa_compname_check_for_dcheck(comp_name, dcomp_id, origin_id);
    p_tsi_compname_check_for_dcheck(comp_name, dcomp_id, sp_id);
  END;

  --用于新增时的3处同时校验
  PROCEDURE p_companyname_new(comp_name VARCHAR2, dcomp_id VARCHAR2) IS
  BEGIN
    p_tar_compname_check_for_new(comp_name, dcomp_id);
    p_tfa_compname_check_for_new(comp_name, dcomp_id);
    p_tsi_compname_check_for_new(comp_name, dcomp_id);
  END;

END pkg_compname_check;
/

