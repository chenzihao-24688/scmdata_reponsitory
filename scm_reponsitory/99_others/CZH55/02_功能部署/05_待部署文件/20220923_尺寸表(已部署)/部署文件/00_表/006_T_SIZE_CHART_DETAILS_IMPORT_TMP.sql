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
  is '�ߴ絼��������룩';
-- Add comments to the columns 
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.size_chart_dt_tmp_id
  is '�ߴ絼���ID(������)';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.size_chart_id
  is '�ߴ絼���ID';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.measure
  is '���루������Ӧ����ҵ�ֵ�ID��';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.measure_value
  is '����ֵ';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.pause
  is '��ͣ��0�����ã�1��ͣ�ã���Ĭ������';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.create_id
  is '������';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.create_time
  is '����ʱ��';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.update_id
  is '�޸���';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.update_time
  is '�޸�ʱ��';
comment on column SCMDATA.T_SIZE_CHART_DETAILS_IMPORT_TMP.memo
  is '��ע';
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
