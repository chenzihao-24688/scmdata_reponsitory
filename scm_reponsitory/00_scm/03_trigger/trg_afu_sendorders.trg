create or replace trigger scmdata.TRG_AFU_SENDORDERS
  after update
  on T_SENDORDERS 
  for each row
declare
  -- local variables here
begin
  UPDATE T_SENDORDERED A SET A.UPDATE_TIME=SYSDATE WHERE A.SEND_ID=:NEW.SEND_ID 
     AND A.COMPANY_ID=:NEW.COMPANY_ID;
     
end TRG_AFU_SENDORDERS;
/

