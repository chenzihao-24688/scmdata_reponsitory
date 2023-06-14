prompt Importing table nbw.sys_look_up...
set feedback off
set define off

insert into nbw.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_118_1', 'CHECKER_DESC', '{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql := scmdata.pkg_production_progress_a.f_get_checker_look_sql(p_data_source => ''SC'',
                                                                    p_company_id  => %default_company_id%);
  IF :origin = ''MA'' THEN
    v_sql := scmdata.pkg_production_progress_a.f_get_checker_look_sql(p_data_source => ''MA'',
                                                                      p_company_id  => %default_company_id%);
  END IF;
  @strresult := v_sql;
END;
}', '1', 'CHECKER', 'CHECKER_DESC', 'CHECKER', 0, 1, '0', null, ';', null, null, null);

insert into nbw.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_118_2', 'CHECK_GD_LINK_DESC', '{
DECLARE
  v_sql1 CLOB;
  v_sql2 CLOB;
  v_sql  CLOB;
BEGIN
  v_sql1 := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => ''QC_CHECK_NODE_DICT'',
                                                           p_field_value     => ''CHECK_LINK'',
                                                           p_field_desc      => ''CHECK_GD_LINK_DESC'');
  v_sql2 := scmdata.pkg_plat_comm.f_get_lookup_sql_by_type(p_group_dict_type => ''QA_CHECKTYPE'',
                                                           p_field_value     => ''CHECK_LINK'',
                                                           p_field_desc      => ''CHECK_GD_LINK_DESC'');

  v_sql := v_sql1 || '' UNION ALL '' || v_sql2;
  IF :abnormal_orgin IN (''ed7ff3c7135a236ae0533c281caccd8d'', ''14'') THEN
    v_sql := v_sql1;
  ELSIF :abnormal_orgin IN (''16'') THEN
    v_sql := v_sql2;
  ELSE
    NULL;
  END IF;
  @strresult := v_sql;
END;
}', '1', 'CHECK_LINK', 'CHECK_GD_LINK_DESC', 'CHECK_LINK', 0, 0, '0', null, null, null, null, null);

insert into nbw.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_120_1', 'ABN_ORGIN_DESC', '{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_production_progress_a.f_get_abn_source_look_sql(p_company_id => %default_company_id%);
  @strresult := v_sql;
END;
}', '1', 'ABNORMAL_ORGIN', 'ABN_ORGIN_DESC', 'ABNORMAL_ORGIN', 0, 0, '0', null, null, null, null, null);

insert into nbw.sys_look_up (ELEMENT_ID, FIELD_NAME, LOOK_UP_SQL, DATA_TYPE, KEY_FIELD, RESULT_FIELD, BEFORE_FIELD, SEARCH_FLAG, MULTI_VALUE_FLAG, DISABLED_FIELD, GROUP_FIELD, VALUE_SEP, ICON, PORT_ID, PORT_SQL)
values ('look_a_product_120_1_1', 'ORIGIN_DESC', '{
DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_production_progress_a.f_get_data_source_look_sql();
  @strresult := v_sql;
END;
}', '1', 'ORIGIN', 'ORIGIN_DESC', 'ORIGIN', 0, 0, '0', null, null, null, null, null);

prompt Done.
