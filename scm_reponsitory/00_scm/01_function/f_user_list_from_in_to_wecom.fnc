create or replace function scmdata.F_USER_LIST_FROM_IN_TO_WECOM(pi_user_list in varchar2,
                                                        value_step   in varchar2)
  return varchar2 is
  FunctionResult varchar2(100);
begin
  /*
  * author:zwh73
    2021年9月25日11:52:59
    将内部员工号列表转为企业微信发送用户列表
  */
  for x in (SELECT REGEXP_SUBSTR(pi_user_list,
                                 '[^' || value_step || ']+',
                                 1,
                                 LEVEL,
                                 'i') userid
              FROM DUAL
            CONNECT BY LEVEL <=
                       LENGTH(pi_user_list) -
                       LENGTH(REGEXP_REPLACE(pi_user_list, ';', '')) + 1) loop
    FunctionResult := FunctionResult || '<@' || x.userid || '>';
  end loop;
  return(FunctionResult);
end F_USER_LIST_FROM_IN_TO_WECOM;
/

