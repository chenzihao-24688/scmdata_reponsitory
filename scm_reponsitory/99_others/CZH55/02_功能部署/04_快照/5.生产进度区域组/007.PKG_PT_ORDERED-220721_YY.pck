CREATE OR REPLACE PACKAGE SCMDATA.PKG_PT_ORDERED IS

  -- Author  : DYY153
  -- Created : 2022/7/14 14:36:14
  -- Purpose : �����������ݱ�༭����


 /*===================================================================
 
   ��������û�id���ض�Ӧ��update_sql
   ��Σ�
        V_USERID �� �û�id
        V_COMPID ����ҵid
 
 =====================================================================*/
  FUNCTION F_UPD_PTORDERED(V_USERID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB;

END PKG_PT_ORDERED;
/
CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_PT_ORDERED IS

  FUNCTION F_UPD_PTORDERED(V_USERID IN VARCHAR2, V_COMPID IN VARCHAR2)
    RETURN CLOB IS
  
    V_NUM1 NUMBER;
    V_NUM2 NUMBER;
    --V_NUM3 NUMBER;
    V_SQL  CLOB;
  BEGIN
    --����
    SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_USERID,
                                                         V_COMPID,
                                                         'P013030104')
      INTO V_NUM1
      FROM DUAL;
  
    --QC
    SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_USERID,
                                                         V_COMPID,
                                                         'P013030105')
      INTO V_NUM2
      FROM DUAL;
  
    /*--����ԭ��
    SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_USERID,
                                                         V_COMPID,
                                                         'P013030106')
      INTO V_NUM3
      FROM DUAL;
  */
  
  
  
    --�����༭�����ֶ�
    IF V_NUM1 = 1 AND V_NUM2 = 0 /*AND V_NUM3 = 0*/ THEN
      V_SQL := q'[DECLARE
  V_ORDER_FINISH_TIME DATE;
  V_DELIVERY_DATE     DATE;
  V_FLW_MANA         VARCHAR2(512);
  v_is_sup_exemption  NUMBER;
  v_first_dept_id     VARCHAR2(100);
  v_second_dept_id    VARCHAR2(100);
  v_is_quality        NUMBER;
  v_flag              NUMBER;
  v_dept_name        varchar2(100);
BEGIN

  SELECT T.ORDER_FINISH_TIME, T.DELIVERY_DATE
    INTO V_ORDER_FINISH_TIME, V_DELIVERY_DATE
    FROM SCMDATA.PT_ORDERED T
   WHERE T.PT_ORDERED_ID = :PT_ORDERED_ID;
  IF TO_CHAR(V_DELIVERY_DATE, 'yyyy-mm') <>
     NVL(SCMDATA.PKG_DB_JOB.F_GET_MONTH(TRUNC(SYSDATE, 'mm')),
         TO_CHAR(SYSDATE, 'yyyy-mm')) THEN
    RAISE_APPLICATION_ERROR(-20002, '����ʧ�ܣ������ѷ�棬�����޸ġ�');
  END IF;
  IF V_ORDER_FINISH_TIME IS NULL THEN
    RAISE_APPLICATION_ERROR(-20002,
                            '����ʧ�ܣ�ֻ���޸��ѽ��������ĸ���Ա��δ�����뵽�����������޸ġ�');
  END IF;
  --����У���߼�������������ࡢ����ԭ����ࡢ����ԭ��ϸ����ֵ����������������
  IF :delay_problem_class_pr IS NOT NULL AND
     :delay_cause_class_pr IS NOT NULL AND
     :delay_cause_detailed_pr IS NOT NULL THEN
    IF :problem_desc_pr IS NULL THEN
      raise_application_error(-20002,
                              '��ʾ������������ࡢ����ԭ����ࡢ����ԭ��ϸ����ֵ���������������');
      ELSIF :responsible_dept_sec is null then
           raise_application_error(-20002,
                                  '����ʧ�ܣ�����ԭ������д�����β���(2)������Ϊ�գ����顣');
        ELSE
      SELECT max(ad.is_sup_exemption),
             max(ad.first_dept_id),
             max(ad.second_dept_id),
             max(ad.is_quality_problem)
        INTO v_is_sup_exemption,
             v_first_dept_id,
             v_second_dept_id,
             v_is_quality
        FROM scmdata.t_commodity_info tc
       INNER JOIN scmdata.t_abnormal_range_config ar
          ON tc.company_id = ar.company_id
         AND tc.category = ar.industry_classification
         AND tc.product_cate = ar.production_category
         AND instr(';' || ar.product_subclass || ';',
                   ';' || tc.samll_category || ';') > 0
         AND ar.pause = 0
       INNER JOIN scmdata.t_abnormal_dtl_config ad
          ON ar.company_id = ad.company_id
         AND ar.abnormal_config_id = ad.abnormal_config_id
         AND ad.pause = 0
       INNER JOIN scmdata.t_abnormal_config ab
          ON ab.company_id = ad.company_id
         AND ab.abnormal_config_id = ad.abnormal_config_id
         AND ab.pause = 0
       WHERE tc.company_id = :company_id
         AND tc.goo_id = :goo_id_pr
         AND ad.anomaly_classification = 'AC_DATE'
         AND ad.problem_classification = :delay_problem_class_pr
         AND ad.cause_classification = :delay_cause_class_pr
         AND ad.cause_detail = :delay_cause_detailed_pr;
      select max(t.dept_name)
          into v_dept_name
          from scmdata.sys_company_dept t
         where t.company_dept_id =
               nvl(:responsible_dept_sec, v_second_dept_id);
        if v_dept_name <> '��' then
      SELECT COUNT(1)
        INTO v_flag
        FROM (SELECT t.company_dept_id
                FROM scmdata.sys_company_dept t
               START WITH t.company_dept_id = v_first_dept_id
              CONNECT BY PRIOR t.company_dept_id = t.parent_id)
       WHERE company_dept_id = nvl(:responsible_dept_sec, v_second_dept_id);

      IF v_flag = 0 THEN
        raise_application_error(-20002,
                                '����ʧ�ܣ����β���(2��)����Ϊ���β���(1��)���¼����ţ����飡');

       END IF;
          else
          null;
        end if;
    END IF;
  ELSE
    IF :responsible_dept_sec IS NOT NULL THEN
      raise_application_error(-20002,
                              '����ʧ�ܣ����β���(2��)��Ϊ��ʱ,����������ࡢ����ԭ����ࡢ����ԭ��ϸ�ֱ��');
    ELSE
      NULL;
    END IF;
  END IF;
    IF :DEAL_FOLLOWER IS NOT NULL THEN 
    V_FLW_MANA := SCMDATA.PKG_DB_JOB.f_get_manager(p_company_id     => %DEFAULT_COMPANY_ID%,
                                        p_user_id        => :DEAL_FOLLOWER,
                                        p_company_job_id => '1001005003005002');
  END IF; 
 
   UPDATE scmdata.pt_ordered t
     SET t.delay_problem_class  = :delay_problem_class_pr,
         t.delay_cause_class    = :delay_cause_class_pr,
         t.delay_cause_detailed = :delay_cause_detailed_pr,
         t.problem_desc         = :problem_desc_pr,
         t.is_sup_duty          = v_is_sup_exemption,
         t.responsible_dept     = v_first_dept_id,
         t.responsible_dept_sec = nvl(:responsible_dept_sec,
                                      v_second_dept_id),
         t.is_quality           = v_is_quality,
         t.updated              = 1,
         t.update_id            = :user_id,
         t.update_time          = sysdate,
         T.FLW_ORDER            = :DEAL_FOLLOWER,
         T.FLW_ORDER_MANAGER    = V_FLW_MANA
   WHERE T.PT_ORDERED_ID = :PT_ORDERED_ID;
END; ]';
 --QC
ELSIF V_NUM1 = 0 AND V_NUM2 = 1 /*AND V_NUM3 = 0*/ THEN 
  V_SQL:=q'[
  DECLARE
  --V_ORDER_FINISH_TIME DATE;
  V_DELIVERY_DATE     DATE;
  V_QC_DIRECTOR_ID    VARCHAR2(512);

BEGIN

  SELECT  T.DELIVERY_DATE
    INTO  V_DELIVERY_DATE
    FROM SCMDATA.PT_ORDERED T
   WHERE T.PT_ORDERED_ID = :PT_ORDERED_ID;
  IF TO_CHAR(V_DELIVERY_DATE, 'yyyy-mm') <>
     NVL(SCMDATA.PKG_DB_JOB.F_GET_MONTH(TRUNC(SYSDATE, 'mm')),
         TO_CHAR(SYSDATE, 'yyyy-mm')) THEN
    RAISE_APPLICATION_ERROR(-20002, '����ʧ�ܣ������ѷ�棬�����޸ġ�');
  END IF;
  IF :QC_ID IS NOT NULL THEN 
    V_QC_DIRECTOR_ID := SCMDATA.PKG_DB_JOB.f_get_manager_byconfig(p_company_id =>%DEFAULT_COMPANY_ID%,
                                                                  p_user_id  => :QC_ID);
   END IF;                                                               
     UPDATE SCMDATA.PT_ORDERED T 
             SET T.QC = :QC_ID,
                 T.QC_MANAGER =V_QC_DIRECTOR_ID,
                 T.UPDATED_QC = 1 
           WHERE T.PT_ORDERED_ID = :PT_ORDERED_ID;    
   END;                   ]';

  --���ɱ༭
ELSIF V_NUM1 = 1 AND V_NUM2 = 1 /*AND V_NUM3 = 0*/ THEN 
 v_sql:='DECLARE
  v_is_sup_exemption  NUMBER;
  v_first_dept_id     VARCHAR2(100);
  v_second_dept_id    VARCHAR2(100);
  v_is_quality        NUMBER;
  v_flag              NUMBER;
  v_order_finish_time date;
  v_delivery_date     date;
  v_dept_name        varchar2(100);
  V_FLW_MANA         VARCHAR2(512);
  V_QC_DIRECTOR_ID   VARCHAR2(512);
  
BEGIN

  SELECT t.order_finish_time, t.delivery_date
    INTO v_order_finish_time, v_delivery_date
    FROM scmdata.pt_ordered t
   WHERE t.pt_ordered_id = :pt_ordered_id;
  if to_char(v_delivery_date, ''yyyy-mm'') <>
     nvl(scmdata.pkg_db_job.f_get_month(trunc(sysdate,''mm'')),to_char(sysdate,''yyyy-mm'')) then
    raise_application_error(-20002, ''����ʧ�ܣ������ѷ�棬�����޸ġ�'');
 
 ELSE  
  
    --��ֻ��qc�����ı�ʱ����У��
 IF NVL(:qc_id,''1'')<>NVL(:old_qc_id,''1'') AND NVL(:deal_follower,''1'') = NVL(:old_deal_follower,''1'') 
      AND NVL(:problem_desc_pr,''1'') = NVL(:old_problem_desc_pr,''1'') 
      AND NVL(:delay_problem_class_pr,''1'') = NVL(:old_delay_problem_class_pr,''1'')
      AND NVL(:delay_cause_class_pr,''1'') = NVL(:old_delay_cause_class_pr,''1'')
      AND NVL(:delay_cause_detailed_pr,''1'') = NVL(:old_delay_cause_detailed_pr,''1'') THEN 
      
   IF :QC_ID IS NOT NULL THEN 
    V_QC_DIRECTOR_ID := SCMDATA.PKG_DB_JOB.f_get_manager_byconfig(p_company_id =>%DEFAULT_COMPANY_ID%,
                                                                  p_user_id  => :QC_ID);
                                                           
    ELSE 
      NULL;
    END IF;                                                              
      UPDATE SCMDATA.PT_ORDERED T 
             SET T.QC = :QC_ID,
                 T.QC_MANAGER =V_QC_DIRECTOR_ID,
                 T.UPDATED_QC = 1 
           WHERE T.PT_ORDERED_ID = :PT_ORDERED_ID;    
  
  
      
       --��ֻҪ�������ֶη����ı�ʱ����У��
ELSE 
       IF v_order_finish_time is null then
    raise_application_error(-20002,
                            ''����ʧ�ܣ�����δ���������޸ĸ���/������������ֶΣ��뵽����������/���������ȡ��޸ġ�'');
  end if;
  --����У���߼�������������ࡢ����ԭ����ࡢ����ԭ��ϸ����ֵ����������������
  IF :delay_problem_class_pr IS NOT NULL AND
     :delay_cause_class_pr IS NOT NULL AND
     :delay_cause_detailed_pr IS NOT NULL THEN
    IF :problem_desc_pr IS NULL THEN
      raise_application_error(-20002,
                              ''��ʾ������������ࡢ����ԭ����ࡢ����ԭ��ϸ����ֵ���������������'');
      ELSIF :responsible_dept_sec is null then
           raise_application_error(-20002,
                                  ''����ʧ�ܣ�����ԭ������д�����β���(2)������Ϊ�գ����顣'');
        ELSE
      SELECT max(ad.is_sup_exemption),
             max(ad.first_dept_id),
             max(ad.second_dept_id),
             max(ad.is_quality_problem)
        INTO v_is_sup_exemption,
             v_first_dept_id,
             v_second_dept_id,
             v_is_quality
        FROM scmdata.t_commodity_info tc
       INNER JOIN scmdata.t_abnormal_range_config ar
          ON tc.company_id = ar.company_id
         AND tc.category = ar.industry_classification
         AND tc.product_cate = ar.production_category
         AND instr('';'' || ar.product_subclass || '';'',
                   '';'' || tc.samll_category || '';'') > 0
         AND ar.pause = 0
       INNER JOIN scmdata.t_abnormal_dtl_config ad
          ON ar.company_id = ad.company_id
         AND ar.abnormal_config_id = ad.abnormal_config_id
         AND ad.pause = 0
       INNER JOIN scmdata.t_abnormal_config ab
          ON ab.company_id = ad.company_id
         AND ab.abnormal_config_id = ad.abnormal_config_id
         AND ab.pause = 0
       WHERE tc.company_id = :company_id
         AND tc.goo_id = :goo_id_pr
         AND ad.anomaly_classification = ''AC_DATE''
         AND ad.problem_classification = :delay_problem_class_pr
         AND ad.cause_classification = :delay_cause_class_pr
         AND ad.cause_detail = :delay_cause_detailed_pr;
      select max(t.dept_name)
          into v_dept_name
          from scmdata.sys_company_dept t
         where t.company_dept_id =
               nvl(:responsible_dept_sec, v_second_dept_id);
        if v_dept_name <> ''��'' then
      SELECT COUNT(1)
        INTO v_flag
        FROM (SELECT t.company_dept_id
                FROM scmdata.sys_company_dept t
               START WITH t.company_dept_id = v_first_dept_id
              CONNECT BY PRIOR t.company_dept_id = t.parent_id)
       WHERE company_dept_id = nvl(:responsible_dept_sec, v_second_dept_id);

      IF v_flag = 0 THEN
        raise_application_error(-20002,
                                ''����ʧ�ܣ����β���(2��)����Ϊ���β���(1��)���¼����ţ����飡'');

       END IF;
          else
          null;
        end if;
    END IF;
  ELSE
    IF :responsible_dept_sec IS NOT NULL THEN
      raise_application_error(-20002,
                              ''����ʧ�ܣ����β���(2��)��Ϊ��ʱ,����������ࡢ����ԭ����ࡢ����ԭ��ϸ�ֱ��'');
    ELSE
      NULL;
    END IF;
  END IF;
  
  
  IF :DEAL_FOLLOWER IS NOT NULL THEN 
    V_FLW_MANA := SCMDATA.PKG_DB_JOB.f_get_manager(p_company_id     => %DEFAULT_COMPANY_ID%,
                                        p_user_id        => :DEAL_FOLLOWER,
                                        p_company_job_id => ''1001005003005002'');
  END IF;                                       
    UPDATE scmdata.pt_ordered t
     SET t.delay_problem_class  = :delay_problem_class_pr,
         t.delay_cause_class    = :delay_cause_class_pr,
         t.delay_cause_detailed = :delay_cause_detailed_pr,
         t.problem_desc         = :problem_desc_pr,
         t.is_sup_duty          = v_is_sup_exemption,
         t.responsible_dept     = v_first_dept_id,
         t.responsible_dept_sec = nvl(:responsible_dept_sec,v_second_dept_id),
         t.is_quality           = v_is_quality,
         t.updated              = 1,      
         T.FLW_ORDER            = :DEAL_FOLLOWER,
         t.FLW_ORDER_MANAGER    = V_FLW_MANA,
         T.QC                   = :QC_ID,
         T.QC_MANAGER           = V_QC_DIRECTOR_ID,
         T.UPDATED_QC           = 1,
         t.update_id            = :user_id,
         t.update_time          = sysdate
   WHERE t.pt_ordered_id = :pt_ordered_id;
   
  end if;
  

  
  
    END IF;
END; ';
 
 
 
 

    END IF;
    RETURN V_SQL;
  END F_UPD_PTORDERED;

END PKG_PT_ORDERED;
/
