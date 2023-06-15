create or replace trigger scmdata.trg_bf_update_sys_company_person_wecom_msg
  before update or insert of apply_id on scmdata.sys_group_wecom_msg_pattern
  for each row
declare
  PRAGMA AUTONOMOUS_TRANSACTION;
begin
  if inserting then
    if :new.apply_id is not null then
      for i in (select sc.company_id
                  from scmdata.sys_company sc
                 where sc.pause = 0) loop
        insert into scmdata.sys_company_person_wecom_msg
          (sys_company_person_wecom_msg_id,
           company_id,
           sys_group_wecom_msg_pattern_id,
           create_id,
           create_time)
        values
          (scmdata.f_get_uuid(),
           i.company_id,
           :new.sys_group_wecom_msg_pattern_id,
           'ADMIN',
           sysdate);
       commit;
      end loop;
    end if;
  elsif updating then
    if :old.apply_id is null then
      if :new.apply_id is not null then
        for i in (select sc.company_id
                    from scmdata.sys_company sc
                   where sc.pause = 0) loop
          insert into scmdata.sys_company_person_wecom_msg
            (sys_company_person_wecom_msg_id,
             company_id,
             sys_group_wecom_msg_pattern_id,
             create_id,
             create_time)
          values
            (scmdata.f_get_uuid(),
             i.company_id,
             :old.sys_group_wecom_msg_pattern_id,
             'ADMIN',
             sysdate);
       commit;
        end loop;
      end if;
    end if;
  end if;
end trg_bf_update_sys_company_person_wecom_msg;
/

