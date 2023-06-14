-- Create table
create table SYS_DATA_PRIV_LOOKUP_FIELDS
(
  data_priv_lookup_field_id VARCHAR2(32) not null,
  data_priv_id              VARCHAR2(32) not null,
  create_id                 VARCHAR2(32) not null,
  create_time               DATE not null,
  update_id                 VARCHAR2(32) not null,
  update_time               DATE not null,
  col_11                    VARCHAR2(256)
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
comment on table SYS_DATA_PRIV_LOOKUP_FIELDS
  is '����Ȩ��LOOKUP�ֶα�';
-- Add comments to the columns 
comment on column SYS_DATA_PRIV_LOOKUP_FIELDS.data_priv_lookup_field_id
  is '����Ȩ���ֶ�ID��������';
comment on column SYS_DATA_PRIV_LOOKUP_FIELDS.data_priv_id
  is '����Ȩ��ID';
comment on column SYS_DATA_PRIV_LOOKUP_FIELDS.create_id
  is '������';
comment on column SYS_DATA_PRIV_LOOKUP_FIELDS.create_time
  is '����ʱ��';
comment on column SYS_DATA_PRIV_LOOKUP_FIELDS.update_id
  is '�޸���';
comment on column SYS_DATA_PRIV_LOOKUP_FIELDS.update_time
  is '�޸�ʱ��';
comment on column SYS_DATA_PRIV_LOOKUP_FIELDS.col_11
  is '�ֶ�11';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_DATA_PRIV_LOOKUP_FIELDS
  add constraint PK_DATA_PRIV_PICK_LOOKUP_ID primary key (DATA_PRIV_LOOKUP_FIELD_ID)
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
alter index PK_DATA_PRIV_PICK_LOOKUP_ID nologging;
alter table SYS_DATA_PRIV_LOOKUP_FIELDS
  add constraint FK_FIELD_DATA_PRIV_LOOKUP_ID foreign key (DATA_PRIV_ID)
  references SYS_DATA_PRIVS (DATA_PRIV_ID);
