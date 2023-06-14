SELECT t1.table_name||'-'||t3.comments AS "表名称-表说明",
       t1.column_name AS "字段名称",
       t1.data_type || '(' || t1.data_length || ')' AS "数据类型",
       t1.nullable AS "是否为空",
       t2.comments AS "字段说明",
       t1.data_default "默认值"
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
   AND t1.table_name = 'T_PRODUCTION_PROGRESS' --这里注意哦换成自己要查的那个表的表名，如果去掉这句话会查出该数据库所有的表结构
 ORDER BY t1.table_name, t1.column_id;
--以上所查的列如果不符合自己的要求 可以通过自己更改sql语句来获得想要查询的列，想要的属性上面几张系统表里都有,自己写也很简单
