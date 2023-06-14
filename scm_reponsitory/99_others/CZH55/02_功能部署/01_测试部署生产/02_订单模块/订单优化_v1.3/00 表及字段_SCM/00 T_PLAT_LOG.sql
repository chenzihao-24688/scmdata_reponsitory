-- Create table
create table T_PLAT_LOG
(
  log_id             VARCHAR2(32) not null,
  pre_log_id         VARCHAR2(32),
  suf_log_id         VARCHAR2(32),
  company_id         VARCHAR2(32) not null,
  apply_module       VARCHAR2(32) not null,
  apply_pk_id        VARCHAR2(32) not null,
  action_type        VARCHAR2(32),
  log_type           VARCHAR2(32),
  log_msg            VARCHAR2(4000),
  operater           VARCHAR2(32),
  operate_company_id VARCHAR2(32),
  create_id          VARCHAR2(32),
  create_time        DATE,
  update_id          VARCHAR2(32),
  update_time        DATE,
  memo               VARCHAR2(256),
  base_table         VARCHAR2(256)
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
comment on table T_PLAT_LOG
  is 'ƽ̨������־';
-- Add comments to the columns 
comment on column T_PLAT_LOG.log_id
  is '��־ID';
comment on column T_PLAT_LOG.pre_log_id
  is 'ǰ��־ID';
comment on column T_PLAT_LOG.suf_log_id
  is '����־ID';
comment on column T_PLAT_LOG.company_id
  is '��ҵID';
comment on column T_PLAT_LOG.apply_module
  is 'Ӧ��ģ��';
comment on column T_PLAT_LOG.apply_pk_id
  is 'Ӧ��ģ������ID';
comment on column T_PLAT_LOG.action_type
  is '��������';
comment on column T_PLAT_LOG.log_type
  is '��־����';
comment on column T_PLAT_LOG.log_msg
  is '��־����';
comment on column T_PLAT_LOG.operater
  is '������';
comment on column T_PLAT_LOG.operate_company_id
  is '��������ҵ';
comment on column T_PLAT_LOG.create_id
  is '������';
comment on column T_PLAT_LOG.create_time
  is '����ʱ��';
comment on column T_PLAT_LOG.update_id
  is '�޸���';
comment on column T_PLAT_LOG.update_time
  is '�޸�ʱ��';
comment on column T_PLAT_LOG.memo
  is '��ע';
comment on column T_PLAT_LOG.base_table
  is '����';
-- Create/Recreate indexes 
create index IX_T_PLAT_LOG_01 on T_PLAT_LOG (APPLY_PK_ID, APPLY_MODULE, COMPANY_ID)
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
alter table T_PLAT_LOG
  add constraint PK_PLAT_LOG_ID primary key (LOG_ID)
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
alter index PK_PLAT_LOG_ID nologging;
