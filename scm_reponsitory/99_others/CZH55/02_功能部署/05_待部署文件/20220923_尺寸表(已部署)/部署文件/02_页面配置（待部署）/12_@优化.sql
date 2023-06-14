prompt Importing table bw3.sys_associate...
set feedback off
set define off

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_approve_310_3', 'associate_a_approve_111_2', 'GOO_ID', 6, '尺寸表', null, 2, '{
DECLARE
  v_sql         CLOB;
  v_methods     VARCHAR2(256) := ''GET;POST;PUT;DELETE'';
  v_flag        INT;
  v_rela_goo_id VARCHAR2(32);
  v_params      VARCHAR2(4000);
BEGIN
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart(p_goo_id     => :goo_id,
                                                                             p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, ''该货号未生成尺寸表'');
  END IF;
  SELECT MAX(t.rela_goo_id)
    INTO v_rela_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.goo_id = :goo_id
     AND t.company_id = %default_company_id%;
  --ass 参数携带
  v_params   := ''"rela_goo_id"'' || '':'' || ''"'' || v_rela_goo_id || ''"'';
  v_params   := v_params || '','' || ''"is_show_element"'' || '':'' || ''"1"'';
  v_params   := ''{'' || v_params || ''}'';
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;
}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_approve_310_3', 'associate_a_approve_111_3', 'GOO_ID', 6, '尺寸表', null, 2, '{
DECLARE
  v_sql                         CLOB;
  v_methods                     VARCHAR2(256) := ''GET'';
  v_flag                        INT;
  v_rela_goo_id VARCHAR2(32);
  v_params      VARCHAR2(4000);
BEGIN
    v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart(p_goo_id => :goo_id,p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, ''该货号未生成尺寸表'');
  END IF;
  SELECT MAX(t.rela_goo_id)
    INTO v_rela_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.goo_id = :goo_id
     AND t.company_id = %default_company_id%;
  --ass 参数携带
  v_params   := ''"rela_goo_id"'' || '':'' || ''"'' || v_rela_goo_id || ''"'';
  v_params   := v_params || '','' || ''"is_show_element"'' || '':'' || ''"0"'';
  v_params   := ''{'' || v_params || ''}'';
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;
}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_good_310_3', 'associate_a_good_110_1', 'GOO_ID', 6, '尺寸表', null, 2, '{DECLARE
  v_sql  CLOB;
  v_flag INT;
BEGIN
  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart(p_goo_id     => :goo_id,
                                                             p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, ''该货号未生成尺寸表'');
  END IF;
  v_sql      := ''select '''''' || :goo_id || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;}', null);

prompt Done.
