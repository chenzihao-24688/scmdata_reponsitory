--查锁
SELECT a.*, c.type, c.lmode
  FROM v$locked_object a, all_objects b, v$lock c
 WHERE a.object_id = b.object_id
   AND a.session_id = c.sid
   AND b.object_name = 'SCMDATA';

--查看session之间的阻塞关系
SELECT decode(request, 0, 'Holder: ', 'Waiter: ') || sid sess,
       id1,
       id2,
       lmode,
       request,
       TYPE
  FROM gv$lock
 WHERE (id1, id2, TYPE) IN (SELECT id1, id2, TYPE
                              FROM gv$lock
                             WHERE request > 0
                               AND TYPE != 'HW')
 ORDER BY id1, request;

--查看包引起的排它锁
SELECT session_id     sid,
       owner,
       NAME,
       TYPE,
       mode_held      held,
       mode_requested request
  FROM dba_ddl_locks
 WHERE NAME = upper('pkg_production_progress');

SELECT DISTINCT b.sid, b.serial#
  FROM dba_ddl_locks a, v$session b
 WHERE a.session_id = b.sid
   AND a.name = upper('pkg_production_progress');

--1.查看被锁表信息
SELECT sess.sid,
       sess.serial#,
       lo.oracle_username,
       lo.os_user_name,
       ao.object_name,
       lo.locked_mode
  FROM v$locked_object lo, dba_objects ao, v$session sess
 WHERE ao.object_id = lo.object_id
   AND lo.session_id = sess.sid;

--2.查看数据库引起锁表的SQL语句 
SELECT a.username,
       a.machine,
       a.program,
       a.sid,
       a.serial#,
       a.status,
       c.piece,
       c.sql_text
  FROM v$session a, v$sqltext c
 WHERE a.sid IN (SELECT DISTINCT t2.sid
                   FROM v$locked_object t1, v$session t2
                  WHERE t1.session_id = t2.sid)
   AND a.sql_address = c.address(+)
 ORDER BY c.piece;

--3.杀死锁表进程
--'68,51'分别为SID和SERIAL#号
--alter system kill session '289,55488';

ALTER system kill session '289,55488';
ALTER system kill session '51,52126';
ALTER system kill session '278,4943';
ALTER system kill session '271,38565';
ALTER system kill session '266,52341';
ALTER system kill session '54,18687';
ALTER system kill session '255,21527';


DECLARE
  v_sql CLOB;
BEGIN
  v_sql := q'[ALTER system kill session ']';
  FOR i IN (SELECT DISTINCT b.sid sid, b.serial# serial
              FROM dba_ddl_locks a, v$session b
             WHERE a.session_id = b.sid
               AND a.name = upper('pkg_production_progress')) LOOP
    EXECUTE IMMEDIATE v_sql || i.sid || ',' || i.serial || q'[']';
  END LOOP;
END;

