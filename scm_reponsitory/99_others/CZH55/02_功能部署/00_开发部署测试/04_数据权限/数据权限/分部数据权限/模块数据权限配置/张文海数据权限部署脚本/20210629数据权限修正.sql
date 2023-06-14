declare
P_select_sql clob:='--优化后
WITH group_dict AS
 (SELECT * FROM scmdata.sys_group_dict),
company_dict AS
 (SELECT * FROM scmdata.sys_company_dict t),
company_user AS
 (SELECT company_id, user_id, company_user_name FROM sys_company_user)
SELECT tc.commodity_info_id,
       tc.company_id,
      
       tc.rela_goo_id,
       tc.goo_id,
       tc.sup_style_number,
       tc.style_number,
       tc.style_name,
       gd1.group_dict_name      category_gd,
       gd2.group_dict_name      product_cate_gd,
       cd.company_dict_name     small_category_gd,
      -- tc.supplier_code         supplier_code_gd,
       sp.supplier_company_name sup_name_gd,
       tc.goo_name,
       tc.year,
       tc.season,
       --gd3.group_dict_name      year_gd,
       gd4.group_dict_name season_gd,
       tc.inprice,
       tc.price price_gd,
        gd.group_dict_name       origin,
       tc.create_time,
       nvl((SELECT a.company_user_name
             FROM company_user a
            WHERE a.company_id = tc.company_id
              AND a.user_id = tc.create_id),
           tc.create_id) create_id,
       tc.update_time,
       nvl((SELECT b.company_user_name
             FROM company_user b
            WHERE b.company_id = tc.company_id
              AND b.user_id = tc.update_id),
           tc.create_id) update_id
  FROM scmdata.t_commodity_info tc
 INNER JOIN scmdata.t_supplier_info sp
    ON tc.supplier_code = sp.supplier_code
   AND tc.company_id = sp.company_id
 INNER JOIN group_dict gd
    ON gd.group_dict_type = ''ORIGIN_TYPE''
   AND tc.origin = gd.group_dict_value
 INNER JOIN group_dict gd1
    ON gd1.group_dict_type = ''PRODUCT_TYPE''
   AND gd1.group_dict_value = tc.category
 INNER JOIN group_dict gd2
    ON gd2.group_dict_type = gd1.group_dict_value
   AND gd2.group_dict_value = tc.product_cate
 INNER JOIN company_dict cd
    ON cd.company_dict_type = gd2.group_dict_value
   AND cd.company_dict_value = tc.samll_category
   AND cd.company_id = %default_company_id%
/* INNER JOIN group_dict gd3
 ON gd3.group_dict_type = ''GD_YEAR''
AND gd3.group_dict_value = tc.year*/
 INNER JOIN group_dict gd4
    ON gd4.group_dict_type = ''GD_SESON''
   AND gd4.group_dict_value = tc.season
 WHERE tc.company_id = %default_company_id%
  AND tc.pause = 0
 AND (%is_company_admin%=1  or instr(%coop_class_priv%,tc.category)>0 )
 ORDER BY tc.create_time DESC';
begin
update bw3.sys_item_list a set a.select_sql=P_select_sql where  a.item_id='a_good_110';
end;
/
declare
P_select_sql clob:='with data_pri as
 (select listagg(distinct cooperation_classification, '';'') within GROUP(ORDER BY cooperation_classification asc) category,
         object_id factory_ask_id
    from scmdata.t_ask_scope
   where  object_type = ''CA''
   group by object_id),
    data_ability as
 (select listagg(distinct cooperation_classification, '';'') within GROUP(ORDER BY cooperation_classification asc) category,
         factory_report_id
    from scmdata.t_factory_report_ability
     group by factory_report_id))
   select a.factory_ask_id,
       a.factrory_ask_flow_status,
       substr(fals.group_dict_name,0,instr(fals.group_dict_name,''+'')-1) FLOW_NODE_NAME,
       substr(fals.group_dict_name,instr(fals.group_dict_name,''+'')+1,length(fals.group_dict_name)) FLOW_NODE_STATUS_DESC,
       a.factory_ask_type,
       decode(a.factory_ask_type, 0, ''验厂申请'', ''验厂报告'') factory_ask_report_detail,
       case
         when a.origin = ''CA'' then
          (select company_id
             from t_ask_record
            where ask_record_id = a.ask_record_id)
         else
          a.cooperation_company_id
       end company_id,
       a.company_name ASK_COMPANY_NAME,
       ga.group_dict_name cooperation_type_sp,
       case
         when a.factory_ask_type = 0 then
          (SELECT listagg(group_dict_name, '';'') within GROUP(ORDER BY 1)
             FROM sys_group_dict
            WHERE group_dict_type = ''PRODUCT_TYPE''
              AND group_dict_value in
                  (select distinct cooperation_classification
                     from scmdata.t_ask_scope
                    where object_id = a.factory_ask_id
                      and object_type = ''CA''))
         else
          (SELECT listagg(distinct t.group_dict_name, '';'') within GROUP(ORDER BY 1)
             FROM scmdata.t_factory_report_ability fra
             left join scmdata.sys_group_dict t
               on t.group_dict_value = fra.cooperation_classification
              AND t.group_dict_type = a.cooperation_type
            where fra.factory_report_id = fr.factory_report_id)
       end cooperation_classification_sp,
       gd.group_dict_name cooperation_model_sp,
        decode(a.factory_ask_type, 0, ''不验厂'', 1, ''内部验厂'', ''第三方验厂'') factory_ask_type_desc,
		a.remarks,
       case
         when a.factory_ask_type <> 0 then
          fr.check_result
         else
          null
       end check_result,
      
       a.ask_date FACTORY_ASK_DATE,
       case
         when a.factory_ask_type <> 0 then
          fr.check_date
         else
          null
       end check_date
  from t_factory_ask a
  inner join data_pri c
    on c.factory_ask_id=a.factory_ask_id
  left join (select max(ol.oper_time) audit_time, ol.factory_ask_id
               from t_factory_ask_oper_log ol
              where ol.status_AF_OPER = ''FA12''
              group by ol.factory_ask_id) k
    on k.factory_ask_id = a.factory_ask_id
  left join t_factory_report fr
    on a.factory_ask_id = fr.factory_ask_id
    left join data_ability frc
    on frc.factory_report_id = fr.factory_report_id
  left join sys_group_dict ga
    on a.cooperation_type = ga.group_dict_value
   and ga.group_dict_type = ''COOPERATION_TYPE''
  left join sys_group_dict gd
    on a.cooperation_model = gd.group_dict_value
   and gd.group_dict_type = ''SUPPLY_TYPE''
  left join sys_group_dict fals
    on a.factrory_ask_flow_status = fals.group_dict_value
   and fals.group_dict_type = ''FACTORY_ASK_FLOW''
 where a.factrory_ask_flow_status in (''FA12'', ''FA31'')
   and a.company_id = %default_company_id%
    AND (%is_company_admin% = 1 or
       instr_priv(%coop_class_priv%, c.category) > 0 or
       instr_priv(%coop_class_priv%, frc.category) > 0)
 order by k.audit_time asc';
begin
update bw3.sys_item_list a set a.select_sql=P_select_sql where  a.item_id='a_coop_310';
end;
/
declare
P_select_sql clob:='with data_pri as
 (select listagg(distinct cooperation_classification, '';'') within GROUP(ORDER BY cooperation_classification asc) category,
         object_id factory_ask_id
    from scmdata.t_ask_scope
   where  object_type = ''CA''
   group by object_id),
    data_ability as
 (select listagg(distinct cooperation_classification, '';'') within GROUP(ORDER BY cooperation_classification asc) category,
         factory_report_id
    from scmdata.t_factory_report_ability
    group by factory_report_id)
select a.factory_ask_id,
       a.factrory_ask_flow_status,
       a.factory_ask_type,
       substr(fals.group_dict_name, 0, instr(fals.group_dict_name, ''+'') - 1) FLOW_NODE_NAME,
       substr(fals.group_dict_name,
              instr(fals.group_dict_name, ''+'') + 1,
              length(fals.group_dict_name)) FLOW_NODE_STATUS_DESC,
       decode(a.factory_ask_type, 0, ''验厂申请'', ''验厂报告'') factory_ask_report_detail,
       case
         when a.origin = ''CA'' then
          (select company_id
             from t_ask_record
            where ask_record_id = a.ask_record_id)
         else
          a.cooperation_company_id
       end company_id,
       a.company_name ASK_COMPANY_NAME,
       ga.group_dict_name cooperation_type_sp,
       case
         when a.factory_ask_type = 0 then
          (SELECT listagg(group_dict_name, '','') within GROUP(ORDER BY 1)
             FROM sys_group_dict
            WHERE group_dict_type = ''PRODUCT_TYPE''
              AND group_dict_value in
                  (select distinct cooperation_classification
                     from scmdata.t_ask_scope
                    where object_id = a.factory_ask_id
                      and object_type = ''CA''))
         else
          (SELECT listagg(distinct t.group_dict_name, '','') within GROUP(ORDER BY 1)
             FROM scmdata.t_factory_report_ability fra
             left join scmdata.sys_group_dict t
               on t.group_dict_value = fra.cooperation_classification
              AND t.group_dict_type = a.cooperation_type
            where fra.factory_report_id = fr.factory_report_id)
       end cooperation_classification_sp,
       gd.group_dict_name cooperation_model_sp,
       --加个审核意见
       (select remarks
          from (select remarks
                  from t_factory_ask_oper_log
                 where factory_ask_id = a.factory_ask_id
                   and status_af_oper in (''FA22'', ''FA21'', ''FA32'', ''FA33'')
                 order by oper_time desc)
         where rownum <= 1) audit_comment,
       decode(a.factory_ask_type, 0, ''不验厂'', 1, ''内部验厂'', ''第三方验厂'') factory_ask_type_desc,
	   a.remarks,
       case
         when a.factory_ask_type <> 0 then
          fr.check_result
         else
          null
       end check_result,
       
       a.ask_date FACTORY_ASK_DATE,
       case
         when a.factory_ask_type <> 0 then
          fr.check_date
         else
          null
       end check_date
  from t_factory_ask a
 inner join (select max(ol.oper_time) audit_time, ol.factory_ask_id
               from t_factory_ask_oper_log ol
              where ol.status_AF_OPER in (''FA21'', ''FA22'', ''FA32'', ''FA33'')
              group by ol.factory_ask_id) k
    on k.factory_ask_id = a.factory_ask_id
 inner join data_pri c
    on c.factory_ask_id=a.factory_ask_id
  left join t_factory_report fr
    on a.factory_ask_id = fr.factory_ask_id
 left join data_ability frc
    on frc.factory_report_id = fr.factory_report_id
  left join sys_group_dict ga
    on a.cooperation_type = ga.group_dict_value
   and ga.group_dict_type = ''COOPERATION_TYPE''
  left join sys_group_dict gd
    on a.cooperation_model = gd.group_dict_value
   and gd.group_dict_type = ''SUPPLY_TYPE''
  left join sys_group_dict fals
    on a.factrory_ask_flow_status = fals.group_dict_value
   and fals.group_dict_type = ''FACTORY_ASK_FLOW''
 where a.factrory_ask_flow_status in (''FA22'', ''FA21'', ''FA32'', ''FA33'')
   and a.company_id = %default_company_id%
    AND (%is_company_admin% = 1 or
       instr_priv(%coop_class_priv%, c.category) > 0 or
       instr_priv(%coop_class_priv%, frc.category) > 0)
 order by k.audit_time desc';
begin
update bw3.sys_item_list a set a.select_sql=P_select_sql where  a.item_id='a_coop_320';
end;
/
declare
P_select_sql clob:='with data_pri as
 (select listagg(distinct cooperation_classification, '';'') within GROUP(ORDER BY cooperation_classification) category,
         object_id factory_ask_id
    from scmdata.t_ask_scope
   where  object_type = ''CA''
   group by object_id)
 select a.factory_ask_id,
      -- substr(fals.group_dict_name, 0, instr(fals.group_dict_name, ''+'') - 1) FLOW_NODE_NAME,
       substr(fals.group_dict_name,
              instr(fals.group_dict_name, ''+'') + 1,
              length(fals.group_dict_name)) FLOW_NODE_STATUS_DESC,
       a.company_name ASK_COMPANY_NAME,
       (SELECT listagg(group_dict_name, '';'') within GROUP(ORDER BY 1)
          FROM sys_group_dict
         WHERE group_dict_type = ''PRODUCT_TYPE''
           AND group_dict_value in
               (select distinct cooperation_classification
                  from scmdata.t_ask_scope
                 where object_id = a.factory_ask_id
                   and object_type = ''CA'')) cooperation_classification_desc,
       /* (SELECT listagg(group_dict_name, '';'') within GROUP(ORDER BY 1)
       from (select distinct group_dict_name
               FROM sys_group_dict
              WHERE group_dict_type in
                    (select cooperation_classification
                       from scmdata.t_ask_scope
                      where object_id = a.factory_ask_id
                        and object_type = ''CA'')
                AND group_dict_value in
                    (select cooperation_product_cate
                       from scmdata.t_ask_scope
                      where object_id = a.factory_ask_id
                        and object_type = ''CA''))) cooperation_product_cate_desc,*/
       gd.group_dict_name cooperation_model_desc,
       -- a.COMPANY_ADDRESS, 
       a.FACTORY_NAME,
       a.ASK_ADDRESS,
       cd.dept_name ask_user_dept_name,
       (select company_user_name
          from sys_company_user
         where user_id = a.ask_user_id
           and company_id = %default_company_id%) CHECKAPPLY_PERSON,
       a.ask_date FACTORY_ASK_DATE,
       (SELECT GROUP_DICT_NAME
          FROM sys_group_dict
         WHERE GROUP_DICT_VALUE = a.COOPERATION_TYPE
           AND GROUP_DICT_TYPE = ''COOPERATION_TYPE'') COOPERATION_TYPE_DESC,
       
       case
         when a.origin = ''CA'' then
          (select company_id
             from t_ask_record
            where ask_record_id = a.ask_record_id)
         else
          a.cooperation_company_id
       end company_id
  from t_factory_ask a
  inner join data_pri c
    on c.factory_ask_id=a.factory_ask_id
  left join sys_user u
    on a.ask_user_id = u.user_id
  left join sys_company_dept cd
    on a.ask_user_dept_id = cd.company_dept_id
  left join t_ask_record b
    on a.ask_record_id = b.ask_record_id
  left join sys_group_dict ga
    on a.cooperation_type = ga.group_dict_value
   and ga.group_dict_type = ''COOPERATION_TYPE''
  left join sys_group_dict gd
    on gd.group_dict_value = a.COOPERATION_MODEL
   and gd.group_dict_type = ''SUPPLY_TYPE''
  left join sys_group_dict fals
    on a.factrory_ask_flow_status = fals.group_dict_value
   and fals.group_dict_type = ''FACTORY_ASK_FLOW''
 where a.company_id = %default_company_id%
   and a.factrory_ask_flow_status = ''FA02''
  AND ( %is_company_admin%=1  or instr_priv(%coop_class_priv%, c.category) > 0)
 order by a.ask_date asc';
begin
update bw3.sys_item_list a set a.select_sql=P_select_sql where  a.item_id='a_coop_220';
end;
/
declare
P_select_sql clob:='with data_pri as
 (select listagg(distinct cooperation_classification, '';'') within GROUP(ORDER BY cooperation_classification asc) category,
         object_id factory_ask_id
    from scmdata.t_ask_scope
   where  object_type = ''CA''
   group by object_id)
select a.factory_ask_id,
       substr(fals.group_dict_name, 0, instr(fals.group_dict_name, ''+'') - 1) FLOW_NODE_NAME,
       substr(fals.group_dict_name,
              instr(fals.group_dict_name, ''+'') + 1,
              length(fals.group_dict_name)) FLOW_NODE_STATUS_DESC,
       a.company_name ASK_COMPANY_NAME,
       (SELECT listagg(group_dict_name, '';'') within GROUP(ORDER BY 1)
          FROM sys_group_dict
         WHERE group_dict_type = ''PRODUCT_TYPE''
           AND group_dict_value in
               (select distinct cooperation_classification
                  from scmdata.t_ask_scope
                 where object_id = a.factory_ask_id
                   and object_type = ''CA'')) cooperation_classification_desc,
       /* (SELECT listagg(group_dict_name, '';'') within GROUP(ORDER BY 1)
       from (select distinct group_dict_name
               FROM sys_group_dict
              WHERE group_dict_type in
                    (select cooperation_classification
                       from scmdata.t_ask_scope
                      where object_id = a.factory_ask_id
                        and object_type = ''CA'')
                AND group_dict_value in
                    (select cooperation_product_cate
                       from scmdata.t_ask_scope
                      where object_id = a.factory_ask_id
                        and object_type = ''CA''))) cooperation_product_cate_desc,*/
       gd.group_dict_name cooperation_model_desc,
       -- a.COMPANY_ADDRESS, 
       a.FACTORY_NAME,
       a.ASK_ADDRESS,
       
       cd.dept_name ask_user_dept_name,
       (select company_user_name
          from sys_company_user
         where user_id = a.ask_user_id
           and company_id = %default_company_id%) CHECKAPPLY_PERSON,
       a.ask_date FACTORY_ASK_DATE,
       (SELECT GROUP_DICT_NAME
          FROM sys_group_dict
         WHERE GROUP_DICT_VALUE = a.COOPERATION_TYPE
           AND GROUP_DICT_TYPE = ''COOPERATION_TYPE'') COOPERATION_TYPE_DESC,
       
       case
         when a.origin = ''CA'' then
          (select company_id
             from t_ask_record
            where ask_record_id = a.ask_record_id)
         else
          a.cooperation_company_id
       end company_id,
       
       --   a.contact_name,
       -- a.contact_phone,
       decode(a.factory_ask_type,
              0,
              ''不验厂'',
              1,
              ''内部验厂'',
              2,
              ''第三方验厂'') CHECK_METHOD,
	   a.remarks,
       c2.logn_name CHECK_COMPANY_NAME
  from t_factory_ask a
 inner join (select max(ol.oper_time) audit_time, ol.factory_ask_id
               from t_factory_ask_oper_log ol
              where ol.status_AF_OPER in (''FA03'', ''FA11'', ''FA12'')
                 or (ol.status_AF_OPER = ''FA01'' and ol.oper_code in (''BACK''))
              group by ol.factory_ask_id) k
    on k.factory_ask_id = a.factory_ask_id
    inner join data_pri c
    on c.factory_ask_id=a.factory_ask_id
  left join sys_company c2
    on a.ask_company_id = c2.company_id
   and a.factory_ask_type <> ''0''
  left join sys_user u
    on a.ask_user_id = u.user_id
  left join sys_company_dept cd
    on a.ask_user_dept_id = cd.company_dept_id
  left join t_ask_record b
    on a.ask_record_id = b.ask_record_id
 inner join sys_group_dict ga
    on a.cooperation_type = ga.group_dict_value
   and ga.group_dict_type = ''COOPERATION_TYPE''
 inner join sys_group_dict gd
    on gd.group_dict_value = a.COOPERATION_MODEL
   and gd.group_dict_type = ''SUPPLY_TYPE''
 inner join sys_group_dict fals
    on a.factrory_ask_flow_status = fals.group_dict_value
   and fals.group_dict_type = ''FACTORY_ASK_FLOW''
 where a.company_id = %default_company_id%
   and a.factrory_ask_flow_status like ''FA%''
   and factrory_ask_flow_status <> ''FA02''
  AND ( %is_company_admin%=1  or instr_priv(%coop_class_priv%, c.category) > 0)
 order by k.audit_time desc';
begin
update bw3.sys_item_list a set a.select_sql=P_select_sql where  a.item_id='a_coop_230';
end;
/
declare
p_select_sql clob:='select a.check_request_id,
       g.rela_goo_id,
       g.style_number,
       a.color_list CHECK_COLOR,
       a.check_result,
       a.unqualified_type,
       a.check_report_file_id FABRIC_CHECK_REPORT_FILE,
       a.send_check_amount,
       a.memo,
       
       a.check_date FABRIC_CHECK_DATE,
       a.check_type,
       a.check_company_name FABRIC_CHECK_COMPANY_NAME,
       nvl(FABRIC_CHECK_USER_NAME,u.company_user_name) FABRIC_CHECK_USER_NAME,
       a.ARCHIVES_NUMBER,
       
       a.goo_id,
       gd1.group_dict_name  category_gd,
       gd2.group_dict_name  product_cate_gd,
       cd.company_dict_name small_category_gd,
       
       a.send_check_file_id,
       a.send_check_company_id,
       a.send_check_sup_id,
       nvl(a.SEND_CHECK_SUP_NAME, si.supplier_company_name) SEND_CHECK_SUP_NAME,
       a.check_user_id,
       a.send_check_user_name,
       a.send_check_date,
       a.check_request_code,
       
       (select company_user_name
          from sys_company_user
         where company_id = a.company_id
           and user_id = a.create_id) create_id,
       a.create_time,
       (select company_user_name
          from sys_company_user
         where company_id = a.company_id
           and user_id = a.update_id) update_id,
       a.update_time

  from (select *
          from scmdata.t_check_request
         where company_id = %default_company_id%) a
 inner join scmdata.t_commodity_info g
    on g.goo_id = a.goo_id
   and g.company_id = a.company_id
 INNER JOIN sys_group_dict gd1
    ON gd1.group_dict_type = ''PRODUCT_TYPE''
   AND gd1.group_dict_value = g.category
 INNER JOIN sys_group_dict gd2
    ON gd2.group_dict_type = gd1.group_dict_value
   AND gd2.group_dict_value = g.product_cate
 INNER JOIN sys_company_dict cd
    ON cd.company_dict_type = gd2.group_dict_value
   AND cd.company_dict_value = g.samll_category
   AND cd.company_id = %default_company_id%
 inner join scmdata.sys_company_user u
    on u.user_id = a.check_user_id
   and u.company_id = a.company_id
  left join scmdata.t_supplier_info si
    on si.supplier_info_id = a.send_check_sup_id
   and si.company_id = a.company_id
  WHERE  (%is_company_admin%=1  or  instr(%coop_class_priv%,g.category)>0)
 order by a.create_time desc';
begin
update bw3.sys_item_list a set a.select_sql =p_select_sql where a.item_id='a_fabric_110';
end;
/
declare
p_select_sql clob:='WITH group_dict AS
 (SELECT gd.group_dict_value, gd.group_dict_type, gd.group_dict_name
    FROM scmdata.sys_group_dict gd),
company_dict AS
 (SELECT cd.company_dict_value,
         cd.company_dict_type,
         cd.company_dict_name,
         cd.company_id,
         cd.pause
    FROM scmdata.sys_company_dict cd),
company_user AS
 (SELECT company_id, user_id, company_user_name
    FROM scmdata.sys_company_user)
select *
  from (SELECT k.fabric_evaluate_id,
               tc.commodity_info_id,
               tc.rela_goo_id,
               sp.supplier_company_name sup_name_gd,
               tc.style_number,
               tc.style_name,
               k.risk_level,
               k.evaluate_result,
               k.memo,
               (select listagg(distinct cs.colorname, '';'') within group(order by 1)
                  from scmdata.t_ordersitem oi
                 inner join scmdata.t_commodity_color_size cs
                    on cs.barcode = oi.barcode
                   and cs.company_id = oi.company_id
                 where oi.goo_id = k.goo_id
                   and oi.company_id = k.company_id) order_color_name,
               
               (select listagg(distinct y, ''，'') within group(order by 1)
                  from (SELECT REGEXP_SUBSTR(w.l, ''[^，]+'', 1, LEVEL, ''i'') y
                          FROM (select listagg(distinct cr.color_list, ''，'') within group(order by 1) l
                                  from scmdata.t_check_request cr
                                 where cr.goo_id = k.goo_id
                                   and cr.company_id = k.company_id) w
                        CONNECT BY LEVEL <=
                                   LENGTH(w.l) -
                                   LENGTH(REGEXP_REPLACE(w.l, ''，'', '''')) + 1)) checked_color_name,
               (select max(check_date)
                  from scmdata.t_check_request
                 where goo_id = tc.goo_id
                   and company_id = tc.company_id) last_fabric_check_time,
               k.evaluate_id,
               k.evaluate_time,
               
               tc.company_id,
               
               tc.goo_id,
               
               gd1.group_dict_name  category_gd,
               gd2.group_dict_name  product_cate_gd,
               cd.company_dict_name small_category_gd,
               
               nvl((select company_user_name
                     from company_user a
                    where a.company_id = tc.company_id
                      AND a.user_id = tc.create_id),
                   tc.create_id) RECORD_CREATE_USER,
               tc.create_time RECORD_CREATE_TIME,
               tc.supplier_code supplier_code_gd,
               tc.sup_style_number,
               k.create_time
          FROM (select *
                  from scmdata.t_fabric_evaluate
                 where company_id = %default_company_id%) k
         inner join scmdata.t_commodity_info tc
            on tc.company_id = k.company_id
           and tc.goo_id = k.goo_id
         INNER JOIN scmdata.t_supplier_info sp
            ON tc.supplier_code = sp.supplier_code
           AND tc.company_id = sp.company_id
         INNER JOIN group_dict gd1
            ON gd1.group_dict_type = ''PRODUCT_TYPE''
           AND tc.category = gd1.group_dict_value
         INNER JOIN group_dict gd2
            ON gd2.group_dict_type = gd1.group_dict_value
           AND tc.product_cate = gd2.group_dict_value
         INNER JOIN company_dict cd
            ON tc.samll_category = cd.company_dict_value
           and cd.company_id = tc.company_id
        WHERE  (%is_company_admin%=1 or  instr(%coop_class_priv%,tc.category)>0))
 order by last_fabric_check_time desc';
begin
update bw3.sys_item_list a set a.select_sql =p_select_sql where a.item_id='a_fabric_120';
end;
/
declare
p_select_sql clob:='with pass_dict as
 (select group_dict_name, group_dict_value
    from scmdata.sys_group_dict
   where group_dict_type = ''NORMAL_QUALIFIED'')
select a.qc_goo_collect_id,
       ci.rela_goo_id,
       ci.style_number,
       ci.style_name,
       si.supplier_company_name supplier,
       a.approve_result,
       a.fabric_check,
       /*(select gd1.group_dict_name
          from scmdata.sys_group_dict gd1
         where gd1.group_dict_type = ''PRODUCT_TYPE''
           AND gd1.group_dict_value = ci.category) category,*/

       --  a.pre_meeting_record,
       a.PRE_MEETING_TIME,
       a.wash_test_result,
       a.first_check_result,
       a.first_check_sum || ''/'' || a.order_count || '' '' ||
       (select group_dict_name
          from pass_dict
         where group_dict_value = a.first_check_result) FIRST_QC_CHECK_LINE,
       a.middle_check_result,
       a.middle_check_sum || ''/'' || a.order_count || '' '' ||
       (select group_dict_name
          from pass_dict
         where group_dict_value = a.middle_check_result) MIDDLE_QC_CHECK_LINE,
       a.final_check_result,
       a.final_check_sum || ''/'' || a.order_count || '' '' ||
       (select group_dict_name
          from pass_dict
         where group_dict_value = a.final_check_result) FINAL_QC_CHECK_LINE,
       -- a.order_count,
       (select sum(os.order_amount)
          from scmdata.t_orders os
         inner join scmdata.t_ordered oe
            on os.order_id = oe.order_code
           and os.company_id = oe.company_id
         where os.goo_id = a.goo_id
           and os.company_id = a.company_id
           and oe.supplier_code = a.supplier_code) ORDER_AMOUNT_SUM,
       a.memo,
       (select company_user_name
          from scmdata.sys_company_user
         where user_id = a.update_id
           and company_id = a.company_id) update_id,
       a.update_time,
       a.goo_id
  from scmdata.t_qc_goo_collect a
 inner join scmdata.t_commodity_info ci
    on ci.goo_id = a.goo_id
   and ci.company_id = a.company_id
 inner join scmdata.t_supplier_info si
    on si.supplier_code = a.supplier_code
   and a.company_id = si.company_id
 where a.company_id = %default_company_id%
  and  (%is_company_admin%=1 or instr(%coop_class_priv%,ci.category)>0)
  order by a.create_time desc';
begin
update bw3.sys_item_list a set a.select_sql =p_select_sql where a.item_id='a_qcqa_131';
end;
/
