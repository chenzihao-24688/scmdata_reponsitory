alter table scmdata.t_ask_record modify ASK_SAY VARCHAR2(2000) null;
alter table scmdata.T_FACTORY_ASK modify FACTORY_PROVINCE VARCHAR2(48) null;
alter table scmdata.T_FACTORY_ASK modify FACTORY_CITY VARCHAR2(48) null;
alter table scmdata.T_FACTORY_ASK modify FACTORY_COUNTY VARCHAR2(48) null;

alter table scmdata.T_FACTORY_REPORT modify CHECK_PROVINCE VARCHAR2(48) null;
alter table scmdata.T_FACTORY_REPORT modify CHECK_CITY VARCHAR2(48) null;
alter table scmdata.T_FACTORY_REPORT modify CHECK_COUNTY VARCHAR2(48) null;

alter table scmdata.t_supplier_info_oper_log modify oper_type VARCHAR2(256) ;

-- Create sequence 
create sequence SYS_APP_ERROR_MSG_S
minvalue 0
maxvalue 99
start with 1
increment by 1
cache 20
cycle;
