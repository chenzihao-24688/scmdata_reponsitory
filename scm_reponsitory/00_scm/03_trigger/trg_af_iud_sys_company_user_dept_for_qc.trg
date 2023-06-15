create or replace trigger scmdata.trg_af_iud_sys_company_user_dept_for_qc
  after insert or update or delete on sys_company_user_dept
  for each row
declare
  -- local variables here
  pragma autonomous_transaction;
  p_flag number(1);
begin
  if deleting then
    --如果之前的是qc
    select nvl(max(1), 0)
      into p_flag
      from scmdata.sys_company_dept cd
     where cd.company_dept_id = :old.company_dept_id
       and cd.company_id = :old.company_id
       and cd.dept_name like '%QC%';
    --去掉所有qc配置中的该用户
    if p_flag = 1 then
      scmdata.pkg_qcfactory_config.p_delete_qc_user(p_user_id    => :old.user_id,
                                                    p_company_id => :old.company_id);
    end if;
  elsif updating('company_dept_id') and
        :new.company_dept_id <> :old.company_dept_id then
    select nvl(max(1), 0)
      into p_flag
      from scmdata.sys_company_dept cd
     where cd.company_dept_id = :old.company_dept_id
       and cd.company_id = :old.company_id
       and cd.dept_name like '%QC%';
    if p_flag = 1 then
      scmdata.pkg_qcfactory_config.p_delete_qc_user(p_user_id    => :old.user_id,
                                                    p_company_id => :old.company_id);
      scmdata.pkg_qcfactory_msg.send_unconfig_qc_msg(p_company_id => :new.company_id);
    end if;
  elsif inserting then
    --如果进入的部门是qc部，通知存在用户未配置
    select nvl(max(1), 0)
      into p_flag
      from scmdata.sys_company_dept cd
     where cd.company_dept_id = :new.company_dept_id
       and cd.company_id = :new.company_id
       and cd.dept_name like '%QC%';
    --通知存在未配置qc
    if p_flag = 1 then
      scmdata.pkg_qcfactory_msg.send_unconfig_qc_msg(p_company_id => :new.company_id);
    end if;
  end if;
  commit;
exception
  when others then
    scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => :old.company_id,
                                                     p_user_id    => 'ZWH73',
                                                     p_content    => substr(SQLERRM,
                                                                            0,
                                                                            500) ||
                                                                     '...',
                                                     p_sender     => 'ADMIN');
end trg_af_iud_sys_company_user_dept_for_qc;
/

