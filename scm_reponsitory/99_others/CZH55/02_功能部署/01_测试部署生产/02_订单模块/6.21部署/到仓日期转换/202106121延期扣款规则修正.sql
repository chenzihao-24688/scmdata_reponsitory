begin
update bw3.sys_item_list a set a.select_sql='select a.deduction_config_id,
       a.pause,
       --  a.deduction_config_code,
       a.DEDUCTION_NAME,
       a.deduction_change_time,
        cua.company_user_name CREATOR,
       a.create_time,
       cub.company_user_name   UPDATOR,
       a.update_time
  from scmdata.t_deduction_config a
 inner join sys_company_user cua
    on a.create_id = cua.user_id
   and a.company_id = cua.company_id
 inner join sys_company_user cub
    on a.update_id = cub.user_id
   and a.company_id = cub.company_id
 where a.company_id = %default_company_id%
 order by a.create_time desc',a.insert_sql='declare
  p_id varchar2(32);
  p_i  int;
begin
  p_id := f_get_uuid();
  insert into t_deduction_config
    (deduction_config_id,
     company_id,
     DEDUCTION_NAME,
     pause,
     create_id,
     create_time,
     update_id,
     update_time,
     memo,
     deduction_config_code,deduction_change_time)
  values
    (p_id,
     %default_company_id%,
     :DEDUCTION_NAME,
     0,
     :user_id,
     sysdate,
     :user_id,
     sysdate,
     null,
     pkg_plat_comm.f_getkeyid_number(pi_table_name  => ''t_deduction_config'',
                                     pi_column_name => ''deduction_config_code'',
                                     pi_company_id  => %default_company_id%),deduction_change_time);

  scmdata.pkg_a_config_lib.p_check_model_name_repeat_deduction(pi_company_id => %default_company_id%,
                                                              pi_config_id  => p_id,
                                                              pi_model_name => :deduction_name);
end;',a.update_sql='declare
begin
update t_deduction_config a
   set a.DEDUCTION_NAME = :DEDUCTION_NAME,
       a.update_id     = :user_id,
       a.update_time   = sysdate,
       a.deduction_change_time=:deduction_change_time
 where a.deduction_config_id = :deduction_config_id;
 
  scmdata.pkg_a_config_lib.p_check_model_name_repeat_deduction(pi_company_id => %default_company_id%,
                                                              pi_config_id  => :deduction_config_id,
                                                              pi_model_name => :deduction_name);
                                                              end;' where a.item_id='a_config_123';
end;
/
alter table scmdata.t_deduction_config add deduction_change_time DATE;
/
