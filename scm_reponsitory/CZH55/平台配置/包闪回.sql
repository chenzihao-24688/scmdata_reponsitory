--注意：请使用DBA管理员用户进行操作

--1.根据要找回的存储过程名查询出包头和包体的obj ID

SELECT obj#
  FROM sys.obj$ AS OF TIMESTAMP to_timestamp('2021-09-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS')
 WHERE NAME = upper('pkg_ask_record_mange');

--2.查询旧版本数据

--查询出来的为包头
SELECT SOURCE
  FROM sys.source$ AS OF TIMESTAMP to_timestamp('2021-09-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS')
 WHERE obj# = 91998;
 
--查询出来的为包体
SELECT SOURCE
  FROM sys.source$ AS OF TIMESTAMP to_timestamp('2021-09-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS')
 WHERE obj# = 91999;
