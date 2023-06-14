CREATE OR REPLACE PACKAGE pkg_supplier_info IS

  -- Author  : SANFU
  -- Created : 2020/11/6 14:52:03
  -- Purpose : 
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-09 16:52:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 提交时触发 =》校验-供应商档案（主表，从表：合作范围必须有值） 
  * Obj_Name    : check_t_supplier_info
  * Arg_Number  : 1
  * p_supplier_info_id : 当前供应商编号
  * p_default_company_id ： 默认企业编号
  *============================================*/
  PROCEDURE check_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                  p_default_company_id VARCHAR2);

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
                                       p_status             VARCHAR2);

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
  FUNCTION get_supplier_code_by_rule(p_supplier_info_id   VARCHAR2,
                                     p_default_company_id VARCHAR2)
    RETURN VARCHAR2;

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
                                   p_user_id        VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-03 17:10:14
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 提交     生成供应商编码，未建档=》已建档
  * Obj_Name    : SUBMIT_T_SUPPLIER_INFO
  * Arg_Number  : 3
  * P_SUPPLIER_INFO_ID :供应商档案编号
  * p_default_company_id ：
  * p_user_id ：
  *============================================*/
  PROCEDURE submit_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                   p_default_company_id VARCHAR2,
                                   p_user_id            VARCHAR2);

  --新增操作日志从表
  PROCEDURE insert_oper_log(p_supplier_info_id VARCHAR2,
                            oper_type          VARCHAR2,
                            p_reason           VARCHAR2,
                            p_user_id          VARCHAR2,
                            p_company_id       VARCHAR2,
                            p_create_time      DATE);

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
                                        p_company_id       VARCHAR2);

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
  PROCEDURE update_supp_info_bind_status(p_company_id       VARCHAR2,
                                         p_supplier_info_id VARCHAR2,
                                         p_user_id          VARCHAR2,
                                         p_status           NUMBER);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   更新供应商档案-合作范围状态（0：正常，1：停用）
  * Obj_Name    : update_supplier_info_status
  * Arg_Number  : 4
  * p_supplier_info_id :供应商档案编号
  * P_STATUS :状态
  * p_company_id ：当前操作企业
  * p_coop_scope_id : 合作范围编号
  *============================================*/
  PROCEDURE update_coop_scope_status(p_company_id       VARCHAR2,
                                     p_user_id          VARCHAR2,
                                     p_supplier_info_id VARCHAR2,
                                     p_coop_scope_id    VARCHAR2,
                                     p_status           NUMBER);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增供应商 
  * Obj_Name    : insert_supplier_info
  * Arg_Number  : 2
  * P_SP_DATA : 供应商档案数据
  * P_DEFAULT_COMPANY_ID : 平台当前默认企业
  *============================================*/

  PROCEDURE insert_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                 p_default_company_id VARCHAR2);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改供应商 
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 2
  * P_SP_DATA : 供应商档案数据
  * P_DEFAULT_COMPANY_ID : 平台当前默认企业
  *============================================*/
  PROCEDURE update_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                 p_default_company_id VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 删除供应商 
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 2
  * p_supplier_info_id : 供应商档案编号
  * P_DEFAULT_COMPANY_ID : 平台当前默认企业
  *============================================*/

  PROCEDURE delete_supplier_info(p_supplier_info_id   VARCHAR2,
                                 p_default_company_id VARCHAR2);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验合同日期
  * Obj_Name    : check_contract_info
  * Arg_Number  : 1
  * p_contract_rec : 合同记录
  *============================================*/
  PROCEDURE check_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增合同 
  * Obj_Name    : insert_contract_info
  * Arg_Number  : 1
  * p_contract_rec : 合同记录
  *============================================*/
  PROCEDURE insert_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改合同
  * Obj_Name    : update_contract_info
  * Arg_Number  : 1
  * p_contract_rec : 合同记录
  *============================================*/
  PROCEDURE update_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验导入数据
  * Obj_Name    : CHECK_IMPORTDATAS
  * Arg_Number  : 2
  * P_COMPANY_ID :企业ID
  * P_USER_ID :用户ID
  * p_supplier_temp_id :临时表ID
  *============================================*/

  PROCEDURE check_importdatas(p_company_id       IN VARCHAR2,
                              p_user_id          IN VARCHAR2,
                              p_supplier_temp_id IN VARCHAR2);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 提交工艺单 将临时数据提交到业务表中
  * Obj_Name    : submit_comm_craft_temp
  * Arg_Number  : 2
  * p_company_id :企业ID
  * p_user_id ：用户ID
  *============================================*/
  PROCEDURE submit_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2);

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 新增供应商主档临时数据
  * Obj_Name    : insert_supplier_info_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :临时数据
  *============================================*/

  PROCEDURE insert_supplier_info_temp(p_supp_rec scmdata.t_supplier_info_temp%ROWTYPE);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 修改供应商主档临时数据
  * Obj_Name    : update_supplier_info_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :临时数据
  *============================================*/
  PROCEDURE update_supplier_info_temp(p_supp_rec scmdata.t_supplier_info_temp%ROWTYPE);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 删除合同
  * Obj_Name    : delete_contract_info
  * Arg_Number  : 1
  * p_contract_info_id : 合同id
  *============================================*/
  PROCEDURE delete_contract_info(p_contract_info_id VARCHAR2);
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:43:35
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 清空导入数据
  * Obj_Name    : delete_supplier_info_temp
  * Arg_Number  : 2
  * P_COMPANY_ID :企业ID
  * P_USER_ID : 用户ID
  *============================================*/
  PROCEDURE delete_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2);
  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验导入数据
  * Obj_Name    : check_importdatas_coop_scope
  * Arg_Number  : 1
  * p_supplier_temp_id :临时表ID
  *============================================*/

  PROCEDURE check_importdatas_coop_scope(p_coop_scope_temp_id IN VARCHAR2);
  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 提交供应商合作范围 将临时数据提交到业务表中
  * Obj_Name    : submit_t_coop_scope_temp
  * Arg_Number  : 2
  * p_company_id :企业ID
  * p_user_id ：用户ID
  *============================================*/
  PROCEDURE submit_t_coop_scope_temp(p_company_id IN VARCHAR2,
                                     p_user_id    IN VARCHAR2);
  --校验合作范围  p_status： IU 新增/更新 D 删除
  PROCEDURE check_coop_scopre(p_cp_data scmdata.t_coop_scope%ROWTYPE,
                              p_status  VARCHAR2);

  --新增合作范围
  PROCEDURE insert_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --修改合作范围
  PROCEDURE update_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --删除合作范围
  PROCEDURE delete_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --获取供应商批次
  FUNCTION get_supp_batch_id(pi_company_id VARCHAR2) RETURN VARCHAR2;
END pkg_supplier_info;
/
CREATE OR REPLACE PACKAGE BODY pkg_supplier_info IS

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-09 16:52:50
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 提交时触发 =》校验-供应商档案（主表，从表：合作范围必须有值） 
  * Obj_Name    : check_t_supplier_info
  * Arg_Number  : 1
  * p_supplier_info_id : 当前供应商编号
  * p_default_company_id ： 默认企业编号
  *============================================*/
  PROCEDURE check_t_supplier_info(p_supplier_info_id   VARCHAR2,
                                  p_default_company_id VARCHAR2) IS
    supplier_submit_exp EXCEPTION;
    --供应商档案
    supp_info_rec scmdata.t_supplier_info%ROWTYPE;
    v_flag        NUMBER;
  
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
  
    --3.校验合作范围TAB页不能为空
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_coop_scope t
     WHERE t.supplier_info_id = supp_info_rec.supplier_info_id;
  
    IF v_flag = 0 AND supp_info_rec.supplier_info_origin <> 'QC' THEN
      raise_application_error(-20002,
                              '合作范围，不能为空,请先到下方《合作范围TAB页》进行填写！');
    END IF;
  
  END check_t_supplier_info;

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
    v_scc_flag     NUMBER;
    v_supp_flag    NUMBER := 0;
    v_supp_flag_tp NUMBER := 0;
  
  BEGIN
    --1.校验基础数据 
    IF p_sp_data.supplier_company_name IS NULL THEN
      raise_application_error(-20002, '公司名称不能为空！');
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
    END IF;
  
    IF p_sp_data.social_credit_code IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_soial_code(p_sp_data.social_credit_code) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002,
                                '请输入正确的统一社会信用代码，且长度应为18位！');
      END IF;
    END IF;
  
    IF p_sp_data.company_contact_phone IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_phone(p_sp_data.company_contact_phone) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '请输入正确的联系人手机号码！');
      END IF;
    END IF;
  
    --准入流程，供应商档案：供应商名称可编辑。
    --无论新增修改，都得校验供应商名称是否重复
  
    -- 1） 限制仅能填写中文及中文括号；
    IF p_sp_data.supplier_company_name IS NOT NULL THEN
      IF pkg_check_data_comm.f_check_varchar(pi_data => p_sp_data.supplier_company_name,
                                             pi_type => 0) <> 1 THEN
        raise_application_error(-20002,
                                '供应商名称填写错误，仅能填写中文及中文括号！');
      END IF;
    
      --2） 不能与当前企业供应商档案：待建档、已建档的供应商名称重复；  
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_default_company_id
         AND t.supplier_info_id <> p_sp_data.supplier_info_id
         AND t.supplier_company_name = p_sp_data.supplier_company_name;
    
      IF v_supp_flag_tp > 0 THEN
        raise_application_error(-20002,
                                '供应商名称与供应商档案已有名称重复！');
      END IF;
    
    END IF;
  
    --2.新增时，校验企业在平台是否存在供应商档案
    IF p_status = 'NEW' THEN
      IF p_sp_data.supplier_company_name IS NOT NULL THEN
        --1） 不能与当前企业在准入流程中的公司名称存在重复；
        scmdata.pkg_compname_check.p_tfa_compname_check_for_new(comp_name => p_sp_data.supplier_company_name,
                                                                dcomp_id  => p_default_company_id);
      END IF;
      IF p_sp_data.social_credit_code IS NOT NULL THEN
        --2)校验当前企业是否已存在供应商档案
        SELECT COUNT(1)
          INTO v_supp_flag
          FROM scmdata.t_supplier_info sp
         WHERE sp.social_credit_code = p_sp_data.social_credit_code
           AND sp.company_id = p_default_company_id;
      
        IF v_supp_flag > 0 THEN
          raise_application_error(-20002,
                                  p_sp_data.supplier_company_name ||
                                  ',该企业已存在供应商档案！');
        END IF;
      END IF;
    ELSIF p_status = 'OLD' THEN
      IF p_sp_data.supplier_company_name IS NOT NULL THEN
        --3） 不能与当前企业在准入流程中的公司名称存在重复；
        scmdata.pkg_compname_check.p_tfa_compname_check_for_dcheck(comp_name => p_sp_data.supplier_company_name,
                                                                   dcomp_id  => p_default_company_id,
                                                                   origin_id => p_sp_data.supplier_info_origin_id);
      END IF;
    END IF;
  
  END check_save_t_supplier_info;

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
  FUNCTION get_supplier_code_by_rule(p_supplier_info_id   VARCHAR2,
                                     p_default_company_id VARCHAR2)
    RETURN VARCHAR2 IS
    v_company_id          VARCHAR2(200);
    v_supplier_company_id VARCHAR2(200);
    v_cooperation_type    VARCHAR2(200);
    --v_origin              VARCHAR2(100);
    v_flag            NUMBER;
    c_product_type    VARCHAR2(100) := 'C';
    c_material_type   VARCHAR2(100) := 'W';
    c_technology_type VARCHAR2(100) := 'T';
    c_equip_type      VARCHAR2(100) := 'S';
    c_service_type    VARCHAR2(100) := 'F';
    v_table_name      VARCHAR2(100) := 't_supplier_info';
    v_column_name     VARCHAR2(100) := 'supplier_code';
    v_serail_num      NUMBER := 5; --流水号长度
    v_supplier_code   VARCHAR2(100); --供应商编码
    supplier_info_exp    EXCEPTION;
    cooperation_type_exp EXCEPTION;
    x_err_msg VARCHAR2(1000);
  BEGIN
    SELECT sp.supplier_company_id, sp.cooperation_type, sp.company_id
    /*,sp.supplier_info_origin*/
      INTO v_supplier_company_id, v_cooperation_type, v_company_id /*,v_origin*/
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id
       AND sp.company_id = p_default_company_id;
  
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
          --生成企业级编码
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_product_type,
                                                                pi_serail_num  => v_serail_num);
        
        ELSIF v_cooperation_type = 'MATERIAL_TYPE' THEN
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_material_type,
                                                                pi_serail_num  => v_serail_num);
        
        ELSIF v_cooperation_type = 'TECHNOLOGY_TYPE' THEN
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_technology_type,
                                                                pi_serail_num  => v_serail_num);
        
        ELSIF v_cooperation_type = 'EQUIP_TYPE' THEN
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_equip_type,
                                                                pi_serail_num  => v_serail_num);
        
        ELSIF v_cooperation_type = 'SERVICE_TYPE' THEN
        
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_service_type,
                                                                pi_serail_num  => v_serail_num);
          /*        ELSIF v_origin = 'II' THEN
          --接口进来的数据，默认生成生成企业级编码 'PRODUCT_TYPE' 
          v_supplier_code := scmdata.pkg_plat_comm.f_getkeycode(pi_table_name  => v_table_name,
                                                                pi_column_name => v_column_name,
                                                                pi_company_id  => v_company_id,
                                                                pi_pre         => c_product_type,
                                                                pi_serail_num  => v_serail_num);*/
        ELSE
          raise_application_error(-20002,
                                  '生成供应商编码失败，请联系管平台理员！！');
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
      x_err_msg := '合作类型为空！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'T');
  END get_supplier_code_by_rule;
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
  
    v_cooperation_company_id VARCHAR2(100);
  
    v_supply_id VARCHAR2(100);
  
    v_certificate_file VARCHAR2(4000);
  
    v_flag NUMBER;
  
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
      INSERT INTO scmdata.t_supplier_info
        (supplier_info_id,
         company_id,
         supplier_info_origin_id,
         supplier_company_id,
         supplier_company_name,
         supplier_company_abbreviation,
         social_credit_code,
         company_contact_person,
         company_contact_phone,
         company_address,
         certificate_file,
         cooperation_type,
         cooperation_model,
         sharing_type,
         supplier_info_origin,
         pause,
         status,
         bind_status,
         create_id,
         create_date,
         update_id,
         update_date)
      VALUES
        (v_supply_id,
         v_company_id,
         fask_rec.factory_ask_id,
         nvl(fask_rec.cooperation_company_id, v_cooperation_company_id),
         fask_rec.company_name,
         fask_rec.company_name,
         fask_rec.social_credit_code,
         fask_rec.contact_name,
         fask_rec.contact_phone,
         fask_rec.company_address,
         v_certificate_file,
         fask_rec.cooperation_type,
         fask_rec.cooperation_model,
         '00',
         'AA',
         0,
         0,
         1,
         p_user_id,
         SYSDATE,
         p_user_id,
         SYSDATE);
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
           sharing_type)
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
           supplier_company_name,
           supplier_company_abbreviation,
           social_credit_code,
           company_contact_person,
           company_contact_phone,
           company_address,
           certificate_file,
           cooperation_type,
           cooperation_model,
           sharing_type,
           supplier_info_origin,
           pause,
           status,
           bind_status,
           create_id,
           create_date,
           update_id,
           update_date)
        VALUES
          (v_supply_id,
           v_company_id,
           fask_rec.factory_ask_id,
           nvl(fask_rec.cooperation_company_id, v_cooperation_company_id),
           fask_rec.company_name,
           fask_rec.company_name,
           fask_rec.social_credit_code,
           fask_rec.contact_name,
           fask_rec.contact_phone,
           fask_rec.company_address,
           v_certificate_file,
           fask_rec.cooperation_type,
           fask_rec.cooperation_model,
           '00',
           'AA',
           0,
           0,
           1,
           p_user_id,
           SYSDATE,
           p_user_id,
           SYSDATE);
      
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
               update_time)
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
               SYSDATE);
          ELSE
            NULL;
          END IF;
        END LOOP;
      
      ELSE
        NULL;
      END IF;
    END IF;
  END create_t_supplier_info;

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
    v_supplier_code := get_supplier_code_by_rule(p_supplier_info_id,
                                                 p_default_company_id);
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
                                          0,
                                          'QC',
                                          0,
                                          0),
             sp.create_supp_date = SYSDATE,
             sp.update_id        = p_user_id,
             sp.update_date      = SYSDATE
       WHERE sp.supplier_info_id = p_supplier_info_id;
    
      --记录操作日志
      insert_oper_log(p_supplier_info_id,
                      '创建档案',
                      '',
                      p_user_id,
                      p_default_company_id,
                      SYSDATE);
    END IF;
  
  EXCEPTION
    WHEN supplier_code_exp THEN
      x_err_msg := '生成供应商编码失败，请联系管平台理员！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
  END submit_t_supplier_info;
  --新增操作日志从表
  PROCEDURE insert_oper_log(p_supplier_info_id VARCHAR2,
                            oper_type          VARCHAR2,
                            p_reason           VARCHAR2,
                            p_user_id          VARCHAR2,
                            p_company_id       VARCHAR2,
                            p_create_time      DATE) IS
    v_name VARCHAR2(100);
  BEGIN
    SELECT fc.company_user_name
      INTO v_name
      FROM scmdata.sys_company_user fc
     WHERE fc.company_id = p_company_id
       AND fc.user_id = p_user_id;
    --操作日志从表
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
       v_name,
       p_create_time,
       p_company_id);
  END insert_oper_log;

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
      insert_oper_log(p_supplier_info_id,
                      oper_type,
                      p_reason,
                      p_user_id,
                      p_company_id,
                      SYSDATE);
    
      --启用，停用
      UPDATE scmdata.t_supplier_info sp
         SET sp.pause = p_status, sp.update_date = SYSDATE
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
  PROCEDURE update_supp_info_bind_status(p_company_id       VARCHAR2,
                                         p_supplier_info_id VARCHAR2,
                                         p_user_id          VARCHAR2,
                                         p_status           NUMBER) IS
    v_status          NUMBER;
    oper_type         VARCHAR2(100);
    v_supp_company_id VARCHAR2(100);
    x_err_msg         VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
    supplier_bind_exp EXCEPTION;
  BEGIN
  
    SELECT sp.bind_status, sp.supplier_company_id
      INTO v_status, v_supp_company_id
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id
       AND sp.company_id = p_company_id;
  
    --对已注册供应商进行绑定，解绑
    IF p_status <> nvl(v_status, 0) THEN
      IF v_supp_company_id IS NULL THEN
        RAISE supplier_bind_exp;
      END IF;
      IF p_status = 0 THEN
        oper_type := '解绑';
      ELSIF p_status = 1 THEN
        oper_type := '绑定';
      ELSE
        NULL;
      END IF;
      --新增绑定、解绑操作日志从表
      insert_oper_log(p_supplier_info_id,
                      oper_type,
                      '',
                      p_user_id,
                      p_company_id,
                      SYSDATE);
    
      UPDATE scmdata.t_supplier_info sp
         SET sp.bind_status = p_status
       WHERE sp.company_id = p_company_id
         AND sp.supplier_info_id = p_supplier_info_id
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

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-07-22 15:29:43
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :   更新供应商档案-合作范围状态（0：正常，1：停用）
  * Obj_Name    : update_supplier_info_status
  * Arg_Number  : 4
  * p_supplier_info_id :供应商档案编号
  * P_STATUS :状态
  * p_company_id ：当前操作企业
  * p_coop_scope_id : 合作范围编号
  *============================================*/
  PROCEDURE update_coop_scope_status(p_company_id       VARCHAR2,
                                     p_user_id          VARCHAR2,
                                     p_supplier_info_id VARCHAR2,
                                     p_coop_scope_id    VARCHAR2,
                                     p_status           NUMBER) IS
    v_status  NUMBER;
    oper_type VARCHAR2(100);
    x_err_msg VARCHAR2(1000);
    coop_scope_exp EXCEPTION;
  BEGIN
  
    SELECT sp.pause
      INTO v_status
      FROM scmdata.t_coop_scope sp
     WHERE sp.company_id = p_company_id
       AND sp.supplier_info_id = p_supplier_info_id
       AND sp.coop_scope_id = p_coop_scope_id;
  
    IF p_status <> v_status THEN
      --启用，停用
      UPDATE scmdata.t_coop_scope sp
         SET sp.pause       = p_status,
             sp.update_id   = p_user_id,
             sp.update_time = SYSDATE
       WHERE sp.company_id = p_company_id
         AND sp.supplier_info_id = p_supplier_info_id
         AND sp.coop_scope_id = p_coop_scope_id;
    
      IF p_status = 0 THEN
        oper_type := '启用';
      ELSIF p_status = 1 THEN
        oper_type := '停用';
      ELSE
        NULL;
      END IF;
    
      --新增操作日志从表
      insert_oper_log(p_supplier_info_id,
                      '修改档案-' || oper_type || '合作范围',
                      '',
                      p_user_id,
                      p_company_id,
                      SYSDATE);
    ELSE
      --操作重复报提示信息
      RAISE coop_scope_exp;
    END IF;
  
  EXCEPTION
    WHEN coop_scope_exp THEN
      x_err_msg := '不可重复操作！！';
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => x_err_msg,
                                               p_is_running_error => 'F');
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => '',
                                               p_is_running_error => 'T');
    
  END update_coop_scope_status;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 新增供应商 
  * Obj_Name    : insert_supplier_info
  * Arg_Number  : 2
  * P_SP_DATA : 供应商档案数据
  * P_DEFAULT_COMPANY_ID : 平台当前默认企业
  *============================================*/

  PROCEDURE insert_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                 p_default_company_id VARCHAR2) IS
  BEGIN
  
    INSERT INTO scmdata.t_supplier_info
      (supplier_info_id,
       company_id,
       inside_supplier_code,
       supplier_company_name,
       company_province,
       company_city,
       company_county,
       company_address,
       supplier_company_abbreviation,
       social_credit_code,
       legal_representative,
       company_contact_person,
       company_type,
       cooperation_model,
       company_contact_phone,
       certificate_file,
       company_say,
       cooperation_type,
       status,
       supplier_info_origin,
       pause,
       create_id,
       create_date,
       update_id,
       update_date,
       remarks)
    VALUES
      (p_sp_data.supplier_info_id,
       p_default_company_id,
       p_sp_data.inside_supplier_code,
       p_sp_data.supplier_company_name,
       p_sp_data.company_province,
       p_sp_data.company_city,
       p_sp_data.company_county,
       p_sp_data.company_address,
       p_sp_data.supplier_company_abbreviation,
       p_sp_data.social_credit_code,
       p_sp_data.legal_representative,
       p_sp_data.company_contact_person,
       p_sp_data.company_type,
       p_sp_data.cooperation_model,
       p_sp_data.company_contact_phone,
       p_sp_data.certificate_file,
       p_sp_data.company_say,
       p_sp_data.cooperation_type,
       0,
       p_sp_data.supplier_info_origin,
       '0',
       p_sp_data.create_id,
       SYSDATE,
       p_sp_data.create_id,
       SYSDATE,
       p_sp_data.remarks);
  
  END insert_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 修改供应商 
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 2
  * P_SP_DATA : 供应商档案数据
  * P_DEFAULT_COMPANY_ID : 平台当前默认企业
  *============================================*/

  PROCEDURE update_supplier_info(p_sp_data            scmdata.t_supplier_info%ROWTYPE,
                                 p_default_company_id VARCHAR2) IS
  BEGIN
  
    UPDATE scmdata.t_supplier_info
       SET inside_supplier_code          = p_sp_data.inside_supplier_code,
           supplier_company_name         = p_sp_data.supplier_company_name,
           company_province              = p_sp_data.company_province,
           company_city                  = p_sp_data.company_city,
           company_county                = p_sp_data.company_county,
           company_address               = p_sp_data.company_address,
           supplier_company_abbreviation = p_sp_data.supplier_company_abbreviation,
           social_credit_code            = p_sp_data.social_credit_code,
           legal_representative          = p_sp_data.legal_representative,
           company_contact_person        = p_sp_data.company_contact_person,
           company_type                  = p_sp_data.company_type,
           cooperation_model             = p_sp_data.cooperation_model,
           company_contact_phone         = p_sp_data.company_contact_phone,
           certificate_file              = p_sp_data.certificate_file,
           company_say                   = p_sp_data.company_say,
           cooperation_type              = p_sp_data.cooperation_type,
           update_id                     = p_sp_data.update_id,
           update_date                   = SYSDATE,
           remarks                       = p_sp_data.remarks
     WHERE supplier_info_id = p_sp_data.supplier_info_id
       AND company_id = p_default_company_id;
  
  END update_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 删除供应商 
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 2
  * p_supplier_info_id : 供应商档案编号
  * P_DEFAULT_COMPANY_ID : 平台当前默认企业
  *============================================*/

  PROCEDURE delete_supplier_info(p_supplier_info_id   VARCHAR2,
                                 p_default_company_id VARCHAR2) IS
    v_origin VARCHAR2(100);
  BEGIN
    SELECT sp.supplier_info_origin
      INTO v_origin
      FROM scmdata.t_supplier_info sp
     WHERE sp.company_id = p_default_company_id
       AND sp.supplier_info_id = p_supplier_info_id
       AND sp.status = 0;
    IF v_origin <> 'MA' THEN
      raise_application_error(-20002,
                              '只能删除“手动新增”的待建档供应商档案！');
    ELSE
    
      DELETE FROM scmdata.t_supplier_shared ts
       WHERE ts.company_id = p_default_company_id
         AND ts.supplier_info_id = p_supplier_info_id;
    
      DELETE FROM scmdata.t_coop_scope tc
       WHERE tc.company_id = p_default_company_id
         AND tc.supplier_info_id = p_supplier_info_id;
    
      DELETE FROM scmdata.t_contract_info tc
       WHERE tc.company_id = p_default_company_id
         AND tc.supplier_info_id = p_supplier_info_id;
    
      DELETE FROM scmdata.t_supplier_info sp
       WHERE sp.company_id = p_default_company_id
         AND sp.supplier_info_id = p_supplier_info_id
         AND sp.supplier_info_origin = 'MA'
         AND sp.status = 0;
    END IF;
  END delete_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  校验合同 
  * Obj_Name    : check_contract_info
  * Arg_Number  : 1
  * p_contract_rec : 合同记录
  *============================================*/
  PROCEDURE check_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE) IS
  BEGIN
    IF p_contract_rec.contract_start_date >
       p_contract_rec.contract_stop_date THEN
      raise_application_error(-20002, '合同日期，结束日期必须≥开始日期');
    END IF;
  END check_contract_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  新增合同 
  * Obj_Name    : insert_contract_info
  * Arg_Number  : 1
  * p_contract_rec : 合同记录
  *============================================*/
  PROCEDURE insert_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE) IS
  BEGIN
    --校验合同日期，结束日期必须≥开始日期
    check_contract_info(p_contract_rec => p_contract_rec);
  
    INSERT INTO t_contract_info
      (contract_info_id,
       supplier_info_id,
       company_id,
       contract_start_date,
       contract_stop_date,
       contract_sign_date,
       contract_file)
    VALUES
      (scmdata.f_get_uuid(),
       p_contract_rec.supplier_info_id,
       p_contract_rec.company_id,
       p_contract_rec.contract_start_date,
       p_contract_rec.contract_stop_date,
       p_contract_rec.contract_sign_date,
       p_contract_rec.contract_file);
  
  END insert_contract_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  修改合同 
  * Obj_Name    : update_contract_info
  * Arg_Number  : 1
  * p_contract_rec : 合同记录
  *============================================*/
  PROCEDURE update_contract_info(p_contract_rec scmdata.t_contract_info%ROWTYPE) IS
  BEGIN
    --校验合同日期，结束日期必须≥开始日期
    check_contract_info(p_contract_rec => p_contract_rec);
  
    UPDATE t_contract_info t
       SET t.contract_start_date = p_contract_rec.contract_start_date,
           t.contract_stop_date  = p_contract_rec.contract_stop_date,
           t.contract_sign_date  = p_contract_rec.contract_sign_date,
           t.contract_file       = p_contract_rec.contract_file
     WHERE t.contract_info_id = p_contract_rec.contract_info_id;
  
  END update_contract_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  删除合同 
  * Obj_Name    : delete_contract_info
  * Arg_Number  : 1
  * p_contract_rec : 合同记录
  *============================================*/
  PROCEDURE delete_contract_info(p_contract_info_id VARCHAR2) IS
  BEGIN
  
    DELETE t_contract_info t WHERE t.contract_info_id = p_contract_info_id;
  
  END delete_contract_info;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 提交工艺单 将临时数据提交到业务表中
  * Obj_Name    : submit_comm_craft_temp
  * Arg_Number  : 2
  * p_company_id :企业ID
  * p_user_id ：用户ID
  *============================================*/
  PROCEDURE submit_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2) IS
    p_sp_data scmdata.t_supplier_info%ROWTYPE;
    --临时数据,校验信息                               
    CURSOR import_data_cur IS
      SELECT t.*, m.msg_type
        FROM scmdata.t_supplier_info_temp t
        LEFT JOIN scmdata.t_supplier_info_import_msg m
          ON t.err_msg_id = m.msg_id
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id;
  BEGIN
  
    FOR data_rec IN import_data_cur LOOP
      --判断数据是否都校验成功，只有都校验成功了，才能进行提交
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      
      ELSE
        p_sp_data.supplier_info_id       := scmdata.f_get_uuid();
        p_sp_data.company_id             := data_rec.company_id;
        p_sp_data.create_id              := data_rec.user_id;
        p_sp_data.inside_supplier_code   := data_rec.inside_supplier_code;
        p_sp_data.supplier_company_name  := data_rec.supplier_company_name;
        p_sp_data.cooperation_type       := data_rec.cooperation_type;
        p_sp_data.company_city           := data_rec.company_city;
        p_sp_data.company_province       := data_rec.company_province;
        p_sp_data.company_county         := data_rec.company_county;
        p_sp_data.company_address        := data_rec.company_address;
        p_sp_data.social_credit_code     := data_rec.social_credit_code;
        p_sp_data.legal_representative   := data_rec.legal_representative;
        p_sp_data.company_contact_person := data_rec.company_contact_person;
        p_sp_data.company_contact_phone  := data_rec.company_contact_phone;
        p_sp_data.cooperation_type       := data_rec.cooperation_type_code;
        p_sp_data.cooperation_model      := data_rec.cooperation_model_code;
        p_sp_data.company_city           := data_rec.company_city_code;
        p_sp_data.company_province       := data_rec.company_province_code;
        p_sp_data.company_county         := data_rec.company_county_code;
        p_sp_data.remarks                := data_rec.memo;
        p_sp_data.supplier_info_origin   := 'QC';
      
        --将临时数据提交到业务表中,待建档
        insert_supplier_info(p_sp_data            => p_sp_data,
                             p_default_company_id => p_company_id);
        -- 提交=》已建档                                    
        submit_t_supplier_info(p_supplier_info_id   => p_sp_data.supplier_info_id,
                               p_default_company_id => p_company_id,
                               p_user_id            => p_user_id);
      END IF;
    
    END LOOP;
  
    --最后清空临时表数据以及导入信息表的数据
    delete_supplier_info_temp(p_company_id => p_company_id,
                              p_user_id    => p_user_id);
  END submit_supplier_info_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验导入数据
  * Obj_Name    : CHECK_IMPORTDATAS
  * Arg_Number  : 2
  * P_COMPANY_ID :企业ID
  * P_USER_ID :用户ID
  * p_supplier_temp_id :临时表ID
  *============================================*/

  PROCEDURE check_importdatas(p_company_id       IN VARCHAR2,
                              p_user_id          IN VARCHAR2,
                              p_supplier_temp_id IN VARCHAR2) IS
  
    v_num          NUMBER := 0;
    v_err_num      NUMBER := 0;
    v_msg_id       NUMBER;
    v_supp_flag    NUMBER := 0;
    v_supp_flag_tp NUMBER := 0;
    v_msg          VARCHAR2(2000);
    v_flag         NUMBER := 0;
    v_coop_name    VARCHAR2(100);
    v_coop_mdname  VARCHAR2(100);
    v_import_flag  VARCHAR2(100);
    v_province     VARCHAR2(100);
    v_city         VARCHAR2(100);
    v_county       VARCHAR2(100);
    --导入的临时数据
    data_rec scmdata.t_supplier_info_temp%ROWTYPE;
    /*    CURSOR importdatas IS
    SELECT *
      FROM scmdata.t_supplier_info_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;*/
  BEGIN
    SELECT *
      INTO data_rec
      FROM scmdata.t_supplier_info_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id
       AND t.supplier_temp_id = p_supplier_temp_id;
  
    --FOR data_rec IN importdatas LOOP
    IF data_rec.inside_supplier_code IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_err_num || '.供应商编号不能为空！';
    ELSE
    
      --1）导入的数据供应商编号不能重复
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_supplier_info_temp t
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id
         AND t.inside_supplier_code = data_rec.inside_supplier_code;
    
      --2） 跟已有供应商档案的供应商编码不能重复
    
      SELECT COUNT(1)
        INTO v_supp_flag
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.inside_supplier_code = data_rec.inside_supplier_code;
    
      --供应商编号是否存在，不可重复
      IF v_supp_flag_tp > 1 OR v_supp_flag > 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_err_num || '.供应商编号不可重复，导入数据存在重复或与供应商档案已有编号重复！';
      END IF;
    END IF;
  
    IF data_rec.supplier_company_name IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.供应商名称不能为空！';
    ELSE
      --3) 供应商名称只能填写中文及中文括号  
      IF pkg_check_data_comm.f_check_varchar(pi_data => data_rec.supplier_company_name,
                                             pi_type => 0) <> 1 THEN
        raise_application_error(-20002,
                                '供应商名称填写错误，仅能填写中文及中文括号！');
      END IF;
      --4）导入的数据供应商名称不能重复
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_supplier_info_temp t
       WHERE t.company_id = p_company_id
         AND t.user_id = p_user_id
         AND t.supplier_company_name = data_rec.supplier_company_name;
      --5） 跟已有供应商档案的供应商名称不能重复
      SELECT COUNT(1)
        INTO v_supp_flag
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.supplier_company_name = data_rec.supplier_company_name;
    
      --供应商名称是否存在，不可重复
      IF v_supp_flag_tp > 1 OR v_supp_flag > 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_err_num || '.供应商名称不可重复，导入数据存在重复或与供应商档案已有名称重复！';
      END IF;
    END IF;
  
    IF data_rec.cooperation_type_code IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.合作类型编码不能为空！';
    END IF;
  
    IF data_rec.cooperation_type IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.合作类型不能为空！';
    END IF;
  
    IF data_rec.cooperation_model_code IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.合作模式编码不能为空！';
    END IF;
  
    IF data_rec.cooperation_model IS NULL THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.合作模式不能为空！';
    END IF;
  
    --校验统一社会信用代码
    IF data_rec.social_credit_code IS NULL THEN
    
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.统一社会信用代码不能为空！';
    
    ELSIF pkg_check_data_comm.f_check_soial_code(data_rec.social_credit_code) = 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.统一社会信用代码:[' ||
                   data_rec.social_credit_code ||
                   ']长度应为18位，请填写正确的统一社会信用代码！';
    ELSE
      --校验统一社会信用代码 在该企业下已建档是否唯一
      SELECT COUNT(1)
        INTO v_flag
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = data_rec.company_id
         AND t.status = 1
         AND t.social_credit_code = data_rec.social_credit_code;
    
      IF v_flag > 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.统一社会信用代码:[' ||
                     data_rec.social_credit_code ||
                     ']在该企业中已存在，请填写正确的统一社会信用代码！';
      END IF;
    
    END IF;
  
    --校验合作类型编码
    SELECT COUNT(t.group_dict_value)
      INTO v_flag
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = 'COOPERATION_TYPE'
       AND t.group_dict_value = data_rec.cooperation_type_code;
  
    IF v_flag = 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.合作类型编码:[' ||
                   data_rec.cooperation_type_code ||
                   ']在数据字典中不存在，请填写正确的合作类型编码！';
    ELSE
      SELECT MAX(t.group_dict_name)
        INTO v_coop_name
        FROM scmdata.sys_group_dict t
       WHERE t.group_dict_type = 'COOPERATION_TYPE'
         AND t.group_dict_value = data_rec.cooperation_type_code;
    
      IF v_coop_name <> data_rec.cooperation_type THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.合作类型编码:[' ||
                     data_rec.cooperation_type_code || ']与合作类型名称:[' ||
                     data_rec.cooperation_type || ']对应关系不一致，请确认后填写！';
      ELSE
        NULL;
      END IF;
    END IF;
  
    --校验合作模式编码
    SELECT COUNT(t.group_dict_value)
      INTO v_flag
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = 'SUPPLY_TYPE'
       AND t.group_dict_value = data_rec.cooperation_model_code;
  
    IF v_flag = 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.合作模式编码:[' ||
                   data_rec.cooperation_model_code ||
                   ']在数据字典中不存在，请填写正确的合作模式编码！';
    ELSE
      SELECT MAX(t.group_dict_name)
        INTO v_coop_mdname
        FROM scmdata.sys_group_dict t
       WHERE t.group_dict_type = 'SUPPLY_TYPE'
         AND t.group_dict_value = data_rec.cooperation_model_code;
    
      IF v_coop_mdname <> data_rec.cooperation_model THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.合作模式编码:[' ||
                     data_rec.cooperation_model_code || ']与合作模式名称:[' ||
                     data_rec.cooperation_model || ']对应关系不一致，请确认后填写！';
      ELSE
        NULL;
      END IF;
    END IF;
  
    --校验手机号码
    IF pkg_check_data_comm.f_check_phone(pi_data => data_rec.company_contact_phone) = 0 THEN
      v_err_num := v_err_num + 1;
      v_msg     := v_msg || v_err_num || '.联系人手机:[' ||
                   data_rec.company_contact_phone || ']请填写正确的联系人手机！';
    END IF;
    --校验省市区
    --省
    IF data_rec.company_province_code IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_num
        FROM scmdata.dic_province p
       WHERE p.provinceid = data_rec.company_province_code;
    
      IF v_num = 0 THEN
        v_err_num := v_err_num + 1;
        v_msg     := v_msg || v_err_num || '.省份编号:[' ||
                     data_rec.company_province_code ||
                     ']在数据字典中不存在，请填写正确的省份编号！';
      ELSE
        SELECT MAX(p.province)
          INTO v_province
          FROM scmdata.dic_province p
         WHERE p.provinceid = data_rec.company_province_code;
      
        IF v_province <> data_rec.company_province THEN
          v_err_num := v_err_num + 1;
          v_msg     := v_msg || v_err_num || '.省份编号:[' ||
                       data_rec.company_province_code || ']与省份名称:[' ||
                       data_rec.company_province || ']对应关系不一致，请确认后填写！';
        ELSE
          --市
          IF data_rec.company_city_code IS NOT NULL THEN
          
            SELECT COUNT(1)
              INTO v_num
              FROM scmdata.dic_city c
             WHERE c.provinceid = data_rec.company_province_code
               AND c.cityno = data_rec.company_city_code;
          
            IF v_num = 0 THEN
              v_err_num := v_err_num + 1;
              v_msg     := v_msg || v_err_num || '.城市编号:[' ||
                           data_rec.company_city_code || ']在数据字典中不存在/[' ||
                           data_rec.company_city || ']不属于[' ||
                           data_rec.company_province || ']，请填写正确的城市编号！';
            ELSE
              SELECT MAX(c.city)
                INTO v_city
                FROM scmdata.dic_city c
               WHERE c.provinceid = data_rec.company_province_code
                 AND c.cityno = data_rec.company_city_code;
            
              IF v_city <> data_rec.company_city THEN
                v_err_num := v_err_num + 1;
                v_msg     := v_msg || v_err_num || '.城市编号:[' ||
                             data_rec.company_city_code || ']与城市名称:[' ||
                             data_rec.company_city || ']对应关系不一致，请确认后填写！';
              ELSE
                --区
                IF data_rec.company_county_code IS NOT NULL THEN
                
                  SELECT COUNT(1)
                    INTO v_num
                    FROM scmdata.dic_county d
                   WHERE d.cityno = data_rec.company_city_code
                     AND d.countyid = data_rec.company_county_code;
                
                  IF v_num = 0 THEN
                    v_err_num := v_err_num + 1;
                    v_msg     := v_msg || v_err_num || '.区县编号:[' ||
                                 data_rec.company_county_code ||
                                 ']在数据字典中不存在/[' || data_rec.company_county ||
                                 ']不属于[' || data_rec.company_city ||
                                 ']，请填写正确的区县编号！';
                  ELSE
                    SELECT MAX(d.county)
                      INTO v_county
                      FROM scmdata.dic_county d
                     WHERE d.cityno = data_rec.company_city_code
                       AND d.countyid = data_rec.company_county_code;
                  
                    IF v_county <> data_rec.company_county THEN
                      v_err_num := v_err_num + 1;
                      v_msg     := v_msg || v_err_num || '.区县编号:[' ||
                                   data_rec.company_county_code ||
                                   ']与区县名称:[' || data_rec.company_county ||
                                   ']对应关系不一致，请确认后填写！';
                    END IF;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
    --将校验信息插入到导入信息表
    v_msg_id := scmdata.t_supplier_info_import_msg_s.nextval;
  
    UPDATE scmdata.t_supplier_info_temp t
       SET t.err_msg_id = v_msg_id
     WHERE t.company_id = data_rec.company_id
       AND t.user_id = data_rec.user_id
       AND t.supplier_temp_id = data_rec.supplier_temp_id;
  
    IF v_err_num > 0 THEN
      v_import_flag := '校验错误：共' || v_err_num || '处错误。';
      INSERT INTO scmdata.t_supplier_info_import_msg
      VALUES
        (v_msg_id,
         data_rec.company_id,
         data_rec.user_id,
         'E',
         v_import_flag || v_msg,
         SYSDATE);
      --清空错误记录
      /*      v_num     := 0;
      v_err_num := 0;
      v_msg     := NULL;*/
    ELSE
      v_import_flag := '校验成功';
      INSERT INTO scmdata.t_supplier_info_import_msg
      VALUES
        (v_msg_id,
         data_rec.company_id,
         data_rec.user_id,
         'Y',
         v_import_flag,
         SYSDATE);
    END IF;
  
    --END LOOP;
  
  END check_importdatas;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 新增供应商主档临时数据
  * Obj_Name    : insert_supplier_info_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :临时数据
  *============================================*/

  PROCEDURE insert_supplier_info_temp(p_supp_rec scmdata.t_supplier_info_temp%ROWTYPE) IS
  BEGIN
  
    INSERT INTO t_supplier_info_temp
      (supplier_temp_id,
       company_id,
       user_id,
       err_msg_id,
       inside_supplier_code,
       supplier_company_name,
       cooperation_type,
       cooperation_model_code,
       cooperation_model,
       company_city,
       company_province,
       company_county,
       company_address,
       social_credit_code,
       legal_representative,
       company_contact_person,
       company_contact_phone,
       cooperation_type_code,
       company_city_code,
       company_province_code,
       company_county_code,
       memo)
    VALUES
      (p_supp_rec.supplier_temp_id,
       p_supp_rec.company_id,
       p_supp_rec.user_id,
       p_supp_rec.err_msg_id,
       p_supp_rec.inside_supplier_code,
       p_supp_rec.supplier_company_name,
       p_supp_rec.cooperation_type,
       p_supp_rec.cooperation_model_code,
       p_supp_rec.cooperation_model,
       p_supp_rec.company_city,
       p_supp_rec.company_province,
       p_supp_rec.company_county,
       p_supp_rec.company_address,
       p_supp_rec.social_credit_code,
       p_supp_rec.legal_representative,
       p_supp_rec.company_contact_person,
       p_supp_rec.company_contact_phone,
       p_supp_rec.cooperation_type_code,
       p_supp_rec.company_city_code,
       p_supp_rec.company_province_code,
       p_supp_rec.company_county_code,
       p_supp_rec.memo);
  
    --导入后校验数据 
    check_importdatas(p_company_id       => p_supp_rec.company_id,
                      p_user_id          => p_supp_rec.user_id,
                      p_supplier_temp_id => p_supp_rec.supplier_temp_id);
  
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => 'EXCEL导入供应商主档出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END insert_supplier_info_temp;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 修改供应商主档临时数据
  * Obj_Name    : update_supplier_info_temp
  * Arg_Number  : 1
  * P_CRAFT_REC :临时数据
  *============================================*/
  PROCEDURE update_supplier_info_temp(p_supp_rec scmdata.t_supplier_info_temp%ROWTYPE) IS
  BEGIN
  
    UPDATE t_supplier_info_temp t
       SET t.inside_supplier_code   = p_supp_rec.inside_supplier_code,
           t.supplier_company_name  = p_supp_rec.supplier_company_name,
           t.cooperation_type       = p_supp_rec.cooperation_type,
           t.cooperation_model_code = p_supp_rec.cooperation_model_code,
           t.cooperation_model      = p_supp_rec.cooperation_model,
           t.company_city           = p_supp_rec.company_city,
           t.company_province       = p_supp_rec.company_province,
           t.company_county         = p_supp_rec.company_county,
           t.company_address        = p_supp_rec.company_address,
           t.social_credit_code     = p_supp_rec.social_credit_code,
           t.legal_representative   = p_supp_rec.legal_representative,
           t.company_contact_person = p_supp_rec.company_contact_person,
           t.company_contact_phone  = p_supp_rec.company_contact_phone,
           t.cooperation_type_code  = p_supp_rec.cooperation_type_code,
           t.company_city_code      = p_supp_rec.company_city_code,
           t.company_province_code  = p_supp_rec.company_province_code,
           t.company_county_code    = p_supp_rec.company_county_code,
           t.memo                   = p_supp_rec.memo
     WHERE t.supplier_temp_id = p_supp_rec.supplier_temp_id;
  
    --导入后校验数据
    --导入后校验数据 待做
    check_importdatas(p_company_id       => p_supp_rec.company_id,
                      p_user_id          => p_supp_rec.user_id,
                      p_supplier_temp_id => p_supp_rec.supplier_temp_id);
  EXCEPTION
    WHEN OTHERS THEN
      sys_raise_app_error_pkg.is_running_error(p_err_msg          => 'EXCEL导入供应商主档出错，请联系管理员！',
                                               p_is_running_error => 'T');
  END update_supplier_info_temp;
  /*============================================*
  * Author   : SANFU
  * Created  : 2020-10-23 17:43:35
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 清空导入数据
  * Obj_Name    : delete_supplier_info_temp
  * Arg_Number  : 2
  * P_COMPANY_ID :企业ID
  * P_USER_ID : 用户ID
  *============================================*/
  PROCEDURE delete_supplier_info_temp(p_company_id IN VARCHAR2,
                                      p_user_id    IN VARCHAR2) IS
  
  BEGIN
    --清空临时表，导入信息表的数据
    DELETE FROM scmdata.t_supplier_info_import_msg m
     WHERE m.company_id = p_company_id
       AND m.user_id = p_user_id;
  
    DELETE FROM scmdata.t_supplier_info_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;
  
  END delete_supplier_info_temp;

  --接口获取批次
  FUNCTION get_supp_batch_id(pi_company_id VARCHAR2) RETURN VARCHAR2 IS
    v_i VARCHAR2(100);
  BEGIN
    --1.初始跑批日期
    v_i := pkg_plat_comm.f_getkeycode(pi_table_name  => 't_supplier_info_ctl',
                                      pi_column_name => 'batch_id',
                                      pi_company_id  => pi_company_id,
                                      pi_pre         => '',
                                      pi_serail_num  => 6);
  
    --2.查询监控表跑批号，并重写初始值
    SELECT decode(MAX(t.batch_id), NULL, v_i, v_i)
      INTO v_i
      FROM scmdata.t_supplier_info_ctl t;
  
    RETURN v_i;
  END get_supp_batch_id;
  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:42:18
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  : 校验导入数据
  * Obj_Name    : check_importdatas_coop_scope
  * Arg_Number  : 1
  * p_supplier_temp_id :临时表ID
  *============================================*/

  PROCEDURE check_importdatas_coop_scope(p_coop_scope_temp_id IN VARCHAR2) IS
    p_coop_scope_temp t_coop_scope_temp%ROWTYPE;
    p_flag            INT;
    p_i               INT;
    p_msg             VARCHAR2(3000);
    p_desc            VARCHAR2(100);
    p_supplier_id     VARCHAR2(32);
  BEGIN
    p_i := 0;
    SELECT t.*
      INTO p_coop_scope_temp
      FROM scmdata.t_coop_scope_temp t
     WHERE coop_scope_temp_id = p_coop_scope_temp_id;
    --校验供应商号码
    SELECT MAX(t.status),
           MAX(supplier_company_name),
           MAX(t.supplier_info_id)
      INTO p_flag, p_desc, p_supplier_id
      FROM scmdata.t_supplier_info t
     WHERE t.inside_supplier_code = p_coop_scope_temp.inside_supplier_code
       AND t.company_id = p_coop_scope_temp.company_id;
    IF p_flag IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')不存在的供应商编号,';
    
    ELSIF p_flag = 0 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')供应商未建档,';
    
    ELSIF p_desc <> p_coop_scope_temp.supplier_company_name THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')供应商编号和供应商名称不对应,当前对应为:' || p_desc || ' ,';
    
    END IF;
    --检验大类
    SELECT MAX(a.group_dict_value)
      INTO p_coop_scope_temp.coop_classification
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_coop_scope_temp.coop_classification_desc
       AND a.group_dict_type = 'PRODUCT_TYPE'
       AND pause = 0;
    IF p_coop_scope_temp.coop_classification IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')不存在的合作分类';
    ELSE
      UPDATE scmdata.t_coop_scope_temp t
         SET t.coop_classification = p_coop_scope_temp.coop_classification
       WHERE coop_scope_temp_id = p_coop_scope_temp_id;
    END IF;
    --校验分类
    SELECT MAX(a.group_dict_value)
      INTO p_coop_scope_temp.coop_product_cate
      FROM sys_group_dict a
     WHERE a.group_dict_name = p_coop_scope_temp.coop_product_cate_desc
       AND a.group_dict_type = p_coop_scope_temp.coop_classification
       AND pause = 0;
    IF p_coop_scope_temp.coop_product_cate IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')不存在的可生产类别';
    ELSE
      UPDATE scmdata.t_coop_scope_temp t
         SET t.coop_product_cate = p_coop_scope_temp.coop_product_cate
       WHERE coop_scope_temp_id = p_coop_scope_temp_id;
    
    END IF;
    IF p_supplier_id IS NOT NULL AND
       p_coop_scope_temp.coop_classification IS NOT NULL AND
       p_coop_scope_temp.coop_product_cate IS NOT NULL THEN
      SELECT nvl(MAX(1), 0)
        INTO p_flag
        FROM scmdata.t_coop_scope a
       WHERE a.supplier_info_id = p_supplier_id
         AND a.coop_classification = p_coop_scope_temp.coop_classification
         AND a.coop_product_cate = p_coop_scope_temp.coop_product_cate;
      IF p_flag = 1 THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')对应供应商档案已有重复的分类+生产类别';
      END IF;
    END IF;
  
    --校验小类
  
    IF p_coop_scope_temp.coop_subcategory_desc IS NULL THEN
      UPDATE scmdata.t_coop_scope_temp t
         SET coop_subcategory     =
             (SELECT listagg(company_dict_value, ';') within GROUP(ORDER BY 1)
                FROM sys_company_dict
               WHERE company_dict_type = p_coop_scope_temp.coop_product_cate
                 AND company_id = p_coop_scope_temp.company_id),
             coop_subcategory_desc =
             (SELECT listagg(company_dict_name, ';') within GROUP(ORDER BY 1)
                FROM sys_company_dict
               WHERE company_dict_type = p_coop_scope_temp.coop_product_cate
                 AND company_id = p_coop_scope_temp.company_id)
       WHERE coop_scope_temp_id = p_coop_scope_temp_id;
    ELSE
      SELECT listagg(c.company_dict_value, ';') within GROUP(ORDER BY 1)
        INTO p_coop_scope_temp.coop_subcategory
        FROM scmdata.sys_company_dict c
       WHERE c.company_id = p_coop_scope_temp.company_id
         AND company_dict_type = p_coop_scope_temp.coop_product_cate
         AND instr(';' || p_coop_scope_temp.coop_subcategory_desc || ';',
                   ';' || company_dict_name || ';') > 0;
      IF p_coop_scope_temp.coop_subcategory IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')不存在的可合作产品子类';
      
      ELSE
        UPDATE scmdata.t_coop_scope_temp t
           SET t.coop_subcategory = p_coop_scope_temp.coop_subcategory
         WHERE coop_scope_temp_id = p_coop_scope_temp_id;
      
      END IF;
    END IF;
  
    --校验不存在的子类
    SELECT nvl(length(regexp_replace(p_coop_scope_temp.coop_subcategory,
                                     '[^;]',
                                     '')),
               0),
           nvl(length(regexp_replace(p_coop_scope_temp.coop_subcategory_desc,
                                     '[^;]',
                                     '')),
               0)
      INTO p_i, p_flag
      FROM dual;
    IF p_i <> p_flag THEN
      SELECT listagg(c.company_dict_name, ';') within GROUP(ORDER BY 1)
        INTO p_desc
        FROM scmdata.sys_company_dict c
       WHERE c.company_id = p_coop_scope_temp.company_id
         AND company_dict_type = p_coop_scope_temp.coop_product_cate
         AND instr(';' || p_coop_scope_temp.coop_subcategory || ';',
                   ';' || company_dict_value || ';') > 0;
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')有部分产品子类没有在scm中设置，请检查，当前关联部分为：' || p_desc;
    END IF;
    --校驗子類重複
    SELECT COUNT(col) - COUNT(DISTINCT col)
      INTO p_flag
      FROM (SELECT regexp_substr(p_coop_scope_temp.coop_subcategory,
                                 '[^;]+',
                                 1,
                                 LEVEL,
                                 'i') col,
                   LEVEL seq_no
              FROM dual
            CONNECT BY LEVEL <= length(p_coop_scope_temp.coop_subcategory) -
                       length(regexp_replace(p_coop_scope_temp.coop_subcategory,
                                                      ';',
                                                      '')) + 1);
    IF p_flag > 0 THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')存在重复的可合作产品子类';
    
    END IF;
  
    SELECT MAX(a.group_dict_name)
      INTO p_desc
      FROM sys_group_dict a
     WHERE a.group_dict_value = p_coop_scope_temp.sharing_type
       AND a.group_dict_type = 'SHARE_METHOD'
       AND pause = 0;
    IF p_desc IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')不存在的是否允许关联供应商编码';
    
    ELSIF p_desc <> p_coop_scope_temp.sharing_type_desc THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')是否允许关联供应商编码和是否允许关联供应商描述不对应,当前对应为:' ||
               p_desc;
    
    END IF;
  
    IF p_coop_scope_temp.sharing_type = '02' AND
       p_coop_scope_temp.sharing_sup_code IS NULL THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')部分关联时，必须添加关联供应商列表';
    END IF;
    IF p_coop_scope_temp.sharing_sup_code IS NOT NULL THEN
      SELECT listagg(a.supplier_company_name, ';') within GROUP(ORDER BY 1)
        INTO p_desc
        FROM t_supplier_info a
       WHERE a.company_id = p_coop_scope_temp.company_id
         AND a.inside_supplier_code IN
             (SELECT regexp_substr(p_coop_scope_temp.sharing_sup_code,
                                   '[^;]+',
                                   1,
                                   LEVEL,
                                   'i')
                FROM dual
              CONNECT BY LEVEL <= length(p_coop_scope_temp.sharing_sup_code) -
                         length(regexp_replace(p_coop_scope_temp.sharing_sup_code,
                                                        ';',
                                                        '')) + 1);
      IF p_desc IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')关联供应商编码没有找到对应的供应商';
      ELSIF p_desc <> p_coop_scope_temp.sharing_sup_code_desc OR
            p_coop_scope_temp.sharing_sup_code_desc IS NULL THEN
        p_i   := p_i + 1;
        p_msg := p_msg || p_i || ')关联供应商编码和关联供应商名称描述不对应,当前对应为:' || p_desc;
      END IF;
    END IF;
  
    IF p_coop_scope_temp.sharing_sup_code LIKE
       '%' || p_coop_scope_temp.inside_supplier_code || '%' THEN
      p_i   := p_i + 1;
      p_msg := p_msg || p_i || ')关联供应商编码不能包含自身';
    END IF;
  
    IF p_msg IS NOT NULL THEN
      UPDATE scmdata.t_coop_scope_temp t
         SET t.msg_type = 'E', t.msg = p_msg
       WHERE t.coop_scope_temp_id = p_coop_scope_temp_id;
    ELSE
      UPDATE scmdata.t_coop_scope_temp t
         SET t.msg_type = 'N', t.msg = NULL
       WHERE t.coop_scope_temp_id = p_coop_scope_temp_id;
    END IF;
  END check_importdatas_coop_scope;
  /*============================================*
  * Author   : zwh73
  * Created  : 2020-10-23 17:38:28
  * ALERTER  : 
  * ALERTER_TIME  : 
  * Purpose  :  EXCEL导入 提交供应商合作范围 将临时数据提交到业务表中
  * Obj_Name    : submit_t_coop_scope_temp
  * Arg_Number  : 2
  * p_company_id :企业ID
  * p_user_id ：用户ID
  *============================================*/
  PROCEDURE submit_t_coop_scope_temp(p_company_id IN VARCHAR2,
                                     p_user_id    IN VARCHAR2) IS
    p_code VARCHAR2(32);
    p_id   VARCHAR2(32);
  BEGIN
    FOR data_rec IN (SELECT *
                       FROM scmdata.t_coop_scope_temp t
                      WHERE t.company_id = p_company_id
                        AND t.create_id = p_user_id) LOOP
      IF data_rec.msg_type = 'E' OR data_rec.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
        p_code := data_rec.inside_supplier_code;
        p_id   := f_get_uuid();
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
          (p_id,
           (SELECT supplier_info_id
              FROM t_supplier_info a
             WHERE a.inside_supplier_code = p_code
               AND a.company_id = data_rec.company_id),
           data_rec.company_id,
           data_rec.coop_mode,
           data_rec.coop_classification,
           data_rec.coop_product_cate,
           data_rec.coop_subcategory,
           data_rec.create_id,
           SYSDATE,
           data_rec.create_id,
           SYSDATE,
           NULL,
           0,
           data_rec.sharing_type);
        ---加上共享
        IF data_rec.sharing_sup_code IS NOT NULL THEN
          FOR sup IN (SELECT regexp_substr(data_rec.sharing_sup_code,
                                           '[^;]+',
                                           1,
                                           LEVEL,
                                           'i') code
                        FROM dual
                      CONNECT BY LEVEL <=
                                 length(data_rec.sharing_sup_code) -
                                 length(regexp_replace(data_rec.sharing_sup_code,
                                                       ';',
                                                       '')) + 1) LOOP
            INSERT INTO scmdata.t_supplier_shared
              (supplier_shared_id,
               company_id,
               supplier_info_id,
               shared_supplier_code,
               remarks,
               coop_scope_id)
            VALUES
              (f_get_uuid(),
               data_rec.company_id,
               (SELECT a.supplier_info_id
                  FROM t_supplier_info a
                 WHERE a.inside_supplier_code =
                       data_rec.inside_supplier_code
                   AND a.company_id = data_rec.company_id),
               (SELECT a.supplier_code
                  FROM t_supplier_info a
                 WHERE a.inside_supplier_code = sup.code
                   AND a.company_id = data_rec.company_id),
               NULL,
               p_id);
          END LOOP;
        END IF;
      END IF;
    END LOOP;
  
    --清空
    DELETE FROM scmdata.t_coop_scope_temp
     WHERE company_id = p_company_id
       AND create_id = p_user_id;
  END submit_t_coop_scope_temp;
  --校验合作范围  p_status： IU 新增/更新 D 删除
  PROCEDURE check_coop_scopre(p_cp_data scmdata.t_coop_scope%ROWTYPE,
                              p_status  VARCHAR2) IS
    v_flag NUMBER := 0; --校验重复
    v_num  NUMBER := 0; --校验是否只剩最后一条
  BEGIN
    IF p_status = 'IU' THEN
      --1) 新增/更新 校验合作分类，可生产类别，可合作产品子类不可重复
      SELECT COUNT(1)
        INTO v_flag
        FROM t_coop_scope t
       WHERE t.company_id = p_cp_data.company_id
         AND t.supplier_info_id = p_cp_data.supplier_info_id
         AND t.coop_classification = p_cp_data.coop_classification
         AND t.coop_product_cate = p_cp_data.coop_product_cate
         AND t.coop_scope_id <> p_cp_data.coop_scope_id;
    
      IF v_flag > 0 THEN
        raise_application_error(-20002,
                                '合作分类、可生产类别，已经存在，请重新填写！');
      END IF;
    ELSIF p_status = 'D' THEN
    
      --2) 删除 当合作范围只有1条数据时，不可删除
      SELECT COUNT(1)
        INTO v_num
        FROM t_coop_scope t
       WHERE t.company_id = p_cp_data.company_id
         AND t.supplier_info_id = p_cp_data.supplier_info_id;
    
      IF v_num = 1 THEN
        raise_application_error(-20002,
                                '删除失败！合作范围需至少保留1条数据！');
      END IF;
    END IF;
  END check_coop_scopre;

  --新增合作范围
  PROCEDURE insert_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE) IS
  BEGIN
    --校验合作范围  p_status： IU 新增/更新 D 删除
    check_coop_scopre(p_cp_data => p_cp_data, p_status => 'IU');
  
    INSERT INTO t_coop_scope
      (coop_scope_id,
       supplier_info_id,
       company_id,
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
       publish_id,
       publish_date)
    VALUES
      (p_cp_data.coop_scope_id,
       p_cp_data.supplier_info_id,
       p_cp_data.company_id,
       p_cp_data.coop_classification,
       p_cp_data.coop_product_cate,
       p_cp_data.coop_subcategory,
       p_cp_data.create_id,
       p_cp_data.create_time,
       p_cp_data.update_id,
       p_cp_data.update_time,
       p_cp_data.remarks,
       p_cp_data.pause,
       p_cp_data.sharing_type,
       p_cp_data.publish_id,
       p_cp_data.publish_date);
  
  END insert_coop_scope;
  --修改合作范围
  PROCEDURE update_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE) IS
  BEGIN
    --校验合作范围  p_status： IU 新增/更新 D 删除
    check_coop_scopre(p_cp_data => p_cp_data, p_status => 'IU');
  
    UPDATE t_coop_scope t
       SET t.coop_classification = p_cp_data.coop_classification,
           t.coop_product_cate   = p_cp_data.coop_product_cate,
           t.coop_subcategory    = p_cp_data.coop_subcategory,
           t.update_id           = p_cp_data.update_id,
           t.update_time         = p_cp_data.update_time,
           t.sharing_type        = p_cp_data.sharing_type
     WHERE t.company_id = p_cp_data.company_id
       AND t.supplier_info_id = p_cp_data.supplier_info_id
       AND t.coop_scope_id = p_cp_data.coop_scope_id;
  
  END update_coop_scope;

  --删除合作范围
  PROCEDURE delete_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE) IS
  BEGIN
    --校验合作范围  p_status： IU 新增/更新 D 删除
    check_coop_scopre(p_cp_data => p_cp_data, p_status => 'D');
  
    DELETE FROM scmdata.t_supplier_shared t
     WHERE t.company_id = p_cp_data.company_id
       AND t.supplier_info_id = p_cp_data.supplier_info_id
       AND t.coop_scope_id = p_cp_data.coop_scope_id;
  
    DELETE FROM t_coop_scope t
     WHERE t.company_id = p_cp_data.company_id
       AND t.supplier_info_id = p_cp_data.supplier_info_id
       AND t.coop_scope_id = p_cp_data.coop_scope_id;
  
  END delete_coop_scope;

END pkg_supplier_info;
/
