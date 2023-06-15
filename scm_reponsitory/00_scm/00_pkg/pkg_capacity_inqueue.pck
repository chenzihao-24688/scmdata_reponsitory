CREATE OR REPLACE PACKAGE SCMDATA.pkg_capacity_inqueue IS

  /*===================================================================================
  
    品类合作供应商主表启用/停用 【view层即时生效】 逻辑
  
    用途:
      用于品类合作供应商主表操作启用/停用后在view层即时生效
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_cscids     :  选择数据id，多值用分号隔开
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_pause      :  启用/停用  0-启用 1停用
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-14 : 品类合作供应商启用/停用 【view层即时生效】 逻辑
      2022-01-18 : 新增 v_method 参数
  
  ===================================================================================*/
  PROCEDURE p_coopsup_pausechange
  (
    v_cscids    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_pause     IN NUMBER,
    v_method    IN VARCHAR2
  );

  /*===================================================================================
  
    viewlogic
    品类合作供应商新增
  
    入参:
      v_supcode  :  供应商编码
      v_cate     :  分类id
      v_procate  :  生产分类id
      v_subcate  :  产品子类id
      v_compid   :  企业id
  
    版本:
      2022-08-10 : 品类合作供应商新增
      scmdata.t_coopcate_supplier_cfg
  
  ===================================================================================*/
  PROCEDURE p_coopsup_i_checklogic
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    viewlogic
    品类合作供应商新增
  
    入参:
      v_queueid  :  队列id
      v_compid   :  企业id
  
    版本:
      2022-08-10 : 品类合作供应商新增
      scmdata.t_coopcate_supplier_cfg
  
  ===================================================================================*/
  PROCEDURE p_coopsup_i_viewlogic
  (
    v_cscid   IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_creid   IN VARCHAR2,
    v_credate IN VARCHAR2
  );

  /*===================================================================================
  
    品类合作供应商从表启用/停用 【view层即时生效】 逻辑
  
    用途:
      品类合作供应商从表启用/停用 【view层即时生效】 逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_cfcids     :  选择数据id，多值用分号隔开
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_pause      :  启用/停用  0-启用 1停用
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-14 : 品类合作供应商从表启用/停用 【view层即时生效】 逻辑
      2022-01-18 : 新增 v_method 参数
  
  ===================================================================================*/
  PROCEDURE p_coopfac_pausechange
  (
    v_cfcids    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_pause     IN NUMBER,
    v_method    IN VARCHAR2
  );

  /*===================================================================================
  
    生产工厂产能预约配置【view层即时生效】 逻辑
  
    用途:
      用于生产工厂产能预约配置【view层即时生效】 逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid      :  选择数据id
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_apprate    :  预约产能占比
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 生产工厂产能预约配置【view层即时生效】 逻辑
      2022-01-18 : 新增 v_method 参数
  
  ===================================================================================*/
  PROCEDURE p_appcapc_appratechange
  (
    v_accid     IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_apprate   IN NUMBER,
    v_method    IN VARCHAR2
  );

  /*===================================================================================
  
    供应商开工通用配置【view层即时生效】逻辑
  
    用途:
      用于供应商开工通用配置【view层即时生效】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid      :  选择数据id
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_braid      :  分类/分部id
      v_provinceid :  省id
      v_cityid     :  市id
      v_countyid   :  区id
      v_year       :  年份
      v_weeknw     :  周不开工
      v_monthnw    :  月不开工
      v_yearnw     :  年不开工
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 供应商开工通用配置【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_supstarwork_change
  (
    v_sswcid     IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_curuserid  IN VARCHAR2,
    v_braid      IN VARCHAR2,
    v_provinceid IN VARCHAR2,
    v_cityid     IN VARCHAR2,
    v_countyid   IN VARCHAR2,
    v_year       IN NUMBER,
    v_weeknw     IN VARCHAR2,
    v_monthnw    IN VARCHAR2,
    v_yearnw     IN VARCHAR2,
    v_method     IN VARCHAR2
  );

  /*===================================================================================
  
    生产工厂开工通用配置【view层即时生效】逻辑
  
    用途:
      用于生产工厂开工通用配置【view层即时生效】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid      :  选择数据id
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_faccode    :  生产工厂编码
      v_year       :  年份
      v_weeknw     :  周不开工
      v_monthnw    :  月不开工
      v_yearnw     :  年不开工
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 生产工厂开工通用配置【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_facstarwork_change
  (
    v_sswcid    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_faccode   IN VARCHAR2,
    v_year      IN NUMBER,
    v_weeknw    IN VARCHAR2,
    v_monthnw   IN VARCHAR2,
    v_yearnw    IN VARCHAR2,
    v_method    IN VARCHAR2
  );

  /*===================================================================================
  
    标准工时配置【view层即时生效】逻辑
  
    用途:
      用于标准工时配置【view层即时生效】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid      :  选择数据id
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_faccode    :  生产工厂编码
      v_year       :  年份
      v_weeknw     :  周不开工
      v_monthnw    :  月不开工
      v_yearnw     :  年不开工
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 标准工时配置【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_stdwktime_cfg_infochange
  (
    v_swmcid    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_cate      IN VARCHAR2,
    v_procate   IN VARCHAR2,
    v_subcate   IN VARCHAR2,
    v_stdwktime IN NUMBER,
    v_method    IN VARCHAR2
  );

  /*===================================================================================
    产能品类规划配置【view层即时生效】逻辑
  
      用途：
      用于产能品类规划配置【view层即时生效】逻辑
  
      入参：
        v_cpccid     选择数据主键id
        v_compid     企业id
        v_curuserid  操作人id
        v_cate       分类
        v_procate    生产类别
        v_subcate    子类
        v_inplan     是否做产能规划，1是0否
        v_method     操作方式 ins-新增 upd-修改 del-删除
  
  
  
  ====================================================================================*/
  PROCEDURE p_capaplan_change
  (
    v_cpccid    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_cate      IN VARCHAR2,
    v_procate   IN VARCHAR2,
    v_subcate   IN VARCHAR2,
    v_inplan    IN NUMBER,
    v_method    IN VARCHAR2
  );

  /*===================================================================================
  
    生产周期配置【view层即时生效】逻辑
  
    用途:
      用于生产周期配置【view层即时生效】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid        :  选择数据id
      v_compid       :  企业id
      v_curuserid    :  当前操作人id
      v_cate         :  分类
      v_procate      :  生产分类
      v_subcate      :  子类
      v_supcodes     :  供应商编码，多值
      v_firordmatw   :  首单待料天数
      v_addordmatw   :  补单待料天数
      v_pctransmatw  :  后整及物流天数
      v_method       :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 生产周期配置【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_prodcyc_cfg_infochange
  (
    v_pccid       IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_curuserid   IN VARCHAR2,
    v_cate        IN VARCHAR2,
    v_procate     IN VARCHAR2,
    v_subcate     IN VARCHAR2,
    v_supcodes    IN VARCHAR2,
    v_firordmatw  IN NUMBER,
    v_addordmatw  IN NUMBER,
    v_pctransmatw IN NUMBER,
    v_method      IN VARCHAR2
  );

  /*===================================================================================
  
    供应商产能预约主表修改 【view层即时生效】 逻辑
  
    用途:
      用于供应商产能预约主表修改 【view层即时生效】 逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_ptcid      :  选择数据id，多值用分号隔开
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_pause      :  启用/停用  0-启用 1停用
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-20 : 供应商产能预约主表修改 【view层即时生效】 逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcapc_ntwkdchange
  (
    v_ptcid      IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_curuserid  IN VARCHAR2,
    v_notworkday IN VARCHAR2,
    v_method     IN VARCHAR2
  );

  /*===================================================================================
  
    供应商产能预约从表修改 【view层即时生效】 逻辑
  
    用途:
      用于供应商产能预约从表修改 【view层即时生效】 逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_ctddid     :  选择数据id
      v_compid     :  企业id
      v_operid     :  当前操作人id
      v_opertime   :  操作时间，格式 yyyy-mm-dd hh24-mi-ss
      v_wkhour     :  上班时数
      v_wkpeople   :  车位人数
      v_appcrate   :  预约产能占比
      v_prodeff    :  生产效率
      v_memo       :  备注
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-20 : 供应商产能预约从表修改 【view层即时生效】 逻辑
  
  ===================================================================================*/
  PROCEDURE p_capcapp_infochange
  (
    v_ctddid   IN VARCHAR2,
    v_compid   IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_wkhour   IN NUMBER,
    v_wkpeople IN NUMBER,
    v_appcrate IN NUMBER,
    v_prodeff  IN NUMBER,
    v_memo     IN VARCHAR2,
    v_method   IN VARCHAR2
  );

  /*===================================================================================
  
    预计新品【view层即时生效】逻辑
  
    用途:
      用于预计新品【view层即时生效】逻辑
  
    入参:
      v_pnid            :  选择数据id
      v_compid          :  企业id
      v_operid          :  当前操作人id
      v_opertime        :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_changestatus    :  修改状态
      v_cate            :  分类
      v_procate         :  生产分类
      v_subcate         :  子类
      v_year            ： 年份
      v_season          :  季节
      v_ware            :  波段
      v_warestatus      :  波段生效状态
      v_supcode         :  供应商编码
      v_preordamt       :  预计订购品种数
      v_hotprodmamt     :  爆品可能数量
      v_normprodmamt    :  非爆品可能数量
      v_preorddate      :  预计下单日期
      v_predeldate      :  预计下单交期
      v_hotprodavgamt   :  爆品平均单量
      v_normprodavgamt  :  非爆品平均单量
      v_memo            :  备注
      v_method          :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-22 : 预计新品【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_plannew_infochange
  (
    v_pnid           IN VARCHAR2,
    v_compid         IN VARCHAR2,
    v_operid         IN VARCHAR2,
    v_opertime       IN VARCHAR2,
    v_changestatus   IN VARCHAR2,
    v_cate           IN VARCHAR2,
    v_procate        IN VARCHAR2,
    v_subcate        IN VARCHAR2,
    v_season         IN VARCHAR2,
    v_ware           IN NUMBER,
    v_warestatus     IN VARCHAR2,
    v_supcode        IN VARCHAR2,
    v_preordamt      IN NUMBER,
    v_hotprodmamt    IN NUMBER,
    v_normprodmamt   IN NUMBER,
    v_preorddate     IN DATE,
    v_predeldate     IN DATE,
    v_hotprodavgamt  IN NUMBER,
    v_normprodavgamt IN NUMBER,
    v_memo           IN VARCHAR2,
    v_method         IN VARCHAR2
  );

  /*===================================================================================
  
    预计新品波段生效状态自动变更view层生效
  
    用途:
      预计新品波段生效状态自动变更view层生效
  
    版本:
      2022-05-31 : 预计新品波段生效状态自动变更view层生效
  
  ===================================================================================*/
  PROCEDURE p_pln_autowavestatucg_viewgenerate
  (
    v_pnid   IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    预计补单生效状态自动变更view层生效
  
    用途:
      预计补单生效状态自动变更view层生效
  
    版本:
      2022-08-04 : 预计补单生效状态自动变更view层生效
  
  ===================================================================================*/
  PROCEDURE p_pls_autoactstatucg_viewgenerate
  (
    v_psid   IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    预计新品信息修改从表【view层即时生效】逻辑
  
    用途:
      用于预计新品信息修改从表【view层即时生效】逻辑
  
    入参:
      v_pnid           :  预计新品表id
      v_compid         :  企业id
      v_operid         :  当前操作人id
      v_opertime       :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_hotprodmamt    :  爆品可能种数
      v_normprodmamt   :  非爆品可能种数
      v_hotprodavgamt  :  爆品平均单量
      v_normprodavgamt :  非爆品平均单量
      v_preorddate     :  预计下单日期
      v_predeldate     :  预计交期
      v_cate           :  分类
      v_pcate          :  生产分类
      v_scate          :  子类
  
    版本:
      2022-01-22 : 预计新品信息修改从表【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_gen_prodplannew_infochange
  (
    v_pnid           IN VARCHAR2,
    v_compid         IN VARCHAR2,
    v_operid         IN VARCHAR2,
    v_opertime       IN VARCHAR2,
    v_hotprodmamt    IN NUMBER,
    v_normprodmamt   IN NUMBER,
    v_hotprodavgamt  IN NUMBER,
    v_normprodavgamt IN NUMBER,
    v_preorddate     IN DATE,
    v_predeldate     IN DATE,
    v_cate           IN VARCHAR2,
    v_pcate          IN VARCHAR2,
    v_scate          IN VARCHAR2
  );

  /*===================================================================================
  
    预计补单生产排期【view层即时生效】逻辑
  
    用途:
      用于预计补单生产排期【view层即时生效】逻辑
  
    入参:
      v_pnsid           :  预计补单表id
      v_operid          :  当前操作人id
      v_opertime        :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_method          :  操作方式 ins-新增 upd-修改 del-删除
      v_compid          :  企业id
  
    版本:
      2022-07-26 : 预计补单生产排期【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_gen_newprodscheview_data_4pln
  (
    v_pnid     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN DATE,
    v_method   IN VARCHAR2,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    预计补单【view层即时生效】逻辑
  
    用途:
      用于预计补单【view层即时生效】逻辑
  
    入参:
      v_pnid            :  预计补单表id
      v_compid          :  企业id
      v_operid          :  当前操作人id
      v_opertime        :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_cate            :  分类
      v_procate         :  生产分类
      v_subcate         :  子类
      v_actstatus       :  生效状态
      v_supcode         :  供应商编码
      v_preorddate      :  预计下单日期
      v_predeldate      :  预计下单交期
      v_preordamt       :  预计下单数量
      v_method          :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-07-26 : 预计补单【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_plansupp_infochange
  (
    v_pnsid        IN VARCHAR2,
    v_compid       IN VARCHAR2,
    v_operid       IN VARCHAR2,
    v_opertime     IN VARCHAR2,
    v_cate         IN VARCHAR2,
    v_procate      IN VARCHAR2,
    v_subcate      IN VARCHAR2,
    v_actstatus    IN VARCHAR2,
    v_supcode      IN VARCHAR2,
    v_preorddate   IN VARCHAR2,
    v_predeldate   IN VARCHAR2,
    v_preordamt    IN VARCHAR2,
    v_changestatus IN VARCHAR2,
    v_method       IN VARCHAR2
  );

  /*===================================================================================
  
    预计补单生产排期【view层即时生效】逻辑
  
    用途:
      用于预计补单生产排期【view层即时生效】逻辑
  
    入参:
      v_pnsid           :  预计补单表id
      v_operid          :  当前操作人id
      v_opertime        :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_method          :  操作方式 ins-新增 upd-修改 del-删除
      v_compid          :  企业id
  
    版本:
      2022-07-26 : 预计补单生产排期【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_gen_newprodscheview_data_4pls
  (
    v_pnsid    IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN DATE,
    v_method   IN VARCHAR2,
    v_compid   IN VARCHAR2
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
  
  ===================================================================================*/
  PROCEDURE p_gen_orditf_inqueue(v_compid IN VARCHAR2);

  /*========================================================================================
  
    指定工厂入队逻辑
  
    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业id
  
    版本:
      2022-12-17 : 指定工厂入队逻辑
  
  ========================================================================================*/
  PROCEDURE p_specify_ordfactory_inqueue
  (
    v_inp_ordid  IN VARCHAR2,
    v_inp_compid IN VARCHAR2
  );

  /*===================================================================================
  
    【通用入队】逻辑
  
    用途:
      【通用入队】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_pause      :  启用/停用  0-启用 1停用
      v_tab        :  值变更表名称
      v_viewtab    :  值变更 view 表名称
      v_unqfields  :  值变更表-唯一列
      v_ckfields   :  值变更表-变更值列
      v_conds      :  查找值变更表变更记录条件
      v_method     :  值变更方式
      v_viewlogic  :  view 层即时生效逻辑
      v_queuetype  :  队列类型
  
    版本:
      2022-01-17 : 【通用入队】逻辑
  
  ===================================================================================*/
  PROCEDURE p_common_inqueue
  (
    v_curuserid IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_tab       IN VARCHAR2,
    v_viewtab   IN VARCHAR2 DEFAULT NULL,
    v_unqfields IN VARCHAR2,
    v_ckfields  IN VARCHAR2,
    v_conds     IN VARCHAR2,
    v_method    IN VARCHAR2,
    v_viewlogic IN CLOB,
    v_queuetype IN VARCHAR2
  );

END pkg_capacity_inqueue;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_capacity_inqueue IS

  /*===================================================================================
  
    品类合作供应商主表启用/停用 【view层即时生效】 逻辑
  
    用途:
      用于品类合作供应商主表操作启用/停用后在view层即时生效
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_cscids     :  选择数据id，多值用分号隔开
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_pause      :  启用/停用  0-启用 1停用
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-14 : 品类合作供应商启用/停用 【view层即时生效】 逻辑
      2022-01-18 : 新增 v_method 参数
  
  ===================================================================================*/
  PROCEDURE p_coopsup_pausechange
  (
    v_cscids    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_pause     IN NUMBER,
    v_method    IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    -- view 层即时修改即时生效
    -- 主表生效
    FOR i IN (SELECT *
                FROM scmdata.t_coopcate_supplier_cfg
               WHERE instr(';' || v_cscids || ';', ';' || csc_id || ';') > 0
                 AND company_id = v_compid) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_coop_supfac_cfg_view
       WHERE csc_id = i.csc_id
         AND company_id = i.company_id
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_coop_supfac_cfg_view
          (cscv_id, company_id, csc_id, pause, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), i.company_id, i.csc_id, v_pause, v_curuserid, SYSDATE, v_method);
      ELSE
        UPDATE scmdata.t_coop_supfac_cfg_view
           SET pause          = v_pause,
               operate_id     = v_curuserid,
               operate_time   = SYSDATE,
               operate_method = v_method
         WHERE csc_id = i.csc_id
           AND company_id = i.company_id;
      END IF;
    END LOOP;
  
    -- 从表生效
    FOR l IN (SELECT *
                FROM scmdata.t_coopcate_factory_cfg
               WHERE instr(';' || v_cscids || ';', ';' || csc_id || ';') > 0
                 AND company_id = v_compid) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_coop_supfac_cfg_view
       WHERE cfc_id = l.cfc_id
         AND company_id = l.company_id
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_coop_supfac_cfg_view
          (cscv_id, company_id, cfc_id, pause, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), l.company_id, l.cfc_id, v_pause, v_curuserid, SYSDATE, v_method);
      ELSE
        UPDATE scmdata.t_coop_supfac_cfg_view
           SET pause          = v_pause,
               operate_id     = v_curuserid,
               operate_time   = SYSDATE,
               operate_method = v_method
         WHERE cfc_id = l.cfc_id
           AND company_id = l.company_id;
      END IF;
    END LOOP;
  END p_coopsup_pausechange;

  /*===================================================================================
  
    viewlogic
    品类合作供应商新增
  
    入参:
      v_supcode  :  供应商编码
      v_cate     :  分类id
      v_procate  :  生产分类id
      v_subcate  :  产品子类id
      v_compid   :  企业id
  
    版本:
      2022-08-10 : 品类合作供应商新增
      scmdata.t_coopcate_supplier_cfg
  
  ===================================================================================*/
  PROCEDURE p_coopsup_i_checklogic
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_errinfo CLOB;
    v_jugnum  NUMBER(1);
  BEGIN
    scmdata.pkg_common_check.p_comm_check_supcode(v_supcode => v_supcode,
                                                  v_compid  => v_compid,
                                                  v_errinfo => v_errinfo);
  
    scmdata.pkg_common_check.p_comm_check_cate(v_cate    => v_cate,
                                               v_errinfo => v_errinfo);
  
    scmdata.pkg_common_check.p_comm_check_procate(v_procate => v_procate,
                                                  v_cate    => v_cate,
                                                  v_errinfo => v_errinfo);
  
    scmdata.pkg_common_check.p_comm_check_subcate(v_subcate => v_subcate,
                                                  v_procate => v_procate,
                                                  v_compid  => v_compid,
                                                  v_errinfo => v_errinfo);
  
    IF v_supcode IS NOT NULL
       AND v_cate IS NOT NULL
       AND v_procate IS NOT NULL
       AND v_subcate IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supplier_info tsi
       INNER JOIN scmdata.t_coop_scope tcs
          ON tsi.supplier_info_id = tcs.supplier_info_id
         AND tsi.company_id = tcs.company_id
       WHERE tsi.supplier_code = v_supcode
         AND tsi.company_id = v_compid
         AND tcs.coop_classification = v_cate
         AND tcs.coop_product_cate = v_procate
         AND instr(tcs.coop_subcategory, v_subcate) > 0
         AND tcs.company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '供应商档案-合作范围中不存在此分类-生产分类-产品子类',
                                                  v_middliestr => chr(10));
      END IF;
    
      SELECT nvl(MAX(1), 0)
        INTO v_jugnum
        FROM scmdata.t_coopcate_supplier_cfg
       WHERE supplier_code = v_supcode
         AND coop_category = v_cate
         AND coop_productcate = v_procate
         AND coop_subcategory = v_subcate
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 1 THEN
        v_errinfo := scmdata.f_sentence_append_rc(v_sentence   => v_errinfo,
                                                  v_appendstr  => '供应商-分类-生产分类-产品子类数据已在品类合作供应商表内存在',
                                                  v_middliestr => chr(10));
      END IF;
    END IF;
  
    IF v_errinfo IS NOT NULL THEN
      raise_application_error(-20002, v_errinfo);
    END IF;
  END p_coopsup_i_checklogic;

  /*===================================================================================
  
    viewlogic
    品类合作供应商新增
  
    入参:
      v_queueid  :  队列id
      v_compid   :  企业id
  
    版本:
      2022-08-10 : 品类合作供应商新增
      scmdata.t_coopcate_supplier_cfg
  
  ===================================================================================*/
  PROCEDURE p_coopsup_i_viewlogic
  (
    v_cscid   IN VARCHAR2,
    v_compid  IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_creid   IN VARCHAR2,
    v_credate IN VARCHAR2
  ) IS
    v_wt     NUMBER(8, 2);
    v_wp     NUMBER(8, 2);
    v_pe     NUMBER(8, 2);
    v_jugnum NUMBER(1);
  BEGIN
    INSERT INTO scmdata.t_coopcate_supplier_cfg
      (csc_id, company_id, supplier_code, coop_category, coop_productcate, coop_subcategory, pause, create_id, create_time)
    VALUES
      (v_cscid, v_compid, v_supcode, v_cate, v_procate, v_subcate, 1, v_creid, to_date(v_credate,
                'YYYY-MM-DD HH24-MI-SS'));
  
    INSERT INTO scmdata.t_coop_supfac_cfg_view
      (cscv_id, company_id, csc_id, pause, operate_id, operate_time, operate_method)
    VALUES
      (scmdata.f_get_uuid(), v_compid, v_cscid, 0, v_creid, to_date(v_credate,
                'YYYY-MM-DD HH24-MI-SS'), 'INS');
  
    FOR i IN (SELECT factory_code,
                     company_id,
                     sign(facfilepause + copfacpause + copscppause +
                          protypepause + copmodlepause) pause
                FROM (SELECT tcf.factory_code,
                             tcf.company_id,
                             decode(ttsi.pause, 2, 0, ttsi.pause) facfilepause,
                             tcf.pause copfacpause,
                             tcsf.pause copscppause,
                             decode(nvl(ttsi.product_type, '00'), '00', 0, 1) protypepause,
                             (CASE
                               WHEN tsi.cooperation_model = 'OF' THEN
                                1
                               ELSE
                                0
                             END) copmodlepause
                        FROM scmdata.t_supplier_info tsi
                       INNER JOIN scmdata.t_coop_scope tcss
                          ON tsi.supplier_info_id = tcss.supplier_info_id
                         AND tsi.company_id = tcss.company_id
                         AND tcss.coop_classification = v_cate
                         AND tcss.coop_product_cate = v_procate
                         AND instr(tcss.coop_subcategory, v_subcate) > 0
                       INNER JOIN scmdata.t_coop_factory tcf
                          ON tsi.supplier_info_id = tcf.supplier_info_id
                         AND tsi.company_id = tcf.company_id
                       INNER JOIN scmdata.t_coop_scope tcsf
                          ON tcf.fac_sup_info_id = tcsf.supplier_info_id
                         AND tcf.company_id = tcsf.company_id
                         AND tcsf.coop_classification = v_cate
                         AND tcsf.coop_product_cate = v_procate
                         AND instr(tcsf.coop_subcategory, v_subcate) > 0
                       INNER JOIN scmdata.t_supplier_info ttsi
                          ON tcf.fac_sup_info_id = ttsi.supplier_info_id
                         AND tcf.company_id = ttsi.company_id
                       WHERE tsi.supplier_code = v_supcode
                         AND tsi.company_id = v_compid)) LOOP
      IF i.factory_code IS NOT NULL THEN
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_coopcate_factory_cfg
         WHERE csc_id = v_cscid
           AND company_id = v_compid
           AND factory_code = i.factory_code
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_coopcate_factory_cfg
            (cfc_id, company_id, csc_id, factory_code, pause, is_show, create_id, create_time)
          VALUES
            (scmdata.f_get_uuid(), i.company_id, v_cscid, i.factory_code, i.pause, i.pause, v_creid, to_date(v_credate,
                      'YYYY-MM-DD HH24-MI-SS'));
        ELSE
          UPDATE scmdata.t_coopcate_factory_cfg
             SET is_show = i.pause
           WHERE csc_id = v_cscid
             AND factory_code = i.factory_code
             AND company_id = i.company_id;
        END IF;
      
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_app_capacity_cfg
         WHERE category = v_cate
           AND supplier_code = v_supcode
           AND factory_code = i.factory_code
           AND company_id = i.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          SELECT MAX(work_hours_day),
                 MAX(to_number(worker_num)),
                 MAX(product_efficiency)
            INTO v_wt,
                 v_wp,
                 v_pe
            FROM scmdata.t_supplier_info
           WHERE supplier_code = i.factory_code
             AND company_id = i.company_id
             AND rownum = 1;
        
          INSERT INTO scmdata.t_app_capacity_cfg
            (acc_id, company_id, category, supplier_code, factory_code, wktime_num, wkperson_num, prod_eff, restcapc_rate, create_id, create_time)
          VALUES
            (scmdata.f_get_uuid(), i.company_id, v_cate, v_supcode, i.factory_code, v_wt, v_wp, v_pe, 100, v_creid, to_date(v_credate,
                      'YYYY-MM-DD HH24-MI-SS'));
        
          scmdata.pkg_capacity_efflogic.p_ins_faccode_into_tab(v_faccode => i.factory_code,
                                                               v_compid  => i.company_id);
        END IF;
      END IF;
    
    END LOOP;
  END p_coopsup_i_viewlogic;

  /*===================================================================================
  
    品类合作供应商从表启用/停用 【view层即时生效】 逻辑
  
    用途:
      品类合作供应商从表启用/停用 【view层即时生效】 逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_cfcids     :  选择数据id，多值用分号隔开
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_pause      :  启用/停用  0-启用 1停用
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-14 : 品类合作供应商从表启用/停用 【view层即时生效】 逻辑
      2022-01-18 : 新增 v_method 参数
  
  ===================================================================================*/
  PROCEDURE p_coopfac_pausechange
  (
    v_cfcids    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_pause     IN NUMBER,
    v_method    IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    -- view 层即时修改即时生效
    -- 从表生效
    FOR l IN (SELECT *
                FROM scmdata.t_coopcate_factory_cfg
               WHERE instr(';' || v_cfcids || ';', ';' || cfc_id || ';') > 0
                 AND company_id = v_compid) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_coop_supfac_cfg_view
       WHERE cfc_id = l.cfc_id
         AND company_id = l.company_id
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_coop_supfac_cfg_view
          (cscv_id, company_id, cfc_id, pause, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), l.company_id, l.cfc_id, v_pause, v_curuserid, SYSDATE, v_method);
      ELSE
        UPDATE scmdata.t_coop_supfac_cfg_view
           SET pause          = v_pause,
               operate_id     = v_curuserid,
               operate_time   = SYSDATE,
               operate_method = v_method
         WHERE cfc_id = l.cfc_id
           AND company_id = l.company_id;
      END IF;
    END LOOP;
  END p_coopfac_pausechange;

  /*===================================================================================
  
    生产工厂产能预约配置【view层即时生效】 逻辑
  
    用途:
      用于生产工厂产能预约配置【view层即时生效】 逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid      :  选择数据id
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_apprate    :  预约产能占比
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 生产工厂产能预约配置【view层即时生效】 逻辑
      2022-01-18 : 新增 v_method 参数
  
  ===================================================================================*/
  PROCEDURE p_appcapc_appratechange
  (
    v_accid     IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_apprate   IN NUMBER,
    v_method    IN VARCHAR2
  ) IS
    v_jugnum   NUMBER(1);
    v_restrate NUMBER(5, 2);
    v_cate     VARCHAR2(2);
    v_supcode  VARCHAR2(32);
    v_faccode  VARCHAR2(32);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_app_capacity_cfg_view
     WHERE acc_id = v_accid
       AND company_id = v_compid
       AND rownum = 1;
  
    SELECT MAX(category),
           MAX(supplier_code),
           MAX(factory_code)
      INTO v_cate,
           v_supcode,
           v_faccode
      FROM scmdata.t_app_capacity_cfg
     WHERE acc_id = v_accid
       AND company_id = v_compid;
  
    v_restrate := scmdata.pkg_capacity_withview_management.f_get_restcapc_rate_withview(v_cate    => v_cate,
                                                                                        v_supcode => v_supcode,
                                                                                        v_faccode => v_faccode,
                                                                                        v_compid  => v_compid);
  
    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_app_capacity_cfg_view
        (accv_id, company_id, acc_id, appcapc_rate, operate_id, operate_time, operate_method, restcapc_rate)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_accid, v_apprate, v_curuserid, SYSDATE, v_method, v_restrate);
    ELSE
      UPDATE scmdata.t_app_capacity_cfg_view
         SET appcapc_rate   = v_apprate,
             restcapc_rate  = v_restrate,
             operate_id     = v_curuserid,
             operate_time   = SYSDATE,
             operate_method = v_method
       WHERE acc_id = v_accid
         AND company_id = v_compid;
    END IF;
  
    FOR x IN (SELECT acc_id,
                     company_id,
                     category,
                     supplier_code,
                     factory_code
                FROM scmdata.t_app_capacity_cfg
               WHERE supplier_code <> v_supcode
                 AND factory_code = v_faccode
                 AND company_id = v_compid) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_app_capacity_cfg_view
       WHERE acc_id = x.acc_id
         AND company_id = x.company_id
         AND rownum = 1;
    
      v_restrate := scmdata.pkg_capacity_withview_management.f_get_restcapc_rate_withview(v_cate    => x.category,
                                                                                          v_supcode => x.supplier_code,
                                                                                          v_faccode => x.factory_code,
                                                                                          v_compid  => x.company_id);
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_app_capacity_cfg_view
          (accv_id, company_id, acc_id, operate_id, operate_time, operate_method, restcapc_rate)
        VALUES
          (scmdata.f_get_uuid(), x.company_id, x.acc_id, v_curuserid, SYSDATE, 'VIEW', v_restrate);
      ELSE
        UPDATE scmdata.t_app_capacity_cfg_view
           SET restcapc_rate = v_restrate
         WHERE acc_id = x.acc_id
           AND company_id = x.company_id;
      END IF;
    END LOOP;
  END p_appcapc_appratechange;

  /*===================================================================================
  
    供应商开工通用配置【view层即时生效】逻辑
  
    用途:
      用于供应商开工通用配置【view层即时生效】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid      :  选择数据id
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_braid      :  分类/分部id
      v_provinceid :  省id
      v_cityid     :  市id
      v_countyid   :  区id
      v_year       :  年份
      v_weeknw     :  周不开工
      v_monthnw    :  月不开工
      v_yearnw     :  年不开工
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 供应商开工通用配置【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_supstarwork_change
  (
    v_sswcid     IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_curuserid  IN VARCHAR2,
    v_braid      IN VARCHAR2,
    v_provinceid IN VARCHAR2,
    v_cityid     IN VARCHAR2,
    v_countyid   IN VARCHAR2,
    v_year       IN NUMBER,
    v_weeknw     IN VARCHAR2,
    v_monthnw    IN VARCHAR2,
    v_yearnw     IN VARCHAR2,
    v_method     IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_method = 'INS' THEN
      INSERT INTO scmdata.t_supplier_start_work_cfg_view
        (sswcv_id, company_id, sswc_id, bra_id, province_id, city_id, country_id, YEAR, week_not_work, month_not_work, year_not_work, operate_id, operate_time, operate_method)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_sswcid, v_braid, v_provinceid, v_cityid, v_countyid, v_year, v_weeknw, v_monthnw, v_yearnw, v_curuserid, SYSDATE, v_method);
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supplier_start_work_cfg_view
       WHERE sswc_id = v_sswcid
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_supplier_start_work_cfg_view
          (sswcv_id, company_id, sswc_id, bra_id, province_id, city_id, country_id, YEAR, week_not_work, month_not_work, year_not_work, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), v_compid, v_sswcid, v_braid, v_provinceid, v_cityid, v_countyid, v_year, v_weeknw, v_monthnw, v_yearnw, v_curuserid, SYSDATE, v_method);
      ELSE
        UPDATE scmdata.t_supplier_start_work_cfg_view
           SET bra_id         = v_braid,
               province_id    = v_provinceid,
               city_id        = v_cityid,
               country_id     = v_countyid,
               YEAR           = v_year,
               week_not_work  = v_weeknw,
               month_not_work = v_monthnw,
               year_not_work  = v_yearnw,
               operate_id     = v_curuserid,
               operate_time   = SYSDATE,
               operate_method = v_method
         WHERE sswc_id = v_sswcid
           AND company_id = v_compid;
      END IF;
    END IF;
  END p_supstarwork_change;

  /*===================================================================================
  
    生产工厂开工通用配置【view层即时生效】逻辑
  
    用途:
      用于生产工厂开工通用配置【view层即时生效】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid      :  选择数据id
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_faccode    :  生产工厂编码
      v_year       :  年份
      v_weeknw     :  周不开工
      v_monthnw    :  月不开工
      v_yearnw     :  年不开工
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 生产工厂开工通用配置【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_facstarwork_change
  (
    v_sswcid    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_faccode   IN VARCHAR2,
    v_year      IN NUMBER,
    v_weeknw    IN VARCHAR2,
    v_monthnw   IN VARCHAR2,
    v_yearnw    IN VARCHAR2,
    v_method    IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_method = 'INS' THEN
      INSERT INTO scmdata.t_supplier_start_work_cfg_view
        (sswcv_id, company_id, sswc_id, factory_code, YEAR, week_not_work, month_not_work, year_not_work, operate_id, operate_time, operate_method)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_sswcid, v_faccode, v_year, v_weeknw, v_monthnw, v_yearnw, v_curuserid, SYSDATE, v_method);
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_supplier_start_work_cfg_view
       WHERE sswc_id = v_sswcid
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_supplier_start_work_cfg_view
          (sswcv_id, company_id, sswc_id, factory_code, YEAR, week_not_work, month_not_work, year_not_work, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), v_compid, v_sswcid, v_faccode, v_year, v_weeknw, v_monthnw, v_yearnw, v_curuserid, SYSDATE, v_method);
      ELSE
        UPDATE scmdata.t_supplier_start_work_cfg_view
           SET factory_code   = v_faccode,
               YEAR           = v_year,
               week_not_work  = v_weeknw,
               month_not_work = v_monthnw,
               year_not_work  = v_yearnw,
               operate_id     = v_curuserid,
               operate_time   = SYSDATE,
               operate_method = v_method
         WHERE sswc_id = v_sswcid
           AND company_id = v_compid;
      END IF;
    END IF;
  END p_facstarwork_change;

  /*===================================================================================
  
    标准工时配置【view层即时生效】逻辑
  
    用途:
      用于标准工时配置【view层即时生效】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid      :  选择数据id
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_faccode    :  生产工厂编码
      v_year       :  年份
      v_weeknw     :  周不开工
      v_monthnw    :  月不开工
      v_yearnw     :  年不开工
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 标准工时配置【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_stdwktime_cfg_infochange
  (
    v_swmcid    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_cate      IN VARCHAR2,
    v_procate   IN VARCHAR2,
    v_subcate   IN VARCHAR2,
    v_stdwktime IN NUMBER,
    v_method    IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_method = 'INS' THEN
      INSERT INTO scmdata.t_standard_work_minte_cfg_view
        (swmcv_id, company_id, swmc_id, category, product_cate, subcategory, standard_worktime, operate_id, operate_time, operate_method)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_swmcid, v_cate, v_procate, v_subcate, v_stdwktime, v_curuserid, SYSDATE, v_method);
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_standard_work_minte_cfg_view
       WHERE swmc_id = v_swmcid
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_standard_work_minte_cfg_view
          (swmcv_id, company_id, swmc_id, category, product_cate, subcategory, standard_worktime, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), v_compid, v_swmcid, v_cate, v_procate, v_subcate, v_stdwktime, v_curuserid, SYSDATE, v_method);
      ELSE
        UPDATE scmdata.t_standard_work_minte_cfg_view
           SET category          = v_cate,
               product_cate      = v_procate,
               subcategory       = v_subcate,
               standard_worktime = v_stdwktime,
               operate_id        = v_curuserid,
               operate_time      = SYSDATE,
               operate_method    = v_method
         WHERE swmc_id = v_swmcid
           AND company_id = v_compid;
      END IF;
    END IF;
  END p_stdwktime_cfg_infochange;

  /*===================================================================================
    产能品类规划配置【view层即时生效】逻辑
  
      用途：
      用于产能品类规划配置【view层即时生效】逻辑
  
      入参：
        v_cpccid     选择数据主键id
        v_compid     企业id
        v_curuserid  操作人id
        v_cate       分类
        v_procate    生产类别
        v_subcate    子类
        v_inplan     是否做产能规划，1是0否
        v_method     操作方式 ins-新增 upd-修改 del-删除
  
  
  
  ====================================================================================*/
  PROCEDURE p_capaplan_change
  (
    v_cpccid    IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_curuserid IN VARCHAR2,
    v_cate      IN VARCHAR2,
    v_procate   IN VARCHAR2,
    v_subcate   IN VARCHAR2,
    v_inplan    IN NUMBER,
    v_method    IN VARCHAR2
  ) IS
    v_judnum NUMBER(1);
  BEGIN
    IF v_method = 'INS' THEN
      INSERT INTO scmdata.t_capaplan_cate_cfg_view
        (cpccv_id, company_id, cpcc_id, category, product_cate, subcategory, in_planning, operate_id, operate_time, operate_method)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_cpccid, v_cate, v_procate, v_subcate, v_inplan, v_curuserid, SYSDATE, v_method);
    ELSE
      /*for i in (select *
       from scmdata.t_capacity_plan_category_cfg
      where cpcc_id = v_cpccid
        and company_id = v_compid) loop*/
      SELECT COUNT(1)
        INTO v_judnum
        FROM scmdata.t_capaplan_cate_cfg_view
       WHERE cpcc_id = v_cpccid
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_judnum = 0 THEN
        INSERT INTO scmdata.t_capaplan_cate_cfg_view
          (cpccv_id, company_id, cpcc_id, category, product_cate, subcategory, in_planning, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), v_compid, v_cpccid, v_cate, v_procate, v_subcate, v_inplan, v_curuserid, SYSDATE, v_method);
      ELSE
        UPDATE scmdata.t_capaplan_cate_cfg_view
           SET category       = v_cate,
               product_cate   = v_procate,
               subcategory    = v_subcate,
               in_planning    = v_inplan,
               operate_id     = v_curuserid,
               operate_time   = SYSDATE,
               operate_method = v_method
         WHERE cpcc_id = v_cpccid
           AND company_id = v_compid;
      END IF;
      -- end loop;
    END IF;
  END p_capaplan_change;

  /*===================================================================================
  
    生产周期配置【view层即时生效】逻辑
  
    用途:
      用于生产周期配置【view层即时生效】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_accid        :  选择数据id
      v_compid       :  企业id
      v_curuserid    :  当前操作人id
      v_cate         :  分类
      v_procate      :  生产分类
      v_subcate      :  子类
      v_supcodes     :  供应商编码，多值
      v_firordmatw   :  首单待料天数
      v_addordmatw   :  补单待料天数
      v_pctransmatw  :  后整及物流天数
      v_method       :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-17 : 生产周期配置【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_prodcyc_cfg_infochange
  (
    v_pccid       IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_curuserid   IN VARCHAR2,
    v_cate        IN VARCHAR2,
    v_procate     IN VARCHAR2,
    v_subcate     IN VARCHAR2,
    v_supcodes    IN VARCHAR2,
    v_firordmatw  IN NUMBER,
    v_addordmatw  IN NUMBER,
    v_pctransmatw IN NUMBER,
    v_method      IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_method = 'INS' THEN
      INSERT INTO scmdata.t_product_cycle_cfg_view
        (pccv_id, company_id, pcc_id, category, product_cate, subcategory, supplier_codes, first_ord_mat_wait, add_ord_mat_wait, pc_and_trans_wait, operate_id, operate_time, operate_method)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_pccid, v_cate, v_procate, v_subcate, v_supcodes, v_firordmatw, v_addordmatw, v_pctransmatw, v_curuserid, SYSDATE, v_method);
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_product_cycle_cfg_view
       WHERE pcc_id = v_pccid
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_product_cycle_cfg_view
          (pccv_id, company_id, pcc_id, category, product_cate, subcategory, supplier_codes, first_ord_mat_wait, add_ord_mat_wait, pc_and_trans_wait, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), v_compid, v_pccid, v_cate, v_procate, v_subcate, v_supcodes, v_firordmatw, v_addordmatw, v_pctransmatw, v_curuserid, SYSDATE, v_method);
      ELSE
        UPDATE scmdata.t_product_cycle_cfg_view
           SET category           = v_cate,
               product_cate       = v_procate,
               subcategory        = v_subcate,
               supplier_codes     = v_supcodes,
               first_ord_mat_wait = v_firordmatw,
               add_ord_mat_wait   = v_addordmatw,
               pc_and_trans_wait  = v_pctransmatw,
               operate_id         = v_curuserid,
               operate_time       = SYSDATE,
               operate_method     = v_method
         WHERE pcc_id = v_pccid
           AND company_id = v_compid;
      END IF;
    END IF;
  END p_prodcyc_cfg_infochange;

  /*===================================================================================
  
    供应商产能预约主表修改 【view层即时生效】 逻辑
  
    用途:
      用于供应商产能预约主表修改 【view层即时生效】 逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_ptcid      :  选择数据id，多值用分号隔开
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_pause      :  启用/停用  0-启用 1停用
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-20 : 供应商产能预约主表修改 【view层即时生效】 逻辑
  
  ===================================================================================*/
  PROCEDURE p_supcapc_ntwkdchange
  (
    v_ptcid      IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_curuserid  IN VARCHAR2,
    v_notworkday IN VARCHAR2,
    v_method     IN VARCHAR2
  ) IS
    v_jugnum   NUMBER(1);
    v_year     NUMBER(4);
    v_supcode  VARCHAR2(32);
    v_faccode  VARCHAR2(32);
    v_week     NUMBER(2);
    v_wkhour   NUMBER(2);
    v_wkpeople NUMBER(4);
    v_appcrate NUMBER(5, 2);
    v_prodeff  NUMBER(5, 2);
    v_restcapc NUMBER(5, 2);
  BEGIN
    -- view 层即时修改即时生效
    -- 主表生效
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_supplier_capacity_detail_view
     WHERE ptc_id = v_ptcid
       AND company_id = v_compid
       AND rownum = 1;
  
    SELECT MAX(YEAR),
           MAX(week),
           MAX(supplier_code),
           MAX(factory_code)
      INTO v_year,
           v_week,
           v_supcode,
           v_faccode
      FROM scmdata.t_supplier_capacity_detail
     WHERE ptc_id = v_ptcid
       AND company_id = v_compid;
  
    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_supplier_capacity_detail_view
        (ptcv_id, company_id, ptc_id, not_workday, operate_id, operate_time, operate_method, operate_company_id)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_ptcid, v_notworkday, v_curuserid, SYSDATE, v_method, v_compid);
    ELSE
      UPDATE scmdata.t_supplier_capacity_detail_view
         SET not_workday        = v_notworkday,
             operate_id         = v_curuserid,
             operate_time       = SYSDATE,
             operate_method     = v_method,
             operate_company_id = v_compid
       WHERE ptc_id = v_ptcid
         AND company_id = v_compid;
    END IF;
  
    -- 从表生效
    SELECT MAX(wktime_num),
           MAX(wkperson_num),
           MAX(appcapc_rate),
           MAX(prod_eff)
      INTO v_wkhour,
           v_wkpeople,
           v_appcrate,
           v_prodeff
      FROM scmdata.t_app_capacity_cfg
     WHERE supplier_code = v_supcode
       AND factory_code = v_faccode
       AND company_id = v_compid;
  
    FOR i IN (SELECT dd_date
                FROM scmdata.t_day_dim
               WHERE instr(';' || v_notworkday || ';', ';' || dd_id || ';') = 0
                 AND yearweek = v_year * 100 + v_week) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_capacity_appointment_detail
       WHERE ptc_id = v_ptcid
         AND DAY = i.dd_date
         AND company_id = v_compid;
    
      IF v_jugnum = 0 THEN
        v_restcapc := scmdata.pkg_capacity_withview_management.f_get_restcapcrate_by_ptcidorctddid(v_ptcid  => v_ptcid,
                                                                                                   v_day    => i.dd_date,
                                                                                                   v_compid => v_compid);
      
        IF v_restcapc IS NULL THEN
          v_restcapc := 100 - v_appcrate;
        END IF;
      
        INSERT INTO scmdata.t_capacity_appointment_detail_view
          (ctddv_id, company_id, ctdd_id, ptc_id, DAY, work_hour, work_people, appcapacity_rate, prod_effient, restcapc_rate, operate_id, operate_time, operate_method, operate_company_id)
        VALUES
          (scmdata.f_get_uuid(), v_compid, scmdata.f_get_uuid(), v_ptcid, i.dd_date, v_wkhour, v_wkpeople, v_appcrate, v_prodeff, v_restcapc, v_curuserid, SYSDATE, 'INS', v_compid);
      END IF;
    END LOOP;
  
    FOR l IN (SELECT *
                FROM scmdata.t_capacity_appointment_detail cad
               WHERE ptc_id = v_ptcid
                 AND company_id = v_compid
                 AND EXISTS (SELECT 1
                        FROM scmdata.t_day_dim
                       WHERE instr(';' || v_notworkday || ';',
                                   ';' || dd_id || ';') > 0
                         AND yearweek = v_year * 100 + v_week
                         AND dd_date = cad.day)) LOOP
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_capacity_appointment_detail
       WHERE ptc_id = v_ptcid
         AND DAY = l.day
         AND company_id = v_compid;
    
      IF v_jugnum = 1 THEN
        SELECT COUNT(1)
          INTO v_jugnum
          FROM scmdata.t_capacity_appointment_detail_view
         WHERE ptc_id = v_ptcid
           AND DAY = l.day
           AND company_id = v_compid;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_capacity_appointment_detail_view
            (ctddv_id, company_id, ctdd_id, ptc_id, DAY, work_hour, work_people, appcapacity_rate, prod_effient, restcapc_rate, memo, operate_id, operate_time, operate_method, operate_company_id)
          VALUES
            (scmdata.f_get_uuid(), l.company_id, l.ctdd_id, v_ptcid, l.day, l.work_hour, l.work_people, l.appcapacity_rate, l.prod_effient, l.restcapc_rate, l.memo, v_curuserid, SYSDATE, 'DEL', l.company_id);
        ELSE
          UPDATE scmdata.t_capacity_appointment_detail_view
             SET work_hour          = v_wkhour,
                 work_people        = v_wkpeople,
                 appcapacity_rate   = v_appcrate,
                 prod_effient       = v_prodeff,
                 restcapc_rate      = v_restcapc,
                 operate_id         = v_curuserid,
                 operate_time       = SYSDATE,
                 operate_method     = 'DEL',
                 operate_company_id = l.company_id
           WHERE ptc_id = v_ptcid
             AND DAY = l.day
             AND company_id = v_compid;
        END IF;
      END IF;
    END LOOP;
  
    FOR p IN (SELECT *
                FROM scmdata.t_capacity_appointment_detail tmp
               WHERE ptc_id = v_ptcid
                 AND company_id = v_compid
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_capacity_appointment_detail_view
                       WHERE ctdd_id = tmp.ctdd_id
                         AND company_id = tmp.company_id)) LOOP
      v_restcapc := scmdata.pkg_capacity_withview_management.f_get_restcapcrate_by_ptcidorctddid(v_ctddid => p.ctdd_id,
                                                                                                 v_day    => p.day,
                                                                                                 v_compid => v_compid);
      INSERT INTO scmdata.t_capacity_appointment_detail_view
        (ctddv_id, company_id, ctdd_id, ptc_id, DAY, work_hour, work_people, appcapacity_rate, prod_effient, restcapc_rate, memo, operate_id, operate_time, operate_method, operate_company_id)
      VALUES
        (scmdata.f_get_uuid(), p.company_id, p.ctdd_id, v_ptcid, p.day, p.work_hour, p.work_people, p.appcapacity_rate, p.prod_effient, v_restcapc, p.memo, v_curuserid, SYSDATE, 'UPD', p.company_id);
    END LOOP;
  END p_supcapc_ntwkdchange;

  /*===================================================================================
  
    供应商产能预约从表修改 【view层即时生效】 逻辑
  
    用途:
      用于供应商产能预约从表修改 【view层即时生效】 逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_ctddid     :  选择数据id
      v_compid     :  企业id
      v_operid     :  当前操作人id
      v_opertime   :  操作时间，格式 yyyy-mm-dd hh24-mi-ss
      v_wkhour     :  上班时数
      v_wkpeople   :  车位人数
      v_appcrate   :  预约产能占比
      v_prodeff    :  生产效率
      v_memo       :  备注
      v_method     :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-20 : 供应商产能预约从表修改 【view层即时生效】 逻辑
  
  ===================================================================================*/
  PROCEDURE p_capcapp_infochange
  (
    v_ctddid   IN VARCHAR2,
    v_compid   IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN VARCHAR2,
    v_wkhour   IN NUMBER,
    v_wkpeople IN NUMBER,
    v_appcrate IN NUMBER,
    v_prodeff  IN NUMBER,
    v_memo     IN VARCHAR2,
    v_method   IN VARCHAR2
  ) IS
    v_jugnum  NUMBER(1);
    v_day     DATE;
    v_faccode VARCHAR2(32);
    v_exesql  VARCHAR2(4000);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_capacity_appointment_detail_view
     WHERE ctdd_id = v_ctddid
       AND company_id = v_compid;
  
    IF v_jugnum = 0 THEN
      v_exesql := 'SELECT MAX(DAY) FROM SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL WHERE CTDD_ID = :A AND COMPANY_ID = :B';
      EXECUTE IMMEDIATE v_exesql
        INTO v_day
        USING v_ctddid, v_compid;
    
      INSERT INTO scmdata.t_capacity_appointment_detail_view
        (ctddv_id, company_id, ctdd_id, DAY, work_hour, work_people, appcapacity_rate, prod_effient, memo, operate_id, operate_time, operate_method, operate_company_id)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_ctddid, v_day, v_wkhour, v_wkpeople, v_appcrate, v_prodeff, v_memo, v_operid, to_date(v_opertime,
                  'YYYY-MM-DD HH24-MI-SS'), v_method, v_compid);
    ELSE
      UPDATE scmdata.t_capacity_appointment_detail_view
         SET work_hour          = v_wkhour,
             work_people        = v_wkpeople,
             appcapacity_rate   = v_appcrate,
             prod_effient       = v_prodeff,
             memo               = v_memo,
             operate_id         = v_operid,
             operate_time       = to_date(v_opertime,
                                          'YYYY-MM-DD HH24-MI-SS'),
             operate_method     = v_method,
             operate_company_id = v_compid
       WHERE ctdd_id = v_ctddid
         AND company_id = v_compid;
    END IF;
  
    SELECT MAX(a.factory_code)
      INTO v_faccode
      FROM scmdata.t_supplier_capacity_detail a
     INNER JOIN scmdata.t_capacity_appointment_detail b
        ON a.ptc_id = b.ptc_id
       AND a.company_id = b.company_id
     WHERE b.ctdd_id = v_ctddid
       AND b.company_id = v_compid;
  
    IF v_faccode IS NOT NULL THEN
      scmdata.pkg_capacity_efflogic.p_ins_faccode_into_tab(v_faccode => v_faccode,
                                                           v_compid  => v_compid);
    END IF;
  END p_capcapp_infochange;

  /*===================================================================================
  
    预计新品【view层即时生效】逻辑
  
    用途:
      用于预计新品【view层即时生效】逻辑
  
    入参:
      v_pnid            :  选择数据id
      v_compid          :  企业id
      v_operid          :  当前操作人id
      v_opertime        :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_changestatus    :  修改状态
      v_cate            :  分类
      v_procate         :  生产分类
      v_subcate         :  子类
      v_year            ： 年份
      v_season          :  季节
      v_ware            :  波段
      v_warestatus      :  波段生效状态
      v_supcode         :  供应商编码
      v_preordamt       :  预计订购品种数
      v_hotprodmamt     :  爆品可能数量
      v_normprodmamt    :  非爆品可能数量
      v_preorddate      :  预计下单日期
      v_predeldate      :  预计下单交期
      v_hotprodavgamt   :  爆品平均单量
      v_normprodavgamt  :  非爆品平均单量
      v_memo            :  备注
      v_method          :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-01-22 : 预计新品【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_plannew_infochange
  (
    v_pnid           IN VARCHAR2,
    v_compid         IN VARCHAR2,
    v_operid         IN VARCHAR2,
    v_opertime       IN VARCHAR2,
    v_changestatus   IN VARCHAR2,
    v_cate           IN VARCHAR2,
    v_procate        IN VARCHAR2,
    v_subcate        IN VARCHAR2,
    v_season         IN VARCHAR2,
    v_ware           IN NUMBER,
    v_warestatus     IN VARCHAR2,
    v_supcode        IN VARCHAR2,
    v_preordamt      IN NUMBER,
    v_hotprodmamt    IN NUMBER,
    v_normprodmamt   IN NUMBER,
    v_preorddate     IN DATE,
    v_predeldate     IN DATE,
    v_hotprodavgamt  IN NUMBER,
    v_normprodavgamt IN NUMBER,
    v_memo           IN VARCHAR2,
    v_method         IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    --主表 view 即时生效逻辑
    IF v_method = 'INS' THEN
      INSERT INTO scmdata.t_plan_newproduct_view
        (pnv_id, company_id, pn_id, change_status, category, product_cate, subcategory, season, ware, waveact_status, supplier_code, preord_amount, hotprodm_amount, normprodm_amount, predord_date, preddelv_date, hotprod_avgsale, normprod_avgsale, memo, operate_id, operate_time, operate_method)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_pnid, v_changestatus, v_cate, v_procate, v_subcate, v_season, v_ware, v_warestatus, v_supcode, v_preordamt, v_hotprodmamt, v_normprodmamt, v_preorddate, v_predeldate, v_hotprodavgamt, v_normprodavgamt, v_memo, v_operid, to_date(v_opertime,
                  'YYYY-MM-DD HH24-MI-SS'), v_method);
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_plan_newproduct_view
       WHERE pn_id = v_pnid
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_plan_newproduct_view
          (pnv_id, company_id, pn_id, change_status, category, product_cate, subcategory, season, ware, waveact_status, supplier_code, preord_amount, hotprodm_amount, normprodm_amount, predord_date, preddelv_date, hotprod_avgsale, normprod_avgsale, memo, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), v_compid, v_pnid, v_changestatus, v_cate, v_procate, v_subcate, v_season, v_ware, v_warestatus, v_supcode, v_preordamt, v_hotprodmamt, v_normprodmamt, v_preorddate, v_predeldate, v_hotprodavgamt, v_normprodavgamt, v_memo, v_operid, to_date(v_opertime,
                    'YYYY-MM-DD HH24-MI-SS'), v_method);
      ELSE
        UPDATE scmdata.t_plan_newproduct_view
           SET change_status    = v_changestatus,
               category         = v_cate,
               product_cate     = v_procate,
               subcategory      = v_subcate,
               season           = season,
               ware             = v_ware,
               waveact_status   = v_warestatus,
               supplier_code    = v_supcode,
               preord_amount    = v_preordamt,
               hotprodm_amount  = v_hotprodmamt,
               normprodm_amount = v_normprodmamt,
               predord_date     = v_preorddate,
               preddelv_date    = v_predeldate,
               hotprod_avgsale  = v_hotprodavgamt,
               normprod_avgsale = v_normprodavgamt,
               memo             = v_memo,
               operate_id       = v_operid,
               operate_time     = to_date(v_opertime,
                                          'YYYY-MM-DD HH24-MI-SS'),
               operate_method   = v_method
         WHERE pn_id = v_pnid
           AND company_id = v_compid;
      END IF;
    END IF;
  
    --从表 view 即时生效逻辑
    p_gen_newprodscheview_data_4pln(v_pnid     => v_pnid,
                                    v_operid   => v_operid,
                                    v_opertime => to_date(v_opertime,
                                                          'YYYY-MM-DD HH24-MI-SS'),
                                    v_method   => v_method,
                                    v_compid   => v_compid);
  END p_plannew_infochange;

  /*===================================================================================
  
    预计新品波段生效状态自动变更view层生效
  
    用途:
      预计新品波段生效状态自动变更view层生效
  
    版本:
      2022-05-31 : 预计新品波段生效状态自动变更view层生效
  
  ===================================================================================*/
  PROCEDURE p_pln_autowavestatucg_viewgenerate
  (
    v_pnid   IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_plan_newproduct_view
     WHERE pn_id = v_pnid
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_plan_newproduct_view
        (pnv_id, company_id, pn_id, change_status, category, product_cate, subcategory, YEAR, season, ware, waveact_status, supplier_code, preord_amount, hotprodm_amount, normprodm_amount, predord_date, preddelv_date, hotprod_avgsale, normprod_avgsale, memo, operate_id, operate_time, operate_method)
        SELECT scmdata.f_get_uuid(),
               company_id,
               pn_id,
               change_status,
               category,
               product_cate,
               subcategory,
               YEAR,
               season,
               ware,
               'OD',
               supplier_code,
               preord_amount,
               hotprodm_amount,
               normprodm_amount,
               predord_date,
               preddelv_date,
               hotprod_avgsale,
               normprod_avgsale,
               memo,
               'ADMIN',
               SYSDATE,
               'UPD'
          FROM scmdata.t_plan_newproduct
         WHERE pn_id = v_pnid
           AND company_id = v_compid;
    ELSE
      UPDATE scmdata.t_plan_newproduct_view
         SET waveact_status = 'OD',
             operate_id     = 'ADMIN',
             operate_time   = SYSDATE,
             operate_method = 'UPD'
       WHERE pn_id = v_pnid
         AND company_id = v_compid;
    END IF;
  END p_pln_autowavestatucg_viewgenerate;

  /*===================================================================================
  
    预计补单生效状态自动变更view层生效
  
    用途:
      预计补单生效状态自动变更view层生效
  
    版本:
      2022-08-04 : 预计补单生效状态自动变更view层生效
  
  ===================================================================================*/
  PROCEDURE p_pls_autoactstatucg_viewgenerate
  (
    v_psid   IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    SELECT COUNT(1)
      INTO v_jugnum
      FROM scmdata.t_plannew_supplementary_view
     WHERE ps_id = v_psid
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum = 0 THEN
      INSERT INTO scmdata.t_plannew_supplementary_view
        (psv_id, company_id, ps_id, category, product_cate, subcategory, supplier_code, predord_date, preddelv_date, preord_amount, act_status, operate_id, operate_time, operate_method, change_status)
        SELECT scmdata.f_get_uuid(),
               company_id,
               ps_id,
               category,
               product_cate,
               subcategory,
               supplier_code,
               predord_date,
               preddelv_date,
               preord_amount,
               'AO',
               'ADMIN',
               SYSDATE,
               'UPD',
               change_status
          FROM scmdata.t_plannew_supplementary
         WHERE ps_id = v_psid
           AND company_id = v_compid;
    ELSE
      UPDATE scmdata.t_plannew_supplementary_view
         SET act_status     = 'AO',
             operate_id     = 'ADMIN',
             operate_time   = SYSDATE,
             operate_method = 'UPD'
       WHERE ps_id = v_psid
         AND company_id = v_compid;
    END IF;
  END p_pls_autoactstatucg_viewgenerate;

  /*===================================================================================
  
    预计新品信息修改从表【view层即时生效】逻辑
  
    用途:
      用于预计新品信息修改从表【view层即时生效】逻辑
  
    入参:
      v_pnid           :  预计新品表id
      v_compid         :  企业id
      v_operid         :  当前操作人id
      v_opertime       :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_hotprodmamt    :  爆品可能种数
      v_normprodmamt   :  非爆品可能种数
      v_hotprodavgamt  :  爆品平均单量
      v_normprodavgamt :  非爆品平均单量
      v_preorddate     :  预计下单日期
      v_predeldate     :  预计交期
      v_cate           :  分类
      v_pcate          :  生产分类
      v_scate          :  子类
  
    版本:
      2022-01-22 : 预计新品信息修改从表【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_gen_prodplannew_infochange
  (
    v_pnid           IN VARCHAR2,
    v_compid         IN VARCHAR2,
    v_operid         IN VARCHAR2,
    v_opertime       IN VARCHAR2,
    v_hotprodmamt    IN NUMBER,
    v_normprodmamt   IN NUMBER,
    v_hotprodavgamt  IN NUMBER,
    v_normprodavgamt IN NUMBER,
    v_preorddate     IN DATE,
    v_predeldate     IN DATE,
    v_cate           IN VARCHAR2,
    v_pcate          IN VARCHAR2,
    v_scate          IN VARCHAR2
  ) IS
    v_ck_hotprodmamt    NUMBER(4); --校验爆品可能品种数
    v_ck_normprodmamt   NUMBER(4); --校验非爆品可能品种数
    v_ck_hotprodavgamt  NUMBER(16); --校验爆品平均单量
    v_ck_normprodavgamt NUMBER(16); --校验非爆品平均单量
    v_ck_preorddate     DATE; --校验预计下单日期
    v_ck_predeldate     DATE; --校验预计交期
    v_firstordwait      NUMBER(4); --首单待料天数
    v_pctranswait       NUMBER(4); --后整及物流天数
    v_daysubstact       NUMBER(4); --日期相减差数
    v_plantotalamt      NUMBER(16); --预计新品总单量
    v_sdprodamt         NUMBER(16); --单日生产单量
  BEGIN
    SELECT MAX(hotprodm_amount),
           MAX(normprodm_amount),
           MAX(hotprod_avgsale),
           MAX(normprod_avgsale),
           MAX(predord_date),
           MAX(preddelv_date)
      INTO v_ck_hotprodmamt,
           v_ck_normprodmamt,
           v_ck_hotprodavgamt,
           v_ck_normprodavgamt,
           v_ck_preorddate,
           v_ck_predeldate
      FROM scmdata.t_plan_newproduct
     WHERE pn_id = v_pnid
       AND company_id = v_compid;
  
    IF nvl(v_hotprodmamt, 0) <> nvl(v_ck_hotprodmamt, 0)
       OR nvl(v_normprodmamt, 0) <> nvl(v_ck_normprodmamt, 0)
       OR nvl(v_hotprodavgamt, 0) <> nvl(v_ck_hotprodavgamt, 0)
       OR nvl(v_normprodavgamt, 0) <> nvl(v_ck_normprodavgamt, 0)
       OR nvl(v_preorddate, trunc(SYSDATE)) <>
       nvl(v_ck_preorddate, trunc(SYSDATE))
       OR nvl(v_predeldate, trunc(SYSDATE)) <>
       nvl(v_ck_predeldate, trunc(SYSDATE)) THEN
      SELECT MAX(first_ord_mat_wait),
             MAX(pc_and_trans_wait)
        INTO v_firstordwait,
             v_pctranswait
        FROM scmdata.t_product_cycle_cfg
       WHERE category = v_cate
         AND product_cate = v_pcate
         AND subcategory = v_scate
         AND company_id = v_compid;
    
      v_firstordwait := nvl(v_firstordwait, 0);
      v_pctranswait  := nvl(v_pctranswait, 0);
    
      v_plantotalamt := (v_hotprodmamt * v_hotprodavgamt) +
                        (v_normprodmamt * v_normprodavgamt);
    
      v_daysubstact := to_number((v_predeldate - v_pctranswait) -
                                 (v_preorddate + v_firstordwait)) + 1;
    
      --view层 ins, dai 类型的历史数据清理
      DELETE FROM scmdata.t_production_schedule_view
       WHERE pn_id = v_pnid
         AND operate_method IN ('INS', 'DAI')
         AND company_id = v_compid;
    
      IF v_daysubstact > 0 THEN
        FOR i IN (SELECT dd_date
                    FROM scmdata.t_day_dim
                   WHERE dd_date BETWEEN v_preorddate + 1 + v_firstordwait AND
                         v_predeldate - v_pctranswait) LOOP
          IF i.dd_date <> v_predeldate - v_pctranswait THEN
            v_sdprodamt := trunc(v_plantotalamt / v_daysubstact);
          ELSIF i.dd_date = v_predeldate - v_pctranswait THEN
            v_sdprodamt := v_plantotalamt -
                           trunc(v_plantotalamt / v_daysubstact) *
                           (v_daysubstact - 1);
          END IF;
        
          INSERT INTO scmdata.t_production_schedule_view
            (psv_id, company_id, ps_id, pn_id, DAY, product_amount, operate_id, operate_time, operate_method)
          VALUES
            (scmdata.f_get_uuid(), v_compid, scmdata.f_get_uuid(), v_pnid, i.dd_date, v_sdprodamt, v_operid, to_date(v_opertime,
                      'YYYY-MM-DD HH24-MI-SS'), 'DAI');
        END LOOP;
      ELSE
        v_sdprodamt := v_plantotalamt;
      
        INSERT INTO scmdata.t_production_schedule_view
          (psv_id, company_id, ps_id, pn_id, DAY, product_amount, operate_id, operate_time, operate_method)
        VALUES
          (scmdata.f_get_uuid(), v_compid, scmdata.f_get_uuid(), v_pnid, v_preorddate + 1, v_sdprodamt, v_operid, to_date(v_opertime,
                    'YYYY-MM-DD HH24-MI-SS'), 'DAI');
      END IF;
    END IF;
  END p_gen_prodplannew_infochange;

  /*===================================================================================
  
    预计补单生产排期【view层即时生效】逻辑
  
    用途:
      用于预计补单生产排期【view层即时生效】逻辑
  
    入参:
      v_pnsid           :  预计补单表id
      v_operid          :  当前操作人id
      v_opertime        :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_method          :  操作方式 ins-新增 upd-修改 del-删除
      v_compid          :  企业id
  
    版本:
      2022-07-26 : 预计补单生产排期【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_gen_newprodscheview_data_4pln
  (
    v_pnid     IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN DATE,
    v_method   IN VARCHAR2,
    v_compid   IN VARCHAR2
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
      FROM scmdata.t_production_schedule_view
     WHERE pn_id = v_pnid
       AND company_id = v_compid
       AND rownum = 1;
  
    --fixme: 如果存在删除重算
    --xxx: 删除当前周及以后的数据，当前周以前的数据保留
    IF v_jugnum > 0 THEN
      DELETE FROM scmdata.t_production_schedule_view
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
                FROM scmdata.t_plan_newproduct_view tpn
               WHERE pn_id = v_pnid
                 AND company_id = v_compid
                 AND EXISTS (SELECT 1
                        FROM scmdata.t_coopcate_supplier_cfg
                       WHERE supplier_code = tpn.supplier_code
                         AND coop_category = tpn.category
                         AND company_id = tpn.company_id
                         AND pause = 0)
                 AND EXISTS (SELECT 1
                        FROM scmdata.t_capacity_plan_category_cfg
                       WHERE category = tpn.category
                         AND product_cate = tpn.product_cate
                         AND subcategory = tpn.subcategory
                         AND in_planning = 1)) LOOP
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
        FROM scmdata.t_production_schedule_view
       WHERE pn_id = v_pnid
         AND company_id = v_compid;
    
      v_sumamt := nvl(x.hotprodm_amount, 0) * nvl(x.hotprod_avgsale, 0) +
                  nvl(x.normprodm_amount, 0) * nvl(x.normprod_avgsale, 0) -
                  nvl(v_incnum, 0);
    
      FOR z IN (SELECT dd_date
                  FROM scmdata.t_day_dim
                 WHERE dd_date BETWEEN v_startday AND v_endday) LOOP
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
          FROM scmdata.t_production_schedule_view
         WHERE pn_id = x.pn_id
           AND DAY = z.dd_date
           AND company_id = x.company_id
           AND rownum = 1;
      
        IF v_jugnum = 0 THEN
          INSERT INTO scmdata.t_production_schedule_view
            (psv_id, ps_id, company_id, pn_id, DAY, product_amount, operate_id, operate_time, operate_method)
          VALUES
            (scmdata.f_get_uuid(), scmdata.f_get_uuid(), x.company_id, v_pnid, z.dd_date, v_amt, v_operid, v_opertime, v_method);
        ELSE
          UPDATE scmdata.t_production_schedule_view
             SET product_amount = v_amt
           WHERE pn_id = v_pnid
             AND DAY = z.dd_date
             AND company_id = x.company_id;
        END IF;
      END LOOP;
    END LOOP;
  END p_gen_newprodscheview_data_4pln;

  /*===================================================================================
  
    预计补单【view层即时生效】逻辑
  
    用途:
      用于预计补单【view层即时生效】逻辑
  
    入参:
      v_pnid            :  预计补单表id
      v_compid          :  企业id
      v_operid          :  当前操作人id
      v_opertime        :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_cate            :  分类
      v_procate         :  生产分类
      v_subcate         :  子类
      v_actstatus       :  生效状态
      v_supcode         :  供应商编码
      v_preorddate      :  预计下单日期
      v_predeldate      :  预计下单交期
      v_preordamt       :  预计下单数量
      v_method          :  操作方式 ins-新增 upd-修改 del-删除
  
    版本:
      2022-07-26 : 预计补单【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_plansupp_infochange
  (
    v_pnsid        IN VARCHAR2,
    v_compid       IN VARCHAR2,
    v_operid       IN VARCHAR2,
    v_opertime     IN VARCHAR2,
    v_cate         IN VARCHAR2,
    v_procate      IN VARCHAR2,
    v_subcate      IN VARCHAR2,
    v_actstatus    IN VARCHAR2,
    v_supcode      IN VARCHAR2,
    v_preorddate   IN VARCHAR2,
    v_predeldate   IN VARCHAR2,
    v_preordamt    IN VARCHAR2,
    v_changestatus IN VARCHAR2,
    v_method       IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    --主表 view 即时生效逻辑
    IF v_method = 'INS' THEN
      INSERT INTO scmdata.t_plannew_supplementary_view
        (psv_id, company_id, ps_id, category, product_cate, subcategory, supplier_code, act_status, predord_date, preddelv_date, preord_amount, operate_id, operate_time, operate_method, change_status)
      VALUES
        (scmdata.f_get_uuid(), v_compid, v_pnsid, v_cate, v_procate, v_subcate, v_supcode, v_actstatus, to_date(v_preorddate,
                  'YYYY-MM-DD HH24-MI-SS'), to_date(v_predeldate,
                  'YYYY-MM-DD HH24-MI-SS'), v_preordamt, v_operid, to_date(v_opertime,
                  'YYYY-MM-DD HH24-MI-SS'), v_method, v_changestatus);
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM scmdata.t_plannew_supplementary_view
       WHERE ps_id = v_pnsid
         AND company_id = v_compid
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_plannew_supplementary_view
          (psv_id, company_id, ps_id, category, product_cate, subcategory, supplier_code, act_status, predord_date, preddelv_date, preord_amount, operate_id, operate_time, operate_method, change_status)
        VALUES
          (scmdata.f_get_uuid(), v_compid, v_pnsid, v_cate, v_procate, v_subcate, v_supcode, v_actstatus, to_date(v_preorddate,
                    'YYYY-MM-DD HH24-MI-SS'), to_date(v_predeldate,
                    'YYYY-MM-DD HH24-MI-SS'), v_preordamt, v_operid, to_date(v_opertime,
                    'YYYY-MM-DD HH24-MI-SS'), v_method, v_changestatus);
      ELSE
        UPDATE scmdata.t_plannew_supplementary_view tmp
           SET category       = v_cate,
               product_cate   = v_procate,
               subcategory    = v_subcate,
               act_status     = v_actstatus,
               supplier_code  = v_supcode,
               preord_amount  = v_preordamt,
               predord_date   = to_date(v_preorddate,
                                        'YYYY-MM-DD HH24-MI-SS'),
               preddelv_date  = to_date(v_predeldate,
                                        'YYYY-MM-DD HH24-MI-SS'),
               change_status  = v_changestatus,
               operate_id     = v_operid,
               operate_time   = to_date(v_opertime, 'YYYY-MM-DD HH24-MI-SS'),
               operate_method = v_method
         WHERE ps_id = v_pnsid
           AND company_id = v_compid;
      END IF;
    END IF;
  
    --从表 view 即时生效逻辑
    p_gen_newprodscheview_data_4pls(v_pnsid    => v_pnsid,
                                    v_operid   => v_operid,
                                    v_opertime => to_date(v_opertime,
                                                          'YYYY-MM-DD HH24-MI-SS'),
                                    v_method   => v_method,
                                    v_compid   => v_compid);
  END p_plansupp_infochange;

  /*===================================================================================
  
    预计补单生产排期【view层即时生效】逻辑
  
    用途:
      用于预计补单生产排期【view层即时生效】逻辑
  
    入参:
      v_pnsid           :  预计补单表id
      v_operid          :  当前操作人id
      v_opertime        :  操作时间，字符串，格式:yyyy-mm-dd hh24-mi-ss
      v_method          :  操作方式 ins-新增 upd-修改 del-删除
      v_compid          :  企业id
  
    版本:
      2022-07-26 : 预计补单生产排期【view层即时生效】逻辑
  
  ===================================================================================*/
  PROCEDURE p_gen_newprodscheview_data_4pls
  (
    v_pnsid    IN VARCHAR2,
    v_operid   IN VARCHAR2,
    v_opertime IN DATE,
    v_method   IN VARCHAR2,
    v_compid   IN VARCHAR2
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
      FROM scmdata.t_production_schedule_view
     WHERE pns_id = v_pnsid
       AND company_id = v_compid
       AND rownum = 1;
  
    --如果存在删除重算，删除当前周及以后的数据，当前周以前的数据保留
    IF v_jugnum > 0 THEN
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
                     predord_date,
                     preddelv_date,
                     preord_amount
                FROM scmdata.t_plannew_supplementary_view tpsv
               WHERE ps_id = v_pnsid
                 AND act_status = 'NO'
                 AND company_id = v_compid
                 AND EXISTS (SELECT 1
                        FROM scmdata.t_coopcate_supplier_cfg
                       WHERE supplier_code = tpsv.supplier_code
                         AND coop_category = tpsv.category
                         AND company_id = tpsv.company_id
                         AND pause = 0)
                 AND EXISTS (SELECT 1
                        FROM scmdata.t_capacity_plan_category_cfg
                       WHERE category = tpsv.category
                         AND product_cate = tpsv.product_cate
                         AND subcategory = tpsv.subcategory
                         AND in_planning = 1)) LOOP
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
        FROM scmdata.t_production_schedule_view
       WHERE pns_id = v_pnsid
         AND company_id = v_compid;
    
      v_sumamt := nvl(x.preord_amount, 0) - nvl(v_incnum, 0);
    
      IF v_sumamt > 0 THEN
        FOR z IN (SELECT dd_date
                    FROM scmdata.t_day_dim
                   WHERE dd_date BETWEEN v_startday AND v_endday) LOOP
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
            FROM scmdata.t_production_schedule_view
           WHERE pns_id = x.ps_id
             AND DAY = z.dd_date
             AND company_id = x.company_id
             AND rownum = 1;
        
          IF v_jugnum = 0 THEN
            INSERT INTO scmdata.t_production_schedule_view
              (psv_id, ps_id, company_id, pns_id, DAY, product_amount, operate_id, operate_time, operate_method)
            VALUES
              (scmdata.f_get_uuid(), scmdata.f_get_uuid(), x.company_id, v_pnsid, z.dd_date, v_amt, v_operid, v_opertime, v_method);
          ELSE
            UPDATE scmdata.t_production_schedule_view
               SET product_amount = v_amt
             WHERE pns_id = x.ps_id
               AND DAY = z.dd_date
               AND company_id = x.company_id;
          END IF;
        END LOOP;
      END IF;
    
    END LOOP;
  END p_gen_newprodscheview_data_4pls;

  /*===================================================================================
  
    生成[订单数据接入]数据源级影响行sql
  
    入参:
      v_queueid      :  队列id
      v_compid       :  企业id
  
    返回值:
      可执行的sql语句，用于查出关联供应商、生产工厂、分类、生产分类、子类
  
    版本:
      2022-04-25 : 生成[订单数据接入]数据源级影响行sql
  
  ===================================================================================*/
  PROCEDURE p_gen_orditf_inqueue(v_compid IN VARCHAR2) IS
    v_queueid VARCHAR2(32) := scmdata.f_get_uuid();
    v_curtime DATE := SYSDATE;
    v_jugnum  NUMBER(1);
  BEGIN
    FOR i IN (SELECT DISTINCT order_code,
                              company_id
                FROM scmdata.t_ordered orded
               WHERE create_time > SYSDATE - 10 / (24 * 60)
                 AND company_id = v_compid
                 AND EXISTS
               (SELECT 1
                        FROM scmdata.t_orders
                       WHERE order_id = orded.order_code
                         AND company_id = orded.company_id)) LOOP
      SELECT nvl(MAX(1), 0)
        INTO v_jugnum
        FROM scmdata.t_queue_orditfpsync
       WHERE order_id = i.order_code
         AND company_id = i.company_id
         AND rownum = 1;
    
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_queue_orditfpsync
          (qo_id, company_id, queue_id, order_id, create_time)
        VALUES
          (scmdata.f_get_uuid(), i.company_id, v_queueid, i.order_code, v_curtime);
      END IF;
    END LOOP;
  
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_queue_orditfpsync
     WHERE queue_id = v_queueid
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_jugnum > 0 THEN
      INSERT INTO scmdata.t_queue
        (queue_id, company_id, queue_status, queue_type, create_id, create_time)
      VALUES
        (v_queueid, v_compid, 'PR', 'CAPA_ORDITF_I', 'ADMIN', v_curtime);
    
      scmdata.pkg_capacity_iflrow.p_gen_orditf_iflrows(v_queueid => v_queueid,
                                                       v_compid  => v_compid);
    END IF;
  END p_gen_orditf_inqueue;

  /*========================================================================================
  
    指定工厂入队逻辑
  
    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业id
  
    版本:
      2022-12-17 : 指定工厂入队逻辑
  
  ========================================================================================*/
  PROCEDURE p_specify_ordfactory_inqueue
  (
    v_inp_ordid  IN VARCHAR2,
    v_inp_compid IN VARCHAR2
  ) IS
    v_jugnum  NUMBER(1);
    v_queueid VARCHAR2(32) := scmdata.f_get_uuid();
    v_operid  VARCHAR2(32);
  BEGIN
    --判断是否在生产排期表中
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_production_schedule
     WHERE order_id = v_inp_ordid
       AND company_id = v_inp_compid;
  
    --在排期表中
    IF v_jugnum = 1 THEN
      --获取操作人
      SELECT MAX(update_id)
        INTO v_operid
        FROM scmdata.t_ordered
       WHERE order_code = v_inp_ordid
         AND company_id = v_inp_compid;
    
      --新增队列
      INSERT INTO scmdata.t_queue
        (queue_id, company_id, queue_status, queue_type, create_id, create_time)
      VALUES
        (v_queueid, v_inp_compid, 'PR', 'CAPA_ORDSPCFAC_U', v_operid, SYSDATE);
    
      --新增影响行
      scmdata.pkg_capacity_iflrow.p_gen_specify_ordfactory_iflrows(v_inp_queueid => v_queueid,
                                                                   v_inp_ordid   => v_inp_ordid,
                                                                   v_inp_compid  => v_inp_compid);
    ELSE
      --判断是否存在于产能订单表
      SELECT nvl(MAX(1), 0)
        INTO v_jugnum
        FROM scmdata.t_queue_orditfpsync
       WHERE order_id = v_inp_ordid
         AND company_id = v_inp_compid
         AND rownum = 1;
    
      --判断
      IF v_jugnum = 0 THEN
        --不存在，新增
        INSERT INTO scmdata.t_queue_orditfpsync
          (qo_id, company_id, queue_id, order_id, create_time)
        VALUES
          (scmdata.f_get_uuid(), v_inp_compid, v_queueid, v_inp_ordid, SYSDATE);
      ELSE
        --存在，刷新创建时间，队列id
        UPDATE scmdata.t_queue_orditfpsync
           SET create_time = SYSDATE,
               queue_id    = v_queueid
         WHERE order_id = v_inp_ordid;
      END IF;
    
      --新增入队
      INSERT INTO scmdata.t_queue
        (queue_id, company_id, queue_status, queue_type, create_id, create_time)
      VALUES
        (v_queueid, v_inp_compid, 'PR', 'CAPA_ORDITF_I', 'ADMIN', SYSDATE);
    
      --生成影响行
      scmdata.pkg_capacity_iflrow.p_gen_orditf_iflrows(v_queueid => v_queueid,
                                                       v_compid  => v_inp_compid);
    END IF;
  END p_specify_ordfactory_inqueue;

  /*===================================================================================
  
    【通用入队】逻辑
  
    用途:
      【通用入队】逻辑
  
    用于:
      品类合作供应商启用/停用
  
    入参:
      v_compid     :  企业id
      v_curuserid  :  当前操作人id
      v_pause      :  启用/停用  0-启用 1停用
      v_tab        :  值变更表名称
      v_viewtab    :  值变更 view 表名称
      v_unqfields  :  值变更表-唯一列
      v_ckfields   :  值变更表-变更值列
      v_conds      :  查找值变更表变更记录条件
      v_method     :  值变更方式
      v_viewlogic  :  view 层即时生效逻辑
      v_queuetype  :  队列类型
  
    版本:
      2022-01-17 : 【通用入队】逻辑
  
  ===================================================================================*/
  PROCEDURE p_common_inqueue
  (
    v_curuserid IN VARCHAR2,
    v_compid    IN VARCHAR2,
    v_tab       IN VARCHAR2,
    v_viewtab   IN VARCHAR2 DEFAULT NULL,
    v_unqfields IN VARCHAR2,
    v_ckfields  IN VARCHAR2,
    v_conds     IN VARCHAR2,
    v_method    IN VARCHAR2,
    v_viewlogic IN CLOB,
    v_queuetype IN VARCHAR2
  ) IS
    v_queueid    VARCHAR2(32);
    v_vcexists   NUMBER(1);
    v_isiflgened NUMBER(1) := 0;
  BEGIN
    --创建还原点
    SAVEPOINT ready_to_effcg_and_genvcifl;
  
    v_queueid := scmdata.f_get_uuid();
  
    -- view 层即时修改即时生效
    IF v_viewlogic IS NOT NULL THEN
      EXECUTE IMMEDIATE v_viewlogic;
    END IF;
  
    -- 入队
    scmdata.pkg_queue.p_gen_queuevc_info(v_queueid   => v_queueid,
                                         v_compid    => v_compid,
                                         v_tab       => v_tab,
                                         v_viewtab   => v_viewtab,
                                         v_unqfields => v_unqfields,
                                         v_ckfields  => v_ckfields,
                                         v_conds     => v_conds,
                                         v_method    => v_method);
  
    /*if v_tab <> 'SCMDATA.T_SUPPLIER_INFO'
      or v_tab = 'SCMDATA.T_COOP_SCOPE'
      or v_tab = 'SCMDATA.T_COOP_FACTORY' then
      v_isiflgened := 1;
    else
      scmdata.pkg_capacity_iflrow.p_influencerows_core(v_queueid  => v_queueid,
                                                       v_compid   => v_compid);
    end if;*/
  
    scmdata.pkg_capacity_iflrow.p_influencerows_core(v_queueid => v_queueid,
                                                     v_compid  => v_compid);
  
    SELECT COUNT(1)
      INTO v_vcexists
      FROM scmdata.t_queue_valchange
     WHERE queue_id = v_queueid
       AND company_id = v_compid
       AND rownum = 1;
  
    IF v_vcexists > 0 THEN
      INSERT INTO scmdata.t_queue
        (queue_id, company_id, queue_status, queue_type, create_id, create_time, is_iflrowsgened)
      VALUES
        (v_queueid, v_compid, 'PR', v_queuetype, v_curuserid, SYSDATE, v_isiflgened);
    ELSE
      ROLLBACK TO ready_to_effcg_and_genvcifl;
    END IF;
    /*exception
    when others then
      rollback to ready_to_effcg_and_genvcifl;*/
  END p_common_inqueue;

END pkg_capacity_inqueue;
/

