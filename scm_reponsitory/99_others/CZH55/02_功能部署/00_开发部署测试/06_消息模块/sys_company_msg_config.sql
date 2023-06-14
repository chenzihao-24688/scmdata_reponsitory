-- Create table
create table SYS_COMPANY_MSG_CONFIG
(
  company_msg_id VARCHAR2(32) not null,
  group_msg_id   VARCHAR2(32),
  company_id     VARCHAR2(32) not null,
  user_id        VARCHAR2(32) not null,
  pause          NUMBER(1) default 0 not null,
  create_time    DATE default sysdate not null,
  create_id      VARCHAR2(32),
  update_time    DATE,
  update_id      VARCHAR2(32),
  memo           VARCHAR2(200),
  tomorrow_flag  NUMBER default 0
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
comment on table SYS_COMPANY_MSG_CONFIG
  is '企业消息推送配置表';
-- Add comments to the columns 
comment on column SYS_COMPANY_MSG_CONFIG.company_msg_id
  is '主键';
comment on column SYS_COMPANY_MSG_CONFIG.group_msg_id
  is '平台类型编号';
comment on column SYS_COMPANY_MSG_CONFIG.company_id
  is '企业ID';
comment on column SYS_COMPANY_MSG_CONFIG.user_id
  is '员工号';
comment on column SYS_COMPANY_MSG_CONFIG.pause
  is '禁用';
comment on column SYS_COMPANY_MSG_CONFIG.create_time
  is '创建时间';
comment on column SYS_COMPANY_MSG_CONFIG.create_id
  is '创建人';
comment on column SYS_COMPANY_MSG_CONFIG.update_time
  is '修改时间';
comment on column SYS_COMPANY_MSG_CONFIG.update_id
  is '修改人';
comment on column SYS_COMPANY_MSG_CONFIG.memo
  is '备注';
comment on column SYS_COMPANY_MSG_CONFIG.tomorrow_flag
  is '是否明天提醒（0：否 1：是）';
