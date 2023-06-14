--1.添加验厂报告提交后推送消息至叶其林企业微信中；
declare
v_sql clob;
begin
  v_sql := '--czh 重构代码
{DECLARE
  judge               NUMBER(1);
  v_check_report_file VARCHAR2(32);
  v_wx_sql            CLOB;
BEGIN
  scmdata.pkg_factory_inspection.p_jug_report_result(v_frid   => :factory_report_id,
                                                     v_compid => %default_company_id%);

  SELECT MAX(fr.certificate_file)
    INTO v_check_report_file
    FROM scmdata.t_factory_report fr
   WHERE fr.company_id = %default_company_id%
     AND fr.factory_ask_id = :factory_ask_id;

  SELECT decode(:check_fac_result, NULL, 0, 1) +
         decode(:check_say, '' '', 0, 1) +
         decode(v_check_report_file, NULL, 0, 1)
    INTO judge
    FROM dual;

  IF judge >= 3 THEN
    SELECT COUNT(factory_report_ability_id)
      INTO judge
      FROM scmdata.t_factory_report_ability
     WHERE factory_report_id = :factory_report_id
       AND (cooperation_subcategory IS NULL OR ability_result IS NULL OR
           ability_result = '' '');
    IF judge = 0 THEN
      SELECT COUNT(factory_ask_id)
        INTO judge
        FROM scmdata.t_factory_ask
       WHERE factrory_ask_flow_status <> ''FA11''
         AND factory_ask_id =
             (SELECT factory_ask_id
                FROM scmdata.t_factory_report
               WHERE factory_report_id = :factory_report_id);
      IF judge = 0 THEN     
        
        UPDATE scmdata.t_factory_report
           SET check_user_id = %current_userid%,
               create_id     = %current_userid%
         WHERE factory_ask_id = :factory_ask_id
           AND company_id = %default_company_id%;
           
        --流程操作记录
        pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                                    p_user_id      => :user_id,
                                                    p_fac_ask_id   => :factory_ask_id,
                                                    p_flow_status  => ''SUBMIT'',
                                                    p_fac_ask_flow => ''FA13'',
                                                    p_memo         => '''');
           
        --供应流程 触发企微机器人发送消息
        v_wx_sql := scmdata.pkg_supplier_info.send_fac_wx_msg(p_company_id     => %default_company_id%,
                                                              p_factory_ask_id => :factory_ask_id,
                                                              p_msgtype        => ''text'', --消息类型 text、markdown
                                                              p_msg_title      => ''验厂审核通知'', --消息标题
                                                              p_bot_key        => ''94bc653e-e4ed-4d58-bc7e-57b918645bd2'', --机器人key
                                                              p_robot_type     => ''SUP_MSG'' --机器人配置类型
                                                              );       
      ELSE
        raise_application_error(-20004,
                                ''已有单据在流程中或该供应商已准入通过，请勿重复提交！'');
      END IF;
    ELSE
      raise_application_error(-20003, ''请将能力评估表填写完成后再提交！'');
    END IF;
  ELSE
    raise_application_error(-20002, ''请填写页面必填项后再提交！'');
  END IF;
  @strresult := v_wx_sql;
END;}';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_check_101_1_0';
end;
/
--待审批-不同意审批意见改为下拉选项，可多选，同时增加备注字段（非必填）：
--（1）产品质量差；(2）人员太少；(3）设备不满足产品需求；(4）品控流程不符合公司要求。
declare
v_sql clob;
begin
  v_sql := 'DECLARE
v_audit_comment varchar2(256) := @audit_comment_fr@;
v_memo CLOB := @memo_fr@;
BEGIN
  UPDATE scmdata.t_factory_report t
     SET t.factory_result_suggest = ''不通过''
   WHERE t.factory_report_id = :factory_report_id;
  --供应链总监需审核验厂审核不通过的单据   需流入准入待审批  
  --流程操作记录
  v_memo := case when v_memo is not null then ''审核意见：''||chr(13)||v_audit_comment||chr(13)||'';备注:''||chr(13)||v_memo else ''审核意见：''||chr(13)||v_audit_comment end;
  pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => %default_company_id%,
                                              p_user_id      => :user_id,
                                              p_fac_ask_id   => :factory_ask_id,
                                              p_flow_status  => ''UNPASS'',  --''UNPASS'',
                                              p_fac_ask_flow => ''FA12'',  --''FA14'',
                                              p_memo         => v_memo);
END;';
update bw3.sys_action t set t.action_sql = v_sql where t.element_id = 'action_a_check_102_2';
end;
/
begin
insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('AUDIT_COMMENT_FR', 'oracle_scmdata', '审核意见', null, 'SELECT t.group_dict_name AUDIT_COMMENT_FR
  FROM scmdata.sys_group_dict t
 WHERE t.group_dict_type = ''AUDIT_COMMENT''', 1, null, null, null, null, null, null, null, null, null, null, null, ';', 1);

insert into bw3.sys_param_list (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('MEMO_FR', 'oracle_scmdata', '备注', null, null, 0, null, null, null, null, null, null, null, null, null, null, '18', null, null);

update bw3.sys_field_list t set t.requiered_flag = 0 where t.field_name = 'COST_STEP_DESC' ;
end;
/
begin
insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('d2ff009335982aafe0533c281cacff96', 'b2c7b0092405122de0533c281cac6536', 'b2c7b0092405122de0533c281cac6536', '审核意见', 'AUDIT_COMMENT', 'SUPPLIER_MANGE_DICT', null, 1, '1', 1, 1, 0, 'CZH', to_date('13-12-2021 14:33:58', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('13-12-2021 14:33:58', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('d2ff009335992aafe0533c281cacff96', 'd2ff009335982aafe0533c281cacff96', 'd2ff009335982aafe0533c281cacff96', '产品质量差', '00', 'AUDIT_COMMENT', null, 1, '1', 1, 1, 0, 'CZH', to_date('13-12-2021 14:35:48', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('13-12-2021 14:35:48', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('d2ff0093359a2aafe0533c281cacff96', 'd2ff009335982aafe0533c281cacff96', 'd2ff009335982aafe0533c281cacff96', '人员太少', '01', 'AUDIT_COMMENT', null, 1, '1', 1, 1, 0, 'CZH', to_date('13-12-2021 14:35:48', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('13-12-2021 14:35:48', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('d2ff0093359b2aafe0533c281cacff96', 'd2ff009335982aafe0533c281cacff96', 'd2ff009335982aafe0533c281cacff96', '设备不满足产品需求', '02', 'AUDIT_COMMENT', null, 1, '1', 1, 1, 0, 'CZH', to_date('13-12-2021 14:35:48', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('13-12-2021 14:35:48', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA)
values ('d2ff0093359c2aafe0533c281cacff96', 'd2ff009335982aafe0533c281cacff96', 'd2ff009335982aafe0533c281cacff96', '品控流程不符合公司要求', '03', 'AUDIT_COMMENT', null, 1, '1', 1, 1, 0, 'CZH', to_date('13-12-2021 14:35:48', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('13-12-2021 14:35:48', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0');
end;
/
declare
v_sql clob;
begin
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
       sp.ask_files,
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
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'a_supp_151'; 
end;
/
declare
v_sql clob;
begin
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
       sp.ask_files,
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
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'a_supp_161'; 
end;
/
declare
v_sql clob;
begin
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
       sp.ask_files,
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
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'a_supp_171'; 
end;
/
begin
  update bw3.sys_detail_group t set t.clo_names = 'certificate_file,ask_files,supplier_gate,supplier_office,supplier_site,supplier_product' where t.item_id in ('a_coop_150_3' , 'a_coop_211' , 'a_coop_221','a_coop_104') and t.group_name = '供应商附件资料' ; 
  update bw3.sys_detail_group t set t.clo_names = 'certificate_file_sp,ask_files,SUPPLIER_GATE,SUPPLIER_OFFICE,SUPPLIER_SITE,SUPPLIER_PRODUCT' where t.item_id in ('a_supp_151' , 'a_supp_161' , 'a_supp_171') and t.group_name = '相关附件' ; 
end;
/
declare
v_sql1 clob;
v_sql2 clob;
v_sql3 clob;
begin
v_sql1 := '--czh 20211016重构代码
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
  p_fa_rec.ask_files             := :ask_files;
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
v_sql2 := '--czh 重构代码
DECLARE
  p_fa_rec scmdata.t_factory_ask%ROWTYPE;
  p_fo_rec scmdata.t_factory_ask_out%ROWTYPE;
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
  p_fa_rec.contact_name          := :contact_name;
  p_fa_rec.contact_phone         := :contact_phone;
  p_fa_rec.company_type          := :company_type;
  p_fa_rec.brand_type            := :brand_type;
  p_fa_rec.cooperation_brand     := :cooperation_brand;
  p_fa_rec.com_manufacturer      := :com_manufacturer;
  p_fa_rec.certificate_file      := :certificate_file;
  p_fa_rec.ask_files             := :ask_files;
  p_fa_rec.supplier_gate         := :supplier_gate;
  p_fa_rec.supplier_office       := :supplier_office;
  p_fa_rec.supplier_site         := :supplier_site;
  p_fa_rec.supplier_product      := :supplier_product;
  p_fa_rec.ask_user_id           := %current_userid%;
  p_fa_rec.update_id             := %current_userid%;
  p_fa_rec.update_date           := SYSDATE;
  p_fa_rec.rela_supplier_id      := :rela_supplier_id;
  p_fa_rec.product_link          := :product_link;

  scmdata.pkg_ask_record_mange.p_save_factory_ask(p_fa_rec => p_fa_rec);

END;';
v_sql3 := '--czh 重构代码
DECLARE
  p_fa_rec scmdata.t_factory_ask%ROWTYPE;
  p_fo_rec scmdata.t_factory_ask_out%ROWTYPE;
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
  p_fa_rec.company_address       := :company_address;
  --p_fa_rec.ask_address           := :company_address;
  p_fa_rec.factory_name          := :factory_name;
  p_fa_rec.factory_province      := :factory_province;
  p_fa_rec.factory_city          := :factory_city;
  p_fa_rec.factory_county        := :factory_county;
  p_fa_rec.ask_address           := :ask_address;
  p_fa_rec.legal_representative  := :legal_representative;
  p_fa_rec.company_contact_phone := :company_contact_phone;
  p_fa_rec.contact_name          := :ask_user_name;
  p_fa_rec.contact_phone         := :ask_user_phone;
  p_fa_rec.company_type          := :company_type;
  p_fa_rec.brand_type            := :brand_type;
  p_fa_rec.cooperation_brand     := :cooperation_brand;
  p_fa_rec.com_manufacturer      := :com_manufacturer;
  p_fa_rec.certificate_file      := :certificate_file;
  p_fa_rec.ask_files             := :ask_files;
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
update bw3.sys_item_list t set t.update_sql = v_sql1 where t.item_id = 'a_coop_150_3';
update bw3.sys_item_list t set t.update_sql = v_sql2 where t.item_id = 'a_coop_211';
update bw3.sys_item_list t set t.update_sql = v_sql3 where t.item_id = 'a_coop_221';
end;
/
declare
v_sql clob;
begin
 v_sql := 'DECLARE
  p_fac_rec scmdata.t_factory_report%ROWTYPE;
BEGIN
  p_fac_rec.factory_report_id   := :factory_report_id;
  p_fac_rec.certificate_file    := :certificate_file;
  p_fac_rec.ask_files           := :ask_files;
  p_fac_rec.supplier_gate       := :supplier_gate;
  p_fac_rec.supplier_office     := :supplier_office;
  p_fac_rec.supplier_site       := :supplier_site;
  p_fac_rec.supplier_product    := :supplier_product;
  p_fac_rec.check_report_file   := :check_report_file;
  p_fac_rec.update_id           := :user_id;
  p_fac_rec.update_date         := SYSDATE;

  scmdata.pkg_ask_record_mange.p_update_check_factory_report(p_fac_rec => p_fac_rec,p_type => 1);
END;';
update bw3.sys_item_list t set t.update_sql = v_sql where t.item_id = 'a_check_101_4';
end;
/
declare
v_sql1 clob;
v_sql2 clob;
v_sql3 clob;
v_sql4 clob;
v_sql5 clob;
v_sql6 clob;
v_sql7 clob;
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
       sp.ask_files,
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
  v_sp_data.coop_position := :coop_position;
  --附件资料
  v_sp_data.certificate_file := :certificate_file_sp;
  v_sp_data.ask_files := :ask_files;
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
v_sql3 := 'WITH group_dict AS
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
       sp.ask_files,
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
 v_sql4 := '{DECLARE
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
  v_sp_data.ask_files := :ask_files;
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
v_sql5 := '--czh 重构代码
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
       sp.ask_files,
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

v_sql6 := '--不考虑供应商是否已经在平台注册
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
  p_sp_data.coop_position     := :coop_position;
  --相关附件
  p_sp_data.certificate_file := :certificate_file_sp;
  p_sp_data.ask_files := :ask_files;
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
v_sql7 :='{DECLARE
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
  v_sp_data.ask_files := :ask_files;
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
   update bw3.sys_item_list t set t.select_sql = v_sql3,t.update_sql = v_sql4 where t.item_id = 'a_supp_161';
   update bw3.sys_item_list t set t.select_sql = v_sql5,t.insert_sql = v_sql6,t.update_sql = v_sql7 where t.item_id = 'a_supp_171';
end;
