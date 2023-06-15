create or replace package plm.pkg_good_rela_plm is

  -- Author  : SANFU
  -- Created : 2022/8/16 9:32:42
  -- Purpose : 商品档案关联plm数据

  --新增货号关联逻辑
  procedure dual_after_create_good(p_rela_goo_id      varchar2,
                                   p_category         varchar2,
                                   p_cooperation_mode varchar2);

  --删除货号关联逻辑
  procedure dual_after_delete_good(p_rela_goo_id      varchar2,
                                   p_cooperation_mode varchar2);
  --修改货号采购定价关联逻辑
  procedure dual_after_modify_good_inprice(p_goo_id     varchar2,
                                           p_company_id varchar2,
                                           p_inprice    number);

  --修改货号合作模式关联逻辑
  procedure dual_after_modify_good_cooperation_mode(p_company_id           varchar2,
                                                    p_goo_id               varchar2,
                                                    p_rela_goo_id          varchar2,
                                                    p_new_cooperation_mode varchar2,
                                                    p_old_cooperation_mode varchar2);

  --重算某个货号的颜色
  procedure dual_after_dual_good_color(p_company_id     varchar2,
                                       p_goo_id         varchar2,
                                       p_inf_begin_time date default trunc(sysdate,
                                                                           
                                                                           'YYYY'));

  --启用bom需求
  procedure status_goods_fabric_set_bom_demand(p_goods_skc_code varchar2,
                                               p_status         number default 1,
                                               p_whether_del    number default 0);
end pkg_good_rela_plm;
/

create or replace package body plm.pkg_good_rela_plm is

  --新增货号关联逻辑
  procedure dual_after_create_good(p_rela_goo_id      varchar2,
                                   p_category         varchar2,
                                   p_cooperation_mode varchar2) is
    p_id varchar2(32);
  begin
    --为男装/女装/鞋包/内衣 才落表
    if p_category is null or p_category not in ('00', '01', '03', '08') then
      return;
    end if;
    --判断是odm还是oem
    if p_cooperation_mode = 'ODM' then
      p_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'odm_antenatal_task',
                                              v_column_name => 'odm_antenatal_task_id',
                                              v_pre         => 'DCQ' ||
                                                               substr(to_char(sysdate,
                                                                              'yyyy'),
                                                                      3,
                                                                      2),
                                              v_serail_num  => 6);
      --如果是odm落表oem部分
      merge into plm.odm_antenatal_task a
      using (select p_rela_goo_id article_no from dual) b
      on (a.article_no = b.article_no)
      when matched then
        update
           set a.task_status = 0,
               a.update_id   = 'ADMIN',
               a.update_time = sysdate
      when not matched then
        insert
          (a.odm_antenatal_task_id,
           a.task_status,
           a.create_time,
           a.article_no,
           a.whether_del,
           a.create_id,
           a.update_time,
           a.update_id)
        values
          (p_id, 0, sysdate, b.article_no, 0, 'ADMIN', null, null);
    
    elsif p_cooperation_mode = 'OEM' then
      p_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'oem_antenatal_task',
                                              v_column_name => 'oem_antenatal_task_id',
                                              v_pre         => 'ECQ' ||
                                                               substr(to_char(sysdate,
                                                                              'yyyy'),
                                                                      3,
                                                                      2),
                                              v_serail_num  => 6);
      --如果是oem落表oem部分
      merge into plm.oem_antenatal_task a
      using (select p_rela_goo_id article_no from dual) b
      on (a.article_no = b.article_no)
      when matched then
        update
           set a.task_status = 0,
               a.update_id   = 'ADMIN',
               a.update_time = sysdate
      when not matched then
        insert
          (a.oem_antenatal_task_id,
           a.task_status,
           a.create_time,
           a.article_no,
           a.whether_del,
           a.create_id,
           a.update_time,
           a.update_id)
        values
          (p_id, 0, sysdate, b.article_no, 0, 'ADMIN', null, null);
    end if;
  
  end dual_after_create_good;

  --删除货号关联逻辑
  procedure dual_after_delete_good(p_rela_goo_id      varchar2,
                                   p_cooperation_mode varchar2) is
  begin
    --判断合作类型
    if p_cooperation_mode = 'OEM' then
      update plm.oem_antenatal_task a
         set a.task_status = 2,
             a.update_id   = 'ADMIN',
             a.update_time = sysdate
       where a.article_no = p_rela_goo_id;
    elsif p_cooperation_mode = 'ODM' then
      update plm.odm_antenatal_task a
         set a.task_status = 2
       where a.article_no = p_rela_goo_id;
    end if;
  end dual_after_delete_good;

  --修改货号采购定价关联逻辑
  procedure dual_after_modify_good_inprice(p_goo_id     varchar2,
                                           p_company_id varchar2,
                                           p_inprice    number) is
  begin
    --非特价设定定价
    update plm.EXAMINE_PRICE a
       set a.current_quotation = p_inprice,
           a.update_id         = 'ADMIN',
           a.update_time       = sysdate
     where a.matching_goods_skc_code in
           (select c.commodity_color_code
              from scmdata.t_commodity_color c
             where c.goo_id = p_goo_id
               and c.company_id = p_company_id)
       and a.whether_special_adopt = 0;
    --核价状态
    update plm.EXAMINE_PRICE a
       set a.examine_price_status =
           (select case
                     when bc.extend_03 is not null then
                      case
                        when a.current_tier_price * (1 + bc.extend_03 / 100) >=
                             a.current_quotation then
                         1
                        else
                         2
                      end
                     when bc.extend_03 is null and bc.extend_04 is not null then
                      case
                        when a.current_tier_price + bc.extend_04 >=
                             a.current_quotation then
                         1
                        else
                         2
                      end
                   end
              from plm.quotation b
             inner join scmdata.sys_company_dict bc
                on bc.company_dict_type = 'PLM_READY_PRICE_CLASSIFICATION'
               and bc.company_id = p_company_id
               and bc.company_dict_value = b.quotation_classification
             where b.quotation_id = a.relate_quotation_id),
           a.update_id            = 'ADMIN',
           a.update_time          = sysdate
     where a.matching_goods_skc_code in
           (select c.commodity_color_code
              from scmdata.t_commodity_color c
             where c.goo_id = p_goo_id
               and c.company_id = p_company_id);
  end dual_after_modify_good_inprice;

  --修改货号合作模式关联逻辑
  procedure dual_after_modify_good_cooperation_mode(p_company_id           varchar2,
                                                    p_goo_id               varchar2,
                                                    p_rela_goo_id          varchar2,
                                                    p_new_cooperation_mode varchar2,
                                                    p_old_cooperation_mode varchar2) is
    p_i number(1) := 0;
  begin
    if p_new_cooperation_mode = p_old_cooperation_mode then
      return;
    end if;
    --如果不曾有产前任务，不继续处理
    if p_old_cooperation_mode = 'ODM' then
      select nvl(max(1), 0)
        into p_i
        from plm.odm_antenatal_task a
       where a.article_no = p_rela_goo_id
         and a.whether_del = 0;
      if p_i = 0 then
        return;
      end if;
    elsif p_old_cooperation_mode = 'OEM' then
      select nvl(max(1), 0)
        into p_i
        from plm.oem_antenatal_task a
       where a.article_no = p_rela_goo_id
         and a.whether_del = 0;
      if p_i = 0 then
        return;
      end if;
    end if;
    -- 2.1 【ODM产前任务】><【OEM产前任务】（唯一键=货号）
    if p_new_cooperation_mode = 'ODM' then
    
      merge into plm.odm_antenatal_task a
      using (select c.oem_antenatal_task_id odm_antenatal_task_id,
                    c.task_status,
                    c.create_time,
                    c.article_no,
                    c.whether_del,
                    c.create_id,
                    c.update_time,
                    c.update_id
               from plm.oem_antenatal_task c
              where c.article_no = p_rela_goo_id) b
      on (a.article_no = b.article_no)
      when not matched then
        insert
          (a.odm_antenatal_task_id,
           a.task_status,
           a.create_time,
           a.article_no,
           a.whether_del,
           a.create_id,
           a.update_time,
           a.update_id)
        values
          (b.odm_antenatal_task_id,
           b.task_status,
           b.create_time,
           b.article_no,
           b.whether_del,
           b.create_id,
           b.update_time,
           b.update_id)
      when matched then
        update
           set a.task_status = b.task_status,
               a.create_time = b.create_time,
               a.whether_del = b.whether_del,
               a.create_id   = b.create_id,
               a.update_time = b.update_time,
               a.update_id   = b.update_id;
      update plm.oem_antenatal_task a
         set a.whether_del = 1
       where a.article_no = p_rela_goo_id;
    elsif p_new_cooperation_mode = 'OEM' then
      merge into plm.oem_antenatal_task a
      using (select c.odm_antenatal_task_id oem_antenatal_task_id,
                    c.task_status,
                    c.create_time,
                    c.article_no,
                    c.whether_del,
                    c.create_id,
                    c.update_time,
                    c.update_id
               from plm.odm_antenatal_task c
              where c.article_no = p_rela_goo_id) b
      on (a.article_no = b.article_no)
      when not matched then
        insert
          (a.oem_antenatal_task_id,
           a.task_status,
           a.create_time,
           a.article_no,
           a.whether_del,
           a.create_id,
           a.update_time,
           a.update_id)
        values
          (b.oem_antenatal_task_id,
           b.task_status,
           b.create_time,
           b.article_no,
           b.whether_del,
           b.create_id,
           b.update_time,
           b.update_id)
      when matched then
        update
           set a.task_status = b.task_status,
               a.create_time = b.create_time,
               a.whether_del = b.whether_del,
               a.create_id   = b.create_id,
               a.update_time = b.update_time,
               a.update_id   = b.update_id;
      update plm.odm_antenatal_task a
         set a.whether_del = 1
       where a.article_no = p_rela_goo_id;
    end if;
  
    -- 2.2 【ODM货色SKC核价任务】><【OEM货色SKC核价任务】（唯一键=货色SKC）
    if p_new_cooperation_mode = 'ODM' then
      merge into plm.odm_goods_skc_examine_price_task a
      using (select c.goods_skc_examine_id,
                    c.goods_skc_code,
                    c.manual_order_number,
                    c.whether_del,
                    c.create_time,
                    c.create_id,
                    c.update_time,
                    c.update_id,
                    c.whether_special_adopt,
                    c.special_bargaining_price,
                    c.special_picture,
                    c.task_status
               from plm.oem_goods_skc_examine_price_task c
              where c.goods_skc_code in
                    (select cc.commodity_color_code
                       from scmdata.t_commodity_color cc
                      where cc.goo_id = p_goo_id
                        and cc.company_id = p_company_id)) b
      on (a.goods_skc_code = b.goods_skc_code)
      when not matched then
        insert
          (a.goods_skc_examine_id,
           a.goods_skc_code,
           a.manual_order_number,
           a.whether_del,
           a.create_time,
           a.create_id,
           a.update_time,
           a.update_id,
           a.whether_special_adopt,
           a.special_bargaining_price,
           a.special_picture,
           a.task_status)
        values
          (b.goods_skc_examine_id,
           b.goods_skc_code,
           b.manual_order_number,
           b.whether_del,
           b.create_time,
           b.create_id,
           b.update_time,
           b.update_id,
           b.whether_special_adopt,
           b.special_bargaining_price,
           b.special_picture,
           b.task_status)
      when matched then
        update
           set a.manual_order_number      = b.manual_order_number,
               a.whether_del              = b.whether_del,
               a.create_time              = b.create_time,
               a.create_id                = b.create_id,
               a.update_time              = b.update_time,
               a.update_id                = b.update_id,
               a.whether_special_adopt    = b.whether_special_adopt,
               a.special_bargaining_price = b.special_bargaining_price,
               a.special_picture          = b.special_picture,
               a.task_status              = b.task_status;
      update plm.oem_goods_skc_examine_price_task a
         set a.whether_del = 1
       where a.goods_skc_code in
             (select cc.commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id);
    elsif p_new_cooperation_mode = 'OEM' then
      merge into plm.oem_goods_skc_examine_price_task a
      using (select c.goods_skc_examine_id,
                    c.goods_skc_code,
                    c.manual_order_number,
                    c.whether_del,
                    c.create_time,
                    c.create_id,
                    c.update_time,
                    c.update_id,
                    c.whether_special_adopt,
                    c.special_bargaining_price,
                    c.special_picture,
                    c.task_status
               from plm.odm_goods_skc_examine_price_task c
              where c.goods_skc_code in
                    (select cc.commodity_color_code
                       from scmdata.t_commodity_color cc
                      where cc.goo_id = p_goo_id
                        and cc.company_id = p_company_id)) b
      on (a.goods_skc_code = b.goods_skc_code)
      when not matched then
        insert
          (a.goods_skc_examine_id,
           a.goods_skc_code,
           a.manual_order_number,
           a.whether_del,
           a.create_time,
           a.create_id,
           a.update_time,
           a.update_id,
           a.whether_special_adopt,
           a.special_bargaining_price,
           a.special_picture,
           a.task_status)
        values
          (b.goods_skc_examine_id,
           b.goods_skc_code,
           b.manual_order_number,
           b.whether_del,
           b.create_time,
           b.create_id,
           b.update_time,
           b.update_id,
           b.whether_special_adopt,
           b.special_bargaining_price,
           b.special_picture,
           b.task_status)
      when matched then
        update
           set a.manual_order_number      = b.manual_order_number,
               a.whether_del              = b.whether_del,
               a.create_time              = b.create_time,
               a.create_id                = b.create_id,
               a.update_time              = b.update_time,
               a.update_id                = b.update_id,
               a.whether_special_adopt    = b.whether_special_adopt,
               a.special_bargaining_price = b.special_bargaining_price,
               a.special_picture          = b.special_picture,
               a.task_status              = b.task_status;
      update plm.odm_goods_skc_examine_price_task a
         set a.whether_del = 1
       where a.goods_skc_code in
             (select cc.commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id);
    end if;
    -- 2.3 【ODM-核价任务版本信息】><【OEM-核价任务版本信息】（唯一键=货色SKC+版本号）
    if p_new_cooperation_mode = 'ODM' then
    
      merge into plm.ODM_EXAMINE_PRICE_TASK_VERSION a
      using (select c.version_code,
                    c.goods_skc_code,
                    c.examine_price_id,
                    c.whether_current_version,
                    c.create_time,
                    c.end_time,
                    c.task_version_id,
                    c.whether_del
               from plm.oem_examine_price_task_version c
              where c.goods_skc_code in
                    (select cc.commodity_color_code
                       from scmdata.t_commodity_color cc
                      where cc.goo_id = p_goo_id
                        and cc.company_id = p_company_id)) b
      on (a.goods_skc_code = b.goods_skc_code and a.version_code = b.version_code)
      when not matched then
        insert
          (a.version_code,
           a.goods_skc_code,
           a.examine_price_id,
           a.whether_current_version,
           a.create_time,
           a.end_time,
           a.task_version_id,
           a.whether_del)
        values
          (b.version_code,
           b.goods_skc_code,
           b.examine_price_id,
           b.whether_current_version,
           b.create_time,
           b.end_time,
           b.task_version_id,
           b.whether_del)
      when matched then
        update
           set a.examine_price_id        = b.examine_price_id,
               a.whether_current_version = b.whether_current_version,
               a.create_time             = b.create_time,
               a.end_time                = b.end_time,
               a.task_version_id         = b.task_version_id,
               a.whether_del             = b.whether_del;
      update plm.ODM_EXAMINE_PRICE_TASK_VERSION a
         set a.whether_del = 1
       where goods_skc_code in
             (select cc.commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id);
    elsif p_new_cooperation_mode = 'OEM' then
      merge into plm.OEM_EXAMINE_PRICE_TASK_VERSION a
      using (select c.version_code,
                    c.goods_skc_code,
                    c.examine_price_id,
                    c.whether_current_version,
                    c.create_time,
                    c.end_time,
                    c.task_version_id,
                    c.whether_del
               from plm.odm_examine_price_task_version c
              where c.goods_skc_code in
                    (select cc.commodity_color_code
                       from scmdata.t_commodity_color cc
                      where cc.goo_id = p_goo_id
                        and cc.company_id = p_company_id)) b
      on (a.goods_skc_code = b.goods_skc_code and a.version_code = b.version_code)
      when not matched then
        insert
          (a.version_code,
           a.goods_skc_code,
           a.examine_price_id,
           a.whether_current_version,
           a.create_time,
           a.end_time,
           a.task_version_id,
           a.whether_del)
        values
          (b.version_code,
           b.goods_skc_code,
           b.examine_price_id,
           b.whether_current_version,
           b.create_time,
           b.end_time,
           b.task_version_id,
           b.whether_del)
      when matched then
        update
           set a.examine_price_id        = b.examine_price_id,
               a.whether_current_version = b.whether_current_version,
               a.create_time             = b.create_time,
               a.end_time                = b.end_time,
               a.task_version_id         = b.task_version_id,
               a.whether_del             = b.whether_del;
      update plm.OEM_EXAMINE_PRICE_TASK_VERSION a
         set a.whether_current_version = 0
       where goods_skc_code in
             (select cc.commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id);
    end if;
  
    -- 2.4 【ODM-开发BOM表】><【OEM-开发BOM表】（唯一键=开发BOMID）
    --2.4.2 bom版本信息
    -- 2.5 【ODM-BOM单物料明细】><【OEM-BOM单物料明细】（唯一键=开发BOMID+物料明细ID）
    if p_new_cooperation_mode = 'ODM' then
    
      merge into plm.ODM_DEVELOP_BOM a
      using (select c.develop_bom_id,
                    c.goods_skc_code,
                    c.develop_bom_status,
                    c.bom_source,
                    c.relate_examine_price_id,
                    c.create_time,
                    c.create_id,
                    c.whether_del,
                    c.update_time,
                    c.update_id,
                    c.latest_confirmation_time,
                    c.create_supplier
               from plm.OEM_DEVELOP_BOM c
              where c.goods_skc_code in
                    (select cc.commodity_color_code
                       from scmdata.t_commodity_color cc
                      where cc.goo_id = p_goo_id
                        and cc.company_id = p_company_id)) b
      on (a.goods_skc_code = b.goods_skc_code)
      when not matched then
        insert
          (a.develop_bom_id,
           a.goods_skc_code,
           a.develop_bom_status,
           a.bom_source,
           a.relate_examine_price_id,
           a.create_time,
           a.create_id,
           a.whether_del,
           a.update_time,
           a.update_id,
           a.latest_confirmation_time,
           a.create_supplier)
        values
          (b.develop_bom_id,
           b.goods_skc_code,
           b.develop_bom_status,
           b.bom_source,
           b.relate_examine_price_id,
           b.create_time,
           b.create_id,
           b.whether_del,
           b.update_time,
           b.update_id,
           b.latest_confirmation_time,
           b.create_supplier)
      when matched then
        update
           set a.develop_bom_id           = b.develop_bom_id,
               a.develop_bom_status       = b.develop_bom_status,
               a.bom_source               = b.bom_source,
               a.relate_examine_price_id  = b.relate_examine_price_id,
               a.create_time              = b.create_time,
               a.create_id                = b.create_id,
               a.whether_del              = b.whether_del,
               a.update_time              = b.update_time,
               a.update_id                = b.update_id,
               a.latest_confirmation_time = b.latest_confirmation_time,
               a.create_supplier          = b.create_supplier;
    
      merge into plm.odm_goods_develop_bom_version a
      using (select c.goods_skc_code,
                    c.version_code,
                    c.version_code_corresponding_develop_bom_id,
                    c.whether_current_version,
                    c.create_time,
                    c.end_time,
                    c.bom_version_id,
                    c.whether_del,
                    c.update_time,
                    c.update_id
               from plm.oem_goods_develop_bom_version c
              where c.goods_skc_code in
                    (select cc.commodity_color_code
                       from scmdata.t_commodity_color cc
                      where cc.goo_id = p_goo_id
                        and cc.company_id = p_company_id)) b
      on (a.goods_skc_code = b.goods_skc_code and a.version_code = b.version_code)
      when matched then
        update
           set a.version_code_corresponding_develop_bom_id = b.version_code_corresponding_develop_bom_id,
               a.whether_current_version                   = b.whether_current_version,
               a.create_time                               = b.create_time,
               a.end_time                                  = b.end_time,
               a.bom_version_id                            = b.bom_version_id,
               a.whether_del                               = b.whether_del,
               a.update_time                               = b.update_time,
               a.update_id                                 = b.update_id
      when not matched then
        insert
          (a.goods_skc_code,
           a.version_code,
           a.version_code_corresponding_develop_bom_id,
           a.whether_current_version,
           a.create_time,
           a.end_time,
           a.bom_version_id,
           a.whether_del,
           a.update_time,
           a.update_id)
        values
          (b.goods_skc_code,
           b.version_code,
           b.version_code_corresponding_develop_bom_id,
           b.whether_current_version,
           b.create_time,
           b.end_time,
           b.bom_version_id,
           b.whether_del,
           b.update_time,
           b.update_id);
    
      merge into plm.odm_bom_material_detail a
      using (select d.material_detail_id,
                    d.relate_material_detail_examine_id,
                    d.relate_defect_material_detail_id,
                    d.wnether_defect_material,
                    d.material_detail_serial_num,
                    d.material_type,
                    d.application_site,
                    d.material_sku,
                    d.defect_material_name,
                    d.fabric_supplier_code,
                    d.singleton_consumption,
                    d.unit,
                    d.develop_bom_id,
                    d.whether_del,
                    d.create_time,
                    d.create_id,
                    d.update_time,
                    d.update_id
               from plm.oem_bom_material_detail d
              where d.develop_bom_id in
                    (select c.develop_bom_id
                       from plm.OEM_DEVELOP_BOM c
                      where c.goods_skc_code in
                            (select cc.commodity_color_code
                               from scmdata.t_commodity_color cc
                              where cc.goo_id = p_goo_id
                                and cc.company_id = p_company_id))) b
      on (a.material_detail_id = b.material_detail_id and a.develop_bom_id = b.develop_bom_id)
      when not matched then
        insert
          (a.material_detail_id,
           a.relate_material_detail_examine_id,
           a.relate_defect_material_detail_id,
           a.wnether_defect_material,
           a.material_detail_serial_num,
           a.material_type,
           a.application_site,
           a.material_sku,
           a.defect_material_name,
           a.fabric_supplier_code,
           a.singleton_consumption,
           a.unit,
           a.develop_bom_id,
           a.whether_del,
           a.create_time,
           a.create_id,
           a.update_time,
           a.update_id)
        values
          (b.material_detail_id,
           b.relate_material_detail_examine_id,
           b.relate_defect_material_detail_id,
           b.wnether_defect_material,
           b.material_detail_serial_num,
           b.material_type,
           b.application_site,
           b.material_sku,
           b.defect_material_name,
           b.fabric_supplier_code,
           b.singleton_consumption,
           b.unit,
           b.develop_bom_id,
           b.whether_del,
           b.create_time,
           b.create_id,
           b.update_time,
           b.update_id)
      when matched then
        update
           set a.relate_material_detail_examine_id = b.relate_material_detail_examine_id,
               a.relate_defect_material_detail_id  = b.relate_defect_material_detail_id,
               a.wnether_defect_material           = b.wnether_defect_material,
               a.material_detail_serial_num        = b.material_detail_serial_num,
               a.material_type                     = b.material_type,
               a.application_site                  = b.application_site,
               a.material_sku                      = b.material_sku,
               a.defect_material_name              = b.defect_material_name,
               a.fabric_supplier_code              = b.fabric_supplier_code,
               a.singleton_consumption             = b.singleton_consumption,
               a.unit                              = b.unit,
               a.whether_del                       = b.whether_del,
               a.create_time                       = b.create_time,
               a.create_id                         = b.create_id,
               a.update_time                       = b.update_time,
               a.update_id                         = b.update_id;
    
      update plm.OEM_DEVELOP_BOM a
         set a.whether_del = 1
       where a.goods_skc_code in
             (select cc.commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id);
      update plm.oem_bom_material_detail d
         set d.whether_del = 1
       where d.develop_bom_id in
             (select c.develop_bom_id
                from plm.OEM_DEVELOP_BOM c
               where c.goods_skc_code in
                     (select cc.commodity_color_code
                        from scmdata.t_commodity_color cc
                       where cc.goo_id = p_goo_id
                         and cc.company_id = p_company_id));
    elsif p_new_cooperation_mode = 'OEM' then
      merge into plm.OEM_DEVELOP_BOM a
      using (select c.develop_bom_id,
                    c.goods_skc_code,
                    c.develop_bom_status,
                    c.bom_source,
                    c.relate_examine_price_id,
                    c.create_time,
                    c.create_id,
                    c.whether_del,
                    c.update_time,
                    c.update_id,
                    c.latest_confirmation_time,
                    c.create_supplier
               from plm.ODM_DEVELOP_BOM c
              where c.goods_skc_code in
                    (select cc.commodity_color_code
                       from scmdata.t_commodity_color cc
                      where cc.goo_id = p_goo_id
                        and cc.company_id = p_company_id)) b
      on (a.goods_skc_code = b.goods_skc_code)
      when not matched then
        insert
          (a.develop_bom_id,
           a.goods_skc_code,
           a.develop_bom_status,
           a.bom_source,
           a.relate_examine_price_id,
           a.create_time,
           a.create_id,
           a.whether_del,
           a.update_time,
           a.update_id,
           a.latest_confirmation_time,
           a.create_supplier)
        values
          (b.develop_bom_id,
           b.goods_skc_code,
           b.develop_bom_status,
           b.bom_source,
           b.relate_examine_price_id,
           b.create_time,
           b.create_id,
           b.whether_del,
           b.update_time,
           b.update_id,
           b.latest_confirmation_time,
           b.create_supplier)
      when matched then
        update
           set a.develop_bom_id           = b.develop_bom_id,
               a.develop_bom_status       = b.develop_bom_status,
               a.bom_source               = b.bom_source,
               a.relate_examine_price_id  = b.relate_examine_price_id,
               a.create_time              = b.create_time,
               a.create_id                = b.create_id,
               a.whether_del              = b.whether_del,
               a.update_time              = b.update_time,
               a.update_id                = b.update_id,
               a.latest_confirmation_time = b.latest_confirmation_time,
               a.create_supplier          = b.create_supplier;
      merge into plm.oem_goods_develop_bom_version a
      using (select c.goods_skc_code,
                    c.version_code,
                    c.version_code_corresponding_develop_bom_id,
                    c.whether_current_version,
                    c.create_time,
                    c.end_time,
                    c.bom_version_id,
                    c.whether_del,
                    c.update_time,
                    c.update_id
               from plm.odm_goods_develop_bom_version c
              where c.goods_skc_code in
                    (select cc.commodity_color_code
                       from scmdata.t_commodity_color cc
                      where cc.goo_id = p_goo_id
                        and cc.company_id = p_company_id)) b
      on (a.goods_skc_code = b.goods_skc_code and a.version_code = b.version_code)
      when matched then
        update
           set a.version_code_corresponding_develop_bom_id = b.version_code_corresponding_develop_bom_id,
               a.whether_current_version                   = b.whether_current_version,
               a.create_time                               = b.create_time,
               a.end_time                                  = b.end_time,
               a.bom_version_id                            = b.bom_version_id,
               a.whether_del                               = b.whether_del,
               a.update_time                               = b.update_time,
               a.update_id                                 = b.update_id
      when not matched then
        insert
          (a.goods_skc_code,
           a.version_code,
           a.version_code_corresponding_develop_bom_id,
           a.whether_current_version,
           a.create_time,
           a.end_time,
           a.bom_version_id,
           a.whether_del,
           a.update_time,
           a.update_id)
        values
          (b.goods_skc_code,
           b.version_code,
           b.version_code_corresponding_develop_bom_id,
           b.whether_current_version,
           b.create_time,
           b.end_time,
           b.bom_version_id,
           b.whether_del,
           b.update_time,
           b.update_id);
    
      merge into plm.oem_bom_material_detail a
      using (select d.material_detail_id,
                    d.relate_material_detail_examine_id,
                    d.relate_defect_material_detail_id,
                    d.wnether_defect_material,
                    d.material_detail_serial_num,
                    d.material_type,
                    d.application_site,
                    d.material_sku,
                    d.defect_material_name,
                    d.fabric_supplier_code,
                    d.singleton_consumption,
                    d.unit,
                    d.develop_bom_id,
                    d.whether_del,
                    d.create_time,
                    d.create_id,
                    d.update_time,
                    d.update_id
               from plm.odm_bom_material_detail d
              where d.develop_bom_id in
                    (select c.develop_bom_id
                       from plm.OEM_DEVELOP_BOM c
                      where c.goods_skc_code in
                            (select cc.commodity_color_code
                               from scmdata.t_commodity_color cc
                              where cc.goo_id = p_goo_id
                                and cc.company_id = p_company_id))) b
      on (a.material_detail_id = b.material_detail_id and a.develop_bom_id = b.develop_bom_id)
      when not matched then
        insert
          (a.material_detail_id,
           a.relate_material_detail_examine_id,
           a.relate_defect_material_detail_id,
           a.wnether_defect_material,
           a.material_detail_serial_num,
           a.material_type,
           a.application_site,
           a.material_sku,
           a.defect_material_name,
           a.fabric_supplier_code,
           a.singleton_consumption,
           a.unit,
           a.develop_bom_id,
           a.whether_del,
           a.create_time,
           a.create_id,
           a.update_time,
           a.update_id)
        values
          (b.material_detail_id,
           b.relate_material_detail_examine_id,
           b.relate_defect_material_detail_id,
           b.wnether_defect_material,
           b.material_detail_serial_num,
           b.material_type,
           b.application_site,
           b.material_sku,
           b.defect_material_name,
           b.fabric_supplier_code,
           b.singleton_consumption,
           b.unit,
           b.develop_bom_id,
           b.whether_del,
           b.create_time,
           b.create_id,
           b.update_time,
           b.update_id)
      when matched then
        update
           set a.relate_material_detail_examine_id = b.relate_material_detail_examine_id,
               a.relate_defect_material_detail_id  = b.relate_defect_material_detail_id,
               a.wnether_defect_material           = b.wnether_defect_material,
               a.material_detail_serial_num        = b.material_detail_serial_num,
               a.material_type                     = b.material_type,
               a.application_site                  = b.application_site,
               a.material_sku                      = b.material_sku,
               a.defect_material_name              = b.defect_material_name,
               a.fabric_supplier_code              = b.fabric_supplier_code,
               a.singleton_consumption             = b.singleton_consumption,
               a.unit                              = b.unit,
               a.whether_del                       = b.whether_del,
               a.create_time                       = b.create_time,
               a.create_id                         = b.create_id,
               a.update_time                       = b.update_time,
               a.update_id                         = b.update_id;
      update plm.odm_bom_material_detail d
         set d.whether_del = 1
       where d.develop_bom_id in
             (select c.develop_bom_id
                from plm.OEM_DEVELOP_BOM c
               where c.goods_skc_code in
                     (select cc.commodity_color_code
                        from scmdata.t_commodity_color cc
                       where cc.goo_id = p_goo_id
                         and cc.company_id = p_company_id));
      update plm.odm_goods_develop_bom_version a
         set a.whether_del = 1
       where a.goods_skc_code in
             (select cc.commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id);
      update plm.ODM_DEVELOP_BOM a
         set a.whether_del = 1
       where a.goods_skc_code in
             (select cc.commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id);
    
    end if;
  
    -- 2.6 【唛架文件】【纸样文件】
    update plm.Pattern_File a
       set a.cooperation_mode = p_new_cooperation_mode,
           a.update_id        = 'ADMIN',
           a.update_time      = sysdate
     where a.goods_skc_code in
           (select cc.commodity_color_code
              from scmdata.t_commodity_color cc
             where cc.goo_id = p_goo_id
               and cc.company_id = p_company_id);
  
    update plm.MARKER_FILE a
       set a.cooperation_mode = p_new_cooperation_mode,
           a.update_id        = 'ADMIN',
           a.update_time      = sysdate
     where a.goods_skc_code in
           (select cc.commodity_color_code
              from scmdata.t_commodity_color cc
             where cc.goo_id = p_goo_id
               and cc.company_id = p_company_id);
  end dual_after_modify_good_cooperation_mode;

  --重算某个货号的颜色
  procedure dual_after_dual_good_color(p_company_id     varchar2,
                                       p_goo_id         varchar2,
                                       p_inf_begin_time date default trunc(sysdate,
                                                                           'YYYY')) is
    p_commodity_info scmdata.t_commodity_info%rowtype;
    p_i              number(1) := 0;
    p_has_color_new  number(1) := 0;
  begin
    --获取商品档案信息
    select *
      into p_commodity_info
      from scmdata.t_commodity_info a
     where a.company_id = p_company_id
       and a.goo_id = p_goo_id;
    if p_commodity_info.category not in ('00', '01', '03', '06') or
       p_commodity_info.cooperation_mode is null then
      return;
    end if;
    --查看是否有颜色新增
    select nvl(max(1), 0)
      into p_has_color_new
      from scmdata.t_commodity_color a
     where a.goo_id = p_goo_id
       and a.company_id = p_company_id
       and a.create_time > p_inf_begin_time;
  
    --如果不曾有产前任务，不继续处理(但存在颜色新增的需要补充产前任务）
    if p_commodity_info.cooperation_mode = 'ODM' then
      select nvl(max(1), 0)
        into p_i
        from plm.odm_antenatal_task a
       where a.article_no = p_commodity_info.rela_goo_id
         and a.whether_del = 0;
      if p_i = 0 and p_has_color_new = 0 then
      
        return;
      elsif p_i = 0 and p_has_color_new = 1 then
        plm.pkg_good_rela_plm.dual_after_create_good(p_rela_goo_id      => p_commodity_info.rela_goo_id,
                                                     p_category         => p_commodity_info.category,
                                                     p_cooperation_mode => p_commodity_info.cooperation_mode);
      end if;
    elsif p_commodity_info.cooperation_mode = 'OEM' then
      select nvl(max(1), 0)
        into p_i
        from plm.oem_antenatal_task a
       where a.article_no = p_commodity_info.rela_goo_id
         and a.whether_del = 0;
      if p_i = 0 and p_has_color_new = 0 then
      
        return;
      elsif p_i = 0 and p_has_color_new = 1 then
        plm.pkg_good_rela_plm.dual_after_create_good(p_rela_goo_id      => p_commodity_info.rela_goo_id,
                                                     p_category         => p_commodity_info.category,
                                                     p_cooperation_mode => p_commodity_info.cooperation_mode);
      end if;
    end if;
  
    if p_commodity_info.cooperation_mode is not null and
       p_commodity_info.cooperation_mode = 'ODM' then
      --对启用的数据merge
      merge into plm.ODM_GOODS_SKC_EXAMINE_PRICE_TASK a
      using (select cc.commodity_color_code || '01' goods_skc_examine_id,
                    cc.colorname,
                    color_code,
                    commodity_color_code
               from scmdata.t_commodity_color cc
              where cc.goo_id = p_goo_id
                and cc.company_id = p_company_id
                and cc.skc_status = 1
                and cc.create_time > p_inf_begin_time) b
      on (a.goods_skc_examine_id = b.goods_skc_examine_id)
      when not matched then
        insert
          (a.goods_skc_examine_id,
           a.goods_skc_code,
           a.manual_order_number,
           a.whether_del,
           a.create_time,
           a.create_id,
           a.update_time,
           a.update_id,
           a.whether_special_adopt,
           a.special_bargaining_price,
           a.special_picture,
           a.task_status)
        values
          (b.goods_skc_examine_id,
           b.commodity_color_code,
           null,
           0,
           sysdate,
           'ADMIN',
           null,
           null,
           0,
           null,
           null,
           1)
      when matched then
        update
           set a.task_status = 1,
               a.update_id   = 'ADMIN',
               a.update_time = sysdate;
    
      --对被禁用的数据merge
      update plm.ODM_GOODS_SKC_EXAMINE_PRICE_TASK a
         set a.task_status = 0,
             a.update_id   = 'ADMIN',
             a.update_time = sysdate
       where a.goods_skc_code in
             (select commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id
                 and cc.skc_status = 0);
    
    elsif p_commodity_info.cooperation_mode is not null and
          p_commodity_info.cooperation_mode = 'OEM' then
      --对启用的数据merge
      merge into plm.OEM_GOODS_SKC_EXAMINE_PRICE_TASK a
      using (select cc.commodity_color_code || '01' goods_skc_examine_id,
                    cc.colorname,
                    color_code,
                    commodity_color_code,
                    cc.create_time
               from scmdata.t_commodity_color cc
              where cc.goo_id = p_goo_id
                and cc.company_id = p_company_id
                and cc.skc_status = 1) b
      on (a.goods_skc_examine_id = b.goods_skc_examine_id)
      when not matched then
        insert
          (a.goods_skc_examine_id,
           a.goods_skc_code,
           a.manual_order_number,
           a.whether_del,
           a.create_time,
           a.create_id,
           a.update_time,
           a.update_id,
           a.whether_special_adopt,
           a.special_bargaining_price,
           a.special_picture,
           a.task_status)
        values
          (b.goods_skc_examine_id,
           b.commodity_color_code,
           null,
           0,
           sysdate,
           'ADMIN',
           null,
           null,
           0,
           null,
           null,
           1)
      when matched then
        update
           set a.task_status = 1,
               a.update_id   = 'ADMIN',
               a.update_time = sysdate
         where b.create_time > p_inf_begin_time;
      --对被禁用的数据merge
      update plm.OEM_GOODS_SKC_EXAMINE_PRICE_TASK a
         set a.task_status = 0,
             a.update_id   = 'ADMIN',
             a.update_time = sysdate
       where a.goods_skc_code in
             (select commodity_color_code
                from scmdata.t_commodity_color cc
               where cc.goo_id = p_goo_id
                 and cc.company_id = p_company_id
                 and cc.skc_status = 0);
    end if;
  
  end dual_after_dual_good_color;

  procedure status_goods_fabric_set_bom_demand(p_goods_skc_code varchar2,
                                               p_status         number,
                                               p_whether_del    number) is
  begin
    if p_whether_del = 1 then
      update plm.goods_fabric_set_bom_demand a
         set a.whether_del               = 1,
             a.update_id                 = 'ADMIN',
             a.update_time               = sysdate
       where a.goods_skc_code = p_goods_skc_code;
    elsif p_status=0 then
      update plm.goods_fabric_set_bom_demand a
         set a.total_supplier_bom_status = 0,
             a.whether_del               = 0,
             a.update_id                 = 'ADMIN',
             a.update_time               = sysdate
       where a.goods_skc_code = p_goods_skc_code;
      if sql%rowcount = 0 then
        insert into plm.goods_fabric_set_bom_demand
          (goods_skc_code,
           whether_del,
           total_supplier_bom_status,
           create_id,
           create_time,
           update_id,
           update_time,
           goods_fabric_set_bom_demand_id)
        values
          (p_goods_skc_code,
           0,
           0,
           'SYSTEM',
           sysdate,
           'SYSTEM',
           sysdate,
           plm.pkg_plat_comm.f_get_uuid());
      end if;
    else 
      update plm.goods_fabric_set_bom_demand a
         set a.whether_del               = 0,
             a.update_id                 = 'ADMIN',
             a.update_time               = sysdate
       where a.goods_skc_code = p_goods_skc_code;
      if sql%rowcount = 0 then
        insert into plm.goods_fabric_set_bom_demand
          (goods_skc_code,
           whether_del,
           total_supplier_bom_status,
           create_id,
           create_time,
           update_id,
           update_time,
           goods_fabric_set_bom_demand_id)
        values
          (p_goods_skc_code,
           0,
           0,
           'SYSTEM',
           sysdate,
           'SYSTEM',
           sysdate,
           plm.pkg_plat_comm.f_get_uuid());
      end if;
    end if;
  
  end status_goods_fabric_set_bom_demand;

end pkg_good_rela_plm;
/

