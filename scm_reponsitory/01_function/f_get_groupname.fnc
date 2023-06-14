CREATE OR REPLACE FUNCTION SCMDATA.f_get_groupname(f_company_province in varchar2,
                                           f_company_city     in varchar2,
                                           f_category         in varchar2,
                                           f_product_cate     in varchar2,
                                           f_compid             IN VARCHAR2)
  return varchar2 is
  t_p                varchar2(1000);
  t_name             varchar2(128);
  group_id           varchar2(128);
  t_num              number;
  t_id               number;
begin
  select count(1)
    into t_num
    from scmdata.t_supplier_group_area_config t
   where t.pause = 1
     and scmdata.instr_priv(t.province_id, f_company_province) > 0
     and scmdata.instr_priv(t.city_id, f_company_city) > 0
     AND t.company_id=f_compid;
  if t_num > 0 then
    select listagg(t.group_area_config_id, ';') within group(order by t.pause)
      into t_p
      from scmdata.t_supplier_group_area_config t
     where t.pause = 1
       and scmdata.instr_priv(t.province_id,f_company_province) > 0
       and scmdata.instr_priv(t.city_id, f_company_city) > 0
       AND t.company_id=f_compid;
    select count(*)
      into t_id
      from scmdata.t_supplier_group_category_config t
     where t.pause = 1
       and scmdata.instr_priv(t.area_config_id, t_p) > 0
       and t.cooperation_classification = f_category
       and scmdata.instr_priv(t.cooperation_product_cate, f_product_cate) > 0
       AND t.company_id=f_compid;
    if t_id > 0 then
      select t.group_config_id
        into group_id
        from scmdata.t_supplier_group_category_config t
       where t.pause = 1
         and scmdata.instr_priv(t.area_config_id, t_p) > 0
         and t.cooperation_classification = f_category
         and scmdata.instr_priv(t.cooperation_product_cate,f_product_cate) > 0
         AND t.company_id=f_compid;
      select t.group_name
        into t_name
        from scmdata.t_supplier_group_config t
       where t.pause = 1
         and t.group_config_id = group_id
         AND t.company_id=f_compid;
      return t_name;
    else
      return 1;
    end if;
  else
    return 2;
  end if;
end f_get_groupname;
/

