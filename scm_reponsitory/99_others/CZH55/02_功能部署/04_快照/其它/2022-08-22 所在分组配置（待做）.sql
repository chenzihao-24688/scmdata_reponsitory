CREATE OR REPLACE TRIGGER trg_af_iu_supplier_group_category_config
  AFTER INSERT OR UPDATE OF cooperation_classification, cooperation_product_cate, area_config_id, pause ON scmdata.t_supplier_group_category_config
  FOR EACH ROW
DECLARE
  v_cnt                        INT;
  v_gc_pause                   INT;
  v_pause                      INT;
  v_other_fields_change_flag   INT;
  v_pause_flag                 INT;
  v_area_config_id             VARCHAR2(256);
  v_cooperation_classification VARCHAR2(256);
  v_cooperation_product_cate   VARCHAR2(256);
BEGIN
  SELECT MAX(t.pause)
    INTO v_gc_pause
    FROM scmdata.t_supplier_group_config t
   WHERE t.group_config_id = :new.group_config_id
     AND t.company_id = :new.company_id;
  IF v_gc_pause = 0 THEN
    NULL;
  ELSE
  
    IF inserting OR updating THEN
      v_other_fields_change_flag := scmdata.pkg_plat_log.f_is_check_fields_eq(:old.cooperation_classification ||
                                                                              :old.cooperation_product_cate ||
                                                                              :old.area_config_id,
                                                                              :new.cooperation_classification ||
                                                                              :new.cooperation_product_cate ||
                                                                              :new.area_config_id);
      --判断配置是否停用
      v_pause_flag := scmdata.pkg_plat_log.f_is_check_fields_eq(:old.pause,
                                                                :new.pause);
      --停用，则直接根据条件 刷新对应供应商分组
      --条件：供应商分组是否手填
      --是，则不作操作
      --否，赋值为空     
      
      --启用，   则根据条件 刷新满足条件的供应商分组，无须校验是否手填
      
      --如果启用，则还需进行一下操作  行
      --判断配置中其它字段是否有改变（字段的新增、修改、删除）
      --找全部供应商去匹配类别+区域
      
      
      
      IF v_pause_flag = 0 THEN
        v_area_config_id             := :old.area_config_id;
        v_cooperation_classification := :old.cooperation_classification;
        v_cooperation_product_cate   := :old.cooperation_product_cate;

      END IF;
    
      FOR sup_rec IN (SELECT va.coop_classification,
                             va.coop_product_cate,
                             va.supplier_info_id,
                             va.company_province,
                             va.company_city,
                             va.company_id,
                             va.group_name_origin
                        FROM (SELECT sa.coop_classification,
                                     sa.coop_product_cate,
                                     sp.supplier_info_id,
                                     sp.company_province,
                                     sp.company_city,
                                     sp.company_id,
                                     sp.group_name_origin,
                                     row_number() over(PARTITION BY sp.supplier_info_id, sp.company_id ORDER BY sa.create_time DESC) rn
                                FROM scmdata.t_supplier_info sp
                               INNER JOIN scmdata.t_coop_scope sa
                                  ON sa.company_id = sp.company_id
                                 AND sa.supplier_info_id =
                                     sp.supplier_info_id
                               WHERE sp.company_id = :new.company_id
                                 AND sp.supplier_code = 'C00002') va
                       WHERE va.rn = 1) LOOP
      
        SELECT COUNT(1)
          INTO v_cnt
          FROM scmdata.t_supplier_group_area_config ee
         WHERE ee.group_type = 'GROUP_AREA'
           AND ee.company_id = sup_rec.company_id
           AND instr(v_area_config_id, ee.group_area_config_id) > 0
           AND (instr(';' || ee.province_id || ';',
                      ';' || sup_rec.company_province || ';') > 0 AND
               instr(';' || ee.city_id || ';',
                      ';' || sup_rec.company_city || ';') > 0);
      
        IF v_cnt > 0 THEN
          SELECT (CASE
                   WHEN instr(';' || v_cooperation_classification || ';',
                              ';' || sup_rec.coop_classification || ';') > 0 THEN
                    1
                   ELSE
                    0
                 END) + (CASE
                   WHEN instr(';' || v_cooperation_product_cate || ';',
                              ';' || sup_rec.coop_product_cate || ';') > 0 THEN
                    1
                   ELSE
                    0
                 END)
            INTO v_cnt
            FROM dual;
        
          IF v_cnt >= 2 THEN
            IF :new.pause = 1 THEN
              --启用
              UPDATE scmdata.t_supplier_info t
                 SET t.group_name        = v_group_config_id,
                     t.group_name_origin = 'AA',
                     t.update_id         = :new.update_id,
                     t.update_date       = SYSDATE
               WHERE t.supplier_info_id = sup_rec.supplier_info_id
                 AND t.company_id = sup_rec.company_id;
            ELSE
              --停用
              IF sup_rec.group_name_origin = 'AA' THEN
                UPDATE scmdata.t_supplier_info t
                   SET t.group_name        = NULL,
                       t.group_name_origin = 'AA',
                       t.update_id         = :new.update_id,
                       t.update_date       = SYSDATE
                 WHERE t.supplier_info_id = sup_rec.supplier_info_id
                   AND t.company_id = sup_rec.company_id;
              ELSE
                CONTINUE;
              END IF;
            END IF;
            
            
          ELSE
            CONTINUE;
          END IF;
        ELSE
          CONTINUE;
        END IF;     
      END LOOP;
      
      
    ELSE
      NULL;
    END IF;
  END IF;

END trg_af_iu_supplier_group_category_config;
