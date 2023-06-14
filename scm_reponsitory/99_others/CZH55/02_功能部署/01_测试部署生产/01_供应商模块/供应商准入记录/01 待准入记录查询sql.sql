SELECT t.supplier_company_abbreviation,
       fa.factory_name,
       v.cooperation_model_desc,
       fa.ask_date                     factory_ask_date,
       cd.dept_name                    ask_user_dept_name,
       su.company_user_name            checkapply_person,
       flg.oper_user_id,
       flg.oper_code,
       flg.oper_time
  FROM scmdata.t_supplier_info t
 INNER JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = t.supplier_info_origin_id
   AND fa.company_id = t.company_id
  LEFT JOIN (SELECT DISTINCT ar.ask_record_id,
                             ar.be_company_id,
                             listagg(gd_a.group_dict_name, ';') over(PARTITION BY ar.ask_record_id) cooperation_model_desc
               FROM scmdata.t_ask_record ar
               LEFT JOIN scmdata.sys_group_dict gd_a
                 ON instr(ar.cooperation_model, gd_a.group_dict_value) > 0
                AND gd_a.group_dict_type = 'SUPPLY_TYPE'
                AND gd_a.pause = 0) v
    ON v.ask_record_id = fa.ask_record_id
   AND v.be_company_id = fa.company_id
  LEFT JOIN sys_company_dept cd
    ON cd.company_dept_id = fa.ask_user_dept_id
  LEFT JOIN scmdata.sys_company_user su
    ON su.user_id = fa.ask_user_id
   AND su.company_id = fa.company_id
  LEFT JOIN scmdata.t_factory_report fr
    ON fr.factory_ask_id = fa.factory_ask_id
   AND fr.company_id = fa.company_id
  LEFT JOIN(WITH fac_log AS (SELECT lg.factory_ask_id,
                                    lg.status_af_oper,
                                    lg.oper_user_id,
                                    lg.oper_code,
                                    row_number() over(PARTITION BY lg.factory_ask_id ORDER BY lg.oper_time ASC) rn,
                                    lg.oper_time,
                                    lg.oper_user_company_id
                               FROM scmdata.t_factory_ask_oper_log lg
                              WHERE lg.oper_user_company_id =
                                    'a972dd1ffe3b3a10e0533c281cac8fd7')
SELECT lb.factory_ask_id,
       lb.status_af_oper,
       lb.oper_code,
       lb.oper_time,
       lb.oper_user_company_id,
       op.nick_name oper_user_id
  FROM (SELECT DISTINCT v.factory_ask_id,
                        nvl(MAX(CASE
                                  WHEN v.status_af_oper = 'FA02' THEN
                                   v.rn
                                END) over(PARTITION BY v.factory_ask_id),
                            -1) max_rn
          FROM fac_log v
        UNION
        SELECT factory_ask_id, rn max_rn
          FROM (SELECT factory_ask_id,
                       rn,
                       row_number() over(PARTITION BY factory_ask_id ORDER BY oper_time ASC) rnn
                  FROM fac_log
                 WHERE status_af_oper = 'FA02')
         WHERE rnn = 2) la
 INNER JOIN fac_log lb
    ON la.factory_ask_id = lb.factory_ask_id
   AND la.max_rn + 1 = lb.rn
 INNER JOIN scmdata.sys_company_user op
    ON op.company_user_id = upper(lb.oper_user_id)
   AND op.company_id = lb.oper_user_company_id) flg ON fa.factory_ask_id = flg.factory_ask_id
 WHERE t.status = 0
   AND t.supplier_info_origin = 'AA'
   AND t.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7';
