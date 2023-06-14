-- Create table
create table SYS_COMPANY_DATA_PRIV_GROUP
(
  data_priv_group_id   VARCHAR2(32) not null,
  data_priv_group_code VARCHAR2(32) not null,
  data_priv_group_name VARCHAR2(48) not null,
  company_id           VARCHAR2(32) not null,
  user_id              VARCHAR2(32),
  seq_no               NUMBER,
  create_id            VARCHAR2(32) not null,
  create_time          DATE not null,
  update_id            VARCHAR2(32) not null,
  update_time          DATE not null
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
comment on table SYS_COMPANY_DATA_PRIV_GROUP
  is '��ҵ����Ȩ����';
-- Add comments to the columns 
comment on column SYS_COMPANY_DATA_PRIV_GROUP.data_priv_group_id
  is '����Ȩ����ID��������';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.data_priv_group_code
  is '����Ȩ�������';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.data_priv_group_name
  is '����Ȩ��������';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.company_id
  is '��˾ID';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.user_id
  is 'Ա��ID';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.seq_no
  is '���';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.create_id
  is '������';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.create_time
  is '����ʱ��';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.update_id
  is '�޸���';
comment on column SYS_COMPANY_DATA_PRIV_GROUP.update_time
  is '�޸�ʱ��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_DATA_PRIV_GROUP
  add constraint PK_DATA_PRIV_GROUP_ID primary key (DATA_PRIV_GROUP_ID)
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
alter index PK_DATA_PRIV_GROUP_ID nologging;
