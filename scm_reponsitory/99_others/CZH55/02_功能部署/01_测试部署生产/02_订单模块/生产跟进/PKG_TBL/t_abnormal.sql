--Drop table
--drop scmdata.t_abnormal;
-- Create table
create table T_ABNORMAL
(
  abnormal_id          VARCHAR2(32) not null,
  company_id           VARCHAR2(32) not null,
  abnormal_code        VARCHAR2(32) not null,
  order_id             VARCHAR2(32) not null,
  progress_status      VARCHAR2(32) not null,
  goo_id               VARCHAR2(32) not null,
  anomaly_class        VARCHAR2(32) not null,
  problem_class        VARCHAR2(32) not null,
  cause_class          VARCHAR2(32) not null,
  detailed_reasons     VARCHAR2(256) not null,
  delay_date           NUMBER,
  delay_amount         NUMBER(18,4),
  responsible_party    VARCHAR2(32),
  responsible_dept     VARCHAR2(32),
  handle_opinions      VARCHAR2(32),
  quality_deduction    NUMBER(32,8) not null,
  is_deduction         NUMBER(1) not null,
  deduction_unit_price NUMBER(18,4),
  file_id              VARCHAR2(256),
  applicant_id         VARCHAR2(32) not null,
  applicant_date       DATE not null,
  confirm_id           VARCHAR2(32),
  confirm_company_id   VARCHAR2(32),
  confirm_date         DATE,
  create_id            VARCHAR2(32) not null,
  create_time          DATE not null,
  origin               VARCHAR2(32) not null,
  origin_id            VARCHAR2(32),
  memo                 VARCHAR2(256),
  update_id            VARCHAR2(32),
  update_time          DATE,
  deduction_method     VARCHAR2(32),
  responsible_dept_sec VARCHAR2(32),
  is_sup_responsible   NUMBER(1),
  cause_detailed       VARCHAR2(32)
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
comment on table T_ABNORMAL
  is '�쳣�����';
-- Add comments to the columns 
comment on column T_ABNORMAL.abnormal_id
  is '����';
comment on column T_ABNORMAL.company_id
  is '��ҵID';
comment on column T_ABNORMAL.abnormal_code
  is '�쳣���';
comment on column T_ABNORMAL.order_id
  is '����ID';
comment on column T_ABNORMAL.progress_status
  is '״̬';
comment on column T_ABNORMAL.goo_id
  is '����';
comment on column T_ABNORMAL.anomaly_class
  is '�쳣����';
comment on column T_ABNORMAL.problem_class
  is '�������';
comment on column T_ABNORMAL.cause_class
  is 'ԭ�����';
comment on column T_ABNORMAL.detailed_reasons
  is '��ϸԭ��';
comment on column T_ABNORMAL.delay_date
  is '����ʱ��';
comment on column T_ABNORMAL.delay_amount
  is '��������';
comment on column T_ABNORMAL.responsible_party
  is '���η�';
comment on column T_ABNORMAL.responsible_dept
  is '���β���(1��)';
comment on column T_ABNORMAL.handle_opinions
  is '�������';
comment on column T_ABNORMAL.is_deduction
  is '�Ƿ�ۿ�';
comment on column T_ABNORMAL.deduction_unit_price
  is '�ۿ�ۣ�Ԫ��';
comment on column T_ABNORMAL.file_id
  is '����';
comment on column T_ABNORMAL.applicant_id
  is '������';
comment on column T_ABNORMAL.applicant_date
  is '����ʱ��';
comment on column T_ABNORMAL.confirm_id
  is 'ȷ����';
comment on column T_ABNORMAL.confirm_company_id
  is 'ȷ������ҵ���';
comment on column T_ABNORMAL.confirm_date
  is 'ȷ��ʱ��';
comment on column T_ABNORMAL.create_id
  is '������';
comment on column T_ABNORMAL.create_time
  is '����ʱ��';
comment on column T_ABNORMAL.origin
  is '��Դ';
comment on column T_ABNORMAL.origin_id
  is '��ԴID';
comment on column T_ABNORMAL.memo
  is '��ע';
comment on column T_ABNORMAL.update_id
  is '�޸���';
comment on column T_ABNORMAL.update_time
  is '�޸�ʱ��';
comment on column T_ABNORMAL.deduction_method
  is '�ۿʽ';
comment on column T_ABNORMAL.responsible_dept_sec
  is '���β���(2��)';
comment on column T_ABNORMAL.is_sup_responsible
  is '��Ӧ���Ƿ�����';
comment on column T_ABNORMAL.cause_detailed
  is 'ԭ��ϸ��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_ABNORMAL
  add constraint PK_T_ABNORMAL primary key (ABNORMAL_ID)
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
alter index PK_T_ABNORMAL nologging;
