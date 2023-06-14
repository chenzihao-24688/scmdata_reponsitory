SELECT a.group_dict_value progress_status_pr,
       a.group_dict_name  progress_status_desc
  FROM scmdata.sys_group_dict a
 WHERE a.group_dict_type = 'PROGRESS_TYPE'
   AND a.group_dict_value IN ('00', '01')
UNION ALL
SELECT pv.progress_value progress_status_pr,
       pv.progress_name  progress_status_desc
  FROM scmdata.v_product_progress_status pv
 WHERE pv.company_id = %default_company_id%
 AND pv.progress_value = '020001'
