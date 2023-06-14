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
  is '�����޸���־��';
-- Add comments to the columns 
comment on column T_ORDER_LOG.log_id
  is '������־ID';
comment on column T_ORDER_LOG.log_type
  is '��־����';
comment on column T_ORDER_LOG.old_designate_factory
  is 'ԭָ������';
comment on column T_ORDER_LOG.new_designate_factory
  is '��ָ������';
comment on column T_ORDER_LOG.operator
  is '������';
comment on column T_ORDER_LOG.operate_person
  is '������';
comment on column T_ORDER_LOG.operate_time
  is '����ʱ��';
comment on column T_ORDER_LOG.order_id
  is '����ID';
comment on column T_ORDER_LOG.company_id
  is '��ҵID������������ҵ��';
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
