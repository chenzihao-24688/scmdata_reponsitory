-- Create table
create table SCMDATA.T_SIZE_CHART_IMPORT_TMP
(
  size_chart_tmp_id      VARCHAR2(32) not null,
  company_id             VARCHAR2(32) not null,
  goo_id                 VARCHAR2(32) not null,
  seq_num                NUMBER,
  position               VARCHAR2(256),
  quantitative_method    VARCHAR2(512),
  base_code              VARCHAR2(32),
  plus_toleran_range     NUMBER,
  negative_toleran_range NUMBER,
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
comment on table SCMDATA.T_SIZE_CHART_IMPORT_TMP
  is '�ߴ絼���';
-- Add comments to the columns 
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.size_chart_tmp_id
  is '�ߴ絼���ID';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.company_id
  is '��ҵID';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.goo_id
  is '��Ʒ�������';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.seq_num
  is '���';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.position
  is '��λ';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.quantitative_method
  is '����';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.base_code
  is '����';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.plus_toleran_range
  is '������';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.negative_toleran_range
  is '������';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.pause
  is '��ͣ��0�����ã�1��ͣ�ã���Ĭ������';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.create_id
  is '������';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.create_time
  is '����ʱ��';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.update_id
  is '�޸���';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.update_time
  is '�޸�ʱ��';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.memo
  is '��ע';
comment on column SCMDATA.T_SIZE_CHART_IMPORT_TMP.base_value
  is '����ֵ';
-- Create/Recreate indexes 
create index SCMDATA.UX_SIZE_CHART_IMP_TMP_001 on SCMDATA.T_SIZE_CHART_IMPORT_TMP (GOO_ID, COMPANY_ID)
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
alter table SCMDATA.T_SIZE_CHART_IMPORT_TMP
  add constraint PK_SIZE_CHART_IMP_TMP_ID primary key (SIZE_CHART_TMP_ID)
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
alter index SCMDATA.PK_SIZE_CHART_IMP_TMP_ID nologging;
/
