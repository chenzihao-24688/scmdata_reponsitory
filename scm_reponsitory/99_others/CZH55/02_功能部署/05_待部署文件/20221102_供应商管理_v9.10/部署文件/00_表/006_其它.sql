alter table scmdata.t_factory_report modify factory_area number(18,2);
alter table scmdata.t_factory_ask MODIFY ASK_ADDRESS NULL;
alter table scmdata.t_ask_record modify SUPPLIER_SITE VARCHAR2(660);
alter table scmdata.t_factory_ask modify SUPPLIER_SITE VARCHAR2(660);
alter table scmdata.t_factory_report modify SUPPLIER_SITE VARCHAR2(660);
alter table scmdata.t_supplier_info modify SUPPLIER_SITE VARCHAR2(660);
