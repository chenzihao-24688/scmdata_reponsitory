create or replace trigger scmdata.trg_af_finish_t_ordered_for_qc
  after update of finish_time_scm on t_ordered
  for each row
declare
  -- local variables here
  pragma autonomous_transaction;
  p_factory_code varchar2(32);
begin
  if :new.finish_time_scm is not null and :old.finish_time_scm is null then
    select max(os.factory_code)
      into p_factory_code
      from scmdata.t_orders os
     inner join scmdata.t_supplier_info si
        on si.supplier_code = os.factory_code
       and si.company_id = os.company_id
     where os.order_id = :new.order_code
       and os.company_id = :new.company_id
       and si.pause = 1;
    if p_factory_code is not null then
      scmdata.pkg_qcfactory_config.p_status_qc_factory_config_by_factory(p_factory_code => p_factory_code,
                                                                         p_company_id   => :new.company_id,
                                                                         p_status       => 1);
    end if;
  end if;
  commit;
  exception
    when others then
      scmdata.pkg_send_wx_msg.p_send_com_person_wx_msg(p_company_id => :old.company_id ,
                                                       p_user_id    => 'ZWH73',
                                                       p_content    => substr(SQLERRM,0,500)||'...',
                                                       p_sender     => 'ADMIN');
end t_af_finish_t_ordered_for_qc;
/

