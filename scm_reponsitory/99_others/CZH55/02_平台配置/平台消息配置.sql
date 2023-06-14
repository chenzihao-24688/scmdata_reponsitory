--消息配置  0412 15.43



--合作管理

SELECT '您有' || COUNT(*) || '家供应商准入成功,请前往[供应商管理]=>[待建档供应商]页面进行处理！'
  FROM scmdata.t_supplier_info sp
 WHERE sp.company_id = %default_company_id%
   AND sp.status = 0;

--供应商管理  待建档供应商

SELECT company_name_list || '等企业已通过准入审核，等待供应商建档中'
  FROM (SELECT listagg(a.supplier_company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_supplier_info a
         WHERE a.create_date > SYSDATE - 5 / 60 / 24
           AND a.company_id = %default_company_id%
           AND a.status = 0)
 WHERE company_name_list IS NOT NULL;

--合作管理 准入待审批

SELECT '关于' || company_name_list || '等企业的验厂申请单正在等待准入审核中'
  FROM (SELECT listagg(b.company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_factory_ask_oper_log a
         INNER JOIN scmdata.t_factory_ask b
            ON a.factory_ask_id = b.factory_ask_id
         WHERE a.status_af_oper = 'FA12'
           AND a.oper_time > SYSDATE - 5 / 60 / 24
           AND b.company_id = %default_company_id%)
 WHERE company_name_list IS NOT NULL;
 
 SELECT '您有' || COUNT(1) || '条待准入审批需处理,请及时前往[准入审批]=>[待审批申请]页面进行处理，谢谢！'
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = 'FA12';
 

--验厂管理 待验厂验厂申请提醒

SELECT '关于' || company_name_list || '等企业的验厂申请单正在等待提交验厂报告中'
  FROM (SELECT listagg(b.company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_factory_ask_oper_log a
         INNER JOIN scmdata.t_factory_ask b
            ON a.factory_ask_id = b.factory_ask_id
         WHERE a.status_af_oper = 'FA11'
           AND a.oper_time > SYSDATE - 5 / 60 / 24
           AND b.company_id = %default_company_id%)
 WHERE company_name_list IS NOT NULL;
 
 SELECT '您有' || COUNT(1) '条[待验厂]验厂申请单需处理，请及时前往[验厂管理]=>[待验厂]页面进行处理，谢谢！'
   FROM scmdata.t_factory_ask fa
  WHERE fa.company_id = %default_company_id%
    AND fa.factrory_ask_flow_status = 'FA11';
 

--合作管理 待处理的合作申请
SELECT '关于' || company_name_list || '等企业的合作申请单正在等待申请验厂中'
  FROM (SELECT listagg(a.company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_ask_record a
         WHERE a.ask_date > SYSDATE - 5 / 60 / 24
           AND a.company_id = %default_company_id%
           AND a.coor_ask_flow_status = 'CA01')
 WHERE company_name_list IS NOT NULL;
 
--合作管理 待审核验厂申请提醒
SELECT '关于' || company_name_list || '等企业的验厂申请单正在等待审核中'
  FROM (SELECT listagg(b.company_name, ';') within GROUP(ORDER BY 1) company_name_list
          FROM scmdata.t_factory_ask_oper_log a
         INNER JOIN scmdata.t_factory_ask b
            ON a.factory_ask_id = b.factory_ask_id
         WHERE a.status_af_oper = 'FA02'
           AND a.oper_time > SYSDATE - 5 / 60 / 24
           AND b.company_id = %default_company_id%)
 WHERE company_name_list IS NOT NULL;
 
SELECT '您有' || COUNT(1) '条验厂申请需处理，请及时前往[验厂申请]=>[待审核申请]页面进行处理，谢谢！'
  FROM scmdata.t_factory_ask fa
 WHERE fa.company_id = %default_company_id%
   AND fa.factrory_ask_flow_status = 'FA02';
