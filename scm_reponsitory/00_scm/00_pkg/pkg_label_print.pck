CREATE OR REPLACE PACKAGE SCMDATA.PKG_LABEL_PRINT IS

FUNCTION F_LABEL_DATASQL(LABEL_ID IN VARCHAR2) RETURN CLOB;

END PKG_LABEL_PRINT;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_LABEL_PRINT IS

  FUNCTION F_LABEL_DATASQL(LABEL_ID IN VARCHAR2) RETURN CLOB IS
    V_SQL CLOB;

    BEGIN
      IF LABEL_ID = '68123' THEN
        V_SQL := 'SELECT CASE WHEN B.GOO_ID = ''760750'' THEN ''羽绒服'' ELSE NVL(CASE D.CATEGORYGROUP
                WHEN ''牛仔长裤'' THEN    D.CATEGORYGROUP  ELSE   D.CATEGORIES   END,
              B.PATTERN)  END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       B.EXECUTIVESTD  EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME_NEW,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       CASE
         WHEN SUBSTR(REPLACE(B.EXECUTIVESTD, '' '', ''''), 0, 9) IN
              (''FZ/T73018'', ''FZ/T73005'') THEN
          ''二等品''
         ELSE
          GETGOODSQUALITY(B.CATEGORYNO)
       END LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKER'') CHECKER,
       ''￥''||to_char(GetNewSalePriceForLabel(B.SHO_ID, b.goo_id),''fm999999990.00'') SalePrice,
       --''￥''||to_char(B.PRICE,''fm999999990.00'') SalePrice,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       CASE G.LABEL_SUPNAME
         WHEN ''SANFU.BE'' THEN
          ''地址1''
         ELSE
          ''地址2''
       END NAME_VAR,

        (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
         (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       A.COLORNAME,
       A.SIZENAME,
       (CASE C.BRA_ID   WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       (CASE C.BRA_ID   WHEN ''00'' THEN    1   ELSE   0  END) ISSCENE,
       (CASE C.BRA_ID WHEN ''00'' THEN ''场景：'' ELSE NULL END ) SCENE_1,
       A.BARCODE,
       A.SHAPE,
       (CASE
         WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id as QRCode ,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
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
   LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
 WHERE A.BARCODE IN   (%SELECTION%)
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
       B.EXECUTIVESTD  EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME_NEW,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       CASE
         WHEN SUBSTR(REPLACE(B.EXECUTIVESTD, '' '', ''''), 0, 9) IN
              (''FZ/T73018'', ''FZ/T73005'') THEN
          ''二等品''
         ELSE
          GETGOODSQUALITY(B.CATEGORYNO)
       END LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKER'') CHECKER,
       ''￥''||to_char(GetNewSalePriceForLabel(B.SHO_ID, b.goo_id),''fm999999990.00'') SalePrice,
       --''￥''||to_char(B.PRICE,''fm999999990.00'') SalePrice,
        (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       CASE G.LABEL_SUPNAME
         WHEN ''SANFU.BE'' THEN
          ''地址1''
         ELSE
          ''地址2''
       END NAME_VAR,

        (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
         (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       NULL COLORNAME,
       NULL SIZENAME,
       (CASE C.BRA_ID    WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       (CASE C.BRA_ID    WHEN ''00'' THEN   1   ELSE   0   END) ISSCENE,
       (CASE C.BRA_ID WHEN ''00'' THEN ''场景：'' ELSE NULL END ) SCENE_1,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN  1  ELSE  0   END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id as QRCode ,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO
  FROM GOODS B
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
    ON B.GOO_ID = T.GOODS_SN
   LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT CASE WHEN B.GOO_ID = ''760750'' THEN ''羽绒服'' ELSE NVL(CASE D.CATEGORYGROUP
                WHEN ''牛仔长裤'' THEN    D.CATEGORYGROUP  ELSE   D.CATEGORIES   END,
              B.PATTERN)  END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       B.EXECUTIVESTD  EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME_NEW,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       CASE
         WHEN SUBSTR(REPLACE(B.EXECUTIVESTD, '' '', ''''), 0, 9) IN
              (''FZ/T73018'', ''FZ/T73005'') THEN
          ''二等品''
         ELSE
          GETGOODSQUALITY(B.CATEGORYNO)
       END LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKER'') CHECKER,
       ''￥''||to_char(GetNewSalePriceForLabel(B.SHO_ID, b.goo_id),''fm999999990.00'') SalePrice,
      -- ''￥''||to_char(B.PRICE,''fm999999990.00'') SalePrice,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       CASE G.LABEL_SUPNAME
         WHEN ''SANFU.BE'' THEN
          ''地址1''
         ELSE
          ''地址2''
       END NAME_VAR,

        (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
         (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       A.COLORNAME,
       A.SIZENAME,
       (CASE C.BRA_ID   WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       (CASE C.BRA_ID   WHEN ''00'' THEN    1   ELSE   0  END) ISSCENE,
       (CASE C.BRA_ID WHEN ''00'' THEN ''场景：'' ELSE NULL END ) SCENE_1,
       A.BARCODE,
       A.SHAPE,
       (CASE
         WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id as QRCode ,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
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
 LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
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
       B.EXECUTIVESTD  EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME_NEW,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       CASE
         WHEN SUBSTR(REPLACE(B.EXECUTIVESTD, '' '', ''''), 0, 9) IN
              (''FZ/T73018'', ''FZ/T73005'') THEN
          ''二等品''
         ELSE
          GETGOODSQUALITY(B.CATEGORYNO)
       END LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKER'') CHECKER,
       ''￥''||to_char(GetNewSalePriceForLabel(B.SHO_ID, b.goo_id),''fm999999990.00'') SalePrice,
       --''￥''||to_char(B.PRICE,''fm999999990.00'') SalePrice,
        (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       CASE G.LABEL_SUPNAME
         WHEN ''SANFU.BE'' THEN
          ''地址1''
         ELSE
          ''地址2''
       END NAME_VAR,

        (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
         (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       NULL COLORNAME,
       NULL SIZENAME,
       (CASE C.BRA_ID    WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       (CASE C.BRA_ID    WHEN ''00'' THEN   1   ELSE   0   END) ISSCENE,
       (CASE C.BRA_ID WHEN ''00'' THEN ''场景：'' ELSE NULL END ) SCENE_1,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN  1  ELSE  0   END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id as QRCode ,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO
  FROM GOODS B
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
    ON B.GOO_ID = T.GOODS_SN
   LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 31 ASC' ;
        
  ELSIF LABEL_ID = '68115' THEN
        V_SQL := 'SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          NVL(D.CATEGORIES, B.PATTERN)
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       B.EXECUTIVESTD EXECUTIVE_STD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE, --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1 ELSE  0 END) ISO2O,
       -- ''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END ) QRCODE,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END ) WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
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
 LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          D.CATEGORIES
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       B.EXECUTIVESTD EXECUTIVE_STD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE, --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1   ELSE  0   END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
      (CASE WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO
  FROM GOODS B
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
    ON B.GOO_ID = T.GOODS_SN
 LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          NVL(D.CATEGORIES, B.PATTERN)
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       B.EXECUTIVESTD EXECUTIVE_STD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE, --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1 ELSE  0 END) ISO2O,
       -- ''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END ) QRCODE,
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END ) WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
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
 LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          D.CATEGORIES
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       B.EXECUTIVESTD EXECUTIVE_STD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE, --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1   ELSE  0   END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
      (CASE WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO
  FROM GOODS B
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
    ON B.GOO_ID = T.GOODS_SN
 LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 23 ASC';
        
        
  ELSIF LABEL_ID = '02186' THEN
        V_SQL := 'SELECT B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       T4.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       G.POSTCODE,
       B.STANDARD,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       ''合格品'' LEVELNAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       A.COLORNAME,
       A.SIZENAME,
       B.GOO_ID,
       A.BARCODE,
       A.SHAPE,
       F.ORD_ID||F.BARCODE ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       f.orderamount - f.gotamount  OWE_AMOUNT_PR,
       (CASE WHEN B.IS_NETGOODS = 0 THEN  1   ELSE  0    END) ISO2O,
       (CASE WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       (CASE WHEN B.IS_NETGOODS = 0 THEN ''微信扫看详情线上购'' ELSE NULL END ) WX_MEMO
--''扫码领88元券'' WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN (SELECT * FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode   
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN PL_DIC_SUBCATEGORY T4
    ON B.SUBCATEGORYNO = T4.SUBCATEGORYNO
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
UNION ALL
SELECT B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       T4.SUBCATEGORY,
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
       G.POSTCODE,
       B.STANDARD,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       ''一等品'' LEVELNAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       f.orderamount - f.gotamount  OWE_AMOUNT_PR,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN   1    ELSE   0   END) ISO2O,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN ''微信扫看详情线上购'' ELSE NULL END) WX_MEMO
--''扫码领88元券'' WX_MEMO
  FROM GOODS B
 INNER JOIN (SELECT * FROM ORDERS Z WHERE Z.ORD_ID||Z.GOO_ID IN (%SELECTION%)) F ON B.GOO_ID=F.GOO_ID   
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN PL_DIC_SUBCATEGORY T4
    ON B.SUBCATEGORYNO = T4.SUBCATEGORYNO
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
 ORDER BY 27 ASC
  ';
        
        
  ELSIF LABEL_ID = '67002' THEN
        V_SQL :=  'SELECT B.ORDERBASEAMOUNT,
       D.CATEGORIES,
       C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       A.COLORNAME,
       A.SIZENAME,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN V_PL_DIC_GOODSTYPE_ALL D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT B.ORDERBASEAMOUNT,
       D.CATEGORIES,
       C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       NULL,
       NULL,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN V_PL_DIC_GOODSTYPE_ALL D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT B.ORDERBASEAMOUNT,
       D.CATEGORIES,
       C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       A.COLORNAME,
       A.SIZENAME,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN V_PL_DIC_GOODSTYPE_ALL D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT B.ORDERBASEAMOUNT,
       D.CATEGORIES,
       C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       NULL,
       NULL,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN V_PL_DIC_GOODSTYPE_ALL D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 4 ASC';
        
   ELSIF LABEL_ID = '68107' THEN
        V_SQL :='SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       A.BAKCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       B.BAKCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       A.BAKCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       B.BAKCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 2 ASC' ;
        
        
    ELSIF LABEL_ID = '68110' THEN
        V_SQL :='SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.BAKCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.BAKCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.BAKCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.BAKCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 2 ASC' ;
        
        
  ELSIF LABEL_ID = '60021' THEN
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
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || TT.COUNTY) ADDRESS,
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
      -- GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
      ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN  1  ELSE  0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' 
       ELSE ''官方正品'' END ) QRCODE,
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END ) WX_MEMO,
       --A.COLORNAME,
       A.SIZENAME,
       A.SHAPE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       (CASE C.BRA_ID   WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       (CASE C.BRA_ID   WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       (CASE C.BRA_ID   WHEN ''00'' THEN   1  ELSE    0   END) ISSCENE
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
  LEFT JOIN DIC_COUNTY TT
    ON G.COUNTYID = TT.COUNTYID
  LEFT JOIN NETGOODS T
    ON A.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
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
 /*WHERE A.BARCODE IN (%SELECTION%)*/
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
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || TT.COUNTY) ADDRESS,
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
      -- GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
      ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
        (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN  1   ELSE    0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE NULL END ) QRCODE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO,
       --NULL COLORNAME,
       NULL SIZENAME,
       NULL SHAPE,
      (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       (CASE C.BRA_ID  WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       (CASE C.BRA_ID  WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       CASE C.BRA_ID  WHEN ''00'' THEN  1  ELSE   0  END ISSCENE
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
  LEFT JOIN DIC_COUNTY TT
    ON G.COUNTYID = TT.COUNTYID
  LEFT JOIN NETGOODS T
    ON B.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
-- Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   /*AND B.GOO_ID IN (%SELECTION%)*/
   ORDER BY 20 ASC';
        
        
   ELSIF LABEL_ID = '68104' THEN
        V_SQL :='SELECT NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME1,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
              ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
              ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
--WHERE b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME1,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
              ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
              ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
--WHERE b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 23 ASC' ;
        
        
    ELSIF LABEL_ID = '60018' THEN
        V_SQL :='SELECT NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME1,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       '''' AS SEASON1,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE B.CATEGORYNO
         WHEN ''3406'' THEN ''号型:''||B.STANDARD ELSE NULL END) STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       --categoryno = 3406  1 else 0   isflag
       CASE B.CATEGORYNO
         WHEN ''3406'' THEN   1  ELSE    0    END ISSELF,
       A.BARCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
              ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
      ( CASE B.CATEGORYNO
         WHEN ''3406'' THEN  ''号型:''||B.STANDARD ELSE NULL END ) STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       CASE B.CATEGORYNO
         WHEN ''3406'' THEN   1  ELSE   0   END ISSELF,
       B.GOO_ID BARCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
--WHERE b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME1,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       '''' AS SEASON1,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE B.CATEGORYNO
         WHEN ''3406'' THEN ''号型:''||B.STANDARD ELSE NULL END) STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       --categoryno = 3406  1 else 0   isflag
       CASE B.CATEGORYNO
         WHEN ''3406'' THEN   1  ELSE    0    END ISSELF,
       A.BARCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
              ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
      ( CASE B.CATEGORYNO
         WHEN ''3406'' THEN  ''号型:''||B.STANDARD ELSE NULL END ) STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       CASE B.CATEGORYNO
         WHEN ''3406'' THEN   1  ELSE   0   END ISSELF,
       B.GOO_ID BARCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
--WHERE b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 24 ASC' ;
        
        
    ELSIF LABEL_ID = '23' THEN
        V_SQL :='SELECT A.BARCODE,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       B.EXECUTIVESTD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       A.GOO_ID,
       A.SHAPE,
       B.MATERIAL,
       G.LABEL_SUPNAME,
       G.LABEL_ADDRESS
/* (select a.code_value from dic_codes a where a.code_type = ''LABEL_PRINT''
and a.sub_code_type = ''LABELPRINT_ADDRESS'') Labelprint_address*/
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT B.GOO_ID BARCODE,
       D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       B.EXECUTIVESTD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       ''08'' CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       NULL SHAPE,
       B.MATERIAL,
       G.LABEL_SUPNAME,
       G.LABEL_ADDRESS
/*(select a.code_value from dic_codes a where a.code_type = ''LABEL_PRINT''
and a.sub_code_type = ''LABELPRINT_ADDRESS'') Labelprint_address*/
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID) /*b.goo_id not in (select goo_id from Articles) */
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT A.BARCODE,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       B.EXECUTIVESTD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       A.GOO_ID,
       A.SHAPE,
       B.MATERIAL,
       G.LABEL_SUPNAME,
       G.LABEL_ADDRESS
/* (select a.code_value from dic_codes a where a.code_type = ''LABEL_PRINT''
and a.sub_code_type = ''LABELPRINT_ADDRESS'') Labelprint_address*/
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT B.GOO_ID BARCODE,
       D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       B.EXECUTIVESTD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       ''08'' CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       NULL SHAPE,
       B.MATERIAL,
       G.LABEL_SUPNAME,
       G.LABEL_ADDRESS
/*(select a.code_value from dic_codes a where a.code_type = ''LABEL_PRINT''
and a.sub_code_type = ''LABELPRINT_ADDRESS'') Labelprint_address*/
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID) /*b.goo_id not in (select goo_id from Articles) */
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 1 ASC' ;
        
        
     ELSIF LABEL_ID = '20076' THEN
        V_SQL :='SELECT B.ORDERBASEAMOUNT,
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
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
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
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
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
        
        
     ELSIF LABEL_ID = '3322' THEN
        V_SQL :='SELECT A.BARCODE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       B.EXECUTIVESTD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       A.GOO_ID,
       A.SHAPE,
       B.MATERIAL,
       G.LABEL_SUPNAME,
       G.LABEL_ADDRESS
/* (select a.code_value from dic_codes a where a.code_type = ''LABEL_PRINT''
and a.sub_code_type = ''LABELPRINT_ADDRESS'') Labelprint_address*/
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
    INNER JOIN (SELECT *
               FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 --WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT B.GOO_ID BARCODE, 
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       B.EXECUTIVESTD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       ''08'' CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       NULL SHAPE,
       B.MATERIAL,
       G.LABEL_SUPNAME,
       G.LABEL_ADDRESS
/*(select a.code_value from dic_codes a where a.code_type = ''LABEL_PRINT''
and a.sub_code_type = ''LABELPRINT_ADDRESS'') Labelprint_address*/
  FROM GOODS B
  INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID) /*b.goo_id not in (select goo_id from Articles) */
   --AND B.GOO_ID IN (%SELECTION%)
   ORDER BY 1 ASC

/*SELECT NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.GOO_ID,
       A.SHAPE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       B.MATERIAL,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN (SELECT *
               FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 --WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       ''08'' CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       B.GOO_ID,
       NULL SHAPE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       B.MATERIAL,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID) /*b.goo_id not in (select goo_id from Articles) */
   --AND B.GOO_ID IN (%SELECTION%)
 ORDER BY 22 ASC*/' ; 
        
      
     ELSIF LABEL_ID = '68124' THEN
        V_SQL := 'SELECT CASE WHEN B.GOO_ID = ''760750'' THEN ''羽绒服'' ELSE NVL(CASE D.CATEGORYGROUP
                WHEN ''牛仔长裤'' THEN    D.CATEGORYGROUP  ELSE   D.CATEGORIES   END,
              B.PATTERN)  END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME1,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       F.ORD_ID||F.BARCODE ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       f.orderamount - f.gotamount  OWE_AMOUNT_PR,
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
       B.EXECUTIVESTD  EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME_NEW,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       CASE
         WHEN SUBSTR(REPLACE(B.EXECUTIVESTD, '' '', ''''), 0, 9) IN
              (''FZ/T73018'', ''FZ/T73005'') THEN
          ''二等品''
         ELSE
          GETGOODSQUALITY(B.CATEGORYNO)
       END LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKER'') CHECKER,
       ''￥''||to_char(GetNewSalePriceForLabel(B.SHO_ID, b.goo_id),''fm999999990.00'') SalePrice,
       --''￥''||to_char(B.PRICE,''fm999999990.00'') SalePrice,
        (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       CASE G.LABEL_SUPNAME
         WHEN ''SANFU.BE'' THEN
          ''地址1''
         ELSE
          ''地址2''
       END NAME_VAR,
      (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
      (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       A.COLORNAME,
       A.SIZENAME,
       (CASE C.BRA_ID    WHEN ''00'' THEN B.SCENE ELSE NULL END) SCENE,
       (CASE C.BRA_ID    WHEN ''00'' THEN  1 ELSE  0  END )ISSCENE,
       (CASE C.BRA_ID    WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       A.BARCODE,
       A.SHAPE,
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN 1 ELSE  0 END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id as QRCode ,
      (CASE  WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END ) QRCODE,
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A  WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND A.SUB_CODE_TYPE = ''WX_MEMO_01'')
          ELSE NULL END ) WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN (SELECT * FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
 /*WHERE A.BARCODE IN   (%SELECTION%)*/
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
       F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       F.orderamount - F.gotamount OWE_AMOUNT_PR,
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
       B.EXECUTIVESTD  EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME_NEW,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       CASE
         WHEN SUBSTR(REPLACE(B.EXECUTIVESTD, '' '', ''''), 0, 9) IN
              (''FZ/T73018'', ''FZ/T73005'') THEN
          ''二等品''
         ELSE
          GETGOODSQUALITY(B.CATEGORYNO)
       END LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKER'') CHECKER,
      ''￥''||to_char(GetNewSalePriceForLabel(B.SHO_ID, b.goo_id),''fm999999990.00'') SalePrice,
       --''￥''||to_char(B.PRICE,''fm999999990.00'') SalePrice,
        (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       CASE G.LABEL_SUPNAME
         WHEN ''SANFU.BE'' THEN
          ''地址1''
         ELSE
          ''地址2''
       END NAME_VAR,
      (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
      (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       NULL COLORNAME,
       NULL SIZENAME,
       (CASE C.BRA_ID  WHEN ''00'' THEN B.SCENE ELSE NULL END) SCENE,
       CASE C.BRA_ID   WHEN ''00'' THEN  1  ELSE  0  END ISSCENE,
       (CASE C.BRA_ID  WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN 1 ELSE 0 END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id as QRCode ,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
         ELSE ''官方正品'' END )QRCODE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN (SELECT A.CODE_VALUE FROM DIC_CODES A  WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND A.SUB_CODE_TYPE = ''WX_MEMO_01'')
        ELSE NULL END ) WX_MEMO
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   /*AND B.GOO_ID IN (%SELECTION%)*/ ORDER BY 30 ASC' ; 
        
      
     ELSIF LABEL_ID = '60020' THEN
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
       --GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
      (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
      (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
      (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       B.SCENE,
       (CASE  C.BRA_ID    WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       CASE C.BRA_ID    WHEN ''00'' THEN  1  ELSE   0  END ISSCENE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
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
 WHERE A.BARCODE IN (%SELECTION%)
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
       --GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1  ELSE  0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
        (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
        ELSE ''官方正品'' END) QRCODE,
        (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''扫码领88元券''
        ELSE NULL END) WX_MEMO,
       NULL SIZENAME,
       NULL SHAPE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
      (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
      (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       B.SCENE,
       (CASE C.BRA_ID   WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       CASE C.BRA_ID   WHEN ''00'' THEN   1  ELSE   0  END ISSCENE
  FROM GOODS B
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
    ON B.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT CASE
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
       --GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
      (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
      (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       B.SCENE,
       (CASE  C.BRA_ID    WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       CASE C.BRA_ID    WHEN ''00'' THEN  1  ELSE   0  END ISSCENE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
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
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
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
       --GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
       (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1  ELSE  0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
        (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
        ELSE ''官方正品'' END) QRCODE,
        (CASE  WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN ''扫码领88元券''
        ELSE NULL END) WX_MEMO,
       NULL SIZENAME,
       NULL SHAPE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
      (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
      (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       B.SCENE,
       (CASE C.BRA_ID   WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       CASE C.BRA_ID   WHEN ''00'' THEN   1  ELSE   0  END ISSCENE
  FROM GOODS B
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
    ON B.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
 ORDER BY 20 ASC  ' ; 
        
        
     ELSIF LABEL_ID = '60022' THEN
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
       --GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE  G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
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
       --GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE  G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   /*AND B.GOO_ID IN (%SELECTION%)*/
 ORDER BY 20 ASC  ' ; 
        
        
      ELSIF LABEL_ID = '71006' THEN
        V_SQL := 'Select b.Price,
       b.Specs,
       b.Goo_Id,
       b.Executivestd,
       Getcomposname(a.Goo_Id) Composname,
       ''￥'' || TO_CHAR(Getnewsalepriceforlabel(B.SHO_ID, b.Goo_Id),''fm999999990.00'') Saleprice,
       a.Barcode,
        F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       F.orderamount - F.gotamount OWE_AMOUNT_PR,
       a.colorname
  From Articles a
 Inner Join Goods b
    On a.Goo_Id = b.Goo_Id
   INNER JOIN (SELECT * FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode  
 --Where a.Barcode In (%Selection%)
Union All
Select b.Price,
       b.Specs,
       b.Goo_Id,
       b.Executivestd,
       Getcomposname(b.Goo_Id) Composname,
       ''￥'' || TO_CHAR(Getnewsalepriceforlabel(B.SHO_ID, b.Goo_Id),''fm999999990.00'') Saleprice,
       b.Goo_Id Barcode,
        F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       F.orderamount - F.gotamount OWE_AMOUNT_PR,
       Null colorname
  From Goods b
   INNER JOIN (SELECT * FROM ORDERS Z WHERE Z.ORD_ID||Z.GOO_ID IN (%SELECTION%)) F ON B.GOO_ID=F.GOO_ID
 --Where b.Goo_Id Not In (Select Goo_Id From Articles)
where not exists(select 1 from Articles t where b.goo_id = t.goo_id)
   --And b.Goo_Id In (%Selection%)
   ORDER BY 7 ASC'; 
        
        
       ELSIF LABEL_ID = '40186' THEN
        V_SQL :=  'SELECT NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME1,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
                     ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       A.SHAPE
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
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
 --WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
                     ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       B.STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
--WHERE b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   --AND B.GOO_ID IN (%SELECTION%)
 ORDER BY 23 ASC'; 
        
        
        ELSIF LABEL_ID =  '51186' THEN
        V_SQL := 'SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          NVL(D.CATEGORIES, B.PATTERN)
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       B.EXECUTIVESTD EXECUTIVE_STD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE, --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE,
       F.ORD_ID || F.BARCODE ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       (CASE
         WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN
          1
         ELSE
          0
       END) ISO2O,
       -- ''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE
         WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN
          ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
         ELSE
          ''官方正品''
       END) QRCODE,
       (CASE
         WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
              AND A.SUB_CODE_TYPE = ''WX_MEMO_01'')
         ELSE
          NULL
       END) WX_MEMO
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
   LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0     
--WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          D.CATEGORIES
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       B.EXECUTIVESTD EXECUTIVE_STD, --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE, --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
      (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
      (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
      (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       (CASE
         WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN
          1
         ELSE
          0
       END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE
         WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN
          ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
         ELSE
          ''官方正品''
       END) QRCODE,
       (CASE
         WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
              AND A.SUB_CODE_TYPE = ''WX_MEMO_01'')
         ELSE
          NULL
       END) WX_MEMO
  FROM GOODS B
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
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
    ON B.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
--AND B.GOO_ID IN (%SELECTION%)
 ORDER BY 23 ASC'; 
        
        
        
       ELSIF LABEL_ID = '81006' THEN
        V_SQL :='SELECT NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME1,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       '''' AS SEASON1,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       (CASE B.CATEGORYNO
         WHEN ''3406'' THEN
          ''号型:'' || B.STANDARD
         ELSE
          NULL
       END) STANDARD,
       A.COLORNAME,
       A.SIZENAME,
       --categoryno = 3406  1 else 0   isflag
       CASE B.CATEGORYNO
         WHEN ''3406'' THEN
          1
         ELSE
          0
       END ISSELF,
       A.BARCODE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       A.SHAPE
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
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
-- WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT D.CATEGORIES,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
       B.SERIES,
       B.SPECS, /*decode(b.SEASON,''春'',''C'',''夏1'',''X1'',''夏2'',''X2'',''秋'',''Q'',''冬'',''D'',''冬1'',
                     ''D1'',''冬2'',''D2'',''冬2+'',''D2+'',''冬3'',''D3'',''春夏季'',''CX'',''秋冬季'',''QD'',''四季'',''SJ'')*/
       '''' AS SEASON1,
       --nvl(d.Sup_name,g.Sup_Name) Sup_Name,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'') LABELPRINT_NAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'') LABELPRINT_ADDRESS,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT''
           AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'') LABELPRINT_TEL,
       B.EXECUTIVESTD EXECUTIVE_STD,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       B.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       --nvl(d.LableAddress,t1.province||t2.city||t3.county) Address,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''CHECKERS'') CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       (CASE B.CATEGORYNO
         WHEN ''3406'' THEN
          ''号型:'' || B.STANDARD
         ELSE
          NULL
       END) STANDARD,
       NULL COLORNAME,
       NULL SIZENAME,
       CASE B.CATEGORYNO
         WHEN ''3406'' THEN
          1
         ELSE
          0
       END ISSELF,
       B.GOO_ID BARCODE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
--WHERE b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
-- AND B.GOO_ID IN (%SELECTION%)
 ORDER BY 24 ASC' ; 
        
        
        
       ELSIF LABEL_ID = '31719' THEN
        V_SQL :='SELECT D.SUBCATEGORY,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       B.SPECS,
       B.GOO_NAME,
       B.GOO_ID,
       B.EXECUTIVESTD,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE, ''yyyy/mm/dd'') DELIVERDATE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKER'') Checker,*/
       K1.CODE_VALUE CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE,
       F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       F.orderamount - F.gotamount OWE_AMOUNT_PR,
       B.STANDARD,
       B.SERIES,
       B.SPESC_TYPE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''LEVELNAME'') Levelname,*/
       K2.CODE_VALUE LEVELNAME,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       ''https://m.sanfu.com/d?g='' || B.GOO_ID QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO*/
       K3.CODE_VALUE WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
     INNER JOIN (SELECT * FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
   LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKER'') K1
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''LEVELNAME'') K2
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') K3
    ON 1 = 1
 --WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT D.SUBCATEGORY,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       B.SPECS,
       B.GOO_NAME,
       B.GOO_ID,
       B.EXECUTIVESTD,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE, ''yyyy/mm/dd'') DELIVERDATE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKER'') Checker,*/
       K1.CODE_VALUE CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       F.orderamount - F.gotamount OWE_AMOUNT_PR,
       B.STANDARD,
       B.SERIES,
       B.SPESC_TYPE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''LEVELNAME'') Levelname,*/
       K2.CODE_VALUE LEVELNAME,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       ''https://m.sanfu.com/d?g='' || B.GOO_ID QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO*/
       K3.CODE_VALUE WX_MEMO
  FROM GOODS B
   INNER JOIN (SELECT * FROM ORDERS Z WHERE Z.ORD_ID||Z.GOO_ID IN (%SELECTION%)) F ON B.GOO_ID=F.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
   LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKER'') K1
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''LEVELNAME'') K2
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') K3
    ON 1 = 1
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   --AND B.GOO_ID IN (%SELECTION%)
   ORDER BY 16 ASC' ; 
        
        
        
        ELSIF LABEL_ID = '11168' THEN
        V_SQL := 'SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE, ''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       --a.SizeName,
       B.GOO_ID,
       A.BARCODE,
       F.ORD_ID || F.BARCODE ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       --a.shape,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          ''https://m.sanfu.com/d?g='' || B.GOO_ID
         ELSE
          ''官方正品''
       END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO,*/
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          TWXMEMO.CODE_VALUE
         ELSE
          NULL
       END) WX_MEMO,
       SUBSTR(A.SHAPE,
              INSTR(A.SHAPE, ''/'') + 1,
              LENGTH(A.SHAPE) - INSTR(A.SHAPE, ''/'')) AS SIZENAME_NEW,
       SUBSTR(A.SHAPE, 1, INSTR(A.SHAPE, ''/'') - 1) AS SHAPE_NEW
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
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID

  LEFT JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
-- WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE, ''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
       --Null SizeName, 
       B.GOO_ID,
       B.GOO_ID BARCODE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       --null shape,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          ''https://m.sanfu.com/d?g='' || B.GOO_ID
         ELSE
          ''官方正品''
       END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO,*/
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          TWXMEMO.CODE_VALUE
         ELSE
          NULL
       END) WX_MEMO,
       NULL SIZENAME_NEW,
       NULL SHAPE_NEW
  FROM GOODS B
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   --AND B.GOO_ID IN (%SELECTION%)
 ORDER BY 29 ASC'; 
        
        
        ELSIF LABEL_ID = '60186' THEN
        V_SQL :='SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       SUBSTR(A.SHAPE,
              INSTR(A.SHAPE, ''/'') + 1,
              LENGTH(A.SHAPE) - INSTR(A.SHAPE, ''/'')) AS SIZENAME_NEW,
       B.GOO_ID,
       A.BARCODE,
       F.ORD_ID||F.BARCODE ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       f.orderamount - f.gotamount  OWE_AMOUNT_PR,
       SUBSTR(A.SHAPE, 1, INSTR(A.SHAPE, ''/'') - 1) AS SHAPE_NEW,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
         ELSE
          ''官方正品''
       END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          TWXMEMO.WX_MEMO
         ELSE
          NULL
       END) WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
     INNER JOIN (SELECT * FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                       A.CODE_VALUE
                    END) LEVELNAME,
                    MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''CHECKER'' THEN
                       A.CODE_VALUE
                    END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
 --WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       DECODE(B.SEASON,
              ''春'',
              ''C'',
              ''夏'',
              ''1'',
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
       NULL SIZENAME_NEW,
       B.GOO_ID,
       B.GOO_ID BARCODE,
       F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       F.orderamount  ORDER_AMOUNT,
       f.orderamount - f.gotamount  OWE_AMOUNT_PR,
       NULL SHAPE_NEW,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
         ELSE
          ''官方正品''
       END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          TWXMEMO.WX_MEMO
         ELSE
          NULL
       END) WX_MEMO
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
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                       A.CODE_VALUE
                    END) LEVELNAME,
                    MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''CHECKER'' THEN
                       A.CODE_VALUE
                    END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   --AND B.GOO_ID IN (%SELECTION%)
 ORDER BY 33 ASC' ;           
        
        
         ELSIF LABEL_ID = '60019' THEN
        V_SQL :='SELECT CASE
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
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || TT.COUNTY) ADDRESS,
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
      -- GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
      ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN  1  ELSE  0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END ) QRCODE,
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END ) WX_MEMO,
       --A.COLORNAME,
       A.SIZENAME,
       A.SHAPE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       (CASE C.BRA_ID   WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       (CASE C.BRA_ID   WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       (CASE C.BRA_ID   WHEN ''00'' THEN   1  ELSE    0   END) ISSCENE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
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
  LEFT JOIN DIC_COUNTY TT
    ON G.COUNTYID = TT.COUNTYID
  LEFT JOIN NETGOODS T
    ON A.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
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
 WHERE A.BARCODE IN (%SELECTION%)
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
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || TT.COUNTY) ADDRESS,
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
      -- GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
      ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
        (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN  1   ELSE    0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE NULL END ) QRCODE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO,
       --NULL COLORNAME,
       NULL SIZENAME,
       NULL SHAPE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       (CASE C.BRA_ID  WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       (CASE C.BRA_ID  WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       CASE C.BRA_ID  WHEN ''00'' THEN  1  ELSE   0  END ISSCENE
  FROM GOODS B
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
  LEFT JOIN DIC_COUNTY TT
    ON G.COUNTYID = TT.COUNTYID
  LEFT JOIN NETGOODS T
    ON B.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
-- Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT CASE
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
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || TT.COUNTY) ADDRESS,
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
      -- GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
      ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN  1  ELSE  0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END ) QRCODE,
       (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END ) WX_MEMO,
       --A.COLORNAME,
       A.SIZENAME,
       A.SHAPE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       (CASE C.BRA_ID   WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       (CASE C.BRA_ID   WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       (CASE C.BRA_ID   WHEN ''00'' THEN   1  ELSE    0   END) ISSCENE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
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
  LEFT JOIN DIC_COUNTY TT
    ON G.COUNTYID = TT.COUNTYID
  LEFT JOIN NETGOODS T
    ON A.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
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
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
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
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || TT.COUNTY) ADDRESS,
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
      -- GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID) SALEPRICE,
      ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
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
        (CASE  WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN  1   ELSE    0  END) ISO2O,
       --''https://m.sanfu.com/d?g='' || b.Goo_Id As Qrcode,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE NULL END ) QRCODE,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND B.IS_NETGOODS = 0  THEN (SELECT A.CODE_VALUE
          FROM DIC_CODES A
         WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
           AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') ELSE NULL END) WX_MEMO,
       --NULL COLORNAME,
       NULL SIZENAME,
       NULL SHAPE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       (CASE C.BRA_ID  WHEN ''00'' THEN ''场景：'' ELSE NULL END) SCENE_1,
       (CASE C.BRA_ID  WHEN ''00'' THEN B.SCENE ELSE NULL END ) SCENE,
       CASE C.BRA_ID  WHEN ''00'' THEN  1  ELSE   0  END ISSCENE
  FROM GOODS B
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
  LEFT JOIN DIC_COUNTY TT
    ON G.COUNTYID = TT.COUNTYID
  LEFT JOIN NETGOODS T
    ON B.GOO_ID = T.GOODS_SN
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
-- Where b.Goo_Id Not In (Select Goo_Id From Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 20 ASC' ;  
        
        
         ELSIF LABEL_ID =  '91713' THEN
        V_SQL :='SELECT D.SUBCATEGORY,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       B.SPECS,
       B.GOO_NAME,
       B.GOO_ID,
       B.EXECUTIVESTD,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE, ''yyyy/mm/dd'') DELIVERDATE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKER'') Checker,*/
       K1.CODE_VALUE CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
        (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE,
       B.STANDARD,
       B.SERIES,
       B.SPESC_TYPE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''LEVELNAME'') Levelname,*/
       K2.CODE_VALUE LEVELNAME,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       ''https://m.sanfu.com/d?g='' || B.GOO_ID QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO*/
       K3.CODE_VALUE WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKER'') K1
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''LEVELNAME'') K2
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') K3
    ON 1 = 1
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT D.SUBCATEGORY,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       B.SPECS,
       B.GOO_NAME,
       B.GOO_ID,
       B.EXECUTIVESTD,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE, ''yyyy/mm/dd'') DELIVERDATE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKER'') Checker,*/
       K1.CODE_VALUE CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       B.STANDARD,
       B.SERIES,
       B.SPESC_TYPE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''LEVELNAME'') Levelname,*/
       K2.CODE_VALUE LEVELNAME,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       ''https://m.sanfu.com/d?g='' || B.GOO_ID QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO*/
       K3.CODE_VALUE WX_MEMO
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKER'') K1
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''LEVELNAME'') K2
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') K3
    ON 1 = 1
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
  UNION ALL
  SELECT D.SUBCATEGORY,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       B.SPECS,
       B.GOO_NAME,
       B.GOO_ID,
       B.EXECUTIVESTD,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE, ''yyyy/mm/dd'') DELIVERDATE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKER'') Checker,*/
       K1.CODE_VALUE CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE,
       B.STANDARD,
       B.SERIES,
       B.SPESC_TYPE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''LEVELNAME'') Levelname,*/
       K2.CODE_VALUE LEVELNAME,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       ''https://m.sanfu.com/d?g='' || B.GOO_ID QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO*/
       K3.CODE_VALUE WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKER'') K1
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''LEVELNAME'') K2
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') K3
    ON 1 = 1
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT D.SUBCATEGORY,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       B.SPECS,
       B.GOO_NAME,
       B.GOO_ID,
       B.EXECUTIVESTD,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE, ''yyyy/mm/dd'') DELIVERDATE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKER'') Checker,*/
       K1.CODE_VALUE CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       B.STANDARD,
       B.SERIES,
       B.SPESC_TYPE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''LEVELNAME'') Levelname,*/
       K2.CODE_VALUE LEVELNAME,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       ''https://m.sanfu.com/d?g='' || B.GOO_ID QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO*/
       K3.CODE_VALUE WX_MEMO
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
--Where b.Goo_Id Not In (Select Goo_Id From Articles)
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKER'') K1
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM NSFDATA.DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''LEVELNAME'') K2
    ON 1 = 1
 INNER JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') K3
    ON 1 = 1
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 16 ASC' ;  
        
        
         ELSIF LABEL_ID = '68111' THEN
        V_SQL := 'SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       --a.SizeName,
        b.goo_id,
        a.Barcode,
        --a.shape,
       (CASE  WHEN B.IS_NETGOODS = 0 THEN  1  ELSE  0  END) ISO2O,
       (CASE  WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO,*/
       (CASE  WHEN B.IS_NETGOODS = 0 THEN TWXMEMO.CODE_VALUE ELSE NULL END) WX_MEMO,
       SUBSTR(A.SHAPE,
              INSTR(A.SHAPE, ''/'') + 1,
              LENGTH(A.SHAPE) - INSTR(A.SHAPE, ''/'')) AS SIZENAME_NEW,
       SUBSTR(A.SHAPE, 1, INSTR(A.SHAPE, ''/'') - 1) AS SHAPE_NEW
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID

  LEFT JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
        --Null SizeName,
        b.goo_id,
        b.Goo_ID Barcode,
        --null shape,
       (CASE  WHEN B.IS_NETGOODS = 0 THEN  1  ELSE  0   END) ISO2O,
       (CASE  WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO,*/
       (CASE  WHEN B.IS_NETGOODS = 0 THEN TWXMEMO.CODE_VALUE ELSE NULL END) WX_MEMO,
       NULL               SIZENAME_NEW,
       NULL               SHAPE_NEW
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       --a.SizeName,
        b.goo_id,
        a.Barcode,
        --a.shape,
       (CASE  WHEN B.IS_NETGOODS = 0 THEN  1  ELSE  0  END) ISO2O,
       (CASE  WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO,*/
       (CASE  WHEN B.IS_NETGOODS = 0 THEN TWXMEMO.CODE_VALUE ELSE NULL END) WX_MEMO,
       SUBSTR(A.SHAPE,
              INSTR(A.SHAPE, ''/'') + 1,
              LENGTH(A.SHAPE) - INSTR(A.SHAPE, ''/'')) AS SIZENAME_NEW,
       SUBSTR(A.SHAPE, 1, INSTR(A.SHAPE, ''/'') - 1) AS SHAPE_NEW
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID

  LEFT JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD,
       --TRUNC(SYSDATE) DELIVERDATE,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
        --Null SizeName,
        b.goo_id,
        b.Goo_ID Barcode,
        --null shape,
       (CASE  WHEN B.IS_NETGOODS = 0 THEN  1  ELSE  0   END) ISO2O,
       (CASE  WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO'') WX_MEMO,*/
       (CASE  WHEN B.IS_NETGOODS = 0 THEN TWXMEMO.CODE_VALUE ELSE NULL END) WX_MEMO,
       NULL               SIZENAME_NEW,
       NULL               SHAPE_NEW
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT A.CODE_VALUE
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 29 ASC';  
        
        
         ELSIF LABEL_ID =  '11' THEN
        V_SQL :=  'SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID) /*b.goo_id not in (select goo_id from Articles) */
   AND GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID) /*b.goo_id not in (select goo_id from Articles) */
   AND GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 2 ASC';  
        
        
         ELSIF LABEL_ID = '68106' THEN
        V_SQL :='SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE   G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE  G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       SUBSTR(A.SHAPE,
              INSTR(A.SHAPE, ''/'') + 1,
              LENGTH(A.SHAPE) - INSTR(A.SHAPE, ''/'')) AS SIZENAME_NEW,
       B.GOO_ID,
       A.BARCODE,
       SUBSTR(A.SHAPE, 1, INSTR(A.SHAPE, ''/'') - 1) AS SHAPE_NEW,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN   1   ELSE     0       END) ISO2O,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' ELSE ''官方正品'' END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       (CASE   WHEN B.IS_NETGOODS = 0 THEN TWXMEMO.WX_MEMO ELSE NULL END) WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                       A.CODE_VALUE
                    END) LEVELNAME,
                    MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''CHECKER'' THEN
                       A.CODE_VALUE
                    END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       DECODE(B.SEASON,
              ''春'',
              ''C'',
              ''夏'',
              ''1'',
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE   G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE  G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
       NULL SIZENAME_NEW,
       B.GOO_ID,
       B.GOO_ID BARCODE,
       NULL SHAPE_NEW,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE    WHEN B.IS_NETGOODS = 0 THEN    1   ELSE    0    END) ISO2O,
       (CASE    WHEN B.IS_NETGOODS = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' ELSE ''官方正品'' END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       (CASE    WHEN B.IS_NETGOODS = 0 THEN TWXMEMO.WX_MEMO ELSE NULL END) WX_MEMO
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                       A.CODE_VALUE
                    END) LEVELNAME,
                    MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''CHECKER'' THEN
                       A.CODE_VALUE
                    END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE   G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE  G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       SUBSTR(A.SHAPE,
              INSTR(A.SHAPE, ''/'') + 1,
              LENGTH(A.SHAPE) - INSTR(A.SHAPE, ''/'')) AS SIZENAME_NEW,
       B.GOO_ID,
       A.BARCODE,
       SUBSTR(A.SHAPE, 1, INSTR(A.SHAPE, ''/'') - 1) AS SHAPE_NEW,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN   1   ELSE     0       END) ISO2O,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' ELSE ''官方正品'' END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       (CASE   WHEN B.IS_NETGOODS = 0 THEN TWXMEMO.WX_MEMO ELSE NULL END) WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                       A.CODE_VALUE
                    END) LEVELNAME,
                    MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''CHECKER'' THEN
                       A.CODE_VALUE
                    END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES1,
       B.SERIES,
       B.SPECS,
       DECODE(B.SEASON,
              ''春'',
              ''C'',
              ''夏'',
              ''1'',
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
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_NAME'')
         ELSE
          NVL(D.SUP_NAME, G.SUP_NAME)
       END SUP_NAME,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_TEL'')
         ELSE
          G.PHONENUMBER
       END PHONENUMBER,
       CASE
         WHEN B.GOO_NAME LIKE ''%SANFU%'' OR B.GOO_NAME LIKE ''%飒达夏%'' OR
              B.GOO_NAME LIKE ''%SATTACHERA%'' THEN
          (SELECT A.CODE_VALUE
             FROM DIC_CODES A
            WHERE A.CODE_TYPE = ''LABEL_PRINT''
              AND A.SUB_CODE_TYPE = ''LABELPRINT_ADDRESS'')
         ELSE
          NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY)
       END ADDRESS,
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE   G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE  G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
       NULL SIZENAME_NEW,
       B.GOO_ID,
       B.GOO_ID BARCODE,
       NULL SHAPE_NEW,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE    WHEN B.IS_NETGOODS = 0 THEN    1   ELSE    0    END) ISO2O,
       (CASE    WHEN B.IS_NETGOODS = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' ELSE ''官方正品'' END) QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       (CASE    WHEN B.IS_NETGOODS = 0 THEN TWXMEMO.WX_MEMO ELSE NULL END) WX_MEMO
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                       A.CODE_VALUE
                    END) LEVELNAME,
                    MAX(CASE
                      WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                           A.SUB_CODE_TYPE = ''CHECKER'' THEN
                       A.CODE_VALUE
                    END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 33 ASC' ;  
        
        
         ELSIF LABEL_ID = '68112' THEN
        V_SQL := 'SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       A.SIZENAME,
       B.GOO_ID,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       A.BARCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
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
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       B.GOO_ID BARCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       A.SIZENAME,
       B.GOO_ID,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       A.BARCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
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
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE,''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       B.GOO_ID BARCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
  ORDER BY 28 ASC';  
        
         ELSIF LABEL_ID = '68120' THEN
        V_SQL :='SELECT B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       T4.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       G.POSTCODE,
       B.STANDARD,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       ''合格品'' LEVELNAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS, 
       A.COLORNAME,
       A.SIZENAME,
       B.GOO_ID,
       A.BARCODE,
       A.SHAPE,
       (CASE WHEN B.IS_NETGOODS = 0 THEN  1   ELSE  0    END) ISO2O,
       (CASE WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       (CASE WHEN B.IS_NETGOODS = 0 THEN ''微信扫看详情线上购'' ELSE NULL END ) WX_MEMO
--''扫码领88元券'' WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN PL_DIC_SUBCATEGORY T4
    ON B.SUBCATEGORYNO = T4.SUBCATEGORYNO
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0   
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       T4.SUBCATEGORY,
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
       G.POSTCODE,
       B.STANDARD,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       ''一等品'' LEVELNAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN   1    ELSE   0   END) ISO2O,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN ''微信扫看详情线上购'' ELSE NULL END) WX_MEMO
--''扫码领88元券'' WX_MEMO
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN PL_DIC_SUBCATEGORY T4
    ON B.SUBCATEGORYNO = T4.SUBCATEGORYNO
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0   
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
   UNION ALL
   SELECT B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       T4.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       G.POSTCODE,
       B.STANDARD,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       ''合格品'' LEVELNAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       A.COLORNAME,
       A.SIZENAME,
       B.GOO_ID,
       A.BARCODE,
       A.SHAPE,
       (CASE WHEN B.IS_NETGOODS = 0 THEN  1   ELSE  0    END) ISO2O,
       (CASE WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       (CASE WHEN B.IS_NETGOODS = 0 THEN ''微信扫看详情线上购'' ELSE NULL END ) WX_MEMO
--''扫码领88元券'' WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN PL_DIC_SUBCATEGORY T4
    ON B.SUBCATEGORYNO = T4.SUBCATEGORYNO
 LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       T4.SUBCATEGORY,
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
       G.POSTCODE,
       B.STANDARD,
       B.EXECUTIVESTD EXECUTIVE_STD,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       ''一等品'' LEVELNAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN   1    ELSE   0   END) ISO2O,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN ''https://m.sanfu.com/d?g='' || B.GOO_ID ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCode,
       (CASE   WHEN B.IS_NETGOODS = 0 THEN ''微信扫看详情线上购'' ELSE NULL END) WX_MEMO
--''扫码领88元券'' WX_MEMO
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN PL_DIC_SUBCATEGORY T4
    ON B.SUBCATEGORYNO = T4.SUBCATEGORYNO
 LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0    
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 27 ASC' ;  
        
        
         ELSIF LABEL_ID =  '111' THEN
        V_SQL := 'SELECT C.BRA_NAME,
       A.BARCODE,
       F.ORD_ID || F.BARCODE ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
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
--WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE
  FROM GOODS B
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID) /*b.goo_id not in (select goo_id from Articles) */
--AND GOO_ID IN (%SELECTION%)
 ORDER BY 2 ASC'; 
        
         ELSIF LABEL_ID = '21186' THEN
        V_SQL := 'SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES1,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE, ''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(A.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       A.COLORNAME,
       A.SIZENAME,
       B.GOO_ID,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       A.BARCODE,
       F.ORD_ID || F.BARCODE ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       A.SHAPE
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
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN D.CUSGROUPNAME IN (''男鞋'', ''女鞋'') AND B.GOO_NAME LIKE ''%SANFU%'' THEN
          ''飒达夏''
         ELSE
          B.GOO_NAME
       END GOO_NAME,
       B.BRA_ID,
       NVL(D.CATEGORIES, B.PATTERN) CATEGORIES,
       D.CATEGORYGROUP,
       D.SUBCATEGORY,
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
       G.POSTCODE,
       B.EXECUTIVESTD EXECUTIVE_STD,
       TO_CHAR(SYSDATE, ''YYYY/MM/DD'') DELIVERDATE,
       --b.SafetyType,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       E.TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       GETCOMPOSNAME_1(B.GOO_ID) COMPOSNAME_1,
       T1.PROVINCE || T2.CITY ADDRESS_BAK,
       Q1.LEVELNAME,
       Q1.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID,
       (CASE
         WHEN B.IS_NETGOODS = 0 THEN
          1
         ELSE
          0
       END) ISO2O,
       B.GOO_ID BARCODE,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
  LEFT JOIN NSFDATA.V_PL_DIC_GOODSTYPE D
    ON B.CUSGROUPNO = D.CUSGROUPNO
   AND B.CATEGORYGROUPNO = D.CATEGORYGROUPNO
   AND B.CATEGORYNO = D.CATEGORYNO
   AND B.SUBCATEGORYNO = D.SUBCATEGORYNO
  LEFT JOIN PL_DIC_CATEGORY_TOUCH E
    ON B.BRA_ID = E.BRA_ID
   AND NVL(SUBSTR(B.SAFE_TYPE, -2), B.TOUCHCLASS) = E.TOUCHCLASS
 INNER JOIN SUPPLIER G
    ON B.SUP_ID = G.SUP_ID
  LEFT JOIN DIC_PROVINCE T1
    ON G.PROVINCEID = T1.PROVINCEID
  LEFT JOIN DIC_CITY T2
    ON G.CITYNO = T2.CITYNO
  LEFT JOIN DIC_COUNTY T3
    ON G.COUNTYID = T3.COUNTYID
  LEFT JOIN (SELECT MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''LEVELNAME'' THEN
                           A.CODE_VALUE
                        END) LEVELNAME,
                    MAX(CASE
                          WHEN A.CODE_TYPE = ''LABEL_PRINT_DEFAULT'' AND
                               A.SUB_CODE_TYPE = ''CHECKER'' THEN
                           A.CODE_VALUE
                        END) CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE IN (''LEVELNAME'', ''CHECKER'')) Q1
    ON 1 = 1
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
--AND B.GOO_ID IN (%SELECTION%)
 ORDER BY 28 ASC' ;  
        
        
         ELSIF LABEL_ID = '81009' THEN
        V_SQL :=  'SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          NVL(D.CATEGORIES, B.PATTERN)
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       GG.EXECUTIVESTD1,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKERS'') Checker,*/
       TCHECKER.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE,
       (CASE   WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN 1  ELSE  0  END) ISO2O,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCODE,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       TWXMEMO.WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID

  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT A.CODE_VALUE CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKERS'') TCHECKER
    ON 1 = 1
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
  LEFT JOIN (SELECT REPLACE(LISTAGG(TO_CHAR(EXECUTIVESTD) || CHR(13)) WITHIN
                            GROUP(ORDER BY EXECUTIVESTD),
                            '' '',
                            '''') AS EXECUTIVESTD1,
                    MAX(GOO_ID) GOO_ID
               FROM (SELECT CASE
                              WHEN ROWNUM = 1 THEN
                               ''文胸'' || EXECUTIVESTD
                              WHEN ROWNUM = 2 THEN
                               ''内裤'' || EXECUTIVESTD
                            END EXECUTIVESTD,
                            GOO_ID
                       FROM (SELECT REGEXP_SUBSTR(NAME, ''[^;]+'', 1, LEVEL) AS EXECUTIVESTD,
                                    ROWNUM,
                                    GOO_ID
                               FROM (SELECT AA.EXECUTIVESTD AS NAME, AA.GOO_ID
                                       FROM GOODS AA
                                      INNER JOIN ARTICLES TT
                                         ON AA.GOO_ID = TT.GOO_ID
                                      WHERE TT.BARCODE IN (%SELECTION%))
                             CONNECT BY REGEXP_SUBSTR(NAME, ''[^;]+'', 1, LEVEL) IS NOT NULL))) GG
    ON GG.GOO_ID = B.GOO_ID
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          D.CATEGORIES
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       GG.EXECUTIVESTD1,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKERS'') Checker,*/
       TCHECKER.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1  ELSE    0  END) ISO2O,
        (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCODE,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       TWXMEMO.WX_MEMO
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID

  LEFT JOIN (SELECT A.CODE_VALUE CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKERS'') TCHECKER
    ON 1 = 1
  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
  LEFT JOIN (SELECT REPLACE(LISTAGG(TO_CHAR(EXECUTIVESTD) || CHR(13)) WITHIN
                            GROUP(ORDER BY EXECUTIVESTD),
                            '' '',
                            '''') AS EXECUTIVESTD1,
                    MAX(GOO_ID) GOO_ID
               FROM (SELECT CASE
                              WHEN ROWNUM = 1 THEN
                               ''文胸'' || EXECUTIVESTD
                              WHEN ROWNUM = 2 THEN
                               ''内裤'' || EXECUTIVESTD
                            END EXECUTIVESTD,
                            GOO_ID
                       FROM (SELECT REGEXP_SUBSTR(NAME, ''[^;]+'', 1, LEVEL) AS EXECUTIVESTD,
                                    ROWNUM,
                                    GOO_ID
                               FROM (SELECT A.EXECUTIVESTD AS NAME, A.GOO_ID
                                       FROM GOODS A
                                      WHERE A.GOO_ID NOT IN
                                            (SELECT GOO_ID FROM ARTICLES)
                                        AND A.GOO_ID IN (%SELECTION%))
                             CONNECT BY REGEXP_SUBSTR(NAME, ''[^;]+'', 1, LEVEL) IS NOT NULL))) GG
    ON GG.GOO_ID = B.GOO_ID
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (%SELECTION%)
UNION ALL
SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          NVL(D.CATEGORIES, B.PATTERN)
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME1,
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
       GG.EXECUTIVESTD1,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(A.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKERS'') Checker,*/
       TCHECKER.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       A.COLORNAME,
       A.SIZENAME,
       A.BARCODE,
       A.SHAPE,
       (CASE
         WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN
          1
         ELSE
          0
       END) ISO2O,
        (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCODE,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       TWXMEMO.WX_MEMO
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID

  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
  LEFT JOIN (SELECT A.CODE_VALUE CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKERS'') TCHECKER
    ON 1 = 1
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
  LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0  
  LEFT JOIN (SELECT REPLACE(LISTAGG(TO_CHAR(EXECUTIVESTD) || CHR(13)) WITHIN
                            GROUP(ORDER BY EXECUTIVESTD),
                            '' '',
                            '''') AS EXECUTIVESTD1,
                    MAX(GOO_ID) GOO_ID
               FROM (SELECT CASE
                              WHEN ROWNUM = 1 THEN
                               ''文胸'' || EXECUTIVESTD
                              WHEN ROWNUM = 2 THEN
                               ''内裤'' || EXECUTIVESTD
                            END EXECUTIVESTD,
                            GOO_ID
                       FROM (SELECT REGEXP_SUBSTR(NAME, ''[^;]+'', 1, LEVEL) AS EXECUTIVESTD,
                                    ROWNUM,
                                    GOO_ID
                               FROM (SELECT AA.EXECUTIVESTD AS NAME, AA.GOO_ID
                                       FROM GOODS AA
                                      INNER JOIN ARTICLES TT
                                         ON AA.GOO_ID = TT.GOO_ID
                                      WHERE TT.BARCODE IN (%SELECTION%))
                             CONNECT BY REGEXP_SUBSTR(NAME, ''[^;]+'', 1, LEVEL) IS NOT NULL))) GG
    ON GG.GOO_ID = B.GOO_ID
 WHERE A.BARCODE IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
UNION ALL
SELECT CASE
         WHEN B.BRA_ID = ''03'' AND
              (D.CATEGORIES IN (''其它'', ''泳装'', ''男内搭'', ''女内搭'') OR
              D.SUBCATEGORY IN (''文胸配件'')) THEN
          D.SUBCATEGORY
         ELSE
          D.CATEGORIES
       END CATEGORIES1,
       D.CATEGORYGROUP,
       CONCAT(C.BRA_NAME, '':'') BRA_NAME,
       NVL(D.CUSGROUPNAME, B.THEME) CUSGROUPNAME,
       SUBSTR(B.SERIES, 1, 1) SERIES,
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
       GG.EXECUTIVESTD1,
       NVL(B.SAFE_TYPE, B.SAFETYTYPE) AS SAFETYTYPE,
       --e.TouchClass, e.Mean,
       DECODE(SUBSTR(B.SAFE_TYPE, INSTR(B.SAFE_TYPE, ''类'') - 1),
              NULL,
              E.TOUCHCLASS,
              NULL) AS TOUCHCLASS,
       E.MEAN,
       GETCOMPOSNAME(B.GOO_ID) COMPOSNAME,
       NVL(D.LABLEADDRESS, T1.PROVINCE || T2.CITY || T3.COUNTY) ADDRESS,
       GETGOODSQUALITY(B.CATEGORYNO) LEVELNAME,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''CHECKERS'') Checker,*/
       TCHECKER.CHECKER,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       (CASE WHEN Z.LABEL_SUPNAME IS NOT NULL THEN Z.LABEL_SUPNAME ELSE G.LABEL_SUPNAME END ) LABEL_SUPNAME,
       (CASE WHEN Z.LABEL_PHONENUMBER IS NOT NULL THEN Z.LABEL_PHONENUMBER ELSE G.LABEL_PHONENUMBER END ) LABEL_PHONENUMBER,
       (CASE WHEN Z.LABEL_ADDRESS IS NOT NULL THEN Z.LABEL_ADDRESS ELSE G.LABEL_ADDRESS END ) LABEL_ADDRESS,
       NULL COLORNAME,
       NULL SIZENAME,
       B.GOO_ID BARCODE,
       NULL SHAPE,
       (CASE WHEN B.IS_NETGOODS = 0 AND T.GOODS_SN IS NOT NULL THEN  1  ELSE 0  END) ISO2O,
       --''https://m.sanfu.com/d?g=''||b.goo_id QRCode,
       (CASE WHEN T.GOODS_SN IS NOT NULL AND b.is_netgoods = 0 THEN ''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92''
       ELSE ''官方正品'' END) QRCODE,
       
       --''https://work.weixin.qq.com/ct/wcde4a1a51791848db43b1a81015080fbe92'' QRCODE,
       /*(Select a.code_value From Dic_Codes a Where A.code_Type = ''LABEL_PRINT_DEFAULT'' And A.sub_Code_Type = ''WX_MEMO_01'') WX_MEMO*/
       TWXMEMO.WX_MEMO
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID

  LEFT JOIN (SELECT A.CODE_VALUE CHECKER
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''CHECKERS'') TCHECKER
    ON 1 = 1
  LEFT JOIN (SELECT A.CODE_VALUE WX_MEMO
               FROM DIC_CODES A
              WHERE A.CODE_TYPE = ''LABEL_PRINT_DEFAULT''
                AND A.SUB_CODE_TYPE = ''WX_MEMO_01'') TWXMEMO
    ON 1 = 1
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
 LEFT JOIN GOODS_PRINT Z ON Z.GOO_ID = B.GOO_ID AND Z.PAUSE=0   
  LEFT JOIN (SELECT REPLACE(LISTAGG(TO_CHAR(EXECUTIVESTD) || CHR(13)) WITHIN
                            GROUP(ORDER BY EXECUTIVESTD),
                            '' '',
                            '''') AS EXECUTIVESTD1,
                    MAX(GOO_ID) GOO_ID
               FROM (SELECT CASE
                              WHEN ROWNUM = 1 THEN
                               ''文胸'' || EXECUTIVESTD
                              WHEN ROWNUM = 2 THEN
                               ''内裤'' || EXECUTIVESTD
                            END EXECUTIVESTD,
                            GOO_ID
                       FROM (SELECT REGEXP_SUBSTR(NAME, ''[^;]+'', 1, LEVEL) AS EXECUTIVESTD,
                                    ROWNUM,
                                    GOO_ID
                               FROM (SELECT A.EXECUTIVESTD AS NAME, A.GOO_ID
                                       FROM GOODS A
                                      WHERE A.GOO_ID NOT IN
                                            (SELECT GOO_ID FROM ARTICLES)
                                        AND A.GOO_ID IN (%SELECTION%))
                             CONNECT BY REGEXP_SUBSTR(NAME, ''[^;]+'', 1, LEVEL) IS NOT NULL))) GG
    ON GG.GOO_ID = B.GOO_ID
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES Z WHERE B.GOO_ID = Z.GOO_ID)
   AND B.GOO_ID IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))'; 
        
         ELSIF LABEL_ID = '22' THEN
        V_SQL :='SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       A.COLORNAME,
       A.SIZENAME,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       1 ISSHOW
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       B.THEME,
       B.MATERIAL,
       B.STRUCTURE,
       B.SPECS,
       NULL,
       NULL,
       ''￥''||to_char(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),''fm999999990.00'') SALEPRICE,
       0 ISSHOW
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID) /*b.goo_id not in (select goo_id from Articles) */
   AND GOO_ID IN (%SELECTION%)
   ORDER BY 2 ASC' ;  
        
        
         ELSIF LABEL_ID =  '70186' THEN
        V_SQL :='SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       CEIL(F.orderamount/2)  ORDER_AMOUNT,
       CEIL((F.orderamount - F.gotamount)/2) OWE_AMOUNT_PR,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       A.BAKCODE,
       A.SHAPE
  FROM ARTICLES A
 INNER JOIN GOODS B
    ON A.GOO_ID = B.GOO_ID
     INNER JOIN (SELECT * FROM ORDERSITEM Z WHERE Z.ORD_ID||Z.BARCODE IN(%SELECTION%))F ON f.goo_id = A.GOO_ID AND a.barcode = f.barcode
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 --WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       F.ORD_ID||F.GOO_ID ORDER_BARCODE,
       CEIL(F.orderamount/2)  ORDER_AMOUNT,
       CEIL((F.orderamount - F.gotamount)/2) OWE_AMOUNT_PR,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID), ''fm999999990.00'') SALEPRICE,
       B.BAKCODE,
       NULL SHAPE
  FROM GOODS B
   INNER JOIN (SELECT * FROM ORDERS Z WHERE Z.ORD_ID||Z.GOO_ID IN (%SELECTION%)) F ON B.GOO_ID=F.GOO_ID
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
  -- AND GOO_ID IN (%SELECTION%)
  ORDER BY 2 ASC' ; 
        
         ELSIF LABEL_ID = '01186' THEN
        V_SQL :=  'SELECT C.BRA_NAME,
       A.BARCODE,
       B.GOO_NAME,
       B.PATTERN,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       A.COLORNAME,
       A.SIZENAME,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       A.BAKCODE,
       A.SHAPE
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
--WHERE A.BARCODE IN (%SELECTION%)
UNION ALL
SELECT C.BRA_NAME,
       B.GOO_ID,
       B.GOO_NAME,
       B.PATTERN,
       F.ORD_ID || F.GOO_ID ORDER_BARCODE,
       F.ORDERAMOUNT ORDER_AMOUNT,
       F.ORDERAMOUNT - F.GOTAMOUNT OWE_AMOUNT_PR,
       B.THEME,
       B.MATERIAL,
       B.SPECS,
       B.STRUCTURE,
       NULL,
       NULL,
       ''￥'' || TO_CHAR(GETNEWSALEPRICEFORLABEL(B.SHO_ID, B.GOO_ID),
                      ''fm999999990.00'') SALEPRICE,
       B.BAKCODE,
       NULL SHAPE
  FROM GOODS B
 INNER JOIN BRANCH C
    ON B.BRA_ID = C.BRA_ID
 INNER JOIN (SELECT *
               FROM ORDERS Z
              WHERE Z.ORD_ID || Z.GOO_ID IN (%SELECTION%)) F
    ON B.GOO_ID = F.GOO_ID
--where b.goo_id not in (select goo_id from Articles)
 WHERE NOT EXISTS (SELECT 1 FROM ARTICLES T WHERE B.GOO_ID = T.GOO_ID)
--AND GOO_ID IN (%SELECTION%)
 ORDER BY 2 ASC';  
        
        
         ELSIF LABEL_ID = '60017' THEN
        V_SQL :='Select b.Price,
       b.Specs,
       b.Goo_Id,
       b.Executivestd,
       Getcomposname(a.Goo_Id) Composname,
       ''￥'' || TO_CHAR(Getnewsalepriceforlabel(B.SHO_ID, b.Goo_Id),''fm999999990.00'') Saleprice,
       a.Barcode,
       a.colorname
  From Articles a
 Inner Join Goods b
    On a.Goo_Id = b.Goo_Id
 Where a.Barcode In (%Selection%)
Union All
Select b.Price,
       b.Specs,
       b.Goo_Id,
       b.Executivestd,
       Getcomposname(b.Goo_Id) Composname,
       ''￥'' || TO_CHAR(Getnewsalepriceforlabel(B.SHO_ID, b.Goo_Id),''fm999999990.00'') Saleprice,
       b.Goo_Id Barcode,
       Null colorname
  From Goods b
 --Where b.Goo_Id Not In (Select Goo_Id From Articles)
where not exists(select 1 from Articles t where b.goo_id = t.goo_id)
   And b.Goo_Id In (%Selection%)
   UNION ALL
   Select b.Price,
       b.Specs,
       b.Goo_Id,
       b.Executivestd,
       Getcomposname(a.Goo_Id) Composname,
       ''￥'' || TO_CHAR(Getnewsalepriceforlabel(B.SHO_ID, b.Goo_Id),''fm999999990.00'') Saleprice,
       a.Barcode,
       a.colorname
  From Articles a
 Inner Join Goods b
    On a.Goo_Id = b.Goo_Id
 Where a.Barcode IN (SELECT barcode FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
Union All
Select b.Price,
       b.Specs,
       b.Goo_Id,
       b.Executivestd,
       Getcomposname(b.Goo_Id) Composname,
       ''￥'' || TO_CHAR(Getnewsalepriceforlabel(B.SHO_ID, b.Goo_Id),''fm999999990.00'') Saleprice,
       b.Goo_Id Barcode,
       Null colorname
  From Goods b
 --Where b.Goo_Id Not In (Select Goo_Id From Articles)
where not exists(select 1 from Articles t where b.goo_id = t.goo_id)
   And b.Goo_Id IN (SELECT GOO_ID FROM ASNORDERPACKS WHERE PACK_BARCODE IN (%SELECTION%))
   ORDER BY 7 ASC' ;            

      END IF;

      RETURN      V_SQL;

      END F_LABEL_DATASQL;
   END  PKG_LABEL_PRINT;
/

