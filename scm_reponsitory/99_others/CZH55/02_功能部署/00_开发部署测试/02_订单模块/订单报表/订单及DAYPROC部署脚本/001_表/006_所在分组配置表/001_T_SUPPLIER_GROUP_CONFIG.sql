-- Create table
create table T_SUPPLIER_GROUP_CONFIG
(
  group_config_id   VARCHAR2(32) not null,
  group_name        VARCHAR2(32) not null,
  area_group_leader VARCHAR2(32) not null,
  effective_time    DATE not null,
  end_time          DATE not null,
  config_status     NUMBER(1) default 0,
  pause             NUMBER(1) default 1,
  remarks           VARCHAR2(256),
  create_id         VARCHAR2(32),
  create_time       DATE,
  update_id         VARCHAR2(32),
  update_time       DATE,
  company_id        VARCHAR2(32) not null
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
comment on table T_SUPPLIER_GROUP_CONFIG
  is '所在分组配置';
-- Add comments to the columns 
comment on column T_SUPPLIER_GROUP_CONFIG.group_config_id
  is '所在分组配置ID（主键）';
comment on column T_SUPPLIER_GROUP_CONFIG.group_name
  is '分组名称';
comment on column T_SUPPLIER_GROUP_CONFIG.area_group_leader
  is '区域组长';
comment on column T_SUPPLIER_GROUP_CONFIG.effective_time
  is '生效时间';
comment on column T_SUPPLIER_GROUP_CONFIG.end_time
  is '结束时间';
comment on column T_SUPPLIER_GROUP_CONFIG.config_status
  is '配置是否生效（0：不生效 1 ：生效）;默认不生效';
comment on column T_SUPPLIER_GROUP_CONFIG.pause
  is '启停状态（0：停用  1：启用）；默认启用';
comment on column T_SUPPLIER_GROUP_CONFIG.remarks
  is '备注';
comment on column T_SUPPLIER_GROUP_CONFIG.create_id
  is '创建人';
comment on column T_SUPPLIER_GROUP_CONFIG.create_time
  is '创建时间';
comment on column T_SUPPLIER_GROUP_CONFIG.update_id
  is '修改人';
comment on column T_SUPPLIER_GROUP_CONFIG.update_time
  is '修改时间';
comment on column T_SUPPLIER_GROUP_CONFIG.company_id
  is '企业ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SUPPLIER_GROUP_CONFIG
  add constraint PK_GROUP_CONFIG_ID primary key (GROUP_CONFIG_ID)
  using index 
  tablespace SCMDATA
  pctfree 10
  initrans 2
  maxtrans 255;
alter index PK_GROUP_CONFIG_ID nologging;
