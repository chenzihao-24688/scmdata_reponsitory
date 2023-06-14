DECLARE
v_sql clob;
BEGIN
  FOR t IN (SELECT * FROM nbw.sys_field_list) LOOP
   v_sql := 'INSERT BW3.sys_field_list VALUES ('''|| nvl(t.field_name,'') || ''','''|| nvl(t.caption,'') || ''','''|| nvl(t.requiered_flag,'') || ''','''|| nvl(t.input_hint,'') || ''','''|| nvl(t.valid_chars,'') || ''','''|| nvl(t.invalid_chars,'') || ''','''|| nvl(t.check_express,'') || ''', '''|| nvl(t.check_message,'') || ''','''|| nvl(t.read_only_flag,'') || ''','''|| nvl(t.no_edit,'') || ''','''|| nvl(t.no_copy,'') || ''','''|| nvl(t.no_sum,'') || ''','''|| nvl(t.no_sort,'') || ''','''|| nvl(t.alignment,'') || ''','''|| nvl(t.max_length,'') || ''', '''|| nvl(t.min_length,'') || ''','''|| nvl(t.display_width,'') || ''','''|| nvl(t.display_format,'') || ''','''|| nvl(t.edit_formt,'') || ''','''|| nvl(t.data_type,'') || ''','''|| nvl(t.max_value,'') || ''','''|| nvl(t.min_value,'') || ''','''|| nvl(t.default_value,'') || ''','''|| nvl(t.ime_care,'') || ''','''|| nvl(t.ime_open,'') || ''','''|| nvl(t.value_lists,'') || ''','''|| nvl(t.value_list_type,'') || ''','''|| nvl(t.hyper_res,'')|| ''', '''|| nvl(t.multi_value_flag,'') || ''','''|| nvl(t.true_expr,'') || ''', '''|| nvl(t.false_expr,'') || ''','''|| nvl(t.name_rule_flag,'') || ''','''|| nvl(t.name_rule_id,'') || ''','''|| nvl(t.data_type_flag,'') || ''','''|| nvl(t.allow_scan,'') || ''','''|| nvl(t.value_encrypt,'') || ''','''|| nvl(t.value_sensitive,'') || ''','''|| nvl(t.operator_flag,'') || ''','''|| nvl(t.value_display_style,'') || ''','''|| nvl(t.to_item_id,'') || ''', '''|| nvl(t.value_sensitive_replacement,'') || ''','''|| nvl(t.store_source,'') || ''','''|| nvl(t.enable_stand_permission,'') || ''')'; 
       dbms_output.put_line(v_sql||chr(13));
   END LOOP;

END;
