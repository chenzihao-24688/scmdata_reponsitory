--t_supplier_info ������
ALTER TABLE scmdata.t_supplier_info ADD PUBLISH_ID VARCHAR2(32); 
COMMENT ON COLUMN scmdata.t_supplier_info.PUBLISH_ID IS '�����ˣ��ӿڣ�' ;

ALTER TABLE scmdata.t_supplier_info ADD PUBLISH_DATE DATE; 
COMMENT ON COLUMN scmdata.t_supplier_info.PUBLISH_DATE IS '����ʱ�䣨�ӿڣ�' ;
