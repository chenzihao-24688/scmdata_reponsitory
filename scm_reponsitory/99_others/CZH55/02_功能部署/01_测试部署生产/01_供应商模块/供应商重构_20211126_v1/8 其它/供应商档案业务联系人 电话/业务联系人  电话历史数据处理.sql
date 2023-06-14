update bw3.sys_field_list t set t.caption = '公司联系人' where t.field_name = 'COMPANY_CONTACT_PERSON';
/
BEGIN
  UPDATE scmdata.t_supplier_info t
     SET t.fa_contact_name  = t.company_contact_person,
         t.fa_contact_phone = t.company_contact_phone
   WHERE 1 = 1;
END;

