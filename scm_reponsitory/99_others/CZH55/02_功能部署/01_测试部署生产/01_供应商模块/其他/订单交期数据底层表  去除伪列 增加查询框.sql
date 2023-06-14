--订单交期数据底层表  去除伪列 增加查询框
update bw3.sys_item t set t.show_rowid = 7 where t.item_id = 'a_report_120';
update bw3.sys_item_list t set t.query_type = 3 where t.item_id = 'a_report_120';
