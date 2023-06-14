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
  is '��������״̬����';
-- Add comments to the columns 
comment on column T_PRODUCT_STATUS_SEQ.seq_id
  is 'ID';
comment on column T_PRODUCT_STATUS_SEQ.company_id
  is '��ҵID';
comment on column T_PRODUCT_STATUS_SEQ.category
  is '�ֲ�';
comment on column T_PRODUCT_STATUS_SEQ.node_num
  is '�ڵ����';
comment on column T_PRODUCT_STATUS_SEQ.node_name
  is '�ڵ�����';
comment on column T_PRODUCT_STATUS_SEQ.create_id
  is '������';
comment on column T_PRODUCT_STATUS_SEQ.create_time
  is '����ʱ��';
comment on column T_PRODUCT_STATUS_SEQ.update_id
  is '�޸���';
comment on column T_PRODUCT_STATUS_SEQ.update_time
  is '�޸�ʱ��';
