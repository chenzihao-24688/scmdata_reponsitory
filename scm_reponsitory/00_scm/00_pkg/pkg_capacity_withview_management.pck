CREATE OR REPLACE PACKAGE SCMDATA.pkg_capacity_withview_management IS

  /*===================================================================================
  
    获取某工厂除当前供应商外的剩余产能占比
  
    用途:
      用于获取某工厂除当前供应商外的剩余产能占比
  
    用于:
      生产周期配置
  
    入参:
      v_cate     :  分类id
      v_supcode  :  供应商编码
      v_faccode  :  工厂编码
      v_compid   :  企业id
  
    版本:
      2022-04-07 : 用于获取某工厂除当前供应商外的剩余产能占比
      2022-09-07 : 表维度变更，由 sf(sup + fac) 变更为 csf(cate + sup + fac)
  
  ===================================================================================*/
  FUNCTION f_get_restcapc_rate_withview
  (
    v_cate    IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER;

  /*===================================================================================
  
    更新该生产工厂剩余产能占比
  
    用途:
      用于更新该生产工厂剩余产能占比
  
    用于:
      生产周期配置
  
    入参:
      v_cate     :  分类id
      v_supcode  :  供应商编码
      v_faccode  :  工厂编码
      v_apprate  :  该供应商预约产能占比
      v_compid   :  企业id
  
    版本:
      2022-04-07 : 用于更新该生产工厂剩余产能占比
  
  ===================================================================================*/
  PROCEDURE p_update_restcapc_rate_withview
  (
    v_cate    IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_apprate IN VARCHAR2,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    是否生效校验
  
    用途:
      用于校验供应商不开工是否生效
  
    用于:
      供应商开工通用配置
  
    入参:
      v_sswcid  :  供应商不开工配置id
      v_compid  :  企业id
  
    返回值:
      0-未生效，1-已生效
  
    版本:
      2021-11-18 : 用于校验供应商不开工是否生效,生效则不能修改年份
  
  ===================================================================================*/
  FUNCTION f_check_supnwcfgview_available
  (
    v_sswcid IN VARCHAR2,
    v_compid IN VARCHAR2
  ) RETURN NUMBER;

  /*===================================================================================
  
    计算产能预约明细中某厂某天剩余产能占比
  
    用途:
      用于计算产能预约明细中某厂某天剩余产能占比，
      如果产能预约明细表id（v_ctddid）为空：
          计算产能预约表中某厂某天的剩余产能占比
      如果产能预约明细表id（v_ctddid）不为空：
          计算产能预约表中除产能预约明细表id数据外的，某厂某天的剩余产能占比
  
    入参:
      v_faccode  : 工厂编码
      v_compid   : 企业id
      v_checkday : 查询日期
      v_ctddid   : 产能预约明细表id
  
    版本:
      2021-04-09 : 用于计算产能预约明细中某厂某天剩余产能占比
  
  ===================================================================================*/
  FUNCTION f_get_restcapc_rate_by_day_wv
  (
    v_faccode  IN VARCHAR2,
    v_compid   IN VARCHAR2,
    v_checkday IN DATE,
    v_ctddid   IN VARCHAR2 DEFAULT NULL
  ) RETURN NUMBER;

  /*===================================================================================
  
    "年+工厂"唯一校验
  
    用途:
      用于供应商开工"年+工厂"唯一性校验
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year     :  年份
      v_faccode  :  生产工厂编码
      v_sswcid   :  供应商开工通用配置id
      v_compid   :  企业id
  
    版本:
      2022-04-07 : 用于供应商开工"年+工厂"唯一性校验
  
  ===================================================================================*/
  PROCEDURE p_check_factory_unq_wv
  (
    v_year    IN NUMBER,
    v_faccode IN VARCHAR2,
    v_sswcid  IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    "年+区域"唯一校验
  
    用途:
      用于供应商开工"年+区域"唯一校验
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year       :  年份
      v_provid     :  省id
      v_cityid     :  市id
      v_countryid  :  区id
      v_sswcid     :  供应商开工通用配置id
      v_compid     :  企业id
  
    版本:
      2022-04-07 : 用于供应商开工"年+区域"唯一校验
  
  ===================================================================================*/
  PROCEDURE p_check_area_unq_wv
  (
    v_year      IN NUMBER,
    v_provid    IN VARCHAR2,
    v_cityid    IN VARCHAR2,
    v_countryid IN VARCHAR2,
    v_sswcid    IN VARCHAR2 DEFAULT NULL,
    v_compid    IN VARCHAR2
  );

  /*===================================================================================
  
    "年+分部+区域"唯一校验
  
    用途:
      用于供应商开工"年+分部+区域"唯一校验
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year       :  年份
      v_provid     :  省id
      v_cityid     :  市id
      v_countryid  :  区id
      v_sswcid     :  供应商开工通用配置id
      v_compid     :  企业id
  
    版本:
      2022-04-07 : 用于供应商开工"年+分部+区域"唯一校验
  
  ===================================================================================*/
  PROCEDURE p_check_bra_area_unq_wv
  (
    v_year      IN NUMBER,
    v_braid     IN VARCHAR2,
    v_provid    IN VARCHAR2,
    v_cityid    IN VARCHAR2,
    v_countryid IN VARCHAR2,
    v_sswcid    IN VARCHAR2 DEFAULT NULL,
    v_compid    IN VARCHAR2
  );

  /*===================================================================================
  
    "年+分部"唯一校验
  
    用途:
      用于供应商开工"年+分部"唯一校验
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year    :  年份
      v_braid   :  分部id
      v_sswcid  :  供应商开工通用配置id
      v_compid  :  企业id
  
    版本:
      2022-04-07 : 用于供应商开工分部唯一校验
  
  ===================================================================================*/
  PROCEDURE p_check_bra_unq_wv
  (
    v_year   IN NUMBER,
    v_braid  IN VARCHAR2,
    v_sswcid IN VARCHAR2 DEFAULT NULL,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    开工唯一校验
  
    用途:
      用于供应商开工唯一性
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year      :  年
      v_braid     :  分部id
      v_provid    :  省id
      v_cityid    :  市id
      v_countryid :  区id
      v_faccode   :  工厂编码
      v_sswcid    :  供应商开工通用配置id
      v_ckmode    :  校验模式
      v_compid    :  企业id
  
    版本:
      2022-04-07 : 用于生成通用日期维度 x 年数据
  
  ===================================================================================*/
  PROCEDURE p_check_supplier_startwork_wv
  (
    v_year      IN NUMBER,
    v_braid     IN VARCHAR2 DEFAULT NULL,
    v_provid    IN VARCHAR2 DEFAULT NULL,
    v_cityid    IN VARCHAR2 DEFAULT NULL,
    v_countryid IN VARCHAR2 DEFAULT NULL,
    v_faccode   IN VARCHAR2 DEFAULT NULL,
    v_sswcid    IN VARCHAR2 DEFAULT NULL,
    v_ckmode    IN VARCHAR2,
    v_compid    IN VARCHAR2
  );

  /*===================================================================================
  
    是否生效校验
  
    用途:
      用于校验供应商不开工是否生效
  
    用于:
      供应商开工通用配置
  
    入参:
      v_sswcid  :  供应商不开工配置id
      v_compid  :  企业id
  
    返回值:
      0-未生效，1-已生效
  
    版本:
      2021-11-18 : 用于校验供应商不开工是否生效,生效则不能修改年份
  
  ===================================================================================*/
  FUNCTION f_check_supnwcfg_available_wv
  (
    v_sswcid IN VARCHAR2,
    v_compid IN VARCHAR2
  ) RETURN NUMBER;

  /*===================================================================================
  
    获取某工厂某天的剩余产能占比（view表）
  
    用途:
      用于获取某工厂某天的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_supcode  : 供应商编码
      v_faccode  : 工厂编码
      v_day      : 日期
      v_compid   : 企业id
  
    版本:
      2022-04-07 : 用于获取某工厂某天的剩余产能占比（view表）
  
  ===================================================================================*/
  FUNCTION f_get_restcapcrate_view
  (
    v_ctddid  IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_day     IN DATE,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER;

  /*===================================================================================
  
    获取并更新某工厂某天的剩余产能占比（view表）
  
    用途:
      用于获取并更新某工厂某天的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_faccode  : 工厂编码
      v_day      : 日期
      v_compid   : 企业id
  
    版本:
      2022-04-07 : 用于获取并更新某工厂某天的剩余产能占比（view表）
  
  ===================================================================================*/
  PROCEDURE p_getandupd_restappcapc_view
  (
    v_ctddid  IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_day     IN DATE,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    获取并更新供应商产能预约主表某条数据下的剩余产能占比（view表）
  
    用途:
      用于获取并更新供应商产能预约主表某条数据下的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ptcid    : 供应商预约产能占比主表id
      v_day      : 日期
      v_year     : 年份（年周）
      v_year     : 周次（年周）
  
    版本:
      2022-04-07 : 用于获取并更新供应商产能预约主表某条数据下的剩余产能占比（view表）
  
  ===================================================================================*/
  PROCEDURE p_getandupd_majtabrestappcapc_view
  (
    v_ptcid  IN VARCHAR2,
    v_compid IN VARCHAR2,
    v_year   IN NUMBER DEFAULT NULL,
    v_week   IN NUMBER DEFAULT NULL
  );

  /*===================================================================================
  
    校验供应商产能预约从表修改预约产能占比是否超过100%（带view表）
  
    用途:
      用于校验供应商产能预约从表修改预约产能占比是否超过100%（带view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ctddid        : 供应商产能预约从表id
      v_compid        : 企业id
      v_appcapcrate   : 预约产能占比
  
    版本:
      2022-04-07 : 用于校验供应商产能预约从表修改预约产能占比是否超过100%（带view表）
  
  ===================================================================================*/
  PROCEDURE p_check_restappcapc_view
  (
    v_ctddid      IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_appcapcrate IN NUMBER
  );

  /*===================================================================================
  
    获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表）
  
    用途:
      用于获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ptcid    : 供应商预约产能占比主表id
      v_day      : 日期
      v_year     : 年份（年周）
      v_year     : 周次（年周）
  
    版本:
      2022-04-07 : 获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表）
  
  ===================================================================================*/
  PROCEDURE p_getandupd_slatabrestappcapc_view
  (
    v_ctddid IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表和业务表）
  
    用途:
      用于获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表和业务表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ptcid    : 供应商预约产能占比主表id
      v_day      : 日期
      v_year     : 年份（年周）
      v_year     : 周次（年周）
  
    版本:
      2022-04-07 : 获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表和业务表）
  
  ===================================================================================*/
  PROCEDURE p_getandupd_slatabrestappcapc_withview
  (
    v_ctddid IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*===================================================================================
  
    通过 ptc_id 或 ctdd_id 获取某工厂某天的剩余产能占比（view表）
  
    用途:
      通过 ptc_id 或 ctdd_id 获取某工厂某天的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ptcid    : 供应商产能预约主表id
      v_ctddid   : 供应商产能预约从表id
      v_day      : 日期
      v_compid   : 企业id
  
    版本:
      2022-01-22 : 通过 ptc_id 或 ctdd_id 获取某工厂某天的剩余产能占比（view表）
  
  ===================================================================================*/
  FUNCTION f_get_restcapcrate_by_ptcidorctddid
  (
    v_ptcid  IN VARCHAR2 DEFAULT NULL,
    v_ctddid IN VARCHAR2 DEFAULT NULL,
    v_day    IN DATE,
    v_compid IN VARCHAR2
  ) RETURN NUMBER;

  /*===================================================================================
  
    供应商生产周期配置唯一性校验
  
    用途:
      供应商生产周期配置唯一性校验
  
    入参:
      v_cate      :  分类
      v_procate   :  生产分类
      v_subcate   :  子类
      v_supcodes  :  供应商编码
      v_compid    :  企业id
  
  
    版本:
      2022-04-08 : 用于生成供应商产能预约数据
  
  ===================================================================================*/
  PROCEDURE p_check_prodcyccfg_unq
  (
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_supcodes IN VARCHAR2,
    v_pccid    IN VARCHAR2 DEFAULT NULL,
    v_compid   IN VARCHAR2
  );

  /*===================================================================================
  
    标准工时配置唯一性校验
  
    用途:
      标准工时配置唯一性校验
  
    入参:
      v_cate      :  分类
      v_procate   :  生产分类
      v_subcate   :  子类
      v_compid    :  企业id
  
    版本:
      2022-04-08 : 标准工时配置唯一性校验
  
  ===================================================================================*/
  PROCEDURE p_check_stdwkmincfg_wvunq
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_swmcid  IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  );

  /*===================================================================================
  
    产能规划品类配置唯一性校验
  
    用途:
      产能规划品类配置唯一性校验
  
    入参:
      v_cate      :  分类
      v_procate   :  生产分类
      v_subcate   :  子类
      v_compid    :  企业id
  
    版本:
      2022-04-08 : 产能规划品类配置唯一性校验
  
  ===================================================================================*/
  PROCEDURE p_check_capccps_wvunq
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_cpccid  IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  );

  /*=======================================================================
  
    预计新品校验
  
    入参:
      v_supcode   :  供应商编码
      v_cate      :  分类id
      v_procate   :  生产分类id
      v_suubcate  :  子类id
      v_year      :  年份，字符
      v_season    :  季节id
      v_ware      :  波段
      v_orddate   :  预计下单日期，日期
      v_deldate   :  预计交期，日期
      v_pnid      :  预计新品表id
      v_compid    :  企业id
  
    版本:
      2022-04-08 : 用于生成品类合作供应商数据
  
  =======================================================================*/
  PROCEDURE p_pln_checklogic
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_season  IN VARCHAR2,
    v_ware    IN NUMBER,
    v_orddate IN DATE,
    v_deldate IN DATE,
    v_pnid    IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  );

END pkg_capacity_withview_management;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_capacity_withview_management IS

  /*===================================================================================
  
    获取某工厂除当前供应商外的剩余产能占比
  
    用途:
      用于获取某工厂除当前供应商外的剩余产能占比
  
    用于:
      生产周期配置
  
    入参:
      v_cate     :  分类id
      v_supcode  :  供应商编码
      v_faccode  :  工厂编码
      v_compid   :  企业id
  
    版本:
      2022-04-07 : 用于获取某工厂除当前供应商外的剩余产能占比
      2022-09-07 : 表维度变更，由 sf(sup + fac) 变更为 csf(cate + sup + fac)
  
  ===================================================================================*/
  FUNCTION f_get_restcapc_rate_withview
  (
    v_cate    IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER IS
    v_restcapctotal NUMBER(5, 2);
  BEGIN
    SELECT SUM(nvl(b.appcapc_rate, a.appcapc_rate))
      INTO v_restcapctotal
      FROM scmdata.t_app_capacity_cfg a
      LEFT JOIN scmdata.t_app_capacity_cfg_view b
        ON a.acc_id = b.acc_id
       AND a.company_id = b.company_id
     WHERE a.factory_code = v_faccode
       AND a.company_id = v_compid
       AND NOT EXISTS (SELECT 1
              FROM scmdata.t_app_capacity_cfg
             WHERE supplier_code = v_supcode
               AND factory_code = v_faccode
               AND company_id = v_compid
               AND category = v_cate
               AND acc_id = a.acc_id
               AND company_id = a.company_id);
  
    RETURN 100 - nvl(v_restcapctotal, 0);
  END f_get_restcapc_rate_withview;

  /*===================================================================================
  
    更新该生产工厂剩余产能占比
  
    用途:
      用于更新该生产工厂剩余产能占比
  
    用于:
      生产周期配置
  
    入参:
      v_cate     :  分类id
      v_supcode  :  供应商编码
      v_faccode  :  工厂编码
      v_apprate  :  该供应商预约产能占比
      v_compid   :  企业id
  
    版本:
      2022-04-07 : 用于更新该生产工厂剩余产能占比
      2022-09-07 : 表维度变更，由 sf(sup + fac) 变更为 csf(cate + sup + fac)
  
  ===================================================================================*/
  PROCEDURE p_update_restcapc_rate_withview
  (
    v_cate    IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_apprate IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) IS
    v_restcapctotal NUMBER(5, 2);
  BEGIN
    v_restcapctotal := f_get_restcapc_rate_withview(v_cate    => v_cate,
                                                    v_supcode => v_supcode,
                                                    v_faccode => v_faccode,
                                                    v_compid  => v_compid);
  
    IF v_restcapctotal - v_apprate < 0 THEN
      raise_application_error(-20002, '同一工厂预约产能占比不能大于100%！');
    ELSE
      UPDATE scmdata.t_app_capacity_cfg_view
         SET restcapc_rate = v_restcapctotal - v_apprate
       WHERE (acc_id, company_id) IN
             (SELECT acc_id, company_id
                FROM scmdata.t_app_capacity_cfg
               WHERE factory_code = v_faccode
                 AND company_id = v_compid);
    END IF;
  END p_update_restcapc_rate_withview;

  /*===================================================================================
  
    是否生效校验
  
    用途:
      用于校验供应商不开工是否生效
  
    用于:
      供应商开工通用配置
  
    入参:
      v_sswcid  :  供应商不开工配置id
      v_compid  :  企业id
  
    返回值:
      0-未生效，1-已生效
  
    版本:
      2021-11-18 : 用于校验供应商不开工是否生效,生效则不能修改年份
  
  ===================================================================================*/
  FUNCTION f_check_supnwcfgview_available
  (
    v_sswcid IN VARCHAR2,
    v_compid IN VARCHAR2
  ) RETURN NUMBER IS
    v_tarids  CLOB;
    v_mindate DATE;
    v_year    VARCHAR2(4);
    v_retnum  NUMBER(1);
  BEGIN
    SELECT MAX(year_not_work), MAX(to_char(YEAR))
      INTO v_tarids, v_year
      FROM (SELECT sswc.sswc_id,
                   sswc.company_id,
                   nvl(sswc_view.year, sswc.year) YEAR,
                   nvl(sswc_view.year_not_work, sswc.year_not_work) year_not_work
              FROM scmdata.t_supplier_start_work_cfg sswc
              LEFT JOIN scmdata.t_supplier_start_work_cfg_view sswc_view
                ON sswc.sswc_id = sswc_view.sswc_id
               AND sswc_view.factory_code IS NOT NULL
               AND sswc.company_id = sswc_view.company_id
             WHERE sswc.company_id = v_compid
               AND sswc.bra_id IS NULL
               AND sswc.province_id IS NULL
               AND sswc.factory_code IS NOT NULL
               AND NOT EXISTS (SELECT 1
                      FROM scmdata.t_supplier_start_work_cfg_view
                     WHERE sswc_id = sswc.sswc_id
                       AND company_id = sswc.company_id
                       AND operate_method = 'DEL')
            UNION ALL
            SELECT sswc_id, company_id, YEAR, year_not_work
              FROM scmdata.t_supplier_start_work_cfg_view tmp
             WHERE factory_code IS NOT NULL
               AND operate_method <> 'DEL'
               AND NOT EXISTS
             (SELECT 1
                      FROM scmdata.t_supplier_start_work_cfg
                     WHERE sswc_id = tmp.sswc_id
                       AND company_id = tmp.company_id))
     WHERE sswc_id = v_sswcid
       AND company_id = v_compid;
  
    IF v_tarids IS NULL THEN
      IF to_date(v_year || '-01-01', 'YYYY-MM-DD') < trunc(SYSDATE) THEN
        v_retnum := 1;
      ELSE
        v_retnum := 0;
      END IF;
    ELSE
      SELECT MIN(dd_date)
        INTO v_mindate
        FROM scmdata.t_day_dim
       WHERE instr(';' || v_tarids || ';', ';' || dd_id || ';') > 0;
    
      IF v_mindate <= SYSDATE THEN
        v_retnum := 1;
      ELSE
        v_retnum := 0;
      END IF;
    END IF;
  
    RETURN v_retnum;
  END f_check_supnwcfgview_available;

  /*===================================================================================
  
    计算产能预约明细中某厂某天剩余产能占比
  
    用途:
      用于计算产能预约明细中某厂某天剩余产能占比，
      如果产能预约明细表id（v_ctddid）为空：
          计算产能预约表中某厂某天的剩余产能占比
      如果产能预约明细表id（v_ctddid）不为空：
          计算产能预约表中除产能预约明细表id数据外的，某厂某天的剩余产能占比
  
    入参:
      v_faccode  : 工厂编码
      v_compid   : 企业id
      v_checkday : 查询日期
      v_ctddid   : 产能预约明细表id
  
    版本:
      2021-04-09 : 用于计算产能预约明细中某厂某天剩余产能占比
  
  ===================================================================================*/
  FUNCTION f_get_restcapc_rate_by_day_wv
  (
    v_faccode  IN VARCHAR2,
    v_compid   IN VARCHAR2,
    v_checkday IN DATE,
    v_ctddid   IN VARCHAR2 DEFAULT NULL
  ) RETURN NUMBER IS
    v_retnum NUMBER(5, 2);
  BEGIN
    IF v_ctddid IS NULL THEN
      SELECT nvl(SUM(appcapacity_rate), 0)
        INTO v_retnum
        FROM (SELECT nvl(tab2.ctdd_id, tab1.ctdd_id) ctdd_id,
                     nvl(tab2.ptc_id, tab1.ptc_id) ptc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.appcapacity_rate, tab1.appcapacity_rate) appcapacity_rate,
                     nvl(tab2.day, tab1.day) DAY
                FROM scmdata.t_capacity_appointment_detail tab1
                LEFT JOIN scmdata.t_capacity_appointment_detail_view tab2
                  ON tab1.ctdd_id = tab2.ctdd_id
                 AND tab1.company_id = tab2.company_id
                 AND nvl(tab1.update_time, tab1.create_time) <
                     tab2.operate_time
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_capacity_appointment_detail_view
                       WHERE ptc_id = tab1.ptc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT ctdd_id, ptc_id, company_id, appcapacity_rate, DAY
                FROM scmdata.t_capacity_appointment_detail_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_capacity_appointment_detail
                       WHERE ctdd_id = tab3.ctdd_id
                         AND company_id = tab3.company_id))
       WHERE DAY = v_checkday
         AND (ptc_id, company_id) IN
             (SELECT ptc_id, company_id
                FROM scmdata.t_supplier_capacity_detail
               WHERE factory_code = v_faccode
                 AND company_id = v_compid);
    ELSE
      SELECT nvl(SUM(appcapacity_rate), 0)
        INTO v_retnum
        FROM (SELECT nvl(tab2.ctdd_id, tab1.ctdd_id) ctdd_id,
                     nvl(tab2.ptc_id, tab1.ptc_id) ptc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.appcapacity_rate, tab1.appcapacity_rate) appcapacity_rate,
                     nvl(tab2.day, tab1.day) DAY
                FROM scmdata.t_capacity_appointment_detail tab1
                LEFT JOIN scmdata.t_capacity_appointment_detail_view tab2
                  ON tab1.ctdd_id = tab2.ctdd_id
                 AND tab1.company_id = tab2.company_id
                 AND nvl(tab1.update_time, tab1.create_time) <
                     tab2.operate_time
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_capacity_appointment_detail_view
                       WHERE ptc_id = tab1.ptc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT ctdd_id, ptc_id, company_id, appcapacity_rate, DAY
                FROM scmdata.t_capacity_appointment_detail_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_capacity_appointment_detail
                       WHERE ctdd_id = tab3.ctdd_id
                         AND company_id = tab3.company_id))
       WHERE ctdd_id <> v_ctddid
         AND DAY = v_checkday
         AND (ptc_id, company_id) IN
             (SELECT ptc_id, company_id
                FROM scmdata.t_supplier_capacity_detail
               WHERE factory_code = v_faccode
                 AND company_id = v_compid);
    END IF;
  
    RETURN 100 - v_retnum;
  END f_get_restcapc_rate_by_day_wv;

  /*===================================================================================
  
    "年+工厂"唯一校验
  
    用途:
      用于供应商开工"年+工厂"唯一性校验
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year     :  年份
      v_faccode  :  生产工厂编码
      v_sswcid   :  供应商开工通用配置id
      v_compid   :  企业id
  
    版本:
      2022-04-07 : 用于供应商开工"年+工厂"唯一性校验
  
  ===================================================================================*/
  PROCEDURE p_check_factory_unq_wv
  (
    v_year    IN NUMBER,
    v_faccode IN VARCHAR2,
    v_sswcid  IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) IS
    v_jugnum  NUMBER(4);
    v_facname VARCHAR2(512);
  BEGIN
    IF v_sswcid IS NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.bra_id, tab1.bra_id) bra_id,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.province_id, tab1.province_id) province_id,
                     nvl(tab2.city_id, tab1.city_id) city_id,
                     nvl(tab2.country_id, tab1.country_id) country_id,
                     nvl(tab2.factory_code, tab1.factory_code) factory_code
                FROM scmdata.t_supplier_start_work_cfg tab1
                LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                  ON tab1.sswc_id = tab2.sswc_id
                 AND tab1.company_id = tab2.company_id
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg_view
                       WHERE sswc_id = tab1.sswc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT sswc_id,
                     company_id,
                     bra_id,
                     YEAR,
                     province_id,
                     city_id,
                     country_id,
                     factory_code
                FROM scmdata.t_supplier_start_work_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg
                       WHERE sswc_id = tab3.sswc_id
                         AND company_id = tab3.company_id))
       WHERE YEAR = v_year
         AND factory_code = v_faccode
         AND company_id = v_compid
         AND bra_id IS NULL
         AND province_id IS NULL;
    ELSIF v_sswcid IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.bra_id, tab1.bra_id) bra_id,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.province_id, tab1.province_id) province_id,
                     nvl(tab2.city_id, tab1.city_id) city_id,
                     nvl(tab2.country_id, tab1.country_id) country_id,
                     nvl(tab2.factory_code, tab1.factory_code) factory_code
                FROM scmdata.t_supplier_start_work_cfg tab1
                LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                  ON tab1.sswc_id = tab2.sswc_id
                 AND tab1.company_id = tab2.company_id
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg_view
                       WHERE sswc_id = tab1.sswc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT sswc_id,
                     company_id,
                     bra_id,
                     YEAR,
                     province_id,
                     city_id,
                     country_id,
                     factory_code
                FROM scmdata.t_supplier_start_work_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg
                       WHERE sswc_id = tab3.sswc_id
                         AND company_id = tab3.company_id))
       WHERE YEAR = v_year
         AND factory_code = v_faccode
         AND sswc_id <> v_sswcid
         AND company_id = v_compid
         AND bra_id IS NULL
         AND province_id IS NULL;
    END IF;
  
    IF v_jugnum > 0 THEN
      SELECT MAX(supplier_company_name)
        INTO v_facname
        FROM scmdata.t_supplier_info
       WHERE supplier_code = v_faccode
         AND company_id = v_compid;
    
      raise_application_error(-20002,
                              '已存在' || v_year || v_facname || '不开工配置数据');
    END IF;
  END p_check_factory_unq_wv;

  /*===================================================================================
  
    "年+区域"唯一校验
  
    用途:
      用于供应商开工"年+区域"唯一校验
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year       :  年份
      v_provid     :  省id
      v_cityid     :  市id
      v_countryid  :  区id
      v_sswcid     :  供应商开工通用配置id
      v_compid     :  企业id
  
    版本:
      2022-04-07 : 用于供应商开工"年+区域"唯一校验
  
  ===================================================================================*/
  PROCEDURE p_check_area_unq_wv
  (
    v_year      IN NUMBER,
    v_provid    IN VARCHAR2,
    v_cityid    IN VARCHAR2,
    v_countryid IN VARCHAR2,
    v_sswcid    IN VARCHAR2 DEFAULT NULL,
    v_compid    IN VARCHAR2
  ) IS
    v_jugnum      NUMBER(4);
    v_provname    VARCHAR2(32);
    v_cityname    VARCHAR2(64);
    v_countryname VARCHAR2(128);
  BEGIN
    IF v_sswcid IS NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.bra_id, tab1.bra_id) bra_id,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.province_id, tab1.province_id) province_id,
                     nvl(tab2.city_id, tab1.city_id) city_id,
                     nvl(tab2.country_id, tab1.country_id) country_id,
                     nvl(tab2.factory_code, tab1.factory_code) factory_code
                FROM scmdata.t_supplier_start_work_cfg tab1
                LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                  ON tab1.sswc_id = tab2.sswc_id
                 AND tab1.company_id = tab2.company_id
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg_view
                       WHERE sswc_id = tab1.sswc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT sswc_id,
                     company_id,
                     bra_id,
                     YEAR,
                     province_id,
                     city_id,
                     country_id,
                     factory_code
                FROM scmdata.t_supplier_start_work_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg
                       WHERE sswc_id = tab3.sswc_id
                         AND company_id = tab3.company_id))
       WHERE YEAR = v_year
         AND province_id = v_provid
         AND city_id = v_cityid
         AND country_id = v_countryid
         AND bra_id IS NULL
         AND factory_code IS NULL
         AND company_id = v_compid;
    ELSIF v_sswcid IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.bra_id, tab1.bra_id) bra_id,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.province_id, tab1.province_id) province_id,
                     nvl(tab2.city_id, tab1.city_id) city_id,
                     nvl(tab2.country_id, tab1.country_id) country_id,
                     nvl(tab2.factory_code, tab1.factory_code) factory_code
                FROM scmdata.t_supplier_start_work_cfg tab1
                LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                  ON tab1.sswc_id = tab2.sswc_id
                 AND tab1.company_id = tab2.company_id
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg_view
                       WHERE sswc_id = tab1.sswc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT sswc_id,
                     company_id,
                     bra_id,
                     YEAR,
                     province_id,
                     city_id,
                     country_id,
                     factory_code
                FROM scmdata.t_supplier_start_work_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg
                       WHERE sswc_id = tab3.sswc_id
                         AND company_id = tab3.company_id))
       WHERE YEAR = v_year
         AND province_id = v_provid
         AND city_id = v_cityid
         AND country_id = v_countryid
         AND bra_id IS NULL
         AND factory_code IS NULL
         AND sswc_id <> v_sswcid
         AND company_id = v_compid;
    END IF;
  
    IF v_jugnum > 0 THEN
      SELECT MAX(province)
        INTO v_provname
        FROM scmdata.dic_province
       WHERE provinceid = v_provid
         AND pause = 0;
    
      SELECT MAX(city)
        INTO v_cityname
        FROM scmdata.dic_city
       WHERE cityno = v_cityid
         AND pause = 0;
    
      SELECT MAX(county)
        INTO v_countryname
        FROM scmdata.dic_county
       WHERE countyid = v_countryid
         AND pause = 0;
      raise_application_error(-20002,
                              '已存在' || v_provname || v_cityname ||
                              v_countryname || '不开工配置数据');
    END IF;
  END p_check_area_unq_wv;

  /*===================================================================================
  
    "年+分部+区域"唯一校验
  
    用途:
      用于供应商开工"年+分部+区域"唯一校验
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year       :  年份
      v_provid     :  省id
      v_cityid     :  市id
      v_countryid  :  区id
      v_sswcid     :  供应商开工通用配置id
      v_compid     :  企业id
  
    版本:
      2022-04-07 : 用于供应商开工"年+分部+区域"唯一校验
  
  ===================================================================================*/
  PROCEDURE p_check_bra_area_unq_wv
  (
    v_year      IN NUMBER,
    v_braid     IN VARCHAR2,
    v_provid    IN VARCHAR2,
    v_cityid    IN VARCHAR2,
    v_countryid IN VARCHAR2,
    v_sswcid    IN VARCHAR2 DEFAULT NULL,
    v_compid    IN VARCHAR2
  ) IS
    v_jugnum      NUMBER(4);
    v_braname     VARCHAR2(8);
    v_provname    VARCHAR2(32);
    v_cityname    VARCHAR2(64);
    v_countryname VARCHAR2(128);
  BEGIN
    IF v_sswcid IS NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.bra_id, tab1.bra_id) bra_id,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.province_id, tab1.province_id) province_id,
                     nvl(tab2.city_id, tab1.city_id) city_id,
                     nvl(tab2.country_id, tab1.country_id) country_id,
                     nvl(tab2.factory_code, tab1.factory_code) factory_code
                FROM scmdata.t_supplier_start_work_cfg tab1
                LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                  ON tab1.sswc_id = tab2.sswc_id
                 AND tab1.company_id = tab2.company_id
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg_view
                       WHERE sswc_id = tab1.sswc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT sswc_id,
                     company_id,
                     bra_id,
                     YEAR,
                     province_id,
                     city_id,
                     country_id,
                     factory_code
                FROM scmdata.t_supplier_start_work_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg
                       WHERE sswc_id = tab3.sswc_id
                         AND company_id = tab3.company_id))
       WHERE YEAR = v_year
         AND bra_id = v_braid
         AND province_id = v_provid
         AND city_id = v_cityid
         AND country_id = v_countryid
         AND factory_code IS NULL
         AND company_id = v_compid;
    ELSIF v_sswcid IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.bra_id, tab1.bra_id) bra_id,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.province_id, tab1.province_id) province_id,
                     nvl(tab2.city_id, tab1.city_id) city_id,
                     nvl(tab2.country_id, tab1.country_id) country_id,
                     nvl(tab2.factory_code, tab1.factory_code) factory_code
                FROM scmdata.t_supplier_start_work_cfg tab1
                LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                  ON tab1.sswc_id = tab2.sswc_id
                 AND tab1.company_id = tab2.company_id
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg_view
                       WHERE sswc_id = tab1.sswc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT sswc_id,
                     company_id,
                     bra_id,
                     YEAR,
                     province_id,
                     city_id,
                     country_id,
                     factory_code
                FROM scmdata.t_supplier_start_work_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg
                       WHERE sswc_id = tab3.sswc_id
                         AND company_id = tab3.company_id))
       WHERE YEAR = v_year
         AND bra_id = v_braid
         AND province_id = v_provid
         AND city_id = v_cityid
         AND country_id = v_countryid
         AND factory_code IS NULL
         AND sswc_id <> v_sswcid
         AND company_id = v_compid;
    END IF;
  
    IF v_jugnum > 0 THEN
      SELECT MAX(group_dict_name)
        INTO v_braname
        FROM scmdata.sys_group_dict
       WHERE group_dict_value = v_braid
         AND group_dict_type = 'PRODUCT_TYPE';
    
      SELECT MAX(province)
        INTO v_provname
        FROM scmdata.dic_province
       WHERE provinceid = v_provid
         AND pause = 0;
    
      SELECT MAX(city)
        INTO v_cityname
        FROM scmdata.dic_city
       WHERE cityno = v_cityid
         AND pause = 0;
    
      SELECT MAX(county)
        INTO v_countryname
        FROM scmdata.dic_county
       WHERE countyid = v_countryid
         AND pause = 0;
      raise_application_error(-20002,
                              '已存在' || v_year || v_braname || v_provname ||
                              v_cityname || v_countryname || '不开工配置数据');
    END IF;
  END p_check_bra_area_unq_wv;

  /*===================================================================================
  
    "年+分部"唯一校验
  
    用途:
      用于供应商开工"年+分部"唯一校验
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year    :  年份
      v_braid   :  分部id
      v_sswcid  :  供应商开工通用配置id
      v_compid  :  企业id
  
    版本:
      2022-04-07 : 用于供应商开工分部唯一校验
  
  ===================================================================================*/
  PROCEDURE p_check_bra_unq_wv
  (
    v_year   IN NUMBER,
    v_braid  IN VARCHAR2,
    v_sswcid IN VARCHAR2 DEFAULT NULL,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum  NUMBER(4);
    v_braname VARCHAR2(8);
  BEGIN
    IF v_sswcid IS NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.bra_id, tab1.bra_id) bra_id,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.province_id, tab1.province_id) province_id,
                     nvl(tab2.city_id, tab1.city_id) city_id,
                     nvl(tab2.country_id, tab1.country_id) country_id,
                     nvl(tab2.factory_code, tab1.factory_code) factory_code
                FROM scmdata.t_supplier_start_work_cfg tab1
                LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                  ON tab1.sswc_id = tab2.sswc_id
                 AND tab1.company_id = tab2.company_id
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg_view
                       WHERE sswc_id = tab1.sswc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT sswc_id,
                     company_id,
                     bra_id,
                     YEAR,
                     province_id,
                     city_id,
                     country_id,
                     factory_code
                FROM scmdata.t_supplier_start_work_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg
                       WHERE sswc_id = tab3.sswc_id
                         AND company_id = tab3.company_id))
       WHERE YEAR = v_year
         AND bra_id = v_braid
         AND province_id IS NULL
         AND factory_code IS NULL
         AND company_id = v_compid;
    ELSIF v_sswcid IS NOT NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                     nvl(tab2.company_id, tab1.company_id) company_id,
                     nvl(tab2.bra_id, tab1.bra_id) bra_id,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.province_id, tab1.province_id) province_id,
                     nvl(tab2.city_id, tab1.city_id) city_id,
                     nvl(tab2.country_id, tab1.country_id) country_id,
                     nvl(tab2.factory_code, tab1.factory_code) factory_code
                FROM scmdata.t_supplier_start_work_cfg tab1
                LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                  ON tab1.sswc_id = tab2.sswc_id
                 AND tab1.company_id = tab2.company_id
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg_view
                       WHERE sswc_id = tab1.sswc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT sswc_id,
                     company_id,
                     bra_id,
                     YEAR,
                     province_id,
                     city_id,
                     country_id,
                     factory_code
                FROM scmdata.t_supplier_start_work_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_supplier_start_work_cfg
                       WHERE sswc_id = tab3.sswc_id
                         AND company_id = tab3.company_id))
       WHERE YEAR = v_year
         AND bra_id = v_braid
         AND sswc_id <> v_sswcid
         AND province_id IS NULL
         AND factory_code IS NULL
         AND company_id = v_compid;
    END IF;
  
    IF v_jugnum > 0 THEN
      SELECT group_dict_name
        INTO v_braname
        FROM scmdata.sys_group_dict
       WHERE group_dict_value = v_braid
         AND group_dict_type = 'PRODUCT_TYPE';
      raise_application_error(-20002,
                              '已存在' || v_year || v_braname || '分部不开工配置数据');
    END IF;
  END p_check_bra_unq_wv;

  /*===================================================================================
  
    开工唯一校验
  
    用途:
      用于供应商开工唯一性
  
    用于:
      供应商开工通用配置
  
    入参:
      v_year      :  年
      v_braid     :  分部id
      v_provid    :  省id
      v_cityid    :  市id
      v_countryid :  区id
      v_faccode   :  工厂编码
      v_sswcid    :  供应商开工通用配置id
      v_ckmode    :  校验模式
      v_compid    :  企业id
  
    版本:
      2022-04-07 : 用于生成通用日期维度 x 年数据
  
  ===================================================================================*/
  PROCEDURE p_check_supplier_startwork_wv
  (
    v_year      IN NUMBER,
    v_braid     IN VARCHAR2 DEFAULT NULL,
    v_provid    IN VARCHAR2 DEFAULT NULL,
    v_cityid    IN VARCHAR2 DEFAULT NULL,
    v_countryid IN VARCHAR2 DEFAULT NULL,
    v_faccode   IN VARCHAR2 DEFAULT NULL,
    v_sswcid    IN VARCHAR2 DEFAULT NULL,
    v_ckmode    IN VARCHAR2,
    v_compid    IN VARCHAR2
  ) IS
    v_ckyear        NUMBER(4);
    v_ckyearnotwork CLOB;
    v_ckday         DATE;
    v_jugnum        NUMBER(4);
  BEGIN
    IF v_faccode IS NOT NULL THEN
      p_check_factory_unq_wv(v_year    => v_year,
                             v_faccode => v_faccode,
                             v_sswcid  => v_sswcid,
                             v_compid  => v_compid);
    
    ELSIF v_provid IS NOT NULL
          AND v_braid IS NULL THEN
      p_check_area_unq_wv(v_year      => v_year,
                          v_provid    => v_provid,
                          v_cityid    => v_cityid,
                          v_countryid => v_countryid,
                          v_sswcid    => v_sswcid,
                          v_compid    => v_compid);
    
    ELSIF v_provid IS NOT NULL
          AND v_braid IS NOT NULL THEN
      p_check_bra_area_unq_wv(v_year      => v_year,
                              v_braid     => v_braid,
                              v_provid    => v_provid,
                              v_cityid    => v_cityid,
                              v_countryid => v_countryid,
                              v_sswcid    => v_sswcid,
                              v_compid    => v_compid);
    
    ELSIF v_provid IS NULL
          AND v_braid IS NOT NULL THEN
      p_check_bra_unq_wv(v_year   => v_year,
                         v_braid  => v_braid,
                         v_sswcid => v_sswcid,
                         v_compid => v_compid);
    
    ELSIF v_ckmode = 'PB'
          AND v_provid IS NULL
          AND v_braid IS NULL THEN
      raise_application_error(-20002, '分部/省市区不允许为空！');
    ELSIF v_ckmode = 'FC'
          AND v_faccode IS NULL THEN
      raise_application_error(-20002, '生产工厂不允许为空！');
    END IF;
  
    SELECT COUNT(1), MAX(YEAR), MAX(year_not_work)
      INTO v_jugnum, v_ckyear, v_ckyearnotwork
      FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                   nvl(tab2.company_id, tab1.company_id) company_id,
                   nvl(tab2.year, tab1.year) YEAR,
                   nvl(tab2.year_not_work, tab1.year_not_work) year_not_work
              FROM scmdata.t_supplier_start_work_cfg tab1
              LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                ON tab1.sswc_id = tab2.sswc_id
               AND tab1.company_id = tab2.company_id
             WHERE NOT EXISTS (SELECT 1
                      FROM scmdata.t_supplier_start_work_cfg_view
                     WHERE sswc_id = tab1.sswc_id
                       AND company_id = tab1.company_id
                       AND operate_method = 'DEL')
            UNION ALL
            SELECT sswc_id, company_id, YEAR, year_not_work
              FROM scmdata.t_supplier_start_work_cfg_view tab3
             WHERE operate_method <> 'DEL'
               AND NOT EXISTS
             (SELECT 1
                      FROM scmdata.t_supplier_start_work_cfg
                     WHERE sswc_id = tab3.sswc_id
                       AND company_id = tab3.company_id))
     WHERE sswc_id = v_sswcid
       AND company_id = v_compid;
  
    IF nvl(v_year, 2000) <> nvl(v_ckyear, 2000)
       AND v_jugnum = 1 THEN
      IF v_ckyearnotwork IS NULL THEN
        IF to_date(to_char(nvl(v_ckyear, 2000)) || '-01-01', 'YYYY-MM-DD') <
           trunc(SYSDATE) THEN
          raise_application_error(-20002, '年份已生效，年份不可修改！');
        END IF;
      ELSE
        SELECT MIN(dd_date)
          INTO v_ckday
          FROM scmdata.t_day_dim
         WHERE instr(v_ckyearnotwork, dd_id) > 0;
      
        IF trunc(v_ckday) < trunc(SYSDATE) THEN
          raise_application_error(-20002,
                                  '年不开工日期已生效，年份不可修改！');
        END IF;
      END IF;
    END IF;
  END p_check_supplier_startwork_wv;

  /*===================================================================================
  
    是否生效校验
  
    用途:
      用于校验供应商不开工是否生效
  
    用于:
      供应商开工通用配置
  
    入参:
      v_sswcid  :  供应商不开工配置id
      v_compid  :  企业id
  
    返回值:
      0-未生效，1-已生效
  
    版本:
      2021-11-18 : 用于校验供应商不开工是否生效,生效则不能修改年份
  
  ===================================================================================*/
  FUNCTION f_check_supnwcfg_available_wv
  (
    v_sswcid IN VARCHAR2,
    v_compid IN VARCHAR2
  ) RETURN NUMBER IS
    v_tarids  CLOB;
    v_mindate DATE;
    v_year    VARCHAR2(4);
    v_retnum  NUMBER(1);
  BEGIN
    SELECT MAX(year_not_work), MAX(to_char(YEAR))
      INTO v_tarids, v_year
      FROM (SELECT nvl(tab2.sswc_id, tab1.sswc_id) sswc_id,
                   nvl(tab2.company_id, tab1.company_id) company_id,
                   nvl(tab2.year, tab1.year) YEAR,
                   nvl(tab2.year_not_work, tab1.year_not_work) year_not_work
              FROM scmdata.t_supplier_start_work_cfg tab1
              LEFT JOIN scmdata.t_supplier_start_work_cfg_view tab2
                ON tab1.sswc_id = tab2.sswc_id
               AND tab1.company_id = tab2.company_id
             WHERE NOT EXISTS (SELECT 1
                      FROM scmdata.t_supplier_start_work_cfg_view
                     WHERE sswc_id = tab1.sswc_id
                       AND company_id = tab1.company_id
                       AND operate_method = 'DEL')
            UNION ALL
            SELECT sswc_id, company_id, YEAR, year_not_work
              FROM scmdata.t_supplier_start_work_cfg_view tab3
             WHERE operate_method <> 'DEL'
               AND NOT EXISTS
             (SELECT 1
                      FROM scmdata.t_supplier_start_work_cfg
                     WHERE sswc_id = tab3.sswc_id
                       AND company_id = tab3.company_id))
     WHERE sswc_id = v_sswcid
       AND company_id = v_compid;
  
    IF v_tarids IS NULL THEN
      IF to_date(v_year || '-01-01', 'YYYY-MM-DD') < trunc(SYSDATE) THEN
        v_retnum := 1;
      ELSE
        v_retnum := 0;
      END IF;
    ELSE
      SELECT MIN(dd_date)
        INTO v_mindate
        FROM scmdata.t_day_dim
       WHERE instr(';' || v_tarids || ';', ';' || dd_id || ';') > 0;
    
      IF v_mindate <= SYSDATE THEN
        v_retnum := 1;
      ELSE
        v_retnum := 0;
      END IF;
    END IF;
  
    RETURN v_retnum;
  END f_check_supnwcfg_available_wv;

  /*===================================================================================
  
    获取某工厂某天的剩余产能占比（view表）
  
    用途:
      用于获取某工厂某天的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_faccode  : 工厂编码
      v_day      : 日期
      v_compid   : 企业id
  
    版本:
      2022-04-07 : 用于获取某工厂某天的剩余产能占比（view表）
  
  ===================================================================================*/
  FUNCTION f_get_restcapcrate_view
  (
    v_ctddid  IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_day     IN DATE,
    v_compid  IN VARCHAR2
  ) RETURN NUMBER IS
    v_appcapcrate  NUMBER(5, 2);
    v_restcapcrate NUMBER(5, 2);
  BEGIN
    SELECT SUM(b.appcapacity_rate)
      INTO v_appcapcrate
      FROM scmdata.t_supplier_capacity_detail a
     INNER JOIN (SELECT nvl(cad_view.ctdd_id, cad.ctdd_id) ctdd_id,
                        nvl(cad_view.company_id, cad.company_id) company_id,
                        nvl(cad_view.ptc_id, cad.ptc_id) ptc_id,
                        nvl(cad_view.day, cad.day) DAY,
                        nvl(cad_view.appcapacity_rate, cad.appcapacity_rate) appcapacity_rate
                   FROM scmdata.t_capacity_appointment_detail cad
                   LEFT JOIN scmdata.t_capacity_appointment_detail_view cad_view
                     ON cad.ctdd_id = cad_view.ctdd_id
                    AND cad.company_id = cad_view.company_id
                    AND NOT EXISTS
                  (SELECT 1
                           FROM scmdata.t_capacity_appointment_detail_view tmp1
                          WHERE tmp1.ctdd_id = cad.ctdd_id
                            AND tmp1.company_id = cad.company_id
                            AND tmp1.operate_method = 'DEL')
                 UNION ALL
                 SELECT ctdd_id, company_id, ptc_id, DAY, appcapacity_rate
                   FROM scmdata.t_capacity_appointment_detail_view viewtab
                  WHERE operate_method <> 'DEL'
                    AND NOT EXISTS
                  (SELECT 1
                           FROM scmdata.t_capacity_appointment_detail tmp2
                          WHERE tmp2.ctdd_id = viewtab.ctdd_id
                            AND tmp2.company_id = viewtab.company_id)) b
        ON a.ptc_id = b.ptc_id
       AND a.company_id = b.company_id
     WHERE a.supplier_code = v_supcode
       AND a.factory_code = v_faccode
       AND b.ctdd_id <> nvl(v_ctddid, ' ')
       AND b.day = v_day
       AND a.company_id = v_compid;
  
    v_restcapcrate := 100 - nvl(v_appcapcrate, 0);
  
    RETURN v_restcapcrate;
  END f_get_restcapcrate_view;

  /*===================================================================================
  
    获取并更新某工厂某天的剩余产能占比（view表）
  
    用途:
      用于获取并更新某工厂某天的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_faccode  : 工厂编码
      v_day      : 日期
      v_compid   : 企业id
  
    版本:
      2022-04-07 : 用于获取并更新某工厂某天的剩余产能占比（view表）
  
  ===================================================================================*/
  PROCEDURE p_getandupd_restappcapc_view
  (
    v_ctddid  IN VARCHAR2,
    v_supcode IN VARCHAR2,
    v_faccode IN VARCHAR2,
    v_day     IN DATE,
    v_compid  IN VARCHAR2
  ) IS
    v_restcapcrate NUMBER(5, 2);
  BEGIN
    v_restcapcrate := f_get_restcapcrate_view(v_ctddid  => v_ctddid,
                                              v_supcode => v_supcode,
                                              v_faccode => v_faccode,
                                              v_day     => v_day,
                                              v_compid  => v_compid);
  
    UPDATE scmdata.t_capacity_appointment_detail_view
       SET restcapc_rate = v_restcapcrate
     WHERE (ptc_id, DAY, company_id) IN
           (SELECT c.ptc_id, c.day, c.company_id
              FROM scmdata.t_capacity_appointment_detail c
             INNER JOIN scmdata.t_supplier_capacity_detail d
                ON c.ptc_id = d.ptc_id
               AND c.company_id = d.company_id
             WHERE d.factory_code = v_faccode
               AND c.company_id = v_compid);
  END p_getandupd_restappcapc_view;

  /*===================================================================================
  
    获取并更新供应商产能预约主表某条数据下的剩余产能占比（view表）
  
    用途:
      用于获取并更新供应商产能预约主表某条数据下的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ptcid    : 供应商预约产能占比主表id
      v_day      : 日期
      v_year     : 年份（年周）
      v_year     : 周次（年周）
  
    版本:
      2022-04-07 : 用于获取并更新供应商产能预约主表某条数据下的剩余产能占比（view表）
  
  ===================================================================================*/
  PROCEDURE p_getandupd_majtabrestappcapc_view
  (
    v_ptcid  IN VARCHAR2,
    v_compid IN VARCHAR2,
    v_year   IN NUMBER DEFAULT NULL,
    v_week   IN NUMBER DEFAULT NULL
  ) IS
    TYPE rctype IS REF CURSOR;
    rc         rctype;
    v_cond     VARCHAR2(512);
    v_exesql   VARCHAR2(2048);
    rc_supcode VARCHAR2(32);
    rc_faccode VARCHAR2(32);
    rc_ctddid  VARCHAR2(32);
    rc_day     DATE;
  BEGIN
    IF v_year IS NULL
       OR v_week IS NULL THEN
      v_cond := ' AND A.YEAR = ' || v_year || ' AND A.WEEK = ' || v_week;
    END IF;
  
    v_exesql := 'SELECT A.SUPPLIER_CODE, A.FACTORY_CODE, B.CTDD_ID, B.DAY FROM SCMDATA.T_SUPPLIER_CAPACITY_DETAIL A ' ||
                'INNER JOIN SCMDATA.T_CAPACITY_APPOINTMENT_DETAIL B ON A.PTC_ID = B.PTC_ID ' ||
                'AND A.COMPANY_ID = B.COMPANY_ID WHERE A.PTC_ID = ''' ||
                v_ptcid || ''' ' || 'AND A.COMPANY_ID = ''' || v_compid ||
                ''' ' || v_cond;
    OPEN rc FOR v_exesql;
    LOOP
      FETCH rc
        INTO rc_supcode, rc_faccode, rc_ctddid, rc_day;
      EXIT WHEN rc%NOTFOUND;
      p_getandupd_restappcapc_view(v_ctddid  => rc_ctddid,
                                   v_supcode => rc_supcode,
                                   v_faccode => rc_faccode,
                                   v_day     => rc_day,
                                   v_compid  => v_compid);
    END LOOP;
  END p_getandupd_majtabrestappcapc_view;

  /*===================================================================================
  
    校验供应商产能预约从表修改预约产能占比是否超过100%（带view表）
  
    用途:
      用于校验供应商产能预约从表修改预约产能占比是否超过100%（带view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ctddid        : 供应商产能预约从表id
      v_compid        : 企业id
      v_appcapcrate   : 预约产能占比
  
    版本:
      2022-04-07 : 用于校验供应商产能预约从表修改预约产能占比是否超过100%（带view表）
  
  ===================================================================================*/
  PROCEDURE p_check_restappcapc_view
  (
    v_ctddid      IN VARCHAR2,
    v_compid      IN VARCHAR2,
    v_appcapcrate IN NUMBER
  ) IS
    v_supcode      VARCHAR2(32);
    v_faccode      VARCHAR2(32);
    v_day          DATE;
    v_restcapcrate NUMBER(5, 2);
  BEGIN
    SELECT MAX(a.supplier_code), MAX(a.factory_code), MAX(b.day)
      INTO v_supcode, v_faccode, v_day
      FROM scmdata.t_supplier_capacity_detail a
     INNER JOIN scmdata.t_capacity_appointment_detail b
        ON a.ptc_id = b.ptc_id
       AND a.company_id = b.company_id
     WHERE b.ctdd_id = v_ctddid
       AND b.company_id = v_compid;
  
    v_restcapcrate := f_get_restcapcrate_view(v_ctddid  => v_ctddid,
                                              v_supcode => v_supcode,
                                              v_faccode => v_faccode,
                                              v_day     => v_day,
                                              v_compid  => v_compid);
  
    IF v_restcapcrate - v_appcapcrate < 0 THEN
      raise_application_error(-20002, '预约产能占比不能超过可用产能占比！');
    ELSIF trunc(v_day) < trunc(SYSDATE, 'IW') THEN
      raise_application_error(-20002, '仅能修改当前周和未来周数据！');
    END IF;
  END p_check_restappcapc_view;

  /*===================================================================================
  
    获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表）
  
    用途:
      用于获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ptcid    : 供应商预约产能占比主表id
      v_day      : 日期
      v_year     : 年份（年周）
      v_year     : 周次（年周）
  
    版本:
      2022-04-07 : 获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表）
  
  ===================================================================================*/
  PROCEDURE p_getandupd_slatabrestappcapc_view
  (
    v_ctddid IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_faccode      VARCHAR2(32);
    v_day          DATE;
    v_restcapcrate NUMBER(5, 2);
  BEGIN
    SELECT MAX(a.factory_code), MAX(b.day)
      INTO v_faccode, v_day
      FROM scmdata.t_supplier_capacity_detail a
     INNER JOIN scmdata.t_capacity_appointment_detail b
        ON a.ptc_id = b.ptc_id
       AND a.company_id = b.company_id
     WHERE b.ctdd_id = v_ctddid
       AND b.company_id = v_compid;
  
    FOR i IN (SELECT d.ctdd_id, d.company_id
                FROM scmdata.t_supplier_capacity_detail c
               INNER JOIN scmdata.t_capacity_appointment_detail d
                  ON c.ptc_id = d.ptc_id
                 AND c.company_id = d.company_id
               WHERE c.factory_code = v_faccode
                 AND d.day = v_day
                 AND c.company_id = v_compid) LOOP
      v_restcapcrate := f_get_restcapc_rate_by_day_wv(v_faccode  => v_faccode,
                                                      v_compid   => i.company_id,
                                                      v_checkday => v_day,
                                                      v_ctddid   => i.ctdd_id);
      UPDATE scmdata.t_capacity_appointment_detail_view
         SET restcapc_rate = v_restcapcrate
       WHERE ctdd_id = i.ctdd_id
         AND company_id = i.company_id;
    END LOOP;
  END p_getandupd_slatabrestappcapc_view;

  /*===================================================================================
  
    获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表和业务表）
  
    用途:
      用于获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表和业务表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ptcid    : 供应商预约产能占比主表id
      v_day      : 日期
      v_year     : 年份（年周）
      v_year     : 周次（年周）
  
    版本:
      2022-04-07 : 获取并更新供应商产能预约从表某条数据及其他关联的的剩余产能占比（view表和业务表）
  
  ===================================================================================*/
  PROCEDURE p_getandupd_slatabrestappcapc_withview
  (
    v_ctddid IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_faccode      VARCHAR2(32);
    v_day          DATE;
    v_restcapcrate NUMBER(5, 2);
  BEGIN
    SELECT MAX(a.factory_code), MAX(b.day)
      INTO v_faccode, v_day
      FROM scmdata.t_supplier_capacity_detail a
     INNER JOIN scmdata.t_capacity_appointment_detail b
        ON a.ptc_id = b.ptc_id
       AND a.company_id = b.company_id
     WHERE b.ctdd_id = v_ctddid
       AND b.company_id = v_compid;
  
    FOR i IN (SELECT d.ctdd_id, d.company_id
                FROM scmdata.t_supplier_capacity_detail c
               INNER JOIN scmdata.t_capacity_appointment_detail d
                  ON c.ptc_id = d.ptc_id
                 AND c.company_id = d.company_id
               WHERE c.factory_code = v_faccode
                 AND d.day = v_day
                 AND c.company_id = v_compid) LOOP
      v_restcapcrate := f_get_restcapc_rate_by_day_wv(v_faccode  => v_faccode,
                                                      v_compid   => i.company_id,
                                                      v_checkday => v_day,
                                                      v_ctddid   => i.ctdd_id);
      UPDATE scmdata.t_capacity_appointment_detail
         SET restcapc_rate = v_restcapcrate
       WHERE ctdd_id = i.ctdd_id
         AND company_id = i.company_id;
    
      UPDATE scmdata.t_capacity_appointment_detail_view
         SET restcapc_rate = v_restcapcrate
       WHERE ctdd_id = i.ctdd_id
         AND company_id = i.company_id;
    END LOOP;
  END p_getandupd_slatabrestappcapc_withview;

  /*===================================================================================
  
    通过 ptc_id 或 ctdd_id 获取某工厂某天的剩余产能占比（view表）
  
    用途:
      通过 ptc_id 或 ctdd_id 获取某工厂某天的剩余产能占比（view表）
  
    用于:
      供应商产能预约
  
    入参:
      v_ptcid    : 供应商产能预约主表id
      v_ctddid   : 供应商产能预约从表id
      v_day      : 日期
      v_compid   : 企业id
  
    版本:
      2022-04-07 : 通过 ptc_id 或 ctdd_id 获取某工厂某天的剩余产能占比（view表）
  
  ===================================================================================*/
  FUNCTION f_get_restcapcrate_by_ptcidorctddid
  (
    v_ptcid  IN VARCHAR2 DEFAULT NULL,
    v_ctddid IN VARCHAR2 DEFAULT NULL,
    v_day    IN DATE,
    v_compid IN VARCHAR2
  ) RETURN NUMBER IS
    v_supcode      VARCHAR2(32);
    v_faccode      VARCHAR2(32);
    v_tmpctddid    VARCHAR2(32);
    v_restcapcrate NUMBER(5, 2);
  BEGIN
    IF v_ptcid IS NOT NULL THEN
      SELECT MAX(supplier_code), MAX(factory_code)
        INTO v_supcode, v_faccode
        FROM scmdata.t_supplier_capacity_detail
       WHERE ptc_id = v_ptcid
         AND company_id = v_compid;
    
      SELECT MAX(ctdd_id)
        INTO v_tmpctddid
        FROM scmdata.t_capacity_appointment_detail
       WHERE ptc_id = v_ptcid
         AND DAY = v_day
         AND company_id = v_compid;
    ELSIF v_ptcid IS NULL
          AND v_ctddid IS NOT NULL THEN
      SELECT MAX(supplier_code), MAX(factory_code)
        INTO v_supcode, v_faccode
        FROM scmdata.t_supplier_capacity_detail a
       INNER JOIN scmdata.t_capacity_appointment_detail b
          ON a.ptc_id = b.ptc_id
         AND a.company_id = b.company_id
       WHERE b.ctdd_id = v_ctddid
         AND b.company_id = v_compid;
    
      v_tmpctddid := v_ctddid;
    END IF;
  
    IF v_faccode IS NOT NULL THEN
      v_restcapcrate := f_get_restcapcrate_view(v_ctddid  => v_tmpctddid,
                                                v_supcode => v_supcode,
                                                v_faccode => v_faccode,
                                                v_day     => v_day,
                                                v_compid  => v_compid);
    END IF;
  
    RETURN v_restcapcrate;
  END f_get_restcapcrate_by_ptcidorctddid;

  /*===================================================================================
  
    供应商生产周期配置唯一性校验
  
    用途:
      供应商生产周期配置唯一性校验
  
    入参:
      v_cate      :  分类
      v_procate   :  生产分类
      v_subcate   :  子类
      v_supcodes  :  供应商编码
      v_compid    :  企业id
  
  
    版本:
      2022-04-08 : 用于生成供应商产能预约数据
  
  ===================================================================================*/
  PROCEDURE p_check_prodcyccfg_unq
  (
    v_cate     IN VARCHAR2,
    v_procate  IN VARCHAR2,
    v_subcate  IN VARCHAR2,
    v_supcodes IN VARCHAR2,
    v_pccid    IN VARCHAR2 DEFAULT NULL,
    v_compid   IN VARCHAR2
  ) IS
    v_cksupcodes     CLOB;
    v_jugnum         NUMBER(8);
    v_cpsstr         VARCHAR2(256);
    v_repcodes       VARCHAR2(4000);
    v_repsupcompname CLOB;
  BEGIN
    IF v_cate IS NULL
       OR v_procate IS NULL
       OR v_subcate IS NULL THEN
      raise_application_error(-20002, '分类-生产分类-子类不能为空！');
    END IF;
  
    IF v_pccid IS NULL THEN
      SELECT listagg(supplier_codes, ';'), COUNT(1)
        INTO v_cksupcodes, v_jugnum
        FROM (SELECT nvl(tab2.category, tab1.category) category,
                     nvl(tab2.product_cate, tab1.product_cate) product_cate,
                     nvl(tab2.subcategory, tab1.subcategory) subcategory,
                     nvl(nvl(tab2.supplier_codes, tab1.supplier_codes), ' ') supplier_codes,
                     nvl(tab2.company_id, tab1.company_id) company_id
                FROM scmdata.t_product_cycle_cfg tab1
                LEFT JOIN scmdata.t_product_cycle_cfg_view tab2
                  ON tab1.pcc_id = tab2.pcc_id
                 AND tab1.company_id = tab2.company_id
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_product_cycle_cfg_view
                       WHERE pcc_id = tab1.pcc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT category,
                     product_cate,
                     subcategory,
                     nvl(supplier_codes, ' '),
                     company_id
                FROM scmdata.t_product_cycle_cfg_view tab3
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_product_cycle_cfg
                       WHERE pcc_id = tab3.pcc_id
                         AND company_id = tab3.company_id)) a
       WHERE a.category = v_cate
         AND a.product_cate = v_procate
         AND a.subcategory = v_subcate
         AND a.company_id = v_compid;
    ELSE
      SELECT listagg(supplier_codes, ';'), COUNT(1)
        INTO v_cksupcodes, v_jugnum
        FROM (SELECT nvl(tab2.category, tab1.category) category,
                     nvl(tab2.product_cate, tab1.product_cate) product_cate,
                     nvl(tab2.subcategory, tab1.subcategory) subcategory,
                     nvl(nvl(tab2.supplier_codes, tab1.supplier_codes), ' ') supplier_codes,
                     nvl(tab2.company_id, tab1.company_id) company_id
                FROM scmdata.t_product_cycle_cfg tab1
                LEFT JOIN scmdata.t_product_cycle_cfg_view tab2
                  ON tab1.pcc_id = tab2.pcc_id
                 AND tab1.company_id = tab2.company_id
               WHERE tab1.pcc_id <> v_pccid
                 AND NOT EXISTS (SELECT 1
                        FROM scmdata.t_product_cycle_cfg_view
                       WHERE pcc_id = tab1.pcc_id
                         AND company_id = tab1.company_id
                         AND operate_method = 'DEL')
              UNION ALL
              SELECT category,
                     product_cate,
                     subcategory,
                     nvl(supplier_codes, ' '),
                     company_id
                FROM scmdata.t_product_cycle_cfg_view tab3
               WHERE tab3.pcc_id <> v_pccid
                 AND operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_product_cycle_cfg
                       WHERE pcc_id = tab3.pcc_id
                         AND company_id = tab3.company_id)) a
       WHERE a.category = v_cate
         AND a.product_cate = v_procate
         AND a.subcategory = v_subcate
         AND a.company_id = v_compid;
    END IF;
  
    IF v_jugnum > 0
       AND instr(v_cksupcodes, ' ') > 0
       AND v_supcodes IS NULL THEN
      v_cpsstr := scmdata.pkg_capacity_management.f_get_cps_name(v_cate     => v_cate,
                                                                 v_prodcate => v_procate,
                                                                 v_subcate  => v_subcate,
                                                                 v_compid   => v_compid);
      raise_application_error(-20002,
                              '已存在' || v_cpsstr || '-供应商为空配置，请检查！');
    ELSIF v_jugnum > 0 THEN
      SELECT listagg(a.col, ';')
        INTO v_repcodes
        FROM (SELECT regexp_substr(v_supcodes, '[^;]+', 1, LEVEL) col
                FROM dual
              CONNECT BY LEVEL <= regexp_count(v_supcodes, '\;') + 1) a
        LEFT JOIN (SELECT regexp_substr(v_cksupcodes, '[^;]+', 1, LEVEL) col
                     FROM dual
                   CONNECT BY LEVEL <= regexp_count(v_cksupcodes, '\;') + 1) b
          ON to_char(a.col) = to_char(b.col)
       WHERE b.col IS NOT NULL;
    
      IF v_repcodes IS NOT NULL THEN
        SELECT listagg(supplier_company_name, ';')
          INTO v_repsupcompname
          FROM scmdata.t_supplier_info
         WHERE instr(v_repcodes, supplier_code) > 0
           AND company_id = v_compid;
      
        v_cpsstr := scmdata.pkg_capacity_management.f_get_cps_name(v_cate     => v_cate,
                                                                   v_prodcate => v_procate,
                                                                   v_subcate  => v_subcate,
                                                                   v_compid   => v_compid);
        raise_application_error(-20002,
                                '已存在' || v_cpsstr || '-' ||
                                v_repsupcompname || '配置，请检查！');
      END IF;
    END IF;
  END p_check_prodcyccfg_unq;

  /*===================================================================================
  
    标准工时配置唯一性校验
  
    用途:
      标准工时配置唯一性校验
  
    入参:
      v_cate      :  分类
      v_procate   :  生产分类
      v_subcate   :  子类
      v_compid    :  企业id
  
    版本:
      2022-04-08 : 标准工时配置唯一性校验
  
  ===================================================================================*/
  PROCEDURE p_check_stdwkmincfg_wvunq
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_swmcid  IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
    v_cpsstr VARCHAR2(512);
  BEGIN
    IF v_cate IS NULL
       OR v_procate IS NULL
       OR v_subcate IS NULL THEN
      raise_application_error(-20002, '分类-生产分类-子类必填！');
    END IF;
  
    IF v_swmcid IS NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT swmc_id,
                     company_id,
                     category,
                     product_cate,
                     subcategory
                FROM scmdata.t_standard_work_minte_cfg tab1
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_standard_work_minte_cfg_view
                       WHERE swmc_id = tab1.swmc_id
                         AND operate_method = 'DEL'
                         AND company_id = tab1.company_id)
              UNION ALL
              SELECT swmc_id,
                     company_id,
                     category,
                     product_cate,
                     subcategory
                FROM scmdata.t_standard_work_minte_cfg_view tab2
               WHERE operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_standard_work_minte_cfg
                       WHERE swmc_id = tab2.swmc_id
                         AND company_id = tab2.company_id)) t
       WHERE t.category = v_cate
         AND t.product_cate = v_procate
         AND t.subcategory = v_subcate
         AND t.company_id = v_compid
         AND rownum = 1;
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT swmc_id,
                     company_id,
                     category,
                     product_cate,
                     subcategory
                FROM scmdata.t_standard_work_minte_cfg tab3
               WHERE swmc_id <> v_swmcid
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_standard_work_minte_cfg_view
                       WHERE swmc_id = tab3.swmc_id
                         AND operate_method = 'DEL'
                         AND company_id = tab3.company_id)
              UNION ALL
              SELECT swmc_id,
                     company_id,
                     category,
                     product_cate,
                     subcategory
                FROM scmdata.t_standard_work_minte_cfg_view tab4
               WHERE swmc_id <> v_swmcid
                 AND operate_method <> 'DEL'
                 AND NOT EXISTS
               (SELECT 1
                        FROM scmdata.t_standard_work_minte_cfg
                       WHERE swmc_id = tab4.swmc_id
                         AND company_id = tab4.company_id)) t
       WHERE t.category = v_cate
         AND t.product_cate = v_procate
         AND t.subcategory = v_subcate
         AND t.company_id = v_compid
         AND rownum = 1;
    END IF;
  
    IF v_jugnum = 1 THEN
      v_cpsstr := scmdata.pkg_capacity_management.f_get_cps_name(v_cate     => v_cate,
                                                                 v_prodcate => v_procate,
                                                                 v_subcate  => v_subcate,
                                                                 v_compid   => v_compid);
    
      raise_application_error(-20002, v_cpsstr || '已配置标准工时!');
    END IF;
  END p_check_stdwkmincfg_wvunq;

  /*===================================================================================
  
    产能规划品类配置唯一性校验
  
    用途:
      产能规划品类配置唯一性校验
  
    入参:
      v_cate      :  分类
      v_procate   :  生产分类
      v_subcate   :  子类
      v_compid    :  企业id
  
    版本:
      2022-04-08 : 产能规划品类配置唯一性校验
  
  ===================================================================================*/
  PROCEDURE p_check_capccps_wvunq
  (
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_cpccid  IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
    v_cpsstr VARCHAR2(128);
  BEGIN
    IF v_cate IS NULL
       OR v_procate IS NULL
       OR v_subcate IS NULL THEN
      raise_application_error(-20002, '分类-生产分类-子类必填！');
    ELSE
      IF v_cpccid IS NULL THEN
        SELECT COUNT(1)
          INTO v_jugnum
          FROM (SELECT cpcc_id,
                       company_id,
                       category,
                       product_cate,
                       subcategory
                  FROM scmdata.t_capacity_plan_category_cfg tab1
                 WHERE NOT EXISTS
                 (SELECT 1
                          FROM scmdata.t_capaplan_cate_cfg_view
                         WHERE cpcc_id = tab1.cpcc_id
                           AND operate_method = 'DEL'
                           AND company_id = tab1.company_id)
                UNION ALL
                SELECT cpcc_id,
                       company_id,
                       category,
                       product_cate,
                       subcategory
                  FROM scmdata.t_capaplan_cate_cfg_view tab2
                 WHERE operate_method <> 'DEL'
                   AND NOT EXISTS
                 (SELECT 1
                          FROM scmdata.t_capacity_plan_category_cfg
                         WHERE cpcc_id = tab2.cpcc_id
                           AND company_id = tab2.company_id))
         WHERE category = v_cate
           AND product_cate = v_procate
           AND subcategory = v_subcate
           AND company_id = v_compid
           AND rownum = 1;
      ELSE
        SELECT COUNT(1)
          INTO v_jugnum
          FROM (SELECT cpcc_id,
                       company_id,
                       category,
                       product_cate,
                       subcategory
                  FROM scmdata.t_capacity_plan_category_cfg tab1
                 WHERE cpcc_id <> v_cpccid
                   AND NOT EXISTS
                 (SELECT 1
                          FROM scmdata.t_capaplan_cate_cfg_view
                         WHERE cpcc_id = tab1.cpcc_id
                           AND operate_method = 'DEL'
                           AND company_id = tab1.company_id)
                UNION ALL
                SELECT cpcc_id,
                       company_id,
                       category,
                       product_cate,
                       subcategory
                  FROM scmdata.t_capaplan_cate_cfg_view tab2
                 WHERE cpcc_id <> v_cpccid
                   AND operate_method <> 'DEL'
                   AND NOT EXISTS
                 (SELECT 1
                          FROM scmdata.t_capacity_plan_category_cfg
                         WHERE cpcc_id = tab2.cpcc_id
                           AND company_id = tab2.company_id))
         WHERE category = v_cate
           AND product_cate = v_procate
           AND subcategory = v_subcate
           AND company_id = v_compid
           AND rownum = 1;
      END IF;
    
      IF v_jugnum > 0 THEN
        v_cpsstr := scmdata.pkg_capacity_management.f_get_cps_name(v_cate     => v_cate,
                                                                   v_prodcate => v_procate,
                                                                   v_subcate  => v_subcate,
                                                                   v_compid   => v_compid);
        raise_application_error(-20002, v_cpsstr || '已配置，请检查！');
      END IF;
    END IF;
  END p_check_capccps_wvunq;

  /*=======================================================================
  
    预计新品校验
  
    入参:
      v_supcode   :  供应商编码
      v_cate      :  分类id
      v_procate   :  生产分类id
      v_suubcate  :  子类id
      v_year      :  年份，字符
      v_season    :  季节id
      v_ware      :  波段
      v_orddate   :  预计下单日期，日期
      v_deldate   :  预计交期，日期
      v_pnid      :  预计新品表id
      v_compid    :  企业id
  
    版本:
      2022-04-08 : 用于生成品类合作供应商数据
  
  =======================================================================*/
  PROCEDURE p_pln_checklogic
  (
    v_supcode IN VARCHAR2,
    v_cate    IN VARCHAR2,
    v_procate IN VARCHAR2,
    v_subcate IN VARCHAR2,
    v_season  IN VARCHAR2,
    v_ware    IN NUMBER,
    v_orddate IN DATE,
    v_deldate IN DATE,
    v_pnid    IN VARCHAR2 DEFAULT NULL,
    v_compid  IN VARCHAR2
  ) IS
    v_jugnum NUMBER(1);
  BEGIN
    IF v_supcode IS NULL
       OR v_cate IS NULL
       OR v_procate IS NULL
       OR v_subcate IS NULL
       OR v_season IS NULL THEN
      raise_application_error(-20002,
                              '分类-生产类别-产品子类-季节、供应商 不允许为空');
    END IF;
  
    IF v_pnid IS NULL THEN
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.category, tab1.category) category,
                     nvl(tab2.product_cate, tab1.product_cate) product_cate,
                     nvl(tab2.subcategory, tab1.subcategory) subcategory,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.season, tab1.season) season,
                     nvl(tab2.ware, tab1.ware) ware,
                     nvl(tab2.supplier_code, tab1.supplier_code) supplier_code,
                     nvl(tab2.company_id, tab1.company_id) company_id
                FROM scmdata.t_plan_newproduct tab1
                LEFT JOIN scmdata.t_plan_newproduct_view tab2
                  ON tab1.pn_id = tab2.pn_id
                 AND tab1.company_id = tab2.company_id
              UNION ALL
              SELECT category,
                     product_cate,
                     subcategory,
                     YEAR,
                     season,
                     ware,
                     supplier_code,
                     company_id
                FROM scmdata.t_plan_newproduct_view tab3
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_plan_newproduct
                       WHERE pn_id = tab3.pn_id
                         AND company_id = tab3.company_id))
       WHERE category = v_cate
         AND product_cate = v_procate
         AND subcategory = v_subcate
         AND season = v_season
         AND ware = v_ware
         AND supplier_code = v_supcode
         AND company_id = v_compid
         AND rownum = 1;
    ELSE
      SELECT COUNT(1)
        INTO v_jugnum
        FROM (SELECT nvl(tab2.pn_id, tab1.pn_id) pn_id,
                     nvl(tab2.category, tab1.category) category,
                     nvl(tab2.product_cate, tab1.product_cate) product_cate,
                     nvl(tab2.subcategory, tab1.subcategory) subcategory,
                     nvl(tab2.year, tab1.year) YEAR,
                     nvl(tab2.season, tab1.season) season,
                     nvl(tab2.ware, tab1.ware) ware,
                     nvl(tab2.supplier_code, tab1.supplier_code) supplier_code,
                     nvl(tab2.company_id, tab1.company_id) company_id
                FROM scmdata.t_plan_newproduct tab1
                LEFT JOIN scmdata.t_plan_newproduct_view tab2
                  ON tab1.pn_id = tab2.pn_id
                 AND tab1.company_id = tab2.company_id
              UNION ALL
              SELECT pn_id,
                     category,
                     product_cate,
                     subcategory,
                     YEAR,
                     season,
                     ware,
                     supplier_code,
                     company_id
                FROM scmdata.t_plan_newproduct_view tab3
               WHERE NOT EXISTS (SELECT 1
                        FROM scmdata.t_plan_newproduct
                       WHERE pn_id = tab3.pn_id
                         AND company_id = tab3.company_id))
       WHERE category = v_cate
         AND product_cate = v_procate
         AND subcategory = v_subcate
         AND season = v_season
         AND ware = v_ware
         AND supplier_code = v_supcode
         AND pn_id <> v_pnid
         AND company_id = v_compid
         AND rownum = 1;
    END IF;
  
    IF v_jugnum > 0 THEN
      raise_application_error(-20002,
                              '分部+季节+波段+生产类别+品类+供应商需唯一');
    END IF;
  
    IF trunc(v_deldate) <= trunc(v_orddate)
       AND v_orddate IS NOT NULL
       AND v_deldate IS NOT NULL THEN
      raise_application_error(-20002,
                              '预计订单交期：【' ||
                              to_char(v_deldate, 'YYYY-MM-DD') ||
                              '】必须大于 预计下单日期:【' ||
                              to_char(v_orddate, 'YYYY-MM-DD') || '】');
    END IF;
  
    IF trunc(v_orddate) <= trunc(SYSDATE)
       AND v_orddate IS NOT NULL THEN
      raise_application_error(-20002,
                              '预计下单日期：【' ||
                              to_char(v_orddate, 'YYYY-MM-DD') ||
                              '】必须大于当前系统时间');
    END IF;
  END p_pln_checklogic;

END pkg_capacity_withview_management;
/

