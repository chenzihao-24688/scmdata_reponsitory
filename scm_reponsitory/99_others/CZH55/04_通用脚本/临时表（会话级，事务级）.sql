--在oracle中，临时表分为会话级别(session)和事务级别(transaction)两种。
--会话级的临时表在整个会话期间都存在，直到会话结束；事务级别的临时表数据在transaction结束后消失，即commit/rollback或结束会话时，会清除临时表数据。
--  1、事务级临时表  on commit delete rows;      当COMMIT的时候删除数据（默认情况）
--  2、会话级临时表  on commit preserve rows;  当COMMIT的时候保留数据，当会话结束删除数据
--临时表
--1.会话级别临时表
--会话级临时表是指临时表中的数据只在会话生命周期之中存在，当用户退出会话结束的时候，Oracle自动清除临时表中数据。
--1.1 创建方式1
create global temporary table test_session_temp_tb(temp_id number,temp_name varchar2(32)) on commit preserve rows;
insert into test_session_temp_tb values(2,'czh');
select * from  test_session_temp_tb;

--1.2 创建方式2
create global temporary table test_session_temp_tb2 on commit preserve rows as select * from test_session_temp_tb;
insert into test_session_temp_tb2 values(3,'czh');
--当前session会话，查询有数据
select * from  test_session_temp_tb2;
--切换或者退出session会话，查询无数据
select * from  test_session_temp_tb2;

--2.事务级别的临时表
--2.1 创建方式1
create global temporary table  test_session_temp_tb3(temp_id number,temp_name varchar2(100))on commit delete rows;
insert into test_session_temp_tb3 values(4,'czh');
--commmit、rollback之前查一次，有数据
select * from test_session_temp_tb3;
--commmit、rollback之后查一次，无数据
select * from test_session_temp_tb3;

--2.2 创建方式2
create global temporary table test_session_temp_tb4 as select * from test_session_temp_tb3;--(默认创建的就是事务级别，所以不用on commit delete rows)

--3.oracle的临时表创建完就是真实存在的，无需每次都创建。
--若要删除临时表可以：
truncate table 临时表名;
drop table 临时表名;
