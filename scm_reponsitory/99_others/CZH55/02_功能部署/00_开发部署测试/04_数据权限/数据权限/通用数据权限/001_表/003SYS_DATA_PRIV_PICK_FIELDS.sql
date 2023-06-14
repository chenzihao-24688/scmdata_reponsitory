-- Create table
create table SYS_DATA_PRIV_PICK_FIELDS
(
  data_priv_pick_field_id VARCHAR2(32) not null,
  data_priv_id            VARCHAR2(32) not null,
  create_id               VARCHAR2(32) not null,
  create_time             DATE not null,
  update_id               VARCHAR2(32) not null,
  update_time             DATE not null,
  col_1                   VARCHAR2(256),
  col_2                   VARCHAR2(256),
  col_3                   VARCHAR2(256),
  col_4                   VARCHAR2(256),
  col_5                   VARCHAR2(256),
  col_6                   VARCHAR2(256),
  col_7                   VARCHAR2(256),
  col_8                   VARCHAR2(256),
  col_9                   VARCHAR2(256),
  col_10                  VARCHAR2(256)
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
comment on table SYS_DATA_PRIV_PICK_FIELDS
  is '����Ȩ��PICK�ֶα�';
-- Add comments to the columns 
comment on column SYS_DATA_PRIV_PICK_FIELDS.data_priv_pick_field_id
  is '����Ȩ���ֶ�ID��������';
comment on column SYS_DATA_PRIV_PICK_FIELDS.data_priv_id
  is '����Ȩ��ID';
comment on column SYS_DATA_PRIV_PICK_FIELDS.create_id
  is '������';
comment on column SYS_DATA_PRIV_PICK_FIELDS.create_time
  is '����ʱ��';
comment on column SYS_DATA_PRIV_PICK_FIELDS.update_id
  is '�޸���';
comment on column SYS_DATA_PRIV_PICK_FIELDS.update_time
  is '�޸�ʱ��';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_1
  is '�ֶ�1';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_2
  is '�ֶ�2';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_3
  is '�ֶ�3';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_4
  is '�ֶ�4';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_5
  is '�ֶ�5';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_6
  is '�ֶ�6';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_7
  is '�ֶ�7';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_8
  is '�ֶ�8';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_9
  is '�ֶ�9';
comment on column SYS_DATA_PRIV_PICK_FIELDS.col_10
  is '�ֶ�10';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_DATA_PRIV_PICK_FIELDS
  add constraint PK_DATA_PRIV_PICK_FIELD_ID primary key (DATA_PRIV_PICK_FIELD_ID)
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
alter index PK_DATA_PRIV_PICK_FIELD_ID nologging;
alter table SYS_DATA_PRIV_PICK_FIELDS
  add constraint FK_FIELD_DATA_PRIV_PICK_ID foreign key (DATA_PRIV_ID)
  references SYS_DATA_PRIVS (DATA_PRIV_ID);
