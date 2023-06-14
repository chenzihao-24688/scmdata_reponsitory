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
  is '�ߴ�������룩';
-- Add comments to the columns 
comment on column SCMDATA.T_SIZE_CHART_DETAILS.size_chart_dt_id
  is '�ߴ��ID(������)';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.size_chart_id
  is '�ߴ��ID';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.measure
  is '����';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.measure_value
  is '����ֵ';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.pause
  is '��ͣ��0�����ã�1��ͣ�ã���Ĭ������';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.create_id
  is '������';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.create_time
  is '����ʱ��';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.update_id
  is '�޸���';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.update_time
  is '�޸�ʱ��';
comment on column SCMDATA.T_SIZE_CHART_DETAILS.memo
  is '��ע';
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
