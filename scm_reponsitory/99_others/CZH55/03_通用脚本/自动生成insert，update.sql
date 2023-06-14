--ÐÂÔö
SELECT 'INSERT INTO ' || listagg(DISTINCT(t.table_name)) || ' (' ||
       rtrim(listagg(t.column_name || ',', ''), ',') || ')' || ' VALUES( ' ||
       rtrim(listagg('p_' || t.column_name || ',', ''), ',') || ' );'
  FROM user_tab_columns t
 WHERE t.table_name = upper('T_SUPPLIER_INFO');
--ÐÞ¸Ä
SELECT 'UPDATE ' || listagg(DISTINCT(t.table_name)) ||
       rtrim(listagg(' SET ' || t.column_name || ' = ' || ' p_' ||
                     t.column_name || ',',
                     ''),
             ',') || ' WHERE      ;'
  FROM user_tab_columns t
 WHERE t.table_name = upper('T_SUPPLIER_INFO');
