alter table T_ORDERED add (isfirstordered     NUMBER(2));
comment on column T_ORDERED.isfirstordered
  is '�Ƿ��׵�';
  
alter table T_PRODUCTION_PROGRESS add (is_quality  NUMBER(1));
comment on column T_PRODUCTION_PROGRESS.is_quality
  is '�Ƿ���������';  
  
alter table T_SUPPLIER_INFO add (group_name   VARCHAR2(32));
comment on column T_SUPPLIER_INFO.group_name
  is '��������';  
   
alter table T_ABNORMAL_DTL_CONFIG add (is_quality_problem  NUMBER(1));  
comment on column T_ABNORMAL_DTL_CONFIG.is_quality_problem
  is '�Ƿ���������';
