DECLARE
  --��ṹ
  v_clob1 CLOB;
  v_clob2 CLOB;
  --�����
  v_clob3 CLOB;
  v_clob4 CLOB;
  --����
  v_clob5 CLOB;
  v_clob6 CLOB;
  --������
  v_clob7 CLOB;
  v_clob8 CLOB;
BEGIN
  v_clob1 := q'[WITH TMP AS
 (SELECT '������' AS "������",
         '��˵��' AS "��˵��",
         '�ֶ�����' AS "�ֶ�����",
         '��������' AS "��������",
         9999 AS "����",
         NULL AS "�Ƿ�Ϊ��",
         '�ֶ�˵��' AS "�ֶ�˵��"
    FROM DUAL),
RL AS
 (SELECT T1.TABLE_NAME   AS "������",
         T3.COMMENTS     AS "��˵��",
         T1.COLUMN_NAME  AS "�ֶ�����",
         T1.DATA_TYPE    AS "��������",
         T1.DATA_LENGTH  AS "����",
         T1.NULLABLE     AS "�Ƿ�Ϊ��",
         T2.COMMENTS     AS "�ֶ�˵��"
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
 (SELECT 'ӵ����' AS "ӵ����",
         '����' AS "����",
         'Լ������' AS "Լ������",
         '��Լ��' AS "��Լ��",
         '���ӵ����' AS "���ӵ����",
         '���ձ���' AS "���ձ���",
         '������Լ��' AS "������Լ��"
    FROM dual),
RL1 AS
 (SELECT t.owner AS "ӵ����",
         t.table_name AS "����",
         decode(t.constraint_type, 'P', '����', 'R', '���') AS "Լ������",
         t.constraint_name AS "��Լ��",
         t.r_owner AS "���ӵ����",
         (SELECT uc.table_name
            FROM user_constraints uc
           WHERE uc.owner = t.r_owner
             AND uc.constraint_name = t.r_constraint_name) AS "���ձ���",
         t.r_constraint_name AS "������Լ��"
    FROM user_constraints t
   WHERE t.constraint_type IN ('P', 'R'))]';

  v_clob5 := q'[WITH TMP2 AS
 (SELECT 'ӵ����' AS "ӵ����",
         '����' AS "����",
         '��������' AS "��������",
         '��������' AS "��������",
         '����Ψһ��' AS "����Ψһ��",
         '������' AS "������"
    FROM dual),
RL2 AS
 (SELECT user_indexes.table_owner     AS "ӵ����",
         user_ind_columns.table_name  AS "����",
         user_ind_columns.index_name  AS "��������",
         user_indexes.index_type      AS "��������",
         user_indexes.uniqueness      AS "����Ψһ��",
         user_ind_columns.column_name AS "������"
    FROM user_ind_columns, user_indexes
   WHERE user_ind_columns.index_name = user_indexes.index_name)]';

  v_clob7 := q'[WITH tmp3 AS
 (SELECT '����' AS "����", '��������' AS "��������" FROM dual),
rl3 AS
 (SELECT table_name AS "����", trigger_name AS "��������" FROM all_triggers)]';

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
               q'[SELECT * FROM rl WHERE rl.������ = ]' || '''' ||
               i.table_name || '''' || ' UNION ALL ' || v_clob2;
  
    v_clob4 := q'[SELECT * 
  FROM TMP1]' || ' UNION ALL ' ||
               q'[SELECT * FROM rl1 WHERE rl1.���� = ]' || '''' ||
               i.table_name || '''' || ' UNION ALL ' || v_clob4;
  
    v_clob6 := q'[SELECT * 
  FROM TMP2]' || ' UNION ALL ' ||
               q'[SELECT * FROM rl2 WHERE rl2.���� = ]' || '''' ||
               i.table_name || '''' || ' UNION ALL ' || v_clob6;
  
    v_clob8 := q'[SELECT * 
  FROM TMP3]' || ' UNION ALL ' ||
               q'[SELECT * FROM rl3 WHERE rl3.���� = ]' || '''' ||
               i.table_name || '''' || ' UNION ALL ' || v_clob8;
  
  /*  dbms_output.put_line('----------������ṹ----------');             
          dbms_output.put_line(v_clob1 || substr(v_clob2,1,length(v_clob2)-length(' UNION ALL '))||';');
          dbms_output.put_line('----------Լ������----------'); 
          dbms_output.put_line(v_clob3 || substr(v_clob4,1,length(v_clob4)-length(' UNION ALL '))||';');
          dbms_output.put_line('----------��������----------'); 
          dbms_output.put_line(v_clob5 || substr(v_clob6,1,length(v_clob6)-length(' UNION ALL '))||';');
          dbms_output.put_line('----------������----------'); 
          dbms_output.put_line(v_clob7 || substr(v_clob8,1,length(v_clob6)-length(' UNION ALL '))||';');    
          
          v_clob2 := '';
          v_clob4 := '';
          v_clob6 := '';
          v_clob8 := '';*/
  
  END LOOP;
  dbms_output.put_line('----------������ṹ----------');
  dbms_output.put_line(v_clob1 ||
                       substr( v_clob2,
                              1,
                              length(v_clob2) - length(' UNION ALL ')) || ';');
  dbms_output.put_line('----------Լ������----------');
  dbms_output.put_line(v_clob3 ||
                       substr(v_clob4,
                              1,
                              length(v_clob4) - length(' UNION ALL ')) || ';');
  dbms_output.put_line('----------��������----------');
  dbms_output.put_line(v_clob5 ||
                       substr(v_clob6,
                              1,
                              length(v_clob6) - length(' UNION ALL ')) || ';');
  dbms_output.put_line('----------������----------');
  dbms_output.put_line(v_clob7 ||
                       substr(v_clob8,
                              1,
                              length(v_clob6) - length(' UNION ALL ')) || ';');

END;
