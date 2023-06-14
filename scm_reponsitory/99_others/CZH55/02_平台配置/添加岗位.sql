select * from  scmdata.sys_company_job WHERE company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7';

INSERT INTO scmdata.sys_company_job
  (job_id,
   company_id,
   company_job_id,
   job_name,
   pause,
   create_id,
   create_time,
   update_id,
   update_time,
   job_type,
   parent_job_id)
  SELECT scmdata.f_get_uuid(),
         'a972dd1ffe3b3a10e0533c281cac8fd7',
         fj.company_job_id,
         fj.job_name||'(T)',
         fj.pause,
         fj.create_id,
         SYSDATE,
         fj.update_id,
         SYSDATE,
         fj.job_type,
         fj.parent_job_id
    FROM scmdata.sys_company_job fj
   WHERE fj.company_id = 'b54e6b5964d30544e0533c281cac9880';
   
   
   select * from scmdata.sys_company_dept_job_ra
