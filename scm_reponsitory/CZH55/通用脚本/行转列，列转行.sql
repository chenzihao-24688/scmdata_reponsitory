WITH temp AS
 (SELECT '四川省' nation, '成都市' city, '第一' ranking
    FROM dual
  UNION ALL
  SELECT '四川省' nation, '绵阳市' city, '第二' ranking
    FROM dual
  UNION ALL
  SELECT '四川省' nation, '德阳市' city, '第三' ranking
    FROM dual
  UNION ALL
  SELECT '四川省' nation, '宜宾市' city, '第四' ranking
    FROM dual
  UNION ALL
  SELECT '湖北省' nation, '武汉市' city, '第一' ranking
    FROM dual
  UNION ALL
  SELECT '湖北省' nation, '宜昌市' city, '第二' ranking
    FROM dual
  UNION ALL
  SELECT '湖北省' nation, '襄阳市' city, '第三' ranking
    FROM dual)

--select * from temp;

--说明：pivot（聚合函数 for 列名 in（类型）），其中 in(‘’) 中可以指定别名，in中还可以指定子查询，比如 select distinct ranking from temp 以xml格式输出
--1.行转列 选去ranking字段为行，以城市排名输出city
/*SELECT *
  FROM (SELECT nation, city, ranking FROM temp)
pivot (MAX(city) FOR ranking IN('第一' AS 第一,
                           '第二' AS 第二,
                           '第三' AS 第三,
                           '第四' AS 第四));*/
--1.1 xml格式行转列输出                          
/*SELECT *
  FROM (SELECT nation, city, ranking FROM temp)
pivot xml(MAX(city)
   FOR ranking IN (SELECT DISTINCT ranking FROM temp));*/

--2.使用聚合函数，结合decode 行转列
--说明：decode的用法：decode(条件,值1,返回值1,值2,返回值2,...值n,返回值n,缺省值)

SELECT t.nation,
       MAX(decode(t.ranking, '第一', t.city, '')) AS 第一,
       MAX(decode(t.ranking, '第二', t.city, '')) AS 第二,
       MAX(decode(t.ranking, '第三', t.city, '')) AS 第三,
       MAX(decode(t.ranking, '第四', t.city, '')) AS 第四
  FROM temp t
 GROUP BY t.nation;

--3.使用聚合函数，结合case..when

WITH temp_score AS
 (SELECT '1' grade_id, '语文' course, '98' score
    FROM dual
  UNION ALL
  SELECT '1' grade_id, '数学' course, '88' score
    FROM dual
  UNION ALL
  SELECT '1' grade_id, '语文' course, '94' score
    FROM dual
  UNION ALL
  SELECT '2' grade_id, '数学' course, '70' score
    FROM dual
  UNION ALL
  SELECT '2' grade_id, '数学' course, '88' score
    FROM dual
  UNION ALL
  SELECT '2' grade_id, '英语' course, '94' score
    FROM dual
  UNION ALL
  SELECT '3' grade_id, '语文' course, '80' score
    FROM dual
  UNION ALL
  SELECT '4' grade_id, '数学' course, '66' score
    FROM dual
  UNION ALL
  SELECT '4' grade_id, '数学' course, '99' score
    FROM dual
  UNION ALL
  SELECT '5' grade_id, '语文' course, '77' score
    FROM dual
  UNION ALL
  SELECT '6' grade_id, '数学' course, '88' score
    FROM dual
  UNION ALL
  SELECT '7' grade_id, '英语' course, '94' score
    FROM dual)
SELECT CASE
         WHEN t.grade_id = '1' THEN
          '一年级'
         WHEN t.grade_id = '2' THEN
          '二年级'
         WHEN t.grade_id = '3' THEN
          '三年级'
         WHEN t.grade_id = '4' THEN
          '四年级'
         WHEN t.grade_id = '5' THEN
          '五年级'
         WHEN t.grade_id = '6' THEN
          '六年级'
         WHEN t.grade_id = '7' THEN
          '七年级'
         ELSE
          NULL
       END grade,
       MAX(CASE
             WHEN t.course = '语文' THEN
              t.score
           END) 语文,
       MAX(CASE
             WHEN t.course = '数学' THEN
              t.score
           END) 数学,
       MAX(CASE
             WHEN t.course = '英语' THEN
              t.score
           END) 英语
  FROM temp_score t
 GROUP BY CASE
            WHEN t.grade_id = '1' THEN
             '一年级'
            WHEN t.grade_id = '2' THEN
             '二年级'
            WHEN t.grade_id = '3' THEN
             '三年级'
            WHEN t.grade_id = '4' THEN
             '四年级'
            WHEN t.grade_id = '5' THEN
             '五年级'
            WHEN t.grade_id = '6' THEN
             '六年级'
            WHEN t.grade_id = '7' THEN
             '七年级'
            ELSE
             NULL
          END;

--2.列转行
--说明：unpivot（自定义列名/*列的值*/ for 自定义列名/*列名*/ in（列名））
WITH temp AS
 (SELECT '四川省' nation,
         '成都市' 第一,
         '绵阳市' 第二,
         '德阳市' 第三,
         '宜宾市' 第四
    FROM dual
  UNION ALL
  SELECT '湖北省' nation,
         '武汉市' 第一,
         '宜昌市' 第二,
         '襄阳市' 第三,
         '' 第四
    FROM dual)
--SELECT * FROM temp WHERE 1 = 2;

SELECT * FROM temp unpivot(city FOR ranking IN(第一, 第二, 第三，第四));
