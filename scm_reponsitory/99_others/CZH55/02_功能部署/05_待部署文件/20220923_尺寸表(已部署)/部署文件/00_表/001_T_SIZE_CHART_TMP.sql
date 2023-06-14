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
  is '�ߴ���ʱ��';
-- Add comments to the columns 
comment on column SCMDATA.T_SIZE_CHART_TMP.size_chart_tmp_id
  is '�ߴ���ʱ��ID';
comment on column SCMDATA.T_SIZE_CHART_TMP.company_id
  is '��ҵID';
comment on column SCMDATA.T_SIZE_CHART_TMP.goo_id
  is '��Ʒ�������';
comment on column SCMDATA.T_SIZE_CHART_TMP.seq_num
  is '���';
comment on column SCMDATA.T_SIZE_CHART_TMP.position
  is '��λ';
comment on column SCMDATA.T_SIZE_CHART_TMP.quantitative_method
  is '����';
comment on column SCMDATA.T_SIZE_CHART_TMP.base_code
  is '����';
comment on column SCMDATA.T_SIZE_CHART_TMP.plus_toleran_range
  is '������';
comment on column SCMDATA.T_SIZE_CHART_TMP.negative_toleran_range
  is '������';
comment on column SCMDATA.T_SIZE_CHART_TMP.pause
  is '��ͣ��0�����ã�1��ͣ�ã���Ĭ������';
comment on column SCMDATA.T_SIZE_CHART_TMP.create_id
  is '������';
comment on column SCMDATA.T_SIZE_CHART_TMP.create_time
  is '����ʱ��';
comment on column SCMDATA.T_SIZE_CHART_TMP.update_id
  is '�޸���';
comment on column SCMDATA.T_SIZE_CHART_TMP.update_time
  is '�޸�ʱ��';
comment on column SCMDATA.T_SIZE_CHART_TMP.memo
  is '��ע';
comment on column SCMDATA.T_SIZE_CHART_TMP.base_value
  is '����ֵ';
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