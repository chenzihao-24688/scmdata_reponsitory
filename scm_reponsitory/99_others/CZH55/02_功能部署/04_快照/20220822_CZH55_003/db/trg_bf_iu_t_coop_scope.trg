CREATE OR REPLACE TRIGGER trg_bf_iu_t_coop_scope
  BEFORE INSERT OR UPDATE ON scmdata.t_coop_scope
  FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  vo_log_id          VARCHAR2(32);
  v_company_id       VARCHAR2(32) := :new.company_id;
  v_update_id        VARCHAR2(32) := :new.update_id;
  v_supplier_info_id VARCHAR2(32) := :new.supplier_info_id;
  v_memo_desc        VARCHAR2(256);
  v_status           INT;
  v_company_province VARCHAR2(32);
  v_company_city     VARCHAR2(32);
  v_coop_scope_id    VARCHAR2(32);
BEGIN
  SELECT MAX(t.status)
    INTO v_status
    FROM scmdata.t_supplier_info t
   WHERE t.supplier_info_id = v_supplier_info_id
     AND t.company_id = v_company_id;
  --供应商已建档才记录日志
  IF v_status = 1 THEN
    SELECT MAX(t.group_dict_name) || '-' || MAX(a.group_dict_name) memo_desc
      INTO v_memo_desc
      FROM scmdata.sys_group_dict t
     INNER JOIN scmdata.sys_group_dict a
        ON a.group_dict_type = t.group_dict_value
     WHERE t.group_dict_type = 'PRODUCT_TYPE'
       AND t.group_dict_value = :new.coop_classification
       AND a.group_dict_value = :new.coop_product_cate;
  
    IF inserting THEN
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                             p_apply_module       => 'a_supp_161_1',
                                             p_base_table         => 't_coop_scope',
                                             p_apply_pk_id        => v_supplier_info_id,
                                             p_action_type        => 'INSERT',
                                             p_log_type           => '02',
                                             p_is_logs            => 0,
                                             p_log_msg            => '新增：' ||
                                                                     v_memo_desc,
                                             p_user_id            => v_update_id,
                                             p_operate_company_id => v_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    
    ELSIF updating THEN
      --更新所在分组
      IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.coop_classification ||
                                                   :old.coop_product_cate,
                                                   :new.coop_classification ||
                                                   :new.coop_product_cate) = 0 THEN
        --合作范围第一条记录                                     
        SELECT MAX(va.coop_scope_id),
               MAX(va.company_province),
               MAX(va.company_city)
          INTO v_coop_scope_id, v_company_province, v_company_city
          FROM (SELECT row_number() over(ORDER BY sa.create_time) rn,
                       sp.company_province,
                       sp.company_city,
                       sa.coop_scope_id
                  FROM scmdata.t_supplier_info sp
                 INNER JOIN scmdata.t_coop_scope sa
                    ON sa.company_id = sp.company_id
                   AND sa.supplier_info_id = sp.supplier_info_id
                 WHERE sa.supplier_info_id = v_supplier_info_id
                   AND sa.company_id = v_company_id) va
         WHERE va.rn = 1;
        --判断是否相等 
        IF :new.coop_scope_id = v_coop_scope_id THEN
          pkg_supplier_info.p_update_group_name(p_company_id       => v_company_id,
                                                p_supplier_info_id => v_supplier_info_id,
                                                p_is_by_pick       => 1,
                                                p_province         => v_company_province,
                                                p_city             => v_company_city);
        END IF;
      
      END IF;
      --状态
      IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.pause, :new.pause) = 0 THEN
        scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                               p_apply_module       => 'a_supp_161_1',
                                               p_base_table         => 't_coop_scope',
                                               p_apply_pk_id        => v_supplier_info_id,
                                               p_action_type        => 'UPDATE',
                                               p_log_id             => vo_log_id,
                                               p_log_type           => '01',
                                               p_field_desc         => '状态',
                                               p_operate_field      => 'pause',
                                               p_field_type         => 'INT',
                                               p_old_code           => :old.pause,
                                               p_new_code           => :new.pause,
                                               p_old_value          => CASE
                                                                         WHEN :old.pause = 1 THEN
                                                                          '停用'
                                                                         WHEN :old.pause = 0 THEN
                                                                          '启用'
                                                                         ELSE
                                                                          NULL
                                                                       END,
                                               p_new_value          => CASE
                                                                         WHEN :new.pause = 1 THEN
                                                                          '停用'
                                                                         WHEN :new.pause = 0 THEN
                                                                          '启用'
                                                                         ELSE
                                                                          NULL
                                                                       END,
                                               p_memo               => '03',
                                               p_memo_desc          => v_memo_desc,
                                               p_user_id            => v_update_id,
                                               p_operate_company_id => v_company_id,
                                               p_seq_no             => 2,
                                               po_log_id            => vo_log_id);
        --拼接日志
        IF vo_log_id IS NOT NULL THEN
          scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id        => v_company_id,
                                                    p_log_id            => vo_log_id,
                                                    p_is_logsmsg        => 1,
                                                    p_is_splice_fields  => 0,
                                                    p_is_show_memo_desc => 1);
        END IF;
      END IF;
      IF scmdata.pkg_plat_log.f_is_check_fields_eq(:old.coop_classification ||
                                                   :old.coop_product_cate,
                                                   :new.coop_classification ||
                                                   :new.coop_product_cate) = 0 THEN
        --分类、生产类别
        scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => v_company_id,
                                               p_apply_module       => 'a_supp_161_1',
                                               p_base_table         => 't_coop_scope',
                                               p_apply_pk_id        => v_supplier_info_id,
                                               p_action_type        => 'UPDATE',
                                               p_log_type           => '02',
                                               p_is_logs            => 0,
                                               p_log_msg            => '修改：' ||
                                                                       v_memo_desc,
                                               p_user_id            => v_update_id,
                                               p_operate_company_id => v_company_id,
                                               p_seq_no             => 3,
                                               po_log_id            => vo_log_id);
      
      END IF;
    END IF;
  END IF;
  COMMIT;
END trg_bf_iu_t_coop_scope;
/
