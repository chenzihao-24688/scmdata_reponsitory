CREATE OR REPLACE PACKAGE SCMDATA.PKG_APPROVE_SIZE_IMPORT_CHECK IS

  /*========================================================*
  * Author                : ZhangCheng
  * Created               : 2020年10月19日14:39:46
  * ALERTER               :
  * ALERTER_TIME          :
  * Purpose               : 用于纯数字校验
  * Obj_Name              : F_NUMBER_ONLY_CHECK
  * Arg_Number            : 2
  * Check_value           ：被校验值
  * Show_Name             ：该值所在列中文名称
  *=========================================================*/
  FUNCTION F_NUMBER_ONLY_CHECK(CHECK_VALUE VARCHAR2, SHOW_NAME VARCHAR2)
    RETURN VARCHAR2;

  /*========================================================*
  * Author                : ZhangCheng
  * Created               : 2020年10月19日14:39:46
  * ALERTER               :
  * ALERTER_TIME          :
  * Purpose               : 用于中文字符及标点校验
  * Obj_Name              : F_NUMBER_ONLY_CHECK
  * Arg_Number            : 2
  * Check_value           ：被校验值
  * Show_Name             ：该值所在列中文名称
  *=========================================================*/
  FUNCTION F_CHINESE_ONLY_CHECK(CHECK_VALUE VARCHAR2, SHOW_NAME VARCHAR2)
    RETURN VARCHAR2;

  /*========================================================*
  * Author                : ZhangCheng
  * Created               : 2020年10月19日14:39:46
  * ALERTER               : ZhangCheng
  * ALERTER_TIME          : 2020年10月20日14:27:02
  * Purpose               : 用于重复值校验
  * Obj_Name              : F_NUMBER_ONLY_CHECK
  * Arg_Number            : 4
  * Col_Name              ：被校验列·名称
  * Show_Name             ：被校验列·中文名称
	* Tar_value             : 被检测值
  * Imp_Table_Name        ：被导入表·名称
  * Ord_Table_Name        ：目标表·名称
	* Comp_id               ：公司ID
	* User_id               : 用户ID
	* Avid                  : 批版记录ID
  *=========================================================*/
  FUNCTION F_REPEAT_VALUE_CHECK(COL_NAME       VARCHAR2,
                                SHOW_NAME      VARCHAR2,
																TAR_VALUE      VARCHAR2,
                                IMP_TABLE_NAME VARCHAR2,
                                ORD_TABLE_NAME VARCHAR2,
                                COMP_ID        VARCHAR2,
                                USER_ID        VARCHAR2,
                                AVID           VARCHAR2) RETURN VARCHAR2;

  /*========================================================*
  * Author                : ZhangCheng
  * Created               : 2020年10月19日14:39:46
  * ALERTER               : ZhangCheng
  * ALERTER_TIME          : 2020年10月20日14:27:23
  * Purpose               : 批版导入校验存储过程
  * Obj_Name              : F_NUMBER_ONLY_CHECK
  * Arg_Number            : 3
  * Imp_Table_Name        ：导入表·名称
  * Cid                   : 公司ID
  * Uid                   ：用户ID
  *=========================================================*/
  PROCEDURE P_CHECK_VALUES(IMP_TNAME  VARCHAR2,
                           ORD_TNAME  VARCHAR2,
                           COMPANY_ID VARCHAR2,
                           USER_ID    VARCHAR2,
                           AVID       VARCHAR2);

  /*========================================================*
  * Author                : ZhangCheng
  * Created               : 2020年10月20日09:33:52
  * ALERTER               :
  * ALERTER_TIME          :
  * Purpose               : 依据 company_id, user_id, approve_version_id 
	                          删除 UAT_APPROVE_SIZE内部数据，用于导入，提交
  * Obj_Name              : F_NUMBER_ONLY_CHECK
  * Arg_Number            : 3
  * Approve_version_id    ：导入表·名称
  * Compid                : 公司ID
  * Userid                ：用户ID
  *=========================================================*/
  PROCEDURE P_DELETE_UAT_APPROVE_SIZE(COMPID             VARCHAR2,
                                      USERID             VARCHAR2,
                                      AVID VARCHAR2);



END PKG_APPROVE_SIZE_IMPORT_CHECK;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_APPROVE_SIZE_IMPORT_CHECK IS

  --数值校验fuction
  FUNCTION F_NUMBER_ONLY_CHECK(CHECK_VALUE VARCHAR2, SHOW_NAME VARCHAR2)
    RETURN VARCHAR2 IS
    NOC_ERROR_STR VARCHAR2(500);
  BEGIN
    IF REGEXP_INSTR(CHECK_VALUE, '^(-?\d+)(\.\d+)?$|^[0-9]*$') = 0 THEN
      NOC_ERROR_STR := SHOW_NAME || '列中' || CHECK_VALUE ||
                       '不是数值，请修改该值或重新导入' || chr(13);
    ELSE
      NOC_ERROR_STR := '';
    END IF;
    RETURN NOC_ERROR_STR;
  END F_NUMBER_ONLY_CHECK;

  --中文及标点校验function
  FUNCTION F_CHINESE_ONLY_CHECK(CHECK_VALUE VARCHAR2, SHOW_NAME VARCHAR2)
    RETURN VARCHAR2 IS
    COC_ERROR_STR VARCHAR2(500);
  BEGIN
    IF REGEXP_INSTR(CHECK_VALUE, '^[\u4e00-\u9fa5|\w|\W]*$') = 0 THEN
      COC_ERROR_STR := SHOW_NAME || '列中' || CHECK_VALUE ||
                       '不是中文，请修改该值或重新导入' || chr(13);
    ELSE
      COC_ERROR_STR := '';
    END IF;
    RETURN COC_ERROR_STR;
  END F_CHINESE_ONLY_CHECK;

  --重复值校验function
  FUNCTION F_REPEAT_VALUE_CHECK(COL_NAME       VARCHAR2,
                                SHOW_NAME      VARCHAR2,
                                TAR_VALUE      VARCHAR2,
                                IMP_TABLE_NAME VARCHAR2,
                                ORD_TABLE_NAME VARCHAR2,
                                COMP_ID        VARCHAR2,
                                USER_ID        VARCHAR2,
                                AVID           VARCHAR2) RETURN VARCHAR2 IS
    JUDGE         NUMBER(1);
    SQL_STR       VARCHAR2(800);
    RVC_ERROR_STR VARCHAR2(500);
  BEGIN
    SQL_STR := 'SELECT COUNT(TARGET_COL)
                FROM (SELECT ' || COL_NAME ||
               ' TARGET_COL
                        FROM ' || IMP_TABLE_NAME ||
               ' WHERE COMPANY_ID = ''' || COMP_ID || ''' AND USER_ID = ''' ||
               USER_ID || ''' AND APPROVE_VERSION_ID = ''' || AVID ||
               ''' UNION ALL
                      SELECT ' || COL_NAME ||
               ' TARGET_COL
                        FROM ' || ORD_TABLE_NAME ||
               ' WHERE COMPANY_ID = ''' || COMP_ID ||
               ''' AND APPROVE_VERSION_ID = ''' || AVID || ''')
                            WHERE TARGET_COL = ''' || TAR_VALUE || '''';
    EXECUTE IMMEDIATE SQL_STR
      INTO JUDGE;
    IF JUDGE > 1 THEN
      RVC_ERROR_STR := SHOW_NAME || '列列值与表中数据重复，请删除该行';
    ELSE
      RVC_ERROR_STR := '';
    END IF;
  
    RETURN RVC_ERROR_STR;
  END F_REPEAT_VALUE_CHECK;

  --导入数据校验procedure
  PROCEDURE P_CHECK_VALUES(IMP_TNAME  VARCHAR2,
                           ORD_TNAME  VARCHAR2,
                           COMPANY_ID VARCHAR2,
                           USER_ID    VARCHAR2,
                           AVID       VARCHAR2) IS
    TMP_INFO VARCHAR2(800);
    TYPE UATCURTYP IS REF CURSOR;
    UAT_CURSOR UATCURTYP;
    UAT_ROW    SCMDATA.UAT_APPROVE_SIZE%ROWTYPE;
    SQL_STR    VARCHAR2(200);
  BEGIN
    SQL_STR := 'SELECT * FROM ' || IMP_TNAME ||
               ' WHERE COMPANY_ID=:COMPANY_ID AND USER_ID=:USER_ID AND APPROVE_VERSION_ID=:AVID';
  
    OPEN UAT_CURSOR FOR SQL_STR
      USING COMPANY_ID, USER_ID, AVID;
  
    LOOP
      FETCH UAT_CURSOR
        INTO UAT_ROW;
      TMP_INFO := '';
    
      --数值类型校验
      TMP_INFO := TMP_INFO ||
                  F_NUMBER_ONLY_CHECK(UAT_ROW.STD_SIZE, '初始尺寸');
      TMP_INFO := TMP_INFO ||
                  F_NUMBER_ONLY_CHECK(UAT_ROW.TEMPLATE_SIZE, '样板尺寸');
      TMP_INFO := TMP_INFO ||
                  F_NUMBER_ONLY_CHECK(UAT_ROW.CRAFTSMAN_SIZE, '标准尺寸');
    
      --重复值校验
      TMP_INFO := TMP_INFO || F_REPEAT_VALUE_CHECK('POSITION',
                                                   '部位',
                                                   UAT_ROW.POSITION,
                                                   IMP_TNAME,
                                                   ORD_TNAME,
                                                   COMPANY_ID,
                                                   USER_ID,
                                                   AVID);
    
      --更新表内数据
      UPDATE SCMDATA.UAT_APPROVE_SIZE
         SET ERROR_INFO = TMP_INFO
       WHERE IMPORT_ID = UAT_ROW.IMPORT_ID;
    
      --退出游标
      EXIT WHEN UAT_CURSOR%NOTFOUND;
    END LOOP;
    COMMIT;
  END P_CHECK_VALUES;

  --删除数据procedure
  PROCEDURE P_DELETE_UAT_APPROVE_SIZE(COMPID VARCHAR2,
                                      USERID VARCHAR2,
                                      AVID   VARCHAR2) IS
    TAR_SQL VARCHAR2(300);
  BEGIN
    TAR_SQL := 'DELETE FROM SCMDATA.UAT_APPROVE_SIZE WHERE COMPANY_ID=:COMID AND USER_ID=:USERID AND APPROVE_VERSION_ID=:AVID';
    EXECUTE IMMEDIATE TAR_SQL
      USING COMPID, USERID, AVID;
		COMMIT;
  END;

END PKG_APPROVE_SIZE_IMPORT_CHECK;
/

