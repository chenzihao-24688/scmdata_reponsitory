create or replace function scmdata.F_CHECK_HX_TEST(v_sql1 in varchar2) return number is
  type cur_test_type is ref cursor;
  cur_test_info cur_test_type;
  v_seq_no number(10);
  v_cr_amount number(10);
  v_dr_amount number(10);
  v_begin_date date;
  v_end_date date;
  v_i int;
begin
  open cur_test_info for v_sql1;
  loop
  fetch cur_test_info into v_cr_amount,v_dr_amount,v_begin_date,v_end_date,v_seq_no;
  select max(1)
    into v_i
    from dual
   where exists(
                  select *
                    from hx_test_condlist a
                   where a.seq_no<v_seq_no and (a.begin_date>=v_begin_date or a.end_date>=v_end_date)
               );
   if v_i =1 then
     return 2;
   end if;


   select max(1)
    into v_i
    from dual
   where exists(
                  select *
                    from hx_test_condlist a
                   where a.seq_no>v_seq_no and (a.begin_date<=v_begin_date or a.end_date<=v_end_date)
               );
   if v_i =1 then
     return 3;
   end if;

  exit when  cur_test_info%NotFound;
  end loop;
  return 1;
end F_CHECK_HX_TEST;
/

