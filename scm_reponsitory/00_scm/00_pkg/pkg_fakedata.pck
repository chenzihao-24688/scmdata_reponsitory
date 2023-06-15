CREATE OR REPLACE PACKAGE SCMDATA.pkg_fakedata IS

  /*=======================================================================

    获取虚拟订单号处理类型

    版本:
      2022-09-01 : 获取虚拟订单号处理类型

  =======================================================================*/
  FUNCTION f_get_ot RETURN VARCHAR2;

  /*=======================================================================

    获取虚拟订单号

    入参:
      v_pre_str      :  前缀
      v_order_type   :  订单类型
      v_create_time  :  创建时间
      v_company_id   :  企业Id

    版本:
      2022-09-01 : 获取虚拟订单号
      2023-05-12 : 新增订单类型,创建时间字段入参，生成逻辑修改

  =======================================================================*/
  FUNCTION f_get_fakeorderid
  (
    v_pre_str     IN VARCHAR2,
    v_order_type  IN VARCHAR2 DEFAULT NULL,
    v_create_time IN VARCHAR2 DEFAULT NULL,
    v_company_id  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*=======================================================================

    获取订单类型

    入参:
      V_COMPID   :  企业Id

    版本:
      2022-09-01 : 获取订单类型

  =======================================================================*/
  FUNCTION f_get_ordertype RETURN VARCHAR2;

  /*=======================================================================

    获取发单人

    入参:
      V_COMPID   :  企业Id

    版本:
      2022-09-01 : 获取发单人

  =======================================================================*/
  FUNCTION f_get_sendorder(v_compid IN VARCHAR2) RETURN VARCHAR2;

  /*=======================================================================

    获取跟单员

    入参:
      V_SUPCODE  :  供应商编码
      V_GOOID    :  货号
      V_COMPID   :  企业Id

    版本:
      2022-09-01 : 获取跟单员

  =======================================================================*/
  FUNCTION f_get_dealfollower
  (
    v_supcode IN VARCHAR2,
    v_gooid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2;

  /*=======================================================================

    虚拟订单数据自动填充

    入参:
      V_STR_PRESTR           :  前缀
      V_STR_COMPID           :  企业Id
      V_STR_SUPCODE          :  供应商编码
      V_STR_FACCODE          :  生产工厂编码
      V_STR_RELAGOOID        :  货号
      V_STR_CREDATE          :  创建日期 格式-YYYYMMMDD 例如-20220801
      V_NUM_DELDINCLOW       :  交期创建低位值
      V_NUM_DELDINCHIGH      :  交期创建高位值
      V_NUM_AMTLOW           :  数量创建低位值
      V_NUM_AMTHIGH          :  数量创建高位值

    出参:
      V_PRESTR            :  前缀
      V_COMPID            :  企业Id
      V_SUPCODE           :  供应商编码
      V_FACCODE           :  生产工厂编码
      V_GOOID             :  货号
      V_CREDATE           :  创建日期
      V_DELDINCLOW        :  交期创建低位值
      V_DELDINCHIGH       :  交期创建高位值
      V_AMTLOW            :  数量创建低位值
      V_AMTHIGH           :  数量创建高位值

    版本:
      2022-09-01 : 虚拟订单数据自动填充

  =======================================================================*/
  PROCEDURE p_visualord_inputdatafill
  (
    v_str_prestr      IN VARCHAR2,
    v_str_compid      IN VARCHAR2,
    v_str_orderstatus IN VARCHAR2,
    v_str_supcode     IN VARCHAR2,
    v_str_faccode     IN VARCHAR2,
    v_str_gooid       IN VARCHAR2,
    v_str_credate     IN VARCHAR2,
    v_num_deldinclow  IN NUMBER,
    v_num_deldinchigh IN NUMBER,
    v_num_amtlow      IN NUMBER,
    v_num_amthigh     IN NUMBER,
    v_prestr          IN OUT VARCHAR2,
    v_orderstatus     IN OUT VARCHAR2,
    v_compid          IN OUT VARCHAR2,
    v_supcode         IN OUT VARCHAR2,
    v_faccode         IN OUT VARCHAR2,
    v_gooid           IN OUT VARCHAR2,
    v_credate         IN OUT VARCHAR2,
    v_deldinclow      IN OUT NUMBER,
    v_deldinchigh     IN OUT NUMBER,
    v_amtlow          IN OUT NUMBER,
    v_amthigh         IN OUT NUMBER
  );

  /*=======================================================================

    生成虚拟订单数据

    入参:
      V_STR_PRESTR           :  前缀 与生产类似，限制3个字符
      V_STR_COMPID           :  企业ID
      V_STR_SUPCODE          :  供应商编码
      V_STR_FACCODE          :  生产工厂编码
      V_STR_GOOID            :  货号
      V_STR_CREDATE          :  创建日期 格式-YYYYMMMDD 例如-20220801
      V_NUM_DELDINCLOW       :  交期创建低位值
      V_NUM_DELDINCHIGH      :  交期创建高位值
      V_NUM_AMTLOW           :  数量创建低位值
      V_NUM_AMTHIGH          :  数量创建高位值
      v_ordid                :  订单号

    版本:
      2022-09-01 : 生成虚拟订单数据

  =======================================================================*/
  PROCEDURE p_gen_visualorddata
  (
    v_str_prestr      IN VARCHAR2,
    v_str_compid      IN VARCHAR2,
    v_str_orderstatus IN VARCHAR2,
    v_str_supcode     IN VARCHAR2 DEFAULT NULL,
    v_str_faccode     IN VARCHAR2 DEFAULT NULL,
    v_str_gooid       IN VARCHAR2 DEFAULT NULL,
    v_str_credate     IN VARCHAR2 DEFAULT NULL,
    v_num_deldinclow  IN NUMBER DEFAULT NULL,
    v_num_deldinchigh IN NUMBER DEFAULT NULL,
    v_num_amtlow      IN NUMBER DEFAULT NULL,
    v_num_amthigh     IN NUMBER DEFAULT NULL,
    v_ordid           IN OUT VARCHAR2
  );

END pkg_fakedata;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.pkg_fakedata IS

  /*=======================================================================

    获取虚拟订单号处理类型

    版本:
      2022-09-01 : 获取虚拟订单号处理类型

  =======================================================================*/
  FUNCTION f_get_ot RETURN VARCHAR2 IS
    v_num   NUMBER(1);
    v_rtstr VARCHAR2(2);
  BEGIN
    SELECT to_number(to_char(systimestamp(1), 'FF')) INTO v_num FROM dual;

    IF v_num = 1 THEN
      v_rtstr := 'XN';
    ELSIF v_num = 2 THEN
      v_rtstr := 'XC';
    ELSIF v_num = 2 THEN
      v_rtstr := 'XS';
    ELSIF v_num = 4 THEN
      v_rtstr := 'XP';
    ELSE
      v_rtstr := 'XW';
    END IF;

    RETURN v_rtstr;
  END f_get_ot;

  /*=======================================================================

    获取虚拟订单号

    入参:
      v_pre_str      :  前缀
      v_order_type   :  订单类型
      v_create_time  :  创建时间
      v_company_id   :  企业Id

    版本:
      2022-09-01 : 获取虚拟订单号
      2023-05-12 : 新增订单类型,创建时间字段入参，生成逻辑修改

  =======================================================================*/
  FUNCTION f_get_fakeorderid
  (
    v_pre_str     IN VARCHAR2,
    v_order_type  IN VARCHAR2 DEFAULT NULL,
    v_create_time IN VARCHAR2 DEFAULT NULL,
    v_company_id  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_order_type_gen VARCHAR2(2);
    v_time           DATE;
    v_seqno          NUMBER(1);
  BEGIN
    IF v_order_type IS NOT NULL THEN
      v_order_type_gen := v_order_type;
    ELSE
      v_order_type_gen := f_get_ot;
    END IF;

    IF v_create_time IS NOT NULL THEN
      v_time := to_date(v_create_time, 'YYYYMMDD');
    ELSE
      v_time := SYSDATE;
    END IF;

    SELECT MAX(to_number(substr(ord.order_code, 12, 4)))
      INTO v_seqno
      FROM scmdata.t_ordered ord
     WHERE substr(ord.order_code, 4, 8) =
           v_order_type_gen || to_char(v_time, 'YYMMDD')
       AND company_id = v_company_id;

    IF v_seqno IS NULL THEN
      v_seqno := 0;
    END IF;

    RETURN v_pre_str || v_order_type_gen || to_char(v_time, 'YYMMDD') || lpad(to_char(v_seqno + 1),
                                                                              4,
                                                                              '0');
  END f_get_fakeorderid;

  /*=======================================================================

    获取订单类型

    入参:
      V_COMPID   :  企业ID

    版本:
      2022-09-01 : 获取订单类型

  =======================================================================*/
  FUNCTION f_get_ordertype RETURN VARCHAR2 IS
    v_num   NUMBER(1);
    v_rtstr VARCHAR2(2);
  BEGIN
    SELECT to_number(to_char(systimestamp(1), 'FF')) INTO v_num FROM dual;

    IF v_num = 1 THEN
      v_rtstr := 'PP';
    ELSIF v_num = 2 THEN
      v_rtstr := 'NP';
    ELSIF v_num = 2 THEN
      v_rtstr := 'WP';
    ELSIF v_num = 4 THEN
      v_rtstr := 'CP';
    ELSE
      v_rtstr := 'SP';
    END IF;

    RETURN v_rtstr;
  END f_get_ordertype;

  /*=======================================================================

    获取发单人

    入参:
      V_COMPID   :  企业ID

    版本:
      2022-09-01 : 获取发单人

  =======================================================================*/
  FUNCTION f_get_sendorder(v_compid IN VARCHAR2) RETURN VARCHAR2 IS
    v_sendorder VARCHAR2(32);
  BEGIN
    SELECT MAX(user_id)
      INTO v_sendorder
      FROM scmdata.sys_company_user
     WHERE pause = 0
       AND company_id = v_compid;

    IF v_sendorder IS NULL THEN
      raise_application_error(-20002, '当前企业没有员工！');
    END IF;

    RETURN v_sendorder;
  END f_get_sendorder;

  /*=======================================================================

    获取跟单员

    入参:
      V_SUPCODE  :  供应商编码
      V_GOOID    :  货号
      V_COMPID   :  企业ID

    版本:
      2022-09-01 : 获取跟单员

  =======================================================================*/
  FUNCTION f_get_dealfollower
  (
    v_supcode IN VARCHAR2,
    v_gooid   IN VARCHAR2,
    v_compid  IN VARCHAR2
  ) RETURN VARCHAR2 IS
    v_dealfollower VARCHAR2(4000);
    v_cate         VARCHAR2(2);
  BEGIN
    SELECT MAX(category)
      INTO v_cate
      FROM scmdata.t_commodity_info
     WHERE goo_id = v_gooid
       AND company_id = v_compid;

    SELECT MAX(gendan_perid)
      INTO v_dealfollower
      FROM scmdata.t_supplier_info
     WHERE supplier_code = v_supcode
       AND company_id = v_compid;

    SELECT listagg(a.user_id, ';')
      INTO v_dealfollower
      FROM scmdata.sys_company_user a
     INNER JOIN scmdata.sys_company_user_cate_map b
        ON a.user_id = b.user_id
       AND a.company_id = b.company_id
       AND b.pause = 0
     WHERE instr(v_dealfollower, a.user_id) > 0
       AND b.cooperation_classification = v_cate
       AND a.company_id = v_compid;

    IF v_dealfollower IS NULL THEN
      SELECT MAX(user_id)
        INTO v_dealfollower
        FROM scmdata.sys_company_user
       WHERE pause = 0
         AND company_id = v_compid;
    END IF;

    IF v_dealfollower IS NULL THEN
      raise_application_error(-20002, '该公司中不存在员工！');
    END IF;

    RETURN v_dealfollower;
  END f_get_dealfollower;

  /*=======================================================================

    虚拟订单数据自动填充

    入参:
      V_STR_PRESTR           :  前缀
      V_STR_COMPID           :  企业ID
      V_STR_SUPCODE          :  供应商编码
      V_STR_FACCODE          :  生产工厂编码
      V_STR_RELAGOOID        :  货号
      V_STR_CREDATE          :  创建日期 格式-YYYYMMMDD 例如-20220801
      V_NUM_DELDINCLOW       :  交期创建低位值
      V_NUM_DELDINCHIGH      :  交期创建高位值
      V_NUM_AMTLOW           :  数量创建低位值
      V_NUM_AMTHIGH          :  数量创建高位值

    出参:
      V_PRESTR            :  前缀
      V_COMPID            :  企业ID
      V_SUPCODE           :  供应商编码
      V_FACCODE           :  生产工厂编码
      V_GOOID             :  货号
      V_CREDATE           :  创建日期
      V_DELDINCLOW        :  交期创建低位值
      V_DELDINCHIGH       :  交期创建高位值
      V_AMTLOW            :  数量创建低位值
      V_AMTHIGH           :  数量创建高位值

    版本:
      2022-09-01 : 虚拟订单数据自动填充

  =======================================================================*/
  PROCEDURE p_visualord_inputdatafill
  (
    v_str_prestr      IN VARCHAR2,
    v_str_compid      IN VARCHAR2,
    v_str_orderstatus IN VARCHAR2,
    v_str_supcode     IN VARCHAR2,
    v_str_faccode     IN VARCHAR2,
    v_str_gooid       IN VARCHAR2,
    v_str_credate     IN VARCHAR2,
    v_num_deldinclow  IN NUMBER,
    v_num_deldinchigh IN NUMBER,
    v_num_amtlow      IN NUMBER,
    v_num_amthigh     IN NUMBER,
    v_prestr          IN OUT VARCHAR2,
    v_orderstatus     IN OUT VARCHAR2,
    v_compid          IN OUT VARCHAR2,
    v_supcode         IN OUT VARCHAR2,
    v_faccode         IN OUT VARCHAR2,
    v_gooid           IN OUT VARCHAR2,
    v_credate         IN OUT VARCHAR2,
    v_deldinclow      IN OUT NUMBER,
    v_deldinchigh     IN OUT NUMBER,
    v_amtlow          IN OUT NUMBER,
    v_amthigh         IN OUT NUMBER
  ) IS

  BEGIN
    IF v_str_prestr IS NULL THEN
      v_prestr := 'GZZ';
    ELSE
      IF length(v_str_prestr) > 3 THEN
        raise_application_error(-20002, '前缀不能大于3个字符');
      END IF;
    END IF;

    IF v_str_compid IS NULL THEN
      v_compid := 'a972dd1ffe3b3a10e0533c281cac8fd7';
    ELSE
      v_compid := v_str_compid;
    END IF;

    IF v_str_orderstatus IS NULL THEN
      v_orderstatus := 'OS01';
    ELSE
      IF v_str_orderstatus NOT IN ('OS00', 'OS01', 'OS02') THEN
        raise_application_error(-20002, '订单无此状态！');
      ELSE
        v_orderstatus := v_str_orderstatus;
      END IF;
    END IF;

    IF v_str_supcode IS NULL THEN
      SELECT MAX(supplier_code)
        INTO v_supcode
        FROM scmdata.t_supplier_info
       WHERE pause IN (0, 2)
         AND company_id = v_compid;
    ELSE
      SELECT MAX(supplier_code)
        INTO v_supcode
        FROM scmdata.t_supplier_info
       WHERE supplier_code = v_str_supcode
         AND pause IN (0, 2)
         AND company_id = v_compid;

      IF v_supcode IS NULL THEN
        SELECT MAX(supplier_code)
          INTO v_supcode
          FROM scmdata.t_supplier_info
         WHERE pause IN (0, 2)
           AND company_id = v_compid;
      END IF;
    END IF;

    IF v_supcode IS NULL THEN
      raise_application_error(-20002,
                              '当前公司不存在供应商/供应商状态为停用！');
    END IF;

    IF v_str_faccode IS NULL THEN
      v_faccode := v_supcode;
    ELSE
      SELECT MAX(supplier_code)
        INTO v_faccode
        FROM scmdata.t_supplier_info
       WHERE supplier_code = v_str_faccode
         AND pause IN (0, 2)
         AND company_id = v_compid;

      IF v_str_faccode IS NULL THEN
        v_faccode := v_supcode;
      END IF;
    END IF;

    IF v_str_gooid IS NULL THEN
      SELECT MAX(goo_id)
        INTO v_gooid
        FROM scmdata.t_commodity_info
       WHERE pause IN (0, 2)
         AND company_id = v_compid;
    ELSE
      SELECT MAX(goo_id)
        INTO v_gooid
        FROM scmdata.t_commodity_info
       WHERE goo_id = v_str_gooid
         AND pause IN (0, 2)
         AND company_id = v_compid;

      IF v_gooid IS NULL THEN
        SELECT MAX(goo_id)
          INTO v_gooid
          FROM scmdata.t_commodity_info
         WHERE pause IN (0, 2)
           AND company_id = v_compid;
      END IF;
    END IF;

    IF v_gooid IS NULL THEN
      raise_application_error(-20002,
                              '当前公司不存在货号/货号状态为停用！');
    END IF;

    IF v_str_credate IS NULL THEN
      v_credate := to_char(SYSDATE, 'YYYYMMDD');
    ELSE
      v_credate := v_str_credate;
    END IF;

    IF v_num_deldinclow IS NULL THEN
      v_deldinclow := 1;
    ELSE
      v_deldinclow := v_num_deldinclow;
    END IF;

    IF v_num_deldinchigh IS NULL THEN
      v_deldinchigh := 50;
    ELSE
      v_deldinchigh := v_num_deldinchigh;
    END IF;

    IF v_num_amtlow IS NULL THEN
      v_amtlow := 1;
    ELSE
      v_amtlow := v_num_amtlow;
    END IF;

    IF v_num_amthigh IS NULL THEN
      v_amthigh := 50;
    ELSE
      v_amthigh := v_num_amthigh;
    END IF;
  END p_visualord_inputdatafill;

  /*=======================================================================

    生成虚拟订单数据

    入参:
      V_STR_PRESTR           :  前缀 与生产类似，限制3个字符
      V_STR_COMPID           :  企业ID
      V_STR_SUPCODE          :  供应商编码
      V_STR_FACCODE          :  生产工厂编码
      V_STR_GOOID            :  货号
      V_STR_CREDATE          :  创建日期 格式-YYYYMMMDD 例如-20220801
      V_NUM_DELDINCLOW       :  交期创建低位值
      V_NUM_DELDINCHIGH      :  交期创建高位值
      V_NUM_AMTLOW           :  数量创建低位值
      V_NUM_AMTHIGH          :  数量创建高位值
      v_ordid                :  订单号

    版本:
      2022-09-01 : 生成虚拟订单数据

  =======================================================================*/
  PROCEDURE p_gen_visualorddata
  (
    v_str_prestr      IN VARCHAR2,
    v_str_compid      IN VARCHAR2,
    v_str_orderstatus IN VARCHAR2,
    v_str_supcode     IN VARCHAR2 DEFAULT NULL,
    v_str_faccode     IN VARCHAR2 DEFAULT NULL,
    v_str_gooid       IN VARCHAR2 DEFAULT NULL,
    v_str_credate     IN VARCHAR2 DEFAULT NULL,
    v_num_deldinclow  IN NUMBER DEFAULT NULL,
    v_num_deldinchigh IN NUMBER DEFAULT NULL,
    v_num_amtlow      IN NUMBER DEFAULT NULL,
    v_num_amthigh     IN NUMBER DEFAULT NULL,
    v_ordid           IN OUT VARCHAR2
  ) IS
    v_prestr       VARCHAR2(3);
    v_compid       VARCHAR2(32);
    v_orderstatus  VARCHAR2(4);
    v_supcode      VARCHAR2(32);
    v_faccode      VARCHAR2(32);
    v_gooid        VARCHAR2(32);
    v_credate      VARCHAR2(32);
    v_deldinclow   NUMBER(8);
    v_deldinchigh  NUMBER(8);
    v_amtlow       NUMBER(8);
    v_amthigh      NUMBER(8);
    v_dealfollower VARCHAR2(512);
    v_sendorder    VARCHAR2(32);
    v_ordertype    VARCHAR2(4);
    v_orddeldate   DATE;
    v_ordamountsum NUMBER(8);
    po_header_rec  scmdata.t_ordered%ROWTYPE;
    drhead         scmdata.t_delivery_record%ROWTYPE;
  BEGIN
    v_ordid := NULL;

    p_visualord_inputdatafill(v_str_prestr      => v_str_prestr,
                              v_str_compid      => v_str_compid,
                              v_str_orderstatus => v_str_orderstatus,
                              v_str_supcode     => v_str_supcode,
                              v_str_faccode     => v_str_faccode,
                              v_str_gooid       => v_str_gooid,
                              v_str_credate     => v_str_credate,
                              v_num_deldinclow  => v_num_deldinclow,
                              v_num_deldinchigh => v_num_deldinchigh,
                              v_num_amtlow      => v_num_amtlow,
                              v_num_amthigh     => v_num_amthigh,
                              v_prestr          => v_prestr,
                              v_compid          => v_compid,
                              v_orderstatus     => v_orderstatus,
                              v_supcode         => v_supcode,
                              v_faccode         => v_faccode,
                              v_gooid           => v_gooid,
                              v_credate         => v_credate,
                              v_deldinclow      => v_deldinclow,
                              v_deldinchigh     => v_deldinchigh,
                              v_amtlow          => v_amtlow,
                              v_amthigh         => v_amthigh);

    v_ordid := f_get_fakeorderid(v_pre_str     => v_str_prestr,
                                 v_create_time => v_str_credate,
                                 v_company_id  => v_str_compid);

    v_dealfollower := f_get_dealfollower(v_supcode => v_supcode,
                                         v_gooid   => v_gooid,
                                         v_compid  => v_compid);

    v_ordertype := f_get_ordertype;

    v_sendorder := f_get_sendorder(v_compid => v_compid);

    v_orddeldate := to_date(v_credate, 'YYYYMMDD') +
                    trunc(dbms_random.value(v_deldinclow, v_deldinchigh));

    INSERT INTO scmdata.t_ordered
      (order_id, company_id, order_code, order_status, order_type, delivery_date, supplier_code, send_order, create_id, send_order_date, create_time, origin, deal_follower, is_product_order, sho_id)
    VALUES
      (scmdata.f_get_uuid(), v_compid, v_ordid, v_orderstatus, v_ordertype, v_orddeldate, v_supcode, v_sendorder, 'ADMIN', to_date(v_credate,
                'YYYYMMDD'), to_date(v_credate, 'YYYYMMDD'), 'FAKEINFO', v_dealfollower, 1, v_str_prestr);

    INSERT INTO scmdata.t_orders
      (orders_id, company_id, orders_code, order_id, goo_id, order_amount, got_amount, order_price, delivery_date, memo, factory_code)
    VALUES
      (scmdata.f_get_uuid(), v_compid, ' ', v_ordid, v_gooid, 0, 0, trunc(dbms_random.value(10,
                                30)), v_orddeldate, ' ', v_faccode);

    FOR o IN (SELECT barcode
                FROM scmdata.t_commodity_color_size ccs
               WHERE EXISTS (SELECT 1
                        FROM scmdata.t_commodity_info
                       WHERE goo_id = v_gooid
                         AND company_id = v_compid
                         AND commodity_info_id = ccs.commodity_info_id
                         AND company_id = ccs.company_id)) LOOP
      INSERT INTO scmdata.t_ordersitem
        (ordersitem_id, company_id, ordersitem_code, order_id, goo_id, barcode, order_amount, got_amount, memo)
      VALUES
        (scmdata.f_get_uuid(), v_compid, ' ', v_ordid, v_gooid, o.barcode, trunc(dbms_random.value(v_amtlow,
                                  v_amthigh)), 0, ' ');
    END LOOP;

    --v_ordamountsum
    SELECT nvl(SUM(order_amount), trunc(dbms_random.value(10, 80)))
      INTO v_ordamountsum
      FROM scmdata.t_ordersitem
     WHERE order_id = v_ordid
       AND goo_id = v_gooid
       AND company_id = v_compid;

    UPDATE scmdata.t_orders ords
       SET order_amount = v_ordamountsum
     WHERE order_id = v_ordid
       AND goo_id = v_gooid
       AND company_id = v_compid;

    SELECT *
      INTO po_header_rec
      FROM scmdata.t_ordered
     WHERE order_code = v_ordid
       AND company_id = v_compid;

    scmdata.pkg_production_progress.sync_production_progress(po_header_rec => po_header_rec);

    INSERT INTO scmdata.t_delivery_record
      (delivery_record_id, asn_id, company_id, delivery_record_code, order_code, goo_id, create_id, create_time, delivery_date, accept_date, sorting_date, predict_delivery_amount, delivery_origin_time, delivery_origin_amount, delivery_amount)
    VALUES
      (scmdata.f_get_uuid(), scmdata.f_get_uuid(), v_compid, scmdata.f_get_uuid(), v_ordid, v_gooid, 'ADMIN', to_date(v_credate,
                'YYYYMMDD'), v_orddeldate, v_orddeldate, v_orddeldate, v_ordamountsum, v_orddeldate, v_ordamountsum, v_ordamountsum);

    SELECT *
      INTO drhead
      FROM scmdata.t_delivery_record
     WHERE order_code = v_ordid
       AND company_id = v_compid;

    scmdata.pkg_production_progress.sync_delivery_record(drhead);

    scmdata.pkg_a_qcqa.p_create_goo_collect(p_goo_id        => v_gooid,
                                            p_supplier_code => v_supcode,
                                            p_company_id    => v_compid,
                                            p_order_code    => v_ordid);
  END p_gen_visualorddata;

END pkg_fakedata;
/

