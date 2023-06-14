declare
  --Ԥ��������
  --��Ԥ��������
  --�û��Զ������⣨ҵ�����⣩
  --������룬�����кţ����������Ϣ
  v_account           varchar2(100);
  v_flag              number;
  v_app_error_line_id varchar2(100);
  x_error_type        varchar2(100);
  x_line_num          varchar2(100);
  x_message           varchar2(1000);
  v_is_running_error  varchar2(100);
  test_exception exception;

begin
/*  select count(1)
    into v_flag
    from scmdata.sys_user u
   where u.user_account = '18172543571';

  if v_flag > 0 then
    raise test_exception;
  end if;*/

  select u.user_account
    into v_account
    from scmdata.sys_user u
   where u.sex = '��';
exception
  when test_exception then
    v_is_running_error := 'FALSE';
    x_message := 'user_account��������';
    SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_app_error_line_id => v_app_error_line_id,
                                             x_error_type        => x_error_type,
                                             x_line_num          => x_line_num,
                                             x_message           => x_message,
                                             p_is_running_error  => v_is_running_error);

  when others then
    v_is_running_error := 'TRUE';
  
    SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_app_error_line_id => v_app_error_line_id,
                                             x_error_type        => x_error_type,
                                             x_line_num          => x_line_num,
                                             x_message           => x_message,
                                             p_is_running_error  => v_is_running_error);

end;


select * from SYS_APP_ERROR_MSG ORDER BY CREATE_TIME DESC;


