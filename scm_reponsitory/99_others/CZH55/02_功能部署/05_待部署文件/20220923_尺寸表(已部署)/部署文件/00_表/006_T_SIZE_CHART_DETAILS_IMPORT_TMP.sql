-- Create table
create table SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP
(
  size_chart_dt_tmp_id VARCHAR2(32) not null,
  size_chart_id        VARCHAR2(32) not null,
  measure              VARCHAR2(32),
  measure_value        NUMBER,
  pause                NUMBER default 0,
  create_id            VARCHAR2(32),
  create_time          DATE,
  update_id            VARCHAR2(32),
  update_time          DATE,
  memo                 VARCHAR2(256)
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
comment on table SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP
  is '尺寸导入表（含尺码）';
-- Add comments to the columns 
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.size_chart_dt_tmp_id
  is '尺寸导入表ID(含尺码)';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.size_chart_id
  is '尺寸导入表ID';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.measure
  is '尺码（存尺码对应的企业字典ID）';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.measure_value
  is '尺码值';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.pause
  is '启停（0：启用，1：停用），默认启用';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.create_id
  is '创建人';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.create_time
  is '创建时间';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.update_id
  is '修改人';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.update_time
  is '修改时间';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.memo
  is '备注';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP
  add constraint PK_SIZE_CHART_DT_IMP_TMP_ID primary key (SIZE_CHART_DT_TMP_ID)
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
alter index SCMDATA.PK_SIZE_CHART_DT_IMP_TMP_ID nologging;
/
