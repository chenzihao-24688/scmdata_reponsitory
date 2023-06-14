create or replace package scmdata.PKG_FASTLION_OPER_LOG_DW is

  -- Author  : SANFU
  -- Created : 2022/7/13 15:59:40
  -- Purpose : 速狮平台操作日志dw
  --重算每个item_id的归属应用和父级菜单
  procedure dw_oper_log_job;

  --重算每个item_id的归属应用和父级菜单
  procedure dw_item_apply_list;

  --平台操作日志处理
  procedure dw_fastlion_sys_oper_log(pi_date date);

end PKG_FASTLION_OPER_LOG_DW;
/

create or replace package body scmdata.PKG_FASTLION_OPER_LOG_DW is

  procedure dw_oper_log_job is
  begin
    scmdata.pkg_fastlion_oper_log_dw.dw_item_apply_list;
    scmdata.pkg_fastlion_oper_log_dw.dw_fastlion_sys_oper_log(pi_date => sysdate);
  end;
  
  procedure dw_item_apply_list is
    p_i    int := 0;
    p_flag int;
  begin
    delete from scmdata.sys_group_item_dw a where 1 = 1;
    --初始化临时表
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id,
       item_id,
       apply_root_name,
       last_menu_name,
       LAST_MENU_ID)
      select scmdata.f_get_uuid_pe(), base.*
        from (select a.item_id,
                     a.caption_sql apply_root_name,
                     a.caption_sql last_menu_name,
                     a.item_id     LAST_MENU_ID
                from nbw.sys_item a
               inner join nbw.sys_tree_list tl
                  on tl.item_id = a.item_id
                 and tl.parent_id = 'menuroot'
               where a.item_id not in
                     ('item-test', 'pj_xxl_job', 'monitor-1000', 'menu-help')) base;
    --补充个人中心
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id,
       item_id,
       apply_root_name,
       last_menu_name,
       LAST_MENU_ID,
       scaned)
    values
      (scmdata.f_get_uuid(),
       'personal',
       '个人中心',
       '个人中心',
       'personal',
       3);
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id,
       item_id,
       apply_root_name,
       last_menu_name,
       LAST_MENU_ID)
    values
      (scmdata.f_get_uuid(), 'u_100', '个人中心', '个人中心', 'u_100');
    --货物类归属范围
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id, item_id, apply_root_name, last_menu_name, scaned)
    values
      (scmdata.f_get_uuid(), 'a_good_201', '商品档案', '商品档案列表', 3);
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id, item_id, apply_root_name, last_menu_name, scaned)
    values
      (scmdata.f_get_uuid(), 'a_good_130', '商品档案', '商品档案列表', 3);
    --补充从表
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id, item_id, apply_root_name, last_menu_name, scaned)
    values
      (scmdata.f_get_uuid(), 'a_good_130_1', '商品档案', '商品档案列表', 3);
  
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id, item_id, apply_root_name, last_menu_name, scaned)
    values
      (scmdata.f_get_uuid(), 'a_good_130_2', '商品档案', '商品档案列表', 3);
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id, item_id, apply_root_name, last_menu_name, scaned)
    values
      (scmdata.f_get_uuid(), 'a_good_130_3', '商品档案', '商品档案列表', 3);
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id, item_id, apply_root_name, last_menu_name, scaned)
    values
      (scmdata.f_get_uuid(), 'a_good_130_4', '商品档案', '商品档案列表', 3);
    insert into scmdata.sys_group_item_dw
      (group_item_dw_id, item_id, apply_root_name, last_menu_name, scaned)
    values
      (scmdata.f_get_uuid(), 'a_good_130_5', '商品档案', '商品档案列表', 3);
  
    --循环十次，或者所有item找到父级后停止
    loop
      update scmdata.sys_group_item_dw a
         set a.scaned = 2
       where a.scaned = 1;
      update scmdata.sys_group_item_dw a
         set a.scaned = 1
       where a.scaned = 0;
    
      for x in (select a.*,
                       b.item_type,
                       b.pause,
                       (select nvl(max(1), 0)
                          from nbw.sys_tree_list tp
                         inner join nbw.sys_item ti
                            on ti.item_id = tp.parent_id
                         where (ti.item_type = 'menu' or not exists
                                (select 1
                                   from nbw.sys_item_list c
                                  where c.item_id = ti.item_id))
                           and tp.pause = 0
                           and ti.pause = 0
                           and tp.item_id = a.item_id) is_menu
                  from scmdata.sys_group_item_dw a
                 inner join nbw.sys_item b
                    on b.item_id = a.item_id
                 where a.scaned = 1) loop
      
        --树的从节点,其中末级节点值只写menu节点或者父级节点是menu节点的
        merge into scmdata.sys_group_item_dw a
        using (select distinct i.item_id, i.caption_sql, i.item_type
                 from nbw.sys_tree_list tr
                inner join nbw.sys_item i
                   on i.item_id = tr.item_id
                where tr.parent_id = x.item_id
                  and tr.pause = 0
                  and i.pause = 0) b
        on (a.item_id = b.item_id)
        when not matched then
          insert
            (a.group_item_dw_id,
             a.item_id,
             a.apply_root_name,
             a.last_menu_name,
             a.LAST_MENU_ID)
          values
            (scmdata.f_get_uuid(),
             b.item_id,
             x.apply_root_name,
             case
               when x.item_type = 'menu' or b.item_type = 'menu' then
                b.caption_sql
               else
                x.last_menu_name
             end,
             case
               when x.item_type = 'menu' or b.item_type = 'menu' then
                b.item_id
               else
                x.LAST_MENU_ID
             end) when matched then update set a.last_menu_name =case
            when x.item_type = 'menu' or b.item_type = 'menu' then
             b.caption_sql
            else
             a.last_menu_name
          end, a.LAST_MENU_ID =case
            when x.item_type = 'menu' or b.item_type = 'menu' then
             b.item_id
            else
             a.LAST_MENU_ID
          end where a.LAST_MENU_ID <> b.item_id and a.scaned <> 3;
      
        --从表
        merge into scmdata.sys_group_item_dw a
        using (select distinct i.item_id, i.caption_sql
                 from nbw.sys_item_rela tr
                inner join nbw.sys_item i
                   on i.item_id = tr.relate_id
                where tr.item_id = x.item_id
                  and tr.pause = 0
                  and i.pause = 0) b
        on (a.item_id = b.item_id)
        when not matched then
          insert
            (a.group_item_dw_id,
             a.item_id,
             a.apply_root_name,
             a.last_menu_name,
             a.LAST_MENU_ID)
          values
            (scmdata.f_get_uuid(),
             b.item_id,
             x.apply_root_name,
             x.last_menu_name,
             x.item_id)
        when matched then
          update
             set a.last_menu_name = case
                                      when x.is_menu = 1 and
                                           instr(';' || a.LAST_MENU_ID || ';', ';' || x.item_id || ';') = 0 then
                                       a.last_menu_name || ';' || x.last_menu_name
                                      else
                                       a.last_menu_name
                                    end,
                 a.LAST_MENU_ID   = case
                                      when x.is_menu = 1 and
                                           instr(';' || a.LAST_MENU_ID || ';', ';' || x.item_id || ';') = 0 then
                                       a.LAST_MENU_ID || ';' || x.item_id
                                      else
                                       a.LAST_MENU_ID
                                    end
           where a.LAST_MENU_ID <> b.item_id
             and a.scaned <> 3;
        --tab界面
        merge into scmdata.sys_group_item_dw a
        using (select distinct i.item_id, i.caption_sql
                 from nbw.sys_web_union tr
                inner join nbw.sys_item i
                   on i.item_id = tr.union_item_id
                where tr.item_id = x.item_id
                  and tr.pause = 0
                  and i.pause = 0) b
        on (a.item_id = b.item_id)
        when not matched then
          insert
            (a.group_item_dw_id,
             a.item_id,
             a.apply_root_name,
             a.last_menu_name,
             a.LAST_MENU_ID)
          values
            (scmdata.f_get_uuid(),
             b.item_id,
             x.apply_root_name,
             x.last_menu_name,
             x.item_id)
        when matched then
          update
             set a.last_menu_name = case
                                      when x.is_menu = 1 and
                                           instr(';' || a.LAST_MENU_ID || ';', ';' || x.item_id || ';') = 0 then
                                       a.last_menu_name || ';' || x.last_menu_name
                                      else
                                       a.last_menu_name
                                    end,
                 a.LAST_MENU_ID   = case
                                      when x.is_menu = 1 and
                                           instr(';' || a.LAST_MENU_ID || ';', ';' || x.item_id || ';') = 0 then
                                       a.LAST_MENU_ID || ';' || x.item_id
                                      else
                                       a.LAST_MENU_ID
                                    end
           where a.LAST_MENU_ID <> b.item_id
             and a.scaned <> 3;
        --action的跳转
        merge into scmdata.sys_group_item_dw a
        using (select distinct i.item_id, i.caption_sql
                 from nbw.sys_item_element_rela ier
                inner join nbw.sys_action a
                   on a.element_id = ier.element_id
                inner join nbw.sys_cond_rela cr
                   on cr.ctl_id = a.element_id
                inner join nbw.sys_cond_operate co
                   on co.cond_id = cr.cond_id
                inner join nbw.sys_item i
                   on i.item_id = co.to_confirm_item_id
                where ier.item_id = x.item_id
                  and x.item_id <> 'g_520'
                  and i.pause = 0
                  and i.item_id not in
                      (select item_id from scmdata.sys_group_item_dw)) b
        on (a.item_id = b.item_id)
        when not matched then
          insert
            (a.group_item_dw_id,
             a.item_id,
             a.apply_root_name,
             a.last_menu_name,
             a.LAST_MENU_ID)
          values
            (scmdata.f_get_uuid(),
             b.item_id,
             x.apply_root_name,
             x.last_menu_name,
             x.item_id);
        --associate的跳转
        merge into scmdata.sys_group_item_dw a
        using (select distinct i.item_id, i.caption_sql
                 from nbw.sys_item_element_rela ier
                inner join nbw.sys_associate a
                   on a.element_id = ier.element_id
                inner join nbw.sys_tree_list tl
                   on tl.node_id = a.node_id
                inner join nbw.sys_item i
                   on i.item_id = tl.item_id
                where ier.item_id = x.item_id
                  and i.pause = 0) b
        on (a.item_id = b.item_id)
        when not matched then
          insert
            (a.group_item_dw_id,
             a.item_id,
             a.apply_root_name,
             a.last_menu_name,
             a.LAST_MENU_ID)
          values
            (scmdata.f_get_uuid(),
             b.item_id,
             x.apply_root_name,
             x.last_menu_name,
             x.item_id)
        when matched then
          update
             set a.last_menu_name = case
                                      when x.is_menu = 1 and
                                           instr(';' || a.LAST_MENU_ID || ';', ';' || x.item_id || ';') = 0 then
                                       a.last_menu_name || ';' || x.last_menu_name
                                      else
                                       a.last_menu_name
                                    end,
                 a.LAST_MENU_ID   = case
                                      when x.is_menu = 1 and
                                           instr(';' || a.LAST_MENU_ID || ';', ';' || x.item_id || ';') = 0 then
                                       a.LAST_MENU_ID || ';' || x.item_id
                                      else
                                       a.LAST_MENU_ID
                                    end
           where a.LAST_MENU_ID <> b.item_id
             and a.scaned <> 3;
      
        --link_field
        merge into scmdata.sys_group_item_dw a
        using (select distinct i.item_id, i.caption_sql
                 from nbw.sys_link_list tr
                inner join nbw.sys_item i
                   on i.item_id = tr.to_item_id
                where tr.item_id = x.item_id
                  and tr.pause = 0
                  and i.pause = 0) b
        on (a.item_id = b.item_id)
        when not matched then
          insert
            (a.group_item_dw_id,
             a.item_id,
             a.apply_root_name,
             a.last_menu_name,
             a.LAST_MENU_ID)
          values
            (scmdata.f_get_uuid(),
             b.item_id,
             x.apply_root_name,
             x.last_menu_name,
             x.item_id)
        when matched then
          update
             set a.last_menu_name = case
                                      when x.is_menu = 1 and
                                           instr(';' || a.LAST_MENU_ID || ';', ';' || x.item_id || ';') = 0 then
                                       a.last_menu_name || ';' || x.last_menu_name
                                      else
                                       a.last_menu_name
                                    end,
                 a.LAST_MENU_ID   = case
                                      when x.is_menu = 1 and
                                           instr(';' || a.LAST_MENU_ID || ';', ';' || x.item_id || ';') = 0 then
                                       a.LAST_MENU_ID || ';' || x.item_id
                                      else
                                       a.LAST_MENU_ID
                                    end
           where a.LAST_MENU_ID <> b.item_id
             and a.scaned <> 3;
      
      end loop;
    
      p_i := p_i + 1;
      exit when p_i > 10;
      select nvl(max(1), 0)
        into p_flag
        from scmdata.sys_group_item_dw a
       where a.scaned = 0;
      exit when p_flag = 0;
    end loop;
  
    --清掉不存在sys_item关联的表
    delete from scmdata.sys_group_item_dw a
     where not exists
     (select 1 from nbw.sys_item a where a.item_id = a.item_id);
  
  end dw_item_apply_list;

  procedure dw_fastlion_sys_oper_log(pi_date date) is
    p_day  date := trunc(pi_date, 'dd');
    p_flag number(1);
    p_i    int := 0;
  begin
    delete from scmdata.sys_group_oper_log_dw a where a.when_day = p_day;
    --从【nbw.SYS_OPER_LOGS】中获取数据，取数规则：
    --1.“OPT_TYPE”=100 and “REST_DESC”=登陆成功
    insert into scmdata.sys_group_oper_log_dw
      (oper_log_dw_id,
       user_account,
       user_id,
       opt_type,
       opt_desc,
       item_id,
       oper_time,
       when_day)
      select scmdata.f_get_uuid_pe(), base.*
        from (select distinct a.user_id user_account,
                              u.user_id,
                              a.opt_type,
                              a.opt_desc,
                              a.item_id,
                              a.opt_time,
                              trunc(a.opt_time, 'dd') when_day
                from nbw.sys_oper_logs a
               inner join scmdata.sys_user u
                  on u.user_account = a.user_id
               where trunc(a.opt_time, 'dd') = p_day
                 and a.opt_type = '100'
                 and a.rest_desc = '登陆成功'
                 and a.uuid is not null) base;
  
    --2.“OPT_TYPE”=199 and “REST_DESC”=退出成功
    insert into scmdata.sys_group_oper_log_dw
      (oper_log_dw_id,
       user_account,
       user_id,
       opt_type,
       opt_desc,
       item_id,
       oper_time,
       when_day)
      select scmdata.f_get_uuid_pe(), base.*
        from (select distinct a.user_id user_account,
                              u.user_id,
                              a.opt_type,
                              a.opt_desc,
                              a.item_id,
                              a.opt_time,
                              trunc(a.opt_time, 'dd') when_day
                from nbw.sys_oper_logs a
               inner join scmdata.sys_user u
                  on u.user_account = a.user_id
               where trunc(a.opt_time, 'dd') = p_day
                 and a.opt_type = '199'
                 and a.rest_desc = '退出成功'
                 and a.uuid is not null) base;
  
    --4.“OPT_TYPE”=404 and “REST_DESC”=（操作执行成功 or associate获取成功）
    --  4.1 同一“user_id”在同一“OPT_TIME”下连续生成2条同一“item_id”（1条执行状态=操作执行成功，1条执行状态=associate获取成功）时，剔重，只统计最早生成的那一条
    ---  4.2 关于一个Associate执行item_id共用多个模块，该item_id对应的归属应用和菜单为固定值：
    --     ① “item_id”=a_good_201  or  a_good_130，归属应用=商品档案，末级菜单=商品档案列表
    insert into scmdata.sys_group_oper_log_dw
      (oper_log_dw_id,
       user_account,
       user_id,
       opt_type,
       opt_desc,
       item_id,
       oper_time,
       when_day,
       element_id)
      select scmdata.f_get_uuid_pe(), base.*
        from (select distinct a.user_id user_account,
                              u.user_id,
                              a.opt_type,
                              a.opt_desc,
                              a.item_id,
                              a.opt_time,
                              trunc(a.opt_time, 'dd') when_day,
                              substr(replace(a.origin_url,
                                             '/api/v1/item/' || a.item_id ||
                                             '/associate/',
                                             ''),
                                     0,
                                     instr(replace(a.origin_url,
                                                   '/api/v1/item/' ||
                                                   a.item_id || '/associate/',
                                                   ''),
                                           '/',
                                           -1) - 1) element_id
                from nbw.sys_oper_logs a
               inner join scmdata.sys_user u
                  on u.user_account = a.user_id
               where trunc(a.opt_time, 'dd') = p_day
                 and a.opt_type = '404'
                 and a.rest_desc in ('操作执行成功', 'associate获取成功')
                 and a.uuid is not null) base;
  
    ----5.“OPT_TYPE”=401 and “REST_DESC”=操作执行成功 通过url获取element_id
    insert into scmdata.sys_group_oper_log_dw
      (oper_log_dw_id,
       user_account,
       user_id,
       opt_type,
       opt_desc,
       item_id,
       oper_time,
       when_day,
       element_id)
      select scmdata.f_get_uuid_pe(), base.*
        from (select distinct a.user_id user_account,
                              u.user_id,
                              a.opt_type,
                              a.opt_desc,
                              a.item_id,
                              a.opt_time,
                              trunc(a.opt_time, 'dd') when_day,
                              substr(replace(a.origin_url,
                                             '/api/v1/item/' || a.item_id ||
                                             '/action/',
                                             ''),
                                     0,
                                     instr(replace(a.origin_url,
                                                   '/api/v1/item/' ||
                                                   a.item_id || '/action/',
                                                   ''),
                                           '/',
                                           -1) - 1) element_id
                from nbw.sys_oper_logs a
               inner join scmdata.sys_user u
                  on u.user_account = a.user_id
               where trunc(a.opt_time, 'dd') = p_day
                 and a.opt_type = '401'
                 and a.rest_desc in ('操作执行成功')
                 and a.uuid is not null) base;
  
    --6.“OPT_TYPE”=302 and “REST_DESC”=（操作执行成功  or  [null]）
    --  6.1 关于一个数据查询item_id共用多个模块，该item_id对应的归属应用和菜单的取值规则：
    --     ① 以该“item_id”+“user_id”的操作时间降序，往下取操作时间最新的共用模块
  
    insert into scmdata.sys_group_oper_log_dw
      (oper_log_dw_id,
       user_account,
       user_id,
       opt_type,
       opt_desc,
       item_id,
       oper_time,
       when_day)
      select scmdata.f_get_uuid_pe(), base.*
        from (select distinct a.user_id user_account,
                              u.user_id,
                              a.opt_type,
                              a.opt_desc,
                              a.item_id,
                              a.opt_time,
                              trunc(a.opt_time, 'dd') when_day
                from nbw.sys_oper_logs a
               inner join scmdata.sys_user u
                  on u.user_account = a.user_id
               where trunc(a.opt_time, 'dd') = p_day
                 and a.opt_type = '302'
                 and (a.rest_desc = '退出成功' or a.rest_desc is null)
                 and a.uuid is not null) base;
  
    --3.“OPT_TYPE”=301 and “REST_DESC”=操作执行成功
    --  3.1 同一“user_id”在同一“OPT_TIME”下连续生成多条同一“item_id”时，剔重，只统计一条
    --7.“OPT_TYPE”=303 and “REST_DESC”=操作执行成功
    --8.“OPT_TYPE”=201 and “REST_DESC”=操作执行成功
    --9.“OPT_TYPE”=202 and “REST_DESC”=操作执行成功
    insert into scmdata.sys_group_oper_log_dw
      (oper_log_dw_id,
       user_account,
       user_id,
       opt_type,
       opt_desc,
       item_id,
       oper_time,
       when_day)
      select scmdata.f_get_uuid_pe(), base.*
        from (select distinct a.user_id user_account,
                              u.user_id,
                              a.opt_type,
                              a.opt_desc,
                              a.item_id,
                              a.opt_time,
                              trunc(a.opt_time, 'dd') when_day
                from nbw.sys_oper_logs a
               inner join scmdata.sys_user u
                  on u.user_account = a.user_id
               where trunc(a.opt_time, 'dd') = p_day
                 and a.opt_type in ('303', '201', '202', '301')
                 and a.rest_desc = '操作执行成功'
                 and a.uuid is not null) base;
    --10.“OPT_TYPE”=505 and “REST_DESC”=解析成功 --通过url获取element_id
    insert into scmdata.sys_group_oper_log_dw
      (oper_log_dw_id,
       user_account,
       user_id,
       opt_type,
       opt_desc,
       item_id,
       oper_time,
       when_day)
      select scmdata.f_get_uuid_pe(), base.*
        from (select distinct a.user_id user_account,
                              u.user_id,
                              a.opt_type,
                              a.opt_desc,
                              a.item_id,
                              a.opt_time,
                              trunc(a.opt_time, 'dd') when_day
                from nbw.sys_oper_logs a
               inner join scmdata.sys_user u
                  on u.user_account = a.user_id
               where trunc(a.opt_time, 'dd') = p_day
                 and a.opt_type = '505'
                 and a.rest_desc = '解析成功'
                 and a.uuid is not null) base;
  
    --统一处理菜单内容
  
    --20220716过滤掉top的数据
  
    delete from scmdata.sys_group_oper_log_dw a where a.item_id = 'top';
  
    --根据itemdw表确定各菜单属于哪个表
    update scmdata.sys_group_oper_log_dw a
       set a.last_menu_name =
           (select last_menu_name
              from scmdata.sys_group_item_dw b
             where b.item_id = a.item_id
               and b.last_menu_name not like '%;%'),
           a.apply_root_name =
           (select apply_root_name
              from scmdata.sys_group_item_dw b
             where b.item_id = a.item_id
               and b.last_menu_name not like '%;%')
     where a.when_day = p_day
       and a.item_id is not null
       and a.last_menu_name is null;
    --对于有多个归属的菜单，往上搜索指存在
    loop
      update scmdata.sys_group_oper_log_dw a
         set a.last_menu_name =
             (select max(z.last_menu_name) keep(dense_rank first order by z.oper_time desc)
                from scmdata.sys_group_oper_log_dw z
               where instr(';' ||
                           (select b.last_menu_id
                              from scmdata.sys_group_item_dw b
                             where b.item_id = a.item_id
                               and b.last_menu_name like '%;%') || ';',
                           ';' || z.item_id || ';') > 0
                 and z.oper_time <= a.oper_time),
             a.apply_root_name =
             (select max(z.apply_root_name) keep(dense_rank first order by z.oper_time desc)
                from scmdata.sys_group_oper_log_dw z
               where instr(';' ||
                           (select b.last_menu_id
                              from scmdata.sys_group_item_dw b
                             where b.item_id = a.item_id
                               and b.last_menu_name like '%;%') || ';',
                           ';' || z.item_id || ';') > 0
                 and z.oper_time <= a.oper_time)
      
       where a.when_day = p_day
         and a.item_id is not null
         and a.last_menu_name is null;
    
      p_i := p_i + 1;
      exit when p_i > 10;
      select nvl(max(1), 0)
        into p_flag
        from scmdata.sys_group_oper_log_dw a
       inner join scmdata.sys_group_item_dw b
          on a.item_id = b.item_id
       where a.last_menu_name is null;
      exit when p_flag = 0;
    
    end loop;
  end dw_fastlion_sys_oper_log;

end PKG_FASTLION_OPER_LOG_DW;
/

