BEGIN
  FOR rec IN (SELECT a.attributor_id, a.company_id
                FROM scmdata.sys_company a
               WHERE a.licence_num IN
                     ('91350203MA31K6PP29',
                      '914403005840804293',
                      '91310101332329566H',
                      '913307827590843931',
                      '91441900MA52PQJ30R',
                      '91440106MAC14MY400')) LOOP
  
    UPDATE scmdata.sys_company_user t
       SET t.phone = REPLACE(t.phone, chr(10), '')
     WHERE t.user_id = rec.attributor_id
       AND t.company_id = rec.company_id;
  
    UPDATE scmdata.sys_user t
       SET t.user_account = REPLACE(t.user_account, chr(10), ''),
           t.phone        = REPLACE(t.phone, chr(10), ''),
           t.password     = '496d234c7d6f6f7a422d634747632d4273616173422d6d05'
     WHERE t.user_id = rec.attributor_id;
  END LOOP;
END;
/ 
DECLARE
  po_result NUMBER;
  po_msg    VARCHAR2(1000);
BEGIN
  FOR rec IN (SELECT a.attributor_id, a.company_id, a.licence_num
                FROM scmdata.sys_company a
               WHERE a.licence_num IN ('91440106MAC14MY400')) LOOP
    UPDATE t_supplier_info
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
