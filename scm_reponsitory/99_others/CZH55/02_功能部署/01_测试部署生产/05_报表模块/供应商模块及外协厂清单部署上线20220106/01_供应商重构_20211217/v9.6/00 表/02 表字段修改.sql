alter table scmdata.t_supplier_info add ask_files varchar2(256);
alter table scmdata.t_coop_factory add PAUSE_TYPE  VARCHAR2(256);
comment on column T_COOP_FACTORY.PAUSE_TYPE
  is '��������  SUP:��Ӧ�� , SUP_COOP:��Ӧ��_������Χ  ,OF:��Э,  OF_COOP:����_������Χ';
alter table scmdata.t_coop_scope  modify sharing_type  null;
