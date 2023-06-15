create or replace package scmdata.pkg_qc_view_supp is

  -- Author  : SANFU
  -- Created : 2022/7/12 17:05:46
  -- Purpose : qc品控记录查看通用包

  --生成批版记录sql
  FUNCTION F_GET_APPROVE_VERSION_SQL(V_ID     IN VARCHAR2,
                                     V_COMPID IN VARCHAR2) RETURN CLOB;

  --生成面料检测sql
  FUNCTION F_GET_FABRIC_SQL(V_ID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB;

  --生成产前会sql
  FUNCTION F_GET_QC_PRE_MEETING_SQL(V_ID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB;

  --生成洗水测试sql
  FUNCTION F_GET_QC_WASH_TESTING_SQL(V_ID     IN VARCHAR2,
                                     V_COMPID IN VARCHAR2) RETURN CLOB;

  --生成qc其余检测环节sql
  FUNCTION F_GET_QC_ELSE_SQL(V_ID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB;

  --生成QA检测sql
  FUNCTION F_GET_QA_REPORT_SQL(V_ID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB;

  --获取多重展示页面正确sql
  FUNCTION F_GET_RIGHT_SQL_FOR_MULTI_VIEW(V_ID     IN VARCHAR2,
                                          V_COMPID IN VARCHAR2) RETURN CLOB;

end pkg_qc_view_supp;
/

create or replace package body scmdata.pkg_qc_view_supp is

  --生成批版记录sql
  FUNCTION F_GET_APPROVE_VERSION_SQL(V_ID     IN VARCHAR2,
                                     V_COMPID IN VARCHAR2) RETURN CLOB IS
    V_EXESQL CLOB;
  BEGIN
    V_EXESQL := 'WITH TMP AS
   (SELECT *
      FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT
     WHERE APPROVE_VERSION_ID = ''' || V_ID ||
                '''),
  FILE_TEMP AS
   (SELECT *
      FROM SCMDATA.T_APPROVE_FILE
     WHERE APPROVE_VERSION_ID = ''' || V_ID ||
                '''),
  G_DIC AS
   (SELECT GROUP_DICT_VALUE, GROUP_DICT_NAME, GROUP_DICT_TYPE
      FROM SCMDATA.SYS_GROUP_DICT),
  C_DIC AS
   (SELECT COMPANY_DICT_VALUE,
           COMPANY_DICT_NAME,
           COMPANY_DICT_TYPE,
           COMPANY_ID
      FROM SCMDATA.SYS_COMPANY_DICT)
  SELECT CI.RELA_GOO_ID,
         A.STYLE_CODE,
         CI.STYLE_NAME,
         (SELECT SUPPLIER_COMPANY_NAME
            FROM SCMDATA.T_SUPPLIER_INFO
           WHERE COMPANY_ID = A.COMPANY_ID
             AND SUPPLIER_CODE = CI.SUPPLIER_CODE) SUPPLIER,
         (SELECT GROUP_DICT_NAME
            FROM SCMDATA.SYS_GROUP_DICT
           WHERE GROUP_DICT_VALUE = A.APPROVE_RESULT) APPROVE_RESULT,
         A.APPROVE_NUMBER,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE USER_ID = A.APPROVE_USER_ID
             AND COMPANY_ID = a.company_id) APPROVE_USER,
         A.APPROVE_TIME,
         A.REMARKS,
         ''面辅料'' ASSESS_TYPE_DESC_1,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE COMPANY_ID =
                 (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')
             AND USER_ID =
                 (SELECT ASSESS_USER_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')) MFL_AU,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''EVAL_RESULT''
             AND GROUP_DICT_VALUE =
                 (SELECT ASSESS_RESULT FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')) MFL_AR,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''APPROVE_RISK_WARNING''
             AND GROUP_DICT_VALUE =
                 (SELECT RISK_WARNING FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')) MFL_RW,
         (SELECT COMPANY_DICT_NAME
            FROM C_DIC
           WHERE COMPANY_DICT_TYPE = ''EVAL11''
             AND COMPANY_ID = a.company_id
             AND COMPANY_DICT_VALUE =
                 (SELECT UNQUALIFIED_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL11'')) MFL_US,
         (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL11'') APR_MFL_AS,
         ''印绣花'' ASSESS_TYPE_DESC_2,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE COMPANY_ID =
                 (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')
             AND USER_ID =
                 (SELECT ASSESS_USER_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')) YXH_AU,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''EVAL_RESULT''
             AND GROUP_DICT_VALUE =
                 (SELECT ASSESS_RESULT FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')) YXH_AR,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''APPROVE_RISK_WARNING''
             AND GROUP_DICT_VALUE =
                 (SELECT RISK_WARNING FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')) YXH_RW,
         (SELECT COMPANY_DICT_NAME
            FROM C_DIC
           WHERE COMPANY_DICT_TYPE = ''EVAL12''
             AND COMPANY_ID = a.company_id
             AND COMPANY_DICT_VALUE =
                 (SELECT UNQUALIFIED_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL12'')) YXH_US,
         (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL12'') YXH_AS,
         ''工艺'' ASSESS_TYPE_DESC_3,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE COMPANY_ID =
                 (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')
             AND USER_ID =
                 (SELECT ASSESS_USER_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')) GY_AU,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''EVAL_RESULT''
             AND GROUP_DICT_VALUE =
                 (SELECT ASSESS_RESULT FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')) GY_AR,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''APPROVE_RISK_WARNING''
             AND GROUP_DICT_VALUE =
                 (SELECT RISK_WARNING FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')) GY_RW,
         (SELECT COMPANY_DICT_NAME
            FROM C_DIC
           WHERE COMPANY_DICT_TYPE = ''EVAL13''
             AND COMPANY_ID = a.company_id
             AND COMPANY_DICT_VALUE =
                 (SELECT UNQUALIFIED_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL13'')) GY_US,
         (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL13'') GY_AS,
         ''版型尺寸'' ASSESS_TYPE_DESC_4,
         (SELECT COMPANY_USER_NAME
            FROM SCMDATA.SYS_COMPANY_USER
           WHERE COMPANY_ID =
                 (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')
             AND USER_ID =
                 (SELECT ASSESS_USER_ID FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')) BXCC_AU,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''EVAL_RESULT''
             AND GROUP_DICT_VALUE =
                 (SELECT ASSESS_RESULT FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')) BXCC_AR,
         (SELECT GROUP_DICT_NAME
            FROM G_DIC
           WHERE GROUP_DICT_TYPE = ''APPROVE_RISK_WARNING''
             AND GROUP_DICT_VALUE =
                 (SELECT RISK_WARNING FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')) BXCC_RW,
         (SELECT COMPANY_DICT_NAME
            FROM C_DIC
           WHERE COMPANY_DICT_TYPE = ''EVAL14''
             AND COMPANY_ID = a.company_id
             AND COMPANY_DICT_VALUE =
                 (SELECT UNQUALIFIED_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL14'')) BXCC_US,
         (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = ''EVAL14'') BXCC_AS,
         (SELECT LISTAGG(FILE_ID, '','') FROM FILE_TEMP) FILE_ID_PR
    FROM (SELECT *
            FROM SCMDATA.T_APPROVE_VERSION
           WHERE APPROVE_VERSION_ID = ''' || V_ID ||
                ''') A
   INNER JOIN SCMDATA.T_COMMODITY_INFO CI
      ON CI.GOO_ID = A.GOO_ID
     AND A.COMPANY_ID = CI.COMPANY_ID';
    RETURN V_EXESQL;
  END F_GET_APPROVE_VERSION_SQL;

  --生成面料检测sql
  FUNCTION F_GET_FABRIC_SQL(V_ID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB IS
    V_EXESQL     CLOB;
    v_company_id varchar2(32);
  BEGIN
    V_EXESQL := 'select
 a.goo_id,
 a.send_check_amount,
 a.check_company_name FABRIC_CHECK_COMPANY_NAME,
 g.rela_goo_id,
 nvl(a.SEND_CHECK_SUP_NAME, si.supplier_company_name) SEND_CHECK_SUP_NAME,
 a.check_type,
 g.style_number,
 a.send_check_user_name,
 nvl(u.company_user_name, FABRIC_CHECK_USER_NAME) FABRIC_CHECK_USER_NAME,
 a.color_list,
 a.send_check_date,
 a.check_date FABRIC_CHECK_DATE,
 a.check_result,
 (select listagg(company_dict_name,'';'') from scmdata.sys_company_dict d where instr(a.unqualified_type,d.company_dict_value)>0 and d.company_dict_type=''FABRIC_UNQUALIFY_TYPE_DICT'' and d.company_id=a.company_id) unqualified_type_DESC,
a.UNQUALIFIED_COLOR,
 (select company_dict_name from scmdata.sys_company_dict d where d.company_dict_value=a.check_link and d.company_dict_type=''FABRIC_LINK_DICT'' and d.company_id=a.company_id) CHECK_LINK_DESC,
 a.ARCHIVES_NUMBER,
 a.send_check_file_id,
 a.check_report_file_id FABRIC_CHECK_REPORT_FILE,
 a.memo
  from (select *
          from scmdata.t_check_request
         where CHECK_REQUEST_CODE = ''' || V_ID ||
                ''') a
  inner join scmdata.t_supplier_info s
  on s.supplier_info_id =a.send_check_sup_id
  and s.supplier_company_id=%default_company_id%
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
   AND cd.company_id = a.company_id
 inner join scmdata.sys_company_user u
    on u.user_id = a.check_user_id
   and u.company_id = a.company_id
  left join scmdata.t_supplier_info si
    on si.supplier_info_id = a.send_check_sup_id
   and si.company_id = a.company_id
 order by a.create_time desc';
    RETURN V_EXESQL;
  END F_GET_FABRIC_SQL;

  --生成产前会sql
  FUNCTION F_GET_QC_PRE_MEETING_SQL(V_ID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB IS
    V_EXESQL CLOB;
  BEGIN
    V_EXESQL := 'select
 ci.rela_goo_id,
 ci.style_number,
c.logn_name kehu,
 fi.supplier_company_name PRODUCT_FACTORY,
 a.qc_check_num pre_meeting_NUM,
 a.pre_meeting_time,
 a.IS_FABRIC_BACK,
       a.FABRIC_BACK_DATE,
       a.IS_SUB_FABRIC_BACK,
       a.SUB_FABRIC_BACK_DATE,
       a.IS_CAPACITY_MATCH,
       a.capacity_unq_say,
       a.DELAY_RISK_LEVEL,
       a.delay_risk_say,
 a.pre_meeting_record,
 (select listagg(o.order_id, ''; '') within group(order by 1)
    from scmdata.t_qc_check_rela_order k
   inner join scmdata.t_orders o
      on o.orders_id = k.orders_id
   where k.qc_check_id = a.qc_check_id) rela_order_id,
 a.memo,
 (select company_user_name
    from sys_company_user
   where user_id =  a.finish_qc_id
     and company_id = a.company_id) QC_CHECK_USER,
 a.finish_time submit_time
  from scmdata.t_qc_check a
  inner join scmdata.sys_company c
  on c.company_id=a.company_id
 inner join scmdata.t_commodity_info ci
    on ci.goo_id = a.goo_id
   and a.company_id = ci.company_id
  left join scmdata.t_supplier_info si
    on si.supplier_code = a.supplier_code
   and a.company_id = si.company_id
  left join scmdata.t_supplier_info fi
    on fi.supplier_code = a.factory_code
   and a.company_id = fi.company_id
 where a.qc_check_code = ''' || V_ID || '''
   and si.supplier_company_id = ''' || V_COMPID || '''';
    RETURN V_EXESQL;
  END F_GET_QC_PRE_MEETING_SQL;

  --生成洗水测试sql
  FUNCTION F_GET_QC_WASH_TESTING_SQL(V_ID     IN VARCHAR2,
                                     V_COMPID IN VARCHAR2) RETURN CLOB IS
    V_EXESQL CLOB;
  BEGIN
    V_EXESQL := 'select
 ci.rela_goo_id,
 ci.style_number,
c.logn_name kehu,
 fi.supplier_company_name PRODUCT_FACTORY,
 a.qc_check_num           wash_TEST_NUM,
 qw.wash_test_date,
 qw.wash_float,
 qw.wash_float_unq,
 qw.dyed_stain,
 qw.dyed_stain_unq,
 qw.cloth_shrinkage,
 qw.cloth_shrinkage_unq,
 qw.appearance_af,
 qw.appearance_af_unq,
 a.qc_result              wash_test_result,
 a.qc_unq_say             wash_test_unq_say,
 a.qc_unq_advice,qw.wash_test_log,

 (select listagg(o.order_id, ''; '') within group(order by 1)
    from scmdata.t_qc_check_rela_order k
   inner join scmdata.t_orders o
      on o.orders_id = k.orders_id
   where k.qc_check_id = a.qc_check_id) wash_test_order_id,
 a.memo,
 (select company_user_name
    from sys_company_user
   where user_id = a.finish_qc_id
     and company_id = a.company_id) QC_CHECK_USER

  from scmdata.t_qc_check a
  inner join scmdata.sys_company c
  on c.company_id=a.company_id
 inner join scmdata.t_qc_check_wash qw
    on a.qc_check_id = qw.qc_check_id
 inner join scmdata.t_commodity_info ci
    on ci.goo_id = a.goo_id
   and a.company_id = ci.company_id
  left join scmdata.t_supplier_info si
    on si.supplier_code = a.supplier_code
   and a.company_id = si.company_id
  left join scmdata.t_supplier_info fi
    on fi.supplier_code = a.factory_code
   and a.company_id = fi.company_id
 where a.qc_check_code = ''' || V_ID || '''
   and si.supplier_company_id = ''' || V_COMPID || '''';
    RETURN V_EXESQL;
  END F_GET_QC_WASH_TESTING_SQL;

  --生成qc其余检测环节sql
  FUNCTION F_GET_QC_ELSE_SQL(V_ID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB IS
    V_EXESQL CLOB;
  BEGIN
    V_EXESQL := 'select ci.rela_goo_id,
       ci.style_number,
       --su.supplier_company_name,
       c.logn_name kehu,
       a.qc_check_node,
       a.QC_FINISH_DATE,
       a.ts_product_num,
       a.ts_check_num,
       a.ts_unquality_num,
       a.ts_check_percenty,
       a.ts_quality_percenty,
       a.second_final_check,
       a.qc_check_num QC_CHECK_NUM,
       (select company_user_name
          from sys_company_user
         where user_id = a.finish_qc_id
           and company_id = a.company_id) QC_CHECK_USER,
       a.qc_file_id,
       (select listagg(o.order_id, ''; '') within group(order by 1)
          from scmdata.t_qc_check_rela_order k
         inner join scmdata.t_orders o
            on o.orders_id = k.orders_id
         where k.qc_check_id = a.qc_check_id) rela_order_id,
       a.qc_result,
       a.qc_unq_say,
       a.qc_unq_advice,
        (select nvl(ga.group_dict_name, listagg(abn_range_desc, '' ''))
          from (select c.colorname abn_range_desc
                  from scmdata.t_commodity_color c
                 where c.goo_id = ci.goo_id
                   and c.company_id = ci.company_id
                   and instr(qca.abnormal_range, c.color_code) > 0
                   and qca.abnormal_range not in (''00'', ''01''))) ABN_RANGE_QC_DESC,
         qca.delay_amount DELAY_AMOUNT_PR,
       qca.CAUSE_DETAILED PROBLEM_CLASS_QC,
       a.need_recheck,
       a.memo,
       ''样衣核对'' CHECK_TYPE_DESC_1,
       qcr.sampler_result,
       --qcr.sampler_unq,
       (select listagg(cd.company_dict_name, '';'') within group(order by 1)  from scmdata.sys_company_dict cd where instr('';'' || qcr.sampler_unq || '';'', '';'' ||cd.company_dict_value|| '';'') > 0 and cd.company_dict_type=''QC_SAMPLE_UNQ'' and a.company_id=cd.company_id) sampler_unq_desc,
        ''面辅料查验'' CHECK_TYPE_DESC_2,
       qcr.fabrib_result,
       --qcr.fabrib_unq,
        (select listagg(cd.company_dict_name, '';'') within group(order by 1) from scmdata.sys_company_dict cd where instr('';'' || qcr.fabrib_unq || '';'', '';'' ||cd.company_dict_value|| '';'') > 0 and cd.company_dict_type=''QC_FARBIC_PHYSIAL_UNQ'' and a.company_id=cd.company_id) fabrib_unq_desc,
        ''工艺做工查验'' CHECK_TYPE_DESC_3,
       qcr.craft_result,
       --qcr.craft_unq,
       (select listagg(cd.company_dict_name, '';'') within group(order by 1) from scmdata.sys_company_dict cd where instr('';'' || qcr.craft_unq || '';'', '';'' ||cd.company_dict_value|| '';'') > 0  and cd.company_dict_type=''QC_CRAFT_UNQ_DICT'' and a.company_id=cd.company_id) craft_unq_desc,
        ''版型尺寸查验'' CHECK_TYPE_DESC_4,
       qcr.type_size_result,
       --qcr.type_size_unq,
       (select listagg(cd.company_dict_name, '';'') within group(order by 1) from scmdata.sys_company_dict cd where instr('';'' || qcr.type_size_unq || '';'', '';'' ||cd.company_dict_value|| '';'') > 0 and cd.company_dict_type=''QC_SIZE_TYPE_UNQ_DICT'' and a.company_id=cd.company_id) type_size_unq_desc,
       /*(select listagg(picture_id, '','') within group(order by 1)
          from scmdata.t_commodity_file
         where commodity_info_id = ci.commodity_info_id
           and file_type = ''01'') COMMODITY_SIZE_CHART,*/
        ''尺寸表核对查看'' SIZE_CHART_CHECK,
         A.QC_CHECK_ID
  from scmdata.t_qc_check a
  inner join scmdata.sys_company c
  on c.company_id=a.company_id
 inner join scmdata.t_qc_check_report qcr
    on a.qc_check_id = qcr.qc_check_id
 inner join scmdata.t_commodity_info ci
    on a.goo_id = ci.goo_id
   and a.company_id = ci.company_id
 inner join scmdata.t_supplier_info su
    on a.supplier_code = su.supplier_code
   and a.company_id = su.company_id
   left join scmdata.t_qc_check_abnormal qca
    on qca.qc_check_id = a.qc_check_id
  left join scmdata.sys_group_dict ga
    on ga.group_dict_type = ''ABN_RANGE''
   AND ga.pause = 0
   and ga.group_dict_value = qca.abnormal_range
   and qca.abnormal_range in (''00'', ''01'')
 where a.qc_check_code = ''' || V_ID || '''
   and su.supplier_company_id = ''' || V_COMPID || '''';
    RETURN V_EXESQL;
  END F_GET_QC_ELSE_SQL;

  --生成QA检测sql
  FUNCTION F_GET_QA_REPORT_SQL(V_ID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB IS
    v_company_id varchar2(32);
    V_EXESQL     CLOB;
  BEGIN
  
    select max(company_id)
      into v_company_id
      from scmdata.t_qa_report a
     where a.qa_report_id = V_ID;
    V_EXESQL := 'SELECT A.QA_REPORT_ID,
         A.COMPANY_ID,
         B.RELA_GOO_ID,
         B.STYLE_NUMBER,
         B.STYLE_NAME,
         (select logn_name from scmdata.sys_company
         where company_id =a.company_id) kehu,
         A.PCOMESUM_AMOUNT QAPCOMESUM_AMOUNT,
         A.FIRSTCHECK_AMOUNT QAFIRSTCHECK_AMOUNT,
         (SELECT GROUP_DICT_NAME
            FROM SCMDATA.SYS_GROUP_DICT
           WHERE GROUP_DICT_VALUE = A.CHECK_TYPE
             AND GROUP_DICT_TYPE = ''QA_REPCHECK_TYPE'') QACHECK_TYPE,
         A.ADDCHECK_AMOUNT QAADDCHECK_AMOUNT,
         A.CHECKSUM_AMOUNT QACHECKSUM_AMOUNT,
         A.CHECKERS QACHECKERS,
         NVL(TO_CHAR(ROUND(A.CHECKSUM_AMOUNT / DECODE(A.PCOMESUM_AMOUNT,0,1,A.PCOMESUM_AMOUNT) * 100,2),''fm990.00''),0.00)||''%'' QACHECK_RATE,
         A.CHECK_DATE QACHECK_DATE,
         A.MEMO,
         A.CHECK_RESULT QACHECK_RESULT,
         A.CHECKSUM_AMOUNT QACHECK_AMOUNT,
         A.UNQUAL_TREATMENT,
         A.UNQUALREASON_CLASS,
         A.UNQUAL_SUBJUECTS,
         A.UNQUAL_AMOUNT QAUNQUAL_AMOUNT,
         NVL(TO_CHAR(ROUND((1-(NVL(A.UNQUAL_AMOUNT,0) / DECODE(A.CHECKSUM_AMOUNT,0,1,A.CHECKSUM_AMOUNT))) * 100,2),''fm990.00''),0.00)||''%'' QAQUAL_RATE,
         A.ATTACHMENT,A.YY_RESULT VW_YYRESULT,
         -- a.YY_UQDESC
         (select listagg(cd.company_dict_name, '';'') within group(order by 1)  from scmdata.sys_company_dict cd
          where instr('';'' || a.YY_UQDESC || '';'', '';'' ||cd.company_dict_value|| '';'') > 0
          and cd.company_dict_type=''QC_SAMPLE_UNQ'' and a.company_id=cd.company_id) YY_UQDESC,
         A.MFL_RESULT VW_MFLRESULT,
         --A.MFL_UQDESC,
         (select listagg(cd.company_dict_name, '';'') within group(order by 1)  from scmdata.sys_company_dict cd
          where instr('';'' || a.MFL_UQDESC || '';'', '';'' ||cd.company_dict_value|| '';'') > 0
          and cd.company_dict_type=''QC_FARBIC_PHYSIAL_UNQ'' and a.company_id=cd.company_id) MFL_UQDESC,
         A.GY_RESULT VW_GYRESULT,
         --A.GY_UQDESC,
         (select listagg(cd.company_dict_name, '';'') within group(order by 1)  from scmdata.sys_company_dict cd
          where instr('';'' || a.GY_UQDESC || '';'', '';'' ||cd.company_dict_value|| '';'') > 0
          and cd.company_dict_type=''QA_CRAFT_UNQ_DICT'' and a.company_id=cd.company_id) GY_UQDESC,
         A.BX_RESULT VW_BXRESULT,
         --A.BX_UQDESC,
         (select listagg(cd.company_dict_name, '';'') within group(order by 1)  from scmdata.sys_company_dict cd
          where instr('';'' || a.BX_UQDESC || '';'', '';'' ||cd.company_dict_value|| '';'') > 0
          and cd.company_dict_type=''QC_SIZE_TYPE_UNQ_DICT'' and a.company_id=cd.company_id) BX_UQDESC,
        ''查看'' TO_CHECK_RANGE,
        ''查看'' TO_SUBS_AMOUNT,
        ''查看'' TO_UNQUAL_TREATMENT
    FROM (SELECT Z.QA_REPORT_ID,Z.COMPANY_ID,Z.PCOMESUM_AMOUNT,Z.FIRSTCHECK_AMOUNT,Z.ADDCHECK_AMOUNT,
                 Z.CHECKSUM_AMOUNT,Z.GOTSUM_AMOUNT,Z.SUBS_AMOUNT,Z.REJSUM_AMOUNT,Z.RETSUM_AMOUNT,
                 Z.CHECKERS,Z.CHECK_DATE,Z.CHECK_RESULT,Z.UNQUAL_TREATMENT,Z.UNQUAL_SUBJUECTS,
                 Z.UNQUAL_AMOUNT,Z.ATTACHMENT,Z.MEMO,Z.YY_RESULT,Z.YY_UQDESC,Z.MFL_RESULT,Z.MFL_UQDESC,
                 Z.GY_RESULT,Z.GY_UQDESC,Z.BX_RESULT,Z.BX_UQDESC,Z.CHECK_TYPE,Z.GOO_ID,Z.UNQUALREASON_CLASS,
                 (SELECT MAX(SUPPLIER_CODE)
                    FROM SCMDATA.T_QA_SCOPE
                   WHERE QA_REPORT_ID = Z.QA_REPORT_ID
                     AND COMPANY_ID = Z.COMPANY_ID) SUPPLIER_CODE
            FROM SCMDATA.T_QA_REPORT Z
           WHERE COMPANY_ID = ''' || v_company_id || '''
             AND QA_REPORT_ID = ''' || V_ID ||
                ''') A
   INNER JOIN SCMDATA.T_COMMODITY_INFO B
      ON A.GOO_ID = B.GOO_ID
     AND A.COMPANY_ID = B.COMPANY_ID';
    return V_EXESQL;
  END F_GET_QA_REPORT_SQL;

  --获取多重展示页面正确sql
  FUNCTION F_GET_RIGHT_SQL_FOR_MULTI_VIEW(V_ID     IN VARCHAR2,
                                          V_COMPID IN VARCHAR2) RETURN CLOB IS
    V_SQL  CLOB;
    V_NODE VARCHAR2(32);
  BEGIN
    IF V_ID LIKE 'AP_VERSION%' THEN
      V_SQL := F_GET_APPROVE_VERSION_SQL(V_ID => V_ID, V_COMPID => V_COMPID);
    ELSIF V_ID LIKE 'SJ%' THEN
      V_SQL := F_GET_FABRIC_SQL(V_ID => V_ID, V_COMPID => V_COMPID);
    ELSIF V_ID LIKE 'QA%' THEN
      V_SQL := F_GET_QA_REPORT_SQL(V_ID => V_ID, V_COMPID => V_COMPID);
    ELSE
      SELECT MAX(A.QC_CHECK_NODE)
        INTO V_NODE
        FROM SCMDATA.T_QC_CHECK A
       inner join scmdata.t_supplier_info si
          on si.supplier_code = a.supplier_code
         and si.company_id = a.company_id
       WHERE A.QC_CHECK_CODE = V_ID
         AND si.supplier_company_id = V_COMPID;
      IF V_NODE = 'QC_PRE_MEETING' THEN
        V_SQL := F_GET_QC_PRE_MEETING_SQL(V_ID     => V_ID,
                                          V_COMPID => V_COMPID);
      ELSIF V_NODE = 'QC_WASH_TESTING' THEN
        V_SQL := F_GET_QC_WASH_TESTING_SQL(V_ID     => V_ID,
                                           V_COMPID => V_COMPID);
      ELSE
        V_SQL := F_GET_QC_ELSE_SQL(V_ID => V_ID, V_COMPID => V_COMPID);
      END IF;
    END IF;
    RETURN V_SQL;
  END F_GET_RIGHT_SQL_FOR_MULTI_VIEW;

end pkg_qc_view_supp;
/

