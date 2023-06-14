{DECLARE
  v_select_sql VARCHAR2(8000);
  v_dtime      VARCHAR2(30);
BEGIN
  v_dtime := to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS');
  --基本信息 
  v_select_sql := 'SELECT sp.supplier_info_id,
         sp.company_id,
         sp.supplier_info_origin_id,
         sp.supplier_code,
         sp.inside_supplier_code,
         sp.supplier_company_name,
         sp.supplier_company_abbreviation,
         sp.legal_representative,
         sp.company_create_date,
         sp.regist_address,
         sp.certificate_validity_start,
         sp.certificate_validity_end,
         sp.regist_price,
         sp.social_credit_code,
         sp.company_type,
         sp.company_person,
         sp.company_contact_person,
         sp.company_contact_phone,
         sp.regist_address company_address,
         sp.taxpayer,
         sp.company_say,
         sp.certificate_file up_certificate_file,
         sp.organization_file,
         decode(sp.sharing_type,
                '' 00 '',
                '' 不共享 '',
                '' 01 '',
                '' 全部共享 '',
                '' 02 '',
                '' 指定共享
                  '') sharing_type,
         --财务信息
         sp.public_accounts,
         sp.public_payment,
         sp.public_bank,
         sp.public_id,
         sp.public_phone,
         sp.personal_account,
         sp.personal_payment,
         sp.personal_bank,
         sp.personal_idcard,
         sp.personal_phone,
         sp.pay_type,
         sp.settlement_type,
         sp.reconciliation_user,
         sp.reconciliation_phone,
         --合同管理
         sp.contract_start_date,
         sp.contract_stop_date,
         sp.contract_file,
         --能力评估
         sp.cooperation_method,
         sp.cooperation_model,
         sp.cooperation_type,
         sp.production_mode,
         sp.cooperation_classification,
         sp.cooperation_subcategory
    FROM scmdata.t_supplier_info sp
   WHERE sp.company_id = %default_company_id%
   AND (sp.create_date >=
   to_date(''' || v_dtime || ''', '' yyyy - mm - dd hh24 :mi :ss '')or sp.update_date >=
   to_date(''' || v_dtime ||
                  ''', '' yyyy - mm - dd hh24 :mi :ss ''))';
 :strresult := v_select_sql;

END;
}
