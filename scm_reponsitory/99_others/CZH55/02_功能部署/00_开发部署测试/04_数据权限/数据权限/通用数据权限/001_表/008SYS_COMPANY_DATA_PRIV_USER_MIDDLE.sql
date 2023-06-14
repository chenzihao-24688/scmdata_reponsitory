-- Create table
create table SYS_COMPANY_DATA_PRIV_USER_MIDDLE
(
  data_priv_user_middle_id VARCHAR2(32) not null,
  company_id               VARCHAR2(32) not null,
  data_priv_group_id       VARCHAR2(32) not null,
  user_id                  VARCHAR2(32) not null,
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
comment on table SYS_COMPANY_DATA_PRIV_USER_MIDDLE
  is '��ҵ����Ȩ�ޣ���-��Ա���ã��м��';
-- Add comments to the columns 
comment on column SYS_COMPANY_DATA_PRIV_USER_MIDDLE.data_priv_user_middle_id
  is '����Ȩ�ޣ���-��Ա���ã�ID(����)';
comment on column SYS_COMPANY_DATA_PRIV_USER_MIDDLE.data_priv_group_id
  is '����Ȩ����ID';
comment on column SYS_COMPANY_DATA_PRIV_USER_MIDDLE.user_id
  is '��ԱID';
comment on column SYS_COMPANY_DATA_PRIV_USER_MIDDLE.create_id
  is '������';
comment on column SYS_COMPANY_DATA_PRIV_USER_MIDDLE.create_time
  is '����ʱ��';
comment on column SYS_COMPANY_DATA_PRIV_USER_MIDDLE.update_id
  is '�޸���';
comment on column SYS_COMPANY_DATA_PRIV_USER_MIDDLE.update_time
  is '�޸�ʱ��';
comment on column SYS_COMPANY_DATA_PRIV_USER_MIDDLE.company_id
  is '��˾ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_DATA_PRIV_USER_MIDDLE
  add constraint PK_DATA_PRIV_USER_MIDDLE_ID primary key (DATA_PRIV_USER_MIDDLE_ID)
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
alter index PK_DATA_PRIV_USER_MIDDLE_ID nologging;
alter table SYS_COMPANY_DATA_PRIV_USER_MIDDLE
  add constraint FK_PAGE_DATA_PRIV_USER_GROUP_ID foreign key (DATA_PRIV_GROUP_ID)
  references SYS_COMPANY_DATA_PRIV_GROUP (DATA_PRIV_GROUP_ID);
