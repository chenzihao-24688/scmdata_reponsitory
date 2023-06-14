CREATE OR REPLACE PACKAGE sys_raise_app_error_pkg IS

  -- Author  : SANFU
  -- Created : 2021/8/16 15:15:26
  -- Purpose : ϵͳ������־��

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-01 15:18:15
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �쳣����
  * Obj_Name    : IS_RUNNING_ERROR
  * Arg_Number  : 2
  * X_MESSAGE :������Ϣ
  * P_IS_RUNNING_ERROR :��T:����ʱ�쳣��F��ҵ����ʾ��
  *============================================*/

  PROCEDURE is_running_error(p_is_running_error IN VARCHAR2,
                             p_is_log           IN NUMBER DEFAULT 0,
                             p_err_msg          IN VARCHAR2 DEFAULT NULL);

  --��¼������Ϣ������־
  PROCEDURE insert_sys_app_error_msg(p_error_msg_rec scmdata.sys_app_error_msg%ROWTYPE,
                                     p_is_log        NUMBER DEFAULT 0);

END sys_raise_app_error_pkg;
/
CREATE OR REPLACE PACKAGE BODY sys_raise_app_error_pkg IS

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-08-01 15:18:15
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : �쳣����
  * Obj_Name    : IS_RUNNING_ERROR
  * Arg_Number  : 2
  * X_MESSAGE :������Ϣ
  * P_IS_RUNNING_ERROR :��R:����ʱ�쳣��B��ҵ����ʾ��
  * P_IS_LOG :�Ƿ��¼��־ 0 ������¼  1����¼   Ĭ��Ϊ0
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
      v_error_type := '����ʱ�쳣';
      RAISE running_error_exp;
    ELSIF 'F' = p_is_running_error THEN
      v_error_type := '��ʾ';
      RAISE not_running_error_exp;
    ELSE
      raise_application_error(-20002,
                              'sys_raise_app_error_pkg,�쳣��������,����ϵ����Ա��');
    END IF;
  
  EXCEPTION
    WHEN not_running_error_exp THEN
      error_msg_rec.error_line_num := dbms_utility.format_error_backtrace;
      --ҵ���쳣�������б�д��ʾ��Ϣ  
      error_msg_rec.error_msg := nvl(p_err_msg,
                                     dbms_utility.format_error_stack);
    
      --���뵽������Ϣ����¼��־
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
      --���뵽������Ϣ����¼��־   
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
                              v_error_type || ',�����ţ�[' ||
                              error_msg_rec.error_code || ']' || ',' ||
                              '����ϵƽ̨����Ա����');
  END is_running_error;
  --��¼������Ϣ������־
  --P_IS_LOG :�Ƿ��¼��־ 0 ������¼  1����¼   Ĭ��Ϊ0
  PROCEDURE insert_sys_app_error_msg(p_error_msg_rec scmdata.sys_app_error_msg%ROWTYPE,
                                     p_is_log        NUMBER DEFAULT 0) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    IF p_is_log = 1 THEN
      --���뵽������Ϣ����¼��־
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
                              '����ʱ�쳣����¼������Ϣ������־��������ϵ����Ա!');
  END insert_sys_app_error_msg;
END sys_raise_app_error_pkg;
/
