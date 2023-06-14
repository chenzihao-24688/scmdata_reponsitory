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
comment on table MDMDATA.T_SUPPLIER_INFO_CTL is '供应商主档接口监控表';
-- Add comments to the columns 
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.ctl_id
  is '接口监控编号，主键';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.itf_id
  is '接口编号';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.itf_type
  is '接口类型';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.batch_id
  is '批次编号';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.batch_num
  is '数量';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.batch_time
  is '批次时间';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.sender
  is '发送方';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.receiver
  is '接收方';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.send_time
  is '发送时间';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.receive_time
  is '接收时间';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.return_type
  is '返回类型';
comment on column MDMDATA.T_SUPPLIER_INFO_CTL.return_msg
  is '返回消息';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MDMDATA.T_SUPPLIER_INFO_CTL
  add constraint PK_T_SUPPLIER_INFO_CTL_ID primary key (CTL_ID)
  using index 
  tablespace MDMDATA;
alter index MDMDATA.PK_T_SUPPLIER_INFO_CTL_ID nologging;
