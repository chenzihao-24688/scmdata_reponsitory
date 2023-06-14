--测试环境同步开发
--1.字段同步
DECLARE
v_sql clob;
BEGIN
  FOR t IN (SELECT * FROM nbw.sys_field_list@db_link_scmdata_nbw fd WHERE NOT EXISTS (SELECT 1
              FROM bw3.sys_field_list t
             WHERE t.field_name = fd.field_name)) LOOP
   v_sql := 'INSERT INTO BW3.sys_field_list VALUES ('''|| nvl(t.field_name,'') || ''','''|| nvl(t.caption,'') || ''','''|| nvl(t.requiered_flag,'') || ''','''|| nvl(t.input_hint,'') || ''','''|| nvl(t.valid_chars,'') || ''','''|| nvl(t.invalid_chars,'') || ''','''|| nvl(t.check_express,'') || ''', '''|| nvl(t.check_message,'') || ''','''|| nvl(t.read_only_flag,'') || ''','''|| nvl(t.no_edit,'') || ''','''|| nvl(t.no_copy,'') || ''','''|| nvl(t.no_sum,'') || ''','''|| nvl(t.no_sort,'') || ''','''|| nvl(t.alignment,'') || ''','''|| nvl(t.max_length,'') || ''', '''|| nvl(t.min_length,'') || ''','''|| nvl(t.display_width,'') || ''','''|| nvl(t.display_format,'') || ''','''|| nvl(t.edit_formt,'') || ''','''|| nvl(t.data_type,'') || ''','''|| nvl(t.max_value,'') || ''','''|| nvl(t.min_value,'') || ''','''|| nvl(t.default_value,'') || ''','''|| nvl(t.ime_care,'') || ''','''|| nvl(t.ime_open,'') || ''','''|| nvl(t.value_lists,'') || ''','''|| nvl(t.value_list_type,'') || ''','''|| nvl(t.hyper_res,'')|| ''', '''|| nvl(t.multi_value_flag,'') || ''','''|| nvl(t.true_expr,'') || ''', '''|| nvl(t.false_expr,'') || ''','''|| nvl(t.name_rule_flag,'') || ''','''|| nvl(t.name_rule_id,'') || ''','''|| nvl(t.data_type_flag,'') || ''','''|| nvl(t.allow_scan,'') || ''','''|| nvl(t.value_encrypt,'') || ''','''|| nvl(t.value_sensitive,'') || ''','''|| nvl(t.operator_flag,'') || ''','''|| nvl(t.value_display_style,'') || ''','''|| nvl(t.to_item_id,'') || ''', '''|| nvl(t.value_sensitive_replacement,'') || ''','''|| nvl(t.store_source,'') || ''','''|| nvl(t.enable_stand_permission,'') || ''');'; 
       dbms_output.put_line(v_sql||chr(13));
   END LOOP;
END;

--2.字典同步
--平台字典
DECLARE
v_sql clob;
BEGIN
  FOR t IN (SELECT * FROM scmdata.sys_group_dict@db_link_scmdata fd WHERE NOT EXISTS (SELECT 1
          FROM scmdata.sys_group_dict t WHERE t.group_dict_type = fd.group_dict_type
           AND t.group_dict_value = fd.group_dict_value)) LOOP
   v_sql := 'INSERT INTO scmdata.sys_group_dict VALUES ('''||t.group_dict_id||''','''||t.parent_id||''','''||t.parent_ids||''','''||t.group_dict_name||''','''||t.group_dict_value||''','''||t.group_dict_type||''','''||t.description||''','''||t.group_dict_sort||''','''||t.group_dict_status||''','''||t.tree_level||''','''||t.is_leaf||''','''||t.is_initial||''','''||t.create_id||''','''||t.create_time||''','''||t.update_id||''','''||t.update_time||''','''||t.remarks||''','''||t.del_flag||''','''||t.pause||''','''||t.is_company_dict_rela||''');';
       dbms_output.put_line(v_sql||chr(13));
   END LOOP;
END;
