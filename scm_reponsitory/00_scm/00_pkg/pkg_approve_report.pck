create or replace package scmdata.pkg_approve_report is

  -- Author  : SANFU
  -- Created : 2022/4/15 15:16:28
  -- Purpose : 生成批版清单记录

  Procedure p_log_approve_report(p_approve_vesrion_id varchar2);
end pkg_approve_report;
/

create or replace package body scmdata.pkg_approve_report is

  Procedure p_log_approve_report(p_approve_vesrion_id varchar2) is
    p_approve_log_report scmdata.t_approve_log_report%rowtype;
  begin
  
    WITH TMP AS
     (SELECT *
        FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT
       WHERE APPROVE_VERSION_ID = p_approve_vesrion_id)
    SELECT a.approve_version_id,
           a.company_id,
           a.bill_code,
           a.approve_number,
           a.approve_result,
           a.goo_id,
           a.style_code,
           a.approve_user_id,
           a.approve_time,
           a.create_time,
           a.remarks,
           a.origin,
           a.create_id,
           a.supplier_code,
           a.re_version_reason,
           (select min(oe.SEND_ORDER_DATE)
              from scmdata.t_ordered oe
             inner join scmdata.t_orders os
                on oe.order_code = os.order_id
               and oe.company_id = os.company_id
             where os.goo_id = a.goo_id) FIRST_SEND_ORDER_DATE,
           (select nvl2(min(oe.send_order_date),
                        a.approve_time - min(oe.send_order_date),
                        null)
              from scmdata.t_ordered oe
             inner join scmdata.t_orders os
                on oe.order_code = os.order_id
               and oe.company_id = os.company_id
             where os.goo_id = a.goo_id) APPROVE_USE_DAY,
           (SELECT COMPANY_USER_NAME
              FROM SCMDATA.SYS_COMPANY_USER
             WHERE COMPANY_ID =
                   (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = 'EVAL11')
               AND USER_ID = (SELECT ASSESS_USER_ID
                                FROM TMP
                               WHERE ASSESS_TYPE = 'EVAL11')) MFL_AU,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'APPROVE_RISK_WARNING'
               AND GROUP_DICT_VALUE =
                   (SELECT risk_warning FROM TMP WHERE ASSESS_TYPE = 'EVAL11')) MFL_RW,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'EVAL_RESULT'
               AND GROUP_DICT_VALUE =
                   (SELECT ASSESS_RESULT
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL11')) MFL_AR,
           
           (SELECT COMPANY_DICT_NAME
              FROM SCMDATA.SYS_COMPANY_DICT
             WHERE COMPANY_DICT_TYPE = 'EVAL11'
               and company_id = a.company_id
               AND COMPANY_DICT_VALUE =
                   (SELECT unqualified_say
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL11')) MFL_US,
           (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = 'EVAL11') MFL_AS,
           (SELECT COMPANY_USER_NAME
              FROM SCMDATA.SYS_COMPANY_USER
             WHERE COMPANY_ID =
                   (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = 'EVAL12')
               AND USER_ID = (SELECT ASSESS_USER_ID
                                FROM TMP
                               WHERE ASSESS_TYPE = 'EVAL12')) YXH_AU,
           
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'APPROVE_RISK_WARNING'
               AND GROUP_DICT_VALUE =
                   (SELECT risk_warning FROM TMP WHERE ASSESS_TYPE = 'EVAL12')) YXH_RW,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE =  'EVAL_RESULT'
               AND GROUP_DICT_VALUE =
                   (SELECT ASSESS_RESULT
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL12')) YXH_AR,
           (SELECT COMPANY_DICT_NAME
              FROM SCMDATA.SYS_COMPANY_DICT
             WHERE COMPANY_DICT_TYPE = 'EVAL12'
               and company_id = a.company_id
               AND COMPANY_DICT_VALUE =
                   (SELECT unqualified_say
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL12')) YXH_US,
           (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = 'EVAL12') YXH_AS,
           (SELECT COMPANY_USER_NAME
              FROM SCMDATA.SYS_COMPANY_USER
             WHERE COMPANY_ID =
                   (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = 'EVAL13')
               AND USER_ID = (SELECT ASSESS_USER_ID
                                FROM TMP
                               WHERE ASSESS_TYPE = 'EVAL13')) GY_AU,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'APPROVE_RISK_WARNING'
               AND GROUP_DICT_VALUE =
                   (SELECT risk_warning FROM TMP WHERE ASSESS_TYPE = 'EVAL13')) GY_RW,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'EVAL_RESULT'
               AND GROUP_DICT_VALUE =
                   (SELECT ASSESS_RESULT
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL13')) GY_AR,
           
           (SELECT COMPANY_DICT_NAME
              FROM SCMDATA.SYS_COMPANY_DICT
             WHERE COMPANY_DICT_TYPE = 'EVAL13'
               and company_id = a.company_id
               AND COMPANY_DICT_VALUE =
                   (SELECT unqualified_say
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL13')) GY_US,
           (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = 'EVAL13') GY_AS,
           
           (SELECT COMPANY_USER_NAME
              FROM SCMDATA.SYS_COMPANY_USER
             WHERE COMPANY_ID =
                   (SELECT COMPANY_ID FROM TMP WHERE ASSESS_TYPE = 'EVAL14')
               AND USER_ID = (SELECT ASSESS_USER_ID
                                FROM TMP
                               WHERE ASSESS_TYPE = 'EVAL14')) BXCC_AU,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'APPROVE_RISK_WARNING'
               AND GROUP_DICT_VALUE =
                   (SELECT risk_warning FROM TMP WHERE ASSESS_TYPE = 'EVAL14')) BXCC_RW,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'EVAL_RESULT'
               AND GROUP_DICT_VALUE =
                   (SELECT ASSESS_RESULT
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL14')) BXCC_AR,
           
           (SELECT COMPANY_DICT_NAME
              FROM SCMDATA.SYS_COMPANY_DICT
             WHERE COMPANY_DICT_TYPE = 'EVAL14'
               and company_id = 'b6cc680ad0f599cde0531164a8c0337f'
               AND COMPANY_DICT_VALUE =
                   (SELECT unqualified_say
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL14')) BXCC_US,
           (SELECT ASSESS_SAY FROM TMP WHERE ASSESS_TYPE = 'EVAL14') BXCC_AS,
           (SELECT LISTAGG(E.GROUP_DICT_NAME, ',')
              FROM SCMDATA.T_APPROVE_RISK_ASSESSMENT D
              LEFT JOIN SCMDATA.SYS_GROUP_DICT E
                ON D.ASSESS_TYPE = E.GROUP_DICT_VALUE
               AND E.GROUP_DICT_TYPE = 'BAD_FACTOR'
             WHERE D.APPROVE_VERSION_ID = a.APPROVE_VERSION_ID
               AND D.COMPANY_ID = a.COMPANY_ID
               AND D.ASSESS_RESULT = 'EVRT02') NP_EVALSBJ,
           (SELECT LISTAGG(DISTINCT GROUP_DICT_NAME, ',')
              FROM scmdata.sys_group_dict
             WHERE GROUP_DICT_TYPE = 'APUNQUAL_TREATMENT'
               AND GROUP_DICT_VALUE IN (SELECT UNQUAL_TREATMENT FROM TMP)) APUNQUAL_TREATMENT,
           (SELECT GROUP_DICT_NAME
              FROM scmdata.sys_group_dict
             WHERE GROUP_DICT_VALUE = a.approve_result
               AND GROUP_DICT_TYPE = 'APPROVE_STATUS') approve_result_desc,
           (SELECT COMPANY_DICT_NAME
              FROM scmdata.sys_company_dict
             WHERE COMPANY_DICT_VALUE = a.RE_VERSION_REASON
               AND COMPANY_DICT_TYPE = 'RE_VERSION_REASON_DICT'
               and company_id = a.company_id) RE_VERSION_REASON_DESC,
           -- ci.rela_goo_id||','||ci.style_number all_approve_say,
           --APUNQUAL_TREATMENT
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'APUNQUAL_TREATMENT'
               AND GROUP_DICT_VALUE =
                   (SELECT UNQUAL_TREATMENT
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL11')) MFL_UT,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'APUNQUAL_TREATMENT'
               AND GROUP_DICT_VALUE =
                   (SELECT UNQUAL_TREATMENT
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL12')) YXH_UT,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'APUNQUAL_TREATMENT'
               AND GROUP_DICT_VALUE =
                   (SELECT UNQUAL_TREATMENT
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL13')) GY_UT,
           (SELECT GROUP_DICT_NAME
              FROM SCMDATA.SYS_GROUP_DICT
             WHERE GROUP_DICT_TYPE = 'APUNQUAL_TREATMENT'
               AND GROUP_DICT_VALUE =
                   (SELECT UNQUAL_TREATMENT
                      FROM TMP
                     WHERE ASSESS_TYPE = 'EVAL14')) BXCC_UT
      into p_approve_log_report.approve_version_id,
           p_approve_log_report.company_id,
           p_approve_log_report.bill_code,
           p_approve_log_report.approve_number,
           p_approve_log_report.approve_result,
           p_approve_log_report.goo_id,
           p_approve_log_report.style_code,
           p_approve_log_report.approve_user_id,
           p_approve_log_report.approve_time,
           p_approve_log_report.create_time,
           p_approve_log_report.remarks,
           p_approve_log_report.origin,
           p_approve_log_report.create_id,
           p_approve_log_report.supplier_code,
           p_approve_log_report.re_version_reason,
           p_approve_log_report.first_send_order_date,
           p_approve_log_report.approve_use_day,
           p_approve_log_report.mfl_au,
           p_approve_log_report.mfl_rw,
           p_approve_log_report.mfl_ar,
           p_approve_log_report.mfl_us,
           p_approve_log_report.mfl_as,
           p_approve_log_report.yxh_au,
           p_approve_log_report.yxh_rw,
           p_approve_log_report.yxh_ar,
           p_approve_log_report.yxh_us,
           p_approve_log_report.yxh_as,
           p_approve_log_report.gy_au,
           p_approve_log_report.gy_rw,
           p_approve_log_report.gy_ar,
           p_approve_log_report.gy_us,
           p_approve_log_report.gy_as,
           p_approve_log_report.bxcc_au,
           p_approve_log_report.bxcc_rw,
           p_approve_log_report.bxcc_ar,
           p_approve_log_report.bxcc_us,
           p_approve_log_report.bxcc_as,
           p_approve_log_report.np_evalsbj,
           p_approve_log_report.apunqual_treatment,
           p_approve_log_report.APPROVE_RESULT_DESC,
           p_approve_log_report.RE_VERSION_REASON_DESC,
           -- p_approve_log_report.all_approve_say,
           p_approve_log_report.mfl_ut,
           p_approve_log_report.yxh_ut,
           p_approve_log_report.gy_ut,
           p_approve_log_report.bxcc_ut
    
    -- p_approve_log_report.log_time
      FROM SCMDATA.T_APPROVE_VERSION A
     WHERE APPROVE_VERSION_ID = p_approve_vesrion_id;
    select a.rela_goo_id || ',' || a.style_number
      into p_approve_log_report.all_approve_say from scmdata.t_commodity_info a
     where a.goo_id = p_approve_log_report.goo_id
       and a.company_id = p_approve_log_report.company_id;
    p_approve_log_report.APPROVE_LOG_REPORT_ID := scmdata.f_get_uuid();
    p_approve_log_report.log_time              := sysdate;
    p_approve_log_report.all_approve_say       := p_approve_log_report.all_approve_say || ',' ||
                                                  to_char(p_approve_log_report.approve_time,
                                                          'yyyy-mm-dd') || ',' ||
                                                  p_approve_log_report.approve_result_desc ||
                                                  '(面辅料' ||
                                                  p_approve_log_report.mfl_ar ||
                                                  p_approve_log_report.mfl_ut || ',' ||
                                                  '印绣花' ||
                                                  p_approve_log_report.yxh_ar ||
                                                  p_approve_log_report.yxh_ut || ',' || '工艺' ||
                                                  p_approve_log_report.gy_ar ||
                                                  p_approve_log_report.gy_ut || ',' ||
                                                  '版型尺寸' ||
                                                  p_approve_log_report.bxcc_ar ||
                                                  p_approve_log_report.bxcc_ut || ')' ||
                                                  chr(10) || chr(10) ||
                                                  '面辅料:' || chr(10) ||
                                                  p_approve_log_report.mfl_as ||
                                                  chr(10) || chr(10) ||
                                                  '印绣花:' || chr(10) ||
                                                  p_approve_log_report.yxh_as ||
                                                  chr(10) || chr(10) ||
                                                  '工艺:' || chr(10) ||
                                                  p_approve_log_report.gy_as ||
                                                  chr(10) || chr(10) ||
                                                  '版型尺寸:' || chr(10) ||
                                                  p_approve_log_report.bxcc_as ||
                                                  chr(10) || chr(10);
    insert into scmdata.t_approve_log_report values p_approve_log_report;
  end p_log_approve_report;

end pkg_approve_report;
/

