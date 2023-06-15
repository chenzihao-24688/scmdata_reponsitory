create or replace package scmdata.sf_user_info_pkg is

  -- Author  : SANFU
  -- Created : 2020/7/4 11:04:50
  -- Purpose : 用户管理

  --更新用户状态（0：正常，1：停用）
  PROCEDURE update_user_status(p_user_id VARCHAR2, p_status number);
  --重置密码 
  PROCEDURE update_user_pwd(p_user_id VARCHAR2);
  --设置平台角色
  PROCEDURE set_user_type(p_user_id VARCHAR2, p_user_role_type VARCHAR2);
end sf_user_info_pkg;
/

create or replace package body scmdata.sf_user_info_pkg is

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   更新用户状态（0：正常，1：停用）
  * Obj_Name    : UPDATE_USER_STATUS
  * Arg_Number  : 2
  * P_USER_ID :用户编号
  * P_STATUS :用户状态
  *============================================*/
  PROCEDURE update_user_status(p_user_id VARCHAR2, p_status number) IS
    v_status  number;
    x_err_msg varchar2(1000);
    user_exp exception;
  BEGIN
    select u.pause
      into v_status
      from scmdata.sys_user u
     where u.user_id = p_user_id;
  
    if p_status <> v_status then
      update scmdata.sys_user u
         set u.pause = p_status
       where u.user_id = p_user_id;
    else
      --操作重复报提示信息
      raise user_exp;
    end if;
  
  exception
    when user_exp then
      x_err_msg := '不可重复操作！！';
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
    
  END update_user_status;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:31:12
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :    重置密码  
  * Obj_Name    : UPDATE_USER_PWD
  * Arg_Number  : 1
  * P_USER_ID : 用户编号
  *============================================*/

  PROCEDURE update_user_pwd(p_user_id VARCHAR2) IS
  BEGIN
    update scmdata.sys_user u
       set u.password = '3a1e503f0e1314063758153030155837061cc2' --123321 
     where u.user_id = p_user_id;
  exception
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => null,
                                               p_is_running_error => 'T');
  END update_user_pwd;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-01 16:29:02
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 设置平台角色
  * Obj_Name    : SET_USER_TYPE
  * Arg_Number  : 2
  * P_USER_ID : 用户编号
  * P_USER_ROLE_TYPE :用户角色类型
  *============================================*/
  PROCEDURE set_user_type(p_user_id VARCHAR2, p_user_role_type VARCHAR2) IS
    --v_user_role_id VARCHAR2(100);
    v_num number;
  BEGIN
  
    select count(1)
      into v_num
      from scmdata.SYS_GROUP_USER_ROLE ur
     where ur.user_id = p_user_id;
  
    --如果角色原有的关系带有了，先把原有的关联关系去掉
    if v_num > 0 then
      delete from scmdata.SYS_GROUP_USER_ROLE ur
       where ur.user_id = p_user_id;
    end if;
  
    --再新增关联关系
    insert into scmdata.SYS_GROUP_USER_ROLE
      (user_role_id, user_id, group_role_id)
    values
      (f_get_uuid(), p_user_id, p_user_role_type);
  exception
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => null,
                                               p_is_running_error => 'T');
  END set_user_type;

end sf_user_info_pkg;
/

