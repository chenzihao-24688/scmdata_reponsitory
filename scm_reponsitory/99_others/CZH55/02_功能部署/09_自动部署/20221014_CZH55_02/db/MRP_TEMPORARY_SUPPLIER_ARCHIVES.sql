create table MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES
(
    SUPPLIER_CODE                         VARCHAR2(20) not null
        primary key,
    SUPPLIER_SOURCE                       VARCHAR2(30),
    COOPERATION_STATUS                    NUMBER(1),
    SUPPLIER_NAME                         VARCHAR2(60) not null,
    CREATE_FINISHED_PRODUCT_SUPPLIER_CODE VARCHAR2(32),
    RELATED_SUPPLIER_CODE                 VARCHAR2(32),
    BUSINESS_CONTACT                      VARCHAR2(20),
    CONTACT_PHONE                         VARCHAR2(16),
    DETAILED_ADDRESS                      VARCHAR2(100),
    WHETHER_DEL                           NUMBER(2) default 0,
    CREATE_TIME                           DATE,
    CREATE_ID                             VARCHAR2(32),
    UPDATE_TIME                           DATE,
    UPDATE_ID                             VARCHAR2(32),
    COOPERATION_CATEGORY                  VARCHAR2(64),
    NEW_COLUMN                            NUMBER
)
/

comment on table MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES is '临时供应商信息表'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.SUPPLIER_CODE is '供应商编号'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.SUPPLIER_SOURCE is '供应商来源'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.COOPERATION_STATUS is '合作状态，1启用0停用'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.SUPPLIER_NAME is '供应商名称'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.CREATE_FINISHED_PRODUCT_SUPPLIER_CODE is '创建成品供应商编号'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.RELATED_SUPPLIER_CODE is '关联确定供应商编号'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.BUSINESS_CONTACT is '业务联系人'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.CONTACT_PHONE is '联系电话'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.DETAILED_ADDRESS is '公司详细地址'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.WHETHER_DEL is '是否删除，0否1是'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.CREATE_TIME is '创建时间'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.CREATE_ID is '创建人'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.UPDATE_TIME is '更新时间'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.UPDATE_ID is '更新人'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.COOPERATION_CATEGORY is '合作类别'
/
