begin
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('ASK_FILES_SP', '验厂申请附件', 0, null, null, null, null, null, 0, 0, 0, 0, 0, 3, null, null, null, null, null, '50', null, null, null, 0, 0, null, null, null, null, null, null, null, null, 20, null, null, null, null, null, null, null, 'MONGO#DEV', null);
end;
/
declare
v_sql1 clob;
v_sql2 clob;
begin
v_sql1 := 'WITH group_dict AS
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
v_sql2 := '{DECLARE
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
  --2.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => :supplier_info_id);
END;]'';
  @strresult := v_sql;
END;}';
update bw3.sys_item_list t set t.select_sql = v_sql1,t.update_sql = v_sql2 where t.item_id = 'a_supp_151'; 
end;
/
declare
v_sql1 clob;
v_sql2 clob;
begin
v_sql1 := 'WITH group_dict AS
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
v_sql2 := '{DECLARE
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
  pkg_supplier_info.update_supplier_info(p_sp_data => v_sp_data,p_item_id => ''a_supp_161'');
  --2.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => :supplier_info_id);
  --3.启停合作工厂关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => :supplier_info_id);
END;]'';
  @strresult := v_sql;
END;}';
update bw3.sys_item_list t set t.select_sql = v_sql1,t.update_sql = v_sql2 where t.item_id = 'a_supp_161'; 
end;
/
declare
v_sql1 clob;
v_sql2 clob;
v_sql3 clob;
begin
v_sql1 := '--czh 重构代码
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
v_sql2 := '--不考虑供应商是否已经在平台注册
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
  --3.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => p_sp_data.supplier_info_id);

END;';
v_sql3 := '{DECLARE
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
  --2.更新所在区域 区域组长
  pkg_supplier_info.update_group_name(p_company_id       => %default_company_id%,
                                      p_supplier_info_id => :supplier_info_id);
END;]'';
  @strresult := v_sql;
END;}';
update bw3.sys_item_list t set t.select_sql = v_sql1,t.insert_sql = v_sql2,t.update_sql = v_sql3 where t.item_id = 'a_supp_171'; 
end;
