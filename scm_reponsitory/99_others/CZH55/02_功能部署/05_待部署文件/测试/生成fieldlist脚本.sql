/*
'[{"RUN":"1","CAPTION":"","DATA_TYPE":"","INPUT_HINT":"","DEFAULT_VALUE":"","CHECK_EXPRESS":"","CHECK_MESSAGE":"",
"ALIGNMENT":"2","REQUERED":"1","READ_ONLY":"0","NO_EDIT":"0","NO_COPY":"0","NO_SUM":"0","NO_SORT":"0",
"MAX_VALUE":"","MIN_VALUE":"","MAX_LENGTH":"","MIN_LENGTH":"","DISPLAY_WIDTH":"","DISPLAY_FORMAT":"","EDIT_FORMT":"","STORE_SOURCE":""}]'
*/
DECLARE
  v_tb_pre     VARCHAR2(256) := 'nbw';
  v_pre        VARCHAR2(256);
  v_suf        VARCHAR2(256);
  v_table_name VARCHAR2(256);
  v_rtn        VARCHAR2(2000);
  v_fd_rec     nbw.sys_field_list%ROWTYPE;
  v_sql        CLOB;
BEGIN
  FOR tab_rec IN (SELECT t.*, c.comments
                    FROM user_tab_columns t
                   INNER JOIN user_col_comments c
                      ON t.table_name = c.table_name
                     AND t.column_name = c.column_name
                   WHERE t.table_name = upper('t_czh_sup_info_test')
                   ORDER BY t.column_id) LOOP
   
    v_rtn := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                p_key => 'REQUERED');
  
    --�Ƿ����                    
    v_fd_rec.requiered_flag := (CASE
                                 WHEN v_rtn IS NOT NULL THEN
                                  to_number(v_rtn)
                                 ELSE
                                  (CASE
                                    WHEN tab_rec.nullable = 'Y' THEN
                                     0
                                    ELSE
                                     1
                                  END)
                               END);
    v_rtn := (CASE
               WHEN v_rtn = '1' THEN
                'N'
               WHEN v_rtn = '0' THEN
                'Y'
               ELSE
                NULL
             END);
  
    --�ֶ���
    v_fd_rec.field_name := v_pre || tab_rec.column_name ||
                           nvl(v_suf,
                               (CASE
                                 WHEN nvl(v_rtn, tab_rec.nullable) = 'Y' THEN
                                  '_N'
                                 ELSE
                                  '_Y'
                               END));
  
    v_fd_rec.field_name := CASE
                             WHEN v_fd_rec.field_name IS NULL THEN
                              'NULL'
                             ELSE
                              '''' || v_fd_rec.field_name || ''''
                           END;
    v_rtn               := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                              p_key => 'CAPTION');
    --�ֶ�����                    
    v_fd_rec.caption := nvl(v_rtn,
                            TRIM(substr(tab_rec.comments,
                                        0,
                                        instr(tab_rec.comments, '[') - 1)));
    v_fd_rec.caption := CASE
                          WHEN v_fd_rec.caption IS NULL THEN
                           'NULL'
                          ELSE
                           '''' || v_fd_rec.caption || ''''
                        END;
  
    v_rtn := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                p_key => 'INPUT_HINT');
    v_fd_rec.input_hint := CASE WHEN v_rtn IS NULL THEN 'NULL' ELSE '''' || v_rtn || '''' END;
    v_fd_rec.valid_chars   := 'NULL';
    v_fd_rec.invalid_chars := 'NULL';
    v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                 p_key => 'ALIGNMENT');
    v_fd_rec.alignment     := nvl(v_rtn, 2);
    v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                 p_key => 'DATA_TYPE');
    v_fd_rec.data_type     := CASE WHEN v_rtn IS NULL THEN 'NULL' ELSE '''' || v_rtn || '''' END;
    v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                 p_key => 'CHECK_EXPRESS');
    v_fd_rec.check_express := CASE WHEN v_rtn IS NULL THEN 'NULL' ELSE '''' || v_rtn || '''' END;
    v_rtn                  := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                 p_key => 'CHECK_MESSAGE');
    v_fd_rec.check_message := CASE WHEN v_rtn IS NULL THEN 'NULL' ELSE '''' || v_rtn || '''' END;
  
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'DEFAULT_VALUE');
    v_fd_rec.default_value  := CASE WHEN v_rtn IS NULL THEN 'NULL' ELSE '''' || v_rtn || '''' END;
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'MAX_VALUE');
    v_fd_rec.max_value      := nvl(v_rtn,0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'MIN_VALUE');
    v_fd_rec.min_value      := nvl(v_rtn,0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'MAX_LENGTH');
    v_fd_rec.max_length     := nvl(v_rtn,0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'MIN_LENGTH');
    v_fd_rec.min_length     := nvl(v_rtn,0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'DISPLAY_WIDTH');
    v_fd_rec.display_width  := nvl(v_rtn,0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'DISPLAY_FORMAT');
    v_fd_rec.display_format := CASE WHEN v_rtn IS NULL THEN 'NULL' ELSE '''' || v_rtn || '''' END;
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'EDIT_FORMT');
    v_fd_rec.edit_formt     := CASE WHEN v_rtn IS NULL THEN 'NULL' ELSE '''' || v_rtn || '''' END;
  
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'READ_ONLY');
    v_fd_rec.read_only_flag := nvl(v_rtn, 0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'NO_EDIT');
    v_fd_rec.no_edit        := nvl(v_rtn, 0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'NO_COPY');
    v_fd_rec.no_copy        := nvl(v_rtn, 0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'NO_SUM');
    v_fd_rec.no_sum         := nvl(v_rtn, 0);
    v_rtn                   := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                  p_key => 'NO_SORT');
    v_fd_rec.no_sort        := nvl(v_rtn, 0);
  
    v_fd_rec.ime_care                    := 0;
    v_fd_rec.ime_open                    := 0;
    v_fd_rec.value_lists                 := 'NULL';
    v_fd_rec.value_list_type             := 0;
    v_fd_rec.hyper_res                   := 'NULL';
    v_fd_rec.multi_value_flag            := 0;
    v_fd_rec.true_expr                   := 'NULL';
    v_fd_rec.false_expr                  := 'NULL';
    v_fd_rec.name_rule_flag              := 0;
    v_fd_rec.name_rule_id                := 0;
    v_fd_rec.data_type_flag              := 0;
    v_fd_rec.allow_scan                  := 0;
    v_fd_rec.value_encrypt               := 0;
    v_fd_rec.value_sensitive             := 0;
    v_fd_rec.operator_flag               := 0;
    v_fd_rec.value_display_style         := 'NULL';
    v_fd_rec.to_item_id                  := 'NULL';
    v_fd_rec.value_sensitive_replacement := 'NULL';
    v_rtn                                := scmdata.pkg_plat_comm.f_parse_json(scmdata.sf_get_arguments_pkg.get_json_str(tab_rec.comments),
                                                                               p_key => 'STORE_SOURCE');
    v_fd_rec.store_source                := CASE WHEN v_rtn IS NULL THEN 'NULL' ELSE '''' || v_rtn || '''' END;
    v_fd_rec.enable_stand_permission     := 0;
  
    v_sql := q'[INSERT INTO ]' || v_tb_pre || q'[.sys_field_list 
  (field_name, caption, requiered_flag, input_hint, valid_chars,invalid_chars, check_express, check_message, read_only_flag, no_edit,no_copy, no_sum, no_sort, alignment, max_length, min_length,display_width, display_format, edit_formt, data_type, max_value,min_value, default_value, ime_care, ime_open, value_lists,value_list_type, hyper_res, multi_value_flag, true_expr, false_expr,name_rule_flag, name_rule_id, data_type_flag, allow_scan, value_encrypt,value_sensitive, operator_flag, value_display_style, to_item_id,value_sensitive_replacement, store_source, enable_stand_permission)
VALUES
  (]' || v_fd_rec.field_name || q'[,]' || v_fd_rec.caption ||
             q'[,]' || v_fd_rec.requiered_flag || q'[,]' ||
             v_fd_rec.input_hint || q'[,]' || v_fd_rec.valid_chars ||
             q'[,]' || v_fd_rec.invalid_chars || q'[,]' ||
             v_fd_rec.check_express || q'[,]' || v_fd_rec.check_message ||
             q'[,]' || v_fd_rec.read_only_flag || q'[,]' ||
             v_fd_rec.no_edit || q'[,]' || v_fd_rec.no_copy || q'[,]' ||
             v_fd_rec.no_sum || q'[,]' || v_fd_rec.no_sort || q'[,]' ||
             v_fd_rec.alignment || q'[,]' || v_fd_rec.max_length || q'[,]' ||
             v_fd_rec.min_length || q'[,]' || v_fd_rec.display_width ||
             q'[,]' || v_fd_rec.display_format || q'[,]' ||
             v_fd_rec.edit_formt || q'[,]' || v_fd_rec.data_type || q'[,]' ||
             v_fd_rec.max_value || q'[,]' || v_fd_rec.min_value || q'[,]' ||
             v_fd_rec.default_value || q'[,]' || v_fd_rec.ime_care ||
             q'[,]' || v_fd_rec.ime_open || q'[,]' || v_fd_rec.value_lists ||
             q'[,]' || v_fd_rec.value_list_type || q'[,]' ||
             v_fd_rec.hyper_res || q'[,]' || v_fd_rec.multi_value_flag ||
             q'[,]' || v_fd_rec.true_expr || q'[,]' || v_fd_rec.false_expr ||
             q'[,]' || v_fd_rec.name_rule_flag || q'[,]' ||
             v_fd_rec.name_rule_id || q'[,]' || v_fd_rec.data_type_flag ||
             q'[,]' || v_fd_rec.allow_scan || q'[,]' ||
             v_fd_rec.value_encrypt || q'[,]' || v_fd_rec.value_sensitive ||
             q'[,]' || v_fd_rec.operator_flag || q'[,]' ||
             v_fd_rec.value_display_style || q'[,]' || v_fd_rec.to_item_id ||
             q'[,]' || v_fd_rec.value_sensitive_replacement || q'[,]' ||
             v_fd_rec.store_source || q'[,]' ||
             v_fd_rec.enable_stand_permission || q'[);]';
    dbms_output.put_line('');
    dbms_output.put_line(v_sql);
  END LOOP;
END;
