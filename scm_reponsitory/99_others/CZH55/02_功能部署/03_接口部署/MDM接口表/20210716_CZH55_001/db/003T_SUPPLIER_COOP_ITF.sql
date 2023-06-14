-- Create table
create table MDMDATA.T_SUPPLIER_COOP_ITF
(
  itf_id                        VARCHAR2(32) not null,
  supplier_code                 VARCHAR2(32),
  sup_name                      VARCHAR2(100),
  coop_classification_num       VARCHAR2(100),
  cooperation_classification_sp VARCHAR2(100),
  coop_product_cate_num         VARCHAR2(100),
  cooperation_product_cate_sp   VARCHAR2(100),
  data_status                   VARCHAR2(32),
  create_id                     VARCHAR2(32),
  create_time                   DATE,
  update_id                     VARCHAR2(32),
  update_time                   DATE,
  publish_id                    VARCHAR2(32),
  publish_time                  DATE,
  fetch_flag                    NUMBER default 0,
  fetch_time                    DATE,
  coop_scope_id                 VARCHAR2(32) not null,
  pause                         NUMBER
)
tablespace MDMDATA
nologging;
comment on table MDMDATA.T_SUPPLIER_COOP_ITF is '��Ӧ��-������Χ�ӿڱ�';
-- Add comments to the columns 
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.itf_id
  is '�ӿڱ�ţ�����';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.supplier_code
  is '��Ӧ�̵�����ţ�scm��';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.sup_name
  is '��Ӧ������';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.coop_classification_num
  is '����������';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.cooperation_classification_sp
  is '��������';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.coop_product_cate_num
  is '���������';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.cooperation_product_cate_sp
  is '�������';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.data_status
  is '����״̬�����������£�';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.create_id
  is '������';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.create_time
  is '����ʱ��';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.update_id
  is '�޸���';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.update_time
  is '�޸�ʱ��';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.publish_id
  is '������';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.publish_time
  is '����ʱ��';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.fetch_flag
  is 'scm��ȡ��ʶ';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.fetch_time
  is '��ȡʱ��';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.coop_scope_id
  is '������Χ����';
comment on column MDMDATA.T_SUPPLIER_COOP_ITF.pause
  is '��ͣ״̬';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MDMDATA.T_SUPPLIER_COOP_ITF
  add constraint PK_T_SUPPLIER_COOP_ITF_ID primary key (ITF_ID)
  using index 
  tablespace MDMDATA;
alter index MDMDATA.PK_T_SUPPLIER_COOP_ITF_ID nologging;
