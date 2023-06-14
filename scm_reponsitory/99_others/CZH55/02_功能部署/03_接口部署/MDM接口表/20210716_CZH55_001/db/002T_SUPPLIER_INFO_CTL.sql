-- Create table
create table MDMDATA.T_SUPPLIER_INFO_CTL
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
tablespace MDMDATA
nologging;
comment on table MDMDATA.T_SUPPLIER_INFO_CTL is '��Ӧ�������ӿڼ�ر�';
-- Add comments to the columns 
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.ctl_id
  is '�ӿڼ�ر�ţ�����';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.itf_id
  is '�ӿڱ��';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.itf_type
  is '�ӿ�����';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.batch_id
  is '���α��';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.batch_num
  is '����';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.batch_time
  is '����ʱ��';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.sender
  is '���ͷ�';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.receiver
  is '���շ�';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.send_time
  is '����ʱ��';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.receive_time
  is '����ʱ��';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.return_type
  is '��������';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.return_msg
  is '������Ϣ';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MDMDATA.T_SUPPLIER_INFO_CTL
  add constraint PK_T_SUPPLIER_INFO_CTL_ID primary key (CTL_ID)
  using index 
  tablespace MDMDATA;
alter index MDMDATA.PK_T_SUPPLIER_INFO_CTL_ID nologging;
