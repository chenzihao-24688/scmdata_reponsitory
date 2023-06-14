-- Create table
create table SYS_DATA_PRIVS
(
  data_priv_id         VARCHAR2(32) not null,
  data_priv_code       VARCHAR2(32) not null,
  data_priv_name       VARCHAR2(48) not null,
  seq_no               NUMBER,
  level_type           VARCHAR2(32) not null,
  fields_config_method VARCHAR2(32),
  pause                NUMBER default 1,
  create_id            VARCHAR2(32) not null,
  create_time          DATE not null,
  update_id            VARCHAR2(32) not null,
  update_time          DATE not null
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
comment on table SYS_DATA_PRIVS
  is '数据权限';
-- Add comments to the columns 
comment on column SYS_DATA_PRIVS.data_priv_id
  is '数据权限ID（主键）';
comment on column SYS_DATA_PRIVS.data_priv_code
  is '数据权限编码';
comment on column SYS_DATA_PRIVS.data_priv_name
  is '数据权限名称';
comment on column SYS_DATA_PRIVS.seq_no
  is '序号';
comment on column SYS_DATA_PRIVS.level_type
  is '层级类型（日期，分部，仓库等）由字典提供';
comment on column SYS_DATA_PRIVS.create_id
  is '创建人';
comment on column SYS_DATA_PRIVS.create_time
  is '创建时间';
comment on column SYS_DATA_PRIVS.update_id
  is '修改人';
comment on column SYS_DATA_PRIVS.update_time
  is '修改时间';
comment on column SYS_DATA_PRIVS.fields_config_method
  is '字段配置方式';
comment on column SYS_DATA_PRIVS.pause
  is '启停（0：停用 1：启用）';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_DATA_PRIVS
  add constraint PK_DATA_PRIV_ID primary key (DATA_PRIV_ID)
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
alter index PK_DATA_PRIV_ID nologging;
