ALTER TABLE SCMDATA.T_PRODUCTION_PROGRESS ADD prepare_status VARCHAR2(32);

comment on column SCMDATA.T_PRODUCTION_PROGRESS.prepare_status
  is '备料状态（00 无备料，01 未完成，02 已完成）';
  
grant select, insert, update, delete, references, alter, index, debug, read on SCMDATA.T_PRODUCTION_PROGRESS to MRP;
