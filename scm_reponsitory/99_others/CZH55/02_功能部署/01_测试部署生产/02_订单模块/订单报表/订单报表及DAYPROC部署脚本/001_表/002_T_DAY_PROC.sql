-- Create table
create table T_DAY_PROC
(
  day_proc_id   VARCHAR2(32) not null,
  seqno         NUMBER(5) not null,
  proc_sql      CLOB,
  proc_time     DATE,
  seconds       NUMBER(10),
  pause         NUMBER(1),
  proc_end_time DATE,
  proc_name     VARCHAR2(48),
  remarks       VARCHAR2(4000)
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
comment on table T_DAY_PROC
  is '��ʱ��������ִ�б�';
-- Add comments to the columns 
comment on column T_DAY_PROC.day_proc_id
  is '����ID';
comment on column T_DAY_PROC.seqno
  is '�����';
comment on column T_DAY_PROC.proc_sql
  is '����ִ��sql';
comment on column T_DAY_PROC.proc_time
  is 'ִ�п�ʼʱ��';
comment on column T_DAY_PROC.seconds
  is 'ִ��ʱ��';
comment on column T_DAY_PROC.pause
  is '�Ƿ���ã�1������ 0�����ã�';
comment on column T_DAY_PROC.proc_end_time
  is 'ִ�н���ʱ��';
comment on column T_DAY_PROC.proc_name
  is '��������';
comment on column T_DAY_PROC.remarks
  is '��ע';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_DAY_PROC
  add constraint PK_DAY_PROC primary key (DAY_PROC_ID)
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
alter index PK_DAY_PROC nologging;
alter table T_DAY_PROC
  add constraint U_SEQNO unique (SEQNO)
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
alter index U_SEQNO nologging;
