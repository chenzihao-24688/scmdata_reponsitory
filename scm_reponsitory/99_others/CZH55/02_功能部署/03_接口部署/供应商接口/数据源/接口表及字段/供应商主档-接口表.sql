--删除表
drop table scmdata.t_supplier_base_itf;
/
-- Create table
create table T_SUPPLIER_BASE_ITF
(
  itf_id            VARCHAR2(32) not null,
  supplier_code     VARCHAR2(32),
  sup_id_base       NUMBER(5),
  sup_name          VARCHAR2(100),
  legalperson       VARCHAR2(48),
  linkman           VARCHAR2(48),
  phonenumber       VARCHAR2(20),
  address           VARCHAR2(140),
  sup_type          VARCHAR2(20),
  sup_status        VARCHAR2(1),
  countyid          NUMBER,
  provinceid        NUMBER,
  cityno            NUMBER,
  tax_id            VARCHAR2(50),
  cooperation_model VARCHAR2(48),
  data_status       VARCHAR2(32),
  fetch_flag        NUMBER default 0,
  create_id         VARCHAR2(32),
  create_time       DATE,
  update_id         VARCHAR2(32),
  update_time       DATE,
  publish_id        VARCHAR2(32),
  publish_time      DATE,
  sup_type_name     VARCHAR2(20),
  fetch_time        DATE,
  pause             NUMBER,
  supp_date         DATE,
  memo              VARCHAR2(300)
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
-- Add comments to the columns 
comment on column T_SUPPLIER_BASE_ITF.itf_id
  is '接口编号，主键';
comment on column T_SUPPLIER_BASE_ITF.supplier_code
  is '供应商档案编号（scm）';
comment on column T_SUPPLIER_BASE_ITF.sup_id_base
  is '回传供应商编号（mdm）';
comment on column T_SUPPLIER_BASE_ITF.sup_name
  is '供应商名称';
comment on column T_SUPPLIER_BASE_ITF.legalperson
  is '法人代表';
comment on column T_SUPPLIER_BASE_ITF.linkman
  is '联系人';
comment on column T_SUPPLIER_BASE_ITF.phonenumber
  is '电话号码';
comment on column T_SUPPLIER_BASE_ITF.address
  is '注册地址';
comment on column T_SUPPLIER_BASE_ITF.sup_type
  is '供应商类型编号';
comment on column T_SUPPLIER_BASE_ITF.sup_status
  is '供应商状态';
comment on column T_SUPPLIER_BASE_ITF.countyid
  is '省';
comment on column T_SUPPLIER_BASE_ITF.provinceid
  is '市';
comment on column T_SUPPLIER_BASE_ITF.cityno
  is '区';
comment on column T_SUPPLIER_BASE_ITF.tax_id
  is '统一社会信用代码';
comment on column T_SUPPLIER_BASE_ITF.cooperation_model
  is '合作模式';
comment on column T_SUPPLIER_BASE_ITF.data_status
  is '数据状态（I 新增、U 更新）';
comment on column T_SUPPLIER_BASE_ITF.fetch_flag
  is 'scm获取标识';
comment on column T_SUPPLIER_BASE_ITF.create_id
  is '创建人';
comment on column T_SUPPLIER_BASE_ITF.create_time
  is '创建时间';
comment on column T_SUPPLIER_BASE_ITF.update_id
  is '修改人';
comment on column T_SUPPLIER_BASE_ITF.update_time
  is '修改时间';
comment on column T_SUPPLIER_BASE_ITF.publish_id
  is '发布人';
comment on column T_SUPPLIER_BASE_ITF.publish_time
  is '发布时间';
comment on column T_SUPPLIER_BASE_ITF.sup_type_name
  is '供应商类型';
comment on column T_SUPPLIER_BASE_ITF.fetch_time
  is '获取时间';
comment on column T_SUPPLIER_BASE_ITF.pause
  is '启停状态';
comment on column T_SUPPLIER_BASE_ITF.supp_date
  is '建档日期';
comment on column T_SUPPLIER_BASE_ITF.memo
  is '备注';
