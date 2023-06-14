-- Create table
create table T_COOP_FACTORY
(
  coop_factory_id  VARCHAR2(32) not null,
  company_id       VARCHAR2(32) not null,
  supplier_info_id VARCHAR2(32) not null,
  fac_sup_info_id  VARCHAR2(32) not null,
  factory_code     VARCHAR2(32) not null,
  factory_name     VARCHAR2(256) not null,
  factory_type     VARCHAR2(32) not null,
  pause            NUMBER(1) default 0 not null,
  create_id        VARCHAR2(32) not null,
  create_time      DATE not null,
  update_id        VARCHAR2(32) not null,
  update_time      DATE not null,
  memo             VARCHAR2(256)
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
comment on table T_COOP_FACTORY
  is '合作工厂表';
-- Add comments to the columns 
comment on column T_COOP_FACTORY.coop_factory_id
  is 'ID';
comment on column T_COOP_FACTORY.company_id
  is '企业ID';
comment on column T_COOP_FACTORY.factory_code
  is '工厂编码（供应商档案编号）';
comment on column T_COOP_FACTORY.factory_name
  is '工厂名称';
comment on column T_COOP_FACTORY.factory_type
  is '工厂类型';
comment on column T_COOP_FACTORY.pause
  is '启停：0 启用 , 1 停用';
comment on column T_COOP_FACTORY.create_id
  is '创建人';
comment on column T_COOP_FACTORY.create_time
  is '创建时间';
comment on column T_COOP_FACTORY.update_id
  is '修改人';
comment on column T_COOP_FACTORY.update_time
  is '修改时间';
comment on column T_COOP_FACTORY.memo
  is '备注';
comment on column T_COOP_FACTORY.supplier_info_id
  is '供应商ID（关联外键）';
comment on column T_COOP_FACTORY.fac_sup_info_id
  is '工厂所对应的供应商ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_COOP_FACTORY
  add constraint PK_COOP_FACTORY_ID primary key (COOP_FACTORY_ID)
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
alter index PK_COOP_FACTORY_ID nologging;
