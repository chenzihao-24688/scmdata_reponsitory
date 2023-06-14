DECLARE
v_sql CLOB;
BEGIN
  v_sql := 'DECLARE
  v_goo_id VARCHAR2(32);
BEGIN
  scmdata.pkg_approve_insert.p_approver_result_verify(v_avid => :approve_version_id,
                                                      v_cpid => %default_company_id%,
                                                      v_usid => %current_userid%);
  --20221018 czh add 
  SELECT MAX(t.goo_id)
    INTO v_goo_id
    FROM scmdata.t_approve_version t
   WHERE t.approve_version_id = :approve_version_id
     AND t.company_id = %default_company_id%;

  --批版单据生成尺寸表，点击审核后同步更新至同货号商品档案                                                   
  scmdata.pkg_approve_version_size_chart.p_sync_apv_size_chart_to_gd_by_examine(p_company_id => %default_company_id%,
                                                                                p_goo_id     => v_goo_id);
END;

--原逻辑
--CALL SCMDATA.PKG_APPROVE_INSERT.P_APPROVER_RESULT_VERIFY(V_AVID => :APPROVE_VERSION_ID, V_CPID => %DEFAULT_COMPANY_ID%, V_USID => %CURRENT_USERID%)';
UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_approve_111_0';

END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_2_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_1_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_1_2', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_4_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_4_2', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_4_3', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_3_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_1_3', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_approve_310_3_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_approve_111_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_approve_310_1_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_approve_310_1_2', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_approve_310_2_1', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

END;
/
BEGIN
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_approve_111_1', '调整序号', 'icon-morencaidan', 4, 'DECLARE
    v_new_seq_num varchar2(32) := @new_seq_num@;
BEGIN
  scmdata.pkg_size_chart.p_check_new_seq_no(p_new_seq_num => v_new_seq_num);
  scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                    p_goo_id        => :goo_id,
                                                    p_orgin_seq_num => :seq_num,
                                                    p_new_seq_num   => v_new_seq_num,
                                                    p_type          => 0,
                                                    p_table         => ''t_approve_version_size_chart_tmp'',
                                                    p_table_pk_id   => ''size_chart_tmp_id'',
                                                    p_is_check      => 1);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_approve_310_1_1', '选择模板', 'icon-morencaidan', 4, 'DECLARE
  v_size_chart_moudle VARCHAR2(32) := @size_chart_moudle@;
BEGIN
  scmdata.pkg_approve_version_size_chart.p_generate_size_chart_tmp(p_company_id        => %default_company_id%,
                                                                   p_goo_id            => :goo_id,
                                                                   p_user_id           => :user_id,
                                                                   p_size_chart_moudle => v_size_chart_moudle);

  --选择时携带变量
  scmdata.pkg_variable.p_ins_or_upd_variable(v_objid   => :user_id,
                                             v_compid  => %default_company_id%,
                                             v_varname => ''APV_SIZE_CHART_MOUDLE'',
                                             v_vartype => ''VARCHAR'',
                                             v_varchar => v_size_chart_moudle);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_approve_310_1_2', '提交', 'icon-morencaidan', 4, 'BEGIN
  scmdata.pkg_approve_version_size_chart.p_generate_size_chart_dt_tmp(p_company_id => %default_company_id%,
                                                                      p_goo_id     => :goo_id,
                                                                      p_user_id    => :user_id);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_approve_310_2_1', '提交', 'icon-morencaidan', 4, 'DECLARE
  v_goo_id VARCHAR2(32);
BEGIN
  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''APV_SIZE_CHART_GOO_ID'');

  scmdata.pkg_approve_version_size_chart.p_generate_size_chart(p_company_id => %default_company_id%,
                                                               p_goo_id     => v_goo_id);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_approve_310_3_1', '调整序号', 'icon-morencaidan', 4, 'DECLARE
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
  v_new_seq_num varchar2(32) := @new_seq_num@;
BEGIN
  scmdata.pkg_size_chart.p_check_new_seq_no(p_new_seq_num => v_new_seq_num);
  --获取asscoiate请求参数
  plm.pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                                 po_pk_id        => v_goo_id,
                                                 po_rest_methods => v_rest_method,
                                                 po_params       => v_params);

  scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                    p_goo_id        => v_goo_id,
                                                    p_orgin_seq_num => :seq_num,
                                                    p_new_seq_num   => v_new_seq_num,
                                                    p_type          => 0,
                                                    p_table         => ''t_approve_version_size_chart'',
                                                    p_table_pk_id   => ''size_chart_id'',
                                                    p_is_check      => 1);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_1_1', '选择模板', 'icon-morencaidan', 4, 'DECLARE
  v_size_chart_moudle VARCHAR2(32) := @size_chart_moudle@;
BEGIN
  scmdata.pkg_size_chart.p_generate_size_chart_tmp(p_company_id        => %default_company_id%,
                                                   p_goo_id            => :goo_id,
                                                   p_user_id           => :user_id,
                                                   p_size_chart_moudle => v_size_chart_moudle);

  --选择时携带变量
  scmdata.pkg_variable.p_ins_or_upd_variable(v_objid   => :user_id,
                                             v_compid  => %default_company_id%,
                                             v_varname => ''SIZE_CHART_MOUDLE'',
                                             v_vartype => ''VARCHAR'',
                                             v_varchar => v_size_chart_moudle);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_1_2', '提交', 'icon-morencaidan', 4, 'BEGIN
  scmdata.pkg_size_chart.p_generate_size_chart_dt_tmp(p_company_id => %default_company_id%,
                                                      p_goo_id     => :goo_id,
                                                      p_user_id    => :user_id);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_1_3', '调整序号', 'icon-morencaidan', 4, 'DECLARE
    v_new_seq_num varchar2(32) := @new_seq_num@;
BEGIN
  scmdata.pkg_size_chart.p_check_new_seq_no(p_new_seq_num => v_new_seq_num);
  scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                    p_goo_id        => :goo_id,
                                                    p_orgin_seq_num => :seq_num,
                                                    p_new_seq_num   => v_new_seq_num,
                                                    p_type          => 0,
                                                    p_table         => ''t_size_chart_tmp'',
                                                    p_table_pk_id   => ''size_chart_tmp_id'',
                                                    p_is_check      => 1);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_2_1', '提交', 'icon-morencaidan', 4, 'DECLARE
  v_goo_id VARCHAR2(32);
BEGIN
  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''SIZE_CHART_GOO_ID'');
                                                 
  scmdata.pkg_size_chart.p_generate_size_chart(p_company_id => %default_company_id%,
                                               p_goo_id     => v_goo_id);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_3_1', '调整序号', 'icon-morencaidan', 4, 'DECLARE
    v_new_seq_num varchar2(32) := @new_seq_num@;
BEGIN
  scmdata.pkg_size_chart.p_check_new_seq_no(p_new_seq_num => v_new_seq_num);
  scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                    p_goo_id        => :goo_id,
                                                    p_orgin_seq_num => :seq_num,
                                                    p_new_seq_num   => v_new_seq_num,
                                                    p_type          => 0,
                                                    p_table         => ''t_size_chart'',
                                                    p_table_pk_id   => ''size_chart_id'',
                                                    p_is_check      => 1);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_4_1', '提交', 'icon-morencaidan', 4, '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(4000);
  v_item_id     VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                             po_pk_id        => v_goo_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);
                                             
  v_item_id := plm.pkg_plat_comm.parse_json(p_jsonstr => v_params,
                                            p_key     => ''item_id'');

  IF v_item_id = ''a_good_110'' THEN
    v_sql := q''[
DECLARE
  v_goo_id      VARCHAR2(32) := '']'' || v_goo_id || q''['';
BEGIN
  scmdata.pkg_size_chart.p_generate_size_chart_by_good_import(p_goo_id => v_goo_id,p_company_id => %default_company_id%);
END;]'';
  ELSIF v_item_id = ''a_approve_111'' THEN
    v_sql := q''[
DECLARE
  v_goo_id      VARCHAR2(32) := '']'' || v_goo_id || q''['';
BEGIN
  scmdata.pkg_size_chart.p_generate_size_chart_by_apv_import(p_goo_id => v_goo_id,p_company_id => %default_company_id%);
END;]'';
  ELSE
    NULL;
  END IF;
  @strresult := v_sql;
END;}', null, 3, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_4_2', '重置', 'icon-morencaidan', 4, 'DECLARE
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(4000);
  v_item_id     VARCHAR2(32);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                             po_pk_id        => v_goo_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  --重置
  --导入数据前 先清空数据
  --根据商品档案-尺码表 初始化尺寸导入表
  scmdata.pkg_size_chart.p_reset_size_chart_imp_tmp_data(p_company_id => %default_company_id%,
                                                         p_goo_id     => v_goo_id,
                                                         p_user_id    => :user_id);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_4_3', '添加尺码', 'icon-morencaidan', 4, 'DECLARE
  v_goo_id              VARCHAR2(32);
  v_rest_method         VARCHAR2(256);
  v_params              VARCHAR2(4000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                             po_pk_id        => v_goo_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  scmdata.pkg_size_chart.p_insert_size_chart_col(p_company_id => %default_company_id%,
                                                 p_goo_id     => v_goo_id,
                                                 p_user_id    => :user_id,
                                                 p_size_col   => @goo_size_chart_type@);
END;', null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

END;
/
BEGIN
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_1', 'action_a_approve_310_1_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_1', 'action_a_approve_310_1_2', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_2', 'action_a_approve_310_2_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_4', 'action_a_good_310_4_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_4', 'action_a_good_310_4_2', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_1', 'action_a_good_310_1_3', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_2', 'action_a_good_310_1_3', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_3', 'action_a_approve_310_3_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_1', 'action_a_approve_111_1', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_2', 'action_a_approve_111_1', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_4', 'action_a_good_310_4_3', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_3', 'action_a_good_310_3_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_1', 'action_a_good_310_1_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_1', 'action_a_good_310_1_2', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_2', 'action_a_good_310_2_1', 1, 0, null);

END;
/
BEGIN
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_approve_310_1_2', 'select 0 flag from dual where 1=1', 1, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_approve_310_2_1', 'select 0 flag from dual where 1=1', 1, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_good_310_1_2', 'select 0 flag from dual where 1=1', 1, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_good_310_2_1', 'select 0 flag from dual where 1=1', 1, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_approve_310_1_2', 91, 'action_a_approve_310_1_2', 2, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_approve_310_2_1', 91, 'action_a_approve_310_2_1', 2, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_good_310_1_2', 91, 'action_a_good_310_1_2', 2, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_good_310_2_1', 91, 'action_a_good_310_2_1', 2, 1, 0, null);

insert into bw3.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_a_good_310_2_1', '提示', '已生成尺寸表，是否前往商品档案页面？', 'a_good_110', null);

insert into bw3.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_a_good_310_1_2', '提示', '是否前往生成尺寸表页面？', 'a_good_310_2', null);

insert into bw3.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_a_approve_310_1_2', '提示', '是否前往生成尺寸表页面？', 'a_approve_310_2', null);

insert into bw3.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_a_approve_310_2_1', '提示', '已生成尺寸表，是否前往待批版页面？', 'a_approve_111', null);

END;
/
