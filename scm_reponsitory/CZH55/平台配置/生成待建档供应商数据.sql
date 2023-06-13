DECLARE
  --来源都是 准入审核 待审核数据 =》 同意 =》生产待建档供应商数据
  v_company_id VARCHAR2(100) := 'a972dd1ffe3b3a10e0533c281cac8fd7'; --当前默认企业

  v_cooperation_company_id VARCHAR2(100);

  v_supply_id VARCHAR2(100);

  v_flag NUMBER;

  fask_rec scmdata.t_factory_ask%ROWTYPE;

  cinfo_rec scmdata.sys_company%ROWTYPE;

  faskrp_rec scmdata.t_factory_report%ROWTYPE;

  --faskrp_ability_rec scmdata.t_factory_report_ability%ROWTYPE;

  CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
    SELECT ra.*
      FROM scmdata.t_factory_report fr, scmdata.t_factory_report_ability ra
     WHERE fr.factory_report_id = ra.factory_report_id
       AND fr.factory_ask_id = p_factory_ask_id;

BEGIN
  --数据源
  --验厂申请单
  SELECT *
    INTO fask_rec
    FROM scmdata.t_factory_ask fa
   WHERE fa.factory_ask_id = 'test_faid_02' --外部带入 :factory_ask_id 申请单编号
     AND fa.factrory_ask_flow_status = 'FA22'
     AND fa.company_id = v_company_id;

  IF fask_rec.origin = 'CA' THEN
    SELECT ar.company_id
      INTO v_cooperation_company_id
      FROM scmdata.t_ask_record ar
     WHERE ar.ask_record_id = fask_rec.ask_record_id;
  ELSIF fask_rec.origin = 'MA' THEN
    v_cooperation_company_id := fask_rec.cooperation_company_id;
  ELSE
    NULL;
  END IF;

  --企业基础资料
  SELECT *
    INTO cinfo_rec
    FROM scmdata.sys_company fc
   WHERE fc.company_id = v_cooperation_company_id;

  --判断验厂方式
  --1.不验厂 验厂申请单
  --基础信息
  IF fask_rec.factory_ask_type = 0 THEN
    v_supply_id := scmdata.f_get_uuid();
    INSERT INTO scmdata.t_supplier_info
      (supplier_info_id,
       company_id,
       supplier_info_origin_id,
       supplier_company_id,
       sharing_type,
       supplier_info_origin,
       pause,
       status,
       supplier_company_name,
       supplier_company_abbreviation,
       company_create_date,
       social_credit_code,
       company_contact_person,
       company_contact_phone,
       --能力评估
       cooperation_method,
       cooperation_model,
       cooperation_type,
       production_mode)
    VALUES
      (v_supply_id,
       v_company_id,
       fask_rec.factory_ask_id,
       cinfo_rec.company_id,
       '01',
       'AA',
       0,
       0,
       cinfo_rec.logn_name,
       cinfo_rec.company_name,
       cinfo_rec.create_time,
       cinfo_rec.licence_num,
       fask_rec.contact_name,
       fask_rec.contact_phone,
       --能力评估
       fask_rec.cooperation_method,
       fask_rec.cooperation_model,
       fask_rec.cooperation_type,
       fask_rec.production_mode);
  ELSE
    --验厂
    --判断是否有验厂报告
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_factory_report fr
     WHERE fr.factory_ask_id = fask_rec.factory_ask_id;
    --验厂报告
    IF v_flag > 0 THEN
      --基础信息
      v_supply_id := scmdata.f_get_uuid();
    
      SELECT *
        INTO faskrp_rec
        FROM scmdata.t_factory_report fr
       WHERE fr.factory_ask_id = fask_rec.factory_ask_id;
    
      /*      SELECT ra.*
       INTO faskrp_ability_rec
       FROM scmdata.t_factory_report         fr,
            scmdata.t_factory_report_ability ra
      WHERE fr.factory_report_id = ra.factory_report_id
        AND fr.factory_ask_id = fask_rec.factory_ask_id;*/
    
      INSERT INTO scmdata.t_supplier_info
        (supplier_info_id,
         company_id,
         supplier_info_origin_id,
         supplier_company_id,
         sharing_type,
         supplier_info_origin,
         pause,
         status,
         supplier_company_name,
         supplier_company_abbreviation,
         company_create_date,
         social_credit_code,
         company_contact_person,
         company_contact_phone,
         --能力评估
         cooperation_method,
         cooperation_model,
         cooperation_type,
         production_mode)
      VALUES
        (v_supply_id,
         v_company_id,
         fask_rec.factory_ask_id,
         cinfo_rec.company_id,
         '01',
         'AA',
         0,
         0,
         cinfo_rec.logn_name,
         cinfo_rec.company_name,
         cinfo_rec.create_time,
         cinfo_rec.licence_num,
         fask_rec.contact_name,
         fask_rec.contact_phone,
         --能力评估
         faskrp_rec.cooperation_method,
         faskrp_rec.cooperation_model,
         faskrp_rec.cooperation_type,
         faskrp_rec.production_mode);
    
      FOR faskrp_ability_rec IN faskrp_ability_cur(fask_rec.factory_ask_id) LOOP
        --能力评估明细
        INSERT INTO scmdata.t_supplier_ability
          (supplier_ability_id,
           company_id,
           supplier_info_id,
           cooperation_classification,
           cooperation_subcategory,
           original_design,
           development_proofing,
           materials_procurement,
           production_processing)
        VALUES
          (scmdata.f_get_uuid(),
           v_company_id,
           v_supply_id,
           faskrp_ability_rec.cooperation_classification,
           faskrp_ability_rec.cooperation_subcategory,
           faskrp_ability_rec.original_design,
           faskrp_ability_rec.development_proofing,
           faskrp_ability_rec.materials_procurement,
           faskrp_ability_rec.production_processing);
      
      END LOOP;
    
    ELSE
      NULL;
    END IF;
  END IF;
END;
