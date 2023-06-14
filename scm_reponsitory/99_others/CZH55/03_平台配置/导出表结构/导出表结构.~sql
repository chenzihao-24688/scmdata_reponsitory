DECLARE
  --表结构
  v_clob1 CLOB;
  v_clob2 CLOB;
  --主外键
  v_clob3 CLOB;
  v_clob4 CLOB;
  --索引
  v_clob5 CLOB;
  v_clob6 CLOB;
  --触发器
  v_clob7 CLOB;
  v_clob8 CLOB;
BEGIN
  v_clob1 := q'[WITH TMP AS
 (SELECT '表名称' AS "表名称",
         '表说明' AS "表说明",
         '字段名称' AS "字段名称",
         '数据类型' AS "数据类型",
         9999 AS "长度",
         NULL AS "是否为空",
         '字段说明' AS "字段说明"
    FROM DUAL),
RL AS
 (SELECT T1.TABLE_NAME   AS "表名称",
         T3.COMMENTS     AS "表说明",
         T1.COLUMN_NAME  AS "字段名称",
         T1.DATA_TYPE    AS "数据类型",
         T1.DATA_LENGTH  AS "长度",
         T1.NULLABLE     AS "是否为空",
         T2.COMMENTS     AS "字段说明"
    FROM COLS T1
    LEFT JOIN USER_COL_COMMENTS T2
      ON T1.TABLE_NAME = T2.TABLE_NAME
     AND T1.COLUMN_NAME = T2.COLUMN_NAME
    LEFT JOIN USER_TAB_COMMENTS T3
      ON T1.TABLE_NAME = T3.TABLE_NAME
    LEFT JOIN USER_OBJECTS T4
      ON T1.TABLE_NAME = T4.OBJECT_NAME
   WHERE NOT EXISTS (SELECT T4.OBJECT_NAME
            FROM USER_OBJECTS T4
           WHERE T4.OBJECT_TYPE = 'TABLE'
             AND T4.TEMPORARY = 'Y'
             AND T4.OBJECT_NAME = T1.TABLE_NAME)
     ORDER BY t1.TABLE_NAME ASC,t1.COLUMN_ID ASC)]';

  v_clob3 := q'[WITH TMP1 AS
 (SELECT '拥有者' AS "拥有者",
         '表名' AS "表名",
         '约束类型' AS "约束类型",
         '列约束' AS "列约束",
         '外键拥有者' AS "外键拥有者",
         '参照表名' AS "参照表名",
         '参照列约束' AS "参照列约束"
    FROM dual),
RL1 AS
 (SELECT t.owner AS "拥有者",
         t.table_name AS "表名",
         decode(t.constraint_type, 'P', '主键', 'R', '外键') AS "约束类型",
         t.constraint_name AS "列约束",
         t.r_owner AS "外键拥有者",
         (SELECT uc.table_name
            FROM user_constraints uc
           WHERE uc.owner = t.r_owner
             AND uc.constraint_name = t.r_constraint_name) AS "参照表名",
         t.r_constraint_name AS "参照列约束"
    FROM user_constraints t
   WHERE t.constraint_type IN ('P', 'R'))]';

  v_clob5 := q'[WITH TMP2 AS
 (SELECT '拥有者' AS "拥有者",
         '表名' AS "表名",
         '索引名称' AS "索引名称",
         '索引类型' AS "索引类型",
         '索引唯一性' AS "索引唯一性",
         '索引列' AS "索引列"
    FROM dual),
RL2 AS
 (SELECT user_indexes.table_owner     AS "拥有者",
         user_ind_columns.table_name  AS "表名",
         user_ind_columns.index_name  AS "索引名称",
         user_indexes.index_type      AS "索引类型",
         user_indexes.uniqueness      AS "索引唯一性",
         user_ind_columns.column_name AS "索引列"
    FROM user_ind_columns, user_indexes
   WHERE user_ind_columns.index_name = user_indexes.index_name)]';

  v_clob7 := q'[WITH tmp3 AS
 (SELECT '表名' AS "表名", '触发器名' AS "触发器名" FROM dual),
rl3 AS
 (SELECT table_name AS "表名", trigger_name AS "触发器名" FROM all_triggers)]';

  FOR i IN (SELECT table_name
              FROM all_tables t
             WHERE t.owner = 'SCMDATA'
               AND T.TABLE_NAME IN ('T_ORDERED',
                                    'T_ORDERS',
                                    'T_PRODUCTION_PROGRESS',
                                    'T_ABNORMAL',
                                    'T_DELIVERY_RECORD','T_ORDERSITEM','T_DEDUCTION','T_DEDUCTION_PRINT','T_DELIVERY_RECORD_ITEM')
            /* (SELECT a.table_name
             FROM all_tables a
            WHERE a.owner = 'SCMDATA')*/
            ) LOOP
  
    v_clob2 := q'[SELECT * 
  FROM TMP]' || ' UNION ALL ' ||
               q'[SELECT * FROM rl WHERE rl.表名称 = ]' || '''' ||
               i.table_name || '''' || ' UNION ALL ' || v_clob2;
  
    v_clob4 := q'[SELECT * 
  FROM TMP1]' || ' UNION ALL ' ||
               q'[SELECT * FROM rl1 WHERE rl1.表名 = ]' || '''' ||
               i.table_name || '''' || ' UNION ALL ' || v_clob4;
  
    v_clob6 := q'[SELECT * 
  FROM TMP2]' || ' UNION ALL ' ||
               q'[SELECT * FROM rl2 WHERE rl2.表名 = ]' || '''' ||
               i.table_name || '''' || ' UNION ALL ' || v_clob6;
  
    v_clob8 := q'[SELECT * 
  FROM TMP3]' || ' UNION ALL ' ||
               q'[SELECT * FROM rl3 WHERE rl3.表名 = ]' || '''' ||
               i.table_name || '''' || ' UNION ALL ' || v_clob8;
  
  /*  dbms_output.put_line('----------基本表结构----------');             
          dbms_output.put_line(v_clob1 || substr(v_clob2,1,length(v_clob2)-length(' UNION ALL '))||';');
          dbms_output.put_line('----------约束类型----------'); 
          dbms_output.put_line(v_clob3 || substr(v_clob4,1,length(v_clob4)-length(' UNION ALL '))||';');
          dbms_output.put_line('----------索引类型----------'); 
          dbms_output.put_line(v_clob5 || substr(v_clob6,1,length(v_clob6)-length(' UNION ALL '))||';');
          dbms_output.put_line('----------触发器----------'); 
          dbms_output.put_line(v_clob7 || substr(v_clob8,1,length(v_clob6)-length(' UNION ALL '))||';');    
          
          v_clob2 := '';
          v_clob4 := '';
          v_clob6 := '';
          v_clob8 := '';*/
  
  END LOOP;
  dbms_output.put_line('----------基本表结构----------');
  dbms_output.put_line(v_clob1 ||
                       substr( v_clob2,
                              1,
                              length(v_clob2) - length(' UNION ALL ')) || ';');
  dbms_output.put_line('----------约束类型----------');
  dbms_output.put_line(v_clob3 ||
                       substr(v_clob4,
                              1,
                              length(v_clob4) - length(' UNION ALL ')) || ';');
  dbms_output.put_line('----------索引类型----------');
  dbms_output.put_line(v_clob5 ||
                       substr(v_clob6,
                              1,
                              length(v_clob6) - length(' UNION ALL ')) || ';');
  dbms_output.put_line('----------触发器----------');
  dbms_output.put_line(v_clob7 ||
                       substr(v_clob8,
                              1,
                              length(v_clob6) - length(' UNION ALL ')) || ';');

END;
