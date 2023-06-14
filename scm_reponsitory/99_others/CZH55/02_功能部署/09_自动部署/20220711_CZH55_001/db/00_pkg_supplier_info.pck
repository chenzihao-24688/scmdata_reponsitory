CREATE OR REPLACE PACKAGE scmdata.pkg_supplier_info IS

  -- Author  : SANFU
  -- Created : 2020/11/6 14:52:03
  -- Purpose :
  ----------------------------------------------------  配置代码   begin  ----------------------------------------------------------------------------
  --Query
  --供应商管理
  --待建档
  FUNCTION f_query_unfile_supp_info RETURN CLOB;
  --已建档
  FUNCTION f_query_filed_supp_info RETURN CLOB;
  --合作状态
  FUNCTION f_query_coop_status_looksql(p_coop_status_field VARCHAR2,
                                       p_suffix            VARCHAR2)
    RETURN CLOB;

  --获取组织架构 人员信息
  FUNCTION f_query_person_info_looksql(p_person_field VARCHAR2,
                                       p_suffix       VARCHAR2,
                                       p_coop_type    VARCHAR2,
                                       p_coop_cate    VARCHAR2) RETURN CLOB;

  --获取组织架构 人员信息 pick
  FUNCTION f_query_person_info_pick(p_person_field VARCHAR2,
                                    p_suffix       VARCHAR2) RETURN CLOB;

  --合作范围  begin
  --select_sql
  FUNCTION f_query_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB;
  --insert sql
  FUNCTION f_insert_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB;
  --update sql
  FUNCTION f_update_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB;
  --delete sql
  FUNCTION f_delete_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB;
  --合作范围  end
  --合作工厂 begin 'a_supp_151_7'
  --select_sql
  FUNCTION f_query_coop_factory_list(p_item_id VARCHAR2) RETURN CLOB;
  --insert sql
  FUNCTION f_insert_coop_factory_list(p_item_id VARCHAR2) RETURN CLOB;
  --获取合作工厂 pick
  FUNCTION f_query_coop_factory_pick(p_item_id VARCHAR2) RETURN CLOB;
  --合作工厂类型
  FUNCTION f_query_fac_type_looksql(p_fac_type_field VARCHAR2,
                                    p_suffix         VARCHAR2) RETURN CLOB;
  --启用 停用 按钮
  PROCEDURE p_coop_fac_pause(p_company_id      VARCHAR2,
                             p_coop_factory_id VARCHAR2,
                             p_user_id         VARCHAR2,
                             p_status          VARCHAR2);
  --更新合作工厂状态
  PROCEDURE update_coop_fac_status(p_company_id VARCHAR2,
                                   p_sup_id     VARCHAR2,
                                   p_fac_id     VARCHAR2 DEFAULT NULL,
                                   p_status     NUMBER,
                                   p_pause_type VARCHAR2);
  --供应商与工厂合作关系 启停状态校验
  --供应商/工厂 启停按钮触发
  PROCEDURE p_check_sup_fac_pause(p_company_id VARCHAR2, p_sup_id VARCHAR2);

  --供应商的合作范围与工厂合作关系 启停状态校验
  PROCEDURE p_check_coop_fac_pause(p_company_id VARCHAR2,
                                   p_sup_id     VARCHAR2,
                                   p_type       VARCHAR2);

  --合作工厂 end
  ----------------------------------------------------  配置代码   end  ----------------------------------------------------------------------------

  ----------------------------------------------------  业务代码   begin  ---------------------------------------------------------------------------
  --新增合作工厂
  PROCEDURE p_insert_coop_factory(p_fac_rec scmdata.t_coop_factory%ROWTYPE);
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
  PROCEDURE check_t_supplier_info(p_supplier_info_id VARCHAR2);
  --校验统一信用代码
  PROCEDURE p_check_social_credit_code(p_company_id         VARCHAR2,
                                       p_supplier_info_id   VARCHAR2,
                                       p_social_credit_code VARCHAR2);
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

  PROCEDURE check_save_t_supplier_info(p_sp_data scmdata.t_supplier_info%ROWTYPE);
  --校验工厂信息
  /*  FUNCTION check_fask_data(p_company_id       VARCHAR2,
  p_factory_ask_id   VARCHAR2,
  p_com_manufacturer VARCHAR2) RETURN NUMBER;*/

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

  --通过区域 分部获取分组配置id
  FUNCTION f_get_category_config_by_pick(p_company_id VARCHAR2,
                                         p_supp_id    VARCHAR2,
                                         p_province   VARCHAR2,
                                         p_city       VARCHAR2)
    RETURN VARCHAR2;

  --保存时 通过所属品类 获取所在分组 
  FUNCTION f_get_category_config(p_company_id VARCHAR2, p_supp_id VARCHAR2)
    RETURN VARCHAR2;

  --通过所属区域  获取所在分组
  /*  FUNCTION get_area_config(p_company_id VARCHAR2, p_supp_id VARCHAR2)
  RETURN VARCHAR2;*/

  --获取分组
  --所在分组根据供应商的品类、区域，从所在分组配置中匹配，自动获取对应分组；
  FUNCTION f_get_group_config_id(p_company_id VARCHAR2,
                                 p_supp_id    VARCHAR2,
                                 p_is_by_pick INT DEFAULT 0,
                                 p_province   VARCHAR2 DEFAULT NULL,
                                 p_city       VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2;
  --获取分组
  FUNCTION f_get_group_name(p_company_id      VARCHAR2,
                            p_group_config_id VARCHAR2) RETURN VARCHAR2;
  --批量更新所在分组
  PROCEDURE p_batch_update_group_name(p_company_id VARCHAR2,
                                      p_is_trigger INT DEFAULT 0,
                                      p_pause      INT DEFAULT 1,
                                      p_is_by_pick INT DEFAULT 0);
  --更新所在区域 区域组长
  PROCEDURE p_update_group_name(p_company_id       VARCHAR2,
                                p_supplier_info_id VARCHAR2,
                                p_is_create_sup    INT DEFAULT 0,
                                p_is_trigger       INT DEFAULT 0,
                                p_pause            INT DEFAULT 1,
                                p_is_by_pick       INT DEFAULT 0,
                                p_province         VARCHAR2 DEFAULT NULL,
                                p_city             VARCHAR2 DEFAULT NULL);

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

  PROCEDURE create_t_supplier_info(p_company_id      VARCHAR2,
                                   p_factory_ask_id  VARCHAR2,
                                   p_user_id         VARCHAR2,
                                   p_is_trialorder   NUMBER,
                                   p_trialorder_type VARCHAR2);

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

  PROCEDURE insert_supplier_info(p_sp_data scmdata.t_supplier_info%ROWTYPE);
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

  PROCEDURE update_supplier_info(p_sp_data t_supplier_info%ROWTYPE,
                                 p_item_id VARCHAR2 DEFAULT NULL);

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
  /*校验合同批量导入*/
  PROCEDURE check_import_constract(p_temp_id IN VARCHAR2);
  /*提交批量导入的合同*/

  PROCEDURE submit_t_contract_info(p_company_id IN VARCHAR2,
                                   p_user_id    IN VARCHAR2);
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
  PROCEDURE insert_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE,
                              p_type    NUMBER DEFAULT 1);
  --修改合作范围
  PROCEDURE update_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --删除合作范围
  PROCEDURE delete_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE);
  --获取供应商批次
  --FUNCTION get_supp_batch_id(pi_company_id VARCHAR2) RETURN VARCHAR2;
  --新增关联供应商
  PROCEDURE insert_supplier_shared(scope_rec       scmdata.t_coop_scope%ROWTYPE,
                                   p_supplier_code VARCHAR2);
  --删除关联供应商
  PROCEDURE delete_supplier_shared(p_supplier_shared_id VARCHAR2);

  --获取供应流程状态
  PROCEDURE get_supp_oper_status(p_factory_ask_id VARCHAR2,
                                 po_flow_status   OUT VARCHAR2,
                                 po_flow_node     OUT VARCHAR2);
  --供应流程 触发企微机器人发送消息
  FUNCTION send_fac_wx_msg(p_company_id     VARCHAR2,
                           p_factory_ask_id VARCHAR2,
                           p_msgtype        VARCHAR2, --消息类型 text、markdown
                           p_msg_title      VARCHAR2, --消息标题
                           p_bot_key        VARCHAR2, --机器人key
                           p_robot_type     VARCHAR2 --机器人配置类型
                           ) RETURN CLOB;
  ----------------------------------------------------  业务代码   end  ---------------------------------------------------------------------------
END pkg_supplier_info;
/
CREATE OR REPLACE PACKAGE BODY scmdata.pkg_supplier_info IS
  ----------------------------------------------------  配置代码   begin  ----------------------------------------------------------------------------
  --Query
  --供应商管理
  --待建档
  FUNCTION f_query_unfile_supp_info RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[--优化后的查询代码
WITH dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id,
         pause
    FROM scmdata.sys_group_dict
   WHERE pause = 0)
SELECT v.supplier_info_id,
       v.company_id,
       v.status,
       v.pause coop_status,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       nvl(v.cooperation_classification_sp, '') cooperation_classification_sp, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       v.cooperation_model_sp,
       v.company_type,
       v.cooperation_method_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.cooperation_type_sp,
       v.fa_contact_name,
       v.fa_contact_phone,
       v.supplier_info_origin,
       v.supplier_info_origin_id factory_ask_id,
       CASE
         WHEN fa.is_urgent = '1' THEN
          10090495
         ELSE
          NULL
       END gridbackcolor
  FROM (SELECT e.group_dict_name supplier_info_origin,
               sp.status,
               sp.pause,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation,
               ar.ask_date,
               fr.check_date,
               sp.create_supp_date,
               sp.social_credit_code,
               sp.regist_address,
               sp.legal_representative,
               sp.company_create_date,
               sp.regist_price,
               a.group_dict_name cooperation_type_sp,
               va.coop_classification,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                  FROM dic t
                 WHERE t.group_dict_type = sp.cooperation_type
                   AND instr(';' || va.coop_classification || ';',
                             ';' || t.group_dict_value || ';') > 0) cooperation_classification_sp,
               b.group_dict_name cooperation_method_sp,
               (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
                  FROM dic
                 WHERE group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || sp.cooperation_model || ';',
                             ';' || group_dict_value || ';') > 0) cooperation_model_sp,
               d.group_dict_name production_mode_sp,
               sp.fa_contact_name,
               sp.fa_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id,
               f.group_dict_name company_type
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
          LEFT JOIN scmdata.sys_group_dict e
            ON e.group_dict_type = 'ORIGIN_TYPE'
           AND e.group_dict_value = sp.supplier_info_origin
          LEFT JOIN dic a
            ON a.group_dict_type = 'COOPERATION_TYPE'
           AND sp.cooperation_type = a.group_dict_value
          LEFT JOIN dic b
            ON b.group_dict_type = 'COOP_METHOD'
           AND b.group_dict_value = sp.cooperation_method
          LEFT JOIN dic d
            ON d.group_dict_type = 'CPMODE_TYPE'
           AND d.group_dict_value = sp.production_mode
          LEFT JOIN dic f
            ON f.group_dict_type = 'COMPANY_TYPE'
           AND f.group_dict_value = sp.company_type
          LEFT JOIN (SELECT listagg(DISTINCT sa.coop_classification, ';') within GROUP(ORDER BY sa.coop_classification) coop_classification,
                            sa.supplier_info_id,
                            sa.company_id
                      FROM scmdata.t_coop_scope sa
                     WHERE sa.pause = 0
                     GROUP BY sa.supplier_info_id, sa.company_id) va
            ON va.supplier_info_id = sp.supplier_info_id
           AND va.company_id = sp.company_id
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 0
           AND sp.supplier_info_origin <> 'II') v --先不展示接口导入的数据
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
 WHERE ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => @subsql@,
                   p_str2  => v.coop_classification,
                   p_split => ';') > 0)
 ORDER BY nvl(fa.is_urgent, 0) DESC,
          v.create_date DESC,
          v.supplier_info_id DESC
]';
    RETURN v_query_sql;
  END f_query_unfile_supp_info;

  --已建档
  FUNCTION f_query_filed_supp_info RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[
--优化后的查询代码
--增加数据权限函数
WITH dic AS
 (SELECT group_dict_value,
         group_dict_name,
         group_dict_type,
         group_dict_id,
         parent_id,
         pause
    FROM scmdata.sys_group_dict
   WHERE pause = 0)
SELECT v.supplier_info_id,
       v.company_id,
       v.status,
       v.pause coop_status,
       v.supplier_code,
       v.inside_supplier_code,
       v.supplier_company_id,
       v.supplier_company_name,
       v.supplier_company_abbreviation,
       nvl(v.cooperation_classification_sp, '') cooperation_classification_sp, --合作分类：不验厂取申请单的数据，验厂取报告以及能力评估明细表
       v.cooperation_model_sp,
       v.group_name,
       v.flw_order,
       v.company_type,
       v.cooperation_method_sp,
       v.production_mode_sp,
       v.ask_date,
       v.check_date,
       v.create_supp_date,
       v.social_credit_code,
       v.cooperation_type_sp,
       v.regist_status,
       v.bind_status,
       v.fa_contact_name,
       v.fa_contact_phone,
       v.supplier_info_origin,
       v.supplier_info_origin_id factory_ask_id
  FROM (SELECT e.group_dict_name supplier_info_origin,
               sp.status,
               sp.pause,
               nvl2(sp.supplier_company_id, '已注册', '未注册') regist_status,
               sp.bind_status,
               sp.supplier_code,
               sp.inside_supplier_code,
               sp.supplier_company_name,
               sp.supplier_company_abbreviation,
               ar.ask_date,
               fr.check_date,
               sp.create_supp_date,
               sp.social_credit_code,
               sp.regist_address,
               sp.legal_representative,
               sp.company_create_date,
               sp.regist_price,
               a.group_dict_name cooperation_type_sp,
               va.coop_classification,
               (SELECT listagg(DISTINCT t.group_dict_name, ';') within GROUP(ORDER BY t.group_dict_value)
                  FROM dic t
                 WHERE t.group_dict_type = sp.cooperation_type
                   AND instr(';' || va.coop_classification || ';',
                             ';' || t.group_dict_value || ';') > 0) cooperation_classification_sp,
               b.group_dict_name cooperation_method_sp,
               (SELECT listagg(group_dict_name, ';') within GROUP(ORDER BY group_dict_value)
                  FROM dic
                 WHERE group_dict_type = 'SUPPLY_TYPE'
                   AND instr(';' || sp.cooperation_model || ';',
                             ';' || group_dict_value || ';') > 0) cooperation_model_sp,
               (SELECT listagg(fu_a.company_user_name, ',')
                  FROM scmdata.sys_company_user fu_a
                 WHERE fu_a.company_id = sp.company_id
                   AND instr(',' || sp.gendan_perid || ',',
                             ',' || fu_a.user_id || ',') > 0) flw_order,
               d.group_dict_name production_mode_sp,
               sp.fa_contact_name,
               sp.fa_contact_phone,
               sp.create_date,
               sp.supplier_info_origin_id,
               sp.cooperation_type,
               sp.supplier_info_id,
               sp.supplier_company_id,
               sp.company_id,
               f.group_dict_name company_type,
               sp.group_name
          FROM scmdata.t_supplier_info sp
          LEFT JOIN scmdata.t_factory_ask fa
            ON sp.supplier_info_origin_id = fa.factory_ask_id
          LEFT JOIN scmdata.t_factory_report fr
            ON fa.factory_ask_id = fr.factory_ask_id
          LEFT JOIN scmdata.t_ask_record ar
            ON fa.ask_record_id = ar.ask_record_id
          LEFT JOIN scmdata.sys_company fc
            ON sp.social_credit_code = fc.licence_num
          LEFT JOIN dic e
            ON e.group_dict_type = 'ORIGIN_TYPE'
           AND e.group_dict_value = sp.supplier_info_origin
          LEFT JOIN dic a
            ON a.group_dict_type = 'COOPERATION_TYPE'
           AND sp.cooperation_type = a.group_dict_value
          LEFT JOIN dic b
            ON b.group_dict_type = 'COOP_METHOD'
           AND b.group_dict_value = sp.cooperation_method
          LEFT JOIN dic d
            ON d.group_dict_type = 'CPMODE_TYPE'
           AND d.group_dict_value = sp.production_mode
          LEFT JOIN dic f
            ON f.group_dict_type = 'COMPANY_TYPE'
           AND f.group_dict_value = sp.company_type
          LEFT JOIN (SELECT listagg(DISTINCT sa.coop_classification, ';') within GROUP(ORDER BY sa.coop_classification) coop_classification,
                            sa.supplier_info_id,
                            sa.company_id
                      FROM scmdata.t_coop_scope sa
                     WHERE sa.pause = 0
                     GROUP BY sa.supplier_info_id, sa.company_id) va
            ON va.supplier_info_id = sp.supplier_info_id
           AND va.company_id = sp.company_id
         WHERE sp.company_id = %default_company_id%
           AND sp.status = 1
           AND sp.supplier_info_origin <> 'II') v --先不展示接口导入的数据
  LEFT JOIN scmdata.t_factory_ask fa
    ON fa.factory_ask_id = v.supplier_info_origin_id
 WHERE ((%is_company_admin% = 1) OR
       instr_priv(p_str1  => @subsql@,
                   p_str2  => v.coop_classification,
                   p_split => ';') > 0)
 ORDER BY v.create_date DESC, v.supplier_info_id DESC
]';
    RETURN v_query_sql;
  END f_query_filed_supp_info;

  --合作状态
  FUNCTION f_query_coop_status_looksql(p_coop_status_field VARCHAR2,
                                       p_suffix            VARCHAR2)
    RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_coop_status_field ||
                   ', t.group_dict_name ' || p_coop_status_field ||
                   p_suffix || '
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''COOP_STATUS''
     ORDER BY t.group_dict_sort asc';
    RETURN v_query_sql;
  END f_query_coop_status_looksql;

  --获取组织架构 指定跟单员 信息 lookup
  FUNCTION f_query_person_info_looksql(p_person_field VARCHAR2,
                                       p_suffix       VARCHAR2,
                                       p_coop_type    VARCHAR2,
                                       p_coop_cate    VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
  
    v_query_sql := 'SELECT /*d.dept_name,b.avatar,*/ DISTINCT a.user_id ' ||
                   p_person_field || ', a.company_user_name ' ||
                   p_person_field || p_suffix || '
      FROM sys_company_user a
  INNER JOIN sys_user b
    ON a.user_id = b.user_id
  LEFT JOIN sys_company_user_dept c
    ON a.user_id = c.user_id
   AND a.company_id = c.company_id
  LEFT JOIN sys_company_dept d
    ON c.company_dept_id = d.company_dept_id
   AND c.company_id = d.company_id
  LEFT JOIN scmdata.sys_company_dept_cate_map e
    ON d.company_id = e.company_id
   AND d.company_dept_id = e.company_dept_id
  INNER JOIN scmdata.sys_company_job f 
   ON f.job_id  = a.job_id
   AND f.company_id = a.company_id
   AND f.company_job_id IN (''1001005003005002001'',''1001005003005002'')
 WHERE a.company_id = %default_company_id%
   AND e.cooperation_type = ''' || p_coop_type || '''
   AND instr(''' || p_coop_cate || ''', e.cooperation_classification) > 0
   AND a.pause = 0
   AND b.pause = 0
   AND e.pause = 0';
    RETURN v_query_sql;
  
  END f_query_person_info_looksql;

  --获取组织架构 人员信息 pick
  FUNCTION f_query_person_info_pick(p_person_field VARCHAR2,
                                    p_suffix       VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT d.dept_name, b.avatar, a.user_id ' ||
                   p_person_field || ', a.company_user_name ' ||
                   p_person_field || p_suffix || ' ,a.phone ' ||
                   p_person_field || '_phone' || '
  FROM sys_company_user a
 INNER JOIN sys_user b
    ON a.user_id = b.user_id
  LEFT JOIN sys_company_user_dept c
    ON a.user_id = c.user_id
   AND a.company_id = c.company_id
  LEFT JOIN sys_company_dept d
    ON c.company_dept_id = d.company_dept_id
   AND c.company_id = d.company_id
 WHERE a.company_id = %default_company_id%
   AND a.pause = 0
   AND b.pause = 0';
    RETURN v_query_sql;
  END f_query_person_info_pick;

  --合作范围  begin  'a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1'
  --select_sql
  FUNCTION f_query_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[SELECT tc.coop_scope_id,
       tc.pause,
       tc.coop_classification,
       a.group_dict_name coop_classification_desc,
       tc.coop_product_cate,
       b.group_dict_name coop_product_cate_desc,
       tc.coop_subcategory,
       (SELECT listagg(c.company_dict_name, ';')
          FROM scmdata.sys_company_dict c
         WHERE c.company_id = %default_company_id%
           AND c.company_dict_type = b.group_dict_value
           AND instr(';' || tc.coop_subcategory || ';',
                     ';' || c.company_dict_value || ';') > 0) coop_subcategory_desc
  FROM scmdata.t_coop_scope tc
 INNER JOIN scmdata.sys_group_dict a
    ON tc.coop_classification = a.group_dict_value
   AND a.group_dict_type = 'PRODUCT_TYPE'
 INNER JOIN scmdata.sys_group_dict b
    ON b.group_dict_type = a.group_dict_value
   AND tc.coop_product_cate = b.group_dict_value
 WHERE tc.supplier_info_id = :supplier_info_id
   AND tc.company_id = %default_company_id%
   ORDER BY tc.create_time asc]';
    IF p_item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1') THEN
      RETURN v_query_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_query_sup_coop_list;
  --insert sql
  FUNCTION f_insert_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_insert_sql CLOB;
  BEGIN
    v_insert_sql := q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN
  p_cp_data.coop_scope_id       := scmdata.f_get_uuid();
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.create_id           := %user_id%;
  p_cp_data.create_time         := SYSDATE;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  p_cp_data.remarks             := '';
  p_cp_data.pause               := 0;
  p_cp_data.sharing_type        := :sharing_type;
  p_cp_data.publish_id          := '';
  p_cp_data.publish_date        := '';

  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.insert_coop_scope(p_cp_data => p_cp_data);
  END IF;]' || CASE
                      WHEN p_item_id = 'a_supp_161_1' THEN
                       q'[
  --2.同步更新合作工厂-合作关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => :supplier_info_id);
  --3.新增日志操作
  --scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-新增合作范围','',%user_id%,%default_company_id%,SYSDATE);

  --ZC314ADD
  SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                V_TAB        => 'SCMDATA.T_COOP_SCOPE',
                                                V_VIEWTAB    => NULL,
                                                V_UNQFIELDS  => 'COOP_SCOPE_ID,COMPANY_ID',
                                                V_CKFIELDS   => 'COOP_CLASSIFICATION,COOP_PRODUCT_CATE,COOP_SUBCATEGORY,PAUSE,CREATE_ID,CREATE_TIME',
                                                V_CONDS      => 'COOP_SCOPE_ID = '''||p_cp_data.coop_scope_id||''' AND COMPANY_ID = '''||%DEFAULT_COMPANY_ID%||'''',
                                                V_METHOD     => 'INS',
                                                V_VIEWLOGIC  => NULL,
                                                V_QUEUETYPE  => 'CAPC_SUPFILE_COOPSCOPEINFO_IU');]'
                      ELSE
                       NULL
                    END || q'[
END;]';
    IF p_item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1') THEN
      RETURN v_insert_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_insert_sup_coop_list;
  --update sql
  FUNCTION f_update_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_update_sql CLOB;
  BEGIN
    v_update_sql := q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
  --v_company_province VARCHAR2(32); 
  --v_company_city VARCHAR2(32);
BEGIN
  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  p_cp_data.coop_classification := :coop_classification;
  p_cp_data.coop_product_cate   := :coop_product_cate;
  p_cp_data.coop_subcategory    := :coop_subcategory;
  p_cp_data.update_id           := %user_id%;
  p_cp_data.update_time         := SYSDATE;
  IF p_cp_data.coop_product_cate IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '生产类别不能为空，请填写');
  ELSIF p_cp_data.coop_subcategory IS NULL THEN RAISE_APPLICATION_ERROR(-20002, '合作产品子类不能为空，请填写');
  ELSE
  scmdata.pkg_supplier_info.update_coop_scope(p_cp_data => p_cp_data);
  END IF;
  --1.更新所在分组
  /*SELECT sp.company_province, sp.company_city
    INTO v_company_province, v_company_city
    FROM scmdata.t_supplier_info sp
   WHERE sp.supplier_info_id = :supplier_info_id
     AND sp.company_id = %default_company_id%;

  --更新所在分组，区域组长
  pkg_supplier_info.p_update_group_name(p_company_id       => %default_company_id%,
                                        p_supplier_info_id => :supplier_info_id,
                                        p_is_by_pick       => 1,
                                        p_province         => v_company_province,
                                        p_city             => v_company_city);*/]' || CASE
                      WHEN p_item_id = 'a_supp_161_1' THEN
                       q'[
  --2.同步更新合作工厂-合作关系
  pkg_supplier_info.p_check_sup_fac_pause(p_company_id => %default_company_id%,p_sup_id => :supplier_info_id);
  --3.新增日志操作
  --scmdata.pkg_supplier_info.insert_oper_log(:supplier_info_id,'修改档案-修改合作范围','',%user_id%,%default_company_id%,SYSDATE);

  --ZC314 ADD
  SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                V_TAB        => 'SCMDATA.T_COOP_SCOPE',
                                                V_VIEWTAB    => NULL,
                                                V_UNQFIELDS  => 'COOP_SCOPE_ID,COMPANY_ID',
                                                V_CKFIELDS   => 'COOP_CLASSIFICATION,COOP_PRODUCT_CATE,COOP_SUBCATEGORY,PAUSE,UPDATE_ID,UPDATE_TIME',
                                                V_CONDS      => 'COOP_SCOPE_ID = '''||:COOP_SCOPE_ID||''' AND COMPANY_ID = '''||%DEFAULT_COMPANY_ID%||'''',
                                                V_METHOD     => 'UPD',
                                                V_VIEWLOGIC  => NULL,
                                                V_QUEUETYPE  => 'CAPC_SUPFILE_COOPSCOPEINFO_IU');]'
                      ELSE
                       NULL
                    END || q'[
END;]';
    IF p_item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1') THEN
      RETURN v_update_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_update_sup_coop_list;

  --delete sql
  FUNCTION f_delete_sup_coop_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_delete_sql CLOB;
  BEGIN
    v_delete_sql := q'[DECLARE
  p_cp_data scmdata.t_coop_scope%ROWTYPE;
BEGIN
  p_cp_data.coop_scope_id       := :coop_scope_id;
  p_cp_data.supplier_info_id    := :supplier_info_id;
  p_cp_data.company_id          := %default_company_id%;
  scmdata.pkg_supplier_info.delete_coop_scope(p_cp_data => p_cp_data);
  --更新所在分组，区域组长
  pkg_supplier_info.p_update_group_name(p_company_id  => %default_company_id%,p_supplier_info_id => :supplier_info_id);
END;]';
    IF p_item_id IN ('a_supp_151_1', 'a_supp_161_1', 'a_supp_171_1') THEN
      RETURN v_delete_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_delete_sup_coop_list;
  --合作范围  end

  --合作工厂 begin 'a_supp_151_7'
  --select_sql
  FUNCTION f_query_coop_factory_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := q'[WITH group_dict AS
 (SELECT t.group_dict_type,
         t.group_dict_value,
         t.group_dict_name,
         t.group_dict_id,
         t.parent_id
    FROM scmdata.sys_group_dict t
   WHERE t.pause = 0)
   SELECT f.coop_factory_id,
       f.supplier_info_id,
       f.fac_sup_info_id,
       f.company_id,
       sp.SUPPLIER_CODE supplier_code,
       sp.SUPPLIER_COMPANY_NAME factory_name,
       f.factory_type coop_factory_type,
       decode(f.pause, 1, 1, 0) coop_status,
       sp.worker_num,
       sp.machine_num,
       sp.product_efficiency,
       sp.work_hours_day,
       sp.product_type,
       sp.product_link,
       sp.product_line,
       --sp.cooperation_brand,
       (SELECT listagg(b.group_dict_name, ';') within GROUP(ORDER BY b.group_dict_value)
          FROM group_dict t
          LEFT JOIN group_dict b
            ON t.group_dict_type = 'COOPERATION_BRAND'
           AND t.group_dict_id = b.parent_id
           AND instr(';' || sp.brand_type || ';',
                     ';' || t.group_dict_value || ';') > 0
           AND instr(';' || sp.cooperation_brand || ';',
                     ';' || b.group_dict_value || ';') > 0) cooperation_brand_desc,
       nvl(s_a.nick_name,s_a.company_user_name) create_id,
       f.create_time,
       nvl(s_b.nick_name,s_b.company_user_name) update_id,
       f.update_time
  FROM scmdata.t_coop_factory f
 INNER JOIN scmdata.t_supplier_info sp
    ON f.company_id = sp.company_id
   AND f.fac_sup_info_id  = sp.supplier_info_id
 LEFT JOIN scmdata.sys_company_user s_a on f.create_id = s_a.user_id and f.company_id = s_a.company_id
 LEFT JOIN scmdata.sys_company_user s_b on f.update_id = s_b.user_id and f.company_id = s_b.company_id
 WHERE f.supplier_info_id = :supplier_info_id  --substr(:supplier_info_id,1,instr(:supplier_info_id,';')-1)
   AND f.company_id = %default_company_id%
   AND SP.STATUS = 1
 ORDER BY f.factory_type ASC]';
    IF p_item_id IN ('a_supp_151_7') THEN
      RETURN v_query_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_query_coop_factory_list;
  --insert sql
  FUNCTION f_insert_coop_factory_list(p_item_id VARCHAR2) RETURN CLOB IS
    v_insert_sql CLOB;
  BEGIN
    v_insert_sql := q'[DECLARE
      v_fac_rec scmdata.t_coop_factory%ROWTYPE;
    BEGIN
      v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
      v_fac_rec.company_id       := %default_company_id%;
      v_fac_rec.fac_sup_info_id  := :fac_sup_info_id;
      v_fac_rec.factory_code     := :supplier_code;
      v_fac_rec.factory_name     := :factory_name;
      v_fac_rec.factory_type     := :coop_factory_type;
      v_fac_rec.pause            := :coop_status;
      v_fac_rec.create_id        := :user_id;
      v_fac_rec.create_time      := SYSDATE;
      v_fac_rec.update_id        := :user_id;
      v_fac_rec.update_time      := SYSDATE;
      v_fac_rec.memo             := :memo;
      v_fac_rec.supplier_info_id := :supplier_info_id;
      scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);

      --ZC314 ADD
      SCMDATA.PKG_CAPACITY_INQUEUE.P_COMMON_INQUEUE(V_CURUSERID  => %CURRENT_USERID%,
                                                    V_COMPID     => %DEFAULT_COMPANY_ID%,
                                                    V_TAB        => 'SCMDATA.T_COOP_FACTORY',
                                                    V_VIEWTAB    => NULL,
                                                    V_UNQFIELDS  => 'COOP_FACTORY_ID,COMPANY_ID',
                                                    V_CKFIELDS   => 'FACTORY_CODE,PAUSE,CREATE_ID,CREATE_TIME',
                                                    V_CONDS      => 'COOP_FACTORY_ID = '''||:COOP_FACTORY_ID||''' AND COMPANY_ID = '''||%DEFAULT_COMPANY_ID%||'''',
                                                    V_METHOD     => 'UPD',
                                                    V_VIEWLOGIC  => NULL,
                                                    V_QUEUETYPE  => 'CAPC_SUPFILE_COOPFACINFO_IU');
    END;]';
    IF p_item_id IN ('a_supp_151_7') THEN
      RETURN v_insert_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_insert_coop_factory_list;

  --获取合作工厂 pick
  FUNCTION f_query_coop_factory_pick(p_item_id VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
  
    v_query_sql := '{DECLARE
v_coop_class varchar2(4000);
v_sql clob;
BEGIN
  SELECT listagg(tc.coop_classification, '';'') coop_class
    INTO v_coop_class
    FROM scmdata.t_coop_scope tc
   WHERE tc.supplier_info_id = :supplier_info_id
     AND tc.company_id = :company_id
     AND tc.pause = 0;

   v_sql :=  ''SELECT distinct sp.supplier_code,sp.supplier_info_id fac_sup_info_id, sp.supplier_company_name factory_name,
       decode(sp.pause,1,1,0) coop_status,''''01'''' coop_factory_type,:supplier_info_id supplier_info_id
    FROM scmdata.t_supplier_info sp
   INNER JOIN scmdata.t_coop_scope tc
      ON sp.supplier_info_id = tc.supplier_info_id
     AND sp.company_id = tc.company_id
     AND tc.pause = 0
   WHERE sp.company_id = %default_company_id%
     --AND sp.cooperation_model = ''''OF''''
     AND sp.status = 1
     AND sp.pause <> 1
     AND instr(''''''||v_coop_class||'''''', tc.coop_classification) > 0
     AND sp.supplier_info_id not in
     (select t.fac_sup_info_id from scmdata.t_coop_factory t
      where t.supplier_info_id = :supplier_info_id
      and t.company_id = %default_company_id%) '';
 @strresult := v_sql;
END;}';
    IF p_item_id IN ('a_supp_151_7') THEN
      RETURN v_query_sql;
    ELSE
      RETURN NULL;
    END IF;
  END f_query_coop_factory_pick;

  --合作工厂类型
  FUNCTION f_query_fac_type_looksql(p_fac_type_field VARCHAR2,
                                    p_suffix         VARCHAR2) RETURN CLOB IS
    v_query_sql CLOB;
  BEGIN
    v_query_sql := 'SELECT t.group_dict_value ' || p_fac_type_field ||
                   ', t.group_dict_name ' || p_fac_type_field || p_suffix || '
      FROM scmdata.sys_group_dict t
     WHERE t.group_dict_type = ''COOP_FAC_TYPE''
     ORDER BY t.group_dict_sort asc';
    RETURN v_query_sql;
  END f_query_fac_type_looksql;

  --启用 停用 按钮
  PROCEDURE p_coop_fac_pause(p_company_id      VARCHAR2,
                             p_coop_factory_id VARCHAR2,
                             p_user_id         VARCHAR2,
                             p_status          VARCHAR2) IS
    v_where           CLOB;
    v_type            VARCHAR2(256);
    v_sup_name        VARCHAR2(256);
    v_fac_name        VARCHAR2(256);
    v_sup_info_id     VARCHAR2(256);
    v_fac_sup_info_id VARCHAR2(256);
    v_coop_class      VARCHAR2(256);
    v_sup_pause       NUMBER;
    v_fac_pause       NUMBER;
    v_pcnt            NUMBER;
    v_tcnt            NUMBER;
  BEGIN
    IF p_status = 0 THEN
      SELECT MAX(t.pause_type),
             MAX(a.supplier_company_name) sup_name,
             MAX(b.supplier_company_name) fac_name,
             MAX(t.supplier_info_id) supplier_info_id,
             MAX(t.fac_sup_info_id) fac_sup_info_id,
             MAX(a.pause) sup_pause,
             MAX(b.pause) fac_pause
        INTO v_type,
             v_sup_name,
             v_fac_name,
             v_sup_info_id,
             v_fac_sup_info_id,
             v_sup_pause,
             v_fac_pause
        FROM scmdata.t_coop_factory t
       INNER JOIN scmdata.t_supplier_info a
          ON a.supplier_info_id = t.supplier_info_id
         AND a.company_id = t.company_id
       INNER JOIN scmdata.t_supplier_info b
          ON b.supplier_info_id = t.fac_sup_info_id
         AND b.company_id = t.company_id
       WHERE t.coop_factory_id = p_coop_factory_id
         AND t.company_id = p_company_id;
    
      IF v_type IN ('SUP', 'COOP_PAUSE') THEN
        IF v_sup_pause = 1 THEN
          raise_application_error(-20002,
                                  '供应商:[' || v_sup_name ||
                                  '],目前合作状态为停用,不可启用合作关系！');
        ELSE
          NULL;
        END IF;
      END IF;
      IF v_type IN ('SUP_COOP', 'COOP_PAUSE') THEN
        SELECT listagg(DISTINCT CASE
                         WHEN a.pause = 1 THEN
                          b.group_dict_name
                         ELSE
                          NULL
                       END,
                       ';') coop_class
          INTO v_coop_class
          FROM scmdata.t_coop_scope a
         INNER JOIN scmdata.sys_group_dict b
            ON a.coop_classification = b.group_dict_value
           AND b.group_dict_type = 'PRODUCT_TYPE'
         WHERE a.supplier_info_id = v_sup_info_id
           AND a.company_id = p_company_id
           AND a.coop_classification IN
               (SELECT c.coop_classification
                  FROM scmdata.t_coop_scope c
                 WHERE c.supplier_info_id = v_fac_sup_info_id
                   AND c.company_id = p_company_id);
        IF v_coop_class IS NULL THEN
          NULL;
        ELSE
          raise_application_error(-20002,
                                  '供应商:[' || v_sup_name || ']对应的合作分类:[' ||
                                  v_coop_class || '],状态为停用,不可启用合作关系！');
        END IF;
      END IF;
      IF v_type IN ('OF', 'COOP_PAUSE') THEN
        IF v_fac_pause = 1 THEN
          raise_application_error(-20002,
                                  '外协厂:[' || v_fac_name ||
                                  '],目前合作状态为停用,不可启用合作关系！');
        ELSE
          NULL;
        END IF;
      END IF;
      IF v_type IN ('OF_COOP', 'COOP_PAUSE') THEN
        SELECT listagg(DISTINCT CASE
                         WHEN a.pause = 1 THEN
                          b.group_dict_name
                         ELSE
                          NULL
                       END,
                       ';') coop_class,
               SUM(CASE
                     WHEN a.pause = 1 THEN
                      1
                     ELSE
                      0
                   END) p_cnt,
               COUNT(1) t_cnt
          INTO v_coop_class, v_pcnt, v_tcnt
          FROM scmdata.t_coop_scope a
         INNER JOIN scmdata.sys_group_dict b
            ON a.coop_classification = b.group_dict_value
           AND b.group_dict_type = 'PRODUCT_TYPE'
         WHERE a.supplier_info_id = v_fac_sup_info_id
           AND a.company_id = p_company_id
           AND a.coop_classification IN
               (SELECT c.coop_classification
                  FROM scmdata.t_coop_scope c
                 WHERE c.supplier_info_id = v_sup_info_id
                   AND c.company_id = p_company_id);
        IF v_pcnt = v_tcnt THEN
          IF v_coop_class IS NULL THEN
            NULL;
          ELSE
            raise_application_error(-20002,
                                    '外协厂:[' || v_fac_name || ']对应的合作分类:[' ||
                                    v_coop_class || '],状态为停用,不可启用合作关系！');
          END IF;
        END IF;
      END IF;
    ELSE
      NULL;
    END IF;
    v_where := q'[ where company_id = ']' || p_company_id ||
               q'[' and coop_factory_id   = ']' || p_coop_factory_id ||
               q'[']';
    scmdata.pkg_plat_comm.p_pause(p_table       => 'T_COOP_FACTORY',
                                  p_pause_field => 'PAUSE',
                                  p_where       => v_where,
                                  p_user_id     => p_user_id,
                                  p_status      => p_status);
  
    UPDATE scmdata.t_coop_factory t
       SET t.pause_type = CASE
                            WHEN p_status = 1 THEN
                             'COOP_PAUSE'
                            ELSE
                             'COOP_UNPAUSE'
                          END
     WHERE company_id = p_company_id
       AND coop_factory_id = p_coop_factory_id;
  
  END p_coop_fac_pause;

  --更新合作工厂状态
  PROCEDURE update_coop_fac_status(p_company_id VARCHAR2,
                                   p_sup_id     VARCHAR2,
                                   p_fac_id     VARCHAR2 DEFAULT NULL,
                                   p_status     NUMBER,
                                   p_pause_type VARCHAR2) IS
  BEGIN
    IF p_pause_type = 'SUP' THEN
      UPDATE scmdata.t_coop_factory t
         SET t.pause       = p_status,
             t.pause_type  = p_pause_type,
             t.update_id   = 'ADMIN',
             t.update_time = SYSDATE
       WHERE t.supplier_info_id = p_sup_id
         AND t.company_id = p_company_id
         AND t.pause_type <> 'COOP_PAUSE';
    ELSIF p_pause_type IN ('SUP_COOP', 'OF_COOP') THEN
      UPDATE scmdata.t_coop_factory t
         SET t.pause       = p_status,
             t.pause_type  = p_pause_type,
             t.update_id   = 'ADMIN',
             t.update_time = SYSDATE
       WHERE t.supplier_info_id = p_sup_id
         AND t.fac_sup_info_id = p_fac_id
         AND t.company_id = p_company_id
         AND t.pause_type <> 'COOP_PAUSE';
    ELSIF p_pause_type = 'OF' THEN
      UPDATE scmdata.t_coop_factory t
         SET t.pause       = p_status,
             t.pause_type  = p_pause_type,
             t.update_id   = 'ADMIN',
             t.update_time = SYSDATE
       WHERE t.fac_sup_info_id = p_sup_id
         AND t.company_id = p_company_id
         AND t.pause_type <> 'COOP_PAUSE';
    ELSE
      NULL;
    END IF;
  END update_coop_fac_status;

  --供应商与工厂合作关系 启停状态校验
  --供应商/工厂 启停按钮触发
  PROCEDURE p_check_sup_fac_pause(p_company_id VARCHAR2, p_sup_id VARCHAR2) IS
    v_sup_pause NUMBER;
    v_fac_cnt   NUMBER;
    v_befac_cnt NUMBER;
  BEGIN
  
    SELECT COUNT(1)
      INTO v_fac_cnt
      FROM scmdata.t_coop_factory t
     WHERE t.supplier_info_id = p_sup_id
       AND t.company_id = p_company_id;
  
    SELECT MAX(t.pause)
      INTO v_sup_pause
      FROM scmdata.t_supplier_info t
     WHERE t.supplier_info_id = p_sup_id
       AND t.company_id = p_company_id;
  
    --作为供应商：判断是否有工厂
    IF v_fac_cnt > 0 THEN
      --判断供应商启停
      IF v_sup_pause = 1 THEN
        update_coop_fac_status(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_status     => v_sup_pause,
                               p_pause_type => 'SUP');
      
      ELSE
        p_check_coop_fac_pause(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_type       => 'SUP');
      END IF;
    ELSE
      NULL;
    END IF;
    --作为工厂：判断是否作为其他供应商的工厂
    SELECT COUNT(1)
      INTO v_befac_cnt
      FROM scmdata.t_coop_factory t
     WHERE t.fac_sup_info_id = p_sup_id
       AND t.company_id = p_company_id;
    IF v_befac_cnt > 0 THEN
      IF v_sup_pause = 1 THEN
        update_coop_fac_status(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_status     => v_sup_pause,
                               p_pause_type => 'OF');
      
      ELSE
        p_check_coop_fac_pause(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_type       => 'OF');
      END IF;
    ELSE
      NULL;
    END IF;
  END p_check_sup_fac_pause;

  --供应商的合作范围与工厂合作关系 启停状态校验
  PROCEDURE p_check_coop_fac_pause(p_company_id VARCHAR2,
                                   p_sup_id     VARCHAR2,
                                   p_type       VARCHAR2) IS
    v_coop_class VARCHAR2(2048);
  BEGIN
    --1:合作范围启停
    --获取当前供应商/工厂，启用的合作范围
    SELECT nvl(listagg(DISTINCT t.coop_classification, ';'), '-1') coop_class
      INTO v_coop_class
      FROM scmdata.t_coop_scope t
     WHERE t.supplier_info_id = p_sup_id
       AND t.company_id = p_company_id
       AND t.pause = 0;
    IF p_type = 'SUP' THEN
      IF v_coop_class = '-1' THEN
        update_coop_fac_status(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_fac_id     => p_sup_id,
                               p_status     => 1,
                               p_pause_type => 'SUP');
      ELSE
        --作为供应商：判断工厂的合作范围是否部分/全部包含于当前供应商已启用的合作范围，如果是，合作关系则启用，否则停用
        FOR i IN (SELECT listagg(DISTINCT c.coop_classification, ';') coop_class,
                         c.supplier_info_id
                    FROM scmdata.t_coop_factory a
                   INNER JOIN scmdata.t_supplier_info b
                      ON a.company_id = b.company_id
                     AND a.fac_sup_info_id = b.supplier_info_id
                   INNER JOIN scmdata.t_coop_scope c
                      ON b.supplier_info_id = c.supplier_info_id
                     AND b.company_id = c.company_id
                     AND c.pause = 0
                   WHERE a.supplier_info_id = p_sup_id --供应商ID
                     AND a.company_id = p_company_id
                   GROUP BY c.supplier_info_id) LOOP
          IF scmdata.instr_priv(v_coop_class, i.coop_class) > 0 THEN
            update_coop_fac_status(p_company_id => p_company_id,
                                   p_sup_id     => p_sup_id,
                                   p_fac_id     => i.supplier_info_id,
                                   p_status     => 0,
                                   p_pause_type => 'SUP_COOP');
          ELSE
            update_coop_fac_status(p_company_id => p_company_id,
                                   p_sup_id     => p_sup_id,
                                   p_fac_id     => i.supplier_info_id,
                                   p_status     => 1,
                                   p_pause_type => 'SUP_COOP');
          END IF;
        END LOOP;
      END IF;
    ELSIF p_type = 'OF' THEN
      IF v_coop_class = '-1' THEN
        update_coop_fac_status(p_company_id => p_company_id,
                               p_sup_id     => p_sup_id,
                               p_status     => 1,
                               p_pause_type => 'OF');
      ELSE
        --作为工厂：则判断该供应商（工厂）的合作范围是否部分/全部包含于其他供应商档案的合作范围，如果是，合作关系则启用，否则停用
        FOR i IN (SELECT listagg(DISTINCT c.coop_classification, ';') coop_class,
                         c.supplier_info_id
                    FROM scmdata.t_coop_factory a
                   INNER JOIN scmdata.t_supplier_info b
                      ON a.supplier_info_id = b.supplier_info_id
                     AND a.company_id = b.company_id
                   INNER JOIN scmdata.t_coop_scope c
                      ON b.supplier_info_id = c.supplier_info_id
                     AND b.company_id = c.company_id
                     AND c.pause = 0
                   WHERE a.company_id = p_company_id
                     AND a.fac_sup_info_id = p_sup_id --工厂ID
                   GROUP BY c.supplier_info_id) LOOP
          IF scmdata.instr_priv(i.coop_class, v_coop_class) > 0 THEN
            update_coop_fac_status(p_company_id => p_company_id,
                                   p_sup_id     => i.supplier_info_id,
                                   p_fac_id     => p_sup_id,
                                   p_status     => 0,
                                   p_pause_type => 'OF_COOP');
          ELSE
            update_coop_fac_status(p_company_id => p_company_id,
                                   p_sup_id     => i.supplier_info_id,
                                   p_fac_id     => p_sup_id,
                                   p_status     => 1,
                                   p_pause_type => 'OF_COOP');
          END IF;
        END LOOP;
      END IF;
    ELSE
      NULL;
    END IF;
  END p_check_coop_fac_pause;

  --合作工厂 end
  ----------------------------------------------------  配置代码   end  ----------------------------------------------------------------------------

  ----------------------------------------------------  业务代码   begin  ---------------------------------------------------------------------------
  --新增合作工厂
  PROCEDURE p_insert_coop_factory(p_fac_rec scmdata.t_coop_factory%ROWTYPE) IS
  BEGIN
    INSERT INTO scmdata.t_coop_factory
    VALUES
      (p_fac_rec.coop_factory_id,
       p_fac_rec.company_id,
       p_fac_rec.supplier_info_id,
       p_fac_rec.fac_sup_info_id,
       p_fac_rec.factory_code,
       p_fac_rec.factory_name,
       p_fac_rec.factory_type,
       p_fac_rec.pause,
       p_fac_rec.create_id,
       p_fac_rec.create_time,
       p_fac_rec.update_id,
       p_fac_rec.update_time,
       p_fac_rec.memo,
       nvl(p_fac_rec.pause_type, 'COOP_UNPAUSE'));
  END p_insert_coop_factory;

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
  PROCEDURE check_t_supplier_info(p_supplier_info_id VARCHAR2) IS
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
    check_save_t_supplier_info(p_sp_data => supp_info_rec);
  
    --3.校验合作范围TAB页不能为空
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_coop_scope t
     WHERE t.supplier_info_id = supp_info_rec.supplier_info_id;
  
    IF v_flag = 0 AND supp_info_rec.supplier_info_origin <> 'QC' THEN
      raise_application_error(-20002,
                              '合作范围不能为空,请先到下方<合作范围>TAB页进行填写后再提交！');
    END IF;
  
  END check_t_supplier_info;
  --校验统一信用代码
  --p_company_id :企业ID
  --p_supplier_info_id ：供应商编号 主键
  --p_social_credit_code ：统一社会信用代码
  PROCEDURE p_check_social_credit_code(p_company_id         VARCHAR2,
                                       p_supplier_info_id   VARCHAR2,
                                       p_social_credit_code VARCHAR2) IS
    v_scc_flag NUMBER;
  BEGIN
    IF p_social_credit_code IS NULL THEN
      raise_application_error(-20002, '统一社会信用代码不能为空！');
    ELSE
      IF scmdata.pkg_check_data_comm.f_check_soial_code(p_social_credit_code) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002,
                                '请输入正确的统一社会信用代码，且长度应为18位！');
      END IF;
      --不能与当前企业供应商档案：待建档、已建档的统一社会信用代码重复；
      SELECT COUNT(1)
        INTO v_scc_flag
        FROM scmdata.t_supplier_info sp
       WHERE sp.social_credit_code = p_social_credit_code
         AND sp.company_id = p_company_id
         AND sp.supplier_info_id <> p_supplier_info_id;
    
      IF v_scc_flag > 0 THEN
        raise_application_error(-20002, '统一社会信用代码不能重复！');
      END IF;
      --当前企业的统一信用代码已存在流程中，请检查；
      SELECT COUNT(1)
        INTO v_scc_flag
        FROM scmdata.t_ask_record a
        LEFT JOIN scmdata.t_factory_ask b
          ON a.be_company_id = b.company_id
         AND a.ask_record_id = b.ask_record_id
       WHERE a.be_company_id = p_company_id
         AND (a.social_credit_code = p_social_credit_code OR
             b.social_credit_code = p_social_credit_code);
    
      IF v_scc_flag > 0 THEN
        raise_application_error(-20002,
                                '当前企业的统一信用代码已存在流程中，请检查！！');
      END IF;
    
    END IF;
  END p_check_social_credit_code;

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

  PROCEDURE check_save_t_supplier_info(p_sp_data scmdata.t_supplier_info%ROWTYPE) IS
    v_supp_flag_tp NUMBER := 0;
  
  BEGIN
    --校验基础数据
    --1 供应商名称不能为空
    IF p_sp_data.supplier_company_name IS NULL THEN
      raise_application_error(-20002, '供应商名称不能为空！');
    ELSE
      --供应商档案：供应商名称可编辑。
      --无论新增修改，都得校验供应商名称是否重复
      --1） 限制仅能填写中文及中文括号；
      IF pkg_check_data_comm.f_check_varchar(pi_data => p_sp_data.supplier_company_name,
                                             pi_type => 0) <> 1 THEN
        raise_application_error(-20002,
                                '供应商名称填写错误，仅能填写中文及中文括号！');
      END IF;
      --2） 不能与当前企业供应商档案：待建档、已建档的供应商名称重复；
      SELECT COUNT(1)
        INTO v_supp_flag_tp
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_sp_data.company_id
         AND t.supplier_info_id <> p_sp_data.supplier_info_id
         AND t.supplier_company_name = p_sp_data.supplier_company_name;
    
      IF v_supp_flag_tp > 0 THEN
        raise_application_error(-20002, '供应商档案已存在该供应商名称!!');
      END IF;
      --3） 不能与当前企业在准入流程中的公司名称存在重复；
      scmdata.pkg_compname_check.p_tfa_compname_check_for_new(comp_name => p_sp_data.supplier_company_name,
                                                              dcomp_id  => p_sp_data.company_id,
                                                              p_fask_id => p_sp_data.supplier_info_origin_id);
    END IF;
    --手动新增 且 待建档
    IF p_sp_data.supplier_info_origin = 'MA' AND p_sp_data.status = 0 THEN
      --2 校验 统一社会信用代码
      p_check_social_credit_code(p_company_id         => p_sp_data.company_id,
                                 p_supplier_info_id   => p_sp_data.supplier_info_id,
                                 p_social_credit_code => p_sp_data.social_credit_code);
    ELSE
      NULL;
    END IF;
  
    --3 共用校验
    --公司联系人电话
    IF p_sp_data.company_contact_phone IS NOT NULL THEN
      IF scmdata.pkg_check_data_comm.f_check_phone(p_sp_data.company_contact_phone) = 1 THEN
        NULL;
      ELSE
        raise_application_error(-20002, '请输入正确的公司联系人电话号码！');
      END IF;
    END IF;
  
    --校验公司类型为xxx时，意向合作模式只能为xxx
    scmdata.pkg_ask_record_mange.p_check_company_type(p_company_type      => p_sp_data.company_type,
                                                      p_cooperation_model => p_sp_data.cooperation_model);
  
  END check_save_t_supplier_info;

  --校验工厂信息
  /* FUNCTION check_fask_data(p_company_id       VARCHAR2,
                           p_factory_ask_id   VARCHAR2,
                           p_com_manufacturer VARCHAR2) RETURN NUMBER IS
    v_social_credit_code VARCHAR2(18);
    v_flag               NUMBER;
  BEGIN
    IF p_com_manufacturer = '01' THEN
      --校验该供应商是否存在工厂
      SELECT t.fa_social_credit_code
        INTO v_social_credit_code
        FROM scmdata.t_factory_ask_out t
       WHERE t.factory_ask_id = p_factory_ask_id;
      --该工厂是否已经建立档案
      IF v_social_credit_code IS NOT NULL THEN
        SELECT COUNT(1)
          INTO v_flag
          FROM scmdata.t_supplier_info sp
         WHERE sp.company_id = p_company_id
           AND sp.social_credit_code = v_social_credit_code;
        IF v_flag > 0 THEN
          RETURN 0;
        ELSE
          RETURN 1;
        END IF;
      ELSE
        RETURN 0;
      END IF;
    ELSE
      RETURN 0;
    END IF;
  END check_fask_data;*/

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
      INTO v_supplier_company_id, v_cooperation_type, v_company_id
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
  --通过区域pick 分部获取分组配置id
  FUNCTION f_get_category_config_by_pick(p_company_id VARCHAR2,
                                         p_supp_id    VARCHAR2,
                                         p_province   VARCHAR2,
                                         p_city       VARCHAR2)
    RETURN VARCHAR2 IS
    v_group_config_id VARCHAR2(32);
  BEGIN
  
    SELECT MAX(aa.group_config_id)
      INTO v_group_config_id
      FROM scmdata.t_supplier_group_config aa
     INNER JOIN scmdata.t_supplier_group_category_config bb
        ON aa.group_config_id = bb.group_config_id
       AND aa.pause = 1
       AND bb.pause = 1
       AND trunc(SYSDATE) BETWEEN trunc(aa.effective_time) AND
           trunc(aa.end_time)
     INNER JOIN scmdata.t_supplier_group_area_config ee
        ON ee.pause = 1
       AND ee.group_type = 'GROUP_AREA'
       AND instr(bb.area_config_id, ee.group_area_config_id) > 0
       AND (instr(';' || ee.province_id || ';', ';' || p_province || ';') > 0 AND
           instr(';' || ee.city_id || ';', ';' || p_city || ';') > 0)
     INNER JOIN (SELECT coop_classification, coop_product_cate
                   FROM (SELECT sa.coop_classification,
                                sa.coop_product_cate,
                                row_number() over(ORDER BY sa.create_time) rn
                           FROM scmdata.t_supplier_info sp
                          INNER JOIN scmdata.t_coop_scope sa
                             ON sa.company_id = sp.company_id
                            AND sa.supplier_info_id = sp.supplier_info_id
                          WHERE sp.supplier_info_id = p_supp_id
                            AND sp.company_id = p_company_id)
                  WHERE rn = 1) cc
        ON instr(';' || bb.cooperation_classification || ';',
                 ';' || cc.coop_classification || ';') > 0
       AND instr(';' || bb.cooperation_product_cate || ';',
                 ';' || cc.coop_product_cate || ';') > 0
     WHERE aa.company_id = p_company_id;
    RETURN v_group_config_id;
  
  END f_get_category_config_by_pick;

  --通过所属品类 获取所在分组 
  --p_company_id 公司ID
  --p_supp_id 供应商ID
  FUNCTION f_get_category_config(p_company_id VARCHAR2, p_supp_id VARCHAR2)
    RETURN VARCHAR2 IS
    v_group_config_id VARCHAR2(32);
  BEGIN
    SELECT MAX(dd.group_config_id)
      INTO v_group_config_id
      FROM (SELECT *
              FROM (SELECT sa.coop_classification,
                           sa.coop_product_cate,
                           sp.company_province,
                           sp.company_city,
                           sp.company_id,
                           sp.supplier_info_id,
                           row_number() over(ORDER BY sa.create_time) rn
                      FROM scmdata.t_supplier_info sp
                     INNER JOIN scmdata.t_coop_scope sa
                        ON sa.company_id = sp.company_id
                       AND sa.supplier_info_id = sp.supplier_info_id
                     WHERE sa.supplier_info_id = p_supp_id
                       AND sa.company_id = p_company_id) va
             WHERE va.rn = 1) cc
     INNER JOIN (SELECT aa.group_name,
                        aa.group_config_id,
                        aa.area_group_leader,
                        bb.cooperation_classification,
                        bb.cooperation_product_cate,
                        ee.province_id,
                        ee.city_id
                   FROM scmdata.t_supplier_group_config aa
                  INNER JOIN scmdata.t_supplier_group_category_config bb
                     ON aa.group_config_id = bb.group_config_id
                    AND aa.pause = 1
                    AND bb.pause = 1
                  INNER JOIN scmdata.t_supplier_group_area_config ee
                     ON ee.pause = 1
                    AND instr(bb.area_config_id, ee.group_area_config_id) > 0
                  WHERE trunc(SYSDATE) BETWEEN trunc(aa.effective_time) AND
                        trunc(aa.end_time)) dd
        ON instr(';' || dd.cooperation_classification || ';',
                 ';' || cc.coop_classification || ';') > 0
       AND instr(';' || dd.cooperation_product_cate || ';',
                 ';' || cc.coop_product_cate || ';') > 0
       AND (instr(';' || dd.province_id || ';',
                  ';' || cc.company_province || ';') > 0 AND
            instr(';' || dd.city_id || ';', ';' || cc.company_city || ';') > 0);
    RETURN v_group_config_id;
  END f_get_category_config;

  --获取分组
  --所在分组根据供应商的品类、区域，从所在分组配置中匹配，自动获取对应分组；
  FUNCTION f_get_group_config_id(p_company_id VARCHAR2,
                                 p_supp_id    VARCHAR2,
                                 p_is_by_pick INT DEFAULT 0,
                                 p_province   VARCHAR2 DEFAULT NULL,
                                 p_city       VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2 IS
    v_flag             NUMBER;
    vo_group_config_id VARCHAR2(32);
  BEGIN
    SELECT COUNT(1)
      INTO v_flag
      FROM scmdata.t_supplier_info sp
      LEFT JOIN scmdata.t_coop_scope tc
        ON sp.supplier_info_id = tc.supplier_info_id
       AND sp.company_id = tc.company_id
     WHERE sp.supplier_info_id = p_supp_id
       AND sp.company_id = p_company_id;
    --所在分组根据供应商的品类、区域，从所在分组配置中匹配，自动获取对应分组；
    IF v_flag > 0 THEN
      IF p_is_by_pick = 0 THEN
        vo_group_config_id := f_get_category_config(p_company_id => p_company_id,
                                                    p_supp_id    => p_supp_id);
      ELSIF p_is_by_pick = 1 THEN
        vo_group_config_id := f_get_category_config_by_pick(p_company_id => p_company_id,
                                                            p_supp_id    => p_supp_id,
                                                            p_province   => p_province,
                                                            p_city       => p_city);
      ELSE
        NULL;
      END IF;
    ELSE
      vo_group_config_id := NULL;
    END IF;
    RETURN vo_group_config_id;
  END f_get_group_config_id;
  --获取分组
  FUNCTION f_get_group_name(p_company_id      VARCHAR2,
                            p_group_config_id VARCHAR2) RETURN VARCHAR2 IS
    v_group_name VARCHAR2(2000);
  BEGIN
    SELECT MAX(t.group_name)
      INTO v_group_name
      FROM scmdata.t_supplier_group_config t
     WHERE t.group_config_id = p_group_config_id
       AND t.company_id = p_company_id
       AND t.pause = 1;
    RETURN v_group_name;
  END f_get_group_name;
  --批量更新所在分组
  PROCEDURE p_batch_update_group_name(p_company_id VARCHAR2,
                                      p_is_trigger INT DEFAULT 0,
                                      p_pause      INT DEFAULT 1,
                                      p_is_by_pick INT DEFAULT 0) IS
  BEGIN
    FOR sup_rec IN (SELECT t.company_province,
                           t.company_city,
                           vc.coop_classification,
                           vc.coop_product_cate,
                           t.supplier_info_id,
                           t.company_id
                      FROM scmdata.t_supplier_info t
                     INNER JOIN (SELECT *
                                  FROM (SELECT tc.coop_classification,
                                               tc.coop_product_cate,
                                               row_number() over(PARTITION BY tc.supplier_info_id, tc.company_id ORDER BY tc.create_time DESC) rn,
                                               tc.supplier_info_id,
                                               tc.company_id
                                          FROM scmdata.t_coop_scope tc
                                         WHERE tc.company_id = p_company_id)
                                 WHERE rn = 1) vc
                        ON vc.supplier_info_id = t.supplier_info_id
                       AND vc.company_id = t.company_id
                     WHERE t.company_id = p_company_id
                       AND t.supplier_code = 'C03155') LOOP
    
      pkg_supplier_info.p_update_group_name(p_company_id       => sup_rec.company_id,
                                            p_supplier_info_id => sup_rec.supplier_info_id,
                                            p_is_trigger       => p_is_trigger,
                                            p_pause            => p_pause,
                                            p_is_by_pick       => p_is_by_pick,
                                            p_province         => sup_rec.company_province,
                                            p_city             => sup_rec.company_city);
    END LOOP;
  END p_batch_update_group_name;

  --更新所在区域 区域组长
  PROCEDURE p_update_group_name(p_company_id       VARCHAR2,
                                p_supplier_info_id VARCHAR2,
                                p_is_create_sup    INT DEFAULT 0,
                                p_is_trigger       INT DEFAULT 0,
                                p_pause            INT DEFAULT 1,
                                p_is_by_pick       INT DEFAULT 0,
                                p_province         VARCHAR2 DEFAULT NULL,
                                p_city             VARCHAR2 DEFAULT NULL) IS
    vo_group_config_id VARCHAR2(32);
    v_group_name       VARCHAR2(32);
  BEGIN
    IF p_pause = 0 THEN
      vo_group_config_id := NULL;
    ELSE
      IF p_is_by_pick = 0 THEN
        vo_group_config_id := pkg_supplier_info.f_get_group_config_id(p_company_id => p_company_id,
                                                                      p_supp_id    => p_supplier_info_id,
                                                                      p_is_by_pick => 0);
      ELSIF p_is_by_pick = 1 THEN
        vo_group_config_id := pkg_supplier_info.f_get_group_config_id(p_company_id => p_company_id,
                                                                      p_supp_id    => p_supplier_info_id,
                                                                      p_is_by_pick => 1,
                                                                      p_province   => p_province,
                                                                      p_city       => p_city);
      ELSE
        NULL;
      END IF;
      --判断获取配置返回的分组是否为空   
      IF p_is_create_sup = 0 THEN
        IF vo_group_config_id IS NULL THEN
          SELECT MAX(t.group_name)
            INTO v_group_name
            FROM scmdata.t_supplier_info t
           WHERE t.supplier_info_id = p_supplier_info_id
             AND t.company_id = p_company_id;
          --判断供应商 分组原值是否为空
          IF v_group_name IS NULL THEN
            IF p_is_trigger = 0 THEN
              raise_application_error(-20002,
                                      '分组不可为空，请在主表配置分组或联系管理员进行分组配置！');
            ELSIF p_is_trigger = 1 THEN
              vo_group_config_id := NULL;
            ELSE
              NULL;
            END IF;
          ELSE
            vo_group_config_id := v_group_name;
          END IF;
        ELSE
          NULL;
        END IF;
      END IF;
    END IF;
    UPDATE scmdata.t_supplier_info t
       SET t.group_name = vo_group_config_id
     WHERE t.supplier_info_id = p_supplier_info_id
       AND t.company_id = p_company_id;
  END p_update_group_name;

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

  PROCEDURE create_t_supplier_info(p_company_id      VARCHAR2,
                                   p_factory_ask_id  VARCHAR2,
                                   p_user_id         VARCHAR2,
                                   p_is_trialorder   NUMBER,
                                   p_trialorder_type VARCHAR2) IS
  
    --来源都是 准入审核 待审核数据 =》 同意 =》生产待建档供应商数据
    v_cooperation_company_id VARCHAR2(100);
    v_supply_id              VARCHAR2(100);
    v_coop_state             NUMBER;
    v_coop_position          VARCHAR2(48);
    iv_supp_info             scmdata.t_supplier_info%ROWTYPE; --验厂申请  供应商信息
    iv_sp_scope_info         scmdata.t_coop_scope%ROWTYPE; --验厂申请  供应商信息 合作范围
    fask_rec                 scmdata.t_factory_ask%ROWTYPE;
    fr_rec                   scmdata.t_factory_report%ROWTYPE;
    --验厂申请单 意向合作范围
    CURSOR fask_scope_cur(p_factory_ask_id VARCHAR2) IS
      SELECT t.*
        FROM scmdata.t_ask_scope t
       WHERE t.object_id = p_factory_ask_id
         AND t.object_type = 'CA';
    --验厂报告 生产能力评估明细
    CURSOR faskrp_ability_cur(p_factory_ask_id VARCHAR2) IS
      SELECT ra.cooperation_classification,
             ra.cooperation_product_cate,
             listagg(ra.cooperation_subcategory, ';') cooperation_subcategory
        FROM scmdata.t_factory_report         fr,
             scmdata.t_factory_report_ability ra
       WHERE fr.factory_report_id = ra.factory_report_id
         AND fr.factory_ask_id = p_factory_ask_id
         AND ra.ability_result = 'AGREE'
       GROUP BY ra.factory_report_id,
                ra.cooperation_classification,
                ra.cooperation_product_cate;
    /*SELECT ra.*
     FROM scmdata.t_factory_report         fr,
          scmdata.t_factory_report_ability ra
    WHERE fr.factory_report_id = ra.factory_report_id
      AND fr.factory_ask_id = p_factory_ask_id
      AND ra.ability_result = 'AGREE';*/
  BEGIN
    --数据源
    --验厂申请单 （供应商基础信息）
    SELECT *
      INTO fask_rec
      FROM scmdata.t_factory_ask fa
     WHERE fa.factory_ask_id = p_factory_ask_id --外部带入 :factory_ask_id
       AND fa.factrory_ask_flow_status IN ('FA12', 'FA31')
       AND fa.company_id = p_company_id;
  
    --供应商是否在平台注册，已在平台注册就通过社会统一信用代码取公司id
    SELECT MAX(fc.company_id)
      INTO v_cooperation_company_id
      FROM scmdata.sys_company fc
     WHERE fc.licence_num = fask_rec.social_credit_code;
  
    ---区分合作定位
    SELECT decode(MAX(cooperation_model), 'OF', '外协厂', '普通型')
      INTO v_coop_position
      FROM scmdata.t_factory_ask fz
     WHERE fz.factory_ask_id = fask_rec.factory_ask_id;
  
    --获取平台唯一编码
    v_supply_id                          := scmdata.pkg_plat_comm.f_getkeyid_plat('GY',
                                                                                  'seq_plat_code',
                                                                                  99);
    iv_supp_info.supplier_info_id        := v_supply_id;
    iv_supp_info.company_id              := p_company_id;
    iv_supp_info.supplier_info_origin    := 'AA';
    iv_supp_info.supplier_info_origin_id := fask_rec.factory_ask_id;
    iv_supp_info.supplier_company_id     := nvl(fask_rec.cooperation_company_id,
                                                v_cooperation_company_id);
    --基本信息
    iv_supp_info.supplier_company_name         := fask_rec.company_name;
    iv_supp_info.supplier_company_abbreviation := fask_rec.company_abbreviation;
    iv_supp_info.social_credit_code            := fask_rec.social_credit_code;
    iv_supp_info.legal_representative          := fask_rec.legal_representative; --存值有问题
    iv_supp_info.fa_contact_name               := fask_rec.contact_name; --存值有问题
    iv_supp_info.fa_contact_phone              := fask_rec.contact_phone; --存值有问题
    iv_supp_info.company_province              := fask_rec.company_province;
    iv_supp_info.company_city                  := fask_rec.company_city;
    iv_supp_info.company_county                := fask_rec.company_county;
    iv_supp_info.company_address               := fask_rec.company_address;
  
    SELECT MAX(t.company_contact_phone)
      INTO iv_supp_info.company_contact_phone
      FROM scmdata.t_ask_record t
     WHERE t.ask_record_id = fask_rec.ask_record_id;
  
    iv_supp_info.company_contact_person := fask_rec.contact_name;
    iv_supp_info.company_contact_phone  := fask_rec.contact_phone;
    iv_supp_info.company_type           := fask_rec.company_type; --存值有问题
    --生产信息
    iv_supp_info.product_type      := fask_rec.product_type;
    iv_supp_info.product_link      := fask_rec.product_link;
    iv_supp_info.brand_type        := fask_rec.brand_type;
    iv_supp_info.cooperation_brand := fask_rec.cooperation_brand;
  
    --合作信息
    iv_supp_info.pause := CASE
                            WHEN p_is_trialorder = 1 THEN
                             2
                            ELSE
                             0
                          END;
    --准入结果
    iv_supp_info.admit_result := p_trialorder_type;
    iv_supp_info.status       := 0;
    iv_supp_info.bind_status  := 1;
    iv_supp_info.create_id    := p_user_id;
    iv_supp_info.create_date  := SYSDATE;
    iv_supp_info.update_id    := p_user_id;
    iv_supp_info.update_date  := SYSDATE;
    --其它
    iv_supp_info.cooperation_type  := fask_rec.cooperation_type;
    iv_supp_info.cooperation_model := fask_rec.cooperation_model;
    iv_supp_info.sharing_type      := '00';
    iv_supp_info.coop_position     := v_coop_position;
  
    --判断验厂方式
    --1.不验厂  来源只有验厂申请单
    --按验厂申请单 供应商信息 生成档案
    IF fask_rec.factory_ask_type = 0 THEN
      --生产信息
      iv_supp_info.worker_num  := fask_rec.worker_num;
      iv_supp_info.machine_num := fask_rec.machine_num;
      --iv_supp_info.reserve_capacity   := fask_rec.reserve_capacity;
      iv_supp_info.product_efficiency := fask_rec.product_efficiency;
      iv_supp_info.work_hours_day     := fask_rec.work_hours_day;
      iv_supp_info.file_remark        := fask_rec.memo;
      --附件信息
      iv_supp_info.certificate_file := fask_rec.certificate_file;
      iv_supp_info.ask_files        := fask_rec.ask_files;
      iv_supp_info.supplier_gate    := fask_rec.supplier_gate;
      iv_supp_info.supplier_office  := fask_rec.supplier_office;
      iv_supp_info.supplier_site    := fask_rec.supplier_site;
      iv_supp_info.supplier_product := fask_rec.supplier_product;
    
      insert_supplier_info(p_sp_data => iv_supp_info);
    
      --2）合作范围取 =》意向合作范围
      FOR fscope_rec IN fask_scope_cur(fask_rec.factory_ask_id) LOOP
      
        iv_sp_scope_info.coop_scope_id       := scmdata.f_get_uuid();
        iv_sp_scope_info.supplier_info_id    := v_supply_id;
        iv_sp_scope_info.company_id          := p_company_id;
        iv_sp_scope_info.coop_mode           := fask_rec.cooperation_model;
        iv_sp_scope_info.coop_classification := fscope_rec.cooperation_classification;
        iv_sp_scope_info.coop_product_cate   := fscope_rec.cooperation_product_cate;
        iv_sp_scope_info.coop_subcategory    := fscope_rec.cooperation_subcategory;
        iv_sp_scope_info.create_id           := p_user_id;
        iv_sp_scope_info.create_time         := SYSDATE;
        iv_sp_scope_info.update_id           := p_user_id;
        iv_sp_scope_info.update_time         := SYSDATE;
        iv_sp_scope_info.remarks             := '';
        iv_sp_scope_info.pause               := 0;
        iv_sp_scope_info.sharing_type := CASE
                                           WHEN fask_rec.rela_supplier_id IS NULL THEN
                                            '00'
                                           ELSE
                                            '02'
                                         END;
        iv_sp_scope_info.coop_state          := v_coop_state;
      
        insert_coop_scope(p_cp_data => iv_sp_scope_info, p_type => 0);
        /*          --指定工厂
        IF fask_rec.rela_supplier_id IS NULL THEN
          NULL;
        ELSE
          SELECT t.supplier_code
            INTO v_rela_supp_code
            FROM scmdata.t_supplier_info t
           WHERE t.supplier_info_id = fask_rec.rela_supplier_id;
          insert_supplier_shared(scope_rec       => iv_sp_scope_info,
                                 p_supplier_code => v_rela_supp_code);
        END IF;*/
      END LOOP;
    ELSE
      --2.验厂  来源：验厂报告，能力评估
      --判断是否有验厂报告
      SELECT fr.*
        INTO fr_rec
        FROM scmdata.t_factory_report fr
       WHERE fr.factory_ask_id = fask_rec.factory_ask_id;
      --验厂报告
      IF fr_rec.factory_report_id IS NOT NULL THEN
        --生产信息
        iv_supp_info.product_line     := fr_rec.product_line;
        iv_supp_info.product_line_num := fr_rec.product_line_num;
        iv_supp_info.worker_num       := fr_rec.worker_num;
        iv_supp_info.machine_num      := fr_rec.machine_num;
        --iv_supp_info.reserve_capacity    := fr_rec.reserve_capacity;
        iv_supp_info.product_efficiency  := fr_rec.product_efficiency;
        iv_supp_info.work_hours_day      := fr_rec.work_hours_day;
        iv_supp_info.quality_step        := fr_rec.quality_step;
        iv_supp_info.pattern_cap         := fr_rec.pattern_cap;
        iv_supp_info.fabric_purchase_cap := fr_rec.fabric_purchase_cap;
        iv_supp_info.fabric_check_cap    := fr_rec.fabric_check_cap;
        iv_supp_info.cost_step           := fr_rec.cost_step;
        iv_supp_info.file_remark         := fr_rec.remarks;
      
        --附件信息
        iv_supp_info.certificate_file := fr_rec.certificate_file;
        iv_supp_info.ask_files        := fr_rec.ask_files;
        iv_supp_info.supplier_gate    := fr_rec.supplier_gate;
        iv_supp_info.supplier_office  := fr_rec.supplier_office;
        iv_supp_info.supplier_site    := fr_rec.supplier_site;
        iv_supp_info.supplier_product := fr_rec.supplier_product;
      
        insert_supplier_info(p_sp_data => iv_supp_info);
      
        --2）合作范围取 =》验厂报告 生产能力评估明细(符合)
        --只有生产能力评估明细(符合)才能进入合作范围
        FOR faskrp_ability_rec IN faskrp_ability_cur(fask_rec.factory_ask_id) LOOP
          iv_sp_scope_info.coop_scope_id       := scmdata.f_get_uuid();
          iv_sp_scope_info.supplier_info_id    := v_supply_id;
          iv_sp_scope_info.company_id          := p_company_id;
          iv_sp_scope_info.coop_mode           := fask_rec.cooperation_model;
          iv_sp_scope_info.coop_classification := faskrp_ability_rec.cooperation_classification;
          iv_sp_scope_info.coop_product_cate   := faskrp_ability_rec.cooperation_product_cate;
          iv_sp_scope_info.coop_subcategory    := faskrp_ability_rec.cooperation_subcategory;
          iv_sp_scope_info.create_id           := p_user_id;
          iv_sp_scope_info.create_time         := SYSDATE;
          iv_sp_scope_info.update_id           := p_user_id;
          iv_sp_scope_info.update_time         := SYSDATE;
          iv_sp_scope_info.remarks             := '';
          iv_sp_scope_info.pause               := 0;
          iv_sp_scope_info.sharing_type := CASE
                                             WHEN fask_rec.rela_supplier_id IS NULL THEN
                                              '00'
                                             ELSE
                                              '02'
                                           END;
          iv_sp_scope_info.coop_state          := v_coop_state;
        
          insert_coop_scope(p_cp_data => iv_sp_scope_info, p_type => 0);
          /*          --指定工厂
          IF fask_rec.rela_supplier_id IS NULL THEN
            NULL;
          ELSE
            SELECT t.supplier_code
              INTO v_rela_supp_code
              FROM scmdata.t_supplier_info t
             WHERE t.supplier_info_id = fask_rec.rela_supplier_id;
            insert_supplier_shared(scope_rec       => iv_sp_scope_info,
                                   p_supplier_code => v_rela_supp_code);
          END IF;*/
        END LOOP;
      ELSE
        NULL;
      END IF;
    END IF;
  
    --指定工厂
    DECLARE
      v_fac_rec scmdata.t_coop_factory%ROWTYPE;
      --v_factory_code VARCHAR2(32);
      --v_factory_name VARCHAR2(256);
    BEGIN
      --若有关联工厂 则自动生成外协厂信息至合作工厂
      IF fask_rec.rela_supplier_id IS NULL THEN
        NULL;
      ELSE
        /*SELECT MAX(t.supplier_code), MAX(t.supplier_company_name)
         INTO v_factory_code, v_factory_name
         FROM scmdata.t_supplier_info t
        WHERE t.supplier_info_id = fask_rec.rela_supplier_id;*/
        --原指定工厂因需求变更，废弃
        /*insert_supplier_shared(scope_rec       => iv_sp_scope_info,
        p_supplier_code => v_rela_supp_code);*/
        --新需求逻辑  准入后自动生成外协厂至合作工厂
        /*v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
        v_fac_rec.company_id       := p_company_id;
        v_fac_rec.fac_sup_info_id  := fask_rec.rela_supplier_id;
        v_fac_rec.factory_code     := v_factory_code;
        v_fac_rec.factory_name     := v_factory_name;
        v_fac_rec.factory_type     := '01'; --外协厂
        v_fac_rec.pause            := 0; --默认启用
        v_fac_rec.create_id        := 'ADMIN';
        v_fac_rec.create_time      := SYSDATE;
        v_fac_rec.update_id        := 'ADMIN';
        v_fac_rec.update_time      := SYSDATE;
        v_fac_rec.supplier_info_id := v_supply_id;*/
        --准入后自动生成关联供应商的外协厂 by DYY153 20220408
        v_fac_rec.coop_factory_id  := scmdata.f_get_uuid();
        v_fac_rec.company_id       := p_company_id;
        v_fac_rec.fac_sup_info_id  := v_supply_id;
        v_fac_rec.factory_name     := fask_rec.company_name;
        v_fac_rec.factory_type     := '01'; --外协厂
        v_fac_rec.pause            := 0; --默认启用
        v_fac_rec.create_id        := 'ADMIN';
        v_fac_rec.create_time      := SYSDATE;
        v_fac_rec.update_id        := 'ADMIN';
        v_fac_rec.update_time      := SYSDATE;
        v_fac_rec.supplier_info_id := fask_rec.rela_supplier_id;
        scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);
      END IF;
    END;
  
    --更新所在区域 区域组长
    p_update_group_name(p_company_id       => p_company_id,
                        p_supplier_info_id => v_supply_id,
                        p_is_create_sup    => 1,
                        p_is_by_pick       => 0);
  
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
    v_fac_id  VARCHAR2(32);
    v_origin  VARCHAR2(32);
    vo_log_id VARCHAR2(32);
  BEGIN
    --1.校验数据
    check_t_supplier_info(p_supplier_info_id);
  
    --2.生成供应商档案编号
    v_supplier_code := get_supplier_code_by_rule(p_supplier_info_id,
                                                 p_default_company_id);
  
    --3.新需求逻辑  建档后自动生成本厂信息至合作工厂
    DECLARE
      v_fac_rec      scmdata.t_coop_factory%ROWTYPE;
      v_factory_name VARCHAR2(256);
    BEGIN
      v_fac_rec.coop_factory_id := scmdata.f_get_uuid();
      v_fac_rec.company_id      := p_default_company_id;
      v_fac_rec.fac_sup_info_id := p_supplier_info_id;
      v_fac_rec.factory_code    := v_supplier_code;
      SELECT MAX(sp.supplier_company_name)
        INTO v_factory_name
        FROM scmdata.t_supplier_info sp
       WHERE sp.supplier_info_id = p_supplier_info_id
         AND sp.company_id = p_default_company_id;
      v_fac_rec.factory_name     := v_factory_name;
      v_fac_rec.factory_type     := '00'; --本厂
      v_fac_rec.pause            := 0; --默认启用
      v_fac_rec.create_id        := 'ADMIN';
      v_fac_rec.create_time      := SYSDATE;
      v_fac_rec.update_id        := 'ADMIN';
      v_fac_rec.update_time      := SYSDATE;
      v_fac_rec.supplier_info_id := p_supplier_info_id;
      scmdata.pkg_supplier_info.p_insert_coop_factory(p_fac_rec => v_fac_rec);
      --更新该工厂（作为外协厂）的供应商编号至合作工厂表 DYY153 20220411
      UPDATE scmdata.t_coop_factory t
         SET t.factory_code = v_supplier_code
       WHERE t.fac_sup_info_id = p_supplier_info_id
         AND t.company_id = p_default_company_id;
    END;
  
    --4.更新档案状态 待建档 =》已建档 ,新增（MA）供应商 => 未绑定，准入（AA）=> 已绑定
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
    
      --5.记录操作日志
      /*insert_oper_log(p_supplier_info_id,
      '创建档案',
      '',
      p_user_id,
      p_default_company_id,
      SYSDATE);*/
    
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => p_default_company_id,
                                             p_apply_module       => 'action_a_supp_151_1',
                                             p_base_table         => 't_supplier_info',
                                             p_apply_pk_id        => p_supplier_info_id,
                                             p_action_type        => 'UPDATE',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '00',
                                             p_field_desc         => '建档状态',
                                             p_operate_field      => 'status',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => 0,
                                             p_new_code           => 1,
                                             p_old_value          => '待建档',
                                             p_new_value          => '已建档',
                                             p_user_id            => p_user_id,
                                             p_operate_company_id => p_default_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id);
    
      scmdata.pkg_plat_log.p_update_plat_logmsg(p_company_id       => p_default_company_id,
                                                p_log_id           => vo_log_id,
                                                p_is_logsmsg       => 1,
                                                p_is_splice_fields => 0);
    
      --6.判断供应商档案来源
      --‘AA’ 流程过来的 新增流程操作记录
      --'MA'/其他  不记录
      SELECT MAX(t.supplier_info_origin_id), MAX(t.supplier_info_origin)
        INTO v_fac_id, v_origin
        FROM scmdata.t_supplier_info t
       WHERE t.supplier_info_id = p_supplier_info_id;
    
      IF v_origin = 'AA' THEN
        --供应商生成档案后，加急的供应商需取消高亮显示、置顶
        UPDATE scmdata.t_factory_ask t
           SET t.is_urgent = 0
         WHERE t.factory_ask_id = v_fac_id
           AND t.company_id = p_default_company_id;
        --流程操作记录
        pkg_ask_record_mange.p_log_fac_records_oper(p_company_id   => p_default_company_id,
                                                    p_user_id      => p_user_id,
                                                    p_fac_ask_id   => v_fac_id,
                                                    p_flow_status  => 'SP_FILED',
                                                    p_fac_ask_flow => 'SP_01',
                                                    p_memo         => '');
      ELSE
        NULL;
      END IF;
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
    -- v_name VARCHAR2(100);
  BEGIN
    /*    SELECT fc.company_user_name
     INTO v_name
     FROM scmdata.sys_company_user fc
    WHERE fc.company_id = p_company_id
      AND fc.user_id = p_user_id;*/
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
       p_user_id,
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
    x_err_msg VARCHAR2(1000);
    supplier_info_exp EXCEPTION;
  BEGIN
  
    SELECT sp.pause
      INTO v_status
      FROM scmdata.t_supplier_info sp
     WHERE sp.supplier_info_id = p_supplier_info_id
       AND sp.company_id = p_company_id;
  
    IF p_status <> v_status THEN
      --启用，停用
      UPDATE scmdata.t_supplier_info sp
         SET sp.pause       = p_status,
             sp.pause_cause = p_reason,
             sp.update_id   = p_user_id,
             sp.update_date = SYSDATE
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
    
      UPDATE scmdata.t_supplier_info sp
         SET sp.bind_status = p_status,
             sp.update_id   = p_user_id,
             sp.update_date = SYSDATE
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

  PROCEDURE insert_supplier_info(p_sp_data scmdata.t_supplier_info%ROWTYPE) IS
  BEGIN
  
    INSERT INTO scmdata.t_supplier_info
      (supplier_info_id,
       company_id,
       supplier_info_origin_id,
       supplier_company_id,
       supplier_company_name,
       supplier_company_abbreviation,
       social_credit_code,
       inside_supplier_code,
       company_contact_person,
       company_contact_phone,
       legal_representative,
       fa_contact_name,
       fa_contact_phone,
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
       update_date,
       company_province,
       company_city,
       company_county,
       coop_state,
       group_name,
       area_group_leader,
       coop_position,
       product_type,
       product_link,
       brand_type,
       cooperation_brand,
       product_line,
       product_line_num,
       worker_num,
       machine_num,
       quality_step,
       pattern_cap,
       fabric_purchase_cap,
       fabric_check_cap,
       cost_step,
       --reserve_capacity,
       product_efficiency,
       work_hours_day,
       remarks,
       company_type,
       supplier_gate,
       supplier_office,
       supplier_site,
       supplier_product,
       file_remark,
       ask_files,
       admit_result)
    VALUES
      (p_sp_data.supplier_info_id,
       p_sp_data.company_id,
       p_sp_data.supplier_info_origin_id,
       p_sp_data.supplier_company_id,
       p_sp_data.supplier_company_name,
       p_sp_data.supplier_company_abbreviation,
       p_sp_data.social_credit_code,
       p_sp_data.inside_supplier_code,
       p_sp_data.company_contact_person,
       p_sp_data.company_contact_phone,
       p_sp_data.legal_representative,
       p_sp_data.fa_contact_name,
       p_sp_data.fa_contact_phone,
       p_sp_data.company_address,
       p_sp_data.certificate_file,
       p_sp_data.cooperation_type,
       p_sp_data.cooperation_model,
       p_sp_data.sharing_type,
       p_sp_data.supplier_info_origin,
       p_sp_data.pause,
       '0',
       p_sp_data.bind_status,
       p_sp_data.create_id,
       SYSDATE,
       p_sp_data.create_id,
       SYSDATE,
       p_sp_data.company_province,
       p_sp_data.company_city,
       p_sp_data.company_county,
       p_sp_data.coop_state,
       p_sp_data.group_name,
       p_sp_data.area_group_leader,
       p_sp_data.coop_position,
       p_sp_data.product_type,
       p_sp_data.product_link,
       p_sp_data.brand_type,
       p_sp_data.cooperation_brand,
       p_sp_data.product_line,
       p_sp_data.product_line_num,
       p_sp_data.worker_num,
       p_sp_data.machine_num,
       p_sp_data.quality_step,
       p_sp_data.pattern_cap,
       p_sp_data.fabric_purchase_cap,
       p_sp_data.fabric_check_cap,
       p_sp_data.cost_step,
       --p_sp_data.reserve_capacity,
       p_sp_data.product_efficiency,
       p_sp_data.work_hours_day,
       p_sp_data.remarks,
       p_sp_data.company_type,
       p_sp_data.supplier_gate,
       p_sp_data.supplier_office,
       p_sp_data.supplier_site,
       p_sp_data.supplier_product,
       p_sp_data.file_remark,
       p_sp_data.ask_files,
       p_sp_data.admit_result);
  
  END insert_supplier_info;

  /*============================================*
  * Author   : SANFU
  * Created  : 2020-09-28 10:15:31
  * ALERTER  :
  * ALERTER_TIME  :
  * Purpose  : 修改供应商
  * Obj_Name    : update_supplier_info
  * Arg_Number  : 3
  * P_SP_DATA : 供应商档案数据
  * p_item_id   ：页面类型
  * p_origin ：来源
  *============================================*/

  PROCEDURE update_supplier_info(p_sp_data t_supplier_info%ROWTYPE,
                                 p_item_id VARCHAR2 DEFAULT NULL) IS
    v_update_sql CLOB;
  BEGIN
    --当页面为待建档 已建档详情页 更新保存时校验数据
    check_save_t_supplier_info(p_sp_data => p_sp_data);
  
    v_update_sql := q'[UPDATE scmdata.t_supplier_info sp
    --基本信息
       SET ]' || CASE
                      WHEN p_sp_data.supplier_info_origin = 'MA' AND
                           p_sp_data.status = 0 THEN
                       ' sp.social_credit_code            = :social_credit_code,'
                      ELSE
                       ''
                    END || q'[
           sp.supplier_company_name         = :supplier_company_name,
           sp.supplier_company_abbreviation = :supplier_company_abbreviation,
           sp.legal_representative = :legal_representative,
           sp.inside_supplier_code = :inside_supplier_code,
           sp.company_province     = :company_province,
           sp.company_city         = :company_city,
           sp.company_county       = :company_county,
           sp.company_address      = :company_address,
           sp.company_contact_phone = :company_contact_phone,
           sp.fa_contact_name       = :fa_contact_name,
           sp.fa_contact_phone      = :fa_contact_phone,
           sp.company_type          = :company_type,
           sp.group_name            = :group_name,
           sp.area_group_leader     = :area_group_leader,
           --生产信息
           sp.product_type        = :product_type,
           sp.product_link        = :product_link,
           sp.brand_type          = :brand_type,
           sp.cooperation_brand   = :cooperation_brand,
           sp.product_line        = :product_line,
           sp.product_line_num    = :product_line_num,
           sp.worker_num          = :worker_num,
           sp.machine_num         = :machine_num,
           sp.quality_step        = :quality_step,
           sp.pattern_cap         = :pattern_cap,
           sp.fabric_purchase_cap = :fabric_purchase_cap,
           sp.fabric_check_cap    = :fabric_check_cap,
           sp.cost_step           = :cost_step,
           --sp.reserve_capacity    = :reserve_capacity,
           sp.product_efficiency  = :product_efficiency,
           sp.work_hours_day      = :work_hours_day,
           --合作信息
           sp.pause               = :coop_state,
           sp.pause_cause         = :pause_cause,
           --sp.cooperation_type  = :cooperation_type,
           sp.cooperation_model   = :cooperation_model,
           sp.coop_position = :coop_position,
           --附件资料
           sp.certificate_file = :certificate_file,
           sp.ask_files        = :ask_files,
           sp.supplier_gate    = :supplier_gate,
           sp.supplier_office  = :supplier_office,
           sp.supplier_site    = :supplier_site,
           sp.supplier_product = :supplier_product,
           sp.company_say      = :company_say,
           sp.file_remark      = :file_remark,
           sp.update_id        = :update_id,
           sp.update_date      = :update_date
     WHERE sp.supplier_info_id = :supplier_info_id]';
    --来源为准入 统一社会信用代码 不可更改
    --来源为手动新增 且 待建档 统一社会信用代码 可更改
    IF p_sp_data.supplier_info_origin = 'MA' AND p_sp_data.status = 0 THEN
      EXECUTE IMMEDIATE v_update_sql
        USING p_sp_data.social_credit_code, p_sp_data.supplier_company_name, p_sp_data.supplier_company_abbreviation, p_sp_data.legal_representative, p_sp_data.inside_supplier_code, p_sp_data.company_province, p_sp_data.company_city, p_sp_data.company_county, p_sp_data.company_address, p_sp_data.company_contact_phone, p_sp_data.fa_contact_name, p_sp_data.fa_contact_phone, p_sp_data.company_type, p_sp_data.group_name, p_sp_data.area_group_leader, p_sp_data.product_type, p_sp_data.product_link, p_sp_data.brand_type, p_sp_data.cooperation_brand, p_sp_data.product_line, p_sp_data.product_line_num, p_sp_data.worker_num, p_sp_data.machine_num, p_sp_data.quality_step, p_sp_data.pattern_cap, p_sp_data.fabric_purchase_cap, p_sp_data.fabric_check_cap, p_sp_data.cost_step, /*p_sp_data.reserve_capacity,*/
      p_sp_data.product_efficiency, p_sp_data.work_hours_day, p_sp_data.pause, p_sp_data.pause_cause, p_sp_data.cooperation_model, p_sp_data.coop_position, p_sp_data.certificate_file, p_sp_data.ask_files, p_sp_data.supplier_gate, p_sp_data.supplier_office, p_sp_data.supplier_site, p_sp_data.supplier_product, p_sp_data.company_say, p_sp_data.file_remark, p_sp_data.update_id, SYSDATE, p_sp_data.supplier_info_id;
    ELSE
      EXECUTE IMMEDIATE v_update_sql
        USING p_sp_data.supplier_company_name, p_sp_data.supplier_company_abbreviation, p_sp_data.legal_representative, p_sp_data.inside_supplier_code, p_sp_data.company_province, p_sp_data.company_city, p_sp_data.company_county, p_sp_data.company_address, p_sp_data.company_contact_phone, p_sp_data.fa_contact_name, p_sp_data.fa_contact_phone, p_sp_data.company_type, p_sp_data.group_name, p_sp_data.area_group_leader, p_sp_data.product_type, p_sp_data.product_link, p_sp_data.brand_type, p_sp_data.cooperation_brand, p_sp_data.product_line, p_sp_data.product_line_num, p_sp_data.worker_num, p_sp_data.machine_num, p_sp_data.quality_step, p_sp_data.pattern_cap, p_sp_data.fabric_purchase_cap, p_sp_data.fabric_check_cap, p_sp_data.cost_step, /*p_sp_data.reserve_capacity,*/
      p_sp_data.product_efficiency, p_sp_data.work_hours_day, p_sp_data.pause, p_sp_data.pause_cause, p_sp_data.cooperation_model, p_sp_data.coop_position, p_sp_data.certificate_file, p_sp_data.ask_files, p_sp_data.supplier_gate, p_sp_data.supplier_office, p_sp_data.supplier_site, p_sp_data.supplier_product, p_sp_data.company_say, p_sp_data.file_remark, p_sp_data.update_id, SYSDATE, p_sp_data.supplier_info_id;
    END IF;
  END update_supplier_info;

  /*============================================*
  * Author   p_sp_data. SANFU
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

  /*校验合同批量导入*/
  PROCEDURE check_import_constract(p_temp_id IN VARCHAR2) IS
    p_contract_info_temp t_contract_info_temp%ROWTYPE;
    p_con_i              INT;
    p_flag               INT;
    p_con_flag           INT;
    p_con_msg            VARCHAR2(3000);
    p_con_desc           VARCHAR2(600);
  BEGIN
    p_con_i := 0;
    SELECT a.*
      INTO p_contract_info_temp
      FROM t_contract_info_temp a
     WHERE a.temp_id = p_temp_id;
    ---校验供应商编号
    SELECT COUNT(1), MAX(t.status), MAX(supplier_company_name)
      INTO p_flag, p_con_flag, p_con_desc
      FROM scmdata.t_supplier_info t
     WHERE t.inside_supplier_code =
           p_contract_info_temp.inside_supplier_code
       AND t.company_id = p_contract_info_temp.company_id;
  
    IF p_flag = 0 THEN
      p_con_i   := p_con_i + 1;
      p_con_msg := p_con_msg || p_con_i || ')不存在的供应商编号,';
    
    ELSIF p_con_flag = 0 THEN
      p_con_i   := p_con_i + 1;
      p_con_msg := p_con_msg || p_con_i || ')供应商未建档,';
    
    ELSIF p_con_desc <> p_contract_info_temp.supplier_company_name THEN
      p_con_i   := p_con_i + 1;
      p_con_msg := p_con_msg || p_con_i || ')供应商编号和供应商名称不对应,当前对应为:' ||
                   p_con_desc || ' ,';
    END IF;
  
    ----校验合同日期
    IF p_contract_info_temp.contract_start_date >
       p_contract_info_temp.contract_stop_date THEN
      p_con_msg := '合同日期，结束日期必须≥开始日期';
    END IF;
  
    ----校验合同类型
  
    SELECT MAX(a.group_dict_value)
      INTO p_contract_info_temp.contract_type
      FROM sys_group_dict a
     WHERE a.group_dict_value = p_contract_info_temp.contract_type
       AND a.group_dict_type = 'CONTRACT_TYPE'
       AND pause = 0;
    IF p_contract_info_temp.contract_type IS NULL THEN
      p_con_i   := p_con_i + 1;
      p_con_msg := p_con_msg || p_con_i || ')不存在的合同类型';
    ELSE
      UPDATE scmdata.t_contract_info_temp t
         SET t.contract_type = p_contract_info_temp.contract_type
       WHERE t.temp_id = p_temp_id;
    END IF;
  
    ----校验重复数据
  
    ----插入用户数据
  
    p_contract_info_temp.operator_id  := p_contract_info_temp.user_id;
    p_contract_info_temp.operate_time := SYSDATE;
    p_contract_info_temp.change_id    := p_contract_info_temp.user_id;
    p_contract_info_temp.change_time  := SYSDATE;
  
    UPDATE scmdata.t_contract_info_temp t
       SET t.operator_id  = p_contract_info_temp.operator_id,
           t.operate_time = p_contract_info_temp.operate_time,
           t.change_id    = p_contract_info_temp.change_id,
           t.change_time  = p_contract_info_temp.change_time
     WHERE t.temp_id = p_temp_id;
  
    IF p_con_msg IS NOT NULL THEN
      UPDATE scmdata.t_contract_info_temp t
         SET t.msg_type = 'E', t.msg = p_con_msg
       WHERE t.temp_id = p_temp_id;
    ELSE
      UPDATE scmdata.t_contract_info_temp t
         SET t.msg_type = 'S', t.msg = '校验成功'
       WHERE t.temp_id = p_temp_id;
    END IF;
  
  END check_import_constract;

  /*提交批量导入的合同*/

  PROCEDURE submit_t_contract_info(p_company_id IN VARCHAR2,
                                   p_user_id    IN VARCHAR2) IS
    p_sub_id      VARCHAR2(32);
    p_sub_supp_id VARCHAR2(32);
  BEGIN
    FOR data_sub IN (SELECT *
                       FROM scmdata.t_contract_info_temp t
                      WHERE t.company_id = p_company_id
                        AND t.user_id = p_user_id) LOOP
      IF data_sub.msg_type = 'E' OR data_sub.msg_type IS NULL THEN
        raise_application_error(-20002,
                                '请检查数据是否都已检验成功，修改正确后再提交!');
      ELSE
        p_sub_id := f_get_uuid();
      
        SELECT supplier_info_id
          INTO p_sub_supp_id
          FROM scmdata.t_supplier_info a
         WHERE a.inside_supplier_code = data_sub.inside_supplier_code
           AND a.company_id = data_sub.company_id;
      
        INSERT INTO scmdata.t_contract_info
          (contract_info_id,
           supplier_info_id,
           company_id,
           contract_start_date,
           contract_stop_date,
           contract_sign_date,
           contract_file,
           contract_type,
           contract_num,
           operator_id,
           operate_time,
           change_id,
           change_time)
        VALUES
          (p_sub_id,
           p_sub_supp_id,
           data_sub.company_id,
           data_sub.contract_start_date,
           data_sub.contract_stop_date,
           data_sub.contract_sign_date,
           data_sub.contract_file,
           data_sub.contract_type,
           data_sub.contract_num,
           data_sub.operator_id,
           data_sub.operate_time,
           data_sub.change_id,
           data_sub.change_time);
      END IF;
    END LOOP;
    DELETE FROM t_contract_info_temp t
     WHERE t.company_id = p_company_id
       AND t.user_id = p_user_id;
  END submit_t_contract_info;

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
       contract_file,
       contract_type,
       contract_num,
       operator_id,
       operate_time,
       change_id,
       change_time)
    VALUES
      (scmdata.f_get_uuid(),
       p_contract_rec.supplier_info_id,
       p_contract_rec.company_id,
       p_contract_rec.contract_start_date,
       p_contract_rec.contract_stop_date,
       p_contract_rec.contract_sign_date,
       p_contract_rec.contract_file,
       p_contract_rec.contract_type,
       p_contract_rec.contract_num,
       p_contract_rec.operator_id,
       SYSDATE,
       p_contract_rec.change_id,
       SYSDATE);
  
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
           t.contract_file       = p_contract_rec.contract_file,
           t.contract_type       = p_contract_rec.contract_type,
           t.contract_num        = p_contract_rec.contract_num,
           t.change_id           = p_contract_rec.change_id,
           t.change_time         = p_contract_rec.change_time
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
        insert_supplier_info(p_sp_data => p_sp_data);
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
    p_desc            VARCHAR2(600);
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
    /*   IF p_supplier_id IS NOT NULL AND
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
    */
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
    p_code        VARCHAR2(32);
    p_id          VARCHAR2(32);
    p_supplier_id VARCHAR2(32);
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
      
        SELECT supplier_info_id
          INTO p_supplier_id
          FROM t_supplier_info a
         WHERE a.inside_supplier_code = p_code
           AND a.company_id = data_rec.company_id;
        SELECT MAX(coop_scope_id)
          INTO p_id
          FROM t_coop_scope a
         WHERE a.supplier_info_id = p_supplier_id
           AND a.company_id = p_company_id
           AND a.coop_classification = data_rec.coop_classification
           AND a.coop_product_cate = data_rec.coop_product_cate;
        IF p_id IS NOT NULL THEN
          UPDATE scmdata.t_coop_scope a
             SET a.coop_subcategory = data_rec.coop_subcategory,
                 a.update_id        = data_rec.create_id,
                 a.update_time      = SYSDATE,
                 a.sharing_type     = data_rec.sharing_type
           WHERE a.coop_scope_id = p_id;
          DELETE FROM scmdata.t_supplier_shared a
           WHERE a.coop_scope_id = p_id;
        ELSE
          p_id := f_get_uuid();
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
             p_supplier_id,
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
        END IF;
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
               p_supplier_id,
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
  PROCEDURE insert_coop_scope(p_cp_data scmdata.t_coop_scope%ROWTYPE,
                              p_type    NUMBER DEFAULT 1) IS
  BEGIN
    --校验合作范围  p_status： IU 新增/更新 D 删除
    IF p_type = 1 THEN
      check_coop_scopre(p_cp_data => p_cp_data, p_status => 'IU');
    ELSE
      NULL;
    END IF;
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

  --新增关联供应商
  PROCEDURE insert_supplier_shared(scope_rec       scmdata.t_coop_scope%ROWTYPE,
                                   p_supplier_code VARCHAR2) IS
  BEGIN
    INSERT INTO t_supplier_shared
      (coop_scope_id,
       supplier_shared_id,
       company_id,
       supplier_info_id,
       shared_supplier_code,
       remarks)
    VALUES
      (scope_rec.coop_scope_id,
       scmdata.f_get_uuid(),
       scope_rec.company_id,
       scope_rec.supplier_info_id,
       p_supplier_code,
       '');
  END insert_supplier_shared;
  --删除关联供应商
  PROCEDURE delete_supplier_shared(p_supplier_shared_id VARCHAR2) IS
  BEGIN
    DELETE FROM scmdata.t_supplier_shared t
     WHERE t.supplier_shared_id = p_supplier_shared_id;
  END delete_supplier_shared;

  --获取供应流程状态
  PROCEDURE get_supp_oper_status(p_factory_ask_id VARCHAR2,
                                 po_flow_status   OUT VARCHAR2,
                                 po_flow_node     OUT VARCHAR2) IS
    vo_flow_status VARCHAR2(32);
    vo_flow_node   VARCHAR2(32);
  BEGIN
  
    SELECT status_af_oper, flow_node_name_af || flow_node_status_desc_af
      INTO vo_flow_status, vo_flow_node
      FROM (SELECT factory_ask_id,
                   status_af_oper,
                   substr(gs.group_dict_name,
                          0,
                          instr(gs.group_dict_name, '+') - 1) flow_node_name_af,
                   substr(gs.group_dict_name,
                          instr(gs.group_dict_name, '+') + 1,
                          length(gs.group_dict_name)) flow_node_status_desc_af
              FROM t_factory_ask_oper_log a
             INNER JOIN sys_group_dict goper
                ON goper.group_dict_value = upper(a.oper_code)
               AND goper.group_dict_type = 'DICT_FLOW_STATUS'
             INNER JOIN sys_group_dict gs
                ON gs.group_dict_value = a.status_af_oper
               AND gs.group_dict_type = 'FACTORY_ASK_FLOW'
             INNER JOIN sys_company_user cua
                ON a.oper_user_id = cua.user_id
               AND a.oper_user_company_id = cua.company_id
             WHERE a.factory_ask_id = p_factory_ask_id
                OR (a.ask_record_id IS NOT NULL AND
                   a.ask_record_id =
                   (SELECT ask_record_id
                       FROM t_factory_ask
                      WHERE factory_ask_id = p_factory_ask_id) AND
                   a.factory_ask_id IS NULL)
             ORDER BY a.oper_time DESC) tablealias
     WHERE factory_ask_id = p_factory_ask_id
       AND rownum = 1;
  
    po_flow_status := vo_flow_status;
    po_flow_node   := vo_flow_node;
  
  END get_supp_oper_status;

  --供应流程 触发企微机器人发送消息
  FUNCTION send_fac_wx_msg(p_company_id     VARCHAR2,
                           p_factory_ask_id VARCHAR2,
                           p_msgtype        VARCHAR2, --消息类型 text、markdown
                           p_msg_title      VARCHAR2, --消息标题
                           p_bot_key        VARCHAR2, --机器人key
                           p_robot_type     VARCHAR2 --机器人配置类型
                           ) RETURN CLOB IS
    v_msg_body     CLOB;
    v_sender       CLOB;
    v_wx_sql       CLOB;
    vo_flow_status VARCHAR2(32);
    vo_flow_name   VARCHAR2(32);
    v_sup_name     VARCHAR2(256);
    v_pause        VARCHAR2(32);
    v_sup_code     VARCHAR2(32);
    v_all_cnt      NUMBER;
    v_shoe_cnt     NUMBER;
  BEGIN
    --获取供应商名称  接收人
    SELECT t.company_name,
           (SELECT t.inner_user_id
              FROM scmdata.sys_company_user t
             WHERE t.company_id = p_company_id
               AND t.user_id = t.ask_user_id)
      INTO v_sup_name, v_sender
      FROM scmdata.t_factory_ask t
     WHERE t.factory_ask_id = p_factory_ask_id;
  
    scmdata.pkg_supplier_info.get_supp_oper_status(p_factory_ask_id => p_factory_ask_id,
                                                   po_flow_status   => vo_flow_status,
                                                   po_flow_node     => vo_flow_name);
  
    --FA21  FA33  '准入不通过', '特批申请不通过'
    IF vo_flow_status IN ('FA21', 'FA33') THEN
      v_msg_body := '您好，关于<' || v_sup_name || '>供应商的验厂结果为[' || vo_flow_name ||
                    '],请及时处理。详情请前往SCM系统进行查看,谢谢！';
      --FA22  FA32  '特批申请待建档', '准入申请待建档'
    ELSIF vo_flow_status IN ('FA22', 'FA32') THEN
      --档案 合作状态
      SELECT decode(t.pause, 0, '通过', 2, '试单', '停用')
        INTO v_pause
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.supplier_info_origin_id = p_factory_ask_id;
    
      v_msg_body := '您好，关于<' || v_sup_name || '>供应商的验厂结果为[' || v_pause ||
                    '],详情请前往SCM系统进行查看,谢谢！';
      --SP_01 '供应商档案已建档'
    ELSIF vo_flow_status IN ('SP_01') THEN
      --档案 合作状态,供应商名称
      SELECT decode(t.pause, 0, '通过', 2, '试单', '停用'), t.supplier_code
        INTO v_pause, v_sup_code
        FROM scmdata.t_supplier_info t
       WHERE t.company_id = p_company_id
         AND t.supplier_info_origin_id = p_factory_ask_id;
    
      v_msg_body := '您好，<' || v_sup_name || '>供应商已建档,建档结果为[' || v_pause ||
                    '],档案编号为：[' || v_sup_code || '],请知悉,谢谢！';
    
    ELSIF vo_flow_status IN ('FA13') THEN
      --重置接收人  默认生产部经理 ：除了鞋子的其他分类：叶其林  鞋：康平
      SELECT COUNT(1) all_cnt,
             SUM(CASE
                   WHEN b.cooperation_classification = '08' AND
                        b.cooperation_product_cate IN ('111', '113', '114') THEN
                    1
                   ELSE
                    0
                 END) shoe_cnt
        INTO v_all_cnt, v_shoe_cnt
        FROM scmdata.t_factory_report a
       INNER JOIN scmdata.t_factory_report_ability b
          ON a.factory_report_id = b.factory_report_id
         AND a.company_id = b.company_id
       WHERE a.factory_ask_id = p_factory_ask_id
         AND a.company_id = p_company_id;
    
      IF v_shoe_cnt = 0 THEN
        v_sender := 'YQL13';
      ELSIF v_shoe_cnt = v_all_cnt THEN
        v_sender := 'KP2';
      ELSE
        v_sender := 'YQL13;KP2';
      END IF;
      v_msg_body := '您好，<' || v_sup_name ||
                    '>供应商的验厂报告已提交,请及时审核。详情请前往SCM系统进行查看,谢谢！';
    ELSE
      raise_application_error(-20002,
                              '企微机器人发送消息失败,请联系管理员！！');
    END IF;
  
    --触发消息通知
    v_wx_sql := scmdata.pkg_plat_comm.send_wx_msg(p_company_id => p_company_id,
                                                  p_msgtype    => p_msgtype,
                                                  p_msg_title  => p_msg_title,
                                                  p_msg_body   => v_msg_body,
                                                  p_sender     => v_sender,
                                                  p_bot_key    => p_bot_key,
                                                  p_robot_type => p_robot_type);
    RETURN v_wx_sql;
  END send_fac_wx_msg;
  ----------------------------------------------------  业务代码   end  ---------------------------------------------------------------------------
END pkg_supplier_info;
/
