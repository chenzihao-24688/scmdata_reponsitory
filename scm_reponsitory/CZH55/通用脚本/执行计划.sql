--��β鿴��sqlplus:Explain��Autotrace   plsql developer:F5��
--1.Explain ������ oracle�Դ�  sqlplus�ڣ�
--1.1 ������ʽ
--explain plan set statement_id = 'testplan' for select ....    (select , insert , update ��dml���)

--1.2 �鿴��ʽ
SELECT lpad('', 5 * (LEVEL - 1)) || operation operation,
       options,
       object_name,
       cost,
       position
  FROM plan_table
 START WITH id = 0
        AND statement_id = 'testplan'
CONNECT BY PRIOR id = parent_id;

--1.3 ɾ���ϴν�������
delete from plan_table where statement_id = 'testplan'


--2.Autotrace(�Զ����� oracle�Դ�sqlplus��)
--2.1 ������ʽ
--SQL > set autotrace on;(sqlplus ��ʹ��)

--�����ţ�SQL > select * from dual;

--����������ݣ�ִ�мƻ���ͳ����Ϣ

--3. ʹ��plsql developer:F5 �鿴


--4. ��ô��
/*
ִ�мƻ���ʵ��һ������������������ִ�У������ͬ�ģ��������ִ�С�
��ʾʱ�������������˴�����ߵĿ������һ�����������

�ȴ��ͷһֱ���ҿ���ֱ���������ұߵĲ��еĵط������ڲ����еģ����ҵ���ִ�У����ڲ��еģ����ϵ���ִ�С�
�����е������飬��������ִ�У��ǲ��е������飬��������ִ�С�

*/





