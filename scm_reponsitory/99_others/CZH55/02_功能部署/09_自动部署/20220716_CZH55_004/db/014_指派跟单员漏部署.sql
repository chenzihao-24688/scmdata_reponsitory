DECLARE
v_sql CLOB;
BEGIN
  v_sql := q'[
DECLARE
  v_flw_order     VARCHAR2(4000);
  v_reason        VARCHAR2(256);
  v_gendan_name_n VARCHAR2(256);
  v_old_gendan    VARCHAR2(4000);
  vo_log_id       VARCHAR2(32);
BEGIN
  --跟单员
  v_flw_order := @flw_order@;

  --变更后
  SELECT listagg(nvl(fc.nick_name, fc.company_user_name), ',') gendan_name_n
    INTO v_gendan_name_n
    FROM scmdata.sys_company_user fc
   WHERE fc.company_id = %default_company_id%
     AND instr(@flw_order@, fc.user_id) > 0;

  FOR i IN (SELECT t.supplier_info_id, t.gendan_perid
              FROM scmdata.t_supplier_info t
             WHERE t.supplier_info_id IN (%selection%)
               AND t.company_id = %default_company_id%) LOOP

    --变更前的跟单
    v_old_gendan := scmdata.pkg_plat_comm.f_get_username(p_user_id         => i.gendan_perid,
                                                         p_company_id      => %default_company_id%,
                                                         p_is_company_user => 1,
                                                         p_is_mutival      => 1);

    --更新进表
    UPDATE scmdata.t_supplier_info t
       SET t.gendan_perid = v_flw_order,
           t.update_id    = :user_id,
           t.update_date  = sysdate
     WHERE t.supplier_info_id = i.supplier_info_id;

  END LOOP;
END;]';
UPDATE bw3.sys_action t SET t.action_sql = v_sql WHERE t.element_id = 'action_a_supp_160_5';
END;
/
