--b54e6b5964d30544e0533c281cac9880
--a972dd1ffe3b3a10e0533c281cac8fd7
select * from scmdata.sys_company_job;
select * from sys_company_dept_job_ra;
update scmdata.sys_company_job t set t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7' ;

update scmdata.sys_company_dept_job_ra t set t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7' ;

select rowid,t.* from nbw.sys_look_up t where t.element_id = 'look_c_2055' ;

 
