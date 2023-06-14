-- Create table
create table SYS_DATA_PRIVS
(
  data_priv_id         VARCHAR2(32) not null,
  data_priv_code       VARCHAR2(32) not null,
  data_priv_name       VARCHAR2(48) not null,
  seq_no               NUMBER,
  level_type           VARCHAR2(32) not null,
  fields_config_method VARCHAR2(32),
  pause                NUMBER default 1,
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
comment on table SYS_DATA_PRIVS
  is '����Ȩ��';
-- Add comments to the columns 
comment on column SYS_DATA_PRIVS.data_priv_id
  is '����Ȩ��ID��������';
comment on column SYS_DATA_PRIVS.data_priv_code
  is '����Ȩ�ޱ���';
comment on column SYS_DATA_PRIVS.data_priv_name
  is '����Ȩ������';
comment on column SYS_DATA_PRIVS.seq_no
  is '���';
comment on column SYS_DATA_PRIVS.level_type
  is '�㼶���ͣ����ڣ��ֲ����ֿ�ȣ����ֵ��ṩ';
comment on column SYS_DATA_PRIVS.create_id
  is '������';
comment on column SYS_DATA_PRIVS.create_time
  is '����ʱ��';
comment on column SYS_DATA_PRIVS.update_id
  is '�޸���';
comment on column SYS_DATA_PRIVS.update_time
  is '�޸�ʱ��';
comment on column SYS_DATA_PRIVS.fields_config_method
  is '�ֶ����÷�ʽ';
comment on column SYS_DATA_PRIVS.pause
  is '��ͣ��0��ͣ�� 1�����ã�';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_DATA_PRIVS
  add constraint PK_DATA_PRIV_ID primary key (DATA_PRIV_ID)
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
alter index PK_DATA_PRIV_ID nologging;
