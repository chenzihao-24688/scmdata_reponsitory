CREATE OR REPLACE PACKAGE SCMDATA.pkg_pt_ordered IS

  -- Author  : DYY153
  -- Created : 2022/7/14 14:36:14
  -- Purpose : 订单交期数据表编辑更新
  --校验订单是否已封存/已结束
  PROCEDURE p_check_orders(p_pt_ordered_id VARCHAR2, p_type INT DEFAULT 1);
  --延期问题必填校验
  PROCEDURE p_check_delay_problems(p_company_id           VARCHAR2,
                                   p_goo_id               VARCHAR2,
                                   p_delay_problem_class  VARCHAR2,
                                   p_delay_cause_class    VARCHAR2,
                                   p_delay_cause_detailed VARCHAR2,
                                   p_problem_desc         VARCHAR2,
                                   p_responsible_dept_sec VARCHAR2,
                                   po_is_sup_exemption    OUT NUMBER,
                                   po_first_dept_id       OUT VARCHAR2,
                                   po_second_dept_id      OUT VARCHAR2,
                                   po_is_quality          OUT NUMBER);

  --czh 20220919 alter 更新订单交期底层表
  FUNCTION f_upd_ptordered RETURN CLOB;
  /*===================================================================

    根据入参用户id返回对应的update_sql
    入参：
         V_USERID ： 用户id
         V_COMPID ：企业id

  =====================================================================*/
/*  FUNCTION f_upd_ptordered(v_userid IN VARCHAR2, v_compid IN VARCHAR2)
    RETURN CLOB;*/

END pkg_pt_ordered;
/
CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_pt_ordered IS
  --校验订单是否已封存/已结束
  PROCEDURE p_check_orders(p_pt_ordered_id VARCHAR2, p_type INT DEFAULT 1) IS
    v_order_finish_time DATE;
    v_delivery_date     DATE;
  BEGIN
    NULL;
   /* SELECT MAX(t.order_finish_time), MAX(t.delivery_date)
      INTO v_order_finish_time, v_delivery_date
      FROM scmdata.pt_ordered t
     WHERE t.pt_ordered_id = p_pt_ordered_id;

    --CZH 20220805 修改 数据封存校验
    IF to_char(v_delivery_date, 'yyyy-mm') NOT IN
       (nvl(scmdata.pkg_db_job.f_get_month(trunc(SYSDATE, 'mm')),
            to_char(SYSDATE, 'yyyy-mm')),
        to_char(SYSDATE, 'yyyy-mm')) THEN
      raise_application_error(-20002, '保存失败！数据已封存，不可修改。');
    ELSE
      IF p_type = 1 THEN
        --订单结束校验
        --未结束不可修改
        IF v_order_finish_time IS NULL THEN
          raise_application_error(-20002,
                                  '保存失败！订单未结束不可修改，请到生产进度表修改。');
        END IF;
      ELSE
        NULL;
      END IF;
    END IF;*/
  END p_check_orders;

  --延期问题必填校验
  PROCEDURE p_check_delay_problems(p_company_id           VARCHAR2,
                                   p_goo_id               VARCHAR2,
                                   p_delay_problem_class  VARCHAR2,
                                   p_delay_cause_class    VARCHAR2,
                                   p_delay_cause_detailed VARCHAR2,
                                   p_problem_desc         VARCHAR2,
                                   p_responsible_dept_sec VARCHAR2,
                                   po_is_sup_exemption    OUT NUMBER,
                                   po_first_dept_id       OUT VARCHAR2,
                                   po_second_dept_id      OUT VARCHAR2,
                                   po_is_quality          OUT NUMBER) IS
    v_is_sup_exemption NUMBER;
    v_first_dept_id    VARCHAR2(100);
    v_second_dept_id   VARCHAR2(100);
    v_is_quality       NUMBER;
    v_flag             NUMBER;
    v_dept_name        VARCHAR2(100);
  BEGIN
    --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
    IF p_delay_problem_class IS NOT NULL AND
       p_delay_cause_class IS NOT NULL AND
       p_delay_cause_detailed IS NOT NULL THEN
      IF p_problem_desc IS NULL THEN
        raise_application_error(-20002,
                                '提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！');
      ELSIF p_responsible_dept_sec IS NULL THEN
        raise_application_error(-20002,
                                '保存失败！延期原因已填写，责任部门(2)级不能为空，请检查。');
      ELSE
        SELECT MAX(ad.is_sup_exemption),
               MAX(ad.first_dept_id),
               MAX(ad.second_dept_id),
               MAX(ad.is_quality_problem)
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
         WHERE tc.company_id = p_company_id
           AND tc.goo_id = p_goo_id
           AND ad.anomaly_classification = 'AC_DATE'
           AND ad.problem_classification = p_delay_problem_class
           AND ad.cause_classification = p_delay_cause_class
           AND ad.cause_detail = p_delay_cause_detailed;

        SELECT MAX(t.dept_name)
          INTO v_dept_name
          FROM scmdata.sys_company_dept t
         WHERE t.company_dept_id =
               nvl(p_responsible_dept_sec, v_second_dept_id);

        IF v_dept_name <> '无' THEN
          SELECT COUNT(1)
            INTO v_flag
            FROM (SELECT t.company_dept_id
                    FROM scmdata.sys_company_dept t
                   START WITH t.company_dept_id = v_first_dept_id
                  CONNECT BY PRIOR t.company_dept_id = t.parent_id)
           WHERE company_dept_id =
                 nvl(p_responsible_dept_sec, v_second_dept_id);

          IF v_flag = 0 THEN
            raise_application_error(-20002,
                                    '保存失败！责任部门(2级)必须为责任部门(1级)的下级部门，请检查！');

          END IF;
        ELSE
          NULL;
        END IF;
      END IF;
    ELSE
      IF p_responsible_dept_sec IS NOT NULL THEN
        raise_application_error(-20002,
                                '保存失败！责任部门(2级)不为空时,延期问题分类、延期原因分类、延期原因细分必填！');
      ELSE
        NULL;
      END IF;
    END IF;

    po_is_sup_exemption := v_is_sup_exemption;
    po_first_dept_id    := v_first_dept_id;
    po_second_dept_id   := v_second_dept_id;
    po_is_quality       := v_is_quality;

  END p_check_delay_problems;

  --czh 20220919 alter 更新订单交期底层表
  FUNCTION f_upd_ptordered RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[DECLARE
  v_is_sup_exemption NUMBER;
  v_first_dept_id    VARCHAR2(100);
  v_second_dept_id   VARCHAR2(100);
  v_is_quality       NUMBER;
BEGIN
  --校验订单是否已封存/已结束
  scmdata.pkg_pt_ordered.p_check_orders(p_pt_ordered_id => :pt_ordered_id);
  --延期问题必填校验
  scmdata.pkg_pt_ordered.p_check_delay_problems(p_company_id           => %default_company_id%,
                                                p_goo_id               => :goo_id_pr,
                                                p_delay_problem_class  => :delay_problem_class_pr,
                                                p_delay_cause_class    => :delay_cause_class_pr,
                                                p_delay_cause_detailed => :delay_cause_detailed_pr,
                                                p_problem_desc         => :problem_desc_pr,
                                                p_responsible_dept_sec => :responsible_dept_sec,
                                                po_is_sup_exemption    => v_is_sup_exemption,
                                                po_first_dept_id       => v_first_dept_id,
                                                po_second_dept_id      => v_second_dept_id,
                                                po_is_quality          => v_is_quality);

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
         t.update_time          = SYSDATE
   WHERE t.pt_ordered_id = :pt_ordered_id;
END;]';
    RETURN v_sql;
  END f_upd_ptordered;

/*--dyy 原代码 更新订单交期底层表  czh 因新需求 需注释
  FUNCTION f_upd_ptordered(v_userid IN VARCHAR2, v_compid IN VARCHAR2)
    RETURN CLOB IS

    v_num1 NUMBER;
    v_num2 NUMBER;
    --V_NUM3 NUMBER;
    v_sql CLOB;
  BEGIN
    --跟单
    SELECT scmdata.pkg_plat_comm.f_hasaction_application(v_userid,
                                                         v_compid,
                                                         'P013030104')
      INTO v_num1
      FROM dual;

    --QC
    SELECT scmdata.pkg_plat_comm.f_hasaction_application(v_userid,
                                                         v_compid,
                                                         'P013030105')
      INTO v_num2
      FROM dual;

    \*--问题原因
      SELECT SCMDATA.PKG_PLAT_COMM.F_HASACTION_APPLICATION(V_USERID,
                                                           V_COMPID,
                                                           'P013030106')
        INTO V_NUM3
        FROM DUAL;
    *\

    --跟单编辑跟单字段
    IF v_num1 = 1 AND v_num2 = 0 \*AND V_NUM3 = 0*\
     THEN
      v_sql := q'[DECLARE
  v_is_sup_exemption  NUMBER;
  v_first_dept_id     VARCHAR2(100);
  v_second_dept_id    VARCHAR2(100);
  v_is_quality        NUMBER;
  v_flag              NUMBER;
  v_order_finish_time DATE;
  v_delivery_date     DATE;
  v_dept_name         VARCHAR2(100);
  V_FLW_MANA          VARCHAR2(128);
BEGIN

  SELECT MAX(t.order_finish_time), MAX(t.delivery_date)
    INTO v_order_finish_time, v_delivery_date
    FROM scmdata.pt_ordered t
   WHERE t.pt_ordered_id = :pt_ordered_id;

  --CZH 20220805 修改 数据封存校验
  IF to_char(v_delivery_date, 'yyyy-mm') NOT IN (NVL(scmdata.pkg_db_job.f_get_month(trunc(SYSDATE, 'mm')),to_char(SYSDATE, 'yyyy-mm')),to_char(SYSDATE, 'yyyy-mm')) THEN
    raise_application_error(-20002, '保存失败！数据已封存，不可修改。');
  ELSE
    IF v_order_finish_time IS NULL THEN
      raise_application_error(-20002,
                              '保存失败！订单未结束不可修改，请到生产进度表修改。');
    END IF;
    --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
    IF :delay_problem_class_pr IS NOT NULL AND
       :delay_cause_class_pr IS NOT NULL AND
       :delay_cause_detailed_pr IS NOT NULL THEN
      IF :problem_desc_pr IS NULL THEN
        raise_application_error(-20002,
                                '提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！');
      ELSIF :responsible_dept_sec IS NULL THEN
        raise_application_error(-20002,
                                '保存失败！延期原因已填写，责任部门(2)级不能为空，请检查。');
      ELSE
        SELECT MAX(ad.is_sup_exemption),
               MAX(ad.first_dept_id),
               MAX(ad.second_dept_id),
               MAX(ad.is_quality_problem)
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
        SELECT MAX(t.dept_name)
          INTO v_dept_name
          FROM scmdata.sys_company_dept t
         WHERE t.company_dept_id =
               nvl(:responsible_dept_sec, v_second_dept_id);
        IF v_dept_name <> '无' THEN
          SELECT COUNT(1)
            INTO v_flag
            FROM (SELECT t.company_dept_id
                    FROM scmdata.sys_company_dept t
                   START WITH t.company_dept_id = v_first_dept_id
                  CONNECT BY PRIOR t.company_dept_id = t.parent_id)
           WHERE company_dept_id =
                 nvl(:responsible_dept_sec, v_second_dept_id);

          IF v_flag = 0 THEN
            raise_application_error(-20002,
                                    '保存失败！责任部门(2级)必须为责任部门(1级)的下级部门，请检查！');

          END IF;
        ELSE
          NULL;
        END IF;
      END IF;
    ELSE
      IF :responsible_dept_sec IS NOT NULL THEN
        raise_application_error(-20002,
                                '保存失败！责任部门(2级)不为空时,延期问题分类、延期原因分类、延期原因细分必填！');
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
           T.FLW_ORDER            = :DEAL_FOLLOWER,
           t.FLW_ORDER_MANAGER    = V_FLW_MANA,
           t.updated              = 1,
           t.update_id            = :user_id,
           t.update_time          = SYSDATE
     WHERE t.pt_ordered_id = :pt_ordered_id;
  END IF;
END;]';
      --QC
    ELSIF v_num1 = 0 AND v_num2 = 1 \*AND V_NUM3 = 0*\
     THEN
      v_sql := q'[
  DECLARE
  V_ORDER_FINISH_TIME DATE;
  V_DELIVERY_DATE     DATE;
  V_QC_DIRECTOR_ID    VARCHAR2(512);

BEGIN

  SELECT MAX(t.order_finish_time), MAX(t.delivery_date)
    INTO v_order_finish_time, v_delivery_date
    FROM scmdata.pt_ordered t
   WHERE t.pt_ordered_id = :pt_ordered_id;

  --CZH 20220805 修改 数据封存校验
  IF to_char(v_delivery_date, 'yyyy-mm') NOT IN (NVL(scmdata.pkg_db_job.f_get_month(trunc(SYSDATE, 'mm')),to_char(SYSDATE, 'yyyy-mm')),to_char(SYSDATE, 'yyyy-mm')) THEN
    raise_application_error(-20002, '保存失败！数据已封存，不可修改。');
  ELSE
  IF :QC_ID IS NOT NULL THEN
    V_QC_DIRECTOR_ID := SCMDATA.PKG_DB_JOB.f_get_manager_byconfig(p_company_id =>%DEFAULT_COMPANY_ID%,
                                                                  p_user_id  => :QC_ID);

     UPDATE SCMDATA.PT_ORDERED T
             SET T.QC = :QC_ID,
                 T.QC_MANAGER =V_QC_DIRECTOR_ID,
                 T.UPDATED_QC = 1,
                 t.update_id            = :user_id,
                 t.update_time          = sysdate
           WHERE T.PT_ORDERED_ID = :PT_ORDERED_ID;
    ELSE
      NULL;
   END IF;
 END IF;
END;]';

      --都可编辑
    ELSIF v_num1 = 1 AND v_num2 = 1 \*AND V_NUM3 = 0*\
     THEN
      v_sql := q'[DECLARE
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
  SELECT MAX(t.order_finish_time), MAX(t.delivery_date)
    INTO v_order_finish_time, v_delivery_date
    FROM scmdata.pt_ordered t
   WHERE t.pt_ordered_id = :pt_ordered_id;

  --CZH 20220805 修改 数据封存校验
  IF to_char(v_delivery_date, 'yyyy-mm') NOT IN (NVL(scmdata.pkg_db_job.f_get_month(trunc(SYSDATE, 'mm')),to_char(SYSDATE, 'yyyy-mm')),to_char(SYSDATE, 'yyyy-mm')) THEN
    raise_application_error(-20002, '保存失败！数据已封存，不可修改。');
  ELSE
   --当只有qc发生改变时不走校验
  IF NVL(:qc_id,'1')<>NVL(:old_qc_id,'1') AND NVL(:deal_follower,'1') = NVL(:old_deal_follower,'1')
      AND NVL(:problem_desc_pr,'1') = NVL(:old_problem_desc_pr,'1')
      AND NVL(:delay_problem_class_pr,'1') = NVL(:old_delay_problem_class_pr,'1')
      AND NVL(:delay_cause_class_pr,'1') = NVL(:old_delay_cause_class_pr,'1')
      AND NVL(:delay_cause_detailed_pr,'1') = NVL(:old_delay_cause_detailed_pr,'1') THEN

  IF :QC_ID IS NOT NULL THEN
    V_QC_DIRECTOR_ID := SCMDATA.PKG_DB_JOB.f_get_manager_byconfig(p_company_id =>%DEFAULT_COMPANY_ID%,
                                                                  p_user_id  => :QC_ID);
    ELSE
      NULL;
    END IF;
      UPDATE SCMDATA.PT_ORDERED T
             SET T.QC = :QC_ID,
                 T.QC_MANAGER =V_QC_DIRECTOR_ID,
                 T.UPDATED_QC = 1,
                 t.update_id            = :user_id,
                 t.update_time          = sysdate
           WHERE T.PT_ORDERED_ID = :PT_ORDERED_ID;

       --当只要有其他字段发生改变时需走校验
  ELSE
   IF v_order_finish_time is null then
    raise_application_error(-20002,
                            '保存失败！订单未结束不可修改跟单/延期问题相关字段，请到【订单管理】/【生产进度】修改。');
  end if;
  --增加校验逻辑：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填
  IF :delay_problem_class_pr IS NOT NULL AND
     :delay_cause_class_pr IS NOT NULL AND
     :delay_cause_detailed_pr IS NOT NULL THEN
    IF :problem_desc_pr IS NULL THEN
      raise_application_error(-20002,
                              '提示：延期问题分类、延期原因分类、延期原因细分有值，则问题描述必填！');
      ELSIF :responsible_dept_sec is null then
           raise_application_error(-20002,
                                  '保存失败！延期原因已填写，责任部门(2)级不能为空，请检查。');
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
        if v_dept_name <> '无' then
      SELECT COUNT(1)
        INTO v_flag
        FROM (SELECT t.company_dept_id
                FROM scmdata.sys_company_dept t
               START WITH t.company_dept_id = v_first_dept_id
              CONNECT BY PRIOR t.company_dept_id = t.parent_id)
       WHERE company_dept_id = nvl(:responsible_dept_sec, v_second_dept_id);

      IF v_flag = 0 THEN
        raise_application_error(-20002,
                                '保存失败！责任部门(2级)必须为责任部门(1级)的下级部门，请检查！');

       END IF;
          else
          null;
        end if;
    END IF;
  ELSE
    IF :responsible_dept_sec IS NOT NULL THEN
      raise_application_error(-20002,
                              '保存失败！责任部门(2级)不为空时,延期问题分类、延期原因分类、延期原因细分必填！');
    ELSE
      NULL;
    END IF;
  END IF;

  IF :DEAL_FOLLOWER IS NOT NULL THEN
    V_FLW_MANA := SCMDATA.PKG_DB_JOB.f_get_manager(p_company_id     => %DEFAULT_COMPANY_ID%,
                                        p_user_id        => :DEAL_FOLLOWER,
                                        p_company_job_id => '1001005003005002');
  END IF;

  IF :QC_ID IS NOT NULL THEN
    V_QC_DIRECTOR_ID := SCMDATA.PKG_DB_JOB.f_get_manager_byconfig(p_company_id =>%DEFAULT_COMPANY_ID%,
                                                                  p_user_id  => :QC_ID);
    ELSE
      NULL;
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
END; ]';
    END IF;
    RETURN v_sql;
  END f_upd_ptordered;*/

END pkg_pt_ordered;
/
