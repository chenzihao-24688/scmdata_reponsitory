-- Create table
create table MRP.RECOMMEND_MATERIAL_RESULT
(
  recommend_material_id            VARCHAR2(32) not null,
  examine_price_id                 VARCHAR2(32) not null,
  examine_price_material_detail_id VARCHAR2(32) not null,
  material_sku                     VARCHAR2(32),
  recommend                        NUMBER(6,2)
)
tablespace MRPDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table MRP.RECOMMEND_MATERIAL_RESULT
  is '推荐物料结果临时表';
-- Add comments to the columns 
comment on column MRP.RECOMMEND_MATERIAL_RESULT.recommend_material_id
  is '推荐物料主键';
comment on column MRP.RECOMMEND_MATERIAL_RESULT.examine_price_id
  is '核价单ID';
comment on column MRP.RECOMMEND_MATERIAL_RESULT.examine_price_material_detail_id
  is '核价物料明细ID';
comment on column MRP.RECOMMEND_MATERIAL_RESULT.material_sku
  is '推荐物料SKU';
comment on column MRP.RECOMMEND_MATERIAL_RESULT.recommend
  is '推荐度';
-- Create/Recreate indexes 
create index MRP.IX_RECOMMEND_MATERIAL_RESULT_001 on MRP.RECOMMEND_MATERIAL_RESULT (EXAMINE_PRICE_ID)
  tablespace MRPDATA
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table MRP.RECOMMEND_MATERIAL_RESULT
  add constraint PK_RECOMMEND_MATERIAL_ID primary key (RECOMMEND_MATERIAL_ID)
  using index 
  tablespace MRPDATA
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
-- Grant/Revoke object privileges 
grant select, insert, update, delete, references, alter, index, debug, read on MRP.RECOMMEND_MATERIAL_RESULT to PLM;
