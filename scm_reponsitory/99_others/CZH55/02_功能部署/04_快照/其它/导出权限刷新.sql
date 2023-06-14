--导出权限报错时处理
BEGIN
UPDATE scmdata.sys_app_privilege a
   SET a.cond_id = NULL
 WHERE a.cond_id IS NOT NULL
   AND a.cond_id LIKE '%cond_9_auto%';
   
DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%cond_9_auto%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%cond_9_auto%';
END;
/
DECLARE
  v_i INT;
BEGIN
  v_i := 0;
  FOR item IN (SELECT t.priv_id
                 FROM scmdata.sys_app_privilege t
                WHERE t.ctl_id = '9' and t.pause = 0) LOOP
    BEGIN
      pkg_company_manage.p_privilege_cond(item.priv_id);
      v_i := v_i + 1;
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('''' || item.priv_id || ''',');
        --raise_application_error(-20002, v_i || item.priv_id);
    END;
  END LOOP;
END;
/
