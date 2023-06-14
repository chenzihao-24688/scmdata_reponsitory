DECLARE
v_sql CLOB;
BEGIN
v_sql := '{
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
  '||CHR(64)||'strresult := v_sql;
END;
}';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_approve_111_2';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{
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
  '||CHR(64)||'strresult := v_sql;
END;
}';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_approve_111_3';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{DECLARE
  v_sql  CLOB;
  v_flag INT;
BEGIN
  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart(p_goo_id     => :goo_id,
                                                             p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, ''该货号未生成尺寸表'');
  END IF;
  v_sql      := ''select '''''' || :goo_id || '''''' GOO_ID from dual'';
  '||CHR(64)||'strresult := v_sql;
END;}';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_good_110_1';
END;
/
