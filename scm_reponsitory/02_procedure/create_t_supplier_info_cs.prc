CREATE OR REPLACE PROCEDURE SCMDATA.create_t_supplier_info_cs(p_company_id     VARCHAR2,
                                   p_factory_ask_id VARCHAR2,
                                   p_user_id        VARCHAR2) IS

    --来源都是 准入审核 待审核数据 =》 同意 =》生产待建档供应商数据
    v_company_id VARCHAR2(100) := p_company_id;

    v_cooperation_company_id VARCHAR2(100);

    v_supply_id VARCHAR2(100);

    v_certificate_file VARCHAR2(4000);

    v_flag NUMBER;
    
    V_GROUP_NAME VARCHAR2(32);
    
    v_coop_state VARCHAR2(32);
    
    v_coop_position VARCHAR2(48);
    
    iv_supp_info scmdata.T_SUPPLIER_INFO%ROWTYPE;

    fask_rec scmdata.t_factory_ask%ROWTYPE;
    

    --验厂申请单 意向合作范围
    CURSOR fask_scope_cur(p_factory_ask_id VARCHAR2) IS
      SELECT t.*
        FROM scmdata.t_ask_scope t
       WHERE t.object_id = p_factory_ask_id
         AND t.object_type = 'CA';

    --验厂报告 生产能力评估明细
    CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
      SELECT ra.*
        FROM scmdata.t_factory_report         fr,
             scmdata.t_factory_report_ability ra
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

    
    ----获取分组信息   
    SELECT NVL(DD.GROUP_NAME, '')
     INTO V_GROUP_NAME
      FROM SCMDATA.T_FACTORY_ASK CC
     INNER JOIN (SELECT AA.GROUP_NAME, BB.PROVINCE_ID || BB.CITY_ID AS QUYU
                   FROM T_SUPPLIER_GROUP_CONFIG AA
                   LEFT JOIN T_SUPPLIER_GROUP_AREA_CONFIG BB
                     ON AA.GROUP_CONFIG_ID = BB.GROUP_CONFIG_ID) DD
        ON (CC.COMPANY_PROVINCE || CC.COMPANY_CITY) = DD.QUYU
     WHERE CC.FACTORY_ASK_ID = P_FACTORY_ASK_ID
       AND CC.COMPANY_ID = V_COMPANY_ID;
       
       
       
    ---区分合作定位   
    SELECT decode(COOPERATION_MODEL,'OF','外协厂','普通型')
      INTO v_coop_position
      FROM SCMDATA.T_FACTORY_REPORT FZ
     WHERE FZ.FACTORY_REPORT_ID = P_FACTORY_ASK_ID;
     
     
    ---区分合作状态   
    SELECT decode(IS_TRIALORDER,1,'COOP_01',2,'COOP_02','')
      INTO v_coop_state
      FROM SCMDATA.T_FACTORY_REPORT FV
     WHERE FV.FACTORY_REPORT_ID = P_FACTORY_ASK_ID;
     

    --供应商是否在平台注册，已在平台注册就通过社会统一信用代码取公司id
    SELECT MAX(fc.company_id)
      INTO v_cooperation_company_id
      FROM scmdata.sys_company fc
     WHERE fc.licence_num = fask_rec.social_credit_code;

    --营业执照
    SELECT tr.certificate_file
      INTO v_certificate_file
      FROM scmdata.t_ask_record tr
     WHERE tr.ask_record_id = fask_rec.ask_record_id;
     


    --判断验厂方式
    --1.不验厂  来源只有验厂申请单

    IF fask_rec.factory_ask_type = 0 THEN 
      --获取平台唯一编码
      v_supply_id := scmdata.pkg_plat_comm.f_getkeyid_plat('GY',
                                                           'seq_plat_code',
                                                           99);


      --1）基础信息   
      
    ---判断是否本厂   1 <---->   判断为外协厂
    IF fask_rec.com_manufacturer  = '1' THEN    
         iv_supp_info.supplier_info_id                    :=v_supply_id;
         iv_supp_info.company_id                          :=v_company_id;
         iv_supp_info.supplier_info_origin_id             :=fask_rec.factory_ask_id;
         iv_supp_info.supplier_company_id                 :=nvl(fask_rec.cooperation_company_id,v_cooperation_company_id);
         iv_supp_info.supplier_company_name               :=fask_rec.company_name;
         iv_supp_info.supplier_company_abbreviation       :=fask_rec.company_name;
         iv_supp_info.social_credit_code                  :=fask_rec.social_credit_code;
         iv_supp_info.company_contact_person              :=fask_rec.contact_name;
         iv_supp_info.company_contact_phone               :=fask_rec.contact_phone;
         iv_supp_info.company_address                     :=fask_rec.company_address;
         iv_supp_info.certificate_file                    :=v_certificate_file;
         iv_supp_info.cooperation_type                    :=fask_rec.cooperation_type;
         iv_supp_info.cooperation_model                   :=fask_rec.cooperation_model;
         iv_supp_info.sharing_type                        :='00';
         iv_supp_info.supplier_info_origin                :='AA';
         iv_supp_info.pause                               :=0;
         iv_supp_info.status                              :=0;
         iv_supp_info.bind_status                         :=1;
         iv_supp_info.create_id                           :=p_user_id;
         iv_supp_info.create_date                         :=SYSDATE;
         iv_supp_info.update_id                           :=p_user_id;
         iv_supp_info.update_date                         :=SYSDATE;
         iv_supp_info.company_province                    :=fask_rec.company_province;
         iv_supp_info.company_city                        :=fask_rec.company_city;
         iv_supp_info.company_county                      :=fask_rec.company_county; 
         iv_supp_info.coop_state                          :=v_coop_state;
         iv_supp_info.group_name                          :=v_group_name;
         iv_supp_info.coop_position                       :=v_coop_position;
         p_insert_supplier_info(IV_SUPP_INFO =>iv_supp_info);

         ELSE
         
         iv_supp_info.supplier_info_id                    :=v_supply_id;
         iv_supp_info.company_id                          :=v_company_id;
         iv_supp_info.supplier_info_origin_id             :=fask_rec.factory_ask_id;
         iv_supp_info.supplier_company_id                 :=nvl(fask_rec.cooperation_company_id,v_cooperation_company_id);
         iv_supp_info.supplier_company_name               :=fask_rec.company_name;
         iv_supp_info.supplier_company_abbreviation       :=fask_rec.company_name;
         iv_supp_info.social_credit_code                  :=fask_rec.social_credit_code;
         iv_supp_info.company_contact_person              :=fask_rec.contact_name;
         iv_supp_info.company_contact_phone               :=fask_rec.contact_phone;
         iv_supp_info.company_address                     :=fask_rec.company_address;
         iv_supp_info.certificate_file                    :=v_certificate_file;
         iv_supp_info.cooperation_type                    :=fask_rec.cooperation_type;
         iv_supp_info.cooperation_model                   :=fask_rec.cooperation_model;
         iv_supp_info.sharing_type                        :='00';
         iv_supp_info.supplier_info_origin                :='AA';
         iv_supp_info.pause                               :=0;
         iv_supp_info.status                              :=0;
         iv_supp_info.bind_status                         :=1;
         iv_supp_info.create_id                           :=p_user_id;
         iv_supp_info.create_date                         :=SYSDATE;
         iv_supp_info.update_id                           :=p_user_id;
         iv_supp_info.update_date                         :=SYSDATE;
         iv_supp_info.company_province                    :=fask_rec.company_province;
         iv_supp_info.company_city                        :=fask_rec.company_city;
         iv_supp_info.company_county                      :=fask_rec.company_county; 
         iv_supp_info.coop_state                          :=v_coop_state;
         iv_supp_info.group_name                          :=v_group_name;
         iv_supp_info.coop_position                       :=v_coop_position;
         p_insert_supplier_info(IV_SUPP_INFO =>iv_supp_info);
         END IF;

      --2）合作范围取=》意向合作范围
      FOR fscope_rec IN fask_scope_cur(fask_rec.factory_ask_id) LOOP
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
           sharing_type,
           coop_state )
        VALUES
          (scmdata.f_get_uuid(),
           v_supply_id,
           v_company_id,
           fask_rec.cooperation_model,
           fscope_rec.cooperation_classification,
           fscope_rec.cooperation_product_cate,
           fscope_rec.cooperation_subcategory,
           p_user_id,
           SYSDATE,
           p_user_id,
           SYSDATE,
           '',
           0,
           '00',
           v_coop_state);

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

        --1）基础信息   1 <---->   判断为外协厂
         IF fask_rec.com_manufacturer  = '1' THEN    
         iv_supp_info.supplier_info_id                    :=v_supply_id;
         iv_supp_info.company_id                          :=v_company_id;
         iv_supp_info.supplier_info_origin_id             :=fask_rec.factory_ask_id;
         iv_supp_info.supplier_company_id                 :=nvl(fask_rec.cooperation_company_id,v_cooperation_company_id);
         iv_supp_info.supplier_company_name               :=fask_rec.company_name;
         iv_supp_info.supplier_company_abbreviation       :=fask_rec.company_name;
         iv_supp_info.social_credit_code                  :=fask_rec.social_credit_code;
         iv_supp_info.company_contact_person              :=fask_rec.contact_name;
         iv_supp_info.company_contact_phone               :=fask_rec.contact_phone;
         iv_supp_info.company_address                     :=fask_rec.company_address;
         iv_supp_info.certificate_file                    :=v_certificate_file;
         iv_supp_info.cooperation_type                    :=fask_rec.cooperation_type;
         iv_supp_info.cooperation_model                   :=fask_rec.cooperation_model;
         iv_supp_info.sharing_type                        :='00';
         iv_supp_info.supplier_info_origin                :='AA';
         iv_supp_info.pause                               :=0;
         iv_supp_info.status                              :=0;
         iv_supp_info.bind_status                         :=1;
         iv_supp_info.create_id                           :=p_user_id;
         iv_supp_info.create_date                         :=SYSDATE;
         iv_supp_info.update_id                           :=p_user_id;
         iv_supp_info.update_date                         :=SYSDATE;
         iv_supp_info.company_province                    :=fask_rec.company_province;
         iv_supp_info.company_city                        :=fask_rec.company_city;
         iv_supp_info.company_county                      :=fask_rec.company_county; 
         iv_supp_info.coop_state                          :=v_coop_state;
         iv_supp_info.group_name                          :=v_group_name;
         iv_supp_info.coop_position                       :=v_coop_position;
         p_insert_supplier_info(IV_SUPP_INFO =>iv_supp_info);

         ELSE
         
         iv_supp_info.supplier_info_id                    :=v_supply_id;
         iv_supp_info.company_id                          :=v_company_id;
         iv_supp_info.supplier_info_origin_id             :=fask_rec.factory_ask_id;
         iv_supp_info.supplier_company_id                 :=nvl(fask_rec.cooperation_company_id,v_cooperation_company_id);
         iv_supp_info.supplier_company_name               :=fask_rec.company_name;
         iv_supp_info.supplier_company_abbreviation       :=fask_rec.company_name;
         iv_supp_info.social_credit_code                  :=fask_rec.social_credit_code;
         iv_supp_info.company_contact_person              :=fask_rec.contact_name;
         iv_supp_info.company_contact_phone               :=fask_rec.contact_phone;
         iv_supp_info.company_address                     :=fask_rec.company_address;
         iv_supp_info.certificate_file                    :=v_certificate_file;
         iv_supp_info.cooperation_type                    :=fask_rec.cooperation_type;
         iv_supp_info.cooperation_model                   :=fask_rec.cooperation_model;
         iv_supp_info.sharing_type                        :='00';
         iv_supp_info.supplier_info_origin                :='AA';
         iv_supp_info.pause                               :=0;
         iv_supp_info.status                              :=0;
         iv_supp_info.bind_status                         :=1;
         iv_supp_info.create_id                           :=p_user_id;
         iv_supp_info.create_date                         :=SYSDATE;
         iv_supp_info.update_id                           :=p_user_id;
         iv_supp_info.update_date                         :=SYSDATE;
         iv_supp_info.company_province                    :=fask_rec.company_province;
         iv_supp_info.company_city                        :=fask_rec.company_city;
         iv_supp_info.company_county                      :=fask_rec.company_county; 
         iv_supp_info.coop_state                          :=v_coop_state;
         iv_supp_info.group_name                          :=v_group_name;
         iv_supp_info.coop_position                       :=v_coop_position;
         p_insert_supplier_info(IV_SUPP_INFO =>iv_supp_info);
         END IF;

        --2）合作范围取 =》验厂报告 生产能力评估明细(符合)
        FOR faskrp_ability_rec IN faskrp_ability_cur(fask_rec.factory_ask_id) LOOP
          --只有生产能力评估明细(符合)才能进入合作范围
          IF faskrp_ability_rec.ability_result = 'AGREE' THEN
            --能力评估明细
            INSERT INTO t_coop_scope
              (coop_scope_id,
               supplier_info_id,
               company_id,
               coop_mode,
               coop_classification,
               coop_product_cate,
               coop_subcategory,
               remarks,
               pause,
               sharing_type,
               create_id,
               create_time,
               update_id,
               update_time,
               coop_state )
            VALUES
              (scmdata.f_get_uuid(),
               v_supply_id,
               v_company_id,
               fask_rec.cooperation_model,
               faskrp_ability_rec.cooperation_classification,
               faskrp_ability_rec.cooperation_product_cate,
               faskrp_ability_rec.cooperation_subcategory,
               '',
               0,
               '00',
               p_user_id,
               SYSDATE,
               p_user_id,
               SYSDATE,
               v_coop_state);
          ELSE
            NULL;
          END IF;
        END LOOP;

      ELSE
        NULL;
      END IF;
    END IF;
  END create_t_supplier_info_cs;
/

