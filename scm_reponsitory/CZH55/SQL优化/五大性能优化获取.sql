--������ܱ����ȡ

--1.AWR��ȡ
--a.����
--1)DBID
select dbid from v$database;
--2)INSTANCE_NUMBER
select instance_number from v$instance;
--3)
select t.snap_id as ����id,
       t.dbid as dbid,
       t.instance_number as instance_number,
       to_char(t.begin_interval_time, 'yyyy-mm-dd hh24:mi:ss') "���տ�ʼʱ��",
       to_char(t.end_interval_time, 'yyyy-mm-dd hh24:mi:ss') as "���ս���ʱ��"
from dba_hist_snapshot t
order by snap_id;
    
--b.��ȡ����
SELECT output
  FROM TABLE(dbms_workload_repository.awr_report_html(v_dbid,
                                                      v_instance_number,
                                                      v_min_snap_id,
                                                      v_max_snap_id))
--1������
SELECT output
  FROM TABLE(dbms_workload_repository.awr_report_html(1591207204,
                                                      1,
                                                      4237,
                                                      4238));
