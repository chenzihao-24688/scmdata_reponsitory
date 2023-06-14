alter table scmdata.t_supplier_info add ask_files varchar2(256);
alter table scmdata.t_coop_factory add PAUSE_TYPE  VARCHAR2(256);
comment on column T_COOP_FACTORY.PAUSE_TYPE
  is '禁用类型  SUP:供应商 , SUP_COOP:供应商_合作范围  ,OF:外协,  OF_COOP:工厂_合作范围';
alter table scmdata.t_coop_scope  modify sharing_type  null;
