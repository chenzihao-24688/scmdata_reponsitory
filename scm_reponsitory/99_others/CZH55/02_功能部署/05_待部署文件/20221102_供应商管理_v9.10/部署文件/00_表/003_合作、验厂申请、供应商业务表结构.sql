--1.1合作申请 人员配置业务表 
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
  is '人员配置表(合作申请)';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.person_config_id
  is '人员配置表（合作申请）主键ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.company_id
  is '企业ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.person_role_id
  is '职能ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.department_id
  is '部门ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.person_job_id
  is '岗位ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.apply_category_id
  is '适用类别ID';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.job_state
  is '岗位说明';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.person_num
  is '人员数量';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.seqno
  is '序号';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.remarks
  is '备注';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.update_id
  is '更新人';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.update_time
  is '更新时间';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.create_id
  is '创建人';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.create_time
  is '创建时间';
comment on column SCMDATA.T_PERSON_CONFIG_HZ.ask_record_id
  is '合作申请记录ID';
alter table SCMDATA.T_PERSON_CONFIG_HZ add CONSTRAINT PK_PERSON_CONFIG_ID_HZ primary key (PERSON_CONFIG_ID) using index;

--1.2合作申请 机器设备业务表 
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
  is '机器设备表(合作申请)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.machine_equipment_id
  is '机器设备(合作申请)主键ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.company_id
  is '企业ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.equipment_category_id
  is '设备分类ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.equipment_name
  is '设备名称';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.seqno
  is '序号';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.orgin
  is '来源';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.remarks
  is '备注';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.update_id
  is '更新人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.update_time
  is '更新时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.create_id
  is '创建人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.create_time
  is '创建时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.ask_record_id
  is '合作申请记录ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_HZ.machine_num
  is '设备数量';
alter table SCMDATA.T_MACHINE_EQUIPMENT_HZ add CONSTRAINT PK_MACHINE_EQUIPMENT_HZ primary key (MACHINE_EQUIPMENT_ID) using index;

--2.1验厂申请 人员配置业务表 
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
  is '人员配置表(验厂申请)';
comment on column SCMDATA.T_PERSON_CONFIG_FA.person_config_id
  is '人员配置表（验厂申请）主键ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.company_id
  is '企业ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.person_role_id
  is '职能ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.department_id
  is '部门ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.person_job_id
  is '岗位ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.apply_category_id
  is '适用类别ID';
comment on column SCMDATA.T_PERSON_CONFIG_FA.job_state
  is '岗位说明';
comment on column SCMDATA.T_PERSON_CONFIG_FA.person_num
  is '人员数量';
comment on column SCMDATA.T_PERSON_CONFIG_FA.seqno
  is '序号';
comment on column SCMDATA.T_PERSON_CONFIG_FA.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_PERSON_CONFIG_FA.remarks
  is '备注';
comment on column SCMDATA.T_PERSON_CONFIG_FA.update_id
  is '更新人';
comment on column SCMDATA.T_PERSON_CONFIG_FA.update_time
  is '更新时间';
comment on column SCMDATA.T_PERSON_CONFIG_FA.create_id
  is '创建人';
comment on column SCMDATA.T_PERSON_CONFIG_FA.create_time
  is '创建时间';
comment on column SCMDATA.T_PERSON_CONFIG_FA.factory_ask_id
  is '验厂申请ID';
alter table SCMDATA.T_PERSON_CONFIG_FA add CONSTRAINT PK_PERSON_CONFIG_ID_FA primary key (PERSON_CONFIG_ID) using index;

--2.2验厂申请 机器设备表业务表 
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
  is '机器设备表(验厂申请)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.machine_equipment_id
  is '机器设备(验厂申请)主键ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.company_id
  is '企业ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.equipment_category_id
  is '设备分类ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.equipment_name
  is '设备名称';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.seqno
  is '序号';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.orgin
  is '来源';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.remarks
  is '备注';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.update_id
  is '更新人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.update_time
  is '更新时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.create_id
  is '创建人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.create_time
  is '创建时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.factory_ask_id
  is '验厂申请ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_FA.machine_num
  is '设备数量';
alter table SCMDATA.T_MACHINE_EQUIPMENT_FA add CONSTRAINT PK_MACHINE_EQUIPMENT_FA primary key (MACHINE_EQUIPMENT_ID) using index ;

--3.1供应商 人员配置业务表 
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
  is '人员配置表(供应商档案)';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.person_config_id
  is '人员配置表（供应商档案）主键ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.company_id
  is '企业ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.person_role_id
  is '职能ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.department_id
  is '部门ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.person_job_id
  is '岗位ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.apply_category_id
  is '适用类别ID';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.job_state
  is '岗位说明';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.person_num
  is '人员数量';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.seqno
  is '序号';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.remarks
  is '备注';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.update_id
  is '更新人';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.update_time
  is '更新时间';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.create_id
  is '创建人';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.create_time
  is '创建时间';
comment on column SCMDATA.T_PERSON_CONFIG_SUP.supplier_info_id
  is '供应商档案ID';
alter table SCMDATA.T_PERSON_CONFIG_SUP add CONSTRAINT PK_PERSON_CONFIG_ID_SUP primary key (PERSON_CONFIG_ID) using index;

--3.2供应商 机器设备业务表 
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
  is '机器设备表(供应商档案)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.machine_equipment_id
  is '机器设备(供应商档案)主键ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.company_id
  is '企业ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.equipment_category_id
  is '设备分类ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.equipment_name
  is '设备名称';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.seqno
  is '序号';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.orgin
  is '来源';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.remarks
  is '备注';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.update_id
  is '更新人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.update_time
  is '更新时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.create_id
  is '创建人';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.create_time
  is '创建时间';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.supplier_info_id
  is '供应商档案ID';
comment on column SCMDATA.T_MACHINE_EQUIPMENT_SUP.machine_num
  is '设备数量';
alter table SCMDATA.T_MACHINE_EQUIPMENT_SUP add CONSTRAINT PK_MACHINE_EQUIPMENT_SUP primary key (MACHINE_EQUIPMENT_ID) using index;

--3.3供应商 品控体系业务表 
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
  is '品控体系模板表(供应商)';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.quality_control_id
  is '品控体系模板主键ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.company_id
  is '企业ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.department_id
  is '部门ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.quality_control_link_id
  is '品控环节ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.seqno
  is '序号';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.pause
  is '是否禁用(0正常,1禁用)';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.remarks
  is '备注';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.update_id
  is '更新人';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.update_time
  is '更新时间';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.create_id
  is '创建人';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.create_time
  is '创建时间';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.supplier_info_id
  is '供应商档案ID';
comment on column SCMDATA.T_QUALITY_CONTROL_SUP.is_quality_control
  is '是否有品控记录(0无,1有)';
alter table SCMDATA.T_QUALITY_CONTROL_SUP add CONSTRAINT PK_QUALITY_CONTROL_ID primary key (QUALITY_CONTROL_ID) using index;
