--平台权限
select rowid, t.* from scmdata.SYS_GROUP_ROLE t;
select rowid, t.* from scmdata.SYS_GROUP_ROLE_SECURITY t;
select rowid, t.* from scmdata.SYS_GROUP_SECURITY t;
select rowid, t.* from scmdata.SYS_GROUP_USER_ROLE t;

--企业后台权限
select rowid, t.* from scmdata.sys_company_user_role t;

select rowid, t.* from scmdata.sys_company_role t;

select rowid, t.* from scmdata.sys_company_role_security t;

select rowid, t.* from scmdata.sys_company_security t;


select rowid, t.* from nbw.sys_cond_list t;

select rowid, t.* from nbw.sys_cond_rela t;

declare
  v_group_security_id   varchar2(100) := '5000';
  v_group_security_name varchar2(100) := '测试查看用户管理';
  v_cond_id             varchar2(100) := 'cond_node_g_501_test';
  v_cond_sql            varchar2(1000);
  v_data_source         varchar2(1000) := 'oracle_scmdata';
  v_obj_type            varchar2(1000) := '0';
  v_ctl_id              varchar2(1000) := 'node_g_501';
  v_ctl_type            varchar2(1000) := '0'; --node_g_501
begin
  v_cond_sql := q'[select max(1) flag from dual where SCMDATA.pkg_plat_comm.F_UserHasAction(%user_id%,%default_company_id% ,']'||v_group_security_id || q'[','G')=1]';

  dbms_output.put_line(v_cond_sql);

  if v_group_security_id is null then
    raise_application_error(-20002, '请输入角色权限编号');
  else
    --权限表
    insert into varchar2(32) 
      (group_security_id,
       sort,
       group_security_name,
       code,
       i18n_key,
       tips,
       security_type)
    values
      (v_group_security_id, 1, v_group_security_name, ' ', ' ', ' ', ' ');
    --条件控制列表
    insert into nbw.SYS_COND_LIST
      (cond_id, cond_sql, data_source)
    values
      (v_cond_id, v_cond_sql, v_data_source);
    --条件控制关系表
    insert into nbw.sys_cond_rela
      (cond_id, obj_type, ctl_id, ctl_type, pause)
    values
      (v_cond_id, v_obj_type, v_ctl_id, v_ctl_type, 0);
  
  end if;
end;





