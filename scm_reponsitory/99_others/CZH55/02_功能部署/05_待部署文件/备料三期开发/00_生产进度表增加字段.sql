ALTER TABLE SCMDATA.T_PRODUCTION_PROGRESS ADD prepare_status VARCHAR2(32);

comment on column SCMDATA.T_PRODUCTION_PROGRESS.prepare_status
  is '����״̬��00 �ޱ��ϣ�01 δ��ɣ�02 ����ɣ�';
  
grant select, insert, update, delete, references, alter, index, debug, read on SCMDATA.T_PRODUCTION_PROGRESS to MRP;
