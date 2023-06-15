CREATE OR REPLACE TRIGGER SCMDATA.TR_BF_D_SYS_APP_ROLE
  Before  Delete On SYS_APP_ROLE
  FOR EACH ROW
Declare
  ----------------------------------------------------------------------
  --- 目的： 删除SYS_APP_ROLE时限制
  --- 作者： 黄翔
  --- 创建时间： 20201106
  --- 最后修改人：
  --- 最后更改日期:
  -----------------------------------------------------------------------
  v_i int;
  v_group_name varchar2(100);
Begin

  select max(1),max(b.role_group_name) into v_i,v_group_name
    from sys_app_role_group_ra a
    left join sys_app_role_group b on a.role_group_id=b.role_group_id and a.company_id=b.company_id
   where a.role_id=:old.role_id and a.company_id=:old.company_id;
  if v_i =1 then
    Raise_application_error( -20002, '该角色已经被其它权限组('||v_group_name||')所引用，无法删除哦');
  end if;

END TR_BF_D_SYS_APP_ROLE;
/

