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

---2.���������¼���޸ı�ṹ
alter table SCMDATA.T_FACTORY_ASK add(
  pay_term                 VARCHAR2(32),
  company_regist_date      DATE,
  is_our_factory           NUMBER(1),
  factroy_area             NUMBER(14,2),
  product_line             VARCHAR2(48),
  product_line_num         VARCHAR2(32),
  quality_step             VARCHAR2(32),
  worker_total_num         NUMBER,
  form_num                 NUMBER,
  pattern_cap              VARCHAR2(48),
  fabric_purchase_cap      VARCHAR2(48),
  fabric_check_cap         VARCHAR2(48),
  other_information        VARCHAR2(256),
  factroy_details_address  VARCHAR2(256));

comment on table SCMDATA.T_FACTORY_ASK
  is '�鳧�����(��Ӧ����Ϣ)';
comment on column SCMDATA.T_FACTORY_ASK.factory_ask_id
  is '����';
comment on column SCMDATA.T_FACTORY_ASK.company_id
  is '��˾���';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_company_id
  is '������˾id';
comment on column SCMDATA.T_FACTORY_ASK.ask_user_id
  is '�鳧������ID';
comment on column SCMDATA.T_FACTORY_ASK.ask_company_id
  is '�鳧��˾���';
comment on column SCMDATA.T_FACTORY_ASK.ask_record_id
  is '��������id';
comment on column SCMDATA.T_FACTORY_ASK.ask_user_dept_id
  is '���벿��id';
comment on column SCMDATA.T_FACTORY_ASK.is_urgent
  is '�Ƿ����';
comment on column SCMDATA.T_FACTORY_ASK.company_province
  is '��˾ʡ ';
comment on column SCMDATA.T_FACTORY_ASK.company_city
  is '��˾��';
comment on column SCMDATA.T_FACTORY_ASK.company_county
  is '��˾��';
comment on column SCMDATA.T_FACTORY_ASK.contact_name
  is '��ϵ��';
comment on column SCMDATA.T_FACTORY_ASK.contact_phone
  is '��ϵ���ֻ�';
comment on column SCMDATA.T_FACTORY_ASK.company_type
  is '����˾���� ';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_method
  is '���������ʽ��v_9.10 ���ϣ�';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_model
  is '�������ģʽ ';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_type
  is '���������ʽ����';
comment on column SCMDATA.T_FACTORY_ASK.company_name
  is '���鳧��˾����';
comment on column SCMDATA.T_FACTORY_ASK.company_abbreviation
  is '��˾���';
comment on column SCMDATA.T_FACTORY_ASK.company_address
  is '��˾��ϸ��ַ';
comment on column SCMDATA.T_FACTORY_ASK.social_credit_code
  is 'ͳһ������ô���';
comment on column SCMDATA.T_FACTORY_ASK.legal_representative
  is '����������';
comment on column SCMDATA.T_FACTORY_ASK.company_contact_phone
  is '��˾��ϵ�绰';
comment on column SCMDATA.T_FACTORY_ASK.company_mold
  is '��˾���ͣ�v_9.10 ���ϣ�';
comment on column SCMDATA.T_FACTORY_ASK.brand_type
  is '����Ʒ��/�ͻ� ����';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_brand
  is '����Ʒ��/�ͻ�';
comment on column SCMDATA.T_FACTORY_ASK.product_type
  is '��������';
comment on column SCMDATA.T_FACTORY_ASK.product_link
  is '��������';
comment on column SCMDATA.T_FACTORY_ASK.rela_supplier_id
  is '������Ӧ��ID';
comment on column SCMDATA.T_FACTORY_ASK.ask_date
  is '�鳧��������';
comment on column SCMDATA.T_FACTORY_ASK.ask_address
  is '�鳧��ַ(������ϸ��ַ)';
comment on column SCMDATA.T_FACTORY_ASK.ask_say
  is '�鳧����˵�� ';
comment on column SCMDATA.T_FACTORY_ASK.ask_files
  is '�鳧���븽��';
comment on column SCMDATA.T_FACTORY_ASK.factory_ask_type
  is '�鳧���ͣ�0���鳧��1�ڲ��鳧��2�������鳧��';
comment on column SCMDATA.T_FACTORY_ASK.factrory_ask_flow_status
  is '���״̬';
comment on column SCMDATA.T_FACTORY_ASK.supplier_gate
  is '��˾���Ÿ�����ַ';
comment on column SCMDATA.T_FACTORY_ASK.supplier_office
  is '��˾�칫�Ҹ�����ַ';
comment on column SCMDATA.T_FACTORY_ASK.supplier_site
  is '�����ֳ�������ַ';
comment on column SCMDATA.T_FACTORY_ASK.supplier_product
  is '��ƷͼƬ������ַ';
comment on column SCMDATA.T_FACTORY_ASK.com_manufacturer
  is '�������������ϣ�';
comment on column SCMDATA.T_FACTORY_ASK.certificate_file
  is 'Ӫҵִ��';
comment on column SCMDATA.T_FACTORY_ASK.origin
  is '��Դ';
comment on column SCMDATA.T_FACTORY_ASK.create_id
  is '������ID';
comment on column SCMDATA.T_FACTORY_ASK.create_date
  is '����ʱ��';
comment on column SCMDATA.T_FACTORY_ASK.update_id
  is '�޸���ID';
comment on column SCMDATA.T_FACTORY_ASK.update_date
  is '�޸�ʱ��';
comment on column SCMDATA.T_FACTORY_ASK.remarks
  is '��ע(������¼)';
comment on column SCMDATA.T_FACTORY_ASK.factory_name
  is '��������';
comment on column SCMDATA.T_FACTORY_ASK.factory_province
  is '��������ʡ';
comment on column SCMDATA.T_FACTORY_ASK.factory_city
  is '����������';
comment on column SCMDATA.T_FACTORY_ASK.factory_county
  is '����������';
comment on column SCMDATA.T_FACTORY_ASK.worker_num
  is '��λ����';
comment on column SCMDATA.T_FACTORY_ASK.machine_num
  is '֯��̨��_ë֯��';
comment on column SCMDATA.T_FACTORY_ASK.reserve_capacity
  is 'ԤԼ����ռ��';
comment on column SCMDATA.T_FACTORY_ASK.product_efficiency
  is '����Ч�� ';
comment on column SCMDATA.T_FACTORY_ASK.work_hours_day
  is '�ϰ�ʱ��/��';
comment on column SCMDATA.T_FACTORY_ASK.memo
  is '��ע';
comment on column SCMDATA.T_FACTORY_ASK.company_vill
  is '��˾����/�ֵ�';
comment on column SCMDATA.T_FACTORY_ASK.factory_vill
  is '������������/�ֵ�';
comment on column SCMDATA.T_FACTORY_ASK.pay_term
  is '��������';
comment on column SCMDATA.T_FACTORY_ASK.company_regist_date
  is '��˾ע������ ';
comment on column SCMDATA.T_FACTORY_ASK.is_our_factory
  is '�Ƿ񱾳�';
comment on column SCMDATA.T_FACTORY_ASK.factroy_area
  is '���������m2��';
comment on column SCMDATA.T_FACTORY_ASK.product_line
  is '����������';
comment on column SCMDATA.T_FACTORY_ASK.product_line_num
  is '����������(��)';
comment on column SCMDATA.T_FACTORY_ASK.quality_step
  is '�����ȼ�';
comment on column SCMDATA.T_FACTORY_ASK.worker_total_num
  is '������ ';
comment on column SCMDATA.T_FACTORY_ASK.form_num
  is '��������_Ь��';
comment on column SCMDATA.T_FACTORY_ASK.pattern_cap
  is '�������';
comment on column SCMDATA.T_FACTORY_ASK.fabric_purchase_cap
  is '���ϲɹ�����';
comment on column SCMDATA.T_FACTORY_ASK.fabric_check_cap
  is '���ϼ������';
comment on column SCMDATA.T_FACTORY_ASK.other_information
  is '��������';
comment on column SCMDATA.T_FACTORY_ASK.factroy_details_address
  is '������ϸ��ַ';

---3.��Ӧ�̵������޸ı�ṹ
alter table SCMDATA.T_SUPPLIER_INFO add(
  pay_term                      VARCHAR2(32),
  company_regist_date           DATE,
  is_our_factory                NUMBER(1),
  factroy_area                  NUMBER(14,2),
  worker_total_num              NUMBER,
  form_num                      NUMBER,
  other_information             VARCHAR2(256));

comment on table SCMDATA.T_SUPPLIER_INFO
  is '��Ӧ�̵���';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_info_id
  is '����';
comment on column SCMDATA.T_SUPPLIER_INFO.company_id
  is '��˾����';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_code
  is '��Ӧ�̱��';
comment on column SCMDATA.T_SUPPLIER_INFO.inside_supplier_code
  is '�ڲ���Ӧ�̱��';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_company_id
  is '��Ӧ����ƽ̨����ҵid';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_company_name
  is '��˾����';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_company_abbreviation
  is '��˾���';
comment on column SCMDATA.T_SUPPLIER_INFO.legal_representative
  is '����������';
comment on column SCMDATA.T_SUPPLIER_INFO.company_create_date
  is '��������';
comment on column SCMDATA.T_SUPPLIER_INFO.regist_address
  is 'ע���ַ';
comment on column SCMDATA.T_SUPPLIER_INFO.certificate_validity_start
  is 'Ӫҵִ�տ�ʼ��Ч��';
comment on column SCMDATA.T_SUPPLIER_INFO.certificate_validity_end
  is 'Ӫҵִ�ս�ֹ��Ч��';
comment on column SCMDATA.T_SUPPLIER_INFO.regist_price
  is 'ע���ʱ�';
comment on column SCMDATA.T_SUPPLIER_INFO.social_credit_code
  is 'ͳһ�������֤������';
comment on column SCMDATA.T_SUPPLIER_INFO.company_type
  is '��˾����';
comment on column SCMDATA.T_SUPPLIER_INFO.company_person
  is '��˾Ա����������v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.company_contact_person
  is '��˾��ϵ�ˣ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.company_contact_phone
  is '��˾��ϵ���ֻ�';
comment on column SCMDATA.T_SUPPLIER_INFO.taxpayer
  is '��˰����ݣ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.company_say
  is '��˾��飨v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.certificate_file
  is '�ϴ�Ӫҵִ��';
comment on column SCMDATA.T_SUPPLIER_INFO.organization_file
  is '�ϴ���֯�ܹ�ͼ��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.contract_stop_date
  is '��ͬ��Ч������v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.contract_file
  is '�ϴ���ͬ������v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_method
  is '������ʽ��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_model
  is '����ģʽ';
comment on column SCMDATA.T_SUPPLIER_INFO.production_mode
  is '����ģʽ��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_type
  is '��������';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_classification
  is '�������ࣨv9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_subcategory
  is '�������ࣨv9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.sharing_type
  is '�������ͣ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.public_accounts
  is '�Թ��˺ţ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.public_payment
  is '�Թ��տ��ˣ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.public_bank
  is '�Թ������У�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.public_id
  is '�Թ����֤�ţ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.public_phone
  is '�Թ���ϵ�绰��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_account
  is '�����˺ţ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_payment
  is '�����տ��ˣ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_bank
  is '���˿����У�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_idcard
  is '�������֤�ţ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_phone
  is '������ϵ�绰��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.pay_type
  is '���ʽ��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.settlement_type
  is '���㷽ʽ��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.reconciliation_user
  is '������ϵ�ˣ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.reconciliation_phone
  is '������ϵ�绰��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.contract_start_date
  is '��ͬ��Ч�ڴӣ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.create_supp_date
  is '��������';
comment on column SCMDATA.T_SUPPLIER_INFO.company_address
  is '��˾��ַ';
comment on column SCMDATA.T_SUPPLIER_INFO.company_province
  is '��˾ʡ';
comment on column SCMDATA.T_SUPPLIER_INFO.company_city
  is '��˾��';
comment on column SCMDATA.T_SUPPLIER_INFO.company_county
  is '��˾��';
comment on column SCMDATA.T_SUPPLIER_INFO.group_name
  is '�������ƣ�v9.9�� ��ֵ��Ϊ����ID��';
comment on column SCMDATA.T_SUPPLIER_INFO.coop_position
  is '������λ';
comment on column SCMDATA.T_SUPPLIER_INFO.product_line
  is '����������';
comment on column SCMDATA.T_SUPPLIER_INFO.product_line_num
  is '����������';
comment on column SCMDATA.T_SUPPLIER_INFO.worker_num
  is '��λ����';
comment on column SCMDATA.T_SUPPLIER_INFO.machine_num
  is '֯��̨��';
comment on column SCMDATA.T_SUPPLIER_INFO.quality_step
  is '�����ȼ�';
comment on column SCMDATA.T_SUPPLIER_INFO.pattern_cap
  is '�������';
comment on column SCMDATA.T_SUPPLIER_INFO.fabric_purchase_cap
  is '���ϲɹ�����';
comment on column SCMDATA.T_SUPPLIER_INFO.fabric_check_cap
  is '���ϼ������';
comment on column SCMDATA.T_SUPPLIER_INFO.cost_step
  is '�ɱ��ȼ���v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.brand_type
  is '����Ʒ��/�ͻ� ����';
comment on column SCMDATA.T_SUPPLIER_INFO.product_type
  is '��������';
comment on column SCMDATA.T_SUPPLIER_INFO.product_link
  is '��������';
comment on column SCMDATA.T_SUPPLIER_INFO.fa_contact_name
  is 'ҵ����ϵ��';
comment on column SCMDATA.T_SUPPLIER_INFO.fa_contact_phone
  is 'ҵ����ϵ���ֻ�';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_brand
  is '����Ʒ��/�ͻ�';
comment on column SCMDATA.T_SUPPLIER_INFO.gendan_perid
  is '����ԱID';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_info_origin
  is '��Դ';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_info_origin_id
  is '��ԴID';
comment on column SCMDATA.T_SUPPLIER_INFO.status
  is '����״̬��0 δ���� 1 �ѽ���';
comment on column SCMDATA.T_SUPPLIER_INFO.coop_state
  is '����״̬��COOP_01 �Ե� COOP_02 ���� COOP_03 ͣ�� �����ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.bind_status
  is '��״̬';
comment on column SCMDATA.T_SUPPLIER_INFO.pause
  is '״̬��0 ���� 1 ͣ�� 2 �Ե�';
comment on column SCMDATA.T_SUPPLIER_INFO.publish_id
  is '�����ˣ��ӿڣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.publish_date
  is '����ʱ�䣨�ӿڣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.create_id
  is '������ID';
comment on column SCMDATA.T_SUPPLIER_INFO.create_date
  is '����ʱ��';
comment on column SCMDATA.T_SUPPLIER_INFO.update_id
  is '�޸���ID';
comment on column SCMDATA.T_SUPPLIER_INFO.update_date
  is '�޸�ʱ��';
comment on column SCMDATA.T_SUPPLIER_INFO.remarks
  is '��ע';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_gate
  is '��˾���Ÿ�����ַ';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_office
  is '��˾�칫�Ҹ�����ַ';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_site
  is '�����ֳ�������ַ';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_product
  is '��ƷͼƬ������ַ';
comment on column SCMDATA.T_SUPPLIER_INFO.file_remark
  is '������ע��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.reserve_capacity
  is 'ԤԼ����ռ�ȣ�v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.product_efficiency
  is '����Ч��';
comment on column SCMDATA.T_SUPPLIER_INFO.work_hours_day
  is '�ϰ�ʱ��/��';
comment on column SCMDATA.T_SUPPLIER_INFO.area_group_leader
  is '�����鳤��v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.ask_files
  is '������v9.10 ���ϣ�';
comment on column SCMDATA.T_SUPPLIER_INFO.admit_result
  is '׼����';
comment on column SCMDATA.T_SUPPLIER_INFO.pause_cause
  is '��ͣԭ��';
comment on column SCMDATA.T_SUPPLIER_INFO.group_name_origin
  is '������Դ��AA �Զ����ɣ�MA �ֶ��༭';
comment on column SCMDATA.T_SUPPLIER_INFO.company_vill
  is '��˾����';
comment on column SCMDATA.T_SUPPLIER_INFO.pay_term
  is '��������';
comment on column SCMDATA.T_SUPPLIER_INFO.company_regist_date
  is '��˾ע������';
comment on column SCMDATA.T_SUPPLIER_INFO.is_our_factory
  is '�Ƿ񱾳�';
comment on column SCMDATA.T_SUPPLIER_INFO.factroy_area
  is '���������m2��';
comment on column SCMDATA.T_SUPPLIER_INFO.worker_total_num
  is '������';
comment on column SCMDATA.T_SUPPLIER_INFO.form_num
  is '��������_Ь��';
comment on column SCMDATA.T_SUPPLIER_INFO.other_information
  is '��������';

---4.�鳧������޸ı�ṹ
alter table scmdata.t_factory_report add(person_config_result varchar2(32),
                                         person_config_reason varchar2(4000),
                                         machine_equipment_result varchar2(32),
                                         machine_equipment_reason varchar2(4000),
                                         control_result varchar2(32),
                                         control_reason varchar2(4000),
                                         factory_area number(8,4),
                                         total_number number(8,4),
                                         molding_number number(8,4),
                                         brand_type varchar2(4000),
                                         cooperation_brand varchar2(4000),
                                         spot_check_brand varchar2(4000),
                                         spot_check_type varchar2(4000),
                                         spot_check_result varchar2(32),
                                         disqualification_cause varchar2(4000),
                                         spot_check_result_accessory varchar2(2560));

comment on column scmdata.t_factory_report.person_config_result
  is '����(��Ա����)';
comment on column scmdata.t_factory_report.person_config_reason
  is '���ϸ�ԭ��(��Ա����)';
comment on column scmdata.t_factory_report.machine_equipment_result
  is '����(�����豸)';
comment on column scmdata.t_factory_report.machine_equipment_reason
  is '���ϸ�ԭ��(�����豸)';
comment on column scmdata.t_factory_report.control_result
  is '����(Ʒ����ϵ)';
comment on column scmdata.t_factory_report.control_reason
  is '���ϸ�ԭ��(Ʒ����ϵ)';
comment on column scmdata.t_factory_report.factory_area
  is '�������(m2)';
comment on column scmdata.t_factory_report.total_number
  is '������';
comment on column scmdata.t_factory_report.molding_number
  is '��������_Ь��';
comment on column scmdata.t_factory_report.brand_type
  is '����Ʒ��/�ͻ� ����';
comment on column scmdata.t_factory_report.cooperation_brand
  is '����Ʒ��/�ͻ�';
comment on column scmdata.t_factory_report.spot_check_brand
  is '���Ʒ��';
comment on column scmdata.t_factory_report.spot_check_type
  is '����ʽ���';
comment on column scmdata.t_factory_report.spot_check_result
  is '�����';
comment on column scmdata.t_factory_report.disqualification_cause
  is '���ϸ�ԭ��';
comment on column scmdata.t_factory_report.spot_check_result_accessory
  is '���������';

---20221226
alter table scmdata.t_factory_report modify check_report_file null; 
