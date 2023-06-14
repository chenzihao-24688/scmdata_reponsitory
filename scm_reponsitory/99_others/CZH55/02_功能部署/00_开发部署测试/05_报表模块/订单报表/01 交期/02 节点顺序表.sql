-- Create table
create table T_PRODUCT_STATUS_SEQ
(
  seq_id      VARCHAR2(32) not null,
  company_id  VARCHAR2(32) not null,
  category    VARCHAR2(32) not null,
  node_num    NUMBER not null,
  node_name   VARCHAR2(256) not null,
  create_id   VARCHAR2(32),
  create_time DATE,
  update_id   VARCHAR2(32),
  update_time DATE
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
comment on table T_PRODUCT_STATUS_SEQ
  is '生产进度状态排序';
-- Add comments to the columns 
comment on column T_PRODUCT_STATUS_SEQ.seq_id
  is 'ID';
comment on column T_PRODUCT_STATUS_SEQ.company_id
  is '企业ID';
comment on column T_PRODUCT_STATUS_SEQ.category
  is '分部';
comment on column T_PRODUCT_STATUS_SEQ.node_num
  is '节点序号';
comment on column T_PRODUCT_STATUS_SEQ.node_name
  is '节点名称';
comment on column T_PRODUCT_STATUS_SEQ.create_id
  is '创建人';
comment on column T_PRODUCT_STATUS_SEQ.create_time
  is '创建时间';
comment on column T_PRODUCT_STATUS_SEQ.update_id
  is '修改人';
comment on column T_PRODUCT_STATUS_SEQ.update_time
  is '修改时间';
