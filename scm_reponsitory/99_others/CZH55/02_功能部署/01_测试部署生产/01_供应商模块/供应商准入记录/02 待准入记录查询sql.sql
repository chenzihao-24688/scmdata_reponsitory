WITH fac_log AS
 (SELECT factory_ask_id,
         status_af_oper,
         oper_user_id,
         oper_code,
         rn,
         MAX(rn) over(PARTITION BY factory_ask_id) max_rn,
         oper_time,
         oper_user_company_id
    FROM (SELECT lg.factory_ask_id,
                 lg.status_af_oper,
                 lg.oper_user_id,
                 lg.oper_code,
                 row_number() over(PARTITION BY lg.factory_ask_id ORDER BY lg.oper_time ASC) rn,
                 lg.oper_time,
                 lg.oper_user_company_id
            FROM scmdata.t_factory_ask_oper_log lg
           WHERE lg.oper_user_company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
             AND lg.factory_ask_id IS NOT NULL)),
dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id,
         pause
    FROM scmdata.sys_group_dict),
sg_log AS
 (SELECT ts.supplier_info_id,
         ts.company_id,
         ts.oper_type,
         MAX(ts.create_time) final_order_aduit_date
    FROM scmdata.t_supplier_info_oper_log ts
   WHERE ts.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
   GROUP BY ts.supplier_info_id, ts.oper_type, ts.company_id)
SELECT fa.factory_ask_id,
       t.supplier_company_abbreviation,
       fa.factory_name,
       v.cooperation_model_desc,
       fa.ask_date factory_ask_date,
       cd.dept_name ask_user_dept_name,
       su.company_user_name checkapply_person,
       va.oper_time fac_apply_date,
       ua.company_user_name fac_apply_person,
       da.group_dict_name fac_apply_result,
       decode(fa.factory_ask_type,
              0,
              '不验厂',
              1,
              '内部验厂',
              2,
              '第三方验厂') check_method,
       fr.check_date,
       ltrim(rtrim(listagg(pa.company_user_name || ';' ||
                           pb.company_user_name)
                   over(PARTITION BY fr.factory_report_id),
                   ';'),
             ';') check_person,
       de.group_dict_name check_result,
       vb.oper_time check_aduit_date,
       ub.company_user_name check_aduit_person,
       db.group_dict_name check_aduit_result,
       fr.factory_result_suggest,
       vc.oper_time admit_aduit_date,
       uc.company_user_name admin_aduit_person,
       dc.group_dict_name admin_aduit_result,
       dh.group_dict_name admit_result,
       og.create_time create_supp_date,
       og.create_id create_supp_person,
       trunc(va.oper_time) - fa.ask_date fac_aprv_dr,
       fr.check_date - trunc(va.oper_time) fac_check_dr,
       trunc(vb.oper_time) - fr.check_date fac_check_aprv_dr,
       trunc(vc.oper_time) - trunc(vb.oper_time) admit_aprv_dr,
       trunc(vc.oper_time) - trunc(va.oper_time) admit_total_aprv_dr,
       decode(fa.is_urgent, 0, '否', 1, '是', NULL) is_urgent,
       fs.supplier_company_name rela_supplier_id,
       dg.group_dict_name product_type,
       ca.coop_class_name cooperation_classification_sp,
       ca.product_cate_name product_cate,
       ca.sub_cate_name,
       dp.province || dc.city || dd.county sup_area,
       pp.province || pc.city || pd.county fac_area,
       t.company_contact_person,
       t.company_contact_phone,
       t.inside_supplier_code,
       decode(t.pause, 0, '正常', 1, '停用', 2, '试单', NULL) pause,
       (CASE
         WHEN t.pause = '2' THEN
          NULL
         WHEN t.pause = '0' THEN
          '试单通过'
         WHEN t.pause = '1' THEN
          '试单不通过'
       END) final_trorder_result,
       decode(t.pause,
              0,
              sg_a.final_order_aduit_date,
              1,
              sg_b.final_order_aduit_date,
              NULL) final_trorder_aduit_date
  FROM scmdata.t_factory_ask fa
  LEFT JOIN scmdata.t_supplier_info fs
    ON fs.supplier_info_id = fa.rela_supplier_id
   AND fs.company_id = fa.company_id
  LEFT JOIN scmdata.t_supplier_info t
    ON t.supplier_info_origin_id = fa.factory_ask_id
   AND t.company_id = fa.company_id
   AND t.supplier_info_origin = 'AA'
  LEFT JOIN dic dh
    ON dh.group_dict_value = t.admit_result
   AND dh.group_dict_type = 'TRIALORDER_TYPE'
  LEFT JOIN dic dg
    ON dg.group_dict_value = t.product_type
   AND dg.group_dict_type = 'FA_PRODUCT_TYPE'
  LEFT JOIN scmdata.t_supplier_info_oper_log og
    ON og.supplier_info_id = t.supplier_info_id
   AND og.company_id = t.company_id
   AND og.oper_type = '创建档案'
  LEFT JOIN sg_log sg_a
    ON sg_a.supplier_info_id = t.supplier_info_id
   AND sg_a.company_id = t.company_id
   AND sg_a.oper_type = '启用'
  LEFT JOIN sg_log sg_b
    ON sg_b.supplier_info_id = t.supplier_info_id
   AND sg_b.company_id = t.company_id
   AND sg_b.oper_type = '停用'
  LEFT JOIN (SELECT sa.company_id,
                    sa.supplier_info_id,
                    listagg(DISTINCT dt.group_dict_name, ';') within GROUP(ORDER BY dt.group_dict_value) coop_class_name,
                    listagg(DISTINCT dy.group_dict_name, ';') within GROUP(ORDER BY dt.group_dict_value, dy.group_dict_value) product_cate_name,
                    listagg(DISTINCT cd.company_dict_name, ';') within GROUP(ORDER BY dy.group_dict_value, cd.company_dict_value) sub_cate_name
               FROM scmdata.t_coop_scope sa
              INNER JOIN dic dt
                 ON dt.group_dict_value = sa.coop_classification
                AND dt.group_dict_type = 'PRODUCT_TYPE'
                AND dt.pause = 0
              INNER JOIN dic dy
                 ON dy.group_dict_value = sa.coop_product_cate
                AND dy.group_dict_type = dt.group_dict_value
              INNER JOIN scmdata.sys_company_dict cd
                 ON cd.company_dict_value = sa.coop_subcategory
                AND cd.company_dict_type = dy.group_dict_value
                AND cd.company_id = sa.company_id
                AND cd.pause = 0
              WHERE sa.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
                AND sa.pause = 0
              GROUP BY sa.supplier_info_id, sa.company_id) ca
    ON ca.supplier_info_id = t.supplier_info_id
   AND ca.company_id = t.company_id
  LEFT JOIN scmdata.dic_province dp
    ON dp.provinceid = t.company_province
  LEFT JOIN scmdata.dic_city dc
    ON dc.cityno = t.company_city
  LEFT JOIN scmdata.dic_county dd
    ON dd.countyid = t.company_county
  LEFT JOIN scmdata.dic_province pp
    ON pp.provinceid = fa.company_province
  LEFT JOIN scmdata.dic_city pc
    ON pc.cityno = fa.company_city
  LEFT JOIN scmdata.dic_county pd
    ON pd.countyid = fa.company_county
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
  LEFT JOIN (SELECT lb.factory_ask_id,
                    lb.oper_user_company_id,
                    lb.oper_code,
                    lb.oper_user_id,
                    lb.oper_time
               FROM fac_log lb
              WHERE (lb.factory_ask_id, lb.oper_user_company_id, lb.rn) IN
                    (SELECT la.factory_ask_id,
                            la.oper_user_company_id,
                            CASE
                              WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                               MAX(la.rn) - 1
                              ELSE
                               MAX(la.rn) + 1
                            END nt_rn
                       FROM fac_log la
                      WHERE la.status_af_oper = 'FA02'
                      GROUP BY la.factory_ask_id, la.oper_user_company_id)) va
    ON va.factory_ask_id = fa.factory_ask_id
   AND va.oper_user_company_id = fa.company_id
  LEFT JOIN scmdata.sys_company_user ua
    ON ua.user_id = va.oper_user_id
   AND ua.company_id = va.oper_user_company_id
  LEFT JOIN dic da
    ON da.group_dict_value = va.oper_code
   AND da.group_dict_type = 'DICT_FLOW_STATUS'
  LEFT JOIN (SELECT lb.factory_ask_id,
                    lb.oper_user_company_id,
                    lb.status_af_oper,
                    lb.oper_code,
                    lb.status_af_oper || ';' || lb.oper_code oper_tp,
                    lb.oper_user_id,
                    lb.oper_time
               FROM fac_log lb
              WHERE (lb.factory_ask_id, lb.oper_user_company_id, lb.rn) IN
                    (SELECT la.factory_ask_id,
                            la.oper_user_company_id,
                            CASE
                              WHEN COUNT(la.status_af_oper) >= 2 THEN
                               CASE
                                 WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                                  MAX(la.rn) - 2
                                 ELSE
                                  MAX(la.rn) + 1
                               END
                              ELSE
                               CASE
                                 WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                                  MAX(la.rn) - 1
                                 ELSE
                                  MAX(la.rn) + 1
                               END
                            END nt_rn
                       FROM fac_log la
                      WHERE status_af_oper = 'FA13'
                      GROUP BY la.factory_ask_id, la.oper_user_company_id)) vb
    ON vb.factory_ask_id = fa.factory_ask_id
   AND vb.oper_user_company_id = fa.company_id
   AND vb.oper_tp <> 'FA11;AGREE'
  LEFT JOIN scmdata.sys_company_user ub
    ON ub.user_id = vb.oper_user_id
   AND ub.company_id = vb.oper_user_company_id
  LEFT JOIN dic db
    ON db.group_dict_value = vb.oper_code
   AND db.group_dict_type = 'DICT_FLOW_STATUS'
  LEFT JOIN (SELECT lb.factory_ask_id,
                    lb.oper_user_company_id,
                    lb.status_af_oper,
                    lb.oper_code,
                    lb.status_af_oper || ';' || lb.oper_code oper_tp,
                    lb.oper_user_id,
                    lb.oper_time
               FROM fac_log lb
              WHERE (lb.factory_ask_id, lb.oper_user_company_id, lb.rn) IN
                    (SELECT la.factory_ask_id,
                            la.oper_user_company_id,
                            CASE
                              WHEN COUNT(la.status_af_oper) >= 2 THEN
                               CASE
                                 WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                                  MAX(la.rn) - 2
                                 ELSE
                                  MAX(la.rn) + 1
                               END
                              ELSE
                               CASE
                                 WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                                  MAX(la.rn) - 1
                                 ELSE
                                  MAX(la.rn) + 1
                               END
                            END nt_rn
                       FROM fac_log la
                      WHERE la.status_af_oper = 'FA12'
                      GROUP BY la.factory_ask_id, la.oper_user_company_id)) vc
    ON vc.factory_ask_id = fa.factory_ask_id
   AND vc.oper_user_company_id = fa.company_id
  LEFT JOIN scmdata.sys_company_user uc
    ON uc.user_id = vc.oper_user_id
   AND uc.company_id = vc.oper_user_company_id
  LEFT JOIN dic dc
    ON dc.group_dict_value = vc.oper_code
   AND dc.group_dict_type = 'DICT_FLOW_STATUS'
  LEFT JOIN sys_company_dept cd
    ON cd.company_dept_id = fa.ask_user_dept_id
  LEFT JOIN scmdata.sys_company_user su
    ON su.user_id = fa.ask_user_id
   AND su.company_id = fa.company_id
  LEFT JOIN scmdata.t_factory_report fr
    ON fr.factory_ask_id = fa.factory_ask_id
   AND fr.company_id = fa.company_id
  LEFT JOIN dic de
    ON de.group_dict_value = fr.check_result
   AND de.group_dict_type = 'CHECK_RESULT'
  LEFT JOIN scmdata.sys_company_user pa
    ON pa.company_id = fr.company_id
   AND pa.user_id = fr.check_person1
  LEFT JOIN scmdata.sys_company_user pb
    ON pb.company_id = fr.company_id
   AND pb.user_id = fr.check_person2
 WHERE fa.company_id = 'a972dd1ffe3b3a10e0533c281cac8fd7'
   AND fa.factory_ask_id = 'CA2204143537114284';
   
/*
WITH fac_log AS
 (SELECT factory_ask_id,
         status_af_oper,
         oper_user_id,
         oper_code,
         rn,
         MAX(rn) over(PARTITION BY factory_ask_id) max_rn,
         oper_time,
         oper_user_company_id
    FROM (SELECT lg.factory_ask_id,
                 lg.status_af_oper,
                 lg.oper_user_id,
                 lg.oper_code,
                 row_number() over(PARTITION BY lg.factory_ask_id ORDER BY lg.oper_time ASC) rn,
                 lg.oper_time,
                 lg.oper_user_company_id
            FROM scmdata.t_factory_ask_oper_log lg
           WHERE lg.oper_user_company_id = %default_company_id%
             AND lg.factory_ask_id IS NOT NULL)),
dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id,
         pause
    FROM scmdata.sys_group_dict),
sg_log AS
 (SELECT ts.supplier_info_id,
         ts.company_id,
         ts.oper_type,
         MAX(ts.create_time) final_order_aduit_date
    FROM scmdata.t_supplier_info_oper_log ts
   WHERE ts.company_id = %default_company_id%
   GROUP BY ts.supplier_info_id, ts.oper_type, ts.company_id)
SELECT fa.factory_ask_id,
       t.supplier_company_abbreviation,
       fa.factory_name,
       v.cooperation_model_desc,
       fa.ask_date factory_ask_date,
       cd.dept_name ask_user_dept_name,
       su.company_user_name checkapply_person,
       va.oper_time fac_apply_date,
       ua.company_user_name fac_apply_person,
       da.group_dict_name fac_apply_result,
       decode(fa.factory_ask_type,
              0,
              '不验厂',
              1,
              '内部验厂',
              2,
              '第三方验厂') check_method,
       fr.check_date,
       ltrim(rtrim(listagg(pa.company_user_name || ';' ||
                           pb.company_user_name)
                   over(PARTITION BY fr.factory_report_id),
                   ';'),
             ';') check_person,
       de.group_dict_name check_result,
       vb.oper_time check_aduit_date,
       ub.company_user_name check_aduit_person,
       db.group_dict_name check_aduit_result,
       fr.factory_result_suggest,
       vc.oper_time admit_aduit_date,
       uc.company_user_name admin_aduit_person,
       dc.group_dict_name admin_aduit_result,
       dh.group_dict_name admit_result,
       og.create_time create_supp_date,
       og.create_id create_supp_person,
       trunc(va.oper_time) - fa.ask_date fac_aprv_dr,
       fr.check_date - trunc(va.oper_time) fac_check_dr,
       trunc(vb.oper_time) - fr.check_date fac_check_aprv_dr,
       trunc(vc.oper_time) - trunc(vb.oper_time) admit_aprv_dr,
       trunc(vc.oper_time) - trunc(va.oper_time) admit_total_aprv_dr,
       decode(fa.is_urgent, 0, '否', 1, '是', NULL) is_urgent,
       fs.supplier_company_name rela_supplier_id,
       dg.group_dict_name product_type,
       ca.coop_class_name cooperation_classification_sp,
       ca.product_cate_name product_cate,
       ca.sub_cate_name,
       dp.province || dc.city || dd.county sup_area,
       pp.province || pc.city || pd.county fac_area,
       t.company_contact_person,
       t.company_contact_phone,
       t.inside_supplier_code,
       decode(t.pause, 0, '正常', 1, '停用', 2, '试单', NULL) pause,
       (CASE
         WHEN t.pause = '2' THEN
          NULL
         WHEN t.pause = '0' THEN
          '试单通过'
         WHEN t.pause = '1' THEN
          '试单不通过'
       END) final_trorder_result,
       decode(t.pause,
              0,
              sg_a.final_order_aduit_date,
              1,
              sg_b.final_order_aduit_date,
              NULL) final_trorder_aduit_date
  FROM scmdata.t_factory_ask fa
  INNER JOIN scmdata.t_supplier_info t
    ON t.supplier_info_origin_id = fa.factory_ask_id
   AND t.company_id = fa.company_id
   AND t.supplier_info_origin = 'AA'
   AND t.status in (0,1) 
  LEFT JOIN scmdata.t_supplier_info fs
    ON fs.supplier_info_id = fa.rela_supplier_id
   AND fs.company_id = fa.company_id
  LEFT JOIN dic dh
    ON dh.group_dict_value = t.admit_result
   AND dh.group_dict_type = 'TRIALORDER_TYPE'
  LEFT JOIN dic dg
    ON dg.group_dict_value = t.product_type
   AND dg.group_dict_type = 'FA_PRODUCT_TYPE'
  LEFT JOIN scmdata.t_supplier_info_oper_log og
    ON og.supplier_info_id = t.supplier_info_id
   AND og.company_id = t.company_id
   AND og.oper_type = '创建档案'
  LEFT JOIN sg_log sg_a
    ON sg_a.supplier_info_id = t.supplier_info_id
   AND sg_a.company_id = t.company_id
   AND sg_a.oper_type = '启用'
  LEFT JOIN sg_log sg_b
    ON sg_b.supplier_info_id = t.supplier_info_id
   AND sg_b.company_id = t.company_id
   AND sg_b.oper_type = '停用'
  LEFT JOIN (SELECT sa.company_id,
                    sa.supplier_info_id,
                    listagg(DISTINCT dt.group_dict_name, ';') within GROUP(ORDER BY dt.group_dict_value) coop_class_name,
                    listagg(DISTINCT dy.group_dict_name, ';') within GROUP(ORDER BY dt.group_dict_value, dy.group_dict_value) product_cate_name,
                    listagg(DISTINCT cd.company_dict_name, ';') within GROUP(ORDER BY dy.group_dict_value, cd.company_dict_value) sub_cate_name
               FROM scmdata.t_coop_scope sa
              INNER JOIN dic dt
                 ON dt.group_dict_value = sa.coop_classification
                AND dt.group_dict_type = 'PRODUCT_TYPE'
                AND dt.pause = 0
              INNER JOIN dic dy
                 ON dy.group_dict_value = sa.coop_product_cate
                AND dy.group_dict_type = dt.group_dict_value
              INNER JOIN scmdata.sys_company_dict cd
                 ON cd.company_dict_value = sa.coop_subcategory
                AND cd.company_dict_type = dy.group_dict_value
                AND cd.company_id = sa.company_id
                AND cd.pause = 0
              WHERE sa.company_id = %default_company_id%
                AND sa.pause = 0
              GROUP BY sa.supplier_info_id, sa.company_id) ca
    ON ca.supplier_info_id = t.supplier_info_id
   AND ca.company_id = t.company_id
  LEFT JOIN scmdata.dic_province dp
    ON dp.provinceid = t.company_province
  LEFT JOIN scmdata.dic_city dc
    ON dc.cityno = t.company_city
  LEFT JOIN scmdata.dic_county dd
    ON dd.countyid = t.company_county
  LEFT JOIN scmdata.dic_province pp
    ON pp.provinceid = fa.company_province
  LEFT JOIN scmdata.dic_city pc
    ON pc.cityno = fa.company_city
  LEFT JOIN scmdata.dic_county pd
    ON pd.countyid = fa.company_county
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
  LEFT JOIN (SELECT lb.factory_ask_id,
                    lb.oper_user_company_id,
                    lb.oper_code,
                    lb.oper_user_id,
                    lb.oper_time
               FROM fac_log lb
              WHERE (lb.factory_ask_id, lb.oper_user_company_id, lb.rn) IN
                    (SELECT la.factory_ask_id,
                            la.oper_user_company_id,
                            CASE
                              WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                               MAX(la.rn) - 1
                              ELSE
                               MAX(la.rn) + 1
                            END nt_rn
                       FROM fac_log la
                      WHERE la.status_af_oper = 'FA02'
                      GROUP BY la.factory_ask_id, la.oper_user_company_id)) va
    ON va.factory_ask_id = fa.factory_ask_id
   AND va.oper_user_company_id = fa.company_id
  LEFT JOIN scmdata.sys_company_user ua
    ON ua.user_id = va.oper_user_id
   AND ua.company_id = va.oper_user_company_id
  LEFT JOIN dic da
    ON da.group_dict_value = va.oper_code
   AND da.group_dict_type = 'DICT_FLOW_STATUS'
  LEFT JOIN (SELECT lb.factory_ask_id,
                    lb.oper_user_company_id,
                    lb.status_af_oper,
                    lb.oper_code,
                    lb.status_af_oper || ';' || lb.oper_code oper_tp,
                    lb.oper_user_id,
                    lb.oper_time
               FROM fac_log lb
              WHERE (lb.factory_ask_id, lb.oper_user_company_id, lb.rn) IN
                    (SELECT la.factory_ask_id,
                            la.oper_user_company_id,
                            CASE
                              WHEN COUNT(la.status_af_oper) >= 2 THEN
                               CASE
                                 WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                                  MAX(la.rn) - 2
                                 ELSE
                                  MAX(la.rn) + 1
                               END
                              ELSE
                               CASE
                                 WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                                  MAX(la.rn) - 1
                                 ELSE
                                  MAX(la.rn) + 1
                               END
                            END nt_rn
                       FROM fac_log la
                      WHERE status_af_oper = 'FA13'
                      GROUP BY la.factory_ask_id, la.oper_user_company_id)) vb
    ON vb.factory_ask_id = fa.factory_ask_id
   AND vb.oper_user_company_id = fa.company_id
   AND vb.oper_tp <> 'FA11;AGREE'
  LEFT JOIN scmdata.sys_company_user ub
    ON ub.user_id = vb.oper_user_id
   AND ub.company_id = vb.oper_user_company_id
  LEFT JOIN dic db
    ON db.group_dict_value = vb.oper_code
   AND db.group_dict_type = 'DICT_FLOW_STATUS'
  LEFT JOIN (SELECT lb.factory_ask_id,
                    lb.oper_user_company_id,
                    lb.status_af_oper,
                    lb.oper_code,
                    lb.status_af_oper || ';' || lb.oper_code oper_tp,
                    lb.oper_user_id,
                    lb.oper_time
               FROM fac_log lb
              WHERE (lb.factory_ask_id, lb.oper_user_company_id, lb.rn) IN
                    (SELECT la.factory_ask_id,
                            la.oper_user_company_id,
                            CASE
                              WHEN COUNT(la.status_af_oper) >= 2 THEN
                               CASE
                                 WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                                  MAX(la.rn) - 2
                                 ELSE
                                  MAX(la.rn) + 1
                               END
                              ELSE
                               CASE
                                 WHEN MAX(la.rn) + 1 > MAX(la.max_rn) THEN
                                  MAX(la.rn) - 1
                                 ELSE
                                  MAX(la.rn) + 1
                               END
                            END nt_rn
                       FROM fac_log la
                      WHERE la.status_af_oper = 'FA12'
                      GROUP BY la.factory_ask_id, la.oper_user_company_id)) vc
    ON vc.factory_ask_id = fa.factory_ask_id
   AND vc.oper_user_company_id = fa.company_id
  LEFT JOIN scmdata.sys_company_user uc
    ON uc.user_id = vc.oper_user_id
   AND uc.company_id = vc.oper_user_company_id
  LEFT JOIN dic dc
    ON dc.group_dict_value = vc.oper_code
   AND dc.group_dict_type = 'DICT_FLOW_STATUS'
  LEFT JOIN sys_company_dept cd
    ON cd.company_dept_id = fa.ask_user_dept_id
  LEFT JOIN scmdata.sys_company_user su
    ON su.user_id = fa.ask_user_id
   AND su.company_id = fa.company_id
  LEFT JOIN scmdata.t_factory_report fr
    ON fr.factory_ask_id = fa.factory_ask_id
   AND fr.company_id = fa.company_id
  LEFT JOIN dic de
    ON de.group_dict_value = fr.check_result
   AND de.group_dict_type = 'CHECK_RESULT'
  LEFT JOIN scmdata.sys_company_user pa
    ON pa.company_id = fr.company_id
   AND pa.user_id = fr.check_person1
  LEFT JOIN scmdata.sys_company_user pb
    ON pb.company_id = fr.company_id
   AND pb.user_id = fr.check_person2
 WHERE fa.company_id = %default_company_id%

*/
