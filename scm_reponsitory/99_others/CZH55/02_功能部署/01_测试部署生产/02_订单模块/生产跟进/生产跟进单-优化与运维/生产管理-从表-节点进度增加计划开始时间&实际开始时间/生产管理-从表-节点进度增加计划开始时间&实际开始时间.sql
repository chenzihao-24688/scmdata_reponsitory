--alter table scmdata.t_production_node add(plan_start_time date);
--/
--alter table scmdata.t_production_node add(actual_start_time date);
--/
DECLARE
  v_sql        CLOB;
  v_update_sql CLOB;
BEGIN
  v_sql := q'[WITH group_dict AS
 (SELECT group_dict_type, group_dict_value, group_dict_name
    FROM scmdata.sys_group_dict),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM sys_company_user
   WHERE company_id = %default_company_id%)
SELECT t.product_node_id,
       t.company_id,
       t.product_gress_id,
       pp.progress_status progress_status_pr,
       t.product_node_code,
       t.node_num,
       t.node_name node_name_pr,
       t.time_ratio time_ratio_pr,
       t.target_completion_time target_completion_time_pr,
       t.plan_start_time plan_start_time_pr,
       t.plan_completion_time plan_completion_time_pr,
       t.actual_start_time actual_start_time_pr,
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
   AND b.user_id = t.update_id
 WHERE pp.company_id = %default_company_id%
   AND pp.product_gress_id = :product_gress_id
 ORDER BY t.node_num ASC]';

  v_update_sql := q'[DECLARE
  pno_rec scmdata.t_production_node%ROWTYPE;
BEGIN
  pno_rec.product_node_id        := :product_node_id;
  pno_rec.company_id             := :company_id;
  pno_rec.product_gress_id       := :product_gress_id;
  pno_rec.product_node_code      := :product_node_code;
  pno_rec.node_num               := :node_num;
  pno_rec.node_name              := :node_name_pr;
  pno_rec.plan_start_time        := :plan_start_time_pr;
  pno_rec.actual_start_time      := :actual_start_time_pr;
  pno_rec.plan_completion_time   := :plan_completion_time_pr;
  pno_rec.actual_completion_time := :actual_completion_time_pr;
  pno_rec.complete_amount        := :complete_amount_pr;
  pno_rec.progress_status        := :product_node_status_pr;
  pno_rec.progress_say           := :progress_say_pr;
  pno_rec.update_id              := :user_id;
  pno_rec.update_date            := SYSDATE;
                                       
 SELECT fc.logn_name
    INTO pno_rec.operator
    FROM scmdata.sys_company fc
   WHERE fc.company_id = %default_company_id%;
   
  scmdata.pkg_production_progress.update_production_node(pno_rec => pno_rec);

END;]';

  UPDATE bw3.sys_item_list t
     SET t.select_sql = v_sql, t.update_sql = v_update_sql
   WHERE t.item_id = 'a_product_111';

END;
