create or replace trigger scmdata.trg_bf_del_t_material_record_item
  before delete
  on t_material_record_item 
  for each row
declare
begin
  if pkg_material_record.f_can_delete_material_record_item(pi_material_record_item_code => :OLD.Material_Record_Item_Code, pi_company_id =>:OLD.Company_Id )=1 then 
    raise_application_error(-20002,'该物料明细已被引用，不能删除！');
  end if;
end trg_bf_del_t_material_record_item;
/

