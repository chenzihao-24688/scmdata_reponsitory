-- Create table
create table SYS_COMPANY_MSG_CONFIG
(
  company_msg_id VARCHAR2(32) not null,
  group_msg_id   VARCHAR2(32),
  company_id     VARCHAR2(32) not null,
  user_id        VARCHAR2(32) not null,
  pause          NUMBER(1) default 0 not null,
  create_time    DATE default sysdate not null,
  create_id      VARCHAR2(32),
  update_time    DATE,
  update_id      VARCHAR2(32),
  memo           VARCHAR2(200),
  tomorrow_flag  NUMBER default 0
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
comment on table SYS_COMPANY_MSG_CONFIG
  is '��ҵ��Ϣ�������ñ�';
-- Add comments to the columns 
comment on column SYS_COMPANY_MSG_CONFIG.company_msg_id
  is '����';
comment on column SYS_COMPANY_MSG_CONFIG.group_msg_id
  is 'ƽ̨���ͱ��';
comment on column SYS_COMPANY_MSG_CONFIG.company_id
  is '��ҵID';
comment on column SYS_COMPANY_MSG_CONFIG.user_id
  is 'Ա����';
comment on column SYS_COMPANY_MSG_CONFIG.pause
  is '����';
comment on column SYS_COMPANY_MSG_CONFIG.create_time
  is '����ʱ��';
comment on column SYS_COMPANY_MSG_CONFIG.create_id
  is '������';
comment on column SYS_COMPANY_MSG_CONFIG.update_time
  is '�޸�ʱ��';
comment on column SYS_COMPANY_MSG_CONFIG.update_id
  is '�޸���';
comment on column SYS_COMPANY_MSG_CONFIG.memo
  is '��ע';
comment on column SYS_COMPANY_MSG_CONFIG.tomorrow_flag
  is '�Ƿ��������ѣ�0���� 1���ǣ�';
