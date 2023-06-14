-- Create table
create table T_BESTGOODSOFMONTH
(
  ayear      NUMBER(4),
  amonth     NUMBER(2),
  goo_id     VARCHAR2(32),
  saleamount NUMBER(8),
  salemoney  NUMBER(16,4)
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
