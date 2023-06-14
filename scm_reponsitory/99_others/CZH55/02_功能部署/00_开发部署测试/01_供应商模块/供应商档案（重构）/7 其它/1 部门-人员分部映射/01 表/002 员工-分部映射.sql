-- Create table
create table SYS_COMPANY_USER_CATE_MAP
(
  user_cate_map_id           VARCHAR2(32) not null,
  user_cate_map_code         VARCHAR2(32) not null,
  company_id                 VARCHAR2(32) not null,
  cooperation_classification VARCHAR2(32) not null,
  cooperation_type           VARCHAR2(32) not null,
  pause                      NUMBER(1) not null,
  create_id                  VARCHAR2(32) not null,
  create_time                DATE not null,
  update_id                  VARCHAR2(32) not null,
  update_time                DATE not null,
  user_id                    VARCHAR2(32) not null
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
comment on table SYS_COMPANY_USER_CATE_MAP
  is '员工-分部映射';
-- Add comments to the columns 
comment on column SYS_COMPANY_USER_CATE_MAP.user_cate_map_id
  is '员工-分部映射ID';
comment on column SYS_COMPANY_USER_CATE_MAP.user_cate_map_code
  is '员工-分部映射编码';
comment on column SYS_COMPANY_USER_CATE_MAP.company_id
  is '公司ID';
comment on column SYS_COMPANY_USER_CATE_MAP.cooperation_classification
  is '分部';
comment on column SYS_COMPANY_USER_CATE_MAP.cooperation_type
  is '合作类型';
comment on column SYS_COMPANY_USER_CATE_MAP.pause
  is '启停(0:启用，1：停用)';
comment on column SYS_COMPANY_USER_CATE_MAP.create_id
  is '创建人';
comment on column SYS_COMPANY_USER_CATE_MAP.create_time
  is '创建时间';
comment on column SYS_COMPANY_USER_CATE_MAP.update_id
  is '修改人';
comment on column SYS_COMPANY_USER_CATE_MAP.update_time
  is '修改时间';
comment on column SYS_COMPANY_USER_CATE_MAP.user_id
  is '员工ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_COMPANY_USER_CATE_MAP
  add constraint PK_USER_CATE_MAP_ID primary key (USER_CATE_MAP_ID)
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
alter index PK_USER_CATE_MAP_ID nologging;
