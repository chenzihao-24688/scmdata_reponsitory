CREATE OR REPLACE PACKAGE SCMDATA.PKG_ARCHIVE_COMMON AUTHID CURRENT_USER IS
  --依据根节点 ITEMID 获取各节点 ITEM_ID
  FUNCTION F_GET_ALLITEMS_BY_ROOTITEM(ROOT_ITEMID IN VARCHAR2) RETURN CLOB;

  --通过根节点 ITME_ID 获取基本的 ITEMS
  FUNCTION F_GET_BASIC_ITEMS(ROOT_ITEMID IN VARCHAR2) RETURN CLOB;

  --获取 SHORTCUT ITEMS
  FUNCTION F_GET_SHORTCUT_ITEMS(INS_ITEMS IN VARCHAR2) RETURN CLOB;

  --获取 ASSOCIATE ITEMS
  FUNCTION F_GET_ASSO_ITEMS(INS_ITEMS IN VARCHAR2) RETURN CLOB;

  --获取 ITEM_RELA ITEMS
  FUNCTION F_GET_ITEMRELA_ITEMS(INS_ITEMS IN VARCHAR2) RETURN CLOB;

  --获取 WEB_UNION_ITEMS
  FUNCTION F_GET_WEBUNION_ITEMS(INS_ITEMS   IN VARCHAR2) RETURN CLOB;

  --获取当前 ITEM_ID 通过 COND 跳转的 ITEM_ID
  FUNCTION F_GET_COND_OPERATE_RELA(V_ITEMS   IN CLOB) RETURN CLOB;

  --获取ACTION中所有表
  FUNCTION F_GET_ACTIONS_TABS(INS_ITEMS IN VARCHAR2,
                              INS_TABS  IN VARCHAR2) RETURN CLOB;

  --获取 SQL 中的所有表
  FUNCTION F_GET_TABS_FROM_SQL(INS_SQL  IN VARCHAR2,
                               INS_TABS IN VARCHAR2,
                               PATTERN  IN VARCHAR2) RETURN CLOB;

  --获取所有表
  FUNCTION F_GET_ALL_TABS(ROOT_ITEMID IN VARCHAR2) RETURN CLOB;

  --创建归档表
  PROCEDURE P_CREATE_ARCTAB(OWNER IN VARCHAR2,
                            TAB   IN VARCHAR2);

  --判断归档表配置是否符合要求
  FUNCTION F_JUDGE_TABCONFIG_INFO(OWNER    IN VARCHAR2,
                                  TAB_NAME IN VARCHAR2,
                                  TAB_COND IN VARCHAR2) RETURN VARCHAR2;

  --获取主键
  FUNCTION F_GET_PK(OATABLE IN VARCHAR2) RETURN VARCHAR2;

  --获取格式化字符串（带游标前缀,不可作为其他地方通用）
  FUNCTION F_GET_FORMATED_FIELDS(OWNER     IN VARCHAR2,
                                 TAB_NAME  IN VARCHAR2,
                                 COLS      IN VARCHAR2,
                                 CUR_PRF   IN VARCHAR2) RETURN CLOB;

  --生成未归档主键列值
  FUNCTION F_GENERATE_FOLLOW_ARCHIVE_COND_AND_UNQVALS(EXE_TIME    IN VARCHAR2,
                                                      MAS_TAB     IN VARCHAR2,
                                                      SLA_TAB     IN VARCHAR2,
                                                      COND_STR    IN VARCHAR2,
                                                      SLA_PK      IN VARCHAR2,
                                                      ALARC_VALS  IN VARCHAR2) RETURN CLOB;

  --单表删除逻辑
  PROCEDURE P_DELETE_RELA_DATA(TAB_OWNER  IN VARCHAR2,
                               TAB_NAME   IN VARCHAR2,
                               COND_STR   IN VARCHAR2,
                               COLS       IN VARCHAR2,
                               FMT_COL    IN VARCHAR2,
                               CF_ID      IN VARCHAR2,
                               RUNTIME    IN DATE);
  --批量删除逻辑
  PROCEDURE P_BATCH_DELETE(CF_ID    IN VARCHAR2,
                           RTIME    IN DATE);

  --归档·总
  PROCEDURE P_BATCH_ARCHIVE(CF_ID    IN VARCHAR2,
                            ROOTITEM IN VARCHAR2,
                            CUSER    IN VARCHAR2);

  --单表归档
  PROCEDURE P_SINGLE_TAB_ARCHIVE(OWNER        IN VARCHAR2,
                                 TAB_NAME     IN VARCHAR2,
                                 TAB_COLS     IN VARCHAR2,
                                 COND_STR     IN VARCHAR2,
                                 FMT_COL      IN VARCHAR2,
                                 FMT_CUR_VCOL IN VARCHAR2,
                                 EXE_ORD      IN NUMBER,
                                 EXE_TIME     IN VARCHAR2,
                                 CF_ID        IN VARCHAR2,
                                 CURR_USER    IN VARCHAR2);

  --获取格式化字符串（带游标前缀,不可作为其他地方通用）
  FUNCTION F_GET_FORMATED_COL(OWNER     IN VARCHAR2,
                              TAB_NAME  IN VARCHAR2,
                              COLS      IN VARCHAR2)  RETURN CLOB;

  --仅用于用户 SCMDATA 获取 SELECT_SQL 中主表
  FUNCTION F_GET_MAJORTAB(INS_SQL  IN VARCHAR2) RETURN VARCHAR2;

  --仅用于用户 SCMDATA 获取 SELECT_SQL 中主表及关联条件
  FUNCTION F_GET_MAJORTAB_AND_WHERECLAUSE(INS_SQL  IN VARCHAR2) RETURN VARCHAR2;

  --仅对错误数据进行处理
  FUNCTION F_ARCHIVE_ERR_GET_COLNAME_BY_COLVAL_WITH_TYPE(EXE_SQL    IN VARCHAR2,
                                                         TAR_COL    IN VARCHAR2) RETURN VARCHAR2;

  --单条数据错误校验
  FUNCTION F_ERR_CHECK(OATABLE    IN VARCHAR2,
                       FMT_COLS   IN VARCHAR2,
                       UNQ_COL    IN VARCHAR2,
                       UNQ_VAL    IN VARCHAR2) RETURN VARCHAR2;

  --单条数据归档
  PROCEDURE P_SINGLE_DATA_ARCHIVE(OAT    IN VARCHAR2,
                                  FMTC   IN VARCHAR2,
                                  UNQC   IN VARCHAR2,
                                  UNQV   IN VARCHAR2,
                                  ERSQ   IN CLOB,
                                  SDID   IN VARCHAR2);

  --校验且完成校验后的逻辑
  PROCEDURE P_CHECK_AND_CHECKPROCESSING(OBJ_ID  IN VARCHAR2,
                                        RM      IN VARCHAR2);

  --更新 CONFIG 表状态
  PROCEDURE P_UPDATE_CONFIG_STATUS(CONFIG_ID  IN VARCHAR2);

  --更新 ARCHIVE_LOG 表
  PROCEDURE P_UPDATE_ARCHIVE_LOG(LOG_ID    IN VARCHAR2,
                                 COLS      IN VARCHAR2,
                                 FMT_VALS  IN VARCHAR2);

  --更新 ARCHIVE_ERR_SINGLE_DATA 表
  PROCEDURE P_UPDATE_ARCHIVE_ERR_SINGLE_DATA(SD_ID     IN VARCHAR2,
                                             COLS      IN VARCHAR2,
                                             FMT_VALS  IN VARCHAR2);

  --执行顺序校验
  PROCEDURE P_CHECK_ARCHIVE_ORDERS(ESD_ID  IN VARCHAR2);



END PKG_ARCHIVE_COMMON;
/

CREATE OR REPLACE PACKAGE BODY SCMDATA.PKG_ARCHIVE_COMMON IS
  --依据根节点 itemid 获取各节点 ITEM_ID
  --ROOT_ITEM_ID : 根节点 ITEM_ID
  FUNCTION F_GET_ALLITEMS_BY_ROOTITEM(ROOT_ITEMID   IN VARCHAR2) RETURN CLOB IS
    OLD_ITEMS CLOB := '0';
    NEW_ITEMS CLOB := '1';
    ITEMS     CLOB;
  BEGIN
    ITEMS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_BASIC_ITEMS(ROOT_ITEMID => ROOT_ITEMID);
    IF ITEMS <> ' ' THEN
      WHILE NEW_ITEMS <> OLD_ITEMS LOOP
        ITEMS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_SHORTCUT_ITEMS(ITEMS);
        ITEMS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_ASSO_ITEMS(ITEMS);
        ITEMS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_ITEMRELA_ITEMS(ITEMS);
        ITEMS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_WEBUNION_ITEMS(ITEMS);
        ITEMS := F_GET_COND_OPERATE_RELA(V_ITEMS => ITEMS);
        --去重
        SELECT xmlagg(xmlparse(content COL || ',' wellformed) ORDER BY 1).getclobval() --LISTAGG(DISTINCT COL, ',')  
          INTO NEW_ITEMS
          FROM (SELECT DISTINCT COL from (SELECT to_char(REGEXP_SUBSTR(ITEMS, '[^,]+', 1, LEVEL)) COL
                  FROM DUAL
                CONNECT BY LEVEL <= REGEXP_COUNT(ITEMS, '\,') + 1));
                
        IF NEW_ITEMS <> OLD_ITEMS THEN
          OLD_ITEMS := NEW_ITEMS;
          NEW_ITEMS := '1';
        END IF;
      END LOOP;
    END IF;
    RETURN NEW_ITEMS;
  END F_GET_ALLITEMS_BY_ROOTITEM;



  --通过根节点 ITME_ID 获取基本的 ITEMS
  FUNCTION F_GET_BASIC_ITEMS(ROOT_ITEMID   IN VARCHAR2) RETURN CLOB IS
    EXE_SQL  CLOB;
    RET_STR  CLOB;
  BEGIN
    EXE_SQL := 'SELECT NVL(LISTAGG(DISTINCT A.ITEM_ID,'',''),'' '')
                  FROM (SELECT ITEM_ID, CONNECT_BY_ISCYCLE ISCYCLED
                          FROM NBW.SYS_TREE_LIST
                         WHERE PAUSE = 0
                         START WITH ITEM_ID = LOWER('''||ROOT_ITEMID||''')
                         CONNECT BY NOCYCLE PARENT_ID = PRIOR ITEM_ID) A
                  INNER JOIN NBW.SYS_ITEM B
                          ON A.ITEM_ID = B.ITEM_ID
                         AND UPPER(B.ITEM_TYPE) <> ''MENU''';
    EXECUTE IMMEDIATE EXE_SQL INTO RET_STR;
    RETURN RET_STR;
  END F_GET_BASIC_ITEMS;



  --获取 SHORTCUT ITEMS
  FUNCTION F_GET_SHORTCUT_ITEMS(INS_ITEMS   IN VARCHAR2) RETURN CLOB IS
    EXE_SQL  CLOB;
    RET_STR  CLOB;
  BEGIN
    EXE_SQL := 'SELECT NVL(LISTAGG(ITEM_ID,'',''),'' '')
                  FROM NBW.SYS_TREE_LIST
                 WHERE PAUSE = 0
                   AND NODE_ID IN
                         (SELECT SHORT_PATH
                            FROM NBW.SYS_SHORTCUT
                           WHERE SHORT_ID IN
                                   (SELECT SHORT_ID
                                      FROM NBW.SYS_SHORTCUT_NODE_RELA
                                     WHERE PAUSE = 0
                                       AND NODE_ID IN
                                            (SELECT NODE_ID
                                               FROM NBW.SYS_TREE_LIST
                                              WHERE ITEM_ID IN (''' || REPLACE(INS_ITEMS,',',''',''') ||'''))))';
    EXECUTE IMMEDIATE EXE_SQL INTO RET_STR;
    IF RET_STR = ' ' THEN
       RET_STR := INS_ITEMS;
    ELSE
      RET_STR := INS_ITEMS ||','|| RET_STR;
    END IF;
    RETURN RET_STR;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN INS_ITEMS;
  END F_GET_SHORTCUT_ITEMS;



  --获取 ASSOCIATE ITEMS
  FUNCTION F_GET_ASSO_ITEMS(INS_ITEMS IN VARCHAR2) RETURN CLOB IS
    EXE_SQL CLOB;
    RET_STR CLOB;
  BEGIN
    EXE_SQL := 'SELECT NVL(LISTAGG(CITEM,'',''),'' '')
                  FROM (SELECT CONNECT_BY_ISCYCLE ISCYCLED, CITEM
                          FROM (SELECT A.ITEM_ID AITEM, C.ITEM_ID CITEM
                                  FROM NBW.SYS_ITEM_ELEMENT_RELA A
                                  INNER JOIN NBW.SYS_ASSOCIATE B
                                    ON A.ELEMENT_ID = B.ELEMENT_ID
                                  INNER JOIN NBW.SYS_TREE_LIST C
                                    ON B.NODE_ID = C.NODE_ID
                                  WHERE A.PAUSE = 0)
                 START WITH AITEM IN (''' || REPLACE(INS_ITEMS,',',''',''') ||''')
                 CONNECT BY NOCYCLE AITEM = PRIOR CITEM)';
    EXECUTE IMMEDIATE EXE_SQL INTO RET_STR;
    IF RET_STR = ' ' THEN
       RET_STR := INS_ITEMS;
    ELSE
      RET_STR := INS_ITEMS ||','|| RET_STR;
    END IF;
    RETURN RET_STR;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN INS_ITEMS;
  END F_GET_ASSO_ITEMS;



  --获取 ITEM_RELA ITEMS
  FUNCTION F_GET_ITEMRELA_ITEMS(INS_ITEMS   IN VARCHAR2) RETURN CLOB IS
    EXE_SQL  CLOB;
    RET_STR  CLOB;
  BEGIN
    EXE_SQL := 'SELECT NVL(LISTAGG(RELATE_ID, '',''),'' '')
                  FROM (SELECT DISTINCT RELATE_ID, CONNECT_BY_ISCYCLE ISCYCLED
                          FROM NBW.SYS_ITEM_RELA A
                         WHERE A.PAUSE = 0
                         START WITH ITEM_ID IN (''' || REPLACE(INS_ITEMS,',',''',''') ||''')
                         CONNECT BY NOCYCLE ITEM_ID = PRIOR RELATE_ID)';
    EXECUTE IMMEDIATE EXE_SQL INTO RET_STR;
    IF RET_STR = ' ' THEN
       RET_STR := INS_ITEMS;
    ELSE
      RET_STR := INS_ITEMS ||','|| RET_STR;
    END IF;
    RETURN RET_STR;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN INS_ITEMS;
  END F_GET_ITEMRELA_ITEMS;


  --获取 WEB_UNION_ITEMS
  FUNCTION F_GET_WEBUNION_ITEMS(INS_ITEMS   IN VARCHAR2) RETURN CLOB IS
    EXE_SQL  CLOB;
    RET_STR  CLOB;
  BEGIN
    EXE_SQL := 'SELECT LISTAGG(UNION_ITEM_ID,'','')
                  FROM NBW.SYS_WEB_UNION
                 WHERE PAUSE = 0
                   AND ITEM_ID IN ('''||REPLACE(INS_ITEMS,',',''',''')||''')';
    EXECUTE IMMEDIATE EXE_SQL INTO RET_STR;
    IF RET_STR = ' ' THEN
      RET_STR := INS_ITEMS;
    ELSE
      RET_STR := INS_ITEMS ||','|| RET_STR;
    END IF;
    RETURN RET_STR;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN INS_ITEMS;
  END F_GET_WEBUNION_ITEMS;


  --获取当前 ITEM_ID 通过 COND 跳转的 ITEM_ID
  FUNCTION F_GET_COND_OPERATE_RELA(V_ITEMS   IN CLOB) RETURN CLOB IS
    V_ELEMENTS   CLOB;
    V_IES        CLOB;
    V_RETCLOB    CLOB;
  BEGIN
    FOR I IN (SELECT ELEMENT_ID FROM NBW.SYS_ITEM_ELEMENT_RELA
               WHERE INSTR(','||V_ITEMS||',', ','||ITEM_ID||',')>0) LOOP
      V_ELEMENTS := V_ELEMENTS || ',' || I.ELEMENT_ID;
    END LOOP;

    V_IES := ',' || V_ITEMS || V_ELEMENTS || ',';

    SELECT NVL(LISTAGG(DISTINCT B.TO_CONFIRM_ITEM_ID||','||B.TO_CANCEL_ITEM_ID, ','), ' ')
      INTO V_RETCLOB
      FROM (SELECT COND_ID
              FROM NBW.SYS_COND_RELA
             WHERE INSTR(V_IES,','||CTL_ID||',')>0
               AND PAUSE = 0) A
     INNER JOIN NBW.SYS_COND_OPERATE B
        ON A.COND_ID = B.COND_ID;

    IF V_RETCLOB = ' ' THEN
      V_RETCLOB := V_IES;
    ELSE
      V_RETCLOB := V_IES ||','|| V_RETCLOB;
    END IF;
    RETURN V_RETCLOB;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN V_ITEMS;
  END F_GET_COND_OPERATE_RELA;







  --获取 SQL 中的所有表
  FUNCTION F_GET_TABS_FROM_SQL(INS_SQL  IN VARCHAR2,
                               INS_TABS IN VARCHAR2,
                               PATTERN  IN VARCHAR2) RETURN CLOB IS
    POS1     NUMBER(8);
    POS2     NUMBER(8);
    TMP_SQL  CLOB;
    TMP_TAB  VARCHAR2(2048);
    TABS     CLOB;
    PATS     VARCHAR2(512);
    TMP_PAT  VARCHAR2(64);
  BEGIN
    PATS := PATTERN||',';
    TABS := UPPER(INS_TABS);
    TMP_SQL := UPPER(INS_SQL);
    WHILE LENGTH(PATS) > 0 LOOP
      TMP_PAT := SUBSTR(PATS,1,INSTR(PATS,',')-1);
      PATS := REPLACE(PATS,TMP_PAT||',');
      WHILE REGEXP_COUNT(TMP_SQL, TMP_PAT) > 0 LOOP
        POS1 := REGEXP_INSTR(TMP_SQL,TMP_PAT)+LENGTH(TMP_PAT);
        POS1 := REGEXP_INSTR(TMP_SQL,'\w',POS1,1);
        POS2 := REGEXP_INSTR(TMP_SQL,'\s|\)',POS1,1);
        TMP_TAB := SUBSTR(TMP_SQL,POS1,POS2-POS1);
        IF REGEXP_COUNT(TMP_TAB,'T_|SYS_') > 0 THEN
          IF REGEXP_COUNT(TABS||',',TMP_TAB||',')=0 THEN
            IF INSTR(TMP_TAB,'SCMDATA.') = 0 AND INSTR(TMP_TAB,'NBW.') = 0 THEN
              TABS := TABS||',SCMDATA.'||TMP_TAB;
            ELSE
              TABS := TABS||','||TMP_TAB;
            END IF;
          END IF;
        END IF;
        TMP_SQL := SUBSTR(TMP_SQL,POS2,LENGTH(TMP_SQL)-POS2+1);
      END LOOP;
    END LOOP;
    RETURN LTRIM(TABS,',');
  END F_GET_TABS_FROM_SQL;



  --获取action中所有表
  FUNCTION F_GET_ACTIONS_TABS(INS_ITEMS  IN VARCHAR2,
                              INS_TABS   IN VARCHAR2) RETURN CLOB IS
    EXE_SQL   CLOB;
    TYPE      ACTYPE IS REF CURSOR;
    ACTCUR    ACTYPE;
    ACTROW    NBW.SYS_ACTION%ROWTYPE;
    TABS      CLOB;
  BEGIN
    TABS := INS_TABS;
    EXE_SQL := 'SELECT A.*
                  FROM NBW.SYS_ACTION A
                 WHERE EXISTS (SELECT 1
                                 FROM NBW.SYS_ITEM_ELEMENT_RELA
                                WHERE ELEMENT_ID = A.ELEMENT_ID
                                  AND PAUSE = 0
                                  AND ITEM_ID IN ('''||REPLACE(INS_ITEMS,',',''',''')||'''))';
    OPEN ACTCUR FOR EXE_SQL;
    LOOP
      FETCH ACTCUR INTO ACTROW;
        TABS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_TABS_FROM_SQL(UPPER(ACTROW.ACTION_SQL),TABS,'INSERT INTO,UPDATE,DELETE FROM');
      EXIT WHEN ACTCUR%NOTFOUND;
    END LOOP;
    CLOSE ACTCUR;
    RETURN TABS;
  END F_GET_ACTIONS_TABS;



  --获取 owners 相关所有表名称
  FUNCTION F_GET_ALL_TABS(ROOT_ITEMID   IN VARCHAR2) RETURN CLOB IS
    ITEMS      CLOB;
    TABS       CLOB;
  BEGIN
    ITEMS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_ALLITEMS_BY_ROOTITEM(ROOT_ITEMID);
    IF ITEMS <> ' ' THEN
      FOR I IN (SELECT SELECT_SQL, INSERT_SQL, UPDATE_SQL, DELETE_SQL, ITEM_ID
                  FROM NBW.SYS_ITEM_LIST
                 WHERE REGEXP_COUNT(ITEMS||',', ITEM_ID||',') > 0) LOOP
        TABS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_TABS_FROM_SQL(I.SELECT_SQL||' '||I.INSERT_SQL||' '||
                                                                 I.UPDATE_SQL||' '||I.DELETE_SQL||' ',TABS,'FROM');
      END LOOP;
    END IF;
    TABS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_ACTIONS_TABS(ITEMS,TABS);
    RETURN TABS;
  END F_GET_ALL_TABS;



  --判断创建归档表
  PROCEDURE P_CREATE_ARCTAB(OWNER   IN VARCHAR2,
                            TAB     IN VARCHAR2) IS
    OATABLE  VARCHAR2(64);
    JUDGE    NUMBER(1);
    SQL_STR  CLOB;
  BEGIN
    OATABLE := OWNER||'.'||TAB;
    SELECT SIGN(COUNT(1))
      INTO JUDGE
      FROM SCMDATA.ALL_TABLES_BACKUP
     WHERE OWNER = OWNER
       AND TABLE_NAME = TAB||'_ARCHIVE';
    IF JUDGE = 0 THEN
      SQL_STR := 'CREATE TABLE '||OATABLE||'_ARCHIVE AS SELECT * FROM '||OATABLE||' WHERE 1=2';
      EXECUTE IMMEDIATE SQL_STR;
      SQL_STR := 'ALTER TABLE '||OATABLE||'_ARCHIVE ADD ARC_ID VARCHAR2(32) NOT NULL';
      EXECUTE IMMEDIATE SQL_STR;
      SQL_STR := 'ALTER TABLE '||OATABLE||'_ARCHIVE ADD ARC_TIME DATE NOT NULL';
      EXECUTE IMMEDIATE SQL_STR;
      SQL_STR := 'ALTER TABLE '||OATABLE||'_ARCHIVE ADD ARC_CREATOR VARCHAR2(32) NOT NULL';
      EXECUTE IMMEDIATE SQL_STR;
      SQL_STR := 'ALTER TABLE '||OATABLE||'_ARCHIVE ADD PRIMARY KEY (ARC_ID)';
      EXECUTE IMMEDIATE SQL_STR;
      SQL_STR := 'CREATE INDEX IDX_'||REPLACE(OATABLE,'.','_')||'_ARCHIVE_ARC_TIME ON '||OATABLE||'_ARCHIVE(ARC_TIME)';
      EXECUTE IMMEDIATE SQL_STR;
      SQL_STR := 'INSERT INTO SCMDATA.ALL_TABLES_BACKUP
                    (ACTIVITY_TRACKING,ADMIT_NULL,AVG_ROW_LEN,AVG_SPACE,AVG_SPACE_FREELIST_BLOCKS,BACKED_UP,BLOCKS,
                     BUFFER_POOL,CACHE,CELLMEMORY,CELL_FLASH_CACHE,CHAIN_CNT,CLUSTERING,CLUSTER_NAME,CLUSTER_OWNER,
                     COMPRESSION,COMPRESS_FOR,CONTAINERS_DEFAULT,CONTAINER_DATA,CONTAINER_MAP,CONTAINER_MAP_OBJECT,
                     DATA_LINK_DML_ENABLED,DEFAULT_COLLATION,DEGREE,DEPENDENCIES,DML_TIMESTAMP,DROPPED,DUPLICATED,
                     DURATION,EMPTY_BLOCKS,EXTENDED_DATA_LINK,EXTENDED_DATA_LINK_MAP,EXTERNAL,FLASH_CACHE,FREELISTS,
                     FREELIST_GROUPS,GLOBAL_STATS,HAS_IDENTITY,HAS_SENSITIVE_COLUMN,HYBRID,INITIAL_EXTENT,INI_TRANS,
                     INMEMORY,INMEMORY_COMPRESSION,INMEMORY_DISTRIBUTE,INMEMORY_DUPLICATE,INMEMORY_PRIORITY,INMEMORY_SERVICE,
                     INMEMORY_SERVICE_NAME,INSTANCES,IOT_NAME,IOT_TYPE,LAST_ANALYZED,LOGGING,LOGICAL_REPLICATION,MAX_EXTENTS,
                     MAX_TRANS,MEMOPTIMIZE_READ,MEMOPTIMIZE_WRITE,MIN_EXTENTS,MONITORING,NESTED,NEXT_EXTENT,NUM_FREELIST_BLOCKS,
                     NUM_ROWS,OWNER,PARTITIONED,PCT_FREE,PCT_INCREASE,PCT_USED,READ_ONLY,RESULT_CACHE,ROW_MOVEMENT,SAMPLE_SIZE,
                     SECONDARY,SEGMENT_CREATED,SHARDED,SKIP_CORRUPT,STATUS,TABLESPACE_NAME,TABLE_LOCK,TABLE_NAME,TEMPORARY,USER_STATS)
                  SELECT ACTIVITY_TRACKING,ADMIT_NULL,AVG_ROW_LEN,AVG_SPACE,AVG_SPACE_FREELIST_BLOCKS,BACKED_UP,BLOCKS,
                     BUFFER_POOL,CACHE,CELLMEMORY,CELL_FLASH_CACHE,CHAIN_CNT,CLUSTERING,CLUSTER_NAME,CLUSTER_OWNER,
                     COMPRESSION,COMPRESS_FOR,CONTAINERS_DEFAULT,CONTAINER_DATA,CONTAINER_MAP,CONTAINER_MAP_OBJECT,
                     DATA_LINK_DML_ENABLED,DEFAULT_COLLATION,DEGREE,DEPENDENCIES,DML_TIMESTAMP,DROPPED,DUPLICATED,
                     DURATION,EMPTY_BLOCKS,EXTENDED_DATA_LINK,EXTENDED_DATA_LINK_MAP,EXTERNAL,FLASH_CACHE,FREELISTS,
                     FREELIST_GROUPS,GLOBAL_STATS,HAS_IDENTITY,HAS_SENSITIVE_COLUMN,HYBRID,INITIAL_EXTENT,INI_TRANS,
                     INMEMORY,INMEMORY_COMPRESSION,INMEMORY_DISTRIBUTE,INMEMORY_DUPLICATE,INMEMORY_PRIORITY,INMEMORY_SERVICE,
                     INMEMORY_SERVICE_NAME,INSTANCES,IOT_NAME,IOT_TYPE,LAST_ANALYZED,LOGGING,LOGICAL_REPLICATION,MAX_EXTENTS,
                     MAX_TRANS,MEMOPTIMIZE_READ,MEMOPTIMIZE_WRITE,MIN_EXTENTS,MONITORING,NESTED,NEXT_EXTENT,NUM_FREELIST_BLOCKS,
                     NUM_ROWS,OWNER,PARTITIONED,PCT_FREE,PCT_INCREASE,PCT_USED,READ_ONLY,RESULT_CACHE,ROW_MOVEMENT,SAMPLE_SIZE,
                     SECONDARY,SEGMENT_CREATED,SHARDED,SKIP_CORRUPT,STATUS,TABLESPACE_NAME,TABLE_LOCK,TABLE_NAME,TEMPORARY,USER_STATS
                    FROM ALL_TABLES
                   WHERE OWNER = :OWNER AND TABLE_NAME = :TAB';
      EXECUTE IMMEDIATE SQL_STR USING OWNER,TAB||'_ARCHIVE';
      COMMIT;
    END IF;
  END;



  --判断归档表配置是否符合要求
  FUNCTION F_JUDGE_TABCONFIG_INFO(OWNER     IN VARCHAR2,
                                  TAB_NAME  IN VARCHAR2,
                                  TAB_COND  IN VARCHAR2) RETURN VARCHAR2 IS
    TMP_SQL  VARCHAR2(4000);
    COND_COL VARCHAR2(32);
    T_NUM    NUMBER(4);
    RET_STR  VARCHAR2(4);
  BEGIN
    IF REGEXP_INSTR(TRIM(UPPER(TAB_COND)),'^RELA_ARCHIVE$') > 0 THEN
      RET_STR := 'PS';
    ELSE
      COND_COL := SUBSTR(TAB_COND,
                         REGEXP_INSTR(TAB_COND,'\w'),
                         REGEXP_INSTR(TAB_COND,'\s',REGEXP_INSTR(TAB_COND,'\w'),1)-1);
      TMP_SQL  := 'SELECT SIGN(COUNT(1)) FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP WHERE OWNER = '''||
                     OWNER||''' AND TABLE_NAME='''||TAB_NAME||''' AND COLUMN_NAME = '''||
                     COND_COL||'''';
      EXECUTE IMMEDIATE TMP_SQL INTO T_NUM;
      IF T_NUM=0 THEN
        --无此列
        RET_STR := 'CER';
      ELSIF T_NUM=1 THEN
        --通过
        RET_STR := 'PS';
      END IF;
    END IF;
    RETURN RET_STR;
  END F_JUDGE_TABCONFIG_INFO;



  --获取主键
  FUNCTION F_GET_PK(OATABLE   IN VARCHAR2) RETURN VARCHAR2 IS
    V_OWNER  VARCHAR2(32);
    V_TABLE  VARCHAR2(32);
    EXE_SQL  CLOB;
    RET_STR  VARCHAR2(32);
  BEGIN
    V_OWNER := SUBSTR(OATABLE,1,INSTR(OATABLE,'.')-1);
    V_TABLE := REPLACE(OATABLE,V_OWNER||'.','');
    EXE_SQL := 'SELECT B.COLUMN_NAME
                  FROM (SELECT CONSTRAINT_NAME
                          FROM SCMDATA.ALL_CONSTRAINTS_BACKUP
                         WHERE OWNER = '''||V_OWNER||'''
                           AND TABLE_NAME = '''||V_TABLE||'''
                           AND CONSTRAINT_TYPE = ''P'') A
                 INNER JOIN (SELECT COLUMN_NAME, CONSTRAINT_NAME
                               FROM SCMDATA.ALL_CONS_COLUMNS_BACKUP
                              WHERE OWNER = '''||V_OWNER||'''
                                AND TABLE_NAME = '''||V_TABLE||''') B
                         ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME';
    EXECUTE IMMEDIATE EXE_SQL INTO RET_STR;
    RETURN RET_STR;
  END F_GET_PK;



  --获取格式化字符串（带游标前缀,不可作为其他地方通用）
  FUNCTION F_GET_FORMATED_FIELDS(OWNER     IN VARCHAR2,
                                 TAB_NAME  IN VARCHAR2,
                                 COLS      IN VARCHAR2,
                                 CUR_PRF   IN VARCHAR2)  RETURN CLOB IS
    FMT_RESULT CLOB;
    JUDGE_STR  VARCHAR2(16);
    TMP_COLS   VARCHAR2(1024);
    TMP_COL    VARCHAR2(64);
    FMT_VAL    CLOB;
    FMT_COL    CLOB;
    ERR_INFO   VARCHAR2(512);
  BEGIN
    TMP_COLS := UPPER(COLS)||',';
    WHILE LENGTH(TMP_COLS) > 0 LOOP
      --获取单列名称
      TMP_COL := SUBSTR(TMP_COLS,1,INSTR(TMP_COLS, ',')-1);
      --删除单列名
      TMP_COLS := SUBSTR(TMP_COLS,INSTR(TMP_COLS, ',')+1,LENGTH(TMP_COLS));
      BEGIN
        --查出数据类型
        SELECT DATA_TYPE
          INTO JUDGE_STR
          FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
         WHERE OWNER = OWNER
           AND TABLE_NAME = TAB_NAME
           AND COLUMN_NAME = TMP_COL;
        EXCEPTION WHEN OTHERS THEN
          ERR_INFO := 'ERR_MESSAGE: '||SQLERRM||CHR(10)||
                      'ERR_MENTION: WRONG TABLE COLUMN'||CHR(10)||
                      'ERR_COL: '||TMP_COL||CHR(10)||
                      'ERR_COLS: '||TMP_COLS||CHR(10)||
                      'TABLE_NAME: '||OWNER||'.'||TAB_NAME;
          RAISE_APPLICATION_ERROR(-20002,ERR_INFO);
      END;
      --组成返回字段
      IF JUDGE_STR = 'VARCHAR2' THEN
        FMT_VAL := FMT_VAL||','||'''''''||'||CUR_PRF||TMP_COL||'||''''''';
        FMT_COL := FMT_COL||','||TMP_COL;
      ELSIF JUDGE_STR = 'DATE' AND REGEXP_COUNT(TMP_COL||',','DATE,') > 0 THEN
        FMT_VAL := FMT_VAL||',TRUNC(TO_DATE(''''''||'||CUR_PRF||TMP_COL||'||'''''',''''yyyy-MM-dd''''))';
        FMT_COL := FMT_COL||',TO_CHAR(TRUNC('||TMP_COL||'),''yyyy-MM-dd'') '||TMP_COL;
      ELSIF JUDGE_STR = 'DATE' AND REGEXP_COUNT(TMP_COL||',','DATE,') = 0 THEN
        FMT_VAL := FMT_VAL||',TO_DATE(''''''||'||CUR_PRF||TMP_COL||'||'''''',''''yyyy-MM-dd HH24-mi-ss'''')';
        FMT_COL := FMT_COL||',TO_CHAR('||TMP_COL||',''yyyy-MM-dd HH24-mi-ss'') '||TMP_COL;
      ELSIF JUDGE_STR = 'NUMBER' OR JUDGE_STR = 'INTEGER' THEN
        FMT_VAL := FMT_VAL||','||'''||'||CUR_PRF||TMP_COL||'||''';
        FMT_COL := FMT_COL||','||TMP_COL;
      END IF;
    END LOOP;
    FMT_RESULT := LTRIM(FMT_VAL,',')||'^^^^^^'||LTRIM(FMT_COL,',');
    RETURN FMT_RESULT;
  END F_GET_FORMATED_FIELDS;



  --生成未归档主键列值
  FUNCTION F_GENERATE_FOLLOW_ARCHIVE_COND_AND_UNQVALS(EXE_TIME    IN VARCHAR2,
                                                      MAS_TAB     IN VARCHAR2,
                                                      SLA_TAB     IN VARCHAR2,
                                                      COND_STR    IN VARCHAR2,
                                                      SLA_PK      IN VARCHAR2,
                                                      ALARC_VALS  IN VARCHAR2) RETURN CLOB IS
    VALS         CLOB;
    TMP_VAL      VARCHAR2(64);
    UNQ_VALS     CLOB;
    EXE_SQL      CLOB;
    MAS_FIELD    VARCHAR2(64);
    SLA_FIELD    VARCHAR2(64);
  BEGIN
    --解析被关联表条件字段，关联表条件字段
    MAS_FIELD := SUBSTR(COND_STR,1,REGEXP_INSTR(COND_STR,'\s|\=')-1);
    SLA_FIELD := SUBSTR(COND_STR,REGEXP_INSTR(COND_STR,'\:')+1,LENGTH(COND_STR));
    --构建执行SQL
    EXE_SQL := 'SELECT LISTAGG('||SLA_PK||','','') || '','' FROM '||SLA_TAB||' WHERE '||SLA_FIELD||
                 ' IN (SELECT '||MAS_FIELD||' FROM '||MAS_TAB||'_ARCHIVE WHERE ARC_TIME='||EXE_TIME||')';
    --赋值
    EXECUTE IMMEDIATE EXE_SQL INTO VALS;
    --获取未归档主键列值
    FOR I IN 1..REGEXP_COUNT(VALS,',') LOOP
      TMP_VAL := SUBSTR(VALS,1,INSTR(VALS,',')-1);
      VALS := REPLACE(VALS,TMP_VAL||',','');
      IF REGEXP_COUNT(ALARC_VALS||',',TMP_VAL||',')=0 THEN
        UNQ_VALS := UNQ_VALS||','||TMP_VAL;
      END IF;
    END LOOP;
    RETURN LTRIM(UNQ_VALS,',');
  END F_GENERATE_FOLLOW_ARCHIVE_COND_AND_UNQVALS;



  --单表删除逻辑
  PROCEDURE P_DELETE_RELA_DATA(TAB_OWNER    IN  VARCHAR2,
                               TAB_NAME     IN  VARCHAR2,
                               COND_STR     IN  VARCHAR2,
                               COLS         IN  VARCHAR2,
                               FMT_COL      IN  VARCHAR2,
                               CF_ID        IN  VARCHAR2,
                               RUNTIME      IN  DATE) IS
    OATABLE       VARCHAR2(64):=TAB_OWNER||'.'||TAB_NAME;
    LG_ID         VARCHAR2(32);
    PK_COL        VARCHAR2(32);
    PKV_POS       NUMBER(8);
    PK_VALS       CLOB;
    ERR_SQL       CLOB;
    TMP_PKV       VARCHAR2(128);
    RUNTIME_V     VARCHAR2(32):=TO_CHAR(RUNTIME,'yyyy-MM-dd HH24-mi-ss');
    EXE_SQL       CLOB;
    VALS          CLOB;
    DECLARE_SQL   CLOB;
    ARC_COLS      CLOB;
    ARC_FMT_STR   CLOB;
    ARC_COMB_VALS CLOB;
    ARC_FMT_COLS  CLOB;
    PLUS_COND     CLOB;
  BEGIN
    --获取当前表数据 LOG表 ID
    SELECT LOG_ID
      INTO LG_ID
      FROM SCMDATA.T_ARCHIVE_LOG
     WHERE CONFIG_ID = CF_ID
       AND TAB_NAME  = OATABLE
       AND EXE_TIME  = RUNTIME;
    --删除源表通过校验数据
    --获取主键
    PK_COL := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_PK(OATABLE);
    --获取源表与归档表相同数据主键值
    EXE_SQL := 'SELECT LISTAGG('||PK_COL||','','') FROM (SELECT '||FMT_COL||' FROM '||OATABLE||
                 ' WHERE '||COND_STR||' INTERSECT SELECT '||FMT_COL|| ' FROM '||OATABLE||
                 '_ARCHIVE WHERE '||COND_STR||' AND ARC_TIME = :RUNTIME)';
    EXECUTE IMMEDIATE EXE_SQL INTO PK_VALS USING RUNTIME;
    EXE_SQL := 'SELECT LISTAGG(COLUMN_NAME,'','') FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
                          WHERE OWNER = '''||TAB_OWNER||''' AND TABLE_NAME = '''||TAB_NAME||'_ARCHIVE''';
    EXECUTE IMMEDIATE EXE_SQL INTO ARC_COLS;
    ARC_FMT_STR := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_FORMATED_FIELDS(OWNER    => TAB_OWNER,
                                                                    TAB_NAME => TAB_NAME||'_ARCHIVE',
                                                                    COLS     => ARC_COLS,
                                                                    CUR_PRF  => 'DR.');
    ARC_COMB_VALS := SUBSTR(ARC_FMT_STR,1,INSTR(ARC_FMT_STR,'^^^^^^')-1);
    ARC_FMT_COLS  := REPLACE(ARC_FMT_STR,ARC_COMB_VALS||'^^^^^^','');
    ARC_COMB_VALS := REPLACE(REPLACE(REPLACE(ARC_COMB_VALS,q'[''']',q'[''''']'),q'['yyyy-MM-dd']',q'['''yyyy-MM-dd''']'),q'['yyyy-MM-dd HH24-mi-ss']',q'['''yyyy-MM-dd HH24-mi-ss''']');
    IF PK_VALS IS NOT NULL THEN
      BEGIN
        --利用 SCMDATA.PKG_ARCHIVE_COMMON.DELETE_STAGE_JUDGE 字段使某个表删除失败之后的所有表数据全部归入 ERR_SINGLE_DATA
        IF /*SCMDATA.PKG_VARIABLE.F_GET_VAL(INS_NAME => 'DELETE_STAGE_JUDGE')*/'PS' <> 'PS' THEN
          RAISE_APPLICATION_ERROR(-20002,'本配置归档表中存在某表删除错误，导致后面所有表不能归档！');
        END IF;
        --依据主键值删除源表数据
        EXE_SQL := 'DELETE FROM '||OATABLE||' WHERE '||PK_COL||' IN ('||''''||
                      REPLACE(PK_VALS,',',''',''')||''')';
        EXECUTE IMMEDIATE EXE_SQL;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          /*SCMDATA.PKG_VARIABLE.P_SET_VAL(INS_NAME => 'DELETE_STAGE_JUDGE', INS_VAL => 'ER');*/
          DECLARE_SQL := 'DECLARE
            EXE_SQL CLOB;
            RNUM    NUMBER(8);
          BEGIN
            FOR DR IN (SELECT '||ARC_FMT_COLS||' FROM '||OATABLE||'_ARCHIVE WHERE REGEXP_COUNT('''||PK_VALS||''','||PK_COL||') > 0 ) LOOP
              EXE_SQL := ''INSERT INTO SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
                          (SD_ID,CONFIG_ID,LOG_ID,STATUS,TAB_NAME,EXE_TIME,ERR_SQL,ERR_INFO,
                           CREATE_TIME)
                        VALUES
                          (SCMDATA.F_GET_UUID(), '''''||CF_ID||''''', '''''||LG_ID||''''', ''''ER'''','''''||OATABLE||''''',
                           TO_DATE('''''||RUNTIME_V||''''',''''yyyy-MM-dd HH24-mi-ss''''), ''''INSERT INTO '||
                           OATABLE||'_ARCHIVE ('||ARC_COLS||') VALUES ('||ARC_COMB_VALS||')'''',
                           ''''删除阶段错误: 本配置归档表中存在某表删除错误，导致后面所有表不能归档！'''', SYSDATE)'';
              EXECUTE IMMEDIATE EXE_SQL;
              EXE_SQL := ''DELETE FROM '||OATABLE||'_ARCHIVE WHERE ARC_TIME = TO_DATE('''''||RUNTIME_V||''''',''''yyyy-MM-dd HH24-mi-ss'''')
                          AND '||PK_COL||' = :PK'';
              EXECUTE IMMEDIATE EXE_SQL USING DR.'||PK_COL||';
            END LOOP;
            EXE_SQL := ''SELECT COUNT(1) FROM SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA WHERE EXE_TIME=TO_DATE('''''||RUNTIME_V||
                          ''''',''''yyyy-MM-dd HH24-mi-ss'''') AND TAB_NAME = '''''||OATABLE||''''''';
            EXECUTE IMMEDIATE EXE_SQL INTO RNUM;
            EXE_SQL := ''UPDATE SCMDATA.T_ARCHIVE_LOG SET ACC_ROWS = 0, ERR_ROWS = :RNUM
                          WHERE LOG_ID = '''''||LG_ID||''''' AND TAB_NAME = '''''||OATABLE||''''''';
            EXECUTE IMMEDIATE EXE_SQL USING RNUM;
          END;';
          EXECUTE IMMEDIATE DECLARE_SQL;
          COMMIT;
          PLUS_COND := ' AND REGEXP_COUNT('''||PK_VALS||''','||PK_COL||') = 0';
      END;
    END IF;
    --删除 ARCHIVE 表未通过校验数据，
    --获取表与归档表不同数据主键值
    EXE_SQL := 'SELECT LISTAGG('||PK_COL||','','') FROM (SELECT '||FMT_COL||' FROM '||OATABLE||
                 ' WHERE '||COND_STR||PLUS_COND||' MINUS SELECT '||FMT_COL|| ' FROM '||OATABLE||
                 '_ARCHIVE WHERE '||COND_STR||' AND ARC_TIME = :RUNTIME)';
    EXECUTE IMMEDIATE EXE_SQL INTO PK_VALS USING RUNTIME;
    --主键值展开
    IF PK_VALS IS NOT NULL THEN
      PK_VALS := PK_VALS || ',';
      FOR I IN 1..REGEXP_COUNT(PK_VALS,',') LOOP
        PKV_POS := INSTR(PK_VALS,',');
        TMP_PKV := SUBSTR(PK_VALS,1,PKV_POS-1);
        PK_VALS := SUBSTR(PK_VALS,PKV_POS+1,LENGTH(PK_VALS));
        --通过主键值查出数据
        EXE_SQL := 'SELECT '||REPLACE(FMT_COL,',','||'',''||')||' FROM '||OATABLE||'_ARCHIVE WHERE '||PK_COL||
                     ' = '''||TMP_PKV||''' AND ARC_TIME=:RT';
        EXECUTE IMMEDIATE EXE_SQL INTO VALS USING RUNTIME;
        --组成 ERR_SQL
        ERR_SQL := 'INSERT INTO '||OATABLE||'_ARCHIVE ('||COLS||') VALUES ('||VALS||')';
        --插入到 T_ARCHIVE_ERR_SINGLE_DATA
        EXECUTE IMMEDIATE 'INSERT INTO SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
                     (SD_ID,CONFIG_ID,LOG_ID,TAB_NAME,STATUS,EXE_TIME,ERR_INFO,ERR_SQL,CREATE_TIME)
                    VALUES
                     (SCMDATA.F_GET_UUID(),:LGID,:CFID,OATABLE,''ER'',:RT,''CHECK_NOT_PASS'',
                      '''||ERR_SQL||''',:RT)' USING LG_ID,CF_ID,RUNTIME;
        --删除 ARCHIVE 表中相关列
        EXE_SQL := 'DELETE FROM '||OATABLE||'_ARCHIVE WHERE '||PK_COL||' = '''||TMP_PKV||'''';
        EXECUTE IMMEDIATE EXE_SQL;
        COMMIT;
      END LOOP;
    END IF;
  END P_DELETE_RELA_DATA;



  --批量删除逻辑
  PROCEDURE P_BATCH_DELETE(CF_ID    IN VARCHAR2,
                           RTIME    IN DATE) IS
    COLS       CLOB;
    FMT_COL    CLOB;
  BEGIN
    FOR I IN (SELECT * FROM SCMDATA.T_ARCHIVE_TABLE_CONFIG
               WHERE REGEXP_COUNT(TRIM(UPPER(TAB_CONDITIONS)),'^RELA_ARCHIVE$')=0
                 AND CONFIG_ID = CF_ID
               ORDER BY EXE_ORDERS DESC) LOOP
      --获取列
      SELECT LISTAGG(COLUMN_NAME,',')
        INTO COLS
        FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
       WHERE OWNER = I.TAB_OWNER
         AND TABLE_NAME = I.TAB_NAME;
      --获取格式化列及带游标前缀的列
      FMT_COL  := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_FORMATED_COL(OWNER    => I.TAB_OWNER,
                                                                TAB_NAME => I.TAB_NAME,
                                                                COLS     => COLS);
      /*--制造错误数据
      IF I.TAB_NAME = 'T_FACTORY_ASK' THEN
        SCMDATA.PKG_VARIABLE.P_SET_VAL(INS_NAME => 'DELETE_STAGE_JUDGE', INS_VAL => 'ER');
      END IF;*/
      --单表删除
      SCMDATA.PKG_ARCHIVE_COMMON.P_DELETE_RELA_DATA(TAB_OWNER => I.TAB_OWNER,
                                                    TAB_NAME  => I.TAB_NAME,
                                                    COND_STR  => REPLACE(I.TAB_CONDITIONS,'''''',''''),
                                                    COLS      => COLS,
                                                    FMT_COL   => FMT_COL,
                                                    CF_ID     => CF_ID,
                                                    RUNTIME   => RTIME);
    END LOOP;
  END P_BATCH_DELETE;



  --归档·总
  PROCEDURE P_BATCH_ARCHIVE(CF_ID    IN VARCHAR2,
                            ROOTITEM IN VARCHAR2,
                            CUSER    IN VARCHAR2) IS
    ETIME_D                DATE;
    ETIME_V                VARCHAR2(128);
    OATABLE                VARCHAR2(64);
    TAB_PKCOL              VARCHAR2(32);
    COLS                   CLOB;
    FMT_POS1               NUMBER(8);
    FMT_POS2               NUMBER(8);
    FMT_UNION              CLOB;
    FMT_COL                CLOB;
    FMT_CUR_VCOL           CLOB;
    ITEMS                  CLOB;
    UNIQUE_VALS            CLOB;
    ALREADY_ARCHIVE_VALS   CLOB:=' ';
    GET_DATA_COND          CLOB;
    JUG_ER                 NUMBER(8);
  BEGIN
    --执行时间
    ETIME_D := SYSDATE;
    ETIME_V := 'TO_DATE('''||TO_CHAR(ETIME_D,'yyyy-MM-dd HH24-mi-ss')||''',''yyyy-MM-dd HH24-mi-ss'')';
    --删除判断字段赋值
    /*SCMDATA.PKG_VARIABLE.P_SET_VAL(INS_NAME => 'DELETE_STAGE_JUDGE', INS_VAL => 'PS');*/
    --展开归档表配置项
    FOR X IN (SELECT *
                FROM SCMDATA.T_ARCHIVE_TABLE_CONFIG
               WHERE CONFIG_ID = CF_ID ORDER BY EXE_ORDERS) LOOP
      --创建归档表
      SCMDATA.PKG_ARCHIVE_COMMON.P_CREATE_ARCTAB(X.TAB_OWNER,X.TAB_NAME);
      --为OATABLE赋值
      OATABLE := X.TAB_OWNER||'.'||X.TAB_NAME;
      --获取主键列
      TAB_PKCOL := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_PK(OATABLE => OATABLE);
      --获取列
      SELECT LISTAGG(COLUMN_NAME,',')
        INTO COLS
        FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
       WHERE OWNER = X.TAB_OWNER
         AND TABLE_NAME = X.TAB_NAME;
      --获取格式化列及带游标前缀的列
      FMT_UNION := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_FORMATED_FIELDS(X.TAB_OWNER,X.TAB_NAME,COLS,'INFO.');
      FMT_POS1 := INSTR(FMT_UNION,'^^^^^^');
      FMT_POS2 := LENGTH(FMT_UNION);
      FMT_CUR_VCOL := SUBSTR(FMT_UNION,1,FMT_POS1-1);
      FMT_COL  := SUBSTR(FMT_UNION,FMT_POS1+6,FMT_POS2-FMT_POS1+5);
      --查找由 RELA_ARCHIVE 作为条件的单项
      IF REGEXP_INSTR(TRIM(UPPER(X.TAB_CONDITIONS)),'^RELA_ARCHIVE$') > 0 THEN
        --存在，关联归档
        --获取当前根节点下所有 ITEMS
        ITEMS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_ALLITEMS_BY_ROOTITEM(ROOTITEM);
        --由主从关系入手展开主表及关联条件
        FOR Y IN (SELECT DISTINCT MASTER_TAB,SLAVE_TAB,COND_STR
                    FROM (SELECT MASTER_ITEM,MASTER_TAB,SLAVE_ITEM,
                                 SUBSTR(SLAVE_STR, 1, INSTR(SLAVE_STR, '^^^^^^') - 1) SLAVE_TAB,
                                 SUBSTR(SLAVE_STR, INSTR(SLAVE_STR, '^^^^^^') + 6, LENGTH(SLAVE_STR)) COND_STR
                            FROM (SELECT A.ITEM_ID MASTER_ITEM,SCMDATA.PKG_ARCHIVE_COMMON.F_GET_MAJORTAB(B.SELECT_SQL) MASTER_TAB,
                                         A.RELATE_ID SLAVE_ITEM,SCMDATA.PKG_ARCHIVE_COMMON.F_GET_MAJORTAB_AND_WHERECLAUSE(C.SELECT_SQL) SLAVE_STR
                                    FROM NBW.SYS_ITEM_RELA A
                                    LEFT JOIN NBW.SYS_ITEM_LIST B ON A.ITEM_ID = B.ITEM_ID
                                    LEFT JOIN NBW.SYS_ITEM_LIST C ON A.RELATE_ID = C.ITEM_ID
                                   WHERE REGEXP_COUNT(','||ITEMS||',',','||A.ITEM_ID)>0)) WHERE SLAVE_TAB = OATABLE) LOOP
          --生成未归档主键列值
          UNIQUE_VALS := SCMDATA.PKG_ARCHIVE_COMMON.F_GENERATE_FOLLOW_ARCHIVE_COND_AND_UNQVALS(EXE_TIME   => ETIME_V,
                                                                                               MAS_TAB    => Y.MASTER_TAB,
                                                                                               SLA_TAB    => Y.SLAVE_TAB,
                                                                                               COND_STR   => Y.COND_STR,
                                                                                               SLA_PK     => TAB_PKCOL,
                                                                                               ALARC_VALS => ALREADY_ARCHIVE_VALS);
          --构建源表取数条件
          GET_DATA_COND := 'REGEXP_COUNT('''''||UNIQUE_VALS||''''','||TAB_PKCOL||') > 0';
          --执行归档逻辑
          SCMDATA.PKG_ARCHIVE_COMMON.P_SINGLE_TAB_ARCHIVE(OWNER        => X.TAB_OWNER,
                                                          TAB_NAME     => X.TAB_NAME,
                                                          TAB_COLS     => COLS,
                                                          COND_STR     => GET_DATA_COND,
                                                          FMT_COL      => FMT_COL,
                                                          FMT_CUR_VCOL => FMT_CUR_VCOL,
                                                          EXE_ORD      => X.EXE_ORDERS,
                                                          EXE_TIME     => ETIME_V,
                                                          CF_ID        => CF_ID,
                                                          CURR_USER    => CUSER);
          --执行归档原表删除逻辑
          SCMDATA.PKG_ARCHIVE_COMMON.P_DELETE_RELA_DATA(TAB_OWNER  => X.TAB_OWNER,
                                                        TAB_NAME   => X.TAB_NAME,
                                                        COND_STR   => REPLACE(GET_DATA_COND,'''''',''''),
                                                        COLS       => COLS,
                                                        FMT_COL    => FMT_COL,
                                                        CF_ID      => CF_ID,
                                                        RUNTIME    => ETIME_D);
          --已归档值列
          ALREADY_ARCHIVE_VALS := LTRIM(ALREADY_ARCHIVE_VALS,',')||','||UNIQUE_VALS;
        END LOOP;
      ELSE
        --不存在，单独归档
        --构建源表取数条件
        GET_DATA_COND := X.TAB_CONDITIONS;
        --执行归档逻辑
        SCMDATA.PKG_ARCHIVE_COMMON.P_SINGLE_TAB_ARCHIVE(OWNER        => X.TAB_OWNER,
                                                        TAB_NAME     => X.TAB_NAME,
                                                        TAB_COLS     => COLS,
                                                        COND_STR     => GET_DATA_COND,
                                                        FMT_COL      => FMT_COL,
                                                        FMT_CUR_VCOL => FMT_CUR_VCOL,
                                                        EXE_ORD      => X.EXE_ORDERS,
                                                        EXE_TIME     => ETIME_V,
                                                        CF_ID        => CF_ID,
                                                        CURR_USER    => CUSER);
      END IF;
    END LOOP;
    --执行批量删除逻辑
    SCMDATA.PKG_ARCHIVE_COMMON.P_BATCH_DELETE(CF_ID => CF_ID,
                                              RTIME => ETIME_D);
    --更新状态
    SELECT COUNT(1)
      INTO JUG_ER
      FROM SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
     WHERE CONFIG_ID = CF_ID;

    IF JUG_ER = 0 THEN
      UPDATE SCMDATA.T_ARCHIVE_CONFIG
         SET LAST_EXE_TIME = ETIME_D,
             STATUS = 'FI'
       WHERE CONFIG_ID = CF_ID;
    ELSE
      UPDATE SCMDATA.T_ARCHIVE_CONFIG
         SET LAST_EXE_TIME = ETIME_D,
             STATUS = 'ER'
       WHERE CONFIG_ID = CF_ID;
    END IF;
  END P_BATCH_ARCHIVE;



  --归档处理
  PROCEDURE P_SINGLE_TAB_ARCHIVE(OWNER        IN VARCHAR2,
                                 TAB_NAME     IN VARCHAR2,
                                 TAB_COLS     IN VARCHAR2,
                                 COND_STR     IN VARCHAR2,
                                 FMT_COL      IN VARCHAR2,
                                 FMT_CUR_VCOL IN VARCHAR2,
                                 EXE_ORD      IN NUMBER,
                                 EXE_TIME     IN VARCHAR2,
                                 CF_ID        IN VARCHAR2,
                                 CURR_USER    IN VARCHAR2) IS
    OATABLE       VARCHAR2(64):= OWNER||'.'||TAB_NAME;
    DECLARE_SQL   CLOB;
    CHECK_COLS    CLOB;
    LG_ID         VARCHAR2(32):= SCMDATA.F_GET_UUID();
  BEGIN
    CHECK_COLS :=SCMDATA.PKG_ARCHIVE_COMMON.F_GET_FORMATED_COL(OWNER    => OWNER,
                                                               TAB_NAME => TAB_NAME,
                                                               COLS     => TAB_COLS);
    DECLARE_SQL  := 'DECLARE
      STATUS     VARCHAR2(4);
      TOT_ROWS   NUMBER(8);
      ERR_ROWS   NUMBER(8);
      PK_COL     VARCHAR2(32);
      LG_ID      VARCHAR2(32);
      RUNTIME    DATE;
      ERR_INFO   CLOB;
      ERR_SQL    CLOB;
      EXE_SQL    CLOB;
    BEGIN
      LG_ID := '''||LG_ID||''';
      RUNTIME := '||EXE_TIME||';
      FOR INFO IN (SELECT '||FMT_COL||' FROM '||OATABLE||' WHERE '||REPLACE(COND_STR,'''''','''')||') LOOP
        BEGIN
          EXE_SQL := ''INSERT INTO '||OATABLE||'_ARCHIVE ('||TAB_COLS||',ARC_ID,ARC_CREATOR,ARC_TIME)
                        VALUES ('||FMT_CUR_VCOL||',SCMDATA.F_GET_UUID(),'''''||CURR_USER||''''',:RUNTIME)'';
          WHILE REGEXP_COUNT(EXE_SQL,'',,'') > 0 LOOP
            EXE_SQL := REPLACE(EXE_SQL,'',,'','',NULL,'');
          END LOOP;
          EXECUTE IMMEDIATE EXE_SQL USING RUNTIME;
          COMMIT;
          EXCEPTION
            WHEN OTHERS THEN
              ERR_INFO := SQLERRM;
              ERR_SQL  := EXE_SQL;
              INSERT INTO SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
                (SD_ID, CONFIG_ID, LOG_ID, STATUS, TAB_NAME, EXE_TIME, ERR_INFO,
                 ERR_SQL, CREATE_TIME)
              VALUES
                (SCMDATA.F_GET_UUID(), '''||CF_ID||''', LG_ID, ''ER'','''||OATABLE||''', RUNTIME,
                 ERR_INFO, EXE_SQL, SYSDATE);
        END;
      END LOOP;
      EXE_SQL := ''SELECT COUNT(1) FROM '||OATABLE||' WHERE '||COND_STR||''';
      EXECUTE IMMEDIATE EXE_SQL INTO TOT_ROWS;
      EXE_SQL := ''SELECT COUNT(1) FROM (SELECT '||CHECK_COLS||' FROM '||OATABLE||
               ' WHERE '||COND_STR||' MINUS SELECT '||CHECK_COLS|| ' FROM '||OATABLE||
               '_ARCHIVE WHERE '||COND_STR||' AND ARC_TIME = :RUNTIME)'';
      EXECUTE IMMEDIATE EXE_SQL INTO ERR_ROWS USING RUNTIME;
      INSERT INTO SCMDATA.T_ARCHIVE_LOG
        (LOG_ID,CONFIG_ID,TAB_NAME,TAB_CONDITIONS,EXE_ORDERS,EXE_TIME,TOT_ROWS,ACC_ROWS,ERR_ROWS)
      VALUES
        (LG_ID,'''||CF_ID||''','''||OATABLE||''','''||COND_STR||''','||EXE_ORD||',RUNTIME,
        TOT_ROWS,TOT_ROWS-ERR_ROWS,ERR_ROWS);
      COMMIT;
    END;';
    EXECUTE IMMEDIATE DECLARE_SQL;
  END P_SINGLE_TAB_ARCHIVE;




  --获取格式化字符串（带游标前缀,不可作为其他地方通用）
  FUNCTION F_GET_FORMATED_COL(OWNER     IN VARCHAR2,
                              TAB_NAME  IN VARCHAR2,
                              COLS      IN VARCHAR2)  RETURN CLOB IS
    FMT_RESULT CLOB;
    JUDGE_STR  VARCHAR2(16);
    TMP_COLS   CLOB;
    TMP_COL    VARCHAR2(64);
    FMT_COL    CLOB;
    ERR_INFO   VARCHAR2(512);
  BEGIN
    TMP_COLS := UPPER(COLS)||',';
    WHILE LENGTH(TMP_COLS) > 0 LOOP
      --获取单列名称
      TMP_COL := SUBSTR(TMP_COLS,1,INSTR(TMP_COLS, ',')-1);
      --删除单列名
      TMP_COLS := SUBSTR(TMP_COLS,INSTR(TMP_COLS, ',')+1,LENGTH(TMP_COLS));
      BEGIN
        --查出数据类型
        SELECT DATA_TYPE
          INTO JUDGE_STR
          FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
         WHERE OWNER = OWNER
           AND TABLE_NAME = TAB_NAME
           AND COLUMN_NAME = TMP_COL;
        EXCEPTION WHEN OTHERS THEN
          ERR_INFO := 'ERR_MESSAGE: '||SQLERRM||CHR(10)||
                      'ERR_MENTION: WRONG TABLE COLUMN'||CHR(10)||
                      'ERR_COL: '||TMP_COL||CHR(10)||
                      'ERR_COLS: '||TMP_COLS||CHR(10)||
                      'TABLE_NAME: '||OWNER||'.'||TAB_NAME;
          RAISE_APPLICATION_ERROR(-20002,ERR_INFO);
      END;
      --组成返回字段
      IF JUDGE_STR = 'VARCHAR2' THEN
        FMT_COL := FMT_COL||','||TMP_COL;
      ELSIF JUDGE_STR = 'DATE' AND REGEXP_COUNT(TMP_COL||',','DATE,') > 0 THEN
        FMT_COL := FMT_COL||',TRUNC('||TMP_COL||')';
      ELSIF JUDGE_STR = 'DATE' AND REGEXP_COUNT(TMP_COL||',','DATE,') = 0 THEN
        FMT_COL := FMT_COL||','||TMP_COL;
      ELSIF JUDGE_STR = 'NUMBER' OR JUDGE_STR = 'INTEGER' THEN
        FMT_COL := FMT_COL||','||TMP_COL;
      END IF;
    END LOOP;
    FMT_RESULT := LTRIM(FMT_COL,',');
    RETURN FMT_RESULT;
  END F_GET_FORMATED_COL;




  --仅用于用户 SCMDATA 获取 SELECT_SQL 中主表
  FUNCTION F_GET_MAJORTAB(INS_SQL  IN VARCHAR2) RETURN VARCHAR2 IS
    TMP_SQL  VARCHAR2(4000);
    TMP_STR  VARCHAR2(2048);
    COUNTER  NUMBER(8);
    POS1     NUMBER(8);
    POS2     NUMBER(8);
    JUG_CNT  NUMBER(8);
    TAR_POS1 NUMBER(8);
    TAR_POS2 NUMBER(8);
    TAR_TAB  VARCHAR2(64);
  BEGIN
    TMP_SQL := REGEXP_REPLACE(UPPER(INS_SQL),'\s{1,}',' ');
    WHILE INSTR(TMP_SQL,'(SELECT') > 0 LOOP
      POS1 := INSTR(TMP_SQL,'(SELECT');
      POS2 := INSTR(TMP_SQL,'FROM',POS1,1)+4;
      TMP_STR := SUBSTR(TMP_SQL,POS1,POS2-POS1);
      JUG_CNT := REGEXP_COUNT(TMP_STR,'\(SELECT');
      COUNTER := 2;
      WHILE JUG_CNT > 1 LOOP
        POS1 := INSTR(TMP_SQL,'(SELECT',1,COUNTER);
        POS2 := INSTR(TMP_SQL,'FROM',POS1,1)+4;
        TMP_STR := SUBSTR(TMP_SQL,POS1,POS2-POS1);
        JUG_CNT := REGEXP_COUNT(TMP_STR,'\(SELECT');
        COUNTER := COUNTER + 1;
      END LOOP;
      TMP_SQL := REPLACE(TMP_SQL,TMP_STR,'');
    END LOOP;
    TMP_SQL  := SUBSTR(TMP_SQL,INSTR(TMP_SQL,'FROM'),LENGTH(TMP_SQL))||' ';
    TAR_POS1 := INSTR(TMP_SQL,'FROM')+5;
    TAR_POS1 := REGEXP_INSTR(TMP_SQL,'\w',TAR_POS1,1);
    TAR_POS2 := REGEXP_INSTR(TMP_SQL,'\s',TAR_POS1,1);
    TAR_TAB := SUBSTR(TMP_SQL,TAR_POS1,TAR_POS2-TAR_POS1);
    IF INSTR(TAR_TAB,'SCMDATA.') = 0 THEN
      TAR_TAB := 'SCMDATA.'||TAR_TAB;
    END IF;
    RETURN TAR_TAB;
  END F_GET_MAJORTAB;



  --仅用于用户 SCMDATA 获取 SELECT_SQL 中主表及关联条件
  FUNCTION F_GET_MAJORTAB_AND_WHERECLAUSE(INS_SQL  IN VARCHAR2) RETURN VARCHAR2 IS
    TMP_SQL    VARCHAR2(4000);
    TMP_STR    VARCHAR2(4000);
    COUNTER    NUMBER(8);
    POS1       NUMBER(8);
    POS2       NUMBER(8);
    JUG_CNT    NUMBER(8);
    TAR_POS1   NUMBER(8);
    TAR_POS2   NUMBER(8);
    TMP_POS    NUMBER(8);
    TAR_TAB    VARCHAR2(32);
    TAR_WHERE  VARCHAR2(4000);
    TAR_STR    VARCHAR2(4000);
  BEGIN
    TMP_SQL := REGEXP_REPLACE(UPPER(INS_SQL),'\s{1,}',' ');
    WHILE INSTR(TMP_SQL,'(SELECT') > 0 LOOP
      POS1 := INSTR(TMP_SQL,'(SELECT');
      POS2 := INSTR(TMP_SQL,'FROM',POS1,1)+4;
      TMP_STR := SUBSTR(TMP_SQL,POS1,POS2-POS1);
      JUG_CNT := REGEXP_COUNT(TMP_STR,'\(SELECT');
      COUNTER := 2;
      WHILE JUG_CNT > 1 LOOP
        POS1 := INSTR(TMP_SQL,'(SELECT',1,COUNTER);
        POS2 := INSTR(TMP_SQL,'FROM',POS1,1)+4;
        TMP_STR := SUBSTR(TMP_SQL,POS1,POS2-POS1);
        JUG_CNT := REGEXP_COUNT(TMP_STR,'\(SELECT');
        COUNTER := COUNTER + 1;
      END LOOP;
      TMP_SQL := REPLACE(TMP_SQL,TMP_STR,'');
    END LOOP;
    TMP_SQL  := SUBSTR(TMP_SQL,INSTR(TMP_SQL,'FROM'),LENGTH(TMP_SQL))||' ';
    TAR_POS1 := INSTR(TMP_SQL,'FROM')+5;
    TAR_POS1 := REGEXP_INSTR(TMP_SQL,'\w',TAR_POS1,1);
    TAR_POS2 := REGEXP_INSTR(TMP_SQL,'\s',TAR_POS1,1);
    TAR_TAB := SUBSTR(TMP_SQL,TAR_POS1,TAR_POS2-TAR_POS1);
    IF INSTR(TAR_TAB,'SCMDATA.') = 0 THEN
      TAR_TAB := 'SCMDATA.'||TAR_TAB;
    END IF;
    --在 FROM 后查找:=字段，通过截取字段 WHERE 数量确定 TAR_POS1
    IF REGEXP_COUNT(TMP_SQL,'\:') > 0 THEN
      TMP_POS := REGEXP_INSTR(TMP_SQL,'\=\s{0,}\:',TAR_POS1,1);
      TMP_STR := SUBSTR(TMP_SQL,1,TMP_POS);
      JUG_CNT := REGEXP_COUNT(TMP_STR, 'WHERE');
      --WHERE 个数为 1，0，大于1 三种情况
      WHILE JUG_CNT > 0 LOOP
        IF JUG_CNT = 1 THEN
          TAR_POS1 := REGEXP_INSTR(TMP_SQL,'WHERE')+5;
          TAR_POS1 := REGEXP_INSTR(TMP_SQL,'\w',TAR_POS1,1);
          TAR_POS2 := REGEXP_INSTR(TMP_SQL,'\:');
          TAR_POS2 := REGEXP_INSTR(TMP_SQL,'\s|\)',TAR_POS2,1);
          TAR_WHERE := SUBSTR(TMP_SQL,TAR_POS1,TAR_POS2-TAR_POS1);
          EXIT;
        ELSIF JUG_CNT > 1 THEN
          --WHERE 个数大于 1 截取第一个 WHERE 后面部分
          TMP_POS := REGEXP_INSTR(TMP_SQL,'WHERE')+5;
          TMP_SQL := SUBSTR(TMP_SQL,TMP_POS,LENGTH(TMP_SQL));
          TMP_POS := REGEXP_INSTR(TMP_SQL,'\=\s{0,}\:',TAR_POS1,1);
          TMP_STR := SUBSTR(TMP_SQL,1,TMP_POS);
          JUG_CNT := REGEXP_COUNT(TMP_STR, 'WHERE');
          CONTINUE;
        ELSE
          --WHERE 个数为 0 直接截取冒号后面部分
          TMP_POS := REGEXP_INSTR(TMP_SQL,'\:',TMP_POS,1)+1;
          TMP_SQL := SUBSTR(TMP_SQL,TMP_POS,LENGTH(TMP_SQL));
          CONTINUE;
        END IF;
      END LOOP;
    END IF;
    TAR_STR := TAR_TAB || '^^^^^^' || TAR_WHERE;
    RETURN TAR_STR;
  END F_GET_MAJORTAB_AND_WHERECLAUSE;


  --仅对错误数据进行处理
  FUNCTION F_ARCHIVE_ERR_GET_COLNAME_BY_COLVAL_WITH_TYPE(EXE_SQL    IN VARCHAR2,
                                                         TAR_COL    IN VARCHAR2) RETURN VARCHAR2 IS
    TMP_SQL    VARCHAR2(4000):=EXE_SQL;
    TMP_STR    VARCHAR2(4000);
    POS_CNT    NUMBER(8);
    RET_STR    VARCHAR2(4000);
    STA_POS    NUMBER(8);
    END_POS    NUMBER(8);
  BEGIN
    TMP_STR := SUBSTR(TMP_SQL,1,INSTR(TMP_SQL,TAR_COL)-1);
    POS_CNT := REGEXP_COUNT(TMP_STR,'\,');
    TMP_STR := SUBSTR(TMP_SQL,INSTR(TMP_SQL,'VALUES'),LENGTH(TMP_SQL));
    TMP_STR := REPLACE(TMP_STR,',''yyyy','--''yyyy');
    IF POS_CNT = 0 THEN
      STA_POS := LENGTH('VALUES (')+1;
      END_POS := INSTR(TMP_STR,',');
    ELSE
      STA_POS := INSTR(TMP_STR,',',1,POS_CNT);
      END_POS := INSTR(TMP_STR,',',1,POS_CNT+1);
    END IF;
    RET_STR   := REPLACE(SUBSTR(TMP_STR,STA_POS+1,END_POS-STA_POS-1),'--',',');
    RETURN REPLACE(RET_STR,'''','');
  END F_ARCHIVE_ERR_GET_COLNAME_BY_COLVAL_WITH_TYPE;


  --单条数据错误校验
  FUNCTION F_ERR_CHECK(OATABLE    IN VARCHAR2,
                       FMT_COLS   IN VARCHAR2,
                       UNQ_COL    IN VARCHAR2,
                       UNQ_VAL    IN VARCHAR2) RETURN VARCHAR2 IS
    EXE_COND  VARCHAR2(1024);
    EXE_SQL   CLOB;
    JUG_NUM   NUMBER(4);
    RET_STR   VARCHAR2(4);
  BEGIN
    --构建条件，这里条件带 WHERE
    EXE_COND := ' WHERE '||UNQ_COL||' = '''||UNQ_VAL||'''';
    --构建执行SQL
    EXE_SQL := 'SELECT COUNT(1) FROM '||OATABLE||EXE_COND;
    EXECUTE IMMEDIATE EXE_SQL INTO JUG_NUM;
    IF JUG_NUM > 0 THEN
      EXE_SQL := 'SELECT COUNT(1) FROM ('||'SELECT '||FMT_COLS||' FROM '||OATABLE||EXE_COND||
                  ' MINUS '||'SELECT '||FMT_COLS||' FROM '||OATABLE||'_ARCHIVE'||EXE_COND||')';
      --执行EXE_SQL
      EXECUTE IMMEDIATE EXE_SQL INTO JUG_NUM;
      --判断
      IF JUG_NUM > 0 THEN
        --存在不同项
        RET_STR := 'ER';
      ELSE
        --不存在不同项
        RET_STR := 'PS';
      END IF;
    ELSE
      --原数据已归档
      RET_STR := 'APS';
    END IF;
    RETURN RET_STR;
  END F_ERR_CHECK;



  --单条数据归档
  PROCEDURE P_SINGLE_DATA_ARCHIVE(OAT    IN VARCHAR2,
                                  FMTC   IN VARCHAR2,
                                  UNQC   IN VARCHAR2,
                                  UNQV   IN VARCHAR2,
                                  ERSQ   IN CLOB,
                                  SDID   IN VARCHAR2) IS
    TMP_RET     VARCHAR2(4);
    ERR_INFOC   VARCHAR2(2048);
    EXE_SQL     CLOB;
  BEGIN
    --错误SQL执行
    EXE_SQL := ERSQ;
    DBMS_OUTPUT.PUT_LINE(EXE_SQL);
    EXECUTE IMMEDIATE ERSQ;
    COMMIT;
    --单条数据错误校验
    TMP_RET := SCMDATA.PKG_ARCHIVE_COMMON.F_ERR_CHECK(OATABLE  => OAT,
                                                      FMT_COLS => FMTC,
                                                      UNQ_COL  => UNQC,
                                                      UNQ_VAL  => UNQV);
    --判断
    IF TMP_RET = 'PS' THEN
      BEGIN
        --删除原表数据
        EXE_SQL := 'DELETE FROM '||OAT||' WHERE '||UNQC||' = '''||UNQV||'''';
        EXECUTE IMMEDIATE EXE_SQL;
        COMMIT;
        --更新 ARCHIVE_ERR_SINGLE_DATA 的 STATUS 字段
        SCMDATA.PKG_ARCHIVE_COMMON.P_UPDATE_ARCHIVE_ERR_SINGLE_DATA(SD_ID => SDID,
                                                                    COLS  => 'STATUS',
                                                                    FMT_VALS => '''MF''');
        EXCEPTION
          WHEN OTHERS THEN
            ERR_INFOC := 'ERR_MESSAGE :校验通过，删除原表数据时报错'||CHR(10)||
                         'OATABLE :'||OAT||CHR(10)||
                         'UNIQUE_COLUMN :'||UNQC||CHR(10)||
                         'UNIQUE_VALUE :' ||UNQV;
            UPDATE SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
               SET ERR_INFO = ERR_INFOC
             WHERE SD_ID    = SDID;
      END;
    ELSIF TMP_RET = 'ER' THEN
      BEGIN
        --删除归档表数据
        EXE_SQL := 'DELETE FROM '||OAT||'_ARCHIVE WHERE '||UNQC||' = '''||UNQV||'''';
        EXECUTE IMMEDIATE EXE_SQL;
        COMMIT;
        --更新 ARCHIVE_ERR_SINGLE_DATA 的 STATUS 字段
        SCMDATA.PKG_ARCHIVE_COMMON.P_UPDATE_ARCHIVE_ERR_SINGLE_DATA(SD_ID => SDID,
                                                                    COLS  => 'STATUS',
                                                                    FMT_VALS => '''ER''');
        EXCEPTION
          WHEN OTHERS THEN
            ERR_INFOC := 'ERR_MESSAGE :校验不通过，删除归档表数据时报错'||CHR(10)||
                         'OATABLE :'||OAT||'_ARCHIVE'||CHR(10)||
                         'UNIQUE_COLUMN :'||UNQC||CHR(10)||
                         'UNIQUE_VALUE :' ||UNQV;
            UPDATE SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
               SET ERR_INFO = ERR_INFOC
             WHERE SD_ID    = SDID;
      END;
    ELSIF TMP_RET = 'APS' THEN
      BEGIN
        --删除
        EXE_SQL := 'DELETE FROM '||OAT||'_ARCHIVE WHERE '||UNQC||' = '''||UNQV||'''';
        EXECUTE IMMEDIATE EXE_SQL;
        COMMIT;
        --更新 ARCHIVE_ERR_SINGLE_DATA 的 STATUS 字段
        SCMDATA.PKG_ARCHIVE_COMMON.P_UPDATE_ARCHIVE_ERR_SINGLE_DATA(SD_ID => SDID,
                                                                    COLS  => 'STATUS',
                                                                    FMT_VALS => '''MF''');
        EXCEPTION
          WHEN OTHERS THEN
            ERR_INFOC := 'ERR_MESSAGE :已归档数据，删除归档表数据时报错'||CHR(10)||
                         'OATABLE :'||OAT||'_ARCHIVE'||CHR(10)||
                         'UNIQUE_COLUMN :'||UNQC||CHR(10)||
                         'UNIQUE_VALUE :' ||UNQV;
            UPDATE SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
               SET ERR_INFO = ERR_INFOC
             WHERE SD_ID    = SDID;
      END;
    END IF;
  END P_SINGLE_DATA_ARCHIVE;


  --校验且完成校验后的逻辑
  PROCEDURE P_CHECK_AND_CHECKPROCESSING(OBJ_ID  IN VARCHAR2,
                                        RM      IN VARCHAR2) IS
    TYPE ESD_CURSOR IS REF CURSOR;
    ESD_CUR       ESD_CURSOR;
    ESD_ROW       SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA%ROWTYPE;
    EXE_SQL       VARCHAR2(2048);
    TMP_CFID      VARCHAR2(32);
    TMP_LGID      VARCHAR2(32);
    TMP_OWNER     VARCHAR2(32);
    TMP_TNAME     VARCHAR2(32);
    TMP_OATABLE   VARCHAR2(32);
    TMP_COLS      VARCHAR2(2048);
    TMP_FMT_COLS  VARCHAR2(2048);
    TMP_PK        VARCHAR2(32);
    TMP_PKV       VARCHAR2(32);
    TMP_CNT       NUMBER(8);
    TOTROWS_N     NUMBER(8);
    ERRROWS_N     NUMBER(8);
  BEGIN
    --赋值 TMP_CNT
    TMP_CNT := 1;
    --运行模式 : SI-SINGLE_DATA 单条数据 MU-MULTIPLE_DATA 多条数据
    IF RM = 'SI' THEN
      EXE_SQL := 'SELECT * FROM SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA WHERE SD_ID = :ID';
    ELSIF RM = 'MU' THEN
      EXE_SQL := 'SELECT * FROM SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA WHERE LOG_ID = :ID AND STATUS = ''ER'' ORDER BY TAB_NAME';
    END IF;
    --展开 EXE_SQL 内部数据
    OPEN ESD_CUR FOR EXE_SQL USING OBJ_ID;
    LOOP
      FETCH ESD_CUR INTO ESD_ROW;
      IF ESD_CUR%NOTFOUND = FALSE THEN
        IF RM = 'SI' THEN
          --为单条数据归档时，执行顺序校验
          SCMDATA.PKG_ARCHIVE_COMMON.P_CHECK_ARCHIVE_ORDERS(ESD_ID => ESD_ROW.SD_ID);
        END IF;
        --判断，不相等时，说明上一个表的逻辑已执行完成（兼容第一次进入）
        IF TMP_OATABLE <> ESD_ROW.TAB_NAME OR TMP_OATABLE IS NULL THEN
          --赋值 TMP_OATABLE, TMP_OWNER, TMP_TNAME
          TMP_OATABLE := ESD_ROW.TAB_NAME;
          TMP_OWNER   := SUBSTR(ESD_ROW.TAB_NAME,1,INSTR(ESD_ROW.TAB_NAME,'.')-1);
          TMP_TNAME   := SUBSTR(ESD_ROW.TAB_NAME,INSTR(ESD_ROW.TAB_NAME,'.')+1,LENGTH(ESD_ROW.TAB_NAME));
          --列赋值
          SELECT LISTAGG(COLUMN_NAME,',')
            INTO TMP_COLS
            FROM SCMDATA.ALL_TAB_COLUMNS_BACKUP
           WHERE OWNER = TMP_OWNER
             AND TABLE_NAME = TMP_TNAME;
          --列格式化
          TMP_FMT_COLS := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_FORMATED_COL(OWNER    => TMP_OWNER,
                                                                        TAB_NAME => TMP_TNAME,
                                                                        COLS     => TMP_COLS);
          --在每条数据运行最后，对 TMP_CFID,TMP_LGID 赋值
          TMP_CFID := ESD_ROW.CONFIG_ID;
          TMP_LGID := ESD_ROW.LOG_ID;
        END IF;
        --获取主键及主键值
        TMP_PK  := SCMDATA.PKG_ARCHIVE_COMMON.F_GET_PK(OATABLE => TMP_OATABLE);
        TMP_PKV := SCMDATA.PKG_ARCHIVE_COMMON.F_ARCHIVE_ERR_GET_COLNAME_BY_COLVAL_WITH_TYPE(EXE_SQL => ESD_ROW.ERR_SQL,
                                                                                            TAR_COL => TMP_PK);
        --单条数据归档
        SCMDATA.PKG_ARCHIVE_COMMON.P_SINGLE_DATA_ARCHIVE(OAT   => ESD_ROW.TAB_NAME,
                                                         FMTC  => TMP_FMT_COLS,
                                                         UNQC  => TMP_PK,
                                                         UNQV  => TMP_PKV,
                                                         ERSQ  => ESD_ROW.ERR_SQL,
                                                         SDID  => ESD_ROW.SD_ID);
      END IF;
      -- TMP_CNT 自增
      TMP_CNT := TMP_CNT + 1;
      EXIT WHEN ESD_CUR%NOTFOUND;
    END LOOP;
    CLOSE ESD_CUR;
    --获取 TOT_ROWS
    SELECT TOT_ROWS
      INTO TOTROWS_N
      FROM SCMDATA.T_ARCHIVE_LOG
     WHERE LOG_ID = TMP_LGID
       AND TAB_NAME = TMP_OATABLE;
    --获取 ERR_ROWS
    SELECT COUNT(1)
      INTO ERRROWS_N
      FROM SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
     WHERE LOG_ID = TMP_LGID
       AND STATUS = 'ER';
    --更新 ARCHIVE_ERR_LOG 中 ACC_ROW、ERR_ROW
    SCMDATA.PKG_ARCHIVE_COMMON.P_UPDATE_ARCHIVE_LOG(LOG_ID    => TMP_LGID,
                                                    COLS      => 'ACC_ROWS,ERR_ROWS',
                                                    FMT_VALS  => TOTROWS_N-ERRROWS_N||','||ERRROWS_N);
    --更新 CONFIG 表状态
    SCMDATA.PKG_ARCHIVE_COMMON.P_UPDATE_CONFIG_STATUS(CONFIG_ID  => ESD_ROW.CONFIG_ID);
  END P_CHECK_AND_CHECKPROCESSING;


  --更新 CONFIG 表状态
  PROCEDURE P_UPDATE_CONFIG_STATUS(CONFIG_ID  IN VARCHAR2) IS
    JUG_ERR     NUMBER(8);
    STATUS_STR  VARCHAR2(4);
    EXE_SQL     CLOB;
  BEGIN
    EXE_SQL := 'SELECT SUM(ERR_ROWS) FROM SCMDATA.T_ARCHIVE_LOG WHERE CONFIG_ID = :CFID';
    EXECUTE IMMEDIATE EXE_SQL INTO JUG_ERR USING CONFIG_ID;
    IF JUG_ERR = 0 THEN
      STATUS_STR := 'FI';
    ELSE
      STATUS_STR := 'ER';
    END IF;
    UPDATE SCMDATA.T_ARCHIVE_CONFIG
       SET STATUS = STATUS_STR
     WHERE CONFIG_ID = CONFIG_ID;
    COMMIT;
  END P_UPDATE_CONFIG_STATUS;


  --更新 ARCHIVE_LOG 表
  PROCEDURE P_UPDATE_ARCHIVE_LOG(LOG_ID    IN VARCHAR2,
                                 COLS      IN VARCHAR2,
                                 FMT_VALS  IN VARCHAR2) IS
    EXE_SQL  CLOB;
  BEGIN
    EXE_SQL := 'UPDATE SCMDATA.T_ARCHIVE_LOG
                   SET ('||COLS||')
                     = (SELECT '||FMT_VALS||' FROM DUAL)
                 WHERE LOG_ID = :ID';
    EXECUTE IMMEDIATE EXE_SQL USING LOG_ID;
    COMMIT;
  END P_UPDATE_ARCHIVE_LOG;


  --更新 ARCHIVE_ERR_SINGLE_DATA 表
  PROCEDURE P_UPDATE_ARCHIVE_ERR_SINGLE_DATA(SD_ID     IN VARCHAR2,
                                             COLS      IN VARCHAR2,
                                             FMT_VALS  IN VARCHAR2) IS
    EXE_SQL  CLOB;
  BEGIN
    EXE_SQL := 'UPDATE SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
                   SET ('||COLS||')
                     = (SELECT '||FMT_VALS||' FROM DUAL)
                 WHERE SD_ID = :ID';
    EXECUTE IMMEDIATE EXE_SQL USING SD_ID;
    COMMIT;
  END P_UPDATE_ARCHIVE_ERR_SINGLE_DATA;


  --执行顺序校验
  PROCEDURE P_CHECK_ARCHIVE_ORDERS(ESD_ID  IN VARCHAR2) IS
    CONFIGID_V  VARCHAR2(32);
    STATUS_V    VARCHAR2(4);
    EXETIME_D   DATE;
    JUDGE_N     NUMBER(4);
  BEGIN
    --赋值 CONFIG_ID, EXE_TIME, STATUS
    SELECT CONFIG_ID, EXE_TIME, STATUS
      INTO CONFIGID_V, EXETIME_D, STATUS_V
      FROM SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA
     WHERE SD_ID = ESD_ID;
    --判断
    IF STATUS_V = 'MF' THEN
      RAISE_APPLICATION_ERROR(-20002,'已归档数据不能二次归档');
    END IF;
    --逆序排名，将对应值存入 JUDGE_N
    SELECT RET
      INTO JUDGE_N
      FROM (SELECT DENSE_RANK() OVER(ORDER BY B.EXE_ORDERS DESC) RET, A.SD_ID
              FROM SCMDATA.T_ARCHIVE_ERR_SINGLE_DATA A
              LEFT JOIN SCMDATA.T_ARCHIVE_TABLE_CONFIG B
                ON A.CONFIG_ID = B.CONFIG_ID
               AND A.TAB_NAME = B.TAB_NAME
             WHERE A.CONFIG_ID = CONFIGID_V
               AND A.EXE_TIME = EXETIME_D
               AND A.STATUS = 'ER')
       WHERE SD_ID = ESD_ID;
    --判断
    IF JUDGE_N <> 1 THEN
      RAISE_APPLICATION_ERROR(-20002,'请按执行顺序逆序进行归档！');
    END IF;
  END P_CHECK_ARCHIVE_ORDERS;


END PKG_ARCHIVE_COMMON;
/

