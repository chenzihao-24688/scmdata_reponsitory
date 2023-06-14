-- Create table
create table SCMDATA.T_SUPPLIER_GROUP
(
  id               VARCHAR2(32) not null,
  company_id       VARCHAR2(32),
  supplier_info_id VARCHAR2(32),
  group_name       VARCHAR2(32),
  create_id        VARCHAR2(32),
  create_time      DATE,
  update_id        VARCHAR2(32),
  update_time      DATE,
  memo             VARCHAR2(256)
)
tablespace SCMDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  )
nologging;
-- Add comments to the table 
comment on table SCMDATA.T_SUPPLIER_GROUP
  is '供应商分组表（用于记录手动编辑最新的分组）';
-- Add comments to the columns 
comment on column SCMDATA.T_SUPPLIER_GROUP.id
  is '主键';
comment on column SCMDATA.T_SUPPLIER_GROUP.company_id
  is '企业ID';
comment on column SCMDATA.T_SUPPLIER_GROUP.supplier_info_id
  is '供应商ID';
comment on column SCMDATA.T_SUPPLIER_GROUP.group_name
  is '分组id';
comment on column SCMDATA.T_SUPPLIER_GROUP.create_id
  is '创建人';
comment on column SCMDATA.T_SUPPLIER_GROUP.create_time
  is '创建时间';
comment on column SCMDATA.T_SUPPLIER_GROUP.update_id
  is '修改人';
comment on column SCMDATA.T_SUPPLIER_GROUP.update_time
  is '修改时间';
comment on column SCMDATA.T_SUPPLIER_GROUP.memo
  is '备注';
-- Create/Recreate indexes 
create index UX_T_SUPPLIER_GROUP_001 on SCMDATA.T_SUPPLIER_GROUP (SUPPLIER_INFO_ID, COMPANY_ID)
  tablespace SCMDATA
  pctfree 10
  initrans 2
  maxtrans 255
  nologging;
/
