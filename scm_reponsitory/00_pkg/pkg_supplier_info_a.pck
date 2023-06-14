CREATE OR REPLACE PACKAGE SCMDATA.pkg_supplier_info_a IS

  -- Author  : SANFU
  -- Created : 2022/12/30 9:56:43
  -- Purpose : 供应商档案

  --查询供应商档案详情
  FUNCTION f_query_supp_info(p_company_id     VARCHAR2,
                             p_supp_id        VARCHAR2,
                             p_is_delay_query INT DEFAULT 0) RETURN CLOB;

  --绩效记录
  FUNCTION f_query_t_supplier_perform(p_supp_id VARCHAR2) RETURN CLOB;

  --查询 T_PERSON_CONFIG_SUP
  FUNCTION f_query_t_person_config_sup(p_company_id VARCHAR2,
                                       p_supp_id    VARCHAR2) RETURN CLOB;

  --新增 T_PERSON_CONFIG_SUP
  PROCEDURE p_insert_t_person_config_sup(p_t_per_rec scmdata.t_person_config_sup%ROWTYPE);

  --修改 T_PERSON_CONFIG_SUP
  PROCEDURE p_update_t_person_config_sup(p_t_per_rec scmdata.t_person_config_sup%ROWTYPE);

  --删除 T_PERSON_CONFIG_SUP
  PROCEDURE p_delete_t_person_config_sup(p_t_per_rec scmdata.t_person_config_sup%ROWTYPE);

  --查询 T_MACHINE_EQUIPMENT_SUP
  FUNCTION f_query_t_machine_equipment_sup(p_company_id VARCHAR2,
                                           p_supp_id    VARCHAR2) RETURN CLOB;
  --新增 修改校验
  PROCEDURE p_check_t_machine_equipment_sup(p_t_mac_rec t_machine_equipment_sup%ROWTYPE);

  --新增 T_MACHINE_EQUIPMENT_SUP
  PROCEDURE p_insert_t_machine_equipment_sup(p_t_mac_rec scmdata.t_machine_equipment_sup%ROWTYPE);

  --修改 T_MACHINE_EQUIPMENT_SUP
  PROCEDURE p_update_t_machine_equipment_sup(p_t_mac_rec scmdata.t_machine_equipment_sup%ROWTYPE);

  --删除 T_MACHINE_EQUIPMENT_SUP
  PROCEDURE p_delete_t_machine_equipment_sup(p_t_mac_rec scmdata.t_machine_equipment_sup%ROWTYPE);

  --查询 t_quality_control_sup
  FUNCTION f_query_t_quality_control_sup(p_company_id VARCHAR2,
                                         p_supp_id    VARCHAR2) RETURN CLOB;

  --新增 t_quality_control_sup
  PROCEDURE p_insert_t_quality_control_sup(p_t_qua_rec scmdata.t_quality_control_sup%ROWTYPE);

  --修改 t_quality_control_sup
  PROCEDURE p_update_t_quality_control_sup(p_t_qua_rec scmdata.t_quality_control_sup%ROWTYPE);

  --删除校验
  PROCEDURE p_check_t_machine_equipment_sup_by_delete(p_orgin VARCHAR2);

  --删除 t_quality_control_sup
  PROCEDURE p_delete_t_quality_control_sup(p_t_qua_rec scmdata.t_quality_control_sup%ROWTYPE);

  --验厂记录
  FUNCTION f_query_t_factory_report(p_company_id VARCHAR2,
                                    p_supp_id    VARCHAR2) RETURN CLOB;

  --绩效记录
  FUNCTION f_query_t_performance_evaluation_report(p_company_id VARCHAR2,
                                                   p_supp_id    VARCHAR2)
    RETURN CLOB;

  --合同记录
  FUNCTION f_query_t_contract_info(p_company_id VARCHAR2,
                                   p_supp_id    VARCHAR2) RETURN CLOB;

  --新增供应商时，同步生成人员、机器配置
  PROCEDURE p_generate_person_machine_config(p_company_id VARCHAR2,
                                             p_user_id    VARCHAR2,
                                             p_sup_id     VARCHAR2);

  --准入时，同步验厂申请时生成的人员、机器配置
  PROCEDURE p_generate_person_machine_config_fa(p_company_id     VARCHAR2,
                                                p_user_id        VARCHAR2,
                                                p_factory_ask_id VARCHAR2,
                                                p_supp_id        VARCHAR2);
  --准入时，同步验厂报告时生成的人员、机器配置、品控体系
  PROCEDURE p_generate_person_machine_quality_config_fr(p_company_id        VARCHAR2,
                                                        p_user_id           VARCHAR2,
                                                        p_factory_report_id VARCHAR2,
                                                        p_supp_id           VARCHAR2);
  --人员配置保存
  --同步更新主表中生产信息的”总人数“、”车位人数“、”成型人数_鞋类“、”打版能力“、”面料采购能力“
  PROCEDURE p_generate_supp_product_info(p_company_id VARCHAR2,
                                         p_supp_id    VARCHAR2);

  --新增档案、档案详情编辑修改是否本厂字段
  PROCEDURE p_generate_t_coop_factory_by_iu(p_company_id VARCHAR2,
                                            p_supp_id    VARCHAR2,
                                            p_user_id    VARCHAR2);
END pkg_supplier_info_a;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_supplier_info_a IS
  --查询供应商档案详情
  FUNCTION f_query_supp_info(p_company_id     VARCHAR2,
                             p_supp_id        VARCHAR2,
                             p_is_delay_query INT DEFAULT 0) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
  WITH group_dict AS
   (SELECT t.group_dict_type,
           t.group_dict_value,
           t.group_dict_name,
           t.group_dict_id,
           t.parent_id
      FROM scmdata.sys_group_dict t
     WHERE t.pause = 0)
  SELECT --基本信息 
   sp.supplier_company_name sp_sup_company_name_y,
   sp.supplier_company_abbreviation sp_sup_company_abb_y,
   sp.social_credit_code sp_social_credit_code_y,
   sp.supplier_code sp_supplier_code_n,
   sp.inside_supplier_code sp_inside_supplier_code_n,
   sp.company_regist_date sp_company_regist_date_y,
   sp.company_province,
   sp.company_city,
   sp.company_county,
   province || city || county sp_location_area_y,
   sp.company_vill ar_company_vill_y,
   dv.vill ar_company_vill_desc_y,
   sp.company_address sp_company_address_y,
   sp.group_name sp_group_name_n,
   sp.legal_representative sp_legal_represent_n,
   sp.company_contact_phone sp_company_contact_phone_n,
   sp.fa_contact_name sp_contact_name_y,
   sp.fa_contact_phone sp_contact_phone_y,
   sp.company_type sp_company_type_y,
   gda.group_dict_name sp_company_type_desc_y,
   sp.is_our_factory ar_is_our_factory_y,
   sp.factroy_area sp_factroy_area_y,
   sp.remarks sp_remarks_n,
   --生产信息
   sp.product_type sp_product_type_y,
   gde.group_dict_name sp_product_type_desc_y,
   sp.brand_type sp_brand_type_n,
   sp.cooperation_brand,
   (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
      FROM group_dict t
      LEFT JOIN group_dict b
        ON t.group_dict_type = 'COOPERATION_BRAND'
       AND t.group_dict_id = b.parent_id
       AND instr(';' || sp.brand_type || ';',
                 ';' || t.group_dict_value || ';') > 0
       AND instr(';' || sp.cooperation_brand || ';',
                 ';' || b.group_dict_value || ';') > 0) sp_coop_brand_desc_n,
   sp.product_link sp_product_link_n,
   sp.product_line sp_product_line_n,
   sp.product_line_num sp_product_line_num_n,
   sp.quality_step sp_quality_step_y,
   sp.work_hours_day sp_work_hours_day_y,
   sp.worker_total_num sp_worker_total_num_y,
   sp.worker_num sp_worker_num_y,
   sp.machine_num sp_machine_num_y,
   sp.form_num sp_form_num_y,
   decode(sp.product_efficiency, NULL, '80', sp.product_efficiency) sp_product_efficiency_y,
   sp.pattern_cap sp_pattern_cap_y,
   sp.fabric_purchase_cap sp_fabric_purchase_cap_y,
   sp.fabric_check_cap sp_fabric_check_cap_y,
   --sp.cost_step cost_step,
   --合作信息
   sp.pause sp_coop_state_y,
   nvl2(sp.supplier_company_id, '已注册', '未注册') sp_regist_status_n,
   decode(sp.bind_status, 1, '已绑定', '未绑定') sp_bind_status_n,
   sp.cooperation_type sp_cooperation_type_y,
   sp.cooperation_model sp_cooperation_model_y,
   --因多字段级联问题，需特殊处理
   REPLACE((SELECT listagg(gdb.group_dict_name, ';') within GROUP(ORDER BY gdb.group_dict_value)
             FROM group_dict gdb
            WHERE gdb.group_dict_type = 'SUPPLY_TYPE'
              AND instr(sp.cooperation_model, gdb.group_dict_value) > 0),
           ';',
           ' ') sp_coop_model_desc_y,
   sp.coop_position sp_coop_position_n,
   sp.pay_term ar_pay_term_n,
   --附件资料
   sp.certificate_file  sp_certificate_file_y,
   sp.supplier_gate     sp_supplier_gate_n,
   sp.supplier_office   sp_supplier_office_n,
   sp.supplier_site     sp_supplier_site_n,
   sp.supplier_product  sp_supplier_product_n,
   sp.other_information sp_other_information_n,
   --其他
   sp.supplier_info_id,
   sp.company_id,
   sp.supplier_info_origin_id,
   sp.supplier_info_origin,
   sp.status
 FROM scmdata.t_supplier_info sp
    LEFT JOIN scmdata.t_factory_ask fa
      ON sp.supplier_info_origin_id = fa.factory_ask_id
    LEFT JOIN scmdata.dic_province p
      ON p.provinceid = sp.company_province
    LEFT JOIN scmdata.dic_city c
      ON c.cityno = sp.company_city
    LEFT JOIN scmdata.dic_county dc
      ON dc.countyid = sp.company_county
    LEFT JOIN dic_village dv
      ON dv.countyid = dc.countyid
     AND dv.villid = sp.company_vill
    LEFT JOIN scmdata.sys_company fc
      ON fc.company_id = sp.supplier_company_id
   INNER JOIN group_dict ga
      ON sp.cooperation_type = ga.group_dict_value
     AND ga.group_dict_type = 'COOPERATION_TYPE'
   LEFT JOIN group_dict gda
      ON gda.group_dict_type = 'COMPANY_TYPE'
     AND gda.group_dict_value = sp.company_type
    LEFT JOIN group_dict gde
      ON gde.group_dict_type = 'FA_PRODUCT_TYPE'
     AND gde.group_dict_value = sp.product_type
    LEFT JOIN group_dict gd
      ON gd.group_dict_type = 'COOPERATION_BRAND'
     AND gd.group_dict_value = sp.cooperation_brand
     WHERE sp.company_id = ']' || p_company_id || q'[']' || (CASE
               WHEN p_is_delay_query = 1 THEN
                q'[ AND sp.status = 0 ]' ||
                ' AND (ceil(TO_NUMBER(SYSDATE - sp.create_date)*(24*60)) <= 20 or ceil(TO_NUMBER(SYSDATE - sp.update_date)*(24*60)) <= 20) '
               ELSE
                q'[ AND sp.supplier_info_id = ']' || p_supp_id || q'[']'
             END);
    RETURN v_sql;
  END f_query_supp_info;

  --绩效记录
  FUNCTION f_query_t_supplier_perform(p_supp_id VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT a.sp_record_id,
           a.supplier_info_id,
           a.company_id,
           a.kaoh_limit,
           a.buh_svg_limit,
           a.order_content_rate,
           a.order_ontime_rate,
           a.store_return_rate,
           a.shop_return_rate,
           a.qoute_rate,
           a.rale_qoute_rate,
           a.custom_prior,
           a.account_cap,
           a.response_qs
      FROM t_supplier_perform a
     WHERE a.supplier_info_id = ']' || p_supp_id || q'['
       AND a.company_id = %default_company_id%]';
    RETURN v_sql;
  END f_query_t_supplier_perform;

  --查询 T_PERSON_CONFIG_SUP
  FUNCTION f_query_t_person_config_sup(p_company_id VARCHAR2,
                                       p_supp_id    VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT t.person_config_id,
       t.company_id,
       t.person_role_id ar_person_role_n,
       t.department_id  ar_department_n,
       t.person_job_id  ar_person_job_n,
       t.apply_category_id ar_apply_cate_n,
       t.job_state         ar_job_state_n,
       t.person_num        ar_person_num_n,
       t.remarks           ar_remarks_n
  FROM t_person_config_sup t
 WHERE t.supplier_info_id = ']' || p_supp_id || q'['
   AND t.company_id = ']' || p_company_id || q'['
   ORDER BY t.seqno ASC]';
    RETURN v_sql;
  END f_query_t_person_config_sup;

  --新增 T_PERSON_CONFIG_SUP
  PROCEDURE p_insert_t_person_config_sup(p_t_per_rec scmdata.t_person_config_sup%ROWTYPE) IS
  BEGIN
    INSERT INTO t_person_config_sup
      (person_config_id, company_id, person_role_id, department_id,
       person_job_id, apply_category_id, job_state, person_num, seqno, pause,
       remarks, update_id, update_time, create_id, create_time,
       supplier_info_id)
    VALUES
      (p_t_per_rec.person_config_id, p_t_per_rec.company_id,
       p_t_per_rec.person_role_id, p_t_per_rec.department_id,
       p_t_per_rec.person_job_id, p_t_per_rec.apply_category_id,
       p_t_per_rec.job_state, p_t_per_rec.person_num, p_t_per_rec.seqno,
       p_t_per_rec.pause, p_t_per_rec.remarks, p_t_per_rec.update_id,
       p_t_per_rec.update_time, p_t_per_rec.create_id,
       p_t_per_rec.create_time, p_t_per_rec.supplier_info_id);
  END p_insert_t_person_config_sup;

  --修改 T_PERSON_CONFIG_SUP
  PROCEDURE p_update_t_person_config_sup(p_t_per_rec scmdata.t_person_config_sup%ROWTYPE) IS
  BEGIN
    UPDATE t_person_config_sup t
       SET t.person_num  = p_t_per_rec.person_num,
           t.remarks     = p_t_per_rec.remarks,
           t.update_id   = p_t_per_rec.update_id,
           t.update_time = p_t_per_rec.update_time
     WHERE t.person_config_id = p_t_per_rec.person_config_id;
  END p_update_t_person_config_sup;

  --删除 T_PERSON_CONFIG_SUP
  PROCEDURE p_delete_t_person_config_sup(p_t_per_rec scmdata.t_person_config_sup%ROWTYPE) IS
  BEGIN
    DELETE FROM t_person_config_sup t
     WHERE t.person_config_id = p_t_per_rec.person_config_id;
  END p_delete_t_person_config_sup;

  --查询 T_MACHINE_EQUIPMENT_SUP
  FUNCTION f_query_t_machine_equipment_sup(p_company_id VARCHAR2,
                                           p_supp_id    VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT t.machine_equipment_id,
       t.company_id,
       t.equipment_category_id ar_equipment_cate_n,
       t.equipment_name ar_equipment_name_y,
       t.machine_num ar_machine_num_n,
       t.remarks,
       t.orgin orgin_val,
       decode(t.orgin, 'AA', '系统配置', 'MA', '手动新增') orgin
  FROM t_machine_equipment_sup t
 WHERE t.supplier_info_id = ']' || p_supp_id || q'['
   AND t.company_id = ']' || p_company_id || q'['
   ORDER BY t.create_time ASC]';
    RETURN v_sql;
  END f_query_t_machine_equipment_sup;

  --新增 修改校验
  PROCEDURE p_check_t_machine_equipment_sup(p_t_mac_rec t_machine_equipment_sup%ROWTYPE) IS
    v_cnt INT;
  BEGIN
    SELECT COUNT(1)
      INTO v_cnt
      FROM scmdata.t_machine_equipment_sup t
     WHERE t.machine_equipment_id <> p_t_mac_rec.machine_equipment_id
       AND t.supplier_info_id = p_t_mac_rec.supplier_info_id
       AND t.equipment_name = p_t_mac_rec.equipment_name;
    IF v_cnt > 0 THEN
      raise_application_error(-20002, '【设备名称】不可重复！');
    END IF;
  END p_check_t_machine_equipment_sup;

  --新增 T_MACHINE_EQUIPMENT_SUP
  PROCEDURE p_insert_t_machine_equipment_sup(p_t_mac_rec scmdata.t_machine_equipment_sup%ROWTYPE) IS
  BEGIN
    INSERT INTO t_machine_equipment_sup
      (machine_equipment_id, company_id, equipment_category_id,
       equipment_name, seqno, orgin, pause, remarks, update_id, update_time,
       create_id, create_time, supplier_info_id, machine_num)
    VALUES
      (p_t_mac_rec.machine_equipment_id, p_t_mac_rec.company_id,
       p_t_mac_rec.equipment_category_id, p_t_mac_rec.equipment_name,
       p_t_mac_rec.seqno, p_t_mac_rec.orgin, p_t_mac_rec.pause,
       p_t_mac_rec.remarks, p_t_mac_rec.update_id, p_t_mac_rec.update_time,
       p_t_mac_rec.create_id, p_t_mac_rec.create_time,
       p_t_mac_rec.supplier_info_id, p_t_mac_rec.machine_num);
  END p_insert_t_machine_equipment_sup;

  --修改 T_MACHINE_EQUIPMENT_SUP
  PROCEDURE p_update_t_machine_equipment_sup(p_t_mac_rec scmdata.t_machine_equipment_sup%ROWTYPE) IS
  BEGIN
    UPDATE t_machine_equipment_sup t
       SET t.equipment_category_id = p_t_mac_rec.equipment_category_id,
           t.equipment_name        = p_t_mac_rec.equipment_name,
           t.machine_num           = p_t_mac_rec.machine_num,
           t.remarks               = p_t_mac_rec.remarks,
           t.update_id             = p_t_mac_rec.update_id,
           t.update_time           = p_t_mac_rec.update_time
     WHERE t.machine_equipment_id = p_t_mac_rec.machine_equipment_id;
  END p_update_t_machine_equipment_sup;
  --删除校验
  PROCEDURE p_check_t_machine_equipment_sup_by_delete(p_orgin VARCHAR2) IS
  BEGIN
    IF p_orgin = 'AA' THEN
      raise_application_error(-20002, '系统配置的数据不允许删除！');
    ELSE
      NULL;
    END IF;
  END p_check_t_machine_equipment_sup_by_delete;

  --删除 T_MACHINE_EQUIPMENT_SUP
  PROCEDURE p_delete_t_machine_equipment_sup(p_t_mac_rec scmdata.t_machine_equipment_sup%ROWTYPE) IS
  BEGIN
    p_check_t_machine_equipment_sup_by_delete(p_orgin => p_t_mac_rec.orgin);
    DELETE FROM t_machine_equipment_sup t
     WHERE t.machine_equipment_id = p_t_mac_rec.machine_equipment_id;
  END p_delete_t_machine_equipment_sup;

  --查询 t_quality_control_sup
  FUNCTION f_query_t_quality_control_sup(p_company_id VARCHAR2,
                                         p_supp_id    VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[
SELECT t.quality_control_id,
       t.company_id,
       t.department_id           fr_department_n,
       tc.company_dict_name      fr_department_desc_n,
       t.quality_control_link_id fr_quality_control_link_n,
       tb.company_dict_name      fr_quality_control_link_desc_n,
       t.is_quality_control      fr_is_quality_control_y,
       t.remarks
  FROM scmdata.t_quality_control_sup t
 INNER JOIN scmdata.sys_company_dict tc
    ON tc.company_id = t.company_id
   AND tc.company_dict_type = 'QUALITY_CONTROL_DEPT'
   AND tc.company_dict_value = t.department_id
 INNER JOIN scmdata.sys_company_dict tb
    ON tb.company_id = t.company_id
   AND tb.company_dict_type = t.department_id
   AND tb.company_dict_value = t.quality_control_link_id
  WHERE t.supplier_info_id = ']' || p_supp_id || q'['
   AND t.company_id = ']' || p_company_id || q'[']';
    RETURN v_sql;
  END f_query_t_quality_control_sup;

  --新增 t_quality_control_sup
  PROCEDURE p_insert_t_quality_control_sup(p_t_qua_rec scmdata.t_quality_control_sup%ROWTYPE) IS
  BEGIN
    INSERT INTO t_quality_control_sup
      (quality_control_id, company_id, department_id,
       quality_control_link_id, seqno, pause, remarks, update_id,
       update_time, create_id, create_time, supplier_info_id,
       is_quality_control)
    VALUES
      (p_t_qua_rec.quality_control_id, p_t_qua_rec.company_id,
       p_t_qua_rec.department_id, p_t_qua_rec.quality_control_link_id,
       p_t_qua_rec.seqno, p_t_qua_rec.pause, p_t_qua_rec.remarks,
       p_t_qua_rec.update_id, p_t_qua_rec.update_time, p_t_qua_rec.create_id,
       p_t_qua_rec.create_time, p_t_qua_rec.supplier_info_id,
       p_t_qua_rec.is_quality_control);
  END p_insert_t_quality_control_sup;

  --修改 t_quality_control_sup
  PROCEDURE p_update_t_quality_control_sup(p_t_qua_rec scmdata.t_quality_control_sup%ROWTYPE) IS
  BEGIN
    UPDATE t_quality_control_sup t
       SET t.department_id           = p_t_qua_rec.department_id,
           t.quality_control_link_id = p_t_qua_rec.quality_control_link_id,
           t.seqno                   = p_t_qua_rec.seqno,
           t.pause                   = p_t_qua_rec.pause,
           t.is_quality_control      = p_t_qua_rec.is_quality_control,
           t.remarks                 = p_t_qua_rec.remarks,
           t.update_id               = p_t_qua_rec.update_id,
           t.update_time             = p_t_qua_rec.update_time
     WHERE t.quality_control_id = p_t_qua_rec.quality_control_id;
  END p_update_t_quality_control_sup;

  --删除 t_quality_control_sup
  PROCEDURE p_delete_t_quality_control_sup(p_t_qua_rec scmdata.t_quality_control_sup%ROWTYPE) IS
  BEGIN
    DELETE FROM t_quality_control_sup t
     WHERE t.quality_control_id = p_t_qua_rec.quality_control_id;
  END p_delete_t_quality_control_sup;

  --绩效记录
  FUNCTION f_query_t_performance_evaluation_report(p_company_id VARCHAR2,
                                                   p_supp_id    VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT *
  FROM (SELECT (t.year || '年第' || t.quarter || '季度') assessment_period,
               t.category classifications,
               t.category_id,
               t.factory_abbreviation production_supplier,
               t.order_money orders_money,
               t.delivery_money order_delivery_money,
               t.score,
               t.order_actualvalue,
               t.order_score,
               t.warehouse_actualvalue,
               t.warehouse_score,
               t.finalcheck_actualvalue,
               t.finalcheck_score,
               t.overall_assessment_actualvalue,
               t.overall_assessment_score overall_score,
               t.major_quality_problem,
               t.integrity,
               t.finance,
               t.create_time,
               t.supplier_code,
               t.company_id
          FROM scmdata.t_performance_evaluation_report_quarter t
         WHERE t.company_id = ']' || p_company_id || q'['
        UNION ALL
        SELECT (t.year || '年') assessment_period,
               t.category classifications,
               t.category_id,
               t.factory_abbreviation production_supplier,
               t.order_money orders_money,
               t.delivery_money order_delivery_money,
               t.score,
               t.order_actualvalue,
               t.order_score,
               t.warehouse_actualvalue,
               t.warehouse_score,
               t.finalcheck_actualvalue,
               t.finalcheck_score,
               t.overall_assessment_actualvalue,
               t.overall_assessment_score overall_score,
               t.major_quality_problem,
               t.integrity,
               t.finance,
               t.create_time,
               t.supplier_code,
               t.company_id
          FROM scmdata.t_performance_evaluation_report_year t
         WHERE t.company_id = ']' || p_company_id ||
             q'[') v
 WHERE (v.supplier_code, v.company_id) IN
       (SELECT sp.supplier_code, sp.company_id
          FROM scmdata.t_supplier_info sp
         WHERE sp.supplier_info_id = ']' || p_supp_id || q'['
           AND sp.company_id = ']' || p_company_id ||
             q'[')
 ORDER BY v.create_time DESC]';
    RETURN v_sql;
  END f_query_t_performance_evaluation_report;

  --验厂记录
  FUNCTION f_query_t_factory_report(p_company_id VARCHAR2,
                                    p_supp_id    VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[WITH company_user AS
     (SELECT t.company_user_name, t.user_id, t.company_id
        FROM scmdata.sys_company_user t
       WHERE t.company_id = ']' || p_company_id ||
             q'[')
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
                   '验厂报告详情' check_report,
                   nvl(fr.admit_result, 0) trialorder_type,
                   fa.factory_ask_id supplier_info_origin_id,
                   fr.factory_report_id
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
             WHERE sa.supplier_info_id = ']' || p_supp_id ||
             q'[')
       AND v.company_id = ']' || p_company_id || q'[']';
    RETURN v_sql;
  END f_query_t_factory_report;

  --合同记录
  FUNCTION f_query_t_contract_info(p_company_id VARCHAR2,
                                   p_supp_id    VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := q'[SELECT tc.contract_info_id,
         tc.supplier_info_id,
         tc.company_id,
         tc.contract_start_date,
         tc.contract_stop_date,
         tc.contract_sign_date,
         tc.contract_file       contract_file_sp,
         tc.contract_type,
         tc.contract_num,
         fc_a.nick_name         operator_name,
         tc.operate_time,
         fc_b.nick_name         change_name,
         tc.change_time
    FROM scmdata.t_contract_info tc
    LEFT JOIN scmdata.sys_company_user fc_a
      ON fc_a.user_id = tc.operator_id
    LEFT JOIN scmdata.sys_company_user fc_b
      ON fc_b.user_id = tc.change_id
     WHERE tc.supplier_info_id = ']' || p_supp_id || q'['
       AND tc.company_id = ']' || p_company_id || q'[']';
    RETURN v_sql;
  END f_query_t_contract_info;

  --新增供应商时，同步生成人员、机器配置
  PROCEDURE p_generate_person_machine_config(p_company_id VARCHAR2,
                                             p_user_id    VARCHAR2,
                                             p_sup_id     VARCHAR2) IS
    v_flag INT := 0;
  BEGIN
    --人员配置
    DECLARE
      v_t_per_rec t_person_config_sup%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_person_config_sup t
       WHERE t.supplier_info_id = p_sup_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_per_rec IN (SELECT *
                              FROM scmdata.t_person_config t
                             WHERE t.company_id = p_company_id
                             ORDER BY t.seqno ASC) LOOP
          v_t_per_rec.person_config_id  := scmdata.f_get_uuid();
          v_t_per_rec.company_id        := p_company_id;
          v_t_per_rec.person_role_id    := p_t_per_rec.person_role_id;
          v_t_per_rec.department_id     := p_t_per_rec.department_id;
          v_t_per_rec.person_job_id     := p_t_per_rec.person_job_id;
          v_t_per_rec.apply_category_id := p_t_per_rec.apply_category_id;
          v_t_per_rec.job_state         := p_t_per_rec.job_state;
          v_t_per_rec.person_num        := 0;
          v_t_per_rec.seqno             := p_t_per_rec.seqno;
          v_t_per_rec.pause             := 0;
          v_t_per_rec.remarks           := NULL;
          v_t_per_rec.update_id         := p_user_id;
          v_t_per_rec.update_time       := SYSDATE;
          v_t_per_rec.create_id         := p_user_id;
          v_t_per_rec.create_time       := SYSDATE;
          v_t_per_rec.supplier_info_id  := p_sup_id;
          scmdata.pkg_supplier_info_a.p_insert_t_person_config_sup(p_t_per_rec => v_t_per_rec);
        END LOOP;
        --人员配置保存后，同步更新主表中生产信息的”总人数“、”车位人数“、”成型人数_鞋类“、”打版能力“、”面料采购能力“
        p_generate_supp_product_info(p_company_id => p_company_id,
                                     p_supp_id    => p_sup_id);
      END IF;
    END person_config;
  
    --机器配置
    DECLARE
      v_t_mac_rec t_machine_equipment_sup%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_machine_equipment_sup t
       WHERE t.supplier_info_id = p_sup_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_mac_rec IN (SELECT *
                              FROM scmdata.t_machine_equipment t
                             WHERE t.company_id = p_company_id
                               AND t.template_type = 'TYPE_00'
                             ORDER BY t.seqno ASC) LOOP
          v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
          v_t_mac_rec.company_id            := p_company_id;
          v_t_mac_rec.equipment_category_id := p_t_mac_rec.equipment_category_id;
          v_t_mac_rec.equipment_name        := p_t_mac_rec.equipment_name;
          v_t_mac_rec.machine_num           := 0;
          v_t_mac_rec.seqno                 := p_t_mac_rec.seqno;
          v_t_mac_rec.orgin                 := 'AA';
          v_t_mac_rec.pause                 := 0;
          v_t_mac_rec.remarks               := NULL;
          v_t_mac_rec.update_id             := p_user_id;
          v_t_mac_rec.update_time           := SYSDATE;
          v_t_mac_rec.create_id             := p_user_id;
          v_t_mac_rec.create_time           := SYSDATE;
          v_t_mac_rec.supplier_info_id      := p_sup_id;
        
          scmdata.pkg_supplier_info_a.p_insert_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
        END LOOP;
      END IF;
    END machine_config;
  END p_generate_person_machine_config;

  --准入时，同步验厂申请时生成的人员、机器配置
  PROCEDURE p_generate_person_machine_config_fa(p_company_id     VARCHAR2,
                                                p_user_id        VARCHAR2,
                                                p_factory_ask_id VARCHAR2,
                                                p_supp_id        VARCHAR2) IS
    v_flag INT := 0;
  BEGIN
    --人员配置
    DECLARE
      v_t_per_rec t_person_config_sup%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_person_config_sup t
       WHERE t.supplier_info_id = p_supp_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_per_rec IN (SELECT *
                              FROM scmdata.t_person_config_fa t
                             WHERE t.company_id = p_company_id
                               AND t.factory_ask_id = p_factory_ask_id
                             ORDER BY t.seqno ASC) LOOP
          v_t_per_rec.person_config_id  := scmdata.f_get_uuid();
          v_t_per_rec.company_id        := p_company_id;
          v_t_per_rec.person_role_id    := p_t_per_rec.person_role_id;
          v_t_per_rec.department_id     := p_t_per_rec.department_id;
          v_t_per_rec.person_job_id     := p_t_per_rec.person_job_id;
          v_t_per_rec.apply_category_id := p_t_per_rec.apply_category_id;
          v_t_per_rec.job_state         := p_t_per_rec.job_state;
          v_t_per_rec.person_num        := p_t_per_rec.person_num;
          v_t_per_rec.seqno             := p_t_per_rec.seqno;
          v_t_per_rec.pause             := 0;
          v_t_per_rec.remarks           := p_t_per_rec.remarks;
          v_t_per_rec.update_id         := p_user_id;
          v_t_per_rec.update_time       := SYSDATE;
          v_t_per_rec.create_id         := p_user_id;
          v_t_per_rec.create_time       := SYSDATE;
          v_t_per_rec.supplier_info_id  := p_supp_id;
          scmdata.pkg_supplier_info_a.p_insert_t_person_config_sup(p_t_per_rec => v_t_per_rec);
        END LOOP;
        --人员配置保存后，同步更新主表中生产信息的”总人数“、”车位人数“、”成型人数_鞋类“、”打版能力“、”面料采购能力“
        p_generate_supp_product_info(p_company_id => p_company_id,
                                     p_supp_id    => p_supp_id);
      END IF;
    END person_config;
  
    --机器配置
    DECLARE
      v_t_mac_rec t_machine_equipment_sup%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_machine_equipment_sup t
       WHERE t.supplier_info_id = p_supp_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_mac_rec IN (SELECT *
                              FROM scmdata.t_machine_equipment_fa t
                             WHERE t.company_id = p_company_id
                               AND t.factory_ask_id = p_factory_ask_id
                             ORDER BY t.seqno ASC) LOOP
          v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
          v_t_mac_rec.company_id            := p_company_id;
          v_t_mac_rec.equipment_category_id := p_t_mac_rec.equipment_category_id;
          v_t_mac_rec.equipment_name        := p_t_mac_rec.equipment_name;
          v_t_mac_rec.machine_num           := p_t_mac_rec.machine_num;
          v_t_mac_rec.seqno                 := p_t_mac_rec.seqno;
          v_t_mac_rec.orgin                 := p_t_mac_rec.orgin;
          v_t_mac_rec.pause                 := 0;
          v_t_mac_rec.remarks               := p_t_mac_rec.remarks;
          v_t_mac_rec.update_id             := p_user_id;
          v_t_mac_rec.update_time           := SYSDATE;
          v_t_mac_rec.create_id             := p_user_id;
          v_t_mac_rec.create_time           := SYSDATE;
          v_t_mac_rec.supplier_info_id      := p_supp_id;
        
          scmdata.pkg_supplier_info_a.p_insert_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
        END LOOP;
      END IF;
    END machine_config;
  END p_generate_person_machine_config_fa;

  --准入时，同步验厂报告时生成的人员、机器配置、品控体系
  PROCEDURE p_generate_person_machine_quality_config_fr(p_company_id        VARCHAR2,
                                                        p_user_id           VARCHAR2,
                                                        p_factory_report_id VARCHAR2,
                                                        p_supp_id           VARCHAR2) IS
    v_flag INT := 0;
  BEGIN
    --人员配置
    DECLARE
      v_t_per_rec t_person_config_sup%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_person_config_sup t
       WHERE t.supplier_info_id = p_supp_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_per_rec IN (SELECT *
                              FROM scmdata.t_person_config_fr t
                             WHERE t.company_id = p_company_id
                               AND t.factory_report_id = p_factory_report_id
                             ORDER BY t.seqno ASC) LOOP
          v_t_per_rec.person_config_id  := scmdata.f_get_uuid();
          v_t_per_rec.company_id        := p_company_id;
          v_t_per_rec.person_role_id    := p_t_per_rec.person_role_id;
          v_t_per_rec.department_id     := p_t_per_rec.department_id;
          v_t_per_rec.person_job_id     := p_t_per_rec.person_job_id;
          v_t_per_rec.apply_category_id := p_t_per_rec.apply_category_id;
          v_t_per_rec.job_state         := p_t_per_rec.job_state;
          v_t_per_rec.person_num        := p_t_per_rec.person_num;
          v_t_per_rec.seqno             := p_t_per_rec.seqno;
          v_t_per_rec.pause             := 0;
          v_t_per_rec.remarks           := p_t_per_rec.remarks;
          v_t_per_rec.update_id         := p_user_id;
          v_t_per_rec.update_time       := SYSDATE;
          v_t_per_rec.create_id         := p_user_id;
          v_t_per_rec.create_time       := SYSDATE;
          v_t_per_rec.supplier_info_id  := p_supp_id;
          scmdata.pkg_supplier_info_a.p_insert_t_person_config_sup(p_t_per_rec => v_t_per_rec);
        END LOOP;
        --人员配置保存后，同步更新主表中生产信息的”总人数“、”车位人数“、”成型人数_鞋类“、”打版能力“、”面料采购能力“
        p_generate_supp_product_info(p_company_id => p_company_id,
                                     p_supp_id    => p_supp_id);
      END IF;
    END person_config;
  
    --机器配置
    DECLARE
      v_t_mac_rec t_machine_equipment_sup%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_machine_equipment_sup t
       WHERE t.supplier_info_id = p_supp_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_mac_rec IN (SELECT *
                              FROM scmdata.t_machine_equipment_fr t
                             WHERE t.company_id = p_company_id
                               AND t.factory_report_id = p_factory_report_id
                             ORDER BY t.seqno ASC) LOOP
          v_t_mac_rec.machine_equipment_id  := scmdata.f_get_uuid();
          v_t_mac_rec.company_id            := p_company_id;
          v_t_mac_rec.equipment_category_id := p_t_mac_rec.equipment_category_id;
          v_t_mac_rec.equipment_name        := p_t_mac_rec.equipment_name;
          v_t_mac_rec.machine_num           := p_t_mac_rec.machine_num;
          v_t_mac_rec.seqno                 := p_t_mac_rec.seqno;
          v_t_mac_rec.orgin                 := p_t_mac_rec.orgin;
          v_t_mac_rec.pause                 := 0;
          v_t_mac_rec.remarks               := p_t_mac_rec.remarks;
          v_t_mac_rec.update_id             := p_user_id;
          v_t_mac_rec.update_time           := SYSDATE;
          v_t_mac_rec.create_id             := p_user_id;
          v_t_mac_rec.create_time           := SYSDATE;
          v_t_mac_rec.supplier_info_id      := p_supp_id;
        
          scmdata.pkg_supplier_info_a.p_insert_t_machine_equipment_sup(p_t_mac_rec => v_t_mac_rec);
        END LOOP;
      END IF;
    END machine_config;
  
    --品控体系
    DECLARE
      v_t_qua_rec t_quality_control_sup%ROWTYPE;
    BEGIN
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_quality_control_sup t
       WHERE t.supplier_info_id = p_supp_id
         AND t.company_id = p_company_id;
    
      IF v_flag > 0 THEN
        NULL;
      ELSE
        FOR p_t_qua_rec IN (SELECT *
                              FROM scmdata.t_quality_control_fr t
                             WHERE t.company_id = p_company_id
                               AND t.factory_report_id = p_factory_report_id
                             ORDER BY t.seqno ASC) LOOP
          v_t_qua_rec.quality_control_id      := scmdata.f_get_uuid(); --品控体系模板主键ID
          v_t_qua_rec.company_id              := p_company_id; --企业ID
          v_t_qua_rec.department_id           := p_t_qua_rec.department_id; --部门ID
          v_t_qua_rec.quality_control_link_id := p_t_qua_rec.quality_control_link_id; --品控环节ID
          v_t_qua_rec.seqno                   := p_t_qua_rec.seqno; --序号
          v_t_qua_rec.pause                   := p_t_qua_rec.pause; --是否禁用(0正常,1禁用)
          v_t_qua_rec.is_quality_control      := p_t_qua_rec.is_quality_control;
          v_t_qua_rec.remarks                 := p_t_qua_rec.remarks; --备注
          v_t_qua_rec.update_id               := p_t_qua_rec.update_id; --更新人
          v_t_qua_rec.update_time             := SYSDATE; --更新时间
          v_t_qua_rec.create_id               := p_t_qua_rec.create_id; --创建人
          v_t_qua_rec.create_time             := SYSDATE; --创建时间
          v_t_qua_rec.supplier_info_id        := p_supp_id; --供应商档案ID
        
          --新增 t_quality_control_sup
          pkg_supplier_info_a.p_insert_t_quality_control_sup(p_t_qua_rec => v_t_qua_rec);
        END LOOP;
      END IF;
    END;
  
  END p_generate_person_machine_quality_config_fr;

  --人员配置保存
  --同步更新主表中生产信息的”总人数“、”车位人数“、”成型人数_鞋类“、”打版能力“、”面料采购能力“
  PROCEDURE p_generate_supp_product_info(p_company_id VARCHAR2,
                                         p_supp_id    VARCHAR2) IS
    v_person_num_total INT;
    v_person_num_cw    INT;
    v_person_num_form  INT;
    v_person_num_db    INT;
    v_person_num_cg    INT;
  BEGIN
    SELECT SUM(t.person_num) person_num_total,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_01_01_01' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_cw,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_01_01_08' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_form,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_00_01_00' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_db,
           SUM(CASE
                 WHEN t.person_job_id = 'ROLE_03_01_00' THEN
                  t.person_num
                 ELSE
                  0
               END) person_num_cg
      INTO v_person_num_total,
           v_person_num_cw,
           v_person_num_form,
           v_person_num_db,
           v_person_num_cg
      FROM scmdata.t_person_config_sup t
     WHERE t.supplier_info_id = p_supp_id
       AND t.company_id = p_company_id;
  
    UPDATE scmdata.t_supplier_info t
       SET t.worker_total_num    = v_person_num_total,
           t.worker_num          = v_person_num_cw,
           t.form_num            = v_person_num_form,
           t.pattern_cap = (CASE
                             WHEN v_person_num_db > 0 THEN
                              '00'
                             ELSE
                              '01'
                           END),
           t.fabric_purchase_cap = (CASE
                                     WHEN v_person_num_cg > 0 THEN
                                      '00'
                                     ELSE
                                      '01'
                                   END)
     WHERE t.supplier_info_id = p_supp_id
       AND t.company_id = p_company_id;
  END p_generate_supp_product_info;

  --新增档案、档案详情编辑修改是否本厂字段
  PROCEDURE p_generate_t_coop_factory_by_iu(p_company_id VARCHAR2,
                                            p_supp_id    VARCHAR2,
                                            p_user_id    VARCHAR2) IS
    v_sup_rec         scmdata.t_supplier_info%ROWTYPE;
    v_fac_rec         scmdata.t_coop_factory%ROWTYPE;
    v_coop_factory_id VARCHAR2(32);
    v_cnt             INT;
    v_where           CLOB;
  BEGIN
    SELECT t.*
      INTO v_sup_rec
      FROM scmdata.t_supplier_info t
     WHERE t.supplier_info_id = p_supp_id
       AND t.company_id = p_company_id;
  
    SELECT COUNT(1), MAX(t.coop_factory_id)
      INTO v_cnt, v_coop_factory_id
      FROM scmdata.t_coop_factory t
     WHERE t.supplier_info_id = p_supp_id
       AND t.company_id = p_company_id
       AND t.factory_type = '00';
    --主档字段-是否本厂
    IF v_sup_rec.is_our_factory = 1 THEN
      --判断是否存在本厂
      IF v_cnt > 0 THEN
        v_where := q'[ where company_id = ']' || p_company_id ||
                   q'[' and coop_factory_id   = ']' || v_coop_factory_id ||
                   q'[']';
        scmdata.pkg_plat_comm.p_pause(p_table       => 'T_COOP_FACTORY',
                                      p_pause_field => 'PAUSE',
                                      p_where       => v_where,
                                      p_user_id     => p_user_id,
                                      p_status      => (CASE
                                                         WHEN v_sup_rec.pause IN
                                                              (0, 2) THEN
                                                          0
                                                         ELSE
                                                          1
                                                       END),
                                      p_is_tips     => 0);
      
        UPDATE scmdata.t_coop_factory t
           SET t.pause_type = 'OF'
         WHERE t.coop_factory_id = v_coop_factory_id;
      ELSE
        v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
        v_fac_rec.company_id       := p_company_id;
        v_fac_rec.fac_sup_info_id  := p_supp_id;
        v_fac_rec.factory_code     := v_sup_rec.supplier_code;
        v_fac_rec.factory_name     := v_sup_rec.supplier_company_name;
        v_fac_rec.factory_type     := '00';
        v_fac_rec.pause            := v_sup_rec.pause;
        v_fac_rec.create_id        := p_user_id;
        v_fac_rec.create_time      := SYSDATE;
        v_fac_rec.update_id        := p_user_id;
        v_fac_rec.update_time      := SYSDATE;
        v_fac_rec.memo             := v_sup_rec.remarks;
        v_fac_rec.supplier_info_id := p_supp_id;
        scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);
      END IF;
    ELSE
      IF v_cnt > 0 THEN
        /*scmdata.pkg_supplier_info.p_coop_fac_pause(p_company_id      => p_company_id,
        p_coop_factory_id => v_coop_factory_id,
        p_user_id         => p_user_id,
        p_status          => 1);*/
        DELETE FROM scmdata.t_coop_factory t
         WHERE t.supplier_info_id = p_supp_id
           AND t.company_id = p_company_id
           AND t.coop_factory_id = v_coop_factory_id;
      ELSE
        NULL;
      END IF;
    END IF;
    --ZC314 ADD
    scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => p_user_id,
                                                  v_compid    => p_company_id,
                                                  v_tab       => 'SCMDATA.T_COOP_FACTORY',
                                                  v_viewtab   => NULL,
                                                  v_unqfields => 'COOP_FACTORY_ID,COMPANY_ID',
                                                  v_ckfields  => 'FACTORY_CODE,PAUSE,CREATE_ID,CREATE_TIME',
                                                  v_conds     => 'COOP_FACTORY_ID = ''' ||
                                                                 v_coop_factory_id ||
                                                                 ''' AND COMPANY_ID = ''' ||
                                                                 p_company_id || '''',
                                                  v_method    => 'UPD',
                                                  v_viewlogic => NULL,
                                                  v_queuetype => 'CAPC_SUPFILE_COOPFACINFO_IU');
  END p_generate_t_coop_factory_by_iu;
END pkg_supplier_info_a;
/

