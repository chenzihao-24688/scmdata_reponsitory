-- Create table
create table T_PROGRESS_LOG
(
  log_id             VARCHAR2(32) not null,
  product_gress_id   VARCHAR2(32) not null,
  company_id         VARCHAR2(32) not null,
  log_type           VARCHAR2(32),
  log_msg            VARCHAR2(4000),
  operater           VARCHAR2(32),
  operate_company_id VARCHAR2(32),
  create_id          VARCHAR2(32),
  create_time        DATE,
  update_id          VARCHAR2(32),
  update_time        DATE,
  memo               VARCHAR2(256)
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
comment on table T_PROGRESS_LOG
  is '�������Ȳ�����־��¼��';
-- Add comments to the columns 
comment on column T_PROGRESS_LOG.log_id
  is '����������־ID��������';
comment on column T_PROGRESS_LOG.product_gress_id
  is '��������ID';
comment on column T_PROGRESS_LOG.company_id
  is '��ҵID';
comment on column T_PROGRESS_LOG.log_type
  is '��������';
comment on column T_PROGRESS_LOG.log_msg
  is '��������';
comment on column T_PROGRESS_LOG.operater
  is '��������NEED���ɹ�����SUP:��Ӧ��  ��';
comment on column T_PROGRESS_LOG.operate_company_id
  is '��������ҵID';
comment on column T_PROGRESS_LOG.create_id
  is '������';
comment on column T_PROGRESS_LOG.create_time
  is '����ʱ��';
comment on column T_PROGRESS_LOG.update_id
  is '�޸���';
comment on column T_PROGRESS_LOG.update_time
  is '�޸�ʱ��';
comment on column T_PROGRESS_LOG.memo
  is '��ע';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_PROGRESS_LOG
  add constraint PK_PROGRESS_LOG_ID primary key (LOG_ID)
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
alter index PK_PROGRESS_LOG_ID nologging;
