BEGIN
insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_approve_310_1', 'list', '尺寸表模板', 'oracle_scmdata', 'T_APPROVE_VERSION_SIZE_CHART_TMP', 'SIZE_CHART_TMP_ID', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 4, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_approve_310_2', 'list', '生成尺寸表', 'oracle_scmdata', 'T_APPROVE_VERSION_SIZE_CHART_DETAILS_TMP', 'SIZE_CHART_DT_TMP_ID', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 4, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_approve_310_3', 'list', '尺寸表', 'oracle_scmdata', 'T_APPROVE_VERSION_SIZE_CHART', 'SIZE_CHART_ID', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 4, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_good_310_1', 'list', '尺寸表模板', 'oracle_scmdata', 'T_SIZE_CHART_TMP', 'SIZE_CHART_TMP_ID', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 4, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_good_310_2', 'list', '生成尺寸表', 'oracle_scmdata', 'T_SIZE_CHART_DETAILS_TMP', 'SIZE_CHART_DT_TMP_ID', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 4, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_good_310_3', 'list', '尺寸表', 'oracle_scmdata', 'T_SIZE_CHART', 'SIZE_CHART_ID', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 4, 1, null);

insert into bw3.sys_item (ITEM_ID, ITEM_TYPE, CAPTION_SQL, DATA_SOURCE, BASE_TABLE, KEY_FIELD, NAME_FIELD, SETTING_ID, REPORT_TITLE, SUB_SCRIPTS, PAUSE, LINK_FIELD, HELP_ID, TAG_ID, CONFIG_PARAMS, TIME_OUT, OFFLINE_FLAG, PANEL_ID, INIT_SHOW, BADGE_FLAG, BADGE_SQL, MEMO, SHOW_ROWID, ENABLE_STAND_PERMISSION, FIX_CAPTION)
values ('a_good_310_4', 'list', '尺寸表导入', 'oracle_scmdata', 'T_SIZE_CHART_IMPORT_TMP', 'SIZE_CHART_TMP_ID', null, null, null, null, 0, null, null, null, null, null, null, null, null, null, null, null, 5, 1, null);
END;
/
BEGIN
insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_approve_310_1', 'tree_a_approve_1', 'a_approve_310_1', null, null, 'scm', 'icon-ziyuanhetong', 0, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_approve_310_2', 'tree_a_approve_1', 'a_approve_310_2', null, null, 'scm', 'icon-ziyuanhetong', 0, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_approve_310_3', 'tree_a_approve_1', 'a_approve_310_3', null, null, 'scm', 'icon-ziyuanhetong', 0, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_good_310_1', 'tree_a_good_1', 'a_good_310_1', null, null, 'scm', 'icon-ziyuanhetong', 0, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_good_310_2', 'tree_a_good_1', 'a_good_310_2', null, null, 'scm', 'icon-ziyuanhetong', 0, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_good_310_3', 'tree_a_good_1', 'a_good_310_3', null, null, 'scm', 'icon-ziyuanhetong', 0, null, 1, 0, 0, null, null, 1, 1, null);

insert into bw3.sys_tree_list (NODE_ID, TREE_ID, ITEM_ID, PARENT_ID, VAR_ID, APP_ID, ICON_NAME, IS_END, STAND_PRIV_FLAG, SEQ_NO, PAUSE, TERMINAL_FLAG, CAPTION_EXPLAIN, COMPETENCE_FLAG, NODE_TYPE, IS_AUTHORIZE, ENABLE_STAND_PERMISSION)
values ('node_a_good_310_4', 'tree_a_good_1', 'a_good_310_4', null, null, 'scm', 'icon-ziyuanhetong', 0, null, 1, 0, 0, null, null, 1, 1, null);

END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
BEGIN
v_sql1 := 'DECLARE
  p_t_siz_rec t_approve_version_size_chart_tmp%ROWTYPE;
  v_base_code VARCHAR2(32);
BEGIN
  p_t_siz_rec.size_chart_tmp_id   := scmdata.f_get_uuid();
  p_t_siz_rec.company_id          := %default_company_id%;
  p_t_siz_rec.goo_id              := :goo_id;
  p_t_siz_rec.seq_num             := scmdata.pkg_size_chart.f_get_size_chart_seq_num(p_company_id => %default_company_id%,
                                                                                     p_goo_id => :goo_id,
                                                                                     p_table => ''t_approve_version_size_chart_tmp'');
  p_t_siz_rec.position            := :position;
  p_t_siz_rec.quantitative_method := :quantitative_method;

  SELECT MAX(base_code) INTO v_base_code FROM (SELECT DISTINCT t.base_code   
    FROM t_approve_version_size_chart_tmp t
   WHERE t.goo_id = :goo_id
     AND t.company_id = %default_company_id%);

  p_t_siz_rec.base_code              := v_base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;
  --校验是否选择模板，未选择模板则不允许新增
  scmdata.pkg_approve_version_size_chart.p_check_is_has_size_chart_moudle_data(p_company_id => %default_company_id%,p_goo_id   => :goo_id);
  --新增批版尺寸临时表                                                             
  scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
END;';

v_sql2 := 'DECLARE
  p_t_siz_rec t_approve_version_size_chart_tmp%ROWTYPE;
BEGIN
  p_t_siz_rec.size_chart_tmp_id      := :size_chart_tmp_id;
  p_t_siz_rec.company_id             := %default_company_id%;
  p_t_siz_rec.goo_id                 := :goo_id;
  p_t_siz_rec.seq_num                := :seq_num;
  p_t_siz_rec.position               := :position;
  p_t_siz_rec.quantitative_method    := :quantitative_method;
  p_t_siz_rec.base_code              := :base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;

  scmdata.pkg_approve_version_size_chart.p_update_t_approve_version_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
END;';

v_sql3 := 'DECLARE
  v_flag INT := 0;
BEGIN
  v_flag := scmdata.pkg_size_chart.f_is_has_size_chart_row_data(p_company_id          => %default_company_id%,
                                                                p_goo_id              => :goo_id,
                                                                p_position            => :position,
                                                                p_quantitative_method => :quantitative_method,
                                                                p_table               => ''t_approve_version_size_chart_tmp'');

  IF v_flag > 0 THEN
  
    scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                      p_goo_id        => :goo_id,
                                                      p_orgin_seq_num => :seq_num, --原序号
                                                      p_type          => 1,
                                                      p_table         => ''t_approve_version_size_chart_tmp'',
                                                      p_table_pk_id   => ''size_chart_tmp_id'');
    --删除校验
    scmdata.pkg_approve_version_size_chart.p_check_size_chart_tmp_by_delete(p_company_id => %default_company_id%,
                                                                            p_goo_id     => :goo_id);
    --删除尺寸临时表行数据
    scmdata.pkg_approve_version_size_chart.p_delete_t_approve_version_size_chart_tmp(p_size_chart_tmp_id => :size_chart_tmp_id);
  END IF;
END;';
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_approve_310_1', 13, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_approve_version_size_chart.f_query_t_approve_version_size_chart_tmp();
  @strresult := v_sql;
END;}', null, null, v_sql1, v_sql2, v_sql3, 'goo_id,company_id,size_chart_tmp_id,base_code', null, null, 'SEQ_NUM', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
BEGIN
  v_sql1 := 'DECLARE
  p_t_siz_rec         t_approve_version_size_chart_tmp%ROWTYPE;
  p_t_siz_dt_rec      t_approve_version_size_chart_details_tmp%ROWTYPE;
  v_goo_id            VARCHAR2(32);
  v_base_code         VARCHAR2(32);
  v_size_chart_tmp_id VARCHAR2(32);
  v_flag              INT;
  v_sizename          VARCHAR2(32);
BEGIN

  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''APV_SIZE_CHART_GOO_ID'');

  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart_tmp_data(p_company_id          => %default_company_id%,
                                                                                      p_goo_id              => v_goo_id,
                                                                                      p_position            => :position,
                                                                                      p_quantitative_method => :quantitative_method);

  IF v_flag = 0 THEN
    SELECT MAX(base_code) INTO v_base_code FROM (SELECT DISTINCT ts.base_code
      FROM scmdata.t_approve_version_size_chart_tmp ts
     WHERE ts.goo_id = v_goo_id
       AND ts.company_id = %default_company_id%);
  
    p_t_siz_rec.size_chart_tmp_id      := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := v_goo_id;
    p_t_siz_rec.seq_num                := scmdata.pkg_size_chart.f_get_size_chart_seq_num(p_company_id => %default_company_id%,
                                                                                          p_goo_id => v_goo_id,
                                                                                          p_table => ''t_approve_version_size_chart_tmp'');
    p_t_siz_rec.position               := :position;
    p_t_siz_rec.quantitative_method    := :quantitative_method;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
    p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := :user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := :user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --新增尺寸表主表
    scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
  END IF;

  SELECT DISTINCT t.size_chart_tmp_id
    INTO v_size_chart_tmp_id
    FROM scmdata.t_approve_version_size_chart_tmp t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = v_goo_id
     AND t.position = :position
     AND t.quantitative_method = :quantitative_method;

  p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
  p_t_siz_dt_rec.size_chart_id        := v_size_chart_tmp_id;
  v_sizename                          := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,
                                                                                        p_size_name  => :measure);
  p_t_siz_dt_rec.measure              := v_sizename;
  --尺码校验
  scmdata.pkg_approve_version_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value := :measure_value;
  p_t_siz_dt_rec.pause         := 0;
  p_t_siz_dt_rec.create_id     := :user_id;
  p_t_siz_dt_rec.create_time   := SYSDATE;
  p_t_siz_dt_rec.update_id     := :user_id;
  p_t_siz_dt_rec.update_time   := SYSDATE;
  p_t_siz_dt_rec.memo          := NULL;
  --新增尺码
  scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_dt_tmp(p_t_siz_rec => p_t_siz_dt_rec);
END;';

v_sql2 := 'DECLARE
  p_t_siz_rec         t_approve_version_size_chart_tmp%ROWTYPE;
  p_t_siz_dt_rec      t_approve_version_size_chart_details_tmp%ROWTYPE;
  v_goo_id            VARCHAR2(32);
  v_base_code         VARCHAR2(32);
  v_size_chart_tmp_id VARCHAR2(32);
  v_sizename          VARCHAR2(32);
BEGIN

  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''APV_SIZE_CHART_GOO_ID'');

  SELECT MAX(t.size_chart_tmp_id)
    INTO v_size_chart_tmp_id
    FROM scmdata.t_approve_version_size_chart_tmp t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = v_goo_id
     AND t.position = :old_position
     AND t.quantitative_method = :old_quantitative_method;

  p_t_siz_rec.size_chart_tmp_id      := v_size_chart_tmp_id;
  p_t_siz_rec.company_id             := %default_company_id%;
  p_t_siz_rec.seq_num                := :seq_num;
  p_t_siz_rec.base_code              := :base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.position               := :position;
  p_t_siz_rec.quantitative_method    := :quantitative_method;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;
  --更新尺寸表主表
  scmdata.pkg_approve_version_size_chart.p_update_t_approve_version_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);

  p_t_siz_dt_rec.size_chart_id := v_size_chart_tmp_id;
  v_sizename := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,p_size_name  => :measure);
  p_t_siz_dt_rec.measure       := v_sizename;
  --尺码校验
  scmdata.pkg_approve_version_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value := :measure_value;
  p_t_siz_dt_rec.pause         := 0;
  p_t_siz_dt_rec.create_id     := :user_id;
  p_t_siz_dt_rec.create_time   := SYSDATE;
  p_t_siz_dt_rec.update_id     := :user_id;
  p_t_siz_dt_rec.update_time   := SYSDATE;
  p_t_siz_dt_rec.memo          := NULL;
  --更新尺码
  scmdata.pkg_approve_version_size_chart.p_update_t_approve_version_size_chart_details_tmp(p_t_siz_rec => p_t_siz_dt_rec);
END;';
v_sql3 := 'DECLARE
  v_goo_id VARCHAR2(32);
  v_flag   INT := 0;
BEGIN
  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''APV_SIZE_CHART_GOO_ID'');

  v_flag := scmdata.pkg_size_chart.f_is_has_size_chart_row_data(p_company_id          => %default_company_id%,
                                                                p_goo_id              => v_goo_id,
                                                                p_position            => :position,
                                                                p_quantitative_method => :quantitative_method,
                                                                p_table               => ''t_approve_version_size_chart_tmp'');

  IF v_flag > 0 THEN
    scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                      p_goo_id        => v_goo_id,
                                                      p_orgin_seq_num => :seq_num, --原序号
                                                      p_type          => 1,
                                                      p_table         => ''t_approve_version_size_chart_tmp'',
                                                      p_table_pk_id   => ''size_chart_tmp_id'');
  
    scmdata.pkg_approve_version_size_chart.p_delete_t_approve_version_size_chart_details_tmp(p_company_id          => %default_company_id%,
                                                                                             p_goo_id              => v_goo_id,
                                                                                             p_position            => :position,
                                                                                             p_quantitative_method => :quantitative_method);
  END IF;
END;';
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_approve_310_2', 13, null, null, null, null, '
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_approve_version_size_chart.f_query_t_approve_version_size_chart_details_tmp(p_user_id => :user_id,p_company_id => %default_company_id%);
  @strresult := v_sql;
END;}', null, null, v_sql1, v_sql2, v_sql3, 'size_chart_dt_tmp_id,company_id,goo_id,base_code,base_value', null, null, 'SEQ_NUM', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
BEGIN
  v_sql1 := '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  plm.pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                                 po_pk_id        => v_goo_id,
                                                 po_rest_methods => v_rest_method,
                                                 po_params       => v_params);
  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
  p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_flag          INT;
  v_sizename      VARCHAR2(32);
  v_goo_id        VARCHAR2(32) := '']'' || v_goo_id || q''['';
BEGIN
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart_data(p_company_id          => %default_company_id%,
                                                                                  p_goo_id              => v_goo_id,
                                                                                  p_position            => :position,
                                                                                  p_quantitative_method => :quantitative_method);
  IF v_flag = 0 THEN
    SELECT MAX(base_code)
      INTO v_base_code
      FROM (SELECT DISTINCT ts.base_code
              FROM scmdata.t_approve_version_size_chart ts
             WHERE ts.goo_id = v_goo_id
               AND ts.company_id = %default_company_id%);
  
    p_t_siz_rec.size_chart_id          := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := v_goo_id;
    p_t_siz_rec.seq_num                := scmdata.pkg_size_chart.f_get_size_chart_seq_num(p_company_id => %default_company_id%,
                                                                                          p_goo_id => v_goo_id,
                                                                                          p_table => ''t_approve_version_size_chart'');
    p_t_siz_rec.position               := :position;
    p_t_siz_rec.quantitative_method    := :quantitative_method;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
    p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := :user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := :user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --新增尺寸表主表
    scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);
  END IF;

  SELECT MAX(size_chart_id)
    INTO v_size_chart_id
    FROM (SELECT DISTINCT t.size_chart_id
            FROM scmdata.t_approve_version_size_chart t
           WHERE t.company_id = %default_company_id%
             AND t.goo_id = v_goo_id
             AND t.position = :position
             AND t.quantitative_method = :quantitative_method);

  p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
  p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
  v_sizename                      := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,
                                                                                    p_size_name  => :measure);
  p_t_siz_dt_rec.measure          := v_sizename;
  --尺码校验
  scmdata.pkg_approve_version_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value    := :measure_value;
  p_t_siz_dt_rec.pause            := 0;
  p_t_siz_dt_rec.create_id        := :user_id;
  p_t_siz_dt_rec.create_time      := SYSDATE;
  p_t_siz_dt_rec.update_id        := :user_id;
  p_t_siz_dt_rec.update_time      := SYSDATE;
  p_t_siz_dt_rec.memo             := NULL;
  --新增尺码
  scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
END;]'';
  ELSE
    NULL;
  END IF;
  @strresult := v_sql;
END;}

/*

DECLARE
  p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
  p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_flag          INT;
  v_sizename      VARCHAR2(32);
BEGIN
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart_data(p_company_id          => %default_company_id%,
                                                                                  p_goo_id              => :goo_id,
                                                                                  p_position            => :position,
                                                                                  p_quantitative_method => :quantitative_method);
  IF v_flag = 0 THEN
    SELECT MAX(base_code)
      INTO v_base_code
      FROM (SELECT DISTINCT ts.base_code
              FROM scmdata.t_approve_version_size_chart ts
             WHERE ts.goo_id = :goo_id
               AND ts.company_id = %default_company_id%);
  
    p_t_siz_rec.size_chart_id          := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := :goo_id;
    p_t_siz_rec.seq_num                := :seq_num;
    p_t_siz_rec.position               := :position;
    p_t_siz_rec.quantitative_method    := :quantitative_method;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
    p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := :user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := :user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --新增尺寸表主表
    scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);
  END IF;

  SELECT MAX(size_chart_id)
    INTO v_size_chart_id
    FROM (SELECT DISTINCT t.size_chart_id
            FROM scmdata.t_approve_version_size_chart t
           WHERE t.company_id = %default_company_id%
             AND t.goo_id = :goo_id
             AND t.position = :position
             AND t.quantitative_method = :quantitative_method);

  p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
  p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
  v_sizename                      := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,
                                                                                    p_size_name  => :measure);
  p_t_siz_dt_rec.measure          := v_sizename;
  p_t_siz_dt_rec.measure_value    := :measure_value;
  p_t_siz_dt_rec.pause            := 0;
  p_t_siz_dt_rec.create_id        := :user_id;
  p_t_siz_dt_rec.create_time      := SYSDATE;
  p_t_siz_dt_rec.update_id        := :user_id;
  p_t_siz_dt_rec.update_time      := SYSDATE;
  p_t_siz_dt_rec.memo             := NULL;
  --新增尺码
  scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
END;*/';
  v_sql2 := '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  plm.pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                                 po_pk_id        => v_goo_id,
                                                 po_rest_methods => v_rest_method,
                                                 po_params       => v_params);
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
  p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_sizename      VARCHAR2(32);
  v_goo_id        VARCHAR2(32) := '']'' || v_goo_id || q''[''; 
BEGIN

  SELECT MAX(t.size_chart_id)
    INTO v_size_chart_id
    FROM scmdata.t_approve_version_size_chart t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = v_goo_id
     AND t.position = :old_position
     AND t.quantitative_method = :old_quantitative_method;

  p_t_siz_rec.size_chart_id          := v_size_chart_id;
  p_t_siz_rec.company_id             := %default_company_id%;
  p_t_siz_rec.seq_num                := :seq_num;
  p_t_siz_rec.base_code              := :base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.position               := :position;
  p_t_siz_rec.quantitative_method    := :quantitative_method;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;
  --更新尺寸表主表
  scmdata.pkg_approve_version_size_chart.p_update_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);

  p_t_siz_dt_rec.size_chart_id := v_size_chart_id;
  v_sizename := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,p_size_name  => :measure);
  p_t_siz_dt_rec.measure       := v_sizename;
  --尺码校验
  scmdata.pkg_approve_version_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value := :measure_value;
  p_t_siz_dt_rec.pause         := 0;
  p_t_siz_dt_rec.create_id     := :user_id;
  p_t_siz_dt_rec.create_time   := SYSDATE;
  p_t_siz_dt_rec.update_id     := :user_id;
  p_t_siz_dt_rec.update_time   := SYSDATE;
  p_t_siz_dt_rec.memo          := NULL;
  --更新尺码
  scmdata.pkg_approve_version_size_chart.p_update_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
END;]'';
  ELSE
    NULL;
  END IF;
  @strresult := v_sql;
END;}

/*
DECLARE
  p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
  p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_sizename      VARCHAR2(32);
BEGIN

  SELECT MAX(t.size_chart_id)
    INTO v_size_chart_id
    FROM scmdata.t_approve_version_size_chart t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = :goo_id
     AND t.position = :old_position
     AND t.quantitative_method = :old_quantitative_method;

  p_t_siz_rec.size_chart_id          := v_size_chart_id;
  p_t_siz_rec.company_id             := %default_company_id%;
  p_t_siz_rec.seq_num                := :seq_num;
  p_t_siz_rec.base_code              := :base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.position               := :position;
  p_t_siz_rec.quantitative_method    := :quantitative_method;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;
  --更新尺寸表主表
  scmdata.pkg_approve_version_size_chart.p_update_t_approve_version_size_chart(p_t_siz_rec => p_t_siz_rec);

  p_t_siz_dt_rec.size_chart_id := v_size_chart_id;
  v_sizename := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,p_size_name  => :measure);
  p_t_siz_dt_rec.measure       := v_sizename;
  --尺码校验
  scmdata.pkg_approve_version_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value := :measure_value;
  p_t_siz_dt_rec.pause         := 0;
  p_t_siz_dt_rec.create_id     := :user_id;
  p_t_siz_dt_rec.create_time   := SYSDATE;
  p_t_siz_dt_rec.update_id     := :user_id;
  p_t_siz_dt_rec.update_time   := SYSDATE;
  p_t_siz_dt_rec.memo          := NULL;
  --更新尺码
  scmdata.pkg_approve_version_size_chart.p_update_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
END;*/';
v_sql3 := '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  plm.pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                                 po_pk_id        => v_goo_id,
                                                 po_rest_methods => v_rest_method,
                                                 po_params       => v_params);
  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[
DECLARE
  v_goo_id      VARCHAR2(32) := '']'' || v_goo_id || q''['';
  v_flag   INT := 0;
BEGIN
  v_flag := scmdata.pkg_size_chart.f_is_has_size_chart_row_data(p_company_id          => %default_company_id%,
                                                                p_goo_id              => v_goo_id,
                                                                p_position            => :position,
                                                                p_quantitative_method => :quantitative_method,
                                                                p_table               => ''t_approve_version_size_chart'');

  IF v_flag > 0 THEN
    scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                      p_goo_id        => v_goo_id,
                                                      p_orgin_seq_num => :seq_num, --原序号
                                                      p_type          => 1,
                                                      p_table         => ''t_approve_version_size_chart'',
                                                      p_table_pk_id   => ''size_chart_id'');
                                                      
  scmdata.pkg_approve_version_size_chart.p_delete_t_approve_version_size_chart_row_data(p_company_id          => %default_company_id%,
                                                                                        p_goo_id              => v_goo_id,
                                                                                        p_position            => :position,
                                                                                        p_quantitative_method => :quantitative_method);
  END IF;                                                                                     
END;]'';
  ELSE
    NULL;
  END IF;
  @strresult := v_sql;
END;}';
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_approve_310_3', 13, null, null, null, null, '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(256);
BEGIN
  --获取asscoiate请求参数
  plm.pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                                 po_pk_id        => v_goo_id,
                                                 po_rest_methods => v_rest_method,
                                                 po_params       => v_params);
  IF instr('';'' || v_rest_method || '';'', '';'' || ''GET'' || '';'') > 0 THEN
    v_sql := scmdata.pkg_approve_version_size_chart.f_query_t_approve_version_size_chart(p_goo_id => v_goo_id,p_company_id => %default_company_id%);
  ELSE
    NULL;
  END IF;
  @strresult := v_sql;
END;}', null, null, v_sql1, v_sql2, v_sql3, 'size_chart_id,company_id,goo_id,base_code,base_value', null, null, 'SEQ_NUM', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
BEGIN
  v_sql1 := 'DECLARE
  p_t_siz_rec t_size_chart_tmp%ROWTYPE;
  v_base_code VARCHAR2(32);
BEGIN
  p_t_siz_rec.size_chart_tmp_id   := scmdata.f_get_uuid();
  p_t_siz_rec.company_id          := %default_company_id%;
  p_t_siz_rec.goo_id              := :goo_id;
  p_t_siz_rec.seq_num             := scmdata.pkg_size_chart.f_get_size_chart_seq_num(p_company_id => %default_company_id%,
                                                                                          p_goo_id => :goo_id,
                                                                                          p_table => ''t_size_chart_tmp'');
  p_t_siz_rec.position            := :position;
  p_t_siz_rec.quantitative_method := :quantitative_method;

  SELECT MAX(base_code) INTO v_base_code FROM (SELECT DISTINCT t.base_code   
    FROM t_size_chart_tmp t
   WHERE t.goo_id = :goo_id
     AND t.company_id = %default_company_id%);

  p_t_siz_rec.base_code              := v_base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;
  scmdata.pkg_size_chart.p_check_is_has_size_chart_moudle_data(p_company_id => %default_company_id%,
                                                               p_goo_id     => :goo_id);
  scmdata.pkg_size_chart.p_insert_t_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
END;';

v_sql2 := 'DECLARE 
  p_t_siz_rec t_size_chart_tmp%ROWTYPE;
BEGIN
  p_t_siz_rec.size_chart_tmp_id      := :size_chart_tmp_id;
  p_t_siz_rec.company_id             := %default_company_id%;
  p_t_siz_rec.goo_id                 := :goo_id;
  p_t_siz_rec.seq_num                := :seq_num;
  p_t_siz_rec.position               := :position;
  p_t_siz_rec.quantitative_method    := :quantitative_method;
  p_t_siz_rec.base_code              := :base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;

  scmdata.pkg_size_chart.p_update_t_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
END;';

v_sql3 := 'DECLARE
  v_flag INT := 0;
BEGIN
  v_flag := scmdata.pkg_size_chart.f_is_has_size_chart_row_data(p_company_id          => %default_company_id%,
                                                                p_goo_id              => :goo_id,
                                                                p_position            => :position,
                                                                p_quantitative_method => :quantitative_method,
                                                                p_table               => ''t_size_chart_tmp'');

  IF v_flag > 0 THEN
    scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                      p_goo_id        => :goo_id,
                                                      p_orgin_seq_num => :seq_num, --原序号
                                                      p_type          => 1,
                                                      p_table         => ''t_size_chart_tmp'',
                                                      p_table_pk_id   => ''size_chart_tmp_id'');
  
    scmdata.pkg_size_chart.p_check_size_chart_tmp_by_delete(p_company_id => %default_company_id%,
                                                            p_goo_id     => :goo_id);
  
    scmdata.pkg_size_chart.p_delete_t_size_chart_tmp(p_size_chart_tmp_id => :size_chart_tmp_id);
  END IF;
END;';
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_good_310_1', 13, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_size_chart.f_query_t_size_chart_tmp();
  @strresult := v_sql;
END;}', null, null, v_sql1, v_sql2, v_sql3, 'goo_id,company_id,size_chart_tmp_id,base_code', null, null, 'SEQ_NUM', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
BEGIN
  v_sql1 := 'DECLARE
  p_t_siz_rec         t_size_chart_tmp%ROWTYPE;
  p_t_siz_dt_rec      t_size_chart_details_tmp%ROWTYPE;
  v_goo_id            VARCHAR2(32);
  v_base_code         VARCHAR2(32);
  v_size_chart_tmp_id VARCHAR2(32);
  v_flag              INT;
  v_sizename          VARCHAR2(32);
BEGIN

  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''SIZE_CHART_GOO_ID'');

  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart_tmp_data(p_company_id          => %default_company_id%,
                                                                      p_goo_id              => v_goo_id,
                                                                      p_position            => :position,
                                                                      p_quantitative_method => :quantitative_method);

  IF v_flag = 0 THEN
    SELECT MAX(base_code) INTO v_base_code FROM (SELECT DISTINCT ts.base_code
      FROM scmdata.t_size_chart_tmp ts
     WHERE ts.goo_id = v_goo_id
       AND ts.company_id = %default_company_id%);
  
    p_t_siz_rec.size_chart_tmp_id      := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := v_goo_id;
    p_t_siz_rec.seq_num                := scmdata.pkg_size_chart.f_get_size_chart_seq_num(p_company_id => %default_company_id%,
                                                                                          p_goo_id => v_goo_id,
                                                                                          p_table => ''t_size_chart_tmp'');
    p_t_siz_rec.position               := :position;
    p_t_siz_rec.quantitative_method    := :quantitative_method;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
    p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := :user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := :user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --新增尺寸表主表
    scmdata.pkg_size_chart.p_insert_t_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
  END IF;

  SELECT DISTINCT t.size_chart_tmp_id
    INTO v_size_chart_tmp_id
    FROM scmdata.t_size_chart_tmp t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = v_goo_id
     AND t.position = :position
     AND t.quantitative_method = :quantitative_method;

  p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
  p_t_siz_dt_rec.size_chart_id        := v_size_chart_tmp_id;
  v_sizename := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,p_size_name  => :measure);
  p_t_siz_dt_rec.measure              := v_sizename;
  --尺码校验
  scmdata.pkg_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value        := :measure_value;
  p_t_siz_dt_rec.pause                := 0;
  p_t_siz_dt_rec.create_id            := :user_id;
  p_t_siz_dt_rec.create_time          := SYSDATE;
  p_t_siz_dt_rec.update_id            := :user_id;
  p_t_siz_dt_rec.update_time          := SYSDATE;
  p_t_siz_dt_rec.memo                 := NULL;
  --新增尺码
  scmdata.pkg_size_chart.p_insert_t_size_chart_dt_tmp(p_t_siz_rec => p_t_siz_dt_rec);
END;';
  v_sql2 := 'DECLARE
  p_t_siz_rec         t_size_chart_tmp%ROWTYPE;
  p_t_siz_dt_rec      t_size_chart_details_tmp%ROWTYPE;
  v_goo_id            VARCHAR2(32);
  v_base_code         VARCHAR2(32);
  v_size_chart_tmp_id VARCHAR2(32);
  v_sizename          VARCHAR2(32);
BEGIN

  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''SIZE_CHART_GOO_ID'');

  SELECT MAX(t.size_chart_tmp_id)
    INTO v_size_chart_tmp_id
    FROM scmdata.t_size_chart_tmp t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = v_goo_id
     AND t.position = :old_position
     AND t.quantitative_method = :old_quantitative_method;

  p_t_siz_rec.size_chart_tmp_id      := v_size_chart_tmp_id;
  p_t_siz_rec.company_id             := %default_company_id%;
  p_t_siz_rec.seq_num                := :seq_num;
  p_t_siz_rec.base_code              := :base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.position               := :position;
  p_t_siz_rec.quantitative_method    := :quantitative_method;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;
  --更新尺寸表主表
  scmdata.pkg_size_chart.p_update_t_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);

  p_t_siz_dt_rec.size_chart_id := v_size_chart_tmp_id;
  v_sizename := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,p_size_name  => :measure);
  p_t_siz_dt_rec.measure       := v_sizename;
  --尺码校验
  scmdata.pkg_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value := :measure_value;
  p_t_siz_dt_rec.pause         := 0;
  p_t_siz_dt_rec.create_id     := :user_id;
  p_t_siz_dt_rec.create_time   := SYSDATE;
  p_t_siz_dt_rec.update_id     := :user_id;
  p_t_siz_dt_rec.update_time   := SYSDATE;
  p_t_siz_dt_rec.memo          := NULL;
  --更新尺码
  scmdata.pkg_size_chart.p_update_t_size_chart_dt_tmp(p_t_siz_rec => p_t_siz_dt_rec);
END;';
  v_sql3 := 'DECLARE
  v_goo_id VARCHAR2(32);
  v_flag   INT := 0;
BEGIN
  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''SIZE_CHART_GOO_ID'');
                                                   
  v_flag := scmdata.pkg_size_chart.f_is_has_size_chart_row_data(p_company_id          => %default_company_id%,
                                                                p_goo_id              => v_goo_id,
                                                                p_position            => :position,
                                                                p_quantitative_method => :quantitative_method,
                                                                p_table               => ''t_size_chart_tmp'');

  IF v_flag > 0 THEN
  
    scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                      p_goo_id        => v_goo_id,
                                                      p_orgin_seq_num => :seq_num, --原序号
                                                      p_type          => 1,
                                                      p_table         => ''t_size_chart_tmp'',
                                                      p_table_pk_id   => ''size_chart_tmp_id'');
                                                     
    scmdata.pkg_size_chart.p_delete_t_size_chart_dt_tmp(p_company_id          => %default_company_id%,
                                                        p_goo_id              => v_goo_id,
                                                        p_position            => :position,
                                                        p_quantitative_method => :quantitative_method);
  END IF;
END;';
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_good_310_2', 13, null, null, null, null, '
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_size_chart.f_query_t_size_chart_dt_tmp(p_user_id => :user_id,p_company_id => %default_company_id%);
  @strresult := v_sql;
END;}', null, null, v_sql1, v_sql2, v_sql3, 'size_chart_dt_tmp_id,company_id,goo_id,base_code,base_value', null, null, 'SEQ_NUM', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
BEGIN
  v_sql1 := 'DECLARE
  p_t_siz_rec     t_size_chart%ROWTYPE;
  p_t_siz_dt_rec  t_size_chart_details%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_flag          INT;
  v_sizename      VARCHAR2(32);
BEGIN
  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart_data(p_company_id          => %default_company_id%,
                                                                  p_goo_id              => :goo_id,
                                                                  p_position            => :position,
                                                                  p_quantitative_method => :quantitative_method);
  IF v_flag = 0 THEN
    SELECT MAX(base_code) INTO v_base_code FROM (SELECT DISTINCT ts.base_code      
      FROM scmdata.t_size_chart ts
     WHERE ts.goo_id = :goo_id
       AND ts.company_id = %default_company_id%);
  
    p_t_siz_rec.size_chart_id          := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := :goo_id;
    p_t_siz_rec.seq_num                := scmdata.pkg_size_chart.f_get_size_chart_seq_num(p_company_id => %default_company_id%,
                                                                                          p_goo_id => :goo_id,
                                                                                          p_table => ''t_size_chart'');
    p_t_siz_rec.position               := :position;
    p_t_siz_rec.quantitative_method    := :quantitative_method;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
    p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := :user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := :user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --新增尺寸表主表
    scmdata.pkg_size_chart.p_insert_t_size_chart(p_t_siz_rec => p_t_siz_rec);
  END IF;

  SELECT size_chart_id INTO v_size_chart_id FROM (SELECT DISTINCT t.size_chart_id   
    FROM scmdata.t_size_chart t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = :goo_id
     AND t.position = :position
     AND t.quantitative_method = :quantitative_method);

  p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
  p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
  v_sizename := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,p_size_name  => :measure);
  p_t_siz_dt_rec.measure          := v_sizename;
  --尺码校验
  scmdata.pkg_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value    := :measure_value;
  p_t_siz_dt_rec.pause            := 0;
  p_t_siz_dt_rec.create_id        := :user_id;
  p_t_siz_dt_rec.create_time      := SYSDATE;
  p_t_siz_dt_rec.update_id        := :user_id;
  p_t_siz_dt_rec.update_time      := SYSDATE;
  p_t_siz_dt_rec.memo             := NULL;
  --新增尺码
  scmdata.pkg_size_chart.p_insert_t_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
  --同步数据至批版列表
  scmdata.pkg_size_chart.p_sync_gd_size_chart_to_apv(p_company_id => %default_company_id%,p_goo_id => :goo_id);
/*EXCEPTION
  WHEN OTHERS THEN
    scmdata.sys_raise_app_error_pkg.is_running_error(p_is_running_error => ''T'');*/
END;';
  v_sql2 := 'DECLARE
  p_t_siz_rec     t_size_chart%ROWTYPE;
  p_t_siz_dt_rec  t_size_chart_details%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_sizename      VARCHAR2(32);
BEGIN

  SELECT MAX(t.size_chart_id)
    INTO v_size_chart_id
    FROM scmdata.t_size_chart t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = :goo_id
     AND t.position = :old_position
     AND t.quantitative_method = :old_quantitative_method;

  p_t_siz_rec.size_chart_id          := v_size_chart_id;
  p_t_siz_rec.company_id             := %default_company_id%;
  p_t_siz_rec.seq_num                := :seq_num;
  p_t_siz_rec.base_code              := :base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.position               := :position;
  p_t_siz_rec.quantitative_method    := :quantitative_method;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;
  --更新尺寸表主表
  scmdata.pkg_size_chart.p_update_t_size_chart(p_t_siz_rec => p_t_siz_rec);

  p_t_siz_dt_rec.size_chart_id := v_size_chart_id;
  v_sizename := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,p_size_name  => :measure);
  p_t_siz_dt_rec.measure       := v_sizename;
  --尺码校验
  scmdata.pkg_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value := :measure_value;
  p_t_siz_dt_rec.pause         := 0;
  p_t_siz_dt_rec.create_id     := :user_id;
  p_t_siz_dt_rec.create_time   := SYSDATE;
  p_t_siz_dt_rec.update_id     := :user_id;
  p_t_siz_dt_rec.update_time   := SYSDATE;
  p_t_siz_dt_rec.memo          := NULL;
  --更新尺码
  scmdata.pkg_size_chart.p_update_t_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
  --同步数据至批版列表
  scmdata.pkg_size_chart.p_sync_gd_size_chart_to_apv(p_company_id => %default_company_id%,p_goo_id => :goo_id);
END;';
  v_sql3 := 'DECLARE
  v_flag INT := 0;
BEGIN

  v_flag := scmdata.pkg_size_chart.f_is_has_size_chart_row_data(p_company_id          => %default_company_id%,
                                                                p_goo_id              => :goo_id,
                                                                p_position            => :position,
                                                                p_quantitative_method => :quantitative_method,
                                                                p_table               => ''t_size_chart'');

  IF v_flag > 0 THEN
    scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                      p_goo_id        => :goo_id,
                                                      p_orgin_seq_num => :seq_num, --原序号
                                                      p_type          => 1,
                                                      p_table         => ''t_size_chart'',
                                                      p_table_pk_id   => ''size_chart_id'');
  
    scmdata.pkg_size_chart.p_delete_t_size_chart_row_data(p_company_id          => %default_company_id%,
                                                          p_goo_id              => :goo_id,
                                                          p_position            => :position,
                                                          p_quantitative_method => :quantitative_method);
    --同步数据至批版列表
    scmdata.pkg_size_chart.p_sync_gd_size_chart_to_apv(p_company_id => %default_company_id%,
                                                       p_goo_id     => :goo_id);
  END IF;
END;';
insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_good_310_3', 13, null, null, null, null, '{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := scmdata.pkg_size_chart.f_query_t_size_chart();
  @strresult := v_sql;
END;}', null, null, v_sql1, v_sql2, v_sql3, 'size_chart_id,company_id,goo_id,base_code,base_value', null, null, 'SEQ_NUM', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
BEGIN
v_sql1 := '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(4000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                             po_pk_id        => v_goo_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  p_t_siz_rec     t_size_chart_import_tmp%ROWTYPE;
  p_t_siz_dt_rec  t_size_chart_details_import_tmp%ROWTYPE;
  v_size_chart_id VARCHAR2(32);
  v_flag          INT;
  v_sizename      VARCHAR2(32);
  v_goo_id        VARCHAR2(32) := '']'' || v_goo_id || q''['';
BEGIN

  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart_import_data(p_company_id          => %default_company_id%,
                                                                         p_goo_id              => v_goo_id,
                                                                         p_position            => :position,
                                                                         p_quantitative_method => :quantitative_method);
  IF v_flag = 0 THEN
    p_t_siz_rec.size_chart_tmp_id      := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := v_goo_id;
    p_t_siz_rec.seq_num                := scmdata.pkg_size_chart.f_get_size_chart_seq_num(p_company_id => %default_company_id%,
                                                                                          p_goo_id => v_goo_id,
                                                                                          p_table => ''t_size_chart_import_tmp'');
    p_t_siz_rec.position               := :position;
    p_t_siz_rec.quantitative_method    := :quantitative_method;
    p_t_siz_rec.base_code              := NULL;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
    p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := :user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := :user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --删除初始化生成的尺寸数据
    scmdata.pkg_size_chart.p_delete_t_size_chart_import_first_generate_data(p_company_id => %default_company_id%,
                                                                            p_goo_id     => v_goo_id,
                                                                            p_seq_num    => 0);
    --新增尺寸表主表
    scmdata.pkg_size_chart.p_insert_t_size_chart_import_tmp(p_t_siz_rec => p_t_siz_rec);
  END IF;

  SELECT MAX(size_chart_tmp_id)
    INTO v_size_chart_id
    FROM (SELECT DISTINCT t.size_chart_tmp_id
            FROM scmdata.t_size_chart_import_tmp t
           WHERE t.company_id = %default_company_id%
             AND t.goo_id = v_goo_id
             AND t.position = :position
             AND t.quantitative_method = :quantitative_method);

  p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
  p_t_siz_dt_rec.size_chart_id        := v_size_chart_id;
  v_sizename                          := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,
                                                                                        p_size_name  => :measure);
  p_t_siz_dt_rec.measure              := v_sizename;
  --尺码校验
  scmdata.pkg_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value        := :measure_value;
  p_t_siz_dt_rec.pause                := 0;
  p_t_siz_dt_rec.create_id            := :user_id;
  p_t_siz_dt_rec.create_time          := SYSDATE;
  p_t_siz_dt_rec.update_id            := :user_id;
  p_t_siz_dt_rec.update_time          := SYSDATE;
  p_t_siz_dt_rec.memo                 := NULL;
  --新增尺码
  scmdata.pkg_size_chart.p_insert_t_size_chart_details_import_tmp(p_t_siz_rec => p_t_siz_dt_rec);
END;]'';
  END IF;
  @strresult := v_sql;
END;}';
v_sql2 := '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(4000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                             po_pk_id        => v_goo_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  p_t_siz_rec     t_size_chart_import_tmp%ROWTYPE;
  p_t_siz_dt_rec  t_size_chart_details_import_tmp%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_sizename      VARCHAR2(32);
  v_goo_id        VARCHAR2(32) := '']'' || v_goo_id || q''['';
BEGIN
  SELECT MAX(t.size_chart_tmp_id)
    INTO v_size_chart_id
    FROM scmdata.t_size_chart_import_tmp t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = v_goo_id
     AND t.position = :old_position
     AND t.quantitative_method = :old_quantitative_method;

  p_t_siz_rec.size_chart_tmp_id      := v_size_chart_id;
  p_t_siz_rec.company_id             := %default_company_id%;
  --不可修改初始化数据
  scmdata.pkg_size_chart.p_check_t_size_chart_import_tmp_by_update(p_seq_num => :seq_num,p_type => 0);
  
  p_t_siz_rec.seq_num                := :seq_num;
  p_t_siz_rec.base_code              := :base_code;
  p_t_siz_rec.base_value             := :base_value;
  p_t_siz_rec.position               := :position;
  p_t_siz_rec.quantitative_method    := :quantitative_method;
  p_t_siz_rec.plus_toleran_range     := :plus_toleran_range;
  p_t_siz_rec.negative_toleran_range := :negative_toleran_range;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;

  --更新尺寸表主表
  scmdata.pkg_size_chart.p_update_t_size_chart_import_tmp(p_t_siz_rec => p_t_siz_rec);

  p_t_siz_dt_rec.size_chart_id := v_size_chart_id;
  v_sizename                   := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,
                                                                                 p_size_name  => :measure);
  p_t_siz_dt_rec.measure       := v_sizename;
  --尺码校验
  scmdata.pkg_size_chart.p_check_size_chart_by_update(p_measure_value => :measure_value);
  p_t_siz_dt_rec.measure_value := :measure_value;
  p_t_siz_dt_rec.pause         := 0;
  p_t_siz_dt_rec.create_id     := :user_id;
  p_t_siz_dt_rec.create_time   := SYSDATE;
  p_t_siz_dt_rec.update_id     := :user_id;
  p_t_siz_dt_rec.update_time   := SYSDATE;
  p_t_siz_dt_rec.memo          := NULL;
  --更新尺码
  scmdata.pkg_size_chart.p_update_t_size_chart_details_import_tmp(p_t_siz_rec => p_t_siz_dt_rec);
END;]'';
  END IF;
  @strresult := v_sql;
END;}';
v_sql3 := '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(4000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                             po_pk_id        => v_goo_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''PUT'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
    v_goo_id      VARCHAR2(32) := '']'' || v_goo_id || q''['';
    v_flag   INT := 0;
BEGIN
  --不可删除初始化数据
  scmdata.pkg_size_chart.p_check_t_size_chart_import_tmp_by_update(p_seq_num => :seq_num,p_type => 1);
  
  v_flag := scmdata.pkg_size_chart.f_is_has_size_chart_row_data(p_company_id          => %default_company_id%,
                                                                p_goo_id              => v_goo_id,
                                                                p_position            => :position,
                                                                p_quantitative_method => :quantitative_method,
                                                                p_table               => ''t_size_chart_import_tmp'');

  IF v_flag > 0 THEN
  
    scmdata.pkg_size_chart.p_reset_size_chart_seq_num(p_company_id    => %default_company_id%,
                                                      p_goo_id        => v_goo_id,
                                                      p_orgin_seq_num => :seq_num, --原序号
                                                      p_type          => 1,
                                                      p_table         => ''t_size_chart_import_tmp'',
                                                      p_table_pk_id   => ''size_chart_tmp_id'');
                                                      
  scmdata.pkg_size_chart.p_delete_t_size_chart_import_tmp_row_data(p_company_id          => %default_company_id%,
                                                                   p_goo_id              => v_goo_id,
                                                                   p_position            => :position,
                                                                   p_quantitative_method => :quantitative_method);
  END IF;
END;]'';
  END IF;
  @strresult := v_sql;
END;}';

insert into bw3.sys_item_list (ITEM_ID, QUERY_TYPE, QUERY_FIELDS, QUERY_COUNT, EDIT_EXPRESS, NEWID_SQL, SELECT_SQL, DETAIL_SQL, SUBSELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, NOSHOW_FIELDS, NOADD_FIELDS, NOMODIFY_FIELDS, NOEDIT_FIELDS, SUBNOSHOW_FIELDS, UI_TMPL, MULTI_PAGE_FLAG, OUTPUT_PARAMETER, LOCK_SQL, MONITOR_ID, END_FIELD, EXECUTE_TIME, SCANNABLE_FIELD, SCANNABLE_TYPE, AUTO_REFRESH, RFID_FLAG, SCANNABLE_TIME, MAX_ROW_COUNT, NOSHOW_APP_FIELDS, SCANNABLE_LOCATION_LINE, SUB_TABLE_JUDGE_FIELD, BACK_GROUND_ID, OPRETION_HINT, SUB_EDIT_STATE, HINT_TYPE, HEADER, FOOTER, JUMP_FIELD, JUMP_EXPRESS, OPEN_MODE, OPERATION_TYPE, OPERATE_TYPE, PAGE_SIZES)
values ('a_good_310_4', 13, null, null, null, null, '{DECLARE
  v_sql         CLOB;
  v_goo_id      VARCHAR2(32);
  v_rest_method VARCHAR2(256);
  v_params      VARCHAR2(4000);
BEGIN
  --获取asscoiate请求参数
  pkg_plat_comm.p_get_rest_val_method_params(p_character     => %ass_goo_id%,
                                             po_pk_id        => v_goo_id,
                                             po_rest_methods => v_rest_method,
                                             po_params       => v_params);

  IF instr('';'' || v_rest_method || '';'', '';'' || ''GET'' || '';'') > 0 THEN
    v_sql      := scmdata.pkg_size_chart.f_query_t_size_chart_import_tmp(p_company_id => %default_company_id%,
                                                                         p_goo_id     => v_goo_id);  
  END IF;
  @strresult := v_sql;
END;}', null, null, v_sql1, v_sql2, v_sql3, 'size_chart_id,company_id,size_chart_tmp_id,goo_id,base_code,base_value', null, null, 'SEQ_NUM', null, null, 1, null, null, null, null, null, null, null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, '20,30,50,100,200,500');
END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
BEGIN
  v_sql1 := '{DECLARE
  V_CATE  VARCHAR2(32):=SCMDATA.PKG_DATA_PRIVS.PARSE_JSON(P_JSONSTR => %DATA_PRIVS_JSON_STRS%,P_KEY => ''COL_2'');
  V_COND VARCHAR2(512):=''((''||%is_company_admin%||'' = 1) OR scmdata.instr_priv(p_str1  => ''''''||V_CATE||'''''', p_str2  => TCI.CATEGORY, p_split => '''';'''')>0'';
  V_SQL  CLOB:=''WITH DIC AS
 (SELECT GROUP_DICT_VALUE, GROUP_DICT_NAME, GROUP_DICT_TYPE
    FROM SCMDATA.SYS_GROUP_DICT)
SELECT TAV.APPROVE_VERSION_ID,
       TCI.RELA_GOO_ID,
       TAV.APPROVE_NUMBER,
       (SELECT GROUP_DICT_NAME   FROM DIC
         WHERE GROUP_DICT_VALUE = TAV.APPROVE_RESULT) APPROVE_RESULT_DESC,
         (SELECT TRUNC(SYSDATE) - TRUNC(AB.SEND_ORDER_DATE)
  FROM (SELECT A.COMPANY_ID, B.GOO_ID, MIN(A.SEND_ORDER_DATE) SEND_ORDER_DATE
          FROM SCMDATA.T_ORDERED A
         INNER JOIN SCMDATA.T_ORDERS B
            ON A.ORDER_CODE = B.ORDER_ID
           AND A.COMPANY_ID = B.COMPANY_ID
         GROUP BY B.GOO_ID, A.COMPANY_ID) AB
 WHERE AB.GOO_ID = TAV.GOO_ID   AND AB.COMPANY_ID = TAV.COMPANY_ID)  ORDER_DAYS,
       (SELECT SUPPLIER_COMPANY_ABBREVIATION
          FROM SCMDATA.T_SUPPLIER_INFO
         WHERE SUPPLIER_CODE = TCI.SUPPLIER_CODE
           AND COMPANY_ID = TCI.COMPANY_ID) SUPPLIER,
       TCI.STYLE_NUMBER STYLE_CODE,
       TCI.STYLE_NAME,
       ''''尺寸表'''' standard_size_chart,--czh add
       TARA.ALREADY_EVALTYPE,
       TARA.LASTEST_ASSESS_TIME,
       TAV.APPROVE_TYPE, --ADD BY DYY153 
       TAV.RE_VERSION_REASON, --add by zwh73
       TAV.VIDEO_ADDRESS,  --add by dyy153
       TCI.EXECUTIVE_STD,
       K.COMPOSNAME_LONG,
       TAV.REMARKS,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TCI.CATEGORY
           AND GROUP_DICT_TYPE = ''''PRODUCT_TYPE'''') CATEGORY,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TCI.PRODUCT_CATE
           AND GROUP_DICT_TYPE = TCI.CATEGORY) PRODUCT_CATE,
       (SELECT COMPANY_DICT_NAME
          FROM SCMDATA.SYS_COMPANY_DICT
         WHERE COMPANY_ID = TAV.COMPANY_ID
           AND COMPANY_DICT_VALUE = TCI.SAMLL_CATEGORY
           AND COMPANY_DICT_TYPE = TCI.PRODUCT_CATE) SAMLL_CATEGORY,
       TAV.GOO_ID,
       TAV.ORIGIN,
       NVL((SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE USER_ID = TCI.CREATE_ID
           AND COMPANY_ID = TCI.COMPANY_ID),TCI.CREATE_ID) COMM_FILE_CREATOR,
       TCI.CREATE_TIME COMM_FILE_CREATETIME,
       NVL((SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE USER_ID = TAV.CREATE_ID
           AND COMPANY_ID = TAV.COMPANY_ID),''''系统管理员'''') CREATOR,
       TAV.CREATE_TIME
  FROM (SELECT APPROVE_VERSION_ID,--
               COMPANY_ID,
               BILL_CODE,
               APPROVE_STATUS,
               APPROVE_NUMBER,
               APPROVE_RESULT,
               GOO_ID,
               STYLE_CODE,
               RE_VERSION_REASON,
               APPROVE_USER_ID,
               APPROVE_TIME,
               CREATE_TIME,
               ORIGIN,
               CREATE_ID,
               SUPPLIER_CODE,
               REMARKS,
               APPROVE_TYPE,
               VIDEO_ADDRESS
          FROM SCMDATA.T_APPROVE_VERSION
         WHERE COMPANY_ID = ''''''||%DEFAULT_COMPANY_ID%||''''''
           AND APPROVE_STATUS = ''''AS00'''') TAV
  LEFT JOIN (SELECT T.APPROVE_VERSION_ID,
                    T.COMPANY_ID,
                    MAX(T.ASSESS_TIME) LASTEST_ASSESS_TIME,
                    LISTAGG(X.GROUP_DICT_NAME, '''','''') WITHIN GROUP(ORDER BY T.ASSESS_TYPE) ALREADY_EVALTYPE
               FROM (SELECT APPROVE_VERSION_ID,
                            COMPANY_ID,
                            ASSESS_TIME,
                            ASSESS_TYPE
                       FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT
                      WHERE LENGTH(TRIM(ASSESS_SAY)) > 0) T
               LEFT JOIN DIC X
                 ON T.ASSESS_TYPE = X.GROUP_DICT_VALUE
                AND X.GROUP_DICT_TYPE = ''''BAD_FACTOR''''
              GROUP BY T.APPROVE_VERSION_ID, T.COMPANY_ID) TARA
    ON TAV.APPROVE_VERSION_ID = TARA.APPROVE_VERSION_ID
   AND TAV.COMPANY_ID = TARA.COMPANY_ID
 INNER JOIN SCMDATA.T_COMMODITY_INFO TCI
    ON TAV.COMPANY_ID = TCI.COMPANY_ID
   AND TAV.GOO_ID = TCI.GOO_ID
   AND ''||V_COND||'')
  LEFT JOIN (SELECT COMMODITY_INFO_ID,COMPANY_ID,
       LISTAGG(COMPOSNAME || '''' '''' || PK, CHR(10)) WITHIN GROUP(ORDER BY SEQ) COMPOSNAME_LONG
  FROM (SELECT DISTINCT COMMODITY_INFO_ID,COMPANY_ID,COMPOSNAME,
               LISTAGG(LOADRATE*100||''''%''''||'''' ''''||GOO_RAW||'''' ''''||MEMO,'''' '''') WITHIN GROUP(ORDER BY SORT ASC) OVER(PARTITION BY COMMODITY_INFO_ID,COMPANY_ID,COMPOSNAME) PK,
               CASE COMPOSNAME
                 WHEN ''''面料1'''' THEN 1
                 WHEN ''''面料2'''' THEN 2
                 WHEN ''''面料'''' THEN 3
                 WHEN ''''里料1'''' THEN 4
                 WHEN ''''里料2'''' THEN 5
                 WHEN ''''里料'''' THEN 6
                 WHEN ''''侧翼面料'''' THEN 7
                 WHEN ''''侧翼里料'''' THEN 8
                 WHEN ''''罩杯里料'''' THEN 9
                 WHEN ''''表层'''' THEN 10
                 WHEN ''''基布'''' THEN 11
                 WHEN ''''填充物'''' THEN 12
                 WHEN ''''填充量'''' THEN 13
                 WHEN ''''鞋面材质'''' THEN 14
                 WHEN ''''鞋底材质'''' THEN 15
                 WHEN ''''帽里填充物'''' THEN 16
                 ELSE 99 END SEQ
          FROM (SELECT COMMODITY_INFO_ID,COMPANY_ID,COMPOSNAME,
                       LOADRATE,GOO_RAW,MEMO,SORT
                  FROM SCMDATA.T_COMMODITY_COMPOSITION))
 GROUP BY COMMODITY_INFO_ID,COMPANY_ID) K
   ON K.COMMODITY_INFO_ID = TCI.COMMODITY_INFO_ID
  AND K.COMPANY_ID = TCI.COMPANY_ID
 ORDER BY TAV.CREATE_TIME DESC'';
BEGIN
  @StrResult := V_SQL;
END;}';

v_sql2 := 'DECLARE
  V_GOODID VARCHAR2(32);
  V_STNUM  VARCHAR2(32);
  V_SPCODE VARCHAR2(32);
  V_APNUM  NUMBER(4);
  V_ORIGIN VARCHAR2(8);
  V_STATUS VARCHAR2(8);
  V_APID   VARCHAR2(32);
  V_APVID  VARCHAR2(32);
BEGIN
  V_APID := SCMDATA.F_GETKEYID_PLAT(''AP_VERSION'',
                                    ''seq_approve_version'',
                                    ''99'');
  SELECT MAX(GOO_ID), MAX(STYLE_NUMBER), MAX(SUPPLIER_CODE)
    INTO V_GOODID, V_STNUM, V_SPCODE
    FROM SCMDATA.T_COMMODITY_INFO
   WHERE RELA_GOO_ID = :RELA_GOO_ID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
  SELECT NVL(MAX(APPROVE_NUMBER), 0) + 1,
         MAX(ORIGIN),
         MAX(APPROVE_STATUS),
         MAX(APPROVE_VERSION_ID)
    INTO V_APNUM, V_ORIGIN, V_STATUS, V_APVID
    FROM (SELECT APPROVE_NUMBER, ORIGIN, APPROVE_TIME, APPROVE_VERSION_ID,APPROVE_STATUS
            FROM SCMDATA.T_APPROVE_VERSION
           WHERE GOO_ID = V_GOODID
             AND COMPANY_ID = %DEFAULT_COMPANY_ID%
           ORDER BY APPROVE_TIME DESC)
   WHERE ROWNUM < 2;
  IF :RELA_GOO_ID IS NULL THEN
    RAISE_APPLICATION_ERROR(-20002,
                            ''未检测到输入货号，请重新输入后再保存！'');
  END IF;
  IF V_GOODID IS NULL THEN
    RAISE_APPLICATION_ERROR(-20002, ''输入货号有误，请核对后重新输入！'');
  ELSE
    IF V_APNUM > 1 THEN
      IF V_STATUS = ''AS00'' THEN
        RAISE_APPLICATION_ERROR(-20002,
                                ''待批版页面已有该货号数据，请勿重复新增！'');
      ELSE
        SCMDATA.PKG_APPROVE_INSERT.P_INSERT_APPROVE_VERSION_WITHOUT_CREATOR(V_APVID  => V_APID,
                                                                            V_STCODE => V_STNUM,
                                                                            V_SPCODE => V_SPCODE,
                                                                            V_COMPID => %DEFAULT_COMPANY_ID%,
                                                                            V_GOODID => V_GOODID,
                                                                            V_ORIGIN => V_ORIGIN,
                                                                            V_APVOID => :APPROVE_VERSION_ID,
                                                                            CRE_ID   => %CURRENT_USERID%);
        SCMDATA.PKG_APPROVE_INSERT.P_INSERT_APRISKASSEMENT_BY_REAP(V_APVID  => V_APVID,
                                                                   V_APID   => V_APID,
                                                                   V_COMPID => %DEFAULT_COMPANY_ID%);
        SCMDATA.PKG_APPROVE_INSERT.P_INSERT_APPROVE_FILE(V_APVID  => V_APID,
                                                         V_COMPID => %DEFAULT_COMPANY_ID%);
      END IF;
    ELSE
      IF V_APNUM = 1 AND V_STATUS = ''AS00'' THEN
        RAISE_APPLICATION_ERROR(-20002,
                                ''待批版页面已有该货号数据，请勿重复新增！'');
      ELSE
        SCMDATA.PKG_APPROVE_INSERT.P_INSERT_APPROVE_VERSION_WITHOUT_CREATOR(V_APVID  => V_APID,
                                                                            V_STCODE => V_STNUM,
                                                                            V_SPCODE => V_SPCODE,
                                                                            V_COMPID => %DEFAULT_COMPANY_ID%,
                                                                            V_GOODID => V_GOODID,
                                                                            V_ORIGIN => ''MI'',
                                                                            CRE_ID   => %CURRENT_USERID%);
        SCMDATA.PKG_APPROVE_INSERT.P_APPROVE_REVERSION_INSERT(COMP_ID => %DEFAULT_COMPANY_ID%,
                                                              AV_ID   => V_APID);
        SCMDATA.PKG_APPROVE_INSERT.P_INSERT_APPROVE_FILE(V_APVID  => V_APID,
                                                         V_COMPID => %DEFAULT_COMPANY_ID%);
      END IF;
    END IF;
  END IF;
  UPDATE SCMDATA.T_PRODUCTION_PROGRESS PR
     SET PR.APPROVE_EDITION = ''AS00''
   WHERE GOO_ID = V_GOODID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
  UPDATE SCMDATA.T_QC_GOO_COLLECT
     SET APPROVE_RESULT = ''AS00''
   WHERE GOO_ID = V_GOODID
     AND COMPANY_ID = %DEFAULT_COMPANY_ID%;
  --czh add 判断商品档案是否存在尺寸表，若存在，则同步商品档案尺寸表至批版
  scmdata.pkg_size_chart.p_sync_gd_size_chart_to_apv(p_company_id => %default_company_id%,p_goo_id  => v_goodid);
END;';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql1,t.insert_sql = v_sql2 WHERE t.item_id = 'a_approve_111';
END;
/
DECLARE
  v_sql1 CLOB;
BEGIN
  v_sql1 := '{DECLARE
  V_CATE  VARCHAR2(32):=SCMDATA.PKG_DATA_PRIVS.PARSE_JSON(P_JSONSTR => %DATA_PRIVS_JSON_STRS%,P_KEY => ''COL_2'');
  V_COND VARCHAR2(512):=''((''||%is_company_admin%||'' = 1) OR scmdata.instr_priv(p_str1  => ''''''||V_CATE||'''''', p_str2  => TCI.CATEGORY, p_split => '''';'''')>0'';
  V_SQL  CLOB:=''WITH DIC AS
 (SELECT GROUP_DICT_VALUE, GROUP_DICT_NAME, GROUP_DICT_TYPE
    FROM SCMDATA.SYS_GROUP_DICT)
SELECT TAV.APPROVE_VERSION_ID,
       TCI.RELA_GOO_ID,
       TAV.APPROVE_NUMBER,
       (SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE COMPANY_ID = TAV.COMPANY_ID
           AND USER_ID = TAV.APPROVE_USER_ID) APPROVE_USER,
       TAV.APPROVE_TIME,
       TAV.APPROVE_RESULT,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TAV.APPROVE_RESULT) APPROVE_RESULT_DESC,
       (SELECT LISTAGG(E.GROUP_DICT_NAME, '''','''')
          FROM (SELECT ASSESS_TYPE FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT
                 WHERE APPROVE_VERSION_ID = TAV.APPROVE_VERSION_ID
                   AND COMPANY_ID = TAV.COMPANY_ID
                   AND ASSESS_RESULT = ''''EVRT02'''') D
          LEFT JOIN DIC E
            ON D.ASSESS_TYPE = E.GROUP_DICT_VALUE
           AND E.GROUP_DICT_TYPE = ''''BAD_FACTOR'''') NP_EVALSBJ,
       (SELECT LISTAGG(DISTINCT GROUP_DICT_NAME, '''','''')
          FROM DIC
         WHERE GROUP_DICT_TYPE = ''''APUNQUAL_TREATMENT''''
           AND GROUP_DICT_VALUE IN
               (SELECT UNQUAL_TREATMENT
                  FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT
                 WHERE APPROVE_VERSION_ID = TAV.APPROVE_VERSION_ID
                   AND COMPANY_ID = TAV.COMPANY_ID)) APUNQUAL_TREATMENT_DESC,
       (SELECT SUPPLIER_COMPANY_ABBREVIATION
          FROM SCMDATA.T_SUPPLIER_INFO
         WHERE SUPPLIER_CODE = TAV.SUPPLIER_CODE
           AND COMPANY_ID = TAV.COMPANY_ID) SUPPLIER,
       TCI.STYLE_NUMBER STYLE_CODE,
       TCI.STYLE_NAME,
       ''''尺寸表'''' standard_size_chart,--czh add
       TAV.APPROVE_TYPE,
       TAV.RE_VERSION_REASON, --add by zwh73
       TAV.VIDEO_ADDRESS,   --add by dyy153
       TCI.EXECUTIVE_STD,
       K.COMPOSNAME_LONG,
       TAV.REMARKS,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TCI.CATEGORY
           AND GROUP_DICT_TYPE = ''''PRODUCT_TYPE'''') CATEGORY,
       (SELECT GROUP_DICT_NAME
          FROM DIC
         WHERE GROUP_DICT_VALUE = TCI.PRODUCT_CATE
           AND GROUP_DICT_TYPE = TCI.CATEGORY) PRODUCT_CATE,
       (SELECT COMPANY_DICT_NAME
          FROM SCMDATA.SYS_COMPANY_DICT
         WHERE COMPANY_ID = TAV.COMPANY_ID
           AND COMPANY_DICT_VALUE = TCI.SAMLL_CATEGORY
           AND COMPANY_DICT_TYPE = TCI.PRODUCT_CATE) SAMLL_CATEGORY,
       TAV.GOO_ID,
       TAV.ORIGIN,
       NVL((SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE USER_ID = TCI.CREATE_ID
           AND COMPANY_ID = TCI.COMPANY_ID),TCI.CREATE_ID) COMM_FILE_CREATOR,
       TCI.CREATE_TIME COMM_FILE_CREATETIME,
           NVL((SELECT COMPANY_USER_NAME
          FROM SCMDATA.SYS_COMPANY_USER
         WHERE USER_ID = TAV.CREATE_ID
           AND COMPANY_ID = TAV.COMPANY_ID),''''系统管理员'''') CREATOR,
       TAV.CREATE_TIME
  FROM (SELECT APPROVE_VERSION_ID,
               COMPANY_ID,
               BILL_CODE,
               APPROVE_STATUS,
               APPROVE_NUMBER,
               APPROVE_RESULT,
               GOO_ID,
               STYLE_CODE,
               RE_VERSION_REASON,
               APPROVE_USER_ID,
               APPROVE_TIME,
               CREATE_TIME,
               ORIGIN,
               CREATE_ID,
               SUPPLIER_CODE,
               REMARKS,
               APPROVE_TYPE,
               VIDEO_ADDRESS
          FROM SCMDATA.T_APPROVE_VERSION
         WHERE COMPANY_ID = ''''''||%default_company_id%||''''''
           AND APPROVE_STATUS IN (''''AS01'''', ''''AS02'''')) TAV
   INNER JOIN SCMDATA.T_COMMODITY_INFO TCI
          ON TAV.COMPANY_ID = TCI.COMPANY_ID
          AND TAV.GOO_ID = TCI.GOO_ID
          AND ''||V_COND||'')
   LEFT JOIN (SELECT COMMODITY_INFO_ID,COMPANY_ID,
       LISTAGG(COMPOSNAME || '''' '''' || PK, CHR(10)) WITHIN GROUP(ORDER BY SEQ) COMPOSNAME_LONG
  FROM (SELECT DISTINCT COMMODITY_INFO_ID,COMPANY_ID,COMPOSNAME,
               LISTAGG(LOADRATE*100||''''%''''||'''' ''''||GOO_RAW||'''' ''''||MEMO,'''' '''') WITHIN GROUP(ORDER BY SORT ASC) OVER(PARTITION BY COMMODITY_INFO_ID,COMPANY_ID,COMPOSNAME) PK,
               CASE COMPOSNAME
                 WHEN ''''面料1'''' THEN 1
                 WHEN ''''面料2'''' THEN 2
                 WHEN ''''面料'''' THEN 3
                 WHEN ''''里料1'''' THEN 4
                 WHEN ''''里料2'''' THEN 5
                 WHEN ''''里料'''' THEN 6
                 WHEN ''''侧翼面料'''' THEN 7
                 WHEN ''''侧翼里料'''' THEN 8
                 WHEN ''''罩杯里料'''' THEN 9
                 WHEN ''''表层'''' THEN 10
                 WHEN ''''基布'''' THEN 11
                 WHEN ''''填充物'''' THEN 12
                 WHEN ''''填充量'''' THEN 13
                 WHEN ''''鞋面材质'''' THEN 14
                 WHEN ''''鞋底材质'''' THEN 15
                 WHEN ''''帽里填充物'''' THEN 16
                 ELSE 99 END SEQ
          FROM (SELECT COMMODITY_INFO_ID,COMPANY_ID,COMPOSNAME,
                       LOADRATE,GOO_RAW,MEMO,SORT
                  FROM SCMDATA.T_COMMODITY_COMPOSITION))
 GROUP BY COMMODITY_INFO_ID,COMPANY_ID) K
   ON K.COMMODITY_INFO_ID = TCI.COMMODITY_INFO_ID
  AND K.COMPANY_ID = TCI.COMPANY_ID
 ORDER BY APPROVE_TIME DESC'';
BEGIN
  @StrResult := V_SQL;
END;}';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql1 WHERE t.item_id = 'a_approve_112';
END;
/
DECLARE
v_sql1 CLOB;
BEGIN
v_sql1 := '--优化后
WITH group_dict AS
 (SELECT * FROM scmdata.sys_group_dict),
company_dict AS
 (SELECT * FROM scmdata.sys_company_dict t),
company_user AS
 (SELECT company_id, user_id, company_user_name FROM sys_company_user)
SELECT tc.commodity_info_id,
       tc.company_id,
       tc.rela_goo_id,
       tc.cooperation_mode,
       tc.goo_id,
       tc.sup_style_number,
       tc.style_number,
       tc.style_name,
       ''尺寸表'' standard_size_chart,--czh add
       gd1.group_dict_name      category_gd,
       gd2.group_dict_name      product_cate_gd,
       cd.company_dict_name     small_category_gd,
      -- tc.supplier_code         supplier_code_gd,
       sp.supplier_company_name sup_name_gd,
       tc.goo_name,
       tc.year,
       tc.season,
       --gd3.group_dict_name      year_gd,
       gd4.group_dict_name season_gd,
       tc.inprice,
       tc.price price_gd,
        gd.group_dict_name       origin,
       tc.create_time,
       nvl((SELECT a.company_user_name
             FROM company_user a
            WHERE a.company_id = tc.company_id
              AND a.user_id = tc.create_id),
           tc.create_id) create_id,
       tc.update_time,
       nvl((SELECT b.company_user_name
             FROM company_user b
            WHERE b.company_id = tc.company_id
              AND b.user_id = tc.update_id),
           tc.create_id) update_id
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_supplier_info sp
    ON tc.supplier_code = sp.supplier_code
   AND tc.company_id = sp.company_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = ''ORIGIN_TYPE''
   AND tc.origin = gd.group_dict_value
 INNER JOIN group_dict gd1
    ON gd1.group_dict_type = ''PRODUCT_TYPE''
   AND gd1.group_dict_value = tc.category
 INNER JOIN group_dict gd2
    ON gd2.group_dict_type = gd1.group_dict_value
   AND gd2.group_dict_value = tc.product_cate
 INNER JOIN company_dict cd
    ON cd.company_dict_type = gd2.group_dict_value
   AND cd.company_dict_value = tc.samll_category
   AND cd.company_id = %default_company_id%
/* INNER JOIN group_dict gd3
 ON gd3.group_dict_type = ''GD_YEAR''
AND gd3.group_dict_value = tc.year*/
 INNER JOIN group_dict gd4
    ON gd4.group_dict_type = ''GD_SESON''
   AND gd4.group_dict_value = tc.season
 WHERE tc.company_id = %default_company_id%
  AND tc.pause = 0
 AND (%is_company_admin%=1  or instr_priv(p_str1  => {declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :='''''''' || v_class_data_privs || '''''''';
end;},p_str2  => tc.category ,p_split => '';'') > 0 )
 ORDER BY tc.create_time DESC';
UPDATE bw3.sys_item_list t SET t.select_sql = v_sql1 WHERE t.item_id = 'a_good_110';
END;
/
