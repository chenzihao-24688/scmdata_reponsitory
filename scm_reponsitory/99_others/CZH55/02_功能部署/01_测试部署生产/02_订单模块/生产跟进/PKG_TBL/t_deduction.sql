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
  is '����';
comment on column T_DEDUCTION.company_id
  is '��ҵID';
comment on column T_DEDUCTION.order_company_id
  is '������ҵID';
comment on column T_DEDUCTION.order_id
  is '����ID';
comment on column T_DEDUCTION.abnormal_id
  is '�쳣ID';
comment on column T_DEDUCTION.deduction_status
  is '״̬';
comment on column T_DEDUCTION.discount_unit_price
  is '���õ���';
comment on column T_DEDUCTION.discount_type
  is '��������';
comment on column T_DEDUCTION.discount_proportion
  is '���ñ���%';
comment on column T_DEDUCTION.discount_price
  is '���ý��';
comment on column T_DEDUCTION.adjust_type
  is '��������';
comment on column T_DEDUCTION.adjust_proportion
  is '��������%';
comment on column T_DEDUCTION.adjust_price
  is '�������';
comment on column T_DEDUCTION.adjust_reason
  is '��������';
comment on column T_DEDUCTION.actual_discount_price
  is 'ʵ�۽��';
comment on column T_DEDUCTION.create_id
  is '������';
comment on column T_DEDUCTION.create_time
  is '����ʱ��';
comment on column T_DEDUCTION.memo
  is '��ע';
comment on column T_DEDUCTION.orgin
  is '��Դ';
comment on column T_DEDUCTION.update_id
  is '�޸���';
comment on column T_DEDUCTION.update_time
  is '�޸�ʱ��';
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
