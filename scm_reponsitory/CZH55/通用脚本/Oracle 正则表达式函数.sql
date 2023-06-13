--Oracle  正则表达式函数
--1. regexp_like
select * from scmdata.sys_company_user_temp t where regexp_like(t.group_role_name);
