create or replace trigger scmdata.TR_BF_D_SYS_APP_ROLE_GROUP
  before delete
  on sys_app_role_group 
  for each row
declare
  ----------------------------------------------------------------------
  --- 目的： 删除SYS_APP_ROLE_GROUP时限制
  --- 作者： 张文海
  --- 创建时间： 20210203
  --- 最后修改人：
  --- 最后更改日期:
  -----------------------------------------------------------------------
   v_i int;
begin
  select max(1) into v_i
    from sys_app_role_group_ra a
   where a.role_group_id=:old.role_group_id and a.company_id=:old.company_id;
  if v_i =1 then
    Raise_application_error( -20002, '该角色组关联了角色，无法删除哦');
  end if;
  
  select max(1) into v_i
    from sys_app_user_role_group_ra a
   where a.role_group_id=:old.role_group_id and a.company_id=:old.company_id;
  if v_i =1 then
    Raise_application_error( -20002, '该角色组关联了用户，无法删除哦');
  end if;
end TR_BF_D_SYS_APP_ROLE_GROUP;
/

