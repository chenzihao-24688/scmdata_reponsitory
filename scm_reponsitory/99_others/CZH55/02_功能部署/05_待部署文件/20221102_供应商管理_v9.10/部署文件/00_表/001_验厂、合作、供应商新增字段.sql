---1.合作申请记录表修改表结构
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
  is '合作申请记录表';
comment on column  SCMDATA.T_ASK_RECORD.ask_record_id
  is '主键';
comment on column  SCMDATA.T_ASK_RECORD.company_id
  is '申请方企业ID';
comment on column  SCMDATA.T_ASK_RECORD.be_company_id
  is '被申请方企业ID';
comment on column  SCMDATA.T_ASK_RECORD.company_province
  is '公司省';
comment on column  SCMDATA.T_ASK_RECORD.company_city
  is '公司市';
comment on column  SCMDATA.T_ASK_RECORD.company_county
  is '公司区';
comment on column  SCMDATA.T_ASK_RECORD.company_address
  is '公司详细地址';
comment on column  SCMDATA.T_ASK_RECORD.ask_date
  is '申请时间';
comment on column  SCMDATA.T_ASK_RECORD.ask_user_id
  is '申请人ID';
comment on column  SCMDATA.T_ASK_RECORD.ask_say
  is '申请说明';
comment on column  SCMDATA.T_ASK_RECORD.cooperation_type
  is '意向合作类型';
comment on column  SCMDATA.T_ASK_RECORD.cooperation_model
  is '意向合作模式';
comment on column  SCMDATA.T_ASK_RECORD.certificate_file
  is '营业执照（企业证照）';
comment on column  SCMDATA.T_ASK_RECORD.other_file
  is '更多附件地址（多个逗号隔开）';
comment on column  SCMDATA.T_ASK_RECORD.company_name
  is '公司名称';
comment on column  SCMDATA.T_ASK_RECORD.company_abbreviation
  is '公司简称';
comment on column  SCMDATA.T_ASK_RECORD.social_credit_code
  is '统一社会信用代码';
comment on column  SCMDATA.T_ASK_RECORD.cooperation_statement
  is '合作申请说明';
comment on column  SCMDATA.T_ASK_RECORD.sapply_user
  is '业务联系人 ';
comment on column  SCMDATA.T_ASK_RECORD.sapply_phone
  is '业务联系电话 ';
comment on column  SCMDATA.T_ASK_RECORD.legal_representative
  is '法定代表人';
comment on column  SCMDATA.T_ASK_RECORD.company_contact_phone
  is '公司联系人手机';
comment on column  SCMDATA.T_ASK_RECORD.company_type
  is '公司类型--对应验厂COMPANY_MOLD';
comment on column  SCMDATA.T_ASK_RECORD.brand_type
  is '合作品牌/客户 类型';
comment on column  SCMDATA.T_ASK_RECORD.cooperation_brand
  is '合作品牌/客户';
comment on column  SCMDATA.T_ASK_RECORD.product_link
  is '生产环节';
comment on column  SCMDATA.T_ASK_RECORD.supplier_gate
  is '公司大门附件地址';
comment on column  SCMDATA.T_ASK_RECORD.supplier_office
  is '公司办公室附件地址';
comment on column  SCMDATA.T_ASK_RECORD.supplier_site
  is '生产现场附件地址';
comment on column  SCMDATA.T_ASK_RECORD.supplier_product
  is '产品图片附件地址';
comment on column  SCMDATA.T_ASK_RECORD.coor_ask_flow_status
  is '合作申请审批状态';
comment on column  SCMDATA.T_ASK_RECORD.collection
  is '收藏';
comment on column  SCMDATA.T_ASK_RECORD.origin
  is '来源';
comment on column  SCMDATA.T_ASK_RECORD.create_id
  is '创建人ID';
comment on column  SCMDATA.T_ASK_RECORD.create_date
  is '创建时间';
comment on column  SCMDATA.T_ASK_RECORD.update_id
  is '修改人ID';
comment on column  SCMDATA.T_ASK_RECORD.update_date
  is '修改时间';
comment on column  SCMDATA.T_ASK_RECORD.remarks
  is '备注';
comment on column  SCMDATA.T_ASK_RECORD.company_vill
  is '公司乡镇/街道';
  
comment on column  SCMDATA.T_ASK_RECORD.company_regist_date
  is '公司注册日期';
comment on column  SCMDATA.T_ASK_RECORD.pay_term
  is '付款条件';
comment on column  SCMDATA.T_ASK_RECORD.product_type
  is '生产类型';
comment on column  SCMDATA.T_ASK_RECORD.rela_supplier_id
  is '关联供应商ID';
comment on column  SCMDATA.T_ASK_RECORD.is_our_factory
  is '是否本厂';
comment on column  SCMDATA.T_ASK_RECORD.factory_name
  is '工厂名称';
comment on column  SCMDATA.T_ASK_RECORD.factory_province
  is '工厂所在省';
comment on column  SCMDATA.T_ASK_RECORD.factory_city
  is '工厂所在市';
comment on column  SCMDATA.T_ASK_RECORD.factory_county
  is '工厂所在区';
comment on column  SCMDATA.T_ASK_RECORD.factory_vill
  is '工厂所在乡镇/街道';
comment on column  SCMDATA.T_ASK_RECORD.factroy_details_address
  is '工厂详细地址';
comment on column  SCMDATA.T_ASK_RECORD.factroy_area
  is '工厂面积（m2）';
comment on column  SCMDATA.T_ASK_RECORD.product_line
  is '生产线类型';
comment on column  SCMDATA.T_ASK_RECORD.product_line_num
  is '生产线数量';
comment on column  SCMDATA.T_ASK_RECORD.quality_step
  is '质量等级';
comment on column  SCMDATA.T_ASK_RECORD.work_hours_day
  is '上班时数/天';
comment on column  SCMDATA.T_ASK_RECORD.worker_total_num
  is '总人数';
comment on column  SCMDATA.T_ASK_RECORD.worker_num
  is '车位人数';
comment on column  SCMDATA.T_ASK_RECORD.machine_num
  is '织机台数_毛织类';
comment on column  SCMDATA.T_ASK_RECORD.form_num
  is '成型人数_鞋类';
comment on column  SCMDATA.T_ASK_RECORD.product_efficiency
  is '生产效率';
comment on column  SCMDATA.T_ASK_RECORD.pattern_cap
  is '打版能力';
comment on column  SCMDATA.T_ASK_RECORD.fabric_purchase_cap
  is '面料采购能力';
comment on column  SCMDATA.T_ASK_RECORD.fabric_check_cap
  is '面料检测能力';
comment on column  SCMDATA.T_ASK_RECORD.other_information
  is '其他资料';

---2.合作申请记录表修改表结构
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
  is '验厂申请表(供应商信息)';
comment on column SCMDATA.T_FACTORY_ASK.factory_ask_id
  is '主键';
comment on column SCMDATA.T_FACTORY_ASK.company_id
  is '公司编号';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_company_id
  is '合作公司id';
comment on column SCMDATA.T_FACTORY_ASK.ask_user_id
  is '验厂申请人ID';
comment on column SCMDATA.T_FACTORY_ASK.ask_company_id
  is '验厂公司编号';
comment on column SCMDATA.T_FACTORY_ASK.ask_record_id
  is '合作申请id';
comment on column SCMDATA.T_FACTORY_ASK.ask_user_dept_id
  is '申请部门id';
comment on column SCMDATA.T_FACTORY_ASK.is_urgent
  is '是否紧急';
comment on column SCMDATA.T_FACTORY_ASK.company_province
  is '公司省 ';
comment on column SCMDATA.T_FACTORY_ASK.company_city
  is '公司市';
comment on column SCMDATA.T_FACTORY_ASK.company_county
  is '公司区';
comment on column SCMDATA.T_FACTORY_ASK.contact_name
  is '联系人';
comment on column SCMDATA.T_FACTORY_ASK.contact_phone
  is '联系人手机';
comment on column SCMDATA.T_FACTORY_ASK.company_type
  is '需求公司类型 ';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_method
  is '意向合作方式（v_9.10 作废）';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_model
  is '意向合作模式 ';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_type
  is '意向合作方式类型';
comment on column SCMDATA.T_FACTORY_ASK.company_name
  is '被验厂公司名称';
comment on column SCMDATA.T_FACTORY_ASK.company_abbreviation
  is '公司简称';
comment on column SCMDATA.T_FACTORY_ASK.company_address
  is '公司详细地址';
comment on column SCMDATA.T_FACTORY_ASK.social_credit_code
  is '统一社会信用代码';
comment on column SCMDATA.T_FACTORY_ASK.legal_representative
  is '法定代表人';
comment on column SCMDATA.T_FACTORY_ASK.company_contact_phone
  is '公司联系电话';
comment on column SCMDATA.T_FACTORY_ASK.company_mold
  is '公司类型（v_9.10 作废）';
comment on column SCMDATA.T_FACTORY_ASK.brand_type
  is '合作品牌/客户 类型';
comment on column SCMDATA.T_FACTORY_ASK.cooperation_brand
  is '合作品牌/客户';
comment on column SCMDATA.T_FACTORY_ASK.product_type
  is '生产类型';
comment on column SCMDATA.T_FACTORY_ASK.product_link
  is '生产环节';
comment on column SCMDATA.T_FACTORY_ASK.rela_supplier_id
  is '关联供应商ID';
comment on column SCMDATA.T_FACTORY_ASK.ask_date
  is '验厂申请日期';
comment on column SCMDATA.T_FACTORY_ASK.ask_address
  is '验厂地址(工厂详细地址)';
comment on column SCMDATA.T_FACTORY_ASK.ask_say
  is '验厂申请说明 ';
comment on column SCMDATA.T_FACTORY_ASK.ask_files
  is '验厂申请附件';
comment on column SCMDATA.T_FACTORY_ASK.factory_ask_type
  is '验厂类型（0不验厂，1内部验厂，2第三方验厂）';
comment on column SCMDATA.T_FACTORY_ASK.factrory_ask_flow_status
  is '审核状态';
comment on column SCMDATA.T_FACTORY_ASK.supplier_gate
  is '公司大门附件地址';
comment on column SCMDATA.T_FACTORY_ASK.supplier_office
  is '公司办公室附件地址';
comment on column SCMDATA.T_FACTORY_ASK.supplier_site
  is '生产现场附件地址';
comment on column SCMDATA.T_FACTORY_ASK.supplier_product
  is '产品图片附件地址';
comment on column SCMDATA.T_FACTORY_ASK.com_manufacturer
  is '生产工厂（作废）';
comment on column SCMDATA.T_FACTORY_ASK.certificate_file
  is '营业执照';
comment on column SCMDATA.T_FACTORY_ASK.origin
  is '来源';
comment on column SCMDATA.T_FACTORY_ASK.create_id
  is '创建人ID';
comment on column SCMDATA.T_FACTORY_ASK.create_date
  is '创建时间';
comment on column SCMDATA.T_FACTORY_ASK.update_id
  is '修改人ID';
comment on column SCMDATA.T_FACTORY_ASK.update_date
  is '修改时间';
comment on column SCMDATA.T_FACTORY_ASK.remarks
  is '备注(操作记录)';
comment on column SCMDATA.T_FACTORY_ASK.factory_name
  is '工厂名称';
comment on column SCMDATA.T_FACTORY_ASK.factory_province
  is '工厂所在省';
comment on column SCMDATA.T_FACTORY_ASK.factory_city
  is '工厂所在市';
comment on column SCMDATA.T_FACTORY_ASK.factory_county
  is '工厂所在区';
comment on column SCMDATA.T_FACTORY_ASK.worker_num
  is '车位人数';
comment on column SCMDATA.T_FACTORY_ASK.machine_num
  is '织机台数_毛织类';
comment on column SCMDATA.T_FACTORY_ASK.reserve_capacity
  is '预约产能占比';
comment on column SCMDATA.T_FACTORY_ASK.product_efficiency
  is '生产效率 ';
comment on column SCMDATA.T_FACTORY_ASK.work_hours_day
  is '上班时数/天';
comment on column SCMDATA.T_FACTORY_ASK.memo
  is '备注';
comment on column SCMDATA.T_FACTORY_ASK.company_vill
  is '公司乡镇/街道';
comment on column SCMDATA.T_FACTORY_ASK.factory_vill
  is '工厂所在乡镇/街道';
comment on column SCMDATA.T_FACTORY_ASK.pay_term
  is '付款条件';
comment on column SCMDATA.T_FACTORY_ASK.company_regist_date
  is '公司注册日期 ';
comment on column SCMDATA.T_FACTORY_ASK.is_our_factory
  is '是否本厂';
comment on column SCMDATA.T_FACTORY_ASK.factroy_area
  is '工厂面积（m2）';
comment on column SCMDATA.T_FACTORY_ASK.product_line
  is '生产线类型';
comment on column SCMDATA.T_FACTORY_ASK.product_line_num
  is '生产线数量(组)';
comment on column SCMDATA.T_FACTORY_ASK.quality_step
  is '质量等级';
comment on column SCMDATA.T_FACTORY_ASK.worker_total_num
  is '总人数 ';
comment on column SCMDATA.T_FACTORY_ASK.form_num
  is '成型人数_鞋类';
comment on column SCMDATA.T_FACTORY_ASK.pattern_cap
  is '打版能力';
comment on column SCMDATA.T_FACTORY_ASK.fabric_purchase_cap
  is '面料采购能力';
comment on column SCMDATA.T_FACTORY_ASK.fabric_check_cap
  is '面料检测能力';
comment on column SCMDATA.T_FACTORY_ASK.other_information
  is '其他资料';
comment on column SCMDATA.T_FACTORY_ASK.factroy_details_address
  is '工厂详细地址';

---3.供应商档案表修改表结构
alter table SCMDATA.T_SUPPLIER_INFO add(
  pay_term                      VARCHAR2(32),
  company_regist_date           DATE,
  is_our_factory                NUMBER(1),
  factroy_area                  NUMBER(14,2),
  worker_total_num              NUMBER,
  form_num                      NUMBER,
  other_information             VARCHAR2(256));

comment on table SCMDATA.T_SUPPLIER_INFO
  is '供应商档案';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_info_id
  is '主键';
comment on column SCMDATA.T_SUPPLIER_INFO.company_id
  is '公司编码';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_code
  is '供应商编号';
comment on column SCMDATA.T_SUPPLIER_INFO.inside_supplier_code
  is '内部供应商编号';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_company_id
  is '供应商在平台的企业id';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_company_name
  is '公司名称';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_company_abbreviation
  is '公司简称';
comment on column SCMDATA.T_SUPPLIER_INFO.legal_representative
  is '法定代表人';
comment on column SCMDATA.T_SUPPLIER_INFO.company_create_date
  is '成立日期';
comment on column SCMDATA.T_SUPPLIER_INFO.regist_address
  is '注册地址';
comment on column SCMDATA.T_SUPPLIER_INFO.certificate_validity_start
  is '营业执照开始有效期';
comment on column SCMDATA.T_SUPPLIER_INFO.certificate_validity_end
  is '营业执照截止有效期';
comment on column SCMDATA.T_SUPPLIER_INFO.regist_price
  is '注册资本';
comment on column SCMDATA.T_SUPPLIER_INFO.social_credit_code
  is '统一社会信用证件代码';
comment on column SCMDATA.T_SUPPLIER_INFO.company_type
  is '公司类型';
comment on column SCMDATA.T_SUPPLIER_INFO.company_person
  is '公司员工总人数（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.company_contact_person
  is '公司联系人（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.company_contact_phone
  is '公司联系人手机';
comment on column SCMDATA.T_SUPPLIER_INFO.taxpayer
  is '纳税人身份（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.company_say
  is '公司简介（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.certificate_file
  is '上传营业执照';
comment on column SCMDATA.T_SUPPLIER_INFO.organization_file
  is '上传组织架构图（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.contract_stop_date
  is '合同有效期至（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.contract_file
  is '上传合同附件（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_method
  is '合作方式（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_model
  is '合作模式';
comment on column SCMDATA.T_SUPPLIER_INFO.production_mode
  is '生产模式（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_type
  is '合作类型';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_classification
  is '合作分类（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_subcategory
  is '合作子类（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.sharing_type
  is '共享类型（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.public_accounts
  is '对公账号（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.public_payment
  is '对公收款人（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.public_bank
  is '对公开户行（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.public_id
  is '对公身份证号（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.public_phone
  is '对公联系电话（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_account
  is '个人账号（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_payment
  is '个人收款人（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_bank
  is '个人开户行（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_idcard
  is '个人身份证号（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.personal_phone
  is '个人联系电话（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.pay_type
  is '付款方式（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.settlement_type
  is '结算方式（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.reconciliation_user
  is '对账联系人（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.reconciliation_phone
  is '对账联系电话（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.contract_start_date
  is '合同有效期从（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.create_supp_date
  is '建档日期';
comment on column SCMDATA.T_SUPPLIER_INFO.company_address
  is '公司地址';
comment on column SCMDATA.T_SUPPLIER_INFO.company_province
  is '公司省';
comment on column SCMDATA.T_SUPPLIER_INFO.company_city
  is '公司市';
comment on column SCMDATA.T_SUPPLIER_INFO.company_county
  is '公司区';
comment on column SCMDATA.T_SUPPLIER_INFO.group_name
  is '分组名称（v9.9版 存值改为分组ID）';
comment on column SCMDATA.T_SUPPLIER_INFO.coop_position
  is '合作定位';
comment on column SCMDATA.T_SUPPLIER_INFO.product_line
  is '生产线类型';
comment on column SCMDATA.T_SUPPLIER_INFO.product_line_num
  is '生产线数量';
comment on column SCMDATA.T_SUPPLIER_INFO.worker_num
  is '车位人数';
comment on column SCMDATA.T_SUPPLIER_INFO.machine_num
  is '织机台数';
comment on column SCMDATA.T_SUPPLIER_INFO.quality_step
  is '质量等级';
comment on column SCMDATA.T_SUPPLIER_INFO.pattern_cap
  is '打版能力';
comment on column SCMDATA.T_SUPPLIER_INFO.fabric_purchase_cap
  is '面料采购能力';
comment on column SCMDATA.T_SUPPLIER_INFO.fabric_check_cap
  is '面料检测能力';
comment on column SCMDATA.T_SUPPLIER_INFO.cost_step
  is '成本等级（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.brand_type
  is '合作品牌/客户 类型';
comment on column SCMDATA.T_SUPPLIER_INFO.product_type
  is '生产类型';
comment on column SCMDATA.T_SUPPLIER_INFO.product_link
  is '生产环节';
comment on column SCMDATA.T_SUPPLIER_INFO.fa_contact_name
  is '业务联系人';
comment on column SCMDATA.T_SUPPLIER_INFO.fa_contact_phone
  is '业务联系人手机';
comment on column SCMDATA.T_SUPPLIER_INFO.cooperation_brand
  is '合作品牌/客户';
comment on column SCMDATA.T_SUPPLIER_INFO.gendan_perid
  is '跟单员ID';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_info_origin
  is '来源';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_info_origin_id
  is '来源ID';
comment on column SCMDATA.T_SUPPLIER_INFO.status
  is '建档状态：0 未建档 1 已建档';
comment on column SCMDATA.T_SUPPLIER_INFO.coop_state
  is '合作状态：COOP_01 试单 COOP_02 正常 COOP_03 停用 （作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.bind_status
  is '绑定状态';
comment on column SCMDATA.T_SUPPLIER_INFO.pause
  is '状态：0 启用 1 停用 2 试单';
comment on column SCMDATA.T_SUPPLIER_INFO.publish_id
  is '发布人（接口）';
comment on column SCMDATA.T_SUPPLIER_INFO.publish_date
  is '发布时间（接口）';
comment on column SCMDATA.T_SUPPLIER_INFO.create_id
  is '创建人ID';
comment on column SCMDATA.T_SUPPLIER_INFO.create_date
  is '创建时间';
comment on column SCMDATA.T_SUPPLIER_INFO.update_id
  is '修改人ID';
comment on column SCMDATA.T_SUPPLIER_INFO.update_date
  is '修改时间';
comment on column SCMDATA.T_SUPPLIER_INFO.remarks
  is '备注';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_gate
  is '公司大门附件地址';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_office
  is '公司办公室附件地址';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_site
  is '生产现场附件地址';
comment on column SCMDATA.T_SUPPLIER_INFO.supplier_product
  is '产品图片附件地址';
comment on column SCMDATA.T_SUPPLIER_INFO.file_remark
  is '附件备注（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.reserve_capacity
  is '预约产能占比（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.product_efficiency
  is '产能效率';
comment on column SCMDATA.T_SUPPLIER_INFO.work_hours_day
  is '上班时数/天';
comment on column SCMDATA.T_SUPPLIER_INFO.area_group_leader
  is '区域组长（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.ask_files
  is '附件（v9.10 作废）';
comment on column SCMDATA.T_SUPPLIER_INFO.admit_result
  is '准入结果';
comment on column SCMDATA.T_SUPPLIER_INFO.pause_cause
  is '启停原因';
comment on column SCMDATA.T_SUPPLIER_INFO.group_name_origin
  is '分组来源：AA 自动生成，MA 手动编辑';
comment on column SCMDATA.T_SUPPLIER_INFO.company_vill
  is '公司乡镇';
comment on column SCMDATA.T_SUPPLIER_INFO.pay_term
  is '付款条件';
comment on column SCMDATA.T_SUPPLIER_INFO.company_regist_date
  is '公司注册日期';
comment on column SCMDATA.T_SUPPLIER_INFO.is_our_factory
  is '是否本厂';
comment on column SCMDATA.T_SUPPLIER_INFO.factroy_area
  is '工厂面积（m2）';
comment on column SCMDATA.T_SUPPLIER_INFO.worker_total_num
  is '总人数';
comment on column SCMDATA.T_SUPPLIER_INFO.form_num
  is '成型人数_鞋类';
comment on column SCMDATA.T_SUPPLIER_INFO.other_information
  is '其他资料';

---4.验厂报告表修改表结构
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
  is '结论(人员配置)';
comment on column scmdata.t_factory_report.person_config_reason
  is '不合格原因(人员配置)';
comment on column scmdata.t_factory_report.machine_equipment_result
  is '结论(机器设备)';
comment on column scmdata.t_factory_report.machine_equipment_reason
  is '不合格原因(机器设备)';
comment on column scmdata.t_factory_report.control_result
  is '结论(品控体系)';
comment on column scmdata.t_factory_report.control_reason
  is '不合格原因(品控体系)';
comment on column scmdata.t_factory_report.factory_area
  is '工厂面积(m2)';
comment on column scmdata.t_factory_report.total_number
  is '总人数';
comment on column scmdata.t_factory_report.molding_number
  is '成型人数_鞋类';
comment on column scmdata.t_factory_report.brand_type
  is '合作品牌/客户 类型';
comment on column scmdata.t_factory_report.cooperation_brand
  is '合作品牌/客户';
comment on column scmdata.t_factory_report.spot_check_brand
  is '抽查品牌';
comment on column scmdata.t_factory_report.spot_check_type
  is '抽查款式类别';
comment on column scmdata.t_factory_report.spot_check_result
  is '抽查结果';
comment on column scmdata.t_factory_report.disqualification_cause
  is '不合格原因';
comment on column scmdata.t_factory_report.spot_check_result_accessory
  is '抽查结果附件';

---20221226
alter table scmdata.t_factory_report modify check_report_file null; 
