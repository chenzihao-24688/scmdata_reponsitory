--1. Create table 人员配置模板表
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
  is '人员配置模板表';
comment on column SCMDATA.T_PERSON_CONFIG.person_config_id
  is '人员配置模板主键ID';
comment on column SCMDATA.T_PERSON_CONFIG.company_id
  is '企业ID';
comment on column SCMDATA.T_PERSON_CONFIG.person_role_id
  is '职能ID';
comment on column SCMDATA.T_PERSON_CONFIG.department_id
  is '部门ID';
comment on column SCMDATA.T_PERSON_CONFIG.person_job_id
  is '岗位ID';
comment on column SCMDATA.T_PERSON_CONFIG.apply_category_id
  is '适用类别ID';
comment on column SCMDATA.T_PERSON_CONFIG.job_state
  is '岗位说明';
comment on column SCMDATA.T_PERSON_CONFIG.seqno
  is '序号';
comment on column SCMDATA.T_PERSON_CONFIG.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_PERSON_CONFIG.remarks
  is '备注';
comment on column SCMDATA.T_PERSON_CONFIG.update_id
  is '更新人';
comment on column SCMDATA.T_PERSON_CONFIG.update_time
  is '更新时间';
comment on column SCMDATA.T_PERSON_CONFIG.create_id
  is '创建人';
comment on column SCMDATA.T_PERSON_CONFIG.create_time
  is '创建时间';

alter table SCMDATA.T_PERSON_CONFIG add CONSTRAINT PK_PERSON_CONFIG primary key (PERSON_CONFIG_ID) using index ;

--2. Create table 机器设备模板表
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
  is '机器设备模板表';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.machine_equipment_id
  is '机器设备模板主键ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.company_id
  is '企业ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.equipment_category_id
  is '设备分类ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.equipment_name
  is '设备名称';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.seqno
  is '序号';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.remarks
  is '备注';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.update_id
  is '更新人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.update_time
  is '更新时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.create_id
  is '创建人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.create_time
  is '创建时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT.template_type
  is '模板类别';

alter table SCMDATA.T_MACHINE_EQUIPMENT add constraint PK_MACHINE_EQUIPMENT primary key (MACHINE_EQUIPMENT_ID) using index ;

--3. Create table 品控体系模板表
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
  is '品控体系模板表';
comment on column SCMDATA.T_QUALITY_CONTROL.quality_control_id
  is '品控体系模板主键ID';
comment on column SCMDATA.T_QUALITY_CONTROL.company_id
  is '企业ID';
comment on column SCMDATA.T_QUALITY_CONTROL.department_id
  is '部门ID';
comment on column SCMDATA.T_QUALITY_CONTROL.quality_control_link_id
  is '品控环节ID';
comment on column SCMDATA.T_QUALITY_CONTROL.seqno
  is '序号';
comment on column SCMDATA.T_QUALITY_CONTROL.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_QUALITY_CONTROL.remarks
  is '备注';
comment on column SCMDATA.T_QUALITY_CONTROL.update_id
  is '更新人';
comment on column SCMDATA.T_QUALITY_CONTROL.update_time
  is '更新时间';
comment on column SCMDATA.T_QUALITY_CONTROL.create_id
  is '创建人';
comment on column SCMDATA.T_QUALITY_CONTROL.create_time
  is '创建时间';
alter table SCMDATA.T_QUALITY_CONTROL add CONSTRAINT PK_QUALITY_CONTROL primary key (QUALITY_CONTROL_ID) using index;


--4. Create table 人员配置表(验厂管理)
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
  is '人员配置表(验厂管理)';
comment on column SCMDATA.T_PERSON_CONFIG_FR.person_config_id
  is '人员配置表(验厂管理)主键ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.factory_report_id
  is '验厂报告ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.company_id
  is '企业ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.person_role_id
  is '职能ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.department_id
  is '部门ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.person_job_id
  is '岗位ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.apply_category_id
  is '适用类别ID';
comment on column SCMDATA.T_PERSON_CONFIG_FR.job_state
  is '岗位说明';
comment on column SCMDATA.T_PERSON_CONFIG_FR.person_num
  is '人员数量';
comment on column SCMDATA.T_PERSON_CONFIG_FR.seqno
  is '序号';
comment on column SCMDATA.T_PERSON_CONFIG_FR.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_PERSON_CONFIG_FR.remarks
  is '备注';
comment on column SCMDATA.T_PERSON_CONFIG_FR.update_id
  is '更新人';
comment on column SCMDATA.T_PERSON_CONFIG_FR.update_time
  is '更新时间';
comment on column SCMDATA.T_PERSON_CONFIG_FR.create_id
  is '创建人';
comment on column SCMDATA.T_PERSON_CONFIG_FR.create_time
  is '创建时间';

alter table SCMDATA.T_PERSON_CONFIG_FR add CONSTRAINT PK_PERSON_CONFIG_FR primary key (PERSON_CONFIG_ID) using index ;

--5. Create table 机器设备表(验厂管理)
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
  is '机器设备表(验厂管理)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.machine_equipment_id
  is '机器设备(验厂管理)主键ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.factory_report_id
  is '验厂报告ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.company_id
  is '企业ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.equipment_category_id
  is '设备分类ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.equipment_name
  is '设备名称';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.seqno
  is '序号';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.orgin
  is '来源';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.machine_num
  is '设备数量';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.remarks
  is '备注';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.update_id
  is '更新人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.update_time
  is '更新时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.create_id
  is '创建人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FR.create_time
  is '创建时间';

alter table SCMDATA.T_MACHINE_EQUIPMENT_FR add CONSTRAINT PK_MACHINE_EQUIPMENT_FR primary key (MACHINE_EQUIPMENT_ID) using index;

--6. Create table 品控体系表(验厂管理)
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
  is '品控体系表(验厂管理)';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.quality_control_id
  is '品控体系表(验厂管理)主键ID';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.company_id
  is '企业ID';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.department_id
  is '部门ID';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.quality_control_link_id
  is '品控环节ID';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.is_quality_control
  is '是否有品控记录(0无,1有)';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.seqno
  is '序号';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.remarks
  is '备注';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.update_id
  is '更新人';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.update_time
  is '更新时间';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.create_id
  is '创建人';
comment on column SCMDATA.T_QUALITY_CONTROL_FR.create_time
  is '创建时间';
alter table SCMDATA.T_QUALITY_CONTROL_FR add CONSTRAINT PK_QUALITY_CONTROL_FR primary key (QUALITY_CONTROL_ID) using index;
