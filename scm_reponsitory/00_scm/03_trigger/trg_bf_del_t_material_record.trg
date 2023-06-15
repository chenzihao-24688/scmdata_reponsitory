CREATE OR REPLACE TRIGGER SCMDATA.trg_bf_del_t_material_record
  before delete on t_material_record
  for each row
declare
begin
  if pkg_material_record.f_can_delete_material_record(pi_material_record_id   => :OLD.MATERIAL_RECORD_ID,
                                                      pi_material_record_code => :OLD.MATERIAL_RECORD_CODE,
                                                      pi_company_id           => :OLD.Company_Id) = 1 then
    raise_application_error(-20002, '该物料存在物料明细，不能删除！');
  end if;
end trg_bf_del_t_material_record;
/

