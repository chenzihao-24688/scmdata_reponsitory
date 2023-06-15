CREATE OR REPLACE FORCE VIEW SCMDATA.V_PRODUCT_PROGRESS_STATUS_SEQ AS
SELECT v.progress_status_pr   progress_status,
       v.progress_status_desc,
       v.status_sort          node_num
  FROM (SELECT a.group_dict_value progress_status_pr,
               a.group_dict_name  progress_status_desc,
               0                  status_sort
          FROM scmdata.sys_group_dict a
         WHERE a.group_dict_type = 'PROGRESS_TYPE'
           AND a.group_dict_value = '00'
           AND a.pause = 0
        UNION ALL
        SELECT pv.progress_value progress_status_pr,
               pv.progress_name  progress_status_desc,
               pv.status_sort
          FROM v_product_progress_status pv
         WHERE pv.company_id = 'b6cc680ad0f599cde0531164a8c0337f') v
 ORDER BY v.progress_status_pr ASC, v.status_sort ASC;

