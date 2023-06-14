-- Create table
create table SCMDATA.T_SIZE_CHART_DETAILS
(
  size_chart_dt_id VARCHAR2(32) not null,
  size_chart_id    VARCHAR2(32) not null,
  measure          VARCHAR2(32),
  measure_value    NUMBER,
  pause            NUMBER default 0,
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
    next 1M
    minextents 1
    maxextents unlimited
  )
nologging;
-- Add comments to the table 
comment on table SCMDATA.T_SIZE_CHART_DETAILS
  is '尺寸表（含尺码）';
-- Add comments to the columns 
comment on column SCMDATA.T_SIZE_CHART_DETAILS.size_chart_dt_id
  is '尺寸表ID(含尺码)';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.size_chart_id
  is '尺寸表ID';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.measure
  is '尺码';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.measure_value
  is '尺码值';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.pause
  is '启停（0：启用，1：停用），默认启用';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.create_id
  is '创建人';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.create_time
  is '创建时间';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.update_id
  is '修改人';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.update_time
  is '修改时间';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.memo
  is '备注';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SCMDATA.T_SIZE_CHART_DETAILS
  add constraint PK_SIZE_CHART_DT_ID primary key (SIZE_CHART_DT_ID)
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
alter index SCMDATA.PK_SIZE_CHART_DT_ID nologging;
/
