SELECT t1.table_name||'-'||t3.comments AS "������-��˵��",
       t1.column_name AS "�ֶ�����",
       t1.data_type || '(' || t1.data_length || ')' AS "��������",
       t1.nullable AS "�Ƿ�Ϊ��",
       t2.comments AS "�ֶ�˵��",
       t1.data_default "Ĭ��ֵ"
  FROM cols t1
  LEFT JOIN all_col_comments t2
    ON t1.table_name = t2.table_name
   AND t1.column_name = t2.column_name
  LEFT JOIN all_tab_comments t3
    ON t2.owner = t3.owner
   AND t2.table_name = t3.table_name
  LEFT JOIN user_objects t4
    ON t1.table_name = t4.object_name
 WHERE NOT EXISTS (SELECT t4.object_name
          FROM user_objects t4
         WHERE t4.object_type = 'TABLE'
           AND t4.temporary = 'Y'
           AND t4.object_name = t1.table_name)
   AND t3.owner = 'SCMDATA'
   AND t1.table_name = 'T_PRODUCTION_PROGRESS' --����ע��Ŷ�����Լ�Ҫ����Ǹ���ı��������ȥ����仰���������ݿ����еı�ṹ
 ORDER BY t1.table_name, t1.column_id;
--���������������������Լ���Ҫ�� ����ͨ���Լ�����sql����������Ҫ��ѯ���У���Ҫ���������漸��ϵͳ���ﶼ��,�Լ�дҲ�ܼ�
