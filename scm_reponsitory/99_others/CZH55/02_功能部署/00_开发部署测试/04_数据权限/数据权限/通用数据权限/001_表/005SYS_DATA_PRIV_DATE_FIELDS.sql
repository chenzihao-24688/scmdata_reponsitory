-- Create table
create table SYS_DATA_PRIV_DATE_FIELDS
(
  data_priv_date_field_id VARCHAR2(32) not null,
  data_priv_id            VARCHAR2(32) not null,
  create_id               VARCHAR2(32) not null,
  create_time             DATE not null,
  update_id               VARCHAR2(32) not null,
  update_time             DATE not null,
  col_21                  VARCHAR2(256),
  col_22                  VARCHAR2(256)
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
comment on table SYS_DATA_PRIV_DATE_FIELDS
  is '����Ȩ��DATE�ֶα�';
-- Add comments to the columns 
comment on column SYS_DATA_PRIV_DATE_FIELDS.data_priv_date_field_id
  is '����Ȩ���ֶ�ID��������';
comment on column SYS_DATA_PRIV_DATE_FIELDS.data_priv_id
  is '����Ȩ��ID';
comment on column SYS_DATA_PRIV_DATE_FIELDS.create_id
  is '������';
comment on column SYS_DATA_PRIV_DATE_FIELDS.create_time
  is '����ʱ��';
comment on column SYS_DATA_PRIV_DATE_FIELDS.update_id
  is '�޸���';
comment on column SYS_DATA_PRIV_DATE_FIELDS.update_time
  is '�޸�ʱ��';
comment on column SYS_DATA_PRIV_DATE_FIELDS.col_21
  is '�ֶ�21';
comment on column SYS_DATA_PRIV_DATE_FIELDS.col_22
  is '�ֶ�22';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_DATA_PRIV_DATE_FIELDS
  add constraint PK_DATA_PRIV_PICK_DATE_ID primary key (DATA_PRIV_DATE_FIELD_ID)
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
alter index PK_DATA_PRIV_PICK_DATE_ID nologging;
alter table SYS_DATA_PRIV_DATE_FIELDS
  add constraint FK_FIELD_DATA_PRIV_DATE_ID foreign key (DATA_PRIV_ID)
  references SYS_DATA_PRIVS (DATA_PRIV_ID);
