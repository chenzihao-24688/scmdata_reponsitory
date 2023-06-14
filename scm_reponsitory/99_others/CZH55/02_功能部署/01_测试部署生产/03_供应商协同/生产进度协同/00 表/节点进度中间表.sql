-- Create table
create table T_NODE_TMP
(
  node_tmp_id            VARCHAR2(32) not null,
  company_id             VARCHAR2(32) not null,
  order_company_id       VARCHAR2(32) not null,
  product_gress_code     VARCHAR2(4000) not null,
  plan_completion_time   DATE,
  actual_completion_time DATE,
  complete_amount        NUMBER(18,4),
  progress_status        VARCHAR2(32),
  progress_say           VARCHAR2(4000),
  operator               VARCHAR2(256),
  update_id              VARCHAR2(32),
  update_date            DATE,
  create_id              VARCHAR2(32) not null,
  create_time            DATE not null,
  memo                   VARCHAR2(4000),
  node_name              VARCHAR2(256),
  node_num               NUMBER
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
comment on table T_NODE_TMP
  is '节点进度中间表';
-- Add comments to the columns 
comment on column T_NODE_TMP.node_tmp_id
  is 'ID';
comment on column T_NODE_TMP.company_id
  is '企业ID';
comment on column T_NODE_TMP.order_company_id
  is '订单企业ID';
comment on column T_NODE_TMP.product_gress_code
  is '生产订单编号';
comment on column T_NODE_TMP.plan_completion_time
  is '计划完成日期';
comment on column T_NODE_TMP.actual_completion_time
  is '实际完成日期';
comment on column T_NODE_TMP.complete_amount
  is '完成数量';
comment on column T_NODE_TMP.progress_status
  is '进度状态';
comment on column T_NODE_TMP.progress_say
  is '进度说明';
comment on column T_NODE_TMP.operator
  is '操作方';
comment on column T_NODE_TMP.update_id
  is '修改人';
comment on column T_NODE_TMP.update_date
  is '修改时间';
comment on column T_NODE_TMP.create_id
  is '创建人';
comment on column T_NODE_TMP.create_time
  is '创建时间';
comment on column T_NODE_TMP.memo
  is '备注';
comment on column T_NODE_TMP.node_name
  is '节点名称';
comment on column T_NODE_TMP.node_num
  is '节点序号';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_NODE_TMP
  add constraint PK_NODE_TMP_ID primary key (NODE_TMP_ID)
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
alter index PK_NODE_TMP_ID nologging;
