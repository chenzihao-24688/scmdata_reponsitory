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

comment on table MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES is '��ʱ��Ӧ����Ϣ��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.SUPPLIER_CODE is '��Ӧ�̱��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.SUPPLIER_SOURCE is '��Ӧ����Դ'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.COOPERATION_STATUS is '����״̬��1����0ͣ��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.SUPPLIER_NAME is '��Ӧ������'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.CREATE_FINISHED_PRODUCT_SUPPLIER_CODE is '������Ʒ��Ӧ�̱��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.RELATED_SUPPLIER_CODE is '����ȷ����Ӧ�̱��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.BUSINESS_CONTACT is 'ҵ����ϵ��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.CONTACT_PHONE is '��ϵ�绰'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.DETAILED_ADDRESS is '��˾��ϸ��ַ'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.WHETHER_DEL is '�Ƿ�ɾ����0��1��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.CREATE_TIME is '����ʱ��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.CREATE_ID is '������'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.UPDATE_TIME is '����ʱ��'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.UPDATE_ID is '������'
/

comment on column MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES.COOPERATION_CATEGORY is '�������'
/
