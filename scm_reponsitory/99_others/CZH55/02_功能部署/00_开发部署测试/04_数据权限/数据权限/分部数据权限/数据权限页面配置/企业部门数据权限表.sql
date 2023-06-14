-- Create table
create table SYS_COMPANY_DEPT_DATA_PRIV
(
  dept_data_priv_id          VARCHAR2(32) not null,
  dept_data_priv_code        VARCHAR2(32) not null,
  company_id                 VARCHAR2(32) not null,
  company_dept_id            VARCHAR2(32) not null,
  cooperation_type           VARCHAR2(32) not null,
  cooperation_classification VARCHAR2(32) not null,
  pause                      NUMBER(1) default 0 not null,
  create_id                  VARCHAR2(32) not null,
  create_time                DATE default sysdate not null,
  update_id                  VARCHAR2(32) not null,
  update_time                DATE default sysdate not null,
  cooperation_product_cate   VARCHAR2(32)
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
comment on table SYS_COMPANY_DEPT_DATA_PRIV
  is '企业部门数据权限，颗粒度到(男装、女装)维度';
-- Add comments to the columns 
comment on column SYS_COMPANY_DEPT_DATA_PRIV.dept_data_priv_id
  is '数据权限ID';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.dept_data_priv_code
  is '数据权限编号';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.company_id
  is '企业ID';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.cooperation_type
  is '合作类型';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.cooperation_classification
  is '合作分类';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.pause
  is '禁用';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.create_id
  is '创建人';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.create_time
  is '创建时间';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.update_id
  is '修改人';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.update_time
  is '修改时间';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.cooperation_product_cate
  is '生产类别';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_DEPT_DATA_PRIV
  add constraint PK_SYS_COMPANY_DEPT_DATA_PRIV primary key (DEPT_DATA_PRIV_ID)
  using index 
  tablespace SCMINDEX
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
alter index PK_SYS_COMPANY_DEPT_DATA_PRIV nologging;
alter table SYS_COMPANY_DEPT_DATA_PRIV
  add constraint UX_SYS_COMPANY_DEPT_DATA_PRIV unique (DEPT_DATA_PRIV_CODE, COMPANY_ID)
  using index 
  tablespace SCMINDEX
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
alter index UX_SYS_COMPANY_DEPT_DATA_PRIV nologging;
