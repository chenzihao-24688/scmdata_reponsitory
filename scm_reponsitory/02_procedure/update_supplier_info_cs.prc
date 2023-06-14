CREATE OR REPLACE PROCEDURE SCMDATA.update_supplier_info_cs(p_sp_data t_supplier_info%ROWTYPE,p_origin VARCHAR2)
IS
BEGIN
  IF (p_origin = 'AA') THEN
    UPDATE scmdata.t_supplier_info sp
       SET sp.inside_supplier_code          = p_sp_data.inside_supplier_code,
           sp.supplier_company_name         = p_sp_data.supplier_company_name,
           sp.supplier_company_abbreviation = p_sp_data.supplier_company_abbreviation,
           sp.legal_representative          = p_sp_data.legal_representative,
           sp.company_address               = p_sp_data.company_address,
           sp.company_contact_person        = p_sp_data.company_contact_person,
           sp.company_type                  = p_sp_data.company_type,
           sp.cooperation_classification    = p_sp_data.cooperation_classification,
           sp.company_contact_phone         = p_sp_data.company_contact_phone,
           sp.certificate_file              = p_sp_data.certificate_file,
           sp.company_say                   = p_sp_data.company_say,
           sp.company_province              = p_sp_data.company_province,
           sp.company_city                  = p_sp_data.company_city,
           sp.company_county                = p_sp_data.company_county,
           sp.update_id                     = p_sp_data.update_id,
           sp.update_date                   = SYSDATE,
           sp.remarks                       = p_sp_data.remarks,
           sp.product_type                  = p_sp_data.product_type,
           sp.product_link                  = p_sp_data.product_link,
           sp.brand_type                    = p_sp_data.brand_type,
           sp.product_line                  = p_sp_data.product_line,
           sp.product_line_num              = p_sp_data.product_line_num,
           sp.worker_num                    = p_sp_data.worker_num,
           sp.machine_num                   = p_sp_data.machine_num,
           sp.quality_step                  = p_sp_data.quality_step,
           sp.pattern_cap                   = p_sp_data.pattern_cap,
           sp.fabric_purchase_cap           = p_sp_data.fabric_purchase_cap,
           sp.fabric_check_cap              = p_sp_data.fabric_check_cap,
           sp.cost_step                     = p_sp_data.cost_step,
           sp.coop_position                 = p_sp_data.coop_position
     WHERE sp.supplier_info_id = p_sp_data.supplier_info_id;
     ELSIF (p_origin = 'MA') THEN
       UPDATE scmdata.t_supplier_info sp
   SET sp.inside_supplier_code              = p_sp_data.inside_supplier_code,
       sp.supplier_company_name             = p_sp_data.supplier_company_name,
       sp.supplier_company_abbreviation     = p_sp_data.supplier_company_abbreviation,
       sp.social_credit_code                = p_sp_data.social_credit_code,
       sp.legal_representative              = p_sp_data.legal_representative,
       sp.company_address                   = p_sp_data.company_address,
       sp.company_contact_person            = p_sp_data.company_contact_person,
       sp.company_type                      = p_sp_data.company_type,
       sp.company_contact_phone             = p_sp_data.company_contact_phone,
       sp.certificate_file                  = p_sp_data.certificate_file,
       sp.company_say                       = p_sp_data.company_say,
       sp.company_province                  = p_sp_data.company_province,
       sp.company_city                      = p_sp_data.company_city,
       sp.company_county                    = p_sp_data.company_county,
       sp.cooperation_type                  = p_sp_data.cooperation_type,
       sp.cooperation_model                 = p_sp_data.cooperation_model,
       sp.update_id                         = p_sp_data.update_id,
       sp.update_date                       = SYSDATE,
       sp.remarks                           = p_sp_data.remarks,
       sp.product_type                      = p_sp_data.product_type,
       sp.product_link                      = p_sp_data.product_link,
       sp.brand_type                        = p_sp_data.brand_type,
       sp.product_line                      = p_sp_data.product_line,
       sp.product_line_num                  = p_sp_data.product_line_num,
       sp.worker_num                        = p_sp_data.worker_num,
       sp.machine_num                       = p_sp_data.machine_num,
       sp.quality_step                      = p_sp_data.quality_step,
       sp.pattern_cap                       = p_sp_data.pattern_cap,
       sp.fabric_purchase_cap               = p_sp_data.fabric_purchase_cap,
       sp.fabric_check_cap                  = p_sp_data.fabric_check_cap,
       sp.cost_step                         = p_sp_data.cost_step,
       sp.coop_position                     = p_sp_data.coop_position
 WHERE sp.supplier_info_id = p_sp_data.supplier_info_id;
 END IF;
 END update_supplier_info_cs;
/

