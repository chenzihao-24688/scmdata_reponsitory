create table MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL
(
    SKU_ABUTMENT_CODE             VARCHAR2(34)  not null
        primary key,
    SUPPLIER_CODE                 VARCHAR2(10)  not null,
    MATERIAL_SKU                  VARCHAR2(16)  not null,
    SUPPLIER_MATERIAL_NAME        VARCHAR2(50)  not null,
    COLOR_CARD_PICTURE            VARCHAR2(24),
    SUPPLIER_COLOR                VARCHAR2(150) not null,
    SUPPLIER_SHADES               VARCHAR2(30),
    OPTIMIZATION                  NUMBER(1),
    DISPARITY                     NUMBER(10, 2),
    SUPPLIER_LARGE_GOOD_QUOTE     NUMBER(10, 2),
    SUPPLIER_LARGE_GOOD_NET_PRICE NUMBER(10, 2),
    SUPPLIER_MATERIAL_STATUS      NUMBER(1),
    MATERIAL_SOURCE               VARCHAR2(20),
    CREATE_TIME                   DATE,
    CREATER                       VARCHAR2(36),
    CREATE_FINISHED_SUPPLIER_CODE VARCHAR2(32),
    WHETHER_DEL                   NUMBER(2) default 0,
    UPDATE_TIME                   DATE,
    UPDATE_ID                     VARCHAR2(32),
    MATERIAL_SPU                  VARCHAR2(64)
)
/
comment on table MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL is '外部供应商物料信息表'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SKU_ABUTMENT_CODE is '供应商物料SKU对接码'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_CODE is '供应商编号'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.MATERIAL_SKU is '物料SKU'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_MATERIAL_NAME is '供应商物料名称'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.COLOR_CARD_PICTURE is '色卡图，存sku对接码，在图片表通过sku对接码关联'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_COLOR is '供应商颜色'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_SHADES is '供应商色号'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.OPTIMIZATION is '是否优选'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.DISPARITY is '空差'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_LARGE_GOOD_QUOTE is '供应商大货报价'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_LARGE_GOOD_NET_PRICE is '供应商大货净价'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_MATERIAL_STATUS is '供应商物料状态，1启用0停用'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.MATERIAL_SOURCE is '物料来源'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.CREATE_TIME is '供应商物料创建时间'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.CREATER is '供应商物料创建人'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.CREATE_FINISHED_SUPPLIER_CODE is '创建成品供应商编号'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.WHETHER_DEL is '是否删除，0否1是'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.UPDATE_TIME is '更新时间'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.UPDATE_ID is '更新人'
/





