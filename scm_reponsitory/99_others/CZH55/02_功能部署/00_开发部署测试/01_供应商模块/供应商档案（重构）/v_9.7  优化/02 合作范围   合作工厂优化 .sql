--合作范围   合作工厂  --czh 重构代码
--czh 重构逻辑
SELECT ROWID, t.*
  FROM nbw.sys_item t
 WHERE t.item_id IN ('a_supp_150',
                     'a_supp_151',
                     'a_supp_161',
                     'a_supp_171',
                     'a_supp_151_1',
                     'a_supp_151_7',
                     'a_supp_161_1',
                     'a_supp_161_7',
                     'a_supp_171_1',
                     'a_supp_171_7');  

SELECT ROWID, t.*
  FROM nbw.sys_item_list t
 WHERE t.item_id IN ('a_supp_150',
                     'a_supp_151',
                     'a_supp_161',
                     'a_supp_171',
                     'a_supp_151_1',
                     'a_supp_151_7',
                     'a_supp_161_1',
                     'a_supp_161_7',
                     'a_supp_171_1',
                     'a_supp_171_7');


--czh 重构逻辑
{DECLARE
  v_sql CLOB;
BEGIN
  v_sql      := pkg_supplier_info.f_insert_coop_factory_list(p_item_id => 'a_supp_151_7'); 
  @strresult := v_sql;
END;}
--原逻辑
/*  coop_factory_id,supplier_info_id,company_id  coop_factory_type,coop_status  COOP_FACTORY_TYPE_DESC  FAC_SUP_INFO_ID
inside_supplier_code,coop_factory_type,coop_status
*/

select * from  scmdata.t_coop_factory
