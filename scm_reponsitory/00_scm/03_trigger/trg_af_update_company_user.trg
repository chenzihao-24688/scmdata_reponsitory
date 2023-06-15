CREATE OR REPLACE TRIGGER SCMDATA.TRG_AF_UPDATE_COMPANY_USER
  before update on sys_company_user
  for each row
declare
  PRAGMA AUTONOMOUS_TRANSACTION;
  p_i   number(1);
  p_msg varchar(100);
begin
  /*update:zwh73
  用户被企业管理员停用更改*/
  if :NEW.PAUSE = 1 and :OLD.Pause = 0 and
     PKG_USER_DEFAULT_COMPANY.F_is_user_company_default(:NEW.user_id,
                                                        :NEW.company_id) = 1 then
    PKG_USER_DEFAULT_COMPANY.P_user_company_default_when_user_change(:NEW.user_id,
                                                                     p_i,
                                                                     p_msg);
  end if;
  commit;
end TRG_AF_UPDATE_COMPANY_USER;
/

