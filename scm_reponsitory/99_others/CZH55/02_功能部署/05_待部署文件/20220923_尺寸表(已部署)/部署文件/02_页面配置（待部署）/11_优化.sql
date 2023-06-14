BEGIN
UPDATE bw3.sys_item_element_rela t SET t.pause = 0
 WHERE t.element_id in ('action_a_approve_310_3_1','action_a_approve_310_3_2');
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[{
DECLARE
  v_sql         CLOB;
  v_methods     VARCHAR2(256) := 'GET;POST;PUT;DELETE';
  v_flag        INT;
  v_rela_goo_id VARCHAR2(32);
  v_params      VARCHAR2(4000);
BEGIN
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart(p_goo_id     => :goo_id,
                                                                             p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, '该货号未生成尺寸表');
  END IF;
  SELECT MAX(t.rela_goo_id)
    INTO v_rela_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.goo_id = :goo_id
     AND t.company_id = %default_company_id%;
  --ass 参数携带
  v_params   := '"rela_goo_id"' || ':' || '"' || v_rela_goo_id || '"';
  v_params   := v_params || ',' || '"is_show_element"' || ':' || '"1"';
  v_params   := '{' || v_params || '}';
  v_sql      := 'select ''' || :goo_id || '/' || v_methods || '?' ||
                v_params || ''' GOO_ID from dual';
  @strresult := v_sql;
END;
}]';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_approve_111_2'; 
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[{
DECLARE
  v_sql                         CLOB;
  v_methods                     VARCHAR2(256) := 'GET';
  v_flag                        INT;
  v_rela_goo_id VARCHAR2(32);
  v_params      VARCHAR2(4000);
BEGIN
    v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart(p_goo_id => :goo_id,p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, '该货号未生成尺寸表');
  END IF;
  SELECT MAX(t.rela_goo_id)
    INTO v_rela_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.goo_id = :goo_id
     AND t.company_id = %default_company_id%;
  --ass 参数携带
  v_params   := '"rela_goo_id"' || ':' || '"' || v_rela_goo_id || '"';
  v_params   := v_params || ',' || '"is_show_element"' || ':' || '"0"';
  v_params   := '{' || v_params || '}';
  v_sql      := 'select ''' || :goo_id || '/' || v_methods || '?' ||
                v_params || ''' GOO_ID from dual';
  @strresult := v_sql;
END;
}]';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_approve_111_3'; 
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
v_sql1 := '{
DECLARE
  v_goo_id          VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(256);
  v_sql             CLOB;
  v_is_element_show VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  scmdata.pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                                     po_pk_id        => v_goo_id,
                                                     po_rest_methods => v_rest_method,
                                                     po_params       => v_params);

  --element是否显示
  v_is_element_show := scmdata.pkg_data_privs.parse_json(p_jsonstr => v_params,
                                                         p_key     => ''is_show_element'');
  IF v_is_element_show = ''1'' THEN
    v_sql := ''select max(1) from dual'';
  ELSE
    v_sql := ''select max(0) from dual'';
  END IF;
  @strresult := v_sql;
END;
}';
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_btn_a_approve_111_2', v_sql1, 0, null, 'oracle_scmdata', null, null);

v_sql2 := '{
DECLARE
  v_goo_id          VARCHAR2(32);
  v_rest_method     VARCHAR2(256);
  v_params          VARCHAR2(256);
  v_sql             CLOB;
  v_is_element_show VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  scmdata.pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                                     po_pk_id        => v_goo_id,
                                                     po_rest_methods => v_rest_method,
                                                     po_params       => v_params);

  --element是否显示
  v_is_element_show := scmdata.pkg_data_privs.parse_json(p_jsonstr => v_params,
                                                         p_key     => ''is_show_element'');
  IF v_is_element_show = ''1'' THEN
    v_sql := ''select max(1) from dual'';
  ELSE
    v_sql := ''select max(0) from dual'';
  END IF;
  @strresult := v_sql;
END;
}';
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_btn_a_approve_111_3', v_sql2, 0, null, 'oracle_scmdata', null, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_approve_310_3_2', 91, 'action_a_approve_310_3_2', 1, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_btn_a_approve_111_2', 91, 'action_a_approve_310_3_1', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_btn_a_approve_111_2', 91, 'action_a_approve_310_3_2', 0, 2, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_btn_a_approve_111_3', 91, 'action_a_approve_310_3_1', 0, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_btn_a_approve_111_3', 91, 'action_a_approve_310_3_2', 0, 2, 0, null);

END;
/
