-- Create table
create table SYS_APP_ERROR_MSG
(
  error_id       VARCHAR2(32) not null,
  error_code     VARCHAR2(32) not null,
  error_type     VARCHAR2(300),
  error_line_num VARCHAR2(3000),
  error_msg      VARCHAR2(3000),
  create_id      VARCHAR2(32),
  create_time    DATE,
  update_id      VARCHAR2(32),
  update_time    DATE
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
comment on table SYS_APP_ERROR_MSG
  is '������Ϣ��';
-- Add comments to the columns 
comment on column SYS_APP_ERROR_MSG.error_id
  is '����ID';
comment on column SYS_APP_ERROR_MSG.error_code
  is '�������';
comment on column SYS_APP_ERROR_MSG.error_type
  is '�������ͣ�����ʱ�쳣��ҵ���쳣��';
comment on column SYS_APP_ERROR_MSG.error_line_num
  is '�����к�';
comment on column SYS_APP_ERROR_MSG.error_msg
  is '������Ϣ';
comment on column SYS_APP_ERROR_MSG.create_id
  is '������';
comment on column SYS_APP_ERROR_MSG.create_time
  is '����ʱ��';
comment on column SYS_APP_ERROR_MSG.update_id
  is '�޸���';
comment on column SYS_APP_ERROR_MSG.update_time
  is '�޸�ʱ��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_APP_ERROR_MSG
  add constraint PK_SYS_APP_ERROR_MSG primary key (ERROR_ID)
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
alter index PK_SYS_APP_ERROR_MSG nologging;
