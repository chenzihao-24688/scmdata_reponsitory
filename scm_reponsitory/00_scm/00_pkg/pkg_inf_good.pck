create or replace package scmdata.pkg_inf_good is

  -- Author  : ZWH73
  -- Created : 2021/8/9 11:01:17
  -- Purpose : 商品接口逻辑

  procedure dual_good_picture_if(p_commodity_picture scmdata.t_commodity_picture%rowtype);

  procedure dual_good_info_if(p_commodity_info     scmdata.t_commodity_info%rowtype,
                              p_errcode            varchar2,
                              pi_article_count     int,
                              pi_composition_count int,
                              pi_sup_list          varchar2 default null);

  procedure dual_articles_if(p_commodity_color_size scmdata.t_commodity_color_size%rowtype);

  procedure dual_composition_if(p_commodity_composition scmdata.t_commodity_composition%rowtype);

  procedure dual_articles_if_v2(p_commodity_color_size scmdata.t_commodity_color_size%rowtype);

  procedure roll_articles_inf;

  --删除逻辑
  procedure delete_info_if(p_commodity_info_delete_inf scmdata.t_commodity_info_delete_inf%rowtype);

  procedure dual_good_supplier_if(p_commodity_supplier scmdata.t_commodity_supplier%rowtype);

end pkg_inf_good;
/

create or replace package body scmdata.pkg_inf_good is

  procedure dual_good_picture_if(p_commodity_picture scmdata.t_commodity_picture%rowtype) is
    v_goo_id               varchar2(32);
    p_company_id           varchar2(32);
    p_commodity_picture_id varchar2(32);
  
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'GOOD_MAIN';
    select max(goo_id)
      into v_goo_id
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_commodity_picture.goo_id
       and a.company_id = p_company_id;
    if v_goo_id is not null then
      select max(commodity_picture_id)
        into p_commodity_picture_id
        from scmdata.t_commodity_picture a
       where a.goo_id = v_goo_id
         and a.company_id = p_company_id
         and a.seqno = p_commodity_picture.seqno;
      if p_commodity_picture_id is null then
        insert into scmdata.t_commodity_picture
          (commodity_picture_id,
           goo_id,
           company_id,
           picture,
           seqno,
           create_time,
           create_id,
           update_time,
           update_id,
           memo,
           blog_file_id,
           blog_file_name)
        values
          (f_get_uuid(),
           v_goo_id,
           p_company_id,
           p_commodity_picture.picture,
           p_commodity_picture.seqno,
           nvl(p_commodity_picture.create_time, sysdate),
           'ADMIN',
           nvl(p_commodity_picture.update_time, sysdate),
           'ADMIN',
           null,
           p_commodity_picture.blog_file_id,
           p_commodity_picture.blog_file_name);
      else
        update scmdata.t_commodity_picture a
           set a.picture        = p_commodity_picture.picture,
               a.blog_file_id   = p_commodity_picture.blog_file_id,
               a.blog_file_name = p_commodity_picture.blog_file_name,
               a.update_id      = 'ADMIN',
               a.update_time    = sysdate
         where a.goo_id = v_goo_id
           and a.company_id = p_company_id
           and a.seqno = p_commodity_picture.seqno;
      end if;
    else
      --进接口表
      merge into scmdata.t_commodity_picture_inf a
      using (select p_commodity_picture.goo_id         goo_id,
                    p_company_id                       company_id,
                    p_commodity_picture.picture        picture,
                    p_commodity_picture.seqno          seqno,
                    p_commodity_picture.create_time    create_time,
                    p_commodity_picture.create_id      create_id,
                    p_commodity_picture.update_time    update_time,
                    p_commodity_picture.update_id      update_id,
                    p_commodity_picture.memo           memo,
                    p_commodity_picture.blog_file_id   blog_file_id,
                    p_commodity_picture.blog_file_name blog_file_name
               from dual) b
      on (a.goo_id = b.goo_id and a.company_id = b.company_id and a.seqno = b.seqno)
      when matched then
        update
           set a.picture        = b.picture,
               a.blog_file_id   = b.blog_file_id,
               a.blog_file_name = b.blog_file_name,
               a.receive_time   = sysdate,
               a.operation_flag = 0
      when not matched then
        insert
          (a.commodity_picture_inf_id,
           a.goo_id,
           a.company_id,
           a.picture,
           a.seqno,
           a.create_time,
           a.create_id,
           a.update_time,
           a.update_id,
           a.memo,
           a.blog_file_id,
           a.blog_file_name,
           a.receive_time,
           a.receive_type,
           a.receive_msg,
           a.operation_flag,
           a.operation_type)
        values
          (f_get_uuid(),
           b.goo_id,
           b.company_id,
           b.picture,
           b.seqno,
           sysdate,
           'ADMIN',
           b.update_time,
           b.update_id,
           b.memo,
           b.blog_file_id,
           b.blog_file_name,
           sysdate,
           'R',
           '商品未导入',
           0,
           'IU');
    end if;
  end dual_good_picture_if;

  procedure dual_good_info_if(p_commodity_info     scmdata.t_commodity_info%rowtype,
                              p_errcode            varchar2,
                              pi_article_count     int,
                              pi_composition_count int,
                              pi_sup_list          varchar2 default null) is
    p_pid         varchar2(32);
    p_has_picture number(1);
    -- p_up_flag              varchar2(32);
    -- v_ctl_id               varchar2(32);
    p_ok_code varchar2(32) := case
                                when p_errcode = 'R' then
                                 'Y'
                                when p_errcode = 'SR' then
                                 'SY'
                              end;
    v_commodity_id         varchar2(32);
    p_company_id           varchar2(100);
    p_supp_code            varchar2(100);
    p_article_count        int;
    p_composition_count    int;
    p_has_re               int;
    p_interface_begin_time date;
    p_inprice              varchar2(32);
    p_coop_type            varchar2(32);
    p_old_coop_type        varchar2(32);
    p_old_goo_id           varchar2(32);
    p_old_is_set_fabric    number(1);
    --p_good_supp_code       varchar2(32);
  begin
    select max(company_id), max(a.interface_begin_time)
      into p_company_id, p_interface_begin_time
      from scmdata.t_interface a
     where a.interface_id = 'GOOD_MAIN';
    --判断同企业同货号是否有相同的数据
    select max(a.commodity_info_id), max(a.goo_id)
      into v_commodity_id, p_pid
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_commodity_info.rela_goo_id
       and company_id = p_company_id;
  
    select max(a.supplier_code)
      into p_supp_code
      from scmdata.t_supplier_info a
     where a.company_id = p_company_id
       and a.inside_supplier_code = p_commodity_info.supplier_code;
  
    select nvl(max(1), 0)
      into p_has_re
      from scmdata.t_commodity_info_ctl a
     where a.itf_id = p_commodity_info.rela_goo_id
       and a.return_type = p_errcode;
    select case
             when p_commodity_info.design_mode is null then
              null
             when p_commodity_info.design_mode like '%供应商%' then
              'ODM'
             else
              'OEM'
           end
      into p_coop_type
      from dual;
    --错误1，供应商
    if p_supp_code is null then
   --货号熊猫端已禁用，清除接口表
      if p_commodity_info.pause = 1  then
       delete scmdata.t_commodity_info_ctl t where t.itf_id = p_commodity_info.rela_goo_id;
      end if;
      if p_has_re = 1 or p_commodity_info.pause = 1 then
        return;
      end if;
      insert into scmdata.t_commodity_info_ctl
        (ctl_id,
         itf_id,
         itf_type,
         batch_id,
         batch_num,
         batch_time,
         sender,
         receiver,
         send_time,
         receive_time,
         return_type,
         return_msg,
         create_id,
         create_time,
         update_id,
         update_time,
         remarks,
         company_id)
      values
        (f_get_uuid(),
         p_commodity_info.rela_goo_id,
         'GOOD_MAIN',
         null,
         null,
         sysdate,
         'mdm',
         'scm',
         sysdate,
         sysdate,
         p_errcode,
         '商品货号' || p_commodity_info.rela_goo_id || '导入错误,供应商id' ||
         p_commodity_info.supplier_code || '不存在于scm',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate,
         null,
         p_company_id);
      if p_commodity_info.pause = 0 and
         to_number(to_char(sysdate, 'hh24')) between 9 and 18 then
        insert into scmdata.sys_company_wecom_msg
          (company_wecom_msg_id,
           robot_type,
           company_id,
           status,
           create_time,
           create_id,
           msgtype,
           content,
           mentioned_list,
           mentioned_mobile_list)
        values
          (scmdata.f_get_uuid(),
           'GOOD_SUP_MSG',
           p_company_id,
           2,
           sysdate,
           'ADMIN',
           'markdown',
           '#### 商品接口错误通知
      货号<font color=''warning''>[' ||
           p_commodity_info.rela_goo_id ||
           ']</font>接口导入失败
      供应商编号<font color=''warning''>[' ||
           p_commodity_info.supplier_code || ']</font>不存在于scm。' || '
      商品关联分类：<font color=''warning''>[' ||
           (select group_dict_name
              from scmdata.sys_group_dict g
             where g.group_dict_value = p_commodity_info.category
               and g.group_dict_type = 'PRODUCT_TYPE') || '->' ||
           (select nvl(max(group_dict_name), p_commodity_info.product_cate)
              from scmdata.sys_group_dict g
             where g.group_dict_value = p_commodity_info.product_cate
               and g.group_dict_type = p_commodity_info.category) || '->' ||
           (select nvl(max(company_dict_name),
                       p_commodity_info.samll_category)
              from scmdata.sys_company_dict g
             where g.company_dict_value = p_commodity_info.samll_category
               and g.company_id = p_company_id
               and g.company_dict_type = p_commodity_info.product_cate) ||
           ']</font>
      ' || (select scmdata.F_USER_LIST_FROM_IN_TO_WECOM(sc.default_target_in_id,
                                                                  ';')
                        from scmdata.sys_company_wecom_config sc
                       where sc.robot_type = 'GOOD_SUP_MSG'),
           null,
           null);
      end if;
      return;
    
      p_supp_code := 'C00001';
    end if;
    --错误2，分类没有
    if p_commodity_info.category is null then
      if p_has_re = 1 then
        return;
      end if;
      insert into scmdata.t_commodity_info_ctl
        (ctl_id,
         itf_id,
         itf_type,
         batch_id,
         batch_num,
         batch_time,
         sender,
         receiver,
         send_time,
         receive_time,
         return_type,
         return_msg,
         create_id,
         create_time,
         update_id,
         update_time,
         remarks,
         company_id)
      values
        (f_get_uuid(),
         p_commodity_info.rela_goo_id,
         'GOOD_MAIN',
         null,
         null,
         sysdate,
         'mdm',
         'scm',
         sysdate,
         sysdate,
         p_errcode,
         '商品货号' || p_commodity_info.rela_goo_id || '导入错误，分类号' ||
         p_commodity_info.product_cate || '映射字段' ||
         p_commodity_info.samll_category || '没有找到对应的分类',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate,
         null,
         p_company_id);
      if to_number(to_char(sysdate, 'hh24')) between 9 and 18 then
        if p_errcode = 'R' then
          insert into scmdata.sys_company_wecom_msg
            (company_wecom_msg_id,
             robot_type,
             company_id,
             status,
             create_time,
             create_id,
             msgtype,
             content,
             mentioned_list,
             mentioned_mobile_list)
          values
            (scmdata.f_get_uuid(),
             'GOOD_MAPPING_MSG',
             p_company_id,
             2,
             sysdate,
             'ADMIN',
             'markdown',
             '#### 商品接口错误通知
货号<font color=''warning''>[' || p_commodity_info.rela_goo_id ||
              ']</font>接口导入失败
 品类编号<font color=''warning''>[' ||
              p_commodity_info.product_cate ||
              ']</font>映射字段<font color=''warning''>[ ' ||
              p_commodity_info.samll_category || ']</font>没有找到对应的分类。
          ' ||
              (select scmdata.F_USER_LIST_FROM_IN_TO_WECOM(sc.default_target_in_id,
                                                           ';')
                 from scmdata.sys_company_wecom_config sc
                where sc.robot_type = 'GOOD_MAPPING_MSG'),
             'LSL167',
             null);
        elsif p_errcode = 'SR' then
          insert into scmdata.sys_company_wecom_msg
            (company_wecom_msg_id,
             robot_type,
             company_id,
             status,
             create_time,
             create_id,
             msgtype,
             content,
             mentioned_list,
             mentioned_mobile_list)
          values
            (scmdata.f_get_uuid(),
             'GOOD_MAPPING_MSG',
             p_company_id,
             2,
             sysdate,
             'ADMIN',
             'markdown',
             '#### 商品接口错误通知
货号<font color=''warning''>[' || p_commodity_info.rela_goo_id ||
              ']</font>接口导入失败
品类编号<font color=''warning''>[' || p_commodity_info.product_cate ||
              ']</font>子品类编号<font color=''warning''>[ ' ||
              p_commodity_info.samll_category || ']</font>没有找到对应的分类。
' || (select scmdata.F_USER_LIST_FROM_IN_TO_WECOM(sc.default_target_in_id,
                                                               ';')
                     from scmdata.sys_company_wecom_config sc
                    where sc.robot_type = 'GOOD_MAPPING_MSG'),
             null,
             null);
        end if;
      end if;
      return;
    end if;
  
    --insert数据或update数据
    if v_commodity_id is null then
      v_commodity_id := f_get_uuid();
      p_pid          := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => 't_commodity_info',
                                                           pi_column_name => 'goo_id',
                                                           pi_company_id  => p_company_id,
                                                           pi_pre         => substr(to_char(p_commodity_info.create_time,
                                                                                            'yyyy'),
                                                                                    3,
                                                                                    2),
                                                           pi_serail_num  => 6);
      insert into scmdata.t_commodity_info
        (commodity_info_id,
         company_id,
         origin,
         style_pic,
         supplier_code,
         goo_id,
         rela_goo_id,
         style_name,
         style_number,
         category,
         samll_category,
         year,
         season,
         base_size,
         inprice,
         price,
         color_list,
         size_list,
         create_id,
         create_time,
         update_id,
         update_time,
         remarks,
         sup_style_number,
         product_cate,
         goo_name,
         pause,
         executive_std,
         IS_SET_FABRIC,
         SAFE_TYPE,
         TOUCHCLASS,
         tax_number,
         tax_rate,
         small_taxrate,
         design_mode,
         is_breakable,
         COOPERATION_MODE,
         price_time,
         fabric,
         material,
         shelf_life,
         is_qc_required)
      values
        (v_commodity_id,
         p_company_id,
         'II',
         '1',
         p_supp_code,
         p_pid,
         p_commodity_info.rela_goo_id,
         p_commodity_info.style_name,
         p_commodity_info.style_number,
         p_commodity_info.category,
         p_commodity_info.samll_category,
         to_char(p_commodity_info.create_time, 'yyyy'),
         (select group_dict_value
            from sys_group_dict
           where group_dict_name = p_commodity_info.season
             and group_dict_type = 'GD_SESON'),
         null,
         p_commodity_info.inprice,
         p_commodity_info.price,
         p_commodity_info.color_list,
         (SELECT listagg(k.sizecode, ';') within GROUP(ORDER BY 1)
            FROM (select b.company_dict_value sizecode,
                         b.company_dict_name  sizedesc
                    from sys_company_dict a
                   inner join sys_company_dict b
                      on a.company_dict_value = b.company_dict_type
                     and b.company_id = p_company_id
                   where a.company_dict_type = 'GD_SIZE_LIST'
                     and a.company_id = p_company_id) k
           WHERE k.sizedesc in
                 (SELECT REGEXP_SUBSTR(p_commodity_info.size_list,
                                       '[^;]+',
                                       1,
                                       LEVEL,
                                       'i')
                    FROM DUAL
                  CONNECT BY LEVEL <= LENGTH(p_commodity_info.size_list) -
                             LENGTH(REGEXP_REPLACE(p_commodity_info.size_list,
                                                            ';',
                                                            '')) + 1)),
         p_commodity_info.create_id,
         p_commodity_info.create_time,
         null,
         p_commodity_info.update_time,
         null,
         null,
         p_commodity_info.product_cate,
         p_commodity_info.goo_name,
         0,
         p_commodity_info.executive_std,
         p_commodity_info.IS_SET_FABRIC,
         p_commodity_info.SAFE_TYPE,
         p_commodity_info.TOUCHCLASS,
         p_commodity_info.tax_number,
         p_commodity_info.tax_rate,
         p_commodity_info.small_taxrate,
         p_commodity_info.design_mode,
         p_commodity_info.is_breakable,
         p_coop_type,
         p_commodity_info.price_time,
         p_commodity_info.fabric,
         p_commodity_info.material,
         p_commodity_info.shelf_life,
         p_commodity_info.is_qc_required);
      --如果商品创建时间大于上线时间，生成批版数据和产前任务数据
      if p_commodity_info.create_time > p_interface_begin_time then
        plm.pkg_good_rela_plm.dual_after_create_good(p_rela_goo_id      => p_commodity_info.goo_id,
                                                     p_category         => p_commodity_info.category,
                                                     p_cooperation_mode => p_coop_type);
        pkg_approve_insert.P_GENERATE_NES_APPROVE_INFO(COMP_ID => p_company_id,
                                                       GOO_ID  => p_pid);
      end if;
      --如果有图片存在，同步图片
      select nvl(max(1), 0)
        into p_has_picture
        from scmdata.t_commodity_picture_inf a
       where a.goo_id = p_commodity_info.rela_goo_id
         and a.company_id = p_company_id;
      if p_has_picture = 1 then
        insert into scmdata.t_commodity_picture
          (commodity_picture_id,
           goo_id,
           company_id,
           picture,
           seqno,
           create_time,
           create_id,
           update_time,
           update_id,
           memo,
           blog_file_id,
           blog_file_name)
          select scmdata.f_get_uuid() commodity_picture_id,
                 p_pid goo_id,
                 b.company_id,
                 b.picture,
                 b.seqno,
                 b.create_time,
                 b.create_id,
                 b.update_time,
                 b.update_id,
                 b.memo,
                 b.blog_file_id,
                 b.blog_file_name
            from scmdata.t_commodity_picture_inf b
           where b.company_id = p_company_id
             and b.goo_id = p_commodity_info.rela_goo_id;
        delete from scmdata.t_commodity_picture_inf b
         where b.company_id = p_company_id
           and b.goo_id = p_commodity_info.rela_goo_id;
      end if;
      --2.记录接口表信息到监控表 20220811改造去除监控
      /*insert into scmdata.t_commodity_info_ctl
        (ctl_id,
         itf_id,
         itf_type,
         batch_id,
         batch_num,
         batch_time,
         sender,
         receiver,
         send_time,
         receive_time,
         return_type,
         return_msg,
         create_id,
         create_time,
         update_id,
         update_time,
         remarks,
         company_id)
      values
        (f_get_uuid(),
         v_commodity_id,
         'GOOD_MAIN',
         null,
         null,
         sysdate,
         'mdm',
         'scm',
         sysdate,
         sysdate,
         p_ok_code,
         '成功',
         'ADMIN',
         p_commodity_info.create_time,
         'ADMIN',
         p_commodity_info.update_time,
         null,
         p_company_id);*/
    
    else
    
      --获取原禁用和价格状态，
      select a.inprice, a.cooperation_mode, a.goo_id, a.is_set_fabric
        into p_inprice, p_old_coop_type, p_old_goo_id, p_old_is_set_fabric
        from scmdata.t_commodity_info a
      
       where a.commodity_info_id = v_commodity_id;
    
      update scmdata.t_commodity_info a
         set a.style_pic        = '1',
             a.origin           = 'II',
             a.supplier_code    = p_supp_code,
             a.goo_name         = p_commodity_info.goo_name,
             a.style_name       = p_commodity_info.style_name,
             a.style_number     = p_commodity_info.style_number,
             a.category         = p_commodity_info.category,
             a.product_cate     = p_commodity_info.product_cate,
             a.samll_category   = p_commodity_info.samll_category,
             a.IS_SET_FABRIC    = p_commodity_info.IS_SET_FABRIC,
             a.inprice          = p_commodity_info.inprice,
             a.price            = p_commodity_info.price,
             a.color_list       = p_commodity_info.color_list,
             a.executive_std    = p_commodity_info.executive_std,
             a.price_time       = p_commodity_info.price_time,
             a.size_list       =
             (SELECT listagg(k.sizecode, ';') within GROUP(ORDER BY 1)
                FROM (select b.company_dict_value sizecode,
                             b.company_dict_name  sizedesc
                        from sys_company_dict a
                       inner join sys_company_dict b
                          on a.company_dict_value = b.company_dict_type
                         and b.company_id = p_company_id
                       where a.company_dict_type = 'GD_SIZE_LIST'
                         and a.company_id = p_company_id) k
               WHERE k.sizedesc in
                     (SELECT REGEXP_SUBSTR(p_commodity_info.size_list,
                                           '[^;]+',
                                           1,
                                           LEVEL,
                                           'i')
                        FROM DUAL
                      CONNECT BY LEVEL <=
                                 LENGTH(p_commodity_info.size_list) -
                                 LENGTH(REGEXP_REPLACE(p_commodity_info.size_list,
                                                       ';',
                                                       '')) + 1)),
             a.update_time      = p_commodity_info.update_time,
             a.create_time      = p_commodity_info.create_time,
             a.create_id        = p_commodity_info.create_id,
             a.SAFE_TYPE        = p_commodity_info.SAFE_TYPE,
             a.TOUCHCLASS       = p_commodity_info.TOUCHCLASS,
             a.tax_number       = p_commodity_info.tax_number,
             a.tax_rate         = p_commodity_info.tax_rate,
             a.small_taxrate    = p_commodity_info.small_taxrate,
             a.design_mode      = p_commodity_info.design_mode,
             a.is_breakable     = p_commodity_info.is_breakable,
             a.COOPERATION_MODE = p_coop_type,
             a.season          =
             (select group_dict_value
                from sys_group_dict
               where group_dict_name = p_commodity_info.season
                 and group_dict_type = 'GD_SESON'),
             a.pause            = 0,
             a.fabric           = p_commodity_info.fabric,
             a.material         = p_commodity_info.material,
             a.shelf_life       = p_commodity_info.shelf_life,
             a.is_qc_required   = p_commodity_info.is_qc_required
       where a.commodity_info_id = v_commodity_id;
      --20230210
      --如果更改了指定面料
      if scmdata.pkg_plat_log.f_is_check_fields_eq(p_old_is_set_fabric,
                                                   p_commodity_info.IS_SET_FABRIC) = 0 then
      
        if p_commodity_info.IS_SET_FABRIC = 1 then
          for x in (select *
                      from scmdata.t_commodity_color a
                     where a.commodity_info_id = v_commodity_id
                       and a.skc_status = 1) loop
            plm.pkg_good_rela_plm.status_goods_fabric_set_bom_demand(p_goods_skc_code => x.commodity_color_code,
                                                                     p_status         => 0,
                                                                     p_whether_del    => 0);
          end loop;
        else
          for x in (select *
                      from scmdata.t_commodity_color a
                     where a.commodity_info_id = v_commodity_id
                       and a.skc_status = 1) loop
            plm.pkg_good_rela_plm.status_goods_fabric_set_bom_demand(p_goods_skc_code => x.commodity_color_code,
                                                                     p_status         => 1,
                                                                     p_whether_del    => 1);
          end loop;
        end if;
      end if;
    
      -- 如果定价修改，同步到货色
      if p_inprice <> p_commodity_info.inprice then
        update scmdata.t_commodity_color a
           set a.inprice = p_commodity_info.inprice
         where a.commodity_info_id = v_commodity_id;
      
        plm.pkg_good_rela_plm.dual_after_modify_good_inprice(p_goo_id     => p_old_goo_id,
                                                             p_company_id => p_company_id,
                                                             p_inprice    => p_commodity_info.inprice);
      end if;
      --如果合作模式修改
      if p_old_coop_type is not null and p_coop_type <> p_old_coop_type then
        plm.pkg_good_rela_plm.dual_after_modify_good_cooperation_mode(p_company_id           => p_company_id,
                                                                      p_goo_id               => p_old_goo_id,
                                                                      p_rela_goo_id          => p_commodity_info.rela_goo_id,
                                                                      p_new_cooperation_mode => p_coop_type,
                                                                      p_old_cooperation_mode => p_old_coop_type);
      end if;
    
    end if;
    --如果商品码不对重来
    if pi_article_count is not null then
      select count(*)
        into p_article_count
        from scmdata.t_commodity_color_size k
       where k.commodity_info_id = v_commodity_id;
      if pi_article_count <> p_article_count then
        /*--删掉色码
        delete from scmdata.t_commodity_color_size
         where commodity_info_id = v_commodity_id;*/
        --如果接口为0 ，删掉色码
        if pi_article_count = 0 then
          delete from scmdata.t_commodity_color_size
           where commodity_info_id = v_commodity_id;
        end if;
        merge into scmdata.t_commodity_color_size_ctl a
        using (select p_commodity_info.rela_goo_id itf_id,
                      '色码表接口导入' itf_type,
                      null batch_id,
                      null batch_num,
                      sysdate batch_time,
                      'mdm' sender,
                      'scm' receiver,
                      sysdate send_time,
                      sysdate receive_time,
                      'W' return_type,
                      '货号' || p_commodity_info.rela_goo_id || '色码重传' return_msg,
                      'ADMIN' create_id,
                      sysdate create_time,
                      'ADMIN' update_id,
                      sysdate update_time,
                      null remarks,
                      p_company_id company_id
                 from dual) b
        on (a.itf_id = b.itf_id and a.return_type = 'W')
        when not matched then
          insert
            (a.ctl_id,
             a.itf_id,
             a.itf_type,
             a.batch_id,
             a.batch_num,
             a.batch_time,
             a.sender,
             a.receiver,
             a.send_time,
             a.receive_time,
             a.return_type,
             a.return_msg,
             a.create_id,
             a.create_time,
             a.update_id,
             a.update_time,
             a.remarks,
             a.company_id)
          values
            (scmdata.f_get_uuid(),
             b.itf_id,
             b.itf_type,
             b.batch_id,
             b.batch_num,
             b.batch_time,
             b.sender,
             b.receiver,
             b.send_time,
             b.receive_time,
             b.return_type,
             b.return_msg,
             b.create_id,
             b.create_time,
             b.update_id,
             b.update_time,
             b.remarks,
             b.company_id);
        /* else
        update scmdata.t_commodity_color a
           set a.inprice = p_commodity_info.inprice
         where a.commodity_info_id = v_commodity_id;*/
      end if;
    end if;
  
    --成分是否需要重传
    if pi_composition_count is not null then
      select count(*)
        into p_composition_count
        from scmdata.t_commodity_composition
       where commodity_info_id = v_commodity_id;
      if pi_composition_count <> p_composition_count then
        delete from scmdata.t_commodity_composition
         where commodity_info_id = v_commodity_id;
      
        merge into scmdata.t_commodity_composition_ctl a
        using (select p_company_id company_id,
                      p_commodity_info.rela_goo_id inf_id,
                      p_commodity_info.rela_goo_id goo_id,
                      null composname,
                      null loadrate,
                      null goo_raw,
                      sysdate receive_time,
                      sysdate create_time,
                      null memo,
                      null sort,
                      'R' return_type,
                      '货号' || p_commodity_info.rela_goo_id || '的成分数量错误，要求重传' return_msg,
                      'GOODS_COMPOSITION' itf_type,
                      'mdm' sender,
                      'scm' receiver
                 from dual) b
        on (a.inf_id = b.inf_id and a.company_id = b.company_id and a.return_type = 'R')
        when not matched then
          insert
            (a.ctl_id,
             a.company_id,
             a.inf_id,
             a.goo_id,
             a.composname,
             a.loadrate,
             a.goo_raw,
             a.receive_time,
             a.create_time,
             a.memo,
             a.sort,
             a.return_type,
             a.return_msg,
             a.itf_type,
             a.sender,
             a.receiver)
          values
            (scmdata.f_get_uuid(),
             b.company_id,
             b.inf_id,
             b.goo_id,
             b.composname,
             b.loadrate,
             b.goo_raw,
             b.receive_time,
             b.create_time,
             b.memo,
             b.sort,
             b.return_type,
             b.return_msg,
             b.itf_type,
             b.sender,
             b.receiver);
      end if;
    end if;
  
    --查看商品供应商
    if pi_sup_list is not null then
      /*for x in (select substr(k, 0, 5) sup_id,
                       to_number(substr(k, 7, 1)) pause,
                       to_number(substr(k, 9, 1)) primary
                  from (SELECT REGEXP_SUBSTR(pi_sup_list,
                                             '[^;]+',
                                             1,
                                             LEVEL,
                                             'i') k
                          FROM DUAL
                        CONNECT BY LEVEL <=
                                   LENGTH(pi_sup_list) -
                                   LENGTH(REGEXP_REPLACE(pi_sup_list, ';', '')) + 1)) loop
        --搜索供应商
        select max(a.supplier_code)
          into p_good_supp_code
          from scmdata.t_supplier_info a
         where a.company_id = p_company_id
           and a.inside_supplier_code = x.sup_id;
        --如果已建档
        if p_good_supp_code is not null then
          merge into scmdata.t_commodity_supplier a
          using (select p_good_supp_code supplier_code,
                        x.pause          pause,
                        x.primary        primary,
                        p_company_id     company_id,
                        v_commodity_id   commodity_info_id
                   from dual) b
          on (a.supplier_code = b.supplier_code and a.company_id = b.company_id and a.commodity_info_id = b.commodity_info_id)
          when matched then
            update set a.pause = b.pause, a.primary = b.primary
          when not matched then
            insert
              (a.commodity_supplier_id,
               a.commodity_info_id,
               a.goo_id,
               a.company_id,
               a.sup_code,
               a.primary,
               create_time,
               pause)
            values
              (scmdata.f_get_uuid(),
               b.commodity_info_id,
               p_pid,
               b.company_id,
               b.supplier_code,
               b.primary,
               sysdate,
               b.pause);
        end if;
        
      end loop;*/
      --删除不存在的供应商
      delete from scmdata.t_commodity_supplier cs
       where cs.supplier_code not in
             (select si.supplier_code
                from (select substr(k, 0, 5) sup_id
                        from (SELECT REGEXP_SUBSTR(pi_sup_list,
                                                   '[^;]+',
                                                   1,
                                                   LEVEL,
                                                   'i') k
                                FROM DUAL
                              CONNECT BY LEVEL <=
                                         LENGTH(pi_sup_list) -
                                         LENGTH(REGEXP_REPLACE(pi_sup_list,
                                                               ';',
                                                               '')) + 1)) base
               inner join scmdata.t_supplier_info si
                  on si.inside_supplier_code = base.sup_id
                 and si.company_id = p_company_id)
         and cs.company_id = p_company_id
         and cs.commodity_info_id = v_commodity_id;
    
      delete from scmdata.t_commodity_supplier_color cs
       where cs.supplier_code not in
             (select si.supplier_code
                from (select substr(k, 0, 5) sup_id
                        from (SELECT REGEXP_SUBSTR(pi_sup_list,
                                                   '[^;]+',
                                                   1,
                                                   LEVEL,
                                                   'i') k
                                FROM DUAL
                              CONNECT BY LEVEL <=
                                         LENGTH(pi_sup_list) -
                                         LENGTH(REGEXP_REPLACE(pi_sup_list,
                                                               ';',
                                                               '')) + 1)) base
               inner join scmdata.t_supplier_info si
                  on si.inside_supplier_code = base.sup_id
                 and si.company_id = p_company_id)
         and cs.company_id = p_company_id
         and cs.commodity_info_id = v_commodity_id;
      --将对应的部分置空
      --接口表补充
      merge into scmdata.t_commodity_supplier_ctl a
      using (select p_commodity_info.rela_goo_id itf_id,
                    '商品供应商表接口导入' itf_type,
                    null batch_id,
                    null batch_num,
                    sysdate batch_time,
                    'mdm' sender,
                    'scm' receiver,
                    sysdate send_time,
                    sysdate receive_time,
                    'W' return_type,
                    '货号' || p_commodity_info.rela_goo_id || '商品供应商重传' return_msg,
                    'ADMIN' create_id,
                    sysdate create_time,
                    'ADMIN' update_id,
                    sysdate update_time,
                    null remarks,
                    p_company_id company_id
               from dual) b
      on (a.itf_id = b.itf_id and a.return_type = 'W')
      when not matched then
        insert
          (a.ctl_id,
           a.itf_id,
           a.itf_type,
           a.batch_id,
           a.batch_num,
           a.batch_time,
           a.sender,
           a.receiver,
           a.send_time,
           a.receive_time,
           a.return_type,
           a.return_msg,
           a.create_id,
           a.create_time,
           a.update_id,
           a.update_time,
           a.remarks,
           a.company_id)
        values
          (scmdata.f_get_uuid(),
           b.itf_id,
           b.itf_type,
           b.batch_id,
           b.batch_num,
           b.batch_time,
           b.sender,
           b.receiver,
           b.send_time,
           b.receive_time,
           b.return_type,
           b.return_msg,
           b.create_id,
           b.create_time,
           b.update_id,
           b.update_time,
           b.remarks,
           b.company_id);
    else
      delete from scmdata.t_commodity_supplier a
       where a.commodity_info_id = v_commodity_id;
      delete from scmdata.t_commodity_supplier_color c
       where c.commodity_info_id = v_commodity_id;
    end if;
  
    update scmdata.t_commodity_info_ctl a
       set a.itf_id       = v_commodity_id,
           a.return_type  = p_ok_code,
           a.return_msg   = '商品档案重传成功',
           a.update_time  = sysdate,
           a.receive_time = sysdate
     where a.itf_id = p_commodity_info.rela_goo_id
       and company_id = p_company_id
       and a.return_type in (p_errcode, 'W');
  
  end dual_good_info_if;

  procedure dual_articles_if(p_commodity_color_size scmdata.t_commodity_color_size%rowtype) is
    p_pid                varchar2(32);
    p_up_flag            varchar2(32);
    v_ctl_id             varchar2(32);
    p_old_color_name     varchar2(32);
    v_commodity_id       varchar2(32);
    p_company_id         varchar2(100);
    p_goo_id             varchar2(100);
    p_fabric_evaluate_id varchar2(32);
    p_need_yxh_check     number(1);
  begin
    --获取接口的企业编号
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ARTICLE_SUB';
    --判断同企业同条码是否有相同的数据
    select max(a.commodity_color_size_id), nvl(max(1), 0), max(a.colorname)
      into p_pid, p_up_flag, p_old_color_name
      from scmdata.t_commodity_color_size a
     where a.barcode = p_commodity_color_size.barcode
       and company_id = p_company_id;
    --获取商品档案数据
    select max(commodity_info_id), max(goo_id), max(need_yxh_check)
      into v_commodity_id, p_goo_id, p_need_yxh_check
      from t_commodity_info
     where rela_goo_id = p_commodity_color_size.goo_id
       and company_id = p_company_id;
    --不存在商品档案的情况下存监控表
    if v_commodity_id is null then
      merge into scmdata.t_commodity_info_ctl a
      using (select p_commodity_color_size.goo_id itf_id,
                    p_company_id company_id,
                    'W' return_type
               from dual) b
      on (a.itf_id = b.itf_id and a.company_id = b.company_id and a.return_type = b.return_type)
      when not matched then
        insert
          (a.ctl_id,
           a.itf_id,
           a.itf_type,
           a.batch_id,
           a.batch_num,
           a.batch_time,
           a.sender,
           a.receiver,
           a.send_time,
           a.receive_time,
           a.return_type,
           a.return_msg,
           a.create_id,
           a.create_time,
           a.update_id,
           a.update_time,
           a.remarks,
           a.company_id)
        values
          (scmdata.f_get_uuid(),
           b.itf_id,
           '色码表接口导入',
           null,
           null,
           sysdate,
           'mdm',
           'scm',
           sysdate,
           sysdate,
           b.return_type,
           '货号' || p_commodity_color_size.goo_id || '的' ||
           p_commodity_color_size.colorname ||
           p_commodity_color_size.sizename || '导入失败',
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate,
           null,
           b.company_id);
      return;
    end if;
  
    --insert数据或update数据
    if p_up_flag = 0 then
      p_pid := f_get_uuid();
      insert into t_commodity_color_size
        (commodity_color_size_id,
         commodity_info_id,
         company_id,
         barcode,
         colorname,
         color_code,
         sizename,
         remarks,
         goo_id,
         sizecode,
         create_time,
         update_time)
      values
        (f_get_uuid(),
         v_commodity_id,
         p_company_id,
         p_commodity_color_size.barcode,
         p_commodity_color_size.colorname,
         p_commodity_color_size.color_code,
         p_commodity_color_size.sizename,
         p_commodity_color_size.remarks,
         p_goo_id,
         (select b.company_dict_value
            from sys_company_dict a
           inner join sys_company_dict b
              on a.company_dict_value = b.company_dict_type
             and b.company_dict_name = p_commodity_color_size.sizecode
             and b.company_id = p_company_id
           where a.company_dict_type = 'GD_SIZE_LIST'
             and a.company_id = p_company_id),
         p_commodity_color_size.create_time,
         p_commodity_color_size.update_time);
      --2.记录接口表信息到监控表
    
      v_ctl_id := scmdata.f_get_uuid();
      insert into scmdata.t_commodity_color_size_ctl
        (ctl_id,
         itf_id,
         itf_type,
         batch_id,
         batch_num,
         batch_time,
         sender,
         receiver,
         send_time,
         receive_time,
         return_type,
         return_msg,
         create_id,
         create_time,
         update_id,
         update_time,
         remarks,
         company_id)
      values
        (v_ctl_id,
         p_pid,
         '色码表接口导入',
         null,
         null,
         sysdate,
         '181',
         'scm',
         sysdate,
         sysdate,
         'Y',
         '成功',
         'ADMIN',
         sysdate,
         'ADMIN',
         sysdate,
         null,
         p_company_id);
    
    else
      update t_commodity_color_size a
         set a.barcode    = p_commodity_color_size.barcode,
             a.color_code = p_commodity_color_size.color_code,
             a.colorname  = p_commodity_color_size.colorname,
             a.sizecode  =
             (select b.company_dict_value
                from sys_company_dict a
               inner join sys_company_dict b
                  on a.company_dict_value = b.company_dict_type
                 and b.company_dict_name = p_commodity_color_size.sizecode
                 and b.company_id = p_company_id
               where a.company_dict_type = 'GD_SIZE_LIST'
                 and a.company_id = p_company_id),
             a.remarks    = p_commodity_color_size.remarks,
             a.sizename   = p_commodity_color_size.sizename,
             create_time  = p_commodity_color_size.create_time,
             update_time  = p_commodity_color_size.update_time
       where commodity_color_size_id = p_pid;
      --如果标准色对应颜色变更，删除旧颜色审核，补充新颜色审核
      if p_old_color_name <> p_commodity_color_size.colorname then
        /*select max(a.fabric_evaluate_id)
          into p_fabric_evaluate_id
          from scmdata.t_fabric_evaluate a
         where a.goo_id = p_goo_id
           and a.company_id = p_company_id;
        if p_fabric_evaluate_id is not null then*/
        delete from scmdata.t_fabric_color_evaluate a
         where a.goo_id = p_goo_id
           and a.company_id = p_company_id
           and not exists (select 1
                  from scmdata.t_commodity_color_size c
                 where c.commodity_info_id = v_commodity_id
                   and c.colorname = a.colorname);
        merge into scmdata.t_fabric_color_evaluate a
        using (select distinct co.colorname, co.goo_id, co.company_id
                 from scmdata.t_commodity_color_size co
                where co.commodity_info_id = v_commodity_id) b
        on (a.goo_id = b.goo_id and a.company_id = b.company_id and a.colorname = b.colorname and a.evaluate_type = 'ML')
        when not matched then
          insert
            (a.fabric_color_evaluate_id,
             a.evaluate_id,
             a.evaluate_result,
             a.evaluate_time,
             a.create_id,
             a.create_time,
             a.memo,
             a.goo_id,
             a.colorname,
             a.update_id,
             a.update_time,
             a.company_id,
             a.risk_level,
             a.evaluate_times)
          values
            (f_get_uuid(),
             null,
             null,
             null,
             'ADMIN',
             sysdate,
             null,
             b.goo_id,
             b.colorname,
             'ADMIN',
             sysdate,
             b.company_id,
             null,
             0);
        --如果货号需要印绣花审核，补充印绣花的审核
        if p_need_yxh_check = 1 then
          merge into scmdata.t_fabric_color_evaluate a
          using (select distinct co.colorname, co.goo_id, co.company_id
                   from scmdata.t_commodity_color_size co
                  where co.commodity_info_id = v_commodity_id) b
          on (a.goo_id = b.goo_id and a.company_id = b.company_id and a.colorname = b.colorname and a.evaluate_type = 'YXH')
          when not matched then
            insert
              (a.fabric_color_evaluate_id,
               a.evaluate_id,
               a.evaluate_result,
               a.evaluate_time,
               a.create_id,
               a.create_time,
               a.memo,
               a.goo_id,
               a.colorname,
               a.update_id,
               a.update_time,
               a.company_id,
               a.risk_level,
               a.evaluate_times,
               a.evaluate_type)
            values
              (f_get_uuid(),
               p_fabric_evaluate_id,
               null,
               null,
               'ADMIN',
               sysdate,
               null,
               b.goo_id,
               b.colorname,
               'ADMIN',
               sysdate,
               b.company_id,
               null,
               0,
               'YXH');
        end if;
      
        --end if;
      
      end if;
    end if;
  
    --2.记录接口表信息到监控表
    update scmdata.t_commodity_color_size_ctl a
       set a.itf_id       = p_pid,
           a.return_type  = 'Y',
           a.return_msg   = '色码表重传成功',
           a.update_time  = sysdate,
           a.receive_time = sysdate
     where a.itf_id = p_commodity_color_size.goo_id
       and a.return_type in ('R', 'W');
  END dual_articles_if;

  procedure dual_composition_if(p_commodity_composition scmdata.t_commodity_composition%rowtype) is
    p_pid          varchar2(32);
    p_up_flag      varchar2(32);
    v_commodity_id varchar2(32);
    p_company_id   varchar2(100);
    p_goo_id       varchar2(100);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'GOODS_COMPOSITION';
  
    select max(commodity_info_id), max(goo_id)
      into v_commodity_id, p_goo_id
      from t_commodity_info
     where rela_goo_id = p_commodity_composition.commodity_info_id
       and company_id = p_company_id;
  
    if v_commodity_id is null then
      return;
    end if;
  
    --检测重复
    select nvl(max(1), 0), max(commodity_composition_id)
      into p_up_flag, p_pid
      from scmdata.t_commodity_composition
     where commodity_info_id = v_commodity_id
       and sort = p_commodity_composition.sort;
  
    --insert数据或update数据
    if p_up_flag = 0 then
      p_pid := f_get_uuid();
      insert into scmdata.t_commodity_composition
        (commodity_composition_id,
         commodity_info_id,
         company_id,
         composname,
         loadrate,
         goo_raw,
         memo,
         sort,
         create_time,
         create_id,
         update_time,
         update_id,
         pause)
      values
        (p_pid,
         v_commodity_id,
         p_company_id,
         p_commodity_composition.composname,
         p_commodity_composition.loadrate,
         p_commodity_composition.goo_raw,
         p_commodity_composition.memo,
         p_commodity_composition.sort,
         p_commodity_composition.create_time,
         'ADMIN',
         null,
         null,
         0);
    else
      update scmdata.t_commodity_composition a
         set a.composname = p_commodity_composition.composname,
             a.loadrate   = p_commodity_composition.loadrate,
             a.goo_raw    = p_commodity_composition.goo_raw,
             a.memo       = p_commodity_composition.memo
       where a.commodity_info_id = v_commodity_id
         and a.sort = p_commodity_composition.sort;
    end if;
  
    --2.记录接口表信息到监控表
  
    update scmdata.t_commodity_composition_ctl a
       set a.inf_id = p_pid, a.return_type = 'N', a.return_msg = '重导成功'
     where goo_id = p_commodity_composition.commodity_info_id
       and return_type in ('R', 'W');
  
  END dual_composition_if;

  procedure dual_articles_if_v2(p_commodity_color_size scmdata.t_commodity_color_size%rowtype) is
  
    v_commodity_id   varchar2(32);
    p_company_id     varchar2(100);
    p_goo_id         varchar2(100);
    p_need_yxh_check number(1);
    p_pid            varchar2(32);
  begin
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ARTICLE_SUB';
    --判断同企业同条码是否有相同的数据
    select max(commodity_info_id), max(goo_id), max(need_yxh_check)
      into v_commodity_id, p_goo_id, p_need_yxh_check
      from t_commodity_info
     where rela_goo_id = p_commodity_color_size.goo_id
       and company_id = p_company_id;
  
    --不存在商品档案时处理
    if v_commodity_id is null then
      merge into scmdata.t_commodity_info_ctl a
      using (select p_commodity_color_size.goo_id itf_id,
                    p_company_id company_id,
                    'W' return_type
               from dual) b
      on (a.itf_id = b.itf_id and a.company_id = b.company_id and a.return_type = b.return_type)
      when not matched then
        insert
          (a.ctl_id,
           a.itf_id,
           a.itf_type,
           a.batch_id,
           a.batch_num,
           a.batch_time,
           a.sender,
           a.receiver,
           a.send_time,
           a.receive_time,
           a.return_type,
           a.return_msg,
           a.create_id,
           a.create_time,
           a.update_id,
           a.update_time,
           a.remarks,
           a.company_id)
        values
          (scmdata.f_get_uuid(),
           b.itf_id,
           '色码表接口导入',
           null,
           null,
           sysdate,
           'mdm',
           'scm',
           sysdate,
           sysdate,
           b.return_type,
           '货号' || p_commodity_color_size.goo_id || '的' ||
           p_commodity_color_size.colorname ||
           p_commodity_color_size.sizename || '导入失败',
           'ADMIN',
           sysdate,
           'ADMIN',
           sysdate,
           null,
           b.company_id);
      return;
    end if;
  
    p_pid := f_get_uuid();
  
    insert into t_commodity_color_size_inf
      (commodity_color_size_inf_id,
       commodity_info_id,
       company_id,
       barcode,
       colorname,
       color_code,
       sizename,
       remarks,
       goo_id,
       sizecode,
       create_time,
       update_time)
    values
      (p_pid,
       v_commodity_id,
       p_company_id,
       p_commodity_color_size.barcode,
       p_commodity_color_size.colorname,
       p_commodity_color_size.color_code,
       p_commodity_color_size.sizename,
       p_commodity_color_size.remarks,
       p_goo_id,
       (select b.company_dict_value
          from sys_company_dict a
         inner join sys_company_dict b
            on a.company_dict_value = b.company_dict_type
           and b.company_dict_name = p_commodity_color_size.sizecode
           and b.company_id = p_company_id
         where a.company_dict_type = 'GD_SIZE_LIST'
           and a.company_id = p_company_id),
       p_commodity_color_size.create_time,
       p_commodity_color_size.update_time);
  
    --2.记录接口表信息到监控表
    update scmdata.t_commodity_color_size_ctl a
       set a.itf_id       = p_pid,
           a.return_type  = 'Y',
           a.return_msg   = '色码表重传成功',
           a.update_time  = sysdate,
           a.receive_time = sysdate
     where a.itf_id = p_commodity_color_size.goo_id
       and a.return_type in ('R', 'W');
  END dual_articles_if_v2;

  procedure roll_articles_inf is
    p_company_id varchar2(32);
    p_i          number(1);
    --p_flag       number(1);
  begin
    --获取接口的企业编号
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'ARTICLE_SUB';
  
    --如果没有需要处理的数据，退出
    select nvl(max(1), 0)
      into p_i
      from scmdata.t_commodity_color_size_inf a
     where a.company_id = p_company_id;
    if p_i = 0 then
      return;
    end if;
    --业务逻辑处理
  
    --skc表处理
    --删除不存在的标准色（软删）
    update scmdata.t_commodity_color a
       set a.skc_status = 0
     where a.company_id = p_company_id
       and a.commodity_info_id in
           (select commodity_info_id
              from scmdata.t_commodity_color_size_inf c)
       and (a.commodity_info_id, a.color_code) not in
           (select commodity_info_id, color_code
              from scmdata.t_commodity_color_size_inf b);
  
    --merge现存颜色
    merge into scmdata.t_commodity_color a
    using (select distinct c.commodity_info_id,
                           c.company_id,
                           d.rela_goo_id,
                           d.inprice,
                           max(c.colorname) over(partition by c.commodity_info_id, c.color_code) colorname,
                           c.color_code,
                           max(c.remarks) over(partition by c.commodity_info_id, c.color_code) remarks,
                           d.goo_id,
                           min(c.create_time) over(partition by c.commodity_info_id, c.color_code) create_time,
                           d.create_id,
                           min(c.update_time) over(partition by c.commodity_info_id, c.color_code) update_time,
                           d.is_set_fabric,
                           d.design_mode,
                           d.cooperation_mode
             from scmdata.t_commodity_color_size_inf c
            inner join scmdata.t_commodity_info d
               on d.commodity_info_id = c.commodity_info_id) b
    on (a.company_id = b.company_id and a.commodity_info_id = b.commodity_info_id and a.color_code = b.color_code)
    when not matched then
      insert
        (commodity_color_id,
         commodity_info_id,
         company_id,
         colorname,
         color_code,
         remarks,
         goo_id,
         commodity_color_code,
         rela_goo_id,
         skc_status,
         inprice,
         create_id,
         create_time,
         update_time,
         is_set_fabric,
         design_mode,
         cooperation_mode)
      values
        (scmdata.f_get_uuid(),
         b.commodity_info_id,
         b.company_id,
         b.colorname,
         b.color_code,
         b.remarks,
         b.goo_id,
         b.rela_goo_id || b.color_code,
         b.rela_goo_id,
         1,
         b.inprice,
         b.create_id,
         b.create_time,
         b.update_time,
         b.is_set_fabric,
         b.design_mode,
         b.cooperation_mode)
    when matched then
      update
         set a.colorname        = b.colorname,
             a.skc_status       = 1,
             a.remarks          = b.remarks,
             a.update_time      = b.update_time,
             a.is_set_fabric    = b.is_set_fabric,
             a.design_mode      = b.design_mode,
             a.cooperation_mode = b.cooperation_mode;
    --供应商处理
    --删除不存在的skc供应商
    delete from scmdata.t_commodity_supplier_color a
     where a.company_id = p_company_id
       and a.commodity_info_id in
           (select commodity_info_id
              from scmdata.t_commodity_color_size_inf c)
       and (a.commodity_info_id, a.commodity_color_code) not in
           (select commodity_info_id, b.commodity_color_code
              from scmdata.t_commodity_color b
             where b.commodity_info_id in
                   (select commodity_info_id
                      from scmdata.t_commodity_color_size_inf c));
  
    --plm处理 
    --颜色维度 20230210
    --判断是否有新增颜色
    for x in (select *
                from (select distinct a.goo_id,
                                      a.company_id,
                                      a.color_code,
                                      ci.rela_goo_id
                        from scmdata.t_commodity_color_size_inf a
                       inner join scmdata.t_commodity_info ci
                          on ci.goo_id = a.goo_id
                         and a.company_id = ci.company_id
                       where a.company_id = p_company_id
                         and ci.is_set_fabric = 1) base
               where not exists
               (select 1
                        from scmdata.t_commodity_color_size c
                       where c.goo_id = base.goo_id
                         and c.company_id = base.company_id
                         and c.color_code = base.color_code)) loop
      --新增对应颜色
      plm.pkg_good_rela_plm.status_goods_fabric_set_bom_demand(p_goods_skc_code => x.rela_goo_id ||
                                                                                   x.color_code,
                                                               p_status         => 0,
                                                               p_whether_del    => 0);
    
    end loop;
    --判断是否有删除颜色
    for x in (select distinct a.goo_id,
                              a.company_id,
                              a.color_code,
                              ci.rela_goo_id
                from scmdata.t_commodity_color_size a
               inner join scmdata.t_commodity_info ci
                  on ci.goo_id = a.goo_id
                 and a.company_id = ci.company_id
               where a.company_id = p_company_id
                 and a.commodity_info_id in
                     (select commodity_info_id
                        from scmdata.t_commodity_color_size_inf c)
                 and a.barcode not in
                     (select barcode
                        from scmdata.t_commodity_color_size_inf b)) loop
      --删除对应的颜色
      plm.pkg_good_rela_plm.status_goods_fabric_set_bom_demand(p_goods_skc_code => x.rela_goo_id ||
                                                                                   x.color_code,
                                                               p_status         => 0,
                                                               p_whether_del    => 1);
    
    end loop;
    --色码维度
    for x in (select a.goo_id, a.company_id
                from scmdata.t_commodity_color_size_inf a
               where a.company_id = p_company_id) loop
    
      plm.pkg_good_rela_plm.dual_after_dual_good_color(p_company_id => x.company_id,
                                                       p_goo_id     => x.goo_id);
    end loop;
  
    --补充新增的skc供应商
    merge into scmdata.t_commodity_supplier_color a
    using (select d.finish_time,
                  d.supplier_info_id,
                  d.pause,
                  d.primary,
                  c.goo_id,
                  c.commodity_info_id,
                  d.supplier_code,
                  c.commodity_color_code,
                  c.company_id,
                  d.operator_inner_user_id,
                  d.operator_name
             from scmdata.t_commodity_color c
            inner join scmdata.t_commodity_supplier d
               on d.commodity_info_id = c.commodity_info_id
            where c.commodity_info_id in
                  (select commodity_info_id
                     from scmdata.t_commodity_color_size_inf w)
              and c.skc_status = 1) b
    on (a.supplier_code = b.supplier_code and a.company_id = b.company_id and a.commodity_color_code = b.commodity_color_code and a.commodity_info_id = b.commodity_info_id)
    when not matched then
      insert
        (commodity_supplier_color_id,
         commodity_info_id,
         goo_id,
         company_id,
         supplier_code,
         primary,
         create_time,
         update_time,
         pause,
         finish_time,
         supplier_info_id,
         commodity_color_code,
         operator_inner_user_id,
         operator_name)
      values
        (scmdata.f_get_uuid(),
         b.commodity_info_id,
         b.goo_id,
         b.company_id,
         b.supplier_code,
         b.primary,
         sysdate,
         sysdate,
         b.pause,
         b.finish_time,
         b.supplier_info_id,
         b.commodity_color_code,
         b.operator_inner_user_id,
         b.operator_name);
  
    --清掉业务表中标准色不一样的颜色
    delete from scmdata.t_commodity_color_size a
     where a.company_id = p_company_id
       and a.commodity_info_id in
           (select commodity_info_id
              from scmdata.t_commodity_color_size_inf c)
       and a.barcode not in
           (select barcode from scmdata.t_commodity_color_size_inf b);
  
    --merge业务表
    merge into scmdata.t_commodity_color_size a
    using (select distinct c.commodity_info_id,
                           c.company_id,
                           c.barcode,
                           c.colorname,
                           c.color_code,
                           c.sizename,
                           c.remarks,
                           c.goo_id,
                           c.sizecode,
                           c.create_time,
                           c.update_time
             from scmdata.t_commodity_color_size_inf c
            where c.company_id = p_company_id) b
    on (a.company_id = b.company_id and a.barcode = b.barcode)
    when matched then
      update
         set a.colorname   = b.colorname,
             a.color_code  = b.color_code,
             a.sizecode    = b.sizecode,
             a.sizename    = b.sizename,
             a.remarks     = b.remarks,
             a.create_time = b.create_time,
             a.update_time = b.update_time
    when not matched then
      insert
        (a.commodity_color_size_id,
         a.commodity_info_id,
         a.company_id,
         a.barcode,
         a.colorname,
         a.color_code,
         a.sizename,
         a.remarks,
         a.goo_id,
         a.sizecode,
         a.create_time,
         a.update_time)
      values
        (f_get_uuid(),
         b.commodity_info_id,
         b.company_id,
         b.barcode,
         b.colorname,
         b.color_code,
         b.sizename,
         b.remarks,
         b.goo_id,
         b.sizecode,
         b.create_time,
         b.update_time);
  
    /*面料审核相关 待需求确认*/
    --如果标准色对应颜色变更，删除旧颜色审核，补充新颜色审核
    --如果货号需要印绣花审核，补充印绣花的审核
    /*暂时逻辑： 如果颜色名变更删除之前的颜色，不中新的颜色审核*/
    --删除不存在的颜色
    delete from scmdata.t_fabric_color_evaluate a
     where (a.goo_id, a.company_id) in
           (select distinct goo_id, company_id
              from scmdata.t_commodity_color_size_inf)
       and not exists (select 1
              from scmdata.t_commodity_color_size c
             where c.goo_id = a.goo_id
               and c.company_id = a.company_id
               and c.colorname = a.colorname);
  
    merge into scmdata.t_fabric_color_evaluate a
    using (select distinct co.colorname, co.goo_id, co.company_id
             from scmdata.t_commodity_info ci
            inner join scmdata.t_commodity_color_size co
               on co.commodity_info_id = ci.commodity_info_id
            where (ci.goo_id, ci.company_id) in
                  (select distinct goo_id, company_id
                     from scmdata.t_commodity_color_size_inf)) b
    on (a.goo_id = b.goo_id and a.company_id = b.company_id and a.colorname = b.colorname and a.evaluate_type = 'ML')
    when not matched then
      insert
        (a.fabric_color_evaluate_id,
         a.evaluate_id,
         a.evaluate_result,
         a.evaluate_time,
         a.create_id,
         a.create_time,
         a.memo,
         a.goo_id,
         a.colorname,
         a.update_id,
         a.update_time,
         a.company_id,
         a.risk_level,
         a.evaluate_times)
      values
        (f_get_uuid(),
         null,
         null,
         null,
         'ADMIN',
         sysdate,
         null,
         b.goo_id,
         b.colorname,
         'ADMIN',
         sysdate,
         b.company_id,
         null,
         0);
  
    --如果货号需要印绣花审核，补充印绣花的审核
    merge into scmdata.t_fabric_color_evaluate a
    using (select distinct co.colorname, co.goo_id, co.company_id
             from scmdata.t_commodity_info ci
            inner join scmdata.t_commodity_color_size co
               on co.commodity_info_id = ci.commodity_info_id
            where (ci.goo_id, ci.company_id) in
                  (select distinct goo_id, company_id
                     from scmdata.t_commodity_color_size_inf)
              and ci.need_yxh_check = 1) b
    on (a.goo_id = b.goo_id and a.company_id = b.company_id and a.colorname = b.colorname and a.evaluate_type = 'YXH')
    when not matched then
      insert
        (a.fabric_color_evaluate_id,
         a.evaluate_id,
         a.evaluate_result,
         a.evaluate_time,
         a.create_id,
         a.create_time,
         a.memo,
         a.goo_id,
         a.colorname,
         a.update_id,
         a.update_time,
         a.company_id,
         a.risk_level,
         a.evaluate_times,
         a.evaluate_type)
      values
        (f_get_uuid(),
         null,
         null,
         null,
         'ADMIN',
         sysdate,
         null,
         b.goo_id,
         b.colorname,
         'ADMIN',
         sysdate,
         b.company_id,
         null,
         0,
         'YXH');
  
    --清掉接口表
    delete from scmdata.t_commodity_color_size_inf a where 1 = 1;
  end roll_articles_inf;

  --删除逻辑
  procedure delete_info_if(p_commodity_info_delete_inf scmdata.t_commodity_info_delete_inf%rowtype) is
    v_goo_id varchar2(32);
    p_i      number(1);
    -- v_supplier_code varchar2(32);
    v_create_time       date;
    v_commodity_info_id varchar2(32);
    p_temp_id           varchar2(32);
    p_company_id        varchar2(32);
    p_supplier_code     varchar2(32);
    p_cooperation_mode  varchar2(32);
  begin
    --查询企业
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'GOOD_MAIN';
  
    --查询供应商编号
    select max(si.supplier_code)
      into p_supplier_code
      from scmdata.t_supplier_info si
     where si.company_id = p_company_id
       and si.inside_supplier_code = p_commodity_info_delete_inf.sup_id;
  
    --判断数据是否已接入
    select nvl(max(1), 0)
      into p_i
      from scmdata.t_commodity_info_delete_inf a
     where a.rela_goo_id = p_commodity_info_delete_inf.rela_goo_id
       and a.company_id = p_company_id
          --and a.supplier_code = p_supplier_code
       and a.buyerid = p_commodity_info_delete_inf.buyerid
       and a.delete_time = p_commodity_info_delete_inf.delete_time;
    if p_i = 1 then
      return;
    end if;
  
    p_temp_id := scmdata.f_get_uuid();
    insert into scmdata.t_commodity_info_delete_inf
      (commodity_info_delete_inf_id,
       company_id,
       rela_goo_id,
       delete_time,
       publish_time,
       style_number,
       category,
       product_cate,
       samll_category,
       buyerid,
       supplier_code,
       sup_id,
       goo_id,
       delete_status)
    values
      (p_temp_id,
       p_company_id,
       p_commodity_info_delete_inf.rela_goo_id,
       p_commodity_info_delete_inf.delete_time,
       null,
       p_commodity_info_delete_inf.style_number,
       p_commodity_info_delete_inf.category,
       null,
       null,
       p_commodity_info_delete_inf.buyerid,
       p_supplier_code,
       p_commodity_info_delete_inf.sup_id,
       null,
       0);
    --查询是否存在对应的数据
    select max(a.goo_id),
           max(a.create_time),
           max(a.commodity_info_id),
           max(a.cooperation_mode)
      into v_goo_id, v_create_time, v_commodity_info_id, p_cooperation_mode
      from scmdata.t_commodity_info a
     where a.rela_goo_id = p_commodity_info_delete_inf.rela_goo_id
       and a.company_id = p_company_id;
    if v_commodity_info_id is not null then
      if v_create_time < p_commodity_info_delete_inf.delete_time then
        --删除成功
        update scmdata.t_commodity_info a
           set a.pause       = 1,
               a.update_time = p_commodity_info_delete_inf.delete_time
         where a.commodity_info_id = v_commodity_info_id
           and a.pause = 1;
        update scmdata.t_commodity_info_delete_inf a
           set a.goo_id        = v_goo_id,
               a.delete_status = 1,
               a.publish_time  = sysdate
         where a.commodity_info_delete_inf_id = p_temp_id;
      
        plm.pkg_good_rela_plm.dual_after_delete_good(p_rela_goo_id      => p_commodity_info_delete_inf.rela_goo_id,
                                                     p_cooperation_mode => p_cooperation_mode);
      else
        --已被覆盖
        update scmdata.t_commodity_info_delete_inf a
           set a.goo_id        = v_goo_id,
               a.delete_status = 2,
               a.publish_time  = sysdate
         where a.commodity_info_delete_inf_id = p_temp_id;
      
      end if;
    else
      --无需覆盖
      update scmdata.t_commodity_info_delete_inf a
         set a.delete_status = 3, a.publish_time = sysdate
       where a.commodity_info_delete_inf_id = p_temp_id;
    end if;
  end delete_info_if;

  procedure dual_good_supplier_if(p_commodity_supplier scmdata.t_commodity_supplier%rowtype) is
    p_company_id            varchar2(32);
    p_commodity_supplier_id varchar2(32);
    p_good_supp_code        varchar2(32);
    p_commodity_info_id     varchar2(32);
    p_goo_id                varchar2(32);
    p_supplier_info_id      varchar2(32);
    p_is_set_fabric         number(1);
  begin
    --获取接口的企业编号
    select max(company_id)
      into p_company_id
      from scmdata.t_interface a
     where a.interface_id = 'GOOD_SUPPLIER';
  
    --获取供应商
    select max(a.supplier_code), max(a.supplier_info_id)
      into p_good_supp_code, p_supplier_info_id
      from scmdata.t_supplier_info a
     where a.company_id = p_company_id
       and a.inside_supplier_code = p_commodity_supplier.supplier_code;
    --获取商品档案
    select max(ci.commodity_info_id), max(ci.goo_id), max(ci.is_set_fabric)
      into p_commodity_info_id, p_goo_id, p_is_set_fabric
      from scmdata.t_commodity_info ci
     where ci.rela_goo_id = p_commodity_supplier.goo_id
       and ci.company_id = p_company_id;
    if p_good_supp_code is not null then
      select max(a.commodity_supplier_id)
        into p_commodity_supplier_id
        from scmdata.t_commodity_supplier a
       where a.supplier_code = p_good_supp_code
         and a.commodity_info_id = p_commodity_info_id
         and a.company_id = p_company_id;
      if p_commodity_supplier_id is null then
        p_commodity_supplier_id := scmdata.f_get_uuid();
        insert into scmdata.t_commodity_supplier
          (commodity_supplier_id,
           commodity_info_id,
           goo_id,
           company_id,
           supplier_code,
           supplier_info_id,
           primary,
           buyer,
           inprice,
           delivery_days,
           order_base_amount,
           order_start_amount,
           color_start_amount,
           size_start_amount,
           min_inprice,
           min_date_time,
           sup_pack_amount,
           fabric_price,
           accessories_price,
           design_price,
           design_profit_price,
           proc_price,
           proc_profit_price,
           other_price,
           suptowh_days,
           create_time,
           update_time,
           operator_inner_user_id,
           operator_name,
           pause,
           order_start_date,
           finish_time)
        values
          (p_commodity_supplier_id,
           p_commodity_info_id,
           p_goo_id,
           p_company_id,
           p_good_supp_code,
           p_supplier_info_id,
           p_commodity_supplier.primary,
           p_commodity_supplier.buyer,
           p_commodity_supplier.inprice,
           p_commodity_supplier.delivery_days,
           p_commodity_supplier.order_base_amount,
           p_commodity_supplier.order_start_amount,
           p_commodity_supplier.color_start_amount,
           p_commodity_supplier.size_start_amount,
           p_commodity_supplier.min_inprice,
           p_commodity_supplier.min_date_time,
           p_commodity_supplier.sup_pack_amount,
           p_commodity_supplier.fabric_price,
           p_commodity_supplier.accessories_price,
           p_commodity_supplier.design_price,
           p_commodity_supplier.design_profit_price,
           p_commodity_supplier.proc_price,
           p_commodity_supplier.proc_profit_price,
           p_commodity_supplier.other_price,
           p_commodity_supplier.suptowh_days,
           p_commodity_supplier.create_time,
           p_commodity_supplier.update_time,
           p_commodity_supplier.operator_inner_user_id,
           p_commodity_supplier.operator_name,
           p_commodity_supplier.pause,
           p_commodity_supplier.order_start_date,
           p_commodity_supplier.finish_time);
        --如果skc
        if p_commodity_supplier.pause = 0 then
          --同步skc供应商
          merge into scmdata.t_commodity_supplier_color a
          using (select *
                   from scmdata.t_commodity_color c
                  where c.commodity_info_id = p_commodity_info_id
                    and skc_status = 1) b
          on (a.supplier_code = p_good_supp_code and a.company_id = p_company_id and a.commodity_info_id = p_commodity_info_id and a.commodity_color_code = b.commodity_color_code)
          when not matched then
            insert
              (commodity_supplier_color_id,
               commodity_info_id,
               goo_id,
               company_id,
               supplier_code,
               primary,
               create_time,
               update_time,
               pause,
               finish_time,
               supplier_info_id,
               commodity_color_code,
               operator_inner_user_id,
               operator_name)
            values
              (scmdata.f_get_uuid(),
               p_commodity_info_id,
               p_goo_id,
               p_company_id,
               p_good_supp_code,
               p_commodity_supplier.primary,
               p_commodity_supplier.create_time,
               p_commodity_supplier.update_time,
               p_commodity_supplier.pause,
               p_commodity_supplier.finish_time,
               p_supplier_info_id,
               b.commodity_color_code,
               p_commodity_supplier.operator_inner_user_id,
               p_commodity_supplier.operator_name)
          when matched then
            update
               set a.update_time            = p_commodity_supplier.update_time,
                   a.pause                  = p_commodity_supplier.pause,
                   a.primary                = p_commodity_supplier.primary,
                   a.finish_time            = p_commodity_supplier.finish_time,
                   a.operator_inner_user_id = p_commodity_supplier.operator_inner_user_id,
                   a.operator_name          = p_commodity_supplier.operator_name;

        end if;
        if p_is_set_fabric = 1 then
          for x in (select *
                      from scmdata.t_commodity_color c
                     where c.commodity_info_id = p_commodity_info_id
                       and skc_status = 1) loop
            plm.pkg_good_rela_plm.status_goods_fabric_set_bom_demand(p_goods_skc_code => x.commodity_color_code,
                                                                     p_status         => 0,
                                                                     p_whether_del    => 0);
          end loop;
        end if;
      else
        update scmdata.t_commodity_supplier a
           set a.primary                = p_commodity_supplier.primary,
               a.buyer                  = p_commodity_supplier.buyer,
               a.inprice                = p_commodity_supplier.inprice,
               a.delivery_days          = p_commodity_supplier.delivery_days,
               a.order_base_amount      = p_commodity_supplier.order_base_amount,
               a.order_start_amount     = p_commodity_supplier.order_start_amount,
               a.color_start_amount     = p_commodity_supplier.color_start_amount,
               a.size_start_amount      = p_commodity_supplier.size_start_amount,
               a.min_inprice            = p_commodity_supplier.min_inprice,
               a.min_date_time          = p_commodity_supplier.min_date_time,
               a.sup_pack_amount        = p_commodity_supplier.sup_pack_amount,
               a.fabric_price           = p_commodity_supplier.fabric_price,
               a.accessories_price      = p_commodity_supplier.accessories_price,
               a.design_price           = p_commodity_supplier.design_price,
               a.design_profit_price    = p_commodity_supplier.design_profit_price,
               a.proc_price             = p_commodity_supplier.proc_price,
               a.proc_profit_price      = p_commodity_supplier.proc_profit_price,
               a.other_price            = p_commodity_supplier.other_price,
               a.suptowh_days           = p_commodity_supplier.suptowh_days,
               a.create_time            = p_commodity_supplier.create_time,
               a.update_time            = p_commodity_supplier.update_time,
               a.operator_inner_user_id = p_commodity_supplier.operator_inner_user_id,
               a.operator_name          = p_commodity_supplier.operator_name,
               a.pause                  = p_commodity_supplier.pause,
               a.order_start_date       = p_commodity_supplier.order_start_date,
               a.finish_time            = p_commodity_supplier.finish_time
         where a.commodity_supplier_id = p_commodity_supplier_id;
        ---更新供应商色
        update scmdata.t_commodity_supplier_color a
           set a.update_time            = p_commodity_supplier.update_time,
               a.pause                  = p_commodity_supplier.pause,
               a.primary                = p_commodity_supplier.primary,
               a.finish_time            = p_commodity_supplier.finish_time,
               a.operator_inner_user_id = p_commodity_supplier.operator_inner_user_id,
               a.operator_name          = p_commodity_supplier.operator_name
         where a.commodity_info_id = p_commodity_info_id
           and a.supplier_code = p_good_supp_code
           and a.company_id = p_company_id;
          --skc是否被禁用
          merge into scmdata.t_commodity_supplier_color a
          using (select *
                   from scmdata.t_commodity_color c
                  where c.commodity_info_id = p_commodity_info_id) b
          on (a.supplier_code = p_good_supp_code and a.company_id = p_company_id and a.commodity_info_id = p_commodity_info_id and a.commodity_color_code = b.commodity_color_code)
          when matched then
            update
               set a.update_time            = p_commodity_supplier.update_time,
                   a.skc_pause              = b.skc_status,
                   a.operator_inner_user_id = p_commodity_supplier.operator_inner_user_id,
                   a.operator_name          = p_commodity_supplier.operator_name;
      end if;
      update scmdata.t_commodity_supplier_ctl a
         set a.return_type = 'Y'
       where a.itf_id = p_commodity_supplier.goo_id
         and a.company_id = p_company_id;
    end if;
  end dual_good_supplier_if;
end pkg_inf_good;
/

