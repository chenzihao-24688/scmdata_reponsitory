DECLARE
v_select_sql clob;
BEGIN
  v_select_sql := q'[WITH group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM sys_company_user
   WHERE company_id = %default_company_id%)
SELECT t.product_node_id,
       t.company_id,
       t.product_gress_id,
       pp.PROGRESS_STATUS PROGRESS_STATUS_PR,
       t.product_node_code,
       t.node_num,
       t.node_name node_name_pr,
       t.time_ratio time_ratio_pr,
       t.target_completion_time target_completion_time_pr,
       t.plan_completion_time plan_completion_time_pr,
       t.actual_completion_time actual_completion_time_pr,
       t.complete_amount complete_amount_pr,
       t.progress_status product_node_status_pr,
       (SELECT a.group_dict_name
          FROM group_dict a
         WHERE a.group_dict_type = 'PROGRESS_NODE_TYPE'
           AND a.group_dict_value = t.progress_status) product_node_status,
       t.progress_say progress_say_pr,
       t.operator,
       b.company_user_name update_id_pr,
       t.update_date update_date_pr
  FROM scmdata.t_production_progress pp
 INNER JOIN scmdata.t_production_node t
    ON pp.product_gress_id = t.product_gress_id
 LEFT JOIN company_user b
    ON b.company_id = t.company_id
    and b.user_id = t.update_id  
 WHERE pp.company_id = %default_company_id%
   AND pp.product_gress_id = :product_gress_id
 ORDER BY t.node_num ASC]';
 
 update bw3.sys_item_list t set t.select_sql = v_select_sql where t.item_id = 'a_product_111';
END;
