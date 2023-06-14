-- Create table
create table SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE
(
  data_priv_dept_middle_id VARCHAR2(32) not null,
  company_id               VARCHAR2(32) not null,
  data_priv_group_id       VARCHAR2(32) not null,
  company_dept_id          VARCHAR2(32),
  create_id                VARCHAR2(32) not null,
  create_time              DATE not null,
  update_id                VARCHAR2(32) not null,
  update_time              DATE not null
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
comment on table SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE
  is '企业数据权限（组-部门配置）中间表';
-- Add comments to the columns 
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.data_priv_dept_middle_id
  is '数据权限（组-人员配置）ID(主键)';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.data_priv_group_id
  is '数据权限组ID';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.create_id
  is '创建人';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.create_time
  is '创建时间';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.update_id
  is '修改人';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.update_time
  is '修改时间';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.company_id
  is '公司ID';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.company_dept_id
  is '部门ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE
  add constraint PK_DATA_PRIV_DEPT_MIDDLE_ID primary key (DATA_PRIV_DEPT_MIDDLE_ID)
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
alter index PK_DATA_PRIV_DEPT_MIDDLE_ID nologging;
alter table SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE
  add constraint FK_PAGE_DATA_PRIV_DEPT_GROUP_ID foreign key (DATA_PRIV_GROUP_ID)
  references SYS_COMPANY_DATA_PRIV_GROUP (DATA_PRIV_GROUP_ID);
