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
  is '生产进度操作日志记录表';
-- Add comments to the columns 
comment on column T_PROGRESS_LOG.log_id
  is '生产进度日志ID（主键）';
comment on column T_PROGRESS_LOG.product_gress_id
  is '生产进度ID';
comment on column T_PROGRESS_LOG.company_id
  is '企业ID';
comment on column T_PROGRESS_LOG.log_type
  is '操作类型';
comment on column T_PROGRESS_LOG.log_msg
  is '操作内容';
comment on column T_PROGRESS_LOG.operater
  is '操作方（NEED：采购方，SUP:供应商  ）';
comment on column T_PROGRESS_LOG.operate_company_id
  is '操作方企业ID';
comment on column T_PROGRESS_LOG.create_id
  is '创建人';
comment on column T_PROGRESS_LOG.create_time
  is '创建时间';
comment on column T_PROGRESS_LOG.update_id
  is '修改人';
comment on column T_PROGRESS_LOG.update_time
  is '修改时间';
comment on column T_PROGRESS_LOG.memo
  is '备注';
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
