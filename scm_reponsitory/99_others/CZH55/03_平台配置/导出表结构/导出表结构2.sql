--���
SELECT table_name FROM all_tables WHERE owner = 'SCMDATA';
SELECT REPLACE(REPLACE('SCMDATA.SYS_GROUP_ROLE,SCMDATA.SYS_GROUP_SECURITY,SCMDATA.SYS_GROUP_DICT,SCMDATA.SYS_USER,SCMDATA.SYS_GROUP_USER_ROLE,SCMDATA.SYS_GROUP_ROLE_SECURITY',
                       'SCMDATA.',
                       ''''),
               ',',
               ''',') || ''''
  FROM dual;


--1.������ṹ
SELECT t1.table_name   AS "������",
       t3.comments     AS "��˵��",
       t1.column_name  AS "�ֶ�����",
       t1.data_type    AS "��������",
       t1.data_length  AS "����",
       t1.nullable     AS "�Ƿ�Ϊ��",
       t2.comments     AS "�ֶ�˵��",
       t1.data_default AS "Ĭ��ֵ"
  FROM cols t1
  LEFT JOIN user_col_comments t2
    ON t1.table_name = t2.table_name
   AND t1.column_name = t2.column_name
  LEFT JOIN user_tab_comments t3
    ON t1.table_name = t3.table_name
  LEFT JOIN user_objects t4
    ON t1.table_name = t4.object_name
 WHERE NOT EXISTS (SELECT t4.object_name
          FROM user_objects t4
         WHERE t4.object_type = 'TABLE'
           AND t4.temporary = 'Y'
           AND t4.object_name = t1.table_name)
   AND t1.table_name = upper('sys_company_user')
 ORDER BY t1.table_name, t1.column_id;
 
--2.�����
SELECT t.owner AS "ӵ����",
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
 WHERE t.table_name = upper('sys_company_user')
   AND (t.constraint_type IN ('P', 'R'));

--3.����
SELECT user_indexes.table_owner     AS "ӵ����",
       user_ind_columns.table_name  AS "����",
       user_ind_columns.index_name  AS "��������",
       user_indexes.index_type      AS "��������",
       user_indexes.uniqueness      AS "����Ψһ��",
       user_ind_columns.column_name AS "������"
  FROM user_ind_columns, user_indexes
 WHERE user_ind_columns.index_name = user_indexes.index_name
   AND user_ind_columns.table_name = upper('sys_company_user');
--4.������

SELECT trigger_name
  FROM all_triggers
 WHERE table_name = upper('sys_company_user');

SELECT text
  FROM all_source
 WHERE TYPE = 'TRIGGER'
   AND NAME = (SELECT trigger_name
                 FROM all_triggers
                WHERE table_name = upper('sys_company_user'));
