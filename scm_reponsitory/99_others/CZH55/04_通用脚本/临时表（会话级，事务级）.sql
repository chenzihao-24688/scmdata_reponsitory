--��oracle�У���ʱ���Ϊ�Ự����(session)�����񼶱�(transaction)���֡�
--�Ự������ʱ���������Ự�ڼ䶼���ڣ�ֱ���Ự���������񼶱����ʱ��������transaction��������ʧ����commit/rollback������Ựʱ���������ʱ�����ݡ�
--  1��������ʱ��  on commit delete rows;      ��COMMIT��ʱ��ɾ�����ݣ�Ĭ�������
--  2���Ự����ʱ��  on commit preserve rows;  ��COMMIT��ʱ�������ݣ����Ự����ɾ������
--��ʱ��
--1.�Ự������ʱ��
--�Ự����ʱ����ָ��ʱ���е�����ֻ�ڻỰ��������֮�д��ڣ����û��˳��Ự������ʱ��Oracle�Զ������ʱ�������ݡ�
--1.1 ������ʽ1
create global temporary table test_session_temp_tb(temp_id number,temp_name varchar2(32)) on commit preserve rows;
insert into test_session_temp_tb values(2,'czh');
select * from  test_session_temp_tb;

--1.2 ������ʽ2
create global temporary table test_session_temp_tb2 on commit preserve rows as select * from test_session_temp_tb;
insert into test_session_temp_tb2 values(3,'czh');
--��ǰsession�Ự����ѯ������
select * from  test_session_temp_tb2;
--�л������˳�session�Ự����ѯ������
select * from  test_session_temp_tb2;

--2.���񼶱����ʱ��
--2.1 ������ʽ1
create global temporary table  test_session_temp_tb3(temp_id number,temp_name varchar2(100))on commit delete rows;
insert into test_session_temp_tb3 values(4,'czh');
--commmit��rollback֮ǰ��һ�Σ�������
select * from test_session_temp_tb3;
--commmit��rollback֮���һ�Σ�������
select * from test_session_temp_tb3;

--2.2 ������ʽ2
create global temporary table test_session_temp_tb4 as select * from test_session_temp_tb3;--(Ĭ�ϴ����ľ������񼶱����Բ���on commit delete rows)

--3.oracle����ʱ�����������ʵ���ڵģ�����ÿ�ζ�������
--��Ҫɾ����ʱ����ԣ�
truncate table ��ʱ����;
drop table ��ʱ����;
