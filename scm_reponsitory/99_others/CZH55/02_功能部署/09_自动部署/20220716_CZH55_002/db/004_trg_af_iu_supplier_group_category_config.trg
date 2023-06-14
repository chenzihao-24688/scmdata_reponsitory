CREATE OR REPLACE TRIGGER scmdata.trg_af_iu_supplier_group_category_config
  AFTER INSERT OR UPDATE OF cooperation_classification, cooperation_product_cate, area_config_id, pause ON scmdata.t_supplier_group_category_config
  FOR EACH ROW
DECLARE
  v_cnt             INT;
  v_gc_pause        INT;
  v_group_config_id VARCHAR2(32);
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
      --ÅäÖÃÆôÍ££¬Ä¬ÈÏ¸³Öµ
      IF :new.pause = 1 THEN
        v_group_config_id := :new.group_config_id;
      ELSE
        v_group_config_id := NULL;
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
                                     row_number() over(PARTITION BY sp.supplier_info_id, sp.company_id ORDER BY sa.create_time) rn
                                FROM scmdata.t_supplier_info sp
                               INNER JOIN scmdata.t_coop_scope sa
                                  ON sa.company_id = sp.company_id
                                 AND sa.supplier_info_id =
                                     sp.supplier_info_id
                               WHERE sp.company_id = :new.company_id) va
                       WHERE va.rn = 1) LOOP
      
        SELECT COUNT(1)
          INTO v_cnt
          FROM scmdata.t_supplier_group_area_config ee
         WHERE ee.pause = 1
           AND ee.group_type = 'GROUP_AREA'
           AND ee.company_id = sup_rec.company_id
           AND instr(:new.area_config_id, ee.group_area_config_id) > 0
           AND (instr(';' || ee.province_id || ';',
                      ';' || sup_rec.company_province || ';') > 0 AND
               instr(';' || ee.city_id || ';',
                      ';' || sup_rec.company_city || ';') > 0);
      
        SELECT v_cnt + (CASE
                 WHEN instr(';' || :new.cooperation_classification || ';',
                            ';' || sup_rec.coop_classification || ';') > 0 THEN
                  1
                 ELSE
                  0
               END) + (CASE
                 WHEN instr(';' || :new.cooperation_product_cate || ';',
                            ';' || sup_rec.coop_product_cate || ';') > 0 THEN
                  1
                 ELSE
                  0
               END)
          INTO v_cnt
          FROM dual;
        IF v_cnt >= 3 THEN
        
          UPDATE scmdata.t_supplier_info t
             SET t.group_name        = v_group_config_id,
                 t.group_name_origin = 'AA',
                 t.update_id         = :new.update_id,
                 t.update_date       = SYSDATE
           WHERE t.supplier_info_id = sup_rec.supplier_info_id
             AND t.company_id = sup_rec.company_id;
        
        ELSE
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
      END LOOP;
    ELSE
      NULL;
    END IF;
  END IF;

END trg_af_iu_supplier_group_category_config;
/
/
