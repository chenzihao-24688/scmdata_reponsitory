create or replace trigger scmdata.trg_bf_i_t_fabric_evaluate
  before insert on t_fabric_evaluate
  for each row
declare
  --zwh73    2021年11月18日11:39:12
  pragma autonomous_transaction;
  p_i int;
begin
  select nvl(max(1), 0)
    into p_i
    from scmdata.t_fabric_evaluate a
   where a.company_id = :new.company_id
     and a.goo_id = :new.goo_id;
  if p_i = 1 then
    RAISE_APPLICATION_ERROR(-20002, '请勿频繁操作！');
  end if;
end trg_bf_i_t_fabric_evaluate;
/

