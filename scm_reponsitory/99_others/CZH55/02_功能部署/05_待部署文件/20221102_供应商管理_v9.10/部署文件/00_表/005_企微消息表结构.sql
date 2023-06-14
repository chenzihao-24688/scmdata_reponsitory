-- Create table
create table SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG
(
  sys_company_person_wecom_msg_id       VARCHAR2(32) not null,
  company_id                     VARCHAR2(32) not null,
  sys_group_wecom_msg_pattern_id VARCHAR2(32),
  pause                          number(1) default 0,
  target_user_id                 VARCHAR2(640),
  remark                         VARCHAR2(4000),
  update_time                    DATE,
  update_id                      VARCHAR2(32),
  create_time                    DATE default sysdate not null,
  create_id                      VARCHAR2(32) 
);
-- Add comments to the table 
comment on table SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG
  is '企业企微推送个人消息表';
-- Add comments to the columns 
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.sys_company_person_wecom_msg_id
  is '主键';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.company_id
  is '企业ID';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.sys_group_wecom_msg_pattern_id
  is '平台企业微信消息模板表主键（外键）';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.target_user_id
  is '发送用户';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.pause
  is '禁止';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.remark
  is '备注';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.update_time
  is '更新时间';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.update_id
  is '更新人';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.create_time
  is '创建时间';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.create_id
  is '创建人';

alter table SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG
  add CONSTRAINT PK_SYS_COMPANY_PERSON_WECOM_MSG primary key (SYS_COMPANY_PERSON_WECOM_MSG_ID)
  using index ;

---修改平台企业微信消息模板表
alter table scmdata.sys_group_wecom_msg_pattern add(apply_id varchar2(32));
comment on column scmdata.sys_group_wecom_msg_pattern.apply_id 
  is '应用id';
