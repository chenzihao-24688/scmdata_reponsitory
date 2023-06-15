create or replace function scmdata.f_check_soialnum(c_num varchar2) return number
  is
    VC_NUM varchar2(128);
  begin
    select c_num
    into VC_NUM
    from dual where asciistr(c_num) LIKE '%\%';
    if VC_NUM is not null then
      return 1;
    else
      return 0;
    end if;
  end f_check_soialnum;
/

