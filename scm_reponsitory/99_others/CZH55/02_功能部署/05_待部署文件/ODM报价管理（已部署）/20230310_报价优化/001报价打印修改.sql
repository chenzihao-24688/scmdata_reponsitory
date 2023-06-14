DECLARE
  V_SQL CLOB;
BEGIN
  V_SQL:='{DECLARE
 v_sql CLOB;
 --v_sku_info CLOB; --sku信息
 --v_supp_info CLOB; --供应商信息
 v_quotation_class_code VARCHAR2(128);  --报价分类
 v_flag NUMBER;
 v_quotation_classification VARCHAR2(128);
BEGIN



SELECT MAX(qt.quotation_classification)
    INTO v_quotation_classification
    FROM plm.quotation qt
   WHERE qt.quotation_id = :QUOTATION_ID;


  v_quotation_class_code := plm.pkg_quotation.f_get_quotation_class_by_id(p_company_id               => ''b6cc680ad0f599cde0531164a8c0337f'',
                                                                          p_quotation_classification => v_quotation_classification,
                                                                          p_out_type                 => 2,
                                                                          p_is_name                  => 0);
  --男鞋、女鞋
  IF v_quotation_class_code IN
     (''PLM_READY_PRICE_CLASSIFICATION00010001'',
      ''PLM_READY_PRICE_CLASSIFICATION00010003'') THEN V_FLAG :=1;
   ELSE
     V_FLAG:=0;
  END IF;



  v_sql :=q''[SELECT ]'' ||CASE V_FLAG WHEN 1 THEN q''[''QUOPR02'' ]'' ELSE q''[''QUOPR01'' ]'' END ||q''[ template_code,
       Z.QUOTATION_ID,
       Z.ITEM_NO,
       Z.COLOR,
       VA.QUOTATION_CLASSIFICATION_N QUO_CLASS,
       Z.SANFU_ARTICLE_NO SANFU_NO,
       Y.SUPPLIER_COMPANY_ABBREVIATION SUPP_NAME,
       (CASE Z.WHETHER_SANFU_FABRIC  WHEN 1 THEN  ''是'' ELSE ''否'' END) IS_SANFU_MA,
       (CASE Z.WHETHER_ADD_COLOR_QUOTATION WHEN 1 THEN ''是'' ELSE ''否''  END) IS_ADD_QUO,
       Z.CREATE_TIME,
       Z.RELATED_COLORED_QUOTATION RELA_QUO,
       Z.QUOTATION_SOURCE,
       Z.QUOTATION_TOTAL,
       Z.MATERIAL_AMOUNT,
       Z.CONSUMABLES_AMOUNT CONSUM_AMOUNT,
       Z.CRAFT_AMOUNT,
       Z.WORKING_PROCEDURE_AMOUNT WORKING_AMOUNT,
       Z.OTHER_AMOUNT
  FROM PLM.QUOTATION Z
 INNER JOIN SCMDATA.T_SUPPLIER_INFO Y
    ON Y.SUPPLIER_INFO_ID = Z.PLATFORM_UNIQUE_KEY
 INNER JOIN (SELECT v.quotation_classification_n1,
       v.quotation_classification_n2,
       v.quotation_classification_v2,
       v.quotation_classification quotation_classification,
       v.quotation_classification_n1 || ''/'' ||
       v.quotation_classification_n2 quotation_classification_n
  FROM (SELECT a.company_dict_name quotation_classification_n1,
               b.company_dict_value quotation_classification_v2,              
               nvl2(d.company_dict_name,
                    b.company_dict_name || ''/'' || c.company_dict_name || ''/'' ||
                    d.company_dict_name,
                    nvl2(c.company_dict_name,
                         b.company_dict_name || ''/'' || c.company_dict_name,
                         b.company_dict_name)) quotation_classification_n2,
               nvl(d.company_dict_id,
                   nvl(c.company_dict_id, b.company_dict_id)) quotation_classification
          FROM scmdata.sys_company_dict a
          LEFT JOIN scmdata.sys_company_dict b
            ON b.company_dict_type = a.company_dict_value
           AND b.company_id = a.company_id
           AND a.pause = 0
           AND b.pause = 0
          LEFT JOIN scmdata.sys_company_dict c
            ON c.company_dict_type = b.company_dict_value
           AND c.company_id = b.company_id
           AND c.pause = 0
          LEFT JOIN scmdata.sys_company_dict d
            ON d.company_dict_type = c.company_dict_value
           AND d.company_id = c.company_id
           AND d.pause = 0
         WHERE a.company_dict_type = ''PLM_READY_PRICE_CLASSIFICATION''
             ) v) va
    ON va.quotation_classification = Z.quotation_classification
 WHERE Z.QUOTATION_ID = :QUOTATION_ID]'';
  @STRRESULT   := v_sql;

END;
}';

 UPDATE BW3.SYS_FILE_TEMPLATE T SET T.SELECT_SQL=V_SQL WHERE T.ELEMENT_ID='word_a_quotation_210_1';
END;
/
