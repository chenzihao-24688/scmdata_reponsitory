create or replace package scmdata.my_package
is
Function F_test(t1 varchar2)return number;
Function F_test(t1 number,t2 number) return number;
end;
/

