--Drop table
--drop scmdata.t_delivery_record;
-- Create table
create table T_DELIVERY_RECORD
(
  delivery_record_id      VARCHAR2(32) not null,
  company_id              VARCHAR2(32) not null,
  delivery_record_code    VARCHAR2(32) not null,
  order_code              VARCHAR2(32) not null,
  ing_id                  VARCHAR2(32),
  goo_id                  VARCHAR2(32) not null,
  delivery_price          NUMBER(18,4),
  delivery_amount         NUMBER(18,4),
  create_id               VARCHAR2(32) not null,
  create_time             DATE not null,
  memo                    VARCHAR2(256),
  delivery_date           DATE,
  accept_date             DATE,
  sorting_date            DATE,
  shipment_date           DATE,
  update_id               VARCHAR2(32),
  update_time             DATE,
  asn_id                  VARCHAR2(32),
  predict_delivery_amount NUMBER(18,4)
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
comment on table T_DELIVERY_RECORD
  is '������¼��';
-- Add comments to the columns 
comment on column T_DELIVERY_RECORD.delivery_record_id
  is '����';
comment on column T_DELIVERY_RECORD.company_id
  is '��ҵID';
comment on column T_DELIVERY_RECORD.delivery_record_code
  is '������¼���';
comment on column T_DELIVERY_RECORD.order_code
  is '�������';
comment on column T_DELIVERY_RECORD.ing_id
  is '���ֵ���';
comment on column T_DELIVERY_RECORD.goo_id
  is '����';
comment on column T_DELIVERY_RECORD.delivery_price
  is '�����ɱ�';
comment on column T_DELIVERY_RECORD.delivery_amount
  is '��������';
comment on column T_DELIVERY_RECORD.create_id
  is '������';
comment on column T_DELIVERY_RECORD.create_time
  is '����ʱ��';
comment on column T_DELIVERY_RECORD.memo
  is '��ע';
comment on column T_DELIVERY_RECORD.delivery_date
  is '��������';
comment on column T_DELIVERY_RECORD.accept_date
  is 'ȷ���ջ�����';
comment on column T_DELIVERY_RECORD.sorting_date
  is '���·ּ�����';
comment on column T_DELIVERY_RECORD.shipment_date
  is '��������';
comment on column T_DELIVERY_RECORD.asn_id
  is 'asnԤԼ����';
comment on column T_DELIVERY_RECORD.predict_delivery_amount
  is 'Ԥ�Ƶ�������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_DELIVERY_RECORD
  add constraint PK_T_DELIVERY_RECORD primary key (DELIVERY_RECORD_ID)
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
alter index PK_T_DELIVERY_RECORD nologging;
