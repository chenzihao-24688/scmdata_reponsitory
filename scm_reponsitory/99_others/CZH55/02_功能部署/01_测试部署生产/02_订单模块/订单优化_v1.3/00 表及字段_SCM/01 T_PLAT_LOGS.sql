-- Create table
create table T_PLAT_LOGS
(
  logs_id       VARCHAR2(32) not null,
  log_id        VARCHAR2(32) not null,
  company_id    VARCHAR2(32) not null,
  operate_field VARCHAR2(1000),
  old_value     VARCHAR2(1000),
  new_value     VARCHAR2(1000),
  create_id     VARCHAR2(32),
  create_time   DATE,
  update_id     VARCHAR2(32),
  update_time   DATE,
  memo          VARCHAR2(256),
  field_type    VARCHAR2(32),
  field_desc    VARCHAR2(32),
  old_code      VARCHAR2(256),
  new_code      VARCHAR2(256),
  seq_no        NUMBER,
  log_reason    VARCHAR2(4000)
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
comment on table T_PLAT_LOGS
  is 'ƽ̨������־��ϸ';
-- Add comments to the columns 
comment on column T_PLAT_LOGS.logs_id
  is '��־��ϸID';
comment on column T_PLAT_LOGS.log_id
  is '��־ID';
comment on column T_PLAT_LOGS.company_id
  is '��ҵID';
comment on column T_PLAT_LOGS.operate_field
  is '�����ֶ�';
comment on column T_PLAT_LOGS.old_value
  is '��ֵ';
comment on column T_PLAT_LOGS.new_value
  is '��ֵ';
comment on column T_PLAT_LOGS.create_id
  is '������';
comment on column T_PLAT_LOGS.create_time
  is '����ʱ��';
comment on column T_PLAT_LOGS.update_id
  is '�޸���';
comment on column T_PLAT_LOGS.update_time
  is '�޸�ʱ��';
comment on column T_PLAT_LOGS.memo
  is '��ע';
comment on column T_PLAT_LOGS.field_type
  is '�ֶ�����';
comment on column T_PLAT_LOGS.field_desc
  is '�ֶ�����';
comment on column T_PLAT_LOGS.old_code
  is '��ֵ����';
comment on column T_PLAT_LOGS.new_code
  is '��ֵ����';
comment on column T_PLAT_LOGS.seq_no
  is '���';
comment on column T_PLAT_LOGS.log_reason
  is '����ԭ��';
-- Create/Recreate indexes 
create index IX_T_PLAT_LOGS_01 on T_PLAT_LOGS (LOG_ID, COMPANY_ID)
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
  )
  nologging;
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_PLAT_LOGS
  add constraint PK_LOGS_ID primary key (LOGS_ID)
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
alter index PK_LOGS_ID nologging;
