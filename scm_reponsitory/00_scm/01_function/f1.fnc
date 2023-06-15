create or replace function scmdata.f1 return number is
  v1_year    number(4);
  v2_quarter number(1);
  year_quarter number(5);
begin
  select extract(year from sysdate) into v1_year from dual;
  select to_char(sysdate, 'Q') into v2_quarter from dual;
  year_quarter := v1_year || v2_quarter;
   dbms_output.put_line(year_quarter);
  return year_quarter;
end f1;
/

