--ע�⣺��ʹ��DBA����Ա�û����в���

--1.����Ҫ�һصĴ洢��������ѯ����ͷ�Ͱ����obj ID

SELECT obj#
  FROM sys.obj$ AS OF TIMESTAMP to_timestamp('2021-09-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS')
 WHERE NAME = upper('pkg_ask_record_mange');

--2.��ѯ�ɰ汾����

--��ѯ������Ϊ��ͷ
SELECT SOURCE
  FROM sys.source$ AS OF TIMESTAMP to_timestamp('2021-09-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS')
 WHERE obj# = 91998;
 
--��ѯ������Ϊ����
SELECT SOURCE
  FROM sys.source$ AS OF TIMESTAMP to_timestamp('2021-09-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS')
 WHERE obj# = 91999;
