--批量生成应用权限
DECLARE
v_priv_id VARCHAR2(32) := pkg_plat_comm.f_getnewsys_app_priv_id(:parent_priv_id);
BEGIN
  v_cond_id  := 'cond_' || r_priv.ctl_id || '_auto';
  v_cond_sql := 'select pkg_plat_comm.f_hasaction_application(%CURRENT_USERID%,%DEFAULT_COMPANY_ID%,''' ||
                r_priv.priv_id || ''') as flag from dual ';

  INSERT INTO scmdata.sys_app_privilege
    (v_priv_id, priv_name, parent_priv_id, pause, obj_type, ctl_id, item_id, create_id, create_time, update_id, update_time, cond_id, apply_belong)
  VALUES
    (v_priv_id, priv_name, parent_priv_id, pause, obj_type, ctl_id, item_id, create_id, create_time, update_id, update_time, cond_id, apply_belong);

END;

