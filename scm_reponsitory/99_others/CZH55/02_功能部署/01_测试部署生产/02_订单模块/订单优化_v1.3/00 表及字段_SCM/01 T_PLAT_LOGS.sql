-- Create table
create table T_PLAT_LOGS
(
  logs_id       VARCHAR2(32) not null,
  log_id        VARCHAR2(32) not null,
  company_id    VARCHAR2(32) not null,
  operate_field VARCHAR2(1000),
  old_value     VARCHAR2(1000),
  new_value     VARCHAR2(1000),
  create_id     VARCHAR2(32),
  create_time   DATE,
  update_id     VARCHAR2(32),
  update_time   DATE,
  memo          VARCHAR2(256),
  field_type    VARCHAR2(32),
  field_desc    VARCHAR2(32),
  old_code      VARCHAR2(256),
  new_code      VARCHAR2(256),
  seq_no        NUMBER,
  log_reason    VARCHAR2(4000)
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
comment on table T_PLAT_LOGS
  is '平台操作日志明细';
-- Add comments to the columns 
comment on column T_PLAT_LOGS.logs_id
  is '日志明细ID';
comment on column T_PLAT_LOGS.log_id
  is '日志ID';
comment on column T_PLAT_LOGS.company_id
  is '企业ID';
comment on column T_PLAT_LOGS.operate_field
  is '操作字段';
comment on column T_PLAT_LOGS.old_value
  is '旧值';
comment on column T_PLAT_LOGS.new_value
  is '新值';
comment on column T_PLAT_LOGS.create_id
  is '创建人';
comment on column T_PLAT_LOGS.create_time
  is '创建时间';
comment on column T_PLAT_LOGS.update_id
  is '修改人';
comment on column T_PLAT_LOGS.update_time
  is '修改时间';
comment on column T_PLAT_LOGS.memo
  is '备注';
comment on column T_PLAT_LOGS.field_type
  is '字段类型';
comment on column T_PLAT_LOGS.field_desc
  is '字段描述';
comment on column T_PLAT_LOGS.old_code
  is '旧值编码';
comment on column T_PLAT_LOGS.new_code
  is '新值编码';
comment on column T_PLAT_LOGS.seq_no
  is '序号';
comment on column T_PLAT_LOGS.log_reason
  is '操作原因';
-- Create/Recreate indexes 
create index IX_T_PLAT_LOGS_01 on T_PLAT_LOGS (LOG_ID, COMPANY_ID)
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
alter table T_PLAT_LOGS
  add constraint PK_LOGS_ID primary key (LOGS_ID)
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
alter index PK_LOGS_ID nologging;
