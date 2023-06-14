alter table mdmdata.t_supplier_base_itf add COMPANY_TYPE    CHAR(2);
/
COMMENT ON column mdmdata.t_supplier_base_itf.COMPANY_TYPE is '公司类型(00：工贸一体 01：贸易型 02：工厂型)';     
/
