--五大性能报告获取

--1.AWR获取
--a.参数
--1)DBID
select dbid from v$database;
--2)INSTANCE_NUMBER
select instance_number from v$instance;
--3)
select t.snap_id as 快照id,
       t.dbid as dbid,
       t.instance_number as instance_number,
       to_char(t.begin_interval_time, 'yyyy-mm-dd hh24:mi:ss') "快照开始时间",
       to_char(t.end_interval_time, 'yyyy-mm-dd hh24:mi:ss') as "快照结束时间"
from dba_hist_snapshot t
order by snap_id;
    
--b.获取方法
SELECT output
  FROM TABLE(dbms_workload_repository.awr_report_html(v_dbid,
                                                      v_instance_number,
                                                      v_min_snap_id,
                                                      v_max_snap_id))
--1）测试
SELECT output
  FROM TABLE(dbms_workload_repository.awr_report_html(1591207204,
                                                      1,
                                                      4237,
                                                      4238));
