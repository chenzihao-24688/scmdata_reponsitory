-- Create table
create table T_LOG
(
  log_id      VARCHAR2(32) not null,
  record_id   VARCHAR2(32),
  log_type    VARCHAR2(48),
  log_flag    CHAR(1),
  log_msg     VARCHAR2(3000),
  create_time DATE
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
-- Add comments to the columns 
comment on column T_LOG.log_id
  is '日志ID';
comment on column T_LOG.record_id
  is '任务ID';
comment on column T_LOG.log_type
  is '日志类型';
comment on column T_LOG.log_flag
  is '任务是否执行成功';
comment on column T_LOG.log_msg
  is '日志消息';
comment on column T_LOG.create_time
  is '创建时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_LOG
  add constraint PK_LOG_ID primary key (LOG_ID)
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
alter index PK_LOG_ID nologging;
