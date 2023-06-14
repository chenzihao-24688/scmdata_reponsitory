--µ÷Õû±í×Ö¶ÎË³Ðò
SELECT ROWID, obj#, col#, NAME
  FROM sys.col$
 WHERE obj# IN (SELECT object_id
                  FROM all_objects
                 WHERE owner = 'SCMDATA'
                   AND object_name = upper('t_supplier_info'))
 ORDER BY col#;

/*UPDATE sys.col$
   SET col# = 2
 WHERE obj# = '81080'
   AND NAME = '×Ö¶Î1';*/

DECLARE
  p_owner       VARCHAR2(32) := upper('SCMDATA');
  p_obj_name    VARCHAR2(32) := upper('t_supplier_info');
  vo_update_sql CLOB;
BEGIN
  FOR field_rec IN (SELECT ROWID, obj#, col#, NAME
                      FROM sys.col$
                     WHERE obj# IN (SELECT object_id
                                      FROM all_objects
                                     WHERE owner = p_owner
                                       AND object_name = p_obj_name)
                     ORDER BY col#) LOOP
  
    vo_update_sql := vo_update_sql || chr(13) ||
                     'UPDATE sys.col$ SET col# = ' || field_rec.col# ||
                     ' WHERE obj# = ''' || field_rec.obj# || ''' AND NAME = ''' ||
                     field_rec.name || ''';';
  END LOOP;
  dbms_output.put_line(vo_update_sql);
END;


