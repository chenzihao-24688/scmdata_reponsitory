--sqlʵ�ʲ�ѯʱ��
SELECT a.sql_text,
       a.sql_fulltext,
       a.sql_id,
       a.executions "��ִ�д���",
       nvl(a.elapsed_time, 0) / 1000 / 1000 "�ܺ�ʱ(��)",
       (nvl(a.elapsed_time, 0) /
       nvl(decode(a.executions, 0, 1, a.executions), 1)) / 1000 / 1000 "ƽ����ʱ���룩",
       a.parse_calls "Ӳ��������",
       a.disk_reads "���������",
       a.buffer_gets "������������",
       a.first_load_time "sql��ʼִ��ʱ��"
  FROM v$sql a
 WHERE a.sql_fulltext LIKE '%progress_status_desc_check02%';
