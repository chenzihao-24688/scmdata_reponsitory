--获取用户对象
SELECT u.object_name,
       u.object_id,
       u.object_type,
       u.created,
       u.last_ddl_time,
       u.timestamp,
       u.status,
       dbms_metadata.get_ddl(u.object_type, u.object_name)
  FROM user_objects u
 WHERE u.object_type IN ('PACKAGE', 'PROCEDURE', 'FUNCTION', 'TRIGGER');
