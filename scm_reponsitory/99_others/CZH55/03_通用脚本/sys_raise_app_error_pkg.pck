create or replace package sys_raise_app_error_pkg is

  -- Author  : SANFU
  -- Created : 2020/8/1 10:21:30
  -- Purpose : 异常处理（运行时异常，业务异常）

  procedure is_running_error(p_err_msg          in varchar2 default null,
                             p_is_running_error in varchar2);

end sys_raise_app_error_pkg;
/
create or replace package body sys_raise_app_error_pkg is

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-01 15:18:15
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 异常处理
  * Obj_Name    : IS_RUNNING_ERROR
  * Arg_Number  : 2
  * X_MESSAGE :错误消息
  * P_IS_RUNNING_ERROR :（T:运行时异常，F：业务提示）
  *============================================*/

  procedure is_running_error(p_err_msg          in varchar2 default null,
                             p_is_running_error in varchar2) is
  
    v_error_type varchar2(100);
    --v_err_msg    varchar2(1000);
    running_error_exp     exception;
    not_running_error_exp exception;
    error_msg_rec nbw.sys_app_error_msg%rowtype;
  begin
  
    if 'T' = p_is_running_error then
      v_error_type := '系统报错（Oracle 异常）';
      raise running_error_exp;
    elsif 'F' = p_is_running_error then
      v_error_type := '业务提示';
      raise not_running_error_exp;
    end if;
  
    error_msg_rec.error_type := v_error_type;
  
  exception
  
    when not_running_error_exp then
    
      error_msg_rec.error_id       := nbw.SYS_APP_ERROR_MSG_S.NEXTVAL;
      error_msg_rec.error_line_num := dbms_utility.format_error_backtrace;
      --业务异常，可自行编写提示信息  
      error_msg_rec.error_msg := nvl(p_err_msg,
                                     dbms_utility.format_error_stack);
    
      /*      if p_err_msg is null then
        v_err_msg := error_msg_rec.error_msg;
      end if;*/
      --插入到错误信息表，记录日志
      insert into nbw.SYS_APP_ERROR_MSG
        (ERROR_ID, ERROR_TYPE, ERROR_LINE_NUM, ERROR_MSG, CREATE_TIME)
      values
        (error_msg_rec.error_id,
         error_msg_rec.error_type,
         error_msg_rec.error_line_num,
         error_msg_rec.error_msg,
         sysdate);
      commit;
      raise_application_error(-20002,
                              v_error_type || '：' ||
                              error_msg_rec.error_msg);
    
    when running_error_exp then
    
      error_msg_rec.error_id       := nbw.SYS_APP_ERROR_MSG_S.NEXTVAL;
      error_msg_rec.error_line_num := dbms_utility.format_error_backtrace;
      error_msg_rec.error_msg      := nvl(p_err_msg,
                                          dbms_utility.format_error_stack);
    
      /*      if p_err_msg is null then
        v_err_msg := error_msg_rec.error_msg;
      end if;*/
      --插入到错误信息表，记录日志
      insert into nbw.SYS_APP_ERROR_MSG
        (ERROR_ID, ERROR_TYPE, ERROR_LINE_NUM, ERROR_MSG, CREATE_TIME)
      values
        (error_msg_rec.error_id,
         error_msg_rec.error_type,
         error_msg_rec.error_line_num,
         error_msg_rec.error_msg,
         sysdate);
      commit;
      raise_application_error(-20002,
                              v_error_type || ',' || '请联系平台管理员！！' ||
                              '错误编号：' || error_msg_rec.error_id);
  end is_running_error;

end sys_raise_app_error_pkg;
/
