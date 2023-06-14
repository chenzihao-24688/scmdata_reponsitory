-- Create table
create table MDMDATA.T_SUPPLIER_COOP_ITF
(
  itf_id                        VARCHAR2(32) not null,
  supplier_code                 VARCHAR2(32),
  sup_name                      VARCHAR2(100),
  coop_classification_num       VARCHAR2(100),
  cooperation_classification_sp VARCHAR2(100),
  coop_product_cate_num         VARCHAR2(100),
  cooperation_product_cate_sp   VARCHAR2(100),
  data_status                   VARCHAR2(32),
  create_id                     VARCHAR2(32),
  create_time                   DATE,
  update_id                     VARCHAR2(32),
  update_time                   DATE,
  publish_id                    VARCHAR2(32),
  publish_time                  DATE,
  fetch_flag                    NUMBER default 0,
  fetch_time                    DATE,
  coop_scope_id                 VARCHAR2(32) not null,
  pause                         NUMBER
)
tablespace MDMDATA
nologging;
comment on table MDMDATA.T_SUPPLIER_COOP_ITF is '供应商-合作范围接口表';
-- Add comments to the columns 
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.itf_id
  is '接口编号，主键';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.supplier_code
  is '供应商档案编号（scm）';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.sup_name
  is '供应商名称';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.coop_classification_num
  is '合作分类编号';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.cooperation_classification_sp
  is '合作分类';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.coop_product_cate_num
  is '生产类别编号';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.cooperation_product_cate_sp
  is '生产类别';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.data_status
  is '数据状态（新增、更新）';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.create_id
  is '创建人';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.create_time
  is '创建时间';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.update_id
  is '修改人';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.update_time
  is '修改时间';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.publish_id
  is '发布人';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.publish_time
  is '发布时间';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.fetch_flag
  is 'scm获取标识';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.fetch_time
  is '获取时间';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.coop_scope_id
  is '合作范围主键';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.pause
  is '启停状态';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MDMDATA.T_SUPPLIER_COOP_ITF
  add constraint PK_T_SUPPLIER_COOP_ITF_ID primary key (ITF_ID)
  using index 
  tablespace MDMDATA;
alter index MDMDATA.PK_T_SUPPLIER_COOP_ITF_ID nologging;
