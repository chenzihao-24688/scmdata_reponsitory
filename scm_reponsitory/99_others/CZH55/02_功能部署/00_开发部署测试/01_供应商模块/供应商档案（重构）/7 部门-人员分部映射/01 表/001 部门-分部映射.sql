-- Create table
create table SYS_COMPANY_DEPT_CATE_MAP
(
  dept_cate_map_id           VARCHAR2(32) not null,
  dept_cate_map_code         VARCHAR2(32) not null,
  company_id                 VARCHAR2(32) not null,
  company_dept_id            VARCHAR2(32) not null,
  cooperation_type           VARCHAR2(32) not null,
  cooperation_classification VARCHAR2(32) not null,
  pause                      NUMBER(1) default 0 not null,
  create_id                  VARCHAR2(32) not null,
  create_time                DATE not null,
  update_id                  VARCHAR2(32) not null,
  update_time                DATE not null
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
comment on table SYS_COMPANY_DEPT_CATE_MAP
  is '����-�ֲ�ӳ��';
-- Add comments to the columns 
comment on column SYS_COMPANY_DEPT_CATE_MAP.dept_cate_map_id
  is '����-�ֲ�ӳ��ID';
comment on column SYS_COMPANY_DEPT_CATE_MAP.dept_cate_map_code
  is '����-�ֲ�ӳ�����';
comment on column SYS_COMPANY_DEPT_CATE_MAP.company_id
  is '��˾ID';
comment on column SYS_COMPANY_DEPT_CATE_MAP.company_dept_id
  is '����ID';
comment on column SYS_COMPANY_DEPT_CATE_MAP.cooperation_type
  is '��������';
comment on column SYS_COMPANY_DEPT_CATE_MAP.cooperation_classification
  is '�ֲ�';
comment on column SYS_COMPANY_DEPT_CATE_MAP.pause
  is '��ͣ(0:���ã�1��ͣ��)';
comment on column SYS_COMPANY_DEPT_CATE_MAP.create_id
  is '������';
comment on column SYS_COMPANY_DEPT_CATE_MAP.create_time
  is '����ʱ��';
comment on column SYS_COMPANY_DEPT_CATE_MAP.update_id
  is '�޸���';
comment on column SYS_COMPANY_DEPT_CATE_MAP.update_time
  is '�޸�ʱ��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_DEPT_CATE_MAP
  add constraint PK_DEPT_CATE_MAP_ID primary key (DEPT_CATE_MAP_ID)
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
alter index PK_DEPT_CATE_MAP_ID nologging;
