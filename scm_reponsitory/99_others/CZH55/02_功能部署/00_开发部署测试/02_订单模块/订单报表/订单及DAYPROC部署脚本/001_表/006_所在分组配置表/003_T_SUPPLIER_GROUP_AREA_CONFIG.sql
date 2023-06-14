-- Create table
create table T_SUPPLIER_GROUP_AREA_CONFIG
(
  group_area_config_id VARCHAR2(32) not null,
  company_id           VARCHAR2(32) not null,
  group_config_id      VARCHAR2(32) not null,
  province_id          VARCHAR2(32) not null,
  city_id              VARCHAR2(32) not null,
  pause                NUMBER(1) default 1,
  remarks              VARCHAR2(256),
  create_id            VARCHAR2(32),
  create_time          DATE,
  update_id            VARCHAR2(32),
  update_time          DATE
)
tablespace SCMDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
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
comment on column T_SUPPLIER_GROUP_AREA_CONFIG.group_config_id
  is '���ڷ������ã������';
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SUPPLIER_GROUP_AREA_CONFIG
  add constraint PK_GROUP_AREA_CONFIG_ID primary key (GROUP_AREA_CONFIG_ID)
  using index 
  tablespace SCMDATA
  pctfree 10
  initrans 2
  maxtrans 255;
alter index PK_GROUP_AREA_CONFIG_ID nologging;
alter table T_SUPPLIER_GROUP_AREA_CONFIG
  add constraint FK_GROUP_CONFIG_ID_AREA foreign key (GROUP_CONFIG_ID)
  references T_SUPPLIER_GROUP_CONFIG (GROUP_CONFIG_ID);
