--1.1�������� ��Ա����ҵ��� 
create table SCMDATA.T_PERSON_CONFIG_HZ
(
  person_config_id  VARCHAR2(32) not null,
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
  create_time       DATE,
  ask_record_id     VARCHAR2(32)
);
comment on table SCMDATA.T_PERSON_CONFIG_HZ
  is '��Ա���ñ�(��������)';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.person_config_id
  is '��Ա���ñ��������룩����ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.company_id
  is '��ҵID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.person_role_id
  is 'ְ��ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.department_id
  is '����ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.person_job_id
  is '��λID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.apply_category_id
  is '�������ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.job_state
  is '��λ˵��';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.person_num
  is '��Ա����';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.seqno
  is '���';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.remarks
  is '��ע';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.update_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.update_time
  is '����ʱ��';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.create_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.create_time
  is '����ʱ��';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.ask_record_id
  is '���������¼ID';
alter table SCMDATA.T_PERSON_CONFIG_HZ add CONSTRAINT PK_PERSON_CONFIG_ID_HZ primary key (PERSON_CONFIG_ID) using index;

--1.2�������� �����豸ҵ��� 
create table SCMDATA.T_MACHINE_EQUIPMENT_HZ
(
  machine_equipment_id  VARCHAR2(32) not null,
  company_id            VARCHAR2(32),
  equipment_category_id VARCHAR2(64),
  equipment_name        VARCHAR2(64),
  seqno                 NUMBER(2),
  orgin                 VARCHAR2(2),
  pause                 NUMBER(1),
  remarks               VARCHAR2(4000),
  update_id             VARCHAR2(32),
  update_time           DATE,
  create_id             VARCHAR2(32),
  create_time           DATE,
  ask_record_id         VARCHAR2(32),
  machine_num           NUMBER
);
comment on table SCMDATA.T_MACHINE_EQUIPMENT_HZ
  is '�����豸��(��������)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.machine_equipment_id
  is '�����豸(��������)����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.company_id
  is '��ҵID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.equipment_category_id
  is '�豸����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.equipment_name
  is '�豸����';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.seqno
  is '���';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.orgin
  is '��Դ';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.remarks
  is '��ע';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.update_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.update_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.create_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.create_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.ask_record_id
  is '���������¼ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.machine_num
  is '�豸����';
alter table SCMDATA.T_MACHINE_EQUIPMENT_HZ add CONSTRAINT PK_MACHINE_EQUIPMENT_HZ primary key (MACHINE_EQUIPMENT_ID) using index;

--2.1�鳧���� ��Ա����ҵ��� 
create table SCMDATA.T_PERSON_CONFIG_FA
(
  person_config_id  VARCHAR2(32) not null,
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
  create_time       DATE,
  factory_ask_id    VARCHAR2(32)
);
comment on table SCMDATA.T_PERSON_CONFIG_FA
  is '��Ա���ñ�(�鳧����)';
comment on column SCMDATA.T_PERSON_CONFIG_FA.person_config_id
  is '��Ա���ñ��鳧���룩����ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.company_id
  is '��ҵID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.person_role_id
  is 'ְ��ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.department_id
  is '����ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.person_job_id
  is '��λID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.apply_category_id
  is '�������ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.job_state
  is '��λ˵��';
comment on column SCMDATA.T_PERSON_CONFIG_FA.person_num
  is '��Ա����';
comment on column SCMDATA.T_PERSON_CONFIG_FA.seqno
  is '���';
comment on column SCMDATA.T_PERSON_CONFIG_FA.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_PERSON_CONFIG_FA.remarks
  is '��ע';
comment on column SCMDATA.T_PERSON_CONFIG_FA.update_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG_FA.update_time
  is '����ʱ��';
comment on column SCMDATA.T_PERSON_CONFIG_FA.create_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG_FA.create_time
  is '����ʱ��';
comment on column SCMDATA.T_PERSON_CONFIG_FA.factory_ask_id
  is '�鳧����ID';
alter table SCMDATA.T_PERSON_CONFIG_FA add CONSTRAINT PK_PERSON_CONFIG_ID_FA primary key (PERSON_CONFIG_ID) using index;

--2.2�鳧���� �����豸��ҵ��� 
create table SCMDATA.T_MACHINE_EQUIPMENT_FA
(
  machine_equipment_id  VARCHAR2(32) not null,
  company_id            VARCHAR2(32),
  equipment_category_id VARCHAR2(64),
  equipment_name        VARCHAR2(64),
  seqno                 NUMBER(2),
  orgin                 VARCHAR2(2),
  pause                 NUMBER(1),
  remarks               VARCHAR2(4000),
  update_id             VARCHAR2(32),
  update_time           DATE,
  create_id             VARCHAR2(32),
  create_time           DATE,
  factory_ask_id        VARCHAR2(32),
  machine_num           NUMBER
);
comment on table SCMDATA.T_MACHINE_EQUIPMENT_FA
  is '�����豸��(�鳧����)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.machine_equipment_id
  is '�����豸(�鳧����)����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.company_id
  is '��ҵID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.equipment_category_id
  is '�豸����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.equipment_name
  is '�豸����';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.seqno
  is '���';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.orgin
  is '��Դ';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.remarks
  is '��ע';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.update_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.update_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.create_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.create_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.factory_ask_id
  is '�鳧����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.machine_num
  is '�豸����';
alter table SCMDATA.T_MACHINE_EQUIPMENT_FA add CONSTRAINT PK_MACHINE_EQUIPMENT_FA primary key (MACHINE_EQUIPMENT_ID) using index ;

--3.1��Ӧ�� ��Ա����ҵ��� 
create table SCMDATA.T_PERSON_CONFIG_SUP
(
  person_config_id  VARCHAR2(32) not null,
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
  create_time       DATE,
  supplier_info_id  VARCHAR2(32)
);
comment on table SCMDATA.T_PERSON_CONFIG_SUP
  is '��Ա���ñ�(��Ӧ�̵���)';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.person_config_id
  is '��Ա���ñ���Ӧ�̵���������ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.company_id
  is '��ҵID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.person_role_id
  is 'ְ��ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.department_id
  is '����ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.person_job_id
  is '��λID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.apply_category_id
  is '�������ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.job_state
  is '��λ˵��';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.person_num
  is '��Ա����';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.seqno
  is '���';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.remarks
  is '��ע';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.update_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.update_time
  is '����ʱ��';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.create_id
  is '������';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.create_time
  is '����ʱ��';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.supplier_info_id
  is '��Ӧ�̵���ID';
alter table SCMDATA.T_PERSON_CONFIG_SUP add CONSTRAINT PK_PERSON_CONFIG_ID_SUP primary key (PERSON_CONFIG_ID) using index;

--3.2��Ӧ�� �����豸ҵ��� 
create table SCMDATA.T_MACHINE_EQUIPMENT_SUP
(
  machine_equipment_id  VARCHAR2(32) not null,
  company_id            VARCHAR2(32),
  equipment_category_id VARCHAR2(64),
  equipment_name        VARCHAR2(64),
  seqno                 NUMBER(2),
  orgin                 VARCHAR2(2),
  pause                 NUMBER(1),
  remarks               VARCHAR2(4000),
  update_id             VARCHAR2(32),
  update_time           DATE,
  create_id             VARCHAR2(32),
  create_time           DATE,
  supplier_info_id      VARCHAR2(32),
  machine_num           NUMBER
);
comment on table SCMDATA.T_MACHINE_EQUIPMENT_SUP
  is '�����豸��(��Ӧ�̵���)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.machine_equipment_id
  is '�����豸(��Ӧ�̵���)����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.company_id
  is '��ҵID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.equipment_category_id
  is '�豸����ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.equipment_name
  is '�豸����';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.seqno
  is '���';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.orgin
  is '��Դ';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.remarks
  is '��ע';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.update_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.update_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.create_id
  is '������';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.create_time
  is '����ʱ��';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.supplier_info_id
  is '��Ӧ�̵���ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.machine_num
  is '�豸����';
alter table SCMDATA.T_MACHINE_EQUIPMENT_SUP add CONSTRAINT PK_MACHINE_EQUIPMENT_SUP primary key (MACHINE_EQUIPMENT_ID) using index;

--3.3��Ӧ�� Ʒ����ϵҵ��� 
create table SCMDATA.T_QUALITY_CONTROL_SUP
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
  create_time             DATE,
  supplier_info_id        VARCHAR2(32) not null,
  is_quality_control      NUMBER(1)
);
comment on table SCMDATA.T_QUALITY_CONTROL_SUP
  is 'Ʒ����ϵģ���(��Ӧ��)';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.quality_control_id
  is 'Ʒ����ϵģ������ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.company_id
  is '��ҵID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.department_id
  is '����ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.quality_control_link_id
  is 'Ʒ�ػ���ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.seqno
  is '���';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.pause
  is '�Ƿ����(0����,1����)';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.remarks
  is '��ע';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.update_id
  is '������';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.update_time
  is '����ʱ��';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.create_id
  is '������';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.create_time
  is '����ʱ��';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.supplier_info_id
  is '��Ӧ�̵���ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.is_quality_control
  is '�Ƿ���Ʒ�ؼ�¼(0��,1��)';
alter table SCMDATA.T_QUALITY_CONTROL_SUP add CONSTRAINT PK_QUALITY_CONTROL_ID primary key (QUALITY_CONTROL_ID) using index;
