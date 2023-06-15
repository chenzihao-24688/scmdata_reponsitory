create or replace package scmdata.PKG_USER_DEFAULT_COMPANY is

  -- Author  : zwh73
  -- Created : 2020/7/31 18:12:43
  -- Purpose : 默认企业相关操作

  /*
  --判断一个用户有多少个正常所属的企业(sys_comapny_user创建后）
  */
  FUNCTION F_count_user_company(pi_user_id varchar2) return number;
  /*
  --判断一个企业是否是一个用户的默认企业
  --pi_user_id：sys_user的user_id
  --pi_company_id : sys_company 的company_id
  */
  FUNCTION F_is_user_company_default(pi_user_id    varchar2,
                                     pi_company_id varchar2) return number;
  /*
    --一个用户，让该用户的默认企业赋给没有被禁用的企业中排序最高的(所有加入企业禁用时，所有企业的默认解除）
    --pi_user_id：sys_user的user_id
  */
  PROCEDURE P_user_company_default_when_user_change(pi_user_id in varchar2,
                                                    po_result  out number,
                                                    po_msg     out varchar2);
  /*
  --企业被禁用时，修改关联用户的默认企业（用a的方法）。
  --pi_company_id : sys_company 的company_id
  */
  PROCEDURE P_user_company_default_when_company_pause(pi_company_id in varchar2,
                                                      po_result     out number,
                                                      po_msg        out varchar2);

  /*
  --判断用户能否将默认企业赋给某个企业（sys_company_user,sys_company的pause）。
  --pi_user_id：sys_user的user_id
  --pi_company_id : sys_company 的company_id
  */
  FUNCTION F_can_user_company_default(pi_user_id    varchar2,
                                      pi_company_id varchar2) return number;

  /*
  --手动设置某个企业为默认企业的封装过程。
  --pi_user_id：sys_user的user_id
  --pi_company_id : sys_company 的company_id
  */
  PROCEDURE P_user_company_default(pi_user_id    in varchar2,
                                   pi_company_id in varchar2,
                                   po_result     out number,
                                   po_msg        out varchar2);
end PKG_USER_DEFAULT_COMPANY;
/

create or replace package body scmdata.PKG_USER_DEFAULT_COMPANY is

  -- Author  : zwh73
  -- Created : 2020/7/31 18:12:43
  -- Purpose : 默认企业相关操作

  --判断一个用户有多少个正常所属的企业(sys_comapny_user创建后）
  FUNCTION F_count_user_company(pi_user_id varchar2) return number is
    p_count number(18);
  begin
    select count(*)
      into p_count
      from sys_company_user a
      left join sys_company b
        on a.company_id = b.company_id
     where a.user_id = pi_user_id
       and a.pause = 0
       and b.pause = 0;
    return p_count;
  end;

  --判断一个企业是否是一个用户的默认企业
  FUNCTION F_is_user_company_default(pi_user_id    varchar2,
                                     pi_company_id varchar2) return number is
    p_result number(1);
  begin
    p_result := 0;
    select max(1)
      into p_result
      from sys_user_company a
     where user_id = pi_user_id
       and company_id = pi_company_id
       and is_default = 1;
    return p_result;
  end F_is_user_company_default;

  --一个用户，让该用户的默认企业赋给没有被禁用的企业中排序最高的(所有加入企业禁用时，所有企业的默认解除）
  PROCEDURE P_user_company_default_when_user_change(pi_user_id in varchar2,
                                                    po_result  out number,
                                                    po_msg     out varchar2) is
    e_update_user_company exception;
    e_update_compnay_user exception;
    p_tid varchar2(32);
  
  begin
    po_result := 0;
    --获取没有被禁用的企业中排序最高的user_company_id
    select max(tp.user_company_id)
      into p_tid
      from (select a.user_company_id
              from sys_user_company a
              left join sys_company b
                on a.company_id = b.company_id
              left join sys_company_user c
                on a.user_id = c.user_id
               and a.company_id = c.company_id
             where a.user_id = pi_user_id
               and b.pause = 0
               and c.pause = 0
             order by a.sort asc) tp
     where rownum <= 1;
    --将其更新为default
    update sys_user_company
       set is_default = 1
     where user_company_id = p_tid;
    if sql%rowcount <> 1 then
      po_result := -1;
      po_msg    := '更新出错！请联系管理员';
      return;
    end if;
    update sys_user_company
       set is_default = 0
     where user_company_id <> p_tid
       and user_id = pi_user_id;

  
  end P_user_company_default_when_user_change;

  --企业被禁用时，且其部分关联用户将其设置为默认企业时，修改关联用户的默认企业。
  PROCEDURE P_user_company_default_when_company_pause(pi_company_id in varchar2,
                                                      po_result     out number,
                                                      po_msg        out varchar2) as
    cursor cur is(
      select a.user_id
        from sys_company_user a
       where company_id = pi_company_id
         and PKG_USER_DEFAULT_COMPANY.F_is_user_company_default(a.user_id,
                                                                a.company_id) = 1
         and pause = 0);
    p_tid varchar2(32);
  begin
    po_result := 0;
  
    FOR rec IN cur LOOP
      select max(tp.user_company_id)
        into p_tid
        from (select a.user_company_id
                from sys_user_company a
                left join sys_company b
                  on a.company_id = b.company_id
                left join sys_company_user c
                  on a.user_id = c.user_id
                 and a.company_id = c.company_id
               where a.user_id = rec.user_id
                 and b.pause = 0
                 and c.pause = 0
                 and c.company_id <> pi_company_id
               order by a.sort asc) tp
       where rownum <= 1;
      --将其更新为default
      update sys_user_company
         set is_default = 1
       where user_company_id = p_tid;
      if sql%rowcount <> 1 then
        po_result := -1;
        po_msg    := '更新出错！请联系管理员';
        return;
      end if;
      update sys_user_company
         set is_default = 0
       where user_company_id <> p_tid
         and user_id = rec.user_id;
    end LOOP;
  end P_user_company_default_when_company_pause;

  --判断用户能否将默认企业赋给某个企业（sys_company_user,sys_company的pause）。
  FUNCTION F_can_user_company_default(pi_user_id    varchar2,
                                      pi_company_id varchar2) return number is
    p_result number(1);
  begin
    select max(1)
      into p_result
      from sys_user_company a
      left join sys_company b
        on a.company_id = b.company_id
      left join sys_company_user c
        on a.user_id = c.user_id
       and a.company_id = c.company_id
     where a.user_id = pi_user_id
       and a.company_id = pi_company_id
       and b.pause = 0
       and c.pause = 0;
    return p_result;
  end F_can_user_company_default;

  --手动设置某个企业为默认企业的封装过程。
  PROCEDURE P_user_company_default(pi_user_id    in varchar2,
                                   pi_company_id in varchar2,
                                   po_result     out number,
                                   po_msg        out varchar2) is
    p_i number;
  begin
    po_result := 0;
    p_i       := PKG_USER_DEFAULT_COMPANY.F_can_user_company_default(pi_user_id    => pi_user_id,
                                                                     pi_company_id => pi_company_id);
    if p_i is null then
      po_msg    := '不能将该企业设置为默认！';
      po_result := -1;
      return;
    end if;
    update sys_user_company
       set is_default = 1
     where user_id = pi_user_id
       and company_id = pi_company_id;
    if sql%rowcount <> 1 then
      po_result := -2;
      po_msg    := '设置失败！请联系管理员';
      return;
    end if;
    update sys_user_company
       set is_default = 0
     where company_id <> pi_company_id
       and user_id = pi_user_id;
  end P_user_company_default;

end PKG_USER_DEFAULT_COMPANY;
/

