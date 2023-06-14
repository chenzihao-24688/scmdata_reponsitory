-- Create table
create table SCMDATA.T_SIZE_CHART_TMP
(
  size_chart_tmp_id      VARCHAR2(32) not null,
  company_id             VARCHAR2(32) not null,
  goo_id                 VARCHAR2(32) not null,
  seq_num                NUMBER,
  position               VARCHAR2(256) not null,
  quantitative_method    VARCHAR2(512) not null,
  base_code              VARCHAR2(32) not null,
  plus_toleran_range     NUMBER not null,
  negative_toleran_range NUMBER not null,
  pause                  NUMBER default 0,
  create_id              VARCHAR2(32),
  create_time            DATE,
  update_id              VARCHAR2(32),
  update_time            DATE,
  memo                   VARCHAR2(256),
  base_value             NUMBER
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
comment on table SCMDATA.T_SIZE_CHART_TMP
  is '尺寸临时表';
-- Add comments to the columns 
comment on column SCMDATA.T_SIZE_CHART_TMP.size_chart_tmp_id
  is '尺寸临时表ID';
comment on column SCMDATA.T_SIZE_CHART_TMP.company_id
  is '企业ID';
comment on column SCMDATA.T_SIZE_CHART_TMP.goo_id
  is '商品档案编号';
comment on column SCMDATA.T_SIZE_CHART_TMP.seq_num
  is '序号';
comment on column SCMDATA.T_SIZE_CHART_TMP.position
  is '部位';
comment on column SCMDATA.T_SIZE_CHART_TMP.quantitative_method
  is '量法';
comment on column SCMDATA.T_SIZE_CHART_TMP.base_code
  is '基码';
comment on column SCMDATA.T_SIZE_CHART_TMP.plus_toleran_range
  is '正公差';
comment on column SCMDATA.T_SIZE_CHART_TMP.negative_toleran_range
  is '负公差';
comment on column SCMDATA.T_SIZE_CHART_TMP.pause
  is '启停（0：启用，1：停用），默认启用';
comment on column SCMDATA.T_SIZE_CHART_TMP.create_id
  is '创建人';
comment on column SCMDATA.T_SIZE_CHART_TMP.create_time
  is '创建时间';
comment on column SCMDATA.T_SIZE_CHART_TMP.update_id
  is '修改人';
comment on column SCMDATA.T_SIZE_CHART_TMP.update_time
  is '修改时间';
comment on column SCMDATA.T_SIZE_CHART_TMP.memo
  is '备注';
comment on column SCMDATA.T_SIZE_CHART_TMP.base_value
  is '基码值';
-- Create/Recreate indexes 
create index SCMDATA.UX_SIZE_CHART_TMP_001 on SCMDATA.T_SIZE_CHART_TMP (GOO_ID, COMPANY_ID)
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
alter table SCMDATA.T_SIZE_CHART_TMP
  add constraint PK_SIZE_CHART_TMP_ID primary key (SIZE_CHART_TMP_ID)
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
alter index SCMDATA.PK_SIZE_CHART_TMP_ID nologging;
/