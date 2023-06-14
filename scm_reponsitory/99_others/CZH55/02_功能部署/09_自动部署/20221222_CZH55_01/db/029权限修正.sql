begin
  delete from bw3.sys_cond_rela a where a.cond_id='cond_action_a_config_size_01_auto';
  delete from bw3.sys_cond_list a where a.cond_id='cond_action_a_config_size_01_auto';
end;
/
begin
update scmdata.sys_app_privilege a set a.cond_id=null,a.ctl_id='action_a_config_size_02' where a.priv_id='P0081005';
end;
/
