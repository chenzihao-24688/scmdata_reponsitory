CREATE OR REPLACE TRIGGER scmdata.trg_af_iu_supplier_group_area_config
  AFTER INSERT OR UPDATE OF province_id, city_id, pause, group_type ON scmdata.t_supplier_group_area_config
  FOR EACH ROW
DECLARE
  --v_group_area_config_id VARCHAR2(256);
  v_group_name VARCHAR2(256);
BEGIN

  IF inserting OR updating THEN
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
                               AND sa.supplier_info_id = sp.supplier_info_id
                             WHERE sp.company_id = :new.company_id) va
                     WHERE va.rn = 1) LOOP
    
      IF instr(';' || :new.province_id || ';',
               ';' || sup_rec.company_province || ';') > 0 AND
         instr(';' || :new.city_id || ';',
               ';' || sup_rec.company_city || ';') > 0 AND :new.pause = 1 AND
         :new.group_type = 'GROUP_AREA' THEN
        SELECT MAX(bb.group_config_id)
          INTO v_group_name
          FROM scmdata.t_supplier_group_category_config bb
         WHERE bb.pause = 1
           AND instr(';' || bb.cooperation_classification || ';',
                     ';' || sup_rec.coop_classification || ';') > 0
           AND instr(';' || bb.cooperation_product_cate || ';',
                     ';' || sup_rec.coop_product_cate || ';') > 0
           AND instr(bb.area_config_id, :new.group_area_config_id) > 0;
      
        IF v_group_name IS NOT NULL THEN
          UPDATE scmdata.t_supplier_info t
             SET t.group_name        = v_group_name,
                 t.group_name_origin = 'AA',
                 t.update_id         = :new.update_id,
                 t.update_date       = SYSDATE
           WHERE t.supplier_info_id = sup_rec.supplier_info_id
             AND t.company_id = sup_rec.company_id;
        ELSE
          CONTINUE;        
        END IF;
      ELSE
        CONTINUE; 
        /*IF sup_rec.group_name_origin = 'AA' THEN
          UPDATE scmdata.t_supplier_info t
             SET t.group_name        = v_group_name,
                 t.group_name_origin = 'AA',
                 t.update_id         = :new.update_id,
                 t.update_date       = SYSDATE
           WHERE t.supplier_info_id = sup_rec.supplier_info_id
             AND t.company_id = sup_rec.company_id;
        ELSE
          CONTINUE;
        END IF;*/
      END IF;
    END LOOP;
  
  ELSE
    NULL;
  END IF;

END trg_af_iu_supplier_group_area_config;
/
/
