-- Create table
create table T_ORDER_LOG
(
  log_id                VARCHAR2(32) not null,
  log_type              VARCHAR2(32),
  old_designate_factory VARCHAR2(32),
  new_designate_factory VARCHAR2(32),
  operator              VARCHAR2(32),
  operate_person        VARCHAR2(32),
  operate_time          DATE,
  order_id              VARCHAR2(32) not null,
  company_id            VARCHAR2(32) not null
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
comment on table T_ORDER_LOG
  is '订单修改日志表';
-- Add comments to the columns 
comment on column T_ORDER_LOG.log_id
  is '订单日志ID';
comment on column T_ORDER_LOG.log_type
  is '日志类型';
comment on column T_ORDER_LOG.old_designate_factory
  is '原指定工厂';
comment on column T_ORDER_LOG.new_designate_factory
  is '新指定工厂';
comment on column T_ORDER_LOG.operator
  is '操作方';
comment on column T_ORDER_LOG.operate_person
  is '操作人';
comment on column T_ORDER_LOG.operate_time
  is '操作时间';
comment on column T_ORDER_LOG.order_id
  is '订单ID';
comment on column T_ORDER_LOG.company_id
  is '企业ID（订单所属企业）';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_ORDER_LOG
  add constraint PK_ORDER_LOG_ID primary key (LOG_ID)
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
alter index PK_ORDER_LOG_ID nologging;
