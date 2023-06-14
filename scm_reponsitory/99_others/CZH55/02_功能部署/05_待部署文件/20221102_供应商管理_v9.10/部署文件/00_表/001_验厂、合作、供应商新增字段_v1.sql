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

---20221226
alter table scmdata.t_factory_report modify check_report_file null; 
