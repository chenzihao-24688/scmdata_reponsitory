create or replace trigger mrp.tfg_bf_iu_pick_list
  before update or insert of pick_status  on mrp.pick_list
  for each row

declare
  pragma autonomous_transaction;
begin

  if inserting then
    if :new.pick_status is not null then
      mrp.pkg_color_prepare_order_manager.p_sync_prepare_status(p_order_num  => :new.relate_product_order_num,
                                                                p_company_id => :new.company_id);
    end if;
  elsif updating then
    if scmdata.pkg_plat_comm.f_is_check_fields_eq(p_old_field => :old.pick_status,
                                                  p_new_field => :new.pick_status) = 0 then

      mrp.pkg_color_prepare_order_manager.p_sync_prepare_status(p_order_num  => :old.relate_product_order_num,
                                                                p_company_id => :old.company_id);

    end if;
  end if;
  commit;
end;
/

