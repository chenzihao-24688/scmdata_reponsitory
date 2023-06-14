CREATE OR REPLACE TRIGGER SCMDATA.TRGBFDELCOMPANY_ROLE
before DELETE on SYS_COMPANY_ROLE
For each Row
Declare
  P_I int;
Begin
  select max(1) into P_I from sys_company_user_role a where a.company_role_id=:OLD.COMPANY_ROLE_ID ;
  if p_i =1 then
    raise_application_error(-20002,'该角色已经分配给了企业用户，若要删除，请删除该权限下所存在的用户');
  end if;
End;
/

