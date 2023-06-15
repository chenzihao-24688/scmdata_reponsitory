CREATE OR REPLACE PACKAGE MRP.pkg_material_preparation_stage_3 IS
/*---------------------------------------------------------
 描述：   备料三期业务包
          领料管理、面料采购页面item_list的select_sql语句
 创建人： lsl167
 时间：   20230615
-----------------------------------------------------------*/
  --查询 item_id:a_prematerial_301页面 select_sql
  FUNCTION f_a_prematerial_301 RETURN CLOB;

  --查询 item_id:a_prematerial_302页面 select_sql
  FUNCTION f_a_prematerial_302 RETURN CLOB ;

  --查询 item_id:a_prematerial_303页面 select_sql
  FUNCTION f_a_prematerial_303 RETURN CLOB ;

  --查询 item_id:a_prematerial_304页面 select_sql
  FUNCTION f_a_prematerial_304 RETURN CLOB ;

  --查询 item_id:a_prematerial_305页面 select_sql
  FUNCTION f_a_prematerial_305 RETURN CLOB ;

  --查询 item_id:a_prematerial_306页面 select_sql
  FUNCTION f_a_prematerial_306 RETURN CLOB ;

  --查询 item_id:a_prematerial_307页面 select_sql
  FUNCTION f_a_prematerial_307 RETURN CLOB ;

  --查询 item_id:a_prematerial_411页面 select_sql
  FUNCTION f_a_prematerial_411 RETURN CLOB ;

  --查询 item_id:a_prematerial_412页面 select_sql
  FUNCTION f_a_prematerial_412 RETURN CLOB ;

  --查询 item_id:a_prematerial_413页面 select_sql
  FUNCTION f_a_prematerial_413 RETURN CLOB ;

  --查询 item_id:a_prematerial_414页面 select_sql
  FUNCTION f_a_prematerial_414 RETURN CLOB ;

  --查询 item_id:a_prematerial_415页面 select_sql
  FUNCTION f_a_prematerial_415 RETURN CLOB ;

  --查询 item_id:a_prematerial_416页面 select_sql
  FUNCTION f_a_prematerial_416 RETURN CLOB ;

  --查询 item_id:a_prematerial_417页面 select_sql
  FUNCTION f_a_prematerial_417 RETURN CLOB ;

  --查询 item_id:a_prematerial_418页面 select_sql
  FUNCTION f_a_prematerial_418 RETURN CLOB ;

  --查询 item_id:a_prematerial_419页面 select_sql
  FUNCTION f_a_prematerial_419 RETURN CLOB ;

  --查询 item_id:a_prematerial_420页面 select_sql
  FUNCTION f_a_prematerial_420 RETURN CLOB;

  --查询 item_id:a_prematerial_421页面 select_sql
  FUNCTION f_a_prematerial_421(V_GROUP_KEY in varchar2)  RETURN CLOB;

  --查询 item_id:a_prematerial_422页面 select_sql
  FUNCTION f_a_prematerial_422(V_FABRIC_ID in varchar2) RETURN CLOB ;

  --查询 item_id:a_prematerial_423页面 select_sql
  FUNCTION f_a_prematerial_423 RETURN CLOB;

END pkg_material_preparation_stage_3;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_material_preparation_stage_3 IS

/*---------------------------------------------------------
 描述：   备料三期业务包
          领料管理、面料采购页面item_list的select_sql语句
 创建人： lsl167
 时间：   20230615
-----------------------------------------------------------*/

  --领料任务——待完成页面查询 item_id:a_prematerial_301页面 select_sql
  FUNCTION f_a_prematerial_301 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.company_id,t.pro_supplier_code,tcc.commodity_info_id,
       t.relate_skc SKC,
       tcc.rela_goo_id,
       tcc.colorname,
       tci.style_number,
       --cp.blog_file_id,
       --cp.blog_file_name,
       cp.picture,
       t.purchase_skc_order_num skc_order_num,
       t.material_sku,
       t.supplier_material_name,
       (case
         when t.whether_inner_mater = '0' then
          mts.supplier_name 
         when t.whether_inner_mater = '1' then
          mds.supplier_abbreviation
       end) material_supplier_name,
       t.suggest_pick_num,
       t.unit purchase_unit,
       nvl(scc.brand_stock,0) brand_stock, --品牌仓库存数 
       nvl(scc.supplier_stock,0) supplier_stock, --供应商仓库存数  
       (nvl(scc.brand_stock,0) + nvl(scc.supplier_stock,0)) stock, --现有总库存
       t.supplier_color material_supplier_color,
       t.supplier_shades,
       t.mater_supplier_code material_supplier_code,
       a.group_dict_name category,
       b.group_dict_name product_cate,
       c.company_dict_name samll_category,
       e.group_dict_name season,
       (case
         when t.whether_inner_mater = '0' then
          '否'
         when t.whether_inner_mater = '1' then
          '是'
       end) whether_inner_mater,
       t.last_update_time 
  from (select distinct p.pick_status,
                        sum(p.suggest_pick_num) over(partition by p.relate_skc,p.mater_supplier_code, p.material_sku, p.unit, p.pro_supplier_code) suggest_pick_num,
                        sum(p.purchase_skc_order_num) over(partition by p.relate_skc,p.mater_supplier_code, p.material_sku, p.unit, p.pro_supplier_code) purchase_skc_order_num,
                        max(p.create_time) over (partition by p.relate_skc, p.mater_supplier_code, p.material_sku, p.unit, p.pro_supplier_code) last_update_time,
                        p.company_id,
                        --p.material_detail_id,
                        p.mater_supplier_code,
                        p.unit,
                        p.whether_inner_mater,
                        p.pro_supplier_code,
                        p.material_sku,
                        p.relate_skc,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_material_name
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_material_name
                        end) supplier_material_name,
                       -- bc.purchase_unit,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_color
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_color
                        end) supplier_color,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_shades
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_shades
                        end) supplier_shades
          from mrp.pick_list p
         inner join mrp.bulk_cargo_bom_material_detail bc
            on bc.material_detail_id = p.material_detail_id
           and bc.company_id = p.company_id
          left join mrp.mrp_internal_supplier_material tmi
            on tmi.material_sku = p.material_sku
           and tmi.supplier_code = p.mater_supplier_code
          left join mrp.mrp_outside_supplier_material tmo
            on tmo.material_sku = p.material_sku
           and tmo.supplier_code = p.mater_supplier_code
           and tmo.create_finished_supplier_code = p.pro_supplier_code
         where p.pick_status = '0') t
 inner join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.relate_skc
 inner join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
   and cp.seqno = 1
  left join mrp.mrp_determine_supplier_archives mds
    on mds.supplier_code = t.mater_supplier_code
  left join mrp.mrp_temporary_supplier_archives mts
    on mts.supplier_code = t.mater_supplier_code
  left join mrp.supplier_color_cloth_stock scc
    on scc.pro_supplier_code = t.pro_supplier_code
   and scc.mater_supplier_code = t.mater_supplier_code
   and scc.unit = t.unit
   and scc.material_sku = t.material_sku
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
 where t.pro_supplier_code =
       (select t.supplier_info_id
          from scmdata.t_supplier_info t
         where t.supplier_company_id = %default_company_id%
           and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
order by t.last_update_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_301;

  --领料任务——已完成页面查询 item_id:a_prematerial_302页面 select_sql
  FUNCTION f_a_prematerial_302 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.company_id,t.pro_supplier_code,tcc.commodity_info_id,
       tcc.rela_goo_id,
       t.relate_skc SKC,
       tcc.colorname,
       tci.style_number,
       --cp.blog_file_name,
       cp.picture,
       --cp.blog_file_id,
       t.purchase_skc_order_num skc_order_num,
       t.material_sku,
       t.supplier_material_name,
       (case
         when t.whether_inner_mater = '0' then
           mts.supplier_name
         when t.whether_inner_mater = '1' then
          mds.supplier_abbreviation
       end) material_supplier_name,
       t.unit purchase_unit,
       t.suggest_pick_num,
       t.pick_num,
       nvl(scc.brand_stock,0) brand_stock, --品牌仓库存数 
       nvl(scc.supplier_stock,0) supplier_stock, --供应商仓库存数  
       (nvl(scc.brand_stock,0) + nvl(scc.supplier_stock,0)) stock, --现有总库存
       t.supplier_color material_supplier_color,
       t.supplier_shades,
       t.mater_supplier_code material_supplier_code,
       a.group_dict_name category,
       b.group_dict_name product_cate,
       c.company_dict_name samll_category,
       e.group_dict_name season,
       (case
         when t.whether_inner_mater = '0' then
          '否'
         when t.whether_inner_mater = '1' then
          '是'
       end) whether_inner_mater,
       t.last_update_time 
  from (select distinct p.pick_status,
                        sum(p.suggest_pick_num) over(partition by p.relate_skc,p.mater_supplier_code, p.material_sku, p.unit, p.pro_supplier_code) suggest_pick_num,
                        sum(p.purchase_skc_order_num) over(partition by p.relate_skc, p.mater_supplier_code,p.material_sku, p.unit, p.pro_supplier_code) purchase_skc_order_num,
                        sum(p.pick_num) over(partition by p.relate_skc, p.mater_supplier_code,p.material_sku, p.unit, p.pro_supplier_code) pick_num,
                        max(p.pick_time ) over (partition by p.relate_skc, p.mater_supplier_code, p.material_sku, p.unit, p.pro_supplier_code) last_update_time,
                        p.company_id,
                        --p.material_detail_id,
                        p.mater_supplier_code,
                        p.unit,
                        p.whether_inner_mater,
                        p.pro_supplier_code,
                        p.material_sku,
                        p.relate_skc,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_material_name
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_material_name
                        end) supplier_material_name,
                       --- bc.purchase_unit,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_color
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_color
                        end) supplier_color,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_shades
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_shades
                        end) supplier_shades
          from mrp.pick_list p
         inner join mrp.bulk_cargo_bom_material_detail bc
            on bc.material_detail_id = p.material_detail_id
           and bc.company_id = p.company_id
          left join mrp.mrp_internal_supplier_material tmi
            on tmi.material_sku = p.material_sku
           and tmi.supplier_code = p.mater_supplier_code
          left join mrp.mrp_outside_supplier_material tmo
            on tmo.material_sku = p.material_sku
           and tmo.supplier_code = p.mater_supplier_code
           and tmo.create_finished_supplier_code = p.pro_supplier_code
         where p.pick_status = '1') t
 inner join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.relate_skc
 inner join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
   and cp.seqno = 1
  left join mrp.mrp_determine_supplier_archives mds
    on mds.supplier_code = t.mater_supplier_code
  left join mrp.mrp_temporary_supplier_archives mts
    on mts.supplier_code = t.mater_supplier_code
  left join mrp.supplier_color_cloth_stock scc
    on scc.pro_supplier_code = t.pro_supplier_code
   and scc.mater_supplier_code = t.mater_supplier_code
   and scc.unit = t.unit
   and scc.material_sku = t.material_sku
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
 where t.pro_supplier_code =
       (select t.supplier_info_id
          from scmdata.t_supplier_info t
         where t.supplier_company_id = %default_company_id%
           and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
order by t.last_update_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_302;

  --领料任务——已取消页面查询 item_id:a_prematerial_303页面 select_sql
  FUNCTION f_a_prematerial_303 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.company_id,t.pro_supplier_code,tcc.commodity_info_id,
       tcc.rela_goo_id,
       t.relate_skc SKC,
       tcc.colorname,
       tci.style_number,
      -- cp.blog_file_name,
       cp.picture,
      -- cp.blog_file_id,
       t.purchase_skc_order_num skc_order_num,
       t.material_sku,
       t.supplier_material_name,
       (case
         when t.whether_inner_mater = '0' then
          mts.supplier_name
         when t.whether_inner_mater = '1' then
          mds.supplier_abbreviation
       end) material_supplier_name,
       t.unit purchase_unit,
       t.suggest_pick_num,
       t.pick_num,
       nvl(scc.brand_stock,0) brand_stock, --品牌仓库存数 
       nvl(scc.supplier_stock,0) supplier_stock, --供应商仓库存数  
       (nvl(scc.brand_stock,0) + nvl(scc.supplier_stock,0)) stock, --现有总库存
       t.supplier_color material_supplier_color,
       t.supplier_shades,
       t.mater_supplier_code material_supplier_code,
       a.group_dict_name category,
       b.group_dict_name product_cate,
       c.company_dict_name samll_category,
       e.group_dict_name season,
       (case
         when t.whether_inner_mater = '0' then
          '否'
         when t.whether_inner_mater = '1' then
          '是'
       end) whether_inner_mater,
       t.last_update_time 
  from (select distinct p.pick_status,
                        sum(p.suggest_pick_num) over(partition by p.relate_skc, p.mater_supplier_code,p.material_sku, p.unit, p.pro_supplier_code) suggest_pick_num,
                        sum(p.purchase_skc_order_num) over(partition by p.relate_skc,p.mater_supplier_code, p.material_sku, p.unit, p.pro_supplier_code) purchase_skc_order_num,
                        sum(p.pick_num) over(partition by p.relate_skc, p.material_sku,p.mater_supplier_code, p.unit, p.pro_supplier_code) pick_num,
                        p.company_id,
                        max(p.cancel_time) over (partition by p.relate_skc, p.mater_supplier_code, p.material_sku, p.unit, p.pro_supplier_code) last_update_time,
                        --p.material_detail_id,
                        p.mater_supplier_code,
                        p.unit,
                        p.whether_inner_mater,
                        p.pro_supplier_code,
                        p.material_sku,
                        p.relate_skc,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_material_name
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_material_name
                        end) supplier_material_name,
                        --bc.purchase_unit,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_color
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_color
                        end) supplier_color,
                        (case
                          when p.whether_inner_mater = 1 then
                           tmi.supplier_shades
                          when p.whether_inner_mater = 0 then
                           tmo.supplier_shades
                        end) supplier_shades
          from mrp.pick_list p
         inner join mrp.bulk_cargo_bom_material_detail bc
            on bc.material_detail_id = p.material_detail_id
           and bc.company_id = p.company_id
          left join mrp.mrp_internal_supplier_material tmi
            on tmi.material_sku = p.material_sku
           and tmi.supplier_code = p.mater_supplier_code
          left join mrp.mrp_outside_supplier_material tmo
            on tmo.material_sku = p.material_sku
           and tmo.supplier_code = p.mater_supplier_code
           and tmo.create_finished_supplier_code = p.pro_supplier_code
         where p.pick_status = '2') t
 inner join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.relate_skc
 inner join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
  --- and cp.seqno = 1
  left join mrp.mrp_determine_supplier_archives mds
    on mds.supplier_code = t.mater_supplier_code
  left join mrp.mrp_temporary_supplier_archives mts
    on mts.supplier_code = t.mater_supplier_code
  left join mrp.supplier_color_cloth_stock scc
    on scc.pro_supplier_code = t.pro_supplier_code
   and scc.mater_supplier_code = t.mater_supplier_code
   and scc.unit = t.unit
   and scc.material_sku = t.material_sku
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
 where t.pro_supplier_code =
       (select t.supplier_info_id
          from scmdata.t_supplier_info t
         where t.supplier_company_id = %default_company_id%
           and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
order by t.last_update_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_303;

  --领料任务——全部页面查询 item_id:a_prematerial_304页面 select_sql
  FUNCTION f_a_prematerial_304 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.pick_lict_code, --领料单,
tcc.commodity_info_id,
       t.relate_product_order_num order_code, --订单编号
       (case
         when t.pick_status = '0' then
          '待完成'
         when t.pick_status = '1' then
          '已完成'
         when t.pick_status = '2' then
          '已取消'
       end) pick_status , --领料状态
       t.relate_skc SKC, --货色skc
       t.company_id,
       tcc.rela_goo_id, --货号
       tcc.colorname, --颜色
       tci.style_number, --款号
       cp.picture, --图片
       t.purchase_skc_order_num skc_order_num, ---订单量
       t.material_sku, --物料sku
       bc.supplier_material_name, --供应商物料名称
       (case
         when t.whether_inner_mater = '0' then
          mts.supplier_name 
         when t.whether_inner_mater = '1' then
          mds.supplier_abbreviation
       end) material_supplier_name, --物料商名称
       tp.progress_status PROGRESS_STATUS_PR, --生产进度状态
       MAX(od.delivery_date) over(PARTITION BY od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       (bc.consumption || bc.examine_unit)  consumption, --单价用量
       bc.purchase_unit, --单位
       t.suggest_pick_num, --建议领料量
       t.pick_num, --已领料量
       nvl(scc.brand_stock,0) brand_stock, --品牌仓库存数 
       nvl(scc.supplier_stock,0) supplier_stock, --供应商仓库存数  
       (nvl(scc.brand_stock,0) + nvl(scc.supplier_stock,0)) stock, --现有总库存
       bc.practical_door_with, --门幅
       bc.gram_weight, --克重
       bc.material_specifications, --规格
       bc.supplier_color material_supplier_color, --供应商物料颜色
       bc.supplier_shades, --供应商色号
       t.mater_supplier_code material_supplier_code, --物料商编号
       a.group_dict_name category,
       b.group_dict_name product_cate,
       c.company_dict_name samll_category,
       e.group_dict_name season,
       (case
         when t.whether_inner_mater = '0' then
          '否'
         when t.whether_inner_mater = '1' then
          '是'
       end) whether_inner_mater, --是否三福物料
       g3.company_user_name create_name,
       t.create_time,    
       t.cancel_reason ,
       g2.company_user_name cancel_name,
       t.cancel_time,
       g1.company_user_name pick_name,
       t.pick_time
  from mrp.pick_list t
 inner join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.relate_skc
 inner join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
   and cp.seqno = 1
  left join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
  left join mrp.mrp_determine_supplier_archives mds
    on mds.supplier_code = t.mater_supplier_code
  left join mrp.mrp_temporary_supplier_archives mts
    on mts.supplier_code = t.mater_supplier_code
  left join mrp.supplier_color_cloth_stock scc
    on scc.pro_supplier_code = t.pro_supplier_code
   and scc.mater_supplier_code = t.mater_supplier_code
   and scc.unit = t.unit
   and scc.material_sku = t.material_sku
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
 INNER join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.relate_product_order_num
 INNER JOIN scmdata.t_orders od
    ON od.company_id = t.company_id
   AND od.order_id = t.relate_product_order_num
   left join scmdata.sys_company_user g1
     on g1.company_id = t.company_id
    and g1.user_id = t.pick_id
   left join scmdata.sys_company_user g2
     on g2.company_id = t.company_id
    and g2.user_id = t.cancel_id
   left join scmdata.sys_company_user g3
     on g3.company_id = t.company_id
    and g3.user_id = t.create_id
 where t.pro_supplier_code =
       (select t.supplier_info_id
          from scmdata.t_supplier_info t
         where t.supplier_company_id = %default_company_id%
           and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
order by t.create_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_304;

  --领料任务——待完成页面从表查询 item_id:a_prematerial_305页面 select_sql
  FUNCTION f_a_prematerial_305 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.pick_lict_code, --领料单
       t.relate_product_order_num product_order_num, --订单编号
       (case
         when t.pick_status = '0' then
          '待完成'
         when t.pick_status = '1' then
          '已完成'
         when t.pick_status = '2' then
          '已取消'
       end) pick_status, --领料状态
       tp.progress_status progress_status_pr, --生产进度状态
       max(od.delivery_date) over(partition by od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       t.purchase_skc_order_num skc_order_num, ---订单量
      (bc.consumption  || bc.examine_unit)  consumption, --单价用量
      --- bc.consumption, --单价用量
       t.suggest_pick_num, --建议领料量
       bc.purchase_unit, --单位
       t.pick_num, --已领料量
       bc.supplier_material_name  , bc.supplier_color ,bc.supplier_shades ,
       bc.practical_door_with, --门幅
       bc.gram_weight, --克重
       bc.material_specifications, --规格
       g3.company_user_name create_name,
       t.create_time
  from mrp.pick_list t
 inner join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
 inner join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.relate_product_order_num
 inner join scmdata.t_orders od
    on od.company_id = t.company_id
   and od.order_id = t.relate_product_order_num
  left join scmdata.sys_company_user g3
    on g3.company_id = t.company_id
   and g3.user_id = t.create_id
 where t.relate_skc = :skc 
       and t.material_sku = :material_sku
       and t.pro_supplier_code = :pro_supplier_code
       and t.mater_supplier_code = :material_supplier_code
       and t.unit = :purchase_unit
  and t.pick_status = '0'
 order by t.create_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_305;

  --领料任务——已完成页面从表查询 item_id:a_prematerial_306页面 select_sql
  FUNCTION f_a_prematerial_306 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.pick_lict_code, --领料单
       t.relate_product_order_num product_order_num, --订单编号
       (case
         when t.pick_status = '0' then
          '待完成'
         when t.pick_status = '1' then
          '已完成'
         when t.pick_status = '2' then
          '已取消'
       end) pick_status, --领料状态
       tp.progress_status progress_status_pr, --生产进度状态
       max(od.delivery_date) over(partition by od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       t.purchase_skc_order_num skc_order_num, ---订单量
      -- bc.consumption, --单价用量
       (bc.consumption  || bc.examine_unit)  consumption, --单价用量
       bc.purchase_unit, --单位
       t.suggest_pick_num, --建议领料量
       t.pick_num, --已领料量
       bc.supplier_material_name  , bc.supplier_color ,bc.supplier_shades ,
       bc.practical_door_with, --门幅
       bc.gram_weight, --克重
       bc.material_specifications, --规格
       g3.company_user_name create_name,
       t.create_time,    
       g1.company_user_name pick_name,
       t.pick_time
  from mrp.pick_list t
  inner join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
  inner join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.relate_product_order_num
 inner join scmdata.t_orders od
    on od.company_id = t.company_id
   and od.order_id = t.relate_product_order_num
   left join scmdata.sys_company_user g1
     on g1.company_id = t.company_id
    and g1.user_id = t.pick_id
   left join scmdata.sys_company_user g3
     on g3.company_id = t.company_id
    and g3.user_id = t.create_id
 where t.relate_skc = :skc 
       and t.material_sku = :material_sku
       and t.pro_supplier_code = :pro_supplier_code
       and t.mater_supplier_code = :material_supplier_code
       and t.unit = :purchase_unit
  and t.pick_status = '1'
 order by t.pick_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_306;

  --领料任务——已取消页面从表查询 item_id:a_prematerial_307页面 select_sql
  FUNCTION f_a_prematerial_307 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.pick_lict_code, --领料单
       t.relate_product_order_num product_order_num, --订单编号
       (case
         when t.pick_status = '0' then
          '待完成'
         when t.pick_status = '1' then
          '已完成'
         when t.pick_status = '2' then
          '已取消'
       end) pick_status, --领料状态
       tp.progress_status progress_status_pr, --生产进度状态
       max(od.delivery_date) over(partition by od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       t.purchase_skc_order_num skc_order_num, ---订单量
      -- bc.consumption, --单价用量
      (bc.consumption  || bc.examine_unit)  consumption, --单价用量
       bc.purchase_unit, --单位
       t.suggest_pick_num, --建议领料量
       bc.supplier_material_name  , bc.supplier_color ,bc.supplier_shades ,
       bc.practical_door_with, --门幅
       bc.gram_weight, --克重
       bc.material_specifications, --规格
       t.pick_num, --已领料量
       g3.company_user_name create_name,
       t.create_time,   
       g1.company_user_name pick_name,
       t.pick_time, 
       t.cancel_reason ,
       g2.company_user_name cancel_name,
       t.cancel_time
  from mrp.pick_list t
  inner join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
  inner join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.relate_product_order_num
 inner join scmdata.t_orders od
    on od.company_id = t.company_id
   and od.order_id = t.relate_product_order_num
   left join scmdata.sys_company_user g1
     on g1.company_id = t.company_id
    and g1.user_id = t.pick_id
   left join scmdata.sys_company_user g2
     on g2.company_id = t.company_id
    and g2.user_id = t.cancel_id
   left join scmdata.sys_company_user g3
     on g3.company_id = t.company_id
    and g3.user_id = t.create_id
 where t.relate_skc = :skc 
       and t.material_sku = :material_sku
       and t.pro_supplier_code = :pro_supplier_code
       and t.mater_supplier_code = :material_supplier_code
       and t.unit = :purchase_unit
 and t.pick_status = '2'
 order by t.cancel_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_307;

  --面料采购——待接单页面查询 item_id:a_prematerial_411页面 select_sql
  FUNCTION f_a_prematerial_411 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select ts.supplier_company_name pro_supplier_name, --成品供应商
       t.pro_supplier_code,
       t.mater_supplier_code,
       t.group_key,
       t.supplier_material_name, --供应商物料名称 
       t.material_sku, --物料sku  
       t.supplier_color material_supplier_color, --供应商颜色 
       trim(t.supplier_shades)supplier_shades, --供应商色号 
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       nvl(mc.brand_stock, 0) brand_stock, --品牌仓库存数 
       nvl(mc.supplier_stock, 0) supplier_stock, --供应商仓库存数  
       (nvl(mc.brand_stock, 0) + nvl(mc.supplier_stock, 0)) stock, --现有总库存
       tm.material_classification , --物料分类
       t.practical_door_with, --实用门幅  
       t.gram_weight, --克重 
       t.material_specifications, --物料规格 
       ts.supplier_code, --成品供应商编号  
       t.last_update_time
  from (select distinct tf.pro_supplier_code,
                        tf.company_id,
                        tf.material_sku,
                        tf.supplier_material_name,
                        tf.mater_supplier_code,
                        tf.unit,
                        tf.group_key,
                        tf.material_spu,
                        tf.supplier_color,
                        tf.supplier_shades,
                        sum(tf.suggest_pick_amount) over(partition by tf.company_id, tf.group_key) suggest_pick_amount,
                        max(tf.create_time ) over(partition by tf.company_id, tf.group_key) last_update_time,
                        tf.practical_door_with,
                        tf.gram_weight,
                        tf.material_specifications
          from mrp.t_fabric_purchase_sheet tf
         where tf.fabric_status = 'S01'
           and tf.mater_supplier_code =
                       (select t.supplier_code
                          from mrp.mrp_determine_supplier_archives t
                 where t.supplier_company_id = %default_company_id%
                   and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')) t
 inner join scmdata.t_supplier_info ts
    on ts.supplier_info_id = t.pro_supplier_code
   and ts.company_id = t.company_id
  left join mrp.mrp_internal_material_spu tm
    on tm.material_spu = t.material_spu
  left join mrp.material_color_cloth_stock mc
    on mc.mater_supplier_code = t.mater_supplier_code
   and mc.material_sku = t.material_sku
   and mc.unit = t.unit
 order by t.suggest_pick_amount desc
]';
    RETURN v_sql;
  END f_a_prematerial_411;

  --面料采购——待发货页面查询 item_id:a_prematerial_412页面 select_sql
  FUNCTION f_a_prematerial_412 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select ts.supplier_company_name pro_supplier_name, --成品供应商
       t.pro_supplier_code,
       t.mater_supplier_code,t.group_key,
       t.supplier_material_name, --供应商物料名称 
       t.material_sku, --物料sku  
       t.supplier_color material_supplier_color, --供应商颜色 
       trim(t.supplier_shades)supplier_shades, --供应商色号 
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       t.already_deliver_amount, --已发货量
       nvl(mc.brand_stock,0) brand_stock, --品牌仓库存数 
       nvl(mc.supplier_stock,0) supplier_stock, --供应商仓库存数  
       (nvl(mc.brand_stock,0) + nvl(mc.supplier_stock,0)) stock, --现有总库存
       tm.material_classification , --物料分类
       t.practical_door_with, --实用门幅  
       t.gram_weight, --克重 
       t.material_specifications, --物料规格 
       ts.supplier_code, --成品供应商编号  
       t.last_update_time
  from (select distinct tf.pro_supplier_code,
                        tf.company_id,
                        tf.material_sku,
                        tf.supplier_material_name,
                        tf.mater_supplier_code,
                        tf.unit,
                        tf.material_spu,
                        tf.supplier_color,
                        tf.supplier_shades,tf.group_key,
                        sum(tf.suggest_pick_amount) over(partition by tf.group_key,tf.company_id) suggest_pick_amount,
                        sum(tf.already_deliver_amount) over(partition by tf.group_key,tf.company_id) already_deliver_amount,
                        max(tf.receive_order_time  ) over(partition by tf.company_id, tf.group_key) last_update_time,
                        tf.practical_door_with,
                        tf.gram_weight,
                        tf.material_specifications
          from mrp.t_fabric_purchase_sheet tf
         where tf.fabric_status = 'S02'
           and tf.mater_supplier_code =
                       (select t.supplier_code
                          from mrp.mrp_determine_supplier_archives t
                 where t.supplier_company_id = %default_company_id%
                   and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')) t
 inner join scmdata.t_supplier_info ts
    on ts.supplier_info_id = t.pro_supplier_code
   and ts.company_id = t.company_id
  left join mrp.mrp_internal_material_spu tm
    on tm.material_spu = t.material_spu
  left join mrp.material_color_cloth_stock mc
    on mc.mater_supplier_code = t.mater_supplier_code
   and mc.material_sku = t.material_sku
   and mc.unit = t.unit
 order by t.suggest_pick_amount desc
]';
    RETURN v_sql;
  END f_a_prematerial_412;

  --面料采购——已完成页面查询 item_id:a_prematerial_413页面 select_sql
  FUNCTION f_a_prematerial_413 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select ts.supplier_company_name pro_supplier_name, --成品供应商
       t.pro_supplier_code,
       t.mater_supplier_code,
       t.supplier_material_name, --供应商物料名称 
       t.material_sku, --物料sku  
       t.supplier_color material_supplier_color, --供应商颜色 
       --t.supplier_shades, --供应商色号 
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       t.already_deliver_amount, --发货量
       nvl(mc.brand_stock,0) brand_stock, --品牌仓库存数 
       nvl(mc.supplier_stock,0) supplier_stock, --供应商仓库存数  
       (nvl(mc.brand_stock,0) + nvl(mc.supplier_stock,0)) stock, --现有总库存
       tm.material_classification , --物料分类
       ts.supplier_code, --成品供应商编号  
       t.last_update_time
  from (select distinct tf.pro_supplier_code,
                        tf.company_id,
                        tf.material_sku,
                        tf.supplier_material_name,
                        tf.mater_supplier_code,
                        tf.unit,
                        tf.material_spu,
                        tf.supplier_color,
                        --tf.supplier_shades,
                        sum(tf.suggest_pick_amount) over(partition by tf.pro_supplier_code, tf.mater_supplier_code, tf.company_id, tf.material_sku, tf.unit) suggest_pick_amount,
                        sum(tf.already_deliver_amount) over(partition by tf.pro_supplier_code, tf.mater_supplier_code, tf.company_id, tf.material_sku, tf.unit) already_deliver_amount,
                        max(tf.send_order_time   ) over(partition by tf.company_id, tf.group_key) last_update_time,
                        tf.practical_door_with,
                        tf.gram_weight,
                        tf.material_specifications
          from mrp.t_fabric_purchase_sheet tf
         where tf.fabric_status in ('S03', 'S04')
           and tf.mater_supplier_code =
                       (select t.supplier_code
                          from mrp.mrp_determine_supplier_archives t
                 where t.supplier_company_id = %default_company_id%
                   and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')) t
 inner join scmdata.t_supplier_info ts
    on ts.supplier_info_id = t.pro_supplier_code
   and ts.company_id = t.company_id
  left join mrp.mrp_internal_material_spu tm
    on tm.material_spu = t.material_spu
  left join mrp.material_color_cloth_stock mc
    on mc.mater_supplier_code = t.mater_supplier_code
   and mc.material_sku = t.material_sku
   and mc.unit = t.unit
 order by t.suggest_pick_amount desc
]';
    RETURN v_sql;
  END f_a_prematerial_413;

  --面料采购——已取消页面查询 item_id:a_prematerial_414页面 select_sql
  FUNCTION f_a_prematerial_414 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select ts.supplier_company_name pro_supplier_name, --成品供应商
       t.pro_supplier_code,
       t.mater_supplier_code,
       t.supplier_material_name, --供应商物料名称 
       t.material_sku, --物料sku  
       t.supplier_color material_supplier_color, --供应商颜色 
       --t.supplier_shades, --供应商色号 
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       t.already_deliver_amount, --发货量
       nvl(mc.brand_stock,0) brand_stock, --品牌仓库存数 
       nvl(mc.supplier_stock,0) supplier_stock, --供应商仓库存数  
       (nvl(mc.brand_stock,0) + nvl(mc.supplier_stock,0)) stock, --现有总库存
       tm.material_classification , --物料分类
       ts.supplier_code, --成品供应商编号  
       t.last_update_time
  from (select distinct tf.pro_supplier_code,
                        tf.company_id,
                        tf.material_sku,
                        tf.supplier_material_name,
                        tf.mater_supplier_code,
                        tf.unit,
                        tf.material_spu,
                        tf.supplier_color,
                       -- tf.supplier_shades,
                        sum(tf.suggest_pick_amount) over(partition by tf.company_id, tf.group_key) suggest_pick_amount,
                        sum(tf.already_deliver_amount) over(partition by tf.company_id, tf.group_key) already_deliver_amount,
                        max(tf.cancel_time ) over(partition by tf.company_id, tf.group_key) last_update_time,
                        tf.practical_door_with,
                        tf.gram_weight,
                        tf.material_specifications
          from mrp.t_fabric_purchase_sheet tf
         where tf.fabric_status = 'S05'
           and tf.mater_supplier_code =
                       (select t.supplier_code
                          from mrp.mrp_determine_supplier_archives t
                 where t.supplier_company_id = %default_company_id%
                   and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')) t
 inner join scmdata.t_supplier_info ts
    on ts.supplier_info_id = t.pro_supplier_code
   and ts.company_id = t.company_id
  left join mrp.mrp_internal_material_spu tm
    on tm.material_spu = t.material_spu
  left join mrp.material_color_cloth_stock mc
    on mc.mater_supplier_code = t.mater_supplier_code
   and mc.material_sku = t.material_sku
   and mc.unit = t.unit
 order by t.suggest_pick_amount desc
]';
    RETURN v_sql;
  END f_a_prematerial_414;

  --面料采购——全部页面查询 item_id:a_prematerial_415页面 select_sql
  FUNCTION f_a_prematerial_415 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.fabric_id,
       (case
         when t.fabric_status = 'S00' then
          '待下单'
         when t.fabric_status = 'S01' then
          '待接单'
         when t.fabric_status = 'S02' then
          '待发货'
         when t.fabric_status = 'S03' then
          '待收货'
         when t.fabric_status = 'S04' then
          '已收货'
         when t.fabric_status = 'S05' then
          '已取消'
       end) fabric_status, --面料采购订单状态
       ts.supplier_company_name pro_supplier_name, --成品供应商
       t.supplier_material_name, --供应商物料名称 
       t.material_sku, --物料sku  
       t.supplier_color material_supplier_color, --供应商颜色 
       trim(t.supplier_shades)supplier_shades, --供应商色号 
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       t.already_deliver_amount, --已发货量 
       nvl(mc.brand_stock,0) brand_stock, --品牌仓库存数 
       nvl(mc.supplier_stock,0) supplier_stock, --供应商仓库存数  
       (nvl(mc.brand_stock,0) + nvl(mc.supplier_stock,0)) stock, --现有总库存
       tm.material_classification , --物料分类
       ts.supplier_code, --成品供应商编号    
       t.purchase_order_num product_order_num, --生产订单号    
       tp.progress_status progress_status_pr, --生产进度状态
       tci.rela_goo_id, --货号
       tci.style_number, --款号
       t.goods_skc SKC, --货色skc
       max(od.delivery_date) over(partition by od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       t.purchase_skc_order_amount skc_order_num, --采购skc订单量 
       (bc.consumption ||  bc.examine_unit) consumption, --单件用量
       t.practical_door_with, --实用门幅  
       t.gram_weight, --克重 
       t.material_specifications, --物料规格 
       a.group_dict_name category, --分类
       b.group_dict_name product_cate, --生产类别
       c.company_dict_name samll_category, --产品子类
       e.group_dict_name season, --季节
       g3.company_user_name create_name, --创建人
       t.create_time, --创建时间
       g2.company_user_name receive_name, --接单人id 
       t.receive_order_time, --接单时间 
       g1.company_user_name send_order_name, --发货人id 
       t.send_order_time, --发货人时间 
       t.cancel_cause cancel_reason, --取消人原因 
       g0.company_user_name cancel_name, --取消人id 
       t.cancel_time --取消人时间 
  from mrp.t_fabric_purchase_sheet t
 left join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.goods_skc
 left join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
   and cp.seqno = 1
 left join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.purchase_order_num
 left join scmdata.t_orders od
    on od.company_id = t.company_id
   and od.order_id = t.purchase_order_num
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
  left join scmdata.sys_company_user g3
    on g3.company_id = t.company_id
   and g3.user_id = t.create_id
  left join scmdata.sys_company_user g2
    on g2.company_id = t.company_id
   and g2.user_id = t.receive_order_id
  left join scmdata.sys_company_user g1
    on g1.company_id = t.company_id
   and g1.user_id = t.send_order_id
  left join scmdata.sys_company_user g0
    on g0.company_id = t.company_id
   and g0.user_id = t.cancel_id
 left join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
  left join mrp.mrp_internal_material_spu tm
    on tm.material_spu = t.material_spu
 left join scmdata.t_supplier_info ts
    on ts.supplier_info_id = t.pro_supplier_code
   and ts.company_id = t.company_id
  left join mrp.material_color_cloth_stock mc
    on mc.mater_supplier_code = t.mater_supplier_code
   and mc.material_sku = t.material_sku
   and mc.unit = t.unit
 where t.mater_supplier_code =
                       (select t.supplier_code
                          from mrp.mrp_determine_supplier_archives t
         where t.supplier_company_id = %default_company_id%
           and t.company_id = 'b6cc680ad0f599cde0531164a8c0337f')
order by t.create_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_415;

  --面料采购——待接单页面从表查询 item_id:a_prematerial_416页面 select_sql
  FUNCTION f_a_prematerial_416 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.fabric_id,
       (case
         when t.fabric_status = 'S00' then
          '待下单'
         when t.fabric_status = 'S01' then
          '待接单'
         when t.fabric_status = 'S02' then
          '待发货'
         when t.fabric_status = 'S03' then
          '待收货'
         when t.fabric_status = 'S04' then
          '已收货'
         when t.fabric_status = 'S05' then
          '已取消'
       end) fabric_status, --面料采购订单状态
       trim(t.supplier_shades)supplier_shades,
       t.purchase_order_num product_order_num, --生产订单号    
       tp.progress_status progress_status_pr, --生产进度状态
       tci.rela_goo_id, --货号
       tci.style_number, --款号
       tcc.colorname, --颜色
       t.goods_skc SKC, --货色skc
       max(od.delivery_date) over(partition by od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       t.purchase_skc_order_amount skc_order_num, --采购skc订单量 
       (bc.consumption || bc.examine_unit) consumption, --单件用量
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       a.group_dict_name category, --分类
       b.group_dict_name product_cate, --生产类别
       c.company_dict_name samll_category, --产品子类
       e.group_dict_name season, --季节
       g3.company_user_name create_name, --创建人
       t.create_time --创建时间
  from mrp.t_fabric_purchase_sheet t
 inner join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.goods_skc
 inner join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
   and cp.seqno = 1
 left join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.purchase_order_num
 inner join scmdata.t_orders od
    on od.company_id = t.company_id
   and od.order_id = t.purchase_order_num
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
  left join scmdata.sys_company_user g3
    on g3.company_id = t.company_id
   and g3.user_id = t.create_id
 inner join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
 where t.fabric_status = 'S01'
   and t.group_key = :group_key
order by t.create_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_416;

  --面料采购——待发货页面从表查询 item_id:a_prematerial_417页面 select_sql
  FUNCTION f_a_prematerial_417 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.fabric_id,
       (case
         when t.fabric_status = 'S00' then
          '待下单'
         when t.fabric_status = 'S01' then
          '待接单'
         when t.fabric_status = 'S02' then
          '待发货'
         when t.fabric_status = 'S03' then
          '待收货'
         when t.fabric_status = 'S04' then
          '已收货'
         when t.fabric_status = 'S05' then
          '已取消'
       end) fabric_status, --面料采购订单状态
       trim(t.supplier_shades)supplier_shades,
       t.purchase_order_num product_order_num, --生产订单号    
       tp.progress_status progress_status_pr, --生产进度状态
       tci.rela_goo_id, --货号
       tci.style_number, --款号
       tcc.colorname, --颜色
       t.goods_skc SKC, --货色skc
       max(od.delivery_date) over(partition by od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       t.purchase_skc_order_amount skc_order_num, --采购skc订单量 
       (bc.consumption || bc.examine_unit) consumption, --单件用量
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       t.already_deliver_amount, --已发货量 
       a.group_dict_name category, --分类
       b.group_dict_name product_cate, --生产类别
       c.company_dict_name samll_category, --产品子类
       e.group_dict_name season, --季节
       g3.company_user_name create_name, --创建人
       t.create_time, --创建时间
       g2.company_user_name receive_name, --接单人id 
       t.receive_order_time --接单时间 
  from mrp.t_fabric_purchase_sheet t
 inner join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.goods_skc
 inner join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
   and cp.seqno = 1
 left join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.purchase_order_num
 inner join scmdata.t_orders od
    on od.company_id = t.company_id
   and od.order_id = t.purchase_order_num
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
  left join scmdata.sys_company_user g3
    on g3.company_id = t.company_id
   and g3.user_id = t.create_id
  left join scmdata.sys_company_user g2
    on g2.company_id = t.company_id
   and g2.user_id = t.receive_order_id
 inner join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
 where t.fabric_status = 'S02'
   and t.group_key = :group_key
order by t.create_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_417;

  --面料采购——已完成页面从表查询 item_id:a_prematerial_418页面 select_sql
  FUNCTION f_a_prematerial_418 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.fabric_id,
       (case
         when t.fabric_status = 'S00' then
          '待下单'
         when t.fabric_status = 'S01' then
          '待接单'
         when t.fabric_status = 'S02' then
          '待发货'
         when t.fabric_status = 'S03' then
          '已完成'
         when t.fabric_status = 'S04' then
          '已完成'
         when t.fabric_status = 'S05' then
          '已取消'
       end) fabric_status, --面料采购订单状态
       t.purchase_order_num product_order_num, --生产订单号    
       tp.progress_status progress_status_pr, --生产进度状态
       tci.rela_goo_id, --货号
       tci.style_number, --款号
       tcc.colorname, --颜色
       t.goods_skc SKC, --货色skc
       max(od.delivery_date) over(partition by od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       t.purchase_skc_order_amount skc_order_num, --采购skc订单量 
       (bc.consumption || bc.examine_unit) consumption, --单件用量
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       t.already_deliver_amount, --已发货量 
       t.supplier_shades, --供应商色号 
       t.practical_door_with, --实用门幅  
       t.gram_weight, --克重 
       t.material_specifications, --物料规格 
       a.group_dict_name category, --分类
       b.group_dict_name product_cate, --生产类别
       c.company_dict_name samll_category, --产品子类
       e.group_dict_name season, --季节
       g3.company_user_name create_name, --创建人
       t.create_time, --创建时间
       g2.company_user_name receive_name, --接单人id 
       t.receive_order_time, --接单时间 
       g1.company_user_name send_order_name, --发货人 
       t.send_order_time --发货时间
  from mrp.t_fabric_purchase_sheet t
 left join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.goods_skc
 left join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
   and cp.seqno = 1
 left join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.purchase_order_num
 left join scmdata.t_orders od
    on od.company_id = t.company_id
   and od.order_id = t.purchase_order_num
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
  left join scmdata.sys_company_user g3
    on g3.company_id = t.company_id
   and g3.user_id = t.create_id
  left join scmdata.sys_company_user g2
    on g2.company_id = t.company_id
   and g2.user_id = t.receive_order_id
  left join scmdata.sys_company_user g1
    on g1.company_id = t.company_id
   and g1.user_id = t.send_order_id
 left join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
 where t.pro_supplier_code = :pro_supplier_code
   and t.mater_supplier_code = :mater_supplier_code
   and t.material_sku = :material_sku
   and t.unit = :unit
   and t.fabric_status in ('S03' ,'S04')
 order by t.create_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_418;

  --面料采购——已取消页面从表查询 item_id:a_prematerial_419页面 select_sql
  FUNCTION f_a_prematerial_419 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select t.fabric_id,
       (case
         when t.fabric_status = 'S00' then
          '待下单'
         when t.fabric_status = 'S01' then
          '待接单'
         when t.fabric_status = 'S02' then
          '待发货'
         when t.fabric_status = 'S03' then
          '待收货'
         when t.fabric_status = 'S04' then
          '已收货'
         when t.fabric_status = 'S05' then
          '已取消'
       end) fabric_status, --面料采购订单状态
       t.purchase_order_num product_order_num, --生产订单号    
       tp.progress_status progress_status_pr, --生产进度状态
       tci.rela_goo_id, --货号
       tci.style_number, --款号
       tcc.colorname, --颜色
       t.goods_skc SKC, --货色skc
       max(od.delivery_date) over(partition by od.order_id) latest_planned_delivery_date_pr, --最新计划交期
       t.purchase_skc_order_amount skc_order_num, --采购skc订单量 
       (bc.consumption || bc.examine_unit) consumption, --单件用量
       t.unit, --单位 
       t.suggest_pick_amount, --建议采购量 
       t.already_deliver_amount, --已发货量 
       t.supplier_shades, --供应商色号 
       t.practical_door_with, --实用门幅  
       t.gram_weight, --克重 
       t.material_specifications, --物料规格 
       a.group_dict_name category, --分类
       b.group_dict_name product_cate, --生产类别
       c.company_dict_name samll_category, --产品子类
       e.group_dict_name season, --季节
       g3.company_user_name create_name, --创建人
       t.create_time, --创建时间
       g2.company_user_name receive_name, --接单人id 
       t.receive_order_time, --接单时间 
       t.cancel_cause cancel_reason, --取消人原因 
       g0.company_user_name cancel_name, --取消人id 
       t.cancel_time --取消人时间 
  from mrp.t_fabric_purchase_sheet t
 inner join scmdata.t_commodity_color tcc
    on tcc.company_id = t.company_id
   and tcc.commodity_color_code = t.goods_skc
 inner join scmdata.t_commodity_info tci
    on tci.company_id = tcc.company_id
   and tci.goo_id = tcc.goo_id
   and tci.rela_goo_id = tcc.rela_goo_id
  left join scmdata.t_commodity_picture cp
    on cp.goo_id = tci.goo_id
   and cp.company_id = tci.company_id
   and cp.seqno = 1
 left join scmdata.t_production_progress tp
    on tp.company_id = t.company_id
   and tp.product_gress_code = t.purchase_order_num
 inner join scmdata.t_orders od
    on od.company_id = t.company_id
   and od.order_id = t.purchase_order_num
  left join scmdata.sys_group_dict a
    on a.group_dict_type = 'PRODUCT_TYPE'
   and a.group_dict_value = tci.category
  left join scmdata.sys_group_dict b
    on b.group_dict_type = a.group_dict_value
   and b.group_dict_value = tci.product_cate
  left join scmdata.sys_company_dict c
    on c.company_dict_type = b.group_dict_value
   and c.company_dict_value = tci.samll_category
   and c.company_id = tci.company_id
  left join scmdata.sys_group_dict e
    on e.group_dict_type = 'GD_SESON'
   and e.group_dict_value = tci.season
  left join scmdata.sys_company_user g3
    on g3.company_id = t.company_id
   and g3.user_id = t.create_id
  left join scmdata.sys_company_user g2
    on g2.company_id = t.company_id
   and g2.user_id = t.receive_order_id
  left join scmdata.sys_company_user g0
    on g0.company_id = t.company_id
   and g0.user_id = t.cancel_id
 inner join mrp.bulk_cargo_bom_material_detail bc
    on bc.material_detail_id = t.material_detail_id
   and bc.company_id = t.company_id
 where t.pro_supplier_code = :pro_supplier_code
   and t.mater_supplier_code = :mater_supplier_code
   and t.material_sku = :material_sku
   and t.unit = :unit
   and t.fabric_status = 'S05' 
 order by t.create_time desc
]';
    RETURN v_sql;
  END f_a_prematerial_419;

  --查询 item_id:a_prematerial_420页面 select_sql
  FUNCTION f_a_prematerial_420 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[  --SELECT ROWNUM CNO, Z.* FROM (
SELECT   ROW_NUMBER() OVER(PARTITION BY A.OPERATE_COMPANY_ID ORDER BY A.CREATE_TIME DESC) CNO,
         A.SEND_GOODS_SHEET_TEMP_ID,
         B.SUPPLIER_COMPANY_NAME PRO_SUPPLIER_NAME, --成品供应商
         A.PRO_SUPPLIER_CODE PRO_SUPPLIER_CODE,
         D.SUPPLIER_MATERIAL_NAME SUPPLIER_MATERIAL_NAME,--供应商物料名称
         A.MATERIAL_SKU,--物料sku
         D.SUPPLIER_COLOR MATERIAL_SUPPLIER_COLOR,--供应商物料颜色
         D.SUPPLIER_SHADES V_SUPPLIER_SHADES,--供应商色号
         F.UNIT,--单位
         A.SEND_AMOUNT ,--本次发货量 -
         G.BRAND_STOCK BRAND_SKU_STOCK,--品牌色布库存 -
         G.SUPPLIER_STOCK SUPP_SKU_STOCK,--供应商色布库存 -
         G.TOTAL_STOCK  SKU_TOTAL_STOCK_DESC,--现有总库存
        F.MATERIAL_CLASSIFICATION, --物料分类
        --H.RESULT MATERIAL_CLASSIFICATION_DESC,
        F.PRACTICAL_DOOR_WITH V_PRACTICAL_DOOR_WITH, --门幅
        F.GRAM_WEIGHT CR_GRAM_WEIGHT_N, --克重
        F.MATERIAL_SPECIFICATIONS, --规格
        B.SUPPLIER_CODE PRO_SUPPLIER_CODE_DESC, --成品供应商编号
        U.NICK_NAME CREATE_NAME, --创建人
        A.CREATE_TIME --创建时间
 FROM MRP.T_SEND_GOODS_SHEET_TEMP A
 INNER JOIN SCMDATA.T_SUPPLIER_INFO B ON A.PRO_SUPPLIER_CODE = B.SUPPLIER_INFO_ID AND A.COMPANY_ID=B.COMPANY_ID
 INNER JOIN MRP.MRP_DETERMINE_SUPPLIER_ARCHIVES C ON A.OPERATE_COMPANY_ID=C.SUPPLIER_COMPANY_ID AND A.COMPANY_ID=C.COMPANY_ID
 INNER JOIN MRP.MRP_INTERNAL_SUPPLIER_MATERIAL D ON A.MATERIAL_SKU = D.MATERIAL_SKU AND D.SUPPLIER_CODE = C.SUPPLIER_CODE
 INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SKU E ON E.MATERIAL_SKU=D.MATERIAL_SKU  
 INNER JOIN MRP.MRP_INTERNAL_MATERIAL_SPU F ON F.MATERIAL_SPU=E.MATERIAL_SPU
 LEFT JOIN MRP.MATERIAL_COLOR_CLOTH_STOCK  G  ON G.MATERIAL_SKU = A.MATERIAL_SKU AND F.UNIT = G.UNIT AND C.SUPPLIER_CODE=G.MATER_SUPPLIER_CODE
 /*LEFT JOIN  (SELECT NVL(T4.COMPANY_DICT_ID, T3.COMPANY_DICT_ID) CATEGORY_ID,
                    T1.COMPANY_DICT_NAME CATEGORY,
                    T2.COMPANY_DICT_NAME NAME1,
                    T3.COMPANY_DICT_NAME NAME2,
                    T4.COMPANY_DICT_NAME NAME4,
                    (T1.COMPANY_DICT_NAME || '/' || T2.COMPANY_DICT_NAME || '/' ||
                    T3.COMPANY_DICT_NAME || (CASE
                      WHEN T4.COMPANY_DICT_NAME IS NOT NULL THEN
                       '/' || T4.COMPANY_DICT_NAME
                      ELSE
                       NULL
                    END)) RESULT
               FROM SCMDATA.SYS_COMPANY_DICT T1
              LEFT JOIN SCMDATA.SYS_COMPANY_DICT T2
                 ON T1.COMPANY_ID = T2.COMPANY_ID
                AND T1.COMPANY_DICT_TYPE = 'MRP_MATERIAL_CLASSIFICATION'
                AND T2.COMPANY_DICT_TYPE = T1.COMPANY_DICT_VALUE
                AND T2.PAUSE = 0 AND T1.PAUSE=0
              LEFT JOIN SCMDATA.SYS_COMPANY_DICT T3
                 ON T2.COMPANY_ID = T3.COMPANY_ID
                AND T3.COMPANY_DICT_TYPE = T2.COMPANY_DICT_VALUE
                AND T3.PAUSE = 0
               LEFT JOIN SCMDATA.SYS_COMPANY_DICT T4
                 ON T3.COMPANY_ID = T4.COMPANY_ID
                AND T4.COMPANY_DICT_TYPE = T3.COMPANY_DICT_VALUE
                AND T4.PAUSE = 0) H ON H.CATEGORY_ID = F.MATERIAL_CLASSIFICATION */
 INNER JOIN SCMDATA.SYS_USER U ON U.USER_ID = A.CREATE_ID
 WHERE C.SUPPLIER_COMPANY_ID = %DEFAULT_COMPANY_ID%
   AND A.STATUS = 1 
   ORDER BY A.CREATE_TIME DESC
   /*) Z*/]';
    RETURN v_sql;
  END f_a_prematerial_420;
  --替换物料sku页面查询 item_id:a_prematerial_421页面 select_sql
  FUNCTION f_a_prematerial_421(V_GROUP_KEY in varchar2) RETURN CLOB IS
    v_sql                     CLOB;
    V_PRO_SUPPLIER_CODE       VARCHAR2(32);
    V_MATER_SUPPLIER_CODE     VARCHAR2(32);
    V_MATERIAL_SKU            VARCHAR2(32);
    V_UNIT                    VARCHAR2(32);
    V_SUPPLIER_SHADES         VARCHAR2(32);
    V_PRACTICAL_DOOR_WITH     VARCHAR2(32);
    V_GRAM_WEIGHT             VARCHAR2(32);
    V_MATERIAL_SPECIFICATIONS VARCHAR2(32);
    V_SUPPLIER_COMPANY_NAME   VARCHAR2(128);
  BEGIN
    SELECT MAX(TF.PRO_SUPPLIER_CODE),
           MAX(TF.MATER_SUPPLIER_CODE),
           MAX(TF.MATERIAL_SKU),
           MAX(TF.UNIT),
           MAX(TF.SUPPLIER_SHADES),
           MAX(TF.PRACTICAL_DOOR_WITH),
           MAX(TF.GRAM_WEIGHT),
           MAX(TF.MATERIAL_SPECIFICATIONS)
      INTO V_PRO_SUPPLIER_CODE,
           V_MATER_SUPPLIER_CODE,
           V_MATERIAL_SKU,
           V_UNIT,
           V_SUPPLIER_SHADES,
           V_PRACTICAL_DOOR_WITH,
           V_GRAM_WEIGHT,
           V_MATERIAL_SPECIFICATIONS
      FROM MRP.T_FABRIC_PURCHASE_SHEET TF
     WHERE TF.GROUP_KEY = V_GROUP_KEY;
  
    SELECT MAX(TS.SUPPLIER_COMPANY_NAME)
      INTO V_SUPPLIER_COMPANY_NAME
      FROM SCMDATA.T_SUPPLIER_INFO TS
     WHERE TS.SUPPLIER_INFO_ID = V_PRO_SUPPLIER_CODE
       AND TS.COMPANY_ID = 'b6cc680ad0f599cde0531164a8c0337f';
    v_sql := q'[ select a.supplier_material_name, --供应商物料名称
       a.material_sku, --物料sku
       a.supplier_code,
       a.supplier_color material_supplier_color, --供应商物料颜色
       a.supplier_shades, --供应商色号
       f.result material_classification, --分类
       c.unit, --单位
       nvl(mc.brand_stock, 0) brand_stock, --品牌仓库存数 
       nvl(mc.supplier_stock, 0) supplier_stock, --供应商仓库存数  
       (nvl(mc.brand_stock, 0) + nvl(mc.supplier_stock, 0)) stock, --现有总库存
       c.practical_door_with, --实用门幅
       c.gram_weight, --克重
       c.material_specifications, --物料规格
       ]' || '''' || V_GROUP_KEY || ''' v_group_key,' || '''' ||
             V_SUPPLIER_COMPANY_NAME || ''' v_pro_supplier_name,' || '''' ||
             V_MATERIAL_SKU || ''' v_material_sku,' || '''' || V_UNIT ||
             ''' v_unit,' || '''' || V_SUPPLIER_SHADES ||
             ''' v_supplier_shades,' || '''' || V_PRACTICAL_DOOR_WITH ||
             ''' v_practical_door_with,' || '''' || V_GRAM_WEIGHT ||
             ''' v_gram_weight,' || '''' || V_MATERIAL_SPECIFICATIONS ||
             ''' v_material_specifications' || q'[
  from mrp.mrp_internal_supplier_material a
 inner join mrp.mrp_internal_material_sku b
    on a.material_sku = b.material_sku
 inner join mrp.mrp_internal_material_spu c
    on c.material_spu = b.material_spu
 inner join mrp.mrp_determine_supplier_archives d
    on d.supplier_code = a.supplier_code
  left join scmdata.t_supplier_info ts
    on ts.supplier_info_id = ']' || V_PRO_SUPPLIER_CODE || q'['
  left join (select nvl(nvl(t4.company_dict_id, t3.company_dict_id),
                        t2.company_dict_id) category_id,
                    t1.company_dict_name category,
                    t2.company_dict_name name1,
                    t3.company_dict_name name2,
                    t4.company_dict_name name4,
                    (t1.company_dict_name || '/' || t2.company_dict_name || '/' ||
                    t3.company_dict_name || (case
                      when t4.company_dict_name is not null then
                       '/' || t4.company_dict_name
                      else
                       null
                    end)) result
               from scmdata.sys_company_dict t1
              inner join scmdata.sys_company_dict t2
                 on t1.company_id = t2.company_id
                and t1.company_dict_type = 'MRP_MATERIAL_CLASSIFICATION'
                and t2.company_dict_type = t1.company_dict_value
               left join scmdata.sys_company_dict t3
                 on t2.company_id = t3.company_id
                and t3.company_dict_type = t2.company_dict_value
                and t3.pause = 0
               left join scmdata.sys_company_dict t4
                 on t3.company_id = t4.company_id
                and t4.company_dict_type = t3.company_dict_value
                and t4.pause = 0) f
    on f.category_id = c.material_classification
  left join mrp.material_color_cloth_stock mc
    on mc.mater_supplier_code = a.supplier_code
   and mc.material_sku = a.material_sku
   and mc.unit = c.unit
 where a.supplier_code = ']' || V_MATER_SUPPLIER_CODE || q'['
   and d.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
   and a.supplier_material_status = '1' ]';
    RETURN v_sql;
  END f_a_prematerial_421;

  --替换物料sku页面查询 item_id:a_prematerial_422页面 select_sql
  FUNCTION f_a_prematerial_422(V_FABRIC_ID in varchar2) RETURN CLOB IS
    v_sql                     CLOB;
    V_PRO_SUPPLIER_CODE       VARCHAR2(32);
    V_MATER_SUPPLIER_CODE     VARCHAR2(32);
    V_MATERIAL_SKU            VARCHAR2(32);
    V_UNIT                    VARCHAR2(32);
    V_SUPPLIER_SHADES         VARCHAR2(32);
    V_PRACTICAL_DOOR_WITH     VARCHAR2(32);
    V_GRAM_WEIGHT             VARCHAR2(32);
    V_MATERIAL_SPECIFICATIONS VARCHAR2(32);
    V_SUPPLIER_COMPANY_NAME   VARCHAR2(128);
    V_SUPPLIER_MATERIAL_NAME  VARCHAR2(128);
    --V_FABRIC_ID               VARCHAR2(1280);
    --V_SQL                     CLOB;
    --v_rest_method             VARCHAR2(1280);
    --v_params                  VARCHAR2(1280);
  BEGIN

    SELECT MAX(T.PRO_SUPPLIER_CODE),
           MAX(T.MATER_SUPPLIER_CODE),
           MAX(T.MATERIAL_SKU),
           MAX(T.UNIT),
           MAX(T.SUPPLIER_SHADES),
           MAX(T.PRACTICAL_DOOR_WITH),
           MAX(T.GRAM_WEIGHT),
           MAX(T.MATERIAL_SPECIFICATIONS)
      INTO V_PRO_SUPPLIER_CODE,
           V_MATER_SUPPLIER_CODE,
           V_MATERIAL_SKU,
           V_UNIT,
           V_SUPPLIER_SHADES,
           V_PRACTICAL_DOOR_WITH,
           V_GRAM_WEIGHT,
           V_MATERIAL_SPECIFICATIONS
      FROM MRP.T_FABRIC_PURCHASE_SHEET T
     WHERE T.FABRIC_ID IN
           (select regexp_substr(V_FABRIC_ID, '[^;]+', 1, level, 'i')
              from dual
            connect by level <=
                       length(V_FABRIC_ID) -
                       length(regexp_replace(V_FABRIC_ID, ';', '')) + 1);
  
    SELECT MAX(TS.SUPPLIER_COMPANY_NAME)
      INTO V_SUPPLIER_COMPANY_NAME
      FROM SCMDATA.T_SUPPLIER_INFO TS
     WHERE TS.SUPPLIER_INFO_ID = V_PRO_SUPPLIER_CODE
       AND TS.COMPANY_ID = 'b6cc680ad0f599cde0531164a8c0337f';
    SELECT MAX(A.SUPPLIER_MATERIAL_NAME)
      INTO V_SUPPLIER_MATERIAL_NAME
      FROM MRP.MRP_INTERNAL_SUPPLIER_MATERIAL A
     WHERE A.SUPPLIER_CODE = V_MATER_SUPPLIer_code;
    v_sql := q'[ select a.supplier_material_name, --供应商物料名称
       a.material_sku, --物料sku
       a.supplier_code,
       a.supplier_color material_supplier_color, --供应商物料颜色
       a.supplier_shades, --供应商色号
       f.result material_classification, --分类
       c.unit, --单位
       nvl(mc.brand_stock, 0) brand_stock, --品牌仓库存数 
       nvl(mc.supplier_stock, 0) supplier_stock, --供应商仓库存数  
       (nvl(mc.brand_stock, 0) + nvl(mc.supplier_stock, 0)) stock, --现有总库存
       c.practical_door_with, --实用门幅
       c.gram_weight, --克重
       c.material_specifications, --物料规格
       ]' || '''' || V_SUPPLIER_COMPANY_NAME ||
             ''' v_pro_supplier_name,' || '''' || V_MATERIAL_SKU ||
             ''' v_material_sku,' || '''' || V_UNIT || ''' V_UNIT,' || '''' ||
             V_SUPPLIER_SHADES || ''' V_SUPPLIER_SHADES,' || '''' ||
             V_PRACTICAL_DOOR_WITH || ''' V_PRACTICAL_DOOR_WITH,' || '''' ||
             V_GRAM_WEIGHT || ''' V_GRAM_WEIGHT,' || '''' ||
             V_MATERIAL_SPECIFICATIONS || ''' V_MATERIAL_SPECIFICATIONS,' || '''' ||
             V_FABRIC_ID || ''' v_fabric_id' || q'[
  from mrp.mrp_internal_supplier_material a
 inner join mrp.mrp_internal_material_sku b
    on a.material_sku = b.material_sku
 inner join mrp.mrp_internal_material_spu c
    on c.material_spu = b.material_spu
 inner join mrp.mrp_determine_supplier_archives d
    on d.supplier_code = a.supplier_code
  left join scmdata.t_supplier_info ts
    on ts.supplier_info_id = ']' || V_PRO_SUPPLIER_CODE || q'['
  left join (select nvl(nvl(t4.company_dict_id, t3.company_dict_id),
                        t2.company_dict_id) category_id,
                    t1.company_dict_name category,
                    t2.company_dict_name name1,
                    t3.company_dict_name name2,
                    t4.company_dict_name name4,
                    (t1.company_dict_name || '/' || t2.company_dict_name || '/' ||
                    t3.company_dict_name || (case
                      when t4.company_dict_name is not null then
                       '/' || t4.company_dict_name
                      else
                       null
                    end)) result
               from scmdata.sys_company_dict t1
              inner join scmdata.sys_company_dict t2
                 on t1.company_id = t2.company_id
                and t1.company_dict_type = 'MRP_MATERIAL_CLASSIFICATION'
                and t2.company_dict_type = t1.company_dict_value
               left join scmdata.sys_company_dict t3
                 on t2.company_id = t3.company_id
                and t3.company_dict_type = t2.company_dict_value
                and t3.pause = 0
               left join scmdata.sys_company_dict t4
                 on t3.company_id = t4.company_id
                and t4.company_dict_type = t3.company_dict_value
                and t4.pause = 0) f
    on f.category_id = c.material_classification
  left join mrp.material_color_cloth_stock mc
    on mc.mater_supplier_code = a.supplier_code
   and mc.material_sku = a.material_sku
   and mc.unit = c.unit
 where a.supplier_code = ']' || V_MATER_SUPPLIER_CODE || q'['
   and d.company_id = 'b6cc680ad0f599cde0531164a8c0337f'
   and a.supplier_material_status = '1' ]';
    RETURN v_sql;
  END f_a_prematerial_422;

  --发货记录页面查询 item_id:a_prematerial_423页面 select_sql
  FUNCTION f_a_prematerial_423 RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
select *
  from (select listagg(distinct tr.fabric_source, ';') within group(order by tfd.fabric_id) fabric_source,
               tfd.fabric_invoice_number,
               max(tfd.unit) unit,
               sum(tfd.send_goods_amount) send_goods_amount,
               max(g3.company_user_name) send_order_name,
               max(tf.create_time) send_order_time
          from mrp.t_fabric_invoice tf
         inner join mrp.t_fabric_invoice_detail tfd
            on tf.company_id = tfd.company_id
           and tf.fabric_invoice_number = tfd.fabric_invoice_number
         inner join (select t.fabric_id,
                           (case
                             when t.fabric_source = 0 then
                              '品牌采购单'
                             when t.fabric_source = 1 then
                              '供应商自采'
                             when t.fabric_source = 2 then
                              '物料商发货'
                           end) fabric_source,
                           t.mater_supplier_code,
                           t.pro_supplier_code,
                           t.material_sku,
                           t.company_id
                      from mrp.t_fabric_purchase_sheet t) tr
            on tfd.company_id = tr.company_id
           and tfd.fabric_id = tr.fabric_id
          left join scmdata.sys_company_user g3
            on g3.company_id = tf.company_id
           and g3.user_id = tf.create_id
         where tfd.mater_supplier_code = :mater_supplier_code
           and tfd.pro_supplier_code = :pro_supplier_code
           and tfd.material_sku = :material_sku
         group by tfd.fabric_invoice_number)
 order by send_order_time desc  ]';
    RETURN v_sql;
  END f_a_prematerial_423;
END pkg_material_preparation_stage_3;
/

