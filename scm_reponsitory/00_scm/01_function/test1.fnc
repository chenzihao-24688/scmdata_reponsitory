create or replace function scmdata.test1 return varchar2 is
  num1 varchar2(1000);
  num2 varchar2(1000);
  num3 varchar2(1000);
  num4 varchar2(1000);
  V_C  varchar2(18) := 'null2';
begin
  select t.company_id
    into num1
    from scmdata.pt_ordered t
   where t.company_id = '1121414';
  dbms_output.put_line(num1);
  select 1 into num2 from dual;
  dbms_output.put_line(num2);
  select 1 into num3 from dual where 1 = 2;
  dbms_output.put_line(num3);
exception
  when no_data_found then
    return V_C;
end;
/

