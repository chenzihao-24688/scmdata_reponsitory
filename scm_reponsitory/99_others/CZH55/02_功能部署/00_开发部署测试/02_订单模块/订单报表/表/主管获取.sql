--跟单主管,qc主管
SELECT ia.company_user_name,
       ic.user_id,
       ic.company_user_name,
       ic.company_job_id
  FROM scmdata.sys_company_user ia
  LEFT JOIN sys_company_user_dept ib
    ON ia.user_id = ib.user_id
   AND ia.company_id = ib.company_id
  LEFT JOIN (SELECT ob.company_dept_id,
                    oa.company_id,
                    oa.user_id,
                    oa.company_user_name,
                    oc.company_job_id
               FROM sys_company_user oa
               LEFT JOIN sys_company_user_dept ob
                 ON oa.user_id = ob.user_id
                AND oa.company_id = ob.company_id
               LEFT JOIN scmdata.sys_company_job oc
                 ON oa.job_id = oc.job_id
                AND oa.company_id = oc.company_id
              WHERE oc.company_job_id = '1001005003005002'  --company_job_id
                AND oa.company_id = p_company_id) ic
    ON ib.company_dept_id = ic.company_dept_id
   AND ib.company_id = ic.company_id
 WHERE ia.user_id = p_user_id
   AND ia.company_id = p_company_id;
