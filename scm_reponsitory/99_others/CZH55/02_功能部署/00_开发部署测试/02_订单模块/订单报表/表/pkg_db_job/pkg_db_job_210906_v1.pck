CREATE OR REPLACE PACKAGE pkg_db_job IS

  -- Author  : CZH
  -- Created : 2021/9/2 11:43:38
  -- Purpose : 统一管理数据库定时任务

  --订单数据表
  --每天更新订单交期数据表
  --更新频率：每天凌晨00:00更新1次数据
  --更新说明：每月5号00:00，上月数据更新最后1次，后续不再更新；（按订单交期月份判断是否为上月数据）
  PROCEDURE p_merge_order(p_company_id VARCHAR2,
                          p_begin_date DATE,
                          p_end_date   DATE);
END pkg_db_job;
/
CREATE OR REPLACE PACKAGE BODY pkg_db_job IS

  --订单数据表
  --每天更新订单交期数据表
  --更新频率：每天凌晨0000更新1次数据
  --更新说明：每月5号0000，上月数据更新最后1次，后续不再更新；（按订单交期月份判断是否为上月数据）
  PROCEDURE p_merge_order(p_company_id VARCHAR2,
                          p_begin_date DATE,
                          p_end_date   DATE) IS
  BEGIN
    MERGE INTO scmdata.pt_ordered pta
    USING (
      WITH supp_info AS
       (SELECT company_id, supplier_code, supplier_company_name
          FROM scmdata.t_supplier_info),
      group_dict AS
       (SELECT group_dict_type, group_dict_value, group_dict_name
          FROM scmdata.sys_group_dict)
      SELECT to_number(extract(YEAR FROM po.delivery_date)) YEAR,
             to_number(to_char(po.delivery_date, 'Q')) quarter,
             to_number(extract(MONTH FROM po.delivery_date)) MONTH,
             pr.supplier_code,
             sp_a.supplier_company_name,
             pr.factory_code,
             sp_b.supplier_company_name factory_company_name,
             pr.goo_id,
             tc.category,
             tc.product_cate,
             tc.samll_category,
             a.group_dict_name category_desc,
             b.group_dict_name coop_product_cate_desc,
             c.company_dict_name product_subclass_desc,
             tc.style_name,
             tc.style_number,
             '' flw_order,--跟单员
             '' flw_order_manager,--跟单主管
             '' qc,--qc
             '' qc_manager,--QC主管
             '' area_gp_leader,--区域组长
             '' is_twenty,--是否前20%
             '' delivery_status,--交货状态
             '' is_quality,--是否质量问题延期
             pr.actual_delay_day,
             CASE
               WHEN pr.actual_delay_day BETWEEN 1 AND 3 THEN
                '1~3天'
               WHEN pr.actual_delay_day BETWEEN 4 AND 6 THEN
                '4~6天'
               ELSE
                '7天以上'
             END delay_interval,
             pr.responsible_dept,
             pr.responsible_dept_sec,
             pr.delay_problem_class,
             pr.delay_cause_class,
             pr.delay_cause_detailed,
             pr.problem_desc,
             pln.order_price,
             tc.price,
             pr.order_amount,
             '' est_arrival_amount,--预计到货量
             pr.delivery_amount,
             '' satisfy_amount,--满足数量
             pln.order_amount * pln.order_price order_money,
             pr.delivery_amount * pln.order_price delivery_money,
             '' satisfy_money,--满足金额 * pln.order_price
             po.delivery_date,
             po.create_time,
             '' arrival_date,--到仓日期
             '' sort_date,--分拣日期
             po.isfirstordered isfirstordered,--是否首单
             pr.memo,
             po.finish_time_scm,
             po.company_id,
             po.order_id
        FROM scmdata.t_ordered po
       INNER JOIN scmdata.t_orders pln
          ON po.company_id = pln.company_id
         AND po.order_code = pln.order_id
       INNER JOIN scmdata.t_production_progress pr
          ON pln.company_id = pr.company_id
         AND pln.order_id = pr.order_id
         AND pln.goo_id = pr.goo_id
       INNER JOIN scmdata.t_commodity_info tc
          ON pr.company_id = tc.company_id
         AND pr.goo_id = tc.goo_id
        LEFT JOIN supp_info sp_a
          ON sp_a.company_id = pr.company_id
         AND sp_a.supplier_code = pr.supplier_code
        LEFT JOIN supp_info sp_b
          ON sp_b.company_id = pr.company_id
         AND sp_b.supplier_code = pr.factory_code
        LEFT JOIN group_dict a
          ON a.group_dict_type = 'PRODUCT_TYPE'
         AND a.group_dict_value = tc.category
        LEFT JOIN group_dict b
          ON b.group_dict_type = a.group_dict_value
         AND b.group_dict_value = tc.product_cate
        LEFT JOIN scmdata.sys_company_dict c
          ON c.company_dict_type = b.group_dict_value
         AND c.company_dict_value = tc.samll_category
         AND c.company_id = tc.company_id
       WHERE po.company_id = p_company_id) ptb ON (pta.company_id = ptb.company_id AND pta.order_id = ptb.order_id) WHEN MATCHED THEN
        UPDATE
           SET pta.year                   = ptb.year,
               pta.quarter                = ptb.quarter,
               pta.month                  = ptb.month,
               pta.supplier_code          = ptb.supplier_code,
               pta.supplier_company_name  = ptb.supplier_company_name,
               pta.factory_code           = ptb.factory_code,
               pta.factory_company_name   = ptb.factory_company_name,
               pta.goo_id                 = ptb.goo_id,
               pta.category               = ptb.category,
               pta.category_name          = ptb.category_desc,
               pta.product_cate           = ptb.product_cate,
               pta.coop_product_cate_name = ptb.coop_product_cate_desc,
               pta.samll_category         = ptb.samll_category,
               pta.product_subclass_name  = ptb.product_subclass_desc,
               pta.style_name             = ptb.style_name,
               pta.style_number           = ptb.style_number,
               pta.flw_order              = '', --ptb.flw_order,
               pta.flw_order_manager      = '', --ptb.flw_order_manager,
               pta.qc                     = '', --ptb.qc,
               pta.qc_manager             = '', --ptb.qc_manager,
               pta.area_gp_leader         = '', --ptb.area_gp_leader,
               pta.is_twenty              = '', --ptb.is_twenty,
               pta.delivery_status        = '', --ptb.delivery_status,
               pta.is_quality             = '', --ptb.is_quality,              
               pta.actual_delay_days      = ptb.actual_delay_day,
               pta.delay_section          = ptb.delay_interval,
               pta.responsible_dept       = ptb.responsible_dept,
               pta.responsible_dept_sec   = ptb.responsible_dept_sec,
               pta.delay_problem_class    = ptb.delay_problem_class,
               pta.delay_cause_class      = ptb.delay_cause_class,
               pta.delay_cause_detailed   = ptb.delay_cause_detailed,
               pta.problem_desc           = ptb.problem_desc,
               pta.purchase_price         = ptb.order_price,
               pta.fixed_price            = ptb.price,
               pta.order_amount           = ptb.order_amount,
               pta.est_arrival_amount     = '', --ptb.est_arrival_amount,
               pta.delivery_amount        = ptb.delivery_amount,
               pta.satisfy_amount         = '', --ptb.satisfy_amount,
               pta.order_money            = ptb.order_money,
               pta.delivery_money         = ptb.delivery_money,
               pta.satisfy_money          = '', --ptb.satisfy_money,
               pta.delivery_date          = ptb.delivery_date,
               pta.order_create_date      = ptb.create_time,
               pta.arrival_date           = '', --ptb.arrival_date,
               pta.sort_date              = '', --ptb.sort_date,
               pta.is_first_order         = ptb.isfirstordered,
               pta.remarks                = ptb.memo,
               pta.order_finish_time      = ptb.finish_time_scm,
               pta.update_id              = 'ADMIN',
               pta.update_time            = SYSDATE
      WHEN NOT MATCHED THEN
        INSERT (pta.pt_ordered_id,pta.company_id,pta.order_id,pta.year,pta.quarter,pta.month,pta.supplier_code,pta.supplier_company_name,pta.factory_code,
       pta.factory_company_name,pta.goo_id,pta.category,pta.category_name,pta.product_cate,pta.coop_product_cate_name,pta.samll_category,pta.product_subclass_name,
       pta.style_name,pta.style_number,pta.flw_order,pta.flw_order_manager,pta.qc,pta.qc_manager,pta.area_gp_leader,pta.is_twenty,pta.delivery_status,       
       pta.is_quality,pta.actual_delay_days,pta.delay_section,pta.responsible_dept,pta.responsible_dept_sec,pta.delay_problem_class,      
       pta.delay_cause_class,pta.delay_cause_detailed,pta.problem_desc,pta.purchase_price,pta.fixed_price,pta.order_amount,pta.est_arrival_amount,pta.delivery_amount,      
       pta.satisfy_amount,pta.order_money,pta.delivery_money,pta.satisfy_money,pta.delivery_date,pta.order_create_date,pta.arrival_date,pta.sort_date,      
       pta.is_first_order,pta.remarks,pta.order_finish_time,pta.create_id,pta.create_time,pta.update_id,pta.update_time) values  
                                              
      (scmdata.f_get_uuid(), ptb.company_id, ptb.order_id, ptb.year,ptb.quarter, ptb.month, ptb.supplier_code,ptb.supplier_company_name, ptb.factory_code,
       ptb.factory_company_name,ptb.goo_id, ptb.category,ptb.category_desc,ptb.product_cate,ptb.coop_product_cate_desc,ptb.samll_category,ptb.product_subclass_desc,
       ptb.style_name, ptb.style_number,''/* ptb.flw_order*/,''/*ptb.flw_order_manager*/, ''/*ptb.qc*/, ''/*ptb.qc_manager*/,''/*ptb.area_gp_leader*/,''/* ptb.is_twenty*/,
       ''/* ptb.delivery_status*/,''/*ptb.is_quality*/,ptb.actual_delay_day, ptb.delay_interval,ptb.responsible_dept, ptb.responsible_dept_sec,ptb.delay_problem_class,
       ptb.delay_cause_class,ptb.delay_cause_detailed, ptb.problem_desc,ptb.order_price, ptb.price, ptb.order_amount,''/*ptb.est_arrival_amount*/, ptb.delivery_amount,
       ''/*ptb.satisfy_amount*/, ptb.order_money, ptb.delivery_money,''/*ptb.satisfy_money*/, ptb.delivery_date, ptb.create_time,''/*ptb.arrival_date*/, ''/*ptb.sort_date*/, 
       ptb.isfirstordered,ptb.memo, ptb.finish_time_scm, 'ADMIN',SYSDATE, 'ADMIN', SYSDATE);  
  END p_merge_order;
END pkg_db_job;
/
