CREATE OR REPLACE PACKAGE SCMDATA.sys_raise_app_error_pkg IS

  -- Author  : SANFU
  -- Created : 2021/8/16 15:15:26
  -- Purpose : 系统错误日志包

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

  PROCEDURE is_running_error(p_is_running_error IN VARCHAR2,
                             p_is_log           IN NUMBER DEFAULT 0,
                             p_err_msg          IN VARCHAR2 DEFAULT NULL);

  --记录错误信息表至日志
  PROCEDURE insert_sys_app_error_msg(p_error_msg_rec scmdata.sys_app_error_msg%ROWTYPE,
                                     p_is_log        NUMBER DEFAULT 0);

END sys_raise_app_error_pkg;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.sys_raise_app_error_pkg IS

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-01 15:18:15
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 异常处理
  * Obj_Name    : IS_RUNNING_ERROR
  * Arg_Number  : 2
  * X_MESSAGE :错误消息
  * P_IS_RUNNING_ERROR :（R:运行时异常，B：业务提示）
  * P_IS_LOG :是否记录日志 0 ：不记录  1：记录   默认为0
  *============================================*/

  PROCEDURE is_running_error(p_is_running_error IN VARCHAR2,
                             p_is_log           IN NUMBER DEFAULT 0,
                             p_err_msg          IN VARCHAR2 DEFAULT NULL) IS
  
    v_error_type VARCHAR2(100);
    --v_err_msg    varchar2(1000);
    running_error_exp     EXCEPTION;
    not_running_error_exp EXCEPTION;
    error_msg_rec scmdata.sys_app_error_msg%ROWTYPE;
  BEGIN
  
    IF 'T' = p_is_running_error THEN
      v_error_type := '运行时异常';
      RAISE running_error_exp;
    ELSIF 'F' = p_is_running_error THEN
      v_error_type := '提示';
      RAISE not_running_error_exp;
    ELSE
      raise_application_error(-20002,
                              'sys_raise_app_error_pkg,异常参数报错,请联系管理员！');
    END IF;
  
  EXCEPTION
    WHEN not_running_error_exp THEN
      error_msg_rec.error_line_num := dbms_utility.format_error_backtrace;
      --业务异常，可自行编写提示信息  
      error_msg_rec.error_msg := nvl(p_err_msg,
                                     dbms_utility.format_error_stack);
    
      --插入到错误信息表，记录日志
      BEGIN
        error_msg_rec.error_type := v_error_type;
        error_msg_rec.error_id   := scmdata.f_get_uuid();
        error_msg_rec.error_code := pkg_plat_comm.f_getkeyid_plat(pi_pre     => 'ERR_',
                                                                  pi_seqname => 'SYS_APP_ERROR_MSG_S',
                                                                  pi_seqnum  => 2);
        insert_sys_app_error_msg(p_error_msg_rec => error_msg_rec,
                                 p_is_log        => p_is_log);
      END;
      raise_application_error(-20002,
                              v_error_type || ':' ||
                              error_msg_rec.error_msg);
    
    WHEN running_error_exp THEN
      ROLLBACK;
      error_msg_rec.error_line_num := dbms_utility.format_error_backtrace;
      error_msg_rec.error_msg      := nvl(p_err_msg,
                                          dbms_utility.format_error_stack);
      --插入到错误信息表，记录日志   
      BEGIN
        error_msg_rec.error_type := v_error_type;
        error_msg_rec.error_id   := scmdata.f_get_uuid();
        error_msg_rec.error_code := /*pkg_plat_comm.*/f_getkeyid_plat(pi_pre     => 'ERR_',
                                                                  pi_seqname => 'SYS_APP_ERROR_MSG_S',
                                                                  pi_seqnum  => 2);
        insert_sys_app_error_msg(p_error_msg_rec => error_msg_rec,
                                 p_is_log        => p_is_log);
      END;
    
      raise_application_error(-20002,
                              v_error_type || ',错误编号：[' ||
                              error_msg_rec.error_code || ']' || ',' ||
                              '请联系平台管理员！！');
  END is_running_error;
  --记录错误信息表至日志
  --P_IS_LOG :是否记录日志 0 ：不记录  1：记录   默认为0
  PROCEDURE insert_sys_app_error_msg(p_error_msg_rec scmdata.sys_app_error_msg%ROWTYPE,
                                     p_is_log        NUMBER DEFAULT 0) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    IF p_is_log = 1 THEN
      --插入到错误信息表，记录日志
      INSERT INTO scmdata.sys_app_error_msg
      VALUES
        (p_error_msg_rec.error_id,
         p_error_msg_rec.error_code,
         p_error_msg_rec.error_type,
         p_error_msg_rec.error_line_num,
         p_error_msg_rec.error_msg,
         'ADMIN',
         SYSDATE,
         'ADMIN',
         SYSDATE);
    
      COMMIT;
    ELSE
      NULL;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(-20002,
                              '运行时异常：记录错误信息表至日志报错，请联系管理员!');
  END insert_sys_app_error_msg;
END sys_raise_app_error_pkg;
/

