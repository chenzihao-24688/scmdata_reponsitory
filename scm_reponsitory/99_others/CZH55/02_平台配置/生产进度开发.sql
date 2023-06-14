SELECT * FROM t_production_progress;
SELECT * FROM t_delivery_record;
SELECT * FROM t_production_node;
SELECT * FROM scmdata.t_ordered;
SELECT * FROM scmdata.t_orders;
SELECT * FROM scmdata.t_ordersitem;
SELECT * FROM scmdata.progress_status ;  

--清空单据
delete from scmdata.t_production_progress;
delete from scmdata.t_production_node;
delete from scmdata.t_abnormal;
delete from  scmdata.t_deduction;

update scmdata.t_ordered po set po.approve_status = null ;

update scmdata.t_production_progress t set t.progress_status = '00';

--订单回退已接单
BEGIN

  UPDATE scmdata.t_ordered po
     SET po.order_status = 'OS01', po.approve_status = NULL
   WHERE po.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
     AND po.order_code = 'FAKEINFO1577';

  UPDATE scmdata.t_production_progress t
     SET t.progress_status = '00'
   WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
     AND t.order_id = 'FAKEINFO1577';

  DELETE FROM scmdata.t_deduction t
   WHERE t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
     AND t.order_id = 'FAKEINFO1577';
END;



--熊猫交货记录接口涉及表（181）
SELECT * FROM nsfdata.ingood;
SELECT * FROM nsfdata.ingoods;
SELECT * FROM nsfdata.ingoodsitem;


--生产进度
SELECT ROWID, t.* FROM nbw.sys_item t WHERE t.item_id LIKE '%a_product_%';

SELECT ROWID, t.*
  FROM nbw.sys_tree_list t
 WHERE t.item_id LIKE '%a_product_%';
 
SELECT ROWID, t.*
  FROM nbw.sys_item_list t
 WHERE t.item_id LIKE '%a_product_%';

SELECT ROWID, t.*
  FROM nbw.sys_item_rela t
 WHERE t.item_id LIKE '%a_product_%';
   
--按钮
select rowid,t.* from nbw.sys_element t  ; 
select rowid,t.* from nbw.sys_action t  ;
select rowid,t.* from nbw.sys_item_element_rela t ; 

select rowid,t.* from nbw.sys_action t where t.element_id in ('action_a_product_118_2','action_a_product_118_3','action_a_product_118_4');

--参数

--checkaction
select rowid, t.* from nbw.sys_cond_list t where t.cond_id = 'cond_checkaction_a_product_110';

select rowid, t.* from nbw.sys_cond_rela t where t.cond_id = 'cond_checkaction_a_product_110';

--下单生产进度表
SELECT t.product_gress_id,
       t.company_id,
       t.product_gress_code product_gress_code_pr,
       t.progress_status progress_status_pr,
       t.order_id order_id_pr,
       t.goo_id goo_id_pr,
       cf.style_number style_number_pr,
       cf.style_name style_name_pr,
       t.supplier_code supplier_code_pr,
       sp.supplier_company_name supplier_company_name_pr, --供应商名称           
       t.factory_code factory_code_pr,
       sp1.supplier_company_name factory_company_name_pr --生产工厂名称
       od.delivery_date delivery_date_pr, --订单交期      
       t.forecast_delivery_date forecast_delivery_date_pr,
       t.forecast_delivery_date - od.delivery_date forecast_delay_day_pr, --预测延误天数=预测交期-订单交期     
       t.latest_planned_delivery_date latest_planned_delivery_date_pr,
       t.actual_delivery_date actual_delivery_date_pr,
       t.actual_delivery_date - od.delivery_date actual_delay_day_pr, --实际延误天数=实际交货日期 - 订单交期  
       t.order_amount order_amount_pr,
       t.delivery_amount delivery_amount_pr,
       t.order_amount - t.delivery_amount owe_amount_pr, --欠货数量=订单数量-交货数量
       t.approve_edition approve_edition_pr,
       t.fabric_check fabric_check_pr,
       t.qc_check qc_check_pr,
       t.qa_check qa_check_pr,
       t.exception_handle_status exception_handle_status_pr,
       t.handle_opinions handle_opinions_pr
  FROM t_production_progress t
 INNER JOIN scmdata.t_commodity_info cf
    ON t.goo_id = cf.goo_id
 INNER JOIN scmdata.t_supplier_info sp
    ON t.factory_code = sp.supplier_code
 INNER JOIN scmdata.t_supplier_info sp1
    ON t.supplier_code = sp1.supplier_code
 INNER JOIN scmdata.t_orders od
    ON t.order_id = od.order_id
 WHERE t.company_id = %default_company_id%;

--节点进度
SELECT t.product_node_id,
       t.company_id,
       t.product_gress_id,
       t.product_node_code,
       t.node_num,
       t.node_name              node_name_pr,
       t.time_ratio             time_ratio_pr,
       t.target_completion_time target_completion_time_pr,
       t.plan_completion_time   plan_completion_time_pr,
       t.actual_completion_time actual_completion_time_pr,
       t.complete_amount        complete_amount_pr,
       t.progress_status        progress_status_pr,
       t.progress_say           progress_say_pr,
       t.update_id              update_id_pr,
       t.update_date            update_date_pr,
       t.create_id              create_id_pr,
       t.create_time            create_time_pr,
       t.memo                   memo_pr
  FROM t_production_node t;

--订单明细
SELECT od.barcode, tcs.colorname, tcs.sizename, od.order_amount
  FROM scmdata.t_ordersitem od
 INNER JOIN scmdata.t_commodity_info tc
    ON od.goo_id = tc.rela_goo_id
 INNER JOIN scmdata.t_commodity_color_size tcs
    ON tc.commodity_info_id = tcs.commodity_info_id
 WHERE od.company_id = %default_company_id%
   AND od.order_id = :order_id
   AND od.barcode = tcs.barcode;

--异常处理记录
SELECT t.abnormal_id,
       t.company_id,
       t.abnormal_code,
       t.order_id,
       t.progress_status progress_status_pr,
       t.goo_id          goo_id_pr,       
       t.anomaly_class anomaly_class_pr,
       t.problem_class problem_class_pr,
       t.cause_class   cause_class_pr,
       t.is_deduction  is_deduction_pr
  FROM t_abnormal t;
