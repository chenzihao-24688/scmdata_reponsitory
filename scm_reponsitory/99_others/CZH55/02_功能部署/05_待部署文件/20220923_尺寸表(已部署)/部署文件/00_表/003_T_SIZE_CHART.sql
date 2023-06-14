-- Create table
create table SCMDATA.T_SIZE_CHART
(
  size_chart_id          VARCHAR2(32) not null,
  company_id             VARCHAR2(32) not null,
  goo_id                 VARCHAR2(32) not null,
  seq_num                NUMBER,
  position               VARCHAR2(256) not null,
  quantitative_method    VARCHAR2(512) not null,
  base_code              VARCHAR2(32),
  base_value             NUMBER,
  plus_toleran_range     NUMBER not null,
  negative_toleran_range NUMBER not null,
  pause                  NUMBER default 0 not null,
  create_id              VARCHAR2(32) not null,
  create_time            DATE not null,
  update_id              VARCHAR2(32) not null,
  update_time            DATE not null,
  memo                   VARCHAR2(256)
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
comment on table SCMDATA.T_SIZE_CHART
  is '尺寸表';
-- Add comments to the columns 
comment on column SCMDATA.T_SIZE_CHART.size_chart_id
  is '尺寸表ID';
comment on column SCMDATA.T_SIZE_CHART.company_id
  is '企业ID';
comment on column SCMDATA.T_SIZE_CHART.goo_id
  is '商品档案编号';
comment on column SCMDATA.T_SIZE_CHART.seq_num
  is '序号';
comment on column SCMDATA.T_SIZE_CHART.position
  is '部位';
comment on column SCMDATA.T_SIZE_CHART.quantitative_method
  is '量法';
comment on column SCMDATA.T_SIZE_CHART.base_code
  is '基码';
comment on column SCMDATA.T_SIZE_CHART.base_value
  is '基码值';
comment on column SCMDATA.T_SIZE_CHART.plus_toleran_range
  is '正公差';
comment on column SCMDATA.T_SIZE_CHART.negative_toleran_range
  is '负公差';
comment on column SCMDATA.T_SIZE_CHART.pause
  is '启停（0：启用，1：停用），默认启用';
comment on column SCMDATA.T_SIZE_CHART.create_id
  is '创建人';
comment on column SCMDATA.T_SIZE_CHART.create_time
  is '创建时间';
comment on column SCMDATA.T_SIZE_CHART.update_id
  is '修改人';
comment on column SCMDATA.T_SIZE_CHART.update_time
  is '修改时间';
comment on column SCMDATA.T_SIZE_CHART.memo
  is '备注';
-- Create/Recreate indexes 
create index SCMDATA.UX_SIZE_CHART_001 on SCMDATA.T_SIZE_CHART (GOO_ID, COMPANY_ID)
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
  )
  nologging;
-- Create/Recreate primary, unique and foreign key constraints 
alter table SCMDATA.T_SIZE_CHART
  add constraint PK_SIZE_CHART_ID primary key (SIZE_CHART_ID)
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
alter index SCMDATA.PK_SIZE_CHART_ID nologging;
/
