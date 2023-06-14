BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_approve_111_1', 'associate', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_approve_111_2', 'associate', 'oracle_scmdata', 0, null, 1, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_approve_111_3', 'associate', 'oracle_scmdata', 0, null, 1, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_approve_111_4', 'associate', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_approve_310_1_1', 'associate', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_good_110', 'associate', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_good_110_1', 'associate', 'oracle_scmdata', 0, null, 1, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_good_110_2', 'associate', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('associate_a_good_310_1_1', 'associate', 'oracle_scmdata', 0, null, 0, null, null, null, null);
END;
/
BEGIN
 insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_approve_310_1', 'associate_a_approve_111_1', 'GOO_ID', 6, '���ɳߴ��', null, 2, '{DECLARE
  v_sql                         CLOB;
BEGIN
  scmdata.pkg_approve_version_size_chart.p_delete_t_size_chart_all_tmp_data(p_goo_id => :goo_id,p_company_id => %default_company_id%);
  v_sql      := ''select '''''' || :goo_id  || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_approve_310_3', 'associate_a_approve_111_2', 'GOO_ID', 6, '�ߴ��', null, 2, '{DECLARE
  v_sql  CLOB;
  v_methods                     VARCHAR2(256) := ''GET;POST;PUT;DELETE'';
  v_flag INT;
BEGIN
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart(p_goo_id     => :goo_id,p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, ''�û���δ���ɳߴ��'');
  END IF;
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_approve_310_3', 'associate_a_approve_111_3', 'GOO_ID', 6, '�ߴ��', null, 2, '{DECLARE
  v_sql                         CLOB;
  v_methods                     VARCHAR2(256) := ''GET'';
  v_flag INT;
BEGIN
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart(p_goo_id     => :goo_id,p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, ''�û���δ���ɳߴ��'');
  END IF;
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_good_310_4', 'associate_a_approve_111_4', 'GOO_ID', 6, '�ߴ����', null, 2, '{DECLARE
  v_sql     CLOB;
  v_methods VARCHAR2(256) := ''GET;POST;PUT;DELETE'';
  v_params  VARCHAR2(4000);
  v_goo_size_chart_type VARCHAR2(32);
BEGIN
  --��������ǰ ���������
  --������Ʒ����-����� ��ʼ���ߴ絼���
  scmdata.pkg_size_chart.p_reset_size_chart_imp_tmp_data(p_company_id => %default_company_id%,
                                                         p_goo_id     => :goo_id,
                                                         p_user_id    => :user_id);

  v_goo_size_chart_type := scmdata.pkg_size_chart.f_get_good_size_chart_type(p_company_id => %default_company_id%,
                                                                             p_goo_id     => :goo_id);
                                                                             
  --ass ����Я��
  v_params   := ''"item_id"'' || '':'' || ''"'' || ''a_approve_111'' || ''"'';
  v_params   := v_params || '','' || ''"goo_size_chart_type"'' || '':'' || ''"'' || v_goo_size_chart_type || ''"'';
  v_params   := ''{'' || v_params || ''}'';
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_approve_310_2', 'associate_a_approve_310_1_1', 'GOO_ID', 2, '�ύ', null, 2, null, null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_good_310_1', 'associate_a_good_110', 'GOO_ID', 6, '���ɳߴ��', null, 2, '{DECLARE
  v_sql                         CLOB;
BEGIN
  scmdata.pkg_size_chart.p_delete_t_size_chart_all_tmp_data(p_goo_id => :goo_id,p_company_id => %default_company_id%);
  v_sql      := ''select '''''' || :goo_id  || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_good_310_3', 'associate_a_good_110_1', 'GOO_ID', 6, '�ߴ��', null, 2, '{DECLARE
  v_sql  CLOB;
  v_flag INT;
BEGIN
  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart(p_goo_id     => :goo_id,
                                                             p_company_id => %default_company_id%);
  IF v_flag = 0 THEN
    raise_application_error(-20002, ''�û���δ���ɳߴ��'');
  END IF;
  v_sql      := ''select '''''' || :goo_id || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_good_310_4', 'associate_a_good_110_2', 'GOO_ID', 6, '�ߴ����', null, 2, '{DECLARE
  v_sql                 CLOB;
  v_methods             VARCHAR2(256) := ''GET;POST;PUT;DELETE'';
  v_params              VARCHAR2(4000);
  v_goo_size_chart_type VARCHAR2(32);
BEGIN
  --��������ǰ ���������
  --������Ʒ����-����� ��ʼ���ߴ絼���
  scmdata.pkg_size_chart.p_reset_size_chart_imp_tmp_data(p_company_id => %default_company_id%,
                                                         p_goo_id     => :goo_id,
                                                         p_user_id    => :user_id);
  v_goo_size_chart_type := scmdata.pkg_size_chart.f_get_good_size_chart_type(p_company_id => %default_company_id%,
                                                                             p_goo_id     => :goo_id);
  --ass ����Я��
  v_params   := ''"item_id"'' || '':'' || ''"'' || ''a_good_110'' || ''"'';
  v_params   := v_params || '','' || ''"goo_size_chart_type"'' || '':'' || ''"'' || v_goo_size_chart_type || ''"'';
  
  v_params   := ''{'' || v_params || ''}'';
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;}', null);

insert into bw3.sys_associate (NODE_ID, ELEMENT_ID, FIELD_NAME, ASSOCIATE_TYPE, CAPTION, ICON_NAME, DATA_TYPE, DATA_SQL, OPEN_TYPE)
values ('node_a_good_310_2', 'associate_a_good_310_1_1', 'GOO_ID', 2, '�ύ', null, 2, null, null);

END;
/
BEGIN
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_1', 'associate_a_good_310_1_1', 1, 1, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_112', 'associate_a_approve_111_3', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_111', 'associate_a_approve_111_4', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_110', 'associate_a_good_110', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_110', 'associate_a_good_110_2', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_110', 'associate_a_good_110_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_111', 'associate_a_approve_111_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_111', 'associate_a_approve_111_2', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_1', 'associate_a_approve_310_1_1', 1, 1, null);

END;
/
BEGIN
insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_approve_112', 'associate_a_approve_111_3', null, 0, 'STANDARD_SIZE_CHART', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_good_110', 'associate_a_good_110_1', null, 0, 'STANDARD_SIZE_CHART', null, null);

insert into bw3.sys_element_hint (ITEM_ID, ELEMENT_ID, MESSAGE, PAUSE, LINK_NAME, JUDGE_FIELD, HINT_TYPE)
values ('a_approve_111', 'associate_a_approve_111_2', null, 0, 'STANDARD_SIZE_CHART', null, null);
END;
/
BEGIN
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_associate_a_approve_110', 'select 1 from dual', 1, '{DECLARE
  v_sql CLOB;
  v_flag INT;
BEGIN
  IF :goo_id IS NULL THEN
    raise_application_error(-20002, ''���ȹ�ѡ�����ɳߴ��Ļ��ţ���'');
  ELSE
  --�û��Ŷ�Ӧ�Ĳ�Ʒ������δ���óߴ��ģ�壬��������
  scmdata.pkg_size_chart.p_check_size_chart_moudle(p_company_id => %default_company_id%,p_goo_id => :goo_id);
  --�ж��Ƿ���ڳߴ��ҵ���
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart(p_company_id => %default_company_id%, p_goo_id => :goo_id);
  IF v_flag > 0 THEN
    v_sql := q''[SELECT ''�û��������ɳߴ��ȷ���������ɣ�'' FROM dual]'';
  ELSE
    v_sql := q''[SELECT ''�Ƿ����ɳߴ��'' FROM dual]'';
  END IF;
  END IF;
  @strresult := v_sql;
END;}', 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_associate_a_good_110', 'select 1 from dual', 1, '{DECLARE
  v_sql  CLOB;
  v_flag INT;
BEGIN
  IF :goo_id IS NULL THEN
    raise_application_error(-20002, ''���ȹ�ѡ�����ɳߴ��Ļ��ţ���'');
  ELSE
    --�û��Ŷ�Ӧ�Ĳ�Ʒ������δ���óߴ��ģ�壬��������
    scmdata.pkg_size_chart.p_check_size_chart_moudle(p_company_id => %default_company_id%,p_goo_id => :goo_id);
    --�ж��Ƿ���ڳߴ��ҵ���
    v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart(p_company_id => %default_company_id%,
                                                               p_goo_id     => :goo_id);
    IF v_flag > 0 THEN
      v_sql := q''[SELECT ''�û��������ɳߴ��ȷ���������ɣ�'' FROM dual]'';
    ELSE
      v_sql := q''[SELECT ''�Ƿ����ɳߴ��'' FROM dual]'';
    END IF;
  END IF;
  @strresult := v_sql;
END;}', 'oracle_scmdata', null, null);
END;
/
BEGIN
insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_associate_a_approve_110', 95, 'associate_a_approve_111_1', 1, null, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_associate_a_good_110', 95, 'associate_a_good_110', 1, null, 0, null);
END;
/
/
