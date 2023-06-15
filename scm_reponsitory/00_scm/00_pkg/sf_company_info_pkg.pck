create or replace package scmdata.sf_company_info_pkg is

  -- Author  : SANFU
  -- Created : 2020/7/6 10:01:03
  -- Purpose : 企业管理

  --启用，停用  更新公司状态（0：正常，1：停用）
  PROCEDURE update_company_status(p_company_id VARCHAR2, p_status number);

end sf_company_info_pkg;
/

create or replace package body scmdata.sf_company_info_pkg is

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:45:29
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 启用，停用  更新公司状态（0：正常，1：停用）
  * Obj_Name    : UPDATE_COMPANY_STATUS
  * Arg_Number  : 2
  * P_COMPANY_ID :公司编号
  * P_STATUS :公司禁用状态
  *============================================*/
  PROCEDURE update_company_status(p_company_id VARCHAR2, p_status number) IS
    v_status  number;
    x_err_msg varchar2(1000);
    company_exp exception;
    user_default_exp exception;
    p_i   number;
    p_msg varchar2(100);
  BEGIN
    select c.pause
      into v_status
      from scmdata.sys_company c
     where c.company_id = p_company_id;
  
    if p_status <> v_status then
      update scmdata.sys_company c
         set c.pause = p_status
       where c.company_id = p_company_id;
      --修改相关的用户的默认企业 edit:zwh73
      if p_status = 1 then
        PKG_USER_DEFAULT_COMPANY.P_user_company_default_when_company_pause(p_company_id,
                                                                           p_i,
                                                                           p_msg);
        if p_i < 0 then
          raise user_default_exp;
        end if;
      end if;
    else
      --操作重复报提示信息
      raise company_exp;
    end if;
  exception
    when user_default_exp then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => p_msg,
                                               p_is_running_error => 'F');
    when company_exp then
      x_err_msg := '不可重复操作！！';
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
    
  END update_company_status;
end sf_company_info_pkg;
/

