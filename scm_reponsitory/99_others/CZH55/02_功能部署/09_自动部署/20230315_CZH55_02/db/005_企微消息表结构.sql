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
  is '��ҵ��΢���͸�����Ϣ��';
-- Add comments to the columns 
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.sys_company_person_wecom_msg_id
  is '����';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.company_id
  is '��ҵID';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.sys_group_wecom_msg_pattern_id
  is 'ƽ̨��ҵ΢����Ϣģ��������������';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.target_user_id
  is '�����û�';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.pause
  is '��ֹ';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.remark
  is '��ע';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.update_time
  is '����ʱ��';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.update_id
  is '������';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.create_time
  is '����ʱ��';
comment on column SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG.create_id
  is '������';

alter table SCMDATA.SYS_COMPANY_PERSON_WECOM_MSG
  add CONSTRAINT PK_SYS_COMPANY_PERSON_WECOM_MSG primary key (SYS_COMPANY_PERSON_WECOM_MSG_ID)
  using index ;

---�޸�ƽ̨��ҵ΢����Ϣģ���
alter table scmdata.sys_group_wecom_msg_pattern add(apply_id varchar2(32));
comment on column scmdata.sys_group_wecom_msg_pattern.apply_id 
  is 'Ӧ��id';
