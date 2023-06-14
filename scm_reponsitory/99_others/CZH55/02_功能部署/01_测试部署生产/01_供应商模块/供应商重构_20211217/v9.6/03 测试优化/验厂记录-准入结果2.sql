begin
 update bw3.sys_item_list t set t.noshow_fields = 'factory_ask_id,company_id,supplier_info_origin_id,TRIALORDER_TYPE,CHECK_FAC_RESULT' where t.item_id in ('a_supp_151_2','a_supp_161_2','a_supp_171_2'); 
end;
/
declare
v_sql clob;
begin
  v_sql := q'[WITH company_user AS
 (SELECT t.company_user_name, t.user_id, t.company_id
    FROM scmdata.sys_company_user t
   WHERE t.company_id = %default_company_id%)
SELECT *
  FROM (SELECT fa.factory_ask_id,
               fa.company_id,
               fa.ask_date factory_ask_date,
               a.company_user_name check_apply_username,
               nvl(fr.check_date, '') check_date,
               b.company_user_name || CASE
                 WHEN c.company_user_name IS NULL THEN
                  ''
                 ELSE
                  ';' || c.company_user_name
               END check_person,
               fr.check_result check_fac_result,
               '验厂报告详情' CHECK_REPORT,
               NVL(fr.admit_result,0) TRIALORDER_TYPE,
               fa.factory_ask_id supplier_info_origin_id
          FROM scmdata.t_factory_ask fa
         INNER JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN company_user a
            ON a.user_id = fa.ask_user_id
           AND a.company_id = fa.company_id
          LEFT JOIN company_user b
            ON b.user_id = fr.check_person1
           AND b.company_id = fr.company_id
          LEFT JOIN company_user c
            ON c.user_id = fr.check_person2
           AND c.company_id = fr.company_id) v
 WHERE v.supplier_info_origin_id IN
       (SELECT sa.supplier_info_origin_id
          FROM scmdata.t_supplier_info sa
         WHERE sa.supplier_info_id = :supplier_info_id)
   AND v.company_id = %default_company_id%]';
   
  update bw3.sys_item_list t set t.select_sql = v_sql where t.item_id in ('a_supp_151_2','a_supp_161_2','a_supp_171_2'); 
end;
