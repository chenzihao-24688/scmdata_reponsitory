create or replace package scmdata.SF_GROUP_ROLE_SECURITY_PKG is

  -- Author  : SANFU
  -- Created : 2020/7/8 11:50:41
  -- Purpose : 角色权限管理

  --选择权限（角色与权限关联）
  PROCEDURE ass_role_security(p_group_role_id     VARCHAR2,
                              p_group_security_id VARCHAR2);

  --设置平台默认角色
  PROCEDURE set_default_role(p_group_role_id VARCHAR2,
                             p_default_flag  NUMBER);

end SF_GROUP_ROLE_SECURITY_PKG;
/

create or replace package body scmdata.SF_GROUP_ROLE_SECURITY_PKG is

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:39:30
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  选择权限（角色与权限关联）
  * Obj_Name    : ASS_ROLE_SECURITY
  * Arg_Number  : 2
  * P_GROUP_ROLE_ID :
  * P_GROUP_SECURITY_ID :
  *============================================*/

  PROCEDURE ass_role_security(p_group_role_id     VARCHAR2,
                              p_group_security_id VARCHAR2) IS
  
  BEGIN
  
    insert into scmdata.SYS_GROUP_ROLE_SECURITY
      (group_role_security_id, group_role_id, group_security_id)
    values
      (scmdata.f_get_uuid(), p_group_role_id, p_group_security_id);
  
  exception
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => null,
                                               p_is_running_error => 'T');
    
  END ass_role_security;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:40:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  设置平台默认角色
  * Obj_Name    : SET_DEFAULT_ROLE
  * Arg_Number  : 2
  * P_GROUP_ROLE_ID :
  * P_DEFAULT_FLAG :
  *============================================*/
  PROCEDURE set_default_role(p_group_role_id VARCHAR2,
                             p_default_flag  NUMBER) is
    v_flag    number;
    x_err_msg varchar2(1000);
    default_role_exp exception;
  begin
    select gr.is_default
      into v_flag
      from scmdata.SYS_GROUP_ROLE gr
     where gr.group_role_id = p_group_role_id;
  
    if p_default_flag <> v_flag then
      update scmdata.SYS_GROUP_ROLE gr
         set gr.is_default = p_default_flag
       where gr.group_role_id = p_group_role_id;
    else
      --操作重复报提示信息
      raise default_role_exp;
    end if;
  
  exception
    when default_role_exp then
      x_err_msg := '不可重复操作！！';
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => null,
                                               p_is_running_error => 'T');
  end set_default_role;

end SF_GROUP_ROLE_SECURITY_PKG;
/

