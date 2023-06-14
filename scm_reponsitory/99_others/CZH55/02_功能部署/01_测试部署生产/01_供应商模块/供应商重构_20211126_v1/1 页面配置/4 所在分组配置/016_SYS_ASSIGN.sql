BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:='
{
DECLARE
  v_query_sql CLOB;
BEGIN
  IF instr(:is_nationwide,''1'') > 0 THEN 
    
    v_query_sql :=' || '''SELECT MAX(1) is_province_allcity,listagg(province, '''';'''') province,
       xmlagg(xmlparse(content group_area || '''';'''') ORDER BY provinceid).getclobval() group_area,
       listagg(province_id, '''';'''') province_id,
       listagg(city_id, '''';'''') city_id
  FROM (SELECT MAX(a.province) province,
               listagg(a.province || b.city, '''';'''') group_area,
               listagg(DISTINCT a.provinceid, '''';'''') province_id,
               listagg(b.cityno, '''';'''') city_id,
               a.provinceid
          FROM scmdata.dic_province a
         LEFT JOIN scmdata.dic_city b
            ON a.provinceid = b.provinceid
         GROUP BY a.provinceid)''' || ';
         
  ELSE
    v_query_sql := ' || '''SELECT MAX(0) is_province_allcity,'''' province,'''' province_id,
       '''' city_id,
       '''' group_area
  FROM DUAL''' || ';
  END IF;
  @strresult := v_query_sql;
END;
}';
  CV2 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_coop_162''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 1,q''[IS_NATIONWIDE]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_coop_162''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 1,''assign_a_coop_162'',q''[IS_NATIONWIDE]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

BEGIN
  DECLARE
    JUDGE_N NUMBER(4);
    EXE_SQL CLOB;
    VALS    CLOB;
  CV1 CLOB:='{DECLARE
  v_query_sql CLOB;
  v_province_id CLOB;
BEGIN
  IF instr(:is_province_allcity,''1'') > 0 THEN
  v_province_id := :province_id;
    v_query_sql := ' ||
        '''SELECT xmlagg(xmlparse(content group_area || '''';'''') ORDER BY provinceid).getclobval() group_area,
       listagg(province_id, '''';'''') province_id,
       listagg(city_id, '''';'''') city_id
  FROM (SELECT listagg(a.province || b.city, '''';'''') group_area,
               listagg(DISTINCT a.provinceid, '''';'''') province_id,
               listagg(b.cityno, '''';'''') city_id,
               a.provinceid
          FROM scmdata.dic_province a
          LEFT JOIN scmdata.dic_city b
            ON a.provinceid = b.provinceid
         GROUP BY a.provinceid)
 WHERE instr(''||v_province_id||'', provinceid) > 0''' || ';
  ELSE
  v_query_sql := SELECT '''' city_id,'''' group_area
  FROM DUAL' || ';
  END IF;

  @strresult := v_query_sql;
END;}';
  CV2 CLOB:=q'[]';

  BEGIN
    EXE_SQL := 'SELECT COUNT(1) FROM BW3.SYS_ASSIGN WHERE ELEMENT_ID = ''assign_a_coop_162_1''';
    EXECUTE IMMEDIATE EXE_SQL INTO JUDGE_N;
    IF JUDGE_N > 0 THEN
       EXE_SQL := 'UPDATE BW3.SYS_ASSIGN SET (ALL_DATA_FLAG,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) = (SELECT 1,q''[IS_PROVINCE_ALLCITY]'',0,q''[]'',:CV1,:CV2 FROM DUAL) WHERE ELEMENT_ID = ''assign_a_coop_162_1''';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     ELSE
       EXE_SQL := 'INSERT INTO BW3.SYS_ASSIGN (ALL_DATA_FLAG,ELEMENT_ID,FIELD_NAME,FORCE_FLAG,PORT_ID,ASSIGN_SQL,PORT_SQL) SELECT 1,''assign_a_coop_162_1'',q''[IS_PROVINCE_ALLCITY]'',0,q''[]'',:CV1,:CV2 FROM DUAL';
       WHILE REGEXP_COUNT(EXE_SQL,',,') > 0 LOOP
         EXE_SQL := REPLACE(EXE_SQL,',,',',NULL,');
       END LOOP;
       EXE_SQL := REPLACE(REPLACE(EXE_SQL,'SELECT ,','SELECT NULL,'),', FROM',',NULL FROM');
       EXECUTE IMMEDIATE EXE_SQL USING CV1,CV2;
     END IF;
  END;
END;
/

