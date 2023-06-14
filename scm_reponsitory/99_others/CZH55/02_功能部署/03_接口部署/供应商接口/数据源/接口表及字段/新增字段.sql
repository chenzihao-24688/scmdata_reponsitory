--t_supplier_info 新增列
ALTER TABLE scmdata.t_supplier_info ADD PUBLISH_ID VARCHAR2(32); 
COMMENT ON COLUMN scmdata.t_supplier_info.PUBLISH_ID IS '发布人（接口）' ;

ALTER TABLE scmdata.t_supplier_info ADD PUBLISH_DATE DATE; 
COMMENT ON COLUMN scmdata.t_supplier_info.PUBLISH_DATE IS '发布时间（接口）' ;
