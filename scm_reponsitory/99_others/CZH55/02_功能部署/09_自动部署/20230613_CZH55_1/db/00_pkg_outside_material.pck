CREATE OR REPLACE PACKAGE plm.pkg_outside_material IS

  -- Author  : SANFU
  -- Created : 2022/7/26 11:18:31
  -- Purpose : ODM报价管理--物料信息

  FUNCTION f_get_mrp_keyid(pi_pre     VARCHAR2,
                           pi_owner   VARCHAR2,
                           pi_seqname VARCHAR2,
                           pi_seqnum  NUMBER DEFAULT NULL) RETURN NUMBER;

  FUNCTION f_get_keycode(v_table_name  IN VARCHAR2,
                         v_column_name IN VARCHAR2,
                         v_pre         IN VARCHAR2,
                         v_serail_num  NUMBER) RETURN VARCHAR2;

  FUNCTION f_get_suppinfo_id(v_current_compid IN VARCHAR2,
                             v_need_compid    IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_get_supcom_id(v_supinfo_id  IN VARCHAR2,
                           v_need_compid IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_query_material_detail(p_quotation_id IN VARCHAR2) RETURN CLOB;

  FUNCTION f_get_outsupp_info_pick(v_supp_id IN VARCHAR2) RETURN CLOB;

  --校验物料信息
  PROCEDURE p_check_outmaterial_data(p_osp_data IN mrp.mrp_create_outside_material_sku_temp %ROWTYPE);

  --创建新物料时插入临时表
  PROCEDURE p_ins_outmaterial_temp(v_rec IN mrp.mrp_create_outside_material_sku_temp%ROWTYPE);

  --更新物料临时表
  PROCEDURE p_upd_outmaterial_temp(v_rec IN mrp.mrp_create_outside_material_sku_temp%ROWTYPE);

  --插入图片
  PROCEDURE p_ins_mrp_pic(pi_mrp_pic mrp.mrp_picture%ROWTYPE);

  --更新图片
  PROCEDURE p_upd_mrp_pic(p_mrp_pic_rec mrp.mrp_picture%ROWTYPE);

  --提交物料按钮
  PROCEDURE p_ins_outmaterial_bysubmit(v_tem_id IN VARCHAR2,
                                       v_com_id IN VARCHAR2);

  --查询物料明细
  FUNCTION f_query_upd_materialdata(v_quo_material_id IN VARCHAR2)
    RETURN CLOB;

  --编辑物料
  PROCEDURE p_upd_outmaterial(v_spu_id      IN VARCHAR2,
                              v_sku_id      IN VARCHAR2,
                              v_supp_code   IN VARCHAR2,
                              v_com_id      IN VARCHAR2,
                              v_useid       IN VARCHAR2,
                              v_ma_name     IN VARCHAR2, --物料名称
                              v_color       IN VARCHAR2, --颜色
                              v_color_num   IN VARCHAR2, --色号
                              v_use_door_cm IN NUMBER, --实用门幅
                              v_kezhong     IN NUMBER, --克重
                              v_kongcha     IN NUMBER, --空差
                              v_dahuo_price IN NUMBER, --大货报价
                              v_spcifi      IN VARCHAR2, --规格
                              v_func_tag    IN VARCHAR2, --功能标签
                              v_contact     IN VARCHAR2, --联系人
                              v_phone       IN NUMBER, --联系电话
                              v_address     IN VARCHAR2, --地址
                              v_tezhengtu   IN VARCHAR2,
                              --V_TEZHENGTU_ID  IN VARCHAR2,
                              v_sekatu IN VARCHAR2,
                              --V_SEKATU_ID     IN VARCHAR2,
                              v_yanse IN VARCHAR2 --,
                              --V_YANSE_ID      IN VARCHAR2
                              );

  PROCEDURE p_delete_material_detail(p_comp_id      IN VARCHAR2,
                                     p_user_id      IN VARCHAR2,
                                     p_material_rec plm.material_detail_quotation%ROWTYPE);

  --提交报价单时校验物料明细
  PROCEDURE p_submit_material_detail(v_quoid    IN VARCHAR2,
                                     po_err_msg OUT VARCHAR2);
  --加色报价按钮
  PROCEDURE p_add_color_quotation(v_color  IN VARCHAR2,
                                  v_quo_id IN VARCHAR2,
                                  v_cre_id IN VARCHAR2);

  --获取内外部物料 物料分类、成分、克重 czh add
  PROCEDURE p_get_material_data(p_material_sku      VARCHAR2,
                                p_is_inner_material INT,
                                po_material_class   OUT VARCHAR2,
                                po_ingredients      OUT VARCHAR2,
                                po_gram_weight      OUT VARCHAR2,
                                po_material_spu     OUT VARCHAR2,
                                po_material_sku     OUT VARCHAR2);

  FUNCTION f_get_same_ingredient_prom(p_material_spu VARCHAR2,
                                      --p_sup_ingredient         VARCHAR2,
                                      p_is_inner_material      INT,
                                      p_recommend_material_spu VARCHAR2 /*,
                                                                                                                                                                                                                                    p_recommend_ingredient   VARCHAR2*/)
    RETURN NUMBER;

  --克重匹配度绝对值
  FUNCTION f_get_gram_weight_comparison(p_sup_material       NUMBER,
                                        p_recommend_material NUMBER)
    RETURN NUMBER;
  --新增推荐物料
  PROCEDURE p_insert_recommend_material_result(p_recom_rec mrp.recommend_material_result%ROWTYPE);
  --新增面料部物料明细推荐内部比价信息
  PROCEDURE p_insert_fabric_material_detail_recommend_price_comparison(p_fabric_mdrp_rec mrp.fabric_material_detail_recommend_price_comparison%ROWTYPE);
  --新增面料部物料明细推荐货比三家信息
  PROCEDURE p_insert_fabric_material_detail_recommend_shop_around(p_fabric_mdrsa_rec mrp.fabric_material_detail_recommend_shop_around%ROWTYPE);
  --通过ID清空物料推荐结果数据
  PROCEDURE p_delete_recommend_material_result_by_id(p_examine_price_id                 VARCHAR2,
                                                     p_examine_price_material_detail_id VARCHAR2);
  --内部比价推荐度计算 czh add
  PROCEDURE p_calculate_inner_price_comparison_recommen(p_examine_price_id                 VARCHAR2,
                                                        p_examine_price_material_detail_id VARCHAR2,
                                                        p_material_spu                     VARCHAR2,
                                                        --p_material_sku                     VARCHAR2,
                                                        p_is_inner_material INT,
                                                        p_material_class    VARCHAR2,
                                                        p_ingredients       VARCHAR2,
                                                        p_gram_weight       VARCHAR2);
  --生成核价单物料明细
  PROCEDURE p_cre_material_examine_price(pi_examine_price_id IN VARCHAR2,
                                         pi_user_id          IN VARCHAR2);
  --插入辅料临时表
  PROCEDURE p_ins_accessories_temp(v_rec IN mrp.mrp_create_outside_accessories_temp%ROWTYPE);

  --辅料提交按钮
  PROCEDURE p_ins_assmaterial_bysubmit(v_com_id    IN VARCHAR2,
                                       v_create_id IN VARCHAR2);
END pkg_outside_material;
/
CREATE OR REPLACE PACKAGE BODY plm.pkg_outside_material IS

  FUNCTION f_get_mrp_keyid(pi_pre     VARCHAR2,
                           pi_owner   VARCHAR2,
                           pi_seqname VARCHAR2,
                           pi_seqnum  NUMBER DEFAULT NULL) RETURN NUMBER IS
  
    p_pre               VARCHAR2(20) := upper(pi_pre); --前缀 动态
    p_seqname           VARCHAR2(100) := pi_seqname; --序列名称 动态  seq_plat_code
    p_seqnum            NUMBER := pi_seqnum; --序列位数 0~99 最大值
    v_max_value         NUMBER;
    v_code              NUMBER; --生成编码
    v_date              VARCHAR2(30); --年月日
    v_seconds           NUMBER; --时分秒转换=》秒
    v_current_timestamp VARCHAR2(30); --时间戳获取毫秒
    v_seqno             VARCHAR2(100); --序列
    v_flag              NUMBER;
    --V_NUM               NUMBER;
  BEGIN
    --1.年月日6位
    SELECT to_char(SYSDATE, 'YYYYMMDD') INTO v_date FROM dual;
    --2.时分秒5位
    SELECT to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 0, 2)) * 60 * 60 +
           
           to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 4, 2)) * 60 +
           
           to_number(substr(to_char(SYSDATE, 'HH24:MI:SS'), 7, 2))
      INTO v_seconds
      FROM dual;
    --3.毫秒3位
    SELECT to_char(current_timestamp, 'ff3')
      INTO v_current_timestamp
      FROM dual;
  
    --随机数10位
    --SELECT to_number(SUBSTR(TO_CHAR(DBMS_RANDOM.VALUE(11, 99)), 4, 10)) INTO V_NUM from dual;
  
    --校验序列名称是否为空
    IF p_seqname IS NULL THEN
      raise_application_error(-20002, '请填写序列名称');
    END IF;
    --判断此序列是否存在
    SELECT COUNT(1)
      INTO v_flag
      FROM all_sequences a
     WHERE a.sequence_name = upper(p_seqname)
       AND a.sequence_owner = upper(pi_owner);
    IF v_flag > 0 THEN
      --4.存在序列
      EXECUTE IMMEDIATE 'SELECT ' || pi_owner || '.' || p_seqname ||
                        '.nextval FROM dual'
        INTO v_seqno;
    ELSE
      --不存在序列
      --校验序列最大值是否为空
      IF p_seqnum IS NULL THEN
        raise_application_error(-20002, '请填写序列最大值');
      END IF;
    
      EXECUTE IMMEDIATE 'create sequence' || pi_owner || '.' || p_seqname ||
                        ' minvalue 0 maxvalue ' || p_seqnum ||
                        ' start with 0 increment by 1 cache 2 cycle';
    
      EXECUTE IMMEDIATE 'SELECT ' || pi_owner || '.' || p_seqname ||
                        '.nextval FROM dual'
        INTO v_seqno;
    END IF;
    --获取序列最大值位数
    SELECT length(a.max_value)
      INTO v_max_value
      FROM all_sequences a
     WHERE a.sequence_name = upper(p_seqname)
       AND a.sequence_owner = upper(pi_owner);
  
    v_seqno := lpad(v_seqno, v_max_value, '0');
  
    --生成编号
    SELECT to_number(p_pre || v_date || v_seconds || v_current_timestamp /*||V_NUM*/
                     || v_seqno)
      INTO v_code
      FROM dual;
  
    RETURN v_code;
  END f_get_mrp_keyid;

  FUNCTION f_get_keycode(v_table_name  IN VARCHAR2,
                         v_column_name IN VARCHAR2,
                         v_pre         IN VARCHAR2,
                         v_serail_num  NUMBER) RETURN VARCHAR2 IS
  
    p_length INT;
    p_id     NUMBER(38);
    p_sql    VARCHAR2(4000);
    p_result VARCHAR2(50);
  BEGIN
    SELECT MAX(decode(data_type, 'NUMBER', data_precision, data_length))
      INTO p_length
      FROM all_tab_columns
     WHERE table_name = upper(v_table_name)
       AND column_name = upper(v_column_name);
  
    --dbms_output.put_line(p_length);
  
    p_sql := 'SELECT nvl(MAX(v.tcode), 0)
  FROM (SELECT DISTINCT MAX(to_number(substr(' || v_column_name || ',
                                             nvl(length(''' ||
             v_pre ||
             '''), 0) + 1,
                                             length(''' ||
             v_column_name || ''')))) over(PARTITION BY substr(' ||
             v_column_name || ', 0, nvl(length(''' || v_pre ||
             '''), 0))) tcode
          FROM ' || v_table_name || '
         WHERE ' || v_column_name || ' IS NOT NULL
           AND substr(' || v_column_name ||
             ', 0, nvl(length(''' || v_pre || '''), 0)) = ''' || v_pre || '''
           AND regexp_like(substr(' || v_column_name || ',
                                  nvl(length(''' || v_pre ||
             '''), 0) + 1,
                                  length(''' || v_column_name ||
             ''')),' || '''^[0-9]+[0-9]$''' || ')) v';
  
    --dbms_output.put_line(p_sql);
  
    EXECUTE IMMEDIATE p_sql
      INTO p_id;
  
    IF (length(v_pre) + length(lpad(to_char(p_id + 1), v_serail_num, '0'))) >
       p_length THEN
      dbms_output.put_line('超出字段長度');
      raise_application_error(-20002, SQLERRM);
    END IF;
  
    p_result := v_pre || lpad(to_char(p_id + 1), v_serail_num, '0');
  
    /*dbms_output.put_line(V_PRE ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
    RETURN p_result;
    /*dbms_output.put_line(V_PRE ||
    lpad(to_char(p_id + 1), pi_serail_num, '0'));*/
  
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_output.put_line(p_sql);
      raise_application_error(-20002, SQLERRM);
      RETURN NULL;
  END f_get_keycode;

  FUNCTION f_get_suppinfo_id(v_current_compid IN VARCHAR2,
                             v_need_compid    IN VARCHAR2) RETURN VARCHAR2 IS
    v_suppid VARCHAR2(32);
  BEGIN
    EXECUTE IMMEDIATE '
 SELECT a.SUPPLIER_INFO_ID
   FROM scmdata.t_supplier_info a WHERE a.supplier_company_id =''' ||
                      v_current_compid || '''
   and a.company_id = ''' || v_need_compid || ''''
      INTO v_suppid;
  
    RETURN v_suppid;
  END f_get_suppinfo_id;

  --根据供应商档案id获取企业id
  FUNCTION f_get_supcom_id(v_supinfo_id  IN VARCHAR2,
                           v_need_compid IN VARCHAR2) RETURN VARCHAR2 IS
    v_suppid VARCHAR2(32);
  BEGIN
    EXECUTE IMMEDIATE 'SELECT A.SUPPLIER_COMPANY_ID

                          FROM SCMDATA.T_SUPPLIER_INFO A WHERE A.SUPPLIER_INFO_ID =''' ||
                      v_supinfo_id || '''
                          AND A.COMPANY_ID=''' ||
                      v_need_compid || ''''
    
      INTO v_suppid;
  
    RETURN v_suppid;
  END f_get_supcom_id;

  FUNCTION f_query_material_detail(p_quotation_id IN VARCHAR2) RETURN CLOB IS
    v_sql CLOB;
  
  BEGIN
    v_sql := q'[SELECT A.MATERIAL_DETAIL_QUOTATION_ID,
     --a.QUOTATION_ID,
     A.RELATED_COLORED_MATERIAL_DETAIL_QUOTATION_ID RELATED_COLORED_MATERIAL_ID,
     (CASE WHEN A.RELATED_COLORED_MATERIAL_DETAIL_QUOTATION_ID IS NOT NULL THEN 1 ELSE 0 END) IS_ADD,
     b.SUPPLIER_MATERIAL_NAME SUPPLIER_MATERIAL_NAME,
     b.supplier_color SUPPLIER_COLOR_DESC,
     b.SUPPLIER_NAME SUPABVNAME_00000,
     a.QUOTATION_MATERIAL_TYPE,
     a.QUOTATION_APPLICATION_SITE,
     a.QUOTATION_UNIT_PRICE,
     a.QUOTATION_UNIT_PRICE_CONSUMPTION,
     a.QUOTATION_LOSS_RATE,
     a.QUOTATION_UNIT||'/元' UNIT,
     --(a.quotation_unit_price * a.QUOTATION_UNIT_PRICE_CONSUMPTION * (1+(a.QUOTATION_LOSS_RATE/100))) MATERIAL_PRICE,
     /*F.RESULT MATERIAL_CLASSIFICATION,*/
     B.MATERIAL_CLASSIFICATION,
     b.MATERIAL_INGREDIENT,
     b.SUPPLIER_SHADES SUPPLIER_SHADES_DESC,
     b.MATERIAL_SPECIFICATIONS,
     b.PRACTICAL_DOOR_WITH,
     b.GRAM_WEIGHT,
     B.DISPARITY,
     A.QUOTATION_REMARK CRAFT_QUOTATION_REMARK,
     B.BUSINESS_CONTACT,
     B.CONTACT_PHONE CONTACT_PHONE_CD,
     B.DETAILED_ADDRESS DETAILED_ADDRESS_QT,
     --C.WHETHER_ADD_COLOR_QUOTATION IS_ADD,
     B.PREFERRED_NET_PRICE_OF_LARGE_GOOD LARGE_NET_PRICE,
     B.PREFERRED_PER_METER_PRICE_OF_LARGE_GOOD METER_PRICE,
     B.FILE_UNIQUE MATERIAL_PIC,
     (CASE WHEN a.whether_inner_material = 1 THEN '是' ELSE '否'END)  IS_INNER_MATERIAL,
     a.quotation_material_sku material_sku
 FROM plm.MATERIAL_DETAIL_QUOTATION a
 INNER JOIN PLM.QUOTATION C
    ON A.QUOTATION_ID = C.QUOTATION_ID
 INNER JOIN
 (SELECT Z.MATERIAL_SKU,
       Y.MATERIAL_NAME,
       X.SUPPLIER_MATERIAL_NAME,
       X.SUPPLIER_COLOR,
       y.material_classification,
       V.FILE_UNIQUE,
       (SELECT LISTAGG(T.INGREDIENT, ';') WITHIN GROUP(ORDER BY T.MATERIAL_SPU)
          FROM (SELECT A.MATERIAL_SPU,
                       T1.COMPANY_DICT_NAME || A.INGREDIENT_PROPORTION ||
                       A.PROPORTION_UNIT INGREDIENT
                  FROM MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING A
                 INNER JOIN SCMDATA.SYS_COMPANY_DICT T1
                    ON A.MATERIAL_INGREDIENT_ID = T1.COMPANY_DICT_ID
                    AND T1.PAUSE=0) T
         WHERE T.MATERIAL_SPU = Y.MATERIAL_SPU) MATERIAL_INGREDIENT,
       Y.MATERIAL_SPECIFICATIONS,
       Y.PRACTICAL_DOOR_WITH,
       Y.GRAM_WEIGHT,
       X.DISPARITY,
       Y.UNIT,
       W.SUPPLIER_NAME,
       W.BUSINESS_CONTACT,
       W.CONTACT_PHONE,
       W.DETAILED_ADDRESS,
       Z.PREFERRED_NET_PRICE_OF_LARGE_GOOD,
       Z.PREFERRED_PER_METER_PRICE_OF_LARGE_GOOD,
       X.SUPPLIER_SHADES,
       w.supplier_code
    FROM MRP.MRP_OUTSIDE_MATERIAL_SKU Z
   INNER JOIN MRP.MRP_OUTSIDE_MATERIAL_SPU Y
      ON Z.MATERIAL_SPU = Y.MATERIAL_SPU
   INNER JOIN MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL X
      ON Z.MATERIAL_SKU = X.MATERIAL_SKU
   INNER JOIN MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES W
      ON W.SUPPLIER_CODE = X.SUPPLIER_CODE
   LEFT JOIN  (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = y.FEATURES
   AND V.RN = 1
    UNION ALL
    SELECT z.material_sku,
       x.material_name,
       Z.SUPPLIER_MATERIAL_NAME,
       z.supplier_color,
       x.MATERIAL_CLASSIFICATION,
       V.FILE_UNIQUE,
       (SELECT LISTAGG(T.INGREDIENT, ';') WITHIN GROUP(ORDER BY T.MATERIAL_SPU)
          FROM (SELECT A.MATERIAL_SPU,
                       T1.COMPANY_DICT_NAME || A.INGREDIENT_PROPORTION ||
                       A.PROPORTION_UNIT INGREDIENT
                  FROM MRP.MRP_MATERIAL_SPU_INGREDIENT_MAPPING A
                 INNER JOIN SCMDATA.SYS_COMPANY_DICT T1
                    ON A.MATERIAL_INGREDIENT_ID = T1.COMPANY_DICT_ID
                    AND T1.PAUSE=0) T
                   WHERE T.MATERIAL_SPU=X.MATERIAL_SPU) MATERIAL_INGR,
       x.material_specifications,
        x.practical_door_with,
        x.gram_weight,
       z.disparity,
       x.unit,
       w.SUPPLIER_ABBREVIATION SUPPLIER_NAME,
       w.BUSINESS_CONTACT,
       w.CONTACT_PHONE,
       w.DETAILED_ADDRESS,
       y.preferred_net_price_of_large_good,
      y.preferred_per_meter_price_of_large_good,
      z.supplier_shades,
      w.supplier_code
FROM mrp.MRP_INTERNAL_SUPPLIER_MATERIAL z
INNER JOIN mrp.mrp_internal_material_sku y ON z.material_sku=y.material_sku
INNER JOIN mrp.mrp_internal_material_spu x ON y.material_spu=x.material_spu
INNER JOIN mrp.mrp_determine_supplier_archives W  ON w.SUPPLIER_CODE=z.supplier_code
LEFT JOIN (SELECT A.THIRDPART_ID,
                    A.FILE_UNIQUE,
                    ROW_NUMBER() OVER(PARTITION BY A.THIRDPART_ID ORDER BY A.UPLOAD_TIME DESC) AS RN
               FROM MRP.MRP_PICTURE A
              WHERE  A.PICTURE_TYPE = 1) V
    ON V.THIRDPART_ID = x.FEATURES
   AND V.RN = 1) b ON a.quotation_material_sku = b.material_sku AND a.QUOTATION_MATERIAL_SUPPLIER_CODE = b.supplier_code
/*LEFT JOIN  (SELECT NVL(T4.COMPANY_DICT_ID, T3.COMPANY_DICT_ID) CATEGORY_ID,
                    T1.COMPANY_DICT_NAME CATEGORY,
                    T2.COMPANY_DICT_NAME NAME1,
                    T3.COMPANY_DICT_NAME NAME2,
                    T4.COMPANY_DICT_NAME NAME4,
                    (T1.COMPANY_DICT_NAME || '/' || T2.COMPANY_DICT_NAME || '/' ||
                    T3.COMPANY_DICT_NAME || (CASE
                      WHEN T4.COMPANY_DICT_NAME IS NOT NULL THEN
                       '/' || T4.COMPANY_DICT_NAME
                      ELSE
                       NULL
                    END)) RESULT
               FROM SCMDATA.SYS_COMPANY_DICT T1
              LEFT JOIN SCMDATA.SYS_COMPANY_DICT T2
                 ON T1.COMPANY_ID = T2.COMPANY_ID
                AND T1.COMPANY_DICT_TYPE = 'MRP_MATERIAL_CLASSIFICATION'
                AND T2.COMPANY_DICT_TYPE = T1.COMPANY_DICT_VALUE
                AND T2.PAUSE = 0 AND T1.PAUSE=0
              LEFT JOIN SCMDATA.SYS_COMPANY_DICT T3
                 ON T2.COMPANY_ID = T3.COMPANY_ID
                AND T3.COMPANY_DICT_TYPE = T2.COMPANY_DICT_VALUE
                AND T3.PAUSE = 0
               LEFT JOIN SCMDATA.SYS_COMPANY_DICT T4
                 ON T3.COMPANY_ID = T4.COMPANY_ID
                AND T4.COMPANY_DICT_TYPE = T3.COMPANY_DICT_VALUE
                AND T4.PAUSE = 0) F ON F.CATEGORY_ID = B.MATERIAL_CLASSIFICATION */
WHERE  A.QUOTATION_ID =  ']' || p_quotation_id ||
             ''' order by A.MATERIAL_DETAIL_QUOTATION_ID ';
    RETURN v_sql;
  
  END f_query_material_detail;

  FUNCTION f_get_outsupp_info_pick(v_supp_id IN VARCHAR2) RETURN CLOB IS
    v_sql    CLOB;
    v_sup_id VARCHAR2(32);
  BEGIN
    v_sup_id := plm.pkg_outside_material.f_get_suppinfo_id(v_current_compid => v_supp_id,
                                                           v_need_compid    => 'b6cc680ad0f599cde0531164a8c0337f');
  
    v_sql := '
    SELECT ''NEW'' SUPPLIER_CODE,
        ''新建供应商'' SUPPLIER_FABRIC,
        NULL CREATE_SUPPLIER_NAME,
        NULL BUSINESS_CONTACT,
        NULL CONTACT_PHONE_QU,
        NULL  DETAILED_ADDRESS FROM DUAL
     UNION ALL
    SELECT A.SUPPLIER_CODE,
       A.SUPPLIER_NAME SUPPLIER_FABRIC,
       NULL CREATE_SUPPLIER_NAME,
       A.BUSINESS_CONTACT,
       A.CONTACT_PHONE CONTACT_PHONE_QU,
       A.DETAILED_ADDRESS
  FROM MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES A
  WHERE A.CREATE_FINISHED_PRODUCT_SUPPLIER_CODE = ''' ||
             v_sup_id || '''';
    RETURN v_sql;
  END f_get_outsupp_info_pick;

  PROCEDURE p_check_outmaterial_data(p_osp_data IN mrp.mrp_create_outside_material_sku_temp%ROWTYPE)
  
   IS
    v_category2 VARCHAR2(256);
    v_err       VARCHAR2(256);
    v_flag      NUMBER;
    v_exist_sku VARCHAR2(32);
    v_flag2     NUMBER;
    v_exist_spu VARCHAR2(32);
    v_supp_id   VARCHAR2(32);
  BEGIN
  
    v_supp_id := plm.pkg_outside_material.f_get_suppinfo_id(v_current_compid => p_osp_data.create_finished_product_supplier_code,
                                                            v_need_compid    => 'b6cc680ad0f599cde0531164a8c0337f');
  
    --二级分类
  
    SELECT name1
      INTO v_category2
      FROM (SELECT nvl(nvl(t4.company_dict_id, t3.company_dict_id),
                       t2.company_dict_id) category_id,
                   t1.company_dict_value category,
                   t2.company_dict_value name1,
                   t3.company_dict_value name2,
                   t4.company_dict_value name4
              FROM scmdata.sys_company_dict t1
              LEFT JOIN scmdata.sys_company_dict t2
                ON t1.company_id = t2.company_id
               AND t1.company_dict_type = 'MRP_MATERIAL_CLASSIFICATION'
               AND t2.company_dict_type = t1.company_dict_value
               AND t2.pause = 0
               AND t1.pause = 0
              LEFT JOIN scmdata.sys_company_dict t3
                ON t2.company_id = t3.company_id
               AND t3.company_dict_type = t2.company_dict_value
               AND t3.pause = 0
              LEFT JOIN scmdata.sys_company_dict t4
                ON t3.company_id = t4.company_id
               AND t4.company_dict_type = t3.company_dict_value
               AND t4.pause = 0)
     WHERE category_id = p_osp_data.material_classification;
  
    IF p_osp_data.supplier_code = 'NEW' AND
       p_osp_data.supplier_name IS NULL THEN
      v_err := '【新建供应商简称】';
    END IF;
    IF p_osp_data.contact_phone IS NULL THEN
      v_err := v_err || '【业务联系电话】';
    END IF;
  
    IF v_category2 IN
       ('MRP_MATERIAL_CLASSIFICATION00020002',
        'MRP_MATERIAL_CLASSIFICATION00020003',
        'MRP_MATERIAL_CLASSIFICATION00020004',
        'MRP_MATERIAL_CLASSIFICATION00020001') THEN
      IF p_osp_data.practical_door_with IS NULL THEN
        v_err := v_err || ' 【实用门幅】';
      END IF;
      IF p_osp_data.gram_weight IS NULL THEN
        v_err := v_err || ' 【克重】 ';
      
        --ELSIF p_osp_data.DISPARITY IS NULL THEN
        -- V_ERR := V_ERR || ' 【空差】 ';
      END IF;
    
    ELSE
      IF p_osp_data.material_specifications IS NULL THEN
        v_err := v_err || ' 【物料规格】 ';
      ELSE
        NULL;
      END IF;
    END IF;
    IF lengthb(p_osp_data.contact_phone) > 16 THEN
      v_err := v_err || '【业务联系电话】字节长度过长';
    END IF;
    IF v_err IS NOT NULL THEN
      raise_application_error(-20002, '必填项' || v_err);
    ELSE
      NULL;
    END IF;
  
    IF v_category2 IN
       ('MRP_MATERIAL_CLASSIFICATION00020001',
        'MRP_MATERIAL_CLASSIFICATION00020002',
        'MRP_MATERIAL_CLASSIFICATION00020003',
        'MRP_MATERIAL_CLASSIFICATION00020004') THEN
      --当【物料分类-二级分类】=【 针织/梭织/牛仔面料/毛呢类】时，
      --【供应商名称】+【供应商物料名称】+【供应商颜色】+【创建成品供应商编号】+【克重】在【MRP-外部物料档案】中相同时
    
      SELECT COUNT(1), MAX(a.material_spu)
        INTO v_flag2, v_exist_spu
        FROM mrp.mrp_outside_material_spu a
       INNER JOIN mrp.mrp_outside_material_sku b
          ON a.material_spu = b.material_spu
       INNER JOIN mrp.mrp_outside_supplier_material c
          ON c.material_sku = b.material_sku
       WHERE a.material_name = p_osp_data.material_name
         AND c.create_finished_supplier_code = v_supp_id
         AND a.gram_weight = p_osp_data.gram_weight;
    
      IF v_flag2 > 0 THEN
        raise_application_error(-20002,
                                '已存在 ' || v_exist_spu ||
                                '对应当前【物料名称】，请前往【SPU加色】或【SKU加供】进行操作');
      
      ELSE
      
        SELECT COUNT(1), MAX(z.material_sku)
          INTO v_flag, v_exist_sku
          FROM mrp.mrp_outside_supplier_material z
         INNER JOIN mrp.mrp_outside_material_sku b
            ON b.material_sku = z.material_sku
           AND b.create_finished_supplier_code =
               z.create_finished_supplier_code
         INNER JOIN mrp.mrp_outside_material_spu a
            ON a.material_spu = b.material_spu
         WHERE z.supplier_code = p_osp_data.supplier_code
           AND z.create_finished_supplier_code = v_supp_id
           AND z.supplier_color = p_osp_data.supplier_color
           AND z.supplier_material_name = p_osp_data.material_name
           AND a.gram_weight = p_osp_data.gram_weight;
      
        IF v_flag > 0 THEN
          raise_application_error(-20002,
                                  '已存在 ' || v_exist_sku ||
                                  '对应当前物料，请前往选择已有面料进行操作');
        ELSE
          NULL;
        END IF;
      END IF;
    ELSE
      --当【物料分类-二级分类】≠【 针织/梭织/牛仔面料/毛呢类】时，
      --【供应商名称】+【供应商物料名称】+【供应商颜色】+【创建成品供应商编号】+【物料规格】在【MRP-外部物料档案】中相同时
      SELECT COUNT(1), MAX(a.material_spu)
        INTO v_flag2, v_exist_spu
        FROM mrp.mrp_outside_material_spu a
       INNER JOIN mrp.mrp_outside_material_sku b
          ON a.material_spu = b.material_spu
       INNER JOIN mrp.mrp_outside_supplier_material c
          ON c.material_sku = b.material_sku
       WHERE a.material_name = p_osp_data.material_name
         AND c.create_finished_supplier_code = v_supp_id
         AND a.material_specifications = p_osp_data.material_specifications;
    
      IF v_flag2 > 0 THEN
        raise_application_error(-20002,
                                '已存在 ' || v_exist_spu ||
                                '对应当前【物料名称】，请前往【SPU加色】或【SKU加供】进行操作');
      
      ELSE
      
        SELECT COUNT(1), MAX(z.material_sku)
          INTO v_flag, v_exist_sku
          FROM mrp.mrp_outside_supplier_material z
         INNER JOIN mrp.mrp_outside_material_sku b
            ON b.material_sku = z.material_sku
           AND b.create_finished_supplier_code =
               z.create_finished_supplier_code
         INNER JOIN mrp.mrp_outside_material_spu a
            ON a.material_spu = b.material_spu
         WHERE z.supplier_code = p_osp_data.supplier_code
           AND z.create_finished_supplier_code = v_supp_id
           AND z.supplier_color = p_osp_data.supplier_color
           AND z.supplier_material_name = p_osp_data.material_name
           AND a.material_specifications =
               p_osp_data.material_specifications;
      
        IF v_flag > 0 THEN
          raise_application_error(-20002,
                                  '已存在 ' || v_exist_sku ||
                                  '对应当前物料，请前往选择已有面料进行操作');
        ELSE
          NULL;
        END IF;
      
      END IF;
    
    END IF;
  
  END p_check_outmaterial_data;

  PROCEDURE p_ins_outmaterial_temp(v_rec IN mrp.mrp_create_outside_material_sku_temp%ROWTYPE) IS
  
    v_dahuo_jinjia NUMBER;
    v_quotation_id VARCHAR2(32);
  
    -- v_supp_id             VARCHAR2(32);
  BEGIN
  
    /* v_supp_id := plm.pkg_outside_material.F_GET_SUPPINFO_ID(V_CURRENT_COMPID =>V_REC.CREATE_FINISHED_PRODUCT_SUPPLIER_CODE ,
    V_NEED_COMPID =>'b6cc680ad0f599cde0531164a8c0337f' );*/
  
    v_quotation_id := scmdata.pkg_variable.f_get_varchar(v_objid   => v_rec.create_id,
                                                         v_compid  => v_rec.create_finished_product_supplier_code,
                                                         v_varname => 'ASS_QUO_ID');
  
    --大货净价
    IF v_rec.unit = '公斤' THEN
      v_dahuo_jinjia := round(v_rec.supplier_large_good_quote / 25 *
                              (25 + nvl(v_rec.disparity, 0)),
                              1);
    ELSIF v_rec.unit = '米' THEN
      --当空差=0时，
      IF v_rec.disparity = 0 THEN
        v_dahuo_jinjia := 0;
      ELSE
        v_dahuo_jinjia := round(v_rec.supplier_large_good_quote /
                                (nvl(v_rec.disparity, 100) / 100),
                                1);
      END IF;
    ELSE
      v_dahuo_jinjia := v_rec.supplier_large_good_quote;
    END IF;
  
    INSERT INTO mrp.mrp_create_outside_material_sku_temp
      (temp_id,
       --MATERIAL_SPU,
       material_classification,
       --MATERIAL_SKU,
       material_name, supplier_color, supplier_shades, unit,
       practical_door_with, gram_weight, disparity,
       supplier_large_good_quote, supplier_large_good_net_price,
       material_specifications, supplier_name, supplier_code,
       business_contact, contact_phone, detailed_address,
       create_finished_product_supplier_code, features, picture_type,
       color_picture, picture_type2, color_card_picture, picture_type3,
       create_id, create_time, function_tag_id, quo_id)
    VALUES
      (v_rec.temp_id,
       --SPU_ID,
       v_rec.material_classification,
       --V_SKU_ID,
       v_rec.material_name, v_rec.supplier_color, v_rec.supplier_shades,
       v_rec.unit, v_rec.practical_door_with, v_rec.gram_weight,
       v_rec.disparity, v_rec.supplier_large_good_quote, v_dahuo_jinjia,
       v_rec.material_specifications, v_rec.supplier_name,
       v_rec.supplier_code, v_rec.business_contact, v_rec.contact_phone,
       v_rec.detailed_address, v_rec.create_finished_product_supplier_code,
       v_rec.features, 1, v_rec.color_picture, 2, v_rec.color_card_picture,
       3, v_rec.create_id, SYSDATE, v_rec.function_tag_id, v_quotation_id);
  END p_ins_outmaterial_temp;

  PROCEDURE p_upd_outmaterial_temp(v_rec IN mrp.mrp_create_outside_material_sku_temp%ROWTYPE) IS
  
    v_dahuo_jinjia NUMBER;
  BEGIN
    --大货净价
    IF v_rec.unit = '公斤' THEN
      v_dahuo_jinjia := round(v_rec.supplier_large_good_quote / 25 *
                              (25 + nvl(v_rec.disparity, 0)),
                              1);
    ELSIF v_rec.unit = '米' THEN
      IF v_rec.disparity = 0 THEN
        v_dahuo_jinjia := 0;
      ELSE
        v_dahuo_jinjia := round(v_rec.supplier_large_good_quote /
                                (nvl(v_rec.disparity, 100) / 100),
                                1);
      END IF;
    ELSE
      v_dahuo_jinjia := v_rec.supplier_large_good_quote;
    END IF;
  
    UPDATE mrp.mrp_create_outside_material_sku_temp t
       SET t.material_classification       = v_rec.material_classification,
           t.material_name                 = v_rec.material_name,
           t.supplier_color                = v_rec.supplier_color,
           t.supplier_shades               = v_rec.supplier_shades,
           t.unit                          = v_rec.unit,
           t.practical_door_with           = v_rec.practical_door_with,
           t.gram_weight                   = v_rec.gram_weight,
           t.disparity                     = v_rec.disparity,
           t.supplier_large_good_quote     = v_rec.supplier_large_good_quote,
           t.supplier_large_good_net_price = v_dahuo_jinjia,
           t.material_specifications       = v_rec.material_specifications,
           t.supplier_name                 = v_rec.supplier_name,
           t.supplier_code                 = v_rec.supplier_code,
           t.business_contact              = v_rec.business_contact,
           t.contact_phone                 = v_rec.contact_phone,
           t.detailed_address              = v_rec.detailed_address,
           t.function_tag_id               = v_rec.function_tag_id,
           t.create_time                   = SYSDATE,
           t.features                      = v_rec.features,
           t.color_picture                 = v_rec.color_picture,
           t.color_card_picture            = v_rec.color_card_picture
     WHERE t.temp_id = v_rec.temp_id;
  
  END p_upd_outmaterial_temp;

  PROCEDURE p_ins_mrp_pic(pi_mrp_pic mrp.mrp_picture%ROWTYPE) IS
  BEGIN
    INSERT INTO mrp.mrp_picture
      (picture_id, thirdpart_id, picture_name, source_name, url, bucket,
       upload_time, picture_type, file_blob, file_unique, file_size)
    VALUES
      (f_get_mrp_keyid(pi_pre     => 1,
                       pi_owner   => 'PLM',
                       pi_seqname => 'SEQ_MRPPIC_ID',
                       pi_seqnum  => 99), pi_mrp_pic.thirdpart_id,
       pi_mrp_pic.picture_name, pi_mrp_pic.source_name, pi_mrp_pic.url,
       pi_mrp_pic.bucket, pi_mrp_pic.upload_time, pi_mrp_pic.picture_type,
       pi_mrp_pic.file_blob, pi_mrp_pic.file_unique, pi_mrp_pic.file_size);
  END p_ins_mrp_pic;

  PROCEDURE p_upd_mrp_pic(p_mrp_pic_rec mrp.mrp_picture%ROWTYPE) IS
  BEGIN
    UPDATE mrp.mrp_picture t
       SET t.picture_name = p_mrp_pic_rec.picture_name,
           t.source_name  = p_mrp_pic_rec.source_name,
           t.upload_time  = p_mrp_pic_rec.upload_time,
           t.file_blob    = p_mrp_pic_rec.file_blob,
           t.file_unique  = p_mrp_pic_rec.file_unique,
           t.file_size    = p_mrp_pic_rec.file_size
     WHERE t.thirdpart_id = p_mrp_pic_rec.thirdpart_id
       AND t.picture_type = p_mrp_pic_rec.picture_type;
  END p_upd_mrp_pic;

  PROCEDURE p_ins_outmaterial_bysubmit(v_tem_id IN VARCHAR2,
                                       v_com_id IN VARCHAR2) IS
  
    v_rec mrp.mrp_create_outside_material_sku_temp%ROWTYPE;
    --V_POC MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING_TEMP%ROWTYPE;
    v_supp_code VARCHAR2(32);
    spu_id_pre  VARCHAR2(32);
    spu_id      VARCHAR2(32);
    v_sku_id    VARCHAR2(32);
    v_cate1     VARCHAR2(256);
    v_cate2     VARCHAR2(256);
    v_cate3     VARCHAR2(256);
    v_cate4     VARCHAR2(256);
    v_cate      VARCHAR2(256);
    v_mijia     NUMBER;
    v_bscontact VARCHAR2(128);
    v_pho       VARCHAR2(128);
    v_add       VARCHAR2(128);
    v_extend01  VARCHAR2(128);
    v_extend02  VARCHAR2(128);
    v_extend03  VARCHAR2(128);
    v_sum       NUMBER;
    v_supp_id   VARCHAR2(32);
    --V_SUPP_NAME VARCHAR2(64);
    vo_log_id VARCHAR2(32);
    --V_QUO       VARCHAR2(256);
    v_quotation_id VARCHAR2(256);
    --v_rest_method  VARCHAR2(256);
    --v_params       VARCHAR2(256);
    v_num         NUMBER;
    v_num2        NUMBER;
    v_material_id VARCHAR2(64);
    v_unit2       VARCHAR2(32);
    v_neirong     BLOB;
    v_name        VARCHAR2(300);
    v_size        NUMBER(20);
    v_ope_name    VARCHAR2(64);
    --V_UPTIME        DATE;
    --V_FILE_ID       VARCHAR2(32);
    v_log_msg     CLOB := NULL;
    v_mrp_pic_rec mrp.mrp_picture%ROWTYPE;
  BEGIN
  
    SELECT *
      INTO v_rec
      FROM mrp.mrp_create_outside_material_sku_temp a
     WHERE a.temp_id = v_tem_id
       AND a.create_finished_product_supplier_code = v_com_id;
  
    SELECT nvl(MAX(t.nick_name), 'ADMIN')
      INTO v_ope_name
      FROM scmdata.sys_user t
     WHERE t.user_id = v_rec.create_id;
  
    /*SELECT * INTO V_POC
    FROM MRP.MRP_OUTSIDE_MATERIAL_SPU_INGREDIENT_MAPPING_TEMP B WHERE B.TEMP_ID = V_TEM_ID;*/
  
    /*v_quotation_id := scmdata.pkg_variable.f_get_varchar(v_objid   => v_rec.create_id,
    v_compid  => v_com_id,
    v_varname => 'ASS_QUO_ID');*/
  
    v_quotation_id := v_rec.quo_id;
  
    --供应商编号
    IF v_rec.supplier_code = 'NEW' THEN
    
      --前缀
    
      v_supp_code := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES',
                                                     v_column_name => 'SUPPLIER_CODE',
                                                     v_pre         => 'L' ||
                                                                      to_char(SYSDATE,
                                                                              'YY'),
                                                     v_serail_num  => 5);
    
    END IF;
  
    v_supp_id := plm.pkg_outside_material.f_get_suppinfo_id(v_current_compid => v_rec.create_finished_product_supplier_code,
                                                            v_need_compid    => 'b6cc680ad0f599cde0531164a8c0337f');
    /*--创建供应商
    SELECT T.SUPPLIER_COMPANY_ABBREVIATION
      INTO V_SUPP_NAME
      FROM SCMDATA.T_SUPPLIER_INFO T
      WHERE T.SUPPLIER_INFO_ID = v_supp_id
        AND T.COMPANY_ID='b6cc680ad0f599cde0531164a8c0337f';*/
  
    --SPU编号
  
    --生成spu编号
    SELECT extend01, extend02, extend03
      INTO v_extend01, v_extend02, v_extend03
      FROM (SELECT nvl(nvl(t4.company_dict_id, t3.company_dict_id),
                       t2.company_dict_id) category_id,
                   --T1.COMPANY_DICT_NAME CATEGORY,
                   t1.extend_01 extend01,
                   --T2.COMPANY_DICT_NAME NAME1,
                   t2.extend_01 extend02,
                   --T3.COMPANY_DICT_NAME NAME2,
                   t3.extend_01 extend03
            --T4.COMPANY_DICT_NAME NAME4
              FROM scmdata.sys_company_dict t1
              LEFT JOIN scmdata.sys_company_dict t2
                ON t1.company_id = t2.company_id
               AND t1.company_dict_type = 'MRP_MATERIAL_CLASSIFICATION'
               AND t2.company_dict_type = t1.company_dict_value
               AND t1.pause = 0
               AND t2.pause = 0
              LEFT JOIN scmdata.sys_company_dict t3
                ON t2.company_id = t3.company_id
               AND t3.company_dict_type = t2.company_dict_value
               AND t3.pause = 0
              LEFT JOIN scmdata.sys_company_dict t4
                ON t3.company_id = t4.company_id
               AND t4.company_dict_type = t3.company_dict_value
               AND t4.pause = 0)
     WHERE category_id = v_rec.material_classification
    /*(SELECT A.MATERIAL_CLASSIFICATION
     FROM MRP.MRP_CREATE_OUTSIDE_MATERIAL_SKU_TEMP A
    WHERE A.TEMP_ID = V_TEM_ID
      AND A.CREATE_FINISHED_PRODUCT_SUPPLIER_CODE = V_COM_ID)*/
    ;
    ---前缀
    spu_id_pre := 'W' || v_extend01 || v_extend02 || v_extend03;
    spu_id     := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MRP.MRP_OUTSIDE_MATERIAL_SPU',
                                                  v_column_name => 'MATERIAL_SPU',
                                                  v_pre         => spu_id_pre,
                                                  v_serail_num  => 4);
  
    --SKU编号
  
    --SKU编号
    --V_SKU_PRE := SPU_ID||'0'|| TO_CHAR(SYSDATE,'YY');
    v_sku_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MRP.MRP_OUTSIDE_MATERIAL_SKU',
                                                v_column_name => 'MATERIAL_SKU',
                                                v_pre         => spu_id || '0' ||
                                                                 to_char(SYSDATE,
                                                                         'YY'),
                                                v_serail_num  => 3);
  
    --分类
  
    SELECT t1.company_dict_value category,
           t2.company_dict_value name1,
           t3.company_dict_value name2,
           t4.company_dict_value name4,
           t1.company_dict_name || '/' || t2.company_dict_name || '/' ||
           t3.company_dict_name || (CASE
             WHEN t4.company_dict_name IS NOT NULL THEN
              '/' || t4.company_dict_name
             ELSE
              NULL
           END) RESULT
      INTO v_cate1, v_cate2, v_cate3, v_cate4, v_cate
      FROM scmdata.sys_company_dict t1
      LEFT JOIN scmdata.sys_company_dict t2
        ON t1.company_id = t2.company_id
       AND t1.company_dict_type = 'MRP_MATERIAL_CLASSIFICATION'
       AND t2.company_dict_type = t1.company_dict_value
      LEFT JOIN scmdata.sys_company_dict t3
        ON t2.company_id = t3.company_id
       AND t3.company_dict_type = t2.company_dict_value
      LEFT JOIN scmdata.sys_company_dict t4
        ON t3.company_id = t4.company_id
       AND t4.company_dict_type = t3.company_dict_value
     WHERE nvl(nvl(t4.company_dict_id, t3.company_dict_id),
               t2.company_dict_id) = v_rec.material_classification;
  
    --优选大货米价
    IF v_rec.unit = '米' AND v_cate1 = 'MRP_MATERIAL_CLASSIFICATION0002' THEN
      v_mijia := v_rec.supplier_large_good_net_price;
    ELSIF v_rec.unit = '公斤' AND
          v_cate2 IN ('MRP_MATERIAL_CLASSIFICATION00020002',
                      'MRP_MATERIAL_CLASSIFICATION00020001') THEN
      v_mijia := trunc(v_rec.supplier_large_good_net_price /
                       round((1 / ((v_rec.practical_door_with + 5) / 100) /
                             (v_rec.gram_weight / 1000)),
                             2),
                       1);
    ELSIF v_rec.unit = '罗' AND v_cate1 = 'MRP_MATERIAL_CLASSIFICATION0002' THEN
      v_mijia := trunc((v_rec.supplier_large_good_net_price / 131.7), 2);
    ELSE
      v_mijia := NULL;
    END IF;
  
    --总成分
    SELECT SUM(b.ingredient_proportion)
      INTO v_sum
      FROM mrp.mrp_create_outside_material_sku_temp a
     INNER JOIN mrp.mrp_outside_material_spu_ingredient_mapping_temp b
        ON a.temp_id = b.temp_id
     WHERE b.temp_id = v_tem_id
       AND a.create_finished_product_supplier_code = v_com_id;
  
    IF (instr(v_cate, '复合') > 0 OR instr(v_cate, 'PU') > 0) AND
       v_sum <> 200 THEN
      raise_application_error(-20002,
                              '【分类】中含有“复合”“PU”字样时，各成分汇总需等于200%');
    ELSIF (instr(v_cate, '复合') = 0 AND instr(v_cate, 'PU') = 0) AND
          v_sum <> 100 THEN
      raise_application_error(-20002,
                              '【分类】中不含“复合”“PU”字样时，各成分汇总需等于100');
    END IF;
  
    ----插入到业务表
  
    --插入SPU
    INSERT INTO mrp.mrp_outside_material_spu
      (material_spu, features, material_name, ingredients,
       practical_door_with, unit, gram_weight, function_tag,
       material_classification, material_specifications,
       create_finished_supplier_code, create_time, create_id, update_time,
       update_id, whether_del)
    VALUES
      (spu_id, spu_id, v_rec.material_name, spu_id,
       v_rec.practical_door_with, v_rec.unit, v_rec.gram_weight, spu_id,
       v_rec.material_classification, v_rec.material_specifications,
       v_supp_id, SYSDATE, v_rec.create_id, SYSDATE, v_rec.create_id, 0);
  
    --功能标签
    IF v_rec.function_tag_id IS NOT NULL THEN
      IF instr(v_rec.function_tag_id, ';') > 0 THEN
        FOR a IN (SELECT regexp_substr(v_rec.function_tag_id,
                                       '[^;]+',
                                       1,
                                       rownum) fun_id
                    FROM dual
                  CONNECT BY rownum <=
                             length(v_rec.function_tag_id) -
                             length(REPLACE(v_rec.function_tag_id, ';', '')) + 1) LOOP
        
          INSERT INTO mrp.mrp_outside_material_spu_function_tag_mapping
            (function_tag_mapping_id, material_spu,
             material_function_tag_id)
          VALUES
            (f_get_mrp_keyid(pi_pre     => 1,
                             pi_owner   => 'PLM',
                             pi_seqname => 'SEQ_MRPPIC_ID',
                             pi_seqnum  => 99), spu_id, a.fun_id);
        END LOOP;
      ELSE
        INSERT INTO mrp.mrp_outside_material_spu_function_tag_mapping
          (function_tag_mapping_id, material_spu, material_function_tag_id)
        VALUES
          (f_get_mrp_keyid(pi_pre     => 1,
                           pi_owner   => 'PLM',
                           pi_seqname => 'SEQ_MRPPIC_ID',
                           pi_seqnum  => 99), spu_id, v_rec.function_tag_id);
      END IF;
    ELSE
      NULL;
    END IF;
  
    --特征图
    IF v_rec.features IS NOT NULL THEN
      IF instr(v_rec.features, ',') > 0 THEN
        FOR p IN (SELECT regexp_substr(v_rec.features, '[^,]+', 1, rownum) pic_id
                    FROM dual
                  CONNECT BY rownum <=
                             length(v_rec.features) -
                             length(REPLACE(v_rec.features, ',', '')) + 1) LOOP
          plm.pkg_plat_comm.p_get_file_info(p_file_unique => p.pic_id,
                                            po_file_name  => v_name,
                                            po_file_size  => v_size,
                                            po_attachment => v_neirong);
          v_mrp_pic_rec.picture_name := v_name;
          v_mrp_pic_rec.source_name  := v_name;
          v_mrp_pic_rec.url          := ' ';
          v_mrp_pic_rec.upload_time  := SYSDATE;
          v_mrp_pic_rec.picture_type := 1;
          v_mrp_pic_rec.file_blob    := v_neirong;
          v_mrp_pic_rec.file_unique  := p.pic_id;
          v_mrp_pic_rec.file_size    := v_size;
          v_mrp_pic_rec.thirdpart_id := spu_id;
        
          p_ins_mrp_pic(pi_mrp_pic => v_mrp_pic_rec);
          /*SELECT A.ATTACHMENT,
                 T.FILE_NAME,
                 A.FILE_SIZE,
                 A.LASTUPDATETIME,
                 A.FILE_ID
            INTO V_NEIRONG, V_NAME, V_SIZE, V_UPTIME, V_FILE_ID
            FROM SCMDATA.FILE_INFO T
           INNER JOIN SCMDATA.FILE_DATA A
              ON T.MD5 = A.FILE_ID
           WHERE T.FILE_UNIQUE = P.PIC_ID;
          INSERT INTO MRP.MRP_PICTURE (PICTURE_ID,THIRDPART_ID,PICTURE_NAME,SOURCE_NAME,URL, UPLOAD_TIME,PICTURE_TYPE,FILE_BLOB,FILE_UNIQUE,FILE_SIZE)
          VALUES
            (F_GET_MRP_KEYID(PI_PRE     => 1,
                             PI_OWNER   => 'PLM',
                             PI_SEQNAME => 'SEQ_OUTMATERIAL_ID',
                             PI_SEQNUM  => 999),  SPU_ID, V_NAME,V_NAME,' ',V_UPTIME, 1,V_NEIRONG, V_FILE_ID, V_SIZE);*/
        END LOOP;
      
      ELSE
        plm.pkg_plat_comm.p_get_file_info(p_file_unique => v_rec.features,
                                          po_file_name  => v_name,
                                          po_file_size  => v_size,
                                          po_attachment => v_neirong);
        v_mrp_pic_rec.picture_name := v_name;
        v_mrp_pic_rec.source_name  := v_name;
        v_mrp_pic_rec.url          := ' ';
        v_mrp_pic_rec.upload_time  := SYSDATE;
        v_mrp_pic_rec.picture_type := 1;
        v_mrp_pic_rec.file_blob    := v_neirong;
        v_mrp_pic_rec.file_unique  := v_rec.features;
        v_mrp_pic_rec.file_size    := v_size;
        v_mrp_pic_rec.thirdpart_id := spu_id;
        p_ins_mrp_pic(pi_mrp_pic => v_mrp_pic_rec);
      END IF;
    ELSE
      NULL;
    END IF;
  
    --色卡图
    IF v_rec.color_card_picture IS NOT NULL THEN
      IF instr(v_rec.color_card_picture, ',') > 0 THEN
        FOR p IN (SELECT regexp_substr(v_rec.color_card_picture,
                                       '[^,]+',
                                       1,
                                       rownum) pic_id
                    FROM dual
                  CONNECT BY rownum <= length(v_rec.color_card_picture) -
                             length(REPLACE(v_rec.color_card_picture,
                                                      ',',
                                                      '')) + 1) LOOP
        
          plm.pkg_plat_comm.p_get_file_info(p_file_unique => p.pic_id,
                                            po_file_name  => v_name,
                                            po_file_size  => v_size,
                                            po_attachment => v_neirong);
          v_mrp_pic_rec.picture_name := v_name;
          v_mrp_pic_rec.source_name  := v_name;
          v_mrp_pic_rec.url          := ' ';
          v_mrp_pic_rec.upload_time  := SYSDATE;
          v_mrp_pic_rec.picture_type := 3;
          v_mrp_pic_rec.file_blob    := v_neirong;
          v_mrp_pic_rec.file_unique  := p.pic_id;
          v_mrp_pic_rec.file_size    := v_size;
          v_mrp_pic_rec.thirdpart_id := (CASE
                                          WHEN v_rec.supplier_code = 'NEW' THEN
                                           v_supp_code
                                          ELSE
                                           v_rec.supplier_code
                                        END) || v_sku_id || v_supp_id;
          p_ins_mrp_pic(pi_mrp_pic => v_mrp_pic_rec);
          /*SELECT A.ATTACHMENT,
                 T.FILE_NAME,
                 A.FILE_SIZE,
                 A.LASTUPDATETIME,
                 A.FILE_ID
            INTO V_NEIRONG, V_NAME, V_SIZE, V_UPTIME, V_FILE_ID
            FROM SCMDATA.FILE_INFO T
           INNER JOIN SCMDATA.FILE_DATA A
              ON T.MD5 = A.FILE_ID
           WHERE T.FILE_UNIQUE = P.PIC_ID;
          INSERT INTO MRP.MRP_PICTURE (PICTURE_ID,THIRDPART_ID,PICTURE_NAME,SOURCE_NAME,UPLOAD_TIME,URL,PICTURE_TYPE,FILE_BLOB,FILE_UNIQUE,FILE_SIZE)
          VALUES
            (F_GET_MRP_KEYID(PI_PRE     => 1,
                             PI_OWNER   => 'PLM',
                             PI_SEQNAME => 'SEQ_OUTMATERIAL_ID',
                             PI_SEQNUM  => 999),V_SKU_ID, V_NAME,V_NAME,V_UPTIME,' ',3,V_NEIRONG, V_FILE_ID, V_SIZE);*/
        END LOOP;
      ELSE
        plm.pkg_plat_comm.p_get_file_info(p_file_unique => v_rec.color_card_picture,
                                          po_file_name  => v_name,
                                          po_file_size  => v_size,
                                          po_attachment => v_neirong);
        v_mrp_pic_rec.picture_name := v_name;
        v_mrp_pic_rec.source_name  := v_name;
        v_mrp_pic_rec.url          := ' ';
        v_mrp_pic_rec.upload_time  := SYSDATE;
        v_mrp_pic_rec.picture_type := 3;
        v_mrp_pic_rec.file_blob    := v_neirong;
        v_mrp_pic_rec.file_unique  := v_rec.color_card_picture;
        v_mrp_pic_rec.file_size    := v_size;
        v_mrp_pic_rec.thirdpart_id := (CASE
                                        WHEN v_rec.supplier_code = 'NEW' THEN
                                         v_supp_code
                                        ELSE
                                         v_rec.supplier_code
                                      END) || v_sku_id || v_supp_id;
        p_ins_mrp_pic(pi_mrp_pic => v_mrp_pic_rec);
      END IF;
    ELSE
      NULL;
    END IF;
  
    --颜色图
    IF v_rec.color_picture IS NOT NULL THEN
      plm.pkg_plat_comm.p_get_file_info(p_file_unique => v_rec.color_picture,
                                        po_file_name  => v_name,
                                        po_file_size  => v_size,
                                        po_attachment => v_neirong);
      v_mrp_pic_rec.picture_name := v_name;
      v_mrp_pic_rec.source_name  := v_name;
      v_mrp_pic_rec.url          := ' ';
      v_mrp_pic_rec.upload_time  := SYSDATE;
      v_mrp_pic_rec.picture_type := 2;
      v_mrp_pic_rec.file_blob    := v_neirong;
      v_mrp_pic_rec.file_unique  := v_rec.color_picture;
      v_mrp_pic_rec.file_size    := v_size;
      v_mrp_pic_rec.thirdpart_id := v_sku_id;
      p_ins_mrp_pic(pi_mrp_pic => v_mrp_pic_rec);
    ELSE
      NULL;
    END IF;
    --成分表
  
    FOR b IN (SELECT *
                FROM mrp.mrp_outside_material_spu_ingredient_mapping_temp b
               WHERE b.temp_id = v_tem_id) LOOP
    
      INSERT INTO mrp.mrp_outside_material_spu_ingredient_mapping
        (ingredient_id, material_spu, material_ingredient_id,
         ingredient_proportion, proportion_unit)
      VALUES
        (f_get_mrp_keyid(pi_pre     => 1,
                         pi_owner   => 'PLM',
                         pi_seqname => 'SEQ_MRPPIC_ID',
                         pi_seqnum  => 99), spu_id, b.material_ingredient_id,
         b.ingredient_proportion, '%');
    END LOOP;
  
    --插入SKU
  
    INSERT INTO mrp.mrp_outside_material_sku
      (material_sku, color_picture, material_color, material_spu,
       preferred_net_price_of_large_good,
       preferred_per_meter_price_of_large_good, sku_status, create_time,
       create_finished_supplier_code, create_id, update_time, update_id,
       whether_del)
    VALUES
      (v_sku_id, v_sku_id, v_rec.supplier_color, spu_id,
       v_rec.supplier_large_good_net_price, v_mijia, 1, SYSDATE, v_supp_id,
       v_rec.create_id, SYSDATE, v_rec.create_id, 0);
  
    --插入外部物料
    INSERT INTO mrp.mrp_outside_supplier_material
      (sku_abutment_code, supplier_code, material_sku,
       supplier_material_name, color_card_picture, supplier_color,
       supplier_shades, optimization, disparity, supplier_large_good_quote,
       supplier_large_good_net_price, supplier_material_status,
       material_source, create_time, creater, create_finished_supplier_code,
       update_time, update_id, whether_del)
    VALUES
      ((CASE WHEN v_rec.supplier_code = 'NEW' THEN v_supp_code ELSE
        v_rec.supplier_code END) || v_sku_id || v_supp_id,
       (CASE WHEN v_rec.supplier_code = 'NEW' THEN v_supp_code ELSE
         v_rec.supplier_code END), v_sku_id, v_rec.material_name,
       (CASE WHEN v_rec.supplier_code = 'NEW' THEN v_supp_code ELSE
         v_rec.supplier_code END) || v_sku_id || v_supp_id,
       v_rec.supplier_color, v_rec.supplier_shades, 1, v_rec.disparity,
       v_rec.supplier_large_good_quote, v_rec.supplier_large_good_net_price,
       1, 'ODM供应商报价', SYSDATE, v_rec.create_id, v_supp_id, SYSDATE,
       v_rec.create_id, 0);
  
    --临时供应商表
    IF v_rec.supplier_code = 'NEW' THEN
      INSERT INTO mrp.mrp_temporary_supplier_archives
        (supplier_code, supplier_source, cooperation_status, supplier_name,
         create_finished_product_supplier_code, business_contact,
         contact_phone, detailed_address, create_time, create_id,
         update_time, update_id, whether_del)
      VALUES
        (v_supp_code, 'ODM供应商报价', 1, v_rec.supplier_name, v_supp_id,
         v_rec.business_contact, v_rec.contact_phone, v_rec.detailed_address,
         SYSDATE, v_rec.create_id, SYSDATE, v_rec.create_id, 0);
      --创建外部供应商日志
      INSERT INTO mrp.mrp_log
        (id, user_name, operate_content, operate, create_time, class_name,
         method_name, thirdpart_id)
      VALUES
        (plm.pkg_outside_material.f_get_mrp_keyid(pi_pre     => 1,
                                                  pi_owner   => 'PLM',
                                                  pi_seqname => 'SEQ_MRPPIC_ID',
                                                  pi_seqnum  => 99),
         v_ope_name, '创建新物料供应商：' || v_supp_code, 'insert', SYSDATE,
         'SCM-ODM报价管理', '创建物料信息', v_supp_code);
    ELSE
      SELECT y.business_contact, y.contact_phone, y.detailed_address
        INTO v_bscontact, v_pho, v_add
        FROM mrp.mrp_temporary_supplier_archives y
       WHERE y.supplier_code = v_rec.supplier_code
         AND y.create_finished_product_supplier_code = v_supp_id;
      IF nvl(v_bscontact, '1') <> nvl(v_rec.business_contact, '1') THEN
        UPDATE mrp.mrp_temporary_supplier_archives u
           SET u.business_contact = v_rec.business_contact,
               u.update_time      = SYSDATE,
               u.update_id        = v_rec.create_id
         WHERE u.supplier_code = v_rec.supplier_code
           AND u.create_finished_product_supplier_code = v_supp_id;
        v_log_msg := ' 业务联系人：' || v_rec.business_contact || '【操作前：' ||
                     v_bscontact || '】 ';
      
      ELSE
        NULL;
      END IF;
    
      IF nvl(v_pho, '1') <> nvl(v_rec.contact_phone, '1') THEN
        UPDATE mrp.mrp_temporary_supplier_archives u
           SET u.contact_phone = v_rec.contact_phone,
               u.update_time   = SYSDATE,
               u.update_id     = v_rec.create_id
         WHERE u.supplier_code = v_rec.supplier_code
           AND u.create_finished_product_supplier_code = v_supp_id;
        v_log_msg := v_log_msg || '联系电话： ' || v_rec.contact_phone ||
                     '【操作前： ' || v_pho || '】 ';
      
      ELSE
        NULL;
      END IF;
    
      IF nvl(v_add, '1') <> nvl(v_rec.detailed_address, '1') THEN
        UPDATE mrp.mrp_temporary_supplier_archives u
           SET u.detailed_address = v_rec.detailed_address,
               u.update_time      = SYSDATE,
               u.update_id        = v_rec.create_id
         WHERE u.supplier_code = v_rec.supplier_code
           AND u.create_finished_product_supplier_code = v_supp_id;
      
        v_log_msg := v_log_msg || '公司详细地址：' || v_rec.detailed_address ||
                     '【操作前：' || v_add || '】';
      ELSE
        NULL;
      END IF;
    
      IF v_log_msg IS NOT NULL THEN
        INSERT INTO mrp.mrp_log
          (id, user_name, operate_content, operate, create_time, class_name,
           method_name, thirdpart_id)
        VALUES
          (plm.pkg_outside_material.f_get_mrp_keyid(pi_pre     => 1,
                                                    pi_owner   => 'PLM',
                                                    pi_seqname => 'SEQ_MRPPIC_ID',
                                                    pi_seqnum  => 99),
           v_ope_name, v_log_msg, 'update', SYSDATE, 'SCM-ODM报价管理', '创建物料信息',
           v_rec.supplier_code);
      ELSE
        NULL;
      END IF;
    END IF;
  
    --插入到报价物料表
    SELECT COUNT(1)
      INTO v_num
      FROM plm.material_detail_quotation t
     WHERE t.quotation_id = v_quotation_id;
    v_num2        := v_num + 1;
    v_material_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MATERIAL_DETAIL_QUOTATION',
                                                     v_column_name => 'MATERIAL_DETAIL_QUOTATION_ID',
                                                     v_pre         => v_quotation_id || 'WL',
                                                     v_serail_num  => 2);
    IF v_mijia IS NULL THEN
      v_unit2 := v_rec.unit;
    ELSE
      v_unit2 := '米';
    END IF;
    INSERT INTO plm.material_detail_quotation
      (material_detail_quotation_id, quotation_material_detail_no,
       quotation_material_type, whether_inner_material,
       quotation_material_sku, quotation_unit_price, quotation_unit,
       --quotation_loss_rate,
       --quotation_unit_price_consumption,
       quotation_amount, quotation_material_supplier_code, quotation_id,
       create_time, create_id, update_time, update_id, whether_del)
    VALUES
      (v_material_id, v_num2, '面料', 0, v_sku_id,
       nvl(v_mijia, v_rec.supplier_large_good_net_price), v_unit2, 0,
       (CASE WHEN v_rec.supplier_code = 'NEW' THEN v_supp_code ELSE
         v_rec.supplier_code END), v_quotation_id, SYSDATE, v_rec.create_id,
       SYSDATE, v_rec.create_id, 0);
  
    DELETE FROM mrp.mrp_outside_material_spu_ingredient_mapping_temp t
     WHERE t.temp_id = v_tem_id;
    DELETE FROM mrp.mrp_create_outside_material_sku_temp e
     WHERE e.temp_id = v_tem_id;
  
    scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                           p_apply_module       => 'a_quotation_110',
                                           p_base_table         => 'mrp.mrp_outside_material_spu',
                                           p_apply_pk_id        => v_quotation_id,
                                           p_action_type        => 'INSERT',
                                           p_log_id             => vo_log_id,
                                           p_log_type           => '01',
                                           p_log_msg            => '创建新物料:' ||
                                                                   v_sku_id,
                                           p_operate_field      => 'MATERIAL_DETAIL_QUOTATION_ID',
                                           p_field_type         => 'VARCHAR2',
                                           p_old_code           => NULL,
                                           p_new_code           => NULL,
                                           p_old_value          => 0,
                                           p_new_value          => 1,
                                           p_user_id            => v_rec.create_id,
                                           p_operate_company_id => v_rec.create_finished_product_supplier_code,
                                           p_seq_no             => 1,
                                           po_log_id            => vo_log_id,
                                           p_type               => 1);
  
    INSERT INTO mrp.mrp_log
      (id, user_name, operate_content, operate, create_time, thirdpart_id,
       class_name, method_name)
    VALUES
      (plm.pkg_outside_material.f_get_mrp_keyid(pi_pre     => 1,
                                                pi_owner   => 'PLM',
                                                pi_seqname => 'SEQ_MRPPIC_ID',
                                                pi_seqnum  => 99),
       v_ope_name, '创建新物料:' || v_sku_id, 'insert', SYSDATE, v_sku_id
       /*(CASE WHEN V_REC.SUPPLIER_CODE = 'NEW' THEN V_SUPP_CODE ELSE V_REC.SUPPLIER_CODE END)*/,
       'SCM-ODM报价管理', '创建物料信息');
  
    --END IF;
    --END IF;
  END p_ins_outmaterial_bysubmit;

  FUNCTION f_query_upd_materialdata(v_quo_material_id IN VARCHAR2)
    RETURN CLOB IS
    v_sql CLOB;
  BEGIN
    v_sql := '
SELECT ''' || v_quo_material_id ||
             ''' QUO_MATERIAL_ID,
       F.RESULT CATEGORY,
       A.MATERIAL_NAME,
       C.SUPPLIER_COLOR ,
       C.SUPPLIER_SHADES ,
       A.MATERIAL_SPU,
       A.UNIT,
       A.PRACTICAL_DOOR_WITH,
       A.GRAM_WEIGHT,
       C.DISPARITY,
       C.SUPPLIER_LARGE_GOOD_QUOTE,
       C.SUPPLIER_LARGE_GOOD_NET_PRICE NET_PRICE,
       A.MATERIAL_SPECIFICATIONS,
       FT.FUNCTION_TAG,
       (SELECT LISTAGG(TF.COMPANY_DICT_NAME, '';'') WITHIN GROUP(ORDER BY FT.MATERIAL_SPU)
          FROM SCMDATA.SYS_COMPANY_DICT TF
         WHERE INSTR('';'' || FT.FUNCTION_TAG || '';'',
                     '';'' || TF.COMPANY_DICT_ID || '';'') > 0
           AND TF.COMPANY_DICT_TYPE = ''MRP_MATERIAL_FUNCTION_TAG'') FUNCTION_ID,
       B.MATERIAL_SKU,
       D.SUPPLIER_CODE,
       D.SUPPLIER_NAME SUPPLIER_FABRIC,
       D.BUSINESS_CONTACT,
       D.CONTACT_PHONE CONTACT_PHONE_QU,
       D.DETAILED_ADDRESS,
       --TO_BLOB(NULL) FEATURES_FILE,
       --TO_BLOB(NULL) COLOR_FILE,
       --TO_BLOB(NULL) COLOR_CARD_FILE,
       --LISTAGG(P1.PICTURE_NAME, '','') WITHIN GROUP(ORDER BY 1) OVER(PARTITION BY P1.THIRDPART_ID) FEATURES_NAME,
       --LISTAGG(P2.PICTURE_NAME, '','') WITHIN GROUP(ORDER BY 1) OVER(PARTITION BY P2.THIRDPART_ID) COLOR_PICTURE_NAME,
       --LISTAGG(P3.PICTURE_NAME, '','') WITHIN GROUP(ORDER BY 1) OVER(PARTITION BY P3.THIRDPART_ID) COLOR_CARD_NAME,
       --P1.FILE_UNIQUE FEATURES_PICTURE_ID,
       --P2.FILE_UNIQUE COLOR_PICTURE_ID,
       --P3.FILE_UNIQUE COLOR_CARD_ID
       P1.PICTURE_NAME FEATURES_NAME,
       P2.FILE_UNIQUE COLOR_PICTURE_NAME,
       P3.PICTURE_NAME COLOR_CARD_NAME
  FROM  MRP.MRP_OUTSIDE_MATERIAL_SKU B
 INNER JOIN MRP.MRP_OUTSIDE_MATERIAL_SPU A
    ON A.MATERIAL_SPU = B.MATERIAL_SPU
   AND A.CREATE_FINISHED_SUPPLIER_CODE = B.CREATE_FINISHED_SUPPLIER_CODE
 INNER JOIN MRP.MRP_OUTSIDE_SUPPLIER_MATERIAL C
    ON B.MATERIAL_SKU = C.MATERIAL_SKU
 INNER JOIN MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES D
    ON C.SUPPLIER_CODE = D.SUPPLIER_CODE
   AND C.CREATE_FINISHED_SUPPLIER_CODE =
       D.CREATE_FINISHED_PRODUCT_SUPPLIER_CODE
  LEFT JOIN (SELECT P1.THIRDPART_ID,
     LISTAGG(P1.FILE_UNIQUE,'','')WITHIN GROUP(ORDER BY P1.THIRDPART_ID) PICTURE_NAME from  MRP.MRP_PICTURE P1
 WHERE P1.PICTURE_TYPE = 1
 GROUP BY P1.THIRDPART_ID) P1
    ON P1.THIRDPART_ID = A.MATERIAL_SPU
  LEFT JOIN MRP.MRP_PICTURE P2
    ON P2.THIRDPART_ID = B.MATERIAL_SKU
   AND P2.PICTURE_TYPE = 2
  LEFT JOIN (SELECT P3.THIRDPART_ID,
     LISTAGG(P3.FILE_UNIQUE,'','')WITHIN GROUP(ORDER BY P3.THIRDPART_ID) PICTURE_NAME  from  MRP.MRP_PICTURE P3
 WHERE P3.PICTURE_TYPE=3
 GROUP BY P3.THIRDPART_ID) P3
    ON P3.THIRDPART_ID = C.COLOR_CARD_PICTURE
  LEFT JOIN (SELECT T6.MATERIAL_SPU,
                    LISTAGG(T6.MATERIAL_FUNCTION_TAG_ID, '';'') WITHIN GROUP(ORDER BY T6.MATERIAL_SPU) FUNCTION_TAG
               FROM MRP.MRP_OUTSIDE_MATERIAL_SPU_FUNCTION_TAG_MAPPING T6
              GROUP BY T6.MATERIAL_SPU) FT
    ON FT.MATERIAL_SPU = A.MATERIAL_SPU
  LEFT JOIN (SELECT NVL(NVL(T4.COMPANY_DICT_ID, T3.COMPANY_DICT_ID),T2.COMPANY_DICT_ID) CATEGORY_ID,
                    (T1.COMPANY_DICT_NAME || ''/'' || T2.COMPANY_DICT_NAME ||  (CASE
                      WHEN T3.COMPANY_DICT_NAME IS NOT NULL THEN
                      ''/'' || T3.COMPANY_DICT_NAME
                      ELSE  NULL  END)
                     || (CASE   WHEN T4.COMPANY_DICT_NAME IS NOT NULL THEN
                      ''/'' || T4.COMPANY_DICT_NAME ELSE   NULL
                    END)) RESULT
               FROM SCMDATA.SYS_COMPANY_DICT T1
              LEFT JOIN SCMDATA.SYS_COMPANY_DICT T2
                 ON T1.COMPANY_ID = T2.COMPANY_ID
                AND T1.COMPANY_DICT_TYPE = ''MRP_MATERIAL_CLASSIFICATION''
                AND T2.COMPANY_DICT_TYPE = T1.COMPANY_DICT_VALUE
              LEFT JOIN SCMDATA.SYS_COMPANY_DICT T3
                 ON T2.COMPANY_ID = T3.COMPANY_ID
                AND T3.COMPANY_DICT_TYPE = T2.COMPANY_DICT_VALUE
                AND T3.PAUSE = 0
               LEFT JOIN SCMDATA.SYS_COMPANY_DICT T4
                 ON T3.COMPANY_ID = T4.COMPANY_ID
                AND T4.COMPANY_DICT_TYPE = T3.COMPANY_DICT_VALUE
                AND T4.PAUSE = 0) F
    ON F.CATEGORY_ID = A.MATERIAL_CLASSIFICATION
 WHERE B.MATERIAL_SKU =(SELECT t.quotation_material_sku
                          FROM plm.MATERIAL_DETAIL_QUOTATION t
                          WHERE  t.material_detail_quotation_id= ''' ||
             v_quo_material_id || ''')';
  
    RETURN v_sql;
  END f_query_upd_materialdata;

  PROCEDURE p_upd_outmaterial(v_spu_id      IN VARCHAR2,
                              v_sku_id      IN VARCHAR2,
                              v_supp_code   IN VARCHAR2,
                              v_com_id      IN VARCHAR2,
                              v_useid       IN VARCHAR2,
                              v_ma_name     IN VARCHAR2, --物料名称
                              v_color       IN VARCHAR2, --颜色
                              v_color_num   IN VARCHAR2, --色号
                              v_use_door_cm IN NUMBER, --实用门幅
                              v_kezhong     IN NUMBER, --克重
                              v_kongcha     IN NUMBER, --空差
                              v_dahuo_price IN NUMBER, --大货报价
                              v_spcifi      IN VARCHAR2, --规格
                              v_func_tag    IN VARCHAR2, --功能标签
                              v_contact     IN VARCHAR2, --联系人
                              v_phone       IN NUMBER, --联系电话
                              v_address     IN VARCHAR2, --地址
                              v_tezhengtu   IN VARCHAR2,
                              --V_TEZHENGTU_ID  IN VARCHAR2,
                              v_sekatu IN VARCHAR2,
                              --V_SEKATU_ID     IN VARCHAR2,
                              v_yanse IN VARCHAR2 --,
                              --V_YANSE_ID      IN VARCHAR2
                              ) IS
  
    --v_rec mrp.mrp_create_outside_material_sku_temp%ROWTYPE;
    v_cate_id      VARCHAR2(256);
    v_unit         VARCHAR2(256);
    v_dahuo_jinjia NUMBER;
    v_cate1        VARCHAR2(256);
    v_cate2        VARCHAR2(256);
    v_cate3        VARCHAR2(256);
    v_cate4        VARCHAR2(256);
    v_mijia        NUMBER;
    v_err          VARCHAR2(2000);
    p_mrp_pic_rec  mrp.mrp_picture%ROWTYPE;
    v_tezheng_num  INT;
    v_attachement  BLOB;
    v_file_size    NUMBER(20);
    v_yanse_num    INT;
    v_seka_num     INT;
    v_name         VARCHAR2(3000);
    v_supp_id      VARCHAR2(32);
    v_flag         NUMBER;
    v_flag2        NUMBER;
    v_exist_sku    VARCHAR2(64);
    v_spu          VARCHAR2(64);
    v_exist_spu    VARCHAR2(64);
  BEGIN
    SELECT b.material_classification, b.unit, b.material_spu
      INTO v_cate_id, v_unit, v_spu
      FROM mrp.mrp_outside_material_sku a
     INNER JOIN mrp.mrp_outside_material_spu b
        ON a.material_spu = b.material_spu
       AND a.create_finished_supplier_code =
           b.create_finished_supplier_code
     INNER JOIN mrp.mrp_outside_supplier_material c
        ON c.material_sku = a.material_sku
       AND c.create_finished_supplier_code =
           a.create_finished_supplier_code
     WHERE a.material_sku = v_sku_id
       AND c.supplier_code = v_supp_code;
  
    v_supp_id := plm.pkg_outside_material.f_get_suppinfo_id(v_current_compid => v_com_id,
                                                            v_need_compid    => 'b6cc680ad0f599cde0531164a8c0337f');
  
    --分类
    SELECT t1.company_dict_value category,
           t2.company_dict_value name1,
           t3.company_dict_value name2,
           t4.company_dict_value name4
      INTO v_cate1, v_cate2, v_cate3, v_cate4
      FROM scmdata.sys_company_dict t1
      LEFT JOIN scmdata.sys_company_dict t2
        ON t1.company_id = t2.company_id
       AND t1.company_dict_type = 'MRP_MATERIAL_CLASSIFICATION'
       AND t2.company_dict_type = t1.company_dict_value
      LEFT JOIN scmdata.sys_company_dict t3
        ON t2.company_id = t3.company_id
       AND t3.company_dict_type = t2.company_dict_value
      LEFT JOIN scmdata.sys_company_dict t4
        ON t3.company_id = t4.company_id
       AND t4.company_dict_type = t3.company_dict_value
     WHERE nvl(nvl(t4.company_dict_id, t3.company_dict_id),
               t2.company_dict_id) = v_cate_id;
  
    IF v_cate2 IN ('MRP_MATERIAL_CLASSIFICATION00020002',
                   'MRP_MATERIAL_CLASSIFICATION00020003',
                   'MRP_MATERIAL_CLASSIFICATION00020004',
                   'MRP_MATERIAL_CLASSIFICATION00020001') THEN
    
      SELECT COUNT(1), MAX(a.material_spu)
        INTO v_flag2, v_exist_spu
        FROM mrp.mrp_outside_material_spu a
       INNER JOIN mrp.mrp_outside_material_sku b
          ON a.material_spu = b.material_spu
       INNER JOIN mrp.mrp_outside_supplier_material c
          ON c.material_sku = b.material_sku
       WHERE a.material_name = v_ma_name
         AND c.create_finished_supplier_code = v_supp_id
         AND a.gram_weight = v_kezhong
         AND a.material_spu <> v_spu;
    
      IF v_flag2 > 0 THEN
        raise_application_error(-20002,
                                '已存在 ' || v_exist_spu ||
                                '对应当前【物料名称】，请前往【SPU加色】或【SKU加供】进行操作');
      
      ELSE
      
        SELECT COUNT(1), MAX(z.material_sku)
          INTO v_flag, v_exist_sku
          FROM mrp.mrp_outside_supplier_material z
         INNER JOIN mrp.mrp_outside_material_sku b
            ON b.material_sku = z.material_sku
           AND b.create_finished_supplier_code =
               z.create_finished_supplier_code
         INNER JOIN mrp.mrp_outside_material_spu a
            ON a.material_spu = b.material_spu
         WHERE z.supplier_code = v_supp_code
           AND z.create_finished_supplier_code = v_supp_id
           AND z.supplier_color = v_color
           AND z.supplier_material_name = v_ma_name
           AND a.gram_weight = v_kezhong
           AND z.material_sku <> v_sku_id;
      
        IF v_flag > 0 THEN
          raise_application_error(-20002,
                                  '已存在 ' || v_exist_sku ||
                                  '对应当前物料，请前往选择已有面料进行操作');
        ELSE
          NULL;
        END IF;
      END IF;
    ELSE
      SELECT COUNT(1), MAX(a.material_spu)
        INTO v_flag2, v_exist_spu
        FROM mrp.mrp_outside_material_spu a
       INNER JOIN mrp.mrp_outside_material_sku b
          ON a.material_spu = b.material_spu
       INNER JOIN mrp.mrp_outside_supplier_material c
          ON c.material_sku = b.material_sku
       WHERE a.material_name = v_ma_name
         AND c.create_finished_supplier_code = v_supp_id
         AND a.material_specifications = v_spcifi
         AND a.material_spu <> v_spu;
    
      IF v_flag2 > 0 THEN
        raise_application_error(-20002,
                                '已存在 ' || v_exist_spu ||
                                '对应当前【物料名称】，请前往【SPU加色】或【SKU加供】进行操作');
      
      ELSE
      
        SELECT COUNT(1), MAX(z.material_sku)
          INTO v_flag, v_exist_sku
          FROM mrp.mrp_outside_supplier_material z
         INNER JOIN mrp.mrp_outside_material_sku b
            ON b.material_sku = z.material_sku
           AND b.create_finished_supplier_code =
               z.create_finished_supplier_code
         INNER JOIN mrp.mrp_outside_material_spu a
            ON a.material_spu = b.material_spu
         WHERE z.supplier_code = v_supp_code
           AND z.create_finished_supplier_code = v_supp_id
           AND z.supplier_color = v_color
           AND z.supplier_material_name = v_ma_name
           AND a.material_specifications = v_spcifi
           AND z.material_sku <> v_sku_id;
      
        IF v_flag > 0 THEN
          raise_application_error(-20002,
                                  '已存在 ' || v_exist_sku ||
                                  '对应当前物料，请前往选择已有面料进行操作');
        ELSE
          NULL;
        END IF;
      END IF;
    
    END IF;
  
    --校验必填项等
    IF v_phone IS NULL THEN
      v_err := v_err || '【业务联系电话】';
    END IF;
  
    IF v_cate2 IN ('MRP_MATERIAL_CLASSIFICATION00020002',
                   'MRP_MATERIAL_CLASSIFICATION00020003',
                   'MRP_MATERIAL_CLASSIFICATION00020004',
                   'MRP_MATERIAL_CLASSIFICATION00020001') THEN
      IF v_use_door_cm IS NULL THEN
        v_err := v_err || ' 【实用门幅】';
      END IF;
      IF v_kezhong IS NULL THEN
        v_err := v_err || ' 【克重】 ';
      
        --ELSIF V_KONGCHA IS NULL THEN
        --V_ERR := V_ERR || ' 【空差】 ';
      END IF;
    
    ELSE
      IF v_spcifi IS NULL THEN
        --raise_application_error(-20002,'必填项 【物料规格】 未填！');
        v_err := v_err || ' 【物料规格】';
      ELSE
        NULL;
      END IF;
      IF lengthb(v_err) > 16 THEN
        v_err := v_err || '【业务联系电话】字节长度过长';
      END IF;
    END IF;
    IF v_err IS NOT NULL THEN
      raise_application_error(-20002, '必填项 ' || v_err);
    ELSE
      NULL;
    END IF;
    --大货净价
    IF v_unit = '公斤' THEN
      v_dahuo_jinjia := round(v_dahuo_price / 25 * (25 + nvl(v_kongcha, 0)),
                              1);
    ELSIF v_unit = '米' THEN
      IF v_kongcha = 0 THEN
        v_dahuo_jinjia := 0;
      ELSE
        v_dahuo_jinjia := round(v_dahuo_price / (nvl(v_kongcha, 100) / 100),
                                1);
      END IF;
    ELSE
      v_dahuo_jinjia := v_dahuo_price;
    END IF;
  
    --优选大货米价
  
    --优选大货米价
    IF v_unit = '米' AND v_cate1 = 'MRP_MATERIAL_CLASSIFICATION0002' THEN
      v_mijia := v_dahuo_jinjia;
    ELSIF v_unit = '公斤' AND
          v_cate2 IN ('MRP_MATERIAL_CLASSIFICATION00020002',
                      'MRP_MATERIAL_CLASSIFICATION00020001') THEN
      v_mijia := trunc(v_dahuo_jinjia /
                       round((1 / ((v_use_door_cm + 5) / 100) /
                             (v_kezhong / 1000)),
                             2),
                       1);
    ELSIF v_unit = '罗' AND v_cate1 = 'MRP_MATERIAL_CLASSIFICATION0002' THEN
      v_mijia := trunc((v_dahuo_jinjia / 131.7), 2);
    ELSE
      v_mijia := NULL;
    END IF;
  
    --供应商信息
    UPDATE mrp.mrp_temporary_supplier_archives t
       SET t.business_contact = v_contact,
           t.contact_phone    = v_phone,
           t.detailed_address = v_address,
           t.update_time      = SYSDATE,
           t.update_id        = v_useid
     WHERE t.supplier_code = v_supp_code;
  
    --spu
    UPDATE mrp.mrp_outside_material_spu a
       SET a.gram_weight             = v_kezhong,
           a.material_name           = v_ma_name,
           a.practical_door_with     = v_use_door_cm,
           a.material_specifications = v_spcifi,
           a.update_id               = v_useid,
           a.update_time             = SYSDATE
     WHERE a.material_spu = v_spu_id;
  
    --功能标签
    IF v_func_tag IS NOT NULL THEN
      DELETE FROM mrp.mrp_outside_material_spu_function_tag_mapping b
       WHERE b.material_spu = v_spu_id;
      IF instr(v_func_tag, ';') > 0 THEN
        FOR b IN (SELECT regexp_substr(v_func_tag, '[^;]+', 1, rownum) fun_id
                    FROM dual
                  CONNECT BY rownum <=
                             length(v_func_tag) -
                             length(REPLACE(v_func_tag, ';', '')) + 1) LOOP
        
          INSERT INTO mrp.mrp_outside_material_spu_function_tag_mapping
            (function_tag_mapping_id, material_spu,
             material_function_tag_id)
          VALUES
            (f_get_mrp_keyid(pi_pre     => 1,
                             pi_owner   => 'PLM',
                             pi_seqname => 'SEQ_MRPPIC_ID',
                             pi_seqnum  => 99), v_spu_id, b.fun_id);
        END LOOP;
      ELSE
        INSERT INTO mrp.mrp_outside_material_spu_function_tag_mapping
          (function_tag_mapping_id, material_spu, material_function_tag_id)
        VALUES
          (f_get_mrp_keyid(pi_pre     => 1,
                           pi_owner   => 'PLM',
                           pi_seqname => 'SEQ_MRPPIC_ID',
                           pi_seqnum  => 99), v_spu_id, v_func_tag);
      END IF;
    ELSE
      NULL;
    END IF;
    --sku
    UPDATE mrp.mrp_outside_material_sku c
       SET c.preferred_net_price_of_large_good       = v_dahuo_jinjia,
           c.preferred_per_meter_price_of_large_good = v_mijia,
           c.material_color                          = v_color,
           c.update_time                             = SYSDATE,
           c.update_id                               = v_useid
     WHERE c.material_sku = v_sku_id;
  
    --
    UPDATE mrp.mrp_outside_supplier_material d
       SET d.supplier_material_name        = v_ma_name,
           d.supplier_color                = v_color,
           d.supplier_shades               = v_color_num,
           d.disparity                     = v_kongcha,
           d.supplier_large_good_quote     = v_dahuo_price,
           d.supplier_large_good_net_price = v_dahuo_jinjia,
           d.update_time                   = SYSDATE,
           d.update_id                     = v_useid
     WHERE d.supplier_code = v_supp_code
       AND d.material_sku = v_sku_id
       AND d.create_finished_supplier_code = v_supp_id;
    --是否有特征图
    BEGIN
      SELECT COUNT(1)
        INTO v_tezheng_num
        FROM mrp.mrp_picture t
       WHERE t.thirdpart_id = v_spu_id
         AND t.picture_type = 1;
    
      IF v_tezheng_num > 0 THEN
        IF v_tezhengtu IS NULL /*AND V_TEZHENGTU_ID IS NULL*/
         THEN
          --删除特征图
          DELETE FROM mrp.mrp_picture
           WHERE thirdpart_id = v_spu_id
             AND picture_type = 1;
        
        ELSE
          /*V_TEZHENGTU_ID IS NOT NULL THEN */
        
          --删掉旧值再重新插入
          DELETE FROM mrp.mrp_picture
           WHERE thirdpart_id = v_spu_id
             AND picture_type = 1;
        
          FOR a IN (SELECT *
                      FROM scmdata.file_info t
                     WHERE instr(',' || v_tezhengtu || ',',
                                 ',' || t.file_unique || ',') > 0) LOOP
          
            plm.pkg_plat_comm.p_get_file_info(p_file_unique => a.file_unique,
                                              po_file_name  => v_name,
                                              po_file_size  => v_file_size,
                                              po_attachment => v_attachement);
            p_mrp_pic_rec.thirdpart_id := v_spu_id;
            p_mrp_pic_rec.picture_name := v_name;
            p_mrp_pic_rec.source_name  := v_name;
            p_mrp_pic_rec.url          := ' ';
            p_mrp_pic_rec.upload_time  := SYSDATE;
            p_mrp_pic_rec.picture_type := 1;
            p_mrp_pic_rec.file_blob    := v_attachement;
            p_mrp_pic_rec.file_unique  := a.file_unique;
            p_mrp_pic_rec.file_size    := v_file_size;
          
            plm.pkg_outside_material.p_ins_mrp_pic(pi_mrp_pic => p_mrp_pic_rec);
          
          END LOOP;
        END IF;
      ELSE
        IF v_tezhengtu IS NOT NULL THEN
          --新增图片
          FOR a IN (SELECT *
                      FROM scmdata.file_info t
                     WHERE instr(',' || v_tezhengtu || ',',
                                 ',' || t.file_unique || ',') > 0) LOOP
            plm.pkg_plat_comm.p_get_file_info(p_file_unique => a.file_unique,
                                              po_file_name  => v_name,
                                              po_file_size  => v_file_size,
                                              po_attachment => v_attachement);
            p_mrp_pic_rec.thirdpart_id := v_spu_id;
            p_mrp_pic_rec.picture_name := v_name;
            p_mrp_pic_rec.source_name  := v_name;
            p_mrp_pic_rec.url          := ' ';
            p_mrp_pic_rec.upload_time  := SYSDATE;
            p_mrp_pic_rec.picture_type := 1;
            p_mrp_pic_rec.file_blob    := v_attachement;
            p_mrp_pic_rec.file_unique  := a.file_unique;
            p_mrp_pic_rec.file_size    := v_file_size;
          
            plm.pkg_outside_material.p_ins_mrp_pic(pi_mrp_pic => p_mrp_pic_rec);
          
          END LOOP;
        
        ELSE
          NULL;
        END IF;
      END IF;
    END feacture_pic;
  
    BEGIN
      --是否有颜色图
      SELECT COUNT(1)
        INTO v_yanse_num
        FROM mrp.mrp_picture t
       WHERE t.thirdpart_id = v_sku_id
         AND t.picture_type = 2;
    
      p_mrp_pic_rec.upload_time  := SYSDATE;
      p_mrp_pic_rec.picture_type := 2;
      p_mrp_pic_rec.thirdpart_id := v_sku_id;
    
      IF v_yanse IS NULL AND v_yanse_num > 0 THEN
        --删除颜色
        DELETE FROM mrp.mrp_picture
         WHERE thirdpart_id = v_sku_id
           AND picture_type = 2;
      ELSE
        IF v_yanse IS NOT NULL THEN
          /*SELECT V.ATTACHMENT, V.FILE_SIZE
           INTO V_ATTACHEMENT, V_FILE_SIZE
           FROM (SELECT A.ATTACHMENT, A.FILE_SIZE
                   FROM SCMDATA.FILE_DATA A
                  WHERE A.FILE_ID = V_YANSE_ID
                  ORDER BY A.LASTUPDATETIME DESC) V
          WHERE ROWNUM < 2;*/
          plm.pkg_plat_comm.p_get_file_info(p_file_unique => v_yanse,
                                            po_file_name  => v_name,
                                            po_file_size  => v_file_size,
                                            po_attachment => v_attachement);
          p_mrp_pic_rec.thirdpart_id := v_sku_id;
          p_mrp_pic_rec.picture_name := v_name;
          p_mrp_pic_rec.source_name  := v_name;
          p_mrp_pic_rec.url          := ' ';
          p_mrp_pic_rec.file_blob    := v_attachement;
          p_mrp_pic_rec.file_unique  := v_yanse;
          p_mrp_pic_rec.file_size    := v_file_size;
          IF v_yanse_num > 0 THEN
            --更新
            plm.pkg_outside_material.p_upd_mrp_pic(p_mrp_pic_rec => p_mrp_pic_rec);
          ELSE
            --插入
            plm.pkg_outside_material.p_ins_mrp_pic(pi_mrp_pic => p_mrp_pic_rec);
          END IF;
        ELSE
          NULL;
        END IF;
      END IF;
    END color_pic;
  
    BEGIN
      SELECT COUNT(1)
        INTO v_seka_num
        FROM mrp.mrp_picture t
       WHERE t.thirdpart_id = v_supp_code || v_sku_id || v_supp_id
         AND t.picture_type = 3;
      IF v_seka_num > 0 THEN
        IF v_sekatu IS NULL /*AND V_SEKATU_ID IS NULL*/
         THEN
          --删除色卡图
          DELETE FROM mrp.mrp_picture
           WHERE thirdpart_id = v_supp_code || v_sku_id
             AND picture_type = 3;
        
        ELSE
          /*V_SEKATU_ID IS NOT NULL THEN */
        
          --删掉旧值再重新插入
          DELETE FROM mrp.mrp_picture
           WHERE thirdpart_id = v_supp_code || v_sku_id
             AND picture_type = 3;
        
          FOR a IN (SELECT *
                      FROM scmdata.file_info t
                     WHERE instr(',' || v_sekatu || ',',
                                 ',' || t.file_unique || ',') > 0) LOOP
          
            plm.pkg_plat_comm.p_get_file_info(p_file_unique => a.file_unique,
                                              po_file_name  => v_name,
                                              po_file_size  => v_file_size,
                                              po_attachment => v_attachement);
            p_mrp_pic_rec.thirdpart_id := v_supp_code || v_sku_id ||
                                          v_supp_id;
            p_mrp_pic_rec.picture_name := v_name;
            p_mrp_pic_rec.source_name  := v_name;
            p_mrp_pic_rec.url          := ' ';
            p_mrp_pic_rec.upload_time  := SYSDATE;
            p_mrp_pic_rec.picture_type := 1;
            p_mrp_pic_rec.file_blob    := v_attachement;
            p_mrp_pic_rec.file_unique  := a.file_unique;
            p_mrp_pic_rec.file_size    := v_file_size;
          
            plm.pkg_outside_material.p_ins_mrp_pic(pi_mrp_pic => p_mrp_pic_rec);
          
          END LOOP;
        END IF;
      ELSE
        IF v_sekatu IS NOT NULL THEN
          --新增图片
          FOR a IN (SELECT *
                      FROM scmdata.file_info t
                     WHERE instr(',' || v_sekatu || ',',
                                 ',' || t.file_unique || ',') > 0) LOOP
            plm.pkg_plat_comm.p_get_file_info(p_file_unique => a.file_unique,
                                              po_file_name  => v_name,
                                              po_file_size  => v_file_size,
                                              po_attachment => v_attachement);
            p_mrp_pic_rec.thirdpart_id := v_supp_code || v_sku_id ||
                                          v_supp_id;
            p_mrp_pic_rec.picture_name := v_name;
            p_mrp_pic_rec.source_name  := v_name;
            p_mrp_pic_rec.url          := ' ';
            p_mrp_pic_rec.upload_time  := SYSDATE;
            p_mrp_pic_rec.picture_type := 3;
            p_mrp_pic_rec.file_blob    := v_attachement;
            p_mrp_pic_rec.file_unique  := a.file_unique;
            p_mrp_pic_rec.file_size    := v_file_size;
          
            plm.pkg_outside_material.p_ins_mrp_pic(pi_mrp_pic => p_mrp_pic_rec);
          
          END LOOP;
        
        ELSE
          NULL;
        END IF;
      END IF;
    
    END seka_pic;
  
  END p_upd_outmaterial;

  PROCEDURE p_delete_material_detail(p_comp_id      IN VARCHAR2,
                                     p_user_id      IN VARCHAR2,
                                     p_material_rec plm.material_detail_quotation%ROWTYPE) IS
  
    v_amount NUMBER;
  BEGIN
    --操作日志
    DECLARE
      v_uq_id          VARCHAR2(32);
      vo_log_id        VARCHAR2(32);
      v_sup_company_id VARCHAR2(32);
    
    BEGIN
      SELECT MAX(t.platform_unique_key)
        INTO v_uq_id
        FROM plm.quotation t
       WHERE t.quotation_id = p_material_rec.quotation_id;
    
      v_sup_company_id := plm.pkg_quotation.f_get_sup_company_id_by_uqid(p_company_id => p_comp_id,
                                                                         p_uq_id      => v_uq_id);
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => p_comp_id,
                                             p_apply_module       => 'a_quotation_111_1',
                                             p_base_table         => 'material_detail_quotation',
                                             p_apply_pk_id        => p_material_rec.quotation_id,
                                             p_action_type        => 'DELETE',
                                             p_log_type           => '01',
                                             p_field_desc         => '删除物料明细',
                                             p_log_msg            => '删除物料明细：' ||
                                                                     p_material_rec.quotation_material_sku,
                                             p_operate_field      => 'MATERIAL_DETAIL_QUOTATION_ID',
                                             p_field_type         => 'VARCHAR',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => 1,
                                             p_new_value          => 0,
                                             p_user_id            => p_user_id,
                                             p_operate_company_id => v_sup_company_id,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id,
                                             p_type               => 1);
    
    END record_plat_log;
  
    DELETE FROM plm.material_detail_quotation t
     WHERE t.material_detail_quotation_id =
           p_material_rec.material_detail_quotation_id
       AND t.quotation_id = p_material_rec.quotation_id;
  
    SELECT SUM(y.quotation_amount)
      INTO v_amount
      FROM plm.material_detail_quotation y
     WHERE y.quotation_id = p_material_rec.quotation_id;
    UPDATE plm.quotation t
       SET t.material_amount = v_amount
     WHERE t.quotation_id = p_material_rec.quotation_id;
  
  END p_delete_material_detail;

  PROCEDURE p_submit_material_detail(v_quoid    IN VARCHAR2,
                                     po_err_msg OUT VARCHAR2) IS
  
    v_count   NUMBER;
    v_err_msg VARCHAR2(3000);
    v_count1  NUMBER := 0;
    v_count2  NUMBER := 0;
    v_count3  NUMBER := 0;
    v_count4  NUMBER := 0;
    v_count5  NUMBER := 0;
  BEGIN
  
    SELECT COUNT(1)
      INTO v_count5
      FROM plm.material_detail_quotation a
     WHERE a.quotation_id = v_quoid
       AND a.whether_del = 0;
    IF v_count5 = 0 THEN
      v_err_msg := '【物料明细】TAB页中无物料SKU信息,请添加';
    ELSE
      FOR i IN (SELECT a.*
                  FROM plm.material_detail_quotation a
                 WHERE a.quotation_id = v_quoid
                   AND a.whether_del = 0) LOOP
        IF i.quotation_unit_price IS NULL THEN
          v_count1 := v_count1 + 1;
        END IF;
      
        IF i.quotation_unit_price_consumption IS NULL THEN
          v_count2 := v_count2 + 1;
        END IF;
        IF i.quotation_loss_rate IS NULL THEN
          v_count3 := v_count3 + 1;
        END IF;
      
        IF i.quotation_material_sku IS NULL THEN
          --V_ERR_MSG:= '【物料明细】中无物料SKU，请删除后重新操作【创建新物料】';
          v_count4 := v_count4 + 1;
        END IF;
      
      END LOOP;
    END IF;
    IF v_count1 > 0 THEN
      v_err_msg := '“单价（元）”';
    END IF;
    IF v_count2 > 0 THEN
      v_err_msg := v_err_msg || '“单件用量” ';
    END IF;
    IF v_count3 > 0 THEN
      v_err_msg := v_err_msg || '“损耗率” ';
    END IF;
    IF v_count4 > 0 THEN
      v_err_msg := '【物料明细】TAB页中无物料SKU，请删除后重新操作【创建新物料】';
    END IF;
  
    IF v_err_msg IS NOT NULL AND instr(v_err_msg, '物料SKU') > 0 THEN
      v_err_msg := v_err_msg || ';';
    ELSIF v_err_msg IS NOT NULL AND instr(v_err_msg, '添加') = 0 THEN
      v_err_msg := '【物料明细】TAB页中必填项' || v_err_msg || '未填;';
    ELSE
      v_err_msg := NULL;
    END IF;
  
    --是否内部物料
    SELECT COUNT(1)
      INTO v_count
      FROM plm.material_detail_quotation b
     WHERE b.quotation_id = v_quoid
       AND b.whether_del = 0
       AND b.whether_inner_material = 1;
  
    IF v_count > 0 THEN
      UPDATE plm.quotation t
         SET t.whether_sanfu_fabric = 1
       WHERE t.quotation_id = v_quoid;
    ELSE
      UPDATE plm.quotation t
         SET t.whether_sanfu_fabric = 0
       WHERE t.quotation_id = v_quoid;
    END IF;
  
    /* UPDATE PLM.QUOTATION T
      SET T.MATERIAL_AMOUNT = (SELECT SUM(QUOTATION_AMOUNT) FROM PLM.MATERIAL_DETAIL_QUOTATION A WHERE A.quotation_id = V_QUOID)
    WHERE T.QUOTATION_ID = V_QUOID; */
    po_err_msg := v_err_msg;
  
  END p_submit_material_detail;

  PROCEDURE p_add_color_quotation(v_color  IN VARCHAR2,
                                  v_quo_id IN VARCHAR2,
                                  v_cre_id IN VARCHAR2) IS
    v_new_quoid                         VARCHAR2(32);
    v_num                               NUMBER;
    v_num2                              NUMBER;
    v_num3                              NUMBER;
    v_num4                              NUMBER;
    v_num5                              NUMBER;
    v_num6                              NUMBER;
    v_material_id                       VARCHAR2(32);
    v_count                             NUMBER;
    v_count2                            NUMBER;
    v_consumables_name_id               VARCHAR2(32);
    v_quotation_special_craft_detail_id VARCHAR2(32);
  BEGIN
    /*IF V_COLOR IS NULL THEN
     RAISE_APPLICATION_ERROR(-20002,'颜色为必填项！');
    ELSE*/
  
    --新生成的报价单ID
    v_new_quoid := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'QUOTATION',
                                                   v_column_name => 'QUOTATION_ID',
                                                   v_pre         => 'BJ' ||
                                                                    to_char(SYSDATE,
                                                                            'YYYYMMDD'),
                                                   v_serail_num  => 3);
    --新增报价单
  
    INSERT INTO plm.quotation
      (quotation_id, quotation_status, create_time, create_id, update_time,
       update_id, cooperation_mode, quotation_source, whether_sanfu_fabric,
       whether_add_color_quotation, related_colored_quotation,
       quotation_total, material_amount, consumables_amount, craft_amount,
       working_procedure_amount, other_amount, affreightment_amount,
       platform_unique_key, item_no, color, sanfu_article_no,
       quotation_classification, paper_quotation_picture, style_picture,
       pattern_file, marker_file, consumables_quotation_classification,
       consumables_combination_no, consumables_combination_name,
       consumables_total_amount, consumables_quotation_remark,
       working_procedure_machining_total, crop_salary, skiving_salary,
       forming_salary, working_procedure_machining_remark,
       bag_paper_lattice_number, management_expense, development_fee,
       euipment_depreciation, rent_and_utilities, processing_profit, freight,
       design_fee, whether_del, final_quotation)
      SELECT v_new_quoid                            AS quotation_id,
             0,
             SYSDATE,
             v_cre_id,
             SYSDATE,
             v_cre_id,
             a.cooperation_mode,
             a.quotation_source,
             a.whether_sanfu_fabric,
             1,
             a.quotation_id,
             a.quotation_total,
             a.material_amount,
             a.consumables_amount,
             a.craft_amount,
             a.working_procedure_amount,
             a.other_amount,
             a.affreightment_amount,
             a.platform_unique_key,
             a.item_no,
             v_color                                AS color,
             a.sanfu_article_no,
             a.quotation_classification,
             a.paper_quotation_picture,
             a.style_picture,
             a.pattern_file,
             a.marker_file,
             a.consumables_quotation_classification,
             a.consumables_combination_no,
             a.consumables_combination_name,
             a.consumables_total_amount,
             a.consumables_quotation_remark,
             a.working_procedure_machining_total,
             a.crop_salary,
             a.skiving_salary,
             a.forming_salary,
             a.working_procedure_machining_remark,
             a.bag_paper_lattice_number,
             a.management_expense,
             a.development_fee,
             a.euipment_depreciation,
             a.rent_and_utilities,
             a.processing_profit,
             a.freight,
             a.design_fee,
             0                                      whether_del,
             a.final_quotation
        FROM plm.quotation a
       WHERE a.quotation_id = v_quo_id;
  
    --新增物料明细
    FOR a IN (SELECT *
                FROM plm.material_detail_quotation t
               WHERE t.quotation_id = v_quo_id
                 AND t.whether_del = 0) LOOP
    
      --物料明细id
      SELECT COUNT(1)
        INTO v_num
        FROM plm.material_detail_quotation t
       WHERE t.quotation_id = v_new_quoid
         AND t.whether_del = 0;
    
      v_num2        := v_num + 1;
      v_material_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MATERIAL_DETAIL_QUOTATION',
                                                       v_column_name => 'MATERIAL_DETAIL_QUOTATION_ID',
                                                       v_pre         => v_new_quoid || 'WL',
                                                       v_serail_num  => 2);
    
      INSERT INTO plm.material_detail_quotation
        (material_detail_quotation_id,
         related_colored_material_detail_quotation_id,
         quotation_material_detail_no, quotation_material_type,
         quotation_application_site, whether_inner_material,
         quotation_material_sku, quotation_material_supplier_code,
         quotation_unit, quotation_unit_price,
         quotation_unit_price_consumption, quotation_loss_rate,
         quotation_amount, quotation_remark, quotation_id, create_time,
         create_id, update_time, update_id)
      VALUES
        (v_material_id, a.material_detail_quotation_id, v_num2,
         a.quotation_material_type, a.quotation_application_site,
         a.whether_inner_material, a.quotation_material_sku,
         a.quotation_material_supplier_code, a.quotation_unit,
         a.quotation_unit_price, a.quotation_unit_price_consumption,
         a.quotation_loss_rate, a.quotation_amount, a.quotation_remark,
         v_new_quoid, SYSDATE, v_cre_id, SYSDATE, v_cre_id);
      v_num2 := 0;
      v_num  := 0;
    
    END LOOP;
  
    --是否有耗材组合明细
    SELECT COUNT(1)
      INTO v_count
      FROM plm.consumables_consumption_detail t
     WHERE t.quotation_id = v_quo_id
       AND t.whether_del = 0;
  
    IF v_count > 0 THEN
      --新增耗材组合明细
      FOR b IN (SELECT *
                  FROM plm.consumables_consumption_detail t
                 WHERE t.quotation_id = v_quo_id /*AND T.WHETHER_DEL =0*/
                ) LOOP
      
        v_consumables_name_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'CONSUMABLES_CONSUMPTION_DETAIL',
                                                                 v_column_name => 'CONSUMABLES_NAME_ID',
                                                                 v_pre         => v_new_quoid || 'HC',
                                                                 v_serail_num  => 2);
        SELECT COUNT(1)
          INTO v_num3
          FROM plm.material_detail_quotation t
         WHERE t.quotation_id = v_new_quoid
           AND t.whether_del = 0;
      
        v_num4 := v_num3 + 1;
        INSERT INTO plm.consumables_consumption_detail
          (consumables_name_id, consumables_material_no,
           consumables_material_name, consumables_material_source,
           consumables_material_consumption, consumables_material_unit,
           suggested_purchase_unit_price, consumables_material_sku,
           consumables_material_supplier_code, suggested_purchase__price,
           quotation_id, create_time, create_id, update_time, update_id)
        VALUES
          (v_consumables_name_id, v_num4, b.consumables_material_name,
           b.consumables_material_source, b.consumables_material_consumption,
           b.consumables_material_unit, b.suggested_purchase_unit_price,
           b.consumables_material_sku, b.consumables_material_supplier_code,
           b.suggested_purchase__price, v_new_quoid, SYSDATE, v_cre_id,
           SYSDATE, v_cre_id);
        v_num4 := 0;
        v_num3 := 0;
      END LOOP;
    ELSE
      NULL;
    END IF;
    --特殊工艺报价
    FOR c IN (SELECT *
                FROM plm.special_craft_quotation t
               WHERE t.quotation_id = v_quo_id
                 AND t.whether_del = 0) LOOP
      v_quotation_special_craft_detail_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'SPECIAL_CRAFT_QUOTATION',
                                                                             v_column_name => 'QUOTATION_SPECIAL_CRAFT_DETAIL_ID',
                                                                             v_pre         => v_new_quoid || 'GY',
                                                                             v_serail_num  => 2);
    
      SELECT COUNT(1)
        INTO v_num5
        FROM plm.special_craft_quotation t
       WHERE t.quotation_id = v_new_quoid
         AND t.whether_del = 0;
    
      v_num6 := v_num5 + 1;
      INSERT INTO plm.special_craft_quotation
        (quotation_special_craft_detail_id, related_colored_detail_id,
         quotation_special_craft_detail_no, craft_classification,
         craft_unit_price, craft_consumption, craft_price, washing_percent,
         craft_factory_name, craft_quotation_remark, quotation_id,
         create_time, create_id, update_time, update_id)
      VALUES
        (v_quotation_special_craft_detail_id,
         c.quotation_special_craft_detail_id, v_num6, c.craft_classification,
         c.craft_unit_price, c.craft_consumption, c.craft_price,
         c.washing_percent, c.craft_factory_name, c.craft_quotation_remark,
         v_new_quoid, SYSDATE, v_cre_id, SYSDATE, v_cre_id);
      v_num5 := 0;
      v_num6 := 0;
    
    END LOOP;
  
    --鞋
    SELECT COUNT(1)
      INTO v_count2
      FROM plm.shoes_fee t
     WHERE t.quotation_id = v_quo_id
       AND t.whether_del = 0;
  
    IF v_count2 > 0 THEN
      INSERT INTO plm.shoes_fee
        (shoe_fee_id, shoe_craft_category, shoe_packing_type,
         shoe_packing_number, shoe_transportation_route,
         shoe_box_material_name, shoe_box_specifications, shoe_box_amount,
         shoe_box_quotation_remark, egg_lattice_amount,
         egg_lattice_quotation_remark, outer_box_amount,
         outer_box_quotation_remark, freight, freight_quotation_remark,
         quotation_id, create_time, create_id, update_time, update_id)
        SELECT v_new_quoid,
               t.shoe_craft_category,
               t.shoe_packing_type,
               t.shoe_packing_number,
               t.shoe_transportation_route,
               t.shoe_box_material_name,
               t.shoe_box_specifications,
               t.shoe_box_amount,
               t.shoe_box_quotation_remark,
               t.egg_lattice_amount,
               t.egg_lattice_quotation_remark,
               t.outer_box_amount,
               t.outer_box_quotation_remark,
               t.freight,
               t.outer_box_quotation_remark,
               v_new_quoid,
               SYSDATE,
               v_cre_id,
               SYSDATE,
               v_cre_id
          FROM plm.shoes_fee t
         WHERE t.quotation_id = v_quo_id;
    
    ELSE
      NULL;
    END IF;
  
    --附件
    FOR d IN (SELECT * FROM plm.plm_file t WHERE t.thirdpart_id = v_quo_id) LOOP
      INSERT INTO plm.plm_file
        (file_id, thirdpart_id, file_name, source_name, url, bucket,
         upload_time, file_type, file_blob, file_unique, file_size
         /*,
                           new_column*/)
      VALUES
        (plm.pkg_plat_comm.f_get_uuid(), v_new_quoid, d.file_name,
         d.source_name, d.url, d.bucket, SYSDATE, d.file_type, d.file_blob,
         d.file_unique, d.file_size /*, d.new_column*/);
    
    END LOOP;
  
    --END IF;
  END p_add_color_quotation;

  --获取供应商核价内外部物料 物料分类、成分、克重 czh add
  PROCEDURE p_get_material_data(p_material_sku      VARCHAR2,
                                p_is_inner_material INT,
                                po_material_class   OUT VARCHAR2,
                                po_ingredients      OUT VARCHAR2,
                                po_gram_weight      OUT VARCHAR2,
                                po_material_spu     OUT VARCHAR2,
                                po_material_sku     OUT VARCHAR2) IS
    vo_material_class VARCHAR2(32);
    vo_ingredients    VARCHAR2(32);
    vo_gram_weight    VARCHAR2(32);
    vo_material_spu   VARCHAR2(32);
    vo_material_sku   VARCHAR2(32);
  BEGIN
    --判断是否内部物料
    IF p_is_inner_material = 1 THEN
      SELECT MAX(spu.material_classification),
             MAX(spu.ingredients),
             MAX(spu.gram_weight),
             MAX(spu.material_spu),
             MAX(material_sku)
        INTO vo_material_class,
             vo_ingredients,
             vo_gram_weight,
             vo_material_spu,
             vo_material_sku
        FROM mrp.mrp_internal_material_sku sku
       INNER JOIN mrp.mrp_internal_material_spu spu
          ON spu.material_spu = sku.material_spu
       WHERE sku.material_sku = p_material_sku;
    
    ELSIF p_is_inner_material = 0 THEN
      SELECT MAX(spu.material_classification),
             MAX(spu.ingredients),
             MAX(spu.gram_weight),
             MAX(spu.material_spu),
             MAX(sku.material_sku)
        INTO vo_material_class,
             vo_ingredients,
             vo_gram_weight,
             vo_material_spu,
             vo_material_sku
        FROM mrp.mrp_outside_material_sku sku
       INNER JOIN mrp.mrp_outside_material_spu spu
          ON spu.material_spu = sku.material_spu
       WHERE sku.material_sku = p_material_sku;
    ELSE
      NULL;
    END IF;
    po_material_class := vo_material_class;
    po_ingredients    := vo_ingredients;
    po_gram_weight    := vo_gram_weight;
    po_material_spu   := vo_material_spu;
    po_material_sku   := vo_material_sku;
  END p_get_material_data;

  --czh add start 20221202
  --获取相同成分占比
  FUNCTION f_get_same_ingredient_prom(p_material_spu VARCHAR2,
                                      --p_sup_ingredient         VARCHAR2,
                                      p_is_inner_material      INT,
                                      p_recommend_material_spu VARCHAR2 /*,
                                                                                                                                                                                                                                    p_recommend_ingredient   VARCHAR2*/)
    RETURN NUMBER IS
    v_same_ingredient_prom NUMBER(6, 2) := 0;
  BEGIN
    --推荐物料成分
    FOR recommend_rec IN (SELECT *
                            FROM mrp.mrp_material_spu_ingredient_mapping a
                           WHERE a.material_spu = p_recommend_material_spu
                          /*AND a.material_ingredient_id =
                          p_recommend_ingredient*/
                          ) LOOP
      --供应商核价物料成分
      -- 判断是否内部物料
      IF p_is_inner_material = 0 THEN
        FOR outside_rec IN (SELECT *
                              FROM mrp.mrp_outside_material_spu_ingredient_mapping b
                             WHERE b.material_spu = p_material_spu
                            /*AND b.material_ingredient_id =
                            p_sup_ingredient*/
                            ) LOOP
          IF recommend_rec.material_ingredient_id =
             outside_rec.material_ingredient_id THEN
            IF recommend_rec.ingredient_proportion >=
               outside_rec.ingredient_proportion THEN
              v_same_ingredient_prom := v_same_ingredient_prom +
                                        outside_rec.ingredient_proportion;
            ELSE
              v_same_ingredient_prom := v_same_ingredient_prom +
                                        recommend_rec.ingredient_proportion;
            END IF;
            EXIT;
          ELSE
            CONTINUE;
          END IF;
        END LOOP;
      ELSIF p_is_inner_material = 1 THEN
        FOR inner_rec IN (SELECT *
                            FROM mrp.mrp_material_spu_ingredient_mapping c
                           WHERE c.material_spu = p_material_spu
                          /*AND c.material_ingredient_id = p_sup_ingredient*/
                          ) LOOP
          IF recommend_rec.material_ingredient_id =
             inner_rec.material_ingredient_id THEN
            IF recommend_rec.ingredient_proportion >=
               inner_rec.ingredient_proportion THEN
              v_same_ingredient_prom := v_same_ingredient_prom +
                                        inner_rec.ingredient_proportion;
            ELSE
              v_same_ingredient_prom := v_same_ingredient_prom +
                                        recommend_rec.ingredient_proportion;
            END IF;
            EXIT;
          ELSE
            CONTINUE;
          END IF;
        END LOOP;
      ELSE
        NULL;
      END IF;
    END LOOP;
    RETURN v_same_ingredient_prom;
  END f_get_same_ingredient_prom;

  --克重匹配度绝对值
  FUNCTION f_get_gram_weight_comparison(p_sup_material       NUMBER,
                                        p_recommend_material NUMBER)
    RETURN NUMBER IS
    v_gram_weight_compar NUMBER(6, 2);
  BEGIN
    IF p_sup_material IS NULL OR p_sup_material = 0 THEN
      v_gram_weight_compar := 0;
    ELSE
      v_gram_weight_compar := 1 -
                              abs((p_sup_material - p_recommend_material) /
                                  p_sup_material);
    END IF;
    RETURN v_gram_weight_compar;
  END f_get_gram_weight_comparison;

  --内部比价推荐度计算 czh add
  PROCEDURE p_calculate_inner_price_comparison_recommen(p_examine_price_id                 VARCHAR2,
                                                        p_examine_price_material_detail_id VARCHAR2,
                                                        p_material_spu                     VARCHAR2,
                                                        --p_material_sku                     VARCHAR2,
                                                        p_is_inner_material INT,
                                                        p_material_class    VARCHAR2,
                                                        p_ingredients       VARCHAR2,
                                                        p_gram_weight       VARCHAR2) IS
    --推荐物料
    CURSOR recommend_cur(p_material_class VARCHAR2) IS
      SELECT spu.material_spu,
             sku.material_sku,
             spu.ingredients,
             spu.gram_weight
        FROM mrp.mrp_internal_material_spu spu
       INNER JOIN mrp.mrp_internal_material_sku sku
          ON sku.material_spu = spu.material_spu
       WHERE spu.material_classification = p_material_class;
    v_same_ingredient_prom NUMBER(6, 2);
    v_gram_weight_compar   NUMBER(6, 2);
    v_recommend            NUMBER(6, 2); --推荐度
    v_component            NUMBER(6, 2); --成本权重
    v_gram_weight          NUMBER(6, 2); --克重权重
    v_recom_rec            mrp.recommend_material_result%ROWTYPE; --物料推荐结果表
    v_fmdr_rec             mrp.fabric_material_detail_recommend_price_comparison%ROWTYPE; --物料推荐内部比价信息
  BEGIN
    --供应商物料spu
    --成分为空且克重为空
    IF p_ingredients IS NULL AND p_gram_weight IS NULL THEN
      --不推荐物料
      NULL;
    ELSE
      --成本权重，克重权重
      SELECT MAX(fm.component), MAX(fm.gram_weight)
        INTO v_component, v_gram_weight
        FROM mrp.fabric_material_detail_price_comparison_config fm
       WHERE rownum = 1;
    
      --推荐物料spu
      FOR recomend_rec IN recommend_cur(p_material_class) LOOP
        --供应商物料spu  成分  克重
        v_same_ingredient_prom := CASE
                                    WHEN p_ingredients IS NULL AND
                                         p_gram_weight IS NOT NULL THEN
                                     0
                                    ELSE
                                     f_get_same_ingredient_prom(p_material_spu => p_material_spu,
                                                                --p_sup_ingredient         => p_ingredients,
                                                                p_is_inner_material      => p_is_inner_material,
                                                                p_recommend_material_spu => recomend_rec.material_spu /*,
                                                                                                                                                                                                                                                                                                                                                                                                p_recommend_ingredient   => recomend_rec.ingredients*/)
                                  END;
      
        v_gram_weight_compar := CASE
                                  WHEN p_ingredients IS NOT NULL AND
                                       (p_gram_weight IS NULL OR p_gram_weight = 0) THEN
                                   0
                                  ELSE
                                   f_get_gram_weight_comparison(p_sup_material       => p_gram_weight,
                                                                p_recommend_material => recomend_rec.gram_weight)
                                END;
        --推荐度
        v_recommend := ((v_same_ingredient_prom * 0.01 * v_component * 0.01) +
                       (v_gram_weight_compar * v_gram_weight * 0.01)) * 100;
      
        --插入至推荐物料结果表
        v_recom_rec.recommend_material_id            := plm.pkg_plat_comm.f_get_uuid();
        v_recom_rec.examine_price_id                 := p_examine_price_id;
        v_recom_rec.examine_price_material_detail_id := p_examine_price_material_detail_id;
        v_recom_rec.material_sku                     := recomend_rec.material_sku;
        v_recom_rec.recommend                        := v_recommend;
        p_insert_recommend_material_result(p_recom_rec => v_recom_rec);
      END LOOP;
      --选前10条数据 插入推荐内部推荐表
      FOR material_result_rec IN (SELECT *
                                    FROM (SELECT row_number() over(PARTITION BY t.examine_price_id, t.examine_price_material_detail_id ORDER BY t.recommend DESC) rn,
                                                 t.recommend_material_id,
                                                 t.examine_price_id,
                                                 t.examine_price_material_detail_id,
                                                 t.material_sku,
                                                 t.recommend
                                            FROM mrp.recommend_material_result t
                                           WHERE t.examine_price_id =
                                                 p_examine_price_id
                                             AND t.examine_price_material_detail_id =
                                                 p_examine_price_material_detail_id) v
                                   WHERE v.rn <= 10) LOOP
        --新增物料推荐内部比价信息
        v_fmdr_rec.recommend_price_comparison       := plm.pkg_plat_comm.f_get_uuid();
        v_fmdr_rec.examine_price_id                 := material_result_rec.examine_price_id;
        v_fmdr_rec.examine_price_material_detail_id := material_result_rec.examine_price_material_detail_id;
        v_fmdr_rec.material_sku                     := material_result_rec.material_sku;
        v_fmdr_rec.weight_sort                      := material_result_rec.rn;
        v_fmdr_rec.choice                           := 0;
        p_insert_fabric_material_detail_recommend_price_comparison(p_fabric_mdrp_rec => v_fmdr_rec);
      END LOOP;
      --清空临时表数据
      /*p_delete_recommend_material_result_by_id(p_examine_price_id                 => p_examine_price_id,
      p_examine_price_material_detail_id => p_examine_price_material_detail_id);*/
    
    END IF;
  END p_calculate_inner_price_comparison_recommen;

  --新增推荐物料结果
  PROCEDURE p_insert_recommend_material_result(p_recom_rec mrp.recommend_material_result%ROWTYPE) IS
  BEGIN
    INSERT INTO mrp.recommend_material_result
      (recommend_material_id, examine_price_id,
       examine_price_material_detail_id, material_sku, recommend)
    VALUES
      (p_recom_rec.recommend_material_id, p_recom_rec.examine_price_id,
       p_recom_rec.examine_price_material_detail_id,
       p_recom_rec.material_sku, p_recom_rec.recommend);
  END p_insert_recommend_material_result;

  --新增面料部物料明细推荐内部比价信息
  PROCEDURE p_insert_fabric_material_detail_recommend_price_comparison(p_fabric_mdrp_rec mrp.fabric_material_detail_recommend_price_comparison%ROWTYPE) IS
  BEGIN
    INSERT INTO mrp.fabric_material_detail_recommend_price_comparison
      (recommend_price_comparison, examine_price_id,
       examine_price_material_detail_id, material_sku, weight_sort, choice)
    VALUES
      (p_fabric_mdrp_rec.recommend_price_comparison,
       p_fabric_mdrp_rec.examine_price_id,
       p_fabric_mdrp_rec.examine_price_material_detail_id,
       p_fabric_mdrp_rec.material_sku, p_fabric_mdrp_rec.weight_sort,
       p_fabric_mdrp_rec.choice);
  END p_insert_fabric_material_detail_recommend_price_comparison;

  --新增面料部物料明细推荐货比三家信息
  PROCEDURE p_insert_fabric_material_detail_recommend_shop_around(p_fabric_mdrsa_rec mrp.fabric_material_detail_recommend_shop_around%ROWTYPE) IS
  BEGIN
    INSERT INTO mrp.fabric_material_detail_recommend_shop_around
      (recommend_shop_around_id, examine_price_id,
       examine_price_material_detail_id, supplier_code, weight_sort)
    VALUES
      (p_fabric_mdrsa_rec.recommend_shop_around_id,
       p_fabric_mdrsa_rec.examine_price_id,
       p_fabric_mdrsa_rec.examine_price_material_detail_id,
       p_fabric_mdrsa_rec.supplier_code, p_fabric_mdrsa_rec.weight_sort);
  END p_insert_fabric_material_detail_recommend_shop_around;

  --通过ID清空物料推荐结果数据
  PROCEDURE p_delete_recommend_material_result_by_id(p_examine_price_id                 VARCHAR2,
                                                     p_examine_price_material_detail_id VARCHAR2) IS
  BEGIN
    DELETE FROM mrp.recommend_material_result t
     WHERE t.examine_price_id = p_examine_price_id
       AND t.examine_price_material_detail_id =
           p_examine_price_material_detail_id;
  END p_delete_recommend_material_result_by_id;
  --czh add end 20221202

  PROCEDURE p_cre_material_examine_price(pi_examine_price_id IN VARCHAR2, --核价单id
                                         pi_user_id          IN VARCHAR2) IS
    v_new_emid     VARCHAR2(32);
    v_quo_id       VARCHAR2(32);
    v_rela_made_id VARCHAR2(32);
  BEGIN
    --根据核价单id获取报价单id
    SELECT a.relate_quotation_id
      INTO v_quo_id
      FROM plm.examine_price a
     WHERE a.examine_price_id = pi_examine_price_id;
  
    --物料明细
    FOR a IN (SELECT b.*, c.whether_add_color_quotation
                FROM plm.material_detail_quotation b
               INNER JOIN plm.quotation c
                  ON c.quotation_id = b.quotation_id
               WHERE b.quotation_id = v_quo_id) LOOP
      --获取id
      v_new_emid := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MATERIAL_DETAIL_EXAMINE_PRICE',
                                                    v_column_name => 'EXAMINE_PRICE_MATERIAL_DETAIL_ID',
                                                    v_pre         => pi_examine_price_id || 'WL',
                                                    v_serail_num  => 2);
    
      --关联加色核价物料明细ID
      SELECT MAX(t.examine_price_material_detail_id)
        INTO v_rela_made_id
        FROM plm.material_detail_examine_price t
       WHERE t.relate_material_detail_quotation_id =
             a.related_colored_material_detail_quotation_id;
    
      --插入表
      INSERT INTO plm.material_detail_examine_price
        (examine_price_material_detail_id,
         relate_material_detail_quotation_id,
         relate_add_color_examine_price_material_detail_id,
         examine_price_material_detail_no, whether_inner_material,
         examine_price_material_sku, examine_price_material_supplier_code,
         examine_price_id,
         --examine_unit_price_result,unit_price,unit,   --因演示需要加上默认值
         create_id, create_time, update_id, update_time, whether_del,
         whether_append)
      VALUES
        (v_new_emid, a.material_detail_quotation_id, v_rela_made_id,
         a.quotation_material_detail_no, a.whether_inner_material,
         a.quotation_material_sku, a.quotation_material_supplier_code,
         pi_examine_price_id, pi_user_id, SYSDATE, pi_user_id, SYSDATE, 0,
         (CASE WHEN a.whether_add_color_quotation = 1 AND
           a.related_colored_material_detail_quotation_id IS NULL THEN 1 ELSE 0 END));
    
      --生成面料单相关信息
      DECLARE
        p_fabric_material_rec mrp.fabric_material_detail_examine_price%ROWTYPE;
        p_fabric_mdrsa_rec    mrp.fabric_material_detail_recommend_shop_around%ROWTYPE;
        vo_material_class     VARCHAR2(32);
        vo_ingredients        VARCHAR2(32);
        vo_gram_weight        VARCHAR2(32);
        vo_material_spu       VARCHAR2(32);
        vo_material_sku       VARCHAR2(32);
      BEGIN
        --1.新增面料部物料明细核价信息
        p_fabric_material_rec.examine_price_material_detail_id                  := v_new_emid;
        p_fabric_material_rec.relate_material_detail_quotation_id               := a.material_detail_quotation_id;
        p_fabric_material_rec.relate_add_color_examine_price_material_detail_id := v_rela_made_id;
        p_fabric_material_rec.examine_price_material_detail_no                  := a.quotation_material_detail_no;
        p_fabric_material_rec.whether_inner_material                            := a.whether_inner_material;
        p_fabric_material_rec.examine_price_material_sku                        := a.quotation_material_sku;
        p_fabric_material_rec.examine_price_material_supplier_code              := a.quotation_material_supplier_code;
        p_fabric_material_rec.examine_unit_price_result                         := NULL;
        p_fabric_material_rec.unit                                              := NULL;
        p_fabric_material_rec.unit_price                                        := NULL;
        p_fabric_material_rec.examine_price_id                                  := pi_examine_price_id;
        plm.pkg_quotation.p_insert_fabric_material_detail_examine_price(p_fabric_material_rec => p_fabric_material_rec);
        --获取供应商内外部物料 （物料分类，成分，克重，spu，sku）
        p_get_material_data(p_material_sku      => a.quotation_material_sku,
                            p_is_inner_material => a.whether_inner_material,
                            po_material_class   => vo_material_class,
                            po_ingredients      => vo_ingredients,
                            po_gram_weight      => vo_gram_weight,
                            po_material_spu     => vo_material_spu,
                            po_material_sku     => vo_material_sku);
        --2.1)新增面料部物料明细推荐内部比价信息
        --2)内部比价推荐度计算
        p_calculate_inner_price_comparison_recommen(p_examine_price_id                 => pi_examine_price_id,
                                                    p_examine_price_material_detail_id => v_new_emid,
                                                    p_material_spu                     => vo_material_spu,
                                                    --p_material_sku                     => vo_material_sku,
                                                    p_is_inner_material => a.whether_inner_material,
                                                    p_material_class    => vo_material_class,
                                                    p_ingredients       => vo_ingredients,
                                                    p_gram_weight       => vo_gram_weight);
      
        --3.新增面料部物料明细推荐货比三家信息
        FOR mdrsa_rec IN (SELECT v.*
                            FROM (SELECT b.supplier_code,
                                         b.cooperation_level,
                                         a.classification_id,
                                         nvl(va.sku_cnt, 0) sku_cnt,
                                         row_number() over(PARTITION BY b.cooperation_level ORDER BY nvl(va.sku_cnt, 0) DESC) level_sort,
                                         row_number() over(ORDER BY b.cooperation_level ASC) all_sort
                                    FROM mrp.mrp_determine_supplier_classification_mapping a
                                   INNER JOIN mrp.mrp_determine_supplier_archives b
                                      ON b.supplier_code = a.supplier_code
                                    LEFT JOIN (SELECT COUNT(c.material_sku) sku_cnt,
                                                     supplier_code
                                                FROM mrp.mrp_internal_supplier_material c
                                               GROUP BY c.supplier_code) va
                                      ON va.supplier_code = b.supplier_code
                                   WHERE a.classification_id =
                                         vo_material_class
                                   ORDER BY b.cooperation_level ASC) v
                           WHERE v.all_sort <= 10) LOOP
          p_fabric_mdrsa_rec.recommend_shop_around_id         := plm.pkg_plat_comm.f_get_uuid();
          p_fabric_mdrsa_rec.examine_price_id                 := pi_examine_price_id;
          p_fabric_mdrsa_rec.examine_price_material_detail_id := v_new_emid;
          p_fabric_mdrsa_rec.supplier_code                    := mdrsa_rec.supplier_code;
          p_fabric_mdrsa_rec.weight_sort                      := mdrsa_rec.all_sort;
          p_insert_fabric_material_detail_recommend_shop_around(p_fabric_mdrsa_rec => p_fabric_mdrsa_rec);
        END LOOP;
      END generate_fabric;
    END LOOP;
  END p_cre_material_examine_price;

  PROCEDURE p_ins_accessories_temp(v_rec IN mrp.mrp_create_outside_accessories_temp%ROWTYPE) IS
  
    v_quotation_id VARCHAR2(32);
    v_supp_id      VARCHAR2(32);
    v_flag2        NUMBER;
    v_exist_spu    VARCHAR2(64);
  BEGIN
    v_supp_id := plm.pkg_outside_material.f_get_suppinfo_id(v_current_compid => v_rec.create_finished_product_supplier_code,
                                                            v_need_compid    => 'b6cc680ad0f599cde0531164a8c0337f');
  
    SELECT COUNT(1), MAX(a.material_spu)
      INTO v_flag2, v_exist_spu
      FROM mrp.mrp_outside_material_spu a
     INNER JOIN mrp.mrp_outside_material_sku b
        ON a.material_spu = b.material_spu
     INNER JOIN mrp.mrp_outside_supplier_material c
        ON c.material_sku = b.material_sku
     WHERE a.material_name = v_rec.supp_material_name
       AND c.create_finished_supplier_code = v_supp_id
       AND a.material_specifications = v_rec.material_specification;
  
    IF v_flag2 > 0 AND v_rec.material_sku IS NULL THEN
      raise_application_error(-20002,
                              v_rec.supp_material_name || '已存在 ' ||
                              v_exist_spu ||
                              '对应当前【物料名称】，请前往【SPU加色】或【SKU加供】进行操作');
    
    ELSE
    
      v_quotation_id := scmdata.pkg_variable.f_get_varchar(v_objid   => v_rec.create_id,
                                                           v_compid  => v_rec.create_finished_product_supplier_code,
                                                           v_varname => 'ASS_QUO_ID_2');
    
      INSERT INTO mrp.mrp_create_outside_accessories_temp
        (ac_temp_id, supplier_name, supp_material_name,
         material_classification, unit, unit_price, TYPE, app_site,
         unit_consumption, loss_rate, amount, contact_phone, material_sku,
         material_specification, create_finished_product_supplier_code,
         create_id, create_time, quo_id, supplier_code, remarks)
      VALUES
        (v_rec.ac_temp_id, v_rec.supplier_name, v_rec.supp_material_name,
         v_rec.material_classification, v_rec.unit, v_rec.unit_price,
         v_rec.type, v_rec.app_site, v_rec.unit_consumption, v_rec.loss_rate,
         v_rec.amount, v_rec.contact_phone, v_rec.material_sku,
         v_rec.material_specification,
         v_rec.create_finished_product_supplier_code, v_rec.create_id,
         SYSDATE, v_quotation_id, v_rec.supplier_code, v_rec.remarks);
    END IF;
  END p_ins_accessories_temp;

  PROCEDURE p_ins_assmaterial_bysubmit(v_com_id    IN VARCHAR2,
                                       v_create_id IN VARCHAR2) IS
  
    --V_REC MRP.MRP_CREATE_OUTSIDE_ACCESSORIES_TEMP%ROWTYPE;
    v_supp_id      VARCHAR2(128);
    v_flag         NUMBER;
    v_exist_sku    VARCHAR2(64);
    v_phone        VARCHAR2(64);
    v_log_msg      CLOB;
    v_msupp        VARCHAR2(128);
    v_dahuo_jinjia NUMBER;
    v_num          NUMBER;
    spu_id         VARCHAR2(32);
    v_guige        VARCHAR2(64);
    v_sku_id       VARCHAR2(64);
    v_wlname       VARCHAR2(64);
    v_dhjj         VARCHAR2(64);
    v_dhbj         VARCHAR2(64);
    v_s_wlname     VARCHAR2(64);
    v_spu          VARCHAR2(64);
    v_no           NUMBER;
    v_material_id  VARCHAR2(64);
    v_ope_name     VARCHAR2(64);
    v_amount       NUMBER;
    vo_log_id      VARCHAR2(32);
  BEGIN
    v_supp_id := plm.pkg_outside_material.f_get_suppinfo_id(v_current_compid => v_com_id,
                                                            v_need_compid    => 'b6cc680ad0f599cde0531164a8c0337f');
  
    FOR i IN (SELECT *
                FROM mrp.mrp_create_outside_accessories_temp a
               WHERE a.create_finished_product_supplier_code = v_com_id
                 AND a.create_id = v_create_id) LOOP
      SELECT nvl(MAX(t.nick_name), 'ADMIN')
        INTO v_ope_name
        FROM scmdata.sys_user t
       WHERE t.user_id = i.create_id;
    
      --先校验是否已存在物料
      SELECT COUNT(1), MAX(z.material_sku)
        INTO v_flag, v_exist_sku
        FROM mrp.mrp_outside_supplier_material z
       INNER JOIN mrp.mrp_temporary_supplier_archives y
          ON z.supplier_code = y.supplier_code
       INNER JOIN mrp.mrp_outside_material_sku b
          ON b.material_sku = z.material_sku
         AND b.create_finished_supplier_code =
             z.create_finished_supplier_code
       INNER JOIN mrp.mrp_outside_material_spu a
          ON a.material_spu = b.material_spu
       WHERE y.supplier_name = i.supplier_name
         AND z.create_finished_supplier_code = v_supp_id
         AND z.supplier_color = '白色'
         AND z.supplier_material_name = i.supp_material_name
         AND a.material_specifications = i.material_specification;
      IF v_flag > 0 AND i.material_sku IS NULL THEN
        raise_application_error(-20002,
                                '已存在 ' || v_exist_sku ||
                                '对应当前物料，请前往选择已有面料进行操作');
      ELSE
        --落表
        IF substr(i.unit, 0, instr(i.unit, '/') - 1) = '公斤' THEN
          v_dahuo_jinjia := round(i.unit_price / 25 * (25), 1);
        ELSIF substr(i.unit, 0, instr(i.unit, '/') - 1) = '米' THEN
          v_dahuo_jinjia := round(i.unit_price / (100 / 100), 1);
        ELSE
          v_dahuo_jinjia := i.unit_price;
        END IF;
        --供应商部分
        IF i.supplier_code = 'NEW' THEN
          --供应商部分
          --IF I.SUPPLIER_NAME='未填写' THEN
        
          SELECT COUNT(1), MAX(a.contact_phone), MAX(a.supplier_code)
            INTO v_num, v_phone, v_msupp
            FROM mrp.mrp_temporary_supplier_archives a
           WHERE a.supplier_name = i.supplier_name
             AND a.create_finished_product_supplier_code = v_supp_id;
        
          IF v_num > 0 THEN
            --如果已存在未填写
            IF nvl(v_phone, 1) <> (i.contact_phone) THEN
              UPDATE mrp.mrp_temporary_supplier_archives u
                 SET u.contact_phone = i.contact_phone,
                     u.update_time   = SYSDATE,
                     u.update_id     = i.create_id
               WHERE u.supplier_code = v_msupp
                 AND u.create_finished_product_supplier_code = v_supp_id;
              v_log_msg := v_log_msg || '联系电话： ' || i.contact_phone ||
                           '【操作前： ' || v_phone || '】 ';
            ELSE
              NULL;
            END IF;
          ELSE
            --不存在，新增
            v_msupp := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES',
                                                       v_column_name => 'SUPPLIER_CODE',
                                                       v_pre         => 'L' ||
                                                                        to_char(SYSDATE,
                                                                                'YY'),
                                                       v_serail_num  => 5);
            INSERT INTO mrp.mrp_temporary_supplier_archives
              (supplier_code, supplier_source, cooperation_status,
               supplier_name, create_finished_product_supplier_code,
               business_contact, contact_phone, detailed_address,
               create_time, create_id, whether_del)
            VALUES
              (v_msupp, 'ODM供应商报价', 1, i.supplier_name, v_supp_id, '',
               i.contact_phone, '', i.create_time, i.create_id, 0);
            --创建外部供应商日志
            INSERT INTO mrp.mrp_log
              (id, user_name, operate_content, operate, create_time,
               class_name, method_name, thirdpart_id)
            VALUES
              (plm.pkg_outside_material.f_get_mrp_keyid(pi_pre     => 1,
                                                        pi_owner   => 'PLM',
                                                        pi_seqname => 'SEQ_MRPPIC_ID',
                                                        pi_seqnum  => 99),
               v_ope_name, '创建新物料供应商：' || v_msupp, 'insert', SYSDATE,
               'SCM-ODM报价管理', '创建物料信息', v_msupp);
          END IF;
          /* ELSE
                --新建供应商
                V_MSUPP:=plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MRP.MRP_TEMPORARY_SUPPLIER_ARCHIVES',
                                                         v_column_name => 'SUPPLIER_CODE',
                                                         v_pre         => 'L' ||
                                                                          to_char(SYSDATE,
                                                                                  'YY'),
                                                         v_serail_num  => 5);
                INSERT INTO mrp.mrp_temporary_supplier_archives
                (supplier_code,supplier_source,cooperation_status,supplier_name,create_finished_product_supplier_code,
                business_contact,contact_phone,detailed_address,create_time,create_id,whether_del)
                VALUES(V_MSUPP,'ODM供应商报价', 1,i.supplier_name,V_SUPP_ID,'',i.contact_phone,'',SYSDATE,i.create_id,0);
          
                --创建外部供应商日志
          INSERT INTO mrp.mrp_log
            (id, user_name, operate_content, operate, create_time, class_name,
             method_name, thirdpart_id)
          VALUES
            (plm.pkg_outside_material.f_get_mrp_keyid(pi_pre     => 1,
                                                      pi_owner   => 'PLM',
                                                      pi_seqname => 'SEQ_MRPPIC_ID',
                                                      pi_seqnum  => 99),
             v_ope_name, '创建新物料供应商：' || V_MSUPP, 'insert', SYSDATE,
             'SCM-ODM报价管理', '创建物料信息', V_MSUPP);
          
              END IF;*/
          --物料部分
        
          --大货净价
          IF substr(i.unit, 0, instr(i.unit, '/') - 1) = '公斤' THEN
            v_dahuo_jinjia := round(i.unit_price / 25 * (25), 1);
          ELSIF substr(i.unit, 0, instr(i.unit, '/') - 1) = '米' THEN
            v_dahuo_jinjia := round(i.unit_price / (100 / 100), 1);
          ELSE
            v_dahuo_jinjia := i.unit_price;
          END IF;
        
          --spu
          spu_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MRP.MRP_OUTSIDE_MATERIAL_SPU',
                                                    v_column_name => 'MATERIAL_SPU',
                                                    v_pre         => 'WFH00',
                                                    v_serail_num  => 4);
          INSERT INTO mrp.mrp_outside_material_spu
            (material_spu, features, material_name, unit,
             material_classification, material_specifications,
             create_finished_supplier_code, create_time, create_id,
             whether_del)
          VALUES
            (spu_id, spu_id, i.supp_material_name,
             substr(i.unit, 0, instr(i.unit, '/') - 1),
             i.material_classification, i.material_specification, v_supp_id,
             SYSDATE, i.create_id, 0);
          --sku
          v_sku_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MRP.MRP_OUTSIDE_MATERIAL_SKU',
                                                      v_column_name => 'MATERIAL_SKU',
                                                      v_pre         => spu_id || '0' ||
                                                                       to_char(SYSDATE,
                                                                               'YY'),
                                                      v_serail_num  => 3);
        
          --外部供应商物料
          INSERT INTO mrp.mrp_outside_supplier_material
            (sku_abutment_code, supplier_code, color_card_picture,
             material_sku, material_source, supplier_material_name,
             supplier_color, supplier_shades, supplier_material_status,
             optimization, create_finished_supplier_code, create_time,
             creater, whether_del, supplier_large_good_quote,
             supplier_large_good_net_price)
          VALUES
            ((CASE WHEN i.supplier_code = 'NEW' THEN v_msupp ELSE
              i.supplier_code END) || v_sku_id || v_supp_id,
             (CASE WHEN i.supplier_code = 'NEW' THEN v_msupp ELSE
               i.supplier_code END),
             (CASE WHEN i.supplier_code = 'NEW' THEN v_msupp ELSE
               i.supplier_code END) || v_sku_id || v_supp_id, v_sku_id,
             'ODM供应商报价', i.supp_material_name, '白色', '', 1, 1, v_supp_id,
             SYSDATE, i.create_id, 0, i.unit_price, v_dahuo_jinjia);
        
          INSERT INTO mrp.mrp_outside_material_sku
            (material_sku, material_color, material_spu, sku_status,
             color_picture, create_time, create_finished_supplier_code,
             whether_del, create_id, preferred_net_price_of_large_good)
          VALUES
            (v_sku_id, '白色', spu_id, 1, v_sku_id, SYSDATE, v_supp_id, 0,
             i.create_id, v_dahuo_jinjia);
        
        ELSE
          --已有的供应商
          --供应商信息
          SELECT y.contact_phone
            INTO v_phone
            FROM mrp.mrp_temporary_supplier_archives y
           WHERE y.create_finished_product_supplier_code = v_supp_id
             AND y.supplier_code = i.supplier_code;
          IF nvl(v_phone, 1) <> (i.contact_phone) THEN
            UPDATE mrp.mrp_temporary_supplier_archives u
               SET u.contact_phone = i.contact_phone,
                   u.update_time   = SYSDATE,
                   u.update_id     = i.create_id
             WHERE u.supplier_code = i.supplier_code
               AND u.create_finished_product_supplier_code = v_supp_id;
            v_log_msg := v_log_msg || '联系电话： ' || i.contact_phone ||
                         '【操作前： ' || v_phone || '】 ';
          ELSE
            NULL;
          END IF;
        
          --物料部分
          SELECT a.material_spu,
                 a.material_specifications,
                 a.material_name,
                 c.supplier_large_good_net_price,
                 c.supplier_large_good_quote,
                 c.supplier_material_name
            INTO v_spu, v_guige, v_wlname, v_dhjj, v_dhbj, v_s_wlname
            FROM mrp.mrp_outside_material_spu a
           INNER JOIN mrp.mrp_outside_material_sku b
              ON a.material_spu = b.material_spu
          
           INNER JOIN mrp.mrp_outside_supplier_material c
              ON c.material_sku = b.material_sku
           WHERE b.material_sku = i.material_sku
             AND c.create_finished_supplier_code = v_supp_id;
          IF nvl(v_guige, 1) <> nvl(i.material_specification, 1) THEN
            UPDATE mrp.mrp_outside_material_spu t
               SET t.material_specifications = i.material_specification
             WHERE t.material_spu = v_spu;
            v_log_msg := v_log_msg || '物料规格： ' || i.material_specification ||
                         '【操作前： ' || v_guige || '】 ';
          
          END IF;
        
          IF nvl(v_wlname, 1) <> nvl(i.supp_material_name, 1) THEN
            UPDATE mrp.mrp_outside_material_spu t
               SET t.material_name = i.supp_material_name
             WHERE t.material_spu = v_spu;
            v_log_msg := v_log_msg || '物料名称： ' || i.supp_material_name ||
                         '【操作前： ' || v_wlname || '】 ';
          ELSE
            NULL;
          END IF;
        
          IF nvl(v_s_wlname, 1) <> nvl(i.supp_material_name, 1) THEN
            UPDATE mrp.mrp_outside_supplier_material t
               SET t.supplier_material_name = i.supp_material_name
             WHERE t.material_sku = i.material_sku
               AND t.supplier_code = i.supplier_code
               AND t.create_finished_supplier_code = v_supp_id;
          
            v_log_msg := v_log_msg || '供应商物料名称： ' || i.supp_material_name ||
                         '【操作前： ' || v_s_wlname || '】 ';
          ELSE
            NULL;
          END IF;
        
          IF nvl(v_dahuo_jinjia, 1) <> nvl(v_dhjj, 1) THEN
            UPDATE mrp.mrp_outside_supplier_material t
               SET t.supplier_large_good_net_price = v_dahuo_jinjia
             WHERE t.material_sku = i.material_sku
               AND t.supplier_code = i.supplier_code
               AND t.create_finished_supplier_code = v_supp_id;
            UPDATE mrp.mrp_outside_material_sku t
               SET t.preferred_net_price_of_large_good = v_dahuo_jinjia
             WHERE t.material_sku = i.material_sku;
            v_log_msg := v_log_msg || '供应商大货净价： ' || v_dahuo_jinjia ||
                         '【操作前： ' || v_dhjj || '】 ';
          ELSE
            NULL;
          END IF;
        
          IF nvl(i.unit_price, 1) <> nvl(v_dhbj, 1) THEN
            UPDATE mrp.mrp_outside_supplier_material t
               SET t.supplier_large_good_quote = i.unit_price
             WHERE t.material_sku = i.material_sku
               AND t.supplier_code = i.supplier_code
               AND t.create_finished_supplier_code = v_supp_id;
            v_log_msg := v_log_msg || '供应商大货报价： ' || i.unit_price ||
                         '【操作前： ' || v_dhbj || '】 ';
          ELSE
            NULL;
          END IF;
        
        END IF;
        --插入报价物料表
        SELECT COUNT(1) + 1
          INTO v_no
          FROM plm.material_detail_quotation t
         WHERE t.quotation_id = i.quo_id;
        v_material_id := plm.pkg_plat_comm.f_get_keycode(v_table_name  => 'MATERIAL_DETAIL_QUOTATION',
                                                         v_column_name => 'MATERIAL_DETAIL_QUOTATION_ID',
                                                         v_pre         => i.quo_id || 'WL',
                                                         v_serail_num  => 2);
      
        INSERT INTO plm.material_detail_quotation
          (material_detail_quotation_id, quotation_material_detail_no,
           quotation_material_type, quotation_application_site,
           whether_inner_material, quotation_material_sku,
           quotation_unit_price, quotation_unit, quotation_loss_rate,
           quotation_unit_price_consumption, quotation_amount,
           quotation_material_supplier_code, quotation_id, quotation_remark,
           create_time, create_id, update_time, update_id, whether_del)
        VALUES
          (v_material_id, v_no, i.type, i.app_site, 0,
           (CASE WHEN i.supplier_code = 'NEW' THEN v_sku_id ELSE
             i.material_sku END), i.unit_price,
           substr(i.unit, 0, instr(i.unit, '/') - 1), i.loss_rate,
           i.unit_consumption, i.amount,
           (CASE WHEN i.supplier_code = 'NEW' THEN v_msupp ELSE
             i.supplier_code END), i.quo_id, i.remarks, SYSDATE, i.create_id,
           SYSDATE, i.create_id, 0);
      END IF;
    
      SELECT SUM(y.quotation_amount)
        INTO v_amount
        FROM plm.material_detail_quotation y
       WHERE y.quotation_id = i.quo_id
         AND y.whether_del = 0;
      UPDATE plm.quotation t
         SET t.material_amount = v_amount
       WHERE t.quotation_id = i.quo_id;
    
      DELETE FROM mrp.mrp_create_outside_accessories_temp t
       WHERE t.ac_temp_id = i.ac_temp_id;
      scmdata.pkg_plat_log.p_record_plat_log(p_company_id         => 'b6cc680ad0f599cde0531164a8c0337f',
                                             p_apply_module       => 'a_quotation_110',
                                             p_base_table         => 'mrp.mrp_outside_material_spu',
                                             p_apply_pk_id        => i.quo_id,
                                             p_action_type        => 'INSERT',
                                             p_log_id             => vo_log_id,
                                             p_log_type           => '01',
                                             p_log_msg            => '创建新物料:' ||
                                                                     (CASE
                                                                       WHEN i.supplier_code =
                                                                            'NEW' THEN
                                                                        v_sku_id
                                                                       ELSE
                                                                        i.material_sku
                                                                     END),
                                             p_operate_field      => 'MATERIAL_DETAIL_QUOTATION_ID',
                                             p_field_type         => 'VARCHAR2',
                                             p_old_code           => NULL,
                                             p_new_code           => NULL,
                                             p_old_value          => 0,
                                             p_new_value          => 1,
                                             p_user_id            => i.create_id,
                                             p_operate_company_id => i.create_finished_product_supplier_code,
                                             p_seq_no             => 1,
                                             po_log_id            => vo_log_id,
                                             p_type               => 1);
    
      IF v_log_msg IS NOT NULL THEN
        INSERT INTO mrp.mrp_log
          (id, user_name, operate_content, operate, create_time, class_name,
           method_name, thirdpart_id)
        VALUES
          (plm.pkg_outside_material.f_get_mrp_keyid(pi_pre     => 1,
                                                    pi_owner   => 'PLM',
                                                    pi_seqname => 'SEQ_MRPPIC_ID',
                                                    pi_seqnum  => 99),
           v_ope_name, v_log_msg, 'update', SYSDATE, 'SCM-ODM报价管理', '物料信息',
           (CASE WHEN i.supplier_code = 'NEW' THEN v_sku_id ELSE
             i.material_sku END));
      ELSE
        NULL;
      END IF;
    
    END LOOP;
  
  END p_ins_assmaterial_bysubmit;

END pkg_outside_material;
/
