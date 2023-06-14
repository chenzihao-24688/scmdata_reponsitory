---1.验厂申请审核记录表修改表结构
comment on table SCMDATA.T_FACTORY_ASK_OPER_LOG
  is '验厂申请审核记录';
-- Add comments to the columns 
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.log_id
  is '主键';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.factory_ask_id
  is '验厂申请单id';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.oper_user_id
  is '操作用户';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.oper_code
  is '操作前执行的操作方式字典编码(SUBMIT提交、AGREE同意、BACK驳回、DISAGREE不同意、CANCEL撤回）';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.status_af_oper
  is '操作后表单的节点+状态(v9.10 废弃)';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.remarks
  is '备注';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.ask_record_id
  is '合作申请单id';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.oper_time
  is '操作时间';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.oper_user_company_id
  is '操作企业';
comment on column SCMDATA.T_FACTORY_ASK_OPER_LOG.status_bf_oper
  is '操作前表单的节点+状态';
