--查表
SELECT table_name FROM all_tables WHERE owner = 'SCMDATA';
SELECT REPLACE(REPLACE('SCMDATA.SYS_GROUP_ROLE,SCMDATA.SYS_GROUP_SECURITY,SCMDATA.SYS_GROUP_DICT,SCMDATA.SYS_USER,SCMDATA.SYS_GROUP_USER_ROLE,SCMDATA.SYS_GROUP_ROLE_SECURITY',
                       'SCMDATA.',
                       ''''),
               ',',
               ''',') || ''''
  FROM dual;


--1.基本表结构
SELECT t1.table_name   AS "表名称",
       t3.comments     AS "表说明",
       t1.column_name  AS "字段名称",
       t1.data_type    AS "数据类型",
       t1.data_length  AS "长度",
       t1.nullable     AS "是否为空",
       t2.comments     AS "字段说明",
       t1.data_default AS "默认值"
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
 
--2.主外键
SELECT t.owner AS "拥有者",
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
 WHERE t.table_name = upper('sys_company_user')
   AND (t.constraint_type IN ('P', 'R'));

--3.索引
SELECT user_indexes.table_owner     AS "拥有者",
       user_ind_columns.table_name  AS "表名",
       user_ind_columns.index_name  AS "索引名称",
       user_indexes.index_type      AS "索引类型",
       user_indexes.uniqueness      AS "索引唯一性",
       user_ind_columns.column_name AS "索引列"
  FROM user_ind_columns, user_indexes
 WHERE user_ind_columns.index_name = user_indexes.index_name
   AND user_ind_columns.table_name = upper('sys_company_user');
--4.触发器

SELECT trigger_name
  FROM all_triggers
 WHERE table_name = upper('sys_company_user');

SELECT text
  FROM all_source
 WHERE TYPE = 'TRIGGER'
   AND NAME = (SELECT trigger_name
                 FROM all_triggers
                WHERE table_name = upper('sys_company_user'));
