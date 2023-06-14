declare
  v_sql clob := '{declare
v_class_data_privs clob;
begin
 v_class_data_privs := pkg_data_privs.parse_json(p_jsonstr => %data_privs_json_strs%,p_key => ''COL_2'');
 @strresult :=''(SELECT * FROM (SELECT '' || '''''''' || v_class_data_privs || '''''''' || '' FROM dual))'';
end;}';
begin
  update bw3.sys_item_list t
     set t.subselect_sql = v_sql
   where t.item_id in ('a_check_101', 'a_check_102');
end;
/
