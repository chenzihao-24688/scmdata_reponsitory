--1.所在分组 assign_a_coop_162_1
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[ {DECLARE
  v_query_sql   CLOB;
  v_province_id CLOB;
BEGIN
  IF instr(:is_province_allcity, '1') > 0 THEN
    v_province_id := :province_id;
    v_query_sql   := 'SELECT xmlagg(xmlparse(content group_area || '';'') ORDER BY provinceid).getclobval() group_area,
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
 WHERE instr(' || v_province_id || ', provinceid) > 0';
  ELSE
    v_query_sql := 'SELECT '''' city_id,'''' group_area FROM dual';
  END IF;
  @strresult := v_query_sql;
END;
}]';

  UPDATE bw3.sys_assign t
     SET t.assign_sql = v_sql
   WHERE t.element_id = 'assign_a_coop_162_1';

END;
/
--2.供应商档案 a_supp_151
DECLARE
  v_sql CLOB;
BEGIN
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

  UPDATE bw3.sys_item_list t
     SET t.update_sql = v_sql
   WHERE t.item_id = 'a_supp_151';

END;
