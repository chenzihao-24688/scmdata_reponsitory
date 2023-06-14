declare
  v_s clob := '
select a.sys_group_wecom_msg_pattern_id,
       a.pause,
       a.apply_id APPLY_ID_N,  ---20230110lsl新增字段
       a.sys_group_wecom_msg_pattern_code,
       a.sys_group_wecom_msg_pattern_name,
       a.msg_pattern,
       a.PARAM_NAME_LIST,
       a.descriptors,
       a.QUANTIFIER,
       a.complex_limit,
       a.hint_sql
  from scmdata.sys_group_wecom_msg_pattern a';
  v_u clob := 'declare
  v_count number;
begin
  select count(sys_group_wecom_msg_pattern_code)
    into v_count
    from scmdata.sys_group_wecom_msg_pattern
   where sys_group_wecom_msg_pattern_code = :sys_group_wecom_msg_pattern_code
     and sys_group_wecom_msg_pattern_id <> :sys_group_wecom_msg_pattern_id;
  if v_count > 0 then
    raise_application_error(-20002, ''模板编码不可重复！请检查'');
  end if;
  update scmdata.sys_group_wecom_msg_pattern a
     set a.sys_group_wecom_msg_pattern_code = :sys_group_wecom_msg_pattern_code,
         a.sys_group_wecom_msg_pattern_name = :sys_group_wecom_msg_pattern_name,
         a.msg_pattern                      = :msg_pattern,
         a.hint_sql                         = :hint_sql,
         a.descriptors                      = :descriptors,
         a.complex_limit                    = :complex_limit,
         a.pause                            = :pause,
         a.apply_id                         = :APPLY_ID_N, ---20230110lsl新增字段
         a.QUANTIFIER                       = :QUANTIFIER,
         a.PARAM_NAME_LIST                  = :PARAM_NAME_LIST
   where a.sys_group_wecom_msg_pattern_id = :sys_group_wecom_msg_pattern_id;
end;';
  v_i clob := 'declare
  v_count number;
begin
  select count(sys_group_wecom_msg_pattern_code)
    into v_count
    from scmdata.sys_group_wecom_msg_pattern
   where sys_group_wecom_msg_pattern_code = :sys_group_wecom_msg_pattern_code;
  if v_count > 0 then
    raise_application_error(-20002, ''模板编码不可重复！请检查'');
  end if;
  insert into scmdata.sys_group_wecom_msg_pattern
    (sys_group_wecom_msg_pattern_id,
     sys_group_wecom_msg_pattern_code,
     sys_group_wecom_msg_pattern_name,
     msg_pattern,
     hint_sql,
     descriptors,
     complex_limit,
     pause,
     apply_id,
     QUANTIFIER,
     PARAM_NAME_LIST)
  values
    (scmdata.f_get_uuid(),
     :sys_group_wecom_msg_pattern_code,
     :sys_group_wecom_msg_pattern_name,
     :msg_pattern,
     :hint_sql,
     :descriptors,
     :complex_limit,
     :pause,
     :APPLY_ID_N,
     :QUANTIFIER,
     :PARAM_NAME_LIST);
end;';
  v_d clob := 'delete from scmdata.sys_group_wecom_msg_pattern a
 where a.sys_group_wecom_msg_pattern_id = :sys_group_wecom_msg_pattern_id';
begin
  update bw3.sys_item_list t
     set t.select_sql    = v_s,
         t.update_sql    = v_u,
         t.insert_sql    = v_i,
         t.delete_sql    = v_d,
         t.noshow_fields = 'sys_group_wecom_msg_pattern_id,APPLY_ID_N'
   where t.item_id = 'g_531';
end;
/
