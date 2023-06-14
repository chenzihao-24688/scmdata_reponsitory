/*============================================*
* Author   : SANFU
* Created  : 2020-09-09 16:52:50
* ALERTER  : 
* ALERTER_TIME  : 
* Purpose  : 生成未建档的供应商档案
* Obj_Name    : CREATE_T_SUPPLIER_INFO
* Arg_Number  : 3
* P_COMPANY_ID : 当前企业编号
* P_FACTORY_ASK_ID : 申请单编号
* p_user_id:当前登录用户编号
*============================================*/

PROCEDURE create_t_supplier_info(p_company_id     VARCHAR2,
                                 p_factory_ask_id VARCHAR2,
                                 p_user_id        VARCHAR2) IS

  --来源都是 准入审核 待审核数据 =》 同意 =》生产待建档供应商数据
  v_company_id VARCHAR2(100) := p_company_id;

  v_supply_id VARCHAR2(100);

  v_flag NUMBER;

  fask_rec scmdata.t_factory_ask%ROWTYPE;

  cinfo_rec scmdata.sys_company%ROWTYPE;

  faskrp_rec scmdata.t_factory_report%ROWTYPE;

  --验厂申请单 意向合作范围
  CURSOR fask_scope_cur(p_factory_ask_id VARCHAR2) IS
    SELECT t.*
      FROM scmdata.t_ask_scope t
     WHERE t.object_id = p_factory_ask_id
       AND t.object_type = 'CA';

  --验厂报告 生产能力评估明细
  CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
    SELECT ra.*
      FROM scmdata.t_factory_report fr, scmdata.t_factory_report_ability ra
     WHERE fr.factory_report_id = ra.factory_report_id
       AND fr.factory_ask_id = p_factory_ask_id;

BEGIN
  --数据源
  --验厂申请单 （供应商基础信息）
  SELECT *
    INTO fask_rec
    FROM scmdata.t_factory_ask fa
   WHERE fa.factory_ask_id = p_factory_ask_id --外部带入 :factory_ask_id
     AND fa.factrory_ask_flow_status IN ('FA22', 'FA32')
     AND fa.company_id = v_company_id;

  --判断验厂方式
  --1.不验厂  来源只有验厂申请单

  IF fask_rec.factory_ask_type = 0 THEN
    --获取平台唯一编码
    v_supply_id := scmdata.pkg_plat_comm.f_getkeyid_plat('GY',
                                                         'seq_plat_code',
                                                         99);
    --1）基础信息
    INSERT INTO scmdata.t_supplier_info
      (supplier_info_id,
       company_id,
       supplier_info_origin_id,
       supplier_company_id,
       sharing_type,
       supplier_info_origin,
       pause,
       status,
       bind_status,
       supplier_company_name,
       supplier_company_abbreviation,
       social_credit_code,
       company_contact_person,
       company_contact_phone,
       cooperation_type,
       create_id,
       create_date,
       update_id,
       update_date)
    VALUES
      (v_supply_id,
       v_company_id,
       fask_rec.factory_ask_id,
       fask_rec.cooperation_company_id,
       '00',
       'AA',
       0,
       0,
       1,
       fask_rec.company_name,
       fask_rec.company_name,
       fask_rec.social_credit_code,
       fask_rec.contact_name,
       fask_rec.contact_phone,
       fask_rec.cooperation_type,
       p_user_id,
       SYSDATE,
       p_user_id,
       SYSDATE);
    --2）合作范围取=》意向合作范围
    FOR fscope_rec IN fask_scope_cur LOOP
      INSERT INTO t_coop_scope
        (coop_scope_id,
         supplier_info_id,
         company_id,
         coop_mode,
         coop_classification,
         coop_product_cate,
         coop_subcategory,
         create_id,
         create_time,
         update_id,
         update_time,
         remarks,
         pause,
         sharing_type)
      VALUES
        (scmdata.f_get_uuid(),
         v_supply_id,
         v_company_id,
         fask_rec.cooperation_model,
         fscope_rec.cooperation_classification,
         fscope_rec.production_mode,
         fscope_rec.cooperation_subcategory,
         fscope_rec.create_id,
         fscope_rec.create_time,
         fscope_rec.update_id,
         fscope_rec.update_time,
         '',
         0,
         '00');
    
    END LOOP;
  
  ELSE
    --2.验厂  来源：验厂报告，能力评估
    --判断是否有验厂报告
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_factory_report fr
     WHERE fr.factory_ask_id = fask_rec.factory_ask_id;
    --验厂报告
    IF v_flag > 0 THEN
      --获取平台唯一编码
      v_supply_id := scmdata.pkg_plat_comm.f_getkeyid_plat('GY',
                                                           'seq_plat_code',
                                                           99);
    
      --1）基础信息
      INSERT INTO scmdata.t_supplier_info
        (supplier_info_id,
         company_id,
         supplier_info_origin_id,
         supplier_company_id,
         sharing_type,
         supplier_info_origin,
         pause,
         status,
         bind_status,
         supplier_company_name,
         supplier_company_abbreviation,
         social_credit_code,
         company_contact_person,
         company_contact_phone,
         cooperation_type,
         create_id,
         create_date,
         update_id,
         update_date)
      VALUES
        (v_supply_id,
         v_company_id,
         fask_rec.factory_ask_id,
         fask_rec.cooperation_company_id,
         '00',
         'AA',
         0,
         0,
         1,
         fask_rec.company_name,
         fask_rec.company_name,
         fask_rec.social_credit_code,
         fask_rec.contact_name,
         fask_rec.contact_phone,
         fask_rec.cooperation_type,
         p_user_id,
         SYSDATE,
         p_user_id,
         SYSDATE);
    
      --2）合作范围取 =》验厂报告 生产能力评估明细(符合)
      FOR faskrp_ability_rec IN faskrp_ability_cur(fask_rec.factory_ask_id) LOOP
        --只有生产能力评估明细(符合)才能进入合作范围
        IF faskrp_ability_rec.ability_result = '符合' THEN
          --能力评估明细
          INSERT INTO t_coop_scope
            (coop_scope_id,
             supplier_info_id,
             company_id,
             coop_mode,
             coop_classification,
             coop_product_cate,
             coop_subcategory,
             create_id,
             create_time,
             update_id,
             update_time,
             remarks,
             pause,
             sharing_type)
          VALUES
            (scmdata.f_get_uuid(),
             v_supply_id,
             v_company_id,
             fask_rec.cooperation_model,
             faskrp_ability_rec.cooperation_classification,
             faskrp_ability_rec.cooperation_product_cate,
             faskrp_ability_rec.cooperation_subcategory,
             faskrp_ability_rec.create_id,
             faskrp_ability_rec.create_time,
             faskrp_ability_rec.update_id,
             faskrp_ability_rec.update_time,
             '',
             0,
             '00');
        ELSE
          NULL;
        END IF;
      END LOOP;
    
    ELSE
      NULL;
    END IF;
  END IF;
END create_t_supplier_info;
