--·¢ËÍ¶ÌÐÅ

select t.*,rowid from sys_port_list t ;
select t.* from sys_port_websocket t;
select t.*,rowid from sys_port_http t;
select a.*,a.rowid from sys_method a;
select a.*,a.rowid from sys_port_method a;
select a.*,a.rowid from SYS_PORT_MAP a;

select a.*,a.rowid from sys_action a where port_id=19
select * from sys_item_element_rela a where element_id='sms-test' for update

select * from sys_item where item_id='xjw_invoice1';

