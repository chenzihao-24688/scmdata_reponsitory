CREATE OR REPLACE PACKAGE SCMDATA.pkg_capacity_iflrow IS

  /*===================================================================================
  
    影响行重构——通用影响行新增生成器
  
    入参:
      v_tab      :  影响表
      v_supcode  :  供应商编码
      v_faccode  :  生产工厂编码
      v_cate     :  分类id
      v_procate  :  生产分类id
      v_subcate  :  产品子类id
      v_queueid  :  队列id
      v_compid   :  企业id
  
    版本:
      2022-08-08 : 影响行重构——通用影响行新增生成器
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_common_queueifldata_generator
  (
    v_tab     IN VARCHAR2 DEFAULT 'SCM_CAPC_COMMON_TAB',
    v_supcode IN VARCHAR2 DEFAULT NULL,
    v_faccode IN VARCHAR2 DEFAULT NULL,
    v_cate    IN VARCHAR2 DEFAULT NULL,
    v_procate IN VARCHAR2 DEFAULT NULL,
    v_subcate IN VARCHAR2 DEFAULT NULL,
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [品类合作供应商] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成 [品类合作供应商] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_csc_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2;

  /*===================================================================================
  
    生成 [品类合作供应商] 影响行
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    版本:
      2022-04-25 : 生成 [品类合作供应商] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_csc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [品类合作生产工厂] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成 [品类合作生产工厂] 影响行sql
  
  ===================================================================================*/
  FUNCTION f_get_cfc_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2;

  /*===================================================================================
  
    生成 [品类合作生产工厂+生产工厂约定产能] 影响行
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    版本:
      2022-04-25 : 生成 [品类合作生产工厂+生产工厂约定产能] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_cfc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [生产工厂约定产能] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂
  
    版本:
      2022-04-25 : 生成 [生产工厂约定产能] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_acc_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2;

  /*===================================================================================
  
    生成 [品类合作生产工厂+生产工厂约定产能] 影响行
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    版本:
      2022-04-25 : 生成 [品类合作生产工厂+生产工厂约定产能] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_acc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [供应商开工通用配置] 省市区影响行sql
  
    入参:
      v_tmpprovid    :  省份id
      v_tmpcityid    :  城市id
      v_tmpcountyid  :  区域id
      v_compid       :  企业id
  
    返回值:
      可执行sql，类型为varchar2
  
    版本:
      2022-04-25 : 生成 [供应商开工通用配置] 省市区影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_sswc_pcc_iflrows
  (
    v_tmpprovid   IN VARCHAR2,
    v_tmpcityid   IN VARCHAR2,
    v_tmpcountyid IN VARCHAR2,
    v_compid      IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
  
    生成 [供应商开工通用配置] 分类生产分类产品子类影响行sql
  
    入参:
      v_tmpbraid     :  省份id
      v_compid       :  企业id
  
    返回值:
      可执行sql，类型为varchar2
  
    版本:
      2022-04-25 : 生成 [供应商开工通用配置] 分类生产分类产品子类影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_sswc_cps_iflrows
  (
    v_tmpbraid IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
  
    生成 [供应商开工通用配置] 影响行
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    返回值:
      可执行sql，类型为varchar2
  
    版本:
      2022-04-25 : 生成 [供应商开工通用配置] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_sswc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [标准工时+产能品类规划+生产周期] 影响行sql
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成 [标准工时+产能品类规划+生产周期] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_swmc_cpcc_pcc_iflrows_sql
  (
    v_vctab  IN VARCHAR2,
    v_vccond IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    生成 [标准工时+产能品类规划+生产周期] 影响行
  
    入参:
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vctab     :  变更表
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-25 : 生成 [标准工时+产能品类规划+生产周期] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_swmc_cpcc_pcc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vctab   IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [供应商产能预约] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-26 : 生成 [供应商产能预约] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_scd_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2;

  /*===================================================================================
  
    生成 [供应商产能预约] 影响行
  
    入参:
  
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-26 : 生成 [供应商产能预约] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_scd_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [供应商产能预约明细] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-26 : 生成 [供应商产能预约明细] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_cad_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2;

  /*===================================================================================
  
    生成 [供应商产能预约] 影响行
  
    入参:
  
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-26 : 生成 [供应商产能预约] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_cad_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [预计新品] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-26 : 生成 [预计新品] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_pn_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2;

  /*===================================================================================
  
    生成 [预计新品] 影响行
  
    入参:
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-26 : 生成 [预计新品] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_pn_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [预计补单] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-26 : 生成 [预计补单] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_pns_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2;

  /*===================================================================================
  
    生成 [预计补单] 影响行
  
    入参:
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-26 : 生成 [预计补单] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_pns_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成[供应商档案]数据源级影响行
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[供应商档案]数据源级影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_supinfo_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    iflrowslogic
    获取供应商档案启停生成影响行逻辑的sql
  
    入参:
      v_vccond  :  值变更唯一条件
  
    返回值:
      可执行的sql语句
  
    版本:
      2022-08-08 : 获取供应商档案启停生成影响行逻辑的sql
  
  ===================================================================================*/
  FUNCTION f_get_supdoc_iflrows_sql(v_vccond IN VARCHAR2) RETURN CLOB;

  /*===================================================================================
  
    iflrowslogic
    供应商档案合作状态变更影响行逻辑
  
    入参:
      v_queueid  :  供应商编码
      v_compid   :  企业id
  
    版本:
      2022-08-08 : 供应商档案合作状态变更影响行逻辑
  
  ===================================================================================*/
  PROCEDURE p_supdoc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2
  );

  /*===================================================================================
  
    生成[供应商档案-合作工厂]数据源级影响行
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[供应商档案-合作工厂]数据源级影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_coopfac_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    iflrowslogic
    供应商档案合作工厂变更影响行生成 sql
  
    入参:
      v_vccond  :  供应商档案合作工厂唯一行条件
  
    返回值:
      可执行的sql语句
  
    版本:
      2022-08-09 : 供应商档案合作工厂变更影响行生成 sql
  
  ===================================================================================*/
  FUNCTION f_get_supfac_iu_iflrows_sql(v_vccond IN VARCHAR2) RETURN CLOB;

  /*===================================================================================
  
    iflrowslogic
    供应商档案合作工厂变更影响行逻辑
  
    入参:
      v_queueid  :  供应商编码
      v_vccond   :  唯一行条件
      v_compid   :  企业id
  
    版本:
      2022-08-05 : 供应商档案合作工厂变更影响行逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfac_iu_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2
  );

  /*===================================================================================
  
    生成[供应商档案-合作范围]数据源级影响行
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[供应商档案-合作范围]数据源级影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_coopscp_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    iflrowslogic
    获取供应商合作范围影响行数据生成sql
  
    入参:
      v_queueid  :  队列id
      v_cond     :  唯一行条件
      v_compid   :  企业id
  
    版本:
      2022-08-09 : 获取供应商合作范围影响行数据生成sql
  
  ===================================================================================*/
  PROCEDURE p_gen_supscp_iflrows
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成[下单列表-ordered]数据源级影响sql
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成[下单列表-ordered]数据源级影响sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_ordered_iflrows_sql
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    生成[下单列表-ordered]数据源级影响sql
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[下单列表-ordered]数据源级影响sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_ordered_iflrows
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成 [下单列表-orders] 数据源级影响行
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成 [下单列表-orders] 数据源级影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_orders_iflrows_sql
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    生成[下单列表-ordered]数据源级影响sql
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[下单列表-ordered]数据源级影响sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_orders_iflrows
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成[订单数据接入]数据源级影响行sql
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂、分类、生产分类、子类
  
    版本:
      2022-04-25 : 生成[订单数据接入]数据源级影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_orditf_iflrows_sql
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    生成[订单数据接入]数据源级影响行sql
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂、分类、生产分类、子类
  
    版本:
      2022-04-25 : 生成[订单数据接入]数据源级影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_orditf_iflrows
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成“指定工厂”影响行
  
    入参:
      v_inp_queueid  :  队列id
      v_inp_ordid    :  订单id
      v_inp_compid   :  企业id
  
    版本:
      2022-12-17_zc314 : 生成“指定工厂”影响行
  
  ===================================================================================*/
  PROCEDURE p_gen_specify_ordfactory_iflrows
  (
    v_inp_queueid IN VARCHAR2,
    v_inp_ordid   IN VARCHAR2,
    v_inp_compid  IN VARCHAR2
  );

  /*===================================================================================
    
    生成工厂生产分类占比影响行 Sql
    
    入参:
      v_inp_table_name  :  表名
      v_inp_cond        :  唯一行条件
    
    返回值:
      可执行的sql语句，用于查出关联分类-生产分类-子类
    
    版本:
      2023-04-28 : 生成工厂生产分类占比影响行 Sql
    
  ===================================================================================*/
  FUNCTION f_get_capc_fac_procate_rate_cfg_iflrows_sql
  (
    v_inp_table_name IN VARCHAR2,
    v_inp_cond_sql   IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
    
    生成“工厂生产类别分配占比”影响行
    
    入参:
      v_inp_queue_id    :  队列id
      v_inp_table_name  :  表名
      v_inp_cond_sql    :  条件Sql
      v_inp_company_id  :  企业Id
    
    版本:
      2023-04-28_zc314 : 生成“工厂生产类别分配占比”影响行
    
  ===================================================================================*/
  PROCEDURE p_gen_capc_fac_procate_rate_cfg_iflrows
  (
    v_inp_queue_id   IN VARCHAR2,
    v_inp_table_name IN VARCHAR2,
    v_inp_cond_sql   IN VARCHAR2,
    v_inp_company_id IN VARCHAR2
  );

  /*===================================================================================
    
    生成供应商产品子类分配占比 Sql
    
    入参:
      v_inp_table_name  :  表名
      v_inp_cond        :  唯一行条件
    
    返回值:
      可执行的sql语句，用于查出关联分类-生产分类-子类
    
    版本:
      2023-04-28 : 生成供应商产品子类分配占比 Sql
    
  ===================================================================================*/
  FUNCTION f_get_capc_sup_subcate_rate_cfg_iflrows_sql
  (
    v_inp_table_name IN VARCHAR2,
    v_inp_cond_sql   IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
    
    生成“供应商产品子类分配占比”影响行
    
    入参:
      v_inp_queue_id    :  队列id
      v_inp_table_name  :  表名
      v_inp_cond_sql    :  条件Sql
      v_inp_company_id  :  企业Id
    
    版本:
      2023-04-28_zc314 : 生成“供应商产品子类分配占比”影响行
    
  ===================================================================================*/
  PROCEDURE p_gen_capc_sup_subcate_rate_cfg_iflrows
  (
    v_inp_queue_id   IN VARCHAR2,
    v_inp_table_name IN VARCHAR2,
    v_inp_cond_sql   IN VARCHAR2,
    v_inp_company_id IN VARCHAR2
  );

  /*===================================================================================
  
    涉及影响行算法
  
    用途:
      用于涉及供应商产能预约增删改生成对应影响行
  
    用于:
      产能部分，规则：
      对所有数据维度不同的表（除配置表外），统一进行关联抽象出伪列，
      分别以供应商+生产工厂/cps/供应商+生产工厂+cps为维度进行抽象
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    版本:
      2022-04-25 : 用于涉及供应商产能预约增删改生成对应影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_influencerows_core
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

END pkg_capacity_iflrow;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_capacity_iflrow IS

  /*===================================================================================
  
    影响行重构——通用影响行新增生成器
  
    入参:
      v_tab      :  影响表
      v_supcode  :  供应商编码
      v_faccode  :  生产工厂编码
      v_cate     :  分类id
      v_procate  :  生产分类id
      v_subcate  :  产品子类id
      v_queueid  :  队列id
      v_compid   :  企业id
  
    版本:
      2022-08-08 : 影响行重构——通用影响行新增生成器
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_common_queueifldata_generator
  (
    v_tab     IN VARCHAR2 DEFAULT 'SCM_CAPC_COMMON_TAB',
    v_supcode IN VARCHAR2 DEFAULT NULL,
    v_faccode IN VARCHAR2 DEFAULT NULL,
    v_cate    IN VARCHAR2 DEFAULT NULL,
    v_procate IN VARCHAR2 DEFAULT NULL,
    v_subcate IN VARCHAR2 DEFAULT NULL,
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  
  BEGIN
    INSERT INTO scmdata.t_queue_iflrows
      (iflrows_id, company_id, queue_id, ir_tab, ir_colname1, ir_colvalue1, ir_colname2, ir_colvalue2, ir_colname3, ir_colvalue3, ir_colname4, ir_colvalue4, ir_colname5, ir_colvalue5)
    VALUES
      (scmdata.f_get_uuid(), v_compid, v_queueid, v_tab, 'SUPPLIER_CODE', v_supcode, 'FACTORY_CODE', v_faccode, 'CATEGORY', v_cate, 'PRODUCT_CATE', v_procate, 'SUBCATEGORY', v_subcate);
  END p_common_queueifldata_generator;

  /*===================================================================================
  
    生成 [品类合作供应商] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成 [品类合作供应商] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_csc_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2 IS
    v_retsql VARCHAR2(4000);
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_retsql := 'SELECT MAX(SUPPLIER_CODE),MAX(COOP_CATEGORY),MAX(COOP_PRODUCTCATE),MAX(COOP_SUBCATEGORY) ' ||
                  'FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG WHERE ' || v_vccond;
    END IF;
  
    RETURN v_retsql;
  END f_get_csc_iflrows_sql;

  /*===================================================================================
  
    生成 [品类合作供应商] 影响行
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    版本:
      2022-04-25 : 生成 [品类合作供应商] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_csc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_supcode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(4);
    v_subcate VARCHAR2(8);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_get_csc_iflrows_sql(v_vccond => v_vccond);
    IF v_iflsql IS NOT NULL THEN
      EXECUTE IMMEDIATE v_iflsql
        INTO v_supcode, v_cate, v_procate, v_subcate;
      p_common_queueifldata_generator(v_supcode => v_supcode,
                                      v_cate    => v_cate,
                                      v_procate => v_procate,
                                      v_subcate => v_subcate,
                                      v_queueid => v_queueid,
                                      v_compid  => v_compid);
    END IF;
  END p_gen_csc_iflrows;

  /*===================================================================================
  
    生成 [品类合作生产工厂] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成 [品类合作生产工厂] 影响行sql
  
  ===================================================================================*/
  FUNCTION f_get_cfc_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2 IS
    v_retsql VARCHAR2(4000);
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_retsql := 'SELECT MAX(B.SUPPLIER_CODE), MAX(A.FACTORY_CODE) FROM ' ||
                  '(SELECT * FROM SCMDATA.T_COOPCATE_FACTORY_CFG WHERE ' ||
                  v_vccond ||
                  ') A LEFT JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG B ON ' ||
                  'A.CSC_ID = B.CSC_ID AND A.COMPANY_ID = B.COMPANY_ID ' ||
                  'AND A.PAUSE = 0 AND B.PAUSE = 0';
    END IF;
  
    RETURN v_retsql;
  END f_get_cfc_iflrows_sql;

  /*===================================================================================
  
    生成 [品类合作生产工厂+生产工厂约定产能] 影响行
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    版本:
      2022-04-25 : 生成 [品类合作生产工厂+生产工厂约定产能] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_cfc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_get_cfc_iflrows_sql(v_vccond => v_vccond);
    IF v_iflsql IS NOT NULL THEN
      EXECUTE IMMEDIATE v_iflsql
        INTO v_supcode, v_faccode;
      p_common_queueifldata_generator(v_supcode => v_supcode,
                                      v_faccode => v_faccode,
                                      v_queueid => v_queueid,
                                      v_compid  => v_compid);
    END IF;
  END p_gen_cfc_iflrows;

  /*===================================================================================
  
    生成 [生产工厂约定产能] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂
  
    版本:
      2022-04-25 : 生成 [生产工厂约定产能] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_acc_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2 IS
    v_retsql VARCHAR2(4000);
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_retsql := 'SELECT MAX(SUPPLIER_CODE), MAX(FACTORY_CODE) FROM SCMDATA.T_APP_CAPACITY_CFG WHERE ' ||
                  v_vccond;
    END IF;
  
    RETURN v_retsql;
  END f_get_acc_iflrows_sql;

  /*===================================================================================
  
    生成 [品类合作生产工厂+生产工厂约定产能] 影响行
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    版本:
      2022-04-25 : 生成 [品类合作生产工厂+生产工厂约定产能] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_acc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_get_acc_iflrows_sql(v_vccond => v_vccond);
    IF v_iflsql IS NOT NULL THEN
      EXECUTE IMMEDIATE v_iflsql
        INTO v_supcode, v_faccode;
      p_common_queueifldata_generator(v_supcode => v_supcode,
                                      v_faccode => v_faccode,
                                      v_queueid => v_queueid,
                                      v_compid  => v_compid);
    END IF;
  END p_gen_acc_iflrows;

  /*===================================================================================
  
    生成 [供应商开工通用配置] 省市区影响行sql
  
    入参:
      v_tmpprovid    :  省份id
      v_tmpcityid    :  城市id
      v_tmpcountyid  :  区域id
      v_compid       :  企业id
  
    返回值:
      可执行sql，类型为varchar2
  
    版本:
      2022-04-25 : 生成 [供应商开工通用配置] 省市区影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_sswc_pcc_iflrows
  (
    v_tmpprovid   IN VARCHAR2,
    v_tmpcityid   IN VARCHAR2,
    v_tmpcountyid IN VARCHAR2,
    v_compid      IN VARCHAR2
  ) RETURN CLOB IS
    v_exesql CLOB;
  BEGIN
    v_exesql := 'SELECT DISTINCT A.SUPPLIER_CODE, B.FACTORY_CODE FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A ' ||
                'LEFT JOIN SCMDATA.T_COOPCATE_FACTORY_CFG B ON A.CSC_ID = B.CSC_ID AND A.COMPANY_ID = B.COMPANY_ID ' ||
                'WHERE A.COMPANY_ID = ''' || v_compid ||
                ''' AND A.PAUSE = 0 AND B.PAUSE = 0 ' ||
                'AND EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_INFO WHERE SUPPLIER_CODE = B.FACTORY_CODE ' ||
                'AND COMPANY_ID = B.COMPANY_ID AND COMPANY_PROVINCE = ''' ||
                v_tmpprovid || ''' AND COMPANY_CITY = ''' || v_tmpcityid ||
                ''' AND COMPANY_COUNTY = ''' || v_tmpcountyid || ''')';
    RETURN v_exesql;
  END f_gen_sswc_pcc_iflrows;

  /*===================================================================================
  
    生成 [供应商开工通用配置] 分类生产分类产品子类影响行sql
  
    入参:
      v_tmpbraid     :  省份id
      v_compid       :  企业id
  
    返回值:
      可执行sql，类型为varchar2
  
    版本:
      2022-04-25 : 生成 [供应商开工通用配置] 分类生产分类产品子类影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_sswc_cps_iflrows
  (
    v_tmpbraid IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) RETURN CLOB IS
    v_exesql CLOB;
  BEGIN
    v_exesql := 'SELECT DISTINCT A.COOP_CATEGORY, A.COOP_PRODUCTCATE, A.COOP_SUBCATEGORY FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A ' ||
                'LEFT JOIN SCMDATA.T_COOPCATE_FACTORY_CFG B ON A.CSC_ID = B.CSC_ID AND A.COMPANY_ID = B.COMPANY_ID ' ||
                'WHERE A.COMPANY_ID = ''' || v_compid ||
                ''' AND A.COOP_CATEGORY = ''' || v_tmpbraid ||
                ''' AND A.PAUSE = 0 AND B.PAUSE = 0';
    RETURN v_exesql;
  END f_gen_sswc_cps_iflrows;

  /*===================================================================================
  
    生成 [供应商开工通用配置] 影响行
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行sql，类型为varchar2
  
    版本:
      2022-04-25 : 生成 [供应商开工通用配置] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_sswc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc            rctype;
    v_supcode     VARCHAR2(32);
    v_faccode     VARCHAR2(32);
    v_tmpbraid    VARCHAR2(2);
    v_tmpprovid   VARCHAR2(16);
    v_tmpcityid   VARCHAR2(16);
    v_tmpcountyid VARCHAR2(16);
    v_tmpfaccode  VARCHAR2(32);
    v_cate        VARCHAR2(2);
    v_procate     VARCHAR2(4);
    v_subcate     VARCHAR2(8);
    v_exesql      VARCHAR2(4000);
  BEGIN
    SELECT MAX(decode(vc_col, 'BRA_ID', vc_curval)) bra_id,
           MAX(decode(vc_col, 'PROVINCE_ID', vc_curval)) province_id,
           MAX(decode(vc_col, 'CITY_ID', vc_curval)) city_id,
           MAX(decode(vc_col, 'COUNTRY_ID', vc_curval)) country_id,
           MAX(decode(vc_col, 'FACTORY_CODE', vc_curval)) factory_code
      INTO v_tmpbraid,
           v_tmpprovid,
           v_tmpcityid,
           v_tmpcountyid,
           v_tmpfaccode
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_tmpfaccode IS NOT NULL THEN
      p_common_queueifldata_generator(v_faccode => v_tmpfaccode,
                                      v_queueid => v_queueid,
                                      v_compid  => v_compid);
    ELSIF v_tmpprovid IS NOT NULL THEN
      v_exesql := f_gen_sswc_pcc_iflrows(v_tmpprovid   => v_tmpprovid,
                                         v_tmpcityid   => v_tmpcityid,
                                         v_tmpcountyid => v_tmpcountyid,
                                         v_compid      => v_compid);
    
      OPEN rc FOR v_exesql;
      LOOP
        FETCH rc
          INTO v_supcode,
               v_faccode;
        EXIT WHEN rc%NOTFOUND;
        p_common_queueifldata_generator(v_supcode => v_supcode,
                                        v_faccode => v_faccode,
                                        v_queueid => v_queueid,
                                        v_compid  => v_compid);
      END LOOP;
      CLOSE rc;
    ELSIF v_tmpbraid IS NOT NULL THEN
      v_exesql := f_gen_sswc_cps_iflrows(v_tmpbraid => v_tmpbraid,
                                         v_compid   => v_compid);
    
      OPEN rc FOR v_exesql;
      LOOP
        FETCH rc
          INTO v_cate,
               v_procate,
               v_subcate;
        EXIT WHEN rc%NOTFOUND;
        p_common_queueifldata_generator(v_cate    => v_cate,
                                        v_procate => v_procate,
                                        v_subcate => v_subcate,
                                        v_compid  => v_compid,
                                        v_queueid => v_queueid);
      END LOOP;
      CLOSE rc;
    END IF;
  END p_gen_sswc_iflrows;

  /*===================================================================================
  
    生成 [标准工时+产能品类规划+生产周期] 影响行sql
  
    入参:
      v_queueid      :  队列id
      v_vccond       :  唯一行条件
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成 [标准工时+产能品类规划+生产周期] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_swmc_cpcc_pcc_iflrows_sql
  (
    v_vctab  IN VARCHAR2,
    v_vccond IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_retsql VARCHAR2(4000);
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_retsql := 'SELECT MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SUBCATEGORY) FROM ' ||
                  v_vctab || ' WHERE ' || v_vccond;
    END IF;
  
    RETURN v_retsql;
  END f_get_swmc_cpcc_pcc_iflrows_sql;

  /*===================================================================================
  
    生成 [标准工时+产能品类规划+生产周期] 影响行
  
    入参:
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vctab     :  变更表
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-25 : 生成 [标准工时+产能品类规划+生产周期] 影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_swmc_cpcc_pcc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vctab   IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(8);
    v_subcate VARCHAR2(8);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_get_swmc_cpcc_pcc_iflrows_sql(v_vctab  => v_vctab,
                                                v_vccond => v_vccond);
    IF v_iflsql IS NOT NULL THEN
      EXECUTE IMMEDIATE v_iflsql
        INTO v_cate, v_procate, v_subcate;
    
      p_common_queueifldata_generator(v_cate    => v_cate,
                                      v_procate => v_procate,
                                      v_subcate => v_subcate,
                                      v_compid  => v_compid,
                                      v_queueid => v_queueid);
    END IF;
  END p_gen_swmc_cpcc_pcc_iflrows;

  /*===================================================================================
  
    生成 [供应商产能预约] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-26 : 生成 [供应商产能预约] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_scd_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2 IS
    v_retsql VARCHAR2(4000);
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_retsql := 'SELECT DISTINCT B.SUPPLIER_CODE, C.FACTORY_CODE, B.COOP_CATEGORY, B.COOP_PRODUCTCATE, B.COOP_SUBCATEGORY ' ||
                  'FROM (SELECT * FROM SCMDATA.T_SUPPLIER_CAPACITY_DETAIL WHERE ' ||
                  v_vccond ||
                  ') A LEFT JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG B ON A.SUPPLIER_CODE = B.SUPPLIER_CODE AND A.CATEGORY = B.COOP_CATEGORY ' ||
                  'AND A.COMPANY_ID = B.COMPANY_ID AND B.PAUSE = 0 LEFT JOIN SCMDATA.T_COOPCATE_FACTORY_CFG C ' ||
                  'ON A.FACTORY_CODE = C.FACTORY_CODE AND A.COMPANY_ID = C.COMPANY_ID AND B.CSC_ID = C.CSC_ID AND C.PAUSE = 0';
    END IF;
    RETURN v_retsql;
  END f_get_scd_iflrows_sql;

  /*===================================================================================
  
    生成 [供应商产能预约] 影响行
  
    入参:
  
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-26 : 生成 [供应商产能预约] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_scd_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc        rctype;
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(8);
    v_subcate VARCHAR2(8);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_get_scd_iflrows_sql(v_vccond => v_vccond);
    IF v_iflsql IS NOT NULL THEN
      OPEN rc FOR v_iflsql;
      LOOP
        FETCH rc
          INTO v_supcode,
               v_faccode,
               v_cate,
               v_procate,
               v_subcate;
        EXIT WHEN rc%NOTFOUND;
        p_common_queueifldata_generator(v_supcode => v_supcode,
                                        v_faccode => v_faccode,
                                        v_compid  => v_compid,
                                        v_cate    => v_cate,
                                        v_procate => v_procate,
                                        v_subcate => v_subcate,
                                        v_queueid => v_queueid);
      END LOOP;
      CLOSE rc;
    END IF;
  END p_gen_scd_iflrows;

  /*===================================================================================
  
    生成 [供应商产能预约明细] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-26 : 生成 [供应商产能预约明细] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_cad_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2 IS
    v_retsql VARCHAR2(4000);
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_retsql := 'SELECT DISTINCT B.SUPPLIER_CODE, B.FACTORY_CODE, C.COOP_CATEGORY, C.COOP_PRODUCTCATE, C.COOP_SUBCATEGORY ' ||
                  'FROM (SELECT PTC_ID,COMPANY_ID FROM SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL WHERE ' ||
                  v_vccond ||
                  ') A INNER JOIN SCMDATA.T_SUPPLIER_CAPACITY_DETAIL B ON A.PTC_ID = B.PTC_ID ' ||
                  'AND A.COMPANY_ID = B.COMPANY_ID INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG C ' ||
                  'ON B.SUPPLIER_CODE = C.SUPPLIER_CODE AND B.COMPANY_ID = C.COMPANY_ID ' ||
                  'INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG D ON B.FACTORY_CODE = D.FACTORY_CODE ' ||
                  'AND B.COMPANY_ID = D.COMPANY_ID';
    END IF;
    RETURN v_retsql;
  END f_get_cad_iflrows_sql;

  /*===================================================================================
  
    生成 [供应商产能预约] 影响行
  
    入参:
  
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-26 : 生成 [供应商产能预约] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_cad_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc        rctype;
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(8);
    v_subcate VARCHAR2(8);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_get_cad_iflrows_sql(v_vccond => v_vccond);
    IF v_iflsql IS NOT NULL THEN
      OPEN rc FOR v_iflsql;
      LOOP
        FETCH rc
          INTO v_supcode,
               v_faccode,
               v_cate,
               v_procate,
               v_subcate;
        EXIT WHEN rc%NOTFOUND;
        p_common_queueifldata_generator(v_supcode => v_supcode,
                                        v_faccode => v_faccode,
                                        v_compid  => v_compid,
                                        v_cate    => v_cate,
                                        v_procate => v_procate,
                                        v_subcate => v_subcate,
                                        v_queueid => v_queueid);
      END LOOP;
      CLOSE rc;
    END IF;
  END p_gen_cad_iflrows;

  /*===================================================================================
  
    生成 [预计新品] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-26 : 生成 [预计新品] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_pn_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2 IS
    v_exesql VARCHAR2(4000);
    v_retsql VARCHAR2(4000);
    v_jugnum NUMBER(1);
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_exesql := 'SELECT COUNT(1) FROM SCMDATA.T_PLAN_NEWPRODUCT WHERE ' ||
                  v_vccond || ' AND ROWNUM = 1';
      EXECUTE IMMEDIATE v_exesql
        INTO v_jugnum;
    
      IF v_jugnum = 1 THEN
        v_retsql := 'SELECT A.SUPPLIER_CODE, C.FACTORY_CODE, A.CATEGORY, A.PRODUCT_CATE, A.SUBCATEGORY ' ||
                    'FROM (SELECT SUPPLIER_CODE, COMPANY_ID, CATEGORY, PRODUCT_CATE, SUBCATEGORY FROM SCMDATA.T_PLAN_NEWPRODUCT WHERE ' ||
                    v_vccond ||
                    ') A INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG B ON A.SUPPLIER_CODE = B.SUPPLIER_CODE AND A.CATEGORY = B.COOP_CATEGORY ' ||
                    'AND A.PRODUCT_CATE  = B.COOP_PRODUCTCATE AND A.SUBCATEGORY = B.COOP_SUBCATEGORY AND A.COMPANY_ID = B.COMPANY_ID ' ||
                    'INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG C ON B.CSC_ID = C.CSC_ID AND B.COMPANY_ID = C.COMPANY_ID';
      ELSE
        v_retsql := 'SELECT A.SUPPLIER_CODE, C.FACTORY_CODE, A.CATEGORY, A.PRODUCT_CATE, A.SUBCATEGORY ' ||
                    'FROM (SELECT SUPPLIER_CODE, COMPANY_ID, CATEGORY, PRODUCT_CATE, SUBCATEGORY FROM SCMDATA.T_PLAN_NEWPRODUCT_VIEW WHERE ' ||
                    v_vccond ||
                    ') A INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG B ON A.SUPPLIER_CODE = B.SUPPLIER_CODE AND A.CATEGORY = B.COOP_CATEGORY ' ||
                    'AND A.PRODUCT_CATE  = B.COOP_PRODUCTCATE AND A.SUBCATEGORY = B.COOP_SUBCATEGORY AND A.COMPANY_ID = B.COMPANY_ID ' ||
                    'INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG C ON B.CSC_ID = C.CSC_ID AND B.COMPANY_ID = C.COMPANY_ID';
      END IF;
    END IF;
    RETURN v_retsql;
  END f_get_pn_iflrows_sql;

  /*===================================================================================
  
    生成 [预计新品] 影响行
  
    入参:
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-26 : 生成 [预计新品] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_pn_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc        rctype;
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(8);
    v_subcate VARCHAR2(8);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_get_pn_iflrows_sql(v_vccond => v_vccond);
    IF v_iflsql IS NOT NULL THEN
      OPEN rc FOR v_iflsql;
      LOOP
        FETCH rc
          INTO v_supcode,
               v_faccode,
               v_cate,
               v_procate,
               v_subcate;
        EXIT WHEN rc%NOTFOUND;
        p_common_queueifldata_generator(v_supcode => v_supcode,
                                        v_faccode => v_faccode,
                                        v_compid  => v_compid,
                                        v_cate    => v_cate,
                                        v_procate => v_procate,
                                        v_subcate => v_subcate,
                                        v_queueid => v_queueid);
      END LOOP;
      CLOSE rc;
    END IF;
  END p_gen_pn_iflrows;

  /*===================================================================================
  
    生成 [预计补单] 影响行sql
  
    入参:
      v_vccond       :  唯一行条件
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-26 : 生成 [预计补单] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_get_pns_iflrows_sql(v_vccond IN VARCHAR2) RETURN VARCHAR2 IS
    v_exesql VARCHAR2(4000);
    v_retsql VARCHAR2(4000);
    v_jugnum NUMBER(1);
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_exesql := 'SELECT COUNT(1) FROM SCMDATA.T_PLANNEW_SUPPLEMENTARY WHERE ' ||
                  v_vccond || ' AND ROWNUM = 1';
      EXECUTE IMMEDIATE v_exesql
        INTO v_jugnum;
    
      IF v_jugnum = 1 THEN
        v_retsql := 'SELECT A.SUPPLIER_CODE, C.FACTORY_CODE, A.CATEGORY, A.PRODUCT_CATE, A.SUBCATEGORY ' ||
                    'FROM (SELECT SUPPLIER_CODE, COMPANY_ID, CATEGORY, PRODUCT_CATE, SUBCATEGORY ' ||
                    'FROM SCMDATA.T_PLANNEW_SUPPLEMENTARY WHERE ' ||
                    v_vccond ||
                    ') A INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG B ON A.SUPPLIER_CODE = B.SUPPLIER_CODE ' ||
                    'AND A.CATEGORY = B.COOP_CATEGORY AND A.PRODUCT_CATE = B.COOP_PRODUCTCATE AND ' ||
                    'A.SUBCATEGORY = B.COOP_SUBCATEGORY AND A.COMPANY_ID = B.COMPANY_ID INNER JOIN ' ||
                    'SCMDATA.T_COOPCATE_FACTORY_CFG C ON B.CSC_ID = C.CSC_ID AND B.COMPANY_ID = C.COMPANY_ID';
      ELSE
        v_retsql := 'SELECT A.SUPPLIER_CODE, C.FACTORY_CODE, A.CATEGORY, A.PRODUCT_CATE, A.SUBCATEGORY ' ||
                    'FROM (SELECT SUPPLIER_CODE, COMPANY_ID, CATEGORY, PRODUCT_CATE, SUBCATEGORY ' ||
                    'FROM SCMDATA.T_PLANNEW_SUPPLEMENTARY_VIEW WHERE ' ||
                    v_vccond ||
                    ') A INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG B ON A.SUPPLIER_CODE = B.SUPPLIER_CODE ' ||
                    'AND A.CATEGORY = B.COOP_CATEGORY AND A.PRODUCT_CATE = B.COOP_PRODUCTCATE AND ' ||
                    'A.SUBCATEGORY = B.COOP_SUBCATEGORY AND A.COMPANY_ID = B.COMPANY_ID INNER JOIN ' ||
                    'SCMDATA.T_COOPCATE_FACTORY_CFG C ON B.CSC_ID = C.CSC_ID AND B.COMPANY_ID = C.COMPANY_ID';
      END IF;
    END IF;
    RETURN v_retsql;
  END f_get_pns_iflrows_sql;

  /*===================================================================================
  
    生成 [预计补单] 影响行
  
    入参:
      v_queueid   :  队列id
      v_compid    :  企业id
      v_vccond    :  唯一行条件
  
    版本:
      2022-04-26 : 生成 [预计补单] 影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_pns_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc        rctype;
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(8);
    v_subcate VARCHAR2(8);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_get_pns_iflrows_sql(v_vccond => v_vccond);
    IF v_iflsql IS NOT NULL THEN
      OPEN rc FOR v_iflsql;
      LOOP
        FETCH rc
          INTO v_supcode,
               v_faccode,
               v_cate,
               v_procate,
               v_subcate;
        EXIT WHEN rc%NOTFOUND;
        p_common_queueifldata_generator(v_supcode => v_supcode,
                                        v_faccode => v_faccode,
                                        v_compid  => v_compid,
                                        v_cate    => v_cate,
                                        v_procate => v_procate,
                                        v_subcate => v_subcate,
                                        v_queueid => v_queueid);
      END LOOP;
      CLOSE rc;
    END IF;
  END p_gen_pns_iflrows;

  /*===================================================================================
  
    生成[供应商档案]数据源级影响行
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[供应商档案]数据源级影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_supinfo_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_faccode    VARCHAR2(32);
    v_tmpsupcode VARCHAR2(32);
    v_tmpfaccode VARCHAR2(32);
    v_tmpcate    VARCHAR2(32);
    v_tmpprocate VARCHAR2(32);
    v_tmpsubcate VARCHAR2(32);
    v_exesql     VARCHAR2(4000);
  BEGIN
    v_exesql := 'SELECT MAX(SUPPLIER_CODE) FROM SCMDATA.T_SUPPLIER_INFO WHERE ' ||
                v_vccond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_faccode;
  
    IF v_faccode IS NOT NULL THEN
      FOR i IN (SELECT b.supplier_code,
                       a.factory_code,
                       c.coop_classification,
                       c.coop_product_cate,
                       '' coop_subcategory
                  FROM (SELECT supplier_info_id,
                               company_id,
                               factory_code
                          FROM scmdata.t_coop_factory
                         WHERE factory_code = v_faccode
                           AND company_id = v_compid) a
                 INNER JOIN scmdata.t_supplier_info b
                    ON a.supplier_info_id = b.supplier_info_id
                   AND a.company_id = b.company_id
                 INNER JOIN scmdata.t_coop_scope c
                    ON b.supplier_info_id = c.supplier_info_id
                   AND b.company_id = c.company_id
                 GROUP BY b.supplier_code,
                          a.factory_code,
                          c.coop_classification,
                          c.coop_product_cate) LOOP
        --生成影响行
        p_common_queueifldata_generator(v_supcode => i.supplier_code,
                                        v_faccode => i.factory_code,
                                        v_cate    => i.coop_classification,
                                        v_procate => i.coop_product_cate,
                                        v_subcate => i.coop_subcategory,
                                        v_queueid => v_queueid,
                                        v_compid  => v_compid);
      
        v_tmpsupcode := i.supplier_code;
        v_tmpfaccode := i.factory_code;
        v_tmpcate    := i.coop_classification;
        v_tmpprocate := i.coop_product_cate;
        v_tmpsubcate := i.coop_subcategory;
      END LOOP;
    END IF;
  END p_gen_supinfo_iflrows;

  /*===================================================================================
  
    iflrowslogic
    获取供应商档案启停生成影响行逻辑的sql
  
    入参:
      v_vccond  :  值变更唯一条件
  
    返回值:
      可执行的sql语句
  
    版本:
      2022-08-08 : 获取供应商档案启停生成影响行逻辑的sql
  
  ===================================================================================*/
  FUNCTION f_get_supdoc_iflrows_sql(v_vccond IN VARCHAR2) RETURN CLOB IS
    v_exesql CLOB;
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_exesql := 'SELECT MAX(SUPPLIER_CODE), MAX(COMPANY_ID) FROM SCMDATA.T_SUPPLIER_INFO WHERE ' ||
                  v_vccond;
    END IF;
  
    RETURN v_exesql;
  END f_get_supdoc_iflrows_sql;

  /*===================================================================================
  
    iflrowslogic
    供应商档案合作状态变更影响行逻辑
  
    入参:
      v_queueid  :  供应商编码
      v_compid   :  企业id
  
    版本:
      2022-08-08 : 供应商档案合作状态变更影响行逻辑
  
  ===================================================================================*/
  PROCEDURE p_supdoc_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2
  ) IS
    v_iflsql   CLOB;
    v_tsupcode VARCHAR2(32);
    v_tcompid  VARCHAR2(32);
  BEGIN
    v_iflsql := f_get_supdoc_iflrows_sql(v_vccond => v_vccond);
  
    IF v_iflsql IS NOT NULL THEN
      EXECUTE IMMEDIATE v_iflsql
        INTO v_tsupcode, v_tcompid;
      p_common_queueifldata_generator(v_supcode => v_tsupcode,
                                      v_compid  => v_tcompid,
                                      v_queueid => v_queueid);
    
      p_common_queueifldata_generator(v_faccode => v_tsupcode,
                                      v_compid  => v_tcompid,
                                      v_queueid => v_queueid);
    END IF;
  END p_supdoc_iflrows;

  /*===================================================================================
  
    生成[供应商档案-合作工厂]数据源级影响行
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[供应商档案-合作工厂]数据源级影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_coopfac_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  
    v_coopfacid  VARCHAR2(32);
    v_tmpsupcode VARCHAR2(32);
    v_tmpfaccode VARCHAR2(32);
    v_tmpcate    VARCHAR2(32);
    v_tmpprocate VARCHAR2(32);
    v_tmpsubcate VARCHAR2(32);
    v_exesql     VARCHAR2(4000);
  BEGIN
    v_exesql := 'SELECT MAX(COOP_FACTORY_ID) FROM SCMDATA.T_COOP_FACTORY WHERE ' ||
                v_vccond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_coopfacid;
  
    IF v_coopfacid IS NOT NULL THEN
      FOR i IN (SELECT b.supplier_code,
                       a.factory_code,
                       c.coop_classification,
                       c.coop_product_cate,
                       '' coop_subcategory
                  FROM (SELECT supplier_info_id,
                               company_id,
                               factory_code
                          FROM scmdata.t_coop_factory
                         WHERE coop_factory_id = v_coopfacid
                           AND company_id = v_compid) a
                 INNER JOIN scmdata.t_supplier_info b
                    ON a.supplier_info_id = b.supplier_info_id
                   AND a.company_id = b.company_id
                 INNER JOIN scmdata.t_coop_scope c
                    ON b.supplier_info_id = c.supplier_info_id
                   AND b.company_id = c.company_id
                 GROUP BY b.supplier_code,
                          a.factory_code,
                          c.coop_classification,
                          c.coop_product_cate) LOOP
        --生成影响行
        p_common_queueifldata_generator(v_supcode => i.supplier_code,
                                        v_faccode => i.factory_code,
                                        v_cate    => i.coop_classification,
                                        v_procate => i.coop_product_cate,
                                        v_subcate => i.coop_subcategory,
                                        v_queueid => v_queueid,
                                        v_compid  => v_compid);
      
        v_tmpsupcode := i.supplier_code;
        v_tmpfaccode := i.factory_code;
        v_tmpcate    := i.coop_classification;
        v_tmpprocate := i.coop_product_cate;
        v_tmpsubcate := i.coop_subcategory;
      END LOOP;
    END IF;
  END p_gen_coopfac_iflrows;

  /*===================================================================================
  
    iflrowslogic
    供应商档案合作工厂变更影响行生成 sql
  
    入参:
      v_vccond  :  供应商档案合作工厂唯一行条件
  
    返回值:
      可执行的sql语句
  
    版本:
      2022-08-09 : 供应商档案合作工厂变更影响行生成 sql
  
  ===================================================================================*/
  FUNCTION f_get_supfac_iu_iflrows_sql(v_vccond IN VARCHAR2) RETURN CLOB IS
    v_exesql CLOB;
  BEGIN
    IF v_vccond IS NOT NULL THEN
      v_exesql := 'SELECT TSI.SUPPLIER_CODE, TTSI.SUPPLIER_CODE FACTORY_CODE, TSI.COMPANY_ID, ' ||
                  'CSC.COOP_CATEGORY, CSC.COOP_PRODUCTCATE, CSC.COOP_SUBCATEGORY ' ||
                  'FROM (SELECT SUPPLIER_INFO_ID,FAC_SUP_INFO_ID,COMPANY_ID,FACTORY_CODE ' ||
                  'FROM SCMDATA.T_COOP_FACTORY WHERE ' || v_vccond ||
                  ') TCF INNER JOIN SCMDATA.T_SUPPLIER_INFO TSI ON TCF.SUPPLIER_INFO_ID = ' ||
                  'TSI.SUPPLIER_INFO_ID AND TCF.COMPANY_ID = TSI.COMPANY_ID INNER JOIN ' ||
                  'SCMDATA.T_COOP_SCOPE TCS ON TSI.SUPPLIER_INFO_ID = TCS.SUPPLIER_INFO_ID ' ||
                  'AND TSI.COMPANY_ID = TCS.COMPANY_ID INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG ' ||
                  'CSC ON CSC.COOP_CATEGORY = TCS.COOP_CLASSIFICATION AND CSC.COOP_PRODUCTCATE = ' ||
                  'TCS.COOP_PRODUCT_CATE AND INSTR(TCS.COOP_SUBCATEGORY, CSC.COOP_SUBCATEGORY) > 0 ' ||
                  'AND TSI.SUPPLIER_CODE = CSC.SUPPLIER_CODE AND TSI.COMPANY_ID = CSC.COMPANY_ID ' ||
                  'INNER JOIN SCMDATA.T_SUPPLIER_INFO TTSI ON TCF.FAC_SUP_INFO_ID = ' ||
                  'TTSI.SUPPLIER_INFO_ID AND TCF.COMPANY_ID = TTSI.COMPANY_ID';
    END IF;
  
    RETURN v_exesql;
  END f_get_supfac_iu_iflrows_sql;

  /*===================================================================================
  
    iflrowslogic
    供应商档案合作工厂变更影响行逻辑
  
    入参:
      v_queueid  :  供应商编码
      v_vccond   :  唯一行条件
      v_compid   :  企业id
  
    版本:
      2022-08-05 : 供应商档案合作工厂变更影响行逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfac_iu_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    sfiurc     rctype;
    v_iflsql   CLOB;
    v_tsupcode VARCHAR2(32);
    v_tfaccode VARCHAR2(32);
    v_tcate    VARCHAR2(2);
    v_tprocate VARCHAR2(4);
    v_tsubcate VARCHAR2(8);
    v_tcompid  VARCHAR2(32);
  BEGIN
    v_iflsql := f_get_supfac_iu_iflrows_sql(v_vccond => v_vccond);
  
    IF v_iflsql IS NOT NULL THEN
      OPEN sfiurc FOR v_iflsql;
      LOOP
        FETCH sfiurc
          INTO v_tsupcode,
               v_tfaccode,
               v_tcompid,
               v_tcate,
               v_tprocate,
               v_tsubcate;
        EXIT WHEN sfiurc%NOTFOUND;
        IF v_tsupcode IS NOT NULL THEN
          p_common_queueifldata_generator(v_supcode => v_tsupcode,
                                          v_faccode => v_tfaccode,
                                          v_cate    => v_tcate,
                                          v_procate => v_tprocate,
                                          v_subcate => v_tsubcate,
                                          v_queueid => v_queueid,
                                          v_compid  => v_tcompid);
        END IF;
      END LOOP;
      CLOSE sfiurc;
    END IF;
  END p_supfac_iu_iflrows;

  /*===================================================================================
  
    生成[供应商档案-合作范围]数据源级影响行
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[供应商档案-合作范围]数据源级影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_coopscp_iflrows
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  
    v_coopscpid  VARCHAR2(32);
    v_tmpsupcode VARCHAR2(32);
    v_tmpfaccode VARCHAR2(32);
    v_tmpcate    VARCHAR2(32);
    v_tmpprocate VARCHAR2(32);
    v_tmpsubcate VARCHAR2(32);
    v_exesql     VARCHAR2(4000);
  BEGIN
    v_exesql := 'SELECT MAX(COOP_SCOPE_ID) FROM SCMDATA.T_COOP_SCOPE WHERE ' ||
                v_vccond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_coopscpid;
  
    IF v_coopscpid IS NOT NULL THEN
      FOR i IN (SELECT b.supplier_code,
                       c.factory_code,
                       a.coop_classification,
                       a.coop_product_cate,
                       '' coop_subcategory
                  FROM (SELECT supplier_info_id,
                               company_id,
                               coop_classification,
                               coop_product_cate,
                               coop_subcategory
                          FROM scmdata.t_coop_scope
                         WHERE coop_scope_id = v_coopscpid
                           AND company_id = v_compid) a
                 INNER JOIN scmdata.t_supplier_info b
                    ON a.supplier_info_id = b.supplier_info_id
                   AND a.company_id = b.company_id
                 INNER JOIN scmdata.t_coop_factory c
                    ON b.supplier_info_id = c.supplier_info_id
                   AND b.company_id = c.company_id
                 GROUP BY b.supplier_code,
                          c.factory_code,
                          a.coop_classification,
                          a.coop_product_cate) LOOP
        --生成影响行
        p_common_queueifldata_generator(v_supcode => i.supplier_code,
                                        v_faccode => i.factory_code,
                                        v_cate    => i.coop_classification,
                                        v_procate => i.coop_product_cate,
                                        v_subcate => i.coop_subcategory,
                                        v_queueid => v_queueid,
                                        v_compid  => v_compid);
      
        v_tmpsupcode := i.supplier_code;
        v_tmpfaccode := i.factory_code;
        v_tmpcate    := i.coop_classification;
        v_tmpprocate := i.coop_product_cate;
        v_tmpsubcate := i.coop_subcategory;
      END LOOP;
    END IF;
  
  END p_gen_coopscp_iflrows;

  /*===================================================================================
  
    iflrowslogic
    获取供应商合作范围影响行数据生成sql
  
    入参:
      v_queueid  :  队列id
      v_cond     :  唯一行条件
      v_compid   :  企业id
  
    版本:
      2022-08-09 : 获取供应商合作范围影响行数据生成sql
  
  ===================================================================================*/
  PROCEDURE p_gen_supscp_iflrows
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_rawcate    VARCHAR2(2);
    v_curcate    VARCHAR2(2);
    v_rawprocate VARCHAR2(4);
    v_curprocate VARCHAR2(4);
    v_rawsubcate VARCHAR2(4000);
    v_cursubcate VARCHAR2(4000);
    v_supcode    VARCHAR2(32);
    v_exesql     VARCHAR2(4000);
  BEGIN
    SELECT MAX(CASE
                 WHEN vc_col = 'COOP_CLASSIFICATION' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOP_CLASSIFICATION' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOP_PRODUCT_CATE' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOP_PRODUCT_CATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOP_SUBCATEGORY' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOP_SUBCATEGORY' THEN
                  vc_curval
               END)
      INTO v_rawcate,
           v_curcate,
           v_rawprocate,
           v_curprocate,
           v_rawsubcate,
           v_cursubcate
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    v_exesql := 'SELECT MAX(TSI.SUPPLIER_CODE) FROM (SELECT SUPPLIER_INFO_ID,COMPANY_ID ' ||
                'FROM SCMDATA.T_COOP_SCOPE WHERE ' || v_cond ||
                ') TCS INNER JOIN SCMDATA.T_SUPPLIER_INFO TSI ' ||
                'ON TCS.SUPPLIER_INFO_ID = TSI.SUPPLIER_INFO_ID ' ||
                'AND TCS.COMPANY_ID = TSI.COMPANY_ID';
  
    EXECUTE IMMEDIATE v_exesql
      INTO v_supcode;
  
    IF v_rawsubcate IS NOT NULL THEN
      --as supplier
      p_common_queueifldata_generator(v_supcode => v_supcode,
                                      v_cate    => v_rawcate,
                                      v_procate => v_rawprocate,
                                      v_subcate => v_rawsubcate,
                                      v_queueid => v_queueid,
                                      v_compid  => v_compid);
    
      --as factory
      p_common_queueifldata_generator(v_faccode => v_supcode,
                                      v_cate    => v_rawcate,
                                      v_procate => v_rawprocate,
                                      v_subcate => v_rawsubcate,
                                      v_queueid => v_queueid,
                                      v_compid  => v_compid);
    END IF;
  
    --as supplier
    p_common_queueifldata_generator(v_supcode => v_supcode,
                                    v_cate    => v_curcate,
                                    v_procate => v_curprocate,
                                    v_subcate => v_cursubcate,
                                    v_queueid => v_queueid,
                                    v_compid  => v_compid);
  
    --as factory
    p_common_queueifldata_generator(v_faccode => v_supcode,
                                    v_cate    => v_curcate,
                                    v_procate => v_curprocate,
                                    v_subcate => v_cursubcate,
                                    v_queueid => v_queueid,
                                    v_compid  => v_compid);
  END p_gen_supscp_iflrows;

  /*===================================================================================
  
    生成[下单列表-ordered]数据源级影响sql
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成[下单列表-ordered]数据源级影响sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_ordered_iflrows_sql
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_vccond VARCHAR2(512);
    v_rawsup VARCHAR2(32);
    v_cursup VARCHAR2(32);
    v_retsql VARCHAR2(4000);
  BEGIN
    SELECT MAX(CASE
                 WHEN vc_col = 'SUPPLIER_CODE' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUPPLIER_CODE' THEN
                  vc_curval
               END),
           MAX(vc_cond)
      INTO v_rawsup,
           v_cursup,
           v_vccond
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_rawsup IS NOT NULL THEN
      v_retsql := 'SELECT DISTINCT TAB1.SUPPLIER_CODE, TAB2.FACTORY_CODE, TAB1.COOP_CATEGORY, TAB1.COOP_PRODUCTCATE, TAB1.COOP_SUBCATEGORY ' ||
                  'FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG TAB1 INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG TAB2 ON TAB1.CSC_ID = TAB2.CSC_ID ' ||
                  'AND TAB1.COMPANY_ID = TAB2.COMPANY_ID WHERE TAB1.SUPPLIER_CODE IN (''' ||
                  nvl(v_rawsup, ' ') || ''', ''' || nvl(v_cursup, ' ') ||
                  ''') AND TAB1.COMPANY_ID = ''' || v_compid || '''';
    END IF;
  
    RETURN v_retsql;
  END f_gen_ordered_iflrows_sql;

  /*===================================================================================
  
    生成[下单列表-ordered]数据源级影响sql
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[下单列表-ordered]数据源级影响sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_ordered_iflrows
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc        rctype;
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(4);
    v_subcate VARCHAR2(8);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_gen_ordered_iflrows_sql(v_queueid => v_queueid,
                                          v_compid  => v_compid);
    IF v_iflsql IS NOT NULL THEN
      OPEN rc FOR v_iflsql;
      LOOP
        FETCH rc
          INTO v_supcode,
               v_faccode,
               v_cate,
               v_procate,
               v_subcate;
        EXIT WHEN rc%NOTFOUND;
        p_common_queueifldata_generator(v_supcode => v_supcode,
                                        v_faccode => v_faccode,
                                        v_cate    => v_cate,
                                        v_procate => v_procate,
                                        v_subcate => v_subcate,
                                        v_queueid => v_queueid,
                                        v_compid  => v_compid);
      END LOOP;
      CLOSE rc;
    END IF;
  END p_gen_ordered_iflrows;

  /*===================================================================================
  
    生成 [下单列表-orders] 数据源级影响行
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂及对应的分类-生产分类-子类
  
    版本:
      2022-04-25 : 生成 [下单列表-orders] 数据源级影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_orders_iflrows_sql
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_vccond VARCHAR2(512);
    v_rawfac VARCHAR2(32);
    v_curfac VARCHAR2(32);
    v_curdel VARCHAR2(64);
    v_exesql VARCHAR2(4000);
    v_retsql VARCHAR2(4000);
  BEGIN
    SELECT MAX(CASE
                 WHEN vc_col = 'FACTORY_CODE' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'FACTORY_CODE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'DELIVERY_DATE' THEN
                  vc_curval
               END),
           MAX(vc_cond)
      INTO v_rawfac,
           v_curfac,
           v_curdel,
           v_vccond
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_rawfac IS NOT NULL THEN
      v_retsql := 'SELECT DISTINCT TAB1.SUPPLIER_CODE, TAB2.FACTORY_CODE, TAB1.COOP_CATEGORY, TAB1.COOP_PRODUCTCATE, TAB1.COOP_SUBCATEGORY ' ||
                  'FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG TAB1 INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG TAB2 ON TAB1.CSC_ID = TAB2.CSC_ID ' ||
                  'AND TAB1.COMPANY_ID = TAB2.COMPANY_ID WHERE TAB2.FACTORY_CODE IN (''' ||
                  nvl(v_rawfac, ' ') || ''', ''' || nvl(v_curfac, ' ') ||
                  ''') AND TAB1.COMPANY_ID = ''' || v_compid || '''';
    ELSIF v_curdel IS NOT NULL THEN
      v_exesql := 'SELECT MAX(FACTORY_CODE) FROM SCMDATA.T_ORDERS WHERE ' ||
                  v_vccond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_curfac;
    
      v_retsql := 'SELECT DISTINCT TAB1.SUPPLIER_CODE, TAB2.FACTORY_CODE, TAB1.COOP_CATEGORY, TAB1.COOP_PRODUCTCATE, TAB1.COOP_SUBCATEGORY ' ||
                  'FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG TAB1 INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG TAB2 ON TAB1.CSC_ID = TAB2.CSC_ID ' ||
                  'AND TAB1.COMPANY_ID = TAB2.COMPANY_ID WHERE TAB2.FACTORY_CODE = ''' ||
                  nvl(v_curfac, ' ') || ''' AND TAB1.COMPANY_ID = ''' ||
                  v_compid || '''';
    END IF;
  
    RETURN v_retsql;
  END f_gen_orders_iflrows_sql;

  /*===================================================================================
  
    生成[下单列表-ordered]数据源级影响sql
  
    入参:
      v_queueid   :  队列id
      v_vccond    :  唯一行条件
      v_compid    :  企业id
  
    版本:
      2022-04-25 : 生成[下单列表-ordered]数据源级影响sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_orders_iflrows
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc        rctype;
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(4);
    v_subcate VARCHAR2(8);
    v_iflsql  VARCHAR2(4000);
  BEGIN
    v_iflsql := f_gen_orders_iflrows_sql(v_queueid => v_queueid,
                                         v_compid  => v_compid);
    IF v_iflsql IS NOT NULL THEN
      OPEN rc FOR v_iflsql;
      LOOP
        FETCH rc
          INTO v_supcode,
               v_faccode,
               v_cate,
               v_procate,
               v_subcate;
        EXIT WHEN rc%NOTFOUND;
        p_common_queueifldata_generator(v_supcode => v_supcode,
                                        v_faccode => v_faccode,
                                        v_cate    => v_cate,
                                        v_procate => v_procate,
                                        v_subcate => v_subcate,
                                        v_queueid => v_queueid,
                                        v_compid  => v_compid);
      END LOOP;
      CLOSE rc;
    END IF;
  END p_gen_orders_iflrows;

  /*===================================================================================
  
    生成[订单数据接入]数据源级影响行sql
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂、分类、生产分类、子类
  
    版本:
      2022-04-25 : 生成[订单数据接入]数据源级影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  FUNCTION f_gen_orditf_iflrows_sql
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_sql VARCHAR2(4000);
  BEGIN
    v_sql := 'SELECT DISTINCT MAX(A.SUPPLIER_CODE), MAX(B.FACTORY_CODE), MAX(C.CATEGORY), ' ||
             'MAX(C.PRODUCT_CATE), MAX(C.SAMLL_CATEGORY) FROM SCMDATA.T_ORDERED A INNER JOIN ' ||
             'SCMDATA.T_ORDERS B ON A.ORDER_CODE = B.ORDER_ID AND A.COMPANY_ID = B.COMPANY_ID ' ||
             'LEFT JOIN SCMDATA.T_COMMODITY_INFO C ON B.GOO_ID = C.GOO_ID AND B.COMPANY_ID = C.COMPANY_ID ' ||
             'INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG D ON A.SUPPLIER_CODE = D.SUPPLIER_CODE ' ||
             'AND C.CATEGORY = D.COOP_CATEGORY AND C.PRODUCT_CATE = D.COOP_PRODUCTCATE ' ||
             'AND C.SAMLL_CATEGORY = D.COOP_SUBCATEGORY AND C.COMPANY_ID = D.COMPANY_ID AND D.PAUSE = 0 ' ||
             'INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG E ON D.CSC_ID = E.CSC_ID AND D.COMPANY_ID = E.COMPANY_ID ' ||
             'AND B.FACTORY_CODE = E.FACTORY_CODE AND E.PAUSE = 0 INNER JOIN SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG F ' ||
             'ON C.CATEGORY = F.CATEGORY AND C.PRODUCT_CATE = F.PRODUCT_CATE AND C.SAMLL_CATEGORY = F.SUBCATEGORY ' ||
             'AND C.COMPANY_ID = F.COMPANY_ID AND F.IN_PLANNING = 1 WHERE (A.ORDER_CODE,A.COMPANY_ID) IN (SELECT ORDER_ID,COMPANY_ID FROM ' ||
             'SCMDATA.T_QUEUE_ORDITFPSYNC WHERE QUEUE_ID = ''' || v_queueid ||
             ''' AND COMPANY_ID = ''' || v_compid || ''')';
  
    RETURN v_sql;
  END f_gen_orditf_iflrows_sql;

  /*===================================================================================
  
    生成[订单数据接入]数据源级影响行sql
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂、分类、生产分类、子类
  
    版本:
      2022-04-25 : 生成[订单数据接入]数据源级影响行sql
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_gen_orditf_iflrows
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc        rctype;
    v_sql     CLOB;
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(4);
    v_subcate VARCHAR2(8);
  BEGIN
    --获取cps，供应商编码，生产工厂编码
    v_sql := f_gen_orditf_iflrows_sql(v_queueid => v_queueid,
                                      v_compid  => v_compid);
  
    OPEN rc FOR v_sql;
    LOOP
      FETCH rc
        INTO v_supcode,
             v_faccode,
             v_cate,
             v_procate,
             v_subcate;
      EXIT WHEN rc%NOTFOUND;
    
      --生成影响行
      p_common_queueifldata_generator(v_supcode => v_supcode,
                                      v_faccode => v_faccode,
                                      v_cate    => v_cate,
                                      v_procate => v_procate,
                                      v_subcate => v_subcate,
                                      v_queueid => v_queueid,
                                      v_compid  => v_compid);
    END LOOP;
    CLOSE rc;
  END p_gen_orditf_iflrows;

  /*===================================================================================
  
    生成“指定工厂”影响行
  
    入参:
      v_inp_queueid  :  队列id
      v_inp_ordid    :  订单id
      v_inp_compid   :  企业id
  
    版本:
      2022-12-17_zc314 : 生成“指定工厂”影响行
  
  ===================================================================================*/
  PROCEDURE p_gen_specify_ordfactory_iflrows
  (
    v_inp_queueid IN VARCHAR2,
    v_inp_ordid   IN VARCHAR2,
    v_inp_compid  IN VARCHAR2
  ) IS
    v_supcode VARCHAR2(32);
    v_cate    VARCHAR2(2);
  BEGIN
    --获取供应商，分类
    SELECT MAX(orded.supplier_code),
           MAX(goo.category)
      INTO v_supcode,
           v_cate
      FROM scmdata.t_ordered orded
     INNER JOIN scmdata.t_orders ords
        ON orded.order_code = ords.order_id
       AND orded.company_id = ords.company_id
      LEFT JOIN scmdata.t_commodity_info goo
        ON ords.goo_id = goo.goo_id
       AND ords.company_id = goo.company_id
     WHERE orded.order_code = v_inp_ordid
       AND orded.company_id = v_inp_compid;
  
    --生成影响行
    p_common_queueifldata_generator(v_supcode => v_supcode,
                                    v_cate    => v_cate,
                                    v_queueid => v_inp_queueid,
                                    v_compid  => v_inp_compid);
  END p_gen_specify_ordfactory_iflrows;

  /*===================================================================================
    
    生成工厂生产分类占比影响行 Sql
    
    入参:
      v_inp_table_name  :  表名
      v_inp_cond        :  唯一行条件
    
    返回值:
      可执行的sql语句，用于查出关联分类-生产分类-子类
    
    版本:
      2023-04-28 : 生成工厂生产分类占比影响行 Sql
    
  ===================================================================================*/
  FUNCTION f_get_capc_fac_procate_rate_cfg_iflrows_sql
  (
    v_inp_table_name IN VARCHAR2,
    v_inp_cond_sql   IN VARCHAR2
  ) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    IF v_inp_cond_sql IS NOT NULL THEN
      v_sql := 'select max(supplier_code), max(factory_code), max(category), max(product_cate) from ' ||
               v_inp_table_name || ' where ' || v_inp_cond_sql;
    END IF;
  
    RETURN v_sql;
  END f_get_capc_fac_procate_rate_cfg_iflrows_sql;

  /*===================================================================================
    
    生成“工厂生产类别分配占比”影响行
    
    入参:
      v_inp_queue_id    :  队列id
      v_inp_table_name  :  表名
      v_inp_cond_sql    :  条件Sql
      v_inp_company_id  :  企业Id
    
    版本:
      2023-04-28_zc314 : 生成“工厂生产类别分配占比”影响行
    
  ===================================================================================*/
  PROCEDURE p_gen_capc_fac_procate_rate_cfg_iflrows
  (
    v_inp_queue_id   IN VARCHAR2,
    v_inp_table_name IN VARCHAR2,
    v_inp_cond_sql   IN VARCHAR2,
    v_inp_company_id IN VARCHAR2
  ) IS
    v_sql           CLOB;
    v_supplier_code VARCHAR2(32);
    v_factory_code  VARCHAR2(32);
    v_category      VARCHAR2(2);
    v_product_cate  VARCHAR2(4);
  BEGIN
    --获取影响行数据 Sql
    v_sql := f_get_capc_fac_procate_rate_cfg_iflrows_sql(v_inp_table_name => v_inp_table_name,
                                                         v_inp_cond_sql   => v_inp_cond_sql);
  
    --执行数据获取 Sql 
    EXECUTE IMMEDIATE v_sql
      INTO v_supplier_code, v_factory_code, v_category, v_product_cate;
  
    --通用队列影响行生成
    p_common_queueifldata_generator(v_supcode => v_supplier_code,
                                    v_faccode => v_factory_code,
                                    v_cate    => v_category,
                                    v_procate => v_product_cate,
                                    v_queueid => v_inp_queue_id,
                                    v_compid  => v_inp_company_id);
  END p_gen_capc_fac_procate_rate_cfg_iflrows;

  /*===================================================================================
    
    生成供应商产品子类分配占比 Sql
    
    入参:
      v_inp_table_name  :  表名
      v_inp_cond        :  唯一行条件
    
    返回值:
      可执行的sql语句，用于查出关联分类-生产分类-子类
    
    版本:
      2023-04-28 : 生成供应商产品子类分配占比 Sql
    
  ===================================================================================*/
  FUNCTION f_get_capc_sup_subcate_rate_cfg_iflrows_sql
  (
    v_inp_table_name IN VARCHAR2,
    v_inp_cond_sql   IN VARCHAR2
  ) RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    IF v_inp_cond_sql IS NOT NULL THEN
      v_sql := 'select max(supplier_code), max(category), max(product_cate), max(subcategory) from ' ||
               v_inp_table_name || ' where ' || v_inp_cond_sql;
    END IF;
  
    RETURN v_sql;
  END f_get_capc_sup_subcate_rate_cfg_iflrows_sql;

  /*===================================================================================
    
    生成“供应商产品子类分配占比”影响行
    
    入参:
      v_inp_queue_id    :  队列id
      v_inp_table_name  :  表名
      v_inp_cond_sql    :  条件Sql
      v_inp_company_id  :  企业Id
    
    版本:
      2023-04-28_zc314 : 生成“供应商产品子类分配占比”影响行
    
  ===================================================================================*/
  PROCEDURE p_gen_capc_sup_subcate_rate_cfg_iflrows
  (
    v_inp_queue_id   IN VARCHAR2,
    v_inp_table_name IN VARCHAR2,
    v_inp_cond_sql   IN VARCHAR2,
    v_inp_company_id IN VARCHAR2
  ) IS
    v_sql           CLOB;
    v_supplier_code VARCHAR2(32);
    v_category      VARCHAR2(2);
    v_product_cate  VARCHAR2(4);
    v_subcategory   VARCHAR2(32);
  BEGIN
    --获取影响行数据 Sql
    v_sql := f_get_capc_sup_subcate_rate_cfg_iflrows_sql(v_inp_table_name => v_inp_table_name,
                                                         v_inp_cond_sql   => v_inp_cond_sql);
  
    --执行数据获取 Sql 
    EXECUTE IMMEDIATE v_sql
      INTO v_supplier_code, v_category, v_product_cate, v_subcategory;
  
    --通用队列影响行生成
    p_common_queueifldata_generator(v_supcode => v_supplier_code,
                                    v_cate    => v_category,
                                    v_procate => v_product_cate,
                                    v_subcate => v_subcategory,
                                    v_queueid => v_inp_queue_id,
                                    v_compid  => v_inp_company_id);
  
  END p_gen_capc_sup_subcate_rate_cfg_iflrows;

  /*===================================================================================
  
    涉及影响行算法
  
    用途:
      用于涉及供应商产能预约增删改生成对应影响行
  
    用于:
      产能部分，规则：
      对所有数据维度不同的表（除配置表外），统一进行关联抽象出伪列，
      分别以供应商+生产工厂/cps/供应商+生产工厂+cps为维度进行抽象
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    版本:
      2022-04-25 : 用于涉及供应商产能预约增删改生成对应影响行
      2022-08-08 : 影响行重构——调整影响行分别生成为使用生成过程统一生成
  
  ===================================================================================*/
  PROCEDURE p_influencerows_core
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_vctab  VARCHAR2(64);
    v_vccond VARCHAR2(512);
  BEGIN
    SELECT MAX(vc_tab),
           MAX(vc_cond)
      INTO v_vctab,
           v_vccond
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_vctab = 'SCMDATA.T_COOPCATE_SUPPLIER_CFG' THEN
      p_gen_csc_iflrows(v_queueid => v_queueid,
                        v_vccond  => v_vccond,
                        v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_COOPCATE_FACTORY_CFG' THEN
      p_gen_cfc_iflrows(v_queueid => v_queueid,
                        v_vccond  => v_vccond,
                        v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_APP_CAPACITY_CFG' THEN
      p_gen_acc_iflrows(v_queueid => v_queueid,
                        v_vccond  => v_vccond,
                        v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_SUPPLIER_START_WORK_CFG' THEN
      p_gen_sswc_iflrows(v_queueid => v_queueid, v_compid => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_STANDARD_WORK_MINTE_CFG'
          OR v_vctab = 'SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG'
          OR v_vctab = 'SCMDATA.T_PRODUCT_CYCLE_CFG' THEN
      p_gen_swmc_cpcc_pcc_iflrows(v_queueid => v_queueid,
                                  v_compid  => v_compid,
                                  v_vctab   => v_vctab,
                                  v_vccond  => v_vccond);
    
    ELSIF v_vctab = 'SCMDATA.T_SUPPLIER_CAPACITY_DETAIL' THEN
      p_gen_scd_iflrows(v_queueid => v_queueid,
                        v_vccond  => v_vccond,
                        v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL' THEN
      p_gen_cad_iflrows(v_queueid => v_queueid,
                        v_vccond  => v_vccond,
                        v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_PLAN_NEWPRODUCT' THEN
      p_gen_pn_iflrows(v_queueid => v_queueid,
                       v_vccond  => v_vccond,
                       v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_PLANNEW_SUPPLEMENTARY' THEN
      p_gen_pns_iflrows(v_queueid => v_queueid,
                        v_vccond  => v_vccond,
                        v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_SUPPLIER_INFO' THEN
      p_supdoc_iflrows(v_queueid => v_queueid, v_vccond => v_vccond);
    
    ELSIF v_vctab = 'SCMDATA.T_COOP_SCOPE' THEN
      p_gen_supscp_iflrows(v_queueid => v_queueid,
                           v_cond    => v_vccond,
                           v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_COOP_FACTORY' THEN
      p_supfac_iu_iflrows(v_queueid => v_queueid, v_vccond => v_vccond);
    
    ELSIF v_vctab = 'SCMDATA.T_ORDERED' THEN
      p_gen_ordered_iflrows(v_queueid => v_queueid, v_compid => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_ORDERS' THEN
      p_gen_orders_iflrows(v_queueid => v_queueid, v_compid => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_CAPC_FAC_PROCATE_RATE_CFG' THEN
      p_gen_capc_fac_procate_rate_cfg_iflrows(v_inp_queue_id   => v_queueid,
                                              v_inp_table_name => v_vctab,
                                              v_inp_cond_sql   => v_vccond,
                                              v_inp_company_id => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_CAPC_SUP_SUBCATE_RATE_CFG' THEN
      p_gen_capc_sup_subcate_rate_cfg_iflrows(v_inp_queue_id   => v_queueid,
                                              v_inp_table_name => v_vctab,
                                              v_inp_cond_sql   => v_vccond,
                                              v_inp_company_id => v_compid);
    
    END IF;
  END p_influencerows_core;

END pkg_capacity_iflrow;
/

