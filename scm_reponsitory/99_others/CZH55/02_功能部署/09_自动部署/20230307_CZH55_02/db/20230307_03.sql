DECLARE
  po_result NUMBER;
  po_msg    VARCHAR2(1000);
BEGIN
  FOR rec IN (SELECT a.attributor_id, a.company_id, a.licence_num
                FROM scmdata.sys_company a
               WHERE a.licence_num IN ('91440106MAC14MY400')) LOOP
    UPDATE scmdata.t_supplier_info
       SET supplier_company_id = rec.company_id, bind_status = 1
     WHERE social_credit_code = rec.licence_num;
  
    --自动将应用包赋值给供应方 2021-11-22 hx87
    /* pi_type = 1 第三个参数，代表新增应用*/
    scmdata.pkg_company_manage.p_app_buy_for_supp(rec.attributor_id,
                                                  rec.company_id,
                                                  1,
                                                  po_result,
                                                  po_msg,
                                                  'supp');
  END LOOP;
END;
/
