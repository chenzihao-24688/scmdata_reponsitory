create or replace package scmdata.pkg_mrp_inf is

  -- Author  : SANFU
  -- Created : 2022/5/17 16:35:54
  -- Purpose : 面辅料系统对接

  --示例
  procedure p_dict_change(p_category    varchar2,
                          p_subcategory varchar2,
                          pause        number);

end pkg_mrp_inf;
/

create or replace package body scmdata.pkg_mrp_inf is

  procedure p_dict_change(p_category    varchar2,
                          p_subcategory varchar2,
                          pause         number) is
  begin
    null;
    --面辅料管系统的代码
  end p_dict_change;

end pkg_mrp_inf;
/

