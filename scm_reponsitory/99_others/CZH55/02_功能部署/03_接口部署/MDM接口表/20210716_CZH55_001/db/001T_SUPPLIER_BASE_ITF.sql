-- Create table
create table MDMDATA.T_SUPPLIER_BASE_ITF
(
  itf_id            VARCHAR2(32) not null,
  supplier_code     VARCHAR2(32),
  sup_id_base       NUMBER(5),
  sup_name          VARCHAR2(100),
  legalperson       VARCHAR2(48),
  linkman           VARCHAR2(48),
  phonenumber       VARCHAR2(20),
  address           VARCHAR2(140),
  countyid          NUMBER,
  provinceid        NUMBER,
  cityno            NUMBER,
  tax_id            VARCHAR2(50),
  cooperation_model VARCHAR2(48),
  data_status       VARCHAR2(32),
  fetch_flag        NUMBER default 0,
  create_id         VARCHAR2(32),
  create_time       DATE,
  update_id         VARCHAR2(32),
  update_time       DATE,
  publish_id        VARCHAR2(32),
  publish_time      DATE,
  fetch_time        DATE,
  supp_date         DATE,
  memo              VARCHAR2(300),
  pause             NUMBER(1)
)
tablespace MDMDATA
nologging;
comment on table MDMDATA.T_SUPPLIER_BASE_ITF is '��Ӧ�������ӿڱ�';
-- Add comments to the columns 
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.itf_id
  is '�ӿڱ�ţ�����';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.supplier_code
  is '��Ӧ�̵�����ţ�scm��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.sup_id_base
  is '�ش���Ӧ�̱�ţ�mdm��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.sup_name
  is '��Ӧ������';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.legalperson
  is '���˴���';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.linkman
  is '��ϵ��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.phonenumber
  is '�绰����';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.address
  is 'ע���ַ';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.countyid
  is 'ʡ';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.provinceid
  is '��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.cityno
  is '��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.tax_id
  is 'ͳһ������ô���';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.cooperation_model
  is '����ģʽ';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.data_status
  is '����״̬��I ������U ���£�';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.fetch_flag
  is 'scm��ȡ��ʶ';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.create_id
  is '������';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.create_time
  is '����ʱ��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.update_id
  is '�޸���';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.update_time
  is '�޸�ʱ��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.publish_id
  is '������';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.publish_time
  is '����ʱ��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.fetch_time
  is '��ȡʱ��';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.supp_date
  is '��������';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.memo
  is '��ע';
comment on column MDMDATA.T_SUPPLIER_BASE_ITF.pause
  is '��ͣ״̬������״̬��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MDMDATA.T_SUPPLIER_BASE_ITF
  add constraint PK_T_SUPPLIER_BASE_ITF_ID primary key (ITF_ID)
  using index 
  tablespace MDMDATA;
alter index MDMDATA.PK_T_SUPPLIER_BASE_ITF_ID nologging;
