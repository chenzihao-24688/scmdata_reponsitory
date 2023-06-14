-- Create table
create table scmdata.T_ORDER_SEAL_TIME
(
  id        VARCHAR2(32),
  month     VARCHAR2(32),
  seal_days NUMBER
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
  );
-- Add comments to the table 
comment on table scmdata.T_ORDER_SEAL_TIME
  is '订单交期底层封存时间表';
-- Add comments to the columns 
comment on column scmdata.T_ORDER_SEAL_TIME.id
  is 'id';
comment on column scmdata.T_ORDER_SEAL_TIME.month
  is '月份';
comment on column scmdata.T_ORDER_SEAL_TIME.seal_days
  is '封存天数';
-- Create/Recreate primary, unique and foreign key constraints 
alter table scmdata.T_ORDER_SEAL_TIME
  add constraint PK_ORDER_SEAL_TIME_ID primary key (ID)
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
/
