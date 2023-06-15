create or replace trigger scmdata.trg_af_i_sys_app_privilege
  after insert on sys_app_privilege
  for each row
declare
  --PRAGMA AUTONOMOUS_TRANSACTION;
begin
  delete scmdata.sys_app_role_priv_ra a
   where a.priv_id in
         (select priv_id
            from sys_app_privilege t
           where t.pause = 0
           start with t.priv_id = :new.parent_priv_id
          connect by prior  t.parent_priv_id = t.priv_id);

end trg_af_i_sys_app_privilege;
/

