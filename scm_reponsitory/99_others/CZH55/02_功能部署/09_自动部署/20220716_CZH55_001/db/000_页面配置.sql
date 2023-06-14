ALTER TABLE scmdata.T_SUPPLIER_INFO ADD (PAUSE_CAUSE VARCHAR2(4000));
ALTER TABLE scmdata.T_SUPPLIER_INFO ADD GROUP_NAME_ORIGIN VARCHAR2(48) DEFAULT 'AA';
ALTER TABLE scmdata.T_PLAT_LOGS ADD (MEMO_DESC VARCHAR2(4000));
/
COMMENT ON COLUMN scmdata.T_SUPPLIER_INFO.PAUSE_CAUSE IS '启停原因';
COMMENT ON COLUMN scmdata.T_SUPPLIER_INFO.GROUP_NAME_ORIGIN IS '分组来源：AA 自动生成，MA 手动编辑';
COMMENT ON COLUMN scmdata.T_PLAT_LOGS.MEMO_DESC IS '备注描述';
/
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_query_t_plat_log(p_apply_pk_id =>  :supplier_info_id,p_dict_type => ''SUPPLIER_INFO_LOG'');
  @strresult := v_sql;
END;}';
  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql
   WHERE t.item_id = 'a_supp_120_1';
END;
/
DECLARE
  v_sql CLOB;
  v_u_sql CLOB;
  v_ns_fileds CLOB;
BEGIN
  v_sql := 'WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
--基本信息 
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.supplier_code,
       sp.social_credit_code,
       sp.legal_representative,
       sp.inside_supplier_code,
       sp.company_province company_province,
       sp.company_city company_city,
       sp.company_county company_county,
       province || city || county location_area,
       nvl(sp.company_address, fc.address) company_address_sp,
       sp.group_name,
       sp.area_group_leader,
       sp.company_contact_phone,
       sp.fa_contact_name,
       sp.fa_contact_phone,
       sp.company_type,
       --生产信息
       sp.product_type,
       sp.product_link,
       sp.brand_type,
       sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, '';'') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = ''COOPERATION_BRAND''
           AND t.group_dict_id = b.parent_id
           AND instr('';'' || sp.brand_type || '';'',
                     '';'' || t.group_dict_value || '';'') > 0
           AND instr('';'' || sp.cooperation_brand || '';'',
                     '';'' || b.group_dict_value || '';'') > 0) cooperation_brand_desc,
       sp.product_line,
       sp.product_line_num,
       sp.worker_num,
       sp.machine_num,
       sp.quality_step quality_step,
       sp.pattern_cap pattern_cap,
       sp.fabric_purchase_cap fabric_purchase_cap,
       sp.fabric_check_cap fabric_check_cap,
       sp.cost_step cost_step,
       --decode(sp.reserve_capacity, NULL, '''', sp.reserve_capacity || ''%'') reserve_capacity,
       decode(sp.product_efficiency, NULL, ''80%'', sp.product_efficiency || ''%'') product_efficiency,
       sp.work_hours_day,
       --合作信息
       sp.pause coop_state,
       nvl2(sp.supplier_company_id, ''已注册'', ''未注册'') regist_status_sp,
       decode(sp.bind_status, 1, ''已绑定'', ''未绑定'') bind_status_sq,
       sp.cooperation_type,
       sp.cooperation_model,
       sp.coop_position,
       --附件资料
       sp.certificate_file certificate_file_sp,
       sp.ask_files ASK_FILES_SP,
       sp.supplier_gate,
       sp.supplier_office,
       sp.supplier_site,
       sp.supplier_product,
       sp.file_remark,
       --其他
       sp.supplier_info_origin,
       sp.status
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
 INNER JOIN group_dict ga
    ON sp.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = ''COOPERATION_TYPE''
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''COOPERATION_BRAND''
   AND gd.group_dict_value = sp.cooperation_brand
 WHERE sp.supplier_info_id = %ass_supplier_info_id%
   AND sp.company_id = %default_company_id%';
  v_u_sql := '{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN
  --来源为准入/手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%
     AND sp.status = 0;

  v_sql := q''[DECLARE
  v_sp_data t_supplier_info%ROWTYPE;
BEGIN
  --待建档数据
  v_sp_data.supplier_info_id := :supplier_info_id;
  v_sp_data.company_id       := :company_id;
  v_sp_data.status           := :status;
  v_sp_data.supplier_info_origin := '']'' || v_origin || q''['' ;
  --来源为准入 统一社会信用代码则 不可更改
  --来源为手动新增 待建档：统一社会信用代码 可以更改 ，已建档 不可以更改
  ]'' || CASE
             WHEN v_origin = ''MA'' THEN
              ''
               v_sp_data.social_credit_code            := :social_credit_code;
               ''
             ELSE
              ''''
           END || q''[
  --基本信息
  v_sp_data.supplier_company_name         := :supplier_company_name;
  v_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  v_sp_data.legal_representative := :legal_representative;
  v_sp_data.inside_supplier_code := :inside_supplier_code;
  v_sp_data.company_province     := :company_province;
  v_sp_data.company_city         := :company_city;
  v_sp_data.company_county       := :company_county;
  v_sp_data.company_address      := :company_address_sp;
  --v_sp_data.group_name           := :group_name;
  v_sp_data.company_contact_phone := :company_contact_phone;
  v_sp_data.fa_contact_name       := :fa_contact_name;
  v_sp_data.fa_contact_phone      := :fa_contact_phone;
  v_sp_data.company_type          := :company_type;
  --生产信息
  v_sp_data.product_type        := :product_type;
  v_sp_data.product_link        := :product_link;
  v_sp_data.brand_type          := :brand_type;
  v_sp_data.cooperation_brand   := :cooperation_brand;
  v_sp_data.product_line        := :product_line;
  v_sp_data.product_line_num    := :product_line_num;
  v_sp_data.worker_num          := :worker_num;
  v_sp_data.machine_num         := :machine_num;
  v_sp_data.quality_step        := :quality_step;
  v_sp_data.pattern_cap         := :pattern_cap;
  v_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  v_sp_data.fabric_check_cap    := :fabric_check_cap;
  v_sp_data.cost_step           := :cost_step;
  v_sp_data.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  v_sp_data.product_efficiency  := rtrim(:product_efficiency,''%'');
  v_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  v_sp_data.pause               := :coop_state;
  --v_sp_data.cooperation_type  := :cooperation_type;
  v_sp_data.cooperation_model := :cooperation_model;
  IF instr(:cooperation_model,''OF'')> 0 THEN
  v_sp_data.coop_position     := ''外协厂'';
  ELSE
  IF :coop_position IS NULL THEN
  v_sp_data.coop_position     := ''普通型'';
  ELSE
  v_sp_data.coop_position     := :coop_position;
  END IF;
  END IF;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
  v_sp_data.ask_files := :ASK_FILES_SP;
  v_sp_data.supplier_gate    := :supplier_gate;
  v_sp_data.supplier_office  := :supplier_office;
  v_sp_data.supplier_site    := :supplier_site;
  v_sp_data.supplier_product := :supplier_product;
  v_sp_data.company_say      := :company_say;
  v_sp_data.file_remark      := :file_remark;
  v_sp_data.update_id        := :user_id;
  v_sp_data.update_date      := SYSDATE;
  --1.更新=》保存，校验数据
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data);
  --2.更新所在区域
  pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                        p_supplier_info_id => :supplier_info_id,
                                        p_is_by_pick => 1,
                                        p_province   => :company_province,
                                        p_city       => :company_city);
END;]'';
  @strresult := v_sql;
END;}';
  v_ns_fileds := 'supplier_info_id,company_id,supplier_info_origin_id,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,province,city,county,company_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,FA_BRAND_TYPE,GROUP_NAME';
  
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql,t.update_sql = v_u_sql,t.noshow_fields = v_ns_fileds WHERE t.item_id = 'a_supp_151';
END;
/
DECLARE
  v_sql CLOB;
  v_ns_fields CLOB;
  v_ne_fields CLOB;
BEGIN
  v_sql := '--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_coop_factory_list(p_item_id => ''a_supp_151_7''); 
  @strresult := v_sql;
END;}';
 
 v_ns_fields := 'coop_factory_id,supplier_info_id,company_id,coop_factory_type,coop_status,FAC_SUP_INFO_ID,product_type,product_link,product_line,cooperation_brand_desc';
 v_ne_fields := 'inside_supplier_code,coop_factory_type,coop_status';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql,t.noshow_fields = v_ns_fields,t.noedit_fields = v_ne_fields WHERE t.item_id = 'a_supp_151_7';
END;
/
DECLARE
  v_sql CLOB;
  v_u_sql CLOB;
  v_ns_fileds CLOB;
BEGIN
  v_sql := '--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_filed_supp_info(); 
  @strresult := v_sql;
END;}';
  v_u_sql := 'BEGIN
  --1.更新=》保存，校验数据
  
  IF :group_name IS NULL THEN
   raise_application_error(-20002, ''所在分组不可为空!'');
  END IF;
  
  UPDATE scmdata.t_supplier_info t
     SET t.group_name = :group_name,
         t.GROUP_NAME_ORIGIN = ''MA'',
         t.update_id = :user_id,
         t.update_date = sysdate
   WHERE t.supplier_info_id = :supplier_info_id
     AND t.company_id = :company_id;
END;';
  v_ns_fileds := 'supplier_info_id,company_id,supplier_company_id,supplier_info_origin_id,status,pause,cooperation_method_sp,production_mode_sp,sp_status_desc,bind_status,factory_ask_id,coop_status,GROUP_NAME';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql,t.update_sql = v_u_sql,t.noshow_fields = v_ns_fileds WHERE t.item_id = 'a_supp_160';
END;
/
DECLARE
  v_sql CLOB;
  v_u_sql CLOB;
  v_ns_fileds CLOB;
BEGIN
  v_sql := 'WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
--基本信息 
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.supplier_code,
       sp.social_credit_code,
       sp.legal_representative,
       sp.inside_supplier_code,
       sp.company_province company_province,
       sp.company_city company_city,
       sp.company_county company_county,
       province || city || county location_area,
       nvl(sp.company_address, fc.address) company_address_sp,
       sp.group_name,
       sp.area_group_leader,
       sp.company_contact_phone,
       sp.fa_contact_name,
       sp.fa_contact_phone,
       sp.company_type,
       --生产信息
       sp.product_type,
       sp.product_link,
       sp.brand_type,
       sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, '';'') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = ''COOPERATION_BRAND''
           AND t.group_dict_id = b.parent_id
           AND instr('';'' || sp.brand_type || '';'',
                     '';'' || t.group_dict_value || '';'') > 0
           AND instr('';'' || sp.cooperation_brand || '';'',
                     '';'' || b.group_dict_value || '';'') > 0) cooperation_brand_desc,
       sp.product_line,
       sp.product_line_num,
       sp.worker_num,
       sp.machine_num,
       sp.quality_step quality_step,
       sp.pattern_cap pattern_cap,
       sp.fabric_purchase_cap fabric_purchase_cap,
       sp.fabric_check_cap fabric_check_cap,
       sp.cost_step cost_step,
       --decode(sp.reserve_capacity, NULL, '''', sp.reserve_capacity || ''%'') reserve_capacity,
       decode(sp.product_efficiency, NULL, ''80%'', sp.product_efficiency || ''%'') product_efficiency,
       sp.work_hours_day,
       --合作信息
       sp.pause coop_state,
       nvl2(sp.supplier_company_id, ''已注册'', ''未注册'') regist_status_sp,
       decode(sp.bind_status, 1, ''已绑定'', ''未绑定'') bind_status_sq,
       sp.cooperation_type,
       sp.cooperation_model,
       sp.coop_position,
       --附件资料
       sp.certificate_file certificate_file_sp,
       sp.ask_files ASK_FILES_SP,
       sp.supplier_gate,
       sp.supplier_office,
       sp.supplier_site,
       sp.supplier_product,
       sp.file_remark,
       --其他
       sp.supplier_info_origin,
       sp.status
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
 INNER JOIN group_dict ga
    ON sp.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = ''COOPERATION_TYPE''
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''COOPERATION_BRAND''
   AND gd.group_dict_value = sp.cooperation_brand
 WHERE sp.supplier_info_id = %ass_supplier_info_id%  --nvl(substr(%ass_supplier_info_id%,1,instr(%ass_supplier_info_id%,'';'')-1),%ass_supplier_info_id%)
   AND sp.company_id = %default_company_id%';
  v_u_sql := '{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN
  --来源为准入/手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%
     AND sp.status = 0;

  v_sql := q''[DECLARE
  v_sp_data t_supplier_info%ROWTYPE;
BEGIN
  --待建档数据
  v_sp_data.supplier_info_id := :supplier_info_id;
  v_sp_data.company_id       := :company_id;
  v_sp_data.status           := :status;
  v_sp_data.supplier_info_origin := '']'' || v_origin || q''['' ;
  --来源为准入 统一社会信用代码则 不可更改
  --来源为手动新增 待建档：统一社会信用代码 可以更改 ，已建档 不可以更改
  ]'' || CASE
             WHEN v_origin = ''MA'' THEN
              ''
               v_sp_data.social_credit_code            := :social_credit_code;
               ''
             ELSE
              ''''
           END || q''[
  --基本信息
  v_sp_data.supplier_company_name         := :supplier_company_name;
  v_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  v_sp_data.legal_representative := :legal_representative;
  v_sp_data.inside_supplier_code := :inside_supplier_code;
  v_sp_data.company_province     := :company_province;
  v_sp_data.company_city         := :company_city;
  v_sp_data.company_county       := :company_county;
  v_sp_data.company_address      := :company_address_sp;
  v_sp_data.group_name            := :group_name;
  v_sp_data.company_contact_phone := :company_contact_phone;
  v_sp_data.fa_contact_name       := :fa_contact_name;
  v_sp_data.fa_contact_phone      := :fa_contact_phone;
  v_sp_data.company_type          := :company_type;
  --生产信息
  v_sp_data.product_type        := :product_type;
  v_sp_data.product_link        := :product_link;
  v_sp_data.brand_type          := :brand_type;
  v_sp_data.cooperation_brand   := :cooperation_brand;
  v_sp_data.product_line        := :product_line;
  v_sp_data.product_line_num    := :product_line_num;
  v_sp_data.worker_num          := :worker_num;
  v_sp_data.machine_num         := :machine_num;
  v_sp_data.quality_step        := :quality_step;
  v_sp_data.pattern_cap         := :pattern_cap;
  v_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  v_sp_data.fabric_check_cap    := :fabric_check_cap;
  v_sp_data.cost_step           := :cost_step;
  v_sp_data.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  v_sp_data.product_efficiency  := rtrim(:product_efficiency,''%'');
  v_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  v_sp_data.pause               := :coop_state;
  v_sp_data.pause_cause         := NULL;
  --v_sp_data.cooperation_type  := :cooperation_type;
  v_sp_data.cooperation_model := :cooperation_model;
  IF instr(:cooperation_model,''OF'')> 0 THEN
  v_sp_data.coop_position     := ''外协厂'';
  ELSE
  IF :coop_position IS NULL THEN
  v_sp_data.coop_position     := ''普通型'';
  ELSE
  v_sp_data.coop_position     := :coop_position;
  END IF;
  END IF;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
  v_sp_data.ask_files := :ASK_FILES_SP;
  v_sp_data.supplier_gate    := :supplier_gate;
  v_sp_data.supplier_office  := :supplier_office;
  v_sp_data.supplier_site    := :supplier_site;
  v_sp_data.supplier_product := :supplier_product;
  v_sp_data.company_say      := :company_say;
  v_sp_data.file_remark      := :file_remark;
  v_sp_data.update_id        := :user_id;
  v_sp_data.update_date      := SYSDATE;
  --1.更新=》保存，校验数据
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data,p_item_id => ''a_supp_161'');

  --3.启停合作工厂关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => :supplier_info_id);
  
  
  --zwh73 qc工厂
  scmdata.pkg_qcfactory_config.p_change_qc_factory_config_by_area_change(p_supplier_info        => :supplier_info_id,
                                                                         p_old_company_province => :old_company_province,
                                                                         p_old_company_city     => :old_company_city,
                                                                         p_new_company_province => :company_province,
                                                                         p_new_company_city     => :company_city);
  --zc314 add
  SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                V_TAB        => ''SCMDATA.T_SUPPLIER_INFO'',
                                                V_VIEWTAB    => NULL,
                                                V_UNQFIELDS  => ''SUPPLIER_INFO_ID,COMPANY_ID'',
                                                V_CKFIELDS   => ''WORKER_NUM,WORK_HOURS_DAY,PRODUCT_EFFICIENCY,UPDATE_ID,UPDATE_DATE'',
                                                V_CONDS      => ''SUPPLIER_INFO_ID = ''''''||:SUPPLIER_INFO_ID||'''''' AND COMPANY_ID = ''''''||%DEFAULT_COMPANY_ID%||'''''''',
                                                V_METHOD     => ''UPD'',
                                                V_VIEWLOGIC  => NULL,
                                                V_QUEUETYPE  => ''CAPC_SUPCAPCAPP_INFO_U'');
  
END;]'';
  @strresult := v_sql;
END;}';
  v_ns_fileds := 'supplier_info_id,company_id,supplier_info_origin_id,taxpayer,cooperation_classification,cooperation_subcategory,cooperation_method,cooperation_model,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,province,city,county,company_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,BIND_STATUS,FA_BRAND_TYPE,GROUP_NAME';
  
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql,t.update_sql = v_u_sql,t.noshow_fields = v_ns_fileds,t.noedit_fields = 'group_name' WHERE t.item_id = 'a_supp_161';
END;
/
DECLARE
  v_sql CLOB;
  v_i_sql CLOB;
  v_u_sql CLOB;
BEGIN
  v_sql := '--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_query_sup_coop_list(p_item_id => ''a_supp_161_1''); 
  @strresult := v_sql;
END;}';
  v_i_sql := '--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_insert_sup_coop_list(p_item_id => ''a_supp_161_1''); 
  @strresult := v_sql;
END;}';
  v_u_sql := '--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_update_sup_coop_list(p_item_id => ''a_supp_161_1''); 
  @strresult := v_sql;
END;}';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql,t.insert_sql = v_i_sql,t.update_sql = v_u_sql WHERE t.item_id = 'a_supp_161_1';
END;
/
DECLARE
  v_sql CLOB;
  v_i_sql CLOB;
  v_u_sql CLOB;
  v_ns_fileds CLOB;
BEGIN
  v_sql := '--czh 重构代码
--过期时间 15分钟
{DECLARE
  v_select_sql VARCHAR2(8000);
BEGIN
  --基本信息 
  v_select_sql := q''[WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
--基本信息
SELECT sp.supplier_info_id,
       sp.company_id,
       sp.supplier_info_origin_id,
       sp.supplier_company_name,
       sp.supplier_company_abbreviation,
       sp.supplier_code,
       sp.social_credit_code,
       sp.legal_representative,
       sp.inside_supplier_code,
       sp.company_province company_province,
       sp.company_city company_city,
       sp.company_county company_county,
       province || city || county location_area,
       nvl(sp.company_address, fc.address) company_address_sp,
       --pkg_supplier_info.get_group_name(p_company_id => %default_company_id%,
       --p_supp_id    => sp.supplier_info_id) group_name,
       sp.group_name,
       sp.area_group_leader,
       sp.company_contact_phone,
       sp.fa_contact_name,
       sp.fa_contact_phone,
       sp.company_type,
       --生产信息 
       sp.product_type,
       sp.product_link,
       sp.brand_type,
       sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, '';'') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = ''COOPERATION_BRAND''
           AND t.group_dict_id = b.parent_id
           AND instr('';'' || sp.brand_type || '';'',
                     '';'' || t.group_dict_value || '';'') > 0
           AND instr('';'' || sp.cooperation_brand || '';'',
                     '';'' || b.group_dict_value || '';'') > 0) cooperation_brand_desc,
       sp.product_line,
       sp.product_line_num,
       sp.worker_num,
       sp.machine_num,
       sp.quality_step,
       sp.pattern_cap,
       sp.fabric_purchase_cap,
       sp.fabric_check_cap,
       sp.cost_step,
       --decode(sp.reserve_capacity, NULL, '''', sp.reserve_capacity || ''%'') reserve_capacity,
       decode(sp.product_efficiency, NULL, ''80%'', sp.product_efficiency || ''%'') product_efficiency,
       sp.work_hours_day,
       --合作信息 
       sp.pause coop_state,
       nvl2(sp.supplier_company_id, ''已注册'', ''未注册'') regist_status_sp,
       decode(sp.bind_status, 1, ''已绑定'', ''未绑定'') bind_status_sq,
       sp.cooperation_type,
       sp.cooperation_model,
       sp.coop_position,
       --附件资料 
       sp.certificate_file certificate_file_sp,
       sp.ask_files ASK_FILES_SP,
       sp.supplier_gate,
       sp.supplier_office,
       sp.supplier_site,
       sp.supplier_product,
       sp.file_remark,
       --其他 
       sp.supplier_info_origin,
       sp.status
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
 INNER JOIN group_dict ga
    ON sp.cooperation_type = ga.group_dict_value
   AND ga.group_dict_type = ''COOPERATION_TYPE''
  LEFT JOIN group_dict gd
    ON gd.group_dict_type = ''COOPERATION_BRAND''
   AND gd.group_dict_value = sp.cooperation_brand
 WHERE sp.company_id = %default_company_id%
   AND sp.create_id  = :user_id
   AND sp.supplier_info_origin = ''MA''
   AND sp.status = 0 
   AND (ceil(TO_NUMBER(SYSDATE - sp.create_date)*(24*60)) <= 15 or ceil(TO_NUMBER(SYSDATE - sp.update_date)*(24*60)) <= 15) 
 ORDER BY sp.create_date DESC, sp.update_date DESC ]'';
  :StrResult:= v_select_sql;  
END;
}';
  v_i_sql := '--不考虑供应商是否已经在平台注册
DECLARE
  p_sp_data    scmdata.t_supplier_info%ROWTYPE;
  vo_group_name            VARCHAR2(32);
  vo_area_group_leader     VARCHAR2(32);
BEGIN

  p_sp_data.supplier_info_id := scmdata.pkg_plat_comm.f_getkeyid_plat(''GY'',''seq_plat_code'',99);
  p_sp_data.company_id       := %default_company_id%;
  --基本信息
  p_sp_data.supplier_company_name         := :supplier_company_name;
  p_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  --p_sp_data.supplier_code                 := :supplier_code;
  p_sp_data.inside_supplier_code          := :inside_supplier_code;
  p_sp_data.social_credit_code            := :social_credit_code;
  p_sp_data.legal_representative          := :legal_representative;
  p_sp_data.inside_supplier_code          := :inside_supplier_code;
  p_sp_data.company_province              := :company_province;
  p_sp_data.company_city                  := :company_city;
  p_sp_data.company_county                := :company_county;
  p_sp_data.company_address               := :company_address_sp;
  p_sp_data.group_name                    := :v_group_name;
  p_sp_data.company_contact_phone         := :company_contact_phone;
  p_sp_data.fa_contact_name               := :fa_contact_name;
  p_sp_data.fa_contact_phone              := :fa_contact_phone;
  p_sp_data.company_type                  := :company_type;
  --生产信息
  p_sp_data.product_type        := :product_type;
  p_sp_data.product_link        := :product_link;
  p_sp_data.brand_type          := :brand_type;
  p_sp_data.cooperation_brand   := :cooperation_brand;
  p_sp_data.product_line        := :product_line;
  p_sp_data.product_line_num    := :product_line_num;
  p_sp_data.worker_num          := :worker_num;
  p_sp_data.machine_num         := :machine_num;
  p_sp_data.quality_step        := :quality_step;
  p_sp_data.pattern_cap         := :pattern_cap;
  p_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  p_sp_data.fabric_check_cap    := :fabric_check_cap;
  p_sp_data.cost_step           := :cost_step;
  p_sp_data.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  p_sp_data.product_efficiency  := rtrim(:product_efficiency,''%'');
  p_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  p_sp_data.pause               := :coop_state;
  p_sp_data.cooperation_model   := :cooperation_model;
  --平台注册状态
  --应用绑定状态
  p_sp_data.cooperation_type  := :cooperation_type;
  p_sp_data.cooperation_model := :cooperation_model;
  IF instr(:cooperation_model,''OF'')> 0 THEN
  p_sp_data.coop_position     := ''外协厂'';
  ELSE
  IF :coop_position IS NULL THEN
  p_sp_data.coop_position     := ''普通型'';
  ELSE
  p_sp_data.coop_position     := :coop_position;
  END IF;
  END IF;
  --相关附件
  p_sp_data.certificate_file := :certificate_file_sp;
  p_sp_data.ask_files := :ASK_FILES_SP;
  p_sp_data.supplier_gate    := :supplier_gate;
  p_sp_data.supplier_office  := :supplier_office;
  p_sp_data.supplier_site    := :supplier_site;
  p_sp_data.supplier_product := :supplier_product;
  p_sp_data.file_remark      := :file_remark;

  p_sp_data.company_say          := :company_say;
  p_sp_data.create_id            := :user_id;
  p_sp_data.create_date          := SYSDATE;
  p_sp_data.supplier_info_origin := ''MA'';
  p_sp_data.status               := 0;

  --1.新增 => 保存，校验数据
  scmdata.pkg_supplier_info.check_save_t_supplier_info(p_sp_data => p_sp_data);
  --2.插入数据
  scmdata.pkg_supplier_info.insert_supplier_info(p_sp_data => p_sp_data);

END;';
  v_u_sql := '{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN
  --来源为手动新增
  SELECT MAX(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%
     AND sp.status = 0;

  v_sql := q''[DECLARE
  v_sp_data t_supplier_info%ROWTYPE;
BEGIN
  --待建档数据
  v_sp_data.supplier_info_id := :supplier_info_id;
  v_sp_data.company_id       := :company_id;
  v_sp_data.status           := :status;
  v_sp_data.supplier_info_origin := '']'' || v_origin || q''['' ;
  --来源为a_supp_171-手动新增 则供应商名称、简称和统一社会信用代码 可更改

  --基本信息
  v_sp_data.supplier_company_name         := :supplier_company_name;
  v_sp_data.supplier_company_abbreviation := :supplier_company_abbreviation;
  v_sp_data.social_credit_code            := :social_credit_code;
  v_sp_data.legal_representative := :legal_representative;
  v_sp_data.inside_supplier_code := :inside_supplier_code;
  v_sp_data.company_province     := :company_province;
  v_sp_data.company_city         := :company_city;
  v_sp_data.company_county       := :company_county;
  v_sp_data.company_address      := :company_address_sp;
  --v_sp_data.group_name                    := :group_name;
  v_sp_data.company_contact_phone := :company_contact_phone;
  v_sp_data.fa_contact_name       := :fa_contact_name;
  v_sp_data.fa_contact_phone      := :fa_contact_phone;
  v_sp_data.company_type          := :company_type;
  --生产信息
  v_sp_data.product_type        := :product_type;
  v_sp_data.product_link        := :product_link;
  v_sp_data.brand_type          := :brand_type;
  v_sp_data.cooperation_brand   := :cooperation_brand;
  v_sp_data.product_line        := :product_line;
  v_sp_data.product_line_num    := :product_line_num;
  v_sp_data.worker_num          := :worker_num;
  v_sp_data.machine_num         := :machine_num;
  v_sp_data.quality_step        := :quality_step;
  v_sp_data.pattern_cap         := :pattern_cap;
  v_sp_data.fabric_purchase_cap := :fabric_purchase_cap;
  v_sp_data.fabric_check_cap    := :fabric_check_cap;
  v_sp_data.cost_step           := :cost_step;
  v_sp_data.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  v_sp_data.product_efficiency  := rtrim(:product_efficiency,''%'');
  v_sp_data.work_hours_day      := :work_hours_day;
  --合作信息
  v_sp_data.pause               := :coop_state;
  --v_sp_data.cooperation_type  := :cooperation_type;
  v_sp_data.cooperation_model := :cooperation_model;
  IF instr(:cooperation_model,''OF'')> 0 THEN
  v_sp_data.coop_position     := ''外协厂'';
  ELSE
  IF :coop_position IS NULL THEN
  v_sp_data.coop_position     := ''普通型'';
  ELSE
  v_sp_data.coop_position     := :coop_position;
  END IF;
  END IF;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
  v_sp_data.ask_files := :ASK_FILES_SP;
  v_sp_data.supplier_gate    := :supplier_gate;
  v_sp_data.supplier_office  := :supplier_office;
  v_sp_data.supplier_site    := :supplier_site;
  v_sp_data.supplier_product := :supplier_product;
  v_sp_data.company_say      := :company_say;
  v_sp_data.file_remark      := :file_remark;
  v_sp_data.update_id        := :user_id;
  v_sp_data.update_date      := SYSDATE;

  --1.更新=》保存，校验数据
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data);

END;]'';
  @strresult := v_sql;
END;}';
  v_ns_fileds := 'supplier_info_id,company_id,supplier_info_origin_id,cooperation_classification,cooperation_subcategory,taxpayer,cooperation_method,cooperation_model,company_type,cooperation_type,production_mode,cooperation_method_sp,production_mode_sp,pay_type,settlement_type,sharing_type,coop_state,PRODUCT_TYPE,PRODUCT_LINK,BRAND_TYPE,PRODUCT_LINE,QUALITY_STEP,PATTERN_CAP,FABRIC_PURCHASE_CAP,FABRIC_CHECK_CAP,COST_STEP,GROUP_NAME';
  UPDATE bw3.sys_item_list t SET t.select_sql = v_sql,t.insert_sql = v_i_sql,t.update_sql = v_u_sql,t.noshow_fields = v_ns_fileds WHERE t.item_id = 'a_supp_171';
END;
/
BEGIN
  insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE)
values ('look_a_supp_151', 'lookup', 'oracle_scmdata', 0, null, null, null, null, NULL);

insert into bw3.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_supp_151', 'GROUP_NAME_DESC', 'SELECT t.group_name group_name_desc, t.group_config_id group_name
  FROM scmdata.t_supplier_group_config t
 WHERE t.company_id = %default_company_id%
 AND t.pause = 1', '1', 'GROUP_NAME', 'GROUP_NAME_DESC', 'GROUP_NAME', null, null, null, null, null, null, null, null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_161', 'look_a_supp_151', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_171', 'look_a_supp_151', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_160', 'look_a_supp_151', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151', 'look_a_supp_151', 1, 0, null);

END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'BEGIN
  pkg_a_config_lib.p_pause_area_config(p_company_id           => %default_company_id%,
                                       p_group_area_config_id => :group_area_config_id,
                                       p_field                => ''pause'',
                                       p_user_id              => :user_id,
                                       p_status               => 0);
END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_coop_162_2';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := '--修改：启用、停用增加输入原因
DECLARE
BEGIN

  pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                p_reason           => @D_REASON_SP@,
                                                p_status           => 0,
                                                p_user_id          => :user_id,
                                                p_company_id       => %default_company_id%);
  --启停合作工厂关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,
                                          p_sup_id     => %selection%);

  --zc314 add
  FOR I IN (SELECT SUPPLIER_INFO_ID, COMPANY_ID, supplier_code
              FROM SCMDATA.T_SUPPLIER_INFO
             WHERE SUPPLIER_INFO_ID IN (%SELECTION%)
               AND COMPANY_ID = %DEFAULT_COMPANY_ID%) LOOP
    SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID => %CURRENT_USERID%,
                                                  V_COMPID    => %DEFAULT_COMPANY_ID%,
                                                  V_TAB       => ''SCMDATA.T_SUPPLIER_INFO'',
                                                  V_VIEWTAB   => NULL,
                                                  V_UNQFIELDS => ''SUPPLIER_INFO_ID,COMPANY_ID'',
                                                  V_CKFIELDS  => ''PAUSE,UPDATE_ID,UPDATE_DATE'',
                                                  V_CONDS     => ''SUPPLIER_INFO_ID = '''''' ||
                                                                 I.SUPPLIER_INFO_ID ||
                                                                 '''''' AND COMPANY_ID = '''''' ||
                                                                 I.COMPANY_ID || '''''''',
                                                  V_METHOD    => ''UPD'',
                                                  V_VIEWLOGIC => NULL,
                                                  V_QUEUETYPE => ''CAPC_SUPCAPCAPP_INFO_U'');

    --zwh73 qc工厂配置禁用
    scmdata.pkg_qcfactory_config.p_status_qc_factory_config_by_factory(p_factory_code => i.supplier_code,
                                                                       p_company_id   => i.company_id,
                                                                       p_status       => 0);
  END LOOP;
END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_supp_160_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := '
--修改：启用、停用增加输入原因
DECLARE
BEGIN

  pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                p_reason           => @D_REASON_SP@,
                                                p_status           => 1,
                                                p_user_id          => :user_id,
                                                p_company_id       => %default_company_id%);
  --启停合作工厂关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => %selection%);

  --zc314 add
  FOR I IN (SELECT SUPPLIER_INFO_ID,COMPANY_ID, supplier_code
              FROM SCMDATA.T_SUPPLIER_INFO
             WHERE SUPPLIER_INFO_ID IN (%SELECTION%)
               AND COMPANY_ID = %DEFAULT_COMPANY_ID%) LOOP
    SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                  V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                  V_TAB        => ''SCMDATA.T_SUPPLIER_INFO'',
                                                  V_VIEWTAB    => NULL,
                                                  V_UNQFIELDS  => ''SUPPLIER_INFO_ID,COMPANY_ID'',
                                                  V_CKFIELDS   => ''PAUSE,UPDATE_ID,UPDATE_DATE'',
                                                  V_CONDS      => ''SUPPLIER_INFO_ID = ''''''||I.SUPPLIER_INFO_ID||'''''' AND COMPANY_ID = ''''''||I.COMPANY_ID||'''''''',
                                                  V_METHOD     => ''UPD'',
                                                  V_VIEWLOGIC  => NULL,
                                                  V_QUEUETYPE  => ''CAPC_SUPCAPCAPP_INFO_U'');

                                                  --zwh73 qc工厂配置禁用
    scmdata.pkg_qcfactory_config.p_status_qc_factory_config_by_factory(p_factory_code => i.supplier_code,
                                                                       p_company_id   => i.company_id,
                                                                       p_status       => 1);
  END LOOP;
END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_supp_160_2';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (@selection)) LOOP
  
    v_supplier_info_id := supplier_info_rec.supplier_info_id;
    
    pkg_supplier_info.update_supp_info_bind_status(p_supplier_info_id => v_supplier_info_id,
                                                      p_status           => 1,
                                                      p_user_id          => :user_id,
                                                      p_company_id       => %default_company_id%);
  
  END LOOP;

END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_supp_160_3';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_supplier_info_id VARCHAR2(100);
BEGIN
  FOR supplier_info_rec IN (SELECT sp.supplier_info_id
                              FROM scmdata.t_supplier_info sp
                             WHERE sp.supplier_info_id IN (@selection)) LOOP
  
    v_supplier_info_id := supplier_info_rec.supplier_info_id;
    pkg_supplier_info.update_supp_info_bind_status(p_supplier_info_id => v_supplier_info_id,
                                                      p_status           => 0,
                                                      p_user_id          => :user_id,
                                                      p_company_id       => %default_company_id%);
  
  END LOOP;

END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_supp_160_4';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_flw_order     VARCHAR2(4000);
  v_reason        VARCHAR2(256);
  v_gendan_name_n VARCHAR2(256);
  v_old_gendan    VARCHAR2(4000);
  vo_log_id       VARCHAR2(32);
BEGIN
  --跟单员
  v_flw_order := @flw_order@;

  --变更后
  SELECT listagg(nvl(fc.nick_name, fc.company_user_name), '','') gendan_name_n
    INTO v_gendan_name_n
    FROM scmdata.sys_company_user fc
   WHERE fc.company_id = %default_company_id%
     AND instr(@flw_order@, fc.user_id) > 0;

  FOR i IN (SELECT t.supplier_info_id, t.gendan_perid
              FROM scmdata.t_supplier_info t
             WHERE t.supplier_info_id IN (%selection%)
               AND t.company_id = %default_company_id%) LOOP
  
    --变更前的跟单
    v_old_gendan := scmdata.pkg_plat_comm.f_get_username(p_user_id         => i.gendan_perid,
                                                         p_company_id      => %default_company_id%,
                                                         p_is_company_user => 1,
                                                         p_is_mutival      => 1);
  
    --更新进表     
    UPDATE scmdata.t_supplier_info t
       SET t.gendan_perid = v_flw_order
     WHERE t.supplier_info_id = i.supplier_info_id;
  
  END LOOP;
END;';
  UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_supp_160_5';
END;
/
BEGIN
UPDATE bw3.sys_field_list t SET t.requiered_flag = 0 WHERE t.field_name = 'GROUP_NAME';
END;
/
