---1.���������¼���޸ı�ṹ
alter table SCMDATA.T_ASK_RECORD add(
  worker_total_num        NUMBER,
  worker_num              NUMBER,
  machine_num             NUMBER,
  form_num                NUMBER,
  product_efficiency      NUMBER(10,2),
  pattern_cap             VARCHAR2(48),
  fabric_purchase_cap     VARCHAR2(48),
  fabric_check_cap        VARCHAR2(48),
  other_information       VARCHAR2(256),
  COMPANY_REGIST_DATE		  DATE,
  PAY_TERM	              VARCHAR2(32),
  PRODUCT_TYPE            VARCHAR2(32),
  RELA_SUPPLIER_ID	      VARCHAR2(32),
  IS_OUR_FACTORY   NUMBER(1),
  FACTORY_NAME   VARCHAR2(300),
  FACTORY_PROVINCE   VARCHAR2(48),
  FACTORY_CITY   VARCHAR2(48),
  FACTORY_COUNTY   VARCHAR2(48) ,
  FACTORY_VILL   VARCHAR2(48),
  FACTROY_DETAILS_ADDRESS  VARCHAR2(256),
  FACTROY_AREA   NUMBER(14,2),
  PRODUCT_LINE   VARCHAR2(48),
  PRODUCT_LINE_NUM   VARCHAR2(32) ,
  QUALITY_STEP  VARCHAR2(32),
  WORK_HOURS_DAY   NUMBER(10,1)
);
comment on table  SCMDATA.T_ASK_RECORD
  is '���������¼��';
comment on column  SCMDATA.T_ASK_RECORD.ask_record_id
  is '����';
comment on column  SCMDATA.T_ASK_RECORD.company_id
  is '���뷽��ҵID';
comment on column  SCMDATA.T_ASK_RECORD.be_company_id
  is '�����뷽��ҵID';
comment on column  SCMDATA.T_ASK_RECORD.company_province
  is '��˾ʡ';
comment on column  SCMDATA.T_ASK_RECORD.company_city
  is '��˾��';
comment on column  SCMDATA.T_ASK_RECORD.company_county
  is '��˾��';
comment on column  SCMDATA.T_ASK_RECORD.company_address
  is '��˾��ϸ��ַ';
comment on column  SCMDATA.T_ASK_RECORD.ask_date
  is '����ʱ��';
comment on column  SCMDATA.T_ASK_RECORD.ask_user_id
  is '������ID';
comment on column  SCMDATA.T_ASK_RECORD.ask_say
  is '����˵��';
comment on column  SCMDATA.T_ASK_RECORD.cooperation_type
  is '�����������';
comment on column  SCMDATA.T_ASK_RECORD.cooperation_model
  is '�������ģʽ';
comment on column  SCMDATA.T_ASK_RECORD.certificate_file
  is 'Ӫҵִ�գ���ҵ֤�գ�';
comment on column  SCMDATA.T_ASK_RECORD.other_file
  is '���฽����ַ��������Ÿ�����';
comment on column  SCMDATA.T_ASK_RECORD.company_name
  is '��˾����';
comment on column  SCMDATA.T_ASK_RECORD.company_abbreviation
  is '��˾���';
comment on column  SCMDATA.T_ASK_RECORD.social_credit_code
  is 'ͳһ������ô���';
comment on column  SCMDATA.T_ASK_RECORD.cooperation_statement
  is '��������˵��';
comment on column  SCMDATA.T_ASK_RECORD.sapply_user
  is 'ҵ����ϵ�� ';
comment on column  SCMDATA.T_ASK_RECORD.sapply_phone
  is 'ҵ����ϵ�绰 ';
comment on column  SCMDATA.T_ASK_RECORD.legal_representative
  is '����������';
comment on column  SCMDATA.T_ASK_RECORD.company_contact_phone
  is '��˾��ϵ���ֻ�';
comment on column  SCMDATA.T_ASK_RECORD.company_type
  is '��˾����--��Ӧ�鳧COMPANY_MOLD';
comment on column  SCMDATA.T_ASK_RECORD.brand_type
  is '����Ʒ��/�ͻ� ����';
comment on column  SCMDATA.T_ASK_RECORD.cooperation_brand
  is '����Ʒ��/�ͻ�';
comment on column  SCMDATA.T_ASK_RECORD.product_link
  is '��������';
comment on column  SCMDATA.T_ASK_RECORD.supplier_gate
  is '��˾���Ÿ�����ַ';
comment on column  SCMDATA.T_ASK_RECORD.supplier_office
  is '��˾�칫�Ҹ�����ַ';
comment on column  SCMDATA.T_ASK_RECORD.supplier_site
  is '�����ֳ�������ַ';
comment on column  SCMDATA.T_ASK_RECORD.supplier_product
  is '��ƷͼƬ������ַ';
comment on column  SCMDATA.T_ASK_RECORD.coor_ask_flow_status
  is '������������״̬';
comment on column  SCMDATA.T_ASK_RECORD.collection
  is '�ղ�';
comment on column  SCMDATA.T_ASK_RECORD.origin
  is '��Դ';
comment on column  SCMDATA.T_ASK_RECORD.create_id
  is '������ID';
comment on column  SCMDATA.T_ASK_RECORD.create_date
  is '����ʱ��';
comment on column  SCMDATA.T_ASK_RECORD.update_id
  is '�޸���ID';
comment on column  SCMDATA.T_ASK_RECORD.update_date
  is '�޸�ʱ��';
comment on column  SCMDATA.T_ASK_RECORD.remarks
  is '��ע';
comment on column  SCMDATA.T_ASK_RECORD.company_vill
  is '��˾����/�ֵ�';
  
comment on column  SCMDATA.T_ASK_RECORD.company_regist_date
  is '��˾ע������';
comment on column  SCMDATA.T_ASK_RECORD.pay_term
  is '��������';
comment on column  SCMDATA.T_ASK_RECORD.product_type
  is '��������';
comment on column  SCMDATA.T_ASK_RECORD.rela_supplier_id
  is '������Ӧ��ID';
comment on column  SCMDATA.T_ASK_RECORD.is_our_factory
  is '�Ƿ񱾳�';
comment on column  SCMDATA.T_ASK_RECORD.factory_name
  is '��������';
comment on column  SCMDATA.T_ASK_RECORD.factory_province
  is '��������ʡ';
comment on column  SCMDATA.T_ASK_RECORD.factory_city
  is '����������';
comment on column  SCMDATA.T_ASK_RECORD.factory_county
  is '����������';
comment on column  SCMDATA.T_ASK_RECORD.factory_vill
  is '������������/�ֵ�';
comment on column  SCMDATA.T_ASK_RECORD.factroy_details_address
  is '������ϸ��ַ';
comment on column  SCMDATA.T_ASK_RECORD.factroy_area
  is '���������m2��';
comment on column  SCMDATA.T_ASK_RECORD.product_line
  is '����������';
comment on column  SCMDATA.T_ASK_RECORD.product_line_num
  is '����������';
comment on column  SCMDATA.T_ASK_RECORD.quality_step
  is '�����ȼ�';
comment on column  SCMDATA.T_ASK_RECORD.work_hours_day
  is '�ϰ�ʱ��/��';
comment on column  SCMDATA.T_ASK_RECORD.worker_total_num
  is '������';
comment on column  SCMDATA.T_ASK_RECORD.worker_num
  is '��λ����';
comment on column  SCMDATA.T_ASK_RECORD.machine_num
  is '֯��̨��_ë֯��';
comment on column  SCMDATA.T_ASK_RECORD.form_num
  is '��������_Ь��';
comment on column  SCMDATA.T_ASK_RECORD.product_efficiency
  is '����Ч��';
comment on column  SCMDATA.T_ASK_RECORD.pattern_cap
  is '�������';
comment on column  SCMDATA.T_ASK_RECORD.fabric_purchase_cap
  is '���ϲɹ�����';
comment on column  SCMDATA.T_ASK_RECORD.fabric_check_cap
  is '���ϼ������';
comment on column  SCMDATA.T_ASK_RECORD.other_information
  is '��������';

---20221226
alter table scmdata.t_factory_report modify check_report_file null; 
