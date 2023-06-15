create or replace trigger mrp.tfg_bf_iu_fabric_purchase_sheet
  before update or insert of fabric_status on mrp.t_fabric_purchase_sheet
  for each row

declare
  pragma autonomous_transaction;

begin

  if inserting then
    if :new.fabric_status is not null then
      mrp.pkg_color_prepare_order_manager.p_sync_prepare_status(p_order_num  => :new.purchase_order_num ,
                                                                p_company_id => :new.company_id);
    end if;
  elsif updating then
    if :old.fabric_status <> :new.fabric_status then
      mrp.pkg_color_prepare_order_manager.p_sync_prepare_status(p_order_num  => :old.purchase_order_num,
                                                                p_company_id => :old.company_id);
    end if;
  end if;
commit;
end;
/

