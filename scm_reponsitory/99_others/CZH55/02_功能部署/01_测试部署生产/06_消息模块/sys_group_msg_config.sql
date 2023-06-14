-- Create table
create table SYS_GROUP_MSG_CONFIG
(
  group_msg_id   VARCHAR2(32) not null,
  group_msg_name VARCHAR2(50) not null,
  apply_id       VARCHAR2(32),
  pause          NUMBER(1) default 0 not null,
  create_time    DATE,
  create_id      VARCHAR2(32),
  update_time    DATE,
  update_id      VARCHAR2(32),
  config_id      VARCHAR2(32),
  memo           VARCHAR2(200),
  config_type    VARCHAR2(32)
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
comment on table SYS_GROUP_MSG_CONFIG
  is 'ƽ̨��Ϣ�������ñ�';
-- Add comments to the columns 
comment on column SYS_GROUP_MSG_CONFIG.group_msg_id
  is '����';
comment on column SYS_GROUP_MSG_CONFIG.group_msg_name
  is '��Ϣ�������';
comment on column SYS_GROUP_MSG_CONFIG.apply_id
  is 'Ӧ��ID ';
comment on column SYS_GROUP_MSG_CONFIG.pause
  is '����';
comment on column SYS_GROUP_MSG_CONFIG.create_time
  is '����ʱ��';
comment on column SYS_GROUP_MSG_CONFIG.create_id
  is '������';
comment on column SYS_GROUP_MSG_CONFIG.update_time
  is '�޸�ʱ��';
comment on column SYS_GROUP_MSG_CONFIG.update_id
  is '�޸���';
comment on column SYS_GROUP_MSG_CONFIG.config_id
  is '����ID(SYS_HINT.HINT_ID�� MSG_INFO ID)';
comment on column SYS_GROUP_MSG_CONFIG.memo
  is '��ע';
comment on column SYS_GROUP_MSG_CONFIG.config_type
  is '��������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_GROUP_MSG_CONFIG
  add constraint PK_SYS_GROUP_MSG_CONFIG primary key (GROUP_MSG_ID)
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
alter index PK_SYS_GROUP_MSG_CONFIG nologging;
