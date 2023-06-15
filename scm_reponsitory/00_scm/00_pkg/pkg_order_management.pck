CREATE OR REPLACE PACKAGE SCMDATA.pkg_order_management IS

  /*======================================================================
  
    获取 ordqcrelationship 关键参数值
  
    用于:
      scmdata.t_ordqc_relationship 增改
  
    入参:
      v_ordid   :  订单号
      v_compid  :  企业id
  
    入出参:
      v_isneedck    :  是否查货
      v_isrepex     :  是否存在报告
      v_noderepids  :  报告ids
      v_gooid       :  商品档案编号
      v_cate        :  分类id
      v_procate     :  生产分类id
      v_subcate     :  产品子类id
      v_supcode     :  供应商编码
      v_faccode     :  生产工厂编码
  
    版本:
      2022-09-14 : 获取 ordqcrelationship 关键参数值
  
  ======================================================================*/
  PROCEDURE p_get_ordqcrelationship_params
  (
    v_ordid      IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_isneedck   IN OUT NUMBER,
    v_isrepex    IN OUT NUMBER,
    v_noderepids IN OUT VARCHAR2,
    v_gooid      IN OUT VARCHAR2,
    v_cate       IN OUT VARCHAR2,
    v_procate    IN OUT VARCHAR2,
    v_subcate    IN OUT VARCHAR2,
    v_supcode    IN OUT VARCHAR2,
    v_faccode    IN OUT VARCHAR2
  );

  /*======================================================================
  
    新增订单qc关联关系表数据
  
    用于:
      接口订单创建时
  
    入参:
      v_ordid   :  订单号
      v_compid  :  企业id
  
    版本:
      2022-09-14 : 创建订单时新增订单qc关联关系表数据
  
  ======================================================================*/
  PROCEDURE p_ordqcrela_iu_data
  (
    v_ordid  IN VARCHAR2,
    v_compid IN VARCHAR2
  );

  /*======================================================================
  
    根据订单更新订单区域组和区域组长字段
  
    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业id
  
    版本:
      2022-11-30 : 根据订单更新订单区域组和区域组长字段
  
  ======================================================================*/
  PROCEDURE p_upd_ordareagroupandgroupleader
  (
    v_inp_ordid  IN VARCHAR2,
    v_inp_compid IN VARCHAR2
  );

  /*======================================================================
  
    获取【订单管理-未完成订单】页面sql
  
    入参:
      v_iscompadmin  :  当前用户是否是当前公司管理员
      v_pirvstr      :  权限字符串
      v_isprodorder  :  是否生产订单
      v_ordstatus    :  订单状态
      v_compid       :  企业id
  
    版本:
      2022-09-24 : 获取【订单管理-未完成订单】页面sql
  
  ======================================================================*/
  FUNCTION f_get_unfinishedorder_selsql
  (
    v_iscompadmin IN VARCHAR2,
    v_pirvstr     IN VARCHAR2,
    v_isprodorder IN VARCHAR2 DEFAULT NULL,
    v_ordstatus   IN VARCHAR2,
    v_compid      IN VARCHAR2
  ) RETURN CLOB;

  /*======================================================================
  
    订单结束-更新ordered-qc关联信息
  
    入参:
      v_inp_ordid  :  订单Id
      v_compid     :  企业Id
  
    版本:
      2023-01-12 : 订单结束-更新ordered-qc关联信息
  
  ======================================================================*/
  PROCEDURE p_ordqcrelainfo_record
  (
    v_inp_ordid  IN VARCHAR2,
    v_inp_compid IN VARCHAR2
  );

  /*======================================================================
  
    更新订单头表 Qc，Qc组长，需要质检字段
  
    入参:
      v_inp_order_id    :  订单Id
      v_inp_company_id  :  企业Id
  
    版本:
      2023-05-05 : 更新订单头表 Qc，Qc组长，需要质检字段
  
  ======================================================================*/
  PROCEDURE p_upd_ordered_qc_qcleader_needcheck
  (
    v_inp_order_id   IN VARCHAR2,
    v_inp_company_id IN VARCHAR2
  );

  /*======================================================================
  
    获取【订单管理-未完成订单】页面sql优化
  
    入参:
      v_iscompadmin  :  当前用户是否是当前公司管理员
      v_pirvstr      :  权限字符串
      v_isprodorder  :  是否生产订单
      v_ordstatus    :  订单状态
      v_compid       :  企业id
  
    版本:
      2022-09-24 : 获取【订单管理-未完成订单】页面sql优化
  
  ======================================================================*/
  FUNCTION f_get_unfinishedorder_selsql_optimize
  (
    v_iscompadmin IN VARCHAR2,
    v_pirvstr     IN VARCHAR2,
    v_isprodorder IN VARCHAR2 DEFAULT NULL,
    v_ordstatus   IN VARCHAR2,
    v_compid      IN VARCHAR2
  ) RETURN CLOB;

END pkg_order_management;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_order_management IS

  /*======================================================================
  
    获取 ordqcrelationship 关键参数值
  
    用于:
      scmdata.t_ordqc_relationship 增改
  
    入参:
      v_ordid   :  订单号
      v_compid  :  企业id
  
    入出参:
      v_isneedck    :  是否查货
      v_isrepex     :  是否存在报告
      v_noderepids  :  报告ids
      v_gooid       :  商品档案编号
      v_cate        :  分类id
      v_procate     :  生产分类id
      v_subcate     :  产品子类id
      v_supcode     :  供应商编码
      v_faccode     :  生产工厂编码
  
    版本:
      2022-09-14 : 获取 ordqcrelationship 关键参数值
  
  ======================================================================*/
  PROCEDURE p_get_ordqcrelationship_params
  (
    v_ordid      IN VARCHAR2,
    v_compid     IN VARCHAR2,
    v_isneedck   IN OUT NUMBER,
    v_isrepex    IN OUT NUMBER,
    v_noderepids IN OUT VARCHAR2,
    v_gooid      IN OUT VARCHAR2,
    v_cate       IN OUT VARCHAR2,
    v_procate    IN OUT VARCHAR2,
    v_subcate    IN OUT VARCHAR2,
    v_supcode    IN OUT VARCHAR2,
    v_faccode    IN OUT VARCHAR2
  ) IS
    v_node VARCHAR2(32);
  BEGIN
    SELECT MAX(ords.goo_id),
           MAX(orded.supplier_code),
           MAX(ords.factory_code)
      INTO v_gooid,
           v_supcode,
           v_faccode
      FROM scmdata.t_ordered orded
     INNER JOIN scmdata.t_orders ords
        ON orded.order_code = ords.order_id
       AND orded.company_id = ords.company_id
     WHERE orded.order_code = v_ordid
       AND orded.company_id = v_compid;
  
    SELECT MAX(goo.category),
           MAX(goo.product_cate),
           MAX(goo.samll_category),
           decode(nvl(MAX(qccfg.pause), 1), 0, 1, 0)
      INTO v_cate,
           v_procate,
           v_subcate,
           v_isneedck
      FROM scmdata.t_commodity_info goo
      LEFT JOIN scmdata.t_qc_config qccfg
        ON goo.category = qccfg.industry_classification
       AND goo.product_cate = qccfg.production_category
       AND instr(qccfg.product_subclass, goo.samll_category) > 0
       AND goo.company_id = qccfg.company_id
     WHERE goo.goo_id = v_gooid
       AND goo.company_id = v_compid;
  
    IF v_isneedck > 0 THEN
      SELECT MAX(qc_check_node)
        INTO v_node
        FROM (SELECT qcc.qc_check_node
                FROM scmdata.t_qc_check qcc
               INNER JOIN scmdata.t_qc_check_rela_order qcro
                  ON qcc.qc_check_id = qcro.qc_check_id
               INNER JOIN scmdata.t_orders ords
                  ON qcro.orders_id = ords.orders_id
               INNER JOIN scmdata.sys_group_dict dic
                  ON qcc.qc_check_node = dic.group_dict_value
                 AND dic.group_dict_type = 'QC_CHECK_NODE_DICT'
               WHERE qcc.goo_id = v_gooid
                 AND ords.order_id = v_ordid
                 AND qcc.company_id = v_compid
               ORDER BY to_number(dic.group_dict_sort) DESC
               FETCH FIRST 1 rows ONLY);
    
      IF v_node IS NOT NULL THEN
        v_isrepex := 1;
      
        SELECT listagg(tqcc.qc_check_id, ';')
          INTO v_noderepids
          FROM scmdata.t_qc_check tqcc
         INNER JOIN scmdata.t_qc_check_rela_order tqcro
            ON tqcc.qc_check_id = tqcro.qc_check_id
         WHERE tqcc.goo_id = v_gooid
           AND tqcc.qc_check_node = v_node
           AND tqcc.company_id = v_compid
           AND EXISTS (SELECT 1
                  FROM scmdata.t_orders
                 WHERE order_id = v_ordid
                   AND company_id = tqcc.company_id
                   AND orders_id = tqcro.orders_id);
      END IF;
    END IF;
  END p_get_ordqcrelationship_params;

  /*======================================================================
  
    新增订单qc关联关系表数据
  
    用于:
      接口订单创建时
  
    入参:
      v_ordid   :  订单号
      v_compid  :  企业id
  
    版本:
      2022-09-14 : 创建订单时新增订单qc关联关系表数据
  
  ======================================================================*/
  PROCEDURE p_ordqcrela_iu_data
  (
    v_ordid  IN VARCHAR2,
    v_compid IN VARCHAR2
  ) IS
    v_jugnum     NUMBER(1);
    v_isneedck   NUMBER(1);
    v_isrepex    NUMBER(1) := 0;
    v_noderepids VARCHAR2(1024) := NULL;
    v_gooid      VARCHAR2(32);
    v_cate       VARCHAR2(2);
    v_procate    VARCHAR2(4);
    v_subcate    VARCHAR2(8);
    v_supcode    VARCHAR2(32);
    v_faccode    VARCHAR2(32);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_jugnum
      FROM scmdata.t_ordqc_relationship
     WHERE order_id = v_ordid
       AND company_id = v_compid
       AND rownum = 1;
  
    p_get_ordqcrelationship_params(v_ordid      => v_ordid,
                                   v_compid     => v_compid,
                                   v_isneedck   => v_isneedck,
                                   v_isrepex    => v_isrepex,
                                   v_noderepids => v_noderepids,
                                   v_gooid      => v_gooid,
                                   v_cate       => v_cate,
                                   v_procate    => v_procate,
                                   v_subcate    => v_subcate,
                                   v_supcode    => v_supcode,
                                   v_faccode    => v_faccode);
  
    IF v_gooid IS NOT NULL
       AND v_cate IS NOT NULL
       AND v_procate IS NOT NULL THEN
      IF v_jugnum = 0 THEN
        INSERT INTO scmdata.t_ordqc_relationship
          (ordqcrela_id, company_id, order_id, goo_id, category, product_cate, subcategory, supplier_code, factory_code, is_needck, is_repex, noderep_ids)
        VALUES
          (scmdata.f_get_uuid(), v_compid, v_ordid, v_gooid, v_cate, v_procate, v_subcate, v_supcode, v_faccode, v_isneedck, v_isrepex, v_noderepids);
      ELSE
        UPDATE scmdata.t_ordqc_relationship
           SET goo_id        = v_gooid,
               category      = v_cate,
               product_cate  = v_procate,
               subcategory   = v_subcate,
               supplier_code = v_supcode,
               factory_code  = v_faccode,
               is_needck     = v_isneedck,
               is_repex      = v_isrepex,
               noderep_ids   = v_noderepids
         WHERE order_id = v_ordid
           AND company_id = v_compid;
      END IF;
    END IF;
  END p_ordqcrela_iu_data;

  /*======================================================================
  
    根据订单更新订单区域组和区域组长字段
  
    入参:
      v_inp_ordid   :  订单号
      v_inp_compid  :  企业id
  
    版本:
      2022-11-30 : 根据订单更新订单区域组和区域组长字段
  
  ======================================================================*/
  PROCEDURE p_upd_ordareagroupandgroupleader
  (
    v_inp_ordid  IN VARCHAR2,
    v_inp_compid IN VARCHAR2
  ) IS
    v_groupid       VARCHAR2(32);
    v_groupleaderid VARCHAR2(32);
  BEGIN
    SELECT MAX(supgroupcfg.group_config_id),
           MAX(supgroupcfg.area_group_leader)
      INTO v_groupid,
           v_groupleaderid
      FROM scmdata.t_supplier_info tmpsup
      LEFT JOIN scmdata.t_supplier_group_config supgroupcfg
        ON tmpsup.group_name = supgroupcfg.group_config_id
       AND tmpsup.company_id = supgroupcfg.company_id
       AND supgroupcfg.pause = 1
     WHERE nvl(tmpsup.inside_supplier_code, ' ') NOT IN ('30928', '73036')
       AND EXISTS (SELECT 1
              FROM scmdata.t_orders
             WHERE order_id = v_inp_ordid
               AND company_id = v_inp_compid
               AND factory_code = tmpsup.supplier_code
               AND company_id = tmpsup.company_id);
  
    UPDATE scmdata.t_ordered
       SET area_group_id       = v_groupid,
           area_group_leaderid = v_groupleaderid
     WHERE order_code = v_inp_ordid
       AND company_id = v_inp_compid;
  END p_upd_ordareagroupandgroupleader;

  /*======================================================================
  
    获取【订单管理-未完成订单】页面sql
  
    入参:
      v_iscompadmin  :  当前用户是否是当前公司管理员
      v_pirvstr      :  权限字符串
      v_isprodorder  :  是否生产订单
      v_ordstatus    :  订单状态
      v_compid       :  企业id
  
    版本:
      2022-09-24 : 获取【订单管理-未完成订单】页面sql
  
  ======================================================================*/
  FUNCTION f_get_unfinishedorder_selsql
  (
    v_iscompadmin IN VARCHAR2,
    v_pirvstr     IN VARCHAR2,
    v_isprodorder IN VARCHAR2 DEFAULT NULL,
    v_ordstatus   IN VARCHAR2,
    v_compid      IN VARCHAR2
  ) RETURN CLOB IS
    v_datapriv VARCHAR2(32) := scmdata.pkg_data_privs.parse_json(p_jsonstr => v_pirvstr,
                                                                 p_key     => 'COL_2');
    v_exesql   CLOB;
    v_cond     VARCHAR2(1024);
  BEGIN
    IF v_ordstatus IS NOT NULL THEN
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'orded.order_status in (' ||
                                                             v_ordstatus || ')',
                                             v_middliestr => ' and ');
    END IF;
  
    IF v_isprodorder IS NOT NULL THEN
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'orded.is_product_order = ' ||
                                                             v_isprodorder,
                                             v_middliestr => ' and ');
    END IF;
  
    IF v_iscompadmin = '0' THEN
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'instr(''' ||
                                                             v_datapriv ||
                                                             ''', goo.category) > 0 ',
                                             v_middliestr => ' and ');
    END IF;
  
    IF v_compid IS NOT NULL THEN
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'orded.company_id = ''' ||
                                                             v_compid || '''',
                                             v_middliestr => ' and ');
    END IF;
  
    v_exesql := 'WITH dic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict),
cu AS
 (SELECT user_id, company_id, company_user_name
    FROM scmdata.sys_company_user)
SELECT info.order_id,
       info.order_code,
       info.company_id,
       dic1.group_dict_name order_status_desc,
       info.supplier,
       info.rela_goo_id,
       info.style_number,
       info.product_factory,
       info.deal_follower,
       info.isneedqccheck,
       decode(info.isneedqccheck, ''否'', NULL, cu4.company_user_name) qc_name,
       decode(info.isneedqccheck, ''否'', NULL, cu5.company_user_name) qc_leader_name,
       info.delivery_date,
       info.delivery_date latest_delivery_date,
       info.order_amount,
       info.memo,
       dic2.group_dict_name order_type,
       info.style_name,
       info.goo_name,
       dic7.province || dic8.city || dic9.county location,
       dic10.vill villname_00000,
       info.group_name,
       cu8.company_user_name area_group_leader,
       dic3.group_dict_name category,
       dic4.group_dict_name product_cate,
       dic5.company_dict_name samll_category,
       dic6.group_dict_name season_00000,
       cu2.company_user_name send_order,
       info.send_by_sup,
       info.rationame rationame_00000,
       info.is_qc_required,
       info.send_order_date,
       info.finish_time_scm,
       info.goo_id,
       cu3.company_user_name update_id,
       info.update_time
  FROM (SELECT orded.order_id,
               orded.order_code,
               orded.company_id,
               orded.order_status,
               supinfo.supplier_company_name supplier,
               goo.rela_goo_id,
               goo.style_number,
               fac.supplier_company_name product_factory,
               (SELECT listagg(DISTINCT company_user_name, '';'')
                  FROM cu
                 WHERE INSTR(orded.deal_follower, user_id) > 0
                   AND company_id = orded.company_id) deal_follower,
               CASE
                 WHEN qccfg.qc_config_id IS NOT NULL AND
                      ordqcr.noderep_ids IS NULL THEN
                  decode(qccfg.qc_config_id, NULL, ''否'', ''是'')
                 WHEN qccfg.qc_config_id IS NOT NULL AND
                      ordqcr.noderep_ids IS NOT NULL THEN
                  decode(ordqcr.noderep_ids, NULL, ''否'', ''是'')
                 ELSE
                  ''否''
               END isneedqccheck,
               decode(ordqcr.noderep_ids,
                      NULL,
                      tqfch.qc_user_id,
                      tqc.finish_qc_id) qc,
               decode(ordqcr.noderep_ids,
                      NULL,
                      tqfch.qc_manage,
                      qcgcfg.qc_group_leader) qc_leader,
               orded.delivery_date,
               ords.delivery_date latest_delivery_date,
               ords.order_amount,
               orded.is_product_order,
               orded.memo,
               orded.order_type,
               goo.style_name,
               goo.goo_name,
               fac.company_province,
               fac.company_city,
               fac.company_county,
               fac.company_vill,
               supgroupcfg.group_name,
               supgroupcfg.area_group_leader,
               goo.category,
               goo.product_cate,
               goo.samll_category,
               goo.season,
               orded.send_order,
               orded.send_by_sup,
               orded.rationame,
               ords.is_qc_required,
               orded.send_order_date,
               orded.finish_time_scm,
               supinfo.cooperation_type,
               goo.goo_id,
               orded.update_id,
               orded.update_time
          FROM scmdata.t_ordered orded
         INNER JOIN scmdata.t_orders ords
            ON orded.order_code = ords.order_id
           AND orded.company_id = ords.company_id
         INNER JOIN scmdata.t_commodity_info goo
            ON ords.goo_id = goo.goo_id
           AND ords.company_id = goo.company_id
          LEFT JOIN scmdata.t_supplier_info supinfo
            ON orded.supplier_code = supinfo.supplier_code
           AND orded.company_id = supinfo.company_id
          LEFT JOIN scmdata.t_ordqc_relationship ordqcr
            ON orded.order_code = ordqcr.order_id
           AND orded.company_id = ordqcr.company_id
          LEFT JOIN scmdata.t_qc_config qccfg
            ON instr(qccfg.product_subclass, ordqcr.subcategory) > 0
           AND qccfg.production_category = ordqcr.product_cate
           AND qccfg.industry_classification = ordqcr.category
           AND qccfg.pause = 0
           AND qccfg.company_id = ordqcr.company_id
          LEFT JOIN scmdata.t_qc_factory_config_head tqfch
            ON ordqcr.factory_code = tqfch.factory_code
           AND instr(tqfch.industry_classification, ordqcr.category) > 0
           AND ordqcr.company_id = tqfch.company_id
          LEFT JOIN scmdata.t_qc_check tqc
            ON instr(ordqcr.noderep_ids, tqc.qc_check_id) > 0
           AND ordqcr.company_id = tqc.company_id
          LEFT JOIN scmdata.sys_company_user_dept scud
            ON tqc.finish_qc_id = scud.user_id
           AND tqc.company_id = scud.company_id
          LEFT JOIN scmdata.t_qc_group_config qcgcfg
            ON scud.company_dept_id = qcgcfg.qc_group_dept_id
           AND scud.company_id = qcgcfg.company_id
          LEFT JOIN scmdata.t_supplier_info fac
            ON ords.factory_code = fac.supplier_code
           AND ords.company_id = fac.company_id
           AND nvl(fac.inside_supplier_code, '' '') NOT IN (''30928'', ''73036'')
          LEFT JOIN scmdata.t_supplier_group_config supgroupcfg
            ON fac.group_name = supgroupcfg.group_config_id
           AND fac.company_id = supgroupcfg.company_id
         WHERE ' || v_cond ||
                ' ) info
  LEFT JOIN cu cu2
    ON info.send_order = cu2.user_id
   AND info.company_id = cu2.company_id
  LEFT JOIN cu cu3
    ON info.update_id = cu3.user_id
   AND info.company_id = cu3.company_id
  LEFT JOIN cu cu4
    ON info.qc = cu4.user_id
   AND info.company_id = cu4.company_id
  LEFT JOIN cu cu5
    ON info.qc_leader = cu5.user_id
   AND info.company_id = cu5.company_id
  LEFT JOIN cu cu8
    ON info.area_group_leader = cu8.user_id
   AND info.company_id = cu8.company_id
  LEFT JOIN dic dic1
    ON dic1.group_dict_type = ''ORDER_STATUS''
   AND dic1.group_dict_value = info.order_status
  LEFT JOIN dic dic2
    ON dic2.group_dict_type = ''ORDER_TYPE''
   AND dic2.group_dict_value = info.order_type
  LEFT JOIN dic dic3
    ON dic3.group_dict_type = info.cooperation_type
   AND dic3.group_dict_value = info.category
  LEFT JOIN dic dic4
    ON dic4.group_dict_type = info.category
   AND dic4.group_dict_value = info.product_cate
  LEFT JOIN scmdata.sys_company_dict dic5
    ON dic5.company_dict_type = info.product_cate
   AND dic5.company_dict_value = info.samll_category
   AND dic5.company_id = info.company_id
  LEFT JOIN dic dic6
    ON dic6.group_dict_type = ''GD_SESON''
   AND dic6.group_dict_value = info.season
  LEFT JOIN scmdata.dic_province dic7
    ON info.company_province = dic7.provinceid
  LEFT JOIN scmdata.dic_city dic8
    ON info.company_city = dic8.cityno
   AND info.company_province = dic8.provinceid
  LEFT JOIN scmdata.dic_county dic9
    ON info.company_county = dic9.countyid
   AND info.company_city = dic9.cityno
  LEFT JOIN scmdata.dic_village dic10
    ON info.company_vill = dic10.villid
   AND info.company_county = dic10.countyid';
  
    RETURN v_exesql;
  END f_get_unfinishedorder_selsql;

  /*======================================================================
  
    订单结束-更新ordered-qc关联信息
  
    入参:
      v_inp_ordid  :  订单Id
      v_compid     :  企业Id
  
    版本:
      2023-01-12 : 订单结束-更新ordered-qc关联信息
  
  ======================================================================*/
  PROCEDURE p_ordqcrelainfo_record
  (
    v_inp_ordid  IN VARCHAR2,
    v_inp_compid IN VARCHAR2
  ) IS
    v_isneedck   NUMBER(1);
    v_isexists   NUMBER(1);
    v_noderepids VARCHAR2(4000);
    v_qcid       VARCHAR2(32);
    v_qcleaderid VARCHAR2(32);
  BEGIN
    SELECT nvl(MAX(1), 0)
      INTO v_isexists
      FROM scmdata.t_ordqc_relationship
     WHERE order_id = v_inp_ordid
       AND company_id = v_inp_compid
       AND rownum = 1;
  
    IF v_isexists = 0 THEN
      scmdata.pkg_order_management.p_ordqcrela_iu_data(v_ordid  => v_inp_ordid,
                                                       v_compid => v_inp_compid);
    END IF;
  
    SELECT MAX(is_needck),
           MAX(noderep_ids)
      INTO v_isneedck,
           v_noderepids
      FROM scmdata.t_ordqc_relationship
     WHERE order_id = v_inp_ordid
       AND company_id = v_inp_compid;
  
    IF v_isneedck > 0
       AND v_noderepids IS NULL THEN
      SELECT MAX(tqfch.qc_user_id),
             MAX(tqfch.qc_manage)
        INTO v_qcid,
             v_qcleaderid
        FROM scmdata.t_ordqc_relationship oqrela1
       INNER JOIN scmdata.t_qc_config qccfg
          ON instr(qccfg.product_subclass, oqrela1.subcategory) > 0
         AND oqrela1.product_cate = qccfg.production_category
         AND oqrela1.category = qccfg.industry_classification
         AND qccfg.pause = 0
         AND oqrela1.company_id = qccfg.company_id
        LEFT JOIN scmdata.t_qc_factory_config_head tqfch
          ON oqrela1.factory_code = tqfch.factory_code
         AND instr(tqfch.industry_classification, oqrela1.category) > 0
         AND oqrela1.company_id = tqfch.company_id;
    ELSIF v_isneedck > 0
          AND v_noderepids IS NOT NULL THEN
      SELECT MAX(tqc.finish_qc_id),
             MAX(qcgcfg.qc_group_leader)
        INTO v_qcid,
             v_qcleaderid
        FROM scmdata.t_ordqc_relationship oqrela2
        LEFT JOIN scmdata.t_qc_check tqc
          ON instr(oqrela2.noderep_ids, tqc.qc_check_id) > 0
         AND oqrela2.company_id = tqc.company_id
        LEFT JOIN scmdata.sys_company_user_dept scud
          ON tqc.finish_qc_id = scud.user_id
         AND tqc.company_id = scud.company_id
        LEFT JOIN scmdata.t_qc_group_config qcgcfg
          ON scud.company_dept_id = qcgcfg.qc_group_dept_id
         AND scud.company_id = qcgcfg.company_id;
    END IF;
  
    UPDATE scmdata.t_ordered
       SET finish_isneedqccheck = v_isneedck,
           finish_qcid          = v_qcid,
           finish_qcleaderid    = v_qcleaderid
     WHERE order_code = v_inp_ordid
       AND company_id = v_inp_compid;
  END p_ordqcrelainfo_record;

  /*======================================================================
  
    更新订单头表 Qc，Qc组长，需要质检字段
  
    入参:
      v_inp_order_id    :  订单Id
      v_inp_company_id  :  企业Id
  
    版本:
      2023-05-06 : 更新订单头表 Qc，Qc组长，需要质检字段
  
  ======================================================================*/
  PROCEDURE p_upd_ordered_qc_qcleader_needcheck
  (
    v_inp_order_id   IN VARCHAR2,
    v_inp_company_id IN VARCHAR2
  ) IS
    v_is_need_check NUMBER(1);
    v_node          VARCHAR2(32);
    v_noderepids    VARCHAR2(4000);
    v_qc_id         VARCHAR2(4000);
    v_qc_leader_id  VARCHAR2(4000);
  BEGIN
    --是否需要质检  
    SELECT decode(nvl(MAX(qccfg.pause), 1), 0, 1, 0)
      INTO v_is_need_check
      FROM scmdata.t_commodity_info goo
     INNER JOIN scmdata.t_qc_config qccfg
        ON goo.category = qccfg.industry_classification
       AND goo.product_cate = qccfg.production_category
       AND instr(qccfg.product_subclass, goo.samll_category) > 0
       AND goo.company_id = qccfg.company_id
     WHERE EXISTS (SELECT 1
              FROM scmdata.t_orders
             WHERE order_id = v_inp_order_id
               AND company_id = v_inp_company_id
               AND goo_id = goo.goo_id
               AND company_id = goo.company_id);
  
    --判断是否需要质检
    IF v_is_need_check > 0 THEN
      SELECT MAX(qc_check_node)
        INTO v_node
        FROM (SELECT qcc.qc_check_node
                FROM scmdata.t_qc_check qcc
               INNER JOIN scmdata.t_qc_check_rela_order qcro
                  ON qcc.qc_check_id = qcro.qc_check_id
               INNER JOIN scmdata.t_orders ords
                  ON qcro.orders_id = ords.orders_id
               INNER JOIN scmdata.sys_group_dict dic
                  ON qcc.qc_check_node = dic.group_dict_value
                 AND dic.group_dict_type = 'QC_CHECK_NODE_DICT'
               WHERE qcc.finish_time IS NOT NULL
                 AND EXISTS (SELECT 1
                        FROM scmdata.t_orders
                       WHERE order_id = v_inp_order_id
                         AND company_id = v_inp_company_id
                         AND goo_id = qcc.goo_id
                         AND company_id = qcc.company_id)
               ORDER BY to_number(dic.group_dict_sort) DESC
               FETCH FIRST 1 rows ONLY);
    
      --节点不为空
      IF v_node IS NOT NULL THEN
        --获取 qc_check_id
        SELECT listagg(tqcc.qc_check_id, ';')
          INTO v_noderepids
          FROM scmdata.t_qc_check tqcc
         INNER JOIN scmdata.t_qc_check_rela_order tqcro
            ON tqcc.qc_check_id = tqcro.qc_check_id
         WHERE tqcc.qc_check_node = v_node
           AND tqcc.finish_time IS NOT NULL
           AND EXISTS (SELECT 1
                  FROM scmdata.t_orders
                 WHERE order_id = v_inp_order_id
                   AND company_id = v_inp_company_id
                   AND goo_id = tqcc.goo_id
                   AND company_id = tqcc.company_id
                   AND orders_id = tqcro.orders_id);
      
        IF v_noderepids IS NOT NULL THEN
          --[qc查货表]直接获取表内数据
          SELECT listagg(DISTINCT tqc.finish_qc_id, ','),
                 listagg(DISTINCT qcgcfg.qc_group_leader, ',')
            INTO v_qc_id,
                 v_qc_leader_id
            FROM scmdata.t_qc_check tqc
            LEFT JOIN scmdata.sys_company_user_dept scud
              ON tqc.finish_qc_id = scud.user_id
             AND tqc.company_id = scud.company_id
            LEFT JOIN scmdata.t_qc_group_config qcgcfg
              ON scud.company_dept_id = qcgcfg.qc_group_dept_id
             AND scud.company_id = qcgcfg.company_id
           WHERE instr(v_noderepids, tqc.qc_check_id) > 0
             AND tqc.finish_time IS NOT NULL
             AND tqc.company_id = v_inp_company_id;
        ELSE
          --[qc配置] 关联 [qc工厂配置头表] 获取 [qc工厂配置头表] 内的数据
          SELECT listagg(DISTINCT tqfch.qc_user_id, ','),
                 listagg(DISTINCT tqfch.qc_manage, ',')
            INTO v_qc_id,
                 v_qc_leader_id
            FROM scmdata.t_orders ords
           INNER JOIN scmdata.t_commodity_info goo
              ON ords.goo_id = goo.goo_id
             AND ords.company_id = goo.company_id
           INNER JOIN scmdata.t_qc_config qccfg
              ON goo.category = qccfg.industry_classification
             AND goo.product_cate = qccfg.production_category
             AND instr(qccfg.product_subclass, goo.samll_category) > 0
             AND qccfg.pause = 0
             AND goo.company_id = qccfg.company_id
           INNER JOIN scmdata.t_qc_factory_config_head tqfch
              ON ords.factory_code = tqfch.factory_code
             AND ords.company_id = tqfch.company_id
           WHERE ords.order_id = v_inp_order_id
             AND ords.company_id = v_inp_company_id;
        END IF;
      
      ELSE
        --[qc配置] 关联 [qc工厂配置头表] 获取 [qc工厂配置头表] 内的数据
        SELECT listagg(DISTINCT tqfch.qc_user_id, ';'),
               listagg(DISTINCT tqfch.qc_manage, ';')
          INTO v_qc_id,
               v_qc_leader_id
          FROM scmdata.t_orders ords
         INNER JOIN scmdata.t_commodity_info goo
            ON ords.goo_id = goo.goo_id
           AND ords.company_id = goo.company_id
         INNER JOIN scmdata.t_qc_config qccfg
            ON goo.category = qccfg.industry_classification
           AND goo.product_cate = qccfg.production_category
           AND instr(qccfg.product_subclass, goo.samll_category) > 0
           AND qccfg.pause = 0
           AND goo.company_id = qccfg.company_id
         INNER JOIN scmdata.t_qc_factory_config_head tqfch
            ON ords.factory_code = tqfch.factory_code
           AND ords.company_id = tqfch.company_id
         WHERE ords.order_id = v_inp_order_id
           AND ords.company_id = v_inp_company_id;
      END IF;
    END IF;
  
    --更新订单头表
    UPDATE scmdata.t_ordered
       SET finish_isneedqccheck = v_is_need_check,
           finish_qcid          = v_qc_id,
           finish_qcleaderid    = v_qc_leader_id
     WHERE order_code = v_inp_order_id
       AND company_id = v_inp_company_id;
  END p_upd_ordered_qc_qcleader_needcheck;

  /*======================================================================
  
    获取【订单管理-未完成订单】页面sql优化
  
    入参:
      v_iscompadmin  :  当前用户是否是当前公司管理员
      v_pirvstr      :  权限字符串
      v_isprodorder  :  是否生产订单
      v_ordstatus    :  订单状态
      v_compid       :  企业id
  
    版本:
      2022-09-24 : 获取【订单管理-未完成订单】页面sql优化
  
  ======================================================================*/
  FUNCTION f_get_unfinishedorder_selsql_optimize
  (
    v_iscompadmin IN VARCHAR2,
    v_pirvstr     IN VARCHAR2,
    v_isprodorder IN VARCHAR2 DEFAULT NULL,
    v_ordstatus   IN VARCHAR2,
    v_compid      IN VARCHAR2
  ) RETURN CLOB IS
    v_datapriv VARCHAR2(32) := scmdata.pkg_data_privs.parse_json(p_jsonstr => v_pirvstr,
                                                                 p_key     => 'COL_2');
    v_exesql   CLOB;
    v_cond     VARCHAR2(1024);
  BEGIN
    IF v_ordstatus IS NOT NULL THEN
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'orded.order_status in (' ||
                                                             v_ordstatus || ')',
                                             v_middliestr => ' and ');
    END IF;
  
    IF v_isprodorder IS NOT NULL THEN
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'orded.is_product_order = ' ||
                                                             v_isprodorder,
                                             v_middliestr => ' and ');
    END IF;
  
    IF v_iscompadmin = '0' THEN
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'instr(''' ||
                                                             v_datapriv ||
                                                             ''', goo.category) > 0 ',
                                             v_middliestr => ' and ');
    END IF;
  
    IF v_compid IS NOT NULL THEN
      v_cond := scmdata.f_sentence_append_rc(v_sentence   => v_cond,
                                             v_appendstr  => 'orded.company_id = ''' ||
                                                             v_compid || '''',
                                             v_middliestr => ' and ');
    END IF;
  
    v_exesql := 'WITH cu AS
 (SELECT user_id, company_id, company_user_name
    FROM scmdata.sys_company_user),
gdic AS
 (SELECT group_dict_value, group_dict_name, group_dict_type
    FROM scmdata.sys_group_dict)
SELECT orded.order_id,
       orded.company_id,
       orded.order_code,
       dic1.group_dict_name order_status,
       supinfo.supplier_company_name supplier,
       goo.rela_goo_id,
       goo.style_number,
       fac.supplier_company_name product_factory,
       orded.deal_follower,
       orded.finish_isneedqccheck isneedqccheck,
       orded.finish_qcid qc,
       orded.finish_qcleaderid qc_leader,
       orded.delivery_date,
       ords.delivery_date latest_delivery_date,
       ords.order_amount,
       orded.memo,
       dic2.group_dict_name order_type,
       goo.style_name,
       goo.goo_name,
       ldic1.province || ldic2.city || ldic3.county location,
       ldic4.vill villname_00000,
       supgroupcfg.group_name,
       cu3.company_user_name area_group_leader,
       dic4.group_dict_name category,
       dic5.group_dict_name product_cate,
       cdic1.company_dict_name samll_category,
       dic3.group_dict_name season,
       cu1.company_user_name send_order,
       orded.send_by_sup,
       orded.rationame rationame_00000,
       orded.send_order_date,
       cu2.company_user_name update_id,
       orded.update_time
  FROM scmdata.t_ordered orded
 INNER JOIN scmdata.t_orders ords
    ON orded.order_code = ords.order_id
   AND orded.company_id = ords.company_id
 INNER JOIN scmdata.t_commodity_info goo
    ON ords.goo_id = goo.goo_id
   AND ords.company_id = goo.company_id
  LEFT JOIN scmdata.t_supplier_info supinfo
    ON orded.supplier_code = supinfo.supplier_code
   AND orded.company_id = supinfo.company_id
  LEFT JOIN scmdata.t_supplier_info fac
    ON ords.factory_code = fac.supplier_code
   AND ords.company_id = fac.company_id
  LEFT JOIN cu cu1
    ON orded.send_order = cu1.user_id
   AND orded.company_id = cu1.company_id
  LEFT JOIN cu cu2
    ON orded.update_id = cu2.user_id
   AND orded.company_id = cu2.company_id
  LEFT JOIN scmdata.t_supplier_group_config supgroupcfg
    ON fac.group_name = supgroupcfg.group_config_id
   AND fac.company_id = supgroupcfg.company_id
  LEFT JOIN cu cu3
    ON supgroupcfg.area_group_leader = cu3.user_id
   AND supgroupcfg.company_id = cu3.company_id
  LEFT JOIN gdic dic1
    ON dic1.group_dict_value = orded.order_status
   AND dic1.group_dict_type = ''ORDER_STATUS''
  LEFT JOIN gdic dic2
    ON dic2.group_dict_value = orded.order_type
   AND dic2.group_dict_type = ''ORDER_TYPE''
  LEFT JOIN gdic dic3
    ON dic3.group_dict_value = goo.season
   AND dic3.group_dict_type = ''GD_SESON''
  LEFT JOIN gdic dic4
    ON dic4.group_dict_value = goo.category
   AND dic4.group_dict_type = supinfo.cooperation_type
  LEFT JOIN gdic dic5
    ON dic5.group_dict_value = goo.product_cate
   AND dic5.group_dict_type = goo.category
  LEFT JOIN scmdata.sys_company_dict cdic1
    ON cdic1.company_dict_value = goo.samll_category
   AND cdic1.company_dict_type = goo.product_cate
   AND cdic1.company_id = goo.company_id
  LEFT JOIN scmdata.dic_province ldic1
    ON fac.company_province = ldic1.provinceid
  LEFT JOIN scmdata.dic_city ldic2
    ON fac.company_city = ldic2.cityno
   AND fac.company_province = ldic2.provinceid
  LEFT JOIN scmdata.dic_county ldic3
    ON fac.company_county = ldic3.countyid
   AND fac.company_city = ldic3.cityno
  LEFT JOIN scmdata.dic_village ldic4
    ON fac.company_vill = ldic4.villid
   AND fac.company_county = ldic4.countyid
 WHERE ' || v_cond;
  
    RETURN v_exesql;
  END f_get_unfinishedorder_selsql_optimize;

END pkg_order_management;
/

