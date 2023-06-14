???prompt Importing table nbw.sys_item_list...
set feedback off
set define off
insert into nbw.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE)
values ('a_supp_151', 0, null, null, null, null, '--基本信息 
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_code,
       sp.inside_supplier_code,
       sp.supplier_company_name,
       province || city || county location_area,
       sp.company_province company_province,
       sp.company_city company_city,
       sp.company_county company_county,
       nvl(sp.company_address, fc.address) company_address_sp,
       sp.supplier_company_abbreviation,
       sp.social_credit_code,
       sp.legal_representative,
       sp.company_contact_person,
       sp.company_type,
       sp.cooperation_model,
       sp.company_contact_phone,
       sp.certificate_file certificate_file_sp,
       sp.company_say,
       sp.cooperation_type,
       sp.remarks,
       sp.supplier_info_origin
  FROM scmdata.t_supplier_info sp
  LEFT JOIN scmdata.t_factory_ask fa
    ON sp.supplier_info_origin_id = fa.factory_ask_id
  LEFT JOIN scmdata.dic_province p
    ON p.provinceid = nvl(sp.company_province, fa.company_province)
  LEFT JOIN scmdata.dic_city c
    ON c.cityno = nvl(sp.company_city, fa.company_city)
  LEFT JOIN scmdata.dic_county dc
    ON dc.countyid = nvl(sp.company_county, fa.company_county)
  LEFT JOIN scmdata.sys_company fc
    ON fc.company_id = sp.supplier_company_id
 WHERE sp.supplier_info_id = %ass_supplier_info_id%
   AND sp.company_id = %default_company_id%', null, null, null, '{DECLARE
  v_origin     VARCHAR2(32);
  v_update_sql VARCHAR2(4000);
BEGIN
  --待建档数据
  --来源为准入/手动新增
  SELECT max(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = %ass_supplier_info_id%
     AND sp.company_id = %default_company_id%
     AND sp.status = 0;

  --档案编号，供应商名称、简称和统一社会信用代码 不可更改
  IF v_origin = ''AA'' THEN
    v_update_sql := ''UPDATE scmdata.t_supplier_info sp
       SET sp.inside_supplier_code   = :inside_supplier_code,
           sp.supplier_company_name         = :supplier_company_name,
           sp.supplier_company_abbreviation = :supplier_company_abbreviation,
           sp.legal_representative   = :legal_representative,
           sp.company_address        = :company_address_sp,
           sp.company_contact_person = :company_contact_person,
           sp.company_type           = :company_type,
           sp.cooperation_classification = :cooperation_classification,
           sp.company_contact_phone  = :company_contact_phone,
           sp.certificate_file       = :certificate_file_sp,
           sp.company_say            = :company_say,
           sp.company_province       = :company_province,
           sp.company_city           = :company_city,
           sp.company_county         = :company_county,
           sp.update_id              = :user_id,
           sp.update_date            = SYSDATE,
           sp.remarks                = :remarks
     WHERE sp.supplier_info_id = :supplier_info_id'';
   /* scmdata.pkg_compname_check.p_companyname_dcheck(comp_name => :supplier_company_name,
                                                    dcomp_id  => %default_company_id%,
                                                    origin_id => v_ori_id,
                                                    sp_id     => :supplier_info_id);*/
  ELSIF v_origin = ''MA'' THEN
    v_update_sql := ''UPDATE scmdata.t_supplier_info sp
   SET sp.inside_supplier_code          = :inside_supplier_code,
       sp.supplier_company_name         = :supplier_company_name,
       sp.supplier_company_abbreviation = :supplier_company_abbreviation,
       sp.social_credit_code            = :social_credit_code,
       sp.legal_representative          = :legal_representative,
       sp.company_address               = :company_address_sp,
       sp.company_contact_person        = :company_contact_person,
       sp.company_type                  = :company_type,
       sp.company_contact_phone         = :company_contact_phone,
       sp.certificate_file              = :certificate_file_sp,
       sp.company_say                   = :company_say,
       sp.company_province                  = :company_province,
       sp.company_city                      = :company_city,
       sp.company_county                    = :company_county,
       sp.cooperation_type                  = :cooperation_type,
       sp.cooperation_model                 = :cooperation_model,
       sp.update_id              = :user_id,
       sp.update_date            = SYSDATE,
       sp.remarks                = :remarks
 WHERE sp.supplier_info_id = :supplier_info_id'';
   /* scmdata.pkg_compname_check.p_companyname_new(comp_name => :supplier_company_name,
                                                 dcomp_id  => %default_company_id%);*/
  ELSE
    RETURN;
  END IF;
  @strresult := v_update_sql;
END;
}', null, 'supplier_info_id,company_id,supplier_info_origin_id,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,province,city,county,company_type', null, null, null, null, '00', 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into nbw.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE)
values ('g_540_11', 12, null, null, null, null, 'SELECT t.seq_no,
       t.object_id,
       t.type,
       t.left_pos,
       t.top_pos,
       t.pause,
       t.condition,
       t.label_id
  FROM nbw.sys_label_lists t
 WHERE t.label_id = :LABEL_ID', null, null, null, null, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

prompt Done.
