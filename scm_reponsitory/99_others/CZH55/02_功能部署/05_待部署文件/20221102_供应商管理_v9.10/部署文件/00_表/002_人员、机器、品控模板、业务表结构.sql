--1. Create table ��Ա����ģ���
create table SCMDATA.T_PERSON_CONFIG
(
  person_config_id  VARCHAR2(32) not null,
  company_id        VARCHAR2(32),
  person_role_id    VARCHAR2(32),
  department_id     VARCHAR2(32),
  person_job_id     VARCHAR2(32),
  apply_category_id VARCHAR2(32),
  job_state         VARCHAR2(4000),
  seqno             NUMBER(2),
  pause             NUMBER(1),
  remarks           VARCHAR2(4000),
  update_id         VARCHAR2(32),
  update_time       DATE,
  create_id         VARCHAR2(32),
  create_time       DATE
);
comment on table SCMDATA.T_PERSON_CONFIG
  is '��Ա����ģ���';
comment on column SCMDATA.T_PERSON_CONFIG.person_config_id
  is '��Ա����ģ������ID';
comment on column SCMDATA.T_PERSON_CONFIG.company_id
  is '��ҵID';
comment on column SCMDATA.T_PERSON_CONFIG.person_role_id
  is 'ְ��ID';
comment on column SCMDATA.T_PERSON_CONFIG.department_id
  is '����ID';
comment on column SCMDATA.T_PERSON_CONFIG.person_job_id
  is '��λID';
comment on column SCMDATA.T_PERSON_CONFIG.apply_category_id
  is '�������ID';
comment on column SCMDATA.T_PERSON_CONFIG.job_state
  is '��λ˵��';
comment on column SCMDATA.T_PERSON_CONFIG.seqno
  is '���';
comment on column SCMDATA.T_PERSON_CONFIG.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_PERSON_CONFIG.remarks
  is '��ע';
comment on column SCMDATA.T_PERSON_CONFIG.update_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG.update_time
  is '����ʱ��';
comment on column SCMDATA.T_PERSON_CONFIG.create_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG.create_time
  is '����ʱ��';

alter table SCMDATA.T_PERSON_CONFIG add CONSTRAINT PK_PERSON_CONFIG primary key (PERSON_CONFIG_ID) using index ;

--2. Create table �����豸ģ���
create table SCMDATA.T_MACHINE_EQUIPMENT
(
  machine_equipment_id  VARCHAR2(32) not null,
  company_id            VARCHAR2(32),
  equipment_category_id VARCHAR2(64),
  equipment_name        VARCHAR2(64),
  seqno                 NUMBER(2),
  pause                 NUMBER(1),
  remarks               VARCHAR2(4000),
  update_id             VARCHAR2(32),
  update_time           DATE,
  create_id             VARCHAR2(32),
  create_time           DATE,
  template_type         VARCHAR2(32)
);
-- Add comments to the table 
comment on table SCMDATA.T_MACHINE_EQUIPMENT
  is '�����豸ģ���';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.machine_equipment_id
  is '�����豸ģ������ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.company_id
  is '��ҵID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.equipment_category_id
  is '�豸����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.equipment_name
  is '�豸����';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.seqno
  is '���';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.remarks
  is '��ע';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.update_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.update_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.create_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.create_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.template_type
  is 'ģ�����';

alter table SCMDATA.T_MACHINE_EQUIPMENT add constraint PK_MACHINE_EQUIPMENT primary key (MACHINE_EQUIPMENT_ID) using index ;

--3. Create table Ʒ����ϵģ���
create table SCMDATA.T_QUALITY_CONTROL
(
  quality_control_id      VARCHAR2(32) not null,
  company_id              VARCHAR2(32),
  department_id           VARCHAR2(32),
  quality_control_link_id VARCHAR2(64),
  seqno                   NUMBER(2),
  pause                   NUMBER(1),
  remarks                 VARCHAR2(4000),
  update_id               VARCHAR2(32),
  update_time             DATE,
  create_id               VARCHAR2(32),
  create_time             DATE
);
-- Add comments to the table 
comment on table SCMDATA.T_QUALITY_CONTROL
  is 'Ʒ����ϵģ���';
comment on column SCMDATA.T_QUALITY_CONTROL.quality_control_id
  is 'Ʒ����ϵģ������ID';
comment on column SCMDATA.T_QUALITY_CONTROL.company_id
  is '��ҵID';
comment on column SCMDATA.T_QUALITY_CONTROL.department_id
  is '����ID';
comment on column SCMDATA.T_QUALITY_CONTROL.quality_control_link_id
  is 'Ʒ�ػ���ID';
comment on column SCMDATA.T_QUALITY_CONTROL.seqno
  is '���';
comment on column SCMDATA.T_QUALITY_CONTROL.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_QUALITY_CONTROL.remarks
  is '��ע';
comment on column SCMDATA.T_QUALITY_CONTROL.update_id
  is '������';
comment on column SCMDATA.T_QUALITY_CONTROL.update_time
  is '����ʱ��';
comment on column SCMDATA.T_QUALITY_CONTROL.create_id
  is '������';
comment on column SCMDATA.T_QUALITY_CONTROL.create_time
  is '����ʱ��';
alter table SCMDATA.T_QUALITY_CONTROL add CONSTRAINT PK_QUALITY_CONTROL primary key (QUALITY_CONTROL_ID) using index;


--4. Create table ��Ա���ñ�(�鳧����)
create table SCMDATA.T_PERSON_CONFIG_FR
(
  person_config_id  VARCHAR2(32) not null,
  factory_report_id VARCHAR2(32),
  company_id        VARCHAR2(32),
  person_role_id    VARCHAR2(32),
  department_id     VARCHAR2(32),
  person_job_id     VARCHAR2(32),
  apply_category_id VARCHAR2(32),
  job_state         VARCHAR2(4000),
  person_num        NUMBER,
  seqno             NUMBER(2),
  pause             NUMBER(1),
  remarks           VARCHAR2(4000),
  update_id         VARCHAR2(32),
  update_time       DATE,
  create_id         VARCHAR2(32),
  create_time       DATE
);
-- Add comments to the table 
comment on table SCMDATA.T_PERSON_CONFIG_FR
  is '��Ա���ñ�(�鳧����)';
comment on column SCMDATA.T_PERSON_CONFIG_FR.person_config_id
  is '��Ա���ñ�(�鳧����)����ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.factory_report_id
  is '�鳧����ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.company_id
  is '��ҵID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.person_role_id
  is 'ְ��ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.department_id
  is '����ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.person_job_id
  is '��λID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.apply_category_id
  is '�������ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.job_state
  is '��λ˵��';
comment on column SCMDATA.T_PERSON_CONFIG_FR.person_num
  is '��Ա����';
comment on column SCMDATA.T_PERSON_CONFIG_FR.seqno
  is '���';
comment on column SCMDATA.T_PERSON_CONFIG_FR.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_PERSON_CONFIG_FR.remarks
  is '��ע';
comment on column SCMDATA.T_PERSON_CONFIG_FR.update_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG_FR.update_time
  is '����ʱ��';
comment on column SCMDATA.T_PERSON_CONFIG_FR.create_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG_FR.create_time
  is '����ʱ��';

alter table SCMDATA.T_PERSON_CONFIG_FR add CONSTRAINT PK_PERSON_CONFIG_FR primary key (PERSON_CONFIG_ID) using index ;

--5. Create table �����豸��(�鳧����)
create table SCMDATA.T_MACHINE_EQUIPMENT_FR
(
  machine_equipment_id  VARCHAR2(32) not null,
  factory_report_id     VARCHAR2(32),
  company_id            VARCHAR2(32),
  equipment_category_id VARCHAR2(64),
  equipment_name        VARCHAR2(64),
  seqno                 NUMBER(2),
  orgin                 VARCHAR2(2),
  machine_num           NUMBER,
  pause                 NUMBER(1),
  remarks               VARCHAR2(4000),
  update_id             VARCHAR2(32),
  update_time           DATE,
  create_id             VARCHAR2(32),
  create_time           DATE
);
-- Add comments to the table 
comment on table SCMDATA.T_MACHINE_EQUIPMENT_FR
  is '�����豸��(�鳧����)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.machine_equipment_id
  is '�����豸(�鳧����)����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.factory_report_id
  is '�鳧����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.company_id
  is '��ҵID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.equipment_category_id
  is '�豸����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.equipment_name
  is '�豸����';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.seqno
  is '���';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.orgin
  is '��Դ';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.machine_num
  is '�豸����';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.remarks
  is '��ע';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.update_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.update_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.create_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.create_time
  is '����ʱ��';

alter table SCMDATA.T_MACHINE_EQUIPMENT_FR add CONSTRAINT PK_MACHINE_EQUIPMENT_FR primary key (MACHINE_EQUIPMENT_ID) using index;

--6. Create table Ʒ����ϵ��(�鳧����)
create table SCMDATA.T_QUALITY_CONTROL_FR
(
  quality_control_id      VARCHAR2(32) not null,
  factory_report_id       VARCHAR2(32),
  company_id              VARCHAR2(32),
  department_id           VARCHAR2(32),
  quality_control_link_id VARCHAR2(64),
  is_quality_control      NUMBER(1),
  seqno                   NUMBER(2),
  pause                   NUMBER(1),
  remarks                 VARCHAR2(4000),
  update_id               VARCHAR2(32),
  update_time             DATE,
  create_id               VARCHAR2(32),
  create_time             DATE
);
-- Add comments to the table 
comment on table SCMDATA.T_QUALITY_CONTROL_FR
  is 'Ʒ����ϵ��(�鳧����)';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.quality_control_id
  is 'Ʒ����ϵ��(�鳧����)����ID';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.company_id
  is '��ҵID';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.department_id
  is '����ID';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.quality_control_link_id
  is 'Ʒ�ػ���ID';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.is_quality_control
  is '�Ƿ���Ʒ�ؼ�¼(0��,1��)';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.seqno
  is '���';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.remarks
  is '��ע';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.update_id
  is '������';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.update_time
  is '����ʱ��';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.create_id
  is '������';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.create_time
  is '����ʱ��';
alter table SCMDATA.T_QUALITY_CONTROL_FR add CONSTRAINT PK_QUALITY_CONTROL_FR primary key (QUALITY_CONTROL_ID) using index;
