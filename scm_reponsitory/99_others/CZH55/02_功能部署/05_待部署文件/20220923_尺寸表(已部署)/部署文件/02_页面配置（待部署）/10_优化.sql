BEGIN
insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_approve_310_3_2', 'select max(0) from dual where 1 = 1', 1, '{
DECLARE
  v_grammage VARCHAR2(256) := @grammage@;
  v_goo_id VARCHAR2(32);
BEGIN
  v_goo_id :=  scmdata.pkg_plat_comm.f_get_rest_val_method_params(p_character => :goo_id,p_rtn_type => 1);
  --判断是否已存在克重
  scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => v_goo_id,
                                           p_table      => ''t_approve_version_size_chart'',
                                           p_grammage   => v_grammage,
                                           p_type       => 1);

  @strresult := q''[SELECT ''“ ]'' || v_grammage ||
                q''[”新增成功，请填写对应的尺码克重'' FROM dual]'';
END;
}', 'oracle_scmdata', null, null);

insert into bw3.sys_cond_list (COND_ID, COND_SQL, COND_TYPE, SHOW_TEXT, DATA_SOURCE, COND_FIELD_NAME, MEMO)
values ('cond_action_a_good_310_3_2', 'select max(0) from dual where 1 = 1', 1, '{
DECLARE
  v_grammage VARCHAR2(256) := @grammage@;
BEGIN
  --判断是否已存在克重
  scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => :goo_id,
                                           p_table      => ''t_size_chart'',
                                           p_grammage   => v_grammage,
                                           p_type       => 1);

  @strresult := q''[SELECT ''“ ]'' || v_grammage ||
                q''[”新增成功，请填写对应的尺码克重'' FROM dual]'';
END;
}', 'oracle_scmdata', null, null);
END;
/
BEGIN
  
insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_approve_310_3_2', 91, 'action_a_approve_310_3_2', 1, 1, 0, null);

insert into bw3.sys_cond_rela (COND_ID, OBJ_TYPE, CTL_ID, CTL_TYPE, SEQ_NO, PAUSE, ITEM_ID)
values ('cond_action_a_good_310_3_2', 91, 'action_a_good_310_3_2', 1, 1, 0, null);
END;
/  
BEGIN
  insert into bw3.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_a_approve_310_3_2', '提示', 'SELECT ''“''|| @grammage@ || ''”新增成功，请填写对应的尺码克重'' FROM dual', 'a_approve_310_3', 'a_approve_310_3');

insert into bw3.sys_cond_operate (COND_ID, CAPTION, CONTENT, TO_CONFIRM_ITEM_ID, TO_CANCEL_ITEM_ID)
values ('cond_action_a_good_310_3_2', '提示', 'SELECT ''“''|| @grammage@ || ''”新增成功，请填写对应的尺码克重'' FROM dual', 'a_good_310_3', 'a_good_310_3');
END;
/
