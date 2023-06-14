--Drop table
--drop scmdata.t_production_progress;
-- Create table
create table T_PRODUCTION_PROGRESS
(
  product_gress_id             VARCHAR2(32) not null,
  company_id                   VARCHAR2(32) not null,
  product_gress_code           VARCHAR2(32) not null,
  order_id                     VARCHAR2(32) not null,
  progress_status              VARCHAR2(32) not null,
  goo_id                       VARCHAR2(32) not null,
  supplier_code                VARCHAR2(32) not null,
  factory_code                 VARCHAR2(32),
  forecast_delivery_date       DATE,
  forecast_delay_day           NUMBER(18,4),
  actual_delivery_date         DATE,
  actual_delay_day             NUMBER(18,4),
  latest_planned_delivery_date DATE,
  order_amount                 NUMBER(18,4) not null,
  delivery_amount              NUMBER(18,4) default 0 not null,
  approve_edition              VARCHAR2(32),
  fabric_check                 VARCHAR2(32),
  qc_quality_check             VARCHAR2(32),
  exception_handle_status      VARCHAR2(32),
  handle_opinions              VARCHAR2(32),
  create_id                    VARCHAR2(32) not null,
  create_time                  DATE not null,
  origin                       VARCHAR2(32) not null,
  memo                         VARCHAR2(256),
  qc_check                     VARCHAR2(32),
  qa_check                     VARCHAR2(32),
  order_status                 VARCHAR2(32),
  delay_problem_class          VARCHAR2(32),
  delay_cause_class            VARCHAR2(32),
  delay_cause_detailed         VARCHAR2(32),
  problem_desc                 VARCHAR2(4000),
  is_sup_responsible           NUMBER(1),
  responsible_dept             VARCHAR2(32),
  responsible_dept_sec         VARCHAR2(32),
  order_full_rate              NUMBER(18,2)
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
comment on table T_PRODUCTION_PROGRESS
  is '�������ȱ�';
-- Add comments to the columns 
comment on column T_PRODUCTION_PROGRESS.product_gress_id
  is '����';
comment on column T_PRODUCTION_PROGRESS.company_id
  is '��ҵID';
comment on column T_PRODUCTION_PROGRESS.product_gress_code
  is '��ҵ�������ȱ��';
comment on column T_PRODUCTION_PROGRESS.order_id
  is '�������';
comment on column T_PRODUCTION_PROGRESS.progress_status
  is '����״̬';
comment on column T_PRODUCTION_PROGRESS.goo_id
  is '����';
comment on column T_PRODUCTION_PROGRESS.supplier_code
  is '��Ʒ��Ӧ�̱���';
comment on column T_PRODUCTION_PROGRESS.factory_code
  is '������������';
comment on column T_PRODUCTION_PROGRESS.forecast_delivery_date
  is 'Ԥ�⽻��';
comment on column T_PRODUCTION_PROGRESS.forecast_delay_day
  is 'Ԥ����������';
comment on column T_PRODUCTION_PROGRESS.actual_delivery_date
  is 'ʵ�ʽ�������';
comment on column T_PRODUCTION_PROGRESS.actual_delay_day
  is 'ʵ����������';
comment on column T_PRODUCTION_PROGRESS.latest_planned_delivery_date
  is '���¼ƻ�����';
comment on column T_PRODUCTION_PROGRESS.order_amount
  is '��������';
comment on column T_PRODUCTION_PROGRESS.delivery_amount
  is '��������';
comment on column T_PRODUCTION_PROGRESS.approve_edition
  is '����';
comment on column T_PRODUCTION_PROGRESS.fabric_check
  is '���ϼ��';
comment on column T_PRODUCTION_PROGRESS.qc_quality_check
  is 'qc�ʼ�';
comment on column T_PRODUCTION_PROGRESS.exception_handle_status
  is '�쳣����״̬';
comment on column T_PRODUCTION_PROGRESS.handle_opinions
  is '�������';
comment on column T_PRODUCTION_PROGRESS.create_id
  is '������';
comment on column T_PRODUCTION_PROGRESS.create_time
  is '����ʱ��';
comment on column T_PRODUCTION_PROGRESS.origin
  is '��Դ';
comment on column T_PRODUCTION_PROGRESS.memo
  is '��ע';
comment on column T_PRODUCTION_PROGRESS.qc_check
  is 'qc���';
comment on column T_PRODUCTION_PROGRESS.qa_check
  is 'qa���';
comment on column T_PRODUCTION_PROGRESS.order_status
  is '����״̬';
comment on column T_PRODUCTION_PROGRESS.delay_problem_class
  is '�����������';
comment on column T_PRODUCTION_PROGRESS.delay_cause_class
  is '����ԭ�����';
comment on column T_PRODUCTION_PROGRESS.delay_cause_detailed
  is '����ԭ��ϸ��';
comment on column T_PRODUCTION_PROGRESS.problem_desc
  is '��������';
comment on column T_PRODUCTION_PROGRESS.is_sup_responsible
  is '��Ӧ���Ƿ�����';
comment on column T_PRODUCTION_PROGRESS.responsible_dept
  is '���β���(1��)';
comment on column T_PRODUCTION_PROGRESS.responsible_dept_sec
  is '���β���(2��)';
comment on column T_PRODUCTION_PROGRESS.order_full_rate
  is '����������';
-- Create/Recreate indexes 
create index IX_T_PRODUCTION_PROGRESS_COMPANY_ID on T_PRODUCTION_PROGRESS (COMPANY_ID)
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
  )
  nologging;
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_PRODUCTION_PROGRESS
  add constraint PK_T_PRODUCTION_PROGRESS primary key (PRODUCT_GRESS_ID)
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
alter index PK_T_PRODUCTION_PROGRESS nologging;
