create or replace procedure scmdata.p_return_plan_msg is
  v_f varchar2(2);
  errorCode number;
  errorMsg varchar2(2000);
begin
  v_f :=1/0;
 exception when others then
   errorCode :=SQLCODE;
   errorMsg :=substr(SQLERRM,1,200);
    insert into scmdata.sys_company_wecom_msg
      (company_wecom_msg_id,
       robot_type,
       company_id,
       status,
       create_time,
       create_id,
       msgtype,
       content,
       mentioned_list,
       mentioned_mobile_list)
    values
      (scmdata.f_get_uuid(),
       'RETURN_PLAN_MSG',
       'a972dd1ffe3b3a10e0533c281cac8fd7',
       2,
       sysdate,
       'ADMIN',
       'text',
       '回货计划错误通知
定时跑发生错误:
'||errorCode||errorMsg||' ',
       'LSL167',
       null);

end;
/

