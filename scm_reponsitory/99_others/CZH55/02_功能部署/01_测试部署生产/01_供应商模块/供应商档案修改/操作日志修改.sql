--已建档档案信息变更需记录操作日志
--a_supp_161 基本信息
DECLARE
  v_update_sql CLOB;
BEGIN
  v_update_sql := q'[DECLARE
  v_update_sql         VARCHAR2(4000);
p_sp_data            scmdata.t_supplier_info%ROWTYPE;
  p_default_company_id VARCHAR2(1000) := %default_company_id%;
  p_status             VARCHAR2(20) := 'OLD';
BEGIN
  --已建档数据
  SELECT :supplier_info_id,
         :supplier_code,
         :inside_supplier_code,
         :supplier_company_name,
         :company_province,
         :company_city,
         :company_county,
         :company_address_sp,
         :supplier_company_abbreviation,
         :social_credit_code,
         :legal_representative,
         :company_contact_person,
         :company_type,
         :cooperation_model,
         :cooperation_classification,
         :company_contact_phone,
         :certificate_file_sp,
         :company_say,
         :cooperation_type,
         :user_id,
         :remarks
    INTO p_sp_data.supplier_info_id,
         p_sp_data.supplier_code,
         p_sp_data.inside_supplier_code,
         p_sp_data.supplier_company_name,
         p_sp_data.company_province,
         p_sp_data.company_city,
         p_sp_data.company_county,
         p_sp_data.company_address,
         p_sp_data.supplier_company_abbreviation,
         p_sp_data.social_credit_code,
         p_sp_data.legal_representative,
         p_sp_data.company_contact_person,
         p_sp_data.company_type,
         p_sp_data.cooperation_model,
         p_sp_data.cooperation_classification,
         p_sp_data.company_contact_phone,
         p_sp_data.certificate_file,
         p_sp_data.company_say,
         p_sp_data.cooperation_type,
         p_sp_data.update_id,
         p_sp_data.remarks
    FROM dual;
    
  --更新 =》校验
  scmdata.pkg_supplier_info.check_save_t_supplier_info(p_sp_data            => p_sp_data,
                                                       p_default_company_id => p_default_company_id,
                                                       p_status             => p_status);
                                                       
  --档案编号，供应商名称、简称和统一社会信用代码 不可更改 
  UPDATE scmdata.t_supplier_info sp
     SET sp.inside_supplier_code          = :inside_supplier_code,
         sp.supplier_company_name         = :supplier_company_name,
         sp.supplier_company_abbreviation = :supplier_company_abbreviation,
         sp.legal_representative          = :legal_representative,
         sp.company_address               = :company_address_sp,
         sp.company_contact_person        = :company_contact_person,
         sp.company_type                  = :company_type,
         sp.cooperation_classification    = :cooperation_classification,
         sp.cooperation_model             = :cooperation_model,
         sp.company_contact_phone         = :company_contact_phone,
         sp.certificate_file              = :certificate_file_sp,
         sp.company_say                   = :company_say,
         sp.company_province              = :company_province,
         sp.company_city                  = :company_city,
         sp.company_county                = :company_county,
         sp.update_id                     = :user_id,
         sp.update_date                   = SYSDATE,
         sp.remarks                       = :remarks
   WHERE sp.supplier_info_id = :supplier_info_id;
   
  --3.新增日志操作
     scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-基本信息','',:user_id,p_default_company_id,SYSDATE);     

END;]';
  UPDATE nbw.sys_item_list t
     SET t.update_sql = v_update_sql
   WHERE t.item_id = 'a_supp_161';

END;
/
--a_supp_161_1 合作范围
DECLARE v_insert_sql CLOB;
v_update_sql CLOB;
v_delete_sql CLOB;
BEGIN
  v_insert_sql := q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
  v_coop_subcategory varchar2(1000) := :coop_subcategory_desc;
BEGIN

  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.create_id           := %user_id%;
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := :sharing_type;
  p_cp_data.publish_id          := '';
  p_cp_data.publish_date        := '';

  scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
  
  scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-新增合作范围','',%user_id%,%default_company_id%,SYSDATE); 

END;]';

  v_update_sql := q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN

  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.sharing_type        := :sharing_type;

  scmdata.pkg_supplier_info.update_coop_scope(p_cp_data => p_cp_data);
  
  --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-修改合作范围','',%user_id%,%default_company_id%,SYSDATE); 

END;]';

  UPDATE nbw.sys_item_list t
     SET t.insert_sql = v_insert_sql, t.update_sql = v_update_sql
   WHERE t.item_id = 'a_supp_161_1';

END;
/
--a_supp_161_3 合同记录
DECLARE v_insert_sql CLOB;
v_update_sql CLOB;
v_delete_sql CLOB;
BEGIN
  v_insert_sql := q'[DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file
    FROM dual;
  scmdata.pkg_supplier_info.insert_contract_info(p_contract_rec => p_contract_rec);
    --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-新增合同','',%user_id%,:company_id,SYSDATE); 
END;]';

  v_update_sql := q'[DECLARE
  p_contract_rec scmdata.t_contract_info%ROWTYPE;
BEGIN
  SELECT :contract_info_id,
         :supplier_info_id,
         :company_id,
         :contract_start_date,
         :contract_stop_date,
         :contract_sign_date,
         :contract_file
    INTO p_contract_rec.contract_info_id,
         p_contract_rec.supplier_info_id,
         p_contract_rec.company_id,
         p_contract_rec.contract_start_date,
         p_contract_rec.contract_stop_date,
         p_contract_rec.contract_sign_date,
         p_contract_rec.contract_file
    FROM dual;
  scmdata.pkg_supplier_info.update_contract_info(p_contract_rec => p_contract_rec);
  --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-修改合同','',%user_id%,%default_company_id%,SYSDATE); 
END;]';

  v_delete_sql := q'[DECLARE
BEGIN
 scmdata.pkg_supplier_info.delete_contract_info(p_contract_info_id => :contract_info_id);
 
 scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-删除合同','',%user_id%,%default_company_id%,SYSDATE); 
END;]';

  UPDATE nbw.sys_item_list t
     SET t.insert_sql = v_insert_sql,
         t.update_sql = v_update_sql,
         t.delete_sql = v_delete_sql
   WHERE t.item_id = 'a_supp_161_3';

END;
/
--a_supp_161_4 供应商选择
DECLARE v_insert_sql CLOB;
v_delete_sql CLOB;
BEGIN
  v_insert_sql := q'[DECLARE
  scope_rec scmdata.t_coop_scope%ROWTYPE;
BEGIN
  SELECT *
    INTO scope_rec
    FROM scmdata.t_coop_scope t
   WHERE t.coop_scope_id = %ass_coop_scope_id%;

  INSERT INTO t_supplier_shared
    (coop_scope_id,
     supplier_shared_id,
     company_id,
     supplier_info_id,
     shared_supplier_code,
     remarks)
  VALUES
    (%ass_coop_scope_id%,
     scmdata.f_get_uuid(),
     scope_rec.company_id,
     scope_rec.supplier_info_id,
     :supplier_code,
     '');
     
    --3.新增日志操作
  scmdata.pkg_supplier_info.insert_oper_log(scope_rec.supplier_info_id,'修改档案-新增指定供应商','',%user_id%,%default_company_id%,SYSDATE); 
END;]';

  v_delete_sql := q'[DECLARE
BEGIN
DELETE FROM scmdata.t_supplier_shared t WHERE t.supplier_shared_id = :supplier_shared_id;
--3.新增日志操作
scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-删除指定供应商','',%user_id%,%default_company_id%,SYSDATE); 
END;]';

  UPDATE nbw.sys_item_list t
     SET t.insert_sql = v_insert_sql,
         t.delete_sql = v_delete_sql
   WHERE t.item_id = 'a_supp_161_4';

END;
/

