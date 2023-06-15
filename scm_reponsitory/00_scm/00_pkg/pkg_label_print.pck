CREATE OR REPLACE PACKAGE SCMDATA.PKG_LABEL_PRINT IS

FUNCTION F_LABEL_DATASQL(LABEL_ID IN VARCHAR2) RETURN CLOB;

END PKG_LABEL_PRINT;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_LABEL_PRINT IS

  FUNCTION F_LABEL_DATASQL(LABEL_ID IN VARCHAR2) RETURN CLOB IS
    V_SQL CLOB;

    BEGIN
      IF LABEL_ID = '60022' THEN
        V_SQL := 'SELECT CASE
         WHEN B.GOO_ID = ''760750'' THEN
          ''羽绒服''
         ELSE
          NVL(CASE D.CATEGORYGROUP
                WHEN ''牛仔长裤'' THEN
                 D.CATEGORYGROUP
                ELSE
                 D.CATEGORIES
              END,
              B.PATTERN)
       END CATEGORIES_GW,
       D.CATEGORYGROUP,
       C.BRA_NAME AS BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME1,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       DECODE(B.SEASON,
              ''春'',
              ''C'',
              ''夏1'',
              ''X1'',
              ''夏2'',
              ''X2'',
              ''秋'',
              ''Q'',
              ''冬'',
              ''D'',
              ''冬1'',
              ''D1'',
              ''冬2'',
              ''D2'',
              ''冬2+'',
              ''D2+'',
              ''冬3'',
              ''D3'',
              ''春夏季'',
              ''CX'',
              ''秋冬季'',
              ''QD'',
              ''四季'',
              ''SJ'') SEASON1,
       NVL(D.SUP_NAME, G.SUP_NAME) SUP_NAME,
       B.EXECUTIVESTD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME_NEW,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       CASE
         WHEN SUBSTR(TRIM(B.EXECUTIVESTD), 0, 9) IN
              (''FZ/T73018'', ''FZ/T73005'') THEN
          ''二等品''
         ELSE
          GETGOODSQUALITY(B.CATEGORYNO)
       END LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKER'') CHECKER,
       --GETNEWSALEPRICEFORLABEL(%SHO_ID%, B.GOO_ID) SALEPRICE,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(%SHO_ID%, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       A.BARCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SIZENAME_GW1'') Sizename_Gw1,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SIZENAME_GW2'') Sizename_Gw2,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SIZENAME_GW3'') Sizename_Gw3,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SIZENAME_GW4'') Sizename_Gw4,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SIZENAME_GW5'') Sizename_Gw5,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SIZENAME_GW6'') Sizename_Gw6,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SIZENAME_GW7'') Sizename_Gw7,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SHAPE_GW1'') Shape_Gw1,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SHAPE_GW2'') Shape_Gw2,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SHAPE_GW3'') Shape_Gw3,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SHAPE_GW4'') Shape_Gw4,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SHAPE_GW5'') Shape_Gw5,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SHAPE_GW6'') Shape_Gw6,
       (Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''SHAPE_GW7'') Shape_Gw7,*/
       DIC.SIZENAME_GW1,
       DIC.SIZENAME_GW2,
       DIC.SIZENAME_GW3,
       DIC.SIZENAME_GW4,
       DIC.SIZENAME_GW5,
       DIC.SIZENAME_GW6,
       DIC.SIZENAME_GW7,
       DIC.SHAPE_GW1,
       DIC.SHAPE_GW2,
       DIC.SHAPE_GW3,
       DIC.SHAPE_GW4,
       DIC.SHAPE_GW5,
       DIC.SHAPE_GW6,
       DIC.SHAPE_GW7,
       NVL(T1.GRAM_WEIGHT1, ''暂无'') GRAM_WEIGHT1,
       NVL(T2.GRAM_WEIGHT2, ''暂无'') GRAM_WEIGHT2,
       NVL(T3.GRAM_WEIGHT3, ''暂无'') GRAM_WEIGHT3,
       NVL(T4.GRAM_WEIGHT4, ''暂无'') GRAM_WEIGHT4,
       NVL(T5.GRAM_WEIGHT5, ''暂无'') GRAM_WEIGHT5,
       NVL(T6.GRAM_WEIGHT6, ''暂无'') GRAM_WEIGHT6,
       NVL(T7.GRAM_WEIGHT7, ''暂无'') GRAM_WEIGHT7,
       F.ORD_ID||F.BARCODE ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       f.orderamount - f.gotamount  OWE_AMOUNT_PR,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1   ELSE  0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
      (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
      ELSE ''官方正品'' END ) QRCODE,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO,
       A.SIZENAME,
       A.SHAPE,
       G.LABEL_SUPNAME,
       G.LABEL_PHONENUMBER,
       G.LABEL_ADDRESS,
       B.SCENE,
       (CASE  C.BRA_ID    WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       CASE C.BRA_ID    WHEN ''00'' THEN  1  ELSE   0  END ISSCENE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN (SELECT * FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode
  LEFT JOIN (SELECT DISTINCT A.GRAM_WEIGHT AS GRAM_WEIGHT1, A.GOO_ID
               FROM ARTICLES A
              WHERE A.SIZENAME = ''S'') T1
    ON B.GOO_ID = T1.GOO_ID
  LEFT JOIN (SELECT DISTINCT A.GRAM_WEIGHT AS GRAM_WEIGHT2, A.GOO_ID
               FROM ARTICLES A
              WHERE A.SIZENAME = ''M'') T2
    ON B.GOO_ID = T2.GOO_ID
  LEFT JOIN (SELECT DISTINCT A.GRAM_WEIGHT AS GRAM_WEIGHT3, A.GOO_ID
               FROM ARTICLES A
              WHERE A.SIZENAME = ''L'') T3
    ON B.GOO_ID = T3.GOO_ID
  LEFT JOIN (SELECT DISTINCT A.GRAM_WEIGHT AS GRAM_WEIGHT4, A.GOO_ID
               FROM ARTICLES A
              WHERE A.SIZENAME = ''XL'') T4
    ON B.GOO_ID = T4.GOO_ID
  LEFT JOIN (SELECT DISTINCT A.GRAM_WEIGHT AS GRAM_WEIGHT5, A.GOO_ID
               FROM ARTICLES A
              WHERE A.SIZENAME = ''XXL'') T5
    ON B.GOO_ID = T5.GOO_ID
  LEFT JOIN (SELECT DISTINCT A.GRAM_WEIGHT AS GRAM_WEIGHT6, A.GOO_ID
               FROM ARTICLES A
              WHERE A.SIZENAME = ''XXXL'') T6
    ON B.GOO_ID = T6.GOO_ID
  LEFT JOIN (SELECT DISTINCT A.GRAM_WEIGHT AS GRAM_WEIGHT7, A.GOO_ID
               FROM ARTICLES A
              WHERE A.SIZENAME = ''XXXXL'') T7
    ON B.GOO_ID = T7.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1), B.TOUCHCLASS) =
       E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN NETGOODS T
    ON A.GOO_ID = T.GOODS_SN
/*--改写2：新增 Left join*/
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SIZENAME_GW1'' THEN
                           A.CODE_VALUE
                        END) SIZENAME_GW1,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SIZENAME_GW2'' THEN
                           A.CODE_VALUE
                        END) SIZENAME_GW2,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SIZENAME_GW3'' THEN
                           A.CODE_VALUE
                        END) SIZENAME_GW3,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SIZENAME_GW4'' THEN
                           A.CODE_VALUE
                        END) SIZENAME_GW4,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SIZENAME_GW5'' THEN
                           A.CODE_VALUE
                        END) SIZENAME_GW5,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SIZENAME_GW6'' THEN
                           A.CODE_VALUE
                        END) SIZENAME_GW6,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SIZENAME_GW7'' THEN
                           A.CODE_VALUE
                        END) SIZENAME_GW7,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SHAPE_GW1'' THEN
                           A.CODE_VALUE
                        END) SHAPE_GW1,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SHAPE_GW2'' THEN
                           A.CODE_VALUE
                        END) SHAPE_GW2,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SHAPE_GW3'' THEN
                           A.CODE_VALUE
                        END) SHAPE_GW3,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SHAPE_GW4'' THEN
                           A.CODE_VALUE
                        END) SHAPE_GW4,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SHAPE_GW5'' THEN
                           A.CODE_VALUE
                        END) SHAPE_GW5,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SHAPE_GW6'' THEN
                           A.CODE_VALUE
                        END) SHAPE_GW6,
                    MAX(CASE
                          WHEN A.SUB_CODE_TYPE = ''SHAPE_GW7'' THEN
                           A.CODE_VALUE
                        END) SHAPE_GW7
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''SIZENAME_GW1'',
                                        ''SIZENAME_GW2'',
                                        ''SIZENAME_GW3'',
                                        ''SIZENAME_GW4'',
                                        ''SIZENAME_GW5'',
                                        ''SIZENAME_GW6'',
                                        ''SIZENAME_GW7'',
                                        ''SHAPE_GW1'',
                                        ''SHAPE_GW2'',
                                        ''SHAPE_GW3'',
                                        ''SHAPE_GW4'',
                                        ''SHAPE_GW5'',
                                        ''SHAPE_GW6'',
                                        ''SHAPE_GW7'')) DIC
    ON 1 = 1
/* WHERE A.BARCODE IN (%SELECTION%)*/
UNION ALL
SELECT NVL(CASE D.CATEGORYGROUP
             WHEN ''牛仔长裤'' THEN
              D.CATEGORYGROUP
             ELSE
              D.CATEGORIES
           END,
           B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       DECODE(B.SEASON,
              ''春'',
              ''C'',
              ''夏1'',
              ''X1'',
              ''夏2'',
              ''X2'',
              ''秋'',
              ''Q'',
              ''冬'',
              ''D'',
              ''冬1'',
              ''D1'',
              ''冬2'',
              ''D2'',
              ''冬2+'',
              ''D2+'',
              ''冬3'',
              ''D3'',
              ''春夏季'',
              ''CX'',
              ''秋冬季'',
              ''QD'',
              ''四季'',
              ''SJ'') SEASON1,
       NVL(D.SUP_NAME, G.SUP_NAME) SUP_NAME,
       B.EXECUTIVESTD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME_NEW,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       CASE
         WHEN SUBSTR(TRIM(B.EXECUTIVESTD), 0, 9) IN
              (''FZ/T73018'', ''FZ/T73005'') THEN
          ''二等品''
         ELSE
          GETGOODSQUALITY(B.CATEGORYNO)
       END LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKER'') CHECKER,
       --GETNEWSALEPRICEFORLABEL(%SHO_ID%, B.GOO_ID) SALEPRICE,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(%SHO_ID%, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
       B.GOO_ID BARCODE,
       NULL SIZENAME_GW1,
       NULL SIZENAME_GW2,
       NULL SIZENAME_GW3,
       NULL SIZENAME_GW4,
       NULL SIZENAME_GW5,
       NULL SIZENAME_GW6,
       NULL SIZENAME_GW7,
       NULL SHAPE_GW1,
       NULL SHAPE_GW2,
       NULL SHAPE_GW3,
       NULL SHAPE_GW4,
       NULL SHAPE_GW5,
       NULL SHAPE_GW6,
       NULL SHAPE_GW7,
       NULL GRAM_WEIGHT1,
       NULL GRAM_WEIGHT2,
       NULL GRAM_WEIGHT3,
       NULL GRAM_WEIGHT4,
       NULL GRAM_WEIGHT5,
       NULL GRAM_WEIGHT6,
       NULL GRAM_WEIGHT7,
       F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       F.orderamount - F.gotamount OWE_AMOUNT_PR,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1  ELSE  0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
        (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
        ELSE ''官方正品'' END) QRCODE,
        (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''扫码领88元券''
        ELSE NULL END) WX_MEMO,
       NULL SIZENAME,
       NULL SHAPE,
       G.LABEL_SUPNAME,
       G.LABEL_PHONENUMBER,
       G.LABEL_ADDRESS,
       B.SCENE,
       (CASE C.BRA_ID   WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       CASE C.BRA_ID   WHEN ''00'' THEN   1  ELSE   0  END ISSCENE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN (SELECT * FROM ORDERS Z WHERE Z.ORD_ID||Z.GOO_ID IN (%SELECTION%)) F ON B.GOO_ID=F.GOO_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1), B.TOUCHCLASS) =
       E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN NETGOODS T
    ON B.GOO_ID = T.GOODS_SN
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   /*AND B.GOO_ID IN (%SELECTION%)*/
 ORDER BY 20 ASC  ';

  ELSIF LABEL_ID = '20076' THEN
        V_SQL := 'SELECT B.ORDERBASEAMOUNT,
       D.CATEGORIES,
       C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(%SHO_ID%, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN (SELECT *
               FROM ORDERSITEM Z
              WHERE Z.ORD_ID || Z.BARCODE IN (%SELECTION%)) F
    ON F.GOO_ID = A.GOO_ID
   AND A.BARCODE = F.BARCODE
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN V_PL_DIC_GOODSTYPE_ALL D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
UNION ALL
SELECT B.ORDERBASEAMOUNT,
       D.CATEGORIES,
       C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(%SHO_ID%, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
 INNER JOIN V_PL_DIC_GOODSTYPE_ALL D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
 ORDER BY 4 ASC' ;
        
  ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
        
  ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
        
  ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
   ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
        
    ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
        
  ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
        
   ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
        
    ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
        
    ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;
        
        
     ELSIF LABEL_ID = '60022' THEN
        V_SQL := ;                                           
              

      END IF;

      RETURN      V_SQL;

      END F_LABEL_DATASQL;
   END  PKG_LABEL_PRINT;
/

