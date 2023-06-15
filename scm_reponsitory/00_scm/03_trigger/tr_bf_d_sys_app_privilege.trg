CREATE OR REPLACE TRIGGER SCMDATA.TR_BF_D_SYS_APP_PRIVILEGE
  Before  Delete On SYS_APP_PRIVILEGE
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
Begin

  select max(1) into v_i
    from sys_app_role_priv_ra a
   where a.priv_id=:old.priv_id;
  if v_i =1 then
    Raise_application_error( -20002, '该权限已经被其它角色所引用，无法删除哦');
  end if;

END TR_BF_D_SYS_APP_PRIVILEGE;
/

