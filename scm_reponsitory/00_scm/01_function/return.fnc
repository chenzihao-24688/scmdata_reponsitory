create or replace function 
return number
is
  p_year  number(4) := to_char(sysdate,'yyyy');
  p_month number(2) := to_char(sysdate,'mm');
  p_halfyear number(1);
  p_yearmonth number(5);
begin
     if p_month in (01,02,03,04,05,06) then
       p_halfyear := 1;
     else
       p_halfyear := 2;
     end if ;
   p_yearmonth := p_year || p_halfyear;
   return p_yearmonth;
end;
/

