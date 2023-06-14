BEGIN
  UPDATE bw3.sys_detail_group t
   SET t.pause = 0, t.seq_no = 3, t.clo_names = 'ar_certificate_file_y,ar_supplier_gate_n,ar_supplier_office_n,ar_supplier_site_n,ar_supplier_product_n,ar_other_information_n'
 WHERE t.item_id = 'a_coop_151'
   AND t.group_name = '附件资料';
   
  UPDATE bw3.sys_detail_group t SET t.pause = 1 WHERE t.item_id  = 'a_coop_151' AND t.group_name IN ('附件信息','供应商基本信息');
  UPDATE bw3.sys_detail_group t SET t.pause = 1 WHERE t.item_id  = 'a_coop_150_3' AND t.group_name in ('供应商基本信息','供应商附件资料');
  
  UPDATE bw3.sys_item_element_rela t SET t.pause = 1 WHERE t.item_id = 'a_coop_310'
   AND t.element_id IN
       ('action_a_coop_311', 'action_a_coop_312', 'action_a_coop_313');
       
 UPDATE bw3.sys_field_control t
   SET t.control_express = q'['{{STATUS_AF_OPER}}'=='CA01'||'{{STATUS_AF_OPER}}'=='FA01'||'{{STATUS_AF_OPER}}'=='FA03']'
 WHERE t.element_id = 'control_a_coop_150_1'
   AND t.from_field = 'STATUS_AF_OPER';
END;
/
BEGIN
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_8', 'adt_a_report_performance_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_8', 'adt_a_report_performance_2', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_8', 'adt_a_report_performance_3', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_8', 'adt_a_report_performance_4', 4, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_supp_151_8', 'adt_a_report_performance_5', 5, 0, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('f0cbe22870c471c6e0533c281cac63b6', 'b2c7b0092405122de0533c281cac6536', 'b2c7b0092405122de0533c281cac6536', '是否紧急', 'IS_URGENT', 'SUPPLIER_MANGE_DICT', null, 1, '1', 1, 1, 0, 'CZH', to_date('27-12-2022 16:17:31', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('27-12-2022 16:17:31', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('f0cbe22870c571c6e0533c281cac63b6', 'f0cbe22870c471c6e0533c281cac63b6', 'f0cbe22870c471c6e0533c281cac63b6', '否', '0', 'IS_URGENT', null, 1, '1', 1, 1, 0, 'CZH', to_date('27-12-2022 16:17:59', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('27-12-2022 16:17:59', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);

insert into scmdata.sys_group_dict (GROUP_DICT_ID, PARENT_ID, PARENT_IDS, GROUP_DICT_NAME, GROUP_DICT_VALUE, GROUP_DICT_TYPE, DESCRIPTION, GROUP_DICT_SORT, GROUP_DICT_STATUS, TREE_LEVEL, IS_LEAF, IS_INITIAL, CREATE_ID, CREATE_TIME, UPDATE_ID, UPDATE_TIME, REMARKS, DEL_FLAG, PAUSE, IS_COMPANY_DICT_RELA, EXTEND_01, EXTEND_02, EXTEND_03, EXTEND_04)
values ('f0cbe22870c671c6e0533c281cac63b6', 'f0cbe22870c471c6e0533c281cac63b6', 'f0cbe22870c471c6e0533c281cac63b6', '是', '1', 'IS_URGENT', null, 2, '1', 1, 1, 0, 'CZH', to_date('27-12-2022 16:17:59', 'dd-mm-yyyy hh24:mi:ss'), 'CZH', to_date('27-12-2022 16:17:59', 'dd-mm-yyyy hh24:mi:ss'), null, 0, 0, '0', null, null, null, null);


UPDATE bw3.sys_field_list t SET t.data_type = 10 WHERE t.field_name = 'AR_PERSON_NUM_N';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[SELECT t.company_dict_value AR_PERSON_JOB_N, t.company_dict_name AR_PERSON_JOB_DESC_N
  FROM scmdata.sys_company_dict t
 WHERE (t.company_dict_type, t.company_id) IN
       (SELECT b.company_dict_value, b.company_id
          FROM scmdata.sys_company_dict b
         WHERE (b.company_dict_type, b.company_id) IN
               (SELECT a.company_dict_value, a.company_id
                  FROM scmdata.sys_company_dict a
                 WHERE a.company_dict_type = 'ROLE'
                   AND a.company_id = %default_company_id%))]';
UPDATE bw3.sys_look_up t SET t.look_up_sql = v_sql WHERE t.element_id = 'look_a_coop_151_1_3'; 
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[{
DECLARE
  v_sql             CLOB;
  v_ask_record_id   VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(2000);
  v_is_show_element VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_is_show_element := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                                    p_key     => 'is_show_element');
  v_is_show_element := nvl(v_is_show_element, 0);
  IF v_is_show_element = 1 THEN
    v_sql := 'select max(1) from dual';
  ELSE
    v_sql := 'select max(0) from dual';
  END IF;
  @strresult        := v_sql;
END;
}]';
UPDATE bw3.sys_cond_list t SET t.cond_sql = v_sql WHERE t.cond_id = 'cond_a_coop_151';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[--czh 重构代码
DECLARE
  v_ask_record_id VARCHAR2(32);
  v_company_name  VARCHAR2(256);
  v_fa_rec        scmdata.t_factory_ask%ROWTYPE;
BEGIN
  SELECT *
    INTO v_fa_rec
    FROM scmdata.t_factory_ask t
   WHERE t.factory_ask_id = :factory_ask_id;
  --1.提交校验
  scmdata.pkg_ask_record_mange.p_check_factory_ask_by_submit(p_fa_rec => v_fa_rec);
  
  --2.提交后,更新单据状态同时记录流程操作日志
  scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                               p_user_id          => :user_id,
                                                               p_fac_ask_id       => :factory_ask_id, --验厂申请单ID
                                                               p_ask_record_id    => v_fa_rec.ask_record_id, --合作申请单ID
                                                               p_flow_oper_status => 'SUBMIT', --流程操作方式编码
                                                               p_flow_af_status   => 'FA02', --操作后流程状态
                                                               p_memo             => NULL);
  --lsl add 20230116
  --3.个人企微消息推送
  SELECT company_name
    INTO v_company_name
    FROM scmdata.t_factory_ask
   WHERE factory_ask_id = :factory_ask_id;

  scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                        v_supplier     => v_company_name,
                                                        v_pattern_code => 'FA_SUBMIT_00',
                                                        v_user_id      => '',
                                                        v_type         => 1);
  --lsl end
END;]';
UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'ac_a_coop_150_4';
END;
/
BEGIN
insert into nbw.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_a_coop_150_4', '{
DECLARE
  v_sql             CLOB;
  v_ask_record_id   VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(2000);
  v_is_show_element VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_ask_record_id%,
                                             po_pk_id        => v_ask_record_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
  v_is_show_element := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                                    p_key     => ''is_show_element'');
  v_is_show_element := nvl(v_is_show_element, 0);
  IF v_is_show_element = 1 THEN
    v_sql := ''select max(1) from dual'';
  ELSE
    v_sql := ''select max(0) from dual'';
  END IF;
  @strresult        := v_sql;
END;
}', 0, null, 'oracle_scmdata', null, null);

UPDATE nbw.sys_cond_rela t SET t.cond_id = 'cond_a_coop_150_4' WHERE t.cond_id = 'cond_a_coop_151' AND t.ctl_id = 'ac_a_coop_150_4'; 
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := q'[--czh 重构代码
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => 'COM_MANUFACTURER',
                                                               p_field_value     => 'COOP_FACTORY_TYPE',
                                                               p_field_desc      => 'COOP_FACTORY_TYPE_DESC');
  @strresult := v_sql;
END;}]';
UPDATE bw3.sys_look_up t SET t.look_up_sql = v_sql WHERE t.element_id = 'look_a_supp_151_7_2'; 
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[
DECLARE
  judge          NUMBER(1);
  fa_id          VARCHAR2(32);
  fa_status      VARCHAR2(32);
  v_type         NUMBER;
  v_company_name VARCHAR2(256);
BEGIN
  SELECT COUNT(1)
    INTO judge
    FROM scmdata.t_factory_ask
   WHERE ask_record_id = :ask_record_id;

  IF judge > 0 THEN
    SELECT factory_ask_id, status_af_oper
      INTO fa_id, fa_status
      FROM (SELECT factory_ask_id, status_af_oper
              FROM scmdata.t_factory_ask_oper_log
             WHERE ask_record_id = :ask_record_id
             ORDER BY oper_time DESC)
     WHERE rownum < 2;
    -- 验厂环节不通过的单据需流入准入待审批
    -- 'FA14',/*CASE WHEN fa_status = 'FA14' THEN  1 ELSE 0 END*/
    IF fa_status IN ('FA03', 'FA21', 'FA33') THEN
      --判断是否验厂
      SELECT COUNT(1)
        INTO v_type
        FROM scmdata.t_factory_report t
       WHERE t.factory_ask_id = fa_id
         AND t.company_id = %default_company_id%;
    
      UPDATE scmdata.t_factory_ask
         SET factory_ask_type = CASE
                                  WHEN v_type > 0 THEN
                                   1
                                  ELSE
                                   0
                                END
       WHERE factory_ask_id = fa_id;
    
      --czh add 更新单据状态同时记录流程操作日志
      scmdata.pkg_ask_record_mange.p_update_flow_status_and_logger(p_company_id       => %default_company_id%,
                                                                   p_user_id          => :user_id,
                                                                   p_fac_ask_id       => fa_id, --验厂申请单ID
                                                                   p_ask_record_id    => NULL, --合作申请单ID
                                                                   p_flow_oper_status => 'SUBMIT', --流程操作方式编码
                                                                   p_flow_af_status   => 'FA31', --操作后流程状态
                                                                   p_memo             => @apply_reason@);
      --lsl add 20230116
      --个人企微消息推送
      SELECT company_name
        INTO v_company_name
        FROM scmdata.t_factory_ask
       WHERE factory_ask_id = fa_id;
      scmdata.pkg_send_wx_msg.p_platform_person_wx_msg_push(v_company_id   => %default_company_id%,
                                                            v_supplier     => v_company_name,
                                                            v_pattern_code => 'FA_SPECIAL_00',
                                                            v_user_id      => '',
                                                            v_type         => 1);
      --lsl end
    ELSE
      raise_application_error(-20002,
                              '仅状态为[验厂申请不通过、准入不通过、特批不通过]的单据才可进行特批申请！');
    END IF;
  ELSE
    raise_application_error(-20002, '找不到验厂申请单，请先申请验厂！');
  END IF;
END;]';
UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_specialapply'; 
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := '{
DECLARE
  v_cate           VARCHAR2(128);
  v_procate        VARCHAR2(256);
  v_subcate        VARCHAR2(512);
  v_sql            CLOB;
  v_ask_record_id  VARCHAR2(32);
  v_factory_ask_id VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  v_ask_record_id := pkg_plat_comm.f_get_rest_val_method_params(p_character => %ass_ask_record_id%,
                                                                p_rtn_type  => 1);

  SELECT MAX(t.factory_ask_id)
    INTO v_factory_ask_id
    FROM scmdata.t_factory_ask t
   WHERE t.ask_record_id = v_ask_record_id
     AND t.company_id = %default_company_id%
   ORDER BY t.create_date DESC;

  v_factory_ask_id := nvl(v_factory_ask_id, :factory_ask_id);

  IF v_factory_ask_id IS NULL THEN
    v_sql := ''SELECT SUPPLIER_INFO_ID      AR_RELA_SUPPLIER_ID_N,
       SUPPLIER_COMPANY_NAME RELA_SUPPLIER_ID_DESC
  FROM SCMDATA.T_SUPPLIER_INFO
 WHERE COMPANY_ID =%DEFAULT_COMPANY_ID%
   AND STATUS = 1'';

  ELSIF v_factory_ask_id IS NOT NULL AND :ar_cooperation_model_y = ''OF'' THEN
    SELECT listagg(cooperation_classification, '';'') within GROUP(ORDER BY 1)
      INTO v_cate
      FROM scmdata.t_ask_scope a
     WHERE a.object_id IN (SELECT T.ASK_RECORD_ID
         FROM SCMDATA.T_FACTORY_ASK T
        WHERE T.FACTORY_ASK_ID = v_factory_ask_id) 
       AND a.company_id = %default_company_id%;

    v_sql := q''[SELECT DISTINCT A.SUPPLIER_INFO_ID      AR_RELA_SUPPLIER_ID_N,
       A.SUPPLIER_COMPANY_NAME RELA_SUPPLIER_ID_DESC
  FROM SCMDATA.T_SUPPLIER_INFO A
  INNER JOIN SCMDATA.T_COOP_SCOPE B ON A.SUPPLIER_INFO_ID=B.SUPPLIER_INFO_ID AND A.COMPANY_ID=B.COMPANY_ID
 WHERE A.COMPANY_ID = %default_company_id%
   AND A.pause <> 1
   AND A.STATUS = 1
   AND B.PAUSE = 0
   AND A.COOPERATION_MODEL <> ''OF''
   AND INSTR('';''||'']'' || v_cate || q''[''||'';'','';''||B.COOP_CLASSIFICATION||'';'')>0]'';
  END IF;
  @strresult := v_sql;
END;
}';
UPDATE bw3.sys_look_up t SET t.look_up_sql = v_sql WHERE t.element_id = 'lookup_a_coop_150_3_0'; 
END;
/

