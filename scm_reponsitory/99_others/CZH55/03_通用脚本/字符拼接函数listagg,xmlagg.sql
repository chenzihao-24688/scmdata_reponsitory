
--1.wm_concat 返回类型 string
-- 此函数慎用，在Oracle12G中不支持此函数，如果遇到项目的数据库版本升级，会报出标识符无效的错。
/*  SELECT wm_concat(t.name)
  INTO v_wm_concat_str
  FROM nbw.czh_test t
 GROUP BY t.id1
HAVING t.id1 < 3;
dbms_output.put_line(v_wm_concat_str);*/

--2.listagg 返回类型 string
--有长度限制，拼接的字符串超过4000时会报错。
SELECT listagg(t.name, ',') within GROUP(ORDER BY 1)
  FROM nbw.czh_test t
 WHERE t.id1 < 3
--GROUP BY t.id1; 分组拼接

--3.xmlagg  返回类型clob
--3.1 存在问题 结尾保留逗号
  SELECT xmlagg(xmlparse(content t.name || ',' wellformed) ORDER BY 1).getclobval() t_name
          FROM nbw.czh_test t
         WHERE t.id1 < 3
        --group by t.id1;--分组拼接
        
--3.2 结合rtrim函数一起使用，去掉末尾多余的“，”

  SELECT rtrim(xmlagg(xmlparse(content t.name || ',' wellformed) ORDER BY 1).getclobval(),',') t_name
          FROM nbw.czh_test t
         WHERE t.id1 < 3
        --group by t.id1;--分组拼接
