CREATE OR REPLACE PACKAGE SCMDATA.sf_supplier_info_pkg IS

  -- Author  : SANFU
  -- Created : 2020/9/3 15:22:09
  -- Purpose : 供应商档案管理

  PROCEDURE submit_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                   p_default_company_id VARCHAR2,
                                   p_user_id            VARCHAR2);

  FUNCTION get_supplier_code_by_rule(p_supplier_info_id VARCHAR2)
    RETURN VARCHAR2;

  PROCEDURE appoint_t_supplier_shared(p_company_id       VARCHAR2,
                                      p_supplier_info_id VARCHAR2,
                                      p_supplier_code    VARCHAR2 DEFAULT NULL,
                                      p_appoint_type     VARCHAR2);

  PROCEDURE auto_reset_sequence(p_seqname IN VARCHAR2);

  PROCEDURE update_supplier_info_status(p_supplier_info_id VARCHAR2,
                                        p_reason           VARCHAR2,
                                        p_status           NUMBER,
                                        p_user_id          VARCHAR2,
                                        p_company_id       VARCHAR2);

  PROCEDURE create_t_supplier_info(p_company_id     VARCHAR2,
                                   p_factory_ask_id VARCHAR2,
                                   p_user_id        VARCHAR2);

  PROCEDURE check_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                  p_default_company_id VARCHAR2);

  PROCEDURE check_save_t_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                       p_default_company_id VARCHAR2,
                                       p_status             VARCHAR2);

  PROCEDURE update_supp_info_bind_status(p_supplier_info_id VARCHAR2,
                                         p_status           NUMBER);

END sf_supplier_info_pkg;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.sf_supplier_info_pkg IS

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-09 16:52:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 生成未建档的供应商档案
  * Obj_Name    : CREATE_T_SUPPLIER_INFO
  * Arg_Number  : 2
  * P_COMPANY_ID : 当前企业编号
  * P_FACTORY_ASK_ID : 申请单编号
  * p_user_id:当前登录用户编号
  *============================================*/

  PROCEDURE create_t_supplier_info(p_company_id     VARCHAR2,
                                   p_factory_ask_id VARCHAR2,
                                   p_user_id        VARCHAR2) IS
  
    --来源都是 准入审核 待审核数据 =》 同意 =》生产待建档供应商数据
    v_company_id VARCHAR2(100) := p_company_id;
  
    v_cooperation_company_id VARCHAR2(100);
  
    v_supply_id VARCHAR2(100);
  
    v_flag NUMBER;
  
    fask_rec scmdata.t_factory_ask%ROWTYPE;
  
    cinfo_rec scmdata.sys_company%ROWTYPE;
  
    faskrp_rec scmdata.t_factory_report%ROWTYPE;
  
    --能力评估明细
    CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
      SELECT ra.*
        FROM scmdata.t_factory_report         fr,
             scmdata.t_factory_report_ability ra
       WHERE fr.factory_report_id = ra.factory_report_id
         AND fr.factory_ask_id = p_factory_ask_id;
  
  BEGIN
    --数据源
    --验厂申请单
    SELECT *
      INTO fask_rec
      FROM scmdata.t_factory_ask fa
     WHERE fa.factory_ask_id = p_factory_ask_id --外部带入 :factory_ask_id
       AND fa.factrory_ask_flow_status IN ('FA22', 'FA32')
       AND fa.company_id = v_company_id;
    --CA,MA 准入，手动新增
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
    --1.不验厂  来源只有验厂申请单
    --基础信息
    IF fask_rec.factory_ask_type = 0 THEN
      --获取平台唯一编码
      v_supply_id := scmdata.pkg_plat_comm.f_getkeyid_plat('GY',
                                                           'seq_plat_code',
                                                           99); --scmdata.f_get_uuid();
    
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
         --company_create_date,
         social_credit_code,
         company_contact_person,
         company_contact_phone,
         --能力评估
         cooperation_method,
         cooperation_model,
         cooperation_type,
         --production_mode,
         create_id,
         create_date,
         update_id,
         update_date)
      VALUES
        (v_supply_id,
         v_company_id,
         fask_rec.factory_ask_id,
         cinfo_rec.company_id,
         '00',
         'AA',
         0,
         0,
         1,
         cinfo_rec.logn_name,
         cinfo_rec.company_name,
         --cinfo_rec.create_time,
         cinfo_rec.licence_num,
         fask_rec.contact_name,
         fask_rec.contact_phone,
         --能力评估
         fask_rec.cooperation_method,
         fask_rec.cooperation_model,
         fask_rec.cooperation_type,
         --fask_rec.production_mode,
         p_user_id,
         SYSDATE,
         p_user_id,
         SYSDATE);
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
                                                             99); --scmdata.f_get_uuid();
      
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
           --company_create_date,
           social_credit_code,
           company_contact_person,
           company_contact_phone,
           --能力评估
           cooperation_method,
           cooperation_model,
           cooperation_type,
           production_mode,
           create_id,
           create_date,
           update_id,
           update_date)
        VALUES
          (v_supply_id,
           v_company_id,
           fask_rec.factory_ask_id,
           cinfo_rec.company_id,
           '00',
           'AA',
           0,
           0,
           cinfo_rec.logn_name,
           cinfo_rec.company_name,
           --cinfo_rec.create_time,
           cinfo_rec.licence_num,
           fask_rec.contact_name,
           fask_rec.contact_phone,
           --能力评估
           faskrp_rec.cooperation_method,
           faskrp_rec.cooperation_model,
           faskrp_rec.cooperation_type,
           faskrp_rec.production_mode,
           p_user_id,
           SYSDATE,
           p_user_id,
           SYSDATE);
      
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
  END create_t_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : （新增，更新）保存时校验 
  * Obj_Name    : CHECK_SAVE_T_SUPPLIER_INFO
  * Arg_Number  : 2
  * P_SP_DATA : 供应商档案数据
  * P_DEFAULT_COMPANY_ID : 平台当前默认企业
  * p_status : 状态（NEW,OLD）
  *============================================*/

  PROCEDURE check_save_t_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                       p_default_company_id VARCHAR2,
                                       p_status             VARCHAR2) IS
    v_supp_flag NUMBER;
    --v_flag       NUMBER;
    --v_share_flag NUMBER;
    v_scc_flag NUMBER;
  
  BEGIN
  
    --1.新增时，校验企业在平台是否存在供应商档案
    IF p_status = 'NEW' AND p_sp_data.supplier_company_name IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_supp_flag
        FROM scmdata.t_supplier_info sp
       WHERE sp.supplier_company_name = p_sp_data.supplier_company_name
         AND sp.company_id = p_default_company_id;
    
      IF v_supp_flag > 0 THEN
        raise_application_error(-20002,
                                p_sp_data.supplier_company_name ||
                                ',该企业已存在供应商档案！');
      ELSE
        NULL;
      END IF;
    ELSE
      NULL;
    END IF;
  
    --2.校验基础数据
    IF p_sp_data.supplier_company_name IS NULL THEN
      raise_application_error(-20002, '公司名称不能为空！');
    END IF;
  
    IF p_sp_data.supplier_company_abbreviation IS NULL THEN
      raise_application_error(-20002, '公司简称不能为空！');
    END IF;
  
    IF p_sp_data.social_credit_code IS NULL THEN
      raise_application_error(-20002, '统一社会信用代码不能为空！');
    END IF;
  
    SELECT COUNT(1)
      INTO v_scc_flag
      FROM scmdata.t_supplier_info sp
     WHERE sp.social_credit_code = p_sp_data.social_credit_code
       AND sp.company_id = p_default_company_id
       AND sp.supplier_info_id <> p_sp_data.supplier_info_id;
  
    IF v_scc_flag > 0 THEN
      raise_application_error(-20002, '统一社会信用代码不能重复！');
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.company_contact_person IS NULL THEN
      raise_application_error(-20002, '公司联系人不能为空！');
    END IF;
  
    IF p_sp_data.company_contact_phone IS NULL THEN
      raise_application_error(-20002, '公司联系人手机号码不能为空！');
    END IF;
  
    IF p_sp_data.certificate_file IS NULL THEN
      raise_application_error(-20002, '营业执照不能为空，请上传！');
    END IF;
  
    IF p_sp_data.contract_start_date IS NULL THEN
      raise_application_error(-20002, '合同有效期从不能为空！');
    END IF;
  
    IF p_sp_data.contract_stop_date IS NULL THEN
      raise_application_error(-20002, '合同有效期至不能为空！');
    END IF;
  
    IF p_sp_data.contract_stop_date - p_sp_data.contract_start_date < 0 THEN
      raise_application_error(-20002,
                              '请正确填写合同有效期从，至（合同有效期至需大于合同有效期从）！');
    END IF;
  
    IF p_sp_data.contract_file IS NULL THEN
      raise_application_error(-20002, '合同附件不能为空，请上传！');
    END IF;
  
    IF p_sp_data.cooperation_type IS NULL THEN
      raise_application_error(-20002, '合作类型不能为空！');
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.cooperation_model IS NULL THEN
      raise_application_error(-20002, '合作模式不能为空！');
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.regist_price IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_integer(p_sp_data.regist_price,
                                                     0) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '注册资本只能输入数字！');
      END IF;
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.social_credit_code IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_soial_code(p_sp_data.social_credit_code) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002,
                                '请输入正确的统一社会信用代码，且长度应为18位！');
      END IF;
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.company_contact_phone IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_phone(p_sp_data.company_contact_phone) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '请输入正确的联系人手机号码！');
      END IF;
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.public_id IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_id_card(p_sp_data.public_id) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '请输入正确的对公身份账号！');
      END IF;
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.personal_idcard IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_id_card(p_sp_data.personal_idcard) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '请输入正确的个人身份账号！');
      END IF;
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.public_phone IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_integer(p_sp_data.public_phone,
                                                     0) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '请输入正确的对公联系电话！');
      END IF;
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.personal_phone IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_integer(p_sp_data.personal_phone,
                                                     0) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '请输入正确的个人联系电话！');
      END IF;
    ELSE
      NULL;
    END IF;
  
    IF p_sp_data.reconciliation_phone IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_integer(p_sp_data.reconciliation_phone,
                                                     0) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '请输入正确的对账联系电话！');
      END IF;
    ELSE
      NULL;
    END IF;
  
    /*  保存按钮，在供应商新增界面 做不到这个逻辑处理 修改：把该逻辑转移到  提交按钮
      --3.校验能力评估明细，合作类型为成品供应商，则能力评估明细tab页不能为空
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_ability t
     WHERE t.supplier_info_id = p_sp_data.supplier_info_id;
    
    IF p_sp_data.cooperation_type = 'PRODUCT_TYPE' AND v_flag = 0 THEN
      raise_application_error(-20002,
                              '合作类型为成品供应商的能力评估明细，不能为空,请先到下方《能力评估明细TAB页》进行填写！');
    ELSE
      NULL;
    END IF;
    --4.共享方式为指定共享，指定供应商的TAB页，不能为空 
    SELECT COUNT(1)
      INTO v_share_flag
      FROM scmdata.t_supplier_info sa,
           scmdata.t_supplier_shared ts,
           (SELECT *
              FROM scmdata.t_supplier_info tu
             WHERE tu.company_id = p_default_company_id
               AND tu.status = 1
               AND tu.pause = 0) v
     WHERE sa.supplier_info_id = ts.supplier_info_id
       AND ts.shared_company_id = v.supplier_company_id
       AND sa.supplier_info_id = p_sp_data.supplier_info_id;
    
    IF p_sp_data.sharing_type = '02' AND v_share_flag = 0 THEN
      raise_application_error(-20002,
                              '共享方式为指定共享，指定供应商的TAB页,不能为空,请先到下方《指定供应商共享TAB页》进行填写！');
    ELSE
      NULL;
    END IF;*/
  
  END check_save_t_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-09 16:52:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 提交时触发 =》校验-供应商档案（主表，从表：能力评估明细） 
  * Obj_Name    : CREATE_T_SUPPLIER_INFO
  * Arg_Number  : 1
  * p_supplier_info_id : 当前供应商编号
  *============================================*/
  PROCEDURE check_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                  p_default_company_id VARCHAR2) IS
    supplier_submit_exp EXCEPTION;
    --v_flag NUMBER;
    --x_err_msg VARCHAR2(100);
    --供应商档案
    supp_info_rec scmdata.t_supplier_info%ROWTYPE;
    v_flag        NUMBER;
    v_share_flag  NUMBER;
  
    --能力评估明细
    /*    CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
    SELECT ra.*
      FROM scmdata.t_factory_report         fr,
           scmdata.t_factory_report_ability ra
     WHERE fr.factory_report_id = ra.factory_report_id
       AND fr.factory_ask_id = p_factory_ask_id;*/
  
  BEGIN
    --数据源
    --供应商档案
    SELECT *
      INTO supp_info_rec
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id;
  
    --1.校验供应商档案编号是否已经生成
  
    IF supp_info_rec.supplier_code IS NOT NULL THEN
      raise_application_error(-20002,
                              '该供应商档案已经生成，请勿重复提交！');
    END IF;
  
    --2.提交 =》校验数据是否有效
    check_save_t_supplier_info(p_sp_data            => supp_info_rec,
                               p_default_company_id => p_default_company_id,
                               p_status             => 'OLD');
  
    --3.校验能力评估明细，合作类型为成品供应商，则能力评估明细tab页不能为空
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_ability t
     WHERE t.supplier_info_id = supp_info_rec.supplier_info_id;
  
    IF supp_info_rec.cooperation_type = 'PRODUCT_TYPE' AND v_flag = 0 THEN
      raise_application_error(-20002,
                              '合作类型为成品供应商的能力评估明细，不能为空,请先到下方《能力评估明细TAB页》进行填写！');
    ELSE
      NULL;
    END IF;
    --4.共享方式为指定共享，指定供应商的TAB页，不能为空 
    SELECT COUNT(1)
      INTO v_share_flag
      FROM scmdata.t_supplier_info sa,
           scmdata.t_supplier_shared ts,
           (SELECT *
              FROM scmdata.t_supplier_info tu
             WHERE tu.company_id = p_default_company_id
               AND tu.status = 1
               AND tu.pause = 0) v
     WHERE sa.supplier_info_id = ts.supplier_info_id
       AND ts.shared_supplier_code = v.supplier_code
       AND sa.supplier_info_id = supp_info_rec.supplier_info_id;
  
    IF supp_info_rec.sharing_type = '02' AND v_share_flag = 0 THEN
      raise_application_error(-20002,
                              '共享方式为指定共享，指定供应商的TAB页,不能为空,请先到下方《指定供应商共享TAB页》进行填写！');
    ELSE
      NULL;
    END IF;
  
  END check_t_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-03 17:10:14
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 提交     生成供应商编码，未建档=》已建档
  * Obj_Name    : SUBMIT_T_SUPPLIER_INFO
  * Arg_Number  : 1
  * P_SUPPLIER_INFO_ID :供应商档案编号
  *============================================*/
  PROCEDURE submit_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                   p_default_company_id VARCHAR2,
                                   p_user_id            VARCHAR2) IS
    v_supplier_code VARCHAR2(100); --供应商编码
    supplier_code_exp EXCEPTION;
    x_err_msg VARCHAR2(100);
  BEGIN
    --1.校验数据
    check_t_supplier_info(p_supplier_info_id, p_default_company_id);
    --2.生成供应商档案编号
    v_supplier_code := get_supplier_code_by_rule(p_supplier_info_id);
    --3.更新档案状态 待建档 =》已建档 ,新增（MA）供应商 => 未绑定，准入（AA）=> 已绑定
    IF v_supplier_code IS NULL THEN
      RAISE supplier_code_exp;
    ELSE
      UPDATE scmdata.t_supplier_info sp
         SET sp.supplier_code    = v_supplier_code,
             sp.status           = 1,
             sp.bind_status      = decode(sp.supplier_info_origin,
                                          'AA',
                                          1,
                                          'MA',
                                          0),
             sp.create_supp_date = SYSDATE,
             sp.update_id        = p_user_id,
             sp.update_date      = SYSDATE
       WHERE sp.supplier_info_id = p_supplier_info_id;
    END IF;
  
  EXCEPTION
    WHEN supplier_code_exp THEN
      x_err_msg := '生成供应商编码失败，请联系管平台理员！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
  END submit_t_supplier_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-03 17:10:14
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 生成供应商编码
  * Obj_Name    : get_supplier_code_by_rule
  * Arg_Number  : 1
  * P_SUPPLIER_INFO_ID :供应商档案编号
  *============================================*/
  FUNCTION get_supplier_code_by_rule(p_supplier_info_id VARCHAR2)
    RETURN VARCHAR2 IS
    v_company_id          VARCHAR2(200);
    v_supplier_company_id VARCHAR2(200);
    v_cooperation_type    VARCHAR2(200);
    v_flag                NUMBER;
    c_product_type        VARCHAR2(100) := 'C';
    c_material_type       VARCHAR2(100) := 'W';
    c_technology_type     VARCHAR2(100) := 'T';
    c_equip_type          VARCHAR2(100) := 'S';
    c_service_type        VARCHAR2(100) := 'F';
    v_table_name          VARCHAR2(100) := 't_supplier_info';
    v_column_name         VARCHAR2(100) := 'supplier_code';
    v_serail_num          NUMBER := 5; --流水号长度
    v_supplier_code       VARCHAR2(100); --供应商编码
    supplier_info_exp    EXCEPTION;
    cooperation_type_exp EXCEPTION;
    x_err_msg VARCHAR2(1000);
  BEGIN
    SELECT sp.supplier_company_id, sp.cooperation_type, sp.company_id
      INTO v_supplier_company_id, v_cooperation_type, v_company_id
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id;
  
    --1个档案1个编码，1个供应商仅能生成1个档案
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_company_id = v_supplier_company_id
       AND sp.company_id = v_company_id
       AND sp.status = 1;
  
    IF v_flag > 0 THEN
      RAISE supplier_info_exp;
    ELSE
      --成品供应商C 物料供应商W 特殊工艺供应商T 设备供应商S 服务商F 
      IF v_cooperation_type IS NOT NULL THEN
        IF v_cooperation_type = 'PRODUCT_TYPE' THEN
          /*          v_supplier_code := c_product_type ||
          lpad(supplier_info_c_s.nextval, 5, '0');*/
          --生成企业级编码
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_product_type,
                                                                pi_serail_num  => v_serail_num);
        
        END IF;
        IF v_cooperation_type = 'MATERIAL_TYPE' THEN
          /*   v_supplier_code := c_material_type ||
          lpad(supplier_info_w_s.nextval, 5, '0');*/
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_material_type,
                                                                pi_serail_num  => v_serail_num);
        
        END IF;
        IF v_cooperation_type = 'TECHNOLOGY_TYPE' THEN
          /*  v_supplier_code := c_technology_type ||
          lpad(supplier_info_t_s.nextval, 5, '0');*/
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_technology_type,
                                                                pi_serail_num  => v_serail_num);
        
        END IF;
        IF v_cooperation_type = 'EQUIP_TYPE' THEN
          /*          v_supplier_code := c_equip_type ||
          lpad(supplier_info_s_s.nextval, 5, '0');*/
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_equip_type,
                                                                pi_serail_num  => v_serail_num);
        
        END IF;
        IF v_cooperation_type = 'SERVICE_TYPE' THEN
          /*          v_supplier_code := c_service_type ||
          lpad(supplier_info_f_s.nextval, 5, '0');*/
        
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_service_type,
                                                                pi_serail_num  => v_serail_num);
        
        END IF;
      
      ELSE
        RAISE cooperation_type_exp;
      END IF;
    END IF;
  
    RETURN v_supplier_code;
  
  EXCEPTION
    WHEN supplier_info_exp THEN
      x_err_msg := '已存在该供应商档案，不可重复生成供应商档案！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    
    WHEN cooperation_type_exp THEN
      x_err_msg := '合作意向类型为空！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
  END get_supplier_code_by_rule;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-04 10:35:19
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 生产工厂共享设置 (旧的待建档界面，舍弃该功能)
  * Obj_Name    : APPOINT_T_SUPPLIER_SHARED
  * Arg_Number  : 4
  * P_COMPANY_ID :当前企业编号
  * P_SUPPLIER_INFO_ID : 供应商编号
  * P_SHARED_COMPANY_ID : 要分享的其他供应商编号
  * P_APPOINT_TYPE : 指定类型（不共享：00,全部共享：01,指定共享: 02）
  *============================================*/

  PROCEDURE appoint_t_supplier_shared(p_company_id       VARCHAR2,
                                      p_supplier_info_id VARCHAR2,
                                      p_supplier_code    VARCHAR2 DEFAULT NULL,
                                      p_appoint_type     VARCHAR2) IS
    --v_flag        NUMBER;
    v_shared_flag NUMBER;
    shared_company_exp       EXCEPTION;
    shared_supplier_info_exp EXCEPTION;
    x_err_msg VARCHAR2(200);
    --当前企业所有已建档的供应商信息                                 
    /*    CURSOR supplier_cur IS
    SELECT *
      FROM scmdata.t_supplier_info tu
     WHERE tu.company_id = p_company_id
       AND tu.supplier_info_id <> p_supplier_info_id
       AND tu.status = 1
       AND tu.pause = 0;*/
  BEGIN
    --校验该企业，当前供应商是否共享过给其他供应商
    /*    SELECT COUNT(1)
     INTO v_flag
     FROM scmdata.t_supplier_shared sp
    WHERE sp.company_id = p_company_id
      AND sp.supplier_info_id = p_supplier_info_id;*/
    --类型  不共享：0,全部共享：1,指定共享: 2
    --不共享：00
    IF p_appoint_type = '00' THEN
      /*      IF v_flag = 0 THEN
        NULL;
      ELSE
        DELETE FROM scmdata.t_supplier_shared sp
         WHERE sp.company_id = p_company_id
           AND sp.supplier_info_id = p_supplier_info_id;
        --设置不共享
        UPDATE scmdata.t_supplier_info ts
           SET ts.sharing_type = '00'
         WHERE ts.company_id = p_company_id
           AND ts.supplier_info_id = p_supplier_info_id;
      END IF;*/
      --设置不共享
      UPDATE scmdata.t_supplier_info ts
         SET ts.sharing_type = '00'
       WHERE ts.company_id = p_company_id
         AND ts.supplier_info_id = p_supplier_info_id;
    END IF;
    --全部共享：01
    IF p_appoint_type = '01' THEN
      /*      IF v_flag = 0 THEN
        FOR supp_rec IN supplier_cur LOOP
          INSERT INTO scmdata.t_supplier_shared sp
          VALUES
            (scmdata.f_get_uuid(),
             p_company_id,
             p_supplier_info_id,
             supp_rec.supplier_company_id,
             '');
        END LOOP;
      ELSE
        FOR supp_rec IN supplier_cur LOOP
          --排除共享过的供应商
          SELECT COUNT(1)
            INTO v_shared_flag
            FROM scmdata.t_supplier_shared sp
           WHERE sp.company_id = p_company_id
             AND sp.supplier_info_id = p_supplier_info_id
             AND sp.shared_company_id = supp_rec.supplier_company_id;
        
          IF v_shared_flag = 0 THEN
            INSERT INTO scmdata.t_supplier_shared sp
            VALUES
              (scmdata.f_get_uuid(),
               p_company_id,
               p_supplier_info_id,
               supp_rec.supplier_company_id,
               '');
          ELSE
            NULL;
          END IF;
        END LOOP;
      END IF;*/
      --设置全部共享
      UPDATE scmdata.t_supplier_info ts
         SET ts.sharing_type = '01'
       WHERE ts.company_id = p_company_id
         AND ts.supplier_info_id = p_supplier_info_id;
    END IF;
    --指定共享: 02
    IF p_appoint_type = '02' THEN
      IF p_supplier_code IS NULL THEN
        RAISE shared_company_exp;
      END IF;
      --校验共享过的供应商
      SELECT COUNT(1)
        INTO v_shared_flag
        FROM scmdata.t_supplier_shared sp
       WHERE sp.company_id = p_company_id
         AND sp.supplier_info_id = p_supplier_info_id
         AND sp.shared_supplier_code = p_supplier_code;
    
      IF v_shared_flag = 0 THEN
        INSERT INTO scmdata.t_supplier_shared sp
        VALUES
          (scmdata.f_get_uuid(),
           p_company_id,
           p_supplier_info_id,
           p_supplier_code,
           '',
           '1'); --新增字段coop_scope_id
      ELSE
        RAISE shared_supplier_info_exp;
      END IF;
      --设置指定共享
      UPDATE scmdata.t_supplier_info ts
         SET ts.sharing_type = '02'
       WHERE ts.company_id = p_company_id
         AND ts.supplier_info_id = p_supplier_info_id;
    
    END IF;
  EXCEPTION
    WHEN shared_company_exp THEN
      x_err_msg := '请指定供应商共享！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN shared_supplier_info_exp THEN
      x_err_msg := '该供应商已经共享过生产工厂设置！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
  END appoint_t_supplier_shared;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   更新供应商档案状态（0：正常，1：停用）
  * Obj_Name    : update_supplier_info_status
  * Arg_Number  : 5
  * p_supplier_info_id :供应商档案编号
  * p_reason ：原因
  * P_STATUS :状态
  * p_user_id ：当前操作人
  * p_company_id ：当前操作企业
  *============================================*/
  PROCEDURE update_supplier_info_status(p_supplier_info_id VARCHAR2,
                                        p_reason           VARCHAR2,
                                        p_status           NUMBER,
                                        p_user_id          VARCHAR2,
                                        p_company_id       VARCHAR2) IS
    v_status  NUMBER;
    oper_type VARCHAR2(100);
    x_err_msg VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
  BEGIN
  
    SELECT sp.pause
      INTO v_status
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id;
  
    IF p_status <> v_status THEN
      IF p_status = 0 THEN
        oper_type := '启用';
      ELSIF p_status = 1 THEN
        oper_type := '停用';
      ELSE
        NULL;
      END IF;
      --新增启用、停用操作日志从表
      INSERT INTO scmdata.t_supplier_info_oper_log
        (log_id,
         supplier_info_id,
         oper_type,
         reason,
         create_id,
         create_time,
         company_id)
      VALUES
        (scmdata.f_get_uuid(),
         p_supplier_info_id,
         oper_type,
         p_reason,
         p_user_id,
         SYSDATE,
         p_company_id);
      --启用，停用
      UPDATE scmdata.t_supplier_info sp
         SET sp.pause = p_status
       WHERE sp.supplier_info_id = p_supplier_info_id;
    ELSE
      --操作重复报提示信息
      RAISE supplier_info_exp;
    END IF;
  
  EXCEPTION
    WHEN supplier_info_exp THEN
      x_err_msg := '不可重复操作！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
    
  END update_supplier_info_status;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   更新供应商档案状态（0：正常，1：停用）
  * Obj_Name    : update_supp_info_bind_status
  * Arg_Number  : 2
  * p_supplier_info_id :供应商档案编号
  * P_STATUS :状态
  *============================================*/
  PROCEDURE update_supp_info_bind_status(p_supplier_info_id VARCHAR2,
                                         p_status           NUMBER) IS
    v_status          NUMBER;
    v_supp_company_id VARCHAR2(100);
    x_err_msg         VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
    supplier_bind_exp EXCEPTION;
  BEGIN
  
    SELECT sp.bind_status, sp.supplier_company_id
      INTO v_status, v_supp_company_id
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id;
  
    --对已注册供应商进行绑定，解绑
    IF p_status <> nvl(v_status, 0) THEN
    
      IF v_supp_company_id IS NULL THEN
        RAISE supplier_bind_exp;
      END IF;
    
      UPDATE scmdata.t_supplier_info sp
         SET sp.bind_status = p_status
       WHERE sp.supplier_info_id = p_supplier_info_id
         AND sp.supplier_company_id IS NOT NULL;
    ELSE
      --操作重复报提示信息
      RAISE supplier_info_exp;
    END IF;
  
  EXCEPTION
    WHEN supplier_bind_exp THEN
      x_err_msg := '未注册供应商不能进行绑定！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN supplier_info_exp THEN
      x_err_msg := '不可重复操作！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
    
  END update_supp_info_bind_status;

  --序列清零
  PROCEDURE auto_reset_sequence(p_seqname IN VARCHAR2) IS
    n NUMBER;
  BEGIN
    BEGIN
      EXECUTE IMMEDIATE 'select ' || p_seqname || '.nextval from dual'
        INTO n;
      EXECUTE IMMEDIATE 'alter sequence ' || p_seqname || ' increment by -' || n;
      EXECUTE IMMEDIATE 'select ' || p_seqname || '.nextval from dual'
        INTO n;
      EXECUTE IMMEDIATE 'alter sequence ' || p_seqname ||
                        ' increment by 1 ';
    END;
  END auto_reset_sequence;

END sf_supplier_info_pkg;
/

