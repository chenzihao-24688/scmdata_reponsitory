CREATE OR REPLACE TRIGGER SCMDATA.TRGBFUDCOMPANY_ROLE
BEFORE  UPDATE OR DELETE on Sys_Company_Role
For each Row
Declare
  P_I int;
  v_tips varchar2(200);
  v_company_role_id varchar2(32);
Begin
  if updating('company_role_name') then
   if :OLD.company_role_name <>:NEW.company_role_name AND :OLD.company_role_name IN ('超级管理员','管理员','普通用户') then
     raise_application_error(-20003,'此角色为企业默认角色，无法进行修改');
   end if;
  elsif deleting and  :old.company_role_name in ('超级管理员','管理员','普通用户')  then
    raise_application_error(-20003,'此角色为企业默认角色，无法删除');
  end if;
End;
/

