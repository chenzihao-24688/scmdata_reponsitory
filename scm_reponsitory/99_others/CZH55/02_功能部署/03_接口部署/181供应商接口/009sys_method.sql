prompt Importing table bwptest1.sys_method...
set feedback off
set define off
insert into bwptest1.sys_method (METHOD_ID, PORT_TYPE, DETAIL)
values ('method_itf_a_supp_140', 'http', '供应商接口导入');

insert into bwptest1.sys_method (METHOD_ID, PORT_TYPE, DETAIL)
values ('method_itf_a_supp_141', 'http', '供应商档案-合作范围接口导入');

prompt Done.
