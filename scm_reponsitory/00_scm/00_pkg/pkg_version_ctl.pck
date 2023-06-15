CREATE OR REPLACE PACKAGE SCMDATA.pkg_version_ctl IS

  -- Author  : SANFU
  -- Created : 2021/11/18 17:00:13
  -- Purpose : 版本控制 

  PROCEDURE p_bak_table(p_owner   VARCHAR2 DEFAULT 'SCMDATA',
                        p_org_tab VARCHAR2,
                        p_split   CHAR DEFAULT ';',
                        p_user_id VARCHAR2);

  --获取当前用户对象的ddl语句
  --INDEX,JOB,TABLE PARTITION,TRIGGER,PACKAGE,PROCEDURE,TABLE SUBPARTITION,FUNCTION,LOB,SEQUENCE,TYPE,TABLE
  FUNCTION f_get_user_objs(p_obj_type VARCHAR2 DEFAULT q'['PACKAGE','PROCEDURE','FUNCTION','TRIGGER']')
    RETURN VARCHAR2;

  PROCEDURE p_insert_user_objs_bak(p_obj_rec scmdata.t_user_objs_bak%ROWTYPE);

  --备份当前用户ddl对象
  PROCEDURE p_backup_user_objs(p_version_num NUMBER DEFAULT 10,
                               p_user_space  VARCHAR2 DEFAULT 'SCMDATA');

END pkg_version_ctl;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_version_ctl IS

  --1.备份表  
  PROCEDURE p_bak_table(p_owner   VARCHAR2 DEFAULT 'SCMDATA',
                        p_org_tab VARCHAR2,
                        p_split   CHAR DEFAULT ';',
                        p_user_id VARCHAR2) IS
    v_owner   VARCHAR2(32) := upper(p_owner);
    v_org_tab VARCHAR2(4000) := upper(p_org_tab);
    --v_bak_tab  VARCHAR2(4000); --默认v_org_tab||'_bak'
    v_split    CHAR(1) := p_split;
    v_user_id  VARCHAR2(32) := upper(p_user_id); --工号
    v_flag     NUMBER;
    v_tab_comm VARCHAR2(4000);
  BEGIN
    --记录至备份表
    FOR str_rec IN (SELECT regexp_substr(v_org_tab,
                                         '[^' || v_split || ']+',
                                         1,
                                         LEVEL,
                                         'i') AS org_tab
                      FROM dual
                    CONNECT BY LEVEL <=
                               length(v_org_tab) -
                               length(regexp_replace(v_org_tab, v_split, '')) + 1) LOOP
      INSERT INTO scmdata.t_table_bakup
      VALUES
        (scmdata.f_get_uuid(), v_owner, str_rec.org_tab,
         str_rec.org_tab || '_BAK', v_user_id, SYSDATE, 'P');
    END LOOP;
    --动态sql 生成备份表
    FOR p_tab_rec IN (SELECT t.bak_id, t.owner, t.org_tab, t.bak_tab
                        FROM scmdata.t_table_bakup t
                       WHERE t.owner = v_owner
                         AND t.create_id = v_user_id
                         AND t.status IN ('P', 'F')) LOOP
      --判断是否存在表   
      SELECT COUNT(1)
        INTO v_flag
        FROM all_tab_comments t
       WHERE t.owner = p_tab_rec.owner
         AND t.table_name = p_tab_rec.org_tab;
    
      IF v_flag > 0 THEN
      
        EXECUTE IMMEDIATE 'CREATE TABLE ' || v_owner || '.' ||
                          p_tab_rec.bak_tab || ' AS
        SELECT * FROM ' || v_owner || '.' ||
                          p_tab_rec.org_tab || '';
      
        SELECT t.comments
          INTO v_tab_comm
          FROM all_tab_comments t
         WHERE t.owner = p_tab_rec.owner
           AND t.table_name = p_tab_rec.org_tab;
        -- Add comments to the table 
        IF v_tab_comm IS NOT NULL THEN
          EXECUTE IMMEDIATE 'COMMENT ON TABLE ' || v_owner || '.' ||
                            p_tab_rec.bak_tab || ' IS ''' || v_tab_comm || '''';
        END IF;
        -- Add comments to the columns 
        FOR p_col_comm_rec IN (SELECT t.owner,
                                      t.table_name,
                                      t.column_name,
                                      t.comments
                                 FROM all_col_comments t
                                WHERE t.owner = p_tab_rec.owner
                                  AND t.table_name = p_tab_rec.org_tab) LOOP
        
          EXECUTE IMMEDIATE 'COMMENT ON column ' || v_owner || '.' ||
                            p_tab_rec.bak_tab || '.' ||
                            p_col_comm_rec.column_name || ' IS ''' ||
                            p_col_comm_rec.comments || '''';
        
        END LOOP;
        UPDATE scmdata.t_table_bakup t
           SET t.status = 'S'
         WHERE t.bak_id = p_tab_rec.bak_id;
      ELSE
        UPDATE scmdata.t_table_bakup t
           SET t.status = 'F'
         WHERE t.bak_id = p_tab_rec.bak_id;
      END IF;
    END LOOP;
  END p_bak_table;

  --获取当前用户对象的ddl语句
  --INDEX,JOB,TABLE PARTITION,TRIGGER,PACKAGE,PROCEDURE,TABLE SUBPARTITION,FUNCTION,LOB,SEQUENCE,TYPE,TABLE
  FUNCTION f_get_user_objs(p_obj_type VARCHAR2 DEFAULT q'['PACKAGE','PROCEDURE','FUNCTION','TRIGGER']')
    RETURN VARCHAR2 IS
  BEGIN
    RETURN q'[SELECT u.object_name,
           u.object_id,
           u.object_type,
           u.created,
           u.last_ddl_time,
           u.timestamp,
           u.status,
           dbms_metadata.get_ddl(u.object_type, u.object_name)
      FROM all_objects u
     WHERE u.object_type IN (]' || p_obj_type || ')';
  END f_get_user_objs;

  PROCEDURE p_insert_user_objs_bak(p_obj_rec scmdata.t_user_objs_bak%ROWTYPE) IS
  BEGIN
    INSERT INTO t_user_objs_bak
      (obj_bak_id, obj_id, object_name, object_type, ddl_sql, create_time,
       last_ddl_time, TIMESTAMP, status, user_space, version_num, memo)
    VALUES
      (p_obj_rec.obj_bak_id, p_obj_rec.obj_id, p_obj_rec.object_name,
       p_obj_rec.object_type, p_obj_rec.ddl_sql, p_obj_rec.create_time,
       p_obj_rec.last_ddl_time, p_obj_rec.timestamp, p_obj_rec.status,
       p_obj_rec.user_space, p_obj_rec.version_num, p_obj_rec.memo);
  END p_insert_user_objs_bak;

  --备份当前用户ddl对象  
  PROCEDURE p_backup_user_objs(p_version_num NUMBER DEFAULT 10,
                               p_user_space  VARCHAR2 DEFAULT 'SCMDATA') IS
    v_sql           CLOB;
    p_obj_rec       scmdata.t_user_objs_bak%ROWTYPE;
    v_version_num   NUMBER;
    v_last_ddl_time DATE;
  BEGIN
    --获取数据库对象
    FOR obj_rec IN (SELECT u.object_name,
                           u.object_id,
                           u.object_type,
                           u.created,
                           u.last_ddl_time,
                           u.timestamp,
                           u.status
                      FROM all_objects u
                     WHERE u.object_type IN ('PACKAGE BODY',
                                             'PROCEDURE',
                                             'FUNCTION',
                                             'TRIGGER')) LOOP
      SELECT nvl(MAX(t.version_num), 0) + 1, MAX(t.last_ddl_time)
        INTO v_version_num, v_last_ddl_time
        FROM scmdata.t_user_objs_bak t
       WHERE t.obj_id = obj_rec.object_id;
      --判断对象是否有更新
      IF obj_rec.last_ddl_time = v_last_ddl_time THEN
        NULL;
      ELSE
        --每个对象最多保留10个版本
        IF v_version_num > p_version_num THEN
          UPDATE scmdata.t_user_objs_bak t
             SET t.version_num = t.version_num - 1
           WHERE t.obj_id = obj_rec.object_id;
        
          DELETE FROM scmdata.t_user_objs_bak t
           WHERE t.obj_id = obj_rec.object_id
             AND t.version_num = 0;
        
        END IF;
        --新增版本
        v_sql := dbms_metadata.get_ddl(CASE
                                         WHEN obj_rec.object_type = 'PACKAGE BODY' THEN
                                          'PACKAGE'
                                         ELSE
                                          obj_rec.object_type
                                       END,
                                       obj_rec.object_name);
        p_obj_rec.obj_bak_id    := scmdata.f_get_uuid();
        p_obj_rec.obj_id        := obj_rec.object_id;
        p_obj_rec.object_name   := obj_rec.object_name;
        p_obj_rec.object_type := CASE
                                   WHEN obj_rec.object_type = 'PACKAGE BODY' THEN
                                    'PACKAGE'
                                   ELSE
                                    obj_rec.object_type
                                 END;
        p_obj_rec.ddl_sql       := v_sql;
        p_obj_rec.create_time   := obj_rec.created;
        p_obj_rec.last_ddl_time := obj_rec.last_ddl_time;
        p_obj_rec.timestamp     := obj_rec.timestamp;
        p_obj_rec.status        := obj_rec.status;
        p_obj_rec.user_space    := p_user_space;
        p_obj_rec.version_num := CASE
                                   WHEN v_version_num > p_version_num THEN
                                    p_version_num
                                   ELSE
                                    v_version_num
                                 END;
        p_obj_rec.memo          := '';
        p_insert_user_objs_bak(p_obj_rec => p_obj_rec);
      END IF;
    
    END LOOP;
  END p_backup_user_objs;

END pkg_version_ctl;
/

