CREATE OR REPLACE TRIGGER SCMDATA.TRGAFINTCOMPANY AFTER INSERT on SYS_COMPANY
For each Row
Declare
  P_I int;
  v_tips varchar2(200);
  v_company_role_id varchar2(32);
Begin
  select max(1) into P_I from dual
   where not exists(select 1 from sys_company_role a where a.company_role_name in ('超级管理员','管理员','普通用户') and a.company_id=:new.company_id);
  if p_i =1 then
    --1.创建企业角色：创建者
    v_tips :='企业的创建者(系统自带)';
    v_company_role_id:=f_get_uuid();
    insert into sys_company_role(company_role_id,company_id,company_role_name,tips,sort,create_id,create_time,update_id,update_time)
    values(v_company_role_id,:new.company_id,'超级管理员',v_tips,1,'ADMIN',SYSDATE,'ADMIN',SYSDATE);

    insert into sys_company_role_security(role_security_id,company_id,company_role_id,company_security_id)
    values(f_get_uuid(),:new.company_id,v_company_role_id,'0');

    --2.创建企业角色：管理员
    v_tips :='企业的管理员，负责企业应用、配置、组织、人员等管理(系统自带)';
    v_company_role_id:=f_get_uuid();
    insert into sys_company_role(company_role_id,company_id,company_role_name,tips,sort,create_id,create_time,update_id,update_time)
    values(v_company_role_id,:new.company_id,'管理员',v_tips,2,'ADMIN',SYSDATE,'ADMIN',SYSDATE);

    insert into sys_company_role_security(role_security_id,company_id,company_role_id,company_security_id)
    select f_get_uuid(),:new.company_id,v_company_role_id,a.company_security_id
      from sys_company_security a
     where a.company_security_id<>'0';

    --3.创建企业角色:普通用户
    v_tips :='企业的普通用户(系统自带)';
    v_company_role_id:=f_get_uuid();
    insert into sys_company_role(company_role_id,company_id,company_role_name,tips,sort,create_id,create_time,update_id,update_time,is_default)
    values(v_company_role_id,:new.company_id,'普通用户',v_tips,3,'ADMIN',SYSDATE,'ADMIN',SYSDATE,1);
  end if;
End;
/

