-- Create table
create table SCMDATA.T_SUPPLIER_GROUP
(
  id               VARCHAR2(32) not null,
  company_id       VARCHAR2(32),
  supplier_info_id VARCHAR2(32),
  group_name       VARCHAR2(32),
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
    minextents 1
    maxextents unlimited
  )
nologging;
-- Add comments to the table 
comment on table SCMDATA.T_SUPPLIER_GROUP
  is '��Ӧ�̷�������ڼ�¼�ֶ��༭���µķ��飩';
-- Add comments to the columns 
comment on column SCMDATA.T_SUPPLIER_GROUP.id
  is '����';
comment on column SCMDATA.T_SUPPLIER_GROUP.company_id
  is '��ҵID';
comment on column SCMDATA.T_SUPPLIER_GROUP.supplier_info_id
  is '��Ӧ��ID';
comment on column SCMDATA.T_SUPPLIER_GROUP.group_name
  is '����id';
comment on column SCMDATA.T_SUPPLIER_GROUP.create_id
  is '������';
comment on column SCMDATA.T_SUPPLIER_GROUP.create_time
  is '����ʱ��';
comment on column SCMDATA.T_SUPPLIER_GROUP.update_id
  is '�޸���';
comment on column SCMDATA.T_SUPPLIER_GROUP.update_time
  is '�޸�ʱ��';
comment on column SCMDATA.T_SUPPLIER_GROUP.memo
  is '��ע';
-- Create/Recreate indexes 
create index UX_T_SUPPLIER_GROUP_001 on SCMDATA.T_SUPPLIER_GROUP (SUPPLIER_INFO_ID, COMPANY_ID)
  tablespace SCMDATA
  pctfree 10
  initrans 2
  maxtrans 255
  nologging;
/
