CREATE OR REPLACE PACKAGE SCMDATA.pkg_capacity_management IS

  /*=======================================================================
  
    获取品类合作供应商主表启停状态
  
    用途:
      获取品类合作供应商主表启停状态
  
    入参:
      V_SUPCODE :  供应商编码
      V_CATE    :  分类
      V_PROCATE :  生产分类
      V_SUBCATE :  子类
      V_COMPID  :  企业Id
  
    版本:
      2022-04-06 : 对工厂非合作范围数据进行校验，停用，并且不展示处理
      2022-05-10 : 对合作工厂启停状态修正
  
  =======================================================================*/
  --need
  FUNCTION f_get_supcsp_pause
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER;

  /*=======================================================================
  
    【已测通】对工厂非合作范围数据校验，停用，不展示
  
    用途:
      用于对工厂非合作范围数据进行校验，停用，并且不展示处理
  
    入参:
      V_SUPCODE :  供应商编码
      V_FACCODE :  生产工厂编码
      V_COMPID  :  企业Id
  
    版本:
      2022-04-06 : 对工厂非合作范围数据进行校验，停用，并且不展示处理
  
  =======================================================================*/
  --need
  PROCEDURE p_csn_coopfaccfg
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*=======================================================================
  
    【已测通】品类合作供应商新增数据
  
    用途:
      用于生成品类合作供应商数据
  
    用于:
      供应商开工通用配置
  
    入参:
      V_SUPCODE :  供应商编码
      V_COMPID  :  企业Id
      V_CURID   :  当前操作人Id
  
    版本:
      2021-11-23 : 用于生成品类合作供应商数据
  
  =======================================================================*/
  --need
  PROCEDURE p_ins_catecoopsup_data
  (
    v_supcode IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_curid   IN VARCHAR2,
    v_mode    IN VARCHAR2
  );

  /*=======================================================================
  
    根据供应商编码，生产工厂编码生成品类合作供应商数据
  
    用途:
      根据供应商编码，生产工厂编码生成品类合作供应商数据
  
    入参:
      V_SUPCODE :  供应商编码
      V_FACCODE :  生产工厂编码
      V_CURID   :  当前操作人Id
      V_COMPID  :  企业Id
  
    版本:
      2022-04-06 : 对工厂非合作范围数据进行校验，停用，并且不展示处理
  
  =======================================================================*/
  --need
  PROCEDURE p_ins_catecoopsup_data_bysf
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_curid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*=======================================================================
  
    根据供应商编码，分类-生产分类-子类生成品类合作供应商数据
  
    用途:
      根据供应商编码，分类-生产分类-子类生成品类合作供应商数据
  
    入参:
      V_SUPCODE :  供应商编码
      V_FACCODE :  生产工厂编码
      V_CURID   :  当前操作人Id
      V_COMPID  :  企业Id
  
    版本:
      2022-05-10 : 根据供应商编码，分类-生产分类-子类生成品类合作供应商数据
  
  =======================================================================*/
  --need
  PROCEDURE p_ins_catecoopsup_data_onlyscps
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_curid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*=====================================================================================
  
    获取单条配置中所有年不开工日期
  
    用途:
     获取单条配置中所有年不开工日期
  
    用于:
      供应商开工通用配置
  
    入参:
      V_SSWCID  :  供应商不开工配置Id
      V_COMPID  :  企业Id
  
    返回值:
      SCMDATA.T_DAY_DIM.DD_ID的集合，多值以分号分隔
  
    版本:
      2021-11-18 : 获取单条配置中所有年不开工日期
  
  ======================================================================================*/
  --need
  FUNCTION f_get_cfgdatesids
  (
    v_sswcids IN CLOB,
    v_compid  IN VARCHAR2
  ) RETURN CLOB;

  /*=====================================================================================
  
    多值去重
  
    用途:
     用于去除单个字符串中的重复值
  
    用于:
      供应商开工通用配置
  
    入参:
      V_DATA       :  重复值数据
      V_SEPSYMBOL  :  分隔符
  
    返回值:
      去重后的字符串
  
    版本:
      2021-11-18 : 用于去除单个字符串中的重复值
  
  ======================================================================================*/
  --need
  FUNCTION f_get_unq_data
  (
    v_data      IN CLOB,
    v_sepsymbol IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
  
    获取周次补正值
  
    用途:
      用于获取当前日期周次补正值，如果某年1月1日是周一，则周次补正值为0，否则为1
  
    用于:
      供应商开工通用配置
  
    入参:
      V_DATE  :  日期
  
    返回值:
      周次补正值，数字类型
  
    版本:
      2021-11-16 : 用于获取当前日期周次补正值，
                   如果某年1月1日是周一，则周次补正值为0，否则为1
  
  ===================================================================================*/
  FUNCTION f_get_weekaddnum(v_date IN DATE) RETURN NUMBER;

  /*===================================================================================
  
    获取年周次
  
    用途:
      用于获取某个日期的周次，已某年1月1日为第一周
  
    用于:
      供应商开工通用配置
  
    入参:
      V_DATE  :  日期
  
    返回值:
      年周次(YYWW)，数字类型
  
    版本:
      2021-11-16 : 用于获取某个日期的周次，以某年1月1日为第一周
  
  ===================================================================================*/
  FUNCTION f_get_weeknum(v_date IN DATE) RETURN NUMBER;

  /*=====================================================================================
  
    通过周不开工日期获取某年内符合配置的日期
  
    用途:
     通过周不开工日期获取某年内符合配置的日期
  
    用于:
      供应商开工通用配置
  
    入参:
      V_YEAR       :  年份
      V_WKINFO     :  周不开工日期
      V_SEPSYMBOL  :  分隔符
  
    返回值:
      SCMDATA.T_DAY_DIM.DD_ID的集合，多值以分号分隔
  
    版本:
      2021-11-18 : 通过周不开工日期获取某年内符合配置的日期
  
  ======================================================================================*/
  --need
  FUNCTION f_get_supnwcfg_weekdateids
  (
    v_year      IN NUMBER,
    v_wkinfo    IN VARCHAR2,
    v_sepsymbol IN VARCHAR2
  ) RETURN CLOB;

  /*=====================================================================================
  
    通过月不开工日期获取某年内符合配置的日期
  
    用途:
     通过周不开工日期获取某年内符合配置的日期
  
    用于:
      供应商开工通用配置
  
    入参:
      V_YEAR       :  年份
      V_WKINFO     :  月不开工日期
      V_SEPSYMBOL  :  分隔符
  
    返回值:
      SCMDATA.T_DAY_DIM.DD_ID的集合，多值以分隔符分隔
  
    版本:
      2021-11-18 : 通过月不开工日期获取某年内符合配置的日期
  
  ======================================================================================*/
  --need
  FUNCTION f_get_supnwcfg_monthdateids
  (
    v_year      IN NUMBER,
    v_mtinfo    IN VARCHAR2,
    v_sepsymbol IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
  
    获取分类-生产分类-子类名称
  
    用途:
      用于分类-生产分类-子类名称
  
    用于:
      生产周期配置
  
    入参:
      V_CATE      :  供应商编码
      V_PRODCATE  :  生产分类
      V_SUBCATE   :  子类
      V_COMPID    :  企业Id
  
    版本:
      2021-11-18 : 用于获取供应商名称
  
  ===================================================================================*/
  --need
  FUNCTION f_get_cps_name
  (
    v_cate     IN VARCHAR2,
    v_prodcate IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    【未测试】用于获取某工厂所在配置的不开工日期
  
    用途:
      用于获取某工厂所在配置的不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_SUPCODE  :  供应商编码
      V_BRAID    :  分部Id
      V_COMPID   :  企业Id
  
    版本:
      2021-11-30 : 用于获取某工厂所在配置的不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_get_notworkdays
  (
    v_supcode IN VARCHAR2,
    v_braid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
  
    【已测试】能否通过工厂编码获取某周不开工日期
  
    用途:
      用于判断能否通过工厂编码获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_SUPCODE  :  供应商编码
      V_PROVID   :  省Id
      V_CITYID   :  市Id
      V_CONTID   :  区Id
      V_BRAID    :  分部Id
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过工厂编码获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_get_notworkday_sswcid
  (
    v_supcode IN VARCHAR2,
    v_provid  IN VARCHAR2,
    v_cityid  IN VARCHAR2,
    v_counid  IN VARCHAR2,
    v_braid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    【已测试】能否通过工厂编码获取某周不开工日期
  
    用途:
      用于判断能否通过工厂编码获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_SUPCODE  :  供应商编码
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过工厂编码获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_can_get_notwork_by_faccode
  (
    v_supcode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    【已测试】能否通过区域获取某周不开工日期
  
    用途:
      用于判断能否通过省市区获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_PROVINCE :  省编码
      V_CITY     :  市编码
      V_COUNTRY  :  区编码
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过省市区获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_can_get_notwork_by_pcc
  (
    v_province IN VARCHAR2,
    v_city     IN VARCHAR2,
    v_country  IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    【已测试】能否通过区域+分部获取某周不开工日期
  
    用途:
      用于判断能否通过区域+分部获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_PROVINCE :  省编码
      V_CITY     :  市编码
      V_COUNTRY  :  区编码
      V_BRAID    :  分部Id
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过区域+分部获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_can_get_notwork_by_pccbra
  (
    v_province IN VARCHAR2,
    v_city     IN VARCHAR2,
    v_country  IN VARCHAR2,
    v_braid    IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    【未测试】能否通过分部获取某周不开工日期
  
    用途:
      用于能否通过分部获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_BRAID    :  分部Id
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过工厂编码获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_can_get_notwork_by_bra
  (
    v_braid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    预计新品导入校验
  
    用途:
      用于预计新品导入总校验
  
    用于:
      预计新品导入
  
    入参:
      isdsupcode     :  内部供应商编号
      v_compid       :  企业id
      v_catename     :  分类名称
      v_procname     :  生产分类名称
      v_subcname     :  子类名称
      v_seaname      :  季节
      v_wave         :  波段
      v_hsamt        :  爆品可能数量
      v_nmamt        :  非爆品可能数量
      v_orddate      :  预计下单日期
      v_deldate      :  预计交货日期
      v_errmsgs      :  错误信息变量
      v_status       :  状态变量
      v_category     :  分类变量
      v_prodcate     :  生产分类变量
      v_subcate      :  子类变量
      v_season       :  季节变量
      v_supcode      :  供应商编码变量
      v_supcompname  :  供应商名称变量
  
    版本:
      2021-12-20 : 校验输入年份不小于当前系统时间年份，
                   满足条件返回 0， 不满足条件返回 1
  
  ===================================================================================*/
  PROCEDURE p_check_plannew_import
  (
    v_isdsupcode  IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_catename    IN VARCHAR2,
    v_procname    IN VARCHAR2,
    v_subcname    IN VARCHAR2,
    v_seaname     IN VARCHAR2,
    v_wave        IN NUMBER,
    v_hsamt       IN NUMBER,
    v_nmamt       IN NUMBER,
    v_orddate     IN DATE,
    v_deldate     IN DATE,
    v_piid        IN VARCHAR2 DEFAULT NULL,
    v_importid    IN VARCHAR2,
    v_errmsgs     IN OUT VARCHAR2,
    v_status      IN OUT VARCHAR2,
    v_category    IN OUT VARCHAR2,
    v_prodcate    IN OUT VARCHAR2,
    v_subcate     IN OUT VARCHAR2,
    v_season      IN OUT VARCHAR2,
    v_supcode     IN OUT VARCHAR2,
    v_supcompname IN OUT VARCHAR2
  );

  /*===================================================================================
  
    预计补单导入校验逻辑
  
    用途:
      预计补单导入校验逻辑
  
    入参:
      v_isdsupcode  :  内部供应商编码
      v_catename    :  分类名称
      v_procatename :  生产分类名称
      v_subcatename :  产品子类名称
      v_preorddate  :  预计下单日期
      v_predlvdate  :  预计交期
      v_preordamt   :  预计下单数量
      v_compid      :  企业id
      v_cate        :  分类
      v_procate     :  生产分类
      v_subcate     :  产品子类
      v_supcode     :  供应商编码
      v_supname     :  供应商名称
  
    出参:
      v_cate        :  分类
      v_procate     :  生产分类
      v_subcate     :  产品子类
      v_supcode     :  供应商编码
      v_supname     :  供应商名称
      v_errmsg      :  错误信息
  
    版本:
      2022-08-02 : 用于预计补单导入校验
  
  ===================================================================================*/
  PROCEDURE p_plnsupp_importcheck
  (
    v_isdsupcode  IN VARCHAR2,
    v_catename    IN VARCHAR2,
    v_procatename IN VARCHAR2,
    v_subcatename IN VARCHAR2,
    v_preorddate  IN DATE,
    v_predlvdate  IN DATE,
    v_preordamt   IN NUMBER,
    v_psiid       IN VARCHAR2,
    v_importer    IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_cate        IN OUT VARCHAR2,
    v_procate     IN OUT VARCHAR2,
    v_subcate     IN OUT VARCHAR2,
    v_supcode     IN OUT VARCHAR2,
    v_supname     IN OUT VARCHAR2,
    v_status      IN OUT VARCHAR2,
    v_errmsg      IN OUT CLOB
  );

  /*===================================================================================
  
    【已测试】计算: 产能上限，约定产能
  
    用途:
      通过 SCMDATA.T_SUPPLIER_CAPACITY_DETAIL.PTC_ID(供应商产能明细清单Id)
      计算 产能上限，约定产能，预约产能占比
  
    计算公式:
      产能上限 = 上班时数 * 60 * 车位人数 * 生产效率
      约定产能 = 上班时数 * 60 * 车位人数 * 生产效率 * 预约产能占比
  
    用于:
      供应商产能预约
    版本:
  
      2021-11-29 : 通过 SCMDATA.T_SUPPLIER_CAPACITY_DETAIL.PTC_ID(供应商产能明细清单Id)
                   计算产能上限
  
  ===================================================================================*/
  --need
  PROCEDURE p_calculate_capacity_rela
  (
    v_ptcid       IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_capcceiling IN OUT NUMBER,
    v_appcapacity IN OUT NUMBER
  );

  /*===================================================================================
  
    获取某工厂除当前供应商外的剩余产能占比
  
    用途:
      用于获取某工厂除当前供应商外的剩余产能占比
  
    用于:
      生产周期配置
  
    入参:
      V_CATE     :  分类Id
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  工厂编码
      V_COMPID   :  企业Id
  
    版本:
      2021-12-06 : 用于获取某工厂除当前供应商外的剩余产能占比
      2022-08-22 : 表维度修改
  
  ===================================================================================*/
  --need
  FUNCTION f_get_restcapc_rate
  (
    v_cate    IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER;

  /*===================================================================================
  
    根据供应商编码生成生产工厂产能预约配置数据
  
    用途:
      用于根据供应商编码生成生产工厂产能预约配置数据
  
    入参:
      V_SUPCODE  :  供应商编码
      V_COMPID   :  企业Id
  
    版本:
      2022-03-21 : 根据供应商编码生成生产工厂产能预约配置数据
      2022-08-22 : 表维度修改
      2022-09-16 : 增加操作人和操作时间
  
  ===================================================================================*/
  --need
  PROCEDURE p_gen_appcapccfg_data_by_sup
  (
    v_supcode  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*=============================================================================
  
     包：
       pkg_capacity_management(产能管理包)
  
     过程名:
       产能操作日志新增
  
     入参:
       v_inp_module_code    :  模块编码
       v_inp_module_name    :  模块名称
       v_inp_program_code   :  程序编码
       v_inp_program_name   :  程序名称
       v_inp_oper_type      :  操作类型
       v_inp_oper_detail    :  操作明细
       v_inp_oper_userid    :  操作人Id
       v_inp_oper_time      :  操作时间
       v_inp_oper_source    :  操作源
       v_inp_rela_unqfield1 :  关联唯一字段1
       v_inp_rela_unqfield2 :  关联唯一字段2
       v_inp_rela_unqfield3 :  关联唯一字段3
       v_inp_rela_unqfield4 :  关联唯一字段4
       v_inp_rela_unqfield5 :  关联唯一字段5
       v_inp_company_id     :  企业Id
  
     版本:
       2023-04-25_zc314 : 产能操作日志新增
  
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capacity_operlog
  (
    v_inp_module_code    IN scmdata.t_capacity_operlog.module_code%TYPE DEFAULT NULL,
    v_inp_module_name    IN scmdata.t_capacity_operlog.module_name%TYPE DEFAULT NULL,
    v_inp_program_code   IN scmdata.t_capacity_operlog.program_code%TYPE DEFAULT NULL,
    v_inp_program_name   IN scmdata.t_capacity_operlog.program_name%TYPE DEFAULT NULL,
    v_inp_oper_type      IN scmdata.t_capacity_operlog.oper_type%TYPE DEFAULT NULL,
    v_inp_oper_detail    IN scmdata.t_capacity_operlog.oper_detail%TYPE DEFAULT NULL,
    v_inp_oper_userid    IN scmdata.t_capacity_operlog.oper_userid%TYPE DEFAULT NULL,
    v_inp_oper_time      IN scmdata.t_capacity_operlog.oper_time%TYPE DEFAULT NULL,
    v_inp_oper_source    IN scmdata.t_capacity_operlog.oper_source%TYPE DEFAULT NULL,
    v_inp_rela_unqfield1 IN scmdata.t_capacity_operlog.rela_unqfield1%TYPE DEFAULT NULL,
    v_inp_rela_unqfield2 IN scmdata.t_capacity_operlog.rela_unqfield2%TYPE DEFAULT NULL,
    v_inp_rela_unqfield3 IN scmdata.t_capacity_operlog.rela_unqfield3%TYPE DEFAULT NULL,
    v_inp_rela_unqfield4 IN scmdata.t_capacity_operlog.rela_unqfield4%TYPE DEFAULT NULL,
    v_inp_rela_unqfield5 IN scmdata.t_capacity_operlog.rela_unqfield5%TYPE DEFAULT NULL,
    v_inp_company_id     IN scmdata.t_capacity_operlog.company_id%TYPE DEFAULT NULL,
    v_inp_invoke_object  IN VARCHAR2
  );

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       工厂生产类别占比配置操作日志新增
      
     入参:
       v_inp_supplier_code            :  供应商编码
       v_inp_factory_code             :  生产工厂编码
       v_inp_category                 :  分类编码
       v_inp_product_cate             :  生产分类编码
       v_inp_old_allocate_percentage  :  旧分配比例
       v_inp_new_allocate_percentage  :  新分配比例
       v_inp_oper_id                  :  操作人Id
       v_inp_oper_type                :  操作类型
       v_inp_oper_time                :  操作时间
       v_inp_oper_source              :  操作源
       v_inp_company_id               :  企业Id
        
     版本:
       2023-06-09_zc314 : 工厂生产类别占比配置操作日志新增
      
  ==============================================================================*/
  PROCEDURE p_capc_fac_procate_rate_cfg_operlog_ins
  (
    v_inp_supplier_code           IN VARCHAR2,
    v_inp_factory_code            IN VARCHAR2,
    v_inp_category                IN VARCHAR2,
    v_inp_product_cate            IN VARCHAR2,
    v_inp_old_allocate_percentage IN NUMBER,
    v_inp_new_allocate_percentage IN NUMBER,
    v_inp_oper_id                 IN VARCHAR2,
    v_inp_oper_type               IN VARCHAR2,
    v_inp_oper_time               IN DATE,
    v_inp_oper_source             IN VARCHAR2,
    v_inp_company_id              IN VARCHAR2
  );

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       供应商产品子类占比配置操作日志新增
      
     入参:
       v_inp_supplier_code            :  供应商编码
       v_inp_category                 :  分类编码
       v_inp_product_cate             :  生产分类编码
       v_inp_subcategory              :  产品子类编码
       v_inp_old_allocate_percentage  :  旧分配比例
       v_inp_new_allocate_percentage  :  新分配比例
       v_inp_module_code              :  模块编码
       v_inp_module_name              :  模块名
       v_inp_program_code             :  程序编码
       v_inp_program_name             :  程序名
       v_inp_oper_id                  :  操作人Id
       v_inp_oper_type                :  操作类型
       v_inp_oper_time                :  操作时间
       v_inp_oper_source              :  操作源
       v_inp_company_id               :  企业Id
        
     版本:
       2023-06-12_zc314 : 供应商产品子类占比配置操作日志新增
      
  ==============================================================================*/
  PROCEDURE p_capc_sup_subcate_rate_cfg_operlog_ins
  (
    v_inp_supplier_code           IN VARCHAR2,
    v_inp_category                IN VARCHAR2,
    v_inp_product_cate            IN VARCHAR2,
    v_inp_subcategory             IN VARCHAR2,
    v_inp_old_allocate_percentage IN NUMBER,
    v_inp_new_allocate_percentage IN NUMBER,
    v_inp_oper_id                 IN VARCHAR2,
    v_inp_oper_type               IN VARCHAR2,
    v_inp_oper_time               IN DATE,
    v_inp_oper_source             IN VARCHAR2,
    v_inp_company_id              IN VARCHAR2
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       生成产能操作日志
    
     入参:
       v_inp_oper_userid  :  操作人Id
       v_inp_oper_time    :  操作时间
       v_inp_oper_detail  :  操作明细
       v_inp_company_id   :  企业Id
    
     版本:
       2023-04-25_zc314 : 生成产能操作日志
    
  ==============================================================================*/
  FUNCTION f_gen_capacity_operlog_msg
  (
    v_inp_oper_userid IN VARCHAR2,
    v_inp_oper_time   IN DATE,
    v_inp_oper_detail IN VARCHAR2,
    v_inp_company_id  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       生成工厂生产分类占比操作日志
    
     入参:
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_old_allocatepercent  :  旧分配比例
       v_inp_new_allocatepercent  :  新分配比例
    
     版本:
       2023-04-25_zc314 : 生成工厂生产分类占比操作日志
    
  ==============================================================================*/
  FUNCTION f_gen_facprocatecfg_operdetail
  (
    v_inp_category            IN VARCHAR2,
    v_inp_product_cate        IN VARCHAR2,
    v_inp_old_allocatepercent IN NUMBER,
    v_inp_new_allocatepercent IN NUMBER
  ) RETURN VARCHAR2;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       生成供应商产品子类占比操作日志
    
     入参:
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  生产分类编码
       v_inp_old_allocatepercent  :  旧分配比例
       v_inp_new_allocatepercent  :  新分配比例
       v_inp_company_id           :  企业Id
    
     版本:
       2023-05-25_zc314 : 生成供应商产品子类占比操作日志
    
  ==============================================================================*/
  FUNCTION f_gen_supsubcatecfg_operdetail
  (
    v_inp_product_cate        IN VARCHAR2,
    v_inp_subcategory         IN VARCHAR2,
    v_inp_old_allocatepercent IN NUMBER,
    v_inp_new_allocatepercent IN NUMBER,
    v_inp_company_id          IN VARCHAR2
  ) RETURN VARCHAR2;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       产能配置-获取生产工厂生产类别占比配置信息
          
     入参:
       v_inp_cfprc_id              :  生产工厂生产类别占比配置Id
       v_inp_company_id            :  企业Id
       v_inp_supplier_code         :  供应商编码
       v_inp_factory_code          :  生产工厂编码
       v_inp_category              :  分类编码
       v_inp_product_cate          :  生产分类编码
       v_inp_infofrom              :  信息来源 NORMAL-业务表 VIEW-view表
      
     入出参:
       v_iop_supplier_code         :  供应商编码
       v_iop_factory_code          :  生产工厂编码
       v_iop_category              :  分类编码
       v_iop_product_cate          :  生产分类编码
       v_iop_old_allocate_percent  :  旧分配比例
          
     版本:
       2023-06-12_zc314 : 产能配置-获取生产工厂生产类别占比配置信息
          
  ==============================================================================*/
  PROCEDURE p_get_capc_fac_procate_rate_cfg_info
  (
    v_inp_cfprc_id             IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE,
    v_inp_company_id           IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE,
    v_inp_supplier_code        IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_inp_factory_code         IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_inp_category             IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_inp_product_cate         IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_inp_infofrom             IN VARCHAR2,
    v_iop_supplier_code        IN OUT scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_iop_factory_code         IN OUT scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_iop_category             IN OUT scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_iop_product_cate         IN OUT scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_iop_old_allocate_percent IN OUT NUMBER
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-根据主键进行生产工厂生产类别占比配置修改
    
     入参:
       v_inp_cfprc_id            :  生产工厂生产类别占比表Id
       v_inp_company_id          :  企业Id
       v_inp_allocate_percentage :  分配占比
       v_inp_update_id           :  修改人Id
       v_inp_update_time         :  修改时间
       v_inp_invoke_object       :  调用对象
    
     版本:
       2023-04-26_zc314 : 产能配置-根据主键进行生产工厂生产类别占比配置修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_fac_procate_rate_cfg_by_pk
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE,
    v_inp_update_id           IN scmdata.t_capc_fac_procate_rate_cfg.update_id%TYPE,
    v_inp_update_time         IN scmdata.t_capc_fac_procate_rate_cfg.update_time%TYPE,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-根据唯一键进行生产工厂生产类别占比配置修改
    
     入参:
       v_inp_supplier_code       :  供应商编码
       v_inp_factory_code        :  生产工厂编码
       v_inp_category            :  分类编码
       v_inp_product_cate        :  生产分类编码
       v_inp_company_id          :  企业Id
       v_inp_allocate_percentage :  分配占比
       v_inp_update_id           :  修改人Id
       v_inp_update_time         :  修改时间
       v_inp_invoke_object       :  调用对象
    
     版本:
       2023-04-26_zc314 : 产能配置-根据唯一键进行生产工厂生产类别占比配置修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_fac_procate_rate_cfg_by_uk
  (
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE,
    v_inp_update_id           IN scmdata.t_capc_fac_procate_rate_cfg.update_id%TYPE,
    v_inp_update_time         IN scmdata.t_capc_fac_procate_rate_cfg.update_time%TYPE,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置修改
    
     入参:
       v_inp_cfprc_id            :  生产工厂生产类别占比配置Id
       v_inp_supplier_code       :  供应商编码
       v_inp_factory_code        :  生产工厂编码
       v_inp_category            :  分类编码
       v_inp_product_cate        :  生产分类编码
       v_inp_allocate_percentage :  分配占比
       v_inp_update_id           :  修改人Id
       v_inp_update_time         :  修改时间
       v_inp_company_id          :  企业Id
       v_inp_invoke_object       :  调用对象
    
     版本:
       2023-04-26_zc314 : 产能配置-生产工厂生产类别占比配置修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_fac_procate_rate_cfg
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_update_id           IN scmdata.t_capc_fac_procate_rate_cfg.update_id%TYPE DEFAULT NULL,
    v_inp_update_time         IN scmdata.t_capc_fac_procate_rate_cfg.update_time%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-生产工厂生产类别占比配置新增/修改
        
     入参:
       v_inp_cfprc_id            :  
       v_inp_company_id          :  企业Id
       v_inp_supplier_code       :  供应商编码
       v_inp_factory_code        :  生产工厂编码
       v_inp_category            :  分类编码
       v_inp_product_cate        :  生产分类编码
       v_inp_allocate_percentage :  分配占比
       v_inp_operate_id          :  操作人Id
       v_inp_operate_time        :  操作时间
       v_inp_oper_source         ： 操作数据源 SYSC-系统变更 MANC-人为变更
        
     版本:
       2023-06-12_zc314 : 产能配置-生产工厂生产类别占比配置新增/修改
        
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capc_fac_procate_rate_cfg
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE,
    v_inp_pause               IN scmdata.t_capc_fac_procate_rate_cfg.pause%TYPE,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg.create_id%TYPE,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg.create_time%TYPE,
    v_inp_oper_source         IN VARCHAR2
  );

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-根据主键判断工厂生产分类占比配置是否存在
        
     入参:
       v_inp_cfprc_id    :  供应商编码
       v_inp_company_id  :  生产工厂编码
        
     版本:
       2023-05-05_zc314 : 产能配置-根据主键判断工厂生产分类占比配置是否存在
        
  ==============================================================================*/
  FUNCTION f_is_capc_fac_procate_rate_exists_by_pk
  (
    v_inp_cfprc_id   IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE,
    v_inp_company_id IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE
  ) RETURN NUMBER;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-根据唯一键判断供应商产品子类占比配置是否存在
        
     入参:
       v_inp_supplier_code  :  供应商编码
       v_inp_factory_code   :  生产工厂编码
       v_inp_category       :  分类编码
       v_inp_product_cate   :  生产分类编码
       v_inp_company_id     :  企业Id
        
     版本:
       2023-05-06_zc314 : 产能配置-根据唯一键判断供应商产品子类占比配置是否存在
        
  ==============================================================================*/
  FUNCTION f_is_capc_fac_procate_rate_exists_by_uk
  (
    v_inp_supplier_code IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_inp_factory_code  IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_inp_category      IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_inp_product_cate  IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_inp_company_id    IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE
  ) RETURN NUMBER;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表新增
    
     入参:
       v_inp_cfprcv_id            :  生产工厂生产类别占比配置view表Id
       v_inp_company_id           :  企业Id
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_factory_code         :  生产工厂编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_allocate_percentage  :  分配计算占比
       v_inp_pause                :  是否作废 0-正常 1-作废
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_invoke_object        :  调用对象
      
     版本: 
       2023-05-06_zc314 : 产能配置-生产工厂生产类别占比配置view表新增
    
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capc_fac_procate_rate_cfg_view
  (
    v_inp_cfprcv_id           IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprcv_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL,
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg_view.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg_view.factory_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg_view.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg_view.product_cate%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg_view.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_pause               IN scmdata.t_capc_fac_procate_rate_cfg_view.pause%TYPE DEFAULT NULL,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_time%TYPE DEFAULT NULL,
    v_inp_operate_method      IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_method%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  );
  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表新增
    
     入参:
       v_inp_cfprcv_id            :  生产工厂生产类别占比配置view表Id
       v_inp_company_id           :  企业Id
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_factory_code         :  生产工厂编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_allocate_percentage  :  分配计算占比
       v_inp_pause                :  是否作废 0-正常 1-作废
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-05-06_zc314 : 产能配置-生产工厂生产类别占比配置view表新增
    
  ==============================================================================*/
  /*PROCEDURE p_tabapi_ins_capc_fac_procate_rate_cfg_view
  (
    v_inp_cfprcv_id           IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprcv_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL,
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg_view.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg_view.factory_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg_view.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg_view.product_cate%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg_view.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_pause               IN scmdata.t_capc_fac_procate_rate_cfg_view.pause%TYPE DEFAULT NULL,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_time%TYPE DEFAULT NULL,
    v_inp_operate_method      IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_method%TYPE DEFAULT NULL,
    v_inp_oper_source         IN VARCHAR2,
    v_inp_invoke_object       IN VARCHAR2
  );*/

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表修改
    
     入参:
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配计算占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_operate_method       :  操作方法: INS-新增 UPD-修改 DEL-删除
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-04-25_zc314 : 产能配置-生产工厂生产类别占比配置view表修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_fac_procate_rate_cfg_view_by_pk
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg_view.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_time%TYPE DEFAULT NULL,
    v_inp_operate_method      IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_method%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表是否存在
    
     入参:
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_company_id           :  企业Id
      
     版本:
       2023-04-27_zc314 : 产能配置-生产工厂生产类别占比配置view表是否存在
    
  ==============================================================================*/
  FUNCTION f_jugnum_capc_fac_procate_rate_cfg_view_exists
  (
    v_inp_cfprc_id   IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_company_id IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL
  ) RETURN NUMBER;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表新增/修改
    
     入参:
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_factory_code         :  生产工厂编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_allocate_percentage  :  分配计算占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_company_id           :  企业Id
       v_inp_oper_source          :  操作源 SYSC-系统 MANC-手动
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-04-27_zc314 : 产能配置-生产工厂生产类别占比配置view表新增/修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capc_fac_procate_rate_cfg_view
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg_view.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg_view.factory_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg_view.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg_view.product_cate%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg_view.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_time%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL,
    v_inp_oper_source         IN VARCHAR2,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
      产能配置-生产工厂生产类别占比配置0/100校验
    
     入参:
       v_inp_supplier_code        :  供应商编码
       v_inp_factory_code         :  生产工厂编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_cfprc_id             :  生产工厂生产类别占比配置Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配占比
      
     版本:
       2023-05-18_zc314 : 产能配置-生产工厂生产类别占比配置0/100校验
    
  ==============================================================================*/
  PROCEDURE p_tabapi_check_zerohundred_capc_fac_procate_rate_cfg
  (
    v_inp_supplier_code       IN VARCHAR2,
    v_inp_factory_code        IN VARCHAR2,
    v_inp_category            IN VARCHAR2,
    v_inp_cfprc_id            IN VARCHAR2,
    v_inp_company_id          IN VARCHAR2,
    v_inp_allocate_percentage IN NUMBER
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-供应商产品子类占比配置表新增
    
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  子类编码
       v_inp_allocate_percentage  :  分配占比
       v_inp_create_id            :  创建人Id
       v_inp_create_time          :  创建时间
       v_inp_company_id           :  企业Id
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-04-27_zc314 : 产能配置-供应商产品子类占比配置表新增
    
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capc_sup_subcate_rate_cfg
  (
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_sup_subcate_rate_cfg.supplier_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_sup_subcate_rate_cfg.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_sup_subcate_rate_cfg.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory         IN scmdata.t_capc_sup_subcate_rate_cfg.subcategory%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_create_id           IN scmdata.t_capc_sup_subcate_rate_cfg.create_id%TYPE DEFAULT NULL,
    v_inp_create_time         IN scmdata.t_capc_sup_subcate_rate_cfg.create_time%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     函数名:
       产能配置-获取供应商产品子类占比配置表是否存在判断值
    
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_company_id           :  企业Id
       
     返回值:
       Number 类型，返回值 0-不存在 1-存在
      
     版本:
       2023-04-28_zc314 : 产能配置-获取供应商产品子类占比配置表是否存在判断值
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_sup_subcate_rate_cfg
  (
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_update_id           IN scmdata.t_capc_sup_subcate_rate_cfg.update_id%TYPE DEFAULT NULL,
    v_inp_update_time         IN scmdata.t_capc_sup_subcate_rate_cfg.update_time%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     函数名:
       产能配置-获取供应商产品子类占比配置表是否存在判断值
    
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_company_id           :  企业Id
       
     返回值:
       Number 类型，返回值 0-不存在 1-存在
      
     版本:
       2023-04-28_zc314 : 产能配置-获取供应商产品子类占比配置表是否存在判断值
    
  ==============================================================================*/
  FUNCTION f_tabapi_is_capc_sup_subcate_rate_cfg_exists_pk
  (
    v_inp_cssrc_id   IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE DEFAULT NULL,
    v_inp_company_id IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE DEFAULT NULL
  ) RETURN NUMBER;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     函数名:
       产能配置-根据唯一键获取供应商产品子类占比配置表是否存在判断值
      
     入参:
       v_inp_supplier_code  :  供应商编码
       v_inp_category       :  分类编码
       v_inp_product_cate   :  生产分类编码
       v_inp_subcategory    :  产品子类编码
       v_inp_company_id     :  企业Id
         
     返回值:
       Number 类型，返回值 0-不存在 1-存在
        
     版本:
       2023-04-28_zc314 : 产能配置-根据唯一键获取供应商产品子类占比配置表是否存在判断值
      
  ==============================================================================*/
  FUNCTION f_tabapi_is_capc_sup_subcate_rate_cfg_exists_uk
  (
    v_inp_supplier_code IN scmdata.t_capc_sup_subcate_rate_cfg.supplier_code%TYPE,
    v_inp_category      IN scmdata.t_capc_sup_subcate_rate_cfg.category%TYPE,
    v_inp_product_cate  IN scmdata.t_capc_sup_subcate_rate_cfg.product_cate%TYPE,
    v_inp_subcategory   IN scmdata.t_capc_sup_subcate_rate_cfg.subcategory%TYPE,
    v_inp_company_id    IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE
  ) RETURN NUMBER;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       产能配置-供应商产品子类占比配置表新增/修改
      
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  子类编码
       v_inp_allocate_percentage  :  分配占比
       v_inp_operate_userid       :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_company_id           :  企业Id
       v_inp_oper_source          :  操作源：SYSC-系统变更 MANC-人为变更
        
     版本:
       2023-06-12_zc314 : 产能配置-供应商产品子类占比配置表新增/修改
      
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capc_sup_subcate_rate_cfg
  (
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_sup_subcate_rate_cfg.supplier_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_sup_subcate_rate_cfg.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_sup_subcate_rate_cfg.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory         IN scmdata.t_capc_sup_subcate_rate_cfg.subcategory%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_operate_userid      IN scmdata.t_capc_sup_subcate_rate_cfg.create_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_sup_subcate_rate_cfg.create_time%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_oper_source         IN VARCHAR2
  );

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       产能配置-供应商产品子类占比配置view表新增
      
     入参:
       v_inp_cssrcv_id            :  供应商产品子类占比配置表Id
       v_inp_company_id           :  企业Id
       v_inp_cssrc_id             :  供应商产品子类占比配置view表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_allocate_percentage  :  分配占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_operate_method       :  操作方法：INS-新增 UPD-修改 DEL-删除
       v_inp_oper_source          :  操作源： SYSC-系统 MANC-手动
       v_inp_invoke_object        :  调用对象
        
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置view表新增
      
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capc_sup_subcate_rate_cfg_view
  (
    v_inp_cssrcv_id           IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrcv_id%TYPE,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.company_id%TYPE,
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrc_id%TYPE,
    v_inp_supplier_code       IN scmdata.t_capc_sup_subcate_rate_cfg_view.supplier_code%TYPE,
    v_inp_category            IN scmdata.t_capc_sup_subcate_rate_cfg_view.category%TYPE,
    v_inp_product_cate        IN scmdata.t_capc_sup_subcate_rate_cfg_view.product_cate%TYPE,
    v_inp_subcategory         IN scmdata.t_capc_sup_subcate_rate_cfg_view.subcategory%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg_view.allocate_percentage%TYPE,
    v_inp_operate_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_id%TYPE,
    v_inp_operate_time        IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_time%TYPE,
    v_inp_operate_method      IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_method%TYPE,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-供应商产品子类占比配置view表修改
        
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置表Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_operate_method       :  操作方法：INS-新增 UPD-修改 DEL-删除
       v_inp_invoke_object        :  调用对象
          
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置view表修改
        
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_sup_subcate_rate_cfg_view
  (
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrc_id%TYPE,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.company_id%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg_view.allocate_percentage%TYPE,
    v_inp_operate_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_id%TYPE,
    v_inp_operate_time        IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_time%TYPE,
    v_inp_operate_method      IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_method%TYPE,
    v_inp_invoke_object       IN VARCHAR2
  );

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     函数名:
       产能配置-判断供应商产品子类占比配置view表是否存在
          
     入参:
       v_inp_cssrc_id    :  供应商产品子类占比配置表Id
       v_inp_company_id  :  企业Id
            
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置view表是否存在
          
  ==============================================================================*/
  FUNCTION f_tabapi_is_capc_sup_subcate_rate_cfg_view_exists
  (
    v_inp_cssrc_id   IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrc_id%TYPE,
    v_inp_company_id IN scmdata.t_capc_sup_subcate_rate_cfg_view.company_id%TYPE
  ) RETURN NUMBER;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       产能配置-供应商产品子类占比配置view表新增
      
     入参:
       v_inp_cssrcv_id            :  供应商产品子类占比配置表Id
       v_inp_company_id           :  企业Id
       v_inp_cssrc_id             :  供应商产品子类占比配置view表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_allocate_percentage  :  分配占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_oper_source          :  操作源：SYSC-系统 MANC-手动
        
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置view表新增
      
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capc_sup_subcate_rate_cfg_view
  (
    v_inp_cssrcv_id           IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrcv_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.company_id%TYPE,
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrc_id%TYPE,
    v_inp_supplier_code       IN scmdata.t_capc_sup_subcate_rate_cfg_view.supplier_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_sup_subcate_rate_cfg_view.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_sup_subcate_rate_cfg_view.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory         IN scmdata.t_capc_sup_subcate_rate_cfg_view.subcategory%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg_view.allocate_percentage%TYPE,
    v_inp_operate_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_id%TYPE,
    v_inp_operate_time        IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_time%TYPE,
    v_inp_oper_source         IN VARCHAR2
  );

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
      产能配置-供应商产品子类占比配置0/100校验
      
     入参:
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配占比
        
     版本:
       2023-05-18_zc314 : 产能配置-供应商产品子类占比配置0/100校验
      
  ==============================================================================*/
  PROCEDURE p_tabapi_check_zerohundred_capc_sup_subcate_rate_cfg
  (
    v_inp_supplier_code       IN VARCHAR2,
    v_inp_category            IN VARCHAR2,
    v_inp_product_cate        IN VARCHAR2,
    v_inp_cssrc_id            IN VARCHAR2,
    v_inp_company_id          IN VARCHAR2,
    v_inp_allocate_percentage IN NUMBER
  );

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     函数名:
       产能配置-获取工厂生产分类占比配置表数据生成sql
          
     入参:
       v_inp_supplier_code  :  供应商编码
       v_inp_factory_code   :  生产工厂编码
       v_inp_category       :  分类编码
       v_inp_product_cate   :  生产分类编码
       v_inp_company_id     :  企业Id
            
     版本:
       2023-05-05_zc314 : 产能配置-获取工厂生产分类占比配置表数据生成sql
          
  ==============================================================================*/
  FUNCTION f_get_capc_fac_procate_rate_cfg_datasql
  (
    v_inp_supplier_code IN VARCHAR2 DEFAULT NULL,
    v_inp_factory_code  IN VARCHAR2 DEFAULT NULL,
    v_inp_category      IN VARCHAR2 DEFAULT NULL,
    v_inp_product_cate  IN VARCHAR2 DEFAULT NULL,
    v_inp_company_id    IN VARCHAR2 DEFAULT NULL
  ) RETURN CLOB;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       产能配置-工厂产品子类占比配置表数据生成
          
     入参:
       v_inp_supplier_code    :  供应商编码
       v_inp_factory_code     :  生产工厂编码
       v_inp_category         :  分类编码 
       v_inp_product_cate     :  生产分类编码
       v_inp_company_id       :  企业Id
       v_inp_operate_userid   :  操作人Id
       v_inp_operate_time     :  操作时间
       v_inp_generate_mode    :  生成模式 IU-增改 I-增
            
     版本:
       2023-05-06_zc314 : 产能配置-工厂产品子类占比配置表数据生成
          
  ==============================================================================*/
  PROCEDURE p_gen_capc_fac_procate_rate_cfg_data
  (
    v_inp_supplier_code  IN VARCHAR2 DEFAULT NULL,
    v_inp_factory_code   IN VARCHAR2 DEFAULT NULL,
    v_inp_category       IN VARCHAR2 DEFAULT NULL,
    v_inp_product_cate   IN VARCHAR2 DEFAULT NULL,
    v_inp_company_id     IN VARCHAR2 DEFAULT NULL,
    v_inp_operate_userid IN VARCHAR2,
    v_inp_operate_time   IN DATE,
    v_inp_generate_mode  IN VARCHAR2
  );

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-获取供应商产品子类占比配置表数据生成sql
        
     入参:
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_company_id           :  企业Id
          
     版本:
       2023-05-05_zc314 : 产能配置-获取供应商产品子类占比配置表数据生成sql
        
  ==============================================================================*/
  FUNCTION f_get_capc_sup_subcate_rate_cfg_datasql
  (
    v_inp_supplier_code IN VARCHAR2 DEFAULT NULL,
    v_inp_category      IN VARCHAR2 DEFAULT NULL,
    v_inp_product_cate  IN VARCHAR2 DEFAULT NULL,
    v_inp_subcategory   IN VARCHAR2 DEFAULT NULL,
    v_inp_company_id    IN VARCHAR2 DEFAULT NULL
  ) RETURN CLOB;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       产能配置-供应商产品子类占比配置表数据生成
          
     入参:
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码 
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_company_id           :  企业Id
       v_inp_operate_userid       :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_generate_mode        :  生成模式 IU-增改 I-增
            
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置表数据生成
          
  ==============================================================================*/
  PROCEDURE p_gen_capc_sup_subcate_rate_cfg_data
  (
    v_inp_supplier_code  IN VARCHAR2 DEFAULT NULL,
    v_inp_category       IN VARCHAR2 DEFAULT NULL,
    v_inp_product_cate   IN VARCHAR2 DEFAULT NULL,
    v_inp_subcategory    IN VARCHAR2 DEFAULT NULL,
    v_inp_company_id     IN VARCHAR2 DEFAULT NULL,
    v_inp_operate_userid IN VARCHAR2,
    v_inp_operate_time   IN DATE,
    v_inp_generate_mode  IN VARCHAR2
  );

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       供应商周产能规划(件数)基表新增
        
     入参:
       v_inp_cwpnb_id                       :  供应商周产能规划(件数)基表Id
       v_inp_company_id                     :  企业Id
       v_inp_supplier_code                  :  供应商编码
       v_inp_factory_code                   :  生产工厂编码
       v_inp_category                       :  分类编码
       v_inp_product_cate                   :  生产分类编码
       v_inp_subcategory                    :  产品子类编码
       v_inp_calculate_day                  :  计算日期
       v_inp_sfcpallocate_percentage        :  供应商-生产工厂-分类-生产分类分配占比
       v_inp_scpsallocate_percentage        :  供应商-分类-生产分类-产品子类分配占比
       v_inp_capacity_ceiling_t             :  产能上限(工时)
       v_inp_capacity_appointment_t         :  约定产能(工时)
       v_inp_capacity_ceiling_p             :  产能上限(件数)
       v_inp_capacity_appointment_p         :  约定产能(件数)
       v_inp_sfcps_allocapcp_ceiling_t      :  产品子类比例分配后产能上限(工时)
       v_inp_sfcps_allocapcp_appointment_t  :  生产分类比例分配后约定产能(工时)
       v_inp_sfcps_allocapcp_ceiling_p      :  产品子类比例分配后产能上限(件数)
       v_inp_sfcps_allocapcp_appointment_p  :  产品子类比例分配后约定产能(件数)
       v_inp_invoke_object                  :  调用对象
          
     版本:
       2023-05-11_zc314 : 供应商周产能规划(件数)基表新增
        
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capacity_weekplan_numpieces_base
  (
    v_inp_cwpnb_id                      IN scmdata.t_capacity_weekplan_numpieces_base.cwpnb_id%TYPE DEFAULT NULL,
    v_inp_company_id                    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL,
    v_inp_supplier_code                 IN scmdata.t_capacity_weekplan_numpieces_base.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code                  IN scmdata.t_capacity_weekplan_numpieces_base.factory_code%TYPE DEFAULT NULL,
    v_inp_category                      IN scmdata.t_capacity_weekplan_numpieces_base.category%TYPE DEFAULT NULL,
    v_inp_product_cate                  IN scmdata.t_capacity_weekplan_numpieces_base.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory                   IN scmdata.t_capacity_weekplan_numpieces_base.subcategory%TYPE DEFAULT NULL,
    v_inp_calculate_day                 IN scmdata.t_capacity_weekplan_numpieces_base.calculate_day%TYPE DEFAULT NULL,
    v_inp_sfcpallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.sfcpallocate_percentage%TYPE DEFAULT NULL,
    v_inp_scpsallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.scpsallocate_percentage%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_t     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_t IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_p     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_p%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_p IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_p%TYPE DEFAULT NULL,
    v_inp_invoke_object                 IN VARCHAR2
  );

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       根据主键执行供应商周产能规划(件数)基表修改
          
     入参:
       v_inp_cwpnb_id                       :  供应商周产能规划(件数)基表Id
       v_inp_company_id                     :  企业Id
       v_inp_sfcpallocate_percentage        :  供应商-生产工厂-分类-生产分类分配占比
       v_inp_scpsallocate_percentage        :  供应商-分类-生产分类-产品子类分配占比
       v_inp_sfcps_allocapcp_ceiling_t      :  产品子类比例分配后产能上限(工时)
       v_inp_sfcps_allocapcp_appointment_t  :  产品子类比例分配后约定产能(工时)
       v_inp_sfcps_allocapcp_ceiling_p      :  产品子类比例分配后产能上限(件数)
       v_inp_sfcps_allocapcp_appointment_p  :  产品子类比例分配后约定产能(件数)
       v_inp_invoke_object                  :  调用对象
            
     版本:
       2023-05-11_zc314 : 根据主键执行供应商周产能规划(件数)基表修改
          
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capacity_weekplan_numpieces_base_by_pk
  (
    v_inp_cwpnb_id                      IN scmdata.t_capacity_weekplan_numpieces_base.cwpnb_id%TYPE DEFAULT NULL,
    v_inp_company_id                    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL,
    v_inp_sfcpallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.sfcpallocate_percentage%TYPE DEFAULT NULL,
    v_inp_scpsallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.scpsallocate_percentage%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_t     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_t IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_p     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_p%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_p IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_p%TYPE DEFAULT NULL,
    v_inp_invoke_object                 IN VARCHAR2
  );

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       根据唯一键执行供应商周产能规划(件数)基表修改
          
     入参:
       v_inp_supplier_code                  :  供应商编码
       v_inp_factory_code                   :  生产工厂编码
       v_inp_category                       :  分类编码
       v_inp_product_cate                   :  生产分类编码
       v_inp_subcategory                    :  产品子类编码
       v_inp_calculate_day                  :  计算日期
       v_inp_company_id                     :  企业Id
       v_inp_sfcpallocate_percentage        :  供应商-生产工厂-分类-生产分类分配占比
       v_inp_scpsallocate_percentage        :  供应商-分类-生产分类-产品子类分配占比
       v_inp_sfcps_allocapcp_ceiling_t      :  产品子类比例分配后产能上限(工时)
       v_inp_sfcps_allocapcp_appointment_t  :  产品子类比例分配后约定产能(工时)
       v_inp_sfcps_allocapcp_ceiling_p      :  产品子类比例分配后产能上限(件数)
       v_inp_sfcps_allocapcp_appointment_p  :  产品子类比例分配后约定产能(件数)
       v_inp_invoke_object                  :  调用对象
            
     版本:
       2023-05-11_zc314 : 根据唯一键执行供应商周产能规划(件数)基表修改
          
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capacity_weekplan_numpieces_base_by_uk
  (
    v_inp_supplier_code                 IN scmdata.t_capacity_weekplan_numpieces_base.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code                  IN scmdata.t_capacity_weekplan_numpieces_base.factory_code%TYPE DEFAULT NULL,
    v_inp_category                      IN scmdata.t_capacity_weekplan_numpieces_base.category%TYPE DEFAULT NULL,
    v_inp_product_cate                  IN scmdata.t_capacity_weekplan_numpieces_base.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory                   IN scmdata.t_capacity_weekplan_numpieces_base.subcategory%TYPE DEFAULT NULL,
    v_inp_calculate_day                 IN scmdata.t_capacity_weekplan_numpieces_base.calculate_day%TYPE DEFAULT NULL,
    v_inp_company_id                    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL,
    v_inp_sfcpallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.sfcpallocate_percentage%TYPE DEFAULT NULL,
    v_inp_scpsallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.scpsallocate_percentage%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_t     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_t IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_p     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_p%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_p IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_p%TYPE DEFAULT NULL,
    v_inp_invoke_object                 IN VARCHAR2
  );

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     函数名:
       根据主键判断供应商周产能规划(件数)基表是否存在
        
     入参:
       v_inp_cwpnb_id    :  供应商周产能规划(件数)基表Id
       v_inp_company_id  :  企业Id
          
     版本:
       2023-05-09_zc314 : 根据主键判断供应商周产能规划(件数)基表是否存在
        
  ==============================================================================*/
  FUNCTION f_tabapi_is_capacity_weekplan_numpieces_base_exists_by_pk
  (
    v_inp_cwpnb_id   IN scmdata.t_capacity_weekplan_numpieces_base.cwpnb_id%TYPE DEFAULT NULL,
    v_inp_company_id IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL
  ) RETURN NUMBER;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       根据唯一键判断供应商周产能规划(件数)基表是否存在 
        
     入参:
       v_inp_supplier_code  :  供应商编码
       v_inp_factory_code   :  生产工厂编码
       v_inp_category       :  分类编码
       v_inp_product_cate   :  生产分类编码
       v_inp_subcategory    :  产品子类编码 
       v_inp_calculate_day  :  计算日期
       v_inp_company_id     :  企业Id
          
     版本:
       2023-05-09_zc314 : 根据唯一键判断供应商周产能规划(件数)基表是否存在 
        
  ==============================================================================*/
  FUNCTION f_tabapi_is_capacity_weekplan_numpieces_base_exists_by_uk
  (
    v_inp_supplier_code IN scmdata.t_capacity_weekplan_numpieces_base.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code  IN scmdata.t_capacity_weekplan_numpieces_base.factory_code%TYPE DEFAULT NULL,
    v_inp_category      IN scmdata.t_capacity_weekplan_numpieces_base.category%TYPE DEFAULT NULL,
    v_inp_product_cate  IN scmdata.t_capacity_weekplan_numpieces_base.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory   IN scmdata.t_capacity_weekplan_numpieces_base.subcategory%TYPE DEFAULT NULL,
    v_inp_calculate_day IN scmdata.t_capacity_weekplan_numpieces_base.calculate_day%TYPE DEFAULT NULL,
    v_inp_company_id    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL
  ) RETURN NUMBER;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       供应商周产能规划(件数)基表新增/修改
        
     入参:
       v_inp_cwpnb_id                       :  供应商周产能规划(件数)基表Id
       v_inp_company_id                     :  企业Id
       v_inp_supplier_code                  :  供应商编码
       v_inp_factory_code                   :  生产工厂编码
       v_inp_category                       :  分类编码
       v_inp_product_cate                   :  生产分类编码
       v_inp_subcategory                    :  产品子类编码
       v_inp_calculate_day                  :  计算日期
       v_inp_sfcpallocate_percentage        :  供应商-生产工厂-分类-生产分类分配占比
       v_inp_scpsallocate_percentage        :  供应商-分类-生产分类-产品子类分配占比
       v_inp_sfcp_allocapc_ceiling_t        :  产品子类比例分配后产能上限(工时)
       v_inp_sfcp_allocapcp_appointment_t   :  产品子类比例分配后约定产能(工时)
       v_inp_sfcps_allocapcp_ceiling_p      :  产品子类比例分配后产能上限(件数)
       v_inp_sfcps_allocapcp_appointment_p  :  产品子类比例分配后约定产能(件数)
          
     版本:
       2023-05-11_zc314 : 供应商周产能规划(件数)基表新增/修改
        
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capacity_weekplan_numpieces_base
  (
    v_inp_cwpnb_id                      IN scmdata.t_capacity_weekplan_numpieces_base.cwpnb_id%TYPE DEFAULT NULL,
    v_inp_company_id                    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE,
    v_inp_supplier_code                 IN scmdata.t_capacity_weekplan_numpieces_base.supplier_code%TYPE,
    v_inp_factory_code                  IN scmdata.t_capacity_weekplan_numpieces_base.factory_code%TYPE,
    v_inp_category                      IN scmdata.t_capacity_weekplan_numpieces_base.category%TYPE,
    v_inp_product_cate                  IN scmdata.t_capacity_weekplan_numpieces_base.product_cate%TYPE,
    v_inp_subcategory                   IN scmdata.t_capacity_weekplan_numpieces_base.subcategory%TYPE,
    v_inp_calculate_day                 IN scmdata.t_capacity_weekplan_numpieces_base.calculate_day%TYPE,
    v_inp_sfcpallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.sfcpallocate_percentage%TYPE DEFAULT NULL,
    v_inp_scpsallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.scpsallocate_percentage%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_t     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_t IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_p     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_p%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_p IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_p%TYPE DEFAULT NULL
  );

END pkg_capacity_management;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_capacity_management IS

  /*=======================================================================
  
    获取品类合作供应商主表启停状态
  
    用途:
      获取品类合作供应商主表启停状态
  
    入参:
      V_SUPCODE :  供应商编码
      V_CATE    :  分类
      V_PROCATE :  生产分类
      V_SUBCATE :  子类
      V_COMPID  :  企业Id
  
    版本:
      2022-04-06 : 对工厂非合作范围数据进行校验，停用，并且不展示处理
      2022-05-10 : 对合作工厂启停状态修正
  
  =======================================================================*/
  --need
  FUNCTION f_get_supcsp_pause
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER IS
    v_retnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_retnum
      FROM scmdata.t_supplier_info a
     INNER JOIN scmdata.t_coop_scope b
        ON a.supplier_info_id = b.supplier_info_id
       AND a.company_id = b.company_id
     WHERE a.supplier_code = v_supcode
       AND b.coop_classification = v_cate
       AND b.coop_product_cate = v_procate
       AND instr(b.coop_subcategory, v_subcate) > 0
       AND a.company_id = v_compid
       AND a.pause IN (0, 2)
       AND nvl(a.product_type, '00') = '00'
       AND b.pause = 0
       AND a.status = 1;
  
    v_retnum := nvl(v_retnum, 0);
  
    IF v_retnum = 0 THEN
      v_retnum := 1;
    ELSE
      v_retnum := 0;
    END IF;
  
    RETURN v_retnum;
  END f_get_supcsp_pause;

  /*=======================================================================
  
    【已测通】对工厂非合作范围数据校验，停用，不展示
  
    用途:
      用于对工厂非合作范围数据进行校验，停用，并且不展示处理
  
    入参:
      V_SUPCODE :  供应商编码
      V_FACCODE :  生产工厂编码
      V_COMPID  :  企业Id
  
    版本:
      2022-04-06 : 对工厂非合作范围数据进行校验，停用，并且不展示处理
      2022-05-10 : 对合作工厂启停状态修正
  
  =======================================================================*/
  PROCEDURE p_csn_coopfaccfg
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    FOR i IN (SELECT a.coop_category,
                     a.coop_productcate,
                     a.coop_subcategory,
                     b.cfc_id,
                     b.company_id
                FROM scmdata.t_coopcate_supplier_cfg a
               INNER JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND b.factory_code = v_faccode
                    --AND B.PAUSE = 0
                 AND a.company_id = v_compid) LOOP
      SELECT nvl(MAX(1), 0)
        INTO v_jugnum
        FROM scmdata.t_coop_scope
       WHERE (supplier_info_id, company_id) IN
             (SELECT supplier_info_id,
                     company_id
                FROM scmdata.t_supplier_info
               WHERE supplier_code = v_faccode
                 AND company_id = v_compid
                 AND pause IN (0, 2)
                 AND nvl(product_type, '00') = '00')
         AND coop_classification = i.coop_category
         AND coop_product_cate = i.coop_productcate
         AND instr(coop_subcategory, i.coop_subcategory) > 0
         AND pause = 0;
    
      v_jugnum := nvl(v_jugnum, 0);
    
      IF v_jugnum = 0 THEN
        v_jugnum := 1;
      ELSE
        v_jugnum := 0;
      END IF;
    
      UPDATE scmdata.t_coopcate_factory_cfg
         SET pause   = v_jugnum,
             is_show = v_jugnum
       WHERE cfc_id = i.cfc_id
         AND company_id = i.company_id;
    END LOOP;
  END p_csn_coopfaccfg;

  /*=======================================================================
  
    【已测通】品类合作供应商新增数据
  
    用途:
      用于生成品类合作供应商数据
  
    用于:
      供应商开工通用配置
  
    入参:
      V_SUPCODE :  供应商编码
      V_COMPID  :  企业Id
      V_CURID   :  当前操作人Id
  
    版本:
      2021-11-23 : 用于生成品类合作供应商数据
  
  =======================================================================*/
  --need
  PROCEDURE p_ins_catecoopsup_data
  (
    v_supcode IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_curid   IN VARCHAR2,
    v_mode    IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc rctype;
    /*V_JUGNUM    NUMBER(1);*/
    v_cond     VARCHAR2(512);
    v_exesql   VARCHAR2(2000);
    rc_supcode VARCHAR2(32);
    rc_faccode VARCHAR2(32);
    rc_compid  VARCHAR2(32);
    v_cscid    VARCHAR2(32);
    v_cfcid    VARCHAR2(32);
    v_suppause NUMBER(1);
    v_facpause NUMBER(1);
  BEGIN
    IF v_mode = 'SUP' THEN
      v_cond := ' WHERE A.SUPPLIER_CODE = ''' || v_supcode ||
                ''' AND A.COMPANY_ID = ''' || v_compid || '''';
    ELSE
      v_cond := ' WHERE B.FACTORY_CODE = ''' || v_supcode ||
                ''' AND A.COMPANY_ID = ''' || v_compid || '''';
    END IF;
  
    v_exesql := 'SELECT A.SUPPLIER_CODE SUPCODE,
                          C.SUPPLIER_CODE FACCODE,
                          A.COMPANY_ID    COMPID
                     FROM SCMDATA.T_SUPPLIER_INFO A
                    INNER JOIN SCMDATA.T_COOP_FACTORY B
                       ON A.SUPPLIER_INFO_ID = B.SUPPLIER_INFO_ID
                      AND A.COMPANY_ID = B.COMPANY_ID
                    INNER JOIN SCMDATA.T_SUPPLIER_INFO C
                       ON B.FAC_SUP_INFO_ID = C.SUPPLIER_INFO_ID
                      AND B.COMPANY_ID = C.COMPANY_ID' ||
                v_cond;
  
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO rc_supcode,
             rc_faccode,
             rc_compid;
      EXIT WHEN rc%NOTFOUND;
      FOR i IN (SELECT supplier_code supcode,
                       company_id    compid,
                       cate,
                       procate,
                       subcate
                  FROM (SELECT a.supplier_code,
                               a.company_id,
                               b.cate,
                               b.procate,
                               (regexp_substr(subcate, '[^;]+', 1, LEVEL)) subcate
                          FROM (SELECT supplier_info_id,
                                       company_id,
                                       supplier_code
                                  FROM scmdata.t_supplier_info
                                 WHERE supplier_code = rc_supcode
                                   AND pause IN (0, 2)
                                   AND company_id = rc_compid) a
                         INNER JOIN (SELECT supplier_info_id,
                                           company_id,
                                           coop_mode,
                                           coop_classification cate,
                                           coop_product_cate   procate,
                                           coop_subcategory    subcate
                                      FROM scmdata.t_coop_scope
                                     WHERE pause IN (0, 2)) b
                            ON a.supplier_info_id = b.supplier_info_id
                           AND a.company_id = b.company_id
                        CONNECT BY LEVEL <= regexp_count(subcate, '\;') + 1)) LOOP
        SELECT MAX(tsi.pause)
          INTO v_facpause
          FROM scmdata.t_supplier_info tsi
         INNER JOIN scmdata.t_coop_scope tcs
            ON tsi.supplier_info_id = tcs.supplier_info_id
           AND tsi.company_id = tcs.company_id
         WHERE tcs.coop_classification = i.cate
           AND tcs.coop_product_cate = i.procate
           AND instr(tcs.coop_subcategory, i.subcate) > 0
           AND tsi.supplier_code = rc_faccode
           AND tcs.company_id = i.compid
           AND rownum = 1;
      
        IF v_facpause IS NOT NULL THEN
          SELECT MAX(csc_id)
            INTO v_cscid
            FROM scmdata.t_coopcate_supplier_cfg
           WHERE supplier_code = i.supcode
             AND coop_category = i.cate
             AND coop_productcate = i.procate
             AND coop_subcategory = i.subcate
             AND company_id = i.compid;
        
          v_suppause := f_get_supcsp_pause(v_supcode => i.supcode,
                                           v_cate    => i.cate,
                                           v_procate => i.procate,
                                           v_subcate => i.subcate,
                                           v_compid  => i.compid);
        
          IF v_cscid IS NULL THEN
            v_cscid := scmdata.f_get_uuid();
            INSERT INTO scmdata.t_coopcate_supplier_cfg
              (csc_id, company_id, supplier_code, coop_category, coop_productcate, coop_subcategory, pause, create_id, create_time)
            VALUES
              (v_cscid, i.compid, i.supcode, i.cate, i.procate, i.subcate, v_suppause, v_curid, SYSDATE);
          ELSE
            UPDATE scmdata.t_coopcate_supplier_cfg
               SET pause = v_suppause
             WHERE supplier_code = i.supcode
               AND coop_category = i.cate
               AND coop_productcate = i.procate
               AND coop_subcategory = i.subcate
               AND company_id = i.compid;
          END IF;
        
          SELECT MAX(cfc_id)
            INTO v_cfcid
            FROM scmdata.t_coopcate_factory_cfg
           WHERE csc_id = v_cscid
             AND factory_code = rc_faccode
             AND company_id = i.compid;
        
          IF v_cfcid IS NULL THEN
            INSERT INTO scmdata.t_coopcate_factory_cfg
              (cfc_id, company_id, csc_id, factory_code, pause, is_show, create_id, create_time)
            VALUES
              (scmdata.f_get_uuid(), i.compid, v_cscid, rc_faccode, v_facpause, v_facpause, v_curid, SYSDATE);
          ELSE
            UPDATE scmdata.t_coopcate_factory_cfg
               SET pause   = v_facpause,
                   is_show = v_facpause
             WHERE csc_id = v_cscid
               AND factory_code = rc_faccode
               AND company_id = i.compid;
          END IF;
        END IF;
      END LOOP;
    END LOOP;
    CLOSE rc;
  END p_ins_catecoopsup_data;

  /*=======================================================================
  
    根据供应商编码，生产工厂编码生成品类合作供应商数据
  
    用途:
      根据供应商编码，生产工厂编码生成品类合作供应商数据
  
    入参:
      V_SUPCODE :  供应商编码
      V_FACCODE :  生产工厂编码
      V_CURID   :  当前操作人Id
      V_COMPID  :  企业Id
  
    版本:
      2022-04-06 : 对工厂非合作范围数据进行校验，停用，并且不展示处理
  
  =======================================================================*/
  --need
  PROCEDURE p_ins_catecoopsup_data_bysf
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_curid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_jugnum   NUMBER(1);
    v_cscid    VARCHAR2(32);
    v_cfcid    VARCHAR2(32);
    v_suppause NUMBER(1);
  BEGIN
    FOR i IN (SELECT DISTINCT supplier_code supcode,
                              company_id    compid,
                              cate,
                              procate,
                              subcate
                FROM (SELECT a.supplier_code,
                             a.company_id,
                             b.cate,
                             b.procate,
                             (regexp_substr(subcate, '[^;]+', 1, LEVEL)) subcate
                        FROM (SELECT supplier_info_id,
                                     company_id,
                                     supplier_code
                                FROM scmdata.t_supplier_info
                               WHERE supplier_code = v_supcode
                                 AND pause IN (0, 2)
                                 AND company_id = v_compid) a
                       INNER JOIN (SELECT supplier_info_id,
                                         company_id,
                                         coop_mode,
                                         coop_classification cate,
                                         coop_product_cate   procate,
                                         coop_subcategory    subcate
                                    FROM scmdata.t_coop_scope
                                   WHERE pause IN (0, 2)) b
                          ON a.supplier_info_id = b.supplier_info_id
                         AND a.company_id = b.company_id
                      CONNECT BY LEVEL <= regexp_count(subcate, '\;') + 1)) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supplier_info tsi
       INNER JOIN scmdata.t_coop_scope tcs
          ON tsi.supplier_info_id = tcs.supplier_info_id
         AND tsi.company_id = tcs.company_id
       WHERE tcs.coop_classification = i.cate
         AND tcs.coop_product_cate = i.procate
         AND instr(tcs.coop_subcategory, i.subcate) > 0
         AND tsi.supplier_code = v_faccode
         AND tcs.company_id = i.compid
         AND rownum = 1;
    
      IF v_jugnum > 0 THEN
        SELECT MAX(csc_id)
          INTO v_cscid
          FROM scmdata.t_coopcate_supplier_cfg
         WHERE supplier_code = i.supcode
           AND coop_category = i.cate
           AND coop_productcate = i.procate
           AND coop_subcategory = i.subcate
           AND company_id = i.compid;
      
        v_suppause := f_get_supcsp_pause(v_supcode => i.supcode,
                                         v_cate    => i.cate,
                                         v_procate => i.procate,
                                         v_subcate => i.subcate,
                                         v_compid  => i.compid);
      
        IF v_cscid IS NULL THEN
          v_cscid := scmdata.f_get_uuid();
          INSERT INTO scmdata.t_coopcate_supplier_cfg
            (csc_id, company_id, supplier_code, coop_category, coop_productcate, coop_subcategory, pause, create_id, create_time)
          VALUES
            (v_cscid, i.compid, i.supcode, i.cate, i.procate, i.subcate, v_suppause, v_curid, SYSDATE);
        ELSE
          UPDATE scmdata.t_coopcate_supplier_cfg
             SET pause = v_suppause
           WHERE csc_id = v_cscid
             AND company_id = i.compid;
        END IF;
      
        scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => v_curid,
                                                      v_compid    => v_compid,
                                                      v_tab       => 'SCMDATA.T_COOPCATE_SUPPLIER_CFG',
                                                      v_unqfields => 'CSC_ID,COMPANY_ID',
                                                      v_ckfields  => 'PAUSE,CREATE_ID,CREATE_TIME',
                                                      v_conds     => 'CSC_ID = ''' ||
                                                                     v_cscid ||
                                                                     ''' AND COMPANY_ID = ''' ||
                                                                     v_compid || '''',
                                                      v_method    => 'INS',
                                                      v_viewlogic => NULL,
                                                      v_queuetype => 'CAPC_COOPSUP_PAUSE_I');
      
        SELECT MAX(cfc_id)
          INTO v_cfcid
          FROM scmdata.t_coopcate_factory_cfg
         WHERE csc_id = v_cscid
           AND factory_code = v_faccode
           AND company_id = i.compid;
      
        IF v_cfcid IS NULL THEN
          INSERT INTO scmdata.t_coopcate_factory_cfg
            (cfc_id, company_id, csc_id, factory_code, pause, create_id, create_time)
          VALUES
            (scmdata.f_get_uuid(), i.compid, v_cscid, v_faccode, 0, v_curid, SYSDATE);
        ELSE
          UPDATE scmdata.t_coopcate_factory_cfg
             SET pause   = 0,
                 is_show = 0
           WHERE csc_id = v_cscid
             AND factory_code = v_faccode
             AND company_id = i.compid;
        END IF;
      
        p_csn_coopfaccfg(v_supcode => i.supcode,
                         v_faccode => v_faccode,
                         v_compid  => i.compid);
      END IF;
    END LOOP;
  END p_ins_catecoopsup_data_bysf;

  /*=======================================================================
  
    根据供应商编码，分类-生产分类-子类生成品类合作供应商数据
  
    用途:
      根据供应商编码，分类-生产分类-子类生成品类合作供应商数据
  
    入参:
      V_SUPCODE :  供应商编码
      V_FACCODE :  生产工厂编码
      V_CURID   :  当前操作人Id
      V_COMPID  :  企业Id
  
    版本:
      2022-05-10 : 根据供应商编码，分类-生产分类-子类生成品类合作供应商数据
  
  =======================================================================*/
  --need
  PROCEDURE p_ins_catecoopsup_data_onlyscps
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_curid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_cscid       VARCHAR2(32);
    v_cfcid       VARCHAR2(32);
    v_pause       NUMBER(1);
    v_jugnum      NUMBER(1);
    v_scppause    NUMBER(1);
    v_suppause    NUMBER(1);
    v_tsiprodtype NUMBER(1);
  BEGIN
    --判断品类合作供应商主表是否存在数据
    SELECT MAX(csc_id)
      INTO v_cscid
      FROM scmdata.t_coopcate_supplier_cfg
     WHERE supplier_code = v_supcode
       AND coop_category = v_cate
       AND coop_productcate = v_procate
       AND coop_subcategory = v_subcate
       AND company_id = v_compid;
  
    --获取品类合作供应商及合作范围启用/禁用状态
    v_suppause := f_get_supcsp_pause(v_supcode => v_supcode,
                                     v_cate    => v_cate,
                                     v_procate => v_procate,
                                     v_subcate => v_subcate,
                                     v_compid  => v_compid);
  
    IF v_cscid IS NULL THEN
      v_cscid := scmdata.f_get_uuid();
      --如果不存在数据
      INSERT INTO scmdata.t_coopcate_supplier_cfg
        (csc_id, company_id, supplier_code, coop_category, coop_productcate, coop_subcategory, pause, create_id, create_time)
      VALUES
        (v_cscid, v_compid, v_supcode, v_cate, v_procate, v_subcate, v_suppause, v_curid, SYSDATE);
    ELSE
      UPDATE scmdata.t_coopcate_supplier_cfg
         SET pause = v_suppause
       WHERE supplier_code = v_supcode
         AND coop_category = v_cate
         AND coop_productcate = v_procate
         AND coop_subcategory = v_subcate
         AND company_id = v_compid;
    END IF;
  
    scmdata.pkg_capacity_inqueue.p_common_inqueue(v_curuserid => v_curid,
                                                  v_compid    => v_compid,
                                                  v_tab       => 'SCMDATA.T_COOPCATE_SUPPLIER_CFG',
                                                  v_unqfields => 'CSC_ID,COMPANY_ID',
                                                  v_ckfields  => 'PAUSE,CREATE_ID,CREATE_TIME',
                                                  v_conds     => 'CSC_ID = ''' ||
                                                                 v_cscid ||
                                                                 ''' AND COMPANY_ID = ''' ||
                                                                 v_compid || '''',
                                                  v_method    => 'INS',
                                                  v_viewlogic => NULL,
                                                  v_queuetype => 'CAPC_COOPSUP_PAUSE_I');
  
    SELECT MAX(csc_id)
      INTO v_cscid
      FROM scmdata.t_coopcate_supplier_cfg
     WHERE supplier_code = v_supcode
       AND coop_category = v_cate
       AND coop_productcate = v_procate
       AND coop_subcategory = v_subcate
       AND company_id = v_compid;
  
    --通过供应商档案关联选出对应生产工厂
    FOR i IN (SELECT DISTINCT a.supplier_code,
                              b.factory_code,
                              a.company_id,
                              nvl(b.pause, 1) facpause,
                              decode(nvl(a.pause, 1), 2, 0, nvl(a.pause, 1)) suppause
                FROM scmdata.t_supplier_info a
               INNER JOIN scmdata.t_coop_factory b
                  ON a.supplier_info_id = b.supplier_info_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND a.company_id = v_compid
                 AND b.factory_code IS NOT NULL) LOOP
      SELECT nvl(MAX(1), 1),
             nvl(MAX(tcs.pause), 1),
             MAX(CASE
                   WHEN nvl(tsi.product_type, '00') = '00' THEN
                    0
                   ELSE
                    1
                 END)
        INTO v_jugnum,
             v_scppause,
             v_tsiprodtype
        FROM scmdata.t_supplier_info tsi
       INNER JOIN scmdata.t_coop_scope tcs
          ON tsi.supplier_info_id = tcs.supplier_info_id
         AND tsi.company_id = tcs.company_id
       WHERE tsi.supplier_code = i.factory_code
         AND tsi.company_id = i.company_id
         AND tcs.coop_classification = v_cate
         AND tcs.coop_product_cate = v_procate
         AND instr(tcs.coop_subcategory, v_subcate) > 0;
    
      v_pause := sign(i.suppause + i.facpause + v_scppause);
    
      IF v_jugnum = 1
         AND v_tsiprodtype = 0 THEN
        SELECT MAX(cfc_id)
          INTO v_cfcid
          FROM scmdata.t_coopcate_factory_cfg
         WHERE csc_id = v_cscid
           AND factory_code = i.factory_code
           AND company_id = i.company_id;
      
        IF v_cfcid IS NULL THEN
          INSERT INTO scmdata.t_coopcate_factory_cfg
            (cfc_id, company_id, csc_id, factory_code, pause, is_show, create_id, create_time)
          VALUES
            (scmdata.f_get_uuid(), i.company_id, v_cscid, i.factory_code, v_pause, v_pause, v_curid, SYSDATE);
        ELSE
          UPDATE scmdata.t_coopcate_factory_cfg
             SET pause   = v_pause,
                 is_show = v_pause
           WHERE csc_id = v_cscid
             AND factory_code = i.factory_code
             AND company_id = i.company_id;
        END IF;
      END IF;
    END LOOP;
  END p_ins_catecoopsup_data_onlyscps;

  /*=====================================================================================
  
    获取单条配置中所有年不开工日期
  
    用途:
     获取单条配置中所有年不开工日期
  
    用于:
      供应商开工通用配置
  
    入参:
      V_SSWCID  :  供应商不开工配置Id
      V_COMPID  :  企业Id
  
    返回值:
      SCMDATA.T_DAY_DIM.DD_ID的集合，多值以分号分隔
  
    版本:
      2021-11-18 : 获取单条配置中所有年不开工日期
  
  ======================================================================================*/
  --need
  FUNCTION f_get_cfgdatesids
  (
    v_sswcids IN CLOB,
    v_compid  IN VARCHAR2
  ) RETURN CLOB IS
    v_wknw   CLOB;
    v_mtnw   CLOB;
    v_tmpids CLOB;
    v_tarids CLOB;
  BEGIN
    FOR x IN (SELECT week_not_work,
                     month_not_work,
                     year_not_work,
                     YEAR
                FROM scmdata.t_supplier_start_work_cfg
               WHERE instr(';' || v_sswcids || ';', ';' || sswc_id || ';') > 0
                 AND company_id = v_compid) LOOP
      v_wknw := f_get_supnwcfg_weekdateids(v_year      => x.year,
                                           v_wkinfo    => x.week_not_work,
                                           v_sepsymbol => ';');
    
      v_mtnw := f_get_supnwcfg_monthdateids(v_year      => x.year,
                                            v_mtinfo    => x.month_not_work,
                                            v_sepsymbol => ';');
    
      v_tmpids := f_get_unq_data(v_data      => v_wknw || ';' || v_mtnw || ';' ||
                                                x.year_not_work,
                                 v_sepsymbol => ';');
    
      IF v_tmpids IS NULL THEN
        v_tarids := v_tmpids;
      ELSE
        v_tarids := v_tarids || ';' || v_tmpids;
      END IF;
    END LOOP;
  
    RETURN v_tarids;
  END f_get_cfgdatesids;

  /*=====================================================================================
  
    多值去重
  
    用途:
     用于去除单个字符串中的重复值
  
    用于:
      供应商开工通用配置
  
    入参:
      V_DATA       :  重复值数据
      V_SEPSYMBOL  :  分隔符
  
    返回值:
      去重后的字符串
  
    版本:
      2021-11-18 : 用于去除单个字符串中的重复值
  
  ======================================================================================*/
  --need
  FUNCTION f_get_unq_data
  (
    v_data      IN CLOB,
    v_sepsymbol IN VARCHAR2
  ) RETURN CLOB IS
    v_retclob CLOB;
  BEGIN
    FOR i IN (SELECT regexp_substr(v_data,
                                   '[^' || v_sepsymbol || ']+',
                                   1,
                                   LEVEL) col
                FROM dual
              CONNECT BY LEVEL <=
                         regexp_count(v_data, '\' || v_sepsymbol) + 1) LOOP
      IF instr(v_sepsymbol || nvl(v_retclob, ' ') || v_sepsymbol,
               v_sepsymbol || i.col || v_sepsymbol) = 0 THEN
        v_retclob := v_retclob || v_sepsymbol || i.col;
      END IF;
    END LOOP;
    RETURN ltrim(v_retclob, v_sepsymbol);
  END f_get_unq_data;

  /*===================================================================================
  
    获取周次补正值
  
    用途:
      用于获取当前日期周次补正值，如果某年1月1日是周一，则周次补正值为0，否则为1
  
    用于:
      供应商开工通用配置
  
    入参:
      V_DATE  :  日期
  
    返回值:
      周次补正值，数字类型
  
    版本:
      2021-11-16 : 用于获取当前日期周次补正值，
                   如果某年1月1日是周一，则周次补正值为0，否则为1
  
  ===================================================================================*/
  FUNCTION f_get_weekaddnum(v_date IN DATE) RETURN NUMBER IS
    v_yearfirstday DATE := to_date(to_char(v_date, 'YYYY') || '-01-01',
                                   'YYYY-MM-DD');
    v_weekord      NUMBER(1);
    v_retnum       NUMBER(1) := 0;
  BEGIN
    SELECT decode(to_char(v_yearfirstday, 'D') - 1,
                  0,
                  7,
                  to_char(v_yearfirstday, 'D') - 1)
      INTO v_weekord
      FROM dual;
    IF v_weekord > 1
       AND to_char(v_yearfirstday, 'IW') <> '01' THEN
      v_retnum := 1;
    END IF;
    RETURN v_retnum;
  END f_get_weekaddnum;

  /*===================================================================================
  
    获取年周次
  
    用途:
      用于获取某个日期的周次，已某年1月1日为第一周
  
    用于:
      供应商开工通用配置
  
    入参:
      V_DATE  :  日期
  
    返回值:
      年周次(YYWW)，数字类型
  
    版本:
      2021-11-16 : 用于获取某个日期的周次，以某年1月1日为第一周
  
  ===================================================================================*/
  FUNCTION f_get_weeknum(v_date IN DATE) RETURN NUMBER IS
    v_weekstyear NUMBER(4) := to_char(trunc(v_date, 'IW'), 'YYYY');
    v_weekedyear NUMBER(4) := to_char(trunc(v_date, 'IW') + 6, 'YYYY');
    v_weekaddnum NUMBER(6);
    v_retweeknum NUMBER(6);
  BEGIN
    IF v_weekstyear <> v_weekedyear THEN
      v_retweeknum := v_weekedyear * 100 + 1;
    ELSE
      v_weekaddnum := f_get_weekaddnum(v_date => v_date);
      v_retweeknum := v_weekedyear * 100 +
                      CAST(to_char(v_date, 'IW') AS NUMBER) + v_weekaddnum;
    END IF;
    RETURN v_retweeknum;
  END f_get_weeknum;

  /*=====================================================================================
  
    通过周不开工日期获取某年内符合配置的日期
  
    用途:
     通过周不开工日期获取某年内符合配置的日期
  
    用于:
      供应商开工通用配置
  
    入参:
      V_YEAR       :  年份
      V_WKINFO     :  周不开工日期
      V_SEPSYMBOL  :  分隔符
  
    返回值:
      SCMDATA.T_DAY_DIM.DD_ID的集合，多值以分号分隔
  
    版本:
      2021-11-18 : 通过周不开工日期获取某年内符合配置的日期
  
  ======================================================================================*/
  --need
  FUNCTION f_get_supnwcfg_weekdateids
  (
    v_year      IN NUMBER,
    v_wkinfo    IN VARCHAR2,
    v_sepsymbol IN VARCHAR2
  ) RETURN CLOB IS
    v_retclob CLOB;
  BEGIN
    FOR i IN (SELECT dd_id
                FROM scmdata.t_day_dim
               WHERE YEAR = v_year
                 AND instr(v_sepsymbol || v_wkinfo || v_sepsymbol,
                           v_sepsymbol || weekord || v_sepsymbol) > 0) LOOP
      v_retclob := v_retclob || v_sepsymbol || i.dd_id;
    END LOOP;
  
    RETURN ltrim(v_retclob, v_sepsymbol);
  END f_get_supnwcfg_weekdateids;

  /*=====================================================================================
  
    通过月不开工日期获取某年内符合配置的日期
  
    用途:
     通过周不开工日期获取某年内符合配置的日期
  
    用于:
      供应商开工通用配置
  
    入参:
      V_YEAR       :  年份
      V_WKINFO     :  月不开工日期
      V_SEPSYMBOL  :  分隔符
  
    返回值:
      SCMDATA.T_DAY_DIM.DD_ID的集合，多值以分隔符分隔
  
    版本:
      2021-11-18 : 通过月不开工日期获取某年内符合配置的日期
  
  ======================================================================================*/
  --need
  FUNCTION f_get_supnwcfg_monthdateids
  (
    v_year      IN NUMBER,
    v_mtinfo    IN VARCHAR2,
    v_sepsymbol IN VARCHAR2
  ) RETURN CLOB IS
    v_retclob CLOB;
  BEGIN
    FOR i IN (SELECT dd_id
                FROM scmdata.t_day_dim
               WHERE YEAR = v_year
                 AND instr(v_sepsymbol || v_mtinfo || v_sepsymbol,
                           v_sepsymbol || DAY || v_sepsymbol) > 0) LOOP
      v_retclob := v_retclob || v_sepsymbol || i.dd_id;
    END LOOP;
  
    RETURN ltrim(v_retclob, v_sepsymbol);
  END f_get_supnwcfg_monthdateids;

  /*===================================================================================
  
    获取分类-生产分类-子类名称
  
    用途:
      用于分类-生产分类-子类名称
  
    用于:
      生产周期配置
  
    入参:
      V_CATE      :  供应商编码
      V_PRODCATE  :  生产分类
      V_SUBCATE   :  子类
      V_COMPID    :  企业Id
  
    版本:
      2021-11-18 : 用于获取供应商名称
  
  ===================================================================================*/
  --need
  FUNCTION f_get_cps_name
  (
    v_cate     IN VARCHAR2,
    v_prodcate IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_tmpval VARCHAR2(512);
    v_retval VARCHAR2(512);
  BEGIN
    SELECT MAX(group_dict_name)
      INTO v_tmpval
      FROM scmdata.sys_group_dict
     WHERE group_dict_value = v_cate
       AND group_dict_type = 'PRODUCT_TYPE';
  
    v_retval := v_tmpval;
  
    SELECT MAX(group_dict_name)
      INTO v_tmpval
      FROM scmdata.sys_group_dict
     WHERE group_dict_value = v_prodcate
       AND group_dict_type = v_cate;
  
    v_retval := v_retval || '-' || v_tmpval;
  
    SELECT MAX(company_dict_name)
      INTO v_tmpval
      FROM scmdata.sys_company_dict
     WHERE company_dict_value = v_subcate
       AND company_dict_type = v_prodcate
       AND company_id = v_compid;
  
    IF v_tmpval IS NOT NULL THEN
      v_retval := v_retval || '-' || v_tmpval;
    END IF;
  
    RETURN v_retval;
  END f_get_cps_name;

  /*===================================================================================
  
    【已测试】用于获取某工厂所在配置的不开工日期
  
    用途:
      用于获取某工厂所在配置的不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_SUPCODE  :  供应商编码
      V_BRAID    :  分部Id
      V_COMPID   :  企业Id
  
    版本:
      2021-11-30 : 用于获取某工厂所在配置的不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_get_notworkdays
  (
    v_supcode IN VARCHAR2,
    v_braid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN CLOB IS
    v_provid      VARCHAR2(32);
    v_cityid      VARCHAR2(32);
    v_counid      VARCHAR2(32);
    v_sswcids     CLOB;
    v_notworkdays CLOB;
  BEGIN
    SELECT MAX(company_province),
           MAX(company_city),
           MAX(company_county)
      INTO v_provid,
           v_cityid,
           v_counid
      FROM scmdata.t_supplier_info
     WHERE supplier_code = v_supcode
       AND company_id = v_compid;
  
    v_sswcids := f_get_notworkday_sswcid(v_supcode => v_supcode,
                                         v_provid  => v_provid,
                                         v_cityid  => v_cityid,
                                         v_counid  => v_counid,
                                         v_braid   => v_braid,
                                         v_compid  => v_compid);
  
    IF v_sswcids IS NOT NULL THEN
      v_notworkdays := f_get_cfgdatesids(v_sswcids => v_sswcids,
                                         v_compid  => v_compid);
    END IF;
  
    RETURN v_notworkdays;
  END f_get_notworkdays;

  /*===================================================================================
  
    【已测试】能否通过工厂编码获取某周不开工日期
  
    用途:
      用于判断能否通过工厂编码获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_SUPCODE  :  供应商编码
      V_PROVID   :  省Id
      V_CITYID   :  市Id
      V_CONTID   :  区Id
      V_BRAID    :  分部Id
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过工厂编码获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_get_notworkday_sswcid
  (
    v_supcode IN VARCHAR2,
    v_provid  IN VARCHAR2,
    v_cityid  IN VARCHAR2,
    v_counid  IN VARCHAR2,
    v_braid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_jugstr VARCHAR2(32);
  BEGIN
    v_jugstr := f_can_get_notwork_by_faccode(v_supcode => v_supcode,
                                             v_compid  => v_compid);
  
    IF v_jugstr IS NULL THEN
      v_jugstr := f_can_get_notwork_by_pcc(v_province => v_provid,
                                           v_city     => v_cityid,
                                           v_country  => v_counid,
                                           v_compid   => v_compid);
      IF v_jugstr IS NULL THEN
        v_jugstr := f_can_get_notwork_by_pccbra(v_province => v_provid,
                                                v_city     => v_cityid,
                                                v_country  => v_counid,
                                                v_braid    => v_braid,
                                                v_compid   => v_compid);
      
        IF v_jugstr IS NULL THEN
          v_jugstr := f_can_get_notwork_by_bra(v_braid  => v_braid,
                                               v_compid => v_compid);
        END IF;
      END IF;
    END IF;
  
    RETURN v_jugstr;
  END f_get_notworkday_sswcid;

  /*===================================================================================
  
    【已测试】能否通过工厂编码获取某周不开工日期
  
    用途:
      用于判断能否通过工厂编码获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_SUPCODE  :  供应商编码
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过工厂编码获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_can_get_notwork_by_faccode
  (
    v_supcode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_retinfo VARCHAR2(32);
  BEGIN
    SELECT MAX(sswc_id)
      INTO v_retinfo
      FROM scmdata.t_supplier_start_work_cfg
     WHERE factory_code = v_supcode
       AND company_id = v_compid
       AND province_id IS NULL
       AND city_id IS NULL
       AND country_id IS NULL
       AND bra_id IS NULL;
  
    RETURN v_retinfo;
  END f_can_get_notwork_by_faccode;

  /*===================================================================================
  
    【已测试】能否通过区域获取某周不开工日期
  
    用途:
      用于判断能否通过省市区获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_PROVINCE :  省编码
      V_CITY     :  市编码
      V_COUNTRY  :  区编码
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过省市区获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_can_get_notwork_by_pcc
  (
    v_province IN VARCHAR2,
    v_city     IN VARCHAR2,
    v_country  IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_retinfo VARCHAR2(32);
  BEGIN
    SELECT MAX(sswc_id)
      INTO v_retinfo
      FROM scmdata.t_supplier_start_work_cfg
     WHERE province_id = v_province
       AND city_id = v_city
       AND country_id = v_country
       AND company_id = v_compid
       AND bra_id IS NULL
       AND factory_code IS NULL;
  
    RETURN v_retinfo;
  END f_can_get_notwork_by_pcc;

  /*===================================================================================
  
    【已测试】能否通过区域+分部获取某周不开工日期
  
    用途:
      用于判断能否通过区域+分部获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_PROVINCE :  省编码
      V_CITY     :  市编码
      V_COUNTRY  :  区编码
      V_BRAID    :  分部Id
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过区域+分部获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_can_get_notwork_by_pccbra
  (
    v_province IN VARCHAR2,
    v_city     IN VARCHAR2,
    v_country  IN VARCHAR2,
    v_braid    IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_retinfo VARCHAR2(32);
  BEGIN
    SELECT MAX(sswc_id)
      INTO v_retinfo
      FROM scmdata.t_supplier_start_work_cfg
     WHERE bra_id = v_braid
       AND province_id = v_province
       AND city_id = v_city
       AND country_id = v_country
       AND company_id = v_compid
       AND factory_code IS NULL;
  
    RETURN v_retinfo;
  END f_can_get_notwork_by_pccbra;

  /*===================================================================================
  
    【已测试】能否通过分部获取某周不开工日期
  
    用途:
      用于能否通过分部获取某周不开工日期
  
    用于:
      供应商产能预约
  
    入参:
      V_BRAID    :  分部Id
      V_COMPID   :  企业Id
  
    返回值:
      NULL 说明没有符合条件的 SSWC_ID
      不为NULL 返回符合的 SSWC_ID
  
    版本:
      2021-11-30 : 用于判断能否通过工厂编码获取某周不开工日期
  
  ===================================================================================*/
  --need
  FUNCTION f_can_get_notwork_by_bra
  (
    v_braid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_retinfo VARCHAR2(32);
  BEGIN
    SELECT MAX(sswc_id)
      INTO v_retinfo
      FROM scmdata.t_supplier_start_work_cfg
     WHERE bra_id = v_braid
       AND company_id = v_compid
       AND province_id IS NULL
       AND city_id IS NULL
       AND country_id IS NULL
       AND factory_code IS NULL;
  
    RETURN v_retinfo;
  END f_can_get_notwork_by_bra;

  /*===================================================================================
  
    预计新品导入唯一性校验
  
    用途:
      预计新品导入唯一性校验，唯一返回 0，
  
    用于:
      预计新品导入
  
    入参:
      v_isdsupcode  :  内部供应商编码
      v_catename    :  分类名称
      v_pcname      :  生产分类名称
      v_scname      :  子类名称
      v_season      :  季节
      v_wave        :  波段
      v_preodate    :  预计下单日期
      v_preddate    :  预计订单交期
      v_piid        :  预计导入表id
      v_compid      :  企业id
  
    版本:
      2021-12-20 : 预计新品导入唯一性校验
      2022-09-27 : 预计新品导入增加预计下单日期，预计订单交期维度
  
  ===================================================================================*/
  FUNCTION f_check_coopsupipt_unq
  (
    v_isdsupcode IN VARCHAR2,
    v_catename   IN VARCHAR2,
    v_pcname     IN VARCHAR2,
    v_scname     IN VARCHAR2,
    v_seaname    IN VARCHAR2,
    v_wave       IN VARCHAR2,
    v_preodate   IN DATE,
    v_preddate   IN DATE,
    v_piid       IN VARCHAR2 DEFAULT NULL,
    v_importid   IN VARCHAR2,
    v_compid     IN VARCHAR2
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_piid IS NULL THEN
      SELECT nvl(MAX(1), 0)
        INTO v_jugnum
        FROM scmdata.t_plannew_import
       WHERE inside_supplier_code = v_isdsupcode
         AND category_name = v_catename
         AND productcate_name = v_pcname
         AND subcategory_name = v_scname
         AND season_name = v_seaname
         AND wave = v_wave
         AND predord_date = v_preodate
         AND preddelv_date = v_preddate
         AND import_id = v_importid
         AND company_id = v_compid;
    ELSE
      SELECT nvl(MAX(1), 0)
        INTO v_jugnum
        FROM scmdata.t_plannew_import
       WHERE inside_supplier_code = v_isdsupcode
         AND category_name = v_catename
         AND productcate_name = v_pcname
         AND subcategory_name = v_scname
         AND season_name = v_seaname
         AND wave = v_wave
         AND predord_date = v_preodate
         AND preddelv_date = v_preddate
         AND pi_id <> v_piid
         AND import_id = v_importid
         AND company_id = v_compid;
    END IF;
  
    RETURN v_jugnum;
  END f_check_coopsupipt_unq;

  /*===================================================================================
  
    根据分类，生产分类，产品子类名称获取分类，生产分类，子类的值
  
    用途:
      根据分类，生产分类，产品子类名称获取分类，生产分类，子类的值
  
    用于:
      预计新品导入
  
    入参:
      v_catename     :  分类名称
      v_procatename  :  生产分类名称
      v_subcatename  :  子类名称
      v_compid       :  企业id
      v_cate         :  分类
      v_procate      :  生产分类
      v_subcate      :  子类
  
    版本:
      2021-12-18 : 根据分类，生产分类，产品子类名称获取分类，生产分类，子类的值
  
  ===================================================================================*/
  PROCEDURE p_get_cpsvalue
  (
    v_catename    IN VARCHAR2,
    v_procatename IN VARCHAR2,
    v_subcatename IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_cate        IN OUT VARCHAR2,
    v_procate     IN OUT VARCHAR2,
    v_subcate     IN OUT VARCHAR2
  ) IS
  BEGIN
    SELECT MAX(group_dict_value)
      INTO v_cate
      FROM scmdata.sys_group_dict
     WHERE group_dict_type = 'PRODUCT_TYPE'
       AND group_dict_name = v_catename
       AND rownum = 1;
  
    SELECT MAX(group_dict_value)
      INTO v_procate
      FROM scmdata.sys_group_dict
     WHERE group_dict_type = v_cate
       AND group_dict_name = v_procatename
       AND rownum = 1;
  
    SELECT MAX(company_dict_value)
      INTO v_subcate
      FROM scmdata.sys_company_dict
     WHERE company_dict_type = v_procate
       AND company_dict_name = v_subcatename
       AND company_id = v_compid
       AND rownum = 1;
  END p_get_cpsvalue;

  /*===================================================================================
  
    根据内部供应商编码，获取供应商编码+供应商名称
  
    用途:
      根据内部供应商编码，获取供应商编码+供应商名称
  
    用于:
      预计新品导入
  
    入参:
      v_insidesupcode  :  内部供应商编码
      v_compid         :  企业id
      v_supcode        :  供应商编码
      v_supcompname    :  供应商名称
  
    版本:
      2021-12-18 : 根据内部供应商编码，获取供应商编码+供应商名称
  
  ===================================================================================*/
  PROCEDURE p_get_supcode_and_supname
  (
    v_insidesupcode IN VARCHAR2,
    v_compid        IN VARCHAR2,
    v_supcode       IN OUT VARCHAR2,
    v_supcompname   IN OUT VARCHAR2
  ) IS
  BEGIN
    SELECT MAX(supplier_code),
           MAX(supplier_company_name)
      INTO v_supcode,
           v_supcompname
      FROM scmdata.t_supplier_info
     WHERE inside_supplier_code = v_insidesupcode
       AND company_id = v_compid
       AND rownum = 1;
  END p_get_supcode_and_supname;

  /*===================================================================================
  
    获取季节编码
  
    用途:
      用于获取季节编码，有则返回季节编码，无则返回空
  
    用于:
      预计新品导入
  
    入参:
      V_SEANAME  :  季节名称
  
    返回值:
      字符串类型，有则返回编码，无则返回空
  
    版本:
      2021-12-20 : 预计新品导入唯一性校验
  
  ===================================================================================*/
  FUNCTION f_get_season(v_seaname IN VARCHAR2) RETURN VARCHAR2 IS
    v_season VARCHAR2(2);
  BEGIN
    SELECT MAX(group_dict_value)
      INTO v_season
      FROM scmdata.sys_group_dict
     WHERE group_dict_type = 'GD_SESON'
       AND group_dict_name = v_seaname;
  
    RETURN v_season;
  END f_get_season;

  /*===================================================================================
  
    2数之和大于0校验
  
    用途:
      校验2数之和是否大于 0，
      大于 0 返回 0，小于/等于 0 返回 1
  
    用于:
      预计新品导入, 爆品可能数量+非爆品可能数量必须大于0校验
  
    入参:
      v_num1  :  输入数1
      v_num2  :  输入数2
  
    版本:
      2021-12-20 : 校验2数之和是否大于 0，
                   大于 0 返回 0，小于/等于 0 返回 1
  
  ===================================================================================*/
  FUNCTION f_check_sumtwonum_gt_zero
  (
    v_num1 IN NUMBER,
    v_num2 IN NUMBER
  ) RETURN NUMBER IS
    v_retnum NUMBER(1);
  BEGIN
    IF v_num1 + v_num2 > 0 THEN
      v_retnum := 0;
    ELSE
      v_retnum := 1;
    END IF;
  
    RETURN v_retnum;
  END f_check_sumtwonum_gt_zero;

  /*===================================================================================
  
    2日期比较，校验先输入的日期大于等于后输入的日期
  
    用途:
      用于校验先输入的日期大于等于后输入的日期，
      判定条件为真返回 0，判定条件为假返回 1
  
    用于:
      预计新品/预计新品导入, 订单交期 >= 预计下单日期
  
    入参:
      v_befday  :  先输入日期
      v_aftday  :  后输入日期
  
    返回值:
      判定条件：先输入的日期大于等于后输入的日期
      判定条件为真返回 0，判定条件为假返回 1
  
    版本:
      2021-12-20 : 用于校验先输入的日期大于等于后输入的日期，
                   判定条件为真返回 0，判定条件为假返回 1
  
  ===================================================================================*/
  FUNCTION f_check_befday_gt_aftday
  (
    v_befday IN DATE,
    v_aftday IN DATE
  ) RETURN NUMBER IS
    v_retnum NUMBER(1);
  BEGIN
    IF v_befday >= v_aftday THEN
      v_retnum := 0;
    ELSE
      v_retnum := 1;
    END IF;
  
    RETURN v_retnum;
  END f_check_befday_gt_aftday;

  /*===================================================================================
  
    预计新品唯一性校验
  
    用途:
      预计新品唯一性校验
  
    用于:
      预计新品新增，预计新品导入
  
    入参:
      V_ISDSUPCODE  :  内部供应商编码
      V_CATE        :  分类名称
      V_PROCATE     :  生产分类名称
      V_SUBCATE     :  子类名称
      V_YEAR        :  年度
      V_SEASON      :  季节
      V_WAVE        :  波段
      V_ORDDATE     :  预计下单日期
      V_DELDATE     :  预计订单交期
      V_COMPID      :  企业Id
  
    返回值:
      0 表示预计新品中不存在， 1 表示预计新品中存在
  
    版本:
      2021-12-20 : 预计新品唯一性校验
  
  ===================================================================================*/
  FUNCTION f_check_coopsup_unq
  (
    v_isdsupcode IN VARCHAR2,
    v_cate       IN VARCHAR2,
    v_procate    IN VARCHAR2,
    v_subcate    IN VARCHAR2,
    v_season     IN VARCHAR2,
    v_wave       IN VARCHAR2,
    v_orddate    IN DATE,
    v_deldate    IN DATE,
    v_compid     IN VARCHAR2
  ) RETURN NUMBER IS
    v_jugnum  NUMBER(1);
    v_supcode VARCHAR2(32);
  BEGIN
    SELECT MAX(supplier_code)
      INTO v_supcode
      FROM scmdata.t_supplier_info
     WHERE inside_supplier_code = v_isdsupcode
       AND company_id = v_compid;
  
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_plan_newproduct
     WHERE supplier_code = v_supcode
       AND category = v_cate
       AND product_cate = v_procate
       AND subcategory = v_subcate
       AND waveact_status = 'OP'
       AND season = v_season
       AND ware = v_wave
       AND predord_date = v_orddate
       AND preddelv_date = v_deldate
       AND company_id = v_compid
       AND rownum = 1;
  
    RETURN v_jugnum;
  END f_check_coopsup_unq;

  /*===================================================================================
  
    预计新品导入校验
  
    用途:
      用于预计新品导入总校验
  
    用于:
      预计新品导入
  
    入参:
      isdsupcode     :  内部供应商编号
      v_compid       :  企业id
      v_catename     :  分类名称
      v_procname     :  生产分类名称
      v_subcname     :  子类名称
      v_seaname      :  季节
      v_wave         :  波段
      v_hsamt        :  爆品可能数量
      v_nmamt        :  非爆品可能数量
      v_orddate      :  预计下单日期
      v_deldate      :  预计交货日期
      v_errmsgs      :  错误信息变量
      v_status       :  状态变量
      v_category     :  分类变量
      v_prodcate     :  生产分类变量
      v_subcate      :  子类变量
      v_season       :  季节变量
      v_supcode      :  供应商编码变量
      v_supcompname  :  供应商名称变量
  
    版本:
      2021-12-20 : 校验输入年份不小于当前系统时间年份，
                   满足条件返回 0， 不满足条件返回 1
  
  ===================================================================================*/
  PROCEDURE p_check_plannew_import
  (
    v_isdsupcode  IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_catename    IN VARCHAR2,
    v_procname    IN VARCHAR2,
    v_subcname    IN VARCHAR2,
    v_seaname     IN VARCHAR2,
    v_wave        IN NUMBER,
    v_hsamt       IN NUMBER,
    v_nmamt       IN NUMBER,
    v_orddate     IN DATE,
    v_deldate     IN DATE,
    v_piid        IN VARCHAR2 DEFAULT NULL,
    v_importid    IN VARCHAR2,
    v_errmsgs     IN OUT VARCHAR2,
    v_status      IN OUT VARCHAR2,
    v_category    IN OUT VARCHAR2,
    v_prodcate    IN OUT VARCHAR2,
    v_subcate     IN OUT VARCHAR2,
    v_season      IN OUT VARCHAR2,
    v_supcode     IN OUT VARCHAR2,
    v_supcompname IN OUT VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
    v_pause  NUMBER(1);
  BEGIN
    IF v_piid IS NOT NULL THEN
      v_jugnum := f_check_coopsupipt_unq(v_isdsupcode => v_isdsupcode,
                                         v_catename   => v_catename,
                                         v_pcname     => v_procname,
                                         v_scname     => v_subcname,
                                         v_seaname    => v_seaname,
                                         v_wave       => v_wave,
                                         v_preodate   => v_orddate,
                                         v_preddate   => v_deldate,
                                         v_piid       => v_piid,
                                         v_importid   => v_importid,
                                         v_compid     => v_compid);
    ELSE
      v_jugnum := f_check_coopsupipt_unq(v_isdsupcode => v_isdsupcode,
                                         v_catename   => v_catename,
                                         v_pcname     => v_procname,
                                         v_scname     => v_subcname,
                                         v_seaname    => v_seaname,
                                         v_wave       => v_wave,
                                         v_preodate   => v_orddate,
                                         v_preddate   => v_deldate,
                                         v_importid   => v_importid,
                                         v_compid     => v_compid);
    END IF;
  
    IF v_jugnum = 1 THEN
      v_errmsgs := v_errmsgs || chr(10) || '内部供应商编号：【' || v_isdsupcode ||
                   '】在预计新品导入列表内存在重复值';
    ELSE
      p_get_cpsvalue(v_catename    => v_catename,
                     v_procatename => v_procname,
                     v_subcatename => v_subcname,
                     v_compid      => v_compid,
                     v_cate        => v_category,
                     v_procate     => v_prodcate,
                     v_subcate     => v_subcate);
    
      p_get_supcode_and_supname(v_insidesupcode => v_isdsupcode,
                                v_compid        => v_compid,
                                v_supcode       => v_supcode,
                                v_supcompname   => v_supcompname);
      IF v_supcode IS NULL THEN
        v_errmsgs := v_errmsgs || chr(10) || '内部供应商编号：【' || v_isdsupcode ||
                     '】不存在于供应商档案中';
      END IF;
    
      IF v_category IS NULL THEN
        v_errmsgs := v_errmsgs || chr(10) || '分类：【' || v_catename ||
                     '】不存在于数据字典中';
      END IF;
    
      IF v_prodcate IS NULL THEN
        v_errmsgs := v_errmsgs || chr(10) || '生产分类：【' || v_procname ||
                     '】不存在于数据字典中';
      END IF;
    
      IF v_subcate IS NULL THEN
        v_errmsgs := v_errmsgs || chr(10) || '子类：【' || v_subcname ||
                     '】不存在于数据字典中';
      END IF;
    END IF;
  
    v_season := f_get_season(v_seaname => v_seaname);
  
    IF v_season IS NULL THEN
      v_errmsgs := v_errmsgs || chr(10) || '季节：【' || v_seaname ||
                   '】不存在于数据字典中';
    END IF;
  
    v_jugnum := f_check_sumtwonum_gt_zero(v_num1 => v_hsamt,
                                          v_num2 => v_nmamt);
  
    IF v_jugnum = 1 THEN
      v_errmsgs := v_errmsgs || chr(10) || '爆品可能数量：【' || v_hsamt ||
                   '】+非爆品可能数量：【' || v_nmamt || '】必须大于0';
    END IF;
  
    v_jugnum := f_check_befday_gt_aftday(v_befday => v_deldate,
                                         v_aftday => v_orddate);
  
    IF v_jugnum = 1 THEN
      v_errmsgs := v_errmsgs || chr(10) || '预计交货日期：【' ||
                   to_char(v_deldate, 'YYYY-MM-DD') || '】必须大于 预计下单日期:【' ||
                   to_char(v_orddate, 'YYYY-MM-DD') || '】';
    END IF;
  
    v_jugnum := f_check_befday_gt_aftday(v_befday => v_orddate,
                                         v_aftday => SYSDATE);
  
    IF v_jugnum = 1 THEN
      v_errmsgs := v_errmsgs || chr(10) || '预计下单日期：【' ||
                   to_char(v_orddate, 'YYYY-MM-DD') || '】必须大于当前系统时间';
    END IF;
  
    IF extract(YEAR FROM v_orddate) < extract(YEAR FROM SYSDATE) THEN
      v_errmsgs := v_errmsgs || chr(10) || '预计下单日期：【' ||
                   to_char(v_orddate, 'YYYY-MM-DD') || '】年份取值小于当前日期';
    END IF;
  
    IF extract(YEAR FROM v_deldate) < extract(YEAR FROM SYSDATE) THEN
      v_errmsgs := v_errmsgs || chr(10) || '预计交货日期：【' ||
                   to_char(v_deldate, 'YYYY-MM-DD') || '】年份取值小于当前日期';
    END IF;
  
    v_jugnum := f_check_coopsup_unq(v_isdsupcode => v_isdsupcode,
                                    v_cate       => v_category,
                                    v_procate    => v_prodcate,
                                    v_subcate    => v_subcate,
                                    v_season     => v_season,
                                    v_wave       => v_wave,
                                    v_orddate    => v_orddate,
                                    v_deldate    => v_deldate,
                                    v_compid     => v_compid);
  
    IF v_jugnum > 0 THEN
      v_errmsgs := v_errmsgs || chr(10) || '内部供应商编号：【' || v_isdsupcode ||
                   '】已存在于预计新品中';
    END IF;
  
    IF v_supcode IS NOT NULL THEN
      SELECT COUNT(1),
             MAX(pause)
        INTO v_jugnum,
             v_pause
        FROM scmdata.t_coopcate_supplier_cfg
       WHERE supplier_code = v_supcode
         AND coop_category = v_category
         AND coop_productcate = v_prodcate
         AND coop_subcategory = v_subcate
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0
         AND v_pause IS NULL THEN
        v_errmsgs := v_errmsgs || chr(10) || '内部供应商编号【' || v_isdsupcode ||
                     '】 分类【' || v_catename || '】 生产分类【' || v_procname ||
                     '】 子类【' || v_subcname || '】 在品类合作供应商中未找到对应数据';
      ELSIF v_jugnum = 1
            AND v_pause = 1 THEN
        v_errmsgs := v_errmsgs || chr(10) || '内部供应商编号【' || v_isdsupcode ||
                     '】 分类【' || v_catename || '】 生产分类【' || v_procname ||
                     '】 子类【' || v_subcname ||
                     '】 在品类合作供应商中【状态】必须为【启用】，否则不能导入！';
      END IF;
    
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_app_capacity_cfg
       WHERE supplier_code = v_supcode
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        v_errmsgs := v_errmsgs || chr(10) || '内部供应商编号【' || v_isdsupcode ||
                     '】在生产工厂产能预约中未能找到对应值';
      END IF;
    END IF;
  
    SELECT COUNT(1),
           MAX(in_planning)
      INTO v_jugnum,
           v_pause
      FROM scmdata.t_capacity_plan_category_cfg
     WHERE category = v_category
       AND product_cate = v_prodcate
       AND subcategory = v_subcate
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      v_errmsgs := v_errmsgs || chr(10) || '分类【' || v_catename || '】 生产分类【' ||
                   v_procname || '】 子类【' || v_subcname ||
                   '】 在产能规划品类配置中未找到对应数据';
    ELSIF v_jugnum = 1
          AND v_pause = 0 THEN
      v_errmsgs := v_errmsgs || chr(10) || '分类【' || v_catename || '】 生产分类【' ||
                   v_procname || '】 子类【' || v_subcname ||
                   '】 在产能规划品类配置【是否做产能规划】字段的值，必须为【是】，否则不能导入';
    END IF;
  
    v_errmsgs := ltrim(v_errmsgs, chr(10));
  
    IF regexp_instr(v_errmsgs, '\w') > 0 THEN
      v_status := 'ER';
    ELSE
      v_status := 'CP';
    END IF;
  END p_check_plannew_import;

  /*===================================================================================
  
    导入获取-分类、生产分类、子类
  
    用途:
      用于在产能导入页面中获取分类、生产分类、子类
  
    入参:
      v_catename    :  分类名称
      v_procatename :  生产分类名称
      v_subcatename :  产品子类名称
      v_compid      :  企业id
      v_cate        :  分类
      v_procate     :  生产分类
      v_subcate     :  产品子类
  
    出参:
      v_cate        :  分类
      v_procate     :  生产分类
      v_subcate     :  产品子类
  
    版本:
      2022-08-02 :用于在产能导入页面中获取分类、生产分类、子类
  
  ===================================================================================*/
  PROCEDURE p_importget_cps
  (
    v_catename    IN VARCHAR2,
    v_procatename IN VARCHAR2,
    v_subcatename IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_cate        IN OUT VARCHAR2,
    v_procate     IN OUT VARCHAR2,
    v_subcate     IN OUT VARCHAR2
  ) IS
  
  BEGIN
    SELECT MAX(group_dict_value)
      INTO v_cate
      FROM scmdata.sys_group_dict
     WHERE group_dict_name = v_catename
       AND group_dict_type = 'PRODUCT_TYPE';
  
    SELECT MAX(group_dict_value)
      INTO v_procate
      FROM scmdata.sys_group_dict
     WHERE group_dict_name = v_procatename
       AND group_dict_type = v_cate;
  
    SELECT MAX(company_dict_value)
      INTO v_subcate
      FROM scmdata.sys_company_dict
     WHERE company_dict_name = v_subcatename
       AND company_dict_type = v_procate
       AND company_id = v_compid;
  END p_importget_cps;

  /*===================================================================================
  
    导入获取-供应商编码
  
    用途:
      用于在产能导入页面中获取供应商编码
  
    入参:
      v_isdsupcode  :  内部供应商编码
      v_compid      :  企业id
      v_supcode     :  供应商编码
      v_supname     :  供应商名称
  
    出参:
      v_supcode     :  供应商编码
      v_supname     :  供应商名称
  
    版本:
      2022-08-02 : 用于在产能导入页面中获取供应商编码
  
  ===================================================================================*/
  PROCEDURE p_importget_sup
  (
    v_isdsupcode IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_supcode    IN OUT VARCHAR2,
    v_supname    IN OUT VARCHAR2
  ) IS
  
  BEGIN
    SELECT MAX(supplier_code),
           MAX(supplier_company_name)
      INTO v_supcode,
           v_supname
      FROM scmdata.t_supplier_info
     WHERE inside_supplier_code = v_isdsupcode
       AND company_id = v_compid;
  END p_importget_sup;

  /*===================================================================================
  
    校验并获取供应商编码，分类，生产分类，产品子类数据
  
    用途:
      校验并获取供应商编码，分类，生产分类，产品子类数据
  
    入参:
      v_isdsupcode  :  内部供应商编码
      v_catename    :  分类名称
      v_procatename :  生产分类名称
      v_subcatename :  产品子类名称
      v_compid      :  企业id
      v_supcode     :  供应商编码
      v_supname     :  供应商名称
      v_cate        :  分类
      v_procate     :  生产分类
      v_subcate     :  产品子类
      v_errmsg      :  错误信息
  
    出参:
      v_supcode     :  供应商编码
      v_supname     :  供应商名称
      v_cate        :  分类
      v_procate     :  生产分类
      v_subcate     :  产品子类
      v_errmsg      :  错误信息
  
    版本:
      2022-08-02 :校验并获取供应商编码，分类，生产分类，产品子类数据
  
  ===================================================================================*/
  PROCEDURE p_importcheck_cpss
  (
    v_isdsupcode  IN VARCHAR2,
    v_catename    IN VARCHAR2,
    v_procatename IN VARCHAR2,
    v_subcatename IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_supcode     IN OUT VARCHAR2,
    v_supname     IN OUT VARCHAR2,
    v_cate        IN OUT VARCHAR2,
    v_procate     IN OUT VARCHAR2,
    v_subcate     IN OUT VARCHAR2,
    v_errmsg      IN OUT CLOB
  ) IS
    v_jugnum NUMBER(1);
    v_pause  NUMBER(1);
  BEGIN
    IF v_catename IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '分类为空';
    END IF;
  
    IF v_procatename IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '生产分类为空';
    END IF;
  
    IF v_subcatename IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '产品子类为空';
    END IF;
  
    IF v_isdsupcode IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '供应商编号为空';
    END IF;
  
    p_importget_cps(v_catename    => v_catename,
                    v_procatename => v_procatename,
                    v_subcatename => v_subcatename,
                    v_compid      => v_compid,
                    v_cate        => v_cate,
                    v_procate     => v_procate,
                    v_subcate     => v_subcate);
  
    p_importget_sup(v_isdsupcode => v_isdsupcode,
                    v_compid     => v_compid,
                    v_supcode    => v_supcode,
                    v_supname    => v_supname);
  
    IF v_cate IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '分类【' || v_catename || '】不存在于数据字典';
    END IF;
  
    IF v_procate IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '生产分类【' || v_procatename ||
                  '】不存在于数据字典';
    END IF;
  
    IF v_subcate IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '产品子类【' || v_subcatename ||
                  '】不存在于数据字典';
    END IF;
  
    IF v_supcode IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '内部供应商编码【' || v_isdsupcode ||
                  '】不存在于供应商档案';
    END IF;
  
    SELECT COUNT(1),
           MAX(pause)
      INTO v_jugnum,
           v_pause
      FROM scmdata.t_coopcate_supplier_cfg
     WHERE coop_category = v_cate
       AND coop_productcate = v_procate
       AND coop_subcategory = v_subcate
       AND supplier_code = v_supcode
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      v_errmsg := v_errmsg || chr(10) || '供应商+产品子类在【合作供应商品类配置】中不存在';
    ELSE
      IF v_pause = 1 THEN
        v_errmsg := v_errmsg || chr(10) || '供应商+产品子类在【合作供应商品类配置】中停用';
      END IF;
    END IF;
  
    SELECT COUNT(1),
           MAX(in_planning)
      INTO v_jugnum,
           v_pause
      FROM scmdata.t_capacity_plan_category_cfg
     WHERE category = v_cate
       AND product_cate = v_procate
       AND subcategory = v_subcate
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      v_errmsg := v_errmsg || chr(10) || '供应商+产品子类在【产能品类规划】中不存在';
    ELSE
      IF v_pause = 0 THEN
        v_errmsg := v_errmsg || chr(10) || '供应商+产品子类在【产能品类规划】中停用';
      END IF;
    END IF;
  END p_importcheck_cpss;

  /*===================================================================================
  
    导入校验-预计下单日期，预计订单交期校验
  
    用途:
      用于在产能导入页面中预计下单日期，预计订单交期校验
  
    入参:
      v_preorddate  :  预计下单日期
      v_predlvdate  :  预计交期
      v_preordamt   :  预计下单数量
      v_errmsg      :  错误信息
  
    出参:
      类型为 CLOB 的错误信息
  
    版本:
      2022-08-02 : 用于在产能导入页面中预计下单日期，预计订单交期校验
  
  ===================================================================================*/
  PROCEDURE p_importcheck_pod_pdd
  (
    v_preorddate IN DATE,
    v_predlvdate IN DATE,
    v_errmsg     IN OUT CLOB
  ) IS
  
  BEGIN
    IF v_preorddate IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '预计下单日期为空';
    ELSIF trunc(v_preorddate) <= trunc(SYSDATE) THEN
      v_errmsg := v_errmsg || chr(10) || '预计下单日期必须大于当前日期';
    END IF;
  
    IF v_predlvdate IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '预计订单交期为空';
    ELSIF trunc(v_predlvdate) <= trunc(v_preorddate)
          AND v_preorddate IS NOT NULL THEN
      v_errmsg := v_errmsg || chr(10) || '预计订单交期必须大于预计下单日期';
    END IF;
  END p_importcheck_pod_pdd;

  /*===================================================================================
  
    导入校验-预计下单日期，预计订单交期校验
  
    用途:
      用于在产能导入页面中预计下单日期，预计订单交期校验
  
    入参:
      v_preorddate  :  预计下单日期
      v_predlvdate  :  预计交期
      v_preordamt   :  预计下单数量
      v_errmsg      :  错误信息
  
    出参:
      类型为 CLOB 的错误信息
  
    版本:
      2022-08-02 : 用于在产能导入页面中预计下单日期，预计订单交期校验
  
  ===================================================================================*/
  PROCEDURE p_importcheck_poa
  (
    v_preordamt IN NUMBER,
    v_errmsg    IN OUT CLOB
  ) IS
  BEGIN
    IF v_preordamt IS NULL THEN
      v_errmsg := v_errmsg || chr(10) || '预计订单数量为空';
    ELSIF v_preordamt <= 0
          OR v_preordamt - trunc(v_preordamt) > 0 THEN
      v_errmsg := v_errmsg || chr(10) || '预计订单数量不为正整数';
    END IF;
  END p_importcheck_poa;

  /*===================================================================================
  
    导入校验-预计补单导入唯一性校验
  
    用途:
      用于预计补单导入唯一性校验
  
    入参:
      v_isdsupcode  :  内部供应商编码
      v_supcode     :  供应商编码
      v_cate        :  分类
      v_catename    :  分类名称
      v_procate     :  生产分类
      v_procatename :  生产分类名称
      v_subcate     :  产品子类
      v_subcatename :  产品子类名称
      v_preorddate  :  预计下单日期
      v_predlvdate  :  预计订单交期
      v_psiid       :  预计补单导入表id
      v_importer    :  导入人id
      v_compid      :  企业id
      v_errmsg      :  错误信息
  
    出参:
      v_errmsg      :  错误信息
  
    版本:
      2022-08-02 : 用于预计补单导入唯一性校验
  
  ===================================================================================*/
  PROCEDURE p_importcheck_plnsuppunq
  (
    v_isdsupcode  IN VARCHAR2,
    v_supcode     IN VARCHAR2,
    v_cate        IN VARCHAR2,
    v_catename    IN VARCHAR2,
    v_procate     IN VARCHAR2,
    v_procatename IN VARCHAR2,
    v_subcate     IN VARCHAR2,
    v_subcatename IN VARCHAR2,
    v_preorddate  IN DATE,
    v_predlvdate  IN DATE,
    v_psiid       IN VARCHAR2,
    v_importer    IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_errmsg      IN OUT CLOB
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_psiid IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_plannew_supplementary_import
       WHERE inside_supplier_code = v_isdsupcode
         AND cate_name = v_catename
         AND procate_name = v_procatename
         AND subcate_name = v_subcatename
         AND trunc(predord_date) = trunc(v_preorddate)
         AND trunc(preddelv_date) = trunc(v_predlvdate)
         AND psi_id <> v_psiid
         AND import_id = v_importer
         AND company_id = v_compid
         AND rownum = 1;
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_plannew_supplementary_import
       WHERE inside_supplier_code = v_isdsupcode
         AND cate_name = v_catename
         AND procate_name = v_procatename
         AND subcate_name = v_subcatename
         AND trunc(predord_date) = trunc(v_preorddate)
         AND trunc(preddelv_date) = trunc(v_predlvdate)
         AND import_id = v_importer
         AND company_id = v_compid
         AND rownum = 1;
    END IF;
  
    IF v_jugnum > 0 THEN
      v_errmsg := v_errmsg || chr(10) || '分类【' || v_catename || '】 生产分类【' ||
                  v_procatename || '】 产品子类【' || v_subcatename ||
                  '】 预计下单日期【' || to_char(v_preorddate, 'YYYY-MM-DD') ||
                  '】 预计订单交期【' || to_char(v_predlvdate, 'YYYY-MM-DD') ||
                  '】 内部供应商编码【' || v_isdsupcode || '】已经存在于预计补单导入页面';
    END IF;
  
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_plannew_supplementary
     WHERE category = v_cate
       AND product_cate = v_procate
       AND subcategory = v_subcate
       AND supplier_code = v_supcode
       AND trunc(predord_date) = trunc(v_preorddate)
       AND trunc(preddelv_date) = trunc(v_predlvdate)
       AND act_status = 'NO'
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum > 0 THEN
      v_errmsg := v_errmsg || chr(10) || '分类【' || v_catename || '】 生产分类【' ||
                  v_procatename || '】 产品子类【' || v_subcatename ||
                  '】 预计下单日期【' || to_char(v_preorddate, 'YYYY-MM-DD') ||
                  '】 预计订单交期【' || to_char(v_predlvdate, 'YYYY-MM-DD') ||
                  '】 内部供应商编码【' || v_isdsupcode || '】已经存在于预计补单页面';
    END IF;
  
  END p_importcheck_plnsuppunq;

  /*===================================================================================
  
    预计补单导入校验逻辑
  
    用途:
      预计补单导入校验逻辑
  
    入参:
      v_isdsupcode  :  内部供应商编码
      v_catename    :  分类名称
      v_procatename :  生产分类名称
      v_subcatename :  产品子类名称
      v_preorddate  :  预计下单日期
      v_predlvdate  :  预计交期
      v_preordamt   :  预计下单数量
      v_compid      :  企业id
      v_cate        :  分类
      v_procate     :  生产分类
      v_subcate     :  产品子类
      v_supcode     :  供应商编码
      v_supname     :  供应商名称
  
    出参:
      v_cate        :  分类
      v_procate     :  生产分类
      v_subcate     :  产品子类
      v_supcode     :  供应商编码
      v_supname     :  供应商名称
      v_errmsg      :  错误信息
  
    版本:
      2022-08-02 : 用于预计补单导入校验
  
  ===================================================================================*/
  PROCEDURE p_plnsupp_importcheck
  (
    v_isdsupcode  IN VARCHAR2,
    v_catename    IN VARCHAR2,
    v_procatename IN VARCHAR2,
    v_subcatename IN VARCHAR2,
    v_preorddate  IN DATE,
    v_predlvdate  IN DATE,
    v_preordamt   IN NUMBER,
    v_psiid       IN VARCHAR2,
    v_importer    IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_cate        IN OUT VARCHAR2,
    v_procate     IN OUT VARCHAR2,
    v_subcate     IN OUT VARCHAR2,
    v_supcode     IN OUT VARCHAR2,
    v_supname     IN OUT VARCHAR2,
    v_status      IN OUT VARCHAR2,
    v_errmsg      IN OUT CLOB
  ) IS
  
  BEGIN
    p_importcheck_cpss(v_isdsupcode  => v_isdsupcode,
                       v_catename    => v_catename,
                       v_procatename => v_procatename,
                       v_subcatename => v_subcatename,
                       v_compid      => v_compid,
                       v_supcode     => v_supcode,
                       v_supname     => v_supname,
                       v_cate        => v_cate,
                       v_procate     => v_procate,
                       v_subcate     => v_subcate,
                       v_errmsg      => v_errmsg);
  
    p_importcheck_pod_pdd(v_preorddate => v_preorddate,
                          v_predlvdate => v_predlvdate,
                          v_errmsg     => v_errmsg);
  
    p_importcheck_poa(v_preordamt => v_preordamt, v_errmsg => v_errmsg);
  
    p_importcheck_plnsuppunq(v_isdsupcode  => v_isdsupcode,
                             v_supcode     => v_supcode,
                             v_cate        => v_cate,
                             v_catename    => v_catename,
                             v_procate     => v_procate,
                             v_procatename => v_procatename,
                             v_subcate     => v_subcate,
                             v_subcatename => v_subcatename,
                             v_preorddate  => v_preorddate,
                             v_predlvdate  => v_predlvdate,
                             v_psiid       => v_psiid,
                             v_importer    => v_importer,
                             v_compid      => v_compid,
                             v_errmsg      => v_errmsg);
  
    IF v_errmsg IS NULL THEN
      v_status := 'CP';
    ELSE
      v_status := 'ER';
    END IF;
  END p_plnsupp_importcheck;

  /*===================================================================================
  
    【已测试】计算: 产能上限，约定产能
  
    用途:
      通过 SCMDATA.T_SUPPLIER_CAPACITY_DETAIL.PTC_ID(供应商产能明细清单Id)
      计算 产能上限，约定产能，预约产能占比
  
    计算公式:
      产能上限 = 上班时数 * 60 * 车位人数 * 生产效率
      约定产能 = 上班时数 * 60 * 车位人数 * 生产效率 * 预约产能占比
  
    用于:
      供应商产能预约
    版本:
  
      2021-11-29 : 通过 SCMDATA.T_SUPPLIER_CAPACITY_DETAIL.PTC_ID(供应商产能明细清单Id)
                   计算产能上限
  
  ===================================================================================*/
  --need
  PROCEDURE p_calculate_capacity_rela
  (
    v_ptcid       IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_capcceiling IN OUT NUMBER,
    v_appcapacity IN OUT NUMBER
  ) IS
  
  BEGIN
    SELECT SUM(work_hour * 60 * work_people * (prod_effient / 100)),
           SUM(work_hour * 60 * work_people * (prod_effient / 100) *
               (appcapacity_rate / 100))
      INTO v_capcceiling,
           v_appcapacity
      FROM scmdata.t_capacity_appointment_detail
     WHERE ptc_id = v_ptcid
       AND company_id = v_compid;
  END p_calculate_capacity_rela;

  /*===================================================================================
  
    获取某工厂除当前供应商外的剩余产能占比
  
    用途:
      用于获取某工厂除当前供应商外的剩余产能占比
  
    用于:
      生产周期配置
  
    入参:
      V_CATE     :  分类Id
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  工厂编码
      V_COMPID   :  企业Id
  
    版本:
      2021-12-06 : 用于获取某工厂除当前供应商外的剩余产能占比
      2022-08-22 : 表维度修改
  
  ===================================================================================*/
  --need
  FUNCTION f_get_restcapc_rate
  (
    v_cate    IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER IS
    v_appcapctotal  NUMBER(16, 2);
    v_restcapctotal NUMBER(5, 2);
  BEGIN
    SELECT SUM(appcapc_rate)
      INTO v_appcapctotal
      FROM scmdata.t_app_capacity_cfg acc
     WHERE factory_code = acc.factory_code
       AND company_id = acc.company_id
       AND NOT EXISTS (SELECT 1
              FROM scmdata.t_app_capacity_cfg
             WHERE category = v_cate
               AND supplier_code = v_supcode
               AND factory_code = v_faccode
               AND company_id = v_compid
               AND acc_id = acc.acc_id
               AND company_id = acc.company_id);
  
    IF nvl(v_appcapctotal, 0) > 100 THEN
      v_restcapctotal := 0;
    ELSE
      v_restcapctotal := 100 - nvl(v_appcapctotal, 0);
    END IF;
  
    RETURN v_restcapctotal;
  END f_get_restcapc_rate;

  /*===================================================================================
  
    根据供应商编码生成生产工厂产能预约配置数据
  
    用途:
      用于根据供应商编码生成生产工厂产能预约配置数据
  
    入参:
      V_SUPCODE  :  供应商编码
      V_COMPID   :  企业Id
  
    版本:
      2022-03-21 : 根据供应商编码生成生产工厂产能预约配置数据
      2022-08-22 : 表维度修改
      2022-09-16 : 增加操作人和操作时间
  
  ===================================================================================*/
  --need
  PROCEDURE p_gen_appcapccfg_data_by_sup
  (
    v_supcode  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    v_restcapcrate NUMBER(5, 2);
    v_jugnum       NUMBER(1);
  BEGIN
    FOR x IN (SELECT a.coop_category,
                     a.supplier_code,
                     a.factory_code,
                     a.company_id,
                     b.product_efficiency,
                     b.work_hours_day,
                     b.worker_num
                FROM (SELECT coop_category,
                             supplier_code,
                             factory_code,
                             company_id,
                             MAX(create_time) create_time
                        FROM (SELECT csc.supplier_code,
                                     cfc.factory_code,
                                     csc.company_id,
                                     csc.create_time,
                                     csc.coop_category
                                FROM scmdata.t_coopcate_supplier_cfg csc
                               INNER JOIN scmdata.t_coopcate_factory_cfg cfc
                                  ON csc.csc_id = cfc.csc_id
                                 AND csc.company_id = cfc.company_id
                               WHERE cfc.factory_code IS NOT NULL
                                 AND csc.supplier_code = v_supcode
                                 AND csc.company_id = v_compid
                                 AND NOT EXISTS
                               (SELECT 1
                                        FROM scmdata.t_app_capacity_cfg
                                       WHERE category = csc.coop_category
                                         AND supplier_code = csc.supplier_code
                                         AND factory_code = cfc.factory_code
                                         AND company_id = csc.company_id))
                       GROUP BY coop_category,
                                supplier_code,
                                factory_code,
                                company_id) a
                LEFT JOIN scmdata.t_supplier_info b
                  ON a.factory_code = b.supplier_code
                 AND a.company_id = b.company_id
               ORDER BY a.create_time) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_app_capacity_cfg
       WHERE category = x.coop_category
         AND supplier_code = x.supplier_code
         AND factory_code = x.factory_code
         AND company_id = x.company_id
         AND rownum = 1;
    
      v_restcapcrate := f_get_restcapc_rate(v_cate    => x.coop_category,
                                            v_supcode => x.supplier_code,
                                            v_faccode => x.factory_code,
                                            v_compid  => x.company_id);
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_app_capacity_cfg
          (acc_id, company_id, category, supplier_code, factory_code, wktime_num, wkperson_num, prod_eff, restcapc_rate, appcapc_rate, create_id, create_time)
        VALUES
          (scmdata.f_get_uuid(), x.company_id, x.coop_category, x.supplier_code, x.factory_code, x.work_hours_day, x.worker_num, x.product_efficiency, v_restcapcrate, 0, v_operid, to_date(v_opertime,
                    'YYYY-MM-DD HH24-MI-SS'));
      ELSE
        UPDATE scmdata.t_app_capacity_cfg
           SET wktime_num   = x.work_hours_day,
               wkperson_num = x.worker_num,
               prod_eff     = x.product_efficiency,
               update_id    = v_operid,
               update_time  = to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS')
         WHERE category = x.coop_category
           AND supplier_code = x.supplier_code
           AND factory_code = x.factory_code
           AND company_id = x.company_id;
      END IF;
    
    END LOOP;
  END p_gen_appcapccfg_data_by_sup;

  /*=============================================================================
  
     包：
       pkg_capacity_management(产能管理包)
  
     过程名:
       产能操作日志新增
  
     入参:
       v_inp_module_code    :  模块编码
       v_inp_module_name    :  模块名称
       v_inp_program_code   :  程序编码
       v_inp_program_name   :  程序名称
       v_inp_oper_type      :  操作类型
       v_inp_oper_detail    :  操作明细
       v_inp_oper_userid    :  操作人Id
       v_inp_oper_time      :  操作时间
       v_inp_oper_source    :  操作源
       v_inp_rela_unqfield1 :  关联唯一字段1
       v_inp_rela_unqfield2 :  关联唯一字段2
       v_inp_rela_unqfield3 :  关联唯一字段3
       v_inp_rela_unqfield4 :  关联唯一字段4
       v_inp_rela_unqfield5 :  关联唯一字段5
       v_inp_company_id     :  企业Id
  
     版本:
       2023-04-25_zc314 : 产能操作日志新增
  
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capacity_operlog
  (
    v_inp_module_code    IN scmdata.t_capacity_operlog.module_code%TYPE DEFAULT NULL,
    v_inp_module_name    IN scmdata.t_capacity_operlog.module_name%TYPE DEFAULT NULL,
    v_inp_program_code   IN scmdata.t_capacity_operlog.program_code%TYPE DEFAULT NULL,
    v_inp_program_name   IN scmdata.t_capacity_operlog.program_name%TYPE DEFAULT NULL,
    v_inp_oper_type      IN scmdata.t_capacity_operlog.oper_type%TYPE DEFAULT NULL,
    v_inp_oper_detail    IN scmdata.t_capacity_operlog.oper_detail%TYPE DEFAULT NULL,
    v_inp_oper_userid    IN scmdata.t_capacity_operlog.oper_userid%TYPE DEFAULT NULL,
    v_inp_oper_time      IN scmdata.t_capacity_operlog.oper_time%TYPE DEFAULT NULL,
    v_inp_oper_source    IN scmdata.t_capacity_operlog.oper_source%TYPE DEFAULT NULL,
    v_inp_rela_unqfield1 IN scmdata.t_capacity_operlog.rela_unqfield1%TYPE DEFAULT NULL,
    v_inp_rela_unqfield2 IN scmdata.t_capacity_operlog.rela_unqfield2%TYPE DEFAULT NULL,
    v_inp_rela_unqfield3 IN scmdata.t_capacity_operlog.rela_unqfield3%TYPE DEFAULT NULL,
    v_inp_rela_unqfield4 IN scmdata.t_capacity_operlog.rela_unqfield4%TYPE DEFAULT NULL,
    v_inp_rela_unqfield5 IN scmdata.t_capacity_operlog.rela_unqfield5%TYPE DEFAULT NULL,
    v_inp_company_id     IN scmdata.t_capacity_operlog.company_id%TYPE DEFAULT NULL,
    v_inp_invoke_object  IN VARCHAR2
  ) IS
    v_module_code_limit  CONSTANT VARCHAR2(512) := 'CAPACITY_CONFIG';
    v_program_code_limit CONSTANT VARCHAR2(512) := 'FAC_PROCATE_RATE_UPD;FAC_PROCATE_RATE_INS;SUP_SUBCATE_RATE_INS;SUP_SUBCATE_RATE_UPD';
    v_oper_type_limit    CONSTANT VARCHAR2(16) := 'INS;UPD;DEL';
    priv_exception        EXCEPTION;
    limit_exception       EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := 'scmdata.pkg_capacity_management.p_capc_fac_procate_rate_cfg_operlog_ins';
    v_self_description    VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_ins_capcoperlog';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --模块编码，程序编码，操作类型变量限制
    IF instr(v_module_code_limit, v_inp_module_code) = 0 THEN
      v_sql_errm := '模块编码未在允许范围内';
      RAISE limit_exception;
    ELSIF instr(v_program_code_limit, v_inp_program_code) = 0 THEN
      v_sql_errm := '程序编码未在允许范围内';
      RAISE limit_exception;
    ELSIF instr(v_oper_type_limit, v_inp_oper_type) = 0 THEN
      v_sql_errm := '操作类型未在允许范围内';
      RAISE limit_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_capacity_operlog
  (operlog_id,
   company_id,
   module_code,
   module_name,
   program_code,
   program_name,
   oper_type,
   oper_detail,
   oper_userid,
   oper_time,
   oper_source,
   rela_unqfield1,
   rela_unqfield2,
   rela_unqfield3,
   rela_unqfield4,
   rela_unqfield5)
VALUES
  (scmdata.f_get_uuid(),
   :v_inp_company_id,
   :v_inp_module_code,
   :v_inp_module_name,
   :v_inp_program_code, 
   :v_inp_program_name, 
   :v_inp_oper_type, 
   :v_inp_oper_detail, 
   :v_inp_oper_userid, 
   :v_inp_oper_time,
   :v_inp_oper_source,
   :v_inp_rela_unqfield1,
   :v_inp_rela_unqfield2,
   :v_inp_rela_unqfield3,
   :v_inp_rela_unqfield4,
   :v_inp_rela_unqfield5)';
  
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_company_id, v_inp_module_code, v_inp_module_name, v_inp_program_code, v_inp_program_name, v_inp_oper_type, v_inp_oper_detail, v_inp_oper_userid, v_inp_oper_time, v_inp_oper_source, v_inp_rela_unqfield1, v_inp_rela_unqfield2, v_inp_rela_unqfield3, v_inp_rela_unqfield4, v_inp_rela_unqfield5;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN limit_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                      chr(10) || 'v_inp_module_code: ' || v_inp_module_code ||
                      chr(10) || 'v_inp_module_name: ' || v_inp_module_name ||
                      chr(10) || 'v_inp_program_code: ' ||
                      v_inp_program_code || chr(10) ||
                      'v_inp_program_name: ' || v_inp_program_name ||
                      chr(10) || 'v_inp_oper_type: ' || v_inp_oper_type ||
                      chr(10) || 'v_inp_oper_detail: ' || v_inp_oper_detail ||
                      chr(10) || 'v_inp_oper_userid: ' || v_inp_oper_userid ||
                      chr(10) || 'v_inp_rela_unqfield1: ' ||
                      v_inp_rela_unqfield1 || chr(10) ||
                      'v_inp_rela_unqfield2: ' || v_inp_rela_unqfield2 ||
                      chr(10) || 'v_inp_rela_unqfield3: ' ||
                      v_inp_rela_unqfield3;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_oper_userid,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_ins_capacity_operlog;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       工厂生产类别占比配置操作日志新增
      
     入参:
       v_inp_supplier_code            :  供应商编码
       v_inp_factory_code             :  生产工厂编码
       v_inp_category                 :  分类编码
       v_inp_product_cate             :  生产分类编码
       v_inp_old_allocate_percentage  :  旧分配比例
       v_inp_new_allocate_percentage  :  新分配比例
       v_inp_oper_id                  :  操作人Id
       v_inp_oper_type                :  操作类型
       v_inp_oper_time                :  操作时间
       v_inp_oper_source              :  操作源
       v_inp_company_id               :  企业Id
        
     版本:
       2023-06-09_zc314 : 工厂生产类别占比配置操作日志新增
      
  ==============================================================================*/
  PROCEDURE p_capc_fac_procate_rate_cfg_operlog_ins
  (
    v_inp_supplier_code           IN VARCHAR2,
    v_inp_factory_code            IN VARCHAR2,
    v_inp_category                IN VARCHAR2,
    v_inp_product_cate            IN VARCHAR2,
    v_inp_old_allocate_percentage IN NUMBER,
    v_inp_new_allocate_percentage IN NUMBER,
    v_inp_oper_id                 IN VARCHAR2,
    v_inp_oper_type               IN VARCHAR2,
    v_inp_oper_time               IN DATE,
    v_inp_oper_source             IN VARCHAR2,
    v_inp_company_id              IN VARCHAR2
  ) IS
    v_jugnum           NUMBER(1);
    v_module_code      VARCHAR2(32) := 'CAPACITY_CONFIG';
    v_module_name      VARCHAR2(512) := '产能配置';
    v_program_code     VARCHAR2(32) := 'FAC_PROCATE_RATE_INS';
    v_program_name     VARCHAR2(512) := '工厂生产分类占比新增';
    v_oper_detail      VARCHAR2(1024);
    v_self_description VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_capc_fac_procate_rate_cfg_operlog_ins';
  BEGIN
    --是否存在操作日志判断
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capacity_operlog
     WHERE module_code = v_module_code
       AND program_code = v_program_code
       AND oper_type = v_inp_oper_type
       AND rela_unqfield1 = v_inp_supplier_code
       AND rela_unqfield2 = v_inp_factory_code
       AND rela_unqfield3 = v_inp_category
       AND oper_source = v_inp_oper_source
       AND oper_time = to_date(v_inp_oper_time, 'yyyy-mm-dd hh24-mi-ss')
       AND company_id = v_inp_company_id;
  
    --不存在产能操作日志则新增
    IF v_jugnum = 0 THEN
      --操作源判定，操作信息赋值
      IF v_inp_oper_source = 'MANC' THEN
        --操作细节赋值
        v_oper_detail := f_gen_facprocatecfg_operdetail(v_inp_category            => v_inp_category,
                                                        v_inp_product_cate        => v_inp_product_cate,
                                                        v_inp_old_allocatepercent => round(v_inp_old_allocate_percentage,
                                                                                           2),
                                                        v_inp_new_allocatepercent => round(v_inp_new_allocate_percentage,
                                                                                           2));
      ELSE
        --操作信息赋值
        v_oper_detail := '系统初始化';
      END IF;
    
      --操作日志新增
      p_tabapi_ins_capacity_operlog(v_inp_module_code    => v_module_code,
                                    v_inp_module_name    => v_module_name,
                                    v_inp_program_code   => v_program_code,
                                    v_inp_program_name   => v_program_name,
                                    v_inp_oper_type      => v_inp_oper_type,
                                    v_inp_oper_detail    => v_oper_detail,
                                    v_inp_oper_userid    => v_inp_oper_id,
                                    v_inp_oper_time      => v_inp_oper_time,
                                    v_inp_oper_source    => v_inp_oper_source,
                                    v_inp_rela_unqfield1 => v_inp_supplier_code,
                                    v_inp_rela_unqfield2 => v_inp_factory_code,
                                    v_inp_rela_unqfield3 => v_inp_category,
                                    v_inp_company_id     => v_inp_company_id,
                                    v_inp_invoke_object  => v_self_description);
    END IF;
  END p_capc_fac_procate_rate_cfg_operlog_ins;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       供应商产品子类占比配置操作日志新增
      
     入参:
       v_inp_supplier_code            :  供应商编码
       v_inp_category                 :  分类编码
       v_inp_product_cate             :  生产分类编码
       v_inp_subcategory              :  产品子类编码
       v_inp_old_allocate_percentage  :  旧分配比例
       v_inp_new_allocate_percentage  :  新分配比例
       v_inp_module_code              :  模块编码
       v_inp_module_name              :  模块名
       v_inp_program_code             :  程序编码
       v_inp_program_name             :  程序名
       v_inp_oper_id                  :  操作人Id
       v_inp_oper_type                :  操作类型
       v_inp_oper_time                :  操作时间
       v_inp_oper_source              :  操作源
       v_inp_company_id               :  企业Id
        
     版本:
       2023-06-12_zc314 : 供应商产品子类占比配置操作日志新增
      
  ==============================================================================*/
  PROCEDURE p_capc_sup_subcate_rate_cfg_operlog_ins
  (
    v_inp_supplier_code           IN VARCHAR2,
    v_inp_category                IN VARCHAR2,
    v_inp_product_cate            IN VARCHAR2,
    v_inp_subcategory             IN VARCHAR2,
    v_inp_old_allocate_percentage IN NUMBER,
    v_inp_new_allocate_percentage IN NUMBER,
    v_inp_oper_id                 IN VARCHAR2,
    v_inp_oper_type               IN VARCHAR2,
    v_inp_oper_time               IN DATE,
    v_inp_oper_source             IN VARCHAR2,
    v_inp_company_id              IN VARCHAR2
  ) IS
    v_jugnum           NUMBER(1);
    v_module_code      VARCHAR2(32) := 'CAPACITY_CONFIG';
    v_module_name      VARCHAR2(512) := '产能配置';
    v_program_code     VARCHAR2(32) := 'SUP_SUBCATE_RATE_INS';
    v_program_name     VARCHAR2(512) := '供应商产品子类占比新增';
    v_oper_detail      VARCHAR2(1024);
    v_self_description VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_capc_sup_subcate_rate_cfg_operlog_ins';
  BEGIN
    --是否存在操作日志判断
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capacity_operlog
     WHERE module_code = v_module_code
       AND program_code = v_program_code
       AND oper_type = v_inp_oper_type
       AND rela_unqfield1 = v_inp_supplier_code
       AND rela_unqfield2 = v_inp_category
       AND rela_unqfield3 = v_inp_product_cate
       AND oper_source = v_inp_oper_source
       AND oper_time = v_inp_oper_time
       AND company_id = v_inp_company_id;
  
    --不存在产能操作日志则新增
    IF v_jugnum = 0 THEN
      --操作源判定，操作信息赋值
      IF v_inp_oper_source = 'MANC' THEN
        --操作细节赋值
        v_oper_detail := f_gen_supsubcatecfg_operdetail(v_inp_product_cate        => v_inp_product_cate,
                                                        v_inp_subcategory         => v_inp_subcategory,
                                                        v_inp_old_allocatepercent => round(v_inp_old_allocate_percentage,
                                                                                           2),
                                                        v_inp_new_allocatepercent => round(v_inp_new_allocate_percentage,
                                                                                           2),
                                                        v_inp_company_id          => v_inp_company_id);
      ELSE
        --操作信息赋值
        v_oper_detail := '系统初始化';
      END IF;
    
      --操作日志新增
      p_tabapi_ins_capacity_operlog(v_inp_module_code    => v_module_code,
                                    v_inp_module_name    => v_module_name,
                                    v_inp_program_code   => v_program_code,
                                    v_inp_program_name   => v_program_name,
                                    v_inp_oper_type      => v_inp_oper_type,
                                    v_inp_oper_detail    => v_oper_detail,
                                    v_inp_oper_userid    => v_inp_oper_id,
                                    v_inp_oper_time      => v_inp_oper_time,
                                    v_inp_oper_source    => v_inp_oper_source,
                                    v_inp_rela_unqfield1 => v_inp_supplier_code,
                                    v_inp_rela_unqfield2 => v_inp_category,
                                    v_inp_rela_unqfield3 => v_inp_product_cate,
                                    v_inp_company_id     => v_inp_company_id,
                                    v_inp_invoke_object  => v_self_description);
    END IF;
  END p_capc_sup_subcate_rate_cfg_operlog_ins;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       产能配置-生产工厂生产类别占比配置新增
      
     入参:
       v_inp_supplier_code       :  供应商编码
       v_inp_factory_code        :  生产工厂编码
       v_inp_category            :  分类编码
       v_inp_product_cate        :  生产分类编码
       v_inp_allocate_percentage :  分配占比
       v_inp_create_id           :  创建人Id
       v_inp_create_time         :  创建时间
       v_inp_company_id          :  企业Id
       v_inp_invoke_object       :  调用对象
      
     版本:
       2023-06-12_zc314 : 产能配置-生产工厂生产类别占比配置新增
      
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capc_fac_procate_rate_cfg
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_pause               IN scmdata.t_capc_fac_procate_rate_cfg.pause%TYPE DEFAULT NULL,
    v_inp_create_id           IN scmdata.t_capc_fac_procate_rate_cfg.create_id%TYPE DEFAULT NULL,
    v_inp_create_time         IN scmdata.t_capc_fac_procate_rate_cfg.create_time%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_ins_capc_fac_procate_rate_cfg';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_capc_fac_procate_rate_cfg
  (cfprc_id, company_id, supplier_code, factory_code, category, 
   product_cate, allocate_percentage, pause, create_id, create_time)
VALUES
  (:v_inp_cfprc_id, :v_inp_company_id, :v_inp_supplier_code, :v_inp_factory_code, 
   :v_inp_category, :v_inp_product_cate, :v_inp_allocate_percentage, :v_inp_pause, 
   :v_inp_create_id, :v_inp_create_time)';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_cfprc_id, v_inp_company_id, v_inp_supplier_code, v_inp_factory_code, v_inp_category, v_inp_product_cate, v_inp_allocate_percentage, v_inp_pause, v_inp_create_id, v_inp_create_time;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql: ' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_cfprc_id: ' || v_inp_cfprc_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                      chr(10) || 'v_inp_supplier_code: ' ||
                      v_inp_supplier_code || chr(10) ||
                      'v_inp_factory_code: ' || v_inp_factory_code ||
                      chr(10) || 'v_inp_category: ' || v_inp_category ||
                      chr(10) || 'v_inp_product_cate: ' ||
                      v_inp_product_cate || chr(10) ||
                      'v_inp_allocate_percentage: ' ||
                      v_inp_allocate_percentage || chr(10) ||
                      'v_inp_pause: ' || v_inp_pause || chr(10) ||
                      'v_inp_create_id: ' || v_inp_create_id || chr(10) ||
                      'v_inp_create_time: ' || v_inp_create_time;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_create_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_ins_capc_fac_procate_rate_cfg;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       生成产能操作日志
    
     入参:
       v_inp_oper_userid  :  操作人Id
       v_inp_oper_time    :  操作时间
       v_inp_oper_detail  :  操作明细
       v_inp_company_id   :  企业Id
    
     版本:
       2023-04-25_zc314 : 生成产能操作日志
    
  ==============================================================================*/
  FUNCTION f_gen_capacity_operlog_msg
  (
    v_inp_oper_userid IN VARCHAR2,
    v_inp_oper_time   IN DATE,
    v_inp_oper_detail IN VARCHAR2,
    v_inp_company_id  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_operlog_info VARCHAR2(4000);
  BEGIN
    SELECT MAX(company_user_name) || '在' ||
           to_char(v_inp_oper_time, 'yyyy-mm-dd hh24-mi-ss') || '进行了【' ||
           v_inp_oper_detail || '】 操作'
      INTO v_operlog_info
      FROM scmdata.sys_company_user
     WHERE user_id = v_inp_oper_userid
       AND company_id = v_inp_company_id;
  
    RETURN v_operlog_info;
  END f_gen_capacity_operlog_msg;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       生成工厂生产分类占比操作日志
    
     入参:
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_old_allocatepercent  :  旧分配比例
       v_inp_new_allocatepercent  :  新分配比例
    
     版本:
       2023-04-25_zc314 : 生成工厂生产分类占比操作日志
    
  ==============================================================================*/
  FUNCTION f_gen_facprocatecfg_operdetail
  (
    v_inp_category            IN VARCHAR2,
    v_inp_product_cate        IN VARCHAR2,
    v_inp_old_allocatepercent IN NUMBER,
    v_inp_new_allocatepercent IN NUMBER
  ) RETURN VARCHAR2 IS
    v_productcate    VARCHAR2(32);
    v_operlog_detail VARCHAR2(4000);
  BEGIN
    --获取生产分类名称
    SELECT MAX(procdic.group_dict_name)
      INTO v_productcate
      FROM scmdata.sys_group_dict catedic
     INNER JOIN scmdata.sys_group_dict procdic
        ON catedic.group_dict_value = procdic.group_dict_type
     WHERE catedic.group_dict_type = 'PRODUCT_TYPE'
       AND catedic.group_dict_value = v_inp_category
       AND procdic.group_dict_value = v_inp_product_cate;
  
    --操作细节赋值
    v_operlog_detail := v_productcate || ': ' ||
                        to_char(v_inp_new_allocatepercent) || '%' ||
                        ' 【操作前: ' || to_char(v_inp_old_allocatepercent) || '%】';
  
    RETURN v_operlog_detail;
  END f_gen_facprocatecfg_operdetail;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       生成供应商产品子类占比操作日志
    
     入参:
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  生产分类编码
       v_inp_old_allocatepercent  :  旧分配比例
       v_inp_new_allocatepercent  :  新分配比例
       v_inp_company_id           :  企业Id
    
     版本:
       2023-05-25_zc314 : 生成供应商产品子类占比操作日志
    
  ==============================================================================*/
  FUNCTION f_gen_supsubcatecfg_operdetail
  (
    v_inp_product_cate        IN VARCHAR2,
    v_inp_subcategory         IN VARCHAR2,
    v_inp_old_allocatepercent IN NUMBER,
    v_inp_new_allocatepercent IN NUMBER,
    v_inp_company_id          IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_subcategory_name VARCHAR2(32);
    v_operlog_detail   VARCHAR2(4000);
  BEGIN
    --获取生产分类名称
    SELECT MAX(subcdic.company_dict_name)
      INTO v_subcategory_name
      FROM scmdata.sys_company_dict subcdic
     WHERE subcdic.company_dict_type = v_inp_product_cate
       AND subcdic.company_dict_value = v_inp_subcategory
       AND subcdic.company_id = v_inp_company_id;
  
    --操作细节赋值
    v_operlog_detail := v_subcategory_name || ': ' ||
                        to_char(v_inp_new_allocatepercent) || '%' ||
                        ' 【操作前: ' || to_char(v_inp_old_allocatepercent) || '%】';
  
    RETURN v_operlog_detail;
  END f_gen_supsubcatecfg_operdetail;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       产能配置-获取供应商产品子类占比配置信息
          
     入参:
       v_inp_cssrc_id             :  供应商编码
       v_inp_company_id           :  企业Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_infofrom             :  信息来源 NORMAL-业务表 VIEW-view表
     
     入出参: 
       v_iop_supplier_code        :  供应商编码
       v_iop_category             :  分类编码
       v_iop_product_cate         :  生产分类编码
       v_iop_subcategory          :  产品子类编码
       v_iop_old_allocate_percent :  分配比例
          
     版本:
       2023-06-12_zc314 : 产能配置-获取供应商产品子类占比配置信息
          
  ==============================================================================*/
  PROCEDURE p_get_capc_sup_subcate_rate_cfg_info
  (
    v_inp_cssrc_id             IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE,
    v_inp_company_id           IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE,
    v_inp_supplier_code        IN scmdata.t_capc_sup_subcate_rate_cfg.supplier_code%TYPE,
    v_inp_category             IN scmdata.t_capc_sup_subcate_rate_cfg.category%TYPE,
    v_inp_product_cate         IN scmdata.t_capc_sup_subcate_rate_cfg.product_cate%TYPE,
    v_inp_subcategory          IN scmdata.t_capc_sup_subcate_rate_cfg.subcategory%TYPE,
    v_inp_infofrom             IN VARCHAR2,
    v_iop_supplier_code        IN OUT scmdata.t_capc_sup_subcate_rate_cfg.supplier_code%TYPE,
    v_iop_category             IN OUT scmdata.t_capc_sup_subcate_rate_cfg.category%TYPE,
    v_iop_product_cate         IN OUT scmdata.t_capc_sup_subcate_rate_cfg.product_cate%TYPE,
    v_iop_subcategory          IN OUT scmdata.t_capc_sup_subcate_rate_cfg.subcategory%TYPE,
    v_iop_old_allocate_percent IN OUT scmdata.t_capc_sup_subcate_rate_cfg.allocate_percentage%TYPE
  ) IS
  
  BEGIN
    --信息来自业务表
    IF v_inp_infofrom = 'NORMAL' THEN
      --供应商编码不为空
      IF v_inp_supplier_code IS NOT NULL THEN
        SELECT MAX(supplier_code),
               MAX(category),
               MAX(product_cate),
               MAX(subcategory),
               MAX(allocate_percentage)
          INTO v_iop_supplier_code,
               v_iop_category,
               v_iop_product_cate,
               v_iop_subcategory,
               v_iop_old_allocate_percent
          FROM scmdata.t_capc_sup_subcate_rate_cfg
         WHERE supplier_code = v_inp_supplier_code
           AND category = v_inp_category
           AND product_cate = v_inp_product_cate
           AND subcategory = v_inp_subcategory
           AND company_id = v_inp_company_id;
      
        --供应商产品子类占比配置Id不为空
      ELSIF v_inp_cssrc_id IS NOT NULL THEN
        SELECT MAX(supplier_code),
               MAX(category),
               MAX(product_cate),
               MAX(subcategory),
               MAX(allocate_percentage)
          INTO v_iop_supplier_code,
               v_iop_category,
               v_iop_product_cate,
               v_iop_subcategory,
               v_iop_old_allocate_percent
          FROM scmdata.t_capc_sup_subcate_rate_cfg
         WHERE cssrc_id = v_inp_cssrc_id
           AND company_id = v_inp_company_id;
      END IF;
    
      --信息来自view表
    ELSIF v_inp_infofrom = 'VIEW' THEN
      --供应商编码不为空
      IF v_inp_supplier_code IS NOT NULL THEN
        SELECT MAX(supplier_code),
               MAX(category),
               MAX(product_cate),
               MAX(subcategory),
               MAX(allocate_percentage)
          INTO v_iop_supplier_code,
               v_iop_category,
               v_iop_product_cate,
               v_iop_subcategory,
               v_iop_old_allocate_percent
          FROM scmdata.t_capc_sup_subcate_rate_cfg_view
         WHERE supplier_code = v_inp_supplier_code
           AND category = v_inp_category
           AND product_cate = v_inp_product_cate
           AND subcategory = v_inp_subcategory
           AND company_id = v_inp_company_id;
      
        --供应商产品子类占比配置Id不为空
      ELSIF v_inp_cssrc_id IS NOT NULL THEN
        SELECT MAX(supplier_code),
               MAX(category),
               MAX(product_cate),
               MAX(subcategory),
               MAX(allocate_percentage)
          INTO v_iop_supplier_code,
               v_iop_category,
               v_iop_product_cate,
               v_iop_subcategory,
               v_iop_old_allocate_percent
          FROM scmdata.t_capc_sup_subcate_rate_cfg_view
         WHERE cssrc_id = v_inp_cssrc_id
           AND company_id = v_inp_company_id;
      END IF;
    END IF;
  END p_get_capc_sup_subcate_rate_cfg_info;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       产能配置-获取生产工厂生产类别占比配置信息
          
     入参:
       v_inp_cfprc_id              :  生产工厂生产类别占比配置Id
       v_inp_company_id            :  企业Id
       v_inp_supplier_code         :  供应商编码
       v_inp_factory_code          :  生产工厂编码
       v_inp_category              :  分类编码
       v_inp_product_cate          :  生产分类编码
       v_inp_infofrom              :  信息来源 NORMAL-业务表 VIEW-view表
      
     入出参:
       v_iop_supplier_code         :  供应商编码
       v_iop_factory_code          :  生产工厂编码
       v_iop_category              :  分类编码
       v_iop_product_cate          :  生产分类编码
       v_iop_old_allocate_percent  :  旧分配比例
          
     版本:
       2023-06-12_zc314 : 产能配置-获取生产工厂生产类别占比配置信息
          
  ==============================================================================*/
  PROCEDURE p_get_capc_fac_procate_rate_cfg_info
  (
    v_inp_cfprc_id             IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE,
    v_inp_company_id           IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE,
    v_inp_supplier_code        IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_inp_factory_code         IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_inp_category             IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_inp_product_cate         IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_inp_infofrom             IN VARCHAR2,
    v_iop_supplier_code        IN OUT scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_iop_factory_code         IN OUT scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_iop_category             IN OUT scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_iop_product_cate         IN OUT scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_iop_old_allocate_percent IN OUT NUMBER
  ) IS
  
  BEGIN
    --信息来自业务表
    IF v_inp_infofrom = 'NORMAL' THEN
      --供应商编码不为空 
      IF v_inp_supplier_code IS NOT NULL THEN
        SELECT MAX(supplier_code),
               MAX(factory_code),
               MAX(category),
               MAX(product_cate),
               MAX(allocate_percentage)
          INTO v_iop_supplier_code,
               v_iop_factory_code,
               v_iop_category,
               v_iop_product_cate,
               v_iop_old_allocate_percent
          FROM scmdata.t_capc_fac_procate_rate_cfg
         WHERE supplier_code = v_inp_supplier_code
           AND factory_code = v_inp_factory_code
           AND category = v_inp_category
           AND product_cate = v_inp_product_cate
           AND company_id = v_inp_company_id;
      
        --工厂生产分类占比配置Id不为空
      ELSIF v_inp_cfprc_id IS NOT NULL THEN
        SELECT MAX(supplier_code),
               MAX(factory_code),
               MAX(category),
               MAX(product_cate),
               MAX(allocate_percentage)
          INTO v_iop_supplier_code,
               v_iop_factory_code,
               v_iop_category,
               v_iop_product_cate,
               v_iop_old_allocate_percent
          FROM scmdata.t_capc_fac_procate_rate_cfg
         WHERE cfprc_id = v_inp_cfprc_id
           AND company_id = v_inp_company_id;
      END IF;
    
      --信息来自view表
    ELSIF v_inp_infofrom = 'VIEW' THEN
      --供应商编码不为空 
      IF v_inp_supplier_code IS NOT NULL THEN
        SELECT MAX(supplier_code),
               MAX(factory_code),
               MAX(category),
               MAX(product_cate),
               MAX(allocate_percentage)
          INTO v_iop_supplier_code,
               v_iop_factory_code,
               v_iop_category,
               v_iop_product_cate,
               v_iop_old_allocate_percent
          FROM scmdata.t_capc_fac_procate_rate_cfg_view
         WHERE supplier_code = v_inp_supplier_code
           AND factory_code = v_inp_factory_code
           AND category = v_inp_category
           AND product_cate = v_inp_product_cate
           AND company_id = v_inp_company_id;
      
        --工厂生产分类占比配置Id不为空
      ELSIF v_inp_cfprc_id IS NOT NULL THEN
        SELECT MAX(supplier_code),
               MAX(factory_code),
               MAX(category),
               MAX(product_cate),
               MAX(allocate_percentage)
          INTO v_iop_supplier_code,
               v_iop_factory_code,
               v_iop_category,
               v_iop_product_cate,
               v_iop_old_allocate_percent
          FROM scmdata.t_capc_fac_procate_rate_cfg_view
         WHERE cfprc_id = v_inp_cfprc_id
           AND company_id = v_inp_company_id;
      END IF;
    END IF;
  
  END p_get_capc_fac_procate_rate_cfg_info;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-根据主键进行生产工厂生产类别占比配置修改
    
     入参:
       v_inp_cfprc_id            :  生产工厂生产类别占比表Id
       v_inp_company_id          :  企业Id
       v_inp_allocate_percentage :  分配占比
       v_inp_update_id           :  修改人Id
       v_inp_update_time         :  修改时间
       v_inp_invoke_object       :  调用对象
    
     版本:
       2023-04-26_zc314 : 产能配置-根据主键进行生产工厂生产类别占比配置修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_fac_procate_rate_cfg_by_pk
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE,
    v_inp_update_id           IN scmdata.t_capc_fac_procate_rate_cfg.update_id%TYPE,
    v_inp_update_time         IN scmdata.t_capc_fac_procate_rate_cfg.update_time%TYPE,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_error_info          CLOB;
    v_sql                 CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := 'scmdata.pkg_capacity_management.p_gen_capc_fac_procate_rate_cfg;scmdata.pkg_capacity_management.p_tabapi_upd_capc_fac_procate_rate_cfg';
    v_self_description    VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_upd_capc_fac_procate_rate_cfg_by_pk';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'UPDATE scmdata.t_capc_fac_procate_rate_cfg
   SET allocate_percentage = :v_inp_allocate_percentage,
       update_id           = :v_inp_update_id,
       update_time         = :v_inp_update_time
 WHERE cfprc_id = :v_inp_cfprc_id
   AND company_id = :v_inp_company_id';
  
    --执行 Sql 
    EXECUTE IMMEDIATE v_sql
      USING v_inp_allocate_percentage, v_inp_update_id, v_inp_update_time, v_inp_cfprc_id, v_inp_company_id;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_cfprc_id: ' || v_inp_cfprc_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                      chr(10) || 'v_inp_allocate_percentage: ' ||
                      to_char(v_inp_allocate_percentage) || chr(10) ||
                      'v_inp_update_id: ' || v_inp_update_id || chr(10) ||
                      'v_inp_update_time: ' ||
                      to_char(v_inp_update_time, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_update_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_capc_fac_procate_rate_cfg_by_pk;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-根据唯一键进行生产工厂生产类别占比配置修改
    
     入参:
       v_inp_supplier_code       :  供应商编码
       v_inp_factory_code        :  生产工厂编码
       v_inp_category            :  分类编码
       v_inp_product_cate        :  生产分类编码
       v_inp_company_id          :  企业Id
       v_inp_allocate_percentage :  分配占比
       v_inp_update_id           :  修改人Id
       v_inp_update_time         :  修改时间
       v_inp_invoke_object       :  调用对象
    
     版本:
       2023-04-26_zc314 : 产能配置-根据唯一键进行生产工厂生产类别占比配置修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_fac_procate_rate_cfg_by_uk
  (
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE,
    v_inp_update_id           IN scmdata.t_capc_fac_procate_rate_cfg.update_id%TYPE,
    v_inp_update_time         IN scmdata.t_capc_fac_procate_rate_cfg.update_time%TYPE,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_error_info          CLOB;
    v_sql                 CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := 'scmdata.pkg_capacity_management.p_gen_capc_fac_procate_rate_cfg;scmdata.pkg_capacity_management.p_tabapi_upd_capc_fac_procate_rate_cfg';
    v_self_description    VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_upd_capc_fac_procate_rate_cfg_by_pk';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'UPDATE scmdata.t_capc_fac_procate_rate_cfg
   SET allocate_percentage = :v_inp_allocate_percentage,
       update_id           = :v_inp_update_id,
       update_time         = :v_inp_update_time
 WHERE supplier_code = :v_inp_supplier_code
   AND factory_code = :v_inp_factory_code
   AND category = :v_inp_category
   AND product_cate = :v_inp_product_cate
   AND company_id = :v_inp_company_id';
  
    --执行 Sql 
    EXECUTE IMMEDIATE v_sql
      USING v_inp_allocate_percentage, v_inp_update_id, v_inp_update_time, v_inp_supplier_code, v_inp_factory_code, v_inp_category, v_inp_product_cate, v_inp_company_id;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_supplier_code: ' ||
                      v_inp_supplier_code || chr(10) ||
                      'v_inp_factory_code: ' || v_inp_factory_code ||
                      chr(10) || 'v_inp_category: ' || v_inp_category ||
                      chr(10) || 'v_inp_product_cate: ' ||
                      v_inp_product_cate || chr(10) || 'v_inp_company_id: ' ||
                      v_inp_company_id || chr(10) ||
                      'v_inp_allocate_percentage: ' ||
                      to_char(v_inp_allocate_percentage) || chr(10) ||
                      'v_inp_update_id: ' || v_inp_update_id || chr(10) ||
                      'v_inp_update_time: ' ||
                      to_char(v_inp_update_time, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_update_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_capc_fac_procate_rate_cfg_by_uk;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置修改
    
     入参:
       v_inp_cfprc_id            :  生产工厂生产类别占比配置Id
       v_inp_supplier_code       :  供应商编码
       v_inp_factory_code        :  生产工厂编码
       v_inp_category            :  分类编码
       v_inp_product_cate        :  生产分类编码
       v_inp_allocate_percentage :  分配占比
       v_inp_update_id           :  修改人Id
       v_inp_update_time         :  修改时间
       v_inp_company_id          :  企业Id
       v_inp_invoke_object       :  调用对象
    
     版本:
       2023-04-26_zc314 : 产能配置-生产工厂生产类别占比配置修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_fac_procate_rate_cfg
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_update_id           IN scmdata.t_capc_fac_procate_rate_cfg.update_id%TYPE DEFAULT NULL,
    v_inp_update_time         IN scmdata.t_capc_fac_procate_rate_cfg.update_time%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    userdefine_exception  EXCEPTION;
    v_sql_errm            CLOB;
    v_allow_invoke_object CLOB := 'a_config_178_1_upd;scmdata.pkg_capacity_efflogic.p_capc_fac_procate_rate_cfg_efflogic';
    v_self_description    VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_upd_capc_fac_procate_rate_cfg';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE userdefine_exception;
    END IF;
  
    --更新策略
    IF v_inp_supplier_code IS NULL THEN
      p_tabapi_upd_capc_fac_procate_rate_cfg_by_pk(v_inp_cfprc_id            => v_inp_cfprc_id,
                                                   v_inp_company_id          => v_inp_company_id,
                                                   v_inp_allocate_percentage => v_inp_allocate_percentage,
                                                   v_inp_update_id           => v_inp_update_id,
                                                   v_inp_update_time         => v_inp_update_time,
                                                   v_inp_invoke_object       => v_self_description);
    ELSE
      p_tabapi_upd_capc_fac_procate_rate_cfg_by_uk(v_inp_supplier_code       => v_inp_supplier_code,
                                                   v_inp_factory_code        => v_inp_factory_code,
                                                   v_inp_category            => v_inp_category,
                                                   v_inp_product_cate        => v_inp_product_cate,
                                                   v_inp_company_id          => v_inp_company_id,
                                                   v_inp_allocate_percentage => v_inp_allocate_percentage,
                                                   v_inp_update_id           => v_inp_update_id,
                                                   v_inp_update_time         => v_inp_update_time,
                                                   v_inp_invoke_object       => v_self_description);
    END IF;
  EXCEPTION
    WHEN userdefine_exception THEN
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_capc_fac_procate_rate_cfg;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-生产工厂生产类别占比配置新增/修改
        
     入参:
       v_inp_cfprc_id            :  
       v_inp_company_id          :  企业Id
       v_inp_supplier_code       :  供应商编码
       v_inp_factory_code        :  生产工厂编码
       v_inp_category            :  分类编码
       v_inp_product_cate        :  生产分类编码
       v_inp_allocate_percentage :  分配占比
       v_inp_operate_id          :  操作人Id
       v_inp_operate_time        :  操作时间
       v_inp_oper_source         ： 操作数据源 SYSC-系统变更 MANC-人为变更
        
     版本:
       2023-06-12_zc314 : 产能配置-生产工厂生产类别占比配置新增/修改
        
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capc_fac_procate_rate_cfg
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg.allocate_percentage%TYPE,
    v_inp_pause               IN scmdata.t_capc_fac_procate_rate_cfg.pause%TYPE,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg.create_id%TYPE,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg.create_time%TYPE,
    v_inp_oper_source         IN VARCHAR2
  ) IS
    v_jugnum               NUMBER(1);
    v_supplier_code        VARCHAR2(32);
    v_factory_code         VARCHAR2(32);
    v_category             VARCHAR2(2);
    v_product_cate         VARCHAR2(4);
    v_oper_type            VARCHAR2(4);
    v_old_allocate_percent NUMBER;
    v_self_description     VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_iou_capc_fac_procate_rate_cfg';
  BEGIN
    --是否存在数据
    IF v_inp_supplier_code IS NULL THEN
      v_jugnum := f_is_capc_fac_procate_rate_exists_by_pk(v_inp_cfprc_id   => v_inp_cfprc_id,
                                                          v_inp_company_id => v_inp_company_id);
    ELSE
      v_jugnum := f_is_capc_fac_procate_rate_exists_by_uk(v_inp_supplier_code => v_inp_supplier_code,
                                                          v_inp_factory_code  => v_inp_factory_code,
                                                          v_inp_category      => v_inp_category,
                                                          v_inp_product_cate  => v_inp_product_cate,
                                                          v_inp_company_id    => v_inp_company_id);
    END IF;
  
    --获取工厂生产类别配置数据
    p_get_capc_fac_procate_rate_cfg_info(v_inp_cfprc_id             => v_inp_cfprc_id,
                                         v_inp_company_id           => v_inp_company_id,
                                         v_inp_supplier_code        => v_inp_supplier_code,
                                         v_inp_factory_code         => v_inp_factory_code,
                                         v_inp_category             => v_inp_category,
                                         v_inp_product_cate         => v_inp_product_cate,
                                         v_inp_infofrom             => 'NORMAL',
                                         v_iop_supplier_code        => v_supplier_code,
                                         v_iop_factory_code         => v_factory_code,
                                         v_iop_category             => v_category,
                                         v_iop_product_cate         => v_product_cate,
                                         v_iop_old_allocate_percent => v_old_allocate_percent);
  
    --判断
    IF v_jugnum = 0 THEN
      --操作类型赋值
      v_oper_type := 'INS';
      --新增
      p_tabapi_ins_capc_fac_procate_rate_cfg(v_inp_cfprc_id            => v_inp_cfprc_id,
                                             v_inp_company_id          => v_inp_company_id,
                                             v_inp_supplier_code       => v_inp_supplier_code,
                                             v_inp_factory_code        => v_inp_factory_code,
                                             v_inp_category            => v_inp_category,
                                             v_inp_product_cate        => v_inp_product_cate,
                                             v_inp_allocate_percentage => v_inp_allocate_percentage,
                                             v_inp_pause               => v_inp_pause,
                                             v_inp_create_id           => v_inp_operate_id,
                                             v_inp_create_time         => v_inp_operate_time,
                                             v_inp_invoke_object       => v_self_description);
    ELSE
      --操作类型赋值
      v_oper_type := 'UPD';
      --修改
      p_tabapi_upd_capc_fac_procate_rate_cfg(v_inp_cfprc_id            => v_inp_cfprc_id,
                                             v_inp_supplier_code       => v_inp_supplier_code,
                                             v_inp_factory_code        => v_inp_factory_code,
                                             v_inp_category            => v_inp_category,
                                             v_inp_product_cate        => v_inp_product_cate,
                                             v_inp_allocate_percentage => v_inp_allocate_percentage,
                                             v_inp_update_id           => v_inp_operate_id,
                                             v_inp_update_time         => v_inp_operate_time,
                                             v_inp_company_id          => v_inp_company_id,
                                             v_inp_invoke_object       => v_self_description);
    END IF;
  
    --日志数据新增
    p_capc_fac_procate_rate_cfg_operlog_ins(v_inp_supplier_code           => v_supplier_code,
                                            v_inp_factory_code            => v_factory_code,
                                            v_inp_category                => v_category,
                                            v_inp_product_cate            => v_product_cate,
                                            v_inp_old_allocate_percentage => v_old_allocate_percent,
                                            v_inp_new_allocate_percentage => v_inp_allocate_percentage,
                                            v_inp_oper_id                 => v_inp_operate_id,
                                            v_inp_oper_type               => v_oper_type,
                                            v_inp_oper_time               => v_inp_operate_time,
                                            v_inp_oper_source             => v_inp_oper_source,
                                            v_inp_company_id              => v_inp_company_id);
  END p_tabapi_iou_capc_fac_procate_rate_cfg;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-根据主键判断工厂生产分类占比配置是否存在
        
     入参:
       v_inp_cfprc_id    :  供应商编码
       v_inp_company_id  :  生产工厂编码
        
     版本:
       2023-05-05_zc314 : 产能配置-根据主键判断工厂生产分类占比配置是否存在
        
  ==============================================================================*/
  FUNCTION f_is_capc_fac_procate_rate_exists_by_pk
  (
    v_inp_cfprc_id   IN scmdata.t_capc_fac_procate_rate_cfg.cfprc_id%TYPE,
    v_inp_company_id IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    --获取结果
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capc_fac_procate_rate_cfg
     WHERE cfprc_id = v_inp_cfprc_id
       AND company_id = v_inp_company_id
       AND rownum = 1;
  
    --返回结果
    RETURN v_jugnum;
  END f_is_capc_fac_procate_rate_exists_by_pk;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-根据唯一键判断供应商产品子类占比配置是否存在
        
     入参:
       v_inp_supplier_code  :  供应商编码
       v_inp_factory_code   :  生产工厂编码
       v_inp_category       :  分类编码
       v_inp_product_cate   :  生产分类编码
       v_inp_company_id     :  企业Id
        
     版本:
       2023-06-12_zc314 : 产能配置-根据唯一键判断供应商产品子类占比配置是否存在
        
  ==============================================================================*/
  FUNCTION f_is_capc_fac_procate_rate_exists_by_uk
  (
    v_inp_supplier_code IN scmdata.t_capc_fac_procate_rate_cfg.supplier_code%TYPE,
    v_inp_factory_code  IN scmdata.t_capc_fac_procate_rate_cfg.factory_code%TYPE,
    v_inp_category      IN scmdata.t_capc_fac_procate_rate_cfg.category%TYPE,
    v_inp_product_cate  IN scmdata.t_capc_fac_procate_rate_cfg.product_cate%TYPE,
    v_inp_company_id    IN scmdata.t_capc_fac_procate_rate_cfg.company_id%TYPE
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    --获取结果
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capc_fac_procate_rate_cfg
     WHERE supplier_code = v_inp_supplier_code
       AND factory_code = v_inp_factory_code
       AND category = v_inp_category
       AND product_cate = v_inp_product_cate
       AND company_id = v_inp_company_id
       AND rownum = 1;
  
    --返回结果
    RETURN v_jugnum;
  END f_is_capc_fac_procate_rate_exists_by_uk;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表新增
    
     入参:
       v_inp_cfprcv_id            :  生产工厂生产类别占比配置view表Id
       v_inp_company_id           :  企业Id
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_factory_code         :  生产工厂编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_allocate_percentage  :  分配计算占比
       v_inp_pause                :  是否作废 0-正常 1-作废
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_invoke_object        :  调用对象
      
     版本: 
       2023-06-12_zc314 : 产能配置-生产工厂生产类别占比配置view表新增
    
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capc_fac_procate_rate_cfg_view
  (
    v_inp_cfprcv_id           IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprcv_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL,
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg_view.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg_view.factory_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg_view.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg_view.product_cate%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg_view.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_pause               IN scmdata.t_capc_fac_procate_rate_cfg_view.pause%TYPE DEFAULT NULL,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_time%TYPE DEFAULT NULL,
    v_inp_operate_method      IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_method%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception            EXCEPTION;
    v_sql                     CLOB;
    v_error_info              CLOB;
    v_sql_errm                VARCHAR2(512);
    v_allow_invoke_object     CLOB := '';
    v_self_description        VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_ins_capc_fac_procate_rate_cfg_view';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_capc_fac_procate_rate_cfg_view
  (cfprcv_id, company_id, cfprc_id, supplier_code, factory_code, 
   category, product_cate, allocate_percentage, pause, operate_id, 
   operate_time, operate_method)
VALUES
  (:v_inp_cfprcv_id, :v_inp_company_id, :v_inp_cfprc_id, :v_inp_supplier_code, 
   :v_inp_factory_code, :v_inp_category, :v_inp_product_cate, :v_inp_allocate_percentage, 
   :v_inp_pause, :v_inp_operate_id, :v_inp_operate_time, :v_inp_operate_method)';
  
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_cfprcv_id, v_inp_company_id, v_inp_cfprc_id, v_inp_supplier_code, v_inp_factory_code, v_inp_category, v_inp_product_cate, v_inp_allocate_percentage, v_inp_pause, v_inp_operate_id, v_inp_operate_time, v_inp_operate_method;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql: ' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_cfprcv_id: ' || v_inp_cfprcv_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                      chr(10) || 'v_inp_cfprc_id: ' || v_inp_cfprc_id ||
                      chr(10) || 'v_inp_supplier_code: ' ||
                      v_inp_supplier_code || chr(10) ||
                      'v_inp_factory_code: ' || v_inp_factory_code ||
                      chr(10) || 'v_inp_category: ' || v_inp_category ||
                      chr(10) || 'v_inp_product_cate: ' ||
                      v_inp_product_cate || chr(10) ||
                      'v_inp_allocate_percentage: ' ||
                      to_char(v_inp_allocate_percentage) || chr(10) ||
                      'v_inp_pause: ' || v_inp_pause || chr(10) ||
                      'v_inp_operate_id: ' || v_inp_operate_id || chr(10) ||
                      'v_inp_operate_time: ' ||
                      to_char(v_inp_operate_time, 'yyyy-mm-dd hh24-mi-ss') ||
                      chr(10) || 'v_inp_operate_method: ' ||
                      v_inp_operate_method;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_operate_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_ins_capc_fac_procate_rate_cfg_view;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表新增
    
     入参:
       v_inp_cfprcv_id            :  生产工厂生产类别占比配置view表Id
       v_inp_company_id           :  企业Id
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_factory_code         :  生产工厂编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_allocate_percentage  :  分配计算占比
       v_inp_pause                :  是否作废 0-正常 1-作废
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-05-06_zc314 : 产能配置-生产工厂生产类别占比配置view表新增
    
  ==============================================================================*/
  /*PROCEDURE p_tabapi_ins_capc_fac_procate_rate_cfg_view
    (
      v_inp_cfprcv_id           IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprcv_id%TYPE DEFAULT NULL,
      v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL,
      v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
      v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg_view.supplier_code%TYPE DEFAULT NULL,
      v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg_view.factory_code%TYPE DEFAULT NULL,
      v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg_view.category%TYPE DEFAULT NULL,
      v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg_view.product_cate%TYPE DEFAULT NULL,
      v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg_view.allocate_percentage%TYPE DEFAULT NULL,
      v_inp_pause               IN scmdata.t_capc_fac_procate_rate_cfg_view.pause%TYPE DEFAULT NULL,
      v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_id%TYPE DEFAULT NULL,
      v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_time%TYPE DEFAULT NULL,
      v_inp_operate_method      IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_method%TYPE DEFAULT NULL,
      v_inp_oper_source         IN VARCHAR2,
      v_inp_invoke_object       IN VARCHAR2
    ) IS
      priv_exception EXCEPTION;
      v_sql          CLOB;
      --v_oper_info               VARCHAR2(4000);
      v_error_info              CLOB;
      v_supplier_code           VARCHAR2(32);
      v_factory_code            VARCHAR2(32);
      v_category                VARCHAR2(2);
      v_product_cate            VARCHAR2(4);
      v_sql_errm                VARCHAR2(512);
      v_old_allocate_percentage NUMBER(5, 2);
      v_oper_detail             VARCHAR2(4000);
      v_allow_invoke_object     CLOB := '';
      v_self_description        VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_ins_capc_fac_procate_rate_cfg_view';
    BEGIN
      --访问控制
      IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
        v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                      v_self_description;
        RAISE priv_exception;
      END IF;
    
      --获取修改前的分配计算占比
      SELECT nvl(MAX(allocate_percentage), 0),
             MAX(supplier_code),
             MAX(factory_code),
             MAX(category),
             MAX(product_cate)
        INTO v_old_allocate_percentage,
             v_supplier_code,
             v_factory_code,
             v_category,
             v_product_cate
        FROM scmdata.t_capc_fac_procate_rate_cfg
       WHERE cfprc_id = v_inp_cfprc_id
         AND company_id = v_inp_company_id;
    
      --执行 Sql 赋值
      v_sql := 'INSERT INTO scmdata.t_capc_fac_procate_rate_cfg_view
    (cfprcv_id, company_id, cfprc_id, supplier_code, factory_code, 
     category, product_cate, allocate_percentage, pause, operate_id, 
     operate_time, operate_method)
  VALUES
    (:v_inp_cfprcv_id, :v_inp_company_id, :v_inp_cfprc_id, :v_inp_supplier_code, 
     :v_inp_factory_code, :v_inp_category, :v_inp_product_cate, :v_inp_allocate_percentage, 
     :v_inp_pause, :v_inp_operate_id, :v_inp_operate_time, :v_inp_operate_method)';
      --执行 Sql
      EXECUTE IMMEDIATE v_sql
        USING v_inp_cfprcv_id, v_inp_company_id, v_inp_cfprc_id, v_inp_supplier_code, v_inp_factory_code, v_inp_category, v_inp_product_cate, v_inp_allocate_percentage, v_inp_pause, v_inp_operate_id, v_inp_operate_time, v_inp_operate_method;
    
      --操作源判定，操作信息赋值
      IF v_inp_oper_source = 'MANC' THEN
        --操作细节赋值
        v_oper_detail := f_gen_facprocatecfg_operdetail(v_inp_category            => v_category,
                                                        v_inp_product_cate        => v_product_cate,
                                                        v_inp_old_allocatepercent => round(v_old_allocate_percentage,
                                                                                           2),
                                                        v_inp_new_allocatepercent => round(v_inp_allocate_percentage,
                                                                                           2));
        --操作信息赋值
        \*v_oper_info := f_gen_capacity_operlog_msg(v_inp_oper_userid => v_inp_operate_id,
        v_inp_oper_time   => v_inp_operate_time,
        v_inp_oper_detail => v_oper_detail,
        v_inp_company_id  => v_inp_company_id);*\
      ELSE
        --操作信息赋值
        v_oper_detail := '系统初始化';
      END IF;
    
      --产能操作日志新增
      p_tabapi_ins_capacity_operlog(v_inp_module_code    => 'CAPACITY_CONFIG',
                                    v_inp_module_name    => '产能配置',
                                    v_inp_program_code   => 'FAC_PROCATE_RATE_UPD',
                                    v_inp_program_name   => '生产工厂生产类别占比更新',
                                    v_inp_oper_type      => 'UPD',
                                    v_inp_oper_detail    => v_oper_detail,
                                    v_inp_oper_userid    => v_inp_operate_id,
                                    v_inp_oper_time      => v_inp_operate_time,
                                    v_inp_oper_source    => v_inp_oper_source,
                                    v_inp_rela_unqfield1 => v_supplier_code,
                                    v_inp_rela_unqfield2 => v_factory_code,
                                    v_inp_rela_unqfield3 => v_category,
                                    v_inp_company_id     => v_inp_company_id,
                                    v_inp_invoke_object  => v_self_description);
    EXCEPTION
      WHEN priv_exception THEN
        --抛出报错
        raise_application_error(-20002, v_sql_errm);
      WHEN OTHERS THEN
        --错误信息赋值
        v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
        v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                        'Error Info: ' || v_sql_errm || chr(10) ||
                        'Execute sql: ' || v_sql || chr(10) || 'Params: ' ||
                        chr(10) || 'v_inp_cfprcv_id: ' || v_inp_cfprcv_id ||
                        chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                        chr(10) || 'v_inp_cfprc_id: ' || v_inp_cfprc_id ||
                        chr(10) || 'v_inp_supplier_code: ' ||
                        v_inp_supplier_code || chr(10) ||
                        'v_inp_factory_code: ' || v_inp_factory_code ||
                        chr(10) || 'v_inp_category: ' || v_inp_category ||
                        chr(10) || 'v_inp_product_cate: ' ||
                        v_inp_product_cate || chr(10) ||
                        'v_inp_allocate_percentage: ' ||
                        to_char(v_inp_allocate_percentage) || chr(10) ||
                        'v_inp_pause: ' || v_inp_pause || chr(10) ||
                        'v_inp_operate_id: ' || v_inp_operate_id || chr(10) ||
                        'v_inp_operate_time: ' ||
                        to_char(v_inp_operate_time, 'yyyy-mm-dd hh24-mi-ss') ||
                        chr(10) || 'v_inp_operate_method: ' ||
                        v_inp_operate_method;
      
        --新增进入错误信息表
        scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                             v_inp_causeerruserid => v_inp_operate_id,
                                             v_inp_erroccurtime   => SYSDATE,
                                             v_inp_errinfo        => v_error_info,
                                             v_inp_compid         => v_inp_company_id);
      
        --抛出报错
        raise_application_error(-20002, v_sql_errm);
    END p_tabapi_ins_capc_fac_procate_rate_cfg_view;*/

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表修改
    
     入参:
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配计算占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_operate_method       :  操作方法: INS-新增 UPD-修改 DEL-删除
       v_inp_oper_source          :  操作源: SYSC-系统 MANC-手动
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-04-25_zc314 : 产能配置-生产工厂生产类别占比配置view表修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_fac_procate_rate_cfg_view_by_pk
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg_view.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_time%TYPE DEFAULT NULL,
    v_inp_operate_method      IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_method%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception            EXCEPTION;
    v_sql                     CLOB;
    v_error_info              CLOB;
    v_sql_errm                VARCHAR2(512);
    v_allow_invoke_object     CLOB := '';
    v_self_description        VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_upd_capc_fac_procate_rate_cfg_view_by_pk';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'UPDATE scmdata.t_capc_fac_procate_rate_cfg_view
   SET allocate_percentage = :v_inp_allocate_percentage,
       operate_id          = :v_inp_operate_id,
       operate_time        = :v_inp_operate_time,
       operate_method      = :v_inp_operate_method
 WHERE cfprc_id = :v_inp_cfprc_id
   AND company_id = :v_inp_company_id';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_allocate_percentage, v_inp_operate_id, v_inp_operate_time, v_inp_operate_method, v_inp_cfprc_id, v_inp_company_id;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_allocate_percentage: ' ||
                      to_char(v_inp_allocate_percentage) || chr(10) ||
                      'v_inp_operate_id: ' || v_inp_operate_id || chr(10) ||
                      'v_inp_operate_time: ' ||
                      to_char(v_inp_operate_time, 'yyyy-mm-dd hh24-mi-ss') ||
                      chr(10) || 'v_inp_operate_method: ' ||
                      v_inp_operate_method || chr(10) || 'v_inp_cfprc_id: ' ||
                      v_inp_cfprc_id || chr(10) || 'v_inp_company_id: ' ||
                      v_inp_company_id;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_operate_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_capc_fac_procate_rate_cfg_view_by_pk;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表是否存在
    
     入参:
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_company_id           :  企业Id
      
     版本:
       2023-04-27_zc314 : 产能配置-生产工厂生产类别占比配置view表是否存在
    
  ==============================================================================*/
  FUNCTION f_jugnum_capc_fac_procate_rate_cfg_view_exists
  (
    v_inp_cfprc_id   IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_company_id IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    --执行 Sql
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capc_fac_procate_rate_cfg_view
     WHERE cfprc_id = v_inp_cfprc_id
       AND company_id = v_inp_company_id;
  
    --返回判断值
    RETURN v_jugnum;
  END f_jugnum_capc_fac_procate_rate_cfg_view_exists;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-生产工厂生产类别占比配置view表新增/修改
    
     入参:
       v_inp_cfprc_id             :  生产工厂生产类别占比配置表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_factory_code         :  生产工厂编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_allocate_percentage  :  分配计算占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_company_id           :  企业Id
       v_inp_oper_source          :  操作源 SYSC-系统 MANC-手动
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-04-27_zc314 : 产能配置-生产工厂生产类别占比配置view表新增/修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capc_fac_procate_rate_cfg_view
  (
    v_inp_cfprc_id            IN scmdata.t_capc_fac_procate_rate_cfg_view.cfprc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_fac_procate_rate_cfg_view.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code        IN scmdata.t_capc_fac_procate_rate_cfg_view.factory_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_fac_procate_rate_cfg_view.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_fac_procate_rate_cfg_view.product_cate%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_fac_procate_rate_cfg_view.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_operate_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_fac_procate_rate_cfg_view.operate_time%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_fac_procate_rate_cfg_view.company_id%TYPE DEFAULT NULL,
    v_inp_oper_source         IN VARCHAR2,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    v_jugnum               NUMBER(1);
    v_supplier_code        VARCHAR2(32);
    v_factory_code         VARCHAR2(32);
    v_category             VARCHAR2(2);
    v_product_cate         VARCHAR2(4);
    v_oper_type            VARCHAR2(4);
    v_old_allocate_percent NUMBER;
  BEGIN
    --生产工厂生产类别占比配置view表是否存在判断
    v_jugnum := f_jugnum_capc_fac_procate_rate_cfg_view_exists(v_inp_cfprc_id   => v_inp_cfprc_id,
                                                               v_inp_company_id => v_inp_company_id);
  
    --获取工厂生产类别配置数据
    p_get_capc_fac_procate_rate_cfg_info(v_inp_cfprc_id             => v_inp_cfprc_id,
                                         v_inp_company_id           => v_inp_company_id,
                                         v_inp_supplier_code        => v_inp_supplier_code,
                                         v_inp_factory_code         => v_inp_factory_code,
                                         v_inp_category             => v_inp_category,
                                         v_inp_product_cate         => v_inp_product_cate,
                                         v_inp_infofrom             => 'VIEW',
                                         v_iop_supplier_code        => v_supplier_code,
                                         v_iop_factory_code         => v_factory_code,
                                         v_iop_category             => v_category,
                                         v_iop_product_cate         => v_product_cate,
                                         v_iop_old_allocate_percent => v_old_allocate_percent);
  
    --判断
    IF v_jugnum = 0 THEN
      --操作类型赋值
      v_oper_type := 'INS';
    
      --新增
      p_tabapi_ins_capc_fac_procate_rate_cfg_view(v_inp_cfprcv_id           => scmdata.f_get_uuid(),
                                                  v_inp_company_id          => v_inp_company_id,
                                                  v_inp_cfprc_id            => v_inp_cfprc_id,
                                                  v_inp_supplier_code       => v_inp_supplier_code,
                                                  v_inp_factory_code        => v_inp_factory_code,
                                                  v_inp_category            => v_inp_category,
                                                  v_inp_product_cate        => v_inp_product_cate,
                                                  v_inp_allocate_percentage => v_inp_allocate_percentage,
                                                  v_inp_pause               => 0,
                                                  v_inp_operate_id          => v_inp_operate_id,
                                                  v_inp_operate_time        => v_inp_operate_time,
                                                  v_inp_operate_method      => 'INS',
                                                  v_inp_invoke_object       => v_inp_invoke_object);
    ELSE
      --操作类型赋值
      v_oper_type := 'UPD';
    
      --修改
      p_tabapi_upd_capc_fac_procate_rate_cfg_view_by_pk(v_inp_cfprc_id            => v_inp_cfprc_id,
                                                        v_inp_company_id          => v_inp_company_id,
                                                        v_inp_allocate_percentage => v_inp_allocate_percentage,
                                                        v_inp_operate_id          => v_inp_operate_id,
                                                        v_inp_operate_time        => v_inp_operate_time,
                                                        v_inp_operate_method      => 'UPD',
                                                        v_inp_invoke_object       => v_inp_invoke_object);
    END IF;
  
    --日志数据新增
    p_capc_fac_procate_rate_cfg_operlog_ins(v_inp_supplier_code           => v_supplier_code,
                                            v_inp_factory_code            => v_factory_code,
                                            v_inp_category                => v_category,
                                            v_inp_product_cate            => v_product_cate,
                                            v_inp_old_allocate_percentage => v_old_allocate_percent,
                                            v_inp_new_allocate_percentage => v_inp_allocate_percentage,
                                            v_inp_oper_id                 => v_inp_operate_id,
                                            v_inp_oper_type               => v_oper_type,
                                            v_inp_oper_time               => v_inp_operate_time,
                                            v_inp_oper_source             => v_inp_oper_source,
                                            v_inp_company_id              => v_inp_company_id);
  END p_tabapi_iou_capc_fac_procate_rate_cfg_view;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
      产能配置-生产工厂生产类别占比配置0/100校验
    
     入参:
       v_inp_supplier_code        :  供应商编码
       v_inp_factory_code         :  生产工厂编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_cfprc_id             :  生产工厂生产类别占比配置Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配占比
      
     版本:
       2023-05-18_zc314 : 产能配置-生产工厂生产类别占比配置0/100校验
    
  ==============================================================================*/
  PROCEDURE p_tabapi_check_zerohundred_capc_fac_procate_rate_cfg
  (
    v_inp_supplier_code       IN VARCHAR2,
    v_inp_factory_code        IN VARCHAR2,
    v_inp_category            IN VARCHAR2,
    v_inp_cfprc_id            IN VARCHAR2,
    v_inp_company_id          IN VARCHAR2,
    v_inp_allocate_percentage IN NUMBER
  ) IS
    v_jugnum    NUMBER(1);
    v_check_num NUMBER(5, 2);
  BEGIN
    IF v_inp_allocate_percentage < 0
       AND v_inp_allocate_percentage > 100 THEN
      raise_application_error(-20002, '计算比例不能小于0%或者大于100%');
    END IF;
  
    SELECT nvl(MAX(1), 0),
           SUM(nvl(cfgview1.allocate_percentage, cfg1.allocate_percentage))
      INTO v_jugnum,
           v_check_num
      FROM scmdata.t_capc_fac_procate_rate_cfg cfg1
      LEFT JOIN scmdata.t_capc_fac_procate_rate_cfg_view cfgview1
        ON cfg1.cfprc_id = cfgview1.cfprc_id
       AND cfg1.company_id = cfgview1.company_id
     WHERE cfg1.supplier_code = v_inp_supplier_code
       AND cfg1.factory_code = v_inp_factory_code
       AND cfg1.category = v_inp_category
       AND cfg1.cfprc_id <> v_inp_cfprc_id
       AND cfg1.company_id = v_inp_company_id
       AND NOT EXISTS (SELECT 1
              FROM scmdata.t_capc_fac_procate_rate_cfg_view
             WHERE cfprc_id = cfg1.cfprc_id
               AND company_id = cfg1.company_id
               AND operate_method = 'DEL');
  
    --计算比例校验
    IF v_jugnum > 0 THEN
      IF nvl(v_check_num, 0) > 100 THEN
        raise_application_error(-20002, '计算比例之和不能大于100%！');
      END IF;
    END IF;
  END p_tabapi_check_zerohundred_capc_fac_procate_rate_cfg;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-供应商产品子类占比配置表新增
    
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  子类编码
       v_inp_allocate_percentage  :  分配占比
       v_inp_create_id            :  创建人Id
       v_inp_create_time          :  创建时间
       v_inp_company_id           :  企业Id
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-04-28_zc314 : 产能配置-供应商产品子类占比配置表新增
    
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capc_sup_subcate_rate_cfg
  (
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_sup_subcate_rate_cfg.supplier_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_sup_subcate_rate_cfg.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_sup_subcate_rate_cfg.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory         IN scmdata.t_capc_sup_subcate_rate_cfg.subcategory%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_create_id           IN scmdata.t_capc_sup_subcate_rate_cfg.create_id%TYPE DEFAULT NULL,
    v_inp_create_time         IN scmdata.t_capc_sup_subcate_rate_cfg.create_time%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := 'scmdata.pkg_capacity_management.p_gen_capc_sup_subcate_rate_cfg_data';
    v_self_description    VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_ins_capc_sup_subcate_rate_cfg';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_capc_sup_subcate_rate_cfg
  (cssrc_id, company_id, supplier_code, category, product_cate, 
   subcategory, allocate_percentage, create_id, create_time)
VALUES
  (:v_inp_cssrc_id, :v_inp_company_id, :v_inp_supplier_code, 
   :v_inp_category, :v_inp_product_cate, :v_inp_subcategory, 
   :v_inp_allocate_percentage, :v_inp_create_id, :v_inp_create_time)';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_cssrc_id, v_inp_company_id, v_inp_supplier_code, v_inp_category, v_inp_product_cate, v_inp_subcategory, v_inp_allocate_percentage, v_inp_create_id, v_inp_create_time;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql: ' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_cssrc_id: ' || v_inp_cssrc_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                      chr(10) || 'v_inp_supplier_code: ' ||
                      v_inp_supplier_code || chr(10) || 'v_inp_category: ' ||
                      v_inp_category || chr(10) || 'v_inp_product_cate: ' ||
                      v_inp_product_cate || chr(10) ||
                      'v_inp_subcategory: ' || v_inp_subcategory || chr(10) ||
                      'v_inp_allocate_percentage: ' ||
                      to_char(v_inp_allocate_percentage) || chr(10) ||
                      'v_inp_create_id: ' || v_inp_create_id || chr(10) ||
                      'v_inp_create_time: ' ||
                      to_char(v_inp_create_time, 'yyyy-mm-dd hh24-mi-ss');
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_create_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_ins_capc_sup_subcate_rate_cfg;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     过程名:
       产能配置-供应商产品子类占比配置表修改
    
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配占比
       v_inp_update_id            :  修改人Id
       v_inp_update_time          :  修改时间
       v_inp_invoke_object        :  调用对象
      
     版本:
       2023-04-28_zc314 : 产能配置-供应商产品子类占比配置表修改
    
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_sup_subcate_rate_cfg
  (
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_update_id           IN scmdata.t_capc_sup_subcate_rate_cfg.update_id%TYPE DEFAULT NULL,
    v_inp_update_time         IN scmdata.t_capc_sup_subcate_rate_cfg.update_time%TYPE DEFAULT NULL,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := '';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'UPDATE scmdata.t_capc_sup_subcate_rate_cfg
   SET allocate_percentage = :v_inp_allocate_percentage,
       update_id           = :v_inp_update_id,
       update_time         = :v_inp_update_time
 WHERE cssrc_id = :v_inp_cssrc_id
   AND company_id = :v_inp_company_id';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_allocate_percentage, v_inp_update_id, v_inp_update_time, v_inp_cssrc_id, v_inp_company_id;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_allocate_percentage: ' ||
                      to_char(v_inp_allocate_percentage) || chr(10) ||
                      'v_inp_update_id: ' || v_inp_update_id || chr(10) ||
                      'v_inp_update_time: ' ||
                      to_char(v_inp_update_time, 'yyyy-mm-dd hh24-mi-ss') ||
                      chr(10) || 'v_inp_cssrc_id: ' || v_inp_cssrc_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_update_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_capc_sup_subcate_rate_cfg;

  /*=============================================================================
    
     包：
       pkg_capacity_management(产能管理包)
    
     函数名:
       产能配置-获取供应商产品子类占比配置表是否存在判断值
    
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_company_id           :  企业Id
       
     返回值:
       Number 类型，返回值 0-不存在 1-存在
      
     版本:
       2023-04-28_zc314 : 产能配置-获取供应商产品子类占比配置表是否存在判断值
    
  ==============================================================================*/
  FUNCTION f_tabapi_is_capc_sup_subcate_rate_cfg_exists_pk
  (
    v_inp_cssrc_id   IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE DEFAULT NULL,
    v_inp_company_id IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE DEFAULT NULL
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    --获取结果
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capc_sup_subcate_rate_cfg
     WHERE cssrc_id = v_inp_cssrc_id
       AND company_id = v_inp_company_id
       AND rownum = 1;
  
    --返回结果
    RETURN v_jugnum;
  END f_tabapi_is_capc_sup_subcate_rate_cfg_exists_pk;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     函数名:
       产能配置-根据唯一键获取供应商产品子类占比配置表是否存在判断值
      
     入参:
       v_inp_supplier_code  :  供应商编码
       v_inp_category       :  分类编码
       v_inp_product_cate   :  生产分类编码
       v_inp_subcategory    :  产品子类编码
       v_inp_company_id     :  企业Id
         
     返回值:
       Number 类型，返回值 0-不存在 1-存在
        
     版本:
       2023-04-28_zc314 : 产能配置-根据唯一键获取供应商产品子类占比配置表是否存在判断值
      
  ==============================================================================*/
  FUNCTION f_tabapi_is_capc_sup_subcate_rate_cfg_exists_uk
  (
    v_inp_supplier_code IN scmdata.t_capc_sup_subcate_rate_cfg.supplier_code%TYPE,
    v_inp_category      IN scmdata.t_capc_sup_subcate_rate_cfg.category%TYPE,
    v_inp_product_cate  IN scmdata.t_capc_sup_subcate_rate_cfg.product_cate%TYPE,
    v_inp_subcategory   IN scmdata.t_capc_sup_subcate_rate_cfg.subcategory%TYPE,
    v_inp_company_id    IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    --获取结果
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capc_sup_subcate_rate_cfg
     WHERE supplier_code = v_inp_supplier_code
       AND category = v_inp_category
       AND product_cate = v_inp_product_cate
       AND subcategory = v_inp_subcategory
       AND company_id = v_inp_company_id
       AND rownum = 1;
  
    --返回结果
    RETURN v_jugnum;
  END f_tabapi_is_capc_sup_subcate_rate_cfg_exists_uk;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       产能配置-供应商产品子类占比配置表新增/修改
      
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  子类编码
       v_inp_allocate_percentage  :  分配占比
       v_inp_operate_userid       :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_company_id           :  企业Id
       v_inp_oper_source          :  操作源：SYSC-系统变更 MANC-人为变更
        
     版本:
       2023-06-12_zc314 : 产能配置-供应商产品子类占比配置表新增/修改
      
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capc_sup_subcate_rate_cfg
  (
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg.cssrc_id%TYPE DEFAULT NULL,
    v_inp_supplier_code       IN scmdata.t_capc_sup_subcate_rate_cfg.supplier_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_sup_subcate_rate_cfg.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_sup_subcate_rate_cfg.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory         IN scmdata.t_capc_sup_subcate_rate_cfg.subcategory%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg.allocate_percentage%TYPE DEFAULT NULL,
    v_inp_operate_userid      IN scmdata.t_capc_sup_subcate_rate_cfg.create_id%TYPE DEFAULT NULL,
    v_inp_operate_time        IN scmdata.t_capc_sup_subcate_rate_cfg.create_time%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg.company_id%TYPE DEFAULT NULL,
    v_inp_oper_source         IN VARCHAR2
  ) IS
    v_jugnum               NUMBER(1);
    v_supplier_code        VARCHAR2(32);
    v_category             VARCHAR2(2);
    v_product_cate         VARCHAR2(4);
    v_subcategory          VARCHAR2(8);
    v_oper_type            VARCHAR2(4);
    v_old_allocate_percent NUMBER;
    v_self_decription      VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_iou_capc_sup_subcate_rate_cfg';
  BEGIN
    --判断
    IF v_inp_supplier_code IS NOT NULL THEN
      v_jugnum := f_tabapi_is_capc_sup_subcate_rate_cfg_exists_uk(v_inp_supplier_code => v_inp_supplier_code,
                                                                  v_inp_category      => v_inp_category,
                                                                  v_inp_product_cate  => v_inp_product_cate,
                                                                  v_inp_subcategory   => v_inp_subcategory,
                                                                  v_inp_company_id    => v_inp_company_id);
    ELSE
      v_jugnum := f_tabapi_is_capc_sup_subcate_rate_cfg_exists_pk(v_inp_cssrc_id   => v_inp_cssrc_id,
                                                                  v_inp_company_id => v_inp_company_id);
    END IF;
  
    --获取供应商产品子类配置数据
    p_get_capc_sup_subcate_rate_cfg_info(v_inp_cssrc_id             => v_inp_cssrc_id,
                                         v_inp_company_id           => v_inp_company_id,
                                         v_inp_supplier_code        => v_inp_supplier_code,
                                         v_inp_category             => v_inp_category,
                                         v_inp_product_cate         => v_inp_product_cate,
                                         v_inp_subcategory          => v_inp_subcategory,
                                         v_inp_infofrom             => 'NORMAL',
                                         v_iop_supplier_code        => v_supplier_code,
                                         v_iop_category             => v_category,
                                         v_iop_product_cate         => v_product_cate,
                                         v_iop_subcategory          => v_subcategory,
                                         v_iop_old_allocate_percent => v_old_allocate_percent);
    --判断
    IF v_jugnum = 0 THEN
      --操作类型赋值
      v_oper_type := 'INS';
    
      --新增
      p_tabapi_ins_capc_sup_subcate_rate_cfg(v_inp_cssrc_id            => v_inp_cssrc_id,
                                             v_inp_supplier_code       => v_inp_supplier_code,
                                             v_inp_category            => v_inp_category,
                                             v_inp_product_cate        => v_inp_product_cate,
                                             v_inp_subcategory         => v_inp_subcategory,
                                             v_inp_allocate_percentage => v_inp_allocate_percentage,
                                             v_inp_create_id           => v_inp_operate_userid,
                                             v_inp_create_time         => v_inp_operate_time,
                                             v_inp_company_id          => v_inp_company_id,
                                             v_inp_invoke_object       => v_self_decription);
    ELSE
      --操作类型赋值
      v_oper_type := 'UPD';
    
      --修改
      p_tabapi_upd_capc_sup_subcate_rate_cfg(v_inp_cssrc_id            => v_inp_cssrc_id,
                                             v_inp_company_id          => v_inp_company_id,
                                             v_inp_allocate_percentage => v_inp_allocate_percentage,
                                             v_inp_update_id           => v_inp_operate_userid,
                                             v_inp_update_time         => v_inp_operate_time,
                                             v_inp_invoke_object       => v_self_decription);
    END IF;
  
    --供应商产品子类占比操作日志新增
    p_capc_sup_subcate_rate_cfg_operlog_ins(v_inp_supplier_code           => v_supplier_code,
                                            v_inp_category                => v_category,
                                            v_inp_product_cate            => v_product_cate,
                                            v_inp_subcategory             => v_subcategory,
                                            v_inp_old_allocate_percentage => v_old_allocate_percent,
                                            v_inp_new_allocate_percentage => v_inp_allocate_percentage,
                                            v_inp_oper_id                 => v_inp_operate_userid,
                                            v_inp_oper_type               => v_oper_type,
                                            v_inp_oper_time               => v_inp_operate_time,
                                            v_inp_oper_source             => v_inp_oper_source,
                                            v_inp_company_id              => v_inp_company_id);
  END p_tabapi_iou_capc_sup_subcate_rate_cfg;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       产能配置-供应商产品子类占比配置view表新增
      
     入参:
       v_inp_cssrcv_id            :  供应商产品子类占比配置表Id
       v_inp_company_id           :  企业Id
       v_inp_cssrc_id             :  供应商产品子类占比配置view表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_allocate_percentage  :  分配占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_operate_method       :  操作方法：INS-新增 UPD-修改 DEL-删除
       v_inp_oper_source          :  操作源： SYSC-系统 MANC-手动
       v_inp_invoke_object        :  调用对象
        
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置view表新增
      
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capc_sup_subcate_rate_cfg_view
  (
    v_inp_cssrcv_id           IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrcv_id%TYPE,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.company_id%TYPE,
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrc_id%TYPE,
    v_inp_supplier_code       IN scmdata.t_capc_sup_subcate_rate_cfg_view.supplier_code%TYPE,
    v_inp_category            IN scmdata.t_capc_sup_subcate_rate_cfg_view.category%TYPE,
    v_inp_product_cate        IN scmdata.t_capc_sup_subcate_rate_cfg_view.product_cate%TYPE,
    v_inp_subcategory         IN scmdata.t_capc_sup_subcate_rate_cfg_view.subcategory%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg_view.allocate_percentage%TYPE,
    v_inp_operate_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_id%TYPE,
    v_inp_operate_time        IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_time%TYPE,
    v_inp_operate_method      IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_method%TYPE,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_sql_errm            VARCHAR2(512);
    v_error_info          CLOB;
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_ins_capc_sup_subcate_rate_cfg_view';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_capc_sup_subcate_rate_cfg_view
  (cssrcv_id, company_id, cssrc_id, supplier_code, category, product_cate, 
   subcategory, allocate_percentage, operate_id, operate_time, operate_method)
VALUES
  (:v_inp_cssrcv_id, :v_inp_company_id, :v_inp_cssrc_id, :v_inp_supplier_code, 
   :v_inp_category, :v_inp_product_cate, :v_inp_subcategory, :v_inp_allocate_percentage, 
   :v_inp_operate_id, :v_inp_operate_time, :v_inp_operate_method)';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_cssrcv_id, v_inp_company_id, v_inp_cssrc_id, v_inp_supplier_code, v_inp_category, v_inp_product_cate, v_inp_subcategory, v_inp_allocate_percentage, v_inp_operate_id, v_inp_operate_time, v_inp_operate_method;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql: ' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_cssrcv_id: ' || v_inp_cssrcv_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                      chr(10) || 'v_inp_cssrc_id: ' || v_inp_cssrc_id ||
                      chr(10) || 'v_inp_supplier_code: ' ||
                      v_inp_supplier_code || chr(10) || 'v_inp_category: ' ||
                      v_inp_category || chr(10) || 'v_inp_product_cate: ' ||
                      v_inp_product_cate || chr(10) ||
                      'v_inp_subcategory: ' || v_inp_subcategory || chr(10) ||
                      'v_inp_allocate_percentage: ' ||
                      v_inp_allocate_percentage || chr(10) ||
                      'v_inp_operate_id: ' || v_inp_operate_id || chr(10) ||
                      'v_inp_operate_time: ' || v_inp_operate_time ||
                      chr(10) || 'v_inp_operate_method: ' ||
                      v_inp_operate_method;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_operate_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_ins_capc_sup_subcate_rate_cfg_view;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-供应商产品子类占比配置view表修改
        
     入参:
       v_inp_cssrc_id             :  供应商产品子类占比配置表Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_operate_method       :  操作方法：INS-新增 UPD-修改 DEL-删除
       v_inp_invoke_object        :  调用对象
          
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置view表修改
        
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capc_sup_subcate_rate_cfg_view
  (
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrc_id%TYPE,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.company_id%TYPE,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg_view.allocate_percentage%TYPE,
    v_inp_operate_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_id%TYPE,
    v_inp_operate_time        IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_time%TYPE,
    v_inp_operate_method      IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_method%TYPE,
    v_inp_invoke_object       IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_upd_capc_sup_subcate_rate_cfg_view';
  BEGIN
    --访问控制  
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'UPDATE scmdata.t_capc_sup_subcate_rate_cfg_view
   SET allocate_percentage = :v_inp_allocate_percentage,
       operate_id          = :v_inp_operate_id,
       operate_time        = :v_inp_operate_time,
       operate_method      = :v_inp_operate_method
 WHERE cssrc_id = :v_inp_cssrc_id
   AND company_id = :v_inp_company_id';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_allocate_percentage, v_inp_operate_id, v_inp_operate_time, v_inp_operate_method, v_inp_cssrc_id, v_inp_company_id;
  
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_allocate_percentage: ' ||
                      v_inp_allocate_percentage || chr(10) ||
                      'v_inp_operate_id: ' || v_inp_operate_id || chr(10) ||
                      'v_inp_operate_time: ' || v_inp_operate_time ||
                      chr(10) || 'v_inp_operate_method: ' ||
                      v_inp_operate_method || chr(10) || 'v_inp_cssrc_id: ' ||
                      v_inp_cssrc_id || chr(10) || 'v_inp_company_id: ' ||
                      v_inp_company_id;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => v_inp_operate_id,
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_capc_sup_subcate_rate_cfg_view;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     函数名:
       产能配置-判断供应商产品子类占比配置view表是否存在
          
     入参:
       v_inp_cssrc_id    :  供应商产品子类占比配置表Id
       v_inp_company_id  :  企业Id
            
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置view表是否存在
          
  ==============================================================================*/
  FUNCTION f_tabapi_is_capc_sup_subcate_rate_cfg_view_exists
  (
    v_inp_cssrc_id   IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrc_id%TYPE,
    v_inp_company_id IN scmdata.t_capc_sup_subcate_rate_cfg_view.company_id%TYPE
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    --获取结果
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capc_sup_subcate_rate_cfg_view
     WHERE cssrc_id = v_inp_cssrc_id
       AND company_id = v_inp_company_id
       AND rownum = 1;
  
    --返回结果
    RETURN v_jugnum;
  END f_tabapi_is_capc_sup_subcate_rate_cfg_view_exists;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
       产能配置-供应商产品子类占比配置view表新增
      
     入参:
       v_inp_cssrcv_id            :  供应商产品子类占比配置表Id
       v_inp_company_id           :  企业Id
       v_inp_cssrc_id             :  供应商产品子类占比配置view表Id
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_allocate_percentage  :  分配占比
       v_inp_operate_id           :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_oper_source          :  操作源：SYSC-系统 MANC-手动
        
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置view表新增
      
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capc_sup_subcate_rate_cfg_view
  (
    v_inp_cssrcv_id           IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrcv_id%TYPE DEFAULT NULL,
    v_inp_company_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.company_id%TYPE,
    v_inp_cssrc_id            IN scmdata.t_capc_sup_subcate_rate_cfg_view.cssrc_id%TYPE,
    v_inp_supplier_code       IN scmdata.t_capc_sup_subcate_rate_cfg_view.supplier_code%TYPE DEFAULT NULL,
    v_inp_category            IN scmdata.t_capc_sup_subcate_rate_cfg_view.category%TYPE DEFAULT NULL,
    v_inp_product_cate        IN scmdata.t_capc_sup_subcate_rate_cfg_view.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory         IN scmdata.t_capc_sup_subcate_rate_cfg_view.subcategory%TYPE DEFAULT NULL,
    v_inp_allocate_percentage IN scmdata.t_capc_sup_subcate_rate_cfg_view.allocate_percentage%TYPE,
    v_inp_operate_id          IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_id%TYPE,
    v_inp_operate_time        IN scmdata.t_capc_sup_subcate_rate_cfg_view.operate_time%TYPE,
    v_inp_oper_source         IN VARCHAR2
  ) IS
    v_jugnum               NUMBER(1);
    v_supplier_code        VARCHAR2(32);
    v_category             VARCHAR2(2);
    v_product_cate         VARCHAR2(4);
    v_subcategory          VARCHAR2(8);
    v_oper_type            VARCHAR2(4);
    v_old_allocate_percent NUMBER;
    v_self_description     VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_iou_capc_sup_subcate_rate_cfg_view';
  BEGIN
    --判断
    v_jugnum := f_tabapi_is_capc_sup_subcate_rate_cfg_view_exists(v_inp_cssrc_id   => v_inp_cssrc_id,
                                                                  v_inp_company_id => v_inp_company_id);
  
    --获取供应商产品子类占比配置信息
    p_get_capc_sup_subcate_rate_cfg_info(v_inp_cssrc_id             => v_inp_cssrc_id,
                                         v_inp_company_id           => v_inp_company_id,
                                         v_inp_supplier_code        => v_inp_supplier_code,
                                         v_inp_category             => v_inp_category,
                                         v_inp_product_cate         => v_inp_product_cate,
                                         v_inp_subcategory          => v_inp_subcategory,
                                         v_inp_infofrom             => 'VIEW',
                                         v_iop_supplier_code        => v_supplier_code,
                                         v_iop_category             => v_category,
                                         v_iop_product_cate         => v_product_cate,
                                         v_iop_subcategory          => v_subcategory,
                                         v_iop_old_allocate_percent => v_old_allocate_percent);
  
    --判断
    IF v_jugnum = 0 THEN
      --操作类型赋值
      v_oper_type := 'INS';
    
      --新增
      p_tabapi_ins_capc_sup_subcate_rate_cfg_view(v_inp_cssrcv_id           => v_inp_cssrcv_id,
                                                  v_inp_company_id          => v_inp_company_id,
                                                  v_inp_cssrc_id            => v_inp_cssrc_id,
                                                  v_inp_supplier_code       => v_inp_supplier_code,
                                                  v_inp_category            => v_inp_category,
                                                  v_inp_product_cate        => v_inp_product_cate,
                                                  v_inp_subcategory         => v_inp_subcategory,
                                                  v_inp_allocate_percentage => v_inp_allocate_percentage,
                                                  v_inp_operate_id          => v_inp_operate_id,
                                                  v_inp_operate_time        => v_inp_operate_time,
                                                  v_inp_operate_method      => v_oper_type,
                                                  v_inp_invoke_object       => v_self_description);
    ELSE
      --操作类型赋值
      v_oper_type := 'UPD';
    
      --修改
      p_tabapi_upd_capc_sup_subcate_rate_cfg_view(v_inp_cssrc_id            => v_inp_cssrc_id,
                                                  v_inp_company_id          => v_inp_company_id,
                                                  v_inp_allocate_percentage => v_inp_allocate_percentage,
                                                  v_inp_operate_id          => v_inp_operate_id,
                                                  v_inp_operate_time        => v_inp_operate_time,
                                                  v_inp_operate_method      => v_oper_type,
                                                  v_inp_invoke_object       => v_self_description);
    END IF;
  
    --供应商产品子类占比配置操作日志新增
    p_capc_sup_subcate_rate_cfg_operlog_ins(v_inp_supplier_code           => v_supplier_code,
                                            v_inp_category                => v_category,
                                            v_inp_product_cate            => v_product_cate,
                                            v_inp_subcategory             => v_subcategory,
                                            v_inp_old_allocate_percentage => v_old_allocate_percent,
                                            v_inp_new_allocate_percentage => v_inp_allocate_percentage,
                                            v_inp_oper_id                 => v_inp_operate_id,
                                            v_inp_oper_type               => v_oper_type,
                                            v_inp_oper_time               => v_inp_operate_time,
                                            v_inp_oper_source             => v_inp_oper_source,
                                            v_inp_company_id              => v_inp_company_id);
  END p_tabapi_iou_capc_sup_subcate_rate_cfg_view;

  /*=============================================================================
      
     包：
       pkg_capacity_management(产能管理包)
      
     过程名:
      产能配置-供应商产品子类占比配置0/100校验
      
     入参:
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_cssrc_id             :  供应商产品子类占比配置Id
       v_inp_company_id           :  企业Id
       v_inp_allocate_percentage  :  分配占比
        
     版本:
       2023-05-18_zc314 : 产能配置-供应商产品子类占比配置0/100校验
      
  ==============================================================================*/
  PROCEDURE p_tabapi_check_zerohundred_capc_sup_subcate_rate_cfg
  (
    v_inp_supplier_code       IN VARCHAR2,
    v_inp_category            IN VARCHAR2,
    v_inp_product_cate        IN VARCHAR2,
    v_inp_cssrc_id            IN VARCHAR2,
    v_inp_company_id          IN VARCHAR2,
    v_inp_allocate_percentage IN NUMBER
  ) IS
    v_jugnum    NUMBER(1);
    v_check_num NUMBER(5, 2);
  BEGIN
    IF v_inp_allocate_percentage < 0
       AND v_inp_allocate_percentage > 100
       AND v_inp_allocate_percentage IS NULL THEN
      raise_application_error(-20002,
                              '计算比例不能小于0%或者大于100%或者为空');
    END IF;
  
    SELECT COUNT(1),
           SUM(nvl(cfgview1.allocate_percentage,
                   nvl(cfg1.allocate_percentage, 0))) allocate_percentage
      INTO v_jugnum,
           v_check_num
      FROM scmdata.t_capc_sup_subcate_rate_cfg cfg1
      LEFT JOIN scmdata.t_capc_sup_subcate_rate_cfg_view cfgview1
        ON cfg1.cssrc_id = cfgview1.cssrc_id
       AND cfg1.company_id = cfgview1.company_id
     WHERE cfg1.supplier_code = v_inp_supplier_code
       AND cfg1.category = v_inp_category
       AND cfg1.product_cate = v_inp_product_cate
       AND cfg1.cssrc_id <> v_inp_cssrc_id
       AND cfg1.company_id = v_inp_company_id;
  
    --除当前数据无其他数据校验
    IF v_jugnum > 0 THEN
      --计算比例校验
      IF nvl(v_check_num, 0) + nvl(v_inp_allocate_percentage, 0) > 100 THEN
        raise_application_error(-20002, '计算比例之和不能大于100%！');
      END IF;
    END IF;
  
  END p_tabapi_check_zerohundred_capc_sup_subcate_rate_cfg;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     函数名:
       产能配置-获取工厂生产分类占比配置表数据生成sql
          
     入参:
       v_inp_supplier_code  :  供应商编码
       v_inp_factory_code   :  生产工厂编码
       v_inp_category       :  分类编码
       v_inp_product_cate   :  生产分类编码
       v_inp_company_id     :  企业Id
            
     版本:
       2023-05-05_zc314 : 产能配置-获取工厂生产分类占比配置表数据生成sql
          
  ==============================================================================*/
  FUNCTION f_get_capc_fac_procate_rate_cfg_datasql
  (
    v_inp_supplier_code IN VARCHAR2 DEFAULT NULL,
    v_inp_factory_code  IN VARCHAR2 DEFAULT NULL,
    v_inp_category      IN VARCHAR2 DEFAULT NULL,
    v_inp_product_cate  IN VARCHAR2 DEFAULT NULL,
    v_inp_company_id    IN VARCHAR2 DEFAULT NULL
  ) RETURN CLOB IS
    v_conds CLOB;
    v_sql   CLOB;
  BEGIN
    --供应商编码非空
    IF v_inp_supplier_code IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.supplier_code = ''' ||
                                                              v_inp_supplier_code ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --生产工厂编码非空
    IF v_inp_factory_code IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.factory_code = ''' ||
                                                              v_inp_factory_code ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --分类编码非空
    IF v_inp_category IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.coop_category = ''' ||
                                                              v_inp_category ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --生产分类编码非空
    IF v_inp_product_cate IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.coop_productcate = ''' ||
                                                              v_inp_product_cate ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --企业Id非空
    IF v_inp_company_id IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.company_id = ''' ||
                                                              v_inp_company_id ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --回传 Sql 赋值
    v_sql := 'SELECT supplier_code,
       factory_code,
       coop_category,
       coop_productcate,
       company_id,
       CASE
         WHEN nvl(MAX(delivery_amount_sfc), 0) = 0
              OR nvl(MAX(delivery_amount_sfcp), 0) = 0 THEN
          0
         ELSE
          nvl(MAX(delivery_amount_sfcp), 0) /
          nvl(MAX(delivery_amount_sfc), 0) * 100
       END allocate_percentage
  FROM (SELECT DISTINCT supplier_code,
                        factory_code,
                        coop_category,
                        coop_productcate,
                        company_id,
                        SUM(delivery_amount) over(PARTITION BY supplier_code, factory_code, coop_category, coop_productcate) delivery_amount_sfcp,
                        SUM(delivery_amount) over(PARTITION BY supplier_code, factory_code, coop_category) delivery_amount_sfc
          FROM (SELECT info1.supplier_code,
                       info1.factory_code,
                       info1.coop_category,
                       info1.coop_productcate,
                       info1.coop_subcategory,
                       info1.company_id,
                       decode(info1.pause,
                              0,
                              nvl(info2.delivery_amount, 0),
                              0) delivery_amount
                  FROM (SELECT csc.supplier_code,
                               cfc.factory_code,
                               csc.coop_category,
                               csc.coop_productcate,
                               csc.coop_subcategory,
                               csc.company_id,
                               sign(nvl(csc.pause, 1) + nvl(cfc.pause, 1) +
                                    decode(nvl(cpcc.in_planning, 0), 1, 0, 1)) pause
                          FROM scmdata.t_coopcate_supplier_cfg csc
                          LEFT JOIN scmdata.t_coopcate_factory_cfg cfc
                            ON csc.csc_id = cfc.csc_id
                           AND csc.company_id = cfc.company_id
                          LEFT JOIN scmdata.t_capacity_plan_category_cfg cpcc
                            ON csc.coop_category = cpcc.category
                           AND csc.coop_productcate = cpcc.product_cate
                           AND csc.coop_subcategory = cpcc.subcategory
                           AND csc.company_id = cpcc.company_id) info1
                  LEFT JOIN (SELECT DISTINCT orded.supplier_code,
                                            ords.factory_code,
                                            goo.category,
                                            goo.product_cate,
                                            goo.samll_category,
                                            dr.company_id,
                                            dr.delivery_amount
                              FROM scmdata.t_delivery_record dr
                              LEFT JOIN scmdata.t_commodity_info goo
                                ON dr.goo_id = goo.goo_id
                               AND dr.company_id = goo.company_id
                              LEFT JOIN scmdata.t_asnordered asned
                                ON dr.asn_id = asned.asn_id
                               AND dr.company_id = asned.company_id
                              LEFT JOIN scmdata.t_ordered orded
                                ON asned.order_id = orded.order_code
                               AND asned.company_id = orded.company_id
                              LEFT JOIN scmdata.t_orders ords
                                ON orded.order_code = ords.order_id
                               AND orded.company_id = ords.company_id
                             WHERE dr.delivery_date BETWEEN
                                   trunc(add_months(trunc(SYSDATE), -1), ''mm'') AND
                                   trunc(add_months(trunc(SYSDATE), 0), ''mm'')
                               AND orded.supplier_code IS NOT NULL
                               AND ords.factory_code IS NOT NULL
                               AND goo.category IS NOT NULL
                               AND goo.product_cate IS NOT NULL) info2
                    ON info1.supplier_code = info2.supplier_code
                   AND info1.factory_code = info2.factory_code
                   AND info1.coop_category = info2.category
                   AND info1.coop_productcate = info2.product_cate
                   AND info1.coop_subcategory = info2.samll_category
                   AND info1.company_id = info2.company_id
                 WHERE ' || v_conds || '))
 GROUP BY supplier_code,
          factory_code,
          coop_category,
          coop_productcate,
          company_id';
  
    --dbms_output.put_line(v_sql);
  
    RETURN v_sql;
  END f_get_capc_fac_procate_rate_cfg_datasql;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       产能配置-工厂产品子类占比配置表数据生成
          
     入参:
       v_inp_supplier_code    :  供应商编码
       v_inp_factory_code     :  生产工厂编码
       v_inp_category         :  分类编码 
       v_inp_product_cate     :  生产分类编码
       v_inp_company_id       :  企业Id
       v_inp_operate_userid   :  操作人Id
       v_inp_operate_time     :  操作时间
       v_inp_generate_mode    :  生成模式 IU-增改 I-增
            
     版本:
       2023-05-06_zc314 : 产能配置-工厂产品子类占比配置表数据生成
          
  ==============================================================================*/
  PROCEDURE p_gen_capc_fac_procate_rate_cfg_data
  (
    v_inp_supplier_code  IN VARCHAR2 DEFAULT NULL,
    v_inp_factory_code   IN VARCHAR2 DEFAULT NULL,
    v_inp_category       IN VARCHAR2 DEFAULT NULL,
    v_inp_product_cate   IN VARCHAR2 DEFAULT NULL,
    v_inp_company_id     IN VARCHAR2 DEFAULT NULL,
    v_inp_operate_userid IN VARCHAR2,
    v_inp_operate_time   IN DATE,
    v_inp_generate_mode  IN VARCHAR2
  ) IS
    TYPE refcur IS REF CURSOR;
    cu    refcur;
    v_sql CLOB;
    --v_jugnum           NUMBER(1);
    v_supplier_code    VARCHAR2(32);
    v_factory_code     VARCHAR2(32);
    v_category         VARCHAR2(2);
    v_product_cate     VARCHAR2(4);
    v_company_id       VARCHAR2(32);
    v_allocate_percent NUMBER(5, 2);
    v_cfprc_id         VARCHAR2(32);
    --v_self_decription  VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_gen_capc_sup_subcate_rate_cfg_data';
  BEGIN
    --数据 Sql 获取
    v_sql := f_get_capc_fac_procate_rate_cfg_datasql(v_inp_supplier_code => v_inp_supplier_code,
                                                     v_inp_factory_code  => v_inp_factory_code,
                                                     v_inp_category      => v_inp_category,
                                                     v_inp_product_cate  => v_inp_product_cate,
                                                     v_inp_company_id    => v_inp_company_id);
  
    IF v_sql IS NOT NULL THEN
      --开启动态游标
      OPEN cu FOR v_sql;
      LOOP
        BEGIN
          --赋值
          FETCH cu
            INTO v_supplier_code,
                 v_factory_code,
                 v_category,
                 v_product_cate,
                 v_company_id,
                 v_allocate_percent;
        
          --游标为空退出
          EXIT WHEN cu%NOTFOUND;
        
          --排除游标内第一次值获取就为空问题
          IF v_supplier_code IS NOT NULL THEN
            --Id赋值
            v_cfprc_id := scmdata.f_get_uuid();
          
            --操作模式判断
            IF v_inp_generate_mode = 'IU'
               OR v_inp_generate_mode = 'I' THEN
              --增改
              p_tabapi_iou_capc_fac_procate_rate_cfg(v_inp_cfprc_id            => v_cfprc_id,
                                                     v_inp_company_id          => v_company_id,
                                                     v_inp_supplier_code       => v_supplier_code,
                                                     v_inp_factory_code        => v_factory_code,
                                                     v_inp_category            => v_category,
                                                     v_inp_product_cate        => v_product_cate,
                                                     v_inp_allocate_percentage => v_allocate_percent,
                                                     v_inp_pause               => 0,
                                                     v_inp_operate_id          => v_inp_operate_userid,
                                                     v_inp_operate_time        => v_inp_operate_time,
                                                     v_inp_oper_source         => 'SYSC');
            END IF;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            --继续循环
            CONTINUE;
        END;
      END LOOP;
    
      --关闭动态游标
      CLOSE cu;
    END IF;
  END p_gen_capc_fac_procate_rate_cfg_data;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       产能配置-获取供应商产品子类占比配置表数据生成sql
        
     入参:
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_company_id           :  企业Id
          
     版本:
       2023-05-05_zc314 : 产能配置-获取供应商产品子类占比配置表数据生成sql
        
  ==============================================================================*/
  FUNCTION f_get_capc_sup_subcate_rate_cfg_datasql
  (
    v_inp_supplier_code IN VARCHAR2 DEFAULT NULL,
    v_inp_category      IN VARCHAR2 DEFAULT NULL,
    v_inp_product_cate  IN VARCHAR2 DEFAULT NULL,
    v_inp_subcategory   IN VARCHAR2 DEFAULT NULL,
    v_inp_company_id    IN VARCHAR2 DEFAULT NULL
  ) RETURN CLOB IS
    v_conds CLOB;
    v_sql   CLOB;
  BEGIN
    --供应商编码非空
    IF v_inp_supplier_code IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.supplier_code = ''' ||
                                                              v_inp_supplier_code ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --分类编码非空
    IF v_inp_category IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.coop_category = ''' ||
                                                              v_inp_category ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --生产分类编码非空
    IF v_inp_product_cate IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.coop_productcate = ''' ||
                                                              v_inp_product_cate ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --产品子类编码非空
    IF v_inp_subcategory IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.coop_subcategory = ''' ||
                                                              v_inp_subcategory ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --企业Id非空
    IF v_inp_company_id IS NOT NULL THEN
      v_conds := scmdata.f_sentence_append_rc(v_sentence   => v_conds,
                                              v_appendstr  => ' info1.company_id = ''' ||
                                                              v_inp_company_id ||
                                                              ''' ',
                                              v_middliestr => ' and ');
    END IF;
  
    --回传 Sql 赋值
    v_sql := 'SELECT supplier_code,
       coop_category,
       coop_productcate,
       coop_subcategory,
       company_id,
       CASE
         WHEN nvl(MAX(delivery_amount_scp), 0) = 0
              OR nvl(MAX(delivery_amount_scps), 0) = 0 THEN
          0
         ELSE
          nvl(MAX(delivery_amount_scps), 0) /
          nvl(MAX(delivery_amount_scp), 0) * 100
       END allocate_percentage
  FROM (SELECT DISTINCT supplier_code,
                        coop_category,
                        coop_productcate,
                        coop_subcategory,
                        company_id,
                        SUM(delivery_amount) over(PARTITION BY supplier_code, coop_category, coop_productcate, coop_subcategory) delivery_amount_scps,
                        SUM(delivery_amount) over(PARTITION BY supplier_code, coop_category, coop_productcate) delivery_amount_scp
          FROM (SELECT info1.supplier_code,
                       info1.factory_code,
                       info1.coop_category,
                       info1.coop_productcate,
                       info1.coop_subcategory,
                       info1.company_id,
                       decode(info1.pause,
                              0,
                              nvl(info2.delivery_amount, 0),
                              0) delivery_amount
                  FROM (SELECT csc.supplier_code,
                               cfc.factory_code,
                               csc.coop_category,
                               csc.coop_productcate,
                               csc.coop_subcategory,
                               csc.company_id,
                               sign(nvl(csc.pause, 1) + nvl(cfc.pause, 1) +
                                    decode(nvl(cpcc.in_planning, 0), 1, 0, 1)) pause
                          FROM scmdata.t_coopcate_supplier_cfg csc
                          LEFT JOIN scmdata.t_coopcate_factory_cfg cfc
                            ON csc.csc_id = cfc.csc_id
                           AND csc.company_id = cfc.company_id
                          LEFT JOIN scmdata.t_capacity_plan_category_cfg cpcc
                            ON csc.coop_category = cpcc.category
                           AND csc.coop_productcate = cpcc.product_cate
                           AND csc.coop_subcategory = cpcc.subcategory
                           AND csc.company_id = cpcc.company_id) info1
                  LEFT JOIN (SELECT DISTINCT orded.supplier_code,
                                            ords.factory_code,
                                            goo.category,
                                            goo.product_cate,
                                            goo.samll_category,
                                            dr.company_id,
                                            dr.delivery_amount
                              FROM scmdata.t_delivery_record dr
                              LEFT JOIN scmdata.t_commodity_info goo
                                ON dr.goo_id = goo.goo_id
                               AND dr.company_id = goo.company_id
                              LEFT JOIN scmdata.t_asnordered asned
                                ON dr.asn_id = asned.asn_id
                               AND dr.company_id = asned.company_id
                              LEFT JOIN scmdata.t_ordered orded
                                ON asned.order_id = orded.order_code
                               AND asned.company_id = orded.company_id
                              LEFT JOIN scmdata.t_orders ords
                                ON orded.order_code = ords.order_id
                               AND orded.company_id = ords.company_id
                             WHERE dr.delivery_date BETWEEN
                                   trunc(add_months(trunc(SYSDATE), -1), ''mm'') AND
                                   trunc(add_months(trunc(SYSDATE), 0), ''mm'')
                               AND orded.supplier_code IS NOT NULL
                               AND ords.factory_code IS NOT NULL
                               AND goo.category IS NOT NULL
                               AND goo.product_cate IS NOT NULL) info2
                    ON info1.supplier_code = info2.supplier_code
                   AND info1.factory_code = info2.factory_code
                   AND info1.coop_category = info2.category
                   AND info1.coop_productcate = info2.product_cate
                   AND info1.coop_subcategory = info2.samll_category
                   AND info1.company_id = info2.company_id
                 WHERE ' || v_conds || '))
 GROUP BY supplier_code,
          coop_category,
          coop_productcate,
          coop_subcategory,
          company_id';
  
    --dbms_output.put_line(v_sql);
  
    --返回回传 Sql
    RETURN v_sql;
  END f_get_capc_sup_subcate_rate_cfg_datasql;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       产能配置-供应商产品子类占比配置表数据生成
          
     入参:
       v_inp_supplier_code        :  供应商编码
       v_inp_category             :  分类编码 
       v_inp_product_cate         :  生产分类编码
       v_inp_subcategory          :  产品子类编码
       v_inp_company_id           :  企业Id
       v_inp_operate_userid       :  操作人Id
       v_inp_operate_time         :  操作时间
       v_inp_generate_mode        :  生成模式 IU-增改 I-增
            
     版本:
       2023-05-05_zc314 : 产能配置-供应商产品子类占比配置表数据生成
          
  ==============================================================================*/
  PROCEDURE p_gen_capc_sup_subcate_rate_cfg_data
  (
    v_inp_supplier_code  IN VARCHAR2 DEFAULT NULL,
    v_inp_category       IN VARCHAR2 DEFAULT NULL,
    v_inp_product_cate   IN VARCHAR2 DEFAULT NULL,
    v_inp_subcategory    IN VARCHAR2 DEFAULT NULL,
    v_inp_company_id     IN VARCHAR2 DEFAULT NULL,
    v_inp_operate_userid IN VARCHAR2,
    v_inp_operate_time   IN DATE,
    v_inp_generate_mode  IN VARCHAR2
  ) IS
    TYPE refcur IS REF CURSOR;
    cu    refcur;
    v_sql CLOB;
    --v_jugnum           NUMBER(1);
    v_supplier_code    VARCHAR2(32);
    v_category         VARCHAR2(2);
    v_product_cate     VARCHAR2(4);
    v_subcategory      VARCHAR2(8);
    v_company_id       VARCHAR2(32);
    v_allocate_percent NUMBER(5, 2);
    v_cssrc_id         VARCHAR2(32);
    --v_self_decription  VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_gen_capc_sup_subcate_rate_cfg_data';
  BEGIN
    --数据 Sql 获取
    v_sql := f_get_capc_sup_subcate_rate_cfg_datasql(v_inp_supplier_code => v_inp_supplier_code,
                                                     v_inp_category      => v_inp_category,
                                                     v_inp_product_cate  => v_inp_product_cate,
                                                     v_inp_subcategory   => v_inp_subcategory,
                                                     v_inp_company_id    => v_inp_company_id);
  
    --开启动态游标
    OPEN cu FOR v_sql;
    LOOP
      BEGIN
        --赋值
        FETCH cu
          INTO v_supplier_code,
               v_category,
               v_product_cate,
               v_subcategory,
               v_company_id,
               v_allocate_percent;
      
        --游标为空退出
        EXIT WHEN cu%NOTFOUND;
      
        --排除游标内第一次值获取就为空问题
        IF v_supplier_code IS NOT NULL THEN
          --Id赋值
          v_cssrc_id := scmdata.f_get_uuid();
        
          --操作模式判断
          IF v_inp_generate_mode = 'IU'
             OR v_inp_generate_mode = 'I' THEN
            --增改
            p_tabapi_iou_capc_sup_subcate_rate_cfg(v_inp_cssrc_id            => v_cssrc_id,
                                                   v_inp_supplier_code       => v_supplier_code,
                                                   v_inp_category            => v_category,
                                                   v_inp_product_cate        => v_product_cate,
                                                   v_inp_subcategory         => v_subcategory,
                                                   v_inp_allocate_percentage => v_allocate_percent,
                                                   v_inp_operate_userid      => v_inp_operate_userid,
                                                   v_inp_operate_time        => v_inp_operate_time,
                                                   v_inp_company_id          => v_company_id,
                                                   v_inp_oper_source         => 'SYSC');
          END IF;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          --继续循环
          CONTINUE;
      END;
    END LOOP;
  
    --关闭动态游标
    CLOSE cu;
  END p_gen_capc_sup_subcate_rate_cfg_data;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       供应商周产能规划(件数)基表新增
        
     入参:
       v_inp_cwpnb_id                       :  供应商周产能规划(件数)基表Id
       v_inp_company_id                     :  企业Id
       v_inp_supplier_code                  :  供应商编码
       v_inp_factory_code                   :  生产工厂编码
       v_inp_category                       :  分类编码
       v_inp_product_cate                   :  生产分类编码
       v_inp_subcategory                    :  产品子类编码
       v_inp_calculate_day                  :  计算日期
       v_inp_sfcpallocate_percentage        :  供应商-生产工厂-分类-生产分类分配占比
       v_inp_scpsallocate_percentage        :  供应商-分类-生产分类-产品子类分配占比
       v_inp_sfcps_allocapcp_ceiling_t      :  产品子类比例分配后产能上限(工时)
       v_inp_sfcps_allocapcp_appointment_t  :  生产分类比例分配后约定产能(工时)
       v_inp_sfcps_allocapcp_ceiling_p      :  产品子类比例分配后产能上限(件数)
       v_inp_sfcps_allocapcp_appointment_p  :  产品子类比例分配后约定产能(件数)
       v_inp_invoke_object                  :  调用对象
          
     版本:
       2023-05-11_zc314 : 供应商周产能规划(件数)基表新增
        
  ==============================================================================*/
  PROCEDURE p_tabapi_ins_capacity_weekplan_numpieces_base
  (
    v_inp_cwpnb_id                      IN scmdata.t_capacity_weekplan_numpieces_base.cwpnb_id%TYPE DEFAULT NULL,
    v_inp_company_id                    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL,
    v_inp_supplier_code                 IN scmdata.t_capacity_weekplan_numpieces_base.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code                  IN scmdata.t_capacity_weekplan_numpieces_base.factory_code%TYPE DEFAULT NULL,
    v_inp_category                      IN scmdata.t_capacity_weekplan_numpieces_base.category%TYPE DEFAULT NULL,
    v_inp_product_cate                  IN scmdata.t_capacity_weekplan_numpieces_base.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory                   IN scmdata.t_capacity_weekplan_numpieces_base.subcategory%TYPE DEFAULT NULL,
    v_inp_calculate_day                 IN scmdata.t_capacity_weekplan_numpieces_base.calculate_day%TYPE DEFAULT NULL,
    v_inp_sfcpallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.sfcpallocate_percentage%TYPE DEFAULT NULL,
    v_inp_scpsallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.scpsallocate_percentage%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_t     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_t IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_p     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_p%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_p IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_p%TYPE DEFAULT NULL,
    v_inp_invoke_object                 IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := '';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'INSERT INTO scmdata.t_capacity_weekplan_numpieces_base
  (cwpnb_id, company_id, supplier_code, factory_code, category, product_cate, 
   subcategory, calculate_day, sfcpallocate_percentage, scpsallocate_percentage, 
   sfcps_allocapcp_ceiling_t, sfcps_allocapcp_appointment_t, sfcps_allocapcp_ceiling_p, 
   sfcps_allocapcp_appointment_p)
VALUES
  (:v_inp_cwpnb_id, :v_inp_company_id, :v_inp_supplier_code, :v_inp_factory_code, 
   :v_inp_category, :v_inp_product_cate, :v_inp_subcategory, :v_inp_calculate_day, 
   :v_inp_sfcpallocate_percentage, :v_inp_scpsallocate_percentage, :v_inp_sfcps_allocapcp_ceiling_t, 
   :v_inp_sfcps_allocapcp_appointment_t, :v_inp_sfcps_allocapcp_ceiling_p, :v_inp_sfcps_allocapcp_appointment_p)';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_cwpnb_id, v_inp_company_id, v_inp_supplier_code, v_inp_factory_code, v_inp_category, v_inp_product_cate, v_inp_subcategory, trunc(v_inp_calculate_day), v_inp_sfcpallocate_percentage, v_inp_scpsallocate_percentage, v_inp_sfcps_allocapcp_ceiling_t, v_inp_sfcps_allocapcp_appointment_t, v_inp_sfcps_allocapcp_ceiling_p, v_inp_sfcps_allocapcp_appointment_p;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql: ' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_cwpnb_id: ' || v_inp_cwpnb_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id ||
                      chr(10) || 'v_inp_supplier_code: ' ||
                      v_inp_supplier_code || chr(10) ||
                      'v_inp_factory_code: ' || v_inp_factory_code ||
                      chr(10) || 'v_inp_category: ' || v_inp_category ||
                      chr(10) || 'v_inp_product_cate: ' ||
                      v_inp_product_cate || chr(10) ||
                      'v_inp_subcategory: ' || v_inp_subcategory || chr(10) ||
                      'v_inp_calculate_day: ' ||
                      to_char(v_inp_calculate_day, 'yyyy-mm-dd hh24-mi-ss') ||
                      chr(10) || 'v_inp_sfcpallocate_percentage: ' ||
                      to_char(v_inp_sfcpallocate_percentage) || chr(10) ||
                      'v_inp_scpsallocate_percentage: ' ||
                      to_char(v_inp_scpsallocate_percentage) || chr(10) ||
                      'v_inp_sfcps_allocapcp_ceiling_t: ' ||
                      to_char(v_inp_sfcps_allocapcp_ceiling_t) || chr(10) ||
                      'v_inp_sfcps_allocapcp_appointment_t: ' ||
                      to_char(v_inp_sfcps_allocapcp_appointment_t) ||
                      chr(10) || 'v_inp_sfcps_allocapcp_ceiling_p: ' ||
                      to_char(v_inp_sfcps_allocapcp_ceiling_p) || chr(10) ||
                      'v_inp_sfcps_allocapcp_appointment_p: ' ||
                      to_char(v_inp_sfcps_allocapcp_appointment_p);
    
      --dbms_output.put_line(v_error_info); 
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => 'sys',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_ins_capacity_weekplan_numpieces_base;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       根据主键执行供应商周产能规划(件数)基表修改
          
     入参:
       v_inp_cwpnb_id                       :  供应商周产能规划(件数)基表Id
       v_inp_company_id                     :  企业Id
       v_inp_sfcpallocate_percentage        :  供应商-生产工厂-分类-生产分类分配占比
       v_inp_scpsallocate_percentage        :  供应商-分类-生产分类-产品子类分配占比
       v_inp_sfcps_allocapcp_ceiling_t      :  产品子类比例分配后产能上限(工时)
       v_inp_sfcps_allocapcp_appointment_t  :  产品子类比例分配后约定产能(工时)
       v_inp_sfcps_allocapcp_ceiling_p      :  产品子类比例分配后产能上限(件数)
       v_inp_sfcps_allocapcp_appointment_p  :  产品子类比例分配后约定产能(件数)
       v_inp_invoke_object                  :  调用对象
            
     版本:
       2023-05-11_zc314 : 根据主键执行供应商周产能规划(件数)基表修改
          
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capacity_weekplan_numpieces_base_by_pk
  (
    v_inp_cwpnb_id                      IN scmdata.t_capacity_weekplan_numpieces_base.cwpnb_id%TYPE DEFAULT NULL,
    v_inp_company_id                    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL,
    v_inp_sfcpallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.sfcpallocate_percentage%TYPE DEFAULT NULL,
    v_inp_scpsallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.scpsallocate_percentage%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_t     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_t IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_p     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_p%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_p IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_p%TYPE DEFAULT NULL,
    v_inp_invoke_object                 IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := '';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'UPDATE scmdata.t_capacity_weekplan_numpieces_base
   SET sfcpallocate_percentage       = :v_inp_sfcpallocate_percentage,
       scpsallocate_percentage       = :v_inp_scpsallocate_percentage,
       sfcps_allocapcp_ceiling_t     = :v_inp_sfcps_allocapcp_ceiling_t,
       sfcps_allocapcp_appointment_t = :v_inp_sfcps_allocapcp_appointment_t,
       sfcps_allocapcp_ceiling_p     = :v_inp_sfcps_allocapcp_ceiling_p,
       sfcps_allocapcp_appointment_p = :v_inp_sfcps_allocapcp_appointment_p
 WHERE cwpnb_id = :v_inp_cwpnb_id
   AND company_id = :v_inp_company_id';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_sfcpallocate_percentage, v_inp_scpsallocate_percentage, v_inp_sfcps_allocapcp_ceiling_t, v_inp_sfcps_allocapcp_appointment_t, v_inp_sfcps_allocapcp_ceiling_p, v_inp_sfcps_allocapcp_appointment_p, v_inp_cwpnb_id, v_inp_company_id;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_sfcpallocate_percentage: ' ||
                      to_char(v_inp_sfcpallocate_percentage) || chr(10) ||
                      'v_inp_scpsallocate_percentage: ' ||
                      to_char(v_inp_scpsallocate_percentage) || chr(10) ||
                      'v_inp_sfcps_allocapcp_ceiling_t: ' ||
                      to_char(v_inp_sfcps_allocapcp_ceiling_t) || chr(10) ||
                      'v_inp_sfcps_allocapcp_appointment_t: ' ||
                      to_char(v_inp_sfcps_allocapcp_appointment_t) ||
                      chr(10) || 'v_inp_sfcps_allocapcp_ceiling_p: ' ||
                      to_char(v_inp_sfcps_allocapcp_ceiling_p) || chr(10) ||
                      'v_inp_sfcps_allocapcp_appointment_p: ' ||
                      to_char(v_inp_sfcps_allocapcp_appointment_p) ||
                      chr(10) || 'v_inp_cwpnb_id: ' || v_inp_cwpnb_id ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => 'sys',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_capacity_weekplan_numpieces_base_by_pk;

  /*=============================================================================
          
     包：
       pkg_capacity_management(产能管理包)
          
     过程名:
       根据唯一键执行供应商周产能规划(件数)基表修改
          
     入参:
       v_inp_supplier_code                  :  供应商编码
       v_inp_factory_code                   :  生产工厂编码
       v_inp_category                       :  分类编码
       v_inp_product_cate                   :  生产分类编码
       v_inp_subcategory                    :  产品子类编码
       v_inp_calculate_day                  :  计算日期
       v_inp_company_id                     :  企业Id
       v_inp_sfcpallocate_percentage        :  供应商-生产工厂-分类-生产分类分配占比
       v_inp_scpsallocate_percentage        :  供应商-分类-生产分类-产品子类分配占比
       v_inp_sfcps_allocapcp_ceiling_t      :  产品子类比例分配后产能上限(工时)
       v_inp_sfcps_allocapcp_appointment_t  :  产品子类比例分配后约定产能(工时)
       v_inp_sfcps_allocapcp_ceiling_p      :  产品子类比例分配后产能上限(件数)
       v_inp_sfcps_allocapcp_appointment_p  :  产品子类比例分配后约定产能(件数)
       v_inp_invoke_object                  :  调用对象
            
     版本:
       2023-05-11_zc314 : 根据唯一键执行供应商周产能规划(件数)基表修改
          
  ==============================================================================*/
  PROCEDURE p_tabapi_upd_capacity_weekplan_numpieces_base_by_uk
  (
    v_inp_supplier_code                 IN scmdata.t_capacity_weekplan_numpieces_base.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code                  IN scmdata.t_capacity_weekplan_numpieces_base.factory_code%TYPE DEFAULT NULL,
    v_inp_category                      IN scmdata.t_capacity_weekplan_numpieces_base.category%TYPE DEFAULT NULL,
    v_inp_product_cate                  IN scmdata.t_capacity_weekplan_numpieces_base.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory                   IN scmdata.t_capacity_weekplan_numpieces_base.subcategory%TYPE DEFAULT NULL,
    v_inp_calculate_day                 IN scmdata.t_capacity_weekplan_numpieces_base.calculate_day%TYPE DEFAULT NULL,
    v_inp_company_id                    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL,
    v_inp_sfcpallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.sfcpallocate_percentage%TYPE DEFAULT NULL,
    v_inp_scpsallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.scpsallocate_percentage%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_t     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_t IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_p     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_p%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_p IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_p%TYPE DEFAULT NULL,
    v_inp_invoke_object                 IN VARCHAR2
  ) IS
    priv_exception        EXCEPTION;
    v_sql                 CLOB;
    v_error_info          CLOB;
    v_sql_errm            VARCHAR2(512);
    v_allow_invoke_object CLOB := '';
    v_self_description    VARCHAR2(1024) := '';
  BEGIN
    --访问控制
    IF instr(v_allow_invoke_object, v_inp_invoke_object) = 0 THEN
      v_sql_errm := '拒绝访问：调用方-' || v_inp_invoke_object || ' 被调用方-' ||
                    v_self_description;
      RAISE priv_exception;
    END IF;
  
    --执行 Sql 赋值
    v_sql := 'UPDATE scmdata.t_capacity_weekplan_numpieces_base
   SET sfcpallocate_percentage       = :v_inp_sfcpallocate_percentage,
       scpsallocate_percentage       = :v_inp_scpsallocate_percentage,
       sfcps_allocapcp_ceiling_t     = :v_inp_sfcps_allocapcp_ceiling_t,
       sfcps_allocapcp_appointment_t = :v_inp_sfcps_allocapcp_appointment_t,
       sfcps_allocapcp_ceiling_p     = :v_inp_sfcps_allocapcp_ceiling_p,
       sfcps_allocapcp_appointment_p = :v_inp_sfcps_allocapcp_appointment_p
 WHERE supplier_code = :v_inp_supplier_code
   AND factory_code = :v_inp_factory_code
   AND category = :v_inp_category
   AND product_cate = :v_inp_product_cate
   AND subcategory = :v_inp_subcategory
   AND calculate_day = :v_inp_calculate_day
   AND company_id = :v_inp_company_id';
    --执行 Sql
    EXECUTE IMMEDIATE v_sql
      USING v_inp_sfcpallocate_percentage, v_inp_scpsallocate_percentage, v_inp_sfcps_allocapcp_ceiling_t, v_inp_sfcps_allocapcp_appointment_t, v_inp_sfcps_allocapcp_ceiling_p, v_inp_sfcps_allocapcp_appointment_p, v_inp_supplier_code, v_inp_factory_code, v_inp_category, v_inp_product_cate, v_inp_subcategory, trunc(v_inp_calculate_day), v_inp_company_id;
  EXCEPTION
    WHEN priv_exception THEN
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
    WHEN OTHERS THEN
      --错误信息赋值
      v_sql_errm   := substr(dbms_utility.format_error_stack, 1, 512);
      v_error_info := 'Error Object:' || v_self_description || chr(10) ||
                      'Error Info: ' || v_sql_errm || chr(10) ||
                      'Execute sql:' || v_sql || chr(10) || 'Params: ' ||
                      chr(10) || 'v_inp_sfcpallocate_percentage: ' ||
                      to_char(v_inp_sfcpallocate_percentage) || chr(10) ||
                      'v_inp_scpsallocate_percentage: ' ||
                      to_char(v_inp_scpsallocate_percentage) || chr(10) ||
                      'v_inp_sfcps_allocapcp_ceiling_t: ' ||
                      to_char(v_inp_sfcps_allocapcp_ceiling_t) || chr(10) ||
                      'v_inp_sfcps_allocapcp_appointment_t: ' ||
                      to_char(v_inp_sfcps_allocapcp_appointment_t) ||
                      chr(10) || 'v_inp_sfcps_allocapcp_ceiling_p: ' ||
                      to_char(v_inp_sfcps_allocapcp_ceiling_p) || chr(10) ||
                      'v_inp_sfcps_allocapcp_appointment_p: ' ||
                      to_char(v_inp_sfcps_allocapcp_appointment_p) ||
                      chr(10) || 'v_inp_supplier_code: ' ||
                      v_inp_supplier_code || chr(10) ||
                      'v_inp_factory_code: ' || v_inp_factory_code ||
                      chr(10) || 'v_inp_category: ' || v_inp_category ||
                      chr(10) || 'v_inp_product_cate: ' ||
                      v_inp_product_cate || chr(10) ||
                      'v_inp_subcategory: ' || v_inp_subcategory || chr(10) ||
                      'v_inp_calculate_day: ' ||
                      to_char(v_inp_calculate_day, 'yyyy-mm-dd hh24-mi-ss') ||
                      chr(10) || 'v_inp_company_id: ' || v_inp_company_id;
    
      --新增进入错误信息表
      scmdata.pkg_qa_ee.p_ins_errrecord_at(v_inp_errprogram     => v_self_description,
                                           v_inp_causeerruserid => 'sys',
                                           v_inp_erroccurtime   => SYSDATE,
                                           v_inp_errinfo        => v_error_info,
                                           v_inp_compid         => v_inp_company_id);
    
      --抛出报错
      raise_application_error(-20002, v_sql_errm);
  END p_tabapi_upd_capacity_weekplan_numpieces_base_by_uk;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     函数名:
       根据主键判断供应商周产能规划(件数)基表是否存在
        
     入参:
       v_inp_cwpnb_id    :  供应商周产能规划(件数)基表Id
       v_inp_company_id  :  企业Id
          
     版本:
       2023-05-09_zc314 : 根据主键判断供应商周产能规划(件数)基表是否存在
        
  ==============================================================================*/
  FUNCTION f_tabapi_is_capacity_weekplan_numpieces_base_exists_by_pk
  (
    v_inp_cwpnb_id   IN scmdata.t_capacity_weekplan_numpieces_base.cwpnb_id%TYPE DEFAULT NULL,
    v_inp_company_id IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    --获取结果
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capacity_weekplan_numpieces_base
     WHERE cwpnb_id = v_inp_cwpnb_id
       AND company_id = v_inp_company_id
       AND rownum = 1;
  
    --返回结果
    RETURN v_jugnum;
  END f_tabapi_is_capacity_weekplan_numpieces_base_exists_by_pk;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       根据唯一键判断供应商周产能规划(件数)基表是否存在 
        
     入参:
       v_inp_supplier_code  :  供应商编码
       v_inp_factory_code   :  生产工厂编码
       v_inp_category       :  分类编码
       v_inp_product_cate   :  生产分类编码
       v_inp_subcategory    :  产品子类编码 
       v_inp_calculate_day  :  计算日期
       v_inp_company_id     :  企业Id
          
     版本:
       2023-05-09_zc314 : 根据唯一键判断供应商周产能规划(件数)基表是否存在 
        
  ==============================================================================*/
  FUNCTION f_tabapi_is_capacity_weekplan_numpieces_base_exists_by_uk
  (
    v_inp_supplier_code IN scmdata.t_capacity_weekplan_numpieces_base.supplier_code%TYPE DEFAULT NULL,
    v_inp_factory_code  IN scmdata.t_capacity_weekplan_numpieces_base.factory_code%TYPE DEFAULT NULL,
    v_inp_category      IN scmdata.t_capacity_weekplan_numpieces_base.category%TYPE DEFAULT NULL,
    v_inp_product_cate  IN scmdata.t_capacity_weekplan_numpieces_base.product_cate%TYPE DEFAULT NULL,
    v_inp_subcategory   IN scmdata.t_capacity_weekplan_numpieces_base.subcategory%TYPE DEFAULT NULL,
    v_inp_calculate_day IN scmdata.t_capacity_weekplan_numpieces_base.calculate_day%TYPE DEFAULT NULL,
    v_inp_company_id    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE DEFAULT NULL
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    --获取结果
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capacity_weekplan_numpieces_base
     WHERE supplier_code = v_inp_supplier_code
       AND factory_code = v_inp_factory_code
       AND category = v_inp_category
       AND product_cate = v_inp_product_cate
       AND subcategory = v_inp_subcategory
       AND trunc(calculate_day) = trunc(v_inp_calculate_day)
       AND company_id = v_inp_company_id
       AND rownum = 1;
  
    --返回结果
    RETURN v_jugnum;
  END f_tabapi_is_capacity_weekplan_numpieces_base_exists_by_uk;

  /*=============================================================================
        
     包：
       pkg_capacity_management(产能管理包)
        
     过程名:
       供应商周产能规划(件数)基表新增/修改
        
     入参:
       v_inp_cwpnb_id                       :  供应商周产能规划(件数)基表Id
       v_inp_company_id                     :  企业Id
       v_inp_supplier_code                  :  供应商编码
       v_inp_factory_code                   :  生产工厂编码
       v_inp_category                       :  分类编码
       v_inp_product_cate                   :  生产分类编码
       v_inp_subcategory                    :  产品子类编码
       v_inp_calculate_day                  :  计算日期
       v_inp_sfcpallocate_percentage        :  供应商-生产工厂-分类-生产分类分配占比
       v_inp_scpsallocate_percentage        :  供应商-分类-生产分类-产品子类分配占比
       v_inp_sfcp_allocapc_ceiling_t        :  产品子类比例分配后产能上限(工时)
       v_inp_sfcp_allocapcp_appointment_t   :  产品子类比例分配后约定产能(工时)
       v_inp_sfcps_allocapcp_ceiling_p      :  产品子类比例分配后产能上限(件数)
       v_inp_sfcps_allocapcp_appointment_p  :  产品子类比例分配后约定产能(件数)
          
     版本:
       2023-05-09_zc314 : 供应商周产能规划(件数)基表新增/修改
        
  ==============================================================================*/
  PROCEDURE p_tabapi_iou_capacity_weekplan_numpieces_base
  (
    v_inp_cwpnb_id                      IN scmdata.t_capacity_weekplan_numpieces_base.cwpnb_id%TYPE DEFAULT NULL,
    v_inp_company_id                    IN scmdata.t_capacity_weekplan_numpieces_base.company_id%TYPE,
    v_inp_supplier_code                 IN scmdata.t_capacity_weekplan_numpieces_base.supplier_code%TYPE,
    v_inp_factory_code                  IN scmdata.t_capacity_weekplan_numpieces_base.factory_code%TYPE,
    v_inp_category                      IN scmdata.t_capacity_weekplan_numpieces_base.category%TYPE,
    v_inp_product_cate                  IN scmdata.t_capacity_weekplan_numpieces_base.product_cate%TYPE,
    v_inp_subcategory                   IN scmdata.t_capacity_weekplan_numpieces_base.subcategory%TYPE,
    v_inp_calculate_day                 IN scmdata.t_capacity_weekplan_numpieces_base.calculate_day%TYPE,
    v_inp_sfcpallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.sfcpallocate_percentage%TYPE DEFAULT NULL,
    v_inp_scpsallocate_percentage       IN scmdata.t_capacity_weekplan_numpieces_base.scpsallocate_percentage%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_t     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_t IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_t%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_ceiling_p     IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_ceiling_p%TYPE DEFAULT NULL,
    v_inp_sfcps_allocapcp_appointment_p IN scmdata.t_capacity_weekplan_numpieces_base.sfcps_allocapcp_appointment_p%TYPE DEFAULT NULL
  ) IS
  
    v_jugnum           NUMBER(1);
    v_self_description VARCHAR2(1024) := 'scmdata.pkg_capacity_management.p_tabapi_iou_capacity_weekplan_numpieces_base';
  BEGIN
    --供应商编码非空判断
    IF v_inp_supplier_code IS NOT NULL THEN
      --唯一键判断
      v_jugnum := f_tabapi_is_capacity_weekplan_numpieces_base_exists_by_uk(v_inp_supplier_code => v_inp_supplier_code,
                                                                            v_inp_factory_code  => v_inp_factory_code,
                                                                            v_inp_category      => v_inp_category,
                                                                            v_inp_product_cate  => v_inp_product_cate,
                                                                            v_inp_subcategory   => v_inp_subcategory,
                                                                            v_inp_calculate_day => v_inp_calculate_day,
                                                                            v_inp_company_id    => v_inp_company_id);
    ELSE
      --主键判断
      v_jugnum := f_tabapi_is_capacity_weekplan_numpieces_base_exists_by_pk(v_inp_cwpnb_id   => v_inp_cwpnb_id,
                                                                            v_inp_company_id => v_inp_company_id);
    END IF;
  
    --是否存在判断
    IF v_jugnum = 0 THEN
      --新增
      p_tabapi_ins_capacity_weekplan_numpieces_base(v_inp_cwpnb_id                      => scmdata.f_get_uuid(),
                                                    v_inp_company_id                    => v_inp_company_id,
                                                    v_inp_supplier_code                 => v_inp_supplier_code,
                                                    v_inp_factory_code                  => v_inp_factory_code,
                                                    v_inp_category                      => v_inp_category,
                                                    v_inp_product_cate                  => v_inp_product_cate,
                                                    v_inp_subcategory                   => v_inp_subcategory,
                                                    v_inp_calculate_day                 => v_inp_calculate_day,
                                                    v_inp_sfcpallocate_percentage       => v_inp_sfcpallocate_percentage,
                                                    v_inp_scpsallocate_percentage       => v_inp_scpsallocate_percentage,
                                                    v_inp_sfcps_allocapcp_ceiling_t     => v_inp_sfcps_allocapcp_ceiling_t,
                                                    v_inp_sfcps_allocapcp_appointment_t => v_inp_sfcps_allocapcp_appointment_t,
                                                    v_inp_sfcps_allocapcp_ceiling_p     => v_inp_sfcps_allocapcp_ceiling_p,
                                                    v_inp_sfcps_allocapcp_appointment_p => v_inp_sfcps_allocapcp_appointment_p,
                                                    v_inp_invoke_object                 => v_self_description);
    ELSE
      --供应商编码非空
      IF v_inp_supplier_code IS NOT NULL THEN
        --根据唯一键修改
        p_tabapi_upd_capacity_weekplan_numpieces_base_by_uk(v_inp_supplier_code                 => v_inp_supplier_code,
                                                            v_inp_factory_code                  => v_inp_factory_code,
                                                            v_inp_category                      => v_inp_category,
                                                            v_inp_product_cate                  => v_inp_product_cate,
                                                            v_inp_subcategory                   => v_inp_subcategory,
                                                            v_inp_calculate_day                 => v_inp_calculate_day,
                                                            v_inp_company_id                    => v_inp_company_id,
                                                            v_inp_sfcpallocate_percentage       => v_inp_sfcpallocate_percentage,
                                                            v_inp_scpsallocate_percentage       => v_inp_scpsallocate_percentage,
                                                            v_inp_sfcps_allocapcp_ceiling_t     => v_inp_sfcps_allocapcp_ceiling_t,
                                                            v_inp_sfcps_allocapcp_appointment_t => v_inp_sfcps_allocapcp_appointment_t,
                                                            v_inp_sfcps_allocapcp_ceiling_p     => v_inp_sfcps_allocapcp_ceiling_p,
                                                            v_inp_sfcps_allocapcp_appointment_p => v_inp_sfcps_allocapcp_appointment_p,
                                                            v_inp_invoke_object                 => v_self_description);
      ELSE
        --根据主键修改
        p_tabapi_upd_capacity_weekplan_numpieces_base_by_pk(v_inp_cwpnb_id                      => v_inp_cwpnb_id,
                                                            v_inp_company_id                    => v_inp_company_id,
                                                            v_inp_sfcpallocate_percentage       => v_inp_sfcpallocate_percentage,
                                                            v_inp_scpsallocate_percentage       => v_inp_scpsallocate_percentage,
                                                            v_inp_sfcps_allocapcp_ceiling_t     => v_inp_sfcps_allocapcp_ceiling_t,
                                                            v_inp_sfcps_allocapcp_appointment_t => v_inp_sfcps_allocapcp_appointment_t,
                                                            v_inp_sfcps_allocapcp_ceiling_p     => v_inp_sfcps_allocapcp_ceiling_p,
                                                            v_inp_sfcps_allocapcp_appointment_p => v_inp_sfcps_allocapcp_appointment_p,
                                                            v_inp_invoke_object                 => v_self_description);
      END IF;
    END IF;
  END p_tabapi_iou_capacity_weekplan_numpieces_base;

END pkg_capacity_management;
/

