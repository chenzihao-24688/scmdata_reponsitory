-- Create table
create table SYS_COMPANY_DEPT_DATA_PRIV
(
  dept_data_priv_id          VARCHAR2(32) not null,
  dept_data_priv_code        VARCHAR2(32) not null,
  company_id                 VARCHAR2(32) not null,
  company_dept_id            VARCHAR2(32) not null,
  cooperation_type           VARCHAR2(32) not null,
  cooperation_classification VARCHAR2(32) not null,
  pause                      NUMBER(1) default 0 not null,
  create_id                  VARCHAR2(32) not null,
  create_time                DATE default sysdate not null,
  update_id                  VARCHAR2(32) not null,
  update_time                DATE default sysdate not null,
  cooperation_product_cate   VARCHAR2(32)
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
comment on table SYS_COMPANY_DEPT_DATA_PRIV
  is '��ҵ��������Ȩ�ޣ������ȵ�(��װ��Ůװ)ά��';
-- Add comments to the columns 
comment on column SYS_COMPANY_DEPT_DATA_PRIV.dept_data_priv_id
  is '����Ȩ��ID';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.dept_data_priv_code
  is '����Ȩ�ޱ��';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.company_id
  is '��ҵID';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.cooperation_type
  is '��������';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.cooperation_classification
  is '��������';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.pause
  is '����';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.create_id
  is '������';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.create_time
  is '����ʱ��';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.update_id
  is '�޸���';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.update_time
  is '�޸�ʱ��';
comment on column SYS_COMPANY_DEPT_DATA_PRIV.cooperation_product_cate
  is '�������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_DEPT_DATA_PRIV
  add constraint PK_SYS_COMPANY_DEPT_DATA_PRIV primary key (DEPT_DATA_PRIV_ID)
  using index 
  tablespace SCMINDEX
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
alter index PK_SYS_COMPANY_DEPT_DATA_PRIV nologging;
alter table SYS_COMPANY_DEPT_DATA_PRIV
  add constraint UX_SYS_COMPANY_DEPT_DATA_PRIV unique (DEPT_DATA_PRIV_CODE, COMPANY_ID)
  using index 
  tablespace SCMINDEX
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
alter index UX_SYS_COMPANY_DEPT_DATA_PRIV nologging;
