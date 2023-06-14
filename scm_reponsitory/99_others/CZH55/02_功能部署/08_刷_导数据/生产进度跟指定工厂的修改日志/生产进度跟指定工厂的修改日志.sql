--生产进度的修改日志
select a.product_gress_code, gd.group_dict_name, b.operator, b.update_date
  from scmdata.t_production_progress a
 inner join (select distinct t.product_gress_id,
                             t.company_id,
                             t.operator,
                             t.update_date
               from scmdata.t_production_node t
              where t.operator is not null
                and t.operator <> '福建省三福百货有限公司') b
    on b.product_gress_id = a.product_gress_id
   and b.company_id = a.company_id
 inner join scmdata.t_commodity_info c
    on c.goo_id = a.goo_id
   and c.company_id = a.company_id
 inner join scmdata.sys_group_dict gd
    on gd.group_dict_type = 'PRODUCT_TYPE'
   AND gd.group_dict_value = c.category;

--指定工厂操作日志

select a.order_code,
       gd.group_dict_name,
       e.company_user_name,
       b.operate_time,
       a.is_product_order
  from scmdata.t_ordered a
 inner join (SELECT t.operate_person,
                    t.operate_time,
                    t.order_id,
                    t.company_id
               FROM scmdata.t_order_log t
               LEFT JOIN scmdata.t_supplier_info sp_a
                 ON t.company_id = sp_a.company_id
                AND t.old_designate_factory = sp_a.supplier_code
               LEFT JOIN scmdata.t_supplier_info sp_b
                 ON t.company_id = sp_b.company_id
                AND t.new_designate_factory = sp_b.supplier_code
               LEFT JOIN scmdata.sys_user su
                 ON t.operate_person = su.user_id
              where t.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
                and t.operator = 'SUPP'
              ORDER BY t.operate_time DESC) b
    on b.order_id = a.order_id
   and b.company_id = a.company_id
 inner join scmdata.t_orders c
    on c.order_id = a.order_code
   and c.company_id = a.company_id
 inner join scmdata.t_commodity_info d
    on d.goo_id = c.goo_id
   and d.company_id = c.company_id
 inner join scmdata.sys_group_dict gd
    on gd.group_dict_type = 'PRODUCT_TYPE'
   AND gd.group_dict_value = d.category
  left join scmdata.sys_company_user e
    on e.user_id = b.operate_person;
--and e.company_id = b.company_id

select a.product_gress_code,
       gd.group_dict_name,
       p.new_operate_remarks product_gress_remarks,
       c.logn_name           operator,
       cu.company_user_name  OPER_USER_NAME,
       p.operate_time
  from scmdata.t_production_progress a
 inner join scmdata.t_commodity_info d
    on d.goo_id = a.goo_id
   and d.company_id = a.company_id
 inner join scmdata.sys_group_dict gd
    on gd.group_dict_type = 'PRODUCT_TYPE'
   AND gd.group_dict_value = d.category
 inner join scmdata.t_production_progress_log p
    on p.product_gress_id = a.product_gress_id
 inner join scmdata.sys_company c
    on c.company_id = p.operate_company_id
 inner join scmdata.sys_company_user cu
    on cu.company_id = p.operate_company_id
   and cu.user_id = p.operate_user_id
 where p.operate_company_id <> 'b6cc680ad0f599cde0531164a8c0337f'
 order by p.operate_time desc;
