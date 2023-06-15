create or replace trigger scmdata.trg_af_iud_sys_company_user_for_qc
  after insert or update or delete on sys_company_user
  for each row
declare
  -- local variables here
  pragma autonomous_transaction;
  p_flag number(1);
begin
  /*if inserting then 
    --
    null;
  end if;*/
  if deleting or (updating('pause') and :new.pause = 1 and :old.pause = 0) then
    scmdata.pkg_qcfactory_config.p_delete_qc_user(p_user_id    => :old.user_id,
                                                  p_company_id => :old.company_id);
  elsif updating('pause') and :new.pause = 0 and :old.pause = 1 then
    select nvl(max(1), 0)
      into p_flag
      from scmdata.sys_company_user_dept cud
     inner join scmdata.sys_company_dept cd
        on cd.company_dept_id = cud.company_dept_id
     where cud.user_id = :new.user_id
       and cud.company_id = :new.company_id
       and cd.dept_name like '%QC%';
    --通知存在未配置qc
    if p_flag = 1 then
      scmdata.pkg_qcfactory_msg.send_unconfig_qc_msg(p_company_id => :new.company_id);
    end if;
  elsif updating('company_user_name') and :new.pause = 0 then
    select nvl(max(1), 0)
      into p_flag
      from scmdata.sys_company_user_dept cud
     inner join scmdata.sys_company_dept cd
        on cd.company_dept_id = cud.company_dept_id
     where cud.company_id = :new.company_id
       and cud.user_id = :new.user_id
       and cd.dept_name like '%QC%';
    if p_flag = 1 then
      update scmdata.t_qc_factory_config_category a
         set a.qc_user_name = trim(';' from
                                   replace(';' || a.qc_user_name || ';',
                                           ';' || :old.company_user_name || ';',
                                           ';' || :new.company_user_name || ';'))
      
       where a.qc_user_id like '%' || :new.user_id || '%';
    
      update scmdata.t_qc_factory_config_detail a
         set a.qc_user_name = trim(';' from
                                   replace(';' || a.qc_user_name || ';',
                                           ';' || :old.company_user_name || ';',
                                           ';' || :new.company_user_name || ';'))
       where a.qc_user_id like '%' || :new.user_id || '%';
    
      update scmdata.t_qc_factory_config_head a
         set a.qc_user_name = trim(';' from
                                   replace(';' || a.qc_user_name || ';',
                                           ';' || :old.company_user_name || ';',
                                           ';' || :new.company_user_name || ';'))
       where a.qc_user_id like '%' || :new.user_id || '%';
    end if;
  end if;
  commit;
end trg_af_iud_sys_company_user_for_qc;
/

