create table pt_ordered (pt_ordered_id varchar2(32),company_id varchar2(32),order_id varchar2(32),year number(4),quarter number(1),month number(2),supplier_code  varchar2(32),
                         factory_code  varchar2(32),goo_id varchar2(32),product_cate  varchar2(32),
                         samll_category  varchar2(32),style_name varchar2(32),style_number  varchar2(32) ,
                         flw_order varchar2(32),flw_order_manager varchar2(32),qc varchar2(32),qc_manager varchar2(32),
                         area_gp_leader varchar2(32),is_twenty number(1),delivery_status varchar2(32),is_quality number(1),
                         actual_delay_days number(5),delay_section varchar2(32),responsible_dept varchar2(32),responsible_dept_sec varchar2(32),
                         delay_problem_class varchar2(50),delay_cause_class varchar2(50),delay_cause_detailed varchar2(50),
                         problem_desc  varchar2(4000), purchase_price number(10), fixed_price number(10),order_amount number(18,4),est_arrival_amount number(18,4),
                         delivery_amount number(18,4), satisfy_amount number(18,4),order_money number(10),delivery_money number(10),
                         satisfy_money number(10),delivery_date date, order_create_date date,arrival_date date,
                         sort_date date,is_first_order number(1),remarks varchar2(4000),order_finish_time date,create_id varchar2(32),create_time date,update_id varchar2(32),update_time date)
tablespace SCMDATA --表段X_SMALL_AREA放在表空间TBSL_SDDQ中
  pctfree 10 --块保留10%的空间留给更新该块数据使用
  initrans 1 --初始化事务槽的个数
  maxtrans 255 --最大事务槽的个数
  storage --存储参数
  ( 
    initial 64k --区段(extent)一次扩展64k
    minextents 1 --最小区段数
    maxextents unlimited --最大区段无限制 
  )                         
partition by list (year)
subpartition by list(month)
subpartition template
(
subpartition pt_ordered_quarter_1 values (1,2,3),
subpartition pt_ordered_quarter_2 values (4,5,6),
subpartition pt_ordered_quarter_3 values (7,8,9),
subpartition pt_ordered_quarter_4 values (10,11,12))
(
partition pt_ordered_year_2021 values (2021),
partition pt_ordered_year_2022 values (2022),
partition pt_ordered_year_2023 values (2023),
partition pt_ordered_year_other values (DEFAULT)
);        
                         

/*
select * from pt_ordered;  
select * from pt_ordered partition(pt_ordered_year_2021);
select * from pt_ordered partition(pt_ordered_year_2022);
select * from pt_ordered partition(pt_ordered_year_2023);
select * from pt_ordered partition(pt_ordered_year_other);
 
select * from pt_ordered subpartition(pt_ordered_year_2021_pt_ordered_quarter_1);
select * from pt_ordered subpartition(pt_ordered_year_2021_pt_ordered_quarter_2);
select * from pt_ordered subpartition(pt_ordered_year_2021_pt_ordered_quarter_3);
select * from pt_ordered subpartition(pt_ordered_year_2021_pt_ordered_quarter_4);

SELECT * FROM user_TAB_PARTITIONS ;

select table_name, partition_name, subpartition_name from user_tab_subpartitions;

drop table pt_ordered;

--select * from  nsfdata.dayproc t where upper(t.procsql) like upper('%PDayUpdateKPI%')
nsfdata.PDayUpdateKPIForOrdered

select trunc(sysdate ,'dd') from dual ; 

select trunc(sysdate ,'yyyy') from dual ; 

select trunc(Add_Months(SysDate,-1) ,'mm') from dual ; 

select Trunc(Sysdate)-1 from dual;
*/
alter table scmdata.pt_ordered enable row movement;
update scmdata.pt_ordered t set t.year = '2022' where t.pt_ordered_id = 'cd06d48a42d322a0e0533c281cac13a9';
alter table scmdata.pt_ordered disable row movement;


select rowid,t.* from nbw.sys_item t where t.item_id like '%a_report_120%';
select rowid,t.* from nbw.sys_tree_list t where t.item_id like '%a_report_120%';
select rowid,t.* from nbw.sys_item_list t where t.item_id like '%a_report_120%';
