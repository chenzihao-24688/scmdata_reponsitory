create or replace package scmdata.PKG_QCFACTORY_CONFIG is

  -- Author  : SANFU
  -- Created : 2022/5/7 14:53:26
  -- Purpose : qc工厂配置
  --根据qc组id，工厂id，企业id，分类重算qc与工厂分类关联表
  procedure p_recal_qc_factory_category_config_by_group(p_qc_group_id  varchar2 default null,
                                                        p_category     varchar2 default null,
                                                        p_product_cate varchar2 default null,
                                                        p_factory_code varchar2 default null,
                                                        p_company_id   varchar2 default null);

  --根据qc组id重算qc与工厂子类关联表
  procedure p_recal_qc_factory_detail_config_by_group_cate(p_qc_group_id  varchar2 default null,
                                                           p_category     varchar2 default null,
                                                           p_factory_code varchar2 default null,
                                                           p_company_id   varchar2 default null);

  --根据qc组id重算qc与工厂子类关联头表
  procedure p_recal_qc_factory_head_config_by_group_cate(p_qc_group_id  varchar2 default null,
                                                         p_factory_code varchar2 default null,
                                                         p_company_id   varchar2 default null);

  --qc组
  function f_get_qc_group_id_by_factory(p_factory_code varchar2,
                                        p_company_id   varchar2)
    return varchar2;

  --qc组
  function f_get_qc_group_name(pi_company_province in varchar2,
                               pi_company_city     in varchar2,
                               pi_category         in varchar2,
                               pi_product_cate     in varchar2,
                               pi_subcategory      in varchar2,
                               pi_compid           in varchar2)
    return varchar2;

  --qc组
  procedure p_get_qc_group_name(pi_company_province in varchar2,
                                pi_company_city     in varchar2,
                                pi_category         in varchar2,
                                pi_product_cate     in varchar2,
                                pi_subcategory      in varchar2,
                                pi_compid           in varchar2,
                                po_group_id         OUT VARCHAR2,
                                po_group_name       out varchar2,
                                po_group_leader     out varchar2);

  --待产前会清单指定qc
  procedure p_appoint_qc_meeting(pi_goo_id        in varchar2,
                                 pi_supplier_code in varchar2,
                                 pi_factory_code  in varchar2,
                                 pi_company_id    in varchar2,
                                 pi_operate_id    in varchar2,
                                 pi_target_id     in varchar2);

  --待查货清单指定qc
  procedure p_appoint_qc_check(pi_order_id      in varchar2,
                               pi_qc_check_node in varchar2,
                               pi_company_id    in varchar2,
                               pi_operate_id    in varchar2,
                               pi_target_id     in varchar2);

  --禁用/启用工厂对应配置
  procedure p_status_qc_factory_config_by_factory(p_factory_code varchar2,
                                                  p_company_id   varchar2,
                                                  p_status       number);
  --删除qc组对应配置
  procedure p_delete_qc_factory_config_by_qc_group(p_qc_group_id  varchar2,
                                                   p_category     varchar2 default null,
                                                   p_product_cate varchar2 default null);

  --删除工厂+分类+生产类别对应配置
  procedure p_delete_qc_factory_config_by_pro(p_factory_code varchar2,
                                              p_company_id   varchar2,
                                              p_category     varchar2 default null,
                                              p_product_cate varchar2 default null);

  --启用/新增工厂+分类+生产类别对应配置
  procedure p_enable_qc_factory_config_by_pro(p_supplier_info varchar2,
                                              p_company_id    varchar2,
                                              p_category      varchar2 default null,
                                              p_product_cate  varchar2 default null,
                                              p_subcategory   varchar2 default null);

  --启用c组对应配置
  procedure p_enable_qc_factory_config_by_qc_group(p_qc_group_id  varchar2 default null,
                                                   p_category     varchar2 default null,
                                                   p_product_cate varchar2 default null,
                                                   p_company_id   varchar2 default null,
                                                   p_factory_code varchar2 default null);

  --去掉所有配置中的某个用户
  procedure p_delete_qc_user(p_user_id varchar2, p_company_id varchar2);

  --禁用/启用qc组对应配置
  procedure p_status_qc_factory_config_by_qc_group(p_qc_group_id varchar2,
                                                   p_company_id  varchar2,
                                                   p_status      number);

  --根据区域组，刷新数据（如果qc组变更就需要更新，如果没有变更就不更新
  procedure p_change_qc_factory_config_by_config_change(p_qc_group_id varchar2,
                                                        p_category    varchar2);

  --根据分类，刷新数据（如果qc组变更就需要更新，如果没有变更就不更新
  procedure p_change_qc_factory_config_by_coop_scope_change(p_supplier_info    varchar2,
                                                            p_old_category     varchar2,
                                                            p_old_product_cate varchar2,
                                                            p_old_subcategory  varchar2,
                                                            p_new_category     varchar2,
                                                            p_new_product_cate varchar2,
                                                            p_new_subcategory  varchar2);

  --根据区域组，刷新数据（如果qc组变更就需要更新，如果没有变更就不更新
  procedure p_change_qc_factory_config_by_area_change(p_supplier_info        varchar2,
                                                      p_old_company_province varchar2,
                                                      p_old_company_city     varchar2,
                                                      p_new_company_province varchar2,
                                                      p_new_company_city     varchar2);

end PKG_QCFACTORY_CONFIG;
/

create or replace package body scmdata.PKG_QCFACTORY_CONFIG is

  --根据qc组id，工厂id，企业id，分类重算qc与工厂分类关联表
  procedure p_recal_qc_factory_category_config_by_group(p_qc_group_id  varchar2 default null,
                                                        p_category     varchar2 default null,
                                                        p_product_cate varchar2 default null,
                                                        p_factory_code varchar2 default null,
                                                        p_company_id   varchar2 default null) is
    p_sql clob;
  begin
    p_sql := q'[merge into scmdata.t_qc_factory_config_category a
    using (select max(aa.company_id) company_id,
                  si.supplier_code factory_code,
                  bb.category industry_classification,
                  0 pause,
                  'ADMIN' create_id,
                  sysdate create_time,
                  'ADMIN' update_id,
                  sysdate update_time,
                  null qc_user_id,
                  max(aa.qc_group_leader) qc_manage,
                  max(aa.qc_group) qc_group,
                  max(cu.company_user_name) qc_manage_name,
                  null qc_user_name,
                  listagg(distinct cc.product_cate, ';') production_category,
                  listagg(distinct cs.coop_product_cate,';') FACTORY_PRODUCTION_CATEGORY,
                  aa.qc_group_id
             from scmdata.t_qc_group_config aa
            inner join scmdata.t_qc_group_cate_config bb
               on bb.qc_group_id = aa.qc_group_id
            inner join scmdata.t_qc_group_subcate_config cc
               on bb.qcgroup_cate_config_id = cc.qcgroup_cate_config_id
            INNER JOIN scmdata.t_supplier_group_area_config ee
               on ee.group_type = 'GROUP_QC'
              AND instr(';' || bb.area_config_id || ';',
                        ';' || ee.group_area_config_id || ';') > 0
            inner join scmdata.t_supplier_info si
               on si.company_id = aa.company_id
              and instr(';' || ee.city_id || ';',
                        ';' || si.company_city || ';') > 0
              and instr(';' || ee.province_id || ';',
                        ';' || si.company_province || ';') > 0
            left join scmdata.t_coop_scope cs
               on cs.coop_product_cate = cc.product_cate
              and cs.supplier_info_id = si.supplier_info_id
              and cs.coop_classification = cc.category
              and cs.pause=0
              and exists (select 1
                     from (SELECT REGEXP_SUBSTR(cc.subcategory,
                                                '[^;]+',
                                                1,
                                                LEVEL,
                                                'i') y
                             FROM dual
                           CONNECT BY LEVEL <=
                                      LENGTH(cc.subcategory) -
                                      LENGTH(REGEXP_REPLACE(cc.subcategory,
                                                            ';',
                                                            '')) + 1) yy
                    where instr(';' || cs.coop_subcategory || ';',
                                ';' || yy.y || ';') > 0)
            inner join scmdata.sys_company_user cu
               on cu.company_id = aa.company_id
              and cu.user_id = aa.qc_group_leader
            where aa.pause = 1
              and bb.pause = 1
              and cc.pause = 1
              and ee.pause = 1]';
  
    --补充条件
    if p_qc_group_id is not null then
      p_sql := p_sql || q'[ and aa.qc_group_id=']' || p_qc_group_id || '''';
    end if;
    if p_category is not null then
      p_sql := p_sql || q'[ and cc.category=']' || p_category || '''';
    end if;
    if p_product_cate is not null then
      p_sql := p_sql || q'[ and cc.product_cate=']' || p_product_cate || '''';
    end if;
    if p_factory_code is not null then
      p_sql := p_sql || q'[ and si.supplier_code=']' || p_factory_code || '''';
    end if;
    if p_company_id is not null then
      p_sql := p_sql || q'[ and aa.company_id=']' || p_company_id || '''';
    end if;
    --测试C01198 生产C00563 C00216
    p_sql := p_sql || q'[
              and si.supplier_code not in ('C00563','C00216')
              and si.status = 1
              --and cs.pause = 0
              and (si.pause in (0, 2) or
                  (si.pause = 1 and
                  (si.supplier_code, si.company_id) in
                  (select os.factory_code supplier_code, os.company_id
                       from scmdata.t_ordered oe
                      inner join scmdata.t_orders os
                         on oe.order_code = os.order_id
                        and oe.company_id = os.company_id
                      where oe.finish_time_scm is null)))
            group by aa.qc_group_id, si.supplier_code, bb.category
            having max(cs.coop_classification) is not null) b
    on (a.company_id = b.company_id and a.factory_code = b.factory_code and a.industry_classification = b.industry_classification and a.qc_group_id = b.qc_group_id)
    when not matched then
      insert
        (a.qc_factory_config_category_id,
         a.company_id,
         a.factory_code,
         a.industry_classification,
         a.pause,
         a.create_id,
         a.create_time,
         a.update_id,
         a.update_time,
         a.qc_user_id,
         a.qc_manage,
         a.qc_group,
         a.qc_manage_name,
         a.qc_user_name,
         a.production_category,
         a.qc_group_id,
         a.FACTORY_PRODUCTION_CATEGORY)
      values
        (scmdata.f_get_uuid(),
         b.company_id,
         b.factory_code,
         b.industry_classification,
         b.pause,
         b.create_id,
         b.create_time,
         b.update_id,
         b.update_time,
         b.qc_user_id,
         b.qc_manage,
         b.qc_group,
         b.qc_manage_name,
         b.qc_user_name,
         b.production_category,
         b.qc_group_id,
         b.FACTORY_PRODUCTION_CATEGORY)
    when matched then
      update
         set a.production_category =b.production_category,
              a.FACTORY_PRODUCTION_CATEGORY=b.FACTORY_PRODUCTION_CATEGORY]';
    EXECUTE IMMEDIATE p_sql;
  
  end p_recal_qc_factory_category_config_by_group;

  --根据qc组id重算qc与工厂子类关联表
  procedure p_recal_qc_factory_detail_config_by_group_cate(p_qc_group_id  varchar2 default null,
                                                           p_category     varchar2 default null,
                                                           p_factory_code varchar2 default null,
                                                           p_company_id   varchar2 default null) is
    p_sql clob;
  begin
    --根据子表合并主表
    p_sql := q'[merge into scmdata.t_qc_factory_config_detail a
    using (select a.qc_factory_config_category_id,
                  a.company_id company_id,
                  a.factory_code factory_code,
                  a.industry_classification industry_classification,
                  gb.group_dict_value production_category,
                  gc.company_dict_value product_subclass,
                  case
                    when a.pause = 0 and gb.pause = 0 and gc.pause = 0 then
                     0
                    else
                     1
                  end pause,
                  a.create_id,
                  a.create_time,
                  a.update_id,
                  a.update_time,
                  a.qc_user_id,
                  a.qc_manage,
                  a.qc_group,
                  a.qc_manage_name,
                  a.qc_user_name,
                  a.qc_group_id
             from scmdata.t_qc_factory_config_category a
            inner join scmdata.t_qc_group_config aa
               on a.qc_group_id = aa.qc_group_id
            inner join scmdata.t_qc_group_cate_config bb
               on bb.qc_group_id = aa.qc_group_id
              and bb.category = a.industry_classification
              and bb.pause = 1
            inner join scmdata.t_qc_group_subcate_config cc
               on cc.qcgroup_cate_config_id = bb.qcgroup_cate_config_id
              and cc.category = bb.category
                 --and cc.product_cate = p_product_cate
              and cc.pause = 1
            inner join scmdata.sys_group_dict gb
               on gb.group_dict_type = cc.category
              and gb.group_dict_value = cc.product_cate
            inner join scmdata.sys_company_dict gc
               on gc.company_dict_type = gb.group_dict_value
              and gc.company_id = a.company_id
              and instr(';' || cc.subcategory || ';',
                        ';' || company_dict_value || ';') > 0
            where aa.pause=1
            and bb.pause=1
            and cc.pause=1]';
  
    --补充条件
    if p_qc_group_id is not null then
      p_sql := p_sql || q'[ and aa.qc_group_id=']' || p_qc_group_id || '''';
    end if;
    if p_category is not null then
      p_sql := p_sql || q'[ and cc.category=']' || p_category || '''';
    end if;
    if p_factory_code is not null then
      p_sql := p_sql || q'[ and a.factory_code=']' || p_factory_code || '''';
    end if;
    if p_company_id is not null then
      p_sql := p_sql || q'[ and a.company_id=']' || p_company_id || '''';
    end if;
  
    p_sql := p_sql || q'[  ) b
    on (a.factory_code = b.factory_code and a.company_id = b.company_id and a.industry_classification = b.industry_classification and a.production_category = b.production_category and a.product_subclass = b.product_subclass)
    when not matched then
      insert
        (a.qc_factory_config_detail_id,
         a.company_id,
         a.factory_code,
         a.industry_classification,
         a.production_category,
         a.product_subclass,
         a.pause,
         a.create_id,
         a.create_time,
         a.update_id,
         a.update_time,
         a.qc_user_id,
         a.qc_group,
         a.qc_manage,
         a.qc_manage_name,
         a.qc_user_name,
         a.qc_group_id)
      values
        (scmdata.f_get_uuid(),
         b.company_id,
         b.factory_code,
         b.industry_classification,
         b.production_category,
         b.product_subclass,
         b.pause,
         b.create_id,
         b.create_time,
         b.update_id,
         b.update_time,
         b.qc_user_id,
         b.qc_group,
         b.qc_manage,
         b.qc_manage_name,
         b.qc_user_name,
         b.qc_group_id)
    when matched then
      update
         set a.qc_user_id     = b.qc_user_id,
             a.qc_user_name   = b.qc_user_name,
             a.update_id      = b.update_id,
             a.update_time    = b.update_time,
             a.pause          = b.pause,
             a.qc_manage      = b.qc_manage,
             a.qc_manage_name = b.qc_manage_name,
             a.qc_group_id=b.qc_group_id,
             a.qc_group=b.qc_group]';
  
    EXECUTE IMMEDIATE p_sql;
  end p_recal_qc_factory_detail_config_by_group_cate;

  --根据qc组id重算qc与工厂子类关联头表
  procedure p_recal_qc_factory_head_config_by_group_cate(p_qc_group_id  varchar2 default null,
                                                         p_factory_code varchar2 default null,
                                                         p_company_id   varchar2 default null) is
    p_sql clob;
  begin
    p_sql := q'[merge into scmdata.t_qc_factory_config_head a
    using (select base.company_id,
                  base.factory_code,
                  base.industry_classification,
                  base.pause,
                  base.create_id,
                  base.create_time,
                  base.update_id,
                  base.update_time,
                  (select listagg(distinct y, ';') within group(order by 1)
                     from (SELECT REGEXP_SUBSTR(base.qc_user_id,
                                                '[^;]+',
                                                1,
                                                LEVEL,
                                                'i') y
                             FROM dual
                           CONNECT BY LEVEL <=
                                      LENGTH(base.qc_user_id) -
                                      LENGTH(REGEXP_REPLACE(base.qc_user_id,
                                                            ';',
                                                            '')) + 1)) qc_user_id,
                  base.qc_manage qc_manage,
                  base.qc_group qc_group,
                  base.qc_manage_name qc_manage_name,
                  (select listagg(distinct y, ';') within group(order by 1)
                     from (SELECT REGEXP_SUBSTR(base.qc_user_name,
                                                '[^;]+',
                                                1,
                                                LEVEL,
                                                'i') y
                             FROM dual
                           CONNECT BY LEVEL <=
                                      LENGTH(base.qc_user_name) -
                                      LENGTH(REGEXP_REPLACE(base.qc_user_name,
                                                            ';',
                                                            '')) + 1)) qc_user_name,
                  --c.production_category,
                  base.qc_group_id qc_group_id
             from (select c.company_id company_id,
                          c.factory_code factory_code,
                          c.qc_group_id,
                          listagg(distinct c.industry_classification, ';') industry_classification,
                          min(c.pause) pause,
                          MAX(c.create_id) KEEP(DENSE_RANK FIRST ORDER BY c.create_time) create_id,
                          min(c.create_time) create_time,
                          MAX(c.update_id) keep(DENSE_RANK FIRST ORDER BY c.update_time) update_id,
                          max(c.update_time) update_time,
                          listagg(distinct c.qc_user_id, ';') qc_user_id,
                          max(c.qc_manage) qc_manage,
                          max(c.qc_group) qc_group,
                          max(c.qc_manage_name) qc_manage_name,
                          listagg(distinct c.qc_user_name, ';') qc_user_name
                          --c.production_category,
                          --c.qc_group_id qc_group_id
                     from scmdata.t_qc_factory_config_category c
                     where 1=1]';
    if p_qc_group_id is not null then
      p_sql := p_sql || q'[ and c.qc_group_id=']' || p_qc_group_id || '''';
    end if;
    if p_factory_code is not null then
      p_sql := p_sql || q'[ and c.factory_code=']' || p_factory_code || '''';
    end if;
    if p_company_id is not null then
      p_sql := p_sql || q'[ and c.company_id=']' || p_company_id || '''';
    end if;
  
    p_sql := p_sql || q'[ group by c.company_id,c.qc_group_id,c.factory_code) base) b
    on (a.company_id = b.company_id and a.factory_code = b.factory_code and a.qc_group_id = b.qc_group_id)
    when not matched then
      insert
        (a.qc_factory_config_head_id,
         a.company_id,
         a.factory_code,
         a.pause,
         a.create_id,
         a.create_time,
         a.update_id,
         a.update_time,
         a.qc_user_id,
         a.qc_manage,
         a.qc_group,
         a.industry_classification,
         a.qc_manage_name,
         a.qc_user_name,
         a.qc_group_id)
      values
        (scmdata.f_get_uuid(),
         b.company_id,
         b.factory_code,
         b.pause,
         b.create_id,
         b.create_time,
         b.update_id,
         b.update_time,
         b.qc_user_id,
         b.qc_manage,
         b.qc_group,
         b.industry_classification,
         b.qc_manage_name,
         b.qc_user_name,
         b.qc_group_id)
    when matched then
      update
         set a.qc_user_id              = b.qc_user_id,
             a.qc_user_name            = b.qc_user_name,
             a.update_id               = b.update_id,
             a.update_time             = b.update_time,
             a.industry_classification = b.industry_classification,
             a.pause                   = b.pause]';
  
    EXECUTE IMMEDIATE p_sql;
  
  end p_recal_qc_factory_head_config_by_group_cate;

  --qc组
  function f_get_qc_group_id_by_factory(p_factory_code varchar2,
                                        p_company_id   varchar2)
    return varchar2 is
    p_qc_group_id varchar2(256);
  begin
    select max(qc_group_id) qc_group_id
      into p_qc_group_id
      from (select listagg(distinct aa.qc_group_id, ';') qc_group_id
            
              from scmdata.t_qc_group_config aa
             inner join scmdata.t_qc_group_cate_config bb
                on bb.qc_group_id = aa.qc_group_id
             inner join scmdata.t_qc_group_subcate_config cc
                on bb.qcgroup_cate_config_id = cc.qcgroup_cate_config_id
             INNER JOIN scmdata.t_supplier_group_area_config ee
                on ee.group_type = 'GROUP_QC'
               AND instr(';' || bb.area_config_id || ';',
                         ';' || ee.group_area_config_id || ';') > 0
             inner join scmdata.t_supplier_info si
                on si.company_id = aa.company_id
               and instr(';' || ee.city_id || ';',
                         ';' || si.company_city || ';') > 0
               and instr(';' || ee.province_id || ';',
                         ';' || si.company_province || ';') > 0
              left join scmdata.t_coop_scope cs
                on cs.coop_product_cate = cc.product_cate
               and cs.supplier_info_id = si.supplier_info_id
               and cs.coop_classification = cc.category
               and cs.pause = 0
               and exists (select 1
                      from (SELECT REGEXP_SUBSTR(cc.subcategory,
                                                 '[^;]+',
                                                 1,
                                                 LEVEL,
                                                 'i') y
                              FROM dual
                            CONNECT BY LEVEL <=
                                       LENGTH(cc.subcategory) -
                                       LENGTH(REGEXP_REPLACE(cc.subcategory,
                                                             ';',
                                                             '')) + 1) yy
                     where instr(';' || cs.coop_subcategory || ';',
                                 ';' || yy.y || ';') > 0)
             inner join scmdata.sys_company_user cu
                on cu.company_id = aa.company_id
               and cu.user_id = aa.qc_group_leader
             where aa.pause = 1
               and bb.pause = 1
               and cc.pause = 1
               and ee.pause = 1
               and si.supplier_code = p_factory_code
               and aa.company_id = p_company_id
               and si.supplier_code not in ('C01198', 'C01198')
               and si.status = 1
                  --and cs.pause = 0
               and (si.pause in (0, 2) or
                   (si.pause = 1 and
                   (si.supplier_code, si.company_id) in
                   (select os.factory_code supplier_code, os.company_id
                        from scmdata.t_ordered oe
                       inner join scmdata.t_orders os
                          on oe.order_code = os.order_id
                         and oe.company_id = os.company_id
                       where oe.finish_time_scm is null)))
             group by aa.qc_group_id, si.supplier_code, bb.category
            having max(cs.coop_classification) is not null);
  
    return p_qc_group_id;
  
  end;

  --qc组
  function f_get_qc_group_name(pi_company_province in varchar2,
                               pi_company_city     in varchar2,
                               pi_category         in varchar2,
                               pi_product_cate     in varchar2,
                               pi_subcategory      in varchar2,
                               pi_compid           in varchar2)
    return varchar2 is
    v_group_id VARCHAR2(32);
  begin
    SELECT MAX(aa.qc_group_id)
      INTO v_group_id
      FROM scmdata.t_qc_group_config aa
     INNER JOIN scmdata.t_qc_group_cate_config bb
        ON aa.qc_group_id = bb.qc_group_id
     inner join scmdata.t_qc_group_subcate_config cc
        on cc.qcgroup_cate_config_id = bb.qcgroup_cate_config_id
     INNER JOIN scmdata.t_supplier_group_area_config ee
        on ee.group_type = 'GROUP_QC'
       AND instr(';' || bb.area_config_id || ';',
                 ';' || ee.group_area_config_id || ';') > 0
    /*WHERE trunc(SYSDATE) BETWEEN trunc(aa.effective_time) AND
    trunc(aa.end_time)*/
     where aa.pause = 1
       and bb.pause = 1
       and ee.pause = 1
       and cc.pause = 1
       and aa.company_id = pi_compid
       and cc.category = pi_category
       and cc.product_cate = pi_product_cate
       and instr(';' || ee.city_id || ';', ';' || pi_company_city || ';') > 0
       and instr(';' || ee.province_id || ';',
                 ';' || pi_company_province || ';') > 0
       and exists
     (select 1
              from (SELECT REGEXP_SUBSTR(cc.subcategory,
                                         '[^;]+',
                                         1,
                                         LEVEL,
                                         'i') y
                      FROM dual
                    CONNECT BY LEVEL <=
                               LENGTH(cc.subcategory) -
                               LENGTH(REGEXP_REPLACE(cc.subcategory, ';', '')) + 1) yy
             where instr(';' || pi_subcategory || ';', ';' || yy.y || ';') > 0);
  
    return v_group_id;
  
  end f_get_qc_group_name;

  procedure p_get_qc_group_name(pi_company_province in varchar2,
                                pi_company_city     in varchar2,
                                pi_category         in varchar2,
                                pi_product_cate     in varchar2,
                                pi_subcategory      in varchar2,
                                pi_compid           in varchar2,
                                po_group_id         OUT VARCHAR2,
                                po_group_name       out varchar2,
                                po_group_leader     out varchar2) is
    v_group_id     VARCHAR2(32);
    v_group_name   varchar2(32);
    v_group_leader varchar2(32);
  begin
    SELECT MAX(aa.qc_group_id), max(aa.qc_group), max(aa.qc_group_leader)
      INTO v_group_id, v_group_name, v_group_leader
      FROM scmdata.t_qc_group_config aa
     INNER JOIN scmdata.t_qc_group_cate_config bb
        ON aa.qc_group_id = bb.qc_group_id
     inner join scmdata.t_qc_group_subcate_config cc
        on cc.qcgroup_cate_config_id = bb.qcgroup_cate_config_id
     INNER JOIN scmdata.t_supplier_group_area_config ee
        on ee.group_type = 'GROUP_QC'
       AND instr(';' || bb.area_config_id || ';',
                 ';' || ee.group_area_config_id || ';') > 0
    /*WHERE trunc(SYSDATE) BETWEEN trunc(aa.effective_time) AND
    trunc(aa.end_time)*/
     where aa.pause = 1
       and bb.pause = 1
       and ee.pause = 1
       and cc.pause = 1
       and aa.company_id = pi_compid
       and cc.category = pi_category
       and cc.product_cate = pi_product_cate
       and instr(';' || ee.city_id || ';', ';' || pi_company_city || ';') > 0
       and instr(';' || ee.province_id || ';',
                 ';' || pi_company_province || ';') > 0
       and exists
     (select 1
              from (SELECT REGEXP_SUBSTR(cc.subcategory,
                                         '[^;]+',
                                         1,
                                         LEVEL,
                                         'i') y
                      FROM dual
                    CONNECT BY LEVEL <=
                               LENGTH(cc.subcategory) -
                               LENGTH(REGEXP_REPLACE(cc.subcategory, ';', '')) + 1) yy
             where instr(';' || pi_subcategory || ';', ';' || yy.y || ';') > 0);
  
    po_group_id     := v_group_id;
    po_group_name   := v_group_name;
    po_group_leader := v_group_leader;
  end p_get_qc_group_name;

  --待产前会清单指定qc
  procedure p_appoint_qc_meeting(pi_goo_id        in varchar2,
                                 pi_supplier_code in varchar2,
                                 pi_factory_code  in varchar2,
                                 pi_company_id    in varchar2,
                                 pi_operate_id    in varchar2,
                                 pi_target_id     in varchar2) is
    p_qc_factory_appoint_meeting_id varchar2(32);
    p_target_name                   varchar2(256);
    p_former_id                     varchar2(256);
    p_former_name                   varchar2(256);
    p_qc_manage_name                varchar2(256);
    p_qc_manage_id                  varchar2(256);
  begin
    select max(a.qc_factory_appoint_check_id),
           max(a.qc_user_id),
           max(a.qc_user_name)
      into p_qc_factory_appoint_meeting_id, p_former_id, p_former_name
      from scmdata.t_qc_factory_appoint_check a
     where a.goo_id = pi_goo_id
       and a.company_id = pi_company_id
       and a.factory_code = pi_factory_code
       and a.supplier_code = pi_supplier_code
       and a.qc_check_node = 'QC_PRE_MEETING';
    --查询target_name
    select listagg(distinct a.company_user_name, ';')
      into p_target_name
      from scmdata.sys_company_user a
     where a.company_id = pi_company_id
       and instr(';' || pi_target_id || ';', ';' || a.user_id || ';') > 0;
    --查询qc主管
    select listagg(distinct base.qc_manage_name, ';'),
           listagg(distinct base.qc_manage_id, ';')
      INTO p_qc_manage_name, p_qc_manage_id
      from (select aa.user_id,
                   --cc.company_user_name,
                   --bb.dept_name,
                   aa.company_id,
                   first_value(cc.company_user_name) over(partition by bb.company_dept_id order by dd.company_job_id asc) qc_manage_name,
                   --dd.company_job_id,
                   first_value(cc.user_id) over(partition by bb.company_dept_id order by dd.company_job_id asc) qc_manage_id,
                   max(company_job_id) over(partition by bb.company_dept_id order by dd.company_job_id asc) company_job_id
              from scmdata.sys_company_dept bb
             inner join scmdata.sys_company_user_dept aa
                on bb.company_dept_id = aa.company_dept_id
             inner join scmdata.sys_company_user cc
                on cc.company_id = aa.company_id
               and cc.user_id = aa.user_id
              left join scmdata.sys_company_job dd
                on dd.job_id = cc.job_id
               and dd.job_name = 'QC主管'
             where bb.dept_name like '%QC%') base
     where base.company_id = pi_company_id
       and base.company_job_id is not null
       and instr(';' || pi_target_id || ';', ';' || base.user_id || ';') > 0;
  
    if p_qc_factory_appoint_meeting_id is null then
      --查询former_name
      select max(qfcd.qc_user_id), max(qfcd.qc_user_name)
        into p_former_id, p_former_name
        from scmdata.t_commodity_info ci
       inner join scmdata.t_qc_factory_config_detail qfcd
          on qfcd.company_id = pi_company_id
         and qfcd.factory_code = pi_factory_code
         and qfcd.industry_classification = ci.category
         and qfcd.production_category = ci.product_cate
         and qfcd.product_subclass = ci.samll_category
       where ci.goo_id = pi_goo_id
         and ci.company_id = pi_company_id;
    
      insert into scmdata.t_qc_factory_appoint_check
        (qc_factory_appoint_check_id,
         qc_user_id,
         qc_user_name,
         former_qc_user_id,
         former_qc_user_name,
         create_id,
         create_time,
         update_id,
         update_time,
         goo_id,
         company_id,
         factory_code,
         supplier_code,
         qc_check_node,
         qc_manage_name,
         qc_manage_id)
      values
        (scmdata.f_get_uuid(),
         pi_target_id,
         p_target_name,
         p_former_id,
         p_former_name,
         pi_operate_id,
         sysdate,
         pi_operate_id,
         sysdate,
         pi_goo_id,
         pi_company_id,
         pi_factory_code,
         pi_supplier_code,
         'QC_PRE_MEETING',
         p_qc_manage_name,
         p_qc_manage_id);
    
    else
      update scmdata.t_qc_factory_appoint_check a
         set a.update_time = sysdate,
             a.update_id   = pi_operate_id,
             --a.former_qc_user_id   = a.qc_user_id,
             --a.former_qc_user_name = a.qc_user_name,
             a.qc_user_id     = pi_target_id,
             a.qc_user_name   = p_target_name,
             a.qc_manage_name = p_qc_manage_name,
             a.qc_manage_id   = p_qc_manage_id
       where a.qc_factory_appoint_check_id =
             p_qc_factory_appoint_meeting_id;
    end if;
  
    insert into scmdata.t_qc_factory_appoint_check_log
      (qc_factory_appoint_check_log_id,
       qc_user_id,
       qc_user_name,
       former_qc_user_id,
       former_qc_user_name,
       operate_id,
       operate_time,
       company_id,
       factory_code,
       goo_id,
       supplier_code,
       qc_check_node,
       qc_manage_name,
       qc_manage_id)
    values
      (scmdata.f_get_uuid(),
       pi_target_id,
       p_target_name,
       p_former_id,
       p_former_name,
       pi_operate_id,
       sysdate,
       pi_company_id,
       pi_factory_code,
       pi_goo_id,
       pi_supplier_code,
       'QC_PRE_MEETING',
       p_qc_manage_name,
       p_qc_manage_id);
  end p_appoint_qc_meeting;

  --待查货清单指定qc
  procedure p_appoint_qc_check(pi_order_id      in varchar2,
                               pi_qc_check_node in varchar2,
                               pi_company_id    in varchar2,
                               pi_operate_id    in varchar2,
                               pi_target_id     in varchar2) is
    p_qc_factory_appoint_check_id varchar2(32);
    p_target_name                 varchar2(256);
    p_former_id                   varchar2(256);
    p_former_name                 varchar2(256);
    p_qc_manage_name              varchar2(256);
    p_qc_manage_id                varchar2(256);
  begin
    select max(a.qc_factory_appoint_check_id),
           max(a.qc_user_id),
           max(a.qc_user_name)
      into p_qc_factory_appoint_check_id, p_former_id, p_former_name
      from scmdata.t_qc_factory_appoint_check a
     where a.order_id = pi_order_id
       and a.company_id = pi_company_id
       and a.qc_check_node = pi_qc_check_node;
    --查询target_name
    select listagg(distinct a.company_user_name, ';')
      into p_target_name
      from scmdata.sys_company_user a
     where a.company_id = pi_company_id
       and instr(';' || pi_target_id || ';', ';' || a.user_id || ';') > 0;
    --查询qc主管
    select listagg(distinct base.qc_manage_name, ';'),
           listagg(distinct base.qc_manage_id, ';')
      INTO p_qc_manage_name, p_qc_manage_id
      from (select aa.user_id,
                   --cc.company_user_name,
                   --bb.dept_name,
                   aa.company_id,
                   first_value(cc.company_user_name) over(partition by bb.company_dept_id order by dd.company_job_id asc) qc_manage_name,
                   --dd.company_job_id,
                   first_value(cc.user_id) over(partition by bb.company_dept_id order by dd.company_job_id asc) qc_manage_id,
                   max(company_job_id) over(partition by bb.company_dept_id order by dd.company_job_id asc) company_job_id
              from scmdata.sys_company_dept bb
             inner join scmdata.sys_company_user_dept aa
                on bb.company_dept_id = aa.company_dept_id
             inner join scmdata.sys_company_user cc
                on cc.company_id = aa.company_id
               and cc.user_id = aa.user_id
              left join scmdata.sys_company_job dd
                on dd.job_id = cc.job_id
               and dd.job_name = 'QC主管'
             where bb.dept_name like '%QC%') base
     where base.company_id = pi_company_id
       and base.company_job_id is not null
       and instr(';' || pi_target_id || ';', ';' || base.user_id || ';') > 0;
    if p_qc_factory_appoint_check_id is null then
      --查询former_name
      select max(qfcd.qc_user_id), max(qfcd.qc_user_name)
        into p_former_id, p_former_name
        from scmdata.t_orders os
       inner join scmdata.t_commodity_info ci
          on ci.goo_id = os.goo_id
         and ci.company_id = os.company_id
       inner join scmdata.t_qc_factory_config_detail qfcd
          on qfcd.company_id = os.company_id
         and qfcd.factory_code = os.factory_code
         and qfcd.industry_classification = ci.category
         and qfcd.production_category = ci.product_cate
         and qfcd.product_subclass = ci.samll_category
       where os.order_id = pi_order_id
         and os.company_id = pi_company_id;
    
      insert into scmdata.t_qc_factory_appoint_check
        (qc_factory_appoint_check_id,
         qc_user_id,
         qc_user_name,
         former_qc_user_id,
         former_qc_user_name,
         create_id,
         create_time,
         update_id,
         update_time,
         company_id,
         order_id,
         qc_check_node,
         qc_manage_name,
         qc_manage_id)
      values
        (scmdata.f_get_uuid(),
         pi_target_id,
         p_target_name,
         p_former_id,
         p_former_name,
         pi_operate_id,
         sysdate,
         pi_operate_id,
         sysdate,
         pi_company_id,
         pi_order_id,
         pi_qc_check_node,
         p_qc_manage_name,
         p_qc_manage_id);
    
    else
      update scmdata.t_qc_factory_appoint_check a
         set a.update_time = sysdate,
             a.update_id   = pi_operate_id,
             --a.former_qc_user_id   = a.qc_user_id,
             --a.former_qc_user_name = a.qc_user_name,
             a.qc_user_id     = pi_target_id,
             a.qc_user_name   = p_target_name,
             a.qc_manage_name = p_qc_manage_name,
             a.qc_manage_id   = p_qc_manage_id
       where a.qc_factory_appoint_check_id = p_qc_factory_appoint_check_id;
    end if;
  
    insert into scmdata.t_qc_factory_appoint_check_log
      (qc_factory_appoint_check_log_id,
       qc_user_id,
       qc_user_name,
       former_qc_user_id,
       former_qc_user_name,
       operate_id,
       operate_time,
       company_id,
       order_id,
       qc_check_node,
       qc_manage_name,
       qc_manage_id)
    values
      (scmdata.f_get_uuid(),
       pi_target_id,
       p_target_name,
       p_former_id,
       p_former_name,
       pi_operate_id,
       sysdate,
       pi_company_id,
       pi_order_id,
       pi_qc_check_node,
       p_qc_manage_name,
       p_qc_manage_id);
  end p_appoint_qc_check;

  --禁用/启用工厂对应配置
  procedure p_status_qc_factory_config_by_factory(p_factory_code varchar2,
                                                  p_company_id   varchar2,
                                                  p_status       number) is
  begin
    update scmdata.t_qc_factory_config_category a
       set a.pause = p_status
     where a.factory_code = p_factory_code
       and a.company_id = p_company_id;
    update scmdata.t_qc_factory_config_head a
       set a.pause = p_status
     where a.factory_code = p_factory_code
       and a.company_id = p_company_id;
    update scmdata.t_qc_factory_config_detail a
       set a.pause = p_status
     where a.factory_code = p_factory_code
       and a.company_id = p_company_id;
  end p_status_qc_factory_config_by_factory;

  --删除qc组对应配置
  procedure p_delete_qc_factory_config_by_qc_group(p_qc_group_id  varchar2,
                                                   p_category     varchar2 default null,
                                                   p_product_cate varchar2 default null) is
  begin
    if p_category is null then
      delete scmdata.t_qc_factory_config_category a
       where a.qc_group_id = p_qc_group_id;
      delete scmdata.t_qc_factory_config_head a
       where a.qc_group_id = p_qc_group_id;
      delete scmdata.t_qc_factory_config_detail a
       where a.qc_group_id = p_qc_group_id;
    elsif p_category is not null and p_product_cate is null then
      delete scmdata.t_qc_factory_config_category a
       where a.qc_group_id = p_qc_group_id
         and a.industry_classification = p_category;
      delete scmdata.t_qc_factory_config_detail a
       where a.qc_group_id = p_qc_group_id
         and a.industry_classification = p_category;
    
      --清除表头
      delete scmdata.t_qc_factory_config_head a
       where a.qc_group_id = p_qc_group_id
         and a.industry_classification = p_category;
    
      update scmdata.t_qc_factory_config_head a
         set a.industry_classification =
             (select listagg(distinct w.industry_classification, ';')
                from scmdata.t_qc_factory_config_category w
               where w.qc_group_id = a.qc_group_id
                 and w.factory_code = a.factory_code)
       where a.qc_group_id = p_qc_group_id;
    elsif p_product_cate is not null then
      delete scmdata.t_qc_factory_config_detail a
       where a.qc_group_id = p_qc_group_id
         and a.industry_classification = p_category
         and a.production_category = p_product_cate;
    
      delete scmdata.t_qc_factory_config_category a
       where a.qc_group_id = p_qc_group_id
         and a.industry_classification = p_category
         and a.production_category = p_product_cate;
      delete scmdata.t_qc_factory_config_head a
       where a.qc_group_id = p_qc_group_id
         and not exists
       (select 1
                from scmdata.t_qc_factory_config_category w
               where w.qc_group_id = a.qc_group_id
                 and w.factory_code = a.factory_code);
      update scmdata.t_qc_factory_config_head a
         set a.industry_classification =
             (select listagg(distinct w.industry_classification, ';')
                from scmdata.t_qc_factory_config_category w
               where w.qc_group_id = a.qc_group_id
                 and w.factory_code = a.factory_code)
       where a.qc_group_id = p_qc_group_id;
    
      update scmdata.t_qc_factory_config_category a
         set a.production_category =
             (select listagg(distinct base.y, ';') within group(order by 1)
                from (SELECT REGEXP_SUBSTR(a.production_category,
                                           '[^;]+',
                                           1,
                                           LEVEL,
                                           'i') y
                        FROM dual
                      CONNECT BY LEVEL <=
                                 LENGTH(a.production_category) -
                                 LENGTH(REGEXP_REPLACE(a.production_category,
                                                       ';',
                                                       '')) + 1) base
               where base.y <> p_product_cate)
       where a.qc_group_id = p_qc_group_id
         and a.industry_classification = p_category;
    
    end if;
  end p_delete_qc_factory_config_by_qc_group;

  --删除工厂+分类+生产类别对应配置
  procedure p_delete_qc_factory_config_by_pro(p_factory_code varchar2,
                                              p_company_id   varchar2,
                                              p_category     varchar2 default null,
                                              p_product_cate varchar2 default null) is
  begin
    if p_category is null then
    
      delete scmdata.t_qc_factory_config_category a
       where a.factory_code = p_factory_code
         and a.company_id = p_company_id;
    
      delete scmdata.t_qc_factory_config_head a
       where a.factory_code = p_factory_code
         and a.company_id = p_company_id;
    
      delete scmdata.t_qc_factory_config_detail a
       where a.factory_code = p_factory_code
         and a.company_id = p_company_id;
    
    elsif p_category is not null and p_product_cate is null then
      delete scmdata.t_qc_factory_config_category a
       where a.factory_code = p_factory_code
         and a.industry_classification = p_category
         and a.company_id = p_company_id;
    
      delete scmdata.t_qc_factory_config_detail a
       where a.factory_code = p_factory_code
         and a.industry_classification = p_category
         and a.company_id = p_company_id;
    
      --清除表头
      delete scmdata.t_qc_factory_config_head a
       where a.factory_code = p_factory_code
         and a.industry_classification = p_category
         and a.company_id = p_company_id;
    
      update scmdata.t_qc_factory_config_head a
         set a.industry_classification =
             (select listagg(distinct w.industry_classification, ';')
                from scmdata.t_qc_factory_config_category w
               where w.qc_group_id = a.qc_group_id
                 and w.factory_code = a.factory_code
                 and a.company_id = p_company_id)
       where a.factory_code = p_factory_code
         and a.company_id = p_company_id;
    
    elsif p_product_cate is not null then
      delete scmdata.t_qc_factory_config_detail a
       where a.factory_code = p_factory_code
         and a.industry_classification = p_category
         and a.production_category = p_product_cate
         and a.company_id = p_company_id;
    
      delete scmdata.t_qc_factory_config_category a
       where a.factory_code = p_factory_code
         and a.industry_classification = p_category
         and a.factory_production_category = p_product_cate
         and a.company_id = p_company_id;
      delete scmdata.t_qc_factory_config_head a
       where a.factory_code = p_factory_code
         and not exists (select 1
                from scmdata.t_qc_factory_config_category w
               where w.qc_group_id = a.qc_group_id
                 and w.factory_code = a.factory_code)
         and a.company_id = p_company_id;
      update scmdata.t_qc_factory_config_head a
         set a.industry_classification =
             (select listagg(distinct w.industry_classification, ';')
                from scmdata.t_qc_factory_config_category w
               where w.qc_group_id = a.qc_group_id
                 and w.factory_code = a.factory_code
                 and a.company_id = p_company_id)
       where a.factory_code = p_factory_code
         and a.company_id = p_company_id;
    
      update scmdata.t_qc_factory_config_category a
         set a.factory_production_category =
             (select listagg(distinct base.y, ';') within group(order by 1)
                from (SELECT REGEXP_SUBSTR(a.factory_production_category,
                                           '[^;]+',
                                           1,
                                           LEVEL,
                                           'i') y
                        FROM dual
                      CONNECT BY LEVEL <=
                                 LENGTH(a.factory_production_category) -
                                 LENGTH(REGEXP_REPLACE(a.factory_production_category,
                                                       ';',
                                                       '')) + 1) base
               where base.y <> p_product_cate)
       where a.factory_code = p_factory_code
         and a.industry_classification = p_category
         and a.company_id = p_company_id;
    
    end if;
  end p_delete_qc_factory_config_by_pro;

  --启用工厂+分类+生产类别对应配置
  procedure p_enable_qc_factory_config_by_pro(p_supplier_info varchar2,
                                              p_company_id    varchar2,
                                              p_category      varchar2 default null,
                                              p_product_cate  varchar2 default null,
                                              p_subcategory   varchar2 default null) is
    --p_group_id         varchar2(32);
    p_supplier_code    varchar2(32);
    p_company_province varchar2(32);
    p_company_city     varchar2(32);
  begin
    select max(a.supplier_code),
           max(a.company_province),
           max(a.company_city)
      into p_supplier_code, p_company_province, p_company_city
      from scmdata.t_supplier_info a
     where a.supplier_info_id = p_supplier_info;
  
    /* --刷新 统一的数据 在某些时候这里刷新实在太慢
    --改为在不刷qcgroup才同步*/
    scmdata.pkg_qcfactory_config.p_recal_qc_factory_category_config_by_group(p_category     => p_category,
                                                                             p_product_cate => p_product_cate,
                                                                             p_factory_code => p_supplier_code,
                                                                             p_company_id   => p_company_id);
  
    scmdata.pkg_qcfactory_config.p_recal_qc_factory_head_config_by_group_cate(p_factory_code => p_supplier_code,
                                                                              p_company_id   => p_company_id);
    scmdata.pkg_qcfactory_config.p_recal_qc_factory_detail_config_by_group_cate(p_factory_code => p_supplier_code,
                                                                                p_company_id   => p_company_id,
                                                                                p_category     => p_category);
  
  end p_enable_qc_factory_config_by_pro;

  --启用c组对应配置
  procedure p_enable_qc_factory_config_by_qc_group(p_qc_group_id  varchar2 default null,
                                                   p_category     varchar2 default null,
                                                   p_product_cate varchar2 default null,
                                                   p_company_id   varchar2 default null,
                                                   p_factory_code varchar2 default null) is
  begin
  
    p_recal_qc_factory_category_config_by_group(p_qc_group_id  => p_qc_group_id,
                                                p_category     => p_category,
                                                p_product_cate => p_product_cate,
                                                p_company_id   => p_company_id,
                                                p_factory_code => p_factory_code);
    p_recal_qc_factory_detail_config_by_group_cate(p_qc_group_id  => p_qc_group_id,
                                                   p_category     => p_category,
                                                   p_company_id   => p_company_id,
                                                   p_factory_code => p_factory_code);
    p_recal_qc_factory_head_config_by_group_cate(p_qc_group_id  => p_qc_group_id,
                                                 p_company_id   => p_company_id,
                                                 p_factory_code => p_factory_code);
  
  end p_enable_qc_factory_config_by_qc_group;

  --去掉所有配置中的某个用户
  procedure p_delete_qc_user(p_user_id varchar2, p_company_id varchar2) is
  begin
    update scmdata.t_qc_factory_config_category a
       set a.qc_user_id = null, a.qc_user_name = null
     where a.company_id = p_company_id
       and a.qc_user_id = p_user_id;
    --如果该方法影响到行，需要通知存在未配置的工厂
    if sql%rowcount > 0 then
      scmdata.pkg_qcfactory_msg.send_unconfig_factory_msg(p_company_id => p_company_id);
    end if;
  
    update scmdata.t_qc_factory_config_head a
       set a.qc_user_id  =
           (select listagg(distinct y, ';') within group(order by 1)
              from (SELECT REGEXP_SUBSTR(a.qc_user_id, '[^;]+', 1, LEVEL, 'i') y
                      FROM dual
                    CONNECT BY LEVEL <=
                               LENGTH(a.qc_user_id) -
                               LENGTH(REGEXP_REPLACE(a.qc_user_id, ';', '')) + 1)
             where y <> p_user_id),
           a.qc_user_name =
           (select listagg(distinct cu.company_user_name, ';') within group(order by 1)
              from (SELECT REGEXP_SUBSTR(a.qc_user_id, '[^;]+', 1, LEVEL, 'i') y
                      FROM dual
                    CONNECT BY LEVEL <=
                               LENGTH(a.qc_user_id) -
                               LENGTH(REGEXP_REPLACE(a.qc_user_id, ';', '')) + 1) base
             inner join scmdata.sys_company_user cu
                on cu.company_id = p_company_id
               and cu.user_id = base.y
             where base.y <> p_user_id)
     where a.company_id = p_company_id
       and instr(';' || a.qc_user_id || ';', ';' || p_user_id || ';') > 0;
    update scmdata.t_qc_factory_config_category a
       set a.qc_user_id  =
           (select listagg(distinct y, ';') within group(order by 1)
              from (SELECT REGEXP_SUBSTR(a.qc_user_id, '[^;]+', 1, LEVEL, 'i') y
                      FROM dual
                    CONNECT BY LEVEL <=
                               LENGTH(a.qc_user_id) -
                               LENGTH(REGEXP_REPLACE(a.qc_user_id, ';', '')) + 1)
             where y <> p_user_id),
           a.qc_user_name =
           (select listagg(distinct cu.company_user_name, ';') within group(order by 1)
              from (SELECT REGEXP_SUBSTR(a.qc_user_id, '[^;]+', 1, LEVEL, 'i') y
                      FROM dual
                    CONNECT BY LEVEL <=
                               LENGTH(a.qc_user_id) -
                               LENGTH(REGEXP_REPLACE(a.qc_user_id, ';', '')) + 1) base
             inner join scmdata.sys_company_user cu
                on cu.company_id = p_company_id
               and cu.user_id = base.y
             where base.y <> p_user_id)
     where a.company_id = p_company_id
       and instr(';' || a.qc_user_id || ';', ';' || p_user_id || ';') > 0;
  
    update scmdata.t_qc_factory_config_detail a
       set a.qc_user_id  =
           (select listagg(distinct y, ';') within group(order by 1)
              from (SELECT REGEXP_SUBSTR(a.qc_user_id, '[^;]+', 1, LEVEL, 'i') y
                      FROM dual
                    CONNECT BY LEVEL <=
                               LENGTH(a.qc_user_id) -
                               LENGTH(REGEXP_REPLACE(a.qc_user_id, ';', '')) + 1)
             where y <> p_user_id),
           a.qc_user_name =
           (select listagg(distinct cu.company_user_name, ';') within group(order by 1)
              from (SELECT REGEXP_SUBSTR(a.qc_user_id, '[^;]+', 1, LEVEL, 'i') y
                      FROM dual
                    CONNECT BY LEVEL <=
                               LENGTH(a.qc_user_id) -
                               LENGTH(REGEXP_REPLACE(a.qc_user_id, ';', '')) + 1) base
             inner join scmdata.sys_company_user cu
                on cu.company_id = p_company_id
               and cu.user_id = base.y
             where base.y <> p_user_id)
     where a.company_id = p_company_id
       and instr(';' || a.qc_user_id || ';', ';' || p_user_id || ';') > 0;
  end p_delete_qc_user;

  --禁用/启用qc组对应配置
  procedure p_status_qc_factory_config_by_qc_group(p_qc_group_id varchar2,
                                                   p_company_id  varchar2,
                                                   p_status      number) is
  begin
    update scmdata.t_qc_factory_config_category a
       set a.pause = p_status
     where a.qc_group_id = p_qc_group_id
       and a.company_id = p_company_id;
    update scmdata.t_qc_factory_config_head a
       set a.pause = p_status
     where a.qc_group_id = p_qc_group_id
       and a.company_id = p_company_id;
    update scmdata.t_qc_factory_config_detail a
       set a.pause = p_status
     where a.qc_group_id = p_qc_group_id
       and a.company_id = p_company_id;
  end p_status_qc_factory_config_by_qc_group;

  --根据区域组，刷新数据（如果qc组变更就需要更新，如果没有变更就不更新
  procedure p_change_qc_factory_config_by_config_change(p_qc_group_id varchar2,
                                                        p_category    varchar2) is
    p_old_qc_group_id varchar2(32);
    p_new_qc_group_id varchar2(32);
  begin
    for x in (select si.company_id,
                     a.qc_group_id,
                     si.company_city,
                     si.company_province,
                     cs.coop_classification,
                     cs.coop_product_cate,
                     si.supplier_code,
                     si.supplier_info_id,
                     cs.coop_subcategory
                from scmdata.t_qc_factory_config_category a
               inner join scmdata.t_supplier_info si
                  on si.supplier_code = a.factory_code
                 and si.company_id = a.company_id
               inner join scmdata.t_coop_scope cs
                  on cs.supplier_info_id = si.supplier_info_id
                 and cs.pause = 0
                 and cs.coop_classification = p_category
               where a.qc_group_id = p_qc_group_id
                 and a.industry_classification = p_category) loop
      --新
      p_new_qc_group_id := scmdata.pkg_qcfactory_config.f_get_qc_group_name(pi_company_province => x.company_province,
                                                                            pi_company_city     => x.company_city,
                                                                            pi_category         => x.coop_classification,
                                                                            pi_product_cate     => x.coop_product_cate,
                                                                            pi_subcategory      => x.coop_subcategory,
                                                                            pi_compid           => x.company_id);
      p_old_qc_group_id := x.qc_group_id;
      --如果旧的配置不在新配置范围内禁用之前的配置
      if p_new_qc_group_id is null or
         instr(';' || p_new_qc_group_id || ';',
               ';' || p_old_qc_group_id || ';') <= 0 then
        scmdata.pkg_qcfactory_config.p_delete_qc_factory_config_by_pro(p_factory_code => x.supplier_code,
                                                                       p_company_id   => x.company_id,
                                                                       p_category     => x.coop_classification,
                                                                       p_product_cate => x.coop_product_cate);
      
      end if;
      /*
      scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => x.supplier_info_id,
                                                                     p_company_id    => x.company_id,
                                                                     p_category      => x.coop_classification,
                                                                     p_product_cate  => x.coop_product_cate,
                                                                     p_subcategory   => x.coop_subcategory);*/
    
    end loop;
    --不管什么情况都需要刷一遍新的配置
    scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_qc_group(p_qc_group_id => p_qc_group_id,
                                                                        p_category    => p_category);
    --scmdata.pkg_qcfactory_msg.send_unconfig_factory_msg(p_company_id => p_company_id);
  end p_change_qc_factory_config_by_config_change;

  procedure p_change_qc_factory_config_by_coop_scope_change(p_supplier_info    varchar2,
                                                            p_old_category     varchar2,
                                                            p_old_product_cate varchar2,
                                                            p_old_subcategory  varchar2,
                                                            p_new_category     varchar2,
                                                            p_new_product_cate varchar2,
                                                            p_new_subcategory  varchar2) is
  
    p_supplier_code varchar2(32);
    p_company_id    varchar2(32);
  
    p_company_province varchar2(32);
    p_company_city     varchar2(32);
    p_old_qc_group_id  varchar2(32);
    p_now_qc_group_id  varchar2(256);
  begin
    --如果product_cate相同
    if p_old_product_cate = p_new_product_cate then
      return;
      --不做操作
    end if;
    select max(a.supplier_code),
           max(a.company_province),
           max(a.company_city),
           max(a.company_id)
      into p_supplier_code,
           p_company_province,
           p_company_city,
           p_company_id
      from scmdata.t_supplier_info a
     where a.supplier_info_id = p_supplier_info;
    --旧
    p_old_qc_group_id := scmdata.pkg_qcfactory_config.f_get_qc_group_name(pi_company_province => p_company_province,
                                                                          pi_company_city     => p_company_city,
                                                                          pi_category         => p_old_category,
                                                                          pi_product_cate     => p_old_product_cate,
                                                                          pi_compid           => p_company_id,
                                                                          pi_subcategory      => p_old_subcategory);
    p_now_qc_group_id := scmdata.pkg_qcfactory_config.f_get_qc_group_id_by_factory(p_factory_code => p_supplier_code,
                                                                                   p_company_id   => p_company_id);
    if p_now_qc_group_id is null then
      scmdata.pkg_qcfactory_config.p_delete_qc_factory_config_by_pro(p_factory_code => p_supplier_code,
                                                                     p_company_id   => p_company_id);
      return;
    end if;
    if p_old_qc_group_id is not null and
       instr(';' || p_now_qc_group_id || ';',
             ';' || p_old_qc_group_id || ';') <= 0 then
    
      scmdata.pkg_qcfactory_config.p_delete_qc_factory_config_by_pro(p_factory_code => p_supplier_code,
                                                                     p_company_id   => p_company_id,
                                                                     p_category     => p_old_category,
                                                                     p_product_cate => p_old_product_cate);
    end if;
    scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_pro(p_supplier_info => p_supplier_info,
                                                                   p_company_id    => p_company_id,
                                                                   p_category      => p_new_category,
                                                                   p_product_cate  => p_new_product_cate,
                                                                   p_subcategory   => p_new_subcategory);
    scmdata.pkg_qcfactory_msg.send_unconfig_factory_msg(p_company_id => p_company_id);
  
  end p_change_qc_factory_config_by_coop_scope_change;

  procedure p_change_qc_factory_config_by_area_change(p_supplier_info        varchar2,
                                                      p_old_company_province varchar2,
                                                      p_old_company_city     varchar2,
                                                      p_new_company_province varchar2,
                                                      p_new_company_city     varchar2) is
    p_supplier_code varchar2(32);
    p_company_id    varchar2(32);
  
    p_company_province varchar2(32) := p_new_company_province;
    p_company_city     varchar2(32) := p_new_company_city;
    p_old_qc_group_id  varchar2(32);
    p_now_qc_group_id  varchar2(256);
  begin
    select max(a.supplier_code),
           --max(a.company_province),
           -- max(a.company_city),
           max(a.company_id)
      into p_supplier_code,
           -- p_company_province,
           -- p_company_city,
           p_company_id
      from scmdata.t_supplier_info a
     where a.supplier_info_id = p_supplier_info;
  
    p_now_qc_group_id := scmdata.pkg_qcfactory_config.f_get_qc_group_id_by_factory(p_factory_code => p_supplier_code,
                                                                                   p_company_id   => p_company_id);
    if p_now_qc_group_id is null then
      scmdata.pkg_qcfactory_config.p_delete_qc_factory_config_by_pro(p_factory_code => p_supplier_code,
                                                                     p_company_id   => p_company_id);
      return;
    end if;
    for x in (select *
                from scmdata.t_coop_scope a
               where a.pause = 0
                 and a.supplier_info_id = p_supplier_info) loop
      p_old_qc_group_id := scmdata.pkg_qcfactory_config.f_get_qc_group_name(pi_company_province => p_old_company_province,
                                                                            pi_company_city     => p_old_company_city,
                                                                            pi_category         => x.coop_classification,
                                                                            pi_product_cate     => x.coop_product_cate,
                                                                            pi_compid           => x.company_id,
                                                                            pi_subcategory      => x.coop_subcategory);
      if p_old_qc_group_id is not null and
         instr(';' || p_now_qc_group_id || ';',
               ';' || p_old_qc_group_id || ';') <= 0 then
        scmdata.pkg_qcfactory_config.p_delete_qc_factory_config_by_pro(p_factory_code => p_supplier_code,
                                                                       p_company_id   => p_company_id,
                                                                       p_category     => x.coop_classification,
                                                                       p_product_cate => x.coop_product_cate);
      
      end if;
    end loop;
  
    scmdata.pkg_qcfactory_config.p_enable_qc_factory_config_by_qc_group(p_company_id   => p_company_id,
                                                                        p_factory_code => p_supplier_code);
    scmdata.pkg_qcfactory_msg.send_unconfig_factory_msg(p_company_id => p_company_id);
  end p_change_qc_factory_config_by_area_change;
end PKG_QCFACTORY_CONFIG;
/

