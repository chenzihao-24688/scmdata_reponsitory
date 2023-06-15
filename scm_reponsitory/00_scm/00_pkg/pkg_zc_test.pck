CREATE OR REPLACE PACKAGE SCMDATA.pkg_zc_test IS

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
       2023-06-12_zc314 : 产能配置-根据唯一键判断供应商产品子类占比配置是否存在
        
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
  );

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
  );

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

END pkg_zc_test;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_zc_test IS

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
    v_supplier_code           VARCHAR2(32);
    v_factory_code            VARCHAR2(32);
    v_category                VARCHAR2(2);
    v_product_cate            VARCHAR2(4);
    v_sql_errm                VARCHAR2(512);
    v_old_allocate_percentage NUMBER(5, 2);
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
    v_old_allocate_percentage NUMBER(5, 2);
    v_supplier_code           VARCHAR2(32);
    v_factory_code            VARCHAR2(32);
    v_category                VARCHAR2(2);
    v_product_cate            VARCHAR2(4);
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
      FROM scmdata.t_capc_fac_procate_rate_cfg_view
     WHERE cfprc_id = v_inp_cfprc_id
       AND company_id = v_inp_company_id;
  
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

END pkg_zc_test;
/

