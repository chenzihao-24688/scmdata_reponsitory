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
  is '平台操作日志';
-- Add comments to the columns 
comment on column T_PLAT_LOG.log_id
  is '日志ID';
comment on column T_PLAT_LOG.pre_log_id
  is '前日志ID';
comment on column T_PLAT_LOG.suf_log_id
  is '后日志ID';
comment on column T_PLAT_LOG.company_id
  is '企业ID';
comment on column T_PLAT_LOG.apply_module
  is '应用模块';
comment on column T_PLAT_LOG.apply_pk_id
  is '应用模块主表ID';
comment on column T_PLAT_LOG.action_type
  is '操作类型';
comment on column T_PLAT_LOG.log_type
  is '日志类型';
comment on column T_PLAT_LOG.log_msg
  is '日志内容';
comment on column T_PLAT_LOG.operater
  is '操作人';
comment on column T_PLAT_LOG.operate_company_id
  is '操作方企业';
comment on column T_PLAT_LOG.create_id
  is '创建人';
comment on column T_PLAT_LOG.create_time
  is '创建时间';
comment on column T_PLAT_LOG.update_id
  is '修改人';
comment on column T_PLAT_LOG.update_time
  is '修改时间';
comment on column T_PLAT_LOG.memo
  is '备注';
comment on column T_PLAT_LOG.base_table
  is '基表';
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
