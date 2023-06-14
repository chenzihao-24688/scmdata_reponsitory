create or replace package scmdata.pkg_check_data_soialcode is

  function f_check_soialnum(c_num varchar2) return number;

  function f_check_soialcode(c_sc varchar2) return number;

end pkg_check_data_soialcode;
/

create or replace package body scmdata.pkg_check_data_soialcode is

  function f_check_soialnum(c_num varchar2) return number
  is
   begin
    if length(c_num)<>lengthb(c_num) then
      return 1;
    else
      return 0;
    end if;
  end f_check_soialnum;

  function f_check_soialcode(c_sc varchar2) return number 
  is
  begin
    if regexp_like(c_sc, '^[a-zA-Z0-9]{18}$') then
      return 1;
    else
      return 0;
    end if;
  end f_check_soialcode;

end pkg_check_data_soialcode;
/

