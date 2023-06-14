--pt_ordered要加字段
ALTER TABLE SCMDATA.PT_ORDERED ADD UPDATED_QC NUMBER(1) default 0;
comment on column scmdata.PT_ORDERED.UPDATED_QC
  is 'qc是否在交期表中更改';

ALTER TABLE SCMDATA.PT_ORDERED ADD AREA_LOCATIOIN VARCHAR2(256);
comment on column scmdata.PT_ORDERED.AREA_LOCATIOIN
  is '所在区域';

ALTER TABLE SCMDATA.PT_ORDERED ADD LATEST_PLANNED_DELIVERY_DATE DATE;
comment on column scmdata.PT_ORDERED.LATEST_PLANNED_DELIVERY_DATE
  is '最新计划交期';
  
ALTER TABLE SCMDATA.PT_ORDERED ADD IS_PRODUCT_ORDER NUMBER(1);
comment on column scmdata.PT_ORDERED.IS_PRODUCT_ORDER
  is '是否生产订单';
  
--QC更新标志字段要刷新
BEGIN  
  UPDATE scmdata.pt_ordered t SET t.updated_qc = 0 WHERE t.updated_qc IS NULL;
END;
/  
  
