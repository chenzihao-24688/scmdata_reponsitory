BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_approve_310_1_4', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_approve_310_2_3', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_approve_310_3_2', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_1_4', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_2_3', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_3_2', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('action_a_good_310_4_4', 'action', 'oracle_scmdata', 0, null, 0, null, null, null, null);

END;
/
DECLARE
v_sql1 CLOB;
v_sql2 CLOB;
v_sql3 CLOB;
v_sql4 CLOB;
v_sql5 CLOB;
v_sql6 CLOB;
v_sql7 CLOB;
BEGIN
  v_sql1 := 'DECLARE
  p_t_siz_rec t_approve_version_size_chart_tmp%ROWTYPE;
  v_base_code VARCHAR2(32);
  v_grammage  VARCHAR2(256) := @grammage@;
BEGIN
  --校验是否选择模板，未选择模板则不允许新增
  scmdata.pkg_approve_version_size_chart.p_check_is_has_size_chart_moudle_data(p_company_id => %default_company_id%,
                                                                               p_goo_id     => :goo_id);

  --判断是否已存在克重
  scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => :goo_id,
                                           p_table      => ''t_approve_version_size_chart_tmp'',
                                           p_type       => 1);

  p_t_siz_rec.size_chart_tmp_id   := scmdata.f_get_uuid();
  p_t_siz_rec.company_id          := %default_company_id%;
  p_t_siz_rec.goo_id              := :goo_id;
  p_t_siz_rec.seq_num             := 99;
  p_t_siz_rec.position            := v_grammage;
  p_t_siz_rec.quantitative_method := v_grammage;

  SELECT MAX(base_code)
    INTO v_base_code
    FROM (SELECT DISTINCT t.base_code
            FROM t_approve_version_size_chart_tmp t
           WHERE t.goo_id = :goo_id
             AND t.company_id = %default_company_id%);

  p_t_siz_rec.base_code              := v_base_code;
  p_t_siz_rec.base_value             := 0;
  p_t_siz_rec.plus_toleran_range     := 5;
  p_t_siz_rec.negative_toleran_range := 5;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;
  --新增批版尺寸临时表                                                             
  scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
END;';
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_approve_310_1_4', '新增克重', 'icon-morencaidan', 4, v_sql1 , null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

v_sql2 := 'DECLARE
  p_t_siz_rec         t_approve_version_size_chart_tmp%ROWTYPE;
  p_t_siz_dt_rec      t_approve_version_size_chart_details_tmp%ROWTYPE;
  v_goo_id            VARCHAR2(32);
  v_base_code         VARCHAR2(32);
  v_size_chart_tmp_id VARCHAR2(32);
  v_flag              INT;
  v_sizename          VARCHAR2(32);
  v_grammage          VARCHAR2(256) := @grammage@;
BEGIN

  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''APV_SIZE_CHART_GOO_ID'');
  --判断是否已存在克重
  scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => v_goo_id,
                                           p_table      => ''t_approve_version_size_chart_tmp'',
                                           p_grammage   => v_grammage);

  --交叉制表，判断是否已存在主表数据，保证只有新增一行主表数据 
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart_tmp_data(p_company_id          => %default_company_id%,
                                                                                      p_goo_id              => v_goo_id,
                                                                                      p_position            => v_grammage,
                                                                                      p_quantitative_method => v_grammage);

  IF v_flag = 0 THEN
    SELECT MAX(base_code)
      INTO v_base_code
      FROM (SELECT DISTINCT ts.base_code
              FROM scmdata.t_approve_version_size_chart_tmp ts
             WHERE ts.goo_id = v_goo_id
               AND ts.company_id = %default_company_id%);
  
    p_t_siz_rec.size_chart_tmp_id      := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := v_goo_id;
    p_t_siz_rec.seq_num                := 99;
    p_t_siz_rec.position               := v_grammage;
    p_t_siz_rec.quantitative_method    := v_grammage;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := 5;
    p_t_siz_rec.negative_toleran_range := 5;
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
     AND t.position = v_grammage
     AND t.quantitative_method = v_grammage;
  FOR size_rec IN (SELECT t.goo_id, ts.measure
                     FROM scmdata.t_approve_version_size_chart_tmp t
                    INNER JOIN scmdata.t_approve_version_size_chart_details_tmp ts
                       ON ts.size_chart_id = t.size_chart_tmp_id
                    WHERE t.company_id = %default_company_id%
                      AND t.goo_id = v_goo_id
                    GROUP BY t.goo_id, ts.measure) LOOP
    p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
    p_t_siz_dt_rec.size_chart_id        := v_size_chart_tmp_id;
    p_t_siz_dt_rec.measure              := size_rec.measure;
    p_t_siz_dt_rec.measure_value        := NULL;
    p_t_siz_dt_rec.pause                := 0;
    p_t_siz_dt_rec.create_id            := :user_id;
    p_t_siz_dt_rec.create_time          := SYSDATE;
    p_t_siz_dt_rec.update_id            := :user_id;
    p_t_siz_dt_rec.update_time          := SYSDATE;
    p_t_siz_dt_rec.memo                 := NULL;
    --新增尺码
    scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_dt_tmp(p_t_siz_rec => p_t_siz_dt_rec);
    --新增克重校验
    scmdata.pkg_size_chart.p_is_has_grammage_row_data(p_company_id          => %default_company_id%,
                                                      p_goo_id              => v_goo_id,
                                                      p_position            => v_grammage,
                                                      p_quantitative_method => v_grammage,
                                                      p_table1              => ''t_approve_version_size_chart_tmp'',
                                                      p_table2              => ''t_approve_version_size_chart_details_tmp'',
                                                      p_table1_pk_id        => ''size_chart_tmp_id'');
  END LOOP;
END;';
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_approve_310_2_3', '新增克重', 'icon-morencaidan', 4, v_sql2 , null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

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
  IF instr('';'' || v_rest_method || '';'', '';'' || ''POST'' || '';'') > 0 THEN
    v_sql := q''[DECLARE
  p_t_siz_rec     t_approve_version_size_chart%ROWTYPE;
  p_t_siz_dt_rec  t_approve_version_size_chart_details%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_flag          INT;
  v_sizename      VARCHAR2(32);
  v_goo_id        VARCHAR2(32) := '']'' || v_goo_id || q''['';  
  v_grammage      VARCHAR2(256) := @grammage@;
BEGIN
  --判断是否已存在克重
  /*scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => v_goo_id,
                                           p_table      => ''t_approve_version_size_chart'',
                                           p_grammage   => v_grammage);*/

  --交叉制表，判断是否已存在主表数据，保证只有新增一行主表数据  
  v_flag := scmdata.pkg_approve_version_size_chart.f_check_is_has_size_chart_data(p_company_id          => %default_company_id%,
                                                                                  p_goo_id              => v_goo_id,
                                                                                  p_position            => v_grammage,
                                                                                  p_quantitative_method => v_grammage);
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
    p_t_siz_rec.seq_num                := 99;
    p_t_siz_rec.position               := v_grammage;
    p_t_siz_rec.quantitative_method    := v_grammage;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := 5;
    p_t_siz_rec.negative_toleran_range := 5;
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
             AND t.position = v_grammage
             AND t.quantitative_method = v_grammage);

  FOR size_rec IN (SELECT t.goo_id, ts.measure
                     FROM scmdata.t_approve_version_size_chart t
                    INNER JOIN scmdata.t_approve_version_size_chart_details ts
                       ON ts.size_chart_id = t.size_chart_id
                    WHERE t.company_id = %default_company_id%
                      AND t.goo_id = v_goo_id
                    GROUP BY t.goo_id, ts.measure) LOOP
    p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
    p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
    p_t_siz_dt_rec.measure          := size_rec.measure;
    p_t_siz_dt_rec.measure_value    := NULL;
    p_t_siz_dt_rec.pause            := 0;
    p_t_siz_dt_rec.create_id        := :user_id;
    p_t_siz_dt_rec.create_time      := SYSDATE;
    p_t_siz_dt_rec.update_id        := :user_id;
    p_t_siz_dt_rec.update_time      := SYSDATE;
    p_t_siz_dt_rec.memo             := NULL;
    --新增尺码
    scmdata.pkg_approve_version_size_chart.p_insert_t_approve_version_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
    --新增克重校验
    scmdata.pkg_size_chart.p_is_has_grammage_row_data(p_company_id          => %default_company_id%,
                                                      p_goo_id              => v_goo_id,
                                                      p_position            => v_grammage,
                                                      p_quantitative_method => v_grammage,
                                                      p_table1              => ''t_approve_version_size_chart'',
                                                      p_table2              => ''t_approve_version_size_chart_details'');
  END LOOP;
END;
]'';
  ELSE
    NULL;
  END IF;
  @strresult := v_sql;
END;}';
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_approve_310_3_2', '新增克重', 'icon-morencaidan', 4, v_sql3 , null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

v_sql4 := 'DECLARE
  p_t_siz_rec t_size_chart_tmp%ROWTYPE;
  v_base_code VARCHAR2(32);
  v_grammage  VARCHAR2(256) := @grammage@;
BEGIN
  --模板校验
  scmdata.pkg_size_chart.p_check_is_has_size_chart_moudle_data(p_company_id => %default_company_id%,
                                                               p_goo_id     => :goo_id);
  --判断是否已存在克重
  scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => :goo_id,
                                           p_table      => ''t_size_chart_tmp'',
                                           p_type       => 1);

  p_t_siz_rec.size_chart_tmp_id   := scmdata.f_get_uuid();
  p_t_siz_rec.company_id          := %default_company_id%;
  p_t_siz_rec.goo_id              := :goo_id;
  p_t_siz_rec.seq_num             := 99;
  p_t_siz_rec.position            := v_grammage;
  p_t_siz_rec.quantitative_method := v_grammage;

  SELECT MAX(base_code)
    INTO v_base_code
    FROM (SELECT DISTINCT t.base_code
            FROM t_size_chart_tmp t
           WHERE t.goo_id = :goo_id
             AND t.company_id = %default_company_id%);

  p_t_siz_rec.base_code              := v_base_code;
  p_t_siz_rec.base_value             := 0;
  p_t_siz_rec.plus_toleran_range     := 5;
  p_t_siz_rec.negative_toleran_range := 5;
  p_t_siz_rec.pause                  := 0;
  p_t_siz_rec.create_id              := :user_id;
  p_t_siz_rec.create_time            := SYSDATE;
  p_t_siz_rec.update_id              := :user_id;
  p_t_siz_rec.update_time            := SYSDATE;
  p_t_siz_rec.memo                   := NULL;

  scmdata.pkg_size_chart.p_insert_t_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
END;';
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_1_4', '新增克重', 'icon-morencaidan', 4, v_sql4, null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

v_sql5 := 'DECLARE
  p_t_siz_rec         t_size_chart_tmp%ROWTYPE;
  p_t_siz_dt_rec      t_size_chart_details_tmp%ROWTYPE;
  v_goo_id            VARCHAR2(32);
  v_base_code         VARCHAR2(32);
  v_size_chart_tmp_id VARCHAR2(32);
  v_flag              INT;
  v_sizename          VARCHAR2(32);
  v_grammage          VARCHAR2(256) := @grammage@;
BEGIN

  v_goo_id := scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                 v_compid  => %default_company_id%,
                                                 v_varname => ''SIZE_CHART_GOO_ID'');
  --判断是否已存在克重
  scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => v_goo_id,
                                           p_table      => ''t_size_chart_tmp'',
                                           p_grammage   => v_grammage);

  --交叉制表，判断是否已存在主表数据，保证只有新增一行主表数据  
  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart_tmp_data(p_company_id          => %default_company_id%,
                                                                      p_goo_id              => v_goo_id,
                                                                      p_position            => v_grammage,
                                                                      p_quantitative_method => v_grammage);

  IF v_flag = 0 THEN
    SELECT MAX(base_code)
      INTO v_base_code
      FROM (SELECT DISTINCT ts.base_code
              FROM scmdata.t_size_chart_tmp ts
             WHERE ts.goo_id = v_goo_id
               AND ts.company_id = %default_company_id%);
  
    p_t_siz_rec.size_chart_tmp_id      := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := v_goo_id;
    p_t_siz_rec.seq_num                := 99;
    p_t_siz_rec.position               := v_grammage;
    p_t_siz_rec.quantitative_method    := v_grammage;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := 5;
    p_t_siz_rec.negative_toleran_range := 5;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := :user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := :user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --新增尺寸表主表
    scmdata.pkg_size_chart.p_insert_t_size_chart_tmp(p_t_siz_rec => p_t_siz_rec);
  END IF;
  --新增尺寸
  SELECT DISTINCT t.size_chart_tmp_id
    INTO v_size_chart_tmp_id
    FROM scmdata.t_size_chart_tmp t
   WHERE t.company_id = %default_company_id%
     AND t.goo_id = v_goo_id
     AND t.position = v_grammage
     AND t.quantitative_method = v_grammage;

  FOR size_rec IN (SELECT t.goo_id, ts.measure
                     FROM scmdata.t_size_chart_tmp t
                    INNER JOIN scmdata.t_size_chart_details_tmp ts
                       ON ts.size_chart_id = t.size_chart_tmp_id
                    WHERE t.company_id = %default_company_id%
                      AND t.goo_id = v_goo_id
                    GROUP BY t.goo_id, ts.measure) LOOP
    p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
    p_t_siz_dt_rec.size_chart_id        := v_size_chart_tmp_id;
    p_t_siz_dt_rec.measure              := size_rec.measure;
    p_t_siz_dt_rec.measure_value := NULL;
    p_t_siz_dt_rec.pause         := 0;
    p_t_siz_dt_rec.create_id     := :user_id;
    p_t_siz_dt_rec.create_time   := SYSDATE;
    p_t_siz_dt_rec.update_id     := :user_id;
    p_t_siz_dt_rec.update_time   := SYSDATE;
    p_t_siz_dt_rec.memo          := NULL;
    --新增尺码
    scmdata.pkg_size_chart.p_insert_t_size_chart_dt_tmp(p_t_siz_rec => p_t_siz_dt_rec);
    --新增克重校验
    scmdata.pkg_size_chart.p_is_has_grammage_row_data(p_company_id          => %default_company_id%,
                                                      p_goo_id              => v_goo_id,
                                                      p_position            => v_grammage,
                                                      p_quantitative_method => v_grammage,
                                                      p_table1              => ''t_size_chart_tmp'',
                                                      p_table2              => ''t_size_chart_details_tmp'',
                                                      p_table1_pk_id        => ''size_chart_tmp_id'');
  END LOOP;
END;';
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_2_3', '新增克重', 'icon-morencaidan', 4, v_sql5 , null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

v_sql6 := 'DECLARE
  p_t_siz_rec     t_size_chart%ROWTYPE;
  p_t_siz_dt_rec  t_size_chart_details%ROWTYPE;
  v_base_code     VARCHAR2(32);
  v_size_chart_id VARCHAR2(32);
  v_flag          INT;
  v_sizename      VARCHAR2(32);
  v_grammage      VARCHAR2(256) := @grammage@;
BEGIN
  --判断是否已存在克重
  /*scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => :goo_id,
                                           p_table      => ''t_size_chart'',
                                           p_grammage   => v_grammage);*/
                                           
  --交叉制表，判断是否已存在主表数据，保证只有新增一行主表数据                                        
  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart_data(p_company_id          => %default_company_id%,
                                                                  p_goo_id              => :goo_id,
                                                                  p_position            => v_grammage,
                                                                  p_quantitative_method => v_grammage);
  IF v_flag = 0 THEN
    SELECT MAX(base_code)
      INTO v_base_code
      FROM (SELECT DISTINCT ts.base_code
              FROM scmdata.t_size_chart ts
             WHERE ts.goo_id = :goo_id
               AND ts.company_id = %default_company_id%);
  
    p_t_siz_rec.size_chart_id          := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := :goo_id;
    p_t_siz_rec.seq_num                := 99;
    p_t_siz_rec.position               := v_grammage;
    p_t_siz_rec.quantitative_method    := v_grammage;
    p_t_siz_rec.base_code              := v_base_code;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := 5;
    p_t_siz_rec.negative_toleran_range := 5;
    p_t_siz_rec.pause                  := 0;
    p_t_siz_rec.create_id              := :user_id;
    p_t_siz_rec.create_time            := SYSDATE;
    p_t_siz_rec.update_id              := :user_id;
    p_t_siz_rec.update_time            := SYSDATE;
    p_t_siz_rec.memo                   := NULL;
    --新增尺寸表主表
    scmdata.pkg_size_chart.p_insert_t_size_chart(p_t_siz_rec => p_t_siz_rec);
  END IF;
  --新增尺寸
  SELECT size_chart_id
    INTO v_size_chart_id
    FROM (SELECT DISTINCT t.size_chart_id
            FROM scmdata.t_size_chart t
           WHERE t.company_id = %default_company_id%
             AND t.goo_id = :goo_id
             AND t.position = v_grammage
             AND t.quantitative_method = v_grammage);

  FOR size_rec IN (SELECT t.goo_id, ts.measure
                     FROM scmdata.t_size_chart t
                    INNER JOIN scmdata.t_size_chart_details ts
                       ON ts.size_chart_id = t.size_chart_id
                    WHERE t.company_id = %default_company_id%
                      AND t.goo_id = :goo_id
                    GROUP BY t.goo_id, ts.measure) LOOP
    p_t_siz_dt_rec.size_chart_dt_id := scmdata.f_get_uuid();
    p_t_siz_dt_rec.size_chart_id    := v_size_chart_id;
    v_sizename                      := scmdata.pkg_size_chart.f_get_size_company_dict(p_company_id => %default_company_id%,
                                                                                      p_size_name  => size_rec.measure);
    p_t_siz_dt_rec.measure          := size_rec.measure;
    --尺码校验
    p_t_siz_dt_rec.measure_value := NULL;
    p_t_siz_dt_rec.pause         := 0;
    p_t_siz_dt_rec.create_id     := :user_id;
    p_t_siz_dt_rec.create_time   := SYSDATE;
    p_t_siz_dt_rec.update_id     := :user_id;
    p_t_siz_dt_rec.update_time   := SYSDATE;
    p_t_siz_dt_rec.memo          := NULL;
    --新增尺码
    scmdata.pkg_size_chart.p_insert_t_size_chart_details(p_t_siz_rec => p_t_siz_dt_rec);
    --新增克重校验
    scmdata.pkg_size_chart.p_is_has_grammage_row_data(p_company_id          => %default_company_id%,
                                                      p_goo_id              => :goo_id,
                                                      p_position            => v_grammage,
                                                      p_quantitative_method => v_grammage,
                                                      p_table1              => ''t_size_chart'',
                                                      p_table2              => ''t_size_chart_details'');
    --同步数据至批版列表
    scmdata.pkg_size_chart.p_sync_gd_size_chart_to_apv(p_company_id => %default_company_id%,
                                                       p_goo_id     => :goo_id);
  END LOOP;
END;';
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_3_2', '新增克重', 'icon-morencaidan', 4, v_sql6, null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);

v_sql7 := '{DECLARE
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
  v_grammage      VARCHAR2(256) := @grammage@;
BEGIN
  --判断是否已存在克重
  scmdata.pkg_size_chart.p_is_has_grammage(p_company_id => %default_company_id%,
                                           p_goo_id     => v_goo_id,
                                           p_table      => ''t_size_chart_import_tmp'',
                                           p_grammage   => v_grammage);

  --交叉制表，判断是否已存在主表数据，保证只有新增一行主表数据  
  v_flag := scmdata.pkg_size_chart.f_check_is_has_size_chart_import_data(p_company_id          => %default_company_id%,
                                                                         p_goo_id              => v_goo_id,
                                                                         p_position            => v_grammage,
                                                                         p_quantitative_method => v_grammage);
  IF v_flag = 0 THEN
    p_t_siz_rec.size_chart_tmp_id      := scmdata.f_get_uuid();
    p_t_siz_rec.company_id             := %default_company_id%;
    p_t_siz_rec.goo_id                 := v_goo_id;
    p_t_siz_rec.seq_num                := 99;
    p_t_siz_rec.position               := v_grammage;
    p_t_siz_rec.quantitative_method    := v_grammage;
    p_t_siz_rec.base_code              := NULL;
    p_t_siz_rec.base_value             := 0;
    p_t_siz_rec.plus_toleran_range     := 5;
    p_t_siz_rec.negative_toleran_range := 5;
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
  --新增尺寸
  SELECT MAX(size_chart_tmp_id)
    INTO v_size_chart_id
    FROM (SELECT DISTINCT t.size_chart_tmp_id
            FROM scmdata.t_size_chart_import_tmp t
           WHERE t.company_id = %default_company_id%
             AND t.goo_id = v_goo_id
             AND t.position = v_grammage
             AND t.quantitative_method = v_grammage);
  FOR size_rec IN (SELECT t.goo_id, ts.measure
                     FROM scmdata.t_size_chart_import_tmp t
                    INNER JOIN scmdata.t_size_chart_details_import_tmp ts
                       ON ts.size_chart_id = t.size_chart_tmp_id
                    WHERE t.company_id = %default_company_id%
                      AND t.goo_id = v_goo_id
                    GROUP BY t.goo_id, ts.measure) LOOP
    p_t_siz_dt_rec.size_chart_dt_tmp_id := scmdata.f_get_uuid();
    p_t_siz_dt_rec.size_chart_id        := v_size_chart_id;
    p_t_siz_dt_rec.measure              := size_rec.measure;
    p_t_siz_dt_rec.measure_value        := NULL;
    p_t_siz_dt_rec.pause                := 0;
    p_t_siz_dt_rec.create_id            := :user_id;
    p_t_siz_dt_rec.create_time          := SYSDATE;
    p_t_siz_dt_rec.update_id            := :user_id;
    p_t_siz_dt_rec.update_time          := SYSDATE;
    p_t_siz_dt_rec.memo                 := NULL;
    --新增尺码
    scmdata.pkg_size_chart.p_insert_t_size_chart_details_import_tmp(p_t_siz_rec => p_t_siz_dt_rec);
    --新增克重校验
    scmdata.pkg_size_chart.p_is_has_grammage_row_data(p_company_id          => %default_company_id%,
                                                      p_goo_id              => v_goo_id,
                                                      p_position            => v_grammage,
                                                      p_quantitative_method => v_grammage,
                                                      p_table1              => ''t_size_chart_import_tmp'',
                                                      p_table2              => ''t_size_chart_details_import_tmp'',
                                                      p_table1_pk_id        => ''size_chart_tmp_id'');
  END LOOP;
END;
]'';
  END IF;
  @strresult := v_sql;
END;}';
insert into bw3.sys_action (ELEMENT_ID, CAPTION, ICON_NAME, ACTION_TYPE, ACTION_SQL, SELECT_FIELDS, REFRESH_FLAG, MULTI_PAGE_FLAG, PRE_FLAG, FILTER_EXPRESS, UPDATE_FIELDS, PORT_ID, PORT_SQL, LOCK_SQL, SELECTION_FLAG, CALL_ID, OPERATE_MODE, PORT_TYPE, QUERY_FIELDS, SELECTION_METHOD)
values ('action_a_good_310_4_4', '新增克重', 'icon-morencaidan', 4, v_sql7, null, 1, 1, 0, null, null, null, null, null, 0, null, null, 1, null, null);
END;
/
BEGIN
insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_3', 'action_a_good_310_3_2', 2, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_1', 'action_a_good_310_1_4', 4, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_2', 'action_a_good_310_2_3', 3, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_4', 'action_a_good_310_4_4', 4, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_3', 'action_a_approve_310_3_2', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_1', 'action_a_approve_310_1_4', 4, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_2', 'action_a_approve_310_2_3', 3, 0, null);

END;
/
BEGIN
insert into bw3.sys_element (ELEMENT_ID, ELEMENT_TYPE, DATA_SOURCE, PAUSE, MESSAGE, IS_HIDE, MEMO, IS_ASYNC, IS_PER_EXE, ENABLE_STAND_PERMISSION)
values ('control_a_good_310_3_1', 'control', 'oracle_plm', 0, null, null, null, null, null, null);

insert into bw3.sys_field_control (ELEMENT_ID, FROM_FIELD, CONTROL_EXPRESS, CONTROL_FIELDS, CONTROL_TYPE)
values ('control_a_good_310_3_1', 'SEQ_NUM', '''{{SEQ_NUM}}''!=99', 'POSITION', 0);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_3', 'control_a_good_310_3_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_1', 'control_a_good_310_3_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_approve_310_2', 'control_a_good_310_3_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_1', 'control_a_good_310_3_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_2', 'control_a_good_310_3_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_3', 'control_a_good_310_3_1', 1, 0, null);

insert into bw3.sys_item_element_rela (ITEM_ID, ELEMENT_ID, SEQ_NO, PAUSE, LEVEL_NO)
values ('a_good_310_4', 'control_a_good_310_3_1', 1, 0, null);

END;
/
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
  v_params   := ''{'' || v_params || ''}'';
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' GOO_ID from dual'';
  @strresult := v_sql;
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
  v_params   := ''{'' || v_params || ''}'';
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;
}';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_approve_111_3';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{
DECLARE
  v_sql     CLOB;
  v_methods VARCHAR2(256) := ''GET;POST;PUT;DELETE'';
  v_params  VARCHAR2(4000);
  v_goo_size_chart_type VARCHAR2(32);
  v_rela_goo_id         VARCHAR2(32);
BEGIN
  --导入数据前 先清空数据
  --根据商品档案-尺码表 初始化尺寸导入表
  scmdata.pkg_size_chart.p_reset_size_chart_imp_tmp_data(p_company_id => %default_company_id%,
                                                         p_goo_id     => :goo_id,
                                                         p_user_id    => :user_id);

  v_goo_size_chart_type := scmdata.pkg_size_chart.f_get_good_size_chart_type(p_company_id => %default_company_id%,
                                                                             p_goo_id     => :goo_id);
                                                                             
  --ass 参数携带  
  v_params   := ''"item_id"'' || '':'' || ''"'' || ''a_approve_111'' || ''"'';
  v_params   := v_params || '','' || ''"goo_size_chart_type"'' || '':'' || ''"'' || v_goo_size_chart_type || ''"'';
  SELECT MAX(t.rela_goo_id)
    INTO v_rela_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.goo_id = :goo_id
     AND t.company_id = %default_company_id%;
  v_params   := v_params || '','' || ''"rela_goo_id"'' || '':'' || ''"'' || v_rela_goo_id || ''"'';
  v_params   := ''{'' || v_params || ''}'';
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;
}';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_approve_111_4';
END;
/
DECLARE
v_sql CLOB;
BEGIN
v_sql := '{
DECLARE
  v_sql                 CLOB;
  v_methods             VARCHAR2(256) := ''GET;POST;PUT;DELETE'';
  v_params              VARCHAR2(4000);
  v_goo_size_chart_type VARCHAR2(32);
  v_rela_goo_id         VARCHAR2(32);
BEGIN
  --导入数据前 先清空数据
  --根据商品档案-尺码表 初始化尺寸导入表
  scmdata.pkg_size_chart.p_reset_size_chart_imp_tmp_data(p_company_id => %default_company_id%,
                                                         p_goo_id     => :goo_id,
                                                         p_user_id    => :user_id);
  v_goo_size_chart_type := scmdata.pkg_size_chart.f_get_good_size_chart_type(p_company_id => %default_company_id%,
                                                                             p_goo_id     => :goo_id);
  --ass 参数携带
  v_params   := ''"item_id"'' || '':'' || ''"'' || ''a_good_110'' || ''"'';
  v_params   := v_params || '','' || ''"goo_size_chart_type"'' || '':'' || ''"'' || v_goo_size_chart_type || ''"'';
  SELECT MAX(t.rela_goo_id)
    INTO v_rela_goo_id
    FROM scmdata.t_commodity_info t
   WHERE t.goo_id = :goo_id
     AND t.company_id = %default_company_id%;
  v_params   := v_params || '','' || ''"rela_goo_id"'' || '':'' || ''"'' || v_rela_goo_id || ''"'';
  v_params   := ''{'' || v_params || ''}'';
  v_sql      := ''select '''''' || :goo_id || ''/'' || v_methods || ''?'' ||
                v_params || '''''' GOO_ID from dual'';
  @strresult := v_sql;
END;
}';
UPDATE bw3.sys_associate t SET t.data_sql = v_sql WHERE t.element_id = 'associate_a_good_110_2';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[SELECT '（货号：' || t.rela_goo_id || '）'
  FROM scmdata.t_commodity_info t
 WHERE t.goo_id = :goo_id
   AND t.company_id = %default_company_id%]';
   
UPDATE bw3.sys_item t SET t.sub_scripts = v_sql WHERE t.item_id = 'a_approve_310_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[SELECT '（货号：' || t.rela_goo_id || '）'
  FROM scmdata.t_commodity_info t
 WHERE t.goo_id = (SELECT scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                             v_compid  => %default_company_id%,
                                                             v_varname => 'APV_SIZE_CHART_GOO_ID')
                     FROM dual)
   AND t.company_id = %default_company_id%]';
   
UPDATE bw3.sys_item t SET t.sub_scripts = v_sql WHERE t.item_id = 'a_approve_310_2';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[SELECT '（货号：' || scmdata.pkg_data_privs.parse_json(p_jsonstr => scmdata.pkg_plat_comm.f_get_val_by_delimit(p_character => :goo_id,
                                                                     p_separate  => '?',
                                                                     p_is_pre    => 0),
                                                                     p_key     => 'rela_goo_id') || '）'
  FROM dual]';
   
UPDATE bw3.sys_item t SET t.sub_scripts = v_sql WHERE t.item_id = 'a_approve_310_3';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[SELECT '（货号：' || t.rela_goo_id || '）'
  FROM scmdata.t_commodity_info t
 WHERE t.goo_id = :goo_id
   AND t.company_id = %default_company_id%]';
   
UPDATE bw3.sys_item t SET t.sub_scripts = v_sql WHERE t.item_id = 'a_good_310_1';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[SELECT '（货号：' || t.rela_goo_id || '）'
  FROM scmdata.t_commodity_info t
 WHERE t.goo_id = (SELECT scmdata.pkg_variable.f_get_varchar(v_objid   => :user_id,
                                                             v_compid  => %default_company_id%,
                                                             v_varname => 'SIZE_CHART_GOO_ID')
                     FROM dual)
   AND t.company_id = %default_company_id%]';
   
UPDATE bw3.sys_item t SET t.sub_scripts = v_sql WHERE t.item_id = 'a_good_310_2';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[SELECT '（货号：' || t.rela_goo_id || '）'
  FROM scmdata.t_commodity_info t
 WHERE t.goo_id = :goo_id
   AND t.company_id = %default_company_id%]';
   
UPDATE bw3.sys_item t SET t.sub_scripts = v_sql WHERE t.item_id = 'a_good_310_3';
END;
/
DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[SELECT '（货号：' || scmdata.pkg_data_privs.parse_json(p_jsonstr => scmdata.pkg_plat_comm.f_get_val_by_delimit(p_character => :goo_id,
                                                                     p_separate  => ''?'',
                                                                     p_is_pre    => 0),
                                                                     p_key     => ''rela_goo_id'') || '）'
  FROM dual]';
   
UPDATE bw3.sys_item t SET t.sub_scripts = v_sql WHERE t.item_id = 'a_good_310_4';
END;
/
BEGIN
insert into BW3.Sys_Param_List (PARAM_NAME, DATA_SOURCE, CAPTION, DEFAULT_SQL, VALUE_SQL, REQUIRED_FLAG, HOTKEY, DISPLAY_WIDTH, READ_ONLY_FLAG, MIN_VALUE, MAX_VALUE, VALUE_STEP, MAX_LENGTH, EDIT_MASK, HINT_TEXT, PARAM_TYPE, DATA_TYPE, SEPARATOR, IS_MULTI)
values ('GRAMMAGE', 'oracle_scmdata', '克重', null, 'SELECT ''羽绒克重'' GRAMMAGE FROM dual
UNION ALL
SELECT ''大货成品克重(不含吊牌)'' GRAMMAGE FROM dual', 1, null, null, null, null, null, null, null, null, null, null, null, null, null);
END;
/

