SELECT rowid,t.*
  FROM scmdata.sys_app_privilege t
 START WITH t.priv_id IN ('P00302')
CONNECT BY PRIOR t.priv_id = t.parent_priv_id;
/
DECLARE
  v_sql CLOB;
BEGIN
  FOR i IN (SELECT t.cond_id
                      FROM scmdata.sys_app_privilege t
                     START WITH t.priv_id IN ('P0030209')
                    CONNECT BY PRIOR t.priv_id = t.parent_priv_id) LOOP
                    
    v_sql := v_sql || q'[SELECT rowid,t.* FROM bw3.sys_cond_list t
                         WHERE t.cond_id= ']' ||
             i.cond_id || q'[' union all ]';
             
  END LOOP;
  dbms_output.put_line(v_sql);
END;
/

DECLARE
  v_sql CLOB;
BEGIN
  FOR i IN (SELECT t.cond_id
                      FROM scmdata.sys_app_privilege t
                     START WITH t.priv_id IN ('P0030209')
                    CONNECT BY PRIOR t.priv_id = t.parent_priv_id) LOOP
                    
    v_sql := v_sql || q'[SELECT rowid,t.* FROM bw3.sys_cond_rela t
                         WHERE t.cond_id= ']' ||
             i.cond_id || q'[' union all ]';
             
  END LOOP;
  dbms_output.put_line(v_sql);
END;
/
SELECT t.*,v.priv_id,t.rowid
  FROM bw3.sys_cond_list t
 INNER JOIN (SELECT t.cond_id, t.priv_id
               FROM scmdata.sys_app_privilege t
              START WITH t.priv_id IN ('P003020903'/*,'P003020905'*/)
             CONNECT BY PRIOR t.priv_id = t.parent_priv_id) v
    ON  v.cond_id = t.cond_id;
