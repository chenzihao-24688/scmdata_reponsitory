--drop table
drop table  scmdata.T_SUPPLIER_INFO_CTL;
/
-- Create table
create table T_SUPPLIER_INFO_CTL
(
  ctl_id       VARCHAR2(32) not null,
  itf_id       VARCHAR2(32) not null,
  itf_type     VARCHAR2(32) not null,
  batch_id     VARCHAR2(32),
  batch_num    NUMBER,
  batch_time   VARCHAR2(32),
  sender       VARCHAR2(32),
  receiver     VARCHAR2(32),
  send_time    DATE,
  receive_time DATE,
  return_type  VARCHAR2(32),
  return_msg   VARCHAR2(256)
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
-- Add comments to the columns 
comment on column T_SUPPLIER_INFO_CTL.ctl_id
  is '�ӿڼ�ر�ţ�����';
comment on column T_SUPPLIER_INFO_CTL.itf_id
  is '�ӿڱ��';
comment on column T_SUPPLIER_INFO_CTL.itf_type
  is '�ӿ�����';
comment on column T_SUPPLIER_INFO_CTL.batch_id
  is '���α��';
comment on column T_SUPPLIER_INFO_CTL.batch_num
  is '����';
comment on column T_SUPPLIER_INFO_CTL.batch_time
  is '����ʱ��';
comment on column T_SUPPLIER_INFO_CTL.sender
  is '���ͷ�';
comment on column T_SUPPLIER_INFO_CTL.receiver
  is '���շ�';
comment on column T_SUPPLIER_INFO_CTL.send_time
  is '����ʱ��';
comment on column T_SUPPLIER_INFO_CTL.receive_time
  is '����ʱ��';
comment on column T_SUPPLIER_INFO_CTL.return_type
  is '��������';
comment on column T_SUPPLIER_INFO_CTL.return_msg
  is '������Ϣ';
