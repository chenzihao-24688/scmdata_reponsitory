-- Create table
create table T_SUPPLIER_GROUP_CATEGORY_CONFIG
(
  group_category_config_id   VARCHAR2(32) not null,
  company_id                 VARCHAR2(32) not null,
  group_config_id            VARCHAR2(32) not null,
  cooperation_classification VARCHAR2(32) not null,
  cooperation_product_cate   VARCHAR2(32) not null,
  pause                      NUMBER(1) default 1,
  remarks                    VARCHAR2(256),
  create_id                  VARCHAR2(32),
  create_time                DATE,
  update_id                  VARCHAR2(32),
  update_time                DATE
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
comment on table T_SUPPLIER_GROUP_CATEGORY_CONFIG
  is '所属品类';
-- Add comments to the columns 
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.group_category_config_id
  is '所属品类ID(主键)';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.company_id
  is '企业ID';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.group_config_id
  is '所属分组配置ID（外键）';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.cooperation_classification
  is '意向合作分类';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.cooperation_product_cate
  is '意向生产类别';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.pause
  is '启停状态（0：停用 1：启用）';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.remarks
  is '备注';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.create_id
  is '创建人';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.create_time
  is '创建时间';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.update_id
  is '修改人';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.update_time
  is '修改时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SUPPLIER_GROUP_CATEGORY_CONFIG
  add constraint PK_GROUP_CATEGORY_CONFIG_ID primary key (GROUP_CATEGORY_CONFIG_ID)
  using index 
  tablespace SCMDATA
  pctfree 10
  initrans 2
  maxtrans 255;
alter index PK_GROUP_CATEGORY_CONFIG_ID nologging;
alter table T_SUPPLIER_GROUP_CATEGORY_CONFIG
  add constraint FK_GROUP_CONFIG_ID foreign key (GROUP_CONFIG_ID)
  references T_SUPPLIER_GROUP_CONFIG (GROUP_CONFIG_ID);
