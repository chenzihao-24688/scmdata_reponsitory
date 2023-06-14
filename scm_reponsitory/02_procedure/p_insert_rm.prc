create or replace procedure scmdata.P_INSERT_RM
IS
  p_date_1      date;
  p_date_2      date;
  p_num         varchar2(32);
  p_goo_id      varchar2(32);
  p_rela_goo_id varchar2(32);
  p_sup_id      varchar2(32);
  p_com_id      varchar2(32);
  p_rm_type     VARCHAR2(10);
begin 
  select FLOOR(DBMS_RANDOM.VALUE(1, 100000000000)) into p_num from dual;
  select goo_id into p_goo_id
    from (select * from t_commodity_info order by dbms_random.value) where rownum <=1;
    SELECT rela_goo_id INTO p_rela_goo_id FROM t_commodity_info WHERE goo_id = p_goo_id;
  select to_date('20200101','yyyymmdd hh24:mi:ss')+trunc(dbms_random.value(0,365)) into p_date_1 from dual;
  select inside_supplier_code into p_sup_id from (select * from t_supplier_info 
                                                   where company_id ='a972dd1ffe3b3a10e0533c281cac8fd7'
                             AND inside_supplier_code IS NOT NULL) where rownum <=1;
  select to_date('20200101','yyyymmdd')+trunc(dbms_random.value(0,365)) into p_date_2 from dual;
  SELECT rm_type INTO p_rm_type FROM (SELECT * FROM (select '零星' AS rm_type from dual
                                                     UNION ALL
                                                     SELECT '批量' AS rm_type FROM dual) 
                                      order by dbms_random.value) where rownum <=1;                           
  p_com_id := 'a972dd1ffe3b3a10e0533c281cac8fd7';
 BEGIN
   if to_number(to_char(p_date_2,'yyyymmdd'))-to_number(to_char(p_date_1,'yyyymmdd')) >=1 then
     insert into cmx_return_management_int (exg_id,company_id,sho_id,
            sup_id,create_time,finish_time,goo_id)
     values( 'YWTX'||p_num,p_com_id,'YWT',p_sup_id,p_date_1,p_date_2,p_goo_id);
   end if;
COMMIT;
 END;
end;
/

