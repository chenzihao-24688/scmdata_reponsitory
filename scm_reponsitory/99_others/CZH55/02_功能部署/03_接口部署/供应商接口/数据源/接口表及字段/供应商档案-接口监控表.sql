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
  is '接口监控编号，主键';
comment on column T_SUPPLIER_INFO_CTL.itf_id
  is '接口编号';
comment on column T_SUPPLIER_INFO_CTL.itf_type
  is '接口类型';
comment on column T_SUPPLIER_INFO_CTL.batch_id
  is '批次编号';
comment on column T_SUPPLIER_INFO_CTL.batch_num
  is '数量';
comment on column T_SUPPLIER_INFO_CTL.batch_time
  is '批次时间';
comment on column T_SUPPLIER_INFO_CTL.sender
  is '发送方';
comment on column T_SUPPLIER_INFO_CTL.receiver
  is '接收方';
comment on column T_SUPPLIER_INFO_CTL.send_time
  is '发送时间';
comment on column T_SUPPLIER_INFO_CTL.receive_time
  is '接收时间';
comment on column T_SUPPLIER_INFO_CTL.return_type
  is '返回类型';
comment on column T_SUPPLIER_INFO_CTL.return_msg
  is '返回消息';
