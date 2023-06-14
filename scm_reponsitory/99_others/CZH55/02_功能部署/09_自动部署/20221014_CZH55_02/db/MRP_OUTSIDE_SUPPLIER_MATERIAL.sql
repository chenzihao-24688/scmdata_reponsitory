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
comment on table MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL is '�ⲿ��Ӧ��������Ϣ��'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SKU_ABUTMENT_CODE is '��Ӧ������SKU�Խ���'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_CODE is '��Ӧ�̱��'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.MATERIAL_SKU is '����SKU'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_MATERIAL_NAME is '��Ӧ����������'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.COLOR_CARD_PICTURE is 'ɫ��ͼ����sku�Խ��룬��ͼƬ��ͨ��sku�Խ������'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_COLOR is '��Ӧ����ɫ'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_SHADES is '��Ӧ��ɫ��'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.OPTIMIZATION is '�Ƿ���ѡ'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.DISPARITY is '�ղ�'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_LARGE_GOOD_QUOTE is '��Ӧ�̴������'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_LARGE_GOOD_NET_PRICE is '��Ӧ�̴������'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.SUPPLIER_MATERIAL_STATUS is '��Ӧ������״̬��1����0ͣ��'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.MATERIAL_SOURCE is '������Դ'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.CREATE_TIME is '��Ӧ�����ϴ���ʱ��'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.CREATER is '��Ӧ�����ϴ�����'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.CREATE_FINISHED_SUPPLIER_CODE is '������Ʒ��Ӧ�̱��'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.WHETHER_DEL is '�Ƿ�ɾ����0��1��'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.UPDATE_TIME is '����ʱ��'
/

comment on column MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL.UPDATE_ID is '������'
/





