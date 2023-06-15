create or replace package scmdata.sf_sys_group_dict_pkg is

  -- Author  : SANFU
  -- Created : 2020/7/13 16:12:20
  -- Purpose : 数据字典管理

  --启用，停用  更新数据字典状态（0：正常，1：停用）
  PROCEDURE update_dict_pause(p_group_dict_id VARCHAR2, p_status number);
end sf_sys_group_dict_pkg;
/

create or replace package body scmdata.sf_sys_group_dict_pkg is

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:34:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 启用，停用  更新数据字典状态（0：正常，1：停用）
  * Obj_Name    : UPDATE_DICT_PAUSE
  * Arg_Number  : 2
  * P_GROUP_DICT_ID :数据字典编号
  * P_STATUS :状态
  *============================================*/
  PROCEDURE update_dict_pause(p_group_dict_id VARCHAR2, p_status number) IS
    v_status  number;
    x_err_msg varchar2(1000);
    dict_exp exception;
  BEGIN
    select g.pause
      into v_status
      from scmdata.sys_group_dict g
     where g.group_dict_id = p_group_dict_id;
  
    if p_status <> v_status then
      update scmdata.sys_group_dict g
         set g.pause = p_status
       where g.group_dict_id = p_group_dict_id;
    else
      --操作重复报提示信息
      raise dict_exp;
    end if;
  
  exception
    when dict_exp then
      x_err_msg := '不可重复操作！！';
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => null,
                                               p_is_running_error => 'T');
  END update_dict_pause;

end sf_sys_group_dict_pkg;
/

