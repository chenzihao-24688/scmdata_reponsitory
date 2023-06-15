create or replace trigger scmdata.sf_sys_user_tri
  after insert on sys_user
  for each row
--触发器实现用户注册时，设置平台默认角色
declare
  v_flag number;
  --获取平台默认角色
  cursor data_cur is
    select t.group_role_id
      from scmdata.SYS_GROUP_ROLE t
     where t.is_default = 1;
begin
  select count(1)
    into v_flag
    from scmdata.SYS_GROUP_ROLE t
   where t.is_default = 1;
  if v_flag = 0 then
    raise_application_error(-20002,
                            'scm平台未设置平台默认角色，请联系管理员设置，再进行注册..');
  else
    --用户与用户权限建立关系，设置平台默认角色
    for data_rec in data_cur loop
      insert into scmdata.SYS_GROUP_USER_ROLE
        (user_role_id, user_id, group_role_id)
      values
        (scmdata.f_get_uuid, :NEW.USER_ID, data_rec.group_role_id);
    end loop;
  end if;

end sf_sys_user_tri;
/

