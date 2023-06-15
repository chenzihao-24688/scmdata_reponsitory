create or replace package scmdata.pkg_personal is

  -- Author  : ZWH73
  -- Created : 2020/7/4 16:07:29
  -- Purpose : 个人中心管理
  
  --获取平台展示的用户姓名，有默认企业，显示企业下的姓名，没有则取sys_user.nick_name
    function F_show_username(pi_user_id varchar2) return varchar2;
  --获取用户在某个企业的用户名，显示企业下的姓名，没有定义则取sys_user.nick_name
    function F_show_username_by_company(pi_user_id varchar2,pi_company_id varchar2) return varchar2;
    
    --根据正则表达式验证输入
    function F_check_nick_name(pi_nick_name varchar2) return number;
    function F_check_phone(pi_phone varchar2) return number;
    function F_check_email(pi_email varchar2) return number;
    function F_check_id_card(pi_id_card varchar2) return number;
    --加密部分手机号显示
    function F_show_phone(pi_phone varchar2) return varchar2;
    --加密部分邮箱号显示
    function F_show_email(p_i_email varchar2) return varchar2;
    
    
    --暂时停用中
    PROCEDURE P_check_city(pio_county in out varchar2,pio_city in out varchar2,pio_province in out varchar2);
end pkg_personal;
/

create or replace package body scmdata.pkg_personal is
  /* createtime: 2020-7-4
     author: ZWH73
     memo:个人中心管理
  */
  --获取平台展示的用户姓名，有默认企业，显示企业下的姓名，没有则取sys_user.nick_name
  function F_show_username(pi_user_id varchar2) return varchar2 is
    p_ls varchar2(50);
  begin
    select nvl(max(b.COMPANY_USER_NAME), max(a.nick_name))
      into p_ls
      from sys_user a
      left join sys_user_company c
        on a.user_id = c.user_id
       and c.is_default = 1
      left join sys_company_user b
        on c.user_id = b.user_id
       and c.company_id = b.company_id
     where a.user_id = pi_user_id;
    return p_ls;
  end F_show_username;

  function F_show_username_by_company(pi_user_id    varchar2,
                                      pi_company_id varchar2) return varchar2 is
    p_ls varchar2(50);
  begin
    select nvl(max(b.COMPANY_USER_NAME), max(a.nick_name))
      into p_ls
      from sys_user a
      left join sys_company_user b
        on a.user_id = b.user_id
        and b.company_id = pi_company_id
     where a.user_id = pi_user_id;
    return p_ls;
  end F_show_username_by_company;

  --判断nick_name是否符合规范
  function F_check_nick_name(pi_nick_name varchar2) return number is
    p_result number(1);
  begin
    p_result := 0;
    if length(pi_nick_name) > 7 then
      p_result := 1;
    else
      select nvl(max(1),0)
        into p_result
        from dual
       where regexp_like(pi_nick_name,
                         '[`~!@#$%^&*()--+={' || '}[' || ']|\:;"''>' ||
                         chr(63) || '<,./]');
    end if;
    return p_result;
  end F_check_nick_name;

  --判断手机号是否符合规范
  function F_check_phone(pi_phone varchar2) return number is
    p_result number(1);
  begin
    p_result := 0;
    select  nvl(max(1),0)
      into p_result
      from dual
     where regexp_like(pi_phone,
                       '^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$');
    return p_result;
  end F_check_phone;

  --判断email是否符合规范
  function F_check_email(pi_email varchar2) return number is
    p_result number(1);
  begin
    p_result := 0;
    select  nvl(max(1),0)
      into p_result
      from dual
     where regexp_like(pi_email,
                       '^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$');
    
    return p_result;
  end F_check_email;
  --判断idcard是否符合规范
  function F_check_id_card(pi_id_card varchar2) return number is
    p_result number(1);
  begin
    p_result := 0;
    select  nvl(max(1),0)
      into p_result
      from dual
     where regexp_like(pi_id_card,
                       '(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)');
    --select max(1) into p_i from dual where regexp_like(pi_id_card,'^[0-9]{18}$');
    return p_result;
  end F_check_id_card;

  --加密部分手机号显示
  function F_show_phone(pi_phone varchar2) return varchar2 is
    p_result varchar2(20);
  begin
    select REPLACE(pi_phone, SUBSTR(pi_phone, 4, 4), '****')
      into p_result
      from dual;
    return p_result;
  end F_show_phone;

  --加密部分邮箱号显示
  function F_show_email(p_i_email varchar2) return varchar2 is
    p_result varchar2(100);
  begin
    select regexp_replace(p_i_email, '^.*@', '******')
      into p_result
      from dual;
    return p_result;
  end F_show_email;

  PROCEDURE P_check_city(pio_county   in out varchar2,
                         pio_city     in out varchar2,
                         pio_province in out varchar2) is
    p_province_id varchar2(30);
    p_city_id     varchar2(30);
    p_i           int;
  begin
    --获取province找不到抛error
    select max(1)
      into p_i
      from dic_province a
     where a.province = pio_province
        or a.jdprovince = pio_province;
    if p_i = 1 then
      select a.provinceid
        into p_province_id
        from dic_province a
       where a.province = pio_province
          or a.jdprovince = pio_province;
      select a.province
        into pio_province
        from dic_province a
       where a.provinceid = p_province_id;
    end if;
  
    --获取city且是county下，找不到置空
    select max(1)
      into p_i
      from dic_city a
     where (a.city = pio_city or pio_city = a.jdcity)
       and p_province_id = a.provinceid;
    if p_i = 1 then
      select a.cityno
        into p_city_id
        from dic_city a
       where (a.city = pio_city or pio_city = a.jdcity)
         and p_province_id = a.provinceid;
      select a.city
        into pio_city
        from dic_city a
       where a.cityno = p_city_id;
    end if;
  
    --获取pio_county且是city下
    select max(1)
      into p_i
      from dic_county a
     where a.county = pio_county
       and p_city_id = a.cityno;
    if p_i = 1 then
      select a.county
        into pio_county
        from dic_county a
       where a.county = pio_county 
         and p_city_id = a.cityno;
    end if;
  
  end P_check_city;

end pkg_personal;
/

