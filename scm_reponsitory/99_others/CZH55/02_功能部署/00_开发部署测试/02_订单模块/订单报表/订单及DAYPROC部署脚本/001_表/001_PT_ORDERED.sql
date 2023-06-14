-- Create table
create table PT_ORDERED
(
  pt_ordered_id          VARCHAR2(32) not null,
  company_id             VARCHAR2(32) not null,
  order_id               VARCHAR2(32) not null,
  product_gress_code     VARCHAR2(32),
  year                   NUMBER(4),
  quarter                NUMBER(1),
  month                  NUMBER(2),
  supplier_code          VARCHAR2(32),
  supplier_company_name  VARCHAR2(48),
  factory_code           VARCHAR2(32),
  factory_company_name   VARCHAR2(48),
  goo_id                 VARCHAR2(32),
  category               VARCHAR2(48),
  category_name          VARCHAR2(48),
  product_cate           VARCHAR2(32),
  coop_product_cate_name VARCHAR2(48),
  samll_category         VARCHAR2(32),
  product_subclass_name  VARCHAR2(48),
  style_name             VARCHAR2(32),
  style_number           VARCHAR2(32),
  flw_order              VARCHAR2(256),
  flw_order_manager      VARCHAR2(32),
  qc                     VARCHAR2(32),
  qc_manager             VARCHAR2(32),
  area_gp_leader         VARCHAR2(32),
  is_twenty              NUMBER(1),
  delivery_status        VARCHAR2(32),
  is_quality             NUMBER(1),
  actual_delay_days      NUMBER(5),
  delay_section          VARCHAR2(32),
  responsible_dept       VARCHAR2(32),
  responsible_dept_sec   VARCHAR2(32),
  delay_problem_class    VARCHAR2(50),
  delay_cause_class      VARCHAR2(50),
  delay_cause_detailed   VARCHAR2(50),
  problem_desc           VARCHAR2(4000),
  purchase_price         NUMBER(10,2),
  fixed_price            NUMBER(10,2),
  order_amount           NUMBER(18,4),
  est_arrival_amount     NUMBER(18,4),
  delivery_amount        NUMBER(18,4),
  satisfy_amount         NUMBER(18,4),
  order_money            NUMBER(10,2),
  delivery_money         NUMBER(10,2),
  satisfy_money          NUMBER(10,2),
  delivery_date          DATE,
  order_create_date      DATE,
  arrival_date           DATE,
  sort_date              DATE,
  is_first_order         NUMBER(1),
  remarks                VARCHAR2(4000),
  order_finish_time      DATE,
  create_id              VARCHAR2(32),
  create_time            DATE,
  update_id              VARCHAR2(32),
  update_time            DATE
)
partition by list (YEAR)
subpartition by list (MONTH)
(
  partition PT_ORDERED_YEAR_2021 values (2021)
    tablespace SCMDATA
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 8
      minextents 1
      maxextents unlimited
    )
  (
    subpartition PT_ORDERED_YEAR_2021_PT_ORDERED_QUARTER_1 values (1, 2, 3) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2021_PT_ORDERED_QUARTER_2 values (4, 5, 6) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2021_PT_ORDERED_QUARTER_3 values (7, 8, 9) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2021_PT_ORDERED_QUARTER_4 values (10, 11, 12) tablespace SCMDATA
  ),
  partition PT_ORDERED_YEAR_2022 values (2022)
    tablespace SCMDATA
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 8
      minextents 1
      maxextents unlimited
    )
  (
    subpartition PT_ORDERED_YEAR_2022_PT_ORDERED_QUARTER_1 values (1, 2, 3) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2022_PT_ORDERED_QUARTER_2 values (4, 5, 6) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2022_PT_ORDERED_QUARTER_3 values (7, 8, 9) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2022_PT_ORDERED_QUARTER_4 values (10, 11, 12) tablespace SCMDATA
  ),
  partition PT_ORDERED_YEAR_2023 values (2023)
    tablespace SCMDATA
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 8
      minextents 1
      maxextents unlimited
    )
  (
    subpartition PT_ORDERED_YEAR_2023_PT_ORDERED_QUARTER_1 values (1, 2, 3) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2023_PT_ORDERED_QUARTER_2 values (4, 5, 6) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2023_PT_ORDERED_QUARTER_3 values (7, 8, 9) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_2023_PT_ORDERED_QUARTER_4 values (10, 11, 12) tablespace SCMDATA
  ),
  partition PT_ORDERED_YEAR_OTHER values (DEFAULT)
    tablespace SCMDATA
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 8
      minextents 1
      maxextents unlimited
    )
  (
    subpartition PT_ORDERED_YEAR_OTHER_PT_ORDERED_QUARTER_1 values (1, 2, 3) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_OTHER_PT_ORDERED_QUARTER_2 values (4, 5, 6) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_OTHER_PT_ORDERED_QUARTER_3 values (7, 8, 9) tablespace SCMDATA,
    subpartition PT_ORDERED_YEAR_OTHER_PT_ORDERED_QUARTER_4 values (10, 11, 12) tablespace SCMDATA
  )
);
-- Add comments to the table 
comment on table PT_ORDERED
  is '�����������ݱ�';
-- Add comments to the columns 
comment on column PT_ORDERED.pt_ordered_id
  is '�����������ݱ�ID';
comment on column PT_ORDERED.company_id
  is '��ҵID';
comment on column PT_ORDERED.order_id
  is '����ID';
comment on column PT_ORDERED.year
  is '���';
comment on column PT_ORDERED.quarter
  is '����';
comment on column PT_ORDERED.month
  is '�·�';
comment on column PT_ORDERED.supplier_code
  is '��Ӧ�̱���';
comment on column PT_ORDERED.factory_code
  is '��������';
comment on column PT_ORDERED.goo_id
  is '����';
comment on column PT_ORDERED.product_cate
  is '��Ʒ���';
comment on column PT_ORDERED.samll_category
  is '����';
comment on column PT_ORDERED.style_name
  is '��ʽ����';
comment on column PT_ORDERED.style_number
  is '���';
comment on column PT_ORDERED.flw_order
  is '����';
comment on column PT_ORDERED.flw_order_manager
  is '��������';
comment on column PT_ORDERED.qc
  is 'QC';
comment on column PT_ORDERED.qc_manager
  is 'QC����';
comment on column PT_ORDERED.area_gp_leader
  is '�����鳤';
comment on column PT_ORDERED.is_twenty
  is '�Ƿ�ǰ20%';
comment on column PT_ORDERED.delivery_status
  is '����״̬';
comment on column PT_ORDERED.is_quality
  is '�Ƿ�������������';
comment on column PT_ORDERED.actual_delay_days
  is 'ʵ����������';
comment on column PT_ORDERED.delay_section
  is '��������';
comment on column PT_ORDERED.responsible_dept
  is '����һ������';
comment on column PT_ORDERED.responsible_dept_sec
  is '���ζ�������';
comment on column PT_ORDERED.delay_problem_class
  is '�����������';
comment on column PT_ORDERED.delay_cause_class
  is '����ԭ�����';
comment on column PT_ORDERED.delay_cause_detailed
  is '����ԭ��ϸ��';
comment on column PT_ORDERED.problem_desc
  is '��������';
comment on column PT_ORDERED.purchase_price
  is '����';
comment on column PT_ORDERED.fixed_price
  is '����';
comment on column PT_ORDERED.order_amount
  is '��������';
comment on column PT_ORDERED.est_arrival_amount
  is 'Ԥ�Ƶ�����';
comment on column PT_ORDERED.delivery_amount
  is '��������';
comment on column PT_ORDERED.satisfy_amount
  is '��������';
comment on column PT_ORDERED.order_money
  is '�������';
comment on column PT_ORDERED.delivery_money
  is '�������';
comment on column PT_ORDERED.satisfy_money
  is '������';
comment on column PT_ORDERED.delivery_date
  is '��������';
comment on column PT_ORDERED.order_create_date
  is '��������ʱ��';
comment on column PT_ORDERED.arrival_date
  is '��������';
comment on column PT_ORDERED.sort_date
  is '�ּ�����';
comment on column PT_ORDERED.is_first_order
  is '�Ƿ��׵�';
comment on column PT_ORDERED.remarks
  is '��ע';
comment on column PT_ORDERED.order_finish_time
  is '��������ʱ��';
comment on column PT_ORDERED.create_id
  is '������';
comment on column PT_ORDERED.create_time
  is '����ʱ��';
comment on column PT_ORDERED.update_id
  is '�޸���';
comment on column PT_ORDERED.update_time
  is '�޸�ʱ��';
comment on column PT_ORDERED.supplier_company_name
  is '��Ӧ������';
comment on column PT_ORDERED.factory_company_name
  is '��������';
comment on column PT_ORDERED.category
  is '����';
comment on column PT_ORDERED.category_name
  is '��������';
comment on column PT_ORDERED.coop_product_cate_name
  is '��Ʒ�������';
comment on column PT_ORDERED.product_subclass_name
  is '��������';
comment on column PT_ORDERED.product_gress_code
  is '�����������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PT_ORDERED
  add constraint PK_PT_ORDERED_ID primary key (PT_ORDERED_ID)
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
alter index PK_PT_ORDERED_ID nologging;
