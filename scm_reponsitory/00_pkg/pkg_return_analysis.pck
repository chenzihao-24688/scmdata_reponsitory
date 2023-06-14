CREATE OR REPLACE PACKAGE SCMDATA.PKG_RETURN_ANALYSIS IS

/*-----------------------------------------------------------------
    Author   : dyy153
    Created  : 2022-3-26
    ALERTER  :
    ALERTER_TIME:
    Purpose  : 退货率质量异常原因分析包

  ------------------------------------------------------------------*/

  /*------------------------------------------------------------------
    退货率质量异常原因分析-分部查询

    入参：

       V_ORIGIN     数据来源：门店/仓库
       V_DUTY       责任部门： 全部责任部门/供应链
       V_DATE1      统计时间：年
       V_DATE2      统计时间类型：月/季/半年/年
       V_DATE3      具体的统计时间
       V_CATE       分部
       V_SELECT1    统计维度：产品子类/跟单/供应商/生产工厂/qc/qc主管/仓库
       V_SELECT2    具体的统计维度
       V_COMPID     企业id

    -----------------------------------------------------------------*/

  FUNCTION F_RETURN_CAUSE_CATE_ANALYSIS(V_ORIGIN  VARCHAR2, --门店/仓库
                                        V_DUTY    VARCHAR2, --全部责任部门/供应链
                                        V_DATE1   NUMBER, --年
                                        V_DATE2   VARCHAR2, --月/季/半年/年
                                        V_DATE3   NUMBER DEFAULT NULL,
                                        V_CATE    VARCHAR2, --分部
                                        V_SELECT1 VARCHAR2, --产品子类/跟单/供应商/生产工厂/qc
                                        V_SELECT2 VARCHAR2 DEFAULT NULL, --
                                        V_COMPID  VARCHAR2) RETURN CLOB;

/*------------------------------------------------------------------
    退货率质量异常原因分析-区域组查询

    入参：

       V_ORIGIN     数据来源：门店/仓库
       V_GROUP      区域组
       V_CATE       分部
       V_WAREH      仓库
       V_DUTY       责任部门： 全部责任部门/供应链
       V_DATE1      统计时间：年
       V_DATE2      统计时间类型：月/季/半年/年
       V_DATE3      具体的统计时间
       V_COMPID     企业id

    -----------------------------------------------------------------*/

  FUNCTION F_RETURN_CAUSE_QY_ANALYSIS(V_ORIGIN IN VARCHAR2,
                                      V_GROUP  IN VARCHAR2,
                                      V_CATE   IN VARCHAR2,
                                      V_WAREH  IN VARCHAR2,
                                      V_DUTY   IN VARCHAR2,
                                      V_DATE1  IN NUMBER,
                                      V_DATE2  IN VARCHAR2,
                                      V_DATE3  IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID IN VARCHAR2) RETURN CLOB;
END PKG_RETURN_ANALYSIS;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_RETURN_ANALYSIS IS


 /*------------------------------------------------------------------
    退货率质量异常原因分析-分部查询

    入参：

       V_ORIGIN     数据来源：门店/仓库
       V_DUTY       责任部门： 全部责任部门/供应链
       V_DATE1      统计时间：年
       V_DATE2      统计时间类型：月/季/半年/年
       V_DATE3      具体的统计时间
       V_CATE       分部
       V_SELECT1    统计维度：产品子类/跟单/供应商/生产工厂/qc/qc主管/仓库
       V_SELECT2    具体的统计维度
       V_COMPID     企业id

    -----------------------------------------------------------------*/

  FUNCTION F_RETURN_CAUSE_CATE_ANALYSIS(V_ORIGIN  VARCHAR2, --门店/仓库
                                        V_DUTY    VARCHAR2, --全部责任部门/供应链
                                        V_DATE1   NUMBER, --年
                                        V_DATE2   VARCHAR2, --月/季/半年/年
                                        V_DATE3   NUMBER DEFAULT NULL,
                                        V_CATE    VARCHAR2, --分部
                                        V_SELECT1 VARCHAR2, --产品子类/跟单/供应商/生产工厂/qc
                                        V_SELECT2 VARCHAR2 DEFAULT NULL,
                                        V_COMPID  VARCHAR2) RETURN CLOB IS

    V_F_SQL     CLOB;
    V_WH_SQL    CLOB;
    V_S_SQL     CLOB;
    V_GR_SQL    CLOB;
    V_SELE_TYPE CLOB ;
    V_SQL       CLOB;
    V_VALUE     VARCHAR2(200);
    V_SQL0      CLOB;
    V_WH2_SQL   VARCHAR2(258);
    V_SELECT3   VARCHAR2(32);
    V_SQL2      CLOB;
    V_SQL3      CLOB;
  BEGIN

    IF V_SELECT1 = '01' THEN
      V_SELE_TYPE := '产品子类';
    ELSIF V_SELECT1 = '02' THEN
      V_SELE_TYPE := '跟单';
    ELSIF V_SELECT1 = '03' THEN
      V_SELE_TYPE := 'QC';
    ELSIF V_SELECT1 = '04' THEN
      V_SELE_TYPE := 'QC主管';
    ELSIF V_SELECT1 = '05' THEN
      V_SELE_TYPE := '仓库';
    ELSIF V_SELECT1 = '06' THEN
      V_SELE_TYPE := '供应商';
    ELSIF V_SELECT1 = '07' THEN   V_SELE_TYPE := '生产工厂';
    END IF;
    --门店退货
    IF V_ORIGIN = 'M' THEN

     /* V_S_SQL := q'[SELECT D1.GROUP_DICT_NAME,C1.PROBLEM_CLASSIFICATION,C1.CAUSE_CLASSIFICATION,(CASE WHEN C1.IS_SUP_EXEMPTION=0 THEN '否' ELSE '是' END) IS_SUP_EXEMPTION,
       C2.DEPT_NAME,SUM(A.EXAMOUNT*B.PRICE) RMMONEY  ]';*/

      V_F_SQL := q'[FROM SCMDATA.T_RETURN_MANAGEMENT A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B ON A.GOO_ID=B.GOO_ID AND A.COMPANY_ID=B.COMPANY_ID
 INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C1 ON C1.ABNORMAL_DTL_CONFIG_ID=A.CAUSE_DETAIL_ID AND C1.COMPANY_ID=A.COMPANY_ID
 INNER JOIN SCMDATA.SYS_COMPANY_DEPT C2 ON C1.FIRST_DEPT_ID=C2.COMPANY_DEPT_ID AND C1.COMPANY_ID=C2.COMPANY_ID
 INNER JOIN SCMDATA.SYS_GROUP_DICT D1 ON D1.GROUP_DICT_VALUE=B.CATEGORY AND D1.GROUP_DICT_TYPE='PRODUCT_TYPE'
 INNER JOIN SCMDATA.SYS_COMPANY_DICT D2 ON B.SAMLL_CATEGORY=D2.COMPANY_DICT_VALUE AND D2.COMPANY_ID=A.COMPANY_ID]';

      V_WH_SQL := '  where A.AUDIT_TIME IS NOT NULL ';

      --GROUP BY
      V_GR_SQL := q'[  GROUP BY D1.GROUP_DICT_NAME,C1.PROBLEM_CLASSIFICATION,C1.CAUSE_CLASSIFICATION,IS_SUP_EXEMPTION,C2.DEPT_NAME]';

      --时间的条件
      IF V_DATE1 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' and A.YEAR =' || V_DATE1;
      ELSE
        V_WH_SQL := V_WH_SQL || ' and 1=1';
      END IF;
      IF V_DATE2 = '01' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' AND lpad(a.month,2,0)=' || V_DATE3;
      ELSIF V_DATE2 = '02' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' AND lpad( A.QUARTER,2,0)=' || V_DATE3;
      ELSIF V_DATE2 = '03' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    ' AND  DECODE(A.QUARTER,1,00,2,00,3,01,4,01)=' ||
                    V_DATE3;
      ELSIF V_DATE2 = '04' THEN
        V_WH_SQL := V_WH_SQL /*|| ' AND A.YEAR = ' || V_DATE1*/
         ;
      END IF;

      --部门条件
      IF V_DUTY = '供应链管理部' THEN
        V_WH_SQL := V_WH_SQL || ' and C2.DEPT_NAME=''' || V_DUTY || '''';

      END IF;

      --筛选条件
      IF V_CATE = '1' /*AND V_SELECT1 IS NULL AND  V_SELECT2 IS NULL*/
       THEN
        V_WH_SQL := V_WH_SQL || ' AND 1=1 ';
        V_S_SQL  := q'[SELECT C1.PROBLEM_CLASSIFICATION,C1.CAUSE_CLASSIFICATION,(CASE WHEN C1.IS_SUP_EXEMPTION=0 THEN '否' ELSE '是' END) IS_SUP_EXEMPTION,
       C2.DEPT_NAME,]'/*SUM(A.EXAMOUNT*B.PRICE) RMMONEY */ ;
        V_GR_SQL := q'[  GROUP BY C1.PROBLEM_CLASSIFICATION,C1.CAUSE_CLASSIFICATION,IS_SUP_EXEMPTION,C2.DEPT_NAME]';
      ELSIF V_CATE <> '1' THEN
        V_WH_SQL := V_WH_SQL || ' and b.category = ''' || V_CATE || '''';
        V_S_SQL:=q'[SELECT D1.GROUP_DICT_NAME,C1.PROBLEM_CLASSIFICATION,C1.CAUSE_CLASSIFICATION,(CASE WHEN C1.IS_SUP_EXEMPTION=0 THEN '否' ELSE '是' END) IS_SUP_EXEMPTION,
       C2.DEPT_NAME, ]';
      END IF;
      IF V_SELECT1 = '01' THEN
        IF V_SELECT2 IS NOT NULL THEN
          V_WH_SQL := V_WH_SQL ||
                      '   AND  D2.company_dict_name =''' ||
                      V_SELECT2 || '''AND A.COMPANY_ID=''' || V_COMPID || '''';
        ELSE
          V_WH_SQL := V_WH_SQL || '   AND 1=1 ';
        END IF;
        V_VALUE := V_SELECT2;
        V_S_SQL:=V_S_SQL||' SUM(A.EXAMOUNT*B.PRICE) RMMONEY ';
      ELSIF V_SELECT1 = '02' AND V_SELECT2 IS NOT NULL THEN
        --跟单
        V_WH_SQL := V_WH_SQL || '  AND A.MERCHER_ID=''' || V_SELECT2 ||
                    '''AND A.COMPANY_ID=''' || V_COMPID || '''';
        V_SQL0   := 'SELECT X.COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= ''' ||
                    V_SELECT2 || '''AND X.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;
      V_S_SQL:=V_S_SQL||' SUM(A.EXAMOUNT*B.PRICE) RMMONEY ';

      ELSIF V_SELECT1 = '06' AND V_SELECT2 IS NOT NULL THEN
        --供应商
        V_WH_SQL := V_WH_SQL || '  AND A.SUPPLIER_CODE=''' || V_SELECT2 ||
                    '''AND A.COMPANY_ID=''' || V_COMPID || '''';
        V_SQL0   := 'SELECT supplier_company_name
                 FROM SCMDATA.T_SUPPLIER_INFO X WHERE X.supplier_code =''' ||
                    V_SELECT2 || '''AND X.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;
      V_S_SQL:=V_S_SQL||' SUM(A.EXAMOUNT*B.PRICE) RMMONEY ';

      ELSIF V_SELECT1 = '03' AND V_SELECT2 IS NOT NULL THEN
        --QC
        V_S_SQL := V_S_SQL||'
         SUM(( A.EXAMOUNT * B.PRICE)/(REGEXP_COUNT(a.QC_ID, '','') + 1)*REGEXP_COUNT(A.QC_ID,'''||V_SELECT2||''')) RMMONEY   ';

        V_WH_SQL := V_WH_SQL ||
                    '  AND INSTR('',''||A.qc_id||'','','',''||''' ||
                    V_SELECT2 || '''||'','') >0  AND A.COMPANY_ID=''' ||
                    V_COMPID || '''';

        V_SQL0 := 'SELECT COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= ''' ||
                  V_SELECT2 || '''AND x.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;

      ELSIF V_SELECT1 = 'QC' AND V_SELECT2 IS NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    '  AND A.QC_ID IS NOT NULL AND A.COMPANY_ID=''' ||
                    V_COMPID || '''';

      ELSIF V_SELECT1 = '04' AND V_SELECT2 IS NOT NULL THEN
        --QC主管
        V_S_SQL := V_S_SQL||'
         SUM(( A.EXAMOUNT * B.PRICE)/(REGEXP_COUNT(a.qc_director_id , '','') + 1)*REGEXP_COUNT(A.qc_director_id,'''||V_SELECT2||''')) RMMONEY  ';

        V_WH_SQL := V_WH_SQL ||
                    ' AND instr('',''||A.qc_director_id||'','','',''||''' ||
                    V_SELECT2 || '''||'','')>0 AND A.COMPANY_ID=''' ||
                    V_COMPID || '''';
        V_SQL0   := 'SELECT COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= ''' ||
                    V_SELECT2 || '''AND x.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;

      ELSIF V_SELECT1 = '05' AND V_SELECT2 IS NOT NULL THEN
        IF  V_SELECT2 <> 'ALL' THEN
        V_S_SQL := V_S_SQL||'
         SUM(( A.EXAMOUNT * B.PRICE)/(REGEXP_COUNT(a.sho_id  , '','') + 1)) RMMONEY   ';
        IF V_SELECT2 = 'GDZ' THEN
          V_SELECT3 := 'GDT';
        ELSIF V_SELECT2 = 'YWZ' THEN
          V_SELECT3 := 'YWT';
        ELSIF V_SELECT2 = 'GZZ' THEN
          V_SELECT3 := 'GZT';
        END IF;
        V_WH_SQL := V_WH_SQL ||
                    '  AND (instr('',''||A.sho_id ||'','','',''||''' ||
                    V_SELECT2 || '''||'','')>0 or A.sho_id = ''' ||
                    V_SELECT3 || ''') AND A.COMPANY_ID=''' || V_COMPID || '''';
        V_SQL0   := 'SELECT t.GROUP_DICT_NAME NAME
          FROM SCMDATA.SYS_GROUP_DICT t
         WHERE GROUP_DICT_TYPE = ''COMPANY_STORE_TYPE'' AND t.group_dict_value =''' ||
                    V_SELECT2 || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;

        ELSE
          V_S_SQL:=V_S_SQL||' SUM(A.EXAMOUNT*B.PRICE) RMMONEY ';
          V_WH_SQL:=V_WH_SQL || ' AND A.COMPANY_ID=''' || V_COMPID || '''';
          V_VALUE := '全部仓库';
       END IF;

      END IF;

      IF V_CATE = '1' THEN
        V_SQL2 := 'select  ''全部''  PRODUCT_CATEGORYS, ';
      ELSE
        V_SQL2 := 'select  GROUP_DICT_NAME  PRODUCT_CATEGORYS, ';
      END IF;

      IF V_SELECT2 IS NULL THEN
        V_SQL3 := ' PROBLEM_CLASSIFICATION,
            CAUSE_CLASSIFICATION,DEPT_NAME RESPON_DEPT_NAME,IS_SUP_EXEMPTION, RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE,RMMONEY FROM tmp
            union all
            select ''合计'' PRODUCT_CATEGORYS, ' || q'[
                   '' PROBLEM_CLASSIFICATION,
                   '' CAUSE_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                   SUM(RMMONEY)   RMMONEY from tmp ]';
         V_S_SQL:=V_S_SQL||' SUM(A.EXAMOUNT*B.PRICE) RMMONEY ';

      ELSE
        V_SQL3 := '''' || V_VALUE || ''' ' || V_SELE_TYPE ||
                  q'[,  PROBLEM_CLASSIFICATION,
            CAUSE_CLASSIFICATION,DEPT_NAME RESPON_DEPT_NAME,IS_SUP_EXEMPTION, RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE,RMMONEY FROM tmp
            union all
            select '合计' PRODUCT_CATEGORYS,
                   ''  ]' || V_SELE_TYPE || q'[,
                   '' PROBLEM_CLASSIFICATION,
                   '' CAUSE_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                   SUM(RMMONEY)   RMMONEY from tmp ]';
      END IF;
      IF V_ORIGIN IS NULL OR V_DATE1 IS NULL OR (V_DATE2 <> '04' AND V_DATE3 IS NULL) OR V_DATE2 IS NULL OR
            V_CATE IS NULL THEN
        --V_WH_SQL := V_WH_SQL || ' AND 1=1 ';
        V_SQL:=q'[select '' PRODUCT_CATEGORYS, '' PROBLEM_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION, '' RT_RATE, '' RMMONEY  from dual]';
      ELSE
      V_SQL := q'[with tmp as (]' || V_S_SQL || V_F_SQL || V_WH_SQL ||
               V_GR_SQL || ') ' || V_SQL2 || V_SQL3;
       END IF;
      /*IF V_CATE = '1' AND V_SELECT1 IS NULL AND
         V_SELECT2 IS NULL THEN
        V_SQL := q'[with tmp as (]' || V_S_SQL || V_F_SQL || V_WH_SQL ||
                 V_GR_SQL || ')
          select  ''全部''  PRODUCT_CATEGORYS, ''' ||
                 V_VALUE || ''' ' || V_SELE_TYPE ||
                 q'[,  PROBLEM_CLASSIFICATION,
            CAUSE_CLASSIFICATION,DEPT_NAME RESPON_DEPT_NAME,IS_SUP_EXEMPTION, RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE,RMMONEY FROM tmp
            union all
            select '合计' PRODUCT_CATEGORYS,
                   ''  ]' || V_SELE_TYPE ||
                 q'[,
                   '合计' PROBLEM_CLASSIFICATION,
                   '' CAUSE_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                   SUM(RMMONEY)   RMMONEY from tmp ]';

      ELSIF V_CATE <> '1' AND V_SELECT2 IS NULL THEN
        V_SQL := q'[with tmp as (]' || V_S_SQL || V_F_SQL || V_WH_SQL ||
                 V_GR_SQL || ')
          select  GROUP_DICT_NAME  PRODUCT_CATEGORYS, ''' ||
                 V_VALUE || ''' ' || V_SELE_TYPE ||
                 q'[,  PROBLEM_CLASSIFICATION,
            CAUSE_CLASSIFICATION,DEPT_NAME RESPON_DEPT_NAME,IS_SUP_EXEMPTION, RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE,RMMONEY FROM tmp
            union all
            select '合计' PRODUCT_CATEGORYS,
                   ''  ]' || V_SELE_TYPE ||
                 q'[,
                   '' PROBLEM_CLASSIFICATION,
                   '' CAUSE_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                   SUM(RMMONEY)   RMMONEY from tmp ]';
      ELSE

        V_SQL := q'[with tmp as (]' || V_S_SQL || V_F_SQL || V_WH_SQL ||
                 V_GR_SQL || ')
          select GROUP_DICT_NAME PRODUCT_CATEGORYS, ''' ||
                 V_VALUE || ''' ' || V_SELE_TYPE ||
                 q'[,  PROBLEM_CLASSIFICATION,
            CAUSE_CLASSIFICATION,DEPT_NAME RESPON_DEPT_NAME,IS_SUP_EXEMPTION, RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE,RMMONEY FROM tmp
            union all
            select '合计' PRODUCT_CATEGORYS,
                   ''  ]' || V_SELE_TYPE || q'[,
                   '' PROBLEM_CLASSIFICATION,
                   '' CAUSE_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                   SUM(RMMONEY)   RMMONEY from tmp ]';
      END IF;*/

      --仓库
    ELSIF V_ORIGIN <> 'M' THEN

      V_S_SQL := q'[SELECT I.GROUP_DICT_NAME,--分部
       H.GROUP_DICT_NAME PROBLEM_CLASSIFICATION,
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) FIRST_RESP_DEPT,
        (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END) IS_SUPP_DEPT,
         SUM((CASE WHEN A.PROCESSING_TYPE ='NM' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> 'NM' THEN A.pcome_amount  END)*B.PRICE)  RMMONEY ]';

      V_F_SQL := q'[FROM SCMDATA.T_QA_SCOPE A
INNER JOIN SCMDATA.T_COMMODITY_INFO B ON A.GOO_ID= B.GOO_ID AND A.COMPANY_ID = B.COMPANY_ID
INNER JOIN scmdata.T_QA_REPORT C  ON A.QA_REPORT_ID=C.QA_REPORT_ID AND A.COMPANY_ID=C.COMPANY_ID
left JOIN SCMDATA.T_ORDERED D ON A.ORDER_ID = D.ORDER_CODE AND A.COMPANY_ID=D.COMPANY_ID
LEFT JOIN SCMDATA.PT_ORDERED E ON D.ORDER_ID=E.ORDER_ID AND E.COMPANY_ID=D.COMPANY_ID
LEFT JOIN SCMDATA.SYS_GROUP_DICT H
    ON H.GROUP_DICT_TYPE = 'QA_UNQUAL_REASON_CLASS' AND C.UNQUALREASON_CLASS=H.GROUP_DICT_VALUE
INNER JOIN SCMDATA.SYS_GROUP_DICT I ON I.GROUP_DICT_VALUE=B.CATEGORY AND I.GROUP_DICT_TYPE='PRODUCT_TYPE'
/*INNER JOIN SCMDATA.SYS_COMPANY_DICT J ON J.COMPANY_DICT_VALUE = B.SAMLL_CATEGORY AND J.COMPANY_ID = B.COMPANY_ID */]';

      V_WH_SQL := '   WHERE C.STATUS IN (''N_ACF'',''R_ACF'') AND A.ORIGIN = ''SCM'' ';

      --GROUP BY
      V_GR_SQL := q'[GROUP BY I.GROUP_DICT_NAME,--分部
        H.GROUP_DICT_NAME, --问题分类
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) ,
        (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END)]';

      /*IF V_ORIGIN = 'GZZ' THEN
        V_WH_SQL := V_WH_SQL || ' AND D.sho_id = ''GZZ'' ';
      ELSIF V_ORIGIN = 'YWZ' THEN
        V_WH_SQL := V_WH_SQL || '  AND D.SHO_ID = ''YWZ'' ';
      ELSIF V_ORIGIN = 'GDZ' THEN
        V_WH_SQL := V_WH_SQL || '  AND D.SHO_ID = ''GDZ'' ';
      END IF;*/

      --时间的条件
      IF V_DATE1 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' AND EXTRACT(YEAR FROM A.COMMIT_TIME) =' ||
                    V_DATE1;
      ELSE
        V_WH_SQL := V_WH_SQL || '  AND 1=1';
      END IF;

      IF V_DATE2 = '01' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    ' AND LPAD (EXTRACT (MONTH FROM A.COMMIT_TIME),2,0)=' ||
                    V_DATE3;
      ELSIF V_DATE2 = '02' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    ' AND  LPAD(TO_CHAR(A.COMMIT_TIME,''Q''),2,0)=' ||
                    V_DATE3;
      ELSIF V_DATE2 = '03' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' AND  DECODE(TO_CHAR(A.COMMIT_TIME,''Q''),1,00,2,00,3,01,4,01)=' ||
                    V_DATE3;
      ELSIF V_DATE2 = '04' THEN
        V_WH_SQL := V_WH_SQL; /*|| ' AND EXTRACT(YEAR FROM A.COMMIT_TIME) = ' || V_DATE1;*/
      END IF;

      --筛选条件

      IF V_CATE = '1' /*AND V_SELECT2 IS NULL*/
       THEN
        V_WH_SQL := V_WH_SQL;
        V_S_SQL  := q'[SELECT H.GROUP_DICT_NAME PROBLEM_CLASSIFICATION,
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) FIRST_RESP_DEPT,
        (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END) IS_SUPP_DEPT, ]';

      ELSIF V_CATE <> '1' THEN
        V_WH_SQL := V_WH_SQL || ' and b.category = ''' || V_CATE || '''';
        V_S_SQL := q'[SELECT I.GROUP_DICT_NAME,--分部
       H.GROUP_DICT_NAME PROBLEM_CLASSIFICATION,
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) FIRST_RESP_DEPT,
        (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END) IS_SUPP_DEPT, ]';
      END IF;
      IF V_SELECT1 = '01' AND V_SELECT2 IS NOT NULL THEN
        --产品子类
        V_WH_SQL := V_WH_SQL || '   AND E.PRODUCT_SUBCLASS_NAME  =''' ||
                    V_SELECT2 || '''AND A.COMPANY_ID=''' || V_COMPID || '''';
        V_VALUE  := V_SELECT2;
       V_S_SQL :=V_S_SQL ||' SUM((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)  RMMONEY  ';

      ELSIF V_SELECT2 IS NULL THEN
        V_WH_SQL := V_WH_SQL || '  AND A.COMPANY_ID=''' || V_COMPID || '''';
        V_S_SQL :=V_S_SQL ||' SUM((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)  RMMONEY  ';
      ELSIF V_SELECT1 = '02' AND V_SELECT2 IS NOT NULL THEN
        --跟单
        V_S_SQL :=V_S_SQL ||' SUM(((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)/(REGEXP_COUNT(E.FLW_ORDER , '','') + 1))  RMMONEY  ';

        V_WH_SQL := V_WH_SQL ||
                    '  AND INSTR('';''||E.FLW_ORDER ||'';'','';''||''' ||
                    V_SELECT2 || '''||'';'')>0 AND A.COMPANY_ID=''' ||
                    V_COMPID || '''';

        V_SQL0 := 'SELECT X.COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= ''' ||
                  V_SELECT2 || '''AND X.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;

      ELSIF V_SELECT1 = '06' AND V_SELECT2 IS NOT NULL THEN
        --供应商
        V_WH_SQL := V_WH_SQL || ' AND  D.SUPPLIER_CODE =''' || V_SELECT2 ||
                    '''AND A.COMPANY_ID=''' || V_COMPID || '''';
        V_SQL0   := 'SELECT SUPPLIER_COMPANY_NAME
                 FROM SCMDATA.T_SUPPLIER_INFO X WHERE X.supplier_code =''' ||
                    V_SELECT2 || '''AND X.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;
       V_S_SQL:=V_S_SQL||' SUM((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)  RMMONEY ';
      ELSIF V_SELECT1 = '07' AND V_SELECT2 IS NOT NULL THEN
        --生产工厂
        V_WH_SQL := V_WH_SQL || '  AND E.FACTORY_CODE = ''' || V_SELECT2 ||
                    '''AND A.COMPANY_ID=''' || V_COMPID || '''';
        V_SQL0   := 'SELECT SUPPLIER_COMPANY_NAME
                 FROM SCMDATA.T_SUPPLIER_INFO X WHERE X.supplier_code =''' ||
                    V_SELECT2 || '''AND X.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;
      V_S_SQL:=V_S_SQL||' SUM((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)  RMMONEY ';
      ELSIF V_SELECT1 = '03' AND V_SELECT2 IS NOT NULL THEN
        --QC
        V_S_SQL :=V_S_SQL ||' SUM(((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)/(REGEXP_COUNT(E.QC , '','') + 1))  RMMONEY ';
        V_WH_SQL := V_WH_SQL ||
                    '  AND INSTR ('',''||E.QC ||'','', '',''||''' ||
                    V_SELECT2 || '''||'','') >0 AND A.COMPANY_ID=''' ||
                    V_COMPID || '''';
        V_SQL0   := 'SELECT COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= ''' ||
                    V_SELECT2 || '''AND x.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;

      ELSIF V_SELECT1 = '03' AND V_SELECT2 IS NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    ' AND  E.QC  IS NOT NULL  AND A.COMPANY_ID=''' ||
                    V_COMPID || '''';


      ELSIF V_SELECT1 = '04' AND V_SELECT2 IS NOT NULL THEN
        --QC主管
        V_S_SQL:=V_S_SQL ||' SUM(((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)/(REGEXP_COUNT(E.QC_MANAGER , '','') + 1))  RMMONEY ';
        V_WH_SQL := V_WH_SQL ||
                    ' AND INSTR('',''||E.QC_MANAGER  ||'','', '',''||''' ||
                    V_SELECT2 || '''||'','') >0 AND A.COMPANY_ID=''' ||
                    V_COMPID || '''';
        V_SQL0   := 'SELECT COMPANY_USER_NAME
                 FROM SYS_COMPANY_USER X WHERE X.USER_ID= ''' ||
                    V_SELECT2 || '''AND x.COMPANY_ID=''' || V_COMPID || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;

      ELSIF V_SELECT1 = '05' AND V_SELECT2 IS NOT NULL THEN

        V_S_SQL:=V_S_SQL||' SUM((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)  RMMONEY ';
        IF V_SELECT2 <>'ALL' THEN
        V_WH_SQL := V_WH_SQL || ' AND  D.sho_id = ''' || V_SELECT2 ||
                    ''' AND A.COMPANY_ID=''' || V_COMPID || '''';

        V_SQL0 := 'SELECT t.GROUP_DICT_NAME NAME
          FROM SCMDATA.SYS_GROUP_DICT t
         WHERE GROUP_DICT_TYPE = ''COMPANY_STORE_TYPE'' AND t.group_dict_value =''' ||
                  V_SELECT2 || '''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;

       ELSE V_WH_SQL := V_WH_SQL || ' AND A.COMPANY_ID=''' || V_COMPID || '''';
         V_VALUE :='全部仓库';
       END IF;

      ELSIF V_ORIGIN IS NULL OR V_DATE1 IS NULL OR V_DATE2 IS NULL OR
            V_CATE IS NULL OR V_SELECT2 IS NULL THEN
        V_WH_SQL := V_WH_SQL || ' AND 1=1 ';
       V_S_SQL:=V_S_SQL||' SUM((CASE WHEN A.PROCESSING_TYPE =''NM'' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> ''NM'' THEN A.pcome_amount  END)*B.PRICE)  RMMONEY ';

      END IF;

      V_WH2_SQL := '  WHERE RMMONEY IS NOT NULL ';

      IF V_DUTY = '供应链管理部' THEN
        V_WH2_SQL := V_WH2_SQL || '  AND  FIRST_RESP_DEPT = ''' || V_DUTY ||
                     ''' ';
      ELSE
        V_WH2_SQL := V_WH2_SQL;
      END IF;

      IF V_CATE = '1' THEN
        V_SQL2 := ' SELECT ''全部'' PRODUCT_CATEGORYS, ';
        V_GR_SQL := q'[GROUP BY  H.GROUP_DICT_NAME, --问题分类
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) ,
        (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END)]';



     ELSE
        V_SQL2 := ' SELECT GROUP_DICT_NAME PRODUCT_CATEGORYS, ';
      END IF;

      IF V_SELECT2 IS NULL THEN
        V_SQL3 := q'[  PROBLEM_CLASSIFICATION, FIRST_RESP_DEPT   RESPON_DEPT_NAME, IS_SUPP_DEPT IS_SUP_EXEMPTION,
               RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE, RMMONEY FROM tmp ]' ||
                  V_WH2_SQL || q'[
            union all
            select '合计'  PRODUCT_CATEGORYS,
                   '' PROBLEM_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                  SUM(RMMONEY)   RMMONEY from tmp ]';
      ELSE
        V_SQL3 := '''' || V_VALUE || ''' ' || V_SELE_TYPE ||
                  q'[,  PROBLEM_CLASSIFICATION, FIRST_RESP_DEPT   RESPON_DEPT_NAME, IS_SUPP_DEPT IS_SUP_EXEMPTION,
               RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE, RMMONEY FROM tmp ]' ||
                  V_WH2_SQL || q'[
            union all
            select '合计' PRODUCT_CATEGORYS,
                   ''  ]' || V_SELE_TYPE || q'[,
                   '' PROBLEM_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                  SUM(RMMONEY)   RMMONEY from tmp ]';
      END IF;

      /*IF V_CATE = '1' \* AND  V_SELECT1 IS NULL AND
         V_SELECT2 IS NULL *\ THEN
        V_SQL := q'[with tmp as (]' || V_S_SQL || V_F_SQL || V_WH_SQL ||
                 V_GR_SQL || ')
              SELECT ''全部'' PRODUCT_CATEGORYS,''' ||
                 V_VALUE || ''' ' || V_SELE_TYPE ||
                 q'[,  PROBLEM_CLASSIFICATION, FIRST_RESP_DEPT   RESPON_DEPT_NAME, IS_SUPP_DEPT IS_SUP_EXEMPTION,
               RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE, RMMONEY FROM tmp ]' ||
                 V_WH2_SQL || q'[
            union all
            select '合计'  PRODUCT_CATEGORYS,
                   '' PROBLEM_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                  SUM(RMMONEY)   RMMONEY from tmp ]';

      ELSE
        V_SQL := q'[with tmp as (]' || V_S_SQL || V_F_SQL || V_WH_SQL ||
                 V_GR_SQL || ')
              SELECT CATEGORY_NAME PRODUCT_CATEGORYS,''' ||
                 V_VALUE || ''' ' || V_SELE_TYPE ||
                 q'[,  PROBLEM_CLASSIFICATION, FIRST_RESP_DEPT   RESPON_DEPT_NAME, IS_SUPP_DEPT IS_SUP_EXEMPTION,
               RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE, RMMONEY FROM tmp ]' ||
                 V_WH2_SQL || q'[
            union all
            select '合计' PRODUCT_CATEGORYS,
                   ''  ]' || V_SELE_TYPE || q'[,
                   '' PROBLEM_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                  SUM(RMMONEY)   RMMONEY from tmp ]';
      END IF;*/

      IF V_ORIGIN IS NULL OR V_DATE1 IS NULL OR (V_DATE2 <>'04' AND V_DATE3 IS NULL) OR V_DATE2 IS NULL OR
            V_CATE IS NULL THEN
       -- V_WH_SQL := V_WH_SQL || ' AND 1=1 ';
       V_SQL:=q'[select '' PRODUCT_CATEGORYS, '' PROBLEM_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION, '' RT_RATE, '' RMMONEY  from dual]';
       ELSE
      V_SQL := q'[with tmp as (]' || V_S_SQL || V_F_SQL || V_WH_SQL ||
               V_GR_SQL || ') ' || V_SQL2 || V_SQL3;
     END IF;
    END IF;

    RETURN V_SQL;

  END F_RETURN_CAUSE_CATE_ANALYSIS;

  /*------------------------------------------------------------------
    退货率质量异常原因分析-区域组查询

    入参：

       V_ORIGIN     数据来源：门店/仓库
       V_GROUP      区域组
       V_CATE       分部
       V_WAREH      仓库
       V_DUTY       责任部门： 全部责任部门/供应链
       V_DATE1      统计时间：年
       V_DATE2      统计时间类型：月/季/半年/年
       V_DATE3      具体的统计时间
       V_COMPID     企业id

    -----------------------------------------------------------------*/
  FUNCTION F_RETURN_CAUSE_QY_ANALYSIS(V_ORIGIN IN VARCHAR2,
                                      V_GROUP  IN VARCHAR2,
                                      V_CATE   IN VARCHAR2,
                                      V_WAREH  IN VARCHAR2,
                                      V_DUTY   IN VARCHAR2,
                                      V_DATE1  IN NUMBER,
                                      V_DATE2  IN VARCHAR2,
                                      V_DATE3  IN VARCHAR2 DEFAULT NULL,
                                      V_COMPID IN VARCHAR2) RETURN CLOB IS
    V_S_SQL   CLOB;
    V_WH_SQL  CLOB;
    V_GR_SQL  CLOB;
    V_VALUE   VARCHAR2(64);
    V_SQL0    VARCHAR2(512);
    V_SQL     CLOB;
    V_WH2_SQL VARCHAR2(512);
    V_SELECT1 VARCHAR2(32);
    --V_S1_SQL  CLOB;


  BEGIN
    --------门店
    IF V_ORIGIN = 'M' THEN

      V_S_SQL := q'[SELECT E.GROUP_NAMEW SUP_GROUP_NAME2, C.PROBLEM_CLASSIFICATION, C.CAUSE_CLASSIFICATION,
                         D.DEPT_NAME, (CASE WHEN C.IS_SUP_EXEMPTION = 0 THEN  '否' ELSE '是' END) IS_SUP_EXEMPTION,
                         SUM((CASE WHEN REGEXP_COUNT(a.SUP_GROUP_NAME, ',') > 0 THEN  a.EXAMOUNT * NVL(((SELECT SUM(R.ORDER_MONEY)
                       FROM SCMDATA.PT_ORDERED R
                      WHERE R.GOO_ID = a.RELA_GOO_ID
                        AND R.COMPANY_ID = a.COMPANY_ID
                        AND R.GROUP_NAME = a.SUP_GROUP_NAME2)/
         (SELECT SUM(R.ORDER_MONEY)
           FROM SCMDATA.PT_ORDERED R
          WHERE R.GOO_ID = a.RELA_GOO_ID 
            AND R.COMPANY_ID = a.COMPANY_ID)),(1/(REGEXP_COUNT(a.SUP_GROUP_NAME, ',')+1))) * b.price ELSE a.examount*b.price END )) RMMONEY
                    FROM (SELECT z.*, REGEXP_SUBSTR(z.SUP_GROUP_NAME,'[^,]+',1,LEVEL) SUP_GROUP_NAME2
     FROM  SCMDATA.T_RETURN_MANAGEMENT z 
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
                   INNER JOIN SCMDATA.T_COMMODITY_INFO B
                      ON A.GOO_ID = B.GOO_ID
                     AND A.COMPANY_ID = B.COMPANY_ID
                   INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                      ON C.ABNORMAL_DTL_CONFIG_ID = A.CAUSE_DETAIL_ID
                     AND C.COMPANY_ID = A.COMPANY_ID
                   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                      ON C.FIRST_DEPT_ID = D.COMPANY_DEPT_ID
                     AND C.COMPANY_ID = D.COMPANY_ID  
                     LEFT JOIN SCMDATA.T_SUPPLIER_GROUP_CONFIG E
      ON E.GROUP_CONFIG_ID = A.SUP_GROUP_NAME2
     AND E.COMPANY_ID = A.COMPANY_ID ]';

      V_WH_SQL := '  where A.AUDIT_TIME IS NOT NULL ';

      --GROUP BY
      V_GR_SQL := q'[   GROUP BY E.GROUP_NAME,
          C.PROBLEM_CLASSIFICATION,
          C.CAUSE_CLASSIFICATION,
          (CASE WHEN C.IS_SUP_EXEMPTION = 0 THEN '否'
            ELSE  '是' END),
          D.DEPT_NAME ]';

      --时间的条件
      IF V_DATE1 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' and A.YEAR =' || V_DATE1;
      ELSE
        V_WH_SQL := V_WH_SQL || ' AND 1=1';
      END IF;

      IF V_DATE2 = '01' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' AND lpad(a.month,2,0)=' || V_DATE3;
      ELSIF V_DATE2 = '02' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' AND lpad( A.QUARTER,2,0)=' || V_DATE3;
      ELSIF V_DATE2 = '03' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    ' AND  DECODE(A.QUARTER,1,00,2,00,3,01,4,01)=' ||
                    V_DATE3;
      ELSIF V_DATE2 = '04' THEN
        V_WH_SQL := V_WH_SQL;
      END IF;

      --责任部门
      IF V_DUTY = '供应链管理部' THEN
        V_WH_SQL := V_WH_SQL || ' and D.DEPT_NAME=''' || V_DUTY || '''';
      END IF;

      --分部
      IF V_CATE <> '1' THEN
        V_WH_SQL := V_WH_SQL || '  AND B.CATEGORY = ''' || V_CATE || '''';
        V_SQL0   := 'SELECT GROUP_DICT_NAME
                  FROM SCMDATA.SYS_GROUP_DICT T WHERE T.GROUP_DICT_VALUE=''' ||
                    V_CATE || ''' AND T.GROUP_DICT_TYPE = ''PRODUCT_TYPE''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;

      ELSIF V_CATE = '1' OR V_CATE IS NULL THEN
        V_WH_SQL := V_WH_SQL;
        V_VALUE  := '全部';

      END IF;

      --区域的条件
      IF V_GROUP <> '全部' THEN
        V_S_SQL:=q'[ SELECT E.GROUP_NAME SUP_GROUP_NAME2,
         C.PROBLEM_CLASSIFICATION,
         C.CAUSE_CLASSIFICATION,
         D.DEPT_NAME,
         (CASE   WHEN C.IS_SUP_EXEMPTION = 0 THEN '否'  ELSE  '是'  END) IS_SUP_EXEMPTION,
         SUM((CASE WHEN REGEXP_COUNT(a.SUP_GROUP_NAME, ',') > 0 THEN  a.EXAMOUNT * NVL(((SELECT SUM(R.ORDER_MONEY)
                       FROM SCMDATA.PT_ORDERED R
                      WHERE R.GOO_ID = a.RELA_GOO_ID
                        AND R.COMPANY_ID = a.COMPANY_ID
                        AND R.GROUP_NAME = a.SUP_GROUP_NAME2)/
         (SELECT SUM(R.ORDER_MONEY)
           FROM SCMDATA.PT_ORDERED R
          WHERE R.GOO_ID = a.RELA_GOO_ID 
            AND R.COMPANY_ID = a.COMPANY_ID)),(1/(REGEXP_COUNT(a.SUP_GROUP_NAME, ',')+1))) * b.price ELSE a.examount*b.price END )) RMMONEY 
             FROM (SELECT z.*, REGEXP_SUBSTR(z.SUP_GROUP_NAME,'[^,]+',1,LEVEL) SUP_GROUP_NAME2
     FROM  SCMDATA.T_RETURN_MANAGEMENT z 
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
            INNER JOIN SCMDATA.T_COMMODITY_INFO B
                      ON A.GOO_ID = B.GOO_ID
                     AND A.COMPANY_ID = B.COMPANY_ID
                   INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                      ON C.ABNORMAL_DTL_CONFIG_ID = A.CAUSE_DETAIL_ID
                     AND C.COMPANY_ID = A.COMPANY_ID
                   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                      ON C.FIRST_DEPT_ID = D.COMPANY_DEPT_ID
                     AND C.COMPANY_ID = D.COMPANY_ID  
                     LEFT JOIN SCMDATA.T_SUPPLIER_GROUP_CONFIG E
      ON E.GROUP_CONFIG_ID = A.SUP_GROUP_NAME2
     AND E.COMPANY_ID = A.COMPANY_ID  ]';

        V_WH_SQL := V_WH_SQL || '  AND A.SUP_GROUP_NAME2= '''|| V_GROUP ||
                    ''' AND A.COMPANY_ID = ''' || V_COMPID || '''';

       ELSIF V_GROUP IS NULL THEN V_WH_SQL:=V_WH_SQL||' AND A.COMPANY_ID = '''||V_COMPID||'''';

      END IF;

      --仓库
      IF V_WAREH IS NOT NULL AND V_WAREH <> 'ALL' THEN
        IF V_WAREH = 'GDZ' THEN
          V_SELECT1 := 'GDT';
        ELSIF V_WAREH = 'YWZ' THEN
          V_SELECT1 := 'YWT';
        ELSIF V_WAREH = 'GZZ' THEN
          V_SELECT1 := 'GZT';
        END IF;
        /*V_WH2_SQL := q'[  SELECT F.*,  F.EXAMOUNT / (REGEXP_COUNT(F.SHO_ID, ',') + 1) EXAMOUNT123
            FROM SCMDATA.T_RETURN_MANAGEMENT F
           WHERE ]' ||
                    '  (instr('',''||F.sho_id ||'','','',''||''' ||
                    V_WAREH || '''||'','')>0 or F.sho_id = ''' || V_SELECT1 ||
                    ''')';
        V_S_SQL:= V_S1_SQL||' FROM ( '||V_WH2_SQL||' ) A
                   INNER JOIN SCMDATA.T_COMMODITY_INFO B
                      ON A.GOO_ID = B.GOO_ID
                     AND A.COMPANY_ID = B.COMPANY_ID
                   INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                      ON C.ABNORMAL_DTL_CONFIG_ID = A.CAUSE_DETAIL_ID
                     AND C.COMPANY_ID = A.COMPANY_ID
                   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                      ON C.FIRST_DEPT_ID = D.COMPANY_DEPT_ID
                     AND C.COMPANY_ID = D.COMPANY_ID   ';*/
        /*V_S_SQL := q'[SELECT A.SUP_GROUP_NAME2, C.PROBLEM_CLASSIFICATION, C.CAUSE_CLASSIFICATION,
                         D.DEPT_NAME, (CASE WHEN C.IS_SUP_EXEMPTION = 0 THEN  '否' ELSE '是' END) IS_SUP_EXEMPTION,
                         SUM((A.EXAMOUNT * B.PRICE)/ (REGEXP_COUNT(a.sho_id , ',') + 1)) RMMONEY
                    FROM (SELECT z.*, REGEXP_SUBSTR(z.SUP_GROUP_NAME,'[^,]+',1,LEVEL) SUP_GROUP_NAME2
     FROM  SCMDATA.T_RETURN_MANAGEMENT z 
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', ''))) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL A
                   INNER JOIN SCMDATA.T_COMMODITY_INFO B
                      ON A.GOO_ID = B.GOO_ID
                     AND A.COMPANY_ID = B.COMPANY_ID
                   INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                      ON C.ABNORMAL_DTL_CONFIG_ID = A.CAUSE_DETAIL_ID
                     AND C.COMPANY_ID = A.COMPANY_ID
                   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                      ON C.FIRST_DEPT_ID = D.COMPANY_DEPT_ID
                     AND C.COMPANY_ID = D.COMPANY_ID   ]';*/
        V_S_SQL :=q'[SELECT E.GROUP_NAME SUP_GROUP_NAME2,
         C.PROBLEM_CLASSIFICATION,
         C.CAUSE_CLASSIFICATION,
         D.DEPT_NAME,
         (CASE   WHEN C.IS_SUP_EXEMPTION = 0 THEN '否'  ELSE  '是'  END) IS_SUP_EXEMPTION,
         SUM((CASE WHEN REGEXP_COUNT(a.SUP_GROUP_NAME, ',') > 0 THEN  a.EXAMOUNT * NVL(((SELECT SUM(R.ORDER_MONEY)
                       FROM SCMDATA.PT_ORDERED R
                      WHERE R.GOO_ID = a.RELA_GOO_ID
                        AND R.COMPANY_ID = a.COMPANY_ID
                        AND R.GROUP_NAME = a.SUP_GROUP_NAME2)/
         (SELECT SUM(R.ORDER_MONEY)
           FROM SCMDATA.PT_ORDERED R
          WHERE R.GOO_ID = a.RELA_GOO_ID 
            AND R.COMPANY_ID = a.COMPANY_ID)),(1/(REGEXP_COUNT(a.SUP_GROUP_NAME, ',')+1))) * b.price ELSE a.examount*b.price END )/ (REGEXP_COUNT(a.sho_id , ',') + 1)) RMMONEY 
             FROM (SELECT z.*, REGEXP_SUBSTR(z.SUP_GROUP_NAME,'[^,]+',1,LEVEL) SUP_GROUP_NAME2
     FROM  SCMDATA.T_RETURN_MANAGEMENT z 
   CONNECT BY PRIOR RM_ID = RM_ID
          AND LEVEL <= LENGTH(z.SUP_GROUP_NAME) -
              LENGTH(REGEXP_REPLACE(z.SUP_GROUP_NAME, ',', '')) + 1
          AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL) A
            INNER JOIN SCMDATA.T_COMMODITY_INFO B
                      ON A.GOO_ID = B.GOO_ID
                     AND A.COMPANY_ID = B.COMPANY_ID
                   INNER JOIN SCMDATA.T_ABNORMAL_DTL_CONFIG C
                      ON C.ABNORMAL_DTL_CONFIG_ID = A.CAUSE_DETAIL_ID
                     AND C.COMPANY_ID = A.COMPANY_ID
                   INNER JOIN SCMDATA.SYS_COMPANY_DEPT D
                      ON C.FIRST_DEPT_ID = D.COMPANY_DEPT_ID
                     AND C.COMPANY_ID = D.COMPANY_ID ]';         
       V_WH_SQL := V_WH_SQL || '  AND (instr('',''||A.sho_id ||'','','',''||''' ||
                    V_WAREH || '''||'','')>0 or A.sho_id = ''' || V_SELECT1 ||
                    ''') ' ;          
                     
      ELSE
        V_WH_SQL := V_WH_SQL || ' AND 1=1 ';
      END IF;


      IF V_ORIGIN IS NULL OR /*V_GROUP IS NULL OR V_CATE IS NULL  OR */
         V_DUTY IS NULL OR (V_DATE2 <> '04' AND V_DATE3 IS NULL) OR V_DATE2 IS NULL THEN
        --V_WH_SQL := V_WH_SQL || ' AND 1=1';
     v_sql:=q'[select '' AREA_GROUP, '' 分部, '' PROBLEM_CLASS_DESC, '' RESPON_DEPT_NAME,'' IS_SUP_EXEMPTION,
                      '' RT_RATE,
                      '' RMMONEY from dual ]';

     ELSE
      V_SQL := 'WITH TMP AS (' || V_S_SQL || V_WH_SQL || V_GR_SQL || ')
            SELECT SUP_GROUP_NAME2 AREA_GROUP,''' || V_VALUE ||
               ''' ' ||
               q'[分部,
                   PROBLEM_CLASSIFICATION,
                   CAUSE_CLASSIFICATION,
                   DEPT_NAME RESPON_DEPT_NAME,
                   IS_SUP_EXEMPTION,
                   RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE, RMMONEY FROM tmp
            union all
            SELECT '合计' AREA_GROUP,
                   '' 分部,
                   '' PROBLEM_CLASSIFICATION,
                   '' CAUSE_CLASSIFICATION,
                   '' RESPON_DEPT_NAME,
                   '' IS_SUP_EXEMPTION,
                   1 RT_RATE,
                   SUM(RMMONEY)   RMMONEY from tmp ]';
       END IF;
      ---------仓库
    ELSIF V_ORIGIN <> 'M' THEN
      --IF V_ORIGIN = 'ALL' THEN
      V_S_SQL := q'[SELECT E.GROUP_NAME,
       F.GROUP_DICT_NAME,
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END) FIRST_RESP_DEPT,
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END) IS_SUPP_DEPT,
        SUM((CASE WHEN A.PROCESSING_TYPE ='NM' AND A.subs_amount >0 THEN A.SUBS_AMOUNT
            WHEN A.PROCESSING_TYPE <> 'NM' THEN A.pcome_amount  END)*B.PRICE)  RMMONEY
 FROM SCMDATA.T_QA_SCOPE A
 INNER JOIN SCMDATA.T_COMMODITY_INFO B ON A.GOO_ID=B.GOO_ID AND A.COMPANY_ID=B.COMPANY_ID
 INNER JOIN SCMDATA.T_QA_REPORT C ON A.QA_REPORT_ID=C.QA_REPORT_ID AND A.COMPANY_ID=C.COMPANY_ID
INNER JOIN SCMDATA.T_ORDERED D  ON D.ORDER_CODE= A.ORDER_ID AND A.COMPANY_ID=D.COMPANY_ID
INNER JOIN SCMDATA.PT_ORDERED E ON D.ORDER_ID=E.ORDER_ID AND E.COMPANY_ID=A.COMPANY_ID
LEFT JOIN SCMDATA.SYS_GROUP_DICT F ON F.GROUP_DICT_VALUE=C.UNQUALREASON_CLASS AND F.GROUP_DICT_TYPE = 'QA_UNQUAL_REASON_CLASS'  ]';

      V_WH_SQL := '   WHERE C.STATUS IN (''N_ACF'',''R_ACF'')  AND A.ORIGIN = ''SCM'' ';


      IF V_WAREH IS NOT NULL AND V_WAREH <> 'ALL' THEN
        V_WH_SQL := V_WH_SQL || ' AND D.SHO_ID =''' || V_WAREH || '''';
      ELSE
        V_WH_SQL := V_WH_SQL || ' AND 1=1';
      END IF;

      --时间的条件
      IF V_DATE1 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL || ' AND EXTRACT(YEAR FROM A.COMMIT_TIME) =' ||
                    V_DATE1;
      ELSE
        V_WH_SQL := V_WH_SQL || '  AND 1=1';
      END IF;

      IF V_DATE2 = '01' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    ' AND LPAD (EXTRACT (MONTH FROM A.COMMIT_TIME),2,0)=' ||
                    V_DATE3;
      ELSIF V_DATE2 = '02' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    ' AND  LPAD(TO_CHAR(A.COMMIT_TIME,''Q''),2,0)=' ||
                    V_DATE3;
      ELSIF V_DATE2 = '03' AND V_DATE3 IS NOT NULL THEN
        V_WH_SQL := V_WH_SQL ||
                    ' AND  DECODE(TO_CHAR(A.COMMIT_TIME,''Q''),1,00,2,00,3,01,4,01)=' ||
                    V_DATE3;
      ELSIF V_DATE2 = '04' THEN
        V_WH_SQL := V_WH_SQL;
      END IF;

      --分部条件
      IF V_CATE <> '1' THEN
        V_WH_SQL := V_WH_SQL || '  AND B.CATEGORY = ''' || V_CATE || '''';
        V_SQL0   := 'SELECT GROUP_DICT_NAME
                  FROM SCMDATA.SYS_GROUP_DICT T WHERE T.GROUP_DICT_VALUE=''' ||
                    V_CATE || ''' AND T.GROUP_DICT_TYPE = ''PRODUCT_TYPE''';
        EXECUTE IMMEDIATE V_SQL0
          INTO V_VALUE;
      ELSIF V_CATE = '1' OR V_CATE IS NULL THEN
        V_WH_SQL := V_WH_SQL;
        V_VALUE  := '全部';
      END IF;

      --区域组
      IF V_GROUP <> '全部' THEN
        V_WH_SQL := V_WH_SQL || '  AND E.GROUP_NAME = ''' || V_GROUP ||
                    ''' AND A.COMPANY_ID = ''' || V_COMPID || '''';

         ELSIF V_GROUP = '全部' OR V_GROUP IS NULL THEN V_WH_SQL:=V_WH_SQL||' AND A.COMPANY_ID = '''||V_COMPID||'''';
      END IF;

      V_GR_SQL := q'[ GROUP BY E.GROUP_NAME,
       F.GROUP_DICT_NAME,(CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '供应链管理部' ELSE '无'END),
       (CASE WHEN C.UNQUALREASON_CLASS='MFL_FACTOR' OR
                  C.UNQUALREASON_CLASS='GY_FACTOR'  OR
                  C.UNQUALREASON_CLASS='WB_FACTOR' OR
                  C.UNQUALREASON_CLASS='BC_FACTOR' THEN '否' ELSE '是' END) ]';

      V_WH2_SQL := '  WHERE RMMONEY IS NOT NULL ';

      IF V_DUTY = '供应链管理部' THEN
        V_WH2_SQL := V_WH2_SQL || '  AND  FIRST_RESP_DEPT = ''' || V_DUTY ||
                     ''' ';
      ELSE
        V_WH2_SQL := V_WH2_SQL;
      END IF;

      IF V_ORIGIN IS NULL /*OR V_GROUP IS NULL*/ OR V_CATE IS NULL OR
         V_DUTY IS NULL OR (V_DATE2 <> '04' AND V_DATE3 IS NULL) OR V_DATE2 IS NULL THEN
        --V_WH_SQL := V_WH_SQL || ' AND 1=1';
        v_sql:=q'[select '' AREA_GROUP, '' 分部, '' PROBLEM_CLASS_DESC, '' RESPON_DEPT_NAME,'' IS_SUP_EXEMPTION,
                      '' RT_RATE,
                      '' RMMONEY from dual]';

    ELSE
      V_SQL := 'WITH TMP AS ( ' || V_S_SQL || V_WH_SQL || V_GR_SQL || ')
            SELECT GROUP_NAME AREA_GROUP, ''' || V_VALUE ||
               ''' ' ||
               q'[分部,
                   GROUP_DICT_NAME PROBLEM_CLASS_DESC,
                   FIRST_RESP_DEPT RESPON_DEPT_NAME,
                   IS_SUPP_DEPT IS_SUP_EXEMPTION,
                   RMMONEY/(SELECT SUM(RMMONEY) FROM tmp) RT_RATE, RMMONEY FROM tmp ]' ||
               V_WH2_SQL || q'[
             union all
             select '合计' AREA_GROUP,
                    '' 分部,
                    '' PROBLEM_CLASS_DESC,
                    '' RESPON_DEPT_NAME,
                    '' IS_SUP_EXEMPTION,
                    1  RT_RATE,
                    SUM(RMMONEY) RMMONEY FROM TMP ]' ||
               V_WH2_SQL;
    END IF;
    END IF;
    RETURN V_SQL;

  END F_RETURN_CAUSE_QY_ANALYSIS;
END PKG_RETURN_ANALYSIS;
/

