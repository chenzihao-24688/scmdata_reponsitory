--1.scmdata.t_ask_record
alter table scmdata.t_ask_record add (SUPPLIER_PRODUCT	VARCHAR2(256));
alter table scmdata.t_ask_record add (SUPPLIER_GATE	VARCHAR2(256));
alter table scmdata.t_ask_record add (SUPPLIER_OFFICE	VARCHAR2(256));
alter table scmdata.t_ask_record add (SUPPLIER_SITE	VARCHAR2(256));
alter table scmdata.t_ask_record add (BRAND_TYPE	VARCHAR2(4000));
alter table scmdata.t_ask_record add (COOPERATION_BRAND	VARCHAR2(4000));
alter table scmdata.t_ask_record add (PRODUCT_LINK	VARCHAR2(148));
alter table scmdata.t_ask_record add (COMPANY_ABBREVIATION	VARCHAR2(148));
alter table scmdata.t_ask_record add (COMPANY_TYPE	VARCHAR2(148));
alter table scmdata.t_ask_record add (LEGAL_REPRESENTATIVE	VARCHAR2(148));
alter table scmdata.t_ask_record add (COMPANY_CONTACT_PHONE	VARCHAR2(148));
COMMENT ON column scmdata.t_ask_record.SUPPLIER_PRODUCT is '��˾���Ÿ�����ַ';
COMMENT ON column scmdata.t_ask_record.SUPPLIER_GATE is '��˾�칫�Ҹ�����ַ';
COMMENT ON column scmdata.t_ask_record.SUPPLIER_OFFICE is '��ƷͼƬ������ַ';
COMMENT ON column scmdata.t_ask_record.SUPPLIER_SITE is '�����ֳ�������ַ';
COMMENT ON column scmdata.t_ask_record.BRAND_TYPE is '����Ʒ��/�ͻ� ����';
COMMENT ON column scmdata.t_ask_record.COOPERATION_BRAND is '����Ʒ��/�ͻ�';
COMMENT ON column scmdata.t_ask_record.PRODUCT_LINK is '��������';
COMMENT ON column scmdata.t_ask_record.COMPANY_ABBREVIATION is '��˾���';
COMMENT ON column scmdata.t_ask_record.COMPANY_TYPE is '��˾����--��Ӧ�鳧COMPANY_MOLD';
COMMENT ON column scmdata.t_ask_record.LEGAL_REPRESENTATIVE is '����������';
COMMENT ON column scmdata.t_ask_record.COMPANY_CONTACT_PHONE is '��˾��ϵ���ֻ�';

--2.scmdata.t_factory_ask
alter table scmdata.t_factory_ask add (MEMO	VARCHAR2(600));
alter table scmdata.t_factory_ask add (PRODUCT_LINK	VARCHAR2(148));
alter table scmdata.t_factory_ask add (WORKER_NUM	VARCHAR2(32));
alter table scmdata.t_factory_ask add (MACHINE_NUM	VARCHAR2(32));
alter table scmdata.t_factory_ask add (RESERVE_CAPACITY	NUMBER(10,2));
alter table scmdata.t_factory_ask add (PRODUCT_EFFICIENCY	NUMBER(10,2));
alter table scmdata.t_factory_ask add (WORK_HOURS_DAY	NUMBER(10,1));
alter table scmdata.t_factory_ask add (BRAND_TYPE	VARCHAR2(4000));
alter table scmdata.t_factory_ask add (COOPERATION_BRAND	VARCHAR2(4000));
alter table scmdata.t_factory_ask add (PRODUCT_TYPE	VARCHAR2(32));
alter table scmdata.t_factory_ask add (WORK_HOURS_DAY	NUMBER(10,1));
alter table scmdata.t_factory_ask add (BRAND_TYPE	VARCHAR2(4000));
alter table scmdata.t_factory_ask add (COOPERATION_BRAND	VARCHAR2(4000));
alter table scmdata.t_factory_ask add (PRODUCT_TYPE	VARCHAR2(32));
alter table scmdata.t_factory_ask add (IS_URGENT	NUMBER(1));
alter table scmdata.t_factory_ask add (SUPPLIER_GATE	VARCHAR2(256));
alter table scmdata.t_factory_ask add (SUPPLIER_OFFICE	VARCHAR2(256));
alter table scmdata.t_factory_ask add (SUPPLIER_SITE	VARCHAR2(256));
alter table scmdata.t_factory_ask add (SUPPLIER_PRODUCT	VARCHAR2(256));
alter table scmdata.t_factory_ask add (CERTIFICATE_FILE	VARCHAR2(256));
alter table scmdata.t_factory_ask add (COM_MANUFACTURER	VARCHAR2(32));
alter table scmdata.t_factory_ask add (COMPANY_CONTACT_PHONE	VARCHAR2(148));
alter table scmdata.t_factory_ask add (COMPANY_MOLD	VARCHAR2(148));
alter table scmdata.t_factory_ask add (LEGAL_REPRESENTATIVE	VARCHAR2(148));
alter table scmdata.t_factory_ask add (COMPANY_ABBREVIATION	VARCHAR2(148));
COMMENT ON column scmdata.t_factory_ask.COMPANY_ABBREVIATION is '��˾���';
COMMENT ON column scmdata.t_factory_ask.LEGAL_REPRESENTATIVE is '����������';
COMMENT ON column scmdata.t_factory_ask.COMPANY_MOLD is '��˾����';
COMMENT ON column scmdata.t_factory_ask.COMPANY_CONTACT_PHONE is '��˾��ϵ�绰';
COMMENT ON column scmdata.t_factory_ask.COM_MANUFACTURER is '����������������';
COMMENT ON column scmdata.t_factory_ask.CERTIFICATE_FILE is 'Ӫҵִ��';
COMMENT ON column scmdata.t_factory_ask.IS_URGENT is '�Ƿ����';
COMMENT ON column scmdata.t_factory_ask.SUPPLIER_GATE is '��˾���Ÿ�����ַ';
COMMENT ON column scmdata.t_factory_ask.SUPPLIER_OFFICE is '��˾�칫�Ҹ�����ַ';
COMMENT ON column scmdata.t_factory_ask.SUPPLIER_SITE is '�����ֳ�������ַ';
COMMENT ON column scmdata.t_factory_ask.SUPPLIER_PRODUCT is '��ƷͼƬ������ַ';
COMMENT ON column scmdata.t_factory_ask.PRODUCT_TYPE is '��������';
COMMENT ON column scmdata.t_factory_ask.BRAND_TYPE is '����Ʒ��/�ͻ� ����';
COMMENT ON column scmdata.t_factory_ask.COOPERATION_BRAND is '����Ʒ��/�ͻ�';
COMMENT ON column scmdata.t_factory_ask.WORKER_NUM is '��λ����';
COMMENT ON column scmdata.t_factory_ask.MACHINE_NUM is '֯��̨��';
COMMENT ON column scmdata.t_factory_ask.RESERVE_CAPACITY is 'ԤԼ����ռ��';
COMMENT ON column scmdata.t_factory_ask.PRODUCT_EFFICIENCY is '����Ч��';
COMMENT ON column scmdata.t_factory_ask.WORK_HOURS_DAY is '�ϰ�ʱ��/��';
COMMENT ON column scmdata.t_factory_ask.MEMO is '��ע';
COMMENT ON column scmdata.t_factory_ask.PRODUCT_LINK is '��������';

--3.T_FACTORY_REPORT
alter table scmdata.T_FACTORY_REPORT add (ADMIT_RESULT	VARCHAR2(32));
alter table scmdata.T_FACTORY_REPORT add (IS_TRIALORDER	NUMBER(1));
alter table scmdata.T_FACTORY_REPORT add (PRODUCT_LINE	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (PRODUCT_LINE_NUM	VARCHAR2(32));
alter table scmdata.T_FACTORY_REPORT add (WORKER_NUM	VARCHAR2(32));
alter table scmdata.T_FACTORY_REPORT add (MACHINE_NUM	VARCHAR2(32));
alter table scmdata.T_FACTORY_REPORT add (QUALITY_STEP	VARCHAR2(32));
alter table scmdata.T_FACTORY_REPORT add (PATTERN_CAP	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (FABRIC_PURCHASE_CAP	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (FABRIC_CHECK_CAP	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (COST_STEP	VARCHAR2(148));
--alter table scmdata.T_FACTORY_REPORT add (COST_STEP	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (CHECK_PERSON1	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (CHECK_PERSON1_PHONE	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (CHECK_PERSON2	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (CHECK_PERSON2_PHONE	VARCHAR2(48));
alter table scmdata.T_FACTORY_REPORT add (CERTIFICATE_FILE	VARCHAR2(256));
alter table scmdata.T_FACTORY_REPORT add (SUPPLIER_GATE	VARCHAR2(256));
alter table scmdata.T_FACTORY_REPORT add (SUPPLIER_OFFICE	VARCHAR2(256));
alter table scmdata.T_FACTORY_REPORT add (SUPPLIER_SITE	VARCHAR2(256));
alter table scmdata.T_FACTORY_REPORT add (SUPPLIER_PRODUCT	VARCHAR2(256));
alter table scmdata.T_FACTORY_REPORT add (FACTORY_RESULT_SUGGEST	VARCHAR2(256));
alter table scmdata.T_FACTORY_REPORT add (TRIALORDER_TYPE	VARCHAR2(32));
alter table scmdata.T_FACTORY_REPORT add (AUDIT_COMMENT	VARCHAR2(256));
alter table scmdata.T_FACTORY_REPORT add (RESERVE_CAPACITY	NUMBER(10,2));
alter table scmdata.T_FACTORY_REPORT add (PRODUCT_EFFICIENCY	NUMBER(10,2));
alter table scmdata.T_FACTORY_REPORT add (WORK_HOURS_DAY	NUMBER(10,2));

COMMENT ON column scmdata.T_FACTORY_REPORT.ADMIT_RESULT is '׼����(����)';
COMMENT ON column scmdata.T_FACTORY_REPORT.IS_TRIALORDER is '�Ƿ��Ե�';
COMMENT ON column scmdata.T_FACTORY_REPORT.PRODUCT_LINE is '����������';
COMMENT ON column scmdata.T_FACTORY_REPORT.PRODUCT_LINE_NUM is '����������';
--COMMENT ON column scmdata.T_FACTORY_REPORT.COMPANY_ABBREVIATION is '��˾���';
COMMENT ON column scmdata.T_FACTORY_REPORT.WORKER_NUM is '��λ����';
COMMENT ON column scmdata.T_FACTORY_REPORT.MACHINE_NUM is '֯��̨��';
COMMENT ON column scmdata.T_FACTORY_REPORT.QUALITY_STEP is '�����ȼ�';
COMMENT ON column scmdata.T_FACTORY_REPORT.PATTERN_CAP is '�������';
COMMENT ON column scmdata.T_FACTORY_REPORT.FABRIC_PURCHASE_CAP is '���ϲɹ�����';
COMMENT ON column scmdata.T_FACTORY_REPORT.FABRIC_CHECK_CAP is '���ϼ������';
COMMENT ON column scmdata.T_FACTORY_REPORT.COST_STEP is '�ɱ��ȼ�';
COMMENT ON column scmdata.T_FACTORY_REPORT.CHECK_PERSON1 is '�鳧��Ա1';
COMMENT ON column scmdata.T_FACTORY_REPORT.CHECK_PERSON1_PHONE is '�鳧��Ա1��ϵ�绰';
COMMENT ON column scmdata.T_FACTORY_REPORT.CHECK_PERSON2 is '�鳧��Ա2';
COMMENT ON column scmdata.T_FACTORY_REPORT.CHECK_PERSON2_PHONE is '�鳧��Ա2��ϵ�绰';
COMMENT ON column scmdata.T_FACTORY_REPORT.CERTIFICATE_FILE is 'Ӫҵִ��';
COMMENT ON column scmdata.T_FACTORY_REPORT.SUPPLIER_GATE is '��˾���Ÿ�����ַ';
COMMENT ON column scmdata.T_FACTORY_REPORT.SUPPLIER_OFFICE is '��˾�칫�Ҹ�����ַ';
COMMENT ON column scmdata.T_FACTORY_REPORT.SUPPLIER_SITE is '�����ֳ�������ַ';
COMMENT ON column scmdata.T_FACTORY_REPORT.SUPPLIER_PRODUCT is '��ƷͼƬ������ַ';
COMMENT ON column scmdata.T_FACTORY_REPORT.FACTORY_RESULT_SUGGEST is '�鳧�������';
COMMENT ON column scmdata.T_FACTORY_REPORT.TRIALORDER_TYPE is '�Ե�ģʽ';
COMMENT ON column scmdata.T_FACTORY_REPORT.AUDIT_COMMENT is '��˽���';
COMMENT ON column scmdata.T_FACTORY_REPORT.RESERVE_CAPACITY is 'ԤԼ����ռ��';
COMMENT ON column scmdata.T_FACTORY_REPORT.PRODUCT_EFFICIENCY is '����Ч��';
COMMENT ON column scmdata.T_FACTORY_REPORT.WORK_HOURS_DAY is '�ϰ�ʱ��/��';

--4.T_SUPPLIER_GROUP_CONFIG
-- Create table
create table T_SUPPLIER_GROUP_CONFIG
(
  group_config_id   VARCHAR2(32) not null,
  group_name        VARCHAR2(32) not null,
  area_group_leader VARCHAR2(32) not null,
  effective_time    DATE not null,
  end_time          DATE not null,
  config_status     NUMBER(1) default 0,
  pause             NUMBER(1) default 0,
  remarks           VARCHAR2(256),
  create_id         VARCHAR2(32),
  create_time       DATE,
  update_id         VARCHAR2(32),
  update_time       DATE,
  company_id        VARCHAR2(32) not null
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
comment on table T_SUPPLIER_GROUP_CONFIG
  is '���ڷ�������';
-- Add comments to the columns 
comment on column T_SUPPLIER_GROUP_CONFIG.group_config_id
  is '���ڷ�������ID(����)';
comment on column T_SUPPLIER_GROUP_CONFIG.group_name
  is '��������';
comment on column T_SUPPLIER_GROUP_CONFIG.area_group_leader
  is '�����鳤';
comment on column T_SUPPLIER_GROUP_CONFIG.effective_time
  is '��Чʱ��';
comment on column T_SUPPLIER_GROUP_CONFIG.end_time
  is '����ʱ��';
comment on column T_SUPPLIER_GROUP_CONFIG.config_status
  is '�����Ƿ���Ч��0������Ч 1 ����Ч��;Ĭ�ϲ���Ч';
comment on column T_SUPPLIER_GROUP_CONFIG.pause
  is '��ͣ״̬��0��ͣ��  1�����ã���Ĭ��ͣ��';
comment on column T_SUPPLIER_GROUP_CONFIG.remarks
  is '��ע';
comment on column T_SUPPLIER_GROUP_CONFIG.create_id
  is '������';
comment on column T_SUPPLIER_GROUP_CONFIG.create_time
  is '����ʱ��';
comment on column T_SUPPLIER_GROUP_CONFIG.update_id
  is '�޸���';
comment on column T_SUPPLIER_GROUP_CONFIG.update_time
  is '�޸�ʱ��';
comment on column T_SUPPLIER_GROUP_CONFIG.company_id
  is '��ҵID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SUPPLIER_GROUP_CONFIG
  add constraint PK_GROUP_CONFIG_ID primary key (GROUP_CONFIG_ID)
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
alter index PK_GROUP_CONFIG_ID nologging;

--5.T_SUPPLIER_GROUP_AREA_CONFIG
-- Create table
create table T_SUPPLIER_GROUP_AREA_CONFIG
(
  group_area_config_id VARCHAR2(32) not null,
  company_id           VARCHAR2(32) not null,
  province_id          VARCHAR2(4000) not null,
  city_id              VARCHAR2(4000) not null,
  pause                NUMBER(1) default 1,
  remarks              VARCHAR2(256),
  create_id            VARCHAR2(32),
  create_time          DATE,
  update_id            VARCHAR2(32),
  update_time          DATE,
  is_nationwide        NUMBER(1),
  is_province_allcity  NUMBER(1),
  area_name            VARCHAR2(256),
  group_area           CLOB
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
comment on table T_SUPPLIER_GROUP_AREA_CONFIG
  is '��������';
-- Add comments to the columns 
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.group_area_config_id
  is '��������ID��������';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.company_id
  is '��˾ID';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.province_id
  is 'ʡ';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.city_id
  is '��';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.pause
  is '��ͣ״̬��0��ͣ�� 1�����ã�';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.remarks
  is '��ע';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.create_id
  is '������';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.create_time
  is '����ʱ��';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.update_id
  is '�޸���';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.update_time
  is '�޸�ʱ��';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.is_nationwide
  is '�Ƿ�ȫ������������ʡ����  1����     0 ����';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.is_province_allcity
  is '�Ƿ����ʡ�����У�1����  0����';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.area_name
  is '��������';
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.group_area
  is '��������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SUPPLIER_GROUP_AREA_CONFIG
  add constraint PK_GROUP_AREA_CONFIG_ID primary key (GROUP_AREA_CONFIG_ID)
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
alter index PK_GROUP_AREA_CONFIG_ID nologging;

--6.T_SUPPLIER_GROUP_CATEGORY_CONFIG
-- Create table
create table T_SUPPLIER_GROUP_CATEGORY_CONFIG
(
  group_category_config_id   VARCHAR2(32) not null,
  company_id                 VARCHAR2(32) not null,
  group_config_id            VARCHAR2(32) not null,
  cooperation_classification VARCHAR2(32) not null,
  cooperation_product_cate   VARCHAR2(4000) not null,
  pause                      NUMBER(1) default 1,
  remarks                    VARCHAR2(256),
  create_id                  VARCHAR2(32),
  create_time                DATE,
  update_id                  VARCHAR2(32),
  update_time                DATE,
  area_name                  VARCHAR2(4000),
  area_config_id             VARCHAR2(4000)
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
comment on table T_SUPPLIER_GROUP_CATEGORY_CONFIG
  is 'Ʒ�ࡢ��������';
-- Add comments to the columns 
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.group_category_config_id
  is '����Ʒ��ID(����)';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.company_id
  is '��ҵID';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.group_config_id
  is '������������ID�������';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.cooperation_classification
  is '�����������';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.cooperation_product_cate
  is '�����������';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.pause
  is '��ͣ״̬��0��ͣ�� 1�����ã�';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.remarks
  is '��ע';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.create_id
  is '������';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.create_time
  is '����ʱ��';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.update_id
  is '�޸���';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.update_time
  is '�޸�ʱ��';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.area_name
  is '��������';
comment on column T_SUPPLIER_GROUP_CATEGORY_CONFIG.area_config_id
  is '��������ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SUPPLIER_GROUP_CATEGORY_CONFIG
  add constraint PK_GROUP_CATEGORY_CONFIG_ID primary key (GROUP_CATEGORY_CONFIG_ID)
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
alter index PK_GROUP_CATEGORY_CONFIG_ID nologging;
alter table T_SUPPLIER_GROUP_CATEGORY_CONFIG
  add constraint FK_GROUP_CONFIG_ID_CATE foreign key (GROUP_CONFIG_ID)
  references T_SUPPLIER_GROUP_CONFIG (GROUP_CONFIG_ID);

--7.T_SUPPLIER_INFO
alter table scmdata.T_SUPPLIER_INFO add (GROUP_NAME	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.GROUP_NAME is '��������';
alter table scmdata.T_SUPPLIER_INFO add (COOP_POSITION	VARCHAR2(48));
COMMENT ON column scmdata.T_SUPPLIER_INFO.COOP_POSITION is '������λ';
alter table scmdata.T_SUPPLIER_INFO add (PRODUCT_LINE	VARCHAR2(48));
COMMENT ON column scmdata.T_SUPPLIER_INFO.PRODUCT_LINE is '����������';
alter table scmdata.T_SUPPLIER_INFO add (PRODUCT_LINE_NUM	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.PRODUCT_LINE_NUM is '����������';
alter table scmdata.T_SUPPLIER_INFO add (WORKER_NUM	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.WORKER_NUM is '��λ����';
alter table scmdata.T_SUPPLIER_INFO add (MACHINE_NUM	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.MACHINE_NUM is '֯��̨��';
alter table scmdata.T_SUPPLIER_INFO add (QUALITY_STEP	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.QUALITY_STEP is '�����ȼ�';
alter table scmdata.T_SUPPLIER_INFO add (PATTERN_CAP	VARCHAR2(48));
COMMENT ON column scmdata.T_SUPPLIER_INFO.PATTERN_CAP is '�������';
alter table scmdata.T_SUPPLIER_INFO add (FABRIC_PURCHASE_CAP	VARCHAR2(48));
COMMENT ON column scmdata.T_SUPPLIER_INFO.FABRIC_PURCHASE_CAP is '���ϲɹ�����';
alter table scmdata.T_SUPPLIER_INFO add (FABRIC_CHECK_CAP	VARCHAR2(48));
COMMENT ON column scmdata.T_SUPPLIER_INFO.FABRIC_CHECK_CAP is '���ϼ������';
alter table scmdata.T_SUPPLIER_INFO add (COST_STEP	VARCHAR2(48));
COMMENT ON column scmdata.T_SUPPLIER_INFO.COST_STEP is '�ɱ��ȼ�';
alter table scmdata.T_SUPPLIER_INFO add (BRAND_TYPE	VARCHAR2(4000));
COMMENT ON column scmdata.T_SUPPLIER_INFO.BRAND_TYPE is '����Ʒ��/�ͻ� ����';
alter table scmdata.T_SUPPLIER_INFO add (PRODUCT_TYPE	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.PRODUCT_TYPE is '��������';
alter table scmdata.T_SUPPLIER_INFO add (PRODUCT_LINK	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.PRODUCT_LINK is '��������';
alter table scmdata.T_SUPPLIER_INFO add (FA_CONTACT_NAME	VARCHAR2(48));
COMMENT ON column scmdata.T_SUPPLIER_INFO.FA_CONTACT_NAME is 'ҵ����ϵ��';
alter table scmdata.T_SUPPLIER_INFO add (FA_CONTACT_PHONE	VARCHAR2(48));
COMMENT ON column scmdata.T_SUPPLIER_INFO.FA_CONTACT_PHONE is 'ҵ����ϵ���ֻ�';
alter table scmdata.T_SUPPLIER_INFO add (COOPERATION_BRAND	VARCHAR2(4000));
COMMENT ON column scmdata.T_SUPPLIER_INFO.COOPERATION_BRAND is '����Ʒ��/�ͻ�';
alter table scmdata.T_SUPPLIER_INFO add (GENDAN_PERID	VARCHAR2(256));
COMMENT ON column scmdata.T_SUPPLIER_INFO.GENDAN_PERID is '����ԱID';
alter table scmdata.T_SUPPLIER_INFO add (SUPPLIER_GATE	VARCHAR2(256));
COMMENT ON column scmdata.T_SUPPLIER_INFO.SUPPLIER_GATE is '��˾���Ÿ�����ַ';
alter table scmdata.T_SUPPLIER_INFO add (SUPPLIER_OFFICE	VARCHAR2(256));
COMMENT ON column scmdata.T_SUPPLIER_INFO.SUPPLIER_OFFICE is '��˾�칫�Ҹ�����ַ';
alter table scmdata.T_SUPPLIER_INFO add (SUPPLIER_PRODUCT	VARCHAR2(256));
COMMENT ON column scmdata.T_SUPPLIER_INFO.SUPPLIER_PRODUCT is '��ƷͼƬ������ַ';
alter table scmdata.T_SUPPLIER_INFO add (SUPPLIER_SITE	VARCHAR2(256));
COMMENT ON column scmdata.T_SUPPLIER_INFO.SUPPLIER_SITE is '�����ֳ�������ַ';
alter table scmdata.T_SUPPLIER_INFO add (FILE_REMARK	VARCHAR2(256));
COMMENT ON column scmdata.T_SUPPLIER_INFO.FILE_REMARK is '������ע';
alter table scmdata.T_SUPPLIER_INFO add (RESERVE_CAPACITY	NUMBER(10,2));
COMMENT ON column scmdata.T_SUPPLIER_INFO.RESERVE_CAPACITY is 'ԤԼ����ռ��';
alter table scmdata.T_SUPPLIER_INFO add (PRODUCT_EFFICIENCY	NUMBER(10,2));
COMMENT ON column scmdata.T_SUPPLIER_INFO.PRODUCT_EFFICIENCY is '����Ч��';
alter table scmdata.T_SUPPLIER_INFO add (WORK_HOURS_DAY	NUMBER(10,1));
COMMENT ON column scmdata.T_SUPPLIER_INFO.WORK_HOURS_DAY is '�ϰ�ʱ��/��';
alter table scmdata.T_SUPPLIER_INFO add (AREA_GROUP_LEADER	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.AREA_GROUP_LEADER is '�����鳤';
alter table scmdata.T_SUPPLIER_INFO add (COOP_STATE	VARCHAR2(32));
COMMENT ON column scmdata.T_SUPPLIER_INFO.COOP_STATE is '����״̬';

--8.T_COOP_SCOPE
alter table scmdata.T_COOP_SCOPE add (COOP_STATE	VARCHAR2(32));
COMMENT ON column scmdata.T_COOP_SCOPE.COOP_STATE is '����״̬';

--9.T_CONTRACT_INFO_TEMP
-- Create table
create table T_CONTRACT_INFO_TEMP
(
  contract_info_id      VARCHAR2(32),
  supplier_info_id      VARCHAR2(32),
  company_id            VARCHAR2(32),
  contract_start_date   DATE,
  contract_stop_date    DATE,
  contract_sign_date    DATE,
  contract_file         VARCHAR2(256),
  contract_type         VARCHAR2(32),
  contract_num          VARCHAR2(32),
  operator_id           VARCHAR2(48),
  operate_time          DATE,
  change_id             VARCHAR2(48),
  change_time           DATE,
  user_id               VARCHAR2(48),
  user_name             VARCHAR2(48),
  temp_id               VARCHAR2(48),
  msg_type              VARCHAR2(32),
  msg                   VARCHAR2(3000),
  inside_supplier_code  VARCHAR2(32),
  supplier_company_name VARCHAR2(148),
  create_id             VARCHAR2(48),
  create_time           DATE
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
comment on table T_CONTRACT_INFO_TEMP
  is '��ͬ��Ϣ��ʱ��';
-- Add comments to the columns 
comment on column T_CONTRACT_INFO_TEMP.contract_info_id
  is '��ͬ���';
comment on column T_CONTRACT_INFO_TEMP.supplier_info_id
  is '��Ӧ�̵������';
comment on column T_CONTRACT_INFO_TEMP.company_id
  is '��˾���';
comment on column T_CONTRACT_INFO_TEMP.contract_start_date
  is '��ʼ����';
comment on column T_CONTRACT_INFO_TEMP.contract_stop_date
  is '��������';
comment on column T_CONTRACT_INFO_TEMP.contract_sign_date
  is 'ǩ������';
comment on column T_CONTRACT_INFO_TEMP.contract_file
  is '����';
comment on column T_CONTRACT_INFO_TEMP.contract_type
  is '��ͬ����';
comment on column T_CONTRACT_INFO_TEMP.contract_num
  is '��ͬ����';
comment on column T_CONTRACT_INFO_TEMP.operator_id
  is '������ID';
comment on column T_CONTRACT_INFO_TEMP.operate_time
  is '����ʱ��';
comment on column T_CONTRACT_INFO_TEMP.change_id
  is '������ID';
comment on column T_CONTRACT_INFO_TEMP.change_time
  is '����ʱ��';
comment on column T_CONTRACT_INFO_TEMP.create_id
  is '������';
comment on column T_CONTRACT_INFO_TEMP.create_time
  is '����ʱ��';
  
--10.T_CONTRACT_INFO
alter table scmdata.T_CONTRACT_INFO add (CHANGE_ID	VARCHAR2(48));
COMMENT ON column scmdata.T_CONTRACT_INFO.CHANGE_ID is '������ID';
alter table scmdata.T_CONTRACT_INFO add (CHANGE_TIME	DATE);
COMMENT ON column scmdata.T_CONTRACT_INFO.CHANGE_TIME is '����ʱ��';
alter table scmdata.T_CONTRACT_INFO add (OPERATOR_ID	VARCHAR2(48));
COMMENT ON column scmdata.T_CONTRACT_INFO.OPERATOR_ID is '������ID';
alter table scmdata.T_CONTRACT_INFO add (OPERATE_TIME	DATE);
COMMENT ON column scmdata.T_CONTRACT_INFO.OPERATE_TIME is '����ʱ��';
alter table scmdata.T_CONTRACT_INFO add (CONTRACT_NUM	VARCHAR2(32));
COMMENT ON column scmdata.T_CONTRACT_INFO.CONTRACT_NUM is '��ͬ����';
alter table scmdata.T_CONTRACT_INFO add (CONTRACT_TYPE	VARCHAR2(32));
COMMENT ON column scmdata.T_CONTRACT_INFO.CONTRACT_TYPE is '��ͬ����';

--11.T_SUPPLIER_PERFORM
-- Create table
create table T_SUPPLIER_PERFORM
(
  sp_record_id       VARCHAR2(32) not null,
  supplier_info_id   VARCHAR2(32) not null,
  company_id         VARCHAR2(32) not null,
  kaoh_limit         VARCHAR2(32),
  buh_svg_limit      VARCHAR2(32),
  order_content_rate VARCHAR2(32),
  order_ontime_rate  VARCHAR2(32),
  store_return_rate  VARCHAR2(32),
  shop_return_rate   VARCHAR2(32),
  qoute_rate         VARCHAR2(32),
  rale_qoute_rate    VARCHAR2(48),
  custom_prior       VARCHAR2(32),
  account_cap        VARCHAR2(48),
  response_qs        VARCHAR2(48)
)
tablespace SCMDATA
  pctfree 10
  initrans 1
  maxtrans 255
nologging;
-- Add comments to the table 
comment on table T_SUPPLIER_PERFORM
  is '��Ч��¼';
-- Add comments to the columns 
comment on column T_SUPPLIER_PERFORM.sp_record_id
  is '��Ч��¼���';
comment on column T_SUPPLIER_PERFORM.supplier_info_id
  is '��Ӧ�̵������';
comment on column T_SUPPLIER_PERFORM.company_id
  is '��˾���';
comment on column T_SUPPLIER_PERFORM.kaoh_limit
  is '������';
comment on column T_SUPPLIER_PERFORM.buh_svg_limit
  is '����ƽ������';
comment on column T_SUPPLIER_PERFORM.order_content_rate
  is '����������';
comment on column T_SUPPLIER_PERFORM.order_ontime_rate
  is '����׼����';
comment on column T_SUPPLIER_PERFORM.store_return_rate
  is '�ֿ��˻���';
comment on column T_SUPPLIER_PERFORM.shop_return_rate
  is '�ŵ��˻���';
comment on column T_SUPPLIER_PERFORM.qoute_rate
  is '����ƫ����';
comment on column T_SUPPLIER_PERFORM.rale_qoute_rate
  is 'ʵ��ƫ����';
comment on column T_SUPPLIER_PERFORM.custom_prior
  is '�ͻ����ȴ���';
comment on column T_SUPPLIER_PERFORM.account_cap
  is '����ռ��';
comment on column T_SUPPLIER_PERFORM.response_qs
  is '������Ӧ';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SUPPLIER_PERFORM
  add constraint PK_SP_RECORD_ID primary key (SP_RECORD_ID)
  using index 
  tablespace SCMDATA
  pctfree 10
  initrans 2
  maxtrans 255;
alter index PK_SP_RECORD_ID nologging;

