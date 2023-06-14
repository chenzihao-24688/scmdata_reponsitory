--禁用分组
BEGIN
 update bw3.sys_detail_group t  set t.pause = 1  where t.item_id = 'a_coop_151' and t.group_name = '公司信息';
 update bw3.sys_detail_group t  set t.pause = 1  where t.item_id = 'a_coop_151' and t.group_name = '意向信息';
 UPDATE bw3.sys_detail_group t SET t.pause = 1 WHERE t.item_id IN ('a_coop_150_3','a_coop_221', 'a_coop_211', 'a_coop_311','a_coop_105') AND t.group_name = '需求信息';
 update bw3.sys_item_rela t set t.pause = 1 where t.item_id = 'a_check_101_1' and t.relate_id in ('a_coop_159_2','a_coop_211');
 UPDATE bw3.sys_detail_group t SET t.pause = 1 WHERE t.item_id IN ('a_check_102_1') AND t.group_name = '验厂申请单信息';
 update bw3.sys_item_rela t set t.pause = 1 where t.item_id = 'a_check_102_1' and t.relate_id in ('a_check_102_2','a_check_102_4','a_coop_159_2');
 update bw3.sys_item_rela t set t.pause = 1 where t.item_id = 'a_coop_105' and t.relate_id in ('a_coop_312_1','a_coop_312_2','a_coop_312_3');
 update bw3.sys_tree_list t set t.pause = 1 where t.node_id = 'node_a_coop_312' ;
 update bw3.sys_detail_group t set t.pause = 1 where t.item_id = 'a_coop_150_6'  and t.group_name = '公司信息';
 update bw3.sys_detail_group t set t.pause = 1 where t.item_id = 'a_coop_150_6'  and t.group_name = '意向信息';
 update bw3.sys_field_list t set t.check_express = '^((13[0-9])|(14([1]|[4-9]))|(15([0-3]|[5-9]))|(16([2]|[5-7]))|(17([0-3]|[5-8]))|(18[0-9])|(19[1-9]))\d{8}$'  where t.field_name in ('CHECK_PERSON1_PHONE','CHECK_PERSON2_PHONE');
 update  bw3.sys_field_list t SET t.check_express = '^[1-9]\d*|0$' where t.field_name = 'WORKER_NUM';
 update bw3.sys_field_list t set t.data_type = 28  where t.field_name = 'CHECK_REPORT_FILE';
 update bw3.sys_cond_rela t set t.pause = 1 where t.cond_id = 'cond_a_check_101_1_1';
 update bw3.sys_item_rela t set t.pause = 1  where t.item_id = 'a_supp_161' and t.relate_id = 'a_supp_161_2' ;
 update bw3.sys_item_rela t set t.pause = 1  where t.item_id = 'a_supp_171' and t.relate_id = 'a_supp_151_8' ;
 update bw3.sys_field_list t set t.check_express = '^[0-9]*[\.]?[0-9]*[\%]?$' where t.field_name in ('RESERVE_CAPACITY','PRODUCT_EFFICIENCY');
 insert into bw3.sys_link_list (ITEM_ID, FIELD_NAME, TO_ITEM_ID, NULL_ITEM_ID, PAUSE)values ('a_supp_151_2', 'CHECK_REPORT', 'a_coop_105', null, 0);
END;
/
--意向合作类型
declare
v_sql clob;
begin
v_sql := q'[SELECT GROUP_DICT_VALUE COOPERATION_TYPE,
       GROUP_DICT_NAME  COOPERATION_TYPE_DESC
  FROM SCMDATA.SYS_GROUP_DICT
 WHERE GROUP_DICT_TYPE = 'COOPERATION_TYPE'
 AND pause = 0]';
 
 update bw3.sys_look_up t set t.look_up_sql = v_sql where t.element_id = 'lookup_a_coop_151_0' ;
end;
/
--意向合作模式
DECLARE
v_sql clob;
BEGIN
v_sql :=q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_ask_record_mange.f_query_supply_type_looksql(p_supply_type_field => 'COOPERATION_MODEL',p_suffix => '_DESC');
  @strresult := v_sql;
END;}]';
update bw3.sys_look_up t set t.look_up_sql=v_sql,t.before_field = 'COOPERATION_MODEL',t.multi_value_flag = 1,t.value_sep = ';',t.disabled_field = 0 where t.element_id = 'coop_model' ;
END;
/
--合作分类 子类
BEGIN
  update bw3.sys_pick_list t set t.from_field = 'COOPERATION_CLASSIFICATION_DES',t.multi_value_flag = 0, t.recursion_flag = 0 where t.element_id ='picklist_cateAprocate';
  update bw3.sys_pick_list t set t.from_field = 'COOPERATION_SUBCATEGORY_DESC',t.recursion_flag = 0 where t.element_id ='picklist_subcate';
END;  
/
begin
 update bw3.sys_field_list t set t.caption = '公司联系电话' where t.field_name = 'COMPANY_CONTACT_PHONE';
 update bw3.sys_field_list t set t.caption = '业务联系人' where t.field_name = 'ASK_USER_NAME';
 update bw3.sys_field_list t set t.caption = '业务联系电话' where t.field_name = 'ASK_USER_PHONE';
 update bw3.sys_field_list t set t.check_express = '^[1-9][0-9]{0,}$' where t.field_name = 'WORKER_NUM';
end;
/
--供应商档案-已建档详情查看
declare
v_sql clob;
begin
  v_sql := '{DECLARE
  v_sql CLOB;
  v_origin  VARCHAR2(32);
BEGIN  
    --来源为准入/手动新增  
  SELECT MAX(sp.supplier_info_origin)
    INTO v_origin
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%
     AND sp.status = 1;
     
  v_sql := q''[DECLARE 
  v_sp_data t_supplier_info%ROWTYPE;
BEGIN
  --已建档数据     
  v_sp_data.supplier_info_id := :supplier_info_id;
  v_sp_data.company_id       := :company_id;
  v_sp_data.status           := :status;
  v_sp_data.supplier_info_origin := '']'' || v_origin || q''['' ;
  --来源为准入/手动新增 统一社会信用代码则 不可更改
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
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
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
END;]'';
  @strresult := v_sql;
END;}';
  update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_supp_161' ;
end;
/
declare
v_sql clob;
begin
v_sql := '{DECLARE
  v_query_sql CLOB;
  v_province_id CLOB;
BEGIN
  IF instr(:is_province_allcity,''1'') > 0 THEN
  v_province_id := :province_id;
    v_query_sql := q''[SELECT xmlagg(xmlparse(content group_area || '';'') ORDER BY provinceid).getclobval() group_area,
       listagg(province_id, '';'') province_id,
       listagg(city_id, '';'') city_id
  FROM (SELECT listagg(a.province || b.city, '';'') group_area,
               listagg(DISTINCT a.provinceid, '';'') province_id,
               listagg(b.cityno, '';'') city_id,
               a.provinceid
          FROM scmdata.dic_province a
          LEFT JOIN scmdata.dic_city b
            ON a.provinceid = b.provinceid
         GROUP BY a.provinceid)
 WHERE instr('']''||v_province_id||q''['', provinceid) > 0]'';
  ELSE
  v_query_sql := q''[SELECT '''' city_id,'''' group_area
  FROM DUAL]'';
  END IF;

  @strresult := v_query_sql;
END;}';
update bw3.sys_assign t set t.assign_sql = v_sql where t.element_id = 'assign_a_coop_162_1';
end;
/
--指定跟單員
begin
insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('FLW_ORDER', 'oracle_scmdata', '跟单员', '{DECLARE
  v_query_sql CLOB;
  v_flag      NUMBER;
BEGIN
  SELECT COUNT(DISTINCT coop_classification) INTO v_flag
  FROM (SELECT listagg(DISTINCT sa.coop_classification, '';'') within GROUP(ORDER BY sa.coop_classification) coop_classification
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_coop_scope sa
            ON sa.company_id = sp.company_id
           AND sa.supplier_info_id = sp.supplier_info_id
         WHERE sp.supplier_info_id IN (@selection)
         GROUP BY sp.supplier_info_id);
  IF v_flag > 1 THEN
  raise_application_error(-20002,
                                ''所选供应商的合作分类不一致,指派跟单员失败！'');
  ELSE
     @strresult := '''';                                                         
  END IF;
END;}', '{DECLARE
  v_query_sql CLOB;
  v_type      VARCHAR2(32);
  v_cate      VARCHAR2(32);
BEGIN
  SELECT listagg(DISTINCT sp.cooperation_type, '';''),
         listagg(DISTINCT sa.coop_classification, '';'') within GROUP(ORDER BY sa.coop_classification) coop_classification
    INTO v_type, v_cate
    FROM scmdata.t_supplier_info sp
    LEFT JOIN scmdata.t_coop_scope sa
      ON sa.company_id = sp.company_id
     AND sa.supplier_info_id = sp.supplier_info_id
   WHERE sp.supplier_info_id IN (@selection);
  v_query_sql := pkg_supplier_info.f_query_person_info_looksql(p_person_field => ''FLW_ORDER'',
                                                               p_suffix       => ''_NAME'',
                                                               p_coop_type    => v_type,
                                                               p_coop_cate    => v_cate);

  @strresult := v_query_sql;
END;
}


/*SELECT d.dept_name,
       b.avatar,
       a.user_id           flw_order,
       a.company_user_name flw_order_name
  FROM sys_company_user a
 INNER JOIN sys_user b
    ON a.user_id = b.user_id
  LEFT JOIN sys_company_user_dept c
    ON a.user_id = c.user_id
   AND a.company_id = c.company_id
  LEFT JOIN sys_company_dept d
    ON c.company_dept_id = d.company_dept_id
   AND c.company_id = d.company_id
 WHERE a.company_id = %default_company_id%
   AND a.pause = 0
   AND b.pause = 0*/', 0, null, null, 0, null, null, null, null, null, null, null, null, ',', 1);
end;
/
--新增供应商档案-详情修改
declare
v_sql clob;
begin
 v_sql := '{DECLARE
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
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
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
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_supp_151';
end;
/
declare
v_sql clob;
begin
 v_sql := '{DECLARE
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
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
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
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_supp_161';
end;
/
declare
v_sql clob;
begin
 v_sql := '{DECLARE
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
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
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
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_supp_171';
end;
/
--供应商合作状态
begin
update scmdata.sys_group_dict t set t.group_dict_name= '正常',t.group_dict_value='0' where t.group_dict_type = 'COOP_STATUS' and t.group_dict_id = 'aec44ecec4670e76e0533c281cac5235';
update scmdata.sys_group_dict t set t.group_dict_name= '停用',t.group_dict_value='1' where t.group_dict_type = 'COOP_STATUS' and t.group_dict_id = 'aec44ecec4680e76e0533c281cac5235';
update scmdata.sys_group_dict t set t.group_dict_name= '试单',t.group_dict_value='2' where t.group_dict_type = 'COOP_STATUS' and t.group_dict_id = 'ccb94c0a41756768e0533c281cac12cc';
end;
/
--新增意向供应商 工厂信息 update_sql
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := '--czh 20211016重构代码
DECLARE
  p_fa_rec scmdata.t_factory_ask%ROWTYPE;
BEGIN
  --验厂申请
  --申请信息
  p_fa_rec.ask_date          := :factory_ask_date;
  p_fa_rec.is_urgent         := :is_urgent;
  p_fa_rec.cooperation_model := :cooperation_model;
  p_fa_rec.product_type      := :product_type;
  p_fa_rec.ask_say           := :checkapply_intro;
  --供应商基本信息
  p_fa_rec.factory_ask_id       := :factory_ask_id;
  p_fa_rec.company_name         := :ask_company_name;
  p_fa_rec.company_abbreviation := :company_abbreviation;
  --p_fa_rec.social_credit_code    := :social_credit_code;
  p_fa_rec.company_province := :company_province;
  p_fa_rec.company_city     := :company_city;
  p_fa_rec.company_county   := :company_county;
  p_fa_rec.company_address  := nvl(:company_address, :pcc);
  p_fa_rec.factory_name     := :factory_name;
  p_fa_rec.factory_province := :factory_province;
  p_fa_rec.factory_city     := :factory_city;
  p_fa_rec.factory_county   := :factory_county;
  p_fa_rec.ask_address      := nvl(:ask_address, :fpcc);
  p_fa_rec.legal_representative  := :legal_representative;
  p_fa_rec.company_contact_phone := :company_contact_phone;
  p_fa_rec.contact_name          := :ask_user_name;
  p_fa_rec.contact_phone         := :ask_user_phone;
  p_fa_rec.company_type          := :company_type;
  p_fa_rec.brand_type            := :brand_type;
  p_fa_rec.cooperation_brand     := :cooperation_brand;
  p_fa_rec.com_manufacturer      := :com_manufacturer;
  p_fa_rec.certificate_file      := :certificate_file;
  p_fa_rec.supplier_gate         := :supplier_gate;
  p_fa_rec.supplier_office       := :supplier_office;
  p_fa_rec.supplier_site         := :supplier_site;
  p_fa_rec.supplier_product      := :supplier_product;
  p_fa_rec.ask_user_id           := %current_userid%;
  p_fa_rec.update_id             := %current_userid%;
  p_fa_rec.update_date           := SYSDATE;
  p_fa_rec.rela_supplier_id      := :rela_supplier_id;
  p_fa_rec.product_link          := :product_link;
  p_fa_rec.memo               := :remarks;
  --生产信息
  p_fa_rec.worker_num          := :worker_num;
  p_fa_rec.machine_num         := :machine_num;
  p_fa_rec.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  p_fa_rec.product_efficiency  := rtrim(:product_efficiency,''%'');
  p_fa_rec.work_hours_day      := :work_hours_day;

  scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);

END;';

update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_coop_150_3';
END;
/
--paramlist
begin
/*insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('APPLY_REASON', 'oracle_scmdata', '申请原因', null, null, 1, null, null, null, null, null, null, null, null, null, null, '18', null, null);
*/
/*insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('AUDIT_COMMENT', 'oracle_scmdata', '审核意见', null, null, 1, null, null, null, null, null, null, null, null, null, null, '18', null, null);
*/
/*insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('AUDIT_COMMENT_SP', 'oracle_scmdata', '审核意见', null, null, 0, null, null, null, null, null, null, null, null, null, null, '18', null, null);
*/
/*insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('FACTORY_ASK_TYPE', 'oracle_scmdata', '验厂方式', null, 'select ''0'' pid,''不验厂'' zdescd from dual 
union
select ''1'' pid,''内部验厂'' zdescd from dual', 1, null, null, null, null, null, null, null, null, null, null, null, null, null);
*/
insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('IS_TRIALORDER', 'oracle_scmdata', '是否试单', 'SELECT c.group_dict_value, c.group_dict_name
  FROM scmdata.sys_group_dict p, scmdata.sys_group_dict c
 WHERE p.group_dict_id = c.parent_id
   AND p.group_dict_value = ''IS_TRIALORDER''
   AND c.group_dict_value = ''0''', '/*select ''0'' SFSD_ID,''否'' SFSD from dual 
union
select ''1'' SFSD_ID,''是'' SFSD from dual*/
SELECT c.group_dict_value,c.group_dict_name
  FROM scmdata.sys_group_dict p, scmdata.sys_group_dict c
 WHERE p.group_dict_id = c.parent_id
   AND p.group_dict_value = ''IS_TRIALORDER''
 ORDER BY c.group_dict_value', 1, null, null, null, null, null, null, null, null, null, null, null, null, null);

/*insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('REMARKS', 'oracle_scmdata', '备注', null, null, 0, null, null, null, null, null, null, null, null, null, null, '18', null, null);
*/
insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('TRIALORDER_TYPE', 'oracle_scmdata', '试单模式', null, '/*select ''0'' SDMS_ID,''试一单'' SDMS from dual
union
select ''1'' SDMS_ID,''试两单'' SDMS from dual
union
select ''2'' SDMS_ID,''试单一个月'' SDMS from dual
union
select ''3'' SDMS_ID,''试单两个月'' SDMS from dual
union
select ''4'' SDMS_ID,''试单三个月'' SDMS from dual*/
SELECT c.group_dict_value,c.group_dict_name
  FROM scmdata.sys_group_dict p, scmdata.sys_group_dict c
 WHERE p.group_dict_id = c.parent_id
   AND p.group_dict_value = ''TRIALORDER_TYPE''
 ORDER BY c.group_dict_value', 0, null, null, null, null, null, null, null, null, null, null, null, null, null);
end;
/
--查看验厂详情
declare
v_sql clob;
begin
  v_sql := '--czh 重构代码
DECLARE
  p_fa_rec scmdata.t_factory_ask%ROWTYPE;
  --p_fo_rec scmdata.t_factory_ask_out%ROWTYPE;
BEGIN
  --验厂申请
  --申请信息
  p_fa_rec.ask_date          := :factory_ask_date;
  p_fa_rec.is_urgent         := :is_urgent;
  p_fa_rec.cooperation_model := :cooperation_model;
  p_fa_rec.product_type      := :product_type;
  p_fa_rec.ask_say           := :checkapply_intro;
  --供应商基本信息
  p_fa_rec.factory_ask_id       := :factory_ask_id;
  p_fa_rec.company_name         := :ask_company_name;
  p_fa_rec.company_abbreviation := :company_abbreviation;
  --p_fa_rec.social_credit_code    := :social_credit_code;
  p_fa_rec.company_province      := :company_province;
  p_fa_rec.company_city          := :company_city;
  p_fa_rec.company_county        := :company_county;
  p_fa_rec.company_address       := :pcc;
  p_fa_rec.ask_address           := :company_address;
  p_fa_rec.factory_name          := :factory_name;
  p_fa_rec.factory_province      := :company_province;
  p_fa_rec.factory_city          := :company_city;
  p_fa_rec.factory_county        := :company_county;
  p_fa_rec.ask_address           := nvl(:ask_address, :fpcc);
  p_fa_rec.legal_representative  := :legal_representative;
  p_fa_rec.company_contact_phone := :company_contact_phone;
  p_fa_rec.contact_name          := :ask_user_name;
  p_fa_rec.contact_phone         := :ask_user_phone;
  p_fa_rec.company_type          := :company_type;
  p_fa_rec.brand_type            := :brand_type;
  p_fa_rec.cooperation_brand     := :cooperation_brand;
  p_fa_rec.com_manufacturer      := :com_manufacturer;
  p_fa_rec.certificate_file      := :certificate_file;
  p_fa_rec.supplier_gate         := :supplier_gate;
  p_fa_rec.supplier_office       := :supplier_office;
  p_fa_rec.supplier_site         := :supplier_site;
  p_fa_rec.supplier_product      := :supplier_product;
  p_fa_rec.ask_user_id           := %current_userid%;
  p_fa_rec.update_id             := %current_userid%;
  p_fa_rec.update_date           := SYSDATE;
  p_fa_rec.rela_supplier_id      := :rela_supplier_id;
  p_fa_rec.product_link          := :product_link;
  p_fa_rec.memo               := :remarks;
  --生产信息
  p_fa_rec.worker_num          := :worker_num;
  p_fa_rec.machine_num         := :machine_num;
  p_fa_rec.reserve_capacity    := rtrim(:reserve_capacity,''%'');
  p_fa_rec.product_efficiency  := rtrim(:product_efficiency,''%'');
  p_fa_rec.work_hours_day      := :work_hours_day;

  scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);

END;';
 update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_coop_221' ;
end;
/
--供应商档案详情 字段必填配置
begin
update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COMPANY_ID';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'COOPERATION_MODEL';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COOPERATION_TYPE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COMPANY_CONTACT_PHONE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COMPANY_TYPE';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'SOCIAL_CREDIT_CODE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'LEGAL_REPRESENTATIVE';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'SUPPLIER_COMPANY_ABBREVIATION';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'SUPPLIER_COMPANY_NAME';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'INSIDE_SUPPLIER_CODE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'SUPPLIER_CODE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'SUPPLIER_INFO_ORIGIN';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'STATUS';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'SUPPLIER_INFO_ID';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'SUPPLIER_INFO_ORIGIN_ID';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'BRAND_TYPE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'PRODUCT_LINE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'PRODUCT_LINE_NUM';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'WORKER_NUM';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'MACHINE_NUM';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'QUALITY_STEP';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'PATTERN_CAP';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'FABRIC_PURCHASE_CAP';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'FABRIC_CHECK_CAP';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COST_STEP';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COMPANY_PROVINCE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COMPANY_CITY';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COMPANY_COUNTY';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'LOCATION_AREA';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'CERTIFICATE_FILE_SP';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'COMPANY_ADDRESS_SP';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'GROUP_NAME';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'AREA_GROUP_LEADER';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'PRODUCT_TYPE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COOPERATION_BRAND';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'FA_CONTACT_NAME';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'FA_CONTACT_PHONE';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'REGIST_STATUS_SP';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'BIND_STATUS_SQ';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COOP_POSITION';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'RESERVE_CAPACITY';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'PRODUCT_EFFICIENCY';

update BW3.sys_field_list t set t.requiered_flag = 1 where t.field_name = 'WORK_HOURS_DAY';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'SUPPLIER_GATE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'SUPPLIER_OFFICE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'SUPPLIER_SITE';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'SUPPLIER_PRODUCT';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COOPERATION_BRAND_DESC';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'PRODUCT_LINK';

update BW3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'FILE_REMARK';

end;
/
--待建档提交
declare
v_sql clob;
begin
v_sql := '/*call   pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => :supplier_info_id,
                                           p_default_company_id => %default_company_id%,
                                           p_user_id            => %user_id%)*/

{DECLARE
  v_wx_sql     CLOB;
  v_origin     VARCHAR2(32);
  v_origin_id  VARCHAR2(32);
  v_submit_btn VARCHAR2(256) := :supplier_company_name;
BEGIN
  --因速狮原因，点击生成档案时，会自动触发两次提交按钮。
  --故获取必填项做校验，当v_submit_btn不为空时，则执行提交按钮。
  IF v_submit_btn IS NOT NULL THEN
    pkg_supplier_info.submit_t_supplier_info(p_supplier_info_id   => :supplier_info_id,
                                             p_default_company_id => %default_company_id%,
                                             p_user_id            => %user_id%);
    --建档通知
    SELECT t.supplier_info_origin, t.supplier_info_origin_id
      INTO v_origin, v_origin_id
      FROM scmdata.t_supplier_info t
     WHERE t.company_id = %default_company_id%
       AND t.supplier_info_id = :supplier_info_id;

    IF v_origin = ''AA'' THEN
      --触发企微机器人发送消息
      v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                            p_factory_ask_id => v_origin_id,
                                                            p_msgtype        => ''text'', --消息类型 text、markdown
                                                            p_msg_title      => ''建档通知通知'', --消息标题
                                                            p_bot_key        => ''0b3bbb09-3475-42b1-8ddb-75753e1b9c96'', --机器人key
                                                            p_robot_type     => ''SUP_MSG'' --机器人配置类型
                                                            );
    ELSE
      v_wx_sql := ''select ''''text'''' MSGTYPE,''''新增供应商-建档通知通知''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
    END IF;
  ELSE
    v_wx_sql := ''select ''''text'''' MSGTYPE,''''新增供应商-建档通知通知''''  CONTENT,''''999bc2eb-55b8-400d-a70e-5ea148e59396'''' key from dual'';
  END IF;

  @strresult := v_wx_sql;

END;
}';
update bw3.Sys_Action t set t.action_sql = v_sql WHERE T.ELEMENT_ID = 'action_a_supp_151_1' ;
end;
/
begin
/*insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('ACCOUNT_CAP', '产能占比', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
*/
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('BUH_SVG_LIMIT', '补货平均交期', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

/*insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('COMPANY_ID', '企业编号', 0, null, null, null, null, null, 0, 0, 0, null, 0, 3, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
*/
insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('CUSTOM_PRIOR', '客户优先次序', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('KAOH_LIMIT', '考核期', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('ORDER_CONTENT_RATE', '订单满足率', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('ORDER_ONTIME_RATE', '订单准期率', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('QOUTE_RATE', '报价偏差率', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('RALE_QOUTE_RATE', '实际偏差率', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('RESPONSE_QS', '问题响应', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('SHOP_RETURN_RATE', '门店退货率', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('STORE_RETURN_RATE', '仓库退货率', 0, null, null, null, null, null, 0, 0, 0, null, 0, 0, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

/*insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('SUPPLIER_INFO_ID', '供应商平台ID', 0, null, null, null, null, null, 0, 0, 0, 0, 0, 3, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
*/
end;
/
declare
v_sql1 clob;
v_sql2 clob;
begin
  v_sql1 := '--修改：启用、停用增加输入原因
DECLARE
BEGIN
  pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                   p_reason           => @U_REASON_SP@,
                                                   p_status           => 0,
                                                   p_user_id          => :user_id,
                                                   p_company_id       => %default_company_id%);

END;';
  v_sql2 := '--修改：启用、停用增加输入原因
DECLARE
BEGIN

  pkg_supplier_info.update_supplier_info_status(p_supplier_info_id => %selection%,
                                                   p_reason           => @D_REASON_SP@,
                                                   p_status           => 1,
                                                   p_user_id          => :user_id,
                                                   p_company_id       => %default_company_id%);

END;';
  update bw3.sys_action t set t.action_sql = v_sql1 where t.element_id = 'action_a_supp_160_1';
  update bw3.sys_action t set t.action_sql = v_sql2 where t.element_id = 'action_a_supp_160_2';
end;
