--乌江榨菜  某人
--SELECT * FROM scmdata.t_factory_ask t WHERE t.company_name = '某人';

SELECT lg.factory_ask_id,
       lg.status_af_oper,
       lg.oper_user_id,
       lg.oper_code,
       row_number() over(PARTITION BY lg.factory_ask_id ORDER BY lg.oper_time ASC) rn,
       lg.oper_time,
       lg.oper_user_company_id
  FROM scmdata.t_factory_ask_oper_log lg
 WHERE lg.oper_user_company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
   AND lg.factory_ask_id IS NOT NULL
   AND lg.factory_ask_id in
       (SELECT t.factory_ask_id
          FROM scmdata.t_factory_ask t
         WHERE t.company_name = '某人');
         
/*select rowid,t.* from scmdata.t_factory_ask_oper_log t 
where t.factory_ask_id = 'CA2204127175553482' */
