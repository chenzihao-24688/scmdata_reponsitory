CREATE OR REPLACE TRIGGER SCMDATA.TRGBFINT_COMPANY_APPLY_SEE
  before insert or update
  on SYS_COMPANY_APPLY_SEE
  for each row
declare
  -- local variables here
  v_i int;
begin

  if :new.apply_see_type <>'0' and :new.data_id is null then
    Raise_application_Error(-20004,'请设置对应的部门/人员');
  end if;

  SELECT MAX(1) into v_i from dual
   where exists(select 1 from sys_company_apply a
                 where a.company_id=:new.company_id
                   and a.apply_id=:new.apply_id
                   and :new.apply_see_type<>'0'
                   and a.visible_to_all=1
               );
  if v_i =1 then
    Raise_application_Error(-20004,'您已设置了全员可见，无法指定其它方式的可见性；若需要执行此操作，请先取消全员可见');
  end if;
end TRGBFINT_COMPANY_APPLY_SEE;
/

