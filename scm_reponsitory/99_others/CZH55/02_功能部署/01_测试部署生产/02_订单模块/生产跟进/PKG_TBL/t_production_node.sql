--Drop table
--drop scmdata.t_production_node;
-- Create table
create table T_PRODUCTION_NODE
(
  product_node_id        VARCHAR2(32) not null,
  company_id             VARCHAR2(32) not null,
  product_gress_id       VARCHAR2(32) not null,
  product_node_code      VARCHAR2(32) not null,
  node_num               NUMBER(3) not null,
  node_name              VARCHAR2(256) not null,
  time_ratio             NUMBER(18,4) not null,
  target_completion_time DATE not null,
  plan_completion_time   DATE,
  actual_completion_time DATE,
  complete_amount        NUMBER(18,4),
  progress_status        VARCHAR2(32),
  progress_say           VARCHAR2(300),
  update_id              VARCHAR2(32),
  update_date            DATE,
  create_id              VARCHAR2(32) not null,
  create_time            DATE not null,
  memo                   VARCHAR2(256),
  operator               VARCHAR2(256)
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
comment on table T_PRODUCTION_NODE
  is '�����ڵ��';
-- Add comments to the columns 
comment on column T_PRODUCTION_NODE.product_node_id
  is '����';
comment on column T_PRODUCTION_NODE.company_id
  is '��ҵID';
comment on column T_PRODUCTION_NODE.product_gress_id
  is '��������ID';
comment on column T_PRODUCTION_NODE.product_node_code
  is '�����ڵ���ȱ��';
comment on column T_PRODUCTION_NODE.node_num
  is '�ڵ����';
comment on column T_PRODUCTION_NODE.node_name
  is '�����ڵ�����';
comment on column T_PRODUCTION_NODE.time_ratio
  is '��ʱռ��';
comment on column T_PRODUCTION_NODE.target_completion_time
  is 'Ŀ�����ʱ��';
comment on column T_PRODUCTION_NODE.plan_completion_time
  is '�ƻ����ʱ��';
comment on column T_PRODUCTION_NODE.actual_completion_time
  is 'ʵ�����ʱ��';
comment on column T_PRODUCTION_NODE.complete_amount
  is '�������';
comment on column T_PRODUCTION_NODE.progress_status
  is '����״̬';
comment on column T_PRODUCTION_NODE.progress_say
  is '����˵��';
comment on column T_PRODUCTION_NODE.update_id
  is '�޸���';
comment on column T_PRODUCTION_NODE.update_date
  is '�޸�ʱ��';
comment on column T_PRODUCTION_NODE.create_id
  is '������';
comment on column T_PRODUCTION_NODE.create_time
  is '����ʱ��';
comment on column T_PRODUCTION_NODE.memo
  is '��ע';
comment on column T_PRODUCTION_NODE.operator
  is '������';
-- Create/Recreate indexes 
create index IX_T_PROGRESS_NODE_01 on T_PRODUCTION_NODE (COMPANY_ID, PRODUCT_GRESS_ID)
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
alter table T_PRODUCTION_NODE
  add constraint PK_T_PROGRESS_NODE primary key (PRODUCT_NODE_ID)
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
alter index PK_T_PROGRESS_NODE nologging;
