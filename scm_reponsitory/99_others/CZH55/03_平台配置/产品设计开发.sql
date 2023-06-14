--产品设计开发
--配置表
SELECT ROWID, t.* FROM nbw.sys_item t WHERE t.item_id LIKE '%a_good_%';
SELECT ROWID, t.*
  FROM nbw.sys_tree_list t
 WHERE t.item_id LIKE '%a_good_%';
SELECT ROWID, t.*
  FROM nbw.sys_item_list t
 WHERE t.item_id LIKE '%a_good_%';
SELECT ROWID, t.* FROM nbw.sys_item_rela t WHERE t.item_id = 'a_good_'; --主从表 
SELECT ROWID, t.* FROM nbw.sys_detail_group t;

--picklist  pick_sql 要有键值，对应item_list 的select_sql也要有键值字段。相关例子看：颜色 pick_a_good_101_1，尺寸  pick_a_good_101_2
SELECT ROWID, t.* FROM nbw.sys_element t;
SELECT ROWID, t.* FROM nbw.sys_pick_list t;
SELECT ROWID, t.* FROM nbw.sys_item_element_rela t;


--列关联按钮下钻 
SELECT ROWID, t.*
  FROM nbw.sys_element t  
 WHERE t.element_id LIKE '%a_good_%';
SELECT ROWID, t.*
  FROM nbw.sys_associate t
 WHERE t.element_id LIKE '%a_good_%';
SELECT ROWID, t.* FROM nbw.sys_item_element_rela t;
SELECT ROWID, t.* FROM nbw.sys_element_hint t;

--配置字段
INSERT INTO nbw.sys_field_list
  (field_name,
   caption,
   requiered_flag,
   read_only_flag,
   no_edit,
   no_copy,
   no_sort,
   alignment,
   ime_care,
   ime_open)
VALUES
  ('GOO_ID', '货号', 0, 0, 0, 0, 0, 0, 0, 0);

--商品档案列表

--1.商品列表  查询
SELECT tc.commodity_info_id,
       tc.company_id,
       --tc.origin,  来源 
       --tc.status 状态(暂无此字段)
       tc.supplier_code,
       sp.supplier_company_abbreviation,
       tc.rela_goo_id,
       tc.goo_id,
       tc.style_number,
       tc.sup_style_number,
       tc.category,
       tc.samll_category,
       tc.style_name,
       tc.year,
       tc.season,
       tc.inprice,
       tc.price,
       tc.create_id,
       tc.create_time,
       tc.update_id,
       tc.update_time
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_supplier_info sp
    ON tc.supplier_code = sp.supplier_code
   AND tc.company_id = sp.company_id
   AND sp.company_id = ''
 ORDER BY tc.create_time DESC; --当前默认企业编号

--2.商品列表 ==下钻==》 商品详情
--2.1 基本信息
SELECT tc.commodity_info_id,
       tc.company_id,
       tc.style_pic,
       tc.supplier_code,
       tc.style_name,
       sp.supplier_company_abbreviation,
       tc.style_number,
       tc.sup_style_number,
       tc.goo_id,
       tc.rela_goo_id,
       tc.category,
       tc.samll_category,
       tc.year,
       tc.season,
       tc.inprice,
       tc.price,
       tc.color_list,
       tc.size_list,
       tc.base_size,
       tc.create_id,
       tc.create_time,
       tc.update_id,
       tc.update_time
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_supplier_info sp
    ON tc.supplier_code = sp.supplier_code
   AND tc.company_id = sp.company_id
   AND sp.company_id = ''; --当前默认企业编号

--2.2更新 商品档案详情 主表
DECLARE
  v_cinfo_rec scmdata.t_commodity_info%TYPE;
BEGIN
  v_cinfo_rec.origin            := :origin;
  v_cinfo_rec.style_pic         := :style_pic;
  v_cinfo_rec.supplier_code     := :supplier_code;
  v_cinfo_rec.rela_goo_id       := :rela_goo_id;
  v_cinfo_rec.goo_id            := :goo_id;
  v_cinfo_rec.sup_style_number  := :sup_style_number;
  v_cinfo_rec.style_number      := :style_number;
  v_cinfo_rec.category          := :category;
  v_cinfo_rec.samll_category    := :samll_category;
  v_cinfo_rec.style_name        := :style_name;
  v_cinfo_rec.year              := :YEAR;
  v_cinfo_rec.season            := :season;
  v_cinfo_rec.base_size         := :base_size;
  v_cinfo_rec.inprice           := :inprice;
  v_cinfo_rec.price             := :price;
  v_cinfo_rec.update_time       := :update_time;
  v_cinfo_rec.update_id         := :update_id;
  v_cinfo_rec.commodity_info_id := :commodity_info_id;
  v_cinfo_rec.company_id        := %default_company_id%;
  --更新数据
  scmdata.pkg_commodity_info.update_commodity_info(p_cinfo_rec => v_cinfo_rec);
END;

--2.2 色码表
SELECT tcs.commodity_color_size_id,
       tcs.commodity_info_id,
       tcs.company_id,
       tcs.goo_id,
       tcs.color_code,
       tcs.barcode,
       tcs.colorname,
       tcs.sizename
  FROM scmdata.t_commodity_color_size tcs
 WHERE tcs.commodity_info_id = ''; --商品档案表主键

--删除 色码表
CALL scmdata.pkg_commodity_info.delete_comm_color_size(p_comm_color_size_id => :commodity_color_size_id);

--2.3 物料清单

SELECT *
  FROM scmdata.t_commodity_material_record tm
 WHERE tm.commodity_info_id = '';

--2.4 尺寸表
SELECT t.commodity_size_id,
       t.commodity_info_id,
       t.company_id,
       t.position,
       t.measurement_methods,
       t.std_size,
       t.tolerance_upper,
       t.tolerance_lower,
       --S M L
       t.remarks,
       t.goo_id
  FROM scmdata.t_commodity_size t
 WHERE t.commodity_info_id = '';
 
--同步主表尺码
SELECT t.commodity_size_id,
       t.commodity_info_id,
       t.company_id,
       t.position,
       t.measurement_methods,
       t.std_size,
       t.tolerance_upper,
       t.tolerance_lower,
       tc.size_list,
       gd.group_dict_value size_code,
       m.size_value,
       t.remarks,
       t.goo_id
  FROM scmdata.t_commodity_info tc
  LEFT JOIN scmdata.t_commodity_size t
    ON tc.commodity_info_id = t.commodity_info_id
 INNER JOIN scmdata.t_commodity_size_middle m
    ON t.commodity_info_id = m.commodity_info_id
   AND t.commodity_size_id = m.commodity_size_id
 INNER JOIN scmdata.sys_group_dict gd
    ON gd.group_dict_value IN
       (SELECT regexp_substr(tc.size_list, '[^;]+', 1, LEVEL) size_gd
          FROM dual
        CONNECT BY LEVEL <= regexp_count(tc.size_list, '[^;]+'));
WHERE t.commodity_info_id = :commodity_info_id;


--2.5 工艺单
SELECT t.commodity_craft_id,
       t.company_id,
       t.commodity_info_id,
       t.craft_type,
       t.part,
       t.process_description,
       t.remarks,
       t.goo_id
  FROM scmdata.t_commodity_craft t
 WHERE t.commodity_info_id = '';
 
DECLARE
BEGIN
   scmdata.pkg_commodity_info.insert_comm_craft(p_craft_rec =>);
   scmdata.pkg_commodity_info.update_comm_craft(p_craft_rec =>);
   scmdata.pkg_commodity_info.delete_comm_craft(p_commodity_craft_id =>);
END;

--2.6 附件
SELECT t.commodity_file_id,
       t.commodity_info_id,
       t.company_id,
       t.file_type,
       t.file_id,
       t.create_id,
       t.create_time,
       t.remarks,
       t.goo_id
  FROM scmdata.t_commodity_file t
 WHERE t.commodity_info_id = '';
--按钮

