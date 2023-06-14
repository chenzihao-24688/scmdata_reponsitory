-- Create table
create table T_SUPPLIER_GROUP_CONFIG
(
  group_config_id   VARCHAR2(32) not null,
  group_name        VARCHAR2(32) not null,
  area_group_leader VARCHAR2(32) not null,
  effective_time    DATE not null,
  end_time          DATE not null,
  config_status     NUMBER(1) default 0,
  pause             NUMBER(1) default 1,
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
    minextents 1
    maxextents unlimited
  )
nologging;
-- Add comments to the table 
comment on table T_SUPPLIER_GROUP_CONFIG
  is '���ڷ�������';
-- Add comments to the columns 
comment on column T_SUPPLIER_GROUP_CONFIG.group_config_id
  is '���ڷ�������ID��������';
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
  is '��ͣ״̬��0��ͣ��  1�����ã���Ĭ������';
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
  maxtrans 255;
alter index PK_GROUP_CONFIG_ID nologging;
