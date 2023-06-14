--Drop table
--drop scmdata.t_deduction;
-- Create table
create table T_DEDUCTION
(
  deduction_id          VARCHAR2(32) not null,
  company_id            VARCHAR2(32) not null,
  order_company_id      VARCHAR2(32),
  order_id              VARCHAR2(32) not null,
  abnormal_id           VARCHAR2(32) not null,
  deduction_status      VARCHAR2(32),
  discount_unit_price   NUMBER(32,8),
  discount_type         VARCHAR2(32),
  discount_proportion   NUMBER(32,8),
  discount_price        NUMBER(32,8),
  adjust_type           VARCHAR2(32),
  adjust_proportion     NUMBER(32,8),
  adjust_price          NUMBER(32,8),
  adjust_reason         VARCHAR2(256),
  actual_discount_price NUMBER(32,8),
  create_id             VARCHAR2(32) not null,
  create_time           DATE not null,
  memo                  VARCHAR2(256),
  orgin                 VARCHAR2(256) not null,
  update_id             VARCHAR2(32),
  update_time           DATE
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
comment on column T_DEDUCTION.deduction_id
  is '主键';
comment on column T_DEDUCTION.company_id
  is '企业ID';
comment on column T_DEDUCTION.order_company_id
  is '发单企业ID';
comment on column T_DEDUCTION.order_id
  is '订单ID';
comment on column T_DEDUCTION.abnormal_id
  is '异常ID';
comment on column T_DEDUCTION.deduction_status
  is '状态';
comment on column T_DEDUCTION.discount_unit_price
  is '折让单价';
comment on column T_DEDUCTION.discount_type
  is '折让类型';
comment on column T_DEDUCTION.discount_proportion
  is '折让比例%';
comment on column T_DEDUCTION.discount_price
  is '折让金额';
comment on column T_DEDUCTION.adjust_type
  is '调整类型';
comment on column T_DEDUCTION.adjust_proportion
  is '调整比例%';
comment on column T_DEDUCTION.adjust_price
  is '调整金额';
comment on column T_DEDUCTION.adjust_reason
  is '调整理由';
comment on column T_DEDUCTION.actual_discount_price
  is '实折金额';
comment on column T_DEDUCTION.create_id
  is '创建人';
comment on column T_DEDUCTION.create_time
  is '创建时间';
comment on column T_DEDUCTION.memo
  is '备注';
comment on column T_DEDUCTION.orgin
  is '来源';
comment on column T_DEDUCTION.update_id
  is '修改人';
comment on column T_DEDUCTION.update_time
  is '修改时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_DEDUCTION
  add constraint PK_DEDUCTION_ID primary key (DEDUCTION_ID)
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
alter index PK_DEDUCTION_ID nologging;
