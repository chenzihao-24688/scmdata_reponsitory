DECLARE
  v_av_str   VARCHAR2(1000) := 'supplier_code,
   inside_supplier_code,
   supplier_company_name,
   supplier_company_abbreviation,
   legal_representative,
   company_create_date,
   regist_address,
   certificate_validity_start,
   certificate_validity_end,
   regist_price,
   social_credit_code,
   company_type,
   company_person,
   company_contact_person,
   company_contact_phone,
   regist_address,
   taxpayer,
   company_say,
   certificate_file,
   organization_file,
   public_accounts,
   public_payment,
   public_bank,
   public_id,
   public_phone,
   personal_account,
   personal_payment,
   personal_bank,
   personal_idcard,
   personal_phone,
   pay_type,
   settlement_type,
   reconciliation_user,
   reconciliation_phone,
   contract_stop_date,
   contract_file,
   cooperation_method,
   cooperation_model,
   cooperation_type,
   production_mode,
   cooperation_classification,
   cooperation_subcategory'; --ÒªÇÐ¸îµÄ×Ö·û´®
  v_av_split VARCHAR2(100) := ','; --·Ö¸î·û
  v_length   NUMBER;
  TYPE role_name_tb_type IS TABLE OF scmdata.sys_company_role.company_role_name%TYPE INDEX BY BINARY_INTEGER;
  role_name_tb role_name_tb_type;

  v_parent_id VARCHAR2(100) := 'ae37e86dd7092815e055025056876ded';
  v_code      VARCHAR2(100) := '06';

BEGIN
  v_length := scmdata.sf_import_company_users_pkg.get_strarraylength(v_av_str,
                                                                     v_av_split);

  FOR i IN 0 .. (v_length - 1) LOOP
    SELECT scmdata.sf_import_company_users_pkg.get_strarraystrofindex(v_av_str,
                                                                      v_av_split,
                                                                      i)
      INTO role_name_tb(i)
      FROM dual;
  
  END LOOP;

  FOR i IN 0 .. (v_length - 1) LOOP
    dbms_output.put_line(upper(role_name_tb(i)));
  /* INSERT INTO scmdata.sys_group_dict
        (group_dict_id,
         parent_id,
         parent_ids,
         group_dict_name,
         group_dict_value,
         group_dict_type,
         group_dict_sort,
         group_dict_status,
         tree_level,
         is_leaf,
         is_initial,
         create_id,
         create_time,
         update_id,
         update_time,
         pause,
         del_flag)
      VALUES
        (scmdata.f_get_uuid(),
         v_parent_id,
         v_parent_id,
         role_name_tb(i),
         v_code || i,
         v_code,
         1,
         1,
         2,
         0,
         0,
         'admin',
         SYSDATE,
         'admin',
         SYSDATE,
         0,
         0);*/
  END LOOP;

END;

/*SELECT t.rowid,
       t.group_dict_id,
       t.group_dict_name,
       t.group_dict_value,
       LEVEL,
       lpad(t.group_dict_name,
            lengthb(t.group_dict_name) + (LEVEL * 2) - 2,
            '_') chart
  FROM scmdata.sys_group_dict t
 START WITH t.group_dict_value = '06'
        AND t.parent_id IS NULL
CONNECT BY PRIOR t.group_dict_id = t.parent_id;
*/
