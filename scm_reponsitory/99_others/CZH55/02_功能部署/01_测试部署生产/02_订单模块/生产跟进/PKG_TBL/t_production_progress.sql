--Drop table
--drop scmdata.t_production_progress;
-- Create table
create table T_PRODUCTION_PROGRESS
(
  product_gress_id             VARCHAR2(32) not null,
  company_id                   VARCHAR2(32) not null,
  product_gress_code           VARCHAR2(32) not null,
  order_id                     VARCHAR2(32) not null,
  progress_status              VARCHAR2(32) not null,
  goo_id                       VARCHAR2(32) not null,
  supplier_code                VARCHAR2(32) not null,
  factory_code                 VARCHAR2(32),
  forecast_delivery_date       DATE,
  forecast_delay_day           NUMBER(18,4),
  actual_delivery_date         DATE,
  actual_delay_day             NUMBER(18,4),
  latest_planned_delivery_date DATE,
  order_amount                 NUMBER(18,4) not null,
  delivery_amount              NUMBER(18,4) default 0 not null,
  approve_edition              VARCHAR2(32),
  fabric_check                 VARCHAR2(32),
  qc_quality_check             VARCHAR2(32),
  exception_handle_status      VARCHAR2(32),
  handle_opinions              VARCHAR2(32),
  create_id                    VARCHAR2(32) not null,
  create_time                  DATE not null,
  origin                       VARCHAR2(32) not null,
  memo                         VARCHAR2(256),
  qc_check                     VARCHAR2(32),
  qa_check                     VARCHAR2(32),
  order_status                 VARCHAR2(32),
  delay_problem_class          VARCHAR2(32),
  delay_cause_class            VARCHAR2(32),
  delay_cause_detailed         VARCHAR2(32),
  problem_desc                 VARCHAR2(4000),
  is_sup_responsible           NUMBER(1),
  responsible_dept             VARCHAR2(32),
  responsible_dept_sec         VARCHAR2(32),
  order_full_rate              NUMBER(18,2)
)
tablespace SCMDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
nologging;
-- Add comments to the table 
comment on table T_PRODUCTION_PROGRESS
  is '生产进度表';
-- Add comments to the columns 
comment on column T_PRODUCTION_PROGRESS.product_gress_id
  is '主键';
comment on column T_PRODUCTION_PROGRESS.company_id
  is '企业ID';
comment on column T_PRODUCTION_PROGRESS.product_gress_code
  is '企业生产进度编号';
comment on column T_PRODUCTION_PROGRESS.order_id
  is '订单编号';
comment on column T_PRODUCTION_PROGRESS.progress_status
  is '进度状态';
comment on column T_PRODUCTION_PROGRESS.goo_id
  is '货号';
comment on column T_PRODUCTION_PROGRESS.supplier_code
  is '成品供应商编码';
comment on column T_PRODUCTION_PROGRESS.factory_code
  is '生产工厂编码';
comment on column T_PRODUCTION_PROGRESS.forecast_delivery_date
  is '预测交期';
comment on column T_PRODUCTION_PROGRESS.forecast_delay_day
  is '预测延误天数';
comment on column T_PRODUCTION_PROGRESS.actual_delivery_date
  is '实际交货日期';
comment on column T_PRODUCTION_PROGRESS.actual_delay_day
  is '实际延误天数';
comment on column T_PRODUCTION_PROGRESS.latest_planned_delivery_date
  is '最新计划交期';
comment on column T_PRODUCTION_PROGRESS.order_amount
  is '订单数量';
comment on column T_PRODUCTION_PROGRESS.delivery_amount
  is '交货数量';
comment on column T_PRODUCTION_PROGRESS.approve_edition
  is '批版';
comment on column T_PRODUCTION_PROGRESS.fabric_check
  is '面料检测';
comment on column T_PRODUCTION_PROGRESS.qc_quality_check
  is 'qc质检';
comment on column T_PRODUCTION_PROGRESS.exception_handle_status
  is '异常处理状态';
comment on column T_PRODUCTION_PROGRESS.handle_opinions
  is '处理意见';
comment on column T_PRODUCTION_PROGRESS.create_id
  is '创建人';
comment on column T_PRODUCTION_PROGRESS.create_time
  is '创建时间';
comment on column T_PRODUCTION_PROGRESS.origin
  is '来源';
comment on column T_PRODUCTION_PROGRESS.memo
  is '备注';
comment on column T_PRODUCTION_PROGRESS.qc_check
  is 'qc查货';
comment on column T_PRODUCTION_PROGRESS.qa_check
  is 'qa查货';
comment on column T_PRODUCTION_PROGRESS.order_status
  is '订单状态';
comment on column T_PRODUCTION_PROGRESS.delay_problem_class
  is '延期问题分类';
comment on column T_PRODUCTION_PROGRESS.delay_cause_class
  is '延期原因分类';
comment on column T_PRODUCTION_PROGRESS.delay_cause_detailed
  is '延期原因细分';
comment on column T_PRODUCTION_PROGRESS.problem_desc
  is '问题描述';
comment on column T_PRODUCTION_PROGRESS.is_sup_responsible
  is '供应商是否免责';
comment on column T_PRODUCTION_PROGRESS.responsible_dept
  is '责任部门(1级)';
comment on column T_PRODUCTION_PROGRESS.responsible_dept_sec
  is '责任部门(2级)';
comment on column T_PRODUCTION_PROGRESS.order_full_rate
  is '订单满足率';
-- Create/Recreate indexes 
create index IX_T_PRODUCTION_PROGRESS_COMPANY_ID on T_PRODUCTION_PROGRESS (COMPANY_ID)
  tablespace SCMDATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
  nologging;
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_PRODUCTION_PROGRESS
  add constraint PK_T_PRODUCTION_PROGRESS primary key (PRODUCT_GRESS_ID)
  using index 
  tablespace SCMDATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter index PK_T_PRODUCTION_PROGRESS nologging;
