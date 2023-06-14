create or replace package scmdata.sf_group_apply_pkg is

  -- Author  : SANFU
  -- Created : 2020/7/7 11:27:08
  -- Purpose : 应用管理

  --启用，停用  更新应用状态（0：正常，1：停用）
  PROCEDURE update_apply_pause(p_apply_id VARCHAR2, p_status number);
  --上下架  更新应用状态（0：上架，1：下架）
  PROCEDURE update_apply_status(p_apply_id VARCHAR2, p_apply_status number);

end sf_group_apply_pkg;
/

create or replace package body scmdata.sf_group_apply_pkg is

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:42:13
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   启用，停用  更新应用状态（0：正常，1：停用）
  * Obj_Name    : UPDATE_APPLY_PAUSE
  * Arg_Number  : 2
  * P_APPLY_ID : 应用编号
  * P_STATUS : 应用禁用状态
  *============================================*/
  PROCEDURE update_apply_pause(p_apply_id VARCHAR2, p_status number) IS
    v_status       number;
    v_apply_status number;
    x_err_msg      varchar2(1000);
    apply_exp exception;
    --下游关联应用
    cursor group_apply_role_datas is
      with b as
       (select a.rela_apply_id, a.force_bind, a.apply_rela_id, a.pause
          from scmdata.sys_group_apply g, scmdata.sys_group_apply_rela a
         where g.apply_id = a.apply_id
           and g.apply_id = p_apply_id)
      select b.rela_apply_id, b.apply_rela_id, ga.pause, ga.apply_status
        from scmdata.sys_group_apply ga, b
       where ga.apply_id = b.rela_apply_id;
    --上游关联应用
    cursor group_apply_role_up_datas is
      with c as
       (select a.rela_apply_id, a.force_bind, a.apply_rela_id, a.pause
          from scmdata.sys_group_apply g, scmdata.sys_group_apply_rela a
         where g.apply_id = a.apply_id
           and a.rela_apply_id = p_apply_id)
      select c.rela_apply_id, c.apply_rela_id, ga.pause, ga.apply_status
        from scmdata.sys_group_apply ga, c
       where ga.apply_id = c.rela_apply_id;
  BEGIN
    select g.pause
      into v_status
      from scmdata.sys_group_apply g
     where g.apply_id = p_apply_id;
  
    if p_status <> v_status then
      --1.应用停用
      if p_status = 1 then
        --级联更新应用状态为 下架
        update scmdata.sys_group_apply g
           set g.apply_status = 1
         where g.apply_id = p_apply_id;
        --绑定在该应用下的所有应用，与之的应用关系，也变为停用，即不可用状态
        /*        for role_rec in group_apply_role_datas loop
          update scmdata.sys_group_apply_rela ga
             set ga.pause = 1
           where ga.apply_rela_id = role_rec.apply_rela_id;
        end loop;*/
      end if;
    
      --2.启用
      --启用 则需要判断其关联应用的应用状态是停用还是启用的
      /*      if p_status = 0 then
              for role_rec in group_apply_role_datas loop
                --增加判断条件  启用:需要判断其关联应用的应用是停用还是启用的,停用则不做操作        
      \*          update scmdata.sys_group_apply_rela ga
                   set ga.pause = 0
                 where ga.apply_rela_id = role_rec.apply_rela_id;*\
                if role_rec.pause = 0 then
                  --更新应用所绑定的应用关系为启用
                  update scmdata.sys_group_apply_rela ga
                     set ga.pause = 0
                   where ga.apply_rela_id = role_rec.apply_rela_id;
                else
                  update scmdata.sys_group_apply_rela ga
                     set ga.pause = 1
                   where ga.apply_rela_id = role_rec.apply_rela_id;
                end if;
              end loop;
            end if;*/
    
      --3.状态更新为启用或停用
      update scmdata.sys_group_apply g
         set g.pause = p_status
       where g.apply_id = p_apply_id;
    
      select g.apply_status
        into v_apply_status
        from scmdata.sys_group_apply g
       where g.apply_id = p_apply_id;
    
      --4.绑定在该应用下的所有应用，与之的应用关系，随着应用的启停，上下架，应用关系跟着变
      if p_status = 0 and v_apply_status = 0 then
        --上游关联应用
        for up_role_rec in group_apply_role_up_datas loop
          update scmdata.sys_group_apply_rela ga
             set ga.pause = 0
           where ga.apply_rela_id = up_role_rec.apply_rela_id;
        end loop;
        --下游关联应用
        for role_rec in group_apply_role_datas loop
          --增加判断条件  启用:需要判断其关联应用的应用是停用还是启用的,停用则不做操作        
          if role_rec.pause = 0 and role_rec.apply_status = 0 then
            --更新应用所绑定的应用关系为启用
            update scmdata.sys_group_apply_rela ga
               set ga.pause = 0
             where ga.apply_rela_id = role_rec.apply_rela_id;
          else
            update scmdata.sys_group_apply_rela ga
               set ga.pause = 1
             where ga.apply_rela_id = role_rec.apply_rela_id;
          end if;
        end loop;
      else
        --下游关联应用
        for role_rec in group_apply_role_datas loop
          update scmdata.sys_group_apply_rela ga
             set ga.pause = 1
           where ga.apply_rela_id = role_rec.apply_rela_id;
        end loop;
        --上游关联应用
        for up_role_rec in group_apply_role_up_datas loop
          update scmdata.sys_group_apply_rela ga
             set ga.pause = 1
           where ga.apply_rela_id = up_role_rec.apply_rela_id;
        end loop;
      end if;
    
    else
      --操作重复报提示信息
      raise apply_exp;
    end if;
  exception
    when apply_exp then
      x_err_msg := '不可重复操作！！';
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
  END update_apply_pause;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:43:24
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   更新应用状态
  * Obj_Name    : UPDATE_APPLY_STATUS
  * Arg_Number  : 2
  * P_APPLY_ID : 应用编号
  * P_APPLY_STATUS : 应用状态
  *============================================*/

  PROCEDURE update_apply_status(p_apply_id VARCHAR2, p_apply_status number) IS
    v_status  number;
    v_pause   number;
    x_err_msg varchar2(1000);
    apply_exp exception;
    pause_exp exception;
    cursor group_apply_role_datas is
      with b as
       (select a.rela_apply_id, a.force_bind, a.apply_rela_id, a.pause
          from scmdata.sys_group_apply g, scmdata.sys_group_apply_rela a
         where g.apply_id = a.apply_id
           and g.apply_id = p_apply_id)
      select b.rela_apply_id, b.apply_rela_id, ga.pause, ga.apply_status
        from scmdata.sys_group_apply ga, b
       where ga.apply_id = b.rela_apply_id;
    --上游关联应用
    cursor group_apply_role_up_datas is
      with c as
       (select a.rela_apply_id, a.force_bind, a.apply_rela_id, a.pause
          from scmdata.sys_group_apply g, scmdata.sys_group_apply_rela a
         where g.apply_id = a.apply_id
           and a.rela_apply_id = p_apply_id)
      select c.rela_apply_id, c.apply_rela_id, ga.pause, ga.apply_status
        from scmdata.sys_group_apply ga, c
       where ga.apply_id = c.rela_apply_id;
  BEGIN
    select g.apply_status, g.pause
      into v_status, v_pause
      from scmdata.sys_group_apply g
     where g.apply_id = p_apply_id;
  
    if p_apply_status <> v_status then
      if v_pause = 1 then
        raise pause_exp;
      else
        update scmdata.sys_group_apply g
           set g.apply_status = p_apply_status
         where g.apply_id = p_apply_id;
        --add by czh
        --绑定在该应用下的所有应用，与之的应用关系，随着应用的启停，上下架，应用关系跟着变
        if v_pause = 0 and p_apply_status = 0 then
          --上游关联应用
          for up_role_rec in group_apply_role_up_datas loop
            update scmdata.sys_group_apply_rela ga
               set ga.pause = 0
             where ga.apply_rela_id = up_role_rec.apply_rela_id;
          end loop;
          --下游关联应用
          for role_rec in group_apply_role_datas loop
            --增加判断条件  启用:需要判断其关联应用的应用是停用还是启用的,停用则不做操作        
            if role_rec.pause = 0 and role_rec.apply_status = 0 then
              --更新应用所绑定的应用关系为启用
              update scmdata.sys_group_apply_rela ga
                 set ga.pause = 0
               where ga.apply_rela_id = role_rec.apply_rela_id;
            else
              update scmdata.sys_group_apply_rela ga
                 set ga.pause = 1
               where ga.apply_rela_id = role_rec.apply_rela_id;
            end if;
          end loop;
        else
          --下游关联应用
          for role_rec in group_apply_role_datas loop
            update scmdata.sys_group_apply_rela ga
               set ga.pause = 1
             where ga.apply_rela_id = role_rec.apply_rela_id;
          end loop;
          --上游关联应用
          for up_role_rec in group_apply_role_up_datas loop
            update scmdata.sys_group_apply_rela ga
               set ga.pause = 1
             where ga.apply_rela_id = up_role_rec.apply_rela_id;
          end loop;
        end if;
      
      end if;
    
    else
      --操作重复报提示信息
      raise apply_exp;
    end if;
  exception
    when apply_exp then
      x_err_msg := '不可重复操作！！';
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    when pause_exp then
      x_err_msg := '该应用已停用，不可进行上下架操作！！';
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    
    when others then
      SYS_RAISE_APP_ERROR_PKG.IS_RUNNING_ERROR(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
  END update_apply_status;

end sf_group_apply_pkg;
/

