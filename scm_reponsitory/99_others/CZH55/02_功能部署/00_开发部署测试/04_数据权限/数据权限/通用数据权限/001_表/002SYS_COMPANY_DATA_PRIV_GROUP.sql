-- Create table
create table SYS_COMPANY_DATA_PRIV_GROUP
(
  data_priv_group_id   VARCHAR2(32) not null,
  data_priv_group_code VARCHAR2(32) not null,
  data_priv_group_name VARCHAR2(48) not null,
  company_id           VARCHAR2(32) not null,
  user_id              VARCHAR2(32),
  seq_no               NUMBER,
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
comment on table SYS_COMPANY_DATA_PRIV_GROUP
  is '企业数据权限组';
-- Add comments to the columns 
comment on column SYS_COMPANY_DATA_PRIV_GROUP.data_priv_group_id
  is '数据权限组ID（主键）';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.data_priv_group_code
  is '数据权限组编码';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.data_priv_group_name
  is '数据权限组名称';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.company_id
  is '公司ID';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.user_id
  is '员工ID';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.seq_no
  is '序号';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.create_id
  is '创建人';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.create_time
  is '创建时间';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.update_id
  is '修改人';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.update_time
  is '修改时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_DATA_PRIV_GROUP
  add constraint PK_DATA_PRIV_GROUP_ID primary key (DATA_PRIV_GROUP_ID)
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
alter index PK_DATA_PRIV_GROUP_ID nologging;
