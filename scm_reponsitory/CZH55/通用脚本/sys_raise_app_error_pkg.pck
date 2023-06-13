create or replace package sys_raise_app_error_pkg is

  -- Author  : SANFU
  -- Created : 2020/8/1 10:21:30
  -- Purpose : �쳣��������ʱ�쳣��ҵ���쳣��

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
  * Purpose  : �쳣����
  * Obj_Name    : IS_RUNNING_ERROR
  * Arg_Number  : 2
  * X_MESSAGE :������Ϣ
  * P_IS_RUNNING_ERROR :��T:����ʱ�쳣��F��ҵ����ʾ��
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
      v_error_type := 'ϵͳ����Oracle �쳣��';
      raise running_error_exp;
    elsif 'F' = p_is_running_error then
      v_error_type := 'ҵ����ʾ';
      raise not_running_error_exp;
    end if;
  
    error_msg_rec.error_type := v_error_type;
  
  exception
  
    when not_running_error_exp then
    
      error_msg_rec.error_id       := nbw.SYS_APP_ERROR_MSG_S.NEXTVAL;
      error_msg_rec.error_line_num := dbms_utility.format_error_backtrace;
      --ҵ���쳣�������б�д��ʾ��Ϣ  
      error_msg_rec.error_msg := nvl(p_err_msg,
                                     dbms_utility.format_error_stack);
    
      /*      if p_err_msg is null then
        v_err_msg := error_msg_rec.error_msg;
      end if;*/
      --���뵽������Ϣ����¼��־
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
                              v_error_type || '��' ||
                              error_msg_rec.error_msg);
    
    when running_error_exp then
    
      error_msg_rec.error_id       := nbw.SYS_APP_ERROR_MSG_S.NEXTVAL;
      error_msg_rec.error_line_num := dbms_utility.format_error_backtrace;
      error_msg_rec.error_msg      := nvl(p_err_msg,
                                          dbms_utility.format_error_stack);
    
      /*      if p_err_msg is null then
        v_err_msg := error_msg_rec.error_msg;
      end if;*/
      --���뵽������Ϣ����¼��־
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
                              v_error_type || ',' || '����ϵƽ̨����Ա����' ||
                              '�����ţ�' || error_msg_rec.error_id);
  end is_running_error;

end sys_raise_app_error_pkg;
/
