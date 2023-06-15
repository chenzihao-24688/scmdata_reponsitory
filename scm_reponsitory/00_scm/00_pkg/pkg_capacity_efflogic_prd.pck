CREATE OR REPLACE PACKAGE SCMDATA.pkg_capacity_efflogic_prd IS

  /*===================================================================================
  
    根据影响行判断是否要重算周产能数据
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业Id
  
    版本:
      2022-08-15  : 根据影响行判断是否要重算周产能数据
  
  ===================================================================================*/
  FUNCTION f_get_isrecalc_weekplancapc
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER;

  /*===================================================================================
  
    生产工厂预约产能占比置零
  
    用途:
      供应商档案停用，合作工厂停用，合作范围停用，
      品类合作供应商停用，品类合作生产工厂停用
  
    入参:
      V_SUPCODE    :  供应商编码
      V_FACCODE    :  生产工厂编码
      V_CATE       :  分类Id
      V_COMPID     :  企业Id
  
    版本:
      2022-09-28 : 品类合作供应商生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_set_appcapcratetozero
  (
    v_supcode  IN VARCHAR2,
    v_faccode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    周产能规划部分删除
  
    用途:
      周产能规划部分删除
  
    入参:
      V_SUPCODE   :  供应商编码
      V_FACCODE   :  生产工厂编码
      V_COMPID    :  企业Id
      V_MINDATE   :  最小执行日期
  
    版本:
      2022-03-08  : 周产能规划部分删除
  
  ===================================================================================*/
  PROCEDURE p_delete_wkplandata
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_mindate IN DATE
  );

  /*=================================================================================
  
    待重算工厂剩余产能占比表新增
  
    用途:
      用于新增待重算工厂剩余产能占比表数据
  
    入参:
      V_FACCODE  :  企业
      V_COMPID   :  企业Id
  
    版本:
      2022-01-13 : 手动修改调度器状态（自治事务）
      2022-02-28 : 废弃
  
  =================================================================================*/
  PROCEDURE p_ins_faccode_into_tab
  (
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    剩余产能占比更新
  
    用途:
      用于剩余产能占比更新
  
    入参:
      V_FACCODE  : 工厂编码
      V_COMPID   : 企业Id
  
    版本:
      2022-05-12 : 剩余产能占比更新
  
  ===================================================================================*/
  PROCEDURE p_upd_facrestrate
  (
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*=========================================================================
  
    产能预约明细数据生成
  
    用途：产能预约明细数据生成
  
    入参：
      V_PTCID          :  供应商产能预约表Id
      V_YEARWEEK       :  年周
      V_NOTWORKDDIDS   :  不开工日期
      V_WKPEOPLE       :  车位人数
      V_WKHOUR         :  工作时长
      V_PRODEFF        :  生产效率
      V_APPRATE        :  预约产能占比
      V_OPERID         :  动作发生时操作人
      V_OPERTIME       :  动作发生时间
      V_COMPID         :  企业id
  
    版本：
      2022-05-06 : 产能预约明细数据生成
  
  ==========================================================================*/
  PROCEDURE p_gen_capcappdtldata
  (
    v_ptcid        IN VARCHAR2,
    v_yearweek     IN NUMBER,
    v_notworkddids IN VARCHAR2,
    v_wkpeople     IN NUMBER,
    v_wkhour       IN NUMBER,
    v_prodeff      IN NUMBER,
    v_apprate      IN NUMBER,
    v_operid       IN VARCHAR2,
    v_opertime     IN VARCHAR2,
    v_isupd        IN NUMBER DEFAULT 1,
    v_compid       IN VARCHAR2
  );

  /*===================================================================================
  
    根据不同参数增删改供应商产能预约数据
  
    用途:
      根据不同参数增删改供应商产能预约数据
  
    入参:
      V_SUPCODE     :  供应商编码
      V_FACCODE     :  生产工厂编码
      V_CATE        :  分类
      V_OPERID      :  动作发生时操作人
      V_OPERTIME    :  动作发生时间
      V_COMPID      :  企业Id
  
    版本:
      2022-03-04 : 根据不同参数增删改供应商产能预约数据
      2022-05-06 : 修复主表供应商产能预约表删除不彻底问题
                   从表供应商产能预约明细生成逻辑分离
  
  ===================================================================================*/
  PROCEDURE p_idu_supcapcappdata_by_diffparam
  (
    v_supcode     IN VARCHAR2,
    v_faccode     IN VARCHAR2,
    v_cate        IN VARCHAR2,
    v_operid      IN VARCHAR2,
    v_opertime    IN VARCHAR2,
    v_issubtabupd IN NUMBER DEFAULT 1,
    v_compid      IN VARCHAR2
  );

  /*===================================================================================
  
    根据入参增删改下单规划-生产排期已下订单数据生成逻辑
  
    用途:
      根据入参增删改下单规划-生产排期已下订单数据生成逻辑
  
    入参:
      V_SUPCODE    :  供应商编码
      V_FACCODE    :  生产工厂编码
      V_CATE       :  分类
      V_PROCATE    :  生产分类
      V_SUBCATE    :  子类
      V_COMPID     :  企业Id
  
    版本:
      2022-03-04 : 根据入参增删改下单规划-生产排期已下订单数据生成逻辑
      2022-05-05 : 增加 [排除历史收货，已排期数据] 重算重排
                   增加 [日生产平均数小于1，每天按日生产1件均匀分配到每一天] 重算重排
  
  ===================================================================================*/
  PROCEDURE p_idu_alorder_data_by_diffparam
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    将 SCMDATA.T_PRODUCTION_SCHEDULE 及 View 表内不进行产能规划数据的日生产件数置零
  
    用途:
      配置直接修改导致不能从业务表取到值的补充重算逻辑（用于产能品类规划生效）
  
    入参:
      V_CATE       :  分类
      V_PROCATE    :  生产分类
      V_SUBCATE    :  子类
      V_COMPID     :  企业Id
  
    版本:
      2022-05-05 : 将 SCMDATA.T_PRODUCTION_SCHEDULE 及 View 表内
                   不进行产能规划数据的日生产件数置零
  
  ===================================================================================*/
  PROCEDURE p_setpsprodamt_to_zero
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    获取供应商某生产工厂子类日生产占比
  
   用途:
     获取供应商某生产工厂子类日生产占比
  
   入参:
     V_SUPCODE  :  供应商编码
     V_FACCODE  :  生产工厂编码
     V_COMPID   :  企业Id
     V_CATE     :  分类
     V_PROCATE  :  生产分类
     V_SUBCATE  :  子类
     V_DAY      :  日期
  
   版本:
     2022-01-24 : 获取供应商某生产工厂子类日生产占比
  
  ===================================================================================*/
  FUNCTION f_get_supdaysubcaterate
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_day     IN DATE
  ) RETURN NUMBER;

  /*===================================================================================
  
    CommonFunction
    字段拼接通用方法(返回VARCHAR2)
  
    入参:
      V_SENTENCE    :  被拼接语句，作为拼接字段载体被最终返回
      V_APPENDSTR   :  拼接字段，被拼接在被拼接语句和中间字段后
      V_MIDDLIESTR  :  中间字段，仅存在于被拼接语句不为空且拼接字段不为空的字符中间
  
    返回值:
      最终返回：
      V_SENTENCE + V_MIDDLIESTR + V_APPENDSTR——————V_SENTENCE且V_APPENDSTR不为空
      V_APPENDSTR——————V_SENTENCE为空且V_APPENDSTR不为空
      V_SENTENCE——————V_APPENDSTR为空
  
    版本:
      2022-08-08 : 获取供应商档案启停生成影响行逻辑的sql(返回VARCHAR2)
  
  ===================================================================================*/
  FUNCTION f_sentence_append_rv
  (
    v_sentence   IN VARCHAR2,
    v_appendstr  IN VARCHAR2,
    v_middliestr IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    CommonFunction
    字段拼接通用方法(返回CLOB)
  
    入参:
      V_SENTENCE    :  被拼接语句，作为拼接字段载体被最终返回
      V_APPENDSTR   :  拼接字段，被拼接在被拼接语句和中间字段后
      V_MIDDLIESTR  :  中间字段，仅存在于被拼接语句不为空且拼接字段不为空的字符中间
  
    返回值:
      最终返回：
      V_SENTENCE + V_MIDDLIESTR + V_APPENDSTR——————V_SENTENCE且V_APPENDSTR不为空
      V_APPENDSTR——————V_SENTENCE为空且V_APPENDSTR不为空
      V_SENTENCE——————V_APPENDSTR为空
  
    版本:
      2022-08-08 : 获取供应商档案启停生成影响行逻辑的sql(返回CLOB)
  
  ===================================================================================*/
  FUNCTION f_sentence_append_rc
  (
    v_sentence   IN CLOB,
    v_appendstr  IN VARCHAR2,
    v_middliestr IN VARCHAR2
  ) RETURN CLOB;

  /*===================================================================================
  
    DataGeneration
    通过不同条件生成品类合作生产工厂+生产工厂产能预约配置数据
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  产品子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-08-09 : 通过不同条件生成品类合作生产工厂+生产工厂产能预约配置数据
  
  ===================================================================================*/
  PROCEDURE p_iu_cfacdata_bydfcond
  (
    v_supcode IN VARCHAR2 DEFAULT NULL,
    v_faccode IN VARCHAR2 DEFAULT NULL,
    v_cate    IN VARCHAR2 DEFAULT NULL,
    v_procate IN VARCHAR2 DEFAULT NULL,
    v_subcate IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成供应商周产能规划-供应商产能明细周汇总数据
  
    入参:
      V_SWPID    :  供应商周产能规划主表Id
      V_COMPID   :  企业Id
  
    版本:
      2022-07-28 : 生成供应商周产能规划-供应商产能明细周汇总数据
  
  ===================================================================================*/
  PROCEDURE p_iu_swpswsd_data
  (
    v_swpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    生成品类周产能规划-供应商产能明细周汇总数据
  
    入参:
      V_CWPID    :  品类周产能规划主表Id
      V_COMPID   :  企业Id
  
    版本:
      2022-07-28 : 生成品类周产能规划-供应商产能明细周汇总数据
  
  ===================================================================================*/
  PROCEDURE p_iu_cwpswsd_data
  (
    v_cwpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*==============================================================================
  
    供应商周产能规划-品类下单规划（件数）周汇总计算逻辑
  
    入参：
      V_SWPID    :  供应商周产能规划表Id
      V_COMPID   :  企业Id
  
    版本:
      2022-07-29 : 供应商周产能规划-品类下单规划（件数）周汇总计算逻辑
  
  ==============================================================================*/
  PROCEDURE p_iu_supcapcwkpl_cwsd_data
  (
    v_swpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    【品类周产能规划-供应商产能明细】数据生成
  
     用途:
       用于生成【品类周产能规划-供应商产能明细】数据
  
     入参:
       V_SUPCODE  :  供应商编码
       V_CATE     :  分类Id
       V_PROCATE  :  生产分类Id
       V_SUBCATE  :  子类Id
       V_OPERID   :  操作人Id
       V_OPERTIME :  操作时间，字符串，格式：YYYY-MM-DD HH24-MI-SS
       V_COMPID   :  企业Id
  
     版本:
       2022-03-12 :  【品类周产能规划-供应商产能明细】数据生成
  
  ===================================================================================*/
  PROCEDURE p_gen_cateweekplan_sup_detail_data
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    新增【品类周产能规划-品类下单规划明细】基础数据
  
     用途:
       用于新增【品类周产能规划-品类下单规划明细】基础数据
  
     入参:
       V_CWPID    :  品类周产能规划表Id
       V_SUPCODE  :  供应商编码
       V_COMPID   :  企业Id
       V_CATE     :  分类Id
       V_PROCATE  :  生产分类Id
       V_SUBCATE  :  子类Id
       V_DAY      :  日期
  
     版本:
       2022-03-12 :  新增【品类周产能规划-品类下单规划明细】基础数据
  
  ===================================================================================*/
  PROCEDURE p_gennew_cateweekplan_cate_detail
  (
    v_cwpid   IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_day     IN DATE
  );

  /*===================================================================================
  
    品类周产能规划逻辑拆分--品类下单规划明细空数据新增
  
    用途:
      品类周产能规划逻辑拆分--品类下单规划明细空数据新增
  
    入参:
      V_CWPID    :  品类周产能规划主表Id
      V_YEARWEEK :  年周
      V_COMPID   :  企业Id
  
    版本:
      2022-07-28 : 品类周产能规划逻辑拆分--品类下单规划明细空数据新增
  
  ===================================================================================*/
  PROCEDURE p_cwp_catedetail_emptydata_gen
  (
    v_cwpid    IN VARCHAR2,
    v_yearweek IN NUMBER,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    品类周产能规划逻辑拆分--品类下单规划明细预计新品/已下订单/预计补单字段更新
  
    用途:
      品类周产能规划逻辑拆分--品类下单规划明细预计新品/已下订单/预计补单字段更新
  
    入参:
      V_CWPID      :  品类周产能规划主表Id
      V_SUPCODE    :  供应商编码
      V_CATE       :  分类Id
      V_PROCATE    :  生产分类Id
      V_SUBCATE    :  子类Id
      V_WKSTARTDAY :  周开始日期
      V_WKENDDAY   :  周结束日期
      V_COMPID     :  企业Id
  
    版本:
      2022-07-28 : 品类周产能规划逻辑拆分--品类下单规划明细预计新品/已下订单/预计补单字段更新
  
  ===================================================================================*/
  PROCEDURE p_upd_catedetail_plnaloplsfield
  (
    v_cwpid      IN VARCHAR2,
    v_supcode    IN VARCHAR2,
    v_cate       IN VARCHAR2,
    v_procate    IN VARCHAR2,
    v_subcate    IN VARCHAR2,
    v_wkstartday IN DATE,
    v_wkendday   IN DATE,
    v_compid     IN VARCHAR2
  );

  /*===================================================================================
  
    品类周产能规划逻辑拆分--品类下单规划明细计算
  
    用途:
      品类周产能规划逻辑拆分--品类下单规划明细计算
  
    入参:
      V_CWPID      :  品类周产能规划主表Id
      V_COMPID     :  企业Id
  
    版本:
      2022-07-28 : 品类周产能规划逻辑拆分--品类下单规划明细计算
  
  ===================================================================================*/
  PROCEDURE p_catedetail_calculate
  (
    v_cwpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    品类周产能规划逻辑拆分--品类周产能规划计算
  
    用途:
      品类周产能规划逻辑拆分--品类周产能规划计算
  
    入参:
      V_CWPID      :  品类周产能规划主表Id
      V_COMPID     :  企业Id
  
    版本:
      2022-07-28 : 品类周产能规划逻辑拆分--品类周产能规划计算
  
  ===================================================================================*/
  PROCEDURE p_cwp_calculate
  (
    v_cwpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    【品类周产能规划-品类下单规划明细】数据生成
  
     用途:
       用于生成【品类周产能规划-品类下单规划明细】数据
  
     入参:
       V_SUPCODE  :  供应商编码
       V_CATE     :  分类Id
       V_PROCATE  :  生产分类Id
       V_SUBCATE  :  子类Id
       V_COMPID   :  企业Id
  
     版本:
       2022-03-12 :  【品类周产能规划-品类下单规划明细】数据生成
       2022-07-29 : 逻辑拆分封装
  
  ===================================================================================*/
  PROCEDURE p_gen_cateweekplan_cate_detail_data
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成品类周产能规划数据
  
   用途:
     生成供应商周产能规划-供应商产能明细数据
  
   入参:
     V_SUPCODE  :  供应商编码
     V_CATE     :  分类Id
     V_PROCATE  :  生产分类Id
     V_SUBCATE  :  子类Id
     V_OPERID   :  操作人Id
     V_OPERTIME :  操作时间
     V_COMPID   :  企业Id
  
   版本:
     2022-03-08 : 生成供应商周产能规划-供应商产能明细数据
  
  ===================================================================================*/
  PROCEDURE p_iu_catewkpln_data
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
   生成供应商周产能规划数据
  
   用途:
     生成供应商周产能规划数据，需先生成品类周产能规划数据
  
   入参:
     V_SUPCODE  :  供应商编码
     V_CATE     :  分类Id
     V_PROCATE  :  生产分类Id
     V_SUBCATE  :  子类Id
     V_OPERID   :  操作人Id
     V_OPERTIME :  操作时间
     V_COMPID   :  企业Id
  
   版本:
     2022-01-24 : 生成供应商周产能规划数据
  
  ===================================================================================*/
  PROCEDURE p_iu_supwkpln_data
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    增加最近生效队列创建时间
  
     入参:
       V_SUPCODE  :  供应商编码
       V_CATE     :  分类Id
       V_OPERTIME :  操作时间，字符串，格式：YYYY-MM-DD HH24-MI-SS
       V_COMPID   :  企业Id
  
     版本:
       2022-09-22 : 新需求，增加最近生效队列创建时间
  
  ===================================================================================*/
  PROCEDURE p_upd_wkpln_lastefftime
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
   生成周产能规划数据
  
   用途:
     生成周产能规划数据
  
   入参:
     V_SUPCODE  :  供应商编码
     V_CATE     :  分类Id
     V_OPERID   :  操作人Id
     V_OPERTIME :  操作时间
     V_COMPID   :  企业Id
  
   版本:
     2022-01-24 : 生成周产能规划数据
  
  ===================================================================================*/
  PROCEDURE p_iu_weekplan_data
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    队列派生-生成周产能规划重算队列
  
    入参:
      V_SUPCODE  :  供应商编码
      V_CATE     :  分类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-08-25 : 队列派生-生成周产能规划重算队列
  
  ===================================================================================*/
  PROCEDURE p_gen_wkplanrecalcrela
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    队列派生-周产能规划重算
  
    入参:
      V_QUEUEID  :  队列Id
      V_COMPID   :  企业Id
  
    版本:
      2022-08-25 : 队列派生-周产能规划重算
  
  ===================================================================================*/
  PROCEDURE p_wkplanrecalc_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    将 SCMDATA.T_PRODUCTION_SCHEDULE 及 View 表内不进行产能规划的数据删除
  
    用途:
      配置直接修改导致不能从业务表取到值的补充删除逻辑（用于产能品类规划生效）
  
    入参:
      V_CATE       :  分类
      V_PROCATE    :  生产分类
      V_SUBCATE    :  子类
      V_COMPID     :  企业Id
  
    版本:
      2022-05-05 : 将 SCMDATA.T_PRODUCTION_SCHEDULE 及 View 表内
                   不进行产能规划的数据删除
  
  ===================================================================================*/
  PROCEDURE p_delpsdata_by_cps
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生产周期配置预计新品重算（CPS）
  
    用途:
      生产周期配置预计新品重算（CPS）
  
    入参:
      V_CATE      :  分类
      V_PROCATE   :  生产分类
      V_SUBCATE   :  子类
      V_COMPID    :  企业Id
  
    版本:
      2022-05-24 : 生产周期配置预计新品重算（CPS）
  
  ===================================================================================*/
  PROCEDURE p_prodcyccfg_cps_plrecalc
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*========================================================================================
  
    获取档案级别启停
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-07 : 获取档案级别启停，版本变动加入生产类型变更影响配置变更
  
  ========================================================================================*/
  FUNCTION f_get_pause_causebysupfilechange
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER;

  /*========================================================================================
  
    获取档案级别关联品类合作供应商配置数据集sql
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-07 : 获取档案级别关联品类合作供应商配置数据集sql，
                   版本变动加入生产类型变更影响配置变更
  
  ========================================================================================*/
  FUNCTION f_get_sfcps_by_conds
  (
    v_supcode IN VARCHAR2 DEFAULT NULL,
    v_faccode IN VARCHAR2 DEFAULT NULL,
    v_cate    IN VARCHAR2 DEFAULT NULL,
    v_procate IN VARCHAR2 DEFAULT NULL,
    v_subcate IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) RETURN CLOB;

  /*========================================================================================
  
    用于获取品类合作供应商配置处的供应商编码，生产工厂编码，分类Id的sql
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-28 : 用于获取品类合作供应商配置处的供应商编码，生产工厂编码，分类Id的sql
  
  ========================================================================================*/
  FUNCTION f_get_coopsf_sfc_by_conds
  (
    v_supcode IN VARCHAR2 DEFAULT NULL,
    v_faccode IN VARCHAR2 DEFAULT NULL,
    v_cate    IN VARCHAR2 DEFAULT NULL,
    v_procate IN VARCHAR2 DEFAULT NULL,
    v_subcate IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) RETURN CLOB;

  /*========================================================================================
  
    供应商档案变更设置生产工厂预约产能占比为0
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-28 : 供应商档案变更设置生产工厂预约产能占比为0
  
  ========================================================================================*/
  PROCEDURE p_supfilecg_setappcapcrate_to_zero
  (
    v_supcode  IN VARCHAR2 DEFAULT NULL,
    v_faccode  IN VARCHAR2 DEFAULT NULL,
    v_cate     IN VARCHAR2 DEFAULT NULL,
    v_procate  IN VARCHAR2 DEFAULT NULL,
    v_subcate  IN VARCHAR2 DEFAULT NULL,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*========================================================================================
  
    品类合作供应商生产工厂产能预约配置数据刷新
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-07 : 品类合作供应商生产工厂产能预约配置数据刷新
  
  ========================================================================================*/
  PROCEDURE p_coopsupfac_appcapc_datarefresh
  (
    v_supcode  IN VARCHAR2 DEFAULT NULL,
    v_faccode  IN VARCHAR2 DEFAULT NULL,
    v_cate     IN VARCHAR2 DEFAULT NULL,
    v_procate  IN VARCHAR2 DEFAULT NULL,
    v_subcate  IN VARCHAR2 DEFAULT NULL,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*========================================================================================
  
    供应商档案相关变更刷新产能配置数据
  
    入参:
      V_SUPCODE   :  供应商编码
      V_FACCODE   :  生产工厂编码
      V_CATE      :  分类Id
      V_PROCATE   :  生产分类Id
      V_SUBCATE   :  子类Id
      V_OPERID    :  操作人
      V_OPERTIME  :  操作时间
      V_COMPID    :  企业Id
  
    版本:
      2022-09-28 : 供应商档案相关变更刷新产能配置数据
  
  ========================================================================================*/
  PROCEDURE p_supfilerelacg_refreshcfgdata
  (
    v_supcode  IN VARCHAR2 DEFAULT NULL,
    v_faccode  IN VARCHAR2 DEFAULT NULL,
    v_cate     IN VARCHAR2 DEFAULT NULL,
    v_procate  IN VARCHAR2 DEFAULT NULL,
    v_subcate  IN VARCHAR2 DEFAULT NULL,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    生产周期配置预计新品重算（CPSS）
  
    用途:
      生产周期配置预计新品重算（CPSS）
  
    入参:
      V_CATE      :  分类
      V_PROCATE   :  生产分类
      V_SUBCATE   :  子类
      V_SUPCODES  :  供应商编码（复数）
      V_COMPID    :  企业Id
  
    版本:
      2022-05-24 : 生产周期配置预计新品重算（CPSS）
  
  ===================================================================================*/
  PROCEDURE p_prodcyccfg_cpss_plrecalc
  (
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_supcodes IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    生产周期配置生效逻辑
  
    用途:
      用于对生产周期配置相关数据修改进行生效、重算或删除
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业id
      V_COND      :  唯一条件
      V_METHOD    :  变更方式 INS-新增 UPD-修改 DEL-删除
  
    版本:
      2022-05-06 : 用于对生产周期配置相关数据修改进行生效、重算或删除
  
  ===================================================================================*/
  PROCEDURE p_recalc_prodcyc_eff
  (
    v_supcode  IN VARCHAR2,
    v_faccode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    生产周期配置生效逻辑
  
    用途:
      用于对生产周期配置相关数据修改进行生效、重算或删除
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业id
      V_COND      :  唯一条件
      V_METHOD    :  变更方式 INS-新增 UPD-修改 DEL-删除
  
    版本:
      2022-05-06 : 用于对生产周期配置相关数据修改进行生效、重算或删除
  
  ===================================================================================*/
  PROCEDURE p_prodcyccfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2
  );

  /*=========================================================================
  
    品类产能配置生成相关数据
  
    用途：品类产能配置生成相关数据
  
    入参：
      V_CATE       分部
      V_PROCATE    生产类别
      V_SUBCATE    子类
      V_COMPID     企业id
  
    版本：
      2022-05-05 : 品类产能配置生成相关数据
  
  ==========================================================================*/
  PROCEDURE p_cateplancfg_able_efflevels_cg
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_opid    IN VARCHAR2,
    v_optime  IN DATE
  );

  /*=========================================================================
  
    品类产能配置删除相关数据
  
    用途：品类产能配置删除相关数据
  
    入参：
      V_CATE       分部
      V_PROCATE    生产类别
      V_SUBCATE    子类
      V_COMPID     企业id
  
    版本：
      2022-05-05 : 品类产能配置删除相关数据
  
  ==========================================================================*/
  PROCEDURE p_cateplancfg_disable_efflevels_cg
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_opid    IN VARCHAR2,
    v_optime  IN DATE
  );

  /*=====================================================================
  
    品类产能配置层级生效逻辑
  
    用途：
      品类产能配置层级生效逻辑
  
    入参：
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业id
      V_COND      :  唯一条件
      V_METHOD    :  变更方式 INS-新增 UPD-修改 DEL-删除
  
    版本：
      2022-05-05 : 品类产能配置删除相关数据
  
  =======================================================================*/
  PROCEDURE p_cateplan_efflogic_cg
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2
  );

  /*===================================================================================
  
    EffectiveLogic
    品类合作供应商新增生效逻辑
  
    入参:
      V_COND  :  唯一行条件
  
    版本:
      2022-08-11 : 品类合作供应商新增生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_coopsupcfg_i_efflogic(v_cond IN VARCHAR2);

  /*===================================================================================
  
    品类合作供应商修改生效逻辑
  
    用途:
      品类合作供应商修改生效逻辑
  
    入参:
      V_QUEUEID    :  队列Id
      V_COND       :  唯一行条件
      V_COMPID     :  企业Id
  
    版本:
      2022-03-08 : 品类合作供应商修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_coopsupcfg_u_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    品类合作供应商生效逻辑
  
    用途:
      品类合作供应商生效逻辑
  
    入参:
      V_QUEUEID    :  供应商编码
      V_COND       :  条件
      V_COMPID     :  企业Id
  
    版本:
      2022-03-08 : 品类合作供应商生效逻辑
      2022-08-11 : 品类合作供应商新增逻辑加入，原存储过程被拆分到修改逻辑
  
  ===================================================================================*/
  PROCEDURE p_coopcatesupcfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    品类合作生产工厂启停生效逻辑
  
    用途:
      品类合作生产工厂启停生效逻辑
  
    入参:
      V_COND         :  品类合作供应商配置Id
      V_COMPID       :  企业Id
      V_CURUSERID    :  动作发生时操作人Id
      V_HAPTIME      :  动作发生时间
      V_PAUSE        :  启停
  
    版本:
      2022-03-08 : 品类合作生产工厂启停生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_coopcatefaccfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    标准工时配置生效计算逻辑
  
    用途:
      用于标准工时配置生效计算逻辑
  
    入参:
      V_COMPID    :  企业Id
      V_COND      :  条件
  
    版本:
      2022-03-03 : 标准工时配置生效计算逻辑
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_eff_calclogic
  (
    v_cond     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    标准工时配置修改生效到业务表
  
    用途:
      用于标准工时配置修改生效到业务表
  
    入参:
      V_COND      :  条件
      V_CATE      :  分类Id
      V_PROCATE   :  生产分类Id
      V_SUBCATE   :  子类Id
      V_STDWKT    :  标准工时
      V_USERID    :  操作人Id
      V_UPDTIME   :  操作时间
  
    版本:
      2022-03-03 : 标准工时配置修改生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_upd_efftotab
  (
    v_cond    IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_stdwkt  IN VARCHAR2,
    v_userid  IN VARCHAR2,
    v_updtime IN VARCHAR2
  );

  /*===================================================================================
  
    标准工时配置新增生效到业务表
  
    用途:
      用于标准工时配置修改生效到业务表
  
    入参:
      V_SWMCID    :  标准工时配置表Id
      V_COMPID    :  企业Id
      V_CATE      :  分类Id
      V_PROCATE   :  生产分类Id
      V_SUBCATE   :  子类Id
      V_STDWKT    :  标准工时
      V_OPERID    :  操作人Id
      V_OPERTIME  :  操作时间
      V_COND      :  条件
  
    版本:
      2022-03-03 : 标准工时配置修改生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_ins_efftotab
  (
    v_swmcid   IN VARCHAR2,
    v_compid   IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_stdwkt   IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2
  );

  /*===================================================================================
  
    标准工时配置删除生效到业务表
  
    用途:
      用于标准工时配置删除生效到业务表
  
    入参:
      V_COND      :  条件
  
    版本:
      2022-03-03 : 标准工时配置删除生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_del_efftotab(v_cond IN VARCHAR2);

  /*===================================================================================
  
    标准工时配置异常(CPS变更，数据删除)生效逻辑
  
    用途:
      用于标准工时配置修改生效到业务表
  
    入参:
      V_CATE      :  分类Id
      V_PROCATE   :  生产分类Id
      V_SUBCATE   :  子类Id
      V_OPERID    :  操作人Id
      V_OPERTIME  :  操作时间
      V_COMPID    :  企业Id
  
    版本:
      2022-05-18 : 标准工时配置异常(CPS变更，数据删除)生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_abn_efflogic
  (
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    标准工时配置异常(CPS变更，数据删除)生效逻辑
  
    用途:
      用于标准工时配置修改生效到业务表
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业Id
      V_COND      :  条件
      V_METHOD    :  操作方式
  
    版本:
      2022-05-18 : 标准工时配置异常(CPS变更，数据删除)生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2
  );

  /*===================================================================================
  
    生产工厂产能预约配置修改生效逻辑
  
    用途:
      生产工厂产能预约配置修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  品类合作供应商配置Id
      V_COMPID       :  企业Id
  
    版本:
      2022-03-08 : 生产工厂产能预约配置修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_facappcapccfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    SpecialLogic
    供应商-生产工厂级品类合作生产工厂启停更新
  
    入参:
      V_SUPCODE     :  供应商编码
      V_FACCODE     :  生产工厂编码
      V_COMPID      :  企业Id
      V_CALCCFCIDS  :  待生效的品类合作生产工厂Id
  
    出参:
      V_CALCCFCIDS  :  待生效的品类合作生产工厂Id
  
    版本:
      2022-08-09 : 供应商-生产工厂级品类合作生产工厂启停更新
  
  ===================================================================================*/
  PROCEDURE p_upd_sflevel_pause
  (
    v_supcode    IN VARCHAR2,
    v_faccode    IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_calccfcids IN OUT CLOB
  );

  /*===================================================================================
  
    effectivelogic
    供应商档案合作工厂生效逻辑
  
    入参:
      v_inp_queue_id  :  队列id
      v_inp_cond      :  唯一行条件
      v_inp_method    :  操作方式
      v_compid        :  企业id
  
    版本:
      2022-08-08 : 供应商档案合作工厂生效逻辑
      2022-09-01 : 增加建档时作为生产工厂产能配置数据生成逻辑
      2023-06-01 : 增加供应商档案修改是否本场字段导致合作工厂数据删除的处理逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfac_efflogic
  (
    v_inp_queue_id   IN VARCHAR2,
    v_inp_cond       IN VARCHAR2,
    v_inp_method     IN VARCHAR2,
    v_inp_company_id IN VARCHAR2
  );

  /*===================================================================================
  
    供应商开工通用配置新增生效到业务表
  
    用途:
      用于供应商开工通用配置新增生效到业务表
  
    入参:
      V_BRAID        :  分类Id
      V_PROVID       :  省Id
      V_CITYID       :  市Id
      V_COUNID       :  区Id
      V_FACCODE      :  生产工厂编码
      V_YEAR         :  年份
      V_WKNTWK       :  周不开工日期
      V_MTNTWK       :  月不开工日期
      V_YRNTWK       :  年不开工日期
      V_CREID        :  创建人Id
      V_CRETIME      :  创建时间
      V_COND         :  唯一行条件
  
    版本:
      2022-03-07 : 供应商开工通用配置新增生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_ins_viewefflogic
  (
    v_sswcid  IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_braid   IN VARCHAR2,
    v_provid  IN VARCHAR2,
    v_cityid  IN VARCHAR2,
    v_counid  IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_year    IN VARCHAR2,
    v_wkntwk  IN VARCHAR2,
    v_mtntwk  IN VARCHAR2,
    v_yrntwk  IN VARCHAR2,
    v_creid   IN VARCHAR2,
    v_cretime IN VARCHAR2
  );

  /*===================================================================================
  
    供应商开工通用配置修改生效到业务表
  
    用途:
      用于供应商开工通用配置修改生效到业务表
  
    入参:
      V_BRAID        :  分类Id
      V_PROVID       :  省Id
      V_CITYID       :  市Id
      V_COUNID       :  区Id
      V_FACCODE      :  生产工厂编码
      V_YEAR         :  年份
      V_WKNTWK       :  周不开工日期
      V_MTNTWK       :  月不开工日期
      V_YRNTWK       :  年不开工日期
      V_UPDID        :  修改人Id
      V_UPDTIME      :  修改时间
      V_COND         :  唯一行条件
  
    版本:
      2022-02-10 : 供应商开工通用配置修改生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_upd_viewefflogic
  (
    v_braid   IN VARCHAR2,
    v_provid  IN VARCHAR2,
    v_cityid  IN VARCHAR2,
    v_counid  IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_year    IN VARCHAR2,
    v_wkntwk  IN VARCHAR2,
    v_mtntwk  IN VARCHAR2,
    v_yrntwk  IN VARCHAR2,
    v_updid   IN VARCHAR2,
    v_updtime IN VARCHAR2,
    v_cond    IN VARCHAR2
  );

  /*===================================================================================
  
    供应商开工通用配置删除生效到业务表
  
    用途:
      用于供应商开工通用配置删除生效到业务表
  
    入参:
      V_BRAID        :  分类Id
      V_PROVID       :  省Id
      V_CITYID       :  市Id
      V_COUNID       :  区Id
      V_FACCODE      :  生产工厂编码
      V_YEAR         :  年份
      V_WKNTWK       :  周不开工日期
      V_MTNTWK       :  月不开工日期
      V_YRNTWK       :  年不开工日期
      V_CREID        :  创建人Id
      V_CRETIME      :  创建时间
      V_COND         :  唯一行条件
  
    版本:
      2022-03-07 : 供应商开工通用配置删除生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_del_viewefflogic(v_cond IN VARCHAR2);

  /*===================================================================================
  
    获取供应商开工通用配置涉及的供应商和生产工厂
  
    用途:
      获取供应商开工通用配置涉及的供应商和生产工厂
  
    入参:
      V_BRAID        :  分部Id
      V_PROVID       :  省Id
      V_CITYID       :  市Id
      V_COUNID       :  区Id
      V_FACCODE      :  生产工厂编码
      V_COMPID       :  企业Id
  
    版本:
      2022-03-08 : 获取供应商开工通用配置涉及的供应商和生产工厂
  
  ===================================================================================*/
  FUNCTION f_get_supstwkcfg_supfacsql
  (
    v_braid   IN VARCHAR2,
    v_provid  IN VARCHAR2,
    v_cityid  IN VARCHAR2,
    v_counid  IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*===================================================================================
  
    供应商开工通用配置修改前置数据重算
  
    用途:
      用于供应商开工通用配置修改前置数据重算
  
    入参:
      V_COND      :  条件
      V_COMPID    :  企业Id
  
    版本:
      2022-03-08 : 供应商开工通用配置修改前置数据重算
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_rawdata_recalc
  (
    v_cond     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    供应商开工通用配置生效逻辑
  
    用途:
      用于供应商开工通用配置生效
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业Id
      V_COND      :  条件
      V_METHOD    :  变更方式 INS-新增 UPD-修改 DEL-删除
  
    版本:
      2022-03-08 : 供应商开工通用配置生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2
  );

  /*===================================================================================
  
    供应商产能预约不开工日期修改生效逻辑
  
    用途:
      供应商产能预约不开工日期修改生效逻辑
  
    入参:
      V_QUEUEID        :  品类合作供应商配置Id
      V_COND           :  唯一行条件
      V_COMPID         :  企业Id
  
    版本:
      2022-02-22 : 供应商产能预约不开工日期修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcapcapp_notworkupd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    供应商产能预约明细修改生效逻辑
  
    用途:
      用于供应商产能预约明细修改生效
  
    入参:
      V_QUEUEID        :  品类合作供应商配置Id
      V_COMPID         :  企业Id
  
    版本:
      2022-02-22 : 供应商产能预约明细修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcapcapp_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    下单规划-生产排期预计新品数据新增修改生成逻辑
  
    用途:
      下单规划-生产排期预计新品数据新增修改生成逻辑
  
    用于:
      下单规划
  
    版本:
      2022-05-15 : 单规划-生产排期预计新品数据新增修改生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_iu_newprodsche_data_4plnp
  (
    v_pnid   IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    下单规划-生产排期预计补单数据新增修改生成逻辑
  
    用途:
      下单规划-生产排期预计补单数据新增修改生成逻辑
  
    用于:
      下单规划
  
    版本:
      2022-07-25 : 下单规划-生产排期预计补单数据新增修改生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_iu_newprodsche_data_4plns
  (
    v_pnsid  IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    预计新品生效逻辑
  
    用途:
      用于预计新品生效
  
    入参:
      V_QUEUEID   :  队列Id
      V_COND      :  确认唯一行条件
      V_METHOD    :  修改方式：INS-新增 UPD-修改
      V_COMPID    :  企业Id
  
    版本:
      2022-02-24 :  用于预计新品生效
  
  ===================================================================================*/
  PROCEDURE p_plannew_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    ORDERED 修改生效逻辑
  
    用途:
      ORDERED 修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-26 : ORDERED 修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_ordered_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    ORDERS 修改生效逻辑
  
    用途:
      ORDERS 修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    出参:
      V_ORDID        :  订单号
  
    版本:
      2022-02-26 : ORDERS 修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_orders_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    ORDER 修改生效逻辑
  
    用途:
      ORDER 修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-26 : ORDER 修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_order_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    供应商档案合作范围修改生效逻辑
  
    用途:
      用于供应商档案合作范围修改生效逻辑
  
    入参:
      V_QUEUEID   :  队列Id
      V_COND      :  唯一行条件
      V_COMPID    :  企业Id
  
    版本:
      2022-04-02  : 供应商档案合作范围修改生效逻辑
      2022-05-24  : 增加涉及供应商作为其他供应商生产工厂角色的生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcpscp_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    供应商档案合作范围新增生效逻辑
  
    用途:
      用于供应商档案合作范围新增生效逻辑
  
    入参:
      V_QUEUEID   :  队列Id
      V_COND      :  唯一行条件
      V_COMPID    :  企业Id
  
    版本:
      2022-04-02  : 供应商档案合作范围新增生效逻辑
      2022-05-24  : 增加涉及供应商作为其他供应商生产工厂角色的生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcpscp_ins_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    合作范围启停生效逻辑
  
    用途:
      合作范围启停生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-26 : 合作范围启停生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcoopscope_pausechange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    合作范围增改生效逻辑
  
    用途:
      合作范围增改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-04-02 : 合作范围增改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcoopscope_iu_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    EffectiveLogic
    获取供应商合作范围变更生效核心逻辑
  
    入参:
      V_SUPCODE  :  供应商编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  产品子类Id
      V_OPERID   :  操作人Id
      V_OPERTIME :  操作时间
      V_COMPID   :  企业Id
  
    版本:
      2022-08-09 : 获取供应商合作范围影响行数据生成sql
  
  ===================================================================================*/
  PROCEDURE p_supscp_iu_efflogiccore
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    EffectiveLogic
    供应商合作范围变更层级生效逻辑
  
    入参:
      V_QUEUEID  :  队列Id
      V_COND     :  唯一行条件
      V_COMPID   :  企业Id
  
    版本:
      2022-08-09 : 供应商合作范围变更层级生效逻辑
      2022-09-01 : 增加建档时作为生产工厂产能配置数据生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_supscp_iu_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    合作工厂启停生效逻辑
  
    用途:
      合作工厂启停生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-26 : 合作工厂启停生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcoopfac_pausechange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    合作工厂增生效逻辑
  
    用途:
      合作工厂增生效逻辑
  
    入参:
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-04-02 : 合作工厂增改效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcoopfac_i_efflogic
  (
    v_cond   IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    合作工厂增改生效逻辑
  
    用途:
      合作工厂增改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-04-02 : 合作工厂增改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcopfac_iu_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    供应商档案启停生效逻辑
  
    用途:
      供应商档案启停生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-27 : 供应商档案启停生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfile_pausechange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    供应商档案信息修改生效逻辑
  
    用途:
      供应商档案信息修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-27 : 供应商档案信息修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfile_infochange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    供应商档案建档生效逻辑
  
    用途:
      供应商档案建档生效逻辑
  
    入参:
      V_QUEUEID      :  队列ID
      V_COND         :  唯一行条件
      V_COMPID       :  企业ID
  
    版本:
      2022-03-23 : 供应商档案建档生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfile_statuschange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    供应商档案修改生效逻辑
  
    用途:
      供应商档案修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列ID
      V_COND         :  唯一行条件
      V_COMPID       :  企业ID
  
    版本:
      2022-03-23 : 供应商档案修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfile_cg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    DataGenerateLogic
    供应商档案建档数据生成逻辑
  
    入参:
      V_SUPCODE  :  供应商编码
      V_COMPID   :  企业Id
  
    版本:
      2022-08-08 : 供应商档案建档数据生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_gen_coopfac_appcapc_data_as_fac
  (
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    EffectiveLogic
    供应商档案信息变更层级生效逻辑
  
    入参:
      V_QUEUEID  :  队列Id
      V_VCCOND   :  唯一行条件
      V_COMPID   :  企业Id
  
    版本:
      2022-08-08 : 供应商档案信息变更层级生效逻辑
      2022-09-01 : 增加建档时作为生产工厂产能配置数据生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_supdoc_efflogic
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_qcompid IN VARCHAR2
  );

  /*===================================================================================
  
    订单接口进入数据生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COMPID       :  企业Id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂、分类、生产分类、子类
  
    版本:
      2022-04-25 : 生成[订单数据接入]数据源级影响行sql
  
  ===================================================================================*/
  PROCEDURE p_gen_orditf_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生成周产能规划日刷新入队，影响行数据
  
    版本:
      2022-07-20 : 生成周产能规划日刷新入队，影响行数据
  
  ===================================================================================*/
  PROCEDURE p_gen_day_refresh_wkplan_rela;

  /*===================================================================================
  
    周产能规划数据日刷新
  
    版本:
      2022-07-20 : 周产能规划数据日刷新
  
  ===================================================================================*/
  PROCEDURE p_capcwkpln_day_refresh;

  /*========================================================================================
  
    指定工厂生效逻辑
  
    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业id
  
    版本:
      2022-12-17 : 指定工厂生效逻辑
  
  ========================================================================================*/
  PROCEDURE p_specify_ordfactory_efflogic
  (
    v_inp_queueid IN VARCHAR2,
    v_inp_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    生效逻辑
  
    用途:
      品类合作供应商生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COMPID       :  企业Id
  
    版本:
      2022-02-27 : 品类合作供应商生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

END pkg_capacity_efflogic_prd;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_capacity_efflogic_prd IS

  /*===================================================================================
  
    根据影响行判断是否要重算周产能数据
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业Id
  
    版本:
      2022-08-15  : 根据影响行判断是否要重算周产能数据
  
  ===================================================================================*/
  FUNCTION f_get_isrecalc_weekplancapc
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT MIN(jug)
      INTO v_jugnum
      FROM (SELECT sign(decode(cpcc.in_planning, 0, 1, 0) + csc.pause +
                        cfc.pause) jug
              FROM scmdata.t_coopcate_supplier_cfg csc
             INNER JOIN scmdata.t_coopcate_factory_cfg cfc
                ON csc.csc_id = cfc.csc_id
               AND csc.company_id = cfc.company_id
             INNER JOIN scmdata.t_capacity_plan_category_cfg cpcc
                ON csc.coop_category = cpcc.category
               AND csc.coop_productcate = cpcc.product_cate
               AND csc.coop_subcategory = cpcc.subcategory
               AND csc.company_id = cpcc.company_id
             WHERE EXISTS (SELECT 1
                      FROM scmdata.t_queue_iflrows
                     WHERE queue_id = v_queueid
                       AND company_id = v_compid
                       AND nvl(ir_colvalue1, csc.supplier_code) =
                           csc.supplier_code
                       AND nvl(ir_colvalue2, cfc.factory_code) =
                           cfc.factory_code
                       AND nvl(ir_colvalue3, csc.coop_category) =
                           csc.coop_category
                       AND nvl(ir_colvalue4, csc.coop_productcate) =
                           csc.coop_productcate
                       AND nvl(ir_colvalue5, csc.coop_subcategory) =
                           csc.coop_subcategory
                       AND company_id = csc.company_id));
  
    RETURN v_jugnum;
  END f_get_isrecalc_weekplancapc;

  /*===================================================================================
  
    生产工厂预约产能占比置零
  
    用途:
      供应商档案停用，合作工厂停用，合作范围停用，
      品类合作供应商停用，品类合作生产工厂停用
  
    入参:
      V_SUPCODE    :  供应商编码
      V_FACCODE    :  生产工厂编码
      V_CATE       :  分类Id
      V_COMPID     :  企业Id
  
    版本:
      2022-09-28 : 品类合作供应商生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_set_appcapcratetozero
  (
    v_supcode  IN VARCHAR2,
    v_faccode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    v_tmprestcapcrate NUMBER(5, 2);
    v_cscnum          NUMBER(1);
    v_cfcnum          NUMBER(1);
    v_accid           VARCHAR2(32);
  BEGIN
    SELECT MAX(CASE
                 WHEN ts.pause = 0 THEN
                  1
                 ELSE
                  0
               END),
           MAX(CASE
                 WHEN tf.pause = 0 THEN
                  1
                 ELSE
                  0
               END)
      INTO v_cscnum,
           v_cfcnum
      FROM scmdata.t_coopcate_supplier_cfg ts
     INNER JOIN scmdata.t_coopcate_factory_cfg tf
        ON ts.csc_id = tf.csc_id
       AND ts.company_id = tf.company_id
     WHERE ts.supplier_code = v_supcode
       AND ts.coop_category = v_cate
       AND tf.factory_code = v_faccode
       AND ts.company_id = v_compid;
  
    IF v_cscnum = 0
       OR v_cfcnum = 0 THEN
      --计算剩余产能占比
      v_tmprestcapcrate := scmdata.pkg_capacity_management.f_get_restcapc_rate(v_cate    => v_cate,
                                                                               v_supcode => v_supcode,
                                                                               v_faccode => v_faccode,
                                                                               v_compid  => v_compid);
    
      SELECT MAX(acc_id)
        INTO v_accid
        FROM scmdata.t_app_capacity_cfg
       WHERE category = v_cate
         AND supplier_code = v_supcode
         AND factory_code = v_faccode
         AND company_id = v_compid;
    
      IF v_accid IS NOT NULL THEN
        UPDATE scmdata.t_app_capacity_cfg
           SET appcapc_rate  = 0,
               restcapc_rate = v_tmprestcapcrate,
               update_id     = v_operid,
               update_time   = to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS')
         WHERE acc_id = v_accid
           AND company_id = v_compid;
      
        UPDATE scmdata.t_app_capacity_cfg_view
           SET appcapc_rate  = 0,
               restcapc_rate = v_tmprestcapcrate,
               operate_id    = v_operid,
               operate_time  = to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS')
         WHERE acc_id = v_accid
           AND company_id = v_compid;
      
        --生产工厂产能预约配置该工厂剩余可用产能占比更新
        FOR y IN (SELECT acc_id,
                         category,
                         supplier_code,
                         factory_code,
                         company_id
                    FROM scmdata.t_app_capacity_cfg
                   WHERE acc_id <> v_accid
                     AND factory_code = v_faccode
                     AND company_id = v_compid) LOOP
          --计算剩余产能占比
          v_tmprestcapcrate := scmdata.pkg_capacity_management.f_get_restcapc_rate(v_cate    => y.category,
                                                                                   v_supcode => y.supplier_code,
                                                                                   v_faccode => y.factory_code,
                                                                                   v_compid  => y.company_id);
          --更新剩余产能占比
          UPDATE scmdata.t_app_capacity_cfg tapp
             SET restcapc_rate = v_tmprestcapcrate
           WHERE acc_id = y.acc_id
             AND company_id = y.company_id;
        
          UPDATE scmdata.t_app_capacity_cfg_view tappv
             SET restcapc_rate = v_tmprestcapcrate
           WHERE acc_id = y.acc_id
             AND company_id = v_compid;
        END LOOP;
      END IF;
    END IF;
  END p_set_appcapcratetozero;

  /*===================================================================================
  
    周产能规划部分删除
  
    用途:
      周产能规划部分删除
  
    入参:
      V_SUPCODE   :  供应商编码
      V_FACCODE   :  生产工厂编码
      V_COMPID    :  企业Id
      V_MINDATE   :  最小执行日期
  
    版本:
      2022-03-08  : 周产能规划部分删除
  
  ===================================================================================*/
  PROCEDURE p_delete_wkplandata
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_mindate IN DATE
  ) IS
    v_despday          DATE := trunc(v_mindate, 'IW');
    v_jugnum           NUMBER(1);
    v_catejug          NUMBER(1);
    v_sumcapcceiling   NUMBER(16, 2);
    v_sumappcapc       NUMBER(16, 2);
    v_sumalocapc       NUMBER(16, 2);
    v_sumplncapc       NUMBER(16, 2);
    v_sumplscapc       NUMBER(16, 2);
    v_sumcapcdiffwopln NUMBER(16, 2);
    v_sumcapcdiffwipln NUMBER(16, 2);
    v_sumcapcdiffwipls NUMBER(16, 2);
    v_warningdays      NUMBER(2);
  BEGIN
    --供应商周产能规划部分
    DELETE FROM scmdata.t_supcapcweekplan_cate_detail
     WHERE supplier_code = v_supcode
       AND category = v_cate
       AND product_cate = v_procate
       AND subcategory = v_subcate
       AND DAY >= v_despday
       AND company_id = v_compid;
  
    FOR i IN (SELECT DISTINCT swp_id,
                              company_id
                FROM scmdata.t_supcapacity_week_plan
               WHERE supplier_code = v_supcode
                 AND category = v_cate
                 AND company_id = v_compid
                 AND (YEAR, week) IN
                     (SELECT DISTINCT trunc(yearweek / 100),
                                      MOD(yearweek, 100)
                        FROM scmdata.t_day_dim
                       WHERE dd_date >= SYSDATE)) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supcapcweekplan_cate_detail
       WHERE swp_id = i.swp_id
         AND company_id = i.company_id
         AND rownum = 1;
    
      SELECT COUNT(1)
        INTO v_catejug
        FROM scmdata.t_coopcate_supplier_cfg csc
       INNER JOIN scmdata.t_coopcate_factory_cfg cfc
          ON csc.csc_id = cfc.csc_id
         AND csc.company_id = cfc.company_id
         AND csc.pause = 0
         AND cfc.pause = 0
       INNER JOIN scmdata.t_capacity_plan_category_cfg cpcc
          ON csc.coop_category = cpcc.category
         AND csc.coop_productcate = cpcc.product_cate
         AND csc.coop_subcategory = cpcc.subcategory
         AND cpcc.in_planning = 1
         AND csc.company_id = cpcc.company_id
       INNER JOIN scmdata.t_standard_work_minte_cfg swmc
          ON csc.coop_category = swmc.category
         AND csc.coop_productcate = swmc.product_cate
         AND csc.coop_subcategory = swmc.subcategory
         AND csc.company_id = swmc.company_id
       WHERE csc.supplier_code = v_supcode
         AND csc.coop_category = v_cate
         AND csc.coop_productcate = v_procate
         AND csc.coop_subcategory = v_subcate
         AND rownum = 1;
    
      IF v_jugnum = 0
         AND v_catejug = 0 THEN
        DELETE FROM scmdata.t_supcapacity_week_plan
         WHERE swp_id = i.swp_id
           AND company_id = i.company_id;
      
        DELETE FROM scmdata.t_supcapcweekplan_sup_detail
         WHERE swp_id = i.swp_id
           AND company_id = i.company_id;
      
        DELETE FROM scmdata.t_supcapcweekplan_catewks_detail
         WHERE swp_id = i.swp_id
           AND company_id = i.company_id;
      
        DELETE FROM scmdata.t_supcapcweekplan_supwks_detail
         WHERE swp_id = i.swp_id
           AND company_id = i.company_id;
      END IF;
    END LOOP;
  
    --品类周产能规划部分
    DELETE FROM scmdata.t_cateweekplan_sup_detail
     WHERE supplier_code = v_supcode
       AND factory_code = v_faccode
       AND category = v_cate
       AND product_cate = v_procate
       AND subcategory = v_subcate
       AND DAY >= v_despday
       AND company_id = v_compid;
  
    DELETE FROM scmdata.t_cateweekplan_cate_detail
     WHERE supplier_code = v_supcode
       AND category = v_cate
       AND product_cate = v_procate
       AND subcategory = v_subcate
       AND DAY >= v_despday
       AND company_id = v_compid;
  
    FOR l IN (SELECT DISTINCT cwp_id,
                              company_id
                FROM scmdata.t_catecapacity_week_plan
               WHERE supplier_code = v_supcode
                 AND category = v_cate
                 AND product_cate = v_procate
                 AND subcategory = v_subcate
                 AND company_id = v_compid
                 AND (YEAR, week) IN
                     (SELECT DISTINCT trunc(yearweek / 100),
                                      MOD(yearweek, 100)
                        FROM scmdata.t_day_dim
                       WHERE dd_date >= v_despday)) LOOP
    
      DELETE FROM scmdata.t_catecapacity_week_plan
       WHERE cwp_id = l.cwp_id
         AND company_id = l.company_id;
    
      DELETE FROM scmdata.t_cateweekplan_supwks_detail
       WHERE cwp_id = l.cwp_id
         AND company_id = l.company_id;
    END LOOP;
  
    FOR y IN (SELECT swp_id,
                     company_id
                FROM scmdata.t_supcapacity_week_plan
               WHERE supplier_code = v_supcode
                 AND category = v_cate
                 AND company_id = v_compid) LOOP
      SELECT SUM(capacity_ceiling),
             SUM(app_capacity)
        INTO v_sumcapcceiling,
             v_sumappcapc
        FROM scmdata.t_supcapcweekplan_sup_detail
       WHERE swp_id = y.swp_id
         AND company_id = y.company_id;
    
      SELECT SUM(trunc(tscd.alo_capacity * tswmc.standard_worktime)),
             SUM(trunc(tscd.pln_capacity * tswmc.standard_worktime)),
             SUM(trunc(tscd.pls_capacity * tswmc.standard_worktime)),
             SUM(trunc(tscd.capc_diffwopln * tswmc.standard_worktime)),
             SUM(trunc(tscd.capc_diffwipln * tswmc.standard_worktime)),
             SUM(trunc(tscd.capc_diffwipls * tswmc.standard_worktime))
        INTO v_sumalocapc,
             v_sumplncapc,
             v_sumplscapc,
             v_sumcapcdiffwopln,
             v_sumcapcdiffwipln,
             v_sumcapcdiffwipls
        FROM scmdata.t_supcapcweekplan_cate_detail tscd
       INNER JOIN scmdata.t_standard_work_minte_cfg tswmc
          ON tscd.category = tswmc.category
         AND tscd.product_cate = tswmc.product_cate
         AND tscd.subcategory = tswmc.subcategory
         AND tscd.company_id = tswmc.company_id
       WHERE tscd.swp_id = y.swp_id
         AND tscd.company_id = y.company_id;
    
      SELECT COUNT(DISTINCT DAY)
        INTO v_warningdays
        FROM scmdata.t_supcapcweekplan_cate_detail
       WHERE swp_id = y.swp_id
         AND capc_diffwipls < 0
         AND company_id = y.company_id;
    
      --汇总数据到供应商周产能规划表
      UPDATE scmdata.t_supcapacity_week_plan
         SET celling_capc    = nvl(v_sumcapcceiling, 0),
             appoint_capc    = nvl(v_sumappcapc, 0),
             alord_capc      = nvl(v_sumalocapc, 0),
             plannew_capc    = nvl(v_sumplncapc, 0),
             plansupp_capc   = nvl(v_sumplscapc, 0),
             capc_diff_wonew = nvl(v_sumcapcdiffwopln, 0),
             capc_diff_winew = nvl(v_sumcapcdiffwipln, 0),
             capc_diff_wipls = nvl(v_sumcapcdiffwipls, 0),
             warning_days    = nvl(v_warningdays, 0)
       WHERE swp_id = y.swp_id
         AND company_id = y.company_id;
    END LOOP;
  
  END p_delete_wkplandata;

  /*=================================================================================
  
    待重算工厂剩余产能占比表新增
  
    用途:
      用于新增待重算工厂剩余产能占比表数据
  
    入参:
      V_FACCODE  :  企业
      V_COMPID   :  企业Id
  
    版本:
      2022-01-13 : 手动修改调度器状态（自治事务）
      2022-02-28 : 废弃
  
  =================================================================================*/
  PROCEDURE p_ins_faccode_into_tab
  (
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_pos_upd_facrestrate
     WHERE fac_code = v_faccode
       AND company_id = v_compid
       AND status = 'PD'
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_pos_upd_facrestrate
        (puf_id, company_id, status, fac_code, create_time)
      VALUES
        (scmdata.f_get_uuid(), v_compid, 'PD', v_faccode, SYSDATE);
    END IF;
  END p_ins_faccode_into_tab;

  /*===================================================================================
  
    剩余产能占比更新
  
    用途:
      用于剩余产能占比更新
  
    入参:
      V_FACCODE  : 工厂编码
      V_COMPID   : 企业Id
  
    版本:
      2022-05-12 : 剩余产能占比更新
  
  ===================================================================================*/
  PROCEDURE p_upd_facrestrate
  (
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  
  BEGIN
    FOR i IN (SELECT DISTINCT ctdd_id,
                              company_id
                FROM scmdata.t_capacity_appointment_detail
               WHERE (ptc_id, company_id) IN
                     (SELECT ptc_id,
                             company_id
                        FROM scmdata.t_supplier_capacity_detail
                       WHERE factory_code = v_faccode
                         AND company_id = v_compid)) LOOP
      scmdata.pkg_capacity_withview_management.p_getandupd_slatabrestappcapc_withview(v_ctddid => i.ctdd_id,
                                                                                      v_compid => i.company_id);
    END LOOP;
  END p_upd_facrestrate;

  /*=========================================================================
  
    产能预约明细数据生成
  
    用途：产能预约明细数据生成
  
    入参：
      V_PTCID          :  供应商产能预约表Id
      V_YEARWEEK       :  年周
      V_NOTWORKDDIDS   :  不开工日期
      V_WKPEOPLE       :  车位人数
      V_WKHOUR         :  工作时长
      V_PRODEFF        :  生产效率
      V_APPRATE        :  预约产能占比
      V_OPERID         :  动作发生时操作人
      V_OPERTIME       :  动作发生时间
      V_COMPID         :  企业id
  
    版本：
      2022-05-06 : 产能预约明细数据生成
  
  ==========================================================================*/
  PROCEDURE p_gen_capcappdtldata
  (
    v_ptcid        IN VARCHAR2,
    v_yearweek     IN NUMBER,
    v_notworkddids IN VARCHAR2,
    v_wkpeople     IN NUMBER,
    v_wkhour       IN NUMBER,
    v_prodeff      IN NUMBER,
    v_apprate      IN NUMBER,
    v_operid       IN VARCHAR2,
    v_opertime     IN VARCHAR2,
    v_isupd        IN NUMBER DEFAULT 1,
    v_compid       IN VARCHAR2
  ) IS
    v_ctddid      VARCHAR2(32);
    v_capcceil    NUMBER(16, 2);
    v_appcapc     NUMBER(16, 2);
    v_appcapcrate NUMBER(5, 2);
  BEGIN
    --供应商产能预约明细数据生成
    FOR m IN (SELECT *
                FROM scmdata.t_day_dim
               WHERE yearweek = v_yearweek
                 AND instr(';' || v_notworkddids || ';', ';' || dd_id || ';') = 0) LOOP
      --获取唯一id
      SELECT MAX(ctdd_id)
        INTO v_ctddid
        FROM scmdata.t_capacity_appointment_detail
       WHERE ptc_id = v_ptcid
         AND DAY = m.dd_date
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_ctddid IS NULL THEN
        --当供应商产能预约明细数据id为空,且状态正常
        --生成供应商产能预约明细数据id
        v_ctddid := scmdata.f_get_uuid();
      
        --新增逻辑
        INSERT INTO scmdata.t_capacity_appointment_detail
          (ctdd_id, company_id, ptc_id, DAY, work_hour, work_people, appcapacity_rate, prod_effient, create_id, create_time, create_company_id, origin)
        VALUES
          (v_ctddid, v_compid, v_ptcid, m.dd_date, nvl(v_wkhour, 0), nvl(v_wkpeople,
                0), nvl(v_apprate, 0), nvl(v_prodeff, 0), v_operid, to_date(v_opertime,
                    'YYYY-MM-DD HH24-MI-SS'), v_compid, 'SYS');
      ELSE
        IF v_isupd = 0 THEN
          UPDATE scmdata.t_capacity_appointment_detail
             SET work_hour         = v_wkhour,
                 work_people       = v_wkpeople,
                 appcapacity_rate  = v_apprate,
                 prod_effient      = v_prodeff,
                 update_id         = v_operid,
                 update_time       = to_date(v_opertime,
                                             'YYYY-MM-DD HH24-MI-SS'),
                 update_company_id = v_compid
           WHERE ptc_id = v_ptcid
             AND DAY = m.dd_date
             AND company_id = v_compid;
        END IF;
      END IF;
    END LOOP;
  
    --不开工数据删除
    FOR l IN (SELECT *
                FROM scmdata.t_day_dim
               WHERE yearweek = v_yearweek
                 AND instr(';' || v_notworkddids || ';', ';' || dd_id || ';') > 0) LOOP
      DELETE FROM scmdata.t_capacity_appointment_detail tcad
       WHERE ptc_id = v_ptcid
         AND DAY = l.dd_date
         AND company_id = v_compid;
    
      DELETE FROM scmdata.t_capacity_appointment_detail_view
       WHERE ptc_id = v_ptcid
         AND DAY = l.dd_date
         AND company_id = v_compid;
    END LOOP;
  
    --计算产能上限和约定产能
    scmdata.pkg_capacity_management.p_calculate_capacity_rela(v_ptcid       => v_ptcid,
                                                              v_compid      => v_compid,
                                                              v_capcceiling => v_capcceil,
                                                              v_appcapacity => v_appcapc);
  
    --更新主表
    IF v_capcceil <> 0
       AND v_capcceil IS NOT NULL THEN
      v_appcapcrate := v_appcapc / v_capcceil * 100;
    END IF;
  
    UPDATE scmdata.t_supplier_capacity_detail
       SET capacity_ceiling = v_capcceil,
           app_capacity     = v_appcapc,
           appcapacity_rate = v_appcapcrate
     WHERE ptc_id = v_ptcid
       AND company_id = v_compid;
  END p_gen_capcappdtldata;

  /*===================================================================================
  
    根据不同参数增删改供应商产能预约数据
  
    用途:
      根据不同参数增删改供应商产能预约数据
  
    入参:
      V_SUPCODE     :  供应商编码
      V_FACCODE     :  生产工厂编码
      V_CATE        :  分类
      V_OPERID      :  动作发生时操作人
      V_OPERTIME    :  动作发生时间
      V_COMPID      :  企业Id
  
    版本:
      2022-03-04 : 根据不同参数增删改供应商产能预约数据
      2022-05-06 : 修复主表供应商产能预约表删除不彻底问题
                   从表供应商产能预约明细生成逻辑分离
  
  ===================================================================================*/
  PROCEDURE p_idu_supcapcappdata_by_diffparam
  (
    v_supcode     IN VARCHAR2,
    v_faccode     IN VARCHAR2,
    v_cate        IN VARCHAR2,
    v_operid      IN VARCHAR2,
    v_opertime    IN VARCHAR2,
    v_issubtabupd IN NUMBER DEFAULT 1,
    v_compid      IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc             rctype;
    v_rcsupcode    VARCHAR2(32);
    v_rcfaccode    VARCHAR2(32);
    v_rccate       VARCHAR2(2);
    v_rcpsnum      NUMBER(8);
    v_rcnpnum      NUMBER(8);
    v_supfilepause NUMBER(1);
    v_cond         VARCHAR2(1024);
    v_faccond      VARCHAR2(128);
    v_exesql       VARCHAR2(4000);
    v_startday     DATE;
    v_endday       DATE;
    v_wkernum      NUMBER(16);
    v_wknum        NUMBER(16);
    v_ptcid        VARCHAR2(32);
    v_ar           NUMBER(16, 2);
    v_pe           NUMBER(16, 2);
    v_year         NUMBER(4);
    v_week         NUMBER(2);
    v_notworkddids CLOB;
    v_ywnotworkids VARCHAR2(4000);
  BEGIN
    v_startday := trunc(to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS'), 'IW');
    v_endday   := trunc(to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS'), 'IW') + 70;
  
    v_cond := ' WHERE SUPPLIER_CODE = ''' || v_supcode || '''';
  
    IF v_cate IS NOT NULL THEN
      v_cond := v_cond || ' AND COOP_CATEGORY = ''' || v_cate || '''';
    END IF;
  
    v_cond := v_cond || ' AND COMPANY_ID = ''' || v_compid || '''';
  
    IF v_faccode IS NOT NULL THEN
      v_faccond := ' AND CFC.FACTORY_CODE = ''' || v_faccode || '''';
    END IF;
  
    v_exesql := 'SELECT SUPPLIER_CODE,
       FACTORY_CODE,
       COOP_CATEGORY,
       SUM(CASE WHEN INPLN = 0 THEN 1 ELSE 0 END) PSNUM,
       SUM(CASE WHEN INPLN = 1 THEN 1 ELSE 0 END) NPNUM,
       MAX(SIGN(TOTALPAUSE)) SUPFILEPAUSE
  FROM (SELECT CSC.SUPPLIER_CODE,
               CFC.FACTORY_CODE,
               CSC.COOP_CATEGORY,
               CSC.COOP_PRODUCTCATE,
               CSC.COOP_SUBCATEGORY,
               SIGN(NVL(CSC.PAUSE,1) + NVL(CFC.PAUSE,1) + DECODE(CPCC.IN_PLANNING,1,0,1)) INPLN,
               JUG.TOTALPAUSE
          FROM (SELECT CSC_ID,
                       SUPPLIER_CODE,
                       COMPANY_ID,
                       COOP_CATEGORY,
                       COOP_PRODUCTCATE,
                       COOP_SUBCATEGORY,
                       CREATE_TIME,
                       PAUSE
                  FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG ' ||
                v_cond || '
                 ORDER BY CREATE_TIME) CSC
         INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG CFC
            ON CSC.CSC_ID = CFC.CSC_ID ' || v_faccond || '
           AND CSC.COMPANY_ID = CFC.COMPANY_ID
         INNER JOIN SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG CPCC
            ON CPCC.CATEGORY = CSC.COOP_CATEGORY
           AND CPCC.PRODUCT_CATE = CSC.COOP_PRODUCTCATE
           AND CPCC.SUBCATEGORY = CSC.COOP_SUBCATEGORY
          LEFT JOIN (SELECT TSI1.SUPPLIER_CODE,
                            TSI2.SUPPLIER_CODE FACTORY_CODE,
                            TCS1.COOP_CLASSIFICATION,
                            TCS1.COOP_PRODUCT_CATE,
                            TCS1.COOP_SUBCATEGORY SUP_SUBCATEGORY,
                            TCS2.COOP_SUBCATEGORY FAC_SUBCATEGORY,
                            TSI1.COMPANY_ID,
                            SIGN(DECODE(TSI1.PAUSE, 2, 0, TSI1.PAUSE) +
                                 TCS1.PAUSE +
                                 DECODE(TSI2.PAUSE, 2, 0, TSI2.PAUSE) +
                                 TCF1.PAUSE + TCS2.PAUSE) TOTALPAUSE
                       FROM SCMDATA.T_SUPPLIER_INFO TSI1
                      INNER JOIN SCMDATA.T_COOP_SCOPE TCS1
                         ON TSI1.SUPPLIER_INFO_ID = TCS1.SUPPLIER_INFO_ID
                        AND TSI1.COMPANY_ID = TCS1.COMPANY_ID
                      INNER JOIN SCMDATA.T_COOP_FACTORY TCF1
                         ON TSI1.SUPPLIER_INFO_ID = TCF1.SUPPLIER_INFO_ID
                        AND TSI1.COMPANY_ID = TCF1.COMPANY_ID
                      INNER JOIN SCMDATA.T_SUPPLIER_INFO TSI2
                         ON TCF1.FAC_SUP_INFO_ID = TSI2.SUPPLIER_INFO_ID
                        AND TCF1.COMPANY_ID = TSI2.COMPANY_ID
                      INNER JOIN SCMDATA.T_COOP_SCOPE TCS2
                         ON TSI2.SUPPLIER_INFO_ID = TCS2.SUPPLIER_INFO_ID
                        AND TSI2.COMPANY_ID = TCS2.COMPANY_ID
                        AND TCS1.COOP_CLASSIFICATION = TCS2.COOP_CLASSIFICATION
                        AND TCS1.COOP_PRODUCT_CATE = TCS2.COOP_PRODUCT_CATE) JUG
             ON CSC.SUPPLIER_CODE = JUG.SUPPLIER_CODE
            AND CFC.FACTORY_CODE = JUG.FACTORY_CODE
            AND CSC.COOP_CATEGORY = JUG.COOP_CLASSIFICATION
            AND CSC.COOP_PRODUCTCATE = JUG.COOP_PRODUCT_CATE
            AND INSTR(JUG.SUP_SUBCATEGORY, CSC.COOP_SUBCATEGORY) > 0
            AND INSTR(JUG.FAC_SUBCATEGORY, CSC.COOP_SUBCATEGORY) > 0
            AND CSC.COMPANY_ID = JUG.COMPANY_ID)
 GROUP BY SUPPLIER_CODE, FACTORY_CODE, COOP_CATEGORY';
  
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO v_rcsupcode,
             v_rcfaccode,
             v_rccate,
             v_rcpsnum,
             v_rcnpnum,
             v_supfilepause;
      EXIT WHEN rc%NOTFOUND;
    
      IF v_rcsupcode IS NOT NULL THEN
        --获取车位人数，工作时长，预约占比，生产效率
        SELECT MAX(wkperson_num),
               MAX(wktime_num),
               MAX(appcapc_rate),
               MAX(prod_eff)
          INTO v_wkernum,
               v_wknum,
               v_ar,
               v_pe
          FROM scmdata.t_app_capacity_cfg
         WHERE supplier_code = v_rcsupcode
           AND factory_code = v_rcfaccode
           AND company_id = v_compid;
      
        --获取不开工日期
        v_notworkddids := scmdata.pkg_capacity_management.f_get_notworkdays(v_supcode => v_rcfaccode,
                                                                            v_braid   => v_rccate,
                                                                            v_compid  => v_compid);
      
        IF v_wkernum IS NOT NULL
           AND v_wknum IS NOT NULL
           AND nvl(v_ar, 0) IS NOT NULL
           AND v_pe IS NOT NULL THEN
          --供应商产能预约表数据生成
          FOR i IN (SELECT DISTINCT yearweek
                      FROM scmdata.t_day_dim
                     WHERE dd_date BETWEEN v_startday AND v_endday
                     ORDER BY yearweek) LOOP
            v_year := substr(i.yearweek, 1, 4);
            v_week := substr(i.yearweek, 5, 2);
          
            --获取唯一id
            SELECT MAX(ptc_id)
              INTO v_ptcid
              FROM scmdata.t_supplier_capacity_detail
             WHERE supplier_code = v_rcsupcode
               AND factory_code = v_rcfaccode
               AND category = v_rccate
               AND YEAR = v_year
               AND week = v_week
               AND company_id = v_compid;
          
            IF v_ptcid IS NULL
               AND v_rcpsnum > 0
               AND v_supfilepause = 0 THEN
              --供应商产能预约表没有数据，且各项配置都为正常
              --新增逻辑
              --唯一id生成
              v_ptcid := scmdata.f_get_uuid();
            
              --获取当前年周不开工日期ids
              SELECT listagg(dd_id, ';')
                INTO v_ywnotworkids
                FROM scmdata.t_day_dim
               WHERE yearweek = i.yearweek
                 AND instr(';' || v_notworkddids || ';',
                           ';' || dd_id || ';') > 0;
            
              --新增进入业务表
              INSERT INTO scmdata.t_supplier_capacity_detail
                (ptc_id, company_id, category, supplier_code, factory_code, YEAR, week, not_workday, create_id, create_time, create_company_id)
              VALUES
                (v_ptcid, v_compid, v_rccate, v_rcsupcode, v_rcfaccode, v_year, v_week, v_ywnotworkids, v_operid, to_date(v_opertime,
                          'YYYY-MM-DD HH24-MI-SS'), v_compid);
            
              --供应商产能预约明细数据生成
              p_gen_capcappdtldata(v_ptcid        => v_ptcid,
                                   v_yearweek     => i.yearweek,
                                   v_notworkddids => v_notworkddids,
                                   v_wkpeople     => v_wkernum,
                                   v_wkhour       => v_wknum,
                                   v_prodeff      => v_pe,
                                   v_apprate      => v_ar,
                                   v_operid       => v_operid,
                                   v_opertime     => v_opertime,
                                   v_isupd        => v_issubtabupd,
                                   v_compid       => v_compid);
            ELSIF v_ptcid IS NOT NULL
                  AND v_rcpsnum > 0
                  AND v_supfilepause = 0 THEN
              --供应商产能预约表有数据，且各项配置都为正常
              --获取当前年周不开工日期ids
              SELECT listagg(dd_id, ';')
                INTO v_ywnotworkids
                FROM scmdata.t_day_dim
               WHERE yearweek = i.yearweek
                 AND instr(';' || v_notworkddids || ';',
                           ';' || dd_id || ';') > 0;
            
              --更新不开工日期字段
              UPDATE scmdata.t_supplier_capacity_detail
                 SET not_workday       = v_ywnotworkids,
                     update_id         = v_operid,
                     update_time       = to_date(v_opertime,
                                                 'YYYY-MM-DD HH24-MI-SS'),
                     update_company_id = v_compid
               WHERE ptc_id = v_ptcid
                 AND YEAR = v_year
                 AND week = v_week
                 AND company_id = v_compid;
            
              --供应商产能预约明细数据生成
              p_gen_capcappdtldata(v_ptcid        => v_ptcid,
                                   v_yearweek     => i.yearweek,
                                   v_notworkddids => v_notworkddids,
                                   v_wkpeople     => v_wkernum,
                                   v_wkhour       => v_wknum,
                                   v_prodeff      => v_pe,
                                   v_apprate      => v_ar,
                                   v_operid       => v_operid,
                                   v_opertime     => v_opertime,
                                   v_isupd        => v_issubtabupd,
                                   v_compid       => v_compid);
            ELSIF v_ptcid IS NOT NULL
                  AND ((v_rcpsnum = 0 AND v_rcnpnum > 0) OR
                  (v_supfilepause > 0)) THEN
              --供应商产能预约表有数据，且各项配置存在异常
              --删除供应商产能预约表数据
              DELETE FROM scmdata.t_supplier_capacity_detail
               WHERE ptc_id = v_ptcid
                 AND company_id = v_compid;
            
              --删除供应商产能预约明细表数据
              DELETE FROM scmdata.t_capacity_appointment_detail
               WHERE ptc_id = v_ptcid
                 AND company_id = v_compid;
            END IF;
          END LOOP;
        END IF;
      END IF;
    END LOOP;
    CLOSE rc;
  END p_idu_supcapcappdata_by_diffparam;

  /*===================================================================================
  
    根据入参增删改下单规划-生产排期已下订单数据生成逻辑
  
    用途:
      根据入参增删改下单规划-生产排期已下订单数据生成逻辑
  
    入参:
      V_SUPCODE    :  供应商编码
      V_FACCODE    :  生产工厂编码
      V_CATE       :  分类
      V_PROCATE    :  生产分类
      V_SUBCATE    :  子类
      V_COMPID     :  企业Id
  
    版本:
      2022-03-04 : 根据入参增删改下单规划-生产排期已下订单数据生成逻辑
      2022-05-05 : 增加 [排除历史收货，已排期数据] 重算重排
                   增加 [日生产平均数小于1，每天按日生产1件均匀分配到每一天] 重算重排
  
  ===================================================================================*/
  PROCEDURE p_idu_alorder_data_by_diffparam
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc                 rctype;
    v_curwkday         DATE := trunc(SYSDATE);
    v_rcordcode        VARCHAR2(32);
    v_rcisfirstord     NUMBER(1);
    v_rccreatetime     DATE;
    v_rcdelvdate       DATE;
    v_rccalcamount     NUMBER(16);
    v_preprodamt       NUMBER(16);
    v_rcfirordmatwait  NUMBER(4);
    v_rcaddordmatwait  NUMBER(4);
    v_rcpcandtranswait NUMBER(4);
    v_rcpause          NUMBER(1);
    v_cond             VARCHAR2(1024);
    v_exesql           VARCHAR2(4000);
    v_startday         DATE;
    v_endday           DATE;
    v_staddday         NUMBER(4);
    v_calcdaynum       NUMBER(4);
    v_avgamount        NUMBER(8);
    v_insdayamt        NUMBER(8);
    v_jugnum           NUMBER(1);
  BEGIN
    IF v_supcode IS NOT NULL THEN
      v_cond := 'Z.SUPPLIER_CODE = ''' || v_supcode || '''';
    END IF;
  
    IF v_faccode IS NOT NULL THEN
      v_cond := v_cond || ' AND Y.FACTORY_CODE = ''' || v_faccode || '''';
    END IF;
  
    IF v_cate IS NOT NULL THEN
      v_cond := v_cond || ' AND X.CATEGORY = ''' || v_cate || '''';
    END IF;
  
    IF v_procate IS NOT NULL THEN
      v_cond := v_cond || ' AND X.PRODUCT_CATE = ''' || v_procate || '''';
    END IF;
  
    IF v_subcate IS NOT NULL THEN
      v_cond := v_cond || ' AND X.SAMLL_CATEGORY = ''' || v_subcate || '''';
    END IF;
  
    v_exesql := 'SELECT DISTINCT Z.ORDER_CODE,
                        Z.ISFIRSTORDERED,
                        Z.CREATE_TIME,
                        Y.DELIVERY_DATE,
                        Y.ORDER_AMOUNT - Y.GOT_AMOUNT CALCAMOUNT,
                        NVL(W.FIRST_ORD_MAT_WAIT, 0) FIRST_ORD_MAT_WAIT,
                        NVL(W.ADD_ORD_MAT_WAIT, 0) ADD_ORD_MAT_WAIT,
                        NVL(W.PC_AND_TRANS_WAIT, 0) PC_AND_TRANS_WAIT,
                        SIGN(V.PAUSE + U.PAUSE + DECODE(T.IN_PLANNING,1,0,1)) PAUSE
                   FROM (SELECT ORDER_CODE,
                                COMPANY_ID,
                                CREATE_TIME,
                                DELIVERY_DATE,
                                ISFIRSTORDERED,
                                SUPPLIER_CODE
                           FROM SCMDATA.T_ORDERED
                          WHERE ORDER_STATUS IN (''OS01'', ''OS00'')
                            AND IS_PRODUCT_ORDER = 1
                            AND COMPANY_ID = ''' || v_compid ||
                ''') Z
                  INNER JOIN SCMDATA.T_ORDERS Y
                     ON Z.ORDER_CODE = Y.ORDER_ID
                    AND Z.COMPANY_ID = Y.COMPANY_ID
                    AND Y.DELIVERY_DATE BETWEEN SYSDATE AND SYSDATE + 69
                  INNER JOIN SCMDATA.T_COMMODITY_INFO X
                     ON X.GOO_ID     = Y.GOO_ID
                    AND X.COMPANY_ID = Y.COMPANY_ID
                   LEFT JOIN SCMDATA.T_PRODUCT_CYCLE_CFG W
                    ON X.CATEGORY       = W.CATEGORY
                   AND X.PRODUCT_CATE   = W.PRODUCT_CATE
                   AND X.SAMLL_CATEGORY = W.SUBCATEGORY
                   AND (W.SUPPLIER_CODES IS NULL OR
                       INSTR(W.SUPPLIER_CODES, Y.FACTORY_CODE) > 0)
                  LEFT JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG V
                    ON Z.SUPPLIER_CODE  = V.SUPPLIER_CODE
                   AND X.CATEGORY       = V.COOP_CATEGORY
                   AND X.PRODUCT_CATE   = V.COOP_PRODUCTCATE
                   AND X.SAMLL_CATEGORY = V.COOP_SUBCATEGORY
                   AND Z.COMPANY_ID     = V.COMPANY_ID
                  LEFT JOIN SCMDATA.T_COOPCATE_FACTORY_CFG U
                    ON Y.FACTORY_CODE = U.FACTORY_CODE
                   AND Y.COMPANY_ID   = U.COMPANY_ID
                   AND V.CSC_ID       = U.CSC_ID
                   AND V.COMPANY_ID   = U.COMPANY_ID
                  LEFT JOIN SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG T
                    ON X.CATEGORY       = T.CATEGORY
                   AND X.PRODUCT_CATE   = T.PRODUCT_CATE
                   AND X.SAMLL_CATEGORY = T.SUBCATEGORY
                   AND X.COMPANY_ID     = T.COMPANY_ID
                 WHERE ' || v_cond;
  
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO v_rcordcode,
             v_rcisfirstord,
             v_rccreatetime,
             v_rcdelvdate,
             v_rccalcamount,
             v_rcfirordmatwait,
             v_rcaddordmatwait,
             v_rcpcandtranswait,
             v_rcpause;
    
      EXIT WHEN rc%NOTFOUND;
    
      IF v_rcordcode IS NOT NULL THEN
        IF v_rcpause = 1 THEN
          DELETE FROM scmdata.t_production_schedule
           WHERE order_id = v_rcordcode
             AND company_id = v_compid;
        
          DELETE FROM scmdata.t_production_schedule_view
           WHERE order_id = v_rcordcode
             AND company_id = v_compid;
        
        ELSIF v_rcpause = 0 THEN
          IF v_rcisfirstord = 0 THEN
            v_staddday := v_rcaddordmatwait;
          ELSE
            v_staddday := v_rcfirordmatwait;
          END IF;
        
          IF v_curwkday <= trunc(v_rccreatetime) + 1 + v_staddday
             AND trunc(v_rccreatetime) + 1 + v_staddday <= v_curwkday + 7 THEN
            v_startday := trunc(v_rccreatetime) + 1 + v_staddday;
          ELSE
            v_startday := v_curwkday + 1;
          END IF;
        
          SELECT SUM(product_amount)
            INTO v_preprodamt
            FROM scmdata.t_production_schedule
           WHERE order_id = v_rcordcode
             AND company_id = v_compid
             AND DAY < trunc(v_startday);
        
          DELETE FROM scmdata.t_production_schedule
           WHERE order_id = v_rcordcode
             AND company_id = v_compid
             AND DAY >= trunc(v_startday);
        
          v_rccalcamount := v_rccalcamount - nvl(v_preprodamt, 0);
        
          v_endday     := trunc(v_rcdelvdate) - v_rcpcandtranswait;
          v_calcdaynum := to_number(v_endday - v_startday) + 1;
        
          IF to_number(v_endday - v_startday) = 0 THEN
            v_calcdaynum := 1;
          END IF;
        
          IF v_calcdaynum > 0 THEN
            v_avgamount := trunc(v_rccalcamount / v_calcdaynum);
          
            IF v_avgamount > 0 THEN
              FOR insinfo IN (SELECT dd_date
                                FROM scmdata.t_day_dim
                               WHERE dd_date BETWEEN v_startday AND v_endday) LOOP
                IF insinfo.dd_date <> v_endday
                   AND v_calcdaynum <> 1 THEN
                  v_insdayamt := v_avgamount;
                ELSIF insinfo.dd_date = v_endday
                      AND v_calcdaynum <> 1 THEN
                  v_insdayamt := v_rccalcamount -
                                 (v_avgamount * (v_calcdaynum - 1));
                ELSIF v_calcdaynum = 1 THEN
                  v_insdayamt := v_avgamount;
                END IF;
              
                SELECT COUNT(1)
                  INTO v_jugnum
                  FROM scmdata.t_production_schedule
                 WHERE order_id = v_rcordcode
                   AND trunc(DAY) = trunc(insinfo.dd_date)
                   AND company_id = v_compid
                   AND rownum = 1;
              
                IF v_jugnum = 0
                   AND v_rcpause = 0 THEN
                  INSERT INTO scmdata.t_production_schedule
                    (ps_id, company_id, order_id, DAY, product_amount)
                  VALUES
                    (scmdata.f_get_uuid(), v_compid, v_rcordcode, trunc(insinfo.dd_date), v_insdayamt);
                ELSIF v_jugnum > 0
                      AND v_rcpause = 0 THEN
                  UPDATE scmdata.t_production_schedule
                     SET product_amount = v_insdayamt
                   WHERE order_id = v_rcordcode
                     AND trunc(DAY) = trunc(insinfo.dd_date)
                     AND company_id = v_compid;
                END IF;
              END LOOP;
            ELSIF v_avgamount = 0 THEN
              FOR x IN (SELECT x1.dd_date,
                               x2.order_id recex
                          FROM scmdata.t_day_dim x1
                          LEFT JOIN (SELECT order_id,
                                           DAY
                                      FROM scmdata.t_production_schedule
                                     WHERE order_id = v_rcordcode
                                       AND company_id = v_compid) x2
                            ON x1.dd_date = x2.day
                         WHERE x1.dd_date BETWEEN v_startday AND v_endday) LOOP
                IF x.dd_date BETWEEN v_startday AND
                   v_startday + v_rccalcamount - 1 THEN
                  v_insdayamt := 1;
                ELSE
                  v_insdayamt := 0;
                END IF;
              
                IF x.recex IS NOT NULL THEN
                  UPDATE scmdata.t_production_schedule
                     SET product_amount = v_insdayamt
                   WHERE order_id = v_rcordcode
                     AND trunc(DAY) = trunc(x.dd_date)
                     AND company_id = v_compid;
                ELSE
                  INSERT INTO scmdata.t_production_schedule
                    (ps_id, company_id, order_id, DAY, product_amount)
                  VALUES
                    (scmdata.f_get_uuid(), v_compid, v_rcordcode, trunc(x.dd_date), v_insdayamt);
                END IF;
              END LOOP;
            END IF;
          END IF;
        END IF;
      END IF;
    END LOOP;
    CLOSE rc;
  END p_idu_alorder_data_by_diffparam;

  /*===================================================================================
  
    将 SCMDATA.T_PRODUCTION_SCHEDULE 及 View 表内不进行产能规划数据的日生产件数置零
  
    用途:
      配置直接修改导致不能从业务表取到值的补充重算逻辑（用于产能品类规划生效）
  
    入参:
      V_CATE       :  分类
      V_PROCATE    :  生产分类
      V_SUBCATE    :  子类
      V_COMPID     :  企业Id
  
    版本:
      2022-05-05 : 将 SCMDATA.T_PRODUCTION_SCHEDULE 及 View 表内
                   不进行产能规划数据的日生产件数置零
  
  ===================================================================================*/
  PROCEDURE p_setpsprodamt_to_zero
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    --补充重算逻辑
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_capacity_plan_category_cfg
     WHERE category = v_cate
       AND product_cate = v_procate
       AND subcategory = v_subcate
       AND in_planning = 1
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum > 0 THEN
      FOR delit IN (SELECT ps_id,
                           company_id
                      FROM (SELECT a1.ps_id,
                                   a1.company_id,
                                   c1.category       cate,
                                   c1.product_cate   procate,
                                   c1.samll_category subcate
                              FROM scmdata.t_production_schedule a1
                             INNER JOIN scmdata.t_orders b1
                                ON a1.order_id = b1.order_id
                               AND a1.company_id = b1.company_id
                             INNER JOIN scmdata.t_commodity_info c1
                                ON b1.goo_id = c1.goo_id
                               AND b1.company_id = c1.company_id
                            UNION ALL
                            SELECT a2.ps_id,
                                   a2.company_id,
                                   b2.category,
                                   b2.product_cate,
                                   b2.subcategory
                              FROM scmdata.t_production_schedule a2
                             INNER JOIN scmdata.t_plan_newproduct b2
                                ON a2.pn_id = b2.pn_id
                               AND a2.company_id = b2.company_id)
                     WHERE cate = v_cate
                       AND procate = v_procate
                       AND subcate = v_subcate
                       AND company_id = v_compid) LOOP
        UPDATE scmdata.t_production_schedule_view
           SET product_amount = 0
         WHERE ps_id = delit.ps_id
           AND company_id = delit.company_id;
      
        UPDATE scmdata.t_production_schedule
           SET product_amount = 0
         WHERE ps_id = delit.ps_id
           AND company_id = delit.company_id;
      END LOOP;
    END IF;
  END p_setpsprodamt_to_zero;

  /*===================================================================================
  
    获取供应商某生产工厂子类日生产占比
  
   用途:
     获取供应商某生产工厂子类日生产占比
  
   入参:
     V_SUPCODE  :  供应商编码
     V_FACCODE  :  生产工厂编码
     V_COMPID   :  企业Id
     V_CATE     :  分类
     V_PROCATE  :  生产分类
     V_SUBCATE  :  子类
     V_DAY      :  日期
  
   版本:
     2022-01-24 : 获取供应商某生产工厂子类日生产占比
  
  ===================================================================================*/
  FUNCTION f_get_supdaysubcaterate
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_day     IN DATE
  ) RETURN NUMBER IS
    v_cates              VARCHAR2(512);
    v_procates           VARCHAR2(512);
    v_subcates           VARCHAR2(4000);
    v_sup_plndaywktime   NUMBER(16, 2);
    v_supsc_plndaywktime NUMBER(16, 2);
    v_sup_plsdaywktime   NUMBER(16, 2);
    v_supsc_plsdaywktime NUMBER(16, 2);
    v_sup_alodaywktime   NUMBER(16, 2);
    v_supsc_alodaywktime NUMBER(16, 2);
    v_rate               NUMBER(5, 4) := 0;
  BEGIN
    --获取单日生产工厂涉及子类
    SELECT listagg(DISTINCT csc.coop_category, ';'),
           listagg(DISTINCT csc.coop_productcate, ';'),
           listagg(DISTINCT csc.coop_subcategory, ';')
      INTO v_cates,
           v_procates,
           v_subcates
      FROM scmdata.t_coopcate_supplier_cfg csc
     INNER JOIN scmdata.t_coopcate_factory_cfg cfc
        ON csc.csc_id = cfc.csc_id
       AND csc.company_id = cfc.company_id
     WHERE csc.supplier_code = v_supcode
       AND cfc.factory_code = v_faccode
       AND csc.company_id = v_compid
       AND csc.pause = 0
       AND cfc.pause = 0
       AND EXISTS (SELECT 1
              FROM scmdata.t_capacity_plan_category_cfg
             WHERE subcategory = csc.coop_subcategory
               AND in_planning = 1);
  
    IF v_cates IS NOT NULL
       AND instr(v_subcates, v_subcate) > 0 THEN
      --获取单日供应商对应生产工厂子类所有产能(工时)
      --预计新品
      SELECT SUM(nvl(ps.product_amount, 0) * nvl(swmc.standard_worktime, 0))
        INTO v_sup_plndaywktime
        FROM scmdata.t_plan_newproduct pn
       INNER JOIN scmdata.t_production_schedule ps
          ON pn.pn_id = ps.pn_id
         AND pn.company_id = ps.company_id
        LEFT JOIN scmdata.t_standard_work_minte_cfg swmc
          ON pn.category = swmc.category
         AND pn.product_cate = swmc.product_cate
         AND pn.subcategory = swmc.subcategory
         AND pn.company_id = swmc.company_id
       WHERE pn.supplier_code = v_supcode
         AND ps.day = v_day
         AND instr(';' || v_cates || ';', ';' || pn.category || ';') > 0
         AND instr(';' || v_procates || ';', ';' || pn.product_cate || ';') > 0
         AND instr(';' || v_subcates || ';', ';' || pn.subcategory || ';') > 0
         AND pn.waveact_status = 'OP'
         AND pn.company_id = v_compid;
    
      SELECT SUM(nvl(ps.product_amount, 0) * nvl(swmc.standard_worktime, 0))
        INTO v_supsc_plndaywktime
        FROM scmdata.t_plan_newproduct pn
       INNER JOIN scmdata.t_production_schedule ps
          ON pn.pn_id = ps.pn_id
         AND pn.company_id = ps.company_id
        LEFT JOIN scmdata.t_standard_work_minte_cfg swmc
          ON pn.category = swmc.category
         AND pn.product_cate = swmc.product_cate
         AND pn.subcategory = swmc.subcategory
            
         AND pn.company_id = swmc.company_id
       WHERE pn.supplier_code = v_supcode
         AND ps.day = v_day
         AND pn.category = v_cate
         AND pn.product_cate = v_procate
         AND pn.subcategory = v_subcate
         AND pn.waveact_status = 'OP'
         AND pn.company_id = v_compid;
    
      --预计补单
      SELECT SUM(nvl(ps.product_amount, 0) * nvl(swmc.standard_worktime, 0))
        INTO v_sup_plsdaywktime
        FROM scmdata.t_plannew_supplementary pns
       INNER JOIN scmdata.t_production_schedule ps
          ON pns.ps_id = ps.pns_id
         AND pns.company_id = ps.company_id
        LEFT JOIN scmdata.t_standard_work_minte_cfg swmc
          ON pns.category = swmc.category
         AND pns.product_cate = swmc.product_cate
         AND pns.subcategory = swmc.subcategory
         AND pns.company_id = swmc.company_id
       WHERE pns.supplier_code = v_supcode
         AND ps.day = v_day
         AND instr(';' || v_cates || ';', ';' || pns.category || ';') > 0
         AND instr(';' || v_procates || ';', ';' || pns.product_cate || ';') > 0
         AND instr(';' || v_subcates || ';', ';' || pns.subcategory || ';') > 0
         AND pns.act_status = 'NO'
         AND pns.company_id = v_compid;
    
      SELECT SUM(nvl(ps.product_amount, 0) * nvl(swmc.standard_worktime, 0))
        INTO v_supsc_plsdaywktime
        FROM scmdata.t_plannew_supplementary pns
       INNER JOIN scmdata.t_production_schedule ps
          ON pns.ps_id = ps.pns_id
         AND pns.company_id = ps.company_id
        LEFT JOIN scmdata.t_standard_work_minte_cfg swmc
          ON pns.category = swmc.category
         AND pns.product_cate = swmc.product_cate
         AND pns.subcategory = swmc.subcategory
         AND pns.company_id = swmc.company_id
       WHERE pns.supplier_code = v_supcode
         AND ps.day = v_day
         AND pns.category = v_cate
         AND pns.product_cate = v_procate
         AND pns.subcategory = v_subcate
         AND pns.act_status = 'NO'
         AND pns.company_id = v_compid;
    
      --已下订单
      SELECT SUM(nvl(ps1.product_amount, 0) *
                 nvl(swmc1.standard_worktime, 0))
        INTO v_sup_alodaywktime
        FROM scmdata.t_ordered orded
       INNER JOIN scmdata.t_orders ords
          ON orded.order_code = ords.order_id
         AND orded.company_id = ords.company_id
        LEFT JOIN scmdata.t_production_schedule ps1
          ON orded.order_code = ps1.order_id
         AND orded.company_id = ps1.company_id
        LEFT JOIN scmdata.t_commodity_info tci
          ON ords.goo_id = tci.goo_id
         AND ords.company_id = tci.company_id
        LEFT JOIN scmdata.t_standard_work_minte_cfg swmc1
          ON tci.category = swmc1.category
         AND tci.product_cate = swmc1.product_cate
         AND tci.samll_category = swmc1.subcategory
         AND tci.company_id = swmc1.company_id
       WHERE orded.supplier_code = v_supcode
         AND instr(';' || v_cates || ';', ';' || tci.category || ';') > 0
         AND instr(';' || v_procates || ';', ';' || tci.product_cate || ';') > 0
         AND instr(';' || v_subcates || ';',
                   ';' || tci.samll_category || ';') > 0
         AND ps1.day = v_day
         AND orded.company_id = v_compid;
    
      SELECT SUM(nvl(ps1.product_amount, 0) *
                 nvl(swmc1.standard_worktime, 0))
        INTO v_supsc_alodaywktime
        FROM scmdata.t_ordered orded
       INNER JOIN scmdata.t_orders ords
          ON orded.order_code = ords.order_id
         AND orded.company_id = ords.company_id
        LEFT JOIN scmdata.t_production_schedule ps1
          ON orded.order_code = ps1.order_id
         AND orded.company_id = ps1.company_id
        LEFT JOIN scmdata.t_commodity_info tci
          ON ords.goo_id = tci.goo_id
         AND ords.company_id = tci.company_id
        LEFT JOIN scmdata.t_standard_work_minte_cfg swmc1
          ON tci.category = swmc1.category
         AND tci.product_cate = swmc1.product_cate
         AND tci.samll_category = swmc1.subcategory
         AND tci.company_id = swmc1.company_id
       WHERE orded.supplier_code = v_supcode
         AND tci.category = v_cate
         AND tci.product_cate = v_procate
         AND tci.samll_category = v_subcate
         AND ps1.day = v_day
         AND orded.company_id = v_compid;
    
      IF nvl(v_supsc_plndaywktime, 0) + nvl(v_supsc_alodaywktime, 0) = 0 THEN
        v_rate := 0;
      ELSIF nvl(v_sup_plndaywktime, 0) + nvl(v_sup_alodaywktime, 0) = 0 THEN
        v_rate := 1;
      ELSE
        v_rate := (nvl(v_supsc_plndaywktime, 0) +
                  nvl(v_supsc_alodaywktime, 0) +
                  nvl(v_supsc_plsdaywktime, 0)) /
                  (nvl(v_sup_plndaywktime, 0) + nvl(v_sup_alodaywktime, 0) +
                  nvl(v_sup_plsdaywktime, 0));
      END IF;
    ELSE
      v_rate := 0;
    END IF;
  
    RETURN v_rate;
  END f_get_supdaysubcaterate;

  /*===================================================================================
  
    CommonFunction
    字段拼接通用方法(返回VARCHAR2)
  
    入参:
      V_SENTENCE    :  被拼接语句，作为拼接字段载体被最终返回
      V_APPENDSTR   :  拼接字段，被拼接在被拼接语句和中间字段后
      V_MIDDLIESTR  :  中间字段，仅存在于被拼接语句不为空且拼接字段不为空的字符中间
  
    返回值:
      最终返回：
      V_SENTENCE + V_MIDDLIESTR + V_APPENDSTR——————V_SENTENCE且V_APPENDSTR不为空
      V_APPENDSTR——————V_SENTENCE为空且V_APPENDSTR不为空
      V_SENTENCE——————V_APPENDSTR为空
  
    版本:
      2022-08-08 : 获取供应商档案启停生成影响行逻辑的sql(返回VARCHAR2)
  
  ===================================================================================*/
  FUNCTION f_sentence_append_rv
  (
    v_sentence   IN VARCHAR2,
    v_appendstr  IN VARCHAR2,
    v_middliestr IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_retst VARCHAR2(4000) := v_sentence;
  BEGIN
    IF v_appendstr IS NOT NULL THEN
      IF v_retst IS NULL THEN
        v_retst := v_appendstr;
      ELSE
        v_retst := v_retst || v_middliestr || v_appendstr;
      END IF;
    END IF;
  
    RETURN v_retst;
  END f_sentence_append_rv;

  /*===================================================================================
  
    CommonFunction
    字段拼接通用方法(返回CLOB)
  
    入参:
      V_SENTENCE    :  被拼接语句，作为拼接字段载体被最终返回
      V_APPENDSTR   :  拼接字段，被拼接在被拼接语句和中间字段后
      V_MIDDLIESTR  :  中间字段，仅存在于被拼接语句不为空且拼接字段不为空的字符中间
  
    返回值:
      最终返回：
      V_SENTENCE + V_MIDDLIESTR + V_APPENDSTR——————V_SENTENCE且V_APPENDSTR不为空
      V_APPENDSTR——————V_SENTENCE为空且V_APPENDSTR不为空
      V_SENTENCE——————V_APPENDSTR为空
  
    版本:
      2022-08-08 : 获取供应商档案启停生成影响行逻辑的sql(返回CLOB)
  
  ===================================================================================*/
  FUNCTION f_sentence_append_rc
  (
    v_sentence   IN CLOB,
    v_appendstr  IN VARCHAR2,
    v_middliestr IN VARCHAR2
  ) RETURN CLOB IS
    v_retst CLOB := v_sentence;
  BEGIN
    IF v_appendstr IS NOT NULL THEN
      IF v_retst IS NULL THEN
        v_retst := v_appendstr;
      ELSE
        v_retst := v_retst || v_middliestr || v_appendstr;
      END IF;
    END IF;
  
    RETURN v_retst;
  END f_sentence_append_rc;

  /*===================================================================================
  
    DataGeneration
    通过不同条件生成品类合作生产工厂+生产工厂产能预约配置数据
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  产品子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-08-09 : 通过不同条件生成品类合作生产工厂+生产工厂产能预约配置数据
  
  ===================================================================================*/
  PROCEDURE p_iu_cfacdata_bydfcond
  (
    v_supcode IN VARCHAR2 DEFAULT NULL,
    v_faccode IN VARCHAR2 DEFAULT NULL,
    v_cate    IN VARCHAR2 DEFAULT NULL,
    v_procate IN VARCHAR2 DEFAULT NULL,
    v_subcate IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rc_type IS REF CURSOR;
    rc          rc_type;
    v_cscid     VARCHAR2(32);
    v_tsupcode  VARCHAR2(32);
    v_tfaccode  VARCHAR2(32);
    v_pause     NUMBER(1);
    v_twkpeople NUMBER(8);
    v_twktime   NUMBER(8);
    v_tprodeff  NUMBER(5, 2);
    v_tcompid   VARCHAR2(32);
    v_toperid   VARCHAR2(32);
    v_topertime DATE;
    v_jugnum    NUMBER(1);
    v_cond      CLOB;
    v_exesql    CLOB;
  BEGIN
    IF v_supcode IS NOT NULL THEN
      v_cond := f_sentence_append_rc(v_sentence   => v_cond,
                                     v_appendstr  => 'TSI.SUPPLIER_CODE = ''' ||
                                                     v_supcode || '''',
                                     v_middliestr => 'AND');
    END IF;
  
    IF v_faccode IS NOT NULL THEN
      v_cond := f_sentence_append_rc(v_sentence   => v_cond,
                                     v_appendstr  => 'TCF.FACTORY_CODE = ''' ||
                                                     v_faccode || '''',
                                     v_middliestr => 'AND');
    END IF;
  
    IF v_cate IS NOT NULL THEN
      v_cond := f_sentence_append_rc(v_sentence   => v_cond,
                                     v_appendstr  => 'CSC.COOP_CATEGORY = ''' ||
                                                     v_cate || '''',
                                     v_middliestr => 'AND');
    END IF;
  
    IF v_procate IS NOT NULL THEN
      v_cond := f_sentence_append_rc(v_sentence   => v_cond,
                                     v_appendstr  => 'CSC.COOP_PRODUCTCATE = ''' ||
                                                     v_procate || '''',
                                     v_middliestr => 'AND');
    END IF;
  
    IF v_subcate IS NOT NULL THEN
      v_cond := f_sentence_append_rc(v_sentence   => v_cond,
                                     v_appendstr  => 'CSC.COOP_SUBCATEGORY = ''' ||
                                                     v_subcate || '''',
                                     v_middliestr => 'AND');
    END IF;
  
    IF v_compid IS NOT NULL THEN
      v_cond := f_sentence_append_rc(v_sentence   => v_cond,
                                     v_appendstr  => 'TSI.COMPANY_ID = ''' ||
                                                     v_subcate || '''',
                                     v_middliestr => 'AND');
    END IF;
  
    v_exesql := 'SELECT CSC.CSC_ID,
                     TSI.SUPPLIER_CODE,
                     TTSI.SUPPLIER_CODE FACTORY_CODE,
                     TTSI.WORKER_NUM,
                     TTSI.WORK_HOURS_DAY,
                     TTSI.PRODUCT_EFFICIENCY,
                     TSI.COMPANY_ID,
                     SIGN(NVL(TSI.PAUSE,0)+NVL(TCS.PAUSE,0)+NVL(TCF.PAUSE,0)) PAUSE,
                     NVL(TTSI.UPDATE_ID,TTSI.CREATE_ID) OPER_ID
                     NVL(TTSI.UPDATE_DATE,TTSI.CREATE_DATE) OPER_TIME
                FROM SCMDATA.T_SUPPLIER_INFO TSI
               INNER JOIN SCMDATA.T_COOP_FACTORY TCF
                  ON TSI.SUPPLIER_INFO_ID = TCF.SUPPLIER_INFO_ID
                 AND TSI.COMPANY_ID = TCF.COMPANY_ID
               INNER JOIN SCMDATA.T_COOP_SCOPE TCS
                  ON TSI.SUPPLIER_INFO_ID = TCS.SUPPLIER_INFO_ID
                 AND TSI.COMPANY_ID = TCS.COMPANY_ID
               INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG CSC
                  ON CSC.COOP_CATEGORY = TCS.COOP_CLASSIFICATION
                 AND CSC.COOP_PRODUCTCATE = TCS.COOP_PRODUCT_CATE
                 AND INSTR(TCS.COOP_SUBCATEGORY, CSC.COOP_SUBCATEGORY) > 0
                 AND TSI.SUPPLIER_CODE = CSC.SUPPLIER_CODE
                 AND TSI.COMPANY_ID = CSC.COMPANY_ID
               INNER JOIN SCMDATA.T_SUPPLIER_INFO TTSI
                  ON TCF.FAC_SUP_INFO_ID = TTSI.SUPPLIER_INFO_ID
                 AND TCF.COMPANY_ID = TTSI.COMPANY_ID
               WHERE ' || v_cond;
  
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO v_cscid,
             v_tsupcode,
             v_tfaccode,
             v_twkpeople,
             v_twktime,
             v_tprodeff,
             v_tcompid,
             v_pause,
             v_toperid,
             v_topertime;
    
      EXIT WHEN rc%NOTFOUND;
    
      IF v_cscid IS NOT NULL THEN
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_coopcate_factory_cfg
         WHERE csc_id = v_cscid
           AND factory_code = v_tfaccode
           AND company_id = v_tcompid
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_coopcate_factory_cfg
            (cfc_id, company_id, csc_id, factory_code, pause, create_id, create_time, is_show)
          VALUES
            (scmdata.f_get_uuid(), v_tcompid, v_cscid, v_tfaccode, v_pause, v_toperid, v_topertime, v_pause);
        END IF;
      
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_app_capacity_cfg
         WHERE supplier_code = v_tsupcode
           AND factory_code = v_tfaccode
           AND company_id = v_tcompid
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_app_capacity_cfg
            (acc_id, company_id, supplier_code, factory_code, wktime_num, wkperson_num, prod_eff, create_id, create_time)
          VALUES
            (scmdata.f_get_uuid(), v_tcompid, v_tsupcode, v_tfaccode, v_twktime, v_twkpeople, v_tprodeff, v_toperid, v_topertime);
        END IF;
      END IF;
    END LOOP;
    CLOSE rc;
  END p_iu_cfacdata_bydfcond;

  /*===================================================================================
  
    生成供应商周产能规划-供应商产能明细周汇总数据
  
    入参:
      V_SWPID    :  供应商周产能规划主表Id
      V_COMPID   :  企业Id
  
    版本:
      2022-07-28 : 生成供应商周产能规划-供应商产能明细周汇总数据
  
  ===================================================================================*/
  PROCEDURE p_iu_swpswsd_data
  (
    v_swpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    FOR i IN (SELECT factory_code,
                     company_id,
                     SUM(nvl(capacity_ceiling, 0)) capacity_ceiling,
                     SUM(nvl(app_capacity, 0)) app_capacity
                FROM scmdata.t_supcapcweekplan_sup_detail
               WHERE swp_id = v_swpid
                 AND company_id = v_compid
               GROUP BY factory_code,
                        company_id) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supcapcweekplan_supwks_detail
       WHERE swp_id = v_swpid
         AND factory_code = i.factory_code
         AND company_id = i.company_id
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_supcapcweekplan_supwks_detail
          (ssd_id, company_id, swp_id, factory_code, ceil_capacity, app_capacity)
        VALUES
          (scmdata.f_get_uuid(), i.company_id, v_swpid, i.factory_code, i.capacity_ceiling, i.app_capacity);
      ELSE
        UPDATE scmdata.t_supcapcweekplan_supwks_detail
           SET ceil_capacity = i.capacity_ceiling,
               app_capacity  = i.app_capacity
         WHERE swp_id = v_swpid
           AND factory_code = i.factory_code
           AND company_id = i.company_id;
      END IF;
    END LOOP;
  END p_iu_swpswsd_data;

  /*===================================================================================
  
    生成品类周产能规划-供应商产能明细周汇总数据
  
    入参:
      V_CWPID    :  品类周产能规划主表Id
      V_COMPID   :  企业Id
  
    版本:
      2022-07-28 : 生成品类周产能规划-供应商产能明细周汇总数据
  
  ===================================================================================*/
  PROCEDURE p_iu_cwpswsd_data
  (
    v_cwpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    FOR i IN (SELECT a.factory_code,
                     a.company_id,
                     SUM(decode(nvl(c.standard_worktime, 0),
                                0,
                                0,
                                trunc(nvl(a.subapp_capc, 0) /
                                      c.standard_worktime))) subapp_capc
                FROM scmdata.t_cateweekplan_sup_detail a
               INNER JOIN scmdata.t_catecapacity_week_plan b
                  ON a.cwp_id = b.cwp_id
                 AND a.company_id = b.company_id
                LEFT JOIN scmdata.t_standard_work_minte_cfg c
                  ON b.category = c.category
                 AND b.product_cate = c.product_cate
                 AND b.subcategory = c.subcategory
                 AND b.company_id = c.company_id
               WHERE a.cwp_id = v_cwpid
                 AND a.company_id = v_compid
               GROUP BY a.factory_code,
                        a.company_id) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_cateweekplan_supwks_detail
       WHERE cwp_id = v_cwpid
         AND factory_code = i.factory_code
         AND company_id = i.company_id
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_cateweekplan_supwks_detail
          (csd_id, company_id, cwp_id, factory_code, app_capacity)
        VALUES
          (scmdata.f_get_uuid(), i.company_id, v_cwpid, i.factory_code, i.subapp_capc);
      ELSE
        UPDATE scmdata.t_cateweekplan_supwks_detail
           SET app_capacity = i.subapp_capc
         WHERE cwp_id = v_cwpid
           AND factory_code = i.factory_code
           AND company_id = i.company_id;
      END IF;
    END LOOP;
  END p_iu_cwpswsd_data;

  /*==============================================================================
  
    供应商周产能规划-品类下单规划（件数）周汇总计算逻辑
  
    入参：
      V_SWPID    :  供应商周产能规划表Id
      V_COMPID   :  企业Id
  
    版本:
      2022-07-29 : 供应商周产能规划-品类下单规划（件数）周汇总计算逻辑
  
  ==============================================================================*/
  PROCEDURE p_iu_supcapcwkpl_cwsd_data
  (
    v_swpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    FOR i IN (SELECT category,
                     product_cate,
                     subcategory,
                     company_id,
                     MAX(supplier_code) supplier_code,
                     SUM(nvl(app_capacity, 0)) app_capacity,
                     SUM(nvl(alo_capacity, 0)) alo_capacity,
                     SUM(nvl(pln_capacity, 0)) pln_capacity,
                     SUM(nvl(pls_capacity, 0)) pls_capacity,
                     SUM(nvl(capc_diffwopln, 0)) capc_diffwopln,
                     SUM(nvl(capc_diffwipln, 0)) capc_diffwipln,
                     SUM(nvl(capc_diffwipls, 0)) capc_diffwipls,
                     COUNT(DISTINCT(CASE
                                      WHEN capc_diffwipls < 0 THEN
                                       trunc(DAY)
                                    END)) warning_days
                FROM scmdata.t_supcapcweekplan_cate_detail
               WHERE swp_id = v_swpid
                 AND company_id = v_compid
               GROUP BY category,
                        product_cate,
                        subcategory,
                        company_id) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supcapcweekplan_catewks_detail
       WHERE swp_id = v_swpid
         AND category = i.category
         AND product_cate = i.product_cate
         AND subcategory = i.subcategory
         AND company_id = i.company_id;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_supcapcweekplan_catewks_detail
          (scd_id, company_id, swp_id, category, product_cate, subcategory, supplier_code, app_capc, alo_capc, pln_capc, pls_capc, capcdiff_wialo, capcdiff_wipln, capcdiff_wipls, warning_days)
        VALUES
          (scmdata.f_get_uuid(), i.company_id, v_swpid, i.category, i.product_cate, i.subcategory, i.supplier_code, i.app_capacity, i.alo_capacity, i.pln_capacity, i.pls_capacity, i.capc_diffwopln, i.capc_diffwipln, i.capc_diffwipls, i.warning_days);
      ELSE
        UPDATE scmdata.t_supcapcweekplan_catewks_detail
           SET app_capc       = i.app_capacity,
               alo_capc       = i.alo_capacity,
               pln_capc       = i.pln_capacity,
               pls_capc       = i.pls_capacity,
               capcdiff_wialo = i.capc_diffwopln,
               capcdiff_wipln = i.capc_diffwipln,
               capcdiff_wipls = i.capc_diffwipls,
               warning_days   = i.warning_days
         WHERE swp_id = v_swpid
           AND category = i.category
           AND product_cate = i.product_cate
           AND subcategory = i.subcategory
           AND company_id = i.company_id;
      END IF;
    END LOOP;
  END p_iu_supcapcwkpl_cwsd_data;

  /*===================================================================================
  
    【品类周产能规划-供应商产能明细】数据生成
  
     用途:
       用于生成【品类周产能规划-供应商产能明细】数据
  
     入参:
       V_SUPCODE  :  供应商编码
       V_CATE     :  分类Id
       V_PROCATE  :  生产分类Id
       V_SUBCATE  :  子类Id
       V_OPERID   :  操作人Id
       V_OPERTIME :  操作时间，字符串，格式：YYYY-MM-DD HH24-MI-SS
       V_COMPID   :  企业Id
  
     版本:
       2022-03-12 :  【品类周产能规划-供应商产能明细】数据生成
  
  ===================================================================================*/
  PROCEDURE p_gen_cateweekplan_sup_detail_data
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    v_cwpid         VARCHAR2(32);
    v_cwpids        CLOB;
    v_jugnum        NUMBER(1);
    v_scspfcdayrate NUMBER(5, 4);
    v_notwkdayids   CLOB;
    v_tmpsupcode    VARCHAR2(32);
    v_tmpfaccode    VARCHAR2(32);
    /*V_CELIBASNUM         NUMBER(1);*/
    v_tmpyear NUMBER(4);
    v_tmpweek NUMBER(2);
  BEGIN
    FOR i IN (SELECT a.supplier_code,
                     a.company_id,
                     a.factory_code,
                     a.year,
                     a.week,
                     a.category,
                     b.day,
                     b.work_hour,
                     b.work_people,
                     b.appcapacity_rate,
                     b.prod_effient
                FROM scmdata.t_supplier_capacity_detail a
               INNER JOIN scmdata.t_capacity_appointment_detail b
                  ON a.ptc_id = b.ptc_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND a.category = v_cate
                 AND trunc(b.day) BETWEEN trunc(SYSDATE, 'IW') AND
                     trunc(SYSDATE, 'IW') + 69
                 AND a.company_id = v_compid
               ORDER BY a.supplier_code,
                        a.company_id,
                        a.factory_code,
                        a.year,
                        a.week,
                        b.day) LOOP
      --产能上限计算基准值赋值
      /*IF NVL(I.APPCAPACITY_RATE,0) = 0 THEN
        V_CELIBASNUM := 0;
      ELSE
        V_CELIBASNUM := 1;
      END IF;*/
    
      IF nvl(v_tmpsupcode, ' ') <> nvl(i.supplier_code, ' ')
         OR nvl(v_tmpfaccode, ' ') <> nvl(i.factory_code, ' ') THEN
        v_tmpsupcode := i.supplier_code;
        v_tmpfaccode := i.factory_code;
      
        v_notwkdayids := scmdata.pkg_capacity_management.f_get_notworkdays(v_supcode => v_tmpfaccode,
                                                                           v_braid   => v_cate,
                                                                           v_compid  => v_compid);
      
        FOR x IN (SELECT dd_date
                    FROM scmdata.t_day_dim
                   WHERE instr(v_notwkdayids, dd_id) > 0) LOOP
          UPDATE scmdata.t_cateweekplan_sup_detail
             SET subcatedayrate  = 0,
                 subcapc_ceiling = 0,
                 subapp_capc     = 0
           WHERE supplier_code = v_tmpsupcode
             AND factory_code = v_tmpfaccode
             AND DAY = x.dd_date
             AND company_id = v_compid;
        END LOOP;
      END IF;
    
      --如果 V_JUGNUM = 0 对 SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL 新增，否则修改
      FOR n IN (SELECT DISTINCT tcsc.supplier_code,
                                tcfc.factory_code,
                                tcsc.coop_category,
                                tcsc.coop_productcate,
                                tcsc.coop_subcategory,
                                tcsc.company_id
                  FROM scmdata.t_coopcate_supplier_cfg tcsc
                 INNER JOIN scmdata.t_coopcate_factory_cfg tcfc
                    ON tcsc.csc_id = tcfc.csc_id
                   AND tcsc.company_id = tcfc.company_id
                 WHERE tcsc.supplier_code = i.supplier_code
                   AND tcsc.coop_category = i.category
                   AND tcsc.coop_productcate = v_procate
                   AND tcsc.coop_subcategory = v_subcate
                   AND tcfc.factory_code = i.factory_code
                   AND tcfc.factory_code IS NOT NULL
                   AND tcsc.company_id = i.company_id) LOOP
        --重复计算排除逻辑
        IF nvl(v_tmpyear, 0) <> i.year
           OR nvl(v_tmpweek, 0) <> i.week THEN
          --判断是否存在于 SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL
          SELECT MAX(cwp_id)
            INTO v_cwpid
            FROM scmdata.t_catecapacity_week_plan
           WHERE supplier_code = i.supplier_code
             AND category = i.category
             AND product_cate = n.coop_productcate
             AND subcategory = n.coop_subcategory
             AND YEAR = i.year
             AND week = i.week
             AND company_id = v_compid;
        
          --如果 V_CWPID 为空，说明主表（SCMDATA.T_CATECAPACITY_WEEK_PLAN）没数据，新增
          IF v_cwpid IS NULL THEN
            v_cwpid := scmdata.f_get_uuid();
          
            INSERT INTO scmdata.t_catecapacity_week_plan
              (cwp_id, company_id, YEAR, week, category, product_cate, subcategory, supplier_code, create_id, create_time, eff_status)
            VALUES
              (v_cwpid, v_compid, i.year, i.week, n.coop_category, n.coop_productcate, n.coop_subcategory, n.supplier_code, v_operid, to_date(v_opertime,
                        'YYYY-MM-DD HH24-MI-SS'), 'EF');
          END IF;
        
          v_tmpyear := i.year;
          v_tmpweek := i.week;
          IF v_cwpids IS NULL THEN
            v_cwpids := v_cwpid;
          ELSE
            v_cwpids := v_cwpids || ',' || v_cwpid;
          END IF;
        END IF;
      
        --判断是否存在于 SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_cateweekplan_sup_detail
         WHERE supplier_code = n.supplier_code
           AND factory_code = n.factory_code
           AND category = n.coop_category
           AND product_cate = n.coop_productcate
           AND subcategory = n.coop_subcategory
           AND DAY = i.day
           AND cwp_id = v_cwpid
           AND company_id = n.company_id
           AND rownum = 1;
      
        --获取供应商某生产工厂子类日生产占比
        v_scspfcdayrate := f_get_supdaysubcaterate(v_supcode => n.supplier_code,
                                                   v_faccode => n.factory_code,
                                                   v_compid  => n.company_id,
                                                   v_cate    => n.coop_category,
                                                   v_procate => n.coop_productcate,
                                                   v_subcate => n.coop_subcategory,
                                                   v_day     => i.day);
      
        IF v_jugnum = 0 THEN
          --不存在新增
          INSERT INTO scmdata.t_cateweekplan_sup_detail
            (csd_id, company_id, cwp_id, category, product_cate, subcategory, supplier_code, factory_code, YEAR, week, DAY, work_hour, work_people, appcapc_rate, prod_eff, capacity_ceiling, app_capacity, subcatedayrate, subcapc_ceiling, subapp_capc)
          VALUES
            (scmdata.f_get_uuid(), v_compid, v_cwpid, n.coop_category, n.coop_productcate, n.coop_subcategory, n.supplier_code, n.factory_code, i.year, i.week, i.day, i.work_hour, i.work_people, i.appcapacity_rate, i.prod_effient, trunc(i.work_hour * 60 *
                    i.work_people *
                    i.prod_effient / 100 /** V_CELIBASNUM*/), trunc(i.work_hour * 60 *
                    i.work_people *
                    i.prod_effient / 100 *
                    i.appcapacity_rate / 100), v_scspfcdayrate, trunc(i.work_hour * 60 *
                    i.work_people *
                    i.prod_effient / 100 /** V_CELIBASNUM*/
                    * v_scspfcdayrate), trunc(i.work_hour * 60 *
                    i.work_people * i.prod_effient / 100 *
                    i.appcapacity_rate / 100 *
                    v_scspfcdayrate));
        ELSE
          --存在更新
          UPDATE scmdata.t_cateweekplan_sup_detail
             SET work_hour        = i.work_hour,
                 work_people      = i.work_people,
                 appcapc_rate     = i.appcapacity_rate,
                 prod_eff         = i.prod_effient,
                 capacity_ceiling = trunc(i.work_hour * 60 * i.work_people *
                                          i.prod_effient / 100 /** V_CELIBASNUM*/),
                 app_capacity     = trunc(i.work_hour * 60 * i.work_people *
                                          i.prod_effient / 100 *
                                          i.appcapacity_rate / 100),
                 subcatedayrate   = v_scspfcdayrate,
                 subcapc_ceiling  = trunc(i.work_hour * 60 * i.work_people *
                                          i.prod_effient / 100 /** V_CELIBASNUM*/
                                          * v_scspfcdayrate),
                 subapp_capc      = trunc(i.work_hour * 60 * i.work_people *
                                          i.prod_effient / 100 *
                                          i.appcapacity_rate / 100 *
                                          v_scspfcdayrate)
           WHERE supplier_code = n.supplier_code
             AND factory_code = n.factory_code
             AND category = n.coop_category
             AND product_cate = n.coop_productcate
             AND subcategory = n.coop_subcategory
             AND DAY = i.day
             AND cwp_id = v_cwpid
             AND company_id = n.company_id;
        END IF;
      END LOOP;
    END LOOP;
  
    FOR tmp IN (SELECT regexp_substr(v_cwpids, '[^,]+', 1, LEVEL) col
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(v_cwpids, '\,') + 1) LOOP
      p_iu_cwpswsd_data(v_cwpid => tmp.col, v_compid => v_compid);
    END LOOP;
  END p_gen_cateweekplan_sup_detail_data;
  /*PROCEDURE P_GEN_CATEWEEKPLAN_SUP_DETAIL_DATA(V_SUPCODE   IN VARCHAR2,
                                               V_CATE      IN VARCHAR2,
                                               V_PROCATE   IN VARCHAR2,
                                               V_SUBCATE   IN VARCHAR2,
                                               V_OPERID    IN VARCHAR2,
                                               V_OPERTIME  IN VARCHAR2,
                                               V_COMPID    IN VARCHAR2) IS
    V_CWPID              VARCHAR2(32);
    V_JUGNUM             NUMBER(1);
    V_SCSPFCDAYRATE      NUMBER(5,4);
    V_NOTWKDAYIDS        CLOB;
    V_TMPSUPCODE         VARCHAR2(32);
    V_TMPFACCODE         VARCHAR2(32);
    V_CELIBASNUM         NUMBER(1);
  BEGIN
    FOR I IN (SELECT A.SUPPLIER_CODE,
                     A.COMPANY_ID,
                     A.FACTORY_CODE,
                     A.YEAR,
                     A.WEEK,
                     A.CATEGORY,
                     B.DAY,
                     B.WORK_HOUR,
                     B.WORK_PEOPLE,
                     B.APPCAPACITY_RATE,
                     B.PROD_EFFIENT
                FROM SCMDATA.T_SUPPLIER_CAPACITY_DETAIL A
               INNER JOIN SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL B
                  ON A.PTC_ID        = B.PTC_ID
                 AND A.COMPANY_ID    = B.COMPANY_ID
               WHERE A.SUPPLIER_CODE = V_SUPCODE
                 AND A.CATEGORY      = V_CATE
                 AND TRUNC(B.DAY) BETWEEN TRUNC(SYSDATE,'IW') AND TRUNC(SYSDATE,'IW') + 69
                 AND A.COMPANY_ID    = V_COMPID
               ORDER BY A.SUPPLIER_CODE,
                        A.COMPANY_ID,
                        A.FACTORY_CODE,
                        A.YEAR,
                        A.WEEK,
                        B.DAY) LOOP
      --产能上限计算基准值赋值
      IF NVL(I.APPCAPACITY_RATE,0) = 0 THEN
        V_CELIBASNUM := 0;
      ELSE
        V_CELIBASNUM := 1;
      END IF;
  
      IF NVL(V_TMPSUPCODE,' ') <> NVL(I.SUPPLIER_CODE,' ') OR
         NVL(V_TMPFACCODE, ' ') <> NVL(I.FACTORY_CODE, ' ') THEN
         V_TMPSUPCODE := I.SUPPLIER_CODE;
         V_TMPFACCODE := I.FACTORY_CODE;
  
         V_NOTWKDAYIDS := SCMDATA.PKG_CAPACITY_MANAGEMENT.F_GET_NOTWORKDAYS(V_SUPCODE => V_TMPFACCODE,
                                                                            V_BRAID   => V_CATE,
                                                                            V_COMPID  => V_COMPID);
  
         FOR X IN (SELECT DD_DATE
                     FROM SCMDATA.T_DAY_DIM
                    WHERE INSTR(V_NOTWKDAYIDS,DD_ID)>0) LOOP
           UPDATE SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL
              SET SUBCATEDAYRATE = 0,
                  SUBCAPC_CEILING = 0,
                  SUBAPP_CAPC = 0
            WHERE SUPPLIER_CODE = V_TMPSUPCODE
              AND FACTORY_CODE = V_TMPFACCODE
              AND DAY = X.DD_DATE
              AND COMPANY_ID = V_COMPID;
         END LOOP;
      END IF;
  
      --如果 V_JUGNUM = 0 对 SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL 新增，否则修改
      FOR N IN (SELECT DISTINCT TCSC.SUPPLIER_CODE,
                                TCFC.FACTORY_CODE,
                                TCSC.COOP_CATEGORY,
                                TCSC.COOP_PRODUCTCATE,
                                TCSC.COOP_SUBCATEGORY,
                                TCSC.COMPANY_ID
                  FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG TCSC
                 INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG TCFC
                    ON TCSC.CSC_ID           = TCFC.CSC_ID
                   AND TCSC.COMPANY_ID       = TCFC.COMPANY_ID
                 WHERE TCSC.SUPPLIER_CODE    = I.SUPPLIER_CODE
                   AND TCSC.COOP_CATEGORY    = I.CATEGORY
                   AND TCSC.COOP_PRODUCTCATE = V_PROCATE
                   AND TCSC.COOP_SUBCATEGORY = V_SUBCATE
                   AND TCFC.FACTORY_CODE     = I.FACTORY_CODE
                   AND TCFC.FACTORY_CODE IS NOT NULL
                   AND TCSC.COMPANY_ID       = I.COMPANY_ID) LOOP
        --判断是否存在于 SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL
        SELECT MAX(CWP_ID)
          INTO V_CWPID
          FROM SCMDATA.T_CATECAPACITY_WEEK_PLAN
         WHERE SUPPLIER_CODE = I.SUPPLIER_CODE
           AND CATEGORY      = I.CATEGORY
           AND PRODUCT_CATE  = N.COOP_PRODUCTCATE
           AND SUBCATEGORY   = N.COOP_SUBCATEGORY
           AND YEAR          = I.YEAR
           AND WEEK          = I.WEEK
           AND COMPANY_ID    = V_COMPID;
  
        --如果 V_CWPID 为空，说明主表（SCMDATA.T_CATECAPACITY_WEEK_PLAN）没数据，新增
        IF V_CWPID IS NULL THEN
          V_CWPID := SCMDATA.F_GET_UUID();
  
          INSERT INTO SCMDATA.T_CATECAPACITY_WEEK_PLAN
            (CWP_ID, COMPANY_ID, YEAR, WEEK, CATEGORY, PRODUCT_CATE, SUBCATEGORY,
             SUPPLIER_CODE, CREATE_ID, CREATE_TIME, EFF_STATUS)
          VALUES
            (V_CWPID, V_COMPID, I.YEAR, I.WEEK, N.COOP_CATEGORY,
             N.COOP_PRODUCTCATE, N.COOP_SUBCATEGORY, N.SUPPLIER_CODE, V_OPERID,
             TO_DATE(V_OPERTIME,'YYYY-MM-DD HH24-MI-SS'), 'EF');
        END IF;
  
        --判断是否存在于 SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL
        SELECT COUNT(1)
          INTO V_JUGNUM
          FROM SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL
         WHERE SUPPLIER_CODE = N.SUPPLIER_CODE
           AND FACTORY_CODE  = N.FACTORY_CODE
           AND CATEGORY      = N.COOP_CATEGORY
           AND PRODUCT_CATE  = N.COOP_PRODUCTCATE
           AND SUBCATEGORY   = N.COOP_SUBCATEGORY
           AND DAY           = I.DAY
           AND CWP_ID        = V_CWPID
           AND COMPANY_ID    = N.COMPANY_ID
           AND ROWNUM        = 1;
  
        --获取供应商某生产工厂子类日生产占比
        V_SCSPFCDAYRATE := F_GET_SUPDAYSUBCATERATE(V_SUPCODE   => N.SUPPLIER_CODE,
                                                   V_FACCODE   => N.FACTORY_CODE,
                                                   V_COMPID    => N.COMPANY_ID,
                                                   V_CATE      => N.COOP_CATEGORY,
                                                   V_PROCATE   => N.COOP_PRODUCTCATE,
                                                   V_SUBCATE   => N.COOP_SUBCATEGORY,
                                                   V_DAY       => I.DAY);
  
        IF V_JUGNUM = 0 THEN
          --不存在新增
          INSERT INTO SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL
            (CSD_ID, COMPANY_ID, CWP_ID, CATEGORY, PRODUCT_CATE,
             SUBCATEGORY, SUPPLIER_CODE, FACTORY_CODE, YEAR, WEEK,
             DAY, WORK_HOUR, WORK_PEOPLE, APPCAPC_RATE, PROD_EFF,
             CAPACITY_CEILING, APP_CAPACITY,SUBCATEDAYRATE,
             SUBCAPC_CEILING,SUBAPP_CAPC)
          VALUES
            (SCMDATA.F_GET_UUID(), V_COMPID, V_CWPID, N.COOP_CATEGORY,
             N.COOP_PRODUCTCATE, N.COOP_SUBCATEGORY, N.SUPPLIER_CODE,
             N.FACTORY_CODE, I.YEAR, I.WEEK, I.DAY, I.WORK_HOUR, I.WORK_PEOPLE,
             I.APPCAPACITY_RATE, I.PROD_EFFIENT,
             I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * V_CELIBASNUM,
             I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * I.APPCAPACITY_RATE / 100,
             V_SCSPFCDAYRATE, I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * V_CELIBASNUM * V_SCSPFCDAYRATE,
             I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * I.APPCAPACITY_RATE / 100 * V_SCSPFCDAYRATE);
        ELSE
          --存在更新
          UPDATE SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL
             SET WORK_HOUR        = I.WORK_HOUR,
                 WORK_PEOPLE      = I.WORK_PEOPLE,
                 APPCAPC_RATE     = I.APPCAPACITY_RATE,
                 PROD_EFF         = I.PROD_EFFIENT,
                 CAPACITY_CEILING = I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * V_CELIBASNUM,
                 APP_CAPACITY     = I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * I.APPCAPACITY_RATE / 100,
                 SUBCATEDAYRATE   = V_SCSPFCDAYRATE,
                 SUBCAPC_CEILING  = I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * V_CELIBASNUM * V_SCSPFCDAYRATE,
                 SUBAPP_CAPC      = I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * I.APPCAPACITY_RATE / 100 * V_SCSPFCDAYRATE
           WHERE SUPPLIER_CODE  = N.SUPPLIER_CODE
             AND FACTORY_CODE   = N.FACTORY_CODE
             AND CATEGORY       = N.COOP_CATEGORY
             AND PRODUCT_CATE   = N.COOP_PRODUCTCATE
             AND SUBCATEGORY    = N.COOP_SUBCATEGORY
             AND DAY            = I.DAY
             AND CWP_ID         = V_CWPID
             AND COMPANY_ID     = N.COMPANY_ID;
        END IF;
      END LOOP;
    END LOOP;
  
  END P_GEN_CATEWEEKPLAN_SUP_DETAIL_DATA;*/

  /*===================================================================================
  
    新增【品类周产能规划-品类下单规划明细】基础数据
  
     用途:
       用于新增【品类周产能规划-品类下单规划明细】基础数据
  
     入参:
       V_CWPID    :  品类周产能规划表Id
       V_SUPCODE  :  供应商编码
       V_COMPID   :  企业Id
       V_CATE     :  分类Id
       V_PROCATE  :  生产分类Id
       V_SUBCATE  :  子类Id
       V_DAY      :  日期
  
     版本:
       2022-03-12 :  新增【品类周产能规划-品类下单规划明细】基础数据
  
  ===================================================================================*/
  PROCEDURE p_gennew_cateweekplan_cate_detail
  (
    v_cwpid   IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_day     IN DATE
  ) IS
    v_year   NUMBER(4);
    v_week   NUMBER(2);
    v_jugnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_cateweekplan_cate_detail
     WHERE supplier_code = v_supcode
       AND category = v_cate
       AND product_cate = v_procate
       AND subcategory = v_subcate
       AND DAY = v_day
       AND company_id = v_compid;
  
    IF v_jugnum = 0 THEN
      SELECT trunc(yearweek / 100),
             MOD(yearweek, 100)
        INTO v_year,
             v_week
        FROM scmdata.t_day_dim
       WHERE dd_date = v_day;
    
      INSERT INTO scmdata.t_cateweekplan_cate_detail
        (ccd_id, company_id, cwp_id, category, product_cate, subcategory, supplier_code, YEAR, week, DAY, capc_ceiling, app_capacity, alo_capacity, pln_capacity, pls_capacity, capc_diffwopln, capc_diffwipln, capc_diffwipls)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_cwpid, v_cate, v_procate, v_subcate, v_supcode, v_year, v_week, v_day, 0, 0, 0, 0, 0, 0, 0, 0);
    END IF;
  END p_gennew_cateweekplan_cate_detail;

  /*===================================================================================
  
    品类周产能规划逻辑拆分--品类下单规划明细空数据新增
  
    用途:
      品类周产能规划逻辑拆分--品类下单规划明细空数据新增
  
    入参:
      V_CWPID    :  品类周产能规划主表Id
      V_YEARWEEK :  年周
      V_COMPID   :  企业Id
  
    版本:
      2022-07-28 : 品类周产能规划逻辑拆分--品类下单规划明细空数据新增
  
  ===================================================================================*/
  PROCEDURE p_cwp_catedetail_emptydata_gen
  (
    v_cwpid    IN VARCHAR2,
    v_yearweek IN NUMBER,
    v_compid   IN VARCHAR2
  ) IS
  
  BEGIN
    FOR j IN (SELECT cwp.supplier_code,
                     cwp.category,
                     cwp.product_cate,
                     cwp.subcategory,
                     tdd.dd_date,
                     cwp.company_id
                FROM scmdata.t_catecapacity_week_plan cwp
               INNER JOIN scmdata.t_day_dim tdd
                  ON cwp.year * 100 + cwp.week = tdd.yearweek
               WHERE cwp.cwp_id = v_cwpid
                 AND cwp.company_id = v_compid
                 AND cwp.year * 100 + cwp.week = v_yearweek) LOOP
      p_gennew_cateweekplan_cate_detail(v_cwpid   => v_cwpid,
                                        v_supcode => j.supplier_code,
                                        v_compid  => j.company_id,
                                        v_cate    => j.category,
                                        v_procate => j.product_cate,
                                        v_subcate => j.subcategory,
                                        v_day     => j.dd_date);
    END LOOP;
  END p_cwp_catedetail_emptydata_gen;

  /*===================================================================================
  
    品类周产能规划逻辑拆分--品类下单规划明细预计新品/已下订单/预计补单字段更新
  
    用途:
      品类周产能规划逻辑拆分--品类下单规划明细预计新品/已下订单/预计补单字段更新
  
    入参:
      V_CWPID      :  品类周产能规划主表Id
      V_SUPCODE    :  供应商编码
      V_CATE       :  分类Id
      V_PROCATE    :  生产分类Id
      V_SUBCATE    :  子类Id
      V_WKSTARTDAY :  周开始日期
      V_WKENDDAY   :  周结束日期
      V_COMPID     :  企业Id
  
    版本:
      2022-07-28 : 品类周产能规划逻辑拆分--品类下单规划明细预计新品/已下订单/预计补单字段更新
  
  ===================================================================================*/
  PROCEDURE p_upd_catedetail_plnaloplsfield
  (
    v_cwpid      IN VARCHAR2,
    v_supcode    IN VARCHAR2,
    v_cate       IN VARCHAR2,
    v_procate    IN VARCHAR2,
    v_subcate    IN VARCHAR2,
    v_wkstartday IN DATE,
    v_wkendday   IN DATE,
    v_compid     IN VARCHAR2
  ) IS
  
  BEGIN
    FOR l IN (SELECT pln.supplier_code,
                     pln.category,
                     pln.product_cate,
                     pln.subcategory,
                     ps1.day,
                     pln.company_id,
                     SUM(CASE
                           WHEN pln.waveact_status = 'OP' THEN
                            nvl(ps1.product_amount, 0)
                           ELSE
                            0
                         END) product_amount
                FROM scmdata.t_plan_newproduct pln
               INNER JOIN scmdata.t_production_schedule ps1
                  ON pln.pn_id = ps1.pn_id
                 AND pln.company_id = ps1.company_id
               WHERE pln.supplier_code = v_supcode
                 AND pln.category = v_cate
                 AND pln.product_cate = v_procate
                 AND pln.subcategory = v_subcate
                 AND ps1.day BETWEEN v_wkstartday AND v_wkendday
                 AND pln.company_id = v_compid
               GROUP BY pln.supplier_code,
                        pln.category,
                        pln.product_cate,
                        pln.subcategory,
                        ps1.day,
                        pln.company_id) LOOP
      UPDATE scmdata.t_cateweekplan_cate_detail tmp1
         SET pln_capacity = trunc(l.product_amount)
       WHERE supplier_code = l.supplier_code
         AND category = l.category
         AND product_cate = l.product_cate
         AND subcategory = l.subcategory
         AND trunc(DAY) = trunc(l.day)
         AND cwp_id = v_cwpid
         AND company_id = l.company_id;
    END LOOP;
  
    FOR m IN (SELECT orded.supplier_code,
                     ci.category,
                     ci.product_cate,
                     ci.samll_category,
                     ps2.day,
                     orded.company_id,
                     SUM(nvl(ps2.product_amount, 0)) product_amount
                FROM scmdata.t_ordered orded
               INNER JOIN scmdata.t_orders ords
                  ON orded.order_code = ords.order_id
                 AND orded.company_id = ords.company_id
               INNER JOIN scmdata.t_commodity_info ci
                  ON ords.goo_id = ci.goo_id
                 AND ords.company_id = ci.company_id
               INNER JOIN scmdata.t_production_schedule ps2
                  ON orded.order_code = ps2.order_id
                 AND orded.company_id = ps2.company_id
               WHERE orded.supplier_code = v_supcode
                 AND ci.category = v_cate
                 AND ci.product_cate = v_procate
                 AND ci.samll_category = v_subcate
                 AND ps2.day BETWEEN v_wkstartday AND v_wkendday
                 AND orded.company_id = v_compid
               GROUP BY orded.supplier_code,
                        ci.category,
                        ci.product_cate,
                        ci.samll_category,
                        ps2.day,
                        orded.company_id) LOOP
      UPDATE scmdata.t_cateweekplan_cate_detail
         SET alo_capacity = trunc(m.product_amount)
       WHERE supplier_code = m.supplier_code
         AND category = m.category
         AND product_cate = m.product_cate
         AND subcategory = m.samll_category
         AND trunc(DAY) = trunc(m.day)
         AND cwp_id = v_cwpid
         AND company_id = m.company_id;
    END LOOP;
  
    FOR o IN (SELECT pns.supplier_code,
                     pns.category,
                     pns.product_cate,
                     pns.subcategory,
                     ps3.day,
                     pns.company_id,
                     SUM(CASE
                           WHEN pns.act_status = 'NO' THEN
                            nvl(ps3.product_amount, 0)
                           ELSE
                            0
                         END) product_amount
                FROM scmdata.t_plannew_supplementary pns
                LEFT JOIN scmdata.t_production_schedule ps3
                  ON pns.ps_id = ps3.pns_id
                 AND pns.company_id = ps3.company_id
               WHERE pns.supplier_code = v_supcode
                 AND pns.category = v_cate
                 AND pns.product_cate = v_procate
                 AND pns.subcategory = v_subcate
                 AND ps3.day BETWEEN v_wkstartday AND v_wkendday
                 AND pns.company_id = v_compid
               GROUP BY pns.supplier_code,
                        pns.category,
                        pns.product_cate,
                        pns.subcategory,
                        ps3.day,
                        pns.company_id) LOOP
      UPDATE scmdata.t_cateweekplan_cate_detail
         SET pls_capacity = trunc(o.product_amount)
       WHERE supplier_code = o.supplier_code
         AND category = o.category
         AND product_cate = o.product_cate
         AND subcategory = o.subcategory
         AND trunc(DAY) = trunc(o.day)
         AND cwp_id = v_cwpid
         AND company_id = o.company_id;
    END LOOP;
  END p_upd_catedetail_plnaloplsfield;

  /*===================================================================================
  
    品类周产能规划逻辑拆分--品类下单规划明细计算
  
    用途:
      品类周产能规划逻辑拆分--品类下单规划明细计算
  
    入参:
      V_CWPID      :  品类周产能规划主表Id
      V_COMPID     :  企业Id
  
    版本:
      2022-07-28 : 品类周产能规划逻辑拆分--品类下单规划明细计算
  
  ===================================================================================*/
  PROCEDURE p_catedetail_calculate
  (
    v_cwpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_subcapcceiling NUMBER(16, 2);
    v_subappcapcamt  NUMBER(16, 2);
  BEGIN
    FOR n IN (SELECT ccd_id,
                     cwp_id,
                     company_id,
                     DAY,
                     trunc(alo_capacity) alo_capacity,
                     trunc(pln_capacity) pln_capacity,
                     trunc(pls_capacity) pls_capacity
                FROM scmdata.t_cateweekplan_cate_detail
               WHERE cwp_id = v_cwpid
                 AND company_id = v_compid) LOOP
      SELECT SUM(csd.subcapc_ceiling),
             SUM(decode(nvl(swmc.standard_worktime, 0),
                        0,
                        0,
                        trunc(nvl(csd.subapp_capc, 0) /
                              swmc.standard_worktime)))
        INTO v_subcapcceiling,
             v_subappcapcamt
        FROM scmdata.t_cateweekplan_sup_detail csd
       INNER JOIN scmdata.t_standard_work_minte_cfg swmc
          ON csd.category = swmc.category
         AND csd.product_cate = swmc.product_cate
         AND csd.subcategory = swmc.subcategory
         AND csd.company_id = swmc.company_id
       WHERE csd.cwp_id = n.cwp_id
         AND csd.day = n.day
         AND csd.company_id = n.company_id;
    
      v_subcapcceiling := nvl(v_subcapcceiling, 0);
      v_subappcapcamt  := nvl(v_subappcapcamt, 0);
    
      UPDATE scmdata.t_cateweekplan_cate_detail
         SET capc_ceiling   = v_subcapcceiling,
             app_capacity   = v_subappcapcamt,
             capc_diffwopln = v_subappcapcamt - nvl(n.alo_capacity, 0),
             capc_diffwipln = v_subappcapcamt - nvl(n.alo_capacity, 0) -
                              nvl(n.pln_capacity, 0),
             capc_diffwipls = v_subappcapcamt - nvl(n.alo_capacity, 0) -
                              nvl(n.pln_capacity, 0) -
                              nvl(n.pls_capacity, 0)
       WHERE ccd_id = n.ccd_id
         AND cwp_id = n.cwp_id
         AND company_id = n.company_id;
    END LOOP;
  END p_catedetail_calculate;

  /*===================================================================================
  
    品类周产能规划逻辑拆分--品类周产能规划计算
  
    用途:
      品类周产能规划逻辑拆分--品类周产能规划计算
  
    入参:
      V_CWPID      :  品类周产能规划主表Id
      V_COMPID     :  企业Id
  
    版本:
      2022-07-28 : 品类周产能规划逻辑拆分--品类周产能规划计算
  
  ===================================================================================*/
  PROCEDURE p_cwp_calculate
  (
    v_cwpid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_subcapcceiling NUMBER(16, 4);
    v_subappcapcamt  NUMBER(16, 4);
    v_alocapc        NUMBER(16, 4);
    v_plncapc        NUMBER(16, 4);
    v_plscapc        NUMBER(16, 4);
    v_warningdays    NUMBER(4);
  BEGIN
    SELECT SUM(subcapc_ceiling)
      INTO v_subcapcceiling
      FROM scmdata.t_cateweekplan_sup_detail
     WHERE cwp_id = v_cwpid
       AND company_id = v_compid;
  
    SELECT SUM(app_capacity),
           SUM(alo_capacity),
           SUM(pln_capacity),
           SUM(pls_capacity),
           COUNT(DISTINCT(CASE
                            WHEN capc_diffwipls < 0 THEN
                             trunc(DAY)
                          END))
      INTO v_subappcapcamt,
           v_alocapc,
           v_plncapc,
           v_plscapc,
           v_warningdays
      FROM scmdata.t_cateweekplan_cate_detail
     WHERE cwp_id = v_cwpid
       AND company_id = v_compid;
  
    v_subcapcceiling := trunc(nvl(v_subcapcceiling, 0));
    v_subappcapcamt  := trunc(nvl(v_subappcapcamt, 0));
    v_alocapc        := trunc(nvl(v_alocapc, 0));
    v_plncapc        := trunc(nvl(v_plncapc, 0));
    v_plscapc        := trunc(nvl(v_plscapc, 0));
    v_warningdays    := trunc(nvl(v_warningdays, 0));
  
    UPDATE scmdata.t_catecapacity_week_plan
       SET celling_capc    = v_subcapcceiling,
           appoint_capc    = v_subappcapcamt,
           alord_capc      = v_alocapc,
           plannew_capc    = v_plncapc,
           plansupp_capc   = v_plscapc,
           capc_diff_wonew = v_subappcapcamt - v_alocapc,
           capc_diff_winew = v_subappcapcamt - v_alocapc - v_plncapc,
           capc_diff_wipls = v_subappcapcamt - v_alocapc - v_plncapc -
                             v_plscapc,
           warning_days    = v_warningdays
     WHERE cwp_id = v_cwpid
       AND company_id = v_compid;
  END p_cwp_calculate;

  /*===================================================================================
  
    【品类周产能规划-品类下单规划明细】数据生成
  
     用途:
       用于生成【品类周产能规划-品类下单规划明细】数据
  
     入参:
       V_SUPCODE  :  供应商编码
       V_CATE     :  分类Id
       V_PROCATE  :  生产分类Id
       V_SUBCATE  :  子类Id
       V_COMPID   :  企业Id
  
     版本:
       2022-03-12 : 【品类周产能规划-品类下单规划明细】数据生成
       2022-07-29 : 逻辑拆分封装
  
  ===================================================================================*/
  PROCEDURE p_gen_cateweekplan_cate_detail_data
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  BEGIN
    --更新对应 CPS-SUP-DAY 的 已下单件数 和 预计新品件数
    FOR x IN (SELECT tcwp.cwp_id,
                     tcwp.company_id,
                     tdd.yearweek,
                     MIN(tdd.dd_date) weekstart,
                     MAX(tdd.dd_date) weekend
                FROM scmdata.t_day_dim tdd
               INNER JOIN scmdata.t_catecapacity_week_plan tcwp
                  ON tdd.yearweek = tcwp.year * 100 + tcwp.week
                 AND tcwp.supplier_code = v_supcode
                 AND tcwp.company_id = v_compid
               WHERE tdd.dd_date BETWEEN trunc(SYSDATE, 'IW') AND
                     trunc(SYSDATE, 'IW') + 69
                 AND tcwp.supplier_code = v_supcode
                 AND tcwp.category = v_cate
                 AND tcwp.product_cate = v_procate
                 AND tcwp.subcategory = v_subcate
                 AND tcwp.company_id = v_compid
               GROUP BY tcwp.cwp_id,
                        tcwp.company_id,
                        tdd.yearweek) LOOP
      --品类下单规划明细空数据新增
      p_cwp_catedetail_emptydata_gen(v_cwpid    => x.cwp_id,
                                     v_yearweek => x.yearweek,
                                     v_compid   => x.company_id);
    
      --品类下单规划明细预计新品/已下订单/预计补单字段更新
      p_upd_catedetail_plnaloplsfield(v_cwpid      => x.cwp_id,
                                      v_supcode    => v_supcode,
                                      v_cate       => v_cate,
                                      v_procate    => v_procate,
                                      v_subcate    => v_subcate,
                                      v_wkstartday => x.weekstart,
                                      v_wkendday   => x.weekend,
                                      v_compid     => x.company_id);
    
      --品类下单规划明细计算
      p_catedetail_calculate(v_cwpid => x.cwp_id, v_compid => x.company_id);
    
      --品类周产能规划计算
      p_cwp_calculate(v_cwpid => x.cwp_id, v_compid => x.company_id);
    END LOOP;
  END p_gen_cateweekplan_cate_detail_data;
  /*PROCEDURE P_GEN_CATEWEEKPLAN_CATE_DETAIL_DATA(V_SUPCODE IN VARCHAR2,
                                                V_CATE    IN VARCHAR2,
                                                V_PROCATE IN VARCHAR2,
                                                V_SUBCATE IN VARCHAR2,
                                                V_COMPID  IN VARCHAR2) IS
    V_SUBCAPCCEILING NUMBER(16,4);
    V_SUBAPPCAPCAMT  NUMBER(16,4);
    V_WARNINGDAYS    NUMBER(4);
    V_ALOCAPC        NUMBER(16,4);
    V_PLNCAPC        NUMBER(16,4);
  BEGIN
    --更新对应 CPS-SUP-DAY 的 已下单件数 和 预计新品件数
    FOR X IN (SELECT TCWP.CWP_ID,
                     TCWP.COMPANY_ID,
                     TDD.YEARWEEK,
                     MIN(TDD.DD_DATE) WEEKSTART,
                     MAX(TDD.DD_DATE) WEEKEND
                FROM SCMDATA.T_DAY_DIM TDD
               INNER JOIN SCMDATA.T_CATECAPACITY_WEEK_PLAN TCWP
                  ON TDD.YEARWEEK = TCWP.YEAR * 100 + TCWP.WEEK
                 AND TCWP.SUPPLIER_CODE = V_SUPCODE
                 AND TCWP.COMPANY_ID = V_COMPID
               WHERE TDD.DD_DATE BETWEEN TRUNC(SYSDATE, 'IW') AND
                     TRUNC(SYSDATE, 'IW') + 69
                 AND TCWP.SUPPLIER_CODE = V_SUPCODE
                 AND TCWP.CATEGORY = V_CATE
                 AND TCWP.PRODUCT_CATE = V_PROCATE
                 AND TCWP.SUBCATEGORY = V_SUBCATE
                 AND TCWP.COMPANY_ID = V_COMPID
               GROUP BY TCWP.CWP_ID,TCWP.COMPANY_ID,TDD.YEARWEEK) LOOP
      FOR J IN (SELECT CWP1.SUPPLIER_CODE, CWP1.CATEGORY, CWP1.PRODUCT_CATE,
                       CWP1.SUBCATEGORY, TDD1.DD_DATE, CWP1.COMPANY_ID
                  FROM SCMDATA.T_CATECAPACITY_WEEK_PLAN CWP1
                 INNER JOIN SCMDATA.T_DAY_DIM TDD1
                    ON CWP1.YEAR*100+CWP1.WEEK = TDD1.YEARWEEK
                 WHERE CWP1.CWP_ID = X.CWP_ID
                   AND CWP1.COMPANY_ID = X.COMPANY_ID
                   AND CWP1.YEAR*100+CWP1.WEEK = X.YEARWEEK) LOOP
        P_GENNEW_CATEWEEKPLAN_CATE_DETAIL(V_CWPID   => X.CWP_ID,
                                          V_SUPCODE => J.SUPPLIER_CODE,
                                          V_COMPID  => J.COMPANY_ID,
                                          V_CATE    => J.CATEGORY,
                                          V_PROCATE => J.PRODUCT_CATE,
                                          V_SUBCATE => J.SUBCATEGORY,
                                          V_DAY     => J.DD_DATE);
      END LOOP;
  
      FOR L IN (SELECT TMP1A.SUPPLIER_CODE,
                       TMP1A.CATEGORY,
                       TMP1A.PRODUCT_CATE,
                       TMP1A.SUBCATEGORY,
                       TMP1B.DAY,
                       TMP1A.COMPANY_ID,
                       SUM(CASE WHEN TMP1A.WAVEACT_STATUS = 'OP' THEN NVL(TMP1B.PRODUCT_AMOUNT,0) ELSE 0 END) PRODUCT_AMOUNT
                  FROM SCMDATA.T_PLAN_NEWPRODUCT TMP1A
                 INNER JOIN SCMDATA.T_PRODUCTION_SCHEDULE TMP1B
                    ON TMP1A.PN_ID = TMP1B.PN_ID
                   AND TMP1A.COMPANY_ID = TMP1B.COMPANY_ID
                 WHERE TMP1A.SUPPLIER_CODE = V_SUPCODE
                   AND TMP1B.DAY BETWEEN X.WEEKSTART AND X.WEEKEND
                   AND TMP1A.COMPANY_ID = V_COMPID
                 GROUP BY TMP1A.SUPPLIER_CODE, TMP1A.CATEGORY, TMP1A.PRODUCT_CATE, TMP1A.SUBCATEGORY, TMP1B.DAY, TMP1A.COMPANY_ID) LOOP
        UPDATE SCMDATA.T_CATEWEEKPLAN_CATE_DETAIL TMP1
           SET PLN_CAPACITY = NVL(L.PRODUCT_AMOUNT,0)
         WHERE SUPPLIER_CODE = L.SUPPLIER_CODE
           AND CATEGORY = L.CATEGORY
           AND PRODUCT_CATE = L.PRODUCT_CATE
           AND SUBCATEGORY = L.SUBCATEGORY
           AND TRUNC(DAY) = TRUNC(L.DAY)
           AND CWP_ID = X.CWP_ID
           AND COMPANY_ID = L.COMPANY_ID;
      END LOOP;
  
      FOR M IN (SELECT TMP2A.SUPPLIER_CODE,
                       TMP2C.CATEGORY,
                       TMP2C.PRODUCT_CATE,
                       TMP2C.SAMLL_CATEGORY,
                       TMP2D.DAY,
                       TMP2A.COMPANY_ID,
                       SUM(TMP2D.PRODUCT_AMOUNT) PRODUCT_AMOUNT
                  FROM SCMDATA.T_ORDERED TMP2A
                 INNER JOIN SCMDATA.T_ORDERS TMP2B
                    ON TMP2A.ORDER_CODE = TMP2B.ORDER_ID
                   AND TMP2A.COMPANY_ID = TMP2B.COMPANY_ID
                 INNER JOIN SCMDATA.T_COMMODITY_INFO TMP2C
                    ON TMP2B.GOO_ID = TMP2C.GOO_ID
                   AND TMP2B.COMPANY_ID = TMP2C.COMPANY_ID
                 INNER JOIN SCMDATA.T_PRODUCTION_SCHEDULE TMP2D
                    ON TMP2A.ORDER_CODE = TMP2D.ORDER_ID
                   AND TMP2A.COMPANY_ID = TMP2D.COMPANY_ID
                 WHERE TMP2A.SUPPLIER_CODE = V_SUPCODE
                   AND TMP2D.DAY BETWEEN X.WEEKSTART AND X.WEEKEND
                   AND TMP2A.COMPANY_ID = V_COMPID
                 GROUP BY TMP2A.SUPPLIER_CODE, TMP2C.CATEGORY, TMP2C.PRODUCT_CATE, TMP2C.SAMLL_CATEGORY, TMP2D.DAY,TMP2A.COMPANY_ID) LOOP
        UPDATE SCMDATA.T_CATEWEEKPLAN_CATE_DETAIL TMP
           SET ALO_CAPACITY = NVL(M.PRODUCT_AMOUNT,0)
         WHERE SUPPLIER_CODE = M.SUPPLIER_CODE
           AND CATEGORY = M.CATEGORY
           AND PRODUCT_CATE = M.PRODUCT_CATE
           AND SUBCATEGORY = M.SAMLL_CATEGORY
           AND TRUNC(DAY) = TRUNC(M.DAY)
           AND CWP_ID = X.CWP_ID
           AND COMPANY_ID = M.COMPANY_ID;
      END LOOP;
  
      FOR N IN (SELECT *
                  FROM SCMDATA.T_CATEWEEKPLAN_CATE_DETAIL
                 WHERE CWP_ID = X.CWP_ID
                   AND COMPANY_ID = X.COMPANY_ID) LOOP
        SELECT SUM(CSD.SUBCAPC_CEILING),
               SUM(CSD.SUBAPP_CAPC/SWMC.STANDARD_WORKTIME)
          INTO V_SUBCAPCCEILING, V_SUBAPPCAPCAMT
          FROM SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL CSD
         INNER JOIN SCMDATA.T_STANDARD_WORK_MINTE_CFG SWMC
            ON CSD.CATEGORY = SWMC.CATEGORY
           AND CSD.PRODUCT_CATE = SWMC.PRODUCT_CATE
           AND CSD.SUBCATEGORY = SWMC.SUBCATEGORY
           AND CSD.COMPANY_ID = SWMC.COMPANY_ID
         WHERE CSD.CWP_ID = X.CWP_ID
           AND CSD.DAY = N.DAY
           AND CSD.COMPANY_ID = V_COMPID;
  
        V_SUBCAPCCEILING := NVL(TRUNC(V_SUBCAPCCEILING),0);
        V_SUBAPPCAPCAMT  := NVL(TRUNC(V_SUBAPPCAPCAMT),0);
  
        UPDATE SCMDATA.T_CATEWEEKPLAN_CATE_DETAIL
           SET CAPC_CEILING = V_SUBCAPCCEILING,
               APP_CAPACITY = V_SUBAPPCAPCAMT,
               CAPC_DIFFWOPLN = V_SUBAPPCAPCAMT - NVL(N.ALO_CAPACITY,0),
               CAPC_DIFFWIPLN = V_SUBAPPCAPCAMT - NVL(N.ALO_CAPACITY,0) - NVL(N.PLN_CAPACITY,0)
         WHERE CCD_ID = N.CCD_ID
           AND CWP_ID = X.CWP_ID
           AND COMPANY_ID = N.COMPANY_ID;
      END LOOP;
  
  
      SELECT SUM(CSD.SUBCAPC_CEILING),
             SUM(CSD.SUBAPP_CAPC/SWMC.STANDARD_WORKTIME)
        INTO V_SUBCAPCCEILING, V_SUBAPPCAPCAMT
        FROM SCMDATA.T_CATEWEEKPLAN_SUP_DETAIL CSD
       INNER JOIN SCMDATA.T_STANDARD_WORK_MINTE_CFG SWMC
          ON CSD.CATEGORY = SWMC.CATEGORY
         AND CSD.PRODUCT_CATE = SWMC.PRODUCT_CATE
         AND CSD.SUBCATEGORY = SWMC.SUBCATEGORY
         AND CSD.COMPANY_ID = SWMC.COMPANY_ID
       WHERE CSD.CWP_ID = X.CWP_ID
         AND CSD.COMPANY_ID = V_COMPID;
  
      SELECT SUM(ALO_CAPACITY),
             SUM(PLN_CAPACITY),
             COUNT(DISTINCT (CASE WHEN CAPC_DIFFWIPLN < 0 THEN TRUNC(DAY) END))
        INTO V_ALOCAPC, V_PLNCAPC, V_WARNINGDAYS
        FROM SCMDATA.T_CATEWEEKPLAN_CATE_DETAIL
       WHERE CWP_ID = X.CWP_ID
         AND COMPANY_ID = V_COMPID;
  
      V_SUBCAPCCEILING := NVL(TRUNC(V_SUBCAPCCEILING),0);
      V_SUBAPPCAPCAMT  := NVL(TRUNC(V_SUBAPPCAPCAMT),0);
      V_ALOCAPC        := NVL(TRUNC(V_ALOCAPC),0);
      V_PLNCAPC        := NVL(TRUNC(V_PLNCAPC),0);
      V_WARNINGDAYS    := NVL(TRUNC(V_WARNINGDAYS),0);
  
      UPDATE SCMDATA.T_CATECAPACITY_WEEK_PLAN
         SET CELLING_CAPC    = V_SUBCAPCCEILING,
             APPOINT_CAPC    = V_SUBAPPCAPCAMT,
             ALORD_CAPC      = V_ALOCAPC,
             PLANNEW_CAPC    = V_PLNCAPC,
             CAPC_DIFF_WONEW = V_SUBAPPCAPCAMT - V_ALOCAPC,
             CAPC_DIFF_WINEW = V_SUBAPPCAPCAMT - V_ALOCAPC - V_PLNCAPC,
             WARNING_DAYS    = V_WARNINGDAYS
       WHERE CWP_ID = X.CWP_ID
         AND COMPANY_ID = V_COMPID;
    END LOOP;
  END P_GEN_CATEWEEKPLAN_CATE_DETAIL_DATA;*/

  /*===================================================================================
  
    生成品类周产能规划数据
  
   用途:
     生成供应商周产能规划-供应商产能明细数据
  
   入参:
     V_SUPCODE  :  供应商编码
     V_CATE     :  分类Id
     V_PROCATE  :  生产分类Id
     V_SUBCATE  :  子类Id
     V_OPERID   :  操作人Id
     V_OPERTIME :  操作时间
     V_COMPID   :  企业Id
  
   版本:
     2022-03-08 : 生成供应商周产能规划-供应商产能明细数据
  
  ===================================================================================*/
  PROCEDURE p_iu_catewkpln_data
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
  
  BEGIN
    p_gen_cateweekplan_sup_detail_data(v_supcode  => v_supcode,
                                       v_cate     => v_cate,
                                       v_procate  => v_procate,
                                       v_subcate  => v_subcate,
                                       v_operid   => v_operid,
                                       v_opertime => v_opertime,
                                       v_compid   => v_compid);
  
    p_gen_cateweekplan_cate_detail_data(v_supcode => v_supcode,
                                        v_cate    => v_cate,
                                        v_procate => v_procate,
                                        v_subcate => v_subcate,
                                        v_compid  => v_compid);
  END p_iu_catewkpln_data;

  /*===================================================================================
  
   生成供应商周产能规划数据
  
   用途:
     生成供应商周产能规划数据，需先生成品类周产能规划数据
  
   入参:
     V_SUPCODE  :  供应商编码
     V_CATE     :  分类Id
     V_PROCATE  :  生产分类Id
     V_SUBCATE  :  子类Id
     V_OPERID   :  操作人Id
     V_OPERTIME :  操作时间
     V_COMPID   :  企业Id
  
   版本:
     2022-01-24 : 生成供应商周产能规划数据
  
  ===================================================================================*/
  PROCEDURE p_iu_supwkpln_data
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    v_swpid            VARCHAR2(32);
    v_swpids           CLOB;
    v_jugnum           NUMBER(1);
    v_year             NUMBER(4);
    v_week             NUMBER(2);
    v_sumcapcceiling   NUMBER(16, 2);
    v_sumappcapc       NUMBER(16, 2);
    v_sumalocapc       NUMBER(16, 2);
    v_sumplncapc       NUMBER(16, 2);
    v_sumplscapc       NUMBER(16, 2);
    v_sumcapcdiffwopln NUMBER(16, 2);
    v_sumcapcdiffwipln NUMBER(16, 2);
    v_sumcapcdiffwipls NUMBER(16, 2);
    v_warningdays      NUMBER(2);
    /*V_CELIBASNUM         NUMBER(1);*/
  BEGIN
    FOR i IN (SELECT a.supplier_code,
                     a.company_id,
                     a.factory_code,
                     a.year,
                     a.week,
                     a.category,
                     b.day,
                     b.work_hour,
                     b.work_people,
                     b.appcapacity_rate,
                     b.prod_effient
                FROM scmdata.t_supplier_capacity_detail a
               INNER JOIN scmdata.t_capacity_appointment_detail b
                  ON a.ptc_id = b.ptc_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND a.category = v_cate
                 AND trunc(b.day) >= trunc(SYSDATE, 'IW')
                 AND a.factory_code IS NOT NULL
                 AND a.company_id = v_compid
               ORDER BY a.supplier_code,
                        a.company_id,
                        a.factory_code,
                        a.year,
                        a.week,
                        b.day) LOOP
      --产能上限计算基准值赋值
      /*IF NVL(I.APPCAPACITY_RATE,0) = 0 THEN
        V_CELIBASNUM := 0;
      ELSE
        V_CELIBASNUM := 1;
      END IF;*/
    
      IF nvl(v_year, 0) <> i.year
         OR nvl(v_week, 0) <> i.week THEN
        v_year := i.year;
        v_week := i.week;
      
        --判断是否存在 SWP_ID
        SELECT MAX(swp_id)
          INTO v_swpid
          FROM scmdata.t_supcapacity_week_plan
         WHERE YEAR = v_year
           AND week = v_week
           AND supplier_code = i.supplier_code
           AND company_id = i.company_id;
      
        --当 V_SWPID 为空时
        IF v_swpid IS NULL THEN
          v_swpid := scmdata.f_get_uuid();
        
          INSERT INTO scmdata.t_supcapacity_week_plan
            (swp_id, company_id, YEAR, week, category, supplier_code, create_id, create_time, eff_status)
          VALUES
            (v_swpid, v_compid, v_year, v_week, i.category, i.supplier_code, v_operid, to_date(v_opertime,
                      'YYYY-MM-DD HH24-MI-SS'), 'EF');
        END IF;
      
        IF v_swpids IS NULL THEN
          v_swpids := v_swpid;
        ELSE
          v_swpids := v_swpids || ',' || v_swpid;
        END IF;
      END IF;
    
      --判断是否存在
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supcapcweekplan_sup_detail
       WHERE supplier_code = i.supplier_code
         AND factory_code = i.factory_code
         AND category = i.category
         AND YEAR = i.year
         AND week = i.week
         AND DAY = i.day
         AND swp_id = v_swpid
         AND company_id = i.company_id
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        --新增到供应商周产能计划-供应商产能明细（工时）
        INSERT INTO scmdata.t_supcapcweekplan_sup_detail
          (ssd_id, company_id, swp_id, category, supplier_code, factory_code, YEAR, week, DAY, work_hour, work_people, appcapc_rate, prod_eff, capacity_ceiling, app_capacity)
        VALUES
          (scmdata.f_get_uuid(), i.company_id, v_swpid, i.category, i.supplier_code, i.factory_code, i.year, i.week, i.day, i.work_hour, i.work_people, i.appcapacity_rate, i.prod_effient, trunc(i.work_hour * 60 *
                  i.work_people *
                  i.prod_effient / 100 /** V_CELIBASNUM*/), trunc(i.work_hour * 60 *
                  i.work_people *
                  i.prod_effient / 100 *
                  i.appcapacity_rate / 100));
      ELSE
        UPDATE scmdata.t_supcapcweekplan_sup_detail
           SET work_hour        = i.work_hour,
               work_people      = i.work_people,
               appcapc_rate     = i.appcapacity_rate,
               prod_eff         = i.prod_effient,
               capacity_ceiling = trunc(i.work_hour * 60 * i.work_people *
                                        i.prod_effient / 100 /** V_CELIBASNUM*/),
               app_capacity     = trunc(i.work_hour * 60 * i.work_people *
                                        i.prod_effient / 100 *
                                        i.appcapacity_rate / 100)
         WHERE supplier_code = i.supplier_code
           AND factory_code = i.factory_code
           AND category = i.category
           AND YEAR = i.year
           AND week = i.week
           AND DAY = i.day
           AND swp_id = v_swpid
           AND company_id = i.company_id;
      END IF;
    END LOOP;
  
    FOR x IN (SELECT tswp.supplier_code,
                     tswp.company_id,
                     tswp.year,
                     tswp.week,
                     tswp.swp_id,
                     tswp.category,
                     tccd.product_cate,
                     tccd.subcategory,
                     tccd.day,
                     nvl(tccd.capc_ceiling, 0) capc_ceiling,
                     nvl(tccd.app_capacity, 0) app_capacity,
                     nvl(tccd.alo_capacity, 0) alo_capacity,
                     nvl(tccd.pln_capacity, 0) pln_capacity,
                     nvl(tccd.pls_capacity, 0) pls_capacity,
                     nvl(tccd.capc_diffwopln, 0) capc_diffwopln,
                     nvl(tccd.capc_diffwipln, 0) capc_diffwipln,
                     nvl(tccd.capc_diffwipls, 0) capc_diffwipls
                FROM scmdata.t_supcapacity_week_plan tswp
               INNER JOIN scmdata.t_day_dim tdd
                  ON tswp.year * 100 + tswp.week = tdd.yearweek
               INNER JOIN scmdata.t_cateweekplan_cate_detail tccd
                  ON tswp.supplier_code = tccd.supplier_code
                 AND tswp.category = tccd.category
                 AND tswp.year = tccd.year
                 AND tswp.week = tccd.week
                 AND tdd.dd_date = tccd.day
                 AND tswp.company_id = tccd.company_id
               WHERE tswp.supplier_code = v_supcode
                 AND tswp.category = v_cate
                 AND tccd.product_cate = v_procate
                 AND tccd.subcategory = v_subcate
                 AND tswp.company_id = v_compid) LOOP
      --供应商周产能_品类下单规划明细是否存在校验
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supcapcweekplan_cate_detail
       WHERE category = x.category
         AND product_cate = x.product_cate
         AND subcategory = x.subcategory
         AND supplier_code = x.supplier_code
         AND YEAR = x.year
         AND week = x.week
         AND DAY = x.day
         AND swp_id = x.swp_id
         AND company_id = x.company_id
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        --供应商周产能_品类下单规划明细（件数）新增
        INSERT INTO scmdata.t_supcapcweekplan_cate_detail
          (scd_id, company_id, swp_id, category, product_cate, subcategory, supplier_code, YEAR, week, DAY, capc_ceiling, app_capacity, alo_capacity, pln_capacity, pls_capacity, capc_diffwopln, capc_diffwipln, capc_diffwipls)
        VALUES
          (scmdata.f_get_uuid(), x.company_id, x.swp_id, x.category, x.product_cate, x.subcategory, x.supplier_code, x.year, x.week, x.day, x.capc_ceiling, x.app_capacity, x.alo_capacity, x.pln_capacity, x.pls_capacity, x.capc_diffwopln, x.capc_diffwipln, x.capc_diffwipls);
      ELSE
        UPDATE scmdata.t_supcapcweekplan_cate_detail
           SET capc_ceiling   = x.capc_ceiling,
               app_capacity   = x.app_capacity,
               alo_capacity   = x.alo_capacity,
               pln_capacity   = x.pln_capacity,
               pls_capacity   = x.pls_capacity,
               capc_diffwopln = x.capc_diffwopln,
               capc_diffwipln = x.capc_diffwipln,
               capc_diffwipls = x.capc_diffwipls
         WHERE category = x.category
           AND product_cate = x.product_cate
           AND subcategory = x.subcategory
           AND supplier_code = x.supplier_code
           AND YEAR = x.year
           AND week = x.week
           AND DAY = x.day
           AND swp_id = x.swp_id
           AND company_id = x.company_id;
      END IF;
    END LOOP;
  
    --获取汇总数据
    FOR y IN (SELECT swp_id,
                     company_id
                FROM scmdata.t_supcapacity_week_plan
               WHERE supplier_code = v_supcode
                 AND company_id = v_compid) LOOP
      SELECT SUM(trunc(capacity_ceiling)),
             SUM(trunc(app_capacity))
        INTO v_sumcapcceiling,
             v_sumappcapc
        FROM scmdata.t_supcapcweekplan_sup_detail
       WHERE swp_id = y.swp_id
         AND company_id = y.company_id;
    
      SELECT SUM(trunc(tscd.alo_capacity * tswmc.standard_worktime)),
             SUM(trunc(tscd.pln_capacity * tswmc.standard_worktime)),
             SUM(trunc(tscd.pls_capacity * tswmc.standard_worktime)),
             SUM(trunc(tscd.capc_diffwopln * tswmc.standard_worktime)),
             SUM(trunc(tscd.capc_diffwipln * tswmc.standard_worktime)),
             SUM(trunc(tscd.capc_diffwipls * tswmc.standard_worktime))
        INTO v_sumalocapc,
             v_sumplncapc,
             v_sumplscapc,
             v_sumcapcdiffwopln,
             v_sumcapcdiffwipln,
             v_sumcapcdiffwipls
        FROM scmdata.t_supcapcweekplan_cate_detail tscd
       INNER JOIN scmdata.t_standard_work_minte_cfg tswmc
          ON tscd.category = tswmc.category
         AND tscd.product_cate = tswmc.product_cate
         AND tscd.subcategory = tswmc.subcategory
         AND tscd.company_id = tswmc.company_id
       WHERE tscd.swp_id = y.swp_id
         AND tscd.company_id = y.company_id;
    
      SELECT COUNT(DISTINCT DAY)
        INTO v_warningdays
        FROM scmdata.t_supcapcweekplan_cate_detail
       WHERE swp_id = y.swp_id
         AND capc_diffwipls < 0
         AND company_id = y.company_id;
    
      --汇总数据到供应商周产能规划表
      UPDATE scmdata.t_supcapacity_week_plan
         SET celling_capc    = nvl(v_sumcapcceiling, 0),
             appoint_capc    = nvl(v_sumappcapc, 0),
             alord_capc      = nvl(v_sumalocapc, 0),
             plannew_capc    = nvl(v_sumplncapc, 0),
             plansupp_capc   = nvl(v_sumplscapc, 0),
             capc_diff_wonew = nvl(v_sumcapcdiffwopln, 0),
             capc_diff_winew = nvl(v_sumcapcdiffwipln, 0),
             capc_diff_wipls = nvl(v_sumcapcdiffwipls, 0),
             warning_days    = nvl(v_warningdays, 0),
             update_id       = v_operid,
             update_time     = to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS')
       WHERE swp_id = y.swp_id
         AND company_id = y.company_id;
    END LOOP;
  
    FOR tmp IN (SELECT regexp_substr(v_swpids, '[^,]+', 1, LEVEL) col
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(v_swpids, '\,') + 1) LOOP
      p_iu_swpswsd_data(v_swpid => tmp.col, v_compid => v_compid);
    
      p_iu_supcapcwkpl_cwsd_data(v_swpid => tmp.col, v_compid => v_compid);
    END LOOP;
  END p_iu_supwkpln_data;
  /*PROCEDURE P_IU_SUPWKPLN_DATA(V_SUPCODE  IN VARCHAR2,
                               V_CATE     IN VARCHAR2,
                               V_PROCATE  IN VARCHAR2,
                               V_SUBCATE  IN VARCHAR2,
                               V_OPERID   IN VARCHAR2,
                               V_OPERTIME IN VARCHAR2,
                               V_COMPID   IN VARCHAR2) IS
    V_SWPID              VARCHAR2(32);
    V_JUGNUM             NUMBER(1);
    V_YEAR               NUMBER(4);
    V_WEEK               NUMBER(2);
    V_SUMCAPCCEILING     NUMBER(16, 2);
    V_SUMAPPCAPC         NUMBER(16, 2);
    V_SUMALOCAPC         NUMBER(16, 2);
    V_SUMPLNCAPC         NUMBER(16, 2);
    V_SUMCAPCDIFFWOPLN   NUMBER(16, 2);
    V_SUMCAPCDIFFWIPLN   NUMBER(16, 2);
    V_WARNINGDAYS        NUMBER(2);
    V_CELIBASNUM         NUMBER(1);
  BEGIN
    FOR I IN (SELECT A.SUPPLIER_CODE,
                     A.COMPANY_ID,
                     A.FACTORY_CODE,
                     A.YEAR,
                     A.WEEK,
                     A.CATEGORY,
                     B.DAY,
                     B.WORK_HOUR,
                     B.WORK_PEOPLE,
                     B.APPCAPACITY_RATE,
                     B.PROD_EFFIENT
                FROM SCMDATA.T_SUPPLIER_CAPACITY_DETAIL A
               INNER JOIN SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL B
                  ON A.PTC_ID        = B.PTC_ID
                 AND A.COMPANY_ID    = B.COMPANY_ID
               WHERE A.SUPPLIER_CODE = V_SUPCODE
                 AND A.CATEGORY      = V_CATE
                 AND TRUNC(B.DAY)    >= TRUNC(SYSDATE,'IW')
                 AND A.FACTORY_CODE IS NOT NULL
                 AND A.COMPANY_ID    = V_COMPID
               ORDER BY A.SUPPLIER_CODE,
                        A.COMPANY_ID,
                        A.FACTORY_CODE,
                        A.YEAR,
                        A.WEEK,
                        B.DAY) LOOP
     --产能上限计算基准值赋值
      IF NVL(I.APPCAPACITY_RATE,0) = 0 THEN
        V_CELIBASNUM := 0;
      ELSE
        V_CELIBASNUM := 1;
      END IF;
  
     IF NVL(V_YEAR, 0) <> I.YEAR OR NVL(V_WEEK, 0) <> I.WEEK THEN
       V_YEAR := I.YEAR;
       V_WEEK := I.WEEK;
     END IF;
  
     --判断是否存在 SWP_ID
     SELECT MAX(SWP_ID)
       INTO V_SWPID
       FROM SCMDATA.T_SUPCAPACITY_WEEK_PLAN
      WHERE YEAR = V_YEAR
        AND WEEK = V_WEEK
        AND SUPPLIER_CODE = I.SUPPLIER_CODE
        AND COMPANY_ID    = I.COMPANY_ID;
  
     --当 V_SWPID 为空时
     IF V_SWPID IS NULL THEN
       V_SWPID := SCMDATA.F_GET_UUID();
  
       INSERT INTO SCMDATA.T_SUPCAPACITY_WEEK_PLAN
         (SWP_ID, COMPANY_ID, YEAR, WEEK, CATEGORY, SUPPLIER_CODE,
          CREATE_ID, CREATE_TIME, EFF_STATUS)
       VALUES
         (V_SWPID, V_COMPID, V_YEAR, V_WEEK, I.CATEGORY,
          I.SUPPLIER_CODE, V_OPERID, TO_DATE(V_OPERTIME,'YYYY-MM-DD HH24-MI-SS'), 'EF');
     END IF;
  
     --判断是否存在
     SELECT COUNT(1)
       INTO V_JUGNUM
       FROM SCMDATA.T_SUPCAPCWEEKPLAN_SUP_DETAIL
      WHERE SUPPLIER_CODE  = I.SUPPLIER_CODE
        AND FACTORY_CODE   = I.FACTORY_CODE
        AND CATEGORY       = I.CATEGORY
        AND YEAR           = I.YEAR
        AND WEEK           = I.WEEK
        AND DAY            = I.DAY
        AND SWP_ID         = V_SWPID
        AND COMPANY_ID     = I.COMPANY_ID
        AND ROWNUM = 1;
  
     IF V_JUGNUM = 0 THEN
       --新增到供应商周产能计划-供应商产能明细（工时）
       INSERT INTO SCMDATA.T_SUPCAPCWEEKPLAN_SUP_DETAIL
         (SSD_ID, COMPANY_ID, SWP_ID, CATEGORY, SUPPLIER_CODE, FACTORY_CODE,
          YEAR, WEEK, DAY, WORK_HOUR, WORK_PEOPLE, APPCAPC_RATE, PROD_EFF,
          CAPACITY_CEILING, APP_CAPACITY)
       VALUES
         (SCMDATA.F_GET_UUID(), I.COMPANY_ID, V_SWPID, I.CATEGORY, I.SUPPLIER_CODE,
          I.FACTORY_CODE, I.YEAR, I.WEEK, I.DAY, I.WORK_HOUR, I.WORK_PEOPLE,
          I.APPCAPACITY_RATE, I.PROD_EFFIENT,
          I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * V_CELIBASNUM,
          I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * I.APPCAPACITY_RATE / 100);
     ELSE
       UPDATE SCMDATA.T_SUPCAPCWEEKPLAN_SUP_DETAIL
          SET WORK_HOUR        = I.WORK_HOUR,
              WORK_PEOPLE      = I.WORK_PEOPLE,
              APPCAPC_RATE     = I.APPCAPACITY_RATE,
              PROD_EFF         = I.PROD_EFFIENT,
              CAPACITY_CEILING = I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * V_CELIBASNUM,
              APP_CAPACITY     = I.WORK_HOUR * 60 * I.WORK_PEOPLE * I.PROD_EFFIENT / 100 * I.APPCAPACITY_RATE / 100
        WHERE SUPPLIER_CODE  = I.SUPPLIER_CODE
          AND FACTORY_CODE   = I.FACTORY_CODE
          AND CATEGORY       = I.CATEGORY
          AND YEAR           = I.YEAR
          AND WEEK           = I.WEEK
          AND DAY            = I.DAY
          AND SWP_ID         = V_SWPID
          AND COMPANY_ID     = I.COMPANY_ID;
     END IF;
   END LOOP;
  
   --供应商周产能_品类下单规划明细（件数）新增/修改
   FOR X IN (SELECT TSWP.SUPPLIER_CODE, TSWP.COMPANY_ID, TSWP.YEAR, TSWP.WEEK,
                    TSWP.CATEGORY, TCCD.PRODUCT_CATE, TCCD.SUBCATEGORY,
                    TCCD.DAY, TCCD.CAPC_CEILING, TCCD.APP_CAPACITY,
                    TCCD.ALO_CAPACITY, TCCD.PLN_CAPACITY, TCCD.CAPC_DIFFWOPLN,
                    TCCD.CAPC_DIFFWIPLN, TSWP.SWP_ID
               FROM SCMDATA.T_SUPCAPACITY_WEEK_PLAN TSWP
              INNER JOIN SCMDATA.T_DAY_DIM TDD
                 ON TSWP.YEAR * 100 + TSWP.WEEK = TDD.YEARWEEK
              INNER JOIN SCMDATA.T_CATEWEEKPLAN_CATE_DETAIL TCCD
                 ON TSWP.SUPPLIER_CODE = TCCD.SUPPLIER_CODE
                AND TSWP.CATEGORY      = TCCD.CATEGORY
                AND TSWP.YEAR          = TCCD.YEAR
                AND TSWP.WEEK          = TCCD.WEEK
                AND TDD.DD_DATE        = TCCD.DAY
                AND TSWP.COMPANY_ID    = TCCD.COMPANY_ID
              WHERE TSWP.SUPPLIER_CODE = V_SUPCODE
                AND TSWP.CATEGORY      = V_CATE
                AND TCCD.PRODUCT_CATE  = V_PROCATE
                AND TCCD.SUBCATEGORY   = V_SUBCATE
                AND TSWP.COMPANY_ID    = V_COMPID) LOOP
      --供应商周产能_品类下单规划明细是否存在校验
      SELECT COUNT(1)
        INTO V_JUGNUM
        FROM SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL
       WHERE CATEGORY     = X.CATEGORY
         AND PRODUCT_CATE = X.PRODUCT_CATE
         AND SUBCATEGORY  = X.SUBCATEGORY
         AND SUPPLIER_CODE = X.SUPPLIER_CODE
         AND YEAR          = X.YEAR
         AND WEEK          = X.WEEK
         AND DAY           = X.DAY
         AND SWP_ID        = X.SWP_ID
         AND COMPANY_ID    = X.COMPANY_ID
         AND ROWNUM        = 1;
  
      IF V_JUGNUM = 0 THEN
        --供应商周产能_品类下单规划明细（件数）新增
        INSERT INTO SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL
          (SCD_ID,COMPANY_ID,SWP_ID,CATEGORY,PRODUCT_CATE,SUBCATEGORY,SUPPLIER_CODE,
           YEAR,WEEK,DAY,CAPC_CEILING,APP_CAPACITY,ALO_CAPACITY,PLN_CAPACITY,
           CAPC_DIFFWOPLN,CAPC_DIFFWIPLN)
        VALUES
          (SCMDATA.F_GET_UUID(), X.COMPANY_ID, X.SWP_ID, X.CATEGORY, X.PRODUCT_CATE,
           X.SUBCATEGORY, X.SUPPLIER_CODE, X.YEAR, X.WEEK, X.DAY, X.CAPC_CEILING, X.APP_CAPACITY,
           X.ALO_CAPACITY, X.PLN_CAPACITY, X.CAPC_DIFFWOPLN, X.CAPC_DIFFWIPLN);
      ELSE
        UPDATE SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL
           SET CAPC_CEILING   = X.CAPC_CEILING,
               APP_CAPACITY   = X.APP_CAPACITY,
               ALO_CAPACITY   = X.ALO_CAPACITY,
               PLN_CAPACITY   = X.PLN_CAPACITY,
               CAPC_DIFFWOPLN = X.CAPC_DIFFWOPLN,
               CAPC_DIFFWIPLN = X.CAPC_DIFFWIPLN
         WHERE CATEGORY      = X.CATEGORY
           AND PRODUCT_CATE  = X.PRODUCT_CATE
           AND SUBCATEGORY   = X.SUBCATEGORY
           AND SUPPLIER_CODE = X.SUPPLIER_CODE
           AND YEAR          = X.YEAR
           AND WEEK          = X.WEEK
           AND DAY           = X.DAY
           AND SWP_ID        = X.SWP_ID
           AND COMPANY_ID    = X.COMPANY_ID;
      END IF;
    END LOOP;
  
    --获取汇总数据
    FOR Y IN (SELECT SWP_ID,COMPANY_ID
                FROM SCMDATA.T_SUPCAPACITY_WEEK_PLAN
               WHERE SUPPLIER_CODE = V_SUPCODE
                 AND COMPANY_ID = V_COMPID) LOOP
      SELECT SUM(CAPACITY_CEILING), SUM(APP_CAPACITY)
        INTO V_SUMCAPCCEILING, V_SUMAPPCAPC
        FROM SCMDATA.T_SUPCAPCWEEKPLAN_SUP_DETAIL
       WHERE SWP_ID     = Y.SWP_ID
         AND COMPANY_ID = Y.COMPANY_ID;
  
      SELECT SUM(TSCD.ALO_CAPACITY * TSWMC.STANDARD_WORKTIME),
             SUM(TSCD.PLN_CAPACITY * TSWMC.STANDARD_WORKTIME),
             SUM(CAPC_DIFFWOPLN * TSWMC.STANDARD_WORKTIME),
             SUM(CAPC_DIFFWIPLN * TSWMC.STANDARD_WORKTIME)
        INTO V_SUMALOCAPC, V_SUMPLNCAPC, V_SUMCAPCDIFFWOPLN, V_SUMCAPCDIFFWIPLN
       FROM SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL TSCD
      INNER JOIN SCMDATA.T_STANDARD_WORK_MINTE_CFG TSWMC
         ON TSCD.CATEGORY     = TSWMC.CATEGORY
        AND TSCD.PRODUCT_CATE = TSWMC.PRODUCT_CATE
        AND TSCD.SUBCATEGORY  = TSWMC.SUBCATEGORY
        AND TSCD.COMPANY_ID   = TSWMC.COMPANY_ID
      WHERE TSCD.SWP_ID     = Y.SWP_ID
        AND TSCD.COMPANY_ID = Y.COMPANY_ID;
  
     SELECT COUNT(DISTINCT DAY)
       INTO V_WARNINGDAYS
       FROM SCMDATA.T_SUPCAPCWEEKPLAN_CATE_DETAIL
      WHERE SWP_ID     = Y.SWP_ID
        AND CAPC_DIFFWIPLN < 0
        AND COMPANY_ID = Y.COMPANY_ID;
  
     --汇总数据到供应商周产能规划表
     UPDATE SCMDATA.T_SUPCAPACITY_WEEK_PLAN
        SET CELLING_CAPC     = NVL(V_SUMCAPCCEILING,0),
            APPOINT_CAPC     = NVL(V_SUMAPPCAPC,0),
            ALORD_CAPC       = NVL(V_SUMALOCAPC,0),
            PLANNEW_CAPC     = NVL(V_SUMPLNCAPC,0),
            CAPC_DIFF_WONEW  = NVL(V_SUMCAPCDIFFWOPLN,0),
            CAPC_DIFF_WINEW  = NVL(V_SUMCAPCDIFFWIPLN,0),
            WARNING_DAYS     = NVL(V_WARNINGDAYS,0),
            UPDATE_ID        = V_OPERID,
            UPDATE_TIME      = TO_DATE(V_OPERTIME,'YYYY-MM-DD HH24-MI-SS')
      WHERE SWP_ID     = Y.SWP_ID
        AND COMPANY_ID = Y.COMPANY_ID;
    END LOOP;
  END P_IU_SUPWKPLN_DATA;*/

  /*===================================================================================
  
    增加最近生效队列创建时间
  
     入参:
       V_SUPCODE  :  供应商编码
       V_CATE     :  分类Id
       V_OPERTIME :  操作时间，字符串，格式：YYYY-MM-DD HH24-MI-SS
       V_COMPID   :  企业Id
  
     版本:
       2022-09-22 : 新需求，增加最近生效队列创建时间
  
  ===================================================================================*/
  PROCEDURE p_upd_wkpln_lastefftime
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
  
  BEGIN
    UPDATE scmdata.t_supcapacity_week_plan
       SET lasteff_time = to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS')
     WHERE supplier_code = v_supcode
       AND category = v_cate
       AND company_id = v_compid;
  
    UPDATE scmdata.t_catecapacity_week_plan
       SET lasteff_time = to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS')
     WHERE supplier_code = v_supcode
       AND category = v_cate
       AND company_id = v_compid;
  END p_upd_wkpln_lastefftime;

  /*===================================================================================
  
   生成周产能规划数据
  
   用途:
     生成周产能规划数据
  
   入参:
     V_SUPCODE  :  供应商编码
     V_CATE     :  分类Id
     V_PROCATE  :  生产分类Id
     V_SUBCATE  :  子类Id
     V_OPERID   :  操作人Id
     V_OPERTIME :  操作时间
     V_COMPID   :  企业Id
  
   版本:
     2022-01-24 : 生成周产能规划数据
  
  ===================================================================================*/
  PROCEDURE p_iu_weekplan_data
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
  
  BEGIN
    FOR i IN (SELECT DISTINCT a.supplier_code,
                              a.company_id,
                              a.coop_category,
                              a.coop_productcate,
                              a.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a
               WHERE a.supplier_code = v_supcode
                 AND a.coop_category = v_cate
                 AND a.company_id = v_compid) LOOP
      p_iu_catewkpln_data(v_supcode  => i.supplier_code,
                          v_cate     => i.coop_category,
                          v_procate  => i.coop_productcate,
                          v_subcate  => i.coop_subcategory,
                          v_operid   => v_operid,
                          v_opertime => v_opertime,
                          v_compid   => i.company_id);
    
      p_iu_supwkpln_data(v_supcode  => i.supplier_code,
                         v_cate     => i.coop_category,
                         v_procate  => i.coop_productcate,
                         v_subcate  => i.coop_subcategory,
                         v_operid   => v_operid,
                         v_opertime => v_opertime,
                         v_compid   => i.company_id);
    END LOOP;
  
    p_upd_wkpln_lastefftime(v_supcode  => v_supcode,
                            v_cate     => v_cate,
                            v_opertime => v_opertime,
                            v_compid   => v_compid);
  END p_iu_weekplan_data;

  /*===================================================================================
  
    队列派生-生成周产能规划重算队列
  
    入参:
      V_SUPCODE  :  供应商编码
      V_CATE     :  分类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-08-25 : 队列派生-生成周产能规划重算队列
  
  ===================================================================================*/
  PROCEDURE p_gen_wkplanrecalcrela
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    v_queueid VARCHAR2(32);
    v_jugnum  NUMBER(1);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_capc_wkplanrecalcqueue tab
     WHERE status = 'PR'
       AND supplier_code = v_supcode
       AND category = v_cate
       AND company_id = v_compid
       AND NOT EXISTS (SELECT 1
              FROM scmdata.t_queue_executor
             WHERE queue_id = tab.queue_id
               AND company_id = tab.company_id)
       AND EXISTS (SELECT 1
              FROM scmdata.t_queue
             WHERE queue_id = tab.queue_id
               AND company_id = tab.company_id)
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      v_queueid := scmdata.f_get_uuid();
    
      INSERT INTO scmdata.t_queue
        (queue_id, company_id, queue_status, queue_type, create_id, create_time)
      VALUES
        (v_queueid, v_compid, 'PR', 'SCM_CAPCWKPLAN_RECALC', v_operid, to_date(v_opertime,
                  'YYYY-MM-DD HH24-MI-SS'));
    
      INSERT INTO scmdata.t_capc_wkplanrecalcqueue
        (cwpn_id, company_id, status, queue_id, supplier_code, category, create_id, create_time)
      VALUES
        (scmdata.f_get_uuid(), v_compid, 'PR', v_queueid, v_supcode, v_cate, v_operid, to_date(v_opertime,
                  'YYYY-MM-DD HH24-MI-SS'));
    
      scmdata.pkg_capacity_iflrow.p_common_queueifldata_generator(v_tab     => 'SCM_CAPC_WEEKPLAN_RELA',
                                                                  v_supcode => v_supcode,
                                                                  v_cate    => v_cate,
                                                                  v_queueid => v_queueid,
                                                                  v_compid  => v_compid);
    END IF;
  END p_gen_wkplanrecalcrela;

  /*===================================================================================
  
    队列派生-周产能规划重算
  
    入参:
      V_QUEUEID  :  队列Id
      V_COMPID   :  企业Id
  
    版本:
      2022-08-25 : 队列派生-周产能规划重算
  
  ===================================================================================*/
  PROCEDURE p_wkplanrecalc_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_supcode  VARCHAR2(32);
    v_cate     VARCHAR2(2);
    v_operid   VARCHAR2(32);
    v_opertime VARCHAR2(64);
  BEGIN
    SELECT MAX(supplier_code),
           MAX(category),
           MAX(create_id),
           MAX(to_char(create_time, 'YYYY-MM-DD HH24-MI-SS'))
      INTO v_supcode,
           v_cate,
           v_operid,
           v_opertime
      FROM scmdata.t_capc_wkplanrecalcqueue
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_supcode IS NOT NULL
       AND v_cate IS NOT NULL THEN
      p_iu_weekplan_data(v_supcode  => v_supcode,
                         v_cate     => v_cate,
                         v_operid   => v_operid,
                         v_opertime => v_opertime,
                         v_compid   => v_compid);
    END IF;
  
    UPDATE scmdata.t_capc_wkplanrecalcqueue
       SET status = 'SS'
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
  EXCEPTION
    WHEN OTHERS THEN
      UPDATE scmdata.t_capc_wkplanrecalcqueue
         SET status = 'ER'
       WHERE queue_id = v_queueid
         AND company_id = v_compid;
  END p_wkplanrecalc_efflogic;

  /*===================================================================================
  
    将 SCMDATA.T_PRODUCTION_SCHEDULE 及 View 表内不进行产能规划的数据删除
  
    用途:
      配置直接修改导致不能从业务表取到值的补充删除逻辑（用于产能品类规划生效）
  
    入参:
      V_CATE       :  分类
      V_PROCATE    :  生产分类
      V_SUBCATE    :  子类
      V_COMPID     :  企业Id
  
    版本:
      2022-05-05 : 将 SCMDATA.T_PRODUCTION_SCHEDULE 及 View 表内
                   不进行产能规划的数据删除
  
  ===================================================================================*/
  PROCEDURE p_delpsdata_by_cps
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  BEGIN
    --补充重算逻辑
    FOR delit IN (SELECT ps_id,
                         company_id
                    FROM (SELECT a1.ps_id,
                                 a1.company_id,
                                 c1.category       cate,
                                 c1.product_cate   procate,
                                 c1.samll_category subcate,
                                 a1.day
                            FROM scmdata.t_production_schedule a1
                           INNER JOIN scmdata.t_orders b1
                              ON a1.order_id = b1.order_id
                             AND a1.company_id = b1.company_id
                           INNER JOIN scmdata.t_commodity_info c1
                              ON b1.goo_id = c1.goo_id
                             AND b1.company_id = c1.company_id
                          UNION ALL
                          SELECT a2.ps_id,
                                 a2.company_id,
                                 b2.category,
                                 b2.product_cate,
                                 b2.subcategory,
                                 a2.day
                            FROM scmdata.t_production_schedule a2
                           INNER JOIN scmdata.t_plan_newproduct b2
                              ON a2.pn_id = b2.pn_id
                             AND a2.company_id = b2.company_id)
                   WHERE cate = v_cate
                     AND procate = v_procate
                     AND subcate = v_subcate
                     AND DAY >= trunc(SYSDATE, 'IW')
                     AND company_id = v_compid) LOOP
      DELETE FROM scmdata.t_production_schedule_view
       WHERE ps_id = delit.ps_id
         AND company_id = delit.company_id;
    
      DELETE FROM scmdata.t_production_schedule
       WHERE ps_id = delit.ps_id
         AND company_id = delit.company_id;
    END LOOP;
  END p_delpsdata_by_cps;

  /*===================================================================================
  
    生产周期配置预计新品重算（CPS）
  
    用途:
      生产周期配置预计新品重算（CPS）
  
    入参:
      V_CATE      :  分类
      V_PROCATE   :  生产分类
      V_SUBCATE   :  子类
      V_COMPID    :  企业Id
  
    版本:
      2022-05-24 : 生产周期配置预计新品重算（CPS）
  
  ===================================================================================*/
  PROCEDURE p_prodcyccfg_cps_plrecalc
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  
  BEGIN
    FOR i IN (SELECT pn_id,
                     company_id
                FROM scmdata.t_plan_newproduct
               WHERE category = v_cate
                 AND product_cate = v_procate
                 AND subcategory = v_subcate
                 AND company_id = v_compid) LOOP
      p_iu_newprodsche_data_4plnp(v_pnid   => i.pn_id,
                                  v_compid => i.company_id);
    END LOOP;
  
    FOR l IN (SELECT ps_id,
                     company_id
                FROM scmdata.t_plannew_supplementary
               WHERE category = v_cate
                 AND product_cate = v_procate
                 AND subcategory = v_subcate
                 AND company_id = v_compid) LOOP
      p_iu_newprodsche_data_4plns(v_pnsid  => l.ps_id,
                                  v_compid => l.company_id);
    END LOOP;
  END p_prodcyccfg_cps_plrecalc;

  /*===================================================================================
  
    生产周期配置预计新品重算（CPSS）
  
    用途:
      生产周期配置预计新品重算（CPSS）
  
    入参:
      V_CATE      :  分类
      V_PROCATE   :  生产分类
      V_SUBCATE   :  子类
      V_SUPCODES  :  供应商编码（复数）
      V_COMPID    :  企业Id
  
    版本:
      2022-05-24 : 生产周期配置预计新品重算（CPSS）
  
  ===================================================================================*/
  PROCEDURE p_prodcyccfg_cpss_plrecalc
  (
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_supcodes IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
  
  BEGIN
    FOR i IN (SELECT pn_id,
                     company_id
                FROM scmdata.t_plan_newproduct
               WHERE instr(v_supcodes, supplier_code) > 0
                 AND category = v_cate
                 AND product_cate = v_procate
                 AND subcategory = v_subcate
                 AND company_id = v_compid) LOOP
      p_iu_newprodsche_data_4plnp(v_pnid   => i.pn_id,
                                  v_compid => i.company_id);
    END LOOP;
  
    FOR l IN (SELECT ps_id,
                     company_id
                FROM scmdata.t_plannew_supplementary
               WHERE instr(v_supcodes, supplier_code) > 0
                 AND category = v_cate
                 AND product_cate = v_procate
                 AND subcategory = v_subcate
                 AND company_id = v_compid) LOOP
      p_iu_newprodsche_data_4plns(v_pnsid  => l.ps_id,
                                  v_compid => l.company_id);
    END LOOP;
  END p_prodcyccfg_cpss_plrecalc;

  /*========================================================================================
  
    获取档案级别启停
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-07 : 获取档案级别启停，版本变动加入生产类型变更影响配置变更
  
  ========================================================================================*/
  FUNCTION f_get_pause_causebysupfilechange
  (
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER IS
    v_retnum NUMBER(1);
  BEGIN
    SELECT nvl(MAX(CASE
                     WHEN nvl(tsi.production_mode, '00') = '00' THEN
                      sign(decode(tsi.pause, 2, 0, nvl(tsi.pause, 1)) + tcf.pause +
                           tcs1.pause + tcs2.pause)
                     WHEN nvl(tsi.production_mode, '00') = '01' THEN
                      1
                   END),
               1) pause
      INTO v_retnum
      FROM scmdata.t_coopcate_supplier_cfg csc
     INNER JOIN scmdata.t_supplier_info tsi
        ON csc.supplier_code = tsi.supplier_code
       AND csc.company_id = tsi.company_id
     INNER JOIN scmdata.t_coop_scope tcs1
        ON tsi.supplier_info_id = tcs1.supplier_info_id
       AND tsi.company_id = tcs1.company_id
       AND csc.coop_category = tcs1.coop_classification
       AND csc.coop_productcate = tcs1.coop_product_cate
       AND instr(tcs1.coop_subcategory, csc.coop_subcategory) > 0
       AND csc.company_id = tcs1.company_id
     INNER JOIN scmdata.t_coop_factory tcf
        ON tsi.supplier_info_id = tcf.supplier_info_id
       AND tsi.company_id = tcf.company_id
     INNER JOIN scmdata.t_coop_scope tcs2
        ON tcf.fac_sup_info_id = tcs2.supplier_info_id
       AND tcf.company_id = tcs2.company_id
       AND csc.coop_category = tcs2.coop_classification
       AND csc.coop_productcate = tcs2.coop_product_cate
       AND instr(tcs2.coop_subcategory, csc.coop_subcategory) > 0
     WHERE csc.supplier_code = v_supcode
       AND tcf.factory_code = v_faccode
       AND csc.coop_category = v_cate
       AND csc.coop_productcate = v_procate
       AND csc.coop_subcategory = v_subcate
       AND csc.company_id = v_compid;
  
    RETURN v_retnum;
  END f_get_pause_causebysupfilechange;

  /*========================================================================================
  
    获取档案级别关联品类合作供应商配置数据集sql
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-07 : 获取档案级别关联品类合作供应商配置数据集sql，
                   版本变动加入生产类型变更影响配置变更
  
  ========================================================================================*/
  FUNCTION f_get_sfcps_by_conds
  (
    v_supcode IN VARCHAR2 DEFAULT NULL,
    v_faccode IN VARCHAR2 DEFAULT NULL,
    v_cate    IN VARCHAR2 DEFAULT NULL,
    v_procate IN VARCHAR2 DEFAULT NULL,
    v_subcate IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) RETURN CLOB IS
    v_sql  CLOB;
    v_cond VARCHAR2(4000);
  BEGIN
    IF v_supcode IS NOT NULL
       OR v_faccode IS NOT NULL
       OR v_cate IS NOT NULL
       OR v_procate IS NOT NULL
       OR v_subcate IS NOT NULL THEN
      IF v_supcode IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CSC.SUPPLIER_CODE = ''' ||
                                                               v_supcode || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      IF v_faccode IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'TCF.FACTORY_CODE = ''' ||
                                                               v_faccode || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      IF v_cate IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CSC.COOP_CATEGORY = ''' ||
                                                               v_cate || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      IF v_procate IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CSC.COOP_PRODUCTCATE = ''' ||
                                                               v_procate || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      IF v_subcate IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CSC.COOP_SUBCATEGORY = ''' ||
                                                               v_subcate || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'CSC.COMPANY_ID = ''' ||
                                                             v_compid || '''',
                                             v_middliestr => ' AND ');
    
      v_sql := 'SELECT SUPPLIER_CODE, FACTORY_CODE, COOP_CATEGORY, COOP_PRODUCTCATE, COOP_SUBCATEGORY, COMPANY_ID, ' ||
               'NVL(MAX(SIGN(SUPMPAUSE + SUPFPAUSE + FACFPAUSE + COPFPAUSE + SCPSPAUSE + SCPFPAUSE)),1) PAUSE ' ||
               'FROM (SELECT CSC.SUPPLIER_CODE, TCF.FACTORY_CODE, CSC.COOP_CATEGORY, CSC.COOP_PRODUCTCATE, CSC.COOP_SUBCATEGORY, ' ||
               'CASE WHEN TSI1.COOPERATION_MODEL = ''OF'' THEN 1 ELSE 0 END SUPMPAUSE, ' ||
               'DECODE(NVL(TSI1.PRODUCT_TYPE, ''00''), ''00'', 0, 1) SUPFPAUSE, DECODE(NVL(TSI2.PRODUCT_TYPE, ' ||
               '''00''), ''00'', 0, 1) FACFPAUSE, NVL(TCF.PAUSE,1) COPFPAUSE, NVL(TCS1.PAUSE,1) SCPSPAUSE, NVL(TCS2.PAUSE,1) SCPFPAUSE, CSC.COMPANY_ID FROM ' ||
               'SCMDATA.T_COOPCATE_SUPPLIER_CFG CSC LEFT JOIN SCMDATA.T_SUPPLIER_INFO TSI1 ON CSC.SUPPLIER_CODE = TSI1.SUPPLIER_CODE AND ' ||
               'CSC.COMPANY_ID = TSI1.COMPANY_ID LEFT JOIN SCMDATA.T_COOP_SCOPE TCS1 ON TSI1.SUPPLIER_INFO_ID = TCS1.SUPPLIER_INFO_ID AND ' ||
               'TSI1.COMPANY_ID = TCS1.COMPANY_ID AND CSC.COOP_CATEGORY = TCS1.COOP_CLASSIFICATION AND CSC.COOP_PRODUCTCATE = TCS1.COOP_PRODUCT_CATE ' ||
               'AND INSTR(TCS1.COOP_SUBCATEGORY, CSC.COOP_SUBCATEGORY) > 0 AND CSC.COMPANY_ID = TCS1.COMPANY_ID LEFT JOIN SCMDATA.T_COOP_FACTORY TCF ' ||
               'ON TSI1.SUPPLIER_INFO_ID = TCF.SUPPLIER_INFO_ID AND TSI1.COMPANY_ID = TCF.COMPANY_ID AND TCF.FACTORY_CODE IS NOT NULL LEFT JOIN ' ||
               'SCMDATA.T_SUPPLIER_INFO TSI2 ON TCF.FAC_SUP_INFO_ID = TSI2.SUPPLIER_INFO_ID AND TCF.COMPANY_ID = TSI2.COMPANY_ID LEFT JOIN ' ||
               'SCMDATA.T_COOP_SCOPE TCS2 ON TCF.FAC_SUP_INFO_ID = TCS2.SUPPLIER_INFO_ID AND TCF.COMPANY_ID = TCS2.COMPANY_ID AND CSC.COOP_CATEGORY ' ||
               '= TCS2.COOP_CLASSIFICATION AND CSC.COOP_PRODUCTCATE = TCS2.COOP_PRODUCT_CATE AND INSTR(TCS2.COOP_SUBCATEGORY, CSC.COOP_SUBCATEGORY) > 0  WHERE ' ||
               v_cond ||
               ') GROUP BY SUPPLIER_CODE, FACTORY_CODE, COOP_CATEGORY, COOP_PRODUCTCATE, COOP_SUBCATEGORY, COMPANY_ID';
    END IF;
  
    RETURN v_sql;
  END f_get_sfcps_by_conds;

  /*========================================================================================
  
    用于获取品类合作供应商配置处的供应商编码，生产工厂编码，分类Id的sql
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-28 : 用于获取品类合作供应商配置处的供应商编码，生产工厂编码，分类Id的sql
  
  ========================================================================================*/
  FUNCTION f_get_coopsf_sfc_by_conds
  (
    v_supcode IN VARCHAR2 DEFAULT NULL,
    v_faccode IN VARCHAR2 DEFAULT NULL,
    v_cate    IN VARCHAR2 DEFAULT NULL,
    v_procate IN VARCHAR2 DEFAULT NULL,
    v_subcate IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) RETURN CLOB IS
    v_sql  CLOB;
    v_cond VARCHAR2(4000);
  BEGIN
    IF v_supcode IS NOT NULL
       OR v_faccode IS NOT NULL
       OR v_cate IS NOT NULL
       OR v_procate IS NOT NULL
       OR v_subcate IS NOT NULL THEN
      IF v_supcode IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CSC.SUPPLIER_CODE = ''' ||
                                                               v_supcode || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      IF v_faccode IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CFC.FACTORY_CODE = ''' ||
                                                               v_faccode || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      IF v_cate IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CSC.COOP_CATEGORY = ''' ||
                                                               v_cate || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      IF v_procate IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CSC.COOP_PRODUCTCATE = ''' ||
                                                               v_procate || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      IF v_subcate IS NOT NULL THEN
        v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                               v_appendstr  => 'CSC.COOP_SUBCATEGORY = ''' ||
                                                               v_subcate || '''',
                                               v_middliestr => ' AND ');
      END IF;
    
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'CSC.COMPANY_ID = ''' ||
                                                             v_compid || '''',
                                             v_middliestr => ' AND ');
    
      v_sql := 'SELECT DISTINCT CSC.SUPPLIER_CODE, CFC.FACTORY_CODE, CSC.COOP_CATEGORY ' ||
               'FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG CSC INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG CFC ' ||
               'ON CSC.CSC_ID =  CFC.CSC_ID AND CSC.COMPANY_ID = CFC.COMPANY_ID WHERE ' ||
               v_cond;
    
    END IF;
    RETURN v_sql;
  END f_get_coopsf_sfc_by_conds;

  /*========================================================================================
  
    供应商档案变更设置生产工厂预约产能占比为0
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-28 : 供应商档案变更设置生产工厂预约产能占比为0
  
  ========================================================================================*/
  PROCEDURE p_supfilecg_setappcapcrate_to_zero
  (
    v_supcode  IN VARCHAR2 DEFAULT NULL,
    v_faccode  IN VARCHAR2 DEFAULT NULL,
    v_cate     IN VARCHAR2 DEFAULT NULL,
    v_procate  IN VARCHAR2 DEFAULT NULL,
    v_subcate  IN VARCHAR2 DEFAULT NULL,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    TYPE currc IS REF CURSOR;
    tmprc      currc;
    v_exesql   CLOB;
    v_csupcode VARCHAR2(32);
    v_cfaccode VARCHAR2(32);
    v_ccate    VARCHAR2(2);
  BEGIN
    IF v_supcode IS NOT NULL
       AND v_faccode IS NOT NULL
       AND v_cate IS NOT NULL
       AND v_compid IS NOT NULL THEN
      p_set_appcapcratetozero(v_supcode  => v_supcode,
                              v_faccode  => v_faccode,
                              v_cate     => v_cate,
                              v_operid   => v_operid,
                              v_opertime => v_opertime,
                              v_compid   => v_compid);
    ELSE
      v_exesql := f_get_coopsf_sfc_by_conds(v_supcode => v_supcode,
                                            v_faccode => v_faccode,
                                            v_cate    => v_cate,
                                            v_procate => v_procate,
                                            v_subcate => v_subcate,
                                            v_compid  => v_compid);
    
      OPEN tmprc FOR v_exesql;
      LOOP
        EXIT WHEN tmprc%NOTFOUND;
        FETCH tmprc
          INTO v_csupcode,
               v_cfaccode,
               v_ccate;
      
        IF v_csupcode IS NOT NULL THEN
          p_set_appcapcratetozero(v_supcode  => v_csupcode,
                                  v_faccode  => v_cfaccode,
                                  v_cate     => v_ccate,
                                  v_operid   => v_operid,
                                  v_opertime => v_opertime,
                                  v_compid   => v_compid);
        END IF;
      END LOOP;
      CLOSE tmprc;
    END IF;
  END p_supfilecg_setappcapcrate_to_zero;

  /*========================================================================================
  
    品类合作供应商生产工厂产能预约配置数据刷新
  
    入参:
      V_SUPCODE  :  供应商编码
      V_FACCODE  :  生产工厂编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  子类Id
      V_COMPID   :  企业Id
  
    版本:
      2022-09-07 : 品类合作供应商生产工厂产能预约配置数据刷新
  
  ========================================================================================*/
  PROCEDURE p_coopsupfac_appcapc_datarefresh
  (
    v_supcode  IN VARCHAR2 DEFAULT NULL,
    v_faccode  IN VARCHAR2 DEFAULT NULL,
    v_cate     IN VARCHAR2 DEFAULT NULL,
    v_procate  IN VARCHAR2 DEFAULT NULL,
    v_subcate  IN VARCHAR2 DEFAULT NULL,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    TYPE rc_type IS REF CURSOR;
    tmprc       rc_type;
    v_sql       CLOB;
    v_osupcode  VARCHAR2(32);
    v_ofaccode  VARCHAR2(32);
    v_ocate     VARCHAR2(2);
    v_oprocate  VARCHAR2(4);
    v_osubcate  VARCHAR2(8);
    v_opause    NUMBER(1);
    v_ocompid   VARCHAR2(32);
    v_cscid     VARCHAR2(32);
    v_jugnum    NUMBER(1);
    v_wt        NUMBER(8, 2);
    v_wn        NUMBER(8, 2);
    v_pe        NUMBER(8, 2);
    v_ra        NUMBER(8, 2);
    v_scpspause NUMBER(1);
  BEGIN
    IF v_supcode IS NOT NULL
       AND v_faccode IS NULL
       AND v_subcate IS NOT NULL THEN
      SELECT MAX(sign(cmpause + ptpause + sfpause + cspause))
        INTO v_scpspause
        FROM (SELECT (CASE
                       WHEN a.cooperation_model = 'OF' THEN
                        1
                       ELSE
                        0
                     END) cmpause,
                     decode(nvl(a.product_type, '00'), '00', 0, 1) ptpause,
                     decode(a.pause, 2, 0, nvl(a.pause, 1)) sfpause,
                     nvl(b.pause, 1) cspause
                FROM scmdata.t_supplier_info a
                LEFT JOIN scmdata.t_coop_scope b
                  ON a.supplier_info_id = b.supplier_info_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND b.coop_classification = v_cate
                 AND b.coop_product_cate = v_procate
                 AND instr(b.coop_subcategory, v_subcate) > 0
                 AND a.company_id = v_compid);
    
      IF v_scpspause IS NOT NULL THEN
        SELECT MAX(csc_id)
          INTO v_cscid
          FROM scmdata.t_coopcate_supplier_cfg
         WHERE supplier_code = v_supcode
           AND coop_category = v_cate
           AND coop_productcate = v_procate
           AND coop_subcategory = v_subcate
           AND company_id = v_compid;
      
        UPDATE scmdata.t_coopcate_supplier_cfg
           SET pause = v_scpspause
         WHERE csc_id = v_cscid
           AND company_id = v_compid;
      
        UPDATE scmdata.t_coop_supfac_cfg_view
           SET pause = v_scpspause
         WHERE csc_id = v_cscid
           AND company_id = v_compid;
      END IF;
    
    END IF;
  
    v_sql := f_get_sfcps_by_conds(v_supcode => v_supcode,
                                  v_faccode => v_faccode,
                                  v_cate    => v_cate,
                                  v_procate => v_procate,
                                  v_subcate => v_subcate,
                                  v_compid  => v_compid);
  
    /*SCMDATA.P_PRINT_CLOB_INTO_CONSOLE(V_CLOB => V_SQL);*/
  
    OPEN tmprc FOR v_sql;
    LOOP
      FETCH tmprc
        INTO v_osupcode,
             v_ofaccode,
             v_ocate,
             v_oprocate,
             v_osubcate,
             v_ocompid,
             v_opause;
      EXIT WHEN tmprc%NOTFOUND;
      IF v_osupcode IS NOT NULL THEN
        SELECT MAX(csc_id)
          INTO v_cscid
          FROM scmdata.t_coopcate_supplier_cfg
         WHERE supplier_code = v_osupcode
           AND coop_category = v_ocate
           AND coop_productcate = v_oprocate
           AND coop_subcategory = v_osubcate
           AND company_id = v_compid;
      
        IF v_cscid IS NOT NULL THEN
          SELECT nvl(MAX(1), 0)
            INTO v_jugnum
            FROM scmdata.t_coopcate_factory_cfg
           WHERE csc_id = v_cscid
             AND factory_code = v_ofaccode
             AND company_id = v_ocompid;
        
          IF v_jugnum = 0 THEN
            IF v_opause = 0 THEN
              INSERT INTO scmdata.t_coopcate_factory_cfg
                (cfc_id, company_id, csc_id, factory_code, pause, is_show, create_id, create_time)
              VALUES
                (scmdata.f_get_uuid(), v_ocompid, v_cscid, v_ofaccode, v_opause, v_opause, v_operid, to_date(v_opertime,
                          'YYYY-MM-DD HH24-MI-SS'));
            END IF;
          ELSE
            UPDATE scmdata.t_coopcate_factory_cfg
               SET pause       = v_opause,
                   is_show     = v_opause,
                   update_id   = v_operid,
                   update_time = to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS')
             WHERE csc_id = v_cscid
               AND factory_code = v_ofaccode
               AND company_id = v_ocompid;
          
            UPDATE scmdata.t_coop_supfac_cfg_view tmpview
               SET pause          = v_opause,
                   operate_id     = v_operid,
                   operate_time   = to_date(v_opertime,
                                            'YYYY-MM-DD HH24-MI-SS'),
                   operate_method = 'UPD'
             WHERE EXISTS (SELECT 1
                      FROM scmdata.t_coopcate_factory_cfg
                     WHERE csc_id = v_cscid
                       AND factory_code = v_ofaccode
                       AND company_id = v_ocompid
                       AND cfc_id = tmpview.cfc_id
                       AND company_id = tmpview.company_id);
          
          END IF;
        
          SELECT nvl(MAX(1), 0)
            INTO v_jugnum
            FROM scmdata.t_app_capacity_cfg
           WHERE supplier_code = v_osupcode
             AND category = v_ocate
             AND factory_code = v_ofaccode
             AND company_id = v_ocompid;
        
          IF v_jugnum = 0 THEN
            SELECT MAX(nvl(work_hours_day, 0)),
                   MAX(nvl(worker_num, 0)),
                   MAX(nvl(product_efficiency, 0))
              INTO v_wt,
                   v_wn,
                   v_pe
              FROM scmdata.t_supplier_info
             WHERE supplier_code = v_ofaccode
               AND company_id = v_ocompid;
          
            v_ra := scmdata.pkg_capacity_withview_management.f_get_restcapc_rate_withview(v_cate    => v_ocate,
                                                                                          v_supcode => v_osupcode,
                                                                                          v_faccode => v_ofaccode,
                                                                                          v_compid  => v_ocompid);
          
            INSERT INTO scmdata.t_app_capacity_cfg
              (acc_id, company_id, category, supplier_code, factory_code, wktime_num, wkperson_num, prod_eff, restcapc_rate, appcapc_rate, create_id, create_time)
            VALUES
              (scmdata.f_get_uuid(), v_ocompid, v_ocate, v_osupcode, v_ofaccode, v_wt, v_wn, v_pe, v_ra, 0, v_operid, to_date(v_opertime,
                        'YYYY-MM-DD HH24-MI-SS'));
          END IF;
        END IF;
      END IF;
    END LOOP;
    CLOSE tmprc;
  END p_coopsupfac_appcapc_datarefresh;

  /*========================================================================================
  
    供应商档案相关变更刷新产能配置数据
  
    入参:
      V_SUPCODE   :  供应商编码
      V_FACCODE   :  生产工厂编码
      V_CATE      :  分类Id
      V_PROCATE   :  生产分类Id
      V_SUBCATE   :  子类Id
      V_OPERID    :  操作人
      V_OPERTIME  :  操作时间
      V_COMPID    :  企业Id
  
    版本:
      2022-09-28 : 供应商档案相关变更刷新产能配置数据
  
  ========================================================================================*/
  PROCEDURE p_supfilerelacg_refreshcfgdata
  (
    v_supcode  IN VARCHAR2 DEFAULT NULL,
    v_faccode  IN VARCHAR2 DEFAULT NULL,
    v_cate     IN VARCHAR2 DEFAULT NULL,
    v_procate  IN VARCHAR2 DEFAULT NULL,
    v_subcate  IN VARCHAR2 DEFAULT NULL,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
  
  BEGIN
    p_coopsupfac_appcapc_datarefresh(v_supcode  => v_supcode,
                                     v_faccode  => v_faccode,
                                     v_cate     => v_cate,
                                     v_procate  => v_procate,
                                     v_subcate  => v_subcate,
                                     v_operid   => v_operid,
                                     v_opertime => v_opertime,
                                     v_compid   => v_compid);
  
    p_supfilecg_setappcapcrate_to_zero(v_supcode  => v_supcode,
                                       v_faccode  => v_faccode,
                                       v_cate     => v_cate,
                                       v_procate  => v_procate,
                                       v_subcate  => v_subcate,
                                       v_operid   => v_operid,
                                       v_opertime => v_opertime,
                                       v_compid   => v_compid);
  END p_supfilerelacg_refreshcfgdata;

  /*===================================================================================
  
    生产周期配置生效逻辑
  
    用途:
      用于对生产周期配置相关数据修改进行生效、重算或删除
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业id
      V_COND      :  唯一条件
      V_METHOD    :  变更方式 INS-新增 UPD-修改 DEL-删除
  
    版本:
      2022-05-06 : 用于对生产周期配置相关数据修改进行生效、重算或删除
  
  ===================================================================================*/
  PROCEDURE p_recalc_prodcyc_eff
  (
    v_supcode  IN VARCHAR2,
    v_faccode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    --判断供应商产能预约是否存在数据
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_supplier_capacity_detail scd1
     INNER JOIN scmdata.t_capacity_appointment_detail cad1
        ON scd1.ptc_id = cad1.ptc_id
       AND scd1.company_id = cad1.company_id
     WHERE scd1.supplier_code = v_supcode
       AND scd1.factory_code = v_faccode
       AND scd1.company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      --为空新增
      p_idu_supcapcappdata_by_diffparam(v_supcode  => v_supcode,
                                        v_faccode  => v_faccode,
                                        v_cate     => v_cate,
                                        v_operid   => v_operid,
                                        v_opertime => v_opertime,
                                        v_compid   => v_compid);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => v_faccode, v_compid => v_compid);
    END IF;
  
    --已下订单，生产排期数据重算
    p_idu_alorder_data_by_diffparam(v_supcode => v_supcode,
                                    v_faccode => v_faccode,
                                    v_cate    => v_cate,
                                    v_procate => v_procate,
                                    v_subcate => v_subcate,
                                    v_compid  => v_compid);
  
    IF v_supcode IS NOT NULL THEN
      p_prodcyccfg_cpss_plrecalc(v_cate     => v_cate,
                                 v_procate  => v_procate,
                                 v_subcate  => v_subcate,
                                 v_supcodes => v_supcode,
                                 v_compid   => v_compid);
    ELSE
      p_prodcyccfg_cps_plrecalc(v_cate    => v_cate,
                                v_procate => v_procate,
                                v_subcate => v_subcate,
                                v_compid  => v_compid);
    END IF;
  
    --周产能规划重算
    p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                           v_cate     => v_cate,
                           v_operid   => v_operid,
                           v_opertime => v_opertime,
                           v_compid   => v_compid);
    /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_SUPCODE,
    V_CATE     => V_CATE,
    V_OPERID   => V_OPERID,
    V_OPERTIME => V_OPERTIME,
    V_COMPID   => V_COMPID);*/
  END p_recalc_prodcyc_eff;

  /*===================================================================================
  
    生产周期配置生效逻辑
  
    用途:
      用于对生产周期配置相关数据修改进行生效、重算或删除
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业id
      V_COND      :  唯一条件
      V_METHOD    :  变更方式 INS-新增 UPD-修改 DEL-删除
  
    版本:
      2022-05-06 : 用于对生产周期配置相关数据修改进行生效、重算或删除
  
  ===================================================================================*/
  PROCEDURE p_prodcyccfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2
  ) IS
    v_vnum        NUMBER(1);
    v_curpccid    VARCHAR2(32);
    v_curcompid   VARCHAR2(32);
    v_rawcate     VARCHAR2(2);
    v_curcate     VARCHAR2(2);
    v_rawprocate  VARCHAR2(4);
    v_curprocate  VARCHAR2(4);
    v_rawsubcate  VARCHAR2(8);
    v_cursubcate  VARCHAR2(8);
    v_rawsupcodes VARCHAR2(32);
    v_cursupcodes VARCHAR2(32);
    v_curfiomw    VARCHAR2(4);
    v_curaomw     VARCHAR2(4);
    v_curpatw     VARCHAR2(4);
    v_cate        VARCHAR2(2);
    v_procate     VARCHAR2(4);
    v_subcate     VARCHAR2(8);
    v_supcodes    VARCHAR2(4000);
    v_creid       VARCHAR2(32);
    v_cretime     VARCHAR2(32);
    v_updid       VARCHAR2(32);
    v_updtime     VARCHAR2(32);
    v_fields      VARCHAR2(2048);
    v_exesql      VARCHAR2(4000);
  BEGIN
    --选出修改的数据
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PCC_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COMPANY_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CATEGORY' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'CATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_CATE' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_CATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUBCATEGORY' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUBCATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUPPLIER_CODES' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUPPLIER_CODES' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'FIRST_ORD_MAT_WAIT' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'ADD_ORD_MAT_WAIT' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PC_AND_TRANS_WAIT' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_TIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_curpccid,
           v_curcompid,
           v_rawcate,
           v_curcate,
           v_rawprocate,
           v_curprocate,
           v_rawsubcate,
           v_cursubcate,
           v_rawsupcodes,
           v_cursupcodes,
           v_curfiomw,
           v_curaomw,
           v_curpatw,
           v_creid,
           v_cretime,
           v_updid,
           v_updtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    --判断 V_UPDID 是否为空，并且 V_METHOD = 'UPD' 如果是，进业务表获取 UPDATE_ID
    IF v_updid IS NULL
       AND v_method = 'UPD' THEN
      v_exesql := 'SELECT MAX(UPDATE_ID) FROM SCMDATA.T_PRODUCT_CYCLE_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_updid;
    END IF;
  
    --根据 V_METHOD 判断数据生效方式
    IF v_method = 'INS' THEN
      --新增逻辑
      --生效到业务表
      INSERT INTO scmdata.t_product_cycle_cfg
        (pcc_id, company_id, category, product_cate, subcategory, supplier_codes, first_ord_mat_wait, add_ord_mat_wait, pc_and_trans_wait, create_id, create_time)
      VALUES
        (v_curpccid, v_curcompid, v_curcate, v_curprocate, v_cursubcate, v_cursupcodes, to_number(v_curfiomw), to_number(v_curaomw), to_number(v_curpatw), v_creid, to_date(v_cretime,
                  'YYYY-MM-DD HH24-MI-SS'));
    
      --隐式游标筛出可用数据
      FOR it IN (SELECT csc1.supplier_code,
                        cfc1.factory_code,
                        csc1.company_id,
                        csc1.coop_category,
                        csc1.coop_productcate,
                        csc1.coop_subcategory
                   FROM scmdata.t_coopcate_supplier_cfg csc1
                  INNER JOIN scmdata.t_coopcate_factory_cfg cfc1
                     ON csc1.csc_id = cfc1.csc_id
                    AND csc1.company_id = cfc1.company_id
                  WHERE csc1.coop_category = v_curcate
                    AND csc1.coop_productcate = v_curprocate
                    AND csc1.coop_subcategory = v_cursubcate
                    AND csc1.company_id = v_compid) LOOP
        --重算
        p_recalc_prodcyc_eff(v_supcode  => it.supplier_code,
                             v_faccode  => it.factory_code,
                             v_cate     => it.coop_category,
                             v_procate  => it.coop_productcate,
                             v_subcate  => it.coop_subcategory,
                             v_operid   => v_creid,
                             v_opertime => v_cretime,
                             v_compid   => it.company_id);
      END LOOP;
    ELSIF v_method = 'UPD' THEN
      --修改逻辑
      --构造生效字段
      IF v_curcate IS NOT NULL THEN
        v_fields := v_fields || 'CATEGORY = ''' || v_curcate || ''',';
      END IF;
    
      IF v_curprocate IS NOT NULL THEN
        v_fields := v_fields || 'PRODUCT_CATE = ''' || v_curprocate ||
                    ''',';
      END IF;
    
      IF v_cursubcate IS NOT NULL THEN
        v_fields := v_fields || 'SUBCATEGORY = ''' || v_cursubcate || ''',';
      END IF;
    
      IF v_cursupcodes IS NOT NULL THEN
        v_fields := v_fields || 'SUPPLIER_CODES = ''' || v_cursupcodes ||
                    ''',';
      END IF;
    
      IF v_curfiomw IS NOT NULL THEN
        v_fields := v_fields || 'FIRST_ORD_MAT_WAIT = ' || v_curfiomw || ',';
      END IF;
    
      IF v_curaomw IS NOT NULL THEN
        v_fields := v_fields || 'ADD_ORD_MAT_WAIT = ' || v_curaomw || ',';
      END IF;
    
      IF v_curpatw IS NOT NULL THEN
        v_fields := v_fields || 'PC_AND_TRANS_WAIT = ' || v_curpatw || ',';
      END IF;
    
      --去除字段右方逗号
      v_fields := rtrim(v_fields, ',');
    
      --生效到业务表
      v_exesql := 'UPDATE SCMDATA.T_PRODUCT_CYCLE_CFG SET ' || v_fields ||
                  ' WHERE ' || v_cond;
      EXECUTE IMMEDIATE v_exesql;
    
      --选出当前 CPS 及 SUPPLIER_CODES
      v_exesql := 'SELECT CATEGORY, PRODUCT_CATE, SUBCATEGORY, SUPPLIER_CODES FROM SCMDATA.T_PRODUCT_CYCLE_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_cate, v_procate, v_subcate, v_supcodes;
    
      --判断修改字段
      IF v_cursubcate IS NOT NULL THEN
        --CPS修改
        --历史 CPS 相关数据首单待料天数,补单待料天数,后整及物流天数置零重算
        FOR hisupd IN (SELECT csc2.coop_category,
                              csc2.coop_productcate,
                              csc2.coop_subcategory,
                              csc2.supplier_code,
                              cfc2.factory_code,
                              csc2.company_id
                         FROM scmdata.t_coopcate_supplier_cfg csc2
                        INNER JOIN scmdata.t_coopcate_factory_cfg cfc2
                           ON csc2.csc_id = cfc2.csc_id
                          AND csc2.company_id = cfc2.company_id
                        WHERE csc2.coop_category = v_rawcate
                          AND csc2.coop_productcate = v_rawprocate
                          AND csc2.coop_subcategory = v_rawsubcate
                          AND csc2.company_id = v_compid) LOOP
          --重算
          p_recalc_prodcyc_eff(v_supcode  => hisupd.supplier_code,
                               v_faccode  => hisupd.factory_code,
                               v_cate     => hisupd.coop_category,
                               v_procate  => hisupd.coop_productcate,
                               v_subcate  => hisupd.coop_subcategory,
                               v_operid   => v_updid,
                               v_opertime => v_updtime,
                               v_compid   => hisupd.company_id);
        END LOOP;
      
        --当前 CPS 相关数据首单待料天数,补单待料天数,后整及物流天数置零重算
        FOR curupd IN (SELECT csc3.coop_category,
                              csc3.coop_productcate,
                              csc3.coop_subcategory,
                              csc3.supplier_code,
                              cfc3.factory_code,
                              csc3.company_id
                         FROM scmdata.t_coopcate_supplier_cfg csc3
                        INNER JOIN scmdata.t_coopcate_factory_cfg cfc3
                           ON csc3.csc_id = cfc3.csc_id
                          AND csc3.company_id = cfc3.company_id
                        WHERE csc3.coop_category = v_rawcate
                          AND csc3.coop_productcate = v_rawprocate
                          AND csc3.coop_subcategory = v_rawsubcate
                          AND csc3.company_id = v_compid) LOOP
          --重算
          p_recalc_prodcyc_eff(v_supcode  => curupd.supplier_code,
                               v_faccode  => curupd.factory_code,
                               v_cate     => curupd.coop_category,
                               v_procate  => curupd.coop_productcate,
                               v_subcate  => curupd.coop_subcategory,
                               v_operid   => v_updid,
                               v_opertime => v_updtime,
                               v_compid   => curupd.company_id);
        END LOOP;
      ELSIF v_cursupcodes IS NOT NULL THEN
        --SUPPLIER_CODES 修改
        --相关供应商查出
        v_supcodes := scmdata.pkg_capacity_management.f_get_unq_data(v_data      => v_rawsupcodes || ';' ||
                                                                                    v_cursupcodes,
                                                                     v_sepsymbol => ';');
      
        FOR supcds IN (SELECT csc4.coop_category,
                              csc4.coop_productcate,
                              csc4.coop_subcategory,
                              csc4.supplier_code,
                              cfc4.factory_code,
                              csc4.company_id
                         FROM scmdata.t_coopcate_supplier_cfg csc4
                        INNER JOIN scmdata.t_coopcate_factory_cfg cfc4
                           ON csc4.csc_id = cfc4.csc_id
                          AND csc4.company_id = cfc4.company_id
                        WHERE csc4.coop_category = v_cate
                          AND csc4.coop_productcate = v_procate
                          AND csc4.coop_subcategory = v_subcate
                          AND instr(v_supcodes, csc4.supplier_code) > 0
                          AND csc4.company_id = v_compid) LOOP
          --重算
          p_recalc_prodcyc_eff(v_supcode  => supcds.supplier_code,
                               v_faccode  => supcds.factory_code,
                               v_cate     => supcds.coop_category,
                               v_procate  => supcds.coop_productcate,
                               v_subcate  => supcds.coop_subcategory,
                               v_operid   => v_updid,
                               v_opertime => v_updtime,
                               v_compid   => supcds.company_id);
        END LOOP;
      ELSE
        --其他修改
        FOR elsupd IN (SELECT csc5.coop_category,
                              csc5.coop_productcate,
                              csc5.coop_subcategory,
                              csc5.supplier_code,
                              cfc5.factory_code,
                              csc5.company_id
                         FROM scmdata.t_coopcate_supplier_cfg csc5
                        INNER JOIN scmdata.t_coopcate_factory_cfg cfc5
                           ON csc5.csc_id = cfc5.csc_id
                          AND csc5.company_id = cfc5.company_id
                        WHERE csc5.coop_category = v_cate
                          AND csc5.coop_productcate = v_procate
                          AND csc5.coop_subcategory = v_subcate
                          AND instr(v_supcodes, csc5.supplier_code) > 0
                          AND csc5.company_id = v_compid) LOOP
          --重算
          p_recalc_prodcyc_eff(v_supcode  => elsupd.supplier_code,
                               v_faccode  => elsupd.factory_code,
                               v_cate     => elsupd.coop_category,
                               v_procate  => elsupd.coop_productcate,
                               v_subcate  => elsupd.coop_subcategory,
                               v_operid   => v_updid,
                               v_opertime => v_updtime,
                               v_compid   => elsupd.company_id);
        END LOOP;
      END IF;
    ELSIF v_method = 'DEL' THEN
      --删除逻辑
      --选出当前 CPS 及 SUPPLIER_CODES
      v_exesql := 'SELECT CATEGORY, PRODUCT_CATE, SUBCATEGORY, SUPPLIER_CODES FROM SCMDATA.T_PRODUCT_CYCLE_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_cate, v_procate, v_subcate, v_supcodes;
    
      --生效到业务表
      v_exesql := 'DELETE FROM SCMDATA.T_PRODUCT_CYCLE_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql;
    
      FOR delit IN (SELECT csc6.coop_category,
                           csc6.coop_productcate,
                           csc6.coop_subcategory,
                           csc6.supplier_code,
                           cfc6.factory_code,
                           csc6.company_id
                      FROM scmdata.t_coopcate_supplier_cfg csc6
                     INNER JOIN scmdata.t_coopcate_factory_cfg cfc6
                        ON csc6.csc_id = cfc6.csc_id
                       AND csc6.company_id = cfc6.company_id
                     WHERE csc6.coop_category = v_cate
                       AND csc6.coop_productcate = v_procate
                       AND csc6.coop_subcategory = v_subcate
                       AND instr(v_supcodes, csc6.supplier_code) > 0
                       AND csc6.company_id = v_compid) LOOP
        --重算
        p_recalc_prodcyc_eff(v_supcode  => delit.supplier_code,
                             v_faccode  => delit.factory_code,
                             v_cate     => delit.coop_category,
                             v_procate  => delit.coop_productcate,
                             v_subcate  => delit.coop_subcategory,
                             v_operid   => v_updid,
                             v_opertime => v_updtime,
                             v_compid   => delit.company_id);
      END LOOP;
    END IF;
  END p_prodcyccfg_efflogic;

  /*=========================================================================
  
    品类产能配置生成相关数据
  
    用途：品类产能配置生成相关数据
  
    入参：
      V_CATE       分部
      V_PROCATE    生产类别
      V_SUBCATE    子类
      V_COMPID     企业id
  
    版本：
      2022-05-05 : 品类产能配置生成相关数据
  
  ==========================================================================*/
  PROCEDURE p_cateplancfg_able_efflevels_cg
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_opid    IN VARCHAR2,
    v_optime  IN DATE
  ) IS
  BEGIN
    --生成供应商产能预约数据，已下订单生产排期数据
    FOR p IN (SELECT a.supplier_code,
                     b.factory_code,
                     a.company_id,
                     a.coop_category,
                     a.coop_productcate,
                     a.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a
               INNER JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.coop_category = v_cate
                 AND a.coop_productcate = v_procate
                 AND a.coop_subcategory = v_subcate
                 AND a.company_id = v_compid) LOOP
      --生成供应商产能预约数据
      p_idu_supcapcappdata_by_diffparam(v_supcode  => p.supplier_code,
                                        v_faccode  => p.factory_code,
                                        v_cate     => p.coop_category,
                                        v_operid   => v_opid,
                                        v_opertime => to_char(v_optime,
                                                              'YYYY-MM-DD HH24:MI:SS'),
                                        v_compid   => p.company_id);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => p.factory_code,
                             v_compid  => p.company_id);
    
      --生成已下订单生产排期数据
      p_idu_alorder_data_by_diffparam(v_supcode => p.supplier_code,
                                      v_faccode => p.factory_code,
                                      v_cate    => p.coop_category,
                                      v_procate => p.coop_productcate,
                                      v_subcate => p.coop_subcategory,
                                      v_compid  => p.company_id);
    END LOOP;
  
    --生成周产能相关数据
    FOR i IN (SELECT DISTINCT supplier_code,
                              coop_category,
                              company_id
                FROM scmdata.t_coopcate_supplier_cfg
               WHERE coop_category = v_cate
                 AND coop_productcate = v_procate
                 AND coop_subcategory = v_subcate
                 AND company_id = v_compid) LOOP
      --生成周产能相关数据
      p_gen_wkplanrecalcrela(v_supcode  => i.supplier_code,
                             v_cate     => i.coop_category,
                             v_operid   => v_opid,
                             v_opertime => to_char(v_optime,
                                                   'YYYY-MM-DD HH24:MI:SS'),
                             v_compid   => i.company_id);
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => I.SUPPLIER_CODE,
      V_CATE     => I.COOP_CATEGORY,
      V_OPERID   => V_OPID,
      V_OPERTIME => TO_CHAR(V_OPTIME,'YYYY-MM-DD HH24:MI:SS'),
      V_COMPID   => I.COMPANY_ID);*/
    END LOOP;
  
  END p_cateplancfg_able_efflevels_cg;

  /*=========================================================================
  
    品类产能配置删除相关数据
  
    用途：品类产能配置删除相关数据
  
    入参：
      V_CATE       分部
      V_PROCATE    生产类别
      V_SUBCATE    子类
      V_COMPID     企业id
  
    版本：
      2022-05-05 : 品类产能配置删除相关数据
  
  ==========================================================================*/
  PROCEDURE p_cateplancfg_disable_efflevels_cg
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_opid    IN VARCHAR2,
    v_optime  IN DATE
  ) IS
  BEGIN
    --生成供应商产能预约数据，已下订单生产排期数据
    FOR p IN (SELECT a.supplier_code,
                     b.factory_code,
                     a.company_id,
                     a.coop_category,
                     a.coop_productcate,
                     a.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a
               INNER JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.coop_category = v_cate
                 AND a.coop_productcate = v_procate
                 AND a.coop_subcategory = v_subcate
                 AND a.company_id = v_compid) LOOP
      --删除供应商产能预约数据
      p_idu_supcapcappdata_by_diffparam(v_supcode  => p.supplier_code,
                                        v_faccode  => p.factory_code,
                                        v_cate     => p.coop_category,
                                        v_operid   => v_opid,
                                        v_opertime => to_char(v_optime,
                                                              'YYYY-MM-DD HH24:MI:SS'),
                                        v_compid   => p.company_id);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => p.factory_code,
                             v_compid  => p.company_id);
    
      --删除已下订单生产排期数据
      p_idu_alorder_data_by_diffparam(v_supcode => p.supplier_code,
                                      v_faccode => p.factory_code,
                                      v_cate    => p.coop_category,
                                      v_procate => p.coop_productcate,
                                      v_subcate => p.coop_subcategory,
                                      v_compid  => p.company_id);
    
      --删除周产能相关数据
      p_delete_wkplandata(v_supcode => p.supplier_code,
                          v_faccode => p.factory_code,
                          v_cate    => p.coop_category,
                          v_procate => p.coop_productcate,
                          v_subcate => p.coop_subcategory,
                          v_compid  => p.company_id,
                          v_mindate => SYSDATE);
    END LOOP;
  
  END p_cateplancfg_disable_efflevels_cg;

  /*=====================================================================
  
    品类产能配置层级生效逻辑
  
    用途：
      品类产能配置层级生效逻辑
  
    入参：
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业id
      V_COND      :  唯一条件
      V_METHOD    :  变更方式 INS-新增 UPD-修改 DEL-删除
  
    版本：
      2022-05-05 : 品类产能配置删除相关数据
  
  =======================================================================*/
  PROCEDURE p_cateplan_efflogic_cg
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2
  ) IS
    v_vnum       NUMBER(1);
    v_curcpccid  VARCHAR2(32);
    v_curcompid  VARCHAR2(32);
    v_rawcate    VARCHAR2(2);
    v_curcate    VARCHAR2(2);
    v_rawprocate VARCHAR2(4);
    v_curprocate VARCHAR2(4);
    v_rawsubcate VARCHAR2(8);
    v_cursubcate VARCHAR2(8);
    v_rawinpln   VARCHAR2(1);
    v_curinpln   VARCHAR2(1);
    v_creid      VARCHAR2(32);
    v_cretime    VARCHAR2(32);
    v_updid      VARCHAR2(32);
    v_updtime    VARCHAR2(32);
    v_cate       VARCHAR2(2);
    v_procate    VARCHAR2(4);
    v_subcate    VARCHAR2(8);
    v_inplnn     NUMBER(1);
    v_fields     VARCHAR2(2048);
    v_exesql     VARCHAR2(4000);
  BEGIN
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'CPCC_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COMPANY_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CATEGORY' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'CATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_CATE' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_CATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUBCATEGORY' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUBCATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'IN_PLANNING' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'IN_PLANNING' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_TIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_curcpccid,
           v_curcompid,
           v_rawcate,
           v_curcate,
           v_rawprocate,
           v_curprocate,
           v_rawsubcate,
           v_cursubcate,
           v_rawinpln,
           v_curinpln,
           v_creid,
           v_cretime,
           v_updid,
           v_updtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_updid IS NULL THEN
      v_exesql := 'SELECT MAX(OPERATE_ID) FROM SCMDATA.T_CAPAPLAN_CATE_CFG_VIEW WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_updid;
    END IF;
  
    IF v_method = 'INS' THEN
      --操作方式=新增
      --生效到业务表
      INSERT INTO scmdata.t_capacity_plan_category_cfg
        (cpcc_id, company_id, category, product_cate, subcategory, in_planning, create_id, create_time)
      VALUES
        (v_curcpccid, v_curcompid, v_curcate, v_curprocate, v_cursubcate, v_curinpln, v_creid, to_date(v_cretime,
                  'YYYY-MM-DD HH24-MI-SS'));
    
      --生成供应商产能预约，已下单生产排期，周产能规划数据
      p_cateplancfg_able_efflevels_cg(v_cate    => v_curcate,
                                      v_procate => v_curprocate,
                                      v_subcate => v_cursubcate,
                                      v_compid  => v_curcompid,
                                      v_opid    => v_creid,
                                      v_optime  => to_date(v_cretime,
                                                           'YYYY-MM-DD HH24-MI-SS'));
    ELSIF v_method = 'UPD' THEN
      --操作方式=修改
      --更新字段构造
      IF v_rawcate IS NOT NULL THEN
        v_fields := v_fields || 'CATEGORY = ''' || v_curcate || ''',';
      END IF;
    
      IF v_rawprocate IS NOT NULL THEN
        v_fields := v_fields || 'PRODUCT_CATE = ''' || v_curprocate ||
                    ''',';
      END IF;
    
      IF v_rawsubcate IS NOT NULL THEN
        v_fields := v_fields || 'SUBCATEGORY = ''' || v_cursubcate || ''',';
      END IF;
    
      IF v_rawinpln IS NOT NULL THEN
        v_fields := v_fields || 'IN_PLANNING = ' || v_curinpln || ',';
      END IF;
    
      --去除右逗号
      v_fields := rtrim(v_fields, ',');
    
      --生效到业务表
      v_exesql := 'UPDATE SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG SET ' ||
                  v_fields || ' WHERE ' || v_cond;
      EXECUTE IMMEDIATE v_exesql;
    
      --选出分类-生产分类-子类
      v_exesql := 'SELECT CATEGORY, PRODUCT_CATE, SUBCATEGORY, IN_PLANNING FROM SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_cate, v_procate, v_subcate, v_inplnn;
    
      --不同修改对应不同处理
      IF v_rawsubcate IS NOT NULL THEN
        --当子类被修改（前端CPS连选，默认分类-生产分类-子类一起被修改）
        --删除相关生产排期数据
        p_delpsdata_by_cps(v_cate    => v_rawcate,
                           v_procate => v_rawprocate,
                           v_subcate => v_rawsubcate,
                           v_compid  => v_compid);
      
        --RAWCPS失效逻辑（为什么用RAW，因为CPS修改一定会有原值）
        p_cateplancfg_disable_efflevels_cg(v_cate    => v_rawcate,
                                           v_procate => v_rawprocate,
                                           v_subcate => v_rawsubcate,
                                           v_compid  => v_compid,
                                           v_opid    => v_updid,
                                           v_optime  => to_date(v_updtime,
                                                                'YYYY-MM-DD HH24-MI-SS'));
      
        --CURCPS生效逻辑
        IF v_inplnn = 1 THEN
          p_cateplancfg_able_efflevels_cg(v_cate    => v_curcate,
                                          v_procate => v_curprocate,
                                          v_subcate => v_cursubcate,
                                          v_compid  => v_compid,
                                          v_opid    => v_updid,
                                          v_optime  => to_date(v_updtime,
                                                               'YYYY-MM-DD HH24-MI-SS'));
        END IF;
      ELSE
        --当CPS未被修改
        IF v_curinpln = '0' THEN
          --是否进行产能规划字段为0（不进行产能规划）
          --失效逻辑
          p_cateplancfg_disable_efflevels_cg(v_cate    => v_cate,
                                             v_procate => v_procate,
                                             v_subcate => v_subcate,
                                             v_compid  => v_compid,
                                             v_opid    => v_updid,
                                             v_optime  => to_date(v_updtime,
                                                                  'YYYY-MM-DD HH24-MI-SS'));
        ELSE
          --是否进行产能规划字段为1（进行产能规划）
          --生效逻辑
          p_cateplancfg_able_efflevels_cg(v_cate    => v_cate,
                                          v_procate => v_procate,
                                          v_subcate => v_subcate,
                                          v_compid  => v_compid,
                                          v_opid    => v_updid,
                                          v_optime  => to_date(v_updtime,
                                                               'YYYY-MM-DD HH24-MI-SS'));
        END IF;
      END IF;
    ELSIF v_method = 'DEL' THEN
      --操作方式=删除
      --选出分类-生产分类-子类
      v_exesql := 'SELECT CATEGORY, PRODUCT_CATE, SUBCATEGORY FROM SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_cate, v_procate, v_subcate;
    
      --生效到业务表
      v_exesql := 'DELETE FROM SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql;
    
      v_exesql := 'DELETE FROM SCMDATA.T_CAPAPLAN_CATE_CFG_VIEW WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql;
    
      --删除生产排期数据
      p_delpsdata_by_cps(v_cate    => v_cate,
                         v_procate => v_procate,
                         v_subcate => v_subcate,
                         v_compid  => v_compid);
    
      --重算供应商产能预约明细，删除周产能规划相关数据
      FOR it IN (SELECT a.supplier_code,
                        b.factory_code,
                        a.company_id,
                        a.coop_category,
                        a.coop_productcate,
                        a.coop_subcategory
                   FROM scmdata.t_coopcate_supplier_cfg a
                  INNER JOIN scmdata.t_coopcate_factory_cfg b
                     ON a.csc_id = b.csc_id
                    AND a.company_id = b.company_id
                  WHERE a.coop_category = v_cate
                    AND a.coop_productcate = v_procate
                    AND a.coop_subcategory = v_subcate
                    AND a.company_id = v_compid) LOOP
        --重算供应商产能预约明细
        p_idu_supcapcappdata_by_diffparam(v_supcode  => it.supplier_code,
                                          v_faccode  => it.factory_code,
                                          v_cate     => it.coop_category,
                                          v_operid   => v_updid,
                                          v_opertime => v_updtime,
                                          v_compid   => it.company_id);
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => it.factory_code,
                               v_compid  => it.company_id);
      
        --删除周产能规划数据
        p_delete_wkplandata(v_supcode => it.supplier_code,
                            v_faccode => it.factory_code,
                            v_cate    => it.coop_category,
                            v_procate => it.coop_productcate,
                            v_subcate => it.coop_subcategory,
                            v_compid  => it.company_id,
                            v_mindate => SYSDATE);
      END LOOP;
    END IF;
  END p_cateplan_efflogic_cg;

  /*===================================================================================
  
    EffectiveLogic
    品类合作供应商新增生效逻辑
  
    入参:
      V_COND  :  唯一行条件
  
    版本:
      2022-08-11 : 品类合作供应商新增生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_coopsupcfg_i_efflogic(v_cond IN VARCHAR2) IS
    v_exesql  CLOB;
    v_cscid   VARCHAR2(32);
    v_compid  VARCHAR2(32);
    v_supcode VARCHAR2(32);
    v_cate    VARCHAR2(2);
    v_procate VARCHAR2(4);
    v_subcate VARCHAR2(8);
    v_creid   VARCHAR2(32);
    v_cretime VARCHAR2(32);
    v_pause   NUMBER(1);
  BEGIN
    --获取 CSC_ID,COMPANY_ID,SUPPLIER_CODE,CATE,CREID,CRETIME
    v_exesql := 'SELECT MAX(CSC_ID), MAX(COMPANY_ID), MAX(SUPPLIER_CODE), MAX(COOP_CATEGORY), ' ||
                'MAX(COOP_PRODUCTCATE), MAX(COOP_SUBCATEGORY), MAX(CREATE_ID), ' ||
                'MAX(TO_CHAR(CREATE_TIME,''YYYY-MM-DD HH24-MI-SS'')) ' ||
                'FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG WHERE ' || v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_cscid, v_compid, v_supcode, v_cate, v_procate, v_subcate, v_creid, v_cretime;
  
    --获取档案和合作范围的 PAUSE
    SELECT nvl(MAX(sign(decode(tsi.pause, 2, 0, tsi.pause) +
                        nvl(tsc.pause, 1))),
               1)
      INTO v_pause
      FROM scmdata.t_supplier_info tsi
     INNER JOIN scmdata.t_coop_scope tsc
        ON tsi.supplier_info_id = tsc.supplier_info_id
       AND tsi.company_id = tsc.company_id
     WHERE tsi.supplier_code = v_supcode
       AND tsc.coop_classification = v_cate
       AND tsc.coop_product_cate = v_procate
       AND instr(tsc.coop_subcategory, v_subcate) > 0
       AND tsi.company_id = v_compid;
  
    --生效到业务表
    UPDATE scmdata.t_coopcate_supplier_cfg
       SET pause = v_pause
     WHERE csc_id = v_cscid
       AND company_id = v_compid;
  
    IF v_pause = 0 THEN
      FOR i IN (SELECT csc.supplier_code,
                       cfc.factory_code,
                       csc.company_id,
                       csc.coop_category,
                       csc.coop_productcate,
                       csc.coop_subcategory,
                       csc.create_id,
                       to_char(csc.create_time, 'YYYY-MM-DD HH24-MI-SS') create_time
                  FROM scmdata.t_coopcate_supplier_cfg csc
                 INNER JOIN scmdata.t_coopcate_factory_cfg cfc
                    ON csc.csc_id = cfc.csc_id
                   AND csc.company_id = cfc.company_id
                 WHERE csc.csc_id = v_cscid
                   AND csc.company_id = v_compid) LOOP
        --供应商产能预约
        p_idu_supcapcappdata_by_diffparam(v_supcode     => i.supplier_code,
                                          v_faccode     => i.factory_code,
                                          v_cate        => i.coop_category,
                                          v_operid      => i.create_id,
                                          v_opertime    => i.create_time,
                                          v_issubtabupd => 0,
                                          v_compid      => i.company_id);
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => i.factory_code,
                               v_compid  => i.company_id);
      
        --下单规划
        p_idu_alorder_data_by_diffparam(v_supcode => i.supplier_code,
                                        v_faccode => i.factory_code,
                                        v_cate    => i.coop_category,
                                        v_procate => i.coop_productcate,
                                        v_subcate => i.coop_subcategory,
                                        v_compid  => i.company_id);
      
        --周产能规划数据重算
        p_delete_wkplandata(v_supcode => i.supplier_code,
                            v_faccode => i.factory_code,
                            v_cate    => i.coop_category,
                            v_procate => i.coop_productcate,
                            v_subcate => i.coop_subcategory,
                            v_compid  => i.company_id,
                            v_mindate => SYSDATE);
      END LOOP;
    
      --周产能规划重算
      p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                             v_cate     => v_cate,
                             v_operid   => v_creid,
                             v_opertime => v_cretime,
                             v_compid   => v_compid);
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_SUPCODE,
      V_CATE     => V_CATE,
      V_OPERID   => V_CREID,
      V_OPERTIME => V_CRETIME,
      V_COMPID   => V_COMPID);*/
    END IF;
  END p_coopsupcfg_i_efflogic;

  /*===================================================================================
  
    品类合作供应商生效逻辑
  
    用途:
      品类合作供应商生效逻辑
  
    入参:
      V_QUEUEID    :  队列Id
      V_COND       :  唯一行条件
      V_COMPID     :  企业Id
  
    版本:
      2022-03-08 : 品类合作供应商生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_coopsupcfg_u_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc           rctype;
    v_vnum       NUMBER(1);
    v_exesql     VARCHAR2(512);
    v_rccscid    VARCHAR2(32);
    v_rcsupcode  VARCHAR2(32);
    v_rcfaccode  VARCHAR2(32);
    v_rccate     VARCHAR2(2);
    v_rcprocate  VARCHAR2(4);
    v_rcsubcate  VARCHAR2(8);
    v_pause      NUMBER(1);
    v_pausestr   VARCHAR2(1);
    v_updateid   VARCHAR2(32);
    v_updatetime VARCHAR2(32);
    v_tmpsupcode VARCHAR2(32);
    v_tmpcate    VARCHAR2(2);
    v_cscid      VARCHAR2(32);
  BEGIN
    --VIEW 层生效到业务表
    v_exesql := 'SELECT MAX(CSC_ID) FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_rccscid;
  
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_pausestr,
           v_updateid,
           v_updatetime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_pausestr IS NOT NULL THEN
      v_pause := to_number(v_pausestr);
    
      IF v_updateid IS NULL THEN
        v_exesql := 'SELECT MAX(NVL(UPDATE_ID,CREATE_ID)) FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG WHERE ' ||
                    v_cond;
        EXECUTE IMMEDIATE v_exesql
          INTO v_updateid;
      END IF;
    
      UPDATE scmdata.t_coopcate_supplier_cfg
         SET pause       = v_pause,
             update_id   = v_updateid,
             update_time = to_date(v_updatetime, 'YYYY-MM-DD HH24-MI-SS')
       WHERE csc_id = v_rccscid
         AND company_id = v_compid;
    
      UPDATE scmdata.t_coopcate_factory_cfg
         SET pause       = v_pause,
             update_id   = v_updateid,
             update_time = to_date(v_updatetime, 'YYYY-MM-DD HH24-MI-SS')
       WHERE csc_id = v_rccscid
         AND company_id = v_compid;
    
      IF v_pause = 1 THEN
        v_exesql := 'SELECT MAX(CSC_ID) FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG WHERE ' ||
                    v_cond;
        EXECUTE IMMEDIATE v_exesql
          INTO v_cscid;
      
        FOR x IN (SELECT DISTINCT csc.supplier_code,
                                  cfc.factory_code,
                                  csc.coop_category,
                                  csc.company_id
                    FROM scmdata.t_coopcate_supplier_cfg csc
                   INNER JOIN scmdata.t_coopcate_factory_cfg cfc
                      ON csc.csc_id = cfc.csc_id
                     AND csc.company_id = cfc.company_id
                   WHERE csc.csc_id = v_cscid
                     AND csc.company_id = v_compid) LOOP
          p_set_appcapcratetozero(v_supcode  => x.supplier_code,
                                  v_faccode  => x.factory_code,
                                  v_cate     => x.coop_category,
                                  v_operid   => v_updateid,
                                  v_opertime => v_updatetime,
                                  v_compid   => x.company_id);
        END LOOP;
      END IF;
    
      --层级生效逻辑
      v_exesql := 'SELECT A.SUPPLIER_CODE, B.FACTORY_CODE, A.COOP_CATEGORY, A.COOP_PRODUCTCATE, A.COOP_SUBCATEGORY ' ||
                  'FROM (SELECT * FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG WHERE ' ||
                  v_cond ||
                  ') A LEFT JOIN SCMDATA.T_COOPCATE_FACTORY_CFG B ON A.CSC_ID = B.CSC_ID ' ||
                  'AND A.COMPANY_ID = B.COMPANY_ID ORDER BY A.SUPPLIER_CODE, A.COOP_CATEGORY';
    
      OPEN rc FOR v_exesql;
      LOOP
        FETCH rc
          INTO v_rcsupcode,
               v_rcfaccode,
               v_rccate,
               v_rcprocate,
               v_rcsubcate;
        EXIT WHEN rc%NOTFOUND;
      
        IF v_rcsupcode IS NOT NULL THEN
          --供应商产能预约
          p_idu_supcapcappdata_by_diffparam(v_supcode     => v_rcsupcode,
                                            v_faccode     => v_rcfaccode,
                                            v_cate        => v_rccate,
                                            v_operid      => v_updateid,
                                            v_opertime    => v_updatetime,
                                            v_issubtabupd => 0,
                                            v_compid      => v_compid);
        
          --记录到剩余产能占比待更新表
          p_ins_faccode_into_tab(v_faccode => v_rcfaccode,
                                 v_compid  => v_compid);
        
          --下单规划
          p_idu_alorder_data_by_diffparam(v_supcode => v_rcsupcode,
                                          v_faccode => v_rcfaccode,
                                          v_cate    => v_rccate,
                                          v_procate => v_rcprocate,
                                          v_subcate => v_rcsubcate,
                                          v_compid  => v_compid);
        
          --周产能规划数据重算
          p_delete_wkplandata(v_supcode => v_rcsupcode,
                              v_faccode => v_rcfaccode,
                              v_cate    => v_rccate,
                              v_procate => v_rcprocate,
                              v_subcate => v_rcsubcate,
                              v_compid  => v_compid,
                              v_mindate => SYSDATE);
        END IF;
      END LOOP;
      CLOSE rc;
    
      v_exesql := 'SELECT MAX(SUPPLIER_CODE), MAX(COOP_CATEGORY) FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_tmpsupcode, v_tmpcate;
    
      IF v_tmpsupcode IS NOT NULL
         AND v_tmpcate IS NOT NULL THEN
        p_gen_wkplanrecalcrela(v_supcode  => v_tmpsupcode,
                               v_cate     => v_tmpcate,
                               v_operid   => v_updateid,
                               v_opertime => v_updatetime,
                               v_compid   => v_compid);
      END IF;
    END IF;
  
  END p_coopsupcfg_u_efflogic;

  /*===================================================================================
  
    品类合作供应商生效逻辑
  
    用途:
      品类合作供应商生效逻辑
  
    入参:
      V_QUEUEID    :  供应商编码
      V_COND       :  条件
      V_COMPID     :  企业Id
  
    版本:
      2022-03-08 : 品类合作供应商生效逻辑
      2022-08-11 : 品类合作供应商新增逻辑加入，原存储过程被拆分到修改逻辑
  
  ===================================================================================*/
  PROCEDURE p_coopcatesupcfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  
    v_method VARCHAR2(8);
  BEGIN
    SELECT MAX(vc_method)
      INTO v_method
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_method = 'INS' THEN
      p_coopsupcfg_i_efflogic(v_cond => v_cond);
    ELSIF v_method = 'UPD' THEN
      p_coopsupcfg_u_efflogic(v_queueid => v_queueid,
                              v_cond    => v_cond,
                              v_compid  => v_compid);
    END IF;
  END p_coopcatesupcfg_efflogic;

  /*===================================================================================
  
    品类合作生产工厂启停生效逻辑
  
    用途:
      品类合作生产工厂启停生效逻辑
  
    入参:
      V_COND         :  品类合作供应商配置Id
      V_COMPID       :  企业Id
      V_CURUSERID    :  动作发生时操作人Id
      V_HAPTIME      :  动作发生时间
      V_PAUSE        :  启停
  
    版本:
      2022-03-08 : 品类合作生产工厂启停生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_coopcatefaccfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_vnum       NUMBER(1);
    v_exesql     VARCHAR2(512);
    v_pausestr   VARCHAR2(1);
    v_rcsupcode  VARCHAR2(32);
    v_rcfaccode  VARCHAR2(32);
    v_rccate     VARCHAR2(2);
    v_rcprocate  VARCHAR2(4);
    v_rcsubcate  VARCHAR2(8);
    v_updateid   VARCHAR2(32);
    v_updatetime VARCHAR2(32);
    v_cate       VARCHAR2(2);
    v_supcode    VARCHAR2(32);
    v_faccode    VARCHAR2(32);
  BEGIN
    --获取 PAUSE, UPDATE_ID, UPDATE_TIME
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_pausestr,
           v_updateid,
           v_updatetime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_pausestr IS NOT NULL THEN
      IF v_updateid IS NULL THEN
        v_exesql := 'SELECT MAX(OPERATE_ID) FROM SCMDATA.T_COOP_SUPFAC_CFG_VIEW WHERE ' ||
                    v_cond;
        EXECUTE IMMEDIATE v_exesql
          INTO v_updateid;
      END IF;
    
      --VIEW 层生效到业务表
      v_exesql := 'UPDATE SCMDATA.T_COOPCATE_FACTORY_CFG SET PAUSE = ' ||
                  v_pausestr || ', UPDATE_ID = ''' || v_updateid ||
                  ''', UPDATE_TIME = TO_DATE(''' || v_updatetime ||
                  ''',''YYYY-MM-DD HH24-MI-SS'') WHERE ' || v_cond;
      EXECUTE IMMEDIATE v_exesql;
    
      IF v_pausestr = '1' THEN
        v_exesql := 'SELECT MAX(B.SUPPLIER_CODE), MAX(B.COOP_CATEGORY), MAX(A.FACTORY_CODE) ' ||
                    'FROM (SELECT FACTORY_CODE, CSC_ID, COMPANY_ID FROM SCMDATA.T_COOPCATE_FACTORY_CFG ' ||
                    'WHERE ' || v_cond ||
                    ' ) A INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG B ' ||
                    'ON A.CSC_ID = B.CSC_ID AND A.COMPANY_ID = B.COMPANY_ID';
        /*SCMDATA.P_PRINT_CLOB_INTO_CONSOLE(V_CLOB => V_EXESQL);*/
        EXECUTE IMMEDIATE v_exesql
          INTO v_supcode, v_cate, v_faccode;
      
        p_set_appcapcratetozero(v_supcode  => v_supcode,
                                v_faccode  => v_faccode,
                                v_cate     => v_cate,
                                v_operid   => v_updateid,
                                v_opertime => v_updatetime,
                                v_compid   => v_compid);
      END IF;
    
      --层级生效逻辑
      v_exesql := 'SELECT A.SUPPLIER_CODE, B.FACTORY_CODE, A.COOP_CATEGORY, A.COOP_PRODUCTCATE, A.COOP_SUBCATEGORY ' ||
                  'FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A INNER JOIN (SELECT CSC_ID,COMPANY_ID,FACTORY_CODE,PAUSE FROM SCMDATA.T_COOPCATE_FACTORY_CFG WHERE ' ||
                  v_cond ||
                  ') B ON A.CSC_ID = B.CSC_ID AND A.COMPANY_ID = B.COMPANY_ID';
    
      EXECUTE IMMEDIATE v_exesql
        INTO v_rcsupcode, v_rcfaccode, v_rccate, v_rcprocate, v_rcsubcate;
    
      --供应商产能预约
      p_idu_supcapcappdata_by_diffparam(v_supcode     => v_rcsupcode,
                                        v_faccode     => v_rcfaccode,
                                        v_cate        => v_rccate,
                                        v_operid      => v_updateid,
                                        v_opertime    => v_updatetime,
                                        v_issubtabupd => 0,
                                        v_compid      => v_compid);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => v_rcfaccode,
                             v_compid  => v_compid);
    
      --下单规划
      p_idu_alorder_data_by_diffparam(v_supcode => v_rcsupcode,
                                      v_faccode => v_rcfaccode,
                                      v_cate    => v_rccate,
                                      v_procate => v_rcprocate,
                                      v_subcate => v_rcsubcate,
                                      v_compid  => v_compid);
    
      --周产能规划数据重算
      p_delete_wkplandata(v_supcode => v_rcsupcode,
                          v_faccode => v_rcfaccode,
                          v_cate    => v_rccate,
                          v_procate => v_rcprocate,
                          v_subcate => v_rcsubcate,
                          v_compid  => v_compid,
                          v_mindate => SYSDATE);
    
      p_gen_wkplanrecalcrela(v_supcode  => v_rcsupcode,
                             v_cate     => v_rccate,
                             v_operid   => v_updateid,
                             v_opertime => v_updatetime,
                             v_compid   => v_compid);
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_RCSUPCODE,
      V_CATE     => V_RCCATE,
      V_OPERID   => V_UPDATEID,
      V_OPERTIME => V_UPDATETIME,
      V_COMPID   => V_COMPID);*/
    END IF;
  END p_coopcatefaccfg_efflogic;

  /*===================================================================================
  
    标准工时配置生效计算逻辑
  
    用途:
      用于标准工时配置生效计算逻辑
  
    入参:
      V_COMPID    :  企业Id
      V_COND      :  条件
  
    版本:
      2022-03-03 : 标准工时配置生效计算逻辑
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_eff_calclogic
  (
    v_cond     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    v_exesql  CLOB;
    v_cate    VARCHAR2(32);
    v_procate VARCHAR2(32);
    v_subcate VARCHAR2(32);
  BEGIN
    v_exesql := 'SELECT MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SUBCATEGORY) FROM SCMDATA.T_STANDARD_WORK_MINTE_CFG WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_cate, v_procate, v_subcate;
  
    FOR x IN (SELECT a.supplier_code,
                     b.factory_code,
                     a.company_id,
                     a.coop_category,
                     a.coop_productcate,
                     a.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a
               INNER JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.coop_category = v_cate
                 AND a.coop_productcate = v_procate
                 AND a.coop_subcategory = v_subcate
                 AND a.company_id = v_compid
               ORDER BY a.supplier_code,
                        a.coop_category,
                        a.company_id) LOOP
      --供应商产能预约
      p_idu_supcapcappdata_by_diffparam(v_supcode  => x.supplier_code,
                                        v_faccode  => x.factory_code,
                                        v_cate     => x.coop_category,
                                        v_operid   => v_operid,
                                        v_opertime => v_opertime,
                                        v_compid   => x.company_id);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => x.factory_code,
                             v_compid  => x.company_id);
    
      --周产能规划数据重算
      p_delete_wkplandata(v_supcode => x.supplier_code,
                          v_faccode => x.factory_code,
                          v_cate    => x.coop_category,
                          v_procate => x.coop_productcate,
                          v_subcate => x.coop_subcategory,
                          v_compid  => x.company_id,
                          v_mindate => SYSDATE);
    END LOOP;
  
    FOR y IN (SELECT DISTINCT supplier_code,
                              coop_category,
                              company_id
                FROM scmdata.t_coopcate_supplier_cfg
               WHERE coop_category = v_cate
                 AND company_id = v_compid) LOOP
      p_gen_wkplanrecalcrela(v_supcode  => y.supplier_code,
                             v_cate     => y.coop_category,
                             v_operid   => v_operid,
                             v_opertime => v_opertime,
                             v_compid   => y.company_id);
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => Y.SUPPLIER_CODE,
      V_CATE     => Y.COOP_CATEGORY,
      V_OPERID   => V_OPERID,
      V_OPERTIME => V_OPERTIME,
      V_COMPID   => Y.COMPANY_ID);*/
    END LOOP;
  END p_stdwtcfg_eff_calclogic;

  /*===================================================================================
  
    标准工时配置修改生效到业务表
  
    用途:
      用于标准工时配置修改生效到业务表
  
    入参:
      V_COND      :  条件
      V_CATE      :  分类Id
      V_PROCATE   :  生产分类Id
      V_SUBCATE   :  子类Id
      V_STDWKT    :  标准工时
      V_USERID    :  操作人Id
      V_UPDTIME   :  操作时间
  
    版本:
      2022-03-03 : 标准工时配置修改生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_upd_efftotab
  (
    v_cond    IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_stdwkt  IN VARCHAR2,
    v_userid  IN VARCHAR2,
    v_updtime IN VARCHAR2
  ) IS
    v_partesql CLOB;
    v_exesql   CLOB := 'UPDATE SCMDATA.T_STANDARD_WORK_MINTE_CFG SET ';
  BEGIN
    IF v_cate IS NOT NULL THEN
      v_partesql := ',CATEGORY = ''' || v_cate || '''';
    END IF;
  
    IF v_procate IS NOT NULL THEN
      v_partesql := v_partesql || ',PRODUCT_CATE = ''' || v_procate || '''';
    END IF;
  
    IF v_subcate IS NOT NULL THEN
      v_partesql := v_partesql || ',SUBCATEGORY = ''' || v_subcate || '''';
    END IF;
  
    IF v_procate IS NOT NULL THEN
      v_partesql := v_partesql || ',STANDARD_WORKTIME = ''' || v_stdwkt || '''';
    END IF;
  
    v_exesql := v_exesql || ltrim(v_partesql, ',') || ',UPDATE_ID=''' ||
                v_userid || ''',UPDATE_TIME=TO_DATE(''' || v_updtime ||
                ''',''YYYY-MM-DD HH24-MI-SS'') WHERE ' || v_cond;
  
    EXECUTE IMMEDIATE v_exesql;
  
  END p_stdwtcfg_upd_efftotab;

  /*===================================================================================
  
    标准工时配置新增生效到业务表
  
    用途:
      用于标准工时配置修改生效到业务表
  
    入参:
      V_SWMCID    :  标准工时配置表Id
      V_COMPID    :  企业Id
      V_CATE      :  分类Id
      V_PROCATE   :  生产分类Id
      V_SUBCATE   :  子类Id
      V_STDWKT    :  标准工时
      V_OPERID    :  操作人Id
      V_OPERTIME  :  操作时间
      V_COND      :  条件
  
    版本:
      2022-03-03 : 标准工时配置修改生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_ins_efftotab
  (
    v_swmcid   IN VARCHAR2,
    v_compid   IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_stdwkt   IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2
  ) IS
  
  BEGIN
    INSERT INTO scmdata.t_standard_work_minte_cfg
      (swmc_id, company_id, category, product_cate, subcategory, standard_worktime, create_id, create_time)
    VALUES
      (v_swmcid, v_compid, v_cate, v_procate, v_subcate, to_number(v_stdwkt), v_operid, to_date(v_opertime,
                'YYYY-MM-DD HH24-MI-SS'));
  
  END p_stdwtcfg_ins_efftotab;

  /*===================================================================================
  
    标准工时配置删除生效到业务表
  
    用途:
      用于标准工时配置删除生效到业务表
  
    入参:
      V_COND      :  条件
  
    版本:
      2022-03-03 : 标准工时配置删除生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_del_efftotab(v_cond IN VARCHAR2) IS
    v_exesql CLOB;
  BEGIN
    v_exesql := 'DELETE FROM SCMDATA.T_STANDARD_WORK_MINTE_CFG WHERE ' ||
                v_cond;
  
    EXECUTE IMMEDIATE v_exesql;
  
    v_exesql := 'DELETE FROM SCMDATA.T_STANDARD_WORK_MINTE_CFG_VIEW WHERE ' ||
                v_cond;
  
    EXECUTE IMMEDIATE v_exesql;
  
  END p_stdwtcfg_del_efftotab;

  /*===================================================================================
  
    标准工时配置异常(CPS变更，数据删除)生效逻辑
  
    用途:
      用于标准工时配置修改生效到业务表
  
    入参:
      V_CATE      :  分类Id
      V_PROCATE   :  生产分类Id
      V_SUBCATE   :  子类Id
      V_OPERID    :  操作人Id
      V_OPERTIME  :  操作时间
      V_COMPID    :  企业Id
  
    版本:
      2022-05-18 : 标准工时配置异常(CPS变更，数据删除)生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_abn_efflogic
  (
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    v_tmpsupcode       VARCHAR2(32);
    v_tmpcate          VARCHAR2(32);
    v_sumcapcceiling   NUMBER(16);
    v_sumappcapc       NUMBER(16);
    v_sumalocapc       NUMBER(16);
    v_sumplncapc       NUMBER(16);
    v_sumplscapc       NUMBER(16);
    v_sumcapcdiffwopln NUMBER(16);
    v_sumcapcdiffwipln NUMBER(16);
    v_sumcapcdiffwipls NUMBER(16);
    v_warningdays      NUMBER(2);
  BEGIN
    FOR x IN (SELECT DISTINCT a.supplier_code,
                              b.factory_code,
                              a.company_id,
                              a.coop_category,
                              a.coop_productcate,
                              a.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a
               INNER JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.coop_category = v_cate
                 AND a.coop_productcate = v_procate
                 AND a.coop_subcategory = v_subcate
                 AND a.company_id = v_compid) LOOP
      --周产能规划数据删除
      p_delete_wkplandata(v_supcode => x.supplier_code,
                          v_faccode => x.factory_code,
                          v_cate    => x.coop_category,
                          v_procate => x.coop_productcate,
                          v_subcate => x.coop_subcategory,
                          v_compid  => x.company_id,
                          v_mindate => SYSDATE);
    
      --重算
      IF nvl(v_tmpsupcode, ' ') <> x.supplier_code
         OR nvl(v_tmpcate, ' ') <> x.coop_category THEN
        FOR y IN (SELECT swp_id,
                         company_id
                    FROM scmdata.t_supcapacity_week_plan
                   WHERE celling_capc IS NULL
                     AND supplier_code = x.supplier_code
                     AND category = x.coop_category
                     AND company_id = x.company_id) LOOP
          SELECT SUM(trunc(capacity_ceiling)),
                 SUM(trunc(app_capacity))
            INTO v_sumcapcceiling,
                 v_sumappcapc
            FROM scmdata.t_supcapcweekplan_sup_detail
           WHERE swp_id = y.swp_id
             AND company_id = y.company_id;
        
          SELECT SUM(trunc(tscd.alo_capacity * tswmc.standard_worktime)),
                 SUM(trunc(tscd.pln_capacity * tswmc.standard_worktime)),
                 SUM(trunc(tscd.pls_capacity * tswmc.standard_worktime)),
                 SUM(trunc(tscd.capc_diffwopln * tswmc.standard_worktime)),
                 SUM(trunc(tscd.capc_diffwipln * tswmc.standard_worktime)),
                 SUM(trunc(tscd.capc_diffwipls * tswmc.standard_worktime)),
                 COUNT(DISTINCT(CASE
                                  WHEN tscd.capc_diffwipls < 0 THEN
                                   trunc(tscd.day)
                                END))
            INTO v_sumalocapc,
                 v_sumplncapc,
                 v_sumplscapc,
                 v_sumcapcdiffwopln,
                 v_sumcapcdiffwipln,
                 v_sumcapcdiffwipls,
                 v_warningdays
            FROM scmdata.t_supcapcweekplan_cate_detail tscd
           INNER JOIN scmdata.t_standard_work_minte_cfg tswmc
              ON tscd.category = tswmc.category
             AND tscd.product_cate = tswmc.product_cate
             AND tscd.subcategory = tswmc.subcategory
             AND tscd.company_id = tswmc.company_id
           WHERE tscd.swp_id = y.swp_id
             AND tscd.company_id = y.company_id;
        
          --汇总数据到供应商周产能规划表
          UPDATE scmdata.t_supcapacity_week_plan
             SET celling_capc    = nvl(v_sumcapcceiling, 0),
                 appoint_capc    = nvl(v_sumappcapc, 0),
                 alord_capc      = nvl(v_sumalocapc, 0),
                 plannew_capc    = nvl(v_sumplncapc, 0),
                 plansupp_capc   = nvl(v_sumplscapc, 0),
                 capc_diff_wonew = nvl(v_sumcapcdiffwopln, 0),
                 capc_diff_winew = nvl(v_sumcapcdiffwipln, 0),
                 capc_diff_wipls = nvl(v_sumcapcdiffwipls, 0),
                 warning_days    = nvl(v_warningdays, 0),
                 update_id       = v_operid,
                 update_time     = to_date(v_opertime,
                                           'YYYY-MM-DD HH24-MI-SS')
           WHERE swp_id = y.swp_id
             AND company_id = y.company_id;
        END LOOP;
      END IF;
    
      v_tmpsupcode := x.supplier_code;
      v_tmpcate    := x.coop_category;
    END LOOP;
  END p_stdwtcfg_abn_efflogic;

  /*===================================================================================
  
    标准工时配置异常(CPS变更，数据删除)生效逻辑
  
    用途:
      用于标准工时配置修改生效到业务表
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业Id
      V_COND      :  条件
      V_METHOD    :  操作方式
  
    版本:
      2022-05-18 : 标准工时配置异常(CPS变更，数据删除)生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_stdwtcfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2
  ) IS
    v_vnum         NUMBER(1);
    v_vcswmcid     VARCHAR2(32);
    v_vccompid     VARCHAR2(32);
    v_vccate       VARCHAR2(2);
    v_vcprocate    VARCHAR2(4);
    v_vcsubcate    VARCHAR2(8);
    v_vcstdwktime  VARCHAR2(8);
    v_vccreid      VARCHAR2(32);
    v_vccretime    VARCHAR2(32);
    v_vcupdid      VARCHAR2(32);
    v_vcupdtime    VARCHAR2(32);
    v_rawcate      VARCHAR2(2);
    v_rawprocate   VARCHAR2(4);
    v_rawsubcate   VARCHAR2(8);
    v_rawstdwktime VARCHAR2(8);
    v_rawupdid     VARCHAR2(32);
    v_jugnum       NUMBER(1);
    v_exesql       VARCHAR2(4000);
  BEGIN
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'SWMC_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COMPANY_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_CATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUBCATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'STANDARD_WORKTIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_TIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_vcswmcid,
           v_vccompid,
           v_vccate,
           v_vcprocate,
           v_vcsubcate,
           v_vcstdwktime,
           v_vccreid,
           v_vccretime,
           v_vcupdid,
           v_vcupdtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    v_exesql := 'SELECT COUNT(1) FROM SCMDATA.T_STANDARD_WORK_MINTE_CFG_VIEW WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_jugnum;
  
    IF v_jugnum = 1 THEN
      v_exesql := 'SELECT MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SUBCATEGORY), MAX(STANDARD_WORKTIME), MAX(UPDATE_ID) FROM SCMDATA.T_STANDARD_WORK_MINTE_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_rawcate, v_rawprocate, v_rawsubcate, v_rawstdwktime, v_rawupdid;
    
      IF v_rawsubcate IS NULL THEN
        v_exesql := 'SELECT MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SUBCATEGORY), MAX(STANDARD_WORKTIME), MAX(OPERATE_ID) FROM SCMDATA.T_STANDARD_WORK_MINTE_CFG_VIEW WHERE ' ||
                    v_cond;
        EXECUTE IMMEDIATE v_exesql
          INTO v_rawcate, v_rawprocate, v_rawsubcate, v_rawstdwktime, v_rawupdid;
      END IF;
    
      IF v_rawupdid IS NULL THEN
        v_exesql := 'SELECT MAX(OPERATE_ID) FROM SCMDATA.T_STANDARD_WORK_MINTE_CFG_VIEW WHERE ' ||
                    v_cond;
        EXECUTE IMMEDIATE v_exesql
          INTO v_rawupdid;
      END IF;
    END IF;
  
    IF v_method = 'UPD'
       AND v_vcsubcate IS NOT NULL THEN
      --异常生效逻辑
      p_stdwtcfg_abn_efflogic(v_cate     => v_rawcate,
                              v_procate  => v_rawprocate,
                              v_subcate  => v_rawsubcate,
                              v_operid   => v_vcupdid,
                              v_opertime => v_vcupdtime,
                              v_compid   => v_compid);
    
      --生效到业务表
      p_stdwtcfg_upd_efftotab(v_cond    => v_cond,
                              v_cate    => nvl(v_vccate, v_rawcate),
                              v_procate => nvl(v_vcprocate, v_rawprocate),
                              v_subcate => nvl(v_vcsubcate, v_rawsubcate),
                              v_stdwkt  => nvl(v_vcstdwktime, v_rawstdwktime),
                              v_userid  => nvl(v_vcupdid, v_rawupdid),
                              v_updtime => v_vcupdtime);
    
      --重算
      p_stdwtcfg_eff_calclogic(v_cond     => v_cond,
                               v_operid   => nvl(v_vcupdid, v_rawupdid),
                               v_opertime => v_vcupdtime,
                               v_compid   => v_compid);
    ELSIF v_method = 'UPD'
          AND v_vcsubcate IS NULL
          AND v_vcstdwktime IS NOT NULL THEN
      --生效到业务表
      p_stdwtcfg_upd_efftotab(v_cond    => v_cond,
                              v_cate    => nvl(v_vccate, v_rawcate),
                              v_procate => nvl(v_vcprocate, v_rawprocate),
                              v_subcate => nvl(v_vcsubcate, v_rawsubcate),
                              v_stdwkt  => nvl(v_vcstdwktime, v_rawstdwktime),
                              v_userid  => nvl(v_vcupdid, v_rawupdid),
                              v_updtime => v_vcupdtime);
    
      --重算
      p_stdwtcfg_eff_calclogic(v_cond     => v_cond,
                               v_operid   => nvl(v_vcupdid, v_rawupdid),
                               v_opertime => v_vcupdtime,
                               v_compid   => v_compid);
    ELSIF v_method = 'INS' THEN
      --生效到业务表
      p_stdwtcfg_ins_efftotab(v_swmcid   => v_vcswmcid,
                              v_compid   => v_vccompid,
                              v_cate     => v_vccate,
                              v_procate  => v_vcprocate,
                              v_subcate  => v_vcsubcate,
                              v_stdwkt   => v_vcstdwktime,
                              v_operid   => v_vccreid,
                              v_opertime => v_vccretime);
    
      --重算
      p_stdwtcfg_eff_calclogic(v_cond     => v_cond,
                               v_operid   => v_vccreid,
                               v_opertime => v_vccretime,
                               v_compid   => v_compid);
    ELSIF v_method = 'DEL' THEN
      --生效到业务表
      p_stdwtcfg_del_efftotab(v_cond => v_cond);
    
      --重算
      p_stdwtcfg_abn_efflogic(v_cate     => v_vccate,
                              v_procate  => v_vcprocate,
                              v_subcate  => v_vcsubcate,
                              v_operid   => v_vcupdid,
                              v_opertime => v_vcupdtime,
                              v_compid   => v_compid);
    END IF;
  END p_stdwtcfg_efflogic;

  /*===================================================================================
  
    生产工厂产能预约配置修改生效逻辑
  
    用途:
      生产工厂产能预约配置修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  品类合作供应商配置Id
      V_COMPID       :  企业Id
  
    版本:
      2022-03-08 : 生产工厂产能预约配置修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_facappcapccfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_vnum            NUMBER(1);
    v_exesql          VARCHAR2(4000);
    v_appcapcrate     NUMBER(5, 2);
    v_restcapcrate    NUMBER(5, 2);
    v_appcapcratestr  VARCHAR2(5);
    v_updateid        VARCHAR2(32);
    v_updatetime      VARCHAR2(32);
    v_cate            VARCHAR2(2);
    v_supcode         VARCHAR2(32);
    v_faccode         VARCHAR2(32);
    v_tmprestcapcrate NUMBER(5, 2);
    v_tmpsupcode      VARCHAR2(32);
    v_tmpcate         VARCHAR2(2);
    v_accid           VARCHAR2(32);
  BEGIN
    --获取 APPCAPC_RATE, UPDATE_ID, UPDATE_TIME
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'APPCAPC_RATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'RESTCAPC_RATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_appcapcratestr,
           v_restcapcrate,
           v_updateid,
           v_updatetime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    v_appcapcrate := to_number(v_appcapcratestr);
  
    IF v_updateid IS NULL THEN
      v_exesql := 'SELECT MAX(OPERATE_ID) FROM SCMDATA.T_APP_CAPACITY_CFG_VIEW WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_updateid;
    END IF;
  
    --获取 SUPPLIER_CODE, FACTORY_CODE
    v_exesql := 'SELECT MAX(ACC_ID), MAX(CATEGORY), MAX(SUPPLIER_CODE), MAX(FACTORY_CODE) FROM SCMDATA.T_APP_CAPACITY_CFG WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_accid, v_cate, v_supcode, v_faccode;
  
    v_tmprestcapcrate := scmdata.pkg_capacity_management.f_get_restcapc_rate(v_cate    => v_cate,
                                                                             v_supcode => v_supcode,
                                                                             v_faccode => v_faccode,
                                                                             v_compid  => v_compid);
  
    UPDATE scmdata.t_app_capacity_cfg
       SET appcapc_rate  = v_appcapcrate,
           restcapc_rate = v_tmprestcapcrate,
           update_id     = v_updateid,
           update_time   = to_date(v_updatetime, 'YYYY-MM-DD HH24-MI-SS')
     WHERE acc_id = v_accid
       AND company_id = v_compid;
  
    UPDATE scmdata.t_app_capacity_cfg_view
       SET appcapc_rate  = v_appcapcrate,
           restcapc_rate = v_tmprestcapcrate,
           operate_id    = v_updateid,
           operate_time  = to_date(v_updatetime, 'YYYY-MM-DD HH24-MI-SS')
     WHERE acc_id = v_accid
       AND company_id = v_compid;
  
    --生产工厂产能预约配置该工厂剩余可用产能占比更新
    FOR x IN (SELECT acc_id,
                     category,
                     supplier_code,
                     factory_code,
                     company_id,
                     appcapc_rate
                FROM scmdata.t_app_capacity_cfg
               WHERE acc_id <> v_accid
                 AND factory_code = v_faccode
                 AND company_id = v_compid) LOOP
      --计算剩余产能占比
      v_tmprestcapcrate := scmdata.pkg_capacity_management.f_get_restcapc_rate(v_cate    => x.category,
                                                                               v_supcode => x.supplier_code,
                                                                               v_faccode => x.factory_code,
                                                                               v_compid  => x.company_id);
      --更新剩余产能占比
      UPDATE scmdata.t_app_capacity_cfg
         SET restcapc_rate = v_tmprestcapcrate
       WHERE acc_id = x.acc_id
         AND company_id = x.company_id;
    
      UPDATE scmdata.t_app_capacity_cfg_view
         SET restcapc_rate = v_tmprestcapcrate
       WHERE acc_id = x.acc_id
         AND company_id = x.company_id;
    END LOOP;
  
    --重算
    FOR y IN (SELECT DISTINCT a.supplier_code,
                              b.factory_code,
                              a.company_id,
                              a.coop_category,
                              a.coop_productcate,
                              a.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a
               INNER JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND b.factory_code = v_faccode
                 AND a.company_id = v_compid
               ORDER BY a.supplier_code,
                        a.coop_category,
                        a.company_id) LOOP
      --供应商产能预约重算
      p_idu_supcapcappdata_by_diffparam(v_supcode     => y.supplier_code,
                                        v_faccode     => y.factory_code,
                                        v_cate        => y.coop_category,
                                        v_operid      => v_updateid,
                                        v_opertime    => v_updatetime,
                                        v_issubtabupd => 0,
                                        v_compid      => y.company_id);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => y.factory_code,
                             v_compid  => y.company_id);
    
      --已下单重算
      p_idu_alorder_data_by_diffparam(v_supcode => y.supplier_code,
                                      v_faccode => y.factory_code,
                                      v_cate    => y.coop_category,
                                      v_procate => y.coop_productcate,
                                      v_subcate => y.coop_subcategory,
                                      v_compid  => y.company_id);
    
      --周产能规划预约产能占比更新重算
      IF nvl(v_tmpsupcode, ' ') <> y.supplier_code
         OR nvl(v_tmpcate, ' ') <> y.coop_category THEN
        p_gen_wkplanrecalcrela(v_supcode  => y.supplier_code,
                               v_cate     => y.coop_category,
                               v_operid   => v_updateid,
                               v_opertime => v_updatetime,
                               v_compid   => y.company_id);
        /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => Y.SUPPLIER_CODE,
        V_CATE     => Y.COOP_CATEGORY,
        V_OPERID   => V_UPDATEID,
        V_OPERTIME => V_UPDATETIME,
        V_COMPID   => Y.COMPANY_ID);*/
      END IF;
    
      v_tmpsupcode := y.supplier_code;
      v_tmpcate    := y.coop_category;
    END LOOP;
  
  END p_facappcapccfg_efflogic;

  /*===================================================================================
  
    SpecialLogic
    供应商-生产工厂级品类合作生产工厂启停更新
  
    入参:
      V_SUPCODE     :  供应商编码
      V_FACCODE     :  生产工厂编码
      V_COMPID      :  企业Id
      V_CALCCFCIDS  :  待生效的品类合作生产工厂Id
  
    出参:
      V_CALCCFCIDS  :  待生效的品类合作生产工厂Id
  
    版本:
      2022-08-09 : 供应商-生产工厂级品类合作生产工厂启停更新
  
  ===================================================================================*/
  PROCEDURE p_upd_sflevel_pause
  (
    v_supcode    IN VARCHAR2,
    v_faccode    IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_calccfcids IN OUT CLOB
  ) IS
    v_suppause NUMBER(1);
  BEGIN
    FOR l IN (SELECT cfc.cfc_id,
                     cfc.company_id,
                     cfc.factory_code,
                     csc.supplier_code,
                     csc.coop_category,
                     csc.coop_productcate,
                     csc.coop_subcategory,
                     cfc.pause
                FROM scmdata.t_coopcate_supplier_cfg csc
               INNER JOIN scmdata.t_coopcate_factory_cfg cfc
                  ON csc.csc_id = cfc.csc_id
                 AND csc.company_id = cfc.company_id
                LEFT JOIN scmdata.t_capacity_plan_category_cfg cpcc
                  ON csc.coop_category = cpcc.category
                 AND csc.coop_productcate = cpcc.product_cate
                 AND csc.coop_subcategory = cpcc.subcategory
                 AND csc.company_id = cpcc.company_id
               WHERE csc.supplier_code = v_supcode
                 AND cfc.factory_code = v_faccode
                 AND csc.company_id = v_compid) LOOP
      SELECT sign(decode(tsi.pause, 2, 0, tsi.pause) + tcs.pause +
                  tcf.pause) suppause
        INTO v_suppause
        FROM scmdata.t_supplier_info tsi
        LEFT JOIN scmdata.t_coop_scope tcs
          ON tsi.supplier_info_id = tcs.supplier_info_id
         AND tsi.company_id = tcs.company_id
        LEFT JOIN scmdata.t_coop_factory tcf
          ON tsi.supplier_info_id = tcf.supplier_info_id
         AND tsi.company_id = tcf.company_id
       WHERE tsi.supplier_code = v_supcode
         AND tcf.factory_code = v_faccode
         AND tsi.company_id = v_compid;
    
      IF l.pause <> v_suppause
         AND l.pause IS NOT NULL
         AND v_suppause IS NOT NULL THEN
        UPDATE scmdata.t_coopcate_factory_cfg
           SET pause   = v_suppause,
               is_show = v_suppause
         WHERE cfc_id = l.cfc_id
           AND company_id = l.company_id;
      
        v_calccfcids := f_sentence_append_rc(v_sentence   => v_calccfcids,
                                             v_appendstr  => l.cfc_id,
                                             v_middliestr => ',');
      END IF;
    END LOOP;
  END p_upd_sflevel_pause;

  /*========================================================================================
  
    供应商档案合作工厂被删除处理逻辑
  
    入参:
      v_inp_queue_id      :  队列Id
      v_inp_company_id    :  企业Id
    
    入出参: 
      v_iop_operate_id    :  操作人Id
      v_iop_operate_time  :  操作时间
  
    版本:
      2023-06-01 : 供应商档案合作工厂被删除处理逻辑
  
  ========================================================================================*/
  PROCEDURE p_supfac_efflogic_deleteexe
  (
    v_inp_queue_id     IN VARCHAR2,
    v_inp_company_id   IN VARCHAR2,
    v_iop_operate_id   IN OUT VARCHAR2,
    v_iop_operate_time IN OUT DATE
  ) IS
    v_supplier_code VARCHAR2(32);
    v_factory_code  VARCHAR2(32);
    v_company_id    VARCHAR2(32);
  BEGIN
    --获取供应商，生产工厂，企业Id，入队创建人
    SELECT MAX(supplier_code),
           MAX(factory_code),
           MAX(company_id),
           MAX(create_id),
           MAX(create_time)
      INTO v_supplier_code,
           v_factory_code,
           v_company_id,
           v_iop_operate_id,
           v_iop_operate_time
      FROM (SELECT CASE
                     WHEN ifl.ir_colname1 = 'SUPPLIER_CODE' THEN
                      ifl.ir_colvalue1
                     ELSE
                      NULL
                   END AS supplier_code,
                   CASE
                     WHEN ifl.ir_colname2 = 'FACTORY_CODE' THEN
                      ifl.ir_colvalue1
                     ELSE
                      NULL
                   END AS factory_code,
                   ifl.company_id,
                   que.create_id,
                   que.create_time
              FROM scmdata.t_queue_iflrows ifl
             INNER JOIN scmdata.t_queue que
                ON ifl.queue_id = que.queue_id
               AND ifl.company_id = que.company_id
             WHERE ifl.queue_id = v_inp_queue_id
               AND ifl.company_id = v_inp_company_id);
  
    --关联配置展开
    FOR i IN (SELECT csc.supplier_code,
                     cfc.factory_code,
                     csc.coop_category,
                     csc.coop_productcate,
                     csc.coop_subcategory,
                     csc.company_id,
                     cfc.cfc_id
                FROM scmdata.t_coopcate_supplier_cfg csc
               INNER JOIN scmdata.t_coopcate_factory_cfg cfc
                  ON csc.csc_id = cfc.csc_id
                 AND csc.company_id = cfc.company_id
               WHERE csc.supplier_code = v_supplier_code
                 AND cfc.factory_code = v_factory_code
                 AND csc.company_id = v_company_id) LOOP
      --品类合作生产工厂配置停用并不展示
      UPDATE scmdata.t_coopcate_factory_cfg cfc
         SET pause       = 1,
             is_show     = 1,
             update_id   = v_iop_operate_id,
             update_time = v_iop_operate_time
       WHERE cfc_id = i.cfc_id
         AND company_id = i.company_id;
    
      --供应商档案变更设置生产工厂预约产能占比为0
      p_supfilecg_setappcapcrate_to_zero(v_supcode  => i.supplier_code,
                                         v_faccode  => i.factory_code,
                                         v_cate     => i.coop_category,
                                         v_procate  => i.coop_productcate,
                                         v_subcate  => i.coop_subcategory,
                                         v_operid   => v_iop_operate_id,
                                         v_opertime => to_char(v_iop_operate_time,
                                                               'yyyy-mm-dd hh24-mi-ss'),
                                         v_compid   => i.company_id);
    
    END LOOP;
  
  END p_supfac_efflogic_deleteexe;

  /*===================================================================================
  
    effectivelogic
    供应商档案合作工厂生效逻辑
  
    入参:
      v_inp_queue_id  :  队列id
      v_inp_cond      :  唯一行条件
      v_inp_method    :  操作方式
      v_compid        :  企业id
  
    版本:
      2022-08-08 : 供应商档案合作工厂生效逻辑
      2022-09-01 : 增加建档时作为生产工厂产能配置数据生成逻辑
      2023-06-01 : 增加供应商档案修改是否本场字段导致合作工厂数据删除的处理逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfac_efflogic
  (
    v_inp_queue_id   IN VARCHAR2,
    v_inp_cond       IN VARCHAR2,
    v_inp_method     IN VARCHAR2,
    v_inp_company_id IN VARCHAR2
  ) IS
    v_supcode  VARCHAR2(32);
    v_faccode  VARCHAR2(32);
    v_compid   VARCHAR2(32);
    v_operid   VARCHAR2(32);
    v_opertime VARCHAR2(32);
    v_rawcreid VARCHAR2(32);
    v_rawupdid VARCHAR2(32);
    v_exesql   CLOB;
  BEGIN
    --是否删除判断
    IF v_inp_method = 'DEL' THEN
      --删除执行逻辑
      p_supfac_efflogic_deleteexe(v_inp_queue_id     => v_inp_queue_id,
                                  v_inp_company_id   => v_inp_company_id,
                                  v_iop_operate_id   => v_operid,
                                  v_iop_operate_time => v_opertime);
    ELSE
      --获取生产工厂编码，企业id
      v_exesql := 'SELECT MAX(SUP.SUPPLIER_CODE), MAX(FAC.FACTORY_CODE), MAX(FAC.COMPANY_ID), ' ||
                  'MAX(FAC.CREATE_ID), MAX(FAC.UPDATE_ID) FROM (SELECT SUPPLIER_INFO_ID,COMPANY_ID,' ||
                  'FACTORY_CODE,CREATE_ID,UPDATE_ID FROM SCMDATA.T_COOP_FACTORY WHERE ' ||
                  v_inp_cond ||
                  ') FAC INNER JOIN SCMDATA.T_SUPPLIER_INFO SUP ' ||
                  'ON FAC.SUPPLIER_INFO_ID = SUP.SUPPLIER_INFO_ID AND FAC.COMPANY_ID = ' ||
                  'SUP.COMPANY_ID';
    
      EXECUTE IMMEDIATE v_exesql
        INTO v_supcode, v_faccode, v_compid, v_rawcreid, v_rawupdid;
    
      --获取操作人，操作时间
      SELECT MAX(nvl(update_id, create_id)),
             MAX(nvl(update_time, create_time))
        INTO v_operid,
             v_opertime
        FROM (SELECT MAX(CASE
                           WHEN vc_col = 'CREATE_ID' THEN
                            vc_curval
                         END) create_id,
                     MAX(CASE
                           WHEN vc_col = 'CREATE_TIME' THEN
                            vc_curval
                         END) create_time,
                     MAX(CASE
                           WHEN vc_col = 'UPDATE_ID' THEN
                            vc_curval
                         END) update_id,
                     MAX(CASE
                           WHEN vc_col = 'UPDATE_TIME' THEN
                            vc_curval
                         END) update_time
                FROM scmdata.t_queue_valchange
               WHERE queue_id = v_inp_queue_id
                 AND company_id = v_inp_company_id);
    
      IF v_operid IS NULL THEN
        v_operid := nvl(v_rawupdid, v_rawcreid);
      END IF;
    
      p_supfilerelacg_refreshcfgdata(v_supcode  => v_supcode,
                                     v_faccode  => v_faccode,
                                     v_operid   => v_operid,
                                     v_opertime => v_opertime,
                                     v_compid   => v_compid);
    END IF;
  
    --合作工厂相关重算
    FOR i IN (SELECT csc.supplier_code,
                     cfc.factory_code,
                     csc.company_id,
                     csc.coop_category,
                     csc.coop_productcate,
                     csc.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg csc
               INNER JOIN scmdata.t_coopcate_factory_cfg cfc
                  ON csc.csc_id = cfc.csc_id
                 AND csc.company_id = cfc.company_id
               WHERE csc.supplier_code = v_supcode
                 AND cfc.factory_code = v_faccode
                 AND csc.company_id = v_compid) LOOP
      --供应商产能预约
      p_idu_supcapcappdata_by_diffparam(v_supcode     => i.supplier_code,
                                        v_faccode     => i.factory_code,
                                        v_cate        => i.coop_category,
                                        v_operid      => v_operid,
                                        v_opertime    => v_opertime,
                                        v_issubtabupd => 0,
                                        v_compid      => i.company_id);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => i.factory_code,
                             v_compid  => i.company_id);
    
      --下单规划
      p_idu_alorder_data_by_diffparam(v_supcode => i.supplier_code,
                                      v_faccode => i.factory_code,
                                      v_cate    => i.coop_category,
                                      v_procate => i.coop_productcate,
                                      v_subcate => i.coop_subcategory,
                                      v_compid  => i.company_id);
    
      --周产能规划数据重算
      p_delete_wkplandata(v_supcode => i.supplier_code,
                          v_faccode => i.factory_code,
                          v_cate    => i.coop_category,
                          v_procate => i.coop_productcate,
                          v_subcate => i.coop_subcategory,
                          v_compid  => i.company_id,
                          v_mindate => SYSDATE);
    
      p_gen_wkplanrecalcrela(v_supcode  => i.supplier_code,
                             v_cate     => i.coop_category,
                             v_operid   => v_operid,
                             v_opertime => v_opertime,
                             v_compid   => i.company_id);
    END LOOP;
  END p_supfac_efflogic;

  /*===================================================================================
  
    供应商开工通用配置新增生效到业务表
  
    用途:
      用于供应商开工通用配置新增生效到业务表
  
    入参:
      V_BRAID        :  分类Id
      V_PROVID       :  省Id
      V_CITYID       :  市Id
      V_COUNID       :  区Id
      V_FACCODE      :  生产工厂编码
      V_YEAR         :  年份
      V_WKNTWK       :  周不开工日期
      V_MTNTWK       :  月不开工日期
      V_YRNTWK       :  年不开工日期
      V_CREID        :  创建人Id
      V_CRETIME      :  创建时间
      V_COND         :  唯一行条件
  
    版本:
      2022-03-07 : 供应商开工通用配置新增生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_ins_viewefflogic
  (
    v_sswcid  IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_braid   IN VARCHAR2,
    v_provid  IN VARCHAR2,
    v_cityid  IN VARCHAR2,
    v_counid  IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_year    IN VARCHAR2,
    v_wkntwk  IN VARCHAR2,
    v_mtntwk  IN VARCHAR2,
    v_yrntwk  IN VARCHAR2,
    v_creid   IN VARCHAR2,
    v_cretime IN VARCHAR2
  ) IS
    v_vieweffsql VARCHAR2(4000);
    v_cols       VARCHAR2(1024) := 'SSWC_ID,COMPANY_ID';
    v_vals       VARCHAR2(2048) := '''' || v_sswcid || ''',''' || v_compid || '''';
  BEGIN
    IF v_braid IS NOT NULL THEN
      v_cols := v_cols || ',BRA_ID';
      v_vals := v_vals || ',''' || v_braid || '''';
    END IF;
  
    IF v_provid IS NOT NULL THEN
      v_cols := v_cols || ',PROVINCE_ID';
      v_vals := v_vals || ',''' || v_provid || '''';
    END IF;
  
    IF v_cityid IS NOT NULL THEN
      v_cols := v_cols || ',CITY_ID';
      v_vals := v_vals || ',''' || v_cityid || '''';
    END IF;
  
    IF v_counid IS NOT NULL THEN
      v_cols := v_cols || ',COUNTRY_ID';
      v_vals := v_vals || ',''' || v_counid || '''';
    END IF;
  
    IF v_faccode IS NOT NULL THEN
      v_cols := v_cols || ',FACTORY_CODE';
      v_vals := v_vals || ',''' || v_faccode || '''';
    END IF;
  
    IF v_year IS NOT NULL THEN
      v_cols := v_cols || ',YEAR';
      v_vals := v_vals || ',' || v_year;
    END IF;
  
    IF v_wkntwk IS NOT NULL THEN
      v_cols := v_cols || ',WEEK_NOT_WORK';
      v_vals := v_vals || ',''' || v_wkntwk || '''';
    END IF;
  
    IF v_mtntwk IS NOT NULL THEN
      v_cols := v_cols || ',MONTH_NOT_WORK';
      v_vals := v_vals || ',''' || v_mtntwk || '''';
    END IF;
  
    IF v_yrntwk IS NOT NULL THEN
      v_cols := v_cols || ',YEAR_NOT_WORK';
      v_vals := v_vals || ',''' || v_yrntwk || '''';
    END IF;
  
    v_cols := v_cols || ',CREATE_ID,CREATE_TIME';
    v_vals := v_vals || ',''' || v_creid || ''',TO_DATE(''' || v_cretime ||
              ''',''YYYY-MM-DD HH24-MI-SS'')';
  
    v_vieweffsql := 'INSERT INTO SCMDATA.T_SUPPLIER_START_WORK_CFG (' ||
                    v_cols || ') VALUES (' || v_vals || ')';
  
    EXECUTE IMMEDIATE v_vieweffsql;
  END p_startworkcfg_ins_viewefflogic;

  /*===================================================================================
  
    供应商开工通用配置修改生效到业务表
  
    用途:
      用于供应商开工通用配置修改生效到业务表
  
    入参:
      V_BRAID        :  分类Id
      V_PROVID       :  省Id
      V_CITYID       :  市Id
      V_COUNID       :  区Id
      V_FACCODE      :  生产工厂编码
      V_YEAR         :  年份
      V_WKNTWK       :  周不开工日期
      V_MTNTWK       :  月不开工日期
      V_YRNTWK       :  年不开工日期
      V_UPDID        :  修改人Id
      V_UPDTIME      :  修改时间
      V_COND         :  唯一行条件
  
    版本:
      2022-02-10 : 供应商开工通用配置修改生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_upd_viewefflogic
  (
    v_braid   IN VARCHAR2,
    v_provid  IN VARCHAR2,
    v_cityid  IN VARCHAR2,
    v_counid  IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_year    IN VARCHAR2,
    v_wkntwk  IN VARCHAR2,
    v_mtntwk  IN VARCHAR2,
    v_yrntwk  IN VARCHAR2,
    v_updid   IN VARCHAR2,
    v_updtime IN VARCHAR2,
    v_cond    IN VARCHAR2
  ) IS
    v_vieweffsql VARCHAR2(4000);
  BEGIN
    v_vieweffsql := 'UPDATE SCMDATA.T_SUPPLIER_START_WORK_CFG SET ';
  
    IF v_braid IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'BRA_ID = ''' || v_braid || ''',';
    END IF;
  
    IF v_provid IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'PROVINCE_ID = ''' || v_provid ||
                      ''',';
    END IF;
  
    IF v_cityid IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'CITY_ID = ''' || v_cityid || ''',';
    END IF;
  
    IF v_counid IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'COUNTRY_ID = ''' || v_counid ||
                      ''',';
    END IF;
  
    IF v_faccode IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'FACTORY_CODE = ''' || v_faccode ||
                      ''',';
    END IF;
  
    IF v_year IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'YEAR = ' || v_year || ',';
    END IF;
  
    IF v_wkntwk IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'WEEK_NOT_WORK = ''' || v_wkntwk ||
                      ''',';
    END IF;
  
    IF v_mtntwk IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'MONTH_NOT_WORK = ''' || v_mtntwk ||
                      ''',';
    END IF;
  
    IF v_yrntwk IS NOT NULL THEN
      v_vieweffsql := v_vieweffsql || 'YEAR_NOT_WORK = ''' || v_yrntwk ||
                      ''',';
    END IF;
  
    v_vieweffsql := v_vieweffsql || ' UPDATE_ID = ''' || v_updid ||
                    ''', UPDATE_TIME = TO_DATE(''' || v_updtime ||
                    ''', ''YYYY-MM-DD HH24-MI-SS'') WHERE ' || v_cond;
  
    EXECUTE IMMEDIATE v_vieweffsql;
  END p_startworkcfg_upd_viewefflogic;

  /*===================================================================================
  
    供应商开工通用配置删除生效到业务表
  
    用途:
      用于供应商开工通用配置删除生效到业务表
  
    入参:
      V_BRAID        :  分类Id
      V_PROVID       :  省Id
      V_CITYID       :  市Id
      V_COUNID       :  区Id
      V_FACCODE      :  生产工厂编码
      V_YEAR         :  年份
      V_WKNTWK       :  周不开工日期
      V_MTNTWK       :  月不开工日期
      V_YRNTWK       :  年不开工日期
      V_CREID        :  创建人Id
      V_CRETIME      :  创建时间
      V_COND         :  唯一行条件
  
    版本:
      2022-03-07 : 供应商开工通用配置删除生效到业务表
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_del_viewefflogic(v_cond IN VARCHAR2) IS
    v_exesql VARCHAR2(512);
  BEGIN
    v_exesql := 'DELETE FROM SCMDATA.T_SUPPLIER_START_WORK_CFG WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql;
  
    v_exesql := 'DELETE FROM SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql;
  END p_startworkcfg_del_viewefflogic;

  /*===================================================================================
  
    获取供应商开工通用配置涉及的供应商和生产工厂
  
    用途:
      获取供应商开工通用配置涉及的供应商和生产工厂
  
    入参:
      V_BRAID        :  分部Id
      V_PROVID       :  省Id
      V_CITYID       :  市Id
      V_COUNID       :  区Id
      V_FACCODE      :  生产工厂编码
      V_COMPID       :  企业Id
  
    版本:
      2022-03-08 : 获取供应商开工通用配置涉及的供应商和生产工厂
  
  ===================================================================================*/
  FUNCTION f_get_supstwkcfg_supfacsql
  (
    v_braid   IN VARCHAR2,
    v_provid  IN VARCHAR2,
    v_cityid  IN VARCHAR2,
    v_counid  IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_sql VARCHAR2(2048);
  BEGIN
    IF v_faccode IS NOT NULL THEN
      v_sql := 'SELECT A.SUPPLIER_CODE, B.FACTORY_CODE, A.COOP_CATEGORY, A.COOP_PRODUCTCATE, A.COOP_SUBCATEGORY FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A ' ||
               'INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG B ON A.CSC_ID = B.CSC_ID AND A.COMPANY_ID = B.COMPANY_ID ' ||
               'WHERE B.FACTORY_CODE = ''' || v_faccode ||
               ''' AND B.COMPANY_ID = ''' || v_compid ||
               ''' ORDER BY A.SUPPLIER_CODE, A.COOP_CATEGORY, A.COMPANY_ID';
    ELSIF v_faccode IS NULL
          AND v_provid IS NOT NULL
          AND v_braid IS NOT NULL THEN
      v_sql := 'SELECT A.SUPPLIER_CODE, B.FACTORY_CODE, A.COOP_CATEGORY, A.COOP_PRODUCTCATE, A.COOP_SUBCATEGORY FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A ' ||
               'INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG B ON A.CSC_ID = B.CSC_ID ' ||
               'AND A.COMPANY_ID = B.COMPANY_ID ' ||
               'WHERE A.COOP_CATEGORY = ''' || v_braid ||
               ''' AND EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_INFO ' ||
               'WHERE SUPPLIER_CODE = B.FACTORY_CODE AND COMPANY_ID = B.COMPANY_ID AND COMPANY_PROVINCE = ''' ||
               v_provid || ''' AND COMPANY_CITY = ''' || v_cityid ||
               ''' AND COMPANY_COUNTY = ''' || v_counid ||
               ''' AND COMPANY_ID = ''' || v_compid || ''')' ||
               ' ORDER BY A.SUPPLIER_CODE, A.COOP_CATEGORY, A.COMPANY_ID';
    ELSIF v_faccode IS NULL
          AND v_braid IS NULL
          AND v_provid IS NOT NULL THEN
      v_sql := 'SELECT A.SUPPLIER_CODE, B.FACTORY_CODE, A.COOP_CATEGORY, A.COOP_PRODUCTCATE, A.COOP_SUBCATEGORY FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A ' ||
               'INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG B ON A.CSC_ID = B.CSC_ID ' ||
               'AND A.COMPANY_ID = B.COMPANY_ID ' ||
               'WHERE EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_INFO ' ||
               'WHERE SUPPLIER_CODE = B.FACTORY_CODE AND COMPANY_ID = B.COMPANY_ID AND COMPANY_PROVINCE = ''' ||
               v_provid || ''' AND COMPANY_CITY = ''' || v_cityid ||
               ''' AND COMPANY_COUNTY = ''' || v_counid ||
               ''' AND COMPANY_ID = ''' || v_compid || ''')' ||
               ' ORDER BY A.SUPPLIER_CODE, A.COOP_CATEGORY, A.COMPANY_ID';
    ELSIF v_faccode IS NULL
          AND v_provid IS NULL
          AND v_braid IS NOT NULL THEN
      v_sql := 'SELECT A.SUPPLIER_CODE, B.FACTORY_CODE, A.COOP_CATEGORY, A.COOP_PRODUCTCATE, A.COOP_SUBCATEGORY FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG A ' ||
               'INNER JOIN SCMDATA.T_COOPCATE_FACTORY_CFG B ON A.CSC_ID = B.CSC_ID AND A.COMPANY_ID = B.COMPANY_ID ' ||
               'WHERE A.COOP_CATEGORY = ''' || v_braid ||
               ''' AND A.COMPANY_ID = ''' || v_compid || '''' ||
               ' ORDER BY A.SUPPLIER_CODE, A.COOP_CATEGORY, A.COMPANY_ID';
    END IF;
  
    RETURN v_sql;
  END f_get_supstwkcfg_supfacsql;

  /*===================================================================================
  
    供应商开工通用配置修改前置数据重算
  
    用途:
      用于供应商开工通用配置修改前置数据重算
  
    入参:
      V_COND      :  条件
      V_COMPID    :  企业Id
  
    版本:
      2022-03-08 : 供应商开工通用配置修改前置数据重算
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_rawdata_recalc
  (
    v_cond     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc           rctype;
    v_braid      VARCHAR2(2);
    v_provid     VARCHAR2(16);
    v_cityid     VARCHAR2(16);
    v_counid     VARCHAR2(16);
    v_faccode    VARCHAR2(32);
    v_year       NUMBER(4);
    v_exesql     CLOB;
    v_rcsupcode  VARCHAR2(32);
    v_rcfaccode  VARCHAR2(32);
    v_rccate     VARCHAR2(2);
    v_rcprocate  VARCHAR2(4);
    v_rcsubcate  VARCHAR2(8);
    v_tmpsupcode VARCHAR2(32);
    v_tmpcate    VARCHAR2(32);
  BEGIN
    v_exesql := 'SELECT MAX(BRA_ID), MAX(PROVINCE_ID), MAX(CITY_ID), MAX(COUNTRY_ID), MAX(FACTORY_CODE), MAX(YEAR) FROM SCMDATA.T_SUPPLIER_START_WORK_CFG WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_braid, v_provid, v_cityid, v_counid, v_faccode, v_year;
  
    v_exesql := 'UPDATE SCMDATA.T_SUPPLIER_START_WORK_CFG SET WEEK_NOT_WORK = NULL, MONTH_NOT_WORK = NULL, YEAR_NOT_WORK = NULL WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql;
  
    v_exesql := f_get_supstwkcfg_supfacsql(v_braid   => v_braid,
                                           v_provid  => v_provid,
                                           v_cityid  => v_cityid,
                                           v_counid  => v_counid,
                                           v_faccode => v_faccode,
                                           v_compid  => v_compid);
  
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO v_rcsupcode,
             v_rcfaccode,
             v_rccate,
             v_rcprocate,
             v_rcsubcate;
      EXIT WHEN rc%NOTFOUND;
    
      IF v_rcsupcode IS NOT NULL THEN
        --供应商产能预约
        p_idu_supcapcappdata_by_diffparam(v_supcode  => v_rcsupcode,
                                          v_faccode  => v_rcfaccode,
                                          v_cate     => v_rccate,
                                          v_operid   => v_operid,
                                          v_opertime => v_opertime,
                                          v_compid   => v_compid);
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => v_rcfaccode,
                               v_compid  => v_compid);
      
        --周产能规划数据重算
        IF nvl(v_tmpsupcode, ' ') <> v_rcsupcode
           OR nvl(v_tmpcate, ' ') <> v_rccate THEN
          p_gen_wkplanrecalcrela(v_supcode  => v_rcsupcode,
                                 v_cate     => v_rccate,
                                 v_operid   => v_operid,
                                 v_opertime => v_opertime,
                                 v_compid   => v_compid);
          /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_RCSUPCODE,
          V_CATE     => V_RCCATE,
          V_OPERID   => V_OPERID,
          V_OPERTIME => V_OPERTIME,
          V_COMPID   => V_COMPID);*/
        END IF;
      
        v_tmpsupcode := v_rcsupcode;
        v_tmpcate    := v_rccate;
      END IF;
    
    END LOOP;
    CLOSE rc;
  END p_startworkcfg_rawdata_recalc;

  /*===================================================================================
  
    供应商开工通用配置生效逻辑
  
    用途:
      用于供应商开工通用配置生效
  
    入参:
      V_QUEUEID   :  队列Id
      V_COMPID    :  企业Id
      V_COND      :  条件
      V_METHOD    :  变更方式 INS-新增 UPD-修改 DEL-删除
  
    版本:
      2022-03-08 : 供应商开工通用配置生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_startworkcfg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc           rctype;
    v_vnum       NUMBER(1);
    v_sswcid     VARCHAR2(32);
    v_compidvc   VARCHAR2(32);
    v_braid      VARCHAR2(2);
    v_provid     VARCHAR2(16);
    v_cityid     VARCHAR2(16);
    v_counid     VARCHAR2(16);
    v_faccode    VARCHAR2(32);
    v_year       VARCHAR2(4);
    v_wkntwk     VARCHAR2(32);
    v_mtntwk     VARCHAR2(128);
    v_yrntwk     VARCHAR2(3072);
    v_createid   VARCHAR2(32);
    v_createtime VARCHAR2(64);
    v_updateid   VARCHAR2(32);
    v_updatetime VARCHAR2(64);
    v_exesql     VARCHAR2(4000);
    v_rcsupcode  VARCHAR2(32);
    v_rcfaccode  VARCHAR2(32);
    v_rccate     VARCHAR2(2);
    v_rcprocate  VARCHAR2(4);
    v_rcsubcate  VARCHAR2(8);
    v_tmpsupcode VARCHAR2(32);
    v_tmpcate    VARCHAR2(2);
  BEGIN
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'SSWC_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COMPANY_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'BRA_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'YEAR' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PROVINCE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CITY_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COUNTRY_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'FACTORY_CODE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WEEK_NOT_WORK' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'MONTH_NOT_WORK' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'YEAR_NOT_WORK' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_TIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_sswcid,
           v_compidvc,
           v_braid,
           v_year,
           v_provid,
           v_cityid,
           v_counid,
           v_faccode,
           v_wkntwk,
           v_mtntwk,
           v_yrntwk,
           v_createid,
           v_createtime,
           v_updateid,
           v_updatetime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_updateid IS NULL THEN
      v_exesql := 'SELECT MAX(UPDATE_ID) FROM SCMDATA.T_SUPPLIER_START_WORK_CFG WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_updateid;
    
      IF v_updateid IS NULL THEN
        v_exesql := 'SELECT MAX(OPERATE_ID), MAX(TO_CHAR(OPERATE_TIME,''YYYY-MM-DD HH24-MI-SS'')) FROM SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW WHERE ' ||
                    v_cond;
        EXECUTE IMMEDIATE v_exesql
          INTO v_updateid, v_updatetime;
      END IF;
    END IF;
  
    IF v_method = 'UPD'
       AND (v_braid IS NOT NULL OR v_counid IS NOT NULL OR
       v_faccode IS NOT NULL OR v_year IS NOT NULL) THEN
      v_exesql := 'SELECT MAX(BRA_ID), MAX(YEAR), MAX(PROVINCE_ID), MAX(CITY_ID), MAX(COUNTRY_ID), MAX(FACTORY_CODE) ' ||
                  'FROM (SELECT NVL(TAB2.SSWC_ID, TAB1.SSWC_ID) SSWC_ID, NVL(TAB2.COMPANY_ID, TAB1.COMPANY_ID) COMPANY_ID, ' ||
                  'NVL(TAB2.BRA_ID, TAB1.BRA_ID) BRA_ID, NVL(TAB2.YEAR, TAB1.YEAR) YEAR, NVL(TAB2.PROVINCE_ID, TAB1.PROVINCE_ID) PROVINCE_ID, ' ||
                  'NVL(TAB2.CITY_ID, TAB1.CITY_ID) CITY_ID, NVL(TAB2.COUNTRY_ID, TAB1.COUNTRY_ID) COUNTRY_ID, ' ||
                  'NVL(TAB2.FACTORY_CODE, TAB1.FACTORY_CODE) FACTORY_CODE FROM SCMDATA.T_SUPPLIER_START_WORK_CFG TAB1 ' ||
                  'LEFT JOIN SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW TAB2 ON TAB1.SSWC_ID = TAB2.SSWC_ID AND TAB1.COMPANY_ID = TAB2.COMPANY_ID ' ||
                  'AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW WHERE SSWC_ID = TAB1.SSWC_ID ' ||
                  'AND COMPANY_ID = TAB1.COMPANY_ID AND OPERATE_METHOD = ''DEL'') UNION ALL SELECT SSWC_ID, COMPANY_ID, ' ||
                  'BRA_ID, YEAR, PROVINCE_ID, CITY_ID, COUNTRY_ID, FACTORY_CODE FROM SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW TAB3 ' ||
                  'WHERE OPERATE_METHOD <> ''DEL'' AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_START_WORK_CFG ' ||
                  'WHERE SSWC_ID = TAB3.SSWC_ID AND COMPANY_ID = TAB3.COMPANY_ID)) WHERE ' ||
                  v_cond;
    
      EXECUTE IMMEDIATE v_exesql
        INTO v_braid, v_year, v_provid, v_cityid, v_counid, v_faccode;
      p_startworkcfg_rawdata_recalc(v_cond     => v_cond,
                                    v_operid   => v_updateid,
                                    v_opertime => v_updatetime,
                                    v_compid   => v_compid);
    
      p_startworkcfg_upd_viewefflogic(v_braid   => v_braid,
                                      v_provid  => v_provid,
                                      v_cityid  => v_cityid,
                                      v_counid  => v_counid,
                                      v_faccode => v_faccode,
                                      v_year    => v_year,
                                      v_wkntwk  => v_wkntwk,
                                      v_mtntwk  => v_mtntwk,
                                      v_yrntwk  => v_yrntwk,
                                      v_updid   => v_updateid,
                                      v_updtime => v_updatetime,
                                      v_cond    => v_cond);
    ELSIF v_method = 'UPD'
          AND v_braid IS NULL
          AND v_counid IS NULL
          AND v_faccode IS NULL
          AND v_year IS NULL
          AND (v_wkntwk IS NOT NULL OR v_mtntwk IS NOT NULL OR
          v_yrntwk IS NOT NULL) THEN
      v_exesql := 'SELECT MAX(BRA_ID), MAX(YEAR), MAX(PROVINCE_ID), MAX(CITY_ID), MAX(COUNTRY_ID), MAX(FACTORY_CODE) ' ||
                  'FROM (SELECT NVL(TAB2.SSWC_ID, TAB1.SSWC_ID) SSWC_ID, NVL(TAB2.COMPANY_ID, TAB1.COMPANY_ID) COMPANY_ID, ' ||
                  'NVL(TAB2.BRA_ID, TAB1.BRA_ID) BRA_ID, NVL(TAB2.YEAR, TAB1.YEAR) YEAR, NVL(TAB2.PROVINCE_ID, TAB1.PROVINCE_ID) PROVINCE_ID, ' ||
                  'NVL(TAB2.CITY_ID, TAB1.CITY_ID) CITY_ID, NVL(TAB2.COUNTRY_ID, TAB1.COUNTRY_ID) COUNTRY_ID, ' ||
                  'NVL(TAB2.FACTORY_CODE, TAB1.FACTORY_CODE) FACTORY_CODE FROM SCMDATA.T_SUPPLIER_START_WORK_CFG TAB1 ' ||
                  'LEFT JOIN SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW TAB2 ON TAB1.SSWC_ID = TAB2.SSWC_ID AND TAB1.COMPANY_ID = TAB2.COMPANY_ID ' ||
                  'AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW WHERE SSWC_ID = TAB1.SSWC_ID ' ||
                  'AND COMPANY_ID = TAB1.COMPANY_ID AND OPERATE_METHOD = ''DEL'') UNION ALL SELECT SSWC_ID, COMPANY_ID, ' ||
                  'BRA_ID, YEAR, PROVINCE_ID, CITY_ID, COUNTRY_ID, FACTORY_CODE FROM SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW TAB3 ' ||
                  'WHERE OPERATE_METHOD <> ''DEL'' AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_START_WORK_CFG ' ||
                  'WHERE SSWC_ID = TAB3.SSWC_ID AND COMPANY_ID = TAB3.COMPANY_ID)) WHERE ' ||
                  v_cond;
    
      EXECUTE IMMEDIATE v_exesql
        INTO v_braid, v_year, v_provid, v_cityid, v_counid, v_faccode;
    
      p_startworkcfg_upd_viewefflogic(v_braid   => v_braid,
                                      v_provid  => v_provid,
                                      v_cityid  => v_cityid,
                                      v_counid  => v_counid,
                                      v_faccode => v_faccode,
                                      v_year    => v_year,
                                      v_wkntwk  => v_wkntwk,
                                      v_mtntwk  => v_mtntwk,
                                      v_yrntwk  => v_yrntwk,
                                      v_updid   => v_updateid,
                                      v_updtime => v_updatetime,
                                      v_cond    => v_cond);
    ELSIF v_method = 'INS' THEN
      p_startworkcfg_ins_viewefflogic(v_sswcid  => v_sswcid,
                                      v_compid  => v_compid,
                                      v_braid   => v_braid,
                                      v_provid  => v_provid,
                                      v_cityid  => v_cityid,
                                      v_counid  => v_counid,
                                      v_faccode => v_faccode,
                                      v_year    => v_year,
                                      v_wkntwk  => v_wkntwk,
                                      v_mtntwk  => v_mtntwk,
                                      v_yrntwk  => v_yrntwk,
                                      v_creid   => v_createid,
                                      v_cretime => v_createtime);
    ELSIF v_method = 'DEL' THEN
      v_exesql := 'SELECT MAX(BRA_ID), MAX(YEAR), MAX(PROVINCE_ID), MAX(CITY_ID), MAX(COUNTRY_ID), MAX(FACTORY_CODE) ' ||
                  'FROM (SELECT NVL(TAB2.SSWC_ID, TAB1.SSWC_ID) SSWC_ID, NVL(TAB2.COMPANY_ID, TAB1.COMPANY_ID) COMPANY_ID, ' ||
                  'NVL(TAB2.BRA_ID, TAB1.BRA_ID) BRA_ID, NVL(TAB2.YEAR, TAB1.YEAR) YEAR, NVL(TAB2.PROVINCE_ID, TAB1.PROVINCE_ID) PROVINCE_ID, ' ||
                  'NVL(TAB2.CITY_ID, TAB1.CITY_ID) CITY_ID, NVL(TAB2.COUNTRY_ID, TAB1.COUNTRY_ID) COUNTRY_ID, ' ||
                  'NVL(TAB2.FACTORY_CODE, TAB1.FACTORY_CODE) FACTORY_CODE FROM SCMDATA.T_SUPPLIER_START_WORK_CFG TAB1 ' ||
                  'LEFT JOIN SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW TAB2 ON TAB1.SSWC_ID = TAB2.SSWC_ID AND TAB1.COMPANY_ID = TAB2.COMPANY_ID ' ||
                  'AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW WHERE SSWC_ID = TAB1.SSWC_ID ' ||
                  'AND COMPANY_ID = TAB1.COMPANY_ID AND OPERATE_METHOD = ''DEL'') UNION ALL SELECT SSWC_ID, COMPANY_ID, ' ||
                  'BRA_ID, YEAR, PROVINCE_ID, CITY_ID, COUNTRY_ID, FACTORY_CODE FROM SCMDATA.T_SUPPLIER_START_WORK_CFG_VIEW TAB3 ' ||
                  'WHERE OPERATE_METHOD <> ''DEL'' AND NOT EXISTS (SELECT 1 FROM SCMDATA.T_SUPPLIER_START_WORK_CFG ' ||
                  'WHERE SSWC_ID = TAB3.SSWC_ID AND COMPANY_ID = TAB3.COMPANY_ID)) WHERE ' ||
                  v_cond;
    
      EXECUTE IMMEDIATE v_exesql
        INTO v_braid, v_year, v_provid, v_cityid, v_counid, v_faccode;
    
      p_startworkcfg_del_viewefflogic(v_cond => v_cond);
    END IF;
  
    v_exesql := f_get_supstwkcfg_supfacsql(v_braid   => v_braid,
                                           v_provid  => v_provid,
                                           v_cityid  => v_cityid,
                                           v_counid  => v_counid,
                                           v_faccode => v_faccode,
                                           v_compid  => v_compid);
  
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO v_rcsupcode,
             v_rcfaccode,
             v_rccate,
             v_rcprocate,
             v_rcsubcate;
      EXIT WHEN rc%NOTFOUND;
    
      IF v_rcsupcode IS NOT NULL THEN
        --供应商产能预约
        p_idu_supcapcappdata_by_diffparam(v_supcode  => v_rcsupcode,
                                          v_faccode  => v_rcfaccode,
                                          v_cate     => v_rccate,
                                          v_operid   => nvl(v_updateid,
                                                            v_createid),
                                          v_opertime => nvl(v_updatetime,
                                                            v_createtime),
                                          v_compid   => v_compid);
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => v_rcfaccode,
                               v_compid  => v_compid);
      
        --已下订单重算
        p_idu_alorder_data_by_diffparam(v_supcode => v_rcsupcode,
                                        v_faccode => v_rcfaccode,
                                        v_cate    => v_rccate,
                                        v_procate => v_rcprocate,
                                        v_subcate => v_rcsubcate,
                                        v_compid  => v_compid);
      
        --周产能规划数据重算
        IF nvl(v_tmpsupcode, ' ') <> v_rcsupcode
           OR nvl(v_tmpcate, ' ') <> v_rccate THEN
          p_gen_wkplanrecalcrela(v_supcode  => v_rcsupcode,
                                 v_cate     => v_rccate,
                                 v_operid   => nvl(v_updateid, v_createid),
                                 v_opertime => nvl(v_updatetime,
                                                   v_createtime),
                                 v_compid   => v_compid);
          /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_RCSUPCODE,
          V_CATE     => V_RCCATE,
          V_OPERID   => NVL(V_UPDATEID,V_CREATEID),
          V_OPERTIME => NVL(V_UPDATETIME,V_CREATETIME),
          V_COMPID   => V_COMPID);*/
        END IF;
      
        v_tmpsupcode := v_rcsupcode;
        v_tmpcate    := v_rccate;
      END IF;
    END LOOP;
    CLOSE rc;
  END p_startworkcfg_efflogic;

  /*===================================================================================
  
    供应商产能预约不开工日期修改生效逻辑
  
    用途:
      供应商产能预约不开工日期修改生效逻辑
  
    入参:
      V_QUEUEID        :  品类合作供应商配置Id
      V_COND           :  唯一行条件
      V_COMPID         :  企业Id
  
    版本:
      2022-02-22 : 供应商产能预约不开工日期修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcapcapp_notworkupd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_exesql        CLOB;
    v_vnum          NUMBER(1);
    v_vcnotworkdayr VARCHAR2(512);
    v_vcnotworkday  VARCHAR2(512);
    v_vcupdid       VARCHAR2(32);
    v_vcupdtime     VARCHAR2(32);
    v_ptcid         VARCHAR2(32);
    v_year          NUMBER(4);
    v_week          NUMBER(2);
    v_supcode       VARCHAR2(32);
    v_faccode       VARCHAR2(32);
    v_cate          VARCHAR2(2);
    v_jugnum        NUMBER(1);
    v_wkhour        NUMBER(4, 2);
    v_wknum         NUMBER(8);
    v_prodeff       NUMBER(5, 2);
    v_apprate       NUMBER(5, 2);
    v_appcapcrate   NUMBER(5, 2);
    v_capcceil      NUMBER(16, 2);
    v_appcapc       NUMBER(16, 2);
  BEGIN
    --生效到业务表部分
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'NOT_WORKDAY' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'NOT_WORKDAY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_vcnotworkdayr,
           v_vcnotworkday,
           v_vcupdid,
           v_vcupdtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_vcnotworkdayr IS NOT NULL
       OR v_vcnotworkday IS NOT NULL THEN
      IF v_vcupdid IS NULL THEN
        v_exesql := 'SELECT MAX(UPDATE_ID) FROM SCMDATA.T_SUPPLIER_CAPACITY_DETAIL WHERE ' ||
                    v_cond;
        EXECUTE IMMEDIATE v_exesql
          INTO v_vcupdid;
      END IF;
    
      v_exesql := 'SELECT MAX(PTC_ID), MAX(SUPPLIER_CODE), MAX(CATEGORY), MAX(FACTORY_CODE), MAX(YEAR), ' ||
                  'MAX(WEEK) FROM SCMDATA.T_SUPPLIER_CAPACITY_DETAIL WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_ptcid, v_supcode, v_cate, v_faccode, v_year, v_week;
    
      --更新至业务表
      v_exesql := 'UPDATE SCMDATA.T_SUPPLIER_CAPACITY_DETAIL SET NOT_WORKDAY = ''' ||
                  v_vcnotworkday || ''', UPDATE_ID = ''' || v_vcupdid ||
                  ''', UPDATE_TIME = TO_DATE(''' || v_vcupdtime ||
                  ''', ''YYYY-MM-DD HH24-MI-SS''), ' ||
                  'UPDATE_COMPANY_ID = ''' || v_compid || ''' WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql;
    
      --获取上班时数，车位人数，生产效率，预约产能占比
      SELECT MAX(wktime_num),
             MAX(wkperson_num),
             MAX(prod_eff),
             MAX(appcapc_rate)
        INTO v_wkhour,
             v_wknum,
             v_prodeff,
             v_apprate
        FROM scmdata.t_app_capacity_cfg
       WHERE supplier_code = v_supcode
         AND factory_code = v_faccode
         AND company_id = v_compid;
    
      --删除不开工日期
      FOR x IN (SELECT dd_date
                  FROM scmdata.t_day_dim
                 WHERE yearweek = v_year * 100 + v_week
                   AND instr(',' || v_vcnotworkday || ',',
                             ',' || dd_id || ',') > 0) LOOP
        DELETE FROM scmdata.t_capacity_appointment_detail_view tview
         WHERE EXISTS (SELECT 1
                  FROM scmdata.t_capacity_appointment_detail
                 WHERE ptc_id = v_ptcid
                   AND DAY = x.dd_date
                   AND company_id = v_compid
                   AND ctdd_id = tview.ctdd_id
                   AND company_id = tview.company_id);
      
        DELETE FROM scmdata.t_capacity_appointment_detail
         WHERE ptc_id = v_ptcid
           AND DAY = x.dd_date
           AND company_id = v_compid;
      END LOOP;
    
      --新增开工日期
      FOR y IN (SELECT dd_date
                  FROM scmdata.t_day_dim
                 WHERE yearweek = v_year * 100 + v_week
                   AND instr(',' || v_vcnotworkday || ',',
                             ',' || dd_id || ',') = 0) LOOP
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_capacity_appointment_detail
         WHERE ptc_id = v_ptcid
           AND trunc(DAY) = trunc(y.dd_date)
           AND company_id = v_compid;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_capacity_appointment_detail
            (ctdd_id, company_id, ptc_id, DAY, work_hour, work_people, appcapacity_rate, prod_effient, create_id, create_time, origin)
          VALUES
            (scmdata.f_get_uuid(), v_compid, v_ptcid, y.dd_date, nvl(v_wkhour,
                  0), nvl(v_wknum, 0), nvl(v_apprate, 0), nvl(v_prodeff, 0), v_vcupdid, to_date(v_vcupdtime,
                      'YYYY-MM-DD HH24-MI-SS'), 'SYS');
        END IF;
      END LOOP;
    
      --主表产能上限，约定产能重算
      scmdata.pkg_capacity_management.p_calculate_capacity_rela(v_ptcid       => v_ptcid,
                                                                v_compid      => v_compid,
                                                                v_capcceiling => v_capcceil,
                                                                v_appcapacity => v_appcapc);
    
      --更新主表
      IF v_capcceil <> 0
         AND v_capcceil IS NOT NULL THEN
        v_appcapcrate := v_appcapc / v_capcceil * 100;
      END IF;
    
      UPDATE scmdata.t_supplier_capacity_detail
         SET capacity_ceiling = v_capcceil,
             app_capacity     = v_appcapc,
             appcapacity_rate = v_appcapcrate,
             update_id        = v_vcupdid,
             update_time      = SYSDATE
       WHERE ptc_id = v_ptcid
         AND company_id = v_compid;
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => v_faccode, v_compid => v_compid);
    
      --周产能规划数据重算
      FOR z IN (SELECT DISTINCT supplier_code,
                                coop_category
                  FROM scmdata.t_coopcate_supplier_cfg
                 WHERE supplier_code = v_supcode
                   AND company_id = v_compid) LOOP
        p_gen_wkplanrecalcrela(v_supcode  => z.supplier_code,
                               v_cate     => z.coop_category,
                               v_operid   => v_vcupdid,
                               v_opertime => v_vcupdtime,
                               v_compid   => v_compid);
        /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => Z.SUPPLIER_CODE,
        V_CATE     => Z.COOP_CATEGORY,
        V_OPERID   => V_VCUPDID,
        V_OPERTIME => V_VCUPDTIME,
        V_COMPID   => V_COMPID);*/
      END LOOP;
    END IF;
  END p_supcapcapp_notworkupd_efflogic;

  /*===================================================================================
  
    供应商产能预约明细修改生效逻辑
  
    用途:
      用于供应商产能预约明细修改生效
  
    入参:
      V_QUEUEID        :  品类合作供应商配置Id
      V_COMPID         :  企业Id
  
    版本:
      2022-02-22 : 供应商产能预约明细修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcapcapp_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc             rctype;
    v_exesql       CLOB;
    v_vcworkhour   VARCHAR2(4);
    v_vcworkpeople VARCHAR2(8);
    v_vcapprate    VARCHAR2(5);
    v_vcprdeff     VARCHAR2(5);
    v_vcmemo       VARCHAR2(512);
    v_vcupdid      VARCHAR2(32);
    v_vcupdtime    VARCHAR2(32);
    v_rcsupcode    VARCHAR2(32);
    v_rcfaccode    VARCHAR2(32);
    v_rccate       VARCHAR2(2);
    v_rcprocate    VARCHAR2(4);
    v_rcsubcate    VARCHAR2(8);
    v_setvalstr    VARCHAR2(2048);
    v_tmpsupcode   VARCHAR2(32);
    v_tmpcate      VARCHAR2(2);
    v_ptcid        VARCHAR2(32);
    v_appcapcrate  NUMBER(5, 2);
    v_capcceil     NUMBER(16, 2);
    v_appcapc      NUMBER(16, 2);
    v_vnum         NUMBER(1);
  BEGIN
    --生效到业务表部分
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'WORK_HOUR' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WORK_PEOPLE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'APPCAPACITY_RATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PROD_EFFIENT' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'MEMO' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_vcworkhour,
           v_vcworkpeople,
           v_vcapprate,
           v_vcprdeff,
           v_vcmemo,
           v_vcupdid,
           v_vcupdtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_vcupdid IS NULL THEN
      v_exesql := 'SELECT MAX(UPDATE_ID), MAX(PTC_ID) FROM SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_vcupdid, v_ptcid;
    ELSE
      v_exesql := 'SELECT MAX(PTC_ID) FROM SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_ptcid;
    END IF;
  
    IF v_vcworkhour IS NOT NULL THEN
      v_setvalstr := v_setvalstr || ',' || 'WORK_HOUR = ' || v_vcworkhour;
    END IF;
  
    IF v_vcworkpeople IS NOT NULL THEN
      v_setvalstr := v_setvalstr || ',' || 'WORK_PEOPLE = ' ||
                     v_vcworkpeople;
    END IF;
  
    IF v_vcapprate IS NOT NULL THEN
      v_setvalstr := v_setvalstr || ',' || 'APPCAPACITY_RATE = ' ||
                     v_vcapprate;
    END IF;
  
    IF v_vcprdeff IS NOT NULL THEN
      v_setvalstr := v_setvalstr || ',' || 'PROD_EFFIENT = ' || v_vcprdeff;
    END IF;
  
    --更新至业务表
    v_exesql := 'UPDATE SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL SET ' ||
                ltrim(v_setvalstr, ',') || ', UPDATE_ID = ''' || v_vcupdid ||
                ''', UPDATE_TIME = TO_DATE(''' || v_vcupdtime ||
                ''', ''YYYY-MM-DD HH24-MI-SS''), UPDATE_COMPANY_ID = ''' ||
                v_compid || ''' WHERE ' || v_cond;
  
    EXECUTE IMMEDIATE v_exesql;
  
    --主表产能上限，约定产能重算
    scmdata.pkg_capacity_management.p_calculate_capacity_rela(v_ptcid       => v_ptcid,
                                                              v_compid      => v_compid,
                                                              v_capcceiling => v_capcceil,
                                                              v_appcapacity => v_appcapc);
  
    --更新主表
    IF v_capcceil <> 0
       AND v_capcceil IS NOT NULL THEN
      v_appcapcrate := v_appcapc / v_capcceil * 100;
    END IF;
  
    UPDATE scmdata.t_supplier_capacity_detail
       SET capacity_ceiling = v_capcceil,
           app_capacity     = v_appcapc,
           appcapacity_rate = v_appcapcrate,
           update_id        = v_vcupdid,
           update_time      = SYSDATE
     WHERE ptc_id = v_ptcid
       AND company_id = v_compid;
  
    v_exesql := 'SELECT B.SUPPLIER_CODE, B.FACTORY_CODE,
                        B.CATEGORY, C.COOP_PRODUCTCATE, C.COOP_SUBCATEGORY
                   FROM (SELECT * FROM SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL WHERE ' ||
                v_cond || ') A
                  INNER JOIN SCMDATA.T_SUPPLIER_CAPACITY_DETAIL B
                     ON A.PTC_ID = B.PTC_ID
                    AND A.COMPANY_ID = B.COMPANY_ID
                  INNER JOIN SCMDATA.T_COOPCATE_SUPPLIER_CFG C
                     ON B.SUPPLIER_CODE = C.SUPPLIER_CODE
                    AND B.CATEGORY = C.COOP_CATEGORY
                    AND B.COMPANY_ID = C.COMPANY_ID
                  WHERE EXISTS (SELECT 1
                           FROM SCMDATA.T_COOPCATE_FACTORY_CFG
                          WHERE FACTORY_CODE = B.FACTORY_CODE
                            AND COMPANY_ID = B.COMPANY_ID
                            AND CSC_ID = C.CSC_ID
                            AND COMPANY_ID = C.COMPANY_ID)';
  
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO v_rcsupcode,
             v_rcfaccode,
             v_rccate,
             v_rcprocate,
             v_rcsubcate;
      EXIT WHEN rc%NOTFOUND;
    
      IF v_rcsupcode IS NOT NULL THEN
        --供应商产能预约
        /*P_IDU_SUPCAPCAPPDATA_BY_DIFFPARAM(V_SUPCODE    => V_RCSUPCODE,
        V_FACCODE    => V_RCFACCODE,
        V_CATE       => V_RCCATE,
        V_OPERID     => V_VCUPDID,
        V_OPERTIME   => V_VCUPDTIME,
        V_COMPID     => V_COMPID);*/
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => v_rcfaccode,
                               v_compid  => v_compid);
      
        --周产能规划数据重算
        IF nvl(v_tmpsupcode, ' ') <> v_rcsupcode
           OR nvl(v_tmpcate, ' ') <> v_rccate THEN
          p_gen_wkplanrecalcrela(v_supcode  => v_rcsupcode,
                                 v_cate     => v_rccate,
                                 v_operid   => v_vcupdid,
                                 v_opertime => v_vcupdtime,
                                 v_compid   => v_compid);
          /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_RCSUPCODE,
          V_CATE     => V_RCCATE,
          V_OPERID   => V_VCUPDID,
          V_OPERTIME => V_VCUPDTIME,
          V_COMPID   => V_COMPID);*/
        END IF;
      
        v_tmpsupcode := v_rcsupcode;
        v_tmpcate    := v_rccate;
      END IF;
    
    END LOOP;
    CLOSE rc;
  END p_supcapcapp_upd_efflogic;

  /*===================================================================================
  
    下单规划-生产排期预计新品数据新增修改生成逻辑
  
    用途:
      下单规划-生产排期预计新品数据新增修改生成逻辑
  
    用于:
      下单规划
  
    版本:
      2022-05-15 : 单规划-生产排期预计新品数据新增修改生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_iu_newprodsche_data_4plnp
  (
    v_pnid   IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum    NUMBER(1);
    v_startday  DATE;
    v_endday    DATE;
    v_effdaynum NUMBER(8);
    v_fwdaynum  NUMBER(8);
    v_pcwdaynum NUMBER(8);
    v_sumamt    NUMBER(16);
    v_amt       NUMBER(16);
    v_incnum    NUMBER(8);
  BEGIN
    --判断是否存在改记录下的生产排期数据
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_production_schedule
     WHERE pn_id = v_pnid
       AND company_id = v_compid
       AND rownum = 1;
  
    --删除当前周及以后的数据，当前周以前的数据保留
    IF v_jugnum > 0 THEN
      DELETE FROM scmdata.t_production_schedule
       WHERE pn_id = v_pnid
         AND DAY >= trunc(SYSDATE, 'IW')
         AND company_id = v_compid;
    
      DELETE FROM scmdata.t_production_schedule
       WHERE pn_id = v_pnid
         AND DAY >= trunc(SYSDATE, 'IW')
         AND company_id = v_compid;
    END IF;
  
    --生成数据
    FOR x IN (SELECT pn_id,
                     company_id,
                     category,
                     product_cate,
                     subcategory,
                     hotprodm_amount,
                     normprodm_amount,
                     hotprod_avgsale,
                     normprod_avgsale,
                     predord_date,
                     preddelv_date
                FROM scmdata.t_plan_newproduct tpn
               WHERE pn_id = v_pnid
                 AND company_id = v_compid
              /*AND EXISTS
                   (SELECT 1 FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG
                     WHERE SUPPLIER_CODE = TPN.SUPPLIER_CODE
                       AND COOP_CATEGORY = TPN.CATEGORY
                       AND COOP_PRODUCTCATE = TPN.PRODUCT_CATE
                       AND COOP_SUBCATEGORY = TPN.SUBCATEGORY
                       AND COMPANY_ID = TPN.COMPANY_ID
                       AND PAUSE = 0)
              AND EXISTS
                   (SELECT 1 FROM SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG
                     WHERE CATEGORY = TPN.CATEGORY
                       AND PRODUCT_CATE = TPN.PRODUCT_CATE
                       AND SUBCATEGORY = TPN.SUBCATEGORY
                       AND IN_PLANNING = 1)*/
              ) LOOP
      IF v_fwdaynum IS NULL
         OR v_pcwdaynum IS NULL THEN
        --当首单待料天数和后整及物流天数为空
        SELECT MAX(first_ord_mat_wait),
               MAX(pc_and_trans_wait)
          INTO v_fwdaynum,
               v_pcwdaynum
          FROM scmdata.t_product_cycle_cfg
         WHERE category = x.category
           AND product_cate = x.product_cate
           AND subcategory = x.subcategory
           AND company_id = x.company_id;
      
        v_fwdaynum  := nvl(v_fwdaynum, 0);
        v_pcwdaynum := nvl(v_pcwdaynum, 0);
      END IF;
    
      --开始日期，结束日期赋值
      v_startday := x.predord_date + 1 + v_fwdaynum;
      v_endday   := x.preddelv_date - v_pcwdaynum;
    
      IF v_startday = v_endday THEN
        v_endday := v_startday;
      END IF;
    
      --计算生效日期数
      v_effdaynum := to_number(v_endday - v_startday) + 1;
    
      IF v_effdaynum <= 0 THEN
        v_endday    := v_startday + 1;
        v_effdaynum := 1;
      END IF;
    
      --日生产数量
      SELECT SUM(product_amount)
        INTO v_incnum
        FROM scmdata.t_production_schedule
       WHERE pn_id = v_pnid
         AND company_id = v_compid;
    
      v_sumamt := nvl(x.hotprodm_amount, 0) * nvl(x.hotprod_avgsale, 0) +
                  nvl(x.normprodm_amount, 0) * nvl(x.normprod_avgsale, 0) -
                  nvl(v_incnum, 0);
    
      FOR z IN (SELECT dd_date
                  FROM scmdata.t_day_dim
                 WHERE dd_date BETWEEN v_startday AND v_endday) LOOP
        /*IF Z.DD_DATE = V_ENDDAY THEN
          V_AMT := V_SUMAMT - TRUNC(V_SUMAMT / V_EFFDAYNUM)*(V_EFFDAYNUM - 1);
        ELSE
          V_AMT := TRUNC(V_SUMAMT / V_EFFDAYNUM);
        
          IF V_AMT = 0 THEN
            IF Z.DD_DATE <= V_STARTDAY + V_EFFDAYNUM THEN
              V_AMT := 1;
            ELSE
              V_AMT := 0;
            END IF;
          END IF;
        END IF;*/
        IF z.dd_date = v_endday THEN
          IF trunc(v_sumamt / v_effdaynum) = 0 THEN
            v_amt := 0;
          ELSE
            v_amt := v_sumamt -
                     trunc(v_sumamt / v_effdaynum) * (v_effdaynum - 1);
          END IF;
        ELSE
          v_amt := trunc(v_sumamt / v_effdaynum);
        
          IF v_amt = 0 THEN
            IF trunc(z.dd_date) <= trunc(v_startday) + v_sumamt THEN
              v_amt := 1;
            END IF;
          END IF;
        END IF;
      
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_production_schedule
         WHERE pn_id = x.pn_id
           AND trunc(DAY) = trunc(z.dd_date)
           AND company_id = x.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_production_schedule
            (ps_id, company_id, pn_id, DAY, product_amount)
          VALUES
            (scmdata.f_get_uuid(), x.company_id, x.pn_id, trunc(z.dd_date), v_amt);
        ELSE
          UPDATE scmdata.t_production_schedule
             SET product_amount = v_amt
           WHERE pn_id = v_pnid
             AND trunc(DAY) = trunc(z.dd_date)
             AND company_id = x.company_id;
        END IF;
      END LOOP;
    END LOOP;
  END p_iu_newprodsche_data_4plnp;

  /*===================================================================================
  
    下单规划-生产排期预计补单数据新增修改生成逻辑
  
    用途:
      下单规划-生产排期预计补单数据新增修改生成逻辑
  
    用于:
      下单规划
  
    版本:
      2022-07-25 : 下单规划-生产排期预计补单数据新增修改生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_iu_newprodsche_data_4plns
  (
    v_pnsid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum    NUMBER(1);
    v_startday  DATE;
    v_endday    DATE;
    v_effdaynum NUMBER(8);
    v_fwdaynum  NUMBER(8);
    v_pcwdaynum NUMBER(8);
    v_sumamt    NUMBER(16);
    v_amt       NUMBER(16);
    v_incnum    NUMBER(8);
  BEGIN
    --判断是否存在改记录下的生产排期数据
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_production_schedule
     WHERE pns_id = v_pnsid
       AND company_id = v_compid
       AND rownum = 1;
  
    --删除当前周及以后的数据，当前周以前的数据保留
    IF v_jugnum > 0 THEN
      DELETE FROM scmdata.t_production_schedule
       WHERE pns_id = v_pnsid
         AND DAY >= trunc(SYSDATE, 'IW')
         AND company_id = v_compid;
    
      DELETE FROM scmdata.t_production_schedule_view
       WHERE pns_id = v_pnsid
         AND DAY >= trunc(SYSDATE, 'IW')
         AND company_id = v_compid;
    END IF;
  
    --生成数据
    FOR x IN (SELECT ps_id,
                     company_id,
                     category,
                     product_cate,
                     subcategory,
                     supplier_code,
                     preord_amount,
                     predord_date,
                     preddelv_date
                FROM scmdata.t_plannew_supplementary tps
               WHERE ps_id = v_pnsid
                 AND company_id = v_compid
              /*AND EXISTS
                   (SELECT 1 FROM SCMDATA.T_COOPCATE_SUPPLIER_CFG
                     WHERE SUPPLIER_CODE = TPS.SUPPLIER_CODE
                       AND COOP_CATEGORY = TPS.CATEGORY
                       AND COOP_PRODUCTCATE = TPS.PRODUCT_CATE
                       AND COOP_SUBCATEGORY = TPS.SUBCATEGORY
                       AND COMPANY_ID = TPS.COMPANY_ID
                       AND PAUSE = 0)
              AND EXISTS
                   (SELECT 1 FROM SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG
                     WHERE CATEGORY = TPS.CATEGORY
                       AND PRODUCT_CATE = TPS.PRODUCT_CATE
                       AND SUBCATEGORY = TPS.SUBCATEGORY
                       AND IN_PLANNING = 1)*/
              ) LOOP
      IF v_fwdaynum IS NULL
         OR v_pcwdaynum IS NULL THEN
        --当首单待料天数和后整及物流天数为空
        SELECT MAX(first_ord_mat_wait),
               MAX(pc_and_trans_wait)
          INTO v_fwdaynum,
               v_pcwdaynum
          FROM scmdata.t_product_cycle_cfg
         WHERE category = x.category
           AND product_cate = x.product_cate
           AND subcategory = x.subcategory
           AND company_id = x.company_id;
      
        v_fwdaynum  := nvl(v_fwdaynum, 0);
        v_pcwdaynum := nvl(v_pcwdaynum, 0);
      END IF;
    
      --开始日期，结束日期赋值
      v_startday := x.predord_date + 1 + v_fwdaynum;
      v_endday   := x.preddelv_date - v_pcwdaynum;
    
      IF v_startday = v_endday THEN
        v_endday := v_startday;
      END IF;
    
      --计算生效日期数
      v_effdaynum := to_number(v_endday - v_startday) + 1;
    
      IF v_effdaynum <= 0 THEN
        v_endday    := v_startday + 1;
        v_effdaynum := 1;
      END IF;
    
      --日生产数量
      SELECT SUM(product_amount)
        INTO v_incnum
        FROM scmdata.t_production_schedule
       WHERE pns_id = x.ps_id
         AND company_id = v_compid;
    
      v_sumamt := x.preord_amount - nvl(v_incnum, 0);
    
      IF v_sumamt > 0 THEN
        FOR z IN (SELECT dd_date
                    FROM scmdata.t_day_dim
                   WHERE dd_date BETWEEN v_startday AND v_endday) LOOP
          /*IF Z.DD_DATE = V_ENDDAY THEN
            V_AMT := V_SUMAMT - TRUNC(V_SUMAMT / V_EFFDAYNUM)*(V_EFFDAYNUM - 1);
          ELSE
            V_AMT := TRUNC(V_SUMAMT / V_EFFDAYNUM);
          
            IF V_AMT = 0 THEN
              IF Z.DD_DATE <= V_STARTDAY + V_EFFDAYNUM THEN
                V_AMT := 1;
              ELSE
                V_AMT := 0;
              END IF;
            END IF;
          END IF;*/
          IF z.dd_date = v_endday THEN
            IF trunc(v_sumamt / v_effdaynum) = 0 THEN
              v_amt := 0;
            ELSE
              v_amt := v_sumamt -
                       trunc(v_sumamt / v_effdaynum) * (v_effdaynum - 1);
            END IF;
          ELSE
            v_amt := trunc(v_sumamt / v_effdaynum);
          
            IF v_amt = 0 THEN
              IF trunc(z.dd_date) <= trunc(v_startday) + v_sumamt THEN
                v_amt := 1;
              END IF;
            END IF;
          END IF;
        
          SELECT COUNT(1)
            INTO v_jugnum
            FROM scmdata.t_production_schedule
           WHERE pns_id = x.ps_id
             AND DAY = z.dd_date
             AND company_id = x.company_id
             AND rownum = 1;
        
          IF v_jugnum = 0 THEN
            INSERT INTO scmdata.t_production_schedule
              (ps_id, company_id, pns_id, DAY, product_amount)
            VALUES
              (scmdata.f_get_uuid(), x.company_id, x.ps_id, trunc(z.dd_date), v_amt);
          ELSE
            UPDATE scmdata.t_production_schedule
               SET product_amount = v_amt
             WHERE pns_id = x.ps_id
               AND trunc(DAY) = trunc(z.dd_date)
               AND company_id = x.company_id;
          END IF;
        END LOOP;
      END IF;
    END LOOP;
  END p_iu_newprodsche_data_4plns;

  /*===================================================================================
  
    预计新品生效逻辑
  
    用途:
      用于预计新品生效
  
    入参:
      V_QUEUEID   :  队列Id
      V_COND      :  确认唯一行条件
      V_METHOD    :  修改方式：INS-新增 UPD-修改
      V_COMPID    :  企业Id
  
    版本:
      2022-02-24 :  用于预计新品生效
  
  ===================================================================================*/
  PROCEDURE p_plannew_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_vcpnid      VARCHAR2(32);
    v_vccompid    VARCHAR2(32);
    v_vccgstatus  VARCHAR2(4);
    v_vccate      VARCHAR2(2);
    v_vcprocate   VARCHAR2(4);
    v_vcsubcate   VARCHAR2(8);
    v_vcyear      VARCHAR2(4);
    v_vcseason    VARCHAR2(2);
    v_vcware      VARCHAR2(2);
    v_vcwastatus  VARCHAR2(8);
    v_vcsupcode   VARCHAR2(32);
    v_vcpoamt     VARCHAR2(4);
    v_vchpmamt    VARCHAR2(4);
    v_vcnpmamt    VARCHAR2(4);
    v_vcpodate    VARCHAR2(32);
    v_vcpddate    VARCHAR2(32);
    v_vchpasale   VARCHAR2(16);
    v_vcnpasale   VARCHAR2(16);
    v_vcmemo      VARCHAR2(512);
    v_vccreid     VARCHAR2(32);
    v_vccretime   VARCHAR2(32);
    v_vcupdid     VARCHAR2(32);
    v_vcupdtime   VARCHAR2(32);
    v_rawpnid     VARCHAR2(32);
    v_rawcompid   VARCHAR2(32);
    v_rawsupcode  VARCHAR2(32);
    v_rawcate     VARCHAR2(2);
    v_rawprocate  VARCHAR2(4);
    v_rawsubcate  VARCHAR2(8);
    v_rawyear     VARCHAR2(4);
    v_jugnum      NUMBER(1);
    v_wkcapcrealc NUMBER(1);
    v_vnum        NUMBER(1);
    v_exesql      CLOB;
  BEGIN
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PN_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COMPANY_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CHANGE_STATUS' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_CATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUBCATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'YEAR' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SEASON' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WARE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WAVEACT_STATUS' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUPPLIER_CODE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PREORD_AMOUNT' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'HOTPRODM_AMOUNT' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'NORMPRODM_AMOUNT' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PREDORD_DATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PREDDELV_DATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'HOTPROD_AVGSALE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'NORMPROD_AVGSALE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'MEMO' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_TIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_vcpnid,
           v_vccompid,
           v_vccgstatus,
           v_vccate,
           v_vcprocate,
           v_vcsubcate,
           v_vcyear,
           v_vcseason,
           v_vcware,
           v_vcwastatus,
           v_vcsupcode,
           v_vcpoamt,
           v_vchpmamt,
           v_vcnpmamt,
           v_vcpodate,
           v_vcpddate,
           v_vchpasale,
           v_vcnpasale,
           v_vcmemo,
           v_vccreid,
           v_vccretime,
           v_vcupdid,
           v_vcupdtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    --获取周产能规划是否需要重算
    v_wkcapcrealc := f_get_isrecalc_weekplancapc(v_queueid => v_queueid,
                                                 v_compid  => v_compid);
  
    IF v_vcupdid IS NULL THEN
      v_exesql := 'SELECT MAX(OPERATE_ID) FROM SCMDATA.T_PLAN_NEWPRODUCT_VIEW WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_vcupdid;
    END IF;
  
    IF v_method = 'INS' THEN
      --新增进入业务表
      INSERT INTO scmdata.t_plan_newproduct
        (pn_id, company_id, change_status, category, product_cate, subcategory, YEAR, season, ware, waveact_status, supplier_code, preord_amount, hotprodm_amount, normprodm_amount, predord_date, preddelv_date, hotprod_avgsale, normprod_avgsale, memo, create_id, create_time)
      VALUES
        (v_vcpnid, v_vccompid, v_vccgstatus, v_vccate, v_vcprocate, v_vcsubcate, v_vcyear, v_vcseason, v_vcware, v_vcwastatus, v_vcsupcode, to_number(v_vcpoamt), to_number(v_vchpmamt), to_number(v_vcnpmamt), to_date(v_vcpodate,
                  'YYYY-MM-DD HH24-MI-SS'), to_date(v_vcpddate,
                  'YYYY-MM-DD HH24-MI-SS'), to_number(v_vchpasale), to_number(v_vcnpasale), v_vcmemo, v_vccreid, to_date(v_vccretime,
                  'YYYY-MM-DD HH24-MI-SS'));
    
      --下单排期生成
      DELETE FROM scmdata.t_production_schedule_view
       WHERE pn_id = v_vcpnid
         AND company_id = v_vccompid;
    
      p_iu_newprodsche_data_4plnp(v_pnid   => v_vcpnid,
                                  v_compid => v_vccompid);
    
      --周产能规划生成
      IF nvl(v_wkcapcrealc, 1) = 0 THEN
        p_gen_wkplanrecalcrela(v_supcode  => v_vcsupcode,
                               v_cate     => v_vccate,
                               v_operid   => v_vccreid,
                               v_opertime => v_vccretime,
                               v_compid   => v_vccompid);
        /*P_IU_WEEKPLAN_DATA(V_SUPCODE   => V_VCSUPCODE,
        V_CATE      => V_VCCATE,
        V_OPERID    => V_VCCREID,
        V_OPERTIME  => TO_DATE(V_VCPDDATE,'YYYY-MM-DD HH24-MI-SS'),
        V_COMPID    => V_VCCOMPID);*/
      END IF;
    
    ELSIF v_method = 'UPD' THEN
      --获取 PN_ID
      v_exesql := 'SELECT COUNT(1) FROM SCMDATA.T_PLAN_NEWPRODUCT_VIEW WHERE ' ||
                  v_cond || ' AND ROWNUM = 1';
      EXECUTE IMMEDIATE v_exesql
        INTO v_jugnum;
    
      IF v_jugnum = 0 THEN
        v_exesql := 'SELECT MAX(PN_ID), MAX(COMPANY_ID), MAX(SUPPLIER_CODE), MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SUBCATEGORY), MAX(YEAR) ' ||
                    'FROM SCMDATA.T_PLAN_NEWPRODUCT WHERE ' || v_cond;
      ELSE
        v_exesql := 'SELECT MAX(PN_ID), MAX(COMPANY_ID), MAX(SUPPLIER_CODE), MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SUBCATEGORY), MAX(YEAR) ' ||
                    'FROM SCMDATA.T_PLAN_NEWPRODUCT_VIEW WHERE ' || v_cond;
      END IF;
    
      EXECUTE IMMEDIATE v_exesql
        INTO v_rawpnid, v_rawcompid, v_rawsupcode, v_rawcate, v_rawprocate, v_rawsubcate, v_rawyear;
    
      --更新进入业务表
      UPDATE scmdata.t_plan_newproduct tab
         SET change_status    = nvl(v_vccgstatus, tab.change_status),
             category         = nvl(v_vccate, tab.category),
             product_cate     = nvl(v_vcprocate, tab.product_cate),
             subcategory      = nvl(v_vcsubcate, tab.subcategory),
             YEAR             = nvl(v_vcyear, tab.year),
             season           = nvl(v_vcseason, tab.season),
             ware             = nvl(v_vcware, tab.ware),
             waveact_status   = nvl(v_vcwastatus, tab.waveact_status),
             supplier_code    = nvl(v_vcsupcode, tab.supplier_code),
             preord_amount    = nvl(to_number(v_vcpoamt), tab.preord_amount),
             hotprodm_amount  = nvl(to_number(v_vchpmamt),
                                    tab.hotprodm_amount),
             predord_date     = nvl(to_date(v_vcpodate,
                                            'YYYY-MM-DD HH24-MI-SS'),
                                    tab.predord_date),
             preddelv_date    = nvl(to_date(v_vcpddate,
                                            'YYYY-MM-DD HH24-MI-SS'),
                                    tab.preddelv_date),
             hotprod_avgsale  = nvl(to_number(v_vchpasale),
                                    tab.hotprod_avgsale),
             normprod_avgsale = nvl(to_number(v_vcnpasale),
                                    tab.normprod_avgsale),
             memo             = nvl(v_vcmemo, tab.memo),
             update_id        = v_vcupdid,
             update_time      = to_date(v_vcupdtime, 'YYYY-MM-DD HH24-MI-SS')
       WHERE pn_id = v_rawpnid
         AND company_id = v_rawcompid;
    
      --下单排期历史数据清除
      DELETE FROM scmdata.t_production_schedule
       WHERE pn_id = v_rawpnid
         AND company_id = v_rawcompid;
    
      --下单排期数据生成
      p_iu_newprodsche_data_4plnp(v_pnid   => v_rawpnid,
                                  v_compid => v_rawcompid);
    
      --周产能规划生成
      IF nvl(v_wkcapcrealc, 1) = 0 THEN
        FOR x IN (SELECT DISTINCT a.supplier_code,
                                  b.factory_code
                    FROM scmdata.t_coopcate_supplier_cfg a
                   INNER JOIN scmdata.t_coopcate_factory_cfg b
                      ON a.csc_id = b.csc_id
                     AND a.company_id = b.company_id
                   WHERE a.supplier_code = v_rawsupcode
                     AND a.coop_category = v_rawcate
                     AND a.coop_productcate = v_rawprocate
                     AND a.coop_subcategory = v_rawsubcate
                     AND a.company_id = v_compid) LOOP
          p_delete_wkplandata(v_supcode => v_rawsupcode,
                              v_faccode => x.factory_code,
                              v_cate    => v_rawcate,
                              v_procate => v_rawprocate,
                              v_subcate => v_rawsubcate,
                              v_compid  => v_compid,
                              v_mindate => SYSDATE);
        END LOOP;
      
        IF v_rawsupcode IS NOT NULL THEN
          p_gen_wkplanrecalcrela(v_supcode  => v_rawsupcode,
                                 v_cate     => v_rawcate,
                                 v_operid   => nvl(v_vcupdid, v_vccreid),
                                 v_opertime => nvl(v_vcupdtime, v_vccretime),
                                 v_compid   => v_compid);
          /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_RAWSUPCODE,
          V_CATE     => V_RAWCATE,
          V_OPERID   => NVL(V_VCUPDID,V_VCCREID),
          V_OPERTIME => NVL(V_VCUPDTIME,V_VCCRETIME),
          V_COMPID   => V_COMPID);*/
        END IF;
      
        IF v_vcsupcode IS NOT NULL THEN
          p_gen_wkplanrecalcrela(v_supcode  => v_vcsupcode,
                                 v_cate     => v_vccate,
                                 v_operid   => nvl(v_vcupdid, v_vccreid),
                                 v_opertime => nvl(v_vcupdtime, v_vccretime),
                                 v_compid   => v_compid);
          /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_VCSUPCODE,
          V_CATE     => V_VCCATE,
          V_OPERID   => NVL(V_VCUPDID,V_VCCREID),
          V_OPERTIME => NVL(V_VCUPDTIME,V_VCCRETIME),
          V_COMPID   => V_COMPID);*/
        END IF;
      END IF;
    END IF;
  END p_plannew_efflogic;

  /*===================================================================================
  
    预计补单生效逻辑
  
    用途:
      用于预计补单生效逻辑
  
    入参:
      V_QUEUEID   :  队列Id
      V_COND      :  确认唯一行条件
      V_METHOD    :  修改方式：INS-新增 UPD-修改
      V_COMPID    :  企业Id
  
    版本:
      2022-07-25 :  用于预计补单生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_plansupp_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_method  IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_vcpnsid     VARCHAR2(32);
    v_vccompid    VARCHAR2(32);
    v_vccate      VARCHAR2(2);
    v_vcprocate   VARCHAR2(4);
    v_vcsubcate   VARCHAR2(8);
    v_vcsupcode   VARCHAR2(32);
    v_vcpodate    VARCHAR2(32);
    v_vcpddate    VARCHAR2(32);
    v_vcpodamt    VARCHAR2(16);
    v_vcactstatus VARCHAR2(8);
    v_vccreid     VARCHAR2(32);
    v_vccretime   VARCHAR2(32);
    v_vcupdid     VARCHAR2(32);
    v_vcupdtime   VARCHAR2(32);
    v_rawpnsid    VARCHAR2(32);
    v_rawcompid   VARCHAR2(32);
    v_rawsupcode  VARCHAR2(32);
    v_rawcate     VARCHAR2(2);
    v_rawprocate  VARCHAR2(4);
    v_rawsubcate  VARCHAR2(8);
    v_jugnum      NUMBER(1);
    v_wkcapcrealc NUMBER(1);
    v_vnum        NUMBER(1);
    v_exesql      CLOB;
  BEGIN
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PS_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COMPANY_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_CATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUBCATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUPPLIER_CODE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PREDORD_DATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PREDDELV_DATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PREORD_AMOUNT' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'ACT_STATUS' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_TIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_vcpnsid,
           v_vccompid,
           v_vccate,
           v_vcprocate,
           v_vcsubcate,
           v_vcsupcode,
           v_vcpodate,
           v_vcpddate,
           v_vcpodamt,
           v_vcactstatus,
           v_vccreid,
           v_vccretime,
           v_vcupdid,
           v_vcupdtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    --获取周产能规划是否需要重算
    v_wkcapcrealc := f_get_isrecalc_weekplancapc(v_queueid => v_queueid,
                                                 v_compid  => v_compid);
  
    IF v_vcupdid IS NULL THEN
      v_exesql := 'SELECT MAX(OPERATE_ID) FROM SCMDATA.T_PLANNEW_SUPPLEMENTARY_VIEW WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_vcupdid;
    END IF;
  
    IF v_method = 'INS' THEN
      --新增进入业务表
      INSERT INTO scmdata.t_plannew_supplementary
        (ps_id, company_id, category, product_cate, subcategory, supplier_code, predord_date, preddelv_date, preord_amount, act_status, create_id, create_time)
      VALUES
        (v_vcpnsid, v_vccompid, v_vccate, v_vcprocate, v_vcsubcate, v_vcsupcode, to_date(v_vcpodate,
                  'YYYY-MM-DD HH24-MI-SS'), to_date(v_vcpddate,
                  'YYYY-MM-DD HH24-MI-SS'), to_number(nvl(v_vcpodamt, '0')), v_vcactstatus, v_vccreid, to_date(v_vccretime,
                  'YYYY-MM-DD HH24-MI-SS'));
    
      --下单排期生成
      p_iu_newprodsche_data_4plns(v_pnsid  => v_vcpnsid,
                                  v_compid => v_vccompid);
    
      --周产能规划生成
      IF nvl(v_wkcapcrealc, 1) = 0 THEN
        p_gen_wkplanrecalcrela(v_supcode  => v_vcsupcode,
                               v_cate     => v_vccate,
                               v_operid   => v_vccreid,
                               v_opertime => v_vccretime,
                               v_compid   => v_vccompid);
        /*P_IU_WEEKPLAN_DATA(V_SUPCODE   => V_VCSUPCODE,
        V_CATE      => V_VCCATE,
        V_OPERID    => V_VCCREID,
        V_OPERTIME  => V_VCPDDATE,
        V_COMPID    => V_VCCOMPID);*/
      END IF;
    
    ELSIF v_method = 'UPD' THEN
      --获取 PN_ID
      v_exesql := 'SELECT COUNT(1) FROM SCMDATA.T_PLANNEW_SUPPLEMENTARY_VIEW WHERE ' ||
                  v_cond || ' AND ROWNUM = 1';
      EXECUTE IMMEDIATE v_exesql
        INTO v_jugnum;
    
      IF v_jugnum = 0 THEN
        v_exesql := 'SELECT MAX(PN_ID), MAX(COMPANY_ID), MAX(SUPPLIER_CODE), MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SUBCATEGORY) ' ||
                    'FROM SCMDATA.T_PLANNEW_SUPPLEMENTARY WHERE ' || v_cond;
      ELSE
        v_exesql := 'SELECT MAX(PS_ID), MAX(COMPANY_ID), MAX(SUPPLIER_CODE), MAX(CATEGORY), MAX(PRODUCT_CATE), MAX(SUBCATEGORY) ' ||
                    'FROM SCMDATA.T_PLANNEW_SUPPLEMENTARY_VIEW WHERE ' ||
                    v_cond;
      END IF;
    
      EXECUTE IMMEDIATE v_exesql
        INTO v_rawpnsid, v_rawcompid, v_rawsupcode, v_rawcate, v_rawprocate, v_rawsubcate;
    
      --更新进入业务表
      UPDATE scmdata.t_plannew_supplementary tab
         SET category      = nvl(v_vccate, tab.category),
             product_cate  = nvl(v_vcprocate, tab.product_cate),
             subcategory   = nvl(v_vcsubcate, tab.subcategory),
             supplier_code = nvl(v_vcsupcode, tab.supplier_code),
             predord_date  = nvl(to_date(v_vcpodate, 'YYYY-MM-DD HH24-MI-SS'),
                                 tab.predord_date),
             preddelv_date = nvl(to_date(v_vcpddate, 'YYYY-MM-DD HH24-MI-SS'),
                                 tab.preddelv_date),
             preord_amount = to_number(nvl(nvl(v_vcpodamt, tab.preord_amount),
                                           0)),
             act_status    = nvl(v_vcactstatus, tab.act_status),
             update_id     = v_vcupdid,
             update_time   = to_date(v_vcupdtime, 'YYYY-MM-DD HH24-MI-SS')
       WHERE ps_id = v_rawpnsid
         AND company_id = v_rawcompid;
    
      --下单排期历史数据清除
      DELETE FROM scmdata.t_production_schedule
       WHERE pns_id = v_rawpnsid
         AND DAY >= trunc(SYSDATE, 'IW')
         AND company_id = v_rawcompid;
    
      DELETE FROM scmdata.t_production_schedule_view tmpview
       WHERE pns_id = v_rawpnsid
         AND DAY >= trunc(SYSDATE, 'IW')
         AND company_id = v_rawcompid
         AND NOT EXISTS
       (SELECT 1
                FROM scmdata.t_production_schedule
               WHERE pns_id = tmpview.pns_id
                 AND company_id = tmpview.company_id);
    
      --下单排期数据生成
      p_iu_newprodsche_data_4plns(v_pnsid  => v_rawpnsid,
                                  v_compid => v_rawcompid);
    
      --周产能规划生成
      IF nvl(v_wkcapcrealc, 1) = 0 THEN
        FOR x IN (SELECT DISTINCT a.supplier_code,
                                  b.factory_code
                    FROM scmdata.t_coopcate_supplier_cfg a
                   INNER JOIN scmdata.t_coopcate_factory_cfg b
                      ON a.csc_id = b.csc_id
                     AND a.company_id = b.company_id
                   WHERE a.supplier_code = v_rawsupcode
                     AND a.coop_category = v_rawcate
                     AND a.coop_productcate = v_rawprocate
                     AND a.coop_subcategory = v_rawsubcate
                     AND a.company_id = v_compid) LOOP
          p_delete_wkplandata(v_supcode => v_rawsupcode,
                              v_faccode => x.factory_code,
                              v_cate    => v_rawcate,
                              v_procate => v_rawprocate,
                              v_subcate => v_rawsubcate,
                              v_compid  => v_compid,
                              v_mindate => SYSDATE);
        END LOOP;
      
        IF v_rawsupcode IS NOT NULL THEN
          p_gen_wkplanrecalcrela(v_supcode  => v_rawsupcode,
                                 v_cate     => v_rawcate,
                                 v_operid   => nvl(v_vcupdid, v_vccreid),
                                 v_opertime => nvl(v_vcupdtime, v_vccretime),
                                 v_compid   => v_compid);
          /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_RAWSUPCODE,
          V_CATE     => V_RAWCATE,
          V_OPERID   => NVL(V_VCUPDID,V_VCCREID),
          V_OPERTIME => NVL(V_VCUPDTIME,V_VCCRETIME),
          V_COMPID   => V_COMPID);*/
        END IF;
      
        IF v_vcsupcode IS NOT NULL THEN
          p_gen_wkplanrecalcrela(v_supcode  => v_vcsupcode,
                                 v_cate     => v_vccate,
                                 v_operid   => nvl(v_vcupdid, v_vccreid),
                                 v_opertime => nvl(v_vcupdtime, v_vccretime),
                                 v_compid   => v_compid);
          /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_VCSUPCODE,
          V_CATE     => V_VCCATE,
          V_OPERID   => NVL(V_VCUPDID,V_VCCREID),
          V_OPERTIME => NVL(V_VCUPDTIME,V_VCCRETIME),
          V_COMPID   => V_COMPID);*/
        END IF;
      END IF;
    END IF;
  END p_plansupp_efflogic;

  /*===================================================================================
  
    ORDERED 修改生效逻辑
  
    用途:
      ORDERED 修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-26 : ORDERED 修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_ordered_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_ordid      VARCHAR2(32);
    v_faccode    VARCHAR2(32);
    v_cate       VARCHAR2(2);
    v_procate    VARCHAR2(4);
    v_subcate    VARCHAR2(8);
    v_operid     VARCHAR2(32) := 'ORDERCHANGE_ITF';
    v_opertime   VARCHAR2(32) := to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS');
    v_rawsupcode VARCHAR2(32);
    v_cursupcode VARCHAR2(32);
    v_vnum       NUMBER(1);
    v_exesql     CLOB;
  BEGIN
    v_exesql := 'SELECT MAX(A.ORDER_CODE),MAX(B.FACTORY_CODE),MAX(C.CATEGORY), MAX(C.PRODUCT_CATE), MAX(C.SAMLL_CATEGORY) FROM ' ||
                '(SELECT ORDER_CODE,COMPANY_ID,SUPPLIER_CODE FROM ' ||
                'SCMDATA.T_ORDERED WHERE ' || v_cond ||
                ') A INNER JOIN SCMDATA.T_ORDERS B ' ||
                'ON A.ORDER_CODE = B.ORDER_ID AND A.COMPANY_ID = B.COMPANY_ID ' ||
                'INNER JOIN SCMDATA.T_COMMODITY_INFO C ON B.GOO_ID = C.GOO_ID AND B.COMPANY_ID = C.COMPANY_ID';
  
    EXECUTE IMMEDIATE v_exesql
      INTO v_ordid, v_faccode, v_cate, v_procate, v_subcate;
  
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'SUPPLIER_CODE' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'SUPPLIER_CODE' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_rawsupcode,
           v_cursupcode
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_cursupcode IS NOT NULL THEN
      --删除周产能规划相关数据
      p_delete_wkplandata(v_supcode => v_rawsupcode,
                          v_faccode => v_faccode,
                          v_cate    => v_cate,
                          v_procate => v_procate,
                          v_subcate => v_subcate,
                          v_compid  => v_compid,
                          v_mindate => SYSDATE);
    
      IF v_rawsupcode IS NOT NULL THEN
        p_gen_wkplanrecalcrela(v_supcode  => v_rawsupcode,
                               v_cate     => v_cate,
                               v_operid   => v_operid,
                               v_opertime => v_opertime,
                               v_compid   => v_compid);
      END IF;
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_RAWSUPCODE,
      V_CATE     => V_CATE,
      V_OPERID   => V_OPERID,
      V_OPERTIME => V_OPERTIME,
      V_COMPID   => V_COMPID);*/
    
      p_gen_wkplanrecalcrela(v_supcode  => v_cursupcode,
                             v_cate     => v_cate,
                             v_operid   => v_operid,
                             v_opertime => v_opertime,
                             v_compid   => v_compid);
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_CURSUPCODE,
      V_CATE     => V_CATE,
      V_OPERID   => V_OPERID,
      V_OPERTIME => V_OPERTIME,
      V_COMPID   => V_COMPID);*/
    END IF;
  END p_ordered_upd_efflogic;

  /*===================================================================================
  
    ORDERS 修改生效逻辑
  
    用途:
      ORDERS 修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    出参:
      V_ORDID        :  订单号
  
    版本:
      2022-02-26 : ORDERS 修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_orders_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_supcode    VARCHAR2(32);
    v_faccode    VARCHAR2(32);
    v_ordid      VARCHAR2(32);
    v_cate       VARCHAR2(2);
    v_procate    VARCHAR2(32);
    v_subcate    VARCHAR2(32);
    v_rawfaccode VARCHAR2(32);
    v_vcoperid   VARCHAR2(32);
    v_vcopertime VARCHAR2(32);
    v_vnum       NUMBER(1);
    v_exesql     VARCHAR2(4000);
  BEGIN
    v_exesql := 'SELECT MAX(B.ORDER_CODE), MAX(B.SUPPLIER_CODE),MAX(A.FACTORY_CODE), ' ||
                'MAX(C.CATEGORY),MAX(C.PRODUCT_CATE),MAX(C.SAMLL_CATEGORY) ' ||
                'FROM (SELECT ORDER_ID, COMPANY_ID, FACTORY_CODE, GOO_ID ' ||
                'FROM SCMDATA.T_ORDERS WHERE ' || v_cond ||
                ') A INNER JOIN SCMDATA.T_ORDERED B ' ||
                'ON A.ORDER_ID = B.ORDER_CODE AND A.COMPANY_ID = B.COMPANY_ID ' ||
                'INNER JOIN SCMDATA.T_COMMODITY_INFO C ON A.GOO_ID = C.GOO_ID ' ||
                'AND B.COMPANY_ID = C.COMPANY_ID';
  
    EXECUTE IMMEDIATE v_exesql
      INTO v_ordid, v_supcode, v_faccode, v_cate, v_procate, v_subcate;
  
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'FACTORY_CODE' THEN
                  vc_rawval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_rawfaccode,
           v_vcoperid,
           v_vcopertime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_vcoperid IS NULL
       OR v_vcopertime IS NULL THEN
      v_vcoperid   := 'ADMIN';
      v_vcopertime := to_char(SYSDATE, 'YYYY-MM-DD HH24-MI-SS');
    END IF;
  
    --重算
    --下单规划
    IF v_rawfaccode IS NOT NULL THEN
      p_idu_alorder_data_by_diffparam(v_supcode => v_supcode,
                                      v_faccode => v_rawfaccode,
                                      v_cate    => v_cate,
                                      v_procate => v_procate,
                                      v_subcate => v_subcate,
                                      v_compid  => v_compid);
    END IF;
  
    p_idu_alorder_data_by_diffparam(v_supcode => v_supcode,
                                    v_faccode => v_faccode,
                                    v_cate    => v_cate,
                                    v_procate => v_procate,
                                    v_subcate => v_subcate,
                                    v_compid  => v_compid);
  
    --周产能规划数据重算
    IF v_rawfaccode IS NOT NULL THEN
      p_delete_wkplandata(v_supcode => v_supcode,
                          v_faccode => v_rawfaccode,
                          v_cate    => v_cate,
                          v_procate => v_procate,
                          v_subcate => v_subcate,
                          v_compid  => v_compid,
                          v_mindate => SYSDATE);
    END IF;
  
    p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                           v_cate     => v_cate,
                           v_operid   => v_vcoperid,
                           v_opertime => v_vcopertime,
                           v_compid   => v_compid);
    /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_SUPCODE,
    V_CATE     => V_CATE,
    V_OPERID   => V_VCOPERID,
    V_OPERTIME => V_VCOPERTIME,
    V_COMPID   => V_COMPID);*/
  END p_orders_upd_efflogic;

  /*===================================================================================
  
    ORDER 修改生效逻辑
  
    用途:
      ORDER 修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-26 : ORDER 修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_order_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  BEGIN
    --ORDERED 更新生效逻辑
    p_ordered_upd_efflogic(v_queueid => v_queueid,
                           v_cond    => v_cond,
                           v_compid  => v_compid);
  
    --ORDERS 更新生效逻辑
    p_orders_upd_efflogic(v_queueid => v_queueid,
                          v_cond    => v_cond,
                          v_compid  => v_compid);
  END p_order_upd_efflogic;

  /*===================================================================================
  
    供应商档案合作范围修改生效逻辑
  
    用途:
      用于供应商档案合作范围修改生效逻辑
  
    入参:
      V_QUEUEID   :  队列Id
      V_COND      :  唯一行条件
      V_COMPID    :  企业Id
  
    版本:
      2022-04-02  : 供应商档案合作范围修改生效逻辑
      2022-05-24  : 增加涉及供应商作为其他供应商生产工厂角色的生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcpscp_upd_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_rawcate     VARCHAR2(2);
    v_rawprocate  VARCHAR2(4);
    v_rawsubcate  VARCHAR2(4000);
    v_curcate     VARCHAR2(2);
    v_curprocate  VARCHAR2(4);
    v_cursubcate  VARCHAR2(4000);
    v_updid       VARCHAR2(32);
    v_tabupdid    VARCHAR2(32);
    v_updtime     VARCHAR2(32);
    v_supcode     VARCHAR2(32);
    v_lastsupcode VARCHAR2(32);
    v_cate        VARCHAR2(2);
    v_procate     VARCHAR2(4);
    v_sgsubcate   VARCHAR2(8);
    v_sttime      DATE;
    v_faccode     VARCHAR2(32);
    v_jugnum      NUMBER(1);
    v_vnum        NUMBER(1);
    v_exesql      VARCHAR2(4000);
  BEGIN
    -- 开始时间赋值
    v_sttime := SYSDATE;
  
    --获取修改的分类，生产分类，子类，更新人，更新时间
    SELECT 1,
           MAX(CASE
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
               END),
           MAX(CASE
                 WHEN vc_col = 'UDPATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_rawcate,
           v_curcate,
           v_rawprocate,
           v_curprocate,
           v_rawsubcate,
           v_cursubcate,
           v_updid,
           v_updtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    --获取关联供应商档案编号，表内现有更新人id
    v_exesql := 'SELECT MAX(B.SUPPLIER_CODE), MAX(A.UPDATE_ID), MAX(A.COOP_CLASSIFICATION), MAX(A.COOP_PRODUCT_CATE) ' ||
                'FROM (SELECT SUPPLIER_INFO_ID,COMPANY_ID,UPDATE_ID,COOP_CLASSIFICATION,COOP_PRODUCT_CATE FROM SCMDATA.T_COOP_SCOPE WHERE ' ||
                v_cond ||
                ') A INNER JOIN SCMDATA.T_SUPPLIER_INFO B ON A.SUPPLIER_INFO_ID = B.SUPPLIER_INFO_ID AND A.COMPANY_ID = B.COMPANY_ID';
    EXECUTE IMMEDIATE v_exesql
      INTO v_supcode, v_tabupdid, v_cate, v_procate;
  
    --确保 V_UPDID 一定有值
    IF v_updid IS NULL THEN
      v_updid := v_tabupdid;
    END IF;
  
    FOR x IN (SELECT regexp_substr(v_rawsubcate, '[^;]+', 1, LEVEL) col
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_rawsubcate, '\;') + 1) LOOP
      --修改原有配置为禁用
      FOR i IN (SELECT csc_id,
                       company_id
                  FROM scmdata.t_coopcate_supplier_cfg
                 WHERE supplier_code = v_supcode
                   AND coop_category = nvl(v_rawcate, v_cate)
                   AND coop_productcate = nvl(v_rawprocate, v_procate)
                   AND coop_subcategory = x.col
                   AND company_id = v_compid) LOOP
        UPDATE scmdata.t_coopcate_factory_cfg
           SET pause = 1
         WHERE csc_id = i.csc_id
           AND company_id = i.company_id;
      
        UPDATE scmdata.t_coopcate_supplier_cfg
           SET pause = 1
         WHERE csc_id = i.csc_id
           AND company_id = i.company_id;
      END LOOP;
    END LOOP;
  
    --生成数据补齐--判断是否影响
    FOR i IN (SELECT DISTINCT coop_category,
                              coop_productcate,
                              coop_subcategory,
                              supplier_code,
                              company_id
                FROM scmdata.t_coopcate_supplier_cfg
               WHERE coop_category = nvl(v_curcate, v_cate)
                 AND coop_productcate = nvl(v_curprocate, v_procate)
                 AND instr(v_cursubcate, coop_subcategory) > 0
                 AND company_id = v_compid) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_coop_factory a
       INNER JOIN scmdata.t_supplier_info b
          ON a.supplier_info_id = b.supplier_info_id
         AND a.company_id = b.company_id
       INNER JOIN scmdata.t_coop_scope c
          ON b.supplier_info_id = c.supplier_info_id
         AND b.company_id = c.company_id
       WHERE b.supplier_code = i.supplier_code
         AND c.coop_classification = i.coop_category
         AND c.coop_product_cate = i.coop_productcate
         AND instr(c.coop_subcategory, i.coop_subcategory) > 0
         AND a.factory_code = v_faccode
         AND a.company_id = i.company_id
         AND rownum = 1;
    
      IF v_jugnum > 0 THEN
        --生成数据补齐
        scmdata.pkg_capacity_management.p_ins_catecoopsup_data_onlyscps(v_supcode => i.supplier_code,
                                                                        v_cate    => i.coop_category,
                                                                        v_procate => i.coop_productcate,
                                                                        v_subcate => i.coop_subcategory,
                                                                        v_curid   => v_updid,
                                                                        v_compid  => i.company_id);
      
        scmdata.pkg_capacity_management.p_gen_appcapccfg_data_by_sup(v_supcode  => i.supplier_code,
                                                                     v_operid   => v_updid,
                                                                     v_opertime => v_updtime,
                                                                     v_compid   => i.company_id);
      END IF;
    END LOOP;
  
    IF v_sttime = SYSDATE THEN
      v_sttime := SYSDATE - 1 / (24 * 60 * 60);
    END IF;
  
    --MINUS 获取差异值
    FOR x IN (SELECT csc_id,
                     company_id
                FROM (SELECT csc_id,
                             factory_code,
                             company_id
                        FROM scmdata.t_coopcate_factory_cfg
                      MINUS
                      SELECT csc_id,
                             factory_code,
                             company_id
                        FROM scmdata.t_coopcate_factory_cfg AS OF TIMESTAMP v_sttime)
               WHERE factory_code = v_faccode
                 AND company_id = v_compid
              UNION ALL
              SELECT csc_id,
                     company_id
                FROM scmdata.t_coopcate_supplier_cfg
               WHERE supplier_code = v_supcode
                 AND coop_category = v_curcate
                 AND coop_productcate = v_curprocate
                 AND instr(v_cursubcate, coop_subcategory) > 0
                 AND company_id = v_compid) LOOP
      SELECT MAX(supplier_code),
             MAX(coop_subcategory)
        INTO v_supcode,
             v_sgsubcate
        FROM scmdata.t_coopcate_supplier_cfg
       WHERE csc_id = x.csc_id
         AND coop_category = v_curcate
         AND coop_productcate = v_curprocate
         AND instr(v_cursubcate, coop_subcategory) > 0
         AND company_id = x.company_id;
    
      IF v_supcode IS NOT NULL
         AND v_supcode <> nvl(v_lastsupcode, ' ') THEN
        --供应商产能预约
        scmdata.pkg_capacity_efflogic_prd.p_idu_supcapcappdata_by_diffparam(v_supcode  => v_supcode,
                                                                            v_faccode  => v_faccode,
                                                                            v_cate     => v_curcate,
                                                                            v_operid   => v_updid,
                                                                            v_opertime => v_updtime,
                                                                            v_compid   => v_compid);
      
        --记录到剩余产能占比待更新表
        scmdata.pkg_capacity_efflogic_prd.p_ins_faccode_into_tab(v_faccode => v_faccode,
                                                                 v_compid  => v_compid);
      
        --下单规划
        scmdata.pkg_capacity_efflogic_prd.p_idu_alorder_data_by_diffparam(v_supcode => v_supcode,
                                                                          v_faccode => v_faccode,
                                                                          v_cate    => v_curcate,
                                                                          v_procate => v_curprocate,
                                                                          v_subcate => v_sgsubcate,
                                                                          v_compid  => v_compid);
      
        --周产能规划数据重算
        scmdata.pkg_capacity_efflogic_prd.p_delete_wkplandata(v_supcode => v_supcode,
                                                              v_faccode => v_faccode,
                                                              v_cate    => v_curcate,
                                                              v_procate => v_curprocate,
                                                              v_subcate => v_sgsubcate,
                                                              v_compid  => v_compid,
                                                              v_mindate => SYSDATE);
      
        p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                               v_cate     => v_curcate,
                               v_operid   => v_updid,
                               v_opertime => v_updtime,
                               v_compid   => v_compid);
        /*SCMDATA.PKG_CAPACITY_EFFLOGIC_prd.P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_SUPCODE,
        V_CATE     => V_CURCATE,
        V_OPERID   => V_UPDID,
        V_OPERTIME => V_UPDTIME,
        V_COMPID   => V_COMPID);*/
      END IF;
    
      v_lastsupcode := v_supcode;
    END LOOP;
  END p_supcpscp_upd_efflogic;

  /*===================================================================================
  
    供应商档案合作范围新增生效逻辑
  
    用途:
      用于供应商档案合作范围新增生效逻辑
  
    入参:
      V_QUEUEID   :  队列Id
      V_COND      :  唯一行条件
      V_COMPID    :  企业Id
  
    版本:
      2022-04-02  : 供应商档案合作范围新增生效逻辑
      2022-05-24  : 增加涉及供应商作为其他供应商生产工厂角色的生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcpscp_ins_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_curcate     VARCHAR2(2);
    v_curprocate  VARCHAR2(4);
    v_cursubcate  VARCHAR2(8);
    v_creid       VARCHAR2(32);
    v_tabcreid    VARCHAR2(32);
    v_cretime     VARCHAR2(32);
    v_faccode     VARCHAR2(32);
    v_supcode     VARCHAR2(32);
    v_lastsupcode VARCHAR2(32);
    v_sgsubcate   VARCHAR2(8);
    v_jugnum      NUMBER(1);
    v_sttime      DATE;
    v_vnum        NUMBER(1);
    v_exesql      VARCHAR2(4000);
  BEGIN
    -- 开始时间赋值
    v_sttime := SYSDATE;
  
    -- 获取修改的分类，生产分类，子类，更新人，更新时间
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'COOP_CLASSIFICATION' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOP_PRODUCT_CATE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOP_SUBCATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_curcate,
           v_curprocate,
           v_cursubcate,
           v_creid,
           v_cretime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    --获取关联供应商档案编号，表内现有更新人id
    v_exesql := 'SELECT MAX(B.SUPPLIER_CODE), MAX(A.CREATE_ID) FROM (SELECT SUPPLIER_INFO_ID,COMPANY_ID,UPDATE_ID FROM SCMDATA.T_COOP_SCOPE WHERE ' ||
                v_cond ||
                ') A INNER JOIN SCMDATA.T_SUPPLIER_INFO B ON A.SUPPLIER_INFO_ID = B.SUPPLIER_INFO_ID AND A.COMPANY_ID = B.COMPANY_ID';
    EXECUTE IMMEDIATE v_exesql
      INTO v_faccode, v_tabcreid;
  
    --确保 V_CREID 一定有值
    IF v_creid IS NULL THEN
      v_creid := v_tabcreid;
    END IF;
  
    --判断是否影响
    FOR i IN (SELECT DISTINCT coop_category,
                              coop_productcate,
                              coop_subcategory,
                              supplier_code,
                              company_id
                FROM scmdata.t_coopcate_supplier_cfg
               WHERE coop_category = v_curcate
                 AND coop_productcate = v_curprocate
                 AND instr(v_cursubcate, coop_subcategory) > 0
                 AND company_id = v_compid) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_coop_factory a
       INNER JOIN scmdata.t_supplier_info b
          ON a.supplier_info_id = b.supplier_info_id
         AND a.company_id = b.company_id
       INNER JOIN scmdata.t_coop_scope c
          ON b.supplier_info_id = c.supplier_info_id
         AND b.company_id = c.company_id
       WHERE b.supplier_code = i.supplier_code
         AND c.coop_classification = i.coop_category
         AND c.coop_product_cate = i.coop_productcate
         AND instr(c.coop_subcategory, i.coop_subcategory) > 0
         AND a.factory_code = v_faccode
         AND a.company_id = i.company_id;
    
      IF v_jugnum > 0 THEN
        --生成数据补齐
        scmdata.pkg_capacity_management.p_ins_catecoopsup_data_onlyscps(v_supcode => i.supplier_code,
                                                                        v_cate    => i.coop_category,
                                                                        v_procate => i.coop_productcate,
                                                                        v_subcate => i.coop_subcategory,
                                                                        v_curid   => v_creid,
                                                                        v_compid  => i.company_id);
      
        scmdata.pkg_capacity_management.p_gen_appcapccfg_data_by_sup(v_supcode  => i.supplier_code,
                                                                     v_operid   => v_creid,
                                                                     v_opertime => v_cretime,
                                                                     v_compid   => i.company_id);
      END IF;
    END LOOP;
  
    IF v_sttime = SYSDATE THEN
      v_sttime := SYSDATE - 1 / (24 * 60 * 60);
    END IF;
  
    --MINUS 获取差异值
    FOR x IN (SELECT csc_id,
                     company_id
                FROM (SELECT csc_id,
                             factory_code,
                             company_id
                        FROM scmdata.t_coopcate_factory_cfg
                      MINUS
                      SELECT csc_id,
                             factory_code,
                             company_id
                        FROM scmdata.t_coopcate_factory_cfg AS OF TIMESTAMP v_sttime)
               WHERE factory_code = v_faccode
                 AND company_id = v_compid
              UNION ALL
              SELECT csc_id,
                     company_id
                FROM scmdata.t_coopcate_supplier_cfg
               WHERE supplier_code = v_supcode
                 AND coop_category = v_curcate
                 AND coop_productcate = v_curprocate
                 AND instr(v_cursubcate, coop_subcategory) > 0
                 AND company_id = v_compid) LOOP
      SELECT MAX(supplier_code),
             MAX(coop_subcategory)
        INTO v_supcode,
             v_sgsubcate
        FROM scmdata.t_coopcate_supplier_cfg
       WHERE csc_id = x.csc_id
         AND coop_category = v_curcate
         AND coop_productcate = v_curprocate
         AND instr(v_cursubcate, coop_subcategory) > 0
         AND company_id = x.company_id;
    
      IF v_supcode IS NOT NULL
         AND v_supcode <> nvl(v_lastsupcode, ' ') THEN
        --供应商产能预约
        scmdata.pkg_capacity_efflogic_prd.p_idu_supcapcappdata_by_diffparam(v_supcode  => v_supcode,
                                                                            v_faccode  => v_faccode,
                                                                            v_cate     => v_curcate,
                                                                            v_operid   => v_creid,
                                                                            v_opertime => v_cretime,
                                                                            v_compid   => v_compid);
      
        --记录到剩余产能占比待更新表
        scmdata.pkg_capacity_efflogic_prd.p_ins_faccode_into_tab(v_faccode => v_faccode,
                                                                 v_compid  => v_compid);
      
        --下单规划
        scmdata.pkg_capacity_efflogic_prd.p_idu_alorder_data_by_diffparam(v_supcode => v_supcode,
                                                                          v_faccode => v_faccode,
                                                                          v_cate    => v_curcate,
                                                                          v_procate => v_curprocate,
                                                                          v_subcate => v_sgsubcate,
                                                                          v_compid  => v_compid);
      
        --周产能规划数据重算
        scmdata.pkg_capacity_efflogic_prd.p_delete_wkplandata(v_supcode => v_supcode,
                                                              v_faccode => v_faccode,
                                                              v_cate    => v_curcate,
                                                              v_procate => v_curprocate,
                                                              v_subcate => v_sgsubcate,
                                                              v_compid  => v_compid,
                                                              v_mindate => SYSDATE);
      
        p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                               v_cate     => v_curcate,
                               v_operid   => v_creid,
                               v_opertime => v_cretime,
                               v_compid   => v_compid);
        /*SCMDATA.PKG_CAPACITY_EFFLOGIC_prd.P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_SUPCODE,
        V_CATE     => V_CURCATE,
        V_OPERID   => V_CREID,
        V_OPERTIME => V_CRETIME,
        V_COMPID   => V_COMPID);*/
      END IF;
    
      v_lastsupcode := v_supcode;
    END LOOP;
  END p_supcpscp_ins_efflogic;

  /*===================================================================================
  
    合作范围启停生效逻辑
  
    用途:
      合作范围启停生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-26 : 合作范围启停生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcoopscope_pausechange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_exesql    VARCHAR2(4000);
    v_pause     VARCHAR2(1);
    v_supinfoid VARCHAR2(32);
    v_supcode   VARCHAR2(32);
    v_updid     VARCHAR2(32);
    v_updtime   VARCHAR2(32);
    v_cate      VARCHAR2(2);
    v_procate   VARCHAR2(4);
    v_subcate   VARCHAR2(4000);
    v_vnum      NUMBER(1);
    v_jugnum    NUMBER(1);
  BEGIN
    --获取 SUPPLIER_INFO_ID, COOP_CLASSIFICATION, COOP_PRODUCT_CATE, COOP_SUBCATEGORY
    v_exesql := 'SELECT MAX(SUPPLIER_INFO_ID), MAX(COOP_CLASSIFICATION), MAX(COOP_PRODUCT_CATE), MAX(COOP_SUBCATEGORY) ' ||
                'FROM SCMDATA.T_COOP_SCOPE WHERE ' || v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_supinfoid, v_cate, v_procate, v_subcate;
  
    --获取 SUPPLIER_CODE
    SELECT MAX(supplier_code)
      INTO v_supcode
      FROM scmdata.t_supplier_info
     WHERE supplier_info_id = v_supinfoid
       AND company_id = v_compid;
  
    --获取 PAUSE, UPDATE_ID, UPDATE_TIME
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_pause,
           v_updid,
           v_updtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_updid IS NULL THEN
      v_exesql := 'SELECT MAX(UPDATE_ID) FROM SCMDATA.T_COOP_SCOPE WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_updid;
    END IF;
  
    --修改品类合作供应商对应数据
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_coopcate_supplier_cfg
     WHERE supplier_code = v_supcode
       AND coop_category = v_cate
       AND coop_productcate = v_procate
       AND instr(v_subcate, coop_subcategory) > 0
       AND company_id = v_compid
       AND rownum = 1;
  
    FOR m IN (SELECT regexp_substr(v_subcate, '[^;]+', 1, LEVEL) col
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_subcate, '\;') + 1) LOOP
      scmdata.pkg_capacity_management.p_ins_catecoopsup_data_onlyscps(v_supcode => v_supcode,
                                                                      v_cate    => v_cate,
                                                                      v_procate => v_procate,
                                                                      v_subcate => m.col,
                                                                      v_curid   => v_updid,
                                                                      v_compid  => v_compid);
    END LOOP;
  
    scmdata.pkg_capacity_management.p_gen_appcapccfg_data_by_sup(v_supcode  => v_supcode,
                                                                 v_operid   => v_updid,
                                                                 v_opertime => v_updtime,
                                                                 v_compid   => v_compid);
  
    FOR i IN (SELECT a.supplier_code,
                     b.factory_code,
                     a.coop_category,
                     a.coop_productcate,
                     a.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a
               INNER JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND a.coop_category = v_cate
                 AND a.coop_productcate = v_procate
                 AND instr(v_subcate, a.coop_subcategory) > 0
                 AND a.company_id = v_compid) LOOP
      --供应商产能预约
      p_idu_supcapcappdata_by_diffparam(v_supcode  => i.supplier_code,
                                        v_faccode  => i.factory_code,
                                        v_cate     => i.coop_category,
                                        v_operid   => v_updid,
                                        v_opertime => v_updtime,
                                        v_compid   => v_compid);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => i.factory_code,
                             v_compid  => v_compid);
    
      --下单规划
      p_idu_alorder_data_by_diffparam(v_supcode => i.supplier_code,
                                      v_faccode => i.factory_code,
                                      v_cate    => i.coop_category,
                                      v_procate => i.coop_productcate,
                                      v_subcate => i.coop_subcategory,
                                      v_compid  => v_compid);
    
      --周产能规划数据重算
      p_delete_wkplandata(v_supcode => i.supplier_code,
                          v_faccode => i.factory_code,
                          v_cate    => i.coop_category,
                          v_procate => i.coop_productcate,
                          v_subcate => i.coop_subcategory,
                          v_compid  => v_compid,
                          v_mindate => SYSDATE);
    END LOOP;
  
    FOR m IN (SELECT DISTINCT a.supplier_code,
                              a.coop_category,
                              a.company_id
                FROM scmdata.t_coopcate_supplier_cfg a
               WHERE a.supplier_code = v_supcode
                 AND a.coop_category = v_cate
                 AND a.coop_productcate = v_procate
                 AND instr(v_subcate, a.coop_subcategory) > 0
                 AND a.company_id = v_compid) LOOP
      p_gen_wkplanrecalcrela(v_supcode  => m.supplier_code,
                             v_cate     => m.coop_category,
                             v_operid   => v_updid,
                             v_opertime => v_updtime,
                             v_compid   => m.company_id);
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => M.SUPPLIER_CODE,
      V_CATE     => M.COOP_CATEGORY,
      V_OPERID   => V_UPDID,
      V_OPERTIME => V_UPDTIME,
      V_COMPID   => M.COMPANY_ID);*/
    END LOOP;
  END p_supcoopscope_pausechange_efflogic;

  /*===================================================================================
  
    合作范围增改生效逻辑
  
    用途:
      合作范围增改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-04-02 : 合作范围增改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcoopscope_iu_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_id      VARCHAR2(32);
    v_subcate VARCHAR2(4000);
    v_vnum    NUMBER(1);
    v_pause   VARCHAR2(1);
  BEGIN
    --获取 PAUSE, UDPATE_ID, UPDATE_TIME
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'COOP_SCOPE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOP_SUBCATEGORY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_id,
           v_subcate,
           v_pause
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_id IS NOT NULL THEN
      p_supcpscp_ins_efflogic(v_queueid => v_queueid,
                              v_cond    => v_cond,
                              v_compid  => v_compid);
    ELSIF v_subcate IS NOT NULL THEN
      p_supcpscp_upd_efflogic(v_queueid => v_queueid,
                              v_cond    => v_cond,
                              v_compid  => v_compid);
    ELSIF v_pause IS NOT NULL THEN
      p_supcoopscope_pausechange_efflogic(v_queueid => v_queueid,
                                          v_cond    => v_cond,
                                          v_compid  => v_compid);
    END IF;
  END p_supcoopscope_iu_efflogic;

  /*===================================================================================
  
    EffectiveLogic
    获取供应商合作范围变更生效核心逻辑
  
    入参:
      V_SUPCODE  :  供应商编码
      V_CATE     :  分类Id
      V_PROCATE  :  生产分类Id
      V_SUBCATE  :  产品子类Id
      V_OPERID   :  操作人Id
      V_OPERTIME :  操作时间
      V_COMPID   :  企业Id
  
    版本:
      2022-08-09 : 获取供应商合作范围影响行数据生成sql
  
  ===================================================================================*/
  PROCEDURE p_supscp_iu_efflogiccore
  (
    v_supcode  IN VARCHAR2,
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_compid   IN VARCHAR2
  ) IS
  
  BEGIN
    FOR i IN (SELECT csc1.supplier_code,
                     cfc1.factory_code,
                     csc1.company_id,
                     csc1.coop_category,
                     csc1.coop_productcate,
                     csc1.coop_subcategory,
                     csc1.pause cscpause,
                     cfc1.pause cfcpause,
                     decode(cpcc1.in_planning, 1, 0, 1) cpccpause
                FROM scmdata.t_coopcate_supplier_cfg csc1
               INNER JOIN scmdata.t_coopcate_factory_cfg cfc1
                  ON csc1.csc_id = cfc1.csc_id
                 AND csc1.company_id = cfc1.company_id
                LEFT JOIN scmdata.t_capacity_plan_category_cfg cpcc1
                  ON csc1.coop_category = cpcc1.category
                 AND csc1.coop_productcate = cpcc1.product_cate
                 AND csc1.coop_subcategory = cpcc1.subcategory
                 AND csc1.company_id = csc1.company_id
               WHERE (csc1.supplier_code = v_supcode OR
                     cfc1.factory_code = v_supcode)
                 AND csc1.coop_category = v_cate
                 AND csc1.coop_productcate = v_procate
                 AND csc1.coop_subcategory = v_subcate
                 AND csc1.company_id = v_compid
              MINUS
              SELECT csc2.supplier_code,
                     cfc2.factory_code,
                     csc2.company_id,
                     csc2.coop_category,
                     csc2.coop_productcate,
                     csc2.coop_subcategory,
                     csc2.pause cscpause,
                     cfc2.pause cfcpause,
                     decode(cpcc2.in_planning, 1, 0, 1) cpccpause
                FROM scmdata.t_coopcate_supplier_cfg AS OF TIMESTAMP systimestamp - 1 / (24 * 60 * 60) csc2
               INNER JOIN scmdata.t_coopcate_factory_cfg AS OF TIMESTAMP systimestamp - 1 / (24 * 60 * 60) cfc2
                  ON csc2.csc_id = cfc2.csc_id
                 AND csc2.company_id = cfc2.company_id
                LEFT JOIN scmdata.t_capacity_plan_category_cfg cpcc2
                  ON csc2.coop_category = cpcc2.category
                 AND csc2.coop_productcate = cpcc2.product_cate
                 AND csc2.coop_subcategory = cpcc2.subcategory
                 AND csc2.company_id = csc2.company_id
               WHERE (csc2.supplier_code = v_supcode OR
                     cfc2.factory_code = v_supcode)
                 AND csc2.coop_category = v_cate
                 AND csc2.coop_productcate = v_procate
                 AND csc2.coop_subcategory = v_subcate
                 AND csc2.company_id = v_compid) LOOP
      --供应商产能预约
      p_idu_supcapcappdata_by_diffparam(v_supcode     => i.supplier_code,
                                        v_faccode     => i.factory_code,
                                        v_cate        => i.coop_category,
                                        v_operid      => v_operid,
                                        v_opertime    => v_opertime,
                                        v_issubtabupd => 0,
                                        v_compid      => i.company_id);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => i.factory_code,
                             v_compid  => i.company_id);
    
      --下单规划
      p_idu_alorder_data_by_diffparam(v_supcode => i.supplier_code,
                                      v_faccode => i.factory_code,
                                      v_cate    => i.coop_category,
                                      v_procate => i.coop_productcate,
                                      v_subcate => i.coop_subcategory,
                                      v_compid  => i.company_id);
    
      --周产能规划数据重算
      p_delete_wkplandata(v_supcode => i.supplier_code,
                          v_faccode => i.factory_code,
                          v_cate    => i.coop_category,
                          v_procate => i.coop_productcate,
                          v_subcate => i.coop_subcategory,
                          v_compid  => i.company_id,
                          v_mindate => SYSDATE);
    END LOOP;
  END p_supscp_iu_efflogiccore;

  /*===================================================================================
  
    EffectiveLogic
    供应商合作范围变更层级生效逻辑
  
    入参:
      V_QUEUEID  :  队列Id
      V_COND     :  唯一行条件
      V_COMPID   :  企业Id
  
    版本:
      2022-08-09 : 供应商合作范围变更层级生效逻辑
      2022-09-01 : 增加建档时作为生产工厂产能配置数据生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_supscp_iu_efflogic
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
    v_cate       VARCHAR2(2);
    v_procate    VARCHAR2(4);
    v_subcates   VARCHAR2(4000);
    v_creid      VARCHAR2(32);
    v_cretime    VARCHAR2(32);
    v_updid      VARCHAR2(32);
    v_rawupdid   VARCHAR2(32);
    v_updtime    VARCHAR2(32);
    v_curpause   NUMBER(1);
    v_pause      NUMBER(1);
    v_supcode    VARCHAR2(32);
    v_vnum       NUMBER(1);
    v_exesql     VARCHAR2(4000);
  BEGIN
    SELECT 1,
           MAX(CASE
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
               END),
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'CREATE_TIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_rawcate,
           v_curcate,
           v_rawprocate,
           v_curprocate,
           v_rawsubcate,
           v_cursubcate,
           v_curpause,
           v_creid,
           v_cretime,
           v_updid,
           v_updtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    v_exesql := 'SELECT MAX(TSI.SUPPLIER_CODE), MAX(TCS.COOP_CLASSIFICATION), MAX(TCS.COOP_PRODUCT_CATE), ' ||
                'MAX(TCS.COOP_SUBCATEGORY), MAX(TCS.PAUSE), MAX(TCS.UPDATE_ID) FROM (SELECT SUPPLIER_INFO_ID,COMPANY_ID,' ||
                'COOP_CLASSIFICATION,COOP_PRODUCT_CATE,COOP_SUBCATEGORY,PAUSE,UPDATE_ID ' ||
                'FROM SCMDATA.T_COOP_SCOPE WHERE ' || v_cond ||
                ') TCS INNER JOIN SCMDATA.T_SUPPLIER_INFO TSI ' ||
                'ON TCS.SUPPLIER_INFO_ID = TSI.SUPPLIER_INFO_ID ' ||
                'AND TCS.COMPANY_ID = TSI.COMPANY_ID';
  
    EXECUTE IMMEDIATE v_exesql
      INTO v_supcode, v_cate, v_procate, v_subcates, v_pause, v_rawupdid;
  
    IF v_updid IS NULL THEN
      v_updid := v_rawupdid;
    END IF;
  
    IF v_updtime IS NULL THEN
      SELECT MAX(to_char(create_time, 'YYYY-MM-DD HH24-MI-SS'))
        INTO v_updtime
        FROM scmdata.t_queue
       WHERE queue_id = v_queueid
         AND company_id = v_compid;
    END IF;
  
    IF v_rawsubcate IS NOT NULL THEN
      FOR i IN (SELECT regexp_substr(v_rawsubcate, '[^;]+', 1, LEVEL) rawsubcate
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(v_rawsubcate, '\;') + 1) LOOP
        p_supfilerelacg_refreshcfgdata(v_supcode  => v_supcode,
                                       v_cate     => nvl(v_rawcate, v_cate),
                                       v_procate  => nvl(v_rawprocate,
                                                         v_procate),
                                       v_subcate  => i.rawsubcate,
                                       v_operid   => v_updid,
                                       v_opertime => v_updtime,
                                       v_compid   => v_compid);
      
        --供应商合作范围变更生效核心逻辑
        p_supscp_iu_efflogiccore(v_supcode  => v_supcode,
                                 v_cate     => nvl(v_rawcate, v_cate),
                                 v_procate  => nvl(v_rawprocate, v_procate),
                                 v_subcate  => i.rawsubcate,
                                 v_operid   => v_updid,
                                 v_opertime => v_updtime,
                                 v_compid   => v_compid);
      END LOOP;
    END IF;
  
    IF v_cursubcate IS NOT NULL THEN
      FOR l IN (SELECT regexp_substr(v_cursubcate, '[^;]+', 1, LEVEL) cursubcate
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(v_cursubcate, '\;') + 1) LOOP
        p_supfilerelacg_refreshcfgdata(v_supcode  => v_supcode,
                                       v_cate     => nvl(v_rawcate, v_cate),
                                       v_procate  => nvl(v_rawprocate,
                                                         v_procate),
                                       v_subcate  => l.cursubcate,
                                       v_operid   => v_updid,
                                       v_opertime => v_updtime,
                                       v_compid   => v_compid);
      
        --供应商合作范围变更生效核心逻辑
        p_supscp_iu_efflogiccore(v_supcode  => v_supcode,
                                 v_cate     => nvl(v_curcate, v_cate),
                                 v_procate  => nvl(v_curprocate, v_procate),
                                 v_subcate  => l.cursubcate,
                                 v_operid   => v_updid,
                                 v_opertime => v_updtime,
                                 v_compid   => v_compid);
      END LOOP;
    END IF;
  
    IF v_rawsubcate IS NULL
       AND v_cursubcate IS NULL
       AND v_curpause IS NOT NULL THEN
      FOR l IN (SELECT regexp_substr(v_subcates, '[^;]+', 1, LEVEL) cursubcate
                  FROM dual
                CONNECT BY LEVEL <= regexp_count(v_subcates, '\;') + 1) LOOP
        p_supfilerelacg_refreshcfgdata(v_supcode  => v_supcode,
                                       v_cate     => v_cate,
                                       v_procate  => v_procate,
                                       v_subcate  => l.cursubcate,
                                       v_operid   => v_updid,
                                       v_opertime => v_updtime,
                                       v_compid   => v_compid);
      
        --供应商合作范围变更生效核心逻辑
        p_supscp_iu_efflogiccore(v_supcode  => v_supcode,
                                 v_cate     => nvl(v_curcate, v_cate),
                                 v_procate  => nvl(v_curprocate, v_procate),
                                 v_subcate  => l.cursubcate,
                                 v_operid   => v_updid,
                                 v_opertime => v_updtime,
                                 v_compid   => v_compid);
      END LOOP;
    END IF;
  
    --周产能规划重算
    IF v_rawcate IS NOT NULL THEN
      p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                             v_cate     => v_rawcate,
                             v_operid   => v_updid,
                             v_opertime => v_updtime,
                             v_compid   => v_compid);
    END IF;
  
    p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                           v_cate     => nvl(v_curcate, v_cate),
                           v_operid   => v_updid,
                           v_opertime => v_updtime,
                           v_compid   => v_compid);
  END p_supscp_iu_efflogic;

  /*===================================================================================
  
    合作工厂启停生效逻辑
  
    用途:
      合作工厂启停生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-26 : 合作工厂启停生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcoopfac_pausechange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_exesql  VARCHAR2(4000);
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_pause   VARCHAR2(1);
    v_updid   VARCHAR2(32);
    v_updtime VARCHAR2(32);
    v_vnum    NUMBER(1);
    v_jugnum  NUMBER(1);
  BEGIN
    --获取 SUPPLIER_INFO_ID, FACTORY_CODE
    v_exesql := 'SELECT MAX(B.SUPPLIER_CODE), MAX(A.FACTORY_CODE) FROM (SELECT SUPPLIER_INFO_ID, COMPANY_ID, FACTORY_CODE ' ||
                'FROM SCMDATA.T_COOP_FACTORY WHERE ' || v_cond ||
                ') A LEFT JOIN SCMDATA.T_SUPPLIER_INFO B ' ||
                'ON A.SUPPLIER_INFO_ID = B.SUPPLIER_INFO_ID AND A.COMPANY_ID = B.COMPANY_ID';
    EXECUTE IMMEDIATE v_exesql
      INTO v_supcode, v_faccode;
  
    --获取 PAUSE, UPDATE_ID, UPDATE_TIME
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_pause,
           v_updid,
           v_updtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    --确保 UPDATE_ID 有值
    IF v_updid IS NULL THEN
      v_exesql := 'SELECT MAX(UPDATE_ID) FROM SCMDATA.T_COOP_FACTORY WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_updid;
    END IF;
  
    --生效到品类合作供应商
    IF v_supcode IS NOT NULL
       AND v_faccode IS NOT NULL THEN
      --判断是否存在该生产工厂数据
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_coopcate_factory_cfg
       WHERE factory_code = v_faccode
         AND (csc_id, company_id) IN
             (SELECT csc_id,
                     company_id
                FROM scmdata.t_coopcate_supplier_cfg
               WHERE supplier_code = v_supcode
                 AND company_id = v_compid)
         AND rownum = 1;
    
      --启用并且不存在该生产工厂数据
      IF v_pause = '0'
         AND v_jugnum = 0 THEN
        --生成生产工厂数据
        FOR i IN (SELECT supplier_code,
                         coop_category,
                         coop_productcate,
                         coop_subcategory,
                         company_id
                    FROM scmdata.t_coopcate_supplier_cfg
                   WHERE supplier_code = v_supcode
                     AND company_id = v_compid) LOOP
          --生成品类合作供应商数据
          scmdata.pkg_capacity_management.p_ins_catecoopsup_data_onlyscps(v_supcode => i.supplier_code,
                                                                          v_cate    => i.coop_category,
                                                                          v_procate => i.coop_productcate,
                                                                          v_subcate => i.coop_subcategory,
                                                                          v_curid   => v_updid,
                                                                          v_compid  => i.company_id);
          --生成生产工厂产能预约数据
          scmdata.pkg_capacity_management.p_gen_appcapccfg_data_by_sup(v_supcode  => i.supplier_code,
                                                                       v_operid   => v_updid,
                                                                       v_opertime => v_updtime,
                                                                       v_compid   => i.company_id);
        END LOOP;
      ELSE
        --更新生产工厂数据
        UPDATE scmdata.t_coopcate_factory_cfg
           SET pause   = to_number(v_pause),
               is_show = to_number(v_pause)
         WHERE factory_code = v_faccode
           AND (csc_id, company_id) IN
               (SELECT csc_id,
                       company_id
                  FROM scmdata.t_coopcate_supplier_cfg
                 WHERE supplier_code = v_supcode
                   AND company_id = v_compid);
      END IF;
    
      FOR x IN (SELECT a2.supplier_code,
                       a2.company_id,
                       b2.factory_code,
                       a2.coop_category,
                       a2.coop_productcate,
                       a2.coop_subcategory
                  FROM scmdata.t_coopcate_supplier_cfg a2
                 INNER JOIN scmdata.t_coopcate_factory_cfg b2
                    ON a2.csc_id = b2.csc_id
                   AND a2.company_id = b2.company_id
                 WHERE a2.supplier_code = v_supcode
                   AND b2.factory_code = v_faccode
                   AND a2.company_id = v_compid) LOOP
        --供应商产能预约
        p_idu_supcapcappdata_by_diffparam(v_supcode  => x.supplier_code,
                                          v_faccode  => x.factory_code,
                                          v_cate     => x.coop_category,
                                          v_operid   => v_updid,
                                          v_opertime => v_updtime,
                                          v_compid   => v_compid);
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => x.factory_code,
                               v_compid  => v_compid);
      
        --下单规划
        p_idu_alorder_data_by_diffparam(v_supcode => x.supplier_code,
                                        v_faccode => x.factory_code,
                                        v_cate    => x.coop_category,
                                        v_procate => x.coop_productcate,
                                        v_subcate => x.coop_subcategory,
                                        v_compid  => v_compid);
      
        --周产能规划数据重算
        p_delete_wkplandata(v_supcode => x.supplier_code,
                            v_faccode => x.factory_code,
                            v_cate    => x.coop_category,
                            v_procate => x.coop_productcate,
                            v_subcate => x.coop_subcategory,
                            v_compid  => v_compid,
                            v_mindate => SYSDATE);
      END LOOP;
    
      FOR y IN (SELECT DISTINCT a3.supplier_code,
                                a3.company_id,
                                a3.coop_category
                  FROM scmdata.t_coopcate_supplier_cfg a3
                 INNER JOIN scmdata.t_coopcate_factory_cfg b3
                    ON a3.csc_id = b3.csc_id
                   AND a3.company_id = b3.company_id
                 WHERE a3.supplier_code = v_supcode
                   AND b3.factory_code = v_faccode
                   AND a3.company_id = v_compid) LOOP
        p_gen_wkplanrecalcrela(v_supcode  => y.supplier_code,
                               v_cate     => y.coop_category,
                               v_operid   => v_updid,
                               v_opertime => v_updtime,
                               v_compid   => v_compid);
        /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => Y.SUPPLIER_CODE,
        V_CATE     => Y.COOP_CATEGORY,
        V_OPERID   => V_UPDID,
        V_OPERTIME => V_UPDTIME,
        V_COMPID   => Y.COMPANY_ID);*/
      END LOOP;
    END IF;
  END p_supcoopfac_pausechange_efflogic;

  /*===================================================================================
  
    合作工厂增生效逻辑
  
    用途:
      合作工厂增生效逻辑
  
    入参:
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-04-02 : 合作工厂增改效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcoopfac_i_efflogic
  (
    v_cond   IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_exesql  VARCHAR2(4000);
    v_cfid    VARCHAR2(32);
    v_supcode VARCHAR2(32);
    v_faccode VARCHAR2(32);
    v_creid   VARCHAR2(32);
    v_cretime VARCHAR2(32);
  BEGIN
    --获取合作工厂Id
    v_exesql := 'SELECT MAX(COOP_FACTORY_ID), MAX(COMPANY_ID) FROM SCMDATA.T_COOP_FACTORY WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_cfid;
  
    --获取供应商编码，工厂编码，创建人Id
    v_exesql := 'SELECT MAX(TAB1.SUPPLIER_CODE), MAX(TAB2.FACTORY_CODE), MAX(TAB2.CREATE_ID), MAX(TO_CHAR(TAB2.CREATE_TIME,''YYYY-MM-DD HH24-MI-SS''))' ||
                'FROM SCMDATA.T_SUPPLIER_INFO TAB1 LEFT JOIN SCMDATA.T_COOP_FACTORY TAB2 ' ||
                'ON TAB1.SUPPLIER_INFO_ID = TAB2.SUPPLIER_INFO_ID AND TAB1.COMPANY_ID = TAB2.COMPANY_ID ' ||
                'WHERE COOP_FACTORY_ID = ''' || v_cfid ||
                ''' AND COMPANY_ID = ''' || v_compid || ''')';
  
    EXECUTE IMMEDIATE v_exesql
      INTO v_supcode, v_faccode, v_creid, v_cretime;
  
    --新增品类合作供应商数据
    scmdata.pkg_capacity_management.p_ins_catecoopsup_data_bysf(v_supcode => v_supcode,
                                                                v_faccode => v_faccode,
                                                                v_curid   => v_creid,
                                                                v_compid  => v_compid);
  
    --新增生产工厂产能预约数据
    scmdata.pkg_capacity_management.p_gen_appcapccfg_data_by_sup(v_supcode  => v_supcode,
                                                                 v_operid   => v_creid,
                                                                 v_opertime => v_cretime,
                                                                 v_compid   => v_compid);
  
    --构建遍历数据sql
    FOR x IN (SELECT a.supplier_code,
                     b.factory_code,
                     a.coop_category,
                     a.coop_productcate,
                     a.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a
                LEFT JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND b.factory_code = v_faccode
                 AND a.company_id = v_compid) LOOP
      --生产工厂不为空时执行
      IF x.factory_code IS NOT NULL THEN
        --供应商产能预约
        p_idu_supcapcappdata_by_diffparam(v_supcode  => x.supplier_code,
                                          v_faccode  => x.factory_code,
                                          v_cate     => x.coop_category,
                                          v_operid   => v_creid,
                                          v_opertime => v_cretime,
                                          v_compid   => v_compid);
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => x.factory_code,
                               v_compid  => v_compid);
      
        --下单规划
        p_idu_alorder_data_by_diffparam(v_supcode => x.supplier_code,
                                        v_faccode => x.factory_code,
                                        v_cate    => x.coop_category,
                                        v_procate => x.coop_productcate,
                                        v_subcate => x.coop_subcategory,
                                        v_compid  => v_compid);
      
        --周产能规划数据重算
        p_delete_wkplandata(v_supcode => x.supplier_code,
                            v_faccode => x.factory_code,
                            v_cate    => x.coop_category,
                            v_procate => x.coop_productcate,
                            v_subcate => x.coop_subcategory,
                            v_compid  => v_compid,
                            v_mindate => SYSDATE);
      END IF;
    END LOOP;
  
    FOR y IN (SELECT DISTINCT a.supplier_code,
                              a.coop_category,
                              a.company_id
                FROM scmdata.t_coopcate_supplier_cfg a
                LEFT JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_supcode
                 AND b.factory_code = v_faccode
                 AND a.company_id = v_compid) LOOP
      p_gen_wkplanrecalcrela(v_supcode  => y.supplier_code,
                             v_cate     => y.coop_category,
                             v_operid   => v_creid,
                             v_opertime => v_cretime,
                             v_compid   => y.company_id);
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => Y.SUPPLIER_CODE,
      V_CATE     => Y.COOP_CATEGORY,
      V_OPERID   => V_CREID,
      V_OPERTIME => V_CRETIME,
      V_COMPID   => Y.COMPANY_ID);*/
    END LOOP;
  END p_supcoopfac_i_efflogic;

  /*===================================================================================
  
    合作工厂增改生效逻辑
  
    用途:
      合作工厂增改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-04-02 : 合作工厂增改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcopfac_iu_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_id    VARCHAR2(32);
    v_pause VARCHAR2(1);
    v_vnum  NUMBER(1);
  BEGIN
    --获取 COOP_SCOPE_ID, PAUSE
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'COOP_SCOPE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_id,
           v_pause
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_id IS NOT NULL THEN
      p_supcoopfac_i_efflogic(v_cond => v_cond, v_compid => v_compid);
    ELSE
      p_supcoopfac_pausechange_efflogic(v_queueid => v_queueid,
                                        v_cond    => v_cond,
                                        v_compid  => v_compid);
    END IF;
  END p_supcopfac_iu_efflogic;

  /*===================================================================================
  
    供应商档案启停生效逻辑
  
    用途:
      供应商档案启停生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-27 : 供应商档案启停生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfile_pausechange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_exesql   VARCHAR2(2048);
    v_pausestr VARCHAR2(1);
    v_updid    VARCHAR2(32);
    v_updtime  VARCHAR2(32);
    v_supcode  VARCHAR2(32);
    v_vnum     NUMBER(1);
  BEGIN
    --获取 PAUSE, UDPATE_ID, UPDATE_TIME
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UDPATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_DATE' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_pausestr,
           v_updid,
           v_updtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_updid IS NULL THEN
      v_exesql := 'SELECT MAX(UPDATE_ID) FROM SCMDATA.T_SUPPLIER_INFO WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_updid;
    END IF;
  
    --获取 SUPPLIER_CODE
    v_exesql := 'SELECT MAX(SUPPLIER_CODE) FROM SCMDATA.T_SUPPLIER_INFO WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_supcode;
  
    IF v_supcode IS NOT NULL THEN
      scmdata.pkg_capacity_management.p_ins_catecoopsup_data(v_supcode => v_supcode,
                                                             v_compid  => v_compid,
                                                             v_curid   => v_updid,
                                                             v_mode    => 'SUP');
    
      scmdata.pkg_capacity_management.p_gen_appcapccfg_data_by_sup(v_supcode  => v_supcode,
                                                                   v_operid   => v_updid,
                                                                   v_opertime => v_updtime,
                                                                   v_compid   => v_compid);
    
      --生效到供应商产能预约和供应商周产能规划
      FOR y IN (SELECT a1.csc_id,
                       a1.company_id
                  FROM scmdata.t_coopcate_supplier_cfg a1
                 INNER JOIN scmdata.t_coopcate_factory_cfg b1
                    ON a1.csc_id = b1.csc_id
                   AND a1.company_id = b1.company_id
                 WHERE a1.supplier_code = v_supcode
                   AND a1.company_id = v_compid) LOOP
        --生效到业务表
        UPDATE scmdata.t_coopcate_supplier_cfg
           SET pause = to_number(v_pausestr)
         WHERE csc_id = y.csc_id
           AND company_id = y.company_id;
      
        UPDATE scmdata.t_coopcate_factory_cfg
           SET pause = to_number(v_pausestr)
         WHERE csc_id = y.csc_id
           AND company_id = y.company_id;
      END LOOP;
    
      FOR x IN (SELECT a2.supplier_code,
                       a2.company_id,
                       b2.factory_code,
                       a2.coop_category,
                       a2.coop_productcate,
                       a2.coop_subcategory,
                       a2.pause
                  FROM scmdata.t_coopcate_supplier_cfg a2
                 INNER JOIN scmdata.t_coopcate_factory_cfg b2
                    ON a2.csc_id = b2.csc_id
                   AND a2.company_id = b2.company_id
                 WHERE a2.supplier_code = v_supcode
                   AND a2.company_id = v_compid) LOOP
        --供应商产能预约
        p_idu_supcapcappdata_by_diffparam(v_supcode  => x.supplier_code,
                                          v_faccode  => x.factory_code,
                                          v_cate     => x.coop_category,
                                          v_operid   => v_updid,
                                          v_opertime => v_updtime,
                                          v_compid   => v_compid);
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => x.factory_code,
                               v_compid  => v_compid);
      
        --下单规划
        p_idu_alorder_data_by_diffparam(v_supcode => x.supplier_code,
                                        v_faccode => x.factory_code,
                                        v_cate    => x.coop_category,
                                        v_procate => x.coop_productcate,
                                        v_subcate => x.coop_subcategory,
                                        v_compid  => v_compid);
      
        --周产能规划数据重算
        p_delete_wkplandata(v_supcode => x.supplier_code,
                            v_faccode => x.factory_code,
                            v_cate    => x.coop_category,
                            v_procate => x.coop_productcate,
                            v_subcate => x.coop_subcategory,
                            v_compid  => v_compid,
                            v_mindate => SYSDATE);
      END LOOP;
    
      FOR y IN (SELECT DISTINCT supplier_code,
                                company_id,
                                coop_category
                  FROM scmdata.t_coopcate_supplier_cfg
                 WHERE supplier_code = v_supcode
                   AND company_id = v_compid) LOOP
        p_gen_wkplanrecalcrela(v_supcode  => y.supplier_code,
                               v_cate     => y.coop_category,
                               v_operid   => v_updid,
                               v_opertime => v_updtime,
                               v_compid   => y.company_id);
        /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => Y.SUPPLIER_CODE,
        V_CATE     => Y.COOP_CATEGORY,
        V_OPERID   => V_UPDID,
        V_OPERTIME => V_UPDTIME,
        V_COMPID   => Y.COMPANY_ID);*/
      END LOOP;
    END IF;
  END p_supfile_pausechange_efflogic;

  /*===================================================================================
  
    供应商档案信息修改生效逻辑
  
    用途:
      供应商档案信息修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COND         :  唯一行条件
      V_COMPID       :  企业Id
  
    版本:
      2022-02-27 : 供应商档案信息修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfile_infochange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_vcwkhr    NUMBER(4);
    v_vcwknm    NUMBER(4);
    v_vcpref    NUMBER(5, 2);
    v_vcupdid   VARCHAR2(32);
    v_vcupdtime VARCHAR2(32);
    v_faccode   VARCHAR2(32);
    v_wkhours   NUMBER(4);
    v_wknums    NUMBER(4);
    v_prodeff   NUMBER(5, 2);
    v_exesql    VARCHAR2(2048);
    v_vnum      NUMBER(1);
  BEGIN
    --获取 WORK_HOURS_DAY, WORKER_NUM, PRODUCT_EFFICIENCY, UPDATE_ID, UPDATE_TIME
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'WORK_HOURS_DAY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WORKER_NUM' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_EFFICIENCY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_DATE' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_vcwkhr,
           v_vcwknm,
           v_vcpref,
           v_vcupdid,
           v_vcupdtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_vcupdid IS NULL THEN
      v_exesql := 'SELECT MAX(UPDATE_ID) FROM SCMDATA.T_SUPPLIER_INFO WHERE ' ||
                  v_cond;
      EXECUTE IMMEDIATE v_exesql
        INTO v_vcupdid;
    END IF;
  
    --获取 SUPPLIER_CODE
    v_exesql := 'SELECT MAX(SUPPLIER_CODE), MAX(WORK_HOURS_DAY), MAX(WORKER_NUM), MAX(PRODUCT_EFFICIENCY) ' ||
                'FROM SCMDATA.T_SUPPLIER_INFO WHERE ' || v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_faccode, v_wkhours, v_wknums, v_prodeff;
  
    --更新到业务表
    UPDATE scmdata.t_app_capacity_cfg
       SET wktime_num   = v_wkhours,
           wkperson_num = v_wknums,
           prod_eff     = v_prodeff
     WHERE factory_code = v_faccode
       AND company_id = v_compid;
  
    --重算逻辑
    FOR x IN (SELECT a2.supplier_code,
                     a2.company_id,
                     b2.factory_code,
                     a2.coop_category,
                     a2.coop_productcate,
                     a2.coop_subcategory
                FROM scmdata.t_coopcate_supplier_cfg a2
               INNER JOIN scmdata.t_coopcate_factory_cfg b2
                  ON a2.csc_id = b2.csc_id
                 AND a2.company_id = b2.company_id
               WHERE b2.factory_code = v_faccode
                 AND b2.company_id = v_compid) LOOP
      --重算供应商产能预约数据
      p_idu_supcapcappdata_by_diffparam(v_supcode     => x.supplier_code,
                                        v_faccode     => x.factory_code,
                                        v_cate        => x.coop_category,
                                        v_operid      => v_vcupdid,
                                        v_opertime    => v_vcupdtime,
                                        v_issubtabupd => 0,
                                        v_compid      => v_compid);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => x.factory_code,
                             v_compid  => v_compid);
    
      --重算周产能规划数据
      p_delete_wkplandata(v_supcode => x.supplier_code,
                          v_faccode => x.factory_code,
                          v_cate    => x.coop_category,
                          v_procate => x.coop_productcate,
                          v_subcate => x.coop_subcategory,
                          v_compid  => v_compid,
                          v_mindate => SYSDATE);
    END LOOP;
  
    FOR y IN (SELECT DISTINCT a3.supplier_code,
                              a3.coop_category,
                              a3.company_id
                FROM scmdata.t_coopcate_supplier_cfg a3
               INNER JOIN scmdata.t_coopcate_factory_cfg b3
                  ON a3.csc_id = b3.csc_id
                 AND a3.company_id = b3.company_id
               WHERE b3.factory_code = v_faccode
                 AND b3.company_id = v_compid) LOOP
      p_gen_wkplanrecalcrela(v_supcode  => y.supplier_code,
                             v_cate     => y.coop_category,
                             v_operid   => v_vcupdid,
                             v_opertime => v_vcupdtime,
                             v_compid   => y.company_id);
      /*P_IU_WEEKPLAN_DATA(V_SUPCODE  => Y.SUPPLIER_CODE,
      V_CATE     => Y.COOP_CATEGORY,
      V_OPERID   => V_VCUPDID,
      V_OPERTIME => V_VCUPDTIME,
      V_COMPID   => Y.COMPANY_ID);*/
    END LOOP;
  END p_supfile_infochange_efflogic;

  /*===================================================================================
  
    供应商档案建档生效逻辑
  
    用途:
      供应商档案建档生效逻辑
  
    入参:
      V_QUEUEID      :  队列ID
      V_COND         :  唯一行条件
      V_COMPID       :  企业ID
  
    版本:
      2022-03-23 : 供应商档案建档生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfile_statuschange_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_status   VARCHAR2(4);
    v_updid    VARCHAR2(32);
    v_updtime  VARCHAR2(32);
    v_supupdid VARCHAR2(32);
    v_supcode  VARCHAR2(32);
    v_exesql   VARCHAR2(512);
    v_vnum     NUMBER(1);
  BEGIN
    --获取 STATUS
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'STATUS' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_DATE' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_status,
           v_updid,
           v_updtime
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    --获取 SUPPLIER_CODE
    v_exesql := 'SELECT SUPPLIER_CODE,UPDATE_ID FROM SCMDATA.T_SUPPLIER_INFO WHERE ' ||
                v_cond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_supcode, v_supupdid;
  
    IF v_status IS NOT NULL THEN
      --新增品类合作供应商数据
      scmdata.pkg_capacity_management.p_ins_catecoopsup_data(v_supcode => v_supcode,
                                                             v_compid  => v_compid,
                                                             v_curid   => nvl(v_supupdid,
                                                                              v_updid),
                                                             v_mode    => 'SUP');
    
      --新增生产工厂产能预约数据
      scmdata.pkg_capacity_management.p_gen_appcapccfg_data_by_sup(v_supcode  => v_supcode,
                                                                   v_operid   => nvl(v_supupdid,
                                                                                     v_updid),
                                                                   v_opertime => v_updtime,
                                                                   v_compid   => v_compid);
    
      FOR x IN (SELECT a.supplier_code,
                       b.factory_code,
                       a.coop_category,
                       a.coop_productcate,
                       a.coop_subcategory
                  FROM scmdata.t_coopcate_supplier_cfg a
                  LEFT JOIN scmdata.t_coopcate_factory_cfg b
                    ON a.csc_id = b.csc_id
                   AND a.company_id = b.company_id
                 WHERE a.supplier_code = v_supcode
                   AND a.company_id = v_compid) LOOP
        --供应商产能预约
        p_idu_supcapcappdata_by_diffparam(v_supcode  => x.supplier_code,
                                          v_faccode  => x.factory_code,
                                          v_cate     => x.coop_category,
                                          v_operid   => v_updid,
                                          v_opertime => v_updtime,
                                          v_compid   => v_compid);
      
        --记录到剩余产能占比待更新表
        p_ins_faccode_into_tab(v_faccode => x.factory_code,
                               v_compid  => v_compid);
      
        --下单规划
        p_idu_alorder_data_by_diffparam(v_supcode => x.supplier_code,
                                        v_faccode => x.factory_code,
                                        v_cate    => x.coop_category,
                                        v_procate => x.coop_productcate,
                                        v_subcate => x.coop_subcategory,
                                        v_compid  => v_compid);
      
        --周产能规划数据重算
        p_delete_wkplandata(v_supcode => x.supplier_code,
                            v_faccode => x.factory_code,
                            v_cate    => x.coop_category,
                            v_procate => x.coop_productcate,
                            v_subcate => x.coop_subcategory,
                            v_compid  => v_compid,
                            v_mindate => SYSDATE);
      END LOOP;
    END IF;
  END p_supfile_statuschange_efflogic;

  /*===================================================================================
  
    供应商档案修改生效逻辑
  
    用途:
      供应商档案修改生效逻辑
  
    入参:
      V_QUEUEID      :  队列ID
      V_COND         :  唯一行条件
      V_COMPID       :  企业ID
  
    版本:
      2022-03-23 : 供应商档案修改生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_supfile_cg_efflogic
  (
    v_queueid IN VARCHAR2,
    v_cond    IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_status  VARCHAR2(4);
    v_pause   VARCHAR2(1);
    v_wkhour  VARCHAR2(32);
    v_wknum   VARCHAR2(8);
    v_prodeff VARCHAR2(5);
    v_vnum    NUMBER(1);
  BEGIN
    --获取 STATUS
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'STATUS' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WORK_HOURS_DAY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WORKER_NUM' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_EFFICIENCY' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_status,
           v_pause,
           v_wkhour,
           v_wknum,
           v_prodeff
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_status IS NOT NULL THEN
      p_supfile_statuschange_efflogic(v_queueid => v_queueid,
                                      v_cond    => v_cond,
                                      v_compid  => v_compid);
    ELSIF v_pause IS NOT NULL THEN
      p_supfile_pausechange_efflogic(v_queueid => v_queueid,
                                     v_cond    => v_cond,
                                     v_compid  => v_compid);
    ELSIF v_wkhour IS NOT NULL
          OR v_wknum IS NOT NULL
          OR v_prodeff IS NOT NULL THEN
      p_supfile_infochange_efflogic(v_queueid => v_queueid,
                                    v_cond    => v_cond,
                                    v_compid  => v_compid);
    END IF;
  END p_supfile_cg_efflogic;

  /*===================================================================================
  
    DataGenerateLogic
    供应商档案建档数据生成逻辑
  
    入参:
      V_SUPCODE  :  供应商编码
      V_COMPID   :  企业Id
  
    版本:
      2022-08-08 : 供应商档案建档数据生成逻辑
  
  ===================================================================================*/
  PROCEDURE p_gen_coopfac_appcapc_data_as_fac
  (
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
  
  BEGIN
    FOR i IN (SELECT csc.csc_id,
                     tsi.supplier_code,
                     ttsi.supplier_code factory_code,
                     ttsi.worker_num,
                     ttsi.work_hours_day,
                     ttsi.product_efficiency,
                     tsi.company_id,
                     sign(nvl(tsi.pause, 0) + nvl(tcs.pause, 0) +
                          nvl(tcf.pause, 0)) pause,
                     nvl(ttsi.update_id, ttsi.create_id) oper_id,
                     nvl(ttsi.update_date, ttsi.create_date) oper_date
                FROM scmdata.t_supplier_info tsi
               INNER JOIN scmdata.t_coop_factory tcf
                  ON tsi.supplier_info_id = tcf.supplier_info_id
                 AND tsi.company_id = tcf.company_id
               INNER JOIN scmdata.t_coop_scope tcs
                  ON tsi.supplier_info_id = tcs.supplier_info_id
                 AND tsi.company_id = tcs.company_id
               INNER JOIN scmdata.t_coopcate_supplier_cfg csc
                  ON csc.coop_category = tcs.coop_classification
                 AND csc.coop_productcate = tcs.coop_product_cate
                 AND instr(tcs.coop_subcategory, csc.coop_subcategory) > 0
                 AND tsi.supplier_code = csc.supplier_code
                 AND tsi.company_id = csc.company_id
               INNER JOIN scmdata.t_supplier_info ttsi
                  ON tcf.fac_sup_info_id = ttsi.supplier_info_id
                 AND tcf.company_id = ttsi.company_id
               WHERE tcf.factory_code = v_faccode
                 AND tcf.company_id = v_compid) LOOP
      INSERT INTO scmdata.t_coopcate_factory_cfg
        (cfc_id, company_id, csc_id, factory_code, pause, create_id, create_time, is_show)
      VALUES
        (scmdata.f_get_uuid(), i.company_id, i.csc_id, i.factory_code, i.pause, i.oper_id, i.oper_date, i.pause);
    
      INSERT INTO scmdata.t_app_capacity_cfg
        (acc_id, company_id, supplier_code, factory_code, wktime_num, wkperson_num, prod_eff, create_id, create_time)
      VALUES
        (scmdata.f_get_uuid(), i.company_id, i.supplier_code, i.factory_code, i.work_hours_day, i.worker_num, i.product_efficiency, i.oper_id, i.oper_date);
    END LOOP;
  END p_gen_coopfac_appcapc_data_as_fac;

  /*===================================================================================
  
    EffectiveLogic
    供应商档案信息变更层级生效逻辑
  
    入参:
      V_QUEUEID  :  队列Id
      V_VCCOND   :  唯一行条件
      V_COMPID   :  企业Id
  
    版本:
      2022-08-08 : 供应商档案信息变更层级生效逻辑
      2022-09-01 : 增加建档时作为生产工厂产能配置数据生成逻辑
      2022-09-07 : 档案修改影响配置级数据变更/新增逻辑整合
  
  ===================================================================================*/
  PROCEDURE p_supdoc_efflogic
  (
    v_queueid IN VARCHAR2,
    v_vccond  IN VARCHAR2,
    v_qcompid IN VARCHAR2
  ) IS
    v_exesql      CLOB;
    v_faccode     VARCHAR2(32);
    v_compid      VARCHAR2(32);
    v_vcpause     NUMBER(1);
    v_vcprodtype  VARCHAR2(4);
    v_vccoopmodel VARCHAR2(8);
    v_vcstatus    VARCHAR2(2);
    v_vcupdid     VARCHAR2(32);
    v_vcupdtime   VARCHAR2(32);
    v_rawstatus   NUMBER(1);
    v_rawupdid    VARCHAR2(32);
    v_wknum       NUMBER(8);
    v_wtnum       NUMBER(8, 2);
    v_prodeff     NUMBER(8, 2);
    v_vnum        NUMBER(1);
  BEGIN
    --获取生产工厂编码，企业Id
    v_exesql := 'SELECT MAX(SUPPLIER_CODE), MAX(COMPANY_ID), MAX(UPDATE_ID), MAX(STATUS) FROM SCMDATA.T_SUPPLIER_INFO WHERE ' ||
                v_vccond;
    EXECUTE IMMEDIATE v_exesql
      INTO v_faccode, v_compid, v_rawupdid, v_rawstatus;
  
    --获取修改人和修改时间WORKER_NUM,WORK_HOURS_DAY,PRODUCT_EFFICIENCY
    SELECT 1,
           MAX(CASE
                 WHEN vc_col = 'PAUSE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_TYPE' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'COOPERATION_MODEL' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'STATUS' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_ID' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'UPDATE_TIME' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WORKER_NUM' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'WORK_HOURS_DAY' THEN
                  vc_curval
               END),
           MAX(CASE
                 WHEN vc_col = 'PRODUCT_EFFICIENCY' THEN
                  vc_curval
               END)
      INTO v_vnum,
           v_vcpause,
           v_vcprodtype,
           v_vccoopmodel,
           v_vcstatus,
           v_vcupdid,
           v_vcupdtime,
           v_wknum,
           v_wtnum,
           v_prodeff
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_qcompid;
  
    IF v_vcupdid IS NULL THEN
      v_vcupdid := v_rawupdid;
    END IF;
  
    IF v_vcupdtime IS NULL THEN
      SELECT MAX(to_char(create_time, 'YYYY-MM-DD HH24-MI-SS'))
        INTO v_vcupdtime
        FROM scmdata.t_queue
       WHERE queue_id = v_queueid
         AND company_id = v_compid;
    END IF;
  
    --产能配置数据生成 2022-09-07 ZC314 CHANGE
    IF v_vcstatus IS NOT NULL
       OR v_vcpause IS NOT NULL
       OR v_vcprodtype IS NOT NULL
       OR v_vccoopmodel IS NOT NULL THEN
      --作为供应商
      p_supfilerelacg_refreshcfgdata(v_supcode  => v_faccode,
                                     v_operid   => v_vcupdid,
                                     v_opertime => v_vcupdtime,
                                     v_compid   => v_compid);
      --作为工厂
      p_supfilerelacg_refreshcfgdata(v_faccode  => v_faccode,
                                     v_operid   => v_vcupdid,
                                     v_opertime => v_vcupdtime,
                                     v_compid   => v_compid);
    ELSIF v_wknum IS NOT NULL
          OR v_wtnum IS NOT NULL
          OR v_prodeff IS NOT NULL THEN
      UPDATE scmdata.t_app_capacity_cfg tab
         SET wktime_num   = nvl(v_wtnum, tab.wktime_num),
             wkperson_num = nvl(v_wknum, tab.wkperson_num),
             prod_eff     = nvl(v_prodeff, tab.prod_eff)
       WHERE factory_code = v_faccode
         AND company_id = v_compid;
    END IF;
  
    --生效逻辑
    FOR i IN (SELECT a.supplier_code,
                     b.factory_code,
                     a.coop_category,
                     a.coop_productcate,
                     a.coop_subcategory,
                     a.company_id
                FROM scmdata.t_coopcate_supplier_cfg a
                LEFT JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE (a.supplier_code = v_faccode OR
                     b.factory_code = v_faccode)
                 AND a.company_id = v_compid
                 AND nvl(v_vcstatus, v_rawstatus) = 1
              UNION ALL
              SELECT a.supplier_code,
                     b.factory_code,
                     a.coop_category,
                     a.coop_productcate,
                     a.coop_subcategory,
                     a.company_id
                FROM scmdata.t_coopcate_supplier_cfg a
                LEFT JOIN scmdata.t_coopcate_factory_cfg b
                  ON a.csc_id = b.csc_id
                 AND a.company_id = b.company_id
               WHERE a.supplier_code = v_faccode
                 AND a.company_id = v_compid
                 AND nvl(v_vcstatus, v_rawstatus) = 1) LOOP
      --供应商产能预约
      p_idu_supcapcappdata_by_diffparam(v_supcode     => i.supplier_code,
                                        v_faccode     => i.factory_code,
                                        v_cate        => i.coop_category,
                                        v_operid      => v_vcupdid,
                                        v_opertime    => v_vcupdtime,
                                        v_issubtabupd => 0,
                                        v_compid      => i.company_id);
    
      --记录到剩余产能占比待更新表
      p_ins_faccode_into_tab(v_faccode => i.factory_code,
                             v_compid  => i.company_id);
    
      --下单规划
      p_idu_alorder_data_by_diffparam(v_supcode => i.supplier_code,
                                      v_faccode => i.factory_code,
                                      v_cate    => i.coop_category,
                                      v_procate => i.coop_productcate,
                                      v_subcate => i.coop_subcategory,
                                      v_compid  => i.company_id);
    
      --周产能规划数据重算
      p_delete_wkplandata(v_supcode => i.supplier_code,
                          v_faccode => i.factory_code,
                          v_cate    => i.coop_category,
                          v_procate => i.coop_productcate,
                          v_subcate => i.coop_subcategory,
                          v_compid  => i.company_id,
                          v_mindate => SYSDATE);
    
      p_gen_wkplanrecalcrela(v_supcode  => i.supplier_code,
                             v_cate     => i.coop_category,
                             v_operid   => v_vcupdid,
                             v_opertime => v_vcupdtime,
                             v_compid   => i.company_id);
    END LOOP;
  END p_supdoc_efflogic;

  /*===================================================================================
  
    订单接口进入数据生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COMPID       :  企业Id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂、分类、生产分类、子类
  
    版本:
      2022-04-25 : 生成[订单数据接入]数据源级影响行sql
  
  ===================================================================================*/
  PROCEDURE p_gen_orditf_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    TYPE rctype IS REF CURSOR;
    rc           rctype;
    v_sql        CLOB;
    v_operid     VARCHAR2(32);
    v_opertime   VARCHAR2(32);
    v_supcode    VARCHAR2(32);
    v_faccode    VARCHAR2(32);
    v_cate       VARCHAR2(2);
    v_procate    VARCHAR2(4);
    v_subcate    VARCHAR2(8);
    v_tmpsupcode VARCHAR2(32);
    v_tmpcate    VARCHAR2(2);
  BEGIN
    v_sql := scmdata.pkg_capacity_iflrow.f_gen_orditf_iflrows_sql(v_queueid => v_queueid,
                                                                  v_compid  => v_compid);
  
    SELECT MAX(create_id),
           MAX(to_char(create_time, 'YYYY-MM-DD HH24-MI-SS'))
      INTO v_operid,
           v_opertime
      FROM scmdata.t_queue
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    OPEN rc FOR v_sql;
    LOOP
      FETCH rc
        INTO v_supcode,
             v_faccode,
             v_cate,
             v_procate,
             v_subcate;
      EXIT WHEN rc%NOTFOUND;
    
      IF v_supcode IS NOT NULL THEN
        /*SCMDATA.PKG_CAPACITY_EFFLOGIC_prd.P_IDU_SUPCAPCAPPDATA_BY_DIFFPARAM(V_SUPCODE  => V_SUPCODE,
        V_FACCODE  => V_FACCODE,
        V_CATE     => V_CATE,
        V_OPERID   => V_OPERID,
        V_OPERTIME => V_OPERTIME,
        V_COMPID   => V_COMPID);*/
      
        scmdata.pkg_capacity_efflogic_prd.p_idu_alorder_data_by_diffparam(v_supcode => v_supcode,
                                                                          v_faccode => v_faccode,
                                                                          v_cate    => v_cate,
                                                                          v_procate => v_procate,
                                                                          v_subcate => v_subcate,
                                                                          v_compid  => v_compid);
      
        IF nvl(v_tmpsupcode, ' ') <> v_supcode
           OR nvl(v_tmpcate, ' ') <> v_cate THEN
          p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                                 v_cate     => v_cate,
                                 v_operid   => v_operid,
                                 v_opertime => v_opertime,
                                 v_compid   => v_compid);
          /*SCMDATA.PKG_CAPACITY_EFFLOGIC_prd.P_IU_WEEKPLAN_DATA(V_SUPCODE  => V_SUPCODE,
          V_CATE     => V_CATE,
          V_OPERID   => V_OPERID,
          V_OPERTIME => V_OPERTIME,
          V_COMPID   => V_COMPID);*/
        END IF;
      
        v_tmpsupcode := v_supcode;
        v_tmpcate    := v_cate;
      END IF;
    
    END LOOP;
    CLOSE rc;
  END p_gen_orditf_efflogic;

  /*===================================================================================
  
    生成周产能规划日刷新入队，影响行数据
  
    版本:
      2022-07-20 : 生成周产能规划日刷新入队，影响行数据
  
  ===================================================================================*/
  PROCEDURE p_gen_day_refresh_wkplan_rela IS
    v_queueid VARCHAR2(32);
  BEGIN
    v_queueid := scmdata.f_get_uuid();
  
    INSERT INTO scmdata.t_queue
      (queue_id, company_id, queue_status, queue_type, create_id, create_time)
    VALUES
      (v_queueid, 'b6cc680ad0f599cde0531164a8c0337f', 'PR', 'CAPC_WKPLAN_DAY_REFRESH', 'ADMIN', SYSDATE);
  
    FOR i IN (SELECT DISTINCT supplier_code,
                              company_id
                FROM scmdata.t_supcapacity_week_plan) LOOP
      scmdata.pkg_capacity_iflrow.p_common_queueifldata_generator(v_supcode => i.supplier_code,
                                                                  v_queueid => v_queueid,
                                                                  v_compid  => i.company_id);
      /*--SCMDATA.T_COOPCATE_SUPPLIER_CFG
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_COOPCATE_SUPPLIER_CFG',
         'SUPPLIER_CODE',I.SUPPLIER_CODE,'FACTORY_CODE',NULL);
      
      --SCMDATA.T_APP_CAPACITY_CFG
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_APP_CAPACITY_CFG',
         'SUPPLIER_CODE',I.SUPPLIER_CODE,'FACTORY_CODE',NULL);
      
      --SCMDATA.T_SUPPLIER_START_WORK_CFG
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_SUPPLIER_START_WORK_CFG',
         'FACTORY_CODE',NULL);
      
      --SCMDATA.T_PRODUCT_CYCLE_CFG;SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG;SCMDATA.T_STANDARD_WORK_MINTE_CFG
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2,IR_COLNAME3,IR_COLVALUE3)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_PRODUCT_CYCLE_CFG',
         'CATEGORY', NULL, 'PRODUCT_CATE', NULL, 'SUBCATEGORY', NULL);
      
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2,IR_COLNAME3,IR_COLVALUE3)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG',
         'CATEGORY', NULL, 'PRODUCT_CATE', NULL, 'SUBCATEGORY', NULL);
      
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2,IR_COLNAME3,IR_COLVALUE3)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_STANDARD_WORK_MINTE_CFG',
         'CATEGORY', NULL, 'PRODUCT_CATE', NULL, 'SUBCATEGORY', NULL);
      
      --SCMDATA.T_SUPPLIER_CAPACITY_DETAIL
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2,IR_COLNAME3,IR_COLVALUE3)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_SUPPLIER_CAPACITY_DETAIL',
         'SUPPLIER_CODE',I.SUPPLIER_CODE,'FACTORY_CODE',NULL,'CATEGORY',NULL);
      
      --SCMDATA.T_SUPPLIER_CAPACITY_DETAIL
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2,IR_COLNAME3,IR_COLVALUE3)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_SUPPLIER_CAPACITY_DETAIL',
         'SUPPLIER_CODE',I.SUPPLIER_CODE,'FACTORY_CODE',NULL,'CATEGORY',NULL);
      
      --SCMDATA.T_PRODUCTION_SCHEDULE
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2,IR_COLNAME3,IR_COLVALUE3,
         IR_COLNAME4,IR_COLVALUE4,IR_COLNAME5,IR_COLVALUE5,
         IR_COLNAME6,IR_COLVALUE6)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_PRODUCTION_SCHEDULE',
         'SUPPLIER_CODE',I.SUPPLIER_CODE,'FACTORY_CODE',NULL,
         'CATEGORY', NULL, 'PRODUCT_CATE', NULL, 'SUBCATEGORY', NULL,
         'DELIVERY_DATE',NULL);
      
      --SCMDATA.T_SUPCAPACITY_WEEK_PLAN
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2,IR_COLNAME3,IR_COLVALUE3,
         IR_COLNAME4,IR_COLVALUE4,IR_COLNAME5,IR_COLVALUE5)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_SUPCAPACITY_WEEK_PLAN',
         'SUPPLIER_CODE',I.SUPPLIER_CODE,'FACTORY_CODE',NULL,'CATEGORY',NULL,
         'PRODUCT_CATE',NULL,'SUBCATEGORY',NULL);
      
      --SCMDATA.T_CATECAPACITY_WEEK_PLAN
      INSERT INTO SCMDATA.T_QUEUE_IFLROWS
        (IFLROWS_ID,COMPANY_ID,QUEUE_ID,IR_TAB,IR_COLNAME1,IR_COLVALUE1,
         IR_COLNAME2,IR_COLVALUE2,IR_COLNAME3,IR_COLVALUE3,
         IR_COLNAME4,IR_COLVALUE4,IR_COLNAME5,IR_COLVALUE5)
      VALUES
        (SCMDATA.F_GET_UUID(),I.COMPANY_ID,V_QUEUEID,'SCMDATA.T_CATECAPACITY_WEEK_PLAN',
         'SUPPLIER_CODE',I.SUPPLIER_CODE,'FACTORY_CODE',NULL,'CATEGORY',NULL,
         'PRODUCT_CATE',NULL,'SUBCATEGORY',NULL);*/
    END LOOP;
  END p_gen_day_refresh_wkplan_rela;

  /*===================================================================================
  
    周产能规划数据日刷新
  
    版本:
      2022-07-20 : 周产能规划数据日刷新
  
  ===================================================================================*/
  PROCEDURE p_capcwkpln_day_refresh IS
  
  BEGIN
    FOR i IN (SELECT DISTINCT supplier_code,
                              category,
                              company_id
                FROM scmdata.t_supcapacity_week_plan) LOOP
      p_gen_wkplanrecalcrela(v_supcode  => i.supplier_code,
                             v_cate     => i.category,
                             v_operid   => 'ADMIN',
                             v_opertime => to_char(SYSDATE,
                                                   'YYYY-MM-DD HH24-MI-SS'),
                             v_compid   => i.company_id);
      /*SCMDATA.PKG_CAPACITY_EFFLOGIC_prd.P_IU_WEEKPLAN_DATA(V_SUPCODE  => I.SUPPLIER_CODE,
      V_CATE     => I.CATEGORY,
      V_OPERID   => 'ADMIN',
      V_OPERTIME => TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS'),
      V_COMPID   => I.COMPANY_ID);*/
    END LOOP;
  END p_capcwkpln_day_refresh;

  /*========================================================================================
  
    指定工厂生效逻辑
  
    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业id
  
    版本:
      2022-12-17 : 指定工厂生效逻辑
  
  ========================================================================================*/
  PROCEDURE p_specify_ordfactory_efflogic
  (
    v_inp_queueid IN VARCHAR2,
    v_inp_compid  IN VARCHAR2
  ) IS
    v_supcode  VARCHAR2(32);
    v_cate     VARCHAR2(2);
    v_operid   VARCHAR2(32);
    v_opertime VARCHAR2(32);
  BEGIN
    --获取操作人，操作时间
    SELECT MAX(create_id),
           MAX(to_char(create_time, 'yyyy-mm-dd hh24-mi-ss'))
      INTO v_operid,
           v_opertime
      FROM scmdata.t_queue
     WHERE queue_id = v_inp_queueid
       AND company_id = v_inp_compid;
  
    --获取供应商编码，分类编码
    SELECT MAX(ir_colvalue1),
           MAX(ir_colvalue3)
      INTO v_supcode,
           v_cate
      FROM scmdata.t_queue_iflrows
     WHERE queue_id = v_inp_queueid
       AND company_id = v_inp_compid;
  
    --生成周产能规划重算任务
    p_gen_wkplanrecalcrela(v_supcode  => v_supcode,
                           v_cate     => v_cate,
                           v_operid   => v_operid,
                           v_opertime => v_opertime,
                           v_compid   => v_inp_compid);
  END p_specify_ordfactory_efflogic;

  /*===================================================================================
  
    生效逻辑
  
    用途:
      品类合作供应商生效逻辑
  
    入参:
      V_QUEUEID      :  队列Id
      V_COMPID       :  企业Id
  
    版本:
      2022-02-27 : 品类合作供应商生效逻辑
  
  ===================================================================================*/
  PROCEDURE p_efflogic
  (
    v_queueid IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_vctab    VARCHAR2(64);
    v_vccond   VARCHAR2(512);
    v_vcmethod VARCHAR2(8);
  BEGIN
    SELECT MAX(vc_tab),
           MAX(vc_cond),
           MAX(vc_method)
      INTO v_vctab,
           v_vccond,
           v_vcmethod
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    --更新队列执行时间
    UPDATE scmdata.t_queue
       SET queueexe_time = SYSDATE
     WHERE queue_id = v_queueid
       AND company_id = v_compid;
  
    IF v_vctab = 'SCMDATA.T_COOPCATE_SUPPLIER_CFG' THEN
      --品类合作供应商配置
      p_coopcatesupcfg_efflogic(v_queueid => v_queueid,
                                v_cond    => v_vccond,
                                v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_COOPCATE_FACTORY_CFG' THEN
      --品类合作生产工厂配置
      p_coopcatefaccfg_efflogic(v_queueid => v_queueid,
                                v_cond    => v_vccond,
                                v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_APP_CAPACITY_CFG' THEN
      --生产工厂产能预约配置
      p_facappcapccfg_efflogic(v_queueid => v_queueid,
                               v_compid  => v_compid,
                               v_cond    => v_vccond);
    
    ELSIF v_vctab = 'SCMDATA.T_SUPPLIER_START_WORK_CFG' THEN
      --供应商开工通用配置
      p_startworkcfg_efflogic(v_queueid => v_queueid,
                              v_compid  => v_compid,
                              v_cond    => v_vccond,
                              v_method  => v_vcmethod);
    
    ELSIF v_vctab = 'SCMDATA.T_STANDARD_WORK_MINTE_CFG' THEN
      --标准工时配置
      p_stdwtcfg_efflogic(v_queueid => v_queueid,
                          v_compid  => v_compid,
                          v_cond    => v_vccond,
                          v_method  => v_vcmethod);
    
    ELSIF v_vctab = 'SCMDATA.T_SUPPLIER_CAPACITY_DETAIL' THEN
      --供应商产能预约不开工日期修改
      p_supcapcapp_notworkupd_efflogic(v_queueid => v_queueid,
                                       v_cond    => v_vccond,
                                       v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL' THEN
      --供应商产能预约明细
      p_supcapcapp_upd_efflogic(v_queueid => v_queueid,
                                v_cond    => v_vccond,
                                v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_PLAN_NEWPRODUCT' THEN
      --预计新品
      p_plannew_efflogic(v_queueid => v_queueid,
                         v_cond    => v_vccond,
                         v_method  => v_vcmethod,
                         v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_PLANNEW_SUPPLEMENTARY' THEN
      --预计补单
      p_plansupp_efflogic(v_queueid => v_queueid,
                          v_cond    => v_vccond,
                          v_method  => v_vcmethod,
                          v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_CAPACITY_PLAN_CATEGORY_CFG' THEN
      --品类配置
      p_cateplan_efflogic_cg(v_queueid => v_queueid,
                             v_compid  => v_compid,
                             v_cond    => v_vccond,
                             v_method  => v_vcmethod);
    
    ELSIF v_vctab = 'SCMDATA.T_PRODUCT_CYCLE_CFG' THEN
      --生产周期配置
      p_prodcyccfg_efflogic(v_queueid => v_queueid,
                            v_compid  => v_compid,
                            v_cond    => v_vccond,
                            v_method  => v_vcmethod);
    ELSIF v_vctab = 'SCMDATA.T_ORDERED' THEN
      --ORDERED 更新生效逻辑
      p_ordered_upd_efflogic(v_queueid => v_queueid,
                             v_cond    => v_vccond,
                             v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_ORDERS' THEN
      --ORDERS 更新生效逻辑
      p_orders_upd_efflogic(v_queueid => v_queueid,
                            v_cond    => v_vccond,
                            v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_SUPPLIER_INFO' THEN
      --供应商档案修改
      p_supdoc_efflogic(v_queueid => v_queueid,
                        v_vccond  => v_vccond,
                        v_qcompid => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_COOP_SCOPE' THEN
      --供应商档案合作范围增改
      p_supscp_iu_efflogic(v_queueid => v_queueid,
                           v_cond    => v_vccond,
                           v_compid  => v_compid);
    
    ELSIF v_vctab = 'SCMDATA.T_COOP_FACTORY' THEN
      --供应商档案合作工厂
      p_supfac_efflogic(v_inp_queue_id   => v_queueid,
                        v_inp_cond       => v_vccond,
                        v_inp_method     => v_vcmethod,
                        v_inp_company_id => v_compid);
    END IF;
  END p_efflogic;

END pkg_capacity_efflogic_prd;
/

