--1.验厂管理：
--1）提交验厂报告后推送消息至叶经理企业微信；
--2）验厂审核-不通过时改为下拉框选项，多选；
--2.准入审批-不同意准入-审批意见修改为非必填
select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_check_101_1_0','action_a_check_102_1','action_a_check_102_2','action_a_coop_312'); 
select rowid,t.* from nbw.sys_param_list t where t.param_name in  ('MEMO_FR','AUDIT_COMMENT_FR','AUDIT_COMMENT_SP');
--档案详情
--成本等级改为非必填；
--生产效率默认为80% ，可修改
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_supp_151','a_supp_161','a_supp_171'); 
select rowid,t.* from nbw.sys_field_list t where t.field_name like '%COST_STEP%' ;

--验厂申请附件
select rowid,t.* from nbw.sys_detail_group t where t.item_id in ('a_coop_150_3' , 'a_coop_211' , 'a_coop_221');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_coop_150_3' , 'a_coop_211' , 'a_coop_221');
select rowid,t.* from nbw.sys_field_list t where t.field_name like '%ASK_FILES%' ;  

--验厂报告
select rowid,t.* from nbw.sys_detail_group t where t.item_id in ('a_check_101_1','a_check_102_1','a_check_101_4','a_coop_104');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_check_101_1','a_check_102_1','a_check_101_4','a_coop_104');

--供应商档案
select rowid,t.* from nbw.sys_detail_group t where t.item_id in ('a_supp_151','a_supp_161','a_supp_171');
select rowid,t.* from nbw.sys_item_list t where t.item_id in ('a_supp_151','a_supp_161','a_supp_171');

--提交时校验必填项是否填写（待做）
select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_coop_151');   
