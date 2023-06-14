update bw3.sys_pick_list t
   set t.from_field = 'COOPERATION_SUBCATEGORY_SP'
 where t.element_id = 'pick_subcate_sp';

update bw3.sys_item_list t
   set t.auto_refresh = 4
 where t.item_id in ('a_check_101_1',
                     'a_check_101_1_1',
                     'a_check_101_1_2',
                     'a_check_101_1_3',
                     'a_check_101_1_4',
                     'a_check_101_1_5',
                     'a_check_101_1_6',
                     'a_check_101_1_7',
                     'a_check_101_1_8',
                     'a_check_101_4');

update bw3.sys_item_element_rela t
   set t.pause = '1'
 where t.element_id = 'fr_equipment_category_lookup';

update bw3.sys_look_up t
   set t.look_up_sql = 'select t.company_dict_value FR_SPOT_CHECK_RESULT_Y,
       t.company_dict_name  FR_SPOT_CHECK_RESULT_DESC_Y
  from scmdata.sys_company_dict t
 where t.company_dict_type = ''TEST_RESULT'''
 where t.element_id = 'look_a_check_101_1_8_1'
   and t.field_name = 'FR_SPOT_CHECK_RESULT_DESC_Y';

update bw3.sys_field_list t
   set t.max_value = '24',t.data_type = '10'
 where t.field_name in ('WORK_TIMES',
                        'AR_WORK_HOURS_DAY_Y',
                        'SP_WORK_HOURS_DAY_Y',
                        'WORK_HOURS_DAY');

update bw3.sys_field_list t
   set t.check_express = '^[+]{0,1}(\d+)$'
 where t.field_name in ('AR_PERSON_NUM_N','AR_MACHINE_NUM_N');

alter table scmdata.t_factory_report modify check_address null;

update bw3.sys_field_list t
   set t.data_type = '51'
 where t.field_name = 'ASK_REPORT_FILES';

---修改从表挂靠
update bw3.sys_item_rela t
   set t.pause = 1
 where t.item_id = 'a_check_101_1'
   and t.relate_id in ('a_check_101_1_1','a_check_101_3', 'a_check_101_4');

update bw3.sys_detail_group t
   set t.seq_no    = '6',t.pause ='0',t.column_number ='1',
       t.clo_names = 'fr_ability_result_desc,ask_check_result_desc_y,check_say'
 where t.item_id = 'a_check_101_1'
   and t.group_name = '验厂结果';

update bw3.sys_item t
   set t.item_type = 'single'
 where t.item_id in ('a_check_101_1',
                     'a_check_101_1_2',
                     'a_check_101_1_3',
                     'a_check_101_1_4');

update bw3.sys_field_list t
   set t.display_width = '8'
 where t.field_name = 'FR_IS_QUALITY_CONTROL_DESC_Y';

update bw3.sys_item t
   set t.caption_sql = '人员配置查验'
 where t.item_id in ( 'a_check_101_1_2');

update bw3.sys_item t
   set t.caption_sql = '机器设备查验'
 where t.item_id in ( 'a_check_101_1_3');

update bw3.sys_item t
   set t.caption_sql = '品控体系查验'
 where t.item_id in ( 'a_check_101_1_4');

update bw3.sys_item_rela t
   set t.pause = 1
 where t.item_id = 'a_check_101_1_4'
   and t.relate_id = 'a_check_101_1_8';

---权限新增
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG, SYSTEM_ID, PRIV_URL, PRIV_TYPE, PRIV_OPERATE)
values ('P0020106', '能力评估_导入', 'P00201', 0, 98, '8', 'a_check_101_3', 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('20-02-2023 16:29:33', 'dd-mm-yyyy hh24:mi:ss'), 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('20-02-2023 16:29:33', 'dd-mm-yyyy hh24:mi:ss'), 'cond_8_auto_1', 1, 'SCM', null, null, null);
insert into scmdata.sys_app_privilege (PRIV_ID, PRIV_NAME, PARENT_PRIV_ID, PAUSE, OBJ_TYPE, CTL_ID, ITEM_ID, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, COND_ID, APPLY_BELONG, SYSTEM_ID, PRIV_URL, PRIV_TYPE, PRIV_OPERATE)
values ('P0020107', '机器设备配置_导入', 'P00201', 0, 98, '8', 'a_check_101_1_6', 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('20-02-2023 16:49:30', 'dd-mm-yyyy hh24:mi:ss'), 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('20-02-2023 16:49:30', 'dd-mm-yyyy hh24:mi:ss'), 'cond_8_auto_2', 1, 'SCM', null, null, null);
insert into bw3.SYS_COND_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_8_auto_1', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0020106'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);
insert into bw3.SYS_COND_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_8_auto_2', 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''P0020107'') as flag from dual ', 0, null, 'oracle_scmdata', null, null);
insert into bw3.SYS_COND_RELA (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_8_auto_1', 98, '8', 0, 1, 0, 'a_check_101_3');
insert into bw3.SYS_COND_RELA (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_8_auto_2', 98, '8', 0, 1, 0, 'a_check_101_1_6');
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_101_1_6', 'look_a_coop_151_2_1', 1, 0, null);

--页眉
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE)
values ('span_a_check_101_1', 'span', 'oracle_scmdata', 0, null, null);
insert into  bw3.sys_span (ELEMENT_ID, SPAN_TYPE, POSITION, SPAN_SQL)
values ('span_a_check_101_1', 0, 0, '提示：1、点击''公司名称''，可以查看该公司的验厂申请详情信息。2、点击''人员配置查验''/''机器设备查验''/''品控体系查验''/''能力评估''，可进入对应页面进行验厂相关信息维护。如果未维护对应页面中的数据，将无法提交验厂报告。');
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_101_1', 'span_a_check_101_1', 1, 0, null);

---企业字典补充
insert into scmdata.sys_company_dict (COMPANY_DICT_ID, COMPANY_ID, PARENT_ID, PARENT_IDS, COMPANY_DICT_NAME, COMPANY_DICT_VALUE, COMPANY_DICT_TYPE, DESCRIPTION, COMPANY_DICT_SORT, PAUSE, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, IS_GROUP_DICT_RELA, COMPANY_DICT_STATUS, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04, EXTEND_05, EXTEND_06, EXTEND_07, EXTEND_08, EXTEND_09, EXTEND_10)
values ('f647c61911a30acbe053e2281cac46a0', 'b6cc680ad0f599cde0531164a8c0337f', 'ec65db9cd34e7957e0533c281cacd490', 'ec65db9cd34e7957e0533c281cacd490', '抽查结果', 'TEST_RESULT', 'CHECK_CONFIG', null, 1, 0, 1, 1, 0, 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('07-03-2023 17:24:38', 'dd-mm-yyyy hh24:mi:ss'), 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('07-03-2023 17:24:38', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 1, '1', null, null, null, null, null, null, null, null, null, null);
insert into scmdata.sys_company_dict (COMPANY_DICT_ID, COMPANY_ID, PARENT_ID, PARENT_IDS, COMPANY_DICT_NAME, COMPANY_DICT_VALUE, COMPANY_DICT_TYPE, DESCRIPTION, COMPANY_DICT_SORT, PAUSE, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, IS_GROUP_DICT_RELA, COMPANY_DICT_STATUS, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04, EXTEND_05, EXTEND_06, EXTEND_07, EXTEND_08, EXTEND_09, EXTEND_10)
values ('f63f88320c9a06f5e053e2281caceb7b', 'b6cc680ad0f599cde0531164a8c0337f', 'f647c61911a30acbe053e2281cac46a0', 'f647c61911a30acbe053e2281cac46a0', '合格', 'FR_00', 'TEST_RESULT', null, 1, 0, 1, 1, 0, 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('07-03-2023 17:28:03', 'dd-mm-yyyy hh24:mi:ss'), 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('07-03-2023 17:28:03', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 1, '1', null, null, null, null, null, null, null, null, null, null);
insert into scmdata.sys_company_dict (COMPANY_DICT_ID, COMPANY_ID, PARENT_ID, PARENT_IDS, COMPANY_DICT_NAME, COMPANY_DICT_VALUE, COMPANY_DICT_TYPE, DESCRIPTION, COMPANY_DICT_SORT, PAUSE, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, IS_GROUP_DICT_RELA, COMPANY_DICT_STATUS, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04, EXTEND_05, EXTEND_06, EXTEND_07, EXTEND_08, EXTEND_09, EXTEND_10)
values ('f63f88320c9b06f5e053e2281caceb7b', 'b6cc680ad0f599cde0531164a8c0337f', 'f647c61911a30acbe053e2281cac46a0', 'f647c61911a30acbe053e2281cac46a0', '不合格', 'FR_01', 'TEST_RESULT', null, 1, 0, 1, 1, 0, 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('07-03-2023 17:28:21', 'dd-mm-yyyy hh24:mi:ss'), 'cc9305ba1bb65a8fe053e2281cac3b7d', to_date('07-03-2023 17:28:21', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 1, '1', null, null, null, null, null, null, null, null, null, null);

insert into bw3.sys_detail_group (ITEM_ID, GROUP_NAME, CLO_NAMES, COLUMN_NUMBER, SEQ_NO, PAUSE)
values ('a_check_101_1_4', '现场产品质量抽查结果', 'FR_SPOT_CHECK_BRAND_N,FR_SPOT_CHECK_TYPE_N,FR_SPOT_CHECK_RESULT_Y,FR_DISQUALIFICATION_CAUSE_N,fr_check_result_accessory_n', 3, 2, 0);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_101_1_4', 'look_a_check_101_1_8_1', 1, 0, null);
insert into bw3.sys_detail_group (ITEM_ID, GROUP_NAME, CLO_NAMES, COLUMN_NUMBER, SEQ_NO, PAUSE)
values ('a_check_101_1', '附件资料', 'ar_certificate_file_y,ask_report_files,ar_supplier_gate_n,ar_supplier_office_n,ar_supplier_site_n,ar_supplier_product_n,ask_other_files', 1, 7, 0);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_101_1', 'ask_check_result_lookup', 1, 0, null);

insert into bw3.sys_field_list (FIELD_NAME, CAPTION, REQUIERED_FLAG, INPUT_HINT, VALID_CHARS, INVALID_CHARS, CHECK_EXPRESS, CHECK_MESSAGE, READ_ONLY_FLAG, NO_EDIT, NO_COPY, NO_SUM, NO_SORT, ALIGNMENT, MAX_LENGTH, MIN_LENGTH, DISPLAY_WIDTH, DISPLAY_FORMAT, EDIT_FORMT, DATA_TYPE, MAX_VALUE, MIN_VALUE, DEFAULT_VALUE, IME_CARE, IME_OPEN, VALUE_LISTS, VALUE_LIST_TYPE, HYPER_RES, MULTI_VALUE_FLAG, TRUE_EXPR, FALSE_EXPR, NAME_RULE_FLAG, NAME_RULE_ID, DATA_TYPE_FLAG, ALLOW_SCAN, VALUE_ENCRYPT, VALUE_SENSITIVE, OPERATOR_FLAG, VALUE_DISPLAY_STYLE, TO_ITEM_ID, VALUE_SENSITIVE_REPLACEMENT, STORE_SOURCE, ENABLE_STAND_PERMISSION)
values ('FR_ABILITY_RESULT_DESC', '能力评估', 0, null, null, null, null, null, 0, 0, 0, 0, 0, 3, null, null, null, null, null, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

--associate配置
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('asso_a_check_101_1_6', 'associate', 'oracle_scmdata', 0, null, 1, null, null, null, null);
insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_check_101_3', 'asso_a_check_101_1_6', 'FACTORY_REPORT_ID', 6, '能力评估', null, 2, '', null);
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_check_101_1', 'asso_a_check_101_1_6', 1, 0, null);
insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_check_101_1', 'asso_a_check_101_1_6', null, 0, 'FR_ABILITY_RESULT_DESC', null, 0);

declare
  v_sql clob := q'[{
DECLARE
  v_sql     CLOB;
  v_methods VARCHAR2(256) := 'GET;PUT;POST;DELETE';
  v_params  VARCHAR2(256);
BEGIN
  v_sql      := 'select ''' || :factory_report_id || '/' || v_methods || '?' ||
                v_params || ''' FACTORY_REPORT_ID from dual';
  @strresult := v_sql;
END;
}]';
begin
  update bw3.sys_associate t
     set t.data_sql = v_sql
   where t.element_id = 'asso_a_check_101_1_3';
end;
/

declare
  v_sql clob := 'DECLARE
  judge                      NUMBER;
  v_judge                    NUMBER;
  v_count                    NUMBER;
  v1_count                   NUMBER;
  v_check_report_file        VARCHAR2(1280);
  v_person_config_result     VARCHAR2(32);
  v_machine_equipment_result VARCHAR2(32);
  v_control_result           VARCHAR2(32);
  v_check_say                VARCHAR2(4000);
  v_check_result             VARCHAR2(32);
  v_company_name             VARCHAR2(256);
BEGIN
  scmdata.pkg_factory_inspection.p_jug_report_result(v_frid   => :factory_report_id,
                                                     v_compid => %default_company_id%);
---lsl add 20230113 (验厂管理9.10版)新增校验
  select count(*)
    into v_count
    from scmdata.t_quality_control_fr
   where factory_report_id = :factory_report_id
     and is_quality_control is null;
  if v_count > 0 then
    raise_application_error(-20002, ''品控体系内容页面有必填项未维护'');
  end if;
  select count(*)
    into v1_count
    from scmdata.t_factory_report
   where spot_check_result is null
     and factory_report_id = :factory_report_id;
  if v1_count > 0 then
    raise_application_error(-20002, ''品控体系内容页面有必填项未维护'');
  end if;
---lsl end
  SELECT MAX(fr.certificate_file),
         MAX(fr.person_config_result),
         MAX(fr.machine_equipment_result),
         MAX(fr.control_result),
         MAX(fr.check_say),
         MAX(fr.check_result)
    INTO v_check_report_file,
         v_person_config_result,
         v_machine_equipment_result,
         v_control_result,
         v_check_say,
         v_check_result
    FROM scmdata.t_factory_report fr
   WHERE fr.company_id = %default_company_id%
     AND fr.factory_ask_id = :factory_ask_id;

  SELECT decode(v_check_result, NULL, 0, 1) + decode(v_check_say, '' '', 0, 1) +
         decode(v_person_config_result, NULL, 0, 1) +
         decode(v_machine_equipment_result, NULL, 0, 1) +
         decode(v_control_result, NULL, 0, 1) +
         decode(v_check_report_file, NULL, 0, 1)
    INTO judge
    FROM dual;

  IF judge >= 6 THEN
    SELECT COUNT(factory_report_ability_id)
      INTO judge
      FROM scmdata.t_factory_report_ability
     WHERE factory_report_id = :factory_report_id
       AND (cooperation_subcategory IS NULL OR ability_result IS NULL OR
           ability_result = '' '');
    IF judge = 0 THEN
      SELECT COUNT(factory_ask_id)
        INTO v_judge
        FROM scmdata.t_factory_ask
       WHERE factrory_ask_flow_status <> ''FA11''
         AND factory_ask_id =
             (SELECT factory_ask_id
                FROM scmdata.t_factory_report
               WHERE factory_report_id = :factory_report_id);
      IF v_judge = 0 THEN

        UPDATE scmdata.t_factory_report
           SET check_user_id = %current_userid%,
               create_id     = %current_userid%
         WHERE factory_ask_id = :factory_ask_id
           AND company_id = %default_company_id%;


  --更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_flow_oper_status => ''SUBMIT'', --流程操作方式编码
                                                               p_flow_af_status   => ''FA13'', --操作后流程状态
                                                               p_memo             => '''');

      ---lsl add 20230113 (验厂管理9.10版)消息推送
        SELECT company_name
          INTO v_company_name
          FROM scmdata.t_factory_report
         WHERE factory_ask_id = :factory_ask_id;
        for w in (select cooperation_classification, cooperation_product_cate, cooperation_subcategory
                    from scmdata.t_factory_report_ability
                   where factory_report_id = :factory_report_id) loop
          if w.cooperation_classification = ''08'' then
            if (w.cooperation_product_cate = ''111'' or w.cooperation_product_cate = ''113'' or w.cooperation_product_cate = ''114'') then
              ----走个人企微推送模板表___发送给康平
              scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                                    v_supplier     => v_company_name,
                                                                    v_pattern_code => ''FR_SUBMIT_00'',
                                                                    v_user_id      => '''',
                                                                    v_type         => 1);
            else
              ----走个人企微推送模板表___发送给叶其林
              scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                                    v_supplier     => v_company_name,
                                                                    v_pattern_code => ''FR_SUBMIT_01'',
                                                                    v_user_id      => '''',
                                                                    v_type         => 1);
            end if;
          else
            if w.cooperation_subcategory = ''070602'' then
              ----走个人企微推送模板表___发送给康平
              scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                                    v_supplier     => v_company_name,
                                                                    v_pattern_code => ''FR_SUBMIT_00'',
                                                                    v_user_id      => '''',
                                                                    v_type         => 1);
            end if;
            ----走个人企微推送模板表___发送给叶其林
            scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                                  v_supplier     => v_company_name,
                                                                  v_pattern_code => ''FR_SUBMIT_01'',
                                                                  v_user_id      => '''',
                                                                  v_type         => 1);
          end if;
        end loop;
        ---lsl end
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
END;' ;
begin
  update bw3.sys_action t
     set t.action_sql = v_sql
   where t.element_id = 'action_a_check_101_1_0';
end;
/

declare
  vs_sql clob := '{
DECLARE
  v_factory_report_id VARCHAR2(32);
  v_rest_method  VARCHAR2(256);
  v_params       VARCHAR2(4000);
  v_sql          CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''GET'' || '';'') > 0 THEN
    v_sql := pkg_ask_mange.f_query_t_machine_equipment_fr(p_factory_report_id => v_factory_report_id);
 else
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;
}';
  vi_sql clob := '{
DECLARE
  v_factory_report_id VARCHAR2(32);
  v_rest_method       VARCHAR2(256);
  v_params            VARCHAR2(4000);
  v_sql               CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[
declare
  v_t_mac_rec t_machine_equipment_fr%rowtype;
  v_seqno     int;
  v_number    number(2);
begin
  select nvl(max(t.seqno), 0) + 1
    into v_seqno
    from scmdata.t_machine_equipment_fr t
   where t.factory_report_id = :factory_report_id
     and t.company_id = %default_company_id%;
  if :ar_equipment_name_y is null then
    raise_application_error(-20002, ''设备名称不允许为空！'');
  end if;
  select count(tm.equipment_name)
    into v_number
    from t_machine_equipment_fr tm
   where tm.equipment_name = :ar_equipment_name_y
     and tm.factory_report_id = :factory_report_id;
  if v_number > 0 then
    raise_application_error(-20002, ''设备名称不允许重复！'');
  end if;
  v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
  v_t_mac_rec.company_id            := %default_company_id%;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := (case when :ar_machine_num_n is null then 0 else :ar_machine_num_n end);
  v_t_mac_rec.seqno                 := v_seqno;
  v_t_mac_rec.orgin                 := ''MA'';
  v_t_mac_rec.pause                 := 0;
  v_t_mac_rec.remarks               := :remarks;
  v_t_mac_rec.update_id             := :user_id;
  v_t_mac_rec.update_time           := sysdate;
  v_t_mac_rec.create_id             := :user_id;
  v_t_mac_rec.create_time           := sysdate;
  v_t_mac_rec.factory_report_id     := :factory_report_id;
  pkg_ask_mange.p_insert_t_machine_equipment_fr(p_t_mac_rec => v_t_mac_rec);
end;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;
}';
  vu_sql clob := '{
DECLARE
  v_factory_report_id VARCHAR2(32);
  v_rest_method       VARCHAR2(256);
  v_params            VARCHAR2(4000);
  v_sql               CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_t_mac_rec t_machine_equipment_fr%ROWTYPE;
  v_seqno     INT;
  v_number    number(2);
BEGIN
  if :ar_equipment_name_y is null then
    raise_application_error(-20002, ''设备名称不允许为空！'');
  end if;
  select count(tm.equipment_name)
    into v_number
    from t_machine_equipment_fr tm
   where tm.machine_equipment_id <> :machine_equipment_id
     and tm.equipment_name = :ar_equipment_name_y
     and tm.factory_report_id = :factory_report_id;
  if v_number > 0 then
    raise_application_error(-20002, ''设备名称不允许重复！'');
  end if;
  v_t_mac_rec.machine_equipment_id  := :machine_equipment_id;
  v_t_mac_rec.equipment_category_id := :ar_equipment_cate_n;
  v_t_mac_rec.equipment_name        := :ar_equipment_name_y;
  v_t_mac_rec.machine_num           := (case when :ar_machine_num_n is null then 0 else :ar_machine_num_n  end);
  v_t_mac_rec.remarks               := :remarks;
  v_t_mac_rec.update_id             := :user_id;
  v_t_mac_rec.update_time           := SYSDATE;
  v_t_mac_rec.factory_report_id     := :factory_report_id;
  scmdata.pkg_ask_mange.p_update_t_machine_equipment_fr(p_t_mac_rec => v_t_mac_rec);
END;
]'';
  END IF;
  @strresult := v_sql;
END;
}';
  vd_sql clob := '{
DECLARE
  v_factory_report_id VARCHAR2(32);
  v_rest_method       VARCHAR2(256);
  v_params            VARCHAR2(4000);
  v_sql               CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  IF instr('';'' || v_rest_method || '';'', '';'' || ''DELETE'' || '';'') > 0 THEN
    v_sql := q''[
declare
  v_t_mac_rec t_machine_equipment_fr%rowtype;
  v_orgin     varchar2(32);
  v_seqno     int;
begin
  select max(t.orgin)
    into v_orgin
    from t_machine_equipment_fr t
   where t.machine_equipment_id = :machine_equipment_id;
  if v_orgin <> ''AA'' then
    v_t_mac_rec.machine_equipment_id := :machine_equipment_id;
    pkg_ask_mange.p_delete_t_machine_equipment_fr(p_t_mac_rec => v_t_mac_rec);
  else
    raise_application_error(-20002, ''来源为系统配置的数据，不能删除！'');
  end if;
end;
]'';
  ELSE
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;

}';
begin
  update bw3.sys_item_list t
     set t.select_sql = vs_sql,
         t.insert_sql = vi_sql,
         t.update_sql = vu_sql,
         t.delete_sql = vd_sql
   where t.item_id = 'a_check_101_1_6';
end;
/

declare
 v_sql clob := '{
DECLARE
  v_factory_report_id VARCHAR2(32);
  v_rest_method  VARCHAR2(256);
  v_params       VARCHAR2(4000);
  v_sql          CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => :factory_report_id,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  --准入审批查看时，需要用到该逻辑
  --czh add
  IF :factory_ask_id IS NOT NULL THEN
    SELECT MAX(t.factory_report_id) INTO v_factory_report_id  from scmdata.t_factory_report t WHERE t.factory_ask_id = :factory_ask_id;
    v_rest_method := ''GET'';
  END IF;
  --czh end
  IF instr('';'' || v_rest_method || '';'', '';'' || ''GET'' || '';'') > 0 THEN
v_sql := ''select factory_report_id factory_report_id_p,
        ''''人员配置查看'''' PERSON_DETAILS_LINK,
       fr.person_config_result person_config_result_id,
       (select t.company_dict_name
          from scmdata.sys_company_dict t
         where t.company_dict_type = ''''ASK_REASON''''
           and fr.person_config_result = t.company_dict_value) person_config_result,
       fr.person_config_reason
  from scmdata.t_factory_report fr
 WHERE FACTORY_REPORT_ID = ''''''||v_factory_report_id ||'''''''';
 else
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;
}';
begin
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'a_check_103_4';
end;
/

declare
 v_sql clob := '{
DECLARE
  v_factory_report_id VARCHAR2(32);
  v_rest_method  VARCHAR2(256);
  v_params       VARCHAR2(4000);
  v_sql          CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  --准入审批查看时，需要用到该逻辑
  --czh add
  IF :factory_ask_id IS NOT NULL THEN
    SELECT MAX(t.factory_report_id) INTO v_factory_report_id  from scmdata.t_factory_report t WHERE t.factory_ask_id = :factory_ask_id;
    v_rest_method := ''GET'';
  END IF;
  --czh end
  IF instr('';'' || v_rest_method || '';'', '';'' || ''GET'' || '';'') > 0 THEN
v_sql := ''select factory_report_id factory_report_id_p,
       --机器设备
       ''''机器设备查看'''' MACHINE_DETAILS_LINK,
       fr.machine_equipment_result machine_equipment_result_id,
       (select t.company_dict_name
          from scmdata.sys_company_dict t
         where t.company_dict_type = ''''ASK_REASON''''
           and fr.machine_equipment_result = t.company_dict_value) machine_equipment_result,
       fr.machine_equipment_reason
  from scmdata.t_factory_report fr
 WHERE FACTORY_REPORT_ID = ''''''||v_factory_report_id ||'''''''';
 else
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;
}';
begin
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'a_check_103_5';
end;
/

declare
 v_sql clob := '{
DECLARE
  v_factory_report_id VARCHAR2(32);
  v_rest_method  VARCHAR2(256);
  v_params       VARCHAR2(4000);
  v_sql          CLOB;
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_factory_report_id%,
                                             po_pk_id        => v_factory_report_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  --准入审批查看时，需要用到该逻辑
  --czh add
  IF :factory_ask_id IS NOT NULL THEN
    SELECT MAX(t.factory_report_id) INTO v_factory_report_id  from scmdata.t_factory_report t WHERE t.factory_ask_id = :factory_ask_id;
    v_rest_method := ''GET'';
  END IF;
  --czh end
  IF instr('';'' || v_rest_method || '';'', '';'' || ''GET'' || '';'') > 0 THEN
v_sql := ''select factory_report_id factory_report_id_p,
       --品控体系
       ''''品控体系查看'''' CONTROL_DETAILS_LINK,
       fr.control_result control_result_id,
       (select t.company_dict_name
          from scmdata.sys_company_dict t
         where t.company_dict_type = ''''ASK_REASON''''
           and fr.control_result = t.company_dict_value) control_result,
       fr.control_reason
  from scmdata.t_factory_report fr
 WHERE FACTORY_REPORT_ID = ''''''||v_factory_report_id ||'''''''';
 else
    v_sql := NULL;
  END IF;
  @strresult := v_sql;
END;
}';
begin
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id = 'a_check_103_6';
end;
/


declare
  vu_sql clob := 'DECLARE
  p_fac_rec scmdata.t_factory_report%ROWTYPE;
BEGIN
  p_fac_rec.factory_report_id        := :factory_report_id;
  p_fac_rec.check_person1            := :check_person1;
  p_fac_rec.check_person2            := :check_person2;
  p_fac_rec.check_date               := :check_date;
  p_fac_rec.person_config_result     := :person_config_result_id;
  p_fac_rec.person_config_reason     := :person_config_reason;
  p_fac_rec.machine_equipment_result := :machine_equipment_result_id;
  p_fac_rec.machine_equipment_reason := :machine_equipment_reason;
  p_fac_rec.control_result           := :control_result_id;
  p_fac_rec.control_reason           := :control_reason;
  p_fac_rec.check_result             := trim(:ask_check_result_y);
  p_fac_rec.check_say                := :check_say;
  p_fac_rec.certificate_file         := :ar_certificate_file_y;
  p_fac_rec.ask_files                := :ASK_OTHER_FILES;
  p_fac_rec.supplier_gate            := :ar_supplier_gate_n;
  p_fac_rec.supplier_office          := :ar_supplier_office_n;
  p_fac_rec.supplier_site            := :ar_supplier_site_n;
  p_fac_rec.supplier_product         := :ar_supplier_product_n;
  p_fac_rec.check_report_file        := :ask_report_files;
  p_fac_rec.update_id                := :user_id;
  p_fac_rec.update_date              := SYSDATE;
  if :ar_certificate_file_y is null then
    raise_application_error(-20002, ''企业证照必填！'');
  end if;
  if trim(:ask_check_result_y) is null then
    raise_application_error(-20002, ''验厂结论不可为空！'');
  end if;
  if trim(:check_say) is null then
    raise_application_error(-20002, ''验厂评语不可为空！'');
  end if;
  if :person_config_result_id is null or :machine_equipment_result_id is null or :control_result_id  is null then
    raise_application_error(-20002, ''结论为必填！'');
  end if;
  scmdata.pkg_ask_mange.p_update_check_factory_report(p_fac_rec => p_fac_rec);
END;';
begin
  update bw3.sys_item_list t
     set t.update_sql = vu_sql
   where t.item_id = 'a_check_101_1';
end;
/
