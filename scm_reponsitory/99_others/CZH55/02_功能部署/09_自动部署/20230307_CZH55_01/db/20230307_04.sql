DECLARE
  v_company_id    VARCHAR2(32);
  v_attributor_id VARCHAR2(32);
BEGIN
  SELECT t.company_id, t.attributor_id
    INTO v_company_id, v_attributor_id
    FROM scmdata.sys_company t
   WHERE t.licence_num = '91440106MAC14MY400';

  UPDATE scmdata.sys_user_company t
     SET t.user_id = v_attributor_id
   WHERE t.company_id = v_company_id;
END;
/
