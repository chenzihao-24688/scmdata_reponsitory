DECLARE
  p_version_num   NUMBER := 10;
  p_user_space    VARCHAR2(32) := 'MRP';
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
                    FROM user_objects u
                   WHERE u.object_type IN
                         ('PACKAGE BODY', 'PROCEDURE', 'FUNCTION', 'TRIGGER')) LOOP
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
      scmdata.pkg_version_ctl.p_insert_user_objs_bak(p_obj_rec => p_obj_rec);
    END IF;
  
  END LOOP;
END;
