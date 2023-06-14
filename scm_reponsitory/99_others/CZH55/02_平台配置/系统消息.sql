--1.定时（五分钟）
select * from bwptest1.sys_hint;

--2.接口表（action_type = 8,port_id = 15）
select * from bwptest1.sys_method;
select * from bwptest1.sys_port_http;
select * from bwptest1.sys_port_method;



select t.*,rowid from bwptest1.sys_port_list t ;
select t.* from bwptest1.sys_port_websocket t;
select t.*,rowid from bwptest1.sys_port_http t;
select a.*,a.rowid from bwptest1.sys_method a;
select a.*,a.rowid from bwptest1.sys_port_method a;
select a.*,a.rowid from bwptest1.SYS_PORT_MAP a;

--3.Msg_info(任务调度设置)

select rowid,t.* from bwptest1.Msg_info t; --消息信息表

select * from bwptest1.Msg_log; --消息日志表

select * from bwptest1.Msg_log_detail; --消息日志详情表

select * from bwptest1.msg_user_online;


--4.待审批单据提醒
select rowid,t.* from bwptest1.sys_action t where t.element_id = 'action-czh_approval_0011';
select rowid,t.* from bwptest1.sys_item_element_rela t where t.item_id = 'czh_approval_0011';
select * from bwptest1.sys_action t where t.action_type = 8 and t.port_id = '15';

select * from bwptest1.sys_hint;




