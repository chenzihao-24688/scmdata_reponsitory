create or replace package mrp.pkg_bulk_cargo_bom is

  /*大货bom单落表逻辑*/
  procedure p_bulk_cargo_bom(v_order_id   in varchar2,
                             v_barcode    in varchar2,
                             v_company_id in varchar2);
  /*大货bom单物料明细表落表逻辑*/
  procedure p_bulk_cargo_bom_material_detail(v_bom_id           in varchar2,
                                             v_cooperation_mode in varchar2,
                                             v_company_id       in varchar2);
  /*odm----大货bom单物料明细表落表逻辑*/
  procedure p_mrp_odm_material(v_bom_id     in varchar2,
                               v_company_id in varchar2);
  /*oem----大货bom单物料明细表落表逻辑*/
  procedure p_mrp_oem_material(v_bom_id     in varchar2,
                               v_company_id in varchar2);
  /*领料单表落表逻辑*/
  procedure p_pick_list(v_product_gress_code in varchar2,
                        v_company_id         in varchar2);
  /*面料采购单表落表逻辑*/
  procedure p_fabric_purchase_sheet(v_bom_id     in varchar2,
                                    v_company_id in varchar2);
  /*分批领料单表落表逻辑
  部分领料单更新逻辑*/
  PROCEDURE p_pick_list_batch(material_num     in varchar2,
                              if_all_material  in number,
                              v_pick_lict_code in varchar2,
                              v_user_id        in varchar2,
                              v_item           in varchar2, --操作item
                              v_opr_com        in varchar2 --操作人企业
                              );
  /*领料出库——色布/胚布出入库单表*/
  procedure p_supplier_color_grey_in_out_bound(v_batch_pick_lict_code in varchar2,
                                               v_create_id            in varchar2,
                                               v_company_id           in varchar2);
  --新增 供应商色布出入库单supplier_color_in_out_bound
  procedure p_insert_supplier_color_in_out_bound(p_suppl_rec mrp.supplier_color_in_out_bound%rowtype);
  --新增 供应商坯布出入库单supplier_grey_in_out_bound
  procedure p_insert_supplier_grey_in_out_bound(p_suppl_rec mrp.supplier_grey_in_out_bound%rowtype);
  --新增 面料采购单t_fabric_purchase_sheet
  procedure p_insert_t_fabric_purchase_sheet(p_t_fab_rec mrp.t_fabric_purchase_sheet%rowtype);
  /*替换物料sku按钮逻辑*/
  procedure p_action_a_prematerial_420_1(v1_group_key               in varchar2,
                                         v1_mater_supplier_code     in varchar2,
                                         v1_unit                    in varchar2,
                                         v1_supplier_shades         in varchar2,
                                         v1_material_sku            in varchar2,
                                         v1_practical_door_with     in number,
                                         v1_gram_weight             in number,
                                         v1_material_specifications in varchar2,
                                         v_create_id                in varchar2,
                                         v1_po_company_id           in varchar2);

  /*从表替换物料sku按钮页面跳转——替换物料sku按钮逻辑*/
  procedure p_action_a_prematerial_422_1(v1_fabric_id               in varchar2,
                                         v1_mater_supplier_code     in varchar2,
                                         v1_unit                    in varchar2,
                                         v1_supplier_shades         in varchar2,
                                         v1_material_sku            in varchar2,
                                         v1_practical_door_with     in number,
                                         v1_gram_weight             in number,
                                         v1_material_specifications in varchar2,
                                         v_create_id                in varchar2,
                                         v1_po_company_id           in varchar2);
  --校验取消原因
  procedure p_check_cancel_reason(v_cancel_reason in varchar2);
  PROCEDURE p_fabric_purchase_sheet_group_key;
  /*记录日志mrp_log*/
  PROCEDURE p_mrp_log(v_create_id       IN VARCHAR2,
                      v_operate_content IN VARCHAR2,
                      v_operate         IN VARCHAR2,
                      v_class_name      IN VARCHAR2,
                      v_method_name     IN VARCHAR2,
                      v_thirdpart_id    IN VARCHAR2);

  -- 通过spu获取物料成分
  PROCEDURE P_GET_INGREDIENTS_BYSPU(PI_SPUID IN VARCHAR2,
                                    --pi_comapnyid IN VARCHAR2,
                                    PO_INGREDIENTS OUT VARCHAR2);
end pkg_bulk_cargo_bom;
/

CREATE OR REPLACE PACKAGE BODY MRP.pkg_bulk_cargo_bom IS

  /*大货bom单落表逻辑*/
  PROCEDURE p_bulk_cargo_bom(v_order_id   IN VARCHAR2,
                             v_barcode    IN VARCHAR2,
                             v_company_id IN VARCHAR2) IS
    ---p1_id                   varchar2(32);
    p2_id                   varchar2(32);
    v_count                 number;
    v_develop_bom_id        varchar2(32);
    v_develop_bom_change_id varchar2(32);
  begin
  
    for i in (select max(tor.order_code) order_code,
                     max(tor.deal_follower) deal_follower,
                     max(tor.company_id) company_id,
                     max(tor.create_time) create_time,
                     max(tc.rela_goo_id) rela_goo_id,
                     max(tc.cooperation_mode) cooperation_mode,
                     max(ts.supplier_info_id) supplier_info_id,
                     max(ccs.color_code) color_code,
                     max(tcc.commodity_color_code) commodity_color_code
                from scmdata.t_ordered tor
               inner join scmdata.t_ordersitem a
                  on tor.order_code = a.order_id
                 and tor.company_id = a.company_id
               inner join scmdata.t_commodity_color_size ccs
                  on a.barcode = ccs.barcode
                 and a.company_id = ccs.company_id
               inner join scmdata.t_commodity_color tcc
                  on tcc.commodity_info_id = ccs.commodity_info_id
                 and tcc.company_id = ccs.company_id
                 and tcc.color_code = ccs.color_code
               inner join scmdata.t_commodity_info tc
                  on tc.company_id = ccs.company_id
                 and tc.goo_id = ccs.goo_id
                left join scmdata.t_supplier_info ts
                  on ts.company_id = tor.company_id
                 and ts.supplier_code = tor.supplier_code
               where tor.order_code = v_order_id
                 and tor.company_id = v_company_id
                 and a.barcode = v_barcode
               group by ccs.goo_id, ccs.color_code, ccs.company_id) loop
      if i.cooperation_mode = 'ODM' then
        select max(develop_bom_id), max(develop_bom_change_id)
          into v_develop_bom_id, v_develop_bom_change_id
          from (select t.develop_bom_id, t.develop_bom_change_id
                  from PLM.ODM_DEVELOP_BOM t
                 where t.goods_skc_code = i.commodity_color_code
                   and t.create_supplier = i.supplier_info_id
                 order by develop_bom_status desc, create_time desc)
         where rownum = '1';
      elsif i.cooperation_mode = 'OEM' then
        select max(t1.version_code_corresponding_develop_bom_id),
               max(t1.develop_bom_change_id)
          into v_develop_bom_id, v_develop_bom_change_id
          from PLM.OEM_GOODS_DEVELOP_BOM_VERSION t1
         where t1.whether_current_version = '1'
           and t1.goods_skc_code = i.commodity_color_code;
      end if;
      if v_develop_bom_id > '0' then
        select count(*)
          into v_count
          from mrp.bulk_cargo_bom t
         where t.purchase_order_num = i.order_code
           and t.goods_skc = i.commodity_color_code;
        if v_count = '0' then
          p2_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'bulk_cargo_bom',
                                                  pi_column_name => 'bulk_cargo_bom_id',
                                                  pi_pre         => 'DB' ||
                                                                    substr(to_char(sysdate,
                                                                                   'yyyy'),
                                                                           3,
                                                                           2) ||
                                                                    to_char(sysdate,
                                                                            'MM') ||
                                                                    to_char(sysdate,
                                                                            'dd'),
                                                  pi_serail_num  => 5);
          insert into mrp.bulk_cargo_bom
            (company_id,
             bulk_cargo_bom_id,
             purchase_order_num,
             pro_supplier_code,
             goods_skc,
             develop_bom_id,
             develop_bom_change_id,
             create_id,
             create_time,
             UPDATE_ID,
             UPDATE_TIME,
             WHETHER_DEL)
          values
            (v_company_id,
             p2_id,
             i.order_code,
             i.supplier_info_id,
             i.commodity_color_code,
             v_develop_bom_id,
             v_develop_bom_change_id,
             i.deal_follower,
             i.create_time,
             'admin',
             sysdate,
             '0');
          mrp.pkg_bulk_cargo_bom.p_bulk_cargo_bom_material_detail(v_bom_id           => p2_id,
                                                                  v_cooperation_mode => i.cooperation_mode,
                                                                  v_company_id       => v_company_id);
        end if;
      end if;
    
    end loop;
  
  end p_bulk_cargo_bom;

  /*大货BOM单物料明细表落表逻辑*/
  PROCEDURE p_bulk_cargo_bom_material_detail(v_bom_id           IN VARCHAR2,
                                             v_cooperation_mode IN VARCHAR2,
                                             v_company_id       IN VARCHAR2) IS
  begin
    /*判断该条大货bom单是OEM还是ODM*/
    if v_cooperation_mode = 'ODM' then
    
      mrp.pkg_bulk_cargo_bom.p_mrp_odm_material(v_bom_id     => v_bom_id,
                                                v_company_id => v_company_id);
      /*      生成大货BOM单物料明细后,生成面料采购单*/
      mrp.pkg_bulk_cargo_bom.p_fabric_purchase_sheet(v_bom_id     => v_bom_id,
                                                     v_company_id => v_company_id);
    elsif v_cooperation_mode = 'OEM' then
      mrp.pkg_bulk_cargo_bom.p_mrp_oem_material(v_bom_id     => v_bom_id,
                                                v_company_id => v_company_id);
      /*      生成大货BOM单物料明细后,生成面料采购单*/
      mrp.pkg_bulk_cargo_bom.p_fabric_purchase_sheet(v_bom_id     => v_bom_id,
                                                     v_company_id => v_company_id);
    end if;
  
  end p_bulk_cargo_bom_material_detail;

  /*ODM----大货BOM单物料明细表落表逻辑*/
  procedure p_mrp_odm_material(v_bom_id     IN VARCHAR2,
                               v_company_id IN VARCHAR2) is
    p_id                      varchar2(32);
    v_material_spu            varchar2(32); --物料spu 
    v_color_picture_id        varchar2(32); --颜色图
    v_material_color          varchar2(32); --物料颜色 
    v_net_price_good          number(10, 2); --优选大货净价 
    v_per_meter_good          number(10, 2); --优选大货米价 
    v_benchmark_price         number(10, 2); --基准价 
    v_unit                    varchar2(6); --采购单位
    v_practical_door_with     number(10, 2); --实用门幅，单位厘米 
    v_gram_weight             number(6, 2); --克重，单位每平米 
    v_material_name           varchar2(64); --物料名称 
    v_material_specifications varchar2(32); --物料规格，为辅料时必填 
    v_purchase_per_unit       number(18, 4); --采购单件用量
    v_supplier_material_name  varchar2(50); --供应商物料名称 
    v_sku_abutment_code       varchar2(300); --供应商物料sku对接码 
    v_supplier_color          varchar2(150); --供应商颜色 
    v_supplier_shades         varchar2(30); --供应商色号 
    v_optimization            number(1); --是否优选 
    v_disparity               number(10, 2); --空差 
    v_good_quote              number(10, 2); --供应商大货报价 
    v_good_net_price          number(10, 2); --供应商大货净价 
    v2_picture_id             varchar2(64); --特征图
    v3_picture_id             varchar2(64); --色卡图
    v_material_ingredient_id  varchar2(2560); --成分信息id
  begin
    for i in (select t1.material_detail_id, --核价物料明细id 
                     t1.wnether_defect_material, --是否内部物料,0否1是  
                     t1.material_detail_serial_num, --物料明细序号 
                     t1.material_type, --物料类型 
                     t1.application_site, --应用部位 
                     t1.material_sku, --物料sku 
                     t1.defect_material_name, --缺失物料名称 
                     t1.fabric_supplier_code, --面料供应商编码 
                     t1.singleton_consumption, --单件用量 
                     t1.unit, --单位 
                     t1.whether_prepare_material, --是否备料 
                     t.pro_supplier_code
                from mrp.bulk_cargo_bom t
               inner join plm.odm_bom_material_detail t1
                  on t.develop_bom_id = t1.develop_bom_id
                 and t.bulk_cargo_bom_id = v_bom_id
                 and t.company_id = v_company_id
                 and t1.whether_del =0) loop
      /*  生成物料明细id*/
      p_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'bulk_cargo_bom_material_detail',
                                             pi_column_name => 'material_detail_id',
                                             pi_pre         => v_bom_id || 'WL',
                                             pi_serail_num  => 2);
      /*校验【是否内部物料】*/
      /*  外部物料*/
      if i.wnether_defect_material = '0' then
        /*查找外部物料SKU信息表*/
        select max(material_spu), --物料spu
               max(material_color), --物料颜色 
               max(preferred_net_price_of_large_good), --优选大货净价 
               max(preferred_per_meter_price_of_large_good), --优选大货米价 
               max(benchmark_price) --基准价 
          into v_material_spu,
               v_material_color,
               v_net_price_good,
               v_per_meter_good,
               v_benchmark_price
          from MRP.MRP_OUTSIDE_MATERIAL_SKU tm
         where tm.material_sku = i.material_sku;
        /*查找外部物料SPU信息表——颜色图*/
        select max(t.picture_id)
          into v_color_picture_id
          from MRP.MRP_PICTURE t
         where t.picture_type = '2'
           and t.thirdpart_id = i.material_sku;
      
        /*查找外部物料SPU信息表*/
        select max(unit), --单位 
               max(practical_door_with), --实用门幅，单位厘米 
               max(gram_weight), --克重，单位每平米 
               max(material_name), --物料名称 
               max(material_specifications) --物料规格，为辅料时必填 
          into v_unit,
               v_practical_door_with,
               v_gram_weight,
               v_material_name,
               v_material_specifications
          from MRP.MRP_OUTSIDE_MATERIAL_SPU tms
         where tms.material_spu = v_material_spu;
      
        /*采购单件用量_计算   
        校验【核价单位】与 【采购单位】是否相同
                  1.1 当相同时：【采购单件用量】= 【单件用量】
                  1.2 当不相同时：校验【是否内部物料】
                    a、当【是否内部物料】=是时，用【物料SPU】入参，在【内部物料SPU信息表】中找出对应【实用门幅】【克重】
                    b、当【是否内部物料】=否时，用【物料SPU】入参，在【外部物料SPU信息表】中找出对应【实用门幅】【克重】
                    c、当【采购单位】=公斤时，【采购单件用量】= 单件用量/[单件用量/[（实用门幅+5）/100]×（克重/1000）];红色部分先算
                    b、当【采购单位】= 罗时，【单件用量换算值】=单件用量/131.7*/
        /*  校验【核价单位】与 【采购单位】是否相同    */
        if v_unit = i.unit then
          v_purchase_per_unit := i.singleton_consumption;
        else
          if v_unit = '公斤' then
            v_purchase_per_unit := i.singleton_consumption /
                                   (i.singleton_consumption /
                                   ((v_practical_door_with + 5) / 100) *
                                   (v_gram_weight / 1000));
          elsif v_unit = '罗' then
            v_purchase_per_unit := i.singleton_consumption / 131.7;
          end if;
        end if;
        /*查找外部物料SPU信息表——特征图，物料spu*/
        select max(t.picture_id)
          into v2_picture_id
          from MRP.MRP_PICTURE t
         where t.picture_type = '1'
           and t.thirdpart_id = v_material_spu
           and rownum = 1;
        /*查找外部物料SPU信息表——成分信息*/
        mrp.pkg_bulk_cargo_bom.P_GET_INGREDIENTS_BYSPU(PI_SPUID       => v_material_spu,
                                                       PO_INGREDIENTS => v_material_ingredient_id);
      
        /*  select listagg(material_ingredient_id, ';') within group(order by t.material_spu)
         into v_material_ingredient_id
         from MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING t
        where t.material_spu = v_material_spu
        group by t.material_spu;*/
        /* 查找外部供应商物料信息表 */
        select max(supplier_material_name), --供应商物料名称 
               max(sku_abutment_code), --供应商物料sku对接码 
               max(supplier_color), --供应商颜色  
               max(supplier_shades), --供应商色号 
               max(optimization), --是否优选 
               max(disparity), --空差 
               max(supplier_large_good_quote), --供应商大货报价 
               max(supplier_large_good_net_price) --供应商大货净价 
          into v_supplier_material_name,
               v_sku_abutment_code,
               v_supplier_color,
               v_supplier_shades,
               v_optimization,
               v_disparity,
               v_good_quote,
               v_good_net_price
          from MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL t
         where t.material_sku = i.material_sku
           and t.supplier_code = i.fabric_supplier_code
           and t.create_finished_supplier_code = i.pro_supplier_code;
        /*查找外部物料SPU信息表——色卡图，物料spu*/
        select max(t.picture_id)
          into v3_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '3'
           and t.thirdpart_id = v_sku_abutment_code
         order by t.upload_time desc;
        /*  内部物料*/
      elsif i.wnether_defect_material = '1' then
        /*查找内部物料SKU信息表*/
        select max(material_spu), --物料spu
               max(material_color), --物料颜色 
               max(preferred_net_price_of_large_good), --优选大货净价 
               max(preferred_per_meter_price_of_large_good), --优选大货米价 
               max(benchmark_price) --基准价 
          into v_material_spu,
               v_material_color,
               v_net_price_good,
               v_per_meter_good,
               v_benchmark_price
          from MRP.MRP_INTERNAL_MATERIAL_SKU tm
         where tm.material_sku = i.material_sku;
        /*查找内部物料SPU信息表——颜色图*/
        select max(t.picture_id)
          into v_color_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '2'
           and t.thirdpart_id = i.material_sku;
      
        /*查找内部物料SPU信息表*/
        select max(unit), --单位 
               max(practical_door_with), --实用门幅，单位厘米 
               max(gram_weight), --克重，单位每平米 
               max(material_name), --物料名称 
               max(material_specifications) --物料规格，为辅料时必填 
          into v_unit,
               v_practical_door_with,
               v_gram_weight,
               v_material_name,
               v_material_specifications
          from MRP.MRP_INTERNAL_MATERIAL_SPU tms
         where tms.material_spu = v_material_spu;
      
        /*采购单件用量_计算   
        校验【核价单位】与 【采购单位】是否相同
                  1.1 当相同时：【采购单件用量】= 【单件用量】
                  1.2 当不相同时：校验【是否内部物料】
                    a、当【是否内部物料】=是时，用【物料SPU】入参，在【内部物料SPU信息表】中找出对应【实用门幅】【克重】
                    b、当【是否内部物料】=否时，用【物料SPU】入参，在【外部物料SPU信息表】中找出对应【实用门幅】【克重】
                    c、当【采购单位】=公斤时，【采购单件用量】= 单件用量/[单件用量/[（实用门幅+5）/100]×（克重/1000）];红色部分先算
                    b、当【采购单位】= 罗时，【单件用量换算值】=单件用量/131.7*/
        /*  校验【核价单位】与 【采购单位】是否相同    */
        if v_unit = i.unit then
          v_purchase_per_unit := i.singleton_consumption;
        else
          if v_unit = '公斤' then
            v_purchase_per_unit := i.singleton_consumption /
                                   (i.singleton_consumption /
                                   ((v_practical_door_with + 5) / 100) *
                                   (v_gram_weight / 1000));
          elsif v_unit = '罗' then
            v_purchase_per_unit := i.singleton_consumption / 131.7;
          end if;
        end if;
        /*查找内部物料SPU信息表——特征图，物料spu*/
        select max(t.picture_id)
          into v2_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '1'
           and t.thirdpart_id = v_material_spu
           and rownum = 1;
        /*查找内部物料SPU信息表——成分信息*/
        mrp.pkg_bulk_cargo_bom.P_GET_INGREDIENTS_BYSPU(PI_SPUID       => v_material_spu,
                                                       PO_INGREDIENTS => v_material_ingredient_id);
      
        /*  select listagg(material_ingredient_id, ';') within group(order by t.material_spu)
         into v_material_ingredient_id
         from MRP.MRP_MATERIAL_SPU_INGREDIENT_MAPPING t
        where t.material_spu = v_material_spu
        group by t.material_spu;*/
        /* 查找内部供应商物料信息表 */
        select max(supplier_material_name), --供应商物料名称 
               max(sku_abutment_code), --供应商物料sku对接码 
               max(supplier_color), --供应商颜色  
               max(supplier_shades), --供应商色号 
               max(optimization), --是否优选 
               max(disparity), --空差 
               max(supplier_large_good_quote), --供应商大货报价 
               max(supplier_large_good_net_price) --供应商大货净价 
          into v_supplier_material_name,
               v_sku_abutment_code,
               v_supplier_color,
               v_supplier_shades,
               v_optimization,
               v_disparity,
               v_good_quote,
               v_good_net_price
          from MRP.MRP_INTERNAL_SUPPLIER_MATERIAL t
         where t.material_sku = i.material_sku
           and t.supplier_code = i.fabric_supplier_code;
        /*查找内部物料SPU信息表——色卡图，物料spu*/
        select max(t.picture_id)
          into v3_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '3'
           and t.thirdpart_id = v_sku_abutment_code
         order by t.upload_time desc;
      end if;
      insert into mrp.bulk_cargo_bom_material_detail
        (pk_id,
         company_id,
         bulk_cargo_bom_id,
         material_detail_id,
         relate_develop_bom_material_detail_id,
         whether_inner_mater,
         material_detail_no,
         material_type,
         application_site,
         material_sku,
         defect_material_name,
         mater_supplier_code,
         consumption,
         examine_unit,
         whether_prepare,
         purchase_unit,
         purchase_consumption,
         material_spu,
         features,
         material_name,
         ingredients,
         practical_door_with,
         gram_weight,
         material_specifications,
         color_picture,
         material_color,
         preferred_net_price_of_large_good,
         preferred_per_meter_price_of_large_good,
         benchmark_price,
         supplier_material_name,
         color_card_picture,
         sku_abutment_code,
         supplier_color,
         supplier_shades,
         optimization,
         disparity,
         supplier_large_good_quote,
         supplier_large_good_net_price,
         create_id,
         create_time)
      values
        (mrp.pkg_plat_comm.f_get_uuid(),
         v_company_id,
         v_bom_id,
         p_id,
         i.material_detail_id,
         i.wnether_defect_material,
         i.material_detail_serial_num,
         i.material_type,
         i.application_site,
         i.material_sku,
         i.defect_material_name,
         i.fabric_supplier_code,
         i.singleton_consumption,
         i.unit,
         i.whether_prepare_material,
         v_unit,
         v_purchase_per_unit,
         v_material_spu,
         v2_picture_id,
         v_material_name,
         v_material_ingredient_id,
         v_practical_door_with,
         v_gram_weight,
         v_material_specifications,
         v_color_picture_id,
         v_material_color,
         v_net_price_good,
         v_per_meter_good,
         v_benchmark_price,
         v_supplier_material_name,
         v3_picture_id,
         v_sku_abutment_code,
         v_supplier_color,
         v_supplier_shades,
         v_optimization,
         v_disparity,
         v_good_quote,
         v_good_net_price,
         'admin',
         sysdate);
    end loop;
  end p_mrp_odm_material;

  /*OEM----大货BOM单物料明细表落表逻辑*/
  procedure p_mrp_oem_material(v_bom_id     IN VARCHAR2,
                               v_company_id IN VARCHAR2) is
    p_id                      varchar2(32);
    v_material_spu            varchar2(32); --物料spu 
    v_color_picture_id        varchar2(32); --颜色图
    v_material_color          varchar2(32); --物料颜色 
    v_net_price_good          number(10, 2); --优选大货净价 
    v_per_meter_good          number(10, 2); --优选大货米价 
    v_benchmark_price         number(10, 2); --基准价 
    v_unit                    varchar2(6); --采购单位
    v_practical_door_with     number(10, 2); --实用门幅，单位厘米 
    v_gram_weight             number(6, 2); --克重，单位每平米 
    v_material_name           varchar2(64); --物料名称 
    v_material_specifications varchar2(32); --物料规格，为辅料时必填 
    v_purchase_per_unit       number(18, 4); --采购单件用量
    v_supplier_material_name  varchar2(50); --供应商物料名称 
    v_sku_abutment_code       varchar2(300); --供应商物料sku对接码 
    v_supplier_color          varchar2(150); --供应商颜色 
    v_supplier_shades         varchar2(30); --供应商色号 
    v_optimization            number(1); --是否优选 
    v_disparity               number(10, 2); --空差 
    v_good_quote              number(10, 2); --供应商大货报价 
    v_good_net_price          number(10, 2); --供应商大货净价 
    v2_picture_id             varchar2(64); --特征图
    v3_picture_id             varchar2(64); --色卡图
    v_material_ingredient_id  varchar2(2560); --成分信息id
  begin
    for i in (select t1.material_detail_id, --核价物料明细id 
                     t1.wnether_defect_material, --是否内部物料,0否1是  
                     t1.material_detail_serial_num, --物料明细序号 
                     t1.material_type, --物料类型 
                     t1.application_site, --应用部位 
                     t1.material_sku, --物料sku 
                     t1.defect_material_name, --缺失物料名称 
                     t1.fabric_supplier_code, --面料供应商编码 
                     t1.singleton_consumption, --单件用量 
                     t1.unit, --单位 
                     t1.whether_prepare_material, --是否备料 
                     t.pro_supplier_code
                from mrp.bulk_cargo_bom t
               inner join plm.oem_bom_material_detail t1
                  on t.develop_bom_id = t1.develop_bom_id
                 and t.bulk_cargo_bom_id = v_bom_id
                 and t.company_id = v_company_id
                 and t1.whether_del=0) loop
      /*  生成物料明细id*/
      p_id := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'bulk_cargo_bom_material_detail',
                                             pi_column_name => 'material_detail_id',
                                             pi_pre         => v_bom_id || 'WL',
                                             pi_serail_num  => 2);
      /*校验【是否内部物料】*/
      /*  外部物料*/
      if i.wnether_defect_material = '0' then
        /*查找外部物料SKU信息表*/
        select max(material_spu), --物料spu
               max(material_color), --物料颜色 
               max(preferred_net_price_of_large_good), --优选大货净价 
               max(preferred_per_meter_price_of_large_good), --优选大货米价 
               max(benchmark_price) --基准价 
          into v_material_spu,
               v_material_color,
               v_net_price_good,
               v_per_meter_good,
               v_benchmark_price
          from MRP.MRP_OUTSIDE_MATERIAL_SKU tm
         where tm.material_sku = i.material_sku;
        /*查找外部物料SPU信息表——颜色图*/
        select max(t.picture_id)
          into v_color_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '2'
           and t.thirdpart_id = i.material_sku;
      
        /*查找外部物料SPU信息表*/
        select max(unit), --单位 
               max(practical_door_with), --实用门幅，单位厘米 
               max(gram_weight), --克重，单位每平米 
               max(material_name), --物料名称 
               max(material_specifications) --物料规格，为辅料时必填 
          into v_unit,
               v_practical_door_with,
               v_gram_weight,
               v_material_name,
               v_material_specifications
          from MRP.MRP_OUTSIDE_MATERIAL_SPU tms
         where tms.material_spu = v_material_spu;
      
        /*采购单件用量_计算   
        校验【核价单位】与 【采购单位】是否相同
                  1.1 当相同时：【采购单件用量】= 【单件用量】
                  1.2 当不相同时：校验【是否内部物料】
                    a、当【是否内部物料】=是时，用【物料SPU】入参，在【内部物料SPU信息表】中找出对应【实用门幅】【克重】
                    b、当【是否内部物料】=否时，用【物料SPU】入参，在【外部物料SPU信息表】中找出对应【实用门幅】【克重】
                    c、当【采购单位】=公斤时，【采购单件用量】= 单件用量/[单件用量/[（实用门幅+5）/100]×（克重/1000）];红色部分先算
                    b、当【采购单位】= 罗时，【单件用量换算值】=单件用量/131.7*/
        /*  校验【核价单位】与 【采购单位】是否相同    */
        if v_unit = i.unit then
          v_purchase_per_unit := i.singleton_consumption;
        else
          if v_unit = '公斤' then
            v_purchase_per_unit := i.singleton_consumption /
                                   (i.singleton_consumption /
                                   ((v_practical_door_with + 5) / 100) *
                                   (v_gram_weight / 1000));
          elsif v_unit = '罗' then
            v_purchase_per_unit := i.singleton_consumption / 131.7;
          end if;
        end if;
        /*查找外部物料SPU信息表——特征图，物料spu*/
        select max(t.picture_id)
          into v2_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '1'
           and t.thirdpart_id = v_material_spu
           and rownum = 1;
        /*查找外部物料SPU信息表——成分信息*/
        mrp.pkg_bulk_cargo_bom.P_GET_INGREDIENTS_BYSPU(PI_SPUID       => v_material_spu,
                                                       PO_INGREDIENTS => v_material_ingredient_id);
      
        /*     select listagg(material_ingredient_id, ';') within group(order by t.material_spu)
         into v_material_ingredient_id
         from MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING t
        where t.material_spu = v_material_spu
        group by t.material_spu;*/
        /* 查找外部供应商物料信息表 */
        select max(supplier_material_name), --供应商物料名称 
               max(sku_abutment_code), --供应商物料sku对接码 
               max(supplier_color), --供应商颜色  
               max(supplier_shades), --供应商色号 
               max(optimization), --是否优选 
               max(disparity), --空差 
               max(supplier_large_good_quote), --供应商大货报价 
               max(supplier_large_good_net_price) --供应商大货净价 
          into v_supplier_material_name,
               v_sku_abutment_code,
               v_supplier_color,
               v_supplier_shades,
               v_optimization,
               v_disparity,
               v_good_quote,
               v_good_net_price
          from MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL t
         where t.material_sku = i.material_sku
           and t.supplier_code = i.fabric_supplier_code
           and t.create_finished_supplier_code = i.pro_supplier_code;
        /*查找外部物料SPU信息表——色卡图，物料spu*/
        select max(t.picture_id)
          into v3_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '3'
           and t.thirdpart_id = v_sku_abutment_code
         order by t.upload_time desc;
        /*  内部物料*/
      elsif i.wnether_defect_material = '1' then
        /*查找内部物料SKU信息表*/
        select max(material_spu), --物料spu
               max(material_color), --物料颜色 
               max(preferred_net_price_of_large_good), --优选大货净价 
               max(preferred_per_meter_price_of_large_good), --优选大货米价 
               max(benchmark_price) --基准价 
          into v_material_spu,
               v_material_color,
               v_net_price_good,
               v_per_meter_good,
               v_benchmark_price
          from MRP.MRP_INTERNAL_MATERIAL_SKU tm
         where tm.material_sku = i.material_sku;
        /*查找内部物料SPU信息表——颜色图*/
        select max(t.picture_id)
          into v_color_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '2'
           and t.thirdpart_id = i.material_sku;
      
        /*查找内部物料SPU信息表*/
        select max(unit), --单位 
               max(practical_door_with), --实用门幅，单位厘米 
               max(gram_weight), --克重，单位每平米 
               max(material_name), --物料名称 
               max(material_specifications) --物料规格，为辅料时必填 
          into v_unit,
               v_practical_door_with,
               v_gram_weight,
               v_material_name,
               v_material_specifications
          from MRP.MRP_INTERNAL_MATERIAL_SPU tms
         where tms.material_spu = v_material_spu;
      
        /*采购单件用量_计算   
        校验【核价单位】与 【采购单位】是否相同
                  1.1 当相同时：【采购单件用量】= 【单件用量】
                  1.2 当不相同时：校验【是否内部物料】
                    a、当【是否内部物料】=是时，用【物料SPU】入参，在【内部物料SPU信息表】中找出对应【实用门幅】【克重】
                    b、当【是否内部物料】=否时，用【物料SPU】入参，在【外部物料SPU信息表】中找出对应【实用门幅】【克重】
                    c、当【采购单位】=公斤时，【采购单件用量】= 单件用量/[单件用量/[（实用门幅+5）/100]×（克重/1000）];红色部分先算
                    b、当【采购单位】= 罗时，【单件用量换算值】=单件用量/131.7*/
        /*  校验【核价单位】与 【采购单位】是否相同    */
        if v_unit = i.unit then
          v_purchase_per_unit := i.singleton_consumption;
        else
          if v_unit = '公斤' then
            v_purchase_per_unit := i.singleton_consumption /
                                   (i.singleton_consumption /
                                   ((v_practical_door_with + 5) / 100) *
                                   (v_gram_weight / 1000));
          elsif v_unit = '罗' then
            v_purchase_per_unit := i.singleton_consumption / 131.7;
          end if;
        end if;
        /*查找内部物料SPU信息表——特征图，物料spu*/
        select max(t.picture_id)
          into v2_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '1'
           and t.thirdpart_id = v_material_spu
           and rownum = 1;
        /*查找内部物料SPU信息表——成分信息*/
        mrp.pkg_bulk_cargo_bom.P_GET_INGREDIENTS_BYSPU(PI_SPUID       => v_material_spu,
                                                       PO_INGREDIENTS => v_material_ingredient_id);
      
        /*   select listagg(material_ingredient_id, ';') within group(order by t.material_spu)
         into v_material_ingredient_id
         from MRP.MRP_MATERIAL_SPU_INGREDIENT_MAPPING t
        where t.material_spu = v_material_spu
        group by t.material_spu;*/
        /* 查找内部供应商物料信息表 */
        select max(supplier_material_name), --供应商物料名称 
               max(sku_abutment_code), --供应商物料sku对接码 
               max(supplier_color), --供应商颜色  
               max(supplier_shades), --供应商色号 
               max(optimization), --是否优选 
               max(disparity), --空差 
               max(supplier_large_good_quote), --供应商大货报价 
               max(supplier_large_good_net_price) --供应商大货净价 
          into v_supplier_material_name,
               v_sku_abutment_code,
               v_supplier_color,
               v_supplier_shades,
               v_optimization,
               v_disparity,
               v_good_quote,
               v_good_net_price
          from MRP.MRP_INTERNAL_SUPPLIER_MATERIAL t
         where t.material_sku = i.material_sku
           and t.supplier_code = i.fabric_supplier_code;
        /*查找内部物料SPU信息表——色卡图，物料spu*/
        select max(t.picture_id)
          into v3_picture_id
          from mrp.MRP_PICTURE t
         where t.picture_type = '3'
           and t.thirdpart_id = v_sku_abutment_code
         order by t.upload_time desc;
      end if;
      insert into mrp.bulk_cargo_bom_material_detail
        (pk_id,
         company_id,
         bulk_cargo_bom_id,
         material_detail_id,
         relate_develop_bom_material_detail_id,
         whether_inner_mater,
         material_detail_no,
         material_type,
         application_site,
         material_sku,
         defect_material_name,
         mater_supplier_code,
         consumption,
         examine_unit,
         whether_prepare,
         purchase_unit,
         purchase_consumption,
         material_spu,
         features,
         material_name,
         ingredients,
         practical_door_with,
         gram_weight,
         material_specifications,
         color_picture,
         material_color,
         preferred_net_price_of_large_good,
         preferred_per_meter_price_of_large_good,
         benchmark_price,
         supplier_material_name,
         color_card_picture,
         sku_abutment_code,
         supplier_color,
         supplier_shades,
         optimization,
         disparity,
         supplier_large_good_quote,
         supplier_large_good_net_price,
         create_id,
         create_time)
      values
        (mrp.pkg_plat_comm.f_get_uuid(),
         v_company_id,
         v_bom_id,
         p_id,
         i.material_detail_id,
         i.wnether_defect_material,
         i.material_detail_serial_num,
         i.material_type,
         i.application_site,
         i.material_sku,
         i.defect_material_name,
         i.fabric_supplier_code,
         i.singleton_consumption,
         i.unit,
         i.whether_prepare_material,
         v_unit,
         v_purchase_per_unit,
         v_material_spu,
         v2_picture_id,
         v_material_name,
         v_material_ingredient_id,
         v_practical_door_with,
         v_gram_weight,
         v_material_specifications,
         v_color_picture_id,
         v_material_color,
         v_net_price_good,
         v_per_meter_good,
         v_benchmark_price,
         v_supplier_material_name,
         v3_picture_id,
         v_sku_abutment_code,
         v_supplier_color,
         v_supplier_shades,
         v_optimization,
         v_disparity,
         v_good_quote,
         v_good_net_price,
         'admin',
         sysdate);
    end loop;
  end p_mrp_oem_material;

  /*领料单表落表逻辑*/
  procedure p_pick_list(v_product_gress_code in varchar2,
                        v_company_id         in varchar2) is
    v_order_code   varchar2(32);
    v_fabric_id    varchar2(32);
    v_pid          varchar2(32);
    v_order_amount number(11, 2);
    v_amount       number(11, 2);
  begin
    select max(t.order_code)
      into v_order_code
      from scmdata.t_ordered t
     where t.is_product_order = '1'
       and t.order_code = v_product_gress_code
       and t.company_id = v_company_id;
    if v_order_code is not null or v_order_code <> '0' then
      for ei in (select t.bulk_cargo_bom_id,
                        t.company_id,
                        t.pro_supplier_code,
                        t.goods_skc,
                        t.create_id,
                        t.create_time
                   from mrp.bulk_cargo_bom t
                  where t.purchase_order_num = v_product_gress_code
                    and t.company_id = v_company_id) loop
        /*采购skc订单量*/
        select sum(a.order_amount)
          into v_order_amount
          from scmdata.t_ordersitem a
         inner join scmdata.t_commodity_color_size ccs
            on a.barcode = ccs.barcode
           and a.company_id = ccs.company_id
         inner join scmdata.t_commodity_color tc
            on tc.company_id = ccs.company_id
           and tc.color_code = ccs.color_code
           and tc.goo_id = ccs.goo_id
         where a.order_id = v_product_gress_code
           and a.company_id = v_company_id
           and commodity_color_code = ei.goods_skc
         group by commodity_color_code;
        for eii in (select *
                      from mrp.bulk_cargo_bom_material_detail t1
                     where t1.bulk_cargo_bom_id = ei.bulk_cargo_bom_id
                       and t1.company_id = ei.company_id
                       and not exists(select 1 from mrp.pick_list tp
                             where tp.material_detail_id = t1.material_detail_id)) loop
          /*是否备料*/
          if eii.whether_prepare = '1' and eii.material_sku is not null then
            /*建议领料量*/
            v_amount := v_order_amount * eii.purchase_consumption;
            v_pid    := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'PICK_LIST',
                                                       pi_column_name => 'pick_lict_code',
                                                       pi_pre         => 'MLL' || to_char(sysdate,'YYYYMMDD'),
                                                       pi_serail_num  => 5);
            /*是否内部物料*/
            if eii.whether_inner_mater = '1' then
              /*判断面料采购单是否存在物料明细ID,且来源是品牌采购单的单，存在则不生成【领料单】*/
              select max(tf.fabric_id)
                into v_fabric_id
                from mrp.t_fabric_purchase_sheet tf
               where tf.fabric_source = '0'
                 and tf.material_detail_id = eii.material_detail_id;
              if v_fabric_id is null then
                insert into mrp.pick_list
                  (pick_lict_code,
                   pick_status,
                   pick_source,
                   pro_supplier_code,
                   mater_supplier_code,
                   material_sku,
                   whether_inner_mater,
                   unit,
                   purchase_skc_order_num,
                   suggest_pick_num,
                   pick_num,
                   pick_percent,
                   unpick_num,
                   relate_product_order_num,
                   relate_skc,
                   bulk_cargo_bom_id,
                   material_detail_id,
                   company_id,
                   create_id,
                   create_time,
                   update_id,
                   update_time,
                   whether_del,
                   pick_id,
                   pick_time,
                   cancel_id,
                   cancel_time,
                   cancel_reason)
                values
                  (v_pid,
                   '0', --领料状态，0待完成，1已完成，2已取消 
                   '0', --领料单来源 
                   ei.pro_supplier_code,
                   eii.mater_supplier_code,
                   eii.material_sku,
                   eii.whether_inner_mater,
                   eii.purchase_unit,
                   v_order_amount, --采购skc订单量 
                   v_amount, --建议领料量 
                   '0', --已领料量 
                   '0', --已领料百分比 
                   v_amount, --未领料量 
                   v_product_gress_code, --订单号
                   ei.goods_skc,
                   eii.bulk_cargo_bom_id,
                   eii.material_detail_id,
                   v_company_id,
                   ei.create_id,
                   ei.create_time,
                   'ADMIN',
                   sysdate,
                   '0', --是否删除，0否1是  
                   '', --领料人 
                   '', --领料时间 
                   '', --取消人  
                   '', --取消日期 
                   '');
            --记录操作日志
            scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_company_id,
                                                        p_apply_module       => 'a_prematerial_301',
                                                        p_apply_module_desc  => '领料任务',
                                                        p_base_table         => 'PICK_LIST',
                                                        p_apply_pk_id        => v_pid,
                                                        p_action_type        => 'INSERT',
                                                        p_log_dict_type      => 'PICK_LIST_LOG',
                                                        p_log_type           => '02',
                                                        p_log_msg            => '新建领料单:' ||
                                                                                v_pid,
                                                        p_operate_field      => 'PICK_LICT_CODE',
                                                        p_field_type         => 'VARCHAR2',
                                                        p_field_desc         => '领料单',
                                                        p_old_code           => '0',
                                                        p_new_code           => v_pid,
                                                        p_old_value          => '0',
                                                        p_new_value          => v_pid,
                                                        p_operate_company_id => v_company_id,
                                                        p_user_id            => ei.create_id,
                                                        p_type               => '2');
              end if;
            else
              /*      生成【领料单】  */
              insert into mrp.pick_list
                (pick_lict_code,
                 pick_status,
                 pick_source,
                 pro_supplier_code,
                 mater_supplier_code,
                 material_sku,
                 whether_inner_mater,
                 unit,
                 purchase_skc_order_num,
                 suggest_pick_num,
                 pick_num,
                 pick_percent,
                 unpick_num,
                 relate_product_order_num,
                 relate_skc,
                 bulk_cargo_bom_id,
                 material_detail_id,
                 company_id,
                 create_id,
                 create_time,
                 update_id,
                 update_time,
                 whether_del,
                 pick_id,
                 pick_time,
                 cancel_id,
                 cancel_time,
                 cancel_reason)
              values
                (v_pid,
                 '0',
                 '0',
                 ei.pro_supplier_code,
                 eii.mater_supplier_code,
                 eii.material_sku,
                 eii.whether_inner_mater,
                 eii.purchase_unit,
                 v_order_amount, --采购skc订单量 
                 v_amount, --建议领料量 
                 '0',
                 '0',
                 v_amount,
                 v_product_gress_code, --订单号
                 ei.goods_skc,
                 eii.bulk_cargo_bom_id,
                 eii.material_detail_id,
                 v_company_id,
                 ei.create_id,
                 ei.create_time,
                 'ADMIN',
                 sysdate,
                 '0',
                 '',
                 '',
                 '',
                 '',
                 '');
            --记录操作日志
            scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_company_id,
                                                        p_apply_module       => 'a_prematerial_301',
                                                        p_apply_module_desc  => '领料任务',
                                                        p_base_table         => 'PICK_LIST',
                                                        p_apply_pk_id        => v_pid,
                                                        p_action_type        => 'INSERT',
                                                        p_log_dict_type      => 'PICK_LIST_LOG',
                                                        p_log_type           => '02',
                                                        p_log_msg            => '新建领料单:' ||
                                                                                v_pid,
                                                        p_operate_field      => 'PICK_LICT_CODE',
                                                        p_field_type         => 'VARCHAR2',
                                                        p_field_desc         => '领料单',
                                                        p_old_code           => '0',
                                                        p_new_code           => v_pid,
                                                        p_old_value          => '0',
                                                        p_new_value          => v_pid,
                                                        p_operate_company_id => v_company_id,
                                                        p_user_id            => ei.create_id,
                                                        p_type               => '2');
            end if;
          end if;
        end loop;
      end loop;
    end if;
  end p_pick_list;

  /*面料采购单表落表逻辑*/
  PROCEDURE p_fabric_purchase_sheet(v_bom_id     IN VARCHAR2,
                                    v_company_id IN VARCHAR2) IS
    v_pro_supplier_code  varchar2(32);
    v_purchase_order_num varchar2(32);
    v_goods_skc          varchar2(32);
    v_create_id          varchar2(32);
    v_create_time        date;
    v_total_stock        number(18, 2);
    v_pid                varchar2(32);
    v_order_amount       number(11, 2);
    v_amount             number(11, 2);
    v_is_product_order   number(1);
  begin
    select max(tb.pro_supplier_code),
           max(tb.purchase_order_num),
           max(tb.goods_skc),
           max(tb.create_id),
           max(tb.create_time)
      into v_pro_supplier_code,
           v_purchase_order_num,
           v_goods_skc,
           v_create_id,
           v_create_time
      from mrp.bulk_cargo_bom tb
     where tb.bulk_cargo_bom_id = v_bom_id
       and tb.company_id = v_company_id;
    select max(t.is_product_order)
      into v_is_product_order
      from scmdata.t_ordered t
     where t.order_code = v_purchase_order_num
       and t.company_id = v_company_id;
    if v_is_product_order = 1 then
    
      for ei in (select *
                   from mrp.bulk_cargo_bom_material_detail t1
                  where t1.bulk_cargo_bom_id = v_bom_id
                    and t1.company_id = v_company_id) loop
        /*b.1 当【大货BOM单物料明细-是否备料】=否时，不生成【面辅料采购单】*/
        if ei.whether_prepare = '1' and ei.material_sku is not null then
          /*b.2 当【大货BOM单物料明细-是否内部物料】= 否 或 【大货BOM单物料明细-物料SKU】= 空值时，不生成【面辅料采购单】*/
          if ei.whether_inner_mater = '1' then
            select max(t.total_stock)
              into v_total_stock
              from mrp.SUPPLIER_COLOR_CLOTH_STOCK t
             where t.material_sku = ei.material_sku
               and t.pro_supplier_code = v_pro_supplier_code
               and t.mater_supplier_code = ei.mater_supplier_code
               and t.unit = ei.purchase_unit;
            if v_total_stock = 0 or v_total_stock is null then
              v_pid := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 't_fabric_purchase_sheet',
                                                      pi_column_name => 'fabric_id',
                                                      pi_pre         => 'MCG' ||TO_CHAR(SYSDATE,'yyyymmdd'),
                                                      pi_serail_num  => 5);
              /*采购skc订单量*/
              select sum(a.order_amount)
                into v_order_amount
                from scmdata.t_ordersitem a
               inner join scmdata.t_commodity_color_size ccs
                  on a.barcode = ccs.barcode
                 and a.company_id = ccs.company_id
               inner join scmdata.t_commodity_color tc
                  on tc.company_id = ccs.company_id
                 and tc.color_code = ccs.color_code
                 and tc.goo_id = ccs.goo_id
               where a.order_id = v_purchase_order_num
                 and a.company_id = v_company_id
                 and commodity_color_code = v_goods_skc
               group by commodity_color_code;
              /*建议采购量*/
              v_amount := v_order_amount * nvl(ei.purchase_consumption,0);
            
              insert into mrp.t_fabric_purchase_sheet
                (fabric_purchase_sheet_id,
                 company_id,
                 fabric_id,
                 fabric_status,
                 fabric_source,
                 pro_supplier_code,
                 material_sku,
                 mater_supplier_code,
                 whether_inner_mater,
                 unit,
                 purchase_skc_order_amount,
                 suggest_pick_amount,
                 actual_pick_amount,
                 already_deliver_amount,
                 not_deliver_amount,
                 delivery_amount,
                 purchase_order_num,
                 goods_skc,
                 bulk_cargo_bom_id,
                 material_detail_id,
                 material_spu,
                 features,
                 material_name,
                 ingredients,
                 practical_door_with,
                 gram_weight,
                 material_specifications,
                 color_picture,
                 material_color,
                 preferred_net_price_of_large_good,
                 preferred_per_meter_price_of_large_good,
                 benchmark_price,
                 sku_abutment_code,
                 supplier_material_name,
                 color_card_picture,
                 supplier_color,
                 supplier_shades,
                 optimization,
                 disparity,
                 supplier_large_good_quote,
                 supplier_large_good_net_price,
                 create_id,
                 create_time,
                 order_id,
                 order_time,
                 receive_order_id,
                 receive_order_time,
                 send_order_id,
                 send_order_time,
                 cancel_id,
                 cancel_time,
                 cancel_cause,
                 remarks)
              values
                (mrp.pkg_plat_comm.f_get_uuid(),
                 v_company_id,
                 v_pid,
                 'S01',
                 '0',
                 v_pro_supplier_code,
                 ei.material_sku,
                 ei.mater_supplier_code,
                 ei.whether_inner_mater,
                 ei.purchase_unit,
                 v_order_amount, --采购skc订单量  
                 v_amount, --建议采购量 
                 v_amount, --实际采购量 
                 '0', --已发货量 
                 v_amount, --未发货量 
                 '', --已收货量 
                 v_purchase_order_num,
                 v_goods_skc,
                 ei.bulk_cargo_bom_id,
                 ei.material_detail_id,
                 ei.material_spu,
                 ei.features,
                 ei.material_name,
                 ei.ingredients,
                 ei.practical_door_with,
                 ei.gram_weight,
                 ei.material_specifications,
                 ei.color_picture,
                 ei.material_color,
                 ei.preferred_net_price_of_large_good,
                 ei.preferred_per_meter_price_of_large_good,
                 ei.benchmark_price,
                 ei.sku_abutment_code,
                 ei.supplier_material_name,
                 ei.color_card_picture,
                 ei.supplier_color,
                 trim(ei.supplier_shades),
                 ei.optimization,
                 ei.disparity,
                 ei.supplier_large_good_quote,
                 ei.supplier_large_good_net_price,
                 v_create_id, --创建人id 
                 v_create_time, --创建时间 
                 v_create_id, --下单人id 
                 v_create_time, --下单时间 
                 '', --接单人id 
                 '', --接单时间 
                 '', --发货人id 
                 '', --发货人时间 
                 '', --取消人id 
                 '', --取消人时间 
                 '', --取消人原因 
                 '' --备注 
                 );
              ---select * from mrp.t_fabric_purchase_sheet t;
              ---同步v_group_key 伪主键字段
              mrp.pkg_bulk_cargo_bom.p_fabric_purchase_sheet_group_key;
              --记录操作日志
    --记录操作来源
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => v_company_id,
                                               p_document_id             => v_pid,
                                               p_data_source_parent_code => 'FABRIC_SHEET_LOG',
                                               p_data_source_child_code  => '00',
                                               p_operate_company_id      => v_company_id,
                                               p_user_id                 => v_create_id);

 /*             scmdata.pkg_plat_log.p_sync_record_plat_log(p_company_id         => v_company_id,
                                                          p_apply_module       => 'a_prematerial_411',
                                                          p_apply_module_desc  => '面辅料采购',
                                                          p_base_table         => 't_fabric_purchase_sheet',
                                                          p_apply_pk_id        => v_pid,
                                                          p_action_type        => 'INSERT',
                                                          p_log_dict_type      => 'FABRIC_SHEET_LOG',
                                                          p_log_type           => '00',
                                                          p_log_msg            => '采购单来源=品牌采购单',
                                                          p_operate_field      => 'FABRIC_ID',
                                                          p_field_type         => 'VARCHAR2',
                                                          p_field_desc         => '面料采购单号',
                                                          p_old_code           => '',
                                                          p_new_code           => v_pid,
                                                          p_old_value          => '',
                                                          p_new_value          => v_pid,
                                                          p_operate_company_id => v_company_id,
                                                          p_user_id            => v_create_id,
                                                          p_type               => '0');*/
            end if;
          end if;
        end if;
      end loop;
    end if;
  end p_fabric_purchase_sheet;

  /*分批领料单表落表逻辑
  部分领料单更新逻辑*/
  PROCEDURE p_pick_list_batch(material_num     in varchar2,
                              if_all_material  in number,
                              v_pick_lict_code in varchar2,
                              v_user_id        in varchar2,
                              v_item           in varchar2, --操作item
                              v_opr_com        in varchar2 --操作人企业
                              ) IS
    v_material_num varchar2(64) := material_num;
    v_pick_percent number(5, 2); --领料量百分比
    v_pid          varchar2(32); --分批领料号
    v_num1         number(9, 2); ---本次领料量
    --vo_log_id      varchar2(32);
    v_num          number(9, 2);
    ---v1_pick_lict_code varchar2(32);
  begin
    ---分批领料落表
    /*当【完成全部领料单】=是时*/
    if if_all_material = '1' then
      for ei in (select t.pick_lict_code,
                        t.company_id,
                        t.pick_num,
                        t.suggest_pick_num,
                        t.unpick_num,
                        t.unit,
                        (v_material_num * t.unpick_num) / sum(t.unpick_num) over(partition by 1) total_unpicknum
                   from mrp.pick_list t
                  where t.pick_lict_code in
                        (select regexp_substr(v_pick_lict_code,
                                              '[^;]+',
                                              1,
                                              level,
                                              'i') pick_lict_code
                           from dual
                         connect by level <=
                                    length(v_pick_lict_code) -
                                    length(regexp_replace(v_pick_lict_code,
                                                          ';',
                                                          '')) + 1)) loop
        v_pick_percent := round(ei.total_unpicknum / ei.suggest_pick_num * 100,
                                2);
        v_pid          := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'pick_list_batch',
                                                         pi_column_name => 'batch_pick_lict_code',
                                                         pi_pre         => ei.pick_lict_code,
                                                         pi_serail_num  => 2);
        --生成分批领料单
        insert into mrp.pick_list_batch
          (batch_pick_lict_code,
           pick_lict_code,
           batch_time,
           unit,
           batch_pick_num,
           batch_pick_percent,
           batch_pick_id)
        values
          (v_pid,
           ei.pick_lict_code,
           sysdate,
           ei.unit,
           ei.total_unpicknum,
           v_pick_percent,
           v_user_id);
        /*更新领料表*/
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => ei.company_id,
                                               p_document_id             => ei.pick_lict_code,
                                               p_data_source_parent_code => 'PICK_LIST_LOG',
                                               p_data_source_child_code  => '00',
                                               p_operate_company_id      => v_opr_com,
                                               p_user_id                 => v_user_id);
        update mrp.pick_list t
           set t.pick_status = '1',
               t.pick_num    = nvl(ei.pick_num, 0) +
                               nvl(ei.total_unpicknum, 0),
               pick_percent =
               (nvl(ei.pick_num, 0) + nvl(ei.total_unpicknum, 0)) /
               ei.suggest_pick_num * 100,
               unpick_num    = '0',
               pick_id       = v_user_id,
               pick_time     = sysdate
         where t.pick_lict_code = ei.pick_lict_code;
        v_num := nvl(ei.total_unpicknum, 0);
        --v1_pick_lict_code := ei.pick_lict_code;
       -- vo_log_id := '';
        --记录操作日志

/*        SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => ei.company_id,
                                               P_APPLY_MODULE       => v_item,
                                               P_BASE_TABLE         => 'PICK_LIST',
                                               P_APPLY_PK_ID        => ei.pick_lict_code,
                                               P_ACTION_TYPE        => 'UPDATE',
                                               P_LOG_ID             => vo_log_id,
                                               P_LOG_TYPE           => '00',
                                               P_LOG_MSG            => '操作【领料出库】，本次领料量=' ||
                                                                       v_num ||
                                                                       '，领料状态=已完成',
                                               P_OPERATE_FIELD      => 'PICK_NUM',
                                               P_FIELD_TYPE         => 'VARCHAR2',
                                               P_OLD_CODE           => 0,
                                               P_NEW_CODE           => 1,
                                               P_OLD_VALUE          => '待完成',
                                               P_NEW_VALUE          => '已完成',
                                               P_USER_ID            => v_user_id,
                                               P_OPERATE_COMPANY_ID => v_opr_com,
                                               P_SEQ_NO             => 1,
                                               PO_LOG_ID            => vo_log_id);
      
        scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => vo_log_id,
                                                             p_log_msg     => '操作【领料出库】，本次领料量=' ||
                                                                              v_num ||
                                                                              '，领料状态=已完成',
                                                             p_class_name  => '领料任务',
                                                             p_method_name => '领料出库',
                                                             p_type        => 2);*/
      
        --触发生成出库领料胚布、色布落表逻辑
        mrp.pkg_bulk_cargo_bom.p_supplier_color_grey_in_out_bound(v_batch_pick_lict_code => v_pid,
                                                                  v_create_id            => v_user_id,
                                                                  v_company_id           => ei.company_id);
      
      end loop;
      /*当【完成全部领料单】=是否时 */
    elsif if_all_material = '0' then
      --先进先出原则
      for ei in (select t.pick_lict_code,
                        t.company_id,
                        t.pick_num,
                        t.suggest_pick_num,
                        t.unpick_num,
                        t.unit
                   from mrp.pick_list t
                  where t.pick_lict_code in
                        (select regexp_substr(v_pick_lict_code,'[^;]+', 1, level, 'i') pick_lict_code
                           from dual
                         connect by level <= length(v_pick_lict_code) - length(regexp_replace(v_pick_lict_code, ';', '')) + 1)
                  order by t.create_time asc, t.pick_lict_code asc) loop
        if v_material_num = 0 then
          exit;
        end if;
        --判断领料量(剩于领料量)是否大于本次领料单的未领料量
        if v_material_num > ei.unpick_num then
          ---本次领料量
          v_num1 := ei.unpick_num;
          ---剩于领料量
          v_material_num := v_material_num - ei.unpick_num;
          --领料量百分比
          v_pick_percent := round(v_num1 / ei.suggest_pick_num * 100, 2);
        else
          ---本次领料量
          v_num1 := v_material_num;
          ---剩于领料量
          v_material_num := 0;
          --领料量百分比
          v_pick_percent := round(v_num1 / ei.suggest_pick_num * 100, 2);
        end if;
      
        v_pid := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'pick_list_batch',
                                                pi_column_name => 'batch_pick_lict_code',
                                                pi_pre         => ei.pick_lict_code,
                                                pi_serail_num  => 2);
        --生成分批领料单
        insert into mrp.pick_list_batch
          (batch_pick_lict_code,
           pick_lict_code,
           batch_time,
           unit,
           batch_pick_num,
           batch_pick_percent,
           batch_pick_id)
        values
          (v_pid,
           ei.pick_lict_code,
           sysdate,
           ei.unit,
           v_num1,
           v_pick_percent,
           v_user_id);
        if ei.unpick_num - v_num1 > 0 then
          /*更新领料表*/
          scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => ei.company_id,
                                                       p_document_id             => ei.pick_lict_code,
                                                       p_data_source_parent_code => 'PICK_LIST_LOG',
                                                       p_data_source_child_code  => '00',
                                                       p_operate_company_id      => v_opr_com,
                                                       p_user_id                 => v_user_id);
          update mrp.pick_list t
             set t.pick_num   = nvl(ei.pick_num, 0) + nvl(v_num1, 0),
                 pick_percent =
                 (nvl(ei.pick_num, 0) + nvl(v_num1, 0)) /
                 ei.suggest_pick_num * 100,
                 unpick_num   = ei.unpick_num - v_num1,
                 pick_id      = v_user_id,
                 pick_time    = sysdate
           where t.pick_lict_code = ei.pick_lict_code;
          --记录操作日志
         -- v_num     := nvl(v_num1, 0);
         -- vo_log_id := '';
          --v1_pick_lict_code := ei.pick_lict_code;

         /* SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => ei.company_id,
                                                 P_APPLY_MODULE       => v_item,
                                                 P_BASE_TABLE         => 'PICK_LIST',
                                                 P_APPLY_PK_ID        => ei.pick_lict_code,
                                                 P_ACTION_TYPE        => 'UPDATE',
                                                 P_LOG_ID             => vo_log_id,
                                                 P_LOG_TYPE           => '00',
                                                 P_LOG_MSG            => '操作【领料出库】，本次领料量=' ||
                                                                         v_num,
                                                 P_OPERATE_FIELD      => 'PICK_NUM',
                                                 P_FIELD_TYPE         => 'VARCHAR2',
                                                 P_OLD_CODE           => 0,
                                                 P_NEW_CODE           => 1,
                                                 P_OLD_VALUE          => '待完成',
                                                 P_NEW_VALUE          => '已完成',
                                                 P_USER_ID            => v_user_id,
                                                 P_OPERATE_COMPANY_ID => v_opr_com,
                                                 P_SEQ_NO             => 1,
                                                 PO_LOG_ID            => vo_log_id);
        
          scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => vo_log_id,
                                                               p_log_msg     => '操作【领料出库】，本次领料量=' ||
                                                                                v_num,
                                                               p_class_name  => '领料任务',
                                                               p_method_name => '领料出库',
                                                               p_type        => 2);*/
        
        else
          /*更新领料表*/
          scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => ei.company_id,
                                                       p_document_id             => ei.pick_lict_code,
                                                       p_data_source_parent_code => 'PICK_LIST_LOG',
                                                       p_data_source_child_code  => '00',
                                                       p_operate_company_id      => v_opr_com,
                                                       p_user_id                 => v_user_id);
          update mrp.pick_list t
             set t.pick_status = '1',
                 t.pick_num    = nvl(ei.pick_num, 0) + nvl(v_num1, 0),
                 pick_percent =
                 (nvl(ei.pick_num, 0) + nvl(v_num1, 0)) /
                 ei.suggest_pick_num * 100,
                 unpick_num    = '0',
                 pick_id       = v_user_id,
                 pick_time     = sysdate
           where t.pick_lict_code = ei.pick_lict_code;
          --记录操作日志
         -- v_num     := nvl(v_num1, 0);
         -- vo_log_id := '';
          --v1_pick_lict_code := ei.pick_lict_code;

         /* SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => ei.company_id,
                                                 P_APPLY_MODULE       => v_item,
                                                 P_BASE_TABLE         => 'PICK_LIST',
                                                 P_APPLY_PK_ID        => ei.pick_lict_code,
                                                 P_ACTION_TYPE        => 'UPDATE',
                                                 P_LOG_ID             => vo_log_id,
                                                 P_LOG_TYPE           => '00',
                                                 P_LOG_MSG            => '操作【领料出库】，本次领料量=' ||
                                                                         v_num ||
                                                                         '，领料状态=已完成',
                                                 P_OPERATE_FIELD      => 'PICK_NUM',
                                                 P_FIELD_TYPE         => 'VARCHAR2',
                                                 P_OLD_CODE           => 0,
                                                 P_NEW_CODE           => 1,
                                                 P_OLD_VALUE          => '待完成',
                                                 P_NEW_VALUE          => '已完成',
                                                 P_USER_ID            => v_user_id,
                                                 P_OPERATE_COMPANY_ID => v_opr_com,
                                                 P_SEQ_NO             => 1,
                                                 PO_LOG_ID            => vo_log_id);
        
          scmdata.pkg_plat_log.p_insert_plat_log_to_plm_or_mrp(p_log_id      => vo_log_id,
                                                               p_log_msg     => '操作【领料出库】，本次领料量=' ||
                                                                                v_num ||
                                                                                '，领料状态=已完成',
                                                               p_class_name  => '领料任务',
                                                               p_method_name => '领料出库',
                                                               p_type        => 2);*/
        end if;
        --触发生成出库领料胚布、色布落表逻辑
        mrp.pkg_bulk_cargo_bom.p_supplier_color_grey_in_out_bound(v_batch_pick_lict_code => v_pid,
                                                                  v_create_id            => v_user_id,
                                                                  v_company_id           => ei.company_id);
      
      end loop;
    end if;
  end p_pick_list_batch;

  /*领料出库——色布/胚布出入库单表*/
  procedure p_supplier_color_grey_in_out_bound(v_batch_pick_lict_code in varchar2,
                                               v_create_id            in varchar2,
                                               v_company_id           in varchar2) is
    v_pick_code                varchar2(32); ---领料单
    v_pro_supplier_code        varchar2(32); --成品供应商编号
    v_mater_supplier_code      varchar2(32); --物料供应商编号
    v_material_sku             varchar2(32); --物料SKU
    v_unit                     varchar2(32); --单位
    v_whether_inner_mater      number(1); --是否内部物料，0否1是 
    v_brand_stock              number(18, 2); --品牌仓库存数（色布）
    v_supplier_stock           number(18, 2); --供应商仓库存数（色布）
    v_batch_pick_num           number(11, 2); --分批领料数量
    v2_batch_pick_num          number(11, 2); --分批领料剩余数量
    v_relate_product_order_num varchar2(32); --关联生产订单编号 
    v_relate_skc               varchar2(32); --关联skc 
    v_sciob_rec                mrp.supplier_color_in_out_bound%rowtype;
    v_sgiob_rec                mrp.supplier_grey_in_out_bound%rowtype;
    v_grey_brand_stock         number(18, 2); --品牌仓库存数（胚布）
    v_grey_supplier_stock      number(18, 2); --供应商仓库存数（胚布）
    v_dye_loss_late            number(11, 2); --染损率
    v_material_spu             varchar2(32); --物料spu 
  begin
    --分批领料单
    select max(pb.batch_pick_num), max(pb.pick_lict_code)
      into v_batch_pick_num, v_pick_code
      from mrp.pick_list_batch pb
     where pb.batch_pick_lict_code = v_batch_pick_lict_code;
    --领料单
    select max(p.pro_supplier_code),
           max(p.mater_supplier_code),
           max(p.material_sku),
           max(p.unit),
           max(p.whether_inner_mater),
           max(relate_skc),
           max(relate_product_order_num)
      into v_pro_supplier_code,
           v_mater_supplier_code,
           v_material_sku,
           v_unit,
           v_whether_inner_mater,
           v_relate_skc,
           v_relate_product_order_num
      from mrp.pick_list p
     where p.pick_lict_code = v_pick_code
       and p.company_id = v_company_id;
    --供应商色布仓库存
    select max(t.brand_stock), max(t.supplier_stock)
      into v_brand_stock, v_supplier_stock
      from mrp.supplier_color_cloth_stock t
     where t.pro_supplier_code = v_pro_supplier_code
       and t.mater_supplier_code = v_mater_supplier_code
       and t.material_sku = v_material_sku
       and t.unit = v_unit;
  
    v_sciob_rec.pro_supplier_code   := v_pro_supplier_code; --成品供应商编号 
    v_sciob_rec.mater_supplier_code := v_mater_supplier_code; --物料供应商编号 
    v_sciob_rec.material_sku        := v_material_sku;
    v_sciob_rec.unit                := v_unit; --单位 
    v_sciob_rec.whether_inner_mater := v_whether_inner_mater; --是否内部物料，0否1是 
    v_sciob_rec.ascription          := 0; --出入库归属，0出库1入库 
    v_sciob_rec.bound_type          := 3; --出入库类型，1订单出库，2盘亏出库，3领料出库，10品牌备料入库，11供应商现货入库，12临时补充入库，13盘盈入库，14临时坯转色入库 15 供应商色布入库 16 供应商现货出库 
    v_sciob_rec.relate_num_type     := 3; --关联单号类型，1色布生产单/2色布盘点单/3色布领料单/4面料采购单/5坯布出库单 
    v_sciob_rec.create_id           := v_create_id;
    v_sciob_rec.create_time         := sysdate;
    v_sciob_rec.relate_num          := v_pick_code; --关联单号 
    v_sciob_rec.relate_skc          := v_relate_skc; --关联skc 
    v_sciob_rec.relate_purchase     := v_relate_product_order_num; --关联采购单号 
    v_sciob_rec.company_id          := v_company_id; --企业编码 
    v_sciob_rec.whether_del := '0';
    /*1、判断品牌仓色布库存是否够【分批领料数量】出库*/
    --校验【品牌仓库存数】＞0；
    if v_brand_stock > 0 then
      v_sciob_rec.bound_num := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'supplier_color_in_out_bound',
                                                              pi_column_name => 'bound_num ',
                                                              pi_pre         => 'CKCK' ||to_char(sysdate,'yyyymmdd'),
                                                              pi_serail_num  => 5); --色布出入库单号 
    
      v_sciob_rec.stock_type := 1; --仓库类型，1品牌仓，2供应商仓 
    
      --校验公式：【品牌仓色布库存】 - (【分批领料单-分批领料数量】) ≥ 0
      if v_brand_stock - v_batch_pick_num >= 0 then
        v_sciob_rec.num := v_batch_pick_num; --数量    
        /* 1.3 计算【分批领料数量剩余量】=【原分批领料数量】-生成的【色布出入库单表-数量】）*/
        v2_batch_pick_num := 0;
      else
        v_sciob_rec.num := v_brand_stock; --数量 
      
        /* 1.3 计算【分批领料数量剩余量】=【原分批领料数量】-生成的【色布出入库单表-数量】）*/
        v2_batch_pick_num := v_batch_pick_num - v_brand_stock;
      end if;
      ---落表至【供应商库存-色布出入库单表】
      mrp.pkg_bulk_cargo_bom.p_insert_supplier_color_in_out_bound(p_suppl_rec => v_sciob_rec);
      ---更新【供应商库存-色布仓库存明细】
      update mrp.supplier_color_cloth_stock t
         set t.total_stock = t.total_stock - v_sciob_rec.num,
             t.brand_stock = t.brand_stock - v_sciob_rec.num,
             t.update_id   = v_create_id,
             t.update_time = sysdate
       where t.pro_supplier_code = v_pro_supplier_code
         and t.mater_supplier_code = v_mater_supplier_code
         and t.material_sku = v_material_sku
         and t.unit = v_unit;
    else
      v2_batch_pick_num := v_batch_pick_num;
    end if;
    if v2_batch_pick_num > 0 then
      /*2、判断【供应商仓色布库存】是否够【分批领料数量剩余量】出库：*/
      --校验【供应商仓库存数】＞0；
      if v_supplier_stock > 0 then
        v_sciob_rec.bound_num := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'supplier_color_in_out_bound',
                                                                pi_column_name => 'bound_num ',
                                                                pi_pre         => 'CKCK' || to_char(sysdate, 'yyyymmdd'),                                                                                  
                                                                pi_serail_num  => 5); --色布出入库单号 
      
        v_sciob_rec.stock_type := 2; --仓库类型，1品牌仓，2供应商仓 
      
        --校验公式：【供应商仓色布库存】 - (【分批领料数量剩余数量】) ≥ 0
        if v_supplier_stock - v2_batch_pick_num >= 0 then
          v_sciob_rec.num   := v2_batch_pick_num; --数量  
          v2_batch_pick_num := 0; --剩余数量  
        else
          v_sciob_rec.num   := v_supplier_stock; --数量   
          v2_batch_pick_num := v2_batch_pick_num - v_supplier_stock; --剩余数量  
        end if;
        ---落表至【供应商库存-色布出入库单表】
        mrp.pkg_bulk_cargo_bom.p_insert_supplier_color_in_out_bound(p_suppl_rec => v_sciob_rec);
        ---更新【供应商库存-色布仓库存明细】
        update mrp.supplier_color_cloth_stock t
           set t.total_stock    = t.total_stock - v_sciob_rec.num,
               t.supplier_stock = t.supplier_stock - v_sciob_rec.num,
               t.update_id      = v_create_id,
               t.update_time    = sysdate
         where t.pro_supplier_code = v_pro_supplier_code
           and t.mater_supplier_code = v_mater_supplier_code
           and t.material_sku = v_material_sku
           and t.unit = v_unit;
      
      else
        v2_batch_pick_num := v2_batch_pick_num; --剩余数量  
      end if;
    end if;
    ---判断剩余量是否>0，如果大于0，进行供应商胚；
    if v2_batch_pick_num > 0 then
      if v_whether_inner_mater = '1' then
        select max(t.material_spu)
          into v_material_spu
          from mrp.mrp_internal_material_sku t
         where t.material_sku = v_material_sku;
        select max(t.dye_loss_late)
          into v_dye_loss_late
          from mrp.mrp_internal_supplier_material t
         where t.material_sku = v_material_sku
           and t.supplier_code = v_mater_supplier_code;
      elsif v_whether_inner_mater = '0' then
        select max(t.material_spu)
          into v_material_spu
          from mrp.mrp_outside_material_sku t
         where t.material_sku = v_material_sku
           and t.create_finished_supplier_code = v_pro_supplier_code;
        select max(t.dye_loss_late)
          into v_dye_loss_late
          from mrp.mrp_outside_supplier_material t
         where t.material_sku = v_material_sku
           and t.supplier_code = v_mater_supplier_code
           and t.create_finished_supplier_code = v_pro_supplier_code;
      end if;
    
      if v_dye_loss_late is null then
        v_dye_loss_late := 0;
      end if;
    
      ---供应商坯布仓库存
      select max(t.brand_stock), max(t.supplier_stock)
        into v_grey_brand_stock, v_grey_supplier_stock
        from mrp.supplier_grey_stock t
       where t.pro_supplier_code = v_pro_supplier_code
         and t.mater_supplier_code = v_mater_supplier_code
         and t.unit = v_unit
         and t.material_spu = v_material_spu;
    
      v_sgiob_rec.ascription                := '0'; --出入库归属，0出库1入库 
      v_sgiob_rec.bound_type                := '3'; --坯布出入库类型，1色布备料出库/ 2盘亏出库/ 3临时坯转色出库/ 4坯布备料出库 /11品牌备料入库/ 12供应商现货入库/ 13盘盈入库/ 14临时补充入库/15 供应商色布入库 
      v_sgiob_rec.pro_supplier_code         := v_pro_supplier_code; --成品供应商编号 
      v_sgiob_rec.mater_supplier_code       := v_mater_supplier_code; --物料供应商编号 
      v_sgiob_rec.material_spu              := v_material_spu; --物料spu 
      v_sgiob_rec.whether_inner_mater       := v_whether_inner_mater; --是否内部物料，0否1是 
      v_sgiob_rec.unit                      := v_unit; --单位  
      v_sgiob_rec.relate_num                := v_pick_code; --关联单号 
      v_sgiob_rec.relate_num_type           := '3'; --关联单号类型，1色布生产单/ 2坯布盘点单/ 3色布领料单/ 4坯布生产单/5面料采购单/6色布入库单 
      v_sgiob_rec.relate_skc                := v_relate_skc; --关联skc 
      v_sgiob_rec.relate_purchase_order_num := v_relate_product_order_num; --关联采购单号 
      v_sgiob_rec.company_id                := v_company_id;
      v_sgiob_rec.create_id                 := v_create_id;
      v_sgiob_rec.create_time               := sysdate;
      v_sgiob_rec.whether_del := '0';
      /*3、判断【品牌仓坯布库存】转色布，是否够【分批领料数量剩余量】出库：*/
      ---校验【品牌仓库存数】>0；
      if v_grey_brand_stock > 0 then
        v_sgiob_rec.bound_num  := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'supplier_grey_in_out_bound',
                                                                 pi_column_name => 'bound_num ',
                                                                 pi_pre         => 'CPCK' || to_char(sysdate, 'yyyymmdd'),
                                                                 pi_serail_num  => 5); --色布出入库单号 ; --坯布出入库单号 
        v_sgiob_rec.stock_type := '1'; --仓库类型，1品牌仓，2供应商仓 
        ----校验公式：【品牌仓坯布库存】 - (【分批领料数量剩余量】/(1-【染损率/100】) ≥ 0 
        if v_grey_brand_stock -
           (v2_batch_pick_num / (1 - (v_dye_loss_late / 100))) >= 0 then
          v_sgiob_rec.num   := (v2_batch_pick_num /
                               (1 - (v_dye_loss_late / 100))); --数量 
          v2_batch_pick_num := '0'; --剩余量
        else
          v_sgiob_rec.num   := v_grey_brand_stock; --数量 
          v2_batch_pick_num := v2_batch_pick_num -
                               (v_grey_brand_stock *
                               (1 - (v_dye_loss_late / 100))); --剩余量
        end if;
        ---落表至【供应商坯布仓库存_供应商坯布出入库单】
        mrp.pkg_bulk_cargo_bom.p_insert_supplier_grey_in_out_bound(p_suppl_rec => v_sgiob_rec);
        ---更新【供应商库存-坯布仓库存明细】
        update mrp.supplier_grey_stock t
           set t.total_stock = t.total_stock - v_sgiob_rec.num,
               t.brand_stock = t.brand_stock - v_sgiob_rec.num,
               t.update_id   = v_create_id,
               t.update_time = sysdate
         where t.pro_supplier_code = v_pro_supplier_code
           and t.mater_supplier_code = v_mater_supplier_code
           and t.material_spu = v_material_spu
           and t.unit = v_unit;
      
      else
        v2_batch_pick_num := v2_batch_pick_num; --剩余量
      end if;
    end if;
  
    ---判断剩余量是否>0，如果大于0，进行品牌胚--》供应商胚；
    if v2_batch_pick_num > 0 then
      v_sgiob_rec.bound_num  := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 'supplier_grey_in_out_bound',
                                                               pi_column_name => 'bound_num ',
                                                               pi_pre         => 'CPCK' ||to_char(sysdate,'yyyymmdd'),
                                                               pi_serail_num  => 5); --色布出入库单号 ; --坯布出入库单号 
      v_sgiob_rec.stock_type := '2'; --仓库类型，1品牌仓，2供应商仓 
      /*4、判断【供应商仓坯布库存】转色布，是否够【分批领料数量剩余量】出库：*/
      if v_grey_supplier_stock > 0 then
        ----校验公式：【供应商仓坯布库存】 - （【分批领料数量剩余量】/(1-【染损率/100】) ≥ 0 
        if v_grey_supplier_stock -
           (v2_batch_pick_num / (1 - (v_dye_loss_late / 100))) >= 0 then
          v_sgiob_rec.num := (v2_batch_pick_num /
                             (1 - (v_dye_loss_late / 100))); --数量 
 
        else
          v_sgiob_rec.num := v_grey_supplier_stock; --数量 

        end if;
        ---落表至【供应商坯布仓库存_供应商坯布出入库单】   
        mrp.pkg_bulk_cargo_bom.p_insert_supplier_grey_in_out_bound(p_suppl_rec => v_sgiob_rec);
        ---更新【供应商库存-坯布仓库存明细】
        update mrp.supplier_grey_stock t
           set t.total_stock    = t.total_stock - v_sgiob_rec.num,
               t.supplier_stock = t.supplier_stock - v_sgiob_rec.num,
               t.update_id      = v_create_id,
               t.update_time    = sysdate
         where t.pro_supplier_code = v_pro_supplier_code
           and t.mater_supplier_code = v_mater_supplier_code
           and t.material_spu = v_material_spu
           and t.unit = v_unit;
      end if;
    end if;
  end p_supplier_color_grey_in_out_bound;

  --新增 供应商色布出入库单supplier_color_in_out_bound
  procedure p_insert_supplier_color_in_out_bound(p_suppl_rec mrp.supplier_color_in_out_bound%rowtype) is
  begin
  
    insert into mrp.supplier_color_in_out_bound
      (bound_num,
       ascription,
       bound_type,
       pro_supplier_code,
       mater_supplier_code,
       material_sku,
       whether_inner_mater,
       unit,
       num,
       stock_type,
       relate_num,
       relate_num_type,
       relate_skc,
       relate_purchase,
       company_id,
       create_id,
       create_time,
       update_id,
       update_time,
       whether_del)
    values
      (p_suppl_rec.bound_num,
       p_suppl_rec.ascription,
       p_suppl_rec.bound_type,
       p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code,
       p_suppl_rec.material_sku,
       p_suppl_rec.whether_inner_mater,
       p_suppl_rec.unit,
       p_suppl_rec.num,
       p_suppl_rec.stock_type,
       p_suppl_rec.relate_num,
       p_suppl_rec.relate_num_type,
       p_suppl_rec.relate_skc,
       p_suppl_rec.relate_purchase,
       p_suppl_rec.company_id,
       p_suppl_rec.create_id,
       p_suppl_rec.create_time,
       p_suppl_rec.update_id,
       p_suppl_rec.update_time,
       p_suppl_rec.whether_del);
  end p_insert_supplier_color_in_out_bound;

  --新增 供应商坯布出入库单supplier_grey_in_out_bound
  procedure p_insert_supplier_grey_in_out_bound(p_suppl_rec mrp.supplier_grey_in_out_bound%rowtype) is
  begin
  
    insert into mrp.supplier_grey_in_out_bound
      (bound_num,
       ascription,
       bound_type,
       pro_supplier_code,
       mater_supplier_code,
       material_spu,
       whether_inner_mater,
       unit,
       num,
       stock_type,
       relate_num,
       relate_num_type,
       relate_skc,
       company_id,
       create_id,
       create_time,
       update_id,
       update_time,
       whether_del,
       relate_purchase_order_num)
    values
      (p_suppl_rec.bound_num,
       p_suppl_rec.ascription,
       p_suppl_rec.bound_type,
       p_suppl_rec.pro_supplier_code,
       p_suppl_rec.mater_supplier_code,
       p_suppl_rec.material_spu,
       p_suppl_rec.whether_inner_mater,
       p_suppl_rec.unit,
       p_suppl_rec.num,
       p_suppl_rec.stock_type,
       p_suppl_rec.relate_num,
       p_suppl_rec.relate_num_type,
       p_suppl_rec.relate_skc,
       p_suppl_rec.company_id,
       p_suppl_rec.create_id,
       p_suppl_rec.create_time,
       p_suppl_rec.update_id,
       p_suppl_rec.update_time,
       p_suppl_rec.whether_del,
       p_suppl_rec.relate_purchase_order_num);
  end p_insert_supplier_grey_in_out_bound;

  --新增 t_fabric_purchase_sheet
  procedure p_insert_t_fabric_purchase_sheet(p_t_fab_rec mrp.t_fabric_purchase_sheet%rowtype) is
  begin
  
    insert into mrp.t_fabric_purchase_sheet
      (fabric_purchase_sheet_id,
       company_id,
       fabric_id,
       fabric_status,
       fabric_source,
       pro_supplier_code,
       material_sku,
       mater_supplier_code,
       whether_inner_mater,
       unit,
       purchase_skc_order_amount,
       suggest_pick_amount,
       actual_pick_amount,
       already_deliver_amount,
       not_deliver_amount,
       delivery_amount,
       purchase_order_num,
       goods_skc,
       bulk_cargo_bom_id,
       material_detail_id,
       material_spu,
       features,
       material_name,
       ingredients,
       practical_door_with,
       gram_weight,
       material_specifications,
       color_picture,
       material_color,
       preferred_net_price_of_large_good,
       preferred_per_meter_price_of_large_good,
       benchmark_price,
       sku_abutment_code,
       supplier_material_name,
       color_card_picture,
       supplier_color,
       supplier_shades,
       optimization,
       disparity,
       supplier_large_good_quote,
       supplier_large_good_net_price,
       create_id,
       create_time,
       order_id,
       order_time,
       receive_order_id,
       receive_order_time,
       send_order_id,
       send_order_time,
       cancel_id,
       cancel_time,
       cancel_cause,
       remarks,
       update_id,
       update_time,old_fabric_id )
    values
      (p_t_fab_rec.fabric_purchase_sheet_id,
       p_t_fab_rec.company_id,
       p_t_fab_rec.fabric_id,
       p_t_fab_rec.fabric_status,
       p_t_fab_rec.fabric_source,
       p_t_fab_rec.pro_supplier_code,
       p_t_fab_rec.material_sku,
       p_t_fab_rec.mater_supplier_code,
       p_t_fab_rec.whether_inner_mater,
       p_t_fab_rec.unit,
       p_t_fab_rec.purchase_skc_order_amount,
       p_t_fab_rec.suggest_pick_amount,
       p_t_fab_rec.actual_pick_amount,
       p_t_fab_rec.already_deliver_amount,
       p_t_fab_rec.not_deliver_amount,
       p_t_fab_rec.delivery_amount,
       p_t_fab_rec.purchase_order_num,
       p_t_fab_rec.goods_skc,
       p_t_fab_rec.bulk_cargo_bom_id,
       p_t_fab_rec.material_detail_id,
       p_t_fab_rec.material_spu,
       p_t_fab_rec.features,
       p_t_fab_rec.material_name,
       p_t_fab_rec.ingredients,
       p_t_fab_rec.practical_door_with,
       p_t_fab_rec.gram_weight,
       p_t_fab_rec.material_specifications,
       p_t_fab_rec.color_picture,
       p_t_fab_rec.material_color,
       p_t_fab_rec.preferred_net_price_of_large_good,
       p_t_fab_rec.preferred_per_meter_price_of_large_good,
       p_t_fab_rec.benchmark_price,
       p_t_fab_rec.sku_abutment_code,
       p_t_fab_rec.supplier_material_name,
       p_t_fab_rec.color_card_picture,
       p_t_fab_rec.supplier_color,
       p_t_fab_rec.supplier_shades,
       p_t_fab_rec.optimization,
       p_t_fab_rec.disparity,
       p_t_fab_rec.supplier_large_good_quote,
       p_t_fab_rec.supplier_large_good_net_price,
       p_t_fab_rec.create_id,
       p_t_fab_rec.create_time,
       p_t_fab_rec.order_id,
       p_t_fab_rec.order_time,
       p_t_fab_rec.receive_order_id,
       p_t_fab_rec.receive_order_time,
       p_t_fab_rec.send_order_id,
       p_t_fab_rec.send_order_time,
       p_t_fab_rec.cancel_id,
       p_t_fab_rec.cancel_time,
       p_t_fab_rec.cancel_cause,
       p_t_fab_rec.remarks,
       p_t_fab_rec.update_id,
       p_t_fab_rec.update_time,p_t_fab_rec.old_fabric_id);
  
    ---同步v_group_key 伪主键字段
    mrp.pkg_bulk_cargo_bom.p_fabric_purchase_sheet_group_key;
  
  end p_insert_t_fabric_purchase_sheet;

  /*主表替换物料sku按钮页面跳转——替换物料sku按钮逻辑*/
  procedure p_action_a_prematerial_420_1(v1_group_key               in varchar2,
                                         v1_mater_supplier_code  in varchar2,
                                         v1_unit                    in varchar2,
                                         v1_supplier_shades         in varchar2,
                                         v1_material_sku            in varchar2,
                                         v1_practical_door_with     in number,
                                         v1_gram_weight             in number,
                                         v1_material_specifications in varchar2,
                                         v_create_id                in varchar2,
                                         v1_po_company_id           in varchar2) is
    v_pro_supplier_code                       varchar2(32);
    v_mater_supplier_code                     varchar2(32);
    v_material_sku                            varchar2(32);
    v_unit                                    varchar2(32);
    v_supplier_shades                         varchar2(32);
    v_practical_door_with                     varchar2(32); --实用门幅，单位厘米 
    v_gram_weight                             varchar2(32);
    v_material_specifications                 varchar2(32);
    v_tfps_rec                                mrp.t_fabric_purchase_sheet%rowtype;
    v_color_picture                           varchar2(32); --颜色图
    v_material_color                          varchar2(32); --物料颜色 
    v_material_spu                            varchar2(32); --物料spu 
    v_preferred_net_price_of_large_good       number(10, 2); --优选大货净价 
    v_preferred_per_meter_price_of_large_good number(10, 2); --优选大货米价 
    v_benchmark_price                         number(10, 2); --基准价 
    v_features                                varchar2(64); --特征图
    v_material_name                           varchar2(64); --物料名称 
    v_ingredients                             varchar2(2560); --成分信息id
    v_sku_abutment_code                       varchar2(200); --供应商物料sku对接码 
    v_supplier_material_name                  varchar2(50); --供应商物料名称 
    v_color_card_picture                      varchar2(64); --色卡图
    v_supplier_color                          varchar2(150); --供应商颜色 
    --v2_supplier_shades                        varchar2(30); --供应商色号 
    v_optimization                  number(1); --是否优选 
    v_disparity                     number(10, 2); --空差 
    v_supplier_large_good_quote     number(10, 2); --供应商大货报价 
    v_supplier_large_good_net_price number(10, 2); --供应商大货净价 
    v_count                         number(2);
    v_pid                           varchar2(32);
    --vo_log_id                       varchar2(32);
    v_already_deliver_amount number(18,4) ;
  begin
  
    select max(tf.pro_supplier_code),
           max(tf.mater_supplier_code),
           max(tf.supplier_material_name),
           max(tf.material_sku),
           max(tf.unit),
           max(tf.supplier_shades),
           max(tf.practical_door_with),
           max(tf.gram_weight),
           max(tf.material_specifications),sum(already_deliver_amount)
      into v_pro_supplier_code,
           v_mater_supplier_code,
           v_supplier_material_name,
           v_material_sku,
           v_unit,
           v_supplier_shades,
           v_practical_door_with,
           v_gram_weight,
           v_material_specifications,v_already_deliver_amount
      from mrp.t_fabric_purchase_sheet tf
     where tf.group_key = v1_group_key;
  
    select count(1)
      into v_count
      from mrp.t_fabric_purchase_sheet t
     where t.group_key = v1_group_key
       and t.fabric_status in ('S01', 'S02');
  
    if v_count is null or v_count = '0' then
      raise_application_error(-20002,
                              '所选择的数据状态已更改，不可操作替换物料sku！');
    end if;
       if v_already_deliver_amount > 0 then
      raise_application_error(-20002,
                              '当前面料采购单已发货量≠0，不可替换物料sku。');
    end if; 
    if v_mater_supplier_code = v1_mater_supplier_code and
       v_material_sku = v1_material_sku and v_unit = v1_unit and
       v_supplier_shades = v1_supplier_shades and
       nvl(v_practical_door_with, 0) = nvl(v1_practical_door_with, 0) and
       nvl(v_gram_weight, 0) = nvl(v1_gram_weight, 0) and
       nvl(v_material_specifications, 0) =
       nvl(v1_material_specifications, 0) then
      raise_application_error(-20002, '所选择的物料sku未更改，请检查！');
    end if;
  
    for v_f_sheet in (select *
                        from mrp.t_fabric_purchase_sheet t
                       where t.group_key = v1_group_key
                         and (t.already_deliver_amount = '0' or
                             t.already_deliver_amount is null)
                         and t.fabric_status in ('S01', 'S02')) loop
      v_tfps_rec.fabric_purchase_sheet_id  := mrp.pkg_plat_comm.f_get_uuid();
      v_tfps_rec.company_id                := v_f_sheet.company_id;
      v_pid                                := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 't_fabric_purchase_sheet',
                                                                             pi_column_name => 'fabric_id',
                                                                             pi_pre         => 'MCG' ||TO_CHAR(SYSDATE,'yyyymmdd'),
                                                                             pi_serail_num  => 5);
      v_tfps_rec.fabric_id                 := v_pid;
      v_tfps_rec.old_fabric_id             := v_f_sheet.fabric_id;
      v_tfps_rec.fabric_status             := v_f_sheet.fabric_status; --采购状态(待下单:s00/待接单:s01/待发货:s02/待收货:s03/已收货:s04/已取消:s05) 
      v_tfps_rec.fabric_source             := '3'; --采购单来源(品牌采购单:0/供应商自采:1/物料商发货:2) 
      v_tfps_rec.pro_supplier_code         := v_f_sheet.pro_supplier_code; --成品供应商编号 
      v_tfps_rec.material_sku              := v1_material_sku; --物料sku  
      v_tfps_rec.mater_supplier_code       := v_f_sheet.mater_supplier_code; --物料供应商编号  
      v_tfps_rec.whether_inner_mater       := v_f_sheet.whether_inner_mater; --是否内部物料,0否1是 
      v_tfps_rec.unit                      := v1_unit; --单位  
      v_tfps_rec.purchase_skc_order_amount := v_f_sheet.purchase_skc_order_amount; --采购skc订单量 
      v_tfps_rec.suggest_pick_amount       := v_f_sheet.suggest_pick_amount; --建议采购量 
      v_tfps_rec.actual_pick_amount        := v_f_sheet.actual_pick_amount; --实际采购量 
      v_tfps_rec.already_deliver_amount    := v_f_sheet.already_deliver_amount; --已发货量 
      v_tfps_rec.not_deliver_amount        := v_f_sheet.not_deliver_amount; --未发货量 
      v_tfps_rec.delivery_amount           := v_f_sheet.delivery_amount; --已收货量 
      v_tfps_rec.purchase_order_num        := v_f_sheet.purchase_order_num; --采购订单编号 
      v_tfps_rec.goods_skc                 := v_f_sheet.goods_skc; --货色skc 
      v_tfps_rec.bulk_cargo_bom_id         := v_f_sheet.bulk_cargo_bom_id; --大货bomid 
      v_tfps_rec.material_detail_id        := v_f_sheet.material_detail_id; --大货bom物料明细 
      /*内部物料SKU信息  MRP.MRP_INTERNAL_MATERIAL_SKU*/
      select max(t.material_color),
             max(t.material_spu),
             max(t.preferred_net_price_of_large_good),
             max(t.preferred_per_meter_price_of_large_good),
             max(t.benchmark_price)
        into v_material_color,
             v_material_spu,
             v_preferred_net_price_of_large_good,
             v_preferred_per_meter_price_of_large_good,
             v_benchmark_price
        from mrp.mrp_internal_material_sku t
       where t.material_sku = v1_material_sku;
      /*      内部物料SPU信息 MRP.MRP_INTERNAL_MATERIAL_SPU*/
      select max(t.material_name)
        into v_material_name
        from mrp.mrp_internal_material_spu t
       where t.material_spu = v_material_spu;
      /*    内部供应商物料信息  MRP.MRP_INTERNAL_SUPPLIER_MATERIAL*/
      select max(t.sku_abutment_code),
             max(t.supplier_material_name),
             max(t.supplier_color),
             max(t.supplier_shades),
             max(t.optimization),
             max(t.disparity),
             max(t.supplier_large_good_quote),
             max(t.supplier_large_good_net_price)
        into v_sku_abutment_code,
             v_supplier_material_name,
             v_supplier_color,
             v_supplier_shades,
             v_optimization,
             v_disparity,
             v_supplier_large_good_quote,
             v_supplier_large_good_net_price
        from mrp.mrp_internal_supplier_material t
       where t.material_sku = v1_material_sku
         and t.supplier_code = v_f_sheet.mater_supplier_code;
      /*查找外部物料SPU信息表——颜色图*/
      select max(t.picture_id)
        into v_color_picture
        from mrp.MRP_PICTURE t
       where t.picture_type = '2'
         and t.thirdpart_id = v1_material_sku;
      /*查找外部物料SPU信息表——特征图，物料spu*/
      select max(t.picture_id)
        into v_features
        from mrp.MRP_PICTURE t
       where t.picture_type = '1'
         and t.thirdpart_id = v_material_spu
         and rownum = 1;
      /*查找外部物料SPU信息表——成分信息*/
      mrp.pkg_bulk_cargo_bom.P_GET_INGREDIENTS_BYSPU(PI_SPUID       => v_material_spu,
                                                     PO_INGREDIENTS => v_ingredients);
    
      /*      select listagg(distinct material_ingredient_id, ';') within group(order by t.material_spu)
       into v_ingredients
       from MRP.MRP_MATERIAL_SPU_INGREDIENT_MAPPING t
      where t.material_spu = v_material_spu
      group by t.material_spu;*/
      /*查找外部物料SPU信息表——色卡图，物料spu*/
      select max(t.picture_id)
        into v_color_card_picture
        from mrp.MRP_PICTURE t
       where t.picture_type = '3'
         and t.thirdpart_id = v_sku_abutment_code
       order by t.upload_time desc;
      v_tfps_rec.material_spu                            := v_material_spu; --物料spu   
      v_tfps_rec.features                                := v_features; --特征图 
      v_tfps_rec.material_name                           := v_material_name; --物料名称  
      v_tfps_rec.ingredients                             := v_ingredients; --物料成分  
      v_tfps_rec.practical_door_with                     := v1_practical_door_with; --实用门幅  
      v_tfps_rec.gram_weight                             := v1_gram_weight; --克重 
      v_tfps_rec.material_specifications                 := v1_material_specifications; --物料规格 
      v_tfps_rec.color_picture                           := v_color_picture; --颜色图 
      v_tfps_rec.material_color                          := v_material_color; --物料颜色 
      v_tfps_rec.preferred_net_price_of_large_good       := v_preferred_net_price_of_large_good; --优选大货净价 
      v_tfps_rec.preferred_per_meter_price_of_large_good := v_preferred_per_meter_price_of_large_good; --优选大货米价 
      v_tfps_rec.benchmark_price                         := v_benchmark_price; --基准价 
      v_tfps_rec.sku_abutment_code                       := v_sku_abutment_code; --供应商物料sku对接码 
      v_tfps_rec.supplier_material_name                  := v_supplier_material_name; --供应商物料名称 
      v_tfps_rec.color_card_picture                      := v_color_card_picture; --色卡图 
      v_tfps_rec.supplier_color                          := v_supplier_color; --供应商颜色 
      v_tfps_rec.supplier_shades                         := v_supplier_shades; --供应商色号 
      v_tfps_rec.optimization                            := v_optimization; --是否优选 
      v_tfps_rec.disparity                               := v_disparity; --空差 
      v_tfps_rec.supplier_large_good_quote               := v_supplier_large_good_quote; --供应商大货报价 
      v_tfps_rec.supplier_large_good_net_price           := v_supplier_large_good_net_price; --供应商大货净价 
      v_tfps_rec.create_id                               := v_create_id; --创建id 
      v_tfps_rec.create_time                             := sysdate; --创建时间 
      v_tfps_rec.order_id                                := v_f_sheet.order_id; --下单人id 
      v_tfps_rec.order_time                              := v_f_sheet.order_time; --下单时间 
      v_tfps_rec.receive_order_id                        := v_f_sheet.receive_order_id; --接单人id 
      v_tfps_rec.receive_order_time                      := v_f_sheet.receive_order_time; --接单时间 
      v_tfps_rec.send_order_id                           := v_f_sheet.send_order_id; -- 发货人id 
      v_tfps_rec.send_order_time                         := v_f_sheet.send_order_time; --发货人时间 
      v_tfps_rec.cancel_id                               := v_f_sheet.cancel_id; --取消人id 
      v_tfps_rec.cancel_time                             := v_f_sheet.cancel_time; --取消人时间 
      v_tfps_rec.cancel_cause                            := v_f_sheet.cancel_cause; --取消人原因 
    --记录操作来源
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => v_f_sheet.company_id,
                                               p_document_id             => v_pid,
                                               p_data_source_parent_code => 'FABRIC_SHEET_LOG',
                                               p_data_source_child_code  => '00',
                                               p_operate_company_id      => v1_po_company_id,
                                               p_user_id                 => v_create_id);

      mrp.pkg_bulk_cargo_bom.p_insert_t_fabric_purchase_sheet(p_t_fab_rec => v_tfps_rec);
     /* vo_log_id := '';
      --记录操作日志
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => v_f_sheet.company_id,
                                             P_APPLY_MODULE       => 'a_prematerial_411',
                                             P_BASE_TABLE         => 'T_FABRIC_PURCHASE_SHEET',
                                             P_APPLY_PK_ID        => v_pid,
                                             P_ACTION_TYPE        => 'INSERT',
                                             P_LOG_ID             => vo_log_id,
                                             P_LOG_TYPE           => '00',
                                             P_LOG_MSG            => '采购单来源=' || case
                                                                       when v_f_sheet.fabric_source = '0' then
                                                                        '品牌采购单'
                                                                       when v_f_sheet.fabric_source = '1' then
                                                                        '供应商自采'
                                                                       when v_f_sheet.fabric_source = '2' then
                                                                        '物料商发货'
                                                                     end ||
                                                                     ',原关联面料采购单号：' ||
                                                                     v_f_sheet.fabric_id,
                                             P_OPERATE_FIELD      => 'PICK_NUM',
                                             P_FIELD_TYPE         => 'VARCHAR2',
                                             P_OLD_CODE           => '',
                                             P_NEW_CODE           => v_pid,
                                             P_OLD_VALUE          => '',
                                             P_NEW_VALUE          => v_pid,
                                             P_USER_ID            => v_create_id,
                                             P_OPERATE_COMPANY_ID => v1_po_company_id,
                                             P_SEQ_NO             => 1,
                                             PO_LOG_ID            => vo_log_id);*/
      --记录操作来源
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => v_f_sheet.company_id,
                                               p_document_id             => v_f_sheet.fabric_id,
                                               p_data_source_parent_code => 'FABRIC_SHEET_LOG',
                                               p_data_source_child_code  => '04',
                                               p_operate_company_id      => v1_po_company_id,
                                               p_user_id                 => v_create_id);  
      update mrp.t_fabric_purchase_sheet t
         set t.fabric_status = 'S05',
             t.cancel_id     = v_create_id,
             t.cancel_time   = sysdate,
             t.cancel_cause  = '替换物料SKU为' || v1_material_sku||',新增面料采购单号:'||v_pid
       where t.fabric_purchase_sheet_id =
             v_f_sheet.fabric_purchase_sheet_id
         and t.company_id = v_f_sheet.company_id
         and t.fabric_id = v_f_sheet.fabric_id;
    
     /* vo_log_id := '';
      --记录操作日志
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => v_f_sheet.company_id,
                                             P_APPLY_MODULE       => 'a_prematerial_411',
                                             P_BASE_TABLE         => 'T_FABRIC_PURCHASE_SHEET',
                                             P_APPLY_PK_ID        => v_f_sheet.fabric_id,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => vo_log_id,
                                             P_LOG_TYPE           => '04',
                                             P_LOG_MSG            => '采购状态=已取消，关联新建面料采购单号：' ||
                                                                     v_pid,
                                             P_OPERATE_FIELD      => 'FABRIC_STATUS',
                                             P_FIELD_TYPE         => 'VARCHAR2',
                                             P_OLD_CODE           => '',
                                             P_NEW_CODE           => 'S05',
                                             P_OLD_VALUE          => '',
                                             P_NEW_VALUE          => 'S05',
                                             P_USER_ID            => v_create_id,
                                             P_OPERATE_COMPANY_ID => v1_po_company_id,
                                             P_SEQ_NO             => 1,
                                             PO_LOG_ID            => vo_log_id);*/
    end loop;
  
  end p_action_a_prematerial_420_1;

  /*从表替换物料sku按钮页面跳转——替换物料sku按钮逻辑*/
  procedure p_action_a_prematerial_422_1(v1_fabric_id               in varchar2,
                                         v1_mater_supplier_code  in varchar2,
                                         v1_unit                    in varchar2,
                                         v1_supplier_shades         in varchar2,
                                         v1_material_sku            in varchar2,
                                         v1_practical_door_with     in number,
                                         v1_gram_weight             in number,
                                         v1_material_specifications in varchar2,
                                         v_create_id                in varchar2,
                                         v1_po_company_id           in varchar2) is
    v_pro_supplier_code                       varchar2(32);
    v_mater_supplier_code                     varchar2(32);
    v_material_sku                            varchar2(32);
    v_unit                                    varchar2(32);
    v_supplier_shades                         varchar2(32);
    v_practical_door_with                     varchar2(32); --实用门幅，单位厘米 
    v_gram_weight                             varchar2(32);
    v_material_specifications                 varchar2(32);
    v_tfps_rec                                mrp.t_fabric_purchase_sheet%rowtype;
    v_color_picture                           varchar2(32); --颜色图
    v_material_color                          varchar2(32); --物料颜色 
    v_material_spu                            varchar2(32); --物料spu 
    v_preferred_net_price_of_large_good       number(10, 2); --优选大货净价 
    v_preferred_per_meter_price_of_large_good number(10, 2); --优选大货米价 
    v_benchmark_price                         number(10, 2); --基准价 
    v_features                                varchar2(64); --特征图
    v_material_name                           varchar2(64); --物料名称 
    v_ingredients                             varchar2(2560); --成分信息id
    v_sku_abutment_code                       varchar2(200); --供应商物料sku对接码 
    v_supplier_material_name                  varchar2(50); --供应商物料名称 
    v_color_card_picture                      varchar2(64); --色卡图
    v_supplier_color                          varchar2(150); --供应商颜色 
    --v2_supplier_shades                        varchar2(30); --供应商色号 
    v_optimization                  number(1); --是否优选 
    v_disparity                     number(10, 2); --空差 
    v_supplier_large_good_quote     number(10, 2); --供应商大货报价 
    v_supplier_large_good_net_price number(10, 2); --供应商大货净价 
    v_count                         number(2);
    v_pid                           varchar2(32);
    --vo_log_id                       varchar2(32);
    v_already_deliver_amount number(18,4) ;
  begin
  
    select count(*),sum(already_deliver_amount)
      into v_count,v_already_deliver_amount
      from mrp.t_fabric_purchase_sheet t
     where t.fabric_id in
           (select regexp_substr(v1_fabric_id, '[^;]+', 1, level, 'i')
              from dual
            connect by level <=
                       length(v1_fabric_id) -
                       length(regexp_replace(v1_fabric_id, ';', '')) + 1)
       and t.fabric_status in ('S01', 'S02');
  
    if v_count is null or v_count = '0' then
      raise_application_error(-20002,
                              '所选择的数据状态已更改，不可操作替换物料sku！');
    end if;
     if v_already_deliver_amount > 0 then
      raise_application_error(-20002,
                              '当前面料采购单已发货量≠0，不可替换物料sku。');
    end if; 
    select max(t.pro_supplier_code),
           max(t.mater_supplier_code),
           max(t.material_sku),
           max(t.unit),
           max(t.supplier_shades),
           max(t.practical_door_with),
           max(t.gram_weight),
           max(t.material_specifications)
      into v_pro_supplier_code,
           v_mater_supplier_code,
           v_material_sku,
           v_unit,
           v_supplier_shades,
           v_practical_door_with,
           v_gram_weight,
           v_material_specifications
      from mrp.t_fabric_purchase_sheet t
     where t.fabric_id in
           (select regexp_substr(v1_fabric_id, '[^;]+', 1, level, 'i')
              from dual
            connect by level <=
                       length(v1_fabric_id) -
                       length(regexp_replace(v1_fabric_id, ';', '')) + 1);
  
    select max(a.supplier_material_name)
      into v_supplier_material_name
      from mrp.mrp_internal_supplier_material a
     where a.supplier_code = v_mater_supplier_code;
  
    if v_mater_supplier_code = v1_mater_supplier_code and
       v_material_sku = v1_material_sku and v_unit = v1_unit and
       v_supplier_shades = v1_supplier_shades and
       v_practical_door_with = v1_practical_door_with and
       v_gram_weight = v1_gram_weight and
       v_material_specifications = v1_material_specifications then
      raise_application_error(-20002, '所选择的物料sku未更改，请检查！');
    end if;
  
    for i in (select *
                from mrp.t_fabric_purchase_sheet t
               where t.fabric_id in
                     (select regexp_substr(v1_fabric_id,
                                           '[^;]+',
                                           1,
                                           level,
                                           'i')
                        from dual
                      connect by level <=
                                 length(v1_fabric_id) -
                                 length(regexp_replace(v1_fabric_id, ';', '')) + 1)
                 and t.fabric_status in ('S01', 'S02')
                 and (t.already_deliver_amount = '0' or
                     t.already_deliver_amount is null)) loop
      v_tfps_rec.fabric_purchase_sheet_id  := mrp.pkg_plat_comm.f_get_uuid();
      v_tfps_rec.company_id                := i.company_id;
      v_pid                                := mrp.pkg_plat_comm.f_get_docuno(pi_table_name  => 't_fabric_purchase_sheet',
                                                                             pi_column_name => 'fabric_id',
                                                                             pi_pre         => 'MCG' ||TO_CHAR(SYSDATE,'yyyymmdd'),
                                                                             pi_serail_num  => 5);
      v_tfps_rec.fabric_id                 := v_pid;
      v_tfps_rec.old_fabric_id             := i.fabric_id;
      v_tfps_rec.fabric_status             := i.fabric_status; --采购状态(待下单:s00/待接单:s01/待发货:s02/待收货:s03/已收货:s04/已取消:s05) 
      v_tfps_rec.fabric_source             := '3'; --采购单来源(品牌采购单:0/供应商自采:1/物料商发货:2) 
      v_tfps_rec.pro_supplier_code         := i.pro_supplier_code; --成品供应商编号 
      v_tfps_rec.material_sku              := v1_material_sku; --物料sku  
      v_tfps_rec.mater_supplier_code       := i.mater_supplier_code; --物料供应商编号  
      v_tfps_rec.whether_inner_mater       := i.whether_inner_mater; --是否内部物料,0否1是 
      v_tfps_rec.unit                      := v1_unit; --单位  
      v_tfps_rec.purchase_skc_order_amount := i.purchase_skc_order_amount; --采购skc订单量 
      v_tfps_rec.suggest_pick_amount       := i.suggest_pick_amount; --建议采购量 
      v_tfps_rec.actual_pick_amount        := i.actual_pick_amount; --实际采购量 
      v_tfps_rec.already_deliver_amount    := i.already_deliver_amount; --已发货量 
      v_tfps_rec.not_deliver_amount        := i.not_deliver_amount; --未发货量 
      v_tfps_rec.delivery_amount           := i.delivery_amount; --已收货量 
      v_tfps_rec.purchase_order_num        := i.purchase_order_num; --采购订单编号 
      v_tfps_rec.goods_skc                 := i.goods_skc; --货色skc 
      v_tfps_rec.bulk_cargo_bom_id         := i.bulk_cargo_bom_id; --大货bomid 
      v_tfps_rec.material_detail_id        := i.material_detail_id; --大货bom物料明细 
      /*内部物料SKU信息  MRP.MRP_INTERNAL_MATERIAL_SKU*/
      select max(t.material_color),
             max(t.material_spu),
             max(t.preferred_net_price_of_large_good),
             max(t.preferred_per_meter_price_of_large_good),
             max(t.benchmark_price)
        into v_material_color,
             v_material_spu,
             v_preferred_net_price_of_large_good,
             v_preferred_per_meter_price_of_large_good,
             v_benchmark_price
        from mrp.mrp_internal_material_sku t
       where t.material_sku = v1_material_sku;
      /*      内部物料SPU信息 MRP.MRP_INTERNAL_MATERIAL_SPU*/
      select max(t.material_name)
        into v_material_name
        from mrp.mrp_internal_material_spu t
       where t.material_spu = v_material_spu;
      /*    内部供应商物料信息  MRP.MRP_INTERNAL_SUPPLIER_MATERIAL*/
      select max(t.sku_abutment_code),
             max(t.supplier_material_name),
             max(t.supplier_color),
             max(t.supplier_shades),
             max(t.optimization),
             max(t.disparity),
             max(t.supplier_large_good_quote),
             max(t.supplier_large_good_net_price)
        into v_sku_abutment_code,
             v_supplier_material_name,
             v_supplier_color,
             v_supplier_shades,
             v_optimization,
             v_disparity,
             v_supplier_large_good_quote,
             v_supplier_large_good_net_price
        from mrp.mrp_internal_supplier_material t
       where t.material_sku = v1_material_sku
         and t.supplier_code = i.mater_supplier_code;
      /*查找外部物料SPU信息表——颜色图*/
      select max(t.picture_id)
        into v_color_picture
        from mrp.MRP_PICTURE t
       where t.picture_type = '2'
         and t.thirdpart_id = v1_material_sku;
      /*查找外部物料SPU信息表——特征图，物料spu*/
      select max(t.picture_id)
        into v_features
        from mrp.MRP_PICTURE t
       where t.picture_type = '1'
         and t.thirdpart_id = v_material_spu
         and rownum = 1;
      /*查找外部物料SPU信息表——成分信息*/
      mrp.pkg_bulk_cargo_bom.P_GET_INGREDIENTS_BYSPU(PI_SPUID       => v_material_spu,
                                                     PO_INGREDIENTS => v_ingredients);
    
      /*      select listagg(distinct material_ingredient_id, ';') within group(order by t.material_spu)
       into v_ingredients
       from MRP.MRP_MATERIAL_SPU_INGREDIENT_MAPPING t
      where t.material_spu = v_material_spu
      group by t.material_spu;*/
      /*查找外部物料SPU信息表——色卡图，物料spu*/
      select max(t.picture_id)
        into v_color_card_picture
        from mrp.MRP_PICTURE t
       where t.picture_type = '3'
         and t.thirdpart_id = v_sku_abutment_code
       order by t.upload_time desc;
      v_tfps_rec.material_spu                            := v_material_spu; --物料spu   
      v_tfps_rec.features                                := v_features; --特征图 
      v_tfps_rec.material_name                           := v_material_name; --物料名称  
      v_tfps_rec.ingredients                             := v_ingredients; --物料成分  
      v_tfps_rec.practical_door_with                     := v1_practical_door_with; --实用门幅  
      v_tfps_rec.gram_weight                             := v1_gram_weight; --克重 
      v_tfps_rec.material_specifications                 := v1_material_specifications; --物料规格 
      v_tfps_rec.color_picture                           := v_color_picture; --颜色图 
      v_tfps_rec.material_color                          := v_material_color; --物料颜色 
      v_tfps_rec.preferred_net_price_of_large_good       := v_preferred_net_price_of_large_good; --优选大货净价 
      v_tfps_rec.preferred_per_meter_price_of_large_good := v_preferred_per_meter_price_of_large_good; --优选大货米价 
      v_tfps_rec.benchmark_price                         := v_benchmark_price; --基准价 
      v_tfps_rec.sku_abutment_code                       := v_sku_abutment_code; --供应商物料sku对接码 
      v_tfps_rec.supplier_material_name                  := v_supplier_material_name; --供应商物料名称 
      v_tfps_rec.color_card_picture                      := v_color_card_picture; --色卡图 
      v_tfps_rec.supplier_color                          := v_supplier_color; --供应商颜色 
      v_tfps_rec.supplier_shades                         := v_supplier_shades; --供应商色号 
      v_tfps_rec.optimization                            := v_optimization; --是否优选 
      v_tfps_rec.disparity                               := v_disparity; --空差 
      v_tfps_rec.supplier_large_good_quote               := v_supplier_large_good_quote; --供应商大货报价 
      v_tfps_rec.supplier_large_good_net_price           := v_supplier_large_good_net_price; --供应商大货净价 
      v_tfps_rec.create_id                               := v_create_id; --创建id 
      v_tfps_rec.create_time                             := sysdate; --创建时间 
      v_tfps_rec.order_id                                := i.order_id; --下单人id 
      v_tfps_rec.order_time                              := i.order_time; --下单时间 
      v_tfps_rec.receive_order_id                        := i.receive_order_id; --接单人id 
      v_tfps_rec.receive_order_time                      := i.receive_order_time; --接单时间 
      v_tfps_rec.send_order_id                           := i.send_order_id; -- 发货人id 
      v_tfps_rec.send_order_time                         := i.send_order_time; --发货人时间 
      v_tfps_rec.cancel_id                               := i.cancel_id; --取消人id 
      v_tfps_rec.cancel_time                             := i.cancel_time; --取消人时间 
      v_tfps_rec.cancel_cause                            := i.cancel_cause; --取消人原因 

    --记录操作来源
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => i.company_id,
                                               p_document_id             => v_pid,
                                               p_data_source_parent_code => 'FABRIC_SHEET_LOG',
                                               p_data_source_child_code  => '00',
                                               p_operate_company_id      => v1_po_company_id,
                                               p_user_id                 => v_create_id);

      mrp.pkg_bulk_cargo_bom.p_insert_t_fabric_purchase_sheet(p_t_fab_rec => v_tfps_rec);
      /*vo_log_id := '';
      --记录操作日志
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => i.company_id,
                                             P_APPLY_MODULE       => 'a_prematerial_411',
                                             P_BASE_TABLE         => 'T_FABRIC_PURCHASE_SHEET',
                                             P_APPLY_PK_ID        => v_pid,
                                             P_ACTION_TYPE        => 'INSERT',
                                             P_LOG_ID             => vo_log_id,
                                             P_LOG_TYPE           => '00',
                                             P_LOG_MSG            => '采购单来源=' || case
                                                                       when i.fabric_source = '0' then
                                                                        '品牌采购单'
                                                                       when i.fabric_source = '1' then
                                                                        '供应商自采'
                                                                       when i.fabric_source = '2' then
                                                                        '物料商发货'
                                                                     end ||
                                                                     ',原关联面料采购单号：' ||
                                                                     i.fabric_id,
                                             P_OPERATE_FIELD      => 'PICK_NUM',
                                             P_FIELD_TYPE         => 'VARCHAR2',
                                             P_OLD_CODE           => '',
                                             P_NEW_CODE           => v_pid,
                                             P_OLD_VALUE          => '',
                                             P_NEW_VALUE          => v_pid,
                                             P_USER_ID            => v_create_id,
                                             P_OPERATE_COMPANY_ID => v1_po_company_id,
                                             P_SEQ_NO             => 1,
                                             PO_LOG_ID            => vo_log_id);*/

      --记录操作来源
  scmdata.pkg_plat_log.p_document_change_trace(p_company_id              => i.company_id,
                                               p_document_id             => i.fabric_id,
                                               p_data_source_parent_code => 'FABRIC_SHEET_LOG',
                                               p_data_source_child_code  => '04',
                                               p_operate_company_id      => v1_po_company_id,
                                               p_user_id                 => v_create_id);  

      update mrp.t_fabric_purchase_sheet t
         set t.fabric_status = 'S05',
             t.cancel_id     = v_create_id,
             t.cancel_time   = sysdate,
             t.cancel_cause  = '替换物料SKU为' || v1_material_sku||',新增面料采购单号:'||v_pid
       where t.fabric_purchase_sheet_id = i.fabric_purchase_sheet_id
         and t.company_id = i.company_id
         and t.fabric_id = i.fabric_id;
  /*    vo_log_id := '';
      ---插入scm/mrp日志表
      SCMDATA.PKG_PLAT_LOG.P_RECORD_PLAT_LOG(P_COMPANY_ID         => i.company_id,
                                             P_APPLY_MODULE       => 'a_prematerial_411',
                                             P_BASE_TABLE         => 'T_FABRIC_PURCHASE_SHEET',
                                             P_APPLY_PK_ID        => i.fabric_id,
                                             P_ACTION_TYPE        => 'UPDATE',
                                             P_LOG_ID             => vo_log_id,
                                             P_LOG_TYPE           => '04',
                                             P_LOG_MSG            => '采购状态=已取消，关联新建面料采购单号：' ||
                                                                     v_pid,
                                             P_OPERATE_FIELD      => 'FABRIC_STATUS',
                                             P_FIELD_TYPE         => 'VARCHAR2',
                                             P_OLD_CODE           => '',
                                             P_NEW_CODE           => 'S05',
                                             P_OLD_VALUE          => '',
                                             P_NEW_VALUE          => 'S05',
                                             P_USER_ID            => v_create_id,
                                             P_OPERATE_COMPANY_ID => v1_po_company_id,
                                             P_SEQ_NO             => 1,
                                             PO_LOG_ID            => vo_log_id);*/
    end loop;
  
  end p_action_a_prematerial_422_1;

  --校验取消原因
  procedure p_check_cancel_reason(v_cancel_reason in varchar2) is
  begin
    if trim(v_cancel_reason) is null then
      raise_application_error(-20002, '请填写取消原因！');
    end if;
    if length(v_cancel_reason) > 200 then
      raise_application_error(-20002, '取消原因不能200个字符！');
    end if;
  end p_check_cancel_reason;

  PROCEDURE p_fabric_purchase_sheet_group_key IS
    v_group_key varchar2(32);
    v_where     varchar2(1280);
    v_sql       varchar2(2000);
  begin
    for i in (select t.fabric_purchase_sheet_id,
                     t.company_id,
                     t.pro_supplier_code,
                     t.mater_supplier_code,
                     t.material_sku,
                     t.unit,
                     t.supplier_shades,
                     t.practical_door_with,
                     t.gram_weight,
                     t.material_specifications,
                     t.group_key
                from mrp.t_fabric_purchase_sheet t
               where t.group_key is null) loop
      if i.supplier_shades is not null then
        v_where := ' and t1.supplier_shades = ''' || i.supplier_shades || '''';
      else
        v_where := ' and t1.supplier_shades is null ';
      end if;
      if i.practical_door_with is not null then
        v_where := v_where || ' and t1.practical_door_with = ''' ||
                   i.practical_door_with || '''';
      else
        v_where := v_where || ' and t1.practical_door_with is null  ';
      end if;
      if i.gram_weight is not null then
        v_where := v_where || ' and t1.gram_weight = ''' || i.gram_weight || '''';
      else
        v_where := v_where || ' and t1.gram_weight is null ';
      end if;
      if i.material_specifications is not null then
        v_where := v_where || ' and t1.material_specifications = ''' ||
                   i.material_specifications || '''';
      else
        v_where := v_where || ' and t1.material_specifications is null ';
      end if;
    
      ---查找表里是否有相同的组合主键
      v_sql := q'[ select max(t1.group_key)
      from mrp.t_fabric_purchase_sheet t1
     where t1.pro_supplier_code =']' || i.pro_supplier_code || '''
       and t1.mater_supplier_code = ''' ||
               i.mater_supplier_code || '''
       and t1.material_sku = ''' || i.material_sku || '''
       and t1.unit = ''' || i.unit || '''' || v_where;
      execute immediate v_sql
        into v_group_key;
    
      if v_group_key = '0' or v_group_key is null then
        v_group_key := mrp.pkg_plat_comm.f_get_uuid();
      end if;
      update mrp.t_fabric_purchase_sheet t
         set t.group_key = v_group_key
       where t.fabric_purchase_sheet_id = i.fabric_purchase_sheet_id
         and t.company_id = i.company_id;
    end loop;
  end p_fabric_purchase_sheet_group_key;

  /*记录日志mrp_log*/
  PROCEDURE p_mrp_log(v_create_id       IN VARCHAR2,
                      v_operate_content IN VARCHAR2,
                      v_operate         IN VARCHAR2,
                      v_class_name      IN VARCHAR2,
                      v_method_name     IN VARCHAR2,
                      v_thirdpart_id    IN VARCHAR2) IS
  begin
    insert into mrp.mrp_log
      (id,
       user_name,
       operate_content,
       operate,
       create_time,
       class_name,
       method_name,
       thirdpart_id)
    values
      (mrp.pkg_plat_comm.f_get_mrp_keyid(pi_pre     => '1',
                                         pi_owner   => 'PLM',
                                         pi_seqname => 'SEQ_OUTMATERIAL_ID',
                                         pi_seqnum  => '999'),
       v_create_id,
       v_operate_content,
       v_operate,
       sysdate,
       v_class_name,
       v_method_name,
       v_thirdpart_id);
  
  end p_mrp_log;

  PROCEDURE P_GET_INGREDIENTS_BYSPU(PI_SPUID IN VARCHAR2, --SPU
                                    --pi_comapnyid IN VARCHAR2,
                                    PO_INGREDIENTS OUT VARCHAR2) IS
  
    V_INGREDIENTS VARCHAR2(2000);
  
  BEGIN
    SELECT MAX(CHENGFEN)
      INTO V_INGREDIENTS
      FROM (SELECT T.MATERIAL_SPU,
                   LISTAGG(T.INGREDIENT, ' ; ') WITHIN GROUP(ORDER BY T.MATERIAL_SPU) CHENGFEN
              FROM (SELECT A.MATERIAL_SPU,
                           T1.COMPANY_DICT_NAME || A.INGREDIENT_PROPORTION ||
                           A.PROPORTION_UNIT INGREDIENT
                      FROM MRP.MRP_MATERIAL_SPU_INGREDIENT_MAPPING A
                     INNER JOIN SCMDATA.SYS_COMPANY_DICT T1
                        ON A.MATERIAL_INGREDIENT_ID = T1.COMPANY_DICT_ID) T
             GROUP BY T.MATERIAL_SPU
            UNION
            SELECT T.MATERIAL_SPU,
                   LISTAGG(T.INGREDIENT, ';') WITHIN GROUP(ORDER BY T.MATERIAL_SPU)
              FROM (SELECT A.MATERIAL_SPU,
                           T1.COMPANY_DICT_NAME || A.INGREDIENT_PROPORTION ||
                           A.PROPORTION_UNIT INGREDIENT
                      FROM MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING A
                     INNER JOIN SCMDATA.SYS_COMPANY_DICT T1
                        ON A.MATERIAL_INGREDIENT_ID = T1.COMPANY_DICT_ID) T
             GROUP BY T.MATERIAL_SPU) A
     WHERE A.MATERIAL_SPU = PI_SPUID;
    PO_INGREDIENTS := V_INGREDIENTS;
  END P_GET_INGREDIENTS_BYSPU;

end pkg_bulk_cargo_bom;
/

