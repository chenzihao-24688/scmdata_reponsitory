alter table T_ORDERED add (isfirstordered     NUMBER(2));
comment on column T_ORDERED.isfirstordered
  is '是否首单';
  
alter table T_PRODUCTION_PROGRESS add (is_quality                   NUMBER(1));
comment on column T_PRODUCTION_PROGRESS.is_quality
  is '是否质量问题';  
  
alter table T_SUPPLIER_INFO add (group_name                    VARCHAR2(32));
comment on column T_SUPPLIER_INFO.group_name
  is '分组名称';  
