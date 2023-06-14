DECLARE
  v_i INT;
BEGIN
  v_i := 0;
  FOR item IN (SELECT priv_id
                 FROM sys_app_privilege a
                WHERE a.cond_id IS NULL
                ORDER BY priv_id) LOOP
    BEGIN
      pkg_company_manage.p_privilege_cond(item.priv_id);
      v_i := v_i + 1;
    EXCEPTION
      WHEN OTHERS THEN
        raise_application_error(-20002, v_i || item.priv_id);
    END;
  END LOOP;
END;

--刷新权限
DECLARE
  v_i INT;
BEGIN
  v_i := 0;
  FOR item IN (SELECT t.priv_id
                 FROM scmdata.sys_app_privilege t
                START WITH t.priv_id IN ('P0091008') --IN ('P00901'/*'P00907', 'P00908', 'P00909', 'P00910'*/)
               CONNECT BY PRIOR t.priv_id = t.parent_priv_id) LOOP
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

SELECT *
  FROM scmdata.sys_app_privilege a
 WHERE a.create_time > SYSDATE - 1;
SELECT ROWID, t.*
  FROM nbw.sys_cond_list t
 WHERE t.cond_id IN (SELECT a.cond_id
                       FROM scmdata.sys_app_privilege a
                      WHERE a.create_time > SYSDATE - 1);
SELECT ROWID, t.*
  FROM nbw.sys_cond_rela t
 WHERE t.cond_id IN (SELECT a.cond_id
                       FROM scmdata.sys_app_privilege a
                      WHERE a.create_time > SYSDATE - 1);

UPDATE scmdata.sys_app_privilege t
   SET t.cond_id = NULL, t.pause = 1
 WHERE t.priv_id IN ('P0090111');
SELECT ROWID, t.*
  FROM bw3.sys_cond_list t
 WHERE t.cond_id LIKE '%cond_action_a_product_110_4_auto%';
SELECT ROWID, t.*
  FROM bw3.sys_cond_rela t
 WHERE t.cond_id LIKE '%cond_action_a_product_110_4_auto%';

--迁移应用权限时处理，先备份原应用权限，且sys_app_privilege表字段cond_id置空,同时删除相应cond_id关联的sys_cond_list,sys_cond_rela
BEGIN
  DELETE FROM bw3.sys_cond_rela t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P00907', 'P00908', 'P00909', 'P00910') --IN ('P00901'/*'P00907', 'P00908', 'P00909', 'P00910'*/)
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  DELETE FROM bw3.sys_cond_list t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P00907', 'P00908', 'P00909', 'P00910') --IN ('P00901'/*'P00907', 'P00908', 'P00909', 'P00910'*/)
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  UPDATE scmdata.sys_app_privilege t
     SET t.cond_id = NULL
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN ('P00907', 'P00908', 'P00909', 'P00910') --IN ('P00901'/*'P00907', 'P00908', 'P00909', 'P00910'*/)
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);
END;

BEGIN
  DELETE FROM bw3.sys_cond_rela t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN
                      ('P00901' /*'P00907', 'P00908', 'P00909', 'P00910'*/)
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  DELETE FROM bw3.sys_cond_list t
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN
                      ('P00901' /*'P00907', 'P00908', 'P00909', 'P00910'*/)
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);

  UPDATE scmdata.sys_app_privilege t
     SET t.cond_id = NULL
   WHERE t.cond_id IN
         (SELECT t.cond_id
            FROM scmdata.sys_app_privilege t
           START WITH t.priv_id IN
                      ('P00901' /*'P00907', 'P00908', 'P00909', 'P00910'*/)
          CONNECT BY PRIOR t.priv_id = t.parent_priv_id);
END;

--导出权限报错时处理
UPDATE scmdata.sys_app_privilege a
   SET a.cond_id = NULL
 WHERE a.cond_id IS NOT NULL
   AND a.cond_id LIKE '%cond_9_auto%';

DELETE FROM bw3.sys_cond_rela a WHERE a.cond_id LIKE '%cond_9_auto%';
DELETE FROM bw3.sys_cond_list a WHERE a.cond_id LIKE '%cond_9_auto%';

DECLARE
  v_i INT;
BEGIN
  v_i := 0;
  FOR item IN (SELECT t.priv_id
                 FROM scmdata.sys_app_privilege t
                WHERE t.ctl_id = '9'
                  AND t.pause = 0) LOOP
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

--查找关联
DECLARE
  v_sql CLOB;
BEGIN
  FOR i IN (SELECT t.priv_id
              FROM scmdata.sys_app_privilege t
             WHERE t.priv_id IN ('P009010102',
                                 'P009010103',
                                 'P009010104',
                                 'P009010105',
                                 'P009010402',
                                 'P009010501',
                                 'P00907011',
                                 'P0090701101',
                                 'P0091011',
                                 'P009101101')) LOOP
    v_sql := v_sql || q'[SELECT t.cond_id FROM bw3.sys_cond_list t
                         WHERE t.cond_sql LIKE '%]' ||
             i.priv_id || q'[%' union all]';
  END LOOP;
  dbms_output.put_line(v_sql);
END;
