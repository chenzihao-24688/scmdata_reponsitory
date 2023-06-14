-- Create table
create table SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE
(
  data_priv_dept_middle_id VARCHAR2(32) not null,
  company_id               VARCHAR2(32) not null,
  data_priv_group_id       VARCHAR2(32) not null,
  company_dept_id          VARCHAR2(32),
  create_id                VARCHAR2(32) not null,
  create_time              DATE not null,
  update_id                VARCHAR2(32) not null,
  update_time              DATE not null
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
comment on table SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE
  is '��ҵ����Ȩ�ޣ���-�������ã��м��';
-- Add comments to the columns 
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.data_priv_dept_middle_id
  is '����Ȩ�ޣ���-��Ա���ã�ID(����)';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.data_priv_group_id
  is '����Ȩ����ID';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.create_id
  is '������';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.create_time
  is '����ʱ��';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.update_id
  is '�޸���';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.update_time
  is '�޸�ʱ��';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.company_id
  is '��˾ID';
comment on column SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE.company_dept_id
  is '����ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE
  add constraint PK_DATA_PRIV_DEPT_MIDDLE_ID primary key (DATA_PRIV_DEPT_MIDDLE_ID)
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
alter index PK_DATA_PRIV_DEPT_MIDDLE_ID nologging;
alter table SYS_COMPANY_DATA_PRIV_DEPT_MIDDLE
  add constraint FK_PAGE_DATA_PRIV_DEPT_GROUP_ID foreign key (DATA_PRIV_GROUP_ID)
  references SYS_COMPANY_DATA_PRIV_GROUP (DATA_PRIV_GROUP_ID);
