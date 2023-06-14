begin
insert into scmdata.t_day_proc (DAY_PROC_ID, SEQNO, PROC_SQL, PROC_TIME, SECONDS, PAUSE, PROC_END_TIME, PROC_NAME, REMARKS)
values ('df5b0d8616fa400be053e2281cac426f', 15000, 'begin pkg_production_progress_a.p_auto_end_all_orders(p_company_id => ''b6cc680ad0f599cde0531164a8c0337f''); end;', null, null, 1, null, '自动结束订单——非生产订单', '执行频率：每5分钟刷一次
执行规则：所有分部非生产订单增加自动结束订单功能，规则如下：
1）当订单熊猫结束时间不为空，不延期（不延期指交货记录ASN到仓确定日期≤订单交期）的交货数量≥男装/女装/鞋包80%、内衣88%、淘品86%、美妆92%，无需赋值延期原因，直接结束订单；
2）熊猫结束时间+3天＜当前日期；');

insert into scmdata.t_day_proc (DAY_PROC_ID, SEQNO, PROC_SQL, PROC_TIME, SECONDS, PAUSE, PROC_END_TIME, PROC_NAME, REMARKS)
values ('df5b0d8616fa400be053e2281cac427f', 16000, 'begin pkg_production_progress_a.p_auto_end_mt_orders(p_company_id => ''b6cc680ad0f599cde0531164a8c0337f''); end;', null, null, 1, null, '自动结束订单——美妆、淘品', '执行频率：每5分钟刷一次
执行规则：
  美妆、淘品自动结束订单区分是否生产订单，生产订单自动结束订单规则如下（非生产订单见所有分部非生产订单结束规则）：
  1）当订单熊猫结束时间不为空，不延期（不延期指交货记录ASN到仓确定日期≤订单交期）的交货数量≥淘品86%、美妆92%，无需赋值延期原因，直接结束订单；
  2）结束时间减去交货日期（订单初始交期）＜3；
  3）订单不需要QC查货：订单“分类-生产类别-产品子类”没有在’业务配置中心-QC查货配置‘，则判定为不需要QC查货；
  4）订单没有异常单，或没有在处理中的异常单：在’异常处理列表-待处理‘不存在订单的异常处理单；');

insert into scmdata.t_day_proc (DAY_PROC_ID, SEQNO, PROC_SQL, PROC_TIME, SECONDS, PAUSE, PROC_END_TIME, PROC_NAME, REMARKS)
values ('df5b0d8616fa400be053e2281cac428f', 17000, 'begin pkg_production_progress_a.p_auto_mt_delay_problem(p_company_id => ''b6cc680ad0f599cde0531164a8c0337f''); end;', null, null, 1, null, '自动赋值延期原因——美妆、淘品', '执行频率：每5分钟刷一次
执行规则：美妆、淘品自动赋值延期原因：
  1）当订单满足：熊猫结束时间+1天≤当前日期，且最晚到仓确认时间-交货日期（订单初始交期）=1天的订单自动赋值延期原因
   ①如果没有填写延期原因，需自动赋值延期问题分类、延期原因分类、延期原因细分、供应商是否免责、责任部门1级、责任部门2级、是否质责量问题。延期问题分类、延期原因分类、延期原因细分为下图示；供应商是否免责、责任部门1级、责任部门2级、是否质量问题则根据订单适用范围以及延期问题分类、延期原因分类、延期原因找到对应异常处理配置模板对应的值。问题描述赋值为：其他；
  ②如果已填写延期原因，则不需要自动赋值，以填写的内容为准；
  ③赋值需记录到从表[跟进日志] ，操作方为三福，操作人为系统管理员，操作时间为赋值时间；');
end;
